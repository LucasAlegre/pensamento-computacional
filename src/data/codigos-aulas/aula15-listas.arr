use context dcic2024

l1 = [list: 1, 2, 3]
e1 :: Number = l1.first
l2 = l1.rest
e2 = l2.first
l3 = l2.rest
e3 = l3.first
l4 = l3.rest

check:
  e1 is 1
  e2 is 2
  e3 is 3
  l2 is [list: 2, 3]
  l3 is [list: 3]
  l4 is empty
end


# Construindo listas

link(1, link(2, link(3, empty)))

check:
  [list: 1, 2, 3] is link(1, link(2, link(3, empty)))
end


fruits = link("apple", link("banana", link("cherry", empty)))

# After doing this exercise, you might wonder why anyone would use the link form: it’s more verbose, and makes the individual elements harder to discern. This form is not very convenient to humans. But it will prove very valuable to programs!

fun my-len(l):
  cases (List) l:
    | empty      => 0
    | link(f, r) => 1 + my-len(r)
  end
end

fun my-sum(l):
  cases (List) l:
    | empty      => 0
    | link(f, r) => f + my-sum(r)
  end
end

fun my-doubles(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      link(f * 2, my-doubles(r))
  end
end

fun my-str-len(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      link(string-length(f), my-str-len(r))
  end
end

fun my-pos-nums(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      if f > 0:
        link(f, my-pos-nums(r))
      else:
        my-pos-nums(r)
      end
  end
end

fun my-alternating(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      cases (List) r: # note: deconstructing r, not l
        | empty =>    # the list has an odd number of elements
          [list: f]
        | link(fr, rr) =>
          # fr = first of rest, rr = rest of rest
          link(f, my-alternating(rr))
      end
  end
end


# Structural Problems Over Relaxed Domains

fun my-max(l):
  cases (List) l:
    | empty      => raise("not defined for empty lists")
    | link(f, r) => num-max(f, my-max(r))
  end
end

fun my-max2(l):
  cases (List) l:
    | empty      => raise("not defined for empty lists")
    | link(f, r) =>
      cases (List) r:
        | empty => f
        | else  => num-max(f, my-max2(r))
      end
  end
end

fun my-avg(l):
  my-sum(l) / my-len(l)
end


# Structural problems wiht accumulators

fun my-rs(acc, l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      new-sum = acc + f
      link(new-sum, my-rs(new-sum, r))
  end
end

fun my-running-sum(l):
  my-rs(0, l)
end

fun uniq-rec(l :: List<Any>) -> List<Any>:
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      if r.member(f):
        uniq-rec(r)
      else:
        link(f, uniq-rec(r))
      end
  end
end

fun uniq-rec2(l :: List<Any>) -> List<Any>:
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      ur = uniq-rec2(r)
      if r.member(f):
        ur
      else:
        link(f, ur)
      end
  end
end

fun uniq-rec3(l :: List<Any>) -> List<Any>:
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      ur = uniq-rec3(r)
      if ur.member(f):
        ur
      else:
        link(f, ur)
      end
  end
end


# Dados recursivos

data NumList:
  | nl-empty
  | nl-link(first :: Number, rest :: NumList)
end

nl-empty
nl-link(3, nl-empty)
nl-link(7, nl-link(3, nl-empty))
nl-link(2, nl-link(7, nl-link(3, nl-empty)))

# Funções para processar dados recursivos

fun contains-3(nl :: NumList) -> Boolean:
  cases (NumList) nl:
    | nl-empty => false
    | nl-link(first, rest) =>
      if first == 3:
        true
      else:
        contains-3(rest)
      end
  end
end


fun my-reverse(l :: List<Any>) -> List<Any>:
  cases (List<Any>) l:
    | empty => empty
    | link(f, r) =>
      append(my-reverse(r), link(f, empty))
  end
end

# Template:

#|
fun num-list-fun(nl :: NumList) -> ???:
  cases (NumList) nl:
    | nl-empty => ...
    | nl-link(first, rest) =>
      ... first ...
      ... num-list-fun(rest) ...
  end
end
|#