

//1. Написать функции, которая:
//- Будет просто выводить в консоль ”Hello, world!”.
//- Будет принимать аргумент “имя” и выводить в консоль “Hello, имя” (вызов функции
//должен быть следующим - printHi(“Misha”)).
//- Будет принимать аргумент имя и возвращать строку приветствия “Hello! имя”.

print("\ntask1")
func printHelloWorld() {
    print("Hello world!")
}

printHelloWorld()

func printHi(_ name: String) {
    print("Hello, \(name)")
}

printHi("Misha")

func returnGreeting(name: String) -> String {
    return "Hello! \(name)"
}

let userGreeting = returnGreeting(name: "Pavel")
print(userGreeting)

//2. Написать функцию, которая принимает две строки и возвращает сумму количества
//символов двух строк.

print("\ntask2")
func countSymbolsInTwoStrings(_ str1: String, _ str2: String) -> String {
    return "Сумма количества символов в строках \(str1) и \(str2) равна \(str1.count + str2.count)"
}

print(countSymbolsInTwoStrings("Hello","World"))


//3. Написать функцию, которая выводит в консоль квадрат переданного числа.

print("\ntask3")
func printSquareOfNumber(_ number: Int) {
    print("Квадрат числа \(number) равен \(number * number)")
}

printSquareOfNumber(7)

//4. Создать функцию, которая принимает параметры и вычисляет площадь круга.

print("\ntask4")
func calculateCircleArea(radius: Double) {
    let result = (Double.pi * radius * radius * 100).rounded(.down)/100
    print("Площадь круга с радиусом \(radius) равна \(result)")
}
calculateCircleArea(radius: 3)


//5. Решить задачу сл вомнем суток с помощью функции
print("\ntask5")

func defineDayOrNight(for currentTime: Int) {
    if (currentTime >= 21 && currentTime <= 24) || (currentTime >= 0 && currentTime <= 7 ) {
        print("Сейчас ночь")
    } else if currentTime > 7 && currentTime < 21 {
        print("Сейчас день")
    } else {
        print("Неверное значение")
    }
}

defineDayOrNight(for: 2)
defineDayOrNight(for: 7)
defineDayOrNight(for: 8)
defineDayOrNight(for: 20)
defineDayOrNight(for: 21)

//6. Создать функцию, принимающую 1 аргумент — номер месяца (от 1 до 12), и
//возвращающую время года, которому этот месяц принадлежит (зима, весна, лето или
//осень).

print("\ntask6")
func getSeason(for month: Int) -> String {
    switch month {
    case 12, 1, 2:
        return "Зима"
    case 3, 4, 5:
        return "Весна"
    case 6, 7, 8:
        return "Лето"
    case 9, 10, 11:
        return "Осень"
    default:
        return "Неверный порядковый номер месяца"
    }
}

print(getSeason(for: 12))
print(getSeason(for: 3))
print(getSeason(for: 8))
print(getSeason(for: 10))
print(getSeason(for: 24))


//7. Разбить номер телефона на составляющие. Код страны, код оператора, сам номер.
//Используем функции строки: prefix, suffix.

print("\ntask7")
func splitPhoneNumber(_ phoneNumber: String) -> (countryCode: String, operatorCode: String, number: String) {
    let countryCode = String(phoneNumber.prefix(3))
    let operatorCode = String(phoneNumber.dropFirst(3).prefix(2))
    let number = String(phoneNumber.suffix(7))
    return (countryCode, operatorCode, number)
}

let phoneInfo = splitPhoneNumber("375296663311")
print("Код страны: \(phoneInfo.countryCode), Код оператора: \(phoneInfo.operatorCode), Номер: \(phoneInfo.number)")


//8*. Создать функцию, принимающую 1 аргумент — число от 0 до 100, и возвращающую
//true, если оно простое, и false, если сложное. Рекомендую попробовать решать рекурсией, чтобы разобраться как она работает.

print("\ntask8")

func isSimpleNumber(_ number: Int) -> Bool {
    if number < 2 { return false }
    for n in 2..<number {
        if(number % n == 0) {
            return false
        }
    }
    return true
}

print(isSimpleNumber(1))
print(isSimpleNumber(2))
print(isSimpleNumber(3))
print(isSimpleNumber(4))

//9*. Создать функцию, которая считает факториал введённого числа.

print("\ntask9")

func factorial(_ n: Int128) -> Int128 {
    if n <= 1 { return 1 }
 
    return n * factorial(n - 1)
}
//5*4*3*2*1

print("Факториал равен \(factorial(5))" )

//10*. Создать функцию, которая выводит все числа последовательности Фибоначчи до
//введённого индекса. Например fib(n:6) -> 0, 1, 1, 2, 3, 5, 8

print("\ntask10")


//11*. Создать функцию, которая считает сумму цифр четырехзначного числа,
//переданного в параметры функции (Int).

print("\ntask11")
 
func sumOfDigits(_ number: Int) -> Int {
    var n = abs(number)
    var sum = 0
    while n > 0 {
        sum += n % 10
        n /= 10
    }
    return sum
}

print(sumOfDigits(1234))
