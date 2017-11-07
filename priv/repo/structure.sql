--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: refrigeration; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE refrigeration AS ENUM (
    'freezer',
    'refrigerator',
    'room_temperature'
);


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: credit_type_memberships; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE credit_type_memberships (
    id integer NOT NULL,
    food_group_id character varying(255) NOT NULL,
    credit_type_id integer NOT NULL,
    inserted_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: credit_type_memberships_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE credit_type_memberships_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: credit_type_memberships_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE credit_type_memberships_id_seq OWNED BY credit_type_memberships.id;


--
-- Name: credit_types; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE credit_types (
    id integer NOT NULL,
    name character varying(255),
    credits_per_period integer,
    period_name character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: credit_types_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE credit_types_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: credit_types_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE credit_types_id_seq OWNED BY credit_types.id;


--
-- Name: data_derivation_codes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE data_derivation_codes (
    derivation_code text NOT NULL,
    description text NOT NULL
);


--
-- Name: facilities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE facilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: food_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE food_groups (
    foodgroup_code character varying(255) NOT NULL,
    foodgroup_desc character varying(255),
    id integer
);


--
-- Name: foods; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE foods (
    ndb_no character varying(255) NOT NULL,
    foodgroup_code character varying(255) NOT NULL,
    longdesc character varying(255) NOT NULL,
    shortdesc character varying(255) NOT NULL,
    common_name character varying(255),
    manufacturer_name character varying(255),
    survey character varying(255),
    refuse_description character varying(255),
    refuse numeric,
    scientific_name character varying(255),
    n_factor numeric,
    pro_factor numeric,
    fat_factor numeric,
    cho_factor numeric,
    id integer,
    food_group_id integer
);


--
-- Name: footnotes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE footnotes (
    ndb_no text,
    footnote_no text,
    footnote_type text,
    nutr_no text,
    footnote_text text NOT NULL
);


--
-- Name: langua_l_desc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE langua_l_desc (
    factor_code text NOT NULL,
    description text NOT NULL
);


--
-- Name: langua_l_factors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE langua_l_factors (
    ndb_no text NOT NULL,
    factor_code text NOT NULL
);


--
-- Name: languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE languages (
    id integer NOT NULL,
    iso_code character varying(255),
    english_name character varying(255),
    native_name character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: languages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE languages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE languages_id_seq OWNED BY languages.id;


--
-- Name: meals; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE meals (
    id integer NOT NULL,
    name character varying(255),
    entree character varying(255),
    side_dish1 character varying(255),
    side_dish2 character varying(255),
    dessert character varying(255),
    calories integer,
    calories_from_fat integer,
    calcium integer,
    sodium integer,
    cholesterol integer,
    carbohydrate integer,
    sugars integer,
    fat integer,
    saturated_fat integer,
    protein integer,
    fiber integer,
    weight numeric,
    description character varying(255),
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: meals_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE meals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: meals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE meals_id_seq OWNED BY meals.id;


--
-- Name: nutrient_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE nutrient_data (
    ndb_no text NOT NULL,
    nutr_no text NOT NULL,
    nutrition_value numeric NOT NULL,
    num_data_points numeric NOT NULL,
    std_error numeric,
    source_code text NOT NULL,
    derivation_code text,
    ref_ndb_no text,
    add_nutr_mark text,
    num_studies numeric,
    min numeric,
    max numeric,
    degrees_freedom numeric,
    low_error_bound numeric,
    upper_error_bound numeric,
    stat_comments text,
    add_mod_date text,
    confidence_code text
);


--
-- Name: nutrients; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE nutrients (
    nutr_no text NOT NULL,
    units text NOT NULL,
    tagname text,
    nutr_desc text NOT NULL,
    num_dec integer NOT NULL,
    sr_order numeric NOT NULL
);


--
-- Name: offers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE offers (
    id integer NOT NULL,
    name character varying(255),
    description character varying(255),
    max_per_person integer,
    max_per_package integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: offers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE offers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: offers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE offers_id_seq OWNED BY offers.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp without time zone
);


--
-- Name: source_codes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE source_codes (
    source_code text NOT NULL,
    description text NOT NULL
);


--
-- Name: sources_of_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sources_of_data (
    datasource_id text NOT NULL,
    authors text,
    title text NOT NULL,
    year text,
    journal text,
    vol_city text,
    issue_state text,
    start_page text,
    end_page text
);


--
-- Name: sources_of_data_assoc; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sources_of_data_assoc (
    ndb_no text NOT NULL,
    nutr_no text NOT NULL,
    datasource_id text NOT NULL
);


--
-- Name: stock_distributions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE stock_distributions (
    id integer NOT NULL,
    quantity integer,
    stock_id integer,
    user_order_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT non_negative_quantity CHECK ((quantity >= 0))
);


--
-- Name: CONSTRAINT non_negative_quantity ON stock_distributions; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON CONSTRAINT non_negative_quantity ON stock_distributions IS 'Non negative quantity';


--
-- Name: stock_distributions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stock_distributions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stock_distributions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stock_distributions_id_seq OWNED BY stock_distributions.id;


--
-- Name: stocks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE stocks (
    id integer NOT NULL,
    quantity integer,
    arrival timestamp without time zone,
    expiration timestamp without time zone,
    reorder_quantity integer,
    aisle character varying(255),
    "row" character varying(255),
    shelf character varying(255),
    packaging character varying(255),
    credits_per_package integer,
    food_id character varying(255),
    meal_id integer,
    offer_id integer,
    facility_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    weight numeric,
    CONSTRAINT non_negative_quantity CHECK ((quantity >= 0))
);


--
-- Name: CONSTRAINT non_negative_quantity ON stocks; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON CONSTRAINT non_negative_quantity ON stocks IS 'Non negative quantity';


--
-- Name: stocks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stocks_id_seq OWNED BY stocks.id;


--
-- Name: user_credits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_credits (
    id integer NOT NULL,
    balance integer,
    user_id integer,
    credit_type_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    CONSTRAINT non_negative_balance CHECK ((balance >= 0))
);


--
-- Name: CONSTRAINT non_negative_balance ON user_credits; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON CONSTRAINT non_negative_balance ON user_credits IS 'Non negative balance';


--
-- Name: user_credits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_credits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_credits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_credits_id_seq OWNED BY user_credits.id;


--
-- Name: user_orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_orders (
    id integer NOT NULL,
    ready_for_pickup boolean DEFAULT false NOT NULL,
    finalized boolean DEFAULT false NOT NULL,
    user_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_food_packages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_food_packages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_food_packages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_food_packages_id_seq OWNED BY user_orders.id;


--
-- Name: user_languages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_languages (
    id integer NOT NULL,
    fluent boolean DEFAULT false NOT NULL,
    user_id integer,
    language_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: user_languages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_languages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_languages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_languages_id_seq OWNED BY user_languages.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying(255),
    name character varying(255),
    phone character varying(255),
    ok_to_text boolean DEFAULT false NOT NULL,
    family_members integer,
    facility_id integer,
    primary_language_id integer,
    inserted_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: weights; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE weights (
    ndb_no text NOT NULL,
    seq text NOT NULL,
    amount numeric NOT NULL,
    msre_desc text NOT NULL,
    gram_weight numeric NOT NULL,
    num_data_points numeric,
    std_dev numeric
);


--
-- Name: credit_type_memberships id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY credit_type_memberships ALTER COLUMN id SET DEFAULT nextval('credit_type_memberships_id_seq'::regclass);


--
-- Name: credit_types id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY credit_types ALTER COLUMN id SET DEFAULT nextval('credit_types_id_seq'::regclass);


--
-- Name: languages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY languages ALTER COLUMN id SET DEFAULT nextval('languages_id_seq'::regclass);


--
-- Name: meals id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY meals ALTER COLUMN id SET DEFAULT nextval('meals_id_seq'::regclass);


--
-- Name: offers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY offers ALTER COLUMN id SET DEFAULT nextval('offers_id_seq'::regclass);


--
-- Name: stock_distributions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_distributions ALTER COLUMN id SET DEFAULT nextval('stock_distributions_id_seq'::regclass);


--
-- Name: stocks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stocks ALTER COLUMN id SET DEFAULT nextval('stocks_id_seq'::regclass);


--
-- Name: user_credits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_credits ALTER COLUMN id SET DEFAULT nextval('user_credits_id_seq'::regclass);


--
-- Name: user_languages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_languages ALTER COLUMN id SET DEFAULT nextval('user_languages_id_seq'::regclass);


--
-- Name: user_orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_orders ALTER COLUMN id SET DEFAULT nextval('user_food_packages_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: credit_type_memberships credit_type_memberships_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY credit_type_memberships
    ADD CONSTRAINT credit_type_memberships_pkey PRIMARY KEY (id);


--
-- Name: credit_types credit_types_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY credit_types
    ADD CONSTRAINT credit_types_pkey PRIMARY KEY (id);


--
-- Name: data_derivation_codes data_derivation_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY data_derivation_codes
    ADD CONSTRAINT data_derivation_codes_pkey PRIMARY KEY (derivation_code);


--
-- Name: food_groups food_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY food_groups
    ADD CONSTRAINT food_groups_pkey PRIMARY KEY (foodgroup_code);


--
-- Name: foods foods_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foods
    ADD CONSTRAINT foods_pkey PRIMARY KEY (ndb_no);


--
-- Name: langua_l_desc langua_l_desc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY langua_l_desc
    ADD CONSTRAINT langua_l_desc_pkey PRIMARY KEY (factor_code);


--
-- Name: langua_l_factors langua_l_factors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY langua_l_factors
    ADD CONSTRAINT langua_l_factors_pkey PRIMARY KEY (ndb_no, factor_code);


--
-- Name: languages languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY languages
    ADD CONSTRAINT languages_pkey PRIMARY KEY (id);


--
-- Name: meals meals_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY meals
    ADD CONSTRAINT meals_pkey PRIMARY KEY (id);


--
-- Name: nutrient_data nutrient_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nutrient_data
    ADD CONSTRAINT nutrient_data_pkey PRIMARY KEY (ndb_no, nutr_no);


--
-- Name: nutrients nutrients_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nutrients
    ADD CONSTRAINT nutrients_pkey PRIMARY KEY (nutr_no);


--
-- Name: offers offers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY offers
    ADD CONSTRAINT offers_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: source_codes source_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY source_codes
    ADD CONSTRAINT source_codes_pkey PRIMARY KEY (source_code);


--
-- Name: sources_of_data_assoc sources_of_data_assoc_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sources_of_data_assoc
    ADD CONSTRAINT sources_of_data_assoc_pkey PRIMARY KEY (ndb_no, nutr_no, datasource_id);


--
-- Name: sources_of_data sources_of_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sources_of_data
    ADD CONSTRAINT sources_of_data_pkey PRIMARY KEY (datasource_id);


--
-- Name: stock_distributions stock_distributions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_distributions
    ADD CONSTRAINT stock_distributions_pkey PRIMARY KEY (id);


--
-- Name: stocks stocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stocks
    ADD CONSTRAINT stocks_pkey PRIMARY KEY (id);


--
-- Name: user_credits user_credits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_credits
    ADD CONSTRAINT user_credits_pkey PRIMARY KEY (id);


--
-- Name: user_orders user_food_packages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_orders
    ADD CONSTRAINT user_food_packages_pkey PRIMARY KEY (id);


--
-- Name: user_languages user_languages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_languages
    ADD CONSTRAINT user_languages_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: weights weights_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY weights
    ADD CONSTRAINT weights_pkey PRIMARY KEY (ndb_no, seq);


--
-- Name: credit_type_memberships_credit_type_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX credit_type_memberships_credit_type_id_index ON credit_type_memberships USING btree (credit_type_id);


--
-- Name: credit_type_memberships_food_group_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX credit_type_memberships_food_group_id_index ON credit_type_memberships USING btree (food_group_id);


--
-- Name: languages_iso_code_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX languages_iso_code_index ON languages USING btree (iso_code);


--
-- Name: stocks_facility_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stocks_facility_id_index ON stocks USING btree (facility_id);


--
-- Name: stocks_food_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX stocks_food_id_index ON stocks USING btree (food_id);


--
-- Name: unique_stock_per_package; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_stock_per_package ON stock_distributions USING btree (user_order_id, stock_id);


--
-- Name: user_credits_user_id_credit_type_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_credits_user_id_credit_type_id_index ON user_credits USING btree (user_id, credit_type_id);


--
-- Name: user_food_packages_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_food_packages_user_id_index ON user_orders USING btree (user_id);


--
-- Name: user_languages_language_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_languages_language_id_index ON user_languages USING btree (language_id);


--
-- Name: user_languages_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_languages_user_id_index ON user_languages USING btree (user_id);


--
-- Name: users_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX users_email_index ON users USING btree (email);


--
-- Name: users_facility_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX users_facility_id_index ON users USING btree (facility_id);


--
-- Name: credit_type_memberships credit_type_memberships_credit_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY credit_type_memberships
    ADD CONSTRAINT credit_type_memberships_credit_type_id_fkey FOREIGN KEY (credit_type_id) REFERENCES credit_types(id);


--
-- Name: credit_type_memberships credit_type_memberships_food_group_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY credit_type_memberships
    ADD CONSTRAINT credit_type_memberships_food_group_id_fkey FOREIGN KEY (food_group_id) REFERENCES food_groups(foodgroup_code);


--
-- Name: foods foods_foodgroup_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY foods
    ADD CONSTRAINT foods_foodgroup_code_fkey FOREIGN KEY (foodgroup_code) REFERENCES food_groups(foodgroup_code);


--
-- Name: footnotes footnotes_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY footnotes
    ADD CONSTRAINT footnotes_ndb_no_fkey FOREIGN KEY (ndb_no) REFERENCES foods(ndb_no);


--
-- Name: footnotes footnotes_nutr_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY footnotes
    ADD CONSTRAINT footnotes_nutr_no_fkey FOREIGN KEY (nutr_no) REFERENCES nutrients(nutr_no);


--
-- Name: langua_l_factors langua_l_factors_factor_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY langua_l_factors
    ADD CONSTRAINT langua_l_factors_factor_code_fkey FOREIGN KEY (factor_code) REFERENCES langua_l_desc(factor_code);


--
-- Name: langua_l_factors langua_l_factors_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY langua_l_factors
    ADD CONSTRAINT langua_l_factors_ndb_no_fkey FOREIGN KEY (ndb_no) REFERENCES foods(ndb_no);


--
-- Name: nutrient_data nutrient_data_derivation_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nutrient_data
    ADD CONSTRAINT nutrient_data_derivation_code_fkey FOREIGN KEY (derivation_code) REFERENCES data_derivation_codes(derivation_code);


--
-- Name: nutrient_data nutrient_data_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nutrient_data
    ADD CONSTRAINT nutrient_data_ndb_no_fkey FOREIGN KEY (ndb_no) REFERENCES foods(ndb_no);


--
-- Name: nutrient_data nutrient_data_nutr_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nutrient_data
    ADD CONSTRAINT nutrient_data_nutr_no_fkey FOREIGN KEY (nutr_no) REFERENCES nutrients(nutr_no);


--
-- Name: nutrient_data nutrient_data_ref_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nutrient_data
    ADD CONSTRAINT nutrient_data_ref_ndb_no_fkey FOREIGN KEY (ref_ndb_no) REFERENCES foods(ndb_no);


--
-- Name: nutrient_data nutrient_data_source_code_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY nutrient_data
    ADD CONSTRAINT nutrient_data_source_code_fkey FOREIGN KEY (source_code) REFERENCES source_codes(source_code);


--
-- Name: sources_of_data_assoc sources_of_data_assoc_datasource_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sources_of_data_assoc
    ADD CONSTRAINT sources_of_data_assoc_datasource_id_fkey FOREIGN KEY (datasource_id) REFERENCES sources_of_data(datasource_id);


--
-- Name: sources_of_data_assoc sources_of_data_assoc_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sources_of_data_assoc
    ADD CONSTRAINT sources_of_data_assoc_ndb_no_fkey FOREIGN KEY (ndb_no) REFERENCES foods(ndb_no);


--
-- Name: sources_of_data_assoc sources_of_data_assoc_nutr_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY sources_of_data_assoc
    ADD CONSTRAINT sources_of_data_assoc_nutr_no_fkey FOREIGN KEY (nutr_no) REFERENCES nutrients(nutr_no);


--
-- Name: stock_distributions stock_distributions_stock_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_distributions
    ADD CONSTRAINT stock_distributions_stock_id_fkey FOREIGN KEY (stock_id) REFERENCES stocks(id);


--
-- Name: stock_distributions stock_distributions_user_food_package_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stock_distributions
    ADD CONSTRAINT stock_distributions_user_food_package_id_fkey FOREIGN KEY (user_order_id) REFERENCES user_orders(id);


--
-- Name: stocks stocks_food_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stocks
    ADD CONSTRAINT stocks_food_id_fkey FOREIGN KEY (food_id) REFERENCES foods(ndb_no);


--
-- Name: stocks stocks_meal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stocks
    ADD CONSTRAINT stocks_meal_id_fkey FOREIGN KEY (meal_id) REFERENCES meals(id);


--
-- Name: stocks stocks_offer_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY stocks
    ADD CONSTRAINT stocks_offer_id_fkey FOREIGN KEY (offer_id) REFERENCES offers(id);


--
-- Name: user_credits user_credits_credit_type_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_credits
    ADD CONSTRAINT user_credits_credit_type_id_fkey FOREIGN KEY (credit_type_id) REFERENCES credit_types(id);


--
-- Name: user_credits user_credits_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_credits
    ADD CONSTRAINT user_credits_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: user_orders user_food_packages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_orders
    ADD CONSTRAINT user_food_packages_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: user_languages user_languages_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_languages
    ADD CONSTRAINT user_languages_language_id_fkey FOREIGN KEY (language_id) REFERENCES languages(id);


--
-- Name: user_languages user_languages_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_languages
    ADD CONSTRAINT user_languages_user_id_fkey FOREIGN KEY (user_id) REFERENCES users(id);


--
-- Name: users users_primary_language_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_primary_language_id_fkey FOREIGN KEY (primary_language_id) REFERENCES languages(id);


--
-- Name: weights weights_ndb_no_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY weights
    ADD CONSTRAINT weights_ndb_no_fkey FOREIGN KEY (ndb_no) REFERENCES foods(ndb_no);


--
-- PostgreSQL database dump complete
--

INSERT INTO "schema_migrations" (version) VALUES (20170202181624), (20170204204738), (20170204210449), (20170204212907), (20170204224749), (20170204224750), (20170204224751), (20170205004943), (20170205034828), (20170205035044), (20170207020101), (20170207034754), (20170214132510), (20170214132726), (20170214150520), (20170215134613), (20170220183746), (20170221050436), (20170221155354), (20170225201405), (20170227040522), (20170302235101);

