
<#
.SYNOPSIS
Crop my anime screenshots to remove black background.

.DESCRIPTION
Crop my anime screenshots to remove black background.

.PARAMETER inputDir
Specifies the input directory containing the images to be converted. If not specified, the script uses the current directory.

.NOTES
Author: seesoul5300
Date: 2024/06/11
Version: 1.0
#>

param (
    [string]$inputDir = (Get-Location).Path
)

# Create the output directory for conversions
$outDir = Join-Path -Path $inputDir -ChildPath "convert"
if (-not (Test-Path $outDir)) {
    New-Item -ItemType Directory -Path $outDir | Out-Null
}

# Get all image files in the current directory
$imageFiles = Get-ChildItem -Path $inputDir -Filter "*.jpg" -File
$imageFiles += Get-ChildItem -Path $inputDir -Filter "*.png" -File

foreach ($file in $imageFiles) {
    $outputFileName = Join-Path -Path $outDir -ChildPath ($file.BaseName + $file.Extension)
    
    # unused: & magick "$($file.FullName)" -crop 1920x1080+240+0 -define webp:method=6 -define webp:quality=90 "$webpFileName"
    & magick "$($file.FullName)" -crop 1920x1080+240+0 "$outputFileName"
}

Write-Host "All files processed."
