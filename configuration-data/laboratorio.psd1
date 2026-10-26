@{
    AllNodes = @(
        @{
            NodeName      = 'localhost'
            IisConfigPath = 'MACHINE/WEBROOT/APPHOST'
	    AppPoolName = 'DefaultAppPool'

            SchannelServerProtocols = @(
                @{
                    Id                = 'SSL30'
                    Name              = 'SSL 3.0'
                    Enabled           = 0
                    DisabledByDefault = 1
                }
                @{
                    Id                = 'TLS10'
                    Name              = 'TLS 1.0'
                    Enabled           = 0
                    DisabledByDefault = 1
                }
                @{
                    Id                = 'TLS11'
                    Name              = 'TLS 1.1'
                    Enabled           = 0
                    DisabledByDefault = 1
                }
                @{
                    Id                = 'TLS12'
                    Name              = 'TLS 1.2'
                    Enabled           = 1
                    DisabledByDefault = 0
                }
            )
        }
    )
}