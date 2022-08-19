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

    UserRolDao userRolDao = UserRolDao.getInstance();

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

            UserRolModel userRol = new UserRolModel();
            userRol.setName(name);

            if (userRolDao.create(userRol)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("del")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar

            String idUserRol = request.getParameter("id");

            if (userRolDao.delete(Integer.parseInt(idUserRol))) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("list")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            try {
                List<UserRolModel> lista = userRolDao.readAll();
                respuesta += "\"" + proceso + "\": true,\"listUserRol\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"listUserRol\":[]";
                Logger.getLogger(UserRolDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("update")) {
            //creación de objeto y llamado al metodo actualizar
            String idUserRol = request.getParameter("id");
            String nameUserRol = request.getParameter("name");

            UserRolModel userRol = new UserRolModel(Integer.parseInt(idUserRol), nameUserRol);

            if (userRolDao.update(userRol, userRol.getId())) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("find")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar

            String idUserRol = request.getParameter("id");

            try {
                UserRolModel userRol = userRolDao.read(Integer.parseInt(idUserRol));
                respuesta += "\"" + proceso + "\": true,\"userRol\":" + new Gson().toJson(userRol);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"userRol\":[]";
                Logger.getLogger(UserRolDao.class.getName()).log(Level.SEVERE, null, ex);
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

