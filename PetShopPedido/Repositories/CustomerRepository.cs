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
    public class CustomerRepository
    {
        private dbOnlineStoreModel objFacturaDbEntities;

        public CustomerRepository()
        {
            objFacturaDbEntities = new dbOnlineStoreModel();
        }

        public IEnumerable<SelectListItem> GetAllCustomers()
        {
            var objSelectListItems = new List<SelectListItem>();
            objSelectListItems = (from obj in objFacturaDbEntities.tblUser
                                  select new SelectListItem()
                                  {
                                      Text = obj.Name,
                                      Value = obj.UserId.ToString(),
                                      Selected = false
                                  }).ToList();
            return objSelectListItems;
        }
    }
}