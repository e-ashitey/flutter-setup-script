#!/bin/bash

# Check if project name is provided
if [ -z "$1" ]; then
    echo "Usage: ./setup_flutter_project.sh project_name"
    exit 1
fi

PROJECT_NAME=$1
TEMPLATE_NAME="your_template_name"  # Replace with your actual template project name

# Create a new Flutter project
flutter create $PROJECT_NAME

# Navigate into the project
cd $PROJECT_NAME || exit

# Remove unnecessary default files (optional)
rm -rf lib/main.dart pubspec.yaml

# Copy your custom folder structure and files
cp -r ~/my_flutter_template/* .

# Replace pubspec.yaml with the one from the template
cp ~/my_flutter_template/pubspec.yaml .

# Replace template project name with the new project name in the lib folder
find lib/ -type f -exec sed -i "s/$TEMPLATE_NAME/$PROJECT_NAME/g" {} +

# Replace template project name in pubspec.yaml
sed -i "s/$TEMPLATE_NAME/$PROJECT_NAME/g" pubspec.yaml

# Install dependencies
flutter pub get

# Echo message for package updates
echo "✅ Setup complete!"
echo "📌 Run the following command to ensure all packages are up to date:"
echo "   flutter pub upgrade"

echo "🚀 You can now start your project with:"
echo "   cd $PROJECT_NAME"
echo "   flutter run"
