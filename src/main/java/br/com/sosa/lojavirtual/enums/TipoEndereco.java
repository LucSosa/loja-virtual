package br.com.sosa.lojavirtual.enums;

public enum TipoEndereco {
    COBRANCA("Cobrança"),
    ENDERECO("Entrega");

    private String descricao;

    TipoEndereco(String descricao) {
        this.descricao = descricao;
    }

    public String getDescricao() {
        return descricao;
    }

    @Override
    public String toString() {
        return this.descricao;
    }
}
