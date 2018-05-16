<%-- 
    Document   : verRespuesta
    Created on : 07-jul-2017, 18:41:38
    Author     : Caterin
--%>


<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Ver respuesta</title>
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
                    <h3 class="center-align">Ver respuesta</h3>
                    <div class="row">
                        <div class="col m6 offset-m3 s6 offset-s3">
                            <h6 class="center-align">${requestScope.msg}</h6>
                    </div>
                </div>
                <form action="controlador.do" method="post">
                    <div class="row">
                        <div class="input-field col m6 offset-m3 s6 offset-s3">
                            <input id="usuario" name="asunto" value="${param.asunto}" type="text" >
                            <label for="usuario">Asunto</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col m6 offset-m3 s6 offset-s3">
                            <input id="usuario" name="contenido" value="${param.contenido}" type="text" >
                            <label for="usuario">Contenido</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col m6 offset-m3 s6 offset-s3">
                            <input id="usuario" name="contenido" value="${param.respuesta}" type="text" >
                            <label for="usuario">Respuesta</label>
                        </div>
                    </div>
                    <div class="row">
                        <div class="input-field col m6 offset-m3 s6 offset-s3 ">
                            <a href="verMensajes.jsp" class="btn waves-effect waves-purple right">
                                <i class="material-icons left">reply</i>
                                Volver
                            </a>
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
