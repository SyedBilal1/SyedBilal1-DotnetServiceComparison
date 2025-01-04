# Use the official .NET SDK image to build the app
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app
EXPOSE 80

# Copy the solution and project files
COPY API.sln ./
COPY API.csproj ./

# Restore dependencies
RUN dotnet restore API.sln

# Copy the rest of the application files
COPY . ./ 
# This will copy all contents from the current directory into the container

# Set the working directory and build the app
WORKDIR /app
RUN dotnet publish -c Release -o /app/out

# Use the official .NET runtime image to run the app
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
ENTRYPOINT ["dotnet", "API.dll"]
