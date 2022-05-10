# Laços de Repetição
- for
```lua
    a = { 1, 2, 3, 4, 5 }

    for i = 1,5 do
        print(a[i]) -- 1, 2, 3, 4, 5
    end

    -- retorna como um key-value
    for i, value in ipairs(a) do
        print(i, value) -- indice, valor
    end
```