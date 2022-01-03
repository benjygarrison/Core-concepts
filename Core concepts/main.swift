//
//  main.swift
//  Core concepts
//
//  Created by Ben Garrison on 1/2/22.
//

import Foundation

//ALGO AND DATA STRUCTURE INTERVIEW QUESTIONS:

//MARK: ----- Question 1: -----
/* Cyclical array rotation
For example, given
A = [3, 8, 9, 7, 6]
K = 3
the function should return: [9, 7, 6, 3, 8] (three rotations)
*/

//brute force O(n^2):
func rotateArrayFinal(A: [Int], K: Int) -> [Int] {
    var result = A
    
    for _ in 1...K {
        result = rotateArrayOnce(A: result)
    }
    return result
}

var arrayA = [3, 8, 9, 7, 6]
let numberOfTimes = 3

func rotateArrayOnce(A: [Int]) -> [Int] {

    var newArray = Array<Int>(repeating: 0, count: A.count)
    
    for i in 0..<A.count - 1 {
        newArray[i + 1] = A[i]
    }
    newArray[0] = A.last!
    
    return newArray
}

var finalResult = rotateArrayFinal(A: [1, 2, 3, 4, 5], K: 3)

print("Question 1 answer: \(finalResult)")

//TODO -> reverse this algo



//MARK: ----- Question 2 -----
/*phone number array:
 reformat string with numbers and spaces to have dashes every three characters. end of string can be 2 or 3 characters i.e. "-xxx-xx" or "-xx-xx"
 */
 
func phoneNumberSolution(phoneString: String) -> String {
    let originalPhoneString = phoneString
    
//    if phoneString.count != 0 {
//        originalPhoneString = phoneString
//    }

    var numbersOnlyPhoneString = ""
    
    /*
     possible shortcut:use replacingOccurrence function
     ex: let phoneStringNoSPace = originalPhoneString.replacingOccurrence(of: " ", with: "")
         let phoneStringNoSpaceNoDash = phoneStringNoSpace.replacingOccurrence(of: "-", with: "")
     */

    for letter in originalPhoneString {
        if originalPhoneString.count > 1 {
            switch letter {
            case "1", "2", "3", "4", "5", "6", "7", "8", "9", "0":
                numbersOnlyPhoneString.append(letter)
            default: break
            }
//        } else if originalPhoneString.count == 1 {
//            numbersOnlyPhoneString.append(letter)
        }
    }
    
    var addedDashPhoneString = ""
    var count = -2

    for letter in numbersOnlyPhoneString {
        addedDashPhoneString.append(letter)
        if count % 3 == 0 {
            addedDashPhoneString.append("-")
        }
        count+=1
    }
    
    if addedDashPhoneString.last == "-" {
        addedDashPhoneString = String(addedDashPhoneString.dropLast())
    }
    
    var phoneNumberArray = Array(addedDashPhoneString)
    
    let countBackwardsTwo = phoneNumberArray.count-2
    
    if phoneNumberArray.count >= 1 {
        if phoneNumberArray[countBackwardsTwo] == "-" {
            phoneNumberArray[countBackwardsTwo] = phoneNumberArray[countBackwardsTwo-1]
            phoneNumberArray[countBackwardsTwo-1] = "-"
        }
    }
        if phoneNumberArray.count <= 0 {
            print("Please enter at least 2 digits.")
        }
    return String(phoneNumberArray)
}

var firstPhoneNumber = "123  b  456789 10 11"
var secondPhoneNumber = "1234"
var thirdPhoneNumber = "1--2 345-  6789 - 1013"
var edgeCasePhoneNumber = ""
var edgeCasePhoneNumberTwo = "0 1"

print("")
print("Question 2 answer (first phone no.): \(phoneNumberSolution(phoneString: firstPhoneNumber))")
print("Question 2 answer (second phone no.): \(phoneNumberSolution(phoneString: secondPhoneNumber))")
print("Question 2 (third phone no.): \(phoneNumberSolution(phoneString: thirdPhoneNumber))")
print("Question 2 answer (second edge case): \(phoneNumberSolution(phoneString: edgeCasePhoneNumberTwo))")
print("Question 2 answer for nil input:")
print(phoneNumberSolution(phoneString: edgeCasePhoneNumber))



/* MARK: ----- Question 3 -----
 Contact search algo:
 search contact phone numbers, and return
 -NO CONTACT if none is found
 -Contact name if a contact is found
 -The first alphabetized name if multiple contacts found
 (partial number should return results)
 let A = [Ben, Hana]
 let B = [4082428796, 9254511975] // A[i] = B[i]
 let C = "4511"
 */

//my result
func returnContact(A: [String], B: [String], C: String) -> String {
    
    let contactNameArray = A
    let contactNumberArray = B
    let searchTerm = C
    var searchResult = ""
    
    let filteredContactNumberArray = contactNumberArray.indices.filter {contactNumberArray[$0].contains(searchTerm)}
    
    let filteredContactNameArray = filteredContactNumberArray.map {contactNameArray[$0].lowercased()}.sorted()
    
//    print(filteredContactNumberArray)
//    print(filteredContactNameArray)
    
    if filteredContactNameArray.isEmpty {
        searchResult = "NO CONTACT"
    } else {
        searchResult = filteredContactNameArray[0].capitalized
    }
    
    return searchResult
}

//Instructor's result
func returnOtherGuysContactResult(A: [String], B: [String], C: String) -> String {
    
    var result = [String]()
    
    for i in 0..<B.count {
        if B[i].contains(C) {
            result.append(A[i])
        }
    }
    
    if result.count == 0 {
        return "NO CONTACT"
    } else if result.count == 1 {
        return result.first!.capitalized
    }
    
    return result.sorted().first!.capitalized
}

let A = ["Ben", "Tana", "Rando"]
let B = ["4082428796", "9254511975", "4084511975"] // A[i] = B[i]
let C = "4511975"

print("Question 3 answer (my algo): \(returnContact(A: A, B: B, C: C))")
print("Question 3 answer (better algo): \(returnOtherGuysContactResult(A: A, B: B, C: C))")


