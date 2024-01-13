# install post commit hook

$ErrorActionPreference = "Stop"
$installpath = "$HOME\.git-hooks"
$sourcepath = ".\post-commit"
$sourcename = "post-commit"
if (!(Test-Path $installpath)) {
    New-Item -ItemType Directory -Force -Path $installpath | Out-Null
}
if (!(Test-Path $installpath)) {
    throw "Could not create directory $installpath"
    exit
}

Copy-Item $sourcepath $installpath -Force

if (Test-Path $installpath/$sourcename) {
    Write-Host "Successfully installed post-commit hook as $installpath\$sourcename"
}
else {
    throw "Could not install post-commit hook"
    exit
}

git config --global core.hooksPath $installpath
