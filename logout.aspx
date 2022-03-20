<% @ Page Language="VB" MasterPageFile="~/template.master" Title=" Home 4 The Holidays" debug="true" %>

<script runat="server">
Sub Page_Load(obj as object, e as eventargs)
	Session.Abandon()
    FormsAuthentication.SignOut()
	'response.Redirect("logout.aspx")
End sub

</script>

<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  
</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" > Home 4 The Holidays</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Logged Out<br></h1>
<div class="feature">
														    <h3 align="center">You have been logged out. Thank You for Participating in Home 4 The Holidays!</h3>
														    <p align="center">&nbsp;</p>
													      </div>
</asp:content>
