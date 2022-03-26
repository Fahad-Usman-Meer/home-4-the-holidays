<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Blue Buffalo Home 4 the Holidays Member Page | Helen Woodward Animal Center" Debug="True" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SqlClient" %>
<script runat="server">
    Sub page_load(obj As Object, e As EventArgs)
        'if not instr(1,request("ReturnURL"),"home4theholidays")>0 then 'not h4th login send to hwac login
        '	response.Redirect("http://www.animalcenter.org/HWACLogin.aspx?ReturnURL=" & request("ReturnURL"))
        'end if

        If Not Page.IsPostBack Then 'set focus to username
            Dim objFocus As New HWAC.Utility
            RegisterStartupScript("FirstFocus", objFocus.MakeFocusScript(Me.tbUsername))

            'check for auto login properties
            If Not Request.QueryString("p") = "" And Not Request.QueryString("l") = "" Then
                'auto login, look up username, password
                DoLogin(Request.QueryString("p"), "")
            End If

        End If
    End Sub
    Sub Login(obj As Object, e As EventArgs)
        If tbUsername.Text = "" Or tbPassword.Text = "" Then
            lblmessage.Text = "Please enter both a Username and a Password"
        Else
            DoLogin(tbUsername.Text, tbPassword.Text)
        End If
    End Sub
    Sub DoLogin(Username As String, Pass As String)

        Dim objUser As New HWAC.User
        Dim strResult As String

        strResult = objUser.LoginUser(Username, Pass) 'returns userid, in array
        If strResult <> "" Then 'returned vaild data 0=UserID, 1=Roles 2=ShelterName 
            Dim arrResult As Array
            arrResult = Split(strResult, "|")
            Session("UserID") = arrResult(0)
            If Session("UserID") = "1" Then
                Session("Admin") = "@F@EWE$"
            End If

            '----------------------------------------------------------------------------------------------------------------------------------------------------------------------
            'IMPLEMENT ROLES BASED SECURITY
            Dim authTicket As FormsAuthenticationTicket = New FormsAuthenticationTicket(1, arrResult(0), DateTime.Now, DateTime.Now.AddMinutes(10), False, arrResult(1))
            ' Now encrypt the ticket.
            Dim encryptedTicket As String = FormsAuthentication.Encrypt(authTicket)
            'Create a cookie and add the encrypted ticket to the cookie as data.
            Dim authCookie As HttpCookie = New HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket)
            'Add the cookie to the outgoing cookies collection.
            Response.Cookies.Add(authCookie)
            'Initialize other session variables
            Dim db As New HWAC.DatabaseH4TH
            Dim strSql As String
            Dim objReader As SqlDataReader

            strSql = "SELECT ShelterName FROM tblH4thReg WHERE ShelterId=" & Session("UserId")
            objReader = db.GetReader(strSql)
            If Not objReader Is Nothing Then
                While objReader.Read()
                    Session("ShelterName") = objReader.GetString(0)
                End While

            End If
            objReader.Close()
            'Redirect the user to the originally requested page
            ' Response.Redirect( FormsAuthentication.GetRedirectUrl(tbUserName.Text, false ))
            If Request.QueryString("l") <> "" Then
                If InStr(Request.QueryString("l"), "profile") > 0 Then Response.Redirect("members/profile.aspx")
                If InStr(Request.QueryString("l"), "adoptions") > 0 Then Response.Redirect("members/adoptions.aspx")
                If InStr(Request.QueryString("l"), "account") > 0 Then Response.Redirect("members/account.aspx")
                'if  request.QueryString("l") ="adoptions" then
                '	response.Redirect("members/adoptions.aspx")
                'elseif  request.QueryString("l") ="account" then 
                'response.Redirect("members/" & request.QueryString("l") & ".aspx")
                'response.Redirect("members/profile.aspx")
            Else
                Response.Redirect("members/index.aspx")
            End If
            '----------------------------------------------------------------------------------------------------------------------------------------------------------------------
        Else
            lblmessage.Text = "*That is not a valid Username and Password Combination*"
        End If

    End Sub

    Sub EmailHint(obj As Object, e As EventArgs)
        If Not tbUsername.Text = "" Then
            Dim objUser As New HWAC.User
            Dim EM As New HWAC.EmailMessage
            EM.From = "h4th@animalcenter.org"
            EM.Subject = "Home 4 The Holidays Password Hint"
            lblmessage.Text = objUser.EmailHint(tbUsername.Text, EM)
        Else
            lblmessage.Text = "*Please enter a Username to receive a password hint*"
        End If
    End Sub
</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Log into your Blue Buffalo Home 4 the Holidays account to update adoptions and manage your organization's contact information." />
    <meta name="keywords" content="pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />


</asp:Content>

<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/family-with-dog-porch-banner-2.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">Members Hompage
                    </h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Login</a>
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
                        <h1 class="mb-10">Blue&nbsp;Buffalo Home 4 The Holidays Member Login</h1>
                    </div>

                    <p>Please enter your username and password below. If you are a new user, click <a href="register.aspx"><u>here</u></a> to register.</p>

                    <div class="whole-wrap">
                        <div class="container">
                            <div class="section-top-border">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">

                                        <h3 class="mb-10">Choose Your Account Information</h3>

                                        <form runat="server">
                                            <asp:Label ID="lblmessage" runat="server" CssClass="errorMsg" Font-Bold="true" />
                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2"></div>
                                                <div class="col-lg-2 col-md-2">
                                                    *Username:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox ID="tbUsername" runat="server" CssClass="single-input" placeholder="Username" />
                                                </div>
                                            </div>
                                            
                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2"></div>
                                                <div class="col-lg-2 col-md-2">
                                                    *Password:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox ID="tbPassword" runat="server" CssClass="single-input" placeholder="Username" TextMode="Password"/>
                                                </div>
                                            </div>

                                            
                                                <div class="title text-center mt-10">
                                                    <asp:Button ID="btSubmit" runat="server" OnClick="Login" Text="Log In" CssClass="genric-btn primary small round-border" />
                                                </div>
                                            

                                            <div class="row mt-10" style="float: right;padding-right: 1em;">
                                                <asp:LinkButton ID="lnkbtnHint" Text="<u>Send me my password hint</u>" runat="server" OnClick="EmailHint" />
                                            </div>
                                            <br /> <br />
                                            <div class="row mt-10 ml-5" style="padding-right: 1em;">
                                                <p>If you cannot remember your username or password, please email&nbsp;<a href="mailto:h4th@animalcenter.org" target="_blank"><u>h4th@animalcenter.org</u></a>&nbsp;to retrieve them. Please do not create a duplicate profile as you will lose all of your shelter's history for the program.</p>
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
    <%--End about-info Area--%>


</asp:Content>
