<#

.SYNOPSIS
Run a Docker container with the specified SDK or runtime tag

.DESCRIPTION
A dirty Docker trick to recreate the SDK-switching magic of the `dnvm` utility

.PARAMETER WorkingDirectory
The working directory (defaults to current directory)
.PARAMETER Image
The image to use (no tag). Defaults to `microsoft/dotnet`
.PARAMETER ListTags
Only lists available tags. There is usually a lot of tags.
.PARAMETER Verbosity
Specifies the amount of information to be displayed
.PARAMETER DryRun
Performs a dry run
.PARAMETER ScriptArgs
Remaining arguments are added here
.PARAMETER Tag
The image tag to run. Defaults to `latest`

.LINK
https://github.com/agc93/dnvm

#>

[CmdletBinding()]
Param(
    [string]$WorkingDirectory = $env:PWD,
    [string]$Image = "microsoft/dotnet",
    [switch]$ListTags,
    [ValidateSet("Quiet", "Normal", "Verbose")]
    [string]$Verbosity = "Normal",
    [Alias("WhatIf", "Noop")]
    [switch]$DryRun,
    [Parameter(Position=1,Mandatory=$false)]
    [string]$Tag = "latest",
    [Parameter(Position=1,Mandatory=$false,ValueFromRemainingArguments=$true)]
    [string[]]$ScriptArgs
)

if ($Verbosity -eq "Verbose") {
    $InformationPreference = "Continue"
    $VerbosePreference = "Continue"
}
if ($Verbosity -eq "Normal") {
    $InformationPreference = "Continue"
}

if ($ListTags.IsPresent) {
    Write-Information "Fetching tags for $IMAGE"
    $results = Invoke-WebRequest -Uri https://registry.hub.docker.com/v1/repositories/$IMAGE/tags | ConvertFrom-Json
    foreach ($layer in $results) {
        Write-Host $layer.name
    }
    exit 0;
}

if ($Tag -eq "json") {
    $Tag="1.1.0-sdk-projectjson"
}

Write-Information "Starting $Image container with tag '$Tag' in $WorkingDirectory"

$CMD="docker run -it --rm -v `'${WorkingDirectory}:/app`' -w /app ${Image}:${Tag} $ScriptArgs"

if (-Not $DryRun.IsPresent) {
    Invoke-Expression "& $CMD"
} else {
    Write-Host $CMD
}