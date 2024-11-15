import os
from flask import Flask, jsonify, request, render_template
from flask_cors import CORS
import numpy as np
from tensorflow.keras.preprocessing.image import load_img, img_to_array
from keras.applications.resnet_v2 import preprocess_input as resnet152v2_preprocess_input
from keras.applications.resnet_v2 import ResNet152V2
from keras.applications.imagenet_utils import decode_predictions

# Load the pre-trained ResNet152V2 model
model = ResNet152V2(weights='imagenet')

# Define a dictionary to map the original class names to new class names
class_dict = {
     'notebook': 'laptop',
    'cellular_telephone': 'Smartphone',
    'hand-held_computer': 'Smartphone',
    'remote_control': 'Smartphone',
    'iPod': 'Smartphone',
    'microphone': 'Headphone',
    'espresso_maker': 'Headphone',
    'washer': 'Washing Machine',
    'analog_clock': 'Watch',
    'digital_watch': 'Watch',
    'reflex_camera': 'Camera',
    'vending_machine': 'Refrigerator',
    'television': 'TV',
    'ashcan': 'Washing Machine'
}
app = Flask(__name__)
CORS(app)
# Define the upload folder
UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER

# Define the allowed file extensions
ALLOWED_EXTENSIONS = {'png', 'jpg', 'jpeg', 'gif'}
app.config['ALLOWED_EXTENSIONS'] = ALLOWED_EXTENSIONS

def allowed_file(filename):
    """Function to check if the file extension is allowed"""
    return '.' in filename and \
           filename.rsplit('.', 1)[1].lower() in app.config['ALLOWED_EXTENSIONS']

@app.route('/predict_image', methods=['POST'])
def predict_image():
    
       # Check if a file was submitted with the request
    if request.method == "POST":
        if 'file' not in request.files:
            return render_template('search_page.php', message='No file selected')
        file = request.files['file']

        # Check if the file is an allowed file type
        if not allowed_file(file.filename):
            return render_template('search_page.php', message='File type not allowed')

        # Save the file to the upload folder
        filename = file.filename
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))

        # Load the input image
        img_path = os.path.join(app.config['UPLOAD_FOLDER'], filename)
        img = load_img(img_path, target_size=(224, 224))

        # Preprocess the input image
        img = img_to_array(img)
        img = np.expand_dims(img, axis=0)
        img = resnet152v2_preprocess_input(img)

        # Make a prediction
        preds = model.predict(img)

        # Decode the prediction and print the predicted class
        decoded_preds = decode_predictions(preds, top=1)[0]
        for pred in decoded_preds:
            # Replace the original class name with the new class name
            pred = (pred[0], class_dict.get(pred[1], pred[1]), pred[2])
            item,prob = pred[1], pred[2]
            return jsonify(
                name=item
            )
          
@app.route('/view/<filename>')
def view_image(filename):
    """Function to display an uploaded image"""
    return '<img src="../uploads/{}">'.format(filename)

if __name__ == '__main__':
    app.run(debug=True)

    
    
