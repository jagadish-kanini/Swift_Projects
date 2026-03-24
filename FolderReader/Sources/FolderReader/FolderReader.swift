import Foundation

let fileManager = FileManager.default

print("Enter folder path:")

if let path = readLine() {

    do {
        let files = try fileManager.contentsOfDirectory(atPath: path)

        print("\nFolder: \(path)")
        print("Files:")

        for file in files {
            print(file)
        }

    } catch {
        print("Error reading folder")
    }
}