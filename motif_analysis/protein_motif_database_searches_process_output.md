protein_motif_database_searches_process_output
================
Janet Young

2026-07-24

# Goal

Used protein motifs (output by MEME) to search selected genomes and
proteomes - this script parses the output to help sort through the many
weak hits we get.

Search methods: FIMO, MAST and hmmsearch.

# Genomes and proteomes we’re searching

We search 12 species, two databases for each, comprising three groups:

- `placental_other`: ‘positive control’ species - placental mammals
  where we should find EZHIP, including the KLP motif (motif 9)
- `afrotheria`: four Afrotheria species that seem to have lost KLP in
  EZHIP
- `marsupial/monotreme`: four outgroup species where we want to look for
  remote homologs

For each species we search:

- predicted proteomes downloaded from NCBI. Should work better for
  intron-containing genes, but may be incomplete for some genes
- 6-frame translations of the whole genome. More complete than the
  predicted proteome, but not as good for intron-containing genes, and
  may yield a lot of noise

Here are the 12 species we searched:

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

species
</th>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

species group
</th>

<th style="text-align:left;">

proteome
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

human
</td>

<td style="text-align:left;">

hg38
</td>

<td style="text-align:left;">

placental_other
</td>

<td style="text-align:left;">

GCF_000001405.40_GRCh38.p14_protein.faa
</td>

</tr>

<tr>

<td style="text-align:left;">

mouse
</td>

<td style="text-align:left;">

mm39
</td>

<td style="text-align:left;">

placental_other
</td>

<td style="text-align:left;">

GCF_000001635.27_GRCm39_protein.faa
</td>

</tr>

<tr>

<td style="text-align:left;">

horse
</td>

<td style="text-align:left;">

equCab3
</td>

<td style="text-align:left;">

placental_other
</td>

<td style="text-align:left;">

GCF_002863925.1_EquCab3.0_protein.faa
</td>

</tr>

<tr>

<td style="text-align:left;">

dog
</td>

<td style="text-align:left;">

canFam6
</td>

<td style="text-align:left;">

placental_other
</td>

<td style="text-align:left;">

GCF_000002285.5_Dog10K_Boxer_Tasha_protein.faa
</td>

</tr>

<tr>

<td style="text-align:left;">

African elephant
</td>

<td style="text-align:left;">

loxAfr3
</td>

<td style="text-align:left;">

afrotheria
</td>

<td style="text-align:left;">

GCF_000001905.1_Loxafr3.0_protein.faa
</td>

</tr>

<tr>

<td style="text-align:left;">

Asiatic elephant
</td>

<td style="text-align:left;">

mEleMax1
</td>

<td style="text-align:left;">

afrotheria
</td>

<td style="text-align:left;">

GCF_024166365.1_mEleMax1_primary_haplotype_protein.faa
</td>

</tr>

<tr>

<td style="text-align:left;">

dugong
</td>

<td style="text-align:left;">

mDugDug1
</td>

<td style="text-align:left;">

afrotheria
</td>

<td style="text-align:left;">

GCA_030035585.1_mDugDug1.hap1_protein.faa
</td>

</tr>

<tr>

<td style="text-align:left;">

manatee
</td>

<td style="text-align:left;">

TriManLat1
</td>

<td style="text-align:left;">

afrotheria
</td>

<td style="text-align:left;">

GCF_000243295.1_TriManLat1.0_protein.faa
</td>

</tr>

<tr>

<td style="text-align:left;">

opossum
</td>

<td style="text-align:left;">

mMonDom1
</td>

<td style="text-align:left;">

marsupial
</td>

<td style="text-align:left;">

opossum_mMonDom1_Jan2023/protein.faa
</td>

</tr>

<tr>

<td style="text-align:left;">

wallaby
</td>

<td style="text-align:left;">

mMacEug1
</td>

<td style="text-align:left;">

marsupial
</td>

<td style="text-align:left;">

GCF_028372415.1_mMacEug1.pri_v2_protein.faa
</td>

</tr>

<tr>

<td style="text-align:left;">

tasmanian devil
</td>

<td style="text-align:left;">

mSarHar1
</td>

<td style="text-align:left;">

marsupial
</td>

<td style="text-align:left;">

tasmanianDevil_mSarHar1.11_Nov2019/protein.faa
</td>

</tr>

<tr>

<td style="text-align:left;">

platypus
</td>

<td style="text-align:left;">

mOrnAna1
</td>

<td style="text-align:left;">

monotreme
</td>

<td style="text-align:left;">

GCF_004115215.2_mOrnAna1.pri.v4_protein.faa
</td>

</tr>

</tbody>

</table>

# FIMO search output

From [MEME suite
documentation](https://meme-suite.org/meme/doc/fimo.html) - “FIMO scans
a set of sequences for individual matches to each of the motifs you
provide”

## FIMO search of 12 selected proteomes

FIMO seems to be very lenient - there are many many weak hits for all
motifs.

Therefore here we look only at motif 9 (the KLP motif) for FIMO.

### FIMO motif 9 hits (KLP) in human proteome (top 5)

EZHIP itself is the only hit that looks good (EZHIP2 is not in the
annotated proteome)

    ## 
    ## 
    ## #### match:   NP_981952.1 ; p-value=1.05e-26
    ## description:  EZH inhibitory protein [Homo sapiens]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:           ||||||||||||||||||   
    ## motif_match:       WHAVRMRASSPSPPGRFFLPI
    ##  
    ## 
    ## #### match:   NP_001152758.1 ; p-value=1.66e-09
    ## description:  polyamine deacetylase HDAC10 isoform 2 [Homo sapiens]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             || |  || || ||  |  
    ## motif_match:       VTAVPMSPSSHSPEGRPPPLL
    ##  
    ## 
    ## #### match:   NP_114408.3 ; p-value=1.66e-09
    ## description:  polyamine deacetylase HDAC10 isoform 1 [Homo sapiens]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             || |  || || ||  |  
    ## motif_match:       VTAVPMSPSSHSPEGRPPPLL
    ##  
    ## 
    ## #### match:   NP_057417.3 ; p-value=1.55e-08
    ## description:  serine/arginine repetitive matrix protein 2 [Homo sapiens]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:              || |  | ||  |     
    ## motif_match:       RSPVRRRSRSRSPARRSGRSR
    ##  
    ## 
    ## #### match:   NP_114124.1 ; p-value=1.64e-08
    ## description:  Krueppel-like factor 16 [Homo sapiens]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             | |  | ||  ||   | |
    ## motif_match:       VRAARREAASPGTPGPPPPPP

### FIMO motif 9 hits (KLP) in Afrotheria proteomes

Show the best two hits by p-value for each genome - the alignments are
unimpressive:

    ## 
    ## 
    ## #### match:   XP_012410047.1 ; p-value=3.09e-09
    ## description:  serine/arginine repetitive matrix protein 2 isoform X2 [Trichechus manatus latirostris]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:              || |  | ||  |     
    ## motif_match:       RSPVRRRSRSRSPARRGGRSR
    ##  
    ## 
    ## #### match:   XP_004384536.1 ; p-value=2.07e-08
    ## description:  PGC-1 and ERR-induced regulator in muscle protein 1 [Trichechus manatus latirostris]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:              ||   ||||      | |
    ## motif_match:       RRQVRRGHSSPSLSPSPSPSP
    ##  
    ## 
    ## #### match:   XP_023407620.1 ; p-value=1.78e-08
    ## description:  PGC-1 and ERR-induced regulator in muscle protein 1 [Loxodonta africana]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:                 |  ||||     |  
    ## motif_match:       GRPSPSRSPSPSPSRSPSPSH
    ##  
    ## 
    ## #### match:   XP_003421264.1 ; p-value=1.99e-08
    ## description:  LOW QUALITY PROTEIN: gap junction gamma-2 protein [Loxodonta africana]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             | | |      | |  | |
    ## motif_match:       RRALRRRHGRLPGPRRPPPPP
    ##  
    ## 
    ## #### match:   KAM9206384.1 ; p-value=1.25e-09
    ## description:  pappalysin-1 [Dugong dugon]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             |   ||||| ||    | |
    ## motif_match:       RAARGRRASSPPPPPPPPPPP
    ##  
    ## 
    ## #### match:   KAM9241683.1 ; p-value=1.85e-09
    ## description:  PGC-1 and ERR-induced regulator in muscle protein 1 [Dugong dugon]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:              ||   |||||     |  
    ## motif_match:       RRQVRRGHSSPSPSPSPSPSR
    ##  
    ## 
    ## #### match:   XP_049731451.1 ; p-value=1.78e-08
    ## description:  PGC-1 and ERR-induced regulator in muscle protein 1 [Elephas maximus indicus]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:                 |  ||||     |  
    ## motif_match:       GRPSPSRSPSPSPSRSPSPSH
    ##  
    ## 
    ## #### match:   XP_049752584.1 ; p-value=1.87e-08
    ## description:  TNF receptor-associated factor 2 isoform X1 [Elephas maximus indicus]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             |  | | |  |||      
    ## motif_match:       QAAAPMAAASVTPPGSLDLLQ

### FIMO motif 9 hits (KLP) in outgroup proteomes (marsupial/monotreme)

Show the best two hits by p-value for each genome - the alignments are
unimpressive:

    ## 
    ## 
    ## #### proteome:  mMacEug1
    ## match:   XP_072464324.1 ; p-value=3.23e-11
    ## description:  uncharacterized protein C19orf47 homolog isoform X3 [Notamacropus eugenii]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             ||  |||||||||  |   
    ## motif_match:       MVAVAARASSPSPPGEGFFRR
    ##  
    ## 
    ## #### proteome:  mMacEug1
    ## match:   XP_072464327.1 ; p-value=3.23e-11
    ## description:  uncharacterized protein C19orf47 homolog isoform X6 [Notamacropus eugenii]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             ||  |||||||||  |   
    ## motif_match:       MVAVAARASSPSPPGEGFFRR
    ##  
    ## 
    ## #### proteome:  mMonDom1
    ## match:   XP_056657099.1 ; p-value=4.96e-09
    ## description:  LOW QUALITY PROTEIN: solute carrier family 22 member 18 [Monodelphis domestica]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:            |  | | |   |||| |  |
    ## motif_match:       AHLRRGRKSREGPPGRRFCPP
    ##  
    ## 
    ## #### proteome:  mMonDom1
    ## match:   XP_001374281.1 ; p-value=1.04e-08
    ## description:  V-type proton ATPase subunit S1 [Monodelphis domestica]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             | |  ||||| |    | |
    ## motif_match:       ASAARPPASSPSSPPPPPPPP
    ##  
    ## 
    ## #### proteome:  mOrnAna1
    ## match:   XP_039769282.1 ; p-value=6.32e-10
    ## description:  sphingosine kinase 2 [Ornithorhynchus anatinus]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             | |  | |||||   |   
    ## motif_match:       APAARSPAPSPSPPPSPFSPS
    ##  
    ## 
    ## #### proteome:  mOrnAna1
    ## match:   XP_028928915.1 ; p-value=6.32e-10
    ## description:  sphingosine kinase 2 [Ornithorhynchus anatinus]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             | |  | |||||   |   
    ## motif_match:       APAARSPAPSPSPPPSPFSPS
    ##  
    ## 
    ## #### proteome:  mSarHar1
    ## match:   XP_031817256.1 ; p-value=1.61e-09
    ## description:  porimin [Sarcophilus harrisii]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             |    || || | | ||  
    ## motif_match:       RSAALRPASRPSRPPRLFPPR
    ##  
    ## 
    ## #### proteome:  mSarHar1
    ## match:   XP_031799382.1 ; p-value=8.59e-09
    ## description:  serine/arginine repetitive matrix protein 1-like [Sarcophilus harrisii]
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             | | | ||||||       
    ## motif_match:       SPALRERNSSPSPPSPPSSSR

## FIMO search of 12 selected genome-6frame translations

### FIMO motif 9 hits (KLP) in human 6-frame translation (top 5)

Top hit is EZHIP (chrX), second hit is EZHIP2 (chr5), and the rest look
unimpressive

    ## 
    ## 
    ## #### genome:  hg38
    ## match:   chrX_21027 ; p-value=1.05e-26
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:           ||||||||||||||||||   
    ## motif_match:       WHAVRMRASSPSPPGRFFLPI
    ##  
    ## 
    ## #### genome:  hg38
    ## match:   chr5_132898 ; p-value=4.44e-23
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:           |||||| |||||||||||   
    ## motif_match:       WHAVRMHASSPSPPGRFFLPI
    ##  
    ## 
    ## #### genome:  hg38
    ## match:   chrX_110780 ; p-value=9.45e-11
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:              || |||| |||      |
    ## motif_match:       RPEVRPRASSTSPPRAPYLRP
    ##  
    ## 
    ## #### genome:  hg38
    ## match:   chr7_108695 ; p-value=2.91e-10
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             | | ||  | || |  | |
    ## motif_match:       RRALRLRARPPPPPPRRLPSP
    ##  
    ## 
    ## #### genome:  hg38
    ## match:   chr7_104368 ; p-value=3.2e-10
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:              |  |||   || |    |
    ## motif_match:       AAPVPARASPSTPPRRLRELP

### FIMO motif 9 hits (KLP) in afrotheria 6-frame translations (top 2 per species)

Show the best two hits by p-value for each genome - they seem
unimpressive:

    ## 
    ## 
    ## #### genome:  TriManLat1
    ## match:   NW_004443964.1_33059 ; p-value=2.13e-11
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             | | |||||||||   |  
    ## motif_match:       ATATRHRASSPSPPGDCIPLS
    ##  
    ## 
    ## #### genome:  TriManLat1
    ## match:   NW_004444121.1_2251 ; p-value=8.17e-11
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:               | ||  | |||| |  |
    ## motif_match:       HKPLRNRAQAPRPPGRPFLRP
    ##  
    ## 
    ## #### genome:  loxAfr3
    ## match:   scaffold_88_3054 ; p-value=6.73e-11
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:           |  |   ||||| | | |   
    ## motif_match:       WNQVPEPASSPSLPSRLFLSR
    ##  
    ## 
    ## #### genome:  loxAfr3
    ## match:   scaffold_41_7777 ; p-value=8.82e-11
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:           |||   ||    |||      
    ## motif_match:       WHALGPRARGQTPPGSPLTPH
    ##  
    ## 
    ## #### genome:  mDugDug1
    ## match:   CM057468.1_107564 ; p-value=1.12e-10
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:            ||   || || | |   |  
    ## motif_match:       AHALSRRANSPGPQGTHLPPS
    ##  
    ## 
    ## #### genome:  mDugDug1
    ## match:   CM057462.1_38572 ; p-value=1.31e-10
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:           | | |  | ||||||      
    ## motif_match:       WRAGRRGAPSPSPPGSACTSA
    ##  
    ## 
    ## #### genome:  mEleMax1
    ## match:   NC_064822.1_156243 ; p-value=6.01e-11
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:                  |  |||| | ||  
    ## motif_match:       SRPLPLDAPWPSPPRRPFPPR
    ##  
    ## 
    ## #### genome:  mEleMax1
    ## match:   NC_064827.1_9935 ; p-value=6.73e-11
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:           |  |   ||||| | | |   
    ## motif_match:       WNQVPEPASSPSLPSRLFLSR

### FIMO motif 9 hits (KLP) in marsupials/monotreme 6-frame translations (top 2 per species)

Show the best two hits by p-value for each genome - they seem
unimpressive:

    ## 
    ## 
    ## #### genome:  mMacEug1
    ## match:   CM051814.1_348527 ; p-value=8.93e-13
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:                | |||||||  || | 
    ## motif_match:       GPKLPMQASSPSPPPSFFFFF
    ##  
    ## 
    ## #### genome:  mMacEug1
    ## match:   CM051814.1_23274 ; p-value=1.01e-10
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:                 | | | ||||  |  
    ## motif_match:       RRPLPPRRSAPPPPGRIQPPL
    ##  
    ## 
    ## #### genome:  mMonDom1
    ## match:   NC_077230.1_143420 ; p-value=2.91e-13
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:           ||    ||||  |||| ||  
    ## motif_match:       WHSLLPRASSRPPPGRLFPPL
    ##  
    ## 
    ## #### genome:  mMonDom1
    ## match:   NC_077228.1_221049 ; p-value=4.58e-12
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             ||||||| | || |     
    ## motif_match:       GVAVRMRASTPPPPLRTLSPR
    ##  
    ## 
    ## #### genome:  mOrnAna1
    ## match:   NC_041738.1_97882 ; p-value=7.61e-12
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             | | ||| |||| |  | |
    ## motif_match:       AAAPRSRASRPSPPSRLPPPP
    ##  
    ## 
    ## #### genome:  mOrnAna1
    ## match:   NC_041743.1_65841 ; p-value=1.46e-11
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:               | | ||||   |  | |
    ## motif_match:       GRPGRRRPSSPSTWIRPYPPP
    ##  
    ## 
    ## #### genome:  mSarHar1
    ## match:   NC_045429.1_119935 ; p-value=3.51e-12
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:             |   ||| | || |  |  
    ## motif_match:       RRAAPRRASLPLPPPRPLPPR
    ##  
    ## 
    ## #### genome:  mSarHar1
    ## match:   NC_045428.1_191043 ; p-value=7.26e-12
    ## motif_consensus:   WHAVRMRASSPSPPGRFFPFP
    ## matches:               |  |||| |||   |||
    ## motif_match:       GRGRRRGASSPDPPGPLGPFP

# MAST search output

From [MEME suite
documentation](https://meme-suite.org/meme/doc/mast.html): “MAST
searches sequences for matches to a set of motifs, and sorts the
sequences by the best combined match to all motifs”

## MAST search of 12 selected proteomes

### MAST hits in human proteome (top 2 by target e-value):

To help us understand MAST output and scoring, look at the top 2 hits in
the human annotated proteome (proteome doesn’t include EZHIP2). The
“motif diag ezhip” column shows all the motifs found in a single target
sequence, in order in the sequence (numbered as in Figure 2).

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

sequence name
</th>

<th style="text-align:left;">

target e value orig
</th>

<th style="text-align:right;">

num diff motifs
</th>

<th style="text-align:left;">

motif diag ezhip
</th>

<th style="text-align:left;">

sequence description
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

3.9e-231
</td>

<td style="text-align:right;">

10
</td>

<td style="text-align:left;">

1-2-3-4-5-6-6-7-8-9-10
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_047287577.1
</td>

<td style="text-align:left;">

0.19
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

7
</td>

<td style="text-align:left;">

pleckstrin homology domain-containing family H member 1 isoform X8
\[Homo sapiens\]
</td>

</tr>

</tbody>

</table>

Show the actual motif matches for those two hits. Second hit is
unimpressive (EZHIP2 is not in the annotated proteome)

    ## 
    ## 
    ## ######## target: NP_981952.1; description EZH inhibitory protein [Homo sapiens] 
    ## 
    ## ## EZHIP-1 ; motif start pos 7
    ## MEKEQKHQQGEVPGGPKNEVALAPGDACG
    ## +++++++++++ +++++++++++++++++
    ## MEKEQKHQQDEGQGGLNNETALASGDACG
    ## 
    ## ## EZHIP-2 ; motif start pos 38
    ## NPDPAASVPTVSSQLSPSGGGAPSSGTAGSSAAALAAAGAI
    ## +++++++++++++++++++++++++++++++++++++++++
    ## NQDPAASVTTVSSQASPSGGAALSSSTAGSSAAAATSAAIF
    ## 
    ## ## EZHIP-3 ; motif start pos 98
    ## SDLQGGRSPHAELGCVVPEGGQGAQVGPA
    ## ++ ++++++++++++++++++++++++++
    ## SDRQDCRSPHEVFGCVVPEGGSQAAVGPQ
    ## 
    ## ## EZHIP-4 ; motif start pos 134
    ## GHPTQTKSPGNGRGRKQPSREZAAQAQKP
    ## +++++++++++++++++++++++++++++
    ## EHLAQTKSPGNSRRRKQPCRNQAAPAQKP
    ## 
    ## ## EZHIP-5 ; motif start pos 198
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ## ++++++++++++++++++++++++++++++++++
    ## PGPALLSHASEARPATRSRITLVASALRRRASGP
    ## 
    ## ## EZHIP-6 ; motif start pos 232
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## ++  ++ + ++++++  +++   +++ + 
    ## GPVIRGCTAQPGPAFPHRATHLDPARLSP
    ## 
    ## ## EZHIP-6 ; motif start pos 265
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## +++++++++++++++++++++++++++++
    ## GPARRGRASVPGPARRGCDSAPGPARRGR
    ## 
    ## ## EZHIP-7 ; motif start pos 323
    ## LRSRAARSGPALRSTSTTPGFVLRSRSTQ
    ## +++++++++  ++++++++++++++++++
    ## LRVRTARSDAGHRSTSTTPGTGLRSRSTQ
    ## 
    ## ## EZHIP-8 ; motif start pos 372
    ## PGAALRRLVFQSSSSSPDPEV
    ## ++++ ++++++++++++++++
    ## CGTGSERLAFQSRSGSPDPEV
    ## 
    ## ## EZHIP-9 ; motif start pos 401
    ## WHAVRMRASSPSPPGRFFPFP
    ## +++++++++++++++++++++
    ## WHAVRMRASSPSPPGRFFLPI
    ## 
    ## ## EZHIP-10 ; motif start pos 452
    ## SPKFLGLGSISTPSPASLRRALLPELDAL
    ## +++++++++++++++++++++++++++++
    ## SPEFLGLRSISTPSPESLRYALMPEFYAL
    ## 
    ## 
    ## ######## target: XP_047287577.1; description pleckstrin homology domain-containing family H member 1 isoform X8 [Homo sapiens] 
    ## 
    ## ## EZHIP-7 ; motif start pos 14
    ## LRSRAARSGPALRSTSTTPGFVLRSRSTQ
    ## + +    +++ +++ +    ++++ ++++
    ## LVSPGSFSGLVYKNVTVPVYTALKGRATQ

### MAST hits in marsupial/monotreme proteomes (top 2 by target e-value, regardless of which motifs they contain):

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

proteome
</th>

<th style="text-align:left;">

sequence name
</th>

<th style="text-align:left;">

target e value orig
</th>

<th style="text-align:right;">

num diff motifs
</th>

<th style="text-align:left;">

motif diag ezhip
</th>

<th style="text-align:left;">

sequence description
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

mMacEug1
</td>

<td style="text-align:left;">

XP_072492541.1
</td>

<td style="text-align:left;">

0.022
</td>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

6-2-4-8
</td>

<td style="text-align:left;">

telomeric repeat-binding factor 2 isoform X3 \[Notamacropus eugenii\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mMacEug1
</td>

<td style="text-align:left;">

XP_072492539.1
</td>

<td style="text-align:left;">

0.041
</td>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

6-2-4-8
</td>

<td style="text-align:left;">

telomeric repeat-binding factor 2 isoform X2 \[Notamacropus eugenii\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mMonDom1
</td>

<td style="text-align:left;">

XP_001366959.1
</td>

<td style="text-align:left;">

0.7
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

10-6
</td>

<td style="text-align:left;">

G-protein coupled receptor 12 \[Monodelphis domestica\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mMonDom1
</td>

<td style="text-align:left;">

XP_007495314.1
</td>

<td style="text-align:left;">

0.7
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

10-6
</td>

<td style="text-align:left;">

G-protein coupled receptor 12 \[Monodelphis domestica\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mOrnAna1
</td>

<td style="text-align:left;">

XP_028922515.1
</td>

<td style="text-align:left;">

0.36
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

5
</td>

<td style="text-align:left;">

apolipoprotein E \[Ornithorhynchus anatinus\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mOrnAna1
</td>

<td style="text-align:left;">

XP_028904420.1
</td>

<td style="text-align:left;">

1.1
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

10-6
</td>

<td style="text-align:left;">

G-protein coupled receptor 12 \[Ornithorhynchus anatinus\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mSarHar1
</td>

<td style="text-align:left;">

XP_023354141.2
</td>

<td style="text-align:left;">

0.077
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

9-6
</td>

<td style="text-align:left;">

myeloid differentiation primary response protein MyD88 \[Sarcophilus
harrisii\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mSarHar1
</td>

<td style="text-align:left;">

XP_031805943.1
</td>

<td style="text-align:left;">

0.28
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

2-8
</td>

<td style="text-align:left;">

telomeric repeat-binding factor 2 isoform X3 \[Sarcophilus harrisii\]
</td>

</tr>

</tbody>

</table>

Show best hits in outgroup proteomes, motif level (top 2 per genome by
target p-value):

    ## 
    ## 
    ## ######## target: XP_072492541.1; description telomeric repeat-binding factor 2 isoform X3 [Notamacropus eugenii] 
    ## 
    ## ## EZHIP-6 ; motif start pos 3
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## +    +++     + ++ +   + +++++
    ## GGSSESHDGHGRAASRRPARRLGRARRGR
    ## 
    ## ## EZHIP-2 ; motif start pos 229
    ## NPDPAASVPTVSSQLSPSGGGAPSSGTAGSSAAALAAAGAI
    ##   + +                  +++ +   ++ + +++++
    ## HMDDAEPYLLTIAKRALKSEPSSSSSSAPAATADTSTVAAV
    ## 
    ## ## EZHIP-4 ; motif start pos 282
    ## GHPTQTKSPGNGRGRKQPSREZAAQAQKP
    ##    ++   +++ +  +++  +   +  + 
    ## AVATLGEGPGNMKEDKQLALEPVEKPLKE
    ## 
    ## ## EZHIP-8 ; motif start pos 322
    ## PGAALRRLVFQSSSSSPDPEV
    ##  ++   + ++ + + + +++ 
    ## FGISTLKRAYKSLSDSQDPEA
    ## 
    ## 
    ## ######## target: XP_072492539.1; description telomeric repeat-binding factor 2 isoform X2 [Notamacropus eugenii] 
    ## 
    ## ## EZHIP-6 ; motif start pos 3
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## +    +++     + ++ +   + +++++
    ## GGSSESHDGHGRAASRRPARRLGRARRGR
    ## 
    ## ## EZHIP-2 ; motif start pos 197
    ## NPDPAASVPTVSSQLSPSGGGAPSSGTAGSSAAALAAAGAI
    ##   + +                  +++ +   ++ + +++++
    ## HMDDAEPYLLTIAKRALKSEPSSSSSSAPAATADTSTVAAV
    ## 
    ## ## EZHIP-4 ; motif start pos 250
    ## GHPTQTKSPGNGRGRKQPSREZAAQAQKP
    ##    ++   +++ +  +++  +   +  + 
    ## AVATLGEGPGNMKEDKQLALEPVEKPLKE
    ## 
    ## ## EZHIP-8 ; motif start pos 290
    ## PGAALRRLVFQSSSSSPDPEV
    ##  ++   + ++ + + + +++ 
    ## FGISTLKRAYKSLSDSQDPEA
    ## 
    ## 
    ## ######## target: XP_001366959.1; description G-protein coupled receptor 12 [Monodelphis domestica] 
    ## 
    ## ## EZHIP-10 ; motif start pos 125
    ## SPKFLGLGSISTPSPASLRRALLPELDAL
    ## +   + +  +      ++ +++    +  
    ## SASVCSLLAITVDRYLSLYYALTYNSERT
    ## 
    ## ## EZHIP-6 ; motif start pos 278
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ##  +     ++ +  ++++  +   +++++ 
    ## YPSIYTYATLLPATYNSIINPVIYAFRNQ
    ## 
    ## 
    ## ######## target: XP_007495314.1; description G-protein coupled receptor 12 [Monodelphis domestica] 
    ## 
    ## ## EZHIP-10 ; motif start pos 125
    ## SPKFLGLGSISTPSPASLRRALLPELDAL
    ## +   + +  +      ++ +++    +  
    ## SASVCSLLAITVDRYLSLYYALTYNSERT
    ## 
    ## ## EZHIP-6 ; motif start pos 278
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ##  +     ++ +  ++++  +   +++++ 
    ## YPSIYTYATLLPATYNSIINPVIYAFRNQ
    ## 
    ## 
    ## ######## target: XP_028922515.1; description apolipoprotein E [Ornithorhynchus anatinus] 
    ## 
    ## ## EZHIP-5 ; motif start pos 137
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##     ++++ + +   ++ ++++ +  ++++ +  
    ## NVEELRSRTASQLRKLRKRITKDAEELRRRITVY
    ## 
    ## 
    ## ######## target: XP_028904420.1; description G-protein coupled receptor 12 [Ornithorhynchus anatinus] 
    ## 
    ## ## EZHIP-10 ; motif start pos 120
    ## SPKFLGLGSISTPSPASLRRALLPELDAL
    ## +   + +  +      ++ +++    +  
    ## SASVCSLLAITVDRYLSLYYALTYNSERT
    ## 
    ## ## EZHIP-6 ; motif start pos 273
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ##  +     ++ +  ++++  +   +++++ 
    ## YPSMYTYATLLPATYNSVINPVIYAFRNQ
    ## 
    ## 
    ## ######## target: XP_023354141.2; description myeloid differentiation primary response protein MyD88 [Sarcophilus harrisii] 
    ## 
    ## ## EZHIP-9 ; motif start pos 13
    ## WHAVRMRASSPSPPGRFFPFP
    ##  +++   + ++ +     ++ 
    ## SRAVTAKAASPAPDIHDVPLV
    ## 
    ## ## EZHIP-6 ; motif start pos 200
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ##    + +++  ++  + +  ++   ++ ++
    ## KLCVSDRDVLPGTCVWSITSELIEKRCRR
    ## 
    ## 
    ## ######## target: XP_031805943.1; description telomeric repeat-binding factor 2 isoform X3 [Sarcophilus harrisii] 
    ## 
    ## ## EZHIP-2 ; motif start pos 246
    ## NPDPAASVPTVSSQLSPSGGGAPSSGTAGSSAAALAAAGAI
    ##   +   +  + ++ ++     +    +   +++++ ++++ 
    ## KSESSSSSSSSSSSASSAAAIAAATTTVTTTTANTSATAAT
    ## 
    ## ## EZHIP-8 ; motif start pos 339
    ## PGAALRRLVFQSSSSSPDPEV
    ##  ++   + ++ + + + +++ 
    ## FGISTLKRAFKSLSDSQDPEA

### MAST hits in marsupial/monotreme proteomes (top 2 by target e-value, only hits containing motif 9):

A lot of the best MAST hits don’t contain a match to motif 9 (the KLP).
Here the top hits if we restrict ourselves to only those that contain a
motif 9 match (top 2 per proteome) - they are unimpressive (alignments
are below the table):

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

proteome
</th>

<th style="text-align:left;">

sequence name
</th>

<th style="text-align:left;">

target e value orig
</th>

<th style="text-align:right;">

num diff motifs
</th>

<th style="text-align:left;">

motif diag ezhip
</th>

<th style="text-align:left;">

sequence description
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

mMacEug1
</td>

<td style="text-align:left;">

XP_072464325.1
</td>

<td style="text-align:left;">

0.55
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

9-7
</td>

<td style="text-align:left;">

uncharacterized protein C19orf47 homolog isoform X4 \[Notamacropus
eugenii\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mMacEug1
</td>

<td style="text-align:left;">

XP_072464324.1
</td>

<td style="text-align:left;">

0.57
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

9-7
</td>

<td style="text-align:left;">

uncharacterized protein C19orf47 homolog isoform X3 \[Notamacropus
eugenii\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mMonDom1
</td>

<td style="text-align:left;">

XP_056659687.1
</td>

<td style="text-align:left;">

0.82
</td>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

2-4-9-8
</td>

<td style="text-align:left;">

aminoacyl tRNA synthase complex-interacting multifunctional protein 1
isoform X2 \[Monodelphis domestica\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mMonDom1
</td>

<td style="text-align:left;">

XP_056659686.1
</td>

<td style="text-align:left;">

0.98
</td>

<td style="text-align:right;">

4
</td>

<td style="text-align:left;">

2-4-9-8
</td>

<td style="text-align:left;">

aminoacyl tRNA synthase complex-interacting multifunctional protein 1
isoform X1 \[Monodelphis domestica\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mOrnAna1
</td>

<td style="text-align:left;">

XP_028914561.1
</td>

<td style="text-align:left;">

1.4
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

9-2
</td>

<td style="text-align:left;">

serine-threonine kinase receptor-associated protein \[Ornithorhynchus
anatinus\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mOrnAna1
</td>

<td style="text-align:left;">

XP_039766514.1
</td>

<td style="text-align:left;">

3.4
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

9-6-6-6
</td>

<td style="text-align:left;">

LOW QUALITY PROTEIN: activity-dependent neuroprotector homeobox protein
2 \[Ornithorhynchus anatinus\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mSarHar1
</td>

<td style="text-align:left;">

XP_023354141.2
</td>

<td style="text-align:left;">

0.077
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

9-6
</td>

<td style="text-align:left;">

myeloid differentiation primary response protein MyD88 \[Sarcophilus
harrisii\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mSarHar1
</td>

<td style="text-align:left;">

XP_003765428.1
</td>

<td style="text-align:left;">

0.47
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

9-5
</td>

<td style="text-align:left;">

probable U3 small nucleolar RNA-associated protein 11 \[Sarcophilus
harrisii\]
</td>

</tr>

</tbody>

</table>

Show best hits in outgroup proteomes that contain motif 9, motif level
(top 2 per genome by target p-value, only hits containing motif 9):

    ## 
    ## 
    ## ######## target: XP_072464324.1; description uncharacterized protein C19orf47 homolog isoform X3 [Notamacropus eugenii] 
    ## 
    ## ## EZHIP-9 ; motif start pos 1
    ## WHAVRMRASSPSPPGRFFPFP
    ##   ++  +++++++++  +   
    ## MVAVAARASSPSPPGEGFFRR
    ## 
    ## ## EZHIP-7 ; motif start pos 214
    ## LRSRAARSGPALRSTSTTPGFVLRSRSTQ
    ##  + + +         ++  ++  + + + 
    ## RRRRVTAEMEGKYIITMPKGTTPRTRKIL
    ## 
    ## 
    ## ######## target: XP_072464325.1; description uncharacterized protein C19orf47 homolog isoform X4 [Notamacropus eugenii] 
    ## 
    ## ## EZHIP-9 ; motif start pos 1
    ## WHAVRMRASSPSPPGRFFPFP
    ##   ++  +++++++++  +   
    ## MVAVAARASSPSPPGEGFFRR
    ## 
    ## ## EZHIP-7 ; motif start pos 231
    ## LRSRAARSGPALRSTSTTPGFVLRSRSTQ
    ##  + + +         ++  ++  + + + 
    ## RRRRVTAEMEGKYIITMPKGTTPRTRKIL
    ## 
    ## 
    ## ######## target: XP_056659686.1; description aminoacyl tRNA synthase complex-interacting multifunctional protein 1 isoform X1 [Monodelphis domestica] 
    ## 
    ## ## EZHIP-2 ; motif start pos 82
    ## NPDPAASVPTVSSQLSPSGGGAPSSGTAGSSAAALAAAGAI
    ## +      +++  +    +      + +   +  ++++    
    ## NGVKQIPVPSGTSVQANSTSTPSENLTQSVSVPVLTSGTKG
    ## 
    ## ## EZHIP-4 ; motif start pos 125
    ## GHPTQTKSPGNGRGRKQPSREZAAQAQKP
    ## + ++ + + +++  ++    ++ + +   
    ## EEKNKKENTEKKGEKKEKKQKQPAAAASD
    ## 
    ## ## EZHIP-9 ; motif start pos 230
    ## WHAVRMRASSPSPPGRFFPFP
    ##   +  + ++++     + ++ 
    ## SQAMLMCASSPEKVEILEPPS
    ## 
    ## ## EZHIP-8 ; motif start pos 251
    ## PGAALRRLVFQSSSSSPDPEV
    ##   +   ++ +   ++ ++ + 
    ## GSVPGDRITFEGFSGEPEKEL
    ## 
    ## 
    ## ######## target: XP_056659687.1; description aminoacyl tRNA synthase complex-interacting multifunctional protein 1 isoform X2 [Monodelphis domestica] 
    ## 
    ## ## EZHIP-2 ; motif start pos 73
    ## NPDPAASVPTVSSQLSPSGGGAPSSGTAGSSAAALAAAGAI
    ## +      +++  +    +      + +   +  ++++    
    ## NGVKQIPVPSGTSVQANSTSTPSENLTQSVSVPVLTSGTKG
    ## 
    ## ## EZHIP-4 ; motif start pos 116
    ## GHPTQTKSPGNGRGRKQPSREZAAQAQKP
    ## + ++ + + +++  ++    ++ + +   
    ## EEKNKKENTEKKGEKKEKKQKQPAAAASD
    ## 
    ## ## EZHIP-9 ; motif start pos 221
    ## WHAVRMRASSPSPPGRFFPFP
    ##   +  + ++++     + ++ 
    ## SQAMLMCASSPEKVEILEPPS
    ## 
    ## ## EZHIP-8 ; motif start pos 242
    ## PGAALRRLVFQSSSSSPDPEV
    ##   +   ++ +   ++ ++ + 
    ## GSVPGDRITFEGFSGEPEKEL
    ## 
    ## 
    ## ######## target: XP_028914561.1; description serine-threonine kinase receptor-associated protein [Ornithorhynchus anatinus] 
    ## 
    ## ## EZHIP-9 ; motif start pos 14
    ## WHAVRMRASSPSPPGRFFPFP
    ##  + +   + +   +  ++++ 
    ## TRPVVDLAFSGVTPYGYFLIS
    ## 
    ## ## EZHIP-2 ; motif start pos 45
    ## NPDPAASVPTVSSQLSPSGGGAPSSGTAGSSAAALAAAGAI
    ##   + +  + + + +   + ++ +  +     ++++  ++ +
    ## QGDTGDWIGTFLGHKGAVWGATLNKDATKAATAAADFTAKV
    ## 
    ## 
    ## ######## target: XP_039766514.1; description LOW QUALITY PROTEIN: activity-dependent neuroprotector homeobox protein 2 [Ornithorhynchus anatinus] 
    ## 
    ## ## EZHIP-9 ; motif start pos 289
    ## WHAVRMRASSPSPPGRFFPFP
    ##  + ++  +  +  ++   ++ 
    ## RRPVRTSAAAPGAPGAATLPL
    ## 
    ## ## EZHIP-6 ; motif start pos 426
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## +  + +++ +++  + ++   ++  + ++
    ## GTVLVGRTVAPGALLVGRGVPPGTLLVGR
    ## 
    ## ## EZHIP-6 ; motif start pos 459
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## +    + + +++  + ++   ++    + 
    ## GALPVGQTVAPGTLLVGQTVQPGALPVGQ
    ## 
    ## ## EZHIP-6 ; motif start pos 580
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## +  + + +  ++    +++ ++   + + 
    ## GTLLVGQTLPPGALPAGRAAAPAVLRVGQ
    ## 
    ## 
    ## ######## target: XP_003765428.1; description probable U3 small nucleolar RNA-associated protein 11 [Sarcophilus harrisii] 
    ## 
    ## ## EZHIP-9 ; motif start pos 51
    ## WHAVRMRASSPSPPGRFFPFP
    ##  ++ +  +    +   ++   
    ## LRALRKKALEKNPDEFYFKMT
    ## 
    ## ## EZHIP-5 ; motif start pos 169
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ## +    + + ++ +  +++ + +++   +++ + +
    ## PRIETLQREAVMGATHQSQIQKLARERKRQYSLL
    ## 
    ## 
    ## ######## target: XP_023354141.2; description myeloid differentiation primary response protein MyD88 [Sarcophilus harrisii] 
    ## 
    ## ## EZHIP-9 ; motif start pos 13
    ## WHAVRMRASSPSPPGRFFPFP
    ##  +++   + ++ +     ++ 
    ## SRAVTAKAASPAPDIHDVPLV
    ## 
    ## ## EZHIP-6 ; motif start pos 200
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ##    + +++  ++  + +  ++   ++ ++
    ## KLCVSDRDVLPGTCVWSITSELIEKRCRR

## MAST search of 12 selected genome-6frame translations

### MAST hits in human hg38 6-frame translations (top 5 by target e-value):

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

sequence name
</th>

<th style="text-align:left;">

target e value orig
</th>

<th style="text-align:right;">

num diff motifs
</th>

<th style="text-align:left;">

motif diag ezhip
</th>

<th style="text-align:left;">

chromosome
</th>

<th style="text-align:right;">

start
</th>

<th style="text-align:right;">

end
</th>

<th style="text-align:left;">

strand
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

chrX_21027
</td>

<td style="text-align:left;">

4.6e-229
</td>

<td style="text-align:right;">

10
</td>

<td style="text-align:left;">

1-2-3-4-5-6-6-7-8-9-10
</td>

<td style="text-align:left;">

chrX
</td>

<td style="text-align:right;">

51406744
</td>

<td style="text-align:right;">

51408525
</td>

<td style="text-align:left;">

- </td>

  </tr>

  <tr>

  <td style="text-align:left;">

  chr5_8266
  </td>

  <td style="text-align:left;">

  6.1e-58
  </td>

  <td style="text-align:right;">

  4
  </td>

  <td style="text-align:left;">

  2-3-4-6-6
  </td>

  <td style="text-align:left;">

  chr5
  </td>

  <td style="text-align:right;">

  12794826
  </td>

  <td style="text-align:right;">

  12795545
  </td>

  <td style="text-align:left;">

  - </td>

    </tr>

    <tr>

    <td style="text-align:left;">

    chr5_132898
    </td>

    <td style="text-align:left;">

    1.2e-52
    </td>

    <td style="text-align:right;">

    4
    </td>

    <td style="text-align:left;">

    6-7-8-9
    </td>

    <td style="text-align:left;">

    chr5
    </td>

    <td style="text-align:right;">

    12794332
    </td>

    <td style="text-align:right;">

    12794970
    </td>

    <td style="text-align:left;">

    - </td>

      </tr>

      <tr>

      <td style="text-align:left;">

      chr4_128140
      </td>

      <td style="text-align:left;">

      5e-11
      </td>

      <td style="text-align:right;">

      1
      </td>

      <td style="text-align:left;">

      5
      </td>

      <td style="text-align:left;">

      chr4
      </td>

      <td style="text-align:right;">

      3300861
      </td>

      <td style="text-align:right;">

      3301289
      </td>

      <td style="text-align:left;">

      - </td>

        </tr>

        <tr>

        <td style="text-align:left;">

        chr21_21782
        </td>

        <td style="text-align:left;">

        5.2e-06
        </td>

        <td style="text-align:right;">

        2
        </td>

        <td style="text-align:left;">

        6-5-6
        </td>

        <td style="text-align:left;">

        chr21
        </td>

        <td style="text-align:right;">

        45527395
        </td>

        <td style="text-align:right;">

        45528279
        </td>

        <td style="text-align:left;">

        - </td>

          </tr>

          </tbody>

          </table>

Show the actual motif matches for those five hits - alignments for hits
beyond EZHIP and the two chr5 ORFs containing each end of EZHIP2 look
unimpressive

    ## 
    ## 
    ## ######## target: chrX_21027
    ## coords chrX:51406744-51408525 (+) 
    ## 
    ## ## EZHIP-1 ; motif start pos 98
    ## MEKEQKHQQGEVPGGPKNEVALAPGDACG
    ## +++++++++++ +++++++++++++++++
    ## MEKEQKHQQDEGQGGLNNETALASGDACG
    ## 
    ## ## EZHIP-2 ; motif start pos 129
    ## NPDPAASVPTVSSQLSPSGGGAPSSGTAGSSAAALAAAGAI
    ## +++++++++++++++++++++++++++++++++++++++++
    ## NQDPAASVTTVSSQASPSGGAALSSSTAGSSAAAATSAAIF
    ## 
    ## ## EZHIP-3 ; motif start pos 189
    ## SDLQGGRSPHAELGCVVPEGGQGAQVGPA
    ## ++ ++++++++++++++++++++++++++
    ## SDRQDCRSPHEVFGCVVPEGGSQAAVGPQ
    ## 
    ## ## EZHIP-4 ; motif start pos 225
    ## GHPTQTKSPGNGRGRKQPSREZAAQAQKP
    ## +++++++++++++++++++++++++++++
    ## EHLAQTKSPGNSRRRKQPCRNQAAPAQKP
    ## 
    ## ## EZHIP-5 ; motif start pos 289
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ## ++++++++++++++++++++++++++++++++++
    ## PGPALLSHASEARPATRSRITLVASALRRRASGP
    ## 
    ## ## EZHIP-6 ; motif start pos 323
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## ++  ++ + ++++++  +++   +++ + 
    ## GPVIRGCTAQPGPAFPHRATHLDPARLSP
    ## 
    ## ## EZHIP-6 ; motif start pos 356
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## +++++++++++++++++++++++++++++
    ## GPARRGRASVPGPARRGCDSAPGPARRGR
    ## 
    ## ## EZHIP-7 ; motif start pos 414
    ## LRSRAARSGPALRSTSTTPGFVLRSRSTQ
    ## +++++++++  ++++++++++++++++++
    ## LRVRTARSDAGHRSTSTTPGTGLRSRSTQ
    ## 
    ## ## EZHIP-8 ; motif start pos 463
    ## PGAALRRLVFQSSSSSPDPEV
    ## ++++ ++++++++++++++++
    ## CGTGSERLAFQSRSGSPDPEV
    ## 
    ## ## EZHIP-9 ; motif start pos 492
    ## WHAVRMRASSPSPPGRFFPFP
    ## +++++++++++++++++++++
    ## WHAVRMRASSPSPPGRFFLPI
    ## 
    ## ## EZHIP-10 ; motif start pos 543
    ## SPKFLGLGSISTPSPASLRRALLPELDAL
    ## +++++++++++++++++++++++++++++
    ## SPEFLGLRSISTPSPESLRYALMPEFYAL
    ## 
    ## 
    ## ######## target: chr5_8266
    ## coords chr5:12794826-12795545 (+) 
    ## 
    ## ## EZHIP-2 ; motif start pos 4
    ## NPDPAASVPTVSSQLSPSGGGAPSSGTAGSSAAALAAAGAI
    ##    +  +      +          + ++  ++++++ +++ 
    ## CFCPTFSCDASPCGSAALRCHTAGSNTAAATAAAIFVADEG
    ## 
    ## ## EZHIP-3 ; motif start pos 59
    ## SDLQGGRSPHAELGCVVPEGGQGAQVGPA
    ## +++++++ ++ +++++++ + +++++++ 
    ## SDLQGCRRPHHVLGCVMPYGDSQAAVGPP
    ## 
    ## ## EZHIP-4 ; motif start pos 96
    ## GHPTQTKSPGNGRGRKQPSREZAAQAQKP
    ## +++++++++ +++ ++++++++++ ++ +
    ## EHPAQTKSPANNRHRKRPGRNQAVAAQRP
    ## 
    ## ## EZHIP-6 ; motif start pos 150
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ##    + + ++++++++ ++++ +  +    
    ## RASVSSQATQPGPALLSHASGPSHASGPS
    ## 
    ## ## EZHIP-6 ; motif start pos 211
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## ++++ ++++ +++++++++ +++ +++++
    ## GPALPRRATHPGPARRGRAPAPGSDLRSH
    ## 
    ## 
    ## ######## target: chr5_132898
    ## coords chr5:12794332-12794970 (-) 
    ## 
    ## ## EZHIP-6 ; motif start pos 75
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ##    +  +++ + +++++ ++ + +++ ++
    ## LHLLFLRATPPVPAYRRGASGPSPALQRC
    ## 
    ## ## EZHIP-7 ; motif start pos 111
    ## LRSRAARSGPALRSTSTTPGFVLRSRSTQ
    ## ++++++++ ++  ++++++++++++++++
    ## LRGRTARSSPARHSTSMTPGTALRSRSTQ
    ## 
    ## ## EZHIP-8 ; motif start pos 161
    ## PGAALRRLVFQSSSSSPDPEV
    ##  +++++ +++++++++ ++++
    ## HGAGLGQLAFQSSSGSSDPEV
    ## 
    ## ## EZHIP-9 ; motif start pos 190
    ## WHAVRMRASSPSPPGRFFPFP
    ## ++++++ ++++++++++++++
    ## WHAVRMHASSPSPPGRFFLPI
    ## 
    ## 
    ## ######## target: chr4_128140
    ## coords chr4:3300861-3301289 (-) 
    ## 
    ## ## EZHIP-5 ; motif start pos 45
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ## +++ +  +++   ++++ ++   ++++ +++ + 
    ## TDPVLQRRAAGTDPVLQRRAARTDPVLQRRAAGD
    ## 
    ## 
    ## ######## target: chr21_21782
    ## coords chr21:45527395-45528279 (-) 
    ## 
    ## ## EZHIP-6 ; motif start pos 183
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## ++++ +  + +++++ ++ + ++++  ++
    ## GPAVTDCHSPPGPALPGCHSPPGPAVTDC
    ## 
    ## ## EZHIP-5 ; motif start pos 215
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ## +++++  + + +++ +     ++++++ ++ + +
    ## PGPALPGCHSPPGPTLPCCHSPPGPAVTGCHSPP
    ## 
    ## ## EZHIP-6 ; motif start pos 249
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## ++++ +  + +++++ ++ + +++++ ++
    ## GPALPGCHSPPGPAVTDCHSPPGPALPGC

### MAST hits in marsupial/monotreme 6-frame translations (top 2 per genome by target e-value):

Note that these all involve only the repetitive motifs 5 and 6:

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

sequence name
</th>

<th style="text-align:left;">

target e value orig
</th>

<th style="text-align:right;">

num diff motifs
</th>

<th style="text-align:left;">

motif diag ezhip
</th>

<th style="text-align:left;">

chromosome
</th>

<th style="text-align:right;">

start
</th>

<th style="text-align:right;">

end
</th>

<th style="text-align:left;">

strand
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

mMacEug1
</td>

<td style="text-align:left;">

CM051817.1_33102
</td>

<td style="text-align:left;">

1.6e-05
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

5-6
</td>

<td style="text-align:left;">

CM051817.1
</td>

<td style="text-align:right;">

58411277
</td>

<td style="text-align:right;">

58411642
</td>

<td style="text-align:left;">

- </td>

  </tr>

  <tr>

  <td style="text-align:left;">

  mMacEug1
  </td>

  <td style="text-align:left;">

  CM051813.1_448000
  </td>

  <td style="text-align:left;">

  0.00085
  </td>

  <td style="text-align:right;">

  1
  </td>

  <td style="text-align:left;">

  5
  </td>

  <td style="text-align:left;">

  CM051813.1
  </td>

  <td style="text-align:right;">

  155994559
  </td>

  <td style="text-align:right;">

  155994888
  </td>

  <td style="text-align:left;">

  - </td>

    </tr>

    <tr>

    <td style="text-align:left;">

    mMonDom1
    </td>

    <td style="text-align:left;">

    NC_077229.1_349614
    </td>

    <td style="text-align:left;">

    5e-07
    </td>

    <td style="text-align:right;">

    1
    </td>

    <td style="text-align:left;">

    5-5
    </td>

    <td style="text-align:left;">

    NC_077229.1
    </td>

    <td style="text-align:right;">

    43519659
    </td>

    <td style="text-align:right;">

    43519982
    </td>

    <td style="text-align:left;">

    - </td>

      </tr>

      <tr>

      <td style="text-align:left;">

      mMonDom1
      </td>

      <td style="text-align:left;">

      NC_077229.1_349616
      </td>

      <td style="text-align:left;">

      1.4e-06
      </td>

      <td style="text-align:right;">

      1
      </td>

      <td style="text-align:left;">

      5-5
      </td>

      <td style="text-align:left;">

      NC_077229.1
      </td>

      <td style="text-align:right;">

      43519227
      </td>

      <td style="text-align:right;">

      43519655
      </td>

      <td style="text-align:left;">

      - </td>

        </tr>

        <tr>

        <td style="text-align:left;">

        mOrnAna1
        </td>

        <td style="text-align:left;">

        NC_041735.1_79171
        </td>

        <td style="text-align:left;">

        4.7e-11
        </td>

        <td style="text-align:right;">

        2
        </td>

        <td style="text-align:left;">

        5-6
        </td>

        <td style="text-align:left;">

        NC_041735.1
        </td>

        <td style="text-align:right;">

        1178581
        </td>

        <td style="text-align:right;">

        1179285
        </td>

        <td style="text-align:left;">

        - </td>

          </tr>

          <tr>

          <td style="text-align:left;">

          mOrnAna1
          </td>

          <td style="text-align:left;">

          NC_041744.1_43338
          </td>

          <td style="text-align:left;">

          3.8e-07
          </td>

          <td style="text-align:right;">

          1
          </td>

          <td style="text-align:left;">

          5-5-5
          </td>

          <td style="text-align:left;">

          NC_041744.1
          </td>

          <td style="text-align:right;">

          20567450
          </td>

          <td style="text-align:right;">

          20568607
          </td>

          <td style="text-align:left;">

          - </td>

            </tr>

            <tr>

            <td style="text-align:left;">

            mSarHar1
            </td>

            <td style="text-align:left;">

            NC_045428.1_222895
            </td>

            <td style="text-align:left;">

            1.2e-05
            </td>

            <td style="text-align:right;">

            1
            </td>

            <td style="text-align:left;">

            5-5
            </td>

            <td style="text-align:left;">

            NC_045428.1
            </td>

            <td style="text-align:right;">

            554065610
            </td>

            <td style="text-align:right;">

            554065939
            </td>

            <td style="text-align:left;">

            - </td>

              </tr>

              <tr>

              <td style="text-align:left;">

              mSarHar1
              </td>

              <td style="text-align:left;">

              NC_045428.1_220687
              </td>

              <td style="text-align:left;">

              3.5e-05
              </td>

              <td style="text-align:right;">

              2
              </td>

              <td style="text-align:left;">

              6-5-6
              </td>

              <td style="text-align:left;">

              NC_045428.1
              </td>

              <td style="text-align:right;">

              557663499
              </td>

              <td style="text-align:right;">

              557663858
              </td>

              <td style="text-align:left;">

              - </td>

                </tr>

                </tbody>

                </table>

Show the actual motif matches for those hits:

    ## 
    ## 
    ## ######## genome: mMacEug1 target: CM051817.1_33102
    ## coords CM051817.1:58411277-58411642 (+) 
    ## 
    ## ## EZHIP-5 ; motif start pos 15
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##  + +++ +  +++ +++     ++ +++ ++ + 
    ## AGRALRTQDVRAGRALRTQDVRAGRALRTQDVRA
    ## 
    ## ## EZHIP-6 ; motif start pos 49
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## + ++++ +   + +++ +    + +++ +
    ## GKALRSQDVRAGKALRPRNDRVGRDLKQK
    ## 
    ## 
    ## ######## genome: mMacEug1 target: CM051813.1_448000
    ## coords CM051813.1:155994559-155994888 (-) 
    ## 
    ## ## EZHIP-5 ; motif start pos 37
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##   +   +++ ++ ++ ++ ++ +++++  +   +
    ## ILPSKQSQALEPSLANRGVIKQLGTVFFKREIKL
    ## 
    ## 
    ## ######## genome: mMonDom1 target: NC_077229.1_349614
    ## coords NC_077229.1:43519659-43519982 (-) 
    ## 
    ## ## EZHIP-5 ; motif start pos 17
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ## ++  ++ + ++ +  ++ ++   +  ++    + 
    ## TGKGLRTRNARTGKGLRTRISRTGKGLRTGIVRT
    ## 
    ## ## EZHIP-5 ; motif start pos 61
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ## ++  ++ ++++ +  ++ ++   + +++    ++
    ## TGKGLRTRISRTGKGLRTRIARTGKALRTKMLEL
    ## 
    ## 
    ## ######## genome: mMonDom1 target: NC_077229.1_349616
    ## coords NC_077229.1:43519227-43519655 (-) 
    ## 
    ## ## EZHIP-5 ; motif start pos 17
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ## ++  ++ + ++ +  ++ ++   +  ++    + 
    ## TGKGLRTRNARTGKGLRTRISRTGKGLRTGIVRT
    ## 
    ## ## EZHIP-5 ; motif start pos 61
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ## ++  ++ ++++ +  ++ ++   + +++    ++
    ## TGKGLRTRISRTGKGLRTRIARTGKALRTKMLEL
    ## 
    ## 
    ## ######## genome: mOrnAna1 target: NC_041735.1_79171
    ## coords NC_041735.1:1178581-1179285 (-) 
    ## 
    ## ## EZHIP-5 ; motif start pos 16
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##  ++  +   + +++++++++ +++++  + ++ +
    ## SWPGGRRWGSPPGLAVRGRASPPGPAAGGGATSP
    ## 
    ## ## EZHIP-6 ; motif start pos 51
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## + +++++++ ++++  +  + ++++  + 
    ## GLAVRGRASPPGPAAGGGTSPPGPAAGGG
    ## 
    ## 
    ## ######## genome: mOrnAna1 target: NC_041744.1_43338
    ## coords NC_041744.1:20567450-20568607 (-) 
    ## 
    ## ## EZHIP-5 ; motif start pos 231
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##   ++  ++++ + +++      ++++  +  ++ 
    ## ATPAPSSRAAPASPATPPPSSRAAPATPSPSSRA
    ## 
    ## ## EZHIP-5 ; motif start pos 289
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##   +++ ++   + +++ ++ +++ +++ +++  +
    ## ATPALASRETLPTPALGSRETLPTPALWSRAAPP
    ## 
    ## ## EZHIP-5 ; motif start pos 341
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##   +++ ++++   ++  ++  ++ +  +     +
    ## AAPALPSRAAPETPAPSSRPAPAPPGPKEPVFPP
    ## 
    ## 
    ## ######## genome: mSarHar1 target: NC_045428.1_222895
    ## coords NC_045428.1:554065610-554065939 (-) 
    ## 
    ## ## EZHIP-5 ; motif start pos 15
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##     ++++  +++ +++ +   ++ +++ +  + 
    ## YRKGLRSQEVRAGRALRTRDVRAGRALRTREVRA
    ## 
    ## ## EZHIP-5 ; motif start pos 59
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ## ++ +++ +  +++ +++ +   ++ +++ +  + 
    ## PGRALRTQEVRAGRALRTRDVRAGRALRTQEVRA
    ## 
    ## 
    ## ######## genome: mSarHar1 target: NC_045428.1_220687
    ## coords NC_045428.1:557663499-557663858 (-) 
    ## 
    ## ## EZHIP-6 ; motif start pos 7
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## + +++ + ++ + +++ + +  + +++ +
    ## GRALRTRGSGAGRALRTRGSGAGRALRTR
    ## 
    ## ## EZHIP-5 ; motif start pos 50
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##  + +++ +  +++ +++ +   ++ +++ +  + 
    ## AGRALRTREVRAGRALRTREVRAGRALRTREVRA
    ## 
    ## ## EZHIP-6 ; motif start pos 84
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## + +++ ++   + +++ ++   + +++ +
    ## GRALRTRDVRAGRAFRTQDVRAGRALRTR

### MAST hits in marsupial/monotreme 6-frame translations that contain motif 9 (top 2 per genome by target e-value):

We’d be more impressed by a hit if it contained something that looks
like motif 9, so filter to only show those. Here the motif 9 matches are
weak, and matches to the repetitive motifs 5 and 6 bump up the MAST
score.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

sequence name
</th>

<th style="text-align:left;">

target e value orig
</th>

<th style="text-align:right;">

num diff motifs
</th>

<th style="text-align:left;">

motif diag ezhip
</th>

<th style="text-align:left;">

chromosome
</th>

<th style="text-align:right;">

start
</th>

<th style="text-align:right;">

end
</th>

<th style="text-align:left;">

strand
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

mMacEug1
</td>

<td style="text-align:left;">

CM051817.1_270900
</td>

<td style="text-align:left;">

0.0015
</td>

<td style="text-align:right;">

3
</td>

<td style="text-align:left;">

5-6-5-5-5-9
</td>

<td style="text-align:left;">

CM051817.1
</td>

<td style="text-align:right;">

63254054
</td>

<td style="text-align:right;">

63254968
</td>

<td style="text-align:left;">

- </td>

  </tr>

  <tr>

  <td style="text-align:left;">

  mMacEug1
  </td>

  <td style="text-align:left;">

  CM051817.1_269134
  </td>

  <td style="text-align:left;">

  0.028
  </td>

  <td style="text-align:right;">

  2
  </td>

  <td style="text-align:left;">

  5-9
  </td>

  <td style="text-align:left;">

  CM051817.1
  </td>

  <td style="text-align:right;">

  66984842
  </td>

  <td style="text-align:right;">

  66985171
  </td>

  <td style="text-align:left;">

  - </td>

    </tr>

    <tr>

    <td style="text-align:left;">

    mMonDom1
    </td>

    <td style="text-align:left;">

    NC_077232.1_132788
    </td>

    <td style="text-align:left;">

    0.028
    </td>

    <td style="text-align:right;">

    2
    </td>

    <td style="text-align:left;">

    5-9
    </td>

    <td style="text-align:left;">

    NC_077232.1
    </td>

    <td style="text-align:right;">

    254658870
    </td>

    <td style="text-align:right;">

    254659244
    </td>

    <td style="text-align:left;">

    - </td>

      </tr>

      <tr>

      <td style="text-align:left;">

      mMonDom1
      </td>

      <td style="text-align:left;">

      NC_077229.1_323299
      </td>

      <td style="text-align:left;">

      0.7
      </td>

      <td style="text-align:right;">

      1
      </td>

      <td style="text-align:left;">

      9
      </td>

      <td style="text-align:left;">

      NC_077229.1
      </td>

      <td style="text-align:right;">

      95978861
      </td>

      <td style="text-align:right;">

      95979172
      </td>

      <td style="text-align:left;">

      - </td>

        </tr>

        <tr>

        <td style="text-align:left;">

        mOrnAna1
        </td>

        <td style="text-align:left;">

        NC_041750.1_18743
        </td>

        <td style="text-align:left;">

        0.0068
        </td>

        <td style="text-align:right;">

        2
        </td>

        <td style="text-align:left;">

        9-6
        </td>

        <td style="text-align:left;">

        NC_041750.1
        </td>

        <td style="text-align:right;">

        19367618
        </td>

        <td style="text-align:right;">

        19368592
        </td>

        <td style="text-align:left;">

        - </td>

          </tr>

          <tr>

          <td style="text-align:left;">

          mOrnAna1
          </td>

          <td style="text-align:left;">

          NC_041731.1_74270
          </td>

          <td style="text-align:left;">

          0.018
          </td>

          <td style="text-align:right;">

          2
          </td>

          <td style="text-align:left;">

          6-9
          </td>

          <td style="text-align:left;">

          NC_041731.1
          </td>

          <td style="text-align:right;">

          133960532
          </td>

          <td style="text-align:right;">

          133960963
          </td>

          <td style="text-align:left;">

          - </td>

            </tr>

            <tr>

            <td style="text-align:left;">

            mSarHar1
            </td>

            <td style="text-align:left;">

            NC_045426.1_242962
            </td>

            <td style="text-align:left;">

            0.0011
            </td>

            <td style="text-align:right;">

            2
            </td>

            <td style="text-align:left;">

            5-5-9
            </td>

            <td style="text-align:left;">

            NC_045426.1
            </td>

            <td style="text-align:right;">

            668588251
            </td>

            <td style="text-align:right;">

            668588730
            </td>

            <td style="text-align:left;">

            - </td>

              </tr>

              <tr>

              <td style="text-align:left;">

              mSarHar1
              </td>

              <td style="text-align:left;">

              NC_045426.1_242747
              </td>

              <td style="text-align:left;">

              0.0025
              </td>

              <td style="text-align:right;">

              2
              </td>

              <td style="text-align:left;">

              9-5
              </td>

              <td style="text-align:left;">

              NC_045426.1
              </td>

              <td style="text-align:right;">

              668835275
              </td>

              <td style="text-align:right;">

              668835613
              </td>

              <td style="text-align:left;">

              - </td>

                </tr>

                </tbody>

                </table>

Show the actual motif matches for those hits:

    ## 
    ## 
    ## ######## genome: mMacEug1 target: CM051817.1_270900
    ## coords CM051817.1:63254054-63254968 (-) 
    ## 
    ## ## EZHIP-5 ; motif start pos 37
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##  + +++ + ++++ +++ +   ++ +++    + 
    ## AGRALRTQDARAGRALRTRDARAGRALRTDNIRA
    ## 
    ## ## EZHIP-6 ; motif start pos 71
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## + +++      + +++ ++   + +++  
    ## GRALRTDNVRAGRALRTQDVRAGRALKTQ
    ## 
    ## ## EZHIP-5 ; motif start pos 103
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##  + +++ +  +++ +++     ++ +++ ++ + 
    ## AGRALRTQDVRAGRALRTQDVRAGRALRTQDVRA
    ## 
    ## ## EZHIP-5 ; motif start pos 147
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##  + +++ +  +++ +++ +   ++ +++ ++ + 
    ## AGRALRTRDVRAGRALRTRDVRAGRALRTRDVRA
    ## 
    ## ## EZHIP-5 ; motif start pos 191
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##  + +++   ++++ +++     ++ +++ +  ++
    ## AGRALRTWDARAGRALRTWDARAGRALRTQKIRP
    ## 
    ## ## EZHIP-9 ; motif start pos 280
    ## WHAVRMRASSPSPPGRFFPFP
    ##   +   +   ++ +    +++
    ## LLALEPRRPLPSCPYKGCLLP
    ## 
    ## 
    ## ######## genome: mMacEug1 target: CM051817.1_269134
    ## coords CM051817.1:66984842-66985171 (-) 
    ## 
    ## ## EZHIP-5 ; motif start pos 17
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##  + +++ +  +++ +++     ++ +++ ++ + 
    ## AGSCLRTQNVRAGRVLRTQDARAGRALRTQDVRA
    ## 
    ## ## EZHIP-9 ; motif start pos 62
    ## WHAVRMRASSPSPPGRFFPFP
    ## +       + +++   + +++
    ## WTLKGLWSSFPSPSPFFLTYH
    ## 
    ## 
    ## ######## genome: mMonDom1 target: NC_077232.1_132788
    ## coords NC_077232.1:254658870-254659244 (-) 
    ## 
    ## ## EZHIP-5 ; motif start pos 50
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##   +++  +   +   ++  + ++++ ++++   +
    ## NPPALQGHSLYQKIIINRLASKLGTTFRGRRLIL
    ## 
    ## ## EZHIP-9 ; motif start pos 105
    ## WHAVRMRASSPSPPGRFFPFP
    ##  +      +  ++   ++++ 
    ## KRNLKSLMSIFSPNNFLYLFQ
    ## 
    ## 
    ## ######## genome: mMonDom1 target: NC_077229.1_323299
    ## coords NC_077229.1:95978861-95979172 (-) 
    ## 
    ## ## EZHIP-9 ; motif start pos 48
    ## WHAVRMRASSPSPPGRFFPFP
    ##        ++ ++++   +++ 
    ## MQPLPRDASCPSPPPAVFTPG
    ## 
    ## 
    ## ######## genome: mOrnAna1 target: NC_041750.1_18743
    ## coords NC_041750.1:19367618-19368592 (+) 
    ## 
    ## ## EZHIP-9 ; motif start pos 12
    ## WHAVRMRASSPSPPGRFFPFP
    ##  +    ++++ +++    + +
    ## VRPRPARASSRSPPPPWGLAP
    ## 
    ## ## EZHIP-6 ; motif start pos 219
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## ++++ +  + + ++ ++    ++++ +  
    ## GPALHRAPSPPRPAPRSLYCPPGPDERTI
    ## 
    ## 
    ## ######## genome: mOrnAna1 target: NC_041731.1_74270
    ## coords NC_041731.1:133960532-133960963 (-) 
    ## 
    ## ## EZHIP-6 ; motif start pos 16
    ## GPALRSRASAPGPALRSRASAPGPALRSR
    ## + + ++ +   +++ ++++  +    +++
    ## GRAARGGAASAGPAPRGRARPPAQPMRRR
    ## 
    ## ## EZHIP-9 ; motif start pos 111
    ## WHAVRMRASSPSPPGRFFPFP
    ##  + ++ + +     ++  ++ 
    ## ARQVRGRSSALGREGRHLLPD
    ## 
    ## 
    ## ######## genome: mSarHar1 target: NC_045426.1_242962
    ## coords NC_045426.1:668588251-668588730 (-) 
    ## 
    ## ## EZHIP-5 ; motif start pos 31
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##  + +++ +  +++ +++     ++ +++ +  + 
    ## LGSALRTQEVRAGRALRAQEVRAGRALRAQEVRA
    ## 
    ## ## EZHIP-5 ; motif start pos 86
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##  + +++ +  +++ +++ +   ++ +++ + +++
    ## AGRALRTQEVRAGRALRTHEVRAGRALRTRISRL
    ## 
    ## ## EZHIP-9 ; motif start pos 131
    ## WHAVRMRASSPSPPGRFFPFP
    ##  ++ + + +     +  +++ 
    ## GRALRTRRSGFFFGGGAFLLS
    ## 
    ## 
    ## ######## genome: mSarHar1 target: NC_045426.1_242747
    ## coords NC_045426.1:668835275-668835613 (-) 
    ## 
    ## ## EZHIP-9 ; motif start pos 2
    ## WHAVRMRASSPSPPGRFFPFP
    ##         ++++    ++ + 
    ## LQLLELTLSSPSKIAFYYFYT
    ## 
    ## ## EZHIP-5 ; motif start pos 54
    ## PGPALRSHASRPGPALRSRATPPGPALRRRASGP
    ##  + +++ +  + + +++     ++ +++ +  + 
    ## AGDALRTQEVRTGRALRIQDIRAGRALRTQNFRT

# hmmsearch output

### hmmsearch of 12 selected proteomes

#### hmmsearch of 12 selected proteomes - use inclusion threshold filter

How many seqs in the proteome passed inclusion threshold per species?
We’d expect to find EZHIP in horse (equCab3) but we don’t - it’s most
likely just missing from the annotated proteome.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:right;">

num proteome hits
</th>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

common name
</th>

<th style="text-align:left;">

group
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:right;">

2
</td>

<td style="text-align:left;">

mm39
</td>

<td style="text-align:left;">

mouse
</td>

<td style="text-align:left;">

placental_other
</td>

</tr>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

hg38
</td>

<td style="text-align:left;">

human
</td>

<td style="text-align:left;">

placental_other
</td>

</tr>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

canFam6
</td>

<td style="text-align:left;">

dog
</td>

<td style="text-align:left;">

placental_other
</td>

</tr>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

mEleMax1
</td>

<td style="text-align:left;">

Asiatic elephant
</td>

<td style="text-align:left;">

afrotheria
</td>

</tr>

<tr>

<td style="text-align:right;">

1
</td>

<td style="text-align:left;">

mOrnAna1
</td>

<td style="text-align:left;">

platypus
</td>

<td style="text-align:left;">

monotreme
</td>

</tr>

<tr>

<td style="text-align:right;">

0
</td>

<td style="text-align:left;">

equCab3
</td>

<td style="text-align:left;">

horse
</td>

<td style="text-align:left;">

placental_other
</td>

</tr>

<tr>

<td style="text-align:right;">

0
</td>

<td style="text-align:left;">

loxAfr3
</td>

<td style="text-align:left;">

African elephant
</td>

<td style="text-align:left;">

afrotheria
</td>

</tr>

<tr>

<td style="text-align:right;">

0
</td>

<td style="text-align:left;">

mDugDug1
</td>

<td style="text-align:left;">

dugong
</td>

<td style="text-align:left;">

afrotheria
</td>

</tr>

<tr>

<td style="text-align:right;">

0
</td>

<td style="text-align:left;">

TriManLat1
</td>

<td style="text-align:left;">

manatee
</td>

<td style="text-align:left;">

afrotheria
</td>

</tr>

<tr>

<td style="text-align:right;">

0
</td>

<td style="text-align:left;">

mMonDom1
</td>

<td style="text-align:left;">

opossum
</td>

<td style="text-align:left;">

marsupial
</td>

</tr>

<tr>

<td style="text-align:right;">

0
</td>

<td style="text-align:left;">

mMacEug1
</td>

<td style="text-align:left;">

wallaby
</td>

<td style="text-align:left;">

marsupial
</td>

</tr>

<tr>

<td style="text-align:right;">

0
</td>

<td style="text-align:left;">

mSarHar1
</td>

<td style="text-align:left;">

tasmanian devil
</td>

<td style="text-align:left;">

marsupial
</td>

</tr>

</tbody>

</table>

Show accessions and descriptions for all hits that pass HMMER’s
inclusion threshold. The two hits in mouse (mm39) are just two splice
isoforms of EZHIP

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

common name
</th>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

target name
</th>

<th style="text-align:left;">

description
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

dog
</td>

<td style="text-align:left;">

canFam6
</td>

<td style="text-align:left;">

XP_038320530.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Canis lupus familiaris\]
</td>

</tr>

<tr>

<td style="text-align:left;">

human
</td>

<td style="text-align:left;">

hg38
</td>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

</tr>

<tr>

<td style="text-align:left;">

Asiatic elephant
</td>

<td style="text-align:left;">

mEleMax1
</td>

<td style="text-align:left;">

XP_049727459.1
</td>

<td style="text-align:left;">

EZH inhibitory protein-like \[Elephas maximus indicus\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mouse
</td>

<td style="text-align:left;">

mm39
</td>

<td style="text-align:left;">

NP_001159905.1
</td>

<td style="text-align:left;">

EZH inhibitory protein isoform 1 \[Mus musculus\]
</td>

</tr>

<tr>

<td style="text-align:left;">

mouse
</td>

<td style="text-align:left;">

mm39
</td>

<td style="text-align:left;">

NP_001028383.2
</td>

<td style="text-align:left;">

EZH inhibitory protein isoform 2 \[Mus musculus\]
</td>

</tr>

<tr>

<td style="text-align:left;">

platypus
</td>

<td style="text-align:left;">

mOrnAna1
</td>

<td style="text-align:left;">

XP_007669498.2
</td>

<td style="text-align:left;">

basic salivary proline-rich protein 3-like \[Ornithorhynchus anatinus\]
</td>

</tr>

</tbody>

</table>

The only hit that’s not already annotated as EZHIP is in platypus - the
hit comprises two EZHIP-5 domain matches in one proline-rich sequence
“basic salivary proline-rich protein 3-like”. Show the hmmer scores
here. We also use the target name (XP_007669498.2) to look at the match
alignments in the [hmmsearch.txt output
file](meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa_meme/motifs_hmmsearch_proteomes_max/all_ten_motifs.hmm.hmmsearch.VS.mOrnAna1_6frame.txt) -
they look unconvincing.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

query name
</th>

<th style="text-align:left;">

description
</th>

<th style="text-align:left;">

target name
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:right;">

query len
</th>

<th style="text-align:right;">

target eval
</th>

<th style="text-align:right;">

target score
</th>

<th style="text-align:right;">

domain index
</th>

<th style="text-align:right;">

domain count
</th>

<th style="text-align:right;">

domain condEval
</th>

<th style="text-align:right;">

domain indEval
</th>

<th style="text-align:right;">

domain score
</th>

<th style="text-align:right;">

hmm start
</th>

<th style="text-align:right;">

hmm end
</th>

<th style="text-align:right;">

ali start
</th>

<th style="text-align:right;">

ali end
</th>

<th style="text-align:right;">

ali width
</th>

<th style="text-align:right;">

ali env start
</th>

<th style="text-align:right;">

ali env end
</th>

<th style="text-align:right;">

accuracy
</th>

<th style="text-align:right;">

ezhip motif index
</th>

<th style="text-align:left;">

desc
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:left;">

basic salivary proline-rich protein 3-like \[Ornithorhynchus anatinus\]
</td>

<td style="text-align:left;">

XP_007669498.2
</td>

<td style="text-align:right;">

330
</td>

<td style="text-align:right;">

34
</td>

<td style="text-align:right;">

0.0087
</td>

<td style="text-align:right;">

16.9
</td>

<td style="text-align:right;">

4
</td>

<td style="text-align:right;">

5
</td>

<td style="text-align:right;">

6.3e-06
</td>

<td style="text-align:right;">

0.0087
</td>

<td style="text-align:right;">

16.9
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:right;">

31
</td>

<td style="text-align:right;">

219
</td>

<td style="text-align:right;">

247
</td>

<td style="text-align:right;">

29
</td>

<td style="text-align:right;">

218
</td>

<td style="text-align:right;">

250
</td>

<td style="text-align:right;">

0.87
</td>

<td style="text-align:right;">

5
</td>

<td style="text-align:left;">

basic salivary proline-rich protein 3-like \[Ornithorhynchus anatinus\]
</td>

</tr>

<tr>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:left;">

basic salivary proline-rich protein 3-like \[Ornithorhynchus anatinus\]
</td>

<td style="text-align:left;">

XP_007669498.2
</td>

<td style="text-align:right;">

330
</td>

<td style="text-align:right;">

34
</td>

<td style="text-align:right;">

0.0087
</td>

<td style="text-align:right;">

16.9
</td>

<td style="text-align:right;">

5
</td>

<td style="text-align:right;">

5
</td>

<td style="text-align:right;">

6.7e-04
</td>

<td style="text-align:right;">

0.9200
</td>

<td style="text-align:right;">

10.5
</td>

<td style="text-align:right;">

12
</td>

<td style="text-align:right;">

31
</td>

<td style="text-align:right;">

263
</td>

<td style="text-align:right;">

283
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

255
</td>

<td style="text-align:right;">

286
</td>

<td style="text-align:right;">

0.83
</td>

<td style="text-align:right;">

5
</td>

<td style="text-align:left;">

basic salivary proline-rich protein 3-like \[Ornithorhynchus anatinus\]
</td>

</tr>

</tbody>

</table>

#### hmmsearch of 12 selected proteomes - without inclusion threshold filter

##### just human

Just human - individual domain level. Show top 25 domain matches -
domain scores drop off very quickly after the true EZHIP match.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

target name
</th>

<th style="text-align:left;">

desc
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:left;">

query name
</th>

<th style="text-align:right;">

target eval
</th>

<th style="text-align:right;">

domain score
</th>

<th style="text-align:right;">

domain condEval
</th>

<th style="text-align:right;">

ali start
</th>

<th style="text-align:right;">

ali end
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-10
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

62.9
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

452
</td>

<td style="text-align:right;">

480
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-1
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

60.9
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

7
</td>

<td style="text-align:right;">

35
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-2
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

59.1
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

38
</td>

<td style="text-align:right;">

78
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-4
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

58.1
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

134
</td>

<td style="text-align:right;">

162
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-3
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

54.1
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

98
</td>

<td style="text-align:right;">

126
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

50.7
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

198
</td>

<td style="text-align:right;">

231
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

49.4
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

401
</td>

<td style="text-align:right;">

421
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-7
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

39.1
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

323
</td>

<td style="text-align:right;">

351
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-8
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

37.2
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

372
</td>

<td style="text-align:right;">

392
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-6
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

36.6
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

265
</td>

<td style="text-align:right;">

293
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

28.4
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

254
</td>

<td style="text-align:right;">

286
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-6
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

28.0
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

223
</td>

<td style="text-align:right;">

246
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-6
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

27.5
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

188
</td>

<td style="text-align:right;">

216
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-6
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

25.9
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

255
</td>

<td style="text-align:right;">

282
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-6
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

25.9
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

300
</td>

<td style="text-align:right;">

324
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

23.7
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

275
</td>

<td style="text-align:right;">

308
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-6
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

22.6
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

276
</td>

<td style="text-align:right;">

304
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-7
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

22.1
</td>

<td style="text-align:right;">

1.0e-07
</td>

<td style="text-align:right;">

224
</td>

<td style="text-align:right;">

252
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

21.6
</td>

<td style="text-align:right;">

1.0e-07
</td>

<td style="text-align:right;">

222
</td>

<td style="text-align:right;">

251
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

16.6
</td>

<td style="text-align:right;">

4.5e-06
</td>

<td style="text-align:right;">

231
</td>

<td style="text-align:right;">

264
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

15.8
</td>

<td style="text-align:right;">

7.9e-06
</td>

<td style="text-align:right;">

308
</td>

<td style="text-align:right;">

336
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

13.4
</td>

<td style="text-align:right;">

4.5e-05
</td>

<td style="text-align:right;">

341
</td>

<td style="text-align:right;">

366
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

EZHIP-6
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

12.4
</td>

<td style="text-align:right;">

3.7e-05
</td>

<td style="text-align:right;">

249
</td>

<td style="text-align:right;">

271
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_940913.1
</td>

<td style="text-align:left;">

lanC-like protein 3 isoform 1 \[Homo sapiens\]
</td>

<td style="text-align:right;">

388
</td>

<td style="text-align:left;">

EZHIP-2
</td>

<td style="text-align:right;">

0.97
</td>

<td style="text-align:right;">

11.0
</td>

<td style="text-align:right;">

8.0e-05
</td>

<td style="text-align:right;">

43
</td>

<td style="text-align:right;">

61
</td>

</tr>

<tr>

<td style="text-align:left;">

NP_001163802.1
</td>

<td style="text-align:left;">

lanC-like protein 3 isoform 2 \[Homo sapiens\]
</td>

<td style="text-align:right;">

420
</td>

<td style="text-align:left;">

EZHIP-2
</td>

<td style="text-align:right;">

1.10
</td>

<td style="text-align:right;">

10.9
</td>

<td style="text-align:right;">

8.9e-05
</td>

<td style="text-align:right;">

43
</td>

<td style="text-align:right;">

61
</td>

</tr>

</tbody>

</table>

Now look at matches summarized by the target sequence (\>1 motif match
per target). I use a domain score threshold of \>= 10. Sorting matches
by total target domain score, showing top 2. Second hit after EZHIP is
not good.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

target name
</th>

<th style="text-align:left;">

desc
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:left;">

motif diag ezhip
</th>

<th style="text-align:right;">

best target eval
</th>

<th style="text-align:right;">

total ali width
</th>

<th style="text-align:right;">

total target score
</th>

<th style="text-align:right;">

num motifs
</th>

<th style="text-align:right;">

num diff motifs
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

hg38
</td>

<td style="text-align:left;">

NP_981952.1
</td>

<td style="text-align:left;">

EZH inhibitory protein \[Homo sapiens\]
</td>

<td style="text-align:right;">

503
</td>

<td style="text-align:left;">

1-2-3-4-6-5-5-6-7-5-6-5-6-6-7-5-6-6-5-7-5-8-9-10
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

690
</td>

<td style="text-align:right;">

1803.6
</td>

<td style="text-align:right;">

24
</td>

<td style="text-align:right;">

10
</td>

</tr>

<tr>

<td style="text-align:left;">

hg38
</td>

<td style="text-align:left;">

NP_940913.1
</td>

<td style="text-align:left;">

lanC-like protein 3 isoform 1 \[Homo sapiens\]
</td>

<td style="text-align:right;">

388
</td>

<td style="text-align:left;">

2
</td>

<td style="text-align:right;">

0.97
</td>

<td style="text-align:right;">

19
</td>

<td style="text-align:right;">

12.1
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

</tbody>

</table>

##### afrotheria

Afrotheria - not showing individual domain level hits for all domains,
because we do have tblastn hits, and we’re not asking about additional
hits to anything other than motif 9 (see above for that)

Show matches summarized by the target sequence (\>1 motif match per
target), using a domain score threshold of \>= 10. Sorting matches by
total target domain score, showing top 2 for each species

mEleMax1 (Asiatic elephant) is the only genome for which EZHIP is
present in the annotated proteome - that is a hit here but doesn’t
contain motif 9, as we know.

The other genomes don’t seem to have EZHIP annotated, and the only hits
are weak, containing just one motif (see ‘motif diag ezhip’ column).

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

target name
</th>

<th style="text-align:left;">

desc
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:left;">

motif diag ezhip
</th>

<th style="text-align:right;">

best target eval
</th>

<th style="text-align:right;">

total ali width
</th>

<th style="text-align:right;">

total target score
</th>

<th style="text-align:right;">

num motifs
</th>

<th style="text-align:right;">

num diff motifs
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

TriManLat1
</td>

<td style="text-align:left;">

XP_004373054.1
</td>

<td style="text-align:left;">

NADH dehydrogenase \[ubiquinone\] 1 beta subcomplex subunit 9
\[Trichechus manatus latirostris\]
</td>

<td style="text-align:right;">

179
</td>

<td style="text-align:left;">

1
</td>

<td style="text-align:right;">

0.140
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

13.0
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

TriManLat1
</td>

<td style="text-align:left;">

XP_004382007.1
</td>

<td style="text-align:left;">

pleckstrin homology domain-containing family B member 1 isoform X1
\[Trichechus manatus latirostris\]
</td>

<td style="text-align:right;">

208
</td>

<td style="text-align:left;">

2
</td>

<td style="text-align:right;">

0.280
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

12.0
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

loxAfr3
</td>

<td style="text-align:left;">

XP_003408337.1
</td>

<td style="text-align:left;">

NADH dehydrogenase \[ubiquinone\] 1 beta subcomplex subunit 9
\[Loxodonta africana\]
</td>

<td style="text-align:right;">

179
</td>

<td style="text-align:left;">

1
</td>

<td style="text-align:right;">

0.150
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

13.1
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

loxAfr3
</td>

<td style="text-align:left;">

XP_010589012.2
</td>

<td style="text-align:left;">

meiosis expressed gene 1 protein homolog isoform X1 \[Loxodonta
africana\]
</td>

<td style="text-align:right;">

114
</td>

<td style="text-align:left;">

1
</td>

<td style="text-align:right;">

0.250
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

12.4
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

mDugDug1
</td>

<td style="text-align:left;">

KAM9191764.1
</td>

<td style="text-align:left;">

RWD domain-containing protein 4 isoform 2-T3 \[Dugong dugon\]
</td>

<td style="text-align:right;">

180
</td>

<td style="text-align:left;">

1
</td>

<td style="text-align:right;">

0.068
</td>

<td style="text-align:right;">

15
</td>

<td style="text-align:right;">

14.0
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

mDugDug1
</td>

<td style="text-align:left;">

KAM9198427.1
</td>

<td style="text-align:left;">

NADH dehydrogenase \[ubiquinone\] 1 beta subcomplex subunit 9 isoform
2-T2 \[Dugong dugon\]
</td>

<td style="text-align:right;">

136
</td>

<td style="text-align:left;">

1
</td>

<td style="text-align:right;">

0.097
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

13.5
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

mEleMax1
</td>

<td style="text-align:left;">

XP_049727459.1
</td>

<td style="text-align:left;">

EZH inhibitory protein-like \[Elephas maximus indicus\]
</td>

<td style="text-align:right;">

689
</td>

<td style="text-align:left;">

5-7-6-7-6-5-6-7-5-6-5-6-7-6-5-7-6-7-5-6-7-6-7-5-5-7-6-7-5-7-5-6-7-7-5-5-7-6-5-7-6-5-7-6-6-7-7-5-6-8
</td>

<td style="text-align:right;">

0.000
</td>

<td style="text-align:right;">

1338
</td>

<td style="text-align:right;">

7485.2
</td>

<td style="text-align:right;">

50
</td>

<td style="text-align:right;">

4
</td>

</tr>

<tr>

<td style="text-align:left;">

mEleMax1
</td>

<td style="text-align:left;">

XP_049710313.1
</td>

<td style="text-align:left;">

NADH dehydrogenase \[ubiquinone\] 1 beta subcomplex subunit 9 \[Elephas
maximus indicus\]
</td>

<td style="text-align:right;">

179
</td>

<td style="text-align:left;">

1
</td>

<td style="text-align:right;">

0.200
</td>

<td style="text-align:right;">

21
</td>

<td style="text-align:right;">

13.1
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

</tbody>

</table>

##### marsupials/monotremes

Individual domain level. Show top 5 domain matches per species. We can
use the ‘target name’ column to look up individual hits in the
`*_proteome.txt` output files in [this
folder](meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa_meme/motifs_hmmsearch_proteomes_max) -
these hits look unimpressive.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

target name
</th>

<th style="text-align:left;">

desc
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:left;">

query name
</th>

<th style="text-align:right;">

target eval
</th>

<th style="text-align:right;">

domain score
</th>

<th style="text-align:right;">

domain condEval
</th>

<th style="text-align:right;">

ali start
</th>

<th style="text-align:right;">

ali end
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

XP_072464327.1
</td>

<td style="text-align:left;">

uncharacterized protein C19orf47 homolog isoform X6 \[Notamacropus
eugenii\]
</td>

<td style="text-align:right;">

406
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.0110
</td>

<td style="text-align:right;">

17.0
</td>

<td style="text-align:right;">

1.3e-06
</td>

<td style="text-align:right;">

3
</td>

<td style="text-align:right;">

18
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_072464325.1
</td>

<td style="text-align:left;">

uncharacterized protein C19orf47 homolog isoform X4 \[Notamacropus
eugenii\]
</td>

<td style="text-align:right;">

429
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.0110
</td>

<td style="text-align:right;">

16.9
</td>

<td style="text-align:right;">

1.3e-06
</td>

<td style="text-align:right;">

3
</td>

<td style="text-align:right;">

18
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_072464324.1
</td>

<td style="text-align:left;">

uncharacterized protein C19orf47 homolog isoform X3 \[Notamacropus
eugenii\]
</td>

<td style="text-align:right;">

435
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.0120
</td>

<td style="text-align:right;">

16.9
</td>

<td style="text-align:right;">

1.4e-06
</td>

<td style="text-align:right;">

3
</td>

<td style="text-align:right;">

18
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_072464323.1
</td>

<td style="text-align:left;">

uncharacterized protein C19orf47 homolog isoform X2 \[Notamacropus
eugenii\]
</td>

<td style="text-align:right;">

436
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.0120
</td>

<td style="text-align:right;">

16.9
</td>

<td style="text-align:right;">

1.4e-06
</td>

<td style="text-align:right;">

3
</td>

<td style="text-align:right;">

18
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_072464322.1
</td>

<td style="text-align:left;">

uncharacterized protein C19orf47 homolog isoform X1 \[Notamacropus
eugenii\]
</td>

<td style="text-align:right;">

452
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.0120
</td>

<td style="text-align:right;">

16.9
</td>

<td style="text-align:right;">

1.4e-06
</td>

<td style="text-align:right;">

3
</td>

<td style="text-align:right;">

18
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_016282303.1
</td>

<td style="text-align:left;">

ETS domain-containing protein Elk-1 isoform X6 \[Monodelphis domestica\]
</td>

<td style="text-align:right;">

360
</td>

<td style="text-align:left;">

EZHIP-1
</td>

<td style="text-align:right;">

0.0890
</td>

<td style="text-align:right;">

13.2
</td>

<td style="text-align:right;">

4.6e-05
</td>

<td style="text-align:right;">

165
</td>

<td style="text-align:right;">

179
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_007507703.1
</td>

<td style="text-align:left;">

ETS domain-containing protein Elk-1 isoform X7 \[Monodelphis domestica\]
</td>

<td style="text-align:right;">

343
</td>

<td style="text-align:left;">

EZHIP-1
</td>

<td style="text-align:right;">

0.1400
</td>

<td style="text-align:right;">

13.2
</td>

<td style="text-align:right;">

4.3e-05
</td>

<td style="text-align:right;">

275
</td>

<td style="text-align:right;">

289
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_003342362.2
</td>

<td style="text-align:left;">

ETS domain-containing protein Elk-1 isoform X5 \[Monodelphis domestica\]
</td>

<td style="text-align:right;">

377
</td>

<td style="text-align:left;">

EZHIP-1
</td>

<td style="text-align:right;">

0.1800
</td>

<td style="text-align:right;">

13.1
</td>

<td style="text-align:right;">

4.9e-05
</td>

<td style="text-align:right;">

275
</td>

<td style="text-align:right;">

289
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_016282302.1
</td>

<td style="text-align:left;">

ETS domain-containing protein Elk-1 isoform X4 \[Monodelphis domestica\]
</td>

<td style="text-align:right;">

393
</td>

<td style="text-align:left;">

EZHIP-1
</td>

<td style="text-align:right;">

0.1000
</td>

<td style="text-align:right;">

13.0
</td>

<td style="text-align:right;">

5.1e-05
</td>

<td style="text-align:right;">

198
</td>

<td style="text-align:right;">

212
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_016282301.1
</td>

<td style="text-align:left;">

ETS domain-containing protein Elk-1 isoform X3 \[Monodelphis domestica\]
</td>

<td style="text-align:right;">

398
</td>

<td style="text-align:left;">

EZHIP-1
</td>

<td style="text-align:right;">

0.1000
</td>

<td style="text-align:right;">

13.0
</td>

<td style="text-align:right;">

5.2e-05
</td>

<td style="text-align:right;">

203
</td>

<td style="text-align:right;">

217
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_007669498.2
</td>

<td style="text-align:left;">

basic salivary proline-rich protein 3-like \[Ornithorhynchus anatinus\]
</td>

<td style="text-align:right;">

330
</td>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:right;">

0.0087
</td>

<td style="text-align:right;">

16.9
</td>

<td style="text-align:right;">

6.3e-06
</td>

<td style="text-align:right;">

219
</td>

<td style="text-align:right;">

247
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_007669498.2
</td>

<td style="text-align:left;">

basic salivary proline-rich protein 3-like \[Ornithorhynchus anatinus\]
</td>

<td style="text-align:right;">

330
</td>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:right;">

0.0087
</td>

<td style="text-align:right;">

10.5
</td>

<td style="text-align:right;">

6.7e-04
</td>

<td style="text-align:right;">

263
</td>

<td style="text-align:right;">

283
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_028920568.1
</td>

<td style="text-align:left;">

stabilizer of axonemal microtubules 2 isoform X2 \[Ornithorhynchus
anatinus\]
</td>

<td style="text-align:right;">

406
</td>

<td style="text-align:left;">

EZHIP-8
</td>

<td style="text-align:right;">

1.1000
</td>

<td style="text-align:right;">

10.5
</td>

<td style="text-align:right;">

2.5e-04
</td>

<td style="text-align:right;">

254
</td>

<td style="text-align:right;">

264
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_028920567.1
</td>

<td style="text-align:left;">

stabilizer of axonemal microtubules 2 isoform X1 \[Ornithorhynchus
anatinus\]
</td>

<td style="text-align:right;">

473
</td>

<td style="text-align:left;">

EZHIP-8
</td>

<td style="text-align:right;">

1.6000
</td>

<td style="text-align:right;">

10.3
</td>

<td style="text-align:right;">

3.0e-04
</td>

<td style="text-align:right;">

321
</td>

<td style="text-align:right;">

331
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_028927542.1
</td>

<td style="text-align:left;">

arginine-hydroxylase NDUFAF5, mitochondrial isoform X2 \[Ornithorhynchus
anatinus\]
</td>

<td style="text-align:right;">

156
</td>

<td style="text-align:left;">

EZHIP-5
</td>

<td style="text-align:right;">

0.7300
</td>

<td style="text-align:right;">

10.1
</td>

<td style="text-align:right;">

8.9e-04
</td>

<td style="text-align:right;">

125
</td>

<td style="text-align:right;">

138
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_003763133.1
</td>

<td style="text-align:left;">

olfactory receptor 7C1-like \[Sarcophilus harrisii\]
</td>

<td style="text-align:right;">

311
</td>

<td style="text-align:left;">

EZHIP-8
</td>

<td style="text-align:right;">

0.0390
</td>

<td style="text-align:right;">

14.0
</td>

<td style="text-align:right;">

1.5e-05
</td>

<td style="text-align:right;">

299
</td>

<td style="text-align:right;">

311
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_031796332.1
</td>

<td style="text-align:left;">

ATP-sensitive inward rectifier potassium channel 12 isoform X1
\[Sarcophilus harrisii\]
</td>

<td style="text-align:right;">

564
</td>

<td style="text-align:left;">

EZHIP-6
</td>

<td style="text-align:right;">

0.0870
</td>

<td style="text-align:right;">

12.7
</td>

<td style="text-align:right;">

4.9e-05
</td>

<td style="text-align:right;">

70
</td>

<td style="text-align:right;">

81
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_031799670.1
</td>

<td style="text-align:left;">

dnaJ homolog subfamily C member 4 \[Sarcophilus harrisii\]
</td>

<td style="text-align:right;">

237
</td>

<td style="text-align:left;">

EZHIP-6
</td>

<td style="text-align:right;">

0.2900
</td>

<td style="text-align:right;">

10.7
</td>

<td style="text-align:right;">

2.0e-04
</td>

<td style="text-align:right;">

103
</td>

<td style="text-align:right;">

116
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_031799671.1
</td>

<td style="text-align:left;">

dnaJ homolog subfamily C member 4 \[Sarcophilus harrisii\]
</td>

<td style="text-align:right;">

237
</td>

<td style="text-align:left;">

EZHIP-6
</td>

<td style="text-align:right;">

0.2900
</td>

<td style="text-align:right;">

10.7
</td>

<td style="text-align:right;">

2.0e-04
</td>

<td style="text-align:right;">

103
</td>

<td style="text-align:right;">

116
</td>

</tr>

<tr>

<td style="text-align:left;">

XP_031817586.1
</td>

<td style="text-align:left;">

AP-2 complex subunit alpha-1 \[Sarcophilus harrisii\]
</td>

<td style="text-align:right;">

631
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.6300
</td>

<td style="text-align:right;">

10.1
</td>

<td style="text-align:right;">

1.6e-04
</td>

<td style="text-align:right;">

424
</td>

<td style="text-align:right;">

433
</td>

</tr>

</tbody>

</table>

Now look at matches summarized by the target sequence (\>1 motif match
per target). I use a domain score threshold of \>= 10. Sorting matches
by total target domain score, showing top 2 per species. Unimpressive.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

target name
</th>

<th style="text-align:left;">

desc
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:left;">

motif diag ezhip
</th>

<th style="text-align:right;">

best target eval
</th>

<th style="text-align:right;">

total ali width
</th>

<th style="text-align:right;">

total target score
</th>

<th style="text-align:right;">

num motifs
</th>

<th style="text-align:right;">

num diff motifs
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

mMacEug1
</td>

<td style="text-align:left;">

XP_072476095.1
</td>

<td style="text-align:left;">

LOW QUALITY PROTEIN: zinc finger protein 408, partial \[Notamacropus
eugenii\]
</td>

<td style="text-align:right;">

649
</td>

<td style="text-align:left;">

5-6
</td>

<td style="text-align:right;">

0.0470
</td>

<td style="text-align:right;">

32
</td>

<td style="text-align:right;">

27.9
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:right;">

2
</td>

</tr>

<tr>

<td style="text-align:left;">

mMacEug1
</td>

<td style="text-align:left;">

XP_072464327.1
</td>

<td style="text-align:left;">

uncharacterized protein C19orf47 homolog isoform X6 \[Notamacropus
eugenii\]
</td>

<td style="text-align:right;">

406
</td>

<td style="text-align:left;">

9
</td>

<td style="text-align:right;">

0.0110
</td>

<td style="text-align:right;">

16
</td>

<td style="text-align:right;">

17.0
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

mMonDom1
</td>

<td style="text-align:left;">

XP_016282303.1
</td>

<td style="text-align:left;">

ETS domain-containing protein Elk-1 isoform X6 \[Monodelphis domestica\]
</td>

<td style="text-align:right;">

360
</td>

<td style="text-align:left;">

1
</td>

<td style="text-align:right;">

0.0890
</td>

<td style="text-align:right;">

15
</td>

<td style="text-align:right;">

14.4
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

mMonDom1
</td>

<td style="text-align:left;">

XP_016282302.1
</td>

<td style="text-align:left;">

ETS domain-containing protein Elk-1 isoform X4 \[Monodelphis domestica\]
</td>

<td style="text-align:right;">

393
</td>

<td style="text-align:left;">

1
</td>

<td style="text-align:right;">

0.1000
</td>

<td style="text-align:right;">

15
</td>

<td style="text-align:right;">

14.3
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

mOrnAna1
</td>

<td style="text-align:left;">

XP_007669498.2
</td>

<td style="text-align:left;">

basic salivary proline-rich protein 3-like \[Ornithorhynchus anatinus\]
</td>

<td style="text-align:right;">

330
</td>

<td style="text-align:left;">

5-5
</td>

<td style="text-align:right;">

0.0087
</td>

<td style="text-align:right;">

50
</td>

<td style="text-align:right;">

33.8
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

mOrnAna1
</td>

<td style="text-align:left;">

XP_028927542.1
</td>

<td style="text-align:left;">

arginine-hydroxylase NDUFAF5, mitochondrial isoform X2 \[Ornithorhynchus
anatinus\]
</td>

<td style="text-align:right;">

156
</td>

<td style="text-align:left;">

5
</td>

<td style="text-align:right;">

0.7300
</td>

<td style="text-align:right;">

14
</td>

<td style="text-align:right;">

10.8
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

mSarHar1
</td>

<td style="text-align:left;">

XP_003763133.1
</td>

<td style="text-align:left;">

olfactory receptor 7C1-like \[Sarcophilus harrisii\]
</td>

<td style="text-align:right;">

311
</td>

<td style="text-align:left;">

8
</td>

<td style="text-align:right;">

0.0390
</td>

<td style="text-align:right;">

13
</td>

<td style="text-align:right;">

14.8
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

mSarHar1
</td>

<td style="text-align:left;">

XP_031796332.1
</td>

<td style="text-align:left;">

ATP-sensitive inward rectifier potassium channel 12 isoform X1
\[Sarcophilus harrisii\]
</td>

<td style="text-align:right;">

564
</td>

<td style="text-align:left;">

6
</td>

<td style="text-align:right;">

0.0870
</td>

<td style="text-align:right;">

12
</td>

<td style="text-align:right;">

13.9
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

</tbody>

</table>

### hmmsearch of 12 selected 6-frame translations

#### hmmsearch each motif - any species, using inclusion threshold

#### hmmsearch - motif 9 hits

##### hmmsearch - motif 9 hits in human

Human - requiring domain score \>=10 we find a bunch of hits. Here I
show the top 4. Notes on each:

- 1)  EZHIP
- 2)  EZHIP2
- 3)  a 134aa ORF called chr14_16745 with poor e-value (0.67). The motif
      9 match is `ASSPSPPGR` (pos 8-16 of motif 9) - seems unimpressive
- 4)  a 156aa ORF called chr10_107312 with poor e-value (1.1)

These hits are filtered on domain score \>=10 - without that filter,
there are a lot of even more unimpressive hits (e.g. a match to just
`SSPSP` with domain score -1.5). This is a very sensitive search (too
sensitive).

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

target name
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:left;">

query name
</th>

<th style="text-align:right;">

target eval
</th>

<th style="text-align:right;">

domain score
</th>

<th style="text-align:right;">

domain condEval
</th>

<th style="text-align:right;">

ali start
</th>

<th style="text-align:right;">

ali end
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

hg38
</td>

<td style="text-align:left;">

chrX_21027
</td>

<td style="text-align:right;">

594
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

49.1
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

492
</td>

<td style="text-align:right;">

512
</td>

</tr>

<tr>

<td style="text-align:left;">

hg38
</td>

<td style="text-align:left;">

chr5_132898
</td>

<td style="text-align:right;">

213
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

44.3
</td>

<td style="text-align:right;">

0.0e+00
</td>

<td style="text-align:right;">

190
</td>

<td style="text-align:right;">

210
</td>

</tr>

<tr>

<td style="text-align:left;">

hg38
</td>

<td style="text-align:left;">

chr14_16745
</td>

<td style="text-align:right;">

134
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.67
</td>

<td style="text-align:right;">

16.7
</td>

<td style="text-align:right;">

5.8e-06
</td>

<td style="text-align:right;">

36
</td>

<td style="text-align:right;">

44
</td>

</tr>

<tr>

<td style="text-align:left;">

hg38
</td>

<td style="text-align:left;">

chr10_107312
</td>

<td style="text-align:right;">

156
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

1.10
</td>

<td style="text-align:right;">

14.6
</td>

<td style="text-align:right;">

2.5e-05
</td>

<td style="text-align:right;">

48
</td>

<td style="text-align:right;">

59
</td>

</tr>

</tbody>

</table>

Show matches to motif 9 that pass HMMER’s “inclusion threshold” - only
EZHIP and EZHIP2 pass that threshold:

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

target name
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:left;">

query name
</th>

<th style="text-align:right;">

target eval
</th>

<th style="text-align:right;">

domain score
</th>

<th style="text-align:right;">

domain condEval
</th>

<th style="text-align:right;">

ali start
</th>

<th style="text-align:right;">

ali end
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

hg38
</td>

<td style="text-align:left;">

chrX_21027
</td>

<td style="text-align:right;">

594
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

49.1
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

492
</td>

<td style="text-align:right;">

512
</td>

</tr>

<tr>

<td style="text-align:left;">

hg38
</td>

<td style="text-align:left;">

chr5_132898
</td>

<td style="text-align:right;">

213
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

44.3
</td>

<td style="text-align:right;">

0
</td>

<td style="text-align:right;">

190
</td>

<td style="text-align:right;">

210
</td>

</tr>

</tbody>

</table>

##### hmmsearch - motif 9 hits in afrotheria

Show best motif 9 matches in each of the four afrotheria genomes - best
single motif 9 match in each genome (by target_eval).

I show matches in tabular format here. I use the target name column to
search the plain text hmmsearch.txt output file
(e.g. [`all_ten_motifs.hmm.hmmsearch.VS.TriManLat1_6frame.txt`](meme_protein_motifs/EZHIP_sequences_used_for_MEME_analyses.fa_meme/motifs_hmmsearch_genomes_max/all_ten_motifs.hmm.hmmsearch.VS.TriManLat1_6frame.txt))
to look at the alignments between motif and target sequence. I have not
written code to extract those alignments and display them here.

Here are the best motif 9 matches in those four afrotherian genomes -
none have ‘VRMR’.

The manatee (TriManLat1) match is the only one that passes HMMER’s
inclusion threshold. The rest have high e-values (\>=0.29)

    mEleMax1 - best motif9 hit is          SPSPPGELFPL
    loxAfr3 - best motif9 hit is         ASSPSPPGLMFL
    TriManLat1 - best motif9 hit is ATRHRASSPSPPG
    mDugDug1 - best motif9 hit is          SPSPPGRLYLL

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

target name
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:left;">

query name
</th>

<th style="text-align:right;">

target eval
</th>

<th style="text-align:right;">

domain score
</th>

<th style="text-align:right;">

domain condEval
</th>

<th style="text-align:right;">

ali start
</th>

<th style="text-align:right;">

ali end
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

TriManLat1
</td>

<td style="text-align:left;">

NW_004443964.1_33059
</td>

<td style="text-align:right;">

216
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.005
</td>

<td style="text-align:right;">

22.0
</td>

<td style="text-align:right;">

1.0e-07
</td>

<td style="text-align:right;">

186
</td>

<td style="text-align:right;">

198
</td>

</tr>

<tr>

<td style="text-align:left;">

loxAfr3
</td>

<td style="text-align:left;">

scaffold_46_17924
</td>

<td style="text-align:right;">

127
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.330
</td>

<td style="text-align:right;">

17.7
</td>

<td style="text-align:right;">

2.8e-06
</td>

<td style="text-align:right;">

9
</td>

<td style="text-align:right;">

20
</td>

</tr>

<tr>

<td style="text-align:left;">

mDugDug1
</td>

<td style="text-align:left;">

CM057462.1_146431
</td>

<td style="text-align:right;">

108
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.290
</td>

<td style="text-align:right;">

17.9
</td>

<td style="text-align:right;">

1.5e-06
</td>

<td style="text-align:right;">

80
</td>

<td style="text-align:right;">

90
</td>

</tr>

<tr>

<td style="text-align:left;">

mEleMax1
</td>

<td style="text-align:left;">

NC_064821.1_194352
</td>

<td style="text-align:right;">

112
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

2.000
</td>

<td style="text-align:right;">

14.2
</td>

<td style="text-align:right;">

2.4e-05
</td>

<td style="text-align:right;">

68
</td>

<td style="text-align:right;">

78
</td>

</tr>

</tbody>

</table>

##### hmmsearch - motif 9 hits in marsupial/monotreme

Show best motif 9 match in each of the four marsupial/monotreme outgroup
species genomes - when I look at the alignments none have ‘VRMR’.

    mMacEug1 - best motif9 hit is  PMQASSPSPPPSFFFFF
    mMonDom1 - best motif9 hit is    RNSSPSPPRRHFVF
    mSarHar1 - best motif9 hit is    RASSPAPPGKLFP
    mOrnAna1 - best motif9 hit is   MRCSSPS

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

target name
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:left;">

query name
</th>

<th style="text-align:right;">

target eval
</th>

<th style="text-align:right;">

domain score
</th>

<th style="text-align:right;">

domain condEval
</th>

<th style="text-align:right;">

ali start
</th>

<th style="text-align:right;">

ali end
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

mMacEug1
</td>

<td style="text-align:left;">

CM051814.1_348527
</td>

<td style="text-align:right;">

192
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.22
</td>

<td style="text-align:right;">

13.4
</td>

<td style="text-align:right;">

5.2e-05
</td>

<td style="text-align:right;">

22
</td>

<td style="text-align:right;">

38
</td>

</tr>

<tr>

<td style="text-align:left;">

mMonDom1
</td>

<td style="text-align:left;">

NC_077227.1_100417
</td>

<td style="text-align:right;">

160
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.12
</td>

<td style="text-align:right;">

17.7
</td>

<td style="text-align:right;">

1.5e-06
</td>

<td style="text-align:right;">

33
</td>

<td style="text-align:right;">

46
</td>

</tr>

<tr>

<td style="text-align:left;">

mOrnAna1
</td>

<td style="text-align:left;">

NC_041739.1_5583
</td>

<td style="text-align:right;">

197
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.00
</td>

<td style="text-align:right;">

4.2
</td>

<td style="text-align:right;">

7.2e-02
</td>

<td style="text-align:right;">

9
</td>

<td style="text-align:right;">

15
</td>

</tr>

<tr>

<td style="text-align:left;">

mSarHar1
</td>

<td style="text-align:left;">

NC_045429.1_295620
</td>

<td style="text-align:right;">

271
</td>

<td style="text-align:left;">

EZHIP-9
</td>

<td style="text-align:right;">

0.47
</td>

<td style="text-align:right;">

-1.3
</td>

<td style="text-align:right;">

2.5e+00
</td>

<td style="text-align:right;">

71
</td>

<td style="text-align:right;">

76
</td>

</tr>

</tbody>

</table>

#### hmmsearch all motifs combined - summarize matches per target ORF

##### hmmsearch all motifs combined - human

I’ll use human to figure out some reasonable filtering strategies at the
level of summarized hits.

A reasonable filtering strategy seems to be:

- ignore hits that only have the repetitive motifs 5/6/7 and no others
- require at least one motif with e-value \< 0.1
- require at least 20aa worth of sequence aligned to any motif

Check that strategy in human - that gets me the ONLY 3 human regions we
know about (chrX, plus the two very nearby bit on opposite strands on
chr5). The next-best thing after that was chr20_39436 - has two matches
to motif 4 (total aln length = 24aa). When I look at the hit it’s
unimpressive.

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

chromosome
</th>

<th style="text-align:right;">

start
</th>

<th style="text-align:right;">

end
</th>

<th style="text-align:left;">

strand
</th>

<th style="text-align:left;">

target name
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:left;">

motif diag ezhip
</th>

<th style="text-align:right;">

best target eval
</th>

<th style="text-align:right;">

total ali width
</th>

<th style="text-align:right;">

total target score
</th>

<th style="text-align:right;">

num motifs
</th>

<th style="text-align:right;">

num diff motifs
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

chrX
</td>

<td style="text-align:right;">

51406744
</td>

<td style="text-align:right;">

51408525
</td>

<td style="text-align:left;">

- </td>

  <td style="text-align:left;">

  chrX_21027
  </td>

  <td style="text-align:right;">

  594
  </td>

  <td style="text-align:left;">

  1-2-3-4-6-5-5-6-7-5-6-5-6-6-7-5-6-6-5-7-5-8-9-10
  </td>

  <td style="text-align:right;">

  0
  </td>

  <td style="text-align:right;">

  689
  </td>

  <td style="text-align:right;">

  1755.7
  </td>

  <td style="text-align:right;">

  24
  </td>

  <td style="text-align:right;">

  10
  </td>

  </tr>

  <tr>

  <td style="text-align:left;">

  chr5
  </td>

  <td style="text-align:right;">

  12794826
  </td>

  <td style="text-align:right;">

  12795545
  </td>

  <td style="text-align:left;">

  - </td>

    <td style="text-align:left;">

    chr5_8266
    </td>

    <td style="text-align:right;">

    240
    </td>

    <td style="text-align:left;">

    2-3-4-5-6-7-5-7-6-7-5-5-6-7
    </td>

    <td style="text-align:right;">

    0
    </td>

    <td style="text-align:right;">

    372
    </td>

    <td style="text-align:right;">

    749.3
    </td>

    <td style="text-align:right;">

    14
    </td>

    <td style="text-align:right;">

    6
    </td>

    </tr>

    <tr>

    <td style="text-align:left;">

    chr5
    </td>

    <td style="text-align:right;">

    12794332
    </td>

    <td style="text-align:right;">

    12794970
    </td>

    <td style="text-align:left;">

    - </td>

      <td style="text-align:left;">

      chr5_132898
      </td>

      <td style="text-align:right;">

      213
      </td>

      <td style="text-align:left;">

      5-6-7-7-5-6-7-5-8-9
      </td>

      <td style="text-align:right;">

      0
      </td>

      <td style="text-align:right;">

      240
      </td>

      <td style="text-align:right;">

      387.5
      </td>

      <td style="text-align:right;">

      10
      </td>

      <td style="text-align:right;">

      5
      </td>

      </tr>

      </tbody>

      </table>

##### hmmsearch all motifs combined - Afrotheria

We’re not checking Afrotherian genomes with motifs other than the KLP
(motif 9) - we HAVE found an EZHIP gene or pseudogene in these species.
The question we want to ask in these species is whether they have a KLP
motif in any other gene.

##### hmmsearch all motifs combined - marsupials/monotreme

Check matches in outgroup genomes (marsupials and monotreme) using the
same filtering strategy - these are not convincing

<table class="table" style="width: auto !important; margin-left: auto; margin-right: auto;">

<thead>

<tr>

<th style="text-align:left;">

genome
</th>

<th style="text-align:left;">

target name
</th>

<th style="text-align:right;">

target len aa
</th>

<th style="text-align:left;">

motif diag ezhip
</th>

<th style="text-align:right;">

best target eval
</th>

<th style="text-align:right;">

total ali width
</th>

<th style="text-align:right;">

total target score
</th>

<th style="text-align:right;">

num motifs
</th>

<th style="text-align:right;">

num diff motifs
</th>

</tr>

</thead>

<tbody>

<tr>

<td style="text-align:left;">

mOrnAna1
</td>

<td style="text-align:left;">

NC_041735.1_54185
</td>

<td style="text-align:right;">

141
</td>

<td style="text-align:left;">

8-8
</td>

<td style="text-align:right;">

0.046
</td>

<td style="text-align:right;">

28
</td>

<td style="text-align:right;">

40.0
</td>

<td style="text-align:right;">

2
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

mMonDom1
</td>

<td style="text-align:left;">

NC_077233.1_213080
</td>

<td style="text-align:right;">

166
</td>

<td style="text-align:left;">

2
</td>

<td style="text-align:right;">

0.011
</td>

<td style="text-align:right;">

20
</td>

<td style="text-align:right;">

22.5
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

<tr>

<td style="text-align:left;">

mSarHar1
</td>

<td style="text-align:left;">

NC_045431.1_166099
</td>

<td style="text-align:right;">

131
</td>

<td style="text-align:left;">

2
</td>

<td style="text-align:right;">

0.028
</td>

<td style="text-align:right;">

23
</td>

<td style="text-align:right;">

20.7
</td>

<td style="text-align:right;">

1
</td>

<td style="text-align:right;">

1
</td>

</tr>

</tbody>

</table>

# Finished

    ## R version 4.5.2 (2025-10-31)
    ## Platform: x86_64-pc-linux-gnu
    ## Running under: Ubuntu 24.04.3 LTS
    ## 
    ## Matrix products: default
    ## BLAS:   /usr/lib/x86_64-linux-gnu/openblas-pthread/libblas.so.3 
    ## LAPACK: /usr/lib/x86_64-linux-gnu/openblas-pthread/libopenblasp-r0.3.26.so;  LAPACK version 3.12.0
    ## 
    ## locale:
    ##  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
    ##  [3] LC_TIME=en_US.UTF-8        LC_COLLATE=en_US.UTF-8    
    ##  [5] LC_MONETARY=en_US.UTF-8    LC_MESSAGES=en_US.UTF-8   
    ##  [7] LC_PAPER=en_US.UTF-8       LC_NAME=C                 
    ##  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
    ## [11] LC_MEASUREMENT=en_US.UTF-8 LC_IDENTIFICATION=C       
    ## 
    ## time zone: Etc/UTC
    ## tzcode source: system (glibc)
    ## 
    ## attached base packages:
    ## [1] stats4    stats     graphics  grDevices utils     datasets  methods  
    ## [8] base     
    ## 
    ## other attached packages:
    ##  [1] xml2_1.4.1            kableExtra_1.4.0      Biostrings_2.78.0    
    ##  [4] Seqinfo_1.0.0         XVector_0.50.0        IRanges_2.44.0       
    ##  [7] S4Vectors_0.48.1      BiocGenerics_0.56.0   generics_0.1.4       
    ## [10] ggseqlogo_0.2.2       universalmotif_1.28.0 janitor_2.2.1        
    ## [13] patchwork_1.3.2       here_1.0.2            lubridate_1.9.5      
    ## [16] forcats_1.0.1         stringr_1.5.2         dplyr_1.2.1          
    ## [19] purrr_1.1.0           readr_2.2.0           tidyr_1.3.2          
    ## [22] tibble_3.3.1          ggplot2_4.0.2         tidyverse_2.0.0      
    ## 
    ## loaded via a namespace (and not attached):
    ##  [1] gtable_0.3.6          xfun_0.54             tzdb_0.5.0           
    ##  [4] vctrs_0.7.2           tools_4.5.2           parallel_4.5.2       
    ##  [7] pkgconfig_2.0.3       RColorBrewer_1.1-3    S7_0.2.1             
    ## [10] lifecycle_1.0.5       compiler_4.5.2        farver_2.1.2         
    ## [13] textshaping_1.0.4     snakecase_0.11.1      htmltools_0.5.8.1    
    ## [16] yaml_2.3.10           pillar_1.11.1         crayon_1.5.3         
    ## [19] MASS_7.3-65           tidyselect_1.2.1      digest_0.6.37        
    ## [22] stringi_1.8.7         rprojroot_2.1.1       fastmap_1.2.0        
    ## [25] grid_4.5.2            cli_3.6.5             magrittr_2.0.4       
    ## [28] dichromat_2.0-0.1     withr_3.0.2           scales_1.4.0         
    ## [31] bit64_4.6.0-1         timechange_0.4.0      rmarkdown_2.30       
    ## [34] matrixStats_1.5.0     bit_4.6.0             ragg_1.5.0           
    ## [37] hms_1.1.4             evaluate_1.0.5        knitr_1.50           
    ## [40] viridisLite_0.4.3     rlang_1.2.0           Rcpp_1.1.0           
    ## [43] glue_1.8.0            vroom_1.7.1           svglite_2.2.2        
    ## [46] rstudioapi_0.17.1     R6_2.6.1              MatrixGenerics_1.22.0
    ## [49] systemfonts_1.3.1
