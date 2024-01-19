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
      # name = "test name"
      event_title = ""
      # event_sub = "More Culturally Responsive Towards Transgender Patients"
      speaker = ""
      date = ""

      parse_csv.each do |name|
        create_image(name, event_title, date, speaker)
      end

    end

    def create_image(name, event_title, date, speaker)
      image = MiniMagick::Image.open("lib/generator/images/certificate.pdf")
      image.combine_options do |c|
        c.density 150
        c.quality 100
        c.font "lib/generator/fonts/Georgia-Bold-Italic.ttf"
        c.fill "#2d3e64"
        c.pointsize 35
        c.gravity "center"
        c.draw "text 0, -40 '#{name.humanize.gsub(/\b('?[a-z])/) { $1.capitalize }}'"
        c.pointsize 20
        c.draw "text 0, 105 '#{event_title}'"
        # c.pointsize 18
        # c.draw "text 0, 135 '#{event_sub}'"
        c.pointsize 18
        c.draw "text 0, 160 '#{date}'"
        c.pointsize 20
        c.draw "text 0, 260 '#{speaker}'"
      end

      image.write("lib/generator/output/#{name.parameterize}.pdf")
    end
  end
end
