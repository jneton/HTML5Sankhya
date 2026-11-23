SELECT
       cab.ordemcarga,
       cab.nunota,
       cab.dtneg,
       ite.codprod,
       pro.descrprod,
       parc.nomeparc,
       cid.nomecid,
       ufs.uf,
       (ite.qtdneg - ite.qtdentregue - ite.qtdconferida) AS pendente,
       pro.m3 * (ite.qtdneg - ite.qtdentregue - ite.qtdconferida) AS volume_m3,
       (ite.qtdneg - ite.qtdentregue - ite.qtdconferida)
         * (ite.ad_vlrliq / NULLIF(ite.qtdneg, 0)) AS valor_pendente,
       (ite.qtdneg - ite.qtdentregue - ite.qtdconferida)
         * ite.ad_vlrunitfrete AS valor_frete
  FROM tgfcab cab
  JOIN tgfite ite
    ON ite.nunota = cab.nunota
  JOIN tgfpro pro
    ON pro.codprod = ite.codprod
  JOIN tgfpar parc
    ON parc.codparc = cab.codparc
  LEFT JOIN tsicid cid
    ON cid.codcid = parc.codcid
  LEFT JOIN tsiufs ufs
    ON ufs.coduf = cid.uf
  LEFT JOIN tgford ord
    ON ord.ordemcarga = cab.ordemcarga
 WHERE cab.tipmov = 'P'
   AND cab.pendente = 'S'
   AND ite.pendente = 'S'
   AND cab.ordemcarga IN (:P_OC)
   AND COALESCE(ord.ad_formconc, 'N') IN (:SIT)
   AND ite.codprod = NVL(:A_CODPROD, -1)
 ORDER BY cab.ordemcarga, cab.nunota
