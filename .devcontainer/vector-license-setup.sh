#!/bin/bash
set -e

# Start CodeMeter
sudo /usr/sbin/CodeMeterLin

# Add On-Premise License Server
VectorLicenseClient -sr 255.255.255.255
echo "VectorLicenseClient is about to add the License Server $LICENSE_SERVER"
VectorLicenseClient -sa "$LICENSE_SERVER"
