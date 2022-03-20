<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Blue Buffalo Home 4 the Holidays Member Page | Helen Woodward Animal Center" debug="True" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SqlClient" %>
<script runat="server">
sub page_load(obj as object, e as EventArgs)
'if not instr(1,request("ReturnURL"),"home4theholidays")>0 then 'not h4th login send to hwac login
'	response.Redirect("http://www.animalcenter.org/HWACLogin.aspx?ReturnURL=" & request("ReturnURL"))
'end if

	if not page.ispostback then 'set focus to username
		Dim objFocus as new HWAC.Utility
		RegisterStartupScript("FirstFocus", objFocus.MakeFocusScript(Me.tbUsername))
		
		'check for auto login properties
		if not request.QueryString("p")="" and not request.QueryString("l")="" then
			'auto login, look up username, password
			Dologin(request.QueryString("p"), "")
		end if
		
	end if
end sub
Sub Login(obj as Object, e as EventArgs)
	if tbUsername.text="" or tbPassword.Text="" then
			lblmessage.text="Please enter both a Username and a Password"
		else
			DoLogin(tbUsername.text, tbPassword.Text)
	end if
end sub
Sub DoLogin(Username as string, Pass as string)

	dim objUser as New HWAC.User
	dim strResult as String
			
			strResult=objUser.LoginUser(Username, Pass) 'returns userid, in array
			if strResult <>"" then 'returned vaild data 0=UserID, 1=Roles 2=ShelterName 
				Dim arrResult as array
				arrResult=Split(strResult,"|")
				Session("UserID")=arrResult(0)
				if session("UserID")="1" then
					session("Admin")="@F@EWE$" 
				end if
				
				'----------------------------------------------------------------------------------------------------------------------------------------------------------------------
				'IMPLEMENT ROLES BASED SECURITY
				 Dim authTicket as FormsAuthenticationTicket = new FormsAuthenticationTicket(1, arrResult(0),DateTime.Now, DateTime.Now.AddMinutes(10), false, ArrResult(1) )		
				 ' Now encrypt the ticket.
				 dim encryptedTicket  as string= FormsAuthentication.Encrypt(authTicket)
				'Create a cookie and add the encrypted ticket to the cookie as data.
				 Dim authCookie as HttpCookie=  new HttpCookie(FormsAuthentication.FormsCookieName, encryptedTicket)
				 'Add the cookie to the outgoing cookies collection.
				 Response.Cookies.Add(authCookie)
				 'Initialize other session variables
				 dim db as new HWAC.databaseH4TH
				 dim strSql as string
				 dim objReader as SQLDataReader
				 
				 strSql="SELECT ShelterName FROM tblH4thReg WHERE ShelterId=" & session("UserId")
				 objReader=db.GetReader(strSql)
				 if not objReader is nothing then
					 while objReader.Read()
						session("ShelterName")=objReader.GetString(0)
					 End while
					 
				 end if
				 objReader.close
				'Redirect the user to the originally requested page
				' Response.Redirect( FormsAuthentication.GetRedirectUrl(tbUserName.Text, false ))
				if request.QueryString("l") <>"" then 
					if instr(request.QueryString("l"),"profile")>0 then response.Redirect("members/profile.aspx")
					if instr(request.QueryString("l"),"adoptions")>0 then response.Redirect("members/adoptions.aspx")
					if instr(request.QueryString("l"),"account")>0 then response.Redirect("members/account.aspx")
					'if  request.QueryString("l") ="adoptions" then
					'	response.Redirect("members/adoptions.aspx")
					'elseif  request.QueryString("l") ="account" then 
					'response.Redirect("members/" & request.QueryString("l") & ".aspx")
					'response.Redirect("members/profile.aspx")
				else
					response.Redirect("members/index.aspx")
				end if
				 '----------------------------------------------------------------------------------------------------------------------------------------------------------------------
			else
				lblMessage.Text="*That is not a valid Username and Password Combination*"
			end if
			
	end Sub
	
Sub EmailHint(obj as Object, e as EventArgs)
	if not tbUsername.text="" then
		dim objUser as new HWAC.User
		Dim EM as new HWAC.EmailMessage
			EM.From="h4th@animalcenter.org"
			EM.Subject="Home 4 The Holidays Password Hint"
			lblmessage.text=objUser.EmailHint(tbUsername.text, EM)
	else 
		lblmessage.text="*Please enter a Username to receive a password hint*"
	end if
End Sub
</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<meta name="description" content="Log into your Blue Buffalo Home 4 the Holidays account to update adoptions and manage your organization's contact information." />
  <meta name="keywords" content="pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />

  
</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" > Welcome Members</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Blue&nbsp;Buffalo Home 4 The Holidays Member Login<br>
</h1>
<div class="feature">
														  
														    <br>
														    Please enter your username and password below. If you are a new user, click <a href="register.aspx">here</a> to register. <br>
  <form runat="server" >
    <asp:Label ID="lblmessage" runat="server"  ForeColor="Red" Font-Bold="true"/>
    <table>
      <tr>
        <td >Username:</td>
        <td ><asp:TextBox ID="tbUsername"  runat="server" />        </td>
      </tr>
      <tr>
        <td valign="top">Password:</td>
        <td valign="top"><asp:textbox ID="tbPassword" TextMode="Password" runat="server" />        </td>
      </tr>
      <tr>
        <td colspan="2"><asp:Button ID="btSubmit" runat="server" OnClick="Login" Text="Log In" />
            <br>        </td>
      </tr>
      <tr>
        <td colspan="2"><asp:LinkButton ID="lnkbtnHint" Text="Send me my password hint" runat="server" OnClick="EmailHint"/></td>
      </tr>
      <tr>
        <td  colspan="2">If you cannot remember your username or password, please email&nbsp;<a href="mailto:h4th@animalcenter.org" target="_blank">h4th@animalcenter.org</a>&nbsp;to retrieve them. Please do not create a duplicate profile as you will lose all of your shelter's history for the program.</td>
      </tr>
    </table>
  </form>
													      </div>
</asp:content>
