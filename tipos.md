# Tipos
- nil (padrão)
```lua
    print(var_nao_definida) -- -> nil
    type(var_nao_definida) -- -> nil
```
- boolean
```lua
    souBrasileiro = false
    type(souBrasileiro) -- boolean
```
- number
```lua
    -- não diferencia inteiro de float
    ano = 2022
    pi = 3.14
```
- string
```lua
    -- strings imutáveis por padrão
    nome = "ropoko"
    #nome -- retorna o tamanho da string (6)
```
- function
```lua
    a = function() then
        print("ola")
    end
    type(a) -- function
```
- table (arrays)
```lua
    nomes = { "Luis", "Roberto", "Rodrigo" }
    #nomes -- retorna o length (3)
    
    -- Arrays em lua começam em 1
    nomes[1] -- Luis

    for i, value in ipairs(a) do
        print(i, value) -- indice, valor
    end
```

- table (dicionarios)
```lua
    local a = {
        ["user"] = "teste",
        ["user2"] = "teste2"
        -- ou
        user1 = "teste1",
        user3 = "teste3"
    }

    print(a["user2"]) -- teste2
    print(a.user) -- teste

    for key,value in pairs(a) do
        print(key, value) -- chave, valor
    end
```