#! /bin/bash

# Unzips files among the arguments (after glob expansion) that look like 
# FOO.sb3 (Scratch 3.0 projects) or FOO.sprite3 (Scratch 3.0 sprites).
# The newly created directories are named FOO___sb3 and FOO___sprite3
# respectively. It then traverses these directories looking for JSON and
# XML/SVG files to format for human-readability (line breaks, indents, 
# etc.). Does not remove the original files. Each time it's run it 
# overwrites the files in the output directories without asking.
# 
# In future projects might also be handy for unpacking things like .docx 
# files but that will be then.
# 
# Usage: unpack *; unpack zombie*; unpack *.sb3; unpack *.sprite3; 
#        unpack *.s{b,prite}3
unpack(){
  for ii in $(ls -d $*); do 
    iifile=$(basename -- "$ii"); iiext="${iifile##*.}"; iifile="${iifile%.*}";
    if [[ "$iiext" =~ ^(sb3|sprite3)$ ]]; then
      iidir="$iifile"___"$iiext";
      unzip -o $ii -d "$iidir";
      for jj in $(find $iidir); do
        jjext="${jj##*.}";
        if [[ "$jjext" == json ]]; then
	  jq . $jj > .temp.json && mv .temp.json $jj;
        elif [[ "$jjext" =~ ^(xml|svg)$ ]]; then
  	  xmllint --format $jj > .tmp.xml && mv .tmp.xml $jj;
        fi;
      done;
    fi;
  done;
}

# Reverses unpack by creating or refreshing files FOO.sb3 with the contents
# of FOO___sb3 and FOO.sprite3 with the contents of FOO___sprite3, but 
# preserving the reformatting of JSON/XML/SVG files. Parent directories are
# ignored but the filepaths below that are preserved. Does not delete the 
# files in FOO___* source directories, only refreshes the FOO.* archives
repack(){
  for ii in $(ls -d $*); do
    if [[ "$ii" =~ ___[^_]+$ ]]; then
      iizip=$(basename -- "$ii"|sed "s/___\([^_]*\)/.\1/" - );
      cd "$ii" && zip -r ../"$iizip" ./* && cd ..;
    fi;
  done;
}
