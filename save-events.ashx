<%@ WebHandler Language="C#" Class="SaveEvents" %>

using System;
using System.Web;
using System.IO;
using System.Text;

public class SaveEvents : IHttpHandler
{
    // Hardcoded password for authentication (matches login.html)
    private const string ADMIN_PASSWORD = "BoskruinAdmin2025";

    public void ProcessRequest(HttpContext context)
    {
        context.Response.ContentType = "application/json";
        context.Response.AddHeader("Access-Control-Allow-Origin", "*");
        context.Response.AddHeader("Access-Control-Allow-Methods", "POST, OPTIONS");
        context.Response.AddHeader("Access-Control-Allow-Headers", "Content-Type, X-Admin-Password");

        // Handle preflight OPTIONS request
        if (context.Request.HttpMethod == "OPTIONS")
        {
            context.Response.StatusCode = 200;
            return;
        }

        // Only allow POST requests
        if (context.Request.HttpMethod != "POST")
        {
            context.Response.StatusCode = 405; // Method Not Allowed
            context.Response.Write("{\"success\":false,\"message\":\"Only POST requests are allowed\"}");
            return;
        }

        try
        {
            // Check authentication password
            string providedPassword = context.Request.Headers["X-Admin-Password"];
            if (string.IsNullOrEmpty(providedPassword) || providedPassword != ADMIN_PASSWORD)
            {
                context.Response.StatusCode = 401; // Unauthorized
                context.Response.Write("{\"success\":false,\"message\":\"Authentication failed\"}");
                return;
            }

            // Read the JSON data from request body
            string jsonData;
            using (StreamReader reader = new StreamReader(context.Request.InputStream, Encoding.UTF8))
            {
                jsonData = reader.ReadToEnd();
            }

            // Validate that we received data
            if (string.IsNullOrWhiteSpace(jsonData))
            {
                context.Response.StatusCode = 400; // Bad Request
                context.Response.Write("{\"success\":false,\"message\":\"No data received\"}");
                return;
            }

            // Get the physical path to calendar-events.json
            string filePath = context.Server.MapPath("~/calendar-events.json");

            // Create backup of existing file (optional but recommended)
            if (File.Exists(filePath))
            {
                string backupPath = context.Server.MapPath("~/calendar-events.backup.json");
                File.Copy(filePath, backupPath, true);
            }

            // Write the JSON data to file
            File.WriteAllText(filePath, jsonData, Encoding.UTF8);

            // Return success response
            context.Response.StatusCode = 200;
            context.Response.Write("{\"success\":true,\"message\":\"Events saved successfully\"}");
        }
        catch (UnauthorizedAccessException ex)
        {
            context.Response.StatusCode = 500;
            string detailedError = string.Format("Permission denied. Path: {0}, User: {1}, Error: {2}",
                context.Server.MapPath("~/calendar-events.json").Replace("\\", "\\\\"),
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
                context.Server.MapPath("~/calendar-events.json").Replace("\\", "\\\\"),
                System.Security.Principal.WindowsIdentity.GetCurrent().Name);
            context.Response.Write("{\"success\":false,\"message\":\"" + detailedError + "\"}");
        }
    }

    public bool IsReusable
    {
        get { return true; }
    }
}
