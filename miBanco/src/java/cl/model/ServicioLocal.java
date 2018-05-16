/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cl.model;

import javax.ejb.Local;
import cl.pojos.*;
import java.util.List;
/**
 *
 * @author Caterin
 */
@Local
public interface ServicioLocal {
    
    void insertar(Object o);
    
    Ejecutivo buscarEjecutivo(String rut);
    List<Ejecutivo> getEjecutivos();
    
    Mensaje buscarMensaje(int idMensaje);
    List<Mensaje> getMensajes();
    
    Cliente buscarCliente(String rut);
    List<Cliente> getCliente();
    
    Cuenta buscarCuenta(int numerocta);
    List<Cuenta> getCuentas();
    
    Movimientos buscarMovimiento(int idMovimiento);
    List<Movimientos> getMovimientos();
    
    void sincronizar(Object o);
    
    Cuenta depositarMonto(int numerocta, int monto);
    Cuenta aumentarLineaCredito(int numerocta, int monto);
    void registrarMovimiento(Cuenta cta, String descripcion);
    
    void enviarMensaje(String asunto, String contenido, Cliente c);
    void actualizarRespuesta(String respuesta, int idmensaje);
    
    void transferirDesdeSaldo(Cuenta ctaOrigen, Cuenta ctaDestino, int monto);
    void transferirDesdeLineaCredito(Cuenta ctaOrigen, Cuenta ctaDestino, int monto);
    void transferirDesdeSaldoyCredito(Cuenta ctaOrigen, Cuenta ctaDestino, int monto);
    
    void pagarLineaCredito(Cuenta cta, int monto);
    
    void crearCuenta(int cta, String contraseña, int saldoLineaCredito, String rut);
    
    void crearCliente(String rut, String nombre, String apellido, String clave, String ejecutivo);
}