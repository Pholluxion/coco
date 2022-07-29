<%-- 
    Document   : register
    Created on : 22/07/2022, 12:59:52 p. m.
    Author     : CENTIC
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>

        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <style>div{padding: 5px;}</style>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

    </head>
    <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.8.2/angular.min.js"></script>
    <body>

        <div class="container-fluid" style="background: buttonface" ng-app="demov1" ng-controller="b1Controller as b1">

            <div class = "row" >

                <div class = "col-6">

                    <div class = "row">
                        <div class = "col-12" >
                            <h1>Registro de usuario</h1>
                        </div>

                    </div>

                    <div class = "row">
                        <div class = "col-6">

                            <input type="text" class="form-control"  ng-model="b1.name" placeholder="Nombre">

                        </div>
                        <div class = "col-6">

                            <input type="text" class="form-control" ng-model="b1.email" placeholder="Correo electrónico">

                        </div>
                    </div>
                    <div class = "row">
                        <div class = "col-6">

                            <input type="text" class="form-control" ng-model="b1.password" placeholder="Contraseña">

                        </div>
                        <div class = "col-6">

                            <input type="text" class="form-control" ng-model="b1.password" placeholder="Contraseña">

                        </div>
                    </div>
                    <div class = "row">
                        <div class = "col-6">

                            <input type="text" class="form-control" ng-model="b1.document" placeholder="Número de documento">

                        </div>
                        <div class = "col-6">

                            <input type="text" class="form-control" ng-model="b1.doc_type" placeholder="Tipo de documento">

                        </div>
                    </div>
                    <div class = "row">
                        <div class = "col-6">

                            <input type="text" class="form-control" ng-model="b1.phone_number" placeholder="Número de telefono">

                        </div>
                        <div class = "col-6">

                            <input type="text" class="form-control" ng-model="b1.rol" placeholder="Rol de usuario">

                        </div>
                    </div>

                    <div class = "row" >
                        <div class = "col-3">
                            <a class="btn btn-primary " href="#" role="button" ng-click="b1.save()">Registrar</a>
                        </div>
                        <div class = "col-3">
                            <a class="btn btn-primary btn-success" href="#" role="button" ng-click="b1.list()">Listar</a>
                        </div>
                        <div class = "col-3">


                            <input type="text" class="form-control" placeholder="id" ng-model="b1.id">
                            <div class="input-group-append">
                                <button class="btn btn-primary btn-warning" type="button" ng-click="b1.update()">Actualizar</button>
                            </div>



                        </div>
                        <div class = "col-3">


                            <input type="text" class="form-control" placeholder="id" ng-model="b1.id">
                            <div class="input-group-append">
                                <button class="btn btn-primary btn-danger" type="button" ng-click="b1.delete()" ng-click="b1.list()">Borrar</button>
                            </div>

                        </div>
                    </div>


                </div>

                <div class = "col-6">


                    <div class = "row">
                        <div class = "col-12" >
                            <h1>Confirmación de datos</h1>
                        </div>

                    </div>

                    <div class = "row">
                        <div class = "col-6">

                            <input type="text" class="form-control"  ng-model="b1.name" placeholder="Nombre" disabled="true" value="{{b1.name}}">

                        </div>
                        <div class = "col-6">

                            <input type="text" class="form-control" ng-model="b1.email" placeholder="Correo electrónico" disabled="true" value="{{b1.email}}">

                        </div>
                    </div>
                    <div class = "row">
                        <div class = "col-6">

                            <input type="text" class="form-control" ng-model="b1.password" placeholder="Contraseña" disabled="true" value="{{b1.password}}">

                        </div>
                        <div class = "col-6">

                            <input type="text" class="form-control" ng-model="b1.password" placeholder="Contraseña" disabled="true" value="{{b1.password}}">

                        </div>
                    </div>
                    <div class = "row">
                        <div class = "col-6">

                            <input type="text" class="form-control" ng-model="b1.document" placeholder="Número de documento" disabled="true" value="{{b1.document}}">

                        </div>
                        <div class = "col-6">
                            <input type="text" class="form-control" ng-model="b1.doc_type" placeholder="Tipo de documento" disabled="true" value="{{b1.doc_type}}">


                        </div>
                    </div>
                    <div class = "row">
                        <div class = "col-6">
                            <input type="text" class="form-control" ng-model="b1.phone_number" placeholder="Número de telefono" disabled="true" value="{{b1.phone_number}}">

                        </div>
                        <div class = "col-6">
                            <input type="text" class="form-control" ng-model="b1.rol" placeholder="Rol de usuario" disabled="true" value="{{b1.rol}}">

                        </div>
                    </div>

                </div>

                <table class="table table-striped">
                    <thead>
                        <tr>
                            <th scope="col">id</th>
                            <th scope="col">Nombre</th>
                            <th scope="col">Correo</th>
                            <th scope="col">Password</th>
                            <th scope="col">Tipo de documento</th>
                            <th scope="col">Número de documento</th>
                            <th scope="col">Telefono</th>
                            <th scope="col">Rol</th>

                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="user in b1.Users">
                            <td>{{user.id}}</td>
                            <td>{{user.name}}</td>
                            <td>{{user.email}}</td>
                            <td>{{user.password}}</td>
                            <td>{{user.docType}}</td>
                            <td>{{user.document}}</td>
                            <td>{{user.phoneNumber}}</td>
                            <td>{{user.userRol}}</td>
                        </tr>
                    </tbody>
                </table>

            </div>

        </div>

        <script>
            var app = angular.module('demov1', []);
            app.controller('b1Controller', ['$http', controller]);
            function  controller($http) {
                var b1 = this;
                b1.list = function () {
                    var parametros = {process: 'list'};

                    $http({
                        method: 'POST',
                        url: 'apis/user_api.jsp',
                        params: parametros
                    }).then(function (response) {
                        console.log(response.data.listUsers);
                        b1.Users = response.data.listUsers;
                    });
                };

                b1.save = function () {
                    var parametros = {
                        process: 'save',
                        name: b1.name,
                        email: b1.email,
                        pass: b1.password,
                        doc: b1.document,
                        tel: b1.phone_number,
                        dtype: b1.doc_type,
                        rol: b1.rol
                    };

                    $http({
                        method: 'POST',
                        url: 'apis/user_api.jsp',
                        params: parametros
                    }).then(function (response) {
                        console.log(response.data.ok);
                        if (response.data.ok) {
                            alert("Registro exitoso");
                        }
                    });
                };

                b1.update = function () {
                    var parametros = {
                        process: 'update',
                        id: b1.id,
                        name: b1.name,
                        email: b1.email,
                        pass: b1.password,
                        doc: b1.document,
                        tel: b1.phone_number,
                        dtype: b1.doc_type,
                        rol: b1.rol
                    };

                    $http({
                        method: 'POST',
                        url: 'apis/user_api.jsp',
                        params: parametros
                    }).then(function (response) {
                        console.log(response.data.ok);
                        if (response.data.ok) {
                            alert("Actualización exitosa");
                        }

                    });

                };

                b1.delete = function () {
                    var parametros = {
                        process: 'del',
                        id: b1.id
                    };

                    $http({
                        method: 'POST',
                        url: 'apis/user_api.jsp',
                        params: parametros
                    }).then(function (response) {
                        console.log(response.data.ok);
                        if (response.data.ok) {
                            
                            alert("Usuario eliminado exitosamente");
                        }
                    });
                };

            }


        </script>

    </body>
</html>
