<%@ Control Language="VB"  %>
<script language="vb" runat="server">
Public ReadOnly Property CardNumber as String
	Get
		CardNumber=Card_Number.Text
	End Get
End Property
Public ReadOnly Property ExpMonth as String
	Get
		ExpMonth=Exp_Month.SelectedItem.text
	End Get
End Property
Public ReadOnly Property ExpYear as string
	Get 
		ExpYear=Exp_Year.SelectedItem.Text
	End Get
End Property

</script>
<style type="text/css">
<!--
.style1 {font-weight: bold}
.style2 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>

<table width="400" border="0" align="center" cellpadding="5" cellspacing="2">
<tr bgcolor="#F68428">
<td colspan="2"><span class="style1"> &nbsp;<span class="style2">Payment Information</span></span></td>
</tr>
<tr>
  <td width="28%" nowrap><div align="right">Cards Accepted</div></td>
  <td width="72%">
  
  <img src="https://www.animalcenter.org/_images/business_logos/visa_small.gif">
  <img src="https://www.animalcenter.org/_images/business_logos/mastercd_small.gif">
  <img src="https://www.animalcenter.org/_images/business_logos/amex_small.gif">
  <img src="https://www.animalcenter.org/_images/business_logos/discover.jpg">  </td>
</tr>
<tr>
  <td><div align="right">*Card Number </div></td>
  <td> 		        <asp:TextBox runat="server" ID="Card_Number" MaxLength="16" />                
 (no dashes or spaces)
    <asp:RequiredFieldValidator ControlToValidate="Card_Number" Display="Dynamic" ErrorMessage="*You must enter a credit card number" runat="server"  ID="req_Card_Number"/><asp:RegularExpressionValidator runat="server" ValidationExpression="\d{13,16}" ErrorMessage="*That is not a valid card number" ID="Valid_Card_Number" Display="Dynamic" ControlToValidate="Card_Number"/></td>
</tr>
<tr>
  <td><div align="right">*Expiration Month </div></td>
  <td><asp:DropdownList runat="server" ID="Exp_Month">
  	<asp:ListItem Selected="true">01</asp:ListItem>
	<asp:ListItem>02</asp:ListItem>
	<asp:ListItem>03</asp:ListItem>
	<asp:ListItem>04</asp:ListItem>
	<asp:ListItem>05</asp:ListItem>
	<asp:ListItem>06</asp:ListItem>
	<asp:ListItem>07</asp:ListItem>
	<asp:ListItem>08</asp:ListItem>
	<asp:ListItem>09</asp:ListItem>
	<asp:ListItem>10</asp:ListItem>
	<asp:ListItem>11</asp:ListItem>
	<asp:ListItem>12</asp:ListItem>
  
  </asp:DropdownList> 
    *Expiration Year 
	<asp:DropdownList runat="server" ID="Exp_Year">
	<asp:ListItem Selected="true">2015</asp:ListItem>
	<asp:ListItem>2014</asp:ListItem>
	<asp:ListItem>2016</asp:ListItem>
	<asp:ListItem>2017</asp:ListItem>
	<asp:ListItem>2018</asp:ListItem>
	<asp:ListItem>2019</asp:ListItem>
	<asp:ListItem>2020</asp:ListItem>
	<asp:ListItem>2021</asp:ListItem>  
  </asp:DropdownList>  </td>
</tr>
</table>
