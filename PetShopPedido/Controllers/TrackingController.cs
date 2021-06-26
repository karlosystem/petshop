using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using PetShopPedido.Models;

namespace PetShopPedido.Controllers
{
    public class TrackingController : Controller
    {
        dbOnlineStoreModel db = new dbOnlineStoreModel();

        // GET: Tracking
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Create()
        {
            List<tblEstados> list = db.tblEstados.ToList();
            ViewBag.EstList = new SelectList(list, "id", "nombre");

            List<vw_comboPedidos> list2 = db.vw_comboPedidos.ToList();
            ViewBag.PedList = new SelectList(list2, "InvoiceId", "pedido");
            

            return View();
        }


        [HttpPost]
        public ActionResult Create(tblTracking p)
        {
            List<tblEstados> list = db.tblEstados.ToList();
            ViewBag.EstList = new SelectList(list, "id", "nombre");

            List<vw_comboPedidos> list2 = db.vw_comboPedidos.ToList();
            ViewBag.PedList = new SelectList(list2, "InvoiceId", "pedido");

            if (ModelState.IsValid)
            {
                tblTracking pro = new tblTracking();
                pro.nombre = p.nombre;
                pro.observacion = p.observacion;
                pro.IdEstado = p.IdEstado;
                pro.InvoiceId = p.InvoiceId;
                pro.Created_On = System.DateTime.Now;
                pro.activo = 1;
                db.tblTracking.Add(pro);
                db.SaveChanges();
                @ViewBag.Message = "Registro Grabado con Exito";
            }
            else
            {
                TempData["msg"] = "Error al grabar los datos";
            }
            return View();
        }

    }
}