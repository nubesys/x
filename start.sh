# change into packer
cd packer/


AMIFILE="ami/base_ami.ova"
if [ ! -f "$AMIFILE" ]; then
echo "Downloading Base AMI:"
fileid="1cG2DERHjii13PDzfdc_N9DkvU9ZqzlRG"
filename="ami/base_ami.ova"
curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=${fileid}" > /dev/null
curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=${fileid}" -o ${filename}
rm -f cookie
fi

FILE=packer
if [ ! -f "$FILE" ]; then
echo "Downloading Packer:"
# download packer archive (Mac OS X)
curl -O https://releases.hashicorp.com/packer/1.5.6/packer_1.5.6_darwin_amd64.zip

# unzip packer archive
unzip packer_1.5.6_darwin_amd64.zip

# move packer binary
rm -f packer_1.5.6_darwin_amd64.zip

# check packer version
packer --version

fi

# start packer
packer build templates/ansible_iso.json
