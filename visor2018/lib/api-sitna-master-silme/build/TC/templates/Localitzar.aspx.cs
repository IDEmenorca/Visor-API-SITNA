using Silme.Sig.BDUtils;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace visor2018.lib.api_sitna_master_silme.build.TC.control
{
    public partial class Localitzar : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ClientScript.GetPostBackEventReference(this, string.Empty);

                postgis pgis = new postgis();
                pgis.ConnString = pgis.BD_ConnString(pgisConn.Servidor, pgisConn.Port, pgisConn.Usuari, pgisConn.Pwd, pgisConn.BD);

                DataSet ds = pgis.BD_Query("SELECT distinct(dstram), numtram, idtram FROM silme.or007cca_ccavalls order by numtram");

                ccavallsTrams.DataSource = ds;
                ccavallsTrams.DataTextField = "dstram";
                ccavallsTrams.DataValueField = "idtram";
                ccavallsTrams.DataBind();
            }
        }

        protected void actualitzaTram(object sender, EventArgs e)
        {
            postgis pgis = new postgis();
            pgis.ConnString = pgis.BD_ConnString(pgisConn.Servidor, pgisConn.Port, pgisConn.Usuari, pgisConn.Pwd, pgisConn.BD);

            string idruta = ccavallsTrams.SelectedValue;
        
            DataSet ds = pgis.BD_Query("SELECT idfita, idtram, numfita, idruta, idtipus, dstipus FROM silme.or007cca_senyalitzacio where idruta = '" + idruta + "' order by numfita");

            ccavallsFites.DataSource = ds;
            ccavallsFites.DataTextField = "idfita";
            ccavallsFites.DataValueField = "idfita";
            ccavallsFites.DataBind();
        }
    }
}