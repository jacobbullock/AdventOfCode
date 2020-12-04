//
//  Day04.swift
//  AdventOfCode
//
//  Created by Jacob Bullock on 12/3/20.
//

import Foundation

/*
 byr (Birth Year)
 iyr (Issue Year)
 eyr (Expiration Year)
 hgt (Height)
 hcl (Hair Color)
 ecl (Eye Color)
 pid (Passport ID)
 cid (Country ID)
 */
class Day04: Day {

    override var name: String { "04" }
    
    var passportKeys = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid", "cid"])
    
    
    lazy var passports: Array<Dictionary<String, String>> = {
        let lines = input.lines
        var passports = [[String: String]]()
        var dict = [String: String]()
        for line in lines {
            if line == "" {
                passports.append(dict)
                dict = [String: String]()
            } else {
                let parts = line.components(separatedBy: " ")
                for part in parts {
                    let d = part.components(separatedBy: ":")
                    dict[d[0]] = d[1]
                }
            }
        }
        passports.append(dict)
        
        return passports
    }()
    
    override func part1() -> String {
        let modifiedKeys = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
        
        let validPassports = passports.filter {
            let keys = Set($0.keys)
            
            return keys == passportKeys || keys == modifiedKeys
        }
        
        return "\(validPassports.count)"
    }

    override func part2() -> String {
        let modifiedKeys = Set(["byr", "iyr", "eyr", "hgt", "hcl", "ecl", "pid"])
        
        let validPassports = passports.filter {
            let keys = Set($0.keys)
            
            return (keys == passportKeys || keys == modifiedKeys)
                    && checkBirthYear(s: $0["byr"]!)
                    && checkIssueYear(s: $0["iyr"]!)
                    && checkExpirationYear(s: $0["eyr"]!)
                    && checkHeight(s: $0["hgt"]!)
                    && checkHair(s: $0["hcl"]!)
                    && checkEyes(s: $0["ecl"]!)
                    && checkPassportId(s: $0["pid"]!)
        }
        
        return "\(validPassports.count)"
    }
    
    func checkBirthYear(s: String) -> Bool {
       
        guard s.count == 4, let i = Int(s), i >= 1920, i <= 2002 else {
            return false
        }
        return true
    }
    
    func checkIssueYear(s: String) -> Bool {
        guard s.count == 4, let i = Int(s), i >= 2010, i <= 2020 else {
            return false
        }
        
        return true
    }
    
    func checkExpirationYear(s: String) -> Bool {
        guard s.count == 4, let i = Int(s), i >= 2020, i <= 2030 else {
            return false
        }
        
        return true
    }
    
    func checkHeight(s: String) -> Bool {
        let range = NSRange(location: 0, length: s.utf16.count)
        
        if let regexInches = try? NSRegularExpression(pattern: #"^[^\d]*(\d+)+in"#),
           let _ = regexInches.firstMatch(in: s, options: [], range: range),
           let regex = try? NSRegularExpression(pattern: #"^[^\d]*(\d+)"#),
           let inches = regex.firstMatch(in: s, options: [], range: range),
           let val = Int(String(s[Range(inches.range, in: s)!])),
           val >= 59, val <= 76 {
            return true
        }
        
        if let regexCm = try? NSRegularExpression(pattern: #"^[^\d]*(\d+)+cm"#),
           let _ = regexCm.firstMatch(in: s, options: [], range: range),
           let regex = try? NSRegularExpression(pattern: #"^[^\d]*(\d+)"#),
           let cm = regex.firstMatch(in: s, options: [], range: range),
           let val = Int(String(s[Range(cm.range, in: s)!])),
           val >= 150, val <= 193 {
            return true
        }

        return false
    }
    
    func checkHair(s: String) -> Bool {
        let range = NSRange(location: 0, length: s.utf16.count)
        
        guard s.count == 7,
           let regex = try? NSRegularExpression(pattern: #"^#[0-9a-f]{6}"#),
           regex.firstMatch(in: s, options: [], range: range) != nil else {
            return false
        }
        return true
    }
    
    func checkEyes(s: String) -> Bool {
        let valid = ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]
        return valid.contains(s)
    }
    
    func checkPassportId(s: String) -> Bool {
        
        guard s.count == 9, Int(s) != nil else {
            return false
        }
        return true
    }
    
}

