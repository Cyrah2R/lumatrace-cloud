/**
 * LumaTrace Enterprise C2PA Integration Example (Node.js)
 * -------------------------------------------------------
 * This script demonstrates how to authenticate a tenant and upload
 * a raw image for spatial watermarking and C2PA JUMBF injection.
 * * Requirements: npm install axios form-data
 */

const axios = require('axios');
const FormData = require('form-data');
const fs = require('fs');
const crypto = require('crypto');

// --- Configuration ---
const API_BASE_URL = 'https://api.lumatrace.es/api/v1';
const USERNAME = 'your_service_account';
const PASSWORD = 'your_secure_password';
const IMAGE_PATH = './sample_input.jpg';

function getSha256Hash(filePath) {
    const fileBuffer = fs.readFileSync(filePath);
    const hashSum = crypto.createHash('sha256');
    hashSum.update(fileBuffer);
    return hashSum.digest('hex');
}

async function protectAsset() {
    console.log('[*] Starting LumaTrace Protection Workflow...');

    try {
        // 1. Authenticate and retrieve Tenant JWT
        const authResponse = await axios.post(`${API_BASE_URL}/auth/login`, {
            username: USERNAME,
            password: PASSWORD
        });

        const jwtToken = authResponse.data.token;
        console.log('[+] Authentication Successful. Token acquired.');

        // 2. Prepare the Payload
        const contentHash = getSha256Hash(IMAGE_PATH);

        const metadata = {
            contentHash: contentHash,
            deviceModel: 'NodeJS_Integration_Script_V1',
            latitude: 40.4168,
            longitude: -3.7038
        };

        // 3. Construct Multipart Form-Data
        const formData = new FormData();
        formData.append('image', fs.createReadStream(IMAGE_PATH));
        formData.append('request', JSON.stringify(metadata), {
            contentType: 'application/json'
        });

        console.log('[*] Uploading asset and requesting C2PA injection...');

        // 4. Execute Upload
        const protectResponse = await axios.post(`${API_BASE_URL}/photos/protect`, formData, {
            headers: {
                'Authorization': `Bearer ${jwtToken}`,
                ...formData.getHeaders()
            },
            responseType: 'stream' // We expect a binary image back
        });

        // 5. Handle Binary Response
        const outputPath = 'lumatrace_protected_output.jpg';
        const writer = fs.createWriteStream(outputPath);

        protectResponse.data.pipe(writer);

        return new Promise((resolve, reject) => {
            writer.on('finish', () => {
                console.log(`[+] Success! Protected asset saved to: ${outputPath}`);
                resolve();
            });
            writer.on('error', reject);
        });

    } catch (error) {
        if (error.response) {
            console.error(`[!] API Error (HTTP ${error.response.status}):`, error.response.data);
        } else {
            console.error('[!] Network or Setup Error:', error.message);
        }
    }
}

protectAsset();