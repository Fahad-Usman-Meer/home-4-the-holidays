<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Downloads- Home 4 The Holidays" Debug="true" %>

<script runat="server">
    Sub page_load(obj As Object, e As EventArgs)
        'response.Redirect("https://join.home4theholidays.org/How-To-Guide")

    End Sub
</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server"></asp:Content>

<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/love-dog-chinese-family-banner.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">Successful Campaign Example</h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a href="/downloads.aspx">Downloads</a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Successful Campaign Example</a>
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
                        <h3 class="mb-10">San Antonio&rsquo;s Successful Home 4 the Holidays Campaign</h3>
                    </div>
                    <p>There are many pages of helpful suggestions and ideas to promote Home 4 the Holidays, but one of our participants did a particularly outstanding job of creating a special event to promote Home 4 the Holidays and working with the local government to secure a proclamation regarding Home 4 the Holidays.&nbsp; This is a perfect example of how creating a special day to celebrate Home 4 the Holidays can draw in visitors and significantly increase adoptions.&nbsp; The proclamation is not difficult to get and usually involves simply drafting a letter to your local politician, but it is something that will look great in your lobby for potential adopters and can be included in a press release for the event.</p>


                    <section class="home-about-area mt-30">
                        <div class="container-fluid">
                            <div class="row align-items-center">
                                <div class="col-lg-2 col-md-2">
                                    <h1>FLYER</h1>
                                </div>
                                <div class="col-lg-12 col-md-12 home-about-right no-padding">
                                    <img class="img-fluid" src="_images/SanAntonioFlyer.jpg" alt="" style="border-color: #f8b600; border-radius: 2em; border-width: 10px; border-style: solid;">
                                </div>
                            </div>
                        </div>
                    </section>

                    <section class="home-about-area mt-30">
                        <div class="container-fluid">
                            <div class="row align-items-center">
                                <div class="col-lg-2 col-md-2">
                                    <h1>PROCLAMATION</h1>
                                </div>
                                <div class="col-lg-12 col-md-12 home-about-right no-padding">
                                    <img class="img-fluid" src="_images/SanAntonioProclamation.jpg" alt="" style="border-color: #f8b600; border-radius: 2em; border-width: 10px; border-style: solid;">
                                </div>
                            </div>
                        </div>
                    </section>


                    <div class="title mt-50">
                        <h3 class="mb-10">SUMMARY OF EVENT:</h3>
                    </div>
                    <p>
                        This event created a new record number of adoptions for one event for Talk About It! of the San Antonio Area Foundation with an impressive <b>72 adoptions</b> at an offsite event with multiple rescue organizations. <b>20 organizations</b>, <b>72 pets</b>, we also heard on the day of the event that it was hard  finding parking because it was so crowded.
                    </p>

                    <div class="mt-50">
                        <p><b>Nonprofits with Information Tables:</b></p>

                        <div class="country">
                            <ul class="unordered-list">
                                <li>AAPAW&mdash;Alamo Area Partners for Animal Welfare</li>
                                <li>Daisy Cares</li>
                                <li>Friends of ACS</li>
                                <li>Guide Dogs of Texas</li>
                                <li>Retired Military Working Dogs Assistance Organization</li>
                                <li>San Antonio Big Dawgz</li>
                                <li>San Antonio Feral Cat Coalition</li>
                                <li>SpaySA</li>
                                <li>Talk About It!</li>
                            </ul>
                        </div>
                    </div>

                    <div class="mt-50">
                        <p><b>For profit companies with tables:</b></p>

                        <div class="country">
                            <ul class="unordered-list">
                                <li>Anna&rsquo;s Chem Dry</li>
                                <li>Anthony&rsquo;s Artists</li>
                                <li>Camp Bow Wow</li>
                                <li>Chloe &amp; Isabel</li>
                                <li>Cosmic Cakery</li>
                                <li>Fetch and Friskers</li>
                                <li>Grandpa&rsquo;s Tea</li>
                                <li>Great Ex-Pet-Tations</li>
                                <li>K. Hill BBQ Company</li>
                                <li>Katie&rsquo;s Jar</li>
                                <li>LOMA Behavior and Training/San Antonio Pet Trainers Alliance</li>
                                <li>Lydia&rsquo;s Creations</li>
                                <li>Pampered Paws</li>
                                <li>Paw Basics</li>
                                <li>Poodle in Pink</li>
                                <li>Scentsy</li>
                                <li>Spurs Sports &amp; Entertainment</li>
                                <li>Tails Natural Pet Market</li>
                                <li>Woof Gang Bakery</li>
                                <li>31 Consultants</li>
                            </ul>
                        </div>
                    </div>

                    <div class="mt-50">
                        <p><b>Entertainment Provided By:</b></p>

                        <div class="country">
                            <ul class="unordered-list">
                                <li>DJ Diggy Dutch</li>
                                <li>Radio Disney</li>
                                <li>Derrick Schneider and Gregory Rafert of Computer Systems Intelligence,  production of the photos with Santa</li>
                                <li>Zachary Goertz, San Antonio Food Bank Transportation, Santa Claus</li>
                                <li>Meghan Hull and Marlena Milenkowic, Sigma Kappa, Santa photo backdrop</li>
                            </ul>
                        </div>
                    </div>

                    <div class="mt-70">
                        <p>
                            Special Thanks to Natalie Tejeda of KENS TV for being the Mistress of Ceremonies and the Spurs Coyote for his appearance and entertainment.
                        <br />
                            <br />
                            An event this size would not have been possible without the special volunteers from Kym's Kids.  They were there all day and helped with setup and tear down, not to mention dog walking and trash pickup.  Many thanks, also, to Debi Silva, Joel Williams, and our other Talk About It! volunteers. Thank YOU! 
                                                          <br />
                            <br />
                            And grateful appreciation to Jaime Herrera and Life Time Fitness at The Rim for promoting and hosting the event.
                        </p>
                        <p align="center">
                            <strong>
                                <br />
                                <b>WAY TO GO  SAN ANTONIO!</b></strong>
                            <br /><br />

                            <a target="_blank" href="http://www.kens5.com/news/local/Furry-friends-find-new-homes-at-the-San-Antonio-HOWLiday-adoption-party-182680611.html?gallery=y&amp;c=y#/news/local/Furry-friends-find-new-homes-at-the-San-Antonio-HOWLiday-adoption-party-182680611.html?gallery=y&amp;c=y&amp;img=0&amp;c=y" class="genric-btn link-border circle">Click here for images 
                            <span style="padding-left: inherit; font-size: large; font-weight: bold;" class="lnr lnr-arrow-right"></span>
                            </a>
                        </p>

                    </div>


                </div>
            </div>
        </div>
    </section>
    <%--End about-info Area--%>

</asp:Content>
