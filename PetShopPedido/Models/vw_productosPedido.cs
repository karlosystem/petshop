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
    
    public partial class vw_productosPedido
    {
        public int OrderId { get; set; }
        public Nullable<int> InvoiceId { get; set; }
        public string Producto { get; set; }
        public Nullable<int> Unit { get; set; }
        public Nullable<int> Qty { get; set; }
        public Nullable<int> Total { get; set; }
    }
}
