FROM mcr.microsoft.com/dotnet/runtime:6.0

COPY bin/x64/Release/net6.0/publish .

ENTRYPOINT [ "dotnet", "CAPSrage.dll"]