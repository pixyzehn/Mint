import Foundation
import Utility

class PackageCommand: MintCommand {

    var verboseArgument: OptionArgument<Bool>!
    var packageArgument: PositionalArgument<String>!

    override init(mint: Mint, parser: ArgumentParser, name: String, description: String) {
        super.init(mint: mint, parser: parser, name: name, description: description)

        let packageHelp = """
        The identifier for the Swift Package to use. It can be a shorthand for a github repo \"githubName/repo\", or a fully qualified .git path.
        An optional version can be specified by appending @version to the repo, otherwise the newest tag will be used (or master if no tags are found)
        """
        packageArgument = subparser.add(positional: "package", kind: String.self, optional: false, usage: packageHelp)
        verboseArgument = subparser.add(option: "--verbose", kind: Bool.self, usage: "Show installation output")
    }

    override func execute(parsedArguments: ArgumentParser.Result) throws {
        let verbose = parsedArguments.get(verboseArgument) ?? false
        let package = parsedArguments.get(packageArgument)!

        let version: String
        let packageParts = package.components(separatedBy: "@")
        let repo: String

        if packageParts.count > 1 {
            repo = packageParts[0]
            version = packageParts[1]
        } else {
            repo = package
            version = ""
        }

        try execute(parsedArguments: parsedArguments, repo: repo, version: version, verbose: verbose)
    }

    func execute(parsedArguments: ArgumentParser.Result, repo: String, version: String, verbose: Bool) throws {
    }
}
