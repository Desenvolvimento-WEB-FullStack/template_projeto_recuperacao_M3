import { AppDataSource } from "../../config/database_postgres.js";

const vacinasCatalogo = [
  {
    nome: "V10 (Polivalente Canina)",
    fabricante: "Zoetis",
    lote: "LT1001",
    data_validade: "2027-06-30",
    via_administracao: "INJETAVEL",
    especie_alvo: "CANINA",
    doses_necessarias: 3,
    intervalo_dias: 21,
    obrigatoria: true,
  },
  {
    nome: "Antirrábica",
    fabricante: "MSD Saúde Animal",
    lote: "LT2002",
    data_validade: "2027-12-31",
    via_administracao: "INJETAVEL",
    especie_alvo: "AMBAS",
    doses_necessarias: 1,
    intervalo_dias: 0,
    obrigatoria: true,
  },
  {
    nome: "V4 (Polivalente Felina)",
    fabricante: "Boehringer Ingelheim",
    lote: "LT3003",
    data_validade: "2027-09-15",
    via_administracao: "INJETAVEL",
    especie_alvo: "FELINA",
    doses_necessarias: 3,
    intervalo_dias: 21,
    obrigatoria: true,
  },
  {
    nome: "Giárdia",
    fabricante: "Zoetis",
    lote: "LT4004",
    data_validade: "2027-03-20",
    via_administracao: "INJETAVEL",
    especie_alvo: "AMBAS",
    doses_necessarias: 2,
    intervalo_dias: 21,
    obrigatoria: false,
  },
];

export const seedVacinas = async () => {
  try {
    await AppDataSource.initialize();

    for (const vacina of vacinasCatalogo) {
      await AppDataSource.query(
        `INSERT INTO vacinas
          (nome, fabricante, lote, data_validade, via_administracao, especie_alvo, doses_necessarias, intervalo_dias, obrigatoria)
         VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
         ON CONFLICT (lote) DO NOTHING`,
        [
          vacina.nome,
          vacina.fabricante,
          vacina.lote,
          vacina.data_validade,
          vacina.via_administracao,
          vacina.especie_alvo,
          vacina.doses_necessarias,
          vacina.intervalo_dias,
          vacina.obrigatoria,
        ],
      );
    }

    const [{ total }] = await AppDataSource.query(
      `SELECT COUNT(*)::int AS total FROM vacinas`,
    );

    console.log(`Seed de vacinas concluída. Total de registros: ${total}`);
  } catch (error) {
    console.error("Erro ao criar seed de vacinas:", error);
    process.exitCode = 1;
  } finally {
    if (AppDataSource.isInitialized) {
      await AppDataSource.destroy();
    }
  }
};
