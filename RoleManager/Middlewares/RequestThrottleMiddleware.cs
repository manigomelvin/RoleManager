using RoleManager.Models;
using System.Collections.Concurrent;

public class RequestThrottlingMiddleware
{
    private readonly RequestDelegate _next;
    private static readonly ConcurrentDictionary<string, RequestLog> _requests = new();
    private const int Limit = 10;
    private static readonly TimeSpan Period = TimeSpan.FromMinutes(1);

    public RequestThrottlingMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        var userId = context.User.Identity?.Name ?? context.Connection.RemoteIpAddress?.ToString();

        if (string.IsNullOrEmpty(userId))
        {
            await _next(context);
            return;
        }

        var now = DateTime.UtcNow;
        var requestLog = _requests.GetOrAdd(userId, _ => new RequestLog());
        bool isLimitExceeded = false;

        lock (requestLog)
        {
            requestLog.RequestTimestamps = requestLog.RequestTimestamps
                .Where(timestamp => timestamp > now - Period)
                .ToList();

            if (requestLog.RequestTimestamps.Count >= Limit)
            {
                isLimitExceeded = true;
            }
            else
            {
                requestLog.RequestTimestamps.Add(now);
            }
        }

        if (isLimitExceeded)
        {
            context.Response.StatusCode = StatusCodes.Status429TooManyRequests;
            await context.Response.WriteAsync("Request limit exceeded. Please wait and try again.");
            return;
        }

        await _next(context);
    }

}
