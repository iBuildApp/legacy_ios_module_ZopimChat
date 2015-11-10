#!/bin/bash
for i in $( find ./mZopimchat -name '*.h' -type f ); do
headerdoc2html -j -o ./mZopimchat/Documentation $i
done

gatherheaderdoc ./mZopimchat/Documentation


sed -i.bak 's/<html><body>//g' ./mZopimchat/Documentation/masterTOC.html
sed -i.bak 's|<\/body><\/html>||g' ./mZopimchat/Documentation/masterTOC.html
sed -i.bak 's|<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN" "http://www.w3.org/TR/REC-html40/loose.dtd">||g' ./mZopimchat/Documentation/masterTOC.html