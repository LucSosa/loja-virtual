package br.com.sosa.lojavirtual.enums;

public enum StatusContaPagar {
    COBRANCA("Pagar"),
    VENCIDA("Vencida"),
    ABERTA("Aberta"),
    QUITADA("Quitada"),
    ALUGUEL("Aluguel"),
    FUNCIONARIO("Funcionário"),
    NEGOCIADA("Renegociada");

    private String descricao;

    StatusContaPagar(String descricao) {
        this.descricao = descricao;
    }

    public String getDescricao() {
        return descricao;
    }

    @Override
    public String toString() {
        return this.getDescricao();
    }
}
