<%-- 
    Document   : crearCliente
    Created on : 03-jul-2017, 20:21:03
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
        <title>Crear cliente</title>
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

                <div class="container">
                    <div class="row">
                        <div class="col m8 offset-m2 s10 offset-s1">
                            <form action="controlador.do" method="POST">
                                <br><br> 
                                <div class="card-panel transparente ">
                                    <div class="card-title center-align">
                                        <h4>Crear Cliente</h4>
                                    </div>
                                    <input  name="rutEje" value="${sessionScope.ejecutivo.rut}"  type="text" hidden>
                                <div class="card-content">
                                    <div class="row">
                                        <div class="col m12 s12">
                                            <div class="center-align"><b>${requestScope.msg}${sessionScope.msg}</b></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12">
                                            <input id="usuario" name="rut" type="text" required>
                                            <label for="usuario">RUT</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12 ">
                                            <input  id="contrasena" name="nombre" type="text" required>
                                            <label for="contrasena">Nombre</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12 ">
                                            <input  id="contrasena" name="apellido" type="text" required>
                                            <label for="contrasena">Apellido</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12 ">
                                            <input  id="contrasena" name="contrasena" type="password" required>
                                            <label for="contrasena">Contraseña</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12 ">
                                            <input  id="contrasena" name="contrasena2" type="password" required>
                                            <label for="contrasena">Confirmar contraseña</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12 ">
                                            <button type="submit" name="bt" value="crearCliente" class="btn waves-effect waves-purple right">
                                                Crear
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <div class="row">
                <table class="striped">
                    <thead>
                        <tr>
                            <th>Rut</th>
                            <th>Nombre</th>
                            <th>Clave</th>
                            <th>Ejecutivo</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${servicio.cliente}" var="m">
                            <tr>
                                <td>${m.rut}</td>
                                <td>${m.nombre} ${m.apellido}</td>
                                <td>${m.clave}</td>
                                <td>${m.ejecutivoFK.nombre}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
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
