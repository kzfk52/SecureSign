#!/bin/bash

#sudo apt install -y osslsigncode

touch ./accessTokenConfig.json


rm -rf published
dotnet publish -c Release -o ./published src/SecureSign.Web/
dotnet publish -c Release -o ./published src/SecureSign.Tools/
cp appsettings.json published/

## accessTokenConfig.json file, secrets folder, keys folder
cd published/
ln -s ../keys keys
ln -s ../secrets secrets
ln -s ../accessTokenConfig.json accessTokenConfig.json

# dotnet SecureSign.Web.dll