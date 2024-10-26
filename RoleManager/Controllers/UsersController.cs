using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using RoleManager.Models;
using System.Security.Claims;

[Authorize]
[ApiController]
[Route("api/[controller]")]
public class UsersController : ControllerBase
{
    private readonly UserRepository _userRepository;

    public UsersController(UserRepository userRepository)
    {
        _userRepository = userRepository;
    }

    [HttpGet]
    public async Task<IActionResult> GetCompanyUsers()
    {
        var companyId = int.Parse(User.Claims.First(c => c.Type == "companyId").Value);
        var roleClaim = User.Claims.FirstOrDefault(c => c.Type == ClaimTypes.Role).Value;

        var users = await _userRepository.GetCompanyUsers(companyId);

        if (roleClaim != "Admin")
        {
            users = users.Where(u => !u.IsAdmin);
        }

        return Ok(users);
    }

    [HttpPost]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> CreateUser([FromBody] User user)
    {
        user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(user.PasswordHash);
        await _userRepository.CreateUser(user);
        return Ok();
    }

    [HttpPut("{id}")]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> UpdateUser(int id, [FromBody] User user)
    {
        user.Id = id;

        if (!string.IsNullOrWhiteSpace(user.PasswordHash))
        {
            user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(user.PasswordHash);
        }
        else
        {
            var existingUser = await _userRepository.GetUserById(id);
            if (existingUser == null)
            {
                return NotFound("User not found.");
            }
            user.PasswordHash = existingUser.PasswordHash;
        }

        await _userRepository.UpdateUser(user);
        return Ok();
    }

    [HttpDelete("{id}")]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> DeleteUser(int id)
    {
        await _userRepository.DeleteUser(id);
        return Ok();
    }
}
