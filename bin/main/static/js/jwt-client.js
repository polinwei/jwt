/**
 * Created by Polin on 2018-08-16
 */

/**
 * 建立 jwtClient 的全域函數
 */
var jwtClient = function(){
	// VARIABLES =============================================================
    var TOKEN_KEY = "jwtToken";
 	// FUNCTIONS =============================================================
    var getJwtToken = function() {
        return sessionStorage.getItem(TOKEN_KEY);
    }

    var setJwtToken = function(token) {
        sessionStorage.setItem(TOKEN_KEY, token);
    }

    var removeJwtToken = function() {
        sessionStorage.removeItem(TOKEN_KEY);
    }
    var setAuthorizationTokenHeader = function () {
        var token = getJwtToken();
        if (token) {
            return {"Authorization": "Bearer " + token};
        } else {
            return {};
        }
    }
    // INITIAL
    return {
    	getJwtToken: function () {
            return getJwtToken();
        },
        setJwtToken: function (token) {
            return setJwtToken(token);
        },
        removeJwtToken: function() {
        	return removeJwtToken();
        },
        setAuthorizationTokenHeader: function () {
        	return setAuthorizationTokenHeader();
        }
    }
	
}();
	
$(function () {	
    // VARIABLES =============================================================
    var TOKEN_KEY = "jwtToken"
    var $notLoggedIn = $("#notLoggedIn");
    var $loggedIn = $("#loggedIn").hide();
    var $loggedInBody = $("#loggedInBody");
    var $response = $("#response");
    var $login = $("#login");
    var $userInfo = $("#userInfo").hide();

    // FUNCTIONS =============================================================
    function getJwtToken() {
        return sessionStorage.getItem(TOKEN_KEY);
    }

    function setJwtToken(token) {
        sessionStorage.setItem(TOKEN_KEY, token);
    }

    function removeJwtToken() {
        sessionStorage.removeItem(TOKEN_KEY);
    }

    function doJWTLogin(loginData) {
        $.ajax({
            url: "/auth",
            type: "POST",
            data: JSON.stringify(loginData),
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data, textStatus, jqXHR) {                
                setJwtToken(data.token);                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                if (jqXHR.status === 401 || jqXHR.status === 403) {
                    $('#loginErrorModal')
                        .modal("show")
                        .find(".modal-body")
                        .empty()
                        .html("<p>Message from server:<br>" + jqXHR.responseText + "</p>");
                } else {
                    throw new Error("an unexpected error occured: " + errorThrown);
                }
            }
        });
    }

    function doGetAuthToken() {
        $.ajax({
            url: "/get-auth-token",
            type: "POST",            
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            success: function (data, textStatus, jqXHR) {                
                setJwtToken(data.token);                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                if (jqXHR.status === 401 || jqXHR.status === 403) {
                    $('#loginErrorModal')
                        .modal("show")
                        .find(".modal-body")
                        .empty()
                        .html("<p>Message from server:<br>" + jqXHR.responseText + "</p>");
                } else if (jqXHR.status !== 200) {
                    throw new Error("an unexpected error occured: " + errorThrown);
                }
            }
        });
    }
    
    function doRefreshToken() {
        $.ajax({
            url: "/refresh-token",
            type: "GET",            
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            headers: createAuthorizationTokenHeader(),
            success: function (data, textStatus, jqXHR) {                
                setJwtToken(data.token);                
            },
            error: function (jqXHR, textStatus, errorThrown) {
                if (jqXHR.status === 401 || jqXHR.status === 403) {
                    $('#loginErrorModal')
                        .modal("show")
                        .find(".modal-body")
                        .empty()
                        .html("<p>Message from server:<br>" + jqXHR.responseText + "</p>");
                } else if (jqXHR.status === 500){                	
                	var responseText = jQuery.parseJSON(jqXHR.responseText);
                	$.confirm({
                        icon: 'fa fa-warning',
                        title: 'JWT Token expired',
                        content: responseText.message ,
                        buttons: {
                            info: {
                                btnClass: 'btn-blue',
                                text: "Token will be renew",
                                action: function () {
                                	removeJwtToken();
                                	doGetAuthToken();
                                }
                            }
                        }
                    });                    
                } else if (jqXHR.status === 400){
                	console.log("No need to refresh Token");
                } else {
                    //throw new Error("an unexpected error occured: " + errorThrown);
                }
            }
        });
    }    

    function doLogout() {
        removeJwtToken();
        window.location.href = "/logout";
    }

    function createAuthorizationTokenHeader() {
        var token = getJwtToken();
        if (token) {
            return {"Authorization": "Bearer " + token};
        } else {
            return {};
        }
    }

    function showUserInformation() {
        $.ajax({
            url: "/user",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            dataType: "json",
            headers: createAuthorizationTokenHeader(),
            success: function (data, textStatus, jqXHR) {
                var $userInfoBody = $userInfo.find("#userInfoBody");

                $userInfoBody.append($("<div>").text("Username: " + data.username));
                $userInfoBody.append($("<div>").text("Email: " + data.email));

                var $authorityList = $("<ul>");
                data.authorities.forEach(function (authorityItem) {
                    $authorityList.append($("<li>").text(authorityItem.authority));
                });
                var $authorities = $("<div>").text("Authorities:");
                $authorities.append($authorityList);

                $userInfoBody.append($authorities);
                $userInfo.show();
            }
        });
    }

    function showTokenInformation() {
        var jwtToken = getJwtToken();
        var decodedToken = jwt_decode(jwtToken);
        var $table = $("<table>")
            .addClass("table table-striped");
        appendKeyValue($table, "User:", decodedToken.sub);
        appendKeyValue($table, "Issued At:", moment.unix(decodedToken.iat));
        appendKeyValue($table, "Expiration:", moment.unix(decodedToken.exp));
        appendKeyValue($table, "Scopes:", decodedToken.scopes);
	
	    if (decodedToken) {    
	        $.alert({
	            title: 'JWT Token',
	            content: $table,
	        });
        }
    }

    function appendKeyValue($table, key, value) {
        var $row = $("<tr>")
            .append($("<td>").text(key))
            .append($("<td>").text(value));
        $table.append($row);
    }

    function showResponse(statusCode, message) {
        $response
            .empty()
            .text("status code: " + statusCode + "\n-------------------------\n" + message);
    }

    // REGISTER EVENT LISTENERS =============================================================
    
    $("#jwtLoginForm").submit(function (event) {
        event.preventDefault();

        var $form = $(this);
        var formData = {
            username: $form.find('input[name="username"]').val(),
            password: $form.find('input[name="password"]').val()
        };        
        doJWTLogin(formData);        
    });

    $("#logoutButton").click(doLogout);

    $("#adminServiceBtn").click(function () {
        $.ajax({
            url: "/protected",
            type: "GET",
            contentType: "application/json; charset=utf-8",
            headers: createAuthorizationTokenHeader(),
            success: function (data, textStatus, jqXHR) {
                showResponse(jqXHR.status, data);
            },
            error: function (jqXHR, textStatus, errorThrown) {
                showResponse(jqXHR.status, errorThrown);
            }
        });
    });
    
    $("#tokenInfo").click(showTokenInformation);


    // INITIAL CALLS =============================================================
    if (!getJwtToken()) {        
    	doGetAuthToken();
    } else {
    	var jwtDecoded = jwt_decode(getJwtToken());
    	var jwtExp = moment(jwtDecoded.exp * 1000).format();
    	var now = moment().format();     	
    	if (moment().isAfter(moment(jwtDecoded.exp * 1000))) {
    		doRefreshToken();
    	}    	
    }
    
});
