with entrees_sorties; use entrees_sorties;
procedure programmePrincipale is
--déclaration types etc...
type ValeurCase is (NOIR,BLANC,RIEN);
type Direction is (NOR,SUD,EST,WES);
N:constant Integer:=26;
subtype Intervalle is Integer range 1..N;
type Damier is array (Intervalle,Intervalle) of ValeurCase;
procedure afficherDamier(tab:in Damier;tailleChoisit:In Integer)is
procedure afficherBorneSuperieurOuInferieur(tailleChoisit:IN integer) is
begin
	for i in Integer range 1..tailleChoisit loop
		put("----");
	end loop;
end afficherBorneSuperieurOuInferieur;
procedure afficherCase(x:In ValeurCase) is
begin
if x = RIEN then
	put("|   ");
else
	if x = BLANC then
		put("| B ");
	else
		put("| N ");
	end if;
end if;
put("|");
end afficherCase;
procedure afficherSeparation(tailleChoisit:In Integer) is
begin
	for i in Integer range 1..tailleChoisit loop
		put("-----");
	end loop;
	
end afficherSeparation;
--begin de afficherDamier
begin
	afficherSeparation(tailleChoisit);
	new_line;
	for i in Integer range 1..tailleChoisit loop
		for j in Integer range 1..tailleChoisit loop
			afficherCase(tab(i,j));
		end loop;
	new_line;
	afficherSeparation(tailleChoisit);
	new_line;
	end loop;
end afficherDamier;
procedure initialisation(j1,j2:out ValeurCase;indice:out Integer;tailleChoisit:out Integer)is
choixCouleurEnString:String:="BLAN";
--begin d'initialisation
begin
	put("quel taille de damier souhaitez vous?");
	get(tailleChoisit);
	put("le joueur1 veut-il être blanc ou noir? (tapez 'NOIR' ou 'BLAN')");
	get(choixCouleurEnString);
	put(choixCouleurEnString);
	if ValeurCase'image(NOIR)= choixCouleurEnString then
		j1:=NOIR;
	else
		j1:=BLANC;
	end if;
	if j1 = BLANC then
		j2:= NOIR;
	else
		j2:=BLANC;
	end if;
	put("qui commence? entrez '1' ou '2' qui correspondent respectivement à joueur 1 et joueur 2 ");
	get(indice);
end initialisation;
procedure toursDUnJoueur(tab:in out Damier; joueur:in ValeurCase;tailleChoisit:In Integer) is
procedure insererPion(tab:in out Damier; joueur:in ValeurCase;dir0:in Direction;posInsertion,tailleChoisit:in Integer) is
n:Integer:=1;
pionInserer:Boolean:= False;
--begin de insererPion
begin
	case dir0 is
		when NOR => while not pionInserer loop
						if tab(n,posInsertion) = RIEN or n=tailleChoisit then
							while n/=1 loop
								tab(n,posInsertion):=tab(n-1,posInsertion);
								n:=n-1;
							end loop;
							tab(n,posInsertion):=joueur;
							pionInserer:=TRUE;
						else
							n:=n+1;
						end if;
					end loop;
		when SUD => while not pionInserer loop
						if tab(tailleChoisit-n+1,posInsertion) = RIEN or n=tailleChoisit then
							while n/=1 loop
								tab(tailleChoisit-(n-1),posInsertion):=tab(tailleChoisit-(n-1-1),posInsertion);-------------------------------------------
								n:=n-1;
							end loop;
							tab(tailleChoisit-n+1,posInsertion):=joueur;
							pionInserer:=TRUE;
						else
							n:=n+1;
						end if;
					end loop;
		when EST => while not pionInserer loop
						if tab(posInsertion,tailleChoisit-n+1) = RIEN or n=tailleChoisit then
							while n/=1 loop
								tab(posInsertion,tailleChoisit-(n-1)):=tab(posInsertion,tailleChoisit-(n-1-1));
								n:=n-1;
							end loop;
							tab(posInsertion,tailleChoisit-n+1):=joueur;
							pionInserer:=TRUE;
						else
							n:=n+1;
						end if;
					end loop;
		when WES => while not pionInserer loop
						if tab(posInsertion,n) = RIEN or n=tailleChoisit then
							while n/=1 loop
								tab(posInsertion,n):=tab(posInsertion,n-1);
								n:=n-1;
							end loop;
							tab(posInsertion,n):=joueur;
							pionInserer:=TRUE;
						else
							n:=n+1;
						end if;
					end loop;
	end case;
end insererPion;
--déclaration tours d'un joueur
dir1:Direction;
posInsertion:Integer;
directionEnCharacter:string:="lol";
--begin du tours d'un joueur
begin
	put("DEPUIS quel direction voulez vous inserer le pion? (les directions a taper sont 'SUD' 'NOR' 'EST' 'WES')");
	get(directionEnCharacter);
	if Direction'image(NOR) = directionEnCharacter then
		dir1:=NOR;
	elsif Direction'image(SUD) = directionEnCharacter then
		dir1:=SUD;
	elsif Direction'image(EST) = directionEnCharacter then
		dir1:=EST;
	else
		dir1:=WES;
	end if;
	put("dans quel case voulez vous l'insérer?");
	get(posInsertion);
	insererPion(tab,joueur,dir1,posInsertion,tailleChoisit);
end toursDUnJoueur;
--déclaration du programme principale
grille:Damier:=(others=>(others => RIEN));
joueurActuel,joueur1,joueur2:ValeurCase;
tourDuJoueur,tailleGrille:Integer;
finDuJeu:Boolean:=False;
--begin du programme principale
begin
	initialisation(joueur1,joueur2,tourDuJoueur,tailleGrille);
	afficherDamier(grille,tailleGrille);
	while not finDuJeu loop
		if tourDuJoueur mod 2 = 0 then
			joueurActuel:=joueur2;
		else
			joueurActuel:=joueur1;
		end if;
		toursDUnJoueur(grille,joueurActuel,tailleGrille);
		afficherDamier(grille,tailleGrille);
		tourDuJoueur:=tourDuJoueur+1;
	end loop;
end programmePrincipale;