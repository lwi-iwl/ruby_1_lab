class FileReader
    def initialize(filepath)
        @strings = File.read(filepath).split("\n")
    end

    def get_all
        @strings
    end

    def get_string(index)
        @strings[index]
    end
end