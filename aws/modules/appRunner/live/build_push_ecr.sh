#!/bin/bash

# Read parameters
PROJECT_NAME=$1
REGION=$2
PROFILE=$3

# Trigger CodeBuild
BUILD_ID=$(aws codebuild start-build --project-name $PROJECT_NAME --region $REGION --profile $PROFILE --query 'build.id' --output text)

echo "Triggered build with ID: $BUILD_ID"

# Wait until the build is complete
build_status="IN_PROGRESS"
while [[ "$build_status" == "IN_PROGRESS" || "$build_status" == "QUEUED" ]]; do
  build_status=$(aws codebuild batch-get-builds --ids $BUILD_ID --query 'builds[0].buildStatus' --output text --region $REGION --profile $PROFILE)
  echo "Current build status: $build_status"
  sleep 10
done

# Check the final build status
if [[ "$build_status" == "SUCCEEDED" ]]; then
  echo "Build succeeded"
  sleep 5
  exit 0
else
  echo "Build failed with status: $build_status"
  exit 1
fi

# Fetch and print build logs URL
logs_url=$(aws codebuild batch-get-builds --ids $BUILD_ID --query 'builds[0].logs.deepLink' --output text --region $REGION --profile $PROFILE)
echo "Build logs are available at: $logs_url"
