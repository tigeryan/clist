<cfparam name="url.urlid" default="0" />

<cfset url.urlid = Val(url.urlid) />

<cfset cl = new cfcs.cl() />
<cfset getAllUsers = cl.getAllUsers() />
<cfset getUsers = cl.getUsers(url.urlid) />
<cfset getURL = cl.getURL(url.urlid) />

<cfinclude template="_header.cfm" />

            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">Edit CraigsList Search URL</div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form method="post" action="edit_url_save.cfm" role="form">

									<div class="form-group">
									<label for="search_url">Search URL without region (i.e. /search/sss?query=mustang&format=rss)</label>
									<cfoutput>
									<input type="text" name="search_url" id="search_url" size="100" maxlength="255" value="#getURL.c_search#" />
									</cfoutput>
									<p class="help-block">Enter the URL that will be used for each region</p>
									</div>

									<div class="form-group">
									<label for="userid">Users</label>
										<select name="userid" id="userid" multiple="multiple" size="5" class="form-control">
											<cfoutput query="getAllUsers">
												<option value="#getAllUsers.userid#" <cfif ListFind(ValueList(getUsers.userid),getAllUsers.userid)>selected="selected"</cfif> >#getAllUsers.email#</option>
											</cfoutput>
										</select>
									<p class="help-block">Select which users to send alerts to</p>
									</div>

									<button type="submit" class="btn btn-outline btn-primary">Save Changes</button>

									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

<cfinclude template="_footer.cfm" />
