Class MMA.TCP.RequestInput Extends %Persistent
{

Property TCPStream As Ens.StreamContainer;

Property Port As %Integer;

Storage Default
{
<Data name="RequestInputDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>TCPStream</Value>
</Value>
<Value name="3">
<Value>Port</Value>
</Value>
</Data>
<DataLocation>^MMA.TCP.RequestInputD</DataLocation>
<DefaultData>RequestInputDefaultData</DefaultData>
<IdLocation>^MMA.TCP.RequestInputD</IdLocation>
<IndexLocation>^MMA.TCP.RequestInputI</IndexLocation>
<StreamLocation>^MMA.TCP.RequestInputS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
