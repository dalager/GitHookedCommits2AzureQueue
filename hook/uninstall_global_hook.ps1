# uninstall post commit hook

$ErrorActionPreference = "Stop"
$installpath = "$HOME\.git-hooks"
$sourcename = "post-commit"


if (!(Test-Path $installpath)) {
    write-output "unregister git config core.hooksPath"
    git config --global --unset core.hooksPath 
    Write-Output "post commit hook uinstalled"
    exit
}

# delete post-commit hook
Remove-Item $installpath/$sourcename -Force

# if directory is empty, delete it
if (!(Get-ChildItem $installpath)) {
    Write-Output "deleting empty hook folder at $installpath"
    Remove-Item $installpath -Force
    git config --global --unset core.hooksPath 
    Write-Output "post commit hook uinstalled at $installpath"
    exit
}
else {
    Write-Output "post commit hook uinstalled at $installpath (but still remaining hooks in folder)"
}






