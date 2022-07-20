<%@ Page Language="VB" MasterPageFile="~/template.master" Title="Home 4 The Holidays" Debug="true" ValidateRequest="false" %>

<%@ Import Namespace="System.IO" %>
<%--<%@ Register TagPrefix="FCKeditorV2" Namespace="FredCK.FCKeditorV2" Assembly="FredCK.FCKeditorV2" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>--%>
<%@ Register TagPrefix="cc" Namespace="TinyMCEditor" %>

<script runat="server">
    Sub Page_Load(obj As Object, e As EventArgs)
        'open text file and put in description text
        If Not Page.IsPostBack Then
            'Open a file for reading`
            Dim FILENAME As String = Server.MapPath("../txtFiles/" & Session("UserID") & "_Description.txt")
            'response.Write(filename)
            'exit sub
            Dim objFSO
            objFSO = Server.CreateObject("Scripting.FileSystemObject")
            If objFSO.FileExists(FILENAME) Then
                'Get a StreamReader class that can be used to read the file
                Dim objStreamReader As StreamReader
                objStreamReader = File.OpenText(FILENAME)

                'Now, read the entire file into a string
                Dim contents As String = objStreamReader.ReadToEnd()

                'Set the text of the file to a Web control
                editor1.Value = contents

                'We may wish to replace carraige returns with <br>s
                'lblNicerOutput.Text = contents.Replace(vbCrLf, "<br>")

                objStreamReader.Close()
            Else
                editor1.Value = ""


            End If
        End If
    End Sub


    Sub btnUpdate_Click(obj As Object, e As EventArgs)
        'update text file with shelter description text
        'Open a file for writing
        Dim FILENAME As String = Server.MapPath("../txtFiles/" & Session("UserID") & "_Description.txt")

        'Get a StreamReader class that can be used to read the file
        Dim objStreamWriter As StreamWriter
        objStreamWriter = File.CreateText(FILENAME)

        objStreamWriter.Write(editor1.Value)

        'Close the stream
        objStreamWriter.Close()
        lblmessage.Text = "Description updated " & DateTime.Now.ToString() & " PST   <a href=""https://join.home4theholidays.org/shelter_details.aspx?ShelterID=" & Session("UserId") & """ target=""_blank"">View Profile</a>"
    End Sub


</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
    <script src="../ckeditor/ckeditor.js"></script>
</asp:Content>


<%-- start banner Area --%>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" runat="Server">
    <section class="relative my-banner" style="background: url(/img/banners/family-with-dog-porch-banner-2.jpg) center; background-size: cover;">
        <div class="overlay overlay-bg"></div>
        <div class="container">
            <div class="row d-flex align-items-center justify-content-center">
                <div class="about-content col-lg-12">
                    <h1 class="text-white">Edit Shelter's Description</h1>
                    <p class="text-white link-nav">
                        <a href="/members/index.aspx">Member Home</a>
                        <span class="lnr lnr-arrow-right"></span>
                        <a>Shelter Description</a>
                    </p>
                </div>
            </div>
        </div>
    </section>
</asp:Content>
<%-- End banner Area --%>


<asp:Content ID="navigation" ContentPlaceHolderID="Leftnav" runat="server"></asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" runat="Server">


    <section class="about-info-area">
        <div class="container">
            <div class="row align-items-center ">
                <div class="col-lg-12">
                    <div class="title text-center">
                        <h1 class="mb-10">Edit Description </h1>
                    </div>
                    <p>
                        <asp:Label ID="lblmessage" Font-Bold="true" ForeColor="#FF0000" runat="server" />
                    </p>
                    <p>Add a description of your shelter to your personal page.</p>
                    <div class="whole-wrap mb-20">
                        <div class="container">
                            <div class="section">
                                <div class="row">
                                    <div class="col-lg-12 col-md-12">

                                        <form runat="server" method="post">

                                            <div class="section-top-border">
                                                <h3 class="mb-10">Edit your shelter's description</h3>
                                                <div class="row mt-10">
                                                    <div class="col-lg-12 col-md-12 form-group">
                                                        <textarea name="editor1" class="common-textarea form-control" rows="15" cols="15" textmode="MultiLine" runat="server" id="editor1">&lt;p&gt;Initial value.&lt;/p&gt;</textarea>


                                                        <script>
                                                            CKEDITOR.replace('ctl00$maincontent$editor1');
                                                        </script>

                                                    </div>
                                                </div>
                                            </div>

                                            <div class="title text-center mb-20">
                                                <asp:Button ID="btnUpdate" OnClick="btnUpdate_click" CssClass="genric-btn primary small round-border" runat="server" Text="Update" />
                                            </div>
                                        </form>

                                        <asp:Label runat="server" ID="lblDescription" />

                                        <p>Tip: If you want images in your description, you need to have them hosted on another server such as <a href="http://www.photobucket.com" target="_blank">www.photobucket.com</a> and use the entire link provided by them to have the image appear. (http://www.photobucket.com/myimageinfo)</p>
                                    </div>

                                </div>
                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </section>



</asp:Content>
