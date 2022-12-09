#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/runtime:6.0 AS base
WORKDIR /app
#RUN mkdir /app/keys
#RUN mkdir /app/secrets
#VOLUME ["/app/keys","/app/secrets"]
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    osslsigncode \
    ca-certificates \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*

FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["SecureSign.Tools/SecureSign.Tools.csproj", "SecureSign.Tools/"]
COPY ["SecureSign.Core/SecureSign.Core.csproj", "SecureSign.Core/"]
RUN dotnet restore "SecureSign.Tools/SecureSign.Tools.csproj"
COPY . .
WORKDIR "/src/SecureSign.Tools"
RUN dotnet build "SecureSign.Tools.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SecureSign.Tools.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "SecureSign.Tools.dll"]