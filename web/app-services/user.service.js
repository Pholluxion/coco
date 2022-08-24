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
        service.UpdateProduct = UpdateProduct;
        service.UpdateUser = UpdateUser;
        service.Delete = Delete;
        service.DeleteProduct = DeleteProduct;
        service.GetUserDocType = GetUserDocType;
        service.GetAllProducts = GetAllProducts;
        service.GetAllUserProducts = GetAllUserProducts;
        service.GetAllCategories = GetAllCategories;
        service.CreateProduct = CreateProduct;
        service.CreateUserProduct = CreateUserProduct;
        service.CreateProductCategory = CreateProductCategory;
        service.GetProductByUserId = GetProductByUserId;
        service.GetProductByCatId = GetProductByCatId;

        return service;

        function GetAll() {
            var parametros = {process: 'list'};
            return $http({
                method: 'POST',
                url: 'apis/users.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));

        }

        function GetAllProducts() {
            var parametros = {process: 'list'};
            return $http({
                method: 'POST',
                url: 'apis/products.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));

        }

        function GetAllCategories() {
            var parametros = {process: 'list'};
            return $http({
                method: 'POST',
                url: 'apis/categories.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));

        }

        function GetAllUserProducts() {
            var parametros = {process: 'list'};
            return $http({
                method: 'POST',
                url: 'apis/products_user.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));

        }

        function GetById(id) {
            var parametros = {process: 'getById', id: id};

            return $http({
                method: 'POST',
                url: 'apis/users.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));
        }

        function GetProductByUserId(id) {
            var parametros = {process: 'getUserProd', id: id};

            return $http({
                method: 'POST',
                url: 'apis/products.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));
        }
        function GetProductByCatId(id) {
            var parametros = {process: 'getCatProd', id: id};

            return $http({
                method: 'POST',
                url: 'apis/products.jsp',
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

        function CreateProduct(name, price, imageUrl, description) {

            var parametros = {
                process: 'save',
                name: name,
                description: description,
                price: price,
                image_url: imageUrl
            };

            return $http({
                method: 'POST',
                url: 'apis/products.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));

        }

        function CreateUserProduct(idUser) {

            var parametros = {
                process: 'save',
                id_user: idUser
            };

            return $http({
                method: 'POST',
                url: 'apis/products_user.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));

        }

        function CreateProductCategory(idCat) {

            var parametros = {
                process: 'save',
                id_category: idCat
            };

            return $http({
                method: 'POST',
                url: 'apis/products_category.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));

        }

        function UpdateProduct(id, name, price, imageUrl, description) {

            var parametros = {
                process: 'update',
                id: id,
                name: name,
                description: description,
                price: price,
                image_url: imageUrl
            };

            return $http({
                method: 'POST',
                url: 'apis/products.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));

        }

        function UpdateUser(user) {

            console.log("Update", user);

            var parametros = {
                process: 'update',
                id: user.id,
                name: user.name,
                email: user.email,
                pass: user.password,
                doc: user.document,
                tel: user.phoneNumber,
                dtype: user.docType,
                rol: user.userRol
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

        function DeleteProduct(id) {
            var parametros = {process: 'del', id: id};

            return $http({
                method: 'POST',
                url: 'apis/products.jsp',
                params: parametros
            }).then(handleSuccess, handleError('Error creating user'));
        }

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
