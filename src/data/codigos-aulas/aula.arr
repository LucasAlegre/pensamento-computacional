use context starter2024

data Playlist:
    | vazia
    | b(f :: String, r :: Playlist)
end

b("Musica", b("Musica 2", vazia))

fun adiciona-exclamacao(l :: List<Number>) -> List<String>:
    doc: "Dado uma lista de strings, adiciona ! a todas as strings."

    cases (List<String>) l:
        | empty => empty
        | link(f, r) => 
            link(number-to-string(f), adiciona-exclamacao(r))
    end

where:
    adiciona-exclamacao(empty) is empty
    adiciona-exclamacao(link("a", link("b", empty))) is [list: "a!", "b!"]
end

data EstadoSemaforo:
    | VERMELHO
    | AMARELO
    | VERDE
end

fun aviso-semaforo(e :: EstadoSemaforo) -> String:
    doc: "Dado um estado de semáforo, retorna o aviso correspondente."
    cases (EstadoSemaforo) e:
        | VERMELHO => "Pare!"
        | AMARELO => "Atenção!"
        | VERDE => "Vá!"
    end
end