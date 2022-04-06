<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Downloads- Home 4 The Holidays" Debug="true" %>

<script runat="server">
    Sub page_load(obj As Object, e As EventArgs)
        'response.Redirect("http://join.home4theholidays.org/How-To-Guide")

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
    <section class="relative my-banner" style="background: url(/img/banners/love-dog-chinese-family-banner.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">How To Make Your Campaign a Success</h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a href="/downloads.aspx">Downloads</a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>How To Make Your Campaign a Success</a>
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
                    <%--<div class="title text-center">
                        <h1 class="mb-10">Materials to help you increase adoptions</h1>
                    </div>--%>

                    <div class="title">
                        <h3 class="mb-10">How To Make Your Campaign a Success</h3>
                    </div>
                    <p>
                        There are several important elements involved in making your Campaign a success including working with the local government and utilizing the media.&nbsp; Please go through each one carefully and formulate a customized plan that will work for your organization.&nbsp;
                    </p>


                    <div class="whole-wrap">
                        <div class="container">
                            <div class="section-top-border">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">

                                        <h3 class="mb-20">Download Links</h3>

                                        <div class="row mt-10">
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How To Guide/How to Make Your Campaign a Success/1C What's Next (Executing Your Event) 2019.doc" class="genric-btn primary ee-large">WHAT'S NEXT? (EXECUTING YOUR EVENT)<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-download"></span></a>
                                            </div>
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How To Guide/How to Make Your Campaign a Success/1B How to Create an Adoption Event 2019.doc" class="genric-btn primary ee-large">HOW TO CREATE AN ADOPTIONS EVENT<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-download"></span></a>
                                            </div>
                                        </div>
                                        
                                        <div class="row mt-10">
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How To Guide/How to Make Your Campaign a Success/1E %23IChoseToRescue Contest (Previously the Most Heartwarming Story contest) - 2021.doc" class="genric-btn primary ee-large">ENTER THE #IChoseToRescue CONTEST<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-download"></span></a>
                                            </div>
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How To Guide/How to Make Your Campaign a Success/1E #IChoseToRescue Contest (Previously the Most Heartwarming Story contest) 2019.doc" class="genric-btn primary ee-large">ENTER TIMELINE AND CHECKLIST<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-download"></span></a>
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
