#!/bin/bash

check_install() {
        if ! command -v $1 &> /dev/null; then
                echo "$1 is not installed. Installing..."
                eval $2
        else 
             echo "$1 is already installed."
        fi
}

check_install "assetfinder" "go get -u github.com/tomnomnom/assetfinder"
check_install "waybackurls" "go install github.com/tomnomnom/waybackurls@latest"
check_install "gau" "go install github.com/lc/gau/v2/cmd/gau@latest"
check_install "httpx" "go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest"
check_install "ffuf" "go install github.com/ffuf/ffuf/v2@latest"
check_install "gf" "go get -u github.com/tomnomnom/gf"
check_install "qsreplace" "go install github.com/tomnomnom/qsreplace@latest"
