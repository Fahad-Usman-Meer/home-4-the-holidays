<%@ Control Language="VB" %>

<script runat="server">
    Sub Page_load(obj As Object, e As EventArgs)
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        If Session("UserID") <> "" Then
            ' Dim p as IPrincipal = HttpContext.Current.User
            'if p.IsInRole("h4th") or p.IsInRole("Admin") then
            lnkAdoptions.Visible = True
            lnkProfile.Visible = True
            lnkAccount.Visible = True
            lnkLogout.Visible = True
            lnkSignup.Visible = False
            'lnkDescription.Visible=true
            lnkVan.Visible = True
            'end if
        End If
    End Sub
</script>

<div id="sectionLinks">

    <header id="header">
        <div class="header-top">
            <div class="container">
                <div class="row align-items-center">
                    <div class="col-lg-6 col-sm-6 col-6 header-top-left">
                        <ul>
                            <li>
                                <!--<span style="color:white;"> some text here above logo </span>-->
                            </li>
                        </ul>
                    </div>
                    <div class="col-lg-6 col-sm-6 col-6 header-top-right">
                        <div class="header-social">
                            <a href="http://join.home4theholidays.org/invite.aspx">
                                <i class="fa fa-envelope" style="padding-right: 1em;"></i>
                                Invite Shelters 
                            </a>
                            <a href="http://join.home4theholidays.org/Contact.aspx">
                                <i class="lnr lnr-phone" style="padding-right: 1em;"></i>
                                Contact Us
                            </a>
                            <a>
                                <span class="st_sharethis_custom" displaytext="">
                                    <i class="fa fa-share" style="padding-right: 1em;"></i>
                                    Share This Page
                                </span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="container main-menu">
            <div class="row align-items-center justify-content-between d-flex">
                <div id="logo">
                    <a href="/index.html">
                        <img style="width: 130%; height: 40px" src="/_images/logos/H4TH13-topbar-logo.jpg" alt="" title="" />
                    </a>
                </div>
                <nav id="nav-menu-container">
                    <ul class="nav-menu">

                        <li class="menu-has-children"><a href="http://join.home4theholidays.org/members">Member Homepage</a>
                            <ul>
                                <li ID="lnkAdoptions" runat="server" Visible="false"><a href="http://join.home4theholidays.org/members/adoptions.aspx">Record Adoptions</a></li>
                                <li ID="lnkVan" runat="server"     visible="false"><a href="http://join.home4theholidays.org/members/win.aspx">Win $25,000!</a></li>
                                <li ID="lnkProfile" runat="server" Visible="false"><a href="http://join.home4theholidays.org/members/Profile.aspx">Edit Profile</a></li>
                                <li ID="lnkAccount" runat="server" Visible="false"><a href="http://join.home4theholidays.org/members/Account.aspx">Edit Account</a></li>
                                <li ID="lnkAdmin" runat="server"   Visible="false"><a href="http://join.home4theholidays.org/Admin">Admin</a></li>
                                
                                <%--<asp:Label ID="lnkAdoptions" runat="server" Visible="false" Text="<li><a href=http://join.home4theholidays.org/members/adoptions.aspx>Record Adoptions</a></li>" />
                                <asp:Label ID="lnkVan" runat="server" Visible="false" Text="<li><a href=http://join.home4theholidays.org/members/win.aspx>Win $25,000!</a></li>" />
                                <asp:Label ID="lnkProfile" runat="server" Visible="false" Text="<li><a href=http://join.home4theholidays.org/members/Profile.aspx>Edit Profile</a></li>" />
                                <asp:Label ID="lnkAccount" runat="server" Visible="false" Text="<li><a href=http://join.home4theholidays.org/members/Account.aspx>Edit Account</a></li>" />
                                <asp:Label ID="lnkAdmin" runat="server" Visible="false" Text="<li><a href=http://join.home4theholidays.org/Admin>Admin</a></li>" />--%>
                            </ul>
                        </li>

                        <li><a href="http://join.home4theholidays.org/shelter_map.aspx">Participating Shelters</a></li>
                        <li><a href="http://join.home4theholidays.org/downloads.aspx">Downloads</a></li>
                        <li><a href="http://join.home4theholidays.org/social_media_contest.aspx">#IChoseToRescue Contest</a></li>


                        <li id="lnkSignup" runat="server"><a href="http://join.home4theholidays.org/register.aspx">Sign Up</a></li>
                        <li id="lnkLogout" runat="server" visible="false"><a href="http://join.home4theholidays.org/logout.aspx">Log Out</a></li>

                        <%--<asp:Label ID="lnkSignup" runat="server" Text="<li><a href=http://join.home4theholidays.org/register.aspx>Sign Up</a></li>" />--%>
                        <%--<asp:Label ID="lnkLogout" runat="server" Visible="false" Text="<li><a href=http://join.home4theholidays.org/logout.aspx>Log Out</a></li>" />--%>
                    </ul>
                </nav>
                <!-- #nav-menu-container -->
            </div>
        </div>

    </header>

    <%--<ul> 
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
</ul>--%>
</div>

