using Silme.Sig.BDUtils;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace visor2018.layouts.silme
{
    public partial class peticions : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        /*Camí de cavalls*/
        [WebMethod]
        public static string carregaTrams()
        {
            string dades = "";
            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("carto");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT distinct(dstram), numtram, idtram FROM silme.or007cca_ccavalls order by numtram");
                DataTable dt = ds.Tables[0];

                if (dt.Rows.Count != 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        dades += row["idtram"].ToString() + "*" + row["dstram"].ToString() + ";";
                    }
                    dades = dades.Substring(0, dades.Length - 1);
                }
            }
            catch (Exception ex)
            {
                string err = ex.ToString();
                err = ex.Message.ToString();
            }

            return dades;
        }

        [WebMethod]
        public static string actualitzaTram(string tram)
        {
            string dades = "";
            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("carto");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT idfita, numfita FROM silme.or007cca_senyalitzacio where idruta = '" + tram + "' order by numfita");
                DataTable dt = ds.Tables[0];

                if (dt.Rows.Count != 0) { 
                    foreach (DataRow row in dt.Rows)
                    {
                        dades += row["idfita"].ToString() + ";";
                    }
                    dades = dades.Substring(0, dades.Length - 1);
                }
            } catch (Exception ex)
            {

            }

            return dades;
        }

        [WebMethod]
        public static string tramExtent(string tram)
        {
            string dades = "";
            support.pGisConn pGisConn;
            pGisConn = support.obteParametresConnexio("carto");
            postgis pgis = new postgis();
            pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

            //string idruta = ccavallsTrams.SelectedValue;

            //DataSet ds = pgis.BD_Query("select st_extent(the_geom) from silme.or007cca_ccavalls where idtram = '" + tram + "'");
            DataSet ds = pgis.BD_Query("select st_extent(st_transform(the_geom, 3857)) from silme.or007cca_ccavalls where idtram = '" + tram + "'");

            DataTable dt = ds.Tables[0];

            dades += dt.Rows[0]["st_extent"].ToString();

            int[] extent = tools.ProcesarBOX(dades);

            string ret = "";

            foreach (int coor in extent)
            {
                ret += coor.ToString() + ";";
            }
            ret = ret.Substring(0, ret.Length - 1);

            return ret;
        }

        [WebMethod]
        public static string fitaExtent(string fita)
        {
            string dades = "";
            support.pGisConn pGisConn;
            pGisConn = support.obteParametresConnexio("carto");
            postgis pgis = new postgis();
            pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

            DataSet ds = pgis.BD_Query("SELECT st_extent(st_transform(the_geom, 3857)) FROM silme.or007cca_senyalitzacio where idfita = '" + fita + "'");

            DataTable dt = ds.Tables[0];

            dades += dt.Rows[0]["st_extent"].ToString();

            int[] extent = tools.ProcesarBOX(dades);

            string ret = "";

            foreach (int coor in extent)
            {
                ret += coor.ToString() + ";";
            }
            ret = ret.Substring(0, ret.Length - 1);

            return ret;
        }
        /*End camí de cavalls*/
        /*Punts quilomètrics*/
        [WebMethod]
        public static string carregaVies()
        {
            string dades = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("carto");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT distinct on (idxarxa) idxarxa FROM silme.re007rus_puntsquilometrics where idxarxa != '' order by idxarxa");
                DataTable dt = ds.Tables[0];

                if (dt.Rows.Count != 0 && dt.Rows.Count <= 1000)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        dades += row["idxarxa"].ToString() + "*" + row["idxarxa"].ToString() + ";";
                    }
                    dades = dades.Substring(0, dades.Length - 1);
                }
            }
            catch
            {

            }

            return dades;
        }

        [WebMethod]
        public static string actualitzaPk(string via)
        {
            string dades = "";

            if (via != "")
            {
                try
                {
                    support.pGisConn pGisConn;
                    pGisConn = support.obteParametresConnexio("carto");
                    postgis pgis = new postgis();
                    pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                    DataSet ds = pgis.BD_Query("SELECT etiqueta, numpk FROM silme.re007rus_puntsquilometrics where idxarxa = '" + via + "' order by numpk");
                    DataTable dt = ds.Tables[0];

                    if (dt.Rows.Count != 0)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            dades += row["etiqueta"].ToString() + "*" + row["numpk"].ToString() + ";";
                        }
                        dades = dades.Substring(0, dades.Length - 1);
                    }
                }
                catch
                {

                }
            }

            return dades;
        }

        [WebMethod]
        public static string viaExtent(string via)
        {
            string dades = "";
            string ret = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("carto");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT st_extent(st_transform(the_geom, 3857)) FROM silme.re007rus_puntsquilometrics where idxarxa = '" + via + "'");
                DataTable dt = ds.Tables[0];

                dades += dt.Rows[0]["st_extent"].ToString();
                int[] extent = tools.ProcesarBOX(dades);

                foreach (int coor in extent)
                {
                    ret += coor.ToString() + ";";
                }
                ret = ret.Substring(0, ret.Length - 1);
            }
            catch (Exception ex)
            {

            }

            return ret;
        }

        [WebMethod]
        public static string pkExtent(string pk)
        {
            string dades = "";
            string ret = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("carto");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT st_extent(st_transform(the_geom, 3857)) FROM silme.re007rus_puntsquilometrics where etiqueta = '" + pk + "'");
                DataTable dt = ds.Tables[0];

                dades += dt.Rows[0]["st_extent"].ToString();
                int[] extent = tools.ProcesarBOX(dades);

                foreach (int coor in extent)
                {
                    ret += coor.ToString() + ";";
                }
                ret = ret.Substring(0, ret.Length - 1);
            }
            catch (Exception ex)
            {

            }

            return ret;
        }
        /*End punts quilomètrics*/
        /*Guia de carrers*/
        [WebMethod]
        public static string carregaMunicipi()
        {
            string dades = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("app_guiacarrers");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT municipi, nom_muni FROM sit.sit_dte50v3_111a order by nom_muni");
                DataTable dt = ds.Tables[0];

                if (dt.Rows.Count != 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        dades += row["municipi"].ToString() + "*" + row["nom_muni"].ToString() + ";";
                    }
                    dades = dades.Substring(0, dades.Length - 1);
                }
            }
            catch
            {

            }

            return dades;
        }

        [WebMethod]
        public static string actualitzaNuclis(string mun)
        {
            string dades = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("app_guiacarrers");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT nom_upob_ine, upob_ine7 FROM sit.sit_dte50v1_113x where mun_ine = '" + mun + "' order by nom_upob_ine");
                DataTable dt = ds.Tables[0];
                if (dt.Rows.Count != 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        dades += row["upob_ine7"].ToString() + "*" + row["nom_upob_ine"].ToString() + ";";
                    }
                    dades = dades.Substring(0, dades.Length - 1);
                }

            }
            catch
            {

            }

            return dades;
        }

        [WebMethod]
        public static string actualitzaCarrers(string nuc)
        {
            string dades = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("app_guiacarrers");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT cod_via, nom_via, nexe_via, tip_via FROM sit.sit_cae1mv1_112x1 where cod_unit_p = '" + nuc + "' order by nom_via");
                DataTable dt = ds.Tables[0];

                if (dt.Rows.Count != 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        string nom_complert = "";

                        if (row["nexe_via"].ToString() == "")
                        {
                            nom_complert = row["nom_via"].ToString() + " (" + row["tip_via"].ToString() + ")";
                        }
                        else
                        {
                            nom_complert = row["nom_via"].ToString() + ", " + row["nexe_via"].ToString() + " (" + row["tip_via"].ToString() + ")";
                        }

                        dades += row["cod_via"].ToString() + "*" + nom_complert + ";";
                    }
                    dades = dades.Substring(0, dades.Length - 1);
                }

            }
            catch
            {

            }

            return dades;
        }

        [WebMethod]
        public static string actualitzaPortals(string car, string nuc)
        {
            string dades = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("app_guiacarrers");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT cod_adr_via, cod_via, portal_fisic FROM sit.sit_cae1mv1_122p where cod_via = '" + car + "' and cod_unit_p = '" + nuc + "' order by portal_fisic");
                //DataSet ds = pgis.BD_Query("SELECT distinct on (nomportal) idportal, nomportal, idcarrer FROM silme.re007urb_portals where idcarrer = '" + car + "' and cod_unit_p = '" + nuc + "' order by nomportal asc");
                DataTable dt = ds.Tables[0];

                if (dt.Rows.Count != 0)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        dades += row["cod_adr_via"].ToString() + "," + row["cod_via"].ToString() + "*" + row["portal_fisic"].ToString() + ";";
                    }
                    dades = dades.Substring(0, dades.Length - 1);
                }
            }
            catch
            {

            }

            return dades;
        }

        [WebMethod]
        public static string municipiExtent(string mun)
        {
            string dades = "";
            string id = "";
            string ret = "";

            try
            {
                if (mun == "07067") mun = "07902";
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("carto");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("select st_extent(st_transform(the_geom, 3857)), idmun from silme.re007rus_municipis where idmun = '" + mun + "' group by idmun");
                DataTable dt = ds.Tables[0];

                dades += dt.Rows[0]["st_extent"].ToString();
                id = dt.Rows[0]["idmun"].ToString();
                int[] extent = tools.ProcesarBOX(dades);

                ret = "{\"coords\": {\"x_min\": \"" + extent[0] + "\",\"y_min\": \"" + extent[1] + "\",\"x_max\": \"" + extent[2] + "\",\"y_max\": \"" + extent[3] + "\"},\"id\": \"" + id + "\"}";

                /*foreach (int coor in extent)
                {
                    ret += coor.ToString() + ";";
                }
                ret = ret.Substring(0, ret.Length - 1);
                */
            }
            catch (Exception ex)
            {

            }

            return ret;
        }

        [WebMethod]
        public static string nucliExtent(string nuc)
        {
            string dades = "";
            string id = "";
            string ret = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("carto");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("select st_extent(st_transform(the_geom, 3857)), idnucli from silme.re007rus_nuclis where idnucli = '" + nuc + "' group by idnucli");
                DataTable dt = ds.Tables[0];

                dades += dt.Rows[0]["st_extent"].ToString();
                id = dt.Rows[0]["idnucli"].ToString();
                int[] extent = tools.ProcesarBOX(dades);

                ret = "{\"coords\": {\"x_min\": \"" + extent[0] + "\",\"y_min\": \"" + extent[1] + "\",\"x_max\": \"" + extent[2] + "\",\"y_max\": \"" + extent[3] + "\"},\"id\": \"" + id + "\"}";

                /*foreach (int coor in extent)
                {
                    ret += coor.ToString() + ";";
                }
                ret = ret.Substring(0, ret.Length - 1);
                */
            }
            catch (Exception ex)
            {

            }

            return ret;
        }

        [WebMethod]
        public static string carrerExtent(string car, string mun)
        {
            string dades = "";
            string id = "";
            string ret = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("app_guiacarrers");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT st_extent(st_transform(geom, 3857)), (cod_via || '_' || cod_muni) as cod_carrer FROM sit.sit_cae1mv1_112l where cod_via = '" + car + "' and cod_muni = '" + mun + "' group by cod_via, cod_muni");
                DataTable dt = ds.Tables[0];

                dades += dt.Rows[0]["st_extent"].ToString();
                id = dt.Rows[0]["cod_carrer"].ToString();
                int[] extent = tools.ProcesarBOX(dades);

                ret = "{\"coords\": {\"x_min\": \"" + extent[0] + "\",\"y_min\": \"" + extent[1] + "\",\"x_max\": \"" + extent[2] + "\",\"y_max\": \"" + extent[3] + "\"},\"id\": \"" + id + "\"}";

                /*foreach (int coor in extent)
                {
                    ret += coor.ToString() + ";";
                }
                ret = ret.Substring(0, ret.Length - 1);
                */
            }
            catch (Exception ex)
            {

            }

            return ret;
        }

        [WebMethod]
        public static string portalExtent(string por, string mun)
        {
            string dades = "";
            string id = "";
            string ret = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("app_guiacarrers");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                string[] split = por.Split(',');

                DataSet ds = pgis.BD_Query("select st_extent(st_transform(sit_cae1mv1_122p.geom, 3857)), municipi, nom_muni, nom_upob_ine, tip_via, nexe_via, nom_via, portal_fisic, upob_ine7, (sit_cae1mv1_112x1.cod_via || '_' || municipi) as cod_via, (sit_cae1mv1_122p.cod_adr_via || '_' || municipi) as cod_adr_via from sit.sit_cae1mv1_122p inner join sit.sit_cae1mv1_112x1 on sit_cae1mv1_112x1.cod_via = sit_cae1mv1_122p.cod_via and sit_cae1mv1_112x1.cod_muni = sit_cae1mv1_122p.cod_muni inner join sit.sit_dte50v1_113x on sit_dte50v1_113x.upob_ine7 = sit_cae1mv1_122p.cod_unit_p inner join sit.sit_dte50v3_111a on sit_dte50v3_111a.municipi = sit_cae1mv1_122p.cod_muni where sit_cae1mv1_122p.cod_via = '" + split[1] + "' and sit_cae1mv1_122p.cod_adr_via ='"+ split[0] + "' and sit_cae1mv1_122p.cod_muni = '" + mun + "' group by municipi, nom_upob_ine, tip_via, nexe_via, nom_via, portal_fisic, upob_ine7, sit_cae1mv1_112x1.cod_via, sit_cae1mv1_122p.cod_adr_via");
                DataTable dt = ds.Tables[0];

                dades += dt.Rows[0]["st_extent"].ToString();
                id = dt.Rows[0]["municipi"].ToString();         //07032#MaÃ³#MaÃ³#C. BORJA MOLL#51#9_07032#155_07032#10636_07032  
                id += "#" + dt.Rows[0]["nom_muni"].ToString();  //07032#MaÃ³#Canutells (Es)#C. DES PINARET#20(portal_fisic)#4_07032(cod_unit_p)#220_07032(cod_via)#460_07032(cod_adr_via)
                id += "#" + dt.Rows[0]["nom_upob_ine"].ToString();
                id += "#" + dt.Rows[0]["tip_via"].ToString();
                id += " " + dt.Rows[0]["nexe_via"].ToString();
                id += " " + dt.Rows[0]["nom_via"].ToString();
                id += "#" + dt.Rows[0]["portal_fisic"].ToString();
                id += "#" + dt.Rows[0]["upob_ine7"].ToString();
                id += "#" + dt.Rows[0]["cod_via"].ToString();
                id += "#" + dt.Rows[0]["cod_adr_via"].ToString();

                int[] extent = tools.ProcesarBOX(dades);

                ret = "{\"coords\": {\"x_min\": \"" + extent[0] + "\",\"y_min\": \"" + extent[1] + "\",\"x_max\": \"" + extent[2] + "\",\"y_max\": \"" + extent[3] + "\"},\"id\": \"" + id + "\"}";

                /*
                foreach (int coor in extent)
                {
                    ret += coor.ToString() + ";";
                }
                ret = ret.Substring(0, ret.Length - 1);
                */
            }
            catch (Exception ex)
            {

            }

            return ret;
        }
        /*End guia de carrers*/
        /*Vedats de caça*/
        [WebMethod]
        public static string carregaVedats(string vedats)
        {
            string dades = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("carto");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT gid, matricula, nom, refcat FROM silme.am007cac_vedats where matricula like '%" + vedats + "%' or nom like '%" + vedats + "%' order by matricula desc");
                DataTable dt = ds.Tables[0];

                if (dt.Rows.Count != 0 && dt.Rows.Count <= 1000)
                {
                    foreach (DataRow row in dt.Rows)
                    {
                        dades += row["gid"].ToString() + "*matricula:" + row["matricula"].ToString() + " - refcat:" + row["refcat"].ToString() + " (" + row["nom"].ToString() + ");";
                        //dades += row["matricula"].ToString() + "*" + "matricula:" + row["matricula"].ToString() + " - refcat:" + row["refcat"].ToString() + " (" + row["nom"].ToString() + ");";
                    }
                    dades = dades.Substring(0, dades.Length - 1);
                }
            }
            catch
            {

            }

            return dades;
        }

        [WebMethod]
        public static string vedatCoordsExtent(string ved)
        {
            string dades = "";
            string ret = "";

            try
            {
                support.pGisConn pGisConn;
                pGisConn = support.obteParametresConnexio("carto");
                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pGisConn.Servidor, pGisConn.Port, pGisConn.Usuari, pGisConn.Pwd, pGisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT st_x(st_centroid(st_transform(the_geom, 3857))), st_y(st_centroid(st_transform(the_geom, 3857))), st_extent(st_transform(the_geom, 3857)) FROM silme.am007cac_vedats where gid = '" + ved + "' group by the_geom");
                DataTable dt = ds.Tables[0];

                ret += dt.Rows[0]["st_x"] + ";" + dt.Rows[0]["st_y"] + "*";
                dades += dt.Rows[0]["st_extent"].ToString();
                int[] extent = tools.ProcesarBOX(dades);

                foreach (int coor in extent)
                {
                    ret += coor.ToString() + ";";
                }
                ret = ret.Substring(0, ret.Length - 1);
            }
            catch (Exception ex)
            {

            }

            return ret;
        }
        /*End vedats de caça*/
    }
}