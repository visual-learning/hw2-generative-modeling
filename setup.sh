# Install dependencies
python -m pip install -r requirements.txt

# Prepare folders
mkdir -p $1/cleanfid/stats/
mkdir -p datasets/
rm -rf datasets/* # clear directory content

# Download and extract CUB dataset
gdown https://drive.google.com/uc\?id\=129PpsK6pfphHm6YbUUiVJFfFt1WQxEaM -O datasets/
tar zxvf datasets/CUB_200_2011.tgz
mv CUB_200_2011/ datasets/

# Resize images to 32x32
python resize_dataset.py \
    --input_folder datasets/CUB_200_2011/images \
    --output_folder datasets/CUB_200_2011_32/ \
    --res 32

# Clean up archive and bad images
rm -rf datasets/CUB_200_2011.tgz
rm -rf \
    datasets/CUB_200_2011_32/Mallard_0130_76836.jpg \
    datasets/CUB_200_2011_32/Brewer_Blackbird_0028_2682.jpg \
    datasets/CUB_200_2011_32/Clark_Nutcracker_0020_85099.jpg \
    datasets/CUB_200_2011_32/Ivory_Gull_0040_49180.jpg \
    datasets/CUB_200_2011_32/Pelagic_Cormorant_0022_23802.jpg \
    datasets/CUB_200_2011_32/Western_Gull_0002_54825.jpg \
    datasets/CUB_200_2011_32/Ivory_Gull_0085_49456.jpg \
    datasets/CUB_200_2011_32/White_Necked_Raven_0070_102645.jpg

# Copy FID reference stats
cp cub_clean_custom_na.npz $1/cleanfid/stats/cub_clean_custom_na.npz
