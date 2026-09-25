use context dcic2024

include csv
include data-source
import math as M
import statistics as S
import lists as L


# List as Collective Data

song-list = [list: lver, so, wnkkhs]
check:
  song-list.length() is 3
  song-list.first is lver
end


fun oldest-song(sl :: List<ITunesSong>) -> ITunesSong:
  cases (List) sl:
    | empty => raise("not defined for empty song lists")
    | link(f, r) =>
      cases (List) r:
        | empty => f
        | else =>
          osr = oldest-song(r)
          if osr.year < f.year:
            osr
          else:
            f
          end
      end
  end
end

fun oldest-song-age(sl :: List<ITunesSong>) -> Number:
  os = oldest-song(sl)
  song-age(os)
where:
  oldest-song-age(song-list) is 71
end
