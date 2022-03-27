<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Member Profile- Home 4 The Holidays" ViewStateEncryptionMode="Never" Debug="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SQLClient" %>

<script runat="server">
    Sub Page_Load(obj As Object, e As EventArgs)
        If Session("UserId") = "" Then Response.Redirect("../login.aspx?ReturnURL=../home4theholidays/members/index.aspx")
        'Should always be member data, so get it with session id, and getreader class
        'populate fields
        If Not Page.IsPostBack Then 'load fields
            Dim db As New HWAC.DatabaseH4TH
            Dim objReader As SqlDataReader
            Dim StrSQL As String
            StrSQL = "SELECT  ShelterName, FName, LName, ContactPhone, MAddress, MCity, MState, MZip, MCountry, SAddress, SCity, SState, SZip, SCountry, ShelterPhone, Fax, Email, Website, ShowPublic, Facebook, Twitter, Blog, Lang, youtube, pintrest, capacity,Food_cat, Food_dog, Food_source, Vet, WhereVet, Animal_Focus, offsite_events, mobile_vehicle, work_with_retailers, which_retailers, want_adoption_retailer, pr_person, media_relations, place_ads, where_ads, want_marketing_retailer, attended_ACES, interested_ACES, IAMS_email_optin, participant_2012, Admin_Notes_2016, Admin_Notes_2017, Admin_Notes_2018,INPExNotes, Active, Completed, Calls, Resolution, ExecName, ExecTitle, Title FROM  dbo.tblH4THReg WHERE (ShelterID=" & Session("UserID") & ")"
            objReader = db.GetReader(StrSQL)
            If Not objReader Is Nothing Then 'has found data
                With objReader
                    While .Read() 'fill text boxes
                        tbOrg.Text = .GetString(0)
                        tbFName.Text = .GetString(1)
                        tbLName.Text = .GetString(2)
                        tbPhone.Text = .GetString(3)
                        tbMAddress.Text = .GetString(4)
                        tbMCity.Text = .GetString(5)
                        ddlMState.Items.FindByValue(.GetString(6)).Selected = True
                        tbMZip.Text = .GetString(7)
                        ddlMCountry.Items.Insert(0, New ListItem(.GetString(8), .GetString(8)))
                        tbSAddress.Text = .GetString(9)
                        tbSCity.Text = .GetString(10)
                        ddlSState.Items.FindByValue(.GetString(11)).Selected = True
                        tbSZip.Text = .GetString(12)
                        ddlSCountry.Items.Insert(0, New ListItem(.GetString(13), .GetString(13)))
                        tbOrgPhone.Text = .GetString(14)
                        tbFax.Text = .GetString(15)
                        tbEmail.Text = .GetString(16)
                        tbWebsite.Text = .GetString(17)
                        tbFax.Text = .GetString(15)
                        tbEmail.Text = .GetString(16)
                        tbWebsite.Text = .GetString(17)
                        tbYouTube.Text = .GetString(23)
                        tbPintrest.Text = .GetString(24)
                        tbFacebook.Text = .GetString(19)
                        tbTwitter.Text = .GetString(20)
                        tbBlog.Text = .GetString(21)
                        tbExecName.Text = .Item("ExecName") & ""
                        tbExecTitle.Text = .Item("ExecTitle") & ""
                        tbContactTitle.Text = .Item("Title") & ""
                        ddlLang.Items.Insert(0, New ListItem(.GetString(22), .GetString(22)))
                        'put check box values here .GetString(18)
                        If Mid(.GetString(18), 1, 1) = "1" Then chkOrgPhone.Checked = True
                        If Mid(.GetString(18), 2, 1) = "1" Then chkFax.Checked = True
                        If Mid(.GetString(18), 3, 1) = "1" Then chkName.Checked = True
                        If Mid(.GetString(18), 4, 1) = "1" Then chkContactPhone.Checked = True
                        If Mid(.GetString(18), 5, 1) = "1" Then chkEmail.Checked = True
                        If Mid(.GetString(18), 6, 1) = "1" Then chkShip.Checked = True
                        If Mid(.GetString(18), 7, 1) = "1" Then chkMail.Checked = True
                        If .GetString(25) <> "" Then ddlcapacity.Items.Insert(0, New ListItem(.GetString(25), .GetString(25)))
                        If .GetString(26) <> "" Then ddlFood_dog.Items.Insert(0, New ListItem(.GetString(26), .GetString(26)))
                        If .GetString(27) <> "" Then ddlFood_cat.Items.Insert(0, New ListItem(.GetString(27), .GetString(27)))
                        If .GetString(28) <> "" Then ddlFood_source.Items.Insert(0, New ListItem(.GetString(28), .GetString(28)))
                        If .GetString(29) <> "" Then ddlVet.Items.Insert(0, New ListItem(.GetString(29), .GetString(29)))
                        tbWhereVet.Text = .GetString(30)
                        'animal focus
                        If InStr(.GetString(31), "Dogs") > 0 Then chkDog.Checked = True
                        If InStr(.GetString(31), "Cats") > 0 Then chkCat.Checked = True
                        If InStr(.GetString(31), "Reptiles") > 0 Then chkReptile.Checked = True
                        If InStr(.GetString(31), "Other") > 0 Then chkOther.Checked = True

                        If .GetString(32) <> "" Then ddloffsite_events.Items.Insert(0, New ListItem(.GetString(32), .GetString(32)))
                        If .GetString(33) <> "" Then ddlmobile_vehicle.Items.Insert(0, New ListItem(.GetString(33), .GetString(33)))
                        If .GetString(34) <> "" Then ddlwork_with_retailers.Items.Insert(0, New ListItem(.GetString(34), .GetString(34)))
                        tbwhich_retailers.Text = .GetString(35)
                        If .GetString(36) <> "" Then ddlwant_adoption_retailer.Items.Insert(0, New ListItem(.GetString(36), .GetString(36)))
                        If .GetString(37) <> "" Then ddlpr_person.Items.Insert(0, New ListItem(.GetString(37), .GetString(37)))
                        If .GetString(38) <> "" Then ddlmedia_relations.Items.Insert(0, New ListItem(.GetString(38), .GetString(38)))
                        If .GetString(39) <> "" Then ddlplace_ads.Items.Insert(0, New ListItem(.GetString(39), .GetString(39)))
                        tbwhere_ads.Text = .GetString(40)
                        If .GetString(41) <> "" Then ddlwant_marketing_retailer.Items.Insert(0, New ListItem(.GetString(41), .GetString(41)))
                        If .GetString(42) <> "" Then ddlattended_ACES.Items.Insert(0, New ListItem(.GetString(42), .GetString(42)))
                        If .GetString(43) <> "" Then ddlinterested_ACES.Items.Insert(0, New ListItem(.GetString(43), .GetString(43)))
                        'if .item("Iams_email_optin")=true then chkIams_optin.checked=true
                        'if .item("participant_2012")=true then chkParticipant_2012.checked=true
                        tbAdmin_notes.Text = .Item("Admin_Notes_2016") & ""
                        tbAdmin_notes2017.Text = .Item("Admin_Notes_2017") & ""
                        tbAdmin_notes2018.Text = .Item("Admin_Notes_2018") & ""
                        tbINPExNotes.Text = .Item("INPExNotes") & ""
                        If .Item("Completed") = True Then chkcompleted.Checked = True
                        If .Item("Active") = True Then chkActive.Checked = True
                        'ddlCalls.Items.Insert(0, new ListItem(.item("calls"),.item("calls")))
                        'ddlResolution.Items.Insert(0, new ListItem(.item("resolution"),.item("resolution")))

                        'show admin fields if neccessary
                        If Session("Admin") = "@F@EWE$" Then
                            'show admin fields
                            pnlAdmin.Visible = True
                        End If
                    End While
                End With
            Else ' did not find data
                lblMessage.Text = "Account data not found. Please try again later. Thanks!"
                form1.Visible = False

            End If
        End If

    End Sub

    Sub btnUpdate_Click(obj As Object, e As EventArgs)
        'Update databaseH4TH h4th table with session, userid and fields 'call hwac.user.excecutenonquery
        Dim strResult As String
        Dim strSql As String
        Dim objUserDetails As New HWAC.UserDetails
        Dim db As New HWAC.DatabaseH4TH
        With objUserDetails
            'Contact Details---------
            .FName = Replace(tbFName.Text, "'", "''")
            .LName = Replace(tbLName.Text, "'", "''")
            .ContactPhone = Replace(tbPhone.Text, "'", "''")
            .Email = tbEmail.Text
            'Mailing Address----------
            .BAddress = Replace(tbMAddress.Text, "'", "''")
            .BCity = Replace(tbMCity.Text, "'", "''")
            .BState = ddlMState.SelectedItem.Value
            .BZip = Replace(tbMZip.Text, "'", "''")
            .BCountry = ddlMCountry.SelectedItem.Value
            'Shipping address-------------
            .SAddress = Replace(tbSAddress.Text, "'", "''")
            .SCity = Replace(tbSCity.Text, "'", "''")
            .SState = ddlSState.SelectedItem.Value
            .SZip = Replace(tbSZip.Text, "'", "''")
            .SCountry = ddlSCountry.SelectedItem.Value
            'Org Info---------------------
            .Website = Replace(tbWebsite.Text, "'", "''")
            .ShelterPhone = Replace(tbOrgPhone.Text, "'", "''")
            .Fax = Replace(tbFax.Text, "'", "''")
            .ShelterName = Replace(tbOrg.Text, "'", "''")
            .Facebook = Replace(tbFacebook.Text, "'", "''")
            .Twitter = Replace(tbTwitter.Text, "'", "''")
            .Blog = Replace(tbBlog.Text, "'", "''")
            Session("ShelterName") = .ShelterName
            'showpublic values-----------------------
            Dim strShowPublic As String = "0000000"
            If chkOrgPhone.Checked = True Then mid(strShowPublic, 1, 1) = "1"
            If chkFax.Checked = True Then mid(strShowPublic, 2, 1) = "1"
            If chkName.Checked = True Then mid(strShowPublic, 3, 1) = "1"
            If chkContactPhone.Checked = True Then mid(strShowPublic, 4, 1) = "1"
            If chkEmail.Checked = True Then mid(strShowPublic, 5, 1) = "1"
            If chkShip.Checked = True Then mid(strShowPublic, 6, 1) = "1"
            If chkMail.Checked = True Then mid(strShowPublic, 7, 1) = "1"

            Dim Animal_Focus As String = "" 'build animal focus text
            If chkDog.Checked Then Animal_Focus = "Dogs|"
            If chkCat.Checked Then Animal_Focus &= "Cats|"
            If chkReptile.Checked Then Animal_Focus &= "Reptiles|"
            If chkOther.Checked Then Animal_Focus &= "Other|"
            If Animal_Focus <> "" Then Animal_Focus = Left(Animal_Focus, Len(Animal_Focus) - 1)
            Dim AdminNotes As String
            If Session("Admin") = "@F@EWE$" Then
                AdminNotes = Replace(tbAdmin_notes.Text, "'", "''") & "-profile edited by staff:" & DateTime.Now.ToString()
            Else
                AdminNotes = Replace(tbAdmin_notes.Text, "'", "''") & "-profile edited by client:" & DateTime.Now.ToString()
            End If
            Dim AdminNotes2 As String
            If Not Right(tbINPExNotes.Text, 8) = "INPEx | " Then 'new data in text box
                AdminNotes2 = Replace(tbINPExNotes.Text, "'", "''") & " -- " & DateTime.Now.ToString() & " -edited by INPEx | "
            Else
                AdminNotes2 = Replace(tbINPExNotes.Text, "'", "''")
            End If
            Dim AdminNotes3 As String
            If Not Right(tbAdmin_notes2017.Text, 8) = "Staff | " And Not tbAdmin_notes2017.Text = "" Then 'new data in text box
                AdminNotes3 = Replace(tbAdmin_notes2017.Text, "'", "''") & " -- " & DateTime.Now.ToString() & " -edited by Staff | "
            Else
                AdminNotes3 = Replace(tbAdmin_notes2017.Text, "'", "''")
            End If
            Dim AdminNotes4 As String
            If Not Right(tbAdmin_notes2018.Text, 8) = "Staff | " And Not tbAdmin_notes2018.Text = "" Then 'new data in text box
                AdminNotes4 = Replace(tbAdmin_notes2018.Text, "'", "''") & " -- " & DateTime.Now.ToString() & " -edited by Staff | "
            Else
                AdminNotes4 = Replace(tbAdmin_notes2018.Text, "'", "''")
            End If

            strSql = "UPDATE tblH4thReg Set FName='" & .FName & "', LName='" & .LName & "', ContactPhone='" & .ContactPhone & "', Email='" & .Email & "', MAddress='" & .BAddress & "', MCity='" & .BCity & "', MState='" & .BState & "', MZip='" & .BZip & "', MCountry='" & .BCountry & "', SAddress='" & .SAddress & "', SCity='" & .SCity & "', SState='" & .SState & "', SZip='" & .SZip & "', SCountry='" & .SCountry & "', Website='" & .Website & "', ShelterPhone='" & .ShelterPhone & "', Fax='" & .Fax & "', ShelterName='" & .ShelterName & "', ShowPublic='" & strShowPublic & "', Edited='" & Now.ToString() & "', Facebook='" & .Facebook & "', Twitter='" & .Twitter & "', Blog='" & .Blog & "', Lang='" & ddlLang.SelectedItem.Value & "', youtube='" & tbYouTube.Text & "', pintrest='" & tbPintrest.Text & "', capacity='" & ddlcapacity.SelectedItem.Value & "', Food_cat='" & ddlFood_cat.SelectedItem.Value & "', Food_dog='" & ddlFood_dog.SelectedItem.Value & "', Food_source='" & ddlFood_source.SelectedItem.Value & "', Vet='" & ddlVet.SelectedItem.Value & "', WhereVet='" & tbWhereVet.Text & "', Animal_Focus='" & Animal_Focus & "', offsite_events='" & ddloffsite_events.SelectedItem.Value & "', mobile_vehicle='" & ddlmobile_vehicle.SelectedItem.Value & "', work_with_retailers='" & ddlwork_with_retailers.SelectedItem.Value & "', which_retailers='" & Replace(tbwhich_retailers.Text, "'", "''") & "', want_adoption_retailer='" & ddlwant_adoption_retailer.SelectedItem.Value & "', pr_person='" & ddlpr_person.SelectedItem.Value & "', media_relations='" & ddlmedia_relations.SelectedItem.Value & "', place_ads='" & ddlplace_ads.SelectedItem.Value & "', where_ads='" & Replace(tbwhere_ads.Text, "'", "''") & "', want_marketing_retailer='" & ddlwant_marketing_retailer.SelectedItem.Value & "', attended_ACES='" & ddlattended_ACES.SelectedItem.Value & "', interested_ACES='" & ddlinterested_ACES.SelectedItem.Value & "', IAMS_email_optin=" & IIf(chkIams_optin.Checked, "1", "0") & ", participant_2012=" & IIf(chkParticipant_2012.Checked, "1", "0") & ", Admin_Notes_2017='" & AdminNotes3 & "', Admin_Notes_2018='" & AdminNotes4 & "', Completed=" & IIf(chkcompleted.Checked, "1", "0") & ", Active=" & IIf(chkActive.Checked, "1", "0") & ", Calls='" & ddlCalls.SelectedItem.Value & "', Resolution='" & ddlResolution.SelectedItem.Value & "', ExecName='" & tbExecName.Text & "', ExecTitle='" & tbExecTitle.Text & "', Title='" & tbContactTitle.Text & "' WHERE ShelterID=" & Session("UserID")
        End With
        'lblmessage.text=strSQL
        'exit sub
        If db.ExecuteNonQuery(strSql) Then 'successful
            lblMessage.Text = "Profile updated!  <a href=""../shelter_details.aspx?ShelterID=" & Session("UserId") & """ target=""_blank"">View Profile</a>"
            form1.Visible = False
            'email userid to me so that I can approve it
            Dim objMM As New HWAC.EmailMessage
            With objMM
                .MailTo = "lonjones1972@gmail.com"
                .From = "Home 4 The Holidays <h4th@animalcenter.org>"
                .Subject = "H4TH Profile Edit"
                .Body = Session("ShelterName") & ", UserID:" & Session("UserID") & " has edited their profile<br><br>"
            End With
            With objUserDetails
                objMM.Body &= .FName & "<br>" & .LName & "<br>" & .ContactPhone & "<br>" & .Email & "<br>" & .BAddress & "<br>" & .BCity & "<br>" & .BState & "<br>" & .BZip & "<br>" & .BCountry & "<br>" & .SAddress & "<br>" & .SCity & "<br>" & .SState & "<br>" & .SZip & "<br>" & .SCountry & "<br>" & .Website & "<br>" & .ShelterPhone & "<br>" & .Fax & "<br>" & .ShelterName & "<br>" & .Facebook & "<br>" & .Twitter & "<br>" & .Blog & "<br>" & ddlLang.SelectedItem.Value & "<br>" & Request.ServerVariables("REMOTE_ADDR")
            End With
            objMM.Send_Email(objMM)
        Else
            lblMessage.Text = strSql
        End If
    End Sub


</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <%--<link rel="stylesheet" href="../_css/thickbox.css" type="text/css" media="screen" />
<link href="../_css/style2.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style2 {
	margin-left:10px;
	color: #FFFFFF; 
	font-weight: bold; 
 }
-->
</style>--%>
</asp:Content>


<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/family-with-dog-porch-banner-2.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">Member Profile
                    </h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Member Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Member Profile</a>
                    </p>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<%-- End banner Area --%>



<asp:Content ID="navigation" ContentPlaceHolderID="Leftnav" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="Server">

    <section class="about-info-area">
        <div class="container">
            <div class="row align-items-center ">
                <div class="col-lg-12">
                    <div class="title text-center">
                        <h1 class="mb-10">Edit your profile</h1>
                    </div>
                    <p>
                        <asp:Label ID="lblMessage" Font-Bold="true" ForeColor="#FF0000" runat="server" />
                    </p>
                    <p>Check the boxes next to the information you wish to display to the public</p>
                    <div class="whole-wrap mb-20">
                        <div class="container">
                            <div class="section">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">


                                        <form runat="server" id="form1">

                                            <asp:ValidationSummary runat="server" ShowMessageBox="true" ShowSummary="false" ID="VSum" HeaderText="Please fill out all the required fields appropriately" />
                                            <asp:Panel ID="pnlRegister" runat="server"></asp:Panel>

                                            <div class="section-top-border">
                                                <h3 class="mb-10">Organization Information</h3>

                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        *Organization Name:
                                                    </div>
                                                    <div class="col-lg-9 col-md-9">
                                                        <asp:TextBox ID="tbOrg" runat="server" MaxLength="100" CssClass="single-input" placeholder="Organization Name" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbOrg" CssClass="errorMsg" ErrorMessage="*Organization name required" Display="Dynamic" runat="server" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        <asp:CheckBox ID="chkOrgPhone" runat="server" />
                                                        *Phone Number:
                                                    </div>
                                                    <div class="col-lg-3 col-md-3">
                                                        <asp:TextBox ID="tbOrgPhone" runat="server" MaxLength="20" CssClass="single-input" placeholder="Phone Number" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbOrgPhone" CssClass="errorMsg" ErrorMessage="*Phone number required" Display="Dynamic" runat="server" />
                                                    </div>

                                                    <div class="col-lg-3 col-md-3">
                                                        <asp:CheckBox ID="chkFax" runat="server" />
                                                        Fax Number:
                                                    </div>
                                                    <div class="col-lg-3 col-md-3">
                                                        <asp:TextBox ID="tbFax" runat="server" MaxLength="20" CssClass="single-input" placeholder="Fax Number" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        Website Address:
                                                    </div>
                                                    <div class="col-lg-9 col-md-9">
                                                        <asp:TextBox runat="server" ID="tbWebsite" MaxLength="50" CssClass="single-input" placeholder="i.e., www.yourshelter.com" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        Facebook Link:
                                                    </div>
                                                    <div class="col-lg-9 col-md-9">
                                                        <asp:TextBox runat="server" ID="tbFacebook" MaxLength="250" CssClass="single-input" placeholder="i.e., www.facebook.com/YourOrganizationName" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        Twitter Link:
                                                    </div>
                                                    <div class="col-lg-9 col-md-9">
                                                        <asp:TextBox runat="server" ID="tbTwitter" MaxLength="250" CssClass="single-input" placeholder="i.e.,  www.twitter.com/YourOrganizationName" />
                                                    </div>
                                                </div>


                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        Pinterest Link:
                                                    </div>
                                                    <div class="col-lg-9 col-md-9">
                                                        <asp:TextBox runat="server" ID="tbPintrest" MaxLength="250" CssClass="single-input" placeholder="Pinterest Link" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        Youtube Channel:
                                                    </div>
                                                    <div class="col-lg-9 col-md-9">
                                                        <asp:TextBox runat="server" ID="tbYouTube" MaxLength="250" CssClass="single-input" placeholder="i.e., www.youtube.com.com/user/YourOrg" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        Blog Link:
                                                    </div>
                                                    <div class="col-lg-9 col-md-9">
                                                        <asp:TextBox runat="server" ID="tbBlog" MaxLength="250" CssClass="single-input" placeholder="i.e., www.YourBlog.com" />
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="section-top-border">
                                                <div class="mb-10">
                                                    <h3 class="mb-10" style="display: inline;">Head of Organization</h3>
                                                    <h5 style="display: inline;">(President/Executive Director):</h5>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        Name:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox runat="server" ID="tbExecName" MaxLength="50" CssClass="single-input" placeholder="Name" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        Title:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox runat="server" ID="tbExecTitle" MaxLength="20" CssClass="single-input" placeholder="Title" />
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="section-top-border">

                                                <h3 class="mb-10">Organization H4TH Contact Person</h3>

                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        <asp:CheckBox ID="chkName" runat="server" />
                                                        *First Name:
                                                    </div>
                                                    <div class="col-lg-3 col-md-3">
                                                        <asp:TextBox ID="tbFName" runat="server" MaxLength="20" CssClass="single-input" placeholder="First Name" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbFName" CssClass="errorMsg" ErrorMessage="*First name required" Display="Dynamic" runat="server" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        *Last Name:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox ID="tbLName" runat="server" MaxLength="20" CssClass="single-input" placeholder="Last Name" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbLName" CssClass="errorMsg" ErrorMessage="*Last name required" Display="Dynamic" runat="server" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        <asp:CheckBox ID="chkContactPhone" runat="server" />
                                                        *Phone:
                                                    </div>
                                                    <div class="col-lg-3 col-md-3">
                                                        <asp:TextBox ID="tbPhone" runat="server" MaxLength="20" CssClass="single-input" placeholder="Phone" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbPhone" CssClass="errorMsg" ErrorMessage="*Phone required" Display="Dynamic" runat="server" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        Title:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox ID="tbContactTitle" runat="server" MaxLength="20" CssClass="single-input" placeholder="Title" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        Language Preference:
                                                    </div>
                                                    <div class="col-lg-3 col-md-3">
                                                        <asp:DropDownList runat="server" ID="ddlLang" CssClass="single-input nice-select">
                                                            <asp:ListItem Value="English" Text="English" />
                                                            <asp:ListItem Value="French" Text="French" />
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        <asp:CheckBox ID="chkEmail" runat="server" />
                                                        *Email Address:
                                                    </div>
                                                    <div class="col-lg-9 col-md-9">
                                                        <asp:TextBox ID="tbEmail" runat="server" MaxLength="100" CssClass="single-input" placeholder="Email Address" />
                                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="tbEmail" CssClass="errorMsg" ErrorMessage="*Email is required" Display="Dynamic" />
                                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="tbEmail"
                                                            ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"
                                                            ErrorMessage="*That is not a valid email"
                                                            Display="dynamic" />
                                                    </div>
                                                </div>


                                            </div>

                                            <div class="section-top-border">

                                                <h3 class="mb-10">Shipping Address</h3>

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        <asp:CheckBox ID="chkShip" runat="server" />
                                                        *Address:
                                                    </div>
                                                    <div class="col-lg-10 col-md-10">
                                                        <asp:TextBox ID="tbSAddress" runat="server" MaxLength="50" CssClass="single-input" placeholder="Shipping Address" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbSAddress" CssClass="errorMsg" ErrorMessage="*Shipping address required" Display="Dynamic" runat="server" />
                                                    </div>
                                                </div>
                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        *City:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox ID="tbSCity" runat="server" MaxLength="20" CssClass="single-input" placeholder="City" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbSCity" CssClass="errorMsg" ErrorMessage="*City required" Display="Dynamic" runat="server" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        *State/Province:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:DropDownList runat="server" ID="ddlSState" CssClass="single-input dropdown-scrollable nice-select">
                                                            <asp:ListItem Value="" Text="Choose a State" />
                                                            <asp:ListItem Value="AK" Text="AK" />
                                                            <asp:ListItem Value="AL" Text="AL" />
                                                            <asp:ListItem Value="AR" Text="AR" />
                                                            <asp:ListItem Value="AZ" Text="AZ" />
                                                            <asp:ListItem Value="CA" Text="CA" />
                                                            <asp:ListItem Value="CO" Text="CO" />
                                                            <asp:ListItem Value="CT" Text="CT" />
                                                            <asp:ListItem Value="DC" Text="DC" />
                                                            <asp:ListItem Value="DE" Text="DE" />
                                                            <asp:ListItem Value="FL" Text="FL" />
                                                            <asp:ListItem Value="GA" Text="GA" />
                                                            <asp:ListItem Value="HI" Text="HI" />
                                                            <asp:ListItem Value="IA" Text="IA" />
                                                            <asp:ListItem Value="ID" Text="ID" />
                                                            <asp:ListItem Value="IL" Text="IL" />
                                                            <asp:ListItem Value="IN" Text="IN" />
                                                            <asp:ListItem Value="KS" Text="KS" />
                                                            <asp:ListItem Value="KY" Text="KY" />
                                                            <asp:ListItem Value="LA" Text="LA" />
                                                            <asp:ListItem Value="MA" Text="MA" />
                                                            <asp:ListItem Value="MD" Text="MD" />
                                                            <asp:ListItem Value="ME" Text="ME" />
                                                            <asp:ListItem Value="MI" Text="MI" />
                                                            <asp:ListItem Value="MN" Text="MN" />
                                                            <asp:ListItem Value="MO" Text="MO" />
                                                            <asp:ListItem Value="MS" Text="MS" />
                                                            <asp:ListItem Value="MT" Text="MT" />
                                                            <asp:ListItem Value="NC" Text="NC" />
                                                            <asp:ListItem Value="ND" Text="ND" />
                                                            <asp:ListItem Value="NE" Text="NE" />
                                                            <asp:ListItem Value="NH" Text="NH" />
                                                            <asp:ListItem Value="NJ" Text="NJ" />
                                                            <asp:ListItem Value="NM" Text="NM" />
                                                            <asp:ListItem Value="NV" Text="NV" />
                                                            <asp:ListItem Value="NY" Text="NY" />
                                                            <asp:ListItem Value="OH" Text="OH" />
                                                            <asp:ListItem Value="OK" Text="OK" />
                                                            <asp:ListItem Value="OR" Text="OR" />
                                                            <asp:ListItem Value="PA" Text="PA" />
                                                            <asp:ListItem Value="RI" Text="RI" />
                                                            <asp:ListItem Value="SC" Text="SC" />
                                                            <asp:ListItem Value="SD" Text="SD" />
                                                            <asp:ListItem Value="TN" Text="TN" />
                                                            <asp:ListItem Value="TX" Text="TX" />
                                                            <asp:ListItem Value="UT" Text="UT" />
                                                            <asp:ListItem Value="VA" Text="VA" />
                                                            <asp:ListItem Value="VT" Text="VT" />
                                                            <asp:ListItem Value="WA" Text="WA" />
                                                            <asp:ListItem Value="WI" Text="WI" />
                                                            <asp:ListItem Value="WV" Text="WV" />
                                                            <asp:ListItem Value="WY" Text="WY" />
                                                            <asp:ListItem Value="" Text="_____________" />
                                                            <asp:ListItem Text="US Territories" Value="" />
                                                            <asp:ListItem Value="" Text=" " />
                                                            <asp:ListItem Value="AS" Text="AS" />
                                                            <asp:ListItem Value="FM" Text="FM" />
                                                            <asp:ListItem Value="GU" Text="GU" />
                                                            <asp:ListItem Value="MH" Text="MH" />
                                                            <asp:ListItem Value="MP" Text="MP" />
                                                            <asp:ListItem Value="PR" Text="PR" />
                                                            <asp:ListItem Value="PW" Text="PW" />
                                                            <asp:ListItem Value="VI" Text="VI" />
                                                            <asp:ListItem Value="" Text="_____________" />
                                                            <asp:ListItem Text="US Military" Value="" />
                                                            <asp:ListItem Value="" Text=" " />
                                                            <asp:ListItem Value="AA" Text="AA" />
                                                            <asp:ListItem Value="AE" Text="AE" />
                                                            <asp:ListItem Value="AP" Text="AP" />
                                                            <asp:ListItem Value="" Text="_____________" />
                                                            <asp:ListItem Text="Canada" Value="" />
                                                            <asp:ListItem Value="" Text=" " />
                                                            <asp:ListItem Value="AB" Text="AB" />
                                                            <asp:ListItem Value="BC" Text="BC" />
                                                            <asp:ListItem Value="MB" Text="MB" />
                                                            <asp:ListItem Value="NB" Text="NB" />
                                                            <asp:ListItem Value="NL" Text="NL" />
                                                            <asp:ListItem Value="NS" Text="NS" />
                                                            <asp:ListItem Value="NT" Text="NT" />
                                                            <asp:ListItem Value="NU" Text="NU" />
                                                            <asp:ListItem Value="ON" Text="ON" />
                                                            <asp:ListItem Value="PE" Text="PE" />
                                                            <asp:ListItem Value="QC" Text="QC" />
                                                            <asp:ListItem Value="SK" Text="SK" />
                                                            <asp:ListItem Value="YT" Text="YT" />
                                                            <asp:ListItem Value="" Text="_____________" />
                                                            <asp:ListItem Text="Other Countries" Value="" />
                                                            <asp:ListItem Value="" Text=" " />
                                                            <asp:ListItem Value="None" Text="None" />
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="req_SState" CssClass="errorMsg" ControlToValidate="ddlSState" ErrorMessage="*State is required. Select None if State does not apply to you" runat="server" Display="Dynamic" />

                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        *Zip Code:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox ID="tbSZip" runat="server" MaxLength="15" CssClass="single-input" placeholder="Zip Code" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        *Country:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:DropDownList ID="ddlSCountry" runat="server" CssClass="single-input dropdown-scrollable nice-select">
                                                            <asp:ListItem Text="United States" />
                                                            <asp:ListItem Text="Canada" />
                                                            <asp:ListItem Text="Mexico" />
                                                            <asp:ListItem Text="Afghanistan" />
                                                            <asp:ListItem Text="Albania" />
                                                            <asp:ListItem Text="Algeria" />
                                                            <asp:ListItem Text="American Samoa" />
                                                            <asp:ListItem Text="Andorra" />
                                                            <asp:ListItem Text="Angola" />
                                                            <asp:ListItem Text="Anguilla" />
                                                            <asp:ListItem Text="Antarctica" />
                                                            <asp:ListItem Text="Antigua and Barbuda" />
                                                            <asp:ListItem Text="Argentina" />
                                                            <asp:ListItem Text="Armenia" />
                                                            <asp:ListItem Text="Aruba" />
                                                            <asp:ListItem Text="Australia" />
                                                            <asp:ListItem Text="Austria" />
                                                            <asp:ListItem Text="Azerbaijan" />
                                                            <asp:ListItem Text="Bahamas" />
                                                            <asp:ListItem Text="Bahrain" />
                                                            <asp:ListItem Text="Bangladesh" />
                                                            <asp:ListItem Text="Barbados" />
                                                            <asp:ListItem Text="Belarus" />
                                                            <asp:ListItem Text="Belgium" />
                                                            <asp:ListItem Text="Belize" />
                                                            <asp:ListItem Text="Benin" />
                                                            <asp:ListItem Text="Bermuda" />
                                                            <asp:ListItem Text="Bhutan" />
                                                            <asp:ListItem Text="Bolivia" />
                                                            <asp:ListItem Text="Bosnia-Herzegovina" />
                                                            <asp:ListItem Text="Botswana" />
                                                            <asp:ListItem Text="Bouvet Island" />
                                                            <asp:ListItem Text="Brazil" />
                                                            <asp:ListItem Text="British Indian Ocean Territory" />
                                                            <asp:ListItem Text="Brunei" />
                                                            <asp:ListItem Text="Bulgaria" />
                                                            <asp:ListItem Text="Burkina Faso" />
                                                            <asp:ListItem Text="Burundi" />
                                                            <asp:ListItem Text="Cambodia" />
                                                            <asp:ListItem Text="Cameroon" />
                                                            <asp:ListItem Text="Cape Verde" />
                                                            <asp:ListItem Text="Cayman Islands" />
                                                            <asp:ListItem Text="Central African Republic" />
                                                            <asp:ListItem Text="Chad" />
                                                            <asp:ListItem Text="Chile" />
                                                            <asp:ListItem Text="China" />
                                                            <asp:ListItem Text="Christmas Island" />
                                                            <asp:ListItem Text="Cocos (Keeling) Islands" />
                                                            <asp:ListItem Text="Colombia" />
                                                            <asp:ListItem Text="Comoros" />
                                                            <asp:ListItem Text="Congo" />
                                                            <asp:ListItem Text="Cook Islands" />
                                                            <asp:ListItem Text="Costa Rica" />
                                                            <asp:ListItem Text="Croatia" />
                                                            <asp:ListItem Text="Cuba" />
                                                            <asp:ListItem Text="Cyprus" />
                                                            <asp:ListItem Text="Czech Republic" />
                                                            <asp:ListItem Text="Denmark" />
                                                            <asp:ListItem Text="Djibouti" />
                                                            <asp:ListItem Text="Dominica" />
                                                            <asp:ListItem Text="Dominican Republic" />
                                                            <asp:ListItem Text="East Timor" />
                                                            <asp:ListItem Text="Ecuador" />
                                                            <asp:ListItem Text="Educational" />
                                                            <asp:ListItem Text="Egypt" />
                                                            <asp:ListItem Text="El Salvador" />
                                                            <asp:ListItem Text="Equatorial Guinea" />
                                                            <asp:ListItem Text="Eritrea" />
                                                            <asp:ListItem Text="Estonia" />
                                                            <asp:ListItem Text="Ethiopia" />
                                                            <asp:ListItem Text="Falkland Islands" />
                                                            <asp:ListItem Text="Faroe Islands" />
                                                            <asp:ListItem Text="Fiji" />
                                                            <asp:ListItem Text="Finland" />
                                                            <asp:ListItem Text="Former Czechoslovakia" />
                                                            <asp:ListItem Text="Former USSR" />
                                                            <asp:ListItem Text="France" />
                                                            <asp:ListItem Text="French Guyana" />
                                                            <asp:ListItem Text="French Southern Territories" />
                                                            <asp:ListItem Text="Gabon" />
                                                            <asp:ListItem Text="Gambia" />
                                                            <asp:ListItem Text="Georgia" />
                                                            <asp:ListItem Text="Germany" />
                                                            <asp:ListItem Text="Ghana" />
                                                            <asp:ListItem Text="Gibraltar" />
                                                            <asp:ListItem Text="Great Britain" />
                                                            <asp:ListItem Text="Greece" />
                                                            <asp:ListItem Text="Greenland" />
                                                            <asp:ListItem Text="Grenada" />
                                                            <asp:ListItem Text="Guadeloupe (French)" />
                                                            <asp:ListItem Text="Guam (USA)" />
                                                            <asp:ListItem Text="Guatemala" />
                                                            <asp:ListItem Text="Guinea" />
                                                            <asp:ListItem Text="Guinea-Bissau" />
                                                            <asp:ListItem Text="Guyana" />
                                                            <asp:ListItem Text="Haiti" />
                                                            <asp:ListItem Text="Heard and McDonald Islands" />
                                                            <asp:ListItem Text="Holy See (Vatican City State)" />
                                                            <asp:ListItem Text="Honduras" />
                                                            <asp:ListItem Text="Hungary" />
                                                            <asp:ListItem Text="Iceland" />
                                                            <asp:ListItem Text="India" />
                                                            <asp:ListItem Text="Indonesia" />
                                                            <asp:ListItem Text="Iran" />
                                                            <asp:ListItem Text="Iraq" />
                                                            <asp:ListItem Text="Ireland" />
                                                            <asp:ListItem Text="Israel" />
                                                            <asp:ListItem Text="Italy" />
                                                            <asp:ListItem Text="Ivory Coast (Cote D'Ivoire)" />
                                                            <asp:ListItem Text="Jamaica" />
                                                            <asp:ListItem Text="Japan" />
                                                            <asp:ListItem Text="Jordan" />
                                                            <asp:ListItem Text="Kazakhstan" />
                                                            <asp:ListItem Text="Kenya" />
                                                            <asp:ListItem Text="Kiribati" />
                                                            <asp:ListItem Text="Kuwait" />
                                                            <asp:ListItem Text="Kyrgyz Republic (Kyrgyzstan)" />
                                                            <asp:ListItem Text="Laos" />
                                                            <asp:ListItem Text="Latvia" />
                                                            <asp:ListItem Text="Lebanon" />
                                                            <asp:ListItem Text="Lesotho" />
                                                            <asp:ListItem Text="Liberia" />
                                                            <asp:ListItem Text="Libya" />
                                                            <asp:ListItem Text="Liechtenstein" />
                                                            <asp:ListItem Text="Lithuania" />
                                                            <asp:ListItem Text="Luxembourg" />
                                                            <asp:ListItem Text="Macau" />
                                                            <asp:ListItem Text="Macedonia" />
                                                            <asp:ListItem Text="Madagascar" />
                                                            <asp:ListItem Text="Malawi" />
                                                            <asp:ListItem Text="Malaysia" />
                                                            <asp:ListItem Text="Maldives" />
                                                            <asp:ListItem Text="Mali" />
                                                            <asp:ListItem Text="Malta" />
                                                            <asp:ListItem Text="Marshall Islands" />
                                                            <asp:ListItem Text="Martinique (French)" />
                                                            <asp:ListItem Text="Mauritania" />
                                                            <asp:ListItem Text="Mauritius" />
                                                            <asp:ListItem Text="Mayotte" />
                                                            <asp:ListItem Text="Micronesia" />
                                                            <asp:ListItem Text="Moldavia" />
                                                            <asp:ListItem Text="Monaco" />
                                                            <asp:ListItem Text="Mongolia" />
                                                            <asp:ListItem Text="Montserrat" />
                                                            <asp:ListItem Text="Morocco" />
                                                            <asp:ListItem Text="Mozambique" />
                                                            <asp:ListItem Text="Myanmar" />
                                                            <asp:ListItem Text="Namibia" />
                                                            <asp:ListItem Text="Nauru" />
                                                            <asp:ListItem Text="Nepal" />
                                                            <asp:ListItem Text="Netherlands" />
                                                            <asp:ListItem Text="Netherlands Antilles" />
                                                            <asp:ListItem Text="New Caledonia (French)" />
                                                            <asp:ListItem Text="New Zealand" />
                                                            <asp:ListItem Text="Nicaragua" />
                                                            <asp:ListItem Text="Niger" />
                                                            <asp:ListItem Text="Nigeria" />
                                                            <asp:ListItem Text="Niue" />
                                                            <asp:ListItem Text="Norfolk Island" />
                                                            <asp:ListItem Text="Northern Mariana Islands" />
                                                            <asp:ListItem Text="North Korea" />
                                                            <asp:ListItem Text="Norway" />
                                                            <asp:ListItem Text="Oman" />
                                                            <asp:ListItem Text="Pakistan" />
                                                            <asp:ListItem Text="Palau" />
                                                            <asp:ListItem Text="Panama" />
                                                            <asp:ListItem Text="Papua New Guinea" />
                                                            <asp:ListItem Text="Paraguay" />
                                                            <asp:ListItem Text="Peru" />
                                                            <asp:ListItem Text="Philippines" />
                                                            <asp:ListItem Text="Pitcairn Island" />
                                                            <asp:ListItem Text="Poland" />
                                                            <asp:ListItem Text="Polynesia (French)" />
                                                            <asp:ListItem Text="Portugal" />
                                                            <asp:ListItem Text="Puerto Rico" />
                                                            <asp:ListItem Text="Qatar" />
                                                            <asp:ListItem Text="Reunion (French)" />
                                                            <asp:ListItem Text="Romania" />
                                                            <asp:ListItem Text="Russian Federation" />
                                                            <asp:ListItem Text="Rwanda" />
                                                            <asp:ListItem Text="Saint Helena" />
                                                            <asp:ListItem Text="Saint Kitts &amp; Nevis Anguilla" />
                                                            <asp:ListItem Text="Saint Lucia" />
                                                            <asp:ListItem Text="Saint Pierre and Miquelon" />
                                                            <asp:ListItem Text="Saint Tome and Principe" />
                                                            <asp:ListItem Text="Saint Vincent &amp; Grenadines" />
                                                            <asp:ListItem Text="Samoa" />
                                                            <asp:ListItem Text="San Marino" />
                                                            <asp:ListItem Text="Saudi Arabia" />
                                                            <asp:ListItem Text="Senegal" />
                                                            <asp:ListItem Text="Seychelles" />
                                                            <asp:ListItem Text="S. Georgia &amp; S. Sandwich Isls." />
                                                            <asp:ListItem Text="Sierra Leone" />
                                                            <asp:ListItem Text="Singapore" />
                                                            <asp:ListItem Text="Slovak Republic" />
                                                            <asp:ListItem Text="Slovenia" />
                                                            <asp:ListItem Text="Solomon Islands" />
                                                            <asp:ListItem Text="Somalia" />
                                                            <asp:ListItem Text="South Africa" />
                                                            <asp:ListItem Text="South Korea" />
                                                            <asp:ListItem Text="Spain" />
                                                            <asp:ListItem Text="Sri Lanka" />
                                                            <asp:ListItem Text="Sudan" />
                                                            <asp:ListItem Text="Suriname" />
                                                            <asp:ListItem Text="Svalbard and Jan Mayen Islands" />
                                                            <asp:ListItem Text="Swaziland" />
                                                            <asp:ListItem Text="Sweden" />
                                                            <asp:ListItem Text="Switzerland" />
                                                            <asp:ListItem Text="Syria" />
                                                            <asp:ListItem Text="Tadjikistan" />
                                                            <asp:ListItem Text="Taiwan" />
                                                            <asp:ListItem Text="Tanzania" />
                                                            <asp:ListItem Text="Thailand" />
                                                            <asp:ListItem Text="Togo" />
                                                            <asp:ListItem Text="Tokelau" />
                                                            <asp:ListItem Text="Tonga" />
                                                            <asp:ListItem Text="Trinidad and Tobago" />
                                                            <asp:ListItem Text="Tunisia" />
                                                            <asp:ListItem Text="Turkey" />
                                                            <asp:ListItem Text="Turkmenistan" />
                                                            <asp:ListItem Text="Turks and Caicos Islands" />
                                                            <asp:ListItem Text="Tuvalu" />
                                                            <asp:ListItem Text="Uganda" />
                                                            <asp:ListItem Text="Ukraine" />
                                                            <asp:ListItem Text="United Arab Emirates" />
                                                            <asp:ListItem Text="United Kingdom" />
                                                            <asp:ListItem Text="Uruguay" />
                                                            <asp:ListItem Text="USA Minor Outlying Islands" />
                                                            <asp:ListItem Text="Uzbekistan" />
                                                            <asp:ListItem Text="Vanuatu" />
                                                            <asp:ListItem Text="Venezuela" />
                                                            <asp:ListItem Text="Vietnam" />
                                                            <asp:ListItem Text="Virgin Islands (British)" />
                                                            <asp:ListItem Text="Virgin Islands (USA)" />
                                                            <asp:ListItem Text="Wallis and Futuna Islands" />
                                                            <asp:ListItem Text="Western Sahara" />
                                                            <asp:ListItem Text="Yemen" />
                                                            <asp:ListItem Text="Yugoslavia" />
                                                            <asp:ListItem Text="Zaire" />
                                                            <asp:ListItem Text="Zambia" />
                                                            <asp:ListItem Text="Zimbabwe" />
                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator ID="req_SCountry" CssClass="errorMsg" ControlToValidate="ddlSCountry" ErrorMessage="*Country is required" runat="server" Display="Dynamic" />

                                                    </div>
                                                </div>

                                            </div>

                                            <asp:Panel runat="server" ID="pnlMailing" Visible="false">
                                                <div class="section-top-border">
                                                    <h3 class="mb-10">Mailing Address</h3>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-2 col-md-2">
                                                            <asp:CheckBox ID="chkMail" runat="server" />
                                                            *Address:
                                                        </div>
                                                        <div class="col-lg-10 col-md-10">
                                                            <asp:TextBox ID="tbMAddress" runat="server" MaxLength="50" CssClass="single-input" placeholder="Address" />
                                                            <asp:RequiredFieldValidator ControlToValidate="tbMAddress" CssClass="errorMsg" ErrorMessage="*Mailing address required" Display="Dynamic" runat="server" />
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-2 col-md-2">
                                                            *City:
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:TextBox ID="tbMCity" runat="server" MaxLength="20" CssClass="single-input" placeholder="City" />
                                                            <asp:RequiredFieldValidator ControlToValidate="tbMCity" CssClass="errorMsg" ErrorMessage="*City required" Display="Dynamic" runat="server" />
                                                        </div>
                                                        <div class="col-lg-2 col-md-2">
                                                            *State/Province:
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlMState" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="Choose a State" />
                                                                <asp:ListItem Value="AK" Text="AK" />
                                                                <asp:ListItem Value="AL" Text="AL" />
                                                                <asp:ListItem Value="AR" Text="AR" />
                                                                <asp:ListItem Value="AZ" Text="AZ" />
                                                                <asp:ListItem Value="CA" Text="CA" />
                                                                <asp:ListItem Value="CO" Text="CO" />
                                                                <asp:ListItem Value="CT" Text="CT" />
                                                                <asp:ListItem Value="DC" Text="DC" />
                                                                <asp:ListItem Value="DE" Text="DE" />
                                                                <asp:ListItem Value="FL" Text="FL" />
                                                                <asp:ListItem Value="GA" Text="GA" />
                                                                <asp:ListItem Value="HI" Text="HI" />
                                                                <asp:ListItem Value="IA" Text="IA" />
                                                                <asp:ListItem Value="ID" Text="ID" />
                                                                <asp:ListItem Value="IL" Text="IL" />
                                                                <asp:ListItem Value="IN" Text="IN" />
                                                                <asp:ListItem Value="KS" Text="KS" />
                                                                <asp:ListItem Value="KY" Text="KY" />
                                                                <asp:ListItem Value="LA" Text="LA" />
                                                                <asp:ListItem Value="MA" Text="MA" />
                                                                <asp:ListItem Value="MD" Text="MD" />
                                                                <asp:ListItem Value="ME" Text="ME" />
                                                                <asp:ListItem Value="MI" Text="MI" />
                                                                <asp:ListItem Value="MN" Text="MN" />
                                                                <asp:ListItem Value="MO" Text="MO" />
                                                                <asp:ListItem Value="MS" Text="MS" />
                                                                <asp:ListItem Value="MT" Text="MT" />
                                                                <asp:ListItem Value="NC" Text="NC" />
                                                                <asp:ListItem Value="ND" Text="ND" />
                                                                <asp:ListItem Value="NE" Text="NE" />
                                                                <asp:ListItem Value="NH" Text="NH" />
                                                                <asp:ListItem Value="NJ" Text="NJ" />
                                                                <asp:ListItem Value="NM" Text="NM" />
                                                                <asp:ListItem Value="NV" Text="NV" />
                                                                <asp:ListItem Value="NY" Text="NY" />
                                                                <asp:ListItem Value="OH" Text="OH" />
                                                                <asp:ListItem Value="OK" Text="OK" />
                                                                <asp:ListItem Value="OR" Text="OR" />
                                                                <asp:ListItem Value="PA" Text="PA" />
                                                                <asp:ListItem Value="RI" Text="RI" />
                                                                <asp:ListItem Value="SC" Text="SC" />
                                                                <asp:ListItem Value="SD" Text="SD" />
                                                                <asp:ListItem Value="TN" Text="TN" />
                                                                <asp:ListItem Value="TX" Text="TX" />
                                                                <asp:ListItem Value="UT" Text="UT" />
                                                                <asp:ListItem Value="VA" Text="VA" />
                                                                <asp:ListItem Value="VT" Text="VT" />
                                                                <asp:ListItem Value="WA" Text="WA" />
                                                                <asp:ListItem Value="WI" Text="WI" />
                                                                <asp:ListItem Value="WV" Text="WV" />
                                                                <asp:ListItem Value="WY" Text="WY" />
                                                                <asp:ListItem Value="" Text="_____________" />
                                                                <asp:ListItem Text="US Territories" Value="" />
                                                                <asp:ListItem Value="" Text=" " />
                                                                <asp:ListItem Value="AS" Text="AS" />
                                                                <asp:ListItem Value="FM" Text="FM" />
                                                                <asp:ListItem Value="GU" Text="GU" />
                                                                <asp:ListItem Value="MH" Text="MH" />
                                                                <asp:ListItem Value="MP" Text="MP" />
                                                                <asp:ListItem Value="PR" Text="PR" />
                                                                <asp:ListItem Value="PW" Text="PW" />
                                                                <asp:ListItem Value="VI" Text="VI" />
                                                                <asp:ListItem Value="" Text="_____________" />
                                                                <asp:ListItem Text="US Military" Value="" />
                                                                <asp:ListItem Value="" Text=" " />
                                                                <asp:ListItem Value="AA" Text="AA" />
                                                                <asp:ListItem Value="AE" Text="AE" />
                                                                <asp:ListItem Value="AP" Text="AP" />
                                                                <asp:ListItem Value="" Text="_____________" />
                                                                <asp:ListItem Text="Canada" Value="" />
                                                                <asp:ListItem Value="" Text=" " />
                                                                <asp:ListItem Value="AB" Text="AB" />
                                                                <asp:ListItem Value="BC" Text="BC" />
                                                                <asp:ListItem Value="MB" Text="MB" />
                                                                <asp:ListItem Value="NB" Text="NB" />
                                                                <asp:ListItem Value="NL" Text="NL" />
                                                                <asp:ListItem Value="NS" Text="NS" />
                                                                <asp:ListItem Value="NT" Text="NT" />
                                                                <asp:ListItem Value="NU" Text="NU" />
                                                                <asp:ListItem Value="ON" Text="ON" />
                                                                <asp:ListItem Value="PE" Text="PE" />
                                                                <asp:ListItem Value="QC" Text="QC" />
                                                                <asp:ListItem Value="SK" Text="SK" />
                                                                <asp:ListItem Value="YT" Text="YT" />
                                                                <asp:ListItem Value="" Text="_____________" />
                                                                <asp:ListItem Text="Other Countries" Value="" />
                                                                <asp:ListItem Value="" Text=" " />
                                                                <asp:ListItem Value="None" Text="None" />
                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="req_MState" CssClass="errorMsg" ControlToValidate="ddlMState" ErrorMessage="*State is required. Select None if State does not apply to you" runat="server" Display="Dynamic" />

                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-2 col-md-2">
                                                            *Zip Code:
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:TextBox ID="tbMZip" runat="server" MaxLength="15" CssClass="single-input" placeholder="Zip Code" />
                                                        </div>
                                                        <div class="col-lg-2 col-md-2">
                                                            *Country:
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList ID="ddlMCountry" runat="server" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Text="United States" />
                                                                <asp:ListItem Text="Canada" />
                                                                <asp:ListItem Text="Mexico" />
                                                                <asp:ListItem Text="Afghanistan" />
                                                                <asp:ListItem Text="Albania" />
                                                                <asp:ListItem Text="Algeria" />
                                                                <asp:ListItem Text="American Samoa" />
                                                                <asp:ListItem Text="Andorra" />
                                                                <asp:ListItem Text="Angola" />
                                                                <asp:ListItem Text="Anguilla" />
                                                                <asp:ListItem Text="Antarctica" />
                                                                <asp:ListItem Text="Antigua and Barbuda" />
                                                                <asp:ListItem Text="Argentina" />
                                                                <asp:ListItem Text="Armenia" />
                                                                <asp:ListItem Text="Aruba" />
                                                                <asp:ListItem Text="Australia" />
                                                                <asp:ListItem Text="Austria" />
                                                                <asp:ListItem Text="Azerbaijan" />
                                                                <asp:ListItem Text="Bahamas" />
                                                                <asp:ListItem Text="Bahrain" />
                                                                <asp:ListItem Text="Bangladesh" />
                                                                <asp:ListItem Text="Barbados" />
                                                                <asp:ListItem Text="Belarus" />
                                                                <asp:ListItem Text="Belgium" />
                                                                <asp:ListItem Text="Belize" />
                                                                <asp:ListItem Text="Benin" />
                                                                <asp:ListItem Text="Bermuda" />
                                                                <asp:ListItem Text="Bhutan" />
                                                                <asp:ListItem Text="Bolivia" />
                                                                <asp:ListItem Text="Bosnia-Herzegovina" />
                                                                <asp:ListItem Text="Botswana" />
                                                                <asp:ListItem Text="Bouvet Island" />
                                                                <asp:ListItem Text="Brazil" />
                                                                <asp:ListItem Text="British Indian Ocean Territory" />
                                                                <asp:ListItem Text="Brunei" />
                                                                <asp:ListItem Text="Bulgaria" />
                                                                <asp:ListItem Text="Burkina Faso" />
                                                                <asp:ListItem Text="Burundi" />
                                                                <asp:ListItem Text="Cambodia" />
                                                                <asp:ListItem Text="Cameroon" />
                                                                <asp:ListItem Text="Cape Verde" />
                                                                <asp:ListItem Text="Cayman Islands" />
                                                                <asp:ListItem Text="Central African Republic" />
                                                                <asp:ListItem Text="Chad" />
                                                                <asp:ListItem Text="Chile" />
                                                                <asp:ListItem Text="China" />
                                                                <asp:ListItem Text="Christmas Island" />
                                                                <asp:ListItem Text="Cocos (Keeling) Islands" />
                                                                <asp:ListItem Text="Colombia" />
                                                                <asp:ListItem Text="Comoros" />
                                                                <asp:ListItem Text="Congo" />
                                                                <asp:ListItem Text="Cook Islands" />
                                                                <asp:ListItem Text="Costa Rica" />
                                                                <asp:ListItem Text="Croatia" />
                                                                <asp:ListItem Text="Cuba" />
                                                                <asp:ListItem Text="Cyprus" />
                                                                <asp:ListItem Text="Czech Republic" />
                                                                <asp:ListItem Text="Denmark" />
                                                                <asp:ListItem Text="Djibouti" />
                                                                <asp:ListItem Text="Dominica" />
                                                                <asp:ListItem Text="Dominican Republic" />
                                                                <asp:ListItem Text="East Timor" />
                                                                <asp:ListItem Text="Ecuador" />
                                                                <asp:ListItem Text="Educational" />
                                                                <asp:ListItem Text="Egypt" />
                                                                <asp:ListItem Text="El Salvador" />
                                                                <asp:ListItem Text="Equatorial Guinea" />
                                                                <asp:ListItem Text="Eritrea" />
                                                                <asp:ListItem Text="Estonia" />
                                                                <asp:ListItem Text="Ethiopia" />
                                                                <asp:ListItem Text="Falkland Islands" />
                                                                <asp:ListItem Text="Faroe Islands" />
                                                                <asp:ListItem Text="Fiji" />
                                                                <asp:ListItem Text="Finland" />
                                                                <asp:ListItem Text="Former Czechoslovakia" />
                                                                <asp:ListItem Text="Former USSR" />
                                                                <asp:ListItem Text="France" />
                                                                <asp:ListItem Text="French Guyana" />
                                                                <asp:ListItem Text="French Southern Territories" />
                                                                <asp:ListItem Text="Gabon" />
                                                                <asp:ListItem Text="Gambia" />
                                                                <asp:ListItem Text="Georgia" />
                                                                <asp:ListItem Text="Germany" />
                                                                <asp:ListItem Text="Ghana" />
                                                                <asp:ListItem Text="Gibraltar" />
                                                                <asp:ListItem Text="Great Britain" />
                                                                <asp:ListItem Text="Greece" />
                                                                <asp:ListItem Text="Greenland" />
                                                                <asp:ListItem Text="Grenada" />
                                                                <asp:ListItem Text="Guadeloupe (French)" />
                                                                <asp:ListItem Text="Guam (USA)" />
                                                                <asp:ListItem Text="Guatemala" />
                                                                <asp:ListItem Text="Guinea" />
                                                                <asp:ListItem Text="Guinea-Bissau" />
                                                                <asp:ListItem Text="Guyana" />
                                                                <asp:ListItem Text="Haiti" />
                                                                <asp:ListItem Text="Heard and McDonald Islands" />
                                                                <asp:ListItem Text="Holy See (Vatican City State)" />
                                                                <asp:ListItem Text="Honduras" />
                                                                <asp:ListItem Text="Hungary" />
                                                                <asp:ListItem Text="Iceland" />
                                                                <asp:ListItem Text="India" />
                                                                <asp:ListItem Text="Indonesia" />
                                                                <asp:ListItem Text="Iran" />
                                                                <asp:ListItem Text="Iraq" />
                                                                <asp:ListItem Text="Ireland" />
                                                                <asp:ListItem Text="Israel" />
                                                                <asp:ListItem Text="Italy" />
                                                                <asp:ListItem Text="Ivory Coast (Cote D'Ivoire)" />
                                                                <asp:ListItem Text="Jamaica" />
                                                                <asp:ListItem Text="Japan" />
                                                                <asp:ListItem Text="Jordan" />
                                                                <asp:ListItem Text="Kazakhstan" />
                                                                <asp:ListItem Text="Kenya" />
                                                                <asp:ListItem Text="Kiribati" />
                                                                <asp:ListItem Text="Kuwait" />
                                                                <asp:ListItem Text="Kyrgyz Republic (Kyrgyzstan)" />
                                                                <asp:ListItem Text="Laos" />
                                                                <asp:ListItem Text="Latvia" />
                                                                <asp:ListItem Text="Lebanon" />
                                                                <asp:ListItem Text="Lesotho" />
                                                                <asp:ListItem Text="Liberia" />
                                                                <asp:ListItem Text="Libya" />
                                                                <asp:ListItem Text="Liechtenstein" />
                                                                <asp:ListItem Text="Lithuania" />
                                                                <asp:ListItem Text="Luxembourg" />
                                                                <asp:ListItem Text="Macau" />
                                                                <asp:ListItem Text="Macedonia" />
                                                                <asp:ListItem Text="Madagascar" />
                                                                <asp:ListItem Text="Malawi" />
                                                                <asp:ListItem Text="Malaysia" />
                                                                <asp:ListItem Text="Maldives" />
                                                                <asp:ListItem Text="Mali" />
                                                                <asp:ListItem Text="Malta" />
                                                                <asp:ListItem Text="Marshall Islands" />
                                                                <asp:ListItem Text="Martinique (French)" />
                                                                <asp:ListItem Text="Mauritania" />
                                                                <asp:ListItem Text="Mauritius" />
                                                                <asp:ListItem Text="Mayotte" />
                                                                <asp:ListItem Text="Micronesia" />
                                                                <asp:ListItem Text="Moldavia" />
                                                                <asp:ListItem Text="Monaco" />
                                                                <asp:ListItem Text="Mongolia" />
                                                                <asp:ListItem Text="Montserrat" />
                                                                <asp:ListItem Text="Morocco" />
                                                                <asp:ListItem Text="Mozambique" />
                                                                <asp:ListItem Text="Myanmar" />
                                                                <asp:ListItem Text="Namibia" />
                                                                <asp:ListItem Text="Nauru" />
                                                                <asp:ListItem Text="Nepal" />
                                                                <asp:ListItem Text="Netherlands" />
                                                                <asp:ListItem Text="Netherlands Antilles" />
                                                                <asp:ListItem Text="New Caledonia (French)" />
                                                                <asp:ListItem Text="New Zealand" />
                                                                <asp:ListItem Text="Nicaragua" />
                                                                <asp:ListItem Text="Niger" />
                                                                <asp:ListItem Text="Nigeria" />
                                                                <asp:ListItem Text="Niue" />
                                                                <asp:ListItem Text="Norfolk Island" />
                                                                <asp:ListItem Text="Northern Mariana Islands" />
                                                                <asp:ListItem Text="North Korea" />
                                                                <asp:ListItem Text="Norway" />
                                                                <asp:ListItem Text="Oman" />
                                                                <asp:ListItem Text="Pakistan" />
                                                                <asp:ListItem Text="Palau" />
                                                                <asp:ListItem Text="Panama" />
                                                                <asp:ListItem Text="Papua New Guinea" />
                                                                <asp:ListItem Text="Paraguay" />
                                                                <asp:ListItem Text="Peru" />
                                                                <asp:ListItem Text="Philippines" />
                                                                <asp:ListItem Text="Pitcairn Island" />
                                                                <asp:ListItem Text="Poland" />
                                                                <asp:ListItem Text="Polynesia (French)" />
                                                                <asp:ListItem Text="Portugal" />
                                                                <asp:ListItem Text="Puerto Rico" />
                                                                <asp:ListItem Text="Qatar" />
                                                                <asp:ListItem Text="Reunion (French)" />
                                                                <asp:ListItem Text="Romania" />
                                                                <asp:ListItem Text="Russian Federation" />
                                                                <asp:ListItem Text="Rwanda" />
                                                                <asp:ListItem Text="Saint Helena" />
                                                                <asp:ListItem Text="Saint Kitts &amp; Nevis Anguilla" />
                                                                <asp:ListItem Text="Saint Lucia" />
                                                                <asp:ListItem Text="Saint Pierre and Miquelon" />
                                                                <asp:ListItem Text="Saint Tome and Principe" />
                                                                <asp:ListItem Text="Saint Vincent &amp; Grenadines" />
                                                                <asp:ListItem Text="Samoa" />
                                                                <asp:ListItem Text="San Marino" />
                                                                <asp:ListItem Text="Saudi Arabia" />
                                                                <asp:ListItem Text="Senegal" />
                                                                <asp:ListItem Text="Seychelles" />
                                                                <asp:ListItem Text="S. Georgia &amp; S. Sandwich Isls." />
                                                                <asp:ListItem Text="Sierra Leone" />
                                                                <asp:ListItem Text="Singapore" />
                                                                <asp:ListItem Text="Slovak Republic" />
                                                                <asp:ListItem Text="Slovenia" />
                                                                <asp:ListItem Text="Solomon Islands" />
                                                                <asp:ListItem Text="Somalia" />
                                                                <asp:ListItem Text="South Africa" />
                                                                <asp:ListItem Text="South Korea" />
                                                                <asp:ListItem Text="Spain" />
                                                                <asp:ListItem Text="Sri Lanka" />
                                                                <asp:ListItem Text="Sudan" />
                                                                <asp:ListItem Text="Suriname" />
                                                                <asp:ListItem Text="Svalbard and Jan Mayen Islands" />
                                                                <asp:ListItem Text="Swaziland" />
                                                                <asp:ListItem Text="Sweden" />
                                                                <asp:ListItem Text="Switzerland" />
                                                                <asp:ListItem Text="Syria" />
                                                                <asp:ListItem Text="Tadjikistan" />
                                                                <asp:ListItem Text="Taiwan" />
                                                                <asp:ListItem Text="Tanzania" />
                                                                <asp:ListItem Text="Thailand" />
                                                                <asp:ListItem Text="Togo" />
                                                                <asp:ListItem Text="Tokelau" />
                                                                <asp:ListItem Text="Tonga" />
                                                                <asp:ListItem Text="Trinidad and Tobago" />
                                                                <asp:ListItem Text="Tunisia" />
                                                                <asp:ListItem Text="Turkey" />
                                                                <asp:ListItem Text="Turkmenistan" />
                                                                <asp:ListItem Text="Turks and Caicos Islands" />
                                                                <asp:ListItem Text="Tuvalu" />
                                                                <asp:ListItem Text="Uganda" />
                                                                <asp:ListItem Text="Ukraine" />
                                                                <asp:ListItem Text="United Arab Emirates" />
                                                                <asp:ListItem Text="United Kingdom" />
                                                                <asp:ListItem Text="Uruguay" />
                                                                <asp:ListItem Text="USA Minor Outlying Islands" />
                                                                <asp:ListItem Text="Uzbekistan" />
                                                                <asp:ListItem Text="Vanuatu" />
                                                                <asp:ListItem Text="Venezuela" />
                                                                <asp:ListItem Text="Vietnam" />
                                                                <asp:ListItem Text="Virgin Islands (British)" />
                                                                <asp:ListItem Text="Virgin Islands (USA)" />
                                                                <asp:ListItem Text="Wallis and Futuna Islands" />
                                                                <asp:ListItem Text="Western Sahara" />
                                                                <asp:ListItem Text="Yemen" />
                                                                <asp:ListItem Text="Yugoslavia" />
                                                                <asp:ListItem Text="Zaire" />
                                                                <asp:ListItem Text="Zambia" />
                                                                <asp:ListItem Text="Zimbabwe" />
                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="req_MCountry" CssClass="errorMsg" ControlToValidate="ddlMCountry" ErrorMessage="*Country is required" runat="server" Display="Dynamic" />

                                                        </div>
                                                    </div>

                                                </div>

                                            </asp:Panel>

                                            <asp:Panel ID="pnlAdditional" runat="server" Visible="false">
                                                <div class="section-top-border">
                                                    <h3 class="mb-10">Additional Questions-Answering</h3>
                                                    <p>These questions will help us help you grow your business and save more lives</p>

                                                    <h5 class="mb-10 mt-20">Organization Information</h5>
                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            Organization Capacity (average):
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlcapacity" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="0-25" Text="0-25" />
                                                                <asp:ListItem Value="25-55" Text="26-55" />
                                                                <asp:ListItem Value="56-100" Text="56-100" />
                                                                <asp:ListItem Value="101+" Text="101+" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            Primary Dog Food Brand Used:
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlFood_dog" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Blue Buffalo" Text="Blue Buffalo" />
                                                                <asp:ListItem Value="Beneful" Text="Beneful" />
                                                                <asp:ListItem Value="Eukanuba" Text="Eukanuba" />
                                                                <asp:ListItem Value="Iams" Text="Iams" />
                                                                <asp:ListItem Value="Natura" Text="Natura" />
                                                                <asp:ListItem Value="Purina Chows" Text="Purina Chows" />
                                                                <asp:ListItem Value="Purina ONE" Text="Purina ONE" />
                                                                <asp:ListItem Value="Pedigree" Text="Pedigree" />
                                                                <asp:ListItem Value="Science Diet" Text="Science Diet" />
                                                                <asp:ListItem Value="Store brands" Text="Store brands" />
                                                                <asp:ListItem Value="Other" Text="Other" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            Primary Cat Food Brand Used:
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlFood_cat" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Eukanuba" Text="Eukanuba" />
                                                                <asp:ListItem Value="Blue Buffalo" Text="Blue Buffalo" />
                                                                <asp:ListItem Value="Fancy Feast" Text="Fancy Feast" />
                                                                <asp:ListItem Value="Friskies" Text="Friskies" />
                                                                <asp:ListItem Value="Iams" Text="Iams" />
                                                                <asp:ListItem Value="Meow Mix" Text="Meow Mix" />
                                                                <asp:ListItem Value="Natura" Text="Natura" />
                                                                <asp:ListItem Value="Purina Chows" Text="Purina Chows" />
                                                                <asp:ListItem Value="Science Diet" Text="Science Diet" />
                                                                <asp:ListItem Value="Store brand" Text="Store brand" />
                                                                <asp:ListItem Value="Whiskas" Text="Whiskas" />
                                                                <asp:ListItem Value="Other" Text="Other" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            Prmary Source of Funding for Food:
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlFood_source" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Community Donations" Text="Community Donations" />
                                                                <asp:ListItem Value="Corporate Donations" Text="Corporate Donations" />
                                                                <asp:ListItem Value="Fundraisers" Text="Fundraisers" />
                                                                <asp:ListItem Value="Other" Text="Other" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>


                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            Do you have a Veterinarian on staff?
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlVet" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Yes" Text="Yes" />
                                                                <asp:ListItem Value="No" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>


                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            If no, how do you get Veterinary Services?
                                                        </div>
                                                        <div class="col-lg-8 col-md-8">
                                                            <asp:TextBox ID="tbWhereVet" runat="server" MaxLength="250" CssClass="single-input" placeholder="Veterinary Services" />
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            Which animals do you help?
                                                        </div>
                                                        <div class="col-lg-2 col-md-2">
                                                            <asp:CheckBox ID="chkDog" runat="server" Text='Dogs' />
                                                        </div>
                                                        <div class="col-lg-2 col-md-2">
                                                            <asp:CheckBox ID="chkCat" runat="server" Text='Cats' />
                                                        </div>
                                                        <div class="col-lg-2 col-md-2">
                                                            <asp:CheckBox ID="chkReptile" runat="server" Text='Reptiles' />
                                                        </div>
                                                        <div class="col-lg-2 col-md-2">
                                                            <asp:CheckBox ID="chkOther" runat="server" Text='Other' />
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            Do you have experience with offsite adoption events?
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddloffsite_events" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Yes" Text="Yes" />
                                                                <asp:ListItem Value="No" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            Do you have a mobile adoption vehicle?
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlmobile_vehicle" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Yes" Text="Yes" />
                                                                <asp:ListItem Value="No" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            Have you worked with local retailers for adoption events?
                                                        </div>
                                                        <div class="col-lg-2 col-md-2">
                                                            <asp:DropDownList runat="server" ID="ddlwork_with_retailers" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Yes" Text="Yes" />
                                                                <asp:ListItem Value="No" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                        <div class="col-lg-2 col-md-2">
                                                            If Yes, whom?
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:TextBox ID="tbwhich_retailers" runat="server" MaxLength="250" CssClass="single-input" placeholder="Retailers" />
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-2 col-md-2">
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlwant_adoption_retailer" Visible="false" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Yes" Text="Yes" />
                                                                <asp:ListItem Value="No" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <h5 class="mt-20 mb-15">Marketing</h5>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-8 col-md-8">
                                                            Do you have a Public Relations person (volunteer, part/full time)?
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlpr_person" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Yes" Text="Yes" />
                                                                <asp:ListItem Value="No" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-8 col-md-8">
                                                            Do you have a relationship with your local media (TV, newspaper, etc)?
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlmedia_relations" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Yes" Text="Yes" />
                                                                <asp:ListItem Value="No" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-8 col-md-8">
                                                            Do you place ads on a regular basis?
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlplace_ads" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Yes" Text="Yes" />
                                                                <asp:ListItem Value="No" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>
                                                    <div class="row mt-10">
                                                        <div class="col-lg-3 col-md-3">
                                                            If yes, where?
                                                        </div>
                                                        <div class="col-lg-9 col-md-9">
                                                            <asp:TextBox ID="tbwhere_ads" runat="server" MaxLength="250" CssClass="single-input" />
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-8 col-md-8">
                                                            If no, are you interested in being teamed with a local retailer?
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlwant_marketing_retailer" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Yes" Text="Yes" />
                                                                <asp:ListItem Value="No" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-8 col-md-8">
                                                            Have you attended an <u><a href="http://www.animalcentero.org/ACESConference" target="_blank">ACES International Conference</a></u>?
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlattended_ACES" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Yes" Text="Yes" />
                                                                <asp:ListItem Value="No" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-8 col-md-8">
                                                            Are you interested in attending an <u><a href="http://www.animalcentero.org/ACESConference" target="_blank">ACES International Conference</a></u>?
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlinterested_ACES" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Yes" Text="Yes" />
                                                                <asp:ListItem Value="No" Text="No" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>


                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:CheckBox ID="chkIams_optin" runat="server" Visible="false" />
                                                        </div>
                                                    </div>
                                                </div>

                                            </asp:Panel>


                                            <%--fahad visible should be false--%>
                                            <asp:Panel runat="server" ID="pnlAdmin" Visible="true">
                                                <div class="section-top-border">
                                                    <h3 class="mb-10">Admin</h3>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-2 col-md-2">
                                                            <asp:CheckBox ID="chkParticipant_2012" runat="server" Visible="false" />
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-2 col-md-2">
                                                            <asp:CheckBox ID="chkcompleted" runat="server" Visible="false" />
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-3 col-md-3">
                                                            *City:
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlCalls" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="0" Text="0" />
                                                                <asp:ListItem Value="1" Text="1" />
                                                                <asp:ListItem Value="2" Text="2" />
                                                                <asp:ListItem Value="3" Text="3" />
                                                                <asp:ListItem Value="4" Text="4" />
                                                                <asp:ListItem Value="5" Text="5" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-3 col-md-3">
                                                            <%--Status--%>
                                                        </div>
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:DropDownList runat="server" ID="ddlResolution" Visible="false" CssClass="single-input dropdown-scrollable nice-select">
                                                                <asp:ListItem Value="" Text="" />
                                                                <asp:ListItem Value="Contacted-Participating" Text="Contacted-Participating" />
                                                                <asp:ListItem Value="Contacted-NOT Participating-Not Interested" Text="Contacted-NOT Participating-Not Interested" />
                                                                <asp:ListItem Value="Contacted-NOT Participating-Using Another Program" Text="Contacted-NOT Participating-Using Another Program" />
                                                                <asp:ListItem Value="Contacted-NOT Participating-Shelter Closed/Not Operating" Text="Contacted-NOT Participating-Shelter Closed/Not Operating" />
                                                                <asp:ListItem Value="No Contact-Wrong Number" Text="No Contact-Wrong Number" />
                                                                <asp:ListItem Value="No Contact-No Answer" Text="No Contact-No Answer" />
                                                                <asp:ListItem Value="No Contact-Disconnected Number" Text="No Contact-Disconnected Number" />
                                                                <asp:ListItem Value="No Contact-Left Message" Text="No Contact-Left Message" />
                                                                <asp:ListItem Value="Duplicate-Deleting Account" Text="Duplicate-Deleting Account" />
                                                            </asp:DropDownList>
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-4 col-md-4">
                                                            <asp:CheckBox ID="chkActive" runat="server" />
                                                            Active
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-3 col-md-3">
                                                            2018 Admin Notes
                                                        </div>
                                                        <div class="col-lg-9 col-md-9 form-group">
                                                            <asp:TextBox ID="tbAdmin_notes2018" CssClass="common-textarea form-control" runat="server" Height="200" MaxLength="4000" TextMode="MultiLine" />

                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-3 col-md-3">
                                                            2017 Admin Notes
                                                        </div>
                                                        <div class="col-lg-9 col-md-9 form-group">
                                                            <asp:TextBox ID="tbAdmin_notes2017" CssClass="common-textarea form-control" runat="server" MaxLength="4000" Height="200" TextMode="MultiLine" />
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-3 col-md-3">
                                                            INPEx Notes
                                                        </div>
                                                        <div class="col-lg-9 col-md-9 form-group">
                                                            <asp:TextBox ID="tbINPExNotes" runat="server" CssClass="common-textarea form-control" MaxLength="4000" Height="200" TextMode="MultiLine" />
                                                        </div>
                                                    </div>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-3 col-md-3">
                                                            2016 Admin Notes
                                                        </div>
                                                        <div class="col-lg-9 col-md-9 form-group">
                                                            <asp:TextBox ID="tbAdmin_notes" runat="server" CssClass="common-textarea form-control" MaxLength="4000" Height="200" TextMode="MultiLine" />
                                                        </div>
                                                    </div>

                                                </div>
                                            </asp:Panel>

                                            <div class="title text-center mb-20">
                                                <asp:Button ID="btnUpdate" OnClick="btnUpdate_Click" CssClass="genric-btn primary small round-border" runat="server" Text="Update Profile" />
                                            </div>

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
