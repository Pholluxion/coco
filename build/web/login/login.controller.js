(function () {
    'use strict';

    angular
        .module('app')
        .controller('LoginController', LoginController);

    LoginController.$inject = ['$location', 'AuthenticationService', 'FlashService'];
    function LoginController($location, AuthenticationService, FlashService) {
        var vm = this;

        vm.login = login;

        (function initController() {
            AuthenticationService.ClearCredentials();
        })();

        function login() {
            vm.dataLoading = true;
            AuthenticationService.Login(vm.email, vm.password, function (response) {
                console.log("Login: ",response);
                if (Object.keys(response.data.user).length !== 0) {
                    AuthenticationService.SetCredentials(response.data.user);
                    $location.path('/');
                } else {
                    FlashService.Error("Correo o contraseña incorrectos");
                    vm.dataLoading = false;
                }
            });
        };
    }

})();
