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

pessoa("Carlos", 1926, "A",
        [list: pessoa("João", 1952, "A", empty),
               pessoa("Maria", 1955, "B", empty),
               pessoa("Eva", 1958, "O", 
                  [list: pessoa("Sofia", 1986, "O", empty),
                         pessoa("Gustavo", 1988, "A", empty)])])

JOAO = pessoa("João", 1952, "A", empty)
MARIA = pessoa("Maria", 1955, "B", empty)
SOFIA = pessoa("Sofia", 1986, "O", empty)
GUSTAVO = pessoa("Gustavo", 1988, "A", empty)
LF-EVA = [list: SOFIA, GUSTAVO]
EVA = pessoa("Eva", 1958, "O", LF-EVA)
LF-CARLOS = [list: JOAO, MARIA, EVA]
CARLOS = pessoa("Carlos", 1926, "A", LF-CARLOS)


fun descendente-tipo-o(p :: Pessoa) -> Boolean:
    doc: "Dado uma pessoa, verifica se ela ou algum de seus descendentes tem tipo sanguíneo O."
    ask:
        # Se p tem tipo O, devolver true
        | p.tipo-sang == "O" then: true
        # Senão,
        | otherwise: 
            # Existe alguém com tipo O entre os filhos de p?
            descendente-tipo-o-lista(p.filhos)
    end
where:
    descendente-tipo-o(CARLOS) is true
    descendente-tipo-o(JOAO) is false
end

fun descendente-tipo-o-lista(lf :: ListaDeFilhos) -> Boolean:
    doc: "Dada uma lista de filhos, verifica se algum deles ou seus descendentes tem tipo sanguíneo O."
    cases (ListaDeFilhos) lf:
        # Se a lista de filhos é vazia, devolver false
        | empty => false
        | link(f, r) =>
            # Existe um descendente com tipo O entre:
            # 1) o primeiro filho e seus filhos?, ou
            # 2) entre o resto dos filhos?
            descendente-tipo-o(f) or descendente-tipo-o-lista(r)
    end
where:
    descendente-tipo-o-lista(empty) is false
    descendente-tipo-o-lista(LF-CARLOS) is true
    descendente-tipo-o-lista(LF-EVA) is true
end

fun escolhe-cor(p :: Pessoa) -> String:
    doc: "Dado uma pessoa, devolve a cor que deve ser usada para desenhá-la."
    ask:
        | p.tipo-sang == "O" then: "green"
        | p.tipo-sang == "A" then: "red"
        | p.tipo-sang == "B" then: "blue"
        | otherwise: "gray"
    end
end

fun desenha-pessoa(p :: Pessoa) -> Image:
    doc: "Dado uma pessoa, devolve uma string que representa a pessoa."
    overlay(
        text(p.nome, 12, "white"),
        circle(30, "solid", escolhe-cor(p))
    )
end

fun desenha-descendentes(p :: Pessoa) -> Image:
    doc: "Dado uma pessoa, devolve uma string que representa a árvore de descendentes de p."
    beside(
        desenha-pessoa(p),
        desenha-descendentes-lista(p.filhos)
    )
end

fun desenha-descendentes-lista(lf :: ListaDeFilhos) -> Image:
    doc: "Dada uma lista de filhos, devolve uma string que representa a árvore de descendentes dos filhos."
    cases (ListaDeFilhos) lf:
        | empty => empty-image
        | link(f, r) =>
            # Desenha o primeiro filho e seus descendentes, e depois o resto dos filhos
            beside(
                desenha-descendentes(f),
                desenha-descendentes-lista(r)
            )
    end
end

desenha-descendentes(CARLOS)

data Conteudo:
    | pagina(s :: String)
    | secao(titulo :: String, conteudo :: List<Conteudo>)
end

ALUNO :: Conteudo =
  secao("Graduacao",
    [list:
      secao("Informações Pessoais",
        [list: 
            pagina("Dados Pessoais"),
            pagina("Vínculos"),
            pagina("Qualificações")]),
      secao("Informações do Aluno",
         [list:]),
      secao("Matrícula",
         [list: ])
    ]
  )