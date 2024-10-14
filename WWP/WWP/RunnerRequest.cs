using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace WWP
{
    public class RunnerRequest
    {
        private string connectionString;

        public RunnerRequest(string dbConnectionString)
        {
            connectionString = dbConnectionString;
        }

        public void AddRunnerToDatabase(Runner runner)
        {
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string runner_query = "Insert Into User(Email,Password,First_Name,Last_Name,Role_id)"+
                                        "Values(@Email,@Password,First_Name,@Last_Name,@Role_id)" + 
                                        "Inser Into Runner(Email,Gender,DateOfBirth)" + 
                                        "Values(@Email,@Gender, @DateOfBirth)";
                using (SqlCommand command = new SqlCommand(runner_query,connection))
                {
                    command.Parameters.AddWithValue("@Email", runner.Email);
                    command.Parameters.AddWithValue("@Password", runner.Password);
                    command.Parameters.AddWithValue("@First_Name", runner.FirstName);
                    command.Parameters.AddWithValue("@Last_Name", runner.SurName);
                    command.Parameters.AddWithValue("@Role_id", runner.Role_id);
                    command.Parameters.AddWithValue("@Gender", runner.Gender);
                    command.Parameters.AddWithValue("@DateOfBirth", runner.DateOfBirth);

                    command.ExecuteNonQuery();
                }
                Console.WriteLine("Успешная регестрация");
            }
        }

    }
}
