<cfquery name="GetSearch" datasource="#request.dsn#">
	SELECT *
	FROM craigslist_urls
</cfquery>

<cfloop query="GetSearch">
	<cfset email_send = "0">

	<cftry>
		<cfset feed = feedToQuery(#GetSearch.c_search#) />
		<cfset feedQuery = feed.query />
		
		<!--- <cfdump var="#feedquery#"> --->
		
	
		
		
		<cfsavecontent variable="html">
		
		<cfset t_urlid = GetSearch.urlid>
		<cfloop query="feedquery">
			<cfquery name="Check" datasource="#request.dsn#">
				SELECT watchid
				FROM craigslist_watch
				WHERE c_url = '#feedquery.link#' and urlid = #t_urlid#
			</cfquery>
			
			<cfif Check.recordcount EQ 0>
				<cfquery name="InsertLink" datasource="#request.dsn#">
					INSERT INTO craigslist_watch(urlid,c_url,c_title,c_desc,date_seen)
					VALUES(#t_urlid#,'#feedquery.link#','#feedquery.title#','#feedquery.description#',Now())
				</cfquery>
				
				<cfoutput>
				    <h3><a href="#link#" target="_blank">#title#</a></h3>
		  		    <p>
		        		#description#
				    </p>
					<hr>
				</cfoutput>
				<cfset email_send = 1>
			</cfif>
		</cfloop>
		</cfsavecontent>
		
		
		<cfif email_send EQ 1>
			<cfmail to="#GetSearch.c_emails#" from="jceci@sixfoottiger.com" subject="Craigslist Watch Alert - #feed.channel.title#" type="HTML">
			<h2><a href="#feed.channel.link#" target="_blank">#feed.channel.title#</a></h2>
			#html#
			</cfmail>
		</cfif>
		
		<cfquery name="Update" datasource="#request.dsn#">
			UPDATE craigslist_urls
			SET last_run = Now()
			WHERE urlid = #GetSearch.urlid#
		</cfquery>
		
		<cfcatch type="any">
			<cfmail to="tigeryan55@gmail.com" from="jceci@sixfoottiger.com" subject="Craigslist ERROR - #GetSearch.urlid#" type="HTML">
				<cfdump var="#GetSearch#">
			</cfmail>
		</cfcatch>
	</cftry>
	
	
</cfloop>