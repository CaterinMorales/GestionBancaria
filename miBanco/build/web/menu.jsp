<%-- 
    Document   : menu
    Created on : 03-jul-2017, 20:06:44
    Author     : Caterin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>


<nav>
    <div class="nav-wrapper indigo darken-1">
        <c:if test="${empty ejecutivo and empty cliente}">
            <ul class="right hide-on-med-and-down">
                <li><a href="index.jsp">Iniciar Sesion</a></li>
            </ul>
            <ul class="side-nav" id="mobile-demo">
                <li><a href="#">MENU</a></li>
                <li><a href="index.jsp">Iniciar Sesion</a></li>
            </ul>
        </c:if>

        <c:if test="${not empty ejecutivo}">
            <a href="#!" class="brand-logo left hide-on-med-and-down">Bienvenido ejecutivo</a>
            <ul class="right hide-on-med-and-down">
                <li><a href="crearCliente.jsp">Crear cliente</a></li>
                <li><a href="crearCuenta.jsp">Crear cuenta</a></li>
                <li><a href="responderMensaje.jsp">Responder mensaje</a></li>
                <li><a href="depositarMonto.jsp">Depositar monto</a></li>
                <li><a href="aumentarLineaCredito.jsp">Aumentar linea de credito</a></li>
                <li><a href="consultarCliente.jsp">Consultar cliente</a></li>
                <li><a href="salir.jsp">Salir</a></li>
            </ul>
            <ul class="side-nav" id="mobile-demo">
                <li><a href="#">MENU</a></li>
                <li><a href="crearCliente.jsp">Crear cliente</a></li>
                <li><a href="crearCuenta.jsp">Crear cuenta</a></li>
                <li><a href="responderMensaje.jsp">Responder mensaje</a></li>
                <li><a href="depositarMonto.jsp">Depositar monto</a></li>
                <li><a href="aumentarLineaCredito.jsp">Aumentar linea de credito</a></li>
                <li><a href="consultarCliente.jsp">Consultar cliente</a></li>
                <li><a href="salir.jsp">Salir</a></li>
            </ul>
        </c:if>

        <c:if test="${not empty cliente}">
            <a href="#!" class="brand-logo left hide-on-med-and-down">Bienvenido ${sessionScope.cliente.nombre}</a>
            <ul class="right hide-on-med-and-down">
                <li><a href="consultarSaldo.jsp">Consultar cuentas y saldo</a></li>
                <li><a href="transferirMonto.jsp">Transferir monto</a></li>
                <li><a href="pagarLineaCredito.jsp">Pagar linea de credito</a></li>
                <li><a href="verMensajes.jsp">Ver mensajes</a></li>
                <li><a href="enviarMensaje.jsp">Enviar mensaje</a></li>
                <li><a href="salir.jsp">Salir</a></li>
            </ul>
            <ul class="side-nav" id="mobile-demo">
                <a href="#!" class="brand-logo">${sessionScope.cliente.nombre}</a>
                <a href="#" data-activates="mobile-demo" class="button-collapse"><i class="material-icons">menu</i></a>
                <li><a href="#">MENU</a></li>
                <li><a href="consultarSaldo.jsp">Consultar cuentas y saldo</a></li>
                <li><a href="transferirMonto.jsp">Transferir monto</a></li>
                <li><a href="pagarLineaCredito.jsp">Pagar linea de credito</a></li>
                <li><a href="verMensajes.jsp">Ver mensajes</a></li>
                <li><a href="enviarMensaje.jsp">Enviar mensaje</a></li>
                <li><a href="salir.jsp">Salir</a></li>
            </ul>
        </c:if>
    </div>

</nav>