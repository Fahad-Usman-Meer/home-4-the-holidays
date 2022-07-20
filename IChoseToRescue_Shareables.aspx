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
    <section class="relative my-banner" style="background: url(/img/banners/keyboard-cat-banner.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">Downloadable Shareables</h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a href="/downloads.aspx">Downloads</a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a href="/messaging-guidelines.aspx">Messaging &amp; Guidelines</a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Downloadable Shareables</a>
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

            <div class="section-top-border">

                <div class="title text-center">
                    <p>Click on image to see preview and <em><b>right click</b> (Save Image As...)</em> to save the images.</p>
                </div>

                <h3>Downloadable Shareables</h3>
                <div class="row gallery-item">
                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_Contest_Sharable-1.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/2021/H4TH21_Contest_Sharable-1.jpg);"></div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_Contest_Sharable-2.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/2021/H4TH21_Contest_Sharable-2.jpg);"></div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_Contest_Sharable-3.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/2021/H4TH21_Contest_Sharable-3.jpg);"></div>
                        </a>
                    </div>

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_Contest_Sharable-4.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/2021/H4TH21_Contest_Sharable-4.jpg);"></div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_Contest_Sharable-5.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/2021/H4TH21_Contest_Sharable-5.jpg);"></div>
                        </a>
                    </div>
                </div>
            </div>

            <div class="section-top-border">
                <h3>Contest Story Sharables</h3>
                <div class="row gallery-item">

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_Contest_Story-Sharable-1.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/2021/H4TH21_Contest_Story-Sharable-1.jpg);"></div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_Contest_Story-Sharable-2.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/2021/H4TH21_Contest_Story-Sharable-2.jpg);"></div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_Contest_Story-Sharable-3.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/2021/H4TH21_Contest_Story-Sharable-3.jpg);"></div>
                        </a>
                    </div>

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_Contest_Story-Sharable-4.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/2021/H4TH21_Contest_Story-Sharable-4.jpg);"></div>
                        </a>
                    </div>
                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_Contest_Story-Sharable-5.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/2021/H4TH21_Contest_Story-Sharable-5.jpg);"></div>
                        </a>
                    </div>

                </div>
            </div>

            <div class="section-top-border">
                <h3>Overlay Sharables</h3>
                <div class="row gallery-item">

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/H4TH20_Overlay_Story-Sharable.png" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/H4TH20_Overlay_Story-Shareable-Frame.png);"></div>
                        </a>
                        <div class="row justify-content-center mt-20">
                            <a class="genric-btn primary small" href="_images/Social-Shares/H4TH20_Overlay_Story-Sharable.tif">Click to Download</a>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/H4TH20_Overlay_Sharable.png" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/H4TH20_Overlay-Shareable-Frame.png);"></div>
                        </a>
                        <div class="row justify-content-center mt-20">
                            <a class="genric-btn primary small" href="_images/Social-Shares/H4TH20_Overlay_Sharable.tif">Click to Download</a>
                        </div>
                    </div>

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/H4TH20_Overlay_FB-Frame.png" class="img-gal">
                            <div class="single-gallery-image" style="background: url(_images/Social-Shares/H4TH20_Overlay-facebook-Frame.png);"></div>
                        </a>
                        <div class="row justify-content-center mt-20">
                            <a class="genric-btn primary small" href="_images/Social-Shares/H4TH20_Overlay_FB-Frame.tif">Click to Download</a>
                        </div>
                    </div>

                </div>
            </div>

            <div class="section-top-border">
                <h3>Social Sharables</h3>
                <div class="row gallery-item">

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_SocialSharables 1.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url('_images/Social-Shares/2021/H4TH21_SocialSharables 1.jpg');"></div>
                        </a>
                    </div>

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_SocialSharables 2.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url('_images/Social-Shares/2021/H4TH21_SocialSharables 2.jpg');"></div>
                        </a>
                    </div>

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_SocialSharables 3.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url('_images/Social-Shares/2021/H4TH21_SocialSharables 3.jpg');"></div>
                        </a>
                    </div>

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_SocialSharables 4.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url('_images/Social-Shares/2021/H4TH21_SocialSharables 4.jpg');"></div>
                        </a>
                    </div>

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_SocialSharables 5.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url('_images/Social-Shares/2021/H4TH21_SocialSharables 5.jpg');"></div>
                        </a>
                    </div>

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_SocialSharables 6.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url('_images/Social-Shares/2021/H4TH21_SocialSharables 6.jpg');"></div>
                        </a>
                    </div>

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_SocialSharables 7.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url('_images/Social-Shares/2021/H4TH21_SocialSharables 7.jpg');"></div>
                        </a>
                    </div>

                    <div class="col-md-4">
                        <a href="_images/Social-Shares/2021/H4TH21_SocialSharables 8.jpg" class="img-gal">
                            <div class="single-gallery-image" style="background: url('_images/Social-Shares/2021/H4TH21_SocialSharables 8.jpg');"></div>
                        </a>
                    </div>


                </div>
            </div>

        </div>
    </section>
    <%--End about-info Area--%>

</asp:Content>
