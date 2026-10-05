if (-not $global:PromptExecuted) {
    $global:PromptExecuted = $false
}
function prompt {
    $username = "omar"
    $hostname = $env:COMPUTERNAME.ToLower()
    $path = $(Get-Location).Path
    $time = Get-Date -Format "HH:mm"
    $isAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    $pathParts = $path -split '\\'
    $shortPath = $pathParts[-1]
    
    $homePath = $env:USERPROFILE
    if ($path -eq $homePath) {
        $shortPath = "~"
    } elseif ($path.StartsWith($homePath)) {
        $relativePath = $path.Substring($homePath.Length) -replace '\\', '/'
        $shortPath = "~$relativePath"
    } else {
        $shortPath = $path -replace '\\', '/'
    }

    if ($global:PromptExecuted) {
        Write-Host ""
    }
    $global:PromptExecuted = $true
    
    # Write-Host "$username" -NoNewline -ForegroundColor Green
    # Write-Host "@" -NoNewline -ForegroundColor White
    # Write-Host "[$time]" -NoNewline -ForegroundColor DarkGray
    Write-Host "$hostname" -NoNewline -ForegroundColor Green
    Write-Host ":" -NoNewline -ForegroundColor White
    Write-Host "$shortPath" -NoNewline -ForegroundColor Blue
    if ($isAdmin) {
        Write-Host "#" -NoNewline -ForegroundColor Red
    } else {
        Write-Host "$" -NoNewline -ForegroundColor White
    }
    return " "
}

#old format
# function prompt { 
#     $path = $(Get-Location).Path
#     Write-Host "" 
#     Write-Host $path -ForegroundColor Green 
#     Write-Host "> " -NoNewline -ForegroundColor Green 
# }