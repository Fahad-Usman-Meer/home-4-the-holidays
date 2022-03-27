<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Blue Buffalo Home 4 the Holidays Registration | Helen Woodward Animal Center" Debug="false" %>

<script runat="server">
    Sub page_load(obj As Object, e As EventArgs)
        tbPassword.Attributes("value") = tbPassword.Text
        tbPassword2.Attributes("value") = tbPassword2.Text
        If Not Page.IsPostBack Then 'set focus to username
            Dim objFocus As New HWAC.Utility
            RegisterStartupScript("FirstFocus", objFocus.MakeFocusScript(Me.tbUserName))
        End If

    End Sub
    Public Function GetUniqueID(ByVal length As Integer) As String
        'Get the GUID
        Dim guidResult As String = System.Guid.NewGuid().ToString()

        'Remove the hyphens
        guidResult = guidResult.Replace("-", String.Empty)

        'Make sure length is valid
        If length <= 0 OrElse length > guidResult.Length Then
            Throw New ArgumentException("Length must be between 1 and " & guidResult.Length)
        End If

        'Return the first length bytes
        Return guidResult.Substring(0, length)
    End Function


    Sub chkMailing_Click(obj As Object, e As EventArgs)
        If chkMailing.Checked Then 'do nothing, Shipping is the same
            pnlMailing.Visible = False
        Else
            pnlMailing.Visible = True
            tbMCity.Text = tbSCity.Text
            tbMZip.Text = tbSZip.Text
            'if ddlSState.SelectedItem.Text<>"Choose a State" then
            'ddlMState.Items.FindByValue(ddlSState.SelectedItem.text).Selected=True
            ddlMState.Items.Insert(0, New ListItem(ddlSState.SelectedItem.Text, ddlSState.SelectedItem.Text))
            'VIEW STATE SEEMS TO OVERRIDE ENTRIES ON MULTIPLE POSTS
            'end if
            ddlMCountry.Items.Insert(0, New ListItem(ddlSCountry.SelectedItem.Text, ddlSCountry.SelectedItem.Text))
            Dim objFocus As New HWAC.Utility
            RegisterStartupScript("FirstFocus", objFocus.MakeFocusScript(Me.tbMAddress))
        End If
    End Sub
    Sub btnRegister_Click(obj As Object, e As EventArgs)
        'fraud
        If tbOrg.Text = "" Then Exit Sub
        If Request.ServerVariables("REMOTE_ADDR") = "173.236.103.38" Then Exit Sub '
        If tbDogs.Text = "0" And tbCats.Text = "0" And tbPuppies.Text = "0" And tbKittens.Text = "0" And tbOther.Text = "0" Then
            lblMessage.Text = "You must have some projected adoptions for this campaign."
        End If
        '1) Create Login for New user
        Dim theUniqueID As String = GetUniqueID(10)
        Dim str1 As String
        Dim str2 As String
        Dim str3 As String
        Dim strResult As String
        Dim objUserDetails As New HWAC.UserDetails
        Dim db As New HWAC.DatabaseH4TH
        With objUserDetails
            'Account details---------
            .UserName = Replace(tbUserName.Text, "'", "''")
            .Password = Replace(tbPassword.Text, "'", "''")
            .Hint = Replace(tbHint.Text, "'", "''")
            'Contact Details---------
            .FName = Replace(tbFName.Text, "'", "''")
            .LName = Replace(tbLName.Text, "'", "''")
            .ContactPhone = Replace(tbPhone.Text, "'", "''")
            .Email = tbEmail.Text
            'Mailing Address----------
            If Not chkMailing.Checked Then 'filled out different mailing address
                .BAddress = Replace(tbMAddress.Text, "'", "''")
                .BCity = Replace(tbMCity.Text, "'", "''")
                .BState = ddlMState.SelectedItem.Value
                .BZip = Replace(tbMZip.Text, "'", "''")
                .BCountry = ddlMCountry.SelectedItem.Value
            Else 'same as shipping
                .BAddress = Replace(tbSAddress.Text, "'", "''")
                .BCity = Replace(tbSCity.Text, "'", "''")
                .BState = ddlSState.SelectedItem.Value
                .BZip = Replace(tbSZip.Text, "'", "''")
                .BCountry = ddlSCountry.SelectedItem.Value
            End If
            'Shipping address-------------
            .SAddress = Replace(tbSAddress.Text, "'", "''")
            .SCity = Replace(tbSCity.Text, "'", "''")
            .SState = ddlSState.SelectedItem.Value
            .SZip = Replace(tbSZip.Text, "'", "''")
            .SCountry = ddlSCountry.SelectedItem.Value
            'Org Info---------------------
            .Website = Replace(tbWebsite.Text, "'", "''")
            .Facebook = Replace(tbFacebook.Text, "'", "''")
            .Twitter = Replace(tbTwitter.Text, "'", "''")
            .Pinterest = Replace(tbPinterest.Text, "'", "''")
            .Blog = Replace(tbBlog.Text, "'", "''")
            .ShelterPhone = Replace(tbOrgPhone.Text, "'", "''")
            .Fax = Replace(tbFax.Text, "'", "''")
            .ReferredBy = ddlRefer.SelectedItem.Value
            .ShelterName = Replace(tbOrg.Text, "'", "''")
            'Adoption info
            .Dogs = tbDogs.Text
            .Cats = tbCats.Text
            .Puppies = tbPuppies.Text
            .Kittens = tbKittens.Text
            .Other = tbOther.Text


            '1) make sure the username does not exist in the db

            If db.ExecuteScalar("SELECT UserID FROM tblUsers WHERE UserName='" & .UserName & "'") <> "" Then 'found username already
                lblMessage.Text = "The Username you chose is already taken.  If you have already registered, you can login, or choose another Username and Password to continue.  Thanks!"
                Exit Sub
            End If

            str1 = "INSERT INTO tblUsers (Username,password,email,hint,roles,UniqueID) values('" & .UserName & "','" & .Password & "','" & .Email & "','" & .Hint & "','h4th,','" & theUniqueID & "')"


        End With
        'insert User

        If db.ExecuteNonQuery(str1) Then 'boolean return value true-get userid assigned 

            strResult = db.ExecuteScalar("SELECT UserID FROM tblUsers WHERE UserName='" & objUserDetails.UserName & "' AND Password='" & objUserDetails.Password & "'")
            If strResult <> "" Then 'returned a value

                With objUserDetails
                    .UserId = strResult
                    str2 = "INSERT INTO tblH4thReg (ShelterID,ShelterName,ShelterPhone,Fax,Website,ReferredBy,FName,LName,ContactPhone,Email,MAddress,MCity,MState,MZip,MCountry,SAddress,SCity,SState,SZip,SCountry,Facebook,Twitter,Pintrest, Blog, lang, UniqueID, ExecName, ExecTitle, Title) values("
                    str2 &= .UserId & ",'" & .ShelterName & "','" & .ShelterPhone & "','" & .Fax & "','" & .Website & "','" & .ReferredBy & "','"
                    str2 &= .FName & "','" & .LName & "','" & .ContactPhone & "','" & .Email & "','" & .BAddress & "','" & .BCity & "','"
                    str2 &= .BState & "','" & .BZip & "','" & .BCountry & "','" & .SAddress & "','" & .SCity & "','" & .SState & "','" & .SZip & "','" & .SCountry & "','" & .Facebook & "','" & .Twitter & "','" & .Pinterest & "','" & .Blog & "','" & ddlLang.SelectedItem.Value & "','" & theUniqueID & "','" & Replace(tbExecName.Text, "'", "''") & "','" & Replace(tbExecTitle.Text, "'", "''") & "','" & Replace(tbContactTitle.Text, "'", "''") & "')"
                    'insert registration record
                    db.ExecuteNonQuery(str2) 'success-email me and them, and send them to profile page
                    'Insert animal goals
                    str3 = "INSERT INTO tblH4thAdoptions (ShelterID, DateId, AYear, Dogs, Cats, Puppies, Kittens, other, AType) Values(" & .UserId & ",248,'2022'," & .Dogs & "," & .Cats & "," & .Puppies & "," & .Kittens & "," & .Other & ",'Goal')"
                    db.ExecuteNonQuery(str3)
                End With
                Session("UserID") = objUserDetails.UserId
                Session("ShelterName") = tbOrg.Text
                '----------------------------------------------------------------------------------------------------------------------------------------------------------------------
                'IMPLEMENT ROLES BASED SECURITY
                Dim authTicket As FormsAuthenticationTicket = New FormsAuthenticationTicket(1, objUserDetails.UserId, DateTime.Now, DateTime.Now.AddMinutes(30), True, "h4th,")
                ' Now encrypt the ticket.
                Dim encryptedTicket As String = FormsAuthentication.Encrypt(authTicket)
                'Create a cookie and add the encrypted ticket to the cookie as data.
                Dim authCookie As HttpCookie = New HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket)
                'Add the cookie to the outgoing cookies collection.
                Response.Cookies.Add(authCookie)
                '----------------------------------------------------------------------------------------------------------------------------------------------------------------------

                '2.5)Email welcome letter to client and bcc me for approval
                Dim objMM As New HWAC.EmailMessage
                With objMM
                    .MailTo = objUserDetails.Email
                    .From = "Home 4 The Holidays <h4th@animalcenter.org>"
                    .Subject = "Welcome to the Home 4 The Holidays Campaign!"
                    .Body = "<table width=500 border=1 align=center cellpadding=4><tr><td><img src=""http://join.home4theholidays.org/_images/H4TH_color_sm.jpg"" width=225 height=67 align=right /><p>Congratulations, you are now a part of a worldwide campaign to give orphan animals a Home 4 The Holidays!<p>"
                    .Body &= "<p>Your personal account has been set up for you.  <br><Br>YOU MUST VERIFY YOUR ACCOUNT BY <a href=""http://join.home4theholidays.org/verify.aspx?Var1=" & theUniqueID & """>CLICKING HERE</a>.  YOUR PROFILE WILL NOT BE PUBLIC UNTIL YOU VERIFY IT.<br><br>You may view this account by <a href=http://join.home4theholidays.org/members>logging on</a> with the following information.</P>"
                    .Body &= "<table align=center cellspacing=2><tr><td><b>Username:</b></td><td>" & objUserDetails.UserName & "</td></tr><tr><td><b>Password:</b></td><td>" & objUserDetails.Password & "</td></tr></table>"

                    '.Body &="<p>Stay tuned for exciting news about this year's campaign:  coming soon!</p>"
                    '.Body &="<p>Be sure to log in and set your adoption goal for the H4TH Campaign(October 1st-January 5th).</p>"
                    '.Body &="<ul><li>November 14, 2005</li><li>November 21, 2005</li><li>November 28, 2005</li><li>December 5, 2005</li><li>December 12, 2005</li><li>December 19, 2005</li><li>December 26, 2005</li><li>January 2, 2006</li></ul>"
                    .Body &= "<p><a href=http://join.home4theholidays.org/members/adoptions.aspx>Click here</a> to log into your account to record your adoptions each week.  That way we can track the success of the program.</p>"
                    .Body &= "<p>You may also simply <b><a href=""http://join.home4theholidays.org/login.aspx?p=" & theUniqueID & "&l=account"">Click Here</a></b> to automatically log in.</p>"
                    .Body &= "<p>Thank you for your participation!</p></td></tr></table>"
                    'need to include username and password, info about updating adoptions
                    .Send_Email(objMM)
                End With
                With objMM
                    .MailTo = "lonjones@hotmail.com"
                    .From = "Home 4 The Holidays <h4th@animalcenter.org>"
                    .Subject = "H4TH Registration"
                    .Body = Session("ShelterName") & ", UserID:" & Session("UserID") & " has created a new profile.<br>"
                End With
                With objUserDetails
                    objMM.Body &= Request.ServerVariables("REMOTE_ADDR") & "<br><br>"
                    objMM.Body &= "<a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegDisapprove&Var1=" & theUniqueID & """>Disapprove Registration</a>"

                    objMM.Body &= "<br><br><a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegActivate&Var1=" & theUniqueID & """>Activate Registration</a>"
                    objMM.Body &= "<br><br><a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegApprove&Var1=" & theUniqueID & """>Approve Registration</a>"

                    objMM.Body &= "<br><Br><a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegVerify&Var1=" & theUniqueID & """>Verify Registration</a>"
                    objMM.Body &= "<br><br><a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegDeActivate&Var1=" & theUniqueID & """>Deactivate Registration</a>"
                    objMM.Body &= "<br><br><br><a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegDelete&Var1=" & Session("UserID") & """>Delete Registration</a><br>"
                    objMM.Body &= "UserName:" & .UserName & "<br>Password:" & .Password & "<br>Hint:" & .Hint & "<br>First Name:" & .FName & "<br>Last Name:" & .LName & "<br>Contact Phone:" & .ContactPhone & "<br>Email:" & .Email & "<br>BAddress:" & .BAddress & "<br>BCity:" & .BCity & "<br>BState:" & .BState & "<br>BZip:" & .BZip & "<br>BCoutry:" & .BCountry & "<br>SAddress:" & .SAddress & "<br>SCity:" & .SCity & "<br>SState:" & .SState & "<br>SZip:" & .SZip & "<br>SCountry:" & .SCountry & "<br>Website:" & .Website & "<br>Shelter Phone:" & .ShelterPhone & "<br>Fax:" & .Fax & "<br>ShelterName:" & .ShelterName & "<br>Reffered By:" & .ReferredBy & "<br>Dogs:" & tbDogs.Text & " Cats:" & tbCats.Text & " Puppies:" & tbPuppies.Text & " Kittens:" & tbKittens.Text & " Other:" & tbOther.Text & " <br/>Facebook:" & tbFacebook.Text & " <br/>Twitter:" & tbTwitter.Text & "<br/>Pinterest:" & tbPinterest.Text & " <br/>Blog:" & tbBlog.Text & "<br/>Language:" & ddlLang.SelectedItem.Value

                End With
                objMM.Send_Email(objMM)

                '3) redirect user to member homepage with querystring for welcome message
                Response.Redirect("members/index.aspx?FirstTime=true")

            Else 'Regstration did not go right
                lblMessage.Text &= "The system could not register you at this time, please try again. Thank you!"
                'delete login
                db.ExecuteNonQuery("DELETE FROM tblUsers WHERE UserName='" & objUserDetails.UserName & "' AND Password='" & objUserDetails.Password & "'")

                Exit Sub

            End If
        Else 'could not enter user logon info into tblUsers
            lblMessage.Text = "There has been an error with registration, please try again.  Thank You!"
        End If

    End Sub

</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Increase pet adoptions in your animal shelter by joining Blue Buffalo Home 4 the Holidays - register today!" />
    <meta name="keywords" content="pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />
   <%-- <style type="text/css">
        <!--
        .style1 {
            color: #FFFFFF
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
                    <h1 class="text-white">Join The Cause
                    </h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Sign Up</a>
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
                        <h1 class="mb-10">Shine a Light by Joining Blue Buffalo Home 4 the Holidays</h1>
                    </div>
                    <p><strong>We want to help your pet  adoption organization increase adoptions and raise more funds for your  life-saving mission &ndash; <b>FOR FREE!</b>. </strong>Become a Blue Buffalo Home 4 the Holidays  partner by registering your shelter today.</p>
                    <p><strong>ALL ORGANIZATIONS</strong>:  please check the&nbsp;<a href="http://join.home4theholidays.org/shelter_map.aspx">Shelter Map</a> to see if you are already registered. Please check all similar names before registering, to ensure no duplicate registrations.</p>

                    <div class="country">
                        <ul class="unordered-list">
                            <li><strong><em><u>If your organization IS NOT registered</u></em></strong>,  please fill out all of the fields to register for Blue&nbsp;Buffalo Home 4 the  Holidays. Once you are registered, you will have access to your personal  shelter profile, be able to enter your weekly adoptions online, receive special  announcements, download&nbsp;our annual informative guide to help  you increase adoptions, and more! </li>
                            <li><strong><em><u>If your organization IS registered</u></em></strong>, thank  you and please update your email, adoption goals and contact information  annually.  You can&nbsp;<a href="http://join.home4theholidays.org/members">log in here.</a></li>
                        </ul>
                    </div>

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
                        <h1 class="mb-10">Register my Pet Adoption Organization</h1>
                    </div>
                    <div class="whole-wrap mb-20">
                        <div class="container">
                            <div class="section-top-border">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">


                                        <form runat="server">

                                            <h3 class="mb-10">Choose Your Account Information</h3>

                                            <asp:ValidationSummary runat="server" ShowMessageBox="true" ShowSummary="false" ID="VSum" HeaderText="Please fill out all the required fields appropriately" />
                                            <asp:Label ID="lblMessage" runat="server" Font-Bold="true" ForeColor="red" />

                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2">
                                                    *Username:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox ID="tbUserName" runat="server" MaxLength="12" CssClass="single-input" placeholder="Username" />
                                                    <asp:RequiredFieldValidator runat="server" CssClass="errorMsg" ControlToValidate="tbUserName" ErrorMessage="*Username required" Display="Dynamic" />
                                                </div>
                                            </div>

                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2">
                                                    *Password:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox ID="tbPassword" runat="server" MaxLength="12" TextMode="Password" CssClass="single-input" placeholder="Password" />
                                                    <asp:RequiredFieldValidator runat="server" CssClass="errorMsg" ControlToValidate="tbPassword" ErrorMessage="*Password required" Display="Dynamic" />
                                                </div>
                                            </div>

                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2">
                                                    *Confirm Password:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox ID="tbPassword2" MaxLength="12" runat="server" TextMode="Password" CssClass="single-input" placeholder="Confirm Password" />
                                                    <asp:RequiredFieldValidator runat="server" CssClass="errorMsg" ControlToValidate="tbPassword2" ErrorMessage="*Password required" Display="Dynamic" />
                                                    <asp:CompareValidator ControlToCompare="tbPassword" CssClass="errorMsg" Display="Dynamic" ValueToCompare="=" runat="server" ControlToValidate="tbPassword2" ErrorMessage="*Passwords do not match" />
                                                </div>
                                            </div>

                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2">
                                                    *Password Hint:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox runat="server" MaxLength="200" ID="tbHint" CssClass="single-input" placeholder="Password Hint" />
                                                    <asp:RequiredFieldValidator runat="server" CssClass="errorMsg" Display="Dynamic" ID="req_Hint" ControlToValidate="tbHint" ErrorMessage="*Password Hint Required" />
                                                </div>
                                            </div>


                                            <div class="section-top-border">
                                                <h3 class="mb-10">Organization Information</h3>


                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        *Organization:
                                                    </div>
                                                    <div class="col-lg-10 col-md-10">
                                                        <asp:TextBox ID="tbOrg" runat="server" MaxLength="100" CssClass="single-input" placeholder="Organization Name" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbOrg" CssClass="errorMsg" ErrorMessage="*Organization name required" Display="Dynamic" runat="server" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        *Phone Number:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox ID="tbOrgPhone" runat="server" MaxLength="20" CssClass="single-input" placeholder="Phone Number" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbOrgPhone" CssClass="errorMsg" ErrorMessage="*Phone number required" Display="Dynamic" runat="server" />
                                                    </div>

                                                    <div class="col-lg-2 col-md-2">
                                                        Fax Number:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox ID="tbFax" runat="server" MaxLength="20" CssClass="single-input" placeholder="Fax Number" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        Website Address:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox runat="server" ID="tbWebsite" MaxLength="50" CssClass="single-input" placeholder="i.e., www.yourshelter.com" />
                                                    </div>

                                                    <div class="col-lg-2 col-md-2">
                                                        Facebook Link:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox runat="server" ID="tbFacebook" MaxLength="250" CssClass="single-input" placeholder="Facebook Link" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        Twitter Link:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox runat="server" ID="tbTwitter" MaxLength="250" CssClass="single-input" placeholder="Twitter Link" />
                                                    </div>

                                                    <div class="col-lg-2 col-md-2">
                                                        Pinterest Link:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox runat="server" ID="tbPinterest" MaxLength="250" CssClass="single-input" placeholder="Pinterest Link" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        Blog Link:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox runat="server" ID="tbBlog" MaxLength="250" CssClass="single-input" placeholder="Blog Link" />
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

                                                <h3 class="mb-10">My Organization's Contact Person</h3>

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        *First Name:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
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
                                                    <div class="col-lg-2 col-md-2">
                                                        Title:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox ID="tbContactTitle" runat="server" MaxLength="20" CssClass="single-input" placeholder="Title" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        *Phone:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox ID="tbPhone" runat="server" MaxLength="20" CssClass="single-input" placeholder="Phone" />
                                                        <asp:RequiredFieldValidator ControlToValidate="tbPhone" CssClass="errorMsg" ErrorMessage="*Phone required" Display="Dynamic" runat="server" />
                                                    </div>
                                                </div>

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        *Email Address:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:TextBox ID="tbEmail" runat="server" MaxLength="100" CssClass="single-input" placeholder="Email Address" />
                                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="tbEmail" CssClass="errorMsg" ErrorMessage="*Email is required" Display="Dynamic" />
                                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="tbEmail"
                                                            ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"
                                                            ErrorMessage="*That is not a valid email"
                                                            Display="dynamic" />
                                                    </div>
                                                    <div class="col-lg-2 col-md-2">
                                                        Language Preference:
                                                    </div>
                                                    <div class="col-lg-4 col-md-4">
                                                        <asp:DropDownList runat="server" ID="ddlLang" CssClass="single-input nice-select">
                                                            <asp:ListItem Value="English" Text="English" Selected="true" />
                                                            <asp:ListItem Value="French" Text="French" />
                                                        </asp:DropDownList>
                                                    </div>
                                                </div>

                                            </div>

                                            <div class="section-top-border">

                                                <h3 class="mb-10">Shipping Address</h3>

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        *Address:
                                                    </div>
                                                    <div class="col-lg-10 col-md-10">
                                                        <asp:TextBox ID="tbSAddress" runat="server" MaxLength="50" CssClass="single-input" placeholder="Address" />
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

                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                    </div>
                                                    <div class="col-lg-10 col-md-10">
                                                        <asp:CheckBox runat="server" ID="chkMailing" Text="Mailing Address is the same as Shipping Address" AutoPostBack="true" OnCheckedChanged="chkMailing_Click" Checked="true" />
                                                    </div>
                                                </div>
                                            </div>

                                            <asp:Panel runat="server" ID="pnlMailing" Visible="false">
                                                <div class="section-top-border">
                                                    <h3 class="mb-10">Mailing Address</h3>

                                                    <div class="row mt-10">
                                                        <div class="col-lg-2 col-md-2">
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


                                            <div class="section-top-border">
                                                <h3 class="mb-10">Adoption Information</h3>

                                                <p>
                                                    Please enter the number of projected adoptions you will have during this year's Home 4 The Holidays <b>October 1st-January 4th </b>
                                                </p>

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


                                                <div class="row mt-10">
                                                    <div class="col-lg-3 col-md-3">
                                                        *How did you hear about us?
                                                    </div>
                                                    <div class="col-lg-9 col-md-9">

                                                        <asp:DropDownList runat="server" ID="ddlRefer" CssClass="single-input dropdown-scrollable nice-select" MaxLength="100">
                                                            <asp:ListItem Text="--Choose One--" Value="" Selected="true"></asp:ListItem>
                                                            <asp:ListItem Text="HSUS Expo" Value="HSUS Expo"></asp:ListItem>
                                                            <asp:ListItem Text="Blue Buffalo" Value="Blue Buffalo"></asp:ListItem>
                                                            <asp:ListItem Text="Best Friends" Value="Best Friends"></asp:ListItem>
                                                            <asp:ListItem Text="Conference" Value="Conference"></asp:ListItem>
                                                            <asp:ListItem Text="Delta Article" Value="Delta Article"></asp:ListItem>
                                                            <asp:ListItem Text="Direct Mail" Value="Direct Mail"></asp:ListItem>
                                                            <asp:ListItem Text="Direct Email" Value="Direct Email"></asp:ListItem>
                                                            <asp:ListItem Text="Friend" Value="Friend"></asp:ListItem>
                                                            <asp:ListItem Text="Google" Value="Google"></asp:ListItem>
                                                            <asp:ListItem Text="Helen Woodward Animal Center" Value="Helen Woodward Animal Center"></asp:ListItem>
                                                            <asp:ListItem Text="Hugs For Homeless" Value="Hugs For Homeless"></asp:ListItem>
                                                            <asp:ListItem Text="Humane Society Conference" Value="Humane Society Conference"></asp:ListItem>
                                                            <asp:ListItem Text="Other Shelter" Value="Other Shelter"></asp:ListItem>
                                                            <asp:ListItem Text="Other" Value="Other"></asp:ListItem>
                                                            <asp:ListItem Text="Petco" Value="Petco"></asp:ListItem>
                                                            <asp:ListItem Text="Petfinder.com" Value="Petfinder.com"></asp:ListItem>
                                                            <asp:ListItem Text="Previous Participant" Value="Previous Participant"></asp:ListItem>
                                                            <asp:ListItem Text="Shelter Source" Value="Shelter Source"></asp:ListItem>
                                                            <asp:ListItem Text="Yahoo Groups" Value="Yahoo Groups"></asp:ListItem>

                                                        </asp:DropDownList>
                                                        <asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="req_Refer" CssClass="errorMsg" ControlToValidate="ddlRefer" ErrorMessage="*Reference is required" />
                                                    </div>
                                                </div>
                                            </div>

                                            <div class="title text-center">
                                                <asp:Button ID="btnRegister" OnClick="btnRegister_Click" CssClass="genric-btn primary small round-border" runat="server" Text="Register Your Shelter!" />
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
