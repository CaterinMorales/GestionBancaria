<%-- 
    Document   : crearCuenta
    Created on : 04-jul-2017, 13:54:24
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
                                        <h4>Crear Cuenta</h4>
                                    </div>
                                    <div class="card-content">
                                        <div class="row">
                                            <div class="col m12 s12">
                                                <div class="center-align"><b>${requestScope.msg}</b></div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12">
                                            <input id="usuario" name="numerocta" type="text" required>
                                            <label for="usuario">Numero de cuenta</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12 ">
                                            <input  id="contrasena" name="saldoLineaCredito" type="text" required>
                                            <label for="contrasena">Saldo de línea de credito</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12 ">
                                            <input  id="contrasena" name="cliente" type="text" required>
                                            <label for="contrasena">Rut cliente</label>
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
                                            <button type="submit" name="bt" value="crearCuenta" class="btn waves-effect waves-purple right">
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
                            <th>Numero de cuenta</th>
                            <th>Saldo</th>
                            <th>Clave de transaccion</th>
                            <th>Saldo de LC utilizada</th>
                            <th>Saldo de LC disponible </th>
                            <th>Saldo de LC Total</th>
                            <th>Estado</th>
                            <th>Nombre de cliente</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${servicio.cuentas}" var="m">
                            <tr>
                                <td>${m.numerocta}</td>
                                <td>${m.saldo}</td>
                                <td>${m.clavetransaccion}</td>
                                <td>$${m.saldolineacreditousado}</td>
                                <td>$${m.saldolineacredito}</td>
                                <td>$${m.saldolineacreditousado + m.saldolineacredito }</td>
                                <c:if test="${m.estado eq 1}">
                                    <td>Activo</td>
                                </c:if>
                                <c:if test="${m.estado eq 0}">
                                    <td>Inactivo</td>
                                </c:if>
                                <td>${m.clienteFK.nombre}</td>
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
