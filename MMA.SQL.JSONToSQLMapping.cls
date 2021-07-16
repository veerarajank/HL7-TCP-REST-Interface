/// This child class is created to add the HL7 to JSON mapping 
Class MMA.SQL.JSONToSQLMapping Extends %Persistent
{

/// root table id 
Property RootId As %Integer;

/// json root or field or array map name
Property JSONMapping As %String(MAXLEN="50");

Property RootPath As %String(MAXLEN = "");

/// SQL server field name
Property SQLFieldName As %String(MAXLEN="50");

/// possible values - Field, Array
Property Type As %String(MAXLEN="50");

///This method inserts the child object using parent id
ClassMethod InsertChild(RootId As %Integer, MapName As %String, SQLFieldName As %String, Type As %String, Sequence As %String, SubRoot As %String) As %Status
{
	Set obj=..%New()
	Set obj.RootId=RootId
	Set obj.JSONMapping=MapName
	Set obj.SQLFieldName=SQLFieldName
	Set obj.Type=Type
	Set obj.Sequence=Sequence
	Set obj.SubRoot=SubRoot
	Do obj.%Save()
    RETURN $$$OK
}

Storage Default
{
<Data name="JSONToSQLMappingDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>RootId</Value>
</Value>
<Value name="3">
<Value>JSONMapping</Value>
</Value>
<Value name="4">
<Value>SQLFieldName</Value>
</Value>
<Value name="5">
<Value>Type</Value>
</Value>
<Value name="6">
<Value>Sequence</Value>
</Value>
<Value name="7">
<Value>SubRoot</Value>
</Value>
<Value name="8">
<Value>RootPath</Value>
</Value>
</Data>
<DataLocation>^MMA.SQL.JSONToSQLMappingD</DataLocation>
<DefaultData>JSONToSQLMappingDefaultData</DefaultData>
<IdLocation>^MMA.SQL.JSONToSQLMappingD</IdLocation>
<IndexLocation>^MMA.SQL.JSONToSQLMappingI</IndexLocation>
<StreamLocation>^MMA.SQL.JSONToSQLMappingS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
