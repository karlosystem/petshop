//------------------------------------------------------------------------------
// <auto-generated>
//    Este código se generó a partir de una plantilla.
//
//    Los cambios manuales en este archivo pueden causar un comportamiento inesperado de la aplicación.
//    Los cambios manuales en este archivo se sobrescribirán si se regenera el código.
// </auto-generated>
//------------------------------------------------------------------------------

namespace PetShopPedido.Models
{
    using System;
    using System.Collections.Generic;
    
    public partial class vw_ListaFacturas
    {
        public int idFactura { get; set; }
        public string numero { get; set; }
        public string Cliente { get; set; }
        public Nullable<System.DateTime> createDate { get; set; }
        public string nomTipoPago { get; set; }
        public Nullable<int> estado { get; set; }
        public Nullable<decimal> FinalTotal { get; set; }
    }
}
