<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Blue Buffalo Home 4 the Holidays - Contact Information | Helen Woodward Animal Center" debug="false" %>

<script runat="server">

	Sub Page_Load(sender As Object, e As EventArgs)
	

End Sub


</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
  <meta name="description" content="Have a question about Blue Buffalo Home 4 the Holidays? Feel free to call or email Helen Woodward Animal Center." />
  <meta name="keywords" content="pet adoption, animal shelters, animal shelter marketing, pet adoption marketing, pet adoption events, Blue Buffalo, Helen Woodward Animal Center, Home 4 the Holidays, Mike Arms" />

</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >We're Here To Help</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Blue  Buffalo Home 4 the Holidays Contact Information<br></h1>

<asp:Label ID="lblThanks" runat="server"  Visible="false"/>
<div  ID="pnlIntro" runat="server">
<p>    Thanks for visiting our Blue Buffalo Home 4 the Holidays  website! We appreciate your interest in increasing adoptions around the world.</p>
  <p><strong>General Questions about Blue Buffalo Home 4  the Holidays</strong><br>
    Phone  number: 858-756-4117, ext. 302<br>
    <a href="mailto:LauraS@animalcenter.org?Subject=Blue Buffalo Home 4 The Holidays Inquiry">General email inquiries</a></p>
  <p><strong>Home 4 the Holidays Website or Login Issues</strong><br>
    <a href="Mailto:h4th@animalcenter.org?subject=H4TH Technology Inquiry">Technology inquiries email</a></p>
  <!--<p><strong>Home 4 the Holidays Adoption Pack /  Shipping Inquiries</strong><br>
    Phone  number: TBD<br>
    Click here  for adoption pack/shipping inquiry email [goes to BB  when they have it?]</p>-->
</div>
</asp:content>
