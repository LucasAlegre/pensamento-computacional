use context starter2024


data Ponto:
    # Um elemento do conjunto Ponto tem o formato:
    ponto2d(
        coord-x :: Number,  # Coordenada x do ponto
        coord-y :: Number   # Coordenada y do ponto
    )
end

p1 :: Ponto = ponto2d(2, 0)

check:
    p1.coord-x is 2
end

fun distancia-origem(p :: Ponto) -> Number:
    doc: "Calcula a distância do ponto p até a origem (0,0)."
    sqrt(sqr(p.coord-x) + sqr(p.coord-y))
where:
    distancia-origem(p1) is 2
end

fun soma-pontos(pA :: Ponto, pB :: Ponto) -> Ponto:
    doc: "Soma as coordenadas dos pontos pA e pB."
    ponto2d(
        pA.coord-x + pB.coord-x,
        pA.coord-y + pB.coord-y
    )
where:
    soma-pontos(ponto2d(1, 2), ponto2d(3, 4)) is ponto2d(4, 6)
end

data Carro:
    # Um elemento do conjunto Carro tem o formato:
    carro(
        mod :: String, # modelo do carro
        mar :: String, # marca do carro
        ano :: Number, # ano do carro
        cor :: String, # cor do carro
        km :: Number   # quilometragem do carro
    )
end


ferrari :: Carro = carro("GTB", "Ferrari", 2019, "vermelho", 10000)
fusca :: Carro = carro("Fusca", "VW", 1972, "azul", 70000)


fun soma1000km(c :: Carro) -> Carro:
    doc: "Soma em 1000km a quilometragem de um carro."
    carro(c.mod, c.mar, c.ano, c.cor, c.km + 1000)
end

fun menor2013(c :: Carro) -> Boolean:
    doc: "Dado um carro, diz se o ano é menor que 2013." 
    c.ano < 2013
end

fun aumenta-km(c :: Carro) -> Carro:
    doc: "Dado um carro, aumenta sua quilometragem em 1000km se o ano for menor que 2013."
    ask:
        # Se o ano do carro for menor que 2013, soma 1000km em c
        | menor2013(c) then: soma1000km(c)
        # Se não, retorna o carro c sem alterações
        | otherwise: c
    end
where:
    aumenta-km(fusca) is carro("Fusca", "VW", 1972, "azul", 71000)
    aumenta-km(ferrari) is carro("GTB", "Ferrari", 2019, "vermelho", 10000)
end


#|
   Exercício Final da Aula
|#


data Musico:
    # Um elemento do conjunto Musico tem o formato:
    musico(
        nome :: String,         # Nome do músico
        genero :: String,       # Genero musical do artista
        gravadora :: String     # Nome da gravadora
    ) 
end

rogerio :: Musico = musico("Rogério Águas", "Rock", "Som Livre")
bruno :: Musico = musico("Bruninho Marte", "Pop", "Warner Music")
gaga :: Musico = musico("Dona Gaga", "Pop", "Interscope Records")

fun atualiza-gravadora(m :: Musico) -> Musico:
    doc: "Dado um musico, modificada a gravadora para Universal Music caso a gravadora seja Som Livre."
    ask:
        # Se a gravadora do músico for Som Livre, atualiza para Universal Music
        | string-equal(m.gravadora, "Som Livre") then: musico(m.nome, m.genero, "Universal Music")
        # Se não, deixa o músico m sem alterações
        | otherwise: m
    end
where:
    atualiza-gravadora(rogerio) is musico("Rogério Águas", "Rock", "Universal Music")
    atualiza-gravadora(bruno) is musico("Bruninho Marte", "Pop", "Warner Music")
end


fun atualiza-gravadora2(m :: Musico, gravadora-antiga :: String, gravadora-nova :: String) -> Musico:
    doc: "Dado um musico, a gravadora que está fechando e o nome da gravadora nova, atualiza a gravadora do musico caso ele esteja na gravadora antiga. Caso contrário, não faz alterações."
    ask:
        # Se a gravadora do músico for gravadora-antiga, atualiza para gravadora-nova
        | (m.gravadora == gravadora-antiga) then: 
            musico(m.nome, m.genero, gravadora-nova)
        # Se não, deixa o músico m sem alterações
        | otherwise: m
    end
where:
    atualiza-gravadora2(rogerio, "Som Livre", "Universal Music") is musico("Rogério Águas", "Rock", "Universal Music")
    atualiza-gravadora2(bruno, "Som Livre", "Universal Music") is musico("Bruninho Marte", "Pop", "Warner Music")
end
