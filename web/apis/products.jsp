<%-- 
    Document   : Archivo de peticiones
    Created on : dd/mm/yyyy, hh:mm: AM/PM
    Author     : nombre autor
--%>



<%@page import="logic.daos.ProductDao"%>
<%@page import="logic.models.ProductModel"%>
<%@page import="java.util.logging.Logger"%>
<%@page import="java.util.logging.Level"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.Arrays"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page contentType="application/json;charset=iso-8859-1" language="java" pageEncoding="iso-8859-1" session="true"%>

<%
    String respuesta = "{";

    List<String> tareas = Arrays.asList(new String[]{
        "save",
        "del",
        "update",
        "list",
        "find",
        "getUserProd"
    });

    ProductDao productDao = ProductDao.getInstance();

    String proceso = "" + request.getParameter("process");

    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";

        if (proceso.equals("save")) {

            String name = request.getParameter("name");
            String desc = request.getParameter("description");
            String price = request.getParameter("price");
            String imageUrl = request.getParameter("image_url");

            ProductModel product = new ProductModel();

            product.setName(name);
            product.setDescription(desc);
            product.setPrice(price);
            product.setImageUrl(imageUrl);

            if (productDao.create(product)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("del")) {

            String id = request.getParameter("id");

            if (productDao.delete(id)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("list")) {

            try {
                List<ProductModel> lista = productDao.readAll();
                respuesta += "\"" + proceso + "\": true,\"listProduct\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"listProduct\":[]";
                Logger.getLogger(ProductDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("getUserProd")) {
            
             String id = request.getParameter("id");

            try {
                List<ProductModel> lista = productDao.readAllByUserId(id);
                respuesta += "\"" + proceso + "\": true,\"listProduct\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"listProduct\":[]";
                Logger.getLogger(ProductDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        }else if (proceso.equals("update")) {

            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String desc = request.getParameter("description");
            String price = request.getParameter("price");
            String imageUrl = request.getParameter("image_url");

            ProductModel product = new ProductModel();

            product.setName(name);
            product.setDescription(desc);
            product.setPrice(price);
            product.setImageUrl(imageUrl);

            if (productDao.update(product, id)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("find")) {

            String id = request.getParameter("id");

            try {
                ProductModel docType = productDao.read(id);
                respuesta += "\"" + proceso + "\": true,\"product\":" + new Gson().toJson(docType);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": false,\"product\":[]";
                Logger.getLogger(ProductDao.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }

    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>

