FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 80

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
ARG DOTNET_CONFIG=Release
WORKDIR /src
COPY ["kafka.ui/kafka.ui.csproj", "kafka.ui/"]
RUN dotnet restore "kafka.ui/kafka.ui.csproj"
COPY . .
WORKDIR "/src/kafka.ui"
RUN dotnet build "kafka.ui.csproj" -c ${DOTNET_CONFIG} -o /app/build

FROM build AS publish
ARG DOTNET_CONFIG=Release
RUN dotnet publish "kafka.ui.csproj" -c ${DOTNET_CONFIG} -o /app/publish

FROM base AS final
ARG INSTALL_CLRDBG=exit
RUN bash -c "${INSTALL_CLRDBG}"
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "kafka.ui.dll"]