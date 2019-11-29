FROM mcr.microsoft.com/dotnet/core/aspnet:3.0-buster-slim AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

FROM mcr.microsoft.com/dotnet/core/sdk:3.0-buster AS build
WORKDIR /src
COPY kafka.ui/kafka.ui.csproj kafka.ui/
RUN dotnet restore "kafka.ui/kafka.ui.csproj"
COPY . .
WORKDIR "/src/kafka.ui"
RUN dotnet build "kafka.ui.csproj" -c Release -o /app/build

FROM build AS publish
RUN dotnet publish "kafka.ui.csproj" -c Release -o /app/publish

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "kafka.ui.dll"]
