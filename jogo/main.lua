LARGURA_TELA = 320
ALTURA_TELA = 480
MAX_METEOROS = 12

nave = {
    src = "imagens/nave.png",
    largura = 55,
    altura = 63,
    x = LARGURA_TELA / 2,
    y = ALTURA_TELA - 64
}

function destroi_nave()
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

function checa_colisoes()
    for k,meteoro in pairs(meteoros) do
        if tem_colisao(meteoro.x, meteoro.y, meteoro.largura, meteoro.altura,
            nave.x, nave.y, nave.largura, nave.altura) then
            destroi_nave()
            FIM_JOGO = true
        end
    end
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
        checa_colisoes()
    end
end

function love.draw()
    love.graphics.draw(background, 0, 0)
    love.graphics.draw(nave.imagem, nave.x, nave.y)

    for k,meteoro in pairs(meteoros) do
        love.graphics.draw(meteoro_img, meteoro.x, meteoro.y)
    end
end
