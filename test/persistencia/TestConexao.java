package persistencia;

import java.sql.Connection;
import java.sql.SQLException;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;

/**
 *
 * @author Samuel
 */
public class TestConexao 
{ 
    private ConexaoBanco conec;
    
    public TestConexao() 
    {
        
    }
    
    @BeforeClass
    public static void setUpClass() 
    {
        
    }

    @AfterClass
    public static void tearDownClass()
    {
        
    }

    @Before
    public void setUp() 
    {
        conec = new ConexaoBanco();
    }

    @After
    public void tearDown()
    {
        
    }

    @Test
    public void testarConexao() 
    {
        try 
        {
            //Tenta estabelecer uma conexão
            Connection c = conec.getConexao();
            // Afirma que a conexão não é nula
            assertNotNull("A conexão não deve ser nula", c);
            // Verificar se a conexão é válida
            assertTrue("A conexão deve ser válida", c.isValid(2));
            // Encerra a conexão após o teste
            c.close();
        } 
        catch (SQLException e) 
        {
            // Se houver uma exceção, o teste deverá falhar
            fail("Exception thrown: " + e.getMessage());
        }
    }
}