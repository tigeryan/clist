<cfparam name="form.urlid" default="0" />

<cfset cl = new cfcs.cl() />
<cfset getURL = cl.getURL(form.urlid) />

<cfif getURL.recordcount>

	<cfset cl.updateURL(form.urlid, form.c_search,form.userid) />

</cfif>

