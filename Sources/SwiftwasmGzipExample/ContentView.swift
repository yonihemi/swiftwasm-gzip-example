import TokamakDOM
import struct TokamakStaticHTML.Link
import Foundation
import Gzip

struct ContentView: View {
    @State private var inputText = ""
    @State private var compressed: Data?
    @State private var status: (message: String, isError: Bool) = ("", false)

    var body: some View {
        // onChange is [not yet implemented](https://github.com/TokamakUI/Tokamak/issues/199),
        // so do some double work here
        recompress(newText: inputText)

        return VStack(alignment: .leading, spacing: 10) {
            Text("Enter text:")

            TextEditor(text: $inputText)
                .frame(width: 300, height: 300)

            Text(status.message)
                .foregroundColor(status.isError ? .red : .primary)

            // URL cannot be optional, otherwise:
            // `Could not cast value of type 'Swift.Optional<TokamakCore.Link<TokamakCore.Text>>' to 'TokamakCore.ViewDeferredToRenderer'.`
            let downloadURI = compressed?.dataURI(mimeType: "application/gzip") ?? URL(string: "http://example.com")!
            Link("Download Gzipped", destination: downloadURI)
                .foregroundColor(.blue)
        }
        // .onChange(of: inputText) { newText in
        //     recompress(newText: newText)
        // }
    }

    private func recompress(newText: String) {
        compressed = nil
        guard let inputData = newText.data(using: .utf8) else {
            status = (message: "Can't encode input text to UTF-8", isError: true)
            return
        }
        
        do {
            let compressedData = try inputData.gzipped()
            compressed = compressedData
            status = (message: "Input: \(inputData.byteCount), gzipped: \(compressedData.byteCount)", isError: false)
        } catch {
            status = (message: "Input: \(inputData.byteCount). Error compressing data: \(error)", isError: true)
        }
    }
}

fileprivate extension Data {
    var byteCount: String {
        // NumberFormatter not yet working in SwiftWasm
        // ByteCountFormatter.string(fromByteCount: Int64(count), countStyle: .binary)
        "\(count) bytes"
    }

    func dataURI(mimeType: String) -> URL? {
        let base64 = base64EncodedString()
        return URL(string: "data:\(mimeType);base64,\(base64)")
    }
}