package br.com.sosa.lojavirtual.service;

import br.com.sosa.lojavirtual.model.Acesso;
import br.com.sosa.lojavirtual.repository.AcessoRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AcessoService {
    @Autowired
    private AcessoRepository acessoRepository;

    public Acesso save(Acesso acesso){
        return acessoRepository.save(acesso);
    }
}
