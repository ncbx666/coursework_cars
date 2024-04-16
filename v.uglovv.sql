--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

-- Started on 2024-02-20 20:36:39

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS cars;
--
-- TOC entry 3395 (class 1262 OID 24576)
-- Name: cars; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE cars WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE cars OWNER TO postgres;

\connect cars

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 24844)
-- Name: brands; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.brands (
    id_brand integer NOT NULL,
    brand_name character varying(50) NOT NULL,
    country character varying(100) NOT NULL
);


ALTER TABLE public.brands OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 24843)
-- Name: brands_id_brand_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.brands_id_brand_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.brands_id_brand_seq OWNER TO postgres;

--
-- TOC entry 3396 (class 0 OID 0)
-- Dependencies: 216
-- Name: brands_id_brand_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.brands_id_brand_seq OWNED BY public.brands.id_brand;


--
-- TOC entry 225 (class 1259 OID 25010)
-- Name: dealership_brand; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dealership_brand (
    id_dealership integer NOT NULL,
    id_brand integer NOT NULL
);


ALTER TABLE public.dealership_brand OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 24837)
-- Name: dealerships; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dealerships (
    id_dealership integer NOT NULL,
    title character varying(30) NOT NULL,
    address character varying(100) NOT NULL,
    trade_in boolean
);


ALTER TABLE public.dealerships OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 24836)
-- Name: dealerships_id_dealerships_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.dealerships_id_dealerships_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.dealerships_id_dealerships_seq OWNER TO postgres;

--
-- TOC entry 3397 (class 0 OID 0)
-- Dependencies: 214
-- Name: dealerships_id_dealerships_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.dealerships_id_dealerships_seq OWNED BY public.dealerships.id_dealership;


--
-- TOC entry 219 (class 1259 OID 24874)
-- Name: engines; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.engines (
    id_engine integer NOT NULL,
    name_of_engine character varying(50),
    engine_power smallint NOT NULL,
    engine_type character varying(30) NOT NULL,
    number_of_cylind smallint,
    capacity smallint,
    CONSTRAINT positive_power CHECK ((engine_power > 30))
);


ALTER TABLE public.engines OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 24873)
-- Name: engines_id_engine_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.engines_id_engine_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.engines_id_engine_seq OWNER TO postgres;

--
-- TOC entry 3398 (class 0 OID 0)
-- Dependencies: 218
-- Name: engines_id_engine_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.engines_id_engine_seq OWNED BY public.engines.id_engine;


--
-- TOC entry 224 (class 1259 OID 24995)
-- Name: model_engine; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.model_engine (
    id_model integer NOT NULL,
    id_engine integer NOT NULL
);


ALTER TABLE public.model_engine OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 24899)
-- Name: models; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.models (
    id_model integer NOT NULL,
    model_name character varying(50) NOT NULL,
    id_brand integer,
    id_spec integer,
    type_of_car character varying(30) NOT NULL,
    release_date smallint,
    price bigint,
    CONSTRAINT positive_price CHECK ((price > 0)),
    CONSTRAINT valid_date CHECK ((release_date > 0))
);


ALTER TABLE public.models OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 24898)
-- Name: models_id_model_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.models_id_model_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.models_id_model_seq OWNER TO postgres;

--
-- TOC entry 3399 (class 0 OID 0)
-- Dependencies: 222
-- Name: models_id_model_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.models_id_model_seq OWNED BY public.models.id_model;


--
-- TOC entry 221 (class 1259 OID 24889)
-- Name: specifications; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.specifications (
    id_spec integer NOT NULL,
    num_of_seats smallint,
    weight numeric(7,3),
    drive character varying(20) NOT NULL,
    acceleration_to_100 smallint,
    CONSTRAINT positive_acceleration CHECK ((acceleration_to_100 > 0)),
    CONSTRAINT postivie_number CHECK ((num_of_seats > 0)),
    CONSTRAINT valid_weight CHECK (((weight > (300)::numeric) AND ((weight)::double precision < power((10)::double precision, (7)::double precision))))
);


ALTER TABLE public.specifications OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 24888)
-- Name: specifications_id_spec_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.specifications_id_spec_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.specifications_id_spec_seq OWNER TO postgres;

--
-- TOC entry 3400 (class 0 OID 0)
-- Dependencies: 220
-- Name: specifications_id_spec_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.specifications_id_spec_seq OWNED BY public.specifications.id_spec;


--
-- TOC entry 3202 (class 2604 OID 24847)
-- Name: brands id_brand; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands ALTER COLUMN id_brand SET DEFAULT nextval('public.brands_id_brand_seq'::regclass);


--
-- TOC entry 3201 (class 2604 OID 24840)
-- Name: dealerships id_dealership; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealerships ALTER COLUMN id_dealership SET DEFAULT nextval('public.dealerships_id_dealerships_seq'::regclass);


--
-- TOC entry 3203 (class 2604 OID 24877)
-- Name: engines id_engine; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.engines ALTER COLUMN id_engine SET DEFAULT nextval('public.engines_id_engine_seq'::regclass);


--
-- TOC entry 3205 (class 2604 OID 24902)
-- Name: models id_model; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models ALTER COLUMN id_model SET DEFAULT nextval('public.models_id_model_seq'::regclass);


--
-- TOC entry 3204 (class 2604 OID 24892)
-- Name: specifications id_spec; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specifications ALTER COLUMN id_spec SET DEFAULT nextval('public.specifications_id_spec_seq'::regclass);


--
-- TOC entry 3381 (class 0 OID 24844)
-- Dependencies: 217
-- Data for Name: brands; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.brands (id_brand, brand_name, country) FROM stdin;
\.


--
-- TOC entry 3389 (class 0 OID 25010)
-- Dependencies: 225
-- Data for Name: dealership_brand; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dealership_brand (id_dealership, id_brand) FROM stdin;
\.


--
-- TOC entry 3379 (class 0 OID 24837)
-- Dependencies: 215
-- Data for Name: dealerships; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.dealerships (id_dealership, title, address, trade_in) FROM stdin;
\.


--
-- TOC entry 3383 (class 0 OID 24874)
-- Dependencies: 219
-- Data for Name: engines; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.engines (id_engine, name_of_engine, engine_power, engine_type, number_of_cylind, capacity) FROM stdin;
\.


--
-- TOC entry 3388 (class 0 OID 24995)
-- Dependencies: 224
-- Data for Name: model_engine; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.model_engine (id_model, id_engine) FROM stdin;
\.


--
-- TOC entry 3387 (class 0 OID 24899)
-- Dependencies: 223
-- Data for Name: models; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.models (id_model, model_name, id_brand, id_spec, type_of_car, release_date, price) FROM stdin;
\.


--
-- TOC entry 3385 (class 0 OID 24889)
-- Dependencies: 221
-- Data for Name: specifications; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.specifications (id_spec, num_of_seats, weight, drive, acceleration_to_100) FROM stdin;
\.


--
-- TOC entry 3401 (class 0 OID 0)
-- Dependencies: 216
-- Name: brands_id_brand_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.brands_id_brand_seq', 1, false);


--
-- TOC entry 3402 (class 0 OID 0)
-- Dependencies: 214
-- Name: dealerships_id_dealerships_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.dealerships_id_dealerships_seq', 1, false);


--
-- TOC entry 3403 (class 0 OID 0)
-- Dependencies: 218
-- Name: engines_id_engine_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.engines_id_engine_seq', 1, false);


--
-- TOC entry 3404 (class 0 OID 0)
-- Dependencies: 222
-- Name: models_id_model_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.models_id_model_seq', 1, false);


--
-- TOC entry 3405 (class 0 OID 0)
-- Dependencies: 220
-- Name: specifications_id_spec_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.specifications_id_spec_seq', 1, false);


--
-- TOC entry 3215 (class 2606 OID 24851)
-- Name: brands brands_brand_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_brand_name_key UNIQUE (brand_name);


--
-- TOC entry 3217 (class 2606 OID 24849)
-- Name: brands brands_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id_brand);


--
-- TOC entry 3213 (class 2606 OID 24842)
-- Name: dealerships dealerships_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealerships
    ADD CONSTRAINT dealerships_pkey PRIMARY KEY (id_dealership);


--
-- TOC entry 3219 (class 2606 OID 24882)
-- Name: engines engines_name_of_engine_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.engines
    ADD CONSTRAINT engines_name_of_engine_key UNIQUE (name_of_engine);


--
-- TOC entry 3221 (class 2606 OID 24880)
-- Name: engines engines_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.engines
    ADD CONSTRAINT engines_pkey PRIMARY KEY (id_engine);


--
-- TOC entry 3229 (class 2606 OID 25014)
-- Name: dealership_brand id_dealership_brand; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealership_brand
    ADD CONSTRAINT id_dealership_brand PRIMARY KEY (id_dealership, id_brand);


--
-- TOC entry 3227 (class 2606 OID 24999)
-- Name: model_engine id_model_engine; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_engine
    ADD CONSTRAINT id_model_engine PRIMARY KEY (id_model, id_engine);


--
-- TOC entry 3225 (class 2606 OID 24906)
-- Name: models models_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_pkey PRIMARY KEY (id_model);


--
-- TOC entry 3223 (class 2606 OID 24897)
-- Name: specifications specifications_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.specifications
    ADD CONSTRAINT specifications_pkey PRIMARY KEY (id_spec);


--
-- TOC entry 3234 (class 2606 OID 25020)
-- Name: dealership_brand dealership_brand_id_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealership_brand
    ADD CONSTRAINT dealership_brand_id_brand_fkey FOREIGN KEY (id_brand) REFERENCES public.brands(id_brand);


--
-- TOC entry 3235 (class 2606 OID 25015)
-- Name: dealership_brand dealership_brand_id_dealership_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dealership_brand
    ADD CONSTRAINT dealership_brand_id_dealership_fkey FOREIGN KEY (id_dealership) REFERENCES public.dealerships(id_dealership);


--
-- TOC entry 3232 (class 2606 OID 25005)
-- Name: model_engine model_engine_id_engine_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_engine
    ADD CONSTRAINT model_engine_id_engine_fkey FOREIGN KEY (id_engine) REFERENCES public.engines(id_engine);


--
-- TOC entry 3233 (class 2606 OID 25000)
-- Name: model_engine model_engine_id_model_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.model_engine
    ADD CONSTRAINT model_engine_id_model_fkey FOREIGN KEY (id_model) REFERENCES public.models(id_model);


--
-- TOC entry 3230 (class 2606 OID 24917)
-- Name: models models_id_brand_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_id_brand_fkey FOREIGN KEY (id_brand) REFERENCES public.brands(id_brand);


--
-- TOC entry 3231 (class 2606 OID 24912)
-- Name: models models_id_spec_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.models
    ADD CONSTRAINT models_id_spec_fkey FOREIGN KEY (id_spec) REFERENCES public.specifications(id_spec);


-- Completed on 2024-02-20 20:36:39

--
-- PostgreSQL database dump complete
--

