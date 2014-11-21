<cfdump var="#form#" />

<cfparam name="form.regions" default="southjersey" />
<cfparam name="form.userid" default="1" />
<cfparam name="form.search_url" default="" />

<cfif Len(form.search_url) NEQ 0>

    <cfloop list="#form.regions#" index="x">

        <cfset s_url = "http://#x#.craighslist.org#form.search_url#" />

        <cftransaction>

            <cfquery name="insertURL" datasource="#request.dsn#">
                INSERT INTO craigslist_urls(c_search, active)
                VALUES(<cfqueryparam cfsqltype="cf_sql_varchar" value="#s_url#" />,1)
            </cfquery>

            <cfquery name="getID" datasource="#request.dsn#">
                SELECT MAX(urlid) as ID
                FROM craigslist_urls
            </cfquery>

        </cftransaction>

        <cfloop list="#form.userid#" index="u">

            <cfquery name="insertUser" datasource="#request.dsn#">
                INSERT INTO craigslist_url_users(urlid, userid)
                VALUES(#getID.id#,#u#)
            </cfquery>

        </cfloop>

    </cfloop>
</cfif>
