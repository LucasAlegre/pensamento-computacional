use context starter2024



data Musico:
    musico(
        nome :: String,    # Nome do musico
        genero :: String, # Gênero musical
        gravadora :: String  # Gravadora do musico
     )
end

M1 = musico("Radiohead", "Rock", "Som Livre")
M2 = musico("Pedro", "Samba", "Universal")

fun atualiza-gravadora(m :: Musico,
                      gravadora-antiga :: String,
                      gravadora-nova :: String) -> Musico:
    doc: "..."
    ask:
        | M1.gravadora == "Som Livre" then: 
            musico("Radiohead", "Rock", "Universal")
        | otherwise: M1
    end

where:
    atualiza-gravadora(M1, "Som Livre", "Universal") is
     musico("Radiohead", "Rock", "Universal")
    atualiza-gravadora(M2, "Som Livre", "Universal") is M2
end
 
atualiza-gravadora(M1, "Som Livre", "Universal")