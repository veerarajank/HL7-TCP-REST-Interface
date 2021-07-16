/// Request object to handle JSON message transfer
Class MMA.SQL.Request Extends %Persistent
{

Property JSON As %String(MAXLEN = "");

Property MappingName As %String(MAXLEN = "50");

Storage Default
{
<Data name="RequestDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>JSON</Value>
</Value>
<Value name="3">
<Value>MappingName</Value>
</Value>
</Data>
<DataLocation>^MMA.SQL.RequestD</DataLocation>
<DefaultData>RequestDefaultData</DefaultData>
<IdLocation>^MMA.SQL.RequestD</IdLocation>
<IndexLocation>^MMA.SQL.RequestI</IndexLocation>
<StreamLocation>^MMA.SQL.RequestS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
