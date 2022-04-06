<% @ Page Language="VB" MasterPageFile="~/home4theholidays/template.master" Title="Downloads- Home 4 The Holidays" debug="true" %>

<script runat="server">
sub page_load (obj as object, e as eventargs)
'response.Redirect("http://www.animalcenter.org/home4theholidays/How-To-Guide")
	
end sub
</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
  </style>

</asp:content>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >
How To Guide</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Materials to help you increase adoptions<br></h1>
<div class="feature">
														  <table align="center">
                                                              <tr>
                                                                <td colspan="2" bgcolor="#0033FF"><h3 class="style1">Welcome to the Home 4 the Holidays How-to Guide</h3></td>
                                                              </tr>
                                                              <tr>
                                                                <td><p><strong>Thank you for joining us in our efforts to save the lives of orphaned pets this holiday season.&nbsp; The Home 4 the Holidays How-to Guide will provide a variety of helpful information on everything from how to create a successful Home 4 the Holidays campaign in your area to reporting and sharing your successes after you complete your campaign.&nbsp; Each of the buttons below will provide more detailed information on that particular topic.</strong></p>                                                                </td>
                                                                <td> </td>
                                                              </tr>
                                                            </table>
                                                            
                                                          <table border="0" align="center" cellpadding="5" cellspacing="5">
                                                            <tr>
                                                              <td><a href="how-to-make-your-campaign-a-success.aspx"><img src="_images/H4TH13-campaignbutt.jpg" width="275" height="85" border="0" /></a></td>
                                                              <td><a href="messaging-guidelines.aspx"><img src="_images/H4TH13-messbutt.jpg" width="275" height="85" border="0" /></a></td>
                                                            </tr>
                                                            <tr>
                                                              <td><a href="templates.aspx"><img src="_images/H4TH13-templatebutt.jpg" width="275" height="85" border="0" /></a></td>
                                                              <td><a href="sharing-and-reporting-your-success.aspx"><img src="_images/H4TH13-sharebutt.jpg" width="275" height="85" border="0" /></a>                                                                </td>
                                                            </tr>
                                                            <tr>
                                                              <td colspan="2"><p><a href="successful-campaign-example.aspx"><img src="_images/H4TH13-SuccessfulCampaign_Landing Page Button.jpg" width="275" height="85" border="0" /></a></p>
                                                              
                                                              <div align="center"></div></td>
                                                            </tr>
                                                            <tr>
                                                              <td>&nbsp;</td>
                                                              <td>&nbsp;</td>
                                                            </tr>
                                                          </table>
</div>
</asp:content>
