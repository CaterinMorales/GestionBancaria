/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cl.Controller;

import cl.model.ServicioLocal;
import cl.pojos.Cliente;
import cl.pojos.Cuenta;
import cl.pojos.Ejecutivo;
import cl.pojos.Mensaje;
import cl.pojos.Movimientos;
import java.io.IOException;
import java.util.Date;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Caterin
 */
@WebServlet(name = "Controlador", urlPatterns = {"/controlador.do"})
public class Controlador extends HttpServlet {

    @EJB
    ServicioLocal servicio;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String bt = request.getParameter("bt");
        switch (bt) {
            case "iniciarSesion":
                iniciarSesion(request, response);
                break;
            case "crearCliente":
                crearCliente(request, response);
                break;
            case "consultarCliente":
                consultarCliente(request, response);
                break;
            case "depositarMonto":
                depositarMonto(request, response);
                break;
            case "aumentarLineaCredito":
                aumentarLineaCredito(request, response);
                break;
            case "crearCuenta":
                crearCuenta(request, response);
                break;
            case "enviarMensaje":
                enviarMensaje(request, response);
                break;
            case "responderMensaje":
                responderMensaje(request, response);
                break;
            case "transferirMonto":
                transferir(request, response);
                break;
            case "pagarLineaCredito":
                pagarLineaCredito(request, response);
                break;
        }
    }

    protected void pagarLineaCredito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int cta = Integer.parseInt(request.getParameter("ctaOrigen"));
            int monto = Integer.parseInt(request.getParameter("monto"));
            Cuenta c = servicio.buscarCuenta(cta);

            if (monto > 0) {
                if (c.getSaldo() >= monto) {
                    servicio.pagarLineaCredito(c, monto);
                    request.setAttribute("msg", "Cuenta pagada con exito");
                    request.getRequestDispatcher("pagarLineaCredito.jsp").forward(request, response);
                } else {
                    request.setAttribute("msg", "No existe saldo sucifiente para cancelar la deuda");
                    request.getRequestDispatcher("pagarLineaCredito.jsp").forward(request, response);
                }

            } else {
                request.setAttribute("msg", "Debe ingresar un monto positivo");
                request.getRequestDispatcher("pagarLineaCredito.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("msg", "Debe ingresar solo numeros");
            request.getRequestDispatcher("pagarLineaCredito.jsp").forward(request, response);
        }
    }

    protected void transferir(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String claveTranferenciaFORM = request.getParameter("clave");
            int origen = Integer.parseInt(request.getParameter("ctaOrigen"));
            int destino = Integer.parseInt(request.getParameter("ctaDestinatario"));
            int monto = Integer.parseInt(request.getParameter("monto"));
            Cuenta ctaOrigen = servicio.buscarCuenta(origen);
            Cuenta ctaDestino = servicio.buscarCuenta(destino);

            if (ctaOrigen.getClavetransaccion().equalsIgnoreCase(claveTranferenciaFORM)) {
                if (ctaDestino != null) {
                    if (monto > 0) {
                        if (ctaOrigen.getSaldo() >= monto) {
                            servicio.transferirDesdeSaldo(ctaOrigen, ctaDestino, monto);
                            request.setAttribute("msg", "Se ha transferido el monto solicitado desde el saldo disponible");
                            request.getRequestDispatcher("transferirMonto.jsp").forward(request, response);
                        } else {
                            if (ctaOrigen.getSaldo() > 0 && (ctaOrigen.getSaldo() + ctaOrigen.getSaldolineacredito()) >= monto) {
                                servicio.transferirDesdeSaldoyCredito(ctaOrigen, ctaDestino, monto);
                                request.setAttribute("msg", "Se ha tranferido dinero de su saldo y linea de credito");
                                request.getRequestDispatcher("transferirMonto.jsp").forward(request, response);
                            } else {
                                if (ctaOrigen.getSaldolineacredito() >= monto) {
                                    servicio.transferirDesdeLineaCredito(ctaOrigen, ctaDestino, monto);
                                    request.setAttribute("msg", "Se ha tranferido desde su linea de credito");
                                    request.getRequestDispatcher("transferirMonto.jsp").forward(request, response);
                                } else {
                                    request.setAttribute("msg", "No tiene dinero suficiente para realizar la transferencia.");
                                    request.getRequestDispatcher("transferirMonto.jsp").forward(request, response);
                                }
                            }
                        }
                    } else {
                        request.setAttribute("msg", "El monto debe ser superior a $0");
                        request.getRequestDispatcher("transferirMonto.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("msg", "Cuenta de destinatario no existe");
                    request.getRequestDispatcher("transferirMonto.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "La clave de transferencia es incorrecta");
                request.getRequestDispatcher("transferirMonto.jsp").forward(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("msg", "Debe ingresar solo numeros");
            request.getRequestDispatcher("transferirMonto.jsp").forward(request, response);
        }
    }

    protected void responderMensaje(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String respuesta = request.getParameter("respuesta");
        String IdMensaje = request.getParameter("idmensaje");
        int id = Integer.parseInt(IdMensaje);
        servicio.actualizarRespuesta(respuesta, id);
        request.setAttribute("msg", "Mensaje enviado");
        request.getRequestDispatcher("responder.jsp").forward(request, response);
    }

    protected void enviarMensaje(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String asunto = request.getParameter("asunto");
        String contenido = request.getParameter("contenido");
        Cliente cliente = (Cliente) request.getSession().getAttribute("cliente");
        servicio.enviarMensaje(asunto, contenido, cliente);
        request.setAttribute("msg", "Mensaje enviado");
        request.getRequestDispatcher("enviarMensaje.jsp").forward(request, response);
    }

    protected void crearCuenta(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            String numerocta = request.getParameter("numerocta");
            String saldo = request.getParameter("saldoLineaCredito");
            String rutCliente = request.getParameter("cliente");
            String contrasena = request.getParameter("contrasena");
            String contrasena2 = request.getParameter("contrasena2");

            int cta = Integer.parseInt(numerocta);
            int saldoLineaCredito = Integer.parseInt(saldo);

            Cliente cliente = servicio.buscarCliente(rutCliente);
            if (cliente != null) {
                if (contrasena.equals(contrasena2)) {
                    if (numerocta.length() == 6) {
                        Cuenta c = servicio.buscarCuenta(cta);
                        if (c == null) {
                            servicio.crearCuenta(cta, contrasena2, saldoLineaCredito, rutCliente);
                            request.setAttribute("msg", "Cuenta creada con exito");
                            request.getRequestDispatcher("crearCuenta.jsp").forward(request, response);
                        } else {
                            request.setAttribute("msg", "Cuenta ya existe");
                            request.getRequestDispatcher("crearCuenta.jsp").forward(request, response);
                        }
                    } else {
                        request.setAttribute("msg", "El numero de cuenta debe tener un largo de 6 dígitos");
                        request.getRequestDispatcher("crearCuenta.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("msg", "Las contraseñas no coindicen");
                    request.getRequestDispatcher("crearCuenta.jsp").forward(request, response);
                }
            } else {
                request.setAttribute("msg", "Cliente no existe");
                request.getRequestDispatcher("crearCuenta.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("msg", "numero de cuenta y saldo deben ser numericos");
            request.getRequestDispatcher("crearCuenta.jsp").forward(request, response);
        }
    }

    protected void aumentarLineaCredito(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cta = request.getParameter("cta");
        String montos = request.getParameter("monto");
        try {
            int numerocta = Integer.parseInt(cta);
            int monto = Integer.parseInt(montos);
            boolean exito = false;
            String mensaje = "";
            if (monto > 0) {
                Cuenta c = servicio.aumentarLineaCredito(numerocta, monto);
                if (c != null) {
                    mensaje = "aumento en linea de credito por: $" + monto;
                    servicio.registrarMovimiento(c, mensaje);
                    request.setAttribute("msg", "Aumento realizado con exito al cliente: " + c.getClienteFK().getNombre() + " " + c.getClienteFK().getApellido());
                    request.getRequestDispatcher("aumentarLineaCredito.jsp").forward(request, response);
                } else {
                    request.setAttribute("msg", "Numero de cuenta no existe");
                    request.getRequestDispatcher("aumentarLineaCredito.jsp").forward(request, response);
                }
            }
        } catch (Exception e) {
            request.setAttribute("msg", "Solo debe ingresar numeros.");
            request.getRequestDispatcher("aumentarLineaCredito.jsp").forward(request, response);
        }
    }

    protected void depositarMonto(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String cta = request.getParameter("cta");
        String montos = request.getParameter("monto");
        try {
            int numerocta = Integer.parseInt(cta);
            int monto = Integer.parseInt(montos);
            Cuenta c = servicio.depositarMonto(numerocta, monto);
            if (c != null) {
                servicio.registrarMovimiento(c, "Deposito: $" + monto);
                request.setAttribute("msg", "Deposito realizado con exito al cliente: " + c.getClienteFK().getNombre() + " " + c.getClienteFK().getApellido());
                request.getRequestDispatcher("depositarMonto.jsp").forward(request, response);
            } else {
                request.setAttribute("msg", "Numero de cuenta no existe");
                request.getRequestDispatcher("depositarMonto.jsp").forward(request, response);
            }
        } catch (Exception e) {
            request.setAttribute("msg", "Solo debe ingresar numeros.");
            request.getRequestDispatcher("depositarMonto.jsp").forward(request, response);
        }

    }

    protected void consultarCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rutCliente = request.getParameter("rutCliente");

        Cliente c = servicio.buscarCliente(rutCliente);

        if (c != null) {
            request.setAttribute("consultarCliente", c);
            request.getRequestDispatcher("consultarCliente.jsp").forward(request, response);
        } else {
            request.setAttribute("msg", "Cliente no se encuentra");
            request.getRequestDispatcher("consultarCliente.jsp").forward(request, response);
        }
    }

    protected void crearCliente(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String rutEje = request.getParameter("rutEje");
        String rut = request.getParameter("rut");
        String nombre = request.getParameter("nombre");
        String apellido = request.getParameter("apellido");
        String contraseña = request.getParameter("contrasena");
        String contraseña2 = request.getParameter("contrasena2");

        Cliente cliente = servicio.buscarCliente(rut);

        if (cliente == null) {
            if (!contraseña.equals(contraseña2)) {
                request.setAttribute("msg", "Las contraseñas no coinciden");
                request.getRequestDispatcher("crearCliente.jsp").forward(request, response);
            } else {
                servicio.crearCliente(rut, nombre, apellido, Hash.md5(contraseña), rutEje);
                request.getSession().setAttribute("msg", "Cliente agregado con exito");
                response.sendRedirect("crearCliente.jsp");
            }
        } else {
            request.setAttribute("msg", "Cliente ya existe");
            request.getRequestDispatcher("crearCliente.jsp").forward(request, response);
        }
    }

    protected void iniciarSesion(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String usuario = request.getParameter("usuario");
        String contraseña = request.getParameter("contrasena");
        String tipo = request.getParameter("tipo");

        if (tipo.isEmpty()) {
            request.setAttribute("msg", "Debe seleccionar el tipo de usuario");
            request.getRequestDispatcher("index.jsp").forward(request, response);
        } else {
            if (tipo.equals("cliente")) {
                Cliente cliente = servicio.buscarCliente(usuario);
                if (cliente != null) {
                    if (cliente.getClave().equalsIgnoreCase(Hash.md5(contraseña))) {
                        request.getSession().setAttribute("cliente", cliente);
                        response.sendRedirect("consultarSaldo.jsp");
                    } else {
                        request.setAttribute("msg", "La contraseña es invalida");
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("msg", "Cliente invalido.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            } else {
                Ejecutivo ejecutivo = servicio.buscarEjecutivo(usuario);
                if (ejecutivo != null) {
                    if (ejecutivo.getClave().equalsIgnoreCase(contraseña)) {
                        request.getSession().setAttribute("ejecutivo", ejecutivo);
                        response.sendRedirect("crearCliente.jsp");
                    } else {
                        request.setAttribute("msg", "La contraseña es invalida");
                        request.getRequestDispatcher("index.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("msg", "Ejecutivo invalido.");
                    request.getRequestDispatcher("index.jsp").forward(request, response);
                }
            }
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
