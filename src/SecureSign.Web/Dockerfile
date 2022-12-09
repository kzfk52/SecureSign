#See https://aka.ms/containerfastmode to understand how Visual Studio uses this Dockerfile to build your images for faster debugging.

FROM mcr.microsoft.com/dotnet/aspnet:6.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443
RUN mkdir /app/keys
RUN mkdir /app/secrets
VOLUME ["/app/keys","/app/secrets"]
RUN apt-get update \
 && apt-get install -y --no-install-recommends \
    osslsigncode \
    ca-certificates \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/*


FROM mcr.microsoft.com/dotnet/sdk:6.0 AS build
WORKDIR /src
COPY ["SecureSign.Web/SecureSign.Web.csproj", "SecureSign.Web/"]
COPY ["SecureSign.Core/SecureSign.Core.csproj", "SecureSign.Core/"]
RUN dotnet restore "SecureSign.Web/SecureSign.Web.csproj"
COPY . .
WORKDIR "/src/SecureSign.Web"
RUN dotnet build "SecureSign.Web.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "SecureSign.Web.csproj" -c Release -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENV ASPNETCORE_URLS http://*:5000
EXPOSE 5000
ENTRYPOINT ["dotnet", "SecureSign.Web.dll"]