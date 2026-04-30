import UIKit

//Конвертер валют с обработкой ошибок:
//
//    Создайте enum Currency с кейсами для USD, EUR, BYN. Каждому кейсу присвойте rawValue типа String с соответствующим кодом валюты.
//    Создайте функцию getExchangeRate(from: Currency, to: Currency) -> Double?, которая принимает две валюты и возвращает курс обмена между ними. Если для какой-то пары валют курс не найден, функция должна возвращать nil.
//  Создайте функцию convertCurrency(amount: Double, from: Currency, to: Currency) -> Double?, которая принимает сумму, исходную валюту и целевую валюту и возвращает сконвертированную сумму. Используйте функцию getExchangeRate для получения курса обмена. Если курс обмена не найден, функция должна возвращать nil.

print("\ntask 1")
enum Currency: String {
    case USD = "USD"
    case EUR = "EUR"
    case BYN = "BYN"
}

func getExchangeRate(from: Currency, to: Currency) -> Double? {
    if from == .USD && to == .EUR {
        return 0.85
    } else if from == .EUR && to == .USD {
        return 1.16
    } else if from == .BYN && to == .USD {
        return 0.36
    } else if from == .USD && to == .BYN {
        return 2.82
    } else if from == .BYN && to == .EUR {
        return 0.3
    } else if from == .EUR && to == .BYN {
        return 3.3
    }
    return nil
}

func convertCurrency(amount: Double, from: Currency, to: Currency) -> Double? {
    guard let rate = getExchangeRate(from: from, to: to) else {
        return nil
    }
    return amount * rate
}

print(convertCurrency(amount: 5, from: .USD, to: .BYN))
print(convertCurrency(amount: 5, from: .EUR, to: .BYN))
print(convertCurrency(amount: 5, from: .BYN, to: .USD))


print("\ntask 2")

//Анализатор результатов экзамена:
// 
//•   Создайте enum Grade с кейсами A, B, C, D, F.  Каждому кейсу присвойте rawValue типа Int, представляющий числовой балл (например, A = 90, B = 80 и т.д.).
//•   Создайте функцию getLetterGrade(score: Int) -> Grade?, которая принимает числовой балл (Int) и возвращает соответствующую буквенную оценку (Grade).  Если балл находится вне допустимого диапазона (например, меньше 0 или больше 100), функция должна возвращать nil.  Реализуйте логику определения оценки на основе диапазонов баллов (например, 90-100 -> A, 80-89 -> B и т.д.).
//•   Создайте функцию printExamResult(name: String, score: Int) -> String, которая принимает имя студента (String) и его балл (Int) и возвращает строку с результатом экзамена. Используйте функцию getLetterGrade для получения буквенной оценки.
//
//    •   Если функция getLetterGrade возвращает оценку, строка должна иметь формат: "[Имя студента] получил [Буквенная оценка] (Балл: [Числовой балл])".
//    •   Если функция getLetterGrade возвращает nil, строка должна иметь формат: "[Имя студента] получил недопустимый балл: [Числовой балл]".


enum Grade: Int {
    case A = 90
    case B = 80
    case C = 70
    case D = 60
    case F = 50
}

func getLetterGrade(score: Int) -> Grade? {
    if score >= 90 && score <= 100 {
        return Grade.A
    } else if score >= 80 && score <= 89 {
        return Grade.B
    } else if score >= 70 && score <= 80 {
        return Grade.C
    } else if score >= 60 && score <= 70 {
        return Grade.D
    } else if score >= 0 && score <= 60 {
        return Grade.F
    } else {
        return nil
    }
}

func printExamResult(name: String, score: Int) -> String {
    guard let unwrappedScore = getLetterGrade(score: score) else {
        return "\(name) получил недопустимый балл: \(score)"
    }
    return "\(name) получил \(unwrappedScore) (Балл: \(score))"
}

print(printExamResult(name: "Kate", score: 101))
print(printExamResult(name: "Max", score: 100))
print(printExamResult(name: "Mike", score: 90))
print(printExamResult(name: "Lena", score: 89))
print(printExamResult(name: "Vasya", score: 80))
print(printExamResult(name: "Misha", score: 79))
print(printExamResult(name: "Kolya", score: 70))
print(printExamResult(name: "Andrew", score: 69))
print(printExamResult(name: "Oleg", score: 60))
print(printExamResult(name: "Denys", score: 59))
print(printExamResult(name: "Nastya", score: 0))
print(printExamResult(name: "Anton", score: -10))
