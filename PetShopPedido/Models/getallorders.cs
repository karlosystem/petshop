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
    
    public partial class getallorders
    {
        public int InvoiceId { get; set; }
        public int UserId { get; set; }
        public string user { get; set; }
        public Nullable<int> Bill { get; set; }
        public string Payment { get; set; }
        public Nullable<System.DateTime> InvoiceDate { get; set; }
        public string Status { get; set; }
    }
}
