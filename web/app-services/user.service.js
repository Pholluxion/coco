(function () {
    'use strict';

    angular
            .module('app')
            .factory('UserService', UserService);

    UserService.$inject = ['$http'];
    function UserService($http) {
        var service = {};

        service.GetAll = GetAll;
        service.GetById = GetById;
        service.GetByUsername = GetByUsername;
        service.Create = Create;
        service.Update = Update;
        service.Delete = Delete;
        service.GetUserDocType = GetUserDocType;

        return service;

        function GetAll() {
            var parametros = {process: 'list'};
            return $http({
                method: 'POST',
                url: 'apis/users.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));

        }

        function GetById(email, password) {
            var parametros = {process: 'auth', email: email, pass: password};

            return $http({
                method: 'POST',
                url: 'apis/users.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));
        }

        function GetByUsername(email, password) {
            var parametros = {process: 'auth', email: email, pass: password};

            return $http({
                method: 'POST',
                url: 'apis/users.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));
        }

        function GetUserDocType() {
            var parametros = {process: 'list'};

            return $http({
                method: 'POST',
                url: 'apis/documents.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));
        }

        function Create(user) {

            var parametros = {
                process: 'save',
                name: user.name,
                email: user.email,
                pass: user.password,
                doc: user.document,
                tel: user.phone_number,
                dtype: user.doc_type,
                rol: user.rol
            };

            return $http({
                method: 'POST',
                url: 'apis/users.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));

        }

        function Update(user) {
            if (user.doc_type === "Tipo de documento" || user.doc_type === null) {
                alert("Seleccione un tipo de docuemento");
                return;
            }

            if (user.rol === "Rol de usuario" || user.rol === null) {
                alert("Seleccione un tipo de usuario");
                return;
            }

            var parametros = {
                process: 'update',
                id: user.id,
                name: user.name,
                email: user.email,
                pass: user.password,
                doc: user.document,
                tel: user.phone_number,
                dtype: user.doc_type,
                rol: user.rol
            };

            $http({
                method: 'POST',
                url: 'apis/users.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));
        }

        function Delete(id) {
            var parametros = {process: 'del', id: id};

            return $http({
                method: 'POST',
                url: 'apis/users.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));
        }

        // private functions

        function handleSuccess(res) {
            return res.data;
        }

        function handleError(error) {
            return function () {
                return {success: false, message: error};
            };
        }
    }

})();
