LARGURA_TELA = 320
ALTURA_TELA = 480
MAX_METEOROS = 12

nave = {
    src = "imagens/nave.png",
    largura = 55,
    altura = 63,
    x = LARGURA_TELA / 2,
    y = ALTURA_TELA - 64,
    tiros = {}
}

function atirar()
    musica_disparo:play()

    local tiro = {
        x = nave.x + nave.largura/2,
        y = nave.y,
        largura = 16,
        altura = 16
    }

    table.insert(nave.tiros, tiro)
end

function moveTiros()
    for i = #nave.tiros, 1, -1 do
        if nave.tiros[i].y > 0 then
            nave.tiros[i].y = nave.tiros[i].y - 1
        else
            table.remove(nave.tiros, i)
        end
    end
end

function destroi_nave()

    musica_destruicao:play()
    nave.src = "imagens/explosao_nave.png"
    nave.imagem = love.graphics.newImage(nave.src)
    nave.largura = 67
    nave.altura = 77
end

meteoros = {} 

function tem_colisao(x1, y1, l1, a1, x2, y2, l2, a2)
    return 
        x2 < x1 + l1 and
        x1 < x2 + l2 and
        y1 < y2 + a2 and
        y2 < y1 + a1
end

function troca_musica_fundo()
    musica_ambiente:stop()
    musica_game_over:play()
end

function checa_colisao_nave()
    for k,meteoro in pairs(meteoros) do
        if tem_colisao(meteoro.x, meteoro.y, meteoro.largura, meteoro.altura,
            nave.x, nave.y, nave.largura, nave.altura) then
            
            troca_musica_fundo()
            destroi_nave()
            FIM_JOGO = true
        end
    end
end

function checa_colisao_tiros()
    for i = #nave.tiros, 1, -1 do
        for j = #meteoros, 1, -1 do
            if tem_colisao(nave.tiros[i].x, nave.tiros[i].y, nave.tiros[i].largura, nave.tiros[i].altura,
            meteoros[j].x, meteoros[j].y, meteoros[j].largura, meteoros[j].altura) then
                table.remove(nave.tiros, i)
                table.remove(meteoros, j)
                break
            end
        end
    end
end

function checa_colisoes()
    checa_colisao_nave()
    checa_colisao_tiros()
end

function cria_meteoro()
    local meteoro = {
        x = math.random(LARGURA_TELA),
        y = -70,
        largura = 50,
        altura = 44,
        peso = math.random(3),
        deslocamento_horizontal = math.random(-1, 1)
    }

    table.insert(meteoros, meteoro)
end

function remove_meteoros()
    for i = #meteoros, 1, -1 do
        if meteoros[i].y > ALTURA_TELA then
            table.remove(meteoros, i)
        end
    end
end

function move_meteoros()
    for k,meteoro in pairs(meteoros) do
        meteoro.y = meteoro.y + meteoro.peso
        meteoro.x = meteoro.x + meteoro.deslocamento_horizontal
    end
end

function move_nave()
    if love.keyboard.isDown('w') then
        nave.y = nave.y - 1
    end
    if love.keyboard.isDown('s') then
        nave.y = nave.y + 1
    end
    if love.keyboard.isDown('a') then
        nave.x = nave.x - 1
    end
    if love.keyboard.isDown('d') then
        nave.x = nave.x + 1
    end
end

function love.load()
    love.window.setMode(LARGURA_TELA, ALTURA_TELA, { resizable = false })
    love.window.setTitle("Game #1")

    -- define o valor da máquina como valor inicial para cálculo do random
    math.randomseed(os.time())

    background = love.graphics.newImage("imagens/background.png")
    nave.imagem = love.graphics.newImage(nave.src)
    meteoro_img = love.graphics.newImage("imagens/meteoro.png")
    tiro_img = love.graphics.newImage("imagens/tiro.png")

    musica_destruicao = love.audio.newSource("audios/destruicao.wav", "static")
    musica_game_over = love.audio.newSource("audios/game_over.wav", "static")
    musica_disparo = love.audio.newSource("audios/disparo.wav", "static")

    musica_ambiente = love.audio.newSource("audios/ambiente.wav", "static")
    musica_ambiente:setLooping(true)
    musica_ambiente:play()
end

function love.update(dt)
    if not FIM_JOGO then
        if love.keyboard.isDown('w', 'a', 's', 'd') then 
            move_nave()
        end
    
        remove_meteoros()
    
        if #meteoros < MAX_METEOROS then
            cria_meteoro()        
        end
    
        move_meteoros()
        moveTiros()
        checa_colisoes()
    end
end

function love.keypressed(tecla)
    if tecla == "escape" then
        love.event.quit()
    elseif tecla == "space" then
        atirar()
    end
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(nave.imagem, nave.x, nave.y)

    for k,meteoro in pairs(meteoros) do
        love.graphics.draw(meteoro_img, meteoro.x, meteoro.y)
    end

    for k,tiro in pairs(nave.tiros) do
        love.graphics.draw(tiro_img, tiro.x, tiro.y)
    end
end
