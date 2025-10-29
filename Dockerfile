FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build-env
WORKDIR /app

# Copy csproj and restore it
COPY InvoiceOcrApi/InvoiceOcrApi.csproj ./InvoiceOcrApi/
RUN dotnet restore InvoiceOcrApi/InvoiceOcrApi.csproj

# Copy everything else
COPY InvoiceOcrApi/. ./InvoiceOcrApi

# Build and publish
RUN dotnet publish InvoiceOcrApi/InvoiceOcrApi.csproj -c Release -o out

FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /app
COPY --from=build-env /app/out .

ENTRYPOINT ["dotnet", "InvoiceOcrApi.dll"]
