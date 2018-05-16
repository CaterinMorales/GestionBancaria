<%-- 
    Document   : verMensajes
    Created on : 04-jul-2017, 13:58:31
    Author     : Caterin
--%>
<%@page import="javax.naming.InitialContext"%>
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
        <title>Ver mensajes</title>
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>

    <body>
        <c:if test="${not empty sessionScope.cliente}">
            <c:import url="menu.jsp"></c:import>
            <br>
                <!--TABLA-->
                <div class="row">
                    <div class="col m6 offset-m3 s6 offset-s3">
                        <h2 class="center-align">Lista de mensajes</h2>
                    </div>
                </div><br>
                
                <div class="row">
                    <div class="col m10 offset-m1 s10 offset-s1">
                        <div class="row">
                            <table class="striped">
                                <thead>
                                    <tr>
                                        <th>Nombre de ejecutivo</th>
                                        <th>ID mensaje</th>
                                        <th>Asunto</th>
                                        <th>Contenido</th>
                                    </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${servicio.mensajes}" var="m">
                                    <c:if test="${sessionScope.cliente.rut eq m.clienteFK.rut}">
                                        <tr>
                                            <td>${m.ejecutivoFK.nombre} ${m.ejecutivoFK.apellido}</td>
                                            <td>${m.idmensaje}</td>
                                            <td>${m.asunto}</td>
                                            <td>${m.contenido}</td>
                                            <c:if test="${not empty m.respuesta}">
                                                <td>
                                                    <a 
                                                        href="verRespuesta.jsp?asunto=${m.asunto}&contenido=${m.contenido}&respuesta=${m.respuesta}" 
                                                        class="waves-effect waves-light btn green"
                                                        >
                                                        <i class="material-icons right">visibility</i>
                                                        Leer
                                                    </a>
                                                </td>
                                            </c:if>
                                            <c:if test="${empty m.respuesta}">
                                                <td>
                                                    <button href="" class="waves-effect waves-light btn" disabled>
                                                        EN ESPERA
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

        <c:if test="${empty sessionScope.cliente}">
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
