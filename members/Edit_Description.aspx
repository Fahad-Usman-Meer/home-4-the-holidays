<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Home 4 The Holidays" debug="true" ValidateRequest="false" %>
<%@ Import Namespace="System.IO" %>
<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<%@ Register TagPrefix="cc" Namespace="TinyMCEditor" %>

<script runat="server">
Sub Page_Load(obj as object, e as eventargs)
	'open text file and put in description text
	if not page.ispostback then 
		'Open a file for reading`
		Dim FILENAME as String = Server.MapPath("../txtFiles/" & session("UserID") & "_Description.txt")
		'response.Write(filename)
		'exit sub
		Dim objFSO
		 objFSO = Server.CreateObject("Scripting.FileSystemObject")
	If objFSO.FileExists(FILENAME) then
		'Get a StreamReader class that can be used to read the file
		Dim objStreamReader as StreamReader
		objStreamReader = File.OpenText(FILENAME)
	
		'Now, read the entire file into a string
		Dim contents as String = objStreamReader.ReadToEnd()
	
		'Set the text of the file to a Web control
		editor1.Value = contents
		
		'We may wish to replace carraige returns with <br>s
		'lblNicerOutput.Text = contents.Replace(vbCrLf, "<br>")
		
		objStreamReader.Close()
	else 
				editor1.Value = ""


	end if
end if
end Sub


sub btnUpdate_Click(obj as object, e as eventargs)
	'update text file with shelter description text
	 'Open a file for writing
    Dim FILENAME as String =Server.MapPath("../txtFiles/" & session("UserID") & "_Description.txt")

    'Get a StreamReader class that can be used to read the file
    Dim objStreamWriter as StreamWriter
    objStreamWriter = File.CreateText(FILENAME)

    objStreamWriter.Write(editor1.Value)
    
    'Close the stream
    objStreamWriter.Close()
	lblmessage.text="Description updated " & datetime.now.tostring() & " PST   <a href=""http://join.home4theholidays.org/shelter_details.aspx?ShelterID=" & session("UserId") & """ target=""_blank"">View Profile</a>"
end sub


</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
 
 <script src="../../ckeditor/ckeditor.js"></script>
</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >Shelter Description</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Edit your shelter's description<br></h1><table width="100%" border="0">
                                                            <tr>
                                                              <td width="442" valign="top"><div class="feature">
                                                                  <h3><a href="Profile.aspx">Edit Profile</a> | Edit Description </h3>
                                                              </div></td>
                                                              <td width="154" valign="top">&nbsp;</td>
                                                            </tr>
                                                            <tr>
                                                              <td colspan="2"><p>Add a description of your shelter to your personal page.</p>
                                                                  <p>
                                                                    <asp:Label ID="lblmessage" runat="server" Font-Bold="true" Font-Size="10" ForeColor="#FF0000"     />                                                            
    </p></td>
                                                            </tr>
                                                            <tr>
                                                              <td colspan="2"><form runat="server" method="post">
                                                                 <textarea name="editor1" runat="server" id="editor1">&lt;p&gt;Initial value.&lt;/p&gt;</textarea>
            <script>
                CKEDITOR.replace( 'ctl00$maincontent$editor1' );
            </script>
           
                                                                  <asp:Button runat="server" ID="btnUpdate" Text="Update" OnClick="btnUpdate_click"/>        
                                                                  
                                                                                                                
      </form>
                                                                  <asp:Label runat="server" ID="lblDescription"/>                                                            
                                                                  <br>
      Tip: If you want images in your description, you need to have them hosted on another server such as <a href="http://www.photobucket.com" target="_blank">www.photobucket.com</a> and use the entire link provided by them to have the image appear. (http://www.photobucket.com/myimageinfo)</td>
                                                            </tr>
                                                          </table>
</asp:content>
