package br.com.sosa.lojavirtual.service;

import br.com.sosa.lojavirtual.repository.UsuarioRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PessoaUserService {

    @Autowired
    private UsuarioRepository userRepository;

}
