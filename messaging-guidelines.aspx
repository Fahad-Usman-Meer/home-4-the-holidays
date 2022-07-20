<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Downloads- Home 4 The Holidays" Debug="true" %>

<script runat="server">
    Sub page_load(obj As Object, e As EventArgs)
        'response.Redirect("https://join.home4theholidays.org/How-To-Guide")

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
                    <h1 class="text-white">Messaging &amp; Guidelines</h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a href="/downloads.aspx">Downloads</a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Messaging &amp; Guidelines</a>
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
                    <div class="title">
                        <h3 class="mb-10">Messaging &amp; Guidelines</h3>
                    </div>
                    <p>One of the important components of your organization&rsquo;s involvement in Home 4 the Holidays will be creating materials and an on-line presence that explains what the program is about and why it is so important.&nbsp; It is critical to make sure that everyone in your organization is prepared with background information and is giving out the same message whether it is through social media or an on-air interview.</p>


                    <div class="whole-wrap">
                        <div class="container">
                            <div class="section-top-border">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">

                                        <h3 class="mb-20">Download Links</h3>

                                        <div class="row mt-10">
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How To Guide/Messaging and Guidelines/H4TH21_onepage.pdf" class="genric-btn primary ee-large">HOME 4 THE HOLIDAYS FLYER<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-download"></span></a>
                                            </div>
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How To Guide/Messaging and Guidelines/2B Pet Adoption Stats and Facts 2019.doc" class="genric-btn primary ee-large">PET ADOPTION STATS AND FACTS<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-download"></span></a>
                                            </div>
                                        </div>
                                        
                                        <div class="row mt-10">
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How To Guide/Messaging and Guidelines/2A Home 4 the Holidays Fact Sheet 2019.doc" class="genric-btn primary ee-large">HOME 4 THE HOLIDAYS FACT SHEET<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-download"></span></a>
                                            </div>
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How To Guide/Messaging and Guidelines/2D Interview Tips and Guidelines.doc" class="genric-btn primary ee-large">INTERVIEW TIPS AND GUIDELINES<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-download"></span></a>
                                            </div>
                                        </div>
                                        
                                        <div class="row mt-10">
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How To Guide/Messaging and Guidelines/2C How to Increase Adoptions Through Social Media 2021.docx" class="genric-btn primary ee-large">HOW TO INCREASE ADOPTIONS THROUGH SOCIAL MEDIA<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-download"></span></a>
                                            </div>
                                            <div class="col-lg-6 col-md-6">
                                                <a href="IChoseToRescue_Shareables.aspx" target="_blank" class="genric-btn primary ee-large">SOCIAL MEDIA SHAREABLES<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-exit"></span></a>
                                            </div>
                                        </div>
                                        
                                        <div class="row mt-10">
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How-To-Guide-2013/Mike_Arms_photos.zip" class="genric-btn primary ee-large">MIKE ARMS IMAGES<span style="padding-left: inherit;font-size: large;font-weight: bold;" class="lnr lnr-download"></span></a>
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
