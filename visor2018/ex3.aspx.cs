using Silme.Sig.BDUtils;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace visor2018
{
    public partial class ex3 : System.Web.UI.Page
    {
        string projecte;
        public string serveis = "";
        public string grups = "";
        public string eines = "";
        public string mapaDeFons = "";
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                carregaProjecte();
            }
            catch (Exception ex)
            {
            }
        }

        public void carregaProjecte()
        {
            try
            {
                projecte = Request.QueryString["projecte"];
                if (projecte == null) projecte = "1";

                support.pGisConn oPgis;
                oPgis = support.obteParametresConnexio("app_visor");

                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(oPgis.Servidor, oPgis.Port, oPgis.Usuari, oPgis.Pwd, oPgis.BD);
                mapaDeFons = support.carregaMapesDeFons(pgis, projecte);
                serveis = support.carregaServeis(pgis, projecte);
                grups = support.carregaGrupsServeis(pgis, projecte);
                eines = support.carregaEines(pgis, projecte);
            }
            catch (Exception err)
            {
            }
        }
    }
}