<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Downloads- Home 4 The Holidays" debug="true" %>

<script runat="server">
sub page_load (obj as object, e as eventargs)
'response.Redirect("http://join.home4theholidays.org/How-To-Guide")
	
end sub
</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server"></asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >
How To Guide
</asp:content>
    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Blue Buffalo Pet Food Prize</h1>
<p><img src="_images/download.jpg" alt="Blue Buffalo Food" width="225" height="225" align="right" />Stay tuned for 2014 campaign benefits brought to you by Blue Buffalo.</p>
</asp:content>
