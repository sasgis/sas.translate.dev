#!/usr/bin/sh -ex

etc="${1}etc"
sas_src="${1}sas.sources"
sas_lang="${1}sas.translate"

# space-separated string of the language codes
langs="es fa fr ru tr uk"

function update_git_repo {

    local url=$1
    local path=$2
    
    if [ ! -d "${path}" ]; then
        git clone ${url} ${path}
    else
        cd ${path}
        git fetch --all --verbose
        git clean -d -x --force
        git reset --hard origin/master
    fi
}

function get_translate {
    
    local src="${sas_src}/src/"
    
    cp -f "${etc}/dxgettext/ggexclude.cfg" ${src}
    cp -f "${etc}/dxgettext/dxgettext.ini" ${src}
    cp -f "${sas_lang}/ignore.po" ${src}

    cd ${src}

    dxgettext -r --delphi --nonascii --useignorepo -o:msgid -o ${sas_lang}

    rm -f ggexclude.cfg dxgettext.ini ignore.po

    cd ${sas_lang}

    msgattrib --output-file=out.po --no-location default.po
    msgremove out.po -i ignore.po -o default.po
    
    rm -f out.po
}

function merge_translate {
    
    cd ${sas_lang}
    
    for lang in ${langs} ; do
        echo "Merging ${lang}.po"
        msgmerge --update "${lang}.po" default.po
    done
    
    rm -f *.po~
}

function set_unix_endline {
    
    cd ${sas_lang}
    
    for lang in ${langs} ; do
        echo "Fixing EOL for ${lang}.po"
        dos2unix -u "${lang}.po"
    done
}

update_git_repo "https://github.com/sasgis/sas.planet.src" ${sas_src}
update_git_repo "https://github.com/sasgis/sas.translate" ${sas_lang}

get_translate
merge_translate
set_unix_endline

echo "Done!"
