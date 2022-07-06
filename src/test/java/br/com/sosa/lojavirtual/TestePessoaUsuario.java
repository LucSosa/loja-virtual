package br.com.sosa.lojavirtual;

import br.com.sosa.lojavirtual.model.PessoaJuridica;
import br.com.sosa.lojavirtual.repository.PessoaRepository;
import br.com.sosa.lojavirtual.service.PessoaUserService;
import junit.framework.TestCase;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.context.annotation.Profile;

@Profile("test")
@SpringBootTest(classes = LojaVirtualApplication.class)
class TestePessoaUsuario extends TestCase {
    @Autowired
    private PessoaUserService pessoaUserService;

    @Autowired
    private PessoaRepository pessoaRepository;

    @Test
    public void testCadPessoaFisica() {

        PessoaJuridica pessoaJuridica = new PessoaJuridica();
        pessoaJuridica.setCnpj("03392484083");
        pessoaJuridica.setNome("Lucas Sosa");
        pessoaJuridica.setEmail("lucas.sosa@sosa.com");
        pessoaJuridica.setTelefone("53981216854");
        pessoaJuridica.setInscEstadual("65556565656665");
        pessoaJuridica.setInscMunicipal("55554565656565");
        pessoaJuridica.setNomeFantasia("54556565665");
        pessoaJuridica.setRazaoSocial("4656656566");

        pessoaRepository.save(pessoaJuridica);

        /*
		PessoaFisica pessoaFisica = new PessoaFisica();
		pessoaFisica.setCpf("0597975788");
		pessoaFisica.setNome("Alex fernando");
		pessoaFisica.setEmail("alex.fernando.egidio@gmail.com");
		pessoaFisica.setTelefone("45999795800");
		pessoaFisica.setEmpresa(pessoaFisica);
		*/
    }
}
