using System;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Configuration;

/// <summary>
/// Database Helper Class for managing all SQL Server operations
/// Used for connecting to db.mdf and executing queries
/// </summary>
public class MyAdoHelper
{
    /// <summary>
    /// Execute a SELECT query and return results as DataTable
    /// </summary>
    /// <param name="fileName">Database file name (e.g., "db.mdf")</param>
    /// <param name="selectQuery">SQL SELECT query to execute</param>
    /// <returns>DataTable with query results, empty DataTable if error</returns>
    public static DataTable ExecuteDataTable(string fileName, string selectQuery)
    {
        try
        {
            // Get connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            
            // Create connection and command
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(selectQuery, connection))
                {
                    // Open connection
                    connection.Open();
                    
                    // Create data adapter to fill DataTable
                    SqlDataAdapter adapter = new SqlDataAdapter(command);
                    DataTable dataTable = new DataTable();
                    
                    // Fill DataTable with query results
                    adapter.Fill(dataTable);
                    
                    // Connection closes automatically (using statement)
                    return dataTable;
                }
            }
        }
        catch (Exception ex)
        {
            // Log error (optional)
            System.Diagnostics.Debug.WriteLine("ExecuteDataTable Error: " + ex.Message);
            
            // Return empty DataTable on error
            return new DataTable();
        }
    }

    /// <summary>
    /// Execute an INSERT, UPDATE, or DELETE query
    /// </summary>
    /// <param name="fileName">Database file name (e.g., "db.mdf")</param>
    /// <param name="sql">SQL query to execute (INSERT/UPDATE/DELETE)</param>
    public static void DoQuery(string fileName, string sql)
    {
        try
        {
            // Get connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            
            // Create connection and command
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    // Open connection
                    connection.Open();
                    
                    // Execute the query
                    command.ExecuteNonQuery();
                    
                    // Connection closes automatically (using statement)
                }
            }
        }
        catch (Exception ex)
        {
            // Log error (optional)
            System.Diagnostics.Debug.WriteLine("DoQuery Error: " + ex.Message);
        }
    }

    /// <summary>
    /// Check if a record exists in the database
    /// </summary>
    /// <param name="fileName">Database file name (e.g., "db.mdf")</param>
    /// <param name="selectQuery">SQL SELECT query to check</param>
    /// <returns>True if record exists, False otherwise</returns>
    public static bool IsExist(string fileName, string selectQuery)
    {
        try
        {
            // Get connection string from Web.config
            string connectionString = ConfigurationManager.ConnectionStrings["db"].ConnectionString;
            
            // Create connection and command
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(selectQuery, connection))
                {
                    // Open connection
                    connection.Open();
                    
                    // Execute query and get result
                    SqlDataReader reader = command.ExecuteReader();
                    
                    // Check if any rows returned
                    bool exists = reader.HasRows;
                    
                    // Close reader and connection
                    reader.Close();
                    
                    return exists;
                }
            }
        }
        catch (Exception ex)
        {
            // Log error (optional)
            System.Diagnostics.Debug.WriteLine("IsExist Error: " + ex.Message);
            
            // Return false on error
            return false;
        }
    }
}
