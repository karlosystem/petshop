using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using PetShopPedido.Models;

namespace PetShopPedido.Controllers
{
    public class HomeController : Controller
    {
        dbOnlineStoreModel db = new dbOnlineStoreModel();

        /* agregar carrito */
        List<Cart> li = new List<Cart>();

        public ActionResult Index()
        {

            if (TempData["cart"] != null)
            {
                int x = 0;

                List<Cart> li2 = TempData["cart"] as List<Cart>;
                foreach (var item in li2)
                {
                    x += item.bill;

                }
                TempData["total"] = x;
                TempData["item_count"] = li2.Count();
            }
            TempData.Keep();

            var query = db.tblProducts.ToList();
            return View(query);
        }

        public ActionResult AddtoCart(int id)
        {
            var query = db.tblProducts.Where(x => x.ProID == id).SingleOrDefault();
            return View(query);
        }

        [HttpPost]
        public ActionResult AddtoCart(int id, int qty)
        {
            tblProducts p = db.tblProducts.Where(x => x.ProID == id).SingleOrDefault();
            Cart c = new Cart();
            c.proid = id;
            c.proname = p.Name;
            c.price = Convert.ToInt32(p.Unit);
            c.qty = Convert.ToInt32(qty);
            c.bill = c.price * c.qty;
            if (TempData["cart"] == null)
            {
                li.Add(c);
                TempData["cart"] = li;
            }
            else
            {
                List<Cart> li2 = TempData["cart"] as List<Cart>;
                int flag = 0;
                foreach (var item in li2)
                {
                    if (item.proid == c.proid)
                    {
                        item.qty += c.qty;
                        item.bill += c.bill;
                        flag = 1;
                    }

                }
                if (flag == 0)
                {
                    li2.Add(c);
                    //new item
                }
                TempData["cart"] = li2;

            }

            TempData["msg"] = "Producto Agregado al Carrito de Compras";
            TempData.Keep();



            return RedirectToAction("Index");
        }


        public ActionResult remove(int? id)
        {
            if (TempData["cart"] == null)
            {
                TempData.Remove("total");
                TempData.Remove("cart");
            }
            else
            {
                List<Cart> li2 = TempData["cart"] as List<Cart>;
                Cart c = li2.Where(x => x.proid == id).SingleOrDefault();
                li2.Remove(c);
                int s = 0;
                foreach (var item in li2)
                {
                    s += item.bill;
                }
                TempData["total"] = s;

            }

            return RedirectToAction("Index");
        }

        public ActionResult Checkout()
        {
            TempData.Keep();
            return View();
        }

        [HttpPost]
        public ActionResult Checkout(string contact, string address)
        {
            if (ModelState.IsValid)
            {
                List<Cart> li2 = TempData["cart"] as List<Cart>;
                tblInvoice iv = new tblInvoice();
                iv.UserId = Convert.ToInt32(Session["uid"].ToString());
                iv.InvoiceDate = System.DateTime.Now;
                iv.Bill = (int)TempData["total"];
                iv.Payment = "cash";
                iv.Status = "1";
                db.tblInvoice.Add(iv);
                db.SaveChanges();

                foreach (var item in li2)
                {
                    tblOrder od = new tblOrder();
                    od.ProID = item.proid;
                    od.Contact = contact;
                    od.Address = address;
                    od.OrderDate = System.DateTime.Now;
                    od.InvoiceId = iv.InvoiceId;
                    od.Qty = item.qty;
                    od.Unit = item.price;
                    od.Total = item.bill;

                    db.tblOrder.Add(od);
                    db.SaveChanges();

                }
                TempData.Remove("total");
                TempData.Remove("cart");
                //TempData["msg"] = "Pedido Grabado con Exito!!";
                return RedirectToAction("Index");
            }

            TempData.Keep();
            return View();
        }


        public ActionResult GetAllOrderDetail()
        {
            var query = db.getallorders.ToList();
            return View(query);
        }

        public ActionResult ConfirmOrder(int InvoiceId)
        {
            var query = db.getallorders.SingleOrDefault(m => m.InvoiceId == InvoiceId);
            return View(query);
        }


        [HttpPost]
        public ActionResult ConfirmOrder(getallorders o)
        {
            tblInvoice inv = new tblInvoice()
            {
                InvoiceId = o.InvoiceId,
                UserId = o.UserId,
                Bill = o.Bill,
                Payment = o.Payment,
                InvoiceDate = o.InvoiceDate,
                Status = "0",
            };


            db.Entry(inv).State = EntityState.Modified;
            db.SaveChanges();
            ViewBag.Message = "Pedido en proceso";
            return View();

        }


        public ActionResult OrderDetail(int id)
        {
            var query = db.getallorderusers.Where(m => m.UserId == id).ToList();
            return View(query);
        }


        public ActionResult DetallesPedido(int id)
        {
            var query = db.vw_productosPedido.Where(m => m.InvoiceId == id).ToList();
            return View(query);
        }


        public ActionResult DetallesPedidoCliente(int id)
        {
            var query = db.vw_productosPedido.Where(m => m.InvoiceId == id).ToList();
            return View(query);
        }

        public ActionResult TrackingPedidoCliente(int id)
        {
            var query = db.vw_TrackingEstados.Where(m => m.InvoiceId == id).ToList();
            return View(query);
        }


        public ActionResult TrackingUsuarios(int id)
        {
            var query = db.vw_TrackingUsuarios.Where(m => m.InvoiceId == id).ToList();
            return View(query);
        }



        public ActionResult GetAllUser()
        {
            var query = db.tblUser.ToList();
            return View(query);
        }

        public ActionResult Invoice(int id)
        {
            var query = db.user_invoices.Where(m => m.InvoiceId == id).ToList();
            return View(query);
        }
    }
}