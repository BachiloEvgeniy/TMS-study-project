import UIKit


//1. Разработка иерархии классов для геометрических фигур:
//
//  •  Создайте базовый класс Shape с общими свойствами (например, цвет) и методом calculateArea().
//  •  Создайте подклассы Circle, Rectangle, Triangle, наследующиеся от Shape.
//  •  Переопределите метод calculateArea() в каждом подклассе для вычисления площади соответствующей фигуры.
//  •  Добавьте свойства, специфичные для каждой фигуры (например, радиус для круга, длина и ширина для прямоугольника).
//  •  Создайте массив объектов типа Shape и выведите площадь каждой фигуры.

class Shape {
    let color: String
    
    init(color: String) {
        self.color = color
    }
    
    func calculateArea() {
        print("This is base method")
    }
}

class Circle: Shape {
    let radius: Double
    
    init(color: String, radius: Double) {
        self.radius = radius
        super.init(color: color)
    }
    
    override func calculateArea() {
        print("Area of circle: \(Double.pi * radius * radius)")
    }
}

class Rectangle: Shape {
    let width: Double
    let height: Double
    
    init(color: String, width: Double, height: Double) {
        self.width = width
        self.height = height
        super.init(color: color)
    }
    
    override func calculateArea() {
        print("Area of Rectangle: \(width * height)")
    }
}

class Triangle: Shape {
    let base: Double
    let height: Double
    
    init(color: String, base: Double, height: Double) {
        self.base = base
        self.height = height
        super.init(color: color)
    }
    
    override func calculateArea() {
        print("Area of Triangle: \(0.5 * base * height)")
    }
}

let cirle = Circle(color: "red", radius: 5)
let rectangle = Rectangle(color: "blue", width: 4, height: 6)
let triangle = Triangle(color: "green", base: 8, height: 3)

[cirle, rectangle, triangle].forEach{$0.calculateArea()}


//•  Создайте структуру Contact со свойствами:
//   *  firstName (String)
//   *  lastName (String)
//   *  phoneNumber (String)
//   *  email (String?) (опциональный email).
// •  Создайте функцию, которая принимает массив структур Contact и строку для поиска. Функция должна возвращать новый массив Contact, содержащий только те контакты, у которых имя или фамилия содержат строку для поиска (без учета регистра).

struct Contact {
    let firstName: String
    let lastName: String
    let phoneNumber: String
    let email: String?
}

let max: Contact = Contact(firstName: "Max", lastName: "Tors", phoneNumber: "+375299999999", email: nil)
let nina: Contact = Contact(firstName: "Nina", lastName: "James", phoneNumber: "+375298888888", email: "james@gmail.com")
let vova: Contact = Contact(firstName: "Vova", lastName: "Kollin", phoneNumber: "+375297777777", email: nil)
let vera: Contact = Contact(firstName: "Vera", lastName: "Kovalenko", phoneNumber: "+375296666666", email: "vera@gmail.com")
let sam: Contact = Contact(firstName: "Sam", lastName: "Igorev", phoneNumber: "+375295555555", email: "sam@gmail.com")
let sara: Contact = Contact(firstName: "Sara", lastName: "Walker", phoneNumber: "+375294444444", email: "sara@gmail.com")
let mike: Contact = Contact(firstName: "Mike", lastName: "Kovalenko", phoneNumber: "+375293333333", email: "mike@gmail.com")
let masha: Contact = Contact(firstName: "Masha", lastName: "Kovalenko", phoneNumber: "+375292222222", email: "masha@gmail.com")

let contacts: [Contact] = [max, nina, vova, vera, sam, sara, mike, masha]

let a = "John"
print(a.lowercased())

func findContact(by name: String, in contacts: [Contact]) -> [Contact] {
   return contacts.filter{$0.firstName.lowercased().contains(name.lowercased()) || $0.lastName.lowercased().contains(name.lowercased())}
}

print(findContact(by: "koval", in: contacts))
print(findContact(by: "ma", in: contacts))
