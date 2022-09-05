Feature: Mock Create Order with Wiremock

  Background:
    * url wiremockHost + '/__admin/mappings'

  @GetAllMapping
  Scenario: Get all mapping
    When method get
    Then status 200

  @DeleteAllMapping
  Scenario: Delete all stub mapping
    When method delete
    Then status 200

  @MockTKPD_001
  Scenario: Mock API for TKPD 001
    * def bodyData = read('classpath:api/order/wiremock_mapping/TKPD_001-mapping.json')
    Given request bodyData
    When method post
    Then status 201

  @MockTKPD_002
  Scenario: Mock API for TKPD 002
    * def bodyData = read('classpath:api/order/wiremock_mapping/TKPD_002A-mapping.json')
    Given request bodyData
    When method post
    Then status 201

    * def bodyData = read('classpath:api/order/wiremock_mapping/TKPD_002B-mapping.json')
    Given request bodyData
    When method post
    Then status 201

    * def bodyData = read('classpath:api/order/wiremock_mapping/TKPD_002C-mapping.json')
    Given request bodyData
    When method post
    Then status 201

  @MockTKPD_003
  Scenario: Mock API for TKPD 003
    * def bodyData = read('classpath:api/order/wiremock_mapping/TKPD_003A-mapping.json')
    Given request bodyData
    When method post
    Then status 201

    * def bodyData = read('classpath:api/order/wiremock_mapping/TKPD_003B-mapping.json')
    Given request bodyData
    When method post
    Then status 201

    * def bodyData = read('classpath:api/order/wiremock_mapping/TKPD_003C-mapping.json')
    Given request bodyData
    When method post
    Then status 201

