<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Adoption Record- Home 4 The Holidays" debug="true" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SqlClient" %>

<script runat="server">
Sub Page_Load(obj as object, e as EventArgs)
if session("UserId")="" then response.Redirect("../login.aspx?ReturnURL=../members/adoptions.aspx")

		ShowGraph()	'get goal table set up
	
	if not page.ispostback then
		'load ddlDates here with dates from h4th dates where date-180 to present
		GetDates()
	else 
		'BindGrid() 'fx to load history to repeater control?
	end if
end sub
Sub GetDates()
	dim strSqL as string
	dim objReader as sqldatareader
	dim db as new hwac.databaseH4TH
	strSql="Select DateID, DisplayDesc FROM tblH4thDates Where BegDate<='" & datetime.now.toShortDatestring & "' AND EndDate>='" & datetime.now.toShortDatestring & "' ORDER BY Begdate Desc"
	
	objReader=db.Getreader(strSql)
	ddlDates.datasource=objReader
	ddlDates.databind()
End Sub
Sub ShowGraph()
	dim strSql as string
	dim strGraph as string
	dim intdogs as integer
	dim intcats as integer
	dim intKittens as integer
	dim intPuppies as integer
	dim intOther as integer
	dim objReader as SqlDataReader 
	dim objReader2 as sqldatareader
	dim db as new HWAC.databaseH4TH
	dim db2 as new HWAC.databaseH4TH
	dim clsGraph as new HWAC.Utility
	
	'History---------------------------------------------
		lblHistory.text=""
		strSQL="SELECT AYear, Sum(dogs) as dogs, SUM(puppies) as Puppies, SUM(Cats) as Cats, SUM(Kittens) as Kittens, Sum(other) as Other, AType FROM tblh4thAdoptions WHERE ShelterId=" & session("UserId") & " GROUP BY AYear,AType ORDER BY AYear asc, AType Asc"
		objReader=db.GetReader(strSql)
		if not objreader is nothing then
			While objReader.Read()
				with objReader
					'Set values
						if isDBnull(.Item(0))	THEN 'no data yet
							intDogs=0:intCats=0:IntPuppies=0:IntKittens=0:intOther=0 'initialize for graph
						else
							'if .getstring(0)<>year(now) then
							'lblHistory.text &="<tr><td>" & .getstring(0) & "</td><td>"& .getint32(1) & "</td><td>" & .Getint32(2) & "</td><td>" & .Getint32(3) & "</td><td>" & .Getint32(4)	& "</td><td>" & .Getint32(5) & "</td></tr>"
							
							'else
								if .Item("AType")<>"Goal" then 'weekly numbers
									lblHistory.text &="<tr><td>Total</td><td>" & .getstring(0) & "</td><td>"& .getint32(1) & "</td><td>" & .Getint32(2) & "</td><td>" & .Getint32(3) & "</td><td>" & .Getint32(4)	& "</td><td>" & .Getint32(5) & "</td></tr>"
									intDogs=.Getint32(1)
									intCats=.Getint32(3)
									IntPuppies=.Getint32(2)
									IntKittens=.Getint32(4)
									intOther=.Getint32(5)			
								else	
									lblHistory.text &="<tr bgcolor=""orange""><td>Goal</td><td>" & .getstring(0) & "</td><td>"& .getint32(1) & "</td><td>" & .Getint32(2) & "</td><td>" & .Getint32(3) & "</td><td>" & .Getint32(4)	& "</td><td>" & .Getint32(5) & "</td></tr>"
									intDogs=0:intCats=0:IntPuppies=0:IntKittens=0:intOther=0
								end if
							'end if
						end if	
				End with
			End While
			if lblHistory.text<>"" then lblhistory.text="<table align=center ><tr><td colspan=7 align=center><b>Total Adoptions</b></td></tr><tr><td></td><td>Year</td><td>Dogs</td><td>Puppies</td><td>Cats</td><td>Kittens</td><td>Other</td></tr>" & lblhistory.text & "</table>"
			
			objreader.close
		else 'no data yet
			intDogs=0:intCats=0:IntPuppies=0:IntKittens=0:intOther=0
			objreader.Close
		end if
		db=nothing
		'End History-----------------------------------------------
		'Current Year Graph-----------------------------------------
		strSQL="SELECT AYear, dogs, Puppies, Cats, Kittens, Other FROM tblh4thAdoptions WHERE Atype='Goal' AND ShelterId=" & session("UserId") & " Order By AYear ASC"
		objreader2=db2.GetReader(strSQL)
			if not objReader2 is nothing then 'found it
				'build table
				with objReader2
					While .read()
					lblgraph.text="<table align=center cellpadding=1 cellspacing=1 width=260><tr><td colspan=2 align=center><h4>Your " & .Getstring(0) & " Goal</h4></td></tr><tr>"
					if .Item(1)<>0 then lblGraph.Text &="<td align=right nowrap>" & .Item(1) & " Dogs&nbsp;</td><td>" & clsGraph.CreateGraph(.Item(1),intDogs) & "</td></tr><tr>"
					if .Item(2)<>0 then lblGraph.Text &="<td align=right nowrap>" & .Item(2) & " Puppies&nbsp;</td><td>" & clsGraph.CreateGraph(.Item(2),intPuppies) & "</td></tr><tr>"
					if .Item(3)<>0 then lblGraph.Text &="<td align=right nowrap>" & .Item(3) & " Cats&nbsp;</td><td>" & clsGraph.CreateGraph(.Item(3),intCats) & "</td></tr><tr>"
					if .Item(4)<>0 then lblGraph.Text &="<td align=right nowrap>" & .Item(4) & " Kittens&nbsp;</td><td>" & clsGraph.CreateGraph(.Item(4),intKittens) & "</td></tr><tr>"
					if .Item(5)<>0 then lblGraph.Text &="<td align=right nowrap>" & .Item(5) & " Other&nbsp;</td><td>" & clsGraph.CreateGraph(.Item(5),intOther) & "</td></tr><tr>"
					lblgraph.Text &="<td></td><td></td></tr></table>"
					end while
				end with
			else
			
			End if
			objreader2.close
	'End Current Year Graph---------------------------------------------------------------
	
	'Breakdown this years entries---------------------------------------------------------
			'show this years adoption entries
		dim objreader3 as SqlDataReader
		dim db3 as new hwac.databaseH4TH
		
      strSQL ="SELECT dbo.tblH4thDates.DisplayDesc, dbo.tblH4thAdoptions.pKey, dbo.tblH4thAdoptions.Dogs, dbo.tblH4thAdoptions.Puppies, dbo.tblH4thAdoptions.Cats, dbo.tblH4thAdoptions.Kittens, dbo.tblH4thAdoptions.Other FROM dbo.tblH4thAdoptions INNER JOIN dbo.tblH4thDates ON dbo.tblH4thAdoptions.DateId = dbo.tblH4thDates.DateID WHERE (dbo.tblH4thDates.BegDate <= '" & datetime.now.toshortdatestring & "') AND (dbo.tblH4thDates.EndDate >='" & datetime.now.toShortDatestring & "') AND (dbo.tblH4thAdoptions.ShelterID=" & session("UserID") & ") AND (dbo.tblH4thAdoptions.AType<>'Goal') ORDER BY dbo.tblH4thDates.BegDate"
      'Create/Populate the DataReader
      objReader3 = db3.GetReader(strSQL)
        'Databind the DataReader to the DataList Web control
		if objReader3.HasRows() then
		     dlAdoptions.DataSource = objReader3
     		 dlAdoptions.DataBind()
	    else
		  	dlAdoptions.Visible=False
		end if
      objReader3.Close

End Sub
Sub btnAdd_Adoptions_Click(obj as object, e as EventArgs)
	if page.isvalid then
		'add data to h4th adoptions list with session user id
		'first check if data is already in system, if is, update, if not, add new
		dim strsql as string
		dim strResult as string
		dim db as new hwac.databaseH4TH
		dim strAType as string
			strsql="SELECT pKey FROM tblH4thAdoptions WHERE Shelterid=" & session("UserId") & " AND DateId=" & ddlDates.selecteditem.value
			strResult=db.ExecuteScalar(strSql)
			if instr(ddlDates.selecteditem.Text, "Goal") then 'is a goal, not a weekly
				strAtype="Goal"
			else
				strAType="Weekly"
			End if
			if strResult="" then 'does not exist-insert new
				strSql="INSERT Into tblH4thAdoptions (ShelterID, DateID, Ayear, AType, Dogs, Puppies, Cats, Kittens, Other) Values (" & session("UserId") & "," & ddlDates.selecteditem.value & ",'2021','" & strAType & "'," & tbDogs.text & "," & tbPuppies.text & "," & tbCats.text & "," & tbKittens.text & "," & tbOther.text & ")"
			else 'exists, update
				strSql="Update tblH4thAdoptions Set Dogs=" & tbDogs.text & ", Puppies=" & tbPuppies.text & ", Cats=" & tbCats.text & ", Kittens=" & tbKittens.text & ", Other=" & tbOther.text & " WHERE ShelterId=" & session("UserId") & " AND DateId=" & ddlDates.selecteditem.value 
			end if
			db.ExecuteNonQuery(strsql)
			ShowGraph()
	end if
end sub


</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <link rel="stylesheet" href="../_css/thickbox.css" type="text/css" media="screen" />
<link href="../_css/style2.css" rel="stylesheet" type="text/css" />
</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >
H4TH Members
</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Recording Adoptions For Your Shelter<br></h1><div class="feature">
		
		<asp:Panel runat="server"  BorderColor="#0033FF" BackColor="#EAEEEC" BorderStyle="Ridge" BorderWidth="1">
		 <form runat="server" id="form1" >
		 <table cellpadding="4" cellspacing="4" >
            <tr>
              <td>Choose Your Week or Goal </td>
              <td>Dogs</td>
              <td>Puppies</td>
              <td>Cats</td>
              <td>Kittens</td>
              <td>Other</td>
            </tr>
            <tr>
              <td><asp:DropDownList runat="server" ID="ddlDates"
				Datatextfield="DisplayDesc" DataValueField="DateID"/>          
    </td>
              <td><asp:textbox runat="server" ID="tbDogs" MaxLength="4" Width="25" Text='0'  Columns="3"/>          
    </td>
              <td><asp:textbox runat="server" ID="tbPuppies" MaxLength="4" Width="25" Text='0' Columns="3"/>          
    </td>
              <td><asp:textbox runat="server" ID="tbCats" MaxLength="4" Width="25" Text='0' Columns="3" />          
    </td>
              <td><asp:textbox runat="server" ID="tbKittens" MaxLength="4" Width="25" Text='0' Columns="3" />          
    </td>
              <td><asp:textbox runat="server" ID="tbOther" MaxLength="4" Text="0" Width="25" Columns="3"/>          
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
              <td colspan="6"><asp:Button runat="server" OnClick="btnAdd_Adoptions_Click" Text="Submit Numbers" BackColor="#0033FF" ForeColor="#FFFFFF" BorderStyle="none"  Font-Bold="true"/></td>
            </tr>
          </table>
		</form></asp:Panel>
	<table width="100%"  align="center"><tr><td valign="top"><asp:Label runat="server" ID="lblgraph" /></td></tr><tr>
		<td valign="top"><asp:Panel  runat="server">
            <div align="center">
              <h4><span class="feature">
                History
                  </span></h4>
              <span class="feature">
              <asp:Label runat="server" ID="lblHistory" />                                          
            </span></div>
</asp:Panel></td></tr></table><br>
		<asp:Label runat="server" ID="lblCurrentNumbers" />
		
		
			

		
		<div align="center"> 
		<asp:Datalist id="dlAdoptions" runat="server" DataKeyField="pKey" ShowBorder="true" >
	<headertemplate>
		<table align="center" border="0" cellpadding="2" cellspacing="5"><tr bgcolor="#FF9933"><td colspan="6" align="center"><strong>Current Adoption Numbers</strong></td></tr><tr><td>Week</td>
              <td>Dogs</td>
              <td>Puppies</td>
              <td>Cats</td>
              <td>Kittens</td>
              <td>Other</td></tr>
	</headertemplate>
	<FooterTemplate>
	</table>
     <br>
      </FooterTemplate>
	  <ItemTemplate>
	 <tr><td nowrap><%# Container.DataItem("DisplayDesc") %></td><td><%# Container.DataItem("Dogs") %></td><td><%# Container.DataItem("Puppies") %></td><td><%# Container.DataItem("Cats") %></td><td><%# Container.DataItem("Kittens") %></td><td><%# Container.DataItem("Other") %></td>
	  	</tr>
	   </ItemTemplate>
       
	  </asp:Datalist>
      </div>
		</div>
</asp:content>
