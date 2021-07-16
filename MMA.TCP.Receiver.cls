Class MMA.TCP.Receiver Extends Ens.BusinessService
{

Parameter ADAPTER = "EnsLib.TCP.CountedInboundAdapter";

Method OnProcessInput(pInput As %Stream.Object, pOutput As %RegisteredObject) As %Status
{
	Set tSC=$$$OK
	Set ^Test=pInput.Read(64000)
	$$$TRACE(pInput.Read(64000))
	Quit tSC
}

}
