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

            LoadCountries();
        }

        private void DateOfBirth_reg_TextInput(object sender, TextCompositionEventArgs e)
        {
            char inputChar = e.Text.Length > 0 ? e.Text[0] : char.MinValue;

            // Разрешаем только цифры и точку
            if (!char.IsDigit(inputChar) && inputChar != '.')
            {
                e.Handled = true; // Отменяем ввод, если это не цифра или точка
            }
        }
        private void DateTextBox_TextChanged(object sender,TextChangedEventArgs e)
       {
            TextBox textBox = sender as TextBox;
            if (textBox == null) return;

            // Убираем все символы, кроме цифр и точек
            string cleanedText = new string(textBox.Text.Where(c => char.IsDigit(c) || c == '.').ToArray());

            // Форматируем текст
            if (cleanedText.Length > 2 && cleanedText[2] != '.')
            {
                cleanedText = cleanedText.Insert(2, ".");
            }
            if (cleanedText.Length > 5 && cleanedText[5] != '.')
            {
                cleanedText = cleanedText.Insert(5, ".");
            }

            // Обновляем текст в TextBox
            if (textBox.Text != cleanedText)
            {
                textBox.Text = cleanedText;
                textBox.SelectionStart = cleanedText.Length; // Устанавливаем курсор в конец
            }
        }
        private void TextBox_TextChanged(object sender, TextChangedEventArgs e)
        {

        }

        private void LoadCountries()
        {
            List<string> countries = new List<string>();

            string countries_query = "Select Country_Name From Country";

            try
            {
                database.openConnection();

                SqlCommand command = new SqlCommand(countries_query, database.getConnection());

                SqlDataReader reader = command.ExecuteReader();

                while (reader.Read())
                {
                    countries.Add(reader.GetString(0));
                }
            }
            catch (Exception ex) 
            {
                MessageBox.Show($"Ошибка при подключении к базе данных: {ex.Message}");
            }

            Country_reg.ItemsSource = countries;
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

            if (firstPass.Length <= 5)
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
                throw new Exception("Пароли не совпадают");
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
            if (SurName_reg.Text.Length == 0)
            {
                throw new Exception("Заполните поле Фамилии");
            }
            if (Gender_reg.Text.Length==0)
            {
                throw new Exception("Заполните поле Гендера");
            }
            if (Country_reg.Text.Length==1)
            {
                throw new Exception("Заполните поле Страны");
            }
            DateTime dataValue;
           
            if(!DateTime.TryParse(DateOfBirth_reg.Text,out dataValue))
            {
                throw new Exception("Неверный формат даты");
            }
            else
            {
                if(DateOfBirth_reg.Text.Length!=10)
                {
                    throw new Exception("Заолните дату");
                }
                dataValue=Convert.ToDateTime(DateOfBirth_reg.Text);
                if(DateTime.Now.AddYears(-10) < dataValue)
                {
                    throw new Exception("Минимальынй возраст 10лет");
                }
                else if (DateTime.Now.AddYears(-100) > dataValue)
                {
                    throw new Exception("Максимальный возраст 100лет");
                }
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
                MessageBox.Show("Успешная регестрация");
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка: {ex.Message}");
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
                MessageBox.Show("qwewqeqwew");
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

        private void Gender_reg_SelectionChanged(object sender, SelectionChangedEventArgs e)
        {

        }

       
    }
}
