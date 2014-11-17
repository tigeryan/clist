<cfif IsDefined("url.uguid")>

	<cfquery name="CheckUID" datasource="#request.dsn#">
		SELECT uguid
		FROM craigslist_users
		WHERE uguid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#url.uguid#" />
	</cfquery>

	<cfif CheckUID.recordcount EQ 1>
		<cfcookie name="uguid" value="#url.uguid#">
	</cfif>
	
</cfif>

<cfif NOT IsDefined("Cookie.uguid")>
	You do not have access to this page<cfabort>
</cfif>

<cfif IsDefined("url.a")>
	<cfif a EQ "d">
		<cfquery name="Delete" datasource="#request.dsn#">
			DELETE FROM craigslist_watch_bookmarks
			WHERE watchid = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#url.watchid#" />
			AND uguid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.uguid#" />
		</cfquery>
	</cfif>
</cfif>


<cfquery name="GetBookmarks" datasource="#request.dsn#">
	SELECT craigslist_watch.watchid, c_url, c_title, c_desc, date_seen
	FROM craigslist_watch INNER JOIN craigslist_watch_bookmarks ON craigslist_watch.watchid = craigslist_watch_bookmarks.watchid
	WHERE craigslist_watch_bookmarks.uguid = <cfqueryparam cfsqltype="CF_SQL_VARCHAR" value="#Cookie.uguid#" />
	ORDER BY craigslist_watch_bookmarks.date_added DESC
</cfquery>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html>
<head>
	<title>CraigsList Bookmarks</title>
	<style>
	body
	{
		font-family:arial;
	}
	h1
	{
		font-size:16px;
	}
	p
	{
		font-size:14px;
	}
	</style>
</head>

<body>

<h1>CraigsList Watch Bookmarks</h1>

<cfoutput query="GetBookmarks">

<h1><a href="#GetBookmarks.c_url#" target="_blank">#GetBookmarks.c_title#</a> (posted: #DateFormat(GetBookmarks.date_seen,'mm/dd/yyyy')#)</h1>
<p>#GetBookmarks.c_desc#</p>
<p><a href="bookmarks.cfm?a=d&watchid=#GetBookmarks.watchid#">[delete bookmark]</a></p>

<hr />
</cfoutput>

</body>
</html>
