<% @ Page Language="VB" MasterPageFile="~/templateSECURE.master" Title=" Home 4 The Holidays" debug="true" %>
<%@ import Namespace="System.Security.Principal" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>
<%@ Register TagPrefix="HWAC" TagName="UserInfoForm" src="~/_controls/h4thUserInfoMain.ascx" %>
<%@ Register TagPrefix="HWAC" TagName="UserBAddressForm" src="~/_controls/h4thBillingAddress.ascx" %>
<%@ Register TagPrefix="HWAC" TagName="UserCCForm" src="~/_controls/h4thCredit_Card_Info.ascx" %>

<script runat="server">

sub Page_load(obj as object, e as EventArgs)
	if not page.ispostback then
		if request.QueryString("ShelterId")<>"" then 'good
			if request.QueryString("ShelterId")="8336" then
				lblmessage.text="This Organization has not been verified as a 501c3.  Donations for this Organization are not allowed until its non-profit status is verified."
				form1.visible=false
				exit sub
			end if
			
		'if not session("ShelterInfo") is  nothing then 
			'dim ShelterInfo
				'ShelterInfo=session("ShelterInfo")
				
			lblShelter.text=request.QueryString("ShelterName")
			lblhidden.text=request.QueryString("ShelterId")
		else 'no shelter info
			response.Redirect("shelter_map.aspx?ID=donate")
		end if
	end if
	
end sub
sub donate_click(sender As Object, e As System.EventArgs)
exit sub
if page.isvalid then
	''process the donation
	'lblmessage.text=GetForm()
	Dim objUserDetails as new HWAC.UserDetails
	Dim objPayment as new HWAC.SecurePayment
	with objUserDetails
		.FName=UserInfoForm.FName
		.LName=UserInfoForm.LName
		.BAddress=BAddress.BAddress
		.BCity=BAddress.BCity
		.BState=BAddress.BState
		.BZip=BAddress.BZip
		.BCountry=BAddress.BCountry
		.Email=UserInfoForm.Email
	end with
	Dim objPaymentDetails as new HWAC.PaymentDetails
	with objPaymentDetails
		.CreditCardNumber=UserCCForm.CardNumber
		.Expiration=UserCCForm.ExpMonth &  "/" & right(UserCCForm.ExpYear,2)
		.Amount=Amount.text
		.Desc="Home 4 The Holidays Donation for "  & lblShelter.text 'Change value for each type of donation
		.OtherInfo="Shelter Name=" & lblshelter.text & " | Shelter ID=" & lblhidden.text

	End With
	form1.visible=false
	
		lblMessage.text=objPayment.CCAuthorize(objUserDetails,objPaymentDetails, 2)
		if instr(lblmessage.text, "not completed")>0 or instr(lblmessage.text, "error")>0 then 
			'do nothing
		else
			
			Dim EM as new HWAC.EMailMessage()
				EM.From="noreply@animalcenter.org"
				EM.Subject="Home 4 The Holidays Shelter Donation to " & lblshelter.text
				EM.MailTo="ReneeS@Animalcenter.org, KirsiA@animalcenter.org"
				EM.BCC="lonjones@hotmail.com"
				EM.Body="<h3>Home 4 The Holidays Shelter Donation</h3><br><br>" & "$" & Amount.text & FindShelter
				'EM.BodyFormat=MailFormat.Html
				 Try
					EM.Send_Email(EM)
				 Catch ex as exception
				 end try
		end if
else
'page not valid-do nothing
response.Write("no good")
end if 

end sub
Function FindShelter as string
Dim db as New HWAC.databaseH4TH
	Dim objReader as SQLDataReader
	Dim StrSQL as String
	dim strShelterInfo as string
		StrSQL="SELECT  ShelterName, FName, LName, ContactPhone, MAddress, MCity, MState, MZip, MCountry, SAddress, SCity, SState, SZip, SCountry, ShelterPhone, Fax, Email, Website, ShowPublic, ShelterID FROM  dbo.tblH4THReg WHERE (ShelterID=" & lblhidden.text & ")"
	try
	objReader=db.GetReader(strSQL)
	catch ex as exception
		return "Error:" & ex.tostring() 
	end try
	if not objReader is nothing then 'has found data
		With objReader
		While .Read()'fill labels
			strShelterInfo &="<br>" & .item("ShelterName")
			strShelterInfo &="<br>" & "Shelter Phone: " & .Item("ShelterPhone")
			strShelterInfo &="<br>" & "<br>Contact: " & .GetString(1) & " " & .GetString(2) & "<br>"
			strShelterInfo &="<br>" &"Contact Phone: " & .Item("ContactPhone")
			if .GetString(15)<>"" Then strShelterInfo &="<br>" & "<br>Fax:   " & .Getstring(15)
			if .GetString(16)<>"" Then strShelterInfo &="<br>" & "<br><a href=mailto:" & .GetString(16)& ">Email</a>"
			strShelterInfo &="<br>" & "<strong>Physical</strong><br>" & .Item("SAddress") & "<br>" & .Item("SCity") & ", " & .Item("SState") & "  " & .Item("SZip")
			if .GetString(8)<>"United States" Then strShelterInfo &="<br>" & "<br>" & "  " & .Getstring(8)
			if .Item("SAddress")<>"" then strShelterInfo &="<br>" &"<br><a href=""http://www.maps.google.com/maps?complete=1&hl=en&q=" & .Item("SAddress") & "%20" & .Item("SCity") & "%20" & .Item("SState") & "%20" & .Item("SCountry") & "&sa=N&tab=wl"" target=""_blank"">Map</a>"
			strShelterInfo &="<br>" & "<br><br><strong>Mailing</strong><br>" & .Item("MAddress") & "<br>" & .Item("MCity") & ", " & .Item("MState") & "  " & .Item("MZip")
			if .GetString(8)<>"United States" Then strShelterInfo &="<br>" &"  " & .Getstring(8)
			if .GetString(17)<>"" Then strShelterInfo &="<br>" &"<br><a href=http://" & .GetString(17)& " target=""_blank"">Visit Website</a>"
		end While
		end with
	end if
	return strShelterInfo
end function

</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  
</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" > Home 4 The Holidays Donations</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" >
</asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Support a shelter through your generous donation<br></h1>
<div class="feature">
														    <asp:label runat="server" id="lblMessage" />                                                          
                                                            <form runat="server" id="form1">
                                                              <table border="1" align="center" bordercolor="#F68428" bordercolordark="#000000" bgcolor="#FFF0CF" style="border-style:ridge " >
                                                                <tr>
                                                                  <td><table width="400" border="0" align="center" cellpadding="0" cellspacing="2">
                                                                      <tr bgcolor="#F68428">
                                                                        <td colspan="2" class="style3"> &nbsp;Donation Information </td>
                                                                    </tr>
                                                                      <tr>
                                                                        <td width="152" nowrap>Enter Donation Amount </td>
                                                                        <td width="242" > $
                                                                            <asp:TextBox runat="server" ID="Amount"  MaxLength="8" Width="50" />                                                            
                .00 &nbsp;&nbsp;
                <asp:RequiredFieldValidator id="req_Amount" ControlToValidate="Amount" runat="server" Display="Dynamic" ErrorMessage="*Amount is Required"/>
                <asp:RegularExpressionValidator ControlToValidate="Amount" Display="Dynamic" ErrorMessage="*Amount should be numbers only" ValidationExpression="\d{0,10}" runat="server" />
                                                                        </td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td colspan="2" nowrap><br>
                                                                          100% of your donation will go to 
                                                                            <asp:Label ID="lblShelter" runat="server"  Font-Bold="true"/><Br>
                                                                        <a href="https://join.home4theholidays.org/shelter_map.aspx?ID=donate">Change Shelter</a></td>
                                                                      </tr>
                                                                    </table>
                                                                      <HWAC:UserInfoForm id="UserInfoForm" runat="server"/> <HWAC:UserBAddressForm id="BAddress" runat="server" /> <HWAC:UserCCForm id="UserCCForm" runat="Server" />
                                                                      <table width="400" border="0" align="center" cellpadding="0" cellspacing="2">
                                                                        <tr>
                                                                          <td align="right"><asp:Button ID="Submit"  Text="Make Donation" runat="server" OnClick="donate_click" CommandName="Submit"  BackColor="#F68428" BorderStyle="None" ForeColor="#FFFFFF" Font-Bold="true"/>                                                            
                                                                              <asp:ValidationSummary runat="server" ShowMessageBox="true" ShowSummary="false"   HeaderText="The Form Was Not Completed Correctly" />   
																			  <asp:label runat="server" ID="lblhidden" Visible="false" />                                                           
              </td>
                                                                        </tr>
                                                                    </table></td>
                                                                </tr>
                                                              </table>
                                                            </form>
													      </div>
</asp:content>
