#!/bin/bash

#sudo apt install -y osslsigncode

rm -rf published
dotnet publish -c Release -o ./published src/SecureSign.Web/
dotnet publish -c Release -o ./published src/SecureSign.Tools/
cp appsettings.json published/