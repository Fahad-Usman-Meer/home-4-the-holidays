<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Home 4 the Holidays - Free Pet Adoption Marketing | Helen Woodward Animal Center" Debug="false" %>

<script runat="server">
    Sub page_load(obj As Object, e As EventArgs)
        'response.Redirect("http://join.home4theholidays.org/How-To-Guide")

    End Sub
</script>
<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Want to increase pet adoptions for your animal shelter? Join Home 4 the Holidays and get the free pet adoption marketing How-To Guide!" />
    <meta name="keywords" content="pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />

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
    <section class="relative my-banner" style="background: url(/img/banners/family-with-dog-porch-banner-2.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">How To Guide
                    </h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Downloads (How To Guide)</a>
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
                        <h1 class="mb-10">Materials to help you increase adoptions</h1>
                    </div>

                    <div class="title">
                        <h3 class="mb-10">Welcome  to the Blue Buffalo Home 4 the Holidays How-To Guide</h3>
                    </div>

                    <p>Thank you for joining us in our efforts to save the lives of orphan pets this holiday season.&nbsp; The Blue Buffalo Home 4 the Holidays How-To Guide will provide a variety of helpful information  on everything from how to create a successful Home 4 the Holidays campaign in  your area to reporting and sharing your successes after you complete your  campaign.&nbsp; Each of the buttons below will provide more detailed information on that particular topic.</p>
                    <p align="center">
                        <iframe width="100%" height="415" src="https://youtube.com/embed/iMo1JHy07iQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen=""></iframe>
                        &nbsp;
                    </p>


                    <div class="whole-wrap">
                        <div class="container">
                            <div class="section-top-border">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">

                                        <h3 class="mb-20">Download Links</h3>

                                        <div class="row mt-10">
                                            <div class="col-lg-6 col-md-6">
                                                <a href="how-to-make-your-campaign-a-success.aspx" class="genric-btn primary ee-large">HOW TO MAKE YOUR CAMPAIGN A SUCCESS<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-arrow-right"></span></a>
                                            </div>
                                            <div class="col-lg-6 col-md-6">
                                                <a href="messaging-guidelines.aspx" class="genric-btn primary ee-large">MESSAGING & GUIDELINES<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-arrow-right"></span></a>
                                            </div>
                                        </div>
                                        
                                        <div class="row mt-10">
                                            <div class="col-lg-6 col-md-6">
                                                <a href="templates.aspx" class="genric-btn primary ee-large">TEMPLATES MATERIALS<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-download"></span></a>
                                            </div>
                                            <div class="col-lg-6 col-md-6">
                                                <a href="sharing-and-reporting-your-success.aspx" class="genric-btn primary ee-large">SHARING & REPORTING YOUR SUCCESS<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-arrow-right"></span></a>
                                            </div>
                                        </div>
                                        
                                        <div class="row mt-10">
                                            <div class="col-lg-6 col-md-6">
                                                <a href="successful-campaign-example.aspx" class="genric-btn primary ee-large">SUCCESSFUL CAMPAIGN EXAMPLE<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-arrow-right"></span></a>
                                            </div>
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

