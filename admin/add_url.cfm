<cfquery name="getUsers" datasource="#request.dsn#">
	SELECT *
	FROM craigslist_users
	ORDER BY email
</cfquery>

<cfset regions = "cnj,delaware,jerseyshore,philadelphia,southjersey" />

<cfinclude template="_header.cfm" />

            <div class="row">
                <div class="col-lg-12">
                    <h1 class="page-header">Forms</h1>
                </div>
                <!-- /.col-lg-12 -->
            </div>
            <!-- /.row -->
            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Basic Form Elements
                        </div>
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-6">
                                    <form method="post" action="add_url_save.cfm" role="form">

									<div class="form-group">
									<label for="search_url">Search URL without region (i.e. /search/sss?query=mustang&format=rss)</label>
									<input type="text" name="search_url" id="search_url" size="100" maxlength="255" />
									<p class="help-block">Enter the URL that will be used for each region</p>
									</div>
	
									<div class="form-group">
									<label for="regions">Search Regions</label>
										<select name="regions" id="regions" multiple="multiple" size="5" class="form-control">
											<cfloop index="x" list="#regions#">
												<cfoutput><option value="#x#">#x#</option></cfoutput>
											</cfloop>
										</select>
									<p class="help-block">Select which regions to search</p>
									</div>
									
									<div class="form-group">
									<label for="userid">Users</label>
										<select name="userid" id="userid" multiple="multiple" size="5" class="form-control">
											<cfoutput query="getUsers">
												<option value="#getUsers.userid#">#getUsers.email#</option>
											</cfoutput>
										</select>
									<p class="help-block">Select which users to send alerts to</p>
									</div>

									<button type="submit">Save URL</button>
	
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

<cfinclude template="_footer.cfm" />