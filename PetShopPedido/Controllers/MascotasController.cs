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
    public class MascotasController : Controller
    {
        dbOnlineStoreModel db = new dbOnlineStoreModel();

        public ActionResult Index()
        {
            var query = db.vw_listaMascotas.ToList();
            return View(query);
        }

        public ActionResult Create()
        {
            List<tblRaza> list = db.tblRaza.ToList();
            ViewBag.RazaList = new SelectList(list, "idRaza", "nomRaza");

            List<tblUser> list2 = db.tblUser.ToList();
            ViewBag.UserList = new SelectList(list2, "UserId", "Name");

            return View();
        }


        [HttpPost]
        public ActionResult Create(tblMascota p)
        {
            List<tblRaza> list = db.tblRaza.ToList();
            ViewBag.RazaList = new SelectList(list, "idRaza", "nomRaza");

            List<tblUser> list2 = db.tblUser.ToList();
            ViewBag.UserList = new SelectList(list2, "UserId", "Name");

            if (ModelState.IsValid)
            {
                tblMascota masc = new tblMascota();
                masc.nomMasc = p.nomMasc;
                masc.estado = 1;
                masc.idRaza = p.idRaza;
                masc.idUser = p.idUser;
                masc.createDate = System.DateTime.Now;              
                db.tblMascota.Add(masc);
                db.SaveChanges();

                return RedirectToAction("Index");
            }
            else
            {
                TempData["msg"] = "No se puede grabar la Mascota";
            }
            return View();
        }


    }
}