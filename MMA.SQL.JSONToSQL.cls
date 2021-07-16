/// This parent class is created to add the HL7 to JSON table name and mapping name 
Class MMA.SQL.JSONToSQL Extends %Persistent
{

/// SQL server table name
Property TableName As %String(MAXLEN=100);

/// unique map name to differentiate JSON
Property MappingName As %String(MAXLEN=100);

/// This method is to create the parent object
ClassMethod InsertMapping(TableName AS %String, MapName As %String) As %Integer
{
	Set obj=..%New()
	Set obj.TableName=TableName
	Set obj.MappingName=MapName
	Do obj.%Save()
	RETURN obj.%Id()
}

/// This method is one time script to add the ADT messages json structure in this table
ClassMethod OneTimeScript()
{
	//d ##class(MMA.SQL.JSONToSQL).OneTimeScript()
	#Dim root As MMA.SQL.JSONToSQL
 	Set root=..OneTimeADTA01()
 	Set root=..OneTimeADTA18()
 	Set root=..OneTimeADTA24()
 	Set root=..OneTimeQ22()
 	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="id"
 	#; root path of the json
 	Set obj.RootPath="content->linkIdsDeleted"
 	#; here i assume the MRN as SQL Server field name
 	Set obj.SQLFieldName="NativeIDDeleted"
 	Set obj.Type="Array"
 	Do obj.%Save()
}
/// ADT A23 request
ClassMethod OneTimeADTA23() As MMA.SQL.JSONToSQL
{
    #; ADT A23 request
 	Set root=##class(MMA.SQL.JSONToSQL).%New()
	#; Here i assume PatientLink as SQL Server table name
	Set root.TableName="PatientLink"
	#; Here i assume VeratoA23 as Unique mapping name for the messages A23
	Set root.MappingName="VeratoA23"
	Do root.%Save()
    RETURN root
}
/// ADT Q22 request
ClassMethod OneTimeQ22() As MMA.SQL.JSONToSQL
{
    #; Q22 common structure
	Set root=##class(MMA.SQL.JSONToSQL).%New()
	#; Here i assume Verato Tracking as SQL Server table name
	Set root.TableName="VeratoTracking"
	#; Here i assume VeratoQ22 as Unique mapping name for the messages Q22
	Set root.MappingName="VeratoQ22"
	Do root.%Save()
	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="id"
 	#; root path of the json
 	Set obj.RootPath="content->identity->sources"
 	#; here i assume the MRN as SQL Server field name
 	Set obj.SQLFieldName="MRN"
 	Set obj.Type="Array"
 	Do obj.%Save()
 	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
 	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="name"
 	#; root path of the json
 	Set obj.RootPath="content->identity->sources"
 	#; here i assume the Source as SQL Server field name
 	Set obj.SQLFieldName="Source"
 	Set obj.Type="Array"
 	Do obj.%Save()
 	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
 	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="linkId"
 	#; root path of the json
 	Set obj.RootPath="content->identity"
 	#; here i assume the LinkID as SQL Server field name
 	Set obj.SQLFieldName="LinkID"
 	Set obj.Type="Field"
 	Do obj.%Save()
     RETURN obj
}
/// ADT A24 request
ClassMethod OneTimeADTA24() As MMA.SQL.JSONToSQL
{
    #; ADT A24 structure
	Set root=##class(MMA.SQL.JSONToSQL).%New()
	#; Here i assume Verato Tracking as SQL Server table name
	Set root.TableName="VeratoTracking"
	#; Here i assume VeratoADT24 as Unique mapping name for the messages A24
	Set root.MappingName="VeratoADT24"
	Do root.%Save()
	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="id"
 	#; root path of the json
 	Set obj.RootPath="content->linkToSource"
 	#; here i assume the MRN as SQL Server field name
 	Set obj.SQLFieldName="MRN"
 	Set obj.Type="Field"
 	Do obj.%Save()
 	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
 	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="name"
 	#; root path of the json
 	Set obj.RootPath="content->linkToSource"
 	#; here i assume the Source as SQL Server field name
 	Set obj.SQLFieldName="Source"
 	Set obj.Type="Field"
 	Do obj.%Save()
 	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
 	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="linkId"
 	#; root path of the json
 	Set obj.RootPath="content"
 	#; here i assume the LinkID as SQL Server field name
 	Set obj.SQLFieldName="LinkID"
 	Set obj.Type="Field"
 	Do obj.%Save()
     RETURN obj
}
/// ADT A18 request
ClassMethod OneTimeADTA18() As MMA.SQL.JSONToSQL
{
    #; ADT A18 structure
	Set root=##class(MMA.SQL.JSONToSQL).%New()
	#; Here i assume Verato Tracking as SQL Server table name
	Set root.TableName="VeratoTracking"
	#; Here i assume VeratoADT18 as Unique mapping name for the messages A18
	Set root.MappingName="VeratoADT18"
	Do root.%Save()
	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="id"
 	#; root path of the json
 	Set obj.RootPath="content->toSurviveSource"
 	#; here i assume the trackId as SQL Server field name
 	Set obj.SQLFieldName="MRN"
 	Set obj.Type="Field"
 	Do obj.%Save()
 	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
 	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="name"
 	#; root path of the json
 	Set obj.RootPath="content->toSurviveSource"
 	#; here i assume the Source as SQL Server field name
 	Set obj.SQLFieldName="Source"
 	Set obj.Type="Field"
 	Do obj.%Save()
 	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
 	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="linkId"
 	#; root path of the json
 	Set obj.RootPath="content"
 	#; here i assume the LinkID as SQL Server field name
 	Set obj.SQLFieldName="LinkID"
 	Set obj.Type="Field"
 	Do obj.%Save()
     RETURN obj
}
/// ADT A01 request
ClassMethod OneTimeADTA01() As MMA.SQL.JSONToSQL
{
    #; ADT A01,A04,A05,A28,A08 common structure
	Set root=##class(MMA.SQL.JSONToSQL).%New()
	#; Here i assume Verato Tracking as SQL Server table name
	Set root.TableName="PatientLink"
	#; Here i assume VeratoADT01 as Unique mapping name for the messages A01,A04,A05,A28,A08
	Set root.MappingName="VeratoADT01"
	Do root.%Save()
	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="id"
 	#; root path of the json
 	Set obj.RootPath="content->linkIdentity->sources"
 	#; here i assume the MRN as SQL Server field name
 	Set obj.SQLFieldName="MRN"
 	Set obj.Type="Array"
 	Do obj.%Save()
 	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
 	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="name"
 	#; root path of the json
 	Set obj.RootPath="content->linkIdentity->sources"
 	#; here i assume the Source as SQL Server field name
 	Set obj.SQLFieldName="Source"
 	Set obj.Type="Array"
 	Do obj.%Save()
 	Set obj=##class(MMA.SQL.JSONToSQLMapping).%New()
 	#; root id of the parent table
 	Set obj.RootId=root.%Id()
 	#; json field name
 	Set obj.JSONMapping="linkId"
 	#; root path of the json
 	Set obj.RootPath="content->linkIdentity"
 	#; here i assume the LinkID as SQL Server field name
 	Set obj.SQLFieldName="LinkID"
 	Set obj.Type="Field"
 	Do obj.%Save()
     RETURN obj
}

Storage Default
{
<Data name="JSONToSQLDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>TableName</Value>
</Value>
<Value name="3">
<Value>MappingName</Value>
</Value>
</Data>
<DataLocation>^MMA.SQL.JSONToSQLD</DataLocation>
<DefaultData>JSONToSQLDefaultData</DefaultData>
<IdLocation>^MMA.SQL.JSONToSQLD</IdLocation>
<IndexLocation>^MMA.SQL.JSONToSQLI</IndexLocation>
<StreamLocation>^MMA.SQL.JSONToSQLS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
