package br.com.sosa.lojavirtual.controller;

import br.com.sosa.lojavirtual.ExceptionMentoriaJava;
import br.com.sosa.lojavirtual.model.Acesso;
import br.com.sosa.lojavirtual.repository.AcessoRepository;
import br.com.sosa.lojavirtual.service.AcessoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RestController
public class AcessoController {
    @Autowired
    private AcessoService acessoService;
    @Autowired
    private AcessoRepository acessoRepository;

    @ResponseBody /* Retorno da API*/
    @PostMapping(value = "**/salvarAcesso") /* Mapeando a url para receber JSON*/
    public ResponseEntity<Acesso> salvarAcesso(@RequestBody Acesso acesso) throws ExceptionMentoriaJava {
        if (acesso.getId() == null) {
            List<Acesso> acessos = acessoRepository.buscarAcessoDesc(acesso.getDescricao().toUpperCase());
            if (!acessos.isEmpty()) {
                throw new ExceptionMentoriaJava("Já existe Acesso com a descrição: " + acesso.getDescricao());
            }
        }
        Acesso acessoSalvo = acessoService.save(acesso);
        return new ResponseEntity<Acesso>(acessoSalvo, HttpStatus.OK);
    }

    @ResponseBody /* Retorno da API*/
    @PostMapping(value = "**/deleteAcesso") /* Mapeando a url para receber JSON*/
    public ResponseEntity<?> deleteAcesso(@RequestBody Acesso acesso) {
        acessoRepository.deleteById(acesso.getId());
        return new ResponseEntity("Acesso Removido", HttpStatus.OK);
    }

    @ResponseBody
    @DeleteMapping(value = "**/deleteAcessoPorId/{id}")
    public ResponseEntity<?> deleteAcessoPorId(@PathVariable("id") Long id) {
        acessoRepository.deleteById(id);
        return new ResponseEntity("Acesso Removido", HttpStatus.OK);
    }

    @ResponseBody
    @GetMapping(value = "**/obterAcesso/{id}")
    public ResponseEntity<Acesso> obterAcesso(@PathVariable("id") Long id) throws Exception {
        Acesso acesso = acessoRepository.findById(id).orElse(null);
        if (acesso == null) {
            throw new Exception("Não encontrou Acesso com código: " + id);
        }
        return new ResponseEntity<Acesso>(acesso, HttpStatus.OK);
    }

    @ResponseBody
    @GetMapping(value = "**/buscarPorDesc/{desc}")
    public ResponseEntity<List<Acesso>> buscarPorDesc(@PathVariable("desc") String desc) {
        List<Acesso> acesso = acessoRepository.buscarAcessoDesc(desc.toUpperCase());
        return new ResponseEntity<List<Acesso>>(acesso, HttpStatus.OK);
    }
}
