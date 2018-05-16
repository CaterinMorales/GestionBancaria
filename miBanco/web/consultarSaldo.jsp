<%-- 
    Document   : consultarSaldo
    Created on : 03-jul-2017, 20:21:11
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
        <title>Consultar saldo</title>
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

                <!--TABLA-->
                <br>
                <h2 class="center-align">Mis Cuentas</h2>
                <div class="row">
                    <div class="col m10 offset-m1 s10 offset-s1">
                        <table class="striped">
                            <thead>
                                <tr>
                                    <th>Número de cuenta</th>
                                    <th>Saldo</th>
                                    <th>Saldo de LC utilizada</th>
                                    <th>Saldo de LC disponible </th>
                                    <th>Saldo de LC Total</th>
                                    <th>Estado</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach items="${servicio.cuentas}" var="c">
                                <c:if test="${sessionScope.cliente.rut eq c.clienteFK.rut}">
                                    <tr>
                                        <td>${c.numerocta}</td>
                                        <td>$${c.saldo}</td>
                                        <td>$${c.saldolineacreditousado}</td>
                                        <td>$${c.saldolineacredito}</td>
                                        <td>$${c.saldolineacreditousado + c.saldolineacredito }</td>
                                        <c:if test="${c.estado eq 1}">
                                            <td>Activo</td>
                                            <td>
                                                <a href="verMovimientos.jsp?numerocta=${c.numerocta}&saldo=${c.saldo}&saldolineacredito=${c.saldolineacredito}&estado=${c.estado}" class="btn-floating green">
                                                    <i class="material-icons">visibility</i>
                                                </a>
                                            </td>
                                        </c:if>
                                        <c:if test="${c.estado eq 0}">
                                            <td>Inactivo</td>
                                            <td>
                                                <a href="verMovimientos.jsp?numerocta=${c.numerocta}&saldo=${c.saldo}&saldolineacredito=${c.saldolineacredito}&estado=${c.estado}" class="btn-floating red">
                                                    <i class="material-icons">visibility</i>
                                                </a>
                                            </td>
                                        </c:if>
                                    </tr>
                                </c:if>
                            </c:forEach>
                        </tbody>
                    </table>
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
