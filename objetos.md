# Definindo objetos através de Tables
```lua
    user = {
        anoNascimento = 2000,
        cidade = "SP",
        parentes = { "pai", "mae" },
        imprime = function(self) 
            for k,v in ipairs(self.parentes) do 
                print(k,v)
            end
        end
    }

    user.imprime(user)
    user:imprime() -- sugar syntax para o de cima
```