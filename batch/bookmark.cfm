<cfquery name="CheckUID" datasource="#request.dsn#">
	SELECT uguid
	FROM craigslist_users
	WHERE uguid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.uguid#" />
</cfquery>

<cfif CheckUID.recordcount EQ 1>

	<cfcookie name="uguid" value="#url.uguid#">

	<cfquery name="CheckWatch" datasource="#request.dsn#">
		SELECT watchid
		FROM craigslist_watch
		WHERE watchid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.watchid#" />
	</cfquery>
	
	<cfif CheckWatch.recordcount EQ 1>
	
		<cfquery name="CheckBookmark" datasource="#request.dsn#">
			SELECT bookmarkid
			FROM craigslist_watch_bookmarks
			WHERE watchid = #CheckWatch.watchid# AND uguid = '#CheckUID.uguid#'
		</cfquery>
		
		<cfif CheckBookmark.recordcount EQ 0>
		
			<cfquery name="InsertBookmark" datasource="#request.dsn#">
				INSERT INTO craigslist_watch_bookmarks(watchid,uguid,date_added)
				VALUES(#CheckWatch.watchid#,'#CheckUID.uguid#',Now())
			</cfquery>
			
			<h2>Bookmark Set</h2>
			
			<p><a href="bookmarks.cfm">View Bookmarks</a></p>
	
		</cfif>
	
	</cfif>

</cfif>