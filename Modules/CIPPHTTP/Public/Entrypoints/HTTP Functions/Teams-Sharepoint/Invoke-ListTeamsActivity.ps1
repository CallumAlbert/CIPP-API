Function Invoke-ListTeamsActivity {
    <#
    .FUNCTIONALITY
        Entrypoint
    .ROLE
        Teams.Activity.Read
    #>
    [CmdletBinding()]
    param($Request, $TriggerMetadata)
    # Interact with query parameters or the body of the request.
    $TenantFilter = $Request.Query.tenantFilter
    $type = $request.Query.Type
    $GraphRequest = New-GraphGetRequest -uri "https://graph.microsoft.com/beta/reports/get$($type)Detail(period='D7')" -tenantid $TenantFilter | ConvertFrom-Csv | Select-Object @{ Name = 'UPN'; Expression = { $_.'User Principal Name' } },
    @{ Name = 'LastActive'; Expression = { $_.'Last Activity Date' } },
    @{ Name = 'TeamsChat'; Expression = { $_.'Team Chat Message Count' } },
    @{ Name = 'CallCount'; Expression = { $_.'Call Count' } },
    @{ Name = 'MeetingCount'; Expression = { $_.'Meeting Count' } },
    @{ Name = 'AudioCallDuration'; Expression = { $_.'Audio Duration' } },
    @{ Name = 'VideoCallDuration'; Expression = { $_.'Video Duration' } },
    @{ Name = 'ScreenShareDuration'; Expression = { $_.'Screen Share Duration' } },
    @{ Name = 'PrivateChat'; Expression = { $_.'Private Chat Message Count' } }



    return ([HttpResponseContext]@{
            StatusCode = [HttpStatusCode]::OK
            Body       = @($GraphRequest)
        })

}
