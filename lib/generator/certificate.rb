module Generator
  module Certificate
    module_function

    def run(event_params)
      if event_params[:preview]
        event_params[:participants] = event_params[:participants][0..0]
      end
      event_params[:participants].each do |name|
        create_image(name,event_params[:event_name], event_params[:event_date].to_date.to_formatted_s(:long), event_params[:speaker])
      end
    end

    def create_image(name, event_name, event_date, speaker)
      image = MiniMagick::Image.open("lib/generator/images/certificate.pdf")
      image.combine_options do |c|
        c.density 150
        c.quality 100
        c.font "lib/generator/fonts/Georgia-Bold-Italic.ttf"
        c.fill "#2d3e64"
        c.pointsize 35
        c.gravity "center"
        c.draw "text 0, -40 '#{name}'"
        c.pointsize 22
        c.draw "text 0, 105 '#{event_name}'"
        # c.pointsize 18
        # c.draw "text 0, 135 '#{event_sub}'"
        c.pointsize 18
        c.draw "text 0, 160 '#{event_date}'"
        c.pointsize 20
        c.draw "text 0, 260 '#{speaker}'"
      end

      image.write("lib/generator/output/#{name.parameterize}.pdf")
      binding.pry
    end
  end
end
