FROM mcr.microsoft.com/dotnet/runtime:6.0

RUN curl -fsSLO https://get.docker.com/builds/Linux/x86_64/docker-17.04.0-ce.tgz \
  && tar xzvf docker-17.04.0-ce.tgz \
  && mv docker/docker /usr/local/bin \
  && rm -r docker docker-17.04.0-ce.tgz

COPY bin/Release/net6.0/publish .

ENTRYPOINT [ "dotnet", "CAPSrage.dll"]