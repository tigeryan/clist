<cfparam name="form.email" default="" />
<cfparam name="form.password" default="" />

<cfset cl = new cfcs.cl() />
<cfset checkUser = cl.checkUser(form.email) />

<cfif NOT checkUser.recordcount>

	<cfset cl.addUser(form.email, form.password ) />

</cfif>

<cflocation url="users.cfm" addtoken="false" />