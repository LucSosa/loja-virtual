package br.com.sosa.lojavirtual.repository;

import br.com.sosa.lojavirtual.model.PessoaJuridica;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PessoaRepository extends CrudRepository<PessoaJuridica, Long> {

}
