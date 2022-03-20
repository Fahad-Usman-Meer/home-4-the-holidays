<% @ Page Language="VB" MasterPageFile="~/home4theholidays/template.master" Title="Win Money for Your Animal Welfare Organization|  Home 4 the Holidays" debug="true" %>
<%@ import Namespace="System.Data" %>
<%@ import Namespace="System.Data.SQLClient" %>

<script runat="server">
sub page_load (obj as object, e as eventargs)
	''Dim db as new HWAC.database
	'dim isql as string
	'Use when voting is closed
	'	Dim date1 As Date = Datetime.now
	'	Dim date2 As Date = "4/24/2012 5:00pm"
	'	Dim result As Integer = DateTime.Compare(date1, date2)
	'		lblmessage.text="<center>Voting is now closed. Thank you for participating!</center>"
	'		btnVote.visible=false
	'		form1.visible=false
		'if result>0 then 'later
			
		'else
		'	if request.QueryString("verify")<>"" then 'for verification
		'		isql="UPDATE tblIH4THEssay_Votes_2011 SET Verified=1, Verification_ip='" & request.ServerVariables("REMOTE_ADDR") & "', Verification_date='" & datetime.now() & "' where UniqueID='" & request.QueryString("verify") & "'"
		'		db.Executenonquery(isql)
		'		lblmessage.text="Thank you for your vote!  Your vote has been verified."
		'	end if
		'end if

	'lookup vote totals
	'	isql="SELECT COUNT_BIG(*) AS VoteCount, Vote_For FROM tblIH4THEssay_Votes_2011 WHERE(Verified = 1) GROUP BY Vote_For ORDER BY Vote_For"
	'display vote totals
	'		dim objReader as SQLdatareader
	'		objReader=db.GetReader(iSql)
	'			if objreader.hasrows() then 'display votes
	'				while objreader.read()
	'					if objreader("Vote_For")=1 then lblVote1.text=objreader("Votecount")
	'					if objreader("Vote_For")=2 then lblVote2.text=objreader("Votecount")
	'					if objreader("Vote_For")=3 then lblVote3.text=objreader("Votecount")
	'					if objreader("Vote_For")=4 then lblVote4.text=objreader("Votecount")
	'					if objreader("Vote_For")=5 then lblVote5.text=objreader("Votecount")
	'					if objreader("Vote_For")=6 then lblVote6.text=objreader("Votecount")
	'					if objreader("Vote_For")=7 then lblVote7.text=objreader("Votecount")
	'					if objreader("Vote_For")=8 then lblVote8.text=objreader("Votecount")
	'					if objreader("Vote_For")=9 then lblVote9.text=objreader("Votecount")
	'					if objreader("Vote_For")=10 then lblVote10.text=objreader("Votecount")
	'					if objreader("Vote_For")=11 then lblVote11.text=objreader("Votecount")
	'					if objreader("Vote_For")=12 then lblVote12.text=objreader("Votecount")
	'					if objreader("Vote_For")=13 then lblVote13.text=objreader("Votecount")
	'					if objreader("Vote_For")=14 then lblVote14.text=objreader("Votecount")
	'					if objreader("Vote_For")=15 then lblVote15.text=objreader("Votecount")
	'					if objreader("Vote_For")=16 then lblVote16.text=objreader("Votecount")
	'					if objreader("Vote_For")=17 then lblVote17.text=objreader("Votecount")
	'					if objreader("Vote_For")=18 then lblVote18.text=objreader("Votecount")
	'					
	'				end while
	'			end if
	'		objreader.close()
	
end sub


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
 
<h1 class="grn_ttl_blg"> Most Heartwarming Story Contest for  Home 4 the Holidays participating organizations <br></h1>
														  <div align="left">
														   
                                                              <p>Pet rescue and adoption organizations participating in the&nbsp;2012  Home 4 the Holidays campaign&nbsp;will have the chance to enter their best, most heart-warming pet adoption stories (that take place during the program) into a contest hosted by&nbsp;Helen Woodward Animal Center.&nbsp;The organization with the best story will win a $500 donation. Please see below for details on how to enter.</p>
                                                            <h2>Contest Details:</h2>
                                                              <p>Every week during the 2012  Home 4 the Holidays campaign (Oct. 1, 2012 &ndash; Jan. 2, 2013), participating animal organizations are encouraged to enter heartwarming adoption success stories. Submissions can be made weekly by snail mail, fax or email, and at the end of each week Helen Woodward Animal Center will select a winning story to be featured on this very blog! After the campaign ends on Jan. 2, 2013, the weekly winning stories will be compiled into a pool and voted on by you, your fans and the public. The story with the most votes will win a $500 donation for their animal organization and will be announced on Helen Woodward Animal Center&rsquo;s blog in February 2013.</p>
                                                            <p><strong>We will begin accepting stories on Monday, October 1, 2012!</strong></p>
                                                              <p>Key Points to Remember:</p>
                                                              <ul>
                                                                <li>Enter success stories every week during the campaign (Oct. 1, 2012 &ndash;&nbsp;Jan. 2, 2013). You can enter as many times as you have unique pet adoption success stories.</li>
                                                                <li>The winner will be announced in February 2013, and will be contacted via phone or email. The winner will also be announced on Helen Woodward Animal Center&rsquo;s blog.</li>
                                                                <li>Donation recipient must be a 501(c)(3) non-profit animal welfare group.</li>
                                                                <li>Only  Home 4 the Holidays participating organizations may enter. If your organization wishes to join the campaign,&nbsp;<a href="register.aspx">click here</a>.</li>
                                                              </ul>
                                                              <p>&nbsp;</p>
                                                              <p>Where to submit your success stories:</p>
                                                              <p><strong>Email:</strong></p>
                                                              <p><a href="mailto:h4th@animalcenter.org?subject=Most%20Heartwarming%20Story%20Contest%20Submission" target="_blank">Click here to email your story!</a></p>
                                                              <p><strong>Mail:</strong></p>
                                                              <blockquote>
                                                                <p> Home 4 the Holidays<br />
                                                                c/o Helen Woodward Animal Center<br />
                                                                P.O. Box 64<br />
                                                                Rancho Santa Fe, CA 92067</p>
                                                                </blockquote>
                                                              <p><strong>Fax:</strong></p>
                                                              <p>858-756-1466</p>
                                                              <h2>&nbsp;</h2>
                                                              <p align="center"><strong>Congratulations to 2011&rsquo;s Most Heartwarming Story Winner<br />
  Duke&rsquo;s Story from Chicagoland Dog Rescue, Chicago, Illinois</strong><br />
                                                              <img src="_images/Stories_2011/Duke1.jpg" alt="" width="206" height="213" /><img src="_images/Stories_2011/Duke2.jpg" alt="" width="219" height="213" /></p>
                                                              <p>Duke was abandoned by a family who moved away and did not take him with them. He slept on a porch every night in hopes of finding a new family. Even though Duke was a bit shy at first, he found the perfect family for him. <a href="http://helenwoodwardanimalcenter.wordpress.com/2012/02/14/vote-for-your-favorite-most-heartwarming-story-from-iams-home-4-the-holiday/5/" target="_blank">Full story...</a></p>
  </div>
</asp:content>
