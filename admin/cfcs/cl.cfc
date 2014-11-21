<cfcomponent displayname="Craigslist" hint="Main CFC for the Craigslist System" output="false" >
 	<cfsetting showdebugoutput="false" />
 	<cfset variables.dsn = request.dsn />

 	<cffunction name="getUsers" displayname="getUsers" hint="get a list of users for a search url" output="false" returntype="query">
        <cfargument name="urlid" type="number" required="true" />

        <cfquery name="getUsers" datasource="#variables.dsn#">
            SELECT DISTINCT email
            FROM craigslist_users INNER JOIN craigslist_url_users ON craigslist_users.userid = craigslist_url_users.userid
            WHERE craigslist_users.userid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.urlid#" />
            ORDER BY email
        </cfquery>

        <cfreturn getUsers />
	</cffunction>

</cfcomponent>
