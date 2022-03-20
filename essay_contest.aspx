<% @ Page Language="VB" MasterPageFile="~/template.master" Title="Enter a Writing Contest - Dog Story or Cat Story |  Home 4 the Holidays" debug="true" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SQLClient" %>

<script runat="server">
sub page_load (obj as object, e as eventargs)
	Dim db as new HWAC.databaseH4TH
	dim isql as string
	'Use when voting is closed
		Dim date1 As Date = DateTime.Now.addhours(-1)
		Dim date2 As Date = "2/11/2016 5:00pm"
		Dim result As Integer = DateTime.Compare(date1, date2)
			
		if result>0 then 'later
			lblmessage.text=""'<strong><center>Voting is now closed. Thank you for participating!  The winner will be announced shortly!</center></strong>"
			btnVote.visible=false
			form1.visible=false
		else
			if request.QueryString("verify")<>"" then 'for verification
				isql="UPDATE tblIH4THEssay_Votes_2015 SET Verified=1, Verification_ip='" & request.ServerVariables("REMOTE_ADDR") & "', Verification_date='" & DateTime.Now.addhours(-1) & "' where UniqueID='" & request.QueryString("verify") & "'"
			db.Executenonquery(isql)
				lblmessage.text="Thank you for your vote!  Your vote has been verified. " & DateTime.Now.addhours(-1) & " PDT"
			end if
		end if

	'lookup vote totals
		isql="SELECT COUNT_BIG(*) AS VoteCount, Vote_For FROM tblIH4THEssay_Votes_2015 WHERE(Verified = 1) GROUP BY Vote_For ORDER BY Vote_For"
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
						if objreader("Vote_For")=12 then lblVote12.text=objreader("Votecount")
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
			Dim db as new HWAC.databaseH4TH
			Dim db2 as new HWAC.databaseH4TH
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
			if rbStory12.checked then intvotedfor=12
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
			isql="Select EntryDate FROM tblIH4THEssay_Votes_2015 WHERE Voter_email='" & trim(tb_email.text) & "" & "'"
			objReader=db.GetReader(iSql)
				if objreader.hasrows() then 'already voted
						while objreader.read()
						lblmessage.text="There was already a vote cast by this email on " & objreader("EntryDate") & ". Thank you for voting!"	
						end while
						objreader.close()
						exit sub
				else 'not voted yet
					isql="INSERT INTO tblIH4THEssay_Votes_2015 (Vote_For, Voter_Email, Voter_ip, UniqueID) VALUES (" & intVotedFor & ",'" & tb_email.text & "','" & request.ServerVariables("REMOTE_ADDR") & "','" & strID & "')"
					db2.executenonquery(isql)
				end if 
	'send email for verification
	If instr(tb_email.text,"trapneuterreturn.info")=0  or instr(tb_email.text,"pensacolacriminaldefense.com")=0 or request.ServerVariables("REMOTE_ADDR")<>"85.90.246.33" then 'ok
		 Dim EM as new HWAC.EMailMessage()
						EM.From=" Home 4 The Holidays <h4thnews@animalcenter.org>"
						EM.Subject="Please Verify Your Vote"
						EM.MailTo=tb_email.text
						EM.BCC="lonjones@hotmail.com"
						EM.Body="<table width=500 border=1 align=center cellpadding=4><tr><td><img src=http://join.home4theholidays.org/_images/H4TH-logo2013BB.jpg align=""right"" width=""400px"" /><p>Thank you for your vote!<p><br/>Please <a href=""http://join.home4theholidays.org/essay_contest.aspx?verify=" & strID & """ >Click here</a>  to verify your vote.</td></tr></table>"
						
						 Try
							EM.Send_Email(EM)
							'lblmessage.text=strdata
						 Catch ex as exception
							lblmessage.text="There was a problem emailing your information, please try again"
							exit sub
						 end try
			End if
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
 
<h1 class="grn_ttl_blg">2015 Most  Heartwarming Story Contest Winner<br>
</h1>
														  <div align="left">
														   
                                                            <p align="center"><br>
                                                            <img src="_images/Stories-2016/1 - Abbott and Costello/Lead Image.jpg" width="598" height="703" alt=""/></p>
                                                            <p align="center">                                                              Congratulations to the&nbsp;<a href="http://www.blountcountyhumanesociety.org/">Blount  County Humane Society</a> in Maryville, Tennessee, the 2015&nbsp;Blue Buffalo Home 4 the Holidays&nbsp;Most Heartwarming Story Contest  winner! This year&rsquo;s competition was the toughest yet, but Blount County Humane  came in first place with 1,458 votes.&nbsp;<strong>This outstanding organization  will receive $1,000 for turning an act of unspeakable animal cruelty into  something wonderful that touched the whole community.</strong></p>
                                                            <p align="center"><strong>Meet Abbott and Costello</strong></p>
                                                            <p align="center"><img src="_images/Stories-2016/1 - Abbott and Costello/Before and After.jpg" width="599" height="743" alt=""/><br>
                                                              <strong>These two tabby kittens were found covered in  foam insulation.</strong>&nbsp;Medical  staff and volunteers spent hours removing the plaster from their fur. The  shelter posted their story on Facebook, catching the attention of the perfect  adopters.&nbsp;<a href="http://join.home4theholidays.org/stories-2015/abbott-costello.aspx">Read their full story here!</a></p>
                                                            <p align="center">                                                              To the organizations who submitted stories, thank you from the  bottom of our hearts. We were touched by every single one.&nbsp;We are  constantly amazed by your commitment to orphan pets and honored you chose to  partner with us for this live-saving campaign.</p>
                                                            <p align="center">                                                              Thank you again for everyone&rsquo;s votes and participation.&nbsp;<strong>Together, the 2015 Blue Buffalo  Home 4 the Holidays pet adoption campaign saved 1,373,470 pets,  over&nbsp;50,000 more than last year.</strong>&nbsp;We will not stop  until every orphan pet goes &ldquo;Home 4 the Holidays.&rdquo;</p>
                                                            <p>
      <asp:Label ID="lblmessage" runat="server" Font-Bold="true" ForeColor="#FF0000" Font-Size="14"/>                                                                                                                          </p>
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
                                                                  <td valign="middle"><a href="stories-2015/abbott-costello.aspx"><img src="_images/Stories-2016/1 - Abbott and Costello/Abbott and Costello - Story Contest-4 - Copy.jpg" width="200" height="200" /> </a></td>
                                                                  <td><p><strong>Abbott and Costello</strong><br>
                                                                    <br>
These were some of the most shocking photos of animal  cruelty we&rsquo;ve ever seen: two kittens plastered in foam insulation and left in  the street to die. The story made headlines, causing outrage and the community  to rally around the kittens. Shelter staff worked round-the-clock to nurse  Abbott and Costello back to health before placing them with the perfect pet  parents. </p>
                                                                    <p><a href="stories-2015/abbott-costello.aspx">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory2" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote2" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                  votes</td>
                                                                  <td><a href="stories-2015/almond-joy.aspx"><img src="_images/Stories-2016/2 - Almond Joy/Almond Joy - Heartwarming Story Contest-1 - Copy.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Almond Joy</strong><br>
                                                                      <br>
                                                                      Almond Joy&rsquo;s story is pure serendipity. A UPS driver called  a rescue worker about a sick kitten he had just found, but the call dropped. Lo  and behold, you&rsquo;ll never guess who happened to be delivering a package next  door to the rescuer&rsquo;s house just minutes later! The tiny kitten was so hungry,  he had swallowed a whole almond that needed to be surgically removed. One of the  vet techs who assisted in his surgery fell in love and became his forever mom. </p>
                                                                    <p><a href="stories-2015/almond-joy.aspx">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory3" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote3" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                  votes</td>
                                                                  <td><a href="stories-2015/boone.aspx"><img src="_images/Stories-2016/3 - Boone/Boone - Story Contest-1 - Copy.jpg" width="200" height="200" /></a></td>
                                                                 <td><p><strong>Boone</strong><br>
                                                                   <br>
After being rescued, Boone was off to the Big House. That&rsquo;s  right: he moved into a prison, where inmates trained him to open doors, turn on  lights, pick up things and more. Now, he is a proud service dog for a young man  with Cerebral Palsy. </p>
                                                                   <p><a href="stories-2015/boone.aspx">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory4" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote4" runat="server" Text="0" CssClass="votes"/>
                                                                    <br />
                                                                    votes</td>
                                                                  <td><a href="stories-2015/booth.aspx"><img src="_images/Stories-2016/4 - Booth/Boothe - Heartwarming Story Contest-1 - Copy.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Booth </strong></p>
                                                                    <p>                                                                      Be warned, Booth&rsquo;s story is a tearjerker. A war veteran,  beaten down by life, came to the shelter &ldquo;just to look.&rdquo; He ended up find the  perfect dog, but didn&rsquo;t have enough money to cover the fees. Shelter staff  decided they would do whatever it took to make this adoption happen. The vet&rsquo;s  reaction will melt your heart.</p>
                                                                  <p><a href="stories-2015/booth.aspx">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory5" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote5" runat="server" Text="0"  CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td valign="middle"><a href="stories-2015/brownie.aspx"><img src="_images/Stories-2016/5 - Brownie/Brownie - Heartwarming Story Contest-2 - Copy.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Brownie</strong></p>
                                                                    <p>Brownie&rsquo;s first family returned her to the shelter after  their vet discovered that Brownie had a chronic condition. She went to live  with a foster mom while waiting for a special surgery. In a tragic turn of  events, the foster&rsquo;s only son was killed in a car accident. She came to rely on  her foster pup for emotional support and, after the surgery, she couldn&rsquo;t bear  to give her back. </p>
                                                                    <p><a href="stories-2015/brownie.aspx">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory6" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote6" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="stories-2015/bruce-wayne.aspx"><img src="_images/Stories-2016/6 - Bruce Wayne/Bruce Wayne - Heartwarming Story Contest-6-2.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Bruce Wayne  </strong><br>
                                                                    <br>
Bruce Wayne was one of the most emaciated dogs we&rsquo;ve ever  seen. His original owner starved him <em>intentionally</em>,  and it almost killed him. When he arrived at the rescue, the vet only gave him  a 3 percent chance to live. Slowly but surely, he transformed into a sweet,  lovable pet, even prompting his forever family to become fosters themselves. </p>
                                                                    <p><a href="stories-2015/bruce-wayne.aspx">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory7" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote7" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="stories-2015/buster-thor.aspx"><img src="_images/Stories-2016/7 - Buster and Thor/Buster and Thor - Heartwarming Story Contest-1 - Copy.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Buster and Thor </strong><br>
                                                                    <br>
Buster and Thor&rsquo;s happy ending began with a bargain. In an  attempt to persuade her daughter to take Spanish instead of French, Annelise&rsquo;s  mom reluctantly agreed to let her adopt a kitten. When Annelise started  researching kitten adoption, she learned that kittens are better in pairs! This  family fell in love with the first pair they met. </p>
                                                                    <p><a href="stories-2015/buster-thor.aspx">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory8" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote8" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="stories-2015/manny-ray.aspx"><img src="_images/Stories-2016/8 - Manny and Ray/Manny and Ray - Heartwarming Story Contest-3 - Copy.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Manny and Ray</strong><br>
                                                                    <br>
Kittens Ray and Manny were rescued from separate litters  during two &ldquo;Trap, Neuter, Release&rdquo; missions. Ray suffered my eye infections so  severe that both his eyes had to be removed. Manny was healthy, but after every  single one of his littermates was adopted, the shy kitten was left all alone.  Together, they found the perfect home with a  mom and sweet 8-year-old girl with special needs. </p>
                                                                    <p><a href="stories-2015/manny-ray.aspx">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory9" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote9" runat="server" Text="0"  CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td valign="middle"><a href="stories-2015/milton.aspx"><img src="_images/Stories-2016/9 - Milton/Milton - Heartwarming Story Contest-2 - Copy.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Milton</strong><br>
                                                                    <br>
When Milton first arrived to his foster home, he was so sick  that all he could do was sleep. Eventually, his sweet, lovable spirit shone  through.  He loved the large dogs in his  foster home, so &ldquo;big doggie siblings&rdquo; were put on his forever home wish list.  He would get his wish, but it was take a long journey up the East Coast.</p>
                                                                    <p><a href="stories-2015/milton.aspx">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory10" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote10" runat="server" Text="0" CssClass="votes"/>                                                                
                                                                      <br />
                                                                    votes</td>
                                                                  <td><a href="stories-2015/pink.aspx"><img src="_images/Stories-2016/10 - Pink/Pink - Heartwarming Story Contest-6 - Copy.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Pink</strong><br>
                                                                    <br>
It&rsquo;s no wonder Pink wasn&rsquo;t trusting of humans. She lived  underneath vehicles in an old car lot, fending for herself and her seven  kittens. A Good Samaritan started feeding the feline family and was eventually able  to bring them shelter. Her adorable kittens were adopted in a snap, but Pink  was too scared to show adopters her true personality. She was transferred to  foster care where she learned to play and snuggle (albeit it one paw at the  time.) Pink is so loved by her new family!</p>
                                                                    <p><a href="stories-2015/pink.aspx">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory11" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote11" runat="server" Text="0" CssClass="votes"/>                                                                  
                                                                    <br />
                                                                    votes</td>
                                                                  <td><a href="stories-2015/pirate.aspx"><img src="_images/Stories-2016/11 - Pirate/Pirate - Heartwarming Story Contest-2 - Copy.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>Pirate</strong><br>
                                                                    <br>
Pirate lived at the shelter for <em>seven</em> years. He was a beautiful collie, but always became shy and  standoffish when adopters came through. Meanwhile, Gerrie and her husband had  just suffered the heartbreaking loss of two collies. Pirate didn&rsquo;t make the  best first impression on the couple, but shelter staff encouraged them to have  faith. He has absolutely blossomed in his new home!</p>
                                                                    <p><a href="stories-2015/pirate.aspx">--&gt;Full Story</a></p></td>
                                                                </tr>
                                                                <tr>
                                                                  <td>&nbsp;</td>
                                                                  <td align="center"><asp:RadioButton runat="server" ID="rbstory12" GroupName="rblist1" /></td>
                                                                  <td align="center"><asp:Label ID="lblVote12" runat="server" Text="0" CssClass="votes"/>                                                                  
                                                                    <br />
                                                                    votes</td>
                                                                  <td><a href="stories-2015/william.aspx"><img src="_images/Stories-2016/12 - William/William - Heartwarming Story Contest-1 - Copy.jpg" width="200" height="200" /></a></td>
                                                                  <td><p><strong>William </strong><br>
                                                                    <br>
                                                                    When William arrived at the rescue, he was in rough shape.  He had double cherry eye, was full of parasites and had to have a leg  amputated.  He waited two years, without  even one application submitted, before his forever family walked through the door.  Now, they foster other dogs, and William provides loving support to his foster  brothers and sisters. </p>
<p><a href="stories-2015/william.aspx">--&gt;Full Story</a></p></td>
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
