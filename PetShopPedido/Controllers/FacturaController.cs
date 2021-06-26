using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using PetShopPedido.Models;
using PetShopPedido.Controllers;
using PetShopPedido.Repositories;
using System.Data.Entity;
using PetShopPedido.ViewModel;

namespace PetShopPedido.Controllers
{
    public class FacturaController : Controller
    {
        private dbOnlineStoreModel objFacturaDbEntities;

        public FacturaController()
        {
            objFacturaDbEntities = new dbOnlineStoreModel();
        }

        // GET: Factura
        public ActionResult Index()
        {
            CustomerRepository objCustomerRepository = new CustomerRepository();
            ItemRepository objItemRepository = new ItemRepository();
            PaymentTypeRepository objPaymentTypeRepository = new PaymentTypeRepository();

            var objMultipleModels = new Tuple<IEnumerable<SelectListItem>, IEnumerable<SelectListItem>, IEnumerable<SelectListItem>>
                (objCustomerRepository.GetAllCustomers(), objItemRepository.GetAllItems(), objPaymentTypeRepository.GetAllPaymentType());

            return View(objMultipleModels);
        }

        public ActionResult Listado()
        {
            var query = objFacturaDbEntities.vw_ListaFacturas.ToList();
            return View(query);
        }

        [HttpGet]
        public JsonResult getItemUnitPrice(int ProId)
        {
            int UnitPrice = (int)objFacturaDbEntities.tblProducts.Single(model => model.ProID == ProId).Unit;
            return Json(UnitPrice, JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public JsonResult Index(OrderViewModel objOrderViewModel)
        {
            OrderRepository objOrderRepository = new OrderRepository();
            objOrderRepository.AgregarFactura(objOrderViewModel);
            return Json("Factura Registrada", JsonRequestBehavior.AllowGet);
        }


        public ActionResult FacturaDetallexNumero(int id)
        {
            var query = objFacturaDbEntities.vw_FacturasDetalles.Where(m => m.idFactura == id).ToList();
            return View(query);
        }


    }

   
}
