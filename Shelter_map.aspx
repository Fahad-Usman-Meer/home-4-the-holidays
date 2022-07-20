<%@ Page Language="VB" ViewStateEncryptionMode="Never" MasterPageFile="~/template.master" Title="Home 4 the Holidays Shelter Map | Helen Woodward Animal Center" Debug="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.Security.Principal" %>
<%@ Register TagPrefix="HWAC" TagName="Header2" Src="~/_controls/h4thheader-2.ascx" %>
<%@ Register TagPrefix="HWAC" TagName="LeftNav" Src="~/_controls/h4thleftnav2.ascx" %>
<%@ Register TagPrefix="HWAC" TagName="Footer" Src="~/_controls/h4thfooter.ascx" %>
<script runat="server">

    Sub Page_Load(sender As Object, e As EventArgs)
        if not page.ispostback then 'get data
            Dim objGetData as New HWAC.databaseH4TH
            Dim strSQL as String
            'strsql="BACKUP LOG animalcenter_HWAC WITH TRUNCATE_ONLY"
            'objgetdata.ExecuteNonQuery(strsql)
            'exit sub
            Dim objReader as SqlDataReader
            If Request.QueryString("ID") = "donate" Then
                'donate text
                lblTitle.Text = "Blue Buffalo Home 4 the Holidays Partner Organizations"
                lblTotal.Text = "<h2>Keep the Light Shining by Donating to an Animal Shelter or Rescue Today</h2><p>Select a shelter below and select ""Donate To Shelter"" to proceed.</p>"
            ElseIf Request.ServerVariables("HTTP_REFERER") = "http://www.iams.com/iams/en_US/data_root/html/Angel/BecomeAVolunteer.html" Or Request.QueryString("ID") = "Volunteer" Then 'volunteer text
                lblTotal.Text = "<h1>Volunteering</h1><p>Select a shelter below to find information about volunteering</p><p>View Blue Buffalo Home 4 the Holidays shelters by state or country. Choose a state or country to view partner shelters near you.</p>"
            Else
                lblTitle.Text = "<b>Search</b> for a Blue Buffalo Home 4 the Holidays Organization"
                'Get Total Shelters
                strSQL = "SELECT count(ShelterID) as ShelterCount From tblH4THReg WHERE Approved=1 AND Active=1 AND Verified=1"
                lblTotal.Text = " See Blue Buffalo Home 4 the Holidays shelters by state or  country. Choose a state or country to view partner shelters near you.<br>  <br>  There are " & objGetData.ExecuteScalar(strSQL) & " animal shelters  and pet rescue groups enrolled in Blue Buffalo Home 4 the Holidays. If your  organization has not yet registered, <a href=""https://join.home4theholidays.org/register.aspx"">do so today  and increase pet adoption awareness!</a>"
                '> There are  animal shelters  and pet rescue groups enrolled in Blue Buffalo Home 4 the Holidays. If your  organization has not yet registered, <a href=""https://join.home4theholidays.org/register.aspx"">do so today</a> and increase pet adoption  awareness!"'<p>Choose a state or country to view its participating shelters.</p> <p>Help us reach this years goal of 4000 Shelters! There are " & objGetData.ExecuteScalar(strSQL) & " animal shelters and pet rescue groups that have enrolled in Home 4 the Holidays. If your organization has not yet registered, do so today and help save  lives!</p>"
            End If
            GetStates()
            GetCountries()
        End If
    End Sub

    Sub GetStates()
        'Get States
        Dim objGetData As New HWAC.DatabaseH4TH
        Dim strSQL As String
        Dim objReader As SqlDataReader

        strSQL = "SELECT MState, count(ShelterID) as StateCount From tblH4THReg WHERE MCountry='United States' AND Approved=1 AND Verified=1 AND Active=1 Group By MState Order By MState"
        objReader = objGetData.GetReader(strSQL)
        If Not objReader Is Nothing Then
            dlStates.DataSource = objReader
            dlStates.DataBind()
            objReader.Close()
        End If
    End Sub

    Sub GetCountries()
        'Get Countries
        Dim objGetData As New HWAC.DatabaseH4TH
        Dim strSQL As String
        Dim objReader As SqlDataReader

        strSQL = "SELECT MCountry From tblH4THReg WHERE MCountry<>'United States'  AND Approved=1 AND Verified=1 AND Active=1 Group By MCountry Order By MCountry"
        objReader = objGetData.GetReader(strSQL)
        If Not objReader Is Nothing Then
            dlCountries.DataSource = objReader
            dlCountries.DataBind()
            objReader.Close()
        End If

    End Sub

    Sub View_Shelters(obj As Object, e As DataListCommandEventArgs)
        Dim strSQL As String
        Dim strState As String
        Dim lnkbtn As LinkButton
        Dim objReader As SqlDataReader
        Dim objGetData As New HWAC.DatabaseH4TH
        Dim strWeb As String
        Dim strReplace As String

        '---find the  control containing the state
        lnkbtn = CType(e.Item.FindControl("btn1"), LinkButton)
        strState = lnkbtn.Text
        If Len(strState) > 2 Then 'must be country
            lblHeader.Text = strState
            strSQL = "SELECT ShelterName, MCity, WebSite, ShelterID From tblH4THReg WHERE MCountry ='" & strState & "' AND Approved=1 AND Verified=1 AND Active=1 Order By " & ddlSort.SelectedItem.Value
        Else
            lblHeader.Text = "United States -" & strState
            strSQL = "SELECT ShelterName, MCity, Website, ShelterID From tblH4THReg WHERE MState ='" & strState & "'  AND Approved=1 AND Verified=1 AND Active=1 Order By " & ddlSort.SelectedItem.Value
        End If
        objReader = objGetData.GetReader(strSQL)
        'set lblshelters.text to data
        If Not objReader Is Nothing Then
            lblShelters.Text = "<ol>"
            'Dim p as IPrincipal = HttpContext.Current.User
            'if p.IsInRole("Admin") then
            If Session("Admin") = "@F@EWE$" Then

                While objReader.Read()
                    strReplace = Replace(objReader.GetString(0), "&", "%26")
                    strReplace = Replace(strReplace, """", "%22")
                    strWeb &= "<li> <a href=""members/index.aspx?ShelterName=" & strReplace & "&SID=" & objReader.GetInt32(3) & """><b>+</b></a>&nbsp;<a href=shelter_details.aspx?ShelterID=" & objReader.Item("ShelterId") & " target=""_blank"">" & objReader.GetString(0) & ", " & objReader.GetString(1) & "</a></li>"
                    '& "<span><table bgcolor=""#D8FAD3"" border=""2"" bordercolor=""#009966"" cellpadding=""2""><tr><td>Home 4 The Holidays  is a free program that provides support and materials to shelters to help increase adoptions, increase public awareness, lower euthanasia, and results in very few returns.</td></tr></table></span></a>, " & objReader.GetString(1) & 


                End While
                lblShelters.Text = strWeb
            Else
                While objReader.Read()

                    strWeb &= "<li><a href=shelter_details.aspx?ShelterID=" & objReader.Item("ShelterID") & " target=""_blank"">" & objReader.GetString(0) & ", " & objReader.GetString(1) & "</a></li>"
                    ' "<span><table bgcolor=""#D8FAD3"" border=""2"" bordercolor=""#009966"" cellpadding=""2""><tr><td>Home 4 The Holidays  is a free program that provides support and materials to shelters to help increase adoptions, increase public awareness, lower euthanasia, and results in very few returns.</td></tr></table></span></a>, " &


                End While
                lblShelters.Text &= strWeb



            End If
            lblShelters.Text &= "</ol>"

        End If
    End Sub

</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Is there a Blue Buffalo Home 4 the Holidays shelter in your area? Find all Blue Buffalo Home 4 the Holidays shelters at the Shelter Map." />
    <meta name="keywords" content="shelter map, pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />
</asp:Content>

<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/family-with-dog-porch-banner-2.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">Participating Shelters
                    </h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Participating Shelters</a>
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
            <div class="row align-items-center section-gap">
                <div class="col-lg-12">
                    <div class="title text-center">
                        <h1 class="mb-10">
                            <asp:Label runat="server" ID="lblTitle" /></h1>
                    </div>
                    <p>
                        <asp:Label runat="server" ID="lblTotal" />
                    </p>
                </div>
            </div>
        </div>
    </section>
    <%--End about-info Area--%>


    <section class="about-info-area">
        <div class="container">
            <div class="row align-items-center ">
                <div class="col-lg-12">
                    <div class="title text-center">
                        <h1 class="mb-10">United States</h1>
                    </div>
                    <div class="whole-wrap">
                        <div class="container">
                            <div class="section">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">


                                        <form runat="server">


                                            <div class="row" style="padding-left: 15px;">
                                                <asp:DataList ID="dlStates" runat="server" DataKeyField="MState" RepeatColumns="20" CellPadding="2" RepeatDirection="Vertical" OnEditCommand="View_Shelters" ItemStyle-Wrap="true" RepeatLayout="Table">
                                                    <FooterStyle Font-Size="11px" ForeColor="DimGray" />
                                                    <ItemTemplate>
                                                        <span class="">

                                                            <asp:LinkButton ID="btn1" runat="server" Text='<%# Container.DataItem("MState") %>'
                                                                CommandName="Edit" />
                                                            <sup style="font-size: 8px">(<%# Container.DataItem("StateCount") %>)</sup>
                                                        </span>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </div>

                                            <br />

                                            <div class="title text-center">
                                                <h1 class="mb-10">International</h1>
                                            </div>
                                            <div class="row" style="padding-left: 15px;">
                                            <asp:DataList ID="dlCountries" runat="server" DataKeyField="MCountry"  RepeatDirection="Horizontal" OnEditCommand="View_Shelters" CellPadding="4" ItemStyle-Wrap="true" RepeatLayout="Flow">

                                                <FooterStyle Font-Size="11px" ForeColor="DimGray" />
                                                <FooterTemplate>
                                                    <br>
                                                    <br>
                                                    There are <%# dlCountries.Items.Count.ToString() + 1%> Countries participating.<br>
                                                </FooterTemplate>
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="btn1" runat="server" Text='<%# Container.DataItem("MCountry") %>'
                                                        CommandName="Edit" />&nbsp;&nbsp;
                                                </ItemTemplate>
                                            </asp:DataList>
                                                </div>

                                            <h3>
                                                <asp:Label runat="server" ID="lblHeader" />
                                            </h3>

                                            <div class="row mt-10">
                                                    <div class="col-lg-6 col-md-6">
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                       Sort By: 
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                       <asp:DropDownList runat="server" ID="ddlSort" CssClass="single-input nice-select">
                                                        <asp:ListItem Selected="true" Text="Shelter Name" Value="Sheltername" />
                                                        <asp:ListItem Text="City" Value="MCity" />
                                                    </asp:DropDownList>
                                                    </div>
                                                </div>

                                            <div class="country ordered-list">
                                                <asp:Label runat="server" ID="lblShelters" />
                                            </div>
                                            &nbsp;
		  


                                        </form>

                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>

</asp:Content>
