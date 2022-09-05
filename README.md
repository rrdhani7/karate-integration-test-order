# Karate Integration Test

Simple karate project for integration test. This project will mock API using wiremock for processOrder() and test the API using Karate. This project will be focus on how do we create API Automation Project. We need wiremock only for represent how Karate test real endpoint.


## Prerequisite 
This project need at least Java 8 and Maven for running Karate; and Docker for running Wiremock to mock up endpoint. We will use https://direnv.net/ as well for set environment variable.

## Prerequisite Step
After install all required things, git clone project, `cd` to project directory and run docker compose.
```bash
cd karate-integration-test-order
docker compose up
```


##  How To Run?

### Run all tests
```bash
mvn clean test -Dtest=KarateRunner
```

### Run specific test with test-id
```bash
mvn clean test -Dtest=KarateRunner -Dkarate.options="@test-id=TKPD_001"
```
