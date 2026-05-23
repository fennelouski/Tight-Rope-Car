//
//  ProgressShareExport.swift
//  Tight Rope Car
//

import CoreTransferable
import Foundation
import UniformTypeIdentifiers

/// Share-sheet payload: human-readable summary plus JSON export.
struct ProgressShareExport: Transferable, Equatable, Sendable {
    let plainText: String
    let jsonData: Data
    let jsonFileName: String

    static var transferRepresentation: some TransferRepresentation {
        ProxyRepresentation(exporting: \.plainText)
        DataRepresentation(exportedContentType: .json) { export in
            export.jsonData
        }
        FileRepresentation(exportedContentType: .json) { export in
            let url = FileManager.default.temporaryDirectory
                .appendingPathComponent(export.jsonFileName)
            try export.jsonData.write(to: url, options: .atomic)
            return SentTransferredFile(url)
        }
    }
}
