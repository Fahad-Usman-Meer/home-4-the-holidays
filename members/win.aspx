<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Member Profile- Home 4 The Holidays" ViewStateEncryptionMode="Never" Debug="true" %>

<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="System.Data.SQLClient" %>

<script runat="server">
    Sub Page_Load(obj As Object, e As EventArgs)
        If Session("UserId") = "" Then Response.Redirect("../login.aspx?ReturnURL=../home4theholidays/members/index.aspx")

    End Sub

</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>

<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/family-with-dog-porch-banner-2.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">Win $25,000!
                    </h1>
                    <p class="text-white link-nav">
                        <a href="/members/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Win $25,000! for Members</a>
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
            <div class="row align-items-center">
                <div class="col-lg-12">
					<h2>Congratulations to Stray Love Foundation, Camrose Animal Alliance Rescue Society & Friends of Orange County's Homeless Pets
					  
				  </h2>
                    <p><em>This year we are  pleased to have multiple winners for our Home 4 The Holidays contest, as no one  organization met all the required criteria of our Home 4 the Holidays  contest.&nbsp;</em>Thanks to Save This  Life Microchip &amp; Recovery Systems for being a sponsor of the Home 4 the  Holidays Shelter Grant Prize!<em>&nbsp;Here are the winners and more information  about the marketing campaigns they delivered this holiday season!</em></p>
                     <p> <img width="470" height="474" src="win_clip_image002.jpg" align="right" hspace="12"> 
                  <strong>&#128062;&nbsp;The Stray  Love Foundation&nbsp;</strong>based their holiday adoption campaign around a public  adoption event they held on December 3 called the &quot;Homes for the Holidays  great kitten adoption event&quot;. They had a huge turnout and 7 adoptions that  week!&nbsp;<strong>The Stray Love Foundation</strong>&nbsp;is a foster based rescue and  places an average of 200 cats, kittens and occasional dog each year. That's an  average of 3.8 adoptions per week. Beginning with the event on December 3, they  adopted out 32 cats over the following 5 weeks, averaging 6.4 adoptions per  week. The Stray Love Foundation posted regularly on Facebook, Twitter, other  social media and started using TikTok during the holiday season.</p>
                    <p>They appeared on local  television station WALA Fox 10 to promote their Christmas morning deliveries as  well as their food drive. On Christmas Day, they posted a video of a Christmas  morning delivery and promoted the fact that they would deliver through January  3, leading to 10 adoptions the week after Christmas! With so many adoptions,  they were able to take in even more cats than usual and they saw an impact on  their overall numbers for 2022.&nbsp;</p></div></div>
				  <div class="row"  >
					  <div class="col-lg-12">
                    <p><img width="260" height="260" src="win_clip_image004.jpg" align="Left" hspace="12"><strong>&#128062;&nbsp;Camrose Animal Alliance Rescue  Society&nbsp;</strong>saw their adoptions increase by 72%, compared to 2021. Their  marketing campaign incorporated two segments, both with a focus on supporting  local adopters and followers. They offered their first 30 adopters pet swag  bags from&nbsp;<strong><em>CamrosePetsWithPaws&nbsp;</em></strong>&amp; held a holiday  contest where participants had to comment with how they include pets in the  holidays &amp; they were asked to follow three pages on Facebook and Instagram,  like each post, and share each post.&nbsp;</p><p></p></div></div>
						   <div class="row" style="height: 300px;">
					  <div class="col-lg-12">
                    <p></p><p><img width="218" height="265" src="win_clip_image006.jpg" align="right" hspace="12">&#128062;&nbsp;<strong>Friends of  Orange County's Homeless Pets&nbsp;</strong>organized a &quot;Dress Up  Campaign&quot; to post on their social media pages featuring an oh-so-adorable  adoptable dog named Olive.&nbsp;<br>
                      </p></div></div>
					  







                    <div class="title text-center">
                        <h1 class="mb-10">Win $25,000!</h1>
                    </div>

                    <div class="row">
                        <div class="col-md-9">
                            <p class="text-left">Our partner organizations deserve the best! That’s why Helen Woodward Animal Center is offering $25,000 to the organization that submits the most innovative way they promoted adoptions at their facility over the holidays.</p>

                        </div>
                        <div class="col-md-3">
                            <img src="../_images/money.png" alt="" class="img-fluid">
                        </div>
                    </div>

                    <!--<br />
                    <h4>Contest Timeline</h4>
                    <br />
                    <p class="text-left mb-20">Helen Woodward Animal Center will announce a winning entry on Friday, January 27, 2023.</p>-->
                    <h4>Contest Rules</h4>
                    <br />
                    <div class="country">
                        <ul type="disc" class="unordered-list">
                            <li>An entry must describe how your organization was innovative in driving up adoptions over the holidays and used Home 4 the Holidays and Blue Buffalo in your plan.<u></u><u></u></li>
                            <li>Your organization must fill out the online form and your entry must contain either photos or a video.<u></u><u></u></li>
                            <li>Statistics of adoptions vs. prior year for the period and reach of any social media or media impressions is recommended but not mandatory.<u></u><u></u></li>
                            <li>A weekly login to report your adoptions is recommended but not mandatory.<u></u><u></u></li>
                            <li>Donation recipient must be a 501(c)(3) non-profit animal welfare group or not-for-profit animal welfare corporation in the United States, Puerto Rico, or Canada (documentation required).<u></u><u></u></li>
                            <li>All entries must be submitted on-line by 5pm PST on Monday, January 8, 2024.<u></u><u></u></li>
                            <li>The adoption event for winning entries must take place during the 2023 adoption campaign (October 1, 2023 – January 2, 2024).</li>
                        </ul>
                    </div>
<script src="https://www.cognitoforms.com/f/seamless.js" data-key="imIDUuGt-EuFkWBk_whRYA" data-form="48"></script>
                    <!--<div class="mt-30">
                        <div class="cognito">
                          <script src="https://www.cognitoforms.com/s/imIDUuGt-EuFkWBk_whRYA"></script>
                          <script>Cognito.load("forms", { id: "48" });</script>
                        </div>
                    </div>-->


                    <%--<p>We are pleased to announce that this year&rsquo;s contest winner is  <strong>The Humane Society of Southeast Missouri!</strong></p>
<p>  We wish we could select more than  one organization to win, however we encourage you to try again for 2019. We  received so many wonderful entries, and because of the great success in  increasing adoptions this year we plan to run the contest next year and  encourage even more organizations to join Home 4 the Holidays. The bottom line is more pets will be saved because of  your creativity. </p>
<p>  Thank  you again for being a part of Home 4 the Holidays and for all that you do to save the lives of thousands of orphan pets during the  holiday season&nbsp;and to educate the public about the importance of choosing  pet adoption.</p>--%>
          </div>
            </div>
        </div>
    </section>
    <%--End about-info Area--%>
</asp:Content>


