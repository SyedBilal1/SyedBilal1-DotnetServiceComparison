# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
WORKDIR /app
EXPOSE 80
EXPOSE 443

# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy the API.csproj file (since both Dockerfile and API.csproj are in the API folder)
COPY ./API.csproj ./ 

# Restore the dependencies
RUN dotnet restore "./API.csproj"

# Copy the rest of the application files
COPY . .

# Set the working directory and build the app
WORKDIR "/src"
RUN dotnet build "API.csproj" -c Release -o /app/build

# Publish the app
FROM build AS publish
RUN dotnet publish "API.csproj" -c Release -o /app/publish

# Copy the build output from the 'publish' stage to the 'base' image and set the entry point
FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "API.dll"]
