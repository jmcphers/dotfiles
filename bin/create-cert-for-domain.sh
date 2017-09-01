if [ -z "$1" ]
then
  echo "Please supply a subdomain to create a certificate for";
  echo "e.g. www.mysite.com"
  exit;
fi

# Create a new private key if one does not exist, or use the existing one if it does
if [ -f device.key ]; then
  KEY_OPT="-key"
else
  KEY_OPT="-keyout"
fi

# create v3.ext file
cat > v3.ext <<EOL
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = %%DOMAIN%%
EOL


DOMAIN=$1

# Uncomment to get a wildcard certificate 
# COMMON_NAME=${2:-*.$1}
COMMON_NAME=$1

SUBJECT="/C=US/ST=None/L=NB/O=None/CN=$COMMON_NAME"
NUM_OF_DAYS=999
openssl req -new -newkey rsa:2048 -sha256 -nodes $KEY_OPT device.key -subj "$SUBJECT" -out device.csr
cat v3.ext | sed s/%%DOMAIN%%/$COMMON_NAME/g > /tmp/__v3.ext
openssl x509 -req -in device.csr -CA rootCA.pem -CAkey rootCA.key -CAcreateserial -out device.crt -days $NUM_OF_DAYS -sha256 -extfile /tmp/__v3.ext 

# move output files to final filenames
mv device.csr $DOMAIN.csr
cp device.crt $DOMAIN.crt

# remove temp file
rm -f device.crt;

echo 
echo "###########################################################################"
echo Done! 
echo "###########################################################################"
echo "To use these files on your server, simply copy both $DOMAIN.csr and"
echo "device.key to your webserver, and use like so (if Apache, for example)"
echo 
echo "    SSLCertificateFile    /path_to_your_files/$DOMAIN.crt"
echo "    SSLCertificateKeyFile /path_to_your_files/device.key"
