# LumaTrace Integration Examples

This directory contains ready-to-use scripts to help you integrate the LumaTrace Cloud API into your existing infrastructure.

## Python Integration (`protect_asset.py`)

This script demonstrates how to authenticate and perform a multipart payload upload using Python.

### Prerequisites

Make sure you have Python 3.8+ installed. You will need the `requests` library.

```bash
# Install dependencies
pip install requests

# Run the script
python protect_asset.py
```

## Node.js Integration (protect_asset.js)

This script demonstrates the exact same workflow using Node.js, axios, and form-data.

### Prerequisites

Make sure you have Node.js 18+ installed.

```bash
# Initialize a new project and install dependencies
npm init -y
npm install axios form-data

# Run the script
node protect_asset.js
```

Note: Remember to replace USERNAME, PASSWORD, and IMAGE_PATH inside the scripts with your actual Sandbox or Production credentials before executing them.