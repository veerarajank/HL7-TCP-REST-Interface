///Business operation to store the API log into SQL database
Class MMA.SQL.SQLOutbound Extends %Persistent
{

Parameter ADAPTER = "EnsLib.SQL.OutboundAdapter";

Property Adapter As EnsLib.SQL.OutboundAdapter;

Parameter INVOCATION = "Queue";

/// Start of BO
Method SampleCall(pRequest As POC.BO.Request, Output pResponse As Ens.Response) As %Status
{
	Set tSC=$$$OK
	Set MapName=pRequest.MappingName,RootId="",tablename=""
	Set JSONObj={}.%FromJSON(pRequest.JSON)
    
    Set rsTbl=##class(%ResultSet).%New()
    Do rsTbl.Prepare("Select Id,TableName from MMA_SQL.JSONToSQL where MappingName='"_MapName_"'")
    Do rsTbl.Execute()
    if (rsTbl.%Next())
    {
        Set RootId=rsTbl.GetData(1)
        Set tablename=rsTbl.GetData(2)
    }
    if RootId=""
    {
        RETURN tSC
    }
	elseif RootId>0
	{
		Do ##class(MMA.SQL.SQLOutbound).ReadFieldAndValues(JSONObj,RootId,.Array,.IsArray)
        If IsArray=1
		{
			For loop=0:1
			{
				Set Where=..FrameWhere(.Array,IsArray,loop,.isQueryOk,1)
				If isQueryOk=0 
                {
                    RETURN tSC
                }
				Set ReadSQL="Select Id from "_tablename_" where "_Where
				Set tSC=..Adapter.ExecuteQuery(.rs,ReadSQL)
				Do rs.%Next()
				Set Id=rs.%GetData(1)
				If Id>0
				{
					Set WriteSQL="UPDATE "_tablename_" SET "_..FrameWhere(.Array,IsArray,loop,.isQueryOk,2)_",DateTime="_$zdt($h,3)_" WHERE Id="_Id
					Set tSC=..Adapter.ExecuteUpdate(,WriteSQL)
				}
				Else
				{
					Set WriteSQL="INSERT INTO "_tablename_"("_..FrameWhere(.Array,IsArray,loop,.isQueryOk,1)_",DateTime) VALUES("_..FrameWhere(.Array,IsArray,loop,.isQueryOk,2)_","_$zdt($h,3)_")"
					Set tSC=..Adapter.ExecuteUpdate(,WriteSQL)
				}
			}
		}
        Else{
            RETURN tSC
        }
	}
    Set pResponse=##class(Ens.Response).%New()
    RETURN tSC
}

///Frame Where condition
ClassMethod FrameWhere(ByRef Array, isArray As %Integer = 0, pos As %String, ByRef isQueryOk, Flag As %Integer = 0) As %String
{
	Set FieldName="",Where="",isQueryOk=1
	For
	{
		Set FieldName=$O(Array(FieldName),1,value)
		if FieldName="" 
        {
            RETURN Where
        }
		If $D(Array(FieldName))=1
		{
			If Flag=3
			{
				If Where=""
				{
					Set Where=FieldName
				}
				Else
				{
					Set Where=Where_","_FieldName
				}
			}
			ElseIf Flag=4
			{
				If Where=""
				{
					Set Where="'"_value_"'"
				}
				Else
				{
					Set Where=Where_","_"'"_value_"'"
				}
			}
			Else
			{
				If Where=""
				{
					Set Where=FieldName_"='"_value_"'"
				}
				Else
				{
					Set Where=Where_$Case(Flag,1:" AND ",2:" , ",:"")_FieldName_"='"_value_"'"
				}
			}
		}
		ElseIf isArray=1
		{
			If $D(Array(FieldName,pos))
			{
				If Flag=3
				{
					If Where=""
					{
						Set Where=FieldName
					}
					Else
					{
						Set Where=Where_","_FieldName
					}
				}
				ElseIf Flag=4
				{
					If Where=""
					{
						Set Where="'"_$G(Array(FieldName,pos))_"'"
					}
					Else
					{
						Set Where=Where_","_"'"_$G(Array(FieldName,pos))_"'"
					}
				}
				Else
				{
					If Where=""
					{
						Set Where=FieldName_"='"_$G(Array(FieldName,pos))_"'"
					}
					Else
					{
						Set Where=Where_$Case(Flag,1:" AND ",2:" , ",:"")_FieldName_"='"_$G(Array(FieldName,pos))_"'"
					}
				}
			}
			Else
			{
				Set isQueryOk=0
			}
		}
		
	}
	RETURN Where
}

ClassMethod ReadFieldAndValues(JSONObj, RootId, ByRef Prepare, ByRef IsArray)
{
	Set IsArray=0
	Do ..ConvertJSONToArray(JSONObj,"",.Array)
	Set rs=##class(%ResultSet).%New()
	Do rs.Prepare("Select RootPath,JSONMapping,SQLFieldName,Type from MMA_SQL.JSONToSQLMapping where RootId="_RootId)
	Do rs.Execute()
	While(rs.Next())
	{
		Set RootPath=rs.GetData(1)
		Set JSONMapping=rs.GetData(2)
		Set SQLFieldName=rs.GetData(3)
		Set Type=rs.GetData(4)
		If Type="Field"
		{
			Set Prepare(SQLFieldName)=$G(Array(RootPath_"->"_JSONMapping))
		}
		ElseIf Type="Array"
		{
			Set IsArray=1
			For inc=0:1
			{
				If '$D(Array(RootPath_"->"_inc_"->"_JSONMapping))
                {
                    Quit
                }
				Set Prepare(SQLFieldName,inc)=Array(RootPath_"->"_inc_"->"_JSONMapping)
			}
		}
		
	}
}

///Convert to Array from JSON
ClassMethod ConvertJSONToArray(JSONObj, Root As %String = "", ByRef Array)
{
	If $IsObject(JSONObj)
	{
		Set iter=JSONObj.%GetIterator()
		Set Key=""
		For
		{
			If 'iter.%GetNext(.Key,.value)
            {
                Quit
            }
			Set Pass=Key
			If Root'=""
			{
				Set Pass=Root_"->"_Key
			}
			If $IsObject(value) 
			{
				Do ..ConvertJSONToArray(value,Pass,.Array)
			}
			ElseIf Root'=""
			{
				Set Array(Root_"->"_Key)=value
			}
			Else
			{
				Set Array(Key)=value
			}
		}
	}
}

ClassMethod FrameFields(ByRef Array, isArray As %Integer = 0, pos, ByRef isQueryOk, Flag As %Integer = 0)
{
	Set FieldName="",Where="",isQueryOk=1
	For
	{
		Set FieldName=$O(Array(FieldName),1,value)
		If FieldName="" 
        {
            Quit
        }
		If $D(Array(FieldName))=1
		{
			If Where=""
			{
				Set Where=$Case(Flag,1:FieldName,2:"'"_value_"'",:"")
			}
			Else
			{
				Set Where=Where_","_$Case(Flag,1:FieldName,2:"'"_value_"'",:"")
			}
		}
		ElseIf isArray=1
		{
			If $D(Array(FieldName,pos))
			{
				If Where=""
				{
					Set Where=$Case(Flag,1:FieldName,2:"'"_$G(Array(FieldName,pos))_"'",:"")
				}
				Else
				{
					Set Where=Where_","_$Case(Flag,1:FieldName,2:"'"_$G(Array(FieldName,pos))_"'",:"")
				}
			}
			Else
			{
				Set isQueryOk=0
			}
		}
		
	}
	RETURN Where
}

XData MessageMap
{
<MapItems>
  <MapItem MessageType="MMA.SQL.Request">
    <Method>SampleCall</Method>
  </MapItem>
</MapItems>
}

Storage Default
{
<Data name="SQLOutboundDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>Adapter</Value>
</Value>
</Data>
<DataLocation>^MMA.SQL.SQLOutboundD</DataLocation>
<DefaultData>SQLOutboundDefaultData</DefaultData>
<IdLocation>^MMA.SQL.SQLOutboundD</IdLocation>
<IndexLocation>^MMA.SQL.SQLOutboundI</IndexLocation>
<StreamLocation>^MMA.SQL.SQLOutboundS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}
