/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package cl.pojos;

import java.io.Serializable;
import java.util.List;
import javax.persistence.Basic;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author Caterin
 */
@Entity
@Table(name = "ejecutivo")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "Ejecutivo.findAll", query = "SELECT e FROM Ejecutivo e")
    , @NamedQuery(name = "Ejecutivo.findByRut", query = "SELECT e FROM Ejecutivo e WHERE e.rut = :rut")
    , @NamedQuery(name = "Ejecutivo.findByNombre", query = "SELECT e FROM Ejecutivo e WHERE e.nombre = :nombre")
    , @NamedQuery(name = "Ejecutivo.findByApellido", query = "SELECT e FROM Ejecutivo e WHERE e.apellido = :apellido")
    , @NamedQuery(name = "Ejecutivo.findByClave", query = "SELECT e FROM Ejecutivo e WHERE e.clave = :clave")})
public class Ejecutivo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @Basic(optional = false)
    @NotNull
    @Size(min = 1, max = 20)
    @Column(name = "rut")
    private String rut;
    @Size(max = 20)
    @Column(name = "nombre")
    private String nombre;
    @Size(max = 20)
    @Column(name = "apellido")
    private String apellido;
    @Size(max = 100)
    @Column(name = "clave")
    private String clave;
    @OneToMany(mappedBy = "ejecutivoFK")
    private List<Cliente> clienteList;
    @OneToMany(mappedBy = "ejecutivoFK")
    private List<Mensaje> mensajeList;

    public Ejecutivo() {
    }

    public Ejecutivo(String rut) {
        this.rut = rut;
    }

    public String getRut() {
        return rut;
    }

    public void setRut(String rut) {
        this.rut = rut;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellido() {
        return apellido;
    }

    public void setApellido(String apellido) {
        this.apellido = apellido;
    }

    public String getClave() {
        return clave;
    }

    public void setClave(String clave) {
        this.clave = clave;
    }

    @XmlTransient
    public List<Cliente> getClienteList() {
        return clienteList;
    }

    public void setClienteList(List<Cliente> clienteList) {
        this.clienteList = clienteList;
    }

    @XmlTransient
    public List<Mensaje> getMensajeList() {
        return mensajeList;
    }

    public void setMensajeList(List<Mensaje> mensajeList) {
        this.mensajeList = mensajeList;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (rut != null ? rut.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof Ejecutivo)) {
            return false;
        }
        Ejecutivo other = (Ejecutivo) object;
        if ((this.rut == null && other.rut != null) || (this.rut != null && !this.rut.equals(other.rut))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "cl.pojos.Ejecutivo[ rut=" + rut + " ]";
    }
    
}
