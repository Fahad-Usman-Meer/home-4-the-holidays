<% @ Page Language="VB" MasterPageFile="~/template.master" Title=" Home 4 The Holidays" debug="true" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SQLClient" %>

<script runat="server">
sub page_load (obj as object, e as eventargs)
	Dim db as new HWAC.databaseH4TH
	dim strSQL as string
	strSQL="Update tblH4THReg SET Active=1, verified=1 WHERE UniqueID='" & request.QueryString("Var1") & "'"
				try
				db.ExecuteNonQuery(strSQL) 
				catch ex as exception
					lblmessage.text =ex.tostring()
					exit sub
				end try
				lblmessage.text ="Your registration has been verified. Thank you for helping to save lives!<br></h1><p><img src=""../_images/events/h4th/Little boy holding orange cat.jpg"" alt=""h4th"" width=""275"" height=""200"" align=""right"" />Your profile is now public and you are fully enrolled in the  Home 4 The Holidays program.</p>"
end sub
</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  
</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" > Home 4 The Holidays</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg"><asp:Label ID="lblmessage" runat="server"/>
</asp:content>
