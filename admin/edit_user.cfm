<cfset cl = new cfcs.cl() />
<cfset checkUser = cl.checkUser(form.email) />

<cfinclude template="_header.cfm" />

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Edit CraigsList User</div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form method="post" action="edit_user_save.cfm" role="form">
									<cfoutput>
									<div class="form-group">
									<label for="search_url">User Email Address:</label>
									<input type="text" name="email" id="email" size="100" maxlength="255" value="#checkUser.email#" />
									<p class="help-block">Enter the email address for alerts to be delivered to</p>
									</div>
	
									<div class="form-group">
									<label for="regions">Password</label>
									<input type="text" name="password" id="password" size="100" maxlength="255" value="#checkUser.password#" />
									<p class="help-block">Enter the password (future use)</p>
									</div>
									</cfoutput>
									<button type="submit" class="btn btn-outline btn-primary">Edit User</button>
	
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

<cfinclude template="_footer.cfm" />