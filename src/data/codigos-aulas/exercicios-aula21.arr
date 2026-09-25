use context starter2024

# Referencia mútua

type ListaDeFilhos = List<Pessoa>
# data ListaDeFilhos:
#    | empty
#    | link(
#        first :: Pessoa,
#        rest :: ListaDeFilhos
#    )
# end

data Pessoa:
    | pessoa(
        nome :: String,         # Nome da pessoa
        ano :: Number,          # Ano de nascimento da pessoa
        tipo-sang :: String,    # Tipo sanguíneo da pessoa
        filhos :: ListaDeFilhos # Filhos da pessoa
    )
end

JOAO = pessoa("João", 1952, "A", empty)
MARIA = pessoa("Maria", 1955, "B", empty)
SOFIA = pessoa("Sofia", 1986, "O", empty)
GUSTAVO = pessoa("Gustavo", 1988, "A", empty)
LF-EVA = [list: SOFIA, GUSTAVO]
EVA = pessoa("Eva", 1958, "O", LF-EVA)
LF-CARLOS = [list: JOAO, MARIA, EVA]
CARLOS = pessoa("Carlos", 1926, "A", LF-CARLOS)


fun conta-descendentes-tipo-o(p :: Pessoa) -> Number:
    doc: "Dado uma pessoa, retorna o número de descendentes (incluindo a pessoa) com tipo O"

    if p.tipo-sang == "O": 1 else: 0 end +
    conta-descendentes-tipo-o-lista(p.filhos)
where:
    conta-descendentes-tipo-o(CARLOS) is 2
    conta-descendentes-tipo-o(MARIA) is 0
end

fun conta-descendentes-tipo-o-lista(lf :: ListaDeFilhos) -> Number:
    doc: "..."
    cases (ListaDeFilhos) lf:
        | empty => 0
        | link(f, r) => conta-descendentes-tipo-o(f) +
                        conta-descendentes-tipo-o-lista(r)
    end
where:
    conta-descendentes-tipo-o-lista(LF-CARLOS) is 2
end