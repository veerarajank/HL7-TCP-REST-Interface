Class MMA.Task.SearchNotification Extends %SYS.Task.Definition
{

/// This task is intented to run on the Processing servers to help monitorize the production and have always up&running
Method OnTask() As %Status
{
	Set LastRun=$G(^SearchNotificationConfig("LastRun"),$P($zdt($h,3,5),"+",1))
	Set CurrentRun=$P($zdt($h,3,5),"+",1)
	Set ^SearchNotificationConfig("LastRun")=CurrentRun
	If LastRun=CurrentRun Quit
	Do ..Initiate(LastRun,CurrentRun)
	Quit $$$OK
}

ClassMethod Initiate(FromDateTime As %String, ToDateTime As %String)
{
	Set request=##class(Ens.StringContainer).%New()
	Set request.StringValue=FromDateTime_"^"_ToDateTime
	Set obj=##class(MMC.REST.SearchNotifications).%New("MMC.REST.SearchNotifications")
	Do obj.SearchNotifcation(request)
	Quit
}

}
