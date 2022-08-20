<%-- 
    Document   : Archivo de peticiones
    Created on : dd/mm/yyyy, hh:mm: AM/PM
    Author     : nombre autor
--%>

<%@page import="logic.models.UserModel"%>
<%@page import="logic.daos.UserDao"%>
<%@page import="logic.daos.UserRolDao"%>
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
        "auth"
    });

    UserDao userDao = UserDao.getInstance();

    String proceso = "" + request.getParameter("process");

    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";

        if (proceso.equals("save")) {

            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("pass");
            String doc = request.getParameter("doc");
            String tel = request.getParameter("tel");
            String docType = request.getParameter("dtype");
            String rol = request.getParameter("rol");

            UserModel user = new UserModel();

            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setDocument(doc);
            user.setDocType(docType);
            user.setPhoneNumber(tel);
            user.setUserRol(rol);

            if (userDao.create(user)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("del")) {

            String id = request.getParameter("id");

            if (userDao.delete(id)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("list")) {

            try {
                List<UserModel> lista = new ArrayList<>();
                lista = userDao.readAll();
                respuesta += "\"" + proceso + "\": true,\"listUsers\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"listUsers\":[]";
                Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("update")) {

            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("pass");
            String doc = request.getParameter("doc");
            String tel = request.getParameter("tel");
            String docType = request.getParameter("dtype");
            String rol = request.getParameter("rol");

            UserModel user = new UserModel();

            user.setId(id);
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setDocument(doc);
            user.setDocType(docType);
            user.setPhoneNumber(tel);
            user.setUserRol(rol);

            if (userDao.update(user, user.getId())) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("auth")) {

            String email = request.getParameter("email");
            String pass = request.getParameter("pass");

            try {
                UserModel user = userDao.logIn(email, pass);
                respuesta += "\"" + proceso + "\": true,\"user\":" + new Gson().toJson(user);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": false,\"user\":[]";
                Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inv�lidos. Corrijalos y vuelva a intentar por favor.\"";
    }

    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>

