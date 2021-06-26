using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using PetShopPedido.Models;
using System.Data.Entity;

namespace PetShopPedido.Repositories
{
    public class PaymentTypeRepository
    {
        private dbOnlineStoreModel objFacturaDbEntities;
       
        public PaymentTypeRepository()
        {
            objFacturaDbEntities = new dbOnlineStoreModel();
        }

        public IEnumerable<SelectListItem> GetAllPaymentType()
        {
            var objSelectListItems = new List<SelectListItem>();
            objSelectListItems = (from obj in objFacturaDbEntities.tblTipoPago
                                  select new SelectListItem()
                                  {
                                      Text = obj.nomTipoPago,
                                      Value = obj.idTipoPago.ToString(),
                                      Selected = true
                                  }).ToList();
            return objSelectListItems;
        }

    }
}