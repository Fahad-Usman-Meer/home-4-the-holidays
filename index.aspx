<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Blue Buffalo Home 4 The Holidays | Helen Woodward Animal Center" %>

<script runat="server">
    Sub page_load(obj As Object, e As EventArgs)


    End Sub
</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <meta name="description" content="Join Blue Buffalo Home 4 the Holidays, the world's largest pet adoption campaign! Free marketing resources, events and support to help your shelter do more pet adoptions." />
    <meta name="keywords" content="pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />
</asp:Content>

<%--<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >
 Home 4 The Holidays
</asp:Content>--%>


<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="server">
    <section id="divHomeCover" class="banner-area relative" style="background: rgba(0, 0, 0, 0) url(/img/banners/pet-dog-1.jpg) repeat scroll center center;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row fullscreen align-items-center justify-content-between" style="height: 545px;">
                <div class="col-lg-6 col-md-6 banner-left">
                    <p class="text-white">
                        It's Best Time to become a part of
                    </p>
                    <h1 id="main-bold-text" class="text-white">Home 4 The Holidays</h1>
                    <h6 class="text-white">join Us</h6>
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
                        <h1 class="mb-10">Join the world&rsquo;s  largest adoption campaign with Blue Buffalo® Home 4 the Holidays®</h1>
                    </div>
                    <p>Home 4 the Holidays is a three month adoption drive that  saves the lives of orphan pets and raises awareness about the importance of pet  adoption during the holiday season.&nbsp; <b>Why?</b> More families bring a new pet  home during the holiday season than at any other time of year.</p>
                    <img src="_images/H4TH_historic_logo_08.jpg" align="right" width="200" />
                    <p>This campaign is dedicated to educating the public about the  importance of choosing pet adoption over supporting puppy mills and backyard  breeders.&nbsp; Through our collective group of over 4,000 pet adoption  agencies, facilities, and rescue-groups, this campaign has become the largest  pet adoption campaign on record, saving over&nbsp;18 million pets&nbsp;since  its inception in 1999.</p>
                    <p><b>Benefits your organization/rescue can receive when you join  Blue Buffalo Home 4 the Holidays:</b></p>

                    <div class="country">
                        <!--<img src="/img/route_map/ayyubia_chair_lifts.jpg" alt="flag">-->
                        <ul class="unordered-list">
                            <li>A chance to win $1,000 when you encourage  adopters to share a heartwarming story about their new pet. A winner will be  chosen and in addition to a prize from Blue Buffalo for the pet parent, the  organization they adopted from will win $1,000.</li>
                            <li>A chance to win $25,000 for  your organization through the Home 4 the Holidays Media Award. We&rsquo;re looking  for creative ways you bring media attention to your organization during Home 4  the Holidays!</li>
                            <li>An intensive guide with free adoptions marketing  resources and media plans for the holiday season.</li>
                            <li>By participating in Home 4 the Holidays, your shelter  or rescue group will be listed on a map for potential new pet-parents to be  able to easily locate their nearest animal organization. The international  media coverage from the campaign, including articles, social media,  advertisements, and press releases will bring footsteps through your door.</li>
                            <li>Once you&rsquo;ve registered, visitors to  Home4theHolidays.org will be able to find your organization and donate to the  campaign! 100% of funds raised through your member page will go directly to  you.</li>

                        </ul>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <%--End about-info Area--%>

</asp:Content>
