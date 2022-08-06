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

<%    // Iniciando respuesta JSON.
    String respuesta = "{";

    //Lista de procesos o tareas a realizar 
    List<String> tareas = Arrays.asList(new String[]{
        "save",
        "del",
        "update",
        "list",
        "find"
    });

    UserDao userDao = UserDao.getInstance();

    String proceso = "" + request.getParameter("process");

    // Validación de parámetros utilizados en todos los procesos.
    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";
        // ------------------------------------------------------------------------------------- //
        // -----------------------------------INICIO PROCESOS----------------------------------- //
        // ------------------------------------------------------------------------------------- //
        if (proceso.equals("save")) {

            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            // creación de objeto y llamado a método guardar    
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
            user.setDocType(Integer.parseInt(docType));
            user.setPhoneNumber(tel);
            user.setUserRol(Integer.parseInt(rol));

            if (userDao.create(user)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("del")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar

            String id = request.getParameter("id");

            if (userDao.delete(Long.parseLong(id))) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("list")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            try {
                List<UserModel> lista = new ArrayList<>();
                lista = userDao.readAll();
                respuesta += "\"" + proceso + "\": true,\"listUsers\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"listUsers\":[]";
                Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("update")) {
            //creación de objeto y llamado al metodo actualizar
            String id = request.getParameter("id");
            String name = request.getParameter("name");
            String email = request.getParameter("email");
            String password = request.getParameter("pass");
            String doc = request.getParameter("doc");
            String tel = request.getParameter("tel");
            String docType = request.getParameter("dtype");
            String rol = request.getParameter("rol");
            

            UserModel user = new UserModel();
            
            user.setId(Long.parseLong(id));
            user.setName(name);
            user.setEmail(email);
            user.setPassword(password);
            user.setDocument(doc);
            user.setDocType(Integer.valueOf(docType));
            user.setPhoneNumber(tel);
            user.setUserRol(Integer.valueOf(rol));
            
            if (userDao.update(user,user.getId())) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("find")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar

            String id = request.getParameter("id");

            try {
                UserModel user = userDao.read(Long.parseLong(id));
                respuesta += "\"" + proceso + "\": true,\"user\":" + new Gson().toJson(user);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"user\":[]";
                Logger.getLogger(UserDao.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

        // ------------------------------------------------------------------------------------- //
        // -----------------------------------FIN PROCESOS-------------------------------------- //
        // ------------------------------------------------------------------------------------- //
        // Proceso desconocido.
    } else {
        respuesta += "\"ok\": false,";
        respuesta += "\"error\": \"INVALID\",";
        respuesta += "\"errorMsg\": \"Lo sentimos, los datos que ha enviado,"
                + " son inválidos. Corrijalos y vuelva a intentar por favor.\"";
    }
    // Responder como objeto JSON codificación ISO 8859-1.
    respuesta += "}";
    response.setContentType("application/json;charset=iso-8859-1");
    out.print(respuesta);
%>

