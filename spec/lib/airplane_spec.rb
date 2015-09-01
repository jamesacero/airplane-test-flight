# Pair programming with Phillip and James

require_relative "../../lib/airplane"

describe Airplane do
  let(:airplane) do
    type = "Cesna"
    wing_loading = 10
    horsepower = 150
    fuel = 6
    Airplane.new(type, wing_loading, horsepower, fuel)
  end

  describe "#initialization" do
    it "creates an Airplane object" do
      expect(airplane).to be_a(Airplane)
    end
  end

  describe "#type" do
    it "has a reader for type" do
      expect(airplane.type).to eq ("Cesna")
    end
  end

  describe "#wing_loading" do
    it "has a reader for wing_loading" do
      expect(airplane.wing_loading).to eq(10)
    end
  end

  describe "#horsepower" do
    it "has a reader for horsepower" do
      expect(airplane.horsepower).to eq(150)
    end
  end

  describe "#engine" do
    it "has a reader for engine" do
      expect(airplane.engine).to eq("off")
    end
  end

  describe "#status" do
    it "has a reader for status" do
      expect(airplane.status).to eq("landed")
    end
  end

  describe "#fuel" do
    it "has a reader for fuel" do
      expect(airplane.fuel).to eq(6)
    end

    it "costs fuel to start, takeoff, and land" do
      airplane.start
      expect(airplane.fuel).to eq(5)
      airplane.takeoff
      expect(airplane.fuel).to eq(4)
      airplane.land
      expect(airplane.fuel).to eq(3)
    end
  end

  describe "#start" do
    it "starts the engine" do
      expect(airplane.start).to eq("airplane started")
      expect(airplane.engine).to eq("on")
    end

    it "reports if the engine is already started" do
      airplane.start
      expect(airplane.start).to eq("airplane already started")
    end

    it "can't start if there's not enough fuel" do
      genius_flight_crew = Airplane.new("Cesna", 10, 150, 0)
      expect(genius_flight_crew.start).to eq("Not enough fuel to start engine! D'oh!")
    end
  end

  describe "#takeoff" do
    it "takes off if the engine is running" do
      airplane.start
      expect(airplane.takeoff).to eq("airplane has taken off")
      expect(airplane.status).to eq("flying")
    end

    it "doesn't take off if the engine is not running" do
      expect(airplane.takeoff).to eq("engine not started, please start")
      expect(airplane.status).to eq("landed")
    end

    it "can't take off if there's not enough fuel" do
      bad_preflight_check = Airplane.new("Cesna", 10, 150, 1)
      bad_preflight_check.start
      expect(bad_preflight_check.takeoff).to eq("Not enough fuel to take off. Way to go genius.")
    end
  end

  describe "#land" do
    it "lands if the plane is flying" do
      airplane.start
      airplane.takeoff
      expect(airplane.land).to eq("The plane has landed")
      expect(airplane.status).to eq("landed")
    end

    it "can't land if not flying" do
      expect(airplane.land).to eq("You haven't even started it, dummy!")
      airplane.start
      expect(airplane.land).to eq("The plane is still on the ground")
    end

    it "crashes if there's not enough fuel to land" do
      doomed_flight = Airplane.new("Cesna", 10, 150, 2)
      doomed_flight.start
      doomed_flight.takeoff
      expect(doomed_flight.land).to eq("Insufficient fuel to land. You crash and die.")
    end
  end

end
