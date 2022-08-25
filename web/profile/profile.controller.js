(function () {
    'use strict';

    angular
            .module('app')
            .controller('ProfileController', ProfileController);

    ProfileController.$inject = ['UserService', '$rootScope', 'FlashService', '$location', '$scope', '$route'];
    function ProfileController(UserService, $rootScope, FlashService, $location, $scope, $route) {
        var vm = this;

        vm.user = null;
        vm.showModal = showModal;
        vm.deleteProduct = deleteProduct;
        vm.createNewProduct = createNewProduct;
        vm.updateProduct = updateProduct;
        vm.updateUser = updateUser;
        vm.allDocsType = null;
        initController();

        vm.gotoHome = gotoHome;
        vm.gotoCart = gotoCart;
        vm.gotoForum = gotoForum;


        function gotoHome() {
            $location.path('/');
        }

        function gotoCart() {
            $location.path('/cart');
        }

        function gotoForum() {
            $location.path('/forum');
        }


        function initController() {
            loadCurrentUser();
            loadAllUsers();
            loadAllProducts();
            loadAllUserProducts();
            loadAllCategories();
            loadAllDocs();


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
            UserService.GetProductByUserId(vm.user.id)
                    .then(function (product) {
                        vm.allProducts = product.listProduct;
                        if (product.listProduct.length === 0) {
                            vm.valProducts = false;
                        } else {
                            vm.valProducts = true;
                        }
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

        function deleteProduct(id) {
            UserService.DeleteProduct(id)
                    .then(function () {
                        loadAllProducts();
                        $location.path('/profile');
                        FlashService.Success('Producto eliminado con exito', true);
                    });
        }

        function createNewProduct() {
            UserService.CreateProduct(vm.newProductName, vm.newProductPrice, vm.newProductImg, vm.newProductDescription)
                    .then(function (data) {
                        if (data.ok) {
                            UserService.CreateUserProduct(vm.user.id).then(function (data) {
                                if (data.ok) {
                                    console.log("User Category: ", data.ok);
                                }

                            });
                            UserService.CreateProductCategory(vm.newProductCategory).then(function (data) {
                                if (data.ok) {
                                    console.log(data.ok);
                                }

                            });
                            loadAllUserProducts();
                            $route.reload();
                            FlashService.Success('Nuevo producto agregado con exito', true);
                        }

                        vm.newProductName = null;
                        vm.newProductPrice = null;
                        vm.newProductImg = null;
                        vm.newProductDescription = null;
                        vm.newProductCategory = null;


                    });
        }

        function updateProduct() {

            UserService.UpdateProduct(vm.selectProductId, vm.updateProductName, vm.updateProductPrice, vm.updateProductImg, vm.updateProductDescription)
                    .then(function (data) {
                        if (data.ok) {

                            UserService.CreateProductCategory(vm.newProductCategory).then(function (data) {

                            });
                            loadAllUserProducts();
                            $route.reload();
                            FlashService.Success('Producto actualizado con exito', true);
                        }

                    });
        }
        function updateUser() {

            UserService.UpdateUser(vm.user);
            $location.path('/login');

        }
        function loadAllDocs() {
            UserService.GetUserDocType()
                    .then(function (users) {
                        console.log(users);
                        vm.allDocsType = users.listDocType;
                    });
        }

        function showModal(p) {
            vm.idSeller = null;
            vm.selectProductId = p.id;
            vm.selectProductName = p.name;
            vm.selectProductImg = p.imageUrl;
            vm.selectProductDes = p.description;
            vm.selectProductPrice = p.price;

            vm.selectProductId = p.id;
            vm.updateProductImg = p.imageUrl;
            vm.updateProductName = p.name;
            vm.updateProductPrice = p.price;
            vm.updateProductDescription = p.description;

            console.log(p);
            UserService.GetById(p.id)
                    .then(function (user) {
                        vm.seller = user.user;
                        console.log(vm.seller);
                    });



        }

    }

})();