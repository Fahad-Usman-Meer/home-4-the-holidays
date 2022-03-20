<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Member Profile-Iams Home 4 The Holidays" debug="true" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SQLClient" %>

<script runat="server">
Sub Page_Load(obj as object, e as eventargs)
if session("UserId")="" then response.Redirect("../login.aspx?ReturnURL=../home4theholidays/members/index.aspx")
'Should always be member data, so get it with session id, and getreader class
'populate fields
if not page.ispostback then 'load fields
	Dim db as New HWAC.databaseH4TH
	Dim objReader as SQLDataReader
	Dim StrSQL as String
	StrSQL="SELECT  ShelterName, FName, LName, ContactPhone, MAddress, MCity, MState, MZip, MCountry, SAddress, SCity, SState, SZip, SCountry, ShelterPhone, Fax, Email, Website, ShowPublic, Facebook, Twitter, Blog, Lang, youtube, pintrest, capacity,Food_cat, Food_dog, Food_source, Vet, WhereVet, Animal_Focus, offsite_events, mobile_vehicle, work_with_retailers, which_retailers, want_adoption_retailer, pr_person, media_relations, place_ads, where_ads, want_marketing_retailer, attended_ACES, interested_ACES, IAMS_email_optin, participant_2012 FROM  dbo.tblH4THReg WHERE (ShelterID=" & session("UserID") & ")"
	objReader=db.GetReader(strSQL)
	if not objReader is nothing then 'has found data
		With objReader
		While .Read()'fill text boxes
			tbOrg.text=.GetString(0)
			tbFName.Text=.GetString(1)
			tbLName.Text=.GetString(2)
			tbPhone.Text=.GetString(3)
			tbMAddress.Text=.GetString(4)
			tbMCity.text=.GetString(5)
			ddlMState.Items.FindByValue(.GetString(6)).Selected=True
			tbMZip.Text=.GetString(7)
			ddlMCountry.Items.Insert(0, new ListItem(.GetString(8),.GetString(8)))
			tbSAddress.Text=.GetString(9)
			tbSCity.text=.GetString(10)
			ddlSState.Items.FindByValue(.GetString(11)).Selected=True
			tbSZip.Text=.GetString(12)
			ddlSCountry.Items.Insert(0, new ListItem(.GetString(13),.GetString(13)))
			tbOrgPhone.Text=.GetString(14)
			tbFax.text=.GetString(15)
			tbEmail.Text=.GetString(16)
			tbWebSite.Text=.GetString(17)
			tbFax.text=.GetString(15)
			tbEmail.Text=.GetString(16)
			tbWebSite.Text=.GetString(17)
			tbFacebook.text=.GetString(19)
			tbTwitter.Text=.GetString(20)
			tbBlog.Text=.GetString(21)
			ddlLang.Items.Insert(0, new ListItem(.GetString(22),.GetString(22)))
			'put check box values here .GetString(18)
				if mid(.getstring(18),1,1)="1" then chkOrgPhone.Checked=True
				if mid(.getstring(18),2,1)="1" then chkFax.Checked=True
				if mid(.getstring(18),3,1)="1" then chkName.Checked=True
				if mid(.getstring(18),4,1)="1" then chkContactPhone.Checked=True
				if mid(.getstring(18),5,1)="1" then chkEmail.Checked=True
				if mid(.getstring(18),6,1)="1" then chkShip.Checked=True
				if mid(.getstring(18),7,1)="1" then chkMail.Checked=True
			if .GetString(25)<>"" then ddlCapacity.Items.Insert(0, new ListItem(.GetString(25),.GetString(25)))
			if .GetString(26)<>"" then ddlFood_dog.Items.Insert(0, new ListItem(.GetString(26),.GetString(26)))
			if .GetString(27)<>"" then ddlFood_cat.Items.Insert(0, new ListItem(.GetString(27),.GetString(27)))
			if .GetString(28)<>"" then ddlFood_source.Items.Insert(0, new ListItem(.GetString(28),.GetString(28)))
			if .GetString(29)<>"" then ddlVet.Items.Insert(0, new ListItem(.GetString(29),.GetString(29)))
			tbWhereVet.Text=.GetString(30)
			'animal focus
			if instr(.GetString(31), "Dogs")>0 then chkDog.checked=True
			if instr(.GetString(31), "Cats")>0 then chkCat.checked=True
			if instr(.GetString(31), "Reptiles")>0 then chkReptile.checked=True
			if instr(.GetString(31), "Other")>0 then chkOther.checked=True
				
			if .GetString(32)<>"" then ddloffsite_events.Items.Insert(0, new ListItem(.GetString(32),.GetString(32)))
			if .GetString(33)<>"" then ddlmobile_vehicle.Items.Insert(0, new ListItem(.GetString(33),.GetString(33)))
			if .GetString(34)<>"" then ddlwork_with_retailers.Items.Insert(0, new ListItem(.GetString(34),.GetString(34)))
			tbwhich_retailers.Text=.GetString(35)
			if .GetString(36)<>"" then ddlwant_adoption_retailer.Items.Insert(0, new ListItem(.GetString(36),.GetString(36)))
			if .GetString(37)<>"" then ddlpr_person.Items.Insert(0, new ListItem(.GetString(37),.GetString(37)))
			if .GetString(38)<>"" then ddlMedia_relations.Items.Insert(0, new ListItem(.GetString(38),.GetString(38)))
			if .GetString(39)<>"" then ddlPlace_ads.Items.Insert(0, new ListItem(.GetString(39),.GetString(39)))
			tbWhere_ads.Text=.GetString(40)
			if .GetString(41)<>"" then ddlWant_marketing_retailer.Items.Insert(0, new ListItem(.GetString(41),.GetString(41)))
			if .GetString(42)<>"" then ddlAttended_aces.Items.Insert(0, new ListItem(.GetString(42),.GetString(42)))
			if .GetString(43)<>"" then ddlInterested_aces.Items.Insert(0, new ListItem(.GetString(43),.GetString(43)))
			if .GetString(44)<>"" then ddlIams_email_optin.Items.Insert(0, new ListItem(.GetString(44),.GetString(44)))
			if .item("participant_2012")=true then chkParticipant_2012.checked=true
			'particpant
			
			'show admin fields if neccessary
				if session("Admin")="@F@EWE$" then
					'show admin fields
					pnlAdmin.visible=true
				end if
		end While
		end with
	else' did not find data
		lblmessage.text="Account data not found. Please try again later. Thanks!"
		form1.visible=false
		
	end if 
end if

End Sub

Sub btnUpdate_Click(obj as object, e as eventargs)
'Update databaseH4TH h4th table with session, userid and fields 'call hwac.user.excecutenonquery
	Dim strResult as String
	Dim strSql as String
	dim objUserDetails as New HWAC.UserDetails
	Dim db as new HWAC.databaseH4TH
		with objUserDetails
		'Contact Details---------
		.FName=replace(tbFName.text,"'","''")
		.LName=replace(tbLName.Text,"'","''")
		.ContactPhone=replace(tbPhone.Text,"'","''")
		.Email=tbEmail.text
		'Mailing Address----------
			.BAddress=replace(tbMAddress.text,"'","''")
			.BCity=replace(tbMCity.text,"'","''")
			.BState=ddlMState.SelectedItem.Value
			.BZip=replace(tbMZip.text,"'","''")
			.BCountry=ddlMCountry.SelectedItem.Value
		'Shipping address-------------
			.SAddress=replace(tbSAddress.text,"'","''")
			.SCity=replace(tbSCity.text,"'","''")
			.SState=ddlSState.SelectedItem.Value
			.SZip=replace(tbSZip.text,"'","''")
			.SCountry=ddlSCountry.SelectedItem.Value
		'Org Info---------------------
		.Website=replace(tbWebsite.Text,"'","''")
		.ShelterPhone=replace(tbOrgPhone.text,"'","''")
		.Fax=replace(tbFax.text,"'","''")
		.ShelterName=replace(tbOrg.text,"'","''")
		.Facebook=replace(tbFacebook.Text,"'","''")
		.Twitter=replace(tbTwitter.Text,"'","''")
		.Blog=replace(tbBlog.Text,"'","''")
		session("ShelterName")=.ShelterName
		'showpublic values-----------------------
			dim strShowPublic as String="0000000"
				if  chkOrgPhone.Checked=True then mid(strShowPublic,1,1)="1"
				if chkFax.Checked=True then mid(strShowPublic,2,1)="1"
				if chkName.Checked=True then mid(strShowPublic,3,1)="1"
				if chkContactPhone.Checked=True then mid(strShowPublic,4,1)="1"
				if chkEmail.Checked=True then mid(strShowPublic,5,1)="1"
				if chkShip.Checked=True then mid(strShowPublic,6,1)="1"
				if chkMail.Checked=True then mid(strShowPublic,7,1)="1"

dim Animal_Focus as string="" 'build animal focus text
	if chkDog.checked then animal_focus="Dogs|"
	if chkCat.checked then animal_focus &="Cats|"
	if chkReptile.checked then animal_focus &="Reptiles|"
	if chkOther.checked then animal_focus &="Other|"
	if Animal_Focus<> "" then Animal_Focus=left(animal_focus,len(animal_focus)-1)
	

		strSql="UPDATE tblH4thReg Set FName='" & .FName & "', LName='" & .LName & "', ContactPhone='" &  .ContactPhone & "', Email='" & .Email & "', MAddress='" & .BAddress & "', MCity='" & .BCity & "', MState='" & .BState & "', MZip='" & .BZip & "', MCountry='" & .BCountry & "', SAddress='" & .SAddress & "', SCity='" & .SCity & "', SState='" & .SState & "', SZip='" & .SZip & "', SCountry='" & .SCountry & "', Website='" & .Website & "', ShelterPhone='" & .ShelterPhone & "', Fax='"	& .Fax & "', ShelterName='" & .ShelterName & "', ShowPublic='" & strShowpublic & "', Edited='" & now.tostring() & "', Facebook='" & .Facebook & "', Twitter='" & .Twitter & "', Blog='" &  .Blog & "', Lang='" & ddlLang.selectedItem.Value & "', youtube='" & tbYoutube.text & "', pintrest='" & tbPintrest.text & "', capacity='" & ddlCapacity.selectedItem.Value & "', Food_cat='" & ddlFood_cat.selectedItem.Value & "', Food_dog='" & ddlFood_dog.selectedItem.Value & "', Food_source='" & ddlFood_source.selectedItem.Value & "', Vet='" & ddlVet.selectedItem.Value & "', WhereVet='" & tbWhereVet.text & "', Animal_Focus='" & Animal_Focus & "', offsite_events='" & ddlOffsite_events.selectedItem.Value & "', mobile_vehicle='" & ddlmobile_vehicle.selectedItem.Value & "', work_with_retailers='" & ddlwork_with_retailers.selectedItem.Value & "', which_retailers='" & tbWhich_retailers.text & "', want_adoption_retailer='" & ddlwant_adoption_retailer.selectedItem.Value & "', pr_person='" & ddlpr_person.selectedItem.Value & "', media_relations='" & ddlmedia_relations.selectedItem.Value & "', place_ads='" & ddlplace_ads.selectedItem.Value & "', where_ads='" & tbWhere_ads.text & "', want_marketing_retailer='" & ddlwant_marketing_retailer.selectedItem.Value & "', attended_ACES='" & ddlAttended_ACES.selectedItem.Value & "', interested_ACES='" & ddlInterested_ACES.selectedItem.Value & "', IAMS_email_optin='" & ddlIAMS_email_optin.selectedItem.Value & "', participant_2012=" & iif(chkParticipant_2012.checked, "1","0") & " WHERE ShelterID=" & session("UserID")
		end with
		'lblmessage.text=strSQL
		'exit sub
	if db.ExecuteNonQuery(strSql) then 'successful
	lblmessage.text="Profile updated!  <a href=""../shelter_details.aspx?ShelterID=" & session("UserId") & """ target=""_blank"">View Profile</a>"
	form1.Visible=false
	'email userid to me so that I can approve it
		dim objMM as New HWAC.EmailMessage
							with objMM
							.MailTo="lonjones@hotmail.com"
							.From="Home 4 The Holidays <h4th@animalcenter.org>"
							.Subject="H4TH Profile Edit"
							.Body=session("ShelterName") & ", UserID:" & session("UserID") & " has edited their profile<br><br>"
							end With
							with objUserDetails
							objMM.Body &=.FName & "<br>" & .LName & "<br>" & .ContactPhone & "<br>" & .Email & "<br>" & .BAddress & "<br>" & .BCity & "<br>" & .BState & "<br>" & .BZip & "<br>" & .BCountry & "<br>" & .SAddress & "<br>" & .SCity & "<br>" & .SState & "<br>" & .SZip & "<br>" & .SCountry & "<br>" & .Website &  "<br>" & .ShelterPhone & "<br>" & .Fax & "<br>" & .ShelterName & "<br>" & .Facebook & "<br>" & .Twitter & "<br>" & .Blog & "<br>" & ddlLang.selectedItem.Value  & "<br>" & request.ServerVariables("REMOTE_ADDR")
							End With
							objMM.Send_Email(objMM)
	else 
		lblmessage.text=strSQl
	End if	
End Sub


</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<link rel="stylesheet" href="../_css/thickbox.css" type="text/css" media="screen" />
<link href="../_css/style.css" rel="stylesheet" type="text/css" />
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

<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >IH4TH Member Profile</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Edit your profile<br></h1><div class="feature">
                                                            <h3>Edit Profile</h3>
                                                            <asp:Label ID="lblMessage" Font-Bold="true" ForeColor="#FF0000" runat="server"/>                                                          
                                                            <p>Check the boxes next to the information you wish to display to the public</p>
                                                            <table align="center">
                                                              <tr>
                                                                <td><form runat="server" id="form1">
                                                                    <asp:ValidationSummary runat="server" ShowMessageBox="true" ShowSummary="false"  ID="VSum" HeaderText="Please fill out all the required fields appropriately" />                                                          
                                                                    <asp:Panel id="pnlRegister" runat="server" > </asp:Panel>
<table cellpadding="0" cellspacing="0">
                                                                      <tr>
                                                                        <td colspan="4" bgcolor="#006600"><h4 class="style2">Organization Information</h4></td>
                                                                        <td nowrap>&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>&nbsp;</td>
                                                                        <td><span class="style2">*</span></td>
                                                                        <td nowrap>Organization Name: </td>
                                                                        <td><asp:textbox id="tbOrg" runat="server" Width="275"/>                                                          
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbOrg" ErrorMessage="*Organization name required" Display="Dynamic" runat="server" /></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><asp:CheckBox ID="chkOrgPhone"  runat="server"/></td>
                                                                        <td><span class="style2">*</span></td>
                                                                        <td nowrap>Phone Number: </td>
                                                                        <td><asp:textbox id="tbOrgPhone" runat="server" MaxLength="20"/>                                                          
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbOrgPhone" ErrorMessage="*Phone number required" Display="Dynamic" runat="server" /></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><asp:CheckBox ID="chkFax" runat="server" /></td>
                                                                        <td>&nbsp;</td>
                                                                        <td>Fax Number: </td>
                                                                        <td><asp:textbox id="tbFax" runat="server" MaxLength="20"/></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>&nbsp;</td>
                                                                        <td>&nbsp;</td>
                                                                        <td nowrap>Website Address: </td>
                                                                        <td><asp:TextBox  runat="server"  ID="tbWebsite" MaxLength="50" />                                                          
                (ex. www.yourshelter.com)
                  <asp:RegularExpressionValidator runat="server" ControlToValidate="tbWebsite" ErrorMessage="That is not a valid website address." ValidationExpression="www.*.*" Display="Dynamic" /></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>&nbsp;</td>
                                                                        <td>&nbsp;</td>
                                                                        <td nowrap>Facebook Link:</td>
                                                                        <td><asp:TextBox  runat="server"  ID="tbFacebook" MaxLength="250"  Width="200"/></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>&nbsp;</td>
                                                                        <td>&nbsp;</td>
                                                                        <td nowrap>Twitter Link:</td>
                                                                        <td><asp:TextBox  runat="server"  ID="tbTwitter" MaxLength="250"  Width="200"/></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>&nbsp;</td>
                                                                        <td>&nbsp;</td>
                                                                        <td nowrap>Blog Link:</td>
                                                                        <td><asp:TextBox  runat="server"  ID="tbBlog" MaxLength="250"  Width="200"/></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>&nbsp;</td>
                                                                        <td>&nbsp;</td>
                                                                        <td nowrap>Youtube Channel:</td>
                                                                        <td><asp:TextBox  runat="server"  ID="tbYouTube" MaxLength="250"  Width="200"/></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>&nbsp;</td>
                                                                        <td>&nbsp;</td>
                                                                        <td nowrap>Pintrest Address:</td>
                                                                        <td><asp:TextBox  runat="server"  ID="tbPintrest" MaxLength="250"  Width="200"/></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr bgcolor="#006600">
                                                                        <td colspan="5"><h4 class="style2">Contact Information</h4></td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td rowspan="2"><asp:CheckBox ID="chkName" runat="server" /></td>
                                                                        <td><span class="style2">*</span></td>
                                                                        <td height="30">First Name: </td>
                                                                        <td><asp:TextBox ID="tbFName" runat="server" MaxLength="15"/>                                                          
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbFName" ErrorMessage="*First name required" Display="Dynamic" runat="server" /></td>
                                                                        <td rowspan="2">&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><span class="style2">*</span></td>
                                                                        <td height="30"> Last Name: </td>
                                                                        <td><asp:textbox id="tbLName" runat="server" MaxLength="15"/>                                                          
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbLName" ErrorMessage="*Last name required" Display="Dynamic" runat="server" /></td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><asp:CheckBox ID="chkContactPhone"  runat="server"/></td>
                                                                        <td><span class="style2">*</span></td>
                                                                        <td>Phone: </td>
                                                                        <td><asp:textbox id="tbPhone" runat="server" MaxLength="20"/>                                                          
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbPhone" ErrorMessage="*Phone required" Display="Dynamic" runat="server" /></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><asp:CheckBox ID="chkEmail"  runat="server"/></td>
                                                                        <td><span class="style2">*</span></td>
                                                                        <td nowrap>Email Address: </td>
                                                                        <td><asp:textbox id="tbEmail" runat="server" MaxLength="100"/>                                                          
                                                                            <asp:RequiredFieldValidator runat="server" ControlToValidate="tbEmail" 	ErrorMessage="*Email is required" Display="Dynamic"/>                                                            
                                                                            <asp:regularexpressionvalidator runat="server" controltovalidate="tbEmail" 
					validationexpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" 
					errormessage="*That is not a valid email" 
					display="dynamic"/>              </td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>&nbsp;</td>
                                                                        <td>&nbsp;</td>
                                                                        <td nowrap>Language Preference:</td>
                                                                        <td><asp:Dropdownlist runat="server" id="ddlLang">
                                                                          <asp:ListItem value="English" Text="English"/>                                                                        
                                                                          <asp:ListItem value="French" text="French"/>                                                                        
</Asp:DropdownList></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                      <tr bgcolor="#006600">
                                                                        <td colspan="5"><h4 class="style2">Shipping Address</h4></td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td rowspan="5"><asp:CheckBox ID="chkShip"  runat="server"/></td>
                                                                        <td><span class="style2">*</span></td>
                                                                        <td> Address: </td>
                                                                        <td><asp:textbox id="tbSAddress" runat="server" MaxLength="50"/>                                                          
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbSAddress" ErrorMessage="*Shipping address required" Display="Dynamic" runat="server" /></td>
                                                                        <td rowspan="5">&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><span class="style2">*</span></td>
                                                                        <td>City</td>
                                                                        <td><asp:textbox id="tbSCity" runat="server" MaxLength="20"/>                                                          
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbSCity" ErrorMessage="*City required" Display="Dynamic" runat="server" /></td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><span class="style2">*</span></td>
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
                                                                            <asp:ListItem value="NF" text="NF"/>                                                          
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
                                                                        <td><span class="style2">*</span></td>
                                                                        <td>Zip Code</td>
                                                                        <td><asp:textbox id="tbSZip" runat="server" MaxLength="20"/></td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td valign="top"><span class="style2">*</span></td>
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
                                                                  </table>
                                                            <table cellpadding="0" cellspacing="0">
                                                                      <tr bgcolor="#006600">
                                                                        <td colspan="5" valign="top"><h4 class="style2">Mailing Address </h4></td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td rowspan="5"><asp:CheckBox ID="chkMail"  runat="server"/></td>
                                                                        <td valign="top"><span class="style2">*</span></td>
                                                                        <td valign="top">Address:</td>
                                                                        <td><asp:textbox id="tbMAddress" runat="server" MaxLength="50"/>                                                          
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbMAddress" ErrorMessage="*Mailing address required" Display="Dynamic" runat="server" /></td>
                                                                        <td rowspan="5">&nbsp;</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><span class="style2">*</span></td>
                                                                        <td>City: </td>
                                                                        <td><asp:textbox id="tbMCity" runat="server" MaxLength="20"/>                                                          
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbMCity" ErrorMessage="*City required" Display="Dynamic" runat="server" />              </td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><span class="style2">*</span></td>
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
                                                                            <asp:ListItem value="NF" text="NF"/>                                                          
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
                                                                            <asp:RequiredFieldValidator ID="req_MState" ControlToValidate="ddlMState" ErrorMessage="*State is required. Select None if State does not apply to you"  runat="server" Display="Dynamic"/>              </td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><span class="style2">*</span></td>
                                                                        <td>Zip Code</td>
                                                                        <td><asp:textbox id="tbMZip" runat="server" MaxLength="20"/></td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td valign="top"><span class="style2">*</span></td>
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
                                                                            <asp:RequiredFieldValidator ID="req_MCountry" ControlToValidate="ddlMCountry" ErrorMessage="*Country is required" runat="server" Display="Dynamic"/>              </td>
                                                                      </tr>
                                                                  </table>
                                                            <br />
                                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                              <tr bgcolor="#006600">
                                                                <td colspan="5" valign="top"><h4 class="style2">Additional Questions-Answering these questions will help us help you grow your business and save more lives</h4></td>
                                                              </tr>
                                                              <tr>
                                                                <td rowspan="28">&nbsp;</td>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top" nowrap="nowrap"><strong>Shelter Information</strong></td>
                                                                <td>&nbsp;</td>
                                                                <td rowspan="28">&nbsp;</td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top" nowrap="nowrap">Shelter Capacity (average):</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlcapacity">
                                                                 <asp:ListItem value="" Text=""/>
                                                                                                                                  
                                                                  <asp:ListItem value="" text="10-50"/>                                                                
                                                                  <asp:ListItem value="51-100" text="51-100"/>                                                                
                                                                                                                                  
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">Primary Dog Food Brand Used:</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlFood_dog">
                               
                                                                  <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Beneful" text="Beneful"/>                                                                
                                                                  <asp:ListItem value="Purina Chows" text="Purina Chows"/>                                                                
                                                                  <asp:ListItem value="Purina ONE" text="Purina ONE"/>                                                                
                                                                  <asp:ListItem value="Pedigree" text="Pedigree"/>                                                                
                                                                  <asp:ListItem value="Science Diet" text="Science Diet"/>                                                                
                                                                  <asp:ListItem value="Store brands" text="Store brands"/>                                                                
                                                                  <asp:ListItem value="Other" text="Other"/>                                                                
                                                                                                                                  
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">Primary Cat Food Brand Used:</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlFood_cat">
                                                                  <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Meow Mix" text="Meow Mix"/>                                                                
                                                                  <asp:ListItem value="Fancy Feast" text="Fancy Feast"/>                                                                
                                                                  <asp:ListItem value="Whiskas" text="Whiskas"/>                                                                
                                                                  <asp:ListItem value="Friskies" text="Friskies"/>                                                                
                                                                  <asp:ListItem value="Purina Chows" text="Purina Chows"/>                                                                
                                                                  <asp:ListItem value="Science Diet" text="Science Diet"/>                                                                
                                                                  <asp:ListItem value="Store brand" text="Store brand"/>                                                                
                                                                                                                                  
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top" nowrap="nowrap">Prmary Source of Funding for Food:</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlFood_source">
                                                             
                                                                  <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Community Donations" text="Community Donations"/>                                                                
                                                                  <asp:ListItem value="Corporate Donations" text="Corporate Donations"/>                                                                
                                                                  <asp:ListItem value="Fundraisers" text="Fundraisers"/>                                                                
                                                                  <asp:ListItem value="Other" text="Other"/>                                                                
                                                                                                                                
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top" nowrap="nowrap">Do you have a Veterinarian on staff?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlVet">
                                                                  <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>
                                                                   <asp:ListItem value="No" text="No"/>                                                                
                                                                                                                                  
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">If no, how do you get Veterinary Services?</td>
                                                                <td><asp:textbox id="tbWhereVet" runat="server" MaxLength="250"/></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">Which animals do you help?</td>
                                                                <td><asp:CheckBox ID="chkDog"  runat="server" Text='Dogs'/>
                                                                <asp:CheckBox ID="chkCat"  runat="server" Text='Cats'/>
                                                                <asp:CheckBox ID="chkReptile"  runat="server" Text='Reptiles'/>
                                                                <asp:CheckBox ID="chkOther"  runat="server" Text='Other'/></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">Do you have experience with offsite adoption events?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddloffsite_events">
                                                                  <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>                                                                
                                                                  <asp:ListItem value="No" text="No"/>                                                                
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">Do you have a mobile adoption vehicle?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlmobile_vehicle">
                                                                  <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>                                                                
                                                                  <asp:ListItem value="No" text="No"/>                                                                
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">Have you worked with local retailers for adoption events?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlwork_with_retailers">
                                                                 <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>
                                                                   <asp:ListItem value="No" text="No"/>                                                                
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td>&nbsp;</td>
                                                                <td>If Yes, whom?</td>
                                                                <td><asp:textbox id="tbwhich_retailers" runat="server" MaxLength="250"/></td>
                                                              </tr>
                                                              <tr>
                                                                <td>&nbsp;</td>
                                                                <td>If No, are you interested in being teamed with a local retailer?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlwant_adoption_retailer">
                                                                    <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>
                                                                   <asp:ListItem value="No" text="No"/>                                                            
                                                                </Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td>&nbsp;</td>
                                                                <td><strong>Marketing</strong></td>
                                                                <td>&nbsp;</td>
                                                              </tr>
                                                              <tr>
                                                                <td>&nbsp;</td>
                                                                <td>Do you have a Public Relations person (volunteer, part/full time?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlpr_person">
                                                                   <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>
                                                                   <asp:ListItem value="No" text="No"/>                                                                
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">Do you have a relationship with your local media (TV, newspaper, etc)?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlmedia_relations">
                                                                  <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>
                                                                   <asp:ListItem value="No" text="No"/>                                                                
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">Do you place ads on a regular basis?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlplace_ads">
                                                                   <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>
                                                                   <asp:ListItem value="No" text="No"/>                                                                
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">If yes, where?</td>
                                                                <td><asp:textbox id="tbwhere_ads" runat="server" MaxLength="250"/></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">If no, are you interested in being teamed with a local retailer?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlwant_marketing_retailer">
                                                                   <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>
                                                                   <asp:ListItem value="No" text="No"/>                                                                
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">Have you attended an ACES workshop?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlattended_ACES">
                                                                   <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>
                                                                   <asp:ListItem value="No" text="No"/>                                                                
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">Are you interested in attending an ACES workshop?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlinterested_ACES">
                                                                  <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>
                                                                   <asp:ListItem value="No" text="No"/>
</Asp:DropdownList></td>
                                                              </tr>
                                                              <tr>
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top">May the IAMS Company contact you via email with future promotions?</td>
                                                                <td><asp:Dropdownlist runat="server" id="ddlIAMS_email_optin">
                                                                   <asp:ListItem value="" Text=""/>                                                                
                                                                  <asp:ListItem value="Yes" text="Yes"/>
                                                                   <asp:ListItem value="No" text="No"/>                                                                
</Asp:DropdownList></td>
                                                              </tr>
                                                            </table>
                                                            <asp:Panel ID="pnlAdmin" runat="server" Visible="false">
                                                            <table width="100%" cellpadding="0" cellspacing="0">
                                                              <tr bgcolor="#006600">
                                                                <td colspan="5" valign="top"><h4 class="style2">Admin</h4></td>
                                                              </tr>
                                                              <tr>
                                                                
                                                                <td valign="top">&nbsp;</td>
                                                                <td valign="top" nowrap="nowrap">2012 Participant</td>
                                                                <td><asp:CheckBox ID="chkParticipant_2012"  runat="server"/></td>
                                                              </tr>
                                                            </table>
                                                            </asp:Panel>
                                                            <p>&nbsp;</p>
                                                            <table>
                                                                      <tr>
                                                                        <td><asp:button  ID="btnUpdate" OnClick="btnUpdate_Click" runat="server" Text="Update Profile"/></td>
                                                                      </tr>
                                                                  </table>
                                                                </form></td>
                                                              </tr>
                                                            </table>
													      </div>
</asp:content>
