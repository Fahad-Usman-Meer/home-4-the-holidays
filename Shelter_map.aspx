<% @ Page Language="VB" ViewStateEncryptionMode="Never" MasterPageFile="~/template.master" Title="Home 4 the Holidays Shelter Map | Helen Woodward Animal Center" debug="true" %>

<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SqlClient" %>
<%@ import Namespace="System.Security.Principal" %>
<%@ Register TagPrefix="HWAC" TagName="Header2" src="~/_controls/h4thheader-2.ascx" %>
<%@ Register TagPrefix="HWAC" TagName="LeftNav" src="~/_controls/h4thleftnav2.ascx" %>
<%@ Register TagPrefix="HWAC" TagName="Footer" src="~/_controls/h4thfooter.ascx" %>
<script runat="server">

  Sub Page_Load(sender As Object, e As EventArgs)
	if not page.ispostback then 'get data
       	Dim objGetData as New HWAC.databaseH4TH
   		Dim strSQL as String
		'strsql="BACKUP LOG animalcenter_HWAC WITH TRUNCATE_ONLY"
		'objgetdata.ExecuteNonQuery(strsql)
		'exit sub
    	Dim objReader as SqlDataReader
		if request.QueryString("ID")="donate" then
			'donate text
			lbltitle.text="Blue Buffalo Home 4 the Holidays Partner Organizations"
			lblTotal.text="<h2>Keep the Light Shining by Donating to an Animal Shelter or Rescue Today</h2><p>Select a shelter below and select ""Donate To Shelter"" to proceed.</p>"
		Else if request.ServerVariables("HTTP_REFERER")="http://www.iams.com/iams/en_US/data_root/html/Angel/BecomeAVolunteer.html" or request.QueryString("ID")="Volunteer" then 'volunteer text
			lblTotal.text="<h1>Volunteering</h1><p>Select a shelter below to find information about volunteering</p><p>View Blue Buffalo Home 4 the Holidays shelters by state or country. Choose a state or country to view partner shelters near you.</p>"
		else
			Lbltitle.text="Search for a Blue Buffalo Home 4 the Holidays Organization"
     	 'Get Total Shelters
		  strSQL ="SELECT count(ShelterID) as ShelterCount From tblH4THReg WHERE Approved=1 AND Active=1 AND Verified=1"
		  lblTotal.text=" <p>See Blue Buffalo Home 4 the Holidays shelters by state or  country. Choose a state or country to view partner shelters near you.<br>  <br>  There are " & objGetData.ExecuteScalar(strSQL) &   " animal shelters  and pet rescue groups enrolled in Blue Buffalo Home 4 the Holidays. If your  organization has not yet registered, <a href=""http://join.home4theholidays.org/register.aspx"">do so today  and increase pet adoption awareness!</a></p>"
'> There are  animal shelters  and pet rescue groups enrolled in Blue Buffalo Home 4 the Holidays. If your  organization has not yet registered, <a href=""http://join.home4theholidays.org/register.aspx"">do so today</a> and increase pet adoption  awareness!"'<p>Choose a state or country to view its participating shelters.</p> <p>Help us reach this years goal of 4000 Shelters! There are " & objGetData.ExecuteScalar(strSQL) & " animal shelters and pet rescue groups that have enrolled in Home 4 the Holidays. If your organization has not yet registered, do so today and help save  lives!</p>"
		 end if
		 GetStates
		 GetCountries
	end if 
end sub

Sub GetStates
	  'Get States
	    Dim objGetData as New HWAC.databaseH4TH
   		Dim strSQL as String
    	Dim objReader as SqlDataReader

 strSQL ="SELECT MState, count(ShelterID) as StateCount From tblH4THReg WHERE MCountry='United States' AND Approved=1 AND Verified=1 AND Active=1 Group By MState Order By MState"	
 	  objReader=objGetData.GetReader(strSQL)
		  if not objReader is Nothing then
		  	dlStates.DataSource = objReader
      		dlStates.DataBind()
		    objReader.Close
		 end if
end sub

Sub GetCountries
	  'Get Countries
	    Dim objGetData as New HWAC.databaseH4TH
   		Dim strSQL as String
    	Dim objReader as SqlDataReader

		  strSQL ="SELECT MCountry From tblH4THReg WHERE MCountry<>'United States'  AND Approved=1 AND Verified=1 AND Active=1 Group By MCountry Order By MCountry"
		  objReader=objGetData.GetReader(strSQL)
		  if not objReader is Nothing then
			dlCountries.DataSource = objReader
			dlCountries.DataBind()
			objReader.Close
		  end if

End Sub

sub View_Shelters(obj as object, e as DataListCommandEventArgs)
        dim strSQL as String
		dim strState as string
		dim lnkbtn as linkbutton
		dim objReader as SqlDataReader
		dim objGetData as New HWAC.databaseH4TH
		dim strWeb as string
		dim strReplace as string

		'---find the  control containing the state
        lnkbtn = CType(e.Item.FindControl("btn1"), linkbutton)
        strState = lnkbtn.Text
		if len(strState)>2 then 'must be country
			lblHeader.text=strState
     	    strSQL ="SELECT ShelterName, MCity, WebSite, ShelterID From tblH4THReg WHERE MCountry ='"& strState & "' AND Approved=1 AND Verified=1 AND Active=1 Order By " & ddlSort.selectedItem.Value
		else
			lblHeader.text="United States -" & strState
  	        strSQL ="SELECT ShelterName, MCity, Website, ShelterID From tblH4THReg WHERE MState ='"& strState & "'  AND Approved=1 AND Verified=1 AND Active=1 Order By " & ddlSort.selectedItem.Value
		end if
	  	objReader=objGetData.GetReader(strSQL)
        'set lblshelters.text to data
		if not objReader is nothing then
			lblshelters.text="<ol>"
			 'Dim p as IPrincipal = HttpContext.Current.User
			'if p.IsInRole("Admin") then
			if session("Admin")="@F@EWE$" then
			
				While objReader.read()
					strReplace=replace(objReader.GetString(0),"&","%26")
					strReplace=replace(strReplace,"""","%22")
					strWeb &="<li> <a href=""members/index.aspx?ShelterName=" & strReplace & "&SID=" & objReader.GetInt32(3) & """><b>+</b></a>&nbsp;<a href=shelter_details.aspx?ShelterID=" & objReader.Item("ShelterId") & " target=""_blank"">"  & objReader.GetString(0) & ", " & objReader.GetString(1) & "</a></li>"
					 '& "<span><table bgcolor=""#D8FAD3"" border=""2"" bordercolor=""#009966"" cellpadding=""2""><tr><td>Home 4 The Holidays  is a free program that provides support and materials to shelters to help increase adoptions, increase public awareness, lower euthanasia, and results in very few returns.</td></tr></table></span></a>, " & objReader.GetString(1) & 
					
					
				end while	
				lblShelters.text =strWeb
			else
				While objReader.read()
			
					strWeb &="<li><a href=shelter_details.aspx?ShelterID=" & objReader.Item("ShelterID") & " target=""_blank"">" & objReader.GetString(0) & ", " & objReader.GetString(1) & "</a></li>"
					' "<span><table bgcolor=""#D8FAD3"" border=""2"" bordercolor=""#009966"" cellpadding=""2""><tr><td>Home 4 The Holidays  is a free program that provides support and materials to shelters to help increase adoptions, increase public awareness, lower euthanasia, and results in very few returns.</td></tr></table></span></a>, " &
					
						
				end while	
				lblShelters.text &=strWeb
			
				

			End If	
					lblshelters.text &="</ol>"

		End If  
end sub

</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="description" content="Is there a Blue Buffalo Home 4 the Holidays shelter in your area? Find all Blue Buffalo Home 4 the Holidays shelters at the Shelter Map." />
  <meta name="keywords" content="shelter map, pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />
</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" > Participating Shelters</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" >
 </asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg"> <asp:Label runat="server" ID="lblTitle" /> <br></h1>
<div class="feature" >
    <p>                       
                        <asp:Label runat="server" ID="lblTotal" /> 
                      </p>
        <font size="-1">
		<form runat="server">    
			<asp:Datalist id="dlStates" runat="server" DataKeyField="MState" RepeatColumns="11"   RepeatDirection="Vertical" OnEditCommand="View_Shelters" CellPadding="2" ItemStyle-Wrap="false">
				<headertemplate>
					<h3>United States</h3>
				</headertemplate>
				<FooterStyle Font-Size="11px" ForeColor="DimGray"  />
	
	  			<ItemTemplate>
	  				<asp:LinkButton id="btn1" runat="server" Text='<%# Container.DataItem("MState") %>'
					CommandName="Edit" /> <sup style="font-size:8px">(<%# Container.DataItem("StateCount") %>)</sup>
	  			</ItemTemplate>
	  		</asp:Datalist>
	  		<br>
	  		<asp:Datalist id="dlCountries" runat="server" DataKeyField="MCountry"  RepeatDirection="Horizontal" OnEditCommand="View_Shelters" CellPadding="1" ItemStyle-Wrap="true" RepeatLayout="Flow" >
	 			<headertemplate>
	 				<h3>International</h3>
	 			</headertemplate>
	 			<FooterStyle Font-Size="11px" ForeColor="DimGray"  />
				<FooterTemplate>
     				 <br><br>There are <%# dlCountries.Items.Count.ToString()+1%> Countries participating.<br>
      			</FooterTemplate>
	  			<ItemTemplate>
	  				<asp:LinkButton id="btn1" runat="server" Text='<%# Container.DataItem("MCountry") %>'
					CommandName="Edit" />&nbsp;&nbsp;
	  			</ItemTemplate>
	  		</asp:Datalist>
	  
      		
          <h3>
            <asp:Label runat="server"  ID="lblHeader" />          
          </h3>
          <div align="right">Sort By: 
			  <asp:DropDownList runat="server" id="ddlSort">
			      <asp:ListItem Selected="true" Text="Shelter Name" Value="Sheltername"/>                
			      <asp:Listitem Text="City" Value="MCity"/>                
			    </asp:DropDownList>
          </div>
          <div class="feature">
		  <asp:Label runat="server"  ID="lblShelters" /></div>    &nbsp;</td>
		  
    </form></div>
</asp:content>
