<%@ Control Language="VB"  %>

<script language="vb" runat="server">
Public ReadOnly Property BAddress as String
	Get
		BAddress=Address.Text
	End Get
End Property
Public ReadOnly Property BCity as String
	Get
		BCity=City.Text
	End Get
End Property
Public ReadOnly Property BState as string
	Get 
		BState=State.SelectedItem.Text
	End Get
End Property
Public ReadOnly Property BZip as string
	Get
		BZip=Zip.Text
	End Get
End Property
Public ReadOnly Property BCountry as string
	Get
		BCountry=Country.SelectedItem.text
	End Get
End Property
</script>
<style type="text/css">
<!--
.style1 {
	color: #FFFFFF;
	font-weight: bold;
}
-->
</style>

<table width="400" border="0" align="center" cellpadding="5" cellspacing="2">
<tr bgcolor="#F68428">
<td colspan="2"><span class="style1"> &nbsp;Billing Address </span></td>
</tr>
<tr>
  <td nowrap><div align="right">*Street Address </div></td>
  <td width="77%"><asp:TextBox runat="server" ID="Address"  MaxLength="100"/>
    <asp:RequiredFieldValidator ID="req_Address" runat="server" Display="Dynamic" ErrorMessage="*Billing Address is Required"  ControlToValidate="Address"/></td>
</tr>
<tr>
  <td><div align="right">*City</div></td>
  <td><asp:TextBox runat="server" ID="City" MaxLength="100" /><asp:RequiredFieldValidator ID="req_City" ControlToValidate="City" ErrorMessage="*City is required"  runat="server"/>    </td>
</tr>
<tr>
  <td><div align="right">*State/Province</div></td>
  <td><asp:Dropdownlist runat="server" id="State">
<asp:ListItem value="" Text="Choose a State"/>
<asp:ListItem value="AK" text="AK"/>
<asp:ListItem value="AL" text="AL"/>
<asp:ListItem value="AR" text="AR"/>
<asp:ListItem value="AZ" text="AZ"/>
<asp:ListItem value="CA" text="CA"/>
<asp:ListItem value="CO" text="CO"/>
<asp:ListItem value="CT" text="CT"/>
<asp:ListItem value="DC" text="DC"/>
<asp:ListItem value="DE" text="DE"/>
<asp:ListItem value="FL" text="FL"/>
<asp:ListItem value="GA" text="GA"/>
<asp:ListItem value="HI" text="HI"/>
<asp:ListItem value="IA" text="IA"/>
<asp:ListItem value="ID" text="ID"/>
<asp:ListItem value="IL" text="IL"/>
<asp:ListItem value="IN" text="IN"/>
<asp:ListItem value="KS" text="KS"/>
<asp:ListItem value="KY" text="KY"/>
<asp:ListItem value="LA" text="LA"/>
<asp:ListItem value="MA" text="MA"/>
<asp:ListItem value="MD" text="MD"/>
<asp:ListItem value="ME" text="ME"/>
<asp:ListItem value="MI" text="MI"/>
<asp:ListItem value="MN" text="MN"/>
<asp:ListItem value="MO" text="MO"/>
<asp:ListItem value="MS" text="MS"/>
<asp:ListItem value="MT" text="MT"/>
<asp:ListItem value="NC" text="NC"/>
<asp:ListItem value="ND" text="ND"/>
<asp:ListItem value="NE" text="NE"/>
<asp:ListItem value="NH" text="NH"/>
<asp:ListItem value="NJ" text="NJ"/>
<asp:ListItem value="NM" text="NM"/>
<asp:ListItem value="NV" text="NV"/>
<asp:ListItem value="NY" text="NY"/>
<asp:ListItem value="OH" text="OH"/>
<asp:ListItem value="OK" text="OK"/>
<asp:ListItem value="OR" text="OR"/>
<asp:ListItem value="PA" text="PA"/>
<asp:ListItem value="RI" text="RI"/>
<asp:ListItem value="SC" text="SC"/>
<asp:ListItem value="SD" text="SD"/>
<asp:ListItem value="TN" text="TN"/>
<asp:ListItem value="TX" text="TX"/>
<asp:ListItem value="UT" text="UT"/>
<asp:ListItem value="VA" text="VA"/>
<asp:ListItem value="VT" text="VT"/>
<asp:ListItem value="WA" text="WA"/>
<asp:ListItem value="WI" text="WI"/>
<asp:ListItem value="WV" text="WV"/>
<asp:ListItem value="WY" text="WY"/>
<asp:Listitem Value="" Text="_____________"/>
<asp:ListItem text="US Territories" Value="" />
<asp:Listitem Value="" Text=" "/>
<asp:ListItem value="AS" text="AS"/>
<asp:ListItem value="FM" text="FM"/>
<asp:ListItem value="GU" text="GU"/>
<asp:ListItem value="MH" text="MH"/>
<asp:ListItem value="MP" text="MP"/>
<asp:ListItem value="PR" text="PR"/>
<asp:ListItem value="PW" text="PW"/>
<asp:ListItem value="VI" text="VI"/>
<asp:Listitem Value="" Text="_____________"/>
<asp:ListItem text="US Military" Value="" />
<asp:Listitem Value="" Text=" "/>	
<asp:ListItem value="AA" text="AA"/>
<asp:ListItem value="AE" text="AE"/>
<asp:ListItem value="AP" text="AP"/>
<asp:Listitem Value="" Text="_____________"/>
<asp:ListItem text="Canada" Value="" />
<asp:Listitem Value="" Text=" "/>	
<asp:ListItem value="AB" text="AB"/>
<asp:ListItem value="BC" text="BC"/>
<asp:ListItem value="MB" text="MB"/>
<asp:ListItem value="NB" text="NB"/>
<asp:ListItem value="NF" text="NF"/>
<asp:ListItem value="NS" text="NS"/>
<asp:ListItem value="NT" text="NT"/>
<asp:ListItem value="NU" text="NU"/>
<asp:ListItem value="ON" text="ON"/>
<asp:ListItem value="PE" text="PE"/>
<asp:ListItem value="QC" text="QC"/>
<asp:ListItem value="SK" text="SK"/>
<asp:ListItem value="YT" text="YT"/>
<asp:Listitem Value="" Text="_____________"/>
<asp:ListItem text="Other Countries" Value="" />
<asp:Listitem Value="" Text=" "/>

<asp:ListItem value="None" text="None"/>
</Asp:DropdownList>
    <asp:RequiredFieldValidator ID="req_State" ControlToValidate="State" ErrorMessage="*State is required"  runat="server"/></td>
</tr>
<tr>
  <td><div align="right">*Zip/Postal Code </div></td>
  <td><asp:TextBox runat="server" ID="Zip" MaxLength="100" />  
    <asp:RequiredFieldValidator ID="req_Zip" ControlToValidate="Zip" ErrorMessage="*Zip Code is required"  runat="server"/></td>
</tr>
<tr>
  <td><div align="right">*Country</div></td>
  <td><asp:DropdownList id="Country" runat="server" >
<asp:ListItem text="United States"/>
<asp:ListItem text="Canada"/>
<asp:ListItem text="Mexico"/>
<asp:ListItem text="Afghanistan"/>
<asp:ListItem text="Albania"/>
<asp:ListItem text="Algeria"/>
<asp:ListItem text="American Samoa"/>
<asp:ListItem text="Andorra"/>
<asp:ListItem text="Angola"/>
<asp:ListItem text="Anguilla"/>
<asp:ListItem text="Antarctica"/>
<asp:ListItem text="Antigua and Barbuda"/>
<asp:ListItem text="Argentina"/>
<asp:ListItem text="Armenia"/>
<asp:ListItem text="Aruba"/>
<asp:ListItem text="Australia"/>
<asp:ListItem text="Austria"/>
<asp:ListItem text="Azerbaijan"/>
<asp:ListItem text="Bahamas"/>
<asp:ListItem text="Bahrain"/>
<asp:ListItem text="Bangladesh"/>
<asp:ListItem text="Barbados"/>
<asp:ListItem text="Belarus"/>
<asp:ListItem text="Belgium"/>
<asp:ListItem text="Belize"/>
<asp:ListItem text="Benin"/>
<asp:ListItem text="Bermuda"/>
<asp:ListItem text="Bhutan"/>
<asp:ListItem text="Bolivia"/>
<asp:ListItem text="Bosnia-Herzegovina"/>
<asp:ListItem text="Botswana"/>
<asp:ListItem text="Bouvet Island"/>
<asp:ListItem text="Brazil"/>
<asp:ListItem text="British Indian Ocean Territory"/>
<asp:ListItem text="Brunei"/>
<asp:ListItem text="Bulgaria"/>
<asp:ListItem text="Burkina Faso"/>
<asp:ListItem text="Burundi"/>
<asp:ListItem text="Cambodia"/>
<asp:ListItem text="Cameroon"/>
<asp:ListItem text="Cape Verde"/>
<asp:ListItem text="Cayman Islands"/>
<asp:ListItem text="Central African Republic"/>
<asp:ListItem text="Chad"/>
<asp:ListItem text="Chile"/>
<asp:ListItem text="China"/>
<asp:ListItem text="Christmas Island"/>
<asp:ListItem text="Cocos (Keeling) Islands"/>
<asp:ListItem text="Colombia"/>
<asp:ListItem text="Comoros"/>
<asp:ListItem text="Congo"/>
<asp:ListItem text="Cook Islands"/>
<asp:ListItem text="Costa Rica"/>
<asp:ListItem text="Croatia"/>
<asp:ListItem text="Cuba"/>
<asp:ListItem text="Cyprus"/>
<asp:ListItem text="Czech Republic"/>
<asp:ListItem text="Denmark"/>
<asp:ListItem text="Djibouti"/>
<asp:ListItem text="Dominica"/>
<asp:ListItem text="Dominican Republic"/>
<asp:ListItem text="East Timor"/>
<asp:ListItem text="Ecuador"/>
<asp:ListItem text="Educational"/>
<asp:ListItem text="Egypt"/>
<asp:ListItem text="El Salvador"/>
<asp:ListItem text="Equatorial Guinea"/>
<asp:ListItem text="Eritrea"/>
<asp:ListItem text="Estonia"/>
<asp:ListItem text="Ethiopia"/>
<asp:ListItem text="Falkland Islands"/>
<asp:ListItem text="Faroe Islands"/>
<asp:ListItem text="Fiji"/>
<asp:ListItem text="Finland"/>
<asp:ListItem text="Former Czechoslovakia"/>
<asp:ListItem text="Former USSR"/>
<asp:ListItem text="France"/>
<asp:ListItem text="French Guyana"/>
<asp:ListItem text="French Southern Territories"/>
<asp:ListItem text="Gabon"/>
<asp:ListItem text="Gambia"/>
<asp:ListItem text="Georgia"/>
<asp:ListItem text="Germany"/>
<asp:ListItem text="Ghana"/>
<asp:ListItem text="Gibraltar"/>
<asp:ListItem text="Great Britain"/>
<asp:ListItem text="Greece"/>
<asp:ListItem text="Greenland"/>
<asp:ListItem text="Grenada"/>
<asp:ListItem text="Guadeloupe (French)"/>
<asp:ListItem text="Guam (USA)"/>
<asp:ListItem text="Guatemala"/>
<asp:ListItem text="Guinea"/>
<asp:ListItem text="Guinea-Bissau"/>
<asp:ListItem text="Guyana"/>
<asp:ListItem text="Haiti"/>
<asp:ListItem text="Heard and McDonald Islands"/>
<asp:ListItem text="Holy See (Vatican City State)"/>
<asp:ListItem text="Honduras"/>
<asp:ListItem text="Hungary"/>
<asp:ListItem text="Iceland"/>
<asp:ListItem text="India"/>
<asp:ListItem text="Indonesia"/>
<asp:ListItem text="Iran"/>
<asp:ListItem text="Iraq"/>
<asp:ListItem text="Ireland"/>
<asp:ListItem text="Israel"/>
<asp:ListItem text="Italy"/>
<asp:ListItem text="Ivory Coast (Cote D'Ivoire)"/>
<asp:ListItem text="Jamaica"/>
<asp:ListItem text="Japan"/>
<asp:ListItem text="Jordan"/>
<asp:ListItem text="Kazakhstan"/>
<asp:ListItem text="Kenya"/>
<asp:ListItem text="Kiribati"/>
<asp:ListItem text="Kuwait"/>
<asp:ListItem text="Kyrgyz Republic (Kyrgyzstan)"/>
<asp:ListItem text="Laos"/>
<asp:ListItem text="Latvia"/>
<asp:ListItem text="Lebanon"/>
<asp:ListItem text="Lesotho"/>
<asp:ListItem text="Liberia"/>
<asp:ListItem text="Libya"/>
<asp:ListItem text="Liechtenstein"/>
<asp:ListItem text="Lithuania"/>
<asp:ListItem text="Luxembourg"/>
<asp:ListItem text="Macau"/>
<asp:ListItem text="Macedonia"/>
<asp:ListItem text="Madagascar"/>
<asp:ListItem text="Malawi"/>
<asp:ListItem text="Malaysia"/>
<asp:ListItem text="Maldives"/>
<asp:ListItem text="Mali"/>
<asp:ListItem text="Malta"/>
<asp:ListItem text="Marshall Islands"/>
<asp:ListItem text="Martinique (French)"/>
<asp:ListItem text="Mauritania"/>
<asp:ListItem text="Mauritius"/>
<asp:ListItem text="Mayotte"/>
<asp:ListItem text="Micronesia"/>
<asp:ListItem text="Moldavia"/>
<asp:ListItem text="Monaco"/>
<asp:ListItem text="Mongolia"/>
<asp:ListItem text="Montserrat"/>
<asp:ListItem text="Morocco"/>
<asp:ListItem text="Mozambique"/>
<asp:ListItem text="Myanmar"/>
<asp:ListItem text="Namibia"/>
<asp:ListItem text="Nauru"/>
<asp:ListItem text="Nepal"/>
<asp:ListItem text="Netherlands"/>
<asp:ListItem text="Netherlands Antilles"/>
<asp:ListItem text="New Caledonia (French)"/>
<asp:ListItem text="New Zealand"/>
<asp:ListItem text="Nicaragua"/>
<asp:ListItem text="Niger"/>
<asp:ListItem text="Nigeria"/>
<asp:ListItem text="Niue"/>
<asp:ListItem text="Norfolk Island"/>
<asp:ListItem text="Northern Mariana Islands"/>
<asp:ListItem text="North Korea"/>
<asp:ListItem text="Norway"/>
<asp:ListItem text="Oman"/>
<asp:ListItem text="Pakistan"/>
<asp:ListItem text="Palau"/>
<asp:ListItem text="Panama"/>
<asp:ListItem text="Papua New Guinea"/>
<asp:ListItem text="Paraguay"/>
<asp:ListItem text="Peru"/>
<asp:ListItem text="Philippines"/>
<asp:ListItem text="Pitcairn Island"/>
<asp:ListItem text="Poland"/>
<asp:ListItem text="Polynesia (French)"/>
<asp:ListItem text="Portugal"/>
<asp:ListItem text="Puerto Rico"/>
<asp:ListItem text="Qatar"/>
<asp:ListItem text="Reunion (French)"/>
<asp:ListItem text="Romania"/>
<asp:ListItem text="Russian Federation"/>
<asp:ListItem text="Rwanda"/>
<asp:ListItem text="Saint Helena"/>
<asp:ListItem text="Saint Kitts &amp; Nevis Anguilla"/>
<asp:ListItem text="Saint Lucia"/>
<asp:ListItem text="Saint Pierre and Miquelon"/>
<asp:ListItem text="Saint Tome and Principe"/>
<asp:ListItem text="Saint Vincent &amp; Grenadines"/>
<asp:ListItem text="Samoa"/>
<asp:ListItem text="San Marino"/>
<asp:ListItem text="Saudi Arabia"/>
<asp:ListItem text="Senegal"/>
<asp:ListItem text="Seychelles"/>
<asp:ListItem text="S. Georgia &amp; S. Sandwich Isls."/>
<asp:ListItem text="Sierra Leone"/>
<asp:ListItem text="Singapore"/>
<asp:ListItem text="Slovak Republic"/>
<asp:ListItem text="Slovenia"/>
<asp:ListItem text="Solomon Islands"/>
<asp:ListItem text="Somalia"/>
<asp:ListItem text="South Africa"/>
<asp:ListItem text="South Korea"/>
<asp:ListItem text="Spain"/>
<asp:ListItem text="Sri Lanka"/>
<asp:ListItem text="Sudan"/>
<asp:ListItem text="Suriname"/>
<asp:ListItem text="Svalbard and Jan Mayen Islands"/>
<asp:ListItem text="Swaziland"/>
<asp:ListItem text="Sweden"/>
<asp:ListItem text="Switzerland"/>
<asp:ListItem text="Syria"/>
<asp:ListItem text="Tadjikistan"/>
<asp:ListItem text="Taiwan"/>
<asp:ListItem text="Tanzania"/>
<asp:ListItem text="Thailand"/>
<asp:ListItem text="Togo"/>
<asp:ListItem text="Tokelau"/>
<asp:ListItem text="Tonga"/>
<asp:ListItem text="Trinidad and Tobago"/>
<asp:ListItem text="Tunisia"/>
<asp:ListItem text="Turkey"/>
<asp:ListItem text="Turkmenistan"/>
<asp:ListItem text="Turks and Caicos Islands"/>
<asp:ListItem text="Tuvalu"/>
<asp:ListItem text="Uganda"/>
<asp:ListItem text="Ukraine"/>
<asp:ListItem text="United Arab Emirates"/>
<asp:ListItem text="United Kingdom"/>
<asp:ListItem text="Uruguay"/>
<asp:ListItem text="USA Minor Outlying Islands"/>
<asp:ListItem text="Uzbekistan"/>
<asp:ListItem text="Vanuatu"/>
<asp:ListItem text="Venezuela"/>
<asp:ListItem text="Vietnam"/>
<asp:ListItem text="Virgin Islands (British)"/>
<asp:ListItem text="Virgin Islands (USA)"/>
<asp:ListItem text="Wallis and Futuna Islands"/>
<asp:ListItem text="Western Sahara"/>
<asp:ListItem text="Yemen"/>
<asp:ListItem text="Yugoslavia"/>
<asp:ListItem text="Zaire"/>
<asp:ListItem text="Zambia"/>
<asp:ListItem text="Zimbabwe"/>
</asp:DropDownList>
    <asp:RequiredFieldValidator ID="req_Country" ControlToValidate="Country" ErrorMessage="*Country is required" runat="server"/></td>
</tr>
</table>
