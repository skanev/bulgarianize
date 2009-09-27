bulgarianize
============

A small collection of niceness for localizing your applications in Bulgarian.
If the following text doesn't make any sense, you probably won't need the gem.

На български
------------

`bulgarianize` представлява малка колекция от решения на всякакви проблеми,
които изникват при писане на софтуер на български. Или поне тези, с които
авторът му се е сблъскал.

Функционалността включва (и вероятно е лимитирана до):

(Цели) числа словом
-------------------

Проста хватка:
  
    1.bg.as_words           # едно
    42.bg.as_words          # четиридесет и две
    1_024.bg.as_words       # хиляда двадесет и четири
  
Поради граматическа особеност на българския език се поддържа следното:

    1.bg.as_words(:male)    # един
    1.bg.as_words(:female)  # една
    1.bg.as_words(:neuter)  # едно
    42.bg.as_words(:male)   # четиридесет и два

По подразбиране родът е среден.

Copyright
---------

Copyright (c) 2009 Stefan Kanev. See LICENSE for details.
