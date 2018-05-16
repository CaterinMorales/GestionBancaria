<%-- 
    Document   : index
    Created on : 03-jul-2017, 17:30:01
    Author     : Caterin
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Login</title>
        <!--Import Google Icon Font-->
        <link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
        <!--Import materialize.css-->
        <link type="text/css" rel="stylesheet" href="css/materialize.min.css"  media="screen,projection"/>
        <link href="css/estilo.css" rel="stylesheet" type="text/css"/>

        <!--Let browser know website is optimized for mobile-->
        <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    </head>

    <body>
        <div class="row">
            <div class="col m6 offset-m3 s6 offset-s3">
                <div class="row">
                    <div class="col m8 offset-m2 s10 offset-s1">
                        <form action="controlador.do" method="POST">
                            <br><br> 
                            <div class="card-panel transparente ">
                                <div class="card-title center-align">
                                    <h4>Iniciar Sesion</h4>
                                </div>
                                <div class="card-content">
                                    <div class="row">
                                        <div class="input-field col m12 s12">
                                            <input id="usuario" name="usuario" type="text" required>
                                            <label for="usuario">Usuario</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12 ">
                                            <input  id="contrasena" name="contrasena" type="password" required>
                                            <label for="contrasena">Contraseña</label>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col s6">
                                            <p>
                                                <input name="tipo" value="cliente" type="radio" id="test1" checked />
                                                <label for="test1">Cliente</label>
                                            </p>
                                        </div>
                                        <div class="col s6">
                                            <p>
                                                <input name="tipo" value="ejecutivo" type="radio" id="test2" />
                                                <label for="test2">Ejecutivo</label>
                                            </p>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="input-field col m12 s12 ">
                                            <button type="submit" name="bt" value="iniciarSesion" class="btn waves-effect waves-purple right">
                                                Entrar
                                            </button>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col m12 s12">
                                            <div class="center-align"><b>${requestScope.msg}</b></div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>


        <!--Import jQuery before materialize.js-->
        <script type="text/javascript" src="https://code.jquery.com/jquery-2.1.1.min.js"></script>
        <script type="text/javascript" src="js/materialize.min.js"></script>

        <script type="text/javascript">
            $(".button-collapse").sideNav();
        </script>
    </body>
</html>

<!-- crear cuenta -->