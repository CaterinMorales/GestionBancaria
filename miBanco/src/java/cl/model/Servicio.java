/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cl.model;

import cl.pojos.Cliente;
import cl.pojos.Cuenta;
import cl.pojos.Ejecutivo;
import cl.pojos.Mensaje;
import cl.pojos.Movimientos;
import java.util.Date;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Caterin
 */
@Stateless
public class Servicio implements ServicioLocal {

    @PersistenceContext(unitName = "miBancoPU")
    private EntityManager em;

    @Override
    public void insertar(Object o) {
        em.persist(o);
    }

    @Override
    public Ejecutivo buscarEjecutivo(String rut) {
        return em.find(Ejecutivo.class, rut);
    }

    @Override
    public List<Ejecutivo> getEjecutivos() {
        return em.createQuery("SELECT e FROM Ejecutivo e").getResultList();
    }

    @Override
    public Mensaje buscarMensaje(int idMensaje) {
        return em.find(Mensaje.class, idMensaje);
    }

    @Override
    public List<Mensaje> getMensajes() {
        return em.createQuery("SELECT m FROM Mensaje m").getResultList();
    }

    @Override
    public Cliente buscarCliente(String rut) {
        return em.find(Cliente.class, rut);
    }

    @Override
    public List<Cliente> getCliente() {
        return em.createQuery("SELECT c FROM Cliente c").getResultList();
    }

    @Override
    public Cuenta buscarCuenta(int numerocta) {
        return em.find(Cuenta.class, numerocta);
    }

    @Override
    public List<Cuenta> getCuentas() {
        return em.createQuery("SELECT c FROM Cuenta c").getResultList();
    }

    @Override
    public Movimientos buscarMovimiento(int idMovimiento) {
        return em.find(Movimientos.class, idMovimiento);
    }

    @Override
    public List<Movimientos> getMovimientos() {
        return em.createQuery("SELECT m FROM Movimientos m").getResultList();
    }

    @Override
    public void sincronizar(Object o) {
        em.merge(o);
        em.flush();
    }

    @Override
    public Cuenta depositarMonto(int numerocta, int monto) {
        Cuenta c = buscarCuenta(numerocta);
        c.setSaldo(c.getSaldo() + monto);
        em.merge(c);
        em.flush();
        em.refresh(c);
        return c;
    }

    @Override
    public Cuenta aumentarLineaCredito(int numerocta, int monto) {
        Cuenta c = buscarCuenta(numerocta);
        c.setSaldolineacredito(c.getSaldolineacredito() + monto);
        em.merge(c);
        em.flush();
        em.refresh(c);
        return c;
    }

    @Override
    public void registrarMovimiento(Cuenta cta, String descripcion) {
        Movimientos mo = new Movimientos();
        mo.setIdmovimiento(getMovimientos().size());
        mo.setFecha(new Date());
        mo.setDescripcion(descripcion);
        mo.setCuentaFK(cta);
        insertar(mo);
        getMovimientos().add(mo);
        sincronizar(mo);
        em.refresh(mo);
    }

    @Override
    public void enviarMensaje(String asunto, String contenido, Cliente c) {
        Mensaje m = new Mensaje();
        m.setAsunto(asunto);
        m.setContenido(contenido);
        m.setRespuesta("");
        m.setClienteFK(c);
        m.setEjecutivoFK(c.getEjecutivoFK());
        insertar(m);
        getMensajes().add(m);
        sincronizar(m);
        em.refresh(m);
    }

    @Override
    public void actualizarRespuesta(String respuesta, int idmensaje) {
        Mensaje m = buscarMensaje(idmensaje);
        m.setRespuesta(respuesta);
        sincronizar(m);
        em.refresh(m);
    }

    @Override
    public void transferirDesdeSaldo(Cuenta ctaOrigen, Cuenta ctaDestino, int monto) {
        ctaOrigen.setSaldo(ctaOrigen.getSaldo() - monto); //actualizar monto en cuenta de origen
        em.merge(ctaOrigen);
        em.flush();
        String descripcion = "Tranferencia de saldo a: " + ctaDestino.getClienteFK().getNombre() + " " + ctaDestino.getClienteFK().getApellido() + ", por un monto de $" + monto;
        registrarMovimiento(ctaOrigen, descripcion);

        ctaDestino.setSaldo(ctaDestino.getSaldo() + monto); //actualizar cuenta de destino
        em.merge(ctaDestino);
        em.flush();

        String descripcion2 = "Tranferencia por un saldo de $" + monto + " desde la cuenta de : "
                + ctaOrigen.getClienteFK().getNombre() + " " + ctaOrigen.getClienteFK().getApellido();
        registrarMovimiento(ctaDestino, descripcion2);
    }

    @Override
    public void transferirDesdeLineaCredito(Cuenta ctaOrigen, Cuenta ctaDestino, int monto) {
        ctaOrigen.setSaldolineacredito(ctaOrigen.getSaldolineacredito() - monto);
        ctaOrigen.setSaldolineacreditousado(ctaOrigen.getSaldolineacreditousado() + monto);
        em.merge(ctaOrigen);
        em.flush();
        String descripcion = "Tranferencia de saldo a: " + ctaDestino.getClienteFK().getNombre() + " " + ctaDestino.getClienteFK().getApellido() + ", por un monto de $" + monto;
        registrarMovimiento(ctaOrigen, descripcion);

        ctaDestino.setSaldo(ctaDestino.getSaldo() + monto); //actualizar cuenta de destino
        em.merge(ctaDestino);
        em.flush();

        String descripcion2 = "Tranferencia por un saldo de $" + monto + " desde la cuenta de : "
                + ctaOrigen.getClienteFK().getNombre() + " " + ctaOrigen.getClienteFK().getApellido();
        registrarMovimiento(ctaDestino, descripcion2);
    }

    @Override
    public void transferirDesdeSaldoyCredito(Cuenta ctaOrigen, Cuenta ctaDestino, int monto) {
        int faltante = monto - ctaOrigen.getSaldo();
        ctaOrigen.setSaldo(0);
        ctaOrigen.setSaldolineacredito(ctaOrigen.getSaldolineacredito() - faltante);
        ctaOrigen.setSaldolineacreditousado(ctaOrigen.getSaldolineacreditousado() + faltante);
        em.merge(ctaOrigen);
        em.flush();
        String descripcion = "Tranferencia de saldo a: " + ctaDestino.getClienteFK().getNombre() + " " + ctaDestino.getClienteFK().getApellido() + ", por un monto de $" + monto;
        registrarMovimiento(ctaOrigen, descripcion);

        ctaDestino.setSaldo(ctaDestino.getSaldo() + monto); //actualizar cuenta de destino
        em.merge(ctaDestino);
        em.flush();

        String descripcion2 = "Tranferencia por un saldo de $" + monto + " desde la cuenta de : "
                + ctaOrigen.getClienteFK().getNombre() + " " + ctaOrigen.getClienteFK().getApellido();
        registrarMovimiento(ctaDestino, descripcion2);
    }

    @Override
    public void pagarLineaCredito(Cuenta cta, int monto) {
        String descripcion = "";
        if (cta.getSaldolineacreditousado() <= monto) {
            descripcion = "Linea de credito pagada por un monto de: $" + cta.getSaldolineacreditousado() + ". Deuda actual: $0";
            cta.setSaldolineacredito(cta.getSaldolineacredito() + cta.getSaldolineacreditousado());
            cta.setSaldolineacreditousado(0);
        } else {
            cta.setSaldolineacreditousado(cta.getSaldolineacreditousado() - monto);
            cta.setSaldolineacredito(cta.getSaldolineacredito() + monto);
        }
        cta.setSaldo(cta.getSaldo()-monto);
        em.merge(cta);
        em.flush();

        if (cta.getSaldolineacreditousado() == 0) {
            registrarMovimiento(cta, descripcion);
        } else {
            registrarMovimiento(cta, "Abono a linea de credito por: $" + monto + ". Deuda actual: $" + cta.getSaldolineacreditousado());
        }
    }

    @Override
    public void crearCuenta(int cta, String contraseña, int saldoLineaCredito, String rut) {
        Cliente c = buscarCliente(rut);
        Cuenta nueva = new Cuenta();
        nueva.setNumerocta(cta);
        nueva.setSaldo(0);
        nueva.setClavetransaccion(contraseña);
        nueva.setSaldolineacredito(saldoLineaCredito);
        nueva.setSaldolineacreditousado(0);
        nueva.setEstado(1);
        nueva.setClienteFK(c);
        insertar(nueva);
        getCuentas().add(nueva);
        sincronizar(nueva);
    }

    @Override
    public void crearCliente(String rut, String nombre, String apellido, String clave, String ejecutivo) {
        Cliente c = new Cliente();
        Ejecutivo eje = buscarEjecutivo(ejecutivo);
        c.setRut(rut);
        c.setNombre(nombre);
        c.setApellido(apellido);
        c.setClave(clave);
        c.setEjecutivoFK(eje);
        insertar(c);
        eje.getClienteList().add(c);
        sincronizar(eje);
    }

}
