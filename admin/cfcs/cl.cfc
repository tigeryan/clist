<cfcomponent displayname="Craigslist" hint="Main CFC for the Craigslist System" output="false" >
 	<cfsetting showdebugoutput="false" />
 	<cfset variables.dsn = request.dsn />

 	<cffunction name="getUsers" displayname="getUsers" hint="get a list of users for a search url" output="false" returntype="query">
        <cfargument name="urlid" type="number" required="true" />

        <cfquery name="getUsers" datasource="#variables.dsn#">
            SELECT DISTINCT email, craigslist_users.userid
            FROM craigslist_users INNER JOIN craigslist_url_users ON craigslist_users.userid = craigslist_url_users.userid
            WHERE craigslist_url_users.urlid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.urlid#" />
            ORDER BY email
        </cfquery>

        <cfreturn getUsers />
	</cffunction>

 	<cffunction name="getAllUsers" displayname="getAllUsers" hint="get a list of users" output="false" returntype="query">

        <cfquery name="getAllUsers" datasource="#variables.dsn#">
            SELECT userid, email, uguid
            FROM craigslist_users
            ORDER BY email
        </cfquery>

        <cfreturn getAllUsers />
	</cffunction>

 	<cffunction name="getURLS" displayname="getURLS" hint="get a list of url" output="false" returntype="query">

        <cfquery name="getURLS" datasource="#request.dsn#">
            SELECT urlid, c_search, last_run, active
            FROM craigslist_urls
            ORDER BY c_search
        </cfquery>

        <cfreturn getURLS />
	</cffunction>

 	<cffunction name="getURL" displayname="getURL" hint="get a url" output="false" returntype="query">
        <cfargument name="urlid" type="number" required="true" />

        <cfquery name="getURL" datasource="#request.dsn#">
            SELECT urlid, c_search, last_run, active
            FROM craigslist_urls
			WHERE craigslist_urls.urlid = <cfqueryparam cfsqltype="cf_sql_integer" value="#arguments.urlid#" />
        </cfquery>

        <cfreturn getURL />
	</cffunction>


 	<cffunction name="setActive" displayname="setActive" hint="set a URL as active or inactive"  returnformat="plain" output="false" access="remote">
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

        <cfreturn '[{"active":#return_val#}]' />
	</cffunction>

	<!--- DEMO SERIALIZER --->
	<cffunction name="getGallery" access="remote" returnformat="plain" output="false">

		<!--- , party_desc, last_updated --->
		<cfquery name="getList" datasource="#request.dsn#">
			SELECT party_main.partyid, party_main.party_title, CONCAT('http://www.bodiesbybean.com/images/gallery/',party_images.thumb_image) as thumb_image
			FROM party_main inner join party_images on party_main.partyid = party_images.partyid AND party_images.cover_photo = 1
			WHERE party_main.active = 1
			ORDER BY party_main.party_title
		</cfquery>

		<cfscript>
			serializer = new JsonSerializer()
				.asInteger("partyid")
				.asString("party_title")
				.asString("thumb_image")
			;
		</cfscript>

		<cfreturn serializer.serialize(getList) />
	</cffunction>
	<!--- END DEMO --->


</cfcomponent>
