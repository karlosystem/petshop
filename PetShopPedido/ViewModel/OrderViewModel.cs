using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace PetShopPedido.ViewModel
{
    public class OrderViewModel
    {
        public int idFactura { get; set; }
        public string numero { get; set; }
        public Nullable<System.DateTime> createDate { get; set; }
        public Nullable<int> idUser { get; set; }
        public Nullable<int> idTipoPago { get; set; }
        public Nullable<int> estado { get; set; }
        public Nullable<decimal> FinalTotal { get; set; }

        public IEnumerable <OrderDetailViewModel> ListOfOrderDetailViewModel{ get; set; }
    }
}