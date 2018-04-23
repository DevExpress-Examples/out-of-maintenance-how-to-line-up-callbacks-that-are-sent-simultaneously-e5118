using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Threading;

public partial class Master_Detail_Two_Grids : System.Web.UI.Page 
{
   protected void Page_Load(object sender, EventArgs e) {
        string filterExpression1 = Convert.ToString(Session["FilterExpression1"]);
        if(filterExpression1 != string.Empty) {
            adsProducts1.FilterExpression = filterExpression1;
            detailGridView1.DataSource = adsProducts1;
            detailGridView1.DataSourceID = string.Empty;
            detailGridView1.DataBind();
        }  
       
       
       string filterExpression2 = Convert.ToString(Session["FilterExpression2"]);
        if(filterExpression1 != string.Empty) {
            adsProducts2.FilterExpression = filterExpression2;
            detailGridView2.DataSource = adsProducts2;
            detailGridView2.DataSourceID = string.Empty;
            detailGridView2.DataBind();
        }
    }
   protected void detailGridView1_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e) {
        Thread.Sleep(1000);

        object values = masterGrid1.GetRowValues(masterGrid1.FocusedRowIndex, new string[] { "CategoryID" });
        detailGridView1.DataSource = null;
        string filterExpression = "CategoryID='" + values.ToString() + "'";
        Session["FilterExpression1"] = filterExpression;
        adsProducts1.FilterExpression = filterExpression;
        detailGridView1.DataSource = adsProducts1;
        detailGridView1.PageIndex = 0;
        detailGridView1.DataBind();
    }

   protected void detailGridView2_CustomCallback(object sender, DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs e) {
        Thread.Sleep(1000);

        object values = masterGrid2.GetRowValues(masterGrid2.FocusedRowIndex, new string[] { "CategoryID" });
        detailGridView2.DataSource = null;
        string filterExpression = "CategoryID='" + values.ToString() + "'";
        Session["FilterExpression2"] = filterExpression;
        adsProducts2.FilterExpression = filterExpression;
        detailGridView2.DataSource = adsProducts2;
        detailGridView2.PageIndex = 0;
        detailGridView2.DataBind();
    }
}
