using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using System.Data;
using System.Data.SqlClient;
using System.Collections;

namespace WWP
{
    /// <summary>
    /// Логика взаимодействия для MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {

        ClassDataBaseConnection database = new ClassDataBaseConnection();

          private SqlConnection sqlConnection = null;
        public MainWindow()
        {
            InitializeComponent();
            Gridik.HideGrid(_123123, null_text, MainGrid);
        }

        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void TextBox_TextChanged_1(object sender, TextChangedEventArgs e)
        {

        }
        private void want_be_runner_Click(object sender, RoutedEventArgs e)
        {
            Gridik.HideGrid(Register5as5a5runner, runner_text, MainGrid);
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            this.Close();
        }
        
        public void CheckPass(string firstPass, string secondPass)
        {

            if (firstPass.Length < 5)
            {
                throw new Exception("Пароль должен состоять минимум и 6 символов.");
            }
            bool IsLower = false;
            bool NumberInString = false;
            bool Symbol = false;
            foreach (char ch in firstPass)
            {
                if (char.IsDigit(ch))
                {
                    NumberInString = true;
                }
                if (char.IsLower(ch))
                {
                    IsLower = true;
                }
                if (ch == '!' || ch == '@' || ch == '#' || ch == '$' || ch == '%' || ch == '^')
                {
                    Symbol = true;
                }
            }
            if (NumberInString == false)
            {
                throw new Exception("Пароль должен содержать хотя бы одну цифру");
            }
            if (IsLower == false)
            {
                throw new Exception("Пароль должен содержать хотя бы одну прописную букву");
            }
            if (Symbol == false)
            {
                throw new Exception("Пароль должен содержать хотя бы однин специпльный символ: ! @ # $% ^ ");
            }
            if (firstPass != secondPass)
            {
                throw new Exception("Пароли должны совподать совподают");
            }

        }

        public void CheckReg()
        {
            if(!CheckEmail(Email_reg.Text))
            {
                throw new Exception("Почта не соответствует формату");
            }
            CheckPass(Password_reg.Text, RepeatPassword_reg.Text);
            if (Name_reg.Text.Length==0)
            {
                throw new Exception("Заполните поле Имя");
            }
            if (Surname_reg.Text.Length == 0)
            {
                throw new Exception("Заполните поле Фамилии");
            }
            if (Gender_reg.Text.Length==0)
            {
                throw new Exception("Заполните поле Гендера");
            }
            if (Country_reg.Text.Length==0)
            {
                throw new Exception("Заполните поле Страны");
            }

        }   
        public bool CheckEmail(string email)
        {

            if (string.IsNullOrWhiteSpace(email))
                return false;

            string pattern = @"^[^@\s]+@[^@\s]+\.[^@\s]+$";
            return Regex.IsMatch(email, pattern);

        }

        private void Button_Click_1(object sender, RoutedEventArgs e)
        {
            Gridik.HideGrid(_123123, null_text, MainGrid);
        }

        private void Button_Click_2(object sender, RoutedEventArgs e)
        {
            Gridik.HideGrid(Login, Login_tb, MainGrid);
        }

        private void Button_Click_3(object sender, RoutedEventArgs e)
        {
            this.Close();
        }

        private void Button_Click_4(object sender, RoutedEventArgs e)
        {
            Gridik.HideGrid(_123123, null_text, MainGrid);
        }
        private void Button_Click_5(object sender, RoutedEventArgs e)
        {
            try
            {
                CheckReg();
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка {ex.Message}");
            }
        }

        private void Button_Click_6(object sender, RoutedEventArgs e)
        {
            Gridik.HideGrid(Redister_Runner, Registration_tb, MainGrid);
        }

        private void TextBox_TextChanged_2(object sender, TextChangedEventArgs e)
        {

        }

        private void Button_Click_7(object sender, RoutedEventArgs e)
        {
            string email_log = Email_log.Text;
            string password_log = Password_log.Text;

            string role = AuthenticateUser(email_log, password_log);

            if (role != null)
            {
                MessageBox.Show($"ещкере {role}");
            }
            else
            {
                MessageBox.Show("Неверный логин или пароль!");
            }
        }
        private string AuthenticateUser(string email_log, string password_log)
        {
            try
            {
                string log_query = "Select * From dbo.[User] WHERE Email = @Email AND Password = @Password";
                using (SqlConnection connection = new SqlConnection("Server =(localdb)\\MSSQLLocalDB; Database = database; Trusted_Connection=True"))
                {
                    SqlCommand command = new SqlCommand(log_query, connection);
                    command.Parameters.AddWithValue("@Email", email_log);
                    command.Parameters.AddWithValue("@Password", password_log);
                    connection.Open();
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            return reader.GetInt32(5).ToString();
                        }
                        else
                        {
                            return null;
                        }
                    }

                }
               
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка подключения к базе данных: " + ex.Message);
            }
            return null;
        }
    }
}
