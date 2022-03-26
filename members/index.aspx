<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Member Home Page- Home 4 The Holidays" Debug="true" %>

<script runat="server">
    Sub Page_load(obj As Object, e As EventArgs)
        If Not Page.IsPostBack Then
            If Session("UserId") = "" Then Response.Redirect("../login.aspx?ReturnURL=../home4theholidays/members/index.aspx")

            'check for management updates
            '------------------------------------------------------
            'Dim p as IPrincipal = HttpContext.Current.User
            'if p.IsInRole("Admin") then
            If Session("Admin") = "@F@EWE$" Then

                If Request.QueryString("ShelterName") <> "" Then
                    Session("ShelterName") = Request.QueryString("ShelterName")
                    Session("UserId") = Request.QueryString("SID")
                End If
            End If
            '------------------------------------------------------
            'Check if this is the first time to this page-querystring from registration page= FirstTime=true
            If Request.QueryString("FirstTime") = "true" Then 'came from registration
                lblmessage.Text = "<h3>Welcome to the Home 4 The Holidays pet adoption program!</h3>  <br><p>ATTENTION! YOU MUST CLICK THE VERIFICATION LINK IN THE EMAIL SENT TO YOU BEFORE YOUR PROFILE WILL BE PUBLIC.</p><p>This email also contains your Username and Password. Please keep it handy so you can log in and record your adoptions during the event as well as having access to many free services that this program offers!<br><br><b>Congratulations</b>, you are well on your way to saving many lives this holiday season!"
            Else 'return visitor
                lblmessage.Text = "<h3>" & Session("ShelterName") & " Homepage</h3><br><p>Welcome to your organization's personal homepage. Don't forget to record your weekly adoptions right here during the campaign by clicking the ""<b><u><a href=""adoptions.aspx"">Record Adoptions</a></u></b>"" link.</p>"
            End If
        End If
    End Sub

</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <%--<link rel="stylesheet" href="../_css/thickbox.css" type="text/css" media="screen" />
    <link href="../_css/style2.css" rel="stylesheet" type="text/css" />--%>
</asp:Content>


<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    <section id="divHomeCover" class="banner-area relative" style="background: rgba(0, 0, 0, 0) url(/img/banners/pet-dog-1.jpg) repeat scroll center center;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row fullscreen align-items-center justify-content-between" style="height: 545px;">
                <div class="col-lg-6 col-md-6 banner-left">
                    <h3 id="main-bold-text" class="text-white">Home 4 The Holidays</h3>
                    <h1 class="text-white">for Members</h1>
                    <hr>
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
                        <h1 class="mb-10"><b>16 million</b> pets have gone "Home 4 the Holidays" <b>since 1999!</b></h1>
                    </div>

                    <asp:Label ID="lblmessage" runat="server" />
                    <br />
                    <p>You are joining over 4,200 shelters and rescue organizations, in  over 24 countries, working to secure forever homes for orphan pets. Please  check the list of participants. If you notice that other groups in your area  are NOT enrolled, please <u><b><a href="../invite.aspx">invite</a></b></u> them to join us. It's never too late to enroll! All they  need is a desire to increase adoptions, help lower euthanasia rates, and take  business away from puppy mills and backyard breeders during their most  profitable time of year.</p>


                    <p>
                        <h3 class="mt-20 mb-10">
                            <strong>Why is this campaign successful?</strong>
                        </h3>
                    </p>
                    <p>
                        Because of you! Concentrate on quality adoptions and we'll reach  our Home 4 the Holidays goal&nbsp;<b>one adoption at a time.</b> We&rsquo;re working  together to find families for orphan pets during the time of year when they are  most likely to get new pets.
            <br>
                        Thank you for being a part of Blue Buffalo® Home 4 the Holidays  ®... the most successful pet adoption drive in history!
                        </p>
                </div>
            </div>
        </div>
    </section>
    <%--End about-info Area--%>





    <%--<h1 class="grn_ttl_blg">16 million pets have gone "Home 4 the Holidays" since 1999!<br></h1>--%>
    <div class="feature">
        <%--<p>
            <asp:Label ID="lblmessage" runat="server" />
        </p>--%>
        <%--<p>You are joining over 4,200 shelters and rescue organizations, in  over 24 countries, working to secure forever homes for orphan pets. Please  check the list of participants. If you notice that other groups in your area  are NOT enrolled, please <a href="../invite.aspx">invite</a> them to join us. It's never too late to enroll! All they  need is a desire to increase adoptions, help lower euthanasia rates, and take  business away from puppy mills and backyard breeders during their most  profitable time of year.</p>--%>

        <%--        <p>
            <strong><em>Why is this campaign successful?</em></strong>
            <br>
            Because of you! Concentrate on quality adoptions and we'll reach  our Home 4 the Holidays goal&nbsp;<em>one adoption at a time.</em> We&rsquo;re working  together to find families for orphan pets during the time of year when they are  most likely to get new pets.
            <br>
            Thank you for being a part of Blue Buffalo® Home 4 the Holidays  ®... the most successful pet adoption drive in history!
        </p>--%>
    </div>
</asp:Content>
