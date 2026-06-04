use context dcic2024

import color from color
import color as C
include image
include csv
include data-source
include reactors

provide:
  *,
  type *
end


LARG = 800
ALT = 800

CENARIO = crop(0, 0, LARG, ALT, image-url("https://raw.githubusercontent.com/LucasAlegre/pensamento-computacional/refs/heads/main/src/data/images/grass.png")) 
# rectangle(LARG, ALT, "solid", "lightgray")

data TipoPokemon:
    # Um Pokemon ou movimento pode ter um dos tipos abaixo:
    | NORMAL
    | FIRE
    | ELECTRIC
    | WATER
    | GRASS
    | ICE
    | FIGHTING
    | POISON
    | PSYCHIC
    | BUG
    | GROUND
    | FAIRY
    | ROCK
    | GHOST
    | DRAGON
    | STEEL
    | FLYING
    | DARK
end

data Efeito:
    # Um ataque pode ter um dos efeitos abaixo:
    | SEM-EFEITO
    | NAO-EFETIVO
    | EFETIVO
    | SUPER-EFETIVO
end

data Pokemon:
    # Estrutura para representar um Pokemon
    | pokemon(
        nome :: String,       # Nome do pokemon 
        id :: Number,         # Identificador do pokemon
        tipo :: TipoPokemon,  # Tipo do Pokémon
        x :: Number,          # Coordenada x do pokemon
        y :: Number,          # Coordenada y do pokemon
        dx :: Number,         # Deslocamento em x para a imagem do pokemon
        dy :: Number,         # Deslocamento em y para a imagem do pokemon
        speed :: Number,      # Velocidade de movimento do pokemon
        hp :: Number,         # Quantidade de pontos de vida (HP) do pokemon
        max-hp :: Number,     # Quantidade máxima de pontos de vida (HP) do pokemon
        img :: Image,         # Imagem do pokemon
        movimentos :: Movimento)  # Movimento do pokemon
end

data Movimento:
    # Um movimento pokemon pode ser de ataque ou cura:
    | ataque(
        nome :: String,       # Nome do movimento
        tipo :: TipoPokemon,  # Tipo do movimento
        poder :: Number)      # Poder do movimento
    | cura(
        nome :: String,       # Nome do movimento
        cura :: Number)       # Quantidade de pontos de vida curados
end

type Time = List<Pokemon>
#     Um Time é uma lista de Pokemons
#     | empty
#     | link(first :: Pokemon, rest :: Time)


POKE-URL = "https://gist.githubusercontent.com/armgilles/194bcff35001e7eb53a2a8b441e8b2c6/raw/92200bc0a673d5ce2110aaad4544ed6c4010f687/pokemon.csv"

POKE-DATA =
  load-table: id, name, type1, type2, total, hp, attack, defense, spatck, spdef, speed, generation, legendary
    source: csv-table-url(POKE-URL, default-options)
    sanitize id using num-sanitizer
    sanitize name using string-sanitizer
    sanitize type1 using string-sanitizer
    sanitize type2 using string-sanitizer
    sanitize hp using num-sanitizer
    sanitize speed using num-sanitizer
    sanitize attack using num-sanitizer
  end


EFFECTIVE-URL = "https://raw.githubusercontent.com/zonination/pokemon-chart/refs/heads/master/chart.csv"

EFFECTIVE-DATA =
  load-table: Attacking, Normal, Fire, Water, Electric, Grass, Ice, Fighting, Poison, Ground, Flying, Psychic, Bug, Rock, Ghost, Dragon, Dark, Steel, Fairy
    source: csv-table-url(EFFECTIVE-URL, default-options)
  end


  
fun string-to-tipo(s :: String) -> TipoPokemon:
    doc: "Dada uma string, devolve o tipo de pokemon correspondente a esta string (assumir que a string é sempre um tipo válido)."
    u = string-to-upper(s)
    
    ask:
        | u == "NORMAL" then: NORMAL
        | u == "FIRE" then: FIRE
        | u == "WATER" then: WATER
        | u == "ELECTRIC" then: ELECTRIC
        | u == "GRASS" then: GRASS
        | u == "ICE" then: ICE
        | u == "FIGHTING" then: FIGHTING
        | u == "POISON" then: POISON
        | u == "PSYCHIC" then: PSYCHIC
        | u == "BUG" then: BUG
        | u == "GROUND" then: GROUND
        | u == "FAIRY" then: FAIRY
        | u == "ROCK" then: ROCK
        | u == "GHOST" then: GHOST
        | u == "DRAGON" then: DRAGON
        | u == "STEEL" then: STEEL
        | u == "FLYING" then: FLYING
        | otherwise: DARK
    end
end

fun tipo-to-string(tipo :: TipoPokemon) -> String:
    doc: "Dada um tipo de pokemon, devolve a string correspondente."
    ask:
        | tipo == NORMAL then: "Normal"
        | tipo == FIRE then: "Fire"
        | tipo == WATER then: "Water"
        | tipo == ELECTRIC then: "Electric"
        | tipo == GRASS then: "Grass"
        | tipo == ICE then: "Ice"
        | tipo == FIGHTING then: "Fighting"
        | tipo == POISON then: "Poison"
        | tipo == PSYCHIC then: "Psychic"
        | tipo == BUG then: "Bug"
        | tipo == GROUND then: "Ground"
        | tipo == FAIRY then: "Fairy"
        | tipo == ROCK then: "Rock"
        | tipo == GHOST then: "Ghost"
        | tipo == DRAGON then: "Dragon"
        | tipo == STEEL then: "Steel"
        | tipo == FLYING then: "Flying"
        | otherwise: "Dark"
    end
where:
    tipo-to-string(NORMAL) is "Normal"
    tipo-to-string(FIRE) is "Fire"
end

fun id-pokemon(nome :: String) -> Number:
    doc: "Dado o nome de um pokemon, devolve o id deste pokemon."
    tabela = filter-with(POKE-DATA, lam(row): row["name"] == nome end)

    tabela.row-n(0)["id"]
where:
    id-pokemon("Bulbasaur") is 1
    id-pokemon("Ivysaur") is 2
    id-pokemon("Venusaur") is 3
end


fun id-to-4-digit-string(pokemon-id :: Number) -> String:
    doc: "Dado um número, devolve uma string com este número formatado com 4 dígitos (com zeros à esquerda se necessário)."
    ask:
        | pokemon-id < 10 then: string-append("000", num-to-string(pokemon-id))
        | pokemon-id < 100 then: string-append("00", num-to-string(pokemon-id))
        | pokemon-id < 1000 then: string-append("0", num-to-string(pokemon-id))
        | otherwise: num-to-string(pokemon-id)
    end
where:
    id-to-4-digit-string(1) is "0001"
    id-to-4-digit-string(10) is "0010"
    id-to-4-digit-string(100) is "0100"
    id-to-4-digit-string(1000) is "1000"
end


fun img-pokemon(pokemon-id :: Number) -> Image:
    doc: "Dado o id de um pokemon, devolve a imagem deste pokemon."
    url = "https://raw.githubusercontent.com/HybridShivam/Pokemon/master/assets/thumbnails-compressed/" + id-to-4-digit-string(pokemon-id) + ".png"
    img = image-url(url)

    scale(0.75, img)
end


fun name-pokemon(pokemon-id :: Number) -> String:
    doc: "Dado o id de um pokemon, devolve o nome deste pokemon."
    tabela = filter-with(POKE-DATA, lam(row): row["id"] == pokemon-id end)

    tabela.row-n(0)["name"]
where:
    name-pokemon(1) is "Bulbasaur"
    name-pokemon(2) is "Ivysaur"
end


fun verifica-efeito(tipo-ataque :: TipoPokemon, tipo-defesa :: TipoPokemon) -> Efeito:
    doc: ```Dado o tipo de ataque e o tipo de defesa, devolve uma string indicando o efeito do ataque (sem efeito, não efetivo, efetivo ou super efetivo).
    Tabela de vantagens: https://pokemondb.net/type
    ```
    str-ataque = tipo-to-string(tipo-ataque)
    str-defesa = tipo-to-string(tipo-defesa)
    tabela = filter-with(EFFECTIVE-DATA, lam(row): row["Attacking"] == str-ataque end)
    num-effect = tabela.row-n(0)[str-defesa]

    ask:
        | num-effect == "0" then: SEM-EFEITO
        | num-effect == "0.5" then: NAO-EFETIVO
        | num-effect == "1" then: EFETIVO
        | num-effect == "2" then: SUPER-EFETIVO
    end
where:
    verifica-efeito(FIRE, GRASS) is SUPER-EFETIVO
    verifica-efeito(FIRE, WATER) is NAO-EFETIVO
    verifica-efeito(FIRE, ELECTRIC) is EFETIVO
end

fun barra-hp(p :: Pokemon) -> Image:
    doc: "Dado um pokemon, gera uma imagem da sua barra de pontos de vida (HP). A barra é verde se o HP for maior que 75%, amarela se o HP for maior que 25% e vermelha se o HP for menor ou igual a 25%."
    # Calcula a proporção de vida atual do Pokemon
    porcentagem-vida = p.hp / p.max-hp
    
    # Define a cor da barra baseada na porcentagem de vida
    cor = ask:
            | porcentagem-vida > 0.75 then: "green"
            | porcentagem-vida > 0.25 then: "yellow"
            | otherwise: "red"
        end
        
    # Cria a borda preta (contorno) para a barra de HP
    borda = rectangle(image-width(p.img), 20, "outline", "black")
    
    # Cria o preenchimento da barra de vida com a cor correspondente 
    # e a sobrepõe alinhada à esquerda dentro da borda para representar a proporção preenchida
    barra = overlay-align("left", "top", rectangle(image-width(p.img) * porcentagem-vida, 20, "solid", cor), borda)
    
    # Cria o texto que indica o HP no formato "Atual / Máximo"
    texto-hp = text("HP: " + num-to-string(p.hp) + " / " + num-to-string(p.max-hp), 10, "black")

    # Centraliza o texto sobre a barra e a retorna
    overlay-align("center", "center", texto-hp, barra)
end

fun desenha-pokemon(p :: Pokemon) -> Image:
    doc: "Dado um Pokemon, devolve uma imagem deste Pokemon."
    above(barra-hp(p), p.img)
end

fun um-ou-menos-1() -> Number:
    doc: "Devolve aleatoriamente 1 ou -1."
    if random(2) < 1:  1 else: -1 end
end

fun extrai-pokemon-tabela(id :: Number, table :: Table) -> Pokemon:
    doc: "Dado um id e uma tabela de pokemons, devolve o pokemon correspondente a este id nesta tabela."
    # Filtra a tabela procurando as linhas (rows) com o mesmo id fornecido
    # e assume o primeiro elemento encontrado usando a função .row-n(0)
    row = filter-with(table, lam(row): row["id"] == id end).row-n(0)
    # Cria e retorna a instância do Pokemon utilizando os dados obtidos da linha filtrada
    # (assumindo que inicialmente o hp atual e o max-hp sejam os mesmos)
    DX = random(100)
    DY = random(100)
    SOMA = DX + DY
    TIPO = string-to-tipo(row["type1"])

    pokemon(
        row["name"],
        row["id"],
        TIPO,
        random(LARG),
        random(ALT),
        ((DX / SOMA) * um-ou-menos-1()),
        ((DY / SOMA) * um-ou-menos-1()),
        row["speed"] / 10,
        row["hp"],
        row["hp"],
        img-pokemon(row["id"]),
        ataque("Tackle", TIPO, row["attack"] / 10)
    )
end

fun cria-time(tabela :: Table, lista-ids :: List<Number>) -> Time:
    doc: "Dada uma tabela de pokemons e uma lista de IDs, devolve um time com todos os pokemons desta tabela."
    cases (List<Number>) lista-ids:
        # Se a lista de IDs está vazia, o problema de gerar um time está resolvido: é um time vazio
        | empty => empty
        # Para uma lista de IDs com elementos:
        | link(f, r) => 
            link(
                # Busca-se na tabela o pokemon referente ao primeiro ID (`f`)
                extrai-pokemon-tabela(f, tabela),
                # E o adiciona na frente do time já criado a partir do resto da lista
                cria-time(tabela, r))
    end
end

fun efeito-to-multiplicador(e :: Efeito) -> Number:
    doc: "Dado um tipo de efeito, devolve o multiplicador de dano correspondente."
    ask:
        | e == SEM-EFEITO then: 0       # Absorve tudo (nenhum dano recebido)
        | e == NAO-EFETIVO then: 0.5    # Recebe apenas metade do dano (resistente)
        | e == EFETIVO then: 1          # Dano segue normal (neutro)
        | e == SUPER-EFETIVO then: 2    # Recebe o dobro do dano (fraqueza)
    end
where:
    efeito-to-multiplicador(SEM-EFEITO) is 0
    efeito-to-multiplicador(NAO-EFETIVO) is 0.5
    efeito-to-multiplicador(EFETIVO) is 1
    efeito-to-multiplicador(SUPER-EFETIVO) is 2
end

fun atualiza-hp(p :: Pokemon, valor :: Number) -> Pokemon:
    doc: "Dado um pokemon e um valor (positivo para cura ou negativo para dano), atualiza o hp (vida) do pokemon, respeitando os limites de hp mínimo (0) e máximo (hp-max)."
    # Calcula o novo hp avaliando se não passa dos limites estipulados de vida
    novo-hp = ask:
        | (p.hp + valor) < 0 then: 0 # Não pode ficar com hp negativo
        | (p.hp + valor) > p.max-hp then: p.max-hp # Não pode ter mais hp que o máximo permitido
        | otherwise: p.hp + valor # Atualização normal
    end
    # Obs: Linha comentada abaixo seria uma forma alternativa para garantir o limite de vida com funções
    # novo-hp = num-min(p.max-hp, num-max(0, p.hp + valor))

    # Reconstrói a estrutura Pokemon mantendo todos os dados e passando a vida ajustada (novo-hp)
    pokemon(p.nome, p.id, p.tipo, p.x, p.y, p.dx, p.dy, p.speed, novo-hp, p.max-hp, p.img, p.movimentos)
where:
    atualiza-hp(pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40)), -10) is pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 25, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40))
    atualiza-hp(pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 5, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40)), -10) is pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 0, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40))
    atualiza-hp(pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 30, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40)), +10) is pokemon("Pikachu", 25, ELECTRIC, 0, 0, 0, 0, 0, 35, 35, img-pokemon(25), ataque("Tackle", NORMAL, 40))
end
