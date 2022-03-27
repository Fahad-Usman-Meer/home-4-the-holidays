<%@ Page Language="VB" MasterPageFile="~/template.master" Title=" Home 4 The Holidays" Debug="true" %>

<script runat="server">
    Sub Page_Load(obj As Object, e As EventArgs)
        Session.Abandon()
        FormsAuthentication.SignOut()
        'response.Redirect("logout.aspx")
    End Sub

</script>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
</asp:Content>

<%--<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">Home 4 The Holidays</asp:Content>--%>
<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/family-with-dog-porch-banner-2.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">Home 4 The Holidays</h1>
                    <p class="text-white link-nav">
                        <a href="/members/index.aspx">Members Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Log out</a>
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
                        <h1 class="mb-10">Logged Out</h1>
                    </div>
                    <div class="whole-wrap mb-20">
                        <div class="container">
                            <div class="section-top-border">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">
                                        <h3 class="mb-10">You have been logged out. Thank You for Participating in Home 4 The Holidays!</h3>
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
