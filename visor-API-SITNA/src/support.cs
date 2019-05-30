using log4net;
using Silme.Sig.BDUtils;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;

namespace visor2018
{
    public static class support
    {
        public static ILog IDELogger = LogManager.GetLogger("IDELogger");
        public class ProjecteGrupServei
        {
            string id_projecte;
            string id_servei;
            string id_grup;
            string servei_title;
            string servei_type;
            string servei_url;
            string grup_title;

            public ProjecteGrupServei(string id_projecte, string id_servei, string id_grup, string servei_title, string servei_type, string servei_url, string grup_title)
            {
                this.id_projecte = id_projecte;
                this.id_servei = id_servei;
                this.id_grup = id_grup;
                this.servei_title = servei_title;
                this.servei_type = servei_type;
                this.servei_url = servei_url;
                this.grup_title = grup_title;
            }

            public string crearServeiJson()
            {
                string output = "";

                output += "{id: \"" + this.id_servei + "\", title: \"" + this.servei_title + "\", hideTitle: false, type: ";
                output += this.servei_type + ", url: \"" + this.servei_url + "\", hideTree: false, parentGroupNode: \"" + id_grup + "\"}";

                return output;
            }
        }

        public class Grup
        {
            string id;
            string title;

            public Grup(string id, string title)
            {
                this.id = id;
                this.title = title;
            }

            public string crearGrupJson()
            {
                string output = "";

                output += "{id: \"" + this.id + "\", title: \"" + this.title + "\"}";

                return output;
            }
        }

        public class Eina
        {
            string id;
            string div;

            public Eina(string id, string div)
            {
                this.id = id;
                this.div = div;
            }

            public string crearEinaJson()
            {
                string output = "";

                output += "SITNA.Cfg.controls." + this.id + " = {div: \"" + this.div + "\"};";

                return output;
            }
        }

        public class MapaDeFons
        {
            string id;
            string url;
            string layerNames;
            string type;
            string title;
            string matrixSet;
            string thumbnail;
            string format;

            public MapaDeFons(string id, string url, string layerNames, string type, string title, string format, string matrixSet, string thumbnail)
            {
                this.id = id;
                this.url = url;
                this.layerNames = layerNames;
                this.type = type;
                this.title = title;
                this.format = format;
                this.matrixSet = matrixSet;
                this.thumbnail = thumbnail;
            }

            public string creaMapaDeFonsJson()
            {
                string output = "";

                if (id == "osm" || id == "carto_dark" || id == "carto_light" || id == "carto_voyager" || id == "mapbox_satellite" || id == "mapbox_streets")
                {
                    output += "\"" + id + "\"";
                }
                else
                {
                    output += "{";
                    output += "id: \"" + id + "\",";
                    output += "url: \"" + url + "\",";
                    output += "layerNames: \"" + layerNames + "\",";
                    output += "type: \"" + type + "\",";
                    output += "title: \"" + title + "\",";
                    if (format != null && format != "")
                        output += "format: \"" + format + "\",";

                    output += "matrixSet: \"" + matrixSet + "\",";
                    output += "thumbnail: \"" + thumbnail + "\",";
                    output += "isBase: true";
                    output += "}";
                }

                return output;
            }
        }

        public class pGisConn
        {
            public string Servidor = "";
            public string Port = "";
            public string Usuari = "";
            public string Pwd = "";
            public string BD = "";
        }

        public static string carregaServeis(postgis pgis, string projecte)
        {
            string output = "";

            try
            {
                DataSet ds = pgis.BD_Query("SELECT id_projecte, id_servei, servei.id as idservei, id_grup, grup.id as idgrup, servei.title as servei_title, servei.type as servei_type, servei.url as servei_url, grup.title as grup_title FROM public.projecte_servei_grup join servei on servei.\"idServei\" = id_servei join grup on \"idGrup\" = id_grup where id_projecte = '" + projecte + "' and \"estaDisponible\" = true order by public.projecte_servei_grup.id");
                DataTable dt = ds.Tables[0];

                if (dt.Rows.Count != 0)
                {
                    List<ProjecteGrupServei> lst = new List<ProjecteGrupServei>();
                    foreach (DataRow row in dt.Rows)
                    {
                        lst.Add(new ProjecteGrupServei(row["id_projecte"].ToString(), row["idservei"].ToString(), row["idgrup"].ToString(), row["servei_title"].ToString(), row["servei_type"].ToString(), row["servei_url"].ToString(), row["grup_title"].ToString()));
                    }

                    foreach (ProjecteGrupServei proj in lst)
                    {
                        output += proj.crearServeiJson();
                        output += ",";
                    }

                    output = output.Substring(0, output.Length - 1);//Eliminam la coma del final
                }
            }
            catch (Exception ex)
            {
                IDELogger.Info("carregaServeis ERROR");
                IDELogger.Error(ex.Message.ToString());
            }

            return output;
        }

        public static string carregaGrupsServeis(postgis pgis, string projecte)
        {
            string output = "";

            try
            {
                DataSet ds = pgis.BD_Query("SELECT DISTINCT on (grup.id) grup.id, title FROM public.projecte_servei_grup join grup on grup.\"idGrup\" = id_grup where id_projecte = '" + projecte + "'");
                DataTable dt = ds.Tables[0];

                if (dt.Rows.Count != 0)
                {
                    List<Grup> lstgrp = new List<Grup>();
                    foreach (DataRow row in dt.Rows)
                    {
                        lstgrp.Add(new Grup(row["id"].ToString(), row["title"].ToString()));
                    }

                    foreach (Grup grp in lstgrp)
                    {
                        output += grp.crearGrupJson();
                        output += ",";
                    }

                    output = output.Substring(0, output.Length - 1);//Eliminam la coma del final
                }
            }
            catch (Exception ex)
            {
                IDELogger.Info("carregaGrupsServeis ERROR");
                IDELogger.Error(ex.Message.ToString());
            }

            return output;
        }

        public static string carregaEines(postgis pgis, string projecte)
        {
            string output = "";

            try
            {
                DataSet ds = pgis.BD_Query("SELECT * FROM public.projecte_eina join eina on eina.id = id_eina where id_projecte = '" + projecte + "'");
                DataTable dt = ds.Tables[0];

                if (dt.Rows.Count != 0)
                {
                    List<Eina> lsteina = new List<Eina>();
                    foreach (DataRow row in dt.Rows)
                    {
                        lsteina.Add(new Eina(row["nom_control"].ToString(), row["div"].ToString()));
                    }

                    foreach (Eina eina in lsteina)
                    {
                        output += eina.crearEinaJson();
                        output += "\r\n";
                    }

                    output = output.Substring(0, output.Length - 2);//Eliminam el \r\n del final
                }
            }
            catch (Exception ex)
            {
                IDELogger.Info("carregaEines ERROR");
                IDELogger.Error(ex.Message.ToString());
            }

            return output;
        }

        public static string carregaMapesDeFons(postgis pgis, string projecte)
        {
            string output = "";

            try
            {
                DataSet ds = pgis.BD_Query("SELECT * FROM public.projecte_mapa_de_fons join mapa_de_fons on mapa_de_fons.id = id_mapa_de_fons where id_projecte = '" + projecte + "'");
                DataTable dt = ds.Tables[0];

                if (dt.Rows.Count != 0)
                {
                    List<MapaDeFons> lstMapaFons = new List<MapaDeFons>();
                    foreach (DataRow row in dt.Rows)
                    {
                        lstMapaFons.Add(new MapaDeFons(row["nom"].ToString(), row["url"].ToString(), row["layerNames"].ToString(), row["type"].ToString(), row["title"].ToString(), row["format"].ToString(), row["matrixSet"].ToString(), row["thumbnail"].ToString()));
                    }

                    foreach (MapaDeFons mapaFons in lstMapaFons)
                    {
                        output += mapaFons.creaMapaDeFonsJson();
                        output += ",";
                    }

                    output = output.Substring(0, output.Length - 1);//Eliminam la coma del final
                }
            }
            catch (Exception ex)
            {
                IDELogger.Info("carregaMapesDeFons ERROR");
                IDELogger.Error(ex.Message.ToString());
            }

            if (output == "") //error o la consulta no ha tornat res
            {
                output += "'osm'";
            }

            return output;
        }

        public static pGisConn obteParametresConnexio(string nomConnexio)
        {
            pGisConn oPgis = new pGisConn();
            for (int i = 0; i < ConfigurationManager.ConnectionStrings.Count; i++)
            {
                string cs = ConfigurationManager.ConnectionStrings[i].ConnectionString;
                string[] dadesCs = cs.Split(';');
                if (ConfigurationManager.ConnectionStrings[i].Name.Contains(nomConnexio))
                {
                    oPgis.Servidor = dadesCs[0].Split('=')[1];
                    oPgis.Usuari = dadesCs[2].Split('=')[1];
                    oPgis.BD = dadesCs[1].Split('=')[1];
                    oPgis.Pwd = dadesCs[3].Split('=')[1];
                    oPgis.Port = dadesCs[4].Split('=')[1];
                }
            }

            return oPgis;
        }
    }
}