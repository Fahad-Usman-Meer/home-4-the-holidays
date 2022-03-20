Imports System
Imports System.IO
Imports System.Web.Mail
Imports System.Net
Imports System.Net.Mail
Imports System.Data.SqlClient
Imports System.Web.SessionState
Imports System.Web
Imports System.Configuration
Imports System.Text
Imports System.Data
Imports System.String
Imports Microsoft.Visualbasic


Namespace HWAC
Public Class UserDetails
	Public UserId as string
	Public UserName as string
	Public Password as String
	Public Hint as string
	Public FName as string
	Public LName as String
	Public Prefix as String
	Public BCity as String
	Public BAddress as String
	Public BAddress2 as string
	Public BState as String
	Public BZip as String
	Public BCountry as String 
	Public SAddress as String
	Public SCity as string
	Public SState as String
	Public SZip as string
	Public SCountry as string
	Public Email as string
	Public ShelterName as string
	Public ContactPhone as string
	Public ShelterPhone as string
	Public Website as string
	Public Fax as string
	Public ReferredBy as string
	Public Dogs as string
	Public Cats as string
	Public Kittens as string
	Public Puppies as string
	Public Other as string
	Public Facebook as string
	Public Twitter as string
	Public Pinterest as string
	Public Blog as string
	Public EmergencyContact as String
	Public IPAddress as string
	
	
End Class
Public Class User
	
	Public Function LoginUser(UserName as String,Password as string)as String
	'Log user in and return userid
	dim strSQL as string
	dim db as new databaseH4TH
	dim objReader as SQLDataReader
	strSQL="SELECT dbo.tblUsers.UserID, dbo.tblUsers.Roles FROM dbo.tblUsers WHERE ((dbo.tblUsers.UserName = N'" & Username & "') AND (dbo.tblUsers.Password = N'" & Password & "')) OR (UniqueId=N'" & Username & "')" 
	 objreader=db.GetReader(strSQL)
	if not objreader is Nothing then'has data
		Dim strResult as string
		While objReader.Read()
		strResult=objReader.GetInt32(0) & "|" & objReader.GetString(1)
		end While
		Return strResult
	else
		return nothing
	end if
	
	End Function



	Public Function EmailHint(UserName as string, EM as EmailMessage) as String
		'get email from tblUsers, 
		Dim strEmail as string
		Dim strHint as string
		Dim strSQL as string="SELECT Email,Hint, UniqueID FROM tblUsers WHERE UserName='" & Username & "'"
		Dim objDatabase as new HWAC.DatabaseH4TH
		Dim objReader as SqlDataReader
		objReader=objDatabase.GetReader(strSQL)
		While objReader.Read
			strEmail=objReader.Item("Email")
			strHint=objReader.Item("Hint")
		End While
		if strEmail<>"" AND strHint<>"" then 'ok email hint
			EM.MailTo=strEmail
			EM.Body="Here is your password hint.  Please return to the login page and try again!  Thanks.<br><br>" & strHint
			dim strResult as string	
			strResult= EM.Send_Email(EM)
			if strResult<>Nothing then 'error sending
				Return StrResult
			else
				Return "Your password hint has been sent to your registration email address."
			end if
		Else
			Return "User Name not found, please try again"
		End If
	End Function
End Class



Public Class EmailMessage
	public MailTo as string
	public From as string
	public CC as string
	public Bcc as string
	public Sender as string
	Public Subject as string
	Public Body as string
	Public Attachment as string
	
Public Function Send_EmailArvixe(objEmail as EmailMessage) as string
'	______________________________________________
	'ARVIXE Code sample for sending mail in code
	'To send an email from .NET, use this code:

      Dim msg As New System.Net.Mail.MailMessage(objEmail.From, objEmail.Mailto)
      msg.Subject = objEmail.Subject
     msg.Body = objEmail.Body
	 msg.isbodyhtml="true"
	 'msg.To=objEmail.Mailto 
	' msg.From=

      Dim client As New System.Net.Mail.SmtpClient("relay-hosting.secureserver.net")
      client.Credentials = New Net.NetworkCredential("noreply@aanimalcenter.org", "oAj85Cvr$iQj")
	  Try
	 	client.Send(msg)
	  'return Nothing
	  Catch e as exception
		return "There has been a problem. " & e.ToString() & "  Please try again."
	  end try
      
'    ________________________________________________________	

end function
	
	Public Function Send_Email(objEmail as EmailMessage) as string
'	______________________________________________
	'ARVIXE Code sample for sending mail in code
	'To send an email from .NET, use this code:

     ' Dim msg As New MailMessage("to@example.com", "<emailaddress in your domain>")
      'msg.Subject = "Subject here"
      'msg.Body = "Body here"

      'Dim client As New SmtpClient("localhost")
      'client.Credentials = New Net.NetworkCredential("<email address in your domain>", "<password of this emailaccount>")
      'client.Send(msg)
'    ________________________________________________________	
	
	
		Const cdoSendUsingPickup = 1 'Send message using the local SMTP service pickup directory.
		Const cdoSendUsingPort = 2 'Send the message using the network (SMTP over the network).
		
		Const cdoAnonymous = 0 'Do not authenticate
		Const cdoBasic = 1 'basic (clear-text) authentication
		Const cdoNTLM = 2 'NTLM
		
		dim objMessage = HttpContext.Current.Server.CreateObject("CDO.Message")
		objMessage.Subject = objEmail.Subject
		objMessage.Sender = objEmail.From
		objMessage.From = objEmail.From
		objMessage.To = objEmail.MailTo
		objMessage.HtmlBody = objEmail.Body
		objMessage.HtmlBody.replace("<BR>","<BR>"&vbcr)
		objMessage.CC=objEmail.CC
		objMessage.BCC=objEmail.BCC
	
		'==This section provides the configuration information for the remote SMTP server.
		'==THIS IS ONLY SET UP FOR ASPHOSTCENTRAL EMAIL SYSTEM, BASED UPON EMAIL ACCOUNT
		'==CREATED IN THE ASPHOST CONTROL PANEL
		
		objMessage.Configuration.Fields.Item _
		("http://schemas.microsoft.com/cdo/configuration/sendusing") = 2
		
		'Name or IP of Remote SMTP Server
		objMessage.Configuration.Fields.Item _
		("http://schemas.microsoft.com/cdo/configuration/smtpserver") = "relay-hosting.secureserver.net"
		
		'Type of authentication, NONE, Basic (Base64 encoded), NTLM
		objMessage.Configuration.Fields.Item _
		("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate") = cdoBasic
		
		'Your UserID on the SMTP server
		objMessage.Configuration.Fields.Item _
		("http://schemas.microsoft.com/cdo/configuration/sendusername") = "noreply@animalcenter.org"
		
		'Your password on the SMTP server
		objMessage.Configuration.Fields.Item _
		("http://schemas.microsoft.com/cdo/configuration/sendpassword") ="oAj85Cvr$iQj"
		
		'Server port (typically 25)
		objMessage.Configuration.Fields.Item _
		("http://schemas.microsoft.com/cdo/configuration/smtpserverport") = 25
		
		'Use SSL for the connection (False or True)
		objMessage.Configuration.Fields.Item _
		("http://schemas.microsoft.com/cdo/configuration/smtpusessl") = False
		
		'Connection Timeout in seconds (the maximum time CDO will try to establish a connection to the SMTP server)
		objMessage.Configuration.Fields.Item _
		("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout") = 60
		
		objMessage.Configuration.Fields.Update
		
	  Try
	 	objMessage.Send
	  'return Nothing
	  Catch e as exception
		return "There has been a problem. " & e.ToString() & "  Please try again."
	  end try
	End Function

	Public Function EmailHint(UserName as string, EM as EmailMessage) as String
		'get email from tblUsers, 
		Dim strEmail as string
		Dim strHint as string
		Dim strSQL as string="SELECT Email,Hint FROM tblUsers WHERE UserName='" & Username & "'"
		Dim objDatabase as new HWAC.DatabaseH4TH
		Dim objReader as SqlDataReader
		objReader=objDatabase.GetReader(strSQL)
		While objReader.Read
			strEmail=objReader.Item("Email")
			strHint=objReader.Item("Hint")
		End While
		if strEmail<>"" AND strHint<>"" then 'ok email hint
			EM.MailTo=strEmail
			EM.Body="Here is your password hint.  Please return to the login page and try again!  Thanks.<br><br>" & strHint
			dim strResult as string	
			strResult= EM.Send_Email(EM)
			if strResult<>Nothing then 'error sending
				Return StrResult
			else
				Return "Your password hint has been sent to your registration email address."
			end if
		Else
			Return "User Name not found, please try again"
		End If
	End Function
End Class
'--------------------------------------------------------------------------------------------------------------------------------
Public Class Utility
	Public Function RecordSaveThisLife
		
		
		'Open a file for writing
		Dim FILENAME as String =HttpContext.Current.server.mappath("..\cgi-bin\SaveThisLife.txt") ''"C:\ClientSites\animalcenter.org\httpdocs\cgi-bin\SaveThisLife.txt"
		'Get a StreamWriter class that can be used to write the file
	    Dim objStreamWriter as StreamWriter
		objStreamWriter = File.AppendText(FILENAME)
	
		'Append the the end of the string, 
		'current date and time
		objStreamWriter.WriteLine(DateTime.Now.ToString() & " | " & HttpContext.Current.Request.ServerVariables("REMOTE_ADDR") )
	
		'Close the stream
		objStreamWriter.Close()
		
	
	end Function
	
	Public Function SignUpForNewsletter(objUserDetails as UserDetails) as string
		'return result or error
		'Open a file for writing
		Dim FILENAME as String ="G:\PleskVhosts\animalcenter.org\httpdocs\cgi-bin\newsletter.txt"''"C:\ClientSites\animalcenter.org\httpdocs\cgi-bin\newsletter.txt"
		'Get a StreamWriter class that can be used to write the file
	    Dim objStreamWriter as StreamWriter
		objStreamWriter = File.AppendText(FILENAME)
	
		'Append the the end of the string, 
		'followed by the current date and time
		with objUserDetails
		objStreamWriter.WriteLine(.Email & "," & .FName & "," & .LName & "," & DateTime.Now.ToString())
		end with
		'Close the stream
		objStreamWriter.Close()
		
		Dim strResult as String="You are signed up for our e-newsletter as " & objUserDetails.Email & "!  Please be sure to add animalcenter.org to your email safe list to avoid our newsletters being marked as spam."
		
		 Dim objMM as New HWAC.EMailMessage()
	  Dim strBody as string
	  	with objUserDetails
			strBody=.Email & "," & .FName & " " & .LName 
		end with
	  objMM.MailTo = "ShantiP@animalcenter.org"
	  objMM.BCC="lonjones@hotmail.com"
	  objMM.From ="Helen Woodward Animal Center <development@Animalcenter.org>"
	  objMM.Subject = "Newsletter Signup"
	  objMM.Body = strBody
	  
	  objMM.Send_Email(objMM)
		
		
		
		return strResult
	
	end Function
	
	Public Function MakeFocusScript(ByVal WebCtl As System.Web.UI.Control) As String

		'Generate the startup script to register for setting focus to a given control on a webpage
		
		Dim sCtlName As String = WebCtl.ClientID.ToString
		'Create the javascript
		Dim sbScript As New System.Text.StringBuilder
		With sbScript
		
		.Append("<script language='javascript'>")
		.Append("function setFocus() {")
		.Append(" if (document.getElementById('" & sCtlName & "') != null) {")
		.Append(" document.getElementById('" & sCtlName & "').focus();")
		.Append(" }")
		.Append("}")
		.Append(" setFocus();")
		.Append("</script>")
		
		End With
		
		Return sbScript.ToString

	End Function

	Public Function CreateGraph(BigNum as integer, SmallNum as integer) as string
		dim i as integer=math.abs(SmallNum/BigNum*100) 'get percentage for chart
		if i>100 then i=100
		if i=0 then i=1
		dim strBackColor as string="Red"
		dim result as string
			Select case i 'set graph bar color
				case 0 to 25
					strBackColor="Orange"
				case 26 to 50	
					strBackcolor="Yellow"
				case 51 to 75
					strBackcolor="Blue"
				case 76 to 100
					strBackcolor="Green"
			End select
			result ="<table cellpadding=0 cellspacing=0 width=200><tr><td width=" & i & "% align=right bgColor=" & strBackColor & ">-</td><td align=left width=" & 100-i & "%>" & SmallNum & "</td></tr></table>"
			return result
	End function


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
End Class

Public Class LayoutFunction

	public function GetHeaderRandomImageNumber as integer
		Dim r As New Random(System.DateTime.Now.Millisecond)
		dim x as integer
			 x=r.Next(1,13)
			 return x
	end function
End Class

'-------------------------------------------------------------------------------------------------------------------------
'-------------------------------------------------------------------------------------------------------------------------
Public Class PaymentDetails
	Public Amount as String
	Public CreditCardNumber as string
	Public Expiration as string 'ExpMonth & "/" & ExpYear
	Public Desc as String
	Public OtherInfo as string
	Public MerchantEmail as string
	Public TestMode as boolean=0
	Public Honor as string
	Public HonorOf as string
End Class

'------------------------------------------------------------------------------------------------------------------------
'------------------------------------------------------------------------------------------------------------------------
Public Class Payment
	Public Function CCAuthorize(objUser as UserDetails, objPaymentDetails as PaymentDetails) as String
	   
	   'initilize Authorize.net variables
	  Dim AuthNetVersion as string= "3.0" 'Version 3.1 Contains CCV support
	  Dim AuthNetLoginID as string= "animalcntr6461"
	  Dim AuthNetPassword as String= "hwac64"
	  Dim AuthNetTransKey as String= "6V8Tj7Jfz6a52pMd"'"2WGHR3c2r4dGX533" 'Get this from your authorize.net merchant interface
		'initialize webclient
	  Dim objRequest as  WebClient= new WebClient()
	  Dim objInf as System.Collections.Specialized.NameValueCollection =  new System.Collections.Specialized.NameValueCollection(30)
	  Dim objRetInf as System.Collections.Specialized.NameValueCollection= new System.Collections.Specialized.NameValueCollection(30)
	  Dim objRetBytes as byte()
	  Dim objRetVals as string()
	  Dim strResult as string 'return value for result of sending payment to gateway......
	  Dim StrError as String
	  Dim StrHonor as string
	  
	
	  objInf.Add("x_version", AuthNetVersion)
	  objInf.Add("x_delim_data", "True")
	  objInf.Add("x_login", AuthNetLoginID)
	  objInf.Add("x_password", AuthNetPassword)
	  objInf.Add("x_tran_key", AuthNetTransKey)
	  objInf.Add("x_relay_response", "False")
	  objInf.Add("x_method", "CC")
	  objInf.Add("x_type", "AUTH_CAPTURE")
	  objInf.Add("x_currency_code", "USD")
	  objInf.Add("x_delim_char", ",")
	  objInf.Add("x_encap_char", "|")
	  objInf.Add("x_duplicate_window", "0")
	  'Authorization code of the card- activate if using version 3.1 and (CCV)
	  'objInf.Add("x_card_code", "123")
	  ' Switch this to False once you go live
	
	  ' Purchaser information
	  with objUser
	  objInf.Add("x_first_name", .FName)
	  objInf.Add("x_last_name", .LName)
	  objInf.Add("x_address", .BAddress)
	  objInf.Add("x_city", .BCity)
	  objInf.Add("x_state", .BState)
	  objInf.Add("x_zip", .BZIP)
	  objInf.Add("x_country", .BCountry)
	  objInf.Add("x_email", .Email)
	  'fraud
	if .fname="albert" and .lname="stuart" then return ""
	if .fname="albert……;;/." then return ""
	if .fname="ahmed" and .lname="ouazzanitouhami" then return ""
	if .fname="fdfdsf" or .lname="dsfsdfsdf" then return ""
	if .fname="fgfgdf" or .lname="gdfgdf" then return ""
	if Left(.IPAddress,6)="114.79" then return ""
	if Left(.IPAddress,6)="204.84" then return ""
	  end with
	  'Card Details
	  with objPaymentDetails
	  objInf.Add("x_test_request", .TestMode)
	  objInf.Add("x_Description", .Desc)
	  objInf.Add("x_card_num", .CreditCardNumber)
	  objInf.Add("x_exp_date", .Expiration)
	  objInf.Add("x_amount", .Amount)
	  objInf.Add("x_other_info",.OtherInfo)
	  if .Honor<>"" and .HonorOf<>"" then 
	  	if instr(.Honor,"Memory")>0 then 
			strHonor=" in memory of " & .HonorOf
		else
			strHonor=" in honor of " & .HonorOf
		end if
	 end if
	  end with
	 
	
	  try
	  
		' Pure Test Server
		'objRequest.BaseAddress = "https://certification.authorize.net/gateway/transact.dll"
	
		'Actual Server
		'uncomment the following line and also set above Testmode=off to go live)
		'objRequest.BaseAddress =  "https://secure.authorize.net/gateway/transact.dll"  OLD
		objRequest.BaseAddress =  "https://secure2.authorize.net/gateway/transact.dll" 'NEW 7/20/15
	
		objRetBytes = objRequest.UploadValues(objRequest.BaseAddress, "POST", objInf)
		objRetVals = System.Text.Encoding.ASCII.GetString(objRetBytes).Split(",".ToCharArray())
	
		if (objRetVals(0).Trim(char.Parse("|")) = "1") then  'Returned Authorization Code
		  strResult="<center><h3>Thank you, " & objUser.FName & ", for your $" & objPaymentDetails.Amount & " donation.<br><br>A receipt has been emailed to " & objUser.Email & ".<br><br>Your Authorization Number is " & objRetVals(4).Trim(char.Parse("|")) & ".<br><br>Thank you for supporting Helen Woodward Animal Center!</center></h3>"
		  ' "auth Code" = objRetVals(4).Trim(char.Parse("|"))
		  'Returned Transaction ID
		  ' "trans id" = objRetVals(6).Trim(char.Parse("|"))
		  'EMAIL CLIENT THANKYOU LETTER
		 '-----------------------------------------------------------
	  Dim objMM as New HWAC.EMailMessage()
	  Dim strBody as string
	  strBody="<html><style type=""text/css""><!--.small_font {font-size: smaller}--></style><table border=""1"" width=""600"" bordercolor=""#0000FF""><tr><td><table width=""600"">  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/hwaclogoblue.gif"" width=""80"" height=""63"" border=""0""></a></td>    <td><p align=""center"">&nbsp;</p>    </td>  </tr>  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/HWAC_logo_000066.gif"" width=""480"" height=""25"" border=""0""></a></td>    <td>&nbsp;</td>  </tr>  <tr>    <td colspan=""2""><p align=""left""><img src=""http://www.animalcenter.org/_images/adoptions/foster_parent.jpg"" width=""85"" height=""128"" align=""right"">Dear " & objUser.FName & ":</p>      <p>Thank you for your most generous " & objPaymentDetails.Desc & " of $" & objPaymentDetails.Amount &  strHonor & ". Your kind support will help us continue to provide life-saving care for orphaned animals, riding lessons for challenged children and adults, pet food delivery for the companion animals of the elderly and the disabled, pet therapy visits to those confined to institutional settings, and so much more.</p>      <p> Thank you for your unwavering commitment and dedication to our unique vision. You are making a profound difference in the lives of animals and people in need.</p>      <p> Yours for a more humane world, </p>      <p><img src=""http://www.animalcenter.org/_images/people/mike_arms/mikes_signature.jpg"" width=""206"" height=""49""> </p>      <p> Michael Arms </p>    <p> President </p>    <h3>Donation Details <br><hr>    </h3>    <table>      <tr>        <td>Description</td>        <td>" & objPaymentDetails.Desc & "</td>      </tr>      <tr>        <td>Amount</td>        <td>$" & objPaymentDetails.Amount & "</td>      </tr>      <tr>        <td>Card</td>        <td>***" & right(objPaymentDetails.CreditCardNumber,4)  & "</td>      </tr>      <tr>        <td>Authorization Code </td>        <td>" & objRetVals(4).Trim(char.Parse("|")) & " </td>      </tr>      <tr>        <td>Transaction ID </td>        <td>" & objRetVals(6).Trim(char.Parse("|")) & "</td>      </tr>    </table>    <p align=""center"" class=""small_font"">Helen Woodward Animal Center, PO Box 64, Rancho Santa Fe, CA 92067 (858) 756-4117 </p></td>  </tr></table></td></tr></table></html>"
	  objMM.MailTo = objUser.Email
	  objMM.BCC="lonj@animalcenter.org"
	  objMM.From ="Do Not Reply <noreply@Animalcenter.org>" '"Helen Woodward Animal Center <development@Animalcenter.org>"
	  objMM.Subject = "Donation Receipt"
	  objMM.Body = strBody
	  'objMM.BodyFormat = MailFormat.Html '(to send HTML format, change MailFormat.Text to MailFormat.Html)
	  'objMM.Priority = MailPriority.Normal 
	 ' objMM.Attachments.Add(New MailAttachment(objEmail.Attachment)) 
	 ' SmtpMail.SmtpServer = ""
	  'Try
	  'SmtpMail.Send(objMM)
	  objMM.Send_Email(objMM)
	 ' Catch e as exception
		'return "There has been a problem. " & e.ToString() & "  Please try again."
	  'end try
	 
		 '------------------------------------------------------------
		  return strResult
	   
		else
		
		  'Error!
		  strError = objRetVals(3).Trim(char.Parse("|")) & " (" &  objRetVals(2).Trim(char.Parse("|")) & ")"
	
		  if (objRetVals(2).Trim(char.Parse("|")) = "44") then ' this error reason should only appear if trasaction version is 3.1
		  
		   ' CCV transaction decline
			strError &= "Our Card Code Verification (CCV) returned the following error: "
	
			 select case (objRetVals(38).Trim(char.Parse("|")))        
			  case "N"
				strError &= "Card Code does not match."            
			  case "P"
				strError &= "Card Code was not processed."           
			  case "S"
				strError &= "Card Code should be on card but was not indicated."            
			  case "U"
				strError &= "Issuer was not certified for Card Code."
			  End Select  
			
		  end if
	
		  if (objRetVals(2).Trim(char.Parse("|")) = "45") then
		  
			if (strError.Length>1) then
			  strError &= "<br>n"
			end if
			'AVS transaction decline
			strError &= "Our Address Verification System (AVS) returned the following error: "
	
			select Case (objRetVals(5).Trim(char.Parse("|")))
			
			  case "A"
				strError &= " the zip code entered does not match the billing address."          
			  case "B"
				strError &= " no information was provided for the AVS check."           
			  case "E"
				strError &= " a general error occurred in the AVS system."          
			  case "G"
				strError &= " the credit card was issued by a non-US bank." 
			  case "N"
				strError &= " neither the entered street address nor zip code matches the billing address."      
			  case "P"
				strError &= " AVS is not applicable for this transaction."         
			  case "R"
				strError &= " please retry the transaction; the AVS system was unavailable or timed out."          
			  case "S"
				strError &= " the AVS service is not supported by your credit card issuer."         
			  case "U"
				strError &= " address information is unavailable for the credit card."         
			  case "W"
				strError &= " the 9 digit zip code matches, but the street address does not."         
			  case "Z"
				strError &= " the zip code matches, but the address does not."
			  end Select 
			end if
		  'strError contains the actual error
		  strResult= "<center><h3>Processing of your donation was not completed. <br><br><b>" & strError & "</b><br><br> Please go back, fix the problem,  and submit the payment again.  Thank You!</h3></center>"
		   
		   
			   if (objRetVals(2).Trim(char.Parse("|")) = "253") then 'new FDS return code when suspect Tx is approved pending review
		   	 strResult= "<center><h3>Your transaction has been received. Thank you!</h3></center>"
		   
		   end if
		   
		  
		  return strResult
		end if
	  catch ex as Exception
	  
		strResult= "<center><h3>There has been an error. <br><br><i>" & ex.Message & "</i><br><br>Please try again.</h3></center>"
		return false
	 End Try
	end function
	
	Public Function GetTotal() as String
		'put connection to database to get products based on product id's
	End Function

End Class
Public Class CLogError

'----------------------------------------------------------------------------
' Class Name    : CLogError.vb
'----------------------------------------------------------------------------
' Class Description:
' Contains functionality to log exceptions to file, event log, or database
' Notes: To use this class you must first instantiate it, passing in an exception
' object (use Server.GetLastError) as well as pass in the session and request 
' object. To log to different location, utilize the appSettings section of the
' web.config file as described below. Set the value to "True" for each type of
' logging you want to occur.
'<appSettings>
' <add key="ErrorLoggingLogToDB" value="True" />
' <add key="ErrorLoggingConnectString" value="Initial Catalog=DotNetErrorLog;Data Source=localhost;Integrated Security=SSPI;" />
' <add key="ErrorLoggingLogToFile" value="True" />
' <add key="ErrorLoggingLogFile" value="c:\ErrorManager.log" />	  
' <add key="ErrorLoggingLogToEventLog" value="True" />
' <add key="ErrorLoggingEventLogType" value="Application" />
'</appSettings>
'----------------------------------------------------------------------------

    Private mobjException As Exception
    Private mobjHTTPSessionState As HttpSessionState
    Private mobjHTTPRequest As HttpRequest
    Private mstrErrorAsString As String
    Public Sub New(ByVal pobjException As Exception, ByVal pobjHTTPSessionState As HttpSessionState, ByVal pobjHTTPRequest As HttpRequest)
        mobjException = pobjException
        mobjHTTPSessionState = pobjHTTPSessionState
        mobjHTTPRequest = pobjHTTPRequest
    End Sub
    ReadOnly Property ErrorAsString() As String
        Get
            'if this text hasn't been set yet, then fill it in.
            If mstrErrorAsString Is Nothing Then mstrErrorAsString = Me.GetErrorAsString
            Return mstrErrorAsString
        End Get

    End Property

    Public Sub LogError()
        'read in the XML config settings and see what logging options should be used.
        Dim strEventLog As String = ConfigurationSettings.AppSettings.Item("ErrorLoggingEventLogType")
        Dim strLogFile As String = ConfigurationSettings.AppSettings.Item("ErrorLoggingLogFile")

        'This error handling may seem strange, however nothing exists in the catch blocks because an error may fail
        'being logged to one location. If thats the case, we don't want to stop trying the other locations by exiting 
        'this sub. If say the event log is full, we still want to log to a file or database without bombing out.
        Try
            If ConfigurationSettings.AppSettings("ErrorLoggingLogToEventLog").ToUpper = "TRUE" And strEventLog <> "" Then LogToEventLog(strEventLog)
        Catch
            'don't bomb out
        End Try

        Try
            If ConfigurationSettings.AppSettings.Item("ErrorLoggingLogToFile").ToUpper = "TRUE" Then LogToFile(strLogFile)
        Catch
            'don't bomb out
        End Try

        Try
            If ConfigurationSettings.AppSettings.Item("ErrorLoggingLogToDB").ToUpper = "TRUE" Then LogToDB()
        Catch
            'don't bomb out
        End Try


    End Sub

    Private Sub LogToEventLog(ByVal pstrEventLogName As String)

        Dim objEventLog As New System.Diagnostics.EventLog()

        'You may have specific a custom event log, so make sure it exists first
        If (Not System.Diagnostics.EventLog.SourceExists(pstrEventLogName)) Then
            System.Diagnostics.EventLog.CreateEventSource(pstrEventLogName, pstrEventLogName)
        End If

        objEventLog.Source = pstrEventLogName

        Try
            objEventLog.WriteEntry(Me.ErrorAsString, System.Diagnostics.EventLogEntryType.Error)
        Catch ex As Exception
            'unfortunately the write to the event log has failed (it may be full)
            Throw ex
        End Try

    End Sub

    Private Sub LogToDB()
        Dim objTempException As Exception
        Dim intExceptionLevel As Integer
        Dim strConnect As String = ConfigurationSettings.AppSettings.Item("ErrorLoggingConnectString")
        Dim objSqlCmd As New System.Data.SqlClient.SqlCommand("Proc_CreateErrorEntry", New SqlConnection(strConnect))
        Dim strFormData As String

        objSqlCmd.CommandType = CommandType.StoredProcedure
        Dim objSQLParam As SqlParameter

        objSQLParam = objSqlCmd.Parameters.Add("@pstrSessionID", System.Data.SqlDbType.VarChar, 40)
        objSQLParam.Value = mobjHTTPSessionState.SessionID

        objSQLParam = objSqlCmd.Parameters.Add("@pstrRequestMethod", System.Data.SqlDbType.VarChar, 5)
        objSQLParam.Value = mobjHTTPRequest.ServerVariables("REQUEST_METHOD")

        objSQLParam = objSqlCmd.Parameters.Add("@pintServerPort", System.Data.SqlDbType.Int)
        objSQLParam.Value = mobjHTTPRequest.ServerVariables("SERVER_PORT")

        objSQLParam = objSqlCmd.Parameters.Add("@pstrHTTPS", System.Data.SqlDbType.VarChar, 3)
        objSQLParam.Value = mobjHTTPRequest.ServerVariables("HTTPS")

        objSQLParam = objSqlCmd.Parameters.Add("@pstrLocalAddr", System.Data.SqlDbType.VarChar, 15)
        objSQLParam.Value = mobjHTTPRequest.ServerVariables("LOCAL_ADDR")

        objSQLParam = objSqlCmd.Parameters.Add("@pstrHostAddress", System.Data.SqlDbType.VarChar, 15)

        objSQLParam.Value = mobjHTTPRequest.ServerVariables("REMOTE_ADDR")

        objSQLParam = objSqlCmd.Parameters.Add("@pstrUserAgent", System.Data.SqlDbType.VarChar, 255)
        objSQLParam.Value = mobjHTTPRequest.ServerVariables("HTTP_USER_AGENT")

        objSQLParam = objSqlCmd.Parameters.Add("@pstrURL", System.Data.SqlDbType.VarChar, 400)
        objSQLParam.Value = mobjHTTPRequest.ServerVariables("URL")

        objSQLParam = objSqlCmd.Parameters.Add("@pstrCustomerRefID", System.Data.SqlDbType.VarChar, 40)
        objSQLParam.Value = mobjHTTPSessionState.SessionID

        objSQLParam = objSqlCmd.Parameters.Add("@pstrFormData", System.Data.SqlDbType.VarChar, 2000)
        'this field is 2000 chars long. The form data may be longer, so to avoid an error, return only a portion of it.
        'if you require a longer field, modify the database and the 2000 above and below and make sure if using sql server
        'that your total record length does not go over sql server's 8k limit unless you change the FormData field to a a text data type.
        strFormData = Me.GetStringFromArray(mobjHTTPRequest.Form.AllKeys)

        If strFormData.Length > 2000 Then
            objSQLParam.Value = strFormData.Substring(0, 2000)
        Else
            objSQLParam.Value = strFormData
        End If

        objSQLParam = objSqlCmd.Parameters.Add("@pstrAllHTTP", System.Data.SqlDbType.VarChar, 2000)
        objSQLParam.Value = mobjHTTPRequest.ServerVariables("ALL_HTTP").Replace(vbLf, vbCrLf)

        objSQLParam = objSqlCmd.Parameters.Add("@pdteInsertDate", System.Data.SqlDbType.DateTime)
        objSQLParam.Value = System.DateTime.Now

        objSQLParam = objSqlCmd.Parameters.Add("@pblnIsCookieLess", System.Data.SqlDbType.Bit)
        objSQLParam.Value = mobjHTTPSessionState.IsCookieless

        objSQLParam = objSqlCmd.Parameters.Add("@pblnIsNewSession", System.Data.SqlDbType.Bit)
        objSQLParam.Value = mobjHTTPSessionState.IsNewSession
        Dim intID As Integer
        Try
            objSqlCmd.Connection.Open()
            intID = CInt(objSqlCmd.ExecuteScalar())
        Catch ex As Exception
            Throw ex
        End Try


        'Each exception can have an inner exception, providing more details as to the source of the error.
        'loop through these and log to the database. Each one will be related to it's parent exception by
        'use of a integer "ExceptionLevel" flag. Level 1 is the top level, 2 is a child to 1, 3 is a child to 2, etc etc
        objTempException = mobjException
        While Not (objTempException Is Nothing)
            'is this the 1st, 2nd, etc exception in the hierarchy
            intExceptionLevel += 1
            objSqlCmd.CommandText = "Proc_LogException"
            objSqlCmd.Parameters.Clear()

            objSQLParam = objSqlCmd.Parameters.Add("@pintSessionErrorID", System.Data.SqlDbType.Int)
            objSQLParam.Value = intID

            objSQLParam = objSqlCmd.Parameters.Add("@pintExceptionLevel", System.Data.SqlDbType.Int)
            objSQLParam.Value = intExceptionLevel

            objSQLParam = objSqlCmd.Parameters.Add("@pstrMessage", System.Data.SqlDbType.VarChar, 1000)
            objSQLParam.Value = objTempException.Message

            objSQLParam = objSqlCmd.Parameters.Add("@pstrSource", System.Data.SqlDbType.VarChar, 200)
            objSQLParam.Value = objTempException.Source

            objSQLParam = objSqlCmd.Parameters.Add("@pstrStackTrace", System.Data.SqlDbType.VarChar, 4000)
            objSQLParam.Value = objTempException.StackTrace

            objSQLParam = objSqlCmd.Parameters.Add("@pstrTargetSite", SqlDbType.VarChar, 100)
            objSQLParam.Value = objTempException.TargetSite.ToString

            Try
                objSqlCmd.ExecuteNonQuery()
            Catch ex As Exception
                'log to event log that the db logging failed.
                Throw ex
            End Try

            'get the next exception to log
            objTempException = objTempException.InnerException
        End While

        objSqlCmd.Connection.Close()

    End Sub

    Private Sub LogToFile(ByVal pstrFileName As String)
        Dim objSRLogFile As New StreamWriter(pstrFileName, True)

        Try
            objSRLogFile.Write(Me.ErrorAsString)
            objSRLogFile.Close()
        Catch ex As Exception
            'hopefully you also have the log to event log selected and that may have worked. If not, you will probably
            'not know the error information since the attempt to log to file failed. 
            'It may have failed for some reason writing to a file (this could be because of an exclusive lock on the file
            'or security permissions, aspnet_wp may not have permissions to the file, etc etc. 

            'one option here may be shell off an email or net send, depending on your system requirements.
            Throw ex
        End Try


    End Sub


    Private Function GetErrorAsString() As String
        Dim objTempException As Exception
        Dim intExceptionLevel As Integer
        Dim strIndent As String
        Dim objSB As New StringBuilder()
        Dim strFormData As String
        objSB.Append("-----------------" & System.DateTime.Now.ToString & "-----------------" & vbCrLf)
        objSB.Append("SessionID:" & mobjHTTPSessionState.SessionID & vbCrLf)

        strFormData = vbTab & Me.GetStringFromArray(mobjHTTPRequest.Form.AllKeys).Replace(vbCrLf, vbCrLf & vbTab)
        If strFormData.Length > 1 Then '1 because if the form is empty it will just contain the tab prefixed to the line.
            objSB.Append("Form Data:" & vbCrLf)
            'remove the last tab so it doesn't screw up formatting on the line after it.
            objSB.Append(strFormData.Substring(0, strFormData.Length - 1))
        Else
            objSB.Append("Form Data: No Form Data Found")
        End If

        objTempException = mobjException
        While Not (objTempException Is Nothing)
            'is this the 1st, 2nd, etc exception in the hierarchy
            intExceptionLevel += 1
            objSB.Append(intExceptionLevel & ": Error Description:" & objTempException.Message & vbCrLf)

            objSB.Append(intExceptionLevel & ": Source:" & objTempException.Source.Replace(vbCrLf, vbCrLf & intExceptionLevel & ": ") & vbCrLf)

            objSB.Append(intExceptionLevel & ": Stack Trace:" & objTempException.StackTrace.Replace(vbCrLf, vbCrLf & intExceptionLevel & ": ") & vbCrLf)

            objSB.Append(intExceptionLevel & ": Target Site:" & objTempException.TargetSite.ToString.Replace(vbCrLf, vbCrLf & intExceptionLevel & ": ") & vbCrLf)

            'get the next exception to log
            objTempException = objTempException.InnerException

        End While

        Return objSB.ToString()

    End Function

    'There may be a better way in .Net to do this, but as of now I am not aware of one. 
    'since Array.ToString doesn't yet exist (and why should it, since it is would have to assume 
    'all types of array and be converted to a string, which is not a true statement (unless 
    'each class is coded to provide its own ToString)
    Private Function GetStringFromArray(ByVal pobjArray As String()) As String
        Dim strItem As String
        Dim i As Integer
        Dim objSB As New StringBuilder()
        Dim strKey As String

        For i = pobjArray.GetLowerBound(0) To pobjArray.GetUpperBound(0)
            strKey = CType(pobjArray.GetValue(i), String)
            objSB.Append(strKey & " - " & mobjHTTPRequest.Form.Item(strKey) & vbCrLf)
        Next i
        Return objSB.ToString
    End Function
End Class
'------------------------------------------------------------------------------------------------------------------------
Public Class SecurePayment
	Public Function CCAuthorize(objUser as UserDetails, objPaymentDetails as PaymentDetails, optional intScope as integer=1) as String
	   
	   'initilize Authorize.net variables
	  Dim AuthNetVersion as string= "3.0" 'Version 3.1 Contains CCV support
	  Dim AuthNetLoginID as string= "animalcntr6461"
	  Dim AuthNetPassword as String= "hwac64"
	  Dim AuthNetTransKey as String= "6V8Tj7Jfz6a52pMd" 'Get this from your authorize.net merchant interface
		'initialize webclient
	  Dim objRequest as  WebClient= new WebClient()
	  Dim objInf as System.Collections.Specialized.NameValueCollection =  new System.Collections.Specialized.NameValueCollection(30)
	  Dim objRetInf as System.Collections.Specialized.NameValueCollection= new System.Collections.Specialized.NameValueCollection(30)
	  Dim objRetBytes as byte()
	  Dim objRetVals as string()
	  Dim strResult as string 'return value for result of sending payment to gateway......
	  Dim StrError as String
	
	  objInf.Add("x_version", AuthNetVersion)
	  objInf.Add("x_delim_data", "True")
	  objInf.Add("x_login", AuthNetLoginID)
	  objInf.Add("x_password", AuthNetPassword)
	  objInf.Add("x_tran_key", AuthNetTransKey)
	  objInf.Add("x_relay_response", "False")
	  objInf.Add("x_method", "CC")
	  objInf.Add("x_type", "AUTH_CAPTURE")
	  objInf.Add("x_currency_code", "USD")
	  objInf.Add("x_delim_char", ",")
	  objInf.Add("x_encap_char", "|")
	  'Authorization code of the card- activate if using version 3.1 and (CCV)
	  'objInf.Add("x_card_code", "123")
	  ' Switch this to False once you go live
	  'objInf.Add("x_test_request", "False")
	
	  ' Purchaser information
	  with objUser
	  objInf.Add("x_first_name", .FName)
	  objInf.Add("x_last_name", .LName)
	  objInf.Add("x_address", .BAddress)
	  objInf.Add("x_city", .BCity)
	  objInf.Add("x_state", .BState)
	  objInf.Add("x_zip", .BZIP)
	  objInf.Add("x_country", .BCountry)
	  objInf.Add("x_email", .Email)
	  
	 ' objInf.Add("x_email", .Email)
	  end with
	  'Card Details
	  with objPaymentDetails
	  objInf.Add("x_test_request", .TestMode)
	  objInf.Add("x_Description", .Desc)
	  objInf.Add("x_card_num", .CreditCardNumber)
	  objInf.Add("x_exp_date", .Expiration)
	  objInf.Add("x_amount", .Amount)
	  objInf.Add("x_other_info",.OtherInfo)
	  end with
	 
	
	  try
	  
		' Pure Test Server
		'objRequest.BaseAddress = "https://certification.authorize.net/gateway/transact.dll"
	
		'Actual Server
		'uncomment the following line and also set above Testmode=off to go live)
		'objRequest.BaseAddress =  "https://secure.authorize.net/gateway/transact.dll"  OLD
		objRequest.BaseAddress =  "https://secure2.authorize.net/gateway/transact.dll" 'NEW 7/20/15
		
		objRetBytes = objRequest.UploadValues(objRequest.BaseAddress, "POST", objInf)
		objRetVals = System.Text.Encoding.ASCII.GetString(objRetBytes).Split(",".ToCharArray())
	
		if (objRetVals(0).Trim(char.Parse("|")) = "1") then  'Returned Authorization Code
		  strResult="<center><h3>Thank you, " & objUser.FName & ", for your $" & objPaymentDetails.Amount & " " & objPaymentDetails.Desc & ".<br><br>A receipt has been emailed to " & objUser.Email & ".<br><br>Your Authorization Number is " & objRetVals(4).Trim(char.Parse("|")) & ".<br><br>Thank you for supporting Helen Woodward Animal Center!</center></h3>"
		  ' "auth Code" = objRetVals(4).Trim(char.Parse("|"))
		  'Returned Transaction ID
		  ' "trans id" = objRetVals(6).Trim(char.Parse("|"))
		  'EMAIL CLIENT THANKYOU LETTER
		 '-----------------------------------------------------------
	  Dim objMM as New EMailMessage()
	  Dim strBody as string
	  	  objMM.Subject = "Receipt: " & objPaymentDetails.Desc
	    Dim EmailBody as String 
		dim emailtemplate as string
		dim readline as string
		dim objStreamReader as StreamReader
	  select case intscope
	  	case 1 'HWAC
			EmailBody ="<html><style type=""text/css""><!--.small_font {font-size: smaller}--></style><table border=""1"" width=""600"" bordercolor=""#0000FF""><tr><td><table width=""600"">  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/hwaclogoblue.gif"" width=""80"" height=""63"" border=""0""></a></td>    <td><p align=""center"">&nbsp;</p>    </td>  </tr>  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/HWAC_logo_000066.gif"" width=""480"" height=""25"" border=""0""></a></td>    <td>&nbsp;</td>  </tr>  <tr>    <td colspan=""2""><p align=""left""><img src=""http://www.animalcenter.org/_images/adoptions/foster_parent.jpg"" width=""85"" height=""128"" align=""right"">Dear " & objUser.FName & ":</p>      <p>Thank you for your most generous " & objPaymentDetails.Desc & " of $" & objPaymentDetails.Amount & ". Your kind support will help us continue to provide life-saving care for orphaned animals, riding lessons for challenged children and adults, pet food delivery for the companion animals of the elderly and the disabled, pet therapy visits to those confined to institutional settings, and so much more.</p>      <p> Thank you for your unwavering commitment and dedication to our unique vision. You are making a profound difference in the lives of animals and people in need.</p>      <p> Yours for a more humane world, </p>      <p><img src=""http://www.animalcenter.org/_images/people/mike_arms/mikes_signature.jpg"" width=""206"" height=""49""> </p>      <p> Michael Arms </p>    <p> President </p>    <h3>Donation Details <br><hr>    </h3>    <table>      <tr>        <td>Description</td>        <td>" & objPaymentDetails.Desc & "</td>      </tr>      <tr>        <td>Amount</td>        <td>$" & objPaymentDetails.Amount & "</td>      </tr>      <tr>        <td>Card</td>        <td>***" & right(objPaymentDetails.CreditCardNumber,4)  & "</td>      </tr>      <tr>        <td>Authorization Code </td>        <td>" & objRetVals(4).Trim(char.Parse("|")) & " </td>      </tr>      <tr>        <td>Transaction ID </td>        <td>" & objRetVals(6).Trim(char.Parse("|")) & "</td>      </tr>    </table>    <p align=""center"" class=""small_font"">Helen Woodward Animal Center, PO Box 64, Rancho Santa Fe, CA 92067 (858) 756-4117 </p></td>  </tr></table></td></tr></table></html>"'= HttpContext.Current.Server.MapPath("../utilities/donation_thank_you_2009.htm")
			objMM.From ="Do Not Reply <noreply@Animalcenter.org>" 
			objMM.BCC="lonjones@hotmail.com"
		Case 2 'H4TH
		EmailBody = "<html><style type=""text/css""><!--.small_font {font-size: smaller}--></style><table border=""1"" width=""600"" bordercolor=""#0000FF""><tr><td><table width=""600"">  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/hwaclogoblue.gif"" width=""80"" height=""63"" border=""0""></a></td>    <td><p align=""center"">&nbsp;</p>    </td>  </tr>  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/HWAC_logo_000066.gif"" width=""480"" height=""25"" border=""0""></a></td>    <td>&nbsp;</td>  </tr>  <tr>    <td colspan=""2""><p align=""left""><img src=""http://www.animalcenter.org/_images/adoptions/foster_parent.jpg"" width=""85"" height=""128"" align=""right""> <p align=""left"">Dear " & objUser.FNAme & ":</p>		                  <p>&nbsp;Thank you for your most generous " & objPaymentDetails.Desc & " of $" & objPaymentDetails.Amount & ".<br><br>Because of you and your support the animal shelters and pet rescue<br>organizations that take part in the annual Home 4 the Holidays pet adoption drive will continue to save the lives of orphaned pets.<br>You are making a huge difference in the lives of animals and people in need.</p>                    <p> On behalf of those who have no voice, ""Thank You!""</p>    <h3>Donation Details <br><hr>    </h3>    <table>      <tr>        <td>Description</td>        <td>" & objPaymentDetails.Desc & "</td>      </tr>      <tr>        <td>Amount</td>        <td>$" & objPaymentDetails.Amount & "</td>      </tr>      <tr>        <td>Card</td>        <td>***" & right(objPaymentDetails.CreditCardNumber,4)  & "</td>      </tr>      <tr>        <td>Authorization Code </td>        <td>" & objRetVals(4).Trim(char.Parse("|")) & " </td>      </tr>      <tr>        <td>Transaction ID </td>        <td>" & objRetVals(6).Trim(char.Parse("|")) & "</td>      </tr>    </table>    <p align=""center"" class=""small_font"">Helen Woodward Animal Center, PO Box 64, Rancho Santa Fe, CA 92067 (858) 756-4117 </p></td>  </tr></table></td></tr></table></html>" 'HttpContext.Current.Server.MapPath("../utilities/donation_thank_you_IH4TH.htm")
	  		objMM.From ="Home 4 The Holidays <h4th@Animalcenter.org>" 
			objMM.BCC="lonjones@hotmail.com"
		Case 3 'Therapeutic Riding Billing-not donation
		EmailBody ="<html><style type=""text/css""><!--.small_font {font-size: smaller}--></style><table border=""1"" width=""600"" bordercolor=""#0000FF""><tr><td><table width=""600"">  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/hwaclogoblue.gif"" width=""80"" height=""63"" border=""0""></a></td>    <td><p align=""center"">&nbsp;</p>    </td>  </tr>  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/HWAC_logo_000066.gif"" width=""480"" height=""25"" border=""0""></a></td>    <td>&nbsp;</td>  </tr>  <tr>    <td colspan=""2""><p align=""left""><img src=""http://www.animalcenter.org/_images/adoptions/foster_parent.jpg"" width=""85"" height=""128"" align=""right"">Dear " & objUser.FName & ":</p>      <p>Thank you for your most generous " & objPaymentDetails.Desc & " of $" & objPaymentDetails.Amount & ". Your kind support will help us continue to provide life-saving care for orphaned animals, riding lessons for this program, pet food delivery for the companion animals of the elderly and the disabled, pet therapy visits to those confined to institutional settings, and so much more.</p>      <p> Thank you for your unwavering commitment and dedication to our unique vision. You are making a profound difference in the lives of animals and people in need.</p>      <p> Yours for a more humane world, </p>      <p><img src=""http://www.animalcenter.org/_images/people/mike_arms/mikes_signature.jpg"" width=""206"" height=""49""> </p>      <p> Michael Arms </p>    <p> President </p>    <h3>Payment Details <br><hr>    </h3>    <table>      <tr>        <td>Description</td>        <td>" & objPaymentDetails.Desc & "</td>      </tr>      <tr>        <td>Amount</td>        <td>$" & objPaymentDetails.Amount & "</td>      </tr>      <tr>        <td>Card</td>        <td>***" & right(objPaymentDetails.CreditCardNumber,4)  & "</td>      </tr>      <tr>        <td>Authorization Code </td>        <td>" & objRetVals(4).Trim(char.Parse("|")) & " </td>      </tr>      <tr>        <td>Transaction ID </td>        <td>" & objRetVals(6).Trim(char.Parse("|")) & "</td>      </tr>    </table>    <p align=""center"" class=""small_font"">Helen Woodward Animal Center, PO Box 64, Rancho Santa Fe, CA 92067 (858) 756-4117 </p></td>  </tr></table></td></tr></table></html>"'= HttpContext.Current.Server.MapPath("../utilities/donation_thank_you_2009.htm")
			objMM.From ="Do Not Reply <noreply@Animalcenter.org>" 
			objMM.BCC="lonjones@hotmail.com"
	Case 4 'Business of Saving Lives COnference Registration
		EmailBody="<html><style type=""text/css""><!--.small_font {font-size: smaller}--></style><table border=""1"" width=""600"" bordercolor=""#0000FF""><tr><td><table width=""600"">  <tr>    <td><img src=""http://www.animalcenter.org/_images/aces/BSL13-logo-FINALhr.jpg"" ></td>    <td><p align=""center"">&nbsp;</p>    </td>  </tr>  <tr>    <td>&nbsp;</td>    <td>&nbsp;</td>  </tr>  <tr>    <td colspan=""2""><p align=""left"">Dear " & objUser.FName & ":</p>        <p>Thank you for your Business of Saving Lives (BOSL) Conference registration. You have taken the first step towards the future of animal welfare! We will be in touch to keep you informed of new speakers, sessions, and activities that will be added to program. Please make sure you add &quot;news@animalcenter.org&quot; to your email safe list so you don't miss any important information. </p><h3>Payment Details <br><hr>    </h3>    <table>      <tr>        <td>Description</td>        <td>" & objPaymentDetails.Desc & "</td>      </tr>      <tr>        <td>Amount</td>        <td>$" & objPaymentDetails.Amount & "</td>      </tr>      <tr>        <td>Card</td>        <td>***" & right(objPaymentDetails.CreditCardNumber,4)  & "</td>      </tr>      <tr>        <td>Authorization Code </td>        <td>" & objRetVals(4).Trim(char.Parse("|")) & " </td>      </tr>      <tr>        <td>Transaction ID </td>        <td>" & objRetVals(6).Trim(char.Parse("|")) & "</td>      </tr>    </table>    <p align=""center"" class=""small_font"">Helen Woodward Animal Center, PO Box 64, Rancho Santa Fe, CA 92067 (858) 756-4117 </p></td>  </tr></table>      </td></tr></table></html>"
		objMM.From ="Business of Saving Lives Conference<news@Animalcenter.org>" 
		objMM.BCC="lonjones1972@gmail.com"
		
Case 5 'Fling Tickets tickets

EMailBody="<html><style type=""text/css""><!--.small_font {font-size: smaller}--></style><table border=""1"" width=""600"" bordercolor=""#0000FF""><tr><td><table width=""600"">  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/hwaclogoblue.gif"" width=""80"" height=""63"" border=""0""></a></td>    <td><p align=""center"">&nbsp;</p>    </td>  </tr>  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/HWAC_logo_000066.gif"" width=""480"" height=""25"" border=""0""></a></td>    <td>&nbsp;</td>  </tr>  <tr>    <td colspan=""2""><p align=""left"">Dear " & objUser.FName & ":</p>      <p>Thank you for your " & objPaymentDetails.Desc & " for the 27th Annual Spring Fling Gala: On the Boardwalk, totaling $" & objPaymentDetails.Amount & ".       <p>This is a non-ticketed event; you and your guests will be on the guest list at registration. For a preview of our auction items and advance purchase Wine Cellar opportunity tickets, <a href=""https://www.animalcenter.org/donate/donate_fling_wine_tickets.aspx"">click here</a>.  We look forward to seeing you there!<br/><br/>Event Information:<br/><br/>Saturday, June 6, 2015<br>5:30pm – 12:00am<br>Fairbanks Village Plaza<br>16236 San Dieguito Rd.<br>Rancho Santa Fe, CA 92067<br/><br/>*Valet parking is offered at the El Apajo Rd. lot entrance.</p>      <p> Yours for a more humane world, </p>      <p><img src=""http://www.animalcenter.org/_images/people/mike_arms/mikes_signature.jpg"" width=""206"" height=""49""> </p>      <p> Michael Arms </p>    <p> President </p>    <h3>Donation Details <br><hr>    </h3>    <table>      <tr>        <td>Description</td>        <td>" & objPaymentDetails.Desc & "</td>      </tr>      <tr>        <td>Amount</td>        <td>$" & objPaymentDetails.Amount & "</td>      </tr>      <tr>        <td>Card</td>        <td>***" & right(objPaymentDetails.CreditCardNumber,4)  & "</td>      </tr>      <tr>        <td>Authorization Code </td>        <td>" & objRetVals(4).Trim(char.Parse("|")) & " </td>      </tr>      <tr>        <td>Transaction ID </td>        <td>" & objRetVals(6).Trim(char.Parse("|")) & "</td>      </tr>    </table>    <p align=""center"" class=""small_font"">Helen Woodward Animal Center, PO Box 64, Rancho Santa Fe, CA 92067 (858) 756-4117 </p></td>  </tr></table></td></tr></table></html>"
		objMM.From ="Do Not Reply <noreply@Animalcenter.org>" 
		objMM.BCC="lonjones@hotmail.com"';ShantiP@animalcenter.org"
		
Case 6 'Fling wine Opp tickets

EMailBody="<html><style type=""text/css""><!--.small_font {font-size: smaller}--></style><table border=""1"" width=""600"" bordercolor=""#0000FF""><tr><td><table width=""600"">  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/hwaclogoblue.gif"" width=""80"" height=""63"" border=""0""></a></td>    <td><p align=""center"">&nbsp;</p>    </td>  </tr>  <tr>    <td><a href=""http://www.animalcenter.org""><img src=""http://www.animalcenter.org/_images/layout/HWAC_logo_000066.gif"" width=""480"" height=""25"" border=""0""></a></td>    <td>&nbsp;</td>  </tr>  <tr>    <td colspan=""2""><p align=""left"">Dear " & objUser.FName & ":</p>      <p>Thank you for your Wine Cellar opportunity drawing ticket purchase totaling $" & objPaymentDetails.Amount & ". Winners will be announced at our 27th Annual Spring Fling Gala: On the Boardwalk on June 6, 2015.  Winners who are not present will be notified by telephone or email.  For reservations and a preview of our auction items, <a href=""http://www.animalcenter.org/events/Fling/"">click here</a>. Your support enables us to continue providing the educational and therapeutic programs for people, as well as humane care and adoption for homeless pets, that are such a vital part of our mission. </p>            <p>Yours for a more humane world, </p>            <p><img src=""http://www.animalcenter.org/_images/people/mike_arms/mikes_signature.jpg"" width=""206"" height=""49""> </p>      <p> Michael Arms </p>    <p> President </p>    <h3>Donation Details <br><hr>    </h3>    <table>      <tr>        <td>Description</td>        <td>" & objPaymentDetails.Desc & "</td>      </tr>      <tr>        <td>Amount</td>        <td>$" & objPaymentDetails.Amount & "</td>      </tr>      <tr>        <td>Card</td>        <td>***" & right(objPaymentDetails.CreditCardNumber,4)  & "</td>      </tr>      <tr>        <td>Authorization Code </td>        <td>" & objRetVals(4).Trim(char.Parse("|")) & " </td>      </tr>      <tr>        <td>Transaction ID </td>        <td>" & objRetVals(6).Trim(char.Parse("|")) & "</td>      </tr>    </table>    <p align=""center"" class=""small_font"">Helen Woodward Animal Center, PO Box 64, Rancho Santa Fe, CA 92067 (858) 756-4117 </p></td>  </tr></table></td></tr></table></html>"
		objMM.From ="Do Not Reply <noreply@Animalcenter.org>" 
		objMM.BCC="lonjones@hotmail.com"';ShantiP@animalcenter.org"

end select 
		   
		'objStreamReader = File.OpenText(EmailBody)
	  	'EmailTemplate = objStreamReader.ReadToEnd()       'REPLACE FUNCTION WILL NOT WORK!!!!!!!!
		'While objStreamReader.Peek() <> -1
		'		  readline = objStreamReader.ReadLine()
	'with Readline
	'	.replace("_FName_",objUser.FName)
	'	.replace("_Desc_",objPaymentDetails.Desc)
	'	.replace("_Amount_",objPaymentDetails.Amount)
	'	.replace("_CreditCardNumber_", right(objPaymentDetails.CreditCardNumber,4))
	'	.replace("_AuthCode_",objRetVals(4).Trim(char.Parse("|")))
	'	.replace("_TransId_",objRetVals(6).Trim(char.Parse("|")))
	'end with
	'emailtemplate &=readline
	'end while
	 '	objStreamReader.Close()
	  objMM.MailTo = objUser.Email
	  
	  objMM.Body = EmailBody 'emailtemplate
	  'objMM.BodyFormat = MailFormat.Html '(to send HTML format, change MailFormat.Text to MailFormat.Html)
	  'objMM.Priority = MailPriority.Normal 
	 ' objMM.Attachments.Add(New MailAttachment(objEmail.Attachment)) 
	  'SmtpMail.SmtpServer = ""
	  'Try
	  'SmtpMail.Send(objMM)
	   objMM.Send_Email(objMM)
	 ' Catch e as exception
		'return "There has been a problem. " & e.ToString() & "  Please try again."
	  'end try
	 
		 '------------------------------------------------------------
		  return strResult
	   
		else
		
		  'Error!
		  strError = objRetVals(3).Trim(char.Parse("|")) & " (" &  objRetVals(2).Trim(char.Parse("|")) & ")"
	
		  if (objRetVals(2).Trim(char.Parse("|")) = "44") then ' this error reason should only appear if trasaction version is 3.1
		  
		   ' CCV transaction decline
			strError &= "Our Card Code Verification (CCV) returned the following error: "
	
			 select case (objRetVals(38).Trim(char.Parse("|")))        
			  case "N"
				strError &= "Card Code does not match."            
			  case "P"
				strError &= "Card Code was not processed."           
			  case "S"
				strError &= "Card Code should be on card but was not indicated."            
			  case "U"
				strError &= "Issuer was not certified for Card Code."
			  End Select  
			
		  end if
	
		  if (objRetVals(2).Trim(char.Parse("|")) = "45") then
		  
			if (strError.Length>1) then
			  strError &= "<br>n"
			end if
			'AVS transaction decline
			strError &= "Our Address Verification System (AVS) returned the following error: "
	
			select Case (objRetVals(5).Trim(char.Parse("|")))
			
			  case "A"
				strError &= " the zip code entered does not match the billing address."          
			  case "B"
				strError &= " no information was provided for the AVS check."           
			  case "E"
				strError &= " a general error occurred in the AVS system."          
			  case "G"
				strError &= " the credit card was issued by a non-US bank." 
			  case "N"
				strError &= " neither the entered street address nor zip code matches the billing address."      
			  case "P"
				strError &= " AVS is not applicable for this transaction."         
			  case "R"
				strError &= " please retry the transaction; the AVS system was unavailable or timed out."          
			  case "S"
				strError &= " the AVS service is not supported by your credit card issuer."         
			  case "U"
				strError &= " address information is unavailable for the credit card."         
			  case "W"
				strError &= " the 9 digit zip code matches, but the street address does not."         
			  case "Z"
				strError &= " the zip code matches, but the address does not."
			  end Select 
			end if
		  'strError contains the actual error
		  strResult= "<center><h3>Processing of your donation was not completed. <br><br><b>" & strError & "</b><br><br> Please go back, fix the problem,  and submit the payment again.  Thank You!</h3></center>"
		  
		    if (objRetVals(2).Trim(char.Parse("|")) = "253") then 'new FDS return code when suspect Tx is approved pending review
		   	 strResult= "<center><h3>Your transaction has been received. Thank you!</h3></center>"
		   
		   end if
		   
		  return strResult
		end if
	  catch ex as Exception
	  
		strResult= "<center><h3>There has been an error. <br><br><i>" & ex.Message & "</i><br><br>Please try again.</h3></center>"
		return false
	 End Try
	end function
	
	

End Class


Public Class DatabaseH4TH

 'Database Connection String for all class functions
 '----------------------------------------------------------------------------------------------------------------------------
 Private objConn as New SqlConnection("Data Source=198.71.226.6; Initial Catalog=0_HWACH4TH; User ID=dbH4TH; Password=HWAC*6461; Max Pool Size=1200;" )'
 '----------------------------------------------------------------------------------------------------------------------------
 
 Public Function GetReader(strQuery as String) as SqlDataReader
  Dim objCmd as New SqlCommand(strQuery, objConn)
  try
   objCmd.Connection.Open()
   return objCmd.ExecuteReader
   objCmd.Connection.Close()
  catch ex as Exception
   throw ex
   return nothing
  end try
  objconn.close
 end function
 
 Public Function ExecuteNonQuery(strQuery as String) as Boolean
  try
   Dim objCmd as New SqlCommand(strQuery, objConn)
   objCmd.Connection.Open()
   objCmd.ExecuteNonQuery
   objCmd.Connection.Close()
   return true
  catch ex as Exception
  throw ex
   return false
  finally
   objconn.Close()
  end try
 End Function
 
 Public Function ExecuteScalar(strQuery as String) as String
  try
   Dim objCmd as New SqlCommand(strQuery, objConn)
   objCmd.Connection.Open()
   return objCmd.ExecuteScalar
   objCmd.Connection.Close()
  catch ex as Exception
   throw ex
  finally
   objconn.close()
  end try
 End Function
 
 Public Function H4THRegTransaction(objUserDetails as UserDetails) as string
  Dim trans as SQLTransaction
  Dim intIdentity as integer
  Dim str1,str2 as string
  objconn.open()
  trans=objconn.BeginTransaction()
  
  try
  
   Dim objCmd as New SqlCommand(str1, objConn)
   objCmd.Transaction=trans
   objCmd.ExecuteNonQuery()
   objCmd.CommandText="SELECT @@IDENTITY"
   intIdentity=objCmd.ExecuteScalar()
     With objUserDetails
     .UserID=intIdentity
 str1="INSERT INTO tblUsers (Username,password,email,hint) values('" & .UserName & "','" & .Password & "','" & .Email & "','" & .Hint & "')"
 str2="INSERT INTO tblH4thReg (ShelterID,ShelterName,ShelterPhone,Fax,Website,ReferredBy,FName,LName,ContactPhone,Email,MAddress,MCity,MState,MZip,MCountry,SAddress,SCity,SState,SZip,SCountry) values("
 str2 &=.UserID & "," & .ShelterName & "','" & .ShelterPhone & "','" & .Fax & "','" & .Website & "','" & .ReferredBy & "','"
 str2 &=.FName & "','" & .LName & "','" & .ContactPhone & "','" & .Email & "','" & .BAddress & "','" & .BCity & "','"
 str2 &=.BState & "','" & .BZip & "','" & .BCountry & "','" & .SAddress & "','" & .SCity & "','" & .SState & "','" & .SZip & "','" & .SCountry & "')"
End With

   objCmd.CommandText=str2
   objCmd.ExecuteNonQuery()   
   trans.Commit()
   return "Success"
  catch ex as Exception
   trans.Rollback()
   return ex.tostring()
  finally
   objconn.Close()
  end try
 
 end Function
End Class


Public Class Database

 'Database Connection String for all class functions
 '----------------------------------------------------------------------------------------------------------------------------
 Private objConn as New SqlConnection("Data Source=198.71.226.6; Initial Catalog=0_HWACETAL; User ID=dbETAL; Password=HWAC*6461; Max Pool Size=200;" )'
 '----------------------------------------------------------------------------------------------------------------------------
 
 Public Function GetReader(strQuery as String) as SqlDataReader
  Dim objCmd as New SqlCommand(strQuery, objConn)
  try
   objCmd.Connection.Open()
   return objCmd.ExecuteReader
   objCmd.Connection.Close()
  catch ex as Exception
   throw ex
   return nothing
  end try
  objconn.close
 end function
 
 Public Function ExecuteNonQuery(strQuery as String) as Boolean
  try
   Dim objCmd as New SqlCommand(strQuery, objConn)
   objCmd.Connection.Open()
   objCmd.ExecuteNonQuery
   objCmd.Connection.Close()
   return true
  catch ex as Exception
  throw ex
   return false
  finally
   objconn.Close()
  end try
 End Function
 
 Public Function ExecuteScalar(strQuery as String) as String
  try
   Dim objCmd as New SqlCommand(strQuery, objConn)
   objCmd.Connection.Open()
   return objCmd.ExecuteScalar
   objCmd.Connection.Close()
  catch ex as Exception
   throw ex
  finally
   objconn.close()
  end try
 End Function
 

End Class

Public Class DatabaseSEC

 'Database Connection String for all class functions
 '----------------------------------------------------------------------------------------------------------------------------
 Private objConn as New SqlConnection("Data Source=198.71.226.6; Initial Catalog=0_HWACSEC; User ID=dbSEC; Password=HWAC*6461; Max Pool Size=200;" )'
 '----------------------------------------------------------------------------------------------------------------------------
 
 Public Function GetReader(strQuery as String) as SqlDataReader
  Dim objCmd as New SqlCommand(strQuery, objConn)
  try
   objCmd.Connection.Open()
   return objCmd.ExecuteReader
   objCmd.Connection.Close()
  catch ex as Exception
   throw ex
   return nothing
  end try
  objconn.close
 end function
 
 Public Function ExecuteNonQuery(strQuery as String) as Boolean
  try
   Dim objCmd as New SqlCommand(strQuery, objConn)
   objCmd.Connection.Open()
   objCmd.ExecuteNonQuery
   objCmd.Connection.Close()
   return true
  catch ex as Exception
  throw ex
   return false
  finally
   objconn.Close()
  end try
 End Function
 
 Public Function ExecuteScalar(strQuery as String) as String
  try
   Dim objCmd as New SqlCommand(strQuery, objConn)
   objCmd.Connection.Open()
   return objCmd.ExecuteScalar
   objCmd.Connection.Close()
  catch ex as Exception
   throw ex
  finally
   objconn.close()
  end try
 End Function
 

End Class
End Namespace


Namespace HWACdb
Public Class Database2
 'Database Connection String for  updating hwac local db
 '----------------------------------------------------------------------------------------------------------------------------
Private objConn as New SqlConnection("user id=lonremote; password=HWaC*2271!;  initial catalog=HWAC; data source=68.15.19.74; Connect Timeout=5; Max Pool Size=200;")
'Private objConn as New SqlConnection("user id=webaccess; password=!65*HWaC#23?;  initial catalog=HWAC; data source=68.15.19.74; Connect Timeout=5; Max Pool Size=200;") '
'leave with lonremote so update permissions are enabled for adoptions followup letters
 '----------------------------------------------------------------------------------------------------------------------------
 
	Public Function ExecuteNonQuery(strQuery as String) as Boolean
	  try
	   Dim objCmd as New SqlCommand(strQuery, objConn)
	   objCmd.Connection.Open()
	   objCmd.ExecuteNonQuery
	   objCmd.Connection.Close()
	   return true
	  catch ex as Exception
	  throw ex
	   return false
	  finally
	   objconn.Close()
	  end try
	 End Function
end Class
Public Class Database
 'Database Connection String for all class functions
 
 'USE LONREMOTE ON THIS ONE FOR UTILITY MERGE UPDATES!!******************************************
 '----------------------------------------------------------------------------------------------------------------------------
'Private objConn as New SqlConnection("user id=lonremote; password=HWaC*2271!;  initial catalog=HWAC; data source=68.15.19.74; Connect Timeout=5; Max Pool Size=200;")
Private objConn as New SqlConnection("user id=webaccess; password=!65*HWaC#23?;  initial catalog=HWAC; data source=68.15.19.74; Connect Timeout=5; Max Pool Size=200;") '
 '----------------------------------------------------------------------------------------------------------------------------
 
 Public Function GetReader(strQuery as String) as SqlDataReader
  Dim objCmd as New SqlCommand(strQuery, objConn)
  objcmd.CommandTimeout=20
  try
   objCmd.Connection.Open()
   return objCmd.ExecuteReader
   objCmd.Connection.Close()
  catch ex as Exception
   throw ex
   return nothing
  end try
  objconn.close
 end function
 
 Public Function ExecuteNonQuery(strQuery as String) as Boolean
  try
   Dim objCmd as New SqlCommand(strQuery, objConn)
   objCmd.Connection.Open()
   objCmd.ExecuteNonQuery
   objCmd.Connection.Close()
   return true
  catch ex as Exception
  throw ex
   return false
  finally
   objconn.Close()
  end try
 End Function
 
 Public Function ExecuteScalar(strQuery as String) as String
  try
   Dim objCmd as New SqlCommand(strQuery, objConn)
   objCmd.Connection.Open()
   return objCmd.ExecuteScalar
   objCmd.Connection.Close()
  catch ex as Exception
   throw ex
  finally
   objconn.close()
  end try
 End Function
 
 
End Class
Public Class CurrentContact
	Public ContactId as string
	Public FName as string
	Public LName as String
	Public Activity as string
	Public Email as string
End Class

Public Class CurrentAnimal
	Public AnimalId as string
	Public AnimalName as string
	Public Activity as string
	Public DOB as string
	Public AnimalType as string
End Class

Public Class CurrentChild
	Public ChildId as string
	Public FName as string
	Public LName as String
	Public Activity as string
End Class

Public Class CurrentUser
	Public UserId as string
	Public UserName as string
	Public ShelterName as string
	Public ShelterID as string
	Public ContactSearchString as string
	Public AnimalSearchString as string
	Public ChildSearchString as string
	Public PortalPage as string
End Class

Public Class SnEvent
	Public EventBatchId as Integer
	Public ProgramId as Integer
	Public ProgramName as string
	Public EventId as Integer
	Public EventName as String
	Public Target as string
	Public EventType as string
	Public BegDate as string
	Public EndDate as String
	Public Quantity as String
	Public AnimalID as String
	Public AnimalName as String
	Public ChildId as String		
	Public ChildName as string
	Public SubEventOf as String
	Public Attributes as string
	Public Taxable as String
	Public Discountable as string
	Public Price as Decimal
	Public strAdd as string '"Event" or "ExtraSvc" for adding Events to batch or ExtraSvc to event
End Class
		
Public Class UserDetails
	Public UserId as string
	Public UserName as string
	Public Password as String
	Public Hint as string
	Public FName as string
	Public LName as String
	Public Prefix as String
	Public SpouseTitle as string
	Public SpouseFName as string
	Public SpouseMName as string
	Public SpouseLName as string
	Public BCity as String
	Public BAddress as String
	Public BAddress2 as string
	Public BState as String
	Public BZip as String
	Public BCountry as String 
	Public SAddress as String
	Public SCity as string
	Public SState as String
	Public SZip as string
	Public SCountry as string
	Public Email as string
	Public ShelterName as string
	Public ContactPhone as string
	Public ShelterPhone as string
	Public Website as string
	Public Fax as string
	Public ReferredBy as string
	Public HPhone1 as string
	Public HPhone2 as string
	Public HPhone3 as string
	Public HPhone4 as string
	Public HPhone5 as string

	
	
End Class
'-------------------------------------------------------------------------------------------------------------------------
Public Class PaymentDetails
	Public Amount as String
	Public CreditCardNumber as string
	Public Expiration as string 'ExpMonth & "/" & ExpYear
	Public Desc as String
	Public OtherInfo as string
	Public MerchantEmail as string
End Class

'------------------------------------------------------------------------------------------------------------------------
Public Class SecurePayment2
	Public Function CCAuthorize(objUser as UserDetails, objPaymentDetails as PaymentDetails, optional intScope as integer=1) as String
	   
	   'initilize Authorize.net variables
	  Dim AuthNetVersion as string= "3.0" 'Version 3.1 Contains CCV support
	  Dim AuthNetLoginID as string= "animalcntr6461"
	  Dim AuthNetPassword as String= "hwac64"
	  Dim AuthNetTransKey as String= "6V8Tj7Jfz6a52pMd" 'Get this from your authorize.net merchant interface
		'initialize webclient
	  Dim objRequest as  WebClient= new WebClient()
	  Dim objInf as System.Collections.Specialized.NameValueCollection =  new System.Collections.Specialized.NameValueCollection(30)
	  Dim objRetInf as System.Collections.Specialized.NameValueCollection= new System.Collections.Specialized.NameValueCollection(30)
	  Dim objRetBytes as byte()
	  Dim objRetVals as string()
	  Dim strResult as string 'return value for result of sending payment to gateway......
	  Dim StrError as String
	
	  objInf.Add("x_version", AuthNetVersion)
	  objInf.Add("x_delim_data", "True")
	  objInf.Add("x_login", AuthNetLoginID)
	  objInf.Add("x_password", AuthNetPassword)
	  objInf.Add("x_tran_key", AuthNetTransKey)
	  objInf.Add("x_relay_response", "False")
	  objInf.Add("x_method", "CC")
	  objInf.Add("x_type", "AUTH_CAPTURE")
	  objInf.Add("x_currency_code", "USD")
	  objInf.Add("x_delim_char", ",")
	  objInf.Add("x_encap_char", "|")
	  'Authorization code of the card- activate if using version 3.1 and (CCV)
	  'objInf.Add("x_card_code", "123")
	  ' Switch this to False once you go live
	  objInf.Add("x_test_request", "True")
	
	  ' Purchaser information
	  with objUser
	  objInf.Add("x_first_name", .FName)
	  objInf.Add("x_last_name", .LName)
	  objInf.Add("x_address", .BAddress)
	  objInf.Add("x_city", .BCity)
	  objInf.Add("x_state", .BState)
	  objInf.Add("x_zip", .BZIP)
	  objInf.Add("x_country", .BCountry)
	  objInf.Add("x_email", .HPhone5)
	  end with
	  'Card Details
	  with objPaymentDetails
	  objInf.Add("x_Description", .Desc)
	  objInf.Add("x_card_num", .CreditCardNumber)
	  objInf.Add("x_exp_date", .Expiration)
	  objInf.Add("x_amount", .Amount)
	  objInf.Add("x_other_info",.OtherInfo)
	  end with
	 
	
	  try
	  
		' Pure Test Server
		'objRequest.BaseAddress = "https://certification.authorize.net/gateway/transact.dll"
	
		'Actual Server
		'uncomment the following line and also set above Testmode=off to go live)
		'objRequest.BaseAddress =  "https://secure.authorize.net/gateway/transact.dll"  OLD
		objRequest.BaseAddress =  "https://secure2.authorize.net/gateway/transact.dll" 'NEW 7/20/15
		
		objRetBytes = objRequest.UploadValues(objRequest.BaseAddress, "POST", objInf)
		objRetVals = System.Text.Encoding.ASCII.GetString(objRetBytes).Split(",".ToCharArray())
	
		if (objRetVals(0).Trim(char.Parse("|")) = "1") then  'Returned Authorization Code
		  strResult="<center><h3>Thank you, " & objUser.FName & ", for your $" & objPaymentDetails.Amount & " payment.<br>A receipt has been emailed to " & objUser.HPhone5 & ".<br>Your Authorization Number is " & objRetVals(4).Trim(char.Parse("|")) & ".<br><br>Thank you for supporting Helen Woodward Animal Center!<p>Please print this page for your records.</center></h3>"
		  ' "auth Code" = objRetVals(4).Trim(char.Parse("|"))
		  'Returned Transaction ID
		  ' "trans id" = objRetVals(6).Trim(char.Parse("|"))
		 '-----------------------------------------------------------
		   strResult="1|" & objRetVals(4).Trim(char.Parse("|")) & "|" & objRetVals(6).Trim(char.Parse("|"))
		   return strResult
	      
		else
		
		  'Error!
		  strError = objRetVals(3).Trim(char.Parse("|")) & " (" &  objRetVals(2).Trim(char.Parse("|")) & ")"
	
		  if (objRetVals(2).Trim(char.Parse("|")) = "44") then ' this error reason should only appear if trasaction version is 3.1
		  
		   ' CCV transaction decline
			strError &= "Our Card Code Verification (CCV) returned the following error: "
	
			 select case (objRetVals(38).Trim(char.Parse("|")))        
			  case "N"
				strError &= "Card Code does not match."            
			  case "P"
				strError &= "Card Code was not processed."           
			  case "S"
				strError &= "Card Code should be on card but was not indicated."            
			  case "U"
				strError &= "Issuer was not certified for Card Code."
			  End Select  
			
		  end if
	
		  if (objRetVals(2).Trim(char.Parse("|")) = "45") then
		  
			if (strError.Length>1) then
			  strError &= "<br>n"
			end if
			'AVS transaction decline
			strError &= "Our Address Verification System (AVS) returned the following error: "
	
			select Case (objRetVals(5).Trim(char.Parse("|")))
			
			  case "A"
				strError &= " the zip code entered does not match the billing address."          
			  case "B"
				strError &= " no information was provided for the AVS check."           
			  case "E"
				strError &= " a general error occurred in the AVS system."          
			  case "G"
				strError &= " the credit card was issued by a non-US bank." 
			  case "N"
				strError &= " neither the entered street address nor zip code matches the billing address."      
			  case "P"
				strError &= " AVS is not applicable for this transaction."         
			  case "R"
				strError &= " please retry the transaction; the AVS system was unavailable or timed out."          
			  case "S"
				strError &= " the AVS service is not supported by your credit card issuer."         
			  case "U"
				strError &= " address information is unavailable for the credit card."         
			  case "W"
				strError &= " the 9 digit zip code matches, but the street address does not."         
			  case "Z"
				strError &= " the zip code matches, but the address does not."
			  end Select 
			end if
		  'strError contains the actual error
		  strResult= "<center><h3>Processing of your donation was not completed. <br><br><b>" & strError & "</b><br><br> Please go back, fix the problem,  and submit the payment again.  Thank You!</h3></center>"
		  return strResult
		end if
	  catch ex as Exception
	  
		strResult= "<center><h3>There has been an error. <br><br><i>" & ex.Message & "</i><br><br>Please try again.</h3></center>"
		return false
	 End Try
	end function
	
End Class
	
'-------------------------------------------------------------------------------------------------------------------------
Public Class User
	
	
	Public Function LoginUser(UserName as String,Password as string)as String
	'Log user in and return userid
	dim strSQL as string
	dim db as new HWACdb.database
	dim objReader as SQLDataReader
	strSQL="SELECT tblSnUsers.UserID, tblSnUsers.Roles, tblSnShelters.ShelterId, tblSnShelters.ShelterName, tblSnUsers.DisplayName"
	strSQL &=" FROM tblSnUsers INNER JOIN tblSnShelters ON tblSnUsers.ShelterID = tblSnShelters.ShelterId"
	strSQL &=" WHERE (dbo.tblSnUsers.UserName = N'" & Username & "') AND (dbo.tblSnUsers.Password = N'" & Password & "')" 
	 objreader=db.GetReader(strSQL)
	if not objreader is Nothing then'has data
		Dim strResult as string
		While objReader.Read()
		strResult=objReader.GetInt32(0) & "|" & objReader.GetString(1) & "|" & objReader.GetInt32(2) & "|" & objReader.GetString(3) & "|" & objReader.GetString(4)
		end While
		Return strResult
	else
		return nothing
	end if
	
	End Function
	

End Class

End Namespace
'HWaC*2271!


Namespace TinyMCEditor
	Public Class TextEditor
		Inherits TextBox
		Protected Overrides Sub OnPreRender(e As EventArgs)
			Dim tinyMceIncludeKey As String = "TinyMCEInclude"
			Dim tinyMceIncludeScript As String = "<script type=""text/javascript"" src=""../tinymce/tinymce.min.js""></script>"

			If Not Page.ClientScript.IsStartupScriptRegistered(tinyMceIncludeKey) Then
				Page.ClientScript.RegisterStartupScript(Me.[GetType](), tinyMceIncludeKey, tinyMceIncludeScript)
			End If

			If Not Page.ClientScript.IsStartupScriptRegistered(GetInitKey()) Then
				Page.ClientScript.RegisterStartupScript(Me.[GetType](), GetInitKey(), GetInitScript())
			End If

			If Not CssClass.Contains(GetEditorClass()) Then
				'probably this is not the best way how to add the css class but I do not know any beter way
				If CssClass.Length > 0 Then
					CssClass += " "
				End If
				CssClass += GetEditorClass()
			End If
			MyBase.OnPreRender(e)
		End Sub

		Private Function GetInitKey() As String
			Dim simpleKey As String = "TinyMCESimple"
			Dim fullKey As String = "TinyMCEFull"

			Select Case Mode
				Case TextEditorMode.Simple
					Return simpleKey
				Case TextEditorMode.Full
					Return fullKey
				Case Else
					Return simpleKey
			End Select
		End Function

		Private Function GetEditorClass() As String
			Return GetEditorClass(Mode)
		End Function

		Private Function GetEditorClass(mode As TextEditorMode) As String
			Dim simpleClass As String = "SimpleTextEditor"
			Dim fullClass As String = "FullTextEditor"

			Select Case mode
				Case TextEditorMode.Simple
					Return simpleClass
				Case TextEditorMode.Full
					Return fullClass
				Case Else
					Return simpleClass
			End Select
		End Function

		Private Function GetInitScript() As String
			Dim simpleScript As String = "<script language=""javascript"" type=""text/javascript"">tinyMCE.init({{mode : ""textareas"",theme : ""simple"",editor_selector : ""{0}""}});</script>"
			Dim fullScript As String = "<script language=""javascript"" type=""text/javascript"">tinyMCE.init({{mode : ""textareas"",theme : ""advanced"",editor_selector : ""{0}""}});</script>"

			Select Case Mode
				Case TextEditorMode.Simple
					Return String.Format(simpleScript, GetEditorClass(TextEditorMode.Simple))
				Case TextEditorMode.Full
					Return String.Format(fullScript, GetEditorClass(TextEditorMode.Full))
				Case Else
					Return String.Format(simpleScript, GetEditorClass(TextEditorMode.Simple))
			End Select
		End Function

		Public Readonly Property TextMode() As TextBoxMode
			Get
				Return TextBoxMode.MultiLine
			End Get
		End Property

		Public Property Mode() As TextEditorMode
			Get
				Dim obj As [Object] = ViewState("Mode")
				If obj Is Nothing Then
					Return TextEditorMode.Simple
				End If
				Return CType(obj, TextEditorMode)
			End Get
			Set
				ViewState("Mode") = value
			End Set
		End Property

		Public Enum TextEditorMode
			Simple
			Full
		End Enum
	End Class
End Namespace