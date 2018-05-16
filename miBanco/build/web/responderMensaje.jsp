<%-- 
    Document   : responderMensaje
    Created on : 04-jul-2017, 13:54:56
    Author     : Caterin
--%><%@page import="javax.naming.InitialContext"%>
<%@page import="cl.model.ServicioLocal"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%! ServicioLocal servicio;%>
<%
    InitialContext ctx = new InitialContext();
    servicio = (ServicioLocal) ctx.lookup("java:global/miBanco/Servicio!cl.model.ServicioLocal");

%>

<c:set var="servicio" value="<%=servicio%>"  scope="page" />

<!DOCTYPE html>
<html>
    <head>
        <title>Responder mensaje</title>
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>

    <body>
        <c:if test="${not empty sessionScope.ejecutivo}">
            <c:import url="menu.jsp"></c:import>

                <div class="row">
                    <div class="col m6 offset-m3 s6 offset-s3">
                        <h2 class="center-align">Responder Mensajes</h2>
                    </div>
                </div>
                <br><br>
                <!--TABLA-->
                <div class="row">
                    <div class="col m10 offset-m1 s10 offset-s1">
                        <div class="row">
                            <table class="striped">
                                <thead>
                                    <tr>
                                        <th>Rut de Cliente</th>
                                        <th>Nombre de cliente</th>
                                        <th>ID mensaje</th>
                                        <th>Asunto</th>
                                        <th>Contenido</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${servicio.mensajes}" var="m">
                                    <c:if test="${sessionScope.ejecutivo.rut eq m.ejecutivoFK.rut}">
                                        <tr>
                                            <td>${m.clienteFK.rut}</td>
                                            <td>${m.clienteFK.nombre} ${m.clienteFK.apellido}</td>
                                            <td>${m.idmensaje}</td>
                                            <td>${m.asunto}</td>
                                            <td>${m.contenido}</td>
                                            <c:if test="${empty m.respuesta}">
                                                <td>
                                                    <a 
                                                        href="responder.jsp?idmensaje=${m.idmensaje}&asunto=${m.asunto}&contenido=${m.contenido}&nombre=${m.clienteFK.nombre}&apellido=${m.clienteFK.apellido}" 
                                                        class="waves-effect waves-light btn green"
                                                        >
                                                        <i class="material-icons right">send</i>
                                                        Responder
                                                    </a>
                                                </td>
                                            </c:if>
                                            <c:if test="${not empty m.respuesta}">
                                                <td>
                                                    <button href="" class="waves-effect waves-light btn" disabled>
                                                        <i class="material-icons right">done all</i>
                                                        LISTO
                                                    </button>
                                                </td>
                                            </c:if>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </c:if>

        <c:if test="${empty sessionScope.ejecutivo}">
            <a href="index.jsp">Debe iniciar sesion para estar aquí</a>
        </c:if>
        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="js/materialize.min.js"></script>
        <script type="text/javascript">
            $(".button-collapse").sideNav();
        </script>
    </body>
</html>