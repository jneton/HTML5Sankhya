SELECT
       ite.nunota,
       ite.sequencia,
       ite.codprod,
       pro.descrprod,
       pro.m3,
       (ite.qtdneg - ite.qtdentregue - ite.qtdconferida) AS qtd_pendente,
       (ite.qtdneg - ite.qtdentregue - ite.qtdconferida)
         * (ite.ad_vlrliq / NULLIF(ite.qtdneg, 0)) AS valor_pendente,
       (ite.qtdneg - ite.qtdentregue - ite.qtdconferida)
         * ite.ad_vlrunitfrete AS valor_frete
  FROM tgfite ite
  JOIN tgfpro pro
    ON pro.codprod = ite.codprod
 WHERE ite.nunota = :A_NUNOTA
   AND ite.pendente = 'S'
 ORDER BY ite.sequencia
