var authmanager = {
    after_login_callback: null,
    after_logout_callback: null,
    
    login: function(service, callback){
        this.after_login_callback = callback;
        window.open('/auth/'+service, 'auth-popup', 'status=0,toolbar=0,width=900,height=700');
    },

    logout: function(callback){
        this.after_logout_callback = callback;
        window.open('/auth/logout', 'auth-popup', 'status=0,toolbar=0,width=200,height=100');
    }
};


var auth_popup = {
    logged_in: false,

    close: function(){
        if(window.opener){
            var callbk;
            if(this.logged_in){
                callbk = window.opener.authmanager.after_login_callback;
            } else {
                callbk = window.opener.authmanager.after_logout_callback;
            }
            if(callbk!=null){ callbk(); }
            window.close();
        }
    }
};

