<%-- 
    Document   : aumentarLineaCredito
    Created on : 04-jul-2017, 13:55:36
    Author     : Caterin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Aumentar línea de credito</title>
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
                                        <h4>Aumentar linea de credito</h4>
                                    </div>
                                    <div class="card-content">
                                        <div class="row">
                                            <div class="col m12 s12">
                                                <div class="center-align">
                                                    <b>${requestScope.msg}</b>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12  ">
                                            <input id="usuario" name="cta" type="text" required>
                                            <label for="usuario">Numero de cuenta</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12  ">
                                            <input id="usuario" name="monto" type="text" required>
                                            <label for="usuario">Aumento</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m2 s2">
                                            <button type="submit" name="bt" value="aumentarLineaCredito" class="waves-effect waves-light btn blue">
                                                Aumentar
                                            </button>
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </form>
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