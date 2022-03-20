<%@ Control Language="VB"  %>
<script language="vb" runat="server">
Public ReadOnly Property Prefix as String
	Get
		Prefix=Prefix1.SelectedItem.Text
	End Get
End Property
Public ReadOnly Property FName as String
	Get
		FName=FName1.Text
	End Get
End Property
Public ReadOnly Property LName as string
	Get 
		LName=LName1.Text
	End Get
End Property
Public ReadOnly Property Email as string
	Get
		Email=Email1.Text
	End Get
End Property

</script>
<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>

<table width="400" border="0" align="center" cellpadding="0" cellspacing="2">
<tr bgcolor="#F68428">
<td colspan="2"><span class="style1"> &nbsp;Your Information </span></td>
</tr>
<tr>
  <td>Prefix</td>
  <td ><asp:DropDownList id="Prefix1" runat="server" >
            <asp:ListItem Value="Mr." Text="Mr."/>
            <asp:ListItem Value="Ms." Text="Ms."/>
            <asp:ListItem Value="Mrs." Text="Mrs."/>
            <asp:ListItem Value="Dr." Text="Dr." />
        </asp:DropDownList>
</td>
</tr>
<tr>
  <td>*First Name </td>
  <td><asp:TextBox runat="server" ID="FName1"   MaxLength="25"/><asp:RequiredFieldValidator ID="req_FName" runat="server" Display="Dynamic" ErrorMessage="*First Name is Required"  ControlToValidate="FName1"/></td>
</tr>
<tr>
  <td>*Last Name </td>
  <td><asp:TextBox runat="server" ID="LName1" MaxLength="25" /><asp:RequiredFieldValidator ID="req_LName"  runat="server" Display="Dynamic" ErrorMessage="*Last Name is Required" ControlToValidate="LName1" /></td>
</tr>
<tr>
  <td nowrap>*Email Address </td>
  <td><asp:TextBox runat="server" ID="Email1" /><asp:RequiredFieldValidator ID="req_Email" runat="server" Display="Dynamic" ErrorMessage="*Email is Required" ControlToValidate="Email1" />
  <asp:regularexpressionvalidator runat="server" controltovalidate="Email1" 
					validationexpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" 
					errormessage="*That is not a valid email" 
					display="dynamic"/></td>
</tr>
</table>
