<%-- 
    Document   : Archivo de peticiones
    Created on : dd/mm/yyyy, hh:mm: AM/PM
    Author     : nombre autor
--%>

<%@page import="logic.models.PostModel"%>
<%@page import="logic.daos.PostDao"%>
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

    PostDao postDao = PostDao.getInstance();

    String proceso = "" + request.getParameter("process");

    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";

        if (proceso.equals("save")) {

            String message = request.getParameter("message");
            String date = request.getParameter("date");
            String id_user = request.getParameter("id_user");
            String id_topic = request.getParameter("id_topic");

            PostModel post = new PostModel();
            
            post.setMessage(message);
            post.setDate(date);
            post.setUser(id_user);
            post.setTopic(id_topic);

            if (postDao.create(post)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("del")) {

            String id = request.getParameter("id");

            if (postDao.delete(id)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("list")) {

            try {
                List<PostModel> lista = postDao.readAll();
                respuesta += "\"" + proceso + "\": true,\"listPosts\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"listPosts\":[]";
                Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("update")) {

            String id = request.getParameter("id");
            String message = request.getParameter("message");
            String date = request.getParameter("date");
            String id_user = request.getParameter("id_user");
            String id_topic = request.getParameter("id_topic");

            PostModel post = new PostModel();
            
            post.setId(id);
            post.setMessage(message);
            post.setDate(date);
            post.setUser(id_user);
            post.setTopic(id_topic);

            if (postDao.update(post, post.getId())) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("find")) {

            String id = request.getParameter("id");

            try {
                PostModel post = postDao.read(id);
                respuesta += "\"" + proceso + "\": true,\"post\":" + new Gson().toJson(post);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"post\":[]";
                Logger.getLogger(PostDao.class.getName()).log(Level.SEVERE, null, ex);
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

