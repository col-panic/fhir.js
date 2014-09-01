jasmine.DEFAULT_TIMEOUT_INTERVAL = 10000

angular.module('test', ['ng-fhir'])
  .config ($fhirProvider)->
     $fhirProvider.baseUrl = 'http://try-fhirplace.hospital-systems.com'

describe "ngFhir", ->
  $injector = angular.injector(['test'])

  it "search", (done) ->
    $injector.invoke ['$fhir', ($fhir)->
       $fhir.search('Patient', {name: 'maud'})
         .then (d)->
           # console.log('Search by patients', d)
           done()
     ]

  bundle = '{"resourceType":"Bundle","entry":[]}'

  it "transaction", (done) ->
    $injector.invoke ['$fhir', ($fhir)->
       $fhir.transaction(bundle)
         .then (d)->
           # console.log('Transaction', d)
           done()
     ]

  it "history", (done) ->
    $injector.invoke ['$fhir', ($fhir)->
       $fhir.history()
         .then (d)->
           # console.log('History', d)
           done()
         .error (err)->
           console.log('History', err)
     ]