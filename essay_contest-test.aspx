<% @ Page Language="VB" MasterPageFile="~/home4theholidays/template.master" Title="Pet Adoption Stories - Most Heartwarming Story Contest | Helen Woodward Animal Center" debug="false" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SQLClient" %>

<script runat="server">
sub page_load (obj as object, e as eventargs)
	Dim db as new HWAC.database
	dim isql as string
	'Use when voting is closed
		Dim date1 As Date = Datetime.now
		Dim date2 As Date = "2/18/2015 4:00pm"
		Dim result As Integer = DateTime.Compare(date1, date2)
			response.Write(result)
		if result>0 then 'later
			lblmessage.text="<font color=""red""><center><h1><b>Voting is now closed. Thank you for participating!</b></h1></center></font>"
			btnVote.visible=false
			'form1.visible=false
		else
			if request.QueryString("verify")<>"" then 'for verification
				isql="UPDATE tblIH4THEssay_Votes_2014 SET Verified=1, Verification_ip='" & request.ServerVariables("REMOTE_ADDR") & "', Verification_date='" & datetime.now() & "' where UniqueID='" & request.QueryString("verify") & "'"
			db.Executenonquery(isql)
				lblmessage.text="Thank you for your vote!  Your vote has been verified."
			end if
		end if

	'lookup vote totals
		isql="SELECT COUNT_BIG(*) AS VoteCount, Vote_For FROM tblIH4THEssay_Votes_2014 WHERE(Verified = 1) GROUP BY Vote_For ORDER BY Vote_For"
	'display vote totals
			dim objReader as SQLdatareader
			objReader=db.GetReader(iSql)
				if objreader.hasrows() then 'display votes
					while objreader.read()
						if objreader("Vote_For")=1 then lblVote1.text=objreader("Votecount")
						if objreader("Vote_For")=2 then lblVote2.text=objreader("Votecount")
						if objreader("Vote_For")=3 then lblVote3.text=objreader("Votecount")
						if objreader("Vote_For")=4 then lblVote4.text=objreader("Votecount")
						if objreader("Vote_For")=5 then lblVote5.text=objreader("Votecount")
						if objreader("Vote_For")=6 then lblVote6.text=objreader("Votecount")
						if objreader("Vote_For")=7 then lblVote7.text=objreader("Votecount")
						if objreader("Vote_For")=8 then lblVote8.text=objreader("Votecount")
						if objreader("Vote_For")=9 then lblVote9.text=objreader("Votecount")
						if objreader("Vote_For")=10 then lblVote10.text=objreader("Votecount")
						if objreader("Vote_For")=11 then lblVote11.text=objreader("Votecount")
						'if objreader("Vote_For")=12 then lblVote12.text=objreader("Votecount")
						'if objreader("Vote_For")=13 then lblVote13.text=objreader("Votecount")
						'if objreader("Vote_For")=14 then lblVote14.text=objreader("Votecount")
						'if objreader("Vote_For")=15 then lblVote15.text=objreader("Votecount")
						'if objreader("Vote_For")=16 then lblVote16.text=objreader("Votecount")
						'if objreader("Vote_For")=17 then lblVote17.text=objreader("Votecount")
						'if objreader("Vote_For")=18 then lblVote18.text=objreader("Votecount")
						
					end while
				end if
			objreader.close()
	
end sub
Sub btnVote_Click(obj as object, e as eventargs)
	if session("Voted")="Yes" then 
		lblmessage.text="There was already a vote cast by you. Thank you for voting!"	
		exit sub 'slowing down spammers
	end if
	
			dim objReader as SQLdatareader
			Dim db as new HWAC.database
			Dim db2 as new HWAC.database
			dim isql as String
			dim intVotedFor as integer=0
			dim strID as string=GetUniqueID(10)
			if rbStory1.checked then intvotedfor=1
			if rbStory2.checked then intvotedfor=2
			if rbStory3.checked then intvotedfor=3
			if rbStory4.checked then intvotedfor=4
			if rbStory5.checked then intvotedfor=5
			if rbStory6.checked then intvotedfor=6
			if rbStory7.checked then intvotedfor=7
			if rbStory8.checked then intvotedfor=8
			if rbStory9.checked then intvotedfor=9
			if rbStory10.checked then intvotedfor=10
			if rbStory11.checked then intvotedfor=11
			'if rbStory12.checked then intvotedfor=12
			'if rbStory13.checked then intvotedfor=13
			'if rbStory14.checked then intvotedfor=14	
			'if rbStory15.checked then intvotedfor=15
			'if rbStory16.checked then intvotedfor=16
			'if rbStory17.checked then intvotedfor=17
			'if rbStory18.checked then intvotedfor=18
			
			if intVotedFor=0 then 
				lblmessage.text="You must choose a story for which to vote."
				exit sub
			end if

	'record vote-verification
		'look to see if email already registered
			isql="Select EntryDate FROM tblIH4THEssay_Votes_2014 WHERE Voter_email='" & trim(tb_email.text) & "" & "'"
			objReader=db.GetReader(iSql)
				if objreader.hasrows() then 'already voted
						while objreader.read()
						lblmessage.text="There was already a vote cast by this email on " & objreader("EntryDate") & ". Thank you for voting!"	
						end while
						objreader.close()
						exit sub
				else 'not voted yet
					isql="INSERT INTO tblIH4THEssay_Votes_2014 (Vote_For, Voter_Email, Voter_ip, UniqueID) VALUES (" & intVotedFor & ",'" & tb_email.text & "','" & request.ServerVariables("REMOTE_ADDR") & "','" & strID & "')"
					db2.executenonquery(isql)
				end if 
	'send email for verification
		 Dim EM as new HWAC.EMailMessage()
						EM.From=" Home 4 The Holidays <h4thnews@animalcenter.org>"
						EM.Subject="Please Verify Your Vote"
						EM.MailTo=tb_email.text
						EM.BCC="lonjones1972@gmail.com"
						EM.Body="<table width=500 border=1 align=center cellpadding=4><tr><td><img src=http://www.animalcenter.org/home4theholidays/_images/H4TH-logo2013BB--email.jpg align=right /><p>Thank you for your vote!<p><br/>Please <a href=""http://www.animalcenter.org/home4theholidays/essay_contest.aspx?verify=" & strID & """ >Click here</a>  to verify your vote.</td></tr></table>"
						
						 Try
							EM.Send_Email(EM)
							'lblmessage.text=strdata
						 Catch ex as exception
							lblmessage.text="There was a problem emailing your information, please try again"
							exit sub
						 end try
	'verification message
		lblmessage.text="Thank you for your vote!  Please check your email to complete the voting process in order for your vote to be counted!"
	session("Voted")="Yes"
end sub

Public Function GetUniqueID(ByVal length as Integer) as String  
  'Get the GUID
  Dim guidResult as String = System.Guid.NewGuid().ToString()
  
  'Remove the hyphens
  guidResult = guidResult.Replace("-", String.Empty)
  
  'Make sure length is valid
  If length <= 0 OrElse length > guidResult.Length Then
    Throw New ArgumentException("Length must be between 1 and " & guidResult.Length)
  End If
  
  'Return the first length bytes
  Return guidResult.Substring(0, length)
End Function

</script>


<asp:Content ID="HeadContent" ContentPlaceHolderID="HeadContent" runat="server">
<meta name="description" content="Blue Buffalo Home 4 the Holidays will award $1,000 to a partner organization’s pet adoption story. Submit an adoption story for a chance to win!" />
  <meta name="keywords" content="pet adoption, dog stories, cat stories, pet stories, pet adoption successes, animal shelter stories, Blue Buffalo Home 4 the Holidays, Home 4 the Holidays, Helen Woodward Animal Center" />
    <style type="text/css">
<!--
.votes {
font-weight: bold;
font-size:16px;

}

-->
  </style>
</asp:content>
<asp:Content ID="Content1" ContentPlaceHolderID="PageTitle" Runat="Server" >Essay Contest</asp:content>

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" ></asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg"><strong>Blue  Buffalo Home 4 the Holidays Success Story Contest</strong><br>
</h1>
														  <div align="left">
														    <p>Vote for  your favorite heartwarming story from the Blue Buffalo Home 4 the Holidays  adoption campaign. The winner will receive $1,000 for their pet adoption  organization!</p>
                                                            <p>Pet rescue  and adoption organizations participating in the&nbsp;2014 Blue Buffalo Home 4  the Holidays pet adoption campaign&nbsp;sent us amazing pet adoption stories!  Every story was heartfelt, passionate and inspiring. It was a tough decision to  settle on our finalists because each organization works so hard to find loving,  forever families for the orphan pets. </p>
                                                            <p>We leave it  in your hands now. <strong>Vote for your  favorite Heartwarming Story and the winning organization wins a $1,000 prize.</strong> You can only vote once &ndash; so make it count! </p>
                                                            <p><strong><em>Note:  You will be sent an email to verify your vote. Remember to check your email.</em></strong></p>
<h2>&nbsp;</h2>
                                                            <p>
                                                            <asp:Label ID="lblmessage" runat="server" Font-Bold="true" ForeColor="#FF0000"/>                                                                                                                          </p>
                              <form runat="server" id="form1" visible="True">
                                <table width="100%" border="0" cellspacing="3" cellpadding="3">
                                                                <tr>
                                                                  <td colspan="5">&nbsp;</td>
                                                                </tr>

                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory1" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote1" runat="server" Text="0"  CssClass="votes"/>
                                                                    <br />
                                                                  votes</td>
                                                                  <td valign="middle"><a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/2/" target="_blank"><img src="_images/Stories-2014/Gentle Ben - H4TH Story.jpg" width="200" height="207" /> </a></td>
                                                                  <td><h3>Gentle Ben</h3>
                                                                    <p> <strong>Shelter Transport Animal Rescue Team  (S.T.A.R.T.)</strong><br>
                                                                    A black  Labrador Retriever was found living in squalor in the hot, desert sun. His  gentle nature earned him the name &ldquo;Gentle Ben,&rdquo; and he now looks after his  loving forever family!<br>
                                                                    <a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/2/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory2" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote2" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                  votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/3/" target="_blank"><img src="_images/Stories-2014/Raisin - H4TH Story.jpg" width="200" height="200" /></a></td>
                                                                  <td><h3>Raisin</h3>
                                                                    <p> <strong>Animal Outreach of the Mother Lode</strong><br>
                                                                  After losing  his beloved wife and dog, a grieving man finds a new forever friend in a sweet  and loving feline. It was love at first sight!<br>
                                                                  <a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/3/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory3" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote3" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                  votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/4/"><img src="_images/Stories-2014/Velvet and Carl - H4TH Story.jpg" width="200" height="151" /></a></td>
                                                                 <td><h3>Velvet and Carl</h3>
                                                                   <p> <strong>Forever Home Feline Ranch</strong><br>
                                                                  Tragedy  brings two families together: one family lost a beloved husband, the other lost  a cherished cat. Their newly found connection helps rescue two cats named  Velvet and Carl. <br>
                                                                  <a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/4/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory4" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote4" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/5/" target="_blank"><img src="_images/Stories-2014/Tali - H4TH Story.jpg" width="199" height="184" /></a></td>
                                                                  <td><h3>Tali</h3>
                                                                    <p> <strong>Gateway Pet Guardians</strong><br>
                                                                      Tali had a  rough life on the street. After her rescue and recovery, she wins the hearts  and minds of everyone she meets&hellip; with her toy pig!<br>
<a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/5/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory5" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote5" runat="server" Text="0"  CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td valign="middle"><a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/6/" target="_blank"><img src="_images/Stories-2014/Ollie - H4TH Story.jpg" width="200" height="167" /></a></td>
                                                                  <td><h3>Ollie</h3>
                                                                    <p> <strong>The Society for the Improvement of  Conditions for Stray Animals (S.I.C.S.A.)</strong><br>
                                                                  Ollie was  destined for great things! After he was pulled from an overburdened animal  shelter, Ollie finds his perfect life match at an assisted living facility  where he brings all he meets comfort and happiness. <br>
                                                                  <a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/6/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory6" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote6" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/7/" target="_blank"><img src="_images/Stories-2014/Zonder - H4TH Story.jpg" width="200" height="251" /></a></td>
                                                                  <td><h3>Zonder</h3>
                                                                    <p> <strong>Friends of Rescue</strong><br>
                                                                  Zonder, deaf  and blind, was utterly alone in the shelter before he was rescued. After 10  weeks of rehabilitation and love, Zonder found a wonderful forever home!<br>
                                                                  <a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/7/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory7" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote7" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/8/" target="_blank"><img src="_images/Stories-2014/Aaron - H4TH Story.jpg" width="200" height="195" /></a></td>
                                                                  <td><h3>Aaron</h3>
                                                                    <p> <strong>P.A.W.S. of Central Louisiana</strong><br>
                                                                  A young dog,  plucked from an animal facility with only hours to spare, rescues his adopted  family right back!<br>
                                                                  <a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/8/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory8" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote8" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/9/" target="_blank"><img src="_images/Stories-2014/Lela and Ren - H4TH Story.jpg" width="200" height="193" /></a></td>
                                                                  <td><h3>Lela and Ren</h3>
                                                                    <p> <strong>Pet Placement Center</strong><br>
                                                                  Lela and Ren  were inseparable. Lela relied on Ren to help her build confidence and Ren  needed Lela&rsquo;s gentle, nurturing spirit. After searching for a family for seven  years, they found the perfect home &ndash; TOGETHER!<br>
                                                                  <a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/9/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory9" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote9" runat="server" Text="0"  CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td valign="middle"><a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/10/" target="_blank"><img src="_images/Stories-2014/Bodie - H4TH Story.jpg" width="200" height="224" /></a></td>
                                                                  <td><h3>Bodie</h3>
                                                                    <p> <strong>Save One Soul Animal Rescue League</strong><br>
                                                                  One woman  recovering from the death of her son. One dog struggling to find that perfect  home. Destiny brought them together.<br>
                                                                  <a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/10/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory10" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote10" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/11/" target="_blank"><img src="_images/Stories-2014/Conor - H4TH Story.jpg" width="200" height="205" /></a></td>
                                                                  <td><h3>Conor</h3>
                                                                    <p> <strong>Safe Haven of Iowa County</strong><br>
                                                                  Starving,  sad, suffering. Conor finds himself in dire straits before his rescue. Now he  is doted on by a little girl who adores him night and day!<br>
                                                                  <a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/11/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory11" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote11" runat="server" Text="0" CssClass="votes"/>                                                                  
                                                                    <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/12/" target="_blank"><img src="_images/Stories-2014/Katt - H4TH Story.jpg" width="200" height="229" /></a></td>
                                                                  <td><h3>Katt</h3>
                                                                    <p> <strong>Home Furever Rescue</strong><br>
                                                                      After her  rescue off the streets of Detroit, Katt waited two years to find a forever  family. Now she has a warm, loving home and a new sibling to play with!<br>
<a href="http://helenwoodwardanimalcenter.wordpress.com/2015/02/09/2014-most-heartwarming-story-contest/12/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td colspan="4">&nbsp;</td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td colspan="4">*Your email: 
                                                                    <asp:TextBox  runat="server" ID="tb_email" Width="150" MaxLength="150" Wrap="false" TextMode="SingleLine"/>                                                                    
                                                                    &nbsp;
                                                                    <asp:regularexpressionvalidator runat="server" controltovalidate="tb_Email" 
					validationexpression="^(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6}$" 
					errormessage="*That is not a valid email" 
					display="dynamic"/>                                                                    
                                                                    <asp:RequiredFieldValidator runat="server" ControlToValidate="tb_Email" 	ErrorMessage="*Email is required" Display="Dynamic"/></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td colspan="4"><asp:Button runat="server" ID="btnVote" Text="Cast Your Vote!" OnClick="btnVote_click"/></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td colspan="4"> Get more heroic and inspiring adoption stories delivered to your inbox.&nbsp;<a href="http://eepurl.com/oOmMT" target="_blank">Click here</a>&nbsp;to sign up for our newsletter. &nbsp; <br />
                                                                  <br /></td>
                                                               </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td colspan="4"><p>Please contact <a href="mailto:h4thnews@animalcenter.org">h4thnews@animalcenter.org</a> if you have questions or issues with the voting process. </p></td>
                                                               </tr>
                                                              </table>
                                                            </form>
                                                              <p>&nbsp;</p>
  </div>
</asp:content>
