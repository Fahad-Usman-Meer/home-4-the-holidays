<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Blue Buffalo Home 4 the Holidays Registration | Helen Woodward Animal Center" debug="false" %>

<script runat="server">
Sub page_load(obj as object, e as EventArgs)
tbPassword.Attributes( "value" ) = tbPassword.Text
tbPassword2.Attributes( "value" ) = tbPassword2.Text
	if not page.ispostback then 'set focus to username
		Dim objFocus as new HWAC.Utility
		RegisterStartupScript("FirstFocus", objFocus.MakeFocusScript(Me.tbUsername))
	end if

End sub
Public Function GetUniqueID(ByVal length as Integer) as String  
  'Get the GUID
  Dim guidResult as String = System.Guid.NewGuid().ToString()
  
  'Remove the hyphens
  guidResult = guidResult.Replace("-", String.Empty)
  
  'Make sure length is valid
  If length <= 0 OrElse length > guidResult.Length Then
    Throw New ArgumentException("Length must be between 1 and " & guidResult.Length)
  End If
  
  'Return the first length bytes
  Return guidResult.Substring(0, length)
End Function


Sub chkMailing_Click(obj as object, e as eventargs)
	if chkMailing.Checked then 'do nothing, Shipping is the same
		pnlMailing.visible=false
	else
		pnlMailing.visible=true	
		tbMCity.text=tbSCity.Text
		tbMZip.text=tbSZip.text
		'if ddlSState.SelectedItem.Text<>"Choose a State" then
			'ddlMState.Items.FindByValue(ddlSState.SelectedItem.text).Selected=True
			ddlMState.Items.Insert(0, new ListItem(ddlSState.SelectedItem.text,ddlSState.SelectedItem.text))
			'VIEW STATE SEEMS TO OVERRIDE ENTRIES ON MULTIPLE POSTS
		'end if
			ddlMCountry.Items.Insert(0, new ListItem(ddlSCountry.SelectedItem.text,ddlSCountry.SelectedItem.text))
		Dim objFocus as new HWAC.Utility
		RegisterStartupScript("FirstFocus", objFocus.MakeFocusScript(Me.tbMAddress))
	end if	
End sub
Sub btnRegister_Click(obj as object, e as eventargs)
	'fraud
		if tbOrg.text="" then exit sub 
		if request.ServerVariables("REMOTE_ADDR")="173.236.103.38" then exit sub '
		if tbdogs.text="0" and tbcats.text="0" and tbpuppies.text="0" and tbkittens.text="0" and tbOther.text="0" then 
			lblmessage.text="You must have some projected adoptions for this campaign."
		end if
	'1) Create Login for New user
	dim theUniqueID as string=getUniqueID(10)
	Dim str1 as string
	Dim str2 as String
	Dim str3 as string
	Dim strResult as String
	dim objUserDetails as New HWAC.UserDetails
	Dim db as new HWAC.databaseH4TH
		with objUserDetails
		'Account details---------
		.UserName=replace(tbUsername.text,"'","''")
		.Password=replace(tbPassword.text,"'","''")
		.Hint=replace(tbHint.text,"'","''")
		'Contact Details---------
		.FName=replace(tbFName.text,"'","''")
		.LName=replace(tbLName.Text,"'","''")
		.ContactPhone=replace(tbPhone.Text,"'","''")
		.Email=tbEmail.text
		'Mailing Address----------
		if not chkMailing.Checked then 'filled out different mailing address
			.BAddress=replace(tbMAddress.text,"'","''")
			.BCity=replace(tbMCity.text,"'","''")
			.BState=ddlMState.SelectedItem.Value
			.BZip=replace(tbMZip.text,"'","''")
			.BCountry=ddlMCountry.SelectedItem.Value
		else 'same as shipping
			.BAddress=replace(tbSAddress.text,"'","''")
			.BCity=replace(tbSCity.text,"'","''")
			.BState=ddlSState.SelectedItem.Value
			.BZip=replace(tbSZip.text,"'","''")
			.BCountry=ddlSCountry.SelectedItem.Value
		end if
		'Shipping address-------------
			.SAddress=replace(tbSAddress.text,"'","''")
			.SCity=replace(tbSCity.text,"'","''")
			.SState=ddlSState.SelectedItem.Value
			.SZip=replace(tbSZip.text,"'","''")
			.SCountry=ddlSCountry.SelectedItem.Value
		'Org Info---------------------
		.Website=replace(tbWebsite.Text,"'","''")
		.Facebook=replace(tbFacebook.Text,"'","''")
		.Twitter=replace(tbTwitter.Text,"'","''")
		.Pinterest=replace(tbPinterest.text, "'","''")
		.Blog=replace(tbBlog.Text,"'","''")
		.ShelterPhone=replace(tbOrgPhone.text,"'","''")
		.Fax=replace(tbFax.text,"'","''")
		.ReferredBy=ddlRefer.SelectedItem.Value
		.ShelterName=replace(tbOrg.text,"'","''")
		'Adoption info
		.Dogs=tbDogs.text
		.Cats=tbCats.Text
		.Puppies=tbPuppies.Text
		.Kittens=tbKittens.Text
		.Other=tbOther.Text
		
		
		'1) make sure the username does not exist in the db

if  db.ExecuteScalar("SELECT UserID FROM tblUsers WHERE UserName='" & .UserName & "'")<>"" then 'found username already
	lblmessage.text="The Username you chose is already taken.  If you have already registered, you can login, or choose another Username and Password to continue.  Thanks!"
	exit sub
end if
	
	str1="INSERT INTO tblUsers (Username,password,email,hint,roles,UniqueID) values('" & .UserName & "','" & .Password & "','" & .Email & "','" & .Hint & "','h4th,','" & theUniqueID & "')"
	

	end with
	'insert User

	if db.ExecuteNonQuery(str1) then 'boolean return value true-get userid assigned 

		strResult=db.ExecuteScalar("SELECT UserID FROM tblUsers WHERE UserName='" & objUserDetails.UserName & "' AND Password='" & objUserDetails.Password & "'")
		if strResult<>"" then 'returned a value

				With objUserDetails
				.UserId=strResult
				str2="INSERT INTO tblH4thReg (ShelterID,ShelterName,ShelterPhone,Fax,Website,ReferredBy,FName,LName,ContactPhone,Email,MAddress,MCity,MState,MZip,MCountry,SAddress,SCity,SState,SZip,SCountry,Facebook,Twitter,Pintrest, Blog, lang, UniqueID, ExecName, ExecTitle, Title) values("
				str2 &=.UserID & ",'" & .ShelterName & "','"	& .ShelterPhone & "','" & .Fax & "','" & .Website & "','" & .ReferredBy & "','"
				str2 &=.FName & "','" & .LName & "','" & .ContactPhone & "','" & .Email & "','" & .BAddress & "','" & .BCity & "','"
				str2 &=.BState & "','" & .BZip & "','" & .BCountry & "','" & .SAddress & "','" & .SCity & "','" & .SState & "','" & .SZip & "','" & .SCountry & "','" & .Facebook & "','" & .Twitter & "','" & .Pinterest & "','" & .Blog & "','" & ddlLang.SelectedItem.Value & "','" & theUniqueID & "','" & replace(tbExecName.text,"'","''") & "','" & replace(tbExecTitle.text,"'","''") & "','" & replace(tbContactTitle.text,"'","''") & "')"
				'insert registration record
				db.ExecuteNonQuery(str2) 'success-email me and them, and send them to profile page
				'Insert animal goals
				str3="INSERT INTO tblH4thAdoptions (ShelterID, DateId, AYear, Dogs, Cats, Puppies, Kittens, other, AType) Values(" & .UserID & ",248,'2022'," & .Dogs & "," & .Cats & "," & .puppies & "," & .Kittens & "," & .Other & ",'Goal')"
				db.ExecuteNonQuery(str3)
				End With
						Session("UserID")=objUserDetails.UserId
						Session("ShelterName")=tbOrg.Text
						'----------------------------------------------------------------------------------------------------------------------------------------------------------------------
						'IMPLEMENT ROLES BASED SECURITY
						 Dim authTicket as FormsAuthenticationTicket = new FormsAuthenticationTicket(1, objUserDetails.UserId,DateTime.Now, DateTime.Now.AddMinutes(30), true, "h4th," )		
						 ' Now encrypt the ticket.
						 dim encryptedTicket  as string= FormsAuthentication.Encrypt(authTicket)
						'Create a cookie and add the encrypted ticket to the cookie as data.
						 Dim authCookie as HttpCookie=  new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket)
						 'Add the cookie to the outgoing cookies collection.
						 Response.Cookies.Add(authCookie)
						 '----------------------------------------------------------------------------------------------------------------------------------------------------------------------
					
						 '2.5)Email welcome letter to client and bcc me for approval
							dim objMM as New HWAC.EmailMessage
							with objMM
							.MailTo=objUserDetails.Email
							.From="Home 4 The Holidays <h4th@animalcenter.org>"
							.Subject="Welcome to the Home 4 The Holidays Campaign!"
							.Body="<table width=500 border=1 align=center cellpadding=4><tr><td><img src=""http://join.home4theholidays.org/_images/H4TH_color_sm.jpg"" width=225 height=67 align=right /><p>Congratulations, you are now a part of a worldwide campaign to give orphan animals a Home 4 The Holidays!<p>"
							.Body &="<p>Your personal account has been set up for you.  <br><Br>YOU MUST VERIFY YOUR ACCOUNT BY <a href=""http://join.home4theholidays.org/verify.aspx?Var1=" & theUniqueId & """>CLICKING HERE</a>.  YOUR PROFILE WILL NOT BE PUBLIC UNTIL YOU VERIFY IT.<br><br>You may view this account by <a href=http://join.home4theholidays.org/members>logging on</a> with the following information.</P>"
							.Body &="<table align=center cellspacing=2><tr><td><b>Username:</b></td><td>" & objUserDetails.UserName & "</td></tr><tr><td><b>Password:</b></td><td>" & objUserDetails.Password  & "</td></tr></table>"
							
							'.Body &="<p>Stay tuned for exciting news about this year's campaign:  coming soon!</p>"
							'.Body &="<p>Be sure to log in and set your adoption goal for the H4TH Campaign(October 1st-January 5th).</p>"
							'.Body &="<ul><li>November 14, 2005</li><li>November 21, 2005</li><li>November 28, 2005</li><li>December 5, 2005</li><li>December 12, 2005</li><li>December 19, 2005</li><li>December 26, 2005</li><li>January 2, 2006</li></ul>"
							.Body &="<p><a href=http://join.home4theholidays.org/members/adoptions.aspx>Click here</a> to log into your account to record your adoptions each week.  That way we can track the success of the program.</p>"
							.Body &="<p>You may also simply <b><a href=""http://join.home4theholidays.org/login.aspx?p=" & theUniqueId & "&l=account"">Click Here</a></b> to automatically log in.</p>"
							.Body &="<p>Thank you for your participation!</p></td></tr></table>"
							'need to include username and password, info about updating adoptions
							.Send_Email(objMM)
							End with
							with objMM
							.MailTo="lonjones@hotmail.com"
							.From="Home 4 The Holidays <h4th@animalcenter.org>"
							.Subject="H4TH Registration"
							.Body=session("ShelterName") & ", UserID:" & session("UserID") & " has created a new profile.<br>"
							end With
							with objUserDetails
							objMM.Body &=request.ServerVariables("REMOTE_ADDR") & "<br><br>"
							objMM.Body &="<a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegDisapprove&Var1=" & theUniqueID & """>Disapprove Registration</a>"
							
							objMM.Body &="<br><br><a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegActivate&Var1=" & theUniqueID & """>Activate Registration</a>"
							objMM.Body &="<br><br><a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegApprove&Var1=" & theUniqueID & """>Approve Registration</a>"
							
							objMM.Body &="<br><Br><a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegVerify&Var1=" & theUniqueID & """>Verify Registration</a>"
							objMM.Body &="<br><br><a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegDeActivate&Var1=" & theUniqueID & """>Deactivate Registration</a>"
							objMM.Body &="<br><br><br><a href=""http://www.animalcenter.org/utilities/utility.aspx?ID=AESvdtSeTS&function=H4THRegDelete&Var1=" & session("UserID") & """>Delete Registration</a><br>"
							objMM.Body &="UserName:" & .UserName & "<br>Password:" & .Password & "<br>Hint:" & .Hint & "<br>First Name:" & .FName & "<br>Last Name:" & .LName & "<br>Contact Phone:" & .ContactPhone & "<br>Email:" & .Email & "<br>BAddress:" & .BAddress & "<br>BCity:" & .BCity & "<br>BState:" & .BState & "<br>BZip:" & .BZip & "<br>BCoutry:" & .BCountry & "<br>SAddress:" & .SAddress & "<br>SCity:" & .SCity & "<br>SState:" & .SState & "<br>SZip:" & .SZip & "<br>SCountry:" & .SCountry & "<br>Website:" & .Website &  "<br>Shelter Phone:" & .ShelterPhone & "<br>Fax:" & .Fax & "<br>ShelterName:" & .ShelterName & "<br>Reffered By:" & .ReferredBy & "<br>Dogs:" & tbDogs.Text & " Cats:" & tbCats.Text & " Puppies:" & tbPuppies.text & " Kittens:" & tbKittens.Text & " Other:" & tbOther.Text & " <br/>Facebook:" & tbFacebook.text & " <br/>Twitter:" & tbTwitter.Text & "<br/>Pinterest:" & tbPinterest.Text & " <br/>Blog:" & tbBlog.Text & "<br/>Language:" & ddlLang.SelectedItem.Value
							
							End With
							objMM.Send_Email(objMM)
						
						'3) redirect user to member homepage with querystring for welcome message
						response.Redirect("members/index.aspx?FirstTime=true")
											 
			else 'Regstration did not go right
						lblmessage.text &="The system could not register you at this time, please try again. Thank you!"
						'delete login
						db.ExecuteNonQuery("DELETE FROM tblUsers WHERE UserName='" & objUserDetails.Username & "' AND Password='" & objUserDetails.Password & "'")
						
						exit sub
						
			end if		
	Else 'could not enter user logon info into tblUsers
	lblmessage.text="There has been an error with registration, please try again.  Thank You!"
	End if
	 
end sub



</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<meta name="description" content="Increase pet adoptions in your animal shelter by joining Blue Buffalo Home 4 the Holidays - register today!" />
  <meta name="keywords" content="pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />
  <style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</asp:content>


<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" > Join The Cause</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Shine  a Light by Joining Blue Buffalo Home 4 the Holidays<br>
</h1>
														  <div class="feature">
														    <p><strong>We want to help your pet  adoption organization increase adoptions and raise more funds for your  life-saving mission &ndash; FOR FREE. </strong>Become a Blue Buffalo Home 4 the Holidays  partner by registering your shelter today.</p>
														    <p><strong>ALL ORGANIZATIONS</strong>:  please check the&nbsp;<a href="http://join.home4theholidays.org/shelter_map.aspx">Shelter Map</a> to see if you are already registered. Please check all similar names before registering, to ensure no duplicate registrations.</p>
                                                            <ul>
                                                              <li><strong><em><u>If your organization IS NOT registered</u></em></strong>,  please fill out all of the fields to register for Blue&nbsp;Buffalo Home 4 the  Holidays. Once you are registered, you will have access to your personal  shelter profile, be able to enter your weekly adoptions online, receive special  announcements, download&nbsp;our annual informative guide to help  you increase adoptions, and more! </li>
                                                              <li><strong><em><u>If your organization IS registered</u></em></strong>, thank  you and please update your email, adoption goals and contact information  annually.  You can&nbsp;<a href="http://join.home4theholidays.org/members">log in here.</a></li>
                                                            </ul>
                                                            <h2>Register  my Pet Adoption Organization</h2>
  </div>
														  <p>&nbsp;</p><table width="460" align="center">
              <tr><td>
			<form runat="server">
              <asp:ValidationSummary runat="server" ShowMessageBox="true" ShowSummary="false"  ID="VSum" HeaderText="Please fill out all the required fields appropriately" /> 
			  <asp:Label ID="lblMessage" runat="server" Font-Bold="true" ForeColor="red"/>           
             
                <table cellpadding="0" cellspacing="0" >
                  <tr bgcolor="#0033FF">
                    <td nowrap>&nbsp;</td>
                    <td colspan="2" nowrap bgcolor="#0033FF"><h3 class="style2 style1">Choose Your Account Information</h4></td>
                  </tr>
                  <tr>
                    <td nowrap><span class="style1">*</span></td>
                    <td nowrap>Username:</td>
                    <td   align="left"><asp:TextBox id="tbUserName" runat="server" MaxLength="12"/>            
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="tbUserName" ErrorMessage="*Username required" Display="Dynamic" />
        </td>
                  </tr>
                  <tr>
                    <td nowrap><span class="style1">*</span></td>
                    <td nowrap>Password:</td>
                    <td><asp:TextBox id="tbPassword" runat="server" MaxLength="12"  TextMode="Password"/>            
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="tbPassword" ErrorMessage="*Password required"  Display="Dynamic"/>              
        </td>
                  </tr>
                  <tr>
                    <td nowrap><span class="style1">*</span></td>
                    <td nowrap>Confirm Password:</td>
                    <td><asp:TextBox id="tbPassword2"  MaxLength="12" runat="server"  TextMode="Password"/>            
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="tbPassword2" ErrorMessage="*Password required" Display="Dynamic" /> 
						<asp:CompareValidator ControlToCompare="tbPassword" Display="Dynamic" ValueToCompare="=" runat="server" ControlToValidate="tbPassword2" ErrorMessage="*Passwords do not match" />            
        </td>
                  </tr>
                  <tr>
                    <td nowrap><span class="style1">*</span></td>
                    <td nowrap>Password Hint:</td>
                    <td><asp:TextBox runat="server" MaxLength="200" Width="200" ID="tbHint" /><asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="req_Hint" ControlToValidate="tbHint" ErrorMessage="*Password Hint Required" /></td>
                  </tr>
                </table>
          
              <table cellpadding="0" cellspacing="0">
                <tr bgcolor="#0033FF">
                  <td width="8">&nbsp;</td>
                  <td colspan="2" nowrap bgcolor="#0033FF"><h3 class="style1">Organization Information</h4></td>
                </tr>
                <tr>
                  <td><span class="style1">*</span></td>
                  <td width="128" nowrap>Organization Name: </td>
                  <td width="314"><asp:textbox id="tbOrg" runat="server" Width="250" MaxLength="100"/>            
                      <asp:RequiredFieldValidator  ControlToValidate="tbOrg" ErrorMessage="*Organization name required" Display="Dynamic" runat="server" /></td>
                </tr>
				<tr>
                  <td><span class="style1">*</span></td>
                  <td nowrap>Phone Number: </td>
                  <td><asp:textbox id="tbOrgPhone" runat="server" MaxLength="20"/>            
                      <asp:RequiredFieldValidator  ControlToValidate="tbOrgPhone" ErrorMessage="*Phone number required" Display="Dynamic" runat="server" /></td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td>Fax Number: </td>
                  <td><asp:textbox id="tbFax" runat="server" MaxLength="20"/></td>
                </tr>
				<tr>
                  <td>&nbsp;</td>
                  <td nowrap>Website Address: </td>
                  <td><asp:TextBox  runat="server"  ID="tbWebsite" MaxLength="50" />
                  (ex. www.yourshelter.com)                      </td>
                </tr>
				<tr>
				  <td>&nbsp;</td>
				  <td nowrap>Facebook Link:</td>
				  <td><asp:TextBox  runat="server"  ID="tbFacebook" MaxLength="250"  Width="200"/></td>
			    </tr>
				<tr>
				  <td>&nbsp;</td>
				  <td nowrap>Twitter Link:</td>
				  <td><asp:TextBox  runat="server"  ID="tbTwitter" MaxLength="250"  Width="200"/></td>
			    </tr>
				<tr>
				  <td>&nbsp;</td>
				  <td nowrap>Pinterest Link:</td>
				  <td><asp:TextBox  runat="server"  ID="tbPinterest" MaxLength="250"  Width="200"/></td>
			    </tr>
				<tr>
				  <td>&nbsp;</td>
				  <td nowrap>Blog Link:</td>
				  <td><asp:TextBox  runat="server"  ID="tbBlog" MaxLength="250"  Width="200"/></td>
			    </tr>
				<tr>
				  <td>&nbsp;</td>
				  <td colspan="2" nowrap>Head of Organization 
(President/Executive Director)</td>
			    </tr>
				<tr>
				  <td>&nbsp;</td>
				  <td nowrap><blockquote>
				    <p>Name:</p>
			      </blockquote></td>
				  <td><asp:TextBox  runat="server"  ID="tbExecName" MaxLength="50"  Width="200"/>
			      <br /></td>
			    </tr>
				<tr>
				  <td>&nbsp;</td>
				  <td nowrap><blockquote>
				    <p>Title:</p>
			      </blockquote></td>
				  <td><asp:TextBox  runat="server"  ID="tbExecTitle" MaxLength="20"  Width="200"/></td>
			    </tr>
				<tr bgcolor="#0033FF">
                  <td>&nbsp;</td>
                  <td colspan="2" nowrap bgcolor="#0033ff"><h3 class="style1">
                  My Organization's Contact Person</td>
                </tr>
                <tr>
                  <td><span class="style1">*</span></td>
                  <td height="30">First Name: </td>
                  <td><asp:TextBox ID="tbFName" runat="server" MaxLength="20"/>
                    <asp:RequiredFieldValidator  ControlToValidate="tbFName" ErrorMessage="*First name required" Display="Dynamic" runat="server" /></td>
                </tr>
                <tr>
                  <td><span class="style1">*</span></td>
                  <td height="30"> Last Name: </td>
                  <td><asp:textbox id="tbLName" runat="server" MaxLength="20"/>            
                      <asp:RequiredFieldValidator  ControlToValidate="tbLName" ErrorMessage="*Last name required" Display="Dynamic" runat="server" /></td>
                </tr>
                
                <tr>
                  <td>&nbsp;</td>
                  <td>Title:</td>
                  <td><asp:textbox id="tbContactTitle" runat="server" MaxLength="20"/></td>
                </tr>
                <tr>
                  <td><span class="style1">*</span></td>
                  <td>Phone: </td>
                  <td><asp:textbox id="tbPhone" runat="server" MaxLength="20"/>            
                      <asp:RequiredFieldValidator  ControlToValidate="tbPhone" ErrorMessage="*Phone required" Display="Dynamic" runat="server" /></td>
                </tr>
                <tr>
                  <td><span class="style1">*</span></td>
                  <td nowrap>Email Address: </td>
                  <td><asp:textbox id="tbEmail" runat="server" MaxLength="100"/>            
                      <asp:RequiredFieldValidator runat="server" ControlToValidate="tbEmail" 	ErrorMessage="*Email is required" Display="Dynamic"/>              
                      <asp:regularexpressionvalidator runat="server" controltovalidate="tbEmail" 
					validationexpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" 
					errormessage="*That is not a valid email" 
					display="dynamic"/>      </td>
                </tr>
                <tr>
                  <td>&nbsp;</td>
                  <td nowrap>Language Preference:</td>
                  <td><asp:Dropdownlist runat="server" id="ddlLang">
                    <asp:ListItem value="English" Text="English" Selected="true"/>                  
                    <asp:ListItem value="French" text="French"/>                  
                                    
</Asp:DropdownList></td>
                </tr>
                
                <tr bgcolor="#0033FF">
                  <td>&nbsp;</td>
                  <td colspan="2" bgcolor="#0033FF"><h3 class="style1">Shipping Address</h4></td>
                </tr>
                <tr>
                  <td><span class="style1">*</span></td>
                  <td> Address: </td>
                  <td><asp:textbox id="tbSAddress" runat="server" MaxLength="50"/>            
                      <asp:RequiredFieldValidator  ControlToValidate="tbSAddress" ErrorMessage="*Shipping address required" Display="Dynamic" runat="server" /></td>
                </tr>
                <tr>
                  <td><span class="style1">*</span></td>
                  <td>City</td>
                  <td><asp:textbox id="tbSCity" runat="server" MaxLength="20"/>            
                      <asp:RequiredFieldValidator  ControlToValidate="tbSCity" ErrorMessage="*City required" Display="Dynamic" runat="server" /></td>
                </tr>
                <tr>
                  <td><span class="style1">*</span></td>
                  <td>State/Province</td>
                  <td><asp:Dropdownlist runat="server" id="ddlSState">
                      <asp:ListItem value="" Text="Choose a State"/>            
                      <asp:ListItem value="AK" text="AK"/>            
                      <asp:ListItem value="AL" text="AL"/>            
                      <asp:ListItem value="AR" text="AR"/>            
                      <asp:ListItem value="AZ" text="AZ"/>            
                      <asp:ListItem value="CA" text="CA"/>            
                      <asp:ListItem value="CO" text="CO"/>            
                      <asp:ListItem value="CT" text="CT"/>            
                      <asp:ListItem value="DC" text="DC"/>            
                      <asp:ListItem value="DE" text="DE"/>            
                      <asp:ListItem value="FL" text="FL"/>            
                      <asp:ListItem value="GA" text="GA"/>            
                      <asp:ListItem value="HI" text="HI"/>            
                      <asp:ListItem value="IA" text="IA"/>            
                      <asp:ListItem value="ID" text="ID"/>            
                      <asp:ListItem value="IL" text="IL"/>            
                      <asp:ListItem value="IN" text="IN"/>            
                      <asp:ListItem value="KS" text="KS"/>            
                      <asp:ListItem value="KY" text="KY"/>            
                      <asp:ListItem value="LA" text="LA"/>            
                      <asp:ListItem value="MA" text="MA"/>            
                      <asp:ListItem value="MD" text="MD"/>            
                      <asp:ListItem value="ME" text="ME"/>            
                      <asp:ListItem value="MI" text="MI"/>            
                      <asp:ListItem value="MN" text="MN"/>            
                      <asp:ListItem value="MO" text="MO"/>            
                      <asp:ListItem value="MS" text="MS"/>            
                      <asp:ListItem value="MT" text="MT"/>            
                      <asp:ListItem value="NC" text="NC"/>            
                      <asp:ListItem value="ND" text="ND"/>            
                      <asp:ListItem value="NE" text="NE"/>            
                      <asp:ListItem value="NH" text="NH"/>            
                      <asp:ListItem value="NJ" text="NJ"/>            
                      <asp:ListItem value="NM" text="NM"/>            
                      <asp:ListItem value="NV" text="NV"/>            
                      <asp:ListItem value="NY" text="NY"/>            
                      <asp:ListItem value="OH" text="OH"/>            
                      <asp:ListItem value="OK" text="OK"/>            
                      <asp:ListItem value="OR" text="OR"/>            
                      <asp:ListItem value="PA" text="PA"/>            
                      <asp:ListItem value="RI" text="RI"/>            
                      <asp:ListItem value="SC" text="SC"/>            
                      <asp:ListItem value="SD" text="SD"/>            
                      <asp:ListItem value="TN" text="TN"/>            
                      <asp:ListItem value="TX" text="TX"/>            
                      <asp:ListItem value="UT" text="UT"/>            
                      <asp:ListItem value="VA" text="VA"/>            
                      <asp:ListItem value="VT" text="VT"/>            
                      <asp:ListItem value="WA" text="WA"/>            
                      <asp:ListItem value="WI" text="WI"/>            
                      <asp:ListItem value="WV" text="WV"/>            
                      <asp:ListItem value="WY" text="WY"/>            
                      <asp:Listitem Value="" Text="_____________"/>            
                      <asp:ListItem text="US Territories" Value="" />            
                      <asp:Listitem Value="" Text=" "/>            
                      <asp:ListItem value="AS" text="AS"/>            
                      <asp:ListItem value="FM" text="FM"/>            
                      <asp:ListItem value="GU" text="GU"/>            
                      <asp:ListItem value="MH" text="MH"/>            
                      <asp:ListItem value="MP" text="MP"/>            
                      <asp:ListItem value="PR" text="PR"/>            
                      <asp:ListItem value="PW" text="PW"/>            
                      <asp:ListItem value="VI" text="VI"/>            
                      <asp:Listitem Value="" Text="_____________"/>            
                      <asp:ListItem text="US Military" Value="" />            
                      <asp:Listitem Value="" Text=" "/>            
                      <asp:ListItem value="AA" text="AA"/>            
                      <asp:ListItem value="AE" text="AE"/>            
                      <asp:ListItem value="AP" text="AP"/>            
                      <asp:Listitem Value="" Text="_____________"/>            
                      <asp:ListItem text="Canada" Value="" />            
                      <asp:Listitem Value="" Text=" "/>            
                      <asp:ListItem value="AB" text="AB"/>            
                      <asp:ListItem value="BC" text="BC"/>            
                      <asp:ListItem value="MB" text="MB"/>            
                      <asp:ListItem value="NB" text="NB"/>            
                      <asp:ListItem value="NL" text="NL"/>            
                      <asp:ListItem value="NS" text="NS"/>            
                      <asp:ListItem value="NT" text="NT"/>            
                      <asp:ListItem value="NU" text="NU"/>            
                      <asp:ListItem value="ON" text="ON"/>            
                      <asp:ListItem value="PE" text="PE"/>            
                      <asp:ListItem value="QC" text="QC"/>            
                      <asp:ListItem value="SK" text="SK"/>            
                      <asp:ListItem value="YT" text="YT"/>            
                      <asp:Listitem Value="" Text="_____________"/>            
                      <asp:ListItem text="Other Countries" Value="" />            
                      <asp:Listitem Value="" Text=" "/>            
                      <asp:ListItem value="None" text="None"/>            
        </Asp:DropdownList>
                      <asp:RequiredFieldValidator ID="req_SState" ControlToValidate="ddlSState" ErrorMessage="*State is required. Select None if State does not apply to you"  runat="server" Display="Dynamic"/></td>
                </tr>
                <tr>
                  <td><span class="style1">*</span></td>
                  <td>Zip Code</td>
                  <td><asp:textbox id="tbSZip" runat="server" MaxLength="15"/></td>
                </tr>
                <tr>
                  <td valign="top"><span class="style1">*</span></td>
                  <td valign="top">Country</td>
                  <td><asp:DropdownList id="ddlSCountry" runat="server" >
                      <asp:ListItem text="United States"/>            
                      <asp:ListItem text="Canada"/>            
                      <asp:ListItem text="Mexico"/>            
                      <asp:ListItem text="Afghanistan"/>            
                      <asp:ListItem text="Albania"/>            
                      <asp:ListItem text="Algeria"/>            
                      <asp:ListItem text="American Samoa"/>            
                      <asp:ListItem text="Andorra"/>            
                      <asp:ListItem text="Angola"/>            
                      <asp:ListItem text="Anguilla"/>            
                      <asp:ListItem text="Antarctica"/>            
                      <asp:ListItem text="Antigua and Barbuda"/>            
                      <asp:ListItem text="Argentina"/>            
                      <asp:ListItem text="Armenia"/>            
                      <asp:ListItem text="Aruba"/>            
                      <asp:ListItem text="Australia"/>            
                      <asp:ListItem text="Austria"/>            
                      <asp:ListItem text="Azerbaijan"/>            
                      <asp:ListItem text="Bahamas"/>            
                      <asp:ListItem text="Bahrain"/>            
                      <asp:ListItem text="Bangladesh"/>            
                      <asp:ListItem text="Barbados"/>            
                      <asp:ListItem text="Belarus"/>            
                      <asp:ListItem text="Belgium"/>            
                      <asp:ListItem text="Belize"/>            
                      <asp:ListItem text="Benin"/>            
                      <asp:ListItem text="Bermuda"/>            
                      <asp:ListItem text="Bhutan"/>            
                      <asp:ListItem text="Bolivia"/>            
                      <asp:ListItem text="Bosnia-Herzegovina"/>            
                      <asp:ListItem text="Botswana"/>            
                      <asp:ListItem text="Bouvet Island"/>            
                      <asp:ListItem text="Brazil"/>            
                      <asp:ListItem text="British Indian Ocean Territory"/>            
                      <asp:ListItem text="Brunei"/>            
                      <asp:ListItem text="Bulgaria"/>            
                      <asp:ListItem text="Burkina Faso"/>            
                      <asp:ListItem text="Burundi"/>            
                      <asp:ListItem text="Cambodia"/>            
                      <asp:ListItem text="Cameroon"/>            
                      <asp:ListItem text="Cape Verde"/>            
                      <asp:ListItem text="Cayman Islands"/>            
                      <asp:ListItem text="Central African Republic"/>            
                      <asp:ListItem text="Chad"/>            
                      <asp:ListItem text="Chile"/>            
                      <asp:ListItem text="China"/>            
                      <asp:ListItem text="Christmas Island"/>            
                      <asp:ListItem text="Cocos (Keeling) Islands"/>            
                      <asp:ListItem text="Colombia"/>            
                      <asp:ListItem text="Comoros"/>            
                      <asp:ListItem text="Congo"/>            
                      <asp:ListItem text="Cook Islands"/>            
                      <asp:ListItem text="Costa Rica"/>            
                      <asp:ListItem text="Croatia"/>            
                      <asp:ListItem text="Cuba"/>            
                      <asp:ListItem text="Cyprus"/>            
                      <asp:ListItem text="Czech Republic"/>            
                      <asp:ListItem text="Denmark"/>            
                      <asp:ListItem text="Djibouti"/>            
                      <asp:ListItem text="Dominica"/>            
                      <asp:ListItem text="Dominican Republic"/>            
                      <asp:ListItem text="East Timor"/>            
                      <asp:ListItem text="Ecuador"/>            
                      <asp:ListItem text="Educational"/>            
                      <asp:ListItem text="Egypt"/>            
                      <asp:ListItem text="El Salvador"/>            
                      <asp:ListItem text="Equatorial Guinea"/>            
                      <asp:ListItem text="Eritrea"/>            
                      <asp:ListItem text="Estonia"/>            
                      <asp:ListItem text="Ethiopia"/>            
                      <asp:ListItem text="Falkland Islands"/>            
                      <asp:ListItem text="Faroe Islands"/>            
                      <asp:ListItem text="Fiji"/>            
                      <asp:ListItem text="Finland"/>            
                      <asp:ListItem text="Former Czechoslovakia"/>            
                      <asp:ListItem text="Former USSR"/>            
                      <asp:ListItem text="France"/>            
                      <asp:ListItem text="French Guyana"/>            
                      <asp:ListItem text="French Southern Territories"/>            
                      <asp:ListItem text="Gabon"/>            
                      <asp:ListItem text="Gambia"/>            
                      <asp:ListItem text="Georgia"/>            
                      <asp:ListItem text="Germany"/>            
                      <asp:ListItem text="Ghana"/>            
                      <asp:ListItem text="Gibraltar"/>            
                      <asp:ListItem text="Great Britain"/>            
                      <asp:ListItem text="Greece"/>            
                      <asp:ListItem text="Greenland"/>            
                      <asp:ListItem text="Grenada"/>            
                      <asp:ListItem text="Guadeloupe (French)"/>            
                      <asp:ListItem text="Guam (USA)"/>            
                      <asp:ListItem text="Guatemala"/>            
                      <asp:ListItem text="Guinea"/>            
                      <asp:ListItem text="Guinea-Bissau"/>            
                      <asp:ListItem text="Guyana"/>            
                      <asp:ListItem text="Haiti"/>            
                      <asp:ListItem text="Heard and McDonald Islands"/>            
                      <asp:ListItem text="Holy See (Vatican City State)"/>            
                      <asp:ListItem text="Honduras"/>            
                      <asp:ListItem text="Hungary"/>            
                      <asp:ListItem text="Iceland"/>            
                      <asp:ListItem text="India"/>            
                      <asp:ListItem text="Indonesia"/>            
                      <asp:ListItem text="Iran"/>            
                      <asp:ListItem text="Iraq"/>            
                      <asp:ListItem text="Ireland"/>            
                      <asp:ListItem text="Israel"/>            
                      <asp:ListItem text="Italy"/>            
                      <asp:ListItem text="Ivory Coast (Cote D'Ivoire)"/>            
                      <asp:ListItem text="Jamaica"/>            
                      <asp:ListItem text="Japan"/>            
                      <asp:ListItem text="Jordan"/>            
                      <asp:ListItem text="Kazakhstan"/>            
                      <asp:ListItem text="Kenya"/>            
                      <asp:ListItem text="Kiribati"/>            
                      <asp:ListItem text="Kuwait"/>            
                      <asp:ListItem text="Kyrgyz Republic (Kyrgyzstan)"/>            
                      <asp:ListItem text="Laos"/>            
                      <asp:ListItem text="Latvia"/>            
                      <asp:ListItem text="Lebanon"/>            
                      <asp:ListItem text="Lesotho"/>            
                      <asp:ListItem text="Liberia"/>            
                      <asp:ListItem text="Libya"/>            
                      <asp:ListItem text="Liechtenstein"/>            
                      <asp:ListItem text="Lithuania"/>            
                      <asp:ListItem text="Luxembourg"/>            
                      <asp:ListItem text="Macau"/>            
                      <asp:ListItem text="Macedonia"/>            
                      <asp:ListItem text="Madagascar"/>            
                      <asp:ListItem text="Malawi"/>            
                      <asp:ListItem text="Malaysia"/>            
                      <asp:ListItem text="Maldives"/>            
                      <asp:ListItem text="Mali"/>            
                      <asp:ListItem text="Malta"/>            
                      <asp:ListItem text="Marshall Islands"/>            
                      <asp:ListItem text="Martinique (French)"/>            
                      <asp:ListItem text="Mauritania"/>            
                      <asp:ListItem text="Mauritius"/>            
                      <asp:ListItem text="Mayotte"/>            
                      <asp:ListItem text="Micronesia"/>            
                      <asp:ListItem text="Moldavia"/>            
                      <asp:ListItem text="Monaco"/>            
                      <asp:ListItem text="Mongolia"/>            
                      <asp:ListItem text="Montserrat"/>            
                      <asp:ListItem text="Morocco"/>            
                      <asp:ListItem text="Mozambique"/>            
                      <asp:ListItem text="Myanmar"/>            
                      <asp:ListItem text="Namibia"/>            
                      <asp:ListItem text="Nauru"/>            
                      <asp:ListItem text="Nepal"/>            
                      <asp:ListItem text="Netherlands"/>            
                      <asp:ListItem text="Netherlands Antilles"/>            
                      <asp:ListItem text="New Caledonia (French)"/>            
                      <asp:ListItem text="New Zealand"/>            
                      <asp:ListItem text="Nicaragua"/>            
                      <asp:ListItem text="Niger"/>            
                      <asp:ListItem text="Nigeria"/>            
                      <asp:ListItem text="Niue"/>            
                      <asp:ListItem text="Norfolk Island"/>            
                      <asp:ListItem text="Northern Mariana Islands"/>            
                      <asp:ListItem text="North Korea"/>            
                      <asp:ListItem text="Norway"/>            
                      <asp:ListItem text="Oman"/>            
                      <asp:ListItem text="Pakistan"/>            
                      <asp:ListItem text="Palau"/>            
                      <asp:ListItem text="Panama"/>            
                      <asp:ListItem text="Papua New Guinea"/>            
                      <asp:ListItem text="Paraguay"/>            
                      <asp:ListItem text="Peru"/>            
                      <asp:ListItem text="Philippines"/>            
                      <asp:ListItem text="Pitcairn Island"/>            
                      <asp:ListItem text="Poland"/>            
                      <asp:ListItem text="Polynesia (French)"/>            
                      <asp:ListItem text="Portugal"/>            
                      <asp:ListItem text="Puerto Rico"/>            
                      <asp:ListItem text="Qatar"/>            
                      <asp:ListItem text="Reunion (French)"/>            
                      <asp:ListItem text="Romania"/>            
                      <asp:ListItem text="Russian Federation"/>            
                      <asp:ListItem text="Rwanda"/>            
                      <asp:ListItem text="Saint Helena"/>            
                      <asp:ListItem text="Saint Kitts &amp; Nevis Anguilla"/>            
                      <asp:ListItem text="Saint Lucia"/>            
                      <asp:ListItem text="Saint Pierre and Miquelon"/>            
                      <asp:ListItem text="Saint Tome and Principe"/>            
                      <asp:ListItem text="Saint Vincent &amp; Grenadines"/>            
                      <asp:ListItem text="Samoa"/>            
                      <asp:ListItem text="San Marino"/>            
                      <asp:ListItem text="Saudi Arabia"/>            
                      <asp:ListItem text="Senegal"/>            
                      <asp:ListItem text="Seychelles"/>            
                      <asp:ListItem text="S. Georgia &amp; S. Sandwich Isls."/>            
                      <asp:ListItem text="Sierra Leone"/>            
                      <asp:ListItem text="Singapore"/>            
                      <asp:ListItem text="Slovak Republic"/>            
                      <asp:ListItem text="Slovenia"/>            
                      <asp:ListItem text="Solomon Islands"/>            
                      <asp:ListItem text="Somalia"/>            
                      <asp:ListItem text="South Africa"/>            
                      <asp:ListItem text="South Korea"/>            
                      <asp:ListItem text="Spain"/>            
                      <asp:ListItem text="Sri Lanka"/>            
                      <asp:ListItem text="Sudan"/>            
                      <asp:ListItem text="Suriname"/>            
                      <asp:ListItem text="Svalbard and Jan Mayen Islands"/>            
                      <asp:ListItem text="Swaziland"/>            
                      <asp:ListItem text="Sweden"/>            
                      <asp:ListItem text="Switzerland"/>            
                      <asp:ListItem text="Syria"/>            
                      <asp:ListItem text="Tadjikistan"/>            
                      <asp:ListItem text="Taiwan"/>            
                      <asp:ListItem text="Tanzania"/>            
                      <asp:ListItem text="Thailand"/>            
                      <asp:ListItem text="Togo"/>            
                      <asp:ListItem text="Tokelau"/>            
                      <asp:ListItem text="Tonga"/>            
                      <asp:ListItem text="Trinidad and Tobago"/>            
                      <asp:ListItem text="Tunisia"/>            
                      <asp:ListItem text="Turkey"/>            
                      <asp:ListItem text="Turkmenistan"/>            
                      <asp:ListItem text="Turks and Caicos Islands"/>            
                      <asp:ListItem text="Tuvalu"/>            
                      <asp:ListItem text="Uganda"/>            
                      <asp:ListItem text="Ukraine"/>            
                      <asp:ListItem text="United Arab Emirates"/>            
                      <asp:ListItem text="United Kingdom"/>            
                      <asp:ListItem text="Uruguay"/>            
                      <asp:ListItem text="USA Minor Outlying Islands"/>            
                      <asp:ListItem text="Uzbekistan"/>            
                      <asp:ListItem text="Vanuatu"/>            
                      <asp:ListItem text="Venezuela"/>            
                      <asp:ListItem text="Vietnam"/>            
                      <asp:ListItem text="Virgin Islands (British)"/>            
                      <asp:ListItem text="Virgin Islands (USA)"/>            
                      <asp:ListItem text="Wallis and Futuna Islands"/>            
                      <asp:ListItem text="Western Sahara"/>            
                      <asp:ListItem text="Yemen"/>            
                      <asp:ListItem text="Yugoslavia"/>            
                      <asp:ListItem text="Zaire"/>            
                      <asp:ListItem text="Zambia"/>            
                      <asp:ListItem text="Zimbabwe"/>            
        </asp:DropDownList>
                      <asp:RequiredFieldValidator ID="req_SCountry" ControlToValidate="ddlSCountry" ErrorMessage="*Country is required" runat="server" Display="Dynamic"/></td>
                </tr>
                <tr>
                  <td valign="top">&nbsp;</td>
                  <td colspan="2" valign="top"><asp:CheckBox runat="server" ID="chkMailing" Text="Mailing Address is the same as Shipping Address" AutoPostBack="true" OnCheckedChanged="chkMailing_Click" Checked="true"/>                    </td>
                </tr>
              </table>
              <asp:Panel runat="server" ID="pnlMailing" Visible="false">
                <table width="100%" cellpadding="0" cellspacing="0">
                  <tr>
                    <td valign="top" bgcolor="#0033FF">&nbsp;</td>
                    <td colspan="2" valign="top" bgcolor="#0033FF"><h3 class="style1">Mailing Address </h4></td>
                  </tr>
                  <tr>
                    <td valign="top"><span class="style1">*</span></td>
                    <td valign="top">Address:</td>
                    <td><asp:textbox id="tbMAddress" runat="server" MaxLength="50"/>
                      <asp:RequiredFieldValidator  ControlToValidate="tbMAddress" ErrorMessage="*Mailing address required" Display="Dynamic" runat="server" /></td>
                  </tr>
                  <tr>
                    <td><span class="style1">*</span></td>
                    <td>City: </td>
                    <td><asp:textbox id="tbMCity" runat="server" MaxLength="20"/>
                      <asp:RequiredFieldValidator  ControlToValidate="tbMCity" ErrorMessage="*City required" Display="Dynamic" runat="server" />                      </td>
                  </tr>
                  <tr>
                    <td><span class="style1">*</span></td>
                    <td>State/Province</td>
                    <td><asp:Dropdownlist runat="server" id="ddlMState">
                        <asp:ListItem value="" Text="Choose a State"/>            
                        <asp:ListItem value="AK" text="AK"/>            
                        <asp:ListItem value="AL" text="AL"/>            
                        <asp:ListItem value="AR" text="AR"/>            
                        <asp:ListItem value="AZ" text="AZ"/>            
                        <asp:ListItem value="CA" text="CA"/>            
                        <asp:ListItem value="CO" text="CO"/>            
                        <asp:ListItem value="CT" text="CT"/>            
                        <asp:ListItem value="DC" text="DC"/>            
                        <asp:ListItem value="DE" text="DE"/>            
                        <asp:ListItem value="FL" text="FL"/>            
                        <asp:ListItem value="GA" text="GA"/>            
                        <asp:ListItem value="HI" text="HI"/>            
                        <asp:ListItem value="IA" text="IA"/>            
                        <asp:ListItem value="ID" text="ID"/>            
                        <asp:ListItem value="IL" text="IL"/>            
                        <asp:ListItem value="IN" text="IN"/>            
                        <asp:ListItem value="KS" text="KS"/>            
                        <asp:ListItem value="KY" text="KY"/>            
                        <asp:ListItem value="LA" text="LA"/>            
                        <asp:ListItem value="MA" text="MA"/>            
                        <asp:ListItem value="MD" text="MD"/>            
                        <asp:ListItem value="ME" text="ME"/>            
                        <asp:ListItem value="MI" text="MI"/>            
                        <asp:ListItem value="MN" text="MN"/>            
                        <asp:ListItem value="MO" text="MO"/>            
                        <asp:ListItem value="MS" text="MS"/>            
                        <asp:ListItem value="MT" text="MT"/>            
                        <asp:ListItem value="NC" text="NC"/>            
                        <asp:ListItem value="ND" text="ND"/>            
                        <asp:ListItem value="NE" text="NE"/>            
                        <asp:ListItem value="NH" text="NH"/>            
                        <asp:ListItem value="NJ" text="NJ"/>            
                        <asp:ListItem value="NM" text="NM"/>            
                        <asp:ListItem value="NV" text="NV"/>            
                        <asp:ListItem value="NY" text="NY"/>            
                        <asp:ListItem value="OH" text="OH"/>            
                        <asp:ListItem value="OK" text="OK"/>            
                        <asp:ListItem value="OR" text="OR"/>            
                        <asp:ListItem value="PA" text="PA"/>            
                        <asp:ListItem value="RI" text="RI"/>            
                        <asp:ListItem value="SC" text="SC"/>            
                        <asp:ListItem value="SD" text="SD"/>            
                        <asp:ListItem value="TN" text="TN"/>            
                        <asp:ListItem value="TX" text="TX"/>            
                        <asp:ListItem value="UT" text="UT"/>            
                        <asp:ListItem value="VA" text="VA"/>            
                        <asp:ListItem value="VT" text="VT"/>            
                        <asp:ListItem value="WA" text="WA"/>            
                        <asp:ListItem value="WI" text="WI"/>            
                        <asp:ListItem value="WV" text="WV"/>            
                        <asp:ListItem value="WY" text="WY"/>            
                        <asp:Listitem Value="" Text="_____________"/>            
                        <asp:ListItem text="US Territories" Value="" />            
                        <asp:Listitem Value="" Text=" "/>            
                        <asp:ListItem value="AS" text="AS"/>            
                        <asp:ListItem value="FM" text="FM"/>            
                        <asp:ListItem value="GU" text="GU"/>            
                        <asp:ListItem value="MH" text="MH"/>            
                        <asp:ListItem value="MP" text="MP"/>            
                        <asp:ListItem value="PR" text="PR"/>            
                        <asp:ListItem value="PW" text="PW"/>            
                        <asp:ListItem value="VI" text="VI"/>            
                        <asp:Listitem Value="" Text="_____________"/>            
                        <asp:ListItem text="US Military" Value="" />            
                        <asp:Listitem Value="" Text=" "/>            
                        <asp:ListItem value="AA" text="AA"/>            
                        <asp:ListItem value="AE" text="AE"/>            
                        <asp:ListItem value="AP" text="AP"/>            
                        <asp:Listitem Value="" Text="_____________"/>            
                        <asp:ListItem text="Canada" Value="" />            
                        <asp:Listitem Value="" Text=" "/>            
                        <asp:ListItem value="AB" text="AB"/>            
                        <asp:ListItem value="BC" text="BC"/>            
                        <asp:ListItem value="MB" text="MB"/>            
                        <asp:ListItem value="NB" text="NB"/>            
                        <asp:ListItem value="NL" text="NL"/>            
                        <asp:ListItem value="NS" text="NS"/>            
                        <asp:ListItem value="NT" text="NT"/>            
                        <asp:ListItem value="NU" text="NU"/>            
                        <asp:ListItem value="ON" text="ON"/>            
                        <asp:ListItem value="PE" text="PE"/>            
                        <asp:ListItem value="QC" text="QC"/>            
                        <asp:ListItem value="SK" text="SK"/>            
                        <asp:ListItem value="YT" text="YT"/>            
                        <asp:Listitem Value="" Text="_____________"/>            
                        <asp:ListItem text="Other Countries" Value="" />            
                        <asp:Listitem Value="" Text=" "/>            
                        <asp:ListItem value="None" text="None"/>            
          </Asp:DropdownList>
                      <asp:RequiredFieldValidator ID="req_MState" ControlToValidate="ddlMState" ErrorMessage="*State is required. Select None if State does not apply to you"  runat="server" Display="Dynamic"/>                      
                    </td>
                  </tr>
                  <tr>
                    <td>&nbsp;</td>
                    <td>Zip Code</td>
                    <td><asp:textbox id="tbMZip" runat="server" MaxLength="15"/></td>
                  </tr>
                  <tr>
                    <td valign="top"><span class="style1">*</span></td>
                    <td valign="top">Country</td>
                    <td><asp:DropdownList id="ddlMCountry" runat="server" >
                        <asp:ListItem text="United States"/>            
                        <asp:ListItem text="Canada"/>            
                        <asp:ListItem text="Mexico"/>            
                        <asp:ListItem text="Afghanistan"/>            
                        <asp:ListItem text="Albania"/>            
                        <asp:ListItem text="Algeria"/>            
                        <asp:ListItem text="American Samoa"/>            
                        <asp:ListItem text="Andorra"/>            
                        <asp:ListItem text="Angola"/>            
                        <asp:ListItem text="Anguilla"/>            
                        <asp:ListItem text="Antarctica"/>            
                        <asp:ListItem text="Antigua and Barbuda"/>            
                        <asp:ListItem text="Argentina"/>            
                        <asp:ListItem text="Armenia"/>            
                        <asp:ListItem text="Aruba"/>            
                        <asp:ListItem text="Australia"/>            
                        <asp:ListItem text="Austria"/>            
                        <asp:ListItem text="Azerbaijan"/>            
                        <asp:ListItem text="Bahamas"/>            
                        <asp:ListItem text="Bahrain"/>            
                        <asp:ListItem text="Bangladesh"/>            
                        <asp:ListItem text="Barbados"/>            
                        <asp:ListItem text="Belarus"/>            
                        <asp:ListItem text="Belgium"/>            
                        <asp:ListItem text="Belize"/>            
                        <asp:ListItem text="Benin"/>            
                        <asp:ListItem text="Bermuda"/>            
                        <asp:ListItem text="Bhutan"/>            
                        <asp:ListItem text="Bolivia"/>            
                        <asp:ListItem text="Bosnia-Herzegovina"/>            
                        <asp:ListItem text="Botswana"/>            
                        <asp:ListItem text="Bouvet Island"/>            
                        <asp:ListItem text="Brazil"/>            
                        <asp:ListItem text="British Indian Ocean Territory"/>            
                        <asp:ListItem text="Brunei"/>            
                        <asp:ListItem text="Bulgaria"/>            
                        <asp:ListItem text="Burkina Faso"/>            
                        <asp:ListItem text="Burundi"/>            
                        <asp:ListItem text="Cambodia"/>            
                        <asp:ListItem text="Cameroon"/>            
                        <asp:ListItem text="Cape Verde"/>            
                        <asp:ListItem text="Cayman Islands"/>            
                        <asp:ListItem text="Central African Republic"/>            
                        <asp:ListItem text="Chad"/>            
                        <asp:ListItem text="Chile"/>            
                        <asp:ListItem text="China"/>            
                        <asp:ListItem text="Christmas Island"/>            
                        <asp:ListItem text="Cocos (Keeling) Islands"/>            
                        <asp:ListItem text="Colombia"/>            
                        <asp:ListItem text="Comoros"/>            
                        <asp:ListItem text="Congo"/>            
                        <asp:ListItem text="Cook Islands"/>            
                        <asp:ListItem text="Costa Rica"/>            
                        <asp:ListItem text="Croatia"/>            
                        <asp:ListItem text="Cuba"/>            
                        <asp:ListItem text="Cyprus"/>            
                        <asp:ListItem text="Czech Republic"/>            
                        <asp:ListItem text="Denmark"/>            
                        <asp:ListItem text="Djibouti"/>            
                        <asp:ListItem text="Dominica"/>            
                        <asp:ListItem text="Dominican Republic"/>            
                        <asp:ListItem text="East Timor"/>            
                        <asp:ListItem text="Ecuador"/>            
                        <asp:ListItem text="Educational"/>            
                        <asp:ListItem text="Egypt"/>            
                        <asp:ListItem text="El Salvador"/>            
                        <asp:ListItem text="Equatorial Guinea"/>            
                        <asp:ListItem text="Eritrea"/>            
                        <asp:ListItem text="Estonia"/>            
                        <asp:ListItem text="Ethiopia"/>            
                        <asp:ListItem text="Falkland Islands"/>            
                        <asp:ListItem text="Faroe Islands"/>            
                        <asp:ListItem text="Fiji"/>            
                        <asp:ListItem text="Finland"/>            
                        <asp:ListItem text="Former Czechoslovakia"/>            
                        <asp:ListItem text="Former USSR"/>            
                        <asp:ListItem text="France"/>            
                        <asp:ListItem text="French Guyana"/>            
                        <asp:ListItem text="French Southern Territories"/>            
                        <asp:ListItem text="Gabon"/>            
                        <asp:ListItem text="Gambia"/>            
                        <asp:ListItem text="Georgia"/>            
                        <asp:ListItem text="Germany"/>            
                        <asp:ListItem text="Ghana"/>            
                        <asp:ListItem text="Gibraltar"/>            
                        <asp:ListItem text="Great Britain"/>            
                        <asp:ListItem text="Greece"/>            
                        <asp:ListItem text="Greenland"/>            
                        <asp:ListItem text="Grenada"/>            
                        <asp:ListItem text="Guadeloupe (French)"/>            
                        <asp:ListItem text="Guam (USA)"/>            
                        <asp:ListItem text="Guatemala"/>            
                        <asp:ListItem text="Guinea"/>            
                        <asp:ListItem text="Guinea-Bissau"/>            
                        <asp:ListItem text="Guyana"/>            
                        <asp:ListItem text="Haiti"/>            
                        <asp:ListItem text="Heard and McDonald Islands"/>            
                        <asp:ListItem text="Holy See (Vatican City State)"/>            
                        <asp:ListItem text="Honduras"/>            
                        <asp:ListItem text="Hungary"/>            
                        <asp:ListItem text="Iceland"/>            
                        <asp:ListItem text="India"/>            
                        <asp:ListItem text="Indonesia"/>            
                        <asp:ListItem text="Iran"/>            
                        <asp:ListItem text="Iraq"/>            
                        <asp:ListItem text="Ireland"/>            
                        <asp:ListItem text="Israel"/>            
                        <asp:ListItem text="Italy"/>            
                        <asp:ListItem text="Ivory Coast (Cote D'Ivoire)"/>            
                        <asp:ListItem text="Jamaica"/>            
                        <asp:ListItem text="Japan"/>            
                        <asp:ListItem text="Jordan"/>            
                        <asp:ListItem text="Kazakhstan"/>            
                        <asp:ListItem text="Kenya"/>            
                        <asp:ListItem text="Kiribati"/>            
                        <asp:ListItem text="Kuwait"/>            
                        <asp:ListItem text="Kyrgyz Republic (Kyrgyzstan)"/>            
                        <asp:ListItem text="Laos"/>            
                        <asp:ListItem text="Latvia"/>            
                        <asp:ListItem text="Lebanon"/>            
                        <asp:ListItem text="Lesotho"/>            
                        <asp:ListItem text="Liberia"/>            
                        <asp:ListItem text="Libya"/>            
                        <asp:ListItem text="Liechtenstein"/>            
                        <asp:ListItem text="Lithuania"/>            
                        <asp:ListItem text="Luxembourg"/>            
                        <asp:ListItem text="Macau"/>            
                        <asp:ListItem text="Macedonia"/>            
                        <asp:ListItem text="Madagascar"/>            
                        <asp:ListItem text="Malawi"/>            
                        <asp:ListItem text="Malaysia"/>            
                        <asp:ListItem text="Maldives"/>            
                        <asp:ListItem text="Mali"/>            
                        <asp:ListItem text="Malta"/>            
                        <asp:ListItem text="Marshall Islands"/>            
                        <asp:ListItem text="Martinique (French)"/>            
                        <asp:ListItem text="Mauritania"/>            
                        <asp:ListItem text="Mauritius"/>            
                        <asp:ListItem text="Mayotte"/>            
                        <asp:ListItem text="Micronesia"/>            
                        <asp:ListItem text="Moldavia"/>            
                        <asp:ListItem text="Monaco"/>            
                        <asp:ListItem text="Mongolia"/>            
                        <asp:ListItem text="Montserrat"/>            
                        <asp:ListItem text="Morocco"/>            
                        <asp:ListItem text="Mozambique"/>            
                        <asp:ListItem text="Myanmar"/>            
                        <asp:ListItem text="Namibia"/>            
                        <asp:ListItem text="Nauru"/>            
                        <asp:ListItem text="Nepal"/>            
                        <asp:ListItem text="Netherlands"/>            
                        <asp:ListItem text="Netherlands Antilles"/>            
                        <asp:ListItem text="New Caledonia (French)"/>            
                        <asp:ListItem text="New Zealand"/>            
                        <asp:ListItem text="Nicaragua"/>            
                        <asp:ListItem text="Niger"/>            
                        <asp:ListItem text="Nigeria"/>            
                        <asp:ListItem text="Niue"/>            
                        <asp:ListItem text="Norfolk Island"/>            
                        <asp:ListItem text="Northern Mariana Islands"/>            
                        <asp:ListItem text="North Korea"/>            
                        <asp:ListItem text="Norway"/>            
                        <asp:ListItem text="Oman"/>            
                        <asp:ListItem text="Pakistan"/>            
                        <asp:ListItem text="Palau"/>            
                        <asp:ListItem text="Panama"/>            
                        <asp:ListItem text="Papua New Guinea"/>            
                        <asp:ListItem text="Paraguay"/>            
                        <asp:ListItem text="Peru"/>            
                        <asp:ListItem text="Philippines"/>            
                        <asp:ListItem text="Pitcairn Island"/>            
                        <asp:ListItem text="Poland"/>            
                        <asp:ListItem text="Polynesia (French)"/>            
                        <asp:ListItem text="Portugal"/>            
                        <asp:ListItem text="Puerto Rico"/>            
                        <asp:ListItem text="Qatar"/>            
                        <asp:ListItem text="Reunion (French)"/>            
                        <asp:ListItem text="Romania"/>            
                        <asp:ListItem text="Russian Federation"/>            
                        <asp:ListItem text="Rwanda"/>            
                        <asp:ListItem text="Saint Helena"/>            
                        <asp:ListItem text="Saint Kitts &amp; Nevis Anguilla"/>            
                        <asp:ListItem text="Saint Lucia"/>            
                        <asp:ListItem text="Saint Pierre and Miquelon"/>            
                        <asp:ListItem text="Saint Tome and Principe"/>            
                        <asp:ListItem text="Saint Vincent &amp; Grenadines"/>            
                        <asp:ListItem text="Samoa"/>            
                        <asp:ListItem text="San Marino"/>            
                        <asp:ListItem text="Saudi Arabia"/>            
                        <asp:ListItem text="Senegal"/>            
                        <asp:ListItem text="Seychelles"/>            
                        <asp:ListItem text="S. Georgia &amp; S. Sandwich Isls."/>            
                        <asp:ListItem text="Sierra Leone"/>            
                        <asp:ListItem text="Singapore"/>            
                        <asp:ListItem text="Slovak Republic"/>            
                        <asp:ListItem text="Slovenia"/>            
                        <asp:ListItem text="Solomon Islands"/>            
                        <asp:ListItem text="Somalia"/>            
                        <asp:ListItem text="South Africa"/>            
                        <asp:ListItem text="South Korea"/>            
                        <asp:ListItem text="Spain"/>            
                        <asp:ListItem text="Sri Lanka"/>            
                        <asp:ListItem text="Sudan"/>            
                        <asp:ListItem text="Suriname"/>            
                        <asp:ListItem text="Svalbard and Jan Mayen Islands"/>            
                        <asp:ListItem text="Swaziland"/>            
                        <asp:ListItem text="Sweden"/>            
                        <asp:ListItem text="Switzerland"/>            
                        <asp:ListItem text="Syria"/>            
                        <asp:ListItem text="Tadjikistan"/>            
                        <asp:ListItem text="Taiwan"/>            
                        <asp:ListItem text="Tanzania"/>            
                        <asp:ListItem text="Thailand"/>            
                        <asp:ListItem text="Togo"/>            
                        <asp:ListItem text="Tokelau"/>            
                        <asp:ListItem text="Tonga"/>            
                        <asp:ListItem text="Trinidad and Tobago"/>            
                        <asp:ListItem text="Tunisia"/>            
                        <asp:ListItem text="Turkey"/>            
                        <asp:ListItem text="Turkmenistan"/>            
                        <asp:ListItem text="Turks and Caicos Islands"/>            
                        <asp:ListItem text="Tuvalu"/>            
                        <asp:ListItem text="Uganda"/>            
                        <asp:ListItem text="Ukraine"/>            
                        <asp:ListItem text="United Arab Emirates"/>            
                        <asp:ListItem text="United Kingdom"/>            
                        <asp:ListItem text="Uruguay"/>            
                        <asp:ListItem text="USA Minor Outlying Islands"/>            
                        <asp:ListItem text="Uzbekistan"/>            
                        <asp:ListItem text="Vanuatu"/>            
                        <asp:ListItem text="Venezuela"/>            
                        <asp:ListItem text="Vietnam"/>            
                        <asp:ListItem text="Virgin Islands (British)"/>            
                        <asp:ListItem text="Virgin Islands (USA)"/>            
                        <asp:ListItem text="Wallis and Futuna Islands"/>            
                        <asp:ListItem text="Western Sahara"/>            
                        <asp:ListItem text="Yemen"/>            
                        <asp:ListItem text="Yugoslavia"/>            
                        <asp:ListItem text="Zaire"/>            
                        <asp:ListItem text="Zambia"/>            
                        <asp:ListItem text="Zimbabwe"/>            
          </asp:DropDownList>
                      <asp:RequiredFieldValidator ID="req_MCountry" ControlToValidate="ddlMCountry" ErrorMessage="*Country is required" runat="server" Display="Dynamic"/>                      
                    </td>
                  </tr>
                </table>
              </asp:Panel>
<table width="100%" cellpadding="0" cellspacing="0">
                  <tr>
                    <td valign="top" bgcolor="#0033FF">&nbsp;</td>
                    <td colspan="6" valign="top" bgcolor="#0033FF"><h3 class="style1">Adoption Information</h4></td>
                  </tr>
                  <tr>
                    <td valign="top">&nbsp;</td>
                    <td colspan="6" valign="top"><div align="center">Please enter the number of projected adoptions you will have during this year's Home 4 The Holidays October 1st-January 4th</div></td>
            </tr>
                  <tr>
                    <td valign="top"><span class="style1">*</span></td>
                   
                    <td> <div align="center">Dogs:</div></td>
                    <td> <div align="center">Puppies:</div></td>
                    <td> <div align="center">Cats:</div></td>
                    <td> <div align="center">Kittens:</div></td>
                    <td> <div align="center">Other:</div></td>
                  </tr>
                  <tr>
                    <td valign="top">&nbsp;</td>
                   
                    <td><div align="center">
                      <asp:textbox id="tbDogs" runat="server" Width="30" Text="0"/>                    
					    </div></td>
                    <td><div align="center">
                      <asp:TextBox ID="tbPuppies" runat="server" Width="30" Text="0"/>                    
                    </div></td>
                    <td><div align="center">
                      <asp:TextBox ID="tbCats" runat="server" Width="30" Text="0"/>                    
                    </div></td>
                    <td>
                      <div align="center">
                        <asp:TextBox ID="tbKittens" runat="server" Width="30" Text="0"/>                      
                      </div></td>
                    <td><div align="center">
                      <asp:TextBox ID="tbOther" runat="server" Width="30" Text="0"/>                    
                    </div></td>
                  </tr>
                  <tr>
                   
                    <td>&nbsp;</td>
                    <td colspan="6">					  <asp:RequiredFieldValidator  ControlToValidate="tbDogs" ErrorMessage="*Projected number of dogs required" Display="Dynamic" runat="server" />                    
                      <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" Display="Dynamic" ControlToValidate="tbDogs"  Type="Integer"  ErrorMessage="*Dogs must be a number between 0 and 2000"/>
                      <asp:RequiredFieldValidator  ControlToValidate="tbPuppies" ErrorMessage="*Projected number of Puppies required" Display="Dynamic" runat="server" />
                      <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" Display="Dynamic" ControlToValidate="tbPuppies"   Type="Integer" ErrorMessage="*Puppies must be a number between 0 and 2000"/> 
                      <asp:RequiredFieldValidator  ControlToValidate="tbCats" ErrorMessage="*Projected number of Cats required" Display="Dynamic" runat="server" /> 
                      <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" Display="Dynamic" ControlToValidate="tbCats"   Type="Integer" ErrorMessage="*Cats must be a number between 0 and 2000"/> 
                      <asp:RequiredFieldValidator  ControlToValidate="tbKittens" ErrorMessage="*Projected number of Kittens required" Display="Dynamic" runat="server" /> 
                      <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" Display="Dynamic" ControlToValidate="tbKittens"   Type="Integer" ErrorMessage="*Kittens must be a number between 0 and 2000"/> 
                      <asp:RequiredFieldValidator  ControlToValidate="tbOther" ErrorMessage="*Projected number of other animals required.  Enter 0 if none." Display="Dynamic" runat="server" /> 
                      <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" Display="Dynamic" ControlToValidate="tbOther"  Type="Integer" ErrorMessage="*Other animals must be a number between 0 and 2000"/>                                                                                                                                                                          					  
				    </td>
                  </tr>
              </table> 
			 <table>
			  <tr>
			    <td><span class="style1">*</span></td>
			  <td>How did you hear about us?</td>
			  </tr>
			  <tr>
			    <td height="43">&nbsp;</td>
			    <td><asp:DropDownList runat="server" ID="ddlRefer" MaxLength="100" Width="300">
					<asp:ListItem Text="--Choose One--" Value="" Selected="true"></asp:ListItem>
                    <asp:ListItem Text="HSUS Expo" Value="HSUS Expo" ></asp:ListItem>
				  <asp:ListItem Text="Blue Buffalo" Value="Blue Buffalo" ></asp:ListItem>
					<asp:ListItem Text="Best Friends" Value="Best Friends" ></asp:ListItem>
					<asp:ListItem Text="Conference" Value="Conference" ></asp:ListItem>
					<asp:ListItem Text="Delta Article" Value="Delta Article" ></asp:ListItem>
					<asp:ListItem Text="Direct Mail" Value="Direct Mail" ></asp:ListItem>
					<asp:ListItem Text="Direct Email" Value="Direct Email" ></asp:ListItem>
					<asp:ListItem Text="Friend" Value="Friend" ></asp:ListItem>
					<asp:ListItem Text="Google" Value="Google" ></asp:ListItem>
					<asp:ListItem Text="Helen Woodward Animal Center" Value="Helen Woodward Animal Center" ></asp:ListItem>
					<asp:ListItem Text="Hugs For Homeless" Value="Hugs For Homeless" ></asp:ListItem>
					<asp:ListItem Text="Humane Society Conference" Value="Humane Society Conference" ></asp:ListItem>
					<asp:ListItem Text="Other Shelter" Value="Other Shelter" ></asp:ListItem>
					<asp:ListItem Text="Other" Value="Other" ></asp:ListItem>
					<asp:ListItem Text="Petco" Value="Petco" ></asp:ListItem>
					<asp:ListItem Text="Petfinder.com" Value="Petfinder.com" ></asp:ListItem>
					<asp:ListItem Text="Previous Participant" Value="Previous Participant" ></asp:ListItem>
					<asp:ListItem Text="Shelter Source" Value="Shelter Source" ></asp:ListItem>
					<asp:ListItem Text="Yahoo Groups" Value="Yahoo Groups" ></asp:ListItem>

			</asp:DropDownList>
					<asp:RequiredFieldValidator runat="server" Display="Dynamic" ID="req_Refer" ControlToValidate="ddlRefer" ErrorMessage="*Reference is required"/>
				</td></tr>
			  </table>
              <table>
                <tr>
                  <td><asp:button  ID="btnRegister" OnClick="btnRegister_Click" runat="server" Text="Register Your Shelter!"/></td>
                </tr>
              </table>
            </form></td></tr></table>
													    
</asp:content>
