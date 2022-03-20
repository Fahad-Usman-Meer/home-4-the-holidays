<% @ Page Language="VB" MasterPageFile="~/home4theholidays/template.master" Title="Enter a Writing Contest – Dog Story or Cat Story | Iams Home 4 the Holidays" debug="true" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SQLClient" %>

<script runat="server">
sub page_load (obj as object, e as eventargs)
	Dim db as new HWAC.database
	dim isql as string
	'Use when voting is closed
		Dim date1 As Date = Datetime.now
		Dim date2 As Date = "2/22/2013 5:00pm"
		Dim result As Integer = DateTime.Compare(date1, date2)
			
		if result>0 then 'later
			lblmessage.text="<center>Voting is now closed. Thank you for participating!</center>"
			btnVote.visible=false
			form1.visible=false
		else
			if request.QueryString("verify")<>"" then 'for verification
				isql="UPDATE tblIH4THEssay_Votes_2012 SET Verified=1, Verification_ip='" & request.ServerVariables("REMOTE_ADDR") & "', Verification_date='" & datetime.now() & "' where UniqueID='" & request.QueryString("verify") & "'"
			db.Executenonquery(isql)
				lblmessage.text="Thank you for your vote!  Your vote has been verified."
			end if
		end if

	'lookup vote totals
		isql="SELECT COUNT_BIG(*) AS VoteCount, Vote_For FROM tblIH4THEssay_Votes_2012 WHERE(Verified = 1) GROUP BY Vote_For ORDER BY Vote_For"
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
			isql="Select EntryDate FROM tblIH4THEssay_Votes_2012 WHERE Voter_email='" & trim(tb_email.text) & "" & "'"
			objReader=db.GetReader(iSql)
				if objreader.hasrows() then 'already voted
						while objreader.read()
						lblmessage.text="There was already a vote cast by this email on " & objreader("EntryDate") & ". Thank you for voting!"	
						end while
						objreader.close()
						exit sub
				else 'not voted yet
					isql="INSERT INTO tblIH4THEssay_Votes_2012 (Vote_For, Voter_Email, Voter_ip, UniqueID) VALUES (" & intVotedFor & ",'" & tb_email.text & "','" & request.ServerVariables("REMOTE_ADDR") & "','" & strID & "')"
					db2.executenonquery(isql)
				end if 
	'send email for verification
		 Dim EM as new HWAC.EMailMessage()
						EM.From="Iams Home 4 The Holidays <h4thnews@animalcenter.org>"
						EM.Subject="Please Verify Your Vote"
						EM.MailTo=tb_email.text
						EM.BCC="lonjones@hotmail.com"
						EM.Body="<table width=500 border=1 align=center cellpadding=4><tr><td><img src=http://www.animalcenter.org/_images/events/h4th/Home4holiday_logo2008.jpg width=225 height=67 align=right /><p>Thank you for your vote!<p><br/>Please <a href=""http://www.animalcenter.org/home4theholidays/essay_contest.aspx?verify=" & strID & """ >Click here</a>  to verify your vote.</td></tr></table>"
						
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

    
<asp:content ID="navigation" contentplaceholderId="Leftnav" runat="server" >
<img src="http://www.animalcenter.org/_images/events/h4th/call800.gif" width="140" height="128">
</asp:content>
<asp:Content ID="Content3" ContentPlaceHolderID="maincontent" Runat="Server" >
 
<h1 class="grn_ttl_blg">Vote Now For Your Favorite Heartwarming Story from Iams Home 4 the Holidays<br></h1>
														  <div align="left">
														   
                                                              <p>Pet rescue and adoption organizations participating in the&nbsp;2012 Iams Home 4 the Holidays pet adoption campaign&nbsp;sent us amazing pet adoption stories this year! Every story was heartfelt, passionate and inspiring. It was a tough decision to settle on our Ten Finalists because each organization works so hard to find loving, forever families for the orphaned pets.</p>
                                                              <p>We leave it in your hands now.&nbsp;Vote for your favorite Heartwarming Story and the winning organization wins a $500 prize.&nbsp;You can only vote once &ndash; so make it count!</p>
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
                                                                  <td valign="middle"><a href="http://helenwoodwardanimalcenter.wordpress.com/2012/02/14/vote-for-your-favorite-most-heartwarming-story-from-iams-home-4-the-holiday/2/" target="_blank"><img src="_images/Success-2012/Blanco.jpg" width="200" height="200" /> </a></td>
                                                                  <td><p><strong>Home &ldquo;Fur&rdquo;&nbsp;Good Animal Rescue, Phoenix, Arizona</strong></p>
                                                                    <p>Blanco was just an unruly pup eagerly awaiting a forever family. No one knew why he wouldn&rsquo;t respond to his name or voice commands. Then, it was discovered that Blanco was deaf! After learning hand signals, Blanco became a great companion for a new family.<br />
                                                                      <a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/2/" target="_blank">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory2" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote2" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                  votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2012/02/14/vote-for-your-favorite-most-heartwarming-story-from-iams-home-4-the-holiday/3/" target="_blank"><img src="_images/Success-2012/Cammie.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Ontario Feral Cat Project (OFCP), Ontario, Oregon</strong></p>
                                                                    <p>Cammie was badly injured as a kitten and needed her leg amputated. After her rehabilitation, she grew into a normal, playful kitten and never even realized she was disabled.<a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/3/" target="_blank"><br />
  --&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory3" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote3" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                  votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2012/02/14/vote-for-your-favorite-most-heartwarming-story-from-iams-home-4-the-holiday/4/" target="_blank"><img src="_images/Success-2012/Diamond.JPG" width="200" height="200" /></a></td>
                                                                 <td><p><strong>Decatur Animal Services, Decatur, Alabama&nbsp;</strong></p>
                                                                   <p>The once-beautiful, purebred Miniature Dachshund was close to death when she was found. After weeks of good food, pampering and TLC, this little girl blossomed into a glossy, healthy and happy dog. Her forever family named her &ldquo;Diamond,&rdquo;&nbsp; because she is such a little gem!<a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/4/" target="_blank"><br />
  --&gt;Full Story</a></p>                                                                   </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory4" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote4" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2012/02/14/vote-for-your-favorite-most-heartwarming-story-from-iams-home-4-the-holiday/5/" target="_blank"><img src="_images/Success-2012/Goliath.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Blount County Humane Society, Maryville, Tennessee</strong></p>
                                                                    <p>Goliath&rsquo;s family abandoned him when they moved away. He was found lying on the back porch of the house he lived in &ndash;&nbsp;but the house was empty! After Goliath&rsquo;s rescuers cared for him, he was adopted by a loving family and even has another Rottie playmate.<a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/5/" target="_blank"><br />
  --&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory5" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote5" runat="server" Text="0"  CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td valign="middle"><a href="http://helenwoodwardanimalcenter.wordpress.com/2012/02/14/vote-for-your-favorite-most-heartwarming-story-from-iams-home-4-the-holiday/6/" target="_blank"><img src="_images/Success-2012/Jasper.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Advocates 4 Animals, Xenia, Ohio</strong></p>
                                                                    <p>After he was hit by a car, Jasper&rsquo;s owners decided they just didn&rsquo;t want him anymore. After a leg amputation and weeks of rehabilitation, Jasper was adopted by a loving forever family grateful to have such a loving dog.<a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/6/" target="_blank"><br />
  --&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory6" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote6" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2012/02/14/vote-for-your-favorite-most-heartwarming-story-from-iams-home-4-the-holiday/7/" target="_blank"><img src="_images/Success-2012/Jim.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Society for the Improvement of Conditions for Stray Animals (SICSA), Kettering, Ohio</strong></p>
                                                                    <p>Jim was badly neglected. He was found with a 13 pound tow chain deeply embedded into his neck. While the veterinarian removed the chain from Jim&rsquo;s neck, Jim still needed to rehabilitate for weeks before he could find his forever family. But, eventually, he did!<a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/7/" target="_blank"><br />
  --&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory7" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote7" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2012/02/14/vote-for-your-favorite-most-heartwarming-story-from-iams-home-4-the-holiday/8/" target="_blank"><img src="_images/Success-2012/Mama Cass.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Rocky Mountain Siamese Rescue, Greeley, Colorado</strong></p>
                                                                    <p>Mama Cass was the victim of a terrible hoarding situation and had lingering setbacks. But the &ldquo;purrfect&rdquo;&nbsp;forever mom found her! Mama Cass now gives joy to her new mom, who struggles with COPD. Who is happier? It&rsquo;s hard to tell!<a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/8/" target="_blank"><br />
  --&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory8" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote8" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2012/02/14/vote-for-your-favorite-most-heartwarming-story-from-iams-home-4-the-holiday/9/" target="_blank"><img src="_images/Success-2012/Rosita.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Midogrescue Foundation, Inc., Westerlo, New York</strong></p>
                                                                    <p>Rosita was rescued from filth and despair. When she was bathed for the first time after her rescue, the fleas fell off of her by the hundreds! After rehabilitation in a foster home, she grew to become a &ldquo;normal dog&rdquo; again and was adopted six months later.<a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/9/" target="_blank"><br />
  --&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory9" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote9" runat="server" Text="0"  CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td valign="middle"><a href="http://helenwoodwardanimalcenter.wordpress.com/2012/02/14/vote-for-your-favorite-most-heartwarming-story-from-iams-home-4-the-holiday/10/" target="_blank"><img src="_images/Success-2012/Wally and Polly.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Wags and Whiskers Rescue, Latona, Kentucky</strong></p>
                                                                    <p>Wally and Polly were found abandoned by two teenage girls. After they were dumped off to a Good Samaritan (in a Wal-Mart parking lot), they needed to be flown to the Good Samaritan&rsquo;s home state&hellip; in a new designer bag! She would do anything to make sure they would survive!<a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/10/" target="_blank"><br />
  --&gt;Full Story</a></p>                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory10" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote10" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="http://helenwoodwardanimalcenter.wordpress.com/2012/02/14/vote-for-your-favorite-most-heartwarming-story-from-iams-home-4-the-holiday/11/" target="_blank"><img src="_images/Success-2012/Wyatt.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Helen Sanders CAT Paws, Seal Beach, California</strong></p>
                                                                    <p>A crowd had gathered outside a restaurant near the beach, looking down at something in the grass.&nbsp; In the wet grass lay a motionless kitten, eyes crusted shut, apparently dead. Someone lifted up the kitten and he emitted a loud cry, as if to say, &ldquo;I&rsquo;m still here!&rdquo; The kitten was rushed to receive care and, against the odds, survived to find a forever family.<br />
                                                                    <a href="http://helenwoodwardanimalcenter.wordpress.com/2013/02/11/mostheartwarmingstorycontest/11/" target="_blank">--&gt;Full Story</a></p>                                                                    </td>
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
                                                                  <td colspan="4"> Get more heroic and inspiring adoption stories delivered to your inbox.&nbsp;<a href="http://visitor.r20.constantcontact.com/manage/optin/ea?v=001JtLq2k4dXaKx9twzH40NBw%3D%3D" target="_blank">Click here</a>&nbsp;to sign up for our newsletter. &nbsp; <br />
                                                                  <br /></td>
                                                               </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td colspan="4"> Voting will begin on&nbsp;<strong>Wednesday, February 15</strong>.<strong>&nbsp;</strong><strong>The contest will end on Friday, February 24 at 5:00pm (PST).&nbsp;</strong>There is a limit of one vote per email address, so make it count! We will officially announce the winning animal organization on Tuesday, February 28,<a href="http://helenwoodwardanimalcenter.wordpress.com/" target="_blank">&nbsp;at our blog</a>, so make sure you come back and see if your favorite animal won.&nbsp; </td>
                                                               </tr>
                                                              </table>
                                                            </form>
                                                              <p>&nbsp;</p>
  </div>
</asp:content>
