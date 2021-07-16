Class MMA.SQL.tmpStore Extends %Persistent
{

Property Value1 As %String;

Property Value2 As %String;

Property Value3 As %String;

Index IdxValue On (Value1, Value2, Value3) [ Unique ];

Storage Default
{
<Data name="tmpStoreDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Value1</Value>
</Value>
<Value name="3">
<Value>Value2</Value>
</Value>
<Value name="4">
<Value>Value3</Value>
</Value>
</Data>
<DataLocation>^MMA.SQL.tmpStoreD</DataLocation>
<DefaultData>tmpStoreDefaultData</DefaultData>
<IdLocation>^MMA.SQL.tmpStoreD</IdLocation>
<IndexLocation>^MMA.SQL.tmpStoreI</IndexLocation>
<StreamLocation>^MMA.SQL.tmpStoreS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
