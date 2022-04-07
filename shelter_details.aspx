<%@ Page Language="VB" MasterPageFile="~/template.master" Title=" Home 4 The Holidays" Debug="true" %>

<%@ Import Namespace="System.Security.Principal" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">

    Sub Page_load(obj As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            'look up shelter infor based upon querystring ShelterID
            If Request.QueryString("ShelterId") <> "" Then
                Dim db As New HWAC.DatabaseH4TH
                Dim objReader As SqlDataReader
                Dim StrSQL As String

                StrSQL = "SELECT  ShelterName, FName, LName, ContactPhone, MAddress, MCity, MState, MZip, MCountry, SAddress, SCity, SState, SZip, SCountry, ShelterPhone, Fax, Email, Website, ShowPublic, ShelterID, Facebook, Twitter, Blog, pintrest, youtube FROM  dbo.tblH4THReg WHERE (ShelterID=" & Request.QueryString("ShelterID") & ") AND Active=1"
                objReader = db.GetReader(StrSQL)
                If Not objReader Is Nothing Then 'has found data
                    With objReader
                        While .Read() 'fill labels
                            lblShelterName.Text = .Item("ShelterName")
                            If Mid(.Item("ShowPublic"), 1, 1) = "1" Then
                                lblShelterContact.Text = "Shelter Phone: " & .Item("ShelterPhone")
                            End If
                            If Mid(.Item("ShowPublic"), 3, 1) = "1" Then
                                lblShelterContact.Text &= "<br>Contact: " & .GetString(1) & " " & .GetString(2) & "<br>"
                            End If
                            If Mid(.Item("ShowPublic"), 4, 1) = "1" Then
                                lblShelterContact.Text &= "Contact Phone: " & .Item("ContactPhone")
                            End If
                            If Mid(.Item("ShowPublic"), 2, 1) = "1" Then
                                If .GetString(15) <> "" Then lblShelterContact.Text &= "<br>Fax:   " & .GetString(15)
                            End If
                            If Mid(.Item("ShowPublic"), 5, 1) = "1" Then
                                If .GetString(16) <> "" Then lblShelterContact.Text &= "<br><a href=mailto:" & .GetString(16) & ">Email</a>"
                            End If
                            If Mid(.Item("ShowPublic"), 6, 1) = "1" Then
                                lblShelterAddress.Text = "<strong>Physical</strong><br>" & .Item("SAddress") & "<br>" & .Item("SCity") & ", " & .Item("SState") & "  " & .Item("SZip")
                                If .GetString(8) <> "United States" Then lblShelterAddress.Text &= "  " & .GetString(8)
                                If .Item("SAddress") <> "" Then lblShelterAddress.Text &= "<br><a href=""http://www.maps.google.com/maps?complete=1&hl=en&q=" & .Item("SAddress") & "%20" & .Item("SCity") & "%20" & .Item("SState") & "%20" & .Item("SCountry") & "&sa=N&tab=wl"" target=""_blank"">Map</a>"
                            End If
                            If Mid(.Item("ShowPublic"), 7, 1) = "1" Then
                                lblShelterAddress.Text &= "<br><br><strong>Mailing</strong><br>" & .Item("MAddress") & "<br>" & .Item("MCity") & ", " & .Item("MState") & "  " & .Item("MZip")
                                If .GetString(8) <> "United States" Then lblShelterAddress.Text &= "  " & .GetString(8)
                            End If

                            If .GetString(17) <> "" Then lblShelterWebsite.Text &= "<br><a href=http://" & .GetString(17) & " target=""_blank"">Website</a> "
                            If .GetString(22) <> "" Then
                                lblShelterWebsite.Text &= " | <a href=http://" & .GetString(22) & " target=""_blank"">Blog</a><br>"
                            Else
                                lblShelterWebsite.Text &= "<br>"
                            End If
                            If .GetString(20) <> "" Then lblShelterWebsite.Text &= "<a href=http://" & .GetString(20) & " target=""_blank""><img src=""../_images/layout/3D-Icons-PNG/facebook.png"" alt=""facebook""  width=""25"" Height=""25"" vspace=""1""/></a>"
                            If .GetString(21) <> "" Then lblShelterWebsite.Text &= "<a href=http://" & .GetString(21) & " target=""_blank""><img src=""../_images/layout/3D-Icons-PNG/Twitter.png"" width=""25"" Height=""25"" vspace=""1""/></a>"

                            If .GetString(23) <> "" Then lblShelterWebsite.Text &= "<a href=http://" & .GetString(23) & " target=""_blank""><img src=""../_images/layout/3D-Icons-PNG/Pinterest.png"" width=""25"" Height=""25"" vspace=""1""/></a>"
                            If .GetString(24) <> "" Then lblShelterWebsite.Text &= "<a href=http://" & .GetString(24) & " target=""_blank""><img src=""../_images/layout/3D-Icons-PNG/YouTube.png""  alt=""youtube"" width=""25"" Height=""25""vspace=""1""/></a>"
                            lblDonate.Text = "<a href=""https://join.home4theholidays.org/donate.aspx?ShelterID=" & .Item("ShelterID") & "&ShelterName=" & .Item("ShelterName") & """ class=""genric-btn primary small round-border"">Donate To This Shelter</a>"
                        End While
                    End With
                Else ' did not find data
                    lblMessage.Text = "Shelter information not available. Please try again later. Thanks!"

                End If
            Else
                lblMessage.Text = "Shelter information not available. Please try again later. Thanks!"
            End If

            'open text file and put in description text
            If Not Page.IsPostBack Then
                'Open a file for reading
                Dim FILENAME As String = Server.MapPath("txtFiles/" & Request.QueryString("ShelterId") & "_Description.txt")
                Dim objFSO
                objFSO = Server.CreateObject("Scripting.FileSystemObject")
                If objFSO.FileExists(FILENAME) Then

                    'Get a StreamReader class that can be used to read the file
                    Dim objStreamReader As StreamReader
                    objStreamReader = File.OpenText(FILENAME)

                    'Now, read the entire file into a string
                    Dim contents As String = objStreamReader.ReadToEnd()

                    'Set the text of the file to a Web control
                    lblShelterDescription.Text = contents

                    'We may wish to replace carraige returns with <br>s
                    'lblNicerOutput.Text = contents.Replace(vbCrLf, "<br>")

                    objStreamReader.Close()
                End If
            End If
        End If



    End Sub




</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        <!--
        .style1 {
            color: #FFFFFF
        }
        -->
    </style>
</asp:Content>


<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/love-dog-boy-banner.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">Shelter Details
                    </h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a href="/Shelter_map.aspx">Participating Shelters</a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Shelter Details</a>
                    </p>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<%-- End banner Area --%>


<asp:Content ID="navigation" ContentPlaceHolderID="Leftnav" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="Server">


    <section class="contact-page-area section-gap mb-20">
        <div class="container">

            <div class="title text-center">
                <h1 class="mb-10">
                    <asp:Label runat="server" ForeColor="#0033FF" ID="lblShelterName" Font-Bold="true" /></h1>
            </div>

            <p>
                <asp:Label ID="lblMessage" Font-Bold="true" ForeColor="#FF0000" runat="server" />
            </p>

            <div class="row mt-30">

                <div class="col-lg-4 d-flex flex-column address-wrap">

                    <div class="single-contact-address d-flex flex-row">
                        <div class="icon">
                            <span class="lnr lnr-apartment"></span>
                        </div>
                        <div class="contact-details">
                            <h5>
                                <asp:Label runat="server" ID="lblShelterAddress" />
                            </h5>
                        </div>
                    </div>

                </div>
                <div class="col-lg-4 d-flex flex-column address-wrap">

                    <div class="single-contact-address d-flex flex-row">
                        <div class="icon">
                            <span class="lnr lnr-phone"></span>
                        </div>
                        <div class="contact-details">
                            <h5>
                                <asp:Label runat="server" ID="lblShelterContact" /></h5>
                        </div>
                    </div>
                </div>
                <div class="col-lg-4 d-flex flex-column address-wrap">

                    <div class="single-contact-address d-flex flex-row">
                        <div class="icon">
                            <span class="lnr lnr-earth"></span>
                        </div>
                        <div class="contact-details">
                            <h5>
                                <asp:Label runat="server" ID="lblShelterWebsite" />
                            </h5>
                        </div>
                    </div>

                </div>

            </div>

            <p>
                <asp:Label runat="server" ID="lblShelterDescription" />
            </p>

            <div class="title text-center mt-40">
                <asp:Label CssClass="donate_orange" ID="lblDonate" runat="server" Font-Bold="true" />
            </div>

        </div>
    </section>

</asp:Content>
