<%-- 
    Document   : Archivo de peticiones
    Created on : dd/mm/yyyy, hh:mm: AM/PM
    Author     : nombre autor
--%>

<%@page import="logic.daos.UserRolDao"%>
<%@page import="logic.models.UserRolModel"%>
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

    UserRolDao userRolDao = UserRolDao.getInstance();

    String proceso = "" + request.getParameter("process");

    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";

        if (proceso.equals("save")) {

            String name = request.getParameter("name");

            UserRolModel userRol = new UserRolModel();
            userRol.setName(name);

            if (userRolDao.create(userRol)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("del")) {

            String idUserRol = request.getParameter("id");

            if (userRolDao.delete(Integer.parseInt(idUserRol))) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("list")) {

            try {
                List<UserRolModel> lista = userRolDao.readAll();
                respuesta += "\"" + proceso + "\": true,\"listUserRol\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"listUserRol\":[]";
                Logger.getLogger(UserRolDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("update")) {

            String idUserRol = request.getParameter("id");
            String nameUserRol = request.getParameter("name");

            UserRolModel userRol = new UserRolModel(Integer.parseInt(idUserRol), nameUserRol);

            if (userRolDao.update(userRol, userRol.getId())) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("find")) {

            String idUserRol = request.getParameter("id");

            try {
                UserRolModel userRol = userRolDao.read(Integer.parseInt(idUserRol));
                respuesta += "\"" + proceso + "\": true,\"userRol\":" + new Gson().toJson(userRol);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"userRol\":[]";
                Logger.getLogger(UserRolDao.class.getName()).log(Level.SEVERE, null, ex);
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

