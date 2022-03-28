//
//  JSONParse.swift
//  RNScichart
//
//  Created by Леонид Молчанов on 28.03.2022.
//

// Класс для расшифровки JSON
class JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }
    public var hashValue: Int {
        return 0
    }
    public init() {}
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

// Структура описания элемента данных графика
struct IChart: Codable {
           let priceMin, priceMax, priceOpen, priceClose: Double
           let value: Int
           let sma50: Double
           let sma200: Double
           let tradeDate, tradeHour, tradeMin: String
           let formattedDate: JSONNull?
       }
