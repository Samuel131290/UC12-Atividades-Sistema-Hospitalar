package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
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
 * Author: Samuel
 */
public class TesteListarPacientes 
{
    private PacienteServicos listar;
    private ConexaoBanco con;
    private Paciente pac;

    public TesteListarPacientes() 
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
        listar = new PacienteServicos();

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
    public void testarListagem() 
    {
        Connection c = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try 
        {
            c = con.getConexao();
            String sql = "SELECT * FROM PACIENTE";
            pst = c.prepareStatement(sql);
            rs = pst.executeQuery();

            ArrayList<Paciente> pacientes = new ArrayList<>();
            while (rs.next()) 
            {
                Paciente pac = new Paciente();
                pac.setIdPaciente(rs.getInt("ID_PACIENTE"));
                pac.setNome(rs.getString("NOME"));
                pac.setEndereco(rs.getString("ENDERECO"));
                pac.setDataNascimento(rs.getDate("DATA_NASC"));
                pac.setTelefone(rs.getString("TELEFONE"));
                pac.setCpf(rs.getString("CPF"));
                pac.setRg(rs.getString("RG"));
                pac.setIdConvenio(rs.getInt("ID_CONVENIO_FK"));
                pacientes.add(pac);
            }
            
            assertFalse("A lista de pacientes não deve estar vazia", pacientes.isEmpty());
            Paciente firstPaciente = pacientes.get(0);
            assertNotNull(firstPaciente.getNome());
            assertNotNull(firstPaciente.getEndereco());
        } 
        catch (SQLException se) 
        {
            fail("Erro ao buscar dados no Banco de Dados! " + se.getMessage());
        } 
        finally
        {
            try 
            {
                if (rs != null) rs.close();
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
