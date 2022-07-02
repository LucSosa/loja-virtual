package br.com.sosa.lojavirtual;

import br.com.sosa.lojavirtual.controller.AcessoController;
import br.com.sosa.lojavirtual.model.Acesso;
import br.com.sosa.lojavirtual.repository.AcessoRepository;
import junit.framework.TestCase;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest(classes = LojaVirtualApplication.class)
class LojaVirtualApplicationTests extends TestCase {
    @Autowired
    private AcessoController acessoController;
    @Autowired
    private AcessoRepository acessoRepository;

    @Test
    public void testCadastraAcesso() {
        Acesso acesso = new Acesso();

        acesso.setDescricao("ROLE_ADMIN");

        assertEquals(true, acesso.getId() == null);

        /*Gravou no banco de dados*/
        acesso = acessoController.salvarAcesso(acesso).getBody();

        assertEquals(true, acesso.getId() > 0);

        /*Validar dados salvos da forma correta*/
        assertEquals("ROLE_ADMIN", acesso.getDescricao());

        /*Teste de carregamento*/

        Acesso acesso2 = acessoRepository.findById(acesso.getId()).get();

        assertEquals(acesso.getId(), acesso2.getId());


        /*Teste de delete*/

        acessoRepository.deleteById(acesso2.getId());

        acessoRepository.flush(); /*Roda esse SQL de delete no banco de dados*/

        Acesso acesso3 = acessoRepository.findById(acesso2.getId()).orElse(null);

        assertEquals(true, acesso3 == null);


        /*Teste de query*/

        acesso = new Acesso();

        acesso.setDescricao("ROLE_ALUNO");

        acesso = acessoController.salvarAcesso(acesso).getBody();

        List<Acesso> acessos = acessoRepository.buscarAcessoDesc("ALUNO".trim().toUpperCase());

        assertEquals(1, acessos.size());

        acessoRepository.deleteById(acesso.getId());
    }

}
