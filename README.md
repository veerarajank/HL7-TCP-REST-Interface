# HL7 - TCP - REST - Interface 

        TCP messages integrated to external REST API

Flow : 

* This project contains the ADT messages received via TCP business service and forwards the HL7 Message to the Business process acting as a Router.
* Business process (Router) based on the message type send to external API via Rest Business operation.
* Finally, the response received from API would be logged to the external SQL Server via SQL business operation. 

Tools used :

  * Intersystems Studio
  * Visual studio Code
  * Intersystems management portal
  * Soap-UI
