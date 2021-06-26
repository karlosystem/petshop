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
    public class ProductsController : Controller
    {
        dbOnlineStoreModel db = new dbOnlineStoreModel();

        public ActionResult Index()
        {
            var query = db.vw_getallproducts.ToList();
            return View(query);
        }

        public ActionResult Create()
        {
            List<tblCategories> list = db.tblCategories.ToList();
            ViewBag.CatList = new SelectList(list, "CatID", "Name");

            List<tblProveedor> list2 = db.tblProveedor.ToList();
            ViewBag.ProvList = new SelectList(list2, "idProv", "nomProv");

            return View();
        }


        public ActionResult Edit(int id)
        {

            List<tblCategories> list = db.tblCategories.ToList();
            ViewBag.CatList = new SelectList(list, "CatID", "Name");

            List<tblProveedor> list2 = db.tblProveedor.ToList();
            ViewBag.ProvList = new SelectList(list2, "idProv", "nomProv");

            var query = db.tblProducts.SingleOrDefault(m => m.ProID == id);

            return View(query);
        }


        [HttpPost]
        public ActionResult Edit(tblProducts p, HttpPostedFileBase Image)
        {
            List<tblCategories> list = db.tblCategories.ToList();
            ViewBag.CatList = new SelectList(list, "CatID", "Name");

            List<tblProveedor> list2 = db.tblProveedor.ToList();
            ViewBag.ProvList = new SelectList(list2, "idProv", "nomProv");

            try
            {

                //p.Image = Image.FileName.ToString();
                //p.Image = Image.FileName.ToString(); //in the ProductsController
                //var folder = Server.MapPath("~/Uploads/");
                //Image.SaveAs(Path.Combine(folder, Image.FileName.ToString()));
                db.Entry(p).State = EntityState.Modified;
                db.SaveChanges();

            }
            catch (Exception ex)
            {
                TempData["msg"] = ex;
            }

            return RedirectToAction("Index");

        }

        public ActionResult Delete(int id)
        {
            var query = db.tblProducts.SingleOrDefault(m => m.ProID == id);
            db.tblProducts.Remove(query);

            db.SaveChanges();


            return RedirectToAction("Index");

        }

        [HttpPost]
        public ActionResult Create(tblProducts p, HttpPostedFileBase Image)
        {
            List<tblCategories> list = db.tblCategories.ToList();
            ViewBag.CatList = new SelectList(list, "CatID", "Name");

            List<tblProveedor> list2 = db.tblProveedor.ToList();
            ViewBag.ProvList = new SelectList(list2, "idProv", "nomProv");

            if (ModelState.IsValid)
            {
                tblProducts pro = new tblProducts();
                pro.Name = p.Name;
                pro.Description = p.Description;
                pro.DescriptionHTML = p.DescriptionHTML;
                pro.Unit = p.Unit;
                pro.Stock = p.Stock;
                pro.Serie = p.Serie;
                pro.Marca = p.Marca;
                pro.Image = Image.FileName.ToString();
                pro.CatID = p.CatID;
                pro.idProv = p.idProv;
                pro.estado = 1;
                pro.FechaRegistro = System.DateTime.Now;

                //image upload
                var folder = Server.MapPath("~/Uploads/");
                Image.SaveAs(Path.Combine(folder, Image.FileName.ToString()));

                db.tblProducts.Add(pro);
                db.SaveChanges();

                return RedirectToAction("Index");
            }
            else
            {
                TempData["msg"] = "Product Not Upload";
            }
            return View();
        }

    }
}