<%-- 
    Document   : Archivo de peticiones
    Created on : dd/mm/yyyy, hh:mm: AM/PM
    Author     : nombre autor
--%>



<%@page import="logic.models.ProductCategoryModel"%>
<%@page import="logic.daos.ProductCategoryDao"%>
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
        "find"
    });

    ProductCategoryDao productDao = ProductCategoryDao.getInstance();

    String proceso = "" + request.getParameter("process");

    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";

        if (proceso.equals("save")) {

            String user = request.getParameter("id_category");

            ProductCategoryModel product = new ProductCategoryModel();

            product.setId_category(Integer.valueOf(user));
            product.setId_product(0);

            if (productDao.create(product)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("del")) {

            String id = request.getParameter("id");

            if (productDao.delete(Integer.valueOf(id))) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("list")) {

            try {
                List<ProductCategoryModel> lista = productDao.readAll();
                respuesta += "\"" + proceso + "\": true,\"listProductCategory\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"listProductCategory\":[]";
                Logger.getLogger(ProductCategoryDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("update")) {

            String id = request.getParameter("id");
            String user = request.getParameter("id_category");
            String prod = request.getParameter("id_product");

            ProductCategoryModel product = new ProductCategoryModel();

            product.setId(Integer.valueOf(id));
            product.setId_category(Integer.valueOf(user));
            product.setId_product(Integer.valueOf(prod));

            if (productDao.update(product, Integer.valueOf(id))) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("find")) {

            String id = request.getParameter("id");

            try {
                ProductCategoryModel docType = productDao.read(Integer.valueOf(id));
                respuesta += "\"" + proceso + "\": true,\"productCategory\":" + new Gson().toJson(docType);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": false,\"productCategory\":[]";
                Logger.getLogger(ProductCategoryDao.class.getName()).log(Level.SEVERE, null, ex);
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

