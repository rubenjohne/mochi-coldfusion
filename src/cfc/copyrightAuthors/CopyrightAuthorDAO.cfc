<cfcomponent output="false">

	<cffunction name="read" output="false" access="public" returntype="mochi.cfc.copyrightAuthors.CopyrightAuthor">
		<cfargument name="id" required="true">
		<cfset var qRead="">
		<cfset var obj="">

		<cfquery name="qRead" datasource="Mochi">
			select 	CopyrightAuthorID, Author, Citizenship, DateOfBirth, CreatedBy, CreatedDate, 
					LastMaintainedBy, LastMaintainedDate
			from CopyrightAuthors
			where CopyrightAuthorID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.id#" />
		</cfquery>

		<cfscript>
			obj = createObject("component", "mochi.cfc.copyrightAuthors.CopyrightAuthor").init();
			obj.setCopyrightAuthorID(qRead.CopyrightAuthorID);
			obj.setAuthor(qRead.Author);
			obj.setCitizenship(qRead.Citizenship);
			obj.setDateOfBirth(qRead.DateOfBirth);
			obj.setCreatedBy(qRead.CreatedBy);
			obj.setCreatedDate(qRead.CreatedDate);
			obj.setLastMaintainedBy(qRead.LastMaintainedBy);
			obj.setLastMaintainedDate(qRead.LastMaintainedDate);
			return obj;
		</cfscript>
	</cffunction>



	<cffunction name="create" output="false" access="public">
		<cfargument name="bean" required="true" type="mochi.cfc.copyrightAuthors.CopyrightAuthor">
		<cfset var qCreate="">

		<cfset var qGetId="">

		<cfset var local1=arguments.bean.getAuthor()>
		<cfset var local2=arguments.bean.getCitizenship()>
		<cfset var local3=arguments.bean.getDateOfBirth()>
		<cfset var local4=arguments.bean.getCreatedBy()>
		<cfset var local5=arguments.bean.getCreatedDate()>
		<cfset var local6=arguments.bean.getLastMaintainedBy()>
		<cfset var local7=arguments.bean.getLastMaintainedDate()>

		<cftransaction isolation="read_committed">
			<cfquery name="qCreate" datasource="Mochi">
				insert into CopyrightAuthors(Author, Citizenship, DateOfBirth, CreatedBy, CreatedDate, LastMaintainedBy, LastMaintainedDate)
				values (
					<cfqueryparam value="#local1#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local2#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local3#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local3 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local4#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local5#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local5 eq ""), de("yes"), de("no"))#" />,
					<cfqueryparam value="#local6#" cfsqltype="CF_SQL_VARCHAR" />,
					<cfqueryparam value="#local7#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local7 eq ""), de("yes"), de("no"))#" />
				)
			</cfquery>

			<!--- If your server has a better way to get the ID that is more reliable, use that instead --->
			<cfquery name="qGetID" datasource="Mochi">
				select CopyrightAuthorID
				from CopyrightAuthors
				where Author = <cfqueryparam value="#local1#" cfsqltype="CF_SQL_VARCHAR" />
				  and Citizenship = <cfqueryparam value="#local2#" cfsqltype="CF_SQL_VARCHAR" />
				  and DateOfBirth = <cfqueryparam value="#local3#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local3 eq ""), de("yes"), de("no"))#" />
				  and CreatedBy = <cfqueryparam value="#local4#" cfsqltype="CF_SQL_VARCHAR" />
				  and CreatedDate = <cfqueryparam value="#local5#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local5 eq ""), de("yes"), de("no"))#" />
				  and LastMaintainedBy = <cfqueryparam value="#local6#" cfsqltype="CF_SQL_VARCHAR" />
				  and LastMaintainedDate = <cfqueryparam value="#local7#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((local7 eq ""), de("yes"), de("no"))#" />
				order by CopyrightAuthorID desc
			</cfquery>
		</cftransaction>

		<cfscript>
			arguments.bean.setCopyrightAuthorID(qGetID.CopyrightAuthorID);
		</cfscript>
		<cfreturn arguments.bean />
	</cffunction>



	<cffunction name="update" output="false" access="public">
		<cfargument name="bean" required="true" type="mochi.cfc.copyrightAuthors.CopyrightAuthor">
		<cfset var qUpdate="">

		<cfquery name="qUpdate" datasource="Mochi" result="status">
			update CopyrightAuthors
			set Author = <cfqueryparam value="#arguments.bean.getAuthor()#" cfsqltype="CF_SQL_VARCHAR" />,
				Citizenship = <cfqueryparam value="#arguments.bean.getCitizenship()#" cfsqltype="CF_SQL_VARCHAR" />,
				DateOfBirth = <cfqueryparam value="#arguments.bean.getDateOfBirth()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.bean.getDateOfBirth() eq ""), de("yes"), de("no"))#" />,
				CreatedBy = <cfqueryparam value="#arguments.bean.getCreatedBy()#" cfsqltype="CF_SQL_VARCHAR" />,
				CreatedDate = <cfqueryparam value="#arguments.bean.getCreatedDate()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.bean.getCreatedDate() eq ""), de("yes"), de("no"))#" />,
				LastMaintainedBy = <cfqueryparam value="#arguments.bean.getLastMaintainedBy()#" cfsqltype="CF_SQL_VARCHAR" />,
				LastMaintainedDate = <cfqueryparam value="#arguments.bean.getLastMaintainedDate()#" cfsqltype="CF_SQL_TIMESTAMP" null="#iif((arguments.bean.getLastMaintainedDate() eq ""), de("yes"), de("no"))#" />
			where CopyrightAuthorID = <cfqueryparam value="#arguments.bean.getCopyrightAuthorID()#" cfsqltype="CF_SQL_INTEGER">
		</cfquery>
		<cfreturn arguments.bean />
	</cffunction>



	<cffunction name="delete" output="false" access="public" returntype="void">
		<cfargument name="bean" required="true" type="mochi.cfc.copyrightAuthors.CopyrightAuthor">
		<cfset var qDelete="">

		<cfquery name="qDelete" datasource="Mochi" result="status">
			delete
			from CopyrightAuthors
			where CopyrightAuthorID = <cfqueryparam cfsqltype="CF_SQL_INTEGER" value="#arguments.bean.getCopyrightAuthorID()#" />
		</cfquery>

	</cffunction>


</cfcomponent>