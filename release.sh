#!/bin/bash

# Check if version is provided
if [ -z "$1" ]; then
  echo "Error: Version number is required"
  echo "Usage: ./release.sh <version> [commit message]"
  echo "Example: ./release.sh 0.1.0"
  echo "Example with custom message: ./release.sh 0.1.0 \"feat: add new GraphQL helpers\""
  exit 1
fi

VERSION=$1
# Use custom commit message if provided, otherwise use default
COMMIT_MSG=${2:-"chore: bump version to $VERSION"}

# Validate version format (basic check)
if [[ ! $VERSION =~ ^[0-9]+\.[0-9]+\.[0-9]+(-[a-zA-Z0-9.]+)?$ ]]; then
  echo "Error: Version must be in format x.y.z or x.y.z-tag"
  exit 1
fi

echo "🚀 Releasing @apito-io/js-plugin-build-sdk version: $VERSION"
echo "📝 Commit message: $COMMIT_MSG"
echo ""

# Run tests before release
echo "🧪 Running tests..."
npm test
if [ $? -ne 0 ]; then
  echo "❌ Tests failed. Aborting release."
  exit 1
fi

# Run build
echo "🔨 Building package..."
npm run build
if [ $? -ne 0 ]; then
  echo "❌ Build failed. Aborting release."
  exit 1
fi

# Update version in package.json
echo "📦 Updating package version..."
npm version $VERSION --no-git-tag-version

# Commit the change
echo "📝 Committing changes..."
git add .
git commit -m "$COMMIT_MSG"

# Create and push the tag
echo "🏷️  Creating and pushing tag..."
git tag v$VERSION
git push && git push --tags

echo ""
echo "✅ Released version $VERSION successfully!"
echo "🔄 The GitHub workflow will now build and publish to npm."
echo "📦 Package: @apito-io/js-plugin-build-sdk@$VERSION"
echo "🌐 NPM: https://www.npmjs.com/package/@apito-io/js-plugin-build-sdk"