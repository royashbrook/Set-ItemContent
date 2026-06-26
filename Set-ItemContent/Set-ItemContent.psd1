@{
    RootModule = 'Set-ItemContent.psm1'
    ModuleVersion = '1.0.2'
    GUID = '93cdda16-05e8-42c3-9fb3-1ae9f8d36fcb'
    Author = 'Roy Ashbrook'
    CompanyName = 'royashbrook.com'
    Copyright = '(c) 2021-2026 Roy Ashbrook. All rights reserved.'
    Description = 'Common module for updating item content via Microsoft Graph'
    FunctionsToExport = 'Set-ItemContent'
    AliasesToExport = @()
    CmdletsToExport = @()
    VariablesToExport = @()
    RequiredModules = @('Add-PrefixForLogging')
    PrivateData = @{
        PSData = @{
            Tags = @('msgraph','sharepoint','upload','managedidentity')
            LicenseUri = 'https://github.com/royashbrook/Set-ItemContent/blob/main/LICENSE'
            ProjectUri = 'https://github.com/royashbrook/Set-ItemContent'
            ReleaseNotes = 'Add a managed-identity auth path (no client_secret -> App Service MSI); declare Add-PrefixForLogging RequiredModule; CompanyName -> royashbrook.com; stop logging the token response; add MIT license + project metadata.'
        }
    }
}
