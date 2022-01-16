
class Greet

  def self.to(profile)
    delta = profile[:current_access] - profile[:last_access]
    if delta < 2
      puts "¡Hola!"
      puts "¡Encantado de conocerle #{profile[:cusername]}!"
    elsif delta < 260000
      puts "¡Hola #{profile[:cusername]}!"
      puts "¿Cómo estás?"
    else
      puts "¡Hola #{profile[:cusername]}!"
      puts "¡Cuánto tiempo sin verte!"
    end
  end

end
