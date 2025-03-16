# переписать ниже примеры из первого часа из видеолекции: 
# https://youtu.be/4igzy3bGVkQ
# по желанию можно поменять значения и попробовать другие функции

println(10 + 3)
phbk = Dict("Jen" => 124, "Ga" => "few")
phbk["wesf"] = "ddwes"
println(phbk)
println(phbk["Jen"])
pop!(phbk, "Jen")
println(phbk)
cart = (2, 3, 5) #картеж неизменяемый
println(cart[1])
arr = ["fs", "fd", "dfss"]
push!(arr, "eesdf")#добавляет в конец
pop!(arr)#удаляет с конца

println(arr)

ranarr = rand(4, 3, 3)

println(ranarr)

n = 0
#push!(arr,n) #динамическая типизация не работает в пуш, 
println("/////////////////////")
arr2 = []
println(arr2)

while n < 10
    global n += 1# ??????????????????? не дает доступ к переменной/, нужно я вно указывать что она объявлена глоально, хотя в видео работало
    #print(n)
    #push!(arr,string(n)) #динамическая тепизация не работает в пуш, need convert to string
    #  короче, проблема возникает когда при объявлении присваеваешь глобальное значение
    push!(arr2, n) #но если объявлен пустой массив то нормально изменяет 
    arr2[n] = 2 # и с таким присваеванием тоже
end
println(arr)

n = 0
while n < 10
    global n += 1# ??????????????????? не дает доступ к переменной/, нужно я вно указывать что она объявлена глоально, хотя в видео работало
    #print(n)
    #push!(arr,string(n)) #динамическая тепизация не работает в пуш, need convert to string
    push!(arr2,n) #но если объявлен пустой массив то нормально изменяет 
    arr2[n] = 2
end
println(arr2)
 # итого динамическая типизация - ну такое

for a in arr
    println(a)
end

for n = 1:10 #где на клвиатуре найти знак Е...
    print(n)
end

arr3 = zeros(5,5)
#println(arr3)

for i in 1:5
    for j in 1:5
    arr3[i,j] = i+j
    end
end
println("???????????")


for i in 1:5, j in 1:5
    arr3[i,j] = i-j # занимательно
end
println(arr3)
# interesting
x = 13
y = 17
if x>y
    x
elseif x<y
   y
else
 x+y
end

#x*y # output?!
#"gread" #okeey  выводит через раз?????
#(x > y) ? string(x) : string(y)# почему ошибка? cannot document the following expression:
#(x > y) ? string("ret") : string("ter") #короче вывод без принт баловство, работает через раз
println((x>y) ? string(7) : string(5))

#x == y && 4 # но вот такое работает,
# корчое вот такое вывод работает только если функция вызывается последней? 
# работает такой вывод непредсказуемо и нестабильно
# dont use output without print!!!

function f(x)
     x = x + y +9 #можно дергать глобальные функции явно через global и не явно, но там как повезет
    println(x)
    end 

f(1)

f1 = name -> "Ds$name" # нечитаемо
f1(3) # а получается функции можно прям из терминала дергать
# функции с ! изменяют входные данные
# функции с . будут применятся с каждому объекту масиива, а не к массиву целиком  

#pal = distinguishable_colors(100)
u = -3:0.1:3
f2(u) = u^2
p = f2.(u)
println(p)

pp = plot(u,p,label="line")
scatter!(u,p, label="points")
xlabel!("X")
ylabel!("Y")
title!("y=x^2")
#println("??????????")
arr4 = rand(6)
arr5 = rand(6)
plot(arr4,arr5, legend=false)
scatter!(arr4,arr5, legend=false)
k=-3:0.1:3
p1 = plot(k,k)
p2 = plot(k,k.^2)
p3 = plot(k,k.^3)
p4 = plot(k,k.^4)

#show(p1)
#show(p2)
#show(p3)
#plot(p1,p2,p3,p4,layout=(2,2),legend=false)
#выводится только последний вызванный график
#import Base:+
#+(x::String, y::String) = string(x,y)

#"hello" + "world@S"


#f4(x,y) = println("generous")
#f4(x::Int, y::Float64) = println("int+float64")
#f4(x::Float64, y::Float64) = println("float64+float64")
#f4(x::Int, y::Int) = println("int+int")
#f4(1,false)

#a = rand(3,3)
#println(a)
#A = a'+a
#println(A)
# ну прикольно, но вот работа с типами и не очевидность вывода слегка напрягают
#test push