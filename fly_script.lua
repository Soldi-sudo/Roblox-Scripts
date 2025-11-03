-- Fly Script by YourChannelName
-- Активация: Z (летать), X (сбросить скорость), C (увеличить скорость), V (уменьшить скорость)

loadstring(game:HttpGet('https://raw.githubusercontent.com/IsThisMe01/Project-Madara/refs/heads/main/loader.lua'))();

-- Дождись загрузки основной библиотеки и затем выполняем Fly
repeat wait() until _G.Madara

-- Активируем функцию полета
_G.Madara.GetLibrary("Fly").Toggle()