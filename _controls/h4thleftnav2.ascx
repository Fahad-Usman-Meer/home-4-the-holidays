<%@ Control Language="VB"  %>

<script runat="server">
Sub Page_load(obj as object, e as eventargs)
Response.Cache.SetCacheability(HttpCacheability.NoCache)
If session("UserID")<>"" Then
	' Dim p as IPrincipal = HttpContext.Current.User
	'if p.IsInRole("h4th") or p.IsInRole("Admin") then
		lnkAdoptions.Visible=True
		lnkProfile.Visible=True
		lnkAccount.Visible=true
		lnkLogout.Visible=true
		lnkSignup.Visible=False
		'lnkDescription.Visible=true
		lnkVan.visible=true	
	'end if
End if
end sub
</script>
<div id="sectionLinks">
		  <ul> 
			  <asp:Label ID="lnkSignup" runat="server"  Text="<li><a href=http://join.home4theholidays.org/register.aspx>Sign Up</a></li>"/>
			   <li><a href="http://join.home4theholidays.org/shelter_map.aspx">Participating Shelters</a></li>
			   <!--<li><a href="http://join.home4theholidays.org/luminaries.aspx">Celebrity Angels</a></li>-->
		       <li><a href="http://join.home4theholidays.org/downloads.aspx">Downloads</a></li>
               <li><a href="http://join.home4theholidays.org/social_media_contest.aspx">#IChoseToRescue Contest</a></li>
	 	     <img src="http://join.home4theholidays.org/_images/orange_gradient.gif" width="113" height="2">    
			  <li><a href="http://join.home4theholidays.org/members">Member Homepage</a></li> 
			  <asp:Label ID="lnkAdoptions" runat="server"  Visible="false" Text="<li><a href=http://join.home4theholidays.org/members/adoptions.aspx>Record Adoptions</a></li>"/>
			   <asp:Label ID="lnkVan" runat="server"  Visible="false" Text="<li><a href=http://join.home4theholidays.org/members/win.aspx>Win $25,000!</a></li>"/>
			  <asp:Label ID="lnkProfile" runat="server"  Visible="false" Text="<li><a href=http://join.home4theholidays.org/members/Profile.aspx>Edit Profile</a></li>"/>
			 <!-- <asp:Label ID="lnkDescription" runat="server"  Visible="false" Text="<li><a href=http://join.home4theholidays.org/members/edit_description.aspx>Edit Description</a></li>"/>-->
			  <asp:Label ID="lnkAccount" runat="server"  Visible="false" Text="<li><a href=http://join.home4theholidays.org/members/Account.aspx>Edit Account</a></li>"/>
			  <asp:Label ID="lnkAdmin" runat="server"  Visible="false" Text="<li><a href=http://join.home4theholidays.org/Admin>Admin</a></li>"/>
             
  <img src="http://join.home4theholidays.org/_images/orange_gradient.gif" width="113" height="2">                 
			  <asp:Label ID="lnkLogout" runat="server"  Visible="false" Text="<li><a href=http://join.home4theholidays.org/logout.aspx>Log Out</a></li>"/>
</ul>
		
</div>

