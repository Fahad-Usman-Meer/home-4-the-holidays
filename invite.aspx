<% @ Page Language="VB" MasterPageFile="~/template.master" Title=": Blue Buffalo Home 4 the Holidays – Invite a Shelter | Helen Woodward Animal Center" debug="true" %>

<script runat="server">

	Sub Page_Load(sender As Object, e As EventArgs)
	if not page.ispostback then 
		Dim objFocus as new HWAC.Utility
		RegisterStartupScript("FirstFocus", objFocus.MakeFocusScript(Me.txtFromName))

		lblmessage.text="I would like to invite you to join Blue Buffalo Home 4 the Holidays, the largest pet adoption campaign in the world! This adoption campaign raises awareness for pet adoption, puts puppy mills out of business and increases adoptions for animal shelters around the world. <a href=""http://www.home4theholidays.org"">Click Here</a> to learn more!"
	end if

End Sub

Sub Send_Email(sender as Object, e as EventArgs)
	Dim strSQL as String
		Dim IpTotal as String
  Dim objMM as New HWAC.EMailMessage()
  if txtCCEmail.text<>"" then
	  objMM.Cc = txtCCEmail.Text
  end if
  objMM.MailTo = txtToEmail.Text
  objMM.From = txtFromName.Text & " <" & txtFromEmail.Text & ">"
  objMM.Bcc = "lonj@animalcenter.org;" & txtBCCEmail.text 
  objMM.Subject = txtFromName.text & " has sent you a message about Home 4 the Holidays!"
  objMM.Body = lblMessage.Text & vbCrlf & "<hr>" & txtMessage.text & "<br><hr>"
  Dim Result as string
  dim strBody as string=objmm.body
  	if request.ServerVariables("REMOTE_ADDR")<>"121.54.49.85" then 'fraud
	'check for fraud
		Dim objGetData as New HWAC.databaseSEC
		
     	 'Get Total Shelters
		  strSQL ="SELECT COUNT(pkey) AS IPCount FROM [DwSQL_access].[tblWebsiteDatalog] WHERE  (DATEDIFF(hour, CreateDate, getdate()) <= 2) AND ip='" & request.ServerVariables("REMOTE_ADDR") & "'"
		  iptotal=objGetData.ExecuteScalar(strSQL)
		   'response.Write(iptotal & strsql)
		   'exit sub
		   if iptotal < 3 then 
		result=objMM.Send_Email(objMM)
			end if
	end if
		If Result<>"" then 
			lblmessage.text=result
		else
		
form1.visible=false
	lblthanks.visible=true
	pnlIntro.Visible=false
  lblThanks.text="<h3>Thank you, " & txtFromName.text & ", your message has been sent.  <br><br>Thank you for supporting the Home 4 The Holidays program!</h3>"
   if iptotal < 4 then 
  Dim db as new HWAC.databaseSEC
							Dim str1 as string
								
								str1="INSERT INTO [DwSQL_access].[tblWebsiteDatalog] (data,source,ip) values('" & replace(left(strbody,3950),"'","''") & "','h4th/invite.aspx','" & request.ServerVariables("REMOTE_ADDR") & "')"
								db.ExecuteNonQuery(str1)
	end if
end if 
End Sub
</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="description" content="Invite an animal shelter or rescue to join the Blue Buffalo home 4 the Holidays pet adoption campaign." />
  <meta name="keywords" content="pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />

</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" > Spread The Word</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Invite Shelters To Join Blue Buffalo Home 4 the Holidays<br></h1>
<table width="100%" border="0">
                                                            <tr>
                                                              <td width="592" valign="top"><asp:Label ID="lblThanks" runat="server"  Visible="false"/>                                                          
                                                                  <asp:Panel ID="pnlIntro" runat="server">
                                                                    <div class="feature">
                                                                      <p>The orphan  pets need your help! Invite other animal shelters or rescues you know to join  in this life-saving effort! More shelters joining Home 4 the Holidays, means  more pets will spend this holiday season in a loving home.</p>
Fill out the form below. To add multiple  addresses to the CC or BCC, separate addresses with a semicolon. <em>(Example: petadoptionshelter@domain.com;  myfriend@domain.com) </em>
<h3>&nbsp;</h3></asp:Panel>
                                                                  <form runat="server" id="form1">
                                                                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                                                                      <tr>
                                                                        <td>*Your Name </td>
                                                                        <td><asp:TextBox MaxLength="50" ID="txtFromName" runat="server"/>                                                            
                                                                            <br>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtFromName" runat="server"  ErrorMessage="*Your name is required"  Display="Dynamic"/>                                                              
            </td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>*Your Email </td>
                                                                        <td><asp:TextBox MaxLength="50" ID="txtFromEmail" runat="server"/>                                                            
                                                                            <br>
                                                                            <asp:RequiredFieldValidator ControlToValidate="txtFromEmail" runat="server"  ErrorMessage="*Your email is required"  Display="Dynamic"/>                                                              
                                                                            <asp:regularexpressionvalidator runat="server" controltovalidate="txtFromEmail" 
					validationexpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" 
					errormessage="*That is not a valid email" 
					display="dynamic"/></td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td width="105">*To Email </td>
                                                                        <td><asp:TextBox MaxLength="50" ID="txtToEmail" runat="server"/>                                                            
              One email only<br>
              <asp:RequiredFieldValidator ControlToValidate="txtToEmail" runat="server"  ErrorMessage="*To Email is required"  Display="Dynamic"/>
              <asp:regularexpressionvalidator runat="server" controltovalidate="txtToEmail" 
					validationexpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" 
					errormessage="*That is not a valid email" 
					display="dynamic"/></td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>CC Email </td>
                                                                        <td><asp:TextBox MaxLength="200" ID="txtCCEmail" runat="server"/>                                                            
              Separate multiple with a semicolon</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>BCC Email </td>
                                                                        <td><asp:TextBox MaxLength="200" ID="txtBCCEmail" runat="server"/>                                                            
              Separate multiple with a semicolon </td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>Your message will read: </td>
                                                                        <td><p>&nbsp;</p>                                                                          <p>
                                                                          <asp:Label runat="server" ID="lblMessage"  BackColor="#FFFF99"/>                                                                          </p>
                                                                        <p>&nbsp; </p></td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td>Add a personal message </td>
                                                                        <td><asp:TextBox  height="60" TextMode="MultiLine" MaxLength="255" runat="server" ID="txtMessage" width="360" Wrap="true"/></td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><asp:Button id="submit" OnClick="Send_Email" Text="Send Email" runat="server"/></td>
                                                                        <td>&nbsp;</td>
                                                                      </tr>
                                                                    </table>
                                                                  </form>
                                                                  </div>
                                                              </td>
                                                              <td width="4" valign="top">&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                              <td colspan="2">&nbsp;</td>
                                                            </tr>
                                                          </table>
</asp:content>
