
<cfquery name="Insert" datasource="#request.dsn#">
	INSERT INTO craigslist_urls(c_search)
	VALUES('http://philadelphia.craigslist.org/search/sss?query=yukon&format=rss')
</cfquery>

<cfquery name="GetID" datasource="#request.dsn#">
	SELECT MAX(urlid) as id
	FROM craigslist_urls
</cfquery>

<cfquery name="InsertUser" datasource="#request.dsn#">
	INSERT INTO craigslist_url_users(urlid, userid)
	VALUES(#GetID.id#,1)
</cfquery>

<cfquery name="InsertUser" datasource="#request.dsn#">
	INSERT INTO craigslist_url_users(urlid, userid)
	VALUES(#GetID.id#,3)
</cfquery>
	