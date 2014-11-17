<cfinclude template="_header.cfm" />

<cfquery name="getUsers" datasource="#request.dsn#">
	SELECT *
	FROM craigslist_users
	ORDER BY email
</cfquery>

<cfset regions = "cnj,delaware,jerseyshore,philadelphia,southjersey" />

<form method="post" action="add_url_save.cfm">
	
	
	<label for="search_url">Search URL without region (i.e. /search/sss?query=mustang&format=rss)<br />
		<input type="text" name="search_url" id="search_url" size="100" maxlength="255" />
	</label>
	
	<label for="regions">Search Regions<br />
		<select name="regions" id="regions" multiple="multiple" size="5">
			<cfloop index="x" list="#regions#">
				<cfoutput><option value="#x#">#x#</option></cfoutput>
			</cfloop>
		</select>
	</label>
	
	<label for="userid">Users<br />
		<select name="userid" id="userid" multiple="multiple" size="5">
			<cfoutput query="getUsers">
				<option value="#getUsers.userid#">#getUsers.email#</option>
			</cfoutput>
		</select>
	</label>
	
	<button type="submit">Save URL</button>
	
</form>


<cfinclude template="_footer.cfm" />