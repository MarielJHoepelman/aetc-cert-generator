require 'csv'

module Generator
  module Certificate
    module_function

    def parse_csv
      csv = File.read('lib/generator/data/input.csv')
      CSV.parse(csv, headers: false).map do |row|
        row.join()
      end
    end

    def run
      event_title = "Medications for Opioid Use Disorders in Primary Care"
      # event_sub = ""
      speaker = "Matisyahu Shulman, MD"
      date = "May 12, 2022"

      parse_csv.each do |name|
        create_image(name, event_title, date, speaker)
      end

    end

    def create_image(name, event_title,date, speaker)
      image = MiniMagick::Image.open("lib/generator/images/certificate.pdf")
      image.combine_options do |c|
        c.density 150
        c.quality 100
        c.font "lib/generator/fonts/Georgia-Bold-Italic.ttf"
        c.fill "#2d3e64"
        c.pointsize 40
        c.gravity "center"
        c.draw "text 0, -40 '#{name.titleize}'"
        c.pointsize 18
        c.draw "text 0, 112 '#{event_title}'"
        # c.pointsize 12
        # c.draw "text 0, 128 '#{event_sub}'"
        c.pointsize 14
        c.draw "text 0, 150 '#{date}'"
        c.pointsize 20
        c.draw "text 0, 260 '#{speaker}'"
      end

      image.write("lib/generator/output/#{name.parameterize}.pdf")
    end
  end
end
