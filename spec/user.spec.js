"use strict";
var
  assert = require("chai").assert,
  spec = require("api-first-spec");

var API = spec.define({
  "endpoint": "/api/user",
  "method": "GET",
  "request": {
    "contentType": spec.ContentType.URLENCODED,
    "params": {
      "id": "int"
    }
  },
  "response": {
    "contentType": spec.ContentType.JSON,
    "data": {
      "result": "string"
    }
  }
});

describe("login", function() {
  var host = spec.host("localhost:9393");

  it("Testing", function (done) {
    console.log("hello");
    host.api(API).params({
        "id": 1
    }).success(function (data) {
        console.log("helloIn");
        assert.equal(data.result, "Logged In !");
        done();
    });
  });

});

module.exports = API;