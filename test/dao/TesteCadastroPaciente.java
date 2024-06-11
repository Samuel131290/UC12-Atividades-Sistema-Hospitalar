package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import modelo.Paciente;
import org.junit.After;
import org.junit.AfterClass;
import org.junit.Before;
import org.junit.BeforeClass;
import org.junit.Test;
import static org.junit.Assert.*;
import persistencia.ConexaoBanco;
import servicos.PacienteServicos;

/**
 *
 * @author Samuel
 */
public class TesteCadastroPaciente
{
    private PacienteServicos cadastro;
    private ConexaoBanco con;
    private Paciente pac;

    public TesteCadastroPaciente()
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
        con = new ConexaoBanco();
        cadastro = new PacienteServicos();

        pac = new Paciente();
        pac.setNome("Nome");
        pac.setEndereco("Endereco");
        pac.setDataNascimento(new java.util.Date());
        pac.setTelefone("123456789");
        pac.setCpf("123.456.789-00");
        pac.setRg("12.345.678-9");
        pac.setIdConvenio(1);
    }
    
    @After
    public void tearDown() 
    {
        
    }
    
    @Test
    public void testarCadastro()
    {
        Connection c = null;
        PreparedStatement pst = null;
        try {
            c = con.getConexao();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");

            String sql = "INSERT INTO PACIENTE (NOME, ENDERECO, DATA_NASC, TELEFONE, CPF, RG, ID_CONVENIO_FK) VALUES (?, ?, ?, ?, ?, ?, ?)";

            pst = c.prepareStatement(sql);

            // Set values for the PreparedStatement
            pst.setString(1, pac.getNome());
            pst.setString(2, pac.getEndereco());
            pst.setString(3, sdf.format(pac.getDataNascimento()));
            pst.setString(4, pac.getTelefone());
            pst.setString(5, pac.getCpf());
            pst.setString(6, pac.getRg());
            pst.setInt(7, pac.getIdConvenio());

            int rowsAffected = pst.executeUpdate();
            assertEquals("Uma linha deve ser inserida!", 1, rowsAffected);

        } 
        catch (SQLException se) 
        {
            fail("Erro ao inserir dados no Banco de Dados! " + se.getMessage());
        } 
        finally 
        {
            try 
            {
                if (pst != null) pst.close();
                if (c != null) c.close();
            } 
            catch (SQLException e)
            {
                e.printStackTrace();
            }
        }
    }
}
