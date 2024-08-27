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
	   <div id='woobox-root'></div>
 <script>
 (function(d, s, id) {
	var js, fjs = d.getElementsByTagName(s)[0];
	if (d.getElementById(id)) return;
	js = d.createElement(s); js.id = id;
	js.src = "https://woobox.com/js/plugins/woo.js";
	fjs.parentNode.insertBefore(js, fjs);
	}(document, 'script', 'woobox-sdk'));
</script>
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
					<div class="woobox-offer" data-offer="7itomf" data-trigger="enter"></div>
                    
                    <br />
                    <div class="title">
                        <h2 class="mb-20">Contest Timeline</h2>
                    </div>
                    <p>Helen Woodward Animal  Center and Blue Buffalo will select a winning entry during each month of the  campaign: on October 31, 2023, November 30, 2023, and January 2, 2024 for a  total of three winning entries.</p>
                    <br />



                </div>
            </div>
        </div>
    </section>
    <%--End about-info Area--%>
</asp:Content>
