<cfcomponent output="false">

	<cffunction name="getById" output="false" access="remote">
		<cfargument name="id" required="true" />
 		<cfreturn createObject("component", "FabricRequestDAO").read(arguments.id)>
	</cffunction>


	<cffunction name="save" output="false" access="remote">
		<cfargument name="obj" required="true" />
 		<cfscript>
			if( obj.getFabricRequestID() eq 0 )
			{
				return createObject("component", "FabricRequestDAO").create(arguments.obj);
			} else {
				return createObject("component", "FabricRequestDAO").update(arguments.obj);
			}
		</cfscript>
	</cffunction>


	<cffunction name="deleteById" output="false" access="remote">
		<cfargument name="id" required="true" />
		<cfset var obj = getById(arguments.id)>
		<cfset createObject("component", "FabricRequestDAO").delete(obj)>
	</cffunction>



	<cffunction name="getAll" output="false" access="remote" returntype="mochi.cfc.fabricRequests.FabricRequest[]">
		<cfset var qRead="">
		<cfset var obj="">
		<cfset var ret=arrayNew(1)>

		<cfquery name="qRead" datasource="Mochi">
			select FabricRequestID
			from FabricRequest
		</cfquery>

		<cfloop query="qRead">
		<cfscript>
			obj = createObject("component", "FabricRequestDAO").read(qRead.FabricRequestID);
			ArrayAppend(ret, obj);
		</cfscript>
		</cfloop>
		<cfreturn ret>
	</cffunction>



	<cffunction name="getAllAsQuery" output="false" access="remote" returntype="query">
		<cfargument name="fieldlist" default="*" hint="List of columns to be returned in the query.">

		<cfset var qRead="">

		<cfquery name="qRead" datasource="Mochi">
			select #arguments.fieldList#
			from FabricRequest
		</cfquery>

		<cfreturn qRead>
	</cffunction>




</cfcomponent>