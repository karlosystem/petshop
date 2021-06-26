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
    public class ItemRepository
    {

        private dbOnlineStoreModel objFacturaDbEntities;

        public ItemRepository()
        {
            objFacturaDbEntities = new dbOnlineStoreModel();
        }

        public IEnumerable<SelectListItem> GetAllItems()
        {
            var objSelectListItems = new List<SelectListItem>();
            objSelectListItems = (from obj in objFacturaDbEntities.tblProducts
                                  select new SelectListItem()
                                  {
                                      Text = obj.Name,
                                      Value = obj.ProID.ToString(),
                                      Selected = true
                                  }).ToList();
            return objSelectListItems;
        }

    }
}