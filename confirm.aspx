<% @ Page Language="VB" MasterPageFile="~/home4theholidays/template.master" Title="Report your numbers- Home 4 The Holidays" debug="true" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SqlClient" %>

<script runat="server">
sub Page_load(obj as object, e as EventArgs)
form1.visible=false
lblmessage.text="Sorry, submissions are no longer being accepted for the 2011-12 program.  Be sure to participate in the 2012-13 campaign!"
End Sub

Sub UpdateOrg(obj as Object, e as EventArgs)
				 dim objMM as New HWAC.EmailMessage
				objmm.MailTO="lonjones@hotmail.com"
				 objmm.From="h4thnews@animalcenter.org"
		
			
				'update db
				Dim db as new HWAC.database
				Dim strSql as String
				strsql="UPDATE tblH4THReg set Food2011='" & ddlFood.selectedItem.text & "' WHERE ShelterID=" & session("UserID")
				if db.ExecuteNonQuery(strSql) then 'successful
				 objmm.Body=session("UserID") & "<br/>" & session("ShelterName") & "<br/>" & ddlParticipate.selectedItem.text & "<br>" & ddlFood.selectedItem.text & "<br>" & tbIdeas.text	
				  objmm.Subject="Shelter Food Submission"
				 objmm.Send_Email(objMM)
				
	
				Form1.visible=false
lblmessage.text="Thank you for your participation.  Your food is on its way!  Please <a href=""members/profile.aspx"">review your profile</a> now to make sure your information is current.  Thank you!<br/>"
else 'did not work
	lblmessage.text="There has been a problem, please try agian later, thank you!"
		 objmm.Body=session("UserID") & "<br/>" & session("ShelterName") & "<br/>" & ddlParticipate.selectedItem.text & "<br>" & ddlFood.selectedItem.text & "<br>" & tbIdeas.text	
				  objmm.Subject="Shelter Food Submission ERROR"
				 objmm.Send_Email(objMM)
end if
End Sub

</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <style type="text/css">
<!--
.style1 {font-size: 9px}
-->
</style>

</asp:content>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >Receiving Your Home 4 The Holidays Food</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" >
</asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Bags 4 Bowls</h1>
<div class="feature"><asp:Label runat="server" ID="lblmessage" ForeColor="#FF0000"/>
<p>Thank you for your participation in the 2010  Home 4 The Holidays Campaign!  In order to receive your food, please answer the questions below and please <a href="members/profile.aspx" target="_blank">confirm your profile information</a> to be sure you receive your items.  <strong>New for next year</strong>-Now you can add your Facebook, Twitter, and Blog links to your <a href="members/profile.aspx" target="_blank">profile</a> so that you can further get the word out about your organization!</p>

<p>Please answer the questions below:</p>
<form runat="server" id="form1"><table width="100%" border="0" cellspacing="3" cellpadding="3">
  <tr>
    <td>Please choose the type of food you prefer:</td>
    <td><asp:Dropdownlist runat="server" id="ddlfood">
      <asp:ListItem value="" Text=""/>    
      <asp:ListItem Text="40lb Bag of Dog Food"/>    
      <asp:ListItem text="20lb Bag of Cat Food"/>    
</asp:Dropdownlist>
      <asp:RequiredFieldValidator  ControlToValidate="ddlFood" ErrorMessage="*Answer required" Display="Dynamic" runat="server" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>Do you plan participate in the 2011 Campaign?</td>
<td><asp:DropDownList runat="server" ID="ddlParticipate">
  <asp:ListItem Value="" Text=""/>
  <asp:ListItem Value="Yes" Text="Yes"/>
  <asp:ListItem Value="No" Text="No"/>
</asp:DropDownList>
  <span class="style1">(Answer  does not affect receiving food)</span>
  <asp:RequiredFieldValidator  ControlToValidate="ddlParticipate" ErrorMessage="*Answer required" Display="Dynamic" runat="server" /></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>What recommendations do you have to improve the program?</td>
    <td><asp:TextBox runat="server" ID="tbIdeas" MaxLength="500" Height="100" Width="300"/></td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td colspan="2">Please <a href="members/profile.aspx" target="_blank"  style="color:"">review your profile</a> to make sure we have your most current addresses so you can receive your food!</td>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
    <td><asp:Button ID="btSubmit" runat="server" OnClick="UpdateOrg" Text="Send Me My Food!" />&nbsp;</td>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
<p>&nbsp;</p>

</div>
</asp:content>
