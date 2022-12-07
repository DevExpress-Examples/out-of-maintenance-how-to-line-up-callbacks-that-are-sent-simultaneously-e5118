<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Master_Detail_Two_Grids" %>
<%@ Register Assembly="DevExpress.Web.v15.1, Version=15.1.15.0, Culture=neutral, PublicKeyToken=b88d1754d700e49a" Namespace="DevExpress.Web" TagPrefix="dx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>How to line up callbacks that are sent simultaneously</title>
    <script type="text/javascript">
        PendingCallbacks = {};
        function DoCallback(sender, callback) {
            if (sender.InCallback()) {
                PendingCallbacks[sender.name] = callback;
                sender.EndCallback.RemoveHandler(DoEndCallback);
                sender.EndCallback.AddHandler(DoEndCallback);
            } else {
                callback();
            }
        }

        function DoEndCallback(s, e) {
            var pendingCallback = PendingCallbacks[s.name];
            if (pendingCallback) {
                pendingCallback();
                delete PendingCallbacks[s.name];
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table style="width: 100%;">
            <tr>
                <td style="vertical-align: top">
                    <b>PerformCallback implementation:</b><br />                   
                    <dx:ASPxGridView ID="masterGrid1" runat="server" AutoGenerateColumns="False" DataSourceID="adsCategories"
                        KeyFieldName="CategoryID" Width="598px" ClientInstanceName="masterGrid1">
                        <Columns>
                            <dx:GridViewDataTextColumn ReadOnly="True" VisibleIndex="1" FieldName="CategoryID"
                                Caption="CategoryID">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn VisibleIndex="2" FieldName="CategoryName" Caption="CategoryName">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn VisibleIndex="3" FieldName="Description" Caption="Description">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsBehavior AllowFocusedRow="True" />
                        <ClientSideEvents FocusedRowChanged="function(s, e) {
                    detailGridView1.PerformCallback(s.GetFocusedRowIndex());
            }" />
                    </dx:ASPxGridView>

                    <dx:ASPxGridView runat="server" ID="detailGridView1" ClientInstanceName="detailGridView1" KeyFieldName="ProductID"
                        AutoGenerateColumns="False" Width="599px" OnCustomCallback="detailGridView1_CustomCallback">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" Caption="ProductID"
                                VisibleIndex="1">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ProductName" Caption="ProductName" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CategoryID" Caption="CategoryID" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="SupplierID" Caption="SupplierID" VisibleIndex="4">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
                <td style="vertical-align: top">
                    <b>DoCallback implementation:</b><br />
                    <dx:ASPxGridView ID="masterGrid2" runat="server" AutoGenerateColumns="False" DataSourceID="adsCategories"
                        KeyFieldName="CategoryID" Width="598px" ClientInstanceName="masterGrid2">
                        <Columns>
                            <dx:GridViewDataTextColumn ReadOnly="True" VisibleIndex="1" FieldName="CategoryID"
                                Caption="CategoryID">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn VisibleIndex="2" FieldName="CategoryName" Caption="CategoryName">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn VisibleIndex="3" FieldName="Description" Caption="Description">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                        <SettingsBehavior AllowFocusedRow="True" />
                        <ClientSideEvents FocusedRowChanged="function(s, e) {
                  DoCallback(detailGridView2, function () { detailGridView2.PerformCallback(s.GetFocusedRowIndex()); });
            }" />
                    </dx:ASPxGridView>
                    <dx:ASPxGridView runat="server" ID="detailGridView2" ClientInstanceName="detailGridView2" KeyFieldName="ProductID"
                        AutoGenerateColumns="False" Width="599px" OnCustomCallback="detailGridView2_CustomCallback">
                        <Columns>
                            <dx:GridViewDataTextColumn FieldName="ProductID" ReadOnly="True" Caption="ProductID"
                                VisibleIndex="1">
                                <EditFormSettings Visible="False"></EditFormSettings>
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="ProductName" Caption="ProductName" VisibleIndex="2">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="CategoryID" Caption="CategoryID" VisibleIndex="3">
                            </dx:GridViewDataTextColumn>
                            <dx:GridViewDataTextColumn FieldName="SupplierID" Caption="SupplierID" VisibleIndex="4">
                            </dx:GridViewDataTextColumn>
                        </Columns>
                    </dx:ASPxGridView>
                </td>
            </tr>
        </table>

        <asp:AccessDataSource ID="adsCategories" runat="server" DataFile="~/App_Data/nwind.mdb"
            SelectCommand="SELECT [CategoryID], [CategoryName], [Description] FROM [Categories]"></asp:AccessDataSource>
        <asp:AccessDataSource ID="adsProducts1" runat="server" DataFile="~/App_Data/nwind.mdb"
            SelectCommand="SELECT [ProductID], [ProductName], [CategoryID], [SupplierID] FROM [Products]"></asp:AccessDataSource>
        <asp:AccessDataSource ID="adsProducts2" runat="server" DataFile="~/App_Data/nwind.mdb"
            SelectCommand="SELECT [ProductID], [ProductName], [CategoryID], [SupplierID] FROM [Products]"></asp:AccessDataSource>

    </form>
</body>
</html>
