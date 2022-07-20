<% @ Page Language="VB" MasterPageFile="~/template.master" Title=" Home 4 The Holidays FAQ" debug="true" %>

<script runat="server">
sub page_load (obj as object, e as eventargs)

	
end sub
</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<script type="text/javascript"> 

var textBlocks = new Array( 'Select from the list to change this box', '<p>The success of  Home 4 the Holidays worldwide will contribute to your success in finding loving, forever homes for the orphaned pets in your shelter or rescue group. You are not alone!<p><p>By joining IH4TH you tell potential adopters that you are part of the largest and most successful pet adoption drive in the history of the planet. Your local news media will have no choice but to help you spread the word that you are serious about saving lives and ending euthanasia.</p>','<p>First,   let&rsquo;s make it 100% clear that your participation in  Home 4 the   Holidays is absolutely FREE! No hidden cost. No contract to sign. You   don&rsquo;t have to sell or promote anything. It&rsquo;s FREE! </p>                                                            <p>As a registered    Home 4 the Holidays participant you&rsquo;ll have online access to the &quot;How-To   Guidelines&quot; including materials that you can use to contact your   local news media, proven successful ideas for pet adoption events, fill-in-the-blank   news releases and governmental proclamations, and other materials to   help you be successful. </p>                                                            <p>You will receive your   own IH4TH online web pages to use in promoting pet adoptions and to   keep track of your adoption success. </p>                                                            <p>Your local radio and   television stations will be able to download IH4TH Public Service Announcements   recorded by by Helen Woodward Animal Center President Mike Arms. </p>                                                            <p>You will also receive    &quot;Starter Kits&quot; (while your supplies last) to help your   adopters get started &ldquo;on the right paw&rdquo; with their new pets. </p>                                                            <p>Oh. And did we mention   that your participation in IH4TH is FREE? That&rsquo;s right. It costs you   nothing. Nada. Zip. Zilch. FREE!</P>','<p>Simply register   to let us know that you are serious about saving the lives of orphan   pets and taking business away from backyard breeders and puppy mills   during their most successful time of year....the holiday season. </p>                                                            <p>Log on to the    Home 4 the Holidays &quot;How-To Guidelines&quot; for tips on how you   get started, then get ready to send pets home with their new families. </p>                                                            <p>Home 4 the Holidays   will send news releases to your local news media informing them that   you are part of the largest and most successful pet adoption drive in   history. After that you&rsquo;ll have the opportunity to work with the media   to encourage families to adopt an orphan pet by visiting your shelter   or attending your upcoming adoption events. </p>                                                            <p>We also ask that you   take a couple minutes once each week to report your adoptions for the   week. The easiest way to do this is through your free profile page.   You can use it to keep track of your adoptions and it will automatically   report your weekly results. You can also report your results through   e-mail, phone, or fax. </p>','<p>In the past   many animal shelters discouraged pet adoption during the holiday season   for fear that families were making knee-jerk, emotional decisions and   the pets would be returned after the new year begins.</p>                                                            <p>It is well known that more families invite new pets into their homes during the holiday season than at any other time of year. </p>                                                            <p>If Mom and Dad have   promised the kids a puppy for Christmas, and the animal shelter or rescue   group turns them away, we may as well draw that family a map showing   them how to get to the nearest pet store, backyard breeder, or puppy   mill. </p>                                                            <p>They WILL get a new   pet. They just WON&rsquo;T be getting it from us. </p>                                                            <p>The best thing we can   do is help them to make an informed decision and to match them with   the pet that fits their lifestyle, their family, and their home. If   we remain dedicated to completing quality, lifelong adoptions (the same   as we are the rest of the year) there is no reason for any of these   pets to be returned.</p>                                                            <p> Home 4 the Holidays   proves this year after year. </p>                                                            <p>One more point for   clarification. Walking past the window of the puppy store in the mall   and saying, &ldquo;Let&rsquo;s get a puppy!&rdquo; is a knee-jerk decision. Making   a decision to drive to a shelter or adoption event to find your new   pet is not. </p>                                                            <p>And as for those who   say that getting a pet is an emotional experience&hellip;YES! It is! Finding   your new best friend and making a lifelong commitment is emotional.   We wouldn&rsquo;t want it any other way.</p>','<p> Home 4 the Holidays Adoption Kits are being shipped during the week of Sept 26-Sept 30.<u></u><u></u></p><p>To receive the adoption kits, your organization must have confirmed its continued participation for the 2011 campaign.&nbsp; You can confirm your participation by calling the Consumer Care line at 1-800-421-6456.<u></u><u></u></p><p>If you are a new registrant, please sign up <a href="register.aspx">here</a>.</p><p>There will be a second shipment of kits on November 1 for those organizations who sign up by October 31 (new registrants) or confirm their current year participation by October 31 (for prior participants, by updating 2012 goals or calling 1-800-421-6456 to confirm participation).</p>','<p>You   can download and print an unlimited amount of official IH4TH posters   on H4TH.com by <a href="https://join.home4theholidays.org/downloads.aspx" target="_blank">clicking   here</a> </p>','<p><strong>As a registered   H4TH participant you can </strong>download and print as many of the official   IH4TH How-to Guides as you need by <a href="https://join.home4theholidays.org/downloads.aspx" target="_blank">clicking   here</a></p>','<p>While we do need mailing and shipping information to send you H4TH materials such as the How-to guide and Adoption Kits, you can choose to hide that information from your personal profile to prevent public viewing when you <a href="members/Profile.aspx">edit your profile</a></p>'); 

function changetext(elemid) { 
var ind = document.getElementById(elemid).selectedIndex; 
document.getElementById("display").innerHTML=textBlocks[ind]; 
} 
</script> 
  
</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" > Home 4 The Holidays FAQ</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Frequently Asked Questions<br></h1>
														  <div class="feature">
														 
                                                            <form>
                                                              <select id="whatever" onchange="changetext('whatever');">
                                                                <option value="0">Select a question from the list</option>
                                                                <option value="1">Why join h4th?</option>
                                                                <option value="2">What do I get? </option>
                                                                <option value="3">What is required of me? </option>
                                                                <option value="4">Are holiday adoptions really a good idea? </option>
                                                                <option value="5">How do I get my adoption kits?</option>
                                                                <option value="6">Can I get a H4TH poster? </option>
                                                                <option value="7">Can I get another copy of the How-to Guide? </option>
                                                                <option value="8">I have personal information that I do not want displayed in my profile. </option>
                                                              </select>
                                                              <br>
                                                            </form>
                                                            <div id="display">Select a question from the list.</div>
                                                            
  </div>
														</asp:content>


