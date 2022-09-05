Feature: Create Order

  Background:
    * url wiremockHost + '/processOrder'
    * configure afterFeature =
    """
    function() {
      karate.call('classpath:api/order/wiremock_mapping/wiremock.feature@DeleteAllMapping')
    }
    """

  @test-id=TKPD_001
  Scenario: Verify order is processed successfully when order object is complete
    # mock API
    * def mockAPI = call read('classpath:api/order/wiremock_mapping/wiremock.feature@MockTKPD_001')

    # define data
    * def successResponse = read('classpath:api/order/payload/success-response-pattern.json')
    * def bodyData = read('classpath:api/order/payload/TKPD_001.json')
    * def initialTimestamp = bodyData.last_updated_timestamp

    # Do http request
    Given request bodyData
    When method post
    Then status 200
    And match response contains successResponse
    And match response.order_status == "Processed"
    And match response.last_updated_timestamp != initialTimestamp

  @test-id=TKPD_002
  Scenario Outline: Verify order is not processed with invalid order_id in order object
    # mock API
    * def mockAPI = callonce read('classpath:api/order/wiremock_mapping/wiremock.feature@MockTKPD_002')

    # define data
    * def errorResponse = read('classpath:api/order/payload/404-response-pattern.json')
    * def bodyData = read('classpath:api/order/payload/TKPD_002.json')
    * set bodyData.order_id = <orderId>

    # Do http request
    Given request bodyData
    When method post
    Then status 404
    And match response contains any errorResponse
    And match response.error == <errorMessage>
  Examples:
    | orderId | errorMessage                          |
    | null    | "Order id should not be null"         |
    | ""      | "Order id should not be empty string" |
    | 12345   | "Order id should be string"           |

  @test-id=TKPD_003
  Scenario Outline: Verify order is not processed with invalid last_updated_timestamp in order object
    # mock API
    * def mockAPI = callonce read('classpath:api/order/wiremock_mapping/wiremock.feature@MockTKPD_003')

    # define data
    * def errorResponse = read('classpath:api/order/payload/404-response-pattern.json')
    * def bodyData = read('classpath:api/order/payload/TKPD_003.json')
    * set bodyData.last_updated_timestamp = <lastUpdatedTimestamp>

    # Do http request
    Given request bodyData
    When method post
    Then status 404
    And match response contains any errorResponse
    And match response.error == <errorMessage>
    Examples:
      | lastUpdatedTimestamp | errorMessage                           |
      | null                 | "Timestamp should not be null"         |
      | ""                   | "Timestamp should not be empty string" |
      | "abcd"               | "Timestamp should be number"           |

