<%@ Page Language="VB" MasterPageFile="~/template.master" Title="#IChoseToRescue Social Media Contest |  Home 4 the Holidays" Debug="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SQLClient" %>

<script runat="server">
    Sub page_load(obj As Object, e As EventArgs)

    End Sub
</script>



<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <style type="text/css">
        <!--
        .votes {
            font-weight: bold;
            font-size: 16px;
        }

        -->
    </style>
</asp:Content>

<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/pet-dog-1-banner.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">#IChoseToRescue Challenge
                    </h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>#IChoseToRescue Contest</a>
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
                        <h1 class="mb-10">#IChoseToRescue Challenge Returns</h1>
                    </div>
                    <p>
                        Our partner organizations deserve the best! That&rsquo;s why Helen Woodward Animal Center and  Blue Buffalo are again teaming up to give away&nbsp; <b>three times</b> the  prizes&nbsp;for Blue Buffalo Home 4 the Holidays 2021.
                        <br />
                        <br />
                        We want to show the  world why pet adoption is both beautiful and life-changing! What better way to  do it than share our amazing adoption stories on social media.
                        <br />
                        <br />
                        During Home 4 the  Holidays (October 1, 2021, to January 2, 2022) when your adopters from Home 4  the Holidays partner organizations tag newly adopted pet photos or video with  the hashtag&nbsp;<strong><em>#IChoseToRescue</em></strong>&nbsp;and tag&nbsp; <b><strong><em>@hwac</em></strong></b>&nbsp;and&nbsp;<b><strong><em>@bluebuffalo</em></strong></b>&nbsp;on  Twitter or Instagram, they will be entered to win a year&rsquo;s supply of Blue  Buffalo pet food for their pet and a <b>$1,000 donation</b> to the organization they  adopted from.&nbsp;(Hey, that&rsquo;s you!)<br />
                        &nbsp;<br />
                        Not on Twitter or Instagram? Not to worry, your adopters can post their newly  adopted pet right&nbsp;on&nbsp;<a href="http://www.home4theholidays.org/"><u>www.home4theholidays.org</u></a>&nbsp;when the contest begins on October  1, 2021.
                        <br />
                    </p>
                    <br />
                    <div class="title">
                        <h2 class="mb-20">Contest Timeline</h2>
                    </div>
                    <p>Helen Woodward Animal  Center and Blue Buffalo will select a winning entry during each month of the  campaign: on October 31, 2021, November 30, 2021, and January 2, 2022, for a  total of three winning organizations.</p>
                    <br />

                    <div class="title">
                        <h2 class="mb-20">Contest Rules</h2>
                    </div>

                    <div class="country whole-wrap">
                        <ul class="unordered-list">
                            <li><strong><font color="red">An entry must describe how your organization was innovative in driving up adoptions over the holidays and used Home 4 the Holidays and Blue Buffalo in your plan.</font></strong><u></u><u></u></li>
                            <li><a href="https://www.cognitoforms.com/HelenWoodwardAnimalCenter1/Win25000" target="_blank" data-saferedirecturl="https://www.google.com/url?q=https://www.cognitoforms.com/HelenWoodwardAnimalCenter1/Win25000&source=gmail&ust=1633195171101000&usg=AFQjCNEzZy7m3UIcDk4l7l-ZTbnhy9tj5g">Your organization must fill out the online form and your entry must contain either photos or a video.</a><u></u><u></u></li>
                            <li>Including statistics of adoptions vs. prior year for the period and reach of any social media or media impressions is recommended but not mandatory.<u></u><u></u></li>
                            <li>Weekly login to report your adoptions is recommended but not mandatory.<u></u><u></u></li>
                            <li>Donation recipient must be a 501(c)(3) non-profit animal welfare group or not-for-profit animal welfare corporation in the United States, Puerto Rico, or Canada (documentation required).<u></u><u></u></li>
                            <li>All entries must be submitted on-line by 5pm PST on Monday, January 10, 2022.<u></u><u></u></li>
                            <li>The adoption event for winning entries must take place during the 2020 adoption campaign (October 1, 2021 – January 2, 2022).</li>
                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <%--End about-info Area--%>
</asp:Content>
