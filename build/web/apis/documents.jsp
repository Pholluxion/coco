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

<%
    String respuesta = "{";

    List<String> tareas = Arrays.asList(new String[]{
        "save",
        "del",
        "update",
        "list",
        "find"
    });

    DocTypeDao docTypeDao = DocTypeDao.getInstance();

    String proceso = "" + request.getParameter("process");

    if (tareas.contains(proceso)) {
        respuesta += "\"ok\": true,";

        if (proceso.equals("save")) {

            String name = request.getParameter("name");

            DocTypeModel document = new DocTypeModel(0, name);

            if (docTypeDao.create(document)) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("del")) {

            String id = request.getParameter("id");

            if (docTypeDao.delete(Integer.parseInt(id))) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }

        } else if (proceso.equals("list")) {

            try {
                List<DocTypeModel> lista = docTypeDao.readAll();
                respuesta += "\"" + proceso + "\": true,\"listDocType\":" + new Gson().toJson(lista);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"listDocType\":[]";
                Logger.getLogger(DocTypeDao.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (proceso.equals("update")) {

            String id = request.getParameter("id");
            String name = request.getParameter("name");

            DocTypeModel docType = new DocTypeModel(Integer.parseInt(id), name);

            if (docTypeDao.update(docType, docType.getId())) {
                respuesta += "\"" + proceso + "\": true";
            } else {
                respuesta += "\"" + proceso + "\": false";
            }
        } else if (proceso.equals("find")) {

            String id = request.getParameter("id");

            try {
                DocTypeModel docType = docTypeDao.read(Integer.parseInt(id));
                respuesta += "\"" + proceso + "\": true,\"docType\":" + new Gson().toJson(docType);
            } catch (Exception ex) {
                respuesta += "\"" + proceso + "\": true,\"docType\":[]";
                Logger.getLogger(DocTypeDao.class.getName()).log(Level.SEVERE, null, ex);
            }

        }

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

