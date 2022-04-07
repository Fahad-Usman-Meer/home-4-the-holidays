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
                    <h1 class="text-white">Sharing & Reporting Your Success</h1>
                    <p class="text-white link-nav">
                        <a href="/index.aspx">Home </a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a href="/downloads.aspx">Downloads</a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Sharing & Reporting Your Success</a>
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
                        <h3 class="mb-10">Sharing &amp; Reporting Your Success</h3>
                    </div>
                    <p>A critical piece of the Blue Buffalo Home 4 the Holidays  program is for your organization to track adoptions and report back to Helen  Woodward Animal Center, so we can share the successes of each group with the  over 4,000 animal groups involved.&nbsp; We are confident that you will find  that this program provides a significant boost in adoptions during the holiday  season.&nbsp; Once you are keeping track of these successes you can share them  through social media and of course with your local media.</p>
                    

                    <div class="whole-wrap">
                        <div class="container">
                            <div class="section-top-border">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">

                                        <h3 class="mb-20">Download Links</h3>

                                        <div class="row mt-10">
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How To Guide/Sharing and Reporting/4A How to Report Adoption Success - 2021.doc" class="genric-btn primary ee-large">HOW TO REPORT ADOPTION<span style="padding-left: inherit; font-size: large; font-weight: bold;" class="lnr lnr-download"></span></a>
                                            </div>
                                            <div class="col-lg-6 col-md-6">
                                                <a href="_downloads/How To Guide/Sharing and Reporting/4B Social Media Sample Posts - 2021.docx" class="genric-btn primary ee-large">SOCIAL MEDIA SAMPLE POSTS<span style="padding-left: inherit; font-size: large; font-weight: bold;" class="lnr lnr-download"></span></a>
                                            </div>
                                        </div>
                                        
                                        <div class="row mt-10">
                                            <div class="col-lg-12 col-md-12">
                                                <a href="_downloads/How To Guide/Sharing and Reporting/4C How to Follow-Up with the Media 2019.doc" class="genric-btn primary ee-large">HOW TO FOLLOW-UP WITH THE MEDIA<span style="padding-left: inherit; font-size: large; font-weight: bold;" class="lnr lnr-download"></span></a>
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
