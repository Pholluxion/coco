(function () {
    'use strict';

    angular
            .module('app')
            .controller('RegisterController', RegisterController);

    RegisterController.$inject = ['UserService', '$location', '$rootScope', 'FlashService'];
    function RegisterController(UserService, $location, $rootScope, FlashService) {

        var vm = this;

        vm.register = register;
        vm.allDocsType = null;

        loadAllDocs();

        function register() {
            vm.dataLoading = true;
            UserService.Create(vm.user)
                    .then(function (response) {
                        if (response.ok) {
                            FlashService.Success('Registro exitoso', true);
                            $location.path('/login');
                        } else {
                            FlashService.Error(response.message);
                            vm.dataLoading = false;
                        }
                    });
        }

        function loadAllDocs() {
            UserService.GetUserDocType()
                    .then(function (users) {
                        console.log(users);
                        vm.allDocsType = users.listDocType;
                    });
        }
    }

})();
