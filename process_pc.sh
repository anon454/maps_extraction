ply_path=$1
ransac_code_path=$2

surface_dir="dataset/"surface
color_dir="dataset/"color
rm -rf $surface_dir
rm -rf $color_dir

mkdir -p $surface_dir
mkdir -p $color_dir

build_path=$ransac_code_path/"build"

for pc in $(ls ${ply_path})
do
  echo "Processing file: "$ply_path/$pc
  ./$build_path/ransac_tree $ply_path/$pc
  file_name="${pc%%.*}"
  mv $ransac_code_path/"texture0.png" $color_dir/$file_name".png"
  mv $ransac_code_path/"rad.txt" $surface_dir/$file_name".txt"
done
python convert_to_surface.py --surface_path $surface_dir
echo "Extracted the surface and color"

rm -rf $surface_dir/*.txt
