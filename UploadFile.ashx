<%@ WebHandler Language="C#" Class="UploadFile" %>

using System;
using System.Web;
using System.Web.Script.Serialization;


public class UploadFile : IHttpHandler
{

    public void ProcessRequest(HttpContext context)
    {
        if (context.Request != null)
        {
            OperationDetail obj_Op = new OperationDetail();

            if (context.Request.Files["file"] != null && context.Request.Files["file"].ContentLength > 0)
            {
                HttpPostedFile postedFile = context.Request.Files["file"];
                
                postedFile.SaveAs(context.Server.MapPath("/uploadedImg/") + postedFile.FileName);
                //bj_Op.FilePath = HttpUtility.UrlEncode("c:"postedFile.FileName);
                obj_Op.Operation = "success";
                obj_Op.FileName = postedFile.FileName;
                obj_Op.Index = Convert.ToInt32(context.Request["indexer"]);
                JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
                string serobj_Op = javaScriptSerializer.Serialize(obj_Op);
                context.Response.ContentType = "application/json; charset=utf-8";
                context.Response.Write(serobj_Op);
            }
        }
        else
        {

        }


    }
    public class OperationDetail
    {
        public string FilePath { get; set; }
        public string Operation { get; set; }
        public string FileName { get; set; }
        public int Index { get; set; }
    }

    public bool IsReusable
    {
        get { return true; }
    }
}
