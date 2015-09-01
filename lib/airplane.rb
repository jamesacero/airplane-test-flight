# Pair programming with Phillip and James

class Airplane
  attr_reader :type, :wing_loading, :horsepower, :fuel, :engine, :status

  def initialize (type, wing_loading, horsepower, fuel)
    @type = type
    @wing_loading = wing_loading.to_i
    @horsepower = horsepower.to_i
    @fuel = fuel.to_i
    @engine = "off"
    @status = "landed"
  end

  def start
    if engine == "off"
      return "Not enough fuel to start engine! D'oh!" if fuel <= 0
      @fuel -= 1
      @engine = "on"
      "airplane started"
    else
      "airplane already started"
    end
  end

  def takeoff
    if engine == "on"
      return "Not enough fuel to take off. Way to go genius." if fuel <= 0
      @fuel -= 1
      @status = "flying"
      "airplane has taken off"
    else
      "engine not started, please start"
    end
  end

  def land
    if status == "flying"
      return "Insufficient fuel to land. You crash and die." if fuel <= 0
      @fuel -= 1
      @status = "landed"
      "The plane has landed"
    else
      if engine == "on"
        "The plane is still on the ground"
      else
        "You haven't even started it, dummy!"
      end
    end
  end
end
