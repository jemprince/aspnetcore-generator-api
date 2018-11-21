# Build Stage
FROM microsoft/aspnetcore-build:2 AS build-env
WORKDIR /generator

COPY api/api.csproj ./api/
RUN dotnet restore api/api.csproj

COPY tests/tests.csproj ./tests/
RUN dotnet restore tests/tests.csproj

# copy src files (exc .dockerignore)
COPY . .

# run unit tests
RUN dotnet test tests/tests.csproj

#publish
RUN dotnet publish api/api.csproj -o /publish

# Runtime Image Stage
FROM microsoft/aspnetcore:2
WORKDIR /publish
COPY --from=build-env /publish /publish
ENTRYPOINT ["dotnet", "api.dll"]