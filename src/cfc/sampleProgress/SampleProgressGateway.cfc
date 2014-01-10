<cfcomponent output="false">

	<cffunction name="getById" output="false" access="remote">
		<cfargument name="id" required="true" />
 		<cfreturn createObject("component", "SampleProgressDAO").read(arguments.id)>
	</cffunction>


	<cffunction name="save" output="false" access="remote">
		<cfargument name="obj" required="true" />
 		<cfscript>
			if( obj.getSampleProgressID() eq 0 )
			{
				return createObject("component", "SampleProgressDAO").create(arguments.obj);
			} else {
				return createObject("component", "SampleProgressDAO").update(arguments.obj);
			}
		</cfscript>
	</cffunction>


	<cffunction name="deleteById" output="false" access="remote">
		<cfargument name="id" required="true" />
		<cfset var obj = getById(arguments.id)>
		<cfset createObject("component", "SampleProgressDAO").delete(obj)>
	</cffunction>



	<cffunction name="getAll" output="false" access="remote" returntype="mochi.cfc.sampleProgress.SampleProgress[]">
		<cfset var qRead="">
		<cfset var obj="">
		<cfset var ret=arrayNew(1)>

		<cfquery name="qRead" datasource="Mochi">
			select SampleProgressID
			from SampleProgress
		</cfquery>

		<cfloop query="qRead">
		<cfscript>
			obj = createObject("component", "SampleProgressDAO").read(qRead.SampleProgressID);
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
			from SampleProgress
		</cfquery>

		<cfreturn qRead>
	</cffunction>



	<cffunction name="getBySampleRequestId" output="false" access="remote" returntype="query">
		<cfargument name="id" required="true">
		<cfargument name="fieldlist" default="*" hint="List of columns to be returned in the query.">

		<cfset var qRead="">

		<cfquery name="qRead" datasource="Mochi">
			select #arguments.fieldList#
			from SampleProgress
			where SampleRequestID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#" /> 
		</cfquery>

		<cfreturn qRead>
	</cffunction>



</cfcomponent>