___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "displayName": "VWO Data Points",
  "categories": ["EXPERIMENTATION", "PERSONALIZATION", "ANALYTICS"],
  "description": "Identify when a given page owns an active VWO test and make use of specific data points, such as the test's name and the active variant.",
  "securityGroups": [],
  "id": "cvt_temp_public_id",
  "type": "MACRO",
  "version": 1,
  "containerContexts": [
    "WEB"
  ],
  "brand": {
    "displayName": "Custom Template"
  }
}


___TEMPLATE_PARAMETERS___

[
  {
    "help": "Google Tag Manager configuration must enabled within the VWO test configuration.",
    "macrosInSelect": false,
    "alwaysInSummary": true,
    "selectItems": [
      {
        "displayValue": "Test State",
        "value": "testActive"
      },
      {
        "displayValue": "Test Name",
        "value": "testName"
      },
      {
        "displayValue": "Test ID",
        "value": "testId"
      },
      {
        "displayValue": "Variant Name",
        "value": "variantName"
      }
    ],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "displayName": "Data Point",
    "defaultValue": "Active state",
    "simpleValueType": true,
    "name": "returnItem",
    "type": "SELECT"
  },
  {
    "type": "GROUP",
    "name": "descriptions",
    "displayName": "",
    "groupStyle": "NO_ZIPPY",
    "subParams": [
      {
        "enablingConditions": [
          {
            "paramName": "returnItem",
            "type": "EQUALS",
            "paramValue": "testActive"
          }
        ],
        "displayName": "If an active test is found on a given page this value will be true, else false",
        "name": "lbl_testActive",
        "type": "LABEL"
      },
      {
        "enablingConditions": [
          {
            "paramName": "returnItem",
            "type": "EQUALS",
            "paramValue": "testName"
          }
        ],
        "displayName": "This will return the name of the active test on a given page",
        "name": "lbl_testName",
        "type": "LABEL"
      },
      {
        "enablingConditions": [
          {
            "paramName": "returnItem",
            "type": "EQUALS",
            "paramValue": "testId"
          }
        ],
        "displayName": "This will return the ID of the active test on a given page",
        "name": "lbl_testId",
        "type": "LABEL"
      },
      {
        "enablingConditions": [
          {
            "paramName": "returnItem",
            "type": "EQUALS",
            "paramValue": "variantName"
          }
        ],
        "displayName": "This will return the name of the variant for the current test on page, including control",
        "name": "variantName",
        "type": "LABEL"
      }
    ]
  }
]


___WEB_PERMISSIONS___

[
  {
    "instance": {
      "key": {
        "publicId": "access_globals",
        "versionId": "1"
      },
      "param": [
        {
          "key": "keys",
          "value": {
            "type": 2,
            "listItem": [
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "dataLayer"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "_vwo_exp"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              },
              {
                "type": 3,
                "mapKey": [
                  {
                    "type": 1,
                    "string": "key"
                  },
                  {
                    "type": 1,
                    "string": "read"
                  },
                  {
                    "type": 1,
                    "string": "write"
                  },
                  {
                    "type": 1,
                    "string": "execute"
                  }
                ],
                "mapValue": [
                  {
                    "type": 1,
                    "string": "RexExp"
                  },
                  {
                    "type": 8,
                    "boolean": true
                  },
                  {
                    "type": 8,
                    "boolean": false
                  },
                  {
                    "type": 8,
                    "boolean": false
                  }
                ]
              }
            ]
          }
        }
      ]
    },
    "clientAnnotations": {
      "isEditedByUser": true
    },
    "isRequired": true
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

const query = require('queryPermission');
const copyWindow = require('copyFromWindow');
const callInWindow = require('callInWindow');

var datalayerClone = copyWindow('dataLayer');
var regExp = copyWindow('RexExp');


if (datalayerClone) {
  var vwoEvent = null;

  for(var i=datalayerClone.length-1; i>-1; i--){
    if(typeof datalayerClone[i].event != 'undefined' && datalayerClone[i].event.toLowerCase() == 'vwo'){
      vwoEvent = true;
      i = i-1;

      if(data.returnItem == 'testActive'){
        return true;
      }
    }

    if(vwoEvent !== null){

      for(var key in datalayerClone[i]){
        var testId = key.split('-');


        if(typeof testId !== 'undefined' && testId.length == 2){
          testId = testId[1];

          var vwoData = copyWindow('_vwo_exp');


          if(data.returnItem == 'testName'){
            if(typeof vwoData !== 'undefined' && vwoData[testId]){
            	return vwoData[testId].name;
            }
          }

          if(data.returnItem == 'testId'){
            return testId;
          }

          if(data.returnItem == 'variantName'){
            return datalayerClone[i][key];
          }

        }
      }
    }
  }

}else{
  if(data.returnItem == 'testActive'){
  	return false;
  }else{
    return undefined;
  }
}


___NOTES___

Created on 24/07/2019, 14:23:41
