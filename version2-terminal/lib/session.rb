
require 'rainbow'
require_relative 'user'
require_relative 'greet'

class Session

  def initialize
    @user = User.new
  end

  def greet
    Greet.to @user.data
  end

  def byebye
    @user.save
  end

  def play
    greet
    interact_with_user
    byebye
  end

  private

  def interact_with_user
    flag = true
    keywords = { :exit => ['exit', 'quit', 'bye', 'byebye', 'close'] }
    history = {}
    action = Struct.new(:input, :output, :state, :times)

    while flag do
      print Rainbow("sheli> ").bright.blue
      input = gets
      input.chomp!
      if keywords[:exit].include? input
        puts Rainbow("See you later!").green.bright
        flag = false
      else
        result = `#{input}`
        if result then
          if history[input] then
            history[input].times += 1
          else
            history[input] = action.new(input,result, true,1)
          end
          puts Rainbow(result).yellow
        else
          puts Rainbow("error").red.bright
        end
      end
    end

    filename="data/#{@user.data[:username]}.history"
    history.each do |key,value|
      system("echo 'input  : #{value.input.to_s}' >> #{filename}")
      system("echo 'output : #{value.output.to_s}' >> #{filename}")
      system("echo 'state  : #{value.state.to_s}' >> #{filename}")
      system("echo 'times  : #{value.times.to_s}' >> #{filename}")
    end
  end
end
