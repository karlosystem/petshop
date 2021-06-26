using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PetShopPedido.Models;
using System.Data;
using System.Data.Entity;

namespace PetShopPedido.Controllers
{
    public class CategoryController : Controller
    {
        dbOnlineStoreModel db = new dbOnlineStoreModel();

        public ActionResult Index()
        {
            var query = db.tblCategories.ToList();

            return View(query);
        }

        public ActionResult Create()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Create(tblCategories c)
        {
            if (ModelState.IsValid)
            {
                tblCategories cat = new tblCategories();
                cat.Name = c.Name;
                db.tblCategories.Add(cat);
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            else
            {
                TempData["msg"] = "Error al Ingresar la Categoria";
            }
            return View();
        }


        public ActionResult Edit(int id)
        {
            var query = db.tblCategories.SingleOrDefault(m => m.CatId == id);
            return View(query);
        }

        [HttpPost]
        public ActionResult Edit(tblCategories c)
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
            var query = db.tblCategories.SingleOrDefault(m => m.CatId == id);
            db.tblCategories.Remove(query);
            db.SaveChanges();
            return RedirectToAction("Index");
        }


    }
}