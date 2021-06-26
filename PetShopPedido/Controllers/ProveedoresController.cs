using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PetShopPedido.Models;
using System.IO;
using System.Data;
using System.Data.Entity;

namespace PetShopPedido.Controllers
{
    public class ProveedoresController : Controller
    {
        dbOnlineStoreModel db = new dbOnlineStoreModel();
        
        public ActionResult Index()
        {
            var query = db.tblProveedor.ToList();
            return View(query);
        }


        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(tblProveedor c)
        {
            if (ModelState.IsValid)
            {
                tblProveedor prov = new tblProveedor();
                prov.nomProv = c.nomProv;
                prov.RUC = c.RUC;
                prov.estado = c.estado;
                prov.FechaRegistro = System.DateTime.Now;
                db.tblProveedor.Add(prov);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            else
            {
                TempData["msg"] = "Error al Ingresar el Proveedor";
            }
            return View();
        }


        public ActionResult Edit(int id)
        {
            var query = db.tblProveedor.SingleOrDefault(m => m.idProv == id);
            return View(query);
        }


        [HttpPost]
        public ActionResult Edit(tblProveedor c)
        {
            try
            {

                db.Entry(c).State = EntityState.Modified;
                db.SaveChanges();

                return RedirectToAction("Index");
            }
            catch (Exception ex)
            {
                TempData["msg"] = ex;
            }
            return RedirectToAction("Index");
        }


        public ActionResult Delete(int id)
        {
            var query = db.tblProveedor.SingleOrDefault(m => m.idProv == id);
            db.tblProveedor.Remove(query);
            db.SaveChanges();
            return RedirectToAction("Index");
        }


    }
}