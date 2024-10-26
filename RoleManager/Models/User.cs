namespace RoleManager.Models
{
    public class User
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string PasswordHash { get; set; }
        public string Role { get; set; }
        public int CompanyId { get; set; }
        public bool IsAdmin => Role == "Admin";
    }
}
