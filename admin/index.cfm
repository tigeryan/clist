<cfinclude template="_header.cfm" />

<cfquery name="getURLS" datasource="#request.dsn#">
    SELECT urlid, c_search, last_run, active
    FROM craigslist_urls
    ORDER BY c_search
</cfquery>



            <div class="row">
                <div class="col-lg-12">
                    <div class="panel panel-default">
                        <div class="panel-heading">
                            Existing CraigsList Searches
                        </div>
                        <!-- /.panel-heading -->
                        <div class="panel-body">
                            <div class="table-responsive">
                                <table class="table table-striped table-bordered table-hover" id="dataTables-example">
                                    <thead>
                                        <tr>
                                            <th>Search URL</th>
                                            <th>Last Run</th>
                                            <th>Active?</th>
                                            <th>Users</th>
                                            <th>Options</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <cfoutput query="getURLS">
                                        <tr class="odd gradeX">
                                            <td>#getURLS.c_search#</td>
                                            <td>#DateFormat(getURLS.last_run,"mm/dd/yyyy")# #TimeFormat(getURLS.last_run,"hh:mm tt")#</td>
                                            <td>#getURLS.active#</td>
                                            <td class="center">USERS</td>
                                            <td class="center">[[edit]]</td>
                                        </tr>
                                        </cfoutput>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.table-responsive -->
                        </div>
                        <!-- /.panel-body -->
                    </div>
                    <!-- /.panel -->
                </div>
                <!-- /.col-lg-12 -->
            </div>



<cfinclude template="_footer.cfm" />
