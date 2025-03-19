module GameOfLife
using Plots

mutable struct Life
    current_frame::Matrix{Int}
    next_frame::Matrix{Int}
end

# Функция для одного шага игры "Жизнь"
function step!(state::Life)
    curr = state.current_frame
    next = state.next_frame

    # Создаем массив соседей с помощью сдвигов (тороидальные границы)
    neighbors = zeros(Int, size(curr))
    shifts = ((-1, -1), (-1, 0), (-1, 1),
              (0, -1),         (0, 1),
              (1, -1), (1, 0), (1, 1))

    # Подсчитываем количество живых соседей для каждой клетки
    for (di, dj) in shifts
        neighbors .+= circshift(curr, (di, dj))
    end

    # Применяем правила "Игры Жизнь"
    next .= (curr .== 1) .& ((neighbors .== 2) .| (neighbors .== 3)) .|   # Живая клетка
            (curr .== 0) .& (neighbors .== 3)  # Мёртвая клетка, которая становится живой

    # Обновляем состояние
    state.current_frame .= next

    return nothing
end

# Главная функция для анимации
function main()
    n = 30
    m = 30
    init = rand(0:1, n, m)  # Инициализация случайной сетки

    game = Life(init, zeros(n, m))

    # Анимация
    anim = @animate for time = 1:100
        step!(game)
        cr = game.current_frame
        heatmap(cr)
    end
    gif(anim, "life.gif", fps = 10)
end

export main

end

# Запуск игры
using .GameOfLife
GameOfLife.main()
