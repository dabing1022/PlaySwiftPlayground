import UIKit
import os

let mylogger = Logger(subsystem: "com.sketch.app", category: "UI")

var accountNumber = "123456789"

mylogger.info("User bank account number: \(accountNumber, privacy: .auto)")
