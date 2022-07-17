<%-- 
    Document   : Archivo de peticiones
    Created on : dd/mm/yyyy, hh:mm: AM/PM
    Author     : nombre autor
--%>

<%@page import="logic.models.DocTypeModel"%>
<%@page import="logic.daos.DocTypeDao"%>
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

    DocTypeDao docTypeDao = DocTypeDao.getInstance();

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
            String id = request.getParameter("id");
            String name = request.getParameter("name");

            DocTypeModel userRol = new DocTypeModel(Integer.parseInt(id), name);

            if (docTypeDao.create(userRol)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("del")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado a método eliminar

            String idUserRol = request.getParameter("id");

            if (docTypeDao.delete(Integer.parseInt(idUserRol))) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("list")) {
            //Solicitud de parámetros enviados desde el frontned
            //, uso de request.getParameter("nombre parametro")
            //creación de objeto y llamado al metodo listar
            try {
                List<DocTypeModel> lista = docTypeDao.readAll();
                respuesta += "\"" + proceso + "\": true,\"listDocType\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"listDocType\":[]";
                Logger.getLogger(DocTypeDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("update")) {
            //creación de objeto y llamado al metodo actualizar
            String idUserRol = request.getParameter("id");
            String nameUserRol = request.getParameter("name");

            DocTypeModel docType = new DocTypeModel(Integer.parseInt(idUserRol), nameUserRol);

            if (docTypeDao.update(docType, docType.getId())) {
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
                DocTypeModel docType = docTypeDao.read(Integer.parseInt(id));
                respuesta += "\"" + proceso + "\": true,\"userRol\":" + new Gson().toJson(docType);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"userRol\":[]";
                Logger.getLogger(DocTypeDao.class.getName()).log(Level.SEVERE, null, ex);
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

