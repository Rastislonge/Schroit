# Find mp3 files that didn't convert
import os
import re

Mp3 = []
for file in os.listdir("./Schroit"):
        if file.endswith(".mp3"):
                print(re.sub("\.([\s\S]*)$","",file))
                Mp3.append(re.sub("\.([\s\S]*)$","",file))

Webm = []
for file in os.listdir("./Schroit/Webm"):
        if file.endswith(".webm"):
                print(re.sub("\.([\s\S]*)$","",file))
                Webm.append(re.sub("\.([\s\S]*)$","",file))

def get_difference(Mp3, Webm):
   return set(Mp3)-set(Webm)

non_match = list(get_difference(Mp3, Webm))
print("The following "+str(len(non_match))+" files are missing: ", non_match)

