<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Blue Buffalo Home 4 the Holidays - Contact Information | Helen Woodward Animal Center" Debug="false" %>

<script runat="server">

    Sub Page_Load(sender As Object, e As EventArgs)


    End Sub


</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Have a question about Blue Buffalo Home 4 the Holidays? Feel free to call or email Helen Woodward Animal Center." />
    <meta name="keywords" content="pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />

</asp:Content>

<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/family-with-dog-porch-banner-2.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">We're Here To Help</h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Contact Us</a>
                    </p>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<%-- End banner Area --%>



<asp:Content ID="navigation" ContentPlaceHolderID="Leftnav" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="Server">


    <section class="contact-page-area section-gap mb-20">
        <div class="container">

            <p>
                Thanks for visiting our Blue Buffalo Home 4 the Holidays  website! We appreciate your interest in increasing adoptions around the world.
            </p>

            <div class="row mt-30">

                <asp:Label ID="lblThanks" runat="server" Visible="false" />
                <div class="col-lg-4 d-flex flex-column address-wrap">
                    <div class="single-contact-address d-flex flex-row"></div>
                    <div class="single-contact-address d-flex flex-row">
                        <p>General Questions about Blue Buffalo Home 4 the Holidays</p>
                    </div>
                </div>
                <div class="col-lg-4 d-flex flex-column address-wrap">
                    
                    <div class="single-contact-address d-flex flex-row">
                        <div class="icon">
                            <span class="lnr lnr-phone"></span>
                        </div>
                        <div class="contact-details">
                            <h5>858-756-4117, ext. 302</h5>
                        </div>
                    </div>

                    <div class="single-contact-address d-flex flex-row">
                        <div class="icon">
                            <span class="lnr lnr-envelope"></span>
                        </div>
                        <div class="contact-details">
                            <h5>
                                <a href="mailto:LauraS@animalcenter.org?Subject=Blue Buffalo Home 4 The Holidays Inquiry">LauraS@animalcenter.org
                                </a>
                            </h5>
                            <p>(General email inquiries)</p>
                        </div>
                    </div>

                    <div class="single-contact-address d-flex flex-row">
                        <div class="icon">
                            <span class="lnr lnr-envelope"></span>
                        </div>
                        <div class="contact-details">
                            <h5>
                                <a href="mailto:h4th@animalcenter.org?subject=H4TH Technology Inquiry">h4th@animalcenter.org
                                </a>
                            </h5>
                            <p>(Website/Login issues or Technology inquiries email)</p>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </section>

</asp:Content>
