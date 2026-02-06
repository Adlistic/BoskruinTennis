<%@ WebHandler Language="C#" Class="UploadCoachImage" %>

using System;
using System.Web;
using System.IO;
using System.Collections.Generic;

public class UploadCoachImage : IHttpHandler
{
    private const string ADMIN_PASSWORD = "BoskruinAdmin2025";

    private static readonly HashSet<string> ALLOWED_EXTENSIONS = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
    {
        ".jpg", ".jpeg", ".png", ".webp"
    };

    private static readonly HashSet<string> ALLOWED_CONTENT_TYPES = new HashSet<string>(StringComparer.OrdinalIgnoreCase)
    {
        "image/jpeg", "image/png", "image/webp"
    };

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

            if (context.Request.Files.Count == 0)
            {
                context.Response.StatusCode = 400;
                context.Response.Write("{\"success\":false,\"message\":\"No file uploaded\"}");
                return;
            }

            HttpPostedFile file = context.Request.Files[0];
            string coachId = context.Request.Form["coachId"];

            if (string.IsNullOrEmpty(coachId))
            {
                context.Response.StatusCode = 400;
                context.Response.Write("{\"success\":false,\"message\":\"Coach ID is required\"}");
                return;
            }

            string extension = Path.GetExtension(file.FileName);
            if (!ALLOWED_EXTENSIONS.Contains(extension))
            {
                context.Response.StatusCode = 400;
                context.Response.Write("{\"success\":false,\"message\":\"Invalid file type. Allowed: jpg, jpeg, png, webp\"}");
                return;
            }

            if (!ALLOWED_CONTENT_TYPES.Contains(file.ContentType))
            {
                context.Response.StatusCode = 400;
                context.Response.Write("{\"success\":false,\"message\":\"Invalid content type\"}");
                return;
            }

            // Limit to 5MB
            if (file.ContentLength > 5 * 1024 * 1024)
            {
                context.Response.StatusCode = 400;
                context.Response.Write("{\"success\":false,\"message\":\"File too large. Maximum 5MB allowed\"}");
                return;
            }

            string fileName = "coach-" + coachId + extension.ToLower();
            string filePath = context.Server.MapPath("~/" + fileName);

            file.SaveAs(filePath);

            context.Response.StatusCode = 200;
            context.Response.Write("{\"success\":true,\"message\":\"Image uploaded successfully\",\"filename\":\"" + fileName + "\"}");
        }
        catch (Exception ex)
        {
            context.Response.StatusCode = 500;
            string detailedError = string.Format("Error: {0}, Type: {1}",
                ex.Message.Replace("\"", "'").Replace("\\", "\\\\"),
                ex.GetType().Name);
            context.Response.Write("{\"success\":false,\"message\":\"" + detailedError + "\"}");
        }
    }

    public bool IsReusable
    {
        get { return true; }
    }
}
