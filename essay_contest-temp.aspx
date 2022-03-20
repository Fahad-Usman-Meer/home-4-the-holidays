<% @ Page Language="VB" MasterPageFile="~/home4theholidays/template.master" Title="Enter a Writing Contest - Dog Story or Cat Story |  Home 4 the Holidays" debug="true" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SQLClient" %>

<script runat="server">
sub page_load (obj as object, e as eventargs)
	Dim db as new HWAC.database
	dim isql as string
	'Use when voting is closed
		Dim date1 As Date = Datetime.now
		Dim date2 As Date = "2/20/2014 5:00pm"
		Dim result As Integer = DateTime.Compare(date1, date2)
			
		if result>0 then 'later
			lblmessage.text="<center>Voting is now closed. Thank you for participating!</center>"
			btnVote.visible=false
			form1.visible=false
		else
			if request.QueryString("verify")<>"" then 'for verification
				isql="UPDATE tblIH4THEssay_Votes_2013 SET Verified=1, Verification_ip='" & request.ServerVariables("REMOTE_ADDR") & "', Verification_date='" & datetime.now() & "' where UniqueID='" & request.QueryString("verify") & "'"
			db.Executenonquery(isql)
				lblmessage.text="Thank you for your vote!  Your vote has been verified."
			end if
		end if

	'lookup vote totals
		isql="SELECT COUNT_BIG(*) AS VoteCount, Vote_For FROM tblIH4THEssay_Votes_2013 WHERE(Verified = 1) GROUP BY Vote_For ORDER BY Vote_For"
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
						'if objreader("Vote_For")=11 then lblVote11.text=objreader("Votecount")
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
			'if rbStory11.checked then intvotedfor=11
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
			isql="Select EntryDate FROM tblIH4THEssay_Votes_2013 WHERE Voter_email='" & trim(tb_email.text) & "" & "'"
			objReader=db.GetReader(iSql)
				if objreader.hasrows() then 'already voted
						while objreader.read()
						lblmessage.text="There was already a vote cast by this email on " & objreader("EntryDate") & ". Thank you for voting!"	
						end while
						objreader.close()
						exit sub
				else 'not voted yet
					isql="INSERT INTO tblIH4THEssay_Votes_2013 (Vote_For, Voter_Email, Voter_ip, UniqueID) VALUES (" & intVotedFor & ",'" & tb_email.text & "','" & request.ServerVariables("REMOTE_ADDR") & "','" & strID & "')"
					db2.executenonquery(isql)
				end if 
	'send email for verification
		 Dim EM as new HWAC.EMailMessage()
						EM.From=" Home 4 The Holidays <h4thnews@animalcenter.org>"
						EM.Subject="Please Verify Your Vote"
						EM.MailTo=tb_email.text
						EM.BCC="lonjones@hotmail.com"
						EM.Body="<table width=500 border=1 align=center cellpadding=4><tr><td><img src=http://www.animalcenter.org/home4theholidays/_images/H4TH-logo2013BB.jpg align=right /><p>Thank you for your vote!<p><br/>Please <a href=""http://www.animalcenter.org/home4theholidays/essay_contest.aspx?verify=" & strID & """ >Click here</a>  to verify your vote.</td></tr></table>"
						
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
 
<h1 class="grn_ttl_blg">Vote For Your Favorite Heartwarming Adoption Story!<br>
</h1>
														  <div align="left">
														   
                                                              <p>One lucky animal organization, participating in this year&rsquo;s  Home 4 the Holidays campaign, will receive a&nbsp;$500 prize if their  heartwarming adoption story receives the most votes. <br />
We have nine finalists, with ten amazing heartwarming  stories this year. <strong>Each story  illustrates each animal&rsquo;s unique journey; journeys that begin in abandonment,  betrayal, or serious medical issues, and end in fulfillment, safety and most  importantly, a loving home.&nbsp;</strong></p>
                                                              <p><strong>Voting Guidelines</strong></p>
                                                      <ul>
                                                                <li>Voting begins Tuesday, 2/11/2014, at 10 a.m.,  and ends 2/20/2014, at 5 p.m. (all times PDT)</li>
                                                                <li>Only one vote per email, so make it count!</li>
                                                                <li>You will be sent a validation email to confirm  your vote.</li>
                                                              </ul>
                                                              <p>Remember to read through each entry to see the good work our  Home 4 the Holidays partner organizations are doing for orphan pets. &nbsp;&nbsp;Now on to the stories&hellip;</p>
                                                              <p><strong>Note: You will be sent an email to verify your vote. Remember to check your email.</strong></p>
                                                            <p>
                                                              <asp:Label ID="lblmessage" runat="server" Font-Bold="true" ForeColor="#FF0000"/>                                                                                                                          </p>
                              <form runat="server" id="form1"> <table width="100%" border="0" cellspacing="3" cellpadding="3">
                                                                <tr>
                                                                  <td colspan="5">&nbsp;</td>
                                                                </tr>

                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory1" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote1" runat="server" Text="0"  CssClass="votes"/>
                                                                    <br />
                                                                  votes</td>
                                                                  <td valign="middle"><a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/2/" target="_blank"><img src="_images/stories-2013/Drainpipe Puppies.jpeg" width="200" height="200" /> </a></td>
                                                                  <td><p><strong>The Drainpipe Puppies</strong></p>
                                                                    <p>A litter of puppies was discovered huddling in a drainpipe  in Louisiana. Thanks to the help of a global online community, and one generous  pilot, these puppies were flown to their forever families!                                                                            <br />
                                                                      <a href="http://helenwoodwardanimalcenter.wordpress.com/2014/02/11/vote-for-the-most-heartwarming-adoption-story/2/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory2" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote2" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                  votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/3/" target="_blank"><img src="_images/stories-2013/Zeus 3.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Zeus</strong></p>
                                                                    <p>Kane, an emaciated German Shorthaired Pointer was found  severely starved and wounded. It was obvious that his frail body was broken,  and so was his spirit. Thanks to the generosity of a kind family, Kane, now  named Zeus, has a bright future of love and happiness ahead of him!                                                                            <br />
                                                                      <a href="http://helenwoodwardanimalcenter.wordpress.com/2014/02/11/vote-for-the-most-heartwarming-adoption-story/3/" target="_blank">--&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory3" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote3" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                  votes</td>
                                                                  <td><img src="_images/stories-2013/H4TH Bullet (1).png" width="200" height="200" /></td>
                                                                 <td><p><strong>Bullet</strong></p>
                                                                   <p> A story of true canine courage! Bullet was a stray in a rural area,  living in the woods with a pack of dogs that was like his family. No one liked  the stray dogs so someone used them as target practice. Bullet was shot, but  then recovered to find a loving forever family.<br />
                                                                     <a href="http://helenwoodwardanimalcenter.wordpress.com/2014/02/11/vote-for-the-most-heartwarming-adoption-story/4/" target="_blank">--&gt;Full Story</a></p>                                                                   </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory4" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote4" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/5/" target="_blank"><img src="_images/stories-2013/Charles.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Charles</strong></p>
                                                                    <p> A kitten is found lifeless in the grass and left in a plastic bucket,  with no food or water. He was so weak he could hardly walk! But Charles didn&rsquo;t  give up and neither did his rescuers! <br />
                                                                      <a href="http://helenwoodwardanimalcenter.wordpress.com/2014/02/11/vote-for-the-most-heartwarming-adoption-story/5/" target="_blank">--&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory5" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote5" runat="server" Text="0"  CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td valign="middle"><a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/6/" target="_blank"><img src="_images/stories-2013/Week 8 - Red 1.jpg" width="200" height="167" /></a></td>
                                                                  <td><p><strong>Red</strong></p>
                                                                    <p>Dragged on the side of a rural highway, kicked, then dumped,  but then&hellip; adopted! Red now has a life every dog dreams of!                                                                            <br />
                                                                      <a href="http://helenwoodwardanimalcenter.wordpress.com/2014/02/11/vote-for-the-most-heartwarming-adoption-story/6/" target="_blank">--&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory6" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote6" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/7/" target="_blank"><img src="_images/stories-2013/Week 9 - Pepper Sir Goober 2.JPG" width="200" height="149" /></a></td>
                                                                  <td><p><strong>Sir Goober Cat</strong> </p>
                                                                    <p>In the aftermath of a life-changing car accident, Michael was in need  of a &ldquo;buddy&rdquo; to see him through the hard times. Little did he know that a  special little kitten with a matching condition would help him heal, too.<br />
                                                                      <a href="http://helenwoodwardanimalcenter.wordpress.com/2014/02/11/vote-for-the-most-heartwarming-adoption-story/7/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory7" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote7" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/8/" target="_blank"><img src="_images/stories-2013/Week 10 - Charity 1.jpg" width="200" height="240" /></a></td>
                                                                  <td><p><strong>Charity</strong></p>
                                                                    <p> Charity and her three kittens were rescued in -30 degree  temperatures. After becoming MEOW Foundation&rsquo;s Home 4 the Holidays  &ldquo;spokeskitty&rdquo;, and waiting five years, this gorgeous gal found a purrfect  forever family!<br />
                                                                      <a href="http://helenwoodwardanimalcenter.wordpress.com/2014/02/11/vote-for-the-most-heartwarming-adoption-story/8/" target="_blank">--&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory8" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote8" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/9/" target="_blank"><img src="_images/stories-2013/week 11 - turtle.jpg" width="200" height="150" /></a></td>
                                                                  <td><p><strong>Turtle</strong></p>
                                                                    <p> Turtle was rescued off the streets by a good Samaritan. He had a  badly broken leg and needed a safe and secure place so he could heal. After a  stint in a loving foster, this playful kitty found a loving forever home in the  town&rsquo;s feed store &ndash; he is now the town&rsquo;s favorite store clerk! <br />
                                                                      <a href="http://helenwoodwardanimalcenter.wordpress.com/2014/02/11/vote-for-the-most-heartwarming-adoption-story/9/" target="_blank">--&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory9" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote9" runat="server" Text="0"  CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td valign="middle"><a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/10/" target="_blank"><img src="_images/stories-2013/Jamie.jpg" width="200" height="133" /></a></td>
                                                                  <td><p><strong>Jamie</strong></p>
                                                                    <p> Most of Jamie&rsquo;s short, one-year-of-life, was filled with loneliness  and neglect. She was discovered in her owner&rsquo;s apartment, emaciated and frail,  tied to a couch with a two-foot piece of rope. Jamie was rescued from her  abuser, and after three months of rehabilitation, found a wonderful forever  home.<br />
                                                                      <a href="http://helenwoodwardanimalcenter.wordpress.com/2014/02/11/vote-for-the-most-heartwarming-adoption-story/10/" target="_blank">--&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory10" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote10" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/11/" target="_blank"><img src="_images/stories-2013/Petey.jpg" width="200" height="166" /></a></td>
                                                                  <td><p><strong>Petey</strong></p>
                                                                    <p> Petey was the victim of a hoarder and was found in a littered  backyard with barely enough protection from the elements to survive. He had  almost no hair, few teeth and an agonizing skin condition. Thanks to his  rescuers, and one very special animal welfare advocate, Petey found a loving  home where he lavishes in love every day!<br />
                                                                      <a href="http://helenwoodwardanimalcenter.wordpress.com/2014/02/11/vote-for-the-most-heartwarming-adoption-story/11/" target="_blank">--&gt;Full Story</a></p>                                                                    </td>
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
