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
    doc: "Dado uma pessoa, retorna quantos descendentes do tipo O (incluindo a pessoa) existem."
    ask:
        | p.tipo-sang == "O" then:
            1 + conta-descendentes-tipo-o-filhos(p.filhos)
        | otherwise:
            conta-descendentes-tipo-o-filhos(p.filhos)
    end
where:
    conta-descendentes-tipo-o(CARLOS) is 2
    conta-descendentes-tipo-o(EVA) is 2
    conta-descendentes-tipo-o(GUSTAVO) is 0
end

fun conta-descendentes-tipo-o-filhos(lf :: ListaDeFilhos) -> Number:
    doc: "Dado uma lista de filhos, retorna quantas pessoas tem tipo O na lista e nos descendentes."
    cases (ListaDeFilhos) lf:
    | empty => 0
    | link(f, r) => 
        conta-descendentes-tipo-o(f) +
        conta-descendentes-tipo-o-filhos(r)
    end
where:
    conta-descendentes-tipo-o-filhos(empty) is 0
    conta-descendentes-tipo-o-filhos(LF-EVA) is 1
    conta-descendentes-tipo-o-filhos(LF-CARLOS) is 2
end



fun eh-do-tipo-o(s :: String) -> Boolean:
    s == "A" or s == "B"
end

fun nomes-descendentes-tipo-o(p :: Pessoa, crit :: (String -> Boolean)) -> List<String>:
    doc: "Dado uma pessoa, retorna os nomes dos descendentes do tipo informado (incluindo a pessoa)."
    ask:
        | crit(p.tipo-sang) then:
            link(
                p.nome, 
                nomes-descendentes-tipo-o-filhos(p.filhos, crit))
        | otherwise:
            nomes-descendentes-tipo-o-filhos(p.filhos, crit)
    end
where:
    nomes-descendentes-tipo-o(CARLOS, eh-do-tipo-o) is [list: "Eva", "Sofia"]
    nomes-descendentes-tipo-o(EVA, eh-do-tipo-o) is [list: "Eva", "Sofia"]
    nomes-descendentes-tipo-o(GUSTAVO, eh-do-tipo-o) is empty
end

fun nomes-descendentes-tipo-o-filhos(lf :: ListaDeFilhos, crit :: (String -> Boolean)) -> List<String>:
    doc: "Dado uma lista de filhos, retorna os nomes das pessoas que tem tipo O na lista e nos descendentes."
    cases (ListaDeFilhos) lf:
    | empty => empty
    | link(f, r) => 
        nomes-descendentes-tipo-o(f, crit) +
        nomes-descendentes-tipo-o-filhos(r, crit)
    end
where:
    nomes-descendentes-tipo-o-filhos(empty, eh-do-tipo-o) is empty
    nomes-descendentes-tipo-o-filhos(LF-EVA, eh-do-tipo-o) is [list: "Sofia"]
    nomes-descendentes-tipo-o-filhos(LF-CARLOS, eh-do-tipo-o) is [list: "Eva", "Sofia"]
end