(function () {
    'use strict';

    angular
            .module('app')
            .controller('HomeController', HomeController);

    HomeController.$inject = ['UserService', '$rootScope', 'FlashService', '$location'];
    function HomeController(UserService, $rootScope, FlashService, $location) {
        var vm = this;

        vm.user = null;
        vm.deleteUser = deleteUser;
        vm.showModal = showModal;
        vm.createNewProduct = createNewProduct;
        vm.gotoPerfil = gotoPerfil;

        
        initController();

        function gotoPerfil() {
            $location.path('/profile');
        }

        function gotoHome() {
            $location.path('/');
        }

        function initController() {
            loadCurrentUser();
            loadAllUsers();
            loadAllProducts();
            loadAllUserProducts();
            loadAllCategories();

        }

        function loadCurrentUser() {
            vm.user = $rootScope.globals.currentUser;
            console.log(vm.user);
        }

        function loadAllUsers() {
            UserService.GetAll()
                    .then(function (users) {
                        vm.allUsers = users.listUsers;

                    });
        }

        function loadAllProducts() {
            UserService.GetAllProducts()
                    .then(function (product) {
                        vm.allProducts = product.listProduct;
                        console.log(product);
                    });
        }

        function loadAllCategories() {
            UserService.GetAllCategories()
                    .then(function (category) {
                        vm.allCategories = category.listCategory;

                    });
        }

        function loadAllUserProducts() {
            UserService.GetAllUserProducts()
                    .then(function (product) {
                        vm.allUserProducts = product.listProductUser;

                    });
        }

        function deleteUser(id) {
            UserService.Delete(id)
                    .then(function () {
                        loadAllUsers();
                    });
        }

        function createNewProduct() {
            UserService.CreateProduct(vm.newProductName, vm.newProductPrice, vm.newProductImg, vm.newProductDescription)
                    .then(function (data) {
                        if (data.ok) {
                            UserService.CreateUserProduct(vm.user.id).then(function (data) {
                                if (data.ok) {
                                    console.log(data.ok);
                                }

                            });
                            UserService.CreateProductCategory(vm.newProductCategory).then(function (data) {
                                if (data.ok) {
                                    console.log(data.ok);
                                }

                            });
                            loadAllUserProducts();
                            $location.path('/');
                            FlashService.Success('Nuevo producto agregado exitoso', true);
                        }

                        vm.newProductName = null;
                        vm.newProductPrice = null;
                        vm.newProductImg = null;
                        vm.newProductDescription = null;
                        vm.newProductCategory = null;
                        
                        gotoHome();

                    });
        }

        function showModal(p) {
            vm.idSeller = null;
            vm.selectProductName = p.name;
            vm.selectProductImg = p.imageUrl;
            vm.selectProductDes = p.description;
            vm.selectProductPrice = p.price;

            UserService.GetById(p.id)
                    .then(function (user) {
                        vm.seller = user.user;
                        console.log(vm.seller);
                    });



        }

    }

})();