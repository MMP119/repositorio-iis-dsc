Configuration IisSeguro {
    Import-DscResource `
    	-ModuleName PSDesiredStateConfiguration `
    	-Name WindowsFeature, Registry

    Import-DscResource `
    -ModuleName WebAdministrationDsc `
    -ModuleVersion '4.2.1' `
    -Name WebConfigProperty, WebConfigPropertyCollection, WebAppPool

    Node $AllNodes.NodeName {
        WindowsFeature IIS {
            Ensure = 'Present'
            Name   = 'Web-Server'
        }

        WindowsFeature IISManagement {
            Ensure    = 'Present'
            Name      = 'Web-Mgmt-Tools'
            DependsOn = '[WindowsFeature]IIS'
        }

        WindowsFeature IISScriptingTools {
            Ensure    = 'Present'
            Name      = 'Web-Scripting-Tools'
            DependsOn = '[WindowsFeature]IIS'
        }

        WindowsFeature IISRequestFiltering {
            Ensure    = 'Present'
            Name      = 'Web-Filtering'
            DependsOn = '[WindowsFeature]IIS'
        }

        WindowsFeature IISDirectoryBrowsing {
            Ensure    = 'Present'
            Name      = 'Web-Dir-Browsing'
            DependsOn = '[WindowsFeature]IIS'
        }

        WebConfigProperty DisableDirectoryBrowsing {
            WebsitePath  = $Node.IisConfigPath
            Filter       = 'system.webServer/directoryBrowse'
            PropertyName = 'enabled'
            Value        = 'False'
            Ensure       = 'Present'

            DependsOn = @(
                '[WindowsFeature]IISDirectoryBrowsing'
                '[WindowsFeature]IISScriptingTools'
            )
        }

        WebConfigProperty RemoveServerHeader {
            WebsitePath  = $Node.IisConfigPath
            Filter       = 'system.webServer/security/requestFiltering'
            PropertyName = 'removeServerHeader'
            Value        = 'True'
            Ensure       = 'Present'

            DependsOn = @(
                '[WindowsFeature]IISRequestFiltering'
                '[WindowsFeature]IISScriptingTools'
            )
        }

        WebConfigPropertyCollection RemoveXPoweredBy {
            WebsitePath      = $Node.IisConfigPath
            Filter           = 'system.webServer/httpProtocol'
            CollectionName   = 'customHeaders'
            ItemName         = 'add'
            ItemKeyName      = '*'
            ItemKeyValue     = 'X-Powered-By'
            ItemPropertyName = 'name'
            Ensure           = 'Absent'

            DependsOn = '[WindowsFeature]IISScriptingTools'
        }
	
	WebConfigPropertyCollection DenyHttpTrace {
    	    WebsitePath       = $Node.IisConfigPath
	    Filter            = 'system.webServer/security/requestFiltering'
	    CollectionName    = 'verbs'
	    ItemName          = 'add'
	    ItemKeyName       = 'verb'
	    ItemKeyValue      = 'TRACE'
	    ItemPropertyName  = 'allowed'
	    ItemPropertyValue = 'False'
	    Ensure            = 'Present'

	    DependsOn = @(
        	'[WindowsFeature]IISRequestFiltering'
	        '[WindowsFeature]IISScriptingTools'
	    )
	}

	WebAppPool LabApplicationPool {
    		Name         = $Node.AppPoolName
    		Ensure       = 'Present'
    		State        = 'Started'
    		identityType = 'ApplicationPoolIdentity'

    		DependsOn = '[WindowsFeature]IISScriptingTools'
	}

	WebConfigProperty AnonymousUsesAppPoolIdentity {
    		WebsitePath  = $Node.IisConfigPath
    		Filter       = 'system.webServer/security/authentication/anonymousAuthentication'
    		PropertyName = 'userName'
    		Value        = ''
    		Ensure       = 'Present'

    		DependsOn = '[WebAppPool]LabApplicationPool'
	}

	foreach ($protocolo in $Node.SchannelServerProtocols) {
    $claveProtocolo = (
        'HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\' +
        'SecurityProviders\SCHANNEL\Protocols\' +
        $protocolo.Name +
        '\Server'
    )

    Registry "Schannel$($protocolo.Id)ServerEnabled" {
        Key       = $claveProtocolo
        ValueName = 'Enabled'
        ValueType = 'Dword'
        ValueData = @([string]$protocolo.Enabled)
        Ensure    = 'Present'
    }

    Registry "Schannel$($protocolo.Id)ServerDisabledByDefault" {
        Key       = $claveProtocolo
        ValueName = 'DisabledByDefault'
        ValueType = 'Dword'
        ValueData = @([string]$protocolo.DisabledByDefault)
        Ensure    = 'Present'
    }
}

	

    }
}