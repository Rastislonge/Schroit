import os

#delete all html files in albums
for path, subdirs, files in os.walk(".\\Albums"):
    for name in files:
        if str(name).endswith(".html"):
            os.remove(os.path.join(path, name)) 
            #print("deleted "+os.path.join(path, name))