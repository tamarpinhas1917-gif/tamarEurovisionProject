using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;

namespace tamarProject
{
    /// <summary>
    /// Automatically initializes the database on application startup.
    /// Creates the personalData table and admin user if they don't exist.
    /// </summary>
    public class DatabaseInitializer
    {
        private static object _lockObject = new object();
        private static bool _initialized = false;

        /// <summary>
        /// Initialize database - creates tables and admin user if needed.
        /// Thread-safe and only runs once per application lifetime.
        /// </summary>
        public static void InitializeDatabase()
        {
            lock (_lockObject)
            {
                if (_initialized) return;

                try
                {
                    string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;

                    // Create personalData table if it doesn't exist
                    CreateTableIfNotExists(connectionString);

                    // Create admin user if it doesn't exist
                    CreateAdminUserIfNotExists(connectionString);

                    _initialized = true;
                    HttpContext.Current?.Trace.Warn("DatabaseInitializer", "Database initialization completed successfully");
                }
                catch (Exception ex)
                {
                    HttpContext.Current?.Trace.Warn("DatabaseInitializer", $"Error during initialization: {ex.Message}");
                    // Don't throw - allow app to continue even if init fails
                }
            }
        }

        private static void CreateTableIfNotExists(string connectionString)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string sql = @"
                    IF NOT EXISTS (SELECT * FROM sysobjects WHERE name='personalData' AND xtype='U') 
                    BEGIN
                        CREATE TABLE personalData (
                            idnum VARCHAR(20) PRIMARY KEY,
                            fname NVARCHAR(50) NULL,
                            lname NVARCHAR(50) NULL,
                            pass VARCHAR(50) NULL,
                            area NVARCHAR(50) NULL,
                            isAdmin BIT NULL
                        );
                        PRINT 'Created personalData table';
                    END
                    ELSE
                        PRINT 'personalData table already exists';
                ";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.CommandTimeout = 30;
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private static void CreateAdminUserIfNotExists(string connectionString)
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();

                string sql = @"
                    IF NOT EXISTS (SELECT * FROM personalData WHERE idnum='111111111') 
                    BEGIN
                        INSERT INTO personalData (idnum, fname, lname, pass, area, isAdmin)
                        VALUES ('111111111', N'Admin', N'Account', 'admin123', N'North', 1);
                        PRINT 'Created admin user (ID: 111111111)';
                    END
                    ELSE
                        PRINT 'Admin user already exists';
                ";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.CommandTimeout = 30;
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}
