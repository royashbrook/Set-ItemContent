function Set-ItemContent {
    [cmdletbinding(SupportsShouldProcess = $True)]
    Param($cfg, $file)
    # use data if we have some
    if (Test-Path $file) {

        l "getting config"
        $graphcfg = $cfg.msgraph
        $zipfile = $file + ".zip"

        l "compressing file"
        Compress-Archive -Path $file -Force -DestinationPath $zipfile
        if (-not (Test-Path $zipfile)) {
            l "unable to locate zip file, terminating process"
            return
        }

        if (!$PSCmdlet.ShouldProcess($file, "Upload File")) {
            return
        }

        l "reading in file to upload"
        if ($PSVersionTable.PSVersion.Major -ge 6) {
            $body = Get-Content $zipfile -AsByteStream -Raw
        }
        else {
            $body = Get-Content $zipfile -Encoding Byte -Raw
        }
        
        if (-not $body) {
            l "unable to read in file, terminating process"
            return
        }

        l "getting access token from ms graph"
        #convert tokenbody from config into hashtable for body
        $tokenbody = $graphcfg.tokenBody.psobject.properties | ForEach-Object -begin { $h = @{} } -process { $h."$($_.Name)" = $_.Value } -end { $h }
        $tokenresponse = Invoke-RestMethod -Uri $graphcfg.tokenURL -Method POST -Body $tokenbody
        $token = $tokenresponse.access_token

        if (-not $token) {
            l "unable to acquire token, terminating process"
            return
        }
        l "tokenresponse:"
        $tokenresponse | convertto-json
        
        l "uploading file"
        $uploadresponse = Invoke-RestMethod -Headers @{Authorization = "Bearer $($token)" } -Uri $graphcfg.uploadURL -Method Put -Body $body -ContentType "application/zip"

        if (-not $uploadresponse) {
            l "unable to upload file, terminating process"
            return
        }

        l "uploadresponse:"
        $uploadresponse | convertto-json

    }
    else {

        "Nothing to send"

    }
}
Export-ModuleMember -Function Set-ItemContent