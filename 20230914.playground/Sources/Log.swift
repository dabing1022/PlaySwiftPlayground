import os

public let logger = Logger()

public func log(_ text: String) {
    logger.log("\(text)")
}

public func info(_ text: String) {
    logger.info("\(text)")
}
