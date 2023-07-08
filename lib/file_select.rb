# Class responsible for selecting the markdown file
class MarkdownFile
  def initialize(config)
    @config = config
  end

  # Selects the markdown file to paste the transcription
  def select_markdown_file
    last_selected_file = @config.fetch(:last_selected_file, nil)

    markdown_files = file_list(NOTEBOOK)

    markdown_files.delete_if { |file| file.include?("chatGPTexports")}

    selected_file = @config.fetch(:selected_file) { prompt.select("Select the markdown file:", markdown_files, default:
    last_selected_file) }

    @config.set(:selected_file, value: selected_file)
    @config.set(:last_selected_file, value: selected_file)

    @config.write(force: true)
    selected_file
  end

  private

  # Returns an array of markdown file paths
  def file_list(path)
    Dir.glob(File.join(path, "**/*{,/*/**}.{md,markdown}"))
  end

  # TTY::Prompt instance for user interaction
  def prompt
    @prompt ||= TTY::Prompt.new
  end
end
