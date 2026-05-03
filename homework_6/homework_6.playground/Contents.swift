//
//Вам предстоит разработать систему для обработки данных о студентах. Система должна уметь:
//
//1.  Хранить информацию о студентах: Для каждого студента необходимо хранить следующую информацию:
//    *   Имя (String)
//    *   Возраст (Int)
//    *   Оценки по предметам (Dictionary, где ключ - название предмета (String), значение - оценка (Int))
//    *   Набор (Set) посещенных факультативов (String)
//
//    Используйте кортеж для представления данных об одном студенте: (name: String, age: Int, grades: [String: Double], optionalSubjects: Set<String>)
//
//2.  Создать массив студентов: Создайте массив, содержащий данные о нескольких студентах (минимум 5).
//
//3.  Реализовать функции для обработки данных:
//    *   calculateAverageGrade(student: Student) -> Double?: Функция должна принимать кортеж студента и возвращать его средний балл по всем предметам. Если у студента нет оценок, функция должна вернуть nil.
//
//    *   findStudentsByAge(students: [Student], age: Int) -> [Student]: Функция должна принимать массив студентов и возраст, и возвращать новый массив, содержащий только студентов указанного возраста. Используйте функцию высшего порядка filter.
//
//    *   getTopStudents(students: [Student], top: Int) -> [(name: String, averageGrade: Double)]: Функция должна принимать массив студентов и количество "top", и возвращать массив кортежей (name: String, averageGrade: Double), содержащий информацию о "top" лучших студентах по среднему баллу.  Используйте функции высшего порядка map, filter, sorted и prefix. Если для каких-то студентов не удалось вычислить средний балл (отсутствуют оценки) - их учитывать не нужно.
//
//    *   getUniqueOptionalSubjects(students: [Student]) -> Set<String>:  Функция должна принимать массив студентов и возвращать множество, содержащее все уникальные названия факультативов, которые посещают студенты из массива. Используйте функцию высшего порядка reduce или flatMap.
//
//4.  Вывести результаты: Выведите на консоль:
//
//    *   Информацию о всех студентах (имя, возраст, средний балл, посещаемые факультативы).
//    *   Список студентов определенного возраста (например, 20 лет).
//    *   Список топ-3 лучших студентов по среднему баллу.
//    *   Список всех уникальных факультативов, посещаемых студентами.
//
//Бонус:
//•  Реализуйте функцию, которая будет находить студента с самым большим количеством посещаемых факультативов.

typealias Student = (name: String, age: Int, grades: [String: Int], optionalSubjects: Set<String>)

let Mike: Student = (name: "Mike", age: 20, grades: ["Math": 7, "History": 6, "English": 9, "Geographic": 8, "Music": 7], optionalSubjects: ["Biology", "Chemistry"])
let Nina: Student = (name: "Nina", age: 22, grades: ["Math": 8, "History": 7, "English": 8, "Geographic": 9, "Music": 6], optionalSubjects: ["Biology", "Chemistry", "Physics"])
let Tom: Student = (name: "Tom", age: 21, grades: ["Math": 6, "History": 5, "English": 7, "Geographic": 6, "Music": 8], optionalSubjects: ["Biology"])
let Sam: Student = (name: "Sam", age: 20, grades: ["Math": 9, "History": 9, "English": 9, "Geographic": 9, "Music": 9], optionalSubjects: ["Biology", "Chemistry", "Physics", "Computer Science"])
let John: Student = (name: "John", age: 20, grades: ["Math": 7, "History": 5, "English": 8, "Geographic": 5, "Music": 7], optionalSubjects: ["Physics", "Computer Science"])
let Masha: Student = (name: "Masha", age: 21, grades: [:], optionalSubjects: [])


let students: [Student] = [Mike, Nina, Tom, Sam, John, Masha]

print("______calculateAverageGrade______\n")

func calculateAverageGrade(student: Student) -> Double? {
    if student.grades.isEmpty {
        return nil
    }
    let sum = student.grades.values.reduce(0){ partialResult, number in
         partialResult + number }
    
    return Double(sum) / Double(student.grades.count)
}


func printAllStudents(students: [Student]){
    for student in students {
        print("Имя: \(student.name), возраст: \(student.age), средний балл: \(calculateAverageGrade(student: student) ?? 0.0), посещаемые факультативы: \(student.optionalSubjects)")
    }
}

printAllStudents(students: students)

print("\n______findStudentsByAge______\n")

func findStudentsByAge(students: [Student], age: Int) -> [Student] {
    return students.filter { student in
        student.age == age
    }
}

print(findStudentsByAge(students: students, age: 20))

print("\n______getTopStudents______\n")

func getTopStudents(students: [Student], top: Int) -> [(name: String, averageGrade: Double)] {
    let result = students
        .compactMap { student -> (name: String, averageGrade: Double)? in
            guard let avg = calculateAverageGrade(student: student) else {
                return nil
            }
            return (name: student.name, averageGrade: avg)
        }
        .sorted { student1, student2 in
            student1.averageGrade > student2.averageGrade
        }
        .prefix(top)
    
    return(Array(result))

}

print(getTopStudents(students: students, top: 3))

print("\n______getUniqueOptionalSubjects______\n")

func getUniqueOptionalSubjects(students: [Student]) -> Set<String> {
    return Set(
        students.flatMap { $0.optionalSubjects }
    )
}

print(getUniqueOptionalSubjects(students: students))
