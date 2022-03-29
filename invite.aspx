<%@ Page Language="VB" MasterPageFile="~/template.master" Title=": Blue Buffalo Home 4 the Holidays – Invite a Shelter | Helen Woodward Animal Center" Debug="true" %>

<script runat="server">

    Sub Page_Load(sender As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            Dim objFocus As New HWAC.Utility
            RegisterStartupScript("FirstFocus", objFocus.MakeFocusScript(Me.txtFromName))

            lblMessage.Text = "I would like to invite you to join Blue Buffalo Home 4 the Holidays, the largest pet adoption campaign in the world! This adoption campaign raises awareness for pet adoption, puts puppy mills out of business and increases adoptions for animal shelters around the world. <u><a href=""http://www.home4theholidays.org"">Click Here</a></u> to learn more!"
        End If

    End Sub

    Sub Send_Email(sender As Object, e As EventArgs)
        Dim strSQL As String
        Dim IpTotal As String
        Dim objMM As New HWAC.EmailMessage()
        If txtCCEmail.Text <> "" Then
            objMM.CC = txtCCEmail.Text
        End If
        objMM.MailTo = txtToEmail.Text
        objMM.From = txtFromName.Text & " <" & txtFromEmail.Text & ">"
        objMM.Bcc = "lonj@animalcenter.org;" & txtBCCEmail.Text
        objMM.Subject = txtFromName.Text & " has sent you a message about Home 4 the Holidays!"
        objMM.Body = lblMessage.Text & vbCrLf & "<hr>" & txtMessage.Text & "<br><hr>"
        Dim Result As String
        Dim strBody As String = objMM.Body
        If Request.ServerVariables("REMOTE_ADDR") <> "121.54.49.85" Then 'fraud
            'check for fraud
            Dim objGetData As New HWAC.DatabaseSEC

            'Get Total Shelters
            strSQL = "SELECT COUNT(pkey) AS IPCount FROM [DwSQL_access].[tblWebsiteDatalog] WHERE  (DATEDIFF(hour, CreateDate, getdate()) <= 2) AND ip='" & Request.ServerVariables("REMOTE_ADDR") & "'"
            IpTotal = objGetData.ExecuteScalar(strSQL)
            'response.Write(iptotal & strsql)
            'exit sub
            If IpTotal < 3 Then
                Result = objMM.Send_Email(objMM)
            End If
        End If
        If Result <> "" Then
            lblMessage.Text = Result
        Else

            form1.Visible = False
            lblThanks.Visible = True
            pnlIntro.Visible = False
            lblThanks.Text = "<h3>Thank you, " & txtFromName.Text & ", your message has been sent.  <br><br>Thank you for supporting the Home 4 The Holidays program!</h3>"
            If IpTotal < 4 Then
                Dim db As New HWAC.DatabaseSEC
                Dim str1 As String

                str1 = "INSERT INTO [DwSQL_access].[tblWebsiteDatalog] (data,source,ip) values('" & Replace(Left(strBody, 3950), "'", "''") & "','h4th/invite.aspx','" & Request.ServerVariables("REMOTE_ADDR") & "')"
                db.ExecuteNonQuery(str1)
            End If
        End If
    End Sub
</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Invite an animal shelter or rescue to join the Blue Buffalo home 4 the Holidays pet adoption campaign." />
    <meta name="keywords" content="pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />
</asp:Content>


<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/family-with-dog-porch-banner-2.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">Spread The Word</h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home</a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Invite Shelters</a>
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
                        <h1 class="mb-10">Invite Shelters To Join Blue Buffalo Home 4 the Holidays</h1>
                    </div>
                    <div class="whole-wrap mb-20">
                        <div class="container">
                            <div class="section-top-border">

                                <p>
                                    <asp:Label ID="lblThanks" runat="server" Visible="false" />
                                </p>

                                <asp:Panel ID="pnlIntro" runat="server">
                                    <p>The orphan pets need your help! Invite other animal shelters or rescues you know to join in this life-saving effort! More shelters joining Home 4 the Holidays, means more pets will spend this holiday season in a loving home.</p>
                                    <p> Fill out the form below. To add multiple addresses to the CC or BCC, <b>separate addresses with a semicolon</b>. 
                                        <em>(Example: petadoptionshelter@domain.com;  myfriend@domain.com) </em></p>
                                </asp:Panel>

                                <div class="row">
                                    <div class="col-lg-12 col-md-12">

                                        <form runat="server" id="form1">
                                            
                                            <%--<h3 class="mb-10">Account Information</h3>--%>

                                            <asp:ValidationSummary runat="server" ShowMessageBox="true" CssClass="errorMsg" ShowSummary="false" ID="VSum" HeaderText="Please fill out all the required fields appropriately" />

                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2">
                                                    *Your Name:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox ID="txtFromName" runat="server" MaxLength="50" CssClass="single-input" placeholder="Your Name" />
                                                    <asp:RequiredFieldValidator runat="server" CssClass="errorMsg" ControlToValidate="txtFromName" ErrorMessage="*Your name is required" Display="Dynamic" />
                                                </div>
                                            </div>

                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2">
                                                    *Your Email:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox ID="txtFromEmail" runat="server" MaxLength="50" CssClass="single-input" placeholder="Your Email" />
                                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFromEmail" CssClass="errorMsg" ErrorMessage="*Your email is required" Display="Dynamic" />
                                                    <asp:RegularExpressionValidator runat="server"  CssClass="errorMsg" ControlToValidate="txtFromEmail"
                                                        ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"
                                                        ErrorMessage="*That is not a valid email"
                                                        Display="dynamic" />
                                                </div>
                                            </div>

                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2">
                                                    *To Email:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox ID="txtToEmail" runat="server" MaxLength="50" CssClass="single-input" placeholder="To Email" />
                                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="txtToEmail" CssClass="errorMsg" ErrorMessage="*To Email is required" Display="Dynamic" />
                                                    <asp:RegularExpressionValidator runat="server"  CssClass="errorMsg" ControlToValidate="txtToEmail"
                                                        ValidationExpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$"
                                                        ErrorMessage="*That is not a valid email"
                                                        Display="dynamic" />
                                                </div>
                                                <div class="col-lg-4 col-md-4">
                                                    <p>One email only</p>
                                                </div>
                                            </div>

                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2">
                                                    CC Email:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox ID="txtCCEmail" runat="server" MaxLength="200" CssClass="single-input" placeholder="CC Email" />
                                                </div>
                                                <div class="col-lg-4 col-md-4">
                                                    <p>Separate multiple with a semicolon</p>
                                                </div>
                                            </div>
                                            
                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2">
                                                    BCC Email:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox ID="txtBCCEmail" runat="server" MaxLength="200" CssClass="single-input" placeholder="BCC Email" />
                                                </div>
                                                <div class="col-lg-4 col-md-4">
                                                    <p>Separate multiple with a semicolon</p>
                                                </div>
                                            </div>
                                            
                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2">
                                                    Your message will read:
                                                </div>
                                                <div class="col-lg-10 col-md-10">
                                                    <p>
                                                        <asp:Label ID="lblMessage" BackColor="#FFFF99" runat="server" CssClass="single-input" />
                                                    </p>
                                                </div>
                                            </div>

                                            <div class="row mt-10">
                                                <div class="col-lg-2 col-md-2">
                                                    Add a personal message:
                                                </div>
                                                <div class="col-lg-6 col-md-6">
                                                    <asp:TextBox ID="txtMessage" CssClass="common-textarea form-control" runat="server" Height="100" MaxLength="255" TextMode="MultiLine" Wrap="true"/>
                                                </div>
                                            </div>


                                            <div class="title text-center mt-30">
                                                <asp:Button ID="submit" OnClick="Send_Email" CssClass="genric-btn primary small round-border" runat="server" Text="Send Email" />
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
