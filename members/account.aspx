<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Account Management- Home 4 The Holidays" Debug="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SQLClient" %>

<script runat="server">
    Sub Page_Load(obj As Object, e As EventArgs)
        If Session("UserId") = "" Then Response.Redirect("../login.aspx?ReturnURL=../home4theholidays/members/Account.aspx")

        If Not Page.IsPostBack Then 'load fields
            Dim db As New HWAC.DatabaseH4TH
            Dim objReader As SqlDataReader
            Dim StrSQL As String
            StrSQL = "SELECT UserName, Password, Email, Hint FROM tblUsers WHERE (UserID=" & Session("UserID") & ")"
            objReader = db.GetReader(StrSQL)
            If Not objReader Is Nothing Then 'has found data
                With objReader
                    While .Read() 'fill text boxes
                        tbUserName.Text = .GetString(0)
                        tbPassword.Attributes("value") = .GetString(1)
                        tbPassword2.Attributes("value") = .GetString(1)
                        tbEmail.Text = .GetString(2)
                        tbHint.Text = .GetString(3)
                    End While
                End With
            Else ' did not find data
                lblMessage.Text = "Account data not found. Please try again later. Thanks!"
                form1.Visible = False

            End If
        End If
    End Sub

    Sub btnUpdate_Click(obj As Object, e As EventArgs)
        Dim StrSQL As String
        Dim db As New HWAC.DatabaseH4TH
        'check for duplicate username!
        StrSQL = "SELECT UserId FROM tblUsers WHERE Userid<>" & Session("UserId") & " And Username='" & tbUserName.Text & "'"
        If db.ExecuteScalar(StrSQL) = "" Then 'no duplicate-ok to commit
            'Update databaseH4TH h4th table with session, userid and fields 'call hwac.user.excecutenonquery
            StrSQL = "UPDATE tblUsers SET Username='" & Replace(tbUserName.Text, "'", "''") & "', Password='" & Replace(tbPassword.Text, "'", "''") & "', Hint='" & Replace(tbHint.Text, "'", "''") & "', Email='" & tbEmail.Text & "' WHERE UserID=" & Session("UserID")
            If db.ExecuteNonQuery(StrSQL) Then 'successfull update
                form1.Visible = False
                lblMessage.Text = "Account successfully updated!"
                Dim objMM As New HWAC.EmailMessage
                With objMM
                    .MailTo = "lonjones@hotmail.com"
                    .From = "Account Update <lonj@animalcenter.org>"
                    .Subject = "Account Update"
                    .Body = "Account " & Session("UserID") & " " & Session("ShelterName") & " Updated."
                    .Send_Email(objMM)
                End With

            Else
                lblMessage.Text = "There was a problem updating. Please try again.  Thank You!"
            End If

        Else 'found duplicate username
            lblMessage.Text = "The Username you have chosen is already taken.  Please try another."
        End If

    End Sub

</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <%--  <link rel="stylesheet" href="../_css/thickbox.css" type="text/css" media="screen" />
    <link href="../_css/style2.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
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
                    <h1 class="text-white">H4TH Members</h1>
                    <p class="text-white link-nav">
                        <a href="/members/index.aspx">Members Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Edit Account</a>
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
                        <h1 class="mb-10">Edit Account Information</h1>
                    </div>
                    <div class="whole-wrap mb-20">
                        <div class="container">
                            <div class="section-top-border">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">

                                        <p>
                                            <asp:Label ID="lblMessage" ForeColor="#FF0000" Font-Bold="true" runat="server" />
                                        </p>

                                        <form runat="server" id="form1">
                                            <p>Click &quot;Update Account&quot; to save any changes to your account.</p>

                                            <h3 class="mb-10">Account Information</h3>

                                            <asp:ValidationSummary runat="server" ShowMessageBox="true" CssClass="errorMsg" ShowSummary="false" ID="VSum" HeaderText="Please fill out all the required fields appropriately" />

                                            <asp:Panel ID="pnlRegister" runat="server">
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


                                                <div class="row mt-10">
                                                    <div class="col-lg-2 col-md-2">
                                                        *Email Address:
                                                    </div>
                                                    <div class="col-lg-6 col-md-6">
                                                        <asp:TextBox ID="tbEmail" runat="server" MaxLength="100" CssClass="single-input" placeholder="Email Address" />
                                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="tbEmail" CssClass="errorMsg" ErrorMessage="*Email is required" Display="Dynamic" />
                                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="tbEmail"
                                                            ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"
                                                            ErrorMessage="*That is not a valid email"
                                                            Display="dynamic" />
                                                    </div>
                                                </div>



                                                <div class="title text-center mt-30">
                                                    <asp:Button ID="btnUpdate" OnClick="btnUpdate_Click" CssClass="genric-btn primary small round-border" runat="server" Text="Update Account" />
                                                </div>
                                            </asp:Panel>

                                            <asp:Panel runat="server" ID="pnlMailing" Visible="false"></asp:Panel>
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
