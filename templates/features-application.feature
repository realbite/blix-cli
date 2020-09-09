Feature: Basic Application Access

  Scenario: access public url
    When user guest gets '/version'
    Then the status should be 200
    And the data "version" should == ::Application::VERSION
