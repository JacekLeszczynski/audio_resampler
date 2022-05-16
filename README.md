# audio_resampler
Program do synchronizacji ścieżek audio do filmów.

Używany w celu dodawania ścieżek z polskim lektorem do filmów
w których ścieżka Video jest lepszej jakości, a ścieżki audio
brane są z filmów gorszej jakości.

Często się zdarza, że samo wykorzystanie takiej ścieżki z innego filmu
nie synchronizuje się poprawnie, film jest z innym bitrate,
rozpoczyna się wcześniej, albo później, trwa dłużej, albo krócej.

W programie łapie się dwa punkty na krańcach obu filmów i program
oblicza co należy zrobić z plikiem audio by pasował do docelowego.

Program nie robi wszystkiego z automatu, potem trzeba wygenerować
ścieżkę audio do pliku Wav, by móc w jakimś edytorze audio zrobić
co należy - program potrafi wyekstrachować plik audio do pliku Wav.
Następnie w dowolnym edytorze video należy nową ścieżkę dodać,
ustawić jeden punkt, drugi powinien się nałożyć z automatu,
części nadmiarowe usunąć i powinien wyjść film z nową ścieżką...

Działa to z większością filmów, czasami jednak pliki są tak źle przekodowane,
że to nie zadziała, cóż, ale idea działania programu jest dobra.
