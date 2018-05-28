# -*- coding: utf-8 -*-
"""
Éditeur de Spyder

Ceci est un script temporaire.
"""
def someData():
    file=open("neodys_modif.cat","r")

    #initialisation des listes
    a,a1,e1,i1,longnode1,arg_peric1=[],[],[],[],[],[]
    e,i,longnode,arg_peric,name=[],[],[],[],[]
    
    ligne1=file.readline()
    #on recupere les donnes des 9 premier satellites 
    for k in range(100):

        ligne=file.readline() #recupere la ligne i a l'iteration i
        list=ligne.split() #transformer la ligne (string) en list avec espace comme separateur
        name.append(list[0])
        a.append(list[2])
        e.append(list[3])
        i.append(list[4])
        longnode.append(list[5])
        arg_peric.append(list[6])
    
    print(len(arg_peric))
    print("a\n")
    for elt in a:
        elt=elt.replace("E+00","")    
        a1.append(float(elt))
        

    
    print("e\n")
    for elt in e:
        if elt.find("E-01")!=-1:
            elt=elt.replace("E-01","")
            e1.append(float(elt)*0.1)
        
    print("i\n")   
    for elt in i:
        if elt.find("E+01")!=-1:
            elt=elt.replace("E+01","")
            i1.append(float(elt)*10)
            
        elif elt.find("E+00")!=-1:
            elt=elt.replace("E+00","")
            i1.append(float(elt))

    
    print("longnode\n")  
    for elt in longnode:
        if elt.find("E+02")!=-1:
            elt=elt.replace("E+02","")
            longnode1.append(float(elt)*100)
        
        elif elt.find("E+01")!=-1:
            elt=elt.replace("E+01","")
            longnode1.append(float(elt)*10)
            
        elif elt.find("E+00")!=-1:
            elt=elt.replace("E+00","")
            longnode1.append(float(elt)) 
     
    print("arg_peric\n")
    for elt in arg_peric:
        if elt.find("E+02")!=-1:
            elt=elt.replace("E+02","")
            arg_peric1.append(float(elt)*100)
        elif elt.find("E+01")!=-1:   
             elt=elt.replace("E+01","")
             arg_peric1.append(float(elt)*10)
   
    
    file.close()    
   
    my_file  = open('data.txt', 'w')
    for n,a,b,c,d,e in zip(name,a1,e1,i1,longnode1,arg_peric1):
        s=str(n)+' '+str(a)+' '+str(b)+' '+str(c)+' '+str(d)+' '+str(e)+' '
        my_file.write(s)
    my_file.close()
    #return a1,e1