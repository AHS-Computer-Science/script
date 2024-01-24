$path = "C:/Users/$Env:UserName/AppData/Local/Programs/devenv"
$version = "v20.11.0"
$download = "https://nodejs.org/dist/$version/node-$version-win-x64.zip"

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 

if(![System.IO.File]::Exists($path + "/node-$version-win-x64.zip")) {
	if([System.IO.File]::Exists($path + "/node.exe")) {
		Remove-Item $path
	}
    mkdir $path -ea 0
    Set-Location $path
    Invoke-WebRequest $download -OutFile "node-$version-win-x64.zip"
    Expand-Archive "$path/node-$version-win-x64.zip" -DestinationPath $path
    Move-Item -Path ./node-$version-win-x64/* -Destination ./
}


if(!($env:Path -like "*$path*")) {
    [Environment]::SetEnvironmentVariable("Path", [Environment]::GetEnvironmentVariable("Path", "User") + ";$path","User")
}

$env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User") 
