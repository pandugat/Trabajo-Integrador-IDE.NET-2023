﻿using Entidad.Models;
using System;
using System.Collections;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace WindowsForm
{
    public partial class DatosReserva : Form
    {
        Reserva? _rsv;
        Habitacion? _hbt;
        Huesped? _hpd;
        List<Habitacion> _lstHbt = Negocio.Habitacion.GetAll();
        List<Huesped> _lstHpd = Negocio.Huesped.GetAll();
        List<Reserva> _lstRsv = Negocio.Reserva.GetAll();
        Hashtable _hashHbt = new Hashtable();
        Hashtable _hashHpd = new Hashtable();
        Hashtable _hashRsv = new Hashtable();

        public DatosReserva()
        {
            InitializeComponent();
        }
        //Probar si es viable (*/ω\*)
        public DatosReserva(Habitacion hbt)
        {
            _hbt = hbt;
            InitializeComponent();
        }

        public DatosReserva(Huesped hpd)
        {
            _hpd = hpd;
            InitializeComponent();
        }

        public DatosReserva(Reserva rsv)
        {
            _rsv = rsv;
            InitializeComponent();
        }

#warning Faltan validaciones, ademas de filtrar las habitaciones por fecha de reserva

        public DatosReserva(int id)
        {
            try
            {
                _rsv = Negocio.Reserva.GetOne(id)!;
            }
            catch (Exception ex)
            {
                MessageBox.Show("¡La reserva no existe!\n" + ex);
                this.Close();
            }
            InitializeComponent();
        }

        private void DatosHabitacion_Load(object sender, EventArgs e)
        {
            if (_lstHbt.Count <= 0)
            {
                MessageBox.Show("¡No hay habitaciones registradas!\nAgrege una habitacion, antes de cargar una reserva", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.Close();
            }
            else if (_lstHpd.Count <= 0)
            {
                MessageBox.Show("¡No hay huespedes registrados!\nAgrege un huesped, antes de cargar una reserva", "Error", MessageBoxButtons.OK, MessageBoxIcon.Information);
                this.Close();
            }

            foreach (Habitacion _tmpHbt in _lstHbt)
            {
                string tmp = _tmpHbt.IdHabitacion + " - Piso: " + _tmpHbt.PisoHabitacion + " Nro: " + _tmpHbt.NumeroHabitacion;
                _hashHbt[tmp] = _tmpHbt;
                //cmbHabitacion.Items.Add(tmp);
            }

            foreach (Huesped _tmpHpd in _lstHpd)
            {
                string tmp = _tmpHpd.NumeroDocumento + " - " + _tmpHpd.Nombre + " " + _tmpHpd.Apellido;
                _hashHpd[tmp] = _tmpHpd;
                cmbHuesped.Items.Add(tmp);
            }

            foreach (Reserva _tmpRsv in _lstRsv)
            {
                string tmp = _tmpRsv.FechaInscripcion.ToString("dd/MM/yyyy") + " - Habitacion " + _tmpRsv.IdHabitacionNavigation.NumeroHabitacion + " piso " + _tmpRsv.IdHabitacionNavigation.PisoHabitacion;
                _hashRsv[tmp] = _tmpRsv;
                cmbIdReserva.Items.Add(tmp);
            }

            if (_rsv != null)
            {
                this.Text = "Editar reserva";
                cmbIdReserva.SelectedItem = _rsv.FechaInscripcion.ToString("dd/MM/yyyy") + " - Habitacion " + _rsv.IdHabitacionNavigation.NumeroHabitacion + " piso " + _rsv.IdHabitacionNavigation.PisoHabitacion;
                cmbIdReserva_SelectionChangeCommitted(sender, e);
            }
            else
            {
                this.Text = "Agregar nueva reserva";
                cmbIdReserva.Items.Add("Nuevo");
                cmbIdReserva.SelectedItem = "Nuevo";
                cmbIdReserva.Enabled = false;
                cmbEstado.SelectedIndex = 0;
                dtFechaFin.Value = dtFechaInicio.Value.AddDays(1);
            }

            if (_hbt != null)
            {
                //cmbHabitacion.SelectedItem = _hbt.IdHabitacion + " - Piso: " + _hbt.PisoHabitacion + " Nro: " + _hbt.NumeroHabitacion;
            }

            if (_hpd != null)
            {
                cmbHuesped.SelectedItem = _hpd.NumeroDocumento + " - " + _hpd.Nombre + " " + _hpd.Apellido;
            }
        }

        private void cmbIdReserva_SelectionChangeCommitted(object sender, EventArgs e)
        {
            _rsv = (Reserva)_hashRsv[cmbIdReserva.SelectedItem]!;
            dtFechaInicio.Value = _rsv.FechaInicioReserva;
            dtFechaFin.Value = _rsv.FechaFinReserva;
            txtCantidadPersonas.Text = _rsv.CantidadPersonas.ToString();
            //cmbHabitacion.SelectedItem = _rsv.IdHabitacionNavigation.IdHabitacion + " - Piso: " + _rsv.IdHabitacionNavigation.PisoHabitacion + " Nro: " + _rsv.IdHabitacionNavigation.NumeroHabitacion;
            cmbHuesped.SelectedItem = _rsv.IdHuespedNavigation.NumeroDocumento + " - " + _rsv.IdHuespedNavigation.Nombre + " " + _rsv.IdHuespedNavigation.Apellido;
            cmbEstado.SelectedItem = _rsv.EstadoReserva;
        }

        private void btnAceptar_Click(object sender, EventArgs e)
        {
            bool stop = false;
            //¿Reserva existente o nueva?
            if (_rsv != null)
            {
                //Se modifica una reserva existente
                asignarValores();
                if (!Negocio.Reserva.Update(_rsv))
                {
                    stop = true;
                    MessageBox.Show("Hubo un error al guardar la reserva");
                }
            }
            else
            {
                //Se crea una nueva reserva
                _rsv = new Reserva();
                _rsv.FechaInscripcion = DateTime.Now.Date;
                _rsv.EstadoReserva = (string)cmbEstado.SelectedItem;
                asignarValores();
                if (!Negocio.Reserva.Create(_rsv))
                {
                    stop = true;
                    MessageBox.Show("Hubo un error al guardar la reserva");
                }
            }

            if (!stop)
            {
                this.Close();
            }
        }

        private void btnCancelar_Click(object sender, EventArgs e)
        {
            this.Close();
        }

        private void asignarValores()
        {
            _rsv!.FechaInicioReserva = dtFechaInicio.Value.Date;
            _rsv.FechaFinReserva = dtFechaFin.Value.Date;
            _rsv.CantidadPersonas = int.Parse(txtCantidadPersonas.Text);
            //_rsv.IdHabitacionNavigation = (Habitacion)_hashHbt[cmbHabitacion.SelectedItem]!;
            _rsv.IdHuespedNavigation = (Huesped)_hashHpd[cmbHuesped.SelectedItem]!;
            _rsv.IdHabitacion = _rsv.IdHabitacionNavigation.IdHabitacion;
            _rsv.IdHuesped = _rsv.IdHuespedNavigation.IdHuesped;
        }

        #region A borrar
        private void label1_Click(object sender, EventArgs e)
        {

        }

        private void label2_Click(object sender, EventArgs e)
        {

        }

        private void comboBox1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        private void label7_Click(object sender, EventArgs e)
        {

        }
        #endregion

        //Esta funcion controla que solo se puedan ingresar numeros enteros en los textBoxs
        private void textBox_KeyPress(object sender, KeyPressEventArgs e)
        {
            if (!char.IsControl(e.KeyChar) && !char.IsDigit(e.KeyChar))
            {
                e.Handled = true;
            }
        }

        private void btnBuscar_Click(object sender, EventArgs e)
        {
            List<Habitacion>? lstHbt = null;
            DateTime start = dtFechaInicio.Value;
            DateTime end = dtFechaFin.Value;

            if (txtCantidadPersonas.Text.Length > 0 && start.CompareTo(end) < 0)
            {
                lstHbt = Negocio.Habitacion.GetForAmountOfPeople(int.Parse(txtCantidadPersonas.Text));
                lstHbt = Negocio.Habitacion.TakeAvailable(lstHbt, start, end);

                if (txtPiso.Text.Length > 0)
                {
                    int piso = int.Parse(txtPiso.Text);
                    if (txtNro.Text.Length > 0)
                    {
                        lstHbt = lstHbt.FindAll(hbt => hbt.PisoHabitacion == piso && hbt.NumeroHabitacion == int.Parse(txtNro.Text));
                    }
                    else
                    {
                        lstHbt = lstHbt.FindAll(hbt => hbt.PisoHabitacion == piso);
                    }
                }
            }

            dtGrHabitacion.DataSource = lstHbt;
        }
    }
}
