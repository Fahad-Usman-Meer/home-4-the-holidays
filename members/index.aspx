<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Member Home Page- Home 4 The Holidays" debug="true" %>

<script runat="server">
sub Page_load(obj as object, e as EventArgs)
	if not page.ispostback then
	if session("UserId")="" then response.Redirect("../login.aspx?ReturnURL=../home4theholidays/members/index.aspx")

	'check for management updates
	'------------------------------------------------------
		'Dim p as IPrincipal = HttpContext.Current.User
			'if p.IsInRole("Admin") then
			if session("Admin")="@F@EWE$" then

				if request.QueryString("ShelterName")<>"" then
					Session("ShelterName")=request.QueryString("ShelterName")
					Session("UserId")=request.QueryString("SID")
				end if
			end if
	'------------------------------------------------------
		'Check if this is the first time to this page-querystring from registration page= FirstTime=true
		if request.QueryString("FirstTime")="true" then 'came from registration
			lblmessage.text="<p>Welcome to the Home 4 The Holidays pet adoption program!  <br><br><h4>ATTENTION! YOU MUST CLICK THE VERIFICATION LINK IN THE EMAIL SENT TO YOU BEFORE YOUR PROFILE WILL BE PUBLIC.</p><p>This email also contains your Username and Password. Please keep it handy so you can log in and record your adoptions during the event as well as having access to many free services that this program offers!<br><br>Congratulations, you are well on your way to saving many lives this holiday season!</h4> </P>"
		else'return visitor
				lblmessage.text="<h2>" & session("ShelterName") & " Homepage</h2><br>Welcome to your organization's personal homepage. Don't forget to record your weekly adoptions right here during the campaign by clicking the ""<a href=""adoptions.aspx"">Record Adoptions</a>"" link.<br />"
		End if
	end IF
End Sub




</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <link rel="stylesheet" href="../_css/thickbox.css" type="text/css" media="screen" />
<link href="../_css/style2.css" rel="stylesheet" type="text/css" />

</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >
Home 4 The Holidays Members
</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">16 million pets have gone "Home 4 the Holidays" since 1999!<br></h1><div class="feature">
                                                            <p>
    <asp:Label ID="lblmessage" runat="server" /></p>
    <p>You are joining over 4,200 shelters and rescue organizations, in  over 24 countries, working to secure forever homes for orphan pets. Please  check the list of participants. If you notice that other groups in your area  are NOT enrolled, please <a href="../invite.aspx">invite</a> them to join us. It's never too late to enroll! All they  need is a desire to increase adoptions, help lower euthanasia rates, and take  business away from puppy mills and backyard breeders during their most  profitable time of year.</p>
  
    <p><strong><em>Why is this campaign successful?</em></strong> <br>
      Because of you! Concentrate on quality adoptions and we'll reach  our Home 4 the Holidays goal&nbsp;<em>one adoption at a time.</em> We&rsquo;re working  together to find families for orphan pets during the time of year when they are  most likely to get new pets. <br>
    Thank you for being a part of Blue Buffalo® Home 4 the Holidays  ®... the most successful pet adoption drive in history!</p>
</div>
</asp:content>
