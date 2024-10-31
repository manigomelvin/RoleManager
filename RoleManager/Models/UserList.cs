namespace RoleManager.Models
{
    public class UserList
    {
        public int Id { get; set; }
        public string Username { get; set; }
        public string Role { get; set; }
        public bool IsAdmin => Role == "Admin";
        public string CompanyName { get; set; }
    }
}
