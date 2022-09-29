<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Adoption Record- Home 4 The Holidays" Debug="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>

<script runat="server">
    Sub Page_Load(obj As Object, e As EventArgs)
        If Session("UserId") = "" Then Response.Redirect("../login.aspx?ReturnURL=../members/adoptions.aspx")

        ShowGraph() 'get goal table set up

        If Not Page.IsPostBack Then
            'load ddlDates here with dates from h4th dates where date-180 to present
            GetDates()
        Else
            'BindGrid() 'fx to load history to repeater control?
        End If
    End Sub
    Sub GetDates()
        Dim strSqL As String
        Dim objReader As SqlDataReader
        Dim db As New HWAC.DatabaseH4TH
        strSqL = "Select DateID, DisplayDesc FROM tblH4thDates Where BegDate<='" & DateTime.Now.ToShortDateString & "' AND EndDate>='" & DateTime.Now.ToShortDateString & "' ORDER BY Begdate Desc"

        objReader = db.GetReader(strSqL)
        ddlDates.DataSource = objReader
        ddlDates.DataBind()
    End Sub
    Sub ShowGraph()
        Dim strSql As String
        Dim strGraph As String
        Dim intdogs As Integer
        Dim intcats As Integer
        Dim intKittens As Integer
        Dim intPuppies As Integer
        Dim intOther As Integer
        Dim objReader As SqlDataReader
        Dim objReader2 As SqlDataReader
        Dim db As New HWAC.DatabaseH4TH
        Dim db2 As New HWAC.DatabaseH4TH
        Dim clsGraph As New HWAC.Utility

        'History---------------------------------------------
        lblHistory.Text = ""
        strSql = "SELECT AYear, Sum(dogs) as dogs, SUM(puppies) as Puppies, SUM(Cats) as Cats, SUM(Kittens) as Kittens, Sum(other) as Other, AType FROM tblh4thAdoptions WHERE ShelterId=" & Session("UserId") & " GROUP BY AYear,AType ORDER BY AYear asc, AType Asc"
        objReader = db.GetReader(strSql)
        If Not objReader Is Nothing Then
            While objReader.Read()
                With objReader
                    'Set values
                    If IsDBNull(.Item(0)) Then 'no data yet
                        intdogs = 0 : intcats = 0 : intPuppies = 0 : intKittens = 0 : intOther = 0 'initialize for graph
                    Else
                        'if .getstring(0)<>year(now) then
                        'lblHistory.text &="<tr><td>" & .getstring(0) & "</td><td>"& .getint32(1) & "</td><td>" & .Getint32(2) & "</td><td>" & .Getint32(3) & "</td><td>" & .Getint32(4)	& "</td><td>" & .Getint32(5) & "</td></tr>"

                        'else
                        If .Item("AType") <> "Goal" Then 'weekly numbers
                            lblHistory.Text &= "<div Class=table-row><div Class=serial>Total</div><div Class=serial>" & .GetString(0) & "</div><div Class=serial>" & .GetInt32(1) & "</div><div Class=serial>" & .GetInt32(2) & "</div><div Class=serial>" & .GetInt32(3) & "</div><div Class=serial>" & .GetInt32(4) & "</div><div Class=serial>" & .GetInt32(5) & "</div></div>"
                            intdogs = .GetInt32(1)
                            intcats = .GetInt32(3)
                            intPuppies = .GetInt32(2)
                            intKittens = .GetInt32(4)
                            intOther = .GetInt32(5)
                        Else
                            lblHistory.Text &= "<div Class=table-row style=""background-color: #ffe291;""><div Class=serial>Goal</div><div Class=serial>" & .GetString(0) & "</div><div Class=serial>" & .GetInt32(1) & "</div><div Class=serial>" & .GetInt32(2) & "</div><div Class=serial>" & .GetInt32(3) & "</div><div Class=serial>" & .GetInt32(4) & "</div><div Class=serial>" & .GetInt32(5) & "</div></div>"
                            intdogs = 0 : intcats = 0 : intPuppies = 0 : intKittens = 0 : intOther = 0
                        End If
                        'end if
                    End If
                End With
            End While

            If lblHistory.Text <> "" Then lblHistory.Text = "<p align=center><b>Total Adoptions</b></p><div Class=progress-table-wrap><div Class=progress-table><div Class=table-head><div Class=serial></div><div Class=serial>Year</div><div Class=serial>Dogs</div><div Class=serial>Puppies</div><div Class=serial>Cats</div><div Class=serial>Kittens</div><div Class=serial>Other</div></div><div style=""height: 40em;overflow-y: auto;"">" & lblHistory.Text & "</div></div></div>"

            'If lblHistory.Text <> "" Then lblHistory.Text = "<table align=center ><tr><td colspan=7 align=center><b>Total Adoptions</b></td></tr><tr><td></td><td>Year</td><td>Dogs</td><td>Puppies</td><td>Cats</td><td>Kittens</td><td>Other</td></tr>" & lblHistory.Text & "</table>"

            objReader.Close()
        Else 'no data yet
            intdogs = 0 : intcats = 0 : intPuppies = 0 : intKittens = 0 : intOther = 0
            objReader.Close()
        End If
        db = Nothing
        'End History-----------------------------------------------
        'Current Year Graph-----------------------------------------
        strSql = "SELECT AYear, dogs, Puppies, Cats, Kittens, Other FROM tblh4thAdoptions WHERE Atype='Goal' AND ShelterId=" & Session("UserId") & " Order By AYear ASC"
        objReader2 = db2.GetReader(strSql)
        If Not objReader2 Is Nothing Then 'found it
            'build table
            With objReader2
                While .Read()
                    lblgraph.Text = "<table><tr><td>Your " & .GetString(0) & " Goal</td></tr>"

                    If .Item(1) <> 0 Then
                        lblgraph.Text &= "<tr><td>" & .Item(1) & " Dogs&nbsp;</td><td>" & clsGraph.CreateGraph(.Item(1), intdogs) & "</td></tr>"
                    End If
                    If .Item(2) <> 0 Then
                        lblgraph.Text &= "<tr><td>" & .Item(2) & " Puppies&nbsp;</td><td>" & clsGraph.CreateGraph(.Item(2), intPuppies) & "</td></tr>"
                    End If
                    If .Item(3) <> 0 Then
                        lblgraph.Text &= "<tr><td>" & .Item(3) & " Cats&nbsp;</td><td>" & clsGraph.CreateGraph(.Item(3), intcats) & "</td></tr>"
                    End If
                    If .Item(4) <> 0 Then
                        lblgraph.Text &= "<tr><td>" & .Item(4) & " Kittens&nbsp;</td><td>" & clsGraph.CreateGraph(.Item(4), intKittens) & "</td></tr>"
                    End If
                    If .Item(5) <> 0 Then
                        lblgraph.Text &= "<tr><td>" & .Item(5) & " Other&nbsp;</td><td>" & clsGraph.CreateGraph(.Item(5), intOther) & "</td></tr>"
                    End If
                    lblgraph.Text &= "<tr><td></td><td></td></tr></table>"
                End While
            End With
        Else

        End If
        objReader2.Close()
        'End Current Year Graph---------------------------------------------------------------

        'Breakdown this years entries---------------------------------------------------------
        'show this years adoption entries
        Dim objreader3 As SqlDataReader
        Dim db3 As New HWAC.DatabaseH4TH

        strSql = "SELECT dbo.tblH4thDates.DisplayDesc, dbo.tblH4thAdoptions.pKey, dbo.tblH4thAdoptions.Dogs, dbo.tblH4thAdoptions.Puppies, dbo.tblH4thAdoptions.Cats, dbo.tblH4thAdoptions.Kittens, dbo.tblH4thAdoptions.Other FROM dbo.tblH4thAdoptions INNER JOIN dbo.tblH4thDates ON dbo.tblH4thAdoptions.DateId = dbo.tblH4thDates.DateID WHERE (dbo.tblH4thDates.BegDate <= '" & DateTime.Now.ToShortDateString & "') AND (dbo.tblH4thDates.EndDate >='" & DateTime.Now.ToShortDateString & "') AND (dbo.tblH4thAdoptions.ShelterID=" & Session("UserID") & ") AND (dbo.tblH4thAdoptions.AType<>'Goal') ORDER BY dbo.tblH4thDates.BegDate"
        'Create/Populate the DataReader
        objreader3 = db3.GetReader(strSql)
        'Databind the DataReader to the DataList Web control
        If objreader3.HasRows() Then
            dlAdoptions.DataSource = objreader3
            dlAdoptions.DataBind()
        Else
            dlAdoptions.Visible = False
        End If
        objreader3.Close()

    End Sub
    Sub btnAdd_Adoptions_Click(obj As Object, e As EventArgs)
        If Page.IsValid Then
            'add data to h4th adoptions list with session user id
            'first check if data is already in system, if is, update, if not, add new
            Dim strsql As String
            Dim strResult As String
            Dim db As New HWAC.DatabaseH4TH
            Dim strAType As String
            strsql = "SELECT pKey FROM tblH4thAdoptions WHERE Shelterid=" & Session("UserId") & " AND DateId=" & ddlDates.SelectedItem.Value
            strResult = db.ExecuteScalar(strsql)
            If InStr(ddlDates.SelectedItem.Text, "Goal") Then 'is a goal, not a weekly
                strAType = "Goal"
            Else
                strAType = "Weekly"
            End If
            If strResult = "" Then 'does not exist-insert new
                strsql = "INSERT Into tblH4thAdoptions (ShelterID, DateID, Ayear, AType, Dogs, Puppies, Cats, Kittens, Other) Values (" & Session("UserId") & "," & ddlDates.SelectedItem.Value & ",'2021','" & strAType & "'," & tbDogs.Text & "," & tbPuppies.Text & "," & tbCats.Text & "," & tbKittens.Text & "," & tbOther.Text & ")"
            Else 'exists, update
                strsql = "Update tblH4thAdoptions Set Dogs=" & tbDogs.Text & ", Puppies=" & tbPuppies.Text & ", Cats=" & tbCats.Text & ", Kittens=" & tbKittens.Text & ", Other=" & tbOther.Text & " WHERE ShelterId=" & Session("UserId") & " AND DateId=" & ddlDates.SelectedItem.Value
            End If
            db.ExecuteNonQuery(strsql)
            ShowGraph()
        End If
    End Sub


</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <%--<link rel="stylesheet" href="../_css/thickbox.css" type="text/css" media="screen" />
<link href="../_css/style2.css" rel="stylesheet" type="text/css" />--%>
</asp:Content>

<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/family-with-dog-porch-banner-2.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">H4TH Members</h1>
                    <p class="text-white link-nav">
                        <a href="/members/index.aspx">Member Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Recording Adoptions</a>
                    </p>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<%-- End banner Area --%>


<asp:Content ID="navigation" ContentPlaceHolderID="Leftnav" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="Server">

    <%--Start about-info Area--%>
    <section class="about-info-area">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-12">
                    <div class="title text-center">
                        <h1 class="mb-10">Recording Adoptions For Your Shelter</h1>
                    </div>

                    <div class="whole-wrap">
                        <div class="container">
                            <div class="">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">
                                        <form runat="server" id="form1">

                                            <div class="section-top-border">

                                                <div class="row mt-10">
                                                    <div class="col-lg-1 col-md-1"></div>
                                                    <div class="col-lg-3 col-md-3">
                                                        Choose Your Week or Goal
                                                    </div>
                                                    <div class="col-lg-7 col-md-7">
                                                        <asp:DropDownList runat="server" ID="ddlDates" DataTextField="DisplayDesc" DataValueField="DateID" CssClass="single-input dropdown-scrollable nice-select" />
                                                    </div>
                                                    <div class="col-lg-1 col-md-1"></div>
                                                </div>
                                                <div class="row mt-10">
                                                    <div class="col-lg-1 col-md-1"></div>
                                                    <div class="col-lg-2 col-md-2">
                                                        Dogs:
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        Puppies:
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        Cats:
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        Kittens:
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        Other:
                                                    </div>
                                                    <div class="col-lg-1 col-md-1"></div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-1 col-md-1"></div>
                                                    <div class="col-lg-2 col-md-2">
                                                        <asp:TextBox ID="tbDogs" CssClass="form-control" runat="server" Text="0" onkeypress="if(event.keyCode<48 || event.keyCode>57)event.returnValue=false;" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        <asp:TextBox ID="tbPuppies" CssClass="form-control" runat="server" Text="0" onkeypress="if(event.keyCode<48 || event.keyCode>57)event.returnValue=false;" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        <asp:TextBox ID="tbCats" CssClass="form-control" runat="server" Text="0" onkeypress="if(event.keyCode<48 || event.keyCode>57)event.returnValue=false;" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        <asp:TextBox ID="tbKittens" CssClass="form-control" runat="server" Text="0" onkeypress="if(event.keyCode<48 || event.keyCode>57)event.returnValue=false;" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        <asp:TextBox ID="tbOther" CssClass="form-control" runat="server" Text="0" onkeypress="if(event.keyCode<48 || event.keyCode>57)event.returnValue=false;" />
                                                    </div>
                                                    <div class="col-lg-1 col-md-1"></div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2"></div>
                                                    <div class="col-lg-10 col-md-10">
                                                        <asp:RequiredFieldValidator ControlToValidate="tbDogs" CssClass="errorMsg" ErrorMessage="*Projected number of dogs required" Display="Dynamic" runat="server" />
                                                        <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" CssClass="errorMsg" Display="Dynamic" ControlToValidate="tbDogs" Type="Integer" ErrorMessage="*Dogs must be a number between 0 and 2000" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbPuppies" CssClass="errorMsg" ErrorMessage="*Projected number of Puppies required" Display="Dynamic" runat="server" />
                                                        <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" CssClass="errorMsg" Display="Dynamic" ControlToValidate="tbPuppies" Type="Integer" ErrorMessage="*Puppies must be a number between 0 and 2000" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbCats" CssClass="errorMsg" ErrorMessage="*Projected number of Cats required" Display="Dynamic" runat="server" />
                                                        <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" CssClass="errorMsg" Display="Dynamic" ControlToValidate="tbCats" Type="Integer" ErrorMessage="*Cats must be a number between 0 and 2000" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbKittens" CssClass="errorMsg" ErrorMessage="*Projected number of Kittens required" Display="Dynamic" runat="server" />
                                                        <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" CssClass="errorMsg" Display="Dynamic" ControlToValidate="tbKittens" Type="Integer" ErrorMessage="*Kittens must be a number between 0 and 2000" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbOther" CssClass="errorMsg" ErrorMessage="*Projected number of other animals required.  Enter 0 if none." Display="Dynamic" runat="server" />
                                                        <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" CssClass="errorMsg" Display="Dynamic" ControlToValidate="tbOther" Type="Integer" ErrorMessage="*Other animals must be a number between 0 and 2000" />
                                                    </div>
                                                </div>


                                            </div>

                                            <div class="title text-center">
                                                <asp:Button ID="btnRegister" OnClick="btnAdd_Adoptions_Click" CssClass="genric-btn primary small round-border mb-20" runat="server" Text="Submit Numbers" />
                                            </div>
                                        </form>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>



                    <div class="container section-top">
                        <div class="">
                            <div class="row">
                                <div class="col-lg-12 col-md-12">



                                    <div class="col-lg-12 col-md-12">


                                        <div class="section-top-border">
                                            <h5 class="mb-20">
                                                <asp:Label runat="server" ID="lblgraph" />
                                            </h5>
                                            <h3 class="mb-10">History</h3>

                                            <asp:Label runat="server" ID="lblHistory" />

                                        </div>

                                        <br>
                                        <asp:Label runat="server" ID="lblCurrentNumbers" />




                                        <div align="center">
                                            <asp:DataList ID="dlAdoptions" runat="server" DataKeyField="pKey" ShowBorder="true">
                                                <HeaderTemplate>
                                                    <table align="center" border="0" cellpadding="2" cellspacing="5">
                                                        <tr bgcolor="#FF9933">
                                                            <td colspan="6" align="center"><strong>Current Adoption Numbers</strong></td>
                                                        </tr>
                                                        <tr>
                                                            <td>Week</td>
                                                            <td>Dogs</td>
                                                            <td>Puppies</td>
                                                            <td>Cats</td>
                                                            <td>Kittens</td>
                                                            <td>Other</td>
                                                        </tr>
                                                </HeaderTemplate>
                                                <FooterTemplate>
                                                    </table>
    <br>
                                                </FooterTemplate>
                                                <ItemTemplate>
                                                    <tr>
                                                        <td nowrap><%# Container.DataItem("DisplayDesc") %></td>
                                                        <td><%# Container.DataItem("Dogs") %></td>
                                                        <td><%# Container.DataItem("Puppies") %></td>
                                                        <td><%# Container.DataItem("Cats") %></td>
                                                        <td><%# Container.DataItem("Kittens") %></td>
                                                        <td><%# Container.DataItem("Other") %></td>
                                                    </tr>
                                                </ItemTemplate>

                                            </asp:DataList>
                                        </div>
                                    </div>


                                </div>

                            </div>
                        </div>
                    </div>




                </div>
            </div>
        </div>
    </section>
    <%--End about-info Area--%>
</asp:Content>
