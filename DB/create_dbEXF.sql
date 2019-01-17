
CREATE SEQUENCE public.type_plat_type_plat_id_seq;

CREATE TABLE public.type_plat (
                type_plat_id INTEGER NOT NULL DEFAULT nextval('public.type_plat_type_plat_id_seq'),
                nom_type_plat VARCHAR(50) NOT NULL,
                CONSTRAINT type_plat_pk PRIMARY KEY (type_plat_id)
);


ALTER SEQUENCE public.type_plat_type_plat_id_seq OWNED BY public.type_plat.type_plat_id;

CREATE SEQUENCE public.livreur_livreur_id_seq;

CREATE TABLE public.livreur (
                livreur_id INTEGER NOT NULL DEFAULT nextval('public.livreur_livreur_id_seq'),
                nom VARCHAR(100) NOT NULL,
                prenom VARCHAR(100) NOT NULL,
                statut_livreur VARCHAR(100) NOT NULL,
                position_actuelle VARCHAR NOT NULL,
                CONSTRAINT livreur_pk PRIMARY KEY (livreur_id)
);


ALTER SEQUENCE public.livreur_livreur_id_seq OWNED BY public.livreur.livreur_id;

CREATE SEQUENCE public.plat_plat_id_seq;

CREATE TABLE public.plat (
                plat_id INTEGER NOT NULL DEFAULT nextval('public.plat_plat_id_seq'),
                date_parution DATE NOT NULL,
                nom_du_plat VARCHAR(100) NOT NULL,
                prix NUMERIC(7,2) NOT NULL,
                type_plat_id INTEGER NOT NULL,
                CONSTRAINT plat_pk PRIMARY KEY (plat_id)
);


ALTER SEQUENCE public.plat_plat_id_seq OWNED BY public.plat.plat_id;

CREATE SEQUENCE public.panier_livreur_panier_livreur_id_seq;

CREATE TABLE public.panier_livreur (
                panier_livreur_id INTEGER NOT NULL DEFAULT nextval('public.panier_livreur_panier_livreur_id_seq'),
                livreur_id INTEGER NOT NULL,
                plat_id INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT panier_livreur_pk PRIMARY KEY (panier_livreur_id, livreur_id)
);


ALTER SEQUENCE public.panier_livreur_panier_livreur_id_seq OWNED BY public.panier_livreur.panier_livreur_id;

CREATE SEQUENCE public.client_client_id_seq;

CREATE TABLE public.client (
                client_id INTEGER NOT NULL DEFAULT nextval('public.client_client_id_seq'),
                nom VARCHAR(100) NOT NULL,
                prenom VARCHAR(100) NOT NULL,
                telephone CHAR(10) NOT NULL,
                email VARCHAR(50) NOT NULL,
                CONSTRAINT client_pk PRIMARY KEY (client_id)
);


ALTER SEQUENCE public.client_client_id_seq OWNED BY public.client.client_id;

CREATE SEQUENCE public.adresse_adresse_id_seq;

CREATE TABLE public.adresse (
                adresse_id INTEGER NOT NULL DEFAULT nextval('public.adresse_adresse_id_seq'),
                client_id INTEGER NOT NULL,
                numero_voie SMALLINT NOT NULL,
                rue VARCHAR(300) NOT NULL,
                code_postal INTEGER NOT NULL,
                ville VARCHAR(200) NOT NULL,
                CONSTRAINT adresse_pk PRIMARY KEY (adresse_id)
);


ALTER SEQUENCE public.adresse_adresse_id_seq OWNED BY public.adresse.adresse_id;

CREATE SEQUENCE public.commande_commande_id_seq;

CREATE TABLE public.commande (
                commande_id INTEGER NOT NULL DEFAULT nextval('public.commande_commande_id_seq'),
                client_id INTEGER NOT NULL,
                livreur_id INTEGER NOT NULL,
                date_commande DATE NOT NULL,
                date_livraison DATE NOT NULL,
                prix_total NUMERIC(7,2) NOT NULL,
                validation BOOLEAN NOT NULL,
                heure_depart TIME NOT NULL,
                heure_estimee TIME NOT NULL,
                heure_fin TIME NOT NULL,
                adresse_id INTEGER NOT NULL,
                CONSTRAINT commande_pk PRIMARY KEY (commande_id)
);


ALTER SEQUENCE public.commande_commande_id_seq OWNED BY public.commande.commande_id;

CREATE SEQUENCE public.commande_details_commande_details_id_seq;

CREATE TABLE public.commande_details (
                commande_details_id INTEGER NOT NULL DEFAULT nextval('public.commande_details_commande_details_id_seq'),
                commande_id INTEGER NOT NULL,
                plat_id INTEGER NOT NULL,
                quantite INTEGER NOT NULL,
                CONSTRAINT commande_details_pk PRIMARY KEY (commande_details_id, commande_id, plat_id)
);


ALTER SEQUENCE public.commande_details_commande_details_id_seq OWNED BY public.commande_details.commande_details_id;

ALTER TABLE public.plat ADD CONSTRAINT type_plat_plat_fk
FOREIGN KEY (type_plat_id)
REFERENCES public.type_plat (type_plat_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.panier_livreur ADD CONSTRAINT livreur_panier_livreur_fk
FOREIGN KEY (livreur_id)
REFERENCES public.livreur (livreur_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT livreur_commande_fk
FOREIGN KEY (livreur_id)
REFERENCES public.livreur (livreur_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande_details ADD CONSTRAINT plat_commande_details_fk
FOREIGN KEY (plat_id)
REFERENCES public.plat (plat_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.panier_livreur ADD CONSTRAINT plat_panier_livreur_fk
FOREIGN KEY (plat_id)
REFERENCES public.plat (plat_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT client_commande_fk
FOREIGN KEY (client_id)
REFERENCES public.client (client_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.adresse ADD CONSTRAINT client_adresse_fk
FOREIGN KEY (client_id)
REFERENCES public.client (client_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande ADD CONSTRAINT adresse_commande_fk
FOREIGN KEY (adresse_id)
REFERENCES public.adresse (adresse_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE public.commande_details ADD CONSTRAINT commande_commande_details_fk
FOREIGN KEY (commande_id)
REFERENCES public.commande (commande_id)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
