<%@ WebHandler Language="C#" Class="SaveCoaches" %>

using System;
using System.Web;
using System.IO;
using System.Text;

public class SaveCoaches : IHttpHandler
{
    private const string ADMIN_PASSWORD = "BoskruinAdmin2025";

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        context.Response.AddHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
        context.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, X-Admin-Password");

        if (context.Request.HttpMethod == "OPTIONS")
        {
            context.Response.StatusCode = 200;
            return;
        }

        if (context.Request.HttpMethod != "POST")
        {
            context.Response.StatusCode = 405;
            context.Response.Write("{\"success\":false,\"message\":\"Only POST requests are allowed\"}");
            return;
        }

        try
        {
            string providedPassword = context.Request.Headers["X-Admin-Password"];
            if (string.IsNullOrEmpty(providedPassword) || providedPassword != ADMIN_PASSWORD)
            {
                context.Response.StatusCode = 401;
                context.Response.Write("{\"success\":false,\"message\":\"Authentication failed\"}");
                return;
            }

            string jsonData;
            using (StreamReader reader = new StreamReader(context.Request.InputStream, Encoding.UTF8))
            {
                jsonData = reader.ReadToEnd();
            }

            if (string.IsNullOrWhiteSpace(jsonData))
            {
                context.Response.StatusCode = 400;
                context.Response.Write("{\"success\":false,\"message\":\"No data received\"}");
                return;
            }

            string filePath = context.Server.MapPath("~/coaches.json");

            if (File.Exists(filePath))
            {
                string backupPath = context.Server.MapPath("~/coaches.backup.json");
                File.Copy(filePath, backupPath, true);
            }

            File.WriteAllText(filePath, jsonData, Encoding.UTF8);

            context.Response.StatusCode = 200;
            context.Response.Write("{\"success\":true,\"message\":\"Coaches saved successfully\"}");
        }
        catch (UnauthorizedAccessException ex)
        {
            context.Response.StatusCode = 500;
            string detailedError = string.Format("Permission denied. Path: {0}, User: {1}, Error: {2}",
                context.Server.MapPath("~/coaches.json").Replace("\\", "\\\\"),
                System.Security.Principal.WindowsIdentity.GetCurrent().Name,
                ex.Message.Replace("\"", "'").Replace("\\", "\\\\"));
            context.Response.Write("{\"success\":false,\"message\":\"" + detailedError + "\"}");
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            string detailedError = string.Format("Error: {0}, Type: {1}, Path: {2}, User: {3}",
                ex.Message.Replace("\"", "'").Replace("\\", "\\\\"),
                ex.GetType().Name,
                context.Server.MapPath("~/coaches.json").Replace("\\", "\\\\"),
                System.Security.Principal.WindowsIdentity.GetCurrent().Name);
            context.Response.Write("{\"success\":false,\"message\":\"" + detailedError + "\"}");
        }
    }

    public bool IsReusable
    {
        get { return true; }
    }
}
