using Dapper;
using Microsoft.Data.SqlClient;
using RoleManager.Models;

public class UserRepository
{
    private readonly string _connectionString;

    public UserRepository(IConfiguration configuration)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection");
    }

    private SqlConnection SqlConnection()
    {
        return new SqlConnection(_connectionString);
    }

    public async Task<User> GetUserByUsername(string username)
    {
        using (var connection = SqlConnection())
        {
            string sql = "SELECT * FROM Users WHERE Username = @Username";
            return await connection.QueryFirstOrDefaultAsync<User>(sql, new { Username = username });
        }
    }

    public async Task<IEnumerable<UserList>> GetCompanyUsers(int companyId)
    {
        using (var connection = SqlConnection())
        {
            var sql = @"
                SELECT u.Id, u.Username, u.Role, c.Name AS CompanyName
                FROM Users u
                INNER JOIN Companies c ON u.CompanyId = c.Id
                WHERE u.CompanyId = @CompanyId";
            return await connection.QueryAsync<UserList>(sql, new { CompanyId = companyId });
        }
    }

    public async Task<int> CreateUser(User user)
    {
        using (var connection = SqlConnection())
        {
            string sql = @"INSERT INTO Users (Username, PasswordHash, Role, CompanyId) 
                        VALUES (@Username, @PasswordHash, @Role, @CompanyId)";
            return await connection.ExecuteAsync(sql, user);
        }
    }

    public async Task<int> UpdateUser(User user)
    {
        using (var connection = SqlConnection())
        {
            string sql = @"UPDATE Users SET Username = @Username, Role = @Role, PasswordHash = @PasswordHash
                        WHERE Id = @Id";
            return await connection.ExecuteAsync(sql, user);
        }
    }

    public async Task<int> DeleteUser(int id)
    {
        using (var connection = SqlConnection())
        {
            string sql = "DELETE FROM Users WHERE Id = @Id";
            return await connection.ExecuteAsync(sql, new { Id = id });
        }
    }

    public async Task<User> GetUserById(int id)
    {
        using (var connection = SqlConnection())
        {
            string sql = "SELECT * FROM Users WHERE Id = @Id";
            return await connection.QueryFirstOrDefaultAsync<User>(sql, new { Id = id });
        }
    }
}

