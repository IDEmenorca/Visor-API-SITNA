using Silme.Sig.BDUtils;
using System;
using System.Configuration;
using System.Data.SqlClient;
using log4net;

namespace visor2018
{
    public partial class _defaultNoBD : System.Web.UI.Page
    {
        string projecte;
        public string serveis = "";
        public string grups = "";
        public string eines = "";
        public string mapaDeFons = "";
        public ILog IDELogger;

        public string clickCoords;
        protected void Page_Load(object sender, EventArgs e)
        {
            IDELogger = LogManager.GetLogger("IDELogger");
            IDELogger.Info($"Page_Load -- IsMobileDevice: {Request.Browser.IsMobileDevice}");
            IDELogger.Info($"User agent: {Request.UserAgent}");
            try
            {
                //carregaProjecte();
            }
            catch (Exception ex)
            {
                IDELogger.Info("Page_Load ERROR");
                IDELogger.Error(ex.ToString());
            }
            IDELogger.Info("Page_Load end");
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
                //pgis.BD_Open(pgis.ConnString);
                mapaDeFons = support.carregaMapesDeFons(pgis, projecte);
                serveis = support.carregaServeis(pgis, projecte);
                grups = support.carregaGrupsServeis(pgis, projecte);
                eines = support.carregaEines(pgis, projecte);


                //pgis.BD_Close();

                clickCoords = Request.QueryString["clickCoords"];
                if (clickCoords == null) clickCoords = "0";
            }
            catch (Exception err)
            {
                IDELogger.Info("carregaProjecte ERROR");
                IDELogger.Error(err.Message.ToString());
            }
        }


    }
}