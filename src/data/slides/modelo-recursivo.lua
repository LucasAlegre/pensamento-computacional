-- Filtro do modelo da solução recursiva (ver .modelo-recursivo em pensamento.scss).
-- Quando uma caixa aparece por fragmento (ela ou o seu caso .trivial/.dificil
-- tem .fragment), o texto dela vira um fragmento à parte: a caixa surge vazia e
-- o texto entra no clique seguinte, para perguntar à turma o que vai dentro.

local caixas = { cond = true, res = true, sub = true, sol = true, comb = true }

local function eh_caixa(span)
  for _, classe in ipairs(span.classes) do
    if caixas[classe] then return true end
  end
  return false
end

local function caso(div)
  if not (div.classes:includes("trivial") or div.classes:includes("dificil")) then
    return nil
  end
  local caso_fragmento = div.classes:includes("fragment")
  return div:walk {
    Span = function(span)
      if eh_caixa(span) and (caso_fragmento or span.classes:includes("fragment")) then
        span.content = { pandoc.Span(span.content, { class = "fragment" }) }
        return span
      end
    end,
  }
end

function Div(div)
  if div.classes:includes("modelo-recursivo") then
    return div:walk { Div = caso }
  end
end
