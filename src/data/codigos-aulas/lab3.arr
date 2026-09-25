use context starter2024
# =============================================================================
# DATA DEFINITIONS
# =============================================================================

# A NumList is one of:
# - nl-empty
# - nl-link(f, r), where
#     f :: Number  -- the first element of the list
#     r :: NumList -- the rest of the list
#
# Interpretation:
#   Represents a list of numbers.
data NumList:
  | nl-empty
  | nl-link(first :: Number, rest :: NumList)
end

# Template for functions on NumList:
# fun fn-for-numlist(ln :: NumList) -> ...:
#   cases (NumList) ln:
#     | nl-empty => ...
#     | nl-link(f, r) => ... f ... fn-for-numlist(r) ...
#   end
# end


# A Forma is (forma(n, t, c, a)), where:
#   n :: String   -- the name of the shape
#   t :: String   -- the type of the shape, one of:
#                    "retângulo", "triângulo", "círculo", "estrela"
#   c :: String   -- the color of the shape
#   a :: NumList  -- list of numeric arguments depending on t:
#                    - "retângulo": largura, altura
#                    - "triângulo": lado
#                    - "círculo": raio
#                    - "estrela": num-pontas, raio-interno, raio-externo
data Forma:
  | forma(nome :: String, tipo :: String, cor :: String, args :: NumList)
end


# A FormaLista is one of:
# - f-empty
# - f-link(f, r), where
#     f :: Forma       -- the first shape
#     r :: FormaLista  -- the rest of the list
data FormaLista:
  | f-empty
  | f-link(first :: Forma, rest :: FormaLista)
end

# Template for functions on FormaLista:
# fun fn-for-formalista(lf :: FormaLista) -> ...:
#   cases (FormaLista) lf:
#     | f-empty => ...
#     | f-link(f, r) => ... fn-for-forma(f) ... fn-for-formalista(r) ...
#   end
# end


# =============================================================================
# EXAMPLES
# =============================================================================

ln1 = nl-link(30, nl-link(60, nl-empty))
r1 = forma("r1", "retângulo", "blue", ln1)
l1 = f-link(r1, f-link(r1, f-empty))


# =============================================================================
# FUNCTIONS
# =============================================================================

fun desenha-retangulo(ln :: NumList, cor :: String) -> Image:
  doc: "Given a NumList with two elements [largura, altura] and a color, produces a solid rectangle image."
  rectangle(ln.first, ln.rest.first, "solid", cor)
end


fun desenha(f :: Forma) -> Image:
  doc: "Consumes a Forma and produces an image representing it."
  ask:
    | f.tipo == "retângulo" then: desenha-retangulo(f.args, f.cor)
    # You can extend this later:
    # | f.tipo == "círculo" then: circle(f.args.first, "solid", f.cor)
    # | f.tipo == "triângulo" then: triangle(f.args.first, "solid", f.cor)
  end
where:
  desenha(r1) is rectangle(30, 60, "solid", "blue")
end


fun desenha-lista-formas(lf :: FormaLista) -> Image:
  doc: "Consumes a FormaLista and draws all shapes side by side."
  cases (FormaLista) lf:
    | f-empty => empty-image
    | f-link(f, r) => beside(desenha(f), desenha-lista-formas(r))
  end
where:
  desenha-lista-formas(l1) is beside(desenha(r1), desenha(r1))
end


fun conta-formas-tipo(lf :: FormaLista, tipo :: String) -> Number:
  doc: "Counts how many shapes of a given type exist in a FormaLista."
  cases (FormaLista) lf:
    | f-empty => 0
    | f-link(f, r) =>
        (if f.tipo == tipo: 1 else: 0 end) + conta-formas-tipo(r, tipo)
  end
where:
  conta-formas-tipo(l1, "retângulo") is 2
  conta-formas-tipo(f-empty, "retângulo") is 0
end
