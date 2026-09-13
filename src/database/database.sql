CREATE TABLE "pets"(
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(100) NOT NULL,
    "tipo_id" INTEGER NOT NULL,
    "raca_id" INTEGER NOT NULL,
    "cor_id" INTEGER NOT NULL,
    "porte" VARCHAR(255) CHECK
        ("porte" IN('P', 'M', 'G')) NOT NULL,
    "sexo" VARCHAR(255) CHECK
        ("sexo" IN('M', 'F')) NULL,
    "foto_url" VARCHAR(255) NULL,
    "historia" TEXT NULL,
    "comportamento" TEXT NULL,
    "observacoes_extras" TEXT NULL,
    "idade_meses" INTEGER NULL,
    "criado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW(),
    "atualizado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW()
);
ALTER TABLE
    "pets" ADD PRIMARY KEY("id");

CREATE TABLE "tipos"(
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(100) NOT NULL,
    "criado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW(),
    "atualizado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW()
);
ALTER TABLE
    "tipos" ADD PRIMARY KEY("id");
ALTER TABLE
    "tipos" ADD CONSTRAINT "tipos_nome_unique" UNIQUE("nome");

CREATE TABLE "racas"(
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(100) NOT NULL,
    "criado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW(),
    "atualizado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW()
);
ALTER TABLE
    "racas" ADD PRIMARY KEY("id");
ALTER TABLE
    "racas" ADD CONSTRAINT "racas_nome_unique" UNIQUE("nome");

CREATE TABLE "cores"(
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(100) NOT NULL,
    "criado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW(),
    "atualizado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW()
);
ALTER TABLE
    "cores" ADD PRIMARY KEY("id");
ALTER TABLE
    "cores" ADD CONSTRAINT "cores_nome_unique" UNIQUE("nome");

CREATE TABLE "vacinas"(
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(150) NOT NULL,
    "fabricante" VARCHAR(150) NOT NULL,
    "lote" VARCHAR(20) NOT NULL,
    "data_validade" DATE NOT NULL,
    "via_administracao" VARCHAR(255) CHECK
        ("via_administracao" IN('ORAL', 'INJETAVEL', 'NASAL')) NOT NULL,
    "especie_alvo" VARCHAR(255) CHECK
        ("especie_alvo" IN('CANINA', 'FELINA', 'AMBAS')) NOT NULL,
    "doses_necessarias" INTEGER NOT NULL,
    "intervalo_dias" INTEGER NOT NULL,
    "obrigatoria" BOOLEAN NOT NULL DEFAULT FALSE,
    "criado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW(),
    "atualizado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW()
);
ALTER TABLE
    "vacinas" ADD PRIMARY KEY("id");
ALTER TABLE
    "vacinas" ADD CONSTRAINT "vacinas_lote_unique" UNIQUE("lote");

CREATE TABLE "vacinacoes"(
    "id" SERIAL NOT NULL,
    "pet_id" INTEGER NOT NULL,
    "vacina_id" INTEGER NOT NULL,
    "observacoes" TEXT NULL,
    "criado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW(),
    "atualizado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW()
);
ALTER TABLE
    "vacinacoes" ADD PRIMARY KEY("id");

CREATE TABLE "usuarios"(
    "id" SERIAL NOT NULL,
    "nome" VARCHAR(50) NOT NULL,
    "email" VARCHAR(150) NOT NULL,
    "senha" VARCHAR(100) NOT NULL,
    "role" VARCHAR(255) CHECK
        ("role" IN('admin', 'funcionario')) NOT NULL,
    "criado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW(),
    "atualizado_em" TIMESTAMP(0) WITH TIME ZONE NOT NULL DEFAULT NOW()
);
ALTER TABLE
    "usuarios" ADD PRIMARY KEY("id");
ALTER TABLE
    "usuarios" ADD CONSTRAINT "usuarios_email_unique" UNIQUE("email");

ALTER TABLE
    "pets" ADD CONSTRAINT "pets_cor_id_foreign" FOREIGN KEY("cor_id") REFERENCES "cores"("id");
ALTER TABLE
    "pets" ADD CONSTRAINT "pets_tipo_id_foreign" FOREIGN KEY("tipo_id") REFERENCES "tipos"("id");
ALTER TABLE
    "pets" ADD CONSTRAINT "pets_raca_id_foreign" FOREIGN KEY("raca_id") REFERENCES "racas"("id");
ALTER TABLE
    "vacinacoes" ADD CONSTRAINT "vacinacoes_pet_id_foreign" FOREIGN KEY("pet_id") REFERENCES "pets"("id");
ALTER TABLE
    "vacinacoes" ADD CONSTRAINT "vacinacoes_vacina_id_foreign" FOREIGN KEY("vacina_id") REFERENCES "vacinas"("id");
