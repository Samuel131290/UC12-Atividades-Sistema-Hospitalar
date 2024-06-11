package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
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
public class TesteBuscarPaciente 
{
    private PacienteServicos buscar;
    private ConexaoBanco con;
    private Paciente pac;

    public TesteBuscarPaciente() 
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
        buscar = new PacienteServicos();

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
    public void testarBusca()
    {
        Connection c = null;
        PreparedStatement pst = null;
        ResultSet rs = null;
        try 
        {
            // Insere o paciente
            c = con.getConexao();
            String insertSql = "INSERT INTO PACIENTE (NOME, ENDERECO, DATA_NASC, TELEFONE, CPF, RG, ID_CONVENIO_FK) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pst = c.prepareStatement(insertSql);
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            pst.setString(1, pac.getNome());
            pst.setString(2, pac.getEndereco());
            pst.setString(3, sdf.format(pac.getDataNascimento()));
            pst.setString(4, pac.getTelefone());
            pst.setString(5, pac.getCpf());
            pst.setString(6, pac.getRg());
            pst.setInt(7, pac.getIdConvenio());
            pst.executeUpdate();
            pst.close();

            // Busca pelo paciente
            String selectSql = "SELECT * FROM PACIENTE WHERE NOME = ?";
            pst = c.prepareStatement(selectSql);
            pst.setString(1, pac.getNome());
            rs = pst.executeQuery();

            ArrayList<Paciente> pacientes = new ArrayList<>();
            while (rs.next()) 
            {
                Paciente foundPac = new Paciente();
                foundPac.setIdPaciente(rs.getInt("ID_PACIENTE"));
                foundPac.setNome(rs.getString("NOME"));
                foundPac.setEndereco(rs.getString("ENDERECO"));
                foundPac.setDataNascimento(rs.getDate("DATA_NASC"));
                foundPac.setTelefone(rs.getString("TELEFONE"));
                foundPac.setCpf(rs.getString("CPF"));
                foundPac.setRg(rs.getString("RG"));
                foundPac.setIdConvenio(rs.getInt("ID_CONVENIO_FK"));
                pacientes.add(foundPac);
            }
            
            assertFalse("A busca deve retornar pelo menos um paciente", pacientes.isEmpty());
            assertEquals("Nome", pacientes.get(0).getNome());
            assertEquals("Endereco", pacientes.get(0).getEndereco());
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
