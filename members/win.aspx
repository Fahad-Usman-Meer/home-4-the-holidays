<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Member Profile- Home 4 The Holidays" ViewStateEncryptionMode="Never" debug="true" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SQLClient" %>

<script runat="server">
Sub Page_Load(obj as object, e as eventargs)
if session("UserId")="" then response.Redirect("../login.aspx?ReturnURL=../home4theholidays/members/index.aspx")

End Sub



</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<link rel="stylesheet" href="../_css/thickbox.css" type="text/css" media="screen" />
<link href="../_css/style2.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style2 {
	margin-left:10px;
	color: #FFFFFF; 
	font-weight: bold; 
 }
-->
</style>
</asp:content>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >
 Win $25,000!
</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
<h1 class="grn_ttl_blg">Win $25,000!</h1>
<p><img src="../_images/money.png" width="229" height="171" align="right">Our partner organizations deserve the best! That’s why Helen Woodward Animal Center and our generous contest sponsors (Horizon Structures) are offering $25,000 and a single-run dog kennel to the organization that submits the most innovative way they promoted adoptions at their facility over the holidays. <br>
  <strong>Contest Timeline</strong> <br>
Helen Woodward Animal Center will announce a winning entry on Friday, January 28, 2022.<br>
<strong>Contest Rules</strong></p>
<ul type="disc">
  <li><strong><font color="red"> An entry must describe how your organization was innovative in driving up adoptions over the holidays and used Home 4 the Holidays and Blue Buffalo in your plan.</font></strong><u></u><u></u></li>
  <li><a href="https://www.cognitoforms.com/HelenWoodwardAnimalCenter1/Win25000" target="_blank" data-saferedirecturl="https://www.google.com/url?q=https://www.cognitoforms.com/HelenWoodwardAnimalCenter1/Win25000&source=gmail&ust=1633195171101000&usg=AFQjCNEzZy7m3UIcDk4l7l-ZTbnhy9tj5g">Your organization must fill out the online form and your entry must contain either photos or a video.</a><u></u><u></u></li>
  <li>Including statistics of adoptions vs. prior year for the period and reach of any social media or media impressions is recommended but not mandatory.<u></u><u></u></li>
  <li>Weekly login to report your adoptions is recommended but not mandatory.<u></u><u></u></li>
  <li>Donation recipient must be a 501(c)(3) non-profit animal welfare group or not-for-profit animal welfare corporation in the United States, Puerto Rico, or Canada (documentation required).<u></u><u></u></li>
  <li>All entries must be submitted on-line by 5pm PST on Monday, January 10, 2022.<u></u><u></u></li>
  <li>The adoption event for winning entries must take place during the 2021 adoption campaign (October 1, 2021 – January 2, 2022).</li>
</ul>
<div class="cognito">
<script src="https://www.cognitoforms.com/s/imIDUuGt-EuFkWBk_whRYA"></script>
<script>Cognito.load("forms", { id: "48" });</script>
</div>
	
<!--<p>We are pleased to announce that this year&rsquo;s contest winner is  <strong>The Humane Society of Southeast Missouri!</strong></p>
<p>  We wish we could select more than  one organization to win, however we encourage you to try again for 2019. We  received so many wonderful entries, and because of the great success in  increasing adoptions this year we plan to run the contest next year and  encourage even more organizations to join Home 4 the Holidays. The bottom line is more pets will be saved because of  your creativity. </p>
<p>  Thank  you again for being a part of Home 4 the Holidays and for all that you do to save the lives of thousands of orphan pets during the  holiday season&nbsp;and to educate the public about the importance of choosing  pet adoption.</p>-->
</asp:content>
