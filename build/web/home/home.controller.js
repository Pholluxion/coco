﻿(function () {
    'use strict';

    angular
            .module('app')
            .controller('HomeController', HomeController);

    HomeController.$inject = ['UserService', '$rootScope'];
    function HomeController(UserService, $rootScope) {
        var vm = this;

        vm.user = null;
        vm.deleteUser = deleteUser;

        initController();

        function initController() {
            loadCurrentUser();
            loadAllUsers();
        }

        function loadCurrentUser() {
           vm.user =$rootScope.globals.currentUser;
        }

        function loadAllUsers() {
            UserService.GetAll()
                    .then(function (users) {
                        vm.allUsers = users.listUsers;

                    });
        }

        function deleteUser(id) {
            UserService.Delete(id)
                    .then(function () {
                        loadAllUsers();
                    });
        }
    }

})();