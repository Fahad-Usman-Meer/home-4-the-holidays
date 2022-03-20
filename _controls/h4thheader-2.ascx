<%@ Control Language="VB"  %>

<script runat="server">
Sub Page_Load(obj as object, e as EventArgs)
	lblUser.text=Session("ShelterName")

End Sub


</script>
<table border="0" cellpadding="0" cellspacing="0">
<tr>
<td width="100%" align="left"><div id="topnav"> <h5><a href="http://join.home4theholidays.org/index.aspx">Home</a> | <a href="http://join.home4theholidays.org/about.aspx">About Home 4 The Holidays</a> | <a href="http://join.home4theholidays.org/qa.aspx">Q&amp;A's</a> |
		    <asp:Label runat="server" id="lblUser" Text=""  ForeColor="#003300"/></h5>
		</div></td>
</tr>
</table>
