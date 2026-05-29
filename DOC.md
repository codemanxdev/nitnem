# Apple Code Signing

### A Macbook is needed to perform the steps below

## Create a Certificate Signing Request

1. Open Certificate Keychain
2. Keychain Access -> Certificate Assistant -> Request a Certificate From a Certificate Authority -> Continue
3. Enter Email Address, Common Name and save request to disk.

## Create a new Certificate

1. Go to Apple Developer Console
2. Go to Certificates, Identifiers and Profiles
3. Click + sign to add a new certificate
4. Select iOS Distribution (App Store and Ad Hoc) - Continue
5. Upload the CSR created in the first step.

## Export P12 Certificate

1. open the .cer file and export the p12 from the keychain
