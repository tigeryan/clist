<cfcomponent displayname="Craigslist" hint="Main CFC for the Craigslist System" output="false" >
 	<cfsetting showdebugoutput="false" />
 	<cfset variables.dsn = request.dsn />

 	<cffunction name="getUsers" displayname="getUsers" hint="get a list of users for a search url" output="false" returntype="query">
        <cfargument name="urlid" type="number" required="true" />

        <cfquery name="getUsers" datasource="#variables.dsn#">
            SELECT DISTINCT email
            FROM craigslist_users INNER JOIN craigslist_url_users ON craigslist_users.userid = craigslist_url_users.userid
            WHERE craigslist_url_users.urlid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.urlid#" />
            ORDER BY email
        </cfquery>

        <cfreturn getUsers />
	</cffunction>

 	<cffunction name="getURLS" displayname="getURLS" hint="get a list of url" output="false" returntype="query">

        <cfquery name="getURLS" datasource="#request.dsn#">
            SELECT urlid, c_search, last_run, active
            FROM craigslist_urls
            ORDER BY c_search
        </cfquery>

        <cfreturn getURLS />
	</cffunction>

 	<cffunction name="setActive" displayname="setActive" hint="set a URL as active or inactive" output="false" returns="struct" access="remote">
        <cfargument name="urlid" type="number" required="true" />

        <cfquery name="getURL" datasource="#request.dsn#">
            SELECT urlid, c_search, last_run, active
            FROM craigslist_urls
            WHERE craigslist_urls.urlid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.urlid#" />
        </cfquery>

        <cfset return_val = "-1" />

        <cfif getURL.recordcount>

            <cfquery name="updateURL" datasource="#request.dsn#">
                UPDATE craigslist_urls
                SET active = <cfif getURL.active EQ 1>0<cfelse>1</cfif>
                WHERE craigslist_urls.urlid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.urlid#" />
            </cfquery>

            <cfif getURL.active EQ 1>
                <cfset return_val = "0" />
            <cfelse>
                <cfset return_val = "1" />
            </cfif>

        </cfif>

        <cfreturn { "active"=javaCast("int", return_val)} />
	</cffunction>




</cfcomponent>
