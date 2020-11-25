echo @"
" > /dev/null ; echo > /dev/null <<"out-null" ###
"@ | out-null 

#vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv
# Powershell Start -----------------------------------------------------
    Write-Host "Switching to powershell..."
    $OS="windows"
    $ARCH="amd64"
    $repo = "kf5i/k3ai-core"
    $myHome=Get-Location
    $releases = "https://api.github.com/repos/$repo/releases"
    $tag = (Invoke-WebRequest $releases | ConvertFrom-Json)[0].tag_name
    $tag=$tag.substring(1)
    
    New-Item -Path $env:userprofile -Force -Name ".k3ai" -ItemType Directory
    Set-Location -Path "$($env:userprofile)/.k3ai"
# Download latest dotnet/codeformatter release from github
# Author Mötz Jensen @Splaxi https://gist.github.com/Splaxi

$filenamePattern = "*k3ai-core_"+$tag+"_"+$OS+"_"+$ARCH+".zip"
$pathExtract = "$($env:userprofile)/.k3ai"
$innerDirectory = $true
$preRelease = $false

if ($preRelease) {
    $releasesUri = "https://api.github.com/repos/$repo/releases"
    $downloadUri = ((Invoke-RestMethod -Method GET -Uri $releasesUri)[0].assets | Where-Object name -like $filenamePattern ).browser_download_url
}
else {
    $releasesUri = "https://api.github.com/repos/$repo/releases/latest"
    $downloadUri = ((Invoke-RestMethod -Method GET -Uri $releasesUri).assets | Where-Object name -like $filenamePattern ).browser_download_url
}

$pathZip = Join-Path -Path $([System.IO.Path]::GetTempPath()) -ChildPath $(Split-Path -Path $downloadUri -Leaf)

Invoke-WebRequest -Uri $downloadUri -Out $pathZip

Remove-Item -Path $pathExtract -Recurse -Force -ErrorAction SilentlyContinue

if ($innerDirectory) {
    $tempExtract = Join-Path -Path $([System.IO.Path]::GetTempPath()) -ChildPath $((New-Guid).Guid)
    Expand-Archive -Path $pathZip -DestinationPath $tempExtract -Force
    Move-Item -Path "$tempExtract\*" -Destination $pathExtract -Force
    #Move-Item -Path "$tempExtract\*\*" -Destination $location -Force
    Remove-Item -Path $tempExtract -Force -Recurse -ErrorAction SilentlyContinue
}
else {
    Expand-Archive -Path $pathZip -DestinationPath $pathExtract -Force
}

Remove-Item $pathZip -Force

Invoke-WebRequest -Uri "https://raw.githubusercontent.com/kf5i/k3ai/master/k3ai.txt" -Out "$($env:userprofile)/.k3ai/k3ai.txt"
$path="$($env:userprofile)/.k3ai/k3ai.txt"
$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath="$oldpath;$($env:userprofile)/.k3ai"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath
Clear-Host
Get-Content -Raw $path
Write-Host "To use K3ai simply start with:`nK3ai-cli -h"

Set-Location -Path $myHome
# Powershell End -------------------------------------------------------
# ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
out-null
#Let's switch to bash
echo @'
' > /dev/null

# Bash Start
TMP_DIR='/tmp/k3ai-tmp'
UNOS=$(uname -s)
echo 'Switching to bash...'

function cleanup {
    rm -rf $TMP_DIR > /dev/null
    rm -r .k3ai > /dev/null
    mkdir .k3ai > /dev/null
    wget --directory-prefix=.k3ai https://raw.githubusercontent.com/kf5i/k3ai/master/k3ai.txt > /dev/null
}

function fail {
	cleanup
	msg=$1
	echo '============'
	echo 'Error: $msg' 1>&2
	exit 1
}

function setup_env {
if [[ "$EUID" = 0 ]]; then
    echo "(1) already root"
else
    sudo -k # make sure to ask for password on next sudo
if sudo true; then
    echo "(2) correct password"
else
    echo "(3) wrong password"
    exit 1
fi
fi  
}
function install {
    echo "Installing K3ai ..."
    if sudo true; then
    mypwd=$(pwd)
        mkdir ${TMP_DIR} && cd ${TMP_DIR} && $GET \
        && tar -xvzf k3ai-core_${tag}_${OS}_${ARCH}.tar.gz && sudo chmod +x ./k3ai-cli \
        && sudo mv ./k3ai-cli /usr/local/bin/ && cd ${mypwd} && sudo rm -rf $TMP_DIR
    else
    mypwd=$(pwd)
        mkdir /tmp/k3ai-tmp && cd /tmp/k3ai-tmp &&  $GET \
         && tar -xvzf k3ai-core_${tag}_${OS}_${ARCH}.tar.gz && chmod +x k3ai-cli && \
         mv k3ai-cli /usr/local/bin && cd ${mypwd} && rmdir /tmp/k3ai-tmp
    fi
    clear
}

function unix_download {
    echo "Ready to download..."
    setup_env
    tag=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | awk -F '"' '/tag_name/{print $4}')
    tag=${tag#"v"}
    URL="https://github.com/kf5i/k3ai-core/releases/download/v$tag/k3ai-core_${tag}_${OS}_${ARCH}.tar.gz"
if which curl > /dev/null; then
    GET="curl"
    if [[ $INSECURE = "true" ]]; then GET="$GET --insecure"; fi
    GET="$GET -LJO $URL"
    echo $GET
    install
elif which wget > /dev/null; then
    GET="wget"
    if [[ $INSECURE = "true" ]]; then GET="$GET --no-check-certificate"; fi
    GET="$GET -qO- $URL"
    echo $GET
    install
else
    fail 'neither wget/curl or tar/gzip are installed, please install them and re-launch the install script'
fi
}



function main {
cleanup
case "${UNOS}" in
Darwin*) OS="darwin";;
Linux*) OS="linux";;
*) echo "unknown os: $(uname -s)";;
esac
#find ARCH
if uname -m | grep 64 > /dev/null; then
    ARCH="amd64"
    echo "starting download... $OS $ARCH"
    unix_download
elif uname -m | grep arm > /dev/null; then
     ARCH="arm" TODO armv6/v7
     echo "ready for ARM"
else
    echo "$(uname -m)"
fi
}

# Bash End
#echo > /dev/null <<out-null

main
# Bash End
echo -n
curl -sfL https://raw.githubusercontent.com/kf5i/k3ai/master/k3ai.txt
echo -e "\n"
echo -e "To use K3ai simply start with:\nK3ai-cli -h"
echo > /dev/null <<out-null
'@ | out-null
out-null

