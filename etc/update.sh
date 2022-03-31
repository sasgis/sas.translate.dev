#!/usr/bin/sh -ex

etc="${1}etc"
sas_src="${1}sas.sources"
sas_lang="${1}sas.translate"

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
    
    msgmerge --update ru.po default.po
    msgmerge --update uk.po default.po
    msgmerge --update fr.po default.po
    msgmerge --update tr.po default.po
    msgmerge --update es.po default.po
    
    rm -f *.po~
}

function set_unix_endline {
    
    cd ${sas_lang}
    
    dos2unix -u ru.po
    dos2unix -u uk.po
    dos2unix -u fr.po
    dos2unix -u tr.po
    dos2unix -u es.po
}

update_git_repo "https://github.com/sasgis/sas.planet.src" ${sas_src}
update_git_repo "https://github.com/sasgis/sas.translate" ${sas_lang}

get_translate
merge_translate
set_unix_endline
