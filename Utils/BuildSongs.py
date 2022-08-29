# Utility script for the generation of song html pages
from bs4 import BeautifulSoup
import re
import shutil
from pathlib import Path
import os

# Copy copper wires to your working directory as a baseline and name the new file based on the name of the webm.
baseline='template.html'

assets = list(Path("./Albums").rglob("*.[jJ][pP][gG]"))
webms = list(Path("./Albums").rglob("*.[wW][eE][bB][mM]"))

webmlist=[]
for file in webms:
    if str(file).endswith(".webm"):
        webmlist.append(str(file))
        new_path=re.sub("\\\\Assets\\\\Webm","",str(file))
        new_name=re.sub('\.webm','.html',str(new_path))
        shutil.copyfile(baseline, new_name)
    else:
        print("/Webm should only contain .webm files")
        print(str(file))
        exit()

# Open the new file and substitute the artist, album, title, cover and webm 
# (webm and cover are defined in the previous code)
i=0
for path, subdirs, files in os.walk(".\\Albums"):
    for name in files:
        if str(name).endswith(".html"):
            file=os.path.join(path, name)
            contents=open(file, "r")
            contents=contents.read()
            soup=BeautifulSoup(contents, "html.parser")

            # Replace cover
            img=soup.find('img')
            name=file.split('\\')[4]
            parent=re.sub(name,"Assets\\\\",file)
            print(parent)
            for f in os.listdir(parent):
                if str(f).endswith(".jpg"):
                    img['src']="Assets\\"+str(f)

            # Replace webm
            vid=soup.find('video')
            vid['src']=re.sub("(.*?)(?=Assets)","",webmlist[i])

            # Replace titles
            title=(re.sub('.html','', str(file))).split('\\')[4]
            titlep=soup.find('li', string=re.compile(r'.*Title:.*'))
            titlep.string=re.sub(" ","&nbsp;",("Title: "+title))

            # Replace topdata album
            album=str(file).split('\\')[3]
            albump=soup.find('li', string=re.compile(r'.*Album:.*'))
            albump.string=re.sub(" ","&nbsp;",("Album: "+album))
            #albump.replace(albump.string)

            # Replace topdata artist
            artist=str(file).split('\\')[2]
            artistp=soup.find('li', string=re.compile(r'.*Artist:.*'))
            artistp.string=re.sub(" ","&nbsp;",("Artist: "+artist))

            # Replace bottomdata title and artist
            titleb=soup.find(id='title')
            titleb.string=title+"&nbsp;|&nbsp;"+artist

            # Write new contents to file
            contents=open(file, "w")
            contents.write(str(soup))
            contents.close()

            # Remove all the "amp;" added by bs4 next to nbsp            
            pattern = r'amp;'
            with open(file, "r+") as file:
                text = file.read()
                text = re.sub(pattern, "", text)
                file.seek(0, 0)
                file.write(text)
                file.truncate()
            file.close()
            i+=1
