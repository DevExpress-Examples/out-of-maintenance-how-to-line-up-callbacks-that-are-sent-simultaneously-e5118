Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Threading

Partial Public Class Master_Detail_Two_Grids
	Inherits System.Web.UI.Page
   Protected Sub Page_Load(ByVal sender As Object, ByVal e As EventArgs)
		Dim filterExpression1 As String = Convert.ToString(Session("FilterExpression1"))
		If filterExpression1 <> String.Empty Then
			adsProducts1.FilterExpression = filterExpression1
			detailGridView1.DataSource = adsProducts1
			detailGridView1.DataSourceID = String.Empty
			detailGridView1.DataBind()
		End If


	   Dim filterExpression2 As String = Convert.ToString(Session("FilterExpression2"))
		If filterExpression1 <> String.Empty Then
			adsProducts2.FilterExpression = filterExpression2
			detailGridView2.DataSource = adsProducts2
			detailGridView2.DataSourceID = String.Empty
			detailGridView2.DataBind()
		End If
   End Sub
   Protected Sub detailGridView1_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs)
		Thread.Sleep(1000)

		Dim values As Object = masterGrid1.GetRowValues(masterGrid1.FocusedRowIndex, New String() { "CategoryID" })
		detailGridView1.DataSource = Nothing
		Dim filterExpression As String = "CategoryID='" & values.ToString() & "'"
		Session("FilterExpression1") = filterExpression
		adsProducts1.FilterExpression = filterExpression
		detailGridView1.DataSource = adsProducts1
		detailGridView1.PageIndex = 0
		detailGridView1.DataBind()
   End Sub

   Protected Sub detailGridView2_CustomCallback(ByVal sender As Object, ByVal e As DevExpress.Web.ASPxGridView.ASPxGridViewCustomCallbackEventArgs)
		Thread.Sleep(1000)

		Dim values As Object = masterGrid2.GetRowValues(masterGrid2.FocusedRowIndex, New String() { "CategoryID" })
		detailGridView2.DataSource = Nothing
		Dim filterExpression As String = "CategoryID='" & values.ToString() & "'"
		Session("FilterExpression2") = filterExpression
		adsProducts2.FilterExpression = filterExpression
		detailGridView2.DataSource = adsProducts2
		detailGridView2.PageIndex = 0
		detailGridView2.DataBind()
   End Sub
End Class
