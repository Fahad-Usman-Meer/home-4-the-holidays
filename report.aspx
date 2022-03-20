<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Report your numbers- Home 4 The Holidays" debug="true" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SqlClient" %>

<script runat="server">
sub Page_load(obj as object, e as EventArgs)
	if not page.ispostback then
	GetDates
	'look for data
		if request.QueryString("UniqueID")<>"" And request.QueryString("Dogs")<>"" And request.QueryString("Puppies")<>"" And request.QueryString("Cats")<>"" And request.QueryString("Kittens")<>"" And request.QueryString("Other")<>"" then 'lookup shelter and add adoptions
			tbDogs.text=request.QueryString("Dogs")
			tbPuppies.text=request.QueryString("Puppies")
			tbCats.Text=request.QueryString("Cats")
			tbKittens.text=request.QueryString("Kittens")
			tbOther.text=request.QueryString("Other")
			Add_Adoptions
		else
			if request.QueryString("UniqueID")<>"" then
			lblmessage.text="Please use the form below to submit your numbers."
			else
				lblmessage.text="There has been an error, please <a href=""login.aspx?ReturnURL=home4theholidays"">log in</a> to record your numbers.  Thank you."
				Form1.visible=false
			end if
		end if
	end IF
End Sub
Sub GetDates()
	dim strSqL as string
	dim objReader as sqldatareader
	dim db as new hwac.databaseH4TH
	strSql="Select DateID, DisplayDesc FROM tblH4thDates Where BegDate<='" & datetime.now.toShortDatestring & "' AND EndDate>='" & datetime.now.toShortDatestring & "' ORDER BY Begdate Desc"
	
	objReader=db.Getreader(strSql)
	ddlDates.datasource=objReader
	ddlDates.databind()
End Sub
Sub Add_Adoptions
		'add data to h4th adoptions list with session user id
		'first check if data is already in system, if is, update, if not, add new
		dim strsql as string
		dim intID as integer
		dim strResult as string
		dim db as new hwac.databaseH4TH
		dim strAType as string
		if  session("ShelterID") is nothing then
			strsql="Select UserID From tblUsers Where UniqueID='" & request.QueryString("UniqueID") & "'"
			intID=db.ExecuteScalar(strSql)
		 	session("ShelterID")=intID
		end if
		 if session("ShelterID")<>0 then

			strsql="SELECT pKey FROM tblH4thAdoptions WHERE Shelterid=" & session("ShelterID") & " AND DateId=" & ddlDates.selecteditem.value
			strResult=db.ExecuteScalar(strSql)
			if instr(ddlDates.selecteditem.Text, "Goal") then 'is a goal, not a weekly
				strAtype="Goal"
			else
				strAType="Weekly"
			End if
			if strResult="" then 'does not exist-insert new
				strSql="INSERT Into tblH4thAdoptions (ShelterID, DateID, Ayear, AType, Dogs, Puppies, Cats, Kittens, Other) Values (" & session("ShelterId") & "," & ddlDates.selecteditem.value & ",'2015','" & strAType & "'," & tbDogs.text & "," & tbPuppies.text & "," & tbCats.text & "," & tbKittens.text & "," & tbOther.text & ")"
			else 'exists, update
				strSql="Update tblH4thAdoptions Set Dogs=" & tbDogs.text & ", Puppies=" & tbPuppies.text & ", Cats=" & tbCats.text & ", Kittens=" & tbKittens.text & ", Other=" & tbOther.text & " WHERE ShelterId=" & session("ShelterID") & " AND DateId=" & ddlDates.selecteditem.value 
			end if
			try
				db.ExecuteNonQuery(strsql)
				lblmessage.text=ddldates.selecteditem.text & " Updated!"
			catch ex as exception
				 lblmessage.text="There has been an error.  Please try again or log in to enter your adoptions.  Thank you!"
				 dim objMM as New HWAC.EmailMessage
				 objmm.MailTO="lonjones@hotmail.com"
				 objmm.From="h4thnewsAanimalcenter.org"
				 objmm.Body=ex.tostring()
				 objmm.Subject="Report Error"
				 objmm.Send_Email(objMM)
			end try
		else
				lblmessage.text &="There has been an error, please <a href=""login.aspx?ReturnURL=home4theholidays"">log in</a> to record your numbers.  Thank you."
				Form1.visible=false
		end if
End Sub
Sub btnAdd_Adoptions_Click(obj as object, e as EventArgs)
	Add_Adoptions
end sub
</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  
</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" > Reporting Your Home 4 The Holidays Adoptions</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" >
</asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Home 4 The Holidays Adoptions<br></h1>
<div class="feature">
														    <table width="100%" border="0">
                                                              <tr>
                                                                <th width="442" valign="top"><asp:Label ID="lblmessage" runat="server"/></th>
                                                                <td width="154" valign="top">&nbsp;</td>
                                                              </tr>
                                                              <tr>
                                                                <td colspan="2"><form runat="server" id="form1" >
                                                                    <table  cellpadding="2" cellspacing="5">
                                                                      <tr>
                                                                        <td>Choose Your Week or Goal </td>
                                                                        <td>Dogs</td>
                                                                        <td>Puppies</td>
                                                                        <td>Cats</td>
                                                                        <td>Kittens</td>
                                                                        <td>Other</td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td><asp:DropDownList runat="server" ID="ddlDates"  Width="300"
				Datatextfield="DisplayDesc" DataValueField="DateID"/>                                                          
              </td>
                                                                        <td><asp:textbox runat="server" ID="tbDogs" MaxLength="4" Width="30" Text='0'/>                                                          
              </td>
                                                                        <td><asp:textbox runat="server" ID="tbPuppies" MaxLength="4" Width="30" Text='0'/>                                                          
              </td>
                                                                        <td><asp:textbox runat="server" ID="tbCats" MaxLength="4" Width="30" Text='0'/>                                                          
              </td>
                                                                        <td><asp:textbox runat="server" ID="tbKittens" MaxLength="4" Width="30" Text='0'/>                                                          
              </td>
                                                                        <td><asp:textbox runat="server" ID="tbOther" MaxLength="4" Text="0" Width="30"/>                                                          
              </td>
                                                                      </tr>
                                                                      <tr>
                                                                        <td colspan="6"><asp:RequiredFieldValidator  ControlToValidate="tbDogs" ErrorMessage="*Number of dogs required" Display="Dynamic" runat="server" />                                                          
                                                                            <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" Display="Dynamic" ControlToValidate="tbDogs"  Type="Integer"  ErrorMessage="*Dogs must be a number between 0 and 200"/>                                                            
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbPuppies" ErrorMessage="*Number of Puppies required" Display="Dynamic" runat="server" />                                                            
                                                                            <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" Display="Dynamic" ControlToValidate="tbPuppies"   Type="Integer" ErrorMessage="*Puppies must be a number between 0 and 200"/>                                                            
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbCats" ErrorMessage="*Number of Cats required" Display="Dynamic" runat="server" />                                                            
                                                                            <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" Display="Dynamic" ControlToValidate="tbCats"   Type="Integer" ErrorMessage="*Cats must be a number between 0 and 200"/>                                                            
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbKittens" ErrorMessage="*Number of Kittens required" Display="Dynamic" runat="server" />                                                            
                                                                            <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" Display="Dynamic" ControlToValidate="tbKittens"   Type="Integer" ErrorMessage="*Kittens must be a number between 0 and 200"/>                                                            
                                                                            <asp:RequiredFieldValidator  ControlToValidate="tbOther" ErrorMessage="*Number of other animals required.  Enter 0 if none." Display="Dynamic" runat="server" />                                                            
                                                                            <asp:RangeValidator runat="server" MinimumValue="0" MaximumValue="2000" Display="Dynamic" ControlToValidate="tbOther"  Type="Integer" ErrorMessage="*Other animals must be a number between 0 and 200"/>                                                            
                                                                      <tr>
                                                                        <td colspan="6"><asp:Button runat="server" OnClick="btnAdd_Adoptions_Click" Text="Submit Information"/></td>
                                                                      </tr>
                                                                    </table>
                                                                </form></td>
                                                              </tr>
                                                                                                                      </table>
													      </div>
</asp:content>
