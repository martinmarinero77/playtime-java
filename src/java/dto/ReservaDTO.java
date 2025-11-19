package dto;

import entidades.Reserva;
import java.io.Serializable;

public class ReservaDTO implements Serializable {

    private Reserva reserva;
    private long jugadoresAceptados;

    public ReservaDTO() {
    }

    public Reserva getReserva() {
        return reserva;
    }

    public void setReserva(Reserva reserva) {
        this.reserva = reserva;
    }

    public long getJugadoresAceptados() {
        return jugadoresAceptados;
    }

    public void setJugadoresAceptados(long jugadoresAceptados) {
        this.jugadoresAceptados = jugadoresAceptados;
    }
}
