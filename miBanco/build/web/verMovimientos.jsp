<%-- 
    Document   : verMovimientos
    Created on : 06-jul-2017, 13:38:14
    Author     : Caterin
--%>

<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="cl.model.ServicioLocal"%>
<%-- 
    Document   : enviarMensaje
    Created on : 04-jul-2017, 13:59:02
    Author     : Caterin
--%>
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
        <title>Ver movimientos</title>
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>

    <body>
        <c:if test="${not empty sessionScope.ejecutivo or not empty sessionScope.cliente}">
            <c:import url="menu.jsp"></c:import>

            <div class="container"><br>
                    <div class="row">
                        <div class="col s4">
                            <h4>Número de cuenta: ${param.numerocta}</h4>
                        </div>
                        <div class="col s4">
                            <h4>Saldo: $${param.saldo}</h4>
                        </div>
                    </div>
                    <div class="row">
                    <table class="striped">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Fecha</th>
                                <th>Descripción</th>
                            </tr>
                        </thead>

                        <tbody>
                            <c:forEach items="${servicio.movimientos}" var="m">
                                <c:if test="${param.numerocta eq m.cuentaFK.numerocta}">
                                    <tr>
                                        <td>${m.idmovimiento}</td>
                                        <td>${m.fecha}</td>
                                        <td>${m.descripcion}</td>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>


        </c:if>

        <c:if test="${empty sessionScope.ejecutivo and empty sessionScope.cliente}">
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

