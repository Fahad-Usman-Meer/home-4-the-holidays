<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Account Management- Home 4 The Holidays" debug="true" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SQLClient" %>

<script runat="server">
Sub Page_Load(obj as object, e as eventargs)
if session("UserId")="" then response.Redirect("../login.aspx?ReturnURL=../home4theholidays/members/Account.aspx")

if not page.ispostback then 'load fields
	Dim db as New HWAC.databaseH4TH
	Dim objReader as SQLDataReader
	Dim StrSQL as String
	StrSQL="SELECT UserName, Password, Email, Hint FROM tblUsers WHERE (UserID=" & session("UserID") & ")"
	objReader=db.GetReader(strSQL)
	if not objReader is nothing then 'has found data
		With objReader
		While .Read()'fill text boxes
			tbUsername.text=.GetString(0)
			tbPassword.Attributes( "value" ) = .GetString(1)
			tbPassword2.Attributes( "value" ) = .GetString(1)
			tbEmail.Text=.GetString(2)
			tbHint.Text=.GetString(3)
		end While
		end with
	else' did not find data
		lblmessage.text="Account data not found. Please try again later. Thanks!"
		form1.visible=false
		
	end if 
end if
End Sub

Sub btnUpdate_Click(obj as object, e as eventargs)
Dim StrSQL as String
Dim db as New HWAC.databaseH4TH
'check for duplicate username!
strSql="SELECT UserId FROM tblUsers WHERE Userid<>" & session("UserId") & " And Username='" & tbUsername.text & "'"
if db.ExecuteScalar(strSql)="" then 'no duplicate-ok to commit
		'Update databaseH4TH h4th table with session, userid and fields 'call hwac.user.excecutenonquery
		StrSQL="UPDATE tblUsers SET Username='" & replace(tbUsername.text,"'","''") & "', Password='"& replace(tbPassword.text,"'","''") & "', Hint='" & replace(tbHint.text,"'","''") & "', Email='" & tbEmail.Text & "' WHERE UserID=" & session("UserID")
		if db.ExecuteNonQuery(StrSQL) then 'successfull update
			form1.visible=false
			lblmessage.text="Account successfully updated!"
			dim objMM as New HWAC.EmailMessage
			with objMM
			.MailTo="lonjones@hotmail.com"
			.From="Account Update <lonj@animalcenter.org>"
			.Subject="Account Update"
			.Body="Account " & session("UserID") & " " & session("ShelterName") & " Updated."
			.Send_Email(objMM)
			End with
			
		else
		lblMessage.Text="There was a problem updating. Please try again.  Thank You!"
		End if

else 'found duplicate username
	lblmessage.text="The Username you have chosen is already taken.  Please try another."
End If

End Sub


</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="../_css/thickbox.css" type="text/css" media="screen" />
<link href="../_css/style2.css" rel="stylesheet" type="text/css" />
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</asp:content>

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >
H4TH Members
</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Edit Account Information<br></h1><div class="feature">
                                                         
                                                            <asp:Label ID="lblMessage" ForeColor="#FF0000" Font-Bold="true" runat="server"/>                                                          
                                                            <br>
                                                            <table width="460" align="center">
                                                              <tr>
                                                                <td><form runat="server" id="form1">
          Click &quot;Update Account &quot; to save any changes to your account.
          <asp:ValidationSummary runat="server" ShowMessageBox="true" ShowSummary="false"  ID="VSum" HeaderText="Please fill out all the required fields appropriately" />
          <asp:Panel id="pnlRegister" runat="server" >
            <table cellpadding="0" cellspacing="0" >
              <tr bgcolor="#312BD1">
                <td nowrap>&nbsp;</td>
                <td colspan="2" nowrap><h4 class="style1">Account Information</h4></td>
              </tr>
              <tr>
                <td nowrap><span class="style2">*</span></td>
                <td nowrap>Username:</td>
                <td   align="left"><asp:TextBox id="tbUserName" runat="server" MaxLength="12"/>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="tbUserName" ErrorMessage="*Username required" Display="Dynamic" />  
                </td>
              </tr>
              <tr>
                <td nowrap><span class="style2">*</span></td>
                <td nowrap>Password:</td>
                <td><asp:TextBox id="tbPassword" runat="server" MaxLength="12"  TextMode="Password"/>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="tbPassword" ErrorMessage="*Password required"  Display="Dynamic"/>  
                </td>
              </tr>
              <tr>
                <td nowrap><span class="style2">*</span></td>
                <td nowrap>Confirm Password:</td>
                <td><asp:TextBox id="tbPassword2"  MaxLength="12" runat="server"  TextMode="Password"/>
                    <asp:CompareValidator ControlToCompare="tbPassword" Display="Dynamic" ValueToCompare="=" runat="server" ControlToValidate="tbPassword2" ErrorMessage="*Passwords do not match" />  
                </td>
              </tr>
              <tr>
                <td nowrap><span class="style2">*</span></td>
                <td nowrap>Password Hint:</td>
                <td><asp:TextBox runat="server" MaxLength="200" Width="200" ID="tbHint" />
                    <asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="req_Hint" ControlToValidate="tbHint" ErrorMessage="*Password Hint Required" /></td>
              </tr>
              <tr>
                <td><span class="style2">*</span></td>
                <td nowrap>Email Address: </td>
                <td><asp:textbox id="tbEmail" runat="server"/>
                    <asp:RequiredFieldValidator runat="server" ControlToValidate="tbEmail" 	ErrorMessage="*Email is required" Display="Dynamic"/>  
                    <asp:regularexpressionvalidator runat="server" controltovalidate="tbEmail" 
					validationexpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" 
					errormessage="*That is not a valid email" 
					display="dynamic"/>  
                </td>
              </tr>
              <tr>
                <td nowrap>&nbsp;</td>
                <td nowrap><asp:Button  ID="btnUpdate" OnClick="btnUpdate_Click" runat="server" Text="Update Account"/></td>
                <td>&nbsp;</td>
              </tr>
              <tr>
                <td nowrap>&nbsp;</td>
                <td colspan="2" nowrap>&nbsp;</td>
              </tr>
            </table>
          </asp:Panel>
          <asp:Panel runat="server" ID="pnlMailing" Visible="false"> </asp:Panel>
                                                                </form></td>
                                                              </tr>
                                                            </table>
													      </div>
</asp:content>
