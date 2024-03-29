<%-- 
    Document   : Archivo de peticiones
    Created on : dd/mm/yyyy, hh:mm: AM/PM
    Author     : nombre autor
--%>



<%@page import="logic.models.CategoryModel"%>
<%@page import="logic.daos.CategoryDao"%>
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

    CategoryDao categoryDao = CategoryDao.getInstance();

    String proceso = "" + request.getParameter("process");

    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";

        if (proceso.equals("save")) {
 
            String name = request.getParameter("name");

            CategoryModel category = new CategoryModel(0, name);

            if (categoryDao.create(category)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("del")) {

            String id = request.getParameter("id");

            if (categoryDao.delete(id)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("list")) {

            try {
                List<CategoryModel> lista = categoryDao.readAll();
                respuesta += "\"" + proceso + "\": true,\"listCategory\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"listCategory\":[]";
                Logger.getLogger(CategoryDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("update")) {

            String id = request.getParameter("id");
            String name = request.getParameter("name");

            CategoryModel category = new CategoryModel(Integer.parseInt(id), name);

            if (categoryDao.update(category, String.valueOf(category.getId()))) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("find")) {


            String id = request.getParameter("id");

            try {
                CategoryModel category = categoryDao.read(id);
                respuesta += "\"" + proceso + "\": true,\"category\":" + new Gson().toJson(category);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"category\":[]";
                Logger.getLogger(CategoryDao.class.getName()).log(Level.SEVERE, null, ex);
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

