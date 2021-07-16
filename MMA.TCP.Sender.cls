Class MMA.TCP.Sender Extends Ens.BusinessOperation
{

Parameter ADAPTER = "EnsLib.TCP.CountedOutboundAdapter";

Method OnMessage(pRequest As Ens.StreamContainer, Output pResponse As %Persistent) As %Status
{
	Set SessionId=..%SessionId
	Set Start=$O(^Ens.MessageHeaderI("SessionId",SessionId,""))
	Set obj=##class(Ens.MessageHeader).%OpenId(Start)
	Set Source=obj.SourceConfigName
	Set Port=##class(Ens.Director).GetItemSettingValue(Source,"Adapter","Port",.status)
	Set ..Adapter.Port=Port
	Quit:'$IsObject(pRequest.Stream) $$$ERROR($$$EnsErrGeneral,"No Stream contained in StreamContainer Request")
	Set tSC=..Adapter.SendMessageStream(pRequest.Stream,.tReplyStream)  Quit:$$$ISERR(tSC) tSC
	If ..Adapter.GetReply {
		Set tReply=tReplyStream.Read()
		If $Case(tReply,"":0,"OK":0,:1) {
			Set tSC=$$$ERROR($$$EnsErrGeneral,"Remote acknowledgement not OK:"_$E(tReply,1,1000))
		}
	}
	Quit tSC
}

}
