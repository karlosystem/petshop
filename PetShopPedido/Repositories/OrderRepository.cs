using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using PetShopPedido.Models;
using System.Data.Entity;
using PetShopPedido.ViewModel;

namespace PetShopPedido.Repositories
{
    public class OrderRepository
    {
        private dbOnlineStoreModel objFacturaDbEntities;

        public OrderRepository()
        {
            objFacturaDbEntities = new dbOnlineStoreModel();
        }


        public bool AgregarFactura(OrderViewModel objOrderViewModel)
        {
            tblFactura objFactura = new tblFactura();
            objFactura.idUser = objOrderViewModel.idUser;
            objFactura.FinalTotal = objOrderViewModel.FinalTotal;
            objFactura.createDate = DateTime.Now;
            objFactura.estado = 1;
            objFactura.numero = String.Format("{0:ddmmmyyyyhhmmss}", DateTime.Now);
            objFactura.idTipoPago = objOrderViewModel.idTipoPago;
            objFacturaDbEntities.tblFactura.Add(objFactura);
            objFacturaDbEntities.SaveChanges();
            int FacturaId = objFactura.idFactura;

            foreach (var item in objOrderViewModel.ListOfOrderDetailViewModel)
            {
                tblFacturaDetalles objOrderDetail = new tblFacturaDetalles();
                objOrderDetail.idFactura = FacturaId;
                objOrderDetail.Discount = item.Discount;
                objOrderDetail.ItemId = item.ItemId;
                objOrderDetail.Total = item.Total;
                objOrderDetail.UnitPrice = item.UnitPrice;
                objOrderDetail.Quantity = item.Quantity;
                objOrderDetail.estado = 1;
                objFacturaDbEntities.tblFacturaDetalles.Add(objOrderDetail);
                objFacturaDbEntities.SaveChanges();

                tblTransaccion objTransaccion = new tblTransaccion();
                objTransaccion.ItemId = item.ItemId;
                objTransaccion.Quantity = (-1) * item.Quantity;
                objTransaccion.createDate = DateTime.Now;
                objTransaccion.Type = 2;
                objFacturaDbEntities.tblTransaccion.Add(objTransaccion);
                objFacturaDbEntities.SaveChanges();
            }
            return true;
        }


    }
}