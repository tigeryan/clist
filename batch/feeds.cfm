<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<cfquery name="GetSearch" datasource="#request.dsn#">
	SELECT urlid, c_search, last_run
	FROM craigslist_urls
</cfquery>

<cfloop query="GetSearch">
	<cfset email_send = "0">
	<cfset watch_list = "">
	<cfset title_list = "">
	<!---<cftry>--->

		<cfset feed = feedToQuery(#GetSearch.c_search#) />
		<cfset feedQuery = feed.query />
		
		<p><cfoutput>#GetSearch.c_search# - #feedQuery.recordcount#</cfoutput></p><cfflush>

		<cfsavecontent variable="html">
		<cfset t_urlid = GetSearch.urlid>
		<cfloop query="feedquery">
			
			<cfquery name="Check" datasource="#request.dsn#">
				SELECT watchid
				FROM craigslist_watch
				WHERE c_url = '#feedquery.link#' and urlid = #t_urlid#
			</cfquery>

			<cfif Check.recordcount EQ 0>
	
				<cftry>
				
				<cftransaction>
				
				<cfquery name="InsertLink" datasource="#request.dsn#">
					INSERT INTO craigslist_watch(urlid,c_url,c_title,c_desc,date_seen)
					VALUES(#t_urlid#,'#feedquery.link#','#Replace(feedquery.title,"'","''","ALL")#','#Replace(feedquery.description,"'","''","ALL")#',Now())
				</cfquery> 

				<cfquery name="Check" datasource="#request.dsn#">
					SELECT MAX(watchid) as watchid
					FROM craigslist_watch
					ORDER BY watchid DESC
				</cfquery>
				
				</cftransaction>
				
				<cfset watch_list = ListAppend(watch_list,Check.watchid)>
				<cfset title_list = ListAppend(title_list,title,"^")>
				
				<cfoutput>
				    <h3><a href="#link#" target="_blank">#title#</a></h3>
		  		    <p>
		        		#description#
				    </p>
					<p><a href="http://sixfoottiger.com/rss/bookmark.cfm?watchid=#Check.watchid#&uguid=%uguid%">[bookmark]</a>
					<hr>
				</cfoutput>
				<cfset email_send = 1>
				<cfcatch type="any">ERROR<br /></cfcatch>
				</cftry>
				
			</cfif>
		</cfloop>
		</cfsavecontent>
		
		<cfif email_send EQ 1>
		
			<cfquery name="GetUsers" datasource="#request.dsn#">
				SELECT craigslist_users.email, craigslist_users.uguid
				FROM craigslist_url_users INNER JOIN craigslist_users ON craigslist_url_users.userid = craigslist_users.userid
				WHERE craigslist_url_users.urlid = #t_urlid#
			</cfquery>

			<cfif GetUsers.recordcount GT 0>		
		
				<cfloop query="GetUsers">
					<cfset t_html = Replace(html,"%uguid%",GetUsers.uguid,"ALL")>
		
					<cfmail to="#GetUsers.email#" from="jceci@sixfoottiger.com" subject="Craigslist Watch Alert - #feed.channel.title#" type="HTML">
					
					<h2><a href="#feed.channel.link#" target="_blank">#feed.channel.title#</a></h2>
					<p>
					Inside this email:<br />
					#Replace(title_list,'^','<br />','ALL')#
					</p>
					#t_html#
					<a href="http://sixfoottiger.com/clist/bookmarks.cfm?uguid=#GetUsers.uguid#">[view all bookmarks]</a>
					</cfmail>
				</cfloop>
			</cfif>
		</cfif>
		
		<cfquery name="Update" datasource="#request.dsn#">
			UPDATE craigslist_urls
			SET last_run = Now()
			WHERE urlid = #GetSearch.urlid#
		</cfquery>
		
		<!---<cfcatch type="any">
			<cfmail to="tigeryan55@gmail.com" from="jceci@sixfoottiger.com" subject="Craigslist ERROR - #GetSearch.urlid#" type="HTML">
				#GetSearch.c_search#<br />
				<cfdump var="#GetSearch#">
				<cfdump var="#cfcatch#">
			</cfmail>
		</cfcatch>
	</cftry>--->
	
</cfloop>
