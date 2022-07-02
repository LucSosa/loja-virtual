--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.25
-- Dumped by pg_dump version 9.5.25

-- Started on 2022-07-02 06:07:33

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 2350 (class 1262 OID 16466)
-- Name: loja-virtual; Type: DATABASE; Schema: -; Owner: postgres
--

--CREATE DATABASE "loja-virtual" WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Portuguese_Brazil.1252' LC_CTYPE = 'Portuguese_Brazil.1252';


ALTER DATABASE "loja-virtual" OWNER TO postgres;

--\connect -reuse-previous=on "dbname='loja-virtual'"

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 1 (class 3079 OID 12355)
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner:
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- TOC entry 2353 (class 0 OID 0)
-- Dependencies: 1
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner:
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- TOC entry 223 (class 1255 OID 16954)
-- Name: validachavepessoa(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validachavepessoa() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE existe INTEGER;

BEGIN
			existe = (SELECT COUNT(1) FROM pessoa_fisica WHERE id = NEW.pessoa_id);
	       if(existe <= 0) THEN
			existe = (SELECT COUNT(1) FROM pessoa_juridica WHERE id = NEW.pessoa_id);
		if(existe <= 0) THEN
			RAISE EXCEPTION 'Não foi encontrado o ID e PK da pessoa para realizar a associação do cadastro';
end if;
end if;
RETURN NEW;
END;
	$$;


ALTER FUNCTION public.validachavepessoa() OWNER TO postgres;

--
-- TOC entry 224 (class 1255 OID 16961)
-- Name: validachavepessoa2(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.validachavepessoa2() RETURNS trigger
    LANGUAGE plpgsql
    AS $$

DECLARE existe INTEGER;

BEGIN
			existe = (SELECT COUNT(1) FROM pessoa_fisica WHERE id = NEW.pessoa_forn_id);
	       if(existe <= 0) THEN
			existe = (SELECT COUNT(1) FROM pessoa_juridica WHERE id = NEW.pessoa_forn_id);
		if(existe <= 0) THEN
			RAISE EXCEPTION 'Não foi encontrado o ID e PK da pessoa para realizar a associação do cadastro';
end if;
end if;
RETURN NEW;
END;
	$$;


ALTER FUNCTION public.validachavepessoa2() OWNER TO postgres;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- TOC entry 202 (class 1259 OID 16737)
-- Name: acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.acesso (
                               id bigint NOT NULL,
                               descricao character varying(255) NOT NULL
);


ALTER TABLE public.acesso OWNER TO postgres;

--
-- TOC entry 203 (class 1259 OID 16742)
-- Name: avaliacao_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.avaliacao_produto (
                                          id bigint NOT NULL,
                                          descricao character varying(255) NOT NULL,
                                          nota integer NOT NULL,
                                          pessoa_id bigint NOT NULL,
                                          produto_id bigint NOT NULL
);


ALTER TABLE public.avaliacao_produto OWNER TO postgres;

--
-- TOC entry 204 (class 1259 OID 16747)
-- Name: categoria_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.categoria_produto (
                                          id bigint NOT NULL,
                                          nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.categoria_produto OWNER TO postgres;

--
-- TOC entry 205 (class 1259 OID 16752)
-- Name: conta_pagar; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conta_pagar (
                                    id bigint NOT NULL,
                                    descricao character varying(255) NOT NULL,
                                    dt_pagamento date,
                                    dt_vencimento date,
                                    status character varying(255),
                                    valor_desconto numeric(19,2),
                                    valor_total numeric(19,2) NOT NULL,
                                    pessoa_id bigint NOT NULL,
                                    pessoa_forn_id bigint NOT NULL
);


ALTER TABLE public.conta_pagar OWNER TO postgres;

--
-- TOC entry 206 (class 1259 OID 16760)
-- Name: conta_receber; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conta_receber (
                                      id bigint NOT NULL,
                                      descricao character varying(255) NOT NULL,
                                      dt_pagamento date,
                                      dt_vencimento date NOT NULL,
                                      status character varying(255) NOT NULL,
                                      valor_desconto numeric(19,2),
                                      valor_total numeric(19,2) NOT NULL,
                                      pessoa_id bigint NOT NULL
);


ALTER TABLE public.conta_receber OWNER TO postgres;

--
-- TOC entry 207 (class 1259 OID 16768)
-- Name: cup_desc; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cup_desc (
                                 id bigint NOT NULL,
                                 cod_desc character varying(255) NOT NULL,
                                 data_validade_cupom date NOT NULL,
                                 valor_porcent_desc numeric(19,2),
                                 valor_real_desc numeric(19,2)
);


ALTER TABLE public.cup_desc OWNER TO postgres;

--
-- TOC entry 208 (class 1259 OID 16773)
-- Name: endereco; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.endereco (
                                 id bigint NOT NULL,
                                 bairro character varying(255) NOT NULL,
                                 cep character varying(255) NOT NULL,
                                 cidade character varying(255) NOT NULL,
                                 complemento character varying(255),
                                 numero character varying(255) NOT NULL,
                                 rua_logra character varying(255) NOT NULL,
                                 tipo_endereco character varying(255) NOT NULL,
                                 uf character varying(255) NOT NULL,
                                 pessoa_id bigint NOT NULL
);


ALTER TABLE public.endereco OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16781)
-- Name: forma_pagamento; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.forma_pagamento (
                                        id bigint NOT NULL,
                                        descricao character varying(255) NOT NULL
);


ALTER TABLE public.forma_pagamento OWNER TO postgres;

--
-- TOC entry 181 (class 1259 OID 16472)
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16786)
-- Name: imagem_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.imagem_produto (
                                       id bigint NOT NULL,
                                       imagem_miniatura text NOT NULL,
                                       imagem_original text NOT NULL,
                                       produto_id bigint NOT NULL
);


ALTER TABLE public.imagem_produto OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16794)
-- Name: item_venda_loja; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.item_venda_loja (
                                        id bigint NOT NULL,
                                        quantidade double precision NOT NULL,
                                        produto_id bigint NOT NULL,
                                        venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.item_venda_loja OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16799)
-- Name: marca_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.marca_produto (
                                      id bigint NOT NULL,
                                      nome_desc character varying(255) NOT NULL
);


ALTER TABLE public.marca_produto OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16804)
-- Name: nota_fiscal_compra; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_fiscal_compra (
                                           id bigint NOT NULL,
                                           data_compra date NOT NULL,
                                           descricao_obs character varying(255),
                                           numero_nota character varying(255) NOT NULL,
                                           serie_nota character varying(255) NOT NULL,
                                           valor_desconto numeric(19,2),
                                           valor_icms numeric(19,2) NOT NULL,
                                           valor_total numeric(19,2) NOT NULL,
                                           conta_pagar_id bigint NOT NULL,
                                           pessoa_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16812)
-- Name: nota_fiscal_venda; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_fiscal_venda (
                                          id bigint NOT NULL,
                                          numero character varying(255) NOT NULL,
                                          pdf text NOT NULL,
                                          serie character varying(255) NOT NULL,
                                          tipo character varying(255) NOT NULL,
                                          xml text NOT NULL,
                                          venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16820)
-- Name: nota_item_produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.nota_item_produto (
                                          id bigint NOT NULL,
                                          quantidade double precision NOT NULL,
                                          nota_fiscal_compra_id bigint NOT NULL,
                                          produto_id bigint NOT NULL
);


ALTER TABLE public.nota_item_produto OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16825)
-- Name: pessoa_fisica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa_fisica (
                                      id bigint NOT NULL,
                                      email character varying(255) NOT NULL,
                                      nome character varying(255) NOT NULL,
                                      telefone character varying(255) NOT NULL,
                                      cpf character varying(255) NOT NULL,
                                      data_nascimento date
);


ALTER TABLE public.pessoa_fisica OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16833)
-- Name: pessoa_juridica; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.pessoa_juridica (
                                        id bigint NOT NULL,
                                        email character varying(255) NOT NULL,
                                        nome character varying(255) NOT NULL,
                                        telefone character varying(255) NOT NULL,
                                        categoria character varying(255),
                                        cnpj character varying(255) NOT NULL,
                                        insc_estadual character varying(255) NOT NULL,
                                        insc_municipal character varying(255),
                                        nome_fantasia character varying(255),
                                        razao_social character varying(255) NOT NULL
);


ALTER TABLE public.pessoa_juridica OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16841)
-- Name: produto; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.produto (
                                id bigint NOT NULL,
                                alerta_qtd_estoque boolean,
                                altura double precision NOT NULL,
                                ativo boolean NOT NULL,
                                descricao text NOT NULL,
                                largura double precision NOT NULL,
                                link_youtube character varying(255),
                                nome character varying(255) NOT NULL,
                                peso double precision NOT NULL,
                                profundidade double precision NOT NULL,
                                qtd_alerta_estoque integer,
                                qtd_de_clique integer,
                                qtd_estoque integer NOT NULL,
                                tipo_unidade character varying(255) NOT NULL,
                                valor_venda numeric(19,2) NOT NULL
);


ALTER TABLE public.produto OWNER TO postgres;

--
-- TOC entry 184 (class 1259 OID 16488)
-- Name: seq_acesso; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_acesso
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_acesso OWNER TO postgres;

--
-- TOC entry 201 (class 1259 OID 16734)
-- Name: seq_avaliacao_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_avaliacao_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_avaliacao_produto OWNER TO postgres;

--
-- TOC entry 198 (class 1259 OID 16723)
-- Name: seq_avaliacao_produto_loja; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_avaliacao_produto_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_avaliacao_produto_loja OWNER TO postgres;

--
-- TOC entry 182 (class 1259 OID 16479)
-- Name: seq_categoria_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_categoria_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_categoria_produto OWNER TO postgres;

--
-- TOC entry 189 (class 1259 OID 16571)
-- Name: seq_conta_pagar; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_conta_pagar
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_conta_pagar OWNER TO postgres;

--
-- TOC entry 188 (class 1259 OID 16555)
-- Name: seq_conta_receber; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_conta_receber
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_conta_receber OWNER TO postgres;

--
-- TOC entry 190 (class 1259 OID 16578)
-- Name: seq_cup_desc; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_cup_desc
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_cup_desc OWNER TO postgres;

--
-- TOC entry 186 (class 1259 OID 16516)
-- Name: seq_endereco; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_endereco
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_endereco OWNER TO postgres;

--
-- TOC entry 192 (class 1259 OID 16598)
-- Name: seq_image_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_image_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_image_produto OWNER TO postgres;

--
-- TOC entry 193 (class 1259 OID 16613)
-- Name: seq_imagem_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_imagem_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_imagem_produto OWNER TO postgres;

--
-- TOC entry 199 (class 1259 OID 16725)
-- Name: seq_item_venda_loja; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_item_venda_loja
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_item_venda_loja OWNER TO postgres;

--
-- TOC entry 183 (class 1259 OID 16481)
-- Name: seq_marca_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_marca_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_marca_produto OWNER TO postgres;

--
-- TOC entry 194 (class 1259 OID 16628)
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_fiscal_compra
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_compra OWNER TO postgres;

--
-- TOC entry 197 (class 1259 OID 16670)
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_fiscal_venda
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_fiscal_venda OWNER TO postgres;

--
-- TOC entry 195 (class 1259 OID 16640)
-- Name: seq_nota_item_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_nota_item_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_nota_item_produto OWNER TO postgres;

--
-- TOC entry 185 (class 1259 OID 16506)
-- Name: seq_pessoa; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_pessoa
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_pessoa OWNER TO postgres;

--
-- TOC entry 191 (class 1259 OID 16588)
-- Name: seq_produto; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_produto
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_produto OWNER TO postgres;

--
-- TOC entry 196 (class 1259 OID 16660)
-- Name: seq_status_rastreio; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_status_rastreio
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_status_rastreio OWNER TO postgres;

--
-- TOC entry 187 (class 1259 OID 16535)
-- Name: seq_usuario; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_usuario
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_usuario OWNER TO postgres;

--
-- TOC entry 200 (class 1259 OID 16727)
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.seq_vd_cp_loja_virt
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.seq_vd_cp_loja_virt OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16849)
-- Name: status_rastreio; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.status_rastreio (
                                        id bigint NOT NULL,
                                        centro_distribuicao character varying(255),
                                        cidade character varying(255),
                                        estado character varying(255),
                                        status character varying(255),
                                        venda_compra_loja_virt_id bigint NOT NULL
);


ALTER TABLE public.status_rastreio OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16857)
-- Name: usuario; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario (
                                id bigint NOT NULL,
                                data_atual_senha date NOT NULL,
                                login character varying(255) NOT NULL,
                                senha character varying(255) NOT NULL,
                                pessoa_id bigint NOT NULL
);


ALTER TABLE public.usuario OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16865)
-- Name: usuario_acesso; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.usuario_acesso (
                                       usuario_id bigint NOT NULL,
                                       acesso_id bigint NOT NULL
);


ALTER TABLE public.usuario_acesso OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16868)
-- Name: vd_cp_loja_virt; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vd_cp_loja_virt (
                                        id bigint NOT NULL,
                                        data_entrega date NOT NULL,
                                        data_venda date NOT NULL,
                                        dia_entrega integer NOT NULL,
                                        valor_desconto numeric(19,2),
                                        valor_frete numeric(19,2) NOT NULL,
                                        valor_total numeric(19,2) NOT NULL,
                                        cupom_desc_id bigint,
                                        endereco_cobranca_id bigint NOT NULL,
                                        endereco_entrega_id bigint NOT NULL,
                                        forma_pagamento_id bigint NOT NULL,
                                        nota_fiscal_venda_id bigint NOT NULL,
                                        pessoa_id bigint NOT NULL
);


ALTER TABLE public.vd_cp_loja_virt OWNER TO postgres;

--
-- TOC entry 2324 (class 0 OID 16737)
-- Dependencies: 202
-- Data for Name: acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2325 (class 0 OID 16742)
-- Dependencies: 203
-- Data for Name: avaliacao_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2326 (class 0 OID 16747)
-- Dependencies: 204
-- Data for Name: categoria_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2327 (class 0 OID 16752)
-- Dependencies: 205
-- Data for Name: conta_pagar; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2328 (class 0 OID 16760)
-- Dependencies: 206
-- Data for Name: conta_receber; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2329 (class 0 OID 16768)
-- Dependencies: 207
-- Data for Name: cup_desc; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2330 (class 0 OID 16773)
-- Dependencies: 208
-- Data for Name: endereco; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2331 (class 0 OID 16781)
-- Dependencies: 209
-- Data for Name: forma_pagamento; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2354 (class 0 OID 0)
-- Dependencies: 181
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.hibernate_sequence', 1, false);


--
-- TOC entry 2332 (class 0 OID 16786)
-- Dependencies: 210
-- Data for Name: imagem_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2333 (class 0 OID 16794)
-- Dependencies: 211
-- Data for Name: item_venda_loja; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2334 (class 0 OID 16799)
-- Dependencies: 212
-- Data for Name: marca_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2335 (class 0 OID 16804)
-- Dependencies: 213
-- Data for Name: nota_fiscal_compra; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2336 (class 0 OID 16812)
-- Dependencies: 214
-- Data for Name: nota_fiscal_venda; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2337 (class 0 OID 16820)
-- Dependencies: 215
-- Data for Name: nota_item_produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2338 (class 0 OID 16825)
-- Dependencies: 216
-- Data for Name: pessoa_fisica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2339 (class 0 OID 16833)
-- Dependencies: 217
-- Data for Name: pessoa_juridica; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2340 (class 0 OID 16841)
-- Dependencies: 218
-- Data for Name: produto; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2355 (class 0 OID 0)
-- Dependencies: 184
-- Name: seq_acesso; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_acesso', 1, false);


--
-- TOC entry 2356 (class 0 OID 0)
-- Dependencies: 201
-- Name: seq_avaliacao_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_avaliacao_produto', 1, false);


--
-- TOC entry 2357 (class 0 OID 0)
-- Dependencies: 198
-- Name: seq_avaliacao_produto_loja; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_avaliacao_produto_loja', 1, false);


--
-- TOC entry 2358 (class 0 OID 0)
-- Dependencies: 182
-- Name: seq_categoria_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_categoria_produto', 1, false);


--
-- TOC entry 2359 (class 0 OID 0)
-- Dependencies: 189
-- Name: seq_conta_pagar; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_conta_pagar', 1, false);


--
-- TOC entry 2360 (class 0 OID 0)
-- Dependencies: 188
-- Name: seq_conta_receber; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_conta_receber', 1, false);


--
-- TOC entry 2361 (class 0 OID 0)
-- Dependencies: 190
-- Name: seq_cup_desc; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_cup_desc', 1, false);


--
-- TOC entry 2362 (class 0 OID 0)
-- Dependencies: 186
-- Name: seq_endereco; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_endereco', 1, false);


--
-- TOC entry 2363 (class 0 OID 0)
-- Dependencies: 192
-- Name: seq_image_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_image_produto', 1, false);


--
-- TOC entry 2364 (class 0 OID 0)
-- Dependencies: 193
-- Name: seq_imagem_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_imagem_produto', 1, false);


--
-- TOC entry 2365 (class 0 OID 0)
-- Dependencies: 199
-- Name: seq_item_venda_loja; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_item_venda_loja', 1, false);


--
-- TOC entry 2366 (class 0 OID 0)
-- Dependencies: 183
-- Name: seq_marca_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_marca_produto', 1, false);


--
-- TOC entry 2367 (class 0 OID 0)
-- Dependencies: 194
-- Name: seq_nota_fiscal_compra; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_compra', 1, false);


--
-- TOC entry 2368 (class 0 OID 0)
-- Dependencies: 197
-- Name: seq_nota_fiscal_venda; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_nota_fiscal_venda', 1, false);


--
-- TOC entry 2369 (class 0 OID 0)
-- Dependencies: 195
-- Name: seq_nota_item_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_nota_item_produto', 1, false);


--
-- TOC entry 2370 (class 0 OID 0)
-- Dependencies: 185
-- Name: seq_pessoa; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_pessoa', 1, false);


--
-- TOC entry 2371 (class 0 OID 0)
-- Dependencies: 191
-- Name: seq_produto; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_produto', 1, false);


--
-- TOC entry 2372 (class 0 OID 0)
-- Dependencies: 196
-- Name: seq_status_rastreio; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_status_rastreio', 1, false);


--
-- TOC entry 2373 (class 0 OID 0)
-- Dependencies: 187
-- Name: seq_usuario; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_usuario', 1, false);


--
-- TOC entry 2374 (class 0 OID 0)
-- Dependencies: 200
-- Name: seq_vd_cp_loja_virt; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.seq_vd_cp_loja_virt', 1, false);


--
-- TOC entry 2341 (class 0 OID 16849)
-- Dependencies: 219
-- Data for Name: status_rastreio; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2342 (class 0 OID 16857)
-- Dependencies: 220
-- Data for Name: usuario; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2343 (class 0 OID 16865)
-- Dependencies: 221
-- Data for Name: usuario_acesso; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2344 (class 0 OID 16868)
-- Dependencies: 222
-- Data for Name: vd_cp_loja_virt; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 2115 (class 2606 OID 16741)
-- Name: acesso_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.acesso
    ADD CONSTRAINT acesso_pkey PRIMARY KEY (id);


--
-- TOC entry 2117 (class 2606 OID 16746)
-- Name: avaliacao_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT avaliacao_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2119 (class 2606 OID 16751)
-- Name: categoria_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.categoria_produto
    ADD CONSTRAINT categoria_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2121 (class 2606 OID 16759)
-- Name: conta_pagar_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_pagar
    ADD CONSTRAINT conta_pagar_pkey PRIMARY KEY (id);


--
-- TOC entry 2123 (class 2606 OID 16767)
-- Name: conta_receber_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conta_receber
    ADD CONSTRAINT conta_receber_pkey PRIMARY KEY (id);


--
-- TOC entry 2125 (class 2606 OID 16772)
-- Name: cup_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cup_desc
    ADD CONSTRAINT cup_desc_pkey PRIMARY KEY (id);


--
-- TOC entry 2127 (class 2606 OID 16780)
-- Name: endereco_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.endereco
    ADD CONSTRAINT endereco_pkey PRIMARY KEY (id);


--
-- TOC entry 2129 (class 2606 OID 16785)
-- Name: forma_pagamento_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.forma_pagamento
    ADD CONSTRAINT forma_pagamento_pkey PRIMARY KEY (id);


--
-- TOC entry 2131 (class 2606 OID 16793)
-- Name: imagem_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT imagem_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2133 (class 2606 OID 16798)
-- Name: item_venda_loja_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT item_venda_loja_pkey PRIMARY KEY (id);


--
-- TOC entry 2135 (class 2606 OID 16803)
-- Name: marca_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.marca_produto
    ADD CONSTRAINT marca_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2137 (class 2606 OID 16811)
-- Name: nota_fiscal_compra_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT nota_fiscal_compra_pkey PRIMARY KEY (id);


--
-- TOC entry 2139 (class 2606 OID 16819)
-- Name: nota_fiscal_venda_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT nota_fiscal_venda_pkey PRIMARY KEY (id);


--
-- TOC entry 2141 (class 2606 OID 16824)
-- Name: nota_item_produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_item_produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2143 (class 2606 OID 16832)
-- Name: pessoa_fisica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_fisica
    ADD CONSTRAINT pessoa_fisica_pkey PRIMARY KEY (id);


--
-- TOC entry 2145 (class 2606 OID 16840)
-- Name: pessoa_juridica_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.pessoa_juridica
    ADD CONSTRAINT pessoa_juridica_pkey PRIMARY KEY (id);


--
-- TOC entry 2147 (class 2606 OID 16848)
-- Name: produto_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.produto
    ADD CONSTRAINT produto_pkey PRIMARY KEY (id);


--
-- TOC entry 2149 (class 2606 OID 16856)
-- Name: status_rastreio_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT status_rastreio_pkey PRIMARY KEY (id);


--
-- TOC entry 2153 (class 2606 OID 16874)
-- Name: uk_fhwpg5wu1u5p306q8gycxn9ky; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT uk_fhwpg5wu1u5p306q8gycxn9ky UNIQUE (acesso_id);


--
-- TOC entry 2155 (class 2606 OID 16876)
-- Name: unique_acesso_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT unique_acesso_user UNIQUE (usuario_id, acesso_id);


--
-- TOC entry 2151 (class 2606 OID 16864)
-- Name: usuario_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario
    ADD CONSTRAINT usuario_pkey PRIMARY KEY (id);


--
-- TOC entry 2157 (class 2606 OID 16872)
-- Name: vd_cp_loja_virt_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT vd_cp_loja_virt_pkey PRIMARY KEY (id);


--
-- TOC entry 2179 (class 2620 OID 16965)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.conta_receber FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2181 (class 2620 OID 16967)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.endereco FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2183 (class 2620 OID 16969)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.nota_fiscal_compra FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2185 (class 2620 OID 16971)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.usuario FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2187 (class 2620 OID 16973)
-- Name: validachavepessoa; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa BEFORE UPDATE ON public.vd_cp_loja_virt FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2180 (class 2620 OID 16966)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.conta_receber FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2182 (class 2620 OID 16968)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.endereco FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2184 (class 2620 OID 16970)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.nota_fiscal_compra FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2186 (class 2620 OID 16972)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.usuario FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2188 (class 2620 OID 16974)
-- Name: validachavepessoa2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoa2 BEFORE INSERT ON public.vd_cp_loja_virt FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2173 (class 2620 OID 16955)
-- Name: validachavepessoaavaliacaoproduto; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoproduto BEFORE UPDATE ON public.avaliacao_produto FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2174 (class 2620 OID 16957)
-- Name: validachavepessoaavaliacaoprodutoinsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoaavaliacaoprodutoinsert BEFORE INSERT ON public.avaliacao_produto FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2175 (class 2620 OID 16959)
-- Name: validachavepessoacontapagar; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2177 (class 2620 OID 16963)
-- Name: validachavepessoacontapagar2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagar2 BEFORE UPDATE ON public.conta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa2();


--
-- TOC entry 2176 (class 2620 OID 16960)
-- Name: validachavepessoacontapagarinsert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagarinsert BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa();


--
-- TOC entry 2178 (class 2620 OID 16964)
-- Name: validachavepessoacontapagarinsert2; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER validachavepessoacontapagarinsert2 BEFORE INSERT ON public.conta_pagar FOR EACH ROW EXECUTE PROCEDURE public.validachavepessoa2();


--
-- TOC entry 2166 (class 2606 OID 16919)
-- Name: acesso_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT acesso_fk FOREIGN KEY (acesso_id) REFERENCES public.acesso(id);


--
-- TOC entry 2161 (class 2606 OID 16894)
-- Name: conta_pagar_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_compra
    ADD CONSTRAINT conta_pagar_fk FOREIGN KEY (conta_pagar_id) REFERENCES public.conta_pagar(id);


--
-- TOC entry 2168 (class 2606 OID 16929)
-- Name: cupom_desc_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT cupom_desc_fk FOREIGN KEY (cupom_desc_id) REFERENCES public.cup_desc(id);


--
-- TOC entry 2169 (class 2606 OID 16934)
-- Name: endereco_cobranca_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT endereco_cobranca_fk FOREIGN KEY (endereco_cobranca_id) REFERENCES public.endereco(id);


--
-- TOC entry 2170 (class 2606 OID 16939)
-- Name: endereco_entrega_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT endereco_entrega_fk FOREIGN KEY (endereco_entrega_id) REFERENCES public.endereco(id);


--
-- TOC entry 2171 (class 2606 OID 16944)
-- Name: forma_pagamento_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT forma_pagamento_fk FOREIGN KEY (forma_pagamento_id) REFERENCES public.forma_pagamento(id);


--
-- TOC entry 2163 (class 2606 OID 16904)
-- Name: nota_fiscal_compra_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT nota_fiscal_compra_fk FOREIGN KEY (nota_fiscal_compra_id) REFERENCES public.nota_fiscal_compra(id);


--
-- TOC entry 2172 (class 2606 OID 16949)
-- Name: nota_fiscal_venda_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vd_cp_loja_virt
    ADD CONSTRAINT nota_fiscal_venda_fk FOREIGN KEY (nota_fiscal_venda_id) REFERENCES public.nota_fiscal_venda(id);


--
-- TOC entry 2158 (class 2606 OID 16879)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.avaliacao_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 2159 (class 2606 OID 16884)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.imagem_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 2164 (class 2606 OID 16909)
-- Name: produto_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_item_produto
    ADD CONSTRAINT produto_fk FOREIGN KEY (produto_id) REFERENCES public.produto(id);


--
-- TOC entry 2167 (class 2606 OID 16924)
-- Name: usuario_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.usuario_acesso
    ADD CONSTRAINT usuario_fk FOREIGN KEY (usuario_id) REFERENCES public.usuario(id);


--
-- TOC entry 2160 (class 2606 OID 16889)
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.item_venda_loja
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt(id);


--
-- TOC entry 2162 (class 2606 OID 16899)
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.nota_fiscal_venda
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt(id);


--
-- TOC entry 2165 (class 2606 OID 16914)
-- Name: venda_compra_loja_virt_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.status_rastreio
    ADD CONSTRAINT venda_compra_loja_virt_fk FOREIGN KEY (venda_compra_loja_virt_id) REFERENCES public.vd_cp_loja_virt(id);


--
-- TOC entry 2352 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


-- Completed on 2022-07-02 06:07:33

--
-- PostgreSQL database dump complete
--

