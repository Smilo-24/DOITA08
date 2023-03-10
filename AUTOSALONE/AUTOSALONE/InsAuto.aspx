<%@ Page Title="" Language="C#" MasterPageFile="~/Autosalone.master" AutoEventWireup="true" CodeFile="InsAuto.aspx.cs" Inherits="_InsAuto" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="container">

        <!-- Page Title -->
        <div class="display-4 py-4 d-flex justify-content-center">
            Inserisci Auto
        </div>

        <div class="row d-flex justify-content-center">
            <div class="col-lg-6 col-xl-6">
                <div class="card">
                    <div class="card-body">
                        <h5>Inserisci dati:</h5>
                        <!-- Seleziona marca e modello -->
                        <div class="row">
                            <!-- Seleziona marca dell'auto da aggiungere -->
                            <div class="col-lg-6">
                                <div class="form-outline">
                                    <asp:Literal ID="Literal1" runat="server">Marca:</asp:Literal>
                                    <asp:DropDownList ID="ddlMarca" runat="server" DataTextField="MARCA" DataValueField="chiave" DataSourceID="sdsMARCHE" AutoPostBack="True"></asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="sdsMARCHE" ConnectionString="<%$ ConnectionStrings:AUTOSALONIConnectionString %>" SelectCommand="SELECT [chiave], [MARCA] FROM [MARCHE] ORDER BY [MARCA]"></asp:SqlDataSource>
                                </div>
                            </div>
                            <!-- Seleziona modello dell'auto da aggiungere, in base alla marca selezionata -->
                            <div class="col-lg-6">
                                <div class="form-outline">
                                    <asp:Literal ID="Literal2" runat="server">Modello:</asp:Literal>
                                    <asp:DropDownList ID="ddlModello" runat="server" DataTextField="MODELLO" DataValueField="MODELLO" DataSourceID="sdsMODELLI" AutoPostBack="True" OnDataBound="ddlModello_SelectedIndexChanged"></asp:DropDownList>
                                    <asp:SqlDataSource runat="server" ID="sdsMODELLI" ConnectionString="<%$ ConnectionStrings:AUTOSALONIConnectionString %>" SelectCommand="MODELLI_GetDistinctModelloByMarca" SelectCommandType="StoredProcedure">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddlMarca" PropertyName="SelectedValue" Name="MARCA"></asp:ControlParameter>
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </div>
                            </div>
                        </div>

                        <asp:GridView ID="grdModelli" runat="server" DataSourceID="sdsMODS" AutoGenerateColumns="false" DataKeyNames="chiave" CssClass="table table-striped table-sm">
                            <Columns>
                                <asp:CommandField ShowSelectButton="true" HeaderText="Seleziona:" />
                                <asp:BoundField DataField="MODELLO" HeaderText="MODELLO" SortExpression="MODELLO" />
                                <asp:BoundField DataField="ALIMENTAZIONE" HeaderText="ALIMENTAZIONE" SortExpression="ALIMENTAZIONE" />
                                <asp:BoundField DataField="CAMBIO" HeaderText="CAMBIO" SortExpression="CAMBIO" />
                                <asp:BoundField DataField="MOTORIZZAZIONE" HeaderText="MOTORIZZAZIONE" SortExpression="MOTORIZZAZIONE" />
                            </Columns>
                            <SelectedRowStyle BackColor="#2c98e0" />
                        </asp:GridView>
                        <asp:SqlDataSource runat="server" ID="sdsMODS" ConnectionString="<%$ ConnectionStrings:AUTOSALONIConnectionString %>" SelectCommand="MODELLI_GetModelloByName" SelectCommandType="StoredProcedure">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlModello" PropertyName="SelectedValue" Name="MODELLO" Type="String"></asp:ControlParameter>
                            </SelectParameters>
                        </asp:SqlDataSource>

                        <!-- Campi per l'inserimento dei dati dell'Auto -->
                        <div class="row">
                            <!-- Anno -->
                            <div class="col-lg-4">
                                <div class="form-outline">
                                    <asp:Literal ID="li1" runat="server">Anno:</asp:Literal>
                                    <asp:TextBox ID="txtAnno" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <!-- Targa -->
                            <div class="col-lg-4">
                                <div class="form-outline">
                                    <asp:Literal ID="lit2" runat="server">Targa:</asp:Literal>
                                    <asp:TextBox ID="txtTarga" runat="server" CssClass="form-control" MaxLength="7"></asp:TextBox>
                                </div>
                            </div>
                            <!-- Kilometri -->
                            <div class="col-lg-4">
                                <div class="form-outline">
                                    <asp:Literal ID="lit3" runat="server">Kilometri:</asp:Literal>
                                    <asp:TextBox ID="txtKM" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <!-- Colore e Prezzo -->
                        <div class="row">
                            <div class="col-lg-6">
                                <div class="form-outline">
                                    <asp:Literal ID="lit4" runat="server">Colore:</asp:Literal>
                                    <asp:TextBox ID="txtColore" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="col-lg-6">
                                <div class="form-outline">
                                    <asp:Literal ID="lit1" runat="server">Prezzo:</asp:Literal>
                                    <asp:TextBox ID="txtPrezzo" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                        </div>
                        <!-- Bottone per inserire i dati nel database -->
                        <div class="py-1">
                            <asp:Button ID="btnAuto" runat="server" Text="Inserisci Auto" OnClick="btnAuto_Click" CssClass="btn btn-primary" />
                        </div>
                    </div>
                </div>
            </div>

            <!-- GridView per vedere tutte le auto nel database -->
            <div class="col-lg-6 col-xl-6">
                <div class="scroll">
                    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="chiave" DataSourceID="sdsAUTOMOBILI" CssClass="table table-striped scroll">
                        <Columns>
                            <asp:BoundField DataField="MARCA" HeaderText="MARCA" SortExpression="MARCA"></asp:BoundField>
                            <asp:BoundField DataField="MODELLO" HeaderText="MODELLO" SortExpression="MODELLO"></asp:BoundField>
                            <asp:BoundField DataField="ANNO" HeaderText="ANNO" SortExpression="ANNO"></asp:BoundField>
                            <asp:BoundField DataField="TARGA" HeaderText="TARGA" SortExpression="TARGA"></asp:BoundField>
                            <asp:BoundField DataField="KILOMETRI" HeaderText="KILOMETRI" SortExpression="KILOMETRI"></asp:BoundField>
                            <asp:BoundField DataField="COLORE" HeaderText="COLORE" SortExpression="COLORE"></asp:BoundField>
                            <asp:BoundField DataField="PREZZO" HeaderText="PREZZO" SortExpression="PREZZO"></asp:BoundField>
                            <asp:BoundField DataField="ALIMENTAZIONE" HeaderText="ALIMENTAZIONE" SortExpression="ALIMENTAZIONE"></asp:BoundField>
                            <asp:BoundField DataField="CAMBIO" HeaderText="CAMBIO" SortExpression="CAMBIO"></asp:BoundField>
                            <asp:BoundField DataField="MOTORIZZAZIONE" HeaderText="MOTORIZZAZIONE" SortExpression="MOTORIZZAZIONE"></asp:BoundField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource runat="server" ID="sdsAUTOMOBILI" ConnectionString="<%$ ConnectionStrings:AUTOSALONIConnectionString %>" SelectCommand="select AUTOMOBILI.chiave, MARCHE.MARCA, MODELLI.MODELLO, AUTOMOBILI.ANNO, AUTOMOBILI.TARGA, AUTOMOBILI.KILOMETRI, AUTOMOBILI.COLORE, AUTOMOBILI.PREZZO, MODELLI.ALIMENTAZIONE, MODELLI.CAMBIO, MODELLI.MOTORIZZAZIONE
                        from AUTOMOBILI
                        join MODELLI
                        on AUTOMOBILI.chiaveMODELLO=MODELLI.chiave
                        join MARCHE
                        on MODELLI.chiaveMARCA=MARCHE.chiave
                        order by MARCHE.MARCA"></asp:SqlDataSource>
                </div>
            </div>

        </div>
    </section>
</asp:Content>

