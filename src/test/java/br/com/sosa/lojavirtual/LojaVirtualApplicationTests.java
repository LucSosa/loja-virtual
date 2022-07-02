package br.com.sosa.lojavirtual;

import br.com.sosa.lojavirtual.controller.AcessoController;
import br.com.sosa.lojavirtual.model.Acesso;
import br.com.sosa.lojavirtual.repository.AcessoRepository;
import br.com.sosa.lojavirtual.service.AcessoService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest(classes = LojaVirtualApplication.class)
public class LojaVirtualApplicationTests {
    @Autowired
    private AcessoController acessoController;

    @Test
    public void testCadastraAcesso() {
        Acesso acesso = new Acesso();
        acesso.setDescricao("ROLE_ADMIN");
        acessoController.salvarAcesso(acesso);
    }

}
