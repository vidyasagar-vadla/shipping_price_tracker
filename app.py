from flask import Flask, jsonify
from flask_cors import CORS  # Import CORS

app = Flask(__name__)
CORS(app)  # Enable CORS for all routes

# Your data
CITY_DISTANCES = {
    ("Bangalore", "Mumbai"): 980,
    ("Bangalore", "Delhi"): 2150,
    ("Mumbai", "Delhi"): 1400,
    ("Mumbai", "Kolkata"): 2050,
    ("Delhi", "Kolkata"): 1500,
    ("Chennai", "Bangalore"): 350,
    ("Hyderabad", "Bangalore"): 570
}

# Courier pricing rates
COURIERS = {
    "Delhivery": {"base_price": 50, "per_km_rate": 10},
    "DTDC": {"base_price": 60, "per_km_rate": 12},
    "Bluedart": {"base_price": 70, "per_km_rate": 15}
}

@app.route('/city_distances', methods=['GET'])
def get_city_distances():
    # Convert the CITY_DISTANCES dictionary to a more JSON-friendly format
    distances_json = {f"{city1}-{city2}": distance for (city1, city2), distance in CITY_DISTANCES.items()}
    return jsonify(distances_json)

@app.route('/couriers', methods=['GET'])
def get_couriers():
    return jsonify(COURIERS)

@app.route('/data', methods=['GET'])
def get_all_data():
    return jsonify({
        "city_distances": {f"{city1}-{city2}": distance for (city1, city2), distance in CITY_DISTANCES.items()},
        "couriers": COURIERS
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)