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
 Win a rescue van
</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
<h1 class="grn_ttl_blg">Win A Rescue Van or $25,000</h1>
<p><img src="../_images/H4TH18_Vehicle_comp4web.jpg" width="300" height="120" alt="" align="right"/>Our partner organizations deserve the best! That&rsquo;s why Helen  Woodward Animal Center is offering a rescue van or $25,000 to the organization  that submits the most innovative way they promoted adoptions at their facility  over the holidays.  </p>
<p><strong>Contest Timeline</strong> </p>
<p>  Helen Woodward Animal Center will select a winning entry on  Friday, January 31, 2020.</p>
<p><strong>Contest Rules</strong></p>
<ul type="disc">
  <li>Your       organization must fill out the online form; provide a detailed description       of how your organization was innovative with driving adoptions over the       holidays; and provide photos to be considered.</li>
  <li>Donation       recipient must be a 501(c)(3)&nbsp;non-profit animal welfare group or       not-for-profit corporation in the United States, Puerto Rico or Canada       (documentation required),</li>
  <li>All       entries must be submitted on-line by 5pm PST on Monday, January 13, 2020. </li>
  <li>Entries&nbsp;must       take place during the 2019 adoption campaign&nbsp;(October 1, 2019 –       January 2, 2020).</li>
  <li>An       entry must contain either photos or a video.    </li>
</ul>
<div class="cognito">
<script src="https://services.cognitoforms.com/s/imIDUuGt-EuFkWBk_whRYA"></script>
<script>Cognito.load("forms", { id: "27" });</script>
</div>
	
<!--<p>We are pleased to announce that this year&rsquo;s contest winner is  <strong>The Humane Society of Southeast Missouri!</strong></p>
<p>  We wish we could select more than  one organization to win, however we encourage you to try again for 2019. We  received so many wonderful entries, and because of the great success in  increasing adoptions this year we plan to run the contest next year and  encourage even more organizations to join Home 4 the Holidays. The bottom line is more pets will be saved because of  your creativity. </p>
<p>  Thank  you again for being a part of Home 4 the Holidays and for all that you do to save the lives of thousands of orphan pets during the  holiday season&nbsp;and to educate the public about the importance of choosing  pet adoption.</p>-->
</asp:content>
