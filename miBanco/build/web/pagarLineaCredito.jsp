<%-- 
    Document   : pagarLineaCredito
    Created on : 04-jul-2017, 13:57:59
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
        <title>Pagar línea de credito</title>
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

                <div class="container">
                    <form action="controlador.do" method="post">
                        <h3 class="center-align">Pagar línea de credito</h3>
                        <div class="row">
                            <div class="col m6 offset-m3 s6 offset-s3">
                                <h6 class="center-align">${requestScope.msg}</h6>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col m6 offset-m3 s6 offset-s3">
                            <select name="ctaOrigen">
                                <option value="" disabled selected>Cuenta a pagar</option>
                                <c:forEach items="${servicio.cuentas}" var="c">
                                    <c:if test="${c.clienteFK.rut eq sessionScope.cliente.rut}">
                                        <c:if test="${c.saldolineacreditousado > 0}">
                                            <option value="${c.numerocta}">${c.numerocta}</option>
                                        </c:if>
                                    </c:if>
                                </c:forEach>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col m6 offset-m3 s6 offset-s3">
                            <input id="usuario" name="monto" type="text" required>
                            <label for="usuario">Monto a pagar</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col m6 offset-m3 s6 offset-s3 ">
                            <button type="submit" name="bt" value="pagarLineaCredito" class="btn waves-effect waves-purple right">
                                Pagar
                            </button>
                        </div>
                    </div>
                </form>
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
        <script type="text/javascript">
            $(".button-collapse").sideNav();
            $(document).ready(function () {
                $('select').material_select();
            });
        </script>
    </body>
</html>
