<cfdump var="#form#" />

<cfparam name="form.regions" default="southjersey" />
<cfparam name="form.userid" default="1" />
<cfparam name="form.search_url" default="" />

<cfif Len(form.search_url) NEQ 0>

    <cfloop list="#form.regions#" index="x">






    </cfloop>
</cfif>
