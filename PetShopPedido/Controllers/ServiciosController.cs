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
    public class ServiciosController : Controller
    {
        dbOnlineStoreModel db = new dbOnlineStoreModel();
        
        public ActionResult Index()
        {
            var query = db.tblServicio.ToList();
            return View(query);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(tblServicio c)
        {
            if (ModelState.IsValid)
            {
                tblServicio serv = new tblServicio();
                serv.nomServ = c.nomServ;
                serv.precServ = c.precServ;
                serv.desServ = c.desServ;
                serv.horarioServ = c.horarioServ;
                serv.fecServ = c.fecServ;
                serv.enabled = 1;
                serv.createDate = System.DateTime.Now;

                db.tblServicio.Add(serv);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            else
            {
                TempData["msg"] = "Error al Ingresar el Servicio";
            }
            return View();
        }

        public ActionResult Edit(int id)
        {
            var query = db.tblServicio.SingleOrDefault(m => m.idServ == id);
            return View(query);
        }


        [HttpPost]
        public ActionResult Edit(tblServicio c)
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
            var query = db.tblServicio.SingleOrDefault(m => m.idServ == id);
            db.tblServicio.Remove(query);
            db.SaveChanges();
            return RedirectToAction("Index");
        }


    }
}