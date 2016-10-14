# Copyright (c) 2016 Microsoft Corporation. All Rights Reserved.
# Licensed under the MIT License (MIT)

function Set-RsEmailSettingsAsBasicAuth
{
    <#
    .SYNOPSIS
        This script configures the Email Settings for SQL Server Reporting Services.

    .DESCRIPTION
        This script configures the Email Settings for SQL Server Reporting Services.

    .PARAMETER SqlServerInstance (optional)
        Specify the name of the SQL Server Reporting Services Instance.

    .PARAMETER SqlServerVersion (optional)
        Specify the version of the SQL Server Reporting Services Instance. 13 for SQL Server 2016, 12 for SQL Server 2014, 11 for SQL Server 2012

    .PARAMETER SmtpServer 
        Specify the SMTP Server address.

    .PARAMETER SenderAddress 
        Specify sender email address for the email. 
    
    .PARAMETER EmailCredentials
        Specify credentials to specify when connecting to the SMTP server.

    .LINK
        https://blogs.msdn.microsoft.com/sqlrsteamblog/2016/07/15/deliver-reports-via-email-using-an-email-server-outside-your-network/

    .EXAMPLE
        Set-RSEmailSettingsAsBasicAuth -SmtpServer outlook.office365.com -SenderAddress johndoe@microsoft.com -EmailCredentials johndoe@microsoft.com
        Description
        -----------
        This command will configure the default instance from SQL Server 2016 Reporting Services to use Basic Auth with the specified SMTP Server, Sender Address, Username and Password when sending emails.

    .EXAMPLE
        Set-RSEmailSettingsAsBasicAuth -SqlServerInstance 'MySQL2016' -SqlServerVersion '13' -SmtpServer smtp.gmail.com -SenderAddress johndoe@gmail.com -EmailCredentials johndoe@gmail.com 
        Description
        -----------
        This command will configure the named instance (SQL2016) from SQL Server 2016 Reporting Services to use Basic Auth with the specified SMTP Server, Sender Address, Username and Password when sending emails.
    #>

    [cmdletbinding()]
    param
    (
        [string]
        $SqlServerInstance='MSSQLSERVER',
        
        [string]
        $SqlServerVersion='13',
        
        [Parameter(Mandatory=$True)]
        [string]
        $SmtpServer,

        [Parameter(Mandatory=$True)]
        [string]
        $SenderAddress,

        [Parameter(Mandatory=$True)]
        [System.Management.Automation.PSCredential]
        $EmailCredentials
    )

    $rsWmiObject = New-RsConfigurationSettingObject -SqlServerInstance $SqlServerInstance -SqlServerVersion $SqlServerVersion
    $rsWmiObject.SetAuthenticatedEmailConfiguration($true, $SmtpServer, $SenderAddress, $EmailUsername.Username, $EmailPassword.GetNetworkCredential().Password, 1, $true)
}
