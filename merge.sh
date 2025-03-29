Merge="./variables.tf"
if [ -e ${Merge} ]; then
    rm -f ${Merge}
fi

MODULES=$(awk '!/^#/ && /source[[:space:]]*=/ {gsub("\"", "", $3); print $3}' modules.tf)

for MODULE in ${MODULES}; do
    DIR=$(basename ${MODULE})
    echo "# module : ${DIR}"                        >> ${Merge}
    cat ${MODULE}/variable*.tf                 >> ${Merge}
    echo -e "\n"                                    >> ${Merge}
done