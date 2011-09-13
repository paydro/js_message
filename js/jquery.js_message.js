(function($){
    // Checks that a console arg is available before logging to it
    $.log = function(msg){
        if(window.console && window.DEBUG){
            console.log(msg);
        }
    };

    /* set up a converter and accepts dataType to allow rails to
       "respond_to" jsm based on the accepts header  */
    $.ajaxSetup({
        accepts: {
          jsm: "text/jsm, application/jsm"
        },
        converters: {
          "text jsm": jQuery.parseJSON
        }
    });

    // Appends the ".jsm" to a URL. It will not append the extension
    // if the URL already has it.
    $.appendJSMExt = function(url){
        if(url.indexOf(".jsm") !== -1){
            return url;
        }

        var parts = url.split("?");
        var request = parts[0];
        var params = parts[1];

        var jsmUrl = request + ".jsm";
        if(params){
            jsmUrl += "?" + params;
        }

        return jsmUrl;
    };

    // Send a standard structured JSON message to the server.
    $.jsMessage = function(options){
        var validRespFunc = options.success || function(jsonResponse){
            $.log("Valid response returned");
            $.log(jsonResponse);
        };

        var invalidRespFunc = options.error || function(jsonResponse){
            $.log("Invalid response returned");
            $.log(jsonResponse);
        };

        options.success = function(jsonResponse){
            if(jsonResponse.status == "redirect"){
                window.location = jsonResponse.to;
            }
            else{
                validRespFunc(jsonResponse);
            }
        };

        options.error = function(XMLHttpRequest, textStatus){
            if(XMLHttpRequest.status == 400){
                jsonResponse = $.parseJSON(XMLHttpRequest.responseText);
                invalidRespFunc(jsonResponse);
            }
            else{
                $.log("Request error: " + textStatus);
                $.log(XMLHttpRequest);
            }
        };

        options.dataType = "json";
        options.type = options.type || "POST";
        options.url = $.appendJSMExt(options.url);

        $.ajax(options);
    };

})(jQuery);



