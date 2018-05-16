<%-- 
    Document   : enviarMensaje
    Created on : 04-jul-2017, 13:59:02
    Author     : Caterin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Enviar mensaje</title>
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
                        <h3 class="center-align">Enviar mensaje</h3>
                        <div class="row">
                            <div class="col m6 offset-m3 s6 offset-s3">
                                <h6 class="center-align">${requestScope.msg}</h6>
                        </div>
                    </div>

                    <div class="row">
                        <div class="input-field col m6 offset-m3 s6 offset-s3">
                            <input id="usuario" name="asunto" type="text" required>
                            <label for="usuario">Asunto</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col m6 offset-m3 s6 offset-s3">
                            <textarea id="textarea1" name="contenido" class="materialize-textarea"></textarea>
                            <label for="textarea1">Contenido</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col m6 offset-m3 s6 offset-s3 ">
                            <button type="submit" name="bt" value="enviarMensaje" class="btn waves-effect waves-purple right">
                                Enviar
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
            $('#textarea1').val('');
            $('#textarea1').trigger('autoresize');
        </script>
    </body>
</html>
