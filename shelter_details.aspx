<% @ Page Language="VB" MasterPageFile="~/template.master" Title=" Home 4 The Holidays" debug="true" %>
<%@ import Namespace="System.Security.Principal" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SqlClient" %>
<%@ Import Namespace="System.IO" %>

<script runat="server">

sub Page_load(obj as object, e as EventArgs)
	if not page.ispostback then
		'look up shelter infor based upon querystring ShelterID
	if request.QueryString("ShelterId")<>"" then
	Dim db as New HWAC.databaseH4TH
	Dim objReader as SQLDataReader
	Dim StrSQL as String
	
	StrSQL="SELECT  ShelterName, FName, LName, ContactPhone, MAddress, MCity, MState, MZip, MCountry, SAddress, SCity, SState, SZip, SCountry, ShelterPhone, Fax, Email, Website, ShowPublic, ShelterID, Facebook, Twitter, Blog, pintrest, youtube FROM  dbo.tblH4THReg WHERE (ShelterID=" & request.QueryString("ShelterID") & ") AND Active=1"
	objReader=db.GetReader(strSQL)
	if not objReader is nothing then 'has found data
		With objReader
		While .Read()'fill labels
			lblShelterName.Text=.item("ShelterName")
			if mid(.Item("ShowPublic"),1,1)="1" then 
				lblShelterContact.Text="Shelter Phone: " & .Item("ShelterPhone")
			end if
			if mid(.Item("ShowPublic"),3,1)="1" then 
				lblShelterContact.Text &="<br>Contact: " & .GetString(1) & " " & .GetString(2) & "<br>"
			End if
			if mid(.Item("ShowPublic"),4,1)="1" then 
				lblShelterContact.Text &= "Contact Phone: " & .Item("ContactPhone")
			end if
			if mid(.Item("ShowPublic"),2,1)="1" then 
				if .GetString(15)<>"" Then lblShelterContact.Text &="<br>Fax:   " & .Getstring(15)
			end if
			if mid(.Item("ShowPublic"),5,1)="1" then 
				if .GetString(16)<>"" Then lblShelterContact.Text &="<br><a href=mailto:" & .GetString(16)& ">Email</a>"
			end if
			if mid(.Item("ShowPublic"),6,1)="1" then 
				lblShelterAddress.Text="<strong>Physical</strong><br>" & .Item("SAddress") & "<br>" & .Item("SCity") & ", " & .Item("SState") & "  " & .Item("SZip")
				if .GetString(8)<>"United States" Then lblShelterAddress.Text &="  " & .Getstring(8)
				if .Item("SAddress")<>"" then lblShelterAddress.Text &="<br><a href=""http://www.maps.google.com/maps?complete=1&hl=en&q=" & .Item("SAddress") & "%20" & .Item("SCity") & "%20" & .Item("SState") & "%20" & .Item("SCountry") & "&sa=N&tab=wl"" target=""_blank"">Map</a>"
			end if
			if mid(.Item("ShowPublic"),7,1)="1" then 
				lblShelterAddress.Text &="<br><br><strong>Mailing</strong><br>" & .Item("MAddress") & "<br>" & .Item("MCity") & ", " & .Item("MState") & "  " & .Item("MZip")
				if .GetString(8)<>"United States" Then lblShelterAddress.Text &="  " & .Getstring(8)
			end if

			if .GetString(17)<>"" Then lblShelterWebsite.Text &="<br><a href=http://" & .GetString(17)& " target=""_blank"">Website</a> "
			if .GetString(22)<>"" Then
				 lblShelterWebsite.Text &=" | <a href=http://" & .GetString(22)& " target=""_blank"">Blog</a><br>"
			else 
				lblShelterWebsite.Text &="<br>"
			end if
			if .GetString(20)<>"" Then lblShelterWebsite.Text &="<a href=http://" & .GetString(20)& " target=""_blank""><img src=""../_images/layout/3D-Icons-PNG/facebook.png"" alt=""facebook""  width=""25"" Height=""25"" vspace=""1""/></a>"
			if .GetString(21)<>"" Then lblShelterWebsite.Text &="<a href=http://" & .GetString(21)& " target=""_blank""><img src=""../_images/layout/3D-Icons-PNG/Twitter.png"" width=""25"" Height=""25"" vspace=""1""/></a>"
			
			if .GetString(23)<>"" Then lblShelterWebsite.Text &="<a href=http://" & .GetString(23)& " target=""_blank""><img src=""../_images/layout/3D-Icons-PNG/Pinterest.png"" width=""25"" Height=""25"" vspace=""1""/></a>"
			if .GetString(24)<>"" Then lblShelterWebsite.Text &="<a href=http://" & .GetString(24)& " target=""_blank""><img src=""../_images/layout/3D-Icons-PNG/YouTube.png""  alt=""youtube"" width=""25"" Height=""25""vspace=""1""/></a>"
				lbldonate.text="<a href=""https://join.home4theholidays.org/donate.aspx?ShelterID=" & .Item("ShelterID") & "&ShelterName=" & .Item("ShelterName") & """>Donate To This Shelter</a>"
		end While
		end with
	else' did not find data
		lblmessage.text="Shelter information not available. Please try again later. Thanks!"
		
	end if 
	else
			lblmessage.text="Shelter information not available. Please try again later. Thanks!"
	end if
	
	'open text file and put in description text
	if not page.ispostback then 
		'Open a file for reading
		Dim FILENAME as String = Server.MapPath("txtFiles/" & request.QueryString("ShelterId") & "_Description.txt")
		Dim objFSO
		 objFSO = Server.CreateObject("Scripting.FileSystemObject")
	If objFSO.FileExists(FILENAME) then

		'Get a StreamReader class that can be used to read the file
		Dim objStreamReader as StreamReader
		objStreamReader = File.OpenText(FILENAME)
	
		'Now, read the entire file into a string
		Dim contents as String = objStreamReader.ReadToEnd()
	
		'Set the text of the file to a Web control
		lblShelterDescription.Text = contents
		
		'We may wish to replace carraige returns with <br>s
		'lblNicerOutput.Text = contents.Replace(vbCrLf, "<br>")
		
		objStreamReader.Close()
	end if
	end if
	end IF
	
	
	
End Sub




</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</asp:content>


<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" > Shelter Details</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg"><asp:Label runat="server" ForeColor="#0033FF" ID="lblShelterName" Font-Bold="true"  Font-Size="15"/><br></h1>
														  <div align="left"><span class="feature">
												          <asp:Label ID="lblMessage" Font-Bold="true" ForeColor="#FF0000" runat="server"/>                                                                                                                                                                              
												          </span>
												          </div>
														  <table width="100%">
                                                                    <tr>
                                                                      <td colspan="3"></td>
                                                                    </tr>
                                                                    <tr>
                                                                      <td width="19%" valign="top">&nbsp;</td>
                                                                      <td width="52%" align="right" valign="top">&nbsp;</td>
                                                                <td width="29%" align="right" valign="top"><div align="left">
                                                                          <asp:Label runat="server" ID="lblShelterWebsite" />                                                            
          </div></td>
                                                            </tr>
                                                                    <tr>
                                                                      <td valign="top" bgcolor="#0033FF"><span class="style1">Location</span></td>
                                                                      <td align="right"><div align="center"><asp:Label  CssClass="donate_orange" ID="lblDonate" runat="server" Font-Bold="true"/></div></td>
                                                                      <td align="right" bgcolor="#0033FF"><div align="left"><span class="style1">Contact</span></div></td>
                                                            </tr>
                                                                    <tr>
                                                                      <td valign="top" nowrap><asp:Label runat="server" ID="lblShelterAddress" /></td>
                                                                      <td align="right">&nbsp;</td>
                                                                      <td align="right" valign="top" nowrap><div align="left">
                                                                          <asp:Label runat="server" ID="lblShelterContact" />                                                            
          </div></td>
                                                                    </tr>
                                                                    <tr>
                                                                      <td colspan="3"><asp:Label runat="server" ID="lblShelterDescription" />                                                            
                                                                          </td>
                                                                    </tr>
                                                          </table>
				
                  </asp:content>
