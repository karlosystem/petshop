using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Security;
using PetShopPedido.Models;
using System.Data.Entity;

namespace PetShopPedido.Controllers
{
    public class AccountController : Controller
    {
        dbOnlineStoreModel db = new dbOnlineStoreModel();

        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(tblUser t)
        {
            tblUser u = new tblUser();
            if (ModelState.IsValid)
            {
                u.Name = t.Name;
                u.apellidos = t.apellidos;
                u.direccion = t.direccion;
                u.telefono = t.telefono;
                u.estado = 1;
                u.fecharegistro = System.DateTime.Now;
                u.Email = t.Email;
                u.Password = t.Password;
                u.RoleType = 2;
                db.tblUser.Add(u);
                db.SaveChanges();

                return RedirectToAction("Login", "Account");
            }
            else
            {
                TempData["msg"] = "No se pudo registrar!!";
            }
            return View();
        }


        public ActionResult Login()
        {
            return View();
        }


        [HttpPost]
        public ActionResult Login(tblUser t)
        {
            var query = db.tblUser.SingleOrDefault(m => m.Email == t.Email && m.Password == t.Password);
            if (query != null)
            {
                if (query.RoleType == 1)
                {
                    FormsAuthentication.SetAuthCookie(query.Email, false);
                    Session["User"] = query.Name;
                    Session["uid"] = query.UserId;
                    return RedirectToAction("Index", "Home");
                }
                else if (query.RoleType == 2)
                {
                    FormsAuthentication.SetAuthCookie(query.Email, false);
                    Session["User"] = query.Name;
                    Session["uid"] = query.UserId;
                    return RedirectToAction("Index", "Home");
                }

            }
            else
            {
                TempData["msg"] = "Nombre de usuario / clave invalido";
            }

            return View();
        }

        public ActionResult Edit(int id)
        {
            var query = db.tblUser.SingleOrDefault(m => m.UserId == id);
            return View(query);
        }

        [HttpPost]
        public ActionResult Edit(tblUser c)
        {
            try
            {
                db.Entry(c).State = EntityState.Modified;
                db.SaveChanges();

                return RedirectToAction("GetAllUser", "Home");
            }
            catch (Exception ex)
            {
                TempData["msg"] = ex;
            }
            return RedirectToAction("GetAllUser", "Home");
        }


        public ActionResult Delete(int id)
        {
            var query = db.tblUser.SingleOrDefault(m => m.UserId == id);
            db.tblUser.Remove(query);

            db.SaveChanges();
            return RedirectToAction("GetAllUser", "Home");

        }


        public ActionResult Signout()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Index", "Home");
        }


    }
}