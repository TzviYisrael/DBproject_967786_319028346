--
-- PostgreSQL database dump
--


-- Dumped from database version 18.3 (Debian 18.3-1.pgdg13+1)
-- Dumped by pg_dump version 18.3 (Debian 18.3-1.pgdg13+1)

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
-- Name: coach; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coach (
    coachid integer NOT NULL,
    coachname character varying(50),
    gender character varying(10),
    birthday date,
    prodate date
);


ALTER TABLE public.coach OWNER TO betmaster_user;

--
-- Name: coachedby; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.coachedby (
    coachid integer NOT NULL,
    teamid integer NOT NULL,
    startdate date,
    salary numeric(10,2)
);


ALTER TABLE public.coachedby OWNER TO betmaster_user;

--
-- Name: gkmatchstats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gkmatchstats (
    playerid integer NOT NULL,
    matchid integer NOT NULL,
    saves integer,
    goalsconceded integer,
    yellowcard integer,
    redcard integer
);


ALTER TABLE public.gkmatchstats OWNER TO betmaster_user;

--
-- Name: goalkeeper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.goalkeeper (
    playerid integer NOT NULL,
    glovesnumber integer
);


ALTER TABLE public.goalkeeper OWNER TO betmaster_user;

--
-- Name: match; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.match (
    matchid integer NOT NULL,
    matchdate date,
    stage character varying(50)
);


ALTER TABLE public.match OWNER TO betmaster_user;

--
-- Name: matchstadium; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.matchstadium (
    matchid integer NOT NULL,
    stadiumid integer,
    attendees integer
);


ALTER TABLE public.matchstadium OWNER TO betmaster_user;

--
-- Name: matchteam; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.matchteam (
    matchid integer NOT NULL,
    teamid integer NOT NULL,
    role character varying(10),
    score integer,
    winloss character varying(10),
    CONSTRAINT matchteam_role_check CHECK (((role)::text = ANY ((ARRAY['Home'::character varying, 'Away'::character varying])::text[])))
);


ALTER TABLE public.matchteam OWNER TO betmaster_user;

--
-- Name: player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.player (
    playerid integer NOT NULL,
    playername character varying(50),
    birthdate date,
    "position" character varying(30),
    height integer,
    strongleg character varying(10),
    nativecountry character varying(50),
    CONSTRAINT player_strongleg_check CHECK (((strongleg)::text = ANY ((ARRAY['Left'::character varying, 'Right'::character varying])::text[])))
);


ALTER TABLE public.player OWNER TO betmaster_user;

--
-- Name: playermatchstats; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playermatchstats (
    playerid integer NOT NULL,
    matchid integer NOT NULL,
    goals integer,
    assists integer,
    passcompleted integer,
    passattempts integer,
    tackles integer,
    yellowcard integer,
    redcard integer
);


ALTER TABLE public.playermatchstats OWNER TO betmaster_user;

--
-- Name: playsfor_gk; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playsfor_gk (
    playerid integer NOT NULL,
    teamid integer NOT NULL,
    startdate date,
    salary numeric(10,2)
);


ALTER TABLE public.playsfor_gk OWNER TO betmaster_user;

--
-- Name: playsfor_player; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.playsfor_player (
    playerid integer NOT NULL,
    teamid integer NOT NULL,
    startdate date,
    salary numeric(10,2),
    CONSTRAINT check_salary CHECK ((salary >= (5000)::numeric))
);


ALTER TABLE public.playsfor_player OWNER TO betmaster_user;

--
-- Name: referee; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.referee (
    refereeid integer NOT NULL,
    refereename character varying(50),
    gender character varying(10),
    birthday date,
    prodate date
);


ALTER TABLE public.referee OWNER TO betmaster_user;

--
-- Name: refereeat; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.refereeat (
    matchid integer NOT NULL,
    refereeid integer NOT NULL
);


ALTER TABLE public.refereeat OWNER TO betmaster_user;

--
-- Name: stadium; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.stadium (
    stadiumid integer NOT NULL,
    stadiumname character varying(50),
    city character varying(50),
    capacity integer,
    yearfounded integer,
    CONSTRAINT check_capacity CHECK ((capacity > 0))
);


ALTER TABLE public.stadium OWNER TO betmaster_user;

--
-- Name: team; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.team (
    teamid integer NOT NULL,
    teamname character varying(50) NOT NULL,
    country character varying(50),
    yearfounded integer,
    CONSTRAINT check_year CHECK (((yearfounded)::numeric <= EXTRACT(year FROM CURRENT_DATE))),
    CONSTRAINT team_yearfounded_check CHECK ((yearfounded > 1800))
);


ALTER TABLE public.team OWNER TO betmaster_user;

--
-- Data for Name: coach; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coach (coachid, coachname, gender, birthday, prodate) FROM stdin;
1	Jurgen Klopp 1	Male	1970-01-01	2005-01-01
2	Carlo Ancelotti 2	Male	1970-01-01	2005-01-01
3	Zinedine Zidane 3	Male	1970-01-01	2005-01-01
4	Jose Mourinho 4	Male	1970-01-01	2005-01-01
5	Diego Simeone 5	Male	1970-01-01	2005-01-01
6	Lionel Scaloni 6	Male	1970-01-01	2005-01-01
7	Thomas Tuchel 7	Male	1970-01-01	2005-01-01
8	Erik ten Hag 8	Male	1970-01-01	2005-01-01
9	Xavi Hernandez 9	Male	1970-01-01	2005-01-01
10	Unai Emery 10	Male	1970-01-01	2005-01-01
11	Mikel Arteta 11	Male	1970-01-01	2005-01-01
12	Luis Enrique 12	Male	1970-01-01	2005-01-01
13	Roberto De Zerbi 13	Male	1970-01-01	2005-01-01
14	Ange Postecoglou 14	Male	1970-01-01	2005-01-01
15	Simone Inzaghi 15	Male	1970-01-01	2005-01-01
16	Stefano Pioli 16	Male	1970-01-01	2005-01-01
17	Massimiliano Allegri 17	Male	1970-01-01	2005-01-01
18	Julian Nagelsmann 18	Male	1970-01-01	2005-01-01
19	Hansi Flick 19	Male	1970-01-01	2005-01-01
20	Pep Guardiola 20	Male	1970-01-01	2005-01-01
21	Jurgen Klopp 21	Male	1970-01-01	2005-01-01
22	Carlo Ancelotti 22	Male	1970-01-01	2005-01-01
23	Zinedine Zidane 23	Male	1970-01-01	2005-01-01
24	Jose Mourinho 24	Male	1970-01-01	2005-01-01
25	Diego Simeone 25	Male	1970-01-01	2005-01-01
26	Lionel Scaloni 26	Male	1970-01-01	2005-01-01
27	Thomas Tuchel 27	Male	1970-01-01	2005-01-01
28	Erik ten Hag 28	Male	1970-01-01	2005-01-01
29	Xavi Hernandez 29	Male	1970-01-01	2005-01-01
30	Unai Emery 30	Male	1970-01-01	2005-01-01
31	Mikel Arteta 31	Male	1970-01-01	2005-01-01
32	Luis Enrique 32	Male	1970-01-01	2005-01-01
33	Roberto De Zerbi 33	Male	1970-01-01	2005-01-01
34	Ange Postecoglou 34	Male	1970-01-01	2005-01-01
35	Simone Inzaghi 35	Male	1970-01-01	2005-01-01
36	Stefano Pioli 36	Male	1970-01-01	2005-01-01
37	Massimiliano Allegri 37	Male	1970-01-01	2005-01-01
38	Julian Nagelsmann 38	Male	1970-01-01	2005-01-01
39	Hansi Flick 39	Male	1970-01-01	2005-01-01
40	Pep Guardiola 40	Male	1970-01-01	2005-01-01
41	Jurgen Klopp 41	Male	1970-01-01	2005-01-01
42	Carlo Ancelotti 42	Male	1970-01-01	2005-01-01
43	Zinedine Zidane 43	Male	1970-01-01	2005-01-01
44	Jose Mourinho 44	Male	1970-01-01	2005-01-01
45	Diego Simeone 45	Male	1970-01-01	2005-01-01
46	Lionel Scaloni 46	Male	1970-01-01	2005-01-01
47	Thomas Tuchel 47	Male	1970-01-01	2005-01-01
48	Erik ten Hag 48	Male	1970-01-01	2005-01-01
49	Xavi Hernandez 49	Male	1970-01-01	2005-01-01
50	Unai Emery 50	Male	1970-01-01	2005-01-01
51	Mikel Arteta 51	Male	1970-01-01	2005-01-01
52	Luis Enrique 52	Male	1970-01-01	2005-01-01
53	Roberto De Zerbi 53	Male	1970-01-01	2005-01-01
54	Ange Postecoglou 54	Male	1970-01-01	2005-01-01
55	Simone Inzaghi 55	Male	1970-01-01	2005-01-01
56	Stefano Pioli 56	Male	1970-01-01	2005-01-01
57	Massimiliano Allegri 57	Male	1970-01-01	2005-01-01
58	Julian Nagelsmann 58	Male	1970-01-01	2005-01-01
59	Hansi Flick 59	Male	1970-01-01	2005-01-01
60	Pep Guardiola 60	Male	1970-01-01	2005-01-01
61	Jurgen Klopp 61	Male	1970-01-01	2005-01-01
62	Carlo Ancelotti 62	Male	1970-01-01	2005-01-01
63	Zinedine Zidane 63	Male	1970-01-01	2005-01-01
64	Jose Mourinho 64	Male	1970-01-01	2005-01-01
65	Diego Simeone 65	Male	1970-01-01	2005-01-01
66	Lionel Scaloni 66	Male	1970-01-01	2005-01-01
67	Thomas Tuchel 67	Male	1970-01-01	2005-01-01
68	Erik ten Hag 68	Male	1970-01-01	2005-01-01
69	Xavi Hernandez 69	Male	1970-01-01	2005-01-01
70	Unai Emery 70	Male	1970-01-01	2005-01-01
71	Mikel Arteta 71	Male	1970-01-01	2005-01-01
72	Luis Enrique 72	Male	1970-01-01	2005-01-01
73	Roberto De Zerbi 73	Male	1970-01-01	2005-01-01
74	Ange Postecoglou 74	Male	1970-01-01	2005-01-01
75	Simone Inzaghi 75	Male	1970-01-01	2005-01-01
76	Stefano Pioli 76	Male	1970-01-01	2005-01-01
77	Massimiliano Allegri 77	Male	1970-01-01	2005-01-01
78	Julian Nagelsmann 78	Male	1970-01-01	2005-01-01
79	Hansi Flick 79	Male	1970-01-01	2005-01-01
80	Pep Guardiola 80	Male	1970-01-01	2005-01-01
81	Jurgen Klopp 81	Male	1970-01-01	2005-01-01
82	Carlo Ancelotti 82	Male	1970-01-01	2005-01-01
83	Zinedine Zidane 83	Male	1970-01-01	2005-01-01
84	Jose Mourinho 84	Male	1970-01-01	2005-01-01
85	Diego Simeone 85	Male	1970-01-01	2005-01-01
86	Lionel Scaloni 86	Male	1970-01-01	2005-01-01
87	Thomas Tuchel 87	Male	1970-01-01	2005-01-01
88	Erik ten Hag 88	Male	1970-01-01	2005-01-01
89	Xavi Hernandez 89	Male	1970-01-01	2005-01-01
90	Unai Emery 90	Male	1970-01-01	2005-01-01
91	Mikel Arteta 91	Male	1970-01-01	2005-01-01
92	Luis Enrique 92	Male	1970-01-01	2005-01-01
93	Roberto De Zerbi 93	Male	1970-01-01	2005-01-01
94	Ange Postecoglou 94	Male	1970-01-01	2005-01-01
95	Simone Inzaghi 95	Male	1970-01-01	2005-01-01
96	Stefano Pioli 96	Male	1970-01-01	2005-01-01
97	Massimiliano Allegri 97	Male	1970-01-01	2005-01-01
98	Julian Nagelsmann 98	Male	1970-01-01	2005-01-01
99	Hansi Flick 99	Male	1970-01-01	2005-01-01
100	Pep Guardiola 100	Male	1970-01-01	2005-01-01
\.


--
-- Data for Name: coachedby; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.coachedby (coachid, teamid, startdate, salary) FROM stdin;
1	1	2023-01-01	192457.00
2	2	2023-01-01	280584.00
3	3	2023-01-01	260289.00
4	4	2023-01-01	201755.00
5	5	2023-01-01	258163.00
6	6	2023-01-01	475925.00
7	7	2023-01-01	411890.00
8	8	2023-01-01	125100.00
9	9	2023-01-01	346361.00
10	10	2023-01-01	469735.00
11	11	2023-01-01	140597.00
12	12	2023-01-01	178555.00
13	13	2023-01-01	415677.00
14	14	2023-01-01	145896.00
15	15	2023-01-01	470543.00
16	16	2023-01-01	240018.00
17	17	2023-01-01	354069.00
18	18	2023-01-01	325749.00
19	19	2023-01-01	362485.00
20	20	2023-01-01	353873.00
21	21	2023-01-01	212337.00
22	22	2023-01-01	445285.00
23	23	2023-01-01	330864.00
24	24	2023-01-01	398844.00
25	25	2023-01-01	143617.00
26	26	2023-01-01	444386.00
27	27	2023-01-01	345952.00
28	28	2023-01-01	388606.00
29	29	2023-01-01	123746.00
30	30	2023-01-01	260933.00
31	31	2023-01-01	149345.00
32	32	2023-01-01	484365.00
33	33	2023-01-01	366225.00
34	34	2023-01-01	188911.00
35	35	2023-01-01	197845.00
36	36	2023-01-01	217506.00
37	37	2023-01-01	467796.00
38	38	2023-01-01	121341.00
39	39	2023-01-01	261760.00
40	40	2023-01-01	362006.00
41	41	2023-01-01	335980.00
42	42	2023-01-01	453264.00
43	43	2023-01-01	249937.00
44	44	2023-01-01	367616.00
45	45	2023-01-01	282691.00
46	46	2023-01-01	107049.00
47	47	2023-01-01	210860.00
48	48	2023-01-01	234813.00
49	49	2023-01-01	346637.00
50	50	2023-01-01	247735.00
51	51	2023-01-01	275760.00
52	52	2023-01-01	104541.00
53	53	2023-01-01	348456.00
54	54	2023-01-01	426114.00
55	55	2023-01-01	205125.00
56	56	2023-01-01	427601.00
57	57	2023-01-01	492064.00
58	58	2023-01-01	173557.00
59	59	2023-01-01	457011.00
60	60	2023-01-01	480405.00
61	61	2023-01-01	101000.00
62	62	2023-01-01	278892.00
63	63	2023-01-01	296431.00
64	64	2023-01-01	475752.00
65	65	2023-01-01	457183.00
66	66	2023-01-01	258386.00
67	67	2023-01-01	150026.00
68	68	2023-01-01	117198.00
69	69	2023-01-01	339969.00
70	70	2023-01-01	228590.00
71	71	2023-01-01	320715.00
72	72	2023-01-01	175952.00
73	73	2023-01-01	139691.00
74	74	2023-01-01	124306.00
75	75	2023-01-01	142685.00
76	76	2023-01-01	109428.00
77	77	2023-01-01	376949.00
78	78	2023-01-01	329422.00
79	79	2023-01-01	307518.00
80	80	2023-01-01	321003.00
81	81	2023-01-01	336020.00
82	82	2023-01-01	396850.00
83	83	2023-01-01	401338.00
84	84	2023-01-01	240280.00
85	85	2023-01-01	416878.00
86	86	2023-01-01	480841.00
87	87	2023-01-01	329044.00
88	88	2023-01-01	255085.00
89	89	2023-01-01	460602.00
90	90	2023-01-01	145763.00
91	91	2023-01-01	407747.00
92	92	2023-01-01	257973.00
93	93	2023-01-01	390512.00
94	94	2023-01-01	220591.00
95	95	2023-01-01	275146.00
96	96	2023-01-01	480226.00
97	97	2023-01-01	242887.00
98	98	2023-01-01	238586.00
99	99	2023-01-01	264158.00
100	100	2023-01-01	237767.00
\.


--
-- Data for Name: gkmatchstats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.gkmatchstats (playerid, matchid, saves, goalsconceded, yellowcard, redcard) FROM stdin;
\.


--
-- Data for Name: goalkeeper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.goalkeeper (playerid, glovesnumber) FROM stdin;
\.


--
-- Data for Name: match; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.match (matchid, matchdate, stage) FROM stdin;
1	2023-08-14	Group Stage
2	2023-01-11	Group Stage
3	2023-10-08	Group Stage
4	2023-03-22	Group Stage
5	2023-06-03	Group Stage
6	2023-10-13	Group Stage
7	2023-03-31	Group Stage
8	2023-06-26	Group Stage
9	2023-01-13	Group Stage
10	2023-03-12	Group Stage
11	2023-01-12	Group Stage
12	2023-07-23	Group Stage
13	2023-10-23	Group Stage
14	2023-01-07	Group Stage
15	2023-10-05	Group Stage
16	2023-10-24	Group Stage
17	2023-04-29	Group Stage
18	2023-06-01	Group Stage
19	2023-09-21	Group Stage
20	2023-07-30	Group Stage
21	2023-10-09	Group Stage
22	2023-08-13	Group Stage
23	2023-10-21	Group Stage
24	2023-06-26	Group Stage
25	2023-09-07	Group Stage
26	2023-05-16	Group Stage
27	2023-01-27	Group Stage
28	2023-07-14	Group Stage
29	2023-08-09	Group Stage
30	2023-10-28	Group Stage
31	2023-09-23	Group Stage
32	2023-10-11	Group Stage
33	2023-10-09	Group Stage
34	2023-05-28	Group Stage
35	2023-01-06	Group Stage
36	2023-05-19	Group Stage
37	2023-01-15	Group Stage
38	2023-09-30	Group Stage
39	2023-08-30	Group Stage
40	2023-10-24	Group Stage
41	2023-04-27	Group Stage
42	2023-02-05	Group Stage
43	2023-03-13	Group Stage
44	2023-08-30	Group Stage
45	2023-06-28	Group Stage
46	2023-04-03	Group Stage
47	2023-08-25	Group Stage
48	2023-04-22	Group Stage
49	2023-10-27	Group Stage
50	2023-04-21	Group Stage
51	2023-10-15	Group Stage
52	2023-05-05	Group Stage
53	2023-03-27	Group Stage
54	2023-04-06	Group Stage
55	2023-03-14	Group Stage
56	2023-05-28	Group Stage
57	2023-05-13	Group Stage
58	2023-05-08	Group Stage
59	2023-02-20	Group Stage
60	2023-07-08	Group Stage
61	2023-10-07	Group Stage
62	2023-04-04	Group Stage
63	2023-03-26	Group Stage
64	2023-05-01	Group Stage
65	2023-09-01	Group Stage
66	2023-08-02	Group Stage
67	2023-05-29	Group Stage
68	2023-01-03	Group Stage
69	2023-07-27	Group Stage
70	2023-05-28	Group Stage
71	2023-09-07	Group Stage
72	2023-04-25	Group Stage
73	2023-01-27	Group Stage
74	2023-09-05	Group Stage
75	2023-02-07	Group Stage
76	2023-02-22	Group Stage
77	2023-08-10	Group Stage
78	2023-06-12	Group Stage
79	2023-02-11	Group Stage
80	2023-09-10	Group Stage
81	2023-06-26	Group Stage
82	2023-10-07	Group Stage
83	2023-01-29	Group Stage
84	2023-07-21	Group Stage
85	2023-10-16	Group Stage
86	2023-01-24	Group Stage
87	2023-02-08	Group Stage
88	2023-06-04	Group Stage
89	2023-04-03	Group Stage
90	2023-01-19	Group Stage
91	2023-04-16	Group Stage
92	2023-03-30	Group Stage
93	2023-10-01	Group Stage
94	2023-06-23	Group Stage
95	2023-04-09	Group Stage
96	2023-08-04	Group Stage
97	2023-02-28	Group Stage
98	2023-03-30	Group Stage
99	2023-06-15	Group Stage
100	2023-07-30	Group Stage
101	2023-09-17	Group Stage
102	2023-06-11	Group Stage
103	2023-09-13	Group Stage
104	2023-07-31	Group Stage
105	2023-06-25	Group Stage
106	2023-09-05	Group Stage
107	2023-10-08	Group Stage
108	2023-05-25	Group Stage
109	2023-07-02	Group Stage
110	2023-03-01	Group Stage
111	2023-10-19	Group Stage
112	2023-04-05	Group Stage
113	2023-09-18	Group Stage
114	2023-04-24	Group Stage
115	2023-02-26	Group Stage
116	2023-10-05	Group Stage
117	2023-01-18	Group Stage
118	2023-08-19	Group Stage
119	2023-05-28	Group Stage
120	2023-04-05	Group Stage
121	2023-09-26	Group Stage
122	2023-08-13	Group Stage
123	2023-05-28	Group Stage
124	2023-01-19	Group Stage
125	2023-01-04	Group Stage
126	2023-07-24	Group Stage
127	2023-10-28	Group Stage
128	2023-09-27	Group Stage
129	2023-01-20	Group Stage
130	2023-02-24	Group Stage
131	2023-05-22	Group Stage
132	2023-03-26	Group Stage
133	2023-07-04	Group Stage
134	2023-07-16	Group Stage
135	2023-09-25	Group Stage
136	2023-03-22	Group Stage
137	2023-10-20	Group Stage
138	2023-04-21	Group Stage
139	2023-07-12	Group Stage
140	2023-02-07	Group Stage
141	2023-04-03	Group Stage
142	2023-07-20	Group Stage
143	2023-10-16	Group Stage
144	2023-10-28	Group Stage
145	2023-05-05	Group Stage
146	2023-01-25	Group Stage
147	2023-05-26	Group Stage
148	2023-10-05	Group Stage
149	2023-06-13	Group Stage
150	2023-01-11	Group Stage
151	2023-07-14	Group Stage
152	2023-01-26	Group Stage
153	2023-02-25	Group Stage
154	2023-09-05	Group Stage
155	2023-05-19	Group Stage
156	2023-09-19	Group Stage
157	2023-10-28	Group Stage
158	2023-01-27	Group Stage
159	2023-08-28	Group Stage
160	2023-02-13	Group Stage
161	2023-06-13	Group Stage
162	2023-01-31	Group Stage
163	2023-09-24	Group Stage
164	2023-09-18	Group Stage
165	2023-03-13	Group Stage
166	2023-08-04	Group Stage
167	2023-02-28	Group Stage
168	2023-08-22	Group Stage
169	2023-09-16	Group Stage
170	2023-05-05	Group Stage
171	2023-05-07	Group Stage
172	2023-10-14	Group Stage
173	2023-09-01	Group Stage
174	2023-09-02	Group Stage
175	2023-07-27	Group Stage
176	2023-01-03	Group Stage
177	2023-09-15	Group Stage
178	2023-07-12	Group Stage
179	2023-04-26	Group Stage
180	2023-07-04	Group Stage
181	2023-04-29	Group Stage
182	2023-07-23	Group Stage
183	2023-09-22	Group Stage
184	2023-04-30	Group Stage
185	2023-07-26	Group Stage
186	2023-07-20	Group Stage
187	2023-03-04	Group Stage
188	2023-04-09	Group Stage
189	2023-08-13	Group Stage
190	2023-09-01	Group Stage
191	2023-02-23	Group Stage
192	2023-07-13	Group Stage
193	2023-08-30	Group Stage
194	2023-07-20	Group Stage
195	2023-01-08	Group Stage
196	2023-02-12	Group Stage
197	2023-07-14	Group Stage
198	2023-02-16	Group Stage
199	2023-06-16	Group Stage
200	2023-03-18	Group Stage
201	2023-09-24	Group Stage
202	2023-02-12	Group Stage
203	2023-07-15	Group Stage
204	2023-08-04	Group Stage
205	2023-09-09	Group Stage
206	2023-02-23	Group Stage
207	2023-05-17	Group Stage
208	2023-02-23	Group Stage
209	2023-06-03	Group Stage
210	2023-09-21	Group Stage
211	2023-08-09	Group Stage
212	2023-01-09	Group Stage
213	2023-06-04	Group Stage
214	2023-09-11	Group Stage
215	2023-06-18	Group Stage
216	2023-02-11	Group Stage
217	2023-01-04	Group Stage
218	2023-10-28	Group Stage
219	2023-06-22	Group Stage
220	2023-07-09	Group Stage
221	2023-02-13	Group Stage
222	2023-06-01	Group Stage
223	2023-09-16	Group Stage
224	2023-01-24	Group Stage
225	2023-07-07	Group Stage
226	2023-04-22	Group Stage
227	2023-07-09	Group Stage
228	2023-06-03	Group Stage
229	2023-03-17	Group Stage
230	2023-08-04	Group Stage
231	2023-02-22	Group Stage
232	2023-03-25	Group Stage
233	2023-08-14	Group Stage
234	2023-05-07	Group Stage
235	2023-02-08	Group Stage
236	2023-04-22	Group Stage
237	2023-09-18	Group Stage
238	2023-10-10	Group Stage
239	2023-08-10	Group Stage
240	2023-09-25	Group Stage
241	2023-08-19	Group Stage
242	2023-10-18	Group Stage
243	2023-03-10	Group Stage
244	2023-05-01	Group Stage
245	2023-06-03	Group Stage
246	2023-09-01	Group Stage
247	2023-03-15	Group Stage
248	2023-04-16	Group Stage
249	2023-09-21	Group Stage
250	2023-07-12	Group Stage
251	2023-08-23	Group Stage
252	2023-02-13	Group Stage
253	2023-04-09	Group Stage
254	2023-07-29	Group Stage
255	2023-07-29	Group Stage
256	2023-06-13	Group Stage
257	2023-05-20	Group Stage
258	2023-06-25	Group Stage
259	2023-06-18	Group Stage
260	2023-03-09	Group Stage
261	2023-03-23	Group Stage
262	2023-01-11	Group Stage
263	2023-10-16	Group Stage
264	2023-10-12	Group Stage
265	2023-03-11	Group Stage
266	2023-06-26	Group Stage
267	2023-02-06	Group Stage
268	2023-04-02	Group Stage
269	2023-05-22	Group Stage
270	2023-04-11	Group Stage
271	2023-02-24	Group Stage
272	2023-06-10	Group Stage
273	2023-01-14	Group Stage
274	2023-07-30	Group Stage
275	2023-01-07	Group Stage
276	2023-02-15	Group Stage
277	2023-07-03	Group Stage
278	2023-02-19	Group Stage
279	2023-05-28	Group Stage
280	2023-03-09	Group Stage
281	2023-06-25	Group Stage
282	2023-09-24	Group Stage
283	2023-05-05	Group Stage
284	2023-08-29	Group Stage
285	2023-05-20	Group Stage
286	2023-02-01	Group Stage
287	2023-01-14	Group Stage
288	2023-06-01	Group Stage
289	2023-01-02	Group Stage
290	2023-06-12	Group Stage
291	2023-04-08	Group Stage
292	2023-08-19	Group Stage
293	2023-07-08	Group Stage
294	2023-07-03	Group Stage
295	2023-04-08	Group Stage
296	2023-01-13	Group Stage
297	2023-02-22	Group Stage
298	2023-07-04	Group Stage
299	2023-04-19	Group Stage
300	2023-04-18	Group Stage
301	2023-05-14	Group Stage
302	2023-09-25	Group Stage
303	2023-08-25	Group Stage
304	2023-04-16	Group Stage
305	2023-08-13	Group Stage
306	2023-07-17	Group Stage
307	2023-05-28	Group Stage
308	2023-09-11	Group Stage
309	2023-03-31	Group Stage
310	2023-02-23	Group Stage
311	2023-02-07	Group Stage
312	2023-01-02	Group Stage
313	2023-08-13	Group Stage
314	2023-05-28	Group Stage
315	2023-08-27	Group Stage
316	2023-08-07	Group Stage
317	2023-02-26	Group Stage
318	2023-07-09	Group Stage
319	2023-07-03	Group Stage
320	2023-10-23	Group Stage
321	2023-04-20	Group Stage
322	2023-10-09	Group Stage
323	2023-01-24	Group Stage
324	2023-10-27	Group Stage
325	2023-07-28	Group Stage
326	2023-03-07	Group Stage
327	2023-05-21	Group Stage
328	2023-04-28	Group Stage
329	2023-05-30	Group Stage
330	2023-05-09	Group Stage
331	2023-02-05	Group Stage
332	2023-07-06	Group Stage
333	2023-06-21	Group Stage
334	2023-01-27	Group Stage
335	2023-10-20	Group Stage
336	2023-01-05	Group Stage
337	2023-03-06	Group Stage
338	2023-07-28	Group Stage
339	2023-02-22	Group Stage
340	2023-05-25	Group Stage
341	2023-08-17	Group Stage
342	2023-07-29	Group Stage
343	2023-03-15	Group Stage
344	2023-10-21	Group Stage
345	2023-05-19	Group Stage
346	2023-04-26	Group Stage
347	2023-01-26	Group Stage
348	2023-03-06	Group Stage
349	2023-01-16	Group Stage
350	2023-03-20	Group Stage
351	2023-10-05	Group Stage
352	2023-07-22	Group Stage
353	2023-03-24	Group Stage
354	2023-04-06	Group Stage
355	2023-04-10	Group Stage
356	2023-03-31	Group Stage
357	2023-08-18	Group Stage
358	2023-05-23	Group Stage
359	2023-03-15	Group Stage
360	2023-04-27	Group Stage
361	2023-02-19	Group Stage
362	2023-08-30	Group Stage
363	2023-06-12	Group Stage
364	2023-10-27	Group Stage
365	2023-05-11	Group Stage
366	2023-03-09	Group Stage
367	2023-02-06	Group Stage
368	2023-04-29	Group Stage
369	2023-08-22	Group Stage
370	2023-07-11	Group Stage
371	2023-10-02	Group Stage
372	2023-06-26	Group Stage
373	2023-01-07	Group Stage
374	2023-10-04	Group Stage
375	2023-09-15	Group Stage
376	2023-10-02	Group Stage
377	2023-06-22	Group Stage
378	2023-06-16	Group Stage
379	2023-02-09	Group Stage
380	2023-08-24	Group Stage
381	2023-02-03	Group Stage
382	2023-02-26	Group Stage
383	2023-03-22	Group Stage
384	2023-05-23	Group Stage
385	2023-06-04	Group Stage
386	2023-01-19	Group Stage
387	2023-04-26	Group Stage
388	2023-09-08	Group Stage
389	2023-08-03	Group Stage
390	2023-05-14	Group Stage
391	2023-06-28	Group Stage
392	2023-07-22	Group Stage
393	2023-06-26	Group Stage
394	2023-04-15	Group Stage
395	2023-09-09	Group Stage
396	2023-01-23	Group Stage
397	2023-08-08	Group Stage
398	2023-06-04	Group Stage
399	2023-02-17	Group Stage
400	2023-09-30	Group Stage
401	2023-06-26	Group Stage
402	2023-08-02	Group Stage
403	2023-05-20	Group Stage
404	2023-03-30	Group Stage
405	2023-08-03	Group Stage
406	2023-06-26	Group Stage
407	2023-06-11	Group Stage
408	2023-03-08	Group Stage
409	2023-09-19	Group Stage
410	2023-07-06	Group Stage
411	2023-07-19	Group Stage
412	2023-05-13	Group Stage
413	2023-07-05	Group Stage
414	2023-04-18	Group Stage
415	2023-05-23	Group Stage
416	2023-10-27	Group Stage
417	2023-08-07	Group Stage
418	2023-06-26	Group Stage
419	2023-10-25	Group Stage
420	2023-02-03	Group Stage
421	2023-02-27	Group Stage
422	2023-02-02	Group Stage
423	2023-06-18	Group Stage
424	2023-06-13	Group Stage
425	2023-01-20	Group Stage
426	2023-01-20	Group Stage
427	2023-01-15	Group Stage
428	2023-03-03	Group Stage
429	2023-02-25	Group Stage
430	2023-02-10	Group Stage
431	2023-06-12	Group Stage
432	2023-02-14	Group Stage
433	2023-10-26	Group Stage
434	2023-04-07	Group Stage
435	2023-07-16	Group Stage
436	2023-05-13	Group Stage
437	2023-06-22	Group Stage
438	2023-08-23	Group Stage
439	2023-09-30	Group Stage
440	2023-06-15	Group Stage
441	2023-06-17	Group Stage
442	2023-06-15	Group Stage
443	2023-10-12	Group Stage
444	2023-06-01	Group Stage
445	2023-07-16	Group Stage
446	2023-09-16	Group Stage
447	2023-05-10	Group Stage
448	2023-01-24	Group Stage
449	2023-04-27	Group Stage
450	2023-03-07	Group Stage
451	2023-01-25	Group Stage
452	2023-05-09	Group Stage
453	2023-03-21	Group Stage
454	2023-08-26	Group Stage
455	2023-06-30	Group Stage
456	2023-06-27	Group Stage
457	2023-10-20	Group Stage
458	2023-07-03	Group Stage
459	2023-01-14	Group Stage
460	2023-07-31	Group Stage
461	2023-07-23	Group Stage
462	2023-10-10	Group Stage
463	2023-02-22	Group Stage
464	2023-10-04	Group Stage
465	2023-01-27	Group Stage
466	2023-08-05	Group Stage
467	2023-04-14	Group Stage
468	2023-05-08	Group Stage
469	2023-04-04	Group Stage
470	2023-09-18	Group Stage
471	2023-08-28	Group Stage
472	2023-10-10	Group Stage
473	2023-06-12	Group Stage
474	2023-10-14	Group Stage
475	2023-10-05	Group Stage
476	2023-04-30	Group Stage
477	2023-01-12	Group Stage
478	2023-01-03	Group Stage
479	2023-06-30	Group Stage
480	2023-03-28	Group Stage
481	2023-01-23	Group Stage
482	2023-03-21	Group Stage
483	2023-02-10	Group Stage
484	2023-09-24	Group Stage
485	2023-08-12	Group Stage
486	2023-08-28	Group Stage
487	2023-01-10	Group Stage
488	2023-06-12	Group Stage
489	2023-10-03	Group Stage
490	2023-03-01	Group Stage
491	2023-04-02	Group Stage
492	2023-10-28	Group Stage
493	2023-02-06	Group Stage
494	2023-01-09	Group Stage
495	2023-09-26	Group Stage
496	2023-06-05	Group Stage
497	2023-05-02	Group Stage
498	2023-07-03	Group Stage
499	2023-02-03	Group Stage
500	2023-04-28	Group Stage
\.


--
-- Data for Name: matchstadium; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.matchstadium (matchid, stadiumid, attendees) FROM stdin;
1	2	30142
2	3	63023
3	4	76867
4	5	36093
5	6	48698
6	7	68963
7	8	36365
8	9	38188
9	10	33072
10	11	55440
11	12	40151
12	13	24874
13	14	46141
14	15	66905
15	16	47831
16	17	46006
17	18	39829
18	19	26338
19	20	71357
20	21	37062
21	22	53089
22	23	39931
23	24	53241
24	25	74548
25	26	39822
26	27	78583
27	28	21497
28	29	22080
29	30	33752
30	31	37612
31	32	24630
32	33	20424
33	34	73011
34	35	63868
35	36	42099
36	37	23673
37	38	32794
38	39	53873
39	40	37923
40	41	75492
41	42	45420
42	43	57983
43	44	45013
44	45	48686
45	46	43536
46	47	42143
47	48	37520
48	49	59139
49	50	69879
50	51	46043
51	52	67837
52	53	31363
53	54	76899
54	55	59276
55	56	48985
56	57	28116
57	58	60864
58	59	62792
59	60	22299
60	61	71670
61	62	60575
62	63	66214
63	64	27355
64	65	72841
65	66	68336
66	67	41396
67	68	52573
68	69	26825
69	70	41544
70	71	75983
71	72	32913
72	73	76285
73	74	50175
74	75	23138
75	76	50387
76	77	35946
77	78	68616
78	79	48146
79	80	77790
80	81	28160
81	82	79977
82	83	60609
83	84	47440
84	85	63137
85	86	72708
86	87	42864
87	88	74551
88	89	37422
89	90	47165
90	91	43727
91	92	77362
92	93	48315
93	94	20824
94	95	59378
95	96	62474
96	97	64321
97	98	28193
98	99	79072
99	100	30969
100	101	29385
101	102	53081
102	103	41485
103	104	30494
104	105	64956
105	106	65828
106	107	71599
107	108	76904
108	109	43018
109	110	55297
110	111	24849
111	112	52536
112	113	35185
113	114	74081
114	115	44895
115	116	63213
116	117	20895
117	118	25975
118	119	76370
119	120	68187
120	121	38353
121	122	55815
122	123	32600
123	124	50042
124	125	25885
125	126	29813
126	127	47269
127	128	28458
128	129	53300
129	130	22732
130	131	78272
131	132	71419
132	133	36105
133	134	40985
134	135	55506
135	136	37880
136	137	56471
137	138	64750
138	139	54696
139	140	31526
140	141	74604
141	142	47747
142	143	67289
143	144	65637
144	145	33211
145	146	66857
146	147	76012
147	148	34243
148	149	65067
149	150	21576
150	151	67500
151	152	65633
152	153	67308
153	154	42815
154	155	79082
155	156	76637
156	157	55336
157	158	58532
158	159	43821
159	160	35618
160	161	24531
161	162	76126
162	163	53114
163	164	70899
164	165	43444
165	166	50697
166	167	47491
167	168	63048
168	169	22305
169	170	49532
170	171	26390
171	172	56757
172	173	27720
173	174	76457
174	175	44829
175	176	62737
176	177	66267
177	178	26201
178	179	55847
179	180	29222
180	181	41401
181	182	78618
182	183	48400
183	184	76408
184	185	62953
185	186	76778
186	187	77722
187	188	46706
188	189	59395
189	190	34241
190	191	68389
191	192	23636
192	193	72736
193	194	76847
194	195	60392
195	196	45748
196	197	29188
197	198	30214
198	199	62451
199	200	79876
200	201	33720
201	202	69947
202	203	27096
203	204	43487
204	205	52632
205	206	26625
206	207	60253
207	208	28466
208	209	38547
209	210	69507
210	211	36715
211	212	63384
212	213	50096
213	214	71482
214	215	67057
215	216	67580
216	217	47981
217	218	54587
218	219	51154
219	220	27812
220	221	48650
221	222	69438
222	223	44689
223	224	74696
224	225	35265
225	226	22181
226	227	71955
227	228	49158
228	229	25485
229	230	54546
230	231	74732
231	232	39552
232	233	76322
233	234	42941
234	235	69595
235	236	28603
236	237	58668
237	238	71139
238	239	27058
239	240	23622
240	241	64735
241	242	70337
242	243	66823
243	244	56099
244	245	53846
245	246	41548
246	247	49508
247	248	40862
248	249	53278
249	250	65470
250	251	54672
251	252	75268
252	253	26193
253	254	23207
254	255	78777
255	256	27809
256	257	55896
257	258	62356
258	259	61262
259	260	46508
260	261	67283
261	262	72508
262	263	26549
263	264	59084
264	265	33831
265	266	74022
266	267	31027
267	268	48767
268	269	53237
269	270	77693
270	271	74516
271	272	75114
272	273	39351
273	274	33475
274	275	38931
275	276	51398
276	277	40577
277	278	56758
278	279	73135
279	280	40557
280	281	27899
281	282	68280
282	283	28011
283	284	30431
284	285	55519
285	286	24939
286	287	79284
287	288	33584
288	289	27783
289	290	66325
290	291	39682
291	292	37322
292	293	44658
293	294	65511
294	295	55270
295	296	25068
296	297	47899
297	298	76625
298	299	22643
299	300	37174
300	301	59958
301	302	79442
302	303	41125
303	304	48742
304	305	40667
305	306	34849
306	307	46475
307	308	33397
308	309	55653
309	310	33959
310	311	31053
311	312	60408
312	313	39892
313	314	25258
314	315	32183
315	316	42271
316	317	59441
317	318	32924
318	319	28922
319	320	48581
320	321	61249
321	322	32466
322	323	71877
323	324	66327
324	325	56904
325	326	60863
326	327	45713
327	328	79704
328	329	49366
329	330	53986
330	331	60627
331	332	74806
332	333	49003
333	334	61294
334	335	56285
335	336	76685
336	337	76457
337	338	20148
338	339	59261
339	340	34452
340	341	21125
341	342	51877
342	343	59428
343	344	69329
344	345	67761
345	346	68141
346	347	75212
347	348	40756
348	349	75320
349	350	42600
350	351	27300
351	352	32987
352	353	23980
353	354	49057
354	355	66488
355	356	34412
356	357	56236
357	358	43529
358	359	20356
359	360	72259
360	361	66196
361	362	56202
362	363	36306
363	364	63565
364	365	68535
365	366	76771
366	367	43947
367	368	36134
368	369	20848
369	370	57430
370	371	63150
371	372	22417
372	373	27074
373	374	23412
374	375	29157
375	376	68339
376	377	51697
377	378	38463
378	379	65327
379	380	60263
380	381	46311
381	382	35856
382	383	55375
383	384	46745
384	385	58693
385	386	22546
386	387	34308
387	388	25638
388	389	67435
389	390	37676
390	391	71249
391	392	35168
392	393	61466
393	394	38022
394	395	79739
395	396	20535
396	397	51257
397	398	30840
398	399	55788
399	400	64192
400	401	20311
401	402	54348
402	403	49255
403	404	21109
404	405	38523
405	406	41844
406	407	49441
407	408	36669
408	409	67385
409	410	34533
410	411	41687
411	412	32159
412	413	40007
413	414	75970
414	415	59901
415	416	26622
416	417	25039
417	418	73220
418	419	27634
419	420	64796
420	421	31020
421	422	35670
422	423	47044
423	424	60936
424	425	61350
425	426	27011
426	427	43492
427	428	79804
428	429	77924
429	430	34984
430	431	33025
431	432	50398
432	433	65750
433	434	46855
434	435	63891
435	436	79585
436	437	54094
437	438	31313
438	439	77600
439	440	57153
440	441	32081
441	442	24810
442	443	61558
443	444	22455
444	445	39619
445	446	71126
446	447	79325
447	448	37657
448	449	45778
449	450	38443
450	451	33565
451	452	60736
452	453	31831
453	454	64204
454	455	52574
455	456	61511
456	457	71985
457	458	74935
458	459	22561
459	460	30269
460	461	29489
461	462	76700
462	463	41908
463	464	28460
464	465	57178
465	466	41795
466	467	63310
467	468	43090
468	469	31635
469	470	37526
470	471	27485
471	472	54402
472	473	21138
473	474	30200
474	475	27035
475	476	59253
476	477	33327
477	478	51327
478	479	26150
479	480	59131
480	481	21247
481	482	47820
482	483	41236
483	484	76045
484	485	63900
485	486	73819
486	487	58029
487	488	76939
488	489	46116
489	490	47349
490	491	41805
491	492	76412
492	493	37700
493	494	42499
494	495	35531
495	496	59476
496	497	74542
497	498	51646
498	499	59060
499	500	49967
500	1	48391
\.


--
-- Data for Name: matchteam; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.matchteam (matchid, teamid, role, score, winloss) FROM stdin;
1	93	Home	3	Draw
1	44	Away	3	Draw
2	46	Home	3	Win
2	75	Away	1	Loss
3	90	Home	1	Draw
3	93	Away	1	Draw
4	56	Home	3	Win
4	91	Away	2	Loss
5	28	Home	4	Win
5	93	Away	0	Loss
6	43	Home	0	Loss
6	6	Away	3	Win
7	100	Home	2	Draw
7	11	Away	2	Draw
8	1	Home	4	Win
8	18	Away	0	Loss
9	15	Home	0	Loss
9	11	Away	1	Win
10	51	Home	1	Draw
10	8	Away	1	Draw
11	27	Home	4	Win
11	3	Away	1	Loss
12	97	Home	2	Win
12	62	Away	1	Loss
13	40	Home	1	Win
13	51	Away	0	Loss
14	35	Home	4	Draw
14	61	Away	4	Draw
15	11	Home	0	Loss
15	25	Away	2	Win
16	92	Home	2	Draw
16	34	Away	2	Draw
17	72	Home	0	Loss
17	91	Away	4	Win
18	69	Home	0	Loss
18	52	Away	4	Win
19	46	Home	4	Win
19	31	Away	2	Loss
20	83	Home	3	Draw
20	40	Away	3	Draw
21	83	Home	3	Loss
21	3	Away	4	Win
22	70	Home	3	Win
22	46	Away	2	Loss
23	11	Home	2	Loss
23	21	Away	3	Win
24	42	Home	1	Win
24	93	Away	0	Loss
25	64	Home	2	Loss
25	60	Away	3	Win
26	88	Home	3	Win
26	64	Away	0	Loss
27	92	Home	2	Draw
27	30	Away	2	Draw
28	23	Home	2	Loss
28	27	Away	3	Win
29	52	Home	1	Draw
29	96	Away	1	Draw
30	45	Home	0	Draw
30	4	Away	0	Draw
31	55	Home	1	Draw
31	29	Away	1	Draw
32	53	Home	0	Loss
32	73	Away	1	Win
33	6	Home	4	Win
33	19	Away	1	Loss
34	33	Home	0	Draw
34	69	Away	0	Draw
35	1	Home	3	Win
35	73	Away	2	Loss
36	4	Home	0	Loss
36	82	Away	2	Win
37	3	Home	0	Loss
37	67	Away	1	Win
38	69	Home	2	Loss
38	16	Away	3	Win
39	92	Home	2	Win
39	80	Away	0	Loss
40	49	Home	2	Win
40	46	Away	1	Loss
41	45	Home	0	Loss
41	99	Away	3	Win
42	89	Home	3	Win
42	12	Away	0	Loss
43	29	Home	3	Draw
43	37	Away	3	Draw
44	96	Home	1	Draw
44	81	Away	1	Draw
45	99	Home	3	Draw
45	48	Away	3	Draw
46	21	Home	4	Draw
46	70	Away	4	Draw
47	86	Home	1	Draw
47	96	Away	1	Draw
48	15	Home	1	Loss
48	76	Away	3	Win
49	69	Home	3	Loss
49	56	Away	4	Win
50	70	Home	2	Win
50	91	Away	1	Loss
51	23	Home	0	Loss
51	71	Away	2	Win
52	81	Home	0	Draw
52	1	Away	0	Draw
53	17	Home	4	Draw
53	54	Away	4	Draw
54	64	Home	3	Win
54	70	Away	2	Loss
55	97	Home	0	Loss
55	70	Away	2	Win
56	22	Home	4	Win
56	65	Away	1	Loss
57	43	Home	1	Win
57	28	Away	0	Loss
58	69	Home	2	Loss
58	52	Away	3	Win
59	19	Home	3	Loss
59	3	Away	4	Win
60	68	Home	3	Win
60	35	Away	1	Loss
61	96	Home	3	Win
61	95	Away	1	Loss
62	79	Home	3	Draw
62	36	Away	3	Draw
63	26	Home	3	Win
63	49	Away	1	Loss
64	20	Home	3	Win
64	50	Away	1	Loss
65	76	Home	0	Loss
65	1	Away	3	Win
66	21	Home	2	Win
66	49	Away	1	Loss
67	88	Home	4	Win
67	39	Away	3	Loss
68	91	Home	2	Loss
68	72	Away	3	Win
69	22	Home	2	Win
69	54	Away	0	Loss
70	2	Home	2	Draw
70	33	Away	2	Draw
71	35	Home	3	Draw
71	4	Away	3	Draw
72	5	Home	1	Win
72	40	Away	0	Loss
73	68	Home	4	Win
73	78	Away	1	Loss
74	85	Home	4	Win
74	16	Away	0	Loss
75	36	Home	4	Draw
75	77	Away	4	Draw
76	34	Home	3	Draw
76	11	Away	3	Draw
77	3	Home	3	Draw
77	65	Away	3	Draw
78	71	Home	4	Draw
78	74	Away	4	Draw
79	31	Home	2	Win
79	66	Away	1	Loss
80	58	Home	4	Win
80	53	Away	0	Loss
81	10	Home	4	Draw
81	35	Away	4	Draw
82	96	Home	2	Draw
82	9	Away	2	Draw
83	90	Home	1	Loss
83	58	Away	2	Win
84	44	Home	1	Loss
84	62	Away	2	Win
85	44	Home	1	Draw
85	6	Away	1	Draw
86	41	Home	1	Loss
86	8	Away	3	Win
87	69	Home	4	Win
87	80	Away	1	Loss
88	89	Home	1	Loss
88	3	Away	2	Win
89	52	Home	2	Win
89	40	Away	1	Loss
90	26	Home	1	Loss
90	47	Away	2	Win
91	55	Home	4	Win
91	59	Away	0	Loss
92	82	Home	2	Draw
92	93	Away	2	Draw
93	43	Home	1	Draw
93	54	Away	1	Draw
94	17	Home	4	Win
94	62	Away	1	Loss
95	37	Home	2	Win
95	9	Away	0	Loss
96	91	Home	2	Loss
96	6	Away	4	Win
97	81	Home	2	Loss
97	90	Away	4	Win
98	84	Home	4	Win
98	92	Away	2	Loss
99	98	Home	0	Loss
99	46	Away	1	Win
100	75	Home	3	Win
100	84	Away	0	Loss
101	83	Home	4	Win
101	1	Away	1	Loss
102	38	Home	4	Win
102	72	Away	0	Loss
103	92	Home	4	Win
103	24	Away	0	Loss
104	84	Home	0	Loss
104	25	Away	4	Win
105	30	Home	1	Win
105	71	Away	0	Loss
106	9	Home	3	Draw
106	30	Away	3	Draw
107	34	Home	1	Draw
107	39	Away	1	Draw
108	28	Home	0	Loss
108	62	Away	4	Win
109	8	Home	4	Win
109	7	Away	2	Loss
110	32	Home	1	Win
110	59	Away	0	Loss
111	89	Home	0	Loss
111	83	Away	4	Win
112	93	Home	0	Loss
112	13	Away	2	Win
113	95	Home	3	Win
113	63	Away	1	Loss
114	28	Home	4	Draw
114	58	Away	4	Draw
115	45	Home	1	Loss
115	58	Away	3	Win
116	50	Home	3	Win
116	91	Away	0	Loss
117	71	Home	3	Loss
117	18	Away	4	Win
118	22	Home	3	Draw
118	97	Away	3	Draw
119	93	Home	3	Draw
119	78	Away	3	Draw
120	43	Home	0	Loss
120	6	Away	4	Win
121	69	Home	3	Loss
121	75	Away	4	Win
122	91	Home	2	Win
122	1	Away	0	Loss
123	67	Home	0	Loss
123	98	Away	4	Win
124	43	Home	2	Loss
124	35	Away	4	Win
125	27	Home	2	Win
125	74	Away	1	Loss
126	12	Home	4	Draw
126	60	Away	4	Draw
127	22	Home	2	Loss
127	13	Away	4	Win
128	14	Home	1	Loss
128	34	Away	3	Win
129	60	Home	1	Loss
129	12	Away	2	Win
130	41	Home	4	Win
130	58	Away	0	Loss
131	48	Home	1	Loss
131	64	Away	3	Win
132	48	Home	3	Win
132	62	Away	2	Loss
133	29	Home	4	Win
133	30	Away	1	Loss
134	9	Home	1	Draw
134	54	Away	1	Draw
135	68	Home	0	Loss
135	19	Away	1	Win
136	43	Home	2	Win
136	61	Away	1	Loss
137	96	Home	0	Loss
137	15	Away	2	Win
138	74	Home	2	Draw
138	88	Away	2	Draw
139	5	Home	0	Loss
139	12	Away	1	Win
140	80	Home	1	Loss
140	57	Away	3	Win
141	15	Home	2	Win
141	6	Away	0	Loss
142	8	Home	0	Loss
142	80	Away	3	Win
143	49	Home	3	Draw
143	72	Away	3	Draw
144	14	Home	4	Win
144	71	Away	0	Loss
145	66	Home	1	Loss
145	77	Away	2	Win
146	8	Home	1	Draw
146	48	Away	1	Draw
147	76	Home	0	Loss
147	28	Away	1	Win
148	37	Home	4	Win
148	100	Away	2	Loss
149	83	Home	4	Draw
149	34	Away	4	Draw
150	3	Home	3	Win
150	7	Away	2	Loss
151	83	Home	4	Win
151	24	Away	0	Loss
152	24	Home	4	Win
152	67	Away	3	Loss
153	8	Home	2	Win
153	4	Away	0	Loss
154	23	Home	1	Draw
154	22	Away	1	Draw
155	94	Home	3	Win
155	54	Away	1	Loss
156	38	Home	3	Win
156	44	Away	0	Loss
157	76	Home	2	Loss
157	43	Away	4	Win
158	27	Home	1	Loss
158	20	Away	3	Win
159	57	Home	3	Draw
159	18	Away	3	Draw
160	6	Home	2	Loss
160	47	Away	3	Win
161	19	Home	1	Win
161	63	Away	0	Loss
162	28	Home	4	Win
162	2	Away	1	Loss
163	78	Home	1	Loss
163	77	Away	3	Win
164	81	Home	4	Win
164	51	Away	3	Loss
165	45	Home	1	Loss
165	10	Away	2	Win
166	91	Home	4	Draw
166	56	Away	4	Draw
167	3	Home	1	Win
167	34	Away	0	Loss
168	16	Home	1	Loss
168	22	Away	3	Win
169	67	Home	2	Draw
169	36	Away	2	Draw
170	21	Home	2	Loss
170	49	Away	3	Win
171	75	Home	2	Loss
171	45	Away	3	Win
172	35	Home	1	Draw
172	95	Away	1	Draw
173	27	Home	3	Win
173	45	Away	2	Loss
174	6	Home	2	Loss
174	97	Away	4	Win
175	95	Home	3	Loss
175	33	Away	4	Win
176	64	Home	0	Loss
176	2	Away	4	Win
177	45	Home	2	Win
177	96	Away	0	Loss
178	22	Home	4	Win
178	13	Away	2	Loss
179	47	Home	1	Loss
179	79	Away	4	Win
180	80	Home	2	Win
180	7	Away	1	Loss
181	68	Home	4	Win
181	34	Away	0	Loss
182	43	Home	4	Win
182	10	Away	3	Loss
183	80	Home	4	Draw
183	58	Away	4	Draw
184	67	Home	3	Win
184	30	Away	1	Loss
185	26	Home	2	Win
185	77	Away	1	Loss
186	88	Home	2	Win
186	32	Away	1	Loss
187	63	Home	1	Loss
187	12	Away	2	Win
188	55	Home	4	Win
188	99	Away	0	Loss
189	11	Home	0	Loss
189	92	Away	2	Win
190	55	Home	3	Win
190	96	Away	1	Loss
191	59	Home	0	Loss
191	53	Away	1	Win
192	27	Home	4	Draw
192	21	Away	4	Draw
193	19	Home	0	Loss
193	66	Away	4	Win
194	83	Home	2	Loss
194	50	Away	4	Win
195	5	Home	1	Win
195	36	Away	0	Loss
196	30	Home	4	Win
196	14	Away	0	Loss
197	5	Home	0	Loss
197	20	Away	1	Win
198	44	Home	0	Loss
198	32	Away	2	Win
199	99	Home	4	Draw
199	62	Away	4	Draw
200	33	Home	3	Loss
200	83	Away	4	Win
201	84	Home	3	Win
201	77	Away	2	Loss
202	50	Home	1	Loss
202	45	Away	3	Win
203	37	Home	2	Win
203	36	Away	0	Loss
204	57	Home	2	Draw
204	87	Away	2	Draw
205	45	Home	2	Loss
205	5	Away	4	Win
206	100	Home	0	Loss
206	32	Away	4	Win
207	42	Home	4	Win
207	36	Away	3	Loss
208	96	Home	2	Win
208	5	Away	0	Loss
209	58	Home	0	Loss
209	99	Away	4	Win
210	6	Home	1	Win
210	32	Away	0	Loss
211	88	Home	1	Loss
211	56	Away	3	Win
212	69	Home	1	Loss
212	3	Away	4	Win
213	47	Home	3	Win
213	52	Away	1	Loss
214	39	Home	3	Win
214	94	Away	0	Loss
215	72	Home	0	Loss
215	11	Away	2	Win
216	21	Home	3	Win
216	40	Away	0	Loss
217	62	Home	0	Loss
217	61	Away	1	Win
218	88	Home	1	Loss
218	92	Away	3	Win
219	82	Home	0	Loss
219	56	Away	3	Win
220	22	Home	1	Loss
220	23	Away	3	Win
221	89	Home	4	Win
221	65	Away	3	Loss
222	2	Home	4	Win
222	36	Away	2	Loss
223	28	Home	1	Draw
223	5	Away	1	Draw
224	79	Home	0	Loss
224	2	Away	2	Win
225	98	Home	2	Loss
225	5	Away	3	Win
226	25	Home	3	Win
226	57	Away	2	Loss
227	62	Home	2	Loss
227	52	Away	3	Win
228	53	Home	3	Draw
228	23	Away	3	Draw
229	72	Home	2	Win
229	57	Away	1	Loss
230	22	Home	4	Win
230	85	Away	0	Loss
231	100	Home	0	Loss
231	91	Away	2	Win
232	1	Home	0	Loss
232	82	Away	3	Win
233	41	Home	4	Win
233	27	Away	1	Loss
234	47	Home	1	Draw
234	21	Away	1	Draw
235	9	Home	3	Draw
235	40	Away	3	Draw
236	25	Home	4	Win
236	69	Away	3	Loss
237	84	Home	4	Win
237	73	Away	0	Loss
238	36	Home	0	Loss
238	90	Away	2	Win
239	47	Home	4	Win
239	90	Away	3	Loss
240	94	Home	3	Loss
240	36	Away	4	Win
241	18	Home	0	Loss
241	38	Away	4	Win
242	83	Home	2	Loss
242	68	Away	4	Win
243	93	Home	0	Draw
243	51	Away	0	Draw
244	41	Home	0	Loss
244	29	Away	3	Win
245	80	Home	1	Loss
245	3	Away	4	Win
246	39	Home	1	Win
246	51	Away	0	Loss
247	92	Home	2	Loss
247	94	Away	3	Win
248	95	Home	3	Draw
248	96	Away	3	Draw
249	18	Home	3	Win
249	28	Away	1	Loss
250	52	Home	3	Win
250	37	Away	0	Loss
251	48	Home	1	Draw
251	84	Away	1	Draw
252	26	Home	4	Win
252	100	Away	1	Loss
253	7	Home	3	Draw
253	36	Away	3	Draw
254	23	Home	0	Loss
254	54	Away	4	Win
255	21	Home	2	Win
255	50	Away	0	Loss
256	80	Home	4	Draw
256	38	Away	4	Draw
257	46	Home	3	Win
257	43	Away	0	Loss
258	92	Home	3	Loss
258	10	Away	4	Win
259	72	Home	3	Loss
259	26	Away	4	Win
260	33	Home	2	Win
260	52	Away	0	Loss
261	54	Home	0	Loss
261	31	Away	1	Win
262	16	Home	3	Win
262	18	Away	1	Loss
263	67	Home	1	Loss
263	72	Away	3	Win
264	60	Home	1	Win
264	45	Away	0	Loss
265	69	Home	3	Win
265	85	Away	2	Loss
266	33	Home	4	Win
266	35	Away	0	Loss
267	25	Home	4	Win
267	41	Away	1	Loss
268	92	Home	3	Loss
268	49	Away	4	Win
269	8	Home	3	Win
269	88	Away	2	Loss
270	88	Home	1	Loss
270	90	Away	4	Win
271	77	Home	0	Draw
271	59	Away	0	Draw
272	56	Home	4	Draw
272	9	Away	4	Draw
273	81	Home	0	Loss
273	1	Away	2	Win
274	62	Home	1	Loss
274	91	Away	2	Win
275	93	Home	1	Win
275	58	Away	0	Loss
276	46	Home	3	Loss
276	32	Away	4	Win
277	52	Home	1	Win
277	87	Away	0	Loss
278	51	Home	3	Win
278	8	Away	2	Loss
279	21	Home	1	Draw
279	12	Away	1	Draw
280	78	Home	2	Draw
280	80	Away	2	Draw
281	86	Home	2	Loss
281	39	Away	4	Win
282	77	Home	2	Win
282	39	Away	1	Loss
283	65	Home	3	Win
283	99	Away	1	Loss
284	61	Home	1	Draw
284	79	Away	1	Draw
285	87	Home	0	Loss
285	41	Away	2	Win
286	77	Home	0	Loss
286	99	Away	3	Win
287	92	Home	3	Win
287	19	Away	0	Loss
288	43	Home	4	Win
288	93	Away	1	Loss
289	14	Home	3	Win
289	37	Away	1	Loss
290	63	Home	3	Win
290	38	Away	0	Loss
291	8	Home	2	Loss
291	18	Away	4	Win
292	8	Home	1	Loss
292	29	Away	2	Win
293	35	Home	0	Loss
293	78	Away	1	Win
294	43	Home	4	Win
294	58	Away	3	Loss
295	54	Home	4	Win
295	56	Away	1	Loss
296	20	Home	1	Win
296	43	Away	0	Loss
297	23	Home	2	Loss
297	4	Away	3	Win
298	43	Home	1	Draw
298	74	Away	1	Draw
299	71	Home	2	Loss
299	86	Away	3	Win
300	21	Home	2	Draw
300	86	Away	2	Draw
301	98	Home	3	Win
301	97	Away	1	Loss
302	40	Home	1	Win
302	91	Away	0	Loss
303	75	Home	4	Win
303	100	Away	0	Loss
304	55	Home	3	Loss
304	7	Away	4	Win
305	15	Home	3	Win
305	47	Away	1	Loss
306	52	Home	1	Loss
306	20	Away	3	Win
307	42	Home	1	Win
307	92	Away	0	Loss
308	30	Home	0	Loss
308	4	Away	1	Win
309	96	Home	4	Win
309	35	Away	2	Loss
310	43	Home	2	Draw
310	57	Away	2	Draw
311	65	Home	3	Draw
311	35	Away	3	Draw
312	37	Home	2	Loss
312	43	Away	4	Win
313	7	Home	0	Loss
313	40	Away	4	Win
314	12	Home	3	Win
314	77	Away	1	Loss
315	99	Home	1	Draw
315	58	Away	1	Draw
316	94	Home	2	Loss
316	80	Away	3	Win
317	8	Home	4	Win
317	21	Away	2	Loss
318	59	Home	3	Draw
318	19	Away	3	Draw
319	30	Home	4	Win
319	37	Away	2	Loss
320	67	Home	1	Loss
320	95	Away	2	Win
321	14	Home	1	Win
321	83	Away	0	Loss
322	52	Home	0	Draw
322	70	Away	0	Draw
323	45	Home	0	Loss
323	18	Away	2	Win
324	13	Home	2	Draw
324	24	Away	2	Draw
325	84	Home	0	Loss
325	52	Away	3	Win
326	40	Home	1	Win
326	61	Away	0	Loss
327	99	Home	3	Win
327	31	Away	0	Loss
328	66	Home	0	Loss
328	57	Away	1	Win
329	97	Home	4	Win
329	57	Away	2	Loss
330	72	Home	3	Win
330	94	Away	2	Loss
331	55	Home	2	Win
331	5	Away	0	Loss
332	32	Home	0	Loss
332	69	Away	1	Win
333	34	Home	3	Win
333	10	Away	1	Loss
334	86	Home	4	Win
334	83	Away	2	Loss
335	4	Home	3	Draw
335	47	Away	3	Draw
336	28	Home	0	Draw
336	90	Away	0	Draw
337	30	Home	2	Draw
337	10	Away	2	Draw
338	17	Home	3	Win
338	10	Away	0	Loss
339	28	Home	1	Loss
339	90	Away	3	Win
340	1	Home	2	Loss
340	41	Away	4	Win
341	15	Home	4	Draw
341	93	Away	4	Draw
342	17	Home	1	Loss
342	61	Away	4	Win
343	47	Home	0	Draw
343	89	Away	0	Draw
344	87	Home	2	Win
344	50	Away	1	Loss
345	78	Home	2	Loss
345	46	Away	4	Win
346	82	Home	0	Loss
346	89	Away	3	Win
347	18	Home	2	Loss
347	82	Away	3	Win
348	78	Home	3	Win
348	48	Away	1	Loss
349	37	Home	0	Loss
349	85	Away	2	Win
350	34	Home	1	Draw
350	4	Away	1	Draw
351	24	Home	3	Win
351	35	Away	0	Loss
352	37	Home	4	Win
352	49	Away	3	Loss
353	66	Home	3	Loss
353	10	Away	4	Win
354	100	Home	0	Loss
354	33	Away	1	Win
355	71	Home	4	Draw
355	20	Away	4	Draw
356	13	Home	3	Draw
356	92	Away	3	Draw
357	2	Home	2	Loss
357	52	Away	4	Win
358	13	Home	1	Loss
358	66	Away	3	Win
359	74	Home	2	Draw
359	100	Away	2	Draw
360	77	Home	2	Win
360	37	Away	0	Loss
361	19	Home	4	Win
361	51	Away	0	Loss
362	68	Home	4	Win
362	91	Away	2	Loss
363	77	Home	0	Loss
363	52	Away	4	Win
364	18	Home	2	Win
364	66	Away	1	Loss
365	9	Home	2	Loss
365	58	Away	3	Win
366	40	Home	1	Loss
366	11	Away	4	Win
367	56	Home	2	Win
367	26	Away	0	Loss
368	96	Home	2	Win
368	100	Away	0	Loss
369	22	Home	0	Loss
369	96	Away	2	Win
370	62	Home	1	Loss
370	34	Away	3	Win
371	6	Home	2	Loss
371	94	Away	4	Win
372	21	Home	2	Win
372	71	Away	0	Loss
373	64	Home	0	Loss
373	54	Away	4	Win
374	47	Home	0	Loss
374	49	Away	4	Win
375	37	Home	0	Draw
375	81	Away	0	Draw
376	29	Home	2	Loss
376	97	Away	4	Win
377	89	Home	1	Loss
377	91	Away	2	Win
378	66	Home	3	Loss
378	51	Away	4	Win
379	97	Home	2	Loss
379	69	Away	4	Win
380	96	Home	1	Draw
380	84	Away	1	Draw
381	80	Home	4	Win
381	29	Away	2	Loss
382	71	Home	1	Loss
382	33	Away	4	Win
383	78	Home	0	Loss
383	96	Away	3	Win
384	5	Home	0	Loss
384	61	Away	4	Win
385	25	Home	0	Loss
385	85	Away	2	Win
386	39	Home	3	Draw
386	8	Away	3	Draw
387	45	Home	2	Loss
387	85	Away	4	Win
388	24	Home	1	Draw
388	75	Away	1	Draw
389	44	Home	0	Loss
389	87	Away	4	Win
390	77	Home	2	Draw
390	75	Away	2	Draw
391	43	Home	4	Draw
391	90	Away	4	Draw
392	81	Home	4	Win
392	94	Away	2	Loss
393	56	Home	0	Loss
393	14	Away	3	Win
394	79	Home	4	Win
394	62	Away	3	Loss
395	24	Home	1	Draw
395	64	Away	1	Draw
396	68	Home	0	Loss
396	95	Away	2	Win
397	88	Home	4	Draw
397	41	Away	4	Draw
398	90	Home	3	Loss
398	84	Away	4	Win
399	62	Home	4	Win
399	80	Away	2	Loss
400	55	Home	1	Loss
400	3	Away	4	Win
401	17	Home	0	Loss
401	4	Away	3	Win
402	29	Home	2	Loss
402	89	Away	3	Win
403	78	Home	3	Draw
403	9	Away	3	Draw
404	43	Home	0	Loss
404	71	Away	1	Win
405	31	Home	3	Win
405	7	Away	2	Loss
406	64	Home	0	Loss
406	92	Away	4	Win
407	96	Home	4	Draw
407	5	Away	4	Draw
408	51	Home	1	Loss
408	37	Away	3	Win
409	96	Home	2	Win
409	38	Away	1	Loss
410	16	Home	4	Draw
410	86	Away	4	Draw
411	82	Home	3	Win
411	53	Away	1	Loss
412	34	Home	1	Draw
412	7	Away	1	Draw
413	61	Home	4	Win
413	13	Away	0	Loss
414	3	Home	0	Loss
414	52	Away	3	Win
415	8	Home	2	Win
415	95	Away	0	Loss
416	22	Home	0	Loss
416	84	Away	1	Win
417	27	Home	3	Win
417	73	Away	0	Loss
418	32	Home	2	Draw
418	56	Away	2	Draw
419	35	Home	1	Draw
419	11	Away	1	Draw
420	12	Home	3	Draw
420	18	Away	3	Draw
421	56	Home	3	Win
421	1	Away	1	Loss
422	32	Home	4	Win
422	67	Away	2	Loss
423	73	Home	1	Loss
423	13	Away	2	Win
424	44	Home	3	Win
424	79	Away	1	Loss
425	60	Home	2	Win
425	34	Away	0	Loss
426	47	Home	3	Draw
426	95	Away	3	Draw
427	83	Home	4	Win
427	58	Away	3	Loss
428	30	Home	0	Loss
428	56	Away	1	Win
429	39	Home	2	Loss
429	65	Away	3	Win
430	20	Home	4	Win
430	68	Away	3	Loss
431	40	Home	3	Win
431	33	Away	0	Loss
432	52	Home	2	Loss
432	21	Away	3	Win
433	80	Home	1	Loss
433	76	Away	4	Win
434	53	Home	4	Draw
434	80	Away	4	Draw
435	78	Home	0	Loss
435	81	Away	1	Win
436	16	Home	3	Win
436	91	Away	2	Loss
437	37	Home	1	Win
437	46	Away	0	Loss
438	71	Home	2	Win
438	7	Away	0	Loss
439	37	Home	3	Win
439	41	Away	2	Loss
440	79	Home	4	Draw
440	43	Away	4	Draw
441	80	Home	2	Draw
441	42	Away	2	Draw
442	28	Home	1	Loss
442	83	Away	2	Win
443	5	Home	1	Loss
443	25	Away	4	Win
444	57	Home	2	Win
444	20	Away	0	Loss
445	60	Home	1	Loss
445	94	Away	4	Win
446	52	Home	0	Draw
446	98	Away	0	Draw
447	33	Home	1	Draw
447	98	Away	1	Draw
448	28	Home	0	Loss
448	87	Away	1	Win
449	76	Home	1	Loss
449	45	Away	3	Win
450	54	Home	4	Win
450	97	Away	0	Loss
451	61	Home	3	Win
451	84	Away	2	Loss
452	82	Home	4	Win
452	55	Away	3	Loss
453	50	Home	1	Loss
453	33	Away	4	Win
454	1	Home	4	Win
454	97	Away	3	Loss
455	8	Home	0	Loss
455	34	Away	1	Win
456	73	Home	0	Loss
456	97	Away	2	Win
457	12	Home	0	Draw
457	58	Away	0	Draw
458	65	Home	0	Loss
458	77	Away	3	Win
459	31	Home	4	Win
459	57	Away	0	Loss
460	65	Home	1	Loss
460	5	Away	2	Win
461	48	Home	3	Win
461	34	Away	1	Loss
462	25	Home	2	Loss
462	16	Away	4	Win
463	37	Home	4	Win
463	23	Away	3	Loss
464	5	Home	1	Win
464	69	Away	0	Loss
465	52	Home	3	Win
465	94	Away	0	Loss
466	4	Home	4	Win
466	71	Away	2	Loss
467	21	Home	0	Loss
467	44	Away	4	Win
468	87	Home	4	Win
468	34	Away	2	Loss
469	43	Home	2	Loss
469	91	Away	3	Win
470	2	Home	1	Win
470	53	Away	0	Loss
471	79	Home	0	Loss
471	36	Away	4	Win
472	50	Home	2	Win
472	63	Away	1	Loss
473	11	Home	0	Loss
473	19	Away	4	Win
474	3	Home	1	Loss
474	8	Away	2	Win
475	79	Home	3	Win
475	83	Away	2	Loss
476	89	Home	2	Win
476	61	Away	0	Loss
477	45	Home	1	Loss
477	79	Away	4	Win
478	17	Home	4	Draw
478	8	Away	4	Draw
479	37	Home	0	Loss
479	26	Away	2	Win
480	16	Home	0	Loss
480	72	Away	4	Win
481	86	Home	1	Win
481	65	Away	0	Loss
482	52	Home	3	Loss
482	37	Away	4	Win
483	56	Home	2	Win
483	82	Away	1	Loss
484	17	Home	4	Win
484	25	Away	3	Loss
485	2	Home	4	Win
485	84	Away	1	Loss
486	85	Home	4	Win
486	61	Away	3	Loss
487	96	Home	4	Win
487	88	Away	1	Loss
488	86	Home	3	Win
488	79	Away	0	Loss
489	70	Home	2	Win
489	42	Away	1	Loss
490	11	Home	1	Loss
490	93	Away	3	Win
491	63	Home	0	Loss
491	50	Away	2	Win
492	48	Home	4	Win
492	88	Away	0	Loss
493	31	Home	2	Win
493	82	Away	1	Loss
494	90	Home	3	Win
494	4	Away	1	Loss
495	3	Home	0	Loss
495	100	Away	1	Win
496	88	Home	2	Draw
496	59	Away	2	Draw
497	41	Home	1	Draw
497	95	Away	1	Draw
498	27	Home	2	Loss
498	36	Away	4	Win
499	17	Home	0	Loss
499	1	Away	1	Win
500	54	Home	3	Win
500	68	Away	2	Loss
\.


--
-- Data for Name: player; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.player (playerid, playername, birthdate, "position", height, strongleg, nativecountry) FROM stdin;
1	Ruben Gnabry 1	2001-08-18	Forward	181	Right	France
2	Marcus Silva 2	2002-10-18	Forward	173	Right	France
3	Gabriel Gnabry 3	2004-05-13	Defender	194	Right	Croatia
4	Ousmane Bastoni 4	2003-12-14	Midfielder	193	Left	Morocco
5	Alphonso Alvarez 5	2001-09-26	Defender	182	Left	Egypt
6	Alexis Kimmich 6	1998-11-13	Forward	183	Right	Austria
7	Alexis Becker 7	1996-10-04	Midfielder	175	Right	Brazil
8	Leroy Camavinga 8	2003-11-18	Defender	175	Right	France
9	Aurelien Foden 9	1998-12-27	Forward	182	Left	France
10	Erling Messi 10	2005-09-06	Defender	176	Right	Colombia
11	Sandro Gnabry 11	2001-11-18	Defender	177	Right	Ivory Coast
12	William Hernandez 12	1995-05-17	Defender	188	Left	Nigeria
13	Victor Junior 13	2004-09-29	Forward	193	Right	Italy
14	Marquinhos Junior 14	1998-07-26	Defender	192	Right	Belgium
15	Ronald Gnabry 15	2004-06-12	Midfielder	189	Right	Argentina
16	Eduardo Silva 16	2001-04-11	Midfielder	177	Right	Poland
17	Nicolo Becker 17	2003-04-19	Defender	177	Left	Senegal
18	Achraf Silva 18	1995-11-18	Midfielder	194	Right	Colombia
19	Ruben Araujo 19	1997-08-27	Midfielder	184	Right	USA
20	Cristiano Grealish 20	1996-04-02	Defender	177	Left	Turkey
21	Rafael Junior 21	2000-06-27	Midfielder	189	Right	Senegal
22	Kylian van Dijk 22	1995-03-01	Midfielder	195	Right	Spain
23	Eduardo Osimhen 23	2005-03-13	Defender	173	Left	Austria
24	Joshua Rice 24	2005-04-28	Midfielder	186	Right	Senegal
25	Kylian Dias 25	1995-02-13	Forward	193	Right	Chile
26	Bernardo De Bruyne 26	2001-07-05	Defender	176	Right	Egypt
27	Eder Oblak 27	1996-03-17	Midfielder	179	Left	Egypt
28	Nicolo Diaz 28	2003-10-31	Midfielder	176	Right	Croatia
29	Kylian Bastoni 29	1999-03-17	Midfielder	186	Left	Nigeria
30	Achraf Salah 30	2003-01-02	Defender	173	Left	Ivory Coast
31	Trent Maignan 31	2003-07-19	Defender	191	Right	Argentina
32	Leon Leao 32	1995-05-01	Defender	175	Right	Israel
33	Federico Nunez 33	2002-05-12	Forward	188	Right	Scotland
34	Dayot Silva 34	2003-05-01	Forward	179	Right	Senegal
35	Lionel Osimhen 35	2004-11-08	Midfielder	182	Right	Netherlands
36	Aurelien Moraes 36	1998-07-25	Midfielder	194	Right	Mexico
37	Ousmane White 37	2000-11-10	Forward	175	Right	Croatia
38	Rafael Bastoni 38	2005-10-19	Midfielder	174	Right	Nigeria
39	Erling Araujo 39	2002-09-18	Forward	177	Right	Mexico
40	Achraf Saliba 40	2000-03-07	Forward	185	Right	Colombia
41	Luka Musiala 41	1997-03-16	Midfielder	180	Left	France
42	Virgil Bellingham 42	1995-06-29	Forward	176	Right	Brazil
43	Leon Moraes 43	1997-09-24	Defender	175	Left	Japan
44	Rodri Bastoni 44	1997-01-15	Midfielder	191	Right	Norway
45	Jamal Nunez 45	2002-11-02	Defender	172	Right	France
46	Randal Valverde 46	2004-09-12	Defender	182	Right	Morocco
47	Alisson Dias 47	1998-01-09	Midfielder	193	Right	Ivory Coast
48	Bukayo Silva 48	1998-04-08	Midfielder	195	Right	Scotland
49	Lionel James 49	1995-06-22	Midfielder	192	Left	Scotland
50	Luis James 50	2000-11-09	Defender	180	Left	Austria
51	Reece Modric 51	2001-01-30	Defender	187	Left	Ivory Coast
52	Rodri James 52	2005-08-22	Forward	190	Right	England
53	Erling Araujo 53	2003-10-30	Midfielder	194	Right	Argentina
54	Ronald Dembele 54	2004-11-19	Midfielder	194	Right	Mexico
55	Harry Barella 55	1997-04-10	Midfielder	181	Right	Croatia
56	Alphonso Neuer 56	1996-09-22	Forward	175	Right	England
57	Jack Neuer 57	1997-11-11	Midfielder	178	Left	Austria
58	Serge Kolo Muani 58	1995-02-05	Forward	179	Left	Ivory Coast
59	Leroy Mac Allister 59	1998-11-24	Forward	184	Left	Portugal
60	Marquinhos Martinez 60	1998-06-18	Midfielder	191	Left	Austria
61	Leon Alvarez 61	2005-01-09	Midfielder	176	Right	England
62	Serge Neuer 62	1995-05-01	Midfielder	175	Left	France
63	Kim Kimmich 63	2004-05-20	Defender	185	Left	Ivory Coast
64	Harry Tonali 64	1998-08-24	Midfielder	170	Right	Croatia
65	Bruno Mbappe 65	1998-06-05	Forward	179	Right	Ivory Coast
66	Alisson Barella 66	2001-09-22	Defender	183	Left	Argentina
67	Sandro Salah 67	2004-04-08	Defender	186	Left	Croatia
68	Achraf Tchouameni 68	1997-09-28	Defender	189	Right	USA
69	Sandro Saliba 69	2005-07-07	Forward	183	Right	Chile
70	Antoine White 70	1997-03-05	Forward	173	Left	Scotland
71	Marquinhos Odegaard 71	2000-01-16	Defender	177	Right	Norway
72	Declan Upamecano 72	1997-11-23	Forward	192	Right	Colombia
73	Virgil Fernandez 73	2001-05-11	Defender	189	Right	Italy
74	Julian Partey 74	2000-12-03	Defender	192	Left	Brazil
75	Alexis Rashford 75	2004-08-30	Midfielder	190	Right	Norway
76	Luka Odegaard 76	1998-07-24	Forward	190	Left	Netherlands
77	Marquinhos Messi 77	2002-06-27	Defender	172	Right	England
78	Darwin Haaland 78	1997-05-07	Forward	183	Right	Ivory Coast
79	Khvicha Fernandes 79	1995-12-05	Forward	195	Right	Brazil
80	Marquinhos Tchouameni 80	2002-11-09	Defender	188	Right	Nigeria
81	Phil Dias 81	1997-01-25	Midfielder	188	Left	Portugal
82	Leroy Camavinga 82	2004-11-02	Defender	175	Left	Japan
83	Ruben Coman 83	2003-02-04	Midfielder	176	Left	Germany
84	Antoine Becker 84	1996-01-13	Midfielder	175	Left	Portugal
85	Jamal Rashford 85	2001-02-25	Midfielder	188	Right	Germany
86	Darwin Nkunku 86	2002-03-09	Midfielder	180	Right	Israel
87	Achraf Tchouameni 87	1995-04-15	Defender	194	Left	Ivory Coast
88	Jamal Diaz 88	2003-12-12	Forward	179	Right	Portugal
89	Ruben Oblak 89	1997-10-08	Defender	184	Left	Norway
90	Kylian Min-jae 90	2000-09-21	Defender	178	Right	Sweden
91	Kylian Messi 91	2004-12-16	Forward	175	Right	Colombia
92	Alphonso Nunez 92	1995-06-16	Forward	177	Left	Netherlands
93	Marcus Odegaard 93	2000-01-26	Forward	181	Right	Morocco
94	Mike Nunez 94	2005-03-07	Midfielder	185	Right	Poland
95	Joshua Ronaldo 95	2000-02-21	Defender	183	Left	Poland
96	Gianluigi Barella 96	1997-07-22	Midfielder	181	Left	England
97	Bruno Tchouameni 97	2001-05-11	Midfielder	173	Left	Belgium
98	Luka Kane 98	2005-04-20	Midfielder	183	Right	Egypt
99	Darwin Min-jae 99	2005-10-11	Defender	182	Right	Germany
100	Luis Bellingham 100	1999-10-26	Defender	175	Left	Norway
101	Khvicha Vlahovic 101	2002-05-28	Midfielder	185	Right	Senegal
102	Marquinhos Neuer 102	2001-04-19	Midfielder	176	Right	Israel
103	Bruno Fernandez 103	2003-11-18	Defender	180	Right	Nigeria
104	Bruno Tonali 104	2001-06-11	Defender	188	Right	Poland
105	Thibaut Messi 105	2001-10-13	Forward	178	Left	Sweden
106	Dayot Osimhen 106	2003-11-22	Midfielder	189	Right	Nigeria
107	Khvicha Barella 107	2002-05-26	Midfielder	171	Right	England
108	Marquinhos Coman 108	1998-05-22	Forward	187	Left	Turkey
109	Christopher Nunez 109	1998-04-07	Defender	173	Right	Spain
110	Trent Kane 110	1999-08-14	Forward	175	Right	Argentina
111	Mike Kvaratskhelia 111	2004-08-26	Midfielder	192	Left	Belgium
112	Reece Mac Allister 112	1998-10-04	Forward	177	Right	Portugal
113	Serge Hernandez 113	2005-06-13	Defender	174	Right	Italy
114	Pedri Sane 114	2004-06-15	Forward	176	Left	Senegal
115	Robert Fernandes 115	2003-10-03	Midfielder	192	Left	England
116	Enzo Courtois 116	2002-06-19	Forward	180	Left	Israel
117	Robert Martinez 117	2004-01-27	Defender	190	Right	Croatia
118	Kylian Davies 118	2001-11-14	Forward	183	Left	Ivory Coast
119	Marquinhos Haaland 119	1999-03-24	Midfielder	176	Right	Croatia
120	Randal Bellingham 120	1999-03-28	Defender	173	Right	Senegal
121	Thibaut Hernandez 121	1999-11-07	Midfielder	185	Left	Egypt
122	Casemiro Osimhen 122	2000-08-05	Defender	180	Right	Ivory Coast
123	Marquinhos Fernandes 123	2000-04-05	Midfielder	185	Left	Senegal
124	Darwin Kimmich 124	2005-06-02	Midfielder	192	Left	Croatia
125	Kylian Partey 125	1999-09-12	Midfielder	183	Right	Netherlands
126	Trent Min-jae 126	1995-01-06	Midfielder	193	Left	Senegal
127	Dayot Kolo Muani 127	1997-10-10	Defender	173	Right	Norway
128	Vinicius Diaz 128	2000-05-21	Defender	187	Right	Colombia
129	Martin Tonali 129	2001-04-08	Midfielder	173	Left	Ivory Coast
130	Sandro Neuer 130	1998-05-24	Defender	180	Left	Turkey
131	Lionel Kane 131	1997-12-25	Forward	188	Right	Sweden
132	Rafael Odegaard 132	2005-02-14	Defender	187	Right	Portugal
133	Declan Musiala 133	2000-11-27	Forward	170	Left	Norway
134	Christopher Coman 134	2000-04-09	Forward	182	Right	England
135	Lionel Araujo 135	1996-07-20	Forward	179	Right	Mexico
136	Manuel Musiala 136	2003-04-20	Defender	173	Left	Poland
137	Ousmane Leao 137	1999-04-25	Defender	184	Right	Morocco
138	Harry Saliba 138	2005-02-01	Forward	180	Left	Colombia
139	Jack Foden 139	1999-09-21	Defender	175	Left	Croatia
140	Virgil Araujo 140	1998-05-30	Forward	190	Left	Israel
141	Alphonso Becker 141	2000-12-13	Forward	185	Left	Argentina
142	Joshua Osimhen 142	2001-04-05	Midfielder	176	Left	Norway
143	Antoine Kolo Muani 143	2004-07-15	Defender	179	Left	Austria
144	Kylian Mac Allister 144	2001-08-28	Forward	187	Left	Italy
145	Darwin Vlahovic 145	1999-09-18	Defender	178	Left	Portugal
146	Marcus Silva 146	2000-11-24	Forward	193	Right	Croatia
147	Randal Barella 147	2003-03-07	Midfielder	195	Right	Morocco
148	Gianluigi Martinez 148	1998-08-03	Defender	177	Left	Austria
149	Cristiano Kolo Muani 149	2000-01-26	Forward	187	Right	Belgium
150	Ederson Haaland 150	2004-05-11	Defender	177	Left	Ivory Coast
151	Antoine Modric 151	2002-03-12	Midfielder	189	Right	Austria
152	Casemiro Ronaldo 152	2001-05-17	Forward	181	Left	Japan
153	Neymar De Bruyne 153	2002-04-03	Forward	180	Left	Mexico
154	Neymar Hakimi 154	2004-03-15	Defender	181	Left	Israel
155	Jan Odegaard 155	2005-07-29	Midfielder	185	Left	Germany
156	Manuel Becker 156	2003-11-18	Defender	187	Right	Austria
157	Marcus Haaland 157	1998-05-29	Midfielder	178	Left	Chile
158	Vinicius Silva 158	1995-12-18	Midfielder	179	Right	Netherlands
159	Virgil Davies 159	2004-12-04	Defender	188	Right	Belgium
160	Lionel Alvarez 160	2000-12-26	Defender	187	Right	Chile
161	Gianluigi Dembele 161	1998-05-14	Defender	180	Left	Chile
162	Victor Fernandez 162	1999-11-30	Forward	180	Left	Japan
163	Virgil Dembele 163	1999-09-16	Midfielder	189	Right	Japan
164	Pedri Valverde 164	2003-07-15	Midfielder	193	Right	Sweden
165	Ilkay Osimhen 165	2000-12-10	Forward	176	Left	Mexico
166	Joshua Martinez 166	1997-12-01	Midfielder	178	Left	Ivory Coast
167	Darwin White 167	2003-09-12	Forward	172	Left	France
168	Mohamed Moraes 168	2003-10-08	Forward	170	Right	Spain
169	Eduardo Sane 169	2003-06-03	Forward	194	Right	USA
170	Christopher Davies 170	1999-04-18	Forward	181	Left	Portugal
171	Ilkay Courtois 171	2000-05-01	Forward	174	Right	Israel
172	Harry Diaz 172	2000-07-22	Defender	170	Right	Morocco
173	Federico Messi 173	2002-05-28	Defender	191	Right	England
174	Julian Kane 174	1997-02-24	Defender	184	Left	Portugal
175	Ousmane Hakimi 175	2004-03-25	Midfielder	189	Right	Portugal
176	Lautaro Kvaratskhelia 176	1999-12-26	Defender	181	Left	Austria
177	Joshua Davies 177	1997-11-22	Midfielder	191	Left	Norway
178	Federico Sane 178	2005-01-24	Midfielder	178	Right	Portugal
179	Randal Becker 179	2003-08-06	Forward	173	Right	Mexico
180	Trent Alexander-Arnold 180	1995-05-23	Midfielder	180	Right	Netherlands
181	Rafael Lewandowski 181	2001-09-23	Forward	177	Left	Israel
182	Casemiro Kvaratskhelia 182	2002-06-08	Forward	182	Left	Austria
183	Luka Rice 183	2005-07-12	Midfielder	183	Left	France
184	Theo Rodri 184	2000-04-17	Midfielder	187	Left	Scotland
185	Lionel Dembele 185	1996-05-17	Midfielder	188	Left	Germany
186	Declan Neuer 186	2003-05-01	Forward	192	Right	Argentina
187	Cristiano Ronaldo 187	1997-01-20	Midfielder	181	Left	Scotland
188	Jamal Lewandowski 188	2004-10-30	Defender	188	Left	Japan
189	Mike Haaland 189	1995-03-17	Defender	193	Left	Ivory Coast
190	Sandro Leao 190	1996-02-08	Defender	191	Left	Morocco
191	Pedri Moraes 191	2001-11-13	Midfielder	171	Left	Argentina
192	Victor Kimmich 192	2003-12-11	Defender	173	Left	Sweden
193	Leroy Barella 193	1998-01-03	Midfielder	178	Left	Germany
194	Kylian Camavinga 194	1998-05-28	Forward	175	Right	Sweden
195	Lionel Fernandes 195	2001-10-20	Defender	172	Right	Colombia
196	Enzo Hakimi 196	2004-04-20	Midfielder	178	Right	France
197	Rodri Davies 197	2000-12-03	Defender	178	Left	Nigeria
198	Leroy Moraes 198	2001-04-12	Midfielder	180	Left	France
199	Mohamed van Dijk 199	2004-11-10	Forward	177	Right	France
200	Eder Mac Allister 200	2002-03-25	Forward	182	Right	USA
201	Jamal Kolo Muani 201	2005-08-06	Midfielder	184	Left	Egypt
202	Mohamed Silva 202	1999-07-26	Midfielder	172	Right	Israel
203	Reece Partey 203	1998-03-28	Midfielder	185	Left	Poland
204	Achraf Courtois 204	2004-12-23	Midfielder	172	Left	Nigeria
205	Darwin Odegaard 205	2002-10-04	Midfielder	173	Right	France
206	Erling Vlahovic 206	1996-02-26	Forward	188	Left	Morocco
207	Serge Militao 207	2003-10-17	Midfielder	188	Left	Italy
208	Alphonso Ronaldo 208	2004-09-04	Midfielder	183	Left	Croatia
209	Mike Barella 209	2002-04-28	Defender	178	Left	Ivory Coast
210	Casemiro Musiala 210	1998-05-11	Midfielder	188	Right	Argentina
211	Trent Partey 211	1998-07-30	Defender	175	Right	Poland
212	Bruno Bastoni 212	1995-07-09	Defender	185	Left	Belgium
213	Alphonso Nkunku 213	2004-05-16	Forward	174	Left	Norway
214	Alphonso Fernandes 214	1999-04-02	Defender	187	Right	Israel
215	Alexis Odegaard 215	2000-12-13	Midfielder	193	Left	Chile
216	Ederson Araujo 216	2000-09-05	Midfielder	175	Left	Japan
217	Thibaut Tonali 217	2005-05-17	Midfielder	190	Right	Senegal
218	Virgil Valverde 218	2005-07-03	Defender	191	Right	Portugal
219	Kim Neuer 219	2000-01-18	Midfielder	175	Left	Brazil
220	Luis Maignan 220	1997-12-14	Defender	181	Left	Japan
221	Manuel Tonali 221	1995-10-26	Defender	178	Right	Portugal
222	Rodri White 222	2002-12-25	Forward	177	Left	Netherlands
223	Trent Dias 223	2003-10-21	Midfielder	173	Left	Spain
224	Luka Dembele 224	1997-11-27	Defender	187	Right	Poland
225	Alexis Gundogan 225	1998-08-21	Midfielder	192	Left	Spain
226	Manuel Tonali 226	2003-09-11	Defender	180	Left	Italy
227	Alphonso Militao 227	2004-11-03	Forward	181	Left	Sweden
228	Reece Nkunku 228	1999-05-23	Forward	182	Right	Scotland
229	Ruben Lewandowski 229	2000-09-13	Midfielder	181	Right	Germany
230	Martin Kane 230	2001-05-02	Midfielder	183	Right	Senegal
231	Gabriel Odegaard 231	2003-02-09	Midfielder	171	Right	Sweden
232	Alisson Courtois 232	2002-01-14	Defender	180	Right	Senegal
233	Dayot Hakimi 233	1995-08-21	Defender	182	Left	Mexico
234	Lautaro Messi 234	2003-05-10	Defender	174	Left	Ivory Coast
235	Manuel Odegaard 235	2000-02-07	Midfielder	179	Left	Argentina
236	Neymar Tchouameni 236	2000-05-07	Midfielder	190	Left	Turkey
237	Ederson Maignan 237	1999-05-09	Defender	192	Left	Israel
238	Pedri Mac Allister 238	1995-06-07	Midfielder	178	Right	Germany
239	Martin Upamecano 239	2000-07-20	Midfielder	186	Right	Portugal
240	Dusan Odegaard 240	1997-12-10	Defender	172	Left	USA
241	Virgil Silva 241	1996-06-23	Defender	177	Right	France
242	Enzo Moraes 242	1999-01-09	Forward	172	Right	Poland
243	Kim Gundogan 243	2004-09-16	Defender	173	Right	Spain
244	Sandro Davies 244	2000-02-08	Defender	184	Right	Senegal
245	Antoine Kane 245	2004-02-26	Defender	188	Right	Norway
246	Phil Coman 246	2005-07-09	Midfielder	193	Left	Israel
247	Vinicius Araujo 247	2002-11-06	Midfielder	189	Right	Israel
248	Kevin Saliba 248	2002-08-22	Defender	185	Right	England
249	Mohamed Camavinga 249	2005-04-06	Midfielder	188	Left	Germany
250	Eder Alvarez 250	1997-09-04	Midfielder	184	Right	France
251	Jan Araujo 251	1998-11-10	Forward	175	Right	England
252	Lautaro Donnarumma 252	2004-08-30	Forward	176	Right	Italy
253	Darwin Gundogan 253	1997-07-24	Midfielder	175	Right	Poland
254	Bruno Oblak 254	1996-09-22	Midfielder	179	Left	Belgium
255	Jude Barella 255	1996-10-14	Defender	186	Right	Scotland
256	Aurelien Donnarumma 256	2002-10-14	Defender	189	Left	Chile
257	Alexis Coman 257	1998-10-22	Forward	178	Left	Brazil
258	Ronald Foden 258	1998-09-30	Forward	192	Left	France
259	Serge Modric 259	1997-10-03	Forward	170	Right	Mexico
260	Virgil Hakimi 260	1996-06-14	Forward	177	Right	Austria
261	Phil Gundogan 261	1996-10-17	Forward	181	Left	Chile
262	Vinicius Rice 262	1998-10-16	Midfielder	173	Left	Argentina
263	Bruno Salah 263	1998-07-20	Midfielder	184	Right	Spain
264	Ronald Rice 264	2005-12-05	Forward	172	Left	Brazil
265	Harry Donnarumma 265	2002-06-29	Defender	195	Right	Austria
266	Bukayo Foden 266	2003-02-15	Defender	182	Right	Poland
267	Reece Dembele 267	2002-03-23	Forward	180	Left	Japan
268	Lionel Barella 268	2003-05-08	Forward	182	Right	Scotland
269	Jan Saka 269	1996-10-05	Defender	180	Right	Poland
270	Ousmane van Dijk 270	1999-07-02	Midfielder	190	Left	Senegal
271	Virgil Courtois 271	2004-10-01	Defender	182	Left	USA
272	Luis Diaz 272	1999-06-03	Forward	174	Right	Israel
273	Rodri Courtois 273	1997-10-15	Defender	181	Right	Ivory Coast
274	Gianluigi Hakimi 274	2001-11-08	Midfielder	186	Right	Chile
275	Jack Salah 275	2002-02-20	Midfielder	170	Left	USA
276	Kim James 276	1997-03-13	Midfielder	188	Left	Argentina
277	Marquinhos Moraes 277	1997-05-29	Defender	183	Left	Nigeria
278	Eduardo Saliba 278	2005-02-19	Defender	185	Left	Mexico
279	Lautaro Gnabry 279	1997-03-12	Midfielder	173	Left	Italy
280	Jude Kvaratskhelia 280	1995-12-03	Forward	195	Right	Senegal
281	Rafael Valverde 281	1998-02-09	Midfielder	183	Left	Israel
282	Lautaro Nkunku 282	1995-06-11	Defender	171	Left	Sweden
283	Dayot Silva 283	1999-12-02	Forward	187	Left	Egypt
284	Bukayo Kolo Muani 284	2003-01-26	Defender	172	Left	Japan
285	Christopher Mac Allister 285	2003-12-26	Forward	174	Left	Japan
286	Ederson Odegaard 286	2005-08-19	Defender	178	Right	Mexico
287	Pedri Sane 287	2000-09-16	Midfielder	188	Right	Morocco
288	Jamal van Dijk 288	2002-08-23	Defender	177	Left	Poland
289	Ruben Modric 289	2005-02-05	Defender	190	Right	Italy
290	Mike Mac Allister 290	1998-01-31	Forward	186	Left	France
291	Luis White 291	1996-06-16	Forward	195	Left	Scotland
292	Vinicius Ronaldo 292	2003-03-09	Defender	185	Right	England
293	Bruno Sane 293	1997-04-25	Midfielder	191	Right	USA
294	Eder Junior 294	1999-08-05	Forward	183	Right	Poland
295	Bernardo Fernandez 295	2004-11-23	Midfielder	189	Right	Nigeria
296	Darwin Courtois 296	2005-04-26	Midfielder	185	Left	England
297	Dusan James 297	2002-03-28	Defender	192	Left	Spain
298	Bernardo Courtois 298	2002-08-13	Defender	171	Right	Nigeria
299	Julian Messi 299	2004-07-09	Midfielder	185	Left	Germany
300	Marquinhos Araujo 300	2000-08-21	Defender	179	Left	Spain
301	Eduardo Saka 301	1999-07-20	Forward	171	Left	Ivory Coast
302	Jamal Camavinga 302	2000-02-08	Forward	179	Right	Turkey
303	Bernardo Messi 303	2005-08-16	Defender	183	Left	Argentina
304	Luis James 304	1998-03-26	Forward	175	Left	Croatia
305	Rodri Dembele 305	2001-10-20	Defender	189	Left	Poland
306	Kim Davies 306	1996-05-23	Defender	170	Right	Colombia
307	Leon Silva 307	1998-04-04	Forward	189	Right	Brazil
308	Achraf Davies 308	1999-03-03	Defender	181	Left	Belgium
309	Gianluigi Diaz 309	2004-04-12	Forward	173	Left	Spain
310	Rodri Kvaratskhelia 310	2005-07-05	Forward	185	Right	Belgium
311	Victor Silva 311	2001-07-26	Forward	172	Right	Senegal
312	Pedri Modric 312	1999-05-06	Defender	178	Right	Poland
313	Lautaro Min-jae 313	1997-03-13	Midfielder	189	Left	France
314	Cristiano Messi 314	1999-06-07	Midfielder	181	Right	Egypt
315	Alisson Silva 315	2003-04-20	Defender	183	Left	Turkey
316	Bernardo van Dijk 316	2001-12-06	Defender	192	Right	Norway
317	Lionel White 317	1996-06-23	Midfielder	170	Left	Morocco
318	Achraf Fernandes 318	2004-01-14	Defender	177	Right	Belgium
319	Harry Hakimi 319	1997-01-31	Midfielder	189	Right	Norway
320	Theo Junior 320	2002-11-07	Midfielder	173	Left	Mexico
321	Reece van Dijk 321	2003-08-15	Defender	176	Right	France
322	Kingsley Upamecano 322	2003-02-15	Defender	189	Left	Japan
323	Darwin Davies 323	2001-05-31	Midfielder	172	Left	Brazil
324	Bernardo Fernandes 324	1996-09-25	Defender	178	Left	Brazil
325	Phil Courtois 325	1999-10-15	Defender	185	Left	Brazil
326	Alisson Lewandowski 326	2003-08-04	Midfielder	180	Right	Turkey
327	Rafael Musiala 327	2003-10-29	Midfielder	189	Right	Senegal
328	Trent Grealish 328	2000-11-29	Midfielder	193	Left	Sweden
329	Serge Dembele 329	2002-11-29	Midfielder	179	Left	Chile
330	Nicolo Junior 330	2005-03-25	Midfielder	181	Right	Colombia
331	Gabriel Maignan 331	2004-02-23	Defender	191	Right	Croatia
332	Reece Min-jae 332	2003-04-27	Forward	182	Right	Ivory Coast
333	Harry Rodri 333	1997-10-08	Midfielder	178	Left	France
334	Theo Dias 334	2002-04-20	Midfielder	181	Right	Senegal
335	Neymar Moraes 335	1996-06-04	Forward	170	Right	Spain
336	Nicolo James 336	1995-06-05	Forward	187	Right	USA
337	Serge Haaland 337	1997-11-29	Midfielder	182	Left	Austria
338	Lionel Mac Allister 338	1995-10-06	Defender	177	Right	Ivory Coast
339	Federico Barella 339	2003-05-19	Forward	189	Right	Senegal
340	Marcus Rice 340	2004-09-26	Midfielder	177	Left	Nigeria
341	Cristiano Haaland 341	1997-03-15	Defender	188	Left	USA
342	Lionel Tchouameni 342	1996-07-12	Defender	192	Left	Portugal
343	Federico Becker 343	1995-01-06	Defender	192	Right	Norway
344	Alexis White 344	1998-07-20	Defender	173	Right	France
345	Julian Min-jae 345	2001-10-08	Forward	183	Right	Poland
346	Rodri Kimmich 346	1997-05-07	Defender	184	Right	Chile
347	Christopher Dias 347	2005-10-14	Forward	172	Right	Netherlands
348	Trent Goretzka 348	2004-03-14	Midfielder	185	Right	Germany
349	Aurelien Foden 349	2004-03-19	Defender	187	Left	Germany
350	Rafael Junior 350	1995-03-09	Forward	174	Left	Ivory Coast
351	Jack Dembele 351	2005-10-05	Forward	171	Left	Argentina
352	Declan Bellingham 352	1998-05-28	Midfielder	190	Right	Colombia
353	Alexis Fernandes 353	1998-09-21	Forward	172	Left	Poland
354	Federico Haaland 354	1999-03-09	Defender	172	Right	Belgium
355	Jude Kimmich 355	2002-03-24	Midfielder	172	Left	Netherlands
356	Ilkay Haaland 356	2001-09-06	Midfielder	184	Right	France
357	Ruben Bastoni 357	2001-08-25	Forward	182	Right	Colombia
358	Bruno Lewandowski 358	1996-06-20	Defender	173	Left	Italy
359	Bernardo Salah 359	1998-04-17	Midfielder	174	Left	France
360	Serge Griezmann 360	2002-06-12	Forward	170	Left	Senegal
361	Lionel Bastoni 361	2005-11-15	Defender	181	Right	England
362	Virgil Junior 362	2002-04-27	Defender	183	Left	Japan
363	Casemiro Haaland 363	2000-07-17	Defender	185	Left	Argentina
364	Jan Ronaldo 364	1995-03-26	Defender	190	Left	Sweden
365	Leroy Martinez 365	1998-05-02	Defender	174	Right	Morocco
366	Rodri Silva 366	1996-06-17	Forward	176	Left	Mexico
367	Khvicha Leao 367	1995-08-27	Forward	187	Right	Netherlands
368	Jamal Fernandes 368	1996-12-30	Forward	193	Left	Turkey
369	Marquinhos Martinez 369	2002-10-31	Defender	186	Right	Spain
370	Christopher Partey 370	1998-07-04	Defender	193	Right	Belgium
371	Erling Rashford 371	2001-02-04	Defender	175	Left	Argentina
372	Alisson Donnarumma 372	2001-09-20	Midfielder	171	Right	Chile
373	Leroy Alvarez 373	1996-10-01	Defender	183	Left	Norway
374	Cristiano Oblak 374	2002-10-21	Midfielder	186	Left	Mexico
375	Aurelien Leao 375	2005-12-06	Forward	188	Left	Croatia
376	Marcus Kolo Muani 376	2001-02-07	Forward	176	Left	Scotland
377	Ronald Silva 377	1996-11-30	Defender	185	Left	Morocco
378	Federico Tonali 378	1999-01-08	Midfielder	173	Left	Portugal
379	Kevin Araujo 379	2001-05-07	Forward	177	Right	France
380	Kim Alvarez 380	1998-09-30	Midfielder	191	Left	Colombia
381	Mike Gundogan 381	2002-08-24	Midfielder	175	Right	Japan
382	Ederson Partey 382	2000-04-26	Midfielder	181	Right	Austria
383	Aurelien Courtois 383	2003-09-11	Midfielder	184	Right	Germany
384	Virgil Lewandowski 384	2004-07-18	Forward	178	Right	Ivory Coast
385	Bukayo Hernandez 385	1997-07-06	Midfielder	178	Right	Argentina
386	Marquinhos Messi 386	1996-11-22	Midfielder	170	Left	Japan
387	Julian Musiala 387	1996-09-03	Forward	185	Left	Poland
388	Serge Tchouameni 388	2004-09-25	Midfielder	188	Right	Norway
389	Reece Haaland 389	1999-07-11	Defender	191	Left	Norway
390	Ruben Kane 390	2005-02-22	Midfielder	176	Right	Norway
391	Rafael De Bruyne 391	1997-10-18	Midfielder	188	Left	Poland
392	Lionel Diaz 392	1996-12-13	Midfielder	178	Left	USA
393	Federico Griezmann 393	1998-03-21	Defender	178	Right	Senegal
394	Lautaro De Bruyne 394	2000-11-10	Defender	189	Left	Turkey
395	Marcus Alexander-Arnold 395	1997-03-13	Midfielder	181	Left	Netherlands
396	Enzo Fernandez 396	2005-02-19	Midfielder	190	Left	USA
397	Antoine Barella 397	1999-09-28	Defender	185	Right	Nigeria
398	Luis Kolo Muani 398	2003-07-06	Defender	179	Left	Brazil
399	Eder Davies 399	1997-11-15	Midfielder	176	Right	Netherlands
400	Khvicha Dias 400	2005-01-25	Midfielder	187	Left	Egypt
401	Eduardo Gnabry 401	2004-12-16	Defender	178	Left	Senegal
402	Ousmane Odegaard 402	2005-02-01	Midfielder	180	Left	Germany
403	Robert Kolo Muani 403	2002-09-04	Defender	182	Right	Chile
404	Lautaro Saliba 404	2005-06-16	Defender	195	Right	Portugal
405	Kevin Mbappe 405	2004-02-01	Defender	191	Left	Belgium
406	Luka Moraes 406	2001-05-24	Forward	187	Left	Mexico
407	Ilkay Valverde 407	2000-12-29	Defender	183	Right	Portugal
408	Rafael Saliba 408	1998-09-22	Forward	178	Left	Egypt
409	William Ronaldo 409	1995-04-07	Forward	174	Right	Colombia
410	Alphonso Goretzka 410	1997-05-22	Defender	179	Right	Austria
411	Vinicius Sane 411	2004-04-05	Midfielder	173	Right	Spain
412	Ruben Grealish 412	1999-09-10	Defender	185	Right	Netherlands
413	Martin Nkunku 413	2001-10-21	Forward	189	Left	Morocco
414	Marquinhos Kolo Muani 414	2005-01-26	Forward	181	Left	Ivory Coast
415	Kim White 415	2000-05-12	Forward	184	Right	England
416	Nicolo Coman 416	2002-09-02	Midfielder	171	Left	USA
417	Khvicha Mac Allister 417	1996-12-21	Forward	180	Right	Brazil
418	Aurelien Kolo Muani 418	2001-10-03	Forward	183	Left	Israel
419	Marquinhos Hakimi 419	2005-09-30	Midfielder	183	Right	Japan
420	Christopher Sane 420	2003-07-02	Midfielder	170	Left	Belgium
421	Khvicha Fernandez 421	1999-03-15	Forward	185	Left	Spain
422	Neymar Kane 422	1999-09-08	Midfielder	180	Left	Turkey
423	Gabriel Maignan 423	1997-02-28	Forward	188	Right	Italy
424	Darwin Fernandez 424	1998-11-14	Forward	174	Left	Turkey
425	Ousmane Upamecano 425	1999-04-20	Forward	178	Right	USA
426	Martin Haaland 426	2003-10-03	Forward	183	Right	Germany
427	Ronald Tonali 427	1997-07-06	Defender	194	Right	Turkey
428	Joshua Salah 428	2003-11-14	Forward	170	Left	Portugal
429	Leon Nkunku 429	1995-04-08	Defender	172	Left	France
430	Martin Moraes 430	2002-02-05	Midfielder	172	Left	Brazil
431	Serge Donnarumma 431	2001-03-04	Defender	189	Right	Portugal
432	Khvicha Oblak 432	2002-01-10	Forward	189	Right	Netherlands
433	Erling Sane 433	1999-09-10	Defender	178	Left	Norway
434	Alexis Kolo Muani 434	2000-10-30	Forward	186	Right	Senegal
435	Marcus Tchouameni 435	2005-01-31	Midfielder	171	Left	Sweden
436	Alisson Junior 436	2000-01-05	Forward	187	Right	France
437	Victor Min-jae 437	1996-04-21	Midfielder	192	Right	Ivory Coast
438	Dayot Neuer 438	1998-07-28	Forward	187	Left	Morocco
439	Federico Messi 439	1998-02-17	Defender	179	Right	Japan
440	Leon Gnabry 440	1998-07-16	Defender	179	Right	Portugal
441	Luka Kimmich 441	2004-02-09	Forward	174	Right	USA
442	Bukayo De Bruyne 442	1998-02-03	Forward	184	Right	Ivory Coast
443	Eduardo Modric 443	2001-05-06	Midfielder	194	Left	Italy
444	Ruben Messi 444	2003-08-11	Defender	189	Right	Spain
445	Kingsley Salah 445	2005-08-07	Forward	186	Left	Turkey
446	Kim Courtois 446	2004-10-16	Defender	179	Left	Italy
447	Harry Ronaldo 447	2001-05-29	Defender	186	Left	Portugal
448	Federico Fernandez 448	2003-09-26	Defender	195	Right	Italy
449	Ruben Rice 449	1997-03-05	Forward	183	Right	Scotland
450	Kim White 450	2000-06-10	Defender	187	Left	Brazil
451	Bruno Messi 451	1997-11-22	Defender	174	Right	USA
452	Virgil Kolo Muani 452	1997-02-04	Midfielder	175	Left	Poland
453	Pedri Saliba 453	1995-06-05	Midfielder	193	Left	Japan
454	Julian De Bruyne 454	2000-08-20	Midfielder	188	Right	Turkey
455	Nicolo Tchouameni 455	1995-07-02	Midfielder	178	Left	Japan
456	Ronald Barella 456	1997-09-14	Forward	195	Right	England
457	Martin Rashford 457	1997-02-22	Midfielder	177	Right	Mexico
458	Jack Kolo Muani 458	2001-09-30	Forward	174	Right	Turkey
459	Achraf Kane 459	1999-04-08	Midfielder	170	Right	Belgium
460	Randal Grealish 460	1996-06-28	Defender	178	Right	Belgium
461	Darwin Silva 461	2001-09-03	Forward	170	Right	Chile
462	Trent Tchouameni 462	1996-12-24	Defender	191	Left	Poland
463	Eduardo Modric 463	1995-04-27	Midfielder	187	Left	Portugal
464	Lionel Lewandowski 464	1997-01-04	Defender	176	Right	Belgium
465	Marcus Diaz 465	2002-05-31	Forward	179	Right	Nigeria
466	Reece Militao 466	1995-06-10	Forward	184	Right	Egypt
467	Jan Diaz 467	2005-02-18	Defender	191	Right	Austria
468	Aurelien Coman 468	2001-11-24	Defender	189	Right	Senegal
469	Luka Junior 469	2004-06-04	Defender	172	Right	Poland
470	Marcus Kane 470	2001-11-14	Midfielder	173	Right	Ivory Coast
471	Antoine Mac Allister 471	2005-07-13	Forward	192	Right	Japan
472	Dusan Kimmich 472	2002-10-26	Defender	177	Left	Ivory Coast
473	Phil Silva 473	2002-04-07	Midfielder	171	Left	Morocco
474	Mohamed Maignan 474	1999-04-09	Midfielder	195	Left	USA
475	Virgil Junior 475	1997-05-03	Midfielder	192	Right	Colombia
476	Jamal Neuer 476	2000-11-12	Midfielder	183	Left	Colombia
477	Federico Araujo 477	1995-07-27	Forward	175	Left	Brazil
478	Eduardo Camavinga 478	1997-10-10	Forward	182	Left	Austria
479	Alisson Grealish 479	2000-03-08	Defender	170	Left	USA
480	Theo Salah 480	2002-09-21	Midfielder	170	Right	France
481	Rafael Lewandowski 481	1998-08-15	Forward	194	Right	Nigeria
482	Eder Tchouameni 482	2001-04-18	Forward	194	Left	Austria
483	Leon Messi 483	2002-01-31	Forward	171	Right	France
484	Phil Min-jae 484	2001-07-29	Midfielder	178	Left	Italy
485	Ilkay Rice 485	2001-08-25	Defender	172	Right	Austria
486	Bernardo Mac Allister 486	1998-01-14	Midfielder	189	Right	Spain
487	Mohamed Sane 487	2001-07-26	Midfielder	180	Right	Spain
488	Robert Kolo Muani 488	2004-05-27	Defender	192	Left	Germany
489	Jan Kvaratskhelia 489	2003-09-23	Midfielder	189	Right	Belgium
490	Enzo Grealish 490	2001-12-16	Defender	183	Left	Brazil
491	Federico Min-jae 491	1996-10-01	Forward	180	Right	Norway
492	Federico Grealish 492	2004-10-29	Defender	188	Right	Scotland
493	Victor Moraes 493	2000-05-09	Defender	182	Left	Croatia
494	Bukayo Hakimi 494	2001-08-24	Defender	192	Left	Mexico
495	Thibaut Alvarez 495	1996-10-09	Defender	178	Right	Ivory Coast
496	Mike Junior 496	1997-01-06	Midfielder	184	Right	Brazil
497	Jamal Moraes 497	1995-06-02	Forward	193	Left	Croatia
498	Eder Coman 498	2003-05-03	Forward	184	Right	Mexico
499	Robert Tchouameni 499	2003-02-02	Midfielder	190	Right	USA
500	Ronald Tonali 500	2001-08-08	Midfielder	178	Right	Morocco
501	Victor James 501	1997-03-09	Forward	181	Left	Egypt
502	Leroy Fernandez 502	1995-06-23	Midfielder	181	Right	Italy
503	Darwin Junior 503	2005-06-24	Forward	182	Right	Croatia
504	Randal Maignan 504	2004-10-09	Defender	177	Right	Belgium
505	Gianluigi Bastoni 505	1999-05-14	Midfielder	176	Left	Japan
506	Kingsley Leao 506	1998-10-01	Forward	192	Left	Egypt
507	Trent Rashford 507	1999-03-28	Defender	179	Left	Netherlands
508	Randal Oblak 508	2004-04-19	Forward	183	Right	Croatia
509	Manuel White 509	2003-03-08	Midfielder	171	Left	Morocco
510	Neymar Leao 510	1997-08-27	Defender	173	Right	England
511	Cristiano Militao 511	2001-08-03	Defender	175	Left	England
512	Kylian Kolo Muani 512	1999-11-09	Forward	194	Right	USA
513	Joshua Rashford 513	2005-08-12	Midfielder	172	Right	Egypt
514	Gianluigi Ronaldo 514	1995-08-05	Midfielder	181	Left	Sweden
515	Achraf Bellingham 515	2000-09-08	Defender	172	Right	Japan
516	Robert Rashford 516	2001-11-04	Defender	176	Left	Colombia
517	Dusan White 517	2001-01-07	Defender	183	Left	Senegal
518	Alphonso Alexander-Arnold 518	2004-10-21	Midfielder	174	Left	Morocco
519	Nicolo Rice 519	2003-03-30	Defender	174	Left	Ivory Coast
520	Marcus Leao 520	2005-06-18	Midfielder	195	Left	Austria
521	Joshua Fernandes 521	2001-12-12	Forward	188	Left	France
522	Ruben Gnabry 522	1995-03-15	Defender	181	Left	Netherlands
523	Victor Sane 523	2004-12-21	Forward	177	Right	Scotland
524	Victor Junior 524	2000-10-28	Defender	184	Right	Morocco
525	Jude Maignan 525	1999-10-23	Forward	175	Left	Argentina
526	Jude Gundogan 526	1997-05-18	Defender	191	Left	Ivory Coast
527	Eder Rashford 527	1995-08-19	Midfielder	187	Right	Japan
528	Jude Valverde 528	2003-12-13	Forward	183	Right	Morocco
529	Federico Kimmich 529	2004-11-26	Defender	192	Left	Austria
530	Jamal Diaz 530	2005-03-05	Forward	184	Right	Germany
531	Ronald Becker 531	2002-09-05	Defender	189	Left	Portugal
532	Sandro Musiala 532	1999-12-14	Defender	175	Right	Japan
533	Alisson Moraes 533	2001-04-14	Defender	178	Right	Italy
534	Mike White 534	2001-01-03	Defender	194	Right	Italy
535	Erling White 535	1996-11-18	Midfielder	181	Left	Senegal
536	Achraf Odegaard 536	1996-02-04	Forward	194	Right	Mexico
537	Virgil Musiala 537	1998-12-03	Defender	185	Left	Nigeria
538	Bernardo Ronaldo 538	1999-04-28	Forward	175	Left	Ivory Coast
539	Antoine Upamecano 539	2002-05-18	Defender	171	Left	Belgium
540	Leon Min-jae 540	1996-08-09	Midfielder	183	Right	Nigeria
541	Sandro Kolo Muani 541	2001-02-14	Defender	194	Left	Croatia
542	Jamal Courtois 542	1997-01-18	Midfielder	193	Right	Sweden
543	Lionel Leao 543	2003-08-25	Forward	185	Right	Germany
544	Ousmane Sane 544	1995-11-24	Forward	174	Right	Croatia
545	William Davies 545	2000-05-13	Forward	181	Right	Colombia
546	Mike Sane 546	1998-08-19	Midfielder	185	Right	Sweden
547	Luis Leao 547	2005-02-25	Forward	195	Left	Chile
548	Jamal Coman 548	1998-01-02	Forward	176	Left	Poland
549	Joshua Lewandowski 549	2001-03-02	Defender	171	Right	Colombia
550	Alisson Grealish 550	2000-01-15	Midfielder	189	Right	Ivory Coast
551	Randal Mac Allister 551	1998-10-23	Midfielder	194	Right	Japan
552	Alexis Kane 552	2004-02-05	Midfielder	171	Left	Mexico
553	Marquinhos Courtois 553	2003-09-16	Forward	172	Right	Netherlands
554	Alexis van Dijk 554	2000-12-13	Forward	191	Right	France
555	Rodri James 555	2002-12-31	Forward	178	Right	Italy
556	Kingsley Barella 556	2003-08-17	Midfielder	194	Left	Japan
557	Mohamed Silva 557	1995-04-02	Forward	178	Left	Portugal
558	Phil Militao 558	1996-07-01	Defender	176	Left	Spain
559	Mohamed Mbappe 559	2003-08-26	Midfielder	171	Left	Netherlands
560	Eder Fernandez 560	2003-02-18	Midfielder	176	Right	Chile
561	Reece Nunez 561	1998-09-29	Forward	186	Left	Colombia
562	Randal Kolo Muani 562	2001-10-28	Forward	179	Right	Norway
563	Victor Courtois 563	1997-03-09	Defender	180	Left	Chile
564	Serge Diaz 564	1997-12-18	Forward	192	Right	Sweden
565	Theo Vlahovic 565	1998-11-02	Defender	170	Right	Turkey
566	Reece Camavinga 566	2000-04-18	Forward	193	Left	Brazil
567	Manuel Alexander-Arnold 567	2005-01-06	Defender	171	Right	Mexico
568	Jack Barella 568	1997-10-19	Midfielder	192	Left	Belgium
569	Gabriel Tonali 569	1999-09-30	Defender	187	Right	Senegal
570	Jude Fernandes 570	2003-04-11	Midfielder	173	Left	Colombia
571	Antoine Moraes 571	1996-08-24	Forward	180	Left	Colombia
572	Nicolo Camavinga 572	2001-02-11	Forward	190	Left	Egypt
573	Kevin Tonali 573	1995-11-05	Defender	180	Right	England
574	Pedri Camavinga 574	2005-08-01	Forward	180	Left	France
575	Casemiro Osimhen 575	2005-10-06	Forward	171	Left	Belgium
576	Randal White 576	1998-02-23	Defender	188	Left	Colombia
577	Virgil Ronaldo 577	2002-03-09	Forward	174	Left	USA
578	Nicolo Sane 578	2005-11-23	Midfielder	182	Left	France
579	Manuel Barella 579	1997-04-10	Defender	180	Left	Spain
580	Pedri Davies 580	2002-01-28	Forward	177	Right	Egypt
581	Joshua Courtois 581	2003-05-04	Forward	174	Left	Chile
582	Leroy Courtois 582	2004-05-02	Forward	193	Right	Portugal
583	Randal Donnarumma 583	2001-04-03	Forward	186	Left	France
584	Marcus Vlahovic 584	2000-05-29	Midfielder	180	Right	Morocco
585	Alexis Tonali 585	1999-06-29	Midfielder	195	Left	Argentina
586	Joshua Martinez 586	2000-08-19	Midfielder	176	Left	Italy
587	Ronald White 587	1997-05-10	Midfielder	174	Left	Mexico
588	Bukayo Bellingham 588	1995-07-02	Forward	170	Right	Morocco
589	Rodri Saka 589	2004-08-17	Forward	190	Right	Japan
590	Bernardo Saliba 590	1995-05-22	Midfielder	181	Right	Germany
591	Lionel Salah 591	1996-09-06	Defender	176	Right	Belgium
592	Bernardo Saliba 592	1995-04-12	Midfielder	170	Left	Belgium
593	Lautaro Rashford 593	2001-11-04	Midfielder	183	Right	England
594	Darwin Militao 594	2001-09-15	Defender	179	Left	Colombia
595	Kim Mbappe 595	1995-10-03	Forward	186	Left	Brazil
596	Victor Haaland 596	2001-01-07	Forward	184	Right	Austria
597	Aurelien Oblak 597	1995-04-25	Midfielder	171	Left	Ivory Coast
598	Federico Junior 598	1998-03-10	Midfielder	172	Left	Scotland
599	Vinicius Silva 599	1998-10-25	Forward	173	Left	Japan
600	Christopher Upamecano 600	1997-03-06	Defender	193	Right	USA
601	Ousmane Donnarumma 601	2005-11-10	Midfielder	191	Right	Morocco
602	Aurelien Ronaldo 602	1997-06-02	Midfielder	173	Left	Sweden
603	Rafael Araujo 603	2002-12-05	Forward	190	Left	Ivory Coast
604	Casemiro Mac Allister 604	2001-09-10	Defender	172	Left	Austria
605	Ilkay Foden 605	1995-09-29	Midfielder	179	Left	England
606	Aurelien Becker 606	2000-09-04	Defender	183	Left	Austria
607	Enzo Rodri 607	2004-11-27	Forward	177	Right	Egypt
608	Luis Hernandez 608	2000-12-23	Forward	193	Left	Austria
609	Lautaro Rice 609	2002-07-29	Forward	186	Right	Netherlands
610	Marquinhos Goretzka 610	1996-07-23	Forward	175	Left	Colombia
611	Martin Griezmann 611	2000-11-20	Midfielder	178	Right	Norway
612	Kevin James 612	1995-03-11	Midfielder	173	Left	Egypt
613	Marquinhos Rashford 613	2001-06-24	Midfielder	183	Left	France
614	Lautaro Haaland 614	2000-07-06	Forward	177	Left	France
615	Eduardo Saka 615	2003-09-10	Defender	189	Right	Turkey
616	Eduardo Barella 616	1998-02-03	Defender	189	Left	France
617	Dayot Osimhen 617	1996-07-25	Defender	185	Right	France
618	Khvicha Fernandez 618	1997-10-09	Forward	190	Right	Brazil
619	Aurelien Odegaard 619	1995-10-08	Midfielder	185	Right	France
620	Nicolo Rodri 620	2003-07-19	Forward	187	Left	Italy
621	Bernardo Messi 621	1998-05-11	Defender	184	Left	Morocco
622	Julian Hernandez 622	1996-12-11	Forward	177	Right	Belgium
623	Ruben Rice 623	1997-01-13	Defender	194	Right	Italy
624	Kevin Martinez 624	2000-12-06	Forward	194	Right	Portugal
625	Kylian Donnarumma 625	1997-02-05	Defender	179	Right	Israel
626	Bukayo Foden 626	1997-04-10	Forward	176	Left	Senegal
627	Nicolo Gundogan 627	1996-06-25	Midfielder	185	Right	Senegal
628	Victor Saka 628	2004-06-05	Forward	195	Right	Argentina
629	Eder Dembele 629	1996-10-15	Defender	186	Left	Ivory Coast
630	Dayot Bastoni 630	2004-04-11	Midfielder	176	Right	Morocco
631	Rafael Maignan 631	2001-06-20	Defender	174	Right	Austria
632	Bernardo Moraes 632	1995-12-14	Midfielder	171	Right	Colombia
633	Lautaro Saka 633	2002-03-06	Forward	176	Right	Morocco
634	Lionel Saka 634	1996-12-01	Midfielder	182	Left	Israel
635	Lautaro Valverde 635	2005-09-14	Midfielder	191	Left	France
636	Robert Martinez 636	2000-06-23	Midfielder	171	Right	Ivory Coast
637	Federico Hakimi 637	2001-12-14	Midfielder	182	Left	Turkey
638	Marcus Mbappe 638	2000-02-21	Midfielder	189	Left	Belgium
639	Serge Coman 639	2003-06-05	Defender	170	Right	Colombia
640	Erling Lewandowski 640	2005-07-01	Forward	176	Left	Spain
641	Virgil Silva 641	2001-12-17	Midfielder	180	Left	Scotland
642	Leon Becker 642	2004-12-22	Midfielder	191	Left	Nigeria
643	Reece Ronaldo 643	1995-06-10	Midfielder	176	Left	Poland
644	Ronald Barella 644	2003-03-09	Defender	174	Left	Argentina
645	Marquinhos Rice 645	2002-08-26	Defender	175	Left	Norway
646	Luis Foden 646	1998-02-14	Defender	184	Right	Portugal
647	Eduardo Martinez 647	1998-09-15	Forward	178	Left	France
648	Joshua Maignan 648	2001-04-09	Defender	189	Right	Scotland
649	Lionel Fernandez 649	1995-06-03	Midfielder	183	Left	Egypt
650	Gabriel Kolo Muani 650	2004-10-16	Midfielder	171	Right	Germany
651	Leon Leao 651	1997-04-04	Forward	187	Left	England
652	Alisson Alexander-Arnold 652	1998-07-24	Midfielder	173	Right	Turkey
653	Rafael Fernandez 653	2002-07-27	Forward	195	Left	Egypt
654	Sandro Oblak 654	1997-04-21	Defender	177	Right	Israel
655	Declan Fernandes 655	2001-06-10	Forward	190	Left	Norway
656	Marcus Saka 656	2005-04-06	Midfielder	183	Left	Morocco
657	Victor van Dijk 657	2002-12-24	Defender	173	Right	Netherlands
658	Thibaut Lewandowski 658	1997-02-02	Forward	188	Left	Croatia
659	William Musiala 659	1995-02-05	Defender	177	Right	Sweden
660	Manuel Moraes 660	2005-03-01	Forward	170	Right	Turkey
661	Leon Modric 661	1998-08-07	Midfielder	193	Right	Belgium
662	Ederson Salah 662	2003-08-13	Midfielder	195	Right	Poland
663	Ruben Vlahovic 663	2003-02-12	Defender	182	Left	Croatia
664	Manuel Diaz 664	2001-09-04	Forward	181	Left	Nigeria
665	Thibaut Musiala 665	1999-04-14	Midfielder	177	Right	Sweden
666	Serge De Bruyne 666	1997-05-28	Defender	187	Left	Senegal
667	Randal Rashford 667	2001-12-30	Forward	174	Right	Germany
668	Eder Salah 668	1998-08-28	Forward	174	Left	Portugal
669	Pedri Neuer 669	2005-01-10	Defender	182	Left	Nigeria
670	Martin Moraes 670	1998-08-12	Forward	175	Right	Turkey
671	Eduardo Bastoni 671	1999-06-14	Forward	171	Left	USA
672	Jack Lewandowski 672	1995-05-26	Defender	177	Left	Egypt
673	Robert Militao 673	2004-11-22	Defender	174	Right	Senegal
674	Enzo Becker 674	2005-12-10	Forward	195	Right	Ivory Coast
675	Kingsley Junior 675	2001-10-11	Midfielder	187	Right	Italy
676	Cristiano Saliba 676	2002-07-27	Defender	191	Right	Turkey
677	Bukayo Mac Allister 677	1999-10-14	Forward	170	Left	Italy
678	Joshua Tchouameni 678	1996-04-23	Forward	191	Left	Norway
679	Alphonso Hernandez 679	2001-09-10	Midfielder	192	Left	Mexico
680	Bruno Griezmann 680	2000-09-15	Defender	192	Right	Portugal
681	Mohamed Alvarez 681	2004-01-09	Midfielder	180	Left	Germany
682	Ederson Becker 682	1998-08-09	Defender	170	Left	Portugal
683	Jack Bellingham 683	2002-05-26	Defender	177	Right	Spain
684	Sandro Kimmich 684	2005-06-19	Defender	192	Right	France
685	Casemiro De Bruyne 685	2001-09-18	Midfielder	183	Left	Turkey
686	Victor Griezmann 686	2004-03-09	Forward	181	Right	France
687	Jude De Bruyne 687	2004-05-02	Forward	193	Left	Mexico
688	Kim Kolo Muani 688	2001-10-04	Defender	185	Left	Portugal
689	Joshua Diaz 689	1996-06-17	Midfielder	193	Left	Netherlands
690	Trent Junior 690	1995-05-19	Midfielder	177	Left	Argentina
691	Gianluigi De Bruyne 691	2004-10-01	Defender	184	Right	Argentina
692	Pedri Kolo Muani 692	1996-11-14	Midfielder	184	Left	Nigeria
693	Robert Oblak 693	2004-06-10	Midfielder	192	Left	Austria
694	Ilkay Nkunku 694	2004-07-12	Midfielder	188	Right	England
695	Federico Rodri 695	2001-03-27	Midfielder	187	Right	Scotland
696	Federico Lewandowski 696	2004-01-18	Forward	184	Left	Morocco
697	Harry Modric 697	2004-11-18	Defender	182	Left	Japan
698	Reece Saka 698	1998-01-27	Forward	195	Right	USA
699	Harry Silva 699	2001-06-28	Defender	189	Left	Norway
700	Martin Min-jae 700	2001-06-20	Midfielder	183	Left	Sweden
701	Kylian Camavinga 701	1999-11-19	Defender	185	Left	Norway
702	Luka Sane 702	1996-07-03	Forward	178	Left	USA
703	Ruben Davies 703	1998-02-28	Defender	177	Right	Senegal
704	Randal Oblak 704	1997-11-17	Midfielder	189	Right	Croatia
705	Rodri Grealish 705	2005-06-15	Defender	177	Left	Portugal
706	Robert Maignan 706	2002-06-29	Midfielder	191	Right	Morocco
707	Jamal Davies 707	2001-06-23	Midfielder	192	Right	Argentina
708	Sandro Barella 708	2000-07-14	Defender	170	Left	Turkey
709	Antoine Goretzka 709	2000-02-19	Forward	193	Right	Colombia
710	Pedri Kane 710	2003-06-09	Forward	170	Right	Nigeria
711	Dusan Rashford 711	2001-12-23	Forward	178	Left	Austria
712	Cristiano Upamecano 712	1996-07-07	Midfielder	174	Left	Netherlands
713	Marcus Gnabry 713	2005-10-16	Midfielder	182	Left	Norway
714	Bernardo Griezmann 714	2002-05-25	Forward	171	Right	Argentina
715	Kingsley Maignan 715	1998-11-28	Forward	188	Left	Egypt
716	Ruben Vlahovic 716	2001-04-13	Forward	170	Right	Sweden
717	Martin Grealish 717	1997-05-15	Defender	181	Right	Poland
718	Rodri Vlahovic 718	1998-01-12	Defender	180	Right	Germany
719	Erling Gnabry 719	1997-02-13	Midfielder	186	Right	Senegal
720	Erling White 720	1997-08-03	Midfielder	176	Left	Austria
721	Sandro Sane 721	2002-04-10	Defender	183	Right	Germany
722	Luis Saka 722	2002-06-20	Forward	193	Left	Turkey
723	Eduardo Maignan 723	1999-04-09	Defender	170	Right	Ivory Coast
724	Harry Kvaratskhelia 724	2001-11-20	Forward	195	Left	USA
725	Rodri Gundogan 725	2003-01-11	Defender	192	Right	England
726	Marcus Mac Allister 726	1997-10-23	Midfielder	187	Right	Germany
727	Jude Davies 727	2005-09-19	Forward	172	Right	USA
728	Martin Partey 728	1996-06-06	Defender	174	Right	Mexico
729	Martin Kvaratskhelia 729	1996-12-30	Defender	193	Right	Ivory Coast
730	Harry Sane 730	2002-09-17	Forward	186	Left	Mexico
731	Vinicius Sane 731	2004-06-29	Defender	187	Left	Italy
732	Ederson Moraes 732	1998-07-22	Forward	173	Right	Portugal
733	Alisson Musiala 733	1996-05-19	Forward	192	Right	Chile
734	Gabriel Diaz 734	1996-10-07	Midfielder	195	Right	Norway
735	Enzo Fernandez 735	1996-09-28	Forward	193	Left	Colombia
736	Kylian Rashford 736	2004-09-23	Forward	181	Right	Poland
737	Randal Foden 737	2000-04-24	Defender	179	Left	Brazil
738	Alphonso Becker 738	2005-03-20	Forward	183	Right	Mexico
739	Joshua Dembele 739	1997-01-14	Defender	175	Right	Morocco
740	Antoine Saliba 740	2001-07-03	Forward	195	Right	Spain
741	Harry Tonali 741	1998-10-21	Defender	184	Right	Scotland
742	Lautaro Fernandez 742	2005-09-11	Forward	192	Right	France
743	Christopher Salah 743	2000-10-22	Midfielder	171	Right	Argentina
744	Joshua Tonali 744	1995-12-10	Defender	184	Left	Ivory Coast
745	Sandro Gundogan 745	1997-06-23	Defender	173	Right	Portugal
746	Mohamed Hakimi 746	2001-05-24	Forward	190	Left	Egypt
747	Alphonso Fernandez 747	1996-10-08	Defender	191	Left	Argentina
748	Ilkay Martinez 748	2005-04-17	Midfielder	189	Left	Belgium
749	Marcus Bellingham 749	2000-02-17	Midfielder	188	Right	Portugal
750	Trent Oblak 750	1995-02-10	Defender	172	Left	Croatia
751	Gianluigi Fernandez 751	2000-01-20	Midfielder	172	Left	Croatia
752	Kim Hakimi 752	1998-01-26	Midfielder	184	Left	Nigeria
753	Alphonso Fernandez 753	2005-08-02	Forward	180	Left	Turkey
754	Harry Dembele 754	2002-02-06	Forward	192	Left	Italy
755	Antoine Kvaratskhelia 755	2003-08-18	Defender	172	Left	England
756	Virgil Griezmann 756	2000-07-28	Midfielder	175	Left	Portugal
757	Phil Leao 757	2003-02-21	Defender	173	Right	Germany
758	Gabriel Kimmich 758	1997-01-04	Forward	191	Left	France
759	Bernardo Moraes 759	1997-12-23	Defender	190	Right	Austria
760	Randal Hakimi 760	2002-08-29	Forward	194	Right	Chile
761	Gabriel Kane 761	2005-09-30	Defender	190	Right	Nigeria
762	Sandro Camavinga 762	1995-08-30	Midfielder	188	Right	Croatia
763	Christopher Tchouameni 763	1998-04-20	Forward	189	Left	Austria
764	Mohamed Maignan 764	2001-09-09	Forward	184	Left	Nigeria
765	Manuel Junior 765	2000-04-23	Midfielder	173	Left	Netherlands
766	Alexis Hernandez 766	2000-12-10	Forward	174	Left	Japan
767	Gabriel Hernandez 767	1998-07-25	Defender	188	Right	Mexico
768	Dusan Rodri 768	1996-09-09	Defender	189	Left	Senegal
769	Joshua Dembele 769	2003-04-15	Forward	194	Right	Norway
770	Vinicius Coman 770	2002-10-08	Midfielder	188	Right	Spain
771	Mohamed Bastoni 771	2000-01-10	Forward	174	Left	Norway
772	Marcus Bellingham 772	2005-11-28	Defender	180	Right	Germany
773	Leon Kane 773	2001-04-15	Defender	191	Right	Mexico
774	Manuel Donnarumma 774	1998-05-28	Defender	179	Right	Austria
775	Achraf Valverde 775	2000-04-07	Forward	194	Left	Ivory Coast
776	Kim Silva 776	1999-12-14	Defender	184	Right	Chile
777	Christopher Donnarumma 777	1995-04-19	Defender	170	Left	Morocco
778	Pedri Fernandez 778	2001-05-05	Defender	176	Right	Nigeria
779	Victor Hernandez 779	2004-04-27	Midfielder	182	Right	England
780	Bruno Vlahovic 780	2005-01-11	Defender	173	Right	Israel
781	Victor Mbappe 781	2004-11-08	Defender	178	Right	Mexico
782	Eder Odegaard 782	2005-10-16	Defender	186	Right	USA
783	Ilkay Maignan 783	2004-10-16	Forward	183	Right	Colombia
784	Declan Donnarumma 784	2001-11-28	Forward	179	Right	Egypt
785	Sandro Donnarumma 785	2004-03-14	Forward	186	Right	Argentina
786	Serge Odegaard 786	1998-09-01	Defender	179	Left	Argentina
787	Gabriel Oblak 787	2001-05-06	Defender	178	Right	Netherlands
788	Ilkay Silva 788	1998-10-11	Midfielder	171	Right	Portugal
789	Enzo Modric 789	2004-02-16	Forward	181	Right	Croatia
790	Federico Griezmann 790	2001-09-24	Forward	172	Right	Japan
791	Rodri White 791	1995-10-14	Defender	194	Left	Sweden
792	Ilkay Courtois 792	1995-03-10	Defender	170	Left	Mexico
793	Theo Valverde 793	2003-02-15	Defender	172	Right	Brazil
794	Dayot Fernandez 794	2000-07-04	Defender	193	Right	Nigeria
795	Darwin Grealish 795	2004-02-01	Forward	191	Right	Turkey
796	Leroy Bastoni 796	1999-07-17	Defender	192	Left	Colombia
797	Kylian Vlahovic 797	1995-08-05	Midfielder	193	Right	Austria
798	Virgil Mac Allister 798	1995-01-17	Forward	188	Right	Egypt
799	Bernardo Kolo Muani 799	2005-05-09	Defender	177	Right	Senegal
800	Khvicha Odegaard 800	2000-04-09	Defender	190	Left	Croatia
801	Victor Dias 801	2005-10-23	Defender	185	Left	Turkey
802	Jude Fernandez 802	2000-07-29	Defender	188	Left	Colombia
803	Julian Haaland 803	2004-04-24	Midfielder	181	Left	Spain
804	Reece Sane 804	2004-06-24	Midfielder	194	Left	Italy
805	Casemiro Kvaratskhelia 805	2005-09-20	Midfielder	179	Left	Turkey
806	Mohamed Rashford 806	2001-02-04	Midfielder	194	Left	Norway
807	Vinicius Saka 807	2002-03-17	Defender	183	Left	Portugal
808	Jude Bastoni 808	2005-05-16	Forward	175	Right	England
809	Dayot Gundogan 809	2004-08-19	Midfielder	176	Right	Croatia
810	William Hernandez 810	2000-06-24	Midfielder	192	Right	USA
811	Leroy Oblak 811	1997-12-06	Midfielder	176	Right	USA
812	Manuel Griezmann 812	1997-10-13	Forward	172	Left	Croatia
813	William James 813	1995-09-17	Forward	183	Left	Austria
814	Robert Musiala 814	2002-11-10	Forward	172	Left	Italy
815	Bukayo Donnarumma 815	1995-01-04	Forward	188	Left	Croatia
816	Serge Kolo Muani 816	1999-10-15	Midfielder	171	Right	England
817	Martin Partey 817	2004-03-27	Defender	195	Left	Spain
818	Aurelien Salah 818	2003-05-29	Defender	183	Right	Spain
819	Bernardo Fernandez 819	2003-09-04	Forward	195	Left	Morocco
820	Gabriel Kimmich 820	1999-06-15	Defender	181	Right	Spain
821	Joshua Dias 821	1998-01-15	Midfielder	182	Right	Colombia
822	Kingsley Kolo Muani 822	1998-08-06	Midfielder	172	Right	Japan
823	Kim Foden 823	2001-07-02	Midfielder	174	Left	USA
824	Dusan Davies 824	2001-12-03	Forward	191	Right	Portugal
825	Kylian Goretzka 825	2003-07-31	Forward	193	Left	Croatia
826	Leroy van Dijk 826	2001-12-07	Forward	183	Right	Poland
827	Achraf Silva 827	2003-08-28	Forward	171	Right	Italy
828	Ronald Mbappe 828	1995-01-13	Defender	189	Left	Norway
829	Jack Foden 829	2005-08-12	Defender	181	Right	Colombia
830	Manuel Courtois 830	1996-08-14	Defender	176	Left	Mexico
831	Leroy Barella 831	1995-09-21	Defender	193	Left	Scotland
832	Gabriel Partey 832	2004-10-20	Forward	191	Right	France
833	Aurelien Nkunku 833	1999-01-05	Forward	195	Left	Norway
834	Julian James 834	1996-06-08	Forward	174	Left	Japan
835	Theo Martinez 835	1998-11-03	Defender	184	Left	Colombia
836	Jude Saliba 836	2002-12-13	Midfielder	189	Left	Turkey
837	Randal Foden 837	2000-05-09	Midfielder	182	Right	Scotland
838	Jamal Junior 838	2004-08-30	Midfielder	176	Right	Croatia
839	Virgil Fernandez 839	2001-10-28	Forward	192	Left	Colombia
840	Jude Hernandez 840	1997-01-12	Midfielder	192	Right	Croatia
841	Manuel Bastoni 841	1997-11-02	Forward	189	Left	England
842	Jack Saliba 842	2005-07-14	Midfielder	191	Right	USA
843	Theo Alexander-Arnold 843	1998-06-27	Defender	184	Right	USA
844	Marcus Mbappe 844	1998-10-08	Midfielder	190	Left	Turkey
845	Luis Donnarumma 845	1995-04-01	Defender	179	Left	Israel
846	Theo Odegaard 846	2005-04-25	Defender	172	Left	Norway
847	Casemiro Alexander-Arnold 847	1997-04-01	Midfielder	190	Right	Japan
848	Dayot Kolo Muani 848	1997-04-01	Defender	187	Left	Italy
849	Kim De Bruyne 849	2002-07-17	Midfielder	184	Left	Egypt
850	Cristiano van Dijk 850	2004-12-26	Forward	181	Left	Belgium
851	Joshua Maignan 851	1998-06-11	Forward	177	Left	Brazil
852	Declan Davies 852	2004-08-02	Forward	175	Left	Brazil
853	Luka Kolo Muani 853	1996-04-10	Midfielder	171	Right	Ivory Coast
854	Jan Salah 854	2003-10-29	Defender	187	Left	England
855	Theo White 855	1995-04-30	Forward	186	Right	Germany
856	Theo Modric 856	2001-10-02	Midfielder	191	Left	Israel
857	Harry Neuer 857	1996-08-01	Midfielder	174	Left	Brazil
858	Martin Camavinga 858	2003-11-15	Defender	176	Left	Argentina
859	Cristiano Upamecano 859	1997-03-06	Defender	194	Right	Ivory Coast
860	Eduardo Junior 860	2004-09-29	Forward	172	Left	Spain
861	Eduardo Kolo Muani 861	2004-07-18	Defender	178	Left	Senegal
862	Aurelien Moraes 862	1995-02-14	Midfielder	172	Right	England
863	Virgil Nkunku 863	2000-07-24	Midfielder	181	Left	Croatia
864	Thibaut Kvaratskhelia 864	1996-08-04	Midfielder	191	Left	Israel
865	Marquinhos Nunez 865	2000-04-05	Forward	170	Left	Egypt
866	Casemiro Becker 866	1998-06-30	Forward	189	Left	Senegal
867	Achraf Odegaard 867	2000-10-21	Midfielder	176	Right	Ivory Coast
868	Kevin Partey 868	1999-05-01	Midfielder	193	Right	Belgium
869	Luis Ronaldo 869	1998-09-07	Defender	188	Left	Scotland
870	Erling Oblak 870	1996-09-23	Midfielder	194	Right	Nigeria
871	Christopher Griezmann 871	2001-10-18	Forward	183	Right	Spain
872	Virgil Becker 872	1998-06-03	Forward	173	Left	Austria
873	Nicolo Dias 873	2001-06-08	Midfielder	186	Left	Germany
874	Ilkay Dembele 874	1998-05-24	Midfielder	189	Right	Scotland
875	Marquinhos De Bruyne 875	2000-03-26	Defender	173	Left	Ivory Coast
876	Victor Davies 876	2002-09-22	Midfielder	173	Right	Senegal
877	Sandro Araujo 877	2004-04-05	Midfielder	186	Right	Norway
878	Cristiano Tchouameni 878	1999-11-23	Midfielder	194	Right	Sweden
879	Gianluigi Courtois 879	2003-09-17	Forward	178	Right	Netherlands
880	Serge Camavinga 880	1997-04-29	Midfielder	181	Left	Poland
881	Julian Ronaldo 881	2003-02-23	Defender	173	Right	Chile
882	Phil Rice 882	2005-01-26	Midfielder	175	Left	Germany
883	Reece Grealish 883	2002-02-07	Midfielder	173	Left	Belgium
884	Alphonso Alexander-Arnold 884	1998-04-09	Defender	170	Right	Spain
885	Declan Odegaard 885	2001-08-06	Midfielder	195	Left	Morocco
886	Casemiro Bastoni 886	2002-11-06	Forward	171	Right	Nigeria
887	Eder Fernandez 887	1996-10-13	Midfielder	195	Right	Croatia
888	Kingsley Grealish 888	2000-08-23	Forward	173	Right	Belgium
889	Eder Min-jae 889	1996-12-06	Defender	192	Right	Turkey
890	Serge Hernandez 890	1995-12-06	Defender	176	Left	Chile
891	Rodri Goretzka 891	1995-04-25	Midfielder	174	Right	Mexico
892	Bruno Rodri 892	1996-04-14	Forward	177	Left	USA
893	Gabriel Barella 893	2004-02-24	Forward	185	Right	Israel
894	Leroy Salah 894	1998-10-07	Midfielder	184	Left	Japan
895	Declan Vlahovic 895	1996-10-20	Forward	190	Left	Netherlands
896	Jan Martinez 896	2001-01-30	Defender	195	Left	Nigeria
897	Theo Haaland 897	1998-06-12	Forward	187	Left	Brazil
898	Khvicha De Bruyne 898	2000-01-24	Forward	172	Right	Turkey
899	Randal Upamecano 899	1996-01-02	Midfielder	171	Left	Israel
900	Jamal Vlahovic 900	2001-09-15	Defender	189	Left	Austria
901	Lautaro Kvaratskhelia 901	1996-09-16	Midfielder	176	Right	Spain
902	Rafael Fernandez 902	2003-11-30	Midfielder	175	Right	Colombia
903	Kylian Valverde 903	2001-04-04	Midfielder	184	Right	Nigeria
904	Ilkay Araujo 904	2000-04-29	Defender	180	Left	Senegal
905	Rafael Militao 905	2003-03-18	Defender	174	Right	Ivory Coast
906	Thibaut Griezmann 906	1997-12-06	Defender	171	Right	France
907	Theo Saka 907	1997-05-16	Defender	184	Right	Italy
908	Serge White 908	2003-03-11	Midfielder	192	Right	Mexico
909	Alisson Camavinga 909	2002-03-10	Midfielder	182	Right	Austria
910	Ruben Goretzka 910	1998-01-06	Midfielder	174	Left	France
911	Leon Mbappe 911	1995-11-05	Midfielder	188	Left	Italy
912	Harry Camavinga 912	1996-08-27	Defender	181	Left	Israel
913	Manuel White 913	1999-05-02	Midfielder	173	Right	Germany
914	Virgil Tchouameni 914	2004-06-05	Defender	186	Right	Brazil
915	Bruno Min-jae 915	2004-04-09	Forward	172	Right	Senegal
916	Rafael Maignan 916	1998-07-11	Forward	186	Left	Argentina
917	Darwin Maignan 917	1995-09-28	Midfielder	188	Right	Brazil
918	Leroy Hakimi 918	2001-08-19	Defender	187	Right	Senegal
919	Luka Rice 919	2003-09-20	Defender	172	Right	Poland
920	Ederson Musiala 920	1998-04-29	Defender	174	Left	Egypt
921	Declan Fernandes 921	1997-11-01	Forward	195	Left	Morocco
922	Robert Salah 922	2005-12-10	Defender	171	Left	Chile
923	Ousmane Gnabry 923	2003-06-24	Forward	182	Right	Israel
924	Eder Davies 924	1999-10-15	Forward	173	Right	Senegal
925	Alexis Sane 925	2000-07-17	Midfielder	179	Right	Portugal
926	Dayot Moraes 926	2000-09-15	Forward	180	Left	Argentina
927	Alisson Donnarumma 927	1999-03-08	Defender	181	Right	Brazil
928	Julian White 928	2002-02-02	Defender	194	Right	Chile
929	Achraf Coman 929	1997-01-01	Midfielder	193	Left	Scotland
930	Rafael Saliba 930	2000-09-09	Forward	185	Right	Japan
931	Bernardo Kvaratskhelia 931	2002-02-17	Midfielder	183	Right	Netherlands
932	Alexis Osimhen 932	1998-02-13	Defender	178	Right	Japan
933	Robert Rodri 933	2001-07-07	Defender	186	Right	Brazil
934	Jack Araujo 934	2005-04-29	Midfielder	188	Left	Morocco
935	Darwin Upamecano 935	1995-07-26	Defender	177	Left	Germany
936	Virgil Kvaratskhelia 936	1996-02-21	Forward	192	Right	Chile
937	Manuel Davies 937	1998-09-09	Midfielder	174	Right	Colombia
938	Khvicha Fernandes 938	1997-10-19	Midfielder	192	Right	Turkey
939	Bernardo Maignan 939	1997-01-09	Defender	181	Right	Japan
940	Eder Rice 940	2005-05-08	Forward	178	Right	Colombia
941	Enzo Alexander-Arnold 941	2005-09-08	Forward	179	Left	Italy
942	Lautaro Becker 942	1996-12-03	Defender	190	Right	Brazil
943	Neymar Gnabry 943	1996-01-10	Defender	194	Right	Israel
944	Jamal Upamecano 944	2005-11-06	Midfielder	170	Right	Sweden
945	Erling Goretzka 945	2004-07-23	Forward	188	Right	Portugal
946	Vinicius Barella 946	1999-09-15	Midfielder	177	Right	Egypt
947	Joshua Vlahovic 947	2001-08-28	Midfielder	176	Left	Senegal
948	Rodri Fernandes 948	1999-08-26	Midfielder	177	Left	Israel
949	Eder Tchouameni 949	1995-02-13	Forward	191	Right	Egypt
950	Julian Fernandez 950	2000-10-15	Midfielder	186	Left	Argentina
951	Eder Nkunku 951	1998-08-20	Defender	179	Right	Ivory Coast
952	Khvicha Rashford 952	1998-08-12	Defender	180	Left	Croatia
953	Nicolo Becker 953	2001-11-08	Forward	184	Right	Ivory Coast
954	Harry Tchouameni 954	2005-08-01	Midfielder	179	Left	Chile
955	Enzo Dias 955	1997-02-24	Forward	181	Left	Netherlands
956	Ousmane Gnabry 956	2003-09-13	Forward	189	Right	Austria
957	Declan Kimmich 957	2001-08-18	Defender	183	Left	Japan
958	Luka Gundogan 958	2003-12-04	Midfielder	187	Right	Israel
959	Bruno Junior 959	1996-03-05	Forward	195	Left	Israel
960	Bernardo Sane 960	2005-01-13	Defender	192	Right	Egypt
961	Darwin Camavinga 961	2004-11-02	Forward	177	Right	Japan
962	Kingsley Tchouameni 962	1997-02-25	Forward	184	Right	Germany
963	Eder Alvarez 963	1996-05-03	Forward	175	Left	USA
964	Manuel Rashford 964	2001-04-11	Defender	181	Right	Colombia
965	Casemiro Vlahovic 965	2002-05-21	Defender	172	Left	Poland
966	Thibaut Oblak 966	2005-10-17	Forward	176	Left	Morocco
967	Marquinhos Silva 967	2002-08-22	Midfielder	175	Left	Netherlands
968	Eduardo Kane 968	2000-10-06	Forward	176	Right	Ivory Coast
969	Neymar Coman 969	2005-02-11	Defender	175	Right	Italy
970	Manuel Silva 970	2004-12-12	Forward	178	Right	Egypt
971	Ronald Oblak 971	2004-01-26	Forward	175	Right	Germany
972	Serge Fernandez 972	2004-08-22	Defender	182	Left	Poland
973	Jamal Silva 973	1999-10-29	Defender	171	Left	Brazil
974	Randal Kimmich 974	1998-07-29	Forward	181	Left	Chile
975	Ruben Mac Allister 975	2005-09-22	Midfielder	188	Left	Netherlands
976	Marcus Becker 976	1998-11-25	Midfielder	183	Left	Poland
977	Bruno Upamecano 977	2004-04-22	Forward	188	Left	Japan
978	Gianluigi Martinez 978	1996-08-07	Forward	183	Right	Norway
979	Luka Rice 979	2001-01-29	Defender	193	Right	Netherlands
980	Enzo Araujo 980	1995-02-07	Midfielder	183	Left	Ivory Coast
981	Enzo Mac Allister 981	1997-09-09	Forward	191	Left	Italy
982	Alphonso Maignan 982	2003-07-13	Forward	184	Right	Morocco
983	Mike Rashford 983	1995-05-20	Midfielder	186	Left	Italy
984	Rodri Salah 984	2001-05-24	Defender	174	Left	Turkey
985	Gabriel Musiala 985	2003-01-12	Defender	183	Left	Austria
986	Sandro Courtois 986	2004-07-17	Defender	188	Left	Brazil
987	Marcus Dembele 987	2004-12-22	Defender	174	Right	Mexico
988	Kylian Hernandez 988	1996-10-15	Forward	191	Right	Netherlands
989	Luis Foden 989	2002-12-07	Midfielder	174	Left	Germany
990	Luka James 990	2002-04-13	Forward	171	Right	Brazil
991	Marquinhos Modric 991	2004-07-25	Forward	180	Right	Mexico
992	Gabriel Valverde 992	2002-10-25	Forward	177	Right	Croatia
993	Bruno Tchouameni 993	2005-08-08	Forward	192	Left	Israel
994	Thibaut Donnarumma 994	2001-10-21	Midfielder	193	Left	Egypt
995	Martin Militao 995	2005-10-12	Forward	192	Right	Austria
996	Luis Militao 996	1998-01-21	Forward	178	Left	Brazil
997	Bruno Mac Allister 997	2001-11-15	Defender	179	Left	Netherlands
998	Bruno Araujo 998	1998-07-08	Forward	187	Right	Mexico
999	Jude Grealish 999	1997-07-14	Defender	193	Right	Chile
1000	Dusan Araujo 1000	1996-04-26	Forward	192	Left	Brazil
1001	Jamal Messi 1001	1995-07-25	Forward	192	Left	Egypt
1002	Leroy Nkunku 1002	2002-04-12	Forward	181	Right	Sweden
1003	Martin Mbappe 1003	2001-12-21	Midfielder	185	Left	Austria
1004	Serge Saka 1004	1998-07-25	Defender	192	Left	Brazil
1005	Declan Hernandez 1005	2000-08-18	Midfielder	174	Left	Croatia
1006	Jamal Maignan 1006	2004-04-27	Forward	177	Left	Croatia
1007	Luka Barella 1007	2001-09-10	Defender	189	Right	Sweden
1008	Lionel Coman 1008	2001-07-31	Midfielder	171	Right	Netherlands
1009	Darwin Militao 1009	1997-06-08	Midfielder	170	Right	Portugal
1010	Eduardo Gnabry 1010	2002-11-30	Defender	191	Left	Senegal
1011	Bukayo Rashford 1011	2004-07-20	Forward	186	Left	England
1012	Gianluigi Dias 1012	2002-11-02	Midfielder	184	Right	Nigeria
1013	Alphonso Fernandes 1013	2002-03-31	Forward	175	Right	Scotland
1014	Pedri Musiala 1014	2002-07-17	Defender	189	Left	Austria
1015	Manuel Diaz 1015	2004-08-30	Forward	193	Left	Austria
1016	Gabriel Alexander-Arnold 1016	1998-08-21	Forward	187	Right	Sweden
1017	Lautaro Nunez 1017	2001-07-26	Defender	175	Left	Belgium
1018	Julian Barella 1018	1999-09-18	Forward	171	Left	Brazil
1019	Antoine Osimhen 1019	1997-09-24	Defender	178	Right	Belgium
1020	Christopher Araujo 1020	2004-05-05	Defender	171	Right	Chile
1021	Bukayo Maignan 1021	1996-09-17	Defender	171	Left	Belgium
1022	Ederson Saka 1022	2005-10-30	Midfielder	174	Right	Austria
1023	Dusan Dembele 1023	2000-10-01	Forward	188	Right	Austria
1024	Marquinhos Partey 1024	1996-09-15	Midfielder	185	Right	France
1025	Rodri Min-jae 1025	1996-02-29	Midfielder	182	Right	Japan
1026	Achraf Kolo Muani 1026	1996-08-18	Midfielder	184	Left	Portugal
1027	Martin Rice 1027	2004-06-16	Defender	173	Right	Egypt
1028	Antoine Maignan 1028	1998-04-01	Midfielder	187	Left	Turkey
1029	Alisson Nunez 1029	1998-11-27	Midfielder	176	Right	Chile
1030	Bruno Alexander-Arnold 1030	1996-05-01	Forward	187	Right	Italy
1031	William Salah 1031	1996-02-21	Midfielder	181	Right	Poland
1032	Achraf Bastoni 1032	1996-02-24	Defender	175	Left	Egypt
1033	Pedri Kvaratskhelia 1033	2005-05-16	Defender	188	Left	Japan
1034	Darwin Rodri 1034	1996-03-01	Defender	181	Right	Croatia
1035	Vinicius Bastoni 1035	1996-11-04	Midfielder	183	Left	Brazil
1036	Ilkay Modric 1036	2002-07-27	Forward	183	Left	Morocco
1037	Enzo Dembele 1037	1998-12-24	Midfielder	176	Right	Austria
1038	Christopher Griezmann 1038	1996-03-06	Midfielder	187	Right	Brazil
1039	Rodri Diaz 1039	2004-11-02	Midfielder	195	Left	USA
1040	Alexis Hakimi 1040	1999-04-02	Midfielder	175	Left	Scotland
1041	Ilkay Musiala 1041	2004-07-17	Midfielder	174	Left	USA
1042	Jan Fernandes 1042	2002-03-04	Defender	189	Left	USA
1043	Lautaro Rice 1043	2001-03-15	Defender	194	Right	Argentina
1044	Antoine Kane 1044	1997-08-28	Forward	190	Right	Netherlands
1045	Jack White 1045	2005-02-11	Defender	183	Right	Ivory Coast
1046	Trent Camavinga 1046	2000-10-19	Midfielder	174	Right	Mexico
1047	Ruben Mbappe 1047	1995-03-03	Defender	185	Left	USA
1048	Reece Tchouameni 1048	2000-04-01	Midfielder	185	Right	Senegal
1049	Reece Foden 1049	1998-09-10	Midfielder	186	Left	Scotland
1050	Bruno Ronaldo 1050	2004-11-27	Defender	176	Left	Nigeria
1051	Neymar Mac Allister 1051	1997-12-05	Defender	183	Right	Sweden
1052	Neymar Neuer 1052	2002-06-16	Forward	195	Right	Ivory Coast
1053	Dayot Becker 1053	2003-01-08	Midfielder	184	Right	Germany
1054	Manuel Davies 1054	1995-05-22	Forward	186	Left	Egypt
1055	Theo Min-jae 1055	2005-11-20	Defender	190	Right	Netherlands
1056	Virgil Moraes 1056	2004-07-30	Defender	177	Left	Belgium
1057	Gianluigi Griezmann 1057	2004-08-18	Midfielder	189	Right	Portugal
1058	Ousmane Kolo Muani 1058	1999-04-01	Defender	184	Right	Norway
1059	Leon Sane 1059	2005-06-24	Defender	175	Left	Chile
1060	Jude Nunez 1060	2001-06-08	Midfielder	193	Right	Israel
1061	Mike Rashford 1061	2000-01-04	Defender	190	Right	Morocco
1062	Gabriel Hernandez 1062	1996-10-25	Forward	175	Left	Spain
1063	Marcus Gnabry 1063	2004-10-01	Midfielder	192	Right	Morocco
1064	Aurelien Fernandes 1064	1997-09-01	Midfielder	190	Right	USA
1065	Mohamed Fernandez 1065	2005-11-28	Forward	191	Right	Nigeria
1066	Luka Saka 1066	1996-04-11	Forward	187	Right	Italy
1067	Kingsley Neuer 1067	1999-11-22	Defender	191	Right	Egypt
1068	Randal Ronaldo 1068	1998-03-15	Forward	195	Left	Croatia
1069	Julian De Bruyne 1069	2002-11-14	Midfielder	189	Left	France
1070	Rafael Gnabry 1070	2000-07-24	Defender	171	Right	Argentina
1071	Theo Coman 1071	1998-03-18	Defender	195	Left	Egypt
1072	Leroy Camavinga 1072	2003-01-04	Midfielder	180	Right	Brazil
1073	Lionel van Dijk 1073	2001-06-20	Defender	179	Left	Croatia
1074	Khvicha Rashford 1074	2000-05-20	Midfielder	194	Right	Austria
1075	Alphonso Neuer 1075	2000-10-04	Forward	194	Right	Norway
1076	Rafael Osimhen 1076	2004-03-27	Midfielder	180	Right	Egypt
1077	Phil Davies 1077	2004-07-30	Defender	178	Left	Scotland
1078	Ilkay Bastoni 1078	1999-06-09	Forward	190	Right	Egypt
1079	Jude James 1079	2004-09-19	Forward	186	Left	Sweden
1080	Mike Salah 1080	1995-12-29	Midfielder	176	Left	Chile
1081	Jan Sane 1081	2000-10-12	Midfielder	178	Left	Croatia
1082	Marquinhos Hakimi 1082	2002-09-23	Defender	191	Right	Ivory Coast
1083	Enzo Vlahovic 1083	1997-10-24	Forward	179	Right	France
1084	Kevin Leao 1084	1997-08-21	Forward	170	Right	Chile
1085	Mike Camavinga 1085	1998-10-17	Defender	195	Left	Poland
1086	Vinicius Lewandowski 1086	1996-06-09	Defender	180	Left	Senegal
1087	Christopher Fernandes 1087	1997-06-02	Forward	195	Right	Belgium
1088	Kim Griezmann 1088	1995-11-11	Defender	184	Right	USA
1089	Marcus Moraes 1089	2004-08-04	Forward	186	Right	Germany
1090	Victor Goretzka 1090	2000-04-26	Defender	180	Right	England
1091	Ilkay Haaland 1091	2002-11-27	Forward	181	Right	Croatia
1092	Erling Courtois 1092	2000-02-06	Forward	177	Left	Argentina
1093	Jude Messi 1093	2002-08-04	Forward	172	Right	Netherlands
1094	Vinicius Ronaldo 1094	2005-07-23	Forward	193	Left	England
1095	Declan Griezmann 1095	2003-09-15	Defender	191	Right	Germany
1096	Mike Moraes 1096	2003-08-09	Defender	186	Right	Croatia
1097	Dayot De Bruyne 1097	2001-08-28	Midfielder	182	Right	Brazil
1098	Jack Hakimi 1098	2005-07-10	Forward	175	Right	Germany
1099	Cristiano Silva 1099	2000-03-10	Defender	178	Left	Germany
1100	Thibaut Leao 1100	2002-05-15	Forward	193	Right	Colombia
1101	Declan Barella 1101	2003-05-13	Forward	194	Left	Argentina
1102	Eduardo Tonali 1102	1995-03-21	Defender	187	Left	Spain
1103	Leon Goretzka 1103	1996-02-22	Forward	176	Left	Nigeria
1104	Gianluigi Leao 1104	2005-07-09	Forward	174	Right	Chile
1105	Ronald White 1105	2004-04-06	Forward	175	Right	Germany
1106	Trent Gundogan 1106	2005-03-24	Midfielder	179	Left	Germany
1107	Neymar James 1107	1999-02-15	Midfielder	181	Right	Turkey
1108	Vinicius Bastoni 1108	2003-04-30	Defender	183	Right	Brazil
1109	Declan Courtois 1109	2004-02-02	Forward	177	Left	Spain
1110	Alisson Ronaldo 1110	2004-02-13	Defender	193	Left	Brazil
1111	Ruben Kolo Muani 1111	2003-05-07	Defender	188	Right	Germany
1112	Declan Hernandez 1112	2000-05-06	Midfielder	179	Left	England
1113	Serge Militao 1113	2005-05-31	Defender	184	Right	England
1114	Jude Partey 1114	1998-03-26	Defender	183	Right	Sweden
1115	Enzo Rice 1115	2001-09-19	Forward	195	Right	Belgium
1116	Leroy Salah 1116	2004-08-21	Forward	191	Right	Japan
1117	Phil De Bruyne 1117	2002-09-19	Midfielder	188	Right	Argentina
1118	Gianluigi Gundogan 1118	1995-02-01	Midfielder	195	Left	Senegal
1119	Gabriel van Dijk 1119	2004-04-07	Midfielder	180	Left	Scotland
1120	Joshua Grealish 1120	2000-08-18	Forward	185	Right	Belgium
1121	Gabriel Fernandez 1121	2005-10-11	Midfielder	193	Right	Nigeria
1122	Ruben Messi 1122	2003-10-20	Defender	184	Right	Ivory Coast
1123	Gianluigi Rice 1123	1995-11-03	Midfielder	181	Right	Belgium
1124	Enzo Maignan 1124	1995-04-27	Forward	172	Left	Morocco
1125	Ederson Griezmann 1125	2002-03-26	Defender	177	Left	Sweden
1126	Casemiro Vlahovic 1126	2001-01-22	Midfielder	181	Left	Ivory Coast
1127	Alphonso Dembele 1127	2002-07-15	Forward	189	Right	Morocco
1128	Alisson Foden 1128	1996-12-19	Defender	170	Right	Netherlands
1129	Rafael Tchouameni 1129	1996-03-06	Defender	174	Right	Morocco
1130	Eduardo Donnarumma 1130	2003-08-30	Defender	170	Right	Croatia
1131	William Modric 1131	1995-07-09	Forward	176	Left	Croatia
1132	Mike Dembele 1132	2004-10-10	Defender	193	Left	Scotland
1133	Jude Fernandes 1133	1999-06-20	Midfielder	186	Right	Japan
1134	Martin Kolo Muani 1134	2004-09-30	Forward	176	Left	Norway
1135	Mike De Bruyne 1135	2000-09-02	Midfielder	171	Right	Senegal
1136	Khvicha White 1136	1997-08-28	Midfielder	188	Right	Scotland
1137	Harry Partey 1137	2001-11-01	Midfielder	184	Right	Poland
1138	Ousmane Davies 1138	1997-02-25	Defender	182	Left	Ivory Coast
1139	Kim Bastoni 1139	2000-12-03	Forward	191	Right	Colombia
1140	Cristiano Min-jae 1140	1995-09-08	Midfielder	173	Left	Egypt
1141	Jan Osimhen 1141	1996-04-25	Forward	193	Left	Ivory Coast
1142	Enzo Barella 1142	2004-07-17	Midfielder	186	Right	Israel
1143	Kylian Camavinga 1143	2000-04-21	Defender	174	Left	Germany
1144	Vinicius Alexander-Arnold 1144	1999-05-27	Midfielder	193	Left	Netherlands
1145	Julian Saka 1145	2005-03-09	Midfielder	192	Left	England
1146	Ruben Oblak 1146	1997-04-21	Defender	187	Right	USA
1147	Federico Ronaldo 1147	1999-09-05	Midfielder	171	Left	Mexico
1148	Luka Camavinga 1148	2001-03-15	Forward	188	Right	Germany
1149	Pedri Kimmich 1149	2000-05-12	Forward	188	Left	Chile
1150	Ousmane Grealish 1150	2005-01-28	Forward	191	Left	Colombia
1151	Cristiano Martinez 1151	2000-08-24	Forward	185	Right	Sweden
1152	Declan Silva 1152	1999-12-24	Forward	189	Left	Scotland
1153	Robert Messi 1153	2000-07-07	Midfielder	188	Right	Colombia
1154	Vinicius Moraes 1154	2000-01-21	Midfielder	184	Left	Portugal
1155	Ousmane White 1155	1997-12-09	Defender	188	Right	Argentina
1156	Alexis Valverde 1156	1995-06-28	Midfielder	195	Left	Nigeria
1157	Erling Lewandowski 1157	2002-11-15	Forward	188	Right	Croatia
1158	Darwin Griezmann 1158	2004-03-25	Forward	189	Right	Argentina
1159	Leon Dembele 1159	2003-09-27	Defender	188	Left	Senegal
1160	Dayot Odegaard 1160	2002-01-29	Defender	184	Right	Spain
1161	Manuel Camavinga 1161	1995-06-19	Defender	191	Right	Scotland
1162	Declan Gnabry 1162	1998-06-09	Defender	182	Right	Austria
1163	Rafael Moraes 1163	2000-07-27	Midfielder	181	Left	Senegal
1164	Enzo Griezmann 1164	1996-08-23	Midfielder	193	Left	Egypt
1165	Vinicius Rodri 1165	1997-03-19	Defender	176	Right	Egypt
1166	Bruno Osimhen 1166	1998-02-12	Defender	189	Right	Senegal
1167	Rafael Osimhen 1167	2002-08-03	Forward	189	Left	Belgium
1168	Aurelien Kane 1168	1999-04-08	Defender	178	Left	Scotland
1169	Jan Dias 1169	2003-11-08	Forward	181	Left	Morocco
1170	Christopher Hernandez 1170	1998-05-25	Forward	172	Left	Nigeria
1171	Pedri Griezmann 1171	2005-07-04	Midfielder	185	Left	Austria
1172	Alisson Valverde 1172	2004-04-20	Defender	176	Right	Colombia
1173	Alexis van Dijk 1173	2005-05-31	Forward	194	Right	Morocco
1174	Kingsley Osimhen 1174	1998-12-22	Defender	179	Right	Austria
1175	Pedri Barella 1175	2002-12-23	Midfielder	178	Left	Colombia
1176	Christopher Dembele 1176	2000-02-12	Defender	174	Left	Norway
1177	Alexis Odegaard 1177	1997-12-02	Midfielder	171	Left	USA
1178	Jamal Leao 1178	1996-03-23	Midfielder	177	Right	Colombia
1179	Marquinhos Sane 1179	1997-05-07	Forward	176	Left	Scotland
1180	Martin Salah 1180	1996-06-29	Defender	177	Right	Nigeria
1181	Harry Militao 1181	2001-02-06	Forward	179	Right	Ivory Coast
1182	Alphonso Grealish 1182	1997-11-06	Defender	186	Left	Senegal
1183	Ruben Camavinga 1183	1999-04-27	Defender	175	Left	USA
1184	Alexis Kvaratskhelia 1184	2004-09-13	Midfielder	193	Left	Belgium
1185	Casemiro Fernandes 1185	1997-05-24	Forward	178	Left	Germany
1186	Theo Gundogan 1186	1998-10-10	Forward	187	Right	Netherlands
1187	Jude van Dijk 1187	2003-01-28	Forward	172	Left	Netherlands
1188	Declan Saliba 1188	2000-12-31	Defender	190	Left	Spain
1189	Gianluigi James 1189	1997-10-21	Midfielder	182	Right	Nigeria
1190	Bernardo Alexander-Arnold 1190	2004-01-08	Midfielder	179	Right	Portugal
1191	Pedri Grealish 1191	2003-03-13	Midfielder	178	Left	Croatia
1192	Jude Bellingham 1192	1999-11-03	Midfielder	183	Left	Spain
1193	Gianluigi Grealish 1193	1996-11-14	Midfielder	185	Left	Colombia
1194	Ronald Oblak 1194	1996-04-09	Midfielder	182	Right	Croatia
1195	Kylian Saliba 1195	2002-06-07	Midfielder	183	Right	Senegal
1196	Jamal Alexander-Arnold 1196	1999-11-12	Midfielder	187	Left	Brazil
1197	Bukayo James 1197	1997-05-28	Forward	171	Right	Argentina
1198	Reece Lewandowski 1198	2002-05-21	Defender	174	Left	Norway
1199	Ruben Nunez 1199	2000-09-03	Defender	178	Right	Egypt
1200	Kevin Mac Allister 1200	2000-04-15	Defender	189	Right	Croatia
1201	Sandro Diaz 1201	2000-06-25	Defender	181	Left	Nigeria
1202	Declan Fernandez 1202	1998-12-08	Forward	188	Right	Sweden
1203	Dusan Hernandez 1203	2002-06-19	Defender	184	Left	Italy
1204	Bruno Courtois 1204	2005-03-08	Forward	191	Left	France
1205	Kevin Courtois 1205	2002-06-07	Forward	176	Left	Scotland
1206	Enzo Diaz 1206	1998-04-21	Defender	192	Left	Netherlands
1207	Enzo Musiala 1207	1999-03-05	Forward	189	Right	Norway
1208	Cristiano Lewandowski 1208	1995-04-04	Forward	178	Left	Sweden
1209	Thibaut Kimmich 1209	2001-12-12	Defender	180	Right	Japan
1210	Serge White 1210	2002-04-24	Midfielder	172	Left	Nigeria
1211	Eduardo Neuer 1211	1996-09-02	Midfielder	177	Right	Mexico
1212	Achraf Ronaldo 1212	1996-07-06	Defender	186	Left	Ivory Coast
1213	Neymar Musiala 1213	2005-08-31	Forward	171	Right	Mexico
1214	Thibaut Upamecano 1214	1997-10-09	Midfielder	194	Left	Mexico
1215	Reece Mbappe 1215	1996-10-08	Defender	195	Left	Croatia
1216	Julian Silva 1216	2000-01-08	Defender	184	Left	France
1217	Declan Courtois 1217	2003-12-28	Defender	192	Right	Chile
1218	Serge Tonali 1218	2003-07-01	Midfielder	189	Left	USA
1219	Marcus Dias 1219	2001-12-15	Forward	177	Right	Ivory Coast
1220	Alisson Barella 1220	2003-12-25	Defender	172	Right	USA
1221	Jude Salah 1221	2000-02-14	Forward	189	Right	Morocco
1222	Gabriel Diaz 1222	1999-02-15	Midfielder	193	Right	England
1223	Erling White 1223	2004-04-21	Midfielder	175	Right	England
1224	Alisson Ronaldo 1224	1996-01-31	Midfielder	190	Left	Netherlands
1225	Alphonso Ronaldo 1225	1999-01-21	Forward	172	Left	Argentina
1226	Virgil Diaz 1226	2005-03-12	Midfielder	187	Left	Spain
1227	Kingsley Fernandes 1227	2002-08-06	Forward	171	Right	Italy
1228	Robert Musiala 1228	1999-04-17	Midfielder	185	Right	Belgium
1229	Eduardo van Dijk 1229	1998-02-08	Midfielder	182	Left	USA
1230	Harry Osimhen 1230	1995-12-23	Midfielder	190	Right	Senegal
1231	Vinicius Militao 1231	2000-05-08	Forward	178	Right	Egypt
1232	Lautaro Griezmann 1232	2000-10-18	Forward	183	Right	Senegal
1233	Rafael Dias 1233	1996-11-11	Defender	175	Right	Poland
1234	Lautaro Kimmich 1234	2001-01-24	Forward	174	Right	Italy
1235	Alphonso Griezmann 1235	1997-07-24	Defender	172	Left	Poland
1236	Antoine James 1236	2000-12-22	Forward	173	Left	Japan
1237	Khvicha Rashford 1237	1997-06-08	Forward	182	Right	Israel
1238	Trent Moraes 1238	1997-08-05	Forward	172	Left	Egypt
1239	Randal Rice 1239	1995-04-27	Defender	185	Left	Germany
1240	Bernardo Moraes 1240	1995-06-26	Midfielder	186	Left	Austria
1241	Thibaut Gnabry 1241	2005-07-06	Midfielder	195	Left	Ivory Coast
1242	Christopher Odegaard 1242	1997-04-09	Defender	186	Right	Italy
1243	Kingsley Modric 1243	2004-07-08	Forward	170	Right	Egypt
1244	Neymar Diaz 1244	2001-06-01	Midfielder	186	Left	Senegal
1245	Gianluigi Goretzka 1245	2004-08-30	Defender	173	Right	USA
1246	Dayot Grealish 1246	1995-06-07	Midfielder	192	Right	Brazil
1247	Jamal Odegaard 1247	1996-11-02	Midfielder	179	Left	Netherlands
1248	Dusan Moraes 1248	1998-01-16	Midfielder	188	Left	Japan
1249	Gabriel Dembele 1249	1998-01-21	Midfielder	184	Right	Egypt
1250	Trent Gundogan 1250	1995-02-03	Midfielder	177	Left	Japan
1251	Vinicius Bellingham 1251	2005-01-01	Midfielder	172	Right	Croatia
1252	Julian Kvaratskhelia 1252	1995-09-01	Forward	186	Right	Croatia
1253	Ilkay Barella 1253	2000-07-21	Forward	192	Right	France
1254	Lautaro Kolo Muani 1254	1998-05-30	Defender	191	Right	Colombia
1255	Jack Modric 1255	1998-02-15	Midfielder	191	Right	Colombia
1256	Serge Partey 1256	2003-07-18	Defender	188	Left	Belgium
1257	Kylian Kolo Muani 1257	2004-02-21	Forward	184	Left	Ivory Coast
1258	Darwin Diaz 1258	1995-02-03	Forward	181	Right	Chile
1259	Theo Tchouameni 1259	1996-09-26	Midfielder	191	Left	Argentina
1260	Gabriel Foden 1260	2004-05-05	Midfielder	180	Right	Colombia
1261	Achraf Tchouameni 1261	1995-07-09	Defender	172	Left	Morocco
1262	Marquinhos Maignan 1262	1998-08-13	Midfielder	182	Right	Chile
1263	Randal Sane 1263	1995-10-29	Midfielder	189	Right	Morocco
1264	Rafael Coman 1264	2002-07-24	Midfielder	195	Right	Sweden
1265	Cristiano Foden 1265	2000-06-21	Defender	190	Left	Poland
1266	Luka Foden 1266	2001-09-02	Forward	192	Right	Chile
1267	Martin Kolo Muani 1267	2002-09-17	Forward	180	Left	Austria
1268	Alexis Bastoni 1268	1999-03-21	Midfielder	189	Left	Turkey
1269	Virgil Sane 1269	2004-10-26	Midfielder	176	Right	Poland
1270	Manuel Dembele 1270	2001-04-27	Midfielder	189	Left	Mexico
1271	Thibaut Partey 1271	1997-08-22	Defender	173	Left	Mexico
1272	Alisson Sane 1272	2000-07-22	Defender	188	Left	Poland
1273	Jamal Goretzka 1273	1999-11-25	Midfielder	183	Left	Brazil
1274	Pedri Rodri 1274	2001-11-16	Forward	185	Left	Israel
1275	Ronald Ronaldo 1275	1996-11-09	Defender	172	Right	Norway
1276	Jack Dembele 1276	1995-02-03	Forward	181	Right	Morocco
1277	Jack Vlahovic 1277	1999-10-01	Defender	176	Right	USA
1278	Ronald Haaland 1278	1995-05-10	Midfielder	181	Right	Chile
1279	Aurelien Saliba 1279	2005-04-10	Midfielder	182	Right	Morocco
1280	Manuel Rice 1280	2001-03-24	Midfielder	183	Left	Sweden
1281	Neymar Min-jae 1281	2002-10-09	Midfielder	171	Left	Japan
1282	Jan Tonali 1282	1999-01-18	Midfielder	193	Right	Portugal
1283	Robert Martinez 1283	2004-11-21	Forward	181	Right	USA
1284	Declan Vlahovic 1284	1997-09-01	Midfielder	184	Left	Portugal
1285	Kevin Upamecano 1285	2000-03-09	Defender	176	Right	Italy
1286	Julian White 1286	1997-04-26	Forward	186	Right	Germany
1287	Lionel Bellingham 1287	1998-03-13	Defender	178	Left	Norway
1288	Kingsley Alexander-Arnold 1288	1995-03-14	Midfielder	171	Right	Senegal
1289	Trent Sane 1289	1995-07-07	Forward	174	Left	England
1290	Theo Partey 1290	2003-11-12	Defender	172	Left	Japan
1291	Rafael Courtois 1291	2002-10-12	Midfielder	195	Left	Netherlands
1292	William Lewandowski 1292	2002-12-22	Forward	176	Right	Austria
1293	Martin Partey 1293	2005-11-01	Forward	189	Right	Sweden
1294	Ederson Valverde 1294	1998-10-10	Midfielder	176	Left	Colombia
1295	Lautaro Alexander-Arnold 1295	1995-11-30	Defender	194	Right	Ivory Coast
1296	Vinicius Alexander-Arnold 1296	1996-08-14	Midfielder	180	Right	Sweden
1297	Dayot Barella 1297	1998-12-22	Midfielder	171	Left	USA
1298	Ronald Dias 1298	1998-01-11	Defender	187	Right	Portugal
1299	Jack Maignan 1299	2004-05-28	Midfielder	172	Left	Brazil
1300	Gabriel Fernandes 1300	1999-12-27	Forward	190	Left	England
1301	Leroy Dembele 1301	1999-07-18	Midfielder	183	Right	Morocco
1302	Dayot Ronaldo 1302	2004-09-24	Defender	172	Right	Colombia
1303	Darwin White 1303	2004-11-24	Forward	177	Left	Scotland
1304	Harry Diaz 1304	2005-09-05	Midfielder	186	Left	Japan
1305	Kylian Grealish 1305	2000-02-18	Defender	172	Left	Argentina
1306	Lionel Maignan 1306	2001-01-31	Midfielder	188	Right	Netherlands
1307	Bernardo Messi 1307	2000-03-04	Forward	179	Right	Egypt
1308	Dusan Oblak 1308	1995-05-17	Forward	190	Right	Brazil
1309	Dusan Kvaratskhelia 1309	2002-12-22	Midfielder	195	Left	Austria
1310	Achraf Becker 1310	1997-06-07	Forward	173	Right	England
1311	Ronald Silva 1311	1997-11-21	Defender	194	Left	Sweden
1312	Rafael Neuer 1312	1995-07-31	Defender	187	Right	Portugal
1313	Leroy Rodri 1313	2001-01-15	Midfielder	172	Left	Turkey
1314	Neymar Rice 1314	1999-01-04	Midfielder	181	Right	Chile
1315	Theo Rodri 1315	1997-07-28	Midfielder	191	Left	Belgium
1316	Sandro Donnarumma 1316	2005-02-14	Defender	194	Right	Austria
1317	Nicolo Modric 1317	2003-06-27	Defender	192	Left	USA
1318	Virgil Salah 1318	1997-04-14	Defender	190	Left	Colombia
1319	Kevin Ronaldo 1319	1997-04-06	Defender	189	Left	Colombia
1320	Erling Hakimi 1320	1999-03-01	Midfielder	172	Right	Italy
1321	Ederson Kimmich 1321	2000-03-24	Forward	187	Left	Poland
1322	Mohamed Upamecano 1322	2004-06-20	Midfielder	185	Left	Austria
1323	Thibaut Upamecano 1323	1996-07-07	Midfielder	173	Right	Norway
1324	Cristiano Saliba 1324	1997-04-08	Midfielder	184	Left	Italy
1325	Kingsley Partey 1325	1999-01-07	Defender	178	Left	Japan
1326	Gianluigi Bastoni 1326	1995-02-17	Forward	173	Right	Nigeria
1327	Nicolo Junior 1327	1995-05-25	Midfielder	176	Left	Poland
1328	Jack Maignan 1328	1996-08-18	Forward	191	Left	Italy
1329	Achraf Camavinga 1329	2000-08-25	Midfielder	172	Left	Senegal
1330	Victor Tonali 1330	1997-02-12	Midfielder	193	Left	Portugal
1331	Antoine Diaz 1331	2004-01-22	Defender	195	Left	USA
1332	Reece Grealish 1332	2005-04-25	Forward	179	Left	Poland
1333	Ronald Osimhen 1333	1997-02-09	Forward	189	Right	Portugal
1334	Khvicha Oblak 1334	2002-06-06	Defender	195	Left	Argentina
1335	Enzo Diaz 1335	1998-05-24	Forward	178	Right	Ivory Coast
1336	Sandro Neuer 1336	1996-01-24	Defender	190	Right	Portugal
1337	Aurelien Partey 1337	2005-10-20	Midfielder	182	Left	Austria
1338	Theo Valverde 1338	1997-11-17	Forward	176	Left	Israel
1339	Eduardo Coman 1339	2003-04-21	Midfielder	192	Left	Croatia
1340	Kim Mbappe 1340	1998-05-20	Defender	192	Left	Chile
1341	Reece Diaz 1341	2004-04-02	Defender	171	Left	Portugal
1342	Thibaut Griezmann 1342	2000-03-12	Defender	182	Left	Belgium
1343	Vinicius Valverde 1343	1998-01-14	Midfielder	190	Left	Israel
1344	Reece Junior 1344	1999-02-15	Forward	178	Left	USA
1345	Marcus Alvarez 1345	1999-05-29	Midfielder	174	Right	USA
1346	Eder Alvarez 1346	2000-05-15	Defender	187	Left	Turkey
1347	Jan Fernandes 1347	2003-03-20	Defender	174	Left	Scotland
1348	Eder Neuer 1348	1998-08-21	Forward	175	Right	Chile
1349	Serge Donnarumma 1349	1998-07-09	Midfielder	188	Left	Japan
1350	Bukayo Kolo Muani 1350	2005-06-18	Forward	188	Right	Sweden
1351	Lautaro van Dijk 1351	2005-09-12	Midfielder	181	Left	Argentina
1352	Lautaro Musiala 1352	2000-04-20	Forward	186	Right	Poland
1353	Gabriel Mac Allister 1353	2005-01-15	Defender	189	Left	Mexico
1354	Theo Gundogan 1354	2000-07-01	Midfielder	171	Left	Turkey
1355	Jude Goretzka 1355	1995-10-28	Midfielder	182	Right	USA
1356	Virgil Militao 1356	2005-07-08	Midfielder	179	Left	Scotland
1357	Lautaro Coman 1357	2002-04-29	Defender	190	Right	Senegal
1358	Serge Davies 1358	2000-03-21	Defender	189	Right	Poland
1359	Marquinhos Rice 1359	1996-01-13	Forward	174	Left	Argentina
1360	Rodri Nunez 1360	1997-12-31	Midfielder	183	Right	Japan
1361	Jack Grealish 1361	1997-08-09	Forward	180	Left	Germany
1362	Ruben Hakimi 1362	2002-09-16	Midfielder	180	Left	Mexico
1363	Mike Saliba 1363	1999-08-15	Midfielder	187	Right	Nigeria
1364	Enzo Foden 1364	2000-04-03	Forward	193	Right	Argentina
1365	Vinicius Fernandez 1365	2004-08-24	Defender	183	Left	Italy
1366	Khvicha Coman 1366	1998-10-18	Defender	184	Right	Brazil
1367	Dusan Vlahovic 1367	2005-07-04	Defender	181	Right	Portugal
1368	Kim Saka 1368	1995-09-06	Defender	172	Right	Austria
1369	Phil Tonali 1369	1995-09-24	Defender	177	Left	Ivory Coast
1370	Victor Bellingham 1370	1999-06-22	Defender	170	Right	Netherlands
1371	Antoine Bellingham 1371	2000-01-07	Defender	185	Left	Japan
1372	Jack Donnarumma 1372	1999-11-24	Forward	195	Left	Germany
1373	Sandro Moraes 1373	2000-06-21	Midfielder	185	Right	Scotland
1374	Lautaro Mbappe 1374	1997-03-12	Midfielder	189	Left	Egypt
1375	Trent Valverde 1375	1998-10-30	Forward	178	Right	Germany
1376	Jude Musiala 1376	1995-09-09	Defender	182	Right	Portugal
1377	Ruben Griezmann 1377	1997-11-29	Defender	176	Left	Japan
1378	Eduardo Alexander-Arnold 1378	2004-11-18	Defender	190	Left	Israel
1379	Jude Mac Allister 1379	2004-10-20	Forward	181	Right	Sweden
1380	Antoine Rodri 1380	1999-09-20	Defender	180	Right	Chile
1381	Eder Griezmann 1381	2005-05-30	Midfielder	185	Right	France
1382	Marcus Griezmann 1382	1997-12-24	Defender	182	Left	USA
1383	Leroy Hernandez 1383	1997-05-29	Defender	193	Left	Croatia
1384	Virgil Dembele 1384	2002-10-09	Defender	195	Left	Japan
1385	Antoine Saka 1385	2001-02-04	Midfielder	178	Right	Chile
1386	Sandro Kvaratskhelia 1386	2004-08-18	Midfielder	171	Left	Italy
1387	Dayot Fernandes 1387	2001-11-22	Midfielder	185	Right	Italy
1388	Alexis Partey 1388	1998-05-03	Defender	188	Right	Brazil
1389	Ederson Fernandes 1389	1999-04-25	Forward	190	Left	Norway
1390	Leon Salah 1390	1999-02-13	Defender	192	Left	England
1391	Rodri Kane 1391	2002-03-25	Midfielder	179	Left	Netherlands
1392	Julian Davies 1392	2005-05-14	Defender	193	Right	England
1393	Martin Saliba 1393	1998-01-02	Forward	183	Right	Nigeria
1394	Enzo Kane 1394	1999-02-28	Midfielder	188	Left	USA
1395	Sandro Bastoni 1395	1999-03-28	Forward	175	Right	Israel
1396	Cristiano White 1396	2003-04-21	Midfielder	188	Left	Belgium
1397	Achraf Min-jae 1397	2002-09-05	Forward	190	Left	Sweden
1398	Ederson Moraes 1398	1997-08-07	Midfielder	181	Left	France
1399	Alexis Tchouameni 1399	2001-11-02	Midfielder	185	Left	Ivory Coast
1400	Bukayo Upamecano 1400	1999-12-28	Midfielder	193	Left	Norway
1401	Gianluigi Donnarumma 1401	2000-05-02	Forward	186	Right	Israel
1402	Thibaut Tonali 1402	1995-10-29	Defender	192	Left	Morocco
1403	Alisson Barella 1403	2005-10-30	Midfielder	170	Left	Croatia
1404	Neymar Dembele 1404	1996-02-09	Midfielder	172	Left	USA
1405	Alphonso Mac Allister 1405	2004-11-25	Forward	193	Left	Belgium
1406	Kim Partey 1406	2001-12-01	Midfielder	190	Right	Poland
1407	Kevin Tchouameni 1407	2003-02-04	Defender	192	Left	Netherlands
1408	Eder Saliba 1408	1995-04-20	Midfielder	174	Left	Senegal
1409	Gabriel Tonali 1409	1999-11-01	Defender	187	Right	Mexico
1410	Gianluigi Courtois 1410	2000-01-08	Midfielder	189	Left	Argentina
1411	Federico James 1411	2003-04-02	Forward	185	Left	Turkey
1412	Bukayo Araujo 1412	1997-06-08	Forward	194	Right	Italy
1413	Alisson Saka 1413	2005-08-20	Defender	180	Right	Chile
1414	Virgil Nunez 1414	2004-06-21	Forward	183	Right	France
1415	Manuel Haaland 1415	2001-10-31	Defender	187	Right	Mexico
1416	Manuel James 1416	1997-05-15	Midfielder	189	Right	Netherlands
1417	Ousmane Hernandez 1417	2001-01-25	Forward	176	Right	Belgium
1418	Erling Hernandez 1418	1995-01-12	Defender	175	Left	Sweden
1419	Pedri Dembele 1419	2003-09-09	Defender	192	Left	Chile
1420	Jamal Araujo 1420	2001-11-18	Defender	174	Right	Netherlands
1421	Ousmane Kimmich 1421	2000-02-10	Defender	185	Right	Poland
1422	Antoine Dembele 1422	2004-09-29	Midfielder	178	Right	Nigeria
1423	Leon Dias 1423	2001-05-15	Defender	178	Right	Poland
1424	Rodri Fernandez 1424	1995-07-30	Forward	190	Left	Japan
1425	Eder Haaland 1425	1999-12-05	Midfielder	190	Left	Colombia
1426	Ruben Mac Allister 1426	2003-01-04	Defender	195	Left	Scotland
1427	Luka Bastoni 1427	1998-04-30	Forward	186	Right	USA
1428	Gianluigi Musiala 1428	2004-12-28	Midfielder	184	Left	Austria
1429	Enzo Militao 1429	2000-06-08	Defender	182	Left	Poland
1430	Marquinhos Barella 1430	2003-09-15	Forward	178	Right	Belgium
1431	Mohamed Tonali 1431	2004-01-11	Forward	194	Left	Brazil
1432	Jude Hakimi 1432	2000-04-07	Defender	180	Left	Chile
1433	Federico Nkunku 1433	1998-02-23	Midfielder	194	Left	Ivory Coast
1434	Kevin Kvaratskhelia 1434	2004-09-26	Defender	189	Left	Nigeria
1435	Nicolo Grealish 1435	2005-08-02	Forward	180	Right	Nigeria
1436	Lionel Gundogan 1436	1997-03-06	Defender	180	Left	Poland
1437	Dayot Griezmann 1437	2000-07-12	Defender	172	Left	Sweden
1438	Eder Leao 1438	2004-09-04	Midfielder	188	Right	Nigeria
1439	Randal De Bruyne 1439	2000-08-02	Forward	188	Left	Portugal
1440	Julian Tchouameni 1440	1999-06-25	Forward	190	Right	Egypt
1441	Gabriel Moraes 1441	1995-01-17	Midfielder	187	Right	Egypt
1442	Rafael Tchouameni 1442	2001-01-05	Defender	180	Right	Egypt
1443	Erling Salah 1443	2002-12-13	Defender	170	Left	Scotland
1444	Bernardo Nunez 1444	1995-11-06	Forward	173	Left	Turkey
1445	Virgil Min-jae 1445	2004-03-01	Defender	190	Right	Poland
1446	Kingsley Rashford 1446	1998-02-18	Defender	194	Left	Chile
1447	Thibaut Alvarez 1447	2000-01-06	Forward	190	Left	Croatia
1448	Thibaut Foden 1448	1997-08-02	Midfielder	181	Right	Mexico
1449	Ruben Kolo Muani 1449	2001-02-02	Defender	185	Left	Poland
1450	Darwin Foden 1450	1998-08-16	Midfielder	175	Right	Spain
1451	Ederson Saka 1451	1996-01-23	Midfielder	190	Left	Belgium
1452	Ilkay Goretzka 1452	1999-02-15	Defender	183	Right	Netherlands
1453	Serge Bastoni 1453	1995-06-30	Forward	174	Left	Norway
1454	Nicolo Coman 1454	1999-10-28	Defender	192	Right	France
1455	Serge Ronaldo 1455	2003-06-13	Midfielder	193	Right	Scotland
1456	William Saliba 1456	2004-04-08	Defender	183	Right	Germany
1457	Phil Nunez 1457	1998-11-16	Defender	191	Right	Colombia
1458	Gabriel Moraes 1458	2002-01-28	Midfielder	190	Left	Austria
1459	Mike Junior 1459	1996-04-29	Forward	174	Right	Norway
1460	Thibaut Griezmann 1460	1996-07-28	Defender	177	Left	Colombia
1461	Mike Kolo Muani 1461	2003-05-24	Forward	192	Right	Ivory Coast
1462	Alexis Foden 1462	2005-10-04	Midfielder	178	Left	England
1463	Alphonso White 1463	2000-08-03	Defender	192	Right	Israel
1464	Gianluigi Modric 1464	1999-02-17	Forward	170	Left	Poland
1465	Eder Junior 1465	2001-08-29	Defender	190	Left	Norway
1466	Erling Becker 1466	2005-02-25	Defender	170	Left	Chile
1467	Luka James 1467	1999-12-21	Forward	185	Left	Egypt
1468	Jan Donnarumma 1468	2001-08-31	Forward	188	Right	Germany
1469	Vinicius Saliba 1469	2005-07-20	Midfielder	186	Right	Germany
1470	Nicolo Haaland 1470	1996-08-25	Defender	182	Right	Belgium
1471	Neymar Fernandez 1471	2000-05-02	Defender	193	Left	Nigeria
1472	Lautaro James 1472	2003-09-21	Forward	179	Right	Croatia
1473	Eder Tonali 1473	2004-03-03	Defender	186	Left	Austria
1474	Robert Junior 1474	2000-02-18	Midfielder	175	Right	Germany
1475	Randal Modric 1475	1995-07-01	Midfielder	178	Right	Scotland
1476	Enzo Diaz 1476	2004-04-12	Defender	195	Right	Argentina
1477	Joshua Fernandez 1477	1999-04-04	Midfielder	172	Left	Nigeria
1478	Julian Moraes 1478	1995-05-27	Defender	192	Left	Germany
1479	Jamal Partey 1479	1998-09-18	Midfielder	184	Left	Germany
1480	Harry Coman 1480	1998-10-12	Defender	185	Right	Colombia
1481	Julian Vlahovic 1481	2005-07-24	Defender	172	Right	France
1482	Eduardo Becker 1482	2002-01-14	Midfielder	189	Right	Brazil
1483	Mohamed Bastoni 1483	1999-07-17	Forward	184	Right	Egypt
1484	Neymar Neuer 1484	2002-04-24	Defender	184	Right	Turkey
1485	Ederson Musiala 1485	2004-01-22	Midfielder	190	Right	England
1486	Serge Dias 1486	2004-04-27	Forward	186	Right	Ivory Coast
1487	Declan Alvarez 1487	1998-01-07	Midfielder	193	Right	Germany
1488	Mohamed Goretzka 1488	1996-11-22	Forward	182	Right	Senegal
1489	Alphonso Martinez 1489	1995-04-01	Defender	181	Right	Argentina
1490	Harry Bastoni 1490	2005-12-14	Defender	180	Right	Germany
1491	Kingsley Alexander-Arnold 1491	1995-11-02	Midfielder	185	Right	Germany
1492	Rodri Nkunku 1492	1996-08-03	Forward	192	Left	Brazil
1493	Alexis Modric 1493	2003-11-22	Midfielder	193	Left	Nigeria
1494	Rafael Alvarez 1494	1996-06-30	Midfielder	170	Right	France
1495	Casemiro Valverde 1495	1998-09-19	Defender	184	Right	Japan
1496	Dayot Nunez 1496	2001-08-29	Defender	192	Right	Poland
1497	Jack Neuer 1497	2003-11-18	Midfielder	175	Right	Brazil
1498	Cristiano Lewandowski 1498	2004-07-24	Defender	193	Right	Netherlands
1499	Victor Salah 1499	1997-08-21	Midfielder	191	Right	Egypt
1500	Dusan Sane 1500	1995-02-09	Forward	176	Right	Belgium
1501	Eder Grealish 1501	1995-10-05	Midfielder	171	Left	Ivory Coast
1502	Luka van Dijk 1502	1996-09-30	Forward	187	Right	England
1503	Ruben Haaland 1503	1996-03-09	Defender	184	Left	Argentina
1504	Casemiro Donnarumma 1504	2002-01-24	Midfielder	179	Right	Netherlands
1505	Jamal Lewandowski 1505	1995-04-18	Midfielder	191	Right	Scotland
1506	Aurelien Hernandez 1506	2005-04-11	Midfielder	171	Left	Sweden
1507	Achraf Ronaldo 1507	2000-08-10	Forward	195	Right	Italy
1508	Mohamed Ronaldo 1508	2002-12-16	Defender	188	Right	England
1509	Bukayo Becker 1509	2004-02-08	Forward	193	Right	Argentina
1510	Julian Gundogan 1510	1997-01-30	Forward	188	Left	Brazil
1511	Lionel van Dijk 1511	1997-11-10	Midfielder	177	Left	Croatia
1512	Bukayo Dias 1512	1996-07-13	Forward	195	Left	Poland
1513	Thibaut Nunez 1513	2000-11-23	Defender	188	Right	Portugal
1514	Dayot Vlahovic 1514	1996-07-17	Forward	176	Right	Turkey
1515	Thibaut Davies 1515	2001-11-05	Defender	180	Right	USA
1516	Ruben Coman 1516	2005-07-15	Forward	183	Right	Croatia
1517	Neymar Mbappe 1517	1996-06-25	Defender	190	Right	Turkey
1518	Bukayo Ronaldo 1518	1999-12-29	Defender	178	Right	Israel
1519	Luka Nunez 1519	2003-09-07	Forward	170	Right	Argentina
1520	Thibaut Silva 1520	1997-08-05	Midfielder	182	Left	Germany
1521	Eduardo Salah 1521	1998-04-10	Defender	174	Left	Sweden
1522	Virgil Camavinga 1522	2005-01-03	Forward	187	Left	Brazil
1523	Antoine Silva 1523	1995-03-15	Defender	173	Right	Italy
1524	Bukayo Donnarumma 1524	1995-02-13	Midfielder	191	Left	Senegal
1525	Kevin Saka 1525	1998-02-07	Forward	195	Right	Croatia
1526	Luis Junior 1526	2000-10-20	Forward	184	Left	Austria
1527	Sandro Bastoni 1527	2003-05-28	Forward	188	Right	Portugal
1528	Cristiano Bastoni 1528	2001-11-30	Forward	171	Right	Chile
1529	Ronald Alexander-Arnold 1529	1997-10-21	Midfielder	184	Right	Morocco
1530	Leroy Donnarumma 1530	2003-02-28	Forward	193	Right	France
1531	Casemiro Coman 1531	2004-07-14	Forward	182	Left	France
1532	Trent De Bruyne 1532	2003-02-10	Forward	195	Right	Egypt
1533	Bukayo Osimhen 1533	1998-02-01	Forward	185	Right	Ivory Coast
1534	Antoine Gundogan 1534	2003-02-13	Defender	176	Right	Ivory Coast
1535	Virgil Martinez 1535	2005-01-18	Forward	192	Right	USA
1536	Eder Alvarez 1536	2002-09-05	Forward	191	Left	Sweden
1537	Joshua Ronaldo 1537	1995-03-01	Forward	190	Right	France
1538	Jan Donnarumma 1538	1999-01-06	Defender	180	Right	France
1539	Rodri Donnarumma 1539	1998-08-18	Forward	175	Right	Mexico
1540	Achraf Min-jae 1540	1995-06-20	Midfielder	181	Right	Morocco
1541	Alphonso Donnarumma 1541	1996-08-22	Midfielder	180	Right	Netherlands
1542	Bernardo Vlahovic 1542	2003-07-28	Forward	175	Right	Chile
1543	Achraf Osimhen 1543	1995-04-25	Forward	190	Left	Belgium
1544	Kevin Foden 1544	2005-05-05	Defender	194	Left	Scotland
1545	Thibaut Upamecano 1545	2004-09-10	Midfielder	185	Left	Netherlands
1546	Federico Tchouameni 1546	2001-08-30	Defender	188	Left	Mexico
1547	Dayot Nkunku 1547	1997-11-12	Defender	176	Left	Morocco
1548	Jan Junior 1548	2003-06-25	Defender	192	Right	Egypt
1549	Marquinhos Mbappe 1549	1998-08-13	Midfielder	181	Left	Netherlands
1550	Ruben Diaz 1550	2004-07-13	Defender	186	Right	USA
1551	Rafael Leao 1551	2003-09-04	Defender	176	Right	Japan
1552	Bruno Nunez 1552	1999-03-16	Forward	170	Right	Scotland
1553	Manuel Salah 1553	1999-02-18	Midfielder	181	Left	Poland
1554	Randal Hakimi 1554	1997-06-15	Midfielder	195	Left	Israel
1555	Victor Ronaldo 1555	1995-09-16	Forward	192	Right	France
1556	Ederson Valverde 1556	2000-10-01	Defender	194	Left	Mexico
1557	Khvicha Foden 1557	1998-10-30	Forward	184	Left	USA
1558	Kylian Donnarumma 1558	2003-12-23	Defender	177	Right	Turkey
1559	Bukayo Alexander-Arnold 1559	2000-06-13	Midfielder	185	Right	Chile
1560	Kim White 1560	1998-09-22	Midfielder	187	Right	Spain
1561	Neymar Sane 1561	2002-06-12	Defender	175	Left	Nigeria
1562	Leon White 1562	2000-05-09	Forward	194	Left	Netherlands
1563	Alexis Valverde 1563	2000-06-02	Midfielder	180	Left	Mexico
1564	Declan Tchouameni 1564	2005-09-25	Midfielder	190	Right	Germany
1565	Casemiro Valverde 1565	2000-10-16	Forward	173	Right	Sweden
1566	Gabriel Saka 1566	2001-04-09	Defender	195	Left	Argentina
1567	Ilkay Davies 1567	2001-04-05	Midfielder	171	Right	Scotland
1568	Jamal Maignan 1568	1997-08-20	Forward	183	Left	Croatia
1569	Jack Leao 1569	1996-07-03	Midfielder	173	Right	France
1570	Lionel Osimhen 1570	1997-08-29	Forward	188	Right	Scotland
1571	Bernardo Bellingham 1571	2000-12-25	Defender	189	Right	Portugal
1572	Kim Upamecano 1572	2003-02-03	Forward	173	Right	Poland
1573	Rodri Kimmich 1573	1998-06-27	Defender	183	Left	Spain
1574	Eder Odegaard 1574	1995-04-27	Midfielder	174	Left	Japan
1575	Joshua Upamecano 1575	2004-08-25	Midfielder	174	Right	Brazil
1576	Cristiano Donnarumma 1576	1997-10-17	Midfielder	192	Left	Scotland
1577	Phil Vlahovic 1577	2000-05-14	Defender	181	Left	Norway
1578	Ederson Militao 1578	2005-11-22	Forward	190	Left	Japan
1579	Ruben Fernandes 1579	2004-07-28	Forward	178	Right	Ivory Coast
1580	Virgil Saliba 1580	1998-12-01	Midfielder	193	Right	Belgium
1581	Reece Donnarumma 1581	2002-07-14	Midfielder	181	Left	Scotland
1582	Kim Tchouameni 1582	2002-02-22	Midfielder	190	Right	Nigeria
1583	Enzo Grealish 1583	2001-04-09	Midfielder	191	Left	Turkey
1584	Ronald Alexander-Arnold 1584	2003-09-18	Defender	191	Left	USA
1585	Mike Kolo Muani 1585	2001-05-26	Midfielder	191	Right	Ivory Coast
1586	Thibaut Nunez 1586	1998-04-20	Midfielder	175	Right	Netherlands
1587	Ousmane Kolo Muani 1587	2002-08-03	Midfielder	186	Left	Belgium
1588	Cristiano Rodri 1588	2002-02-06	Defender	170	Right	France
1589	Enzo Coman 1589	2003-12-04	Forward	186	Left	Colombia
1590	Randal Odegaard 1590	2005-07-12	Forward	186	Right	Scotland
1591	Khvicha Silva 1591	2004-04-27	Forward	195	Right	Turkey
1592	Luka Upamecano 1592	1997-07-02	Defender	177	Right	Egypt
1593	Jude Gundogan 1593	1995-01-15	Midfielder	186	Right	Portugal
1594	Christopher Musiala 1594	2002-06-08	Forward	186	Left	Italy
1595	Victor Becker 1595	1995-03-01	Forward	190	Left	Italy
1596	Nicolo Messi 1596	2002-10-02	Defender	190	Right	Senegal
1597	Phil Maignan 1597	2000-07-16	Defender	191	Right	Sweden
1598	Jan Vlahovic 1598	2003-07-29	Midfielder	175	Left	Belgium
1599	Serge White 1599	1999-10-06	Midfielder	183	Left	Senegal
1600	Gianluigi Rashford 1600	2000-04-08	Midfielder	174	Right	France
1601	Christopher Camavinga 1601	1996-09-04	Defender	183	Left	Norway
1602	Mike Courtois 1602	2002-01-01	Midfielder	178	Left	Croatia
1603	Serge Lewandowski 1603	2002-09-29	Midfielder	182	Left	Senegal
1604	Federico Moraes 1604	2005-12-10	Midfielder	178	Left	Morocco
1605	Kevin Foden 1605	1997-03-30	Defender	176	Left	France
1606	Gianluigi De Bruyne 1606	2001-03-30	Forward	173	Right	Italy
1607	Declan Kimmich 1607	1996-04-07	Forward	172	Left	Italy
1608	Alphonso Upamecano 1608	2002-08-21	Midfielder	192	Left	Colombia
1609	Martin Modric 1609	1998-07-06	Forward	184	Right	Croatia
1610	Robert Camavinga 1610	1999-02-26	Midfielder	187	Right	Israel
1611	Casemiro Dembele 1611	2002-12-09	Defender	173	Left	Turkey
1612	Christopher Silva 1612	1999-05-07	Midfielder	194	Right	Israel
1613	Neymar Hernandez 1613	1997-08-17	Forward	176	Right	Nigeria
1614	Ruben Mac Allister 1614	2000-06-05	Midfielder	180	Left	Austria
1615	Marquinhos Nunez 1615	2002-09-06	Midfielder	184	Left	Chile
1616	Kim Diaz 1616	2002-07-25	Midfielder	175	Right	France
1617	Ronald Saka 1617	1997-12-14	Defender	182	Left	Nigeria
1618	Kim Bastoni 1618	2001-01-18	Defender	178	Left	Scotland
1619	Federico Grealish 1619	2002-02-04	Defender	182	Left	Italy
1620	Casemiro Partey 1620	2005-07-12	Defender	193	Left	Portugal
1621	Mohamed Militao 1621	1998-10-21	Midfielder	172	Left	Israel
1622	Bukayo Junior 1622	2004-05-21	Midfielder	194	Left	Israel
1623	Bukayo Rice 1623	2003-02-09	Midfielder	185	Right	France
1624	Khvicha Militao 1624	2001-03-07	Defender	193	Right	Senegal
1625	Declan Bellingham 1625	1997-10-12	Forward	176	Right	Poland
1626	Achraf Rodri 1626	2002-04-11	Defender	171	Right	Netherlands
1627	Bruno Martinez 1627	2003-04-11	Forward	176	Right	Nigeria
1628	Kevin Odegaard 1628	1999-04-07	Midfielder	190	Left	Austria
1629	Victor Nunez 1629	2002-08-01	Defender	177	Right	Poland
1630	Lionel Rice 1630	2001-07-27	Forward	170	Right	Germany
1631	Vinicius Nkunku 1631	2002-09-26	Defender	186	Left	Egypt
1632	Martin Davies 1632	2001-10-22	Forward	192	Left	Egypt
1633	Bruno Gnabry 1633	1997-11-19	Defender	186	Right	Mexico
1634	Christopher Donnarumma 1634	2003-03-12	Forward	175	Left	Sweden
1635	Declan Salah 1635	1998-01-20	Midfielder	178	Left	Croatia
1636	Dusan Foden 1636	2002-12-18	Defender	174	Right	USA
1637	Bernardo Saka 1637	2001-09-09	Forward	178	Right	Austria
1638	Bruno Mac Allister 1638	1997-10-07	Midfielder	187	Left	Ivory Coast
1639	Ousmane Leao 1639	2005-02-16	Midfielder	170	Left	Croatia
1640	Theo Araujo 1640	2002-07-19	Midfielder	179	Right	Poland
1641	Jan Araujo 1641	1996-07-20	Forward	187	Left	Colombia
1642	Mohamed Kvaratskhelia 1642	1998-03-22	Midfielder	178	Right	Chile
1643	Dusan Partey 1643	1995-06-09	Midfielder	170	Left	Spain
1644	Nicolo Modric 1644	1995-10-30	Forward	189	Right	England
1645	Neymar White 1645	1997-01-25	Midfielder	173	Left	Senegal
1646	Dayot Mbappe 1646	1996-01-11	Defender	191	Left	Croatia
1647	Theo Kvaratskhelia 1647	2005-11-28	Forward	185	Left	Mexico
1648	Christopher Barella 1648	2001-12-05	Midfielder	174	Right	Croatia
1649	Julian Donnarumma 1649	1998-07-17	Defender	187	Left	Brazil
1650	Eduardo Lewandowski 1650	2004-12-27	Midfielder	182	Right	Germany
1651	Dayot Kolo Muani 1651	1998-10-07	Midfielder	172	Right	Turkey
1652	Harry Martinez 1652	2002-03-09	Forward	173	Right	Croatia
1653	Dayot Modric 1653	2001-01-13	Forward	180	Right	Belgium
1654	Bruno Foden 1654	2002-01-22	Defender	191	Left	USA
1655	Ilkay Mac Allister 1655	1997-05-09	Midfielder	194	Left	Scotland
1656	Theo Partey 1656	2004-02-25	Forward	191	Left	Senegal
1657	Dayot Rashford 1657	2004-09-24	Forward	189	Right	Brazil
1658	Kylian Nunez 1658	1999-11-10	Midfielder	193	Left	Ivory Coast
1659	Ruben Partey 1659	2002-11-28	Forward	182	Right	Portugal
1660	Robert Donnarumma 1660	1995-11-27	Forward	170	Right	Colombia
1661	Jack Tchouameni 1661	2003-02-28	Forward	191	Left	England
1662	Nicolo Martinez 1662	2000-08-03	Defender	182	Left	Mexico
1663	Reece Militao 1663	2001-06-01	Defender	184	Right	USA
1664	Eduardo Rashford 1664	2004-05-01	Defender	171	Right	USA
1665	Ousmane Osimhen 1665	1996-05-21	Defender	171	Left	Israel
1666	Luka Moraes 1666	2002-09-15	Midfielder	193	Right	Egypt
1667	Lautaro Tchouameni 1667	1999-11-16	Defender	170	Right	Italy
1668	Gabriel Gnabry 1668	2005-03-06	Midfielder	185	Right	Austria
1669	Theo Becker 1669	2004-03-12	Defender	194	Left	Brazil
1670	Antoine Silva 1670	1996-08-03	Forward	194	Left	USA
1671	Serge Donnarumma 1671	1999-07-30	Forward	195	Right	Portugal
1672	Jamal Martinez 1672	2001-07-29	Midfielder	180	Right	Scotland
1673	Rafael Tonali 1673	2005-02-11	Forward	194	Left	Chile
1674	Bukayo Saliba 1674	2001-06-22	Forward	175	Right	Spain
1675	Kim Salah 1675	2001-02-11	Forward	183	Right	Morocco
1676	Bruno Kvaratskhelia 1676	1998-09-25	Midfielder	183	Left	Scotland
1677	Dusan Gnabry 1677	1997-03-04	Defender	189	Left	Mexico
1678	Luka Camavinga 1678	2005-09-23	Defender	172	Right	Poland
1679	Bukayo Becker 1679	2003-08-20	Forward	193	Right	Japan
1680	Eduardo Nunez 1680	1995-01-10	Midfielder	186	Left	Morocco
1681	Neymar Goretzka 1681	1998-04-21	Defender	183	Left	Poland
1682	Kingsley Partey 1682	1997-04-08	Forward	171	Left	Senegal
1683	Robert Rashford 1683	1998-03-20	Forward	189	Left	Portugal
1684	Kylian Rodri 1684	2000-12-23	Forward	175	Right	Colombia
1685	Kylian Osimhen 1685	2005-02-09	Defender	194	Left	Morocco
1686	Jamal Griezmann 1686	2004-11-26	Midfielder	191	Right	Colombia
1687	Mike Gundogan 1687	2005-01-09	Defender	177	Right	Nigeria
1688	Luis Ronaldo 1688	2000-12-21	Defender	189	Left	Netherlands
1689	Ilkay Barella 1689	1995-02-07	Defender	188	Right	Belgium
1690	Thibaut Gnabry 1690	2002-02-07	Midfielder	172	Right	Turkey
1691	Mike Davies 1691	2000-11-30	Defender	185	Right	Ivory Coast
1692	Bruno Martinez 1692	2004-02-20	Midfielder	176	Left	Austria
1693	Rafael Fernandez 1693	2002-03-10	Midfielder	178	Left	Sweden
1694	Eder Diaz 1694	2005-02-15	Defender	193	Left	Ivory Coast
1695	Sandro Grealish 1695	1999-02-09	Defender	189	Left	Italy
1696	Rodri Barella 1696	2004-10-15	Defender	188	Right	Spain
1697	Virgil Osimhen 1697	2003-02-17	Forward	177	Left	Netherlands
1698	Federico Nunez 1698	2002-03-23	Midfielder	195	Left	Colombia
1699	Alisson Valverde 1699	2002-06-01	Defender	193	Left	Japan
1700	Phil Rashford 1700	2003-05-13	Forward	177	Right	France
1701	Julian Bastoni 1701	1998-03-05	Midfielder	170	Left	Austria
1702	Casemiro Alvarez 1702	1995-04-26	Defender	183	Left	Mexico
1703	Dusan Camavinga 1703	2003-05-02	Forward	187	Left	Croatia
1704	Bruno Tchouameni 1704	2004-02-21	Forward	193	Left	France
1705	Ilkay Mac Allister 1705	2004-03-19	Defender	177	Right	Netherlands
1706	Christopher Sane 1706	2003-12-29	Defender	192	Right	Egypt
1707	Erling Upamecano 1707	2001-12-24	Forward	193	Right	Morocco
1708	Manuel Grealish 1708	2000-08-02	Midfielder	191	Right	Morocco
1709	Achraf Davies 1709	2001-09-02	Forward	174	Right	Chile
1710	Ilkay Salah 1710	2003-05-19	Midfielder	187	Left	Japan
1711	Marcus Fernandes 1711	1997-01-03	Forward	192	Left	Colombia
1712	Phil Junior 1712	2004-08-01	Defender	181	Right	Nigeria
1713	Marquinhos Nunez 1713	2003-01-31	Defender	181	Right	Turkey
1714	Phil Griezmann 1714	2003-01-04	Defender	192	Right	Austria
1715	Kylian Ronaldo 1715	1996-03-28	Midfielder	192	Right	Nigeria
1716	Jan Mac Allister 1716	1999-09-15	Midfielder	186	Right	Mexico
1717	Achraf Goretzka 1717	2004-10-27	Defender	174	Left	Morocco
1718	Federico Nunez 1718	2004-05-12	Forward	195	Left	Colombia
1719	Eder Tchouameni 1719	1998-04-10	Midfielder	194	Left	Mexico
1720	Dusan Tonali 1720	1996-12-01	Forward	179	Left	Poland
1721	Theo Coman 1721	2000-03-17	Midfielder	173	Right	England
1722	Nicolo Tonali 1722	1999-11-03	Forward	188	Left	Portugal
1723	Ilkay Moraes 1723	1996-01-23	Forward	175	Right	Chile
1724	Gianluigi Tchouameni 1724	2004-10-01	Forward	182	Right	Belgium
1725	Ilkay Alexander-Arnold 1725	2002-08-30	Midfielder	177	Left	Germany
1726	Mike Rashford 1726	2002-05-01	Midfielder	177	Left	Egypt
1727	Vinicius Gnabry 1727	2001-07-30	Defender	172	Left	Norway
1728	Lautaro Valverde 1728	1997-07-18	Defender	182	Left	Italy
1729	Leon Mac Allister 1729	1997-12-26	Midfielder	181	Left	France
1730	Achraf Tchouameni 1730	2000-08-13	Midfielder	194	Left	Japan
1731	Bruno Leao 1731	2002-05-17	Midfielder	185	Left	Colombia
1732	Vinicius Martinez 1732	2004-05-08	Defender	177	Left	Poland
1733	Manuel Rice 1733	2001-06-18	Forward	181	Left	Spain
1734	Rafael Dias 1734	1995-05-18	Midfielder	184	Right	Turkey
1735	Eder Valverde 1735	1998-01-22	Midfielder	190	Right	Brazil
1736	Alphonso Neuer 1736	1999-11-24	Forward	190	Left	Nigeria
1737	Mohamed Moraes 1737	1997-03-18	Midfielder	177	Left	France
1738	Manuel Kvaratskhelia 1738	1997-06-27	Forward	171	Left	Germany
1739	Joshua Saliba 1739	2002-01-26	Defender	193	Left	Japan
1740	Jamal Lewandowski 1740	2003-01-29	Forward	194	Left	Senegal
1741	Rodri Upamecano 1741	1996-06-11	Midfielder	193	Left	Norway
1742	Kylian Odegaard 1742	2002-12-21	Defender	188	Left	France
1743	Pedri Oblak 1743	1996-07-19	Midfielder	184	Right	Japan
1744	Kingsley Osimhen 1744	1999-12-26	Defender	186	Right	England
1745	Cristiano Sane 1745	2003-01-19	Midfielder	193	Right	Ivory Coast
1746	Lionel Lewandowski 1746	2005-10-25	Midfielder	192	Left	Belgium
1747	Bukayo van Dijk 1747	1996-09-23	Midfielder	185	Right	Poland
1748	Erling Sane 1748	2002-01-18	Defender	179	Right	Japan
1749	Cristiano Alexander-Arnold 1749	1999-07-09	Forward	195	Left	Nigeria
1750	Christopher White 1750	2000-01-12	Forward	192	Left	France
1751	Mike Neuer 1751	1995-06-25	Forward	186	Left	Croatia
1752	Ilkay Kane 1752	1995-11-08	Forward	189	Left	Sweden
1753	Kim Martinez 1753	1996-12-09	Forward	186	Right	Nigeria
1754	Ronald van Dijk 1754	2005-10-05	Defender	174	Right	Egypt
1755	Martin James 1755	2002-07-20	Defender	184	Right	France
1756	Rodri Tchouameni 1756	2003-09-30	Midfielder	187	Left	France
1757	Joshua Hakimi 1757	2002-12-26	Forward	192	Left	Turkey
1758	Mohamed Modric 1758	1995-06-04	Forward	188	Left	Norway
1759	Rafael Ronaldo 1759	2002-02-27	Defender	191	Left	Italy
1760	Dusan Martinez 1760	2000-01-30	Forward	194	Right	Turkey
1761	Gabriel White 1761	2005-05-23	Defender	195	Left	Portugal
1762	Ederson Tchouameni 1762	1995-07-07	Forward	180	Right	Turkey
1763	Luka Valverde 1763	2005-11-26	Forward	191	Left	Austria
1764	Robert Mbappe 1764	1998-05-15	Forward	185	Left	USA
1765	Achraf Nunez 1765	2003-08-03	Midfielder	194	Right	Morocco
1766	Nicolo Martinez 1766	1995-08-11	Defender	172	Right	Chile
1767	Robert Neuer 1767	1999-09-22	Forward	183	Left	Senegal
1768	Bernardo White 1768	1996-08-15	Midfielder	184	Left	Norway
1769	Eder Mbappe 1769	1997-05-29	Defender	177	Left	Turkey
1770	Luka Tchouameni 1770	1996-06-17	Midfielder	178	Right	Chile
1771	Achraf Bastoni 1771	1998-08-25	Forward	180	Left	Japan
1772	Antoine Junior 1772	1998-04-04	Defender	186	Right	Colombia
1773	Kim Hakimi 1773	2000-05-29	Midfielder	189	Left	Netherlands
1774	Ilkay Diaz 1774	2003-01-10	Forward	186	Right	Ivory Coast
1775	Dusan Mac Allister 1775	2001-01-22	Defender	176	Right	Chile
1776	Theo Moraes 1776	1999-07-24	Forward	174	Left	Norway
1777	Luka Nkunku 1777	2005-03-27	Midfielder	170	Right	Senegal
1778	Bukayo Coman 1778	1997-05-14	Defender	188	Right	Netherlands
1779	Sandro Grealish 1779	1995-04-03	Defender	192	Left	Turkey
1780	Victor Dias 1780	2005-09-19	Defender	184	Right	Israel
1781	Dusan Coman 1781	2002-12-04	Defender	190	Left	Colombia
1782	Leon Moraes 1782	2002-07-07	Defender	187	Right	France
1783	Achraf De Bruyne 1783	1996-05-12	Defender	193	Left	Colombia
1784	Theo Hakimi 1784	2003-07-09	Defender	174	Left	Austria
1785	Harry Hakimi 1785	2002-03-11	Defender	177	Right	Ivory Coast
1786	Marquinhos Nunez 1786	1998-06-04	Midfielder	180	Left	Netherlands
1787	Federico Sane 1787	1997-12-30	Defender	191	Right	Senegal
1788	Serge Vlahovic 1788	2002-07-25	Defender	188	Left	Japan
1789	Theo Gnabry 1789	2002-09-16	Midfielder	194	Right	Japan
1790	Luis Salah 1790	2002-05-16	Midfielder	184	Left	England
1791	Manuel Donnarumma 1791	2000-11-19	Midfielder	187	Right	Egypt
1792	Kevin Fernandes 1792	2005-03-26	Defender	191	Right	Poland
1793	Luis Alvarez 1793	2005-07-29	Midfielder	178	Left	Poland
1794	Dusan De Bruyne 1794	2002-10-02	Midfielder	170	Left	USA
1795	Joshua Courtois 1795	2003-02-24	Defender	184	Left	Netherlands
1796	Cristiano Camavinga 1796	2000-07-22	Midfielder	192	Right	Sweden
1797	Jan Bellingham 1797	1998-07-22	Forward	185	Right	Israel
1798	Martin White 1798	2000-04-16	Defender	175	Left	Poland
1799	Julian Musiala 1799	1998-08-26	Forward	179	Left	Scotland
1800	Dusan Modric 1800	1995-06-20	Defender	177	Right	Austria
1801	Joshua Lewandowski 1801	2001-04-25	Forward	192	Right	Germany
1802	Rafael Hakimi 1802	2003-05-17	Defender	190	Left	Belgium
1803	Lionel van Dijk 1803	2005-11-15	Midfielder	172	Left	Italy
1804	Ronald van Dijk 1804	2000-03-23	Midfielder	195	Right	Spain
1805	Kingsley Dias 1805	2003-08-16	Midfielder	179	Right	Belgium
1806	Reece Bellingham 1806	2003-09-19	Defender	192	Left	Senegal
1807	Rafael Rice 1807	1996-06-06	Forward	183	Left	Senegal
1808	Vinicius Mac Allister 1808	1997-02-05	Midfielder	184	Left	Netherlands
1809	Enzo Foden 1809	1996-03-19	Midfielder	175	Left	Norway
1810	Julian Griezmann 1810	1998-12-11	Midfielder	195	Left	Egypt
1811	Harry Foden 1811	1996-10-02	Midfielder	192	Left	Belgium
1812	Neymar Dembele 1812	2001-01-31	Defender	175	Left	Colombia
1813	Manuel Gundogan 1813	2004-09-17	Defender	194	Left	Scotland
1814	Declan Osimhen 1814	1998-05-10	Defender	185	Left	Turkey
1815	Pedri Sane 1815	1995-12-11	Forward	192	Left	Portugal
1816	Mohamed van Dijk 1816	2003-06-13	Midfielder	172	Left	Morocco
1817	Khvicha Araujo 1817	1998-06-23	Midfielder	187	Right	France
1818	Phil Martinez 1818	1995-08-31	Midfielder	190	Left	USA
1819	Martin Dias 1819	2002-07-17	Defender	171	Right	Colombia
1820	Darwin Gundogan 1820	1995-03-12	Midfielder	174	Left	Mexico
1821	Federico Dias 1821	1997-04-12	Midfielder	175	Right	Italy
1822	Jack van Dijk 1822	2001-12-04	Midfielder	191	Right	Chile
1823	Theo De Bruyne 1823	1999-07-11	Midfielder	188	Right	Morocco
1824	Eduardo Partey 1824	1996-06-17	Forward	186	Left	England
1825	Pedri Kimmich 1825	1996-04-02	Forward	177	Left	Norway
1826	Leroy Alexander-Arnold 1826	2005-04-28	Defender	175	Left	Brazil
1827	Achraf Tonali 1827	2004-11-13	Defender	173	Right	Belgium
1828	Aurelien Kvaratskhelia 1828	2003-09-04	Midfielder	186	Left	USA
1829	Nicolo Salah 1829	2000-10-30	Forward	184	Right	Belgium
1830	Lionel Leao 1830	1998-11-24	Midfielder	170	Right	Brazil
1831	Achraf Valverde 1831	1996-04-01	Forward	186	Right	Austria
1832	Martin Dembele 1832	1997-10-30	Forward	175	Right	Scotland
1833	Casemiro Alvarez 1833	2000-07-11	Forward	194	Right	Nigeria
1834	Alisson Militao 1834	1995-05-12	Midfielder	183	Left	Nigeria
1835	Ruben Becker 1835	1998-03-28	Defender	172	Right	Sweden
1836	Nicolo Martinez 1836	2002-01-16	Defender	190	Right	Chile
1837	Julian Gundogan 1837	2005-03-07	Midfielder	176	Left	Sweden
1838	Leroy Messi 1838	1997-05-25	Defender	176	Right	Austria
1839	Alexis Barella 1839	2003-10-02	Defender	189	Left	USA
1840	Jack Silva 1840	1996-07-15	Forward	195	Right	Germany
1841	Serge Silva 1841	1996-12-12	Defender	186	Left	USA
1842	Manuel Militao 1842	2003-10-21	Midfielder	173	Left	Scotland
1843	Manuel Rodri 1843	2003-10-29	Forward	173	Left	Austria
1844	Alexis Martinez 1844	1996-04-12	Forward	170	Right	Colombia
1845	Erling Rashford 1845	2002-08-18	Midfielder	180	Right	Ivory Coast
1846	Ederson Araujo 1846	2004-05-22	Midfielder	191	Right	Turkey
1847	Dusan Donnarumma 1847	2003-06-12	Defender	175	Left	Belgium
1848	Marcus Moraes 1848	1998-01-26	Defender	176	Left	Turkey
1849	Ousmane Rashford 1849	2003-07-23	Midfielder	176	Right	Ivory Coast
1850	Kim Grealish 1850	1997-08-13	Midfielder	194	Right	Spain
1851	Thibaut Haaland 1851	1998-04-01	Midfielder	176	Left	Senegal
1852	William Kolo Muani 1852	2005-01-12	Defender	192	Left	Nigeria
1853	Ousmane Salah 1853	2001-07-12	Forward	187	Right	Mexico
1854	Phil Neuer 1854	2002-08-26	Defender	191	Right	Sweden
1855	Jack Grealish 1855	2005-10-09	Midfielder	192	Right	Spain
1856	Gianluigi Rice 1856	2001-03-25	Defender	170	Right	England
1857	Marquinhos Mbappe 1857	2001-06-30	Defender	195	Right	Spain
1858	Aurelien Maignan 1858	2004-08-01	Defender	184	Left	Netherlands
1859	Pedri Hakimi 1859	1996-09-07	Defender	179	Left	Netherlands
1860	Darwin Min-jae 1860	2001-04-27	Defender	176	Left	Morocco
1861	Luka Rashford 1861	2002-01-11	Midfielder	189	Left	Norway
1862	Alexis Alexander-Arnold 1862	2004-12-23	Midfielder	178	Left	Portugal
1863	Dusan Foden 1863	2004-01-01	Forward	174	Left	USA
1864	Luis Grealish 1864	2003-11-23	Forward	180	Left	Nigeria
1865	Kingsley Militao 1865	1998-05-07	Forward	174	Right	Poland
1866	Nicolo Kolo Muani 1866	2002-08-01	Defender	173	Right	England
1867	Kylian Maignan 1867	1998-11-01	Midfielder	186	Right	France
1868	Nicolo Salah 1868	1995-01-29	Forward	190	Right	Japan
1869	Phil Messi 1869	2003-01-10	Defender	173	Left	Netherlands
1870	Marcus Hernandez 1870	2004-08-24	Defender	185	Right	Brazil
1871	Aurelien Ronaldo 1871	2002-01-24	Defender	185	Left	Colombia
1872	Lionel Kvaratskhelia 1872	2000-03-14	Midfielder	172	Left	Scotland
1873	Rodri Vlahovic 1873	1996-11-07	Midfielder	195	Right	France
1874	Pedri Dembele 1874	1997-06-24	Forward	190	Right	Italy
1875	Alexis Upamecano 1875	1997-04-04	Midfielder	186	Left	Netherlands
1876	Harry Musiala 1876	2002-06-16	Forward	194	Right	Japan
1877	Darwin Saliba 1877	2005-12-13	Defender	179	Right	France
1878	Mohamed Haaland 1878	2002-11-23	Defender	186	Right	Morocco
1879	Lionel Vlahovic 1879	2001-05-12	Forward	182	Right	Colombia
1880	Bruno Dias 1880	1999-08-31	Defender	188	Right	Scotland
1881	Randal Rashford 1881	2005-10-06	Defender	177	Left	Poland
1882	Antoine Haaland 1882	2001-08-23	Forward	179	Right	Mexico
1883	Federico Nunez 1883	2000-06-22	Defender	181	Right	Ivory Coast
1884	Bernardo Militao 1884	2005-04-07	Midfielder	195	Left	USA
1885	Ousmane Saliba 1885	1995-08-25	Defender	176	Left	Nigeria
1886	Julian Bellingham 1886	2001-02-01	Defender	174	Right	Austria
1887	Enzo Becker 1887	2000-03-21	Defender	170	Left	Turkey
1888	Victor Alvarez 1888	2002-02-15	Forward	174	Left	Scotland
1889	Casemiro Donnarumma 1889	1997-09-28	Defender	178	Left	Portugal
1890	Virgil Osimhen 1890	2005-02-18	Defender	180	Left	Mexico
1891	Casemiro Grealish 1891	1995-05-11	Defender	191	Left	Chile
1892	Thibaut Tonali 1892	1999-03-10	Defender	184	Right	Austria
1893	Achraf Alvarez 1893	2004-12-27	Forward	189	Right	Sweden
1894	Aurelien Dembele 1894	2000-01-13	Defender	173	Right	USA
1895	Serge Ronaldo 1895	2004-10-09	Forward	176	Left	Portugal
1896	Leroy Martinez 1896	2002-02-09	Defender	170	Left	Spain
1897	Lautaro Fernandes 1897	2000-03-10	Forward	183	Right	Nigeria
1898	Marcus Odegaard 1898	1999-10-19	Midfielder	185	Left	Ivory Coast
1899	Phil Dias 1899	1995-07-14	Forward	181	Right	Senegal
1900	Eduardo Salah 1900	1996-10-13	Forward	170	Left	Brazil
1901	Bruno van Dijk 1901	2004-01-28	Defender	175	Left	Spain
1902	Kim Hernandez 1902	1998-08-03	Midfielder	176	Left	Poland
1903	Antoine Tonali 1903	2001-04-12	Midfielder	181	Right	Italy
1904	Phil Mac Allister 1904	2005-01-28	Midfielder	170	Right	Poland
1905	Marquinhos Leao 1905	1998-12-02	Forward	182	Left	Austria
1906	Ronald Araujo 1906	2002-09-04	Forward	185	Right	Poland
1907	Achraf Courtois 1907	1998-04-16	Midfielder	178	Left	USA
1908	Alexis Modric 1908	1996-01-13	Defender	191	Right	Colombia
1909	Virgil Odegaard 1909	1997-05-30	Defender	174	Right	Norway
1910	Jude Goretzka 1910	1998-07-13	Midfielder	176	Right	Morocco
1911	Mohamed Bellingham 1911	2004-05-17	Forward	176	Left	Spain
1912	Darwin Kimmich 1912	1995-04-13	Midfielder	177	Left	France
1913	Kim Coman 1913	2005-09-07	Defender	190	Right	Portugal
1914	Theo Haaland 1914	1997-06-15	Forward	187	Right	Germany
1915	Harry Rice 1915	1998-03-14	Midfielder	171	Left	Argentina
1916	Kylian Upamecano 1916	2000-05-12	Midfielder	181	Left	Argentina
1917	Kevin Saliba 1917	2003-02-19	Defender	173	Left	Spain
1918	Eduardo Mbappe 1918	2001-03-22	Midfielder	182	Left	France
1919	Luka Kvaratskhelia 1919	2001-08-07	Forward	181	Right	Egypt
1920	Serge Neuer 1920	1995-01-21	Defender	173	Left	Ivory Coast
1921	Declan Griezmann 1921	1997-04-09	Forward	186	Left	Nigeria
1922	Cristiano Kvaratskhelia 1922	2000-12-25	Midfielder	173	Left	Nigeria
1923	Vinicius Saliba 1923	2003-06-05	Defender	190	Left	Sweden
1924	Eder Dias 1924	2002-01-07	Forward	171	Right	Croatia
1925	Lionel Alvarez 1925	2003-01-30	Forward	193	Left	Austria
1926	Alisson Militao 1926	2001-11-05	Defender	179	Right	Poland
1927	Ronald White 1927	2003-07-10	Midfielder	190	Right	Ivory Coast
1928	Lautaro Rice 1928	2002-03-27	Defender	188	Left	Italy
1929	Mike Becker 1929	1997-01-24	Forward	180	Right	Chile
1930	Harry Musiala 1930	1999-01-16	Midfielder	170	Right	Sweden
1931	Nicolo Fernandez 1931	1996-04-17	Midfielder	174	Left	Belgium
1932	Jack Araujo 1932	2000-03-14	Forward	181	Left	Brazil
1933	Cristiano Nunez 1933	2002-05-12	Defender	178	Right	Portugal
1934	Joshua Mac Allister 1934	1999-11-11	Forward	182	Left	Spain
1935	Dusan Messi 1935	1995-12-13	Midfielder	182	Left	Poland
1936	Manuel Araujo 1936	1996-06-06	Midfielder	183	Left	USA
1937	Jude Donnarumma 1937	1999-08-03	Midfielder	181	Right	Spain
1938	Lautaro Nkunku 1938	1998-08-18	Forward	185	Right	Italy
1939	Antoine Gundogan 1939	2002-12-30	Forward	178	Right	Mexico
1940	Mohamed Osimhen 1940	2001-01-26	Forward	188	Right	England
1941	Marcus Hernandez 1941	1995-09-27	Defender	171	Left	Austria
1942	Mohamed Dembele 1942	2005-05-03	Forward	175	Left	Brazil
1943	Declan Mbappe 1943	2002-01-18	Midfielder	172	Right	Belgium
1944	Victor Osimhen 1944	1997-12-08	Midfielder	194	Right	Austria
1945	Rodri James 1945	2003-08-16	Midfielder	183	Left	Argentina
1946	Marquinhos Upamecano 1946	2000-03-29	Midfielder	183	Left	Croatia
1947	Victor Barella 1947	1997-11-15	Defender	173	Right	Turkey
1948	Bukayo Gnabry 1948	1999-12-09	Defender	194	Right	Argentina
1949	Lautaro Gundogan 1949	1999-12-03	Midfielder	178	Right	Scotland
1950	Reece James 1950	1996-09-17	Forward	180	Left	England
1951	Jan Araujo 1951	1995-02-09	Defender	194	Left	Norway
1952	Cristiano Gundogan 1952	2002-12-31	Midfielder	178	Left	Colombia
1953	Darwin Tchouameni 1953	1998-12-07	Forward	193	Right	Chile
1954	Casemiro Goretzka 1954	2003-07-15	Forward	194	Left	Italy
1955	Manuel Silva 1955	1996-05-03	Forward	187	Right	Spain
1956	Harry Diaz 1956	1996-10-02	Midfielder	195	Left	Sweden
1957	Gianluigi Kvaratskhelia 1957	1996-10-05	Defender	180	Right	Argentina
1958	Luka Maignan 1958	2001-02-27	Forward	170	Left	Spain
1959	Luis Nunez 1959	2001-07-27	Defender	177	Right	USA
1960	Mike De Bruyne 1960	1999-06-01	Forward	188	Right	Poland
1961	Trent Araujo 1961	1998-12-27	Midfielder	184	Right	Croatia
1962	Erling Hernandez 1962	1997-09-18	Midfielder	193	Right	Croatia
1963	Jamal Junior 1963	2001-02-12	Forward	181	Right	Senegal
1964	Alphonso Osimhen 1964	2004-03-02	Forward	190	Left	Japan
1965	Sandro Grealish 1965	1997-05-03	Defender	181	Right	Sweden
1966	Antoine Lewandowski 1966	2003-11-08	Midfielder	190	Right	England
1967	Bernardo Saliba 1967	2005-10-14	Midfielder	181	Left	Germany
1968	Dusan Goretzka 1968	2001-07-14	Defender	173	Left	Sweden
1969	Theo Maignan 1969	1998-10-20	Midfielder	194	Left	Ivory Coast
1970	Manuel Mac Allister 1970	2000-03-16	Forward	174	Left	Norway
1971	Dayot Fernandez 1971	2004-11-06	Defender	172	Left	USA
1972	Marquinhos Donnarumma 1972	2002-07-15	Midfielder	177	Right	Japan
1973	Enzo Osimhen 1973	1997-10-17	Forward	176	Right	Chile
1974	Kingsley Foden 1974	2002-03-30	Defender	177	Right	Croatia
1975	Marcus Rashford 1975	1995-08-10	Forward	192	Right	France
1976	Cristiano van Dijk 1976	1996-12-17	Defender	194	Right	USA
1977	Declan Bastoni 1977	1999-07-06	Midfielder	184	Right	England
1978	Dusan Modric 1978	1996-02-23	Defender	193	Right	Belgium
1979	Ilkay James 1979	1997-01-08	Defender	190	Left	England
1980	Joshua Bastoni 1980	1998-08-08	Defender	191	Left	Ivory Coast
1981	Kevin Martinez 1981	2005-03-24	Forward	173	Right	USA
1982	Virgil Donnarumma 1982	2005-02-07	Midfielder	190	Left	France
1983	Khvicha Nkunku 1983	1995-02-03	Forward	173	Right	Spain
1984	Jamal Dembele 1984	2001-06-19	Defender	195	Left	Mexico
1985	Joshua Fernandez 1985	1997-01-08	Midfielder	186	Right	Italy
1986	Alphonso Hernandez 1986	2003-11-30	Defender	193	Right	Belgium
1987	Neymar Barella 1987	1997-06-01	Midfielder	190	Left	Mexico
1988	Jamal Maignan 1988	1995-06-16	Forward	170	Right	Austria
1989	Eduardo Junior 1989	1998-11-25	Midfielder	188	Right	Netherlands
1990	Mike Partey 1990	2005-05-02	Midfielder	176	Left	England
1991	Aurelien Davies 1991	2000-03-18	Midfielder	195	Right	Belgium
1992	Phil van Dijk 1992	1998-06-01	Forward	171	Right	Turkey
1993	Kylian Saka 1993	1999-01-28	Midfielder	178	Left	Mexico
1994	Jan Gnabry 1994	1999-03-24	Forward	174	Left	Germany
1995	Joshua Diaz 1995	2000-01-17	Defender	180	Left	Croatia
1996	Thibaut Diaz 1996	1998-08-05	Forward	174	Left	Chile
1997	Eduardo Vlahovic 1997	2004-10-23	Midfielder	185	Left	Croatia
1998	Neymar Courtois 1998	2002-03-28	Midfielder	184	Left	France
1999	Gabriel Salah 1999	2004-12-11	Defender	175	Left	Egypt
2000	Dayot Silva 2000	2003-08-14	Midfielder	173	Left	Colombia
\.


--
-- Data for Name: playermatchstats; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.playermatchstats (playerid, matchid, goals, assists, passcompleted, passattempts, tackles, yellowcard, redcard) FROM stdin;
1	451	0	1	40	60	0	0	0
1	325	1	1	47	60	0	0	0
1	195	2	1	20	60	5	0	0
1	462	1	0	28	60	4	0	0
1	303	0	0	35	60	4	0	0
1	254	1	1	33	60	2	1	0
1	267	1	0	33	60	4	1	0
1	479	2	1	45	60	3	0	0
2	281	0	0	30	60	0	0	0
2	383	2	0	27	60	0	0	0
2	20	2	0	47	60	0	0	0
2	66	1	1	27	60	4	0	0
2	481	1	0	22	60	5	1	0
2	151	0	1	35	60	0	0	0
2	267	2	0	28	60	4	0	0
2	229	1	1	41	60	1	0	0
3	200	0	0	37	60	3	1	0
3	342	0	0	43	60	5	0	0
3	424	1	1	36	60	3	0	0
3	417	1	1	43	60	3	0	0
3	217	0	1	27	60	4	0	0
3	447	0	0	44	60	2	0	0
3	121	2	0	31	60	2	0	0
3	238	0	0	23	60	1	0	0
4	116	2	0	48	60	3	1	0
4	257	0	0	39	60	4	0	0
4	159	0	1	43	60	3	0	0
4	358	1	1	21	60	3	1	0
4	158	1	0	31	60	2	0	0
4	28	1	0	41	60	2	0	0
4	490	2	1	32	60	4	0	0
4	287	2	0	36	60	5	1	0
5	174	2	1	20	60	2	1	0
5	321	0	1	27	60	1	1	0
5	482	1	0	40	60	5	0	0
5	351	2	0	30	60	1	0	0
5	183	2	0	26	60	2	0	0
5	187	1	0	25	60	1	0	0
5	59	0	0	36	60	1	0	0
5	328	1	1	37	60	1	0	0
6	262	0	0	33	60	3	1	0
6	172	1	1	43	60	3	0	0
6	332	2	1	24	60	4	1	0
6	112	0	1	26	60	2	0	0
6	226	1	0	39	60	5	0	0
6	147	1	1	21	60	1	0	0
6	66	1	1	46	60	2	0	0
6	234	0	1	40	60	0	0	0
7	367	0	0	28	60	1	0	0
7	314	0	0	47	60	3	0	0
7	163	2	1	47	60	3	0	0
7	346	1	0	29	60	1	0	0
7	296	0	0	32	60	5	0	0
7	99	2	0	36	60	2	1	0
7	187	1	1	28	60	2	0	0
7	302	1	1	34	60	4	0	0
8	469	0	0	50	60	4	1	0
8	109	0	1	25	60	0	0	0
8	438	2	1	44	60	0	0	0
8	424	2	1	41	60	3	0	0
8	347	1	0	23	60	5	1	0
8	162	0	1	32	60	3	0	0
8	420	2	1	23	60	0	1	0
8	314	2	0	32	60	3	0	0
9	224	0	0	41	60	5	0	0
9	263	0	0	29	60	0	0	0
9	90	2	1	38	60	0	0	0
9	466	2	1	49	60	0	1	0
9	402	2	1	30	60	2	0	0
9	427	1	1	42	60	2	0	0
9	333	1	1	46	60	0	1	0
9	202	1	1	24	60	5	0	0
10	26	0	0	20	60	1	1	0
10	157	2	0	43	60	4	1	0
10	314	2	1	23	60	5	0	0
10	476	0	0	28	60	1	0	0
10	306	2	0	30	60	5	0	0
10	417	2	0	43	60	1	1	0
10	196	1	0	33	60	3	1	0
10	162	1	1	27	60	1	0	0
11	386	0	0	42	60	5	1	0
11	306	0	0	20	60	5	0	0
11	319	0	1	38	60	5	0	0
11	33	1	0	23	60	0	1	0
11	496	1	1	40	60	5	0	0
11	68	0	1	24	60	1	0	0
11	284	0	0	47	60	4	0	0
11	118	1	0	35	60	3	0	0
12	196	1	0	41	60	5	1	0
12	21	1	0	38	60	5	0	0
12	387	0	1	42	60	2	0	0
12	465	1	0	36	60	1	0	0
12	389	1	1	21	60	4	1	0
12	416	1	0	20	60	1	0	0
12	419	1	1	29	60	0	0	0
12	122	2	1	24	60	0	0	0
13	311	1	1	31	60	1	0	0
13	27	1	1	37	60	5	0	0
13	397	2	0	34	60	1	1	0
13	402	0	0	44	60	2	0	0
13	191	1	0	48	60	3	1	0
13	371	0	0	21	60	4	0	0
13	451	2	0	41	60	2	0	0
13	345	0	0	24	60	1	1	0
14	18	0	0	33	60	0	0	0
14	23	1	0	23	60	5	1	0
14	292	2	0	42	60	4	0	0
14	169	1	1	47	60	4	0	0
14	480	2	0	24	60	2	0	0
14	479	0	0	32	60	0	0	0
14	25	0	0	49	60	3	0	0
14	266	0	0	42	60	0	0	0
15	455	0	0	26	60	5	0	0
15	225	2	1	44	60	5	0	0
15	367	0	0	43	60	1	0	0
15	362	0	0	34	60	3	0	0
15	127	0	0	31	60	4	1	0
15	282	0	1	33	60	2	0	0
15	25	2	1	21	60	5	0	0
15	230	2	0	29	60	2	0	0
16	472	0	0	32	60	1	1	0
16	126	1	0	35	60	2	1	0
16	156	1	0	37	60	0	1	0
16	27	1	0	39	60	5	0	0
16	159	1	0	42	60	3	0	0
16	325	1	1	28	60	0	1	0
16	117	2	0	23	60	4	0	0
16	492	0	1	25	60	5	0	0
17	437	1	0	25	60	3	0	0
17	126	2	1	50	60	2	0	0
17	204	2	0	47	60	0	0	0
17	119	1	0	33	60	1	0	0
17	348	1	0	46	60	1	1	0
17	255	1	0	45	60	5	0	0
17	63	0	1	30	60	3	0	0
17	172	1	1	24	60	0	0	0
18	32	1	1	38	60	1	0	0
18	395	1	1	27	60	1	0	0
18	443	0	1	30	60	5	0	0
18	364	2	0	31	60	1	1	0
18	84	0	0	49	60	1	0	0
18	42	0	1	37	60	5	0	0
18	404	1	1	36	60	0	0	0
18	35	1	0	44	60	1	0	0
19	252	2	0	42	60	0	1	0
19	389	0	0	24	60	5	0	0
19	310	2	0	31	60	2	0	0
19	292	2	0	50	60	2	0	0
19	51	0	1	28	60	1	0	0
19	145	2	0	46	60	3	0	0
19	219	2	0	50	60	5	0	0
19	239	1	0	37	60	2	0	0
20	429	2	0	42	60	4	0	0
20	453	1	1	41	60	4	0	0
20	363	0	1	41	60	5	0	0
20	314	2	0	36	60	5	0	0
20	105	2	1	38	60	5	0	0
20	376	1	1	37	60	1	0	0
20	218	0	1	45	60	5	0	0
20	409	2	0	25	60	2	0	0
21	418	2	1	48	60	5	0	0
21	92	1	0	35	60	3	0	0
21	130	1	1	20	60	4	0	0
21	160	1	1	46	60	3	0	0
21	282	2	0	40	60	0	0	0
21	39	1	1	38	60	4	0	0
21	365	1	0	42	60	1	1	0
21	221	1	1	43	60	2	0	0
22	150	0	1	30	60	0	0	0
22	231	0	0	36	60	0	1	0
22	404	1	0	39	60	3	0	0
22	500	0	0	24	60	2	1	0
22	3	2	1	47	60	3	1	0
22	170	0	0	47	60	1	0	0
22	59	1	0	21	60	3	0	0
22	52	2	1	42	60	2	0	0
23	477	2	0	32	60	3	0	0
23	442	0	0	30	60	2	1	0
23	498	2	0	47	60	1	0	0
23	147	2	1	45	60	3	0	0
23	384	2	1	29	60	0	0	0
23	228	0	1	46	60	0	0	0
23	303	2	0	34	60	2	0	0
23	322	2	1	43	60	3	0	0
24	80	2	1	39	60	0	0	0
24	475	0	0	34	60	2	1	0
24	395	0	1	31	60	2	0	0
24	363	2	1	23	60	3	1	0
24	156	2	1	27	60	4	0	0
24	441	2	1	39	60	3	1	0
24	270	2	0	25	60	5	0	0
24	54	0	1	31	60	0	0	0
25	212	1	1	38	60	1	0	0
25	19	1	0	50	60	2	0	0
25	114	2	0	20	60	2	0	0
25	296	1	0	47	60	2	0	0
25	261	1	1	43	60	5	0	0
25	291	0	1	35	60	5	1	0
25	14	0	1	39	60	3	1	0
25	331	0	0	49	60	3	0	0
26	144	0	0	37	60	5	1	0
26	77	1	0	40	60	4	1	0
26	436	1	0	26	60	1	0	0
26	404	1	0	40	60	4	0	0
26	253	2	0	34	60	0	1	0
26	493	0	1	22	60	4	1	0
26	367	0	1	34	60	3	0	0
26	105	1	0	27	60	0	0	0
27	190	1	0	40	60	5	0	0
27	379	1	1	22	60	0	0	0
27	392	2	0	24	60	3	1	0
27	127	2	0	39	60	2	0	0
27	272	1	0	39	60	0	0	0
27	25	2	1	35	60	2	0	0
27	436	1	1	40	60	0	0	0
27	244	0	1	24	60	5	0	0
28	402	0	1	30	60	5	0	0
28	91	2	0	25	60	2	0	0
28	270	0	0	31	60	1	0	0
28	142	1	0	50	60	4	1	0
28	191	0	0	21	60	0	0	0
28	206	2	1	26	60	2	0	0
28	412	2	0	37	60	4	1	0
28	417	1	0	37	60	3	1	0
29	27	0	1	21	60	3	0	0
29	334	2	0	39	60	4	0	0
29	181	2	0	28	60	4	0	0
29	207	1	0	40	60	4	0	0
29	206	0	1	20	60	3	0	0
29	73	1	0	50	60	1	1	0
29	290	0	0	34	60	3	1	0
29	152	2	1	43	60	5	1	0
30	484	1	1	40	60	3	0	0
30	376	0	1	33	60	1	1	0
30	322	1	0	31	60	1	0	0
30	6	0	1	26	60	3	0	0
30	412	1	0	39	60	2	1	0
30	366	1	1	45	60	1	0	0
30	60	0	1	50	60	5	0	0
30	139	0	1	37	60	5	0	0
31	13	2	1	43	60	5	0	0
31	137	0	0	23	60	3	0	0
31	27	2	1	39	60	0	0	0
31	467	1	0	33	60	0	0	0
31	179	2	0	37	60	4	0	0
31	352	1	0	22	60	2	0	0
31	277	2	0	48	60	5	1	0
31	250	2	1	29	60	4	0	0
32	270	1	1	43	60	1	0	0
32	259	2	0	37	60	3	0	0
32	430	0	0	45	60	1	1	0
32	361	2	1	37	60	5	0	0
32	165	1	1	35	60	4	0	0
32	414	2	1	26	60	4	0	0
32	411	1	1	46	60	2	1	0
32	150	0	0	24	60	2	0	0
33	301	2	1	35	60	2	0	0
33	293	2	0	26	60	1	0	0
33	377	1	0	48	60	4	0	0
33	41	2	1	20	60	5	1	0
33	34	1	0	23	60	2	0	0
33	22	0	0	45	60	2	0	0
33	58	2	0	37	60	4	1	0
33	418	2	1	25	60	1	0	0
34	28	0	0	49	60	3	0	0
34	35	2	1	46	60	3	0	0
34	242	1	0	50	60	3	0	0
34	451	2	0	27	60	2	0	0
34	388	2	0	31	60	1	0	0
34	500	1	0	32	60	4	0	0
34	11	1	1	45	60	5	0	0
34	281	1	0	48	60	4	0	0
35	282	1	0	28	60	3	1	0
35	250	1	1	32	60	3	0	0
35	261	0	1	22	60	4	0	0
35	160	1	1	46	60	0	0	0
35	325	2	1	40	60	3	0	0
35	378	1	0	40	60	1	0	0
35	95	0	1	40	60	0	0	0
35	167	2	0	37	60	2	0	0
36	33	2	1	23	60	2	1	0
36	259	1	0	43	60	3	0	0
36	359	1	1	31	60	2	0	0
36	72	2	0	26	60	2	0	0
36	405	1	0	47	60	5	1	0
36	225	2	1	37	60	0	0	0
36	384	2	1	49	60	3	0	0
36	138	2	1	36	60	3	0	0
37	341	1	0	26	60	3	0	0
37	399	0	1	34	60	0	0	0
37	363	0	0	25	60	2	0	0
37	266	2	1	46	60	3	0	0
37	93	1	1	27	60	4	1	0
37	313	0	0	47	60	1	0	0
37	241	1	1	29	60	3	0	0
37	378	2	0	30	60	2	1	0
38	36	2	1	49	60	1	1	0
38	105	2	0	21	60	0	1	0
38	70	1	1	29	60	2	0	0
38	288	1	0	31	60	5	0	0
38	473	2	1	26	60	2	0	0
38	229	0	1	44	60	3	1	0
38	235	1	1	20	60	3	1	0
38	212	1	1	47	60	1	0	0
39	13	1	1	31	60	5	0	0
39	368	0	1	34	60	5	0	0
39	472	2	1	27	60	0	0	0
39	150	1	1	42	60	3	0	0
39	358	1	1	43	60	5	0	0
39	97	1	0	27	60	0	0	0
39	348	1	0	28	60	3	0	0
39	468	1	1	36	60	5	0	0
40	111	1	1	50	60	2	0	0
40	249	1	0	44	60	0	0	0
40	442	2	1	41	60	1	1	0
40	199	0	1	46	60	5	0	0
40	183	2	1	35	60	4	1	0
40	263	0	1	46	60	4	0	0
40	405	2	1	43	60	0	1	0
40	416	0	1	26	60	1	0	0
41	190	0	1	25	60	5	0	0
41	20	2	1	24	60	0	1	0
41	322	2	1	46	60	1	0	0
41	291	0	1	48	60	2	0	0
41	333	1	0	27	60	5	0	0
41	279	2	1	27	60	2	1	0
41	243	1	0	34	60	4	1	0
41	325	0	1	50	60	3	0	0
42	92	0	0	41	60	1	0	0
42	278	2	1	38	60	4	0	0
42	212	2	0	44	60	5	1	0
42	21	0	0	22	60	2	0	0
42	482	2	0	38	60	2	1	0
42	168	1	1	39	60	0	1	0
42	495	1	1	30	60	0	0	0
42	51	2	1	27	60	5	1	0
43	2	0	0	27	60	5	0	0
43	311	2	0	50	60	1	0	0
43	444	0	1	27	60	5	1	0
43	43	1	1	40	60	0	0	0
43	281	0	0	26	60	0	1	0
43	261	2	0	30	60	2	0	0
43	470	1	1	34	60	2	0	0
43	490	0	1	28	60	4	0	0
44	30	0	0	21	60	1	1	0
44	445	2	0	44	60	3	0	0
44	253	1	0	46	60	5	0	0
44	365	0	0	21	60	4	0	0
44	232	1	1	24	60	1	0	0
44	324	0	1	29	60	4	0	0
44	25	0	0	21	60	1	0	0
44	114	0	0	24	60	4	0	0
45	224	2	1	46	60	0	1	0
45	53	1	0	45	60	5	1	0
45	322	2	0	33	60	3	1	0
45	336	0	1	25	60	3	0	0
45	341	0	0	35	60	5	0	0
45	222	2	0	33	60	3	0	0
45	7	0	0	31	60	0	1	0
45	58	1	1	46	60	1	0	0
46	202	1	1	49	60	3	1	0
46	217	2	0	40	60	5	0	0
46	216	1	1	48	60	2	0	0
46	496	1	0	48	60	4	0	0
46	429	1	1	24	60	2	1	0
46	49	2	0	40	60	2	1	0
46	337	1	1	24	60	3	0	0
46	391	0	0	24	60	4	0	0
47	211	2	1	25	60	3	1	0
47	489	0	1	29	60	2	0	0
47	89	2	1	43	60	5	0	0
47	176	0	1	48	60	4	0	0
47	294	2	0	48	60	1	0	0
47	320	2	1	36	60	5	0	0
47	406	0	1	31	60	4	1	0
47	48	1	0	31	60	1	1	0
48	375	1	1	42	60	0	1	0
48	126	0	0	20	60	4	0	0
48	32	1	0	35	60	3	0	0
48	159	0	1	36	60	4	0	0
48	337	0	1	27	60	3	0	0
48	149	2	0	37	60	5	0	0
48	492	1	0	46	60	1	1	0
48	270	1	0	29	60	1	0	0
49	450	1	0	33	60	4	0	0
49	469	0	0	41	60	0	0	0
49	278	1	1	32	60	5	0	0
49	33	1	0	22	60	2	1	0
49	183	2	1	25	60	5	0	0
49	189	2	1	26	60	2	1	0
49	148	2	0	36	60	2	0	0
49	356	0	0	45	60	1	1	0
50	292	0	1	25	60	5	1	0
50	280	1	1	38	60	5	0	0
50	340	2	0	35	60	1	0	0
50	44	0	1	39	60	0	0	0
50	465	2	1	46	60	0	0	0
50	392	1	1	40	60	5	1	0
50	344	1	1	45	60	2	1	0
50	230	2	1	24	60	5	1	0
51	383	1	1	23	60	3	0	0
51	88	2	1	33	60	2	1	0
51	469	0	1	24	60	4	0	0
51	423	1	0	48	60	5	1	0
51	110	1	0	42	60	3	0	0
51	317	0	1	29	60	2	1	0
51	97	2	0	43	60	5	0	0
51	231	2	1	47	60	3	1	0
52	180	0	0	30	60	5	1	0
52	166	0	0	23	60	3	0	0
52	460	0	0	48	60	5	1	0
52	331	1	1	45	60	3	0	0
52	31	1	0	24	60	2	0	0
52	245	1	0	44	60	5	0	0
52	476	2	0	36	60	0	0	0
52	199	0	1	22	60	5	0	0
53	194	2	0	48	60	5	0	0
53	275	0	0	44	60	5	0	0
53	235	0	1	31	60	4	0	0
53	57	2	1	27	60	0	0	0
53	224	1	1	42	60	4	0	0
53	430	2	1	43	60	3	0	0
53	468	1	0	44	60	3	1	0
53	279	1	0	26	60	0	0	0
54	442	2	0	38	60	4	0	0
54	327	1	1	49	60	1	0	0
54	432	1	0	27	60	4	0	0
54	416	0	1	27	60	2	0	0
54	177	0	1	50	60	0	0	0
54	193	1	1	40	60	3	0	0
54	291	2	1	21	60	5	0	0
54	280	2	1	34	60	3	0	0
55	177	0	1	41	60	3	0	0
55	284	2	1	37	60	3	0	0
55	496	0	1	24	60	5	0	0
55	149	0	0	36	60	1	1	0
55	391	0	1	27	60	4	0	0
55	348	2	0	33	60	3	0	0
55	89	0	0	23	60	1	0	0
55	366	1	0	28	60	3	0	0
56	445	1	1	39	60	2	0	0
56	372	1	1	45	60	1	0	0
56	21	0	1	40	60	3	0	0
56	118	0	0	42	60	5	1	0
56	336	1	0	34	60	2	0	0
56	97	2	1	25	60	2	1	0
56	360	2	1	48	60	0	0	0
56	212	0	0	21	60	2	1	0
57	305	0	0	43	60	3	0	0
57	415	1	0	21	60	0	1	0
57	442	1	0	42	60	0	1	0
57	114	0	1	33	60	0	1	0
57	357	1	0	36	60	0	0	0
57	286	2	0	32	60	4	0	0
57	460	2	0	47	60	3	0	0
57	436	1	1	48	60	0	1	0
58	423	0	1	40	60	1	0	0
58	381	2	1	22	60	3	1	0
58	397	1	1	41	60	0	1	0
58	70	2	0	27	60	1	0	0
58	11	1	0	31	60	5	0	0
58	380	0	1	23	60	3	0	0
58	171	2	1	46	60	3	0	0
58	488	0	0	50	60	4	0	0
59	59	2	1	41	60	1	0	0
59	311	2	0	31	60	5	1	0
59	69	2	1	31	60	2	0	0
59	19	2	0	46	60	5	1	0
59	403	0	1	49	60	2	0	0
59	24	0	1	28	60	1	0	0
59	218	1	0	48	60	4	0	0
59	317	0	0	26	60	0	0	0
60	97	0	1	38	60	3	0	0
60	71	2	1	28	60	5	1	0
60	91	2	0	43	60	5	1	0
60	38	0	1	29	60	0	0	0
60	227	2	0	40	60	5	1	0
60	29	1	1	28	60	0	0	0
60	210	0	0	48	60	3	0	0
60	341	1	1	26	60	2	0	0
61	212	2	0	34	60	3	0	0
61	491	1	0	43	60	4	1	0
61	38	0	0	36	60	3	0	0
61	498	2	0	26	60	0	1	0
61	439	2	1	39	60	4	0	0
61	158	1	0	24	60	4	1	0
61	40	2	0	34	60	5	0	0
61	110	0	1	39	60	3	0	0
62	363	1	0	43	60	2	1	0
62	453	1	1	27	60	1	0	0
62	59	1	0	28	60	0	0	0
62	281	2	1	50	60	2	0	0
62	81	2	1	28	60	4	0	0
62	352	2	1	44	60	3	0	0
62	119	2	1	34	60	4	0	0
62	438	1	0	27	60	2	0	0
63	398	0	1	35	60	4	0	0
63	164	0	1	28	60	3	1	0
63	252	2	0	25	60	2	0	0
63	411	2	0	41	60	5	0	0
63	389	2	0	35	60	3	0	0
63	47	2	1	49	60	2	1	0
63	208	0	1	46	60	1	0	0
63	130	0	0	47	60	0	0	0
64	269	2	1	50	60	0	0	0
64	90	0	1	43	60	3	0	0
64	166	0	0	26	60	4	0	0
64	114	2	0	35	60	4	1	0
64	157	1	0	25	60	0	0	0
64	53	2	1	21	60	0	1	0
64	230	2	0	43	60	0	1	0
64	342	1	0	44	60	3	0	0
65	494	1	1	44	60	0	1	0
65	110	1	0	40	60	3	0	0
65	387	1	0	22	60	5	1	0
65	186	2	1	28	60	3	1	0
65	335	2	1	34	60	5	0	0
65	29	0	0	42	60	2	0	0
65	330	0	0	31	60	4	1	0
65	44	1	1	41	60	5	1	0
66	409	1	0	38	60	2	1	0
66	6	1	0	42	60	3	0	0
66	416	0	0	31	60	3	0	0
66	242	2	0	49	60	0	0	0
66	16	2	0	30	60	4	0	0
66	198	2	0	21	60	5	0	0
66	413	2	1	33	60	3	0	0
66	281	1	1	32	60	5	1	0
67	86	2	1	39	60	2	0	0
67	383	1	1	39	60	2	0	0
67	345	2	1	40	60	2	0	0
67	304	2	1	42	60	3	0	0
67	197	1	1	39	60	0	0	0
67	308	0	1	42	60	4	1	0
67	161	0	1	29	60	1	0	0
67	355	0	1	43	60	4	0	0
68	26	2	1	34	60	3	0	0
68	28	1	0	23	60	3	0	0
68	106	2	0	27	60	2	0	0
68	96	0	0	21	60	4	0	0
68	20	0	0	30	60	0	0	0
68	50	0	1	39	60	1	1	0
68	402	0	1	46	60	0	1	0
68	40	2	0	42	60	4	0	0
69	231	0	0	30	60	1	0	0
69	492	2	0	25	60	4	0	0
69	162	1	0	42	60	3	0	0
69	369	0	1	45	60	5	0	0
69	279	0	0	28	60	2	0	0
69	229	1	0	20	60	0	0	0
69	313	1	0	36	60	1	0	0
69	234	1	0	31	60	0	1	0
70	472	0	0	29	60	5	0	0
70	6	2	1	24	60	4	0	0
70	394	2	1	45	60	3	1	0
70	218	0	1	45	60	4	0	0
70	186	0	0	27	60	1	0	0
70	189	2	1	45	60	2	0	0
70	454	0	1	24	60	1	1	0
70	496	1	1	21	60	3	0	0
71	334	2	1	48	60	3	0	0
71	430	1	1	26	60	2	0	0
71	117	1	1	28	60	2	0	0
71	424	0	0	26	60	2	0	0
71	159	2	1	50	60	5	0	0
71	137	0	0	41	60	3	0	0
71	248	0	1	42	60	4	0	0
71	59	0	0	20	60	1	0	0
72	151	1	1	36	60	1	0	0
72	27	2	0	40	60	2	1	0
72	470	2	1	37	60	1	0	0
72	475	0	1	27	60	5	0	0
72	95	1	0	44	60	4	0	0
72	123	2	1	25	60	1	1	0
72	169	1	0	36	60	4	0	0
72	109	0	0	40	60	5	0	0
73	173	2	0	47	60	0	1	0
73	354	1	1	38	60	0	0	0
73	302	0	1	46	60	3	0	0
73	223	0	0	25	60	0	1	0
73	289	0	0	46	60	5	0	0
73	292	1	0	24	60	0	0	0
73	150	2	0	20	60	1	0	0
73	494	0	1	23	60	4	0	0
74	481	0	1	36	60	2	0	0
74	274	2	0	34	60	3	0	0
74	77	2	1	36	60	5	0	0
74	145	1	0	39	60	2	0	0
74	467	0	1	23	60	3	1	0
74	311	0	1	40	60	1	0	0
74	389	0	0	40	60	4	1	0
74	475	0	1	49	60	4	0	0
75	469	1	1	34	60	3	0	0
75	468	0	1	50	60	5	0	0
75	498	0	1	36	60	4	0	0
75	76	2	1	42	60	0	0	0
75	216	0	1	49	60	3	0	0
75	184	1	0	38	60	4	1	0
75	295	0	0	25	60	3	0	0
75	186	0	0	26	60	3	0	0
76	310	0	0	30	60	4	0	0
76	351	0	0	45	60	0	0	0
76	491	2	0	27	60	0	0	0
76	386	2	1	26	60	4	0	0
76	431	1	1	50	60	2	0	0
76	94	2	1	39	60	1	0	0
76	204	1	1	28	60	5	1	0
76	295	0	0	34	60	5	0	0
77	119	2	0	36	60	5	0	0
77	196	0	0	21	60	1	0	0
77	289	2	1	44	60	5	0	0
77	306	2	0	39	60	5	0	0
77	141	1	1	47	60	2	0	0
77	405	0	1	43	60	5	0	0
77	238	0	1	31	60	3	0	0
77	165	1	0	40	60	1	1	0
78	100	0	0	42	60	5	1	0
78	334	2	1	22	60	4	1	0
78	391	0	0	28	60	0	1	0
78	116	0	1	37	60	1	1	0
78	18	1	0	22	60	5	1	0
78	44	2	1	43	60	0	0	0
78	96	2	0	22	60	5	1	0
78	327	0	0	24	60	5	0	0
79	494	0	1	41	60	2	0	0
79	1	1	1	24	60	3	1	0
79	445	2	0	45	60	2	0	0
79	88	2	1	20	60	1	0	0
79	106	0	1	47	60	5	1	0
79	496	0	1	25	60	1	0	0
79	184	2	0	42	60	0	0	0
79	127	1	0	29	60	5	0	0
80	195	0	0	37	60	4	0	0
80	189	1	1	45	60	3	0	0
80	97	1	1	41	60	3	0	0
80	139	1	0	35	60	2	1	0
80	400	0	0	24	60	0	1	0
80	147	0	1	38	60	2	0	0
80	206	1	0	48	60	2	1	0
80	142	1	0	47	60	2	0	0
81	66	2	0	25	60	5	0	0
81	55	2	1	21	60	4	0	0
81	246	2	1	24	60	2	0	0
81	157	2	0	41	60	4	0	0
81	257	2	1	21	60	0	0	0
81	30	1	0	34	60	5	0	0
81	329	1	1	50	60	2	0	0
81	442	2	1	35	60	5	0	0
82	353	1	1	49	60	2	0	0
82	172	2	0	32	60	1	1	0
82	245	2	0	25	60	3	0	0
82	224	2	1	26	60	1	1	0
82	239	1	1	33	60	0	1	0
82	388	0	0	48	60	3	1	0
82	434	2	0	40	60	4	1	0
82	340	1	0	32	60	3	0	0
83	8	0	1	43	60	5	1	0
83	62	2	0	32	60	2	0	0
83	354	0	1	23	60	0	0	0
83	407	0	0	49	60	1	0	0
83	165	2	0	22	60	1	1	0
83	352	2	1	37	60	2	0	0
83	465	2	1	29	60	5	0	0
83	33	1	1	43	60	2	0	0
84	164	0	1	31	60	2	0	0
84	320	2	1	39	60	4	0	0
84	52	1	1	49	60	0	1	0
84	500	1	1	41	60	1	0	0
84	359	0	1	34	60	3	0	0
84	491	2	0	36	60	3	0	0
84	62	2	1	36	60	5	0	0
84	443	1	1	38	60	1	0	0
85	256	2	0	49	60	0	0	0
85	73	0	1	23	60	5	1	0
85	254	2	1	20	60	1	0	0
85	277	2	0	34	60	1	0	0
85	49	2	1	34	60	0	0	0
85	9	2	0	20	60	0	0	0
85	493	2	0	20	60	5	1	0
85	98	0	1	38	60	5	0	0
86	458	2	0	43	60	4	1	0
86	263	2	0	38	60	5	0	0
86	145	1	0	37	60	3	1	0
86	185	0	1	44	60	2	0	0
86	295	1	1	37	60	1	1	0
86	156	1	1	38	60	1	0	0
86	55	0	1	44	60	1	0	0
86	117	0	1	23	60	0	1	0
87	224	1	1	45	60	3	0	0
87	382	0	1	35	60	3	0	0
87	346	0	0	50	60	5	1	0
87	213	0	1	49	60	2	0	0
87	142	1	1	26	60	1	0	0
87	119	1	1	37	60	0	1	0
87	340	0	0	25	60	3	1	0
87	140	1	1	31	60	3	0	0
88	429	1	1	36	60	3	0	0
88	232	0	0	27	60	2	1	0
88	269	1	1	32	60	2	1	0
88	84	1	1	43	60	0	0	0
88	96	2	1	22	60	2	0	0
88	11	0	1	25	60	1	0	0
88	25	0	0	34	60	5	0	0
88	107	1	1	44	60	4	1	0
89	467	1	1	37	60	2	0	0
89	39	0	1	29	60	4	1	0
89	113	0	0	39	60	4	1	0
89	279	1	1	34	60	0	0	0
89	83	0	1	40	60	4	1	0
89	393	1	0	26	60	5	0	0
89	9	0	0	48	60	5	0	0
89	16	1	0	26	60	1	0	0
90	280	1	0	34	60	3	1	0
90	494	2	0	35	60	4	0	0
90	167	1	0	29	60	5	1	0
90	484	2	1	40	60	4	1	0
90	427	1	1	45	60	4	1	0
90	491	1	1	22	60	4	1	0
90	139	0	1	45	60	3	0	0
90	151	0	0	32	60	0	1	0
91	334	1	1	41	60	0	0	0
91	171	0	0	28	60	0	0	0
91	22	0	1	25	60	4	0	0
91	410	0	1	40	60	0	0	0
91	153	0	1	39	60	0	0	0
91	70	2	0	49	60	3	0	0
91	113	0	0	43	60	0	0	0
91	221	0	0	26	60	5	1	0
92	315	0	1	50	60	0	0	0
92	357	1	0	20	60	1	0	0
92	421	1	0	49	60	3	0	0
92	51	1	0	23	60	4	0	0
92	297	1	0	49	60	0	0	0
92	126	2	1	41	60	1	0	0
92	148	0	1	42	60	0	0	0
92	249	0	0	28	60	3	0	0
93	227	2	0	50	60	5	0	0
93	259	1	0	33	60	1	1	0
93	130	2	0	25	60	2	0	0
93	333	0	1	47	60	2	1	0
93	404	2	1	48	60	0	0	0
93	418	0	1	43	60	4	0	0
93	318	0	0	45	60	2	0	0
93	170	2	0	25	60	3	1	0
94	261	1	0	23	60	1	1	0
94	418	0	1	49	60	1	0	0
94	65	0	0	21	60	2	1	0
94	90	0	1	46	60	0	0	0
94	32	1	0	49	60	5	0	0
94	118	0	1	42	60	0	0	0
94	201	0	1	29	60	2	0	0
94	219	0	0	32	60	2	0	0
95	181	2	0	35	60	2	0	0
95	28	2	1	29	60	1	0	0
95	237	1	0	37	60	5	0	0
95	205	0	1	34	60	2	1	0
95	489	1	1	26	60	2	1	0
95	23	0	0	26	60	2	0	0
95	82	0	0	26	60	3	0	0
95	356	1	1	49	60	4	0	0
96	427	2	0	41	60	0	0	0
96	62	1	1	48	60	1	0	0
96	220	1	0	36	60	1	0	0
96	122	1	0	33	60	5	0	0
96	240	2	1	36	60	0	0	0
96	468	1	1	40	60	3	0	0
96	153	1	1	36	60	4	0	0
96	420	1	1	24	60	5	0	0
97	42	0	1	27	60	2	0	0
97	301	1	0	28	60	2	1	0
97	41	0	0	25	60	4	0	0
97	472	0	1	49	60	1	0	0
97	493	0	1	22	60	1	0	0
97	205	1	0	37	60	3	0	0
97	237	0	0	48	60	4	0	0
97	212	1	0	26	60	5	0	0
98	181	1	1	37	60	1	0	0
98	440	0	0	22	60	4	0	0
98	188	0	0	44	60	4	0	0
98	193	0	0	34	60	0	1	0
98	413	0	0	34	60	1	1	0
98	265	2	0	41	60	2	0	0
98	454	1	0	32	60	0	0	0
98	277	2	1	30	60	2	1	0
99	231	0	1	48	60	3	0	0
99	370	0	0	37	60	5	0	0
99	184	2	1	32	60	2	0	0
99	217	0	0	43	60	3	1	0
99	86	2	1	45	60	0	1	0
99	177	2	0	25	60	5	0	0
99	434	1	1	26	60	2	0	0
99	281	1	0	32	60	3	0	0
100	322	2	0	31	60	3	0	0
100	458	0	0	26	60	2	0	0
100	109	2	1	41	60	4	0	0
100	64	2	0	37	60	5	0	0
100	211	1	1	42	60	1	0	0
100	151	1	0	33	60	3	0	0
100	497	2	0	34	60	2	0	0
100	73	2	1	48	60	2	0	0
101	12	2	0	37	60	2	0	0
101	88	0	0	37	60	0	1	0
101	46	2	0	29	60	4	1	0
101	284	0	1	41	60	1	0	0
101	182	2	1	21	60	0	1	0
101	159	1	1	46	60	1	0	0
101	301	1	1	20	60	3	0	0
101	163	0	1	23	60	4	0	0
102	285	0	1	22	60	2	0	0
102	206	0	1	20	60	2	0	0
102	445	1	1	22	60	1	1	0
102	241	1	1	24	60	0	0	0
102	149	2	0	20	60	3	1	0
102	242	2	1	44	60	5	1	0
102	464	2	1	45	60	2	1	0
102	330	1	1	27	60	4	1	0
103	95	2	1	32	60	3	0	0
103	471	0	0	22	60	4	1	0
103	8	0	0	21	60	5	1	0
103	435	1	0	41	60	1	1	0
103	495	2	0	47	60	4	0	0
103	360	1	0	36	60	5	0	0
103	413	2	1	34	60	4	1	0
103	101	2	0	26	60	3	0	0
104	356	2	1	35	60	1	0	0
104	429	0	0	23	60	0	0	0
104	12	0	1	29	60	0	0	0
104	452	1	1	40	60	4	0	0
104	374	2	1	43	60	1	1	0
104	286	0	0	40	60	4	0	0
104	3	1	1	36	60	4	0	0
104	258	2	0	50	60	1	1	0
105	76	0	1	20	60	4	1	0
105	42	1	0	26	60	2	0	0
105	294	0	1	45	60	1	1	0
105	451	0	0	43	60	5	1	0
105	355	2	0	31	60	3	1	0
105	172	0	1	46	60	5	1	0
105	480	1	0	44	60	0	0	0
105	450	1	0	32	60	1	0	0
106	290	0	0	34	60	2	0	0
106	144	1	0	27	60	2	0	0
106	304	1	1	36	60	4	0	0
106	97	2	0	20	60	5	1	0
106	210	0	0	42	60	2	0	0
106	248	2	0	22	60	1	0	0
106	350	2	1	35	60	5	0	0
106	322	0	0	35	60	3	0	0
107	267	2	0	43	60	2	1	0
107	488	1	0	34	60	2	1	0
107	20	2	0	33	60	0	0	0
107	116	1	0	48	60	3	0	0
107	309	2	0	50	60	2	1	0
107	298	2	0	32	60	3	0	0
107	447	0	0	27	60	1	0	0
107	478	2	0	48	60	1	0	0
108	454	0	1	45	60	0	0	0
108	423	0	1	42	60	0	0	0
108	391	0	0	25	60	0	0	0
108	194	2	1	48	60	3	0	0
108	2	1	0	39	60	3	0	0
108	246	2	0	49	60	0	0	0
108	273	0	1	41	60	1	0	0
108	220	1	1	45	60	5	0	0
109	319	0	0	43	60	0	0	0
109	373	0	1	23	60	5	0	0
109	331	1	1	37	60	0	1	0
109	466	2	1	25	60	4	0	0
109	192	2	1	30	60	2	0	0
109	391	2	1	46	60	1	1	0
109	322	1	0	25	60	3	1	0
109	294	1	1	46	60	2	0	0
110	126	2	1	32	60	4	0	0
110	249	2	0	23	60	2	1	0
110	71	0	1	23	60	4	0	0
110	292	2	0	20	60	0	0	0
110	452	1	1	38	60	1	1	0
110	100	2	0	20	60	5	1	0
110	397	0	0	41	60	1	0	0
110	123	1	0	39	60	5	1	0
111	424	2	0	46	60	5	1	0
111	237	2	0	27	60	5	0	0
111	477	1	0	28	60	3	0	0
111	192	0	1	48	60	5	0	0
111	176	2	0	20	60	5	1	0
111	40	1	0	40	60	5	0	0
111	122	1	1	44	60	0	0	0
111	150	0	1	47	60	0	0	0
112	6	2	1	35	60	5	0	0
112	445	1	1	32	60	5	1	0
112	118	0	0	44	60	4	0	0
112	302	0	1	48	60	2	1	0
112	345	1	0	27	60	4	1	0
112	432	0	0	30	60	5	0	0
112	478	2	1	27	60	5	1	0
112	145	1	0	21	60	1	0	0
113	368	2	1	21	60	1	0	0
113	329	0	1	26	60	1	0	0
113	30	1	0	46	60	4	0	0
113	128	2	0	34	60	1	0	0
113	25	1	0	25	60	3	0	0
113	374	1	0	47	60	5	0	0
113	254	0	0	35	60	5	0	0
113	462	1	0	31	60	4	0	0
114	432	1	0	33	60	2	0	0
114	98	1	0	37	60	5	0	0
114	382	2	0	26	60	2	0	0
114	104	2	0	39	60	5	0	0
114	163	2	1	38	60	4	0	0
114	42	0	1	26	60	0	1	0
114	488	2	1	42	60	5	0	0
114	145	2	1	45	60	0	0	0
115	233	2	1	47	60	5	0	0
115	55	1	0	32	60	4	1	0
115	269	1	1	32	60	5	1	0
115	375	2	0	28	60	4	0	0
115	401	2	1	27	60	5	0	0
115	84	1	1	29	60	3	0	0
115	344	0	0	37	60	2	0	0
115	440	0	0	41	60	1	0	0
116	22	2	0	33	60	4	1	0
116	305	0	1	24	60	0	0	0
116	362	1	1	23	60	4	1	0
116	213	1	0	37	60	5	0	0
116	433	2	0	41	60	0	0	0
116	292	1	1	25	60	1	0	0
116	276	1	0	28	60	3	0	0
116	309	1	0	32	60	5	0	0
117	326	2	1	25	60	2	0	0
117	252	2	1	22	60	2	0	0
117	409	2	0	43	60	0	0	0
117	204	1	0	31	60	4	0	0
117	401	1	0	34	60	1	0	0
117	473	2	1	37	60	5	0	0
117	410	2	1	35	60	0	1	0
117	18	0	1	21	60	1	0	0
118	143	2	1	50	60	1	0	0
118	4	0	0	37	60	1	0	0
118	63	1	1	25	60	2	0	0
118	311	1	1	28	60	4	0	0
118	24	1	0	41	60	4	0	0
118	176	2	0	35	60	5	0	0
118	416	2	0	32	60	0	0	0
118	268	2	1	27	60	0	0	0
119	23	0	0	30	60	2	1	0
119	348	1	1	45	60	3	0	0
119	210	1	1	50	60	3	0	0
119	41	1	1	34	60	2	0	0
119	89	1	0	37	60	5	1	0
119	263	0	0	46	60	1	1	0
119	122	2	1	44	60	0	0	0
119	389	1	0	39	60	3	1	0
120	129	1	1	21	60	1	0	0
120	86	0	0	27	60	3	0	0
120	431	1	0	20	60	3	0	0
120	43	1	0	34	60	4	0	0
120	420	2	0	22	60	1	1	0
120	168	0	0	21	60	4	1	0
120	145	2	1	49	60	1	0	0
120	150	0	1	24	60	4	1	0
121	21	1	0	44	60	0	0	0
121	199	0	1	22	60	2	0	0
121	384	1	1	45	60	5	0	0
121	327	1	0	24	60	4	0	0
121	19	1	1	32	60	0	0	0
121	290	1	1	37	60	2	0	0
121	337	1	1	20	60	4	1	0
121	180	1	0	49	60	3	0	0
122	175	2	1	31	60	2	1	0
122	97	1	1	47	60	2	0	0
122	117	0	0	25	60	5	0	0
122	166	0	1	36	60	5	1	0
122	145	1	1	27	60	2	0	0
122	331	2	1	29	60	4	0	0
122	13	1	0	34	60	0	0	0
122	73	2	1	37	60	2	0	0
123	116	2	1	48	60	2	0	0
123	340	2	1	38	60	2	1	0
123	126	1	0	33	60	3	1	0
123	9	1	1	49	60	1	0	0
123	222	2	1	35	60	5	0	0
123	117	1	0	38	60	0	0	0
123	495	2	1	41	60	2	0	0
123	28	2	0	20	60	3	0	0
124	41	2	1	46	60	5	0	0
124	415	2	0	44	60	2	0	0
124	494	1	1	35	60	5	0	0
124	227	2	1	33	60	0	0	0
124	311	2	1	42	60	5	1	0
124	130	2	1	32	60	0	1	0
124	175	1	0	45	60	1	0	0
124	377	0	1	47	60	1	0	0
125	188	2	1	25	60	2	0	0
125	272	0	0	21	60	4	0	0
125	220	1	1	46	60	5	1	0
125	305	2	1	30	60	0	0	0
125	140	2	0	35	60	4	0	0
125	341	2	1	35	60	2	0	0
125	283	2	1	28	60	5	0	0
125	263	1	1	23	60	1	0	0
126	375	1	1	24	60	5	0	0
126	193	1	0	27	60	2	0	0
126	442	0	0	31	60	1	0	0
126	395	0	0	32	60	5	0	0
126	149	0	1	26	60	3	0	0
126	385	2	1	21	60	3	0	0
126	465	1	1	38	60	4	1	0
126	56	0	0	20	60	1	1	0
127	165	2	1	40	60	3	0	0
127	225	0	1	24	60	3	0	0
127	326	1	0	40	60	1	0	0
127	29	2	1	32	60	2	0	0
127	230	0	1	42	60	3	0	0
127	74	1	1	43	60	1	0	0
127	459	0	1	48	60	0	0	0
127	262	0	0	46	60	3	0	0
128	185	2	1	31	60	0	0	0
128	499	1	1	27	60	3	0	0
128	220	0	0	35	60	0	1	0
128	76	0	0	34	60	4	0	0
128	327	0	0	21	60	0	0	0
128	343	0	1	23	60	3	1	0
128	267	2	0	29	60	0	0	0
128	386	0	1	32	60	4	0	0
129	439	1	1	36	60	1	0	0
129	150	2	1	36	60	2	0	0
129	212	0	1	43	60	5	0	0
129	16	1	0	30	60	1	0	0
129	357	2	0	36	60	3	0	0
129	222	0	1	21	60	2	1	0
129	127	2	0	45	60	4	0	0
129	171	2	1	41	60	0	0	0
130	234	1	1	29	60	3	1	0
130	64	2	1	39	60	3	0	0
130	119	2	1	28	60	5	1	0
130	336	1	1	48	60	5	1	0
130	331	0	0	25	60	4	0	0
130	453	0	1	40	60	4	0	0
130	171	2	0	43	60	4	0	0
130	487	0	0	26	60	5	0	0
131	424	2	1	42	60	2	0	0
131	152	2	0	49	60	4	1	0
131	42	2	0	25	60	2	1	0
131	73	2	0	40	60	1	0	0
131	423	2	0	31	60	0	0	0
131	272	1	0	41	60	1	0	0
131	419	0	0	45	60	0	0	0
131	125	0	1	41	60	3	0	0
132	237	0	1	31	60	0	1	0
132	114	0	0	20	60	2	0	0
132	72	1	1	41	60	2	0	0
132	465	0	0	49	60	1	0	0
132	221	0	1	45	60	1	0	0
132	163	1	0	45	60	1	0	0
132	402	1	0	28	60	2	1	0
132	500	2	0	32	60	5	0	0
133	108	1	0	21	60	0	0	0
133	451	0	0	46	60	2	1	0
133	355	0	0	38	60	5	0	0
133	452	2	1	35	60	0	1	0
133	476	2	0	47	60	1	0	0
133	64	1	1	47	60	2	0	0
133	2	1	0	37	60	3	1	0
133	492	2	0	34	60	0	0	0
134	117	2	0	35	60	2	1	0
134	11	1	0	30	60	3	0	0
134	370	0	1	35	60	3	0	0
134	429	1	1	38	60	0	0	0
134	415	2	0	31	60	0	0	0
134	449	0	1	48	60	4	0	0
134	156	2	1	45	60	5	1	0
134	412	2	1	40	60	5	1	0
135	387	1	1	44	60	3	0	0
135	448	0	1	27	60	3	0	0
135	477	0	0	22	60	5	0	0
135	267	2	0	49	60	0	0	0
135	214	0	0	27	60	1	0	0
135	252	0	0	40	60	2	0	0
135	432	0	0	21	60	0	0	0
135	233	0	1	22	60	4	0	0
136	433	0	1	32	60	5	0	0
136	480	1	0	35	60	4	1	0
136	202	0	0	23	60	1	1	0
136	37	2	0	32	60	3	1	0
136	217	2	0	49	60	2	0	0
136	400	2	1	35	60	5	1	0
136	123	0	1	47	60	0	0	0
136	163	0	1	35	60	1	0	0
137	227	1	1	37	60	4	0	0
137	448	2	1	32	60	3	0	0
137	115	1	0	43	60	5	1	0
137	204	0	1	22	60	3	0	0
137	415	0	1	30	60	0	0	0
137	303	1	1	48	60	2	0	0
137	376	2	0	46	60	3	0	0
137	351	0	1	43	60	1	0	0
138	151	1	1	35	60	0	0	0
138	79	2	0	40	60	5	1	0
138	128	2	0	28	60	5	0	0
138	314	1	1	30	60	0	1	0
138	81	1	1	46	60	2	0	0
138	278	2	0	28	60	3	1	0
138	429	1	0	46	60	0	1	0
138	387	0	0	29	60	5	1	0
139	495	2	0	50	60	1	0	0
139	496	1	1	41	60	0	0	0
139	420	1	0	45	60	1	0	0
139	483	1	1	21	60	5	0	0
139	453	1	1	28	60	1	0	0
139	358	1	1	48	60	0	0	0
139	204	1	1	34	60	5	0	0
139	132	1	0	21	60	3	0	0
140	284	0	0	33	60	1	0	0
140	204	0	0	22	60	3	0	0
140	287	0	0	36	60	2	0	0
140	470	0	0	31	60	5	0	0
140	460	0	1	24	60	0	0	0
140	364	1	1	42	60	2	0	0
140	256	0	1	44	60	4	0	0
140	459	0	1	21	60	2	0	0
141	149	0	0	38	60	0	1	0
141	83	2	0	30	60	4	0	0
141	349	0	0	48	60	5	0	0
141	148	2	1	50	60	0	0	0
141	236	2	1	28	60	4	1	0
141	200	1	1	24	60	5	1	0
141	13	1	0	32	60	5	0	0
141	6	2	1	24	60	2	0	0
142	346	2	0	30	60	0	0	0
142	97	0	1	47	60	3	0	0
142	381	2	1	43	60	0	1	0
142	379	1	0	39	60	5	0	0
142	442	1	0	28	60	1	0	0
142	24	0	0	35	60	3	0	0
142	420	2	0	42	60	4	1	0
142	373	1	0	45	60	2	0	0
143	367	0	0	43	60	5	0	0
143	444	2	1	23	60	3	0	0
143	230	2	0	33	60	4	1	0
143	165	2	0	38	60	3	0	0
143	136	2	0	28	60	5	0	0
143	301	0	1	30	60	4	0	0
143	39	1	0	32	60	5	0	0
143	279	1	1	20	60	0	1	0
144	19	2	0	39	60	5	0	0
144	482	0	1	29	60	1	0	0
144	215	0	0	35	60	5	1	0
144	67	1	0	41	60	0	0	0
144	249	0	0	29	60	5	0	0
144	241	2	1	47	60	4	0	0
144	185	2	1	45	60	0	0	0
144	458	0	0	24	60	0	1	0
145	84	0	1	41	60	0	0	0
145	408	0	0	34	60	2	1	0
145	265	2	0	25	60	2	1	0
145	200	0	0	24	60	5	0	0
145	213	1	0	38	60	4	0	0
145	173	2	1	39	60	1	1	0
145	463	1	1	50	60	2	0	0
145	272	1	1	26	60	1	0	0
146	392	0	0	21	60	1	0	0
146	166	2	1	29	60	4	0	0
146	45	0	0	37	60	4	0	0
146	468	0	0	24	60	4	0	0
146	404	2	1	36	60	1	0	0
146	266	0	0	26	60	0	0	0
146	299	2	0	43	60	1	0	0
146	374	0	0	38	60	2	0	0
147	488	1	1	29	60	5	0	0
147	250	1	0	28	60	5	0	0
147	4	1	1	41	60	1	1	0
147	294	0	1	20	60	1	0	0
147	166	2	1	31	60	5	1	0
147	194	1	1	21	60	0	1	0
147	439	2	0	35	60	2	0	0
147	15	0	0	49	60	3	1	0
148	157	1	0	32	60	0	0	0
148	19	0	0	44	60	3	0	0
148	485	1	0	22	60	3	0	0
148	481	0	0	50	60	1	0	0
148	131	1	0	33	60	0	0	0
148	407	2	0	32	60	4	0	0
148	141	0	1	20	60	1	0	0
148	102	1	1	41	60	0	0	0
149	407	2	1	29	60	1	0	0
149	361	1	1	47	60	5	0	0
149	102	1	0	32	60	2	0	0
149	13	2	1	46	60	3	0	0
149	16	2	0	31	60	5	0	0
149	277	1	1	47	60	5	0	0
149	213	2	0	31	60	5	1	0
149	334	1	1	45	60	1	0	0
150	377	0	0	35	60	0	1	0
150	97	0	0	24	60	2	1	0
150	317	0	0	43	60	3	0	0
150	106	2	0	20	60	5	1	0
150	205	0	0	27	60	2	1	0
150	147	0	0	27	60	5	0	0
150	122	0	1	36	60	2	0	0
150	47	2	1	23	60	1	0	0
151	128	0	1	26	60	0	0	0
151	155	0	1	30	60	5	0	0
151	331	1	0	33	60	3	0	0
151	415	2	1	34	60	1	0	0
151	15	2	0	30	60	3	0	0
151	307	1	0	25	60	3	1	0
151	12	0	1	26	60	1	1	0
151	151	2	0	29	60	0	0	0
152	300	0	0	21	60	2	1	0
152	329	0	1	32	60	0	0	0
152	40	0	1	39	60	5	0	0
152	307	2	1	33	60	4	0	0
152	438	1	1	24	60	1	0	0
152	364	1	0	44	60	0	0	0
152	333	2	1	39	60	0	0	0
152	286	1	1	47	60	4	0	0
153	427	0	0	50	60	5	1	0
153	498	1	0	27	60	1	0	0
153	128	2	0	41	60	5	0	0
153	203	1	1	36	60	2	0	0
153	90	0	1	38	60	1	0	0
153	419	1	1	50	60	2	0	0
153	37	1	1	35	60	3	0	0
153	238	0	1	39	60	3	0	0
154	234	0	1	44	60	5	0	0
154	447	0	0	41	60	5	0	0
154	298	1	0	26	60	5	1	0
154	62	2	0	35	60	3	0	0
154	333	0	1	34	60	4	0	0
154	417	1	1	26	60	0	0	0
154	220	0	1	27	60	0	0	0
154	392	2	0	26	60	1	0	0
155	174	0	0	37	60	0	0	0
155	105	1	1	31	60	2	1	0
155	113	2	1	41	60	0	1	0
155	76	0	0	33	60	1	0	0
155	413	1	0	24	60	2	0	0
155	7	0	1	20	60	5	0	0
155	418	0	1	27	60	3	0	0
155	307	2	0	24	60	2	0	0
156	163	0	0	31	60	1	0	0
156	443	1	0	21	60	0	0	0
156	244	1	1	41	60	0	0	0
156	471	1	1	33	60	4	1	0
156	147	2	1	43	60	3	0	0
156	328	0	0	29	60	2	0	0
156	245	2	0	49	60	0	0	0
156	436	0	1	20	60	1	0	0
157	95	0	0	36	60	0	0	0
157	448	1	1	34	60	1	0	0
157	382	1	1	47	60	5	0	0
157	198	0	1	22	60	0	0	0
157	268	1	1	43	60	4	0	0
157	42	0	0	36	60	0	0	0
157	149	1	0	47	60	3	0	0
157	216	0	1	25	60	3	0	0
158	217	0	1	46	60	5	0	0
158	482	2	0	31	60	2	0	0
158	196	0	1	35	60	3	0	0
158	458	2	0	50	60	3	0	0
158	168	1	1	20	60	2	0	0
158	390	1	1	28	60	2	0	0
158	441	1	0	45	60	5	1	0
158	187	1	1	22	60	0	0	0
159	440	0	1	47	60	1	0	0
159	193	1	1	27	60	1	0	0
159	459	0	0	26	60	5	0	0
159	129	1	1	25	60	1	0	0
159	321	2	0	21	60	5	0	0
159	332	0	0	33	60	0	1	0
159	405	2	1	26	60	2	0	0
159	316	0	1	39	60	0	1	0
160	283	0	1	31	60	0	0	0
160	157	1	1	26	60	3	1	0
160	381	1	0	38	60	4	1	0
160	406	1	0	37	60	5	0	0
160	436	1	0	50	60	0	0	0
160	178	0	1	47	60	4	0	0
160	445	2	0	20	60	3	0	0
160	470	1	0	46	60	2	0	0
161	93	0	1	48	60	5	0	0
161	83	1	1	45	60	0	0	0
161	494	0	1	21	60	3	0	0
161	387	1	0	20	60	3	0	0
161	297	0	0	35	60	2	0	0
161	241	2	0	37	60	2	0	0
161	109	2	1	33	60	2	1	0
161	261	0	1	26	60	2	0	0
162	435	2	1	26	60	2	0	0
162	376	1	1	36	60	2	0	0
162	63	1	1	34	60	0	0	0
162	458	1	0	48	60	4	0	0
162	180	2	0	35	60	5	0	0
162	103	0	1	50	60	5	0	0
162	361	2	0	30	60	2	0	0
162	348	1	1	22	60	5	0	0
163	486	1	1	24	60	3	0	0
163	303	0	0	20	60	0	1	0
163	258	1	1	44	60	1	1	0
163	460	2	0	27	60	0	1	0
163	311	0	0	42	60	1	0	0
163	201	2	0	20	60	1	1	0
163	288	2	0	21	60	0	1	0
163	453	0	1	41	60	2	0	0
164	36	1	0	40	60	0	0	0
164	140	0	1	28	60	2	1	0
164	225	1	1	31	60	3	1	0
164	279	0	1	45	60	3	0	0
164	442	2	0	30	60	2	0	0
164	489	1	1	36	60	1	0	0
164	443	0	0	44	60	3	0	0
164	218	0	0	45	60	0	0	0
165	332	0	0	21	60	5	1	0
165	116	1	1	22	60	4	0	0
165	58	2	1	48	60	5	0	0
165	410	1	1	27	60	0	0	0
165	73	0	1	43	60	1	0	0
165	112	0	1	26	60	4	1	0
165	400	2	1	30	60	1	0	0
165	29	1	1	47	60	0	0	0
166	461	1	0	25	60	0	1	0
166	66	2	1	27	60	2	0	0
166	451	0	1	33	60	1	1	0
166	170	1	0	46	60	4	0	0
166	159	0	0	22	60	1	0	0
166	383	0	1	27	60	2	0	0
166	387	1	0	21	60	0	0	0
166	129	0	0	36	60	3	0	0
167	23	0	0	26	60	4	0	0
167	438	2	0	38	60	2	0	0
167	276	2	0	36	60	0	0	0
167	182	0	1	46	60	1	1	0
167	369	1	1	28	60	0	0	0
167	225	2	1	49	60	1	0	0
167	382	0	0	44	60	5	0	0
167	178	0	1	33	60	5	0	0
168	424	2	0	25	60	1	1	0
168	390	2	1	30	60	3	1	0
168	260	2	1	31	60	1	0	0
168	327	2	1	42	60	2	0	0
168	259	2	1	47	60	0	0	0
168	100	2	1	49	60	2	0	0
168	172	1	1	27	60	0	0	0
168	10	0	1	24	60	2	0	0
169	275	1	0	48	60	5	1	0
169	496	0	1	41	60	1	0	0
169	86	2	0	22	60	2	0	0
169	411	0	1	27	60	3	0	0
169	205	0	1	24	60	4	0	0
169	124	0	1	24	60	4	0	0
169	436	1	1	46	60	4	0	0
169	76	2	0	32	60	2	0	0
170	323	1	0	27	60	5	0	0
170	379	2	0	24	60	5	0	0
170	46	0	1	27	60	4	0	0
170	450	1	1	37	60	1	0	0
170	390	0	0	45	60	3	1	0
170	55	1	1	40	60	3	0	0
170	469	2	0	26	60	0	1	0
170	71	1	0	21	60	0	0	0
171	268	1	1	26	60	1	1	0
171	367	2	0	21	60	2	1	0
171	166	1	1	20	60	1	0	0
171	223	1	0	22	60	2	1	0
171	61	2	1	49	60	0	0	0
171	29	0	1	23	60	2	0	0
171	136	1	1	30	60	2	1	0
171	335	2	0	47	60	3	0	0
172	27	1	0	30	60	1	1	0
172	292	2	1	30	60	2	1	0
172	20	1	0	28	60	1	0	0
172	342	1	1	28	60	2	0	0
172	406	2	0	45	60	5	0	0
172	194	1	0	50	60	0	0	0
172	30	2	1	24	60	5	0	0
172	120	0	1	26	60	2	1	0
173	53	2	0	44	60	3	0	0
173	363	0	1	33	60	3	1	0
173	27	2	1	42	60	0	0	0
173	49	2	1	30	60	2	0	0
173	70	0	1	25	60	2	0	0
173	99	0	1	48	60	0	0	0
173	477	2	1	39	60	5	1	0
173	482	0	0	36	60	0	0	0
174	77	0	0	25	60	0	0	0
174	93	1	0	33	60	5	0	0
174	322	0	1	33	60	0	0	0
174	83	1	1	41	60	5	0	0
174	161	0	0	42	60	3	0	0
174	254	0	0	43	60	3	0	0
174	181	0	1	26	60	1	0	0
174	370	1	0	21	60	0	0	0
175	125	2	0	50	60	0	0	0
175	411	0	1	43	60	2	0	0
175	415	2	0	37	60	5	0	0
175	132	0	1	48	60	5	1	0
175	238	0	0	49	60	1	0	0
175	357	1	1	24	60	0	0	0
175	394	2	1	42	60	1	1	0
175	22	0	1	50	60	0	0	0
176	305	1	1	29	60	5	1	0
176	222	1	1	20	60	2	0	0
176	103	1	0	20	60	3	0	0
176	189	2	1	49	60	4	0	0
176	169	2	0	20	60	0	0	0
176	85	0	0	43	60	1	0	0
176	264	1	0	50	60	3	1	0
176	184	0	0	47	60	4	0	0
177	423	0	0	46	60	2	0	0
177	293	0	0	28	60	4	0	0
177	72	2	0	35	60	3	0	0
177	428	1	0	23	60	3	0	0
177	489	2	0	28	60	2	0	0
177	172	1	1	28	60	3	0	0
177	322	0	1	23	60	4	1	0
177	234	0	0	35	60	5	0	0
178	294	1	0	27	60	1	0	0
178	204	2	0	35	60	5	1	0
178	326	2	0	28	60	2	1	0
178	31	1	1	27	60	3	1	0
178	58	1	1	47	60	3	0	0
178	68	0	0	27	60	3	0	0
178	435	0	0	34	60	4	0	0
178	287	0	0	31	60	4	0	0
179	212	0	1	44	60	0	1	0
179	412	0	0	34	60	0	0	0
179	272	2	1	44	60	5	0	0
179	238	1	1	23	60	0	0	0
179	112	2	0	41	60	5	1	0
179	371	1	1	37	60	3	0	0
179	202	1	1	29	60	3	0	0
179	169	2	0	45	60	2	1	0
180	404	2	1	49	60	3	0	0
180	2	1	1	30	60	4	1	0
180	303	2	1	39	60	0	0	0
180	247	0	1	45	60	1	0	0
180	394	2	0	24	60	2	0	0
180	136	2	0	41	60	2	0	0
180	10	2	1	48	60	1	0	0
180	485	2	0	43	60	2	0	0
181	38	0	1	33	60	4	0	0
181	177	1	1	45	60	5	0	0
181	275	0	0	41	60	2	0	0
181	148	1	0	36	60	0	0	0
181	247	2	0	24	60	0	1	0
181	261	2	1	32	60	1	0	0
181	255	0	0	36	60	1	0	0
181	288	0	0	50	60	1	0	0
182	12	1	0	33	60	1	1	0
182	128	2	0	21	60	3	1	0
182	163	0	1	49	60	4	0	0
182	379	0	0	26	60	0	1	0
182	427	2	0	47	60	2	0	0
182	200	0	0	46	60	4	0	0
182	269	2	0	40	60	2	0	0
182	265	2	0	42	60	3	0	0
183	311	1	0	40	60	1	0	0
183	202	1	1	38	60	2	0	0
183	78	1	0	40	60	4	0	0
183	108	0	1	33	60	0	0	0
183	234	2	1	32	60	5	0	0
183	66	2	1	48	60	1	0	0
183	333	1	0	38	60	1	0	0
183	385	0	1	34	60	4	1	0
184	375	0	0	28	60	0	0	0
184	364	0	1	21	60	1	0	0
184	438	2	1	47	60	0	1	0
184	15	2	0	30	60	2	0	0
184	437	0	1	24	60	2	0	0
184	472	1	1	35	60	5	0	0
184	216	2	0	24	60	1	1	0
184	173	2	0	45	60	1	0	0
185	135	2	0	23	60	0	0	0
185	112	1	1	23	60	2	0	0
185	248	0	0	31	60	3	0	0
185	87	0	1	38	60	5	0	0
185	308	0	0	32	60	2	0	0
185	291	2	0	28	60	5	1	0
185	375	2	1	28	60	4	0	0
185	24	0	0	35	60	1	0	0
186	89	2	1	40	60	5	1	0
186	283	1	0	36	60	3	0	0
186	86	0	1	30	60	4	0	0
186	30	2	0	36	60	2	0	0
186	161	1	0	21	60	4	0	0
186	404	1	0	38	60	1	0	0
186	449	1	0	29	60	1	1	0
186	119	0	0	22	60	4	0	0
187	146	2	0	20	60	5	0	0
187	50	2	1	41	60	0	0	0
187	38	1	0	50	60	2	0	0
187	292	2	1	24	60	4	0	0
187	370	2	1	26	60	4	0	0
187	248	2	0	33	60	3	0	0
187	33	1	1	24	60	5	0	0
187	485	0	1	29	60	3	0	0
188	427	2	1	27	60	3	0	0
188	90	0	1	44	60	3	1	0
188	119	0	0	48	60	4	0	0
188	499	2	0	40	60	2	0	0
188	409	2	0	45	60	3	1	0
188	476	2	1	35	60	2	0	0
188	183	0	1	36	60	2	0	0
188	494	1	0	44	60	2	0	0
189	429	1	1	49	60	3	0	0
189	231	1	1	33	60	1	0	0
189	472	2	0	49	60	3	0	0
189	110	2	0	31	60	2	1	0
189	137	1	1	46	60	2	0	0
189	210	1	0	49	60	4	1	0
189	79	0	0	20	60	4	0	0
189	166	1	1	44	60	1	0	0
190	116	2	1	27	60	1	0	0
190	310	0	0	45	60	4	1	0
190	7	2	1	23	60	5	0	0
190	91	1	0	35	60	0	0	0
190	136	1	1	26	60	3	0	0
190	84	1	1	38	60	0	0	0
190	234	2	1	46	60	3	1	0
190	264	1	0	22	60	0	0	0
191	104	2	1	26	60	3	1	0
191	407	0	0	21	60	3	1	0
191	403	2	1	33	60	5	0	0
191	53	2	1	26	60	5	0	0
191	311	2	0	46	60	4	0	0
191	269	1	0	21	60	0	1	0
191	398	0	1	33	60	0	0	0
191	126	2	0	32	60	1	0	0
192	248	0	0	44	60	5	0	0
192	142	0	0	40	60	5	1	0
192	130	1	0	48	60	1	0	0
192	90	2	1	36	60	2	1	0
192	292	1	1	42	60	2	0	0
192	126	1	1	26	60	4	0	0
192	387	0	0	32	60	4	0	0
192	330	1	1	46	60	2	0	0
193	116	1	0	33	60	1	0	0
193	491	0	0	31	60	5	0	0
193	296	1	0	23	60	4	0	0
193	318	2	0	46	60	1	0	0
193	451	0	1	43	60	3	1	0
193	278	1	1	39	60	4	0	0
193	465	0	1	42	60	4	0	0
193	106	1	1	44	60	2	0	0
194	89	1	1	24	60	0	0	0
194	181	2	0	34	60	4	0	0
194	389	2	1	32	60	1	1	0
194	8	0	0	41	60	1	1	0
194	358	1	0	45	60	4	0	0
194	200	0	1	37	60	2	0	0
194	97	1	0	22	60	3	1	0
194	422	2	1	49	60	5	0	0
195	157	1	0	29	60	4	0	0
195	2	1	0	38	60	5	0	0
195	289	0	1	24	60	0	0	0
195	1	1	1	47	60	1	0	0
195	204	2	0	42	60	0	0	0
195	257	2	1	36	60	1	0	0
195	396	2	1	38	60	5	0	0
195	395	0	1	29	60	0	0	0
196	372	1	0	41	60	0	0	0
196	90	0	1	20	60	4	0	0
196	495	2	1	34	60	0	0	0
196	156	2	0	49	60	3	0	0
196	177	1	0	34	60	2	0	0
196	243	1	1	42	60	2	1	0
196	275	0	0	26	60	4	0	0
196	303	0	1	24	60	0	0	0
197	221	0	0	27	60	4	0	0
197	240	0	0	25	60	1	1	0
197	64	2	0	20	60	0	0	0
197	300	1	0	25	60	0	0	0
197	216	2	1	34	60	1	1	0
197	312	1	1	37	60	4	0	0
197	99	1	0	42	60	3	0	0
197	147	0	0	37	60	1	0	0
198	54	0	1	31	60	2	0	0
198	382	0	1	23	60	2	0	0
198	246	0	0	47	60	4	0	0
198	393	0	1	37	60	4	0	0
198	43	1	1	36	60	3	0	0
198	137	2	1	49	60	1	0	0
198	41	0	0	47	60	0	1	0
198	205	0	0	22	60	5	0	0
199	263	1	1	48	60	1	0	0
199	81	0	1	21	60	1	0	0
199	219	2	0	44	60	0	0	0
199	480	1	0	23	60	5	0	0
199	204	0	0	30	60	0	1	0
199	142	0	1	21	60	5	1	0
199	444	0	0	22	60	1	0	0
199	26	2	1	44	60	4	1	0
200	13	2	0	37	60	0	0	0
200	390	1	1	28	60	3	0	0
200	492	0	0	47	60	3	0	0
200	439	1	1	39	60	5	1	0
200	1	2	0	41	60	5	1	0
200	345	0	0	25	60	1	1	0
200	116	1	1	21	60	0	0	0
200	388	0	1	40	60	5	0	0
201	237	2	1	24	60	5	0	0
201	434	1	1	24	60	1	1	0
201	137	2	1	33	60	4	0	0
201	497	2	0	41	60	1	0	0
201	486	1	0	25	60	5	0	0
201	87	1	0	47	60	2	0	0
201	5	1	1	50	60	3	0	0
201	176	2	0	46	60	0	0	0
202	313	0	0	49	60	1	0	0
202	132	2	1	45	60	4	0	0
202	33	2	1	47	60	5	1	0
202	438	0	0	24	60	0	0	0
202	35	0	0	46	60	0	0	0
202	45	0	1	47	60	3	0	0
202	217	0	1	49	60	3	0	0
202	269	1	1	47	60	4	0	0
203	237	2	0	20	60	5	0	0
203	31	0	0	40	60	0	0	0
203	158	1	1	49	60	0	0	0
203	320	0	0	27	60	1	1	0
203	182	0	1	31	60	3	0	0
203	460	0	1	32	60	2	0	0
203	381	2	0	21	60	5	0	0
203	344	2	1	39	60	0	0	0
204	298	0	0	21	60	2	0	0
204	337	0	0	43	60	5	1	0
204	402	0	0	44	60	1	0	0
204	307	1	0	37	60	3	0	0
204	481	1	0	34	60	1	0	0
204	354	0	0	49	60	5	0	0
204	88	2	0	35	60	1	0	0
204	412	0	1	28	60	5	1	0
205	201	2	0	22	60	2	0	0
205	156	1	1	39	60	1	0	0
205	286	0	0	30	60	3	1	0
205	451	0	1	38	60	5	0	0
205	184	2	1	30	60	4	0	0
205	455	0	0	37	60	5	0	0
205	233	0	0	37	60	4	1	0
205	131	2	1	48	60	2	0	0
206	459	2	1	26	60	2	0	0
206	54	2	0	22	60	0	0	0
206	146	1	1	46	60	3	0	0
206	399	1	1	49	60	1	0	0
206	303	0	0	48	60	1	0	0
206	6	2	1	43	60	0	0	0
206	406	1	1	29	60	4	1	0
206	479	0	0	36	60	3	0	0
207	376	1	1	36	60	5	0	0
207	268	0	1	38	60	0	1	0
207	52	2	1	48	60	4	0	0
207	129	1	0	39	60	5	1	0
207	341	0	1	32	60	3	1	0
207	23	0	1	25	60	1	0	0
207	498	1	1	22	60	2	0	0
207	278	1	0	33	60	0	0	0
208	135	0	0	20	60	1	0	0
208	432	0	0	40	60	3	0	0
208	261	0	0	44	60	0	0	0
208	215	0	0	28	60	3	1	0
208	182	2	1	45	60	0	0	0
208	219	0	1	43	60	4	0	0
208	354	1	1	41	60	0	0	0
208	452	2	1	22	60	5	0	0
209	128	1	0	42	60	0	0	0
209	292	2	0	20	60	0	1	0
209	159	2	0	23	60	4	1	0
209	202	2	0	47	60	3	0	0
209	126	1	0	37	60	0	0	0
209	266	0	0	40	60	3	0	0
209	92	0	1	50	60	2	0	0
209	232	1	1	33	60	3	0	0
210	125	2	1	41	60	5	0	0
210	288	1	1	20	60	5	0	0
210	178	2	1	27	60	3	0	0
210	148	1	1	47	60	4	0	0
210	369	0	1	34	60	4	1	0
210	347	2	0	23	60	5	1	0
210	313	0	1	47	60	3	1	0
210	174	1	0	27	60	0	0	0
211	188	1	0	43	60	1	0	0
211	53	2	1	26	60	3	0	0
211	467	1	1	31	60	1	0	0
211	104	2	0	48	60	5	0	0
211	198	0	1	21	60	3	0	0
211	490	0	1	45	60	1	1	0
211	18	0	0	28	60	3	1	0
211	485	2	1	27	60	2	0	0
212	175	1	0	39	60	0	0	0
212	187	0	1	31	60	5	0	0
212	211	2	0	40	60	1	0	0
212	249	0	0	36	60	4	0	0
212	331	1	0	29	60	0	0	0
212	174	1	1	20	60	1	0	0
212	95	1	1	32	60	5	0	0
212	14	0	0	35	60	4	0	0
213	463	0	0	33	60	2	0	0
213	414	2	1	45	60	5	0	0
213	303	1	1	46	60	1	0	0
213	259	2	0	41	60	0	0	0
213	142	1	1	30	60	0	0	0
213	167	2	0	36	60	1	0	0
213	284	0	0	28	60	2	1	0
213	149	0	0	31	60	5	0	0
214	445	1	0	37	60	5	0	0
214	146	2	1	26	60	1	0	0
214	499	2	1	45	60	2	0	0
214	304	0	1	23	60	3	1	0
214	71	1	0	49	60	5	0	0
214	451	1	0	24	60	1	0	0
214	397	0	0	29	60	3	0	0
214	196	0	1	25	60	1	0	0
215	242	0	0	47	60	2	0	0
215	306	1	1	34	60	1	0	0
215	455	1	1	30	60	0	0	0
215	44	0	0	26	60	0	0	0
215	327	2	0	22	60	0	0	0
215	253	2	0	21	60	3	0	0
215	221	0	1	46	60	2	1	0
215	67	1	1	43	60	5	1	0
216	33	1	0	26	60	0	0	0
216	435	1	1	34	60	0	0	0
216	261	2	1	20	60	3	0	0
216	218	2	0	32	60	3	0	0
216	223	2	1	36	60	2	0	0
216	339	0	0	30	60	0	0	0
216	130	1	1	39	60	0	0	0
216	305	0	1	40	60	1	0	0
217	411	2	0	39	60	2	0	0
217	246	1	0	39	60	3	0	0
217	401	0	1	35	60	3	1	0
217	104	1	0	34	60	0	0	0
217	337	2	0	48	60	0	0	0
217	321	2	0	26	60	0	0	0
217	485	0	0	22	60	0	0	0
217	80	0	1	48	60	5	1	0
218	117	0	0	29	60	5	0	0
218	186	2	0	20	60	3	0	0
218	438	1	1	37	60	4	0	0
218	465	1	0	40	60	0	1	0
218	246	0	1	26	60	4	1	0
218	187	2	0	27	60	0	1	0
218	320	1	0	24	60	2	0	0
218	2	2	1	32	60	3	0	0
219	129	2	1	28	60	0	0	0
219	475	2	1	26	60	4	0	0
219	166	2	0	37	60	0	1	0
219	2	1	0	28	60	3	0	0
219	175	2	0	35	60	2	0	0
219	145	2	0	41	60	1	1	0
219	459	0	0	40	60	0	0	0
219	63	2	0	45	60	1	0	0
220	418	2	0	44	60	0	0	0
220	124	2	0	32	60	0	0	0
220	50	2	0	21	60	3	1	0
220	177	1	1	37	60	0	0	0
220	373	0	1	39	60	5	0	0
220	415	2	1	47	60	2	0	0
220	161	0	1	49	60	1	1	0
220	491	2	1	43	60	1	1	0
221	397	1	1	43	60	5	1	0
221	76	1	1	48	60	0	0	0
221	373	0	1	29	60	5	0	0
221	260	2	0	37	60	2	0	0
221	369	2	1	48	60	3	0	0
221	139	2	1	29	60	2	1	0
221	101	0	1	34	60	0	0	0
221	356	1	0	48	60	4	0	0
222	136	1	1	28	60	0	0	0
222	436	0	0	47	60	0	0	0
222	257	2	0	42	60	4	0	0
222	92	1	1	36	60	1	0	0
222	294	1	0	34	60	5	0	0
222	368	2	1	42	60	3	0	0
222	51	2	1	27	60	2	0	0
222	467	0	0	38	60	0	1	0
223	352	2	0	43	60	0	0	0
223	99	2	1	33	60	3	1	0
223	62	0	1	20	60	5	1	0
223	271	2	1	35	60	0	0	0
223	142	0	0	43	60	4	0	0
223	355	0	1	33	60	2	0	0
223	9	1	1	28	60	1	0	0
223	19	2	0	28	60	0	1	0
224	40	0	1	47	60	3	0	0
224	45	2	1	23	60	2	1	0
224	281	0	0	24	60	5	0	0
224	121	2	0	34	60	4	0	0
224	342	1	1	28	60	1	0	0
224	292	2	1	29	60	1	1	0
224	303	2	1	31	60	1	0	0
224	294	1	1	33	60	3	1	0
225	93	1	0	39	60	0	1	0
225	317	2	0	45	60	1	1	0
225	149	2	1	21	60	2	1	0
225	49	2	1	48	60	2	1	0
225	379	0	1	29	60	1	0	0
225	58	1	1	46	60	2	1	0
225	227	1	0	49	60	1	1	0
225	215	1	0	44	60	5	0	0
226	499	1	1	29	60	0	1	0
226	96	2	0	21	60	5	0	0
226	279	0	1	45	60	1	1	0
226	389	0	0	26	60	1	1	0
226	305	0	1	50	60	2	0	0
226	423	1	0	43	60	4	0	0
226	379	2	0	30	60	0	0	0
226	348	1	0	47	60	0	0	0
227	490	2	1	26	60	4	0	0
227	97	1	1	34	60	5	0	0
227	426	1	1	36	60	1	0	0
227	378	1	1	47	60	3	0	0
227	372	2	0	43	60	4	0	0
227	226	2	1	31	60	2	0	0
227	152	1	1	37	60	4	0	0
227	415	0	0	23	60	2	0	0
228	130	0	1	50	60	2	1	0
228	423	1	0	44	60	3	0	0
228	142	0	0	49	60	4	0	0
228	19	1	1	48	60	4	0	0
228	361	1	1	26	60	1	0	0
228	323	2	0	42	60	2	0	0
228	46	1	0	22	60	1	1	0
228	461	2	0	32	60	1	1	0
229	370	1	1	34	60	5	0	0
229	49	1	0	44	60	3	0	0
229	100	2	1	21	60	5	0	0
229	397	0	1	31	60	5	1	0
229	288	0	1	28	60	5	0	0
229	202	0	1	38	60	3	0	0
229	128	0	1	43	60	3	0	0
229	201	0	1	40	60	3	1	0
230	56	1	0	41	60	0	0	0
230	50	2	0	30	60	5	1	0
230	483	2	1	48	60	5	0	0
230	267	2	0	37	60	0	0	0
230	312	0	0	43	60	5	0	0
230	184	2	1	36	60	0	0	0
230	348	1	0	30	60	5	1	0
230	279	1	1	25	60	4	0	0
231	382	0	1	21	60	0	0	0
231	351	2	1	26	60	5	0	0
231	416	0	0	40	60	0	0	0
231	245	2	1	28	60	2	0	0
231	38	2	1	39	60	5	0	0
231	11	1	0	44	60	3	0	0
231	401	2	1	45	60	2	0	0
231	435	0	0	24	60	2	0	0
232	209	0	0	22	60	2	0	0
232	305	0	0	49	60	5	0	0
232	115	1	1	44	60	3	0	0
232	107	0	1	36	60	2	0	0
232	362	2	0	32	60	4	1	0
232	486	2	0	21	60	1	0	0
232	71	1	0	46	60	5	0	0
232	148	0	1	26	60	1	0	0
233	47	0	0	21	60	1	0	0
233	164	1	0	24	60	3	0	0
233	228	2	0	28	60	1	1	0
233	386	0	1	25	60	2	1	0
233	97	1	1	23	60	5	0	0
233	150	2	1	28	60	4	0	0
233	330	2	0	44	60	4	0	0
233	297	1	1	40	60	4	0	0
234	381	1	0	35	60	1	0	0
234	467	0	1	22	60	3	0	0
234	464	2	1	21	60	5	0	0
234	211	0	1	27	60	0	0	0
234	41	1	1	40	60	4	1	0
234	18	2	1	46	60	0	0	0
234	143	2	1	27	60	3	0	0
234	83	2	1	30	60	2	0	0
235	143	0	1	48	60	4	0	0
235	19	1	1	27	60	5	0	0
235	55	0	1	30	60	4	0	0
235	178	2	0	46	60	2	0	0
235	136	2	0	27	60	5	0	0
235	483	2	1	32	60	5	1	0
235	36	2	1	25	60	3	0	0
235	301	2	0	37	60	5	0	0
236	442	0	1	33	60	2	0	0
236	246	1	1	34	60	4	0	0
236	312	0	0	34	60	4	1	0
236	483	2	1	49	60	0	1	0
236	183	1	1	45	60	1	0	0
236	337	0	1	39	60	3	0	0
236	350	2	1	21	60	2	0	0
236	179	1	0	50	60	4	0	0
237	35	0	1	47	60	3	0	0
237	124	1	1	39	60	4	0	0
237	104	0	1	29	60	3	0	0
237	125	0	0	32	60	4	0	0
237	131	1	1	24	60	0	0	0
237	482	0	1	46	60	3	0	0
237	222	1	0	22	60	3	1	0
237	58	1	1	21	60	5	1	0
238	237	0	1	41	60	3	1	0
238	489	1	0	34	60	0	1	0
238	385	2	1	37	60	0	1	0
238	248	0	1	40	60	2	0	0
238	4	2	1	34	60	4	0	0
238	475	2	1	39	60	5	0	0
238	104	2	1	29	60	2	0	0
238	332	0	1	49	60	2	0	0
239	136	1	1	34	60	5	0	0
239	149	2	1	37	60	5	0	0
239	428	2	1	34	60	5	0	0
239	168	2	0	30	60	5	0	0
239	348	2	1	25	60	3	1	0
239	37	0	0	46	60	2	0	0
239	370	1	1	45	60	1	0	0
239	356	2	0	39	60	4	0	0
240	437	1	0	29	60	1	0	0
240	498	0	0	34	60	4	0	0
240	156	2	0	36	60	5	1	0
240	56	2	1	30	60	5	0	0
240	425	2	1	32	60	0	0	0
240	53	0	0	39	60	4	0	0
240	14	1	0	45	60	1	0	0
240	114	2	1	25	60	5	1	0
241	152	0	0	21	60	3	1	0
241	303	2	1	31	60	0	1	0
241	217	2	1	49	60	5	0	0
241	384	0	0	21	60	0	0	0
241	296	2	1	47	60	1	1	0
241	145	1	0	36	60	5	0	0
241	146	2	1	22	60	2	0	0
241	69	2	1	21	60	3	0	0
242	286	1	1	50	60	2	0	0
242	340	1	0	48	60	2	0	0
242	70	1	0	25	60	2	1	0
242	492	0	0	42	60	5	0	0
242	81	0	1	33	60	0	1	0
242	403	0	0	47	60	1	1	0
242	319	0	1	39	60	0	1	0
242	250	1	1	34	60	2	0	0
243	128	2	0	32	60	1	0	0
243	416	0	0	27	60	2	0	0
243	497	2	1	50	60	2	0	0
243	6	0	0	47	60	4	0	0
243	41	0	0	46	60	3	0	0
243	353	2	1	28	60	2	1	0
243	334	1	1	38	60	0	0	0
243	202	0	0	29	60	3	1	0
244	215	1	1	32	60	2	0	0
244	380	0	1	23	60	1	0	0
244	137	0	0	23	60	3	0	0
244	251	2	0	39	60	3	0	0
244	457	2	0	20	60	5	0	0
244	265	1	1	37	60	1	1	0
244	61	1	0	29	60	1	0	0
244	91	0	0	36	60	5	1	0
245	31	0	1	50	60	1	0	0
245	334	1	0	49	60	2	1	0
245	85	1	0	38	60	1	0	0
245	143	1	1	28	60	3	1	0
245	315	1	0	28	60	0	0	0
245	484	1	0	37	60	2	0	0
245	279	2	1	20	60	4	1	0
245	344	0	1	48	60	4	1	0
246	105	2	0	23	60	4	1	0
246	342	2	0	21	60	1	1	0
246	134	2	0	47	60	1	0	0
246	148	0	1	39	60	3	1	0
246	414	2	1	34	60	5	0	0
246	132	1	0	32	60	5	1	0
246	276	2	1	44	60	2	0	0
246	14	2	1	34	60	4	0	0
247	42	2	1	42	60	5	0	0
247	144	1	1	20	60	1	0	0
247	328	0	1	46	60	4	1	0
247	454	1	1	46	60	1	0	0
247	350	2	1	39	60	4	0	0
247	401	2	1	48	60	4	0	0
247	347	1	0	41	60	1	0	0
247	41	1	1	49	60	5	0	0
248	123	2	1	50	60	0	1	0
248	370	2	1	39	60	0	1	0
248	248	0	1	25	60	1	0	0
248	360	1	1	24	60	1	0	0
248	382	0	0	35	60	5	0	0
248	279	2	0	26	60	1	0	0
248	392	2	1	37	60	0	0	0
248	471	2	1	37	60	1	0	0
249	202	1	1	40	60	3	0	0
249	30	2	0	47	60	2	0	0
249	251	1	0	49	60	2	0	0
249	313	2	0	44	60	5	1	0
249	407	0	0	41	60	0	0	0
249	395	0	0	29	60	0	0	0
249	82	1	0	29	60	4	1	0
249	263	2	0	46	60	5	0	0
250	484	2	1	38	60	3	0	0
250	56	2	0	35	60	3	1	0
250	97	0	1	47	60	0	0	0
250	465	2	1	45	60	1	0	0
250	360	1	0	36	60	2	1	0
250	495	1	0	44	60	2	0	0
250	377	0	0	47	60	1	0	0
250	133	1	1	31	60	4	0	0
251	312	0	0	33	60	1	1	0
251	138	1	1	27	60	0	0	0
251	206	2	1	26	60	2	0	0
251	293	1	0	46	60	2	0	0
251	14	2	0	34	60	5	0	0
251	242	1	0	45	60	3	1	0
251	291	2	0	26	60	0	0	0
251	78	1	1	25	60	5	0	0
252	245	2	1	23	60	2	0	0
252	490	1	0	40	60	5	0	0
252	43	0	0	22	60	3	0	0
252	189	1	1	21	60	3	0	0
252	119	1	0	43	60	4	0	0
252	258	1	0	48	60	4	0	0
252	148	2	0	37	60	3	0	0
252	143	2	0	45	60	3	0	0
253	38	1	0	22	60	5	1	0
253	275	1	0	41	60	5	0	0
253	293	2	1	31	60	0	0	0
253	261	1	0	49	60	5	0	0
253	391	1	1	43	60	0	1	0
253	252	0	1	37	60	2	1	0
253	235	1	1	40	60	2	0	0
253	115	1	1	46	60	4	0	0
254	431	0	0	50	60	2	1	0
254	445	0	0	29	60	0	0	0
254	285	1	1	38	60	4	1	0
254	347	0	1	45	60	2	1	0
254	435	2	0	22	60	1	0	0
254	130	1	0	30	60	3	0	0
254	230	2	0	26	60	5	0	0
254	182	1	1	32	60	0	0	0
255	129	2	1	35	60	0	0	0
255	73	2	0	30	60	4	0	0
255	195	1	1	25	60	0	0	0
255	458	0	0	30	60	0	0	0
255	72	2	1	29	60	3	0	0
255	120	1	1	33	60	2	0	0
255	377	0	0	42	60	4	1	0
255	168	0	0	43	60	0	0	0
256	472	0	1	49	60	4	1	0
256	65	0	0	34	60	2	0	0
256	114	0	0	37	60	4	0	0
256	152	2	1	39	60	0	0	0
256	53	0	1	26	60	0	1	0
256	319	1	0	26	60	0	0	0
256	356	1	0	34	60	5	1	0
256	351	2	1	50	60	2	0	0
257	120	1	0	24	60	2	0	0
257	284	0	0	39	60	5	0	0
257	475	2	1	32	60	4	0	0
257	203	2	0	48	60	2	0	0
257	462	2	0	39	60	2	0	0
257	101	1	0	46	60	2	1	0
257	166	2	1	49	60	3	0	0
257	182	0	1	41	60	1	0	0
258	82	0	0	32	60	5	0	0
258	291	0	0	33	60	0	0	0
258	361	0	0	42	60	4	0	0
258	280	2	1	46	60	4	0	0
258	69	1	0	27	60	2	1	0
258	480	1	1	45	60	5	0	0
258	203	1	0	45	60	4	0	0
258	422	2	1	30	60	3	0	0
259	143	1	0	40	60	5	1	0
259	222	2	0	31	60	5	1	0
259	436	2	1	36	60	4	0	0
259	464	1	1	25	60	2	0	0
259	387	1	0	47	60	4	1	0
259	459	2	0	42	60	5	0	0
259	492	1	1	44	60	2	0	0
259	257	2	1	33	60	0	0	0
260	397	1	0	30	60	5	0	0
260	237	2	1	36	60	2	0	0
260	175	1	0	48	60	0	1	0
260	35	1	0	48	60	4	0	0
260	171	2	0	22	60	5	1	0
260	464	2	1	21	60	1	1	0
260	447	2	0	30	60	4	0	0
260	496	0	1	46	60	0	0	0
261	141	1	0	42	60	3	0	0
261	14	1	1	41	60	1	0	0
261	134	0	0	50	60	5	0	0
261	257	0	1	43	60	0	0	0
261	392	1	1	43	60	0	0	0
261	310	1	1	28	60	4	0	0
261	367	1	1	48	60	1	1	0
261	274	1	1	29	60	0	0	0
262	315	0	0	20	60	1	0	0
262	9	2	1	34	60	2	0	0
262	372	2	1	40	60	3	0	0
262	317	0	0	20	60	0	0	0
262	116	2	1	40	60	4	0	0
262	66	0	1	46	60	3	0	0
262	33	2	1	42	60	0	0	0
262	453	0	0	32	60	5	0	0
263	401	1	1	23	60	1	0	0
263	158	0	0	34	60	2	0	0
263	24	1	1	46	60	4	1	0
263	72	1	1	20	60	5	0	0
263	236	0	1	24	60	0	0	0
263	370	1	0	28	60	2	0	0
263	280	2	1	41	60	2	0	0
263	307	2	1	47	60	3	0	0
264	481	0	1	31	60	0	1	0
264	364	0	1	29	60	5	1	0
264	238	1	0	41	60	0	0	0
264	167	1	1	41	60	0	0	0
264	414	1	1	35	60	4	1	0
264	494	2	1	23	60	5	0	0
264	198	0	1	42	60	0	0	0
264	392	0	1	39	60	2	0	0
265	89	0	1	22	60	2	0	0
265	438	1	1	40	60	5	0	0
265	474	0	1	38	60	2	1	0
265	55	1	0	21	60	3	0	0
265	283	0	0	28	60	5	0	0
265	189	0	1	37	60	4	0	0
265	125	0	1	33	60	4	1	0
265	67	1	1	47	60	4	0	0
266	163	0	0	24	60	3	1	0
266	90	2	1	26	60	4	0	0
266	219	1	0	29	60	1	0	0
266	465	1	1	44	60	0	1	0
266	308	2	1	34	60	0	0	0
266	51	2	1	49	60	4	0	0
266	181	2	1	20	60	0	0	0
266	458	1	0	31	60	3	0	0
267	284	2	1	44	60	5	0	0
267	101	0	0	43	60	1	0	0
267	194	2	1	39	60	3	0	0
267	14	1	1	40	60	0	0	0
267	306	0	0	37	60	1	0	0
267	402	2	0	31	60	4	0	0
267	392	1	1	47	60	2	0	0
267	15	0	0	40	60	0	0	0
268	303	0	1	45	60	1	0	0
268	342	1	1	37	60	2	0	0
268	413	0	1	22	60	2	1	0
268	173	0	1	36	60	0	0	0
268	368	2	0	32	60	0	0	0
268	209	0	0	29	60	4	0	0
268	204	0	0	32	60	2	0	0
268	403	2	1	32	60	1	0	0
269	301	2	1	40	60	3	1	0
269	247	1	0	50	60	5	1	0
269	34	2	1	44	60	1	0	0
269	173	2	0	49	60	3	1	0
269	335	1	0	29	60	0	1	0
269	253	1	1	22	60	1	0	0
269	112	2	1	47	60	3	0	0
269	166	2	1	22	60	2	1	0
270	130	2	0	46	60	5	1	0
270	283	1	0	35	60	0	0	0
270	465	1	1	33	60	2	1	0
270	225	2	0	32	60	1	0	0
270	437	1	0	43	60	0	0	0
270	85	2	1	48	60	0	1	0
270	407	0	1	47	60	5	0	0
270	156	2	0	43	60	0	0	0
271	471	0	0	31	60	2	0	0
271	141	1	0	27	60	4	1	0
271	417	0	0	27	60	2	1	0
271	86	1	1	31	60	4	0	0
271	370	2	1	34	60	0	1	0
271	199	1	1	43	60	1	0	0
271	42	1	0	43	60	2	1	0
271	213	2	0	24	60	0	0	0
272	222	0	1	37	60	1	1	0
272	205	0	1	31	60	4	1	0
272	295	0	0	40	60	0	0	0
272	364	1	1	47	60	2	1	0
272	442	2	1	30	60	4	1	0
272	135	1	1	32	60	5	0	0
272	392	0	0	30	60	1	0	0
272	436	2	0	29	60	4	0	0
273	192	1	1	47	60	4	0	0
273	62	1	1	21	60	5	1	0
273	127	2	1	46	60	2	1	0
273	14	0	0	48	60	5	0	0
273	145	0	1	30	60	5	0	0
273	498	1	1	32	60	0	0	0
273	447	2	1	26	60	3	0	0
273	253	1	0	33	60	3	0	0
274	121	2	1	44	60	0	0	0
274	184	0	1	37	60	3	0	0
274	31	1	0	37	60	1	1	0
274	383	1	1	41	60	2	0	0
274	487	0	0	23	60	4	0	0
274	493	0	0	42	60	2	0	0
274	331	0	0	26	60	4	1	0
274	171	1	0	40	60	1	1	0
275	109	2	0	33	60	2	1	0
275	479	2	0	26	60	3	0	0
275	144	1	0	21	60	4	1	0
275	257	2	0	23	60	3	0	0
275	155	1	1	45	60	2	1	0
275	171	2	0	29	60	1	1	0
275	369	2	1	47	60	4	0	0
275	317	2	1	50	60	5	0	0
276	357	2	1	30	60	1	0	0
276	273	2	1	30	60	3	0	0
276	149	0	0	22	60	2	0	0
276	374	1	1	49	60	2	1	0
276	157	1	1	24	60	0	0	0
276	264	1	1	34	60	0	1	0
276	295	0	1	31	60	2	1	0
276	15	1	0	27	60	0	0	0
277	251	1	1	37	60	0	0	0
277	206	1	1	49	60	4	1	0
277	305	0	1	44	60	2	0	0
277	430	2	0	34	60	5	0	0
277	442	1	0	21	60	2	0	0
277	250	0	0	40	60	1	1	0
277	176	0	0	28	60	5	1	0
277	81	1	0	33	60	1	0	0
278	343	0	1	25	60	1	1	0
278	383	2	0	28	60	2	0	0
278	338	1	1	29	60	0	1	0
278	30	2	1	44	60	0	0	0
278	47	2	1	46	60	0	1	0
278	421	2	0	28	60	1	0	0
278	189	0	0	43	60	3	0	0
278	247	0	0	39	60	3	0	0
279	473	1	0	24	60	2	0	0
279	206	2	0	27	60	2	0	0
279	306	0	1	46	60	1	1	0
279	416	1	1	40	60	5	0	0
279	226	1	1	32	60	1	1	0
279	323	1	1	33	60	0	0	0
279	191	2	0	27	60	5	1	0
279	369	2	1	46	60	5	0	0
280	5	0	0	41	60	0	0	0
280	433	0	1	44	60	5	1	0
280	343	1	1	21	60	2	0	0
280	24	0	1	39	60	4	0	0
280	345	2	0	39	60	5	0	0
280	145	2	0	25	60	4	0	0
280	376	1	1	38	60	5	1	0
280	405	1	1	37	60	3	0	0
281	416	2	0	34	60	1	0	0
281	12	0	1	33	60	1	1	0
281	369	2	0	49	60	3	0	0
281	47	0	1	47	60	2	0	0
281	126	0	0	50	60	5	0	0
281	308	2	1	28	60	4	0	0
281	237	1	0	24	60	3	0	0
281	414	1	1	29	60	3	0	0
282	59	1	0	36	60	2	0	0
282	479	0	0	46	60	2	0	0
282	291	1	0	39	60	4	0	0
282	162	0	1	31	60	3	0	0
282	457	2	0	36	60	4	0	0
282	396	1	1	27	60	4	1	0
282	423	0	0	34	60	4	0	0
282	394	2	0	41	60	5	1	0
283	133	2	0	24	60	2	1	0
283	308	2	1	43	60	3	0	0
283	6	1	1	42	60	1	0	0
283	409	1	0	50	60	5	0	0
283	15	1	0	44	60	2	0	0
283	128	2	1	33	60	3	0	0
283	223	1	0	30	60	1	0	0
283	270	2	1	44	60	3	0	0
284	74	0	1	32	60	2	0	0
284	20	1	1	35	60	2	0	0
284	128	2	0	40	60	2	0	0
284	495	2	1	45	60	1	0	0
284	494	2	0	28	60	4	0	0
284	381	0	0	32	60	1	0	0
284	363	1	1	26	60	0	0	0
284	214	1	0	50	60	3	0	0
285	273	0	1	50	60	4	0	0
285	261	1	0	33	60	5	0	0
285	153	2	1	37	60	2	0	0
285	305	0	0	28	60	0	0	0
285	375	1	0	22	60	4	0	0
285	9	0	0	48	60	3	0	0
285	249	0	0	20	60	2	0	0
285	274	1	0	47	60	2	1	0
286	425	0	1	42	60	1	0	0
286	74	2	1	33	60	3	0	0
286	96	2	1	42	60	2	0	0
286	105	2	0	21	60	0	0	0
286	81	2	1	26	60	5	0	0
286	457	2	0	46	60	0	0	0
286	121	1	0	29	60	3	0	0
286	447	0	1	47	60	2	0	0
287	486	2	0	22	60	3	0	0
287	409	2	1	37	60	2	1	0
287	471	2	0	24	60	3	0	0
287	309	0	0	43	60	1	0	0
287	454	1	1	28	60	0	0	0
287	386	0	0	21	60	4	1	0
287	74	1	1	44	60	0	0	0
287	190	2	1	27	60	3	0	0
288	112	0	1	42	60	4	1	0
288	106	2	0	36	60	4	1	0
288	366	1	1	33	60	4	1	0
288	259	1	1	30	60	5	0	0
288	162	1	1	35	60	3	0	0
288	178	0	0	33	60	3	1	0
288	264	0	0	45	60	1	0	0
288	332	2	0	31	60	3	0	0
289	444	2	1	38	60	4	0	0
289	137	0	1	46	60	1	0	0
289	17	2	1	41	60	5	0	0
289	482	0	0	45	60	0	1	0
289	276	1	0	29	60	2	0	0
289	37	2	0	23	60	3	1	0
289	273	0	1	28	60	1	1	0
289	303	1	0	25	60	1	1	0
290	473	2	1	43	60	0	0	0
290	335	1	0	43	60	5	1	0
290	355	0	0	34	60	5	1	0
290	212	0	0	21	60	0	0	0
290	478	2	0	41	60	1	1	0
290	179	2	1	48	60	2	1	0
290	7	0	1	50	60	0	1	0
290	497	0	1	36	60	0	1	0
291	450	2	0	37	60	3	0	0
291	211	0	0	32	60	1	1	0
291	397	2	1	48	60	2	0	0
291	385	2	1	35	60	1	0	0
291	33	2	0	37	60	2	0	0
291	244	2	0	35	60	5	0	0
291	116	1	1	40	60	1	1	0
291	478	0	0	33	60	1	0	0
292	400	1	0	23	60	5	0	0
292	440	1	0	50	60	3	1	0
292	16	1	0	26	60	0	0	0
292	493	0	1	32	60	4	0	0
292	60	2	0	40	60	1	0	0
292	454	1	0	33	60	5	0	0
292	281	0	0	48	60	1	0	0
292	420	2	1	49	60	0	0	0
293	193	2	0	29	60	0	1	0
293	484	2	1	38	60	1	1	0
293	480	2	0	39	60	5	0	0
293	90	2	0	34	60	3	0	0
293	412	1	1	40	60	3	0	0
293	173	2	1	26	60	2	1	0
293	436	2	1	32	60	0	1	0
293	477	1	0	39	60	3	0	0
294	249	0	0	47	60	0	0	0
294	254	1	0	48	60	4	1	0
294	447	2	0	44	60	1	0	0
294	380	2	1	37	60	3	0	0
294	53	2	0	22	60	0	0	0
294	461	2	0	47	60	3	0	0
294	435	2	1	45	60	4	0	0
294	50	1	0	45	60	4	0	0
295	5	2	1	39	60	5	0	0
295	154	2	1	28	60	4	0	0
295	201	0	0	25	60	0	1	0
295	378	2	1	48	60	4	0	0
295	467	0	0	37	60	3	0	0
295	140	0	0	24	60	3	0	0
295	28	0	1	31	60	1	0	0
295	401	0	1	38	60	3	0	0
296	341	2	1	22	60	2	0	0
296	351	1	0	28	60	1	0	0
296	378	1	1	41	60	3	0	0
296	422	0	0	50	60	2	0	0
296	388	1	1	20	60	0	0	0
296	227	0	1	42	60	3	0	0
296	78	0	0	38	60	0	1	0
296	209	2	1	48	60	5	0	0
297	191	1	1	40	60	0	1	0
297	47	0	0	20	60	4	0	0
297	466	1	0	33	60	4	0	0
297	85	2	1	27	60	2	0	0
297	353	1	1	31	60	1	0	0
297	184	0	1	33	60	4	0	0
297	382	1	1	30	60	1	0	0
297	167	0	1	29	60	5	0	0
298	455	1	1	38	60	5	0	0
298	436	1	0	26	60	4	0	0
298	476	0	1	32	60	2	1	0
298	294	0	0	42	60	3	1	0
298	236	1	1	34	60	1	0	0
298	345	0	0	27	60	5	0	0
298	29	2	0	23	60	5	0	0
298	178	1	1	42	60	0	0	0
299	123	0	1	37	60	3	0	0
299	170	2	0	40	60	3	1	0
299	353	0	1	20	60	1	0	0
299	363	0	0	20	60	5	0	0
299	346	0	0	23	60	3	0	0
299	120	2	1	41	60	2	0	0
299	162	0	0	23	60	2	0	0
299	380	2	1	42	60	2	0	0
300	351	1	0	45	60	5	1	0
300	166	0	0	26	60	1	0	0
300	484	0	1	31	60	4	0	0
300	71	0	0	39	60	3	0	0
300	19	0	1	28	60	2	0	0
300	167	2	1	40	60	4	0	0
300	33	0	1	42	60	4	0	0
300	160	1	1	22	60	0	1	0
301	397	1	0	26	60	4	1	0
301	155	2	0	37	60	3	0	0
301	44	0	1	37	60	1	1	0
301	326	2	1	40	60	2	0	0
301	67	0	0	43	60	0	0	0
301	346	2	1	36	60	2	0	0
301	54	1	1	29	60	3	0	0
301	51	0	1	48	60	1	0	0
302	276	1	0	20	60	3	1	0
302	174	2	0	34	60	4	0	0
302	340	1	1	25	60	2	1	0
302	248	2	0	49	60	1	0	0
302	172	0	1	44	60	3	0	0
302	430	1	1	50	60	4	0	0
302	143	1	0	38	60	0	1	0
302	13	1	1	43	60	5	0	0
303	36	1	1	41	60	3	0	0
303	494	1	1	44	60	1	0	0
303	342	1	1	23	60	4	0	0
303	15	1	1	43	60	3	0	0
303	187	2	0	36	60	2	0	0
303	198	2	1	30	60	4	0	0
303	73	0	0	40	60	2	1	0
303	85	1	0	20	60	1	0	0
304	424	1	1	26	60	2	1	0
304	46	2	1	42	60	1	0	0
304	421	1	1	50	60	1	1	0
304	21	2	0	29	60	3	0	0
304	386	1	0	32	60	2	0	0
304	171	1	0	44	60	3	0	0
304	116	1	0	37	60	4	0	0
304	137	1	1	29	60	2	0	0
305	285	0	1	26	60	2	1	0
305	205	0	1	44	60	2	0	0
305	140	0	1	27	60	2	0	0
305	80	0	1	26	60	4	0	0
305	290	1	0	29	60	3	0	0
305	42	1	0	24	60	0	0	0
305	450	1	0	50	60	5	0	0
305	132	2	1	21	60	0	0	0
306	227	1	0	43	60	5	1	0
306	491	1	0	34	60	5	0	0
306	498	1	1	44	60	0	0	0
306	202	1	0	42	60	1	0	0
306	67	1	1	46	60	5	0	0
306	342	1	1	40	60	3	1	0
306	192	0	1	34	60	1	1	0
306	152	0	0	21	60	5	1	0
307	288	2	1	49	60	5	0	0
307	114	0	0	48	60	3	0	0
307	301	0	1	43	60	5	0	0
307	32	2	1	50	60	0	0	0
307	46	0	1	31	60	2	0	0
307	472	1	1	25	60	5	1	0
307	477	1	0	46	60	5	0	0
307	482	1	1	26	60	4	0	0
308	64	1	0	44	60	1	1	0
308	376	0	0	50	60	3	0	0
308	242	1	1	32	60	5	0	0
308	452	0	1	26	60	1	1	0
308	326	2	0	45	60	1	1	0
308	113	2	0	29	60	3	0	0
308	329	1	0	22	60	5	0	0
308	93	1	0	24	60	0	0	0
309	128	2	0	48	60	3	0	0
309	277	1	1	42	60	1	0	0
309	156	2	1	21	60	1	0	0
309	214	1	0	49	60	1	0	0
309	248	1	1	45	60	1	0	0
309	487	1	1	36	60	3	0	0
309	424	0	0	27	60	3	0	0
309	306	0	0	39	60	0	0	0
310	136	2	0	33	60	0	0	0
310	312	2	0	50	60	5	0	0
310	129	0	0	44	60	4	0	0
310	123	2	0	48	60	2	0	0
310	75	2	0	21	60	3	1	0
310	394	0	1	25	60	0	0	0
310	361	1	0	35	60	1	0	0
310	331	2	1	48	60	2	0	0
311	70	1	1	23	60	5	0	0
311	34	1	0	38	60	2	0	0
311	204	2	1	20	60	5	0	0
311	249	1	1	31	60	3	0	0
311	151	0	0	24	60	5	1	0
311	109	2	1	28	60	5	0	0
311	320	1	0	41	60	0	1	0
311	305	0	0	34	60	5	0	0
312	344	2	0	40	60	3	0	0
312	54	2	0	33	60	5	0	0
312	129	0	0	35	60	5	0	0
312	156	2	0	26	60	4	0	0
312	430	0	1	42	60	2	1	0
312	127	2	1	28	60	3	1	0
312	251	1	1	40	60	5	0	0
312	88	1	0	35	60	5	0	0
313	136	1	0	50	60	1	0	0
313	115	0	1	26	60	0	1	0
313	398	2	1	30	60	5	0	0
313	304	1	1	24	60	3	0	0
313	216	0	0	42	60	1	0	0
313	223	0	1	46	60	1	0	0
313	116	2	0	49	60	0	0	0
313	308	2	0	21	60	2	0	0
314	61	2	1	20	60	2	0	0
314	369	2	0	39	60	0	0	0
314	408	1	1	30	60	0	0	0
314	163	2	0	23	60	5	0	0
314	262	2	1	27	60	2	1	0
314	230	2	0	37	60	0	0	0
314	225	2	0	46	60	0	1	0
314	250	1	0	22	60	2	0	0
315	342	0	0	33	60	0	0	0
315	126	2	0	29	60	4	1	0
315	172	1	1	27	60	4	0	0
315	222	2	1	22	60	3	1	0
315	2	2	1	37	60	5	0	0
315	291	1	1	29	60	3	1	0
315	490	1	0	35	60	5	0	0
315	317	2	0	49	60	4	0	0
316	5	2	0	35	60	4	0	0
316	83	0	1	36	60	3	0	0
316	439	2	1	30	60	2	1	0
316	361	1	0	47	60	1	0	0
316	113	2	0	23	60	5	0	0
316	120	1	0	49	60	4	0	0
316	77	0	0	26	60	0	1	0
316	30	1	0	26	60	2	0	0
317	191	1	0	21	60	4	0	0
317	274	2	0	28	60	0	0	0
317	347	2	1	24	60	4	0	0
317	34	2	1	40	60	2	0	0
317	371	2	1	27	60	5	0	0
317	143	0	0	44	60	0	0	0
317	280	0	0	21	60	4	1	0
317	253	0	0	49	60	3	1	0
318	175	0	1	36	60	0	0	0
318	324	2	0	43	60	4	1	0
318	334	1	0	41	60	1	1	0
318	290	1	1	28	60	0	1	0
318	1	1	1	49	60	2	0	0
318	439	2	1	21	60	1	0	0
318	142	1	1	44	60	5	0	0
318	132	0	1	35	60	5	1	0
319	29	0	1	29	60	4	1	0
319	61	1	0	28	60	0	1	0
319	228	0	1	26	60	1	0	0
319	287	1	1	49	60	2	0	0
319	408	0	0	34	60	3	1	0
319	464	0	0	24	60	5	0	0
319	491	1	0	35	60	3	1	0
319	259	1	1	24	60	5	0	0
320	188	2	0	23	60	3	1	0
320	49	1	1	41	60	5	0	0
320	136	2	1	41	60	4	0	0
320	86	1	0	46	60	4	1	0
320	311	1	1	47	60	5	1	0
320	210	2	1	27	60	1	1	0
320	445	1	0	45	60	2	0	0
320	421	0	1	33	60	1	0	0
321	18	1	0	30	60	5	0	0
321	339	0	0	45	60	1	0	0
321	458	0	0	22	60	1	0	0
321	364	1	1	47	60	1	0	0
321	283	0	0	45	60	3	0	0
321	346	1	0	26	60	5	1	0
321	120	1	1	21	60	3	0	0
321	401	2	1	40	60	3	0	0
322	491	0	0	38	60	0	0	0
322	438	0	0	30	60	5	0	0
322	454	1	0	33	60	3	0	0
322	377	2	1	21	60	3	0	0
322	1	0	1	31	60	2	1	0
322	103	1	1	28	60	4	0	0
322	240	0	1	27	60	0	0	0
322	361	0	0	23	60	3	0	0
323	43	0	1	31	60	0	0	0
323	321	0	1	44	60	1	1	0
323	37	2	0	38	60	0	1	0
323	63	2	1	45	60	4	1	0
323	330	0	0	27	60	0	0	0
323	287	1	1	29	60	3	1	0
323	59	2	0	25	60	1	1	0
323	39	2	0	32	60	0	0	0
324	273	2	1	46	60	1	0	0
324	419	1	0	30	60	5	0	0
324	361	2	1	35	60	4	0	0
324	142	2	0	33	60	0	0	0
324	55	0	1	43	60	5	0	0
324	348	1	1	50	60	4	1	0
324	277	0	0	47	60	5	0	0
324	123	1	1	47	60	3	0	0
325	203	2	0	36	60	3	0	0
325	22	0	1	40	60	4	0	0
325	289	2	0	41	60	5	0	0
325	160	1	0	22	60	4	0	0
325	164	0	0	28	60	4	0	0
325	239	1	0	20	60	0	0	0
325	5	0	1	42	60	2	0	0
325	299	0	0	28	60	0	1	0
326	107	0	1	33	60	3	1	0
326	486	2	1	25	60	4	1	0
326	283	1	1	20	60	3	1	0
326	339	0	1	49	60	1	0	0
326	193	1	0	37	60	5	0	0
326	303	1	0	34	60	4	1	0
326	38	1	1	34	60	0	0	0
326	129	0	0	25	60	3	1	0
327	449	0	1	42	60	3	0	0
327	47	1	0	27	60	5	1	0
327	239	2	0	32	60	0	0	0
327	370	1	1	30	60	0	0	0
327	330	0	0	23	60	1	1	0
327	296	1	0	48	60	1	1	0
327	378	1	1	22	60	3	0	0
327	27	2	0	24	60	1	0	0
328	464	2	0	37	60	5	0	0
328	20	1	1	42	60	2	0	0
328	269	1	1	22	60	2	1	0
328	314	0	1	31	60	0	0	0
328	81	2	1	43	60	4	0	0
328	283	1	1	35	60	2	0	0
328	110	2	1	35	60	5	0	0
328	467	0	0	29	60	4	0	0
329	399	0	0	32	60	0	0	0
329	394	0	1	30	60	3	0	0
329	469	1	0	37	60	5	0	0
329	340	0	0	25	60	1	0	0
329	8	2	1	28	60	5	1	0
329	344	0	0	37	60	1	1	0
329	5	1	1	47	60	1	0	0
329	101	2	0	22	60	4	1	0
330	168	0	0	46	60	2	0	0
330	178	0	0	44	60	1	1	0
330	251	1	0	31	60	0	0	0
330	202	2	0	41	60	3	0	0
330	122	0	0	30	60	0	0	0
330	123	0	1	26	60	1	0	0
330	349	1	0	46	60	2	0	0
330	184	1	0	30	60	1	1	0
331	413	1	1	20	60	5	0	0
331	207	1	0	43	60	1	0	0
331	240	1	0	26	60	2	0	0
331	208	1	1	34	60	3	0	0
331	445	2	1	37	60	4	1	0
331	258	2	1	41	60	4	0	0
331	322	1	0	32	60	3	1	0
331	378	0	0	25	60	4	0	0
332	439	0	1	27	60	1	0	0
332	392	0	1	32	60	0	0	0
332	416	2	0	21	60	1	0	0
332	131	2	0	29	60	0	0	0
332	236	1	0	39	60	0	0	0
332	296	1	0	44	60	2	0	0
332	413	0	1	22	60	5	0	0
332	18	0	1	29	60	0	0	0
333	229	0	1	30	60	1	0	0
333	442	2	1	24	60	2	0	0
333	180	2	1	43	60	4	1	0
333	129	0	0	37	60	5	0	0
333	127	0	0	22	60	5	0	0
333	70	1	0	23	60	2	0	0
333	43	2	1	50	60	2	0	0
333	283	0	1	38	60	4	0	0
334	426	1	0	32	60	1	1	0
334	147	2	0	28	60	2	0	0
334	116	2	1	50	60	4	0	0
334	7	1	0	23	60	2	0	0
334	282	0	1	49	60	4	1	0
334	96	2	0	33	60	0	0	0
334	425	2	1	20	60	2	0	0
334	390	0	0	49	60	5	1	0
335	219	1	1	35	60	5	1	0
335	232	1	0	35	60	3	1	0
335	47	2	1	44	60	2	0	0
335	497	2	1	30	60	5	0	0
335	425	2	1	39	60	0	0	0
335	83	0	1	25	60	2	1	0
335	326	1	1	25	60	4	0	0
335	138	1	0	49	60	2	0	0
336	17	1	0	20	60	2	0	0
336	409	2	0	23	60	3	0	0
336	190	0	1	37	60	3	0	0
336	226	1	1	30	60	2	0	0
336	295	1	1	29	60	2	0	0
336	7	1	0	36	60	4	0	0
336	205	1	0	44	60	2	1	0
336	250	2	0	32	60	5	1	0
337	353	1	1	41	60	3	0	0
337	492	0	0	24	60	1	0	0
337	198	2	0	49	60	1	0	0
337	178	2	0	26	60	1	0	0
337	202	0	0	28	60	0	1	0
337	315	2	1	33	60	5	0	0
337	488	1	1	20	60	4	0	0
337	234	1	0	39	60	1	0	0
338	155	1	0	49	60	3	0	0
338	300	2	0	43	60	5	0	0
338	50	1	0	47	60	1	0	0
338	37	0	0	44	60	2	0	0
338	194	2	1	25	60	1	1	0
338	119	2	1	30	60	3	0	0
338	348	1	0	39	60	4	1	0
338	365	1	1	22	60	1	0	0
339	157	0	1	46	60	2	0	0
339	409	0	1	24	60	1	1	0
339	375	1	0	23	60	5	0	0
339	396	1	0	20	60	4	0	0
339	389	2	1	30	60	0	0	0
339	380	2	0	20	60	1	1	0
339	250	2	0	46	60	5	0	0
339	347	1	0	35	60	3	1	0
340	426	0	1	27	60	5	0	0
340	118	2	1	47	60	5	1	0
340	494	2	0	42	60	5	0	0
340	488	1	1	33	60	5	0	0
340	2	0	1	26	60	0	0	0
340	87	1	1	37	60	2	0	0
340	206	2	1	36	60	1	0	0
340	292	0	1	34	60	5	0	0
341	347	2	1	42	60	0	0	0
341	186	1	0	46	60	1	0	0
341	487	0	1	50	60	0	0	0
341	141	1	1	41	60	2	0	0
341	251	2	0	26	60	4	0	0
341	60	1	0	26	60	2	0	0
341	305	0	1	34	60	1	1	0
341	233	0	0	37	60	2	0	0
342	342	2	0	46	60	1	1	0
342	8	1	1	29	60	0	0	0
342	54	1	1	31	60	4	0	0
342	291	1	1	21	60	5	1	0
342	268	0	1	38	60	0	1	0
342	223	2	1	32	60	1	1	0
342	381	2	1	23	60	4	0	0
342	273	2	1	49	60	4	0	0
343	269	1	0	47	60	4	1	0
343	407	2	0	50	60	1	0	0
343	196	2	1	22	60	1	0	0
343	97	0	1	29	60	1	1	0
343	462	2	1	41	60	3	0	0
343	326	1	1	44	60	3	0	0
343	386	0	1	47	60	1	0	0
343	360	1	0	33	60	1	0	0
344	291	2	1	37	60	3	0	0
344	274	0	0	34	60	2	0	0
344	54	0	1	31	60	4	1	0
344	225	0	1	44	60	3	0	0
344	175	2	0	43	60	1	0	0
344	411	2	1	44	60	4	0	0
344	308	0	1	34	60	0	0	0
344	346	2	0	39	60	4	0	0
345	301	1	1	21	60	5	0	0
345	461	2	1	26	60	2	1	0
345	129	0	0	48	60	5	0	0
345	179	0	0	26	60	2	0	0
345	46	1	1	40	60	4	1	0
345	222	1	0	30	60	2	1	0
345	400	1	0	28	60	4	0	0
345	471	0	1	23	60	0	1	0
346	437	1	0	45	60	4	0	0
346	373	2	1	41	60	0	1	0
346	419	2	1	43	60	0	0	0
346	255	2	0	36	60	4	1	0
346	173	2	0	48	60	3	0	0
346	189	1	0	41	60	5	1	0
346	228	0	0	40	60	3	0	0
346	390	1	0	48	60	3	1	0
347	283	1	1	42	60	0	1	0
347	302	1	0	48	60	0	0	0
347	172	0	1	32	60	0	0	0
347	83	0	1	42	60	3	0	0
347	420	0	1	33	60	3	0	0
347	288	0	1	21	60	0	1	0
347	379	2	0	25	60	1	0	0
347	459	2	0	32	60	2	0	0
348	111	1	0	45	60	3	1	0
348	61	1	1	29	60	2	0	0
348	249	1	1	21	60	4	1	0
348	119	0	1	24	60	2	1	0
348	82	1	0	45	60	3	1	0
348	257	1	1	28	60	5	0	0
348	127	0	0	33	60	0	0	0
348	290	0	0	22	60	1	0	0
349	336	1	0	40	60	1	0	0
349	305	1	0	36	60	5	0	0
349	344	1	0	31	60	1	0	0
349	192	2	0	33	60	1	0	0
349	136	0	1	36	60	0	0	0
349	388	1	1	41	60	2	0	0
349	481	0	1	23	60	2	1	0
349	268	1	1	33	60	0	0	0
350	337	1	0	26	60	1	0	0
350	37	1	1	45	60	2	1	0
350	494	0	1	24	60	0	1	0
350	209	0	1	21	60	1	1	0
350	498	2	0	36	60	4	0	0
350	414	1	1	25	60	1	1	0
350	108	0	1	47	60	2	0	0
350	200	1	0	46	60	5	0	0
351	21	0	1	21	60	0	0	0
351	254	2	0	27	60	1	0	0
351	169	0	1	32	60	2	1	0
351	7	1	1	47	60	1	0	0
351	201	0	0	37	60	4	0	0
351	400	1	0	43	60	1	0	0
351	234	2	1	33	60	3	0	0
351	22	1	1	43	60	1	0	0
352	215	1	1	43	60	1	0	0
352	259	2	1	27	60	0	0	0
352	280	1	1	32	60	2	1	0
352	478	1	1	37	60	1	1	0
352	451	1	0	35	60	0	0	0
352	361	2	1	21	60	1	1	0
352	175	1	1	49	60	2	1	0
352	27	0	0	24	60	3	0	0
353	13	0	1	37	60	4	1	0
353	28	2	1	21	60	0	0	0
353	464	1	1	45	60	3	0	0
353	171	1	0	40	60	1	0	0
353	340	0	0	30	60	5	0	0
353	390	1	0	23	60	5	0	0
353	246	2	0	29	60	5	0	0
353	143	2	0	35	60	3	0	0
354	176	2	1	29	60	1	1	0
354	369	1	0	39	60	3	0	0
354	208	1	1	24	60	4	0	0
354	28	0	0	27	60	4	0	0
354	31	0	1	50	60	1	0	0
354	167	1	1	35	60	2	1	0
354	439	0	1	35	60	2	0	0
354	305	0	0	22	60	5	0	0
355	75	2	0	21	60	5	0	0
355	15	0	1	30	60	5	1	0
355	91	1	1	40	60	2	0	0
355	373	0	0	43	60	5	0	0
355	87	0	1	24	60	4	1	0
355	185	0	1	27	60	3	0	0
355	63	2	1	38	60	3	0	0
355	127	2	1	27	60	4	0	0
356	296	1	1	46	60	2	1	0
356	326	2	0	24	60	4	1	0
356	314	0	0	40	60	0	0	0
356	238	1	0	28	60	4	0	0
356	492	2	0	46	60	4	0	0
356	60	0	1	45	60	3	0	0
356	109	0	1	35	60	5	1	0
356	256	1	0	21	60	5	0	0
357	91	0	0	41	60	1	0	0
357	110	1	1	25	60	5	0	0
357	439	0	1	43	60	0	0	0
357	301	0	0	44	60	0	0	0
357	112	1	1	47	60	1	1	0
357	458	2	0	29	60	2	0	0
357	76	1	1	23	60	5	1	0
357	339	1	1	22	60	4	0	0
358	305	0	0	39	60	1	0	0
358	490	0	0	34	60	4	0	0
358	148	0	0	22	60	1	1	0
358	184	0	0	39	60	5	0	0
358	222	2	1	20	60	0	0	0
358	402	1	0	38	60	1	0	0
358	245	2	0	30	60	5	0	0
358	344	1	0	25	60	3	0	0
359	330	2	0	48	60	2	0	0
359	36	0	1	26	60	1	1	0
359	134	0	0	39	60	3	1	0
359	488	0	1	42	60	3	0	0
359	225	1	1	48	60	3	0	0
359	26	0	0	38	60	5	0	0
359	109	0	0	42	60	1	0	0
359	20	0	0	33	60	0	1	0
360	385	2	0	33	60	2	0	0
360	58	1	1	44	60	2	0	0
360	80	0	1	31	60	2	0	0
360	150	2	1	43	60	2	1	0
360	77	1	0	36	60	5	0	0
360	330	0	0	29	60	4	0	0
360	117	2	0	32	60	2	0	0
360	335	2	0	48	60	4	0	0
361	461	1	1	38	60	1	0	0
361	4	1	1	50	60	3	0	0
361	203	2	0	23	60	1	1	0
361	33	2	1	26	60	0	0	0
361	134	1	0	46	60	5	0	0
361	32	1	1	37	60	4	0	0
361	219	0	1	50	60	4	0	0
361	206	1	1	40	60	2	1	0
362	22	2	0	22	60	2	0	0
362	121	1	0	49	60	1	0	0
362	311	1	0	34	60	4	0	0
362	491	0	1	46	60	0	0	0
362	145	2	0	28	60	2	0	0
362	81	0	1	30	60	3	1	0
362	52	0	0	38	60	2	0	0
362	382	2	1	49	60	5	0	0
363	244	1	0	46	60	2	0	0
363	5	2	0	45	60	0	0	0
363	73	2	0	47	60	3	0	0
363	80	1	0	47	60	3	0	0
363	11	1	1	46	60	1	0	0
363	310	2	1	30	60	4	0	0
363	253	1	0	21	60	1	0	0
363	499	0	0	36	60	3	0	0
364	162	2	0	35	60	2	0	0
364	172	0	0	46	60	4	0	0
364	358	0	0	43	60	3	1	0
364	80	1	0	22	60	4	0	0
364	205	2	0	43	60	1	0	0
364	21	2	1	47	60	5	0	0
364	185	2	0	44	60	2	1	0
364	30	2	1	39	60	3	0	0
365	36	1	1	22	60	3	0	0
365	18	2	1	25	60	2	1	0
365	425	0	1	41	60	2	1	0
365	412	1	1	40	60	1	0	0
365	49	2	1	32	60	1	0	0
365	1	1	0	39	60	5	1	0
365	359	0	0	30	60	0	0	0
365	381	1	1	27	60	3	0	0
366	319	1	1	36	60	2	0	0
366	437	2	1	46	60	1	0	0
366	91	1	1	27	60	0	1	0
366	318	0	0	27	60	4	0	0
366	277	0	1	30	60	0	0	0
366	475	2	1	25	60	5	0	0
366	426	1	0	24	60	2	0	0
366	137	2	1	44	60	5	0	0
367	91	2	1	40	60	3	0	0
367	10	0	0	22	60	3	0	0
367	382	0	0	25	60	3	1	0
367	388	2	1	24	60	1	1	0
367	227	1	1	38	60	1	0	0
367	362	1	0	46	60	4	0	0
367	92	0	0	36	60	5	0	0
367	77	1	0	23	60	1	0	0
368	486	1	1	32	60	3	0	0
368	99	1	1	25	60	5	0	0
368	10	1	1	39	60	2	0	0
368	391	0	1	42	60	5	0	0
368	291	2	0	32	60	4	0	0
368	173	1	0	25	60	2	1	0
368	381	2	1	31	60	2	0	0
368	24	2	1	22	60	1	0	0
369	100	0	1	40	60	4	0	0
369	59	2	0	45	60	2	0	0
369	128	2	1	45	60	0	0	0
369	34	1	0	31	60	4	1	0
369	110	2	0	36	60	5	0	0
369	295	1	0	21	60	2	0	0
369	106	1	0	42	60	4	0	0
369	179	1	0	31	60	1	1	0
370	172	0	1	24	60	0	0	0
370	118	2	1	41	60	3	0	0
370	362	2	1	29	60	0	0	0
370	38	2	1	44	60	5	0	0
370	8	1	0	21	60	4	0	0
370	162	2	1	26	60	2	0	0
370	19	0	1	25	60	1	0	0
370	163	0	0	39	60	5	0	0
371	462	2	0	35	60	1	0	0
371	381	2	1	44	60	3	0	0
371	339	1	0	36	60	3	0	0
371	425	0	0	36	60	3	1	0
371	344	1	0	42	60	4	0	0
371	12	0	1	48	60	5	1	0
371	287	0	1	33	60	2	0	0
371	374	1	1	48	60	4	0	0
372	379	1	0	21	60	0	0	0
372	156	0	1	50	60	4	0	0
372	425	0	1	29	60	5	0	0
372	128	2	0	50	60	3	0	0
372	362	0	0	40	60	0	0	0
372	226	2	0	41	60	1	1	0
372	82	0	0	35	60	3	0	0
372	456	1	0	45	60	0	0	0
373	370	2	0	42	60	0	0	0
373	212	0	1	26	60	1	0	0
373	450	0	1	33	60	1	0	0
373	342	0	0	21	60	3	0	0
373	143	1	1	42	60	1	0	0
373	279	0	0	50	60	0	1	0
373	84	0	1	49	60	4	1	0
373	381	2	1	41	60	1	1	0
374	36	1	1	44	60	4	0	0
374	386	1	0	46	60	1	0	0
374	52	0	1	42	60	0	1	0
374	25	1	1	24	60	4	1	0
374	86	0	0	43	60	5	0	0
374	58	1	0	32	60	5	1	0
374	369	1	1	34	60	2	0	0
374	90	2	1	50	60	3	0	0
375	176	1	1	40	60	5	1	0
375	278	2	0	42	60	5	0	0
375	251	2	1	23	60	5	1	0
375	495	1	1	37	60	4	0	0
375	435	2	1	36	60	2	0	0
375	429	0	1	33	60	4	0	0
375	107	2	1	26	60	3	0	0
375	121	1	0	43	60	0	0	0
376	22	2	0	45	60	3	0	0
376	86	1	0	37	60	0	0	0
376	298	2	1	43	60	2	1	0
376	313	1	1	29	60	4	1	0
376	84	1	1	30	60	3	1	0
376	132	1	1	46	60	3	0	0
376	176	0	0	34	60	3	1	0
376	202	2	1	49	60	4	0	0
377	410	1	0	34	60	3	0	0
377	208	2	0	42	60	4	0	0
377	322	2	1	26	60	4	1	0
377	132	1	0	31	60	3	0	0
377	470	1	1	34	60	2	0	0
377	113	2	1	28	60	4	0	0
377	194	0	0	34	60	3	0	0
377	199	2	1	38	60	2	0	0
378	63	2	0	25	60	5	0	0
378	86	1	0	20	60	3	0	0
378	34	0	0	30	60	5	0	0
378	139	0	1	33	60	0	0	0
378	442	2	0	32	60	3	1	0
378	267	0	0	50	60	5	0	0
378	152	2	0	33	60	4	0	0
378	144	2	1	46	60	1	1	0
379	499	1	1	39	60	0	0	0
379	202	1	1	37	60	0	0	0
379	324	1	1	49	60	1	0	0
379	262	2	1	25	60	0	1	0
379	467	2	0	37	60	1	0	0
379	307	2	1	49	60	0	1	0
379	6	1	1	42	60	4	0	0
379	237	0	1	20	60	0	0	0
380	496	0	1	21	60	3	1	0
380	299	2	1	49	60	3	0	0
380	467	2	0	42	60	0	0	0
380	199	0	0	22	60	3	0	0
380	500	0	1	22	60	1	0	0
380	449	1	1	34	60	0	0	0
380	444	0	1	20	60	4	0	0
380	153	1	0	24	60	5	0	0
381	489	1	1	26	60	1	0	0
381	478	1	0	20	60	0	1	0
381	346	1	1	45	60	2	0	0
381	271	2	0	42	60	1	1	0
381	486	2	0	48	60	2	1	0
381	481	0	0	31	60	3	0	0
381	186	1	0	48	60	3	0	0
381	11	1	0	27	60	5	0	0
382	119	2	1	36	60	4	0	0
382	384	1	1	23	60	2	0	0
382	447	2	1	33	60	2	0	0
382	453	2	0	24	60	1	0	0
382	395	0	1	26	60	3	0	0
382	440	0	1	46	60	4	0	0
382	50	1	1	48	60	1	0	0
382	352	0	0	40	60	3	1	0
383	79	0	0	46	60	5	0	0
383	254	0	1	22	60	1	1	0
383	206	2	0	32	60	4	0	0
383	62	1	0	32	60	0	1	0
383	76	0	1	42	60	1	1	0
383	316	2	0	22	60	5	0	0
383	230	1	0	37	60	1	0	0
383	2	0	1	49	60	4	0	0
384	250	1	1	42	60	5	0	0
384	285	1	0	38	60	4	1	0
384	231	1	1	45	60	2	1	0
384	456	2	1	35	60	3	0	0
384	361	1	1	36	60	2	0	0
384	66	2	1	37	60	0	0	0
384	264	1	0	44	60	1	0	0
384	311	2	1	21	60	3	0	0
385	161	0	0	26	60	3	0	0
385	470	1	0	43	60	1	1	0
385	223	1	1	49	60	3	0	0
385	91	2	0	31	60	4	0	0
385	284	2	0	40	60	2	0	0
385	134	1	1	49	60	4	0	0
385	137	0	0	22	60	4	0	0
385	336	0	1	48	60	4	0	0
386	300	2	1	39	60	4	0	0
386	213	1	1	36	60	0	0	0
386	78	1	1	22	60	5	0	0
386	77	2	0	23	60	2	0	0
386	332	1	1	29	60	0	0	0
386	398	1	0	25	60	2	1	0
386	242	2	0	35	60	3	0	0
386	467	1	1	29	60	1	0	0
387	329	0	0	28	60	2	1	0
387	413	2	1	41	60	0	1	0
387	353	1	1	37	60	5	0	0
387	383	1	1	46	60	3	0	0
387	305	1	0	33	60	4	0	0
387	258	0	1	34	60	2	1	0
387	142	0	0	35	60	5	1	0
387	75	2	1	46	60	3	0	0
388	93	0	0	28	60	2	0	0
388	271	2	1	30	60	0	1	0
388	106	2	0	41	60	4	0	0
388	294	0	1	22	60	5	0	0
388	345	0	1	49	60	4	1	0
388	116	2	0	45	60	0	0	0
388	439	2	1	36	60	4	0	0
388	398	1	0	42	60	4	0	0
389	346	0	1	30	60	4	0	0
389	262	2	1	25	60	3	0	0
389	185	0	1	31	60	4	0	0
389	333	0	1	41	60	4	0	0
389	200	0	0	39	60	3	0	0
389	374	2	0	21	60	2	0	0
389	194	2	1	27	60	3	0	0
389	494	1	0	47	60	2	1	0
390	40	0	1	35	60	0	0	0
390	5	2	0	22	60	4	0	0
390	327	2	0	46	60	0	1	0
390	354	0	1	21	60	2	0	0
390	24	1	1	46	60	0	0	0
390	490	2	0	40	60	1	0	0
390	180	1	1	32	60	5	0	0
390	80	0	1	41	60	5	0	0
391	244	2	0	35	60	1	0	0
391	303	1	1	41	60	1	1	0
391	13	1	1	41	60	5	0	0
391	272	0	1	20	60	4	1	0
391	100	1	0	25	60	3	1	0
391	497	0	1	37	60	5	0	0
391	310	0	1	21	60	0	0	0
391	404	2	0	42	60	0	0	0
392	291	2	1	36	60	1	0	0
392	463	2	1	39	60	1	0	0
392	184	0	0	30	60	3	0	0
392	41	0	1	26	60	1	0	0
392	153	1	0	28	60	0	0	0
392	130	1	1	40	60	1	0	0
392	93	1	1	37	60	5	1	0
392	18	2	1	21	60	1	0	0
393	257	1	1	44	60	1	0	0
393	371	0	0	44	60	1	0	0
393	361	0	1	20	60	0	1	0
393	143	1	0	31	60	0	0	0
393	311	1	0	37	60	1	0	0
393	191	2	1	45	60	1	0	0
393	344	0	1	43	60	5	1	0
393	214	0	1	32	60	5	0	0
394	469	1	1	40	60	2	0	0
394	19	0	0	47	60	1	0	0
394	78	2	0	46	60	5	0	0
394	44	1	0	27	60	4	1	0
394	90	0	1	37	60	1	0	0
394	185	1	1	34	60	3	0	0
394	116	2	1	42	60	2	0	0
394	484	1	0	25	60	3	1	0
395	471	2	0	42	60	5	1	0
395	196	2	1	22	60	1	0	0
395	488	1	0	29	60	1	0	0
395	295	0	0	25	60	4	0	0
395	320	0	1	34	60	0	0	0
395	360	2	0	38	60	1	0	0
395	422	2	1	36	60	3	0	0
395	13	2	1	21	60	5	0	0
396	91	0	1	25	60	3	0	0
396	362	0	0	41	60	0	1	0
396	169	1	0	45	60	2	1	0
396	115	0	0	26	60	2	1	0
396	123	2	1	36	60	5	0	0
396	280	2	0	28	60	4	0	0
396	32	1	1	21	60	0	1	0
396	195	0	1	31	60	0	1	0
397	361	1	1	45	60	2	1	0
397	184	1	1	27	60	0	1	0
397	427	2	0	34	60	2	0	0
397	407	2	0	28	60	0	1	0
397	9	1	0	39	60	0	0	0
397	90	1	1	35	60	0	0	0
397	151	0	1	49	60	4	1	0
397	278	2	1	27	60	5	0	0
398	466	2	0	42	60	3	1	0
398	322	1	1	42	60	5	0	0
398	381	1	1	37	60	0	1	0
398	369	2	0	46	60	2	0	0
398	100	0	0	27	60	2	1	0
398	296	0	1	23	60	2	0	0
398	62	2	0	37	60	5	1	0
398	391	1	1	29	60	3	0	0
399	241	0	1	21	60	5	0	0
399	2	0	0	29	60	2	1	0
399	219	1	1	20	60	4	0	0
399	284	1	0	23	60	0	0	0
399	125	1	0	39	60	4	1	0
399	315	2	1	44	60	4	1	0
399	319	2	0	22	60	0	0	0
399	52	2	0	44	60	3	1	0
400	224	2	0	32	60	2	0	0
400	203	2	1	30	60	2	0	0
400	398	1	1	29	60	1	0	0
400	97	1	1	39	60	4	1	0
400	193	2	1	34	60	4	0	0
400	117	0	1	50	60	0	0	0
400	147	1	0	37	60	0	0	0
400	276	1	1	20	60	1	1	0
401	89	0	0	49	60	4	0	0
401	289	0	1	39	60	3	1	0
401	129	2	0	44	60	2	0	0
401	132	1	0	26	60	0	0	0
401	234	2	0	23	60	1	0	0
401	62	2	0	42	60	1	0	0
401	63	2	1	34	60	5	0	0
401	460	0	1	48	60	1	0	0
402	275	1	1	47	60	1	1	0
402	26	1	1	39	60	5	0	0
402	196	2	1	23	60	0	0	0
402	111	0	0	20	60	4	0	0
402	205	1	0	32	60	2	1	0
402	239	2	1	30	60	5	0	0
402	11	0	0	29	60	0	0	0
402	378	0	0	30	60	4	1	0
403	411	0	0	20	60	2	0	0
403	69	2	1	30	60	0	0	0
403	328	1	1	47	60	3	1	0
403	396	0	1	20	60	1	0	0
403	341	2	1	20	60	3	0	0
403	499	0	1	20	60	1	0	0
403	379	1	0	37	60	4	1	0
403	403	2	1	23	60	2	0	0
404	442	0	1	30	60	0	0	0
404	438	2	0	30	60	0	0	0
404	60	1	1	21	60	3	1	0
404	102	0	0	35	60	3	1	0
404	251	0	1	49	60	4	0	0
404	45	1	1	38	60	5	0	0
404	413	1	0	49	60	5	0	0
404	89	2	1	33	60	4	1	0
405	22	1	0	27	60	5	0	0
405	29	1	1	20	60	1	0	0
405	251	2	1	39	60	0	0	0
405	118	0	1	48	60	3	0	0
405	205	0	0	41	60	1	0	0
405	351	0	0	37	60	4	0	0
405	206	2	0	36	60	3	0	0
405	480	1	0	33	60	5	0	0
406	130	1	1	36	60	3	0	0
406	239	2	1	44	60	4	0	0
406	328	1	1	47	60	2	0	0
406	147	2	0	34	60	0	0	0
406	20	1	0	34	60	4	0	0
406	311	2	0	42	60	4	0	0
406	32	0	0	37	60	0	1	0
406	345	2	1	28	60	1	0	0
407	345	2	1	21	60	5	0	0
407	325	0	0	35	60	5	0	0
407	444	1	0	39	60	0	0	0
407	329	0	1	36	60	2	0	0
407	189	2	1	29	60	0	0	0
407	495	1	1	30	60	5	0	0
407	6	0	1	34	60	0	0	0
407	81	1	1	49	60	0	0	0
408	391	2	0	50	60	3	0	0
408	257	2	1	50	60	3	1	0
408	275	2	0	27	60	4	0	0
408	401	1	0	33	60	2	1	0
408	326	0	1	33	60	2	0	0
408	292	0	1	42	60	0	1	0
408	87	0	0	35	60	3	0	0
408	159	1	0	42	60	4	0	0
409	42	2	0	22	60	4	1	0
409	356	0	1	48	60	1	0	0
409	496	2	0	49	60	1	0	0
409	246	0	0	40	60	4	0	0
409	151	0	0	26	60	1	0	0
409	440	2	1	35	60	4	0	0
409	493	1	1	35	60	5	0	0
409	52	2	0	35	60	0	1	0
410	36	2	1	27	60	4	1	0
410	188	2	1	34	60	2	0	0
410	112	2	1	41	60	4	0	0
410	353	0	1	32	60	4	0	0
410	444	0	0	40	60	0	1	0
410	266	0	1	24	60	2	0	0
410	134	2	1	22	60	3	0	0
410	423	1	0	30	60	2	0	0
411	30	0	1	38	60	3	0	0
411	432	2	0	38	60	1	1	0
411	369	0	1	36	60	5	1	0
411	274	0	0	31	60	3	1	0
411	388	0	1	41	60	2	0	0
411	52	0	1	38	60	4	0	0
411	106	0	1	46	60	1	0	0
411	68	2	0	50	60	0	0	0
412	225	2	1	50	60	1	0	0
412	231	0	1	43	60	2	0	0
412	181	2	0	28	60	2	0	0
412	385	1	1	22	60	4	1	0
412	194	2	0	42	60	2	0	0
412	354	1	1	40	60	3	0	0
412	404	1	0	42	60	3	0	0
412	327	2	0	22	60	1	0	0
413	459	2	1	39	60	3	1	0
413	433	1	1	33	60	5	0	0
413	116	0	0	28	60	5	0	0
413	344	2	0	28	60	3	0	0
413	179	0	1	31	60	1	0	0
413	215	1	1	48	60	3	0	0
413	262	1	1	47	60	5	0	0
413	172	1	1	49	60	1	0	0
414	187	1	1	26	60	2	0	0
414	384	1	0	45	60	0	0	0
414	365	0	0	46	60	2	0	0
414	70	2	0	24	60	4	0	0
414	395	2	1	28	60	4	1	0
414	142	1	0	26	60	2	0	0
414	386	0	1	25	60	0	1	0
414	119	0	0	34	60	5	0	0
415	267	2	1	32	60	2	0	0
415	55	0	1	33	60	3	0	0
415	345	1	0	28	60	4	0	0
415	142	0	1	45	60	5	0	0
415	83	2	1	29	60	0	1	0
415	2	2	1	24	60	0	0	0
415	488	1	0	49	60	5	0	0
415	385	0	1	47	60	1	0	0
416	439	2	1	20	60	4	0	0
416	186	1	0	46	60	0	1	0
416	1	1	1	33	60	0	0	0
416	127	0	0	45	60	1	1	0
416	331	2	1	43	60	4	0	0
416	223	2	0	41	60	0	0	0
416	66	0	1	38	60	0	0	0
416	129	0	0	32	60	0	0	0
417	67	2	1	43	60	5	0	0
417	134	0	0	50	60	5	0	0
417	268	1	0	46	60	2	0	0
417	489	0	1	48	60	0	1	0
417	106	0	1	38	60	5	0	0
417	113	0	1	40	60	4	0	0
417	221	2	1	42	60	1	0	0
417	457	0	0	28	60	0	0	0
418	461	0	0	39	60	2	0	0
418	277	0	0	40	60	1	1	0
418	29	0	0	39	60	3	1	0
418	298	0	0	21	60	0	0	0
418	38	0	0	35	60	1	0	0
418	428	0	0	23	60	3	0	0
418	312	0	0	45	60	0	0	0
418	479	2	0	43	60	4	0	0
419	318	1	1	50	60	5	0	0
419	79	1	1	41	60	5	1	0
419	310	1	1	48	60	2	0	0
419	261	2	0	31	60	4	0	0
419	373	2	0	26	60	0	0	0
419	171	2	1	43	60	0	0	0
419	477	2	1	39	60	4	0	0
419	269	1	1	21	60	4	0	0
420	239	0	0	26	60	2	0	0
420	119	2	0	22	60	1	1	0
420	180	0	0	41	60	1	0	0
420	310	0	0	40	60	4	0	0
420	491	0	0	43	60	4	0	0
420	70	0	1	28	60	2	0	0
420	403	2	1	33	60	2	0	0
420	280	1	1	25	60	0	0	0
421	446	2	0	37	60	0	1	0
421	370	2	1	20	60	5	0	0
421	150	2	0	39	60	1	0	0
421	369	1	0	27	60	4	0	0
421	271	2	0	32	60	5	0	0
421	188	2	0	20	60	5	1	0
421	64	2	0	27	60	4	0	0
421	209	0	0	41	60	3	0	0
422	169	1	1	46	60	5	1	0
422	205	0	1	37	60	4	1	0
422	160	2	0	46	60	3	1	0
422	236	1	1	21	60	1	0	0
422	434	1	1	41	60	2	0	0
422	56	1	1	48	60	3	0	0
422	152	0	1	39	60	0	0	0
422	325	0	0	48	60	0	0	0
423	238	2	1	40	60	2	0	0
423	453	1	0	30	60	4	0	0
423	425	1	0	50	60	2	0	0
423	183	2	1	45	60	2	0	0
423	406	0	1	20	60	0	1	0
423	355	0	1	39	60	0	1	0
423	219	0	0	40	60	4	0	0
423	394	2	1	29	60	5	0	0
424	226	0	0	45	60	3	1	0
424	258	2	1	34	60	0	1	0
424	88	0	1	43	60	3	0	0
424	304	0	0	48	60	1	0	0
424	399	0	0	34	60	0	0	0
424	458	1	0	33	60	0	1	0
424	198	2	0	28	60	4	1	0
424	114	1	0	47	60	1	0	0
425	387	0	0	32	60	1	1	0
425	453	2	0	21	60	2	0	0
425	147	0	1	33	60	0	1	0
425	364	2	0	44	60	4	0	0
425	90	0	0	39	60	1	1	0
425	32	1	0	20	60	0	0	0
425	203	1	0	48	60	1	0	0
425	348	0	0	32	60	4	0	0
426	347	1	0	24	60	2	1	0
426	285	2	1	46	60	1	0	0
426	351	0	1	34	60	3	0	0
426	263	2	0	33	60	3	1	0
426	22	2	0	49	60	4	0	0
426	487	2	0	23	60	2	0	0
426	388	2	1	22	60	0	0	0
426	221	0	0	47	60	0	0	0
427	456	2	0	36	60	4	0	0
427	462	0	0	21	60	3	1	0
427	112	2	0	32	60	4	0	0
427	124	1	0	41	60	2	0	0
427	233	0	1	35	60	1	0	0
427	39	2	1	44	60	0	1	0
427	400	2	0	28	60	3	0	0
427	94	1	0	35	60	2	0	0
428	81	2	1	46	60	3	0	0
428	322	2	0	43	60	3	0	0
428	175	0	0	32	60	3	0	0
428	307	1	1	35	60	1	0	0
428	277	2	1	43	60	1	0	0
428	257	0	1	42	60	3	0	0
428	36	2	1	48	60	3	0	0
428	423	1	1	30	60	4	0	0
429	218	0	0	45	60	4	0	0
429	2	1	0	47	60	3	0	0
429	98	0	1	36	60	3	0	0
429	254	0	0	42	60	4	0	0
429	286	1	1	20	60	5	1	0
429	202	0	1	26	60	4	0	0
429	164	2	0	31	60	2	0	0
429	393	2	0	38	60	3	0	0
430	63	0	1	47	60	0	1	0
430	488	2	1	24	60	4	0	0
430	331	2	0	30	60	5	0	0
430	132	1	0	31	60	4	0	0
430	300	0	0	50	60	5	1	0
430	359	1	0	32	60	4	0	0
430	78	2	0	28	60	2	0	0
430	308	1	1	34	60	0	0	0
431	343	2	0	21	60	0	0	0
431	482	2	0	35	60	0	0	0
431	338	1	0	41	60	0	0	0
431	475	0	1	22	60	5	0	0
431	250	0	0	27	60	3	0	0
431	103	1	0	24	60	0	0	0
431	178	0	1	39	60	3	0	0
431	477	2	1	38	60	3	0	0
432	46	1	1	27	60	0	0	0
432	329	2	0	44	60	4	1	0
432	108	2	0	30	60	3	0	0
432	423	1	1	20	60	5	0	0
432	115	1	0	23	60	1	0	0
432	413	1	0	28	60	2	0	0
432	205	0	0	42	60	4	0	0
432	255	1	0	40	60	2	0	0
433	264	0	1	24	60	1	0	0
433	381	1	1	40	60	1	0	0
433	304	1	1	29	60	2	1	0
433	176	0	1	28	60	2	0	0
433	377	0	1	43	60	1	0	0
433	183	0	0	39	60	3	0	0
433	62	0	1	34	60	0	0	0
433	313	2	1	50	60	1	0	0
434	102	0	1	41	60	4	1	0
434	480	0	0	49	60	4	0	0
434	173	2	0	30	60	0	0	0
434	15	0	1	22	60	2	0	0
434	171	2	1	41	60	2	0	0
434	388	0	1	38	60	1	0	0
434	233	0	1	43	60	0	0	0
434	20	0	0	25	60	4	0	0
435	296	0	1	20	60	0	1	0
435	136	0	1	41	60	2	0	0
435	193	0	0	44	60	2	1	0
435	456	2	0	26	60	1	1	0
435	261	2	1	34	60	0	0	0
435	31	0	1	32	60	3	0	0
435	63	2	0	44	60	0	1	0
435	355	2	1	44	60	1	1	0
436	203	2	1	23	60	1	0	0
436	483	1	0	38	60	1	0	0
436	28	2	0	44	60	0	0	0
436	431	2	1	46	60	3	1	0
436	434	2	0	28	60	0	0	0
436	85	1	1	23	60	2	1	0
436	234	1	1	31	60	0	1	0
436	215	2	1	39	60	2	1	0
437	43	2	0	38	60	5	0	0
437	471	1	1	42	60	2	0	0
437	222	1	0	44	60	2	0	0
437	97	0	1	43	60	0	0	0
437	141	2	0	28	60	2	0	0
437	53	0	0	45	60	3	1	0
437	344	2	1	47	60	3	1	0
437	361	2	1	29	60	1	0	0
438	149	1	1	23	60	4	0	0
438	391	0	0	33	60	4	1	0
438	439	2	0	26	60	1	0	0
438	428	0	0	23	60	3	0	0
438	207	2	0	33	60	4	0	0
438	410	1	1	29	60	0	0	0
438	251	1	1	37	60	3	0	0
438	39	0	1	28	60	1	0	0
439	378	2	1	24	60	4	0	0
439	493	0	1	25	60	5	0	0
439	198	2	0	26	60	5	1	0
439	465	2	0	34	60	1	0	0
439	147	1	1	20	60	3	1	0
439	264	1	0	44	60	5	1	0
439	174	1	0	44	60	5	1	0
439	246	1	1	31	60	5	0	0
440	488	0	1	42	60	0	0	0
440	65	2	0	30	60	1	0	0
440	118	0	0	23	60	5	0	0
440	149	1	0	29	60	1	0	0
440	306	1	0	32	60	3	0	0
440	82	0	1	49	60	0	0	0
440	318	0	1	37	60	3	0	0
440	74	0	0	29	60	4	0	0
441	275	0	0	33	60	2	0	0
441	312	0	0	21	60	1	1	0
441	257	2	0	45	60	3	0	0
441	31	2	0	36	60	1	0	0
441	322	1	1	47	60	5	0	0
441	409	1	1	34	60	1	0	0
441	118	2	1	39	60	4	0	0
441	429	0	1	49	60	5	1	0
442	368	1	1	41	60	1	0	0
442	128	1	1	40	60	5	0	0
442	179	0	1	23	60	3	0	0
442	114	0	0	32	60	4	0	0
442	417	2	0	30	60	5	0	0
442	271	0	1	39	60	3	0	0
442	146	1	0	40	60	3	1	0
442	171	2	0	36	60	4	0	0
443	390	2	1	26	60	3	0	0
443	16	2	1	23	60	5	0	0
443	36	0	1	24	60	3	0	0
443	208	0	0	47	60	1	0	0
443	383	2	0	45	60	3	1	0
443	278	2	1	20	60	2	0	0
443	107	2	0	28	60	0	0	0
443	329	2	1	35	60	0	0	0
444	319	0	0	36	60	5	0	0
444	103	2	0	32	60	3	0	0
444	482	2	0	20	60	2	0	0
444	357	0	0	44	60	4	0	0
444	458	1	0	37	60	4	1	0
444	360	0	1	21	60	2	0	0
444	460	0	0	50	60	3	0	0
444	303	1	0	23	60	2	0	0
445	336	1	0	29	60	2	0	0
445	1	1	1	39	60	3	0	0
445	360	1	1	27	60	0	1	0
445	206	0	1	36	60	3	1	0
445	313	2	1	30	60	4	0	0
445	491	2	1	50	60	5	0	0
445	207	0	1	31	60	2	1	0
445	49	0	1	21	60	5	0	0
446	83	2	1	36	60	3	0	0
446	434	1	1	21	60	2	0	0
446	189	2	1	48	60	0	0	0
446	294	2	0	24	60	3	0	0
446	216	1	1	32	60	0	0	0
446	49	1	0	32	60	4	0	0
446	148	2	1	40	60	3	0	0
446	214	2	1	40	60	1	0	0
447	312	2	1	42	60	0	0	0
447	395	0	1	37	60	3	1	0
447	137	0	1	22	60	1	0	0
447	448	1	1	40	60	5	1	0
447	227	2	0	20	60	5	0	0
447	375	1	0	45	60	2	1	0
447	129	2	0	31	60	4	0	0
447	408	0	0	28	60	0	0	0
448	61	1	1	33	60	4	1	0
448	249	0	0	34	60	2	0	0
448	271	1	1	44	60	2	0	0
448	168	0	0	32	60	5	0	0
448	79	0	0	27	60	5	1	0
448	415	0	1	25	60	1	0	0
448	462	0	0	35	60	2	1	0
448	431	2	1	36	60	3	0	0
449	108	1	0	24	60	5	0	0
449	126	1	0	45	60	0	0	0
449	60	2	1	50	60	3	1	0
449	292	1	1	43	60	1	0	0
449	104	1	1	35	60	5	0	0
449	4	0	0	37	60	1	0	0
449	388	1	0	30	60	4	0	0
449	182	1	1	46	60	5	0	0
450	246	1	1	46	60	4	0	0
450	260	0	0	47	60	4	0	0
450	284	0	0	46	60	0	0	0
450	217	1	1	40	60	0	0	0
450	182	1	0	31	60	3	1	0
450	248	0	0	42	60	4	0	0
450	21	2	1	29	60	3	0	0
450	428	1	1	39	60	3	0	0
451	77	0	0	28	60	3	0	0
451	204	2	1	29	60	0	0	0
451	49	1	1	21	60	3	0	0
451	459	0	1	25	60	4	0	0
451	232	1	1	27	60	3	0	0
451	298	2	0	37	60	0	0	0
451	265	1	0	20	60	1	0	0
451	475	0	1	29	60	4	0	0
452	386	0	1	46	60	3	0	0
452	297	1	1	23	60	4	0	0
452	396	0	1	28	60	0	0	0
452	277	1	1	31	60	3	1	0
452	300	0	0	22	60	3	0	0
452	359	1	1	22	60	5	0	0
452	227	1	0	27	60	5	0	0
452	268	0	1	45	60	5	0	0
453	139	1	1	43	60	4	0	0
453	109	2	0	35	60	4	1	0
453	467	1	0	22	60	3	0	0
453	71	1	1	34	60	5	1	0
453	261	0	1	25	60	2	0	0
453	148	1	0	50	60	0	0	0
453	473	1	0	25	60	2	0	0
453	457	2	0	48	60	4	0	0
454	198	0	0	48	60	2	0	0
454	417	0	1	34	60	4	1	0
454	29	1	1	39	60	1	0	0
454	358	2	0	44	60	0	0	0
454	406	2	0	44	60	1	0	0
454	31	1	0	38	60	2	0	0
454	382	1	0	38	60	5	0	0
454	253	0	1	37	60	1	0	0
455	136	2	1	25	60	5	1	0
455	314	0	0	44	60	3	0	0
455	360	1	1	34	60	3	0	0
455	93	1	1	23	60	1	1	0
455	469	0	0	24	60	4	0	0
455	14	2	1	31	60	3	1	0
455	24	0	0	49	60	0	0	0
455	410	2	0	33	60	1	0	0
456	285	1	1	46	60	1	0	0
456	81	2	0	45	60	0	0	0
456	397	0	1	50	60	4	0	0
456	157	1	0	25	60	2	1	0
456	152	0	1	49	60	2	0	0
456	211	1	1	24	60	5	0	0
456	113	2	0	48	60	3	1	0
456	328	2	0	21	60	5	0	0
457	91	0	1	38	60	0	0	0
457	398	0	1	21	60	2	0	0
457	14	2	1	39	60	1	0	0
457	363	2	0	20	60	4	0	0
457	348	2	0	38	60	0	0	0
457	198	0	0	29	60	5	1	0
457	291	0	0	37	60	5	1	0
457	185	2	1	41	60	3	0	0
458	280	2	0	34	60	1	0	0
458	83	2	1	38	60	4	0	0
458	243	0	0	28	60	1	0	0
458	54	2	0	35	60	2	1	0
458	30	1	0	23	60	3	0	0
458	164	1	0	20	60	4	0	0
458	486	0	0	37	60	1	0	0
458	315	1	0	23	60	2	0	0
459	458	1	0	43	60	5	0	0
459	453	2	0	22	60	4	0	0
459	285	0	0	40	60	4	0	0
459	342	0	1	38	60	4	0	0
459	101	0	1	29	60	4	1	0
459	439	0	0	43	60	3	0	0
459	185	2	0	48	60	3	0	0
459	362	0	1	38	60	5	0	0
460	308	0	1	36	60	5	0	0
460	163	1	1	44	60	5	0	0
460	74	2	1	46	60	1	0	0
460	283	1	0	33	60	1	0	0
460	393	1	0	24	60	0	1	0
460	432	1	0	36	60	0	0	0
460	298	2	0	41	60	0	0	0
460	71	0	1	30	60	2	0	0
461	45	1	0	28	60	1	0	0
461	207	0	0	38	60	1	0	0
461	258	2	1	27	60	5	0	0
461	57	1	0	34	60	1	0	0
461	74	2	0	50	60	4	1	0
461	288	1	0	28	60	0	0	0
461	228	2	0	42	60	5	0	0
461	267	2	1	50	60	1	0	0
462	493	1	0	25	60	4	0	0
462	170	1	1	27	60	1	0	0
462	150	1	1	40	60	1	0	0
462	472	0	0	22	60	2	1	0
462	350	0	0	49	60	0	0	0
462	270	0	1	20	60	5	0	0
462	255	2	0	24	60	5	0	0
462	212	2	0	42	60	3	0	0
463	21	0	0	21	60	2	0	0
463	491	2	0	34	60	1	1	0
463	13	2	1	40	60	5	1	0
463	439	1	0	31	60	4	0	0
463	371	2	1	23	60	1	0	0
463	272	1	0	44	60	5	0	0
463	217	2	1	45	60	3	0	0
463	182	0	0	43	60	4	1	0
464	452	0	0	38	60	5	0	0
464	272	0	1	26	60	1	0	0
464	362	0	0	46	60	3	0	0
464	391	0	1	37	60	3	0	0
464	228	0	1	48	60	5	0	0
464	358	2	1	30	60	2	0	0
464	179	0	1	41	60	1	0	0
464	194	2	0	38	60	4	1	0
465	458	0	1	30	60	5	0	0
465	30	2	1	27	60	2	0	0
465	372	2	0	45	60	3	0	0
465	267	2	1	32	60	2	0	0
465	412	0	0	49	60	0	0	0
465	18	2	1	32	60	5	0	0
465	275	0	1	30	60	2	1	0
465	331	1	1	48	60	4	0	0
466	306	1	1	29	60	0	1	0
466	10	0	0	20	60	3	0	0
466	80	2	1	46	60	1	0	0
466	173	1	0	45	60	0	0	0
466	424	2	1	40	60	4	0	0
466	114	2	0	22	60	2	0	0
466	456	1	1	36	60	5	0	0
466	439	1	1	34	60	1	1	0
467	396	0	1	44	60	0	0	0
467	194	1	1	23	60	4	0	0
467	328	1	0	30	60	2	0	0
467	103	2	1	43	60	3	0	0
467	456	2	0	24	60	0	0	0
467	471	0	1	20	60	3	1	0
467	375	2	0	30	60	2	0	0
467	116	0	0	21	60	3	0	0
468	260	0	1	38	60	1	0	0
468	241	1	0	46	60	4	1	0
468	481	2	1	34	60	5	1	0
468	8	1	0	29	60	5	0	0
468	185	0	1	23	60	0	0	0
468	282	0	0	39	60	3	0	0
468	237	1	1	23	60	3	1	0
468	283	0	0	26	60	1	0	0
469	25	2	1	20	60	4	0	0
469	83	0	0	36	60	0	0	0
469	414	0	1	28	60	2	0	0
469	233	0	1	25	60	3	0	0
469	56	2	1	30	60	3	1	0
469	185	1	0	29	60	1	0	0
469	229	2	0	37	60	5	0	0
469	279	2	0	22	60	1	1	0
470	138	0	0	39	60	5	1	0
470	345	0	1	23	60	3	0	0
470	202	2	1	50	60	0	0	0
470	161	0	0	28	60	2	0	0
470	427	0	1	35	60	5	0	0
470	68	1	1	32	60	4	0	0
470	238	2	1	34	60	2	0	0
470	140	0	0	36	60	5	0	0
471	267	1	1	22	60	4	1	0
471	61	1	1	36	60	5	0	0
471	222	1	0	30	60	4	1	0
471	409	0	1	28	60	2	0	0
471	136	2	0	49	60	3	1	0
471	425	1	1	37	60	4	0	0
471	35	2	0	25	60	3	1	0
471	60	2	0	50	60	5	0	0
472	403	1	1	42	60	0	0	0
472	98	0	1	41	60	1	0	0
472	382	2	0	27	60	1	0	0
472	446	1	1	40	60	4	1	0
472	194	2	0	27	60	2	0	0
472	94	1	0	32	60	1	1	0
472	56	0	1	21	60	0	0	0
472	107	0	1	41	60	0	0	0
473	276	2	0	40	60	4	1	0
473	206	2	1	38	60	5	1	0
473	131	0	1	36	60	2	0	0
473	458	2	0	31	60	5	1	0
473	97	2	1	34	60	5	1	0
473	258	2	1	26	60	3	0	0
473	194	2	0	37	60	1	0	0
473	48	2	0	48	60	1	0	0
474	128	0	1	46	60	5	0	0
474	96	0	1	22	60	0	1	0
474	265	0	1	26	60	5	0	0
474	161	2	1	25	60	4	1	0
474	95	0	1	27	60	2	0	0
474	122	0	0	30	60	5	0	0
474	82	0	1	27	60	5	0	0
474	267	2	0	46	60	3	0	0
475	41	2	0	28	60	5	0	0
475	71	0	1	47	60	3	1	0
475	377	1	0	37	60	1	0	0
475	405	1	1	45	60	0	0	0
475	87	1	1	44	60	0	1	0
475	249	0	1	48	60	2	1	0
475	45	2	0	29	60	0	0	0
475	302	1	1	27	60	2	0	0
476	207	2	0	48	60	5	1	0
476	197	0	1	24	60	3	0	0
476	96	2	1	41	60	4	0	0
476	135	0	1	42	60	1	1	0
476	292	0	0	39	60	2	1	0
476	335	0	0	31	60	4	0	0
476	432	1	0	27	60	2	0	0
476	104	0	1	46	60	4	0	0
477	191	1	1	25	60	5	0	0
477	221	0	0	33	60	5	0	0
477	337	0	1	31	60	3	0	0
477	233	1	1	22	60	3	1	0
477	56	0	1	49	60	1	0	0
477	92	1	1	50	60	3	0	0
477	391	2	1	38	60	2	0	0
477	30	0	1	49	60	3	0	0
478	120	1	1	21	60	5	0	0
478	127	1	1	24	60	5	0	0
478	389	2	1	21	60	3	0	0
478	8	1	0	47	60	4	0	0
478	434	2	0	24	60	4	0	0
478	296	0	0	25	60	1	0	0
478	414	0	0	33	60	1	0	0
478	406	2	1	37	60	4	1	0
479	63	2	1	42	60	1	1	0
479	211	2	1	44	60	1	0	0
479	32	2	1	37	60	0	0	0
479	97	1	1	44	60	2	0	0
479	368	2	1	45	60	4	0	0
479	106	0	0	26	60	3	1	0
479	361	0	1	36	60	2	0	0
479	51	1	1	20	60	5	0	0
480	366	2	1	28	60	5	0	0
480	241	2	1	44	60	5	1	0
480	396	1	0	38	60	4	0	0
480	146	1	0	35	60	1	0	0
480	194	2	1	21	60	0	0	0
480	127	2	1	20	60	3	1	0
480	154	0	0	29	60	4	0	0
480	379	0	0	32	60	1	0	0
481	379	2	0	48	60	2	0	0
481	475	1	0	32	60	3	0	0
481	103	0	0	36	60	4	0	0
481	463	2	1	46	60	5	0	0
481	488	1	0	40	60	4	1	0
481	113	0	0	38	60	4	0	0
481	94	1	0	23	60	0	0	0
481	285	2	0	41	60	0	0	0
482	347	2	0	39	60	1	0	0
482	1	1	1	26	60	5	0	0
482	125	0	1	37	60	1	0	0
482	117	2	1	21	60	0	0	0
482	17	0	1	32	60	5	0	0
482	260	2	0	21	60	4	0	0
482	364	0	0	50	60	0	0	0
482	166	0	0	43	60	4	0	0
483	456	0	0	31	60	4	0	0
483	411	2	0	49	60	0	0	0
483	115	0	0	37	60	4	0	0
483	363	0	0	47	60	0	1	0
483	55	2	1	39	60	5	0	0
483	226	1	1	45	60	4	0	0
483	370	0	1	44	60	0	0	0
483	168	0	0	25	60	3	0	0
484	231	0	0	34	60	1	0	0
484	410	1	1	46	60	5	1	0
484	285	2	0	46	60	1	0	0
484	406	1	0	45	60	0	0	0
484	307	0	1	37	60	3	1	0
484	437	2	1	47	60	3	0	0
484	94	2	0	35	60	0	0	0
484	397	2	1	25	60	4	0	0
485	432	2	1	34	60	5	0	0
485	187	1	1	32	60	1	0	0
485	188	1	0	38	60	1	1	0
485	346	2	0	23	60	2	0	0
485	23	2	1	29	60	3	0	0
485	408	1	0	39	60	2	0	0
485	239	1	1	35	60	5	0	0
485	59	1	0	43	60	0	0	0
486	401	1	0	43	60	3	0	0
486	46	2	1	33	60	0	0	0
486	431	2	0	50	60	4	0	0
486	123	0	0	35	60	5	1	0
486	65	1	0	37	60	3	0	0
486	364	2	1	41	60	1	0	0
486	30	1	0	50	60	2	0	0
486	190	1	1	21	60	3	0	0
487	441	1	0	26	60	4	0	0
487	414	0	1	27	60	5	0	0
487	368	0	1	24	60	5	0	0
487	120	0	0	24	60	2	0	0
487	398	0	0	30	60	4	1	0
487	114	1	0	47	60	3	0	0
487	135	2	0	34	60	2	0	0
487	86	2	1	22	60	1	1	0
488	113	1	0	31	60	4	0	0
488	4	1	1	44	60	0	0	0
488	403	2	0	43	60	3	0	0
488	125	2	0	36	60	5	0	0
488	170	2	0	29	60	1	1	0
488	180	2	0	27	60	3	1	0
488	406	2	0	26	60	4	1	0
488	478	0	1	35	60	3	0	0
489	222	1	1	29	60	2	1	0
489	241	2	0	34	60	4	0	0
489	368	0	1	22	60	1	1	0
489	379	2	1	40	60	2	1	0
489	233	2	0	49	60	4	0	0
489	165	0	1	20	60	1	0	0
489	51	1	0	21	60	4	0	0
489	197	0	1	35	60	0	0	0
490	48	2	0	28	60	5	0	0
490	139	2	1	46	60	2	0	0
490	119	1	0	36	60	4	0	0
490	200	0	1	35	60	3	0	0
490	433	2	0	35	60	4	1	0
490	279	0	1	33	60	2	0	0
490	235	1	0	30	60	5	0	0
490	398	0	1	48	60	1	0	0
491	41	0	0	48	60	3	0	0
491	114	1	0	21	60	3	0	0
491	487	1	0	42	60	5	0	0
491	35	1	1	38	60	1	0	0
491	170	1	1	21	60	3	0	0
491	30	2	0	45	60	3	1	0
491	106	2	0	34	60	0	0	0
491	370	2	1	43	60	2	0	0
492	117	0	0	25	60	4	0	0
492	410	1	1	29	60	3	0	0
492	401	0	0	49	60	0	0	0
492	407	2	1	29	60	4	1	0
492	337	2	0	20	60	5	0	0
492	106	2	0	30	60	4	0	0
492	222	1	0	50	60	1	0	0
492	172	2	0	28	60	3	0	0
493	391	0	1	50	60	3	0	0
493	149	2	0	32	60	3	1	0
493	438	0	1	36	60	1	0	0
493	151	2	1	48	60	2	0	0
493	297	2	1	49	60	0	0	0
493	235	2	0	20	60	3	0	0
493	470	1	1	28	60	3	1	0
493	56	1	1	36	60	5	0	0
494	171	2	1	33	60	1	0	0
494	226	0	0	35	60	4	0	0
494	19	2	0	33	60	3	0	0
494	94	1	0	23	60	4	1	0
494	292	1	1	28	60	4	0	0
494	11	1	0	24	60	3	0	0
494	289	0	0	35	60	0	0	0
494	187	0	1	21	60	4	0	0
495	442	0	0	45	60	4	0	0
495	200	2	0	23	60	3	0	0
495	357	0	0	50	60	0	1	0
495	10	0	1	49	60	1	1	0
495	420	2	1	23	60	4	0	0
495	151	0	0	36	60	0	0	0
495	220	0	0	28	60	5	1	0
495	76	2	1	32	60	0	1	0
496	158	2	1	44	60	5	0	0
496	432	0	0	47	60	1	0	0
496	7	2	0	27	60	5	0	0
496	458	0	1	24	60	5	0	0
496	425	0	0	21	60	2	0	0
496	493	1	1	29	60	0	1	0
496	398	2	0	21	60	4	0	0
496	335	2	1	45	60	4	1	0
497	180	2	0	46	60	1	0	0
497	363	0	1	30	60	3	0	0
497	161	0	0	25	60	3	1	0
497	95	1	0	45	60	1	1	0
497	334	2	0	37	60	1	0	0
497	80	1	0	24	60	2	0	0
497	215	1	0	43	60	3	0	0
497	51	0	1	49	60	4	1	0
498	291	2	1	23	60	0	1	0
498	354	1	1	22	60	5	0	0
498	319	1	0	47	60	4	0	0
498	181	1	0	29	60	0	0	0
498	297	1	1	26	60	4	0	0
498	23	1	0	24	60	5	0	0
498	343	1	0	46	60	2	0	0
498	454	1	1	22	60	1	0	0
499	35	0	1	48	60	4	0	0
499	298	2	1	32	60	3	0	0
499	349	0	0	37	60	0	0	0
499	45	2	1	20	60	4	0	0
499	233	2	1	29	60	4	0	0
499	304	1	1	41	60	4	0	0
499	25	2	0	34	60	5	0	0
499	326	0	1	22	60	4	0	0
500	209	1	1	38	60	1	0	0
500	45	0	0	46	60	4	0	0
500	225	1	0	38	60	0	0	0
500	273	0	1	30	60	3	0	0
500	205	1	1	20	60	4	0	0
500	1	1	0	50	60	5	1	0
500	113	1	0	49	60	5	0	0
500	153	0	1	36	60	4	0	0
501	380	0	1	20	60	4	0	0
501	431	1	1	29	60	1	0	0
501	269	2	1	36	60	2	1	0
501	150	0	1	22	60	4	0	0
501	36	2	0	40	60	4	0	0
501	3	0	1	30	60	1	0	0
501	353	0	0	43	60	5	0	0
501	161	1	1	27	60	4	0	0
502	188	2	1	21	60	5	0	0
502	417	1	1	35	60	5	1	0
502	299	2	0	48	60	1	0	0
502	288	2	0	29	60	3	1	0
502	191	1	0	43	60	4	0	0
502	407	1	1	22	60	2	0	0
502	454	1	1	23	60	4	1	0
502	125	1	1	23	60	2	0	0
503	449	2	0	29	60	0	0	0
503	496	2	0	21	60	4	0	0
503	417	2	0	45	60	4	0	0
503	342	2	1	48	60	0	1	0
503	21	1	0	45	60	1	0	0
503	390	2	0	33	60	1	0	0
503	425	1	0	39	60	1	0	0
503	160	0	0	21	60	0	0	0
504	185	0	0	32	60	0	1	0
504	468	0	0	30	60	5	1	0
504	127	2	1	29	60	4	0	0
504	156	0	1	20	60	3	0	0
504	367	2	1	41	60	5	1	0
504	327	0	0	29	60	0	0	0
504	358	1	0	33	60	5	1	0
504	69	0	1	34	60	1	0	0
505	433	1	0	39	60	3	0	0
505	59	2	1	50	60	3	0	0
505	280	0	1	43	60	2	0	0
505	450	2	0	20	60	4	0	0
505	255	2	1	33	60	3	0	0
505	369	1	1	26	60	5	0	0
505	319	1	0	36	60	3	0	0
505	249	0	0	50	60	5	0	0
506	426	0	1	47	60	5	0	0
506	11	1	0	35	60	5	0	0
506	306	1	1	42	60	4	0	0
506	212	0	0	43	60	1	0	0
506	354	0	0	23	60	2	0	0
506	176	2	0	49	60	2	0	0
506	291	1	1	44	60	3	1	0
506	121	1	1	40	60	3	0	0
507	488	0	0	31	60	1	0	0
507	108	0	1	40	60	4	0	0
507	200	1	0	34	60	5	1	0
507	98	2	0	38	60	2	0	0
507	392	1	1	39	60	0	0	0
507	340	0	1	23	60	2	0	0
507	30	0	1	29	60	1	0	0
507	121	1	1	42	60	0	0	0
508	1	2	0	26	60	4	0	0
508	452	0	1	38	60	5	1	0
508	290	0	1	25	60	3	0	0
508	445	0	1	47	60	5	1	0
508	332	2	1	21	60	4	1	0
508	71	0	0	30	60	4	0	0
508	380	0	1	30	60	0	1	0
508	409	1	1	24	60	0	0	0
509	389	0	1	47	60	5	1	0
509	374	1	0	22	60	3	0	0
509	20	0	1	40	60	5	0	0
509	282	1	1	36	60	1	0	0
509	118	2	0	50	60	1	1	0
509	102	0	0	25	60	3	0	0
509	81	2	1	40	60	3	0	0
509	70	1	1	46	60	5	0	0
510	454	2	0	48	60	2	1	0
510	273	1	1	49	60	0	0	0
510	262	1	0	23	60	2	0	0
510	37	2	1	50	60	5	0	0
510	161	0	1	23	60	4	0	0
510	70	0	1	28	60	1	0	0
510	369	2	1	41	60	4	0	0
510	250	1	0	40	60	2	0	0
511	235	2	0	41	60	4	1	0
511	362	2	1	36	60	3	0	0
511	300	2	1	26	60	2	0	0
511	181	1	0	50	60	2	1	0
511	459	1	0	37	60	5	0	0
511	174	0	0	38	60	2	0	0
511	353	2	0	24	60	4	0	0
511	285	0	1	48	60	0	1	0
512	274	1	0	50	60	1	0	0
512	334	2	1	36	60	5	1	0
512	276	0	0	32	60	4	0	0
512	127	0	1	39	60	4	0	0
512	332	2	0	37	60	1	0	0
512	231	1	0	45	60	3	1	0
512	14	1	0	48	60	1	0	0
512	294	1	0	35	60	1	0	0
513	452	1	0	42	60	1	1	0
513	283	2	1	28	60	2	1	0
513	486	1	0	35	60	5	1	0
513	110	2	0	42	60	0	1	0
513	13	1	0	30	60	1	0	0
513	314	0	1	30	60	0	0	0
513	106	1	1	28	60	5	0	0
513	331	0	1	25	60	5	0	0
514	20	2	1	45	60	2	1	0
514	500	2	0	40	60	2	0	0
514	479	0	1	40	60	0	0	0
514	308	2	1	49	60	1	0	0
514	257	2	0	27	60	0	0	0
514	467	0	1	24	60	5	0	0
514	163	1	0	26	60	2	0	0
514	470	2	1	47	60	5	0	0
515	333	2	1	46	60	4	0	0
515	51	0	1	48	60	5	0	0
515	117	1	1	43	60	5	0	0
515	330	1	1	30	60	5	0	0
515	253	1	0	48	60	5	0	0
515	474	0	1	33	60	0	0	0
515	467	2	0	43	60	4	0	0
515	412	1	0	42	60	0	0	0
516	302	0	0	37	60	2	1	0
516	83	1	0	46	60	0	0	0
516	217	0	1	30	60	0	0	0
516	14	2	0	35	60	4	0	0
516	363	2	0	41	60	5	0	0
516	51	0	0	28	60	0	1	0
516	324	1	0	32	60	4	1	0
516	491	0	1	33	60	3	0	0
517	182	0	0	32	60	3	0	0
517	419	0	0	40	60	2	1	0
517	1	0	1	48	60	2	0	0
517	126	1	1	42	60	2	1	0
517	157	2	0	49	60	4	0	0
517	226	1	1	22	60	5	0	0
517	102	1	1	26	60	3	0	0
517	258	1	1	28	60	4	0	0
518	473	1	0	45	60	5	1	0
518	374	0	0	49	60	2	1	0
518	304	0	0	46	60	5	0	0
518	48	1	0	23	60	3	1	0
518	295	2	0	50	60	2	0	0
518	92	0	0	35	60	3	0	0
518	377	2	1	22	60	4	0	0
518	118	0	0	41	60	4	0	0
519	233	2	0	26	60	5	0	0
519	192	2	1	36	60	1	0	0
519	268	1	1	43	60	1	0	0
519	65	0	0	37	60	1	0	0
519	404	1	0	36	60	1	1	0
519	258	0	1	30	60	0	0	0
519	365	2	1	24	60	3	1	0
519	221	0	0	23	60	4	1	0
520	444	2	0	42	60	1	0	0
520	412	2	0	33	60	1	1	0
520	248	1	1	34	60	5	0	0
520	23	1	1	39	60	4	1	0
520	31	2	0	46	60	1	0	0
520	382	1	0	32	60	1	0	0
520	404	1	1	46	60	1	0	0
520	423	1	0	35	60	2	0	0
521	383	1	0	21	60	3	1	0
521	92	2	0	33	60	0	0	0
521	250	2	1	49	60	0	0	0
521	49	2	0	36	60	1	0	0
521	288	2	0	25	60	5	0	0
521	173	0	1	33	60	3	0	0
521	57	2	0	32	60	2	0	0
521	237	0	1	37	60	0	1	0
522	270	1	0	38	60	0	0	0
522	321	1	0	36	60	1	0	0
522	448	0	1	49	60	3	1	0
522	84	0	0	34	60	3	0	0
522	284	0	0	32	60	2	0	0
522	165	0	1	37	60	5	0	0
522	316	2	1	41	60	3	0	0
522	483	0	0	25	60	5	0	0
523	285	2	1	29	60	2	0	0
523	117	0	0	50	60	5	0	0
523	453	1	0	22	60	3	1	0
523	155	1	0	42	60	2	1	0
523	78	0	0	49	60	2	0	0
523	190	2	0	42	60	1	0	0
523	110	0	0	31	60	0	0	0
523	94	1	1	29	60	5	0	0
524	463	0	0	49	60	5	0	0
524	21	1	1	36	60	0	0	0
524	346	2	1	43	60	0	0	0
524	404	1	1	33	60	1	0	0
524	102	1	0	24	60	1	0	0
524	142	0	1	29	60	3	0	0
524	232	0	1	40	60	0	1	0
524	280	1	0	45	60	5	1	0
525	156	0	1	50	60	4	1	0
525	7	1	0	38	60	1	0	0
525	200	2	1	38	60	2	0	0
525	170	0	0	42	60	0	1	0
525	355	1	0	32	60	2	0	0
525	114	0	1	35	60	2	0	0
525	440	0	0	40	60	5	0	0
525	401	1	0	21	60	2	0	0
526	305	0	1	45	60	4	0	0
526	420	1	0	22	60	2	0	0
526	440	1	0	45	60	0	0	0
526	228	0	0	22	60	1	1	0
526	105	1	1	50	60	0	0	0
526	250	0	0	21	60	0	0	0
526	485	0	1	24	60	1	0	0
526	83	2	1	26	60	3	0	0
527	403	1	0	27	60	3	0	0
527	11	2	1	50	60	5	1	0
527	264	2	0	42	60	1	0	0
527	158	1	0	24	60	1	0	0
527	187	1	1	43	60	0	0	0
527	410	1	1	29	60	5	0	0
527	202	0	0	34	60	1	0	0
527	400	1	1	29	60	1	0	0
528	178	0	1	25	60	4	1	0
528	419	2	0	40	60	2	0	0
528	401	2	0	21	60	4	0	0
528	146	0	0	31	60	2	0	0
528	26	1	1	45	60	4	0	0
528	45	1	0	37	60	4	0	0
528	120	2	0	21	60	3	0	0
528	342	1	0	34	60	2	1	0
529	12	1	0	27	60	4	0	0
529	348	0	0	41	60	2	0	0
529	137	1	0	42	60	5	0	0
529	208	2	0	20	60	5	0	0
529	403	1	1	28	60	0	0	0
529	359	1	1	47	60	4	1	0
529	134	2	0	47	60	2	0	0
529	241	2	0	24	60	2	0	0
530	466	2	1	50	60	4	0	0
530	35	0	0	50	60	1	0	0
530	41	0	0	36	60	1	1	0
530	325	2	0	38	60	1	0	0
530	183	2	1	47	60	1	0	0
530	383	0	0	24	60	5	0	0
530	311	0	0	43	60	5	0	0
530	387	2	1	31	60	1	0	0
531	410	0	1	23	60	1	0	0
531	274	1	0	21	60	1	0	0
531	203	1	1	24	60	5	0	0
531	237	2	1	35	60	0	0	0
531	296	2	1	37	60	0	0	0
531	137	2	0	31	60	4	1	0
531	140	2	1	23	60	1	0	0
531	91	1	0	42	60	4	0	0
532	259	2	0	30	60	4	0	0
532	92	2	1	34	60	3	0	0
532	332	0	0	49	60	2	0	0
532	236	0	0	20	60	4	1	0
532	292	1	1	33	60	2	0	0
532	354	0	1	29	60	1	0	0
532	407	1	0	21	60	3	0	0
532	26	0	0	43	60	2	0	0
533	348	0	1	38	60	3	0	0
533	369	2	1	42	60	0	0	0
533	1	1	1	32	60	3	0	0
533	296	0	0	31	60	1	1	0
533	60	2	1	29	60	5	0	0
533	342	0	0	39	60	2	0	0
533	321	0	0	45	60	2	0	0
533	35	1	0	35	60	5	0	0
534	452	0	0	20	60	1	1	0
534	395	0	0	33	60	1	0	0
534	238	2	1	30	60	5	0	0
534	162	2	1	35	60	4	0	0
534	358	0	0	49	60	2	0	0
534	94	2	0	49	60	0	1	0
534	430	2	1	26	60	0	0	0
534	131	2	0	26	60	0	1	0
535	30	0	1	42	60	2	0	0
535	453	0	1	45	60	5	0	0
535	331	0	0	31	60	0	1	0
535	422	2	1	39	60	1	1	0
535	208	1	1	22	60	1	0	0
535	189	1	1	37	60	0	0	0
535	33	2	0	22	60	3	0	0
535	333	0	1	26	60	5	0	0
536	232	1	0	35	60	3	0	0
536	402	1	0	43	60	3	0	0
536	165	0	1	24	60	3	0	0
536	476	0	0	45	60	1	0	0
536	59	1	0	30	60	4	1	0
536	444	2	0	34	60	4	1	0
536	382	2	0	44	60	3	0	0
536	197	1	0	31	60	3	0	0
537	151	2	1	46	60	1	1	0
537	219	1	1	27	60	4	0	0
537	422	1	1	42	60	1	0	0
537	359	1	0	26	60	4	0	0
537	59	1	1	21	60	2	0	0
537	183	1	1	40	60	0	0	0
537	358	1	1	34	60	2	1	0
537	472	0	1	36	60	2	1	0
538	313	1	0	20	60	3	0	0
538	112	1	0	30	60	3	0	0
538	459	2	1	26	60	5	0	0
538	208	0	0	27	60	0	0	0
538	324	0	1	38	60	3	0	0
538	155	0	0	20	60	2	0	0
538	145	1	1	32	60	5	1	0
538	65	2	1	30	60	3	0	0
539	113	1	0	47	60	1	1	0
539	64	0	1	39	60	3	0	0
539	494	1	0	20	60	3	1	0
539	430	0	1	32	60	5	0	0
539	155	2	0	30	60	2	0	0
539	405	1	1	31	60	5	0	0
539	417	0	1	29	60	1	1	0
539	348	1	1	38	60	2	0	0
540	269	2	0	46	60	2	0	0
540	247	1	1	37	60	4	0	0
540	350	2	1	49	60	4	0	0
540	354	2	0	24	60	1	0	0
540	76	1	1	50	60	4	0	0
540	382	1	1	36	60	2	1	0
540	458	0	0	20	60	2	0	0
540	398	2	0	27	60	4	1	0
541	74	2	1	49	60	1	0	0
541	438	1	1	29	60	5	0	0
541	220	2	1	28	60	4	0	0
541	327	0	1	35	60	2	1	0
541	169	2	0	48	60	4	0	0
541	59	0	0	28	60	5	1	0
541	206	2	0	40	60	2	0	0
541	423	1	0	48	60	5	0	0
542	437	0	0	46	60	0	0	0
542	166	1	0	39	60	4	0	0
542	6	1	1	38	60	0	0	0
542	272	1	1	40	60	5	0	0
542	152	1	0	29	60	0	1	0
542	383	1	0	32	60	4	0	0
542	195	1	1	24	60	4	1	0
542	125	2	1	45	60	4	0	0
543	144	1	1	29	60	1	0	0
543	376	2	0	44	60	5	0	0
543	447	0	0	41	60	4	0	0
543	308	1	0	31	60	0	0	0
543	160	1	1	20	60	4	0	0
543	455	0	0	22	60	5	1	0
543	162	1	1	46	60	5	1	0
543	489	2	1	29	60	5	0	0
544	54	0	0	39	60	1	1	0
544	331	1	1	49	60	3	1	0
544	199	2	1	33	60	5	0	0
544	283	0	0	47	60	3	0	0
544	214	1	1	50	60	0	0	0
544	367	1	0	22	60	5	0	0
544	19	2	1	32	60	2	0	0
544	33	0	1	33	60	2	1	0
545	390	0	1	41	60	3	1	0
545	403	2	1	31	60	2	1	0
545	36	0	0	20	60	2	1	0
545	51	0	1	32	60	0	0	0
545	58	0	0	44	60	0	1	0
545	465	1	0	36	60	0	0	0
545	434	0	0	38	60	4	0	0
545	233	0	1	46	60	5	0	0
546	179	0	1	26	60	1	1	0
546	100	2	0	33	60	2	1	0
546	74	1	1	49	60	4	0	0
546	127	1	0	40	60	0	0	0
546	469	0	1	25	60	3	1	0
546	447	2	1	30	60	5	0	0
546	105	1	1	37	60	1	0	0
546	165	1	0	36	60	5	1	0
547	454	0	0	48	60	2	1	0
547	378	0	0	31	60	3	1	0
547	458	2	1	41	60	1	0	0
547	474	1	1	33	60	5	0	0
547	52	1	0	43	60	5	0	0
547	247	1	1	35	60	2	0	0
547	493	1	0	41	60	5	0	0
547	335	0	0	26	60	5	1	0
548	440	2	1	26	60	3	0	0
548	484	0	1	23	60	2	0	0
548	355	2	1	29	60	4	0	0
548	1	0	1	26	60	0	0	0
548	176	1	0	49	60	2	0	0
548	133	0	1	23	60	5	0	0
548	387	2	0	23	60	2	0	0
548	190	1	1	31	60	3	0	0
549	329	2	0	35	60	2	0	0
549	70	0	1	42	60	1	0	0
549	450	0	0	39	60	4	1	0
549	415	2	0	20	60	1	0	0
549	191	2	0	36	60	0	0	0
549	192	1	1	27	60	2	0	0
549	56	0	1	36	60	5	0	0
549	6	2	0	44	60	2	0	0
550	242	0	1	33	60	3	0	0
550	248	0	0	29	60	4	1	0
550	216	2	0	35	60	0	0	0
550	40	2	0	39	60	1	0	0
550	436	0	0	34	60	0	0	0
550	362	0	1	30	60	4	0	0
550	452	1	1	34	60	1	1	0
550	211	2	1	24	60	4	0	0
551	227	1	1	32	60	3	0	0
551	7	2	1	29	60	3	0	0
551	380	0	1	20	60	3	1	0
551	15	2	0	50	60	4	0	0
551	302	2	1	25	60	2	1	0
551	60	1	0	43	60	1	0	0
551	381	1	0	50	60	3	0	0
551	273	0	1	49	60	2	0	0
552	457	2	1	41	60	4	0	0
552	423	0	0	27	60	0	0	0
552	281	2	1	34	60	2	0	0
552	455	0	1	21	60	1	0	0
552	89	0	0	42	60	4	0	0
552	207	0	0	25	60	1	1	0
552	41	1	0	35	60	5	0	0
552	61	0	0	48	60	3	0	0
553	68	0	0	26	60	0	0	0
553	273	1	1	45	60	1	1	0
553	277	0	1	42	60	3	0	0
553	319	1	1	34	60	1	0	0
553	354	2	0	26	60	2	0	0
553	282	2	1	29	60	0	0	0
553	129	1	1	37	60	3	0	0
553	380	1	0	49	60	5	0	0
554	251	0	1	27	60	2	0	0
554	454	2	0	28	60	1	0	0
554	216	1	1	46	60	2	1	0
554	335	1	0	31	60	2	0	0
554	207	1	0	45	60	4	1	0
554	483	1	1	39	60	2	0	0
554	378	0	0	25	60	2	0	0
554	10	1	0	23	60	0	0	0
555	146	1	1	36	60	1	0	0
555	255	1	1	37	60	1	0	0
555	345	1	1	29	60	5	0	0
555	300	0	1	40	60	1	0	0
555	1	2	1	38	60	4	0	0
555	292	2	0	48	60	1	0	0
555	287	1	0	23	60	3	0	0
555	210	2	0	34	60	2	0	0
556	276	1	1	43	60	1	0	0
556	340	1	1	33	60	0	1	0
556	2	1	0	20	60	5	0	0
556	53	2	0	27	60	2	0	0
556	33	1	1	45	60	1	1	0
556	35	2	1	23	60	0	0	0
556	181	1	0	36	60	2	1	0
556	315	2	1	26	60	4	0	0
557	250	1	1	48	60	4	0	0
557	132	2	0	23	60	0	0	0
557	362	2	0	29	60	4	0	0
557	53	1	0	24	60	3	0	0
557	432	2	1	38	60	2	1	0
557	388	1	1	46	60	2	1	0
557	370	2	0	34	60	5	0	0
557	462	2	0	25	60	0	1	0
558	497	2	1	35	60	4	1	0
558	15	2	1	36	60	1	1	0
558	70	2	0	46	60	4	0	0
558	491	0	1	40	60	5	0	0
558	333	1	0	37	60	3	1	0
558	353	1	0	36	60	3	1	0
558	326	2	1	47	60	2	0	0
558	418	1	0	30	60	1	0	0
559	244	0	0	22	60	0	0	0
559	360	0	1	47	60	1	1	0
559	178	2	1	23	60	3	0	0
559	424	1	0	21	60	4	0	0
559	325	0	1	26	60	5	0	0
559	171	2	1	23	60	1	1	0
559	242	0	1	35	60	2	0	0
559	105	0	1	45	60	0	0	0
560	197	1	1	33	60	0	0	0
560	121	0	1	47	60	3	0	0
560	75	1	1	29	60	1	0	0
560	323	1	1	22	60	4	0	0
560	371	1	0	28	60	2	1	0
560	441	0	1	36	60	0	0	0
560	494	1	1	27	60	4	0	0
560	399	1	1	40	60	0	0	0
561	243	0	0	33	60	3	0	0
561	362	0	1	49	60	1	0	0
561	285	1	0	35	60	2	0	0
561	313	1	1	39	60	5	0	0
561	439	2	0	41	60	1	0	0
561	56	1	1	50	60	0	0	0
561	476	2	1	29	60	5	0	0
561	175	1	0	48	60	4	0	0
562	31	1	1	44	60	3	1	0
562	419	0	1	40	60	5	1	0
562	80	0	0	29	60	2	1	0
562	63	0	1	31	60	4	0	0
562	347	0	1	37	60	1	0	0
562	248	0	1	33	60	5	0	0
562	175	2	0	34	60	3	1	0
562	186	2	0	42	60	4	1	0
563	463	1	0	30	60	1	1	0
563	361	2	0	32	60	3	0	0
563	62	2	0	32	60	4	0	0
563	472	0	1	37	60	2	1	0
563	423	2	0	41	60	5	1	0
563	482	0	0	40	60	0	0	0
563	431	0	0	25	60	0	0	0
563	166	1	1	22	60	3	0	0
564	288	0	0	46	60	5	0	0
564	145	1	1	24	60	5	0	0
564	244	1	0	48	60	4	1	0
564	85	1	1	30	60	1	0	0
564	242	2	1	44	60	5	1	0
564	398	0	1	32	60	4	1	0
564	162	2	0	26	60	1	0	0
564	117	2	0	29	60	0	1	0
565	264	0	1	20	60	5	1	0
565	178	0	0	37	60	3	0	0
565	16	1	0	46	60	4	1	0
565	277	2	0	21	60	0	1	0
565	201	2	0	49	60	5	0	0
565	471	1	1	34	60	0	0	0
565	101	1	0	24	60	3	0	0
565	103	1	0	47	60	4	0	0
566	438	2	1	32	60	3	1	0
566	395	1	0	49	60	2	0	0
566	313	1	1	20	60	2	0	0
566	194	0	1	46	60	5	0	0
566	401	1	1	22	60	5	1	0
566	141	1	0	35	60	5	1	0
566	317	2	0	34	60	2	0	0
566	34	0	1	21	60	1	0	0
567	282	1	1	24	60	2	1	0
567	273	0	0	33	60	5	0	0
567	187	0	0	45	60	2	1	0
567	135	2	0	34	60	2	0	0
567	313	0	0	35	60	2	1	0
567	291	1	1	32	60	2	0	0
567	96	1	0	46	60	1	0	0
567	40	0	0	47	60	3	0	0
568	204	1	1	34	60	1	0	0
568	242	1	0	37	60	5	0	0
568	399	1	0	36	60	3	0	0
568	111	0	1	48	60	2	1	0
568	482	1	1	21	60	0	1	0
568	447	0	0	32	60	5	0	0
568	207	1	0	46	60	5	1	0
568	283	0	1	26	60	3	0	0
569	451	1	0	28	60	5	1	0
569	448	2	1	29	60	5	0	0
569	419	2	0	48	60	4	0	0
569	455	2	1	39	60	5	0	0
569	428	2	0	37	60	3	0	0
569	221	0	1	36	60	2	0	0
569	8	2	0	39	60	5	0	0
569	386	1	0	36	60	4	0	0
570	14	0	1	28	60	0	0	0
570	263	0	1	34	60	3	1	0
570	481	1	1	26	60	5	0	0
570	244	2	1	49	60	1	0	0
570	335	0	0	43	60	5	1	0
570	466	2	1	48	60	1	0	0
570	236	1	0	46	60	2	1	0
570	432	1	1	29	60	5	0	0
571	22	0	0	36	60	2	0	0
571	401	0	0	49	60	0	0	0
571	316	2	1	35	60	5	0	0
571	2	2	1	20	60	0	0	0
571	499	1	1	46	60	0	0	0
571	359	1	1	36	60	3	0	0
571	257	0	0	32	60	1	0	0
571	175	1	0	44	60	4	0	0
572	9	2	1	36	60	1	0	0
572	99	1	1	30	60	4	0	0
572	163	0	1	22	60	2	0	0
572	475	0	1	24	60	1	0	0
572	311	1	1	39	60	3	1	0
572	278	0	0	34	60	0	0	0
572	151	0	0	48	60	0	0	0
572	355	0	0	31	60	0	0	0
573	394	1	1	46	60	1	0	0
573	496	1	1	21	60	3	0	0
573	47	0	1	28	60	3	0	0
573	414	2	1	32	60	2	0	0
573	84	2	0	39	60	2	1	0
573	463	2	1	25	60	2	1	0
573	474	1	0	22	60	1	0	0
573	77	2	1	49	60	5	0	0
574	226	2	1	29	60	0	1	0
574	147	2	0	20	60	3	0	0
574	84	2	1	38	60	2	0	0
574	444	1	1	35	60	3	0	0
574	48	1	1	29	60	2	0	0
574	197	0	0	22	60	5	0	0
574	20	0	0	39	60	2	0	0
574	92	0	1	36	60	1	1	0
575	424	2	0	37	60	1	0	0
575	135	0	0	48	60	5	0	0
575	203	2	1	21	60	2	0	0
575	50	1	1	32	60	3	1	0
575	186	1	1	47	60	3	0	0
575	111	2	1	33	60	4	0	0
575	438	0	1	40	60	4	0	0
575	81	0	1	37	60	2	0	0
576	246	1	1	35	60	3	0	0
576	67	2	1	49	60	5	1	0
576	252	0	0	21	60	5	1	0
576	36	0	1	29	60	4	0	0
576	325	1	1	42	60	2	1	0
576	128	0	0	38	60	5	0	0
576	264	1	1	32	60	2	1	0
576	112	2	1	42	60	5	0	0
577	187	1	1	42	60	3	0	0
577	419	0	0	48	60	1	0	0
577	171	2	1	41	60	1	0	0
577	240	1	0	31	60	2	1	0
577	249	2	1	43	60	1	0	0
577	474	0	0	49	60	1	0	0
577	399	0	1	50	60	2	0	0
577	378	2	0	36	60	5	0	0
578	256	2	0	34	60	1	0	0
578	55	2	0	30	60	5	0	0
578	49	2	0	41	60	3	1	0
578	455	1	0	22	60	3	0	0
578	490	2	1	39	60	5	1	0
578	211	2	1	31	60	4	0	0
578	204	2	1	30	60	1	0	0
578	228	1	0	20	60	2	1	0
579	258	1	0	41	60	4	0	0
579	250	2	1	35	60	5	1	0
579	450	0	1	38	60	4	0	0
579	27	2	0	30	60	5	0	0
579	439	2	1	42	60	4	0	0
579	254	0	1	45	60	0	1	0
579	123	2	0	44	60	1	0	0
579	57	2	0	22	60	1	0	0
580	256	1	1	20	60	4	1	0
580	336	0	0	45	60	5	1	0
580	100	2	0	24	60	2	0	0
580	298	1	0	42	60	5	0	0
580	136	1	1	45	60	5	0	0
580	42	2	1	45	60	0	0	0
580	376	1	1	44	60	5	0	0
580	233	1	1	41	60	1	0	0
581	174	1	0	50	60	3	0	0
581	247	0	0	24	60	0	0	0
581	474	0	0	31	60	5	0	0
581	443	0	1	38	60	5	0	0
581	81	2	1	29	60	4	0	0
581	389	0	0	47	60	0	0	0
581	405	0	1	38	60	2	0	0
581	107	1	0	33	60	0	0	0
582	10	2	0	49	60	4	0	0
582	485	2	0	48	60	0	0	0
582	353	2	0	29	60	3	0	0
582	39	2	0	28	60	1	0	0
582	389	0	1	48	60	3	0	0
582	256	0	1	41	60	4	1	0
582	147	1	0	44	60	0	0	0
582	290	2	1	20	60	0	0	0
583	266	0	0	39	60	5	0	0
583	495	1	0	30	60	5	0	0
583	408	2	1	48	60	4	0	0
583	17	2	1	21	60	3	0	0
583	405	2	0	40	60	2	1	0
583	196	1	0	27	60	5	1	0
583	456	0	0	20	60	0	0	0
583	493	2	1	42	60	4	0	0
584	103	1	0	35	60	1	0	0
584	163	1	1	26	60	2	1	0
584	369	2	0	21	60	4	0	0
584	242	1	1	45	60	1	0	0
584	37	1	1	21	60	4	0	0
584	415	2	1	25	60	2	0	0
584	481	2	1	30	60	3	0	0
584	88	0	0	28	60	1	0	0
585	410	0	0	29	60	0	0	0
585	443	2	0	27	60	0	1	0
585	52	2	0	22	60	0	0	0
585	13	2	0	39	60	5	0	0
585	201	2	0	28	60	5	0	0
585	108	1	1	46	60	1	0	0
585	27	1	1	22	60	2	1	0
585	375	1	0	39	60	5	1	0
586	212	0	0	46	60	2	0	0
586	52	1	0	38	60	0	1	0
586	432	0	1	30	60	1	0	0
586	300	0	1	30	60	3	0	0
586	481	2	1	33	60	3	0	0
586	344	1	0	26	60	5	1	0
586	477	2	0	42	60	4	1	0
586	191	1	0	35	60	2	0	0
587	264	1	1	20	60	3	0	0
587	398	2	0	50	60	2	0	0
587	424	2	1	28	60	4	0	0
587	411	0	1	29	60	3	1	0
587	114	2	0	25	60	4	0	0
587	233	0	0	39	60	2	0	0
587	413	0	0	31	60	5	0	0
587	267	0	0	38	60	1	0	0
588	45	0	0	26	60	0	0	0
588	81	1	0	47	60	5	0	0
588	106	2	1	36	60	5	0	0
588	320	1	1	27	60	0	0	0
588	133	2	1	29	60	2	0	0
588	322	0	1	36	60	0	0	0
588	58	0	1	36	60	5	0	0
588	436	1	1	44	60	0	0	0
589	205	2	0	29	60	5	1	0
589	130	2	1	50	60	5	0	0
589	453	0	0	49	60	5	1	0
589	392	2	1	20	60	1	0	0
589	66	1	0	49	60	4	1	0
589	338	1	0	37	60	3	0	0
589	351	2	1	31	60	0	1	0
589	322	0	1	40	60	4	0	0
590	75	2	0	31	60	2	0	0
590	144	0	1	35	60	4	0	0
590	61	1	0	47	60	3	0	0
590	229	1	0	34	60	1	0	0
590	310	0	1	31	60	2	0	0
590	147	0	0	36	60	5	0	0
590	194	1	1	50	60	2	1	0
590	431	2	0	23	60	1	0	0
591	345	0	0	45	60	1	0	0
591	279	1	0	24	60	5	0	0
591	321	2	1	26	60	2	0	0
591	335	2	1	41	60	0	0	0
591	281	0	1	46	60	4	1	0
591	268	2	0	43	60	5	0	0
591	392	0	0	36	60	0	1	0
591	179	2	1	45	60	5	0	0
592	419	0	0	27	60	3	1	0
592	457	1	1	33	60	1	0	0
592	127	0	1	25	60	2	0	0
592	318	0	0	24	60	1	0	0
592	116	2	1	27	60	5	1	0
592	115	1	0	32	60	1	0	0
592	252	1	0	29	60	1	0	0
592	270	1	1	33	60	3	0	0
593	326	2	1	37	60	5	0	0
593	128	0	1	28	60	2	0	0
593	143	2	1	23	60	0	0	0
593	218	0	0	46	60	2	0	0
593	174	1	1	27	60	0	0	0
593	346	0	0	47	60	4	0	0
593	222	2	1	20	60	0	1	0
593	23	1	0	30	60	3	0	0
594	142	0	1	29	60	2	0	0
594	144	2	0	32	60	0	0	0
594	246	2	1	49	60	4	1	0
594	315	1	0	32	60	3	0	0
594	382	0	1	23	60	4	0	0
594	74	2	1	32	60	4	1	0
594	42	2	0	28	60	0	0	0
594	283	1	1	41	60	5	0	0
595	366	2	0	29	60	3	0	0
595	3	2	0	45	60	5	0	0
595	406	1	0	25	60	2	1	0
595	477	2	0	32	60	4	0	0
595	175	0	1	25	60	1	0	0
595	391	2	0	22	60	4	0	0
595	248	1	1	29	60	4	0	0
595	52	1	1	23	60	2	0	0
596	355	1	0	41	60	3	1	0
596	462	0	1	34	60	4	0	0
596	385	1	1	21	60	0	0	0
596	54	1	0	20	60	3	0	0
596	407	2	0	22	60	3	0	0
596	337	0	1	27	60	2	0	0
596	378	1	0	47	60	4	0	0
596	2	1	0	20	60	0	0	0
597	401	0	0	24	60	1	1	0
597	171	2	1	40	60	2	0	0
597	383	0	0	25	60	5	0	0
597	298	0	0	20	60	4	1	0
597	427	0	0	47	60	5	0	0
597	43	2	1	42	60	5	0	0
597	224	1	0	33	60	4	0	0
597	454	1	0	29	60	0	0	0
598	40	1	0	49	60	2	0	0
598	102	1	0	48	60	4	0	0
598	209	1	0	38	60	4	0	0
598	83	0	0	26	60	1	0	0
598	86	1	0	43	60	2	1	0
598	134	1	0	37	60	4	0	0
598	162	0	1	21	60	4	0	0
598	472	2	0	26	60	5	0	0
599	34	1	1	33	60	0	0	0
599	468	2	0	22	60	5	1	0
599	325	1	0	25	60	4	1	0
599	275	2	0	38	60	1	1	0
599	207	2	1	39	60	1	0	0
599	453	2	0	28	60	4	0	0
599	48	0	0	48	60	3	0	0
599	189	0	0	43	60	1	0	0
600	430	1	1	32	60	2	1	0
600	394	2	0	35	60	2	0	0
600	111	1	0	32	60	1	0	0
600	97	1	0	30	60	5	1	0
600	363	0	0	45	60	0	0	0
600	406	1	1	30	60	4	1	0
600	77	1	0	29	60	3	0	0
600	96	1	1	37	60	3	0	0
601	23	1	1	48	60	4	0	0
601	21	1	0	40	60	4	0	0
601	79	1	1	34	60	2	0	0
601	109	2	0	20	60	5	1	0
601	341	0	1	50	60	4	0	0
601	326	1	0	23	60	4	1	0
601	223	1	0	23	60	3	0	0
601	233	2	0	40	60	5	0	0
602	233	0	0	42	60	3	0	0
602	411	0	1	47	60	1	1	0
602	163	0	1	38	60	0	0	0
602	74	1	0	41	60	3	0	0
602	473	1	0	28	60	4	0	0
602	147	0	0	33	60	3	0	0
602	18	2	0	47	60	2	0	0
602	336	2	1	49	60	2	0	0
603	84	1	1	27	60	3	0	0
603	250	0	1	24	60	0	0	0
603	329	0	0	34	60	4	1	0
603	367	0	0	30	60	1	1	0
603	294	1	0	30	60	1	0	0
603	210	1	1	34	60	2	0	0
603	95	0	1	27	60	3	0	0
603	273	1	0	42	60	3	0	0
604	464	2	1	34	60	5	0	0
604	305	2	1	32	60	1	0	0
604	80	1	1	27	60	2	1	0
604	214	2	0	23	60	2	0	0
604	131	0	1	32	60	4	0	0
604	177	0	1	50	60	1	0	0
604	180	2	1	24	60	1	0	0
604	220	0	1	45	60	3	0	0
605	25	0	1	48	60	3	0	0
605	45	0	1	20	60	2	0	0
605	135	2	0	21	60	4	0	0
605	385	0	1	43	60	1	0	0
605	97	1	1	37	60	0	0	0
605	462	2	0	43	60	1	0	0
605	65	1	1	49	60	0	0	0
605	100	2	0	22	60	5	0	0
606	114	2	1	22	60	4	1	0
606	496	2	0	25	60	5	1	0
606	424	0	0	50	60	3	1	0
606	214	1	0	22	60	3	0	0
606	475	1	0	20	60	3	1	0
606	153	0	1	34	60	4	0	0
606	65	0	1	50	60	5	1	0
606	252	0	0	20	60	0	0	0
607	496	0	0	25	60	5	1	0
607	225	1	1	31	60	3	1	0
607	352	2	0	50	60	4	1	0
607	193	1	1	50	60	0	0	0
607	413	0	1	48	60	0	0	0
607	134	0	1	34	60	1	1	0
607	224	0	1	25	60	3	0	0
607	136	1	0	48	60	0	1	0
608	61	1	0	47	60	5	0	0
608	491	2	1	23	60	1	0	0
608	100	1	0	27	60	0	0	0
608	213	2	0	29	60	0	0	0
608	310	0	0	22	60	0	1	0
608	112	2	0	22	60	4	0	0
608	29	1	1	34	60	5	0	0
608	399	1	0	33	60	5	0	0
609	310	0	1	50	60	0	0	0
609	115	1	0	32	60	5	0	0
609	130	2	0	34	60	3	1	0
609	344	1	1	32	60	5	1	0
609	266	1	1	34	60	4	0	0
609	264	0	0	31	60	0	1	0
609	392	1	1	35	60	3	1	0
609	13	2	1	31	60	0	0	0
610	326	2	1	31	60	5	0	0
610	405	0	0	35	60	5	0	0
610	295	0	1	44	60	4	1	0
610	484	2	1	47	60	1	0	0
610	322	2	0	24	60	5	1	0
610	46	0	0	32	60	4	0	0
610	383	2	1	42	60	1	0	0
610	14	1	1	26	60	1	1	0
611	46	0	0	33	60	0	0	0
611	307	2	1	23	60	0	0	0
611	287	2	0	41	60	1	0	0
611	3	0	0	28	60	5	0	0
611	208	1	1	21	60	3	0	0
611	57	0	0	26	60	1	0	0
611	59	2	1	27	60	3	1	0
611	191	1	1	42	60	4	0	0
612	340	1	1	28	60	2	0	0
612	169	1	1	28	60	4	0	0
612	439	2	1	33	60	3	0	0
612	118	1	0	21	60	0	0	0
612	185	2	0	20	60	3	0	0
612	292	1	0	34	60	4	1	0
612	450	1	0	36	60	2	0	0
612	265	1	0	42	60	2	1	0
613	363	0	1	39	60	5	0	0
613	186	0	0	21	60	2	0	0
613	244	1	0	36	60	2	0	0
613	31	2	0	40	60	0	0	0
613	83	2	0	31	60	3	0	0
613	167	2	0	36	60	2	1	0
613	344	1	1	44	60	3	0	0
613	260	1	0	49	60	2	1	0
614	442	0	0	50	60	0	0	0
614	423	2	1	32	60	3	1	0
614	379	1	1	40	60	3	0	0
614	445	2	1	32	60	5	0	0
614	47	2	0	26	60	5	0	0
614	76	2	1	38	60	1	0	0
614	317	2	0	38	60	3	1	0
614	415	1	1	32	60	3	0	0
615	325	2	0	44	60	1	1	0
615	222	0	0	28	60	5	0	0
615	156	0	0	41	60	4	1	0
615	216	0	0	45	60	3	0	0
615	411	0	1	40	60	5	0	0
615	70	2	0	48	60	1	1	0
615	91	2	1	37	60	3	0	0
615	384	2	1	37	60	1	0	0
616	159	1	1	48	60	1	1	0
616	487	2	0	46	60	4	0	0
616	258	2	0	22	60	3	1	0
616	154	1	0	45	60	1	1	0
616	13	2	0	25	60	0	0	0
616	325	2	1	21	60	4	0	0
616	473	0	1	22	60	3	0	0
616	491	2	1	25	60	2	0	0
617	488	1	0	32	60	5	0	0
617	197	0	0	36	60	1	0	0
617	472	1	0	25	60	5	0	0
617	137	2	0	28	60	0	0	0
617	397	1	0	20	60	4	1	0
617	312	2	0	31	60	5	0	0
617	372	1	0	46	60	4	0	0
617	255	1	1	22	60	5	0	0
618	258	2	1	25	60	3	0	0
618	316	1	0	31	60	4	0	0
618	488	1	0	35	60	1	0	0
618	375	0	1	24	60	2	0	0
618	109	1	1	41	60	5	1	0
618	318	1	0	36	60	3	1	0
618	6	0	1	35	60	0	1	0
618	88	0	0	49	60	2	1	0
619	299	1	0	24	60	3	0	0
619	393	0	1	27	60	1	0	0
619	359	2	1	30	60	0	0	0
619	167	1	1	33	60	1	0	0
619	319	0	0	30	60	1	0	0
619	60	2	0	45	60	5	1	0
619	401	2	1	46	60	1	0	0
619	134	0	0	40	60	5	0	0
620	119	1	0	40	60	1	1	0
620	210	0	0	41	60	4	1	0
620	258	0	1	27	60	5	0	0
620	496	2	0	40	60	1	0	0
620	448	1	1	39	60	2	0	0
620	429	1	0	22	60	0	0	0
620	484	2	0	39	60	0	0	0
620	31	1	1	20	60	2	1	0
621	179	0	0	27	60	2	0	0
621	8	0	0	39	60	4	0	0
621	50	1	1	46	60	0	1	0
621	348	2	1	28	60	0	0	0
621	389	1	1	47	60	2	1	0
621	141	0	0	25	60	2	0	0
621	305	2	0	20	60	1	0	0
621	242	0	1	44	60	3	0	0
622	225	1	0	27	60	3	0	0
622	457	1	0	22	60	1	1	0
622	437	1	1	45	60	2	0	0
622	68	0	0	27	60	0	0	0
622	431	0	0	24	60	4	0	0
622	145	1	0	36	60	0	0	0
622	460	2	0	29	60	2	1	0
622	24	1	1	48	60	3	0	0
623	75	2	1	32	60	5	0	0
623	273	0	0	34	60	1	1	0
623	429	1	0	29	60	0	0	0
623	109	1	0	45	60	0	0	0
623	431	1	0	35	60	4	0	0
623	367	0	1	24	60	0	0	0
623	471	2	1	43	60	2	0	0
623	166	1	0	46	60	0	0	0
624	444	1	1	34	60	1	0	0
624	183	2	0	36	60	0	0	0
624	296	1	0	34	60	3	0	0
624	118	2	1	40	60	1	1	0
624	485	0	1	28	60	4	0	0
624	320	2	1	27	60	5	0	0
624	172	0	0	39	60	1	0	0
624	163	0	1	39	60	0	1	0
625	103	0	0	45	60	1	0	0
625	91	0	1	44	60	4	0	0
625	449	2	0	36	60	2	1	0
625	168	2	1	39	60	1	0	0
625	152	1	0	26	60	4	1	0
625	244	0	0	35	60	4	1	0
625	261	0	1	36	60	0	1	0
625	116	1	0	41	60	1	0	0
626	224	0	1	28	60	3	1	0
626	144	2	0	25	60	5	0	0
626	146	0	1	27	60	1	0	0
626	391	0	1	35	60	1	0	0
626	437	0	0	50	60	4	0	0
626	101	1	1	37	60	2	0	0
626	176	0	1	49	60	4	0	0
626	72	2	0	28	60	3	0	0
627	23	2	0	26	60	1	0	0
627	209	2	1	40	60	4	0	0
627	258	2	0	50	60	1	1	0
627	320	0	1	39	60	4	0	0
627	97	2	1	35	60	1	0	0
627	399	0	1	21	60	0	0	0
627	481	2	0	38	60	3	1	0
627	388	2	1	46	60	2	0	0
628	230	2	0	47	60	2	0	0
628	427	1	0	28	60	2	0	0
628	387	0	0	45	60	1	1	0
628	142	2	1	48	60	3	0	0
628	41	2	0	29	60	5	0	0
628	256	2	0	31	60	0	0	0
628	64	1	1	23	60	2	0	0
628	129	2	1	47	60	0	1	0
629	403	1	0	47	60	1	0	0
629	103	0	0	46	60	4	0	0
629	184	0	1	32	60	5	0	0
629	303	0	0	32	60	5	0	0
629	452	1	0	20	60	2	1	0
629	63	0	1	36	60	5	1	0
629	425	2	0	39	60	4	0	0
629	181	1	0	39	60	5	0	0
630	238	1	1	35	60	4	1	0
630	48	1	1	44	60	5	0	0
630	41	2	1	21	60	2	0	0
630	371	2	0	47	60	3	0	0
630	486	0	0	45	60	3	0	0
630	5	0	0	42	60	1	1	0
630	84	2	1	26	60	5	0	0
630	155	0	1	50	60	1	0	0
631	107	0	1	41	60	4	1	0
631	309	1	1	43	60	1	0	0
631	348	0	0	33	60	1	1	0
631	26	2	0	50	60	2	0	0
631	286	0	1	39	60	0	0	0
631	487	0	0	48	60	1	1	0
631	87	0	1	41	60	0	0	0
631	332	1	1	26	60	4	1	0
632	494	1	1	33	60	1	0	0
632	414	1	1	31	60	2	0	0
632	383	2	1	27	60	0	0	0
632	92	2	1	38	60	3	0	0
632	202	2	0	43	60	0	0	0
632	167	0	0	44	60	3	0	0
632	46	2	1	49	60	1	0	0
632	233	1	0	36	60	3	1	0
633	436	2	1	20	60	5	1	0
633	275	2	0	45	60	3	0	0
633	390	0	0	27	60	4	0	0
633	317	0	0	46	60	4	0	0
633	439	0	0	26	60	4	1	0
633	19	0	0	41	60	3	0	0
633	127	2	1	22	60	5	0	0
633	379	0	1	20	60	0	0	0
634	430	0	0	49	60	3	1	0
634	460	0	1	29	60	4	1	0
634	122	2	1	48	60	0	0	0
634	233	0	1	26	60	0	0	0
634	191	0	0	42	60	1	1	0
634	61	1	0	28	60	4	0	0
634	197	2	0	25	60	3	0	0
634	434	0	0	26	60	4	0	0
635	480	0	0	25	60	1	0	0
635	165	2	0	39	60	0	0	0
635	275	2	0	44	60	5	0	0
635	125	1	0	25	60	4	0	0
635	248	2	1	38	60	3	1	0
635	259	0	0	50	60	3	1	0
635	8	2	0	43	60	2	0	0
635	363	0	1	44	60	5	1	0
636	412	0	1	31	60	4	0	0
636	293	0	0	20	60	4	0	0
636	185	1	1	25	60	3	0	0
636	276	0	1	38	60	3	0	0
636	1	2	0	41	60	5	0	0
636	429	1	1	39	60	2	0	0
636	58	2	0	41	60	4	0	0
636	49	2	0	23	60	1	0	0
637	199	0	0	27	60	0	0	0
637	125	2	0	22	60	4	0	0
637	214	0	1	30	60	1	0	0
637	413	2	1	49	60	1	0	0
637	326	1	0	32	60	3	1	0
637	43	1	1	26	60	0	1	0
637	442	2	1	33	60	2	0	0
637	398	2	0	26	60	0	1	0
638	328	0	1	23	60	0	1	0
638	390	0	1	29	60	1	0	0
638	39	0	0	25	60	2	0	0
638	202	0	0	44	60	2	0	0
638	231	2	1	36	60	1	0	0
638	50	0	0	26	60	0	0	0
638	238	1	1	20	60	2	0	0
638	188	1	1	34	60	4	0	0
639	377	1	0	21	60	0	0	0
639	145	0	0	30	60	4	1	0
639	121	0	1	22	60	0	0	0
639	406	2	1	24	60	4	0	0
639	122	2	0	39	60	3	1	0
639	380	0	0	33	60	1	0	0
639	313	2	1	23	60	1	0	0
639	448	1	1	29	60	2	0	0
640	391	0	1	43	60	1	1	0
640	275	2	1	25	60	1	1	0
640	200	0	1	34	60	1	0	0
640	485	1	0	31	60	0	0	0
640	483	2	1	32	60	3	0	0
640	256	2	1	29	60	0	0	0
640	213	2	1	45	60	4	0	0
640	402	1	1	23	60	0	0	0
641	95	1	0	45	60	1	0	0
641	438	0	1	50	60	4	0	0
641	32	2	1	28	60	1	1	0
641	109	2	0	42	60	5	0	0
641	461	0	0	42	60	3	0	0
641	1	1	1	39	60	0	0	0
641	94	1	1	46	60	4	0	0
641	251	1	0	42	60	3	0	0
642	76	1	0	24	60	0	0	0
642	481	1	0	21	60	4	0	0
642	32	0	0	21	60	0	1	0
642	363	1	1	22	60	3	0	0
642	266	2	1	30	60	3	0	0
642	107	2	0	35	60	5	0	0
642	238	2	1	49	60	4	0	0
642	265	0	1	42	60	0	0	0
643	28	2	1	31	60	1	0	0
643	413	2	1	40	60	3	1	0
643	333	1	1	21	60	0	1	0
643	42	1	0	33	60	2	0	0
643	468	2	1	47	60	1	0	0
643	207	1	0	26	60	3	1	0
643	262	2	1	25	60	4	0	0
643	280	2	1	23	60	3	0	0
644	249	2	0	42	60	4	0	0
644	299	2	0	23	60	0	0	0
644	86	2	1	48	60	0	0	0
644	116	0	1	46	60	2	0	0
644	242	0	1	26	60	4	0	0
644	43	2	0	23	60	3	0	0
644	23	0	1	44	60	3	0	0
644	262	1	1	20	60	2	0	0
645	228	0	1	34	60	4	0	0
645	493	1	0	32	60	1	0	0
645	430	1	1	43	60	2	0	0
645	497	0	1	29	60	3	0	0
645	5	2	0	28	60	1	0	0
645	91	2	1	28	60	5	0	0
645	48	0	1	21	60	1	0	0
645	160	0	1	24	60	4	0	0
646	106	1	0	23	60	0	0	0
646	88	1	0	37	60	3	0	0
646	428	0	0	36	60	3	0	0
646	455	0	1	49	60	4	0	0
646	416	2	1	25	60	3	0	0
646	405	2	0	22	60	4	0	0
646	464	1	1	46	60	5	0	0
646	296	0	0	46	60	2	0	0
647	134	0	1	21	60	0	0	0
647	257	1	1	33	60	2	0	0
647	220	1	0	36	60	0	0	0
647	419	2	0	34	60	0	0	0
647	500	1	0	27	60	0	0	0
647	300	2	1	47	60	1	0	0
647	115	2	1	50	60	1	1	0
647	491	2	0	21	60	1	1	0
648	22	0	0	45	60	0	0	0
648	58	0	1	50	60	3	0	0
648	345	2	0	37	60	1	1	0
648	170	2	1	37	60	4	1	0
648	154	0	1	31	60	0	0	0
648	157	1	1	43	60	2	0	0
648	500	0	0	31	60	5	0	0
648	320	0	1	38	60	3	0	0
649	299	1	1	21	60	2	0	0
649	308	1	1	23	60	5	1	0
649	199	2	1	36	60	2	0	0
649	54	1	1	43	60	1	1	0
649	163	1	1	44	60	3	0	0
649	179	2	0	43	60	1	0	0
649	430	2	0	46	60	2	0	0
649	306	1	0	30	60	3	0	0
650	341	0	1	27	60	5	1	0
650	450	2	1	47	60	4	0	0
650	32	2	1	33	60	4	0	0
650	214	2	0	38	60	0	1	0
650	57	1	0	47	60	5	0	0
650	36	1	1	33	60	5	0	0
650	40	1	0	29	60	1	0	0
650	467	2	0	36	60	2	1	0
651	318	1	1	34	60	5	0	0
651	495	2	1	34	60	3	1	0
651	453	2	1	29	60	0	0	0
651	305	2	0	20	60	1	0	0
651	489	2	1	34	60	2	1	0
651	237	0	1	23	60	4	0	0
651	149	2	1	39	60	2	0	0
651	49	0	1	40	60	4	0	0
652	295	1	0	37	60	0	1	0
652	121	1	0	31	60	2	0	0
652	39	0	1	25	60	5	1	0
652	181	1	1	40	60	3	1	0
652	319	1	1	27	60	3	1	0
652	368	2	1	29	60	1	0	0
652	400	2	1	35	60	1	0	0
652	242	2	0	27	60	5	0	0
653	76	0	0	39	60	2	0	0
653	147	1	1	20	60	4	0	0
653	84	2	1	50	60	5	0	0
653	471	1	1	40	60	3	1	0
653	273	0	1	43	60	0	0	0
653	18	2	1	20	60	1	0	0
653	371	0	0	44	60	1	1	0
653	82	1	1	49	60	0	1	0
654	230	1	0	47	60	4	0	0
654	378	0	0	49	60	4	0	0
654	255	0	1	23	60	5	0	0
654	96	1	1	42	60	1	0	0
654	417	2	1	28	60	0	1	0
654	241	2	0	33	60	3	0	0
654	7	1	0	39	60	1	0	0
654	180	1	0	27	60	3	0	0
655	452	1	0	44	60	4	0	0
655	1	0	0	27	60	3	0	0
655	330	2	1	26	60	3	0	0
655	430	0	0	23	60	2	0	0
655	272	1	0	20	60	3	1	0
655	101	0	0	50	60	1	0	0
655	419	2	1	36	60	5	0	0
655	135	1	0	28	60	5	0	0
656	167	2	1	42	60	5	0	0
656	130	1	1	45	60	2	0	0
656	371	0	0	49	60	3	0	0
656	398	0	0	20	60	2	0	0
656	463	0	1	42	60	2	0	0
656	79	0	1	29	60	5	0	0
656	444	1	0	22	60	2	1	0
656	77	0	1	26	60	5	1	0
657	351	1	0	50	60	4	0	0
657	292	1	0	40	60	2	0	0
657	461	2	0	40	60	0	1	0
657	365	1	1	28	60	0	1	0
657	22	1	0	50	60	1	0	0
657	427	1	0	45	60	2	0	0
657	422	2	1	44	60	4	0	0
657	178	0	0	40	60	4	0	0
658	115	1	0	45	60	2	0	0
658	158	1	0	40	60	2	0	0
658	86	2	1	36	60	2	1	0
658	472	1	1	25	60	3	0	0
658	175	1	1	33	60	2	0	0
658	422	1	0	38	60	1	0	0
658	84	1	1	24	60	0	1	0
658	22	2	0	44	60	5	1	0
659	266	1	1	34	60	4	0	0
659	5	2	1	25	60	2	0	0
659	500	1	1	47	60	5	0	0
659	270	0	0	28	60	5	1	0
659	391	0	1	32	60	0	0	0
659	414	2	1	39	60	2	1	0
659	181	2	0	33	60	4	0	0
659	196	2	1	35	60	4	0	0
660	440	0	0	33	60	5	0	0
660	228	0	0	37	60	5	0	0
660	446	0	1	22	60	5	1	0
660	283	0	1	46	60	2	1	0
660	226	0	1	40	60	2	0	0
660	48	2	0	47	60	0	1	0
660	22	1	1	30	60	5	1	0
660	16	2	0	20	60	2	0	0
661	159	1	1	20	60	2	1	0
661	247	1	1	27	60	3	0	0
661	498	2	0	23	60	5	1	0
661	398	1	1	32	60	5	1	0
661	98	2	1	49	60	2	1	0
661	203	0	0	25	60	1	1	0
661	445	0	1	24	60	2	1	0
661	312	0	0	21	60	1	1	0
662	434	0	1	28	60	2	1	0
662	79	2	1	21	60	1	0	0
662	308	2	0	29	60	0	0	0
662	315	1	0	50	60	3	0	0
662	478	1	1	39	60	3	0	0
662	80	2	0	20	60	4	1	0
662	197	1	0	42	60	0	1	0
662	448	0	0	36	60	1	1	0
663	371	0	0	45	60	2	1	0
663	422	0	1	28	60	1	0	0
663	121	0	1	34	60	5	0	0
663	155	1	0	36	60	5	0	0
663	56	1	1	34	60	3	0	0
663	50	1	1	23	60	2	0	0
663	432	0	1	44	60	4	0	0
663	455	2	1	48	60	2	0	0
664	321	0	0	31	60	4	0	0
664	329	2	1	46	60	5	0	0
664	290	1	1	32	60	1	0	0
664	490	1	0	47	60	3	1	0
664	6	1	0	40	60	5	0	0
664	67	0	1	33	60	4	0	0
664	326	0	1	40	60	2	0	0
664	89	1	1	26	60	4	1	0
665	119	2	0	20	60	2	1	0
665	195	0	1	24	60	1	0	0
665	437	2	1	32	60	3	0	0
665	453	1	0	39	60	2	0	0
665	417	0	1	40	60	0	0	0
665	273	0	1	47	60	1	1	0
665	145	1	0	34	60	3	0	0
665	277	1	1	22	60	4	0	0
666	100	0	1	44	60	0	0	0
666	55	2	0	28	60	2	0	0
666	59	0	1	44	60	3	0	0
666	97	1	1	46	60	5	0	0
666	27	2	0	27	60	2	0	0
666	168	1	0	36	60	2	0	0
666	399	0	1	29	60	4	1	0
666	417	1	0	22	60	4	0	0
667	45	2	1	48	60	4	0	0
667	294	1	0	30	60	4	0	0
667	291	1	1	24	60	3	0	0
667	486	2	0	38	60	2	1	0
667	305	2	1	34	60	0	0	0
667	226	2	0	45	60	2	0	0
667	65	0	1	32	60	5	0	0
667	10	1	0	40	60	5	1	0
668	141	1	0	49	60	0	1	0
668	391	1	1	35	60	4	1	0
668	451	1	1	35	60	1	0	0
668	94	2	0	32	60	1	0	0
668	259	0	1	36	60	5	0	0
668	288	0	1	39	60	2	0	0
668	1	0	0	34	60	2	0	0
668	60	2	1	29	60	0	0	0
669	191	1	0	33	60	4	0	0
669	427	0	0	28	60	0	1	0
669	115	0	1	27	60	1	0	0
669	151	0	0	45	60	1	1	0
669	16	1	1	30	60	2	0	0
669	12	2	0	36	60	4	0	0
669	206	2	1	29	60	5	0	0
669	245	1	0	25	60	5	0	0
670	133	0	0	32	60	3	0	0
670	255	0	0	21	60	5	0	0
670	307	1	1	37	60	2	0	0
670	311	0	1	48	60	0	0	0
670	140	2	0	40	60	0	1	0
670	100	1	1	21	60	3	0	0
670	362	2	0	22	60	2	0	0
670	357	1	0	39	60	3	1	0
671	75	0	1	20	60	0	0	0
671	358	2	1	40	60	1	0	0
671	227	0	0	35	60	2	0	0
671	270	2	1	21	60	1	0	0
671	156	2	0	33	60	4	1	0
671	399	0	0	41	60	2	0	0
671	221	0	0	47	60	0	0	0
671	78	0	0	40	60	2	0	0
672	429	2	1	46	60	4	1	0
672	199	2	1	22	60	2	0	0
672	10	1	0	50	60	1	1	0
672	331	0	0	20	60	2	0	0
672	410	2	1	33	60	5	1	0
672	160	0	0	42	60	4	0	0
672	301	1	0	47	60	5	1	0
672	312	1	0	24	60	5	0	0
673	215	1	0	22	60	1	0	0
673	54	0	0	35	60	3	0	0
673	87	0	0	27	60	4	1	0
673	163	2	1	49	60	5	1	0
673	380	0	0	31	60	4	0	0
673	109	1	1	35	60	0	0	0
673	65	2	1	41	60	3	0	0
673	417	2	0	27	60	1	0	0
674	102	2	1	46	60	4	0	0
674	204	2	0	49	60	3	0	0
674	295	0	0	47	60	0	0	0
674	54	0	1	26	60	5	0	0
674	4	2	0	37	60	2	0	0
674	277	1	1	32	60	4	0	0
674	103	0	1	27	60	2	0	0
674	242	1	0	33	60	1	1	0
675	103	2	0	28	60	5	1	0
675	201	0	0	33	60	4	0	0
675	395	0	1	35	60	1	0	0
675	460	2	1	40	60	1	0	0
675	197	2	0	48	60	0	1	0
675	86	2	1	26	60	4	1	0
675	261	1	1	35	60	2	0	0
675	419	1	0	23	60	1	0	0
676	350	0	1	49	60	0	1	0
676	152	1	1	36	60	0	0	0
676	253	1	1	26	60	1	0	0
676	241	1	1	27	60	1	0	0
676	33	0	1	22	60	0	1	0
676	101	0	0	29	60	2	0	0
676	411	0	0	45	60	5	1	0
676	273	2	0	20	60	1	1	0
677	228	1	1	38	60	5	0	0
677	78	2	1	33	60	4	0	0
677	15	1	1	30	60	2	0	0
677	375	0	0	36	60	4	1	0
677	294	1	0	45	60	1	0	0
677	14	2	0	36	60	1	0	0
677	55	1	1	31	60	1	0	0
677	422	1	0	43	60	0	0	0
678	92	0	0	31	60	1	0	0
678	83	0	0	25	60	1	0	0
678	52	1	0	35	60	3	0	0
678	283	2	0	32	60	1	0	0
678	51	2	0	34	60	4	0	0
678	229	2	1	23	60	5	0	0
678	243	1	1	31	60	2	1	0
678	190	2	1	44	60	2	0	0
679	208	1	0	25	60	0	0	0
679	368	0	0	47	60	4	0	0
679	342	0	0	49	60	3	0	0
679	219	2	0	41	60	4	0	0
679	497	0	1	22	60	0	0	0
679	339	0	1	40	60	4	0	0
679	303	1	0	43	60	4	0	0
679	313	2	1	26	60	3	0	0
680	209	0	0	40	60	4	1	0
680	69	2	1	31	60	4	1	0
680	343	1	1	49	60	3	0	0
680	149	2	1	26	60	4	0	0
680	96	1	0	49	60	3	0	0
680	473	1	0	32	60	5	0	0
680	237	2	0	40	60	4	0	0
680	483	2	1	25	60	3	0	0
681	28	2	1	34	60	3	0	0
681	346	2	1	20	60	0	0	0
681	365	2	1	27	60	1	0	0
681	66	0	1	35	60	3	1	0
681	164	0	0	20	60	3	0	0
681	319	2	1	22	60	2	1	0
681	165	2	1	38	60	0	0	0
681	192	1	0	20	60	5	0	0
682	211	2	0	43	60	5	0	0
682	394	1	1	25	60	0	0	0
682	482	0	0	38	60	1	0	0
682	78	0	1	42	60	4	0	0
682	59	0	1	49	60	4	1	0
682	265	2	1	38	60	0	0	0
682	170	0	0	42	60	0	0	0
682	450	1	1	30	60	4	0	0
683	232	0	1	40	60	0	0	0
683	403	2	1	22	60	5	1	0
683	282	2	0	26	60	4	1	0
683	393	0	0	47	60	1	0	0
683	239	1	0	45	60	3	0	0
683	60	1	1	35	60	4	0	0
683	286	2	0	28	60	5	0	0
683	123	2	0	48	60	4	0	0
684	121	2	0	23	60	3	1	0
684	152	1	0	21	60	4	0	0
684	288	2	0	25	60	3	0	0
684	101	1	0	30	60	4	0	0
684	360	2	0	23	60	3	0	0
684	257	1	1	37	60	2	1	0
684	187	0	1	39	60	4	1	0
684	251	2	0	35	60	2	1	0
685	431	2	1	44	60	3	0	0
685	258	2	1	26	60	1	0	0
685	60	1	0	38	60	4	1	0
685	352	0	0	50	60	0	0	0
685	165	0	0	32	60	1	0	0
685	345	1	0	24	60	2	0	0
685	227	0	1	44	60	3	0	0
685	272	1	1	45	60	0	0	0
686	66	0	0	22	60	0	0	0
686	438	1	0	37	60	4	0	0
686	2	2	0	23	60	1	0	0
686	35	2	1	28	60	5	1	0
686	80	0	1	29	60	5	0	0
686	175	1	1	21	60	2	1	0
686	162	2	0	46	60	4	0	0
686	244	2	1	31	60	0	1	0
687	135	0	0	29	60	5	1	0
687	67	1	0	34	60	4	0	0
687	469	1	0	50	60	0	0	0
687	239	1	0	28	60	4	0	0
687	31	1	1	35	60	0	1	0
687	366	2	1	44	60	1	0	0
687	373	1	0	37	60	2	0	0
687	477	0	1	42	60	2	0	0
688	97	0	1	37	60	1	0	0
688	469	2	0	21	60	2	0	0
688	35	1	0	29	60	3	0	0
688	412	2	1	38	60	3	0	0
688	115	0	1	36	60	1	0	0
688	105	1	0	48	60	5	0	0
688	401	0	0	44	60	2	1	0
688	378	0	0	49	60	3	1	0
689	290	2	0	28	60	0	1	0
689	58	2	1	29	60	0	0	0
689	418	0	0	24	60	1	0	0
689	306	2	0	45	60	3	1	0
689	156	0	1	36	60	0	1	0
689	443	0	0	40	60	4	1	0
689	148	2	0	42	60	1	0	0
689	13	2	1	40	60	3	0	0
690	282	2	0	37	60	2	0	0
690	53	1	1	27	60	2	1	0
690	460	1	1	48	60	4	0	0
690	126	0	0	44	60	5	0	0
690	161	1	0	37	60	3	1	0
690	75	0	0	31	60	2	1	0
690	37	0	1	27	60	1	0	0
690	64	1	1	48	60	2	1	0
691	449	0	1	40	60	3	0	0
691	80	0	0	42	60	4	0	0
691	51	2	0	49	60	2	0	0
691	66	1	0	43	60	2	0	0
691	39	0	0	41	60	1	0	0
691	428	0	0	30	60	5	0	0
691	7	2	1	20	60	2	1	0
691	190	0	0	20	60	5	0	0
692	229	0	0	45	60	5	1	0
692	419	1	1	29	60	3	1	0
692	424	1	0	29	60	2	1	0
692	447	2	0	21	60	5	0	0
692	188	1	0	36	60	3	0	0
692	61	0	1	39	60	0	0	0
692	116	2	0	37	60	4	0	0
692	196	1	1	25	60	5	0	0
693	155	2	1	27	60	2	0	0
693	118	0	0	25	60	2	1	0
693	144	1	1	35	60	5	0	0
693	471	2	1	47	60	3	0	0
693	119	1	1	41	60	2	0	0
693	383	0	0	48	60	4	0	0
693	200	1	1	30	60	4	0	0
693	454	1	0	44	60	0	0	0
694	138	1	1	41	60	3	0	0
694	389	1	0	34	60	0	0	0
694	177	0	1	30	60	5	0	0
694	266	2	0	43	60	1	0	0
694	17	2	0	48	60	0	1	0
694	442	2	1	50	60	3	0	0
694	79	0	1	43	60	4	1	0
694	159	0	0	30	60	0	0	0
695	98	0	0	29	60	4	0	0
695	421	1	1	35	60	3	0	0
695	185	1	0	50	60	0	0	0
695	166	0	1	39	60	3	0	0
695	144	0	1	48	60	2	1	0
695	90	1	1	36	60	5	0	0
695	175	2	1	44	60	5	1	0
695	436	2	1	26	60	3	0	0
696	294	2	1	33	60	4	0	0
696	421	2	0	49	60	4	0	0
696	304	1	0	49	60	2	0	0
696	333	0	1	25	60	0	0	0
696	457	0	0	27	60	2	1	0
696	14	1	0	24	60	5	1	0
696	154	0	0	36	60	2	0	0
696	262	0	0	23	60	3	0	0
697	113	2	0	27	60	4	0	0
697	22	1	1	49	60	1	0	0
697	253	0	1	46	60	3	0	0
697	315	2	0	45	60	2	1	0
697	361	1	1	23	60	2	0	0
697	168	1	0	20	60	0	0	0
697	210	0	0	26	60	1	1	0
697	129	2	0	35	60	1	0	0
698	382	1	0	39	60	0	0	0
698	256	2	0	26	60	3	0	0
698	290	0	1	22	60	3	0	0
698	202	1	1	22	60	4	0	0
698	365	0	0	49	60	1	0	0
698	375	0	1	42	60	3	0	0
698	63	2	0	22	60	3	0	0
698	321	0	1	31	60	1	0	0
699	209	1	0	32	60	2	0	0
699	110	1	1	20	60	1	0	0
699	492	0	1	47	60	4	1	0
699	289	1	0	42	60	3	0	0
699	325	1	0	21	60	3	0	0
699	304	1	0	49	60	5	0	0
699	105	1	1	20	60	2	0	0
699	186	0	1	47	60	2	0	0
700	368	1	0	36	60	2	0	0
700	332	0	1	44	60	4	0	0
700	155	2	1	37	60	3	0	0
700	14	1	0	37	60	5	1	0
700	72	1	1	32	60	1	1	0
700	207	2	0	25	60	3	1	0
700	238	0	1	20	60	4	0	0
700	355	1	0	47	60	5	0	0
701	12	1	0	22	60	4	1	0
701	315	0	0	23	60	5	1	0
701	171	2	1	28	60	4	0	0
701	163	2	0	42	60	4	0	0
701	376	2	0	44	60	0	0	0
701	337	2	1	20	60	3	1	0
701	414	1	0	40	60	5	0	0
701	366	1	0	41	60	0	0	0
702	99	2	0	48	60	3	0	0
702	96	0	0	32	60	2	0	0
702	50	1	0	42	60	5	0	0
702	166	0	1	42	60	2	0	0
702	295	2	0	26	60	2	1	0
702	28	0	1	20	60	4	0	0
702	43	0	1	47	60	1	0	0
702	61	1	1	30	60	0	1	0
703	69	0	1	49	60	4	1	0
703	43	0	1	42	60	3	0	0
703	11	2	1	42	60	2	1	0
703	393	2	0	25	60	4	0	0
703	66	1	1	23	60	5	0	0
703	24	0	0	45	60	4	0	0
703	185	0	1	43	60	4	1	0
703	302	0	0	39	60	5	1	0
704	265	0	1	25	60	3	1	0
704	16	1	1	25	60	3	0	0
704	134	0	1	44	60	4	0	0
704	172	2	1	24	60	4	0	0
704	252	1	1	41	60	4	0	0
704	388	2	0	38	60	0	0	0
704	349	0	1	40	60	5	0	0
704	129	0	1	41	60	0	0	0
705	79	0	1	36	60	4	0	0
705	301	2	1	24	60	2	0	0
705	373	1	1	34	60	3	0	0
705	300	0	1	40	60	2	1	0
705	364	1	1	34	60	4	0	0
705	315	1	1	48	60	3	1	0
705	374	0	0	38	60	1	1	0
705	229	0	0	22	60	0	1	0
706	85	2	0	46	60	4	0	0
706	192	0	0	31	60	1	0	0
706	2	1	1	25	60	1	1	0
706	394	0	1	46	60	3	0	0
706	429	1	1	27	60	5	0	0
706	433	2	0	29	60	2	0	0
706	184	2	1	37	60	4	0	0
706	210	0	1	50	60	2	1	0
707	458	2	1	25	60	2	0	0
707	328	2	0	49	60	2	1	0
707	189	1	0	33	60	4	0	0
707	116	2	0	44	60	3	0	0
707	203	1	0	43	60	2	0	0
707	372	1	1	49	60	4	0	0
707	139	1	0	26	60	4	0	0
707	463	2	0	29	60	5	1	0
708	316	2	0	40	60	4	1	0
708	197	1	0	22	60	1	1	0
708	32	2	0	36	60	3	0	0
708	122	0	1	21	60	1	0	0
708	476	0	1	34	60	1	0	0
708	106	0	0	32	60	0	0	0
708	361	0	0	37	60	2	0	0
708	300	0	0	26	60	0	0	0
709	81	0	0	28	60	3	0	0
709	271	2	0	47	60	3	0	0
709	161	0	0	28	60	4	0	0
709	9	0	0	37	60	4	0	0
709	274	1	1	26	60	2	1	0
709	452	1	1	37	60	2	1	0
709	218	0	0	20	60	3	0	0
709	164	1	0	45	60	1	0	0
710	393	0	1	39	60	5	1	0
710	355	2	0	22	60	2	0	0
710	160	1	0	34	60	2	1	0
710	369	1	1	33	60	0	0	0
710	480	0	0	24	60	5	0	0
710	426	2	0	44	60	5	0	0
710	141	0	1	21	60	3	0	0
710	400	0	0	47	60	4	0	0
711	222	0	0	47	60	2	0	0
711	280	0	0	38	60	1	0	0
711	482	0	0	30	60	1	0	0
711	1	0	0	39	60	4	0	0
711	112	1	0	30	60	1	0	0
711	230	1	1	22	60	0	0	0
711	461	2	1	30	60	1	0	0
711	221	0	0	45	60	3	0	0
712	476	2	1	27	60	4	0	0
712	54	1	0	45	60	1	0	0
712	96	0	1	24	60	1	0	0
712	399	1	1	20	60	1	1	0
712	167	0	0	38	60	2	0	0
712	64	1	1	45	60	3	0	0
712	414	2	1	46	60	1	0	0
712	335	2	1	44	60	4	0	0
713	258	1	0	39	60	0	1	0
713	116	2	0	33	60	1	1	0
713	201	0	0	38	60	5	0	0
713	313	1	0	34	60	2	0	0
713	191	2	0	26	60	1	0	0
713	421	0	0	32	60	3	1	0
713	430	1	1	34	60	5	0	0
713	158	1	0	47	60	5	0	0
714	13	1	1	25	60	2	0	0
714	75	0	0	50	60	1	0	0
714	186	0	1	26	60	4	0	0
714	476	1	1	20	60	5	0	0
714	28	0	0	25	60	1	0	0
714	100	2	1	23	60	2	0	0
714	55	0	1	37	60	1	0	0
714	400	1	0	35	60	1	0	0
715	344	2	1	46	60	1	0	0
715	266	2	0	27	60	3	0	0
715	188	0	0	28	60	3	0	0
715	304	2	1	29	60	3	0	0
715	274	1	1	46	60	4	1	0
715	141	1	0	28	60	1	0	0
715	331	1	1	43	60	4	0	0
715	282	1	0	31	60	4	0	0
716	491	1	0	33	60	1	0	0
716	91	1	1	46	60	1	1	0
716	146	1	1	31	60	2	1	0
716	234	2	0	22	60	0	0	0
716	189	1	0	49	60	2	1	0
716	302	0	0	38	60	0	0	0
716	164	1	1	40	60	0	0	0
716	295	2	0	37	60	1	0	0
717	68	2	0	23	60	3	0	0
717	20	0	0	22	60	5	0	0
717	392	2	0	34	60	5	0	0
717	461	1	0	38	60	0	0	0
717	307	1	0	37	60	4	0	0
717	363	1	0	23	60	0	0	0
717	258	0	0	38	60	3	0	0
717	211	1	1	34	60	5	0	0
718	198	2	1	28	60	0	0	0
718	460	1	1	46	60	4	0	0
718	455	0	1	37	60	2	0	0
718	7	2	0	47	60	5	0	0
718	448	0	0	33	60	1	0	0
718	193	1	0	39	60	2	1	0
718	301	1	0	35	60	0	0	0
718	499	2	0	42	60	5	0	0
719	142	1	1	42	60	3	0	0
719	473	1	0	31	60	5	1	0
719	189	2	1	45	60	5	0	0
719	477	1	0	43	60	1	0	0
719	308	2	1	29	60	5	0	0
719	395	0	1	32	60	1	0	0
719	311	2	0	41	60	5	1	0
719	397	2	1	39	60	0	0	0
720	212	1	1	43	60	5	1	0
720	242	2	0	28	60	4	0	0
720	143	0	1	35	60	0	0	0
720	150	2	0	49	60	4	0	0
720	300	0	1	26	60	5	1	0
720	383	2	0	30	60	1	0	0
720	123	2	1	21	60	1	0	0
720	313	2	0	40	60	5	0	0
721	122	2	1	39	60	2	1	0
721	165	1	0	32	60	4	0	0
721	290	0	1	31	60	3	0	0
721	103	2	1	35	60	3	0	0
721	39	2	0	42	60	4	1	0
721	455	0	0	37	60	2	0	0
721	484	2	0	24	60	2	0	0
721	330	2	0	22	60	3	1	0
722	221	2	0	36	60	5	0	0
722	270	2	0	45	60	2	0	0
722	152	0	0	37	60	5	0	0
722	121	2	0	34	60	2	0	0
722	434	0	1	20	60	5	1	0
722	248	1	1	22	60	5	0	0
722	228	2	0	33	60	2	0	0
722	371	2	1	21	60	3	1	0
723	329	2	0	31	60	0	0	0
723	3	2	0	50	60	3	1	0
723	124	0	1	22	60	2	0	0
723	497	0	0	36	60	0	0	0
723	366	2	1	35	60	1	1	0
723	348	2	0	48	60	3	0	0
723	11	0	1	47	60	2	0	0
723	151	0	1	28	60	1	0	0
724	42	1	1	49	60	5	0	0
724	342	2	0	31	60	3	0	0
724	51	1	1	28	60	1	0	0
724	127	2	0	47	60	0	0	0
724	104	1	1	31	60	1	1	0
724	471	1	1	25	60	4	0	0
724	31	1	0	49	60	5	0	0
724	111	0	1	47	60	4	0	0
725	138	2	1	43	60	5	0	0
725	310	0	1	42	60	4	1	0
725	128	0	1	34	60	1	1	0
725	111	1	0	34	60	1	0	0
725	218	0	1	28	60	5	0	0
725	402	0	1	49	60	3	1	0
725	201	2	1	44	60	0	0	0
725	500	2	1	44	60	5	0	0
726	64	2	0	33	60	0	1	0
726	259	2	1	46	60	5	0	0
726	55	0	0	20	60	2	1	0
726	395	2	1	30	60	2	1	0
726	269	0	0	35	60	5	1	0
726	224	0	1	46	60	4	0	0
726	476	1	1	22	60	2	0	0
726	167	2	1	49	60	5	0	0
727	160	0	0	45	60	4	0	0
727	365	2	1	47	60	4	1	0
727	230	0	0	29	60	2	0	0
727	296	2	1	41	60	3	1	0
727	358	1	0	27	60	0	0	0
727	226	0	0	43	60	0	0	0
727	168	2	0	24	60	4	0	0
727	16	0	0	50	60	1	0	0
728	374	2	0	44	60	3	0	0
728	108	1	1	25	60	5	0	0
728	403	2	1	44	60	5	0	0
728	255	1	1	43	60	2	0	0
728	148	2	0	40	60	0	0	0
728	466	1	1	39	60	3	0	0
728	298	1	1	41	60	4	1	0
728	34	2	1	22	60	0	0	0
729	14	1	1	32	60	0	0	0
729	430	2	1	27	60	2	0	0
729	223	2	0	23	60	1	1	0
729	229	2	0	50	60	3	0	0
729	2	0	1	38	60	0	0	0
729	356	1	0	32	60	0	1	0
729	332	0	0	39	60	5	1	0
729	202	2	0	34	60	2	1	0
730	37	2	1	47	60	2	1	0
730	40	1	1	23	60	3	0	0
730	306	0	1	49	60	3	0	0
730	123	1	1	24	60	1	0	0
730	266	0	0	23	60	0	0	0
730	60	1	0	47	60	5	0	0
730	309	0	0	34	60	3	0	0
730	256	0	0	21	60	5	0	0
731	415	1	1	25	60	0	0	0
731	67	0	0	31	60	5	0	0
731	187	2	0	27	60	3	0	0
731	227	0	0	49	60	3	1	0
731	98	2	1	40	60	1	0	0
731	365	0	0	32	60	3	1	0
731	402	1	1	23	60	1	0	0
731	50	1	1	32	60	2	0	0
732	79	0	0	44	60	1	0	0
732	423	1	1	36	60	5	1	0
732	316	1	0	36	60	0	1	0
732	429	2	1	38	60	4	0	0
732	141	2	0	20	60	4	0	0
732	180	0	1	20	60	0	1	0
732	127	1	1	36	60	3	0	0
732	407	2	0	21	60	3	0	0
733	351	1	1	25	60	0	0	0
733	375	2	0	28	60	2	1	0
733	16	1	1	24	60	0	0	0
733	387	0	1	39	60	4	1	0
733	425	0	0	50	60	5	0	0
733	443	1	1	39	60	1	1	0
733	467	1	1	39	60	2	1	0
733	312	2	1	46	60	1	0	0
734	380	2	1	42	60	4	0	0
734	251	1	0	25	60	0	1	0
734	449	1	1	36	60	1	0	0
734	298	1	0	38	60	3	1	0
734	222	0	1	37	60	2	0	0
734	274	2	1	39	60	1	0	0
734	27	1	1	30	60	2	1	0
734	148	1	1	32	60	0	0	0
735	51	0	0	38	60	1	1	0
735	88	1	0	31	60	1	0	0
735	439	1	0	24	60	5	0	0
735	71	0	0	36	60	5	1	0
735	263	0	1	48	60	4	0	0
735	338	0	1	37	60	1	1	0
735	280	1	0	22	60	4	1	0
735	79	1	0	23	60	5	0	0
736	134	0	0	36	60	0	1	0
736	313	0	0	41	60	2	0	0
736	107	2	1	25	60	3	0	0
736	183	2	0	41	60	5	0	0
736	73	1	1	32	60	2	1	0
736	342	1	1	20	60	5	1	0
736	168	2	1	40	60	0	0	0
736	180	1	1	29	60	0	1	0
737	2	0	1	22	60	3	0	0
737	359	1	0	31	60	4	0	0
737	119	2	0	46	60	0	1	0
737	64	1	1	42	60	1	1	0
737	445	2	0	37	60	3	1	0
737	323	2	1	24	60	1	0	0
737	92	1	0	44	60	4	0	0
737	44	2	0	46	60	2	0	0
738	289	2	0	45	60	4	0	0
738	500	0	0	38	60	3	0	0
738	362	0	0	35	60	0	1	0
738	300	2	1	47	60	5	1	0
738	441	2	0	26	60	5	0	0
738	231	2	0	47	60	4	0	0
738	479	2	0	37	60	0	0	0
738	191	1	1	25	60	5	0	0
739	430	0	1	44	60	1	0	0
739	107	2	1	30	60	3	0	0
739	66	2	0	45	60	2	0	0
739	424	1	0	50	60	0	0	0
739	189	1	0	45	60	4	1	0
739	137	1	0	44	60	4	0	0
739	378	0	1	39	60	1	0	0
739	238	2	0	46	60	4	0	0
740	228	0	1	31	60	4	0	0
740	495	2	1	29	60	4	0	0
740	436	0	0	23	60	1	0	0
740	133	0	1	36	60	1	0	0
740	297	2	1	33	60	3	0	0
740	388	2	1	26	60	1	1	0
740	183	0	0	46	60	5	1	0
740	314	1	1	41	60	3	0	0
741	102	2	0	22	60	4	0	0
741	110	1	0	29	60	0	0	0
741	197	0	0	37	60	1	0	0
741	234	0	1	45	60	0	0	0
741	112	1	0	20	60	0	1	0
741	24	2	1	25	60	4	0	0
741	59	2	1	45	60	0	1	0
741	298	1	1	40	60	0	1	0
742	238	0	0	49	60	3	0	0
742	171	0	0	23	60	3	0	0
742	2	0	1	47	60	0	1	0
742	479	2	0	45	60	5	0	0
742	246	1	0	23	60	0	1	0
742	435	2	0	35	60	2	0	0
742	79	0	1	25	60	5	0	0
742	333	1	0	42	60	1	0	0
743	78	2	1	28	60	3	0	0
743	315	1	0	30	60	2	1	0
743	132	1	0	30	60	3	0	0
743	174	2	1	39	60	2	0	0
743	449	1	1	36	60	5	0	0
743	170	1	1	34	60	2	0	0
743	262	1	0	42	60	1	0	0
743	318	0	1	21	60	4	0	0
744	21	0	1	20	60	4	0	0
744	146	1	0	28	60	3	0	0
744	285	0	0	26	60	5	0	0
744	362	1	0	35	60	4	0	0
744	110	2	1	36	60	3	0	0
744	338	0	0	43	60	4	0	0
744	400	1	1	38	60	2	0	0
744	472	1	1	21	60	5	0	0
745	399	2	0	29	60	3	0	0
745	135	1	0	50	60	1	0	0
745	263	2	1	21	60	0	0	0
745	400	1	1	24	60	0	0	0
745	358	2	0	34	60	0	0	0
745	170	0	1	42	60	2	0	0
745	173	1	0	47	60	1	0	0
745	52	1	0	45	60	1	0	0
746	480	2	1	40	60	3	0	0
746	78	0	0	34	60	4	1	0
746	214	1	0	20	60	3	0	0
746	239	2	1	23	60	5	0	0
746	294	0	0	50	60	1	0	0
746	101	1	0	24	60	4	0	0
746	337	0	1	35	60	5	1	0
746	97	1	1	39	60	3	1	0
747	40	2	1	23	60	1	0	0
747	234	0	0	20	60	1	1	0
747	343	2	1	22	60	0	1	0
747	295	1	1	38	60	3	1	0
747	195	1	1	28	60	2	1	0
747	278	0	1	31	60	5	1	0
747	32	0	0	32	60	3	0	0
747	41	2	1	25	60	3	1	0
748	208	2	1	24	60	5	0	0
748	252	1	1	32	60	2	0	0
748	407	2	1	31	60	1	0	0
748	142	1	1	20	60	1	0	0
748	97	0	0	43	60	2	0	0
748	49	1	0	41	60	3	0	0
748	123	2	1	28	60	2	0	0
748	17	1	1	20	60	4	1	0
749	435	0	1	38	60	0	0	0
749	286	2	0	24	60	0	0	0
749	113	1	0	49	60	3	0	0
749	253	1	1	25	60	4	0	0
749	392	2	0	23	60	3	0	0
749	453	2	1	32	60	2	0	0
749	50	1	0	50	60	4	0	0
749	140	0	0	45	60	1	0	0
750	24	0	0	45	60	4	0	0
750	266	2	1	39	60	0	0	0
750	356	0	1	39	60	0	0	0
750	490	2	0	37	60	5	0	0
750	418	0	1	29	60	3	0	0
750	198	1	0	42	60	4	0	0
750	409	2	0	46	60	0	0	0
750	294	2	1	38	60	5	1	0
751	129	1	0	27	60	5	1	0
751	302	2	0	20	60	2	1	0
751	356	0	0	32	60	1	0	0
751	27	1	0	29	60	4	1	0
751	387	0	0	22	60	2	1	0
751	493	0	1	43	60	5	0	0
751	489	1	0	20	60	3	0	0
751	116	0	0	21	60	4	0	0
752	332	0	1	31	60	4	0	0
752	210	0	1	50	60	0	0	0
752	437	0	1	39	60	0	1	0
752	333	1	1	29	60	2	1	0
752	254	2	1	48	60	1	0	0
752	305	2	1	45	60	4	0	0
752	54	2	0	39	60	2	0	0
752	269	1	1	21	60	1	0	0
753	94	2	0	30	60	0	0	0
753	479	2	0	32	60	2	0	0
753	334	2	1	28	60	2	0	0
753	461	2	1	48	60	0	1	0
753	26	1	0	31	60	5	1	0
753	36	2	1	29	60	1	0	0
753	283	2	0	27	60	2	0	0
753	413	1	0	46	60	0	1	0
754	17	0	1	46	60	5	0	0
754	398	2	0	39	60	1	0	0
754	127	1	1	28	60	2	1	0
754	355	2	0	23	60	3	0	0
754	14	2	0	39	60	2	0	0
754	273	2	1	42	60	4	1	0
754	28	2	1	33	60	5	0	0
754	453	0	1	47	60	1	0	0
755	352	1	1	44	60	3	0	0
755	119	2	1	33	60	4	0	0
755	298	2	1	32	60	5	0	0
755	202	0	0	44	60	4	1	0
755	27	1	0	42	60	3	0	0
755	67	2	0	38	60	2	0	0
755	48	2	0	44	60	0	0	0
755	500	1	0	32	60	1	1	0
756	439	1	0	39	60	0	1	0
756	29	0	1	22	60	5	0	0
756	374	2	0	39	60	1	0	0
756	149	0	1	34	60	1	0	0
756	355	2	1	20	60	5	0	0
756	425	1	0	36	60	3	0	0
756	345	2	0	49	60	5	0	0
756	389	0	1	49	60	0	0	0
757	444	0	1	34	60	1	0	0
757	94	1	0	31	60	3	0	0
757	34	1	0	46	60	4	1	0
757	180	0	1	25	60	2	1	0
757	387	2	0	36	60	4	0	0
757	24	2	1	29	60	1	0	0
757	439	0	0	42	60	4	0	0
757	165	1	0	49	60	2	1	0
758	378	2	1	37	60	4	0	0
758	35	0	1	50	60	0	0	0
758	194	0	0	26	60	3	0	0
758	82	0	1	50	60	5	1	0
758	383	0	1	26	60	3	0	0
758	12	2	1	36	60	4	0	0
758	100	0	0	23	60	1	1	0
758	210	1	1	27	60	2	1	0
759	369	0	0	50	60	2	0	0
759	317	0	1	44	60	5	0	0
759	213	1	1	41	60	1	0	0
759	344	2	1	35	60	2	0	0
759	38	0	1	39	60	5	0	0
759	201	1	0	43	60	0	1	0
759	221	2	0	47	60	2	0	0
759	58	2	0	32	60	4	0	0
760	445	2	1	30	60	3	0	0
760	499	2	1	43	60	3	0	0
760	29	1	0	50	60	2	0	0
760	201	1	1	45	60	0	0	0
760	180	0	0	50	60	5	1	0
760	159	0	1	31	60	0	0	0
760	156	2	1	32	60	5	0	0
760	64	2	0	44	60	0	0	0
761	435	0	1	50	60	1	0	0
761	139	1	1	48	60	3	0	0
761	428	0	0	27	60	4	1	0
761	337	1	0	31	60	5	0	0
761	275	0	0	27	60	2	1	0
761	445	0	1	23	60	1	0	0
761	223	0	0	25	60	1	1	0
761	452	0	0	29	60	4	1	0
762	439	1	0	23	60	1	0	0
762	132	2	1	24	60	0	0	0
762	189	2	1	21	60	5	0	0
762	260	1	1	37	60	4	0	0
762	474	2	1	40	60	0	0	0
762	420	0	1	31	60	2	0	0
762	427	1	0	25	60	1	1	0
762	342	0	1	44	60	1	1	0
763	312	1	0	47	60	0	1	0
763	323	0	0	30	60	2	1	0
763	410	2	0	39	60	5	0	0
763	495	0	1	35	60	4	0	0
763	439	2	0	21	60	2	1	0
763	39	2	1	50	60	2	0	0
763	357	0	1	49	60	5	0	0
763	288	0	0	37	60	2	0	0
764	313	1	1	26	60	2	0	0
764	95	0	0	38	60	0	1	0
764	268	0	0	41	60	5	1	0
764	445	0	0	31	60	2	0	0
764	479	1	1	35	60	1	1	0
764	207	0	0	33	60	1	0	0
764	74	0	1	23	60	5	0	0
764	19	1	1	50	60	3	0	0
765	237	0	1	31	60	1	1	0
765	138	1	1	43	60	0	0	0
765	1	1	0	45	60	1	0	0
765	369	1	0	47	60	2	1	0
765	220	2	0	50	60	3	1	0
765	15	2	1	45	60	1	0	0
765	119	2	1	49	60	0	0	0
765	292	1	1	32	60	1	1	0
766	267	0	1	47	60	0	0	0
766	484	0	1	22	60	4	0	0
766	119	2	1	36	60	5	0	0
766	337	2	0	31	60	1	0	0
766	156	0	0	37	60	0	0	0
766	154	1	0	46	60	5	0	0
766	123	0	1	31	60	4	0	0
766	483	1	0	29	60	5	0	0
767	148	0	0	49	60	2	1	0
767	346	0	0	46	60	3	0	0
767	380	0	0	50	60	1	0	0
767	475	0	0	30	60	2	0	0
767	44	1	0	31	60	0	0	0
767	340	0	0	21	60	4	0	0
767	416	1	0	44	60	5	0	0
767	195	0	1	24	60	4	1	0
768	397	1	0	46	60	2	0	0
768	347	0	0	45	60	2	1	0
768	216	2	1	33	60	1	1	0
768	418	2	1	29	60	5	1	0
768	118	2	0	27	60	3	0	0
768	82	2	0	50	60	3	0	0
768	297	1	0	29	60	3	0	0
768	109	0	1	22	60	3	0	0
769	289	2	0	23	60	5	1	0
769	350	0	0	44	60	4	0	0
769	28	1	1	38	60	0	1	0
769	73	2	0	46	60	3	1	0
769	20	0	0	35	60	4	0	0
769	68	0	0	48	60	3	0	0
769	186	1	1	46	60	3	1	0
769	133	0	1	46	60	4	0	0
770	214	1	0	49	60	0	0	0
770	168	0	1	23	60	3	0	0
770	279	1	1	24	60	2	0	0
770	472	0	1	32	60	3	0	0
770	280	2	1	31	60	3	0	0
770	339	2	0	24	60	0	0	0
770	276	2	1	30	60	0	0	0
770	356	2	1	23	60	0	1	0
771	417	1	1	36	60	4	0	0
771	436	0	0	39	60	2	0	0
771	314	1	1	25	60	0	0	0
771	455	1	0	31	60	4	0	0
771	412	0	1	40	60	3	0	0
771	206	1	1	30	60	1	1	0
771	29	1	0	26	60	0	0	0
771	410	0	1	35	60	4	0	0
772	406	2	1	49	60	2	1	0
772	278	2	0	36	60	3	0	0
772	378	2	1	43	60	2	0	0
772	500	0	1	37	60	3	0	0
772	206	1	0	43	60	3	0	0
772	177	2	0	33	60	3	0	0
772	342	2	1	44	60	2	0	0
772	309	0	1	48	60	3	1	0
773	101	2	1	50	60	2	1	0
773	215	2	1	40	60	3	0	0
773	383	1	1	36	60	4	0	0
773	358	2	0	22	60	4	0	0
773	274	0	0	46	60	4	0	0
773	357	1	1	27	60	4	1	0
773	492	2	1	38	60	3	0	0
773	415	2	1	22	60	0	0	0
774	495	1	1	39	60	3	0	0
774	193	1	1	35	60	2	1	0
774	67	0	1	39	60	4	1	0
774	355	1	0	21	60	5	0	0
774	171	0	0	29	60	1	0	0
774	279	2	1	22	60	5	0	0
774	72	2	0	37	60	3	0	0
774	356	1	1	35	60	3	0	0
775	41	1	0	31	60	5	0	0
775	125	1	1	37	60	3	1	0
775	438	1	0	33	60	3	0	0
775	409	0	0	48	60	5	1	0
775	200	1	1	50	60	0	0	0
775	416	1	1	25	60	1	0	0
775	196	1	1	37	60	2	1	0
775	363	0	0	41	60	0	0	0
776	192	0	1	45	60	5	1	0
776	394	1	0	37	60	3	0	0
776	178	1	0	29	60	5	0	0
776	191	1	1	31	60	3	0	0
776	190	1	1	44	60	0	0	0
776	62	1	1	26	60	5	0	0
776	136	2	0	45	60	2	0	0
776	172	2	1	33	60	0	0	0
777	252	2	1	47	60	0	0	0
777	402	0	1	43	60	0	1	0
777	200	0	1	43	60	3	0	0
777	301	1	1	31	60	3	0	0
777	378	0	0	23	60	4	0	0
777	290	0	1	33	60	0	0	0
777	405	1	1	48	60	5	0	0
777	164	2	1	28	60	5	0	0
778	234	0	0	23	60	3	1	0
778	459	1	1	30	60	0	0	0
778	387	2	0	47	60	3	1	0
778	181	2	1	24	60	3	1	0
778	244	0	0	39	60	4	0	0
778	30	2	1	20	60	3	0	0
778	55	1	0	33	60	3	0	0
778	451	0	1	31	60	2	0	0
779	369	0	1	42	60	4	0	0
779	295	0	0	28	60	1	0	0
779	370	1	0	42	60	5	1	0
779	361	2	0	41	60	1	0	0
779	24	1	1	50	60	1	0	0
779	470	1	0	34	60	1	0	0
779	136	2	0	41	60	4	0	0
779	85	1	1	31	60	1	0	0
780	429	0	0	37	60	2	0	0
780	106	2	1	48	60	3	0	0
780	153	1	0	37	60	3	1	0
780	392	0	1	49	60	1	0	0
780	23	1	1	47	60	5	1	0
780	85	1	0	34	60	4	0	0
780	87	1	0	28	60	0	1	0
780	80	0	1	21	60	0	0	0
781	469	1	1	34	60	0	0	0
781	137	2	1	20	60	2	1	0
781	233	1	1	22	60	0	0	0
781	209	0	0	25	60	4	0	0
781	493	1	0	25	60	1	1	0
781	237	0	0	42	60	2	0	0
781	27	2	1	49	60	3	1	0
781	22	1	1	28	60	0	1	0
782	174	2	1	36	60	1	0	0
782	278	2	1	28	60	3	1	0
782	307	1	1	32	60	1	1	0
782	258	0	1	47	60	0	0	0
782	235	2	1	45	60	3	0	0
782	252	0	1	21	60	4	0	0
782	362	0	0	44	60	4	1	0
782	204	0	1	49	60	2	1	0
783	31	2	1	35	60	2	0	0
783	425	0	1	36	60	1	1	0
783	29	1	0	26	60	2	0	0
783	296	1	1	43	60	4	1	0
783	130	2	0	21	60	2	0	0
783	268	0	0	20	60	2	0	0
783	419	2	1	41	60	3	0	0
783	60	0	0	25	60	0	0	0
784	493	0	0	43	60	1	0	0
784	222	1	0	22	60	5	0	0
784	162	2	0	21	60	2	0	0
784	232	0	1	42	60	1	0	0
784	68	1	0	27	60	5	1	0
784	434	2	0	24	60	5	1	0
784	468	1	1	28	60	4	0	0
784	417	0	0	42	60	2	1	0
785	255	1	0	28	60	5	0	0
785	211	2	0	27	60	3	1	0
785	441	1	1	41	60	1	0	0
785	111	0	0	37	60	2	0	0
785	133	1	1	24	60	0	1	0
785	206	0	1	23	60	4	0	0
785	88	0	0	43	60	2	0	0
785	260	1	1	38	60	5	0	0
786	331	0	0	41	60	3	1	0
786	209	0	0	50	60	4	0	0
786	239	0	1	36	60	2	0	0
786	43	2	0	45	60	2	0	0
786	383	2	0	47	60	1	0	0
786	290	1	1	36	60	3	0	0
786	218	2	0	21	60	3	1	0
786	359	1	1	38	60	5	1	0
787	331	1	0	47	60	4	0	0
787	8	0	0	32	60	1	0	0
787	251	1	1	20	60	5	1	0
787	452	2	0	41	60	4	0	0
787	285	0	1	47	60	0	0	0
787	293	1	1	45	60	3	0	0
787	207	2	1	23	60	1	0	0
787	31	1	0	23	60	4	0	0
788	275	1	0	34	60	0	0	0
788	373	2	0	45	60	0	0	0
788	201	2	1	29	60	4	0	0
788	420	0	0	49	60	5	0	0
788	473	2	0	28	60	5	0	0
788	4	2	1	38	60	2	0	0
788	423	0	1	47	60	0	0	0
788	173	1	1	32	60	3	0	0
789	488	1	1	22	60	2	0	0
789	421	1	0	21	60	1	0	0
789	472	0	0	45	60	5	0	0
789	12	1	1	24	60	0	1	0
789	465	1	1	48	60	0	0	0
789	333	1	1	21	60	5	0	0
789	391	0	1	43	60	4	1	0
789	371	1	0	39	60	4	0	0
790	245	2	0	48	60	2	1	0
790	338	1	0	46	60	5	0	0
790	141	2	0	44	60	5	0	0
790	167	1	0	46	60	4	0	0
790	248	1	1	23	60	5	0	0
790	36	1	1	25	60	0	0	0
790	387	1	1	23	60	0	0	0
790	112	2	0	24	60	1	1	0
791	212	0	0	27	60	4	0	0
791	285	2	1	44	60	1	1	0
791	14	2	1	40	60	1	1	0
791	279	1	0	23	60	3	0	0
791	427	2	1	44	60	1	0	0
791	397	0	1	39	60	2	0	0
791	238	2	1	37	60	4	0	0
791	393	1	0	40	60	0	0	0
792	293	0	1	24	60	0	1	0
792	108	0	0	34	60	2	0	0
792	139	2	1	38	60	1	0	0
792	78	2	1	41	60	0	0	0
792	101	1	1	40	60	2	0	0
792	158	1	1	49	60	5	0	0
792	262	2	0	20	60	1	0	0
792	114	0	1	36	60	4	1	0
793	184	0	0	40	60	1	0	0
793	98	1	0	28	60	5	0	0
793	492	0	0	29	60	4	0	0
793	251	1	0	28	60	1	1	0
793	348	1	0	49	60	5	0	0
793	384	1	0	43	60	1	0	0
793	133	0	0	22	60	0	0	0
793	134	0	1	34	60	2	0	0
794	3	2	1	25	60	2	0	0
794	494	1	1	20	60	2	0	0
794	235	2	1	33	60	4	0	0
794	144	0	0	27	60	4	0	0
794	140	1	1	21	60	1	0	0
794	493	2	1	35	60	5	0	0
794	371	2	0	50	60	4	0	0
794	471	1	0	37	60	3	0	0
795	373	0	1	35	60	3	0	0
795	9	1	1	21	60	0	0	0
795	49	1	1	23	60	2	0	0
795	8	2	1	45	60	5	0	0
795	420	2	0	27	60	2	0	0
795	209	2	1	26	60	0	0	0
795	245	2	1	27	60	4	0	0
795	448	0	1	28	60	4	0	0
796	489	2	1	37	60	3	0	0
796	375	1	1	27	60	5	0	0
796	9	2	0	45	60	4	0	0
796	336	2	0	40	60	4	0	0
796	384	0	1	34	60	1	1	0
796	406	2	0	33	60	5	0	0
796	408	0	1	47	60	2	1	0
796	393	2	0	30	60	5	0	0
797	464	2	0	26	60	0	0	0
797	172	1	0	40	60	0	0	0
797	359	2	1	32	60	2	0	0
797	134	2	0	27	60	2	0	0
797	91	1	1	28	60	0	0	0
797	328	0	1	34	60	1	0	0
797	470	1	1	22	60	0	1	0
797	282	0	1	34	60	4	0	0
798	249	1	0	30	60	2	0	0
798	35	1	1	22	60	0	0	0
798	265	1	1	25	60	3	1	0
798	355	0	0	21	60	3	1	0
798	64	2	1	21	60	3	0	0
798	452	2	0	30	60	2	1	0
798	112	2	1	43	60	1	0	0
798	24	2	1	24	60	2	0	0
799	29	0	1	32	60	3	0	0
799	466	0	0	48	60	5	0	0
799	148	0	0	29	60	1	1	0
799	166	2	0	36	60	5	1	0
799	72	2	0	28	60	4	0	0
799	348	2	0	37	60	4	0	0
799	380	1	0	27	60	1	0	0
799	500	2	1	30	60	5	0	0
800	112	0	1	40	60	0	0	0
800	221	0	0	44	60	2	0	0
800	53	0	0	23	60	3	0	0
800	293	1	1	29	60	4	0	0
800	215	1	0	20	60	4	0	0
800	3	0	1	21	60	4	0	0
800	10	1	0	24	60	0	1	0
800	298	0	1	29	60	0	0	0
801	218	0	1	35	60	4	1	0
801	304	0	0	30	60	5	0	0
801	278	1	1	48	60	2	0	0
801	419	2	1	40	60	3	0	0
801	255	0	0	38	60	2	0	0
801	284	1	1	40	60	1	0	0
801	47	0	0	47	60	0	0	0
801	76	2	0	41	60	2	1	0
802	89	2	0	24	60	1	0	0
802	264	1	0	38	60	2	0	0
802	226	0	1	50	60	1	0	0
802	339	1	0	44	60	2	0	0
802	437	1	1	30	60	5	0	0
802	438	0	0	47	60	1	0	0
802	406	0	1	45	60	0	1	0
802	17	0	1	35	60	3	0	0
803	448	1	1	26	60	0	0	0
803	152	2	0	49	60	4	1	0
803	85	1	1	36	60	2	0	0
803	408	1	0	36	60	5	0	0
803	134	1	1	48	60	2	1	0
803	426	1	0	40	60	4	0	0
803	301	0	1	35	60	2	1	0
803	79	0	1	47	60	0	0	0
804	117	0	0	27	60	3	0	0
804	219	2	1	32	60	5	0	0
804	283	2	1	49	60	4	1	0
804	363	0	1	44	60	0	0	0
804	413	0	0	25	60	5	0	0
804	322	1	0	47	60	2	1	0
804	100	2	1	42	60	0	0	0
804	357	0	1	23	60	1	0	0
805	321	1	1	48	60	5	0	0
805	213	2	0	26	60	3	0	0
805	48	2	1	41	60	2	0	0
805	175	0	0	38	60	3	0	0
805	488	0	0	36	60	4	0	0
805	354	2	0	35	60	2	0	0
805	414	1	1	43	60	5	0	0
805	320	2	1	26	60	0	0	0
806	263	2	1	27	60	1	0	0
806	362	1	0	49	60	1	0	0
806	180	2	1	33	60	5	0	0
806	171	2	1	31	60	2	0	0
806	59	0	1	27	60	4	1	0
806	379	1	1	32	60	2	0	0
806	68	2	0	46	60	5	0	0
806	152	1	0	37	60	4	0	0
807	116	2	1	38	60	5	1	0
807	170	1	1	29	60	0	1	0
807	108	2	0	49	60	0	0	0
807	53	0	1	35	60	3	0	0
807	405	2	1	36	60	4	0	0
807	380	0	1	42	60	5	0	0
807	450	1	1	44	60	0	1	0
807	193	1	1	21	60	1	1	0
808	412	0	0	23	60	4	0	0
808	315	2	0	32	60	1	1	0
808	204	2	1	42	60	3	0	0
808	265	0	0	41	60	2	1	0
808	351	2	1	48	60	1	0	0
808	418	0	1	32	60	0	0	0
808	274	0	1	50	60	0	1	0
808	331	0	1	30	60	2	0	0
809	3	1	0	44	60	2	1	0
809	330	0	1	24	60	1	0	0
809	406	1	0	48	60	3	0	0
809	147	0	1	39	60	1	0	0
809	285	1	0	43	60	5	0	0
809	264	2	1	40	60	5	1	0
809	499	1	0	45	60	2	1	0
809	160	1	1	30	60	4	1	0
810	175	0	0	39	60	0	0	0
810	167	1	1	46	60	0	0	0
810	338	2	0	28	60	0	0	0
810	387	2	0	34	60	1	0	0
810	428	2	0	49	60	3	0	0
810	433	2	1	35	60	2	1	0
810	315	2	0	20	60	2	0	0
810	94	1	0	34	60	4	0	0
811	481	0	1	28	60	5	1	0
811	413	1	1	49	60	5	0	0
811	261	2	1	21	60	1	0	0
811	380	1	0	22	60	1	0	0
811	402	1	1	35	60	0	0	0
811	330	0	1	24	60	5	0	0
811	149	2	0	28	60	3	0	0
811	332	2	0	32	60	0	1	0
812	298	2	1	24	60	1	0	0
812	224	0	1	24	60	0	0	0
812	46	2	1	48	60	4	0	0
812	1	2	1	47	60	2	0	0
812	97	1	1	26	60	5	0	0
812	372	1	0	48	60	2	1	0
812	72	0	1	22	60	4	1	0
812	341	0	0	26	60	2	0	0
813	321	1	0	30	60	3	1	0
813	142	1	0	24	60	2	1	0
813	382	0	0	25	60	1	0	0
813	230	1	1	41	60	0	1	0
813	267	2	0	43	60	0	0	0
813	172	2	0	37	60	2	0	0
813	355	2	0	40	60	1	1	0
813	113	2	1	21	60	2	0	0
814	386	2	0	22	60	3	0	0
814	136	0	0	32	60	2	0	0
814	75	1	0	37	60	2	0	0
814	126	2	0	49	60	0	1	0
814	444	0	0	24	60	1	0	0
814	375	0	0	28	60	5	0	0
814	287	1	0	27	60	4	0	0
814	421	2	1	29	60	2	0	0
815	400	2	1	44	60	0	1	0
815	245	0	0	42	60	1	1	0
815	106	2	0	31	60	3	0	0
815	458	1	1	35	60	5	0	0
815	40	1	0	46	60	2	0	0
815	259	1	1	38	60	3	0	0
815	367	1	1	43	60	1	0	0
815	274	2	1	43	60	3	0	0
816	51	2	1	25	60	3	0	0
816	53	2	0	35	60	2	0	0
816	311	1	1	34	60	5	0	0
816	450	1	1	30	60	5	0	0
816	146	1	0	29	60	4	0	0
816	294	1	1	22	60	0	0	0
816	54	1	1	42	60	1	0	0
816	438	2	0	20	60	3	0	0
817	334	0	1	39	60	3	0	0
817	141	0	0	34	60	5	0	0
817	462	1	1	40	60	0	0	0
817	319	1	0	40	60	2	0	0
817	43	2	1	33	60	0	0	0
817	227	0	0	48	60	0	0	0
817	270	0	0	47	60	2	0	0
817	307	0	0	29	60	1	1	0
818	172	0	0	28	60	0	0	0
818	379	2	0	38	60	1	0	0
818	333	1	0	35	60	2	0	0
818	458	2	1	45	60	5	0	0
818	373	1	0	24	60	2	0	0
818	447	0	1	44	60	2	0	0
818	371	2	1	39	60	4	0	0
818	328	0	0	36	60	2	0	0
819	385	0	0	46	60	5	1	0
819	413	1	1	24	60	5	0	0
819	279	1	0	20	60	3	1	0
819	103	0	0	23	60	0	0	0
819	148	1	1	21	60	3	0	0
819	322	2	1	30	60	5	0	0
819	303	1	1	22	60	3	0	0
819	173	1	0	24	60	1	0	0
820	325	1	1	23	60	3	0	0
820	375	1	1	46	60	1	0	0
820	437	2	0	20	60	3	0	0
820	383	2	1	21	60	1	0	0
820	476	1	1	31	60	5	0	0
820	389	2	1	21	60	5	0	0
820	209	2	0	46	60	2	0	0
820	278	1	0	42	60	3	0	0
821	85	0	0	49	60	1	1	0
821	121	0	1	27	60	3	0	0
821	151	1	0	41	60	0	1	0
821	237	2	1	29	60	4	1	0
821	68	0	0	49	60	2	0	0
821	369	0	1	49	60	1	0	0
821	13	0	0	49	60	0	0	0
821	368	0	1	23	60	1	1	0
822	226	2	1	28	60	2	0	0
822	490	0	1	49	60	2	0	0
822	441	1	1	40	60	0	1	0
822	137	1	0	23	60	3	0	0
822	108	0	1	44	60	5	0	0
822	354	0	0	35	60	5	1	0
822	461	1	0	33	60	1	0	0
822	212	2	1	35	60	2	0	0
823	275	2	0	23	60	3	0	0
823	262	0	1	25	60	2	0	0
823	369	1	1	23	60	4	0	0
823	95	1	0	32	60	0	1	0
823	165	1	1	27	60	1	0	0
823	116	0	1	48	60	5	0	0
823	327	2	0	44	60	2	1	0
823	411	1	0	22	60	0	0	0
824	96	0	1	20	60	0	0	0
824	269	0	1	50	60	0	0	0
824	383	0	0	48	60	1	0	0
824	337	1	1	42	60	0	0	0
824	491	1	1	40	60	4	0	0
824	473	1	0	46	60	0	0	0
824	481	1	0	43	60	1	0	0
824	9	1	0	24	60	3	0	0
825	470	0	0	25	60	3	1	0
825	52	0	0	25	60	4	0	0
825	15	0	1	31	60	2	0	0
825	178	2	1	50	60	1	0	0
825	329	0	1	31	60	0	0	0
825	474	1	1	43	60	1	1	0
825	404	2	0	23	60	3	0	0
825	241	2	1	49	60	5	1	0
826	245	1	0	50	60	1	1	0
826	333	2	0	49	60	4	1	0
826	157	1	1	27	60	0	1	0
826	271	1	0	21	60	0	0	0
826	20	0	0	31	60	2	0	0
826	216	1	0	23	60	0	0	0
826	152	0	1	27	60	2	1	0
826	368	0	1	29	60	5	0	0
827	418	0	1	24	60	0	0	0
827	151	0	0	39	60	5	0	0
827	136	1	1	32	60	4	1	0
827	266	0	0	21	60	3	0	0
827	258	1	1	39	60	2	0	0
827	158	0	1	34	60	4	1	0
827	204	1	0	41	60	1	0	0
827	36	2	0	22	60	0	0	0
828	379	0	1	46	60	5	0	0
828	240	1	0	43	60	4	0	0
828	483	1	0	38	60	0	0	0
828	248	2	0	30	60	0	0	0
828	385	2	0	31	60	0	0	0
828	95	0	1	42	60	2	0	0
828	92	2	1	26	60	2	1	0
828	314	2	0	45	60	5	0	0
829	261	1	0	22	60	0	1	0
829	73	2	0	40	60	4	0	0
829	247	0	0	37	60	3	0	0
829	185	2	1	33	60	4	1	0
829	59	0	0	48	60	3	1	0
829	442	0	0	46	60	3	1	0
829	75	2	0	46	60	2	0	0
829	169	0	0	50	60	1	0	0
830	41	0	0	46	60	4	1	0
830	251	1	0	49	60	3	1	0
830	24	0	0	24	60	0	0	0
830	410	0	1	38	60	3	0	0
830	164	0	0	22	60	1	0	0
830	201	0	1	25	60	0	0	0
830	311	1	1	20	60	4	0	0
830	366	1	1	26	60	2	0	0
831	319	0	1	47	60	5	0	0
831	257	0	0	25	60	4	0	0
831	325	0	1	27	60	3	0	0
831	60	1	1	47	60	3	0	0
831	86	1	1	31	60	3	1	0
831	39	0	1	33	60	1	0	0
831	253	1	1	21	60	0	0	0
831	292	1	1	37	60	3	0	0
832	280	1	0	38	60	4	0	0
832	208	0	1	21	60	0	0	0
832	495	1	0	32	60	2	1	0
832	300	0	0	34	60	4	0	0
832	9	1	0	41	60	3	1	0
832	461	2	0	48	60	2	0	0
832	269	1	1	48	60	3	0	0
832	486	0	0	45	60	0	0	0
833	341	0	1	34	60	3	0	0
833	149	2	0	41	60	5	0	0
833	112	1	1	27	60	4	0	0
833	331	0	1	47	60	2	0	0
833	286	0	0	40	60	1	1	0
833	174	0	0	46	60	1	0	0
833	197	1	1	39	60	1	1	0
833	85	0	0	33	60	3	1	0
834	342	1	0	27	60	1	1	0
834	63	0	0	28	60	5	1	0
834	366	2	1	45	60	3	0	0
834	117	0	0	24	60	4	1	0
834	93	0	0	32	60	1	0	0
834	429	2	0	21	60	2	0	0
834	187	2	0	34	60	4	0	0
834	55	0	0	26	60	5	0	0
835	430	2	1	45	60	1	0	0
835	35	0	1	41	60	5	0	0
835	453	1	0	43	60	3	0	0
835	408	1	0	38	60	0	0	0
835	383	2	1	34	60	4	1	0
835	340	1	0	20	60	4	0	0
835	384	2	0	38	60	5	0	0
835	474	1	0	27	60	1	0	0
836	429	2	1	23	60	2	1	0
836	340	2	0	25	60	0	1	0
836	398	2	0	46	60	2	0	0
836	407	1	0	49	60	0	0	0
836	361	2	0	49	60	4	0	0
836	418	1	0	44	60	2	1	0
836	334	2	0	48	60	1	0	0
836	94	1	0	27	60	4	1	0
837	185	2	1	21	60	4	0	0
837	290	2	1	33	60	0	1	0
837	343	2	1	50	60	3	0	0
837	101	0	0	42	60	0	0	0
837	174	0	1	34	60	5	1	0
837	225	2	1	28	60	1	1	0
837	336	2	0	41	60	3	0	0
837	419	1	1	45	60	0	1	0
838	407	0	1	20	60	5	0	0
838	218	2	0	35	60	1	0	0
838	480	2	0	49	60	2	0	0
838	420	1	1	38	60	5	1	0
838	406	0	0	44	60	1	1	0
838	327	0	1	29	60	3	0	0
838	287	1	0	45	60	2	0	0
838	216	2	0	40	60	1	1	0
839	57	0	0	48	60	3	0	0
839	477	2	1	22	60	1	0	0
839	34	2	0	30	60	2	0	0
839	42	2	0	39	60	2	0	0
839	471	0	1	34	60	1	1	0
839	92	1	1	33	60	3	0	0
839	341	2	1	46	60	1	0	0
839	322	1	0	30	60	2	1	0
840	62	2	1	32	60	3	0	0
840	125	1	1	30	60	4	0	0
840	486	0	0	50	60	0	0	0
840	107	2	1	34	60	4	0	0
840	138	2	0	50	60	2	1	0
840	482	1	1	35	60	0	0	0
840	18	0	1	45	60	2	0	0
840	156	2	1	23	60	1	0	0
841	490	1	0	23	60	5	1	0
841	91	2	0	20	60	2	1	0
841	325	2	1	49	60	4	0	0
841	209	1	0	21	60	5	0	0
841	262	1	1	27	60	2	0	0
841	449	1	1	38	60	3	1	0
841	83	1	1	43	60	5	0	0
841	119	0	1	39	60	2	0	0
842	500	0	1	29	60	0	0	0
842	435	0	1	23	60	2	0	0
842	104	0	1	25	60	5	0	0
842	376	2	1	44	60	5	0	0
842	151	2	0	29	60	2	0	0
842	489	2	1	26	60	4	1	0
842	46	1	0	21	60	2	1	0
842	222	1	1	47	60	1	1	0
843	117	2	1	27	60	0	0	0
843	384	0	1	38	60	5	0	0
843	490	1	0	23	60	3	1	0
843	146	0	1	22	60	0	1	0
843	278	1	0	42	60	2	0	0
843	364	0	1	36	60	1	0	0
843	242	1	0	50	60	0	0	0
843	269	0	1	38	60	3	0	0
844	355	2	0	22	60	4	0	0
844	429	0	0	47	60	3	0	0
844	75	1	1	47	60	2	1	0
844	274	0	1	30	60	0	1	0
844	267	1	0	27	60	1	1	0
844	298	2	1	25	60	1	0	0
844	485	2	1	35	60	0	0	0
844	104	0	1	36	60	5	0	0
845	341	1	1	24	60	4	0	0
845	159	2	1	20	60	5	0	0
845	149	1	0	23	60	2	0	0
845	307	0	1	43	60	2	0	0
845	263	2	0	48	60	3	0	0
845	139	2	1	31	60	2	1	0
845	494	2	0	39	60	4	0	0
845	421	1	0	43	60	1	1	0
846	432	0	1	36	60	2	0	0
846	17	2	1	46	60	2	1	0
846	94	2	0	36	60	5	0	0
846	230	2	1	35	60	3	0	0
846	488	0	0	36	60	2	0	0
846	460	1	1	33	60	4	0	0
846	149	1	1	25	60	4	0	0
846	181	2	0	33	60	0	0	0
847	453	1	1	36	60	4	0	0
847	171	2	0	25	60	2	0	0
847	194	1	1	26	60	3	1	0
847	99	2	1	26	60	0	0	0
847	362	0	0	50	60	3	0	0
847	119	1	1	30	60	0	0	0
847	28	2	1	48	60	1	1	0
847	326	2	0	36	60	0	0	0
848	437	2	0	26	60	1	0	0
848	422	2	0	46	60	4	1	0
848	18	1	1	29	60	2	0	0
848	283	0	1	36	60	5	1	0
848	252	0	0	42	60	4	0	0
848	219	2	0	20	60	1	0	0
848	94	2	0	24	60	1	1	0
848	143	0	0	46	60	4	1	0
849	486	1	0	43	60	3	0	0
849	58	1	0	35	60	3	0	0
849	324	0	0	36	60	4	0	0
849	134	1	0	40	60	1	1	0
849	397	2	0	39	60	5	0	0
849	21	2	0	35	60	3	1	0
849	286	1	1	35	60	2	1	0
849	456	0	1	30	60	1	0	0
850	440	2	0	47	60	4	1	0
850	22	0	0	26	60	3	0	0
850	487	1	1	33	60	1	0	0
850	498	1	0	44	60	4	0	0
850	197	0	1	37	60	2	1	0
850	280	0	1	41	60	3	0	0
850	471	2	1	37	60	2	0	0
850	150	1	1	46	60	0	0	0
851	280	0	1	30	60	4	0	0
851	378	0	1	30	60	1	0	0
851	368	2	1	24	60	5	0	0
851	385	0	0	25	60	2	0	0
851	314	2	0	42	60	0	0	0
851	17	0	0	33	60	1	0	0
851	96	2	1	40	60	3	0	0
851	85	0	0	23	60	2	0	0
852	209	0	1	24	60	4	0	0
852	276	1	1	36	60	2	1	0
852	496	2	1	37	60	0	0	0
852	164	0	1	28	60	1	0	0
852	310	0	0	47	60	3	1	0
852	129	2	0	43	60	4	0	0
852	445	2	1	39	60	3	0	0
852	229	2	1	48	60	5	1	0
853	220	2	0	33	60	0	0	0
853	401	0	0	23	60	2	1	0
853	472	2	0	20	60	5	0	0
853	269	2	0	30	60	3	1	0
853	178	1	1	29	60	5	0	0
853	36	1	1	48	60	3	0	0
853	43	1	1	35	60	4	0	0
853	84	2	0	34	60	0	0	0
854	224	2	1	27	60	4	0	0
854	454	1	1	26	60	5	0	0
854	52	2	1	41	60	4	1	0
854	473	0	1	35	60	1	0	0
854	294	1	0	32	60	0	0	0
854	17	1	1	22	60	1	0	0
854	383	0	1	40	60	3	0	0
854	54	1	0	45	60	5	0	0
855	39	2	0	23	60	0	0	0
855	309	2	1	36	60	2	1	0
855	329	1	0	33	60	2	1	0
855	458	0	0	33	60	5	1	0
855	83	1	1	29	60	3	0	0
855	298	2	0	43	60	2	0	0
855	197	1	1	34	60	0	0	0
855	457	2	0	31	60	3	1	0
856	45	1	0	27	60	4	0	0
856	231	1	0	32	60	5	0	0
856	3	1	0	35	60	2	0	0
856	56	0	1	35	60	0	0	0
856	196	2	1	46	60	2	0	0
856	187	2	1	46	60	5	0	0
856	105	1	0	35	60	3	0	0
856	95	2	1	41	60	4	1	0
857	377	1	1	27	60	1	0	0
857	85	0	0	40	60	2	0	0
857	203	2	0	31	60	4	0	0
857	2	1	0	33	60	4	1	0
857	204	1	0	32	60	2	0	0
857	215	2	1	21	60	0	0	0
857	147	0	0	37	60	5	0	0
857	283	0	1	49	60	0	0	0
858	139	0	0	21	60	4	0	0
858	10	2	1	33	60	1	1	0
858	70	1	1	37	60	0	0	0
858	88	2	1	35	60	0	1	0
858	111	2	0	30	60	5	0	0
858	163	1	0	45	60	4	0	0
858	141	1	1	32	60	2	1	0
858	73	0	1	47	60	3	0	0
859	409	1	0	38	60	0	1	0
859	336	1	1	25	60	1	1	0
859	47	1	0	41	60	5	0	0
859	366	2	0	48	60	5	0	0
859	70	2	1	20	60	1	0	0
859	475	0	0	41	60	2	1	0
859	171	0	1	40	60	5	0	0
859	7	1	1	24	60	4	1	0
860	150	0	1	49	60	1	0	0
860	45	0	0	21	60	3	0	0
860	493	1	1	30	60	2	1	0
860	496	2	1	39	60	1	0	0
860	39	0	0	41	60	5	1	0
860	470	0	1	38	60	4	0	0
860	291	1	0	26	60	5	0	0
860	84	2	1	35	60	0	1	0
861	285	2	0	29	60	1	0	0
861	112	2	0	35	60	3	0	0
861	421	0	1	42	60	5	0	0
861	106	2	0	27	60	1	0	0
861	342	0	0	41	60	0	1	0
861	221	2	1	38	60	5	1	0
861	435	0	1	45	60	2	1	0
861	478	1	1	31	60	5	1	0
862	24	0	0	20	60	0	0	0
862	75	0	1	43	60	5	1	0
862	333	2	1	49	60	3	0	0
862	99	0	1	20	60	0	0	0
862	253	2	1	20	60	5	0	0
862	151	0	0	50	60	5	0	0
862	339	0	0	30	60	4	0	0
862	397	0	1	44	60	4	0	0
863	353	0	0	47	60	5	0	0
863	400	0	1	30	60	0	0	0
863	265	1	1	49	60	0	0	0
863	330	2	0	33	60	1	0	0
863	409	0	1	23	60	1	0	0
863	212	0	0	47	60	5	0	0
863	413	2	1	49	60	2	0	0
863	346	2	1	36	60	5	1	0
864	149	1	1	25	60	1	0	0
864	160	2	0	37	60	3	1	0
864	301	2	0	37	60	1	0	0
864	154	2	1	44	60	5	1	0
864	278	2	1	33	60	1	0	0
864	135	2	0	35	60	2	0	0
864	461	0	1	36	60	2	0	0
864	14	0	1	38	60	3	0	0
865	304	0	0	31	60	5	0	0
865	475	0	0	45	60	4	1	0
865	293	0	0	24	60	3	0	0
865	184	0	1	39	60	3	0	0
865	260	0	0	28	60	1	0	0
865	136	2	0	38	60	0	0	0
865	443	0	1	41	60	3	0	0
865	374	2	0	24	60	5	0	0
866	108	2	1	36	60	0	1	0
866	403	0	0	27	60	0	0	0
866	75	0	0	21	60	2	0	0
866	334	1	0	26	60	5	0	0
866	25	1	0	22	60	3	1	0
866	173	0	0	44	60	1	0	0
866	187	1	1	26	60	3	0	0
866	140	0	0	28	60	0	0	0
867	284	1	0	50	60	1	0	0
867	25	0	0	43	60	0	0	0
867	38	2	1	22	60	0	0	0
867	313	0	0	40	60	0	0	0
867	165	2	1	40	60	2	0	0
867	14	2	1	24	60	4	0	0
867	220	2	1	34	60	5	0	0
867	281	2	1	23	60	1	0	0
868	400	0	1	47	60	4	0	0
868	305	1	1	38	60	0	1	0
868	159	1	1	24	60	1	0	0
868	164	1	1	36	60	0	0	0
868	259	0	1	20	60	5	0	0
868	221	0	1	22	60	2	0	0
868	22	2	0	20	60	4	0	0
868	166	1	1	22	60	4	0	0
869	441	2	0	49	60	0	0	0
869	46	1	1	21	60	2	0	0
869	241	1	0	22	60	0	0	0
869	157	1	0	24	60	1	1	0
869	364	2	0	36	60	1	1	0
869	297	1	1	28	60	5	0	0
869	313	2	0	41	60	1	0	0
869	231	2	0	42	60	3	1	0
870	348	0	0	29	60	3	1	0
870	469	0	1	36	60	0	1	0
870	301	0	0	38	60	0	0	0
870	429	0	0	36	60	5	1	0
870	38	1	1	30	60	1	0	0
870	419	1	1	25	60	4	0	0
870	270	2	1	38	60	0	0	0
870	402	1	0	40	60	5	1	0
871	99	1	0	24	60	4	0	0
871	143	1	0	32	60	5	0	0
871	2	2	1	49	60	3	1	0
871	219	2	0	43	60	2	0	0
871	126	0	1	34	60	3	0	0
871	279	0	1	36	60	1	0	0
871	131	0	0	29	60	4	1	0
871	389	0	1	46	60	0	0	0
872	412	2	0	24	60	0	0	0
872	259	1	0	50	60	2	0	0
872	385	0	0	41	60	4	0	0
872	206	1	0	23	60	2	0	0
872	196	1	1	38	60	5	1	0
872	213	1	0	34	60	2	0	0
872	115	1	0	21	60	5	0	0
872	140	1	1	38	60	5	0	0
873	347	2	0	26	60	4	0	0
873	370	1	1	32	60	3	0	0
873	408	2	1	28	60	4	0	0
873	303	1	0	24	60	2	0	0
873	471	2	0	45	60	5	0	0
873	219	2	0	37	60	0	1	0
873	214	1	1	23	60	0	0	0
873	468	1	0	39	60	3	0	0
874	88	2	0	21	60	5	1	0
874	292	0	1	27	60	3	0	0
874	468	0	0	21	60	2	0	0
874	220	0	1	38	60	0	0	0
874	49	1	1	25	60	3	0	0
874	398	0	0	22	60	5	0	0
874	279	1	0	49	60	2	1	0
874	403	0	1	48	60	0	0	0
875	50	2	0	47	60	0	1	0
875	29	2	0	23	60	5	0	0
875	163	0	1	43	60	5	0	0
875	305	0	0	32	60	0	0	0
875	295	2	1	43	60	0	0	0
875	84	0	1	29	60	3	1	0
875	379	0	0	39	60	4	1	0
875	455	1	1	39	60	1	0	0
876	18	0	0	45	60	3	0	0
876	459	1	0	41	60	3	0	0
876	195	1	0	29	60	0	0	0
876	99	2	0	30	60	4	1	0
876	122	1	1	42	60	3	0	0
876	499	1	1	20	60	0	0	0
876	90	1	1	39	60	1	0	0
876	412	1	1	32	60	0	0	0
877	205	0	1	44	60	3	0	0
877	408	2	0	49	60	3	0	0
877	141	0	0	30	60	4	0	0
877	99	1	0	20	60	4	0	0
877	386	1	1	44	60	1	0	0
877	419	2	0	33	60	0	0	0
877	400	2	1	27	60	3	0	0
877	139	1	0	20	60	1	1	0
878	27	0	0	31	60	4	0	0
878	249	0	1	25	60	5	0	0
878	22	1	1	26	60	4	0	0
878	32	2	1	28	60	5	0	0
878	46	2	1	38	60	1	1	0
878	44	1	1	50	60	0	0	0
878	405	0	1	44	60	4	0	0
878	408	0	0	49	60	3	0	0
879	25	0	0	43	60	3	0	0
879	414	2	0	36	60	0	0	0
879	455	2	0	23	60	2	1	0
879	289	0	0	29	60	0	0	0
879	132	1	0	32	60	3	0	0
879	277	1	1	28	60	1	0	0
879	291	1	1	22	60	0	0	0
879	200	0	0	38	60	4	0	0
880	169	1	0	24	60	4	0	0
880	237	2	1	30	60	3	0	0
880	415	0	1	42	60	2	0	0
880	40	2	1	36	60	0	0	0
880	172	0	0	40	60	4	0	0
880	404	2	1	36	60	3	0	0
880	117	0	0	34	60	1	0	0
880	431	0	0	49	60	5	1	0
881	462	0	0	22	60	1	0	0
881	490	1	1	20	60	4	0	0
881	358	0	0	29	60	3	0	0
881	359	2	1	34	60	5	1	0
881	189	2	1	41	60	1	0	0
881	123	1	0	42	60	2	0	0
881	248	0	1	47	60	4	1	0
881	142	2	0	38	60	5	0	0
882	164	0	0	20	60	4	1	0
882	251	1	1	30	60	2	0	0
882	332	0	0	25	60	4	1	0
882	419	2	0	21	60	4	0	0
882	71	0	0	24	60	5	1	0
882	89	2	0	21	60	2	0	0
882	20	0	1	25	60	0	0	0
882	246	2	0	43	60	4	1	0
883	55	0	0	20	60	4	0	0
883	86	2	0	29	60	0	1	0
883	242	2	0	40	60	2	0	0
883	76	1	0	28	60	5	0	0
883	472	2	0	24	60	5	0	0
883	335	0	0	44	60	0	1	0
883	492	0	0	47	60	4	1	0
883	155	2	1	39	60	1	1	0
884	328	0	1	28	60	5	1	0
884	283	0	1	40	60	2	0	0
884	37	0	1	45	60	0	0	0
884	176	1	1	31	60	4	0	0
884	376	0	1	35	60	2	0	0
884	281	0	1	48	60	2	0	0
884	96	2	1	34	60	3	0	0
884	145	0	0	22	60	0	0	0
885	319	0	0	33	60	0	0	0
885	254	1	1	41	60	0	0	0
885	69	1	1	27	60	4	0	0
885	408	1	0	20	60	3	0	0
885	310	1	1	34	60	0	0	0
885	420	2	0	44	60	1	0	0
885	122	2	1	29	60	3	0	0
885	188	1	0	36	60	3	1	0
886	484	1	1	25	60	0	1	0
886	319	2	1	24	60	2	0	0
886	479	1	1	34	60	5	0	0
886	114	2	0	21	60	2	0	0
886	120	2	0	46	60	4	0	0
886	197	0	0	36	60	4	1	0
886	448	2	1	26	60	4	1	0
886	258	0	1	23	60	0	0	0
887	478	1	0	23	60	1	1	0
887	189	1	1	27	60	4	0	0
887	129	1	0	45	60	5	1	0
887	476	0	1	35	60	4	0	0
887	462	2	0	20	60	5	0	0
887	138	2	1	31	60	0	1	0
887	448	2	1	40	60	5	0	0
887	407	2	0	48	60	3	1	0
888	387	2	0	35	60	3	0	0
888	398	2	0	34	60	5	0	0
888	372	2	0	29	60	4	0	0
888	308	0	1	24	60	3	0	0
888	55	0	1	38	60	0	1	0
888	209	1	0	33	60	0	0	0
888	269	0	0	30	60	0	0	0
888	491	1	0	42	60	0	0	0
889	87	0	1	29	60	4	1	0
889	480	0	0	20	60	1	0	0
889	433	0	0	28	60	5	0	0
889	402	1	1	23	60	1	0	0
889	48	2	1	32	60	5	0	0
889	163	0	0	36	60	5	1	0
889	113	0	0	45	60	4	0	0
889	380	1	1	38	60	2	0	0
890	369	0	1	36	60	5	1	0
890	207	0	1	30	60	0	0	0
890	182	1	0	48	60	2	0	0
890	105	2	0	29	60	2	0	0
890	470	0	0	24	60	3	1	0
890	125	2	1	43	60	5	0	0
890	362	2	0	39	60	4	1	0
890	367	1	0	34	60	2	1	0
891	385	0	1	43	60	4	0	0
891	189	2	0	23	60	1	1	0
891	55	2	0	38	60	3	0	0
891	180	0	1	45	60	3	0	0
891	329	0	0	38	60	3	0	0
891	402	1	1	27	60	0	0	0
891	125	2	0	32	60	5	1	0
891	44	0	1	38	60	4	0	0
892	54	2	0	43	60	2	0	0
892	449	2	1	24	60	2	0	0
892	276	1	0	40	60	1	0	0
892	377	0	0	24	60	0	0	0
892	46	0	0	40	60	2	1	0
892	334	2	0	30	60	0	0	0
892	146	2	1	23	60	4	0	0
892	298	1	1	40	60	3	0	0
893	377	1	1	37	60	1	1	0
893	96	0	1	50	60	2	0	0
893	166	0	1	45	60	2	0	0
893	360	0	0	26	60	2	1	0
893	102	1	0	39	60	2	0	0
893	373	1	0	28	60	0	1	0
893	194	1	1	25	60	5	0	0
893	28	2	1	37	60	0	1	0
894	79	2	0	44	60	5	0	0
894	69	1	1	24	60	3	0	0
894	263	1	1	23	60	0	0	0
894	237	1	0	27	60	2	0	0
894	12	1	1	34	60	1	1	0
894	308	0	0	23	60	0	1	0
894	169	2	1	32	60	4	0	0
894	499	0	0	45	60	5	0	0
895	231	2	1	45	60	2	0	0
895	474	2	1	37	60	0	0	0
895	219	0	1	41	60	1	0	0
895	124	1	1	41	60	5	0	0
895	486	0	1	30	60	3	0	0
895	336	1	1	20	60	1	1	0
895	403	1	0	44	60	5	0	0
895	89	2	1	47	60	1	0	0
896	67	0	0	41	60	3	0	0
896	130	2	1	32	60	2	0	0
896	461	0	1	31	60	1	0	0
896	171	2	0	47	60	3	0	0
896	12	1	0	31	60	2	0	0
896	284	2	1	50	60	0	0	0
896	473	1	1	38	60	4	0	0
896	254	0	0	35	60	4	0	0
897	136	0	0	28	60	1	0	0
897	293	2	1	39	60	3	0	0
897	454	1	0	41	60	0	1	0
897	382	0	0	46	60	0	0	0
897	134	2	0	40	60	4	1	0
897	405	0	1	31	60	4	0	0
897	188	0	0	26	60	5	0	0
897	379	0	1	39	60	4	1	0
898	353	1	1	40	60	5	0	0
898	73	2	0	25	60	4	0	0
898	110	1	0	50	60	5	1	0
898	40	0	1	29	60	5	0	0
898	252	1	0	31	60	5	0	0
898	369	0	0	26	60	2	0	0
898	404	2	1	21	60	3	0	0
898	492	1	0	50	60	3	1	0
899	60	0	0	43	60	3	0	0
899	176	2	1	29	60	1	0	0
899	233	2	0	46	60	4	1	0
899	158	2	1	31	60	3	1	0
899	432	1	1	33	60	1	1	0
899	450	1	0	47	60	4	0	0
899	371	1	0	47	60	0	0	0
899	387	1	1	41	60	3	0	0
900	177	2	1	29	60	2	1	0
900	410	0	1	41	60	5	0	0
900	338	0	1	21	60	0	1	0
900	152	1	1	42	60	0	1	0
900	316	2	0	35	60	4	1	0
900	286	2	1	21	60	0	0	0
900	335	2	1	26	60	3	1	0
900	180	2	0	37	60	1	0	0
901	272	2	0	29	60	2	0	0
901	153	0	0	36	60	0	0	0
901	68	2	0	38	60	4	0	0
901	391	2	1	50	60	4	0	0
901	76	1	1	20	60	4	0	0
901	474	2	0	27	60	2	1	0
901	344	0	1	44	60	3	0	0
901	14	0	0	41	60	5	0	0
902	171	1	0	36	60	5	0	0
902	469	1	0	22	60	5	0	0
902	292	0	0	25	60	2	0	0
902	125	1	1	34	60	0	0	0
902	134	2	1	38	60	2	0	0
902	10	2	1	29	60	3	0	0
902	268	1	1	29	60	4	0	0
902	439	1	0	24	60	0	0	0
903	84	2	1	22	60	3	0	0
903	190	1	1	39	60	3	0	0
903	221	2	0	48	60	1	0	0
903	189	1	1	35	60	3	1	0
903	277	2	1	50	60	4	0	0
903	148	0	0	43	60	4	0	0
903	440	2	0	31	60	2	1	0
903	175	1	1	41	60	2	0	0
904	290	0	0	27	60	4	0	0
904	387	2	0	22	60	2	0	0
904	462	1	0	49	60	2	0	0
904	254	0	0	39	60	3	0	0
904	455	2	0	41	60	1	0	0
904	437	0	0	33	60	3	0	0
904	428	2	1	27	60	3	0	0
904	366	0	1	50	60	5	0	0
905	321	2	1	24	60	4	0	0
905	391	1	0	49	60	3	0	0
905	252	0	0	29	60	3	0	0
905	457	0	1	28	60	2	1	0
905	183	1	0	29	60	2	0	0
905	316	1	1	32	60	2	0	0
905	192	1	1	48	60	2	0	0
905	30	1	0	47	60	1	0	0
906	419	0	1	32	60	4	0	0
906	250	0	1	34	60	0	1	0
906	231	2	1	45	60	2	0	0
906	421	0	0	31	60	1	0	0
906	278	0	1	31	60	4	0	0
906	69	1	1	25	60	3	1	0
906	311	1	0	34	60	2	1	0
906	336	0	0	49	60	4	0	0
907	436	2	1	27	60	2	0	0
907	33	2	0	29	60	0	1	0
907	496	0	1	22	60	5	1	0
907	211	2	0	37	60	5	0	0
907	473	1	0	31	60	2	0	0
907	166	2	1	36	60	0	0	0
907	160	0	0	32	60	4	0	0
907	460	2	0	36	60	5	0	0
908	75	2	1	42	60	3	0	0
908	434	2	0	32	60	0	0	0
908	52	0	0	36	60	2	0	0
908	387	1	0	23	60	3	0	0
908	358	0	1	46	60	3	0	0
908	169	0	0	26	60	0	1	0
908	178	1	0	46	60	4	0	0
908	314	2	1	41	60	4	0	0
909	395	1	1	29	60	2	0	0
909	471	0	1	27	60	1	1	0
909	475	0	0	46	60	4	0	0
909	23	1	1	44	60	4	0	0
909	71	2	0	42	60	1	0	0
909	481	1	0	23	60	1	0	0
909	307	1	1	40	60	2	0	0
909	177	1	1	28	60	0	0	0
910	446	1	1	31	60	4	1	0
910	278	0	0	42	60	2	1	0
910	129	1	0	29	60	0	0	0
910	91	1	0	27	60	4	1	0
910	47	0	1	41	60	1	0	0
910	81	2	0	25	60	2	1	0
910	185	2	1	45	60	0	0	0
910	64	1	0	26	60	5	0	0
911	267	1	0	29	60	4	1	0
911	49	1	0	36	60	1	0	0
911	264	2	0	37	60	4	1	0
911	30	2	1	35	60	3	0	0
911	363	1	1	26	60	3	0	0
911	43	2	1	48	60	2	1	0
911	82	2	0	33	60	4	1	0
911	421	1	0	30	60	3	0	0
912	158	0	0	23	60	5	0	0
912	32	1	0	20	60	2	0	0
912	146	2	0	27	60	2	0	0
912	345	1	1	44	60	5	0	0
912	395	0	0	39	60	0	0	0
912	2	2	0	29	60	4	1	0
912	275	2	0	31	60	1	1	0
912	30	2	1	37	60	3	0	0
913	264	2	1	49	60	1	0	0
913	208	1	1	35	60	5	0	0
913	357	2	0	48	60	2	0	0
913	10	2	0	39	60	3	1	0
913	164	0	1	48	60	3	0	0
913	250	2	1	50	60	0	1	0
913	276	2	0	32	60	0	0	0
913	240	2	1	49	60	0	0	0
914	406	2	1	27	60	3	0	0
914	250	0	1	20	60	2	0	0
914	366	1	0	44	60	1	0	0
914	123	0	1	33	60	2	0	0
914	263	0	1	32	60	5	1	0
914	280	2	1	50	60	4	0	0
914	482	2	0	25	60	5	1	0
914	154	1	1	42	60	4	0	0
915	416	2	1	31	60	5	1	0
915	128	1	1	46	60	3	1	0
915	410	2	0	33	60	5	0	0
915	152	2	1	43	60	4	1	0
915	122	0	0	26	60	1	0	0
915	109	2	1	32	60	4	0	0
915	115	0	1	30	60	2	0	0
915	5	2	1	49	60	4	0	0
916	130	0	1	37	60	0	1	0
916	169	1	0	33	60	3	0	0
916	205	0	0	29	60	4	0	0
916	457	2	0	39	60	0	0	0
916	60	1	0	38	60	5	0	0
916	109	2	1	36	60	1	1	0
916	163	0	1	26	60	4	0	0
916	271	1	1	22	60	4	0	0
917	466	0	1	36	60	1	0	0
917	316	0	0	43	60	2	0	0
917	255	1	0	46	60	1	0	0
917	372	2	0	32	60	2	1	0
917	68	1	1	35	60	2	0	0
917	188	0	0	34	60	2	1	0
917	230	0	1	36	60	4	0	0
917	117	2	0	37	60	2	0	0
918	399	2	1	42	60	2	0	0
918	292	0	1	24	60	3	0	0
918	407	2	0	27	60	2	0	0
918	76	1	0	41	60	3	1	0
918	118	1	1	27	60	3	0	0
918	395	1	1	48	60	0	1	0
918	343	2	1	30	60	2	0	0
918	144	2	1	25	60	2	0	0
919	338	2	0	33	60	0	1	0
919	125	2	1	27	60	2	0	0
919	216	2	1	35	60	3	0	0
919	412	0	1	38	60	2	1	0
919	33	0	0	47	60	1	0	0
919	268	0	1	22	60	4	0	0
919	54	1	0	42	60	5	1	0
919	16	2	0	35	60	4	1	0
920	427	0	1	41	60	0	1	0
920	20	2	1	31	60	0	0	0
920	373	2	0	36	60	4	0	0
920	128	1	1	49	60	0	0	0
920	256	2	0	20	60	4	0	0
920	280	1	0	28	60	3	0	0
920	59	2	0	41	60	4	1	0
920	420	2	1	32	60	4	1	0
921	125	0	0	21	60	0	0	0
921	278	0	0	25	60	1	1	0
921	296	1	1	41	60	0	0	0
921	247	2	1	32	60	3	0	0
921	435	1	1	49	60	2	0	0
921	382	2	1	24	60	2	0	0
921	271	1	0	48	60	3	1	0
921	25	1	0	38	60	3	1	0
922	130	2	0	47	60	1	0	0
922	359	0	1	33	60	5	0	0
922	161	2	1	31	60	3	0	0
922	275	1	1	20	60	1	0	0
922	157	0	1	36	60	2	0	0
922	255	0	1	42	60	0	0	0
922	149	2	1	26	60	3	0	0
922	435	1	1	25	60	4	0	0
923	321	0	0	43	60	4	1	0
923	332	1	0	38	60	1	0	0
923	469	1	0	44	60	4	1	0
923	228	0	1	30	60	5	0	0
923	483	0	1	30	60	1	0	0
923	32	1	1	46	60	0	0	0
923	287	1	0	42	60	0	1	0
923	16	0	1	38	60	1	0	0
924	89	2	1	40	60	2	1	0
924	216	2	1	42	60	4	0	0
924	386	0	0	40	60	2	1	0
924	445	2	0	48	60	5	1	0
924	32	2	0	36	60	2	0	0
924	37	2	0	48	60	4	0	0
924	177	0	1	28	60	1	1	0
924	41	0	1	40	60	1	0	0
925	143	0	0	30	60	2	0	0
925	473	1	0	27	60	4	0	0
925	285	0	0	20	60	0	0	0
925	302	2	0	36	60	1	0	0
925	103	2	0	34	60	2	0	0
925	68	0	0	44	60	0	1	0
925	392	1	1	46	60	2	0	0
925	98	0	0	26	60	1	0	0
926	436	2	1	29	60	1	0	0
926	279	0	1	38	60	0	0	0
926	446	0	1	45	60	4	0	0
926	28	1	0	27	60	5	0	0
926	41	2	1	39	60	1	0	0
926	453	0	0	45	60	1	0	0
926	240	2	0	43	60	2	0	0
926	123	2	0	34	60	3	0	0
927	350	0	0	48	60	1	1	0
927	202	1	1	38	60	2	0	0
927	65	1	0	39	60	5	1	0
927	140	0	0	49	60	5	0	0
927	296	0	1	38	60	3	0	0
927	306	2	1	24	60	5	0	0
927	483	2	1	44	60	5	0	0
927	325	1	1	42	60	3	1	0
928	358	0	1	26	60	1	1	0
928	70	1	0	42	60	1	0	0
928	232	1	1	45	60	0	1	0
928	434	0	1	39	60	0	0	0
928	49	0	0	25	60	4	0	0
928	280	1	1	36	60	1	0	0
928	359	0	1	40	60	4	1	0
928	494	0	0	29	60	4	0	0
929	299	1	1	25	60	3	0	0
929	418	0	0	46	60	0	0	0
929	177	1	1	36	60	2	0	0
929	143	1	1	30	60	3	1	0
929	410	2	0	34	60	4	1	0
929	120	1	0	42	60	4	0	0
929	138	2	0	41	60	1	0	0
929	373	2	1	38	60	1	0	0
930	265	1	0	41	60	2	0	0
930	173	0	1	23	60	1	0	0
930	92	0	1	29	60	3	0	0
930	451	0	0	48	60	2	0	0
930	481	2	0	27	60	4	0	0
930	427	1	1	23	60	4	0	0
930	153	0	0	47	60	2	0	0
930	457	2	0	45	60	3	0	0
931	487	2	0	23	60	4	1	0
931	15	2	1	33	60	3	0	0
931	451	2	0	34	60	0	0	0
931	25	1	0	50	60	4	0	0
931	192	0	1	23	60	0	0	0
931	69	1	0	43	60	3	1	0
931	268	2	1	35	60	4	1	0
931	26	2	1	48	60	4	0	0
932	94	0	0	43	60	5	0	0
932	459	0	0	24	60	1	0	0
932	203	0	1	46	60	5	0	0
932	231	0	1	27	60	3	0	0
932	311	2	1	47	60	0	0	0
932	460	2	0	44	60	2	0	0
932	378	2	0	33	60	3	0	0
932	150	2	1	41	60	0	0	0
933	294	1	0	47	60	0	0	0
933	399	1	1	40	60	3	1	0
933	142	1	1	28	60	2	0	0
933	342	0	1	50	60	4	0	0
933	234	1	0	34	60	0	0	0
933	149	2	1	35	60	2	0	0
933	303	2	0	35	60	5	0	0
933	362	0	1	24	60	2	0	0
934	37	2	1	37	60	1	0	0
934	289	2	0	41	60	2	0	0
934	298	0	1	35	60	0	0	0
934	327	1	1	48	60	2	0	0
934	468	2	0	31	60	3	1	0
934	232	2	0	20	60	4	1	0
934	194	2	1	36	60	1	0	0
934	19	2	1	48	60	5	0	0
935	62	1	1	43	60	0	0	0
935	470	2	0	48	60	5	1	0
935	209	1	1	44	60	4	0	0
935	169	2	1	26	60	3	0	0
935	3	2	0	43	60	1	0	0
935	387	0	0	42	60	3	1	0
935	104	2	1	50	60	4	0	0
935	278	1	1	45	60	1	0	0
936	330	1	1	43	60	3	0	0
936	482	1	0	45	60	2	1	0
936	376	1	1	41	60	2	0	0
936	199	2	1	33	60	3	1	0
936	388	1	0	26	60	1	0	0
936	200	0	1	36	60	2	1	0
936	393	1	1	37	60	2	0	0
936	30	2	0	50	60	1	0	0
937	300	1	0	37	60	5	0	0
937	346	1	0	23	60	0	0	0
937	320	2	1	49	60	0	0	0
937	242	0	0	23	60	3	0	0
937	199	2	0	39	60	3	0	0
937	350	1	0	35	60	4	0	0
937	108	1	0	34	60	1	1	0
937	229	2	0	27	60	2	1	0
938	464	0	0	25	60	3	0	0
938	275	1	0	49	60	1	1	0
938	479	0	1	22	60	1	0	0
938	406	1	1	33	60	4	0	0
938	426	0	0	31	60	0	0	0
938	398	2	1	20	60	3	1	0
938	360	0	0	23	60	2	0	0
938	385	0	0	26	60	0	0	0
939	303	0	0	47	60	3	1	0
939	87	1	0	43	60	4	0	0
939	138	0	1	50	60	0	0	0
939	109	1	1	41	60	0	0	0
939	147	1	1	37	60	4	0	0
939	280	1	0	22	60	1	0	0
939	80	2	1	26	60	2	0	0
939	18	2	0	25	60	2	0	0
940	118	2	1	36	60	2	0	0
940	192	0	1	24	60	2	0	0
940	246	2	0	34	60	4	0	0
940	202	2	1	45	60	4	0	0
940	218	1	0	27	60	1	0	0
940	64	1	0	35	60	1	0	0
940	198	0	1	33	60	5	1	0
940	326	2	0	30	60	1	0	0
941	426	2	1	38	60	0	0	0
941	106	0	1	48	60	3	0	0
941	271	2	0	43	60	3	0	0
941	461	1	0	49	60	1	0	0
941	482	2	1	43	60	4	0	0
941	84	2	1	50	60	4	0	0
941	21	1	1	29	60	0	0	0
941	146	0	1	26	60	2	0	0
942	121	2	0	34	60	4	0	0
942	315	2	1	43	60	2	1	0
942	257	1	0	24	60	5	0	0
942	425	2	1	25	60	2	0	0
942	357	2	1	27	60	3	0	0
942	126	0	0	21	60	5	1	0
942	374	0	1	33	60	2	0	0
942	51	2	0	33	60	5	0	0
943	373	1	0	39	60	5	0	0
943	123	2	1	30	60	1	0	0
943	493	2	0	27	60	5	1	0
943	415	2	0	50	60	2	0	0
943	23	0	0	35	60	2	0	0
943	169	0	1	34	60	0	1	0
943	386	1	1	28	60	0	0	0
943	353	2	1	23	60	0	1	0
944	153	1	0	33	60	4	0	0
944	61	2	0	30	60	4	0	0
944	439	1	0	23	60	5	0	0
944	165	0	1	27	60	2	0	0
944	268	1	1	33	60	0	0	0
944	5	1	0	49	60	2	0	0
944	481	1	1	31	60	0	0	0
944	110	2	1	22	60	0	0	0
945	244	1	0	39	60	0	0	0
945	351	1	1	38	60	0	0	0
945	54	2	1	31	60	2	1	0
945	163	1	0	23	60	2	0	0
945	352	1	0	31	60	3	0	0
945	42	0	0	28	60	3	0	0
945	142	2	0	30	60	0	0	0
945	11	1	1	50	60	2	1	0
946	173	2	0	49	60	1	0	0
946	161	0	0	23	60	2	1	0
946	484	1	1	22	60	3	1	0
946	156	1	0	23	60	5	0	0
946	207	2	0	24	60	2	0	0
946	148	1	1	35	60	3	1	0
946	126	1	0	24	60	2	0	0
946	24	2	1	29	60	0	0	0
947	54	2	0	43	60	3	0	0
947	493	1	1	46	60	2	0	0
947	124	0	1	25	60	0	0	0
947	164	2	0	34	60	2	0	0
947	327	0	0	30	60	5	0	0
947	416	2	1	32	60	2	0	0
947	33	2	1	27	60	0	0	0
947	412	2	0	41	60	1	0	0
948	194	2	0	21	60	3	0	0
948	367	2	0	50	60	0	0	0
948	428	0	1	38	60	4	0	0
948	400	0	1	28	60	4	0	0
948	253	0	0	28	60	0	1	0
948	341	0	0	47	60	0	1	0
948	140	2	1	32	60	3	0	0
948	199	2	0	25	60	1	0	0
949	52	1	0	48	60	2	1	0
949	190	2	1	36	60	5	1	0
949	175	1	1	44	60	5	1	0
949	209	0	1	45	60	4	0	0
949	335	2	1	43	60	2	1	0
949	443	2	0	22	60	1	0	0
949	236	1	0	21	60	3	1	0
949	46	1	0	40	60	4	1	0
950	154	2	1	25	60	1	0	0
950	238	2	1	22	60	0	0	0
950	30	0	1	30	60	4	0	0
950	117	2	1	48	60	2	1	0
950	388	2	0	39	60	1	0	0
950	375	1	1	41	60	2	0	0
950	185	2	1	20	60	1	0	0
950	496	2	1	46	60	0	0	0
951	3	2	1	37	60	1	1	0
951	122	2	1	26	60	0	1	0
951	484	0	0	35	60	5	1	0
951	15	0	0	38	60	4	0	0
951	67	2	0	47	60	1	0	0
951	4	2	0	36	60	1	0	0
951	157	1	1	36	60	5	0	0
951	137	2	0	23	60	1	0	0
952	75	1	0	50	60	2	1	0
952	276	0	1	42	60	3	0	0
952	60	0	0	33	60	5	1	0
952	339	1	1	44	60	3	1	0
952	190	2	1	46	60	5	0	0
952	260	0	0	46	60	4	0	0
952	233	0	1	43	60	4	1	0
952	256	0	0	25	60	3	0	0
953	208	2	1	39	60	5	0	0
953	320	1	1	33	60	3	0	0
953	75	1	0	31	60	2	0	0
953	192	1	0	32	60	3	1	0
953	29	0	0	41	60	3	0	0
953	86	2	0	41	60	1	0	0
953	18	1	0	37	60	5	0	0
953	90	1	0	22	60	1	1	0
954	27	2	0	34	60	0	1	0
954	167	2	0	31	60	1	0	0
954	416	1	0	47	60	3	0	0
954	450	2	1	41	60	4	0	0
954	308	1	1	48	60	4	1	0
954	343	1	0	45	60	3	0	0
954	477	1	1	29	60	1	0	0
954	126	2	1	29	60	3	1	0
955	294	0	0	46	60	4	0	0
955	497	2	0	39	60	2	0	0
955	359	1	1	21	60	3	0	0
955	452	2	0	25	60	3	0	0
955	249	0	1	27	60	4	0	0
955	469	0	1	24	60	0	0	0
955	387	2	0	26	60	1	0	0
955	52	2	0	33	60	5	0	0
956	400	2	1	39	60	3	0	0
956	433	1	0	47	60	1	1	0
956	406	1	0	28	60	0	0	0
956	174	0	0	45	60	5	0	0
956	62	0	0	49	60	0	0	0
956	190	2	1	40	60	0	0	0
956	178	2	0	49	60	2	0	0
956	197	1	0	21	60	0	0	0
957	51	0	0	48	60	1	0	0
957	201	0	0	21	60	1	0	0
957	1	0	0	22	60	5	0	0
957	94	2	0	36	60	5	1	0
957	122	2	1	36	60	1	0	0
957	467	0	0	43	60	0	0	0
957	48	2	1	41	60	0	1	0
957	466	2	0	37	60	2	0	0
958	194	2	0	34	60	5	0	0
958	169	1	1	50	60	2	0	0
958	147	0	1	48	60	5	0	0
958	465	2	0	49	60	0	0	0
958	346	1	0	21	60	5	0	0
958	266	2	0	23	60	1	0	0
958	35	0	1	45	60	5	0	0
958	60	2	0	42	60	0	0	0
959	181	1	1	49	60	5	0	0
959	232	0	0	42	60	0	0	0
959	56	2	1	50	60	2	0	0
959	100	1	1	42	60	0	0	0
959	182	2	1	50	60	5	0	0
959	332	0	0	49	60	2	0	0
959	292	1	0	23	60	1	0	0
959	299	0	0	48	60	2	1	0
960	185	0	0	48	60	0	1	0
960	116	0	1	49	60	2	1	0
960	131	2	0	27	60	0	0	0
960	488	1	1	36	60	1	0	0
960	172	1	1	31	60	4	1	0
960	290	0	1	33	60	4	0	0
960	168	2	0	38	60	5	1	0
960	256	0	1	25	60	2	0	0
961	223	2	0	27	60	4	0	0
961	324	1	0	45	60	2	1	0
961	95	0	0	27	60	5	1	0
961	70	2	1	24	60	3	0	0
961	490	1	1	49	60	3	1	0
961	179	1	0	38	60	4	0	0
961	465	2	0	36	60	5	1	0
961	362	1	0	50	60	0	0	0
962	93	2	0	47	60	3	0	0
962	77	1	0	41	60	0	0	0
962	25	1	0	23	60	0	1	0
962	324	2	0	26	60	3	1	0
962	46	0	0	29	60	5	0	0
962	126	1	1	20	60	5	0	0
962	157	2	0	35	60	4	1	0
962	352	0	1	32	60	2	0	0
963	388	1	0	37	60	5	1	0
963	295	1	0	41	60	5	0	0
963	118	2	0	36	60	1	1	0
963	13	2	0	46	60	0	1	0
963	217	1	1	31	60	2	0	0
963	34	0	0	30	60	5	1	0
963	383	1	1	21	60	3	1	0
963	155	0	1	27	60	0	1	0
964	220	1	0	40	60	4	0	0
964	5	2	0	23	60	5	0	0
964	108	2	0	50	60	1	1	0
964	464	2	0	22	60	0	1	0
964	370	1	0	38	60	1	0	0
964	92	1	0	37	60	1	0	0
964	199	2	1	42	60	3	0	0
964	480	1	0	36	60	2	0	0
965	408	2	0	36	60	1	1	0
965	51	0	1	44	60	4	1	0
965	500	2	1	25	60	3	0	0
965	128	0	0	48	60	0	0	0
965	291	2	0	36	60	5	0	0
965	130	2	1	31	60	4	0	0
965	11	0	0	23	60	0	0	0
965	314	2	0	44	60	2	0	0
966	320	2	1	48	60	1	0	0
966	452	1	0	20	60	4	0	0
966	203	2	0	28	60	0	1	0
966	112	1	1	44	60	2	0	0
966	377	0	1	48	60	0	0	0
966	321	0	1	22	60	3	1	0
966	299	1	1	44	60	2	0	0
966	140	1	1	35	60	2	0	0
967	329	2	0	24	60	3	0	0
967	205	1	1	40	60	0	1	0
967	338	2	0	46	60	1	0	0
967	199	2	0	25	60	5	0	0
967	459	1	1	27	60	5	0	0
967	43	2	0	22	60	0	0	0
967	270	1	0	38	60	0	1	0
967	494	2	1	34	60	4	0	0
968	230	0	1	42	60	2	0	0
968	317	1	0	33	60	2	0	0
968	288	0	0	43	60	0	0	0
968	453	0	0	22	60	0	1	0
968	442	2	0	25	60	1	1	0
968	23	2	0	34	60	5	0	0
968	459	0	0	47	60	0	0	0
968	322	2	0	25	60	5	0	0
969	440	2	0	40	60	4	1	0
969	201	0	1	43	60	2	0	0
969	325	0	0	49	60	5	1	0
969	322	2	0	50	60	2	0	0
969	250	0	1	29	60	5	0	0
969	326	1	1	49	60	5	0	0
969	493	0	0	27	60	4	0	0
969	422	1	0	34	60	3	0	0
970	434	2	1	25	60	3	0	0
970	237	2	1	40	60	5	0	0
970	481	2	0	38	60	2	1	0
970	94	1	0	34	60	1	0	0
970	218	0	1	45	60	0	0	0
970	286	1	0	44	60	0	1	0
970	464	2	0	26	60	2	0	0
970	499	0	1	26	60	1	0	0
971	250	0	0	50	60	5	1	0
971	48	2	0	49	60	3	0	0
971	149	1	1	45	60	2	0	0
971	17	1	0	37	60	4	0	0
971	426	2	0	47	60	1	0	0
971	282	0	1	43	60	3	0	0
971	276	2	1	23	60	1	1	0
971	54	2	1	37	60	1	0	0
972	64	0	1	31	60	5	1	0
972	471	1	1	48	60	2	0	0
972	255	2	0	38	60	1	0	0
972	187	0	1	24	60	2	1	0
972	326	2	0	40	60	2	0	0
972	412	2	1	36	60	4	0	0
972	422	2	0	44	60	1	0	0
972	140	2	1	40	60	5	0	0
973	9	1	1	24	60	3	0	0
973	270	2	0	30	60	3	0	0
973	146	2	0	26	60	0	0	0
973	441	1	1	43	60	1	0	0
973	369	1	1	33	60	2	1	0
973	348	0	0	20	60	0	0	0
973	1	0	1	34	60	4	0	0
973	435	1	1	21	60	1	0	0
974	259	1	1	45	60	4	0	0
974	20	1	0	22	60	4	0	0
974	490	1	0	38	60	3	0	0
974	220	1	0	42	60	4	0	0
974	466	1	1	24	60	1	0	0
974	194	1	1	41	60	3	0	0
974	479	2	1	39	60	3	0	0
974	125	0	0	50	60	4	0	0
975	162	0	1	46	60	5	0	0
975	345	2	0	36	60	0	0	0
975	340	1	0	48	60	1	1	0
975	476	1	0	20	60	3	0	0
975	326	0	0	28	60	1	0	0
975	432	0	1	21	60	0	0	0
975	364	1	1	39	60	4	1	0
975	395	0	0	44	60	3	0	0
976	195	2	1	28	60	1	0	0
976	367	1	1	44	60	0	0	0
976	216	1	0	24	60	3	0	0
976	341	0	0	36	60	3	1	0
976	42	2	1	45	60	0	0	0
976	446	1	0	30	60	5	0	0
976	399	0	1	24	60	4	0	0
976	1	1	0	41	60	2	1	0
977	166	1	1	47	60	4	0	0
977	17	0	0	49	60	1	1	0
977	69	1	1	23	60	1	0	0
977	170	2	0	29	60	5	0	0
977	498	2	1	22	60	1	0	0
977	241	1	0	49	60	1	1	0
977	40	0	1	22	60	1	1	0
977	375	0	0	45	60	4	0	0
978	368	0	0	44	60	3	1	0
978	147	1	1	47	60	0	0	0
978	293	2	1	31	60	1	0	0
978	410	1	1	39	60	3	0	0
978	172	2	1	50	60	3	0	0
978	384	1	1	26	60	2	1	0
978	200	0	1	36	60	1	0	0
978	148	2	1	46	60	1	0	0
979	57	0	0	44	60	1	0	0
979	222	2	1	50	60	3	0	0
979	432	2	0	23	60	4	0	0
979	375	2	1	48	60	5	1	0
979	381	0	1	46	60	0	0	0
979	215	2	1	44	60	1	0	0
979	415	2	1	27	60	2	0	0
979	208	0	0	46	60	3	0	0
980	13	2	0	50	60	5	0	0
980	316	2	0	31	60	5	0	0
980	494	1	0	48	60	1	0	0
980	325	2	0	42	60	1	1	0
980	127	0	1	34	60	1	0	0
980	405	1	0	42	60	5	0	0
980	309	0	0	42	60	4	0	0
980	52	1	0	20	60	2	0	0
981	312	0	1	34	60	2	0	0
981	226	0	1	42	60	3	0	0
981	227	1	0	49	60	2	0	0
981	382	1	1	24	60	2	1	0
981	78	2	1	44	60	4	0	0
981	25	1	0	49	60	2	0	0
981	402	0	1	27	60	5	1	0
981	380	0	1	20	60	3	1	0
982	188	1	1	50	60	1	0	0
982	465	2	1	42	60	3	1	0
982	376	0	1	41	60	1	0	0
982	100	0	0	43	60	3	1	0
982	101	1	1	42	60	4	0	0
982	339	0	1	22	60	4	0	0
982	87	2	0	37	60	1	1	0
982	490	1	0	43	60	4	0	0
983	415	0	1	33	60	3	1	0
983	391	0	1	28	60	3	0	0
983	3	2	0	24	60	1	1	0
983	162	1	1	28	60	0	0	0
983	109	2	1	37	60	4	1	0
983	463	0	1	31	60	2	0	0
983	195	2	1	22	60	4	0	0
983	338	1	1	20	60	4	0	0
984	91	0	1	41	60	1	0	0
984	334	1	0	30	60	2	1	0
984	314	2	1	39	60	3	0	0
984	228	1	0	49	60	0	0	0
984	25	1	1	44	60	0	0	0
984	209	1	0	49	60	0	0	0
984	337	0	0	40	60	5	0	0
984	216	0	1	44	60	5	0	0
985	152	2	1	36	60	0	0	0
985	138	2	0	36	60	1	1	0
985	381	1	0	22	60	5	1	0
985	26	1	1	27	60	2	0	0
985	155	0	0	41	60	0	0	0
985	358	2	1	21	60	0	0	0
985	30	2	1	34	60	2	0	0
985	210	0	0	38	60	4	1	0
986	90	0	0	21	60	4	0	0
986	162	1	0	34	60	4	1	0
986	301	1	1	47	60	1	0	0
986	14	1	1	49	60	2	1	0
986	408	0	1	39	60	0	0	0
986	57	0	1	21	60	5	1	0
986	174	0	1	46	60	5	0	0
986	137	2	0	27	60	1	0	0
987	193	1	1	41	60	0	1	0
987	267	2	1	48	60	1	0	0
987	104	0	1	36	60	5	0	0
987	270	1	1	25	60	4	0	0
987	177	1	1	32	60	3	0	0
987	103	2	1	34	60	1	0	0
987	8	0	1	34	60	2	0	0
987	454	0	0	40	60	2	0	0
988	442	0	1	47	60	5	0	0
988	68	0	1	48	60	3	1	0
988	53	2	1	30	60	4	0	0
988	61	0	1	29	60	3	0	0
988	419	0	0	28	60	3	0	0
988	411	2	1	37	60	5	0	0
988	340	0	0	33	60	5	1	0
988	497	0	0	26	60	4	1	0
989	179	0	1	50	60	1	0	0
989	159	2	1	47	60	0	0	0
989	307	2	1	36	60	5	0	0
989	267	0	0	45	60	5	0	0
989	167	2	0	50	60	1	0	0
989	453	1	1	40	60	0	0	0
989	325	2	0	49	60	3	0	0
989	315	1	0	40	60	1	1	0
990	231	1	1	50	60	3	1	0
990	403	2	0	46	60	1	0	0
990	458	2	0	40	60	2	0	0
990	325	1	0	35	60	4	0	0
990	27	0	1	31	60	2	1	0
990	358	0	0	26	60	4	0	0
990	94	2	0	30	60	5	1	0
990	103	1	1	23	60	2	0	0
991	46	1	1	34	60	5	0	0
991	161	1	1	38	60	3	0	0
991	357	0	0	29	60	2	0	0
991	18	2	0	37	60	4	0	0
991	185	2	1	31	60	4	0	0
991	448	0	0	43	60	3	0	0
991	65	2	0	35	60	3	0	0
991	218	0	0	47	60	4	0	0
992	329	2	1	23	60	0	0	0
992	214	2	1	37	60	4	0	0
992	78	2	1	47	60	1	0	0
992	74	2	1	31	60	2	1	0
992	415	1	1	24	60	4	0	0
992	292	1	0	22	60	2	0	0
992	328	0	1	24	60	2	1	0
992	493	1	0	40	60	0	0	0
993	195	2	0	32	60	2	0	0
993	320	1	0	33	60	3	1	0
993	92	2	0	41	60	5	0	0
993	201	2	1	37	60	2	0	0
993	237	2	1	38	60	0	1	0
993	307	2	0	39	60	5	0	0
993	28	0	0	32	60	3	0	0
993	448	1	1	38	60	1	0	0
994	104	0	0	24	60	3	0	0
994	387	2	0	22	60	4	0	0
994	125	2	1	22	60	4	0	0
994	334	0	1	44	60	0	1	0
994	404	2	0	45	60	5	0	0
994	201	0	0	25	60	3	0	0
994	112	1	0	41	60	3	0	0
994	92	1	0	38	60	0	0	0
995	400	2	1	50	60	0	0	0
995	250	0	0	44	60	0	0	0
995	479	2	1	46	60	2	0	0
995	203	0	1	34	60	4	0	0
995	238	2	1	29	60	2	0	0
995	235	1	1	46	60	1	1	0
995	181	1	1	43	60	2	1	0
995	330	2	1	33	60	3	0	0
996	394	0	0	37	60	0	0	0
996	385	0	1	30	60	0	0	0
996	126	2	0	46	60	0	0	0
996	491	2	0	20	60	0	1	0
996	407	1	0	28	60	2	1	0
996	365	1	1	38	60	2	1	0
996	325	2	0	34	60	4	0	0
996	300	1	1	29	60	0	0	0
997	203	2	1	26	60	5	0	0
997	73	2	1	27	60	1	0	0
997	476	2	0	31	60	2	1	0
997	348	1	1	20	60	2	1	0
997	218	0	0	39	60	5	0	0
997	40	2	0	50	60	3	1	0
997	236	0	1	41	60	4	1	0
997	495	1	0	40	60	5	1	0
998	222	1	0	41	60	2	1	0
998	492	0	1	35	60	5	0	0
998	370	1	1	45	60	0	1	0
998	292	2	0	43	60	5	1	0
998	323	0	1	28	60	4	1	0
998	175	0	0	45	60	3	0	0
998	232	2	0	39	60	5	0	0
998	103	2	0	33	60	2	1	0
999	244	1	0	41	60	5	0	0
999	162	1	0	40	60	4	0	0
999	482	1	1	37	60	3	0	0
999	212	0	0	36	60	1	1	0
999	131	0	0	34	60	0	0	0
999	497	2	0	38	60	5	0	0
999	472	1	1	45	60	1	1	0
999	310	0	0	35	60	2	1	0
1000	24	1	0	28	60	4	0	0
1000	345	1	0	30	60	1	1	0
1000	308	0	1	48	60	1	0	0
1000	32	0	1	41	60	5	0	0
1000	148	2	1	26	60	4	0	0
1000	135	0	0	24	60	2	0	0
1000	350	0	1	25	60	4	0	0
1000	169	0	1	50	60	1	0	0
1001	386	0	0	38	60	3	1	0
1001	131	1	0	50	60	5	0	0
1001	203	0	0	26	60	1	0	0
1001	124	0	1	28	60	4	1	0
1001	323	2	0	20	60	4	1	0
1001	201	2	1	24	60	5	0	0
1001	370	0	0	22	60	3	0	0
1001	320	1	1	30	60	4	0	0
1002	442	2	0	27	60	0	0	0
1002	387	0	0	33	60	1	0	0
1002	429	2	1	46	60	2	0	0
1002	410	0	1	37	60	3	0	0
1002	483	2	1	49	60	3	1	0
1002	94	1	0	50	60	3	0	0
1002	65	0	0	33	60	2	0	0
1002	435	0	1	23	60	4	0	0
1003	353	0	0	26	60	2	0	0
1003	399	0	1	23	60	5	0	0
1003	496	1	1	21	60	4	0	0
1003	478	0	0	22	60	3	0	0
1003	90	1	1	31	60	4	0	0
1003	124	0	1	25	60	5	0	0
1003	487	1	0	42	60	5	0	0
1003	234	2	1	23	60	4	1	0
1004	307	2	1	39	60	4	0	0
1004	58	0	0	42	60	0	1	0
1004	201	0	0	36	60	0	1	0
1004	480	0	1	27	60	1	0	0
1004	226	0	0	26	60	5	0	0
1004	265	0	0	36	60	3	0	0
1004	37	1	1	34	60	2	0	0
1004	12	0	0	41	60	0	0	0
1005	307	1	0	38	60	5	0	0
1005	357	2	1	44	60	2	0	0
1005	156	2	1	43	60	3	0	0
1005	147	1	0	30	60	4	0	0
1005	192	1	0	45	60	5	0	0
1005	40	2	1	50	60	2	0	0
1005	208	0	0	41	60	2	0	0
1005	119	0	0	28	60	3	0	0
1006	71	1	0	22	60	5	0	0
1006	249	0	1	44	60	0	0	0
1006	24	1	0	40	60	5	0	0
1006	451	1	0	30	60	1	0	0
1006	32	2	1	44	60	0	0	0
1006	90	2	1	38	60	3	0	0
1006	421	2	1	35	60	3	0	0
1006	337	1	1	42	60	4	0	0
1007	480	1	0	35	60	3	0	0
1007	461	2	1	21	60	5	0	0
1007	152	1	1	26	60	3	1	0
1007	207	1	0	47	60	2	0	0
1007	495	0	0	46	60	0	0	0
1007	354	2	0	44	60	1	0	0
1007	264	2	1	34	60	4	1	0
1007	317	2	1	46	60	4	0	0
1008	310	0	1	48	60	2	1	0
1008	13	0	1	37	60	2	1	0
1008	297	0	1	21	60	4	0	0
1008	468	0	0	26	60	4	0	0
1008	290	0	1	46	60	3	0	0
1008	220	1	0	34	60	2	0	0
1008	159	1	0	32	60	2	0	0
1008	462	0	1	30	60	3	0	0
1009	60	2	1	34	60	4	0	0
1009	255	2	0	28	60	5	0	0
1009	362	1	1	22	60	2	0	0
1009	188	1	0	26	60	1	0	0
1009	284	1	1	30	60	3	0	0
1009	477	1	1	26	60	4	1	0
1009	274	2	0	28	60	3	1	0
1009	77	2	0	44	60	4	1	0
1010	263	1	1	38	60	4	0	0
1010	499	2	1	50	60	2	0	0
1010	4	1	0	34	60	1	0	0
1010	120	2	1	28	60	3	1	0
1010	189	0	0	27	60	1	1	0
1010	67	0	0	21	60	1	0	0
1010	482	1	0	33	60	5	1	0
1010	423	2	0	42	60	5	0	0
1011	318	2	1	39	60	3	0	0
1011	79	2	1	28	60	1	1	0
1011	388	0	1	49	60	4	0	0
1011	476	1	0	29	60	2	0	0
1011	436	0	1	33	60	2	0	0
1011	233	1	1	37	60	3	0	0
1011	487	1	1	49	60	3	0	0
1011	9	0	1	40	60	5	0	0
1012	295	2	0	49	60	5	0	0
1012	316	2	0	26	60	1	1	0
1012	1	1	1	28	60	4	0	0
1012	490	1	0	27	60	0	0	0
1012	479	2	1	39	60	0	0	0
1012	498	2	0	25	60	1	0	0
1012	206	1	0	38	60	0	0	0
1012	322	0	1	44	60	5	0	0
1013	203	1	1	29	60	4	0	0
1013	87	1	1	37	60	0	0	0
1013	463	0	1	34	60	4	0	0
1013	438	1	0	43	60	1	0	0
1013	47	2	0	48	60	0	0	0
1013	291	0	0	34	60	4	0	0
1013	311	2	1	31	60	3	0	0
1013	316	1	1	26	60	5	0	0
1014	496	0	1	32	60	3	1	0
1014	237	0	1	25	60	3	0	0
1014	185	0	1	34	60	4	0	0
1014	100	0	1	20	60	4	1	0
1014	17	1	1	41	60	2	0	0
1014	235	0	0	34	60	5	0	0
1014	429	1	0	20	60	3	0	0
1014	313	0	1	42	60	5	0	0
1015	29	1	0	47	60	0	0	0
1015	267	2	0	44	60	0	1	0
1015	21	2	0	38	60	5	0	0
1015	284	2	0	48	60	1	0	0
1015	195	0	0	40	60	1	1	0
1015	187	2	0	24	60	0	0	0
1015	130	1	0	33	60	2	0	0
1015	486	1	0	43	60	0	1	0
1016	50	2	0	20	60	2	0	0
1016	294	2	0	42	60	5	1	0
1016	14	0	1	26	60	3	1	0
1016	405	2	1	40	60	4	0	0
1016	107	1	0	45	60	2	0	0
1016	492	0	1	28	60	4	1	0
1016	155	2	1	39	60	4	0	0
1016	275	0	1	40	60	1	0	0
1017	483	2	1	28	60	2	0	0
1017	263	2	0	49	60	0	0	0
1017	318	2	1	38	60	1	1	0
1017	476	2	0	30	60	0	0	0
1017	95	1	0	31	60	4	0	0
1017	78	2	0	39	60	3	0	0
1017	421	1	1	49	60	1	0	0
1017	454	0	1	26	60	0	0	0
1018	382	0	0	34	60	3	1	0
1018	40	1	1	25	60	5	1	0
1018	302	1	1	26	60	0	0	0
1018	130	0	0	35	60	1	1	0
1018	379	1	0	45	60	3	0	0
1018	414	2	1	38	60	0	0	0
1018	419	2	1	30	60	5	0	0
1018	320	0	1	35	60	2	0	0
1019	438	2	0	21	60	3	0	0
1019	98	0	1	39	60	4	0	0
1019	455	0	1	39	60	5	0	0
1019	198	1	1	32	60	1	0	0
1019	228	2	1	47	60	0	0	0
1019	485	0	1	34	60	0	0	0
1019	150	2	0	41	60	5	0	0
1019	115	0	1	31	60	4	0	0
1020	202	2	0	27	60	3	1	0
1020	323	0	1	43	60	0	0	0
1020	444	2	1	41	60	2	0	0
1020	79	0	0	32	60	2	0	0
1020	182	1	1	40	60	0	0	0
1020	158	2	1	43	60	4	0	0
1020	428	1	0	27	60	3	0	0
1020	447	1	0	47	60	4	0	0
1021	254	2	1	46	60	3	0	0
1021	488	1	1	25	60	5	0	0
1021	161	2	0	27	60	4	0	0
1021	499	1	0	31	60	4	0	0
1021	282	0	0	21	60	5	0	0
1021	185	2	0	26	60	1	1	0
1021	200	1	1	24	60	1	1	0
1021	475	2	1	22	60	0	0	0
1022	214	1	0	39	60	4	0	0
1022	469	1	0	40	60	0	0	0
1022	35	2	1	50	60	1	0	0
1022	115	1	0	37	60	4	0	0
1022	343	2	1	32	60	5	0	0
1022	290	2	1	26	60	5	0	0
1022	431	0	0	45	60	3	0	0
1022	437	2	1	30	60	4	1	0
1023	78	2	1	36	60	4	0	0
1023	5	0	0	21	60	2	0	0
1023	211	0	1	47	60	3	1	0
1023	338	0	0	50	60	2	1	0
1023	336	0	0	43	60	5	1	0
1023	149	2	1	43	60	3	0	0
1023	230	2	0	30	60	2	0	0
1023	191	2	0	41	60	1	0	0
1024	281	0	1	45	60	3	0	0
1024	428	0	1	37	60	3	0	0
1024	225	1	0	50	60	4	0	0
1024	278	1	0	22	60	0	1	0
1024	348	2	0	21	60	3	1	0
1024	160	2	0	45	60	3	0	0
1024	204	2	1	37	60	5	1	0
1024	266	2	1	38	60	5	0	0
1025	452	2	1	46	60	1	0	0
1025	90	0	0	49	60	1	0	0
1025	262	0	1	31	60	1	0	0
1025	283	0	0	41	60	3	0	0
1025	16	0	0	47	60	1	1	0
1025	402	1	0	48	60	1	0	0
1025	428	2	0	21	60	0	0	0
1025	329	2	0	29	60	0	0	0
1026	333	0	0	37	60	0	0	0
1026	296	0	0	20	60	1	0	0
1026	323	0	1	41	60	1	0	0
1026	348	2	0	38	60	4	1	0
1026	356	1	0	40	60	1	1	0
1026	408	1	1	42	60	4	1	0
1026	126	2	1	22	60	1	0	0
1026	94	1	1	36	60	0	0	0
1027	278	1	1	31	60	0	1	0
1027	364	2	1	48	60	0	0	0
1027	96	0	0	45	60	1	0	0
1027	112	1	1	23	60	0	0	0
1027	410	1	0	25	60	5	1	0
1027	386	1	0	29	60	2	1	0
1027	371	1	0	36	60	4	0	0
1027	253	2	1	49	60	2	0	0
1028	35	2	0	41	60	3	0	0
1028	45	0	1	46	60	5	0	0
1028	119	1	0	37	60	3	0	0
1028	247	2	0	22	60	5	0	0
1028	399	2	1	33	60	0	0	0
1028	289	2	0	39	60	2	0	0
1028	56	1	1	24	60	3	0	0
1028	460	0	0	28	60	5	1	0
1029	230	2	0	36	60	3	1	0
1029	237	0	0	35	60	1	1	0
1029	332	1	0	45	60	3	0	0
1029	113	1	1	23	60	2	0	0
1029	372	2	1	27	60	5	0	0
1029	466	0	1	26	60	5	1	0
1029	52	2	1	29	60	2	0	0
1029	447	1	0	26	60	0	1	0
1030	26	1	1	43	60	3	0	0
1030	151	1	1	23	60	4	0	0
1030	398	0	0	39	60	0	0	0
1030	36	0	1	20	60	2	1	0
1030	105	0	1	31	60	4	0	0
1030	118	0	0	49	60	0	0	0
1030	315	0	1	49	60	3	1	0
1030	194	1	1	40	60	1	0	0
1031	382	1	0	20	60	2	1	0
1031	477	2	1	32	60	5	0	0
1031	500	1	0	45	60	0	1	0
1031	55	1	0	26	60	1	0	0
1031	343	2	1	24	60	0	0	0
1031	177	1	1	35	60	1	1	0
1031	70	1	1	21	60	5	0	0
1031	367	0	1	42	60	1	1	0
1032	419	0	0	20	60	5	0	0
1032	204	2	0	35	60	3	0	0
1032	104	0	0	48	60	2	0	0
1032	438	0	0	49	60	5	0	0
1032	387	2	0	36	60	1	0	0
1032	368	0	1	47	60	0	0	0
1032	71	0	1	26	60	0	0	0
1032	210	0	0	29	60	5	0	0
1033	145	1	1	27	60	2	0	0
1033	177	1	0	42	60	0	1	0
1033	12	2	1	24	60	1	0	0
1033	107	1	0	38	60	5	0	0
1033	422	0	1	20	60	4	0	0
1033	474	0	0	45	60	1	1	0
1033	379	2	1	38	60	1	0	0
1033	388	0	0	34	60	2	0	0
1034	100	2	1	46	60	0	0	0
1034	169	1	1	23	60	4	0	0
1034	359	2	0	47	60	2	0	0
1034	155	0	0	42	60	0	0	0
1034	342	1	1	25	60	4	1	0
1034	304	1	0	37	60	5	1	0
1034	201	1	1	23	60	2	0	0
1034	289	0	1	36	60	5	0	0
1035	448	2	0	41	60	2	0	0
1035	362	2	0	48	60	1	0	0
1035	329	2	1	22	60	1	1	0
1035	217	2	1	21	60	0	0	0
1035	158	1	0	31	60	1	0	0
1035	187	1	0	40	60	2	0	0
1035	486	1	0	36	60	0	0	0
1035	343	2	0	27	60	0	0	0
1036	10	1	0	33	60	2	1	0
1036	304	1	0	38	60	4	1	0
1036	308	1	1	27	60	0	0	0
1036	77	0	1	41	60	5	1	0
1036	402	2	0	31	60	2	0	0
1036	202	1	0	26	60	1	1	0
1036	490	1	0	34	60	2	1	0
1036	491	2	1	38	60	5	0	0
1037	127	2	0	47	60	2	0	0
1037	500	1	1	49	60	3	0	0
1037	300	2	1	42	60	1	0	0
1037	302	0	1	22	60	4	0	0
1037	215	1	0	50	60	3	1	0
1037	188	1	1	38	60	0	0	0
1037	163	2	1	30	60	3	0	0
1037	474	1	1	41	60	4	0	0
1038	263	1	0	41	60	4	1	0
1038	334	1	1	42	60	0	1	0
1038	300	0	1	30	60	1	1	0
1038	245	2	0	21	60	1	0	0
1038	28	2	1	36	60	0	0	0
1038	299	0	1	44	60	4	0	0
1038	495	2	1	21	60	2	1	0
1038	253	0	0	49	60	3	0	0
1039	326	0	0	28	60	5	1	0
1039	383	2	1	50	60	2	0	0
1039	304	0	0	42	60	2	0	0
1039	56	0	0	20	60	4	0	0
1039	3	0	1	30	60	4	0	0
1039	112	0	0	21	60	4	0	0
1039	375	1	1	40	60	3	1	0
1039	137	0	0	40	60	1	0	0
1040	433	0	1	48	60	3	1	0
1040	352	0	1	41	60	0	0	0
1040	372	0	1	41	60	1	1	0
1040	177	1	1	22	60	1	0	0
1040	267	2	1	48	60	4	0	0
1040	275	0	1	37	60	0	1	0
1040	246	2	0	22	60	3	0	0
1040	497	1	1	22	60	4	1	0
1041	135	0	1	34	60	0	1	0
1041	258	1	1	34	60	5	0	0
1041	134	2	1	22	60	2	0	0
1041	274	1	1	26	60	1	0	0
1041	301	2	0	28	60	2	0	0
1041	408	1	1	42	60	2	1	0
1041	235	1	1	24	60	4	0	0
1041	412	0	1	43	60	2	1	0
1042	125	2	0	34	60	4	1	0
1042	260	2	1	21	60	3	0	0
1042	200	2	1	35	60	0	0	0
1042	145	2	0	47	60	2	1	0
1042	49	0	0	32	60	0	0	0
1042	418	2	1	32	60	2	0	0
1042	321	0	0	32	60	2	0	0
1042	376	0	1	20	60	3	1	0
1043	384	0	0	27	60	1	0	0
1043	88	0	0	20	60	0	0	0
1043	401	2	1	29	60	1	1	0
1043	24	2	1	40	60	1	0	0
1043	214	1	0	45	60	0	0	0
1043	482	1	0	22	60	3	0	0
1043	39	1	1	50	60	2	0	0
1043	425	1	1	45	60	0	0	0
1044	299	1	0	26	60	3	0	0
1044	268	1	1	46	60	5	0	0
1044	426	0	0	50	60	1	1	0
1044	88	0	1	23	60	1	0	0
1044	104	0	0	29	60	2	0	0
1044	205	1	0	33	60	0	0	0
1044	487	1	1	30	60	5	0	0
1044	317	2	1	26	60	5	0	0
1045	25	1	1	33	60	0	0	0
1045	402	2	1	31	60	5	1	0
1045	286	0	1	49	60	5	0	0
1045	325	1	1	50	60	5	1	0
1045	104	1	0	24	60	4	0	0
1045	173	1	1	26	60	3	1	0
1045	359	1	1	43	60	2	0	0
1045	109	1	1	36	60	4	0	0
1046	101	1	1	47	60	0	0	0
1046	476	2	1	22	60	2	0	0
1046	337	2	1	48	60	0	0	0
1046	312	2	1	43	60	5	0	0
1046	427	2	0	33	60	1	0	0
1046	253	1	1	50	60	3	0	0
1046	120	2	0	32	60	0	0	0
1046	448	1	0	24	60	0	0	0
1047	476	0	1	37	60	1	0	0
1047	76	0	1	36	60	4	0	0
1047	447	1	1	26	60	5	0	0
1047	189	1	1	22	60	1	0	0
1047	22	0	0	44	60	3	0	0
1047	333	0	0	45	60	0	0	0
1047	97	1	0	23	60	2	0	0
1047	230	1	0	47	60	4	0	0
1048	172	2	0	28	60	2	0	0
1048	164	0	1	35	60	4	0	0
1048	434	2	1	27	60	4	0	0
1048	399	0	0	36	60	1	0	0
1048	135	1	0	25	60	4	1	0
1048	213	2	0	35	60	2	1	0
1048	76	0	1	47	60	4	1	0
1048	234	2	0	32	60	3	0	0
1049	186	1	0	40	60	5	1	0
1049	162	0	1	43	60	2	1	0
1049	363	0	1	30	60	3	0	0
1049	152	2	0	49	60	0	0	0
1049	19	1	1	40	60	1	0	0
1049	392	0	0	24	60	4	1	0
1049	437	1	0	41	60	2	0	0
1049	110	2	0	22	60	2	1	0
1050	104	0	1	27	60	4	0	0
1050	443	2	0	23	60	1	0	0
1050	407	2	0	32	60	4	0	0
1050	107	2	1	20	60	1	0	0
1050	185	0	0	48	60	1	0	0
1050	368	0	0	45	60	0	0	0
1050	91	1	1	24	60	2	0	0
1050	159	1	1	31	60	4	0	0
1051	283	1	1	48	60	4	0	0
1051	163	1	1	25	60	0	0	0
1051	455	2	0	38	60	3	0	0
1051	55	0	0	34	60	5	0	0
1051	216	2	1	43	60	3	0	0
1051	26	2	1	32	60	2	0	0
1051	309	1	1	41	60	0	0	0
1051	159	1	1	23	60	2	0	0
1052	141	0	1	22	60	3	0	0
1052	277	1	1	46	60	4	0	0
1052	382	1	1	29	60	0	0	0
1052	61	1	0	40	60	0	1	0
1052	446	2	1	22	60	4	1	0
1052	461	0	1	27	60	4	0	0
1052	474	2	1	44	60	2	0	0
1052	333	1	0	50	60	0	0	0
1053	235	1	0	22	60	0	0	0
1053	9	0	0	42	60	2	0	0
1053	388	0	1	46	60	0	0	0
1053	445	1	0	36	60	2	0	0
1053	210	2	1	40	60	3	0	0
1053	8	1	0	25	60	2	0	0
1053	18	0	0	37	60	0	1	0
1053	23	0	1	42	60	4	0	0
1054	404	2	0	36	60	2	1	0
1054	271	0	1	41	60	0	0	0
1054	386	0	1	39	60	0	1	0
1054	410	0	0	29	60	0	0	0
1054	41	1	0	35	60	3	0	0
1054	445	0	1	49	60	5	0	0
1054	261	2	1	46	60	2	1	0
1054	487	1	1	45	60	0	0	0
1055	381	2	1	32	60	0	0	0
1055	395	1	1	50	60	1	0	0
1055	197	1	0	20	60	4	0	0
1055	70	1	0	25	60	2	0	0
1055	312	0	1	22	60	5	0	0
1055	435	0	1	24	60	0	0	0
1055	366	0	1	32	60	1	1	0
1055	155	0	0	20	60	2	0	0
1056	491	1	1	45	60	2	0	0
1056	197	0	0	24	60	0	0	0
1056	420	0	1	39	60	1	0	0
1056	440	2	1	43	60	4	0	0
1056	139	2	0	48	60	5	1	0
1056	112	0	1	50	60	2	0	0
1056	89	1	1	31	60	2	0	0
1056	239	2	1	28	60	3	1	0
1057	423	1	0	41	60	5	0	0
1057	166	1	0	45	60	2	1	0
1057	321	2	0	45	60	3	0	0
1057	91	2	1	44	60	2	1	0
1057	155	2	0	41	60	2	0	0
1057	330	2	1	37	60	4	1	0
1057	465	0	0	37	60	1	0	0
1057	336	1	0	47	60	5	0	0
1058	271	1	0	44	60	3	0	0
1058	157	2	1	36	60	4	0	0
1058	158	0	1	29	60	1	0	0
1058	443	0	1	41	60	5	0	0
1058	371	1	1	24	60	2	0	0
1058	350	2	0	43	60	4	0	0
1058	412	1	1	30	60	2	0	0
1058	3	2	1	40	60	3	0	0
1059	338	2	0	40	60	2	0	0
1059	139	2	1	45	60	0	0	0
1059	48	2	1	50	60	1	0	0
1059	310	2	1	44	60	3	0	0
1059	464	0	0	48	60	2	0	0
1059	444	0	0	33	60	1	0	0
1059	326	0	1	47	60	0	0	0
1059	236	0	0	35	60	4	1	0
1060	177	2	1	29	60	0	0	0
1060	129	1	1	36	60	2	1	0
1060	297	2	0	48	60	1	0	0
1060	8	0	1	43	60	1	1	0
1060	86	1	1	21	60	5	0	0
1060	16	0	0	28	60	5	0	0
1060	414	2	1	39	60	5	0	0
1060	233	1	1	47	60	3	0	0
1061	346	2	1	32	60	5	0	0
1061	297	2	1	38	60	4	0	0
1061	361	0	0	40	60	0	1	0
1061	135	1	0	39	60	1	1	0
1061	83	1	1	38	60	3	0	0
1061	354	0	0	27	60	1	0	0
1061	52	2	0	40	60	4	0	0
1061	329	0	0	33	60	3	1	0
1062	369	2	1	48	60	1	0	0
1062	97	1	0	30	60	1	1	0
1062	215	0	0	45	60	5	0	0
1062	162	0	1	28	60	1	0	0
1062	246	0	0	35	60	4	1	0
1062	448	2	0	39	60	3	0	0
1062	253	1	0	29	60	2	0	0
1062	198	2	0	46	60	0	1	0
1063	425	2	1	39	60	0	0	0
1063	392	1	0	22	60	3	0	0
1063	222	2	1	45	60	3	0	0
1063	188	0	1	41	60	4	0	0
1063	346	2	0	27	60	1	0	0
1063	278	0	0	33	60	5	0	0
1063	350	1	0	41	60	3	0	0
1063	119	0	1	46	60	3	0	0
1064	250	1	1	22	60	2	0	0
1064	139	1	0	34	60	5	0	0
1064	178	0	1	41	60	2	0	0
1064	145	2	1	44	60	1	0	0
1064	117	2	1	23	60	2	0	0
1064	154	1	0	22	60	2	0	0
1064	237	1	0	41	60	1	1	0
1064	55	1	0	20	60	1	1	0
1065	486	2	1	42	60	4	1	0
1065	99	0	1	30	60	3	0	0
1065	176	2	0	21	60	5	0	0
1065	110	0	1	40	60	0	0	0
1065	388	1	0	46	60	0	1	0
1065	186	2	0	25	60	0	0	0
1065	66	0	0	34	60	4	0	0
1065	245	2	1	39	60	0	0	0
1066	492	2	0	25	60	2	1	0
1066	199	0	0	47	60	2	0	0
1066	179	1	0	21	60	2	0	0
1066	370	1	0	38	60	2	0	0
1066	487	0	1	30	60	5	0	0
1066	187	2	0	23	60	1	0	0
1066	303	2	1	45	60	5	0	0
1066	162	0	0	39	60	5	1	0
1067	280	1	0	28	60	4	0	0
1067	342	1	1	44	60	3	1	0
1067	441	1	1	20	60	4	0	0
1067	386	2	0	39	60	3	1	0
1067	55	1	0	49	60	0	0	0
1067	77	1	0	47	60	4	1	0
1067	4	1	0	47	60	3	0	0
1067	204	0	0	25	60	5	1	0
1068	366	0	0	22	60	2	0	0
1068	72	2	1	50	60	1	0	0
1068	417	0	1	40	60	0	0	0
1068	48	0	1	33	60	1	0	0
1068	249	0	0	35	60	4	0	0
1068	261	2	0	36	60	4	0	0
1068	372	2	0	36	60	0	0	0
1068	342	0	1	40	60	2	0	0
1069	402	0	1	41	60	4	0	0
1069	234	2	1	45	60	5	0	0
1069	487	1	0	34	60	4	0	0
1069	431	2	1	33	60	2	1	0
1069	291	2	1	37	60	2	0	0
1069	224	0	1	24	60	1	0	0
1069	372	0	1	24	60	0	0	0
1069	22	0	0	50	60	1	0	0
1070	365	0	1	38	60	2	0	0
1070	480	1	1	45	60	3	1	0
1070	260	0	0	33	60	2	0	0
1070	470	0	0	46	60	4	0	0
1070	423	0	1	30	60	3	0	0
1070	177	0	1	33	60	0	0	0
1070	488	2	1	23	60	2	0	0
1070	227	2	1	32	60	1	0	0
1071	436	2	0	32	60	0	0	0
1071	217	2	0	21	60	5	0	0
1071	460	1	0	30	60	1	0	0
1071	50	1	0	46	60	1	0	0
1071	144	1	1	30	60	2	1	0
1071	400	1	0	26	60	3	1	0
1071	14	2	1	28	60	0	0	0
1071	358	2	1	36	60	5	0	0
1072	345	1	1	46	60	1	0	0
1072	241	0	1	49	60	1	0	0
1072	333	1	0	50	60	4	0	0
1072	309	2	0	31	60	5	0	0
1072	187	1	0	42	60	4	0	0
1072	28	1	1	33	60	4	0	0
1072	381	0	1	35	60	0	0	0
1072	467	0	0	30	60	2	1	0
1073	328	1	0	28	60	0	1	0
1073	403	1	0	23	60	1	0	0
1073	327	1	0	40	60	5	1	0
1073	115	2	1	44	60	1	0	0
1073	185	0	1	32	60	0	0	0
1073	421	1	0	28	60	3	0	0
1073	498	0	0	42	60	3	0	0
1073	369	2	1	34	60	2	0	0
1074	8	1	1	34	60	0	0	0
1074	15	2	1	41	60	3	0	0
1074	144	0	1	47	60	5	0	0
1074	14	1	0	39	60	2	0	0
1074	224	2	0	34	60	4	0	0
1074	66	0	1	24	60	0	0	0
1074	226	2	1	29	60	3	0	0
1074	62	1	1	42	60	2	0	0
1075	118	0	1	29	60	5	0	0
1075	70	1	1	48	60	0	0	0
1075	168	2	0	42	60	5	0	0
1075	133	0	0	50	60	2	0	0
1075	151	0	1	44	60	4	1	0
1075	11	1	0	39	60	2	0	0
1075	303	2	1	28	60	1	0	0
1075	477	1	0	25	60	2	0	0
1076	331	1	0	49	60	0	0	0
1076	208	1	1	33	60	5	0	0
1076	254	1	1	48	60	1	0	0
1076	481	2	0	34	60	1	0	0
1076	474	1	1	20	60	3	0	0
1076	97	2	1	21	60	5	0	0
1076	448	0	0	35	60	5	1	0
1076	148	0	1	25	60	1	1	0
1077	111	2	0	32	60	4	0	0
1077	261	0	1	43	60	5	0	0
1077	227	1	0	29	60	3	0	0
1077	143	0	1	24	60	1	0	0
1077	191	2	0	27	60	5	0	0
1077	44	1	0	23	60	1	0	0
1077	355	0	1	39	60	0	1	0
1077	190	2	0	34	60	3	0	0
1078	216	1	1	27	60	4	1	0
1078	293	0	1	32	60	5	0	0
1078	451	0	1	28	60	4	0	0
1078	5	1	0	34	60	2	0	0
1078	420	1	0	21	60	0	0	0
1078	137	0	0	39	60	5	0	0
1078	129	2	0	46	60	4	0	0
1078	56	2	1	38	60	2	0	0
1079	23	0	0	34	60	0	1	0
1079	67	1	1	25	60	0	0	0
1079	324	1	0	35	60	0	0	0
1079	219	0	1	50	60	0	0	0
1079	37	0	0	49	60	5	1	0
1079	465	0	1	33	60	5	1	0
1079	201	2	0	49	60	3	0	0
1079	396	1	0	46	60	1	0	0
1080	43	0	1	22	60	1	0	0
1080	465	1	0	36	60	5	0	0
1080	327	1	1	33	60	2	1	0
1080	189	2	1	31	60	1	0	0
1080	418	0	1	40	60	3	1	0
1080	255	1	0	37	60	1	0	0
1080	397	2	0	23	60	1	1	0
1080	93	2	0	48	60	3	1	0
1081	106	2	1	27	60	0	0	0
1081	27	1	1	32	60	5	0	0
1081	354	1	0	37	60	4	0	0
1081	270	0	0	32	60	3	0	0
1081	236	1	0	42	60	3	0	0
1081	303	1	1	48	60	5	0	0
1081	369	1	0	48	60	1	0	0
1081	386	2	1	44	60	4	1	0
1082	9	1	0	42	60	2	1	0
1082	213	2	1	33	60	5	0	0
1082	368	2	1	37	60	5	1	0
1082	277	2	0	48	60	0	0	0
1082	167	0	1	35	60	1	1	0
1082	235	2	1	22	60	4	0	0
1082	478	2	0	45	60	2	0	0
1082	486	0	1	42	60	3	0	0
1083	417	0	1	26	60	3	0	0
1083	336	1	1	26	60	5	0	0
1083	354	0	1	34	60	3	0	0
1083	283	0	1	38	60	5	0	0
1083	406	1	0	22	60	5	0	0
1083	152	2	0	43	60	5	0	0
1083	377	0	0	31	60	5	1	0
1083	426	1	0	42	60	0	0	0
1084	330	0	0	47	60	1	0	0
1084	256	2	1	24	60	5	0	0
1084	486	0	1	26	60	2	0	0
1084	72	2	0	38	60	4	0	0
1084	219	0	0	49	60	0	0	0
1084	129	0	1	44	60	1	1	0
1084	444	0	0	21	60	4	0	0
1084	159	0	0	35	60	4	0	0
1085	307	0	0	24	60	0	0	0
1085	270	0	1	22	60	1	0	0
1085	215	2	0	36	60	1	0	0
1085	407	1	1	26	60	4	0	0
1085	299	0	1	30	60	5	0	0
1085	354	0	1	38	60	4	0	0
1085	425	2	0	22	60	0	0	0
1085	133	0	0	40	60	5	0	0
1086	125	0	1	26	60	3	0	0
1086	438	2	0	22	60	3	0	0
1086	255	1	1	24	60	4	0	0
1086	187	2	1	36	60	2	0	0
1086	328	1	1	42	60	2	0	0
1086	186	2	0	42	60	5	1	0
1086	334	0	0	25	60	1	1	0
1086	377	2	1	39	60	5	0	0
1087	101	0	0	49	60	3	1	0
1087	179	0	0	39	60	4	0	0
1087	174	0	0	25	60	1	0	0
1087	216	1	1	36	60	3	0	0
1087	156	2	0	24	60	0	0	0
1087	424	1	0	40	60	2	0	0
1087	10	0	1	27	60	1	0	0
1087	292	0	0	35	60	4	0	0
1088	275	2	1	39	60	5	0	0
1088	83	1	1	34	60	0	1	0
1088	279	1	1	27	60	2	1	0
1088	427	0	0	41	60	3	1	0
1088	14	2	1	45	60	2	0	0
1088	406	0	0	28	60	1	1	0
1088	17	0	1	33	60	0	0	0
1088	20	2	0	50	60	2	0	0
1089	425	0	1	50	60	0	1	0
1089	276	0	0	21	60	0	1	0
1089	392	0	0	46	60	2	0	0
1089	41	0	1	20	60	0	1	0
1089	362	2	1	27	60	5	1	0
1089	263	0	1	33	60	2	0	0
1089	19	0	1	47	60	4	0	0
1089	147	2	0	26	60	5	0	0
1090	50	2	0	23	60	4	0	0
1090	66	2	1	43	60	4	1	0
1090	225	0	1	45	60	0	0	0
1090	194	1	1	48	60	1	0	0
1090	55	1	1	22	60	0	0	0
1090	377	1	0	29	60	3	0	0
1090	248	0	0	30	60	3	0	0
1090	243	0	1	32	60	5	1	0
1091	284	0	0	27	60	5	1	0
1091	343	0	0	38	60	5	1	0
1091	94	1	0	20	60	2	0	0
1091	451	0	0	45	60	0	1	0
1091	140	2	1	24	60	5	0	0
1091	390	0	1	48	60	5	1	0
1091	107	0	1	24	60	2	0	0
1091	234	2	0	27	60	2	0	0
1092	67	1	1	30	60	0	0	0
1092	134	1	0	31	60	4	0	0
1092	195	1	0	30	60	3	0	0
1092	47	1	0	43	60	2	0	0
1092	177	1	0	22	60	4	0	0
1092	297	0	0	31	60	0	0	0
1092	338	1	1	41	60	4	0	0
1092	457	0	0	21	60	2	0	0
1093	263	2	1	28	60	3	0	0
1093	30	1	0	39	60	4	0	0
1093	257	2	0	44	60	4	0	0
1093	105	2	0	39	60	1	0	0
1093	434	2	0	27	60	0	0	0
1093	120	1	0	47	60	1	1	0
1093	244	0	0	33	60	3	0	0
1093	396	2	0	20	60	0	0	0
1094	153	1	1	47	60	2	0	0
1094	103	0	1	48	60	5	0	0
1094	316	2	0	32	60	0	1	0
1094	235	2	1	36	60	3	0	0
1094	307	2	0	50	60	5	0	0
1094	57	2	1	30	60	4	1	0
1094	221	0	0	29	60	2	0	0
1094	259	0	1	41	60	4	0	0
1095	386	1	0	39	60	3	1	0
1095	6	2	1	28	60	4	0	0
1095	459	2	1	38	60	2	0	0
1095	187	1	0	37	60	3	0	0
1095	59	1	0	32	60	2	0	0
1095	163	0	0	26	60	5	0	0
1095	408	0	1	33	60	0	0	0
1095	190	0	1	48	60	3	0	0
1096	279	2	1	33	60	0	0	0
1096	21	1	0	34	60	4	0	0
1096	108	1	0	42	60	4	0	0
1096	470	2	0	22	60	5	0	0
1096	53	0	1	37	60	2	0	0
1096	4	2	0	48	60	1	0	0
1096	409	0	0	30	60	5	0	0
1096	262	2	1	24	60	2	0	0
1097	78	0	0	44	60	3	1	0
1097	487	2	1	23	60	1	0	0
1097	269	0	1	31	60	0	1	0
1097	135	2	1	47	60	1	0	0
1097	446	1	0	23	60	4	0	0
1097	168	0	1	36	60	5	0	0
1097	25	2	0	23	60	3	0	0
1097	439	1	1	43	60	2	0	0
1098	160	1	0	23	60	2	0	0
1098	13	0	1	20	60	4	1	0
1098	213	1	0	34	60	5	0	0
1098	243	1	0	44	60	0	0	0
1098	448	0	0	33	60	5	1	0
1098	47	2	0	31	60	3	1	0
1098	469	0	1	41	60	0	1	0
1098	458	0	1	30	60	5	0	0
1099	101	2	1	46	60	4	0	0
1099	185	0	0	20	60	0	1	0
1099	491	2	1	33	60	1	0	0
1099	38	1	0	25	60	4	0	0
1099	126	2	0	30	60	3	0	0
1099	283	2	1	25	60	1	0	0
1099	455	0	1	35	60	5	1	0
1099	186	0	0	49	60	4	1	0
1100	242	0	1	27	60	3	0	0
1100	17	1	1	30	60	4	0	0
1100	434	2	0	23	60	1	0	0
1100	478	1	0	44	60	2	0	0
1100	154	1	1	43	60	3	0	0
1100	397	1	0	48	60	4	1	0
1100	344	1	0	24	60	2	1	0
1100	260	0	1	27	60	5	1	0
1101	120	0	1	36	60	5	0	0
1101	24	0	1	28	60	4	0	0
1101	18	2	0	40	60	1	0	0
1101	301	0	1	36	60	1	0	0
1101	228	2	1	38	60	2	0	0
1101	452	1	0	37	60	5	1	0
1101	401	0	1	26	60	1	0	0
1101	231	0	1	47	60	5	1	0
1102	200	1	0	41	60	4	0	0
1102	304	2	0	21	60	4	0	0
1102	429	1	1	48	60	1	0	0
1102	146	0	0	35	60	1	1	0
1102	349	1	1	45	60	3	0	0
1102	204	1	0	40	60	3	0	0
1102	76	2	1	34	60	2	0	0
1102	458	1	0	43	60	4	1	0
1103	43	0	1	41	60	0	0	0
1103	427	1	0	45	60	0	0	0
1103	279	0	0	31	60	2	1	0
1103	327	2	1	30	60	0	0	0
1103	89	2	0	28	60	0	0	0
1103	94	2	0	28	60	1	0	0
1103	284	1	0	28	60	1	0	0
1103	356	2	0	42	60	2	0	0
1104	115	1	0	35	60	1	0	0
1104	65	1	1	33	60	5	0	0
1104	95	1	0	20	60	0	0	0
1104	337	0	0	37	60	3	1	0
1104	308	0	0	45	60	3	1	0
1104	433	2	0	45	60	1	1	0
1104	140	1	0	50	60	3	0	0
1104	264	2	0	20	60	2	0	0
1105	3	1	0	46	60	2	0	0
1105	190	1	0	24	60	2	0	0
1105	401	0	0	25	60	5	0	0
1105	267	2	1	26	60	0	0	0
1105	43	2	1	26	60	4	0	0
1105	78	2	1	33	60	0	0	0
1105	406	1	0	28	60	1	1	0
1105	321	1	0	28	60	0	0	0
1106	365	0	1	50	60	2	0	0
1106	407	0	1	22	60	0	0	0
1106	130	0	1	47	60	3	0	0
1106	378	2	1	34	60	0	0	0
1106	78	2	0	31	60	1	0	0
1106	192	0	0	23	60	0	0	0
1106	237	2	0	37	60	4	0	0
1106	258	0	1	29	60	0	0	0
1107	174	1	0	32	60	2	0	0
1107	73	2	1	36	60	3	0	0
1107	36	0	0	44	60	2	0	0
1107	69	0	1	20	60	3	0	0
1107	210	1	0	33	60	2	1	0
1107	10	0	0	26	60	4	0	0
1107	104	0	0	28	60	0	0	0
1107	13	1	0	33	60	5	0	0
1108	227	0	1	48	60	1	0	0
1108	496	0	0	35	60	3	0	0
1108	223	0	0	33	60	1	1	0
1108	195	1	1	36	60	2	1	0
1108	202	0	0	20	60	5	0	0
1108	163	0	1	26	60	3	0	0
1108	346	0	0	30	60	1	1	0
1108	42	0	0	20	60	3	0	0
1109	283	2	0	20	60	4	0	0
1109	462	1	1	49	60	3	0	0
1109	358	2	0	50	60	4	1	0
1109	118	1	1	46	60	5	0	0
1109	36	2	1	22	60	1	1	0
1109	366	0	0	21	60	0	1	0
1109	300	1	0	34	60	0	0	0
1109	138	1	0	44	60	1	1	0
1110	282	0	0	44	60	0	0	0
1110	327	0	0	34	60	2	0	0
1110	174	1	0	30	60	4	0	0
1110	287	2	0	48	60	0	0	0
1110	306	0	0	49	60	5	0	0
1110	99	1	1	23	60	5	1	0
1110	224	2	0	29	60	4	1	0
1110	67	1	1	41	60	3	0	0
1111	113	1	1	42	60	3	0	0
1111	222	2	0	44	60	4	0	0
1111	207	1	0	45	60	3	1	0
1111	454	1	1	46	60	3	0	0
1111	209	1	1	40	60	1	1	0
1111	129	2	1	34	60	2	0	0
1111	74	0	0	28	60	3	1	0
1111	149	0	0	34	60	5	0	0
1112	262	2	0	49	60	3	1	0
1112	188	0	1	45	60	1	0	0
1112	368	1	0	48	60	5	0	0
1112	6	0	0	26	60	4	1	0
1112	404	2	1	30	60	5	0	0
1112	499	1	1	28	60	0	0	0
1112	275	1	0	45	60	0	1	0
1112	299	1	0	25	60	5	0	0
1113	66	1	1	21	60	3	0	0
1113	148	2	1	26	60	4	0	0
1113	443	0	0	34	60	0	1	0
1113	367	1	0	20	60	1	0	0
1113	139	2	0	29	60	4	0	0
1113	57	1	1	45	60	4	0	0
1113	495	0	1	30	60	4	0	0
1113	101	0	0	31	60	2	0	0
1114	90	2	0	43	60	1	1	0
1114	414	2	0	41	60	0	0	0
1114	279	2	1	37	60	3	0	0
1114	95	1	1	41	60	1	0	0
1114	419	1	1	33	60	2	1	0
1114	373	1	1	32	60	3	1	0
1114	10	0	1	43	60	1	0	0
1114	54	0	0	32	60	4	0	0
1115	35	2	0	23	60	5	0	0
1115	93	2	1	44	60	5	0	0
1115	54	2	0	48	60	3	0	0
1115	149	1	1	27	60	3	1	0
1115	169	1	1	39	60	1	0	0
1115	3	0	0	44	60	2	0	0
1115	244	1	1	43	60	3	0	0
1115	490	2	0	40	60	1	0	0
1116	354	2	0	39	60	1	0	0
1116	324	1	1	22	60	3	1	0
1116	251	2	1	46	60	2	1	0
1116	393	1	1	44	60	0	0	0
1116	31	2	0	50	60	1	1	0
1116	335	1	1	26	60	5	0	0
1116	140	2	1	26	60	3	0	0
1116	456	2	1	44	60	3	0	0
1117	365	0	0	21	60	3	0	0
1117	415	2	0	31	60	1	1	0
1117	202	2	1	38	60	4	0	0
1117	158	1	1	26	60	1	0	0
1117	461	1	1	29	60	4	1	0
1117	451	2	0	35	60	4	0	0
1117	467	2	0	34	60	4	0	0
1117	267	1	0	32	60	1	0	0
1118	217	2	0	22	60	2	0	0
1118	27	2	0	20	60	4	0	0
1118	216	0	1	25	60	0	0	0
1118	383	1	1	24	60	2	0	0
1118	130	0	1	21	60	1	1	0
1118	427	1	1	23	60	4	0	0
1118	184	0	1	38	60	0	0	0
1118	58	2	0	35	60	0	0	0
1119	198	0	1	43	60	5	1	0
1119	111	1	1	38	60	0	1	0
1119	436	1	1	39	60	1	1	0
1119	105	0	0	30	60	0	0	0
1119	330	2	0	37	60	3	0	0
1119	17	0	1	37	60	2	0	0
1119	201	0	1	43	60	3	0	0
1119	455	0	1	23	60	3	0	0
1120	62	2	0	44	60	1	0	0
1120	158	2	0	47	60	3	0	0
1120	276	1	1	33	60	1	0	0
1120	208	0	1	38	60	2	0	0
1120	423	2	1	25	60	2	0	0
1120	310	0	0	26	60	3	1	0
1120	441	0	0	36	60	5	0	0
1120	109	2	1	50	60	5	0	0
1121	479	0	1	26	60	1	0	0
1121	269	2	0	32	60	1	0	0
1121	119	2	0	31	60	2	0	0
1121	186	0	1	20	60	5	0	0
1121	445	1	0	21	60	3	1	0
1121	182	2	0	27	60	2	1	0
1121	439	2	0	26	60	5	1	0
1121	17	2	1	42	60	5	1	0
1122	377	2	1	40	60	3	0	0
1122	265	2	0	28	60	2	0	0
1122	407	2	1	49	60	5	0	0
1122	73	2	0	47	60	3	1	0
1122	82	2	0	48	60	2	0	0
1122	223	2	0	25	60	0	1	0
1122	191	1	0	42	60	0	0	0
1122	176	2	1	29	60	0	0	0
1123	38	2	0	25	60	3	0	0
1123	490	2	0	32	60	5	0	0
1123	466	1	0	29	60	1	0	0
1123	410	0	0	32	60	1	1	0
1123	386	2	0	20	60	1	1	0
1123	417	0	1	35	60	1	0	0
1123	185	1	1	20	60	0	0	0
1123	50	0	1	23	60	2	0	0
1124	201	0	0	46	60	4	1	0
1124	1	1	1	43	60	3	1	0
1124	52	0	1	31	60	4	0	0
1124	256	2	0	43	60	2	1	0
1124	378	2	1	44	60	2	0	0
1124	155	2	1	38	60	1	0	0
1124	374	0	1	45	60	1	0	0
1124	369	0	1	20	60	5	0	0
1125	414	2	0	31	60	4	0	0
1125	130	1	0	24	60	4	0	0
1125	78	1	1	41	60	3	1	0
1125	225	0	0	25	60	0	1	0
1125	423	0	1	46	60	4	0	0
1125	72	2	1	30	60	5	0	0
1125	6	2	0	50	60	4	1	0
1125	359	1	0	43	60	1	1	0
1126	24	1	1	40	60	4	1	0
1126	426	2	0	40	60	3	0	0
1126	341	1	0	37	60	2	0	0
1126	238	1	1	36	60	5	0	0
1126	65	0	1	40	60	3	1	0
1126	100	0	0	43	60	1	0	0
1126	397	0	0	26	60	1	0	0
1126	402	0	0	22	60	2	1	0
1127	499	1	0	49	60	5	1	0
1127	102	1	1	23	60	0	0	0
1127	24	1	0	44	60	5	0	0
1127	307	2	0	25	60	2	0	0
1127	242	0	0	37	60	5	0	0
1127	257	0	1	36	60	5	0	0
1127	61	2	1	34	60	2	0	0
1127	384	0	1	22	60	5	0	0
1128	74	1	0	48	60	0	0	0
1128	404	0	0	32	60	4	0	0
1128	208	1	0	40	60	2	0	0
1128	229	2	0	44	60	5	0	0
1128	53	2	0	48	60	5	1	0
1128	487	2	1	39	60	0	0	0
1128	351	2	1	26	60	1	0	0
1128	401	1	1	37	60	4	0	0
1129	233	2	1	21	60	4	0	0
1129	267	1	0	27	60	2	0	0
1129	62	0	0	25	60	1	1	0
1129	381	2	1	29	60	5	0	0
1129	287	2	0	48	60	5	0	0
1129	496	0	1	43	60	4	1	0
1129	376	0	1	42	60	4	0	0
1129	259	2	1	31	60	0	1	0
1130	102	2	0	21	60	2	0	0
1130	425	1	1	40	60	2	0	0
1130	304	1	0	35	60	3	0	0
1130	305	2	0	38	60	1	1	0
1130	6	2	1	50	60	4	0	0
1130	343	0	0	45	60	3	0	0
1130	22	2	0	21	60	4	0	0
1130	318	0	1	31	60	1	0	0
1131	254	2	1	50	60	3	0	0
1131	391	2	0	33	60	4	1	0
1131	297	2	0	36	60	4	0	0
1131	167	1	0	21	60	4	1	0
1131	7	1	1	41	60	0	0	0
1131	44	2	1	28	60	1	0	0
1131	500	1	1	40	60	0	0	0
1131	170	1	1	41	60	0	1	0
1132	67	0	0	37	60	3	1	0
1132	345	0	0	40	60	3	0	0
1132	302	0	1	34	60	2	0	0
1132	41	2	1	47	60	5	1	0
1132	10	2	1	23	60	0	0	0
1132	498	1	0	45	60	5	1	0
1132	285	1	1	32	60	3	0	0
1132	148	2	1	32	60	2	0	0
1133	247	1	0	41	60	4	0	0
1133	447	0	1	31	60	4	0	0
1133	410	0	1	49	60	0	1	0
1133	42	1	0	29	60	1	0	0
1133	157	1	1	38	60	1	0	0
1133	486	1	0	21	60	3	1	0
1133	162	1	0	39	60	1	0	0
1133	132	2	0	37	60	2	0	0
1134	445	2	1	29	60	1	0	0
1134	349	1	0	29	60	4	1	0
1134	415	2	1	24	60	1	1	0
1134	276	2	1	32	60	0	0	0
1134	258	0	0	30	60	2	1	0
1134	259	1	1	21	60	5	0	0
1134	161	1	0	45	60	1	1	0
1134	26	0	0	36	60	0	0	0
1135	498	0	0	33	60	3	0	0
1135	1	1	1	31	60	2	0	0
1135	219	1	1	27	60	4	0	0
1135	353	0	1	45	60	1	0	0
1135	224	0	1	31	60	1	1	0
1135	13	2	1	45	60	0	0	0
1135	44	0	0	34	60	3	1	0
1135	54	0	0	43	60	0	1	0
1136	142	1	0	23	60	5	0	0
1136	57	0	1	45	60	1	0	0
1136	477	0	1	46	60	2	1	0
1136	153	1	1	20	60	5	0	0
1136	202	0	0	20	60	0	0	0
1136	40	1	0	23	60	2	0	0
1136	269	2	1	47	60	1	0	0
1136	421	1	0	40	60	4	0	0
1137	417	0	1	44	60	3	0	0
1137	315	1	0	38	60	3	0	0
1137	32	0	0	35	60	3	1	0
1137	239	0	0	32	60	0	1	0
1137	170	0	1	48	60	4	0	0
1137	166	2	0	31	60	2	1	0
1137	192	1	1	48	60	1	1	0
1137	407	1	0	48	60	3	0	0
1138	172	2	0	37	60	0	1	0
1138	1	0	1	48	60	4	0	0
1138	297	2	1	49	60	3	0	0
1138	411	0	0	36	60	2	0	0
1138	200	0	0	26	60	3	0	0
1138	286	2	1	31	60	1	0	0
1138	108	1	1	50	60	4	0	0
1138	44	0	1	39	60	1	0	0
1139	438	1	0	25	60	3	1	0
1139	190	0	1	25	60	2	0	0
1139	389	1	1	40	60	0	0	0
1139	14	2	0	26	60	5	0	0
1139	35	1	0	31	60	4	1	0
1139	463	2	0	49	60	1	1	0
1139	284	2	0	38	60	3	0	0
1139	447	2	0	27	60	1	0	0
1140	436	2	0	27	60	5	0	0
1140	462	0	0	28	60	5	1	0
1140	446	2	1	40	60	2	0	0
1140	250	1	1	20	60	0	0	0
1140	498	1	1	27	60	0	1	0
1140	150	2	1	42	60	3	1	0
1140	286	1	0	21	60	0	0	0
1140	54	2	0	38	60	5	1	0
1141	386	0	0	33	60	3	1	0
1141	223	2	1	45	60	4	0	0
1141	426	1	0	41	60	4	1	0
1141	89	0	1	22	60	2	0	0
1141	145	2	1	32	60	2	1	0
1141	85	2	1	26	60	4	1	0
1141	178	1	1	49	60	2	0	0
1141	147	2	0	45	60	2	0	0
1142	282	0	0	26	60	1	1	0
1142	371	0	0	42	60	4	0	0
1142	386	1	0	41	60	1	0	0
1142	425	2	0	44	60	3	0	0
1142	57	1	0	37	60	5	0	0
1142	480	0	0	48	60	2	1	0
1142	127	2	1	45	60	5	1	0
1142	223	0	0	31	60	3	0	0
1143	293	0	1	33	60	5	0	0
1143	371	0	1	27	60	3	0	0
1143	327	1	1	36	60	4	0	0
1143	58	0	1	27	60	3	0	0
1143	265	1	1	23	60	2	0	0
1143	228	1	0	41	60	1	1	0
1143	385	0	1	44	60	2	0	0
1143	5	1	1	26	60	5	1	0
1144	197	1	1	31	60	5	0	0
1144	267	0	0	35	60	3	0	0
1144	371	2	0	20	60	4	0	0
1144	406	1	0	30	60	2	0	0
1144	11	2	1	20	60	3	1	0
1144	112	2	1	22	60	3	0	0
1144	347	1	1	47	60	2	0	0
1144	14	1	0	40	60	0	1	0
1145	419	2	1	45	60	1	0	0
1145	162	0	1	50	60	4	0	0
1145	369	1	0	27	60	0	0	0
1145	151	2	0	39	60	1	0	0
1145	335	1	0	40	60	3	1	0
1145	288	2	1	46	60	4	0	0
1145	325	0	1	32	60	0	1	0
1145	286	1	1	37	60	0	0	0
1146	431	2	0	23	60	0	0	0
1146	231	1	0	39	60	2	0	0
1146	47	0	0	28	60	2	0	0
1146	478	1	0	28	60	2	0	0
1146	199	1	0	22	60	2	0	0
1146	303	0	1	38	60	2	0	0
1146	367	2	1	49	60	4	1	0
1146	370	2	1	40	60	2	1	0
1147	318	0	0	47	60	5	0	0
1147	422	2	1	34	60	1	0	0
1147	270	1	1	24	60	2	1	0
1147	158	0	1	40	60	4	0	0
1147	116	1	1	34	60	2	0	0
1147	493	0	0	36	60	2	0	0
1147	500	2	1	43	60	1	0	0
1147	255	2	1	24	60	3	1	0
1148	15	1	0	45	60	4	0	0
1148	259	0	1	34	60	3	0	0
1148	483	1	0	47	60	4	0	0
1148	73	2	1	31	60	4	0	0
1148	386	0	0	34	60	4	0	0
1148	494	2	1	24	60	3	0	0
1148	274	2	0	46	60	3	1	0
1148	195	1	0	40	60	5	0	0
1149	102	2	0	49	60	4	0	0
1149	276	0	1	22	60	4	0	0
1149	498	2	0	45	60	4	0	0
1149	355	1	0	22	60	4	1	0
1149	110	1	1	48	60	3	1	0
1149	176	2	1	23	60	0	0	0
1149	84	1	0	21	60	5	0	0
1149	156	1	0	30	60	5	1	0
1150	374	2	0	37	60	2	1	0
1150	154	0	1	33	60	0	0	0
1150	337	0	0	45	60	3	0	0
1150	500	1	0	50	60	1	0	0
1150	26	2	1	37	60	5	1	0
1150	201	2	1	35	60	1	0	0
1150	338	1	0	25	60	0	0	0
1150	53	1	0	50	60	4	0	0
1151	410	2	1	50	60	2	1	0
1151	104	1	1	34	60	1	0	0
1151	117	1	0	24	60	1	0	0
1151	388	0	0	40	60	2	0	0
1151	152	2	0	29	60	2	1	0
1151	339	0	1	26	60	0	0	0
1151	255	2	0	46	60	3	1	0
1151	239	2	1	50	60	3	0	0
1152	187	0	0	43	60	5	0	0
1152	165	1	1	46	60	3	0	0
1152	380	2	1	23	60	1	1	0
1152	342	2	0	38	60	2	0	0
1152	222	0	1	46	60	3	0	0
1152	7	2	1	46	60	5	0	0
1152	70	1	1	48	60	1	0	0
1152	495	0	1	35	60	0	0	0
1153	342	1	0	40	60	4	1	0
1153	335	0	0	33	60	3	0	0
1153	121	2	0	48	60	1	1	0
1153	227	0	0	39	60	0	1	0
1153	434	2	1	29	60	0	1	0
1153	292	2	1	27	60	4	0	0
1153	2	0	1	37	60	2	0	0
1153	12	1	0	49	60	0	0	0
1154	425	1	1	30	60	2	0	0
1154	436	1	1	33	60	0	0	0
1154	54	1	0	43	60	2	0	0
1154	271	1	1	42	60	2	1	0
1154	109	2	0	36	60	1	0	0
1154	494	0	0	29	60	2	1	0
1154	484	0	1	37	60	0	0	0
1154	225	2	1	23	60	1	1	0
1155	237	0	0	20	60	5	0	0
1155	72	0	1	25	60	5	0	0
1155	282	0	1	23	60	0	0	0
1155	217	0	1	29	60	0	1	0
1155	254	2	0	20	60	4	1	0
1155	191	2	1	27	60	0	0	0
1155	292	0	1	27	60	3	0	0
1155	460	1	1	25	60	5	0	0
1156	388	1	0	33	60	1	0	0
1156	232	1	1	43	60	1	0	0
1156	267	1	0	44	60	5	1	0
1156	13	0	1	29	60	2	0	0
1156	254	0	0	43	60	0	0	0
1156	64	1	1	23	60	1	1	0
1156	222	2	1	25	60	4	0	0
1156	299	2	1	47	60	2	1	0
1157	43	1	0	38	60	4	1	0
1157	182	0	1	22	60	5	0	0
1157	312	1	0	20	60	0	1	0
1157	479	2	0	43	60	2	0	0
1157	60	0	0	42	60	2	0	0
1157	289	1	0	43	60	1	1	0
1157	467	2	0	28	60	5	0	0
1157	327	2	1	49	60	3	0	0
1158	493	0	1	45	60	3	0	0
1158	420	0	0	21	60	3	0	0
1158	26	1	0	36	60	2	0	0
1158	144	1	1	49	60	0	1	0
1158	194	2	1	24	60	3	0	0
1158	337	0	1	40	60	4	1	0
1158	53	0	0	34	60	4	0	0
1158	200	0	0	22	60	3	1	0
1159	421	1	0	20	60	2	0	0
1159	73	0	1	29	60	0	1	0
1159	102	0	1	26	60	0	0	0
1159	176	2	0	34	60	2	0	0
1159	388	1	1	45	60	3	1	0
1159	346	1	0	50	60	2	1	0
1159	478	0	0	23	60	3	0	0
1159	260	1	1	47	60	4	0	0
1160	232	0	0	49	60	2	0	0
1160	50	2	1	24	60	1	0	0
1160	321	2	1	23	60	0	0	0
1160	165	0	0	26	60	2	0	0
1160	430	0	0	21	60	0	0	0
1160	147	2	0	48	60	1	0	0
1160	115	0	0	45	60	1	1	0
1160	408	2	0	48	60	3	1	0
1161	97	2	0	34	60	5	0	0
1161	295	2	1	40	60	5	0	0
1161	313	2	1	39	60	1	0	0
1161	207	1	0	35	60	4	0	0
1161	30	0	1	28	60	1	0	0
1161	381	0	0	40	60	4	0	0
1161	346	2	0	27	60	5	0	0
1161	15	0	0	50	60	1	0	0
1162	115	1	1	33	60	0	1	0
1162	183	1	0	28	60	4	0	0
1162	475	1	0	28	60	0	0	0
1162	76	0	1	20	60	3	0	0
1162	497	2	1	38	60	4	1	0
1162	344	2	0	24	60	5	0	0
1162	169	0	0	24	60	1	0	0
1162	134	2	1	23	60	3	0	0
1163	348	2	1	49	60	2	0	0
1163	54	0	1	22	60	4	0	0
1163	241	2	0	22	60	4	0	0
1163	340	0	0	41	60	4	1	0
1163	484	2	0	46	60	1	0	0
1163	438	0	1	35	60	3	0	0
1163	259	2	0	36	60	1	0	0
1163	383	0	1	45	60	1	1	0
1164	129	0	0	40	60	3	1	0
1164	46	2	0	37	60	0	0	0
1164	14	1	0	47	60	5	1	0
1164	497	2	0	27	60	4	1	0
1164	338	2	0	22	60	4	1	0
1164	11	2	0	30	60	0	0	0
1164	193	1	1	34	60	0	1	0
1164	459	2	0	21	60	0	1	0
1165	301	1	0	50	60	4	1	0
1165	159	1	0	21	60	0	0	0
1165	18	0	1	30	60	5	0	0
1165	493	2	1	31	60	4	0	0
1165	222	2	0	32	60	2	0	0
1165	25	0	0	48	60	2	0	0
1165	237	0	0	36	60	3	0	0
1165	143	2	1	33	60	4	0	0
1166	256	1	1	47	60	2	0	0
1166	485	2	1	47	60	2	1	0
1166	393	0	0	38	60	5	0	0
1166	272	2	1	44	60	3	0	0
1166	156	2	1	45	60	3	0	0
1166	477	1	1	31	60	5	1	0
1166	46	1	1	38	60	2	0	0
1166	206	0	1	50	60	1	1	0
1167	186	2	0	43	60	3	0	0
1167	339	0	1	36	60	5	1	0
1167	91	2	0	46	60	1	1	0
1167	57	2	1	49	60	5	0	0
1167	368	2	0	40	60	2	0	0
1167	164	0	0	23	60	3	0	0
1167	497	1	1	24	60	2	0	0
1167	43	0	0	30	60	5	1	0
1168	400	1	1	34	60	1	0	0
1168	337	2	0	30	60	5	0	0
1168	388	0	0	38	60	3	0	0
1168	200	2	0	50	60	3	0	0
1168	118	0	0	28	60	2	1	0
1168	348	1	1	37	60	4	0	0
1168	387	1	0	33	60	4	1	0
1168	275	1	1	42	60	2	0	0
1169	40	1	0	48	60	0	0	0
1169	401	1	1	47	60	5	0	0
1169	295	0	0	33	60	5	1	0
1169	454	1	0	50	60	4	1	0
1169	463	2	0	43	60	4	0	0
1169	94	2	0	30	60	2	0	0
1169	199	1	1	48	60	5	0	0
1169	472	2	1	34	60	5	0	0
1170	363	2	1	38	60	4	0	0
1170	32	2	0	39	60	2	0	0
1170	299	1	0	37	60	1	1	0
1170	183	2	1	48	60	4	1	0
1170	459	2	0	25	60	5	1	0
1170	466	1	0	25	60	4	0	0
1170	3	2	0	41	60	1	0	0
1170	120	2	1	48	60	2	0	0
1171	341	1	0	24	60	0	0	0
1171	180	1	1	43	60	4	0	0
1171	205	0	0	39	60	5	0	0
1171	382	2	0	34	60	2	0	0
1171	116	0	0	32	60	5	0	0
1171	75	2	0	43	60	5	0	0
1171	448	2	0	26	60	5	1	0
1171	450	0	1	35	60	2	0	0
1172	162	2	1	25	60	1	0	0
1172	285	2	0	40	60	1	0	0
1172	447	2	1	50	60	4	0	0
1172	187	2	1	43	60	2	0	0
1172	10	1	0	22	60	4	0	0
1172	130	1	1	30	60	0	0	0
1172	333	0	0	20	60	4	1	0
1172	226	1	1	49	60	1	0	0
1173	458	2	1	32	60	3	1	0
1173	277	2	1	22	60	5	1	0
1173	356	2	0	35	60	5	0	0
1173	52	0	0	50	60	0	0	0
1173	131	2	0	46	60	1	0	0
1173	145	1	1	37	60	2	0	0
1173	381	1	0	24	60	4	0	0
1173	112	1	1	24	60	3	0	0
1174	301	1	0	24	60	5	0	0
1174	48	1	0	34	60	5	1	0
1174	463	2	1	23	60	5	0	0
1174	243	2	0	28	60	1	0	0
1174	361	2	0	23	60	0	0	0
1174	113	1	0	21	60	3	0	0
1174	461	2	0	38	60	3	0	0
1174	333	1	1	32	60	3	0	0
1175	90	1	1	41	60	3	0	0
1175	133	2	0	37	60	0	0	0
1175	363	1	1	24	60	5	0	0
1175	326	0	1	25	60	3	0	0
1175	85	0	1	45	60	1	1	0
1175	337	2	1	25	60	2	0	0
1175	475	2	1	31	60	2	0	0
1175	405	2	0	50	60	0	0	0
1176	23	0	0	44	60	3	0	0
1176	481	1	1	29	60	5	0	0
1176	79	0	1	42	60	0	0	0
1176	98	2	1	35	60	2	0	0
1176	86	0	1	43	60	4	1	0
1176	314	2	1	39	60	2	0	0
1176	474	1	0	20	60	0	0	0
1176	274	1	0	29	60	5	0	0
1177	221	2	1	25	60	1	0	0
1177	350	0	0	36	60	3	0	0
1177	267	2	1	28	60	5	1	0
1177	69	0	1	37	60	5	1	0
1177	356	1	1	41	60	0	0	0
1177	482	0	1	47	60	0	0	0
1177	33	0	1	35	60	5	1	0
1177	155	2	1	34	60	0	0	0
1178	178	1	0	47	60	2	0	0
1178	77	2	0	25	60	0	0	0
1178	153	0	1	27	60	0	0	0
1178	241	2	0	22	60	4	0	0
1178	103	0	0	43	60	1	0	0
1178	171	0	0	40	60	3	0	0
1178	97	1	0	44	60	2	0	0
1178	246	1	1	40	60	4	0	0
1179	406	1	1	24	60	5	1	0
1179	384	2	1	41	60	0	0	0
1179	169	0	1	40	60	5	0	0
1179	142	0	0	42	60	3	0	0
1179	125	1	1	35	60	2	0	0
1179	310	0	0	26	60	1	0	0
1179	68	1	1	23	60	4	0	0
1179	57	2	0	25	60	5	0	0
1180	67	1	0	25	60	1	1	0
1180	434	0	0	28	60	5	1	0
1180	161	2	1	35	60	5	0	0
1180	313	1	0	22	60	4	0	0
1180	260	2	0	42	60	5	1	0
1180	27	2	0	24	60	2	0	0
1180	173	2	0	26	60	1	0	0
1180	91	2	0	36	60	4	1	0
1181	78	0	1	31	60	2	0	0
1181	163	1	0	42	60	3	0	0
1181	53	0	0	39	60	4	0	0
1181	447	2	1	20	60	3	1	0
1181	486	2	1	32	60	2	0	0
1181	241	1	1	44	60	0	0	0
1181	391	1	1	20	60	1	1	0
1181	210	2	0	24	60	1	0	0
1182	368	1	0	45	60	0	1	0
1182	352	0	0	44	60	1	0	0
1182	84	0	1	36	60	3	0	0
1182	432	0	1	49	60	2	0	0
1182	431	1	0	21	60	4	0	0
1182	313	0	1	43	60	2	0	0
1182	32	0	0	21	60	1	0	0
1182	312	1	0	39	60	1	0	0
1183	164	1	1	38	60	0	0	0
1183	459	1	0	41	60	4	0	0
1183	180	1	0	49	60	0	0	0
1183	310	2	0	41	60	2	0	0
1183	131	1	1	29	60	1	0	0
1183	415	0	0	49	60	1	0	0
1183	188	2	0	30	60	3	0	0
1183	135	2	1	35	60	2	1	0
1184	24	0	0	36	60	1	0	0
1184	453	2	0	36	60	3	1	0
1184	271	0	1	47	60	2	1	0
1184	189	2	1	34	60	3	1	0
1184	411	0	1	47	60	4	1	0
1184	262	2	0	39	60	1	1	0
1184	346	2	0	48	60	2	0	0
1184	117	2	0	25	60	4	0	0
1185	1	2	0	39	60	3	0	0
1185	98	2	1	24	60	0	0	0
1185	82	1	1	40	60	4	0	0
1185	465	1	0	29	60	1	1	0
1185	230	0	0	23	60	1	0	0
1185	246	0	0	25	60	2	1	0
1185	151	0	1	26	60	4	1	0
1185	379	2	0	46	60	5	1	0
1186	25	2	1	29	60	4	0	0
1186	479	2	1	39	60	2	0	0
1186	30	2	1	35	60	5	0	0
1186	447	1	1	32	60	4	0	0
1186	119	2	1	37	60	0	0	0
1186	13	2	0	22	60	5	0	0
1186	283	2	0	40	60	2	0	0
1186	457	0	1	22	60	0	1	0
1187	394	1	0	21	60	1	0	0
1187	159	2	0	33	60	5	0	0
1187	225	2	0	41	60	0	1	0
1187	495	1	0	21	60	1	0	0
1187	335	0	0	35	60	5	1	0
1187	111	0	1	27	60	2	0	0
1187	224	1	1	45	60	4	0	0
1187	316	1	0	48	60	5	1	0
1188	358	1	0	24	60	5	1	0
1188	491	2	0	37	60	5	0	0
1188	407	0	1	29	60	1	0	0
1188	84	2	0	25	60	4	1	0
1188	124	0	1	46	60	1	1	0
1188	313	2	1	26	60	2	0	0
1188	262	2	0	22	60	5	0	0
1188	197	2	0	32	60	1	0	0
1189	315	0	1	28	60	2	0	0
1189	446	2	1	40	60	4	0	0
1189	420	1	0	26	60	2	0	0
1189	86	0	0	32	60	5	1	0
1189	286	1	1	26	60	1	0	0
1189	421	2	1	45	60	0	1	0
1189	154	1	1	37	60	4	1	0
1189	32	1	0	30	60	0	1	0
1190	185	1	1	37	60	3	0	0
1190	333	0	1	50	60	5	0	0
1190	136	2	1	32	60	1	0	0
1190	348	0	1	29	60	3	0	0
1190	491	0	1	36	60	5	0	0
1190	401	2	0	43	60	4	0	0
1190	465	1	0	32	60	0	1	0
1190	290	0	0	40	60	3	0	0
1191	246	2	1	42	60	0	0	0
1191	177	1	1	40	60	1	0	0
1191	250	2	1	21	60	3	0	0
1191	180	2	1	26	60	5	0	0
1191	337	1	1	41	60	0	0	0
1191	263	1	0	43	60	2	0	0
1191	480	2	0	48	60	2	0	0
1191	183	1	1	32	60	2	1	0
1192	83	1	1	23	60	2	0	0
1192	142	0	0	49	60	3	0	0
1192	231	0	1	46	60	3	0	0
1192	122	1	1	30	60	3	1	0
1192	414	1	1	41	60	2	0	0
1192	107	1	1	41	60	1	0	0
1192	50	2	0	24	60	4	1	0
1192	350	0	0	38	60	0	1	0
1193	185	1	0	36	60	0	0	0
1193	385	2	1	43	60	2	1	0
1193	224	0	0	35	60	5	0	0
1193	187	2	1	32	60	2	0	0
1193	437	1	0	47	60	1	0	0
1193	40	1	1	45	60	3	0	0
1193	279	2	1	22	60	4	0	0
1193	165	2	0	31	60	1	0	0
1194	366	2	1	34	60	3	0	0
1194	286	2	0	48	60	0	1	0
1194	59	0	0	29	60	4	0	0
1194	456	0	1	42	60	2	1	0
1194	55	0	1	23	60	3	1	0
1194	430	1	1	45	60	4	1	0
1194	223	2	0	23	60	3	0	0
1194	486	2	1	31	60	0	0	0
1195	211	1	1	45	60	1	0	0
1195	185	2	1	49	60	1	0	0
1195	429	1	1	31	60	3	1	0
1195	477	0	1	33	60	4	0	0
1195	367	2	0	34	60	0	1	0
1195	452	0	0	48	60	1	0	0
1195	152	2	0	24	60	1	0	0
1195	479	1	0	26	60	4	0	0
1196	492	2	0	43	60	3	0	0
1196	11	1	0	37	60	3	0	0
1196	255	0	1	27	60	3	0	0
1196	221	1	0	27	60	3	0	0
1196	331	2	0	20	60	4	0	0
1196	232	2	0	42	60	4	0	0
1196	411	0	0	47	60	3	0	0
1196	162	1	1	22	60	5	1	0
1197	154	1	0	43	60	0	0	0
1197	355	1	1	30	60	2	0	0
1197	180	1	0	35	60	4	0	0
1197	498	1	1	50	60	1	0	0
1197	392	1	0	20	60	2	0	0
1197	73	2	1	29	60	0	1	0
1197	470	2	1	47	60	5	0	0
1197	445	0	0	46	60	4	1	0
1198	8	0	0	43	60	5	0	0
1198	77	2	0	21	60	2	1	0
1198	420	0	0	21	60	0	0	0
1198	52	0	1	34	60	3	0	0
1198	301	0	0	43	60	4	0	0
1198	133	2	0	37	60	2	0	0
1198	263	1	1	32	60	2	0	0
1198	311	1	1	20	60	0	1	0
1199	94	2	1	42	60	1	0	0
1199	135	2	1	34	60	0	1	0
1199	485	1	0	37	60	4	0	0
1199	280	1	0	46	60	4	0	0
1199	61	1	1	45	60	1	0	0
1199	110	1	1	25	60	2	0	0
1199	246	0	0	35	60	4	0	0
1199	219	0	1	40	60	5	1	0
1200	280	0	0	46	60	3	1	0
1200	360	1	0	40	60	2	0	0
1200	242	2	1	21	60	1	1	0
1200	83	2	1	27	60	1	0	0
1200	433	2	1	42	60	3	0	0
1200	65	2	0	23	60	2	0	0
1200	119	1	1	50	60	3	0	0
1200	362	0	0	42	60	4	0	0
1201	333	2	1	36	60	0	0	0
1201	482	1	0	42	60	5	0	0
1201	251	2	1	30	60	1	1	0
1201	497	0	1	30	60	5	1	0
1201	17	1	0	27	60	0	0	0
1201	146	0	0	36	60	4	0	0
1201	107	0	1	49	60	1	0	0
1201	292	0	1	47	60	3	0	0
1202	44	1	1	43	60	1	0	0
1202	317	2	1	43	60	3	1	0
1202	326	0	0	37	60	0	0	0
1202	51	2	0	44	60	0	0	0
1202	160	2	0	45	60	3	0	0
1202	140	1	0	23	60	4	1	0
1202	43	1	1	26	60	2	1	0
1202	428	1	0	40	60	1	1	0
1203	141	2	1	36	60	1	0	0
1203	486	0	0	28	60	3	0	0
1203	150	2	0	47	60	4	0	0
1203	371	0	0	45	60	4	1	0
1203	62	1	1	28	60	3	1	0
1203	366	0	0	44	60	1	0	0
1203	161	1	1	25	60	2	0	0
1203	399	2	0	43	60	1	0	0
1204	315	2	1	49	60	1	0	0
1204	38	1	1	26	60	1	0	0
1204	101	2	0	30	60	4	0	0
1204	490	1	1	49	60	4	0	0
1204	351	1	0	35	60	1	1	0
1204	179	2	1	33	60	2	0	0
1204	37	1	0	31	60	3	0	0
1204	130	0	0	33	60	3	1	0
1205	416	0	1	40	60	4	0	0
1205	396	2	0	32	60	2	0	0
1205	427	0	0	20	60	1	0	0
1205	316	0	1	40	60	3	1	0
1205	130	1	0	23	60	5	0	0
1205	19	2	1	48	60	3	0	0
1205	187	1	1	44	60	4	1	0
1205	216	2	1	35	60	5	0	0
1206	10	1	0	35	60	3	0	0
1206	49	1	0	21	60	2	1	0
1206	480	2	1	28	60	4	0	0
1206	298	0	1	38	60	0	0	0
1206	423	2	0	50	60	3	0	0
1206	107	1	0	33	60	1	1	0
1206	48	2	1	45	60	2	1	0
1206	495	0	0	44	60	0	0	0
1207	57	1	0	47	60	0	0	0
1207	437	0	0	41	60	2	1	0
1207	192	2	1	35	60	1	1	0
1207	466	0	1	31	60	5	0	0
1207	355	0	0	50	60	0	0	0
1207	473	0	1	37	60	0	1	0
1207	349	1	0	20	60	5	0	0
1207	326	2	0	36	60	2	1	0
1208	3	0	1	42	60	4	0	0
1208	270	2	0	41	60	2	1	0
1208	78	0	0	26	60	1	0	0
1208	137	2	0	30	60	1	1	0
1208	188	2	0	23	60	1	0	0
1208	404	0	0	45	60	5	1	0
1208	120	0	0	45	60	1	0	0
1208	334	0	0	21	60	2	0	0
1209	118	0	1	20	60	2	0	0
1209	326	2	0	40	60	2	0	0
1209	255	1	1	30	60	5	0	0
1209	89	0	0	46	60	0	0	0
1209	299	2	0	49	60	3	0	0
1209	85	2	0	24	60	4	0	0
1209	138	2	1	30	60	0	0	0
1209	148	2	1	22	60	2	0	0
1210	98	0	1	25	60	0	0	0
1210	442	2	1	22	60	0	0	0
1210	124	0	1	32	60	5	0	0
1210	73	0	0	33	60	0	1	0
1210	431	2	1	46	60	4	0	0
1210	488	2	1	25	60	1	0	0
1210	414	2	0	28	60	2	0	0
1210	53	1	1	44	60	2	0	0
1211	7	2	0	38	60	2	0	0
1211	257	0	0	32	60	1	1	0
1211	174	1	0	40	60	0	0	0
1211	276	0	1	26	60	4	0	0
1211	400	2	1	30	60	3	0	0
1211	298	0	0	27	60	0	1	0
1211	245	0	0	28	60	0	0	0
1211	331	1	1	37	60	1	0	0
1212	361	2	1	27	60	3	0	0
1212	139	1	1	34	60	4	0	0
1212	495	0	1	31	60	3	0	0
1212	336	1	0	21	60	5	0	0
1212	85	2	0	21	60	1	0	0
1212	243	2	0	20	60	1	1	0
1212	272	2	0	23	60	3	0	0
1212	295	2	1	42	60	2	0	0
1213	163	0	0	46	60	0	1	0
1213	324	1	0	41	60	4	0	0
1213	273	0	1	47	60	1	1	0
1213	230	1	1	41	60	3	1	0
1213	394	2	1	41	60	0	0	0
1213	326	2	0	45	60	2	1	0
1213	98	0	0	23	60	0	1	0
1213	217	2	1	27	60	4	0	0
1214	218	0	0	40	60	3	0	0
1214	179	2	1	23	60	5	1	0
1214	360	1	0	21	60	0	0	0
1214	268	1	1	41	60	2	0	0
1214	18	1	1	44	60	3	0	0
1214	102	0	1	42	60	0	0	0
1214	126	1	1	30	60	2	0	0
1214	222	2	1	39	60	2	1	0
1215	230	1	1	47	60	4	0	0
1215	495	1	1	46	60	1	1	0
1215	388	0	1	38	60	2	1	0
1215	458	1	0	25	60	0	0	0
1215	413	1	0	22	60	5	0	0
1215	284	2	1	46	60	1	0	0
1215	371	1	0	27	60	1	1	0
1215	243	2	1	32	60	5	0	0
1216	108	2	1	20	60	4	0	0
1216	373	2	0	33	60	5	0	0
1216	62	1	0	31	60	5	1	0
1216	80	0	1	32	60	3	0	0
1216	381	2	1	35	60	2	0	0
1216	93	2	0	20	60	3	1	0
1216	171	0	0	27	60	2	0	0
1216	127	0	1	44	60	1	1	0
1217	403	0	1	33	60	2	0	0
1217	273	2	1	26	60	0	1	0
1217	314	1	1	42	60	5	0	0
1217	409	1	1	21	60	5	0	0
1217	59	2	0	39	60	0	1	0
1217	30	2	0	28	60	2	0	0
1217	394	1	1	22	60	3	0	0
1217	382	2	1	39	60	3	0	0
1218	122	2	0	23	60	4	0	0
1218	98	0	0	38	60	4	0	0
1218	492	0	1	29	60	4	1	0
1218	339	1	0	28	60	4	0	0
1218	320	1	0	33	60	0	0	0
1218	247	1	0	50	60	2	0	0
1218	434	1	1	21	60	4	0	0
1218	301	1	1	35	60	0	1	0
1219	71	0	0	38	60	5	1	0
1219	378	2	1	46	60	3	0	0
1219	121	2	0	33	60	5	0	0
1219	293	0	0	27	60	2	1	0
1219	165	1	0	38	60	2	1	0
1219	498	2	1	43	60	5	1	0
1219	364	1	1	24	60	1	0	0
1219	38	0	0	21	60	4	0	0
1220	356	0	1	22	60	2	0	0
1220	366	1	0	33	60	5	0	0
1220	27	1	0	21	60	3	0	0
1220	452	0	0	45	60	2	0	0
1220	251	2	0	38	60	4	0	0
1220	410	2	1	42	60	4	1	0
1220	246	1	0	21	60	1	0	0
1220	166	2	0	42	60	5	0	0
1221	443	2	0	30	60	5	0	0
1221	144	1	0	26	60	5	1	0
1221	487	1	1	41	60	1	0	0
1221	76	1	0	41	60	4	0	0
1221	496	1	0	28	60	3	0	0
1221	148	0	0	46	60	5	0	0
1221	358	2	1	26	60	2	0	0
1221	389	2	0	31	60	0	0	0
1222	187	1	0	31	60	0	0	0
1222	315	0	1	31	60	5	0	0
1222	15	1	0	37	60	5	1	0
1222	243	0	1	39	60	3	0	0
1222	18	0	1	42	60	1	1	0
1222	284	2	0	37	60	2	1	0
1222	119	2	0	42	60	5	0	0
1222	310	2	1	38	60	5	0	0
1223	457	2	0	31	60	3	0	0
1223	386	1	1	31	60	3	0	0
1223	427	0	1	34	60	5	0	0
1223	444	1	1	40	60	1	0	0
1223	474	0	1	36	60	0	1	0
1223	110	0	1	49	60	0	0	0
1223	241	0	1	44	60	2	0	0
1223	404	2	1	29	60	3	0	0
1224	252	1	0	35	60	0	0	0
1224	295	1	0	41	60	3	0	0
1224	78	1	0	28	60	0	1	0
1224	212	2	1	20	60	4	0	0
1224	214	2	1	43	60	5	0	0
1224	359	2	1	48	60	0	1	0
1224	38	0	1	42	60	3	1	0
1224	161	1	0	45	60	1	1	0
1225	463	1	1	39	60	3	0	0
1225	319	1	1	48	60	0	0	0
1225	302	2	1	41	60	0	0	0
1225	49	2	1	35	60	2	0	0
1225	31	1	1	39	60	2	0	0
1225	202	1	1	33	60	5	0	0
1225	144	0	1	44	60	3	1	0
1225	380	2	0	32	60	5	0	0
1226	313	2	1	30	60	4	0	0
1226	483	2	0	25	60	0	1	0
1226	188	1	1	39	60	0	1	0
1226	279	1	1	47	60	4	0	0
1226	218	1	1	27	60	4	0	0
1226	70	0	0	25	60	3	0	0
1226	389	0	0	42	60	5	0	0
1226	107	0	0	42	60	5	1	0
1227	50	1	0	47	60	5	0	0
1227	357	0	1	27	60	5	0	0
1227	390	1	1	45	60	1	0	0
1227	345	1	0	48	60	4	0	0
1227	22	1	0	36	60	3	0	0
1227	262	2	1	34	60	1	0	0
1227	435	1	0	20	60	2	0	0
1227	238	1	1	38	60	4	0	0
1228	316	1	0	43	60	4	0	0
1228	240	0	0	34	60	4	0	0
1228	49	1	1	21	60	3	0	0
1228	53	2	1	48	60	0	0	0
1228	378	1	1	20	60	5	0	0
1228	323	0	0	39	60	1	0	0
1228	278	2	0	43	60	0	0	0
1228	414	0	0	24	60	3	0	0
1229	294	1	1	20	60	5	0	0
1229	66	1	0	38	60	1	0	0
1229	347	2	1	26	60	0	0	0
1229	179	0	0	37	60	4	0	0
1229	195	1	0	40	60	5	1	0
1229	215	2	1	26	60	0	1	0
1229	339	1	0	50	60	5	1	0
1229	283	2	0	37	60	3	0	0
1230	466	2	1	24	60	1	0	0
1230	227	1	0	25	60	2	0	0
1230	268	0	1	45	60	0	0	0
1230	62	2	0	39	60	5	0	0
1230	219	1	0	41	60	2	0	0
1230	318	2	0	24	60	1	0	0
1230	6	1	1	44	60	5	0	0
1230	68	0	1	20	60	3	1	0
1231	474	1	0	33	60	4	0	0
1231	343	2	1	35	60	5	0	0
1231	208	0	0	20	60	0	0	0
1231	420	2	0	36	60	0	1	0
1231	403	0	1	22	60	2	1	0
1231	460	1	0	47	60	5	0	0
1231	263	0	1	27	60	4	0	0
1231	176	2	1	34	60	4	0	0
1232	197	2	1	20	60	1	1	0
1232	488	1	0	43	60	1	1	0
1232	433	1	1	22	60	3	1	0
1232	349	0	0	42	60	4	0	0
1232	328	2	0	21	60	2	0	0
1232	500	2	1	48	60	5	0	0
1232	21	2	0	40	60	1	0	0
1232	312	1	0	43	60	0	1	0
1233	174	2	1	50	60	1	0	0
1233	420	0	1	49	60	2	0	0
1233	477	2	1	25	60	3	0	0
1233	154	1	0	24	60	2	0	0
1233	135	0	0	44	60	3	0	0
1233	132	0	0	31	60	3	1	0
1233	379	1	0	50	60	0	0	0
1233	378	1	0	22	60	5	0	0
1234	154	0	1	50	60	0	0	0
1234	181	2	0	23	60	5	1	0
1234	415	1	1	31	60	2	1	0
1234	212	0	1	29	60	3	0	0
1234	358	2	1	48	60	1	0	0
1234	325	0	1	41	60	1	0	0
1234	402	0	0	22	60	0	1	0
1234	195	2	1	28	60	2	0	0
1235	492	0	1	47	60	0	0	0
1235	70	2	0	36	60	4	0	0
1235	346	2	1	49	60	0	0	0
1235	333	2	1	36	60	4	1	0
1235	387	0	0	22	60	5	0	0
1235	459	2	1	33	60	3	0	0
1235	363	1	1	24	60	2	0	0
1235	384	2	0	32	60	0	0	0
1236	114	2	1	30	60	2	0	0
1236	387	1	0	40	60	0	0	0
1236	100	2	1	42	60	0	0	0
1236	273	2	1	31	60	3	0	0
1236	24	2	1	50	60	2	0	0
1236	427	2	0	36	60	2	0	0
1236	355	0	0	46	60	4	0	0
1236	366	1	0	42	60	4	1	0
1237	223	2	1	42	60	5	1	0
1237	296	0	1	36	60	5	0	0
1237	134	1	0	35	60	0	0	0
1237	284	1	1	35	60	5	0	0
1237	288	2	0	23	60	4	0	0
1237	5	0	0	42	60	2	1	0
1237	303	0	1	22	60	3	0	0
1237	289	2	1	31	60	4	0	0
1238	382	0	0	37	60	5	0	0
1238	358	0	1	49	60	4	0	0
1238	254	2	1	23	60	5	1	0
1238	86	1	1	50	60	2	0	0
1238	119	0	0	49	60	2	0	0
1238	172	2	1	34	60	0	1	0
1238	341	0	1	24	60	3	0	0
1238	224	1	1	25	60	5	0	0
1239	338	1	1	21	60	4	0	0
1239	144	2	0	24	60	2	0	0
1239	199	0	1	21	60	5	1	0
1239	449	1	1	50	60	1	0	0
1239	58	2	1	23	60	4	0	0
1239	220	1	0	38	60	2	0	0
1239	75	1	0	42	60	1	0	0
1239	404	1	1	41	60	0	0	0
1240	143	0	0	34	60	1	0	0
1240	248	2	1	27	60	0	0	0
1240	226	1	0	26	60	4	1	0
1240	250	0	0	45	60	1	0	0
1240	287	1	0	43	60	0	0	0
1240	31	2	1	49	60	3	0	0
1240	99	0	1	22	60	4	1	0
1240	5	2	0	33	60	3	0	0
1241	318	0	0	40	60	4	0	0
1241	326	1	1	24	60	4	0	0
1241	225	0	0	31	60	3	0	0
1241	402	0	1	47	60	4	1	0
1241	246	0	1	47	60	5	0	0
1241	325	2	1	47	60	5	0	0
1241	233	2	1	28	60	5	0	0
1241	53	1	0	20	60	3	1	0
1242	114	0	0	34	60	4	1	0
1242	411	1	0	28	60	5	0	0
1242	407	0	0	32	60	5	0	0
1242	241	0	0	47	60	3	1	0
1242	141	0	1	38	60	5	0	0
1242	168	2	1	28	60	3	0	0
1242	200	1	0	31	60	1	1	0
1242	273	1	0	22	60	1	0	0
1243	391	0	0	38	60	0	0	0
1243	393	0	0	37	60	3	0	0
1243	270	1	0	29	60	4	1	0
1243	326	2	1	23	60	1	0	0
1243	91	1	1	44	60	3	0	0
1243	172	1	0	41	60	0	0	0
1243	420	1	0	47	60	4	0	0
1243	231	2	1	40	60	3	1	0
1244	147	1	1	23	60	3	1	0
1244	13	1	0	35	60	0	1	0
1244	392	0	0	44	60	1	0	0
1244	28	2	0	44	60	5	0	0
1244	207	0	1	43	60	1	0	0
1244	386	0	0	34	60	5	0	0
1244	412	1	0	33	60	3	0	0
1244	369	2	0	34	60	5	0	0
1245	257	0	0	23	60	3	1	0
1245	472	0	0	30	60	5	0	0
1245	173	1	1	41	60	0	0	0
1245	34	1	0	34	60	0	0	0
1245	419	1	0	27	60	4	0	0
1245	70	2	0	29	60	5	0	0
1245	277	1	1	25	60	0	0	0
1245	141	0	0	45	60	3	0	0
1246	51	2	1	33	60	4	0	0
1246	497	2	1	36	60	5	1	0
1246	430	2	1	24	60	4	0	0
1246	99	1	1	23	60	2	0	0
1246	376	0	1	25	60	4	0	0
1246	17	0	1	38	60	2	1	0
1246	261	1	1	49	60	5	0	0
1246	390	1	1	36	60	2	1	0
1247	38	0	1	39	60	4	0	0
1247	249	1	1	20	60	0	0	0
1247	254	1	0	50	60	5	0	0
1247	446	0	1	40	60	0	1	0
1247	329	0	0	40	60	5	0	0
1247	204	2	0	22	60	0	0	0
1247	214	2	0	39	60	3	1	0
1247	411	2	1	34	60	3	0	0
1248	272	0	0	25	60	2	0	0
1248	286	0	1	38	60	0	0	0
1248	188	1	0	42	60	0	0	0
1248	186	0	0	26	60	2	0	0
1248	423	2	1	20	60	4	0	0
1248	71	0	1	48	60	1	0	0
1248	412	2	1	36	60	2	1	0
1248	332	0	1	38	60	3	0	0
1249	266	2	1	31	60	2	0	0
1249	384	2	0	37	60	5	0	0
1249	492	0	1	25	60	3	0	0
1249	457	2	1	36	60	2	0	0
1249	124	0	1	34	60	5	0	0
1249	293	0	1	25	60	2	0	0
1249	321	1	1	27	60	2	0	0
1249	465	1	1	35	60	5	0	0
1250	443	2	0	39	60	3	0	0
1250	192	1	0	45	60	5	1	0
1250	442	1	0	32	60	2	1	0
1250	101	2	0	45	60	4	1	0
1250	87	1	1	20	60	2	0	0
1250	183	2	1	26	60	5	0	0
1250	474	0	1	35	60	5	0	0
1250	495	1	0	49	60	1	0	0
1251	408	0	1	24	60	1	0	0
1251	442	0	1	49	60	3	0	0
1251	215	1	0	28	60	2	1	0
1251	461	2	1	23	60	0	1	0
1251	90	0	1	34	60	4	0	0
1251	431	2	0	24	60	5	0	0
1251	443	2	0	45	60	1	0	0
1251	293	0	1	37	60	1	0	0
1252	163	1	0	46	60	0	0	0
1252	184	2	1	26	60	5	1	0
1252	317	1	0	41	60	3	0	0
1252	207	2	1	31	60	3	0	0
1252	74	2	0	32	60	5	0	0
1252	91	2	1	26	60	2	0	0
1252	395	1	0	49	60	4	0	0
1252	34	2	1	39	60	3	0	0
1253	345	1	1	43	60	0	0	0
1253	16	1	1	32	60	3	1	0
1253	288	1	1	50	60	5	0	0
1253	392	0	0	45	60	5	0	0
1253	438	1	0	38	60	4	0	0
1253	76	2	0	22	60	1	0	0
1253	45	0	0	43	60	1	0	0
1253	463	1	1	23	60	4	0	0
1254	394	2	0	33	60	2	0	0
1254	384	1	1	47	60	1	1	0
1254	169	0	1	49	60	1	1	0
1254	146	0	1	30	60	0	0	0
1254	294	2	1	25	60	3	0	0
1254	470	2	0	25	60	0	0	0
1254	286	0	1	25	60	3	0	0
1254	363	1	1	37	60	0	1	0
1255	153	1	1	35	60	1	0	0
1255	159	0	1	43	60	1	0	0
1255	343	0	1	50	60	1	0	0
1255	272	0	0	38	60	2	1	0
1255	96	2	0	44	60	5	0	0
1255	148	2	1	27	60	2	0	0
1255	479	1	1	46	60	1	0	0
1255	409	0	0	31	60	5	0	0
1256	13	1	1	33	60	5	0	0
1256	449	2	1	46	60	3	0	0
1256	403	0	0	47	60	5	0	0
1256	399	0	1	33	60	0	0	0
1256	465	0	0	27	60	1	0	0
1256	375	1	0	31	60	1	0	0
1256	27	0	0	48	60	4	1	0
1256	376	1	0	33	60	1	1	0
1257	439	1	1	35	60	1	1	0
1257	251	0	1	28	60	4	0	0
1257	311	0	1	38	60	3	0	0
1257	372	1	1	37	60	5	0	0
1257	388	1	0	36	60	2	0	0
1257	299	2	1	25	60	4	0	0
1257	127	2	0	26	60	5	0	0
1257	17	2	0	23	60	2	0	0
1258	327	1	0	41	60	4	1	0
1258	320	0	1	26	60	0	1	0
1258	375	1	0	50	60	3	1	0
1258	6	0	0	34	60	3	1	0
1258	493	1	1	36	60	3	0	0
1258	443	0	1	32	60	5	1	0
1258	271	0	0	50	60	5	0	0
1258	221	1	0	24	60	4	0	0
1259	115	0	0	41	60	2	0	0
1259	3	1	1	50	60	4	0	0
1259	413	2	1	40	60	5	0	0
1259	463	1	0	40	60	2	0	0
1259	166	2	1	37	60	2	0	0
1259	59	2	0	29	60	0	0	0
1259	456	1	0	30	60	0	0	0
1259	393	0	0	26	60	2	0	0
1260	120	0	1	34	60	3	0	0
1260	89	1	0	41	60	4	0	0
1260	486	2	0	29	60	5	0	0
1260	185	0	1	40	60	1	0	0
1260	286	1	0	20	60	5	0	0
1260	109	1	0	45	60	2	0	0
1260	263	2	1	29	60	2	1	0
1260	69	1	0	22	60	0	0	0
1261	141	1	1	33	60	2	0	0
1261	232	1	1	28	60	1	1	0
1261	477	0	0	49	60	2	0	0
1261	109	1	1	44	60	0	0	0
1261	348	1	1	22	60	4	1	0
1261	382	1	1	43	60	5	0	0
1261	167	0	1	44	60	2	1	0
1261	33	2	0	32	60	2	1	0
1262	455	0	0	20	60	1	0	0
1262	191	2	1	32	60	1	0	0
1262	299	1	0	45	60	2	0	0
1262	93	1	0	27	60	0	1	0
1262	203	0	0	39	60	5	0	0
1262	373	0	1	22	60	5	1	0
1262	489	2	0	36	60	2	0	0
1262	256	0	1	24	60	2	0	0
1263	384	1	0	49	60	5	1	0
1263	417	2	0	25	60	4	0	0
1263	264	2	1	41	60	2	0	0
1263	286	2	1	35	60	0	1	0
1263	491	2	0	43	60	3	0	0
1263	306	1	0	42	60	5	0	0
1263	16	2	0	32	60	3	1	0
1263	267	2	0	37	60	4	0	0
1264	351	0	1	39	60	4	1	0
1264	241	1	1	28	60	1	0	0
1264	498	0	1	43	60	2	1	0
1264	167	0	0	37	60	1	0	0
1264	388	0	1	49	60	2	0	0
1264	499	0	1	28	60	4	1	0
1264	456	1	1	22	60	3	0	0
1264	247	2	1	25	60	5	0	0
1265	404	0	1	37	60	0	1	0
1265	439	2	1	30	60	2	0	0
1265	279	1	1	47	60	1	0	0
1265	368	2	0	20	60	1	0	0
1265	79	1	1	33	60	2	0	0
1265	99	1	1	22	60	5	1	0
1265	241	0	1	34	60	4	0	0
1265	479	1	1	26	60	0	0	0
1266	495	1	0	46	60	5	0	0
1266	293	0	1	29	60	3	0	0
1266	494	2	1	46	60	3	0	0
1266	67	0	1	47	60	3	0	0
1266	227	0	0	27	60	0	0	0
1266	134	0	1	44	60	5	0	0
1266	147	1	0	41	60	0	0	0
1266	313	1	0	34	60	5	0	0
1267	252	1	1	42	60	1	0	0
1267	144	1	1	36	60	3	0	0
1267	297	2	0	25	60	4	0	0
1267	94	1	1	36	60	0	0	0
1267	390	2	1	26	60	0	1	0
1267	36	0	1	44	60	1	1	0
1267	211	2	1	23	60	4	0	0
1267	150	2	1	48	60	2	0	0
1268	500	0	1	25	60	0	0	0
1268	6	2	1	43	60	2	0	0
1268	344	0	0	27	60	0	0	0
1268	306	2	0	33	60	3	0	0
1268	20	1	1	24	60	1	1	0
1268	92	0	0	40	60	5	1	0
1268	196	1	0	20	60	3	0	0
1268	55	0	1	28	60	5	0	0
1269	500	2	0	42	60	1	0	0
1269	352	0	0	30	60	1	0	0
1269	338	1	0	35	60	1	0	0
1269	18	0	0	22	60	4	1	0
1269	174	0	0	38	60	1	0	0
1269	167	0	1	23	60	4	0	0
1269	100	1	0	32	60	5	0	0
1269	22	1	1	39	60	5	0	0
1270	274	0	1	38	60	3	0	0
1270	371	2	1	26	60	2	0	0
1270	33	2	0	22	60	4	0	0
1270	84	0	1	47	60	3	0	0
1270	394	1	1	28	60	0	0	0
1270	442	1	1	29	60	2	0	0
1270	71	0	1	43	60	2	0	0
1270	224	1	0	39	60	4	1	0
1271	359	2	0	30	60	3	0	0
1271	26	1	1	41	60	2	0	0
1271	16	0	1	27	60	4	1	0
1271	347	1	1	44	60	2	0	0
1271	320	0	0	42	60	1	1	0
1271	121	2	1	24	60	5	0	0
1271	322	1	1	49	60	5	1	0
1271	500	2	0	50	60	3	0	0
1272	420	0	0	27	60	4	0	0
1272	194	2	0	36	60	5	0	0
1272	99	0	0	25	60	2	1	0
1272	90	1	1	43	60	2	0	0
1272	312	1	0	23	60	3	0	0
1272	151	2	1	35	60	0	1	0
1272	202	1	0	27	60	3	0	0
1272	197	1	0	36	60	1	0	0
1273	394	0	1	24	60	4	0	0
1273	391	1	1	24	60	4	0	0
1273	4	0	0	30	60	0	1	0
1273	283	0	0	43	60	2	1	0
1273	118	2	0	49	60	4	0	0
1273	114	0	1	35	60	5	1	0
1273	154	0	0	40	60	2	1	0
1273	24	0	0	37	60	2	0	0
1274	67	0	1	47	60	5	0	0
1274	458	1	1	29	60	3	0	0
1274	396	2	1	25	60	3	1	0
1274	223	1	1	43	60	0	0	0
1274	278	1	0	24	60	5	0	0
1274	248	2	1	42	60	4	1	0
1274	344	1	0	49	60	2	0	0
1274	305	0	1	38	60	5	0	0
1275	255	1	0	48	60	4	0	0
1275	233	2	0	41	60	1	0	0
1275	208	0	1	32	60	3	1	0
1275	109	2	1	35	60	2	0	0
1275	316	1	1	22	60	0	1	0
1275	422	0	1	48	60	0	1	0
1275	463	0	0	49	60	4	0	0
1275	67	0	0	35	60	3	0	0
1276	320	1	1	23	60	4	1	0
1276	149	0	0	29	60	5	1	0
1276	369	1	1	44	60	3	0	0
1276	306	0	0	26	60	4	0	0
1276	362	1	0	40	60	2	0	0
1276	343	0	1	40	60	3	0	0
1276	297	0	1	34	60	0	0	0
1276	98	1	1	31	60	2	0	0
1277	161	0	1	37	60	1	0	0
1277	494	0	1	46	60	4	1	0
1277	391	2	0	26	60	4	0	0
1277	287	1	0	38	60	1	0	0
1277	173	1	1	29	60	0	0	0
1277	45	2	1	36	60	2	1	0
1277	384	2	0	32	60	5	0	0
1277	336	1	0	34	60	3	0	0
1278	70	2	1	38	60	1	0	0
1278	481	2	1	21	60	0	0	0
1278	53	0	1	46	60	3	0	0
1278	284	1	1	48	60	1	0	0
1278	357	1	1	40	60	0	1	0
1278	31	1	1	41	60	1	0	0
1278	253	0	1	33	60	2	0	0
1278	208	2	1	39	60	5	1	0
1279	89	2	1	26	60	5	0	0
1279	457	1	0	44	60	3	1	0
1279	334	2	1	33	60	0	0	0
1279	212	2	1	40	60	1	0	0
1279	112	0	0	27	60	4	1	0
1279	82	1	1	44	60	5	0	0
1279	69	1	0	26	60	4	0	0
1279	218	1	1	43	60	3	0	0
1280	269	0	0	22	60	4	0	0
1280	139	1	0	23	60	5	1	0
1280	71	0	0	50	60	5	0	0
1280	117	2	1	37	60	3	0	0
1280	471	0	0	44	60	1	0	0
1280	434	0	1	50	60	5	0	0
1280	62	2	0	44	60	5	0	0
1280	270	0	0	47	60	5	1	0
1281	249	1	1	43	60	0	1	0
1281	276	1	1	34	60	4	1	0
1281	171	0	0	28	60	0	0	0
1281	217	2	0	39	60	1	0	0
1281	383	2	0	26	60	2	0	0
1281	179	1	1	30	60	2	0	0
1281	124	2	1	42	60	5	0	0
1281	112	0	0	26	60	5	1	0
1282	378	2	0	30	60	1	0	0
1282	239	0	1	37	60	3	0	0
1282	330	1	1	49	60	0	1	0
1282	227	1	0	35	60	4	0	0
1282	278	2	0	41	60	3	1	0
1282	292	2	0	35	60	4	0	0
1282	267	1	1	35	60	2	0	0
1282	325	0	1	36	60	3	0	0
1283	192	1	0	20	60	3	0	0
1283	417	1	0	40	60	1	1	0
1283	158	0	1	37	60	1	0	0
1283	21	2	0	31	60	2	0	0
1283	251	1	0	40	60	2	0	0
1283	455	1	1	48	60	5	1	0
1283	76	1	0	24	60	5	0	0
1283	329	0	0	45	60	4	1	0
1284	105	1	0	44	60	2	0	0
1284	302	0	0	44	60	2	0	0
1284	307	0	1	25	60	1	1	0
1284	50	2	0	33	60	2	0	0
1284	459	2	0	43	60	1	0	0
1284	226	0	1	40	60	3	0	0
1284	284	2	0	38	60	1	1	0
1284	182	2	1	24	60	1	0	0
1285	158	2	1	36	60	1	1	0
1285	232	1	1	43	60	0	1	0
1285	168	1	1	38	60	0	0	0
1285	465	2	0	37	60	0	0	0
1285	150	2	1	41	60	2	0	0
1285	370	1	0	22	60	4	1	0
1285	451	2	1	35	60	1	0	0
1285	27	0	1	22	60	0	0	0
1286	477	0	0	32	60	3	0	0
1286	333	1	0	37	60	2	0	0
1286	310	1	1	38	60	1	1	0
1286	481	0	1	49	60	2	0	0
1286	208	1	1	45	60	3	0	0
1286	76	2	0	35	60	5	0	0
1286	309	2	1	29	60	2	0	0
1286	341	2	1	48	60	0	0	0
1287	148	2	0	47	60	4	0	0
1287	35	2	1	26	60	2	0	0
1287	184	2	1	38	60	4	0	0
1287	202	2	1	29	60	0	0	0
1287	77	0	0	37	60	5	0	0
1287	110	2	0	24	60	2	0	0
1287	81	0	0	43	60	0	0	0
1287	129	0	0	44	60	5	1	0
1288	347	0	1	38	60	1	1	0
1288	375	0	0	45	60	5	0	0
1288	313	0	1	27	60	2	0	0
1288	455	0	1	35	60	3	0	0
1288	250	0	0	48	60	4	0	0
1288	140	0	1	25	60	5	0	0
1288	246	1	1	44	60	3	0	0
1288	35	0	1	39	60	1	0	0
1289	328	2	1	40	60	4	1	0
1289	402	0	1	49	60	2	0	0
1289	198	1	1	31	60	5	1	0
1289	65	1	0	44	60	3	0	0
1289	200	2	1	36	60	2	1	0
1289	482	0	0	41	60	1	0	0
1289	357	2	1	34	60	3	0	0
1289	149	0	1	28	60	2	1	0
1290	249	2	1	45	60	2	0	0
1290	91	1	0	38	60	3	0	0
1290	483	2	1	41	60	0	0	0
1290	11	0	0	44	60	0	0	0
1290	386	0	0	41	60	1	0	0
1290	382	2	1	44	60	0	0	0
1290	111	2	0	47	60	1	0	0
1290	126	2	1	31	60	5	0	0
1291	175	0	0	23	60	5	0	0
1291	369	0	0	40	60	5	1	0
1291	442	2	1	32	60	4	1	0
1291	273	2	1	40	60	2	0	0
1291	217	1	0	50	60	4	1	0
1291	433	2	0	48	60	0	0	0
1291	464	2	0	35	60	3	0	0
1291	426	0	0	21	60	3	1	0
1292	178	2	0	31	60	0	0	0
1292	99	2	0	40	60	5	1	0
1292	135	0	1	31	60	2	1	0
1292	115	2	1	32	60	2	0	0
1292	327	1	0	27	60	1	0	0
1292	273	1	1	24	60	0	0	0
1292	424	1	0	26	60	4	0	0
1292	124	1	0	24	60	5	1	0
1293	208	2	0	32	60	4	0	0
1293	99	2	1	48	60	0	0	0
1293	452	1	1	25	60	4	0	0
1293	111	2	1	39	60	1	0	0
1293	356	2	0	43	60	1	0	0
1293	289	2	0	49	60	0	0	0
1293	211	0	0	28	60	2	0	0
1293	29	1	1	46	60	5	0	0
1294	463	1	0	44	60	5	0	0
1294	352	0	0	28	60	3	1	0
1294	157	1	0	34	60	0	0	0
1294	130	0	1	37	60	5	0	0
1294	269	1	1	38	60	2	1	0
1294	385	0	0	35	60	5	0	0
1294	271	2	1	50	60	3	0	0
1294	37	0	1	30	60	2	0	0
1295	461	1	1	42	60	1	0	0
1295	159	2	1	46	60	4	0	0
1295	382	2	1	49	60	1	0	0
1295	63	0	1	41	60	4	0	0
1295	207	1	0	32	60	1	0	0
1295	96	1	1	31	60	1	0	0
1295	374	1	0	32	60	0	0	0
1295	163	0	1	39	60	1	0	0
1296	130	0	1	22	60	4	0	0
1296	491	1	0	23	60	4	0	0
1296	237	1	1	40	60	1	0	0
1296	258	1	1	26	60	5	1	0
1296	182	1	1	26	60	5	0	0
1296	138	0	0	28	60	3	1	0
1296	106	2	0	47	60	5	0	0
1296	191	0	0	50	60	5	0	0
1297	205	1	0	36	60	3	0	0
1297	304	1	1	44	60	3	1	0
1297	105	1	0	43	60	2	1	0
1297	370	0	1	46	60	3	0	0
1297	13	2	0	20	60	0	0	0
1297	286	2	0	23	60	4	0	0
1297	209	2	0	40	60	0	0	0
1297	190	1	1	42	60	0	0	0
1298	241	0	1	34	60	4	1	0
1298	61	2	1	31	60	1	0	0
1298	422	2	1	45	60	1	0	0
1298	162	2	1	41	60	3	0	0
1298	106	2	0	36	60	3	0	0
1298	15	0	1	32	60	1	1	0
1298	39	1	1	27	60	0	0	0
1298	262	0	1	36	60	5	0	0
1299	363	2	0	40	60	5	0	0
1299	223	2	0	28	60	5	0	0
1299	151	2	0	28	60	5	1	0
1299	469	0	1	48	60	5	0	0
1299	136	2	0	25	60	3	0	0
1299	26	2	0	36	60	2	0	0
1299	240	1	0	49	60	4	0	0
1299	339	1	1	49	60	1	0	0
1300	148	0	1	31	60	2	0	0
1300	300	0	0	36	60	3	0	0
1300	468	2	0	45	60	4	1	0
1300	434	0	0	47	60	4	0	0
1300	427	0	0	49	60	1	0	0
1300	315	0	0	43	60	1	0	0
1300	286	0	0	33	60	2	0	0
1300	287	0	1	42	60	2	0	0
1301	476	0	1	34	60	3	0	0
1301	47	2	0	39	60	5	0	0
1301	180	1	0	33	60	4	0	0
1301	464	1	0	25	60	2	0	0
1301	332	2	0	44	60	5	0	0
1301	16	2	0	36	60	0	0	0
1301	443	0	0	27	60	0	0	0
1301	104	2	1	42	60	4	0	0
1302	271	1	0	21	60	4	0	0
1302	140	1	0	39	60	2	0	0
1302	314	1	1	21	60	2	0	0
1302	485	0	0	46	60	3	0	0
1302	205	2	0	46	60	5	0	0
1302	51	0	0	48	60	1	1	0
1302	289	0	1	29	60	1	1	0
1302	363	1	0	29	60	3	0	0
1303	249	2	0	35	60	3	1	0
1303	79	1	1	34	60	4	0	0
1303	86	0	0	34	60	5	1	0
1303	77	1	1	30	60	5	0	0
1303	134	2	1	33	60	0	0	0
1303	30	0	1	31	60	1	0	0
1303	74	2	1	41	60	0	0	0
1303	158	1	1	24	60	5	0	0
1304	205	0	0	36	60	3	0	0
1304	183	1	1	48	60	2	1	0
1304	153	2	1	29	60	0	0	0
1304	104	1	0	22	60	5	0	0
1304	34	1	1	34	60	0	0	0
1304	270	2	1	37	60	4	0	0
1304	36	2	0	34	60	2	0	0
1304	123	1	1	42	60	0	0	0
1305	316	2	1	50	60	1	1	0
1305	450	1	0	31	60	2	0	0
1305	444	0	0	40	60	2	0	0
1305	221	0	1	21	60	0	0	0
1305	114	1	0	34	60	0	0	0
1305	107	1	1	42	60	5	0	0
1305	57	2	0	31	60	1	1	0
1305	458	1	0	41	60	4	1	0
1306	100	0	1	26	60	1	0	0
1306	382	0	1	25	60	1	1	0
1306	107	0	0	36	60	3	1	0
1306	377	2	0	42	60	4	0	0
1306	23	2	1	36	60	5	0	0
1306	423	2	1	29	60	3	1	0
1306	57	1	0	36	60	3	0	0
1306	143	2	1	26	60	2	0	0
1307	66	1	1	50	60	2	0	0
1307	350	1	0	39	60	4	0	0
1307	136	2	0	39	60	4	0	0
1307	477	1	1	42	60	0	0	0
1307	134	1	0	44	60	5	0	0
1307	159	0	0	39	60	3	0	0
1307	488	1	0	40	60	0	0	0
1307	299	2	0	40	60	5	0	0
1308	299	2	0	37	60	3	1	0
1308	216	1	1	21	60	3	0	0
1308	67	2	0	28	60	3	0	0
1308	26	2	0	24	60	0	0	0
1308	36	1	0	22	60	0	1	0
1308	430	2	0	49	60	4	1	0
1308	96	2	1	20	60	2	1	0
1308	178	0	0	29	60	0	0	0
1309	376	1	0	29	60	0	1	0
1309	224	1	1	24	60	2	0	0
1309	441	0	1	26	60	3	0	0
1309	194	0	1	35	60	3	0	0
1309	462	0	1	49	60	4	0	0
1309	150	0	0	40	60	4	0	0
1309	362	2	0	49	60	2	1	0
1309	5	1	0	20	60	3	0	0
1310	376	0	0	24	60	5	1	0
1310	254	2	1	37	60	4	1	0
1310	94	0	0	37	60	5	0	0
1310	483	1	0	30	60	2	1	0
1310	266	2	0	22	60	4	0	0
1310	151	0	0	29	60	1	1	0
1310	342	0	0	32	60	2	0	0
1310	58	0	1	45	60	5	0	0
1311	500	2	1	20	60	0	0	0
1311	153	0	0	32	60	5	0	0
1311	28	2	1	46	60	3	0	0
1311	337	0	0	33	60	2	0	0
1311	255	0	0	25	60	0	0	0
1311	65	0	0	26	60	1	0	0
1311	179	1	0	50	60	5	0	0
1311	254	0	1	44	60	4	0	0
1312	474	2	0	31	60	0	0	0
1312	59	1	0	46	60	3	1	0
1312	104	1	1	43	60	3	0	0
1312	312	1	1	28	60	3	0	0
1312	364	0	0	32	60	0	0	0
1312	94	0	1	24	60	3	1	0
1312	499	1	1	49	60	4	1	0
1312	187	2	0	22	60	0	1	0
1313	257	2	0	29	60	4	0	0
1313	44	1	0	35	60	4	0	0
1313	271	0	0	50	60	4	0	0
1313	437	1	1	32	60	4	0	0
1313	64	0	1	42	60	3	0	0
1313	70	0	0	42	60	3	0	0
1313	445	1	0	42	60	3	0	0
1313	252	1	1	28	60	4	0	0
1314	95	0	1	43	60	2	0	0
1314	355	1	0	34	60	1	1	0
1314	283	1	0	33	60	1	0	0
1314	446	1	1	46	60	5	0	0
1314	402	0	0	49	60	3	0	0
1314	450	0	1	50	60	5	1	0
1314	258	0	0	37	60	0	0	0
1314	416	2	0	48	60	0	0	0
1315	454	0	0	48	60	4	0	0
1315	342	0	0	20	60	1	1	0
1315	197	2	1	40	60	5	0	0
1315	38	2	1	41	60	0	0	0
1315	391	2	1	39	60	2	0	0
1315	192	2	1	37	60	5	0	0
1315	281	1	0	29	60	1	0	0
1315	66	0	1	30	60	1	0	0
1316	54	2	1	40	60	1	0	0
1316	71	0	0	33	60	0	1	0
1316	123	0	0	28	60	1	0	0
1316	26	0	1	49	60	2	0	0
1316	377	0	0	35	60	0	1	0
1316	232	0	0	32	60	4	0	0
1316	300	2	1	25	60	1	0	0
1316	103	0	0	22	60	2	0	0
1317	380	2	0	41	60	2	1	0
1317	151	2	1	47	60	1	0	0
1317	111	1	0	46	60	2	1	0
1317	220	1	1	26	60	3	0	0
1317	232	0	1	40	60	5	1	0
1317	3	2	0	43	60	4	0	0
1317	319	2	1	33	60	3	0	0
1317	77	1	1	21	60	0	0	0
1318	157	0	1	27	60	4	0	0
1318	204	2	1	42	60	5	0	0
1318	84	1	0	30	60	0	0	0
1318	286	1	0	28	60	0	0	0
1318	63	2	0	35	60	4	0	0
1318	52	1	0	46	60	5	0	0
1318	432	2	1	44	60	1	0	0
1318	130	1	1	37	60	4	0	0
1319	384	2	0	24	60	0	0	0
1319	76	0	1	34	60	5	0	0
1319	123	0	0	21	60	4	0	0
1319	124	2	0	37	60	4	0	0
1319	260	0	1	25	60	5	0	0
1319	165	1	1	24	60	5	0	0
1319	200	1	1	28	60	2	1	0
1319	352	2	0	20	60	1	0	0
1320	334	0	0	47	60	4	0	0
1320	416	1	0	35	60	2	1	0
1320	167	0	0	28	60	0	0	0
1320	110	2	0	41	60	4	0	0
1320	453	1	1	30	60	0	1	0
1320	146	0	1	20	60	2	0	0
1320	221	2	1	50	60	4	1	0
1320	17	2	1	26	60	0	0	0
1321	174	0	1	38	60	3	0	0
1321	180	1	0	47	60	4	0	0
1321	19	0	0	50	60	5	0	0
1321	430	2	0	41	60	3	1	0
1321	118	1	0	36	60	0	0	0
1321	460	2	1	46	60	3	0	0
1321	229	0	1	20	60	0	1	0
1321	340	1	1	44	60	3	0	0
1322	321	2	1	21	60	4	0	0
1322	346	2	0	23	60	5	1	0
1322	473	1	1	29	60	5	0	0
1322	325	2	0	26	60	1	1	0
1322	224	1	1	21	60	5	1	0
1322	498	1	0	21	60	5	0	0
1322	190	2	1	22	60	3	0	0
1322	280	2	0	22	60	4	1	0
1323	325	2	1	20	60	0	1	0
1323	287	2	0	38	60	3	1	0
1323	315	2	1	42	60	4	0	0
1323	281	0	0	46	60	0	0	0
1323	293	2	0	32	60	1	1	0
1323	70	1	1	42	60	0	1	0
1323	384	1	1	30	60	0	0	0
1323	429	0	1	30	60	3	1	0
1324	383	2	1	32	60	5	0	0
1324	485	2	1	32	60	1	0	0
1324	355	2	0	26	60	1	1	0
1324	437	1	0	38	60	2	0	0
1324	159	2	1	24	60	2	1	0
1324	315	2	1	30	60	2	0	0
1324	244	0	0	30	60	3	0	0
1324	380	2	0	34	60	3	0	0
1325	474	0	1	43	60	2	0	0
1325	494	1	0	27	60	0	0	0
1325	144	2	0	25	60	5	1	0
1325	106	1	1	37	60	4	0	0
1325	444	1	0	48	60	2	0	0
1325	322	2	1	50	60	0	1	0
1325	408	2	1	32	60	5	0	0
1325	385	0	0	35	60	2	0	0
1326	53	1	1	35	60	3	1	0
1326	102	1	1	28	60	2	0	0
1326	393	2	1	46	60	3	0	0
1326	338	2	1	41	60	0	0	0
1326	23	1	1	33	60	5	0	0
1326	358	1	1	30	60	4	0	0
1326	367	0	1	21	60	4	0	0
1326	164	0	1	29	60	2	0	0
1327	12	2	0	48	60	4	0	0
1327	350	1	0	24	60	4	0	0
1327	340	1	0	44	60	2	0	0
1327	294	1	0	27	60	4	0	0
1327	220	0	1	49	60	0	0	0
1327	441	0	1	23	60	4	0	0
1327	128	2	0	36	60	5	0	0
1327	221	0	0	22	60	5	0	0
1328	483	1	1	41	60	2	0	0
1328	445	2	0	33	60	0	0	0
1328	124	2	1	22	60	2	0	0
1328	162	0	1	38	60	1	0	0
1328	117	0	1	42	60	5	0	0
1328	500	1	0	45	60	2	1	0
1328	243	0	1	49	60	5	0	0
1328	182	2	0	46	60	3	0	0
1329	484	0	0	28	60	1	0	0
1329	418	0	0	31	60	3	0	0
1329	237	0	1	43	60	5	1	0
1329	245	1	1	39	60	0	0	0
1329	255	2	0	25	60	1	0	0
1329	186	1	0	21	60	1	0	0
1329	486	0	1	37	60	2	1	0
1329	154	2	1	39	60	0	1	0
1330	80	1	1	28	60	2	0	0
1330	110	0	0	27	60	3	0	0
1330	8	0	0	48	60	0	0	0
1330	82	0	0	49	60	5	0	0
1330	22	1	0	26	60	0	0	0
1330	208	1	0	22	60	4	0	0
1330	374	1	0	44	60	3	1	0
1330	173	2	0	30	60	1	0	0
1331	315	0	1	44	60	0	0	0
1331	417	0	0	42	60	0	0	0
1331	442	1	0	26	60	0	0	0
1331	437	0	0	32	60	5	0	0
1331	419	1	1	38	60	3	0	0
1331	373	1	0	22	60	5	0	0
1331	141	1	1	45	60	0	0	0
1331	232	0	0	47	60	5	1	0
1332	95	0	0	28	60	4	0	0
1332	86	2	1	22	60	3	1	0
1332	131	0	1	26	60	2	1	0
1332	434	1	1	38	60	3	0	0
1332	487	2	0	39	60	4	1	0
1332	219	1	0	49	60	2	0	0
1332	195	0	0	44	60	1	1	0
1332	419	2	0	46	60	1	0	0
1333	300	2	0	40	60	3	1	0
1333	445	1	1	29	60	3	0	0
1333	485	2	0	23	60	4	0	0
1333	476	2	0	31	60	5	0	0
1333	466	1	1	26	60	1	0	0
1333	282	2	1	37	60	2	1	0
1333	347	2	0	30	60	0	0	0
1333	354	2	0	36	60	1	0	0
1334	82	0	0	37	60	5	1	0
1334	170	0	0	46	60	3	0	0
1334	136	1	0	24	60	3	1	0
1334	482	1	1	22	60	0	0	0
1334	493	2	0	30	60	5	0	0
1334	293	1	0	28	60	3	0	0
1334	498	0	0	40	60	5	0	0
1334	150	0	1	21	60	2	0	0
1335	52	1	1	41	60	3	0	0
1335	481	2	1	23	60	0	1	0
1335	361	0	0	36	60	2	0	0
1335	83	1	1	33	60	5	1	0
1335	28	0	1	26	60	3	1	0
1335	108	1	1	44	60	0	0	0
1335	93	1	0	45	60	3	1	0
1335	491	2	0	42	60	5	1	0
1336	11	0	1	49	60	3	0	0
1336	423	0	0	44	60	2	1	0
1336	341	1	1	25	60	3	0	0
1336	26	1	0	25	60	1	0	0
1336	331	0	0	39	60	3	0	0
1336	267	1	1	28	60	5	0	0
1336	297	1	0	40	60	0	1	0
1336	157	1	0	44	60	4	0	0
1337	222	2	1	22	60	2	1	0
1337	340	2	1	42	60	1	1	0
1337	373	2	0	22	60	3	0	0
1337	187	2	0	26	60	0	1	0
1337	312	0	1	29	60	1	0	0
1337	295	1	1	40	60	0	0	0
1337	85	2	0	37	60	4	0	0
1337	422	2	1	34	60	4	0	0
1338	46	1	0	40	60	1	0	0
1338	11	1	1	25	60	5	0	0
1338	226	0	0	21	60	0	0	0
1338	391	1	0	32	60	4	0	0
1338	266	0	0	47	60	5	0	0
1338	36	2	1	38	60	5	0	0
1338	103	0	0	46	60	3	0	0
1338	344	2	1	48	60	0	0	0
1339	142	2	0	30	60	3	0	0
1339	199	1	0	25	60	3	0	0
1339	315	2	0	42	60	2	0	0
1339	23	1	1	42	60	1	1	0
1339	98	1	1	41	60	0	0	0
1339	212	2	0	26	60	2	1	0
1339	38	2	1	43	60	3	0	0
1339	378	1	0	33	60	0	0	0
1340	232	1	0	44	60	3	1	0
1340	468	0	1	44	60	4	0	0
1340	342	1	0	20	60	3	1	0
1340	174	0	0	45	60	0	0	0
1340	408	2	0	39	60	5	0	0
1340	76	2	0	37	60	3	0	0
1340	281	2	1	43	60	3	0	0
1340	68	1	0	27	60	2	1	0
1341	91	1	0	21	60	2	0	0
1341	454	1	0	41	60	3	1	0
1341	83	1	1	43	60	1	1	0
1341	158	0	1	42	60	2	0	0
1341	320	0	1	40	60	0	0	0
1341	87	0	1	50	60	2	0	0
1341	25	0	1	45	60	3	0	0
1341	373	1	1	45	60	2	0	0
1342	373	0	0	40	60	0	0	0
1342	103	1	1	37	60	0	1	0
1342	154	2	1	47	60	2	0	0
1342	368	2	1	36	60	0	0	0
1342	419	1	0	42	60	3	0	0
1342	144	2	0	36	60	2	1	0
1342	294	2	0	24	60	2	1	0
1342	460	2	1	31	60	5	0	0
1343	488	1	0	32	60	0	0	0
1343	115	0	0	32	60	3	0	0
1343	484	2	0	45	60	2	0	0
1343	229	2	0	45	60	3	0	0
1343	4	0	0	26	60	5	0	0
1343	120	0	1	47	60	5	0	0
1343	434	2	0	37	60	2	0	0
1343	10	0	1	41	60	0	1	0
1344	283	0	0	28	60	1	1	0
1344	439	0	0	24	60	4	0	0
1344	167	0	1	46	60	4	0	0
1344	80	0	1	28	60	2	1	0
1344	318	1	0	36	60	3	0	0
1344	433	2	0	30	60	1	0	0
1344	454	0	0	50	60	0	0	0
1344	195	0	1	25	60	0	0	0
1345	3	0	0	32	60	1	0	0
1345	420	2	1	36	60	4	0	0
1345	378	1	1	36	60	0	0	0
1345	421	0	1	30	60	0	0	0
1345	295	1	0	34	60	2	1	0
1345	308	0	0	35	60	3	0	0
1345	258	1	0	40	60	4	0	0
1345	111	2	0	32	60	3	1	0
1346	12	2	1	46	60	1	1	0
1346	428	2	0	40	60	1	0	0
1346	42	0	1	41	60	5	0	0
1346	324	0	0	30	60	0	0	0
1346	362	2	0	36	60	0	0	0
1346	221	2	1	35	60	1	1	0
1346	47	1	1	46	60	4	1	0
1346	333	0	0	39	60	4	1	0
1347	384	2	0	43	60	2	1	0
1347	363	2	1	36	60	4	0	0
1347	54	2	0	35	60	0	0	0
1347	341	0	1	44	60	4	0	0
1347	37	2	0	32	60	0	0	0
1347	115	2	1	39	60	2	0	0
1347	322	0	1	27	60	1	1	0
1347	253	0	1	21	60	1	0	0
1348	231	0	0	42	60	4	1	0
1348	352	0	1	27	60	0	0	0
1348	34	1	0	32	60	1	0	0
1348	272	2	1	27	60	3	1	0
1348	57	2	1	31	60	2	0	0
1348	258	0	1	42	60	1	0	0
1348	177	0	0	34	60	2	0	0
1348	23	0	0	48	60	0	0	0
1349	90	1	1	45	60	5	0	0
1349	151	0	1	28	60	4	1	0
1349	166	1	1	41	60	1	0	0
1349	475	2	0	25	60	0	1	0
1349	308	0	0	27	60	3	0	0
1349	353	2	0	50	60	4	0	0
1349	495	0	0	31	60	5	0	0
1349	421	2	0	43	60	2	0	0
1350	380	0	1	47	60	3	1	0
1350	416	2	0	32	60	0	0	0
1350	340	2	1	43	60	0	0	0
1350	402	2	1	38	60	1	1	0
1350	334	1	1	49	60	1	1	0
1350	199	2	0	28	60	2	1	0
1350	351	0	0	40	60	3	1	0
1350	149	1	0	47	60	1	0	0
1351	195	2	1	27	60	2	0	0
1351	246	1	1	42	60	4	0	0
1351	264	1	1	50	60	0	1	0
1351	194	1	0	20	60	5	0	0
1351	430	0	0	46	60	5	1	0
1351	64	0	0	48	60	4	0	0
1351	455	1	0	46	60	0	0	0
1351	183	1	0	46	60	4	0	0
1352	33	1	1	32	60	1	1	0
1352	338	2	1	44	60	4	0	0
1352	468	2	0	21	60	1	1	0
1352	38	2	1	36	60	0	1	0
1352	282	1	0	27	60	2	1	0
1352	134	2	1	29	60	3	0	0
1352	89	0	1	32	60	1	0	0
1352	73	2	1	50	60	1	1	0
1353	210	2	0	34	60	5	0	0
1353	435	2	0	47	60	0	0	0
1353	400	0	0	33	60	5	0	0
1353	144	1	1	31	60	4	0	0
1353	256	2	1	29	60	4	0	0
1353	355	2	1	32	60	3	0	0
1353	275	1	1	32	60	3	1	0
1353	376	2	0	45	60	0	0	0
1354	334	1	1	42	60	2	0	0
1354	174	2	0	22	60	0	1	0
1354	280	2	1	48	60	0	0	0
1354	124	0	1	40	60	4	1	0
1354	117	0	1	42	60	4	0	0
1354	389	1	1	36	60	4	0	0
1354	168	2	0	43	60	4	0	0
1354	227	2	1	47	60	3	0	0
1355	53	1	1	27	60	1	1	0
1355	194	0	0	37	60	1	0	0
1355	94	2	0	50	60	0	0	0
1355	352	2	1	30	60	4	0	0
1355	314	1	1	31	60	5	1	0
1355	467	1	0	38	60	5	0	0
1355	149	0	0	23	60	3	0	0
1355	297	1	0	47	60	5	1	0
1356	298	2	1	44	60	2	0	0
1356	214	0	1	34	60	2	1	0
1356	311	0	0	49	60	2	1	0
1356	370	0	0	29	60	4	1	0
1356	53	2	0	31	60	3	0	0
1356	407	0	1	32	60	0	0	0
1356	421	1	1	36	60	4	0	0
1356	384	2	0	35	60	3	0	0
1357	209	1	1	30	60	2	0	0
1357	80	0	1	29	60	0	0	0
1357	477	0	1	31	60	2	1	0
1357	287	0	1	48	60	3	0	0
1357	316	0	1	49	60	5	0	0
1357	234	1	0	28	60	1	0	0
1357	312	0	1	38	60	4	0	0
1357	301	0	1	26	60	2	0	0
1358	92	0	1	50	60	4	1	0
1358	267	1	0	33	60	5	0	0
1358	353	1	1	29	60	1	0	0
1358	148	0	0	47	60	1	1	0
1358	462	0	1	33	60	0	0	0
1358	480	1	1	23	60	5	1	0
1358	118	0	0	35	60	2	0	0
1358	361	2	1	40	60	1	0	0
1359	100	1	0	33	60	3	0	0
1359	93	2	0	21	60	1	0	0
1359	415	0	0	50	60	2	0	0
1359	13	1	0	50	60	4	0	0
1359	148	1	1	25	60	2	0	0
1359	11	2	1	44	60	3	0	0
1359	35	0	1	46	60	1	0	0
1359	280	0	1	43	60	2	0	0
1360	500	2	0	41	60	0	0	0
1360	26	0	1	40	60	0	0	0
1360	415	0	0	32	60	4	0	0
1360	184	0	0	20	60	4	0	0
1360	351	0	0	40	60	0	0	0
1360	431	1	0	31	60	5	0	0
1360	303	1	0	46	60	3	1	0
1360	286	2	1	36	60	0	1	0
1361	490	0	1	49	60	3	0	0
1361	176	1	0	35	60	4	1	0
1361	96	1	1	43	60	1	1	0
1361	91	1	1	48	60	2	1	0
1361	441	2	0	24	60	5	1	0
1361	341	2	1	21	60	3	0	0
1361	289	1	0	39	60	3	1	0
1361	164	1	0	28	60	2	0	0
1362	467	1	0	33	60	3	0	0
1362	115	2	1	31	60	3	0	0
1362	255	0	1	35	60	4	0	0
1362	246	2	1	45	60	3	1	0
1362	87	0	1	36	60	5	1	0
1362	241	0	1	42	60	1	0	0
1362	494	2	1	28	60	1	0	0
1362	9	2	1	39	60	0	0	0
1363	180	2	1	31	60	4	0	0
1363	117	2	1	23	60	1	0	0
1363	283	0	0	47	60	4	1	0
1363	395	2	0	47	60	1	1	0
1363	109	1	0	46	60	0	0	0
1363	276	0	0	45	60	0	0	0
1363	440	1	0	31	60	0	0	0
1363	5	1	1	34	60	2	0	0
1364	323	1	1	42	60	1	0	0
1364	253	0	1	35	60	0	0	0
1364	151	2	1	33	60	1	0	0
1364	244	0	0	38	60	2	0	0
1364	70	2	1	21	60	4	0	0
1364	176	2	0	46	60	0	0	0
1364	480	2	0	36	60	5	1	0
1364	459	2	0	28	60	1	0	0
1365	133	1	1	30	60	5	1	0
1365	216	2	0	49	60	2	0	0
1365	238	0	0	49	60	2	0	0
1365	87	0	1	47	60	3	0	0
1365	256	1	1	39	60	5	1	0
1365	308	0	1	39	60	1	0	0
1365	428	2	0	26	60	0	0	0
1365	327	1	0	37	60	4	0	0
1366	72	0	1	41	60	1	0	0
1366	288	0	0	45	60	0	1	0
1366	450	0	0	35	60	1	0	0
1366	269	0	1	29	60	1	1	0
1366	244	2	1	32	60	4	1	0
1366	282	1	0	41	60	3	0	0
1366	204	2	1	24	60	5	0	0
1366	470	0	0	22	60	2	0	0
1367	261	2	1	27	60	4	1	0
1367	247	0	0	32	60	5	0	0
1367	384	0	1	34	60	4	0	0
1367	100	1	1	48	60	4	0	0
1367	123	1	0	46	60	5	1	0
1367	342	2	1	49	60	0	1	0
1367	443	0	1	22	60	0	1	0
1367	193	0	0	27	60	3	0	0
1368	140	1	0	48	60	1	0	0
1368	396	2	0	39	60	3	0	0
1368	319	0	1	30	60	0	0	0
1368	413	0	0	45	60	3	0	0
1368	39	0	1	45	60	2	0	0
1368	144	0	1	35	60	1	0	0
1368	76	1	1	44	60	2	0	0
1368	225	1	1	44	60	2	0	0
1369	262	0	0	25	60	3	0	0
1369	71	0	1	37	60	0	0	0
1369	488	0	1	23	60	5	0	0
1369	244	0	0	40	60	2	0	0
1369	334	0	0	31	60	2	0	0
1369	216	1	0	48	60	3	0	0
1369	417	1	0	38	60	0	0	0
1369	8	2	1	37	60	0	0	0
1370	281	1	0	28	60	0	0	0
1370	280	1	0	45	60	5	0	0
1370	116	0	0	34	60	3	0	0
1370	154	1	0	46	60	4	1	0
1370	218	0	0	44	60	3	0	0
1370	128	0	0	20	60	3	0	0
1370	224	2	0	44	60	4	1	0
1370	177	0	1	20	60	2	0	0
1371	257	2	1	36	60	5	0	0
1371	450	0	0	33	60	0	0	0
1371	421	1	0	46	60	1	1	0
1371	94	2	0	38	60	4	0	0
1371	126	0	0	25	60	4	1	0
1371	389	1	1	44	60	5	0	0
1371	391	2	1	47	60	5	1	0
1371	106	2	1	39	60	1	0	0
1372	299	0	1	25	60	4	0	0
1372	497	0	0	33	60	4	0	0
1372	26	2	1	31	60	3	0	0
1372	66	1	1	37	60	2	1	0
1372	79	2	1	36	60	0	0	0
1372	155	0	1	29	60	4	0	0
1372	189	1	0	43	60	1	0	0
1372	293	1	0	38	60	2	1	0
1373	111	0	0	37	60	2	0	0
1373	79	2	0	36	60	4	0	0
1373	234	2	1	37	60	3	0	0
1373	211	2	1	40	60	4	0	0
1373	151	1	0	47	60	2	0	0
1373	105	2	1	50	60	1	0	0
1373	13	0	0	32	60	0	0	0
1373	51	2	1	43	60	0	0	0
1374	373	1	0	42	60	0	1	0
1374	286	2	0	23	60	4	0	0
1374	385	1	0	23	60	1	0	0
1374	348	2	0	33	60	1	0	0
1374	190	1	1	29	60	1	1	0
1374	320	0	0	40	60	2	0	0
1374	426	1	0	27	60	0	0	0
1374	276	2	1	32	60	0	0	0
1375	90	0	1	46	60	4	0	0
1375	345	1	1	35	60	5	0	0
1375	453	1	0	20	60	0	1	0
1375	494	2	0	42	60	4	0	0
1375	244	2	0	37	60	4	0	0
1375	91	2	0	42	60	3	0	0
1375	296	1	1	39	60	2	1	0
1375	392	2	1	38	60	3	0	0
1376	337	1	0	43	60	5	0	0
1376	84	0	1	23	60	1	0	0
1376	56	1	1	40	60	2	1	0
1376	122	2	1	40	60	5	0	0
1376	254	2	1	25	60	1	0	0
1376	98	1	0	29	60	1	0	0
1376	388	1	1	37	60	1	0	0
1376	71	0	0	43	60	0	0	0
1377	90	0	0	30	60	2	0	0
1377	390	2	1	34	60	4	0	0
1377	326	1	0	34	60	4	1	0
1377	421	1	0	35	60	4	1	0
1377	200	1	1	23	60	4	0	0
1377	363	0	0	45	60	3	1	0
1377	110	0	1	44	60	0	0	0
1377	315	2	0	47	60	5	0	0
1378	335	0	1	31	60	1	1	0
1378	332	0	0	40	60	5	0	0
1378	116	2	1	25	60	1	1	0
1378	228	2	0	39	60	3	0	0
1378	297	2	1	27	60	2	0	0
1378	463	1	1	50	60	4	0	0
1378	388	0	0	39	60	0	1	0
1378	309	2	0	39	60	3	0	0
1379	459	1	0	38	60	1	1	0
1379	233	1	0	22	60	1	0	0
1379	396	2	1	27	60	5	0	0
1379	470	0	0	48	60	3	0	0
1379	156	2	1	44	60	5	0	0
1379	138	0	1	29	60	3	0	0
1379	170	1	1	50	60	2	0	0
1379	463	0	0	49	60	3	1	0
1380	180	0	0	41	60	4	0	0
1380	477	0	0	27	60	5	1	0
1380	245	1	0	44	60	2	0	0
1380	220	1	1	50	60	3	1	0
1380	110	1	0	49	60	3	1	0
1380	82	1	1	27	60	5	0	0
1380	94	1	0	46	60	5	0	0
1380	345	1	0	48	60	1	1	0
1381	102	0	0	36	60	1	1	0
1381	400	0	1	20	60	4	0	0
1381	253	2	0	48	60	1	1	0
1381	3	2	1	32	60	4	0	0
1381	356	2	0	43	60	3	1	0
1381	32	0	1	26	60	0	1	0
1381	199	2	1	21	60	0	0	0
1381	397	2	1	49	60	2	0	0
1382	85	1	0	34	60	0	0	0
1382	168	0	0	24	60	5	1	0
1382	366	2	0	50	60	2	0	0
1382	441	2	1	46	60	1	1	0
1382	239	0	1	20	60	0	0	0
1382	93	1	1	47	60	1	0	0
1382	50	0	1	25	60	5	0	0
1382	397	0	1	41	60	5	0	0
1383	86	1	1	21	60	4	1	0
1383	483	2	0	20	60	5	1	0
1383	121	2	1	29	60	1	0	0
1383	229	2	1	44	60	5	1	0
1383	41	0	0	32	60	4	1	0
1383	53	1	0	33	60	3	1	0
1383	96	0	1	30	60	0	0	0
1383	2	1	1	38	60	2	0	0
1384	268	2	0	34	60	2	0	0
1384	239	2	1	44	60	5	0	0
1384	191	0	1	36	60	1	0	0
1384	67	1	0	33	60	4	0	0
1384	420	0	1	27	60	2	0	0
1384	340	1	0	39	60	0	1	0
1384	226	1	0	46	60	3	0	0
1384	104	2	1	46	60	2	1	0
1385	403	0	1	41	60	4	0	0
1385	74	1	0	46	60	4	0	0
1385	200	2	1	46	60	4	0	0
1385	212	2	1	38	60	0	0	0
1385	473	1	0	22	60	0	1	0
1385	238	1	0	40	60	0	0	0
1385	135	2	0	47	60	3	0	0
1385	454	1	0	34	60	0	0	0
1386	385	1	1	42	60	4	1	0
1386	383	2	1	48	60	2	0	0
1386	415	2	1	32	60	4	0	0
1386	418	1	1	24	60	1	1	0
1386	161	2	1	40	60	4	0	0
1386	402	1	1	36	60	1	0	0
1386	318	0	1	45	60	1	0	0
1386	10	1	1	48	60	0	0	0
1387	182	2	0	33	60	4	0	0
1387	2	1	1	43	60	0	1	0
1387	54	0	0	25	60	5	0	0
1387	327	2	1	21	60	1	0	0
1387	92	2	0	46	60	1	0	0
1387	15	1	1	29	60	2	1	0
1387	298	1	1	38	60	3	0	0
1387	477	2	1	48	60	5	0	0
1388	80	1	0	39	60	3	1	0
1388	464	0	1	25	60	4	0	0
1388	14	2	0	47	60	0	0	0
1388	165	0	1	20	60	3	1	0
1388	267	1	1	50	60	4	0	0
1388	481	0	0	29	60	2	0	0
1388	476	2	1	30	60	0	0	0
1388	123	0	1	37	60	5	0	0
1389	129	0	0	24	60	0	1	0
1389	120	0	1	29	60	0	0	0
1389	227	2	0	32	60	0	0	0
1389	432	1	0	21	60	2	0	0
1389	284	1	1	50	60	2	1	0
1389	247	2	1	28	60	0	0	0
1389	70	1	1	46	60	0	0	0
1389	305	1	1	39	60	5	0	0
1390	332	2	0	46	60	1	1	0
1390	234	0	1	30	60	1	0	0
1390	47	0	0	43	60	4	0	0
1390	385	0	1	42	60	3	1	0
1390	3	1	1	28	60	5	1	0
1390	150	2	0	49	60	5	0	0
1390	426	0	0	22	60	5	1	0
1390	219	0	0	50	60	2	0	0
1391	30	2	1	49	60	3	0	0
1391	399	2	0	25	60	4	1	0
1391	132	1	0	41	60	2	1	0
1391	278	1	1	25	60	0	0	0
1391	433	0	0	26	60	0	0	0
1391	245	2	1	36	60	3	1	0
1391	180	1	1	20	60	1	0	0
1391	492	2	0	42	60	2	0	0
1392	417	1	0	45	60	4	0	0
1392	45	2	1	22	60	0	1	0
1392	159	2	1	36	60	3	1	0
1392	103	2	1	37	60	0	0	0
1392	447	0	0	28	60	3	0	0
1392	155	1	1	22	60	0	1	0
1392	138	0	0	44	60	2	0	0
1392	468	0	0	43	60	2	0	0
1393	238	1	1	27	60	4	1	0
1393	66	0	1	21	60	2	0	0
1393	39	1	1	34	60	4	0	0
1393	500	2	0	25	60	2	0	0
1393	466	0	0	35	60	5	1	0
1393	379	2	1	44	60	5	0	0
1393	480	2	0	21	60	3	0	0
1393	452	1	0	46	60	0	1	0
1394	428	1	1	44	60	4	1	0
1394	167	1	0	26	60	1	0	0
1394	183	1	0	49	60	1	1	0
1394	233	2	0	39	60	0	0	0
1394	206	2	1	34	60	4	0	0
1394	54	1	0	33	60	5	0	0
1394	359	1	0	43	60	5	0	0
1394	343	0	1	29	60	2	0	0
1395	409	2	1	33	60	3	0	0
1395	182	2	0	50	60	1	0	0
1395	122	1	0	39	60	3	0	0
1395	389	2	1	37	60	1	0	0
1395	398	1	0	40	60	1	1	0
1395	203	1	0	31	60	5	0	0
1395	186	0	1	48	60	0	0	0
1395	91	2	0	31	60	4	0	0
1396	294	2	1	47	60	1	0	0
1396	289	2	0	44	60	0	0	0
1396	331	2	1	26	60	1	0	0
1396	481	1	0	38	60	0	0	0
1396	373	2	1	37	60	5	0	0
1396	136	2	0	25	60	4	0	0
1396	372	2	0	21	60	4	0	0
1396	333	0	1	33	60	2	0	0
1397	371	1	0	38	60	4	1	0
1397	3	1	0	40	60	0	1	0
1397	80	0	1	50	60	1	1	0
1397	91	0	0	20	60	4	0	0
1397	152	2	0	45	60	3	0	0
1397	164	2	1	32	60	5	1	0
1397	333	0	0	27	60	0	0	0
1397	314	1	0	31	60	2	1	0
1398	133	2	0	45	60	3	0	0
1398	477	2	0	37	60	2	0	0
1398	79	0	0	20	60	2	0	0
1398	463	0	0	31	60	2	0	0
1398	247	2	1	28	60	1	0	0
1398	58	0	1	25	60	5	0	0
1398	73	1	1	23	60	3	1	0
1398	400	2	1	49	60	2	0	0
1399	79	1	0	23	60	2	0	0
1399	400	0	0	29	60	4	0	0
1399	365	1	1	21	60	0	0	0
1399	471	1	0	28	60	1	0	0
1399	80	0	0	22	60	1	0	0
1399	122	0	0	31	60	3	0	0
1399	29	2	0	48	60	1	0	0
1399	266	2	1	28	60	3	0	0
1400	326	2	1	33	60	0	0	0
1400	445	1	1	44	60	5	0	0
1400	17	2	1	35	60	4	0	0
1400	286	0	1	50	60	3	1	0
1400	492	2	0	47	60	0	0	0
1400	437	1	0	23	60	5	0	0
1400	398	1	1	35	60	5	0	0
1400	223	0	1	23	60	0	0	0
1401	315	1	1	45	60	3	0	0
1401	153	0	1	39	60	5	0	0
1401	39	1	1	22	60	1	1	0
1401	344	0	0	31	60	1	0	0
1401	55	2	0	27	60	5	1	0
1401	326	1	1	23	60	0	0	0
1401	90	1	0	23	60	0	0	0
1401	346	1	1	32	60	1	1	0
1402	420	1	0	22	60	1	0	0
1402	191	2	1	32	60	4	0	0
1402	302	0	1	50	60	3	0	0
1402	470	2	1	27	60	2	0	0
1402	104	2	1	22	60	4	1	0
1402	425	1	0	31	60	5	1	0
1402	140	2	1	29	60	1	0	0
1402	401	2	0	50	60	4	1	0
1403	258	1	0	40	60	2	0	0
1403	270	2	1	30	60	3	1	0
1403	73	1	1	38	60	5	1	0
1403	127	0	0	47	60	4	0	0
1403	47	0	1	33	60	2	1	0
1403	427	2	0	45	60	3	0	0
1403	147	2	1	44	60	1	0	0
1403	334	2	0	32	60	3	0	0
1404	112	2	1	42	60	5	0	0
1404	397	2	0	36	60	3	1	0
1404	216	1	1	50	60	2	0	0
1404	367	0	1	27	60	1	0	0
1404	422	0	0	24	60	4	0	0
1404	461	2	1	39	60	1	0	0
1404	176	0	0	37	60	5	0	0
1404	59	0	1	41	60	2	0	0
1405	228	2	1	37	60	4	0	0
1405	9	2	0	43	60	4	0	0
1405	220	2	0	45	60	5	1	0
1405	131	2	1	28	60	4	0	0
1405	213	0	0	20	60	4	0	0
1405	317	2	0	24	60	3	0	0
1405	98	2	0	22	60	5	0	0
1405	417	1	0	43	60	4	0	0
1406	255	1	0	21	60	1	0	0
1406	34	2	1	30	60	4	0	0
1406	490	2	0	22	60	3	0	0
1406	162	0	0	31	60	3	0	0
1406	425	1	1	22	60	2	0	0
1406	105	2	0	27	60	5	0	0
1406	295	0	0	25	60	2	0	0
1406	306	1	0	22	60	4	0	0
1407	307	0	0	31	60	3	0	0
1407	430	0	1	35	60	0	1	0
1407	22	0	0	43	60	2	0	0
1407	21	2	1	31	60	4	0	0
1407	367	2	1	26	60	3	0	0
1407	20	2	1	44	60	2	0	0
1407	134	2	1	36	60	3	0	0
1407	103	1	1	34	60	2	0	0
1408	57	0	0	49	60	4	0	0
1408	111	0	0	30	60	0	0	0
1408	417	2	0	34	60	2	0	0
1408	276	0	1	33	60	3	1	0
1408	73	1	1	24	60	0	1	0
1408	261	1	0	43	60	1	0	0
1408	310	1	1	21	60	3	0	0
1408	321	0	1	28	60	3	0	0
1409	395	2	0	47	60	2	0	0
1409	332	2	1	43	60	0	1	0
1409	30	0	0	45	60	1	1	0
1409	179	1	1	33	60	1	0	0
1409	493	1	0	41	60	2	1	0
1409	340	2	0	39	60	0	0	0
1409	405	1	1	20	60	0	1	0
1409	59	1	0	25	60	2	0	0
1410	299	0	0	39	60	3	0	0
1410	4	1	0	46	60	0	1	0
1410	497	1	1	45	60	4	1	0
1410	44	2	1	34	60	1	0	0
1410	464	2	1	23	60	4	0	0
1410	260	0	0	46	60	2	0	0
1410	487	2	0	44	60	5	0	0
1410	105	1	0	35	60	5	0	0
1411	418	1	0	24	60	5	0	0
1411	99	1	0	23	60	1	0	0
1411	23	0	1	24	60	1	0	0
1411	174	2	1	47	60	0	0	0
1411	276	2	0	47	60	4	1	0
1411	456	0	1	40	60	4	1	0
1411	106	1	1	24	60	1	0	0
1411	301	0	1	46	60	3	0	0
1412	240	1	1	50	60	1	0	0
1412	161	0	0	40	60	4	1	0
1412	384	2	1	22	60	5	0	0
1412	69	2	1	20	60	5	0	0
1412	269	2	0	23	60	3	0	0
1412	164	1	1	35	60	1	1	0
1412	336	0	0	49	60	0	0	0
1412	284	1	1	34	60	1	0	0
1413	397	2	0	26	60	2	0	0
1413	374	2	1	21	60	3	0	0
1413	400	2	0	35	60	4	0	0
1413	125	2	0	35	60	2	0	0
1413	15	0	0	20	60	2	0	0
1413	218	2	0	48	60	5	1	0
1413	67	0	1	36	60	5	0	0
1413	232	2	1	36	60	5	0	0
1414	318	0	1	22	60	2	1	0
1414	145	2	0	28	60	3	1	0
1414	487	2	1	40	60	1	0	0
1414	180	1	0	45	60	5	1	0
1414	130	1	1	38	60	5	0	0
1414	474	2	1	30	60	1	0	0
1414	421	0	1	44	60	1	0	0
1414	52	1	0	38	60	5	0	0
1415	12	1	0	40	60	4	0	0
1415	119	2	1	50	60	0	0	0
1415	474	1	0	27	60	4	0	0
1415	357	0	0	29	60	1	1	0
1415	111	2	0	35	60	2	0	0
1415	95	1	1	28	60	1	1	0
1415	288	1	1	41	60	2	1	0
1415	27	1	0	43	60	4	1	0
1416	26	1	1	31	60	3	0	0
1416	426	1	0	37	60	0	1	0
1416	86	1	1	44	60	2	0	0
1416	34	1	1	39	60	5	0	0
1416	313	1	0	25	60	2	0	0
1416	117	0	1	30	60	5	0	0
1416	263	0	1	40	60	2	0	0
1416	265	1	0	34	60	1	0	0
1417	36	0	0	44	60	3	0	0
1417	423	1	0	50	60	0	1	0
1417	190	2	0	48	60	1	1	0
1417	354	0	1	41	60	3	0	0
1417	223	1	1	34	60	2	1	0
1417	378	1	0	43	60	2	0	0
1417	307	0	0	50	60	1	1	0
1417	264	1	1	43	60	2	0	0
1418	297	2	1	42	60	3	0	0
1418	60	1	1	41	60	0	0	0
1418	156	0	1	25	60	0	1	0
1418	111	2	1	44	60	5	0	0
1418	167	2	1	36	60	3	0	0
1418	67	1	0	34	60	0	0	0
1418	471	1	0	36	60	5	0	0
1418	500	0	1	32	60	1	0	0
1419	116	1	0	43	60	0	0	0
1419	52	0	0	21	60	2	0	0
1419	209	0	0	42	60	0	0	0
1419	435	2	1	46	60	3	0	0
1419	176	2	1	27	60	4	1	0
1419	292	1	0	36	60	0	0	0
1419	218	0	1	43	60	2	0	0
1419	431	0	1	32	60	2	0	0
1420	152	1	1	21	60	0	0	0
1420	293	0	1	41	60	1	1	0
1420	375	0	1	27	60	0	0	0
1420	130	0	0	36	60	4	0	0
1420	428	2	0	44	60	5	0	0
1420	124	2	0	33	60	3	0	0
1420	439	1	0	48	60	2	1	0
1420	109	2	0	20	60	1	0	0
1421	116	1	1	29	60	5	0	0
1421	303	1	0	26	60	1	0	0
1421	134	1	1	25	60	4	0	0
1421	310	1	1	39	60	3	0	0
1421	342	2	1	48	60	2	0	0
1421	266	1	0	24	60	5	1	0
1421	17	1	0	23	60	1	0	0
1421	57	0	1	40	60	3	1	0
1422	320	2	1	30	60	1	0	0
1422	344	2	1	20	60	0	1	0
1422	340	1	1	24	60	5	0	0
1422	452	0	0	41	60	2	0	0
1422	289	2	0	42	60	0	0	0
1422	171	1	0	32	60	3	1	0
1422	265	1	1	48	60	2	0	0
1422	486	0	1	25	60	2	0	0
1423	3	1	0	28	60	2	0	0
1423	33	1	0	24	60	5	0	0
1423	442	1	0	28	60	1	0	0
1423	411	1	0	30	60	4	0	0
1423	338	1	0	42	60	4	0	0
1423	291	2	1	43	60	4	0	0
1423	491	2	0	22	60	5	0	0
1423	153	2	1	20	60	5	1	0
1424	386	2	1	39	60	3	0	0
1424	217	1	1	38	60	2	0	0
1424	409	2	0	25	60	2	0	0
1424	277	0	1	50	60	0	0	0
1424	353	0	0	22	60	2	0	0
1424	190	1	1	29	60	4	1	0
1424	38	0	1	46	60	5	1	0
1424	414	2	0	43	60	1	0	0
1425	339	2	0	26	60	0	1	0
1425	273	2	0	20	60	1	0	0
1425	275	1	0	35	60	4	0	0
1425	47	2	0	27	60	5	0	0
1425	254	2	0	47	60	1	0	0
1425	99	2	0	27	60	5	0	0
1425	246	0	0	20	60	4	0	0
1425	122	0	0	33	60	5	0	0
1426	358	1	1	30	60	4	1	0
1426	412	0	0	38	60	2	0	0
1426	49	1	0	41	60	0	0	0
1426	48	1	0	46	60	2	1	0
1426	359	1	1	39	60	2	0	0
1426	95	0	0	33	60	1	0	0
1426	452	0	0	38	60	1	1	0
1426	59	0	0	31	60	2	0	0
1427	267	0	0	42	60	1	0	0
1427	213	1	0	20	60	1	0	0
1427	212	2	0	30	60	0	0	0
1427	4	1	0	39	60	3	0	0
1427	252	1	1	41	60	4	1	0
1427	285	0	1	35	60	0	0	0
1427	140	0	1	23	60	3	0	0
1427	123	1	1	40	60	5	0	0
1428	390	2	1	22	60	0	1	0
1428	170	2	1	30	60	0	1	0
1428	470	2	0	37	60	5	0	0
1428	299	0	1	30	60	0	0	0
1428	26	1	0	24	60	3	0	0
1428	214	1	0	33	60	5	0	0
1428	267	1	0	40	60	5	0	0
1428	216	1	0	37	60	3	1	0
1429	254	2	1	24	60	2	1	0
1429	385	0	0	21	60	5	0	0
1429	92	2	1	42	60	2	0	0
1429	350	0	0	30	60	4	0	0
1429	425	1	0	33	60	0	0	0
1429	103	0	0	37	60	1	0	0
1429	175	0	1	50	60	1	0	0
1429	198	1	1	26	60	5	0	0
1430	350	1	1	34	60	2	1	0
1430	215	1	1	32	60	2	0	0
1430	273	1	0	25	60	5	0	0
1430	220	1	1	28	60	4	0	0
1430	411	0	1	34	60	4	0	0
1430	193	1	0	45	60	4	0	0
1430	32	1	0	48	60	3	1	0
1430	286	1	0	34	60	0	0	0
1431	172	1	1	50	60	1	0	0
1431	126	1	1	44	60	4	0	0
1431	341	2	0	42	60	3	0	0
1431	455	2	1	31	60	3	0	0
1431	25	0	0	34	60	3	1	0
1431	139	1	0	44	60	2	1	0
1431	195	0	0	33	60	5	0	0
1431	384	0	0	23	60	5	1	0
1432	243	0	0	24	60	3	1	0
1432	419	0	0	24	60	1	0	0
1432	354	2	0	35	60	1	0	0
1432	237	0	1	30	60	4	0	0
1432	181	2	0	44	60	4	0	0
1432	240	2	0	43	60	2	1	0
1432	339	0	1	24	60	4	0	0
1432	180	1	0	39	60	3	0	0
1433	91	0	1	39	60	1	0	0
1433	441	0	1	37	60	3	0	0
1433	177	0	0	46	60	2	1	0
1433	11	2	0	21	60	1	0	0
1433	43	0	1	30	60	3	1	0
1433	290	0	0	32	60	5	0	0
1433	267	2	0	25	60	2	1	0
1433	154	0	1	20	60	5	0	0
1434	45	1	0	31	60	1	0	0
1434	141	1	1	46	60	1	0	0
1434	88	2	0	47	60	1	0	0
1434	20	1	0	43	60	5	0	0
1434	438	2	1	31	60	1	1	0
1434	269	0	0	32	60	0	0	0
1434	236	0	0	23	60	0	1	0
1434	221	1	1	37	60	1	0	0
1435	167	0	0	33	60	2	1	0
1435	303	2	0	31	60	2	0	0
1435	335	0	1	36	60	2	0	0
1435	215	0	0	44	60	0	0	0
1435	59	0	0	32	60	0	0	0
1435	401	0	0	42	60	4	1	0
1435	381	2	0	48	60	1	0	0
1435	319	1	1	39	60	3	0	0
1436	65	0	1	32	60	0	1	0
1436	441	1	0	33	60	4	0	0
1436	482	1	0	21	60	3	0	0
1436	270	0	0	22	60	1	0	0
1436	200	2	0	50	60	3	0	0
1436	76	2	1	47	60	3	0	0
1436	64	1	1	50	60	5	1	0
1436	322	2	0	28	60	4	0	0
1437	414	2	1	28	60	3	0	0
1437	238	2	0	33	60	1	0	0
1437	12	2	0	29	60	2	0	0
1437	449	1	0	45	60	1	0	0
1437	415	0	0	37	60	3	1	0
1437	40	1	0	40	60	5	1	0
1437	384	0	0	31	60	2	0	0
1437	483	2	1	45	60	0	0	0
1438	170	0	0	50	60	4	0	0
1438	137	2	1	50	60	5	0	0
1438	420	0	1	24	60	4	0	0
1438	124	2	0	34	60	3	1	0
1438	188	0	0	38	60	2	1	0
1438	136	0	1	43	60	3	0	0
1438	196	1	0	20	60	4	0	0
1438	75	2	1	26	60	2	0	0
1439	224	0	1	37	60	2	0	0
1439	81	0	0	43	60	3	0	0
1439	315	0	1	39	60	5	0	0
1439	16	0	0	31	60	0	0	0
1439	459	0	1	39	60	4	1	0
1439	415	2	0	35	60	0	0	0
1439	237	1	0	22	60	0	0	0
1439	191	1	1	45	60	5	0	0
1440	10	2	0	24	60	1	0	0
1440	237	1	1	26	60	4	1	0
1440	488	1	0	47	60	4	0	0
1440	454	1	0	20	60	0	0	0
1440	65	0	0	22	60	2	0	0
1440	431	1	0	34	60	1	0	0
1440	325	2	0	39	60	0	0	0
1440	175	2	0	39	60	3	1	0
1441	119	0	0	31	60	1	1	0
1441	485	0	0	36	60	1	0	0
1441	498	2	0	27	60	3	0	0
1441	206	1	1	34	60	2	1	0
1441	102	2	0	29	60	1	0	0
1441	88	1	0	33	60	3	1	0
1441	329	1	1	40	60	2	1	0
1441	114	2	0	24	60	3	0	0
1442	350	2	1	31	60	5	0	0
1442	82	0	1	40	60	0	0	0
1442	60	2	1	40	60	2	1	0
1442	407	2	1	46	60	4	0	0
1442	106	0	0	40	60	2	1	0
1442	296	1	1	37	60	1	0	0
1442	445	1	0	22	60	5	1	0
1442	385	2	0	25	60	3	0	0
1443	256	2	1	21	60	4	1	0
1443	159	0	0	30	60	1	0	0
1443	279	0	0	43	60	3	0	0
1443	87	0	1	26	60	2	1	0
1443	490	1	0	25	60	3	1	0
1443	15	2	1	43	60	4	1	0
1443	368	1	0	48	60	0	0	0
1443	480	1	0	39	60	0	0	0
1444	70	1	0	43	60	3	0	0
1444	303	0	1	40	60	2	0	0
1444	49	2	0	26	60	5	0	0
1444	342	0	0	46	60	3	1	0
1444	357	2	0	28	60	3	0	0
1444	24	1	0	42	60	3	0	0
1444	263	0	1	20	60	4	0	0
1444	288	1	1	49	60	5	1	0
1445	9	0	0	44	60	4	1	0
1445	195	2	1	34	60	5	0	0
1445	219	1	1	29	60	0	1	0
1445	295	2	1	37	60	0	0	0
1445	105	2	0	48	60	5	0	0
1445	488	2	0	33	60	5	1	0
1445	204	0	1	35	60	0	0	0
1445	79	0	1	21	60	1	0	0
1446	237	0	0	50	60	1	1	0
1446	312	2	0	47	60	3	0	0
1446	218	0	1	24	60	1	1	0
1446	276	0	1	34	60	3	0	0
1446	212	1	0	32	60	0	1	0
1446	314	0	0	20	60	1	1	0
1446	173	1	0	43	60	0	0	0
1446	197	0	0	24	60	4	0	0
1447	452	0	1	44	60	0	0	0
1447	178	1	1	22	60	1	0	0
1447	321	0	1	49	60	0	1	0
1447	417	2	0	29	60	2	1	0
1447	156	0	0	28	60	0	0	0
1447	428	0	0	46	60	2	0	0
1447	331	0	0	34	60	4	0	0
1447	16	0	1	26	60	3	0	0
1448	149	2	1	23	60	1	1	0
1448	128	0	1	25	60	2	1	0
1448	164	1	1	44	60	0	0	0
1448	188	1	1	43	60	1	0	0
1448	327	2	0	30	60	3	0	0
1448	323	0	0	38	60	0	1	0
1448	450	0	1	40	60	4	0	0
1448	410	2	0	28	60	0	0	0
1449	153	2	1	23	60	2	0	0
1449	186	0	1	44	60	4	0	0
1449	230	1	1	40	60	0	0	0
1449	123	0	1	30	60	5	0	0
1449	200	1	0	23	60	0	0	0
1449	178	2	1	37	60	2	1	0
1449	356	0	0	21	60	5	0	0
1449	154	2	1	40	60	5	0	0
1450	194	1	0	23	60	5	1	0
1450	66	1	1	30	60	2	1	0
1450	288	2	1	28	60	2	0	0
1450	16	1	1	34	60	5	0	0
1450	471	2	1	45	60	4	0	0
1450	258	1	1	42	60	2	1	0
1450	421	2	0	38	60	5	0	0
1450	22	1	1	29	60	4	0	0
1451	216	2	0	28	60	2	0	0
1451	440	0	0	50	60	3	0	0
1451	321	2	0	24	60	1	0	0
1451	94	1	0	26	60	3	0	0
1451	418	2	0	30	60	5	1	0
1451	416	1	1	31	60	5	0	0
1451	144	2	1	30	60	3	0	0
1451	491	1	1	43	60	0	1	0
1452	193	1	1	30	60	5	0	0
1452	464	1	1	39	60	1	0	0
1452	409	2	1	38	60	0	0	0
1452	448	2	1	50	60	1	1	0
1452	104	0	1	44	60	3	0	0
1452	430	1	0	22	60	0	0	0
1452	195	2	1	41	60	3	1	0
1452	412	0	0	46	60	5	1	0
1453	220	2	1	39	60	1	0	0
1453	123	0	1	29	60	4	1	0
1453	166	0	1	39	60	0	0	0
1453	52	1	1	21	60	1	0	0
1453	345	0	0	44	60	4	1	0
1453	420	1	1	26	60	4	0	0
1453	246	0	0	40	60	4	0	0
1453	339	2	1	40	60	3	0	0
1454	438	2	1	42	60	5	0	0
1454	327	1	1	22	60	3	0	0
1454	355	2	0	47	60	0	0	0
1454	334	1	0	20	60	5	0	0
1454	12	2	0	24	60	4	1	0
1454	406	1	0	37	60	2	0	0
1454	447	1	1	26	60	1	0	0
1454	298	2	1	33	60	2	0	0
1455	239	0	1	27	60	5	0	0
1455	210	0	0	23	60	2	0	0
1455	200	1	0	26	60	4	1	0
1455	150	2	0	28	60	4	0	0
1455	345	2	0	30	60	3	1	0
1455	65	0	1	40	60	5	0	0
1455	448	2	0	29	60	3	1	0
1455	232	1	1	22	60	3	0	0
1456	312	1	1	30	60	2	0	0
1456	487	2	1	44	60	3	0	0
1456	6	0	1	27	60	0	0	0
1456	70	0	1	45	60	2	0	0
1456	54	1	1	21	60	2	0	0
1456	273	0	0	23	60	1	1	0
1456	119	0	0	46	60	2	0	0
1456	432	1	1	36	60	2	0	0
1457	442	2	1	23	60	0	0	0
1457	378	0	1	23	60	1	1	0
1457	352	1	0	40	60	0	0	0
1457	305	0	0	47	60	5	0	0
1457	430	1	0	34	60	3	0	0
1457	382	0	1	47	60	3	0	0
1457	492	2	0	47	60	5	0	0
1457	362	2	0	45	60	1	0	0
1458	436	1	0	32	60	1	1	0
1458	489	1	1	25	60	1	0	0
1458	78	1	1	49	60	0	0	0
1458	421	0	0	20	60	5	0	0
1458	139	2	1	28	60	5	0	0
1458	112	2	0	29	60	3	0	0
1458	480	0	1	22	60	3	0	0
1458	212	0	0	41	60	0	0	0
1459	217	0	0	32	60	2	0	0
1459	432	2	1	39	60	0	0	0
1459	159	2	0	37	60	0	0	0
1459	170	0	0	40	60	1	0	0
1459	303	1	0	22	60	2	1	0
1459	101	2	0	29	60	2	1	0
1459	237	2	1	47	60	1	0	0
1459	467	1	1	31	60	0	1	0
1460	375	0	1	22	60	4	0	0
1460	354	2	0	20	60	1	0	0
1460	476	1	0	45	60	5	1	0
1460	137	2	0	44	60	0	0	0
1460	341	0	0	30	60	2	0	0
1460	167	1	1	35	60	4	0	0
1460	406	1	1	25	60	1	1	0
1460	392	1	0	24	60	3	0	0
1461	310	0	0	29	60	2	0	0
1461	454	0	1	45	60	0	0	0
1461	369	1	1	32	60	3	0	0
1461	105	1	1	46	60	4	0	0
1461	416	2	0	42	60	3	0	0
1461	253	2	1	27	60	1	0	0
1461	148	2	1	42	60	1	0	0
1461	481	2	1	24	60	4	0	0
1462	335	0	1	41	60	0	0	0
1462	93	0	0	27	60	5	0	0
1462	246	2	0	30	60	4	0	0
1462	264	0	0	46	60	4	0	0
1462	150	2	0	47	60	4	0	0
1462	50	1	1	50	60	2	0	0
1462	129	2	0	26	60	5	0	0
1462	428	1	0	36	60	2	0	0
1463	162	2	1	35	60	2	1	0
1463	382	1	0	47	60	2	0	0
1463	491	2	0	20	60	3	0	0
1463	475	0	0	44	60	1	0	0
1463	476	1	1	31	60	4	0	0
1463	406	1	1	20	60	3	0	0
1463	116	0	0	38	60	0	1	0
1463	295	0	0	44	60	1	0	0
1464	178	1	0	34	60	3	0	0
1464	496	2	0	32	60	1	0	0
1464	424	0	0	33	60	3	0	0
1464	495	2	1	48	60	2	0	0
1464	139	1	0	28	60	4	0	0
1464	272	1	1	22	60	4	0	0
1464	242	2	1	27	60	3	0	0
1464	42	1	0	47	60	2	0	0
1465	19	1	1	26	60	2	0	0
1465	108	2	0	31	60	2	1	0
1465	237	1	0	31	60	0	1	0
1465	405	2	0	25	60	4	1	0
1465	212	0	0	26	60	3	1	0
1465	117	0	0	25	60	1	0	0
1465	182	1	0	32	60	5	0	0
1465	103	2	1	47	60	1	0	0
1466	398	2	0	37	60	2	0	0
1466	327	1	0	32	60	2	0	0
1466	424	0	1	39	60	5	0	0
1466	209	0	1	31	60	1	1	0
1466	24	2	1	38	60	2	0	0
1466	54	1	1	45	60	1	0	0
1466	395	1	0	27	60	0	0	0
1466	408	0	0	30	60	2	0	0
1467	248	1	1	28	60	1	0	0
1467	484	1	1	37	60	2	0	0
1467	59	1	1	23	60	3	1	0
1467	44	2	1	21	60	3	0	0
1467	46	2	0	37	60	0	1	0
1467	250	1	0	21	60	1	1	0
1467	16	1	0	31	60	5	0	0
1467	128	0	0	23	60	0	1	0
1468	98	0	0	28	60	0	1	0
1468	425	1	1	42	60	2	0	0
1468	290	1	0	20	60	5	0	0
1468	373	1	0	27	60	1	0	0
1468	30	0	0	27	60	3	0	0
1468	1	2	1	23	60	5	1	0
1468	328	1	1	20	60	5	0	0
1468	434	0	1	49	60	0	1	0
1469	273	2	0	34	60	3	0	0
1469	416	0	0	47	60	2	0	0
1469	491	0	1	29	60	2	1	0
1469	313	2	0	36	60	4	0	0
1469	73	2	0	31	60	3	0	0
1469	478	2	0	41	60	2	0	0
1469	455	2	1	44	60	2	0	0
1469	268	0	0	33	60	3	0	0
1470	180	2	0	38	60	0	0	0
1470	139	2	1	26	60	5	0	0
1470	351	0	0	41	60	4	0	0
1470	15	2	0	26	60	3	1	0
1470	372	1	0	48	60	3	0	0
1470	497	1	1	46	60	0	0	0
1470	281	1	0	49	60	3	0	0
1470	88	0	1	22	60	1	0	0
1471	465	2	1	37	60	4	1	0
1471	310	2	0	41	60	5	1	0
1471	481	1	1	29	60	3	0	0
1471	399	0	1	25	60	0	0	0
1471	188	0	0	27	60	3	0	0
1471	230	1	0	25	60	3	0	0
1471	346	0	1	32	60	2	0	0
1471	373	1	0	43	60	5	0	0
1472	119	0	0	28	60	4	1	0
1472	335	2	0	35	60	0	1	0
1472	255	1	1	22	60	2	0	0
1472	281	1	1	42	60	3	0	0
1472	396	0	0	34	60	5	0	0
1472	444	0	1	40	60	3	0	0
1472	468	0	0	46	60	5	1	0
1472	52	0	1	49	60	1	0	0
1473	359	0	1	45	60	1	1	0
1473	118	1	0	46	60	0	1	0
1473	211	1	1	47	60	3	1	0
1473	60	1	1	38	60	4	1	0
1473	49	1	1	30	60	4	0	0
1473	92	0	1	23	60	3	1	0
1473	420	1	1	49	60	1	0	0
1473	113	1	0	43	60	5	0	0
1474	77	1	1	28	60	1	0	0
1474	400	2	1	34	60	1	0	0
1474	439	1	0	22	60	4	0	0
1474	492	1	1	45	60	4	0	0
1474	330	2	1	31	60	0	0	0
1474	147	2	1	36	60	1	0	0
1474	178	2	1	39	60	2	0	0
1474	78	2	0	46	60	0	1	0
1475	393	2	1	42	60	0	0	0
1475	500	1	0	33	60	3	0	0
1475	191	1	1	36	60	0	1	0
1475	388	0	1	40	60	3	0	0
1475	299	1	0	43	60	0	1	0
1475	132	0	0	38	60	3	0	0
1475	285	0	1	34	60	1	0	0
1475	383	2	0	46	60	3	0	0
1476	15	2	0	36	60	3	1	0
1476	328	2	1	29	60	3	0	0
1476	185	1	0	27	60	5	1	0
1476	476	2	0	31	60	3	0	0
1476	136	0	0	41	60	5	0	0
1476	344	1	0	31	60	1	0	0
1476	350	1	1	34	60	5	1	0
1476	171	2	0	27	60	0	0	0
1477	303	0	0	21	60	4	0	0
1477	321	0	0	22	60	5	0	0
1477	371	0	1	21	60	1	1	0
1477	261	0	1	36	60	4	0	0
1477	475	2	0	26	60	3	0	0
1477	288	1	0	28	60	0	1	0
1477	151	2	1	49	60	4	1	0
1477	231	0	1	26	60	3	1	0
1478	373	1	0	33	60	1	0	0
1478	292	0	0	35	60	4	0	0
1478	277	0	1	31	60	5	1	0
1478	299	2	1	23	60	3	0	0
1478	147	0	0	37	60	3	0	0
1478	76	1	0	31	60	2	0	0
1478	381	1	1	23	60	4	0	0
1478	461	0	1	41	60	4	0	0
1479	331	2	0	41	60	2	1	0
1479	9	0	0	21	60	0	0	0
1479	465	1	1	24	60	5	0	0
1479	398	1	1	35	60	0	1	0
1479	246	0	0	44	60	3	0	0
1479	432	2	1	42	60	5	0	0
1479	425	2	1	21	60	3	0	0
1479	136	2	1	39	60	4	0	0
1480	97	1	0	38	60	1	1	0
1480	217	2	1	22	60	2	0	0
1480	140	0	1	37	60	0	0	0
1480	14	1	1	32	60	4	1	0
1480	418	2	1	37	60	5	0	0
1480	352	0	1	26	60	5	0	0
1480	200	2	0	35	60	5	0	0
1480	494	1	1	37	60	4	0	0
1481	261	0	1	23	60	1	1	0
1481	61	2	0	30	60	1	0	0
1481	279	0	0	44	60	4	0	0
1481	340	0	0	50	60	2	0	0
1481	315	0	0	50	60	5	0	0
1481	326	2	0	49	60	0	0	0
1481	478	0	1	45	60	4	0	0
1481	446	0	0	39	60	0	1	0
1482	203	1	1	49	60	2	1	0
1482	292	0	1	21	60	4	0	0
1482	446	1	1	32	60	5	0	0
1482	404	1	1	22	60	2	1	0
1482	456	0	0	46	60	4	0	0
1482	162	0	0	24	60	3	1	0
1482	486	0	1	25	60	5	0	0
1482	104	0	0	49	60	2	1	0
1483	190	1	1	21	60	5	0	0
1483	327	1	0	35	60	3	0	0
1483	227	1	0	33	60	5	0	0
1483	195	0	0	22	60	5	0	0
1483	218	1	1	32	60	1	0	0
1483	216	1	1	31	60	0	0	0
1483	179	1	0	26	60	2	0	0
1483	473	1	1	25	60	2	0	0
1484	351	2	1	27	60	3	0	0
1484	236	0	0	30	60	1	1	0
1484	357	1	0	25	60	3	0	0
1484	355	2	0	41	60	1	0	0
1484	343	2	1	31	60	3	0	0
1484	166	1	0	30	60	2	0	0
1484	354	0	1	20	60	0	1	0
1484	382	1	1	26	60	4	0	0
1485	220	2	0	37	60	5	0	0
1485	145	0	0	32	60	4	0	0
1485	215	2	1	44	60	2	1	0
1485	380	1	1	43	60	1	0	0
1485	330	1	1	48	60	3	1	0
1485	9	1	0	36	60	4	1	0
1485	226	2	1	39	60	4	0	0
1485	239	2	0	38	60	2	1	0
1486	13	0	0	47	60	4	0	0
1486	168	0	1	45	60	2	0	0
1486	181	1	1	36	60	3	1	0
1486	482	2	1	30	60	0	1	0
1486	217	2	0	21	60	0	1	0
1486	234	1	1	35	60	5	0	0
1486	96	2	0	31	60	4	0	0
1486	9	0	0	45	60	0	0	0
1487	268	0	0	36	60	1	0	0
1487	225	2	1	48	60	1	0	0
1487	204	0	1	28	60	1	1	0
1487	414	0	0	30	60	3	1	0
1487	250	0	1	33	60	3	0	0
1487	12	0	0	35	60	0	0	0
1487	308	1	0	21	60	3	0	0
1487	43	0	1	40	60	1	0	0
1488	295	0	1	34	60	0	0	0
1488	334	0	0	21	60	3	0	0
1488	214	2	0	25	60	3	0	0
1488	359	2	0	39	60	5	1	0
1488	234	2	1	23	60	2	1	0
1488	177	2	1	41	60	1	0	0
1488	137	2	0	40	60	2	0	0
1488	328	2	1	27	60	1	0	0
1489	185	2	1	47	60	3	0	0
1489	31	0	0	45	60	0	0	0
1489	40	0	1	36	60	5	1	0
1489	351	1	1	39	60	1	1	0
1489	333	1	1	31	60	5	0	0
1489	293	2	1	42	60	3	0	0
1489	309	2	1	22	60	4	0	0
1489	190	1	0	24	60	0	0	0
1490	257	0	1	36	60	3	0	0
1490	188	1	1	33	60	1	0	0
1490	5	0	0	38	60	4	0	0
1490	44	0	0	41	60	5	0	0
1490	299	0	1	39	60	2	1	0
1490	214	2	0	42	60	4	0	0
1490	307	1	0	25	60	4	0	0
1490	177	0	0	46	60	0	0	0
1491	256	0	1	48	60	2	0	0
1491	223	1	1	40	60	0	1	0
1491	28	0	0	30	60	4	0	0
1491	199	2	0	33	60	4	0	0
1491	443	2	1	29	60	1	0	0
1491	66	0	0	37	60	0	0	0
1491	487	1	1	47	60	0	0	0
1491	219	2	0	36	60	4	1	0
1492	208	1	1	47	60	0	1	0
1492	290	2	1	29	60	3	0	0
1492	439	1	0	40	60	3	1	0
1492	265	0	0	50	60	2	1	0
1492	287	0	0	24	60	5	0	0
1492	232	0	0	42	60	5	0	0
1492	427	0	0	46	60	2	0	0
1492	255	0	0	33	60	3	0	0
1493	421	0	1	25	60	3	0	0
1493	287	1	0	31	60	3	1	0
1493	199	0	0	39	60	5	0	0
1493	315	1	0	22	60	4	0	0
1493	97	0	0	25	60	2	0	0
1493	187	0	0	34	60	2	0	0
1493	311	1	0	21	60	4	0	0
1493	19	1	1	41	60	0	1	0
1494	385	2	0	45	60	0	0	0
1494	196	0	1	33	60	4	0	0
1494	437	2	1	31	60	5	0	0
1494	242	1	0	37	60	5	1	0
1494	161	2	1	32	60	4	0	0
1494	303	2	0	23	60	3	1	0
1494	461	0	0	47	60	1	0	0
1494	122	1	1	48	60	2	0	0
1495	71	2	1	50	60	0	0	0
1495	234	1	1	50	60	1	0	0
1495	68	1	1	32	60	0	1	0
1495	232	1	1	43	60	4	0	0
1495	403	0	1	23	60	1	1	0
1495	174	0	0	38	60	5	1	0
1495	17	2	1	50	60	2	0	0
1495	99	1	1	33	60	2	0	0
1496	36	2	0	35	60	2	0	0
1496	449	1	0	45	60	3	1	0
1496	255	0	1	37	60	2	0	0
1496	336	2	1	22	60	5	0	0
1496	327	2	0	39	60	1	0	0
1496	244	1	1	42	60	0	0	0
1496	226	0	1	40	60	4	1	0
1496	389	1	0	42	60	2	1	0
1497	23	1	1	24	60	4	0	0
1497	166	0	0	20	60	0	1	0
1497	128	0	1	22	60	5	1	0
1497	97	1	1	26	60	1	0	0
1497	180	1	1	31	60	5	0	0
1497	394	2	1	50	60	1	0	0
1497	250	0	1	22	60	5	0	0
1497	412	1	0	28	60	2	0	0
1498	317	2	0	33	60	2	0	0
1498	458	0	0	26	60	1	0	0
1498	168	2	1	49	60	0	1	0
1498	231	0	0	28	60	1	0	0
1498	386	0	1	31	60	5	1	0
1498	496	1	0	44	60	5	1	0
1498	408	1	1	25	60	1	0	0
1498	175	1	1	42	60	2	0	0
1499	50	1	1	34	60	3	1	0
1499	236	0	1	41	60	2	0	0
1499	141	2	0	35	60	1	1	0
1499	226	0	0	30	60	2	0	0
1499	379	1	0	27	60	1	1	0
1499	291	1	1	27	60	0	1	0
1499	136	2	0	23	60	4	1	0
1499	475	2	1	27	60	2	0	0
1500	463	2	0	35	60	0	0	0
1500	373	0	0	36	60	0	0	0
1500	276	2	0	25	60	4	1	0
1500	469	2	1	26	60	2	1	0
1500	23	1	1	39	60	4	0	0
1500	63	2	1	46	60	3	0	0
1500	179	1	1	35	60	2	0	0
1500	121	2	0	23	60	1	0	0
1501	240	0	0	24	60	5	0	0
1501	499	2	1	30	60	5	0	0
1501	177	1	0	37	60	5	1	0
1501	431	2	1	47	60	3	0	0
1501	397	1	0	47	60	4	0	0
1501	353	0	0	36	60	3	0	0
1501	225	1	0	25	60	3	1	0
1501	106	2	1	23	60	1	0	0
1502	188	1	0	36	60	3	0	0
1502	2	2	0	49	60	2	0	0
1502	459	2	0	36	60	0	1	0
1502	117	0	0	40	60	3	0	0
1502	61	0	0	42	60	4	1	0
1502	324	1	1	42	60	5	0	0
1502	416	0	0	34	60	3	1	0
1502	247	0	0	25	60	1	0	0
1503	473	2	1	28	60	3	0	0
1503	151	2	1	36	60	1	1	0
1503	476	0	0	48	60	4	1	0
1503	402	0	1	24	60	5	0	0
1503	239	2	0	25	60	2	0	0
1503	482	2	1	33	60	1	0	0
1503	483	1	0	38	60	1	1	0
1503	211	0	1	42	60	3	1	0
1504	34	2	1	24	60	4	0	0
1504	456	0	1	34	60	5	0	0
1504	202	1	0	49	60	2	0	0
1504	459	2	0	44	60	0	1	0
1504	161	0	0	41	60	2	1	0
1504	284	0	1	47	60	2	0	0
1504	210	2	0	43	60	5	1	0
1504	362	2	1	26	60	4	0	0
1505	374	2	1	47	60	4	0	0
1505	285	0	1	36	60	0	0	0
1505	488	1	1	41	60	4	0	0
1505	170	1	1	20	60	5	0	0
1505	355	2	0	28	60	4	0	0
1505	263	2	1	27	60	2	0	0
1505	425	2	1	36	60	5	0	0
1505	157	2	1	25	60	4	0	0
1506	8	0	1	42	60	4	0	0
1506	462	2	1	35	60	4	0	0
1506	312	2	0	26	60	5	0	0
1506	105	2	0	39	60	3	0	0
1506	305	0	1	26	60	2	0	0
1506	483	1	0	26	60	5	0	0
1506	128	0	1	23	60	1	0	0
1506	407	1	0	42	60	3	1	0
1507	229	1	1	28	60	5	0	0
1507	139	0	0	40	60	3	0	0
1507	331	1	0	28	60	5	0	0
1507	214	0	0	39	60	2	0	0
1507	472	1	0	29	60	1	1	0
1507	277	0	1	39	60	2	1	0
1507	170	2	0	50	60	5	0	0
1507	267	1	0	49	60	3	0	0
1508	471	1	0	43	60	0	1	0
1508	378	0	1	26	60	3	0	0
1508	216	2	1	46	60	3	0	0
1508	441	0	1	33	60	5	1	0
1508	310	0	0	27	60	3	0	0
1508	55	0	1	28	60	2	1	0
1508	47	2	1	26	60	0	0	0
1508	443	0	0	49	60	1	0	0
1509	93	1	1	37	60	1	1	0
1509	133	1	0	45	60	5	0	0
1509	357	1	1	36	60	0	0	0
1509	74	2	0	29	60	1	1	0
1509	2	1	1	43	60	0	0	0
1509	409	0	0	24	60	0	0	0
1509	166	2	1	35	60	5	1	0
1509	353	0	0	20	60	0	0	0
1510	47	2	1	48	60	3	1	0
1510	69	1	0	30	60	2	0	0
1510	80	2	1	26	60	0	0	0
1510	2	0	0	39	60	1	1	0
1510	372	2	1	30	60	1	0	0
1510	58	1	1	36	60	0	0	0
1510	388	1	0	44	60	3	0	0
1510	324	0	1	32	60	2	0	0
1511	116	0	1	36	60	2	0	0
1511	160	0	1	49	60	1	0	0
1511	274	0	1	50	60	0	0	0
1511	161	1	1	36	60	2	0	0
1511	475	2	1	42	60	1	0	0
1511	320	1	1	37	60	5	0	0
1511	59	2	0	25	60	5	0	0
1511	197	1	1	47	60	4	0	0
1512	89	1	0	40	60	1	0	0
1512	285	2	1	27	60	5	0	0
1512	21	1	0	31	60	5	0	0
1512	344	2	1	36	60	2	1	0
1512	211	0	1	39	60	3	0	0
1512	369	1	1	31	60	2	0	0
1512	254	0	0	24	60	3	1	0
1512	241	2	0	27	60	5	0	0
1513	180	2	0	37	60	0	1	0
1513	391	1	1	25	60	5	0	0
1513	212	0	1	32	60	0	0	0
1513	302	2	0	46	60	3	1	0
1513	305	0	1	23	60	4	0	0
1513	370	0	1	39	60	4	1	0
1513	453	1	1	38	60	4	1	0
1513	446	2	0	49	60	2	0	0
1514	485	1	1	37	60	1	0	0
1514	52	1	1	26	60	5	0	0
1514	455	2	0	39	60	0	0	0
1514	458	1	1	47	60	2	0	0
1514	316	1	1	20	60	5	0	0
1514	478	1	1	47	60	0	0	0
1514	279	2	0	34	60	4	0	0
1514	127	2	1	49	60	2	0	0
1515	419	0	0	21	60	2	0	0
1515	444	0	0	42	60	0	0	0
1515	295	1	0	46	60	2	1	0
1515	29	1	1	49	60	5	0	0
1515	13	0	1	33	60	2	0	0
1515	253	0	0	34	60	4	0	0
1515	183	0	0	38	60	1	0	0
1515	104	2	0	27	60	0	0	0
1516	263	0	1	46	60	0	0	0
1516	379	2	0	41	60	0	0	0
1516	294	1	0	40	60	5	0	0
1516	471	0	1	26	60	2	0	0
1516	170	1	1	21	60	0	0	0
1516	255	1	0	38	60	0	0	0
1516	212	2	1	29	60	5	1	0
1516	197	0	1	36	60	5	0	0
1517	135	1	0	29	60	5	0	0
1517	81	2	1	49	60	0	0	0
1517	277	0	0	31	60	3	0	0
1517	238	0	0	22	60	5	0	0
1517	26	2	1	44	60	4	1	0
1517	339	0	1	48	60	2	0	0
1517	58	2	1	46	60	1	1	0
1517	370	0	1	43	60	4	0	0
1518	116	1	0	35	60	1	1	0
1518	50	1	0	35	60	2	0	0
1518	251	0	1	40	60	0	1	0
1518	379	2	0	37	60	3	0	0
1518	298	1	1	35	60	2	0	0
1518	304	1	1	30	60	4	1	0
1518	246	2	0	45	60	1	0	0
1518	439	0	0	32	60	0	0	0
1519	416	2	1	28	60	0	1	0
1519	210	2	1	39	60	0	0	0
1519	185	0	0	40	60	0	0	0
1519	490	1	1	23	60	5	0	0
1519	95	1	0	47	60	4	0	0
1519	395	2	0	28	60	5	1	0
1519	335	1	1	26	60	0	1	0
1519	131	2	1	44	60	2	0	0
1520	326	2	1	32	60	3	0	0
1520	38	2	0	39	60	0	0	0
1520	92	2	0	24	60	1	1	0
1520	214	2	0	30	60	0	0	0
1520	454	1	0	25	60	3	0	0
1520	366	0	0	38	60	4	0	0
1520	139	0	1	27	60	2	0	0
1520	41	1	1	36	60	3	1	0
1521	485	1	0	46	60	1	0	0
1521	429	0	1	48	60	2	0	0
1521	132	1	1	28	60	4	0	0
1521	272	0	0	29	60	0	0	0
1521	419	1	1	45	60	5	1	0
1521	487	2	0	28	60	4	1	0
1521	490	2	0	41	60	5	0	0
1521	57	0	0	41	60	5	0	0
1522	414	1	1	24	60	0	1	0
1522	53	2	0	45	60	3	0	0
1522	70	1	1	34	60	3	0	0
1522	313	2	0	50	60	3	0	0
1522	291	2	0	39	60	1	0	0
1522	392	2	1	31	60	0	1	0
1522	51	1	1	39	60	1	0	0
1522	138	2	1	34	60	5	0	0
1523	207	1	1	44	60	2	0	0
1523	102	1	1	42	60	1	1	0
1523	135	2	0	38	60	2	0	0
1523	257	2	1	36	60	4	0	0
1523	241	2	1	27	60	2	0	0
1523	266	0	1	39	60	1	1	0
1523	126	2	0	22	60	2	0	0
1523	157	0	1	35	60	4	1	0
1524	460	1	1	50	60	1	0	0
1524	161	0	0	36	60	5	0	0
1524	230	0	0	41	60	4	1	0
1524	37	2	0	39	60	1	1	0
1524	39	1	1	40	60	0	0	0
1524	295	0	1	28	60	4	1	0
1524	49	1	0	30	60	1	1	0
1524	404	2	0	45	60	1	0	0
1525	47	0	0	27	60	0	0	0
1525	15	0	0	31	60	2	0	0
1525	149	1	0	23	60	3	0	0
1525	253	2	0	45	60	1	0	0
1525	161	1	1	23	60	4	1	0
1525	365	0	1	39	60	4	0	0
1525	150	1	0	28	60	3	0	0
1525	485	0	1	26	60	1	0	0
1526	306	0	1	39	60	4	0	0
1526	334	0	1	33	60	5	1	0
1526	398	0	1	27	60	3	0	0
1526	83	0	0	47	60	4	1	0
1526	114	0	0	47	60	1	0	0
1526	326	1	1	42	60	2	0	0
1526	39	0	1	38	60	2	0	0
1526	434	2	1	36	60	3	0	0
1527	260	1	1	38	60	2	0	0
1527	268	0	1	32	60	3	0	0
1527	455	1	0	39	60	3	1	0
1527	45	0	1	45	60	3	1	0
1527	118	2	0	37	60	2	1	0
1527	181	0	0	21	60	0	0	0
1527	336	0	1	42	60	4	0	0
1527	445	1	1	44	60	3	0	0
1528	277	1	1	20	60	1	0	0
1528	313	1	1	35	60	1	0	0
1528	440	2	0	33	60	4	0	0
1528	273	0	1	32	60	4	0	0
1528	329	0	0	32	60	1	0	0
1528	102	1	0	41	60	2	0	0
1528	390	2	1	29	60	2	0	0
1528	166	2	1	29	60	4	1	0
1529	211	2	1	43	60	4	0	0
1529	1	0	0	23	60	3	0	0
1529	113	0	1	30	60	1	0	0
1529	151	1	1	42	60	3	0	0
1529	4	2	0	40	60	1	0	0
1529	481	1	0	38	60	1	0	0
1529	217	2	0	30	60	2	0	0
1529	477	0	0	46	60	0	0	0
1530	183	2	0	39	60	4	0	0
1530	171	0	1	47	60	4	0	0
1530	131	1	0	46	60	5	0	0
1530	69	0	0	23	60	5	0	0
1530	293	0	0	40	60	5	0	0
1530	359	1	0	50	60	2	0	0
1530	186	1	0	24	60	0	0	0
1530	172	2	1	45	60	3	0	0
1531	199	2	1	33	60	0	0	0
1531	322	1	1	44	60	3	0	0
1531	183	0	0	31	60	3	1	0
1531	58	1	1	23	60	3	0	0
1531	381	0	1	50	60	4	0	0
1531	153	2	1	20	60	4	0	0
1531	376	2	0	29	60	1	0	0
1531	99	0	1	29	60	1	0	0
1532	316	2	1	48	60	3	0	0
1532	43	0	0	26	60	5	0	0
1532	494	0	0	25	60	3	1	0
1532	105	0	1	28	60	1	1	0
1532	334	1	0	22	60	2	1	0
1532	338	2	1	48	60	0	0	0
1532	344	1	1	30	60	0	0	0
1532	127	1	0	20	60	3	0	0
1533	439	2	0	47	60	5	1	0
1533	185	1	0	40	60	4	1	0
1533	14	0	1	36	60	0	0	0
1533	374	0	1	35	60	3	0	0
1533	87	0	1	40	60	2	0	0
1533	451	1	1	43	60	5	1	0
1533	289	2	1	49	60	2	1	0
1533	286	1	0	24	60	3	0	0
1534	412	2	1	28	60	0	0	0
1534	415	1	1	31	60	2	0	0
1534	371	0	1	48	60	4	0	0
1534	290	2	1	20	60	4	1	0
1534	457	2	1	33	60	0	0	0
1534	34	2	1	44	60	4	0	0
1534	128	2	0	27	60	2	0	0
1534	187	0	1	21	60	0	0	0
1535	26	1	0	24	60	3	0	0
1535	319	0	0	20	60	5	0	0
1535	15	1	0	46	60	5	0	0
1535	133	1	1	41	60	5	0	0
1535	497	0	1	38	60	5	0	0
1535	285	0	0	22	60	5	0	0
1535	197	0	0	47	60	4	0	0
1535	211	2	0	23	60	2	0	0
1536	2	2	0	33	60	1	1	0
1536	99	0	0	29	60	5	0	0
1536	412	1	1	50	60	2	0	0
1536	292	0	0	27	60	5	1	0
1536	112	2	0	31	60	0	1	0
1536	409	2	1	43	60	1	0	0
1536	395	2	1	50	60	4	0	0
1536	142	1	1	34	60	4	0	0
1537	446	0	0	35	60	1	0	0
1537	384	2	0	40	60	4	0	0
1537	453	2	1	49	60	1	1	0
1537	323	1	0	32	60	0	1	0
1537	261	1	0	41	60	5	1	0
1537	451	2	1	43	60	0	0	0
1537	207	2	1	35	60	4	0	0
1537	458	0	0	26	60	1	0	0
1538	126	2	1	27	60	3	0	0
1538	456	0	0	49	60	5	1	0
1538	69	2	1	46	60	4	1	0
1538	150	0	1	46	60	0	0	0
1538	58	1	1	31	60	1	0	0
1538	332	0	0	50	60	0	0	0
1538	345	1	0	49	60	1	0	0
1538	361	0	1	35	60	1	0	0
1539	139	0	0	24	60	4	1	0
1539	498	0	0	42	60	0	1	0
1539	443	0	0	24	60	0	1	0
1539	5	2	0	25	60	1	1	0
1539	2	0	1	21	60	2	0	0
1539	234	1	1	45	60	1	0	0
1539	261	1	0	25	60	0	0	0
1539	426	0	0	49	60	1	0	0
1540	438	2	0	27	60	2	1	0
1540	488	0	0	42	60	4	0	0
1540	380	0	1	36	60	2	0	0
1540	251	1	1	49	60	0	1	0
1540	139	2	0	23	60	3	1	0
1540	18	0	0	42	60	1	1	0
1540	176	1	0	26	60	4	1	0
1540	15	2	1	29	60	1	0	0
1541	290	0	0	47	60	0	0	0
1541	132	1	1	32	60	5	0	0
1541	101	2	0	36	60	4	1	0
1541	446	1	1	47	60	0	1	0
1541	102	2	1	31	60	5	0	0
1541	472	1	0	22	60	3	1	0
1541	455	1	0	40	60	1	0	0
1541	291	0	1	41	60	3	0	0
1542	326	1	0	36	60	0	0	0
1542	347	0	0	32	60	2	0	0
1542	12	1	0	41	60	0	0	0
1542	461	2	1	26	60	0	0	0
1542	134	0	0	48	60	4	0	0
1542	263	0	0	30	60	4	1	0
1542	159	0	1	45	60	1	0	0
1542	259	0	0	29	60	1	0	0
1543	330	1	1	37	60	5	0	0
1543	37	0	0	36	60	2	1	0
1543	229	2	0	28	60	5	0	0
1543	310	1	0	39	60	3	0	0
1543	405	0	0	47	60	5	0	0
1543	133	2	0	22	60	3	0	0
1543	471	1	0	47	60	2	0	0
1543	174	2	0	29	60	0	1	0
1544	151	1	0	43	60	1	1	0
1544	272	2	1	40	60	4	0	0
1544	194	0	1	39	60	4	1	0
1544	94	0	0	33	60	5	0	0
1544	304	1	0	25	60	4	1	0
1544	456	0	1	25	60	2	0	0
1544	39	1	0	28	60	5	0	0
1544	462	1	0	34	60	4	0	0
1545	356	1	0	50	60	0	0	0
1545	178	0	0	41	60	1	0	0
1545	322	1	0	36	60	2	0	0
1545	405	1	0	28	60	4	1	0
1545	488	1	1	24	60	5	0	0
1545	30	1	0	28	60	3	1	0
1545	491	0	0	21	60	1	0	0
1545	271	2	0	42	60	0	0	0
1546	313	2	0	23	60	3	0	0
1546	316	1	0	47	60	0	0	0
1546	183	0	0	31	60	2	0	0
1546	249	2	1	25	60	5	0	0
1546	362	2	1	26	60	3	0	0
1546	68	1	1	25	60	3	0	0
1546	121	0	0	29	60	3	0	0
1546	386	0	0	35	60	4	0	0
1547	182	2	0	39	60	5	0	0
1547	75	1	1	40	60	2	0	0
1547	252	2	0	39	60	0	0	0
1547	441	1	0	44	60	1	0	0
1547	341	2	0	38	60	0	0	0
1547	490	2	0	21	60	2	0	0
1547	353	1	0	50	60	1	0	0
1547	60	2	1	37	60	5	0	0
1548	222	1	0	35	60	3	0	0
1548	494	0	1	48	60	4	1	0
1548	25	1	0	38	60	0	0	0
1548	110	2	0	49	60	3	1	0
1548	297	0	1	43	60	1	0	0
1548	420	0	1	25	60	1	0	0
1548	166	0	1	37	60	5	0	0
1548	152	1	1	33	60	0	0	0
1549	18	0	1	39	60	3	0	0
1549	439	2	1	32	60	4	0	0
1549	134	0	0	29	60	0	0	0
1549	491	2	0	20	60	0	1	0
1549	495	0	1	45	60	2	0	0
1549	54	1	1	22	60	1	0	0
1549	164	2	1	23	60	5	1	0
1549	429	1	1	39	60	2	1	0
1550	428	1	1	32	60	3	1	0
1550	304	0	0	45	60	1	0	0
1550	112	2	1	42	60	5	0	0
1550	111	1	0	36	60	5	0	0
1550	162	0	1	44	60	1	0	0
1550	20	2	0	21	60	0	1	0
1550	24	1	1	21	60	0	0	0
1550	265	0	0	28	60	1	0	0
1551	219	0	1	37	60	5	0	0
1551	381	2	0	34	60	4	0	0
1551	361	1	1	40	60	2	0	0
1551	119	0	1	38	60	4	0	0
1551	405	1	1	50	60	3	0	0
1551	20	0	1	26	60	3	1	0
1551	40	0	1	43	60	2	1	0
1551	274	0	1	40	60	4	1	0
1552	24	2	0	45	60	1	0	0
1552	253	0	0	40	60	0	1	0
1552	369	1	1	29	60	3	1	0
1552	151	1	0	44	60	2	0	0
1552	417	0	1	23	60	3	0	0
1552	277	2	0	27	60	5	0	0
1552	400	2	1	37	60	5	0	0
1552	455	0	0	31	60	1	0	0
1553	339	1	0	38	60	2	0	0
1553	119	2	0	35	60	0	0	0
1553	114	2	0	36	60	1	1	0
1553	175	1	0	34	60	5	0	0
1553	399	2	1	36	60	0	0	0
1553	375	1	0	47	60	0	0	0
1553	285	0	0	26	60	3	0	0
1553	113	1	0	47	60	2	0	0
1554	103	1	1	36	60	4	0	0
1554	139	0	1	37	60	1	0	0
1554	480	1	1	31	60	3	0	0
1554	229	1	1	24	60	3	0	0
1554	215	2	0	37	60	3	0	0
1554	489	2	1	41	60	4	0	0
1554	159	0	0	42	60	2	0	0
1554	302	1	0	47	60	4	1	0
1555	119	2	0	50	60	2	0	0
1555	74	2	1	35	60	2	0	0
1555	228	1	1	49	60	3	1	0
1555	98	0	1	50	60	2	1	0
1555	182	2	0	36	60	4	0	0
1555	385	2	1	33	60	5	0	0
1555	162	0	1	23	60	5	0	0
1555	499	2	1	35	60	3	1	0
1556	464	0	1	42	60	1	0	0
1556	146	1	1	44	60	4	0	0
1556	183	1	0	32	60	5	0	0
1556	369	1	1	20	60	4	1	0
1556	371	1	0	47	60	1	0	0
1556	114	2	1	32	60	3	0	0
1556	163	1	1	20	60	0	0	0
1556	25	2	1	28	60	3	0	0
1557	95	0	1	23	60	3	1	0
1557	166	2	1	44	60	3	0	0
1557	146	0	1	30	60	4	0	0
1557	215	0	0	47	60	3	0	0
1557	241	0	1	27	60	5	1	0
1557	392	0	0	47	60	5	0	0
1557	141	0	0	29	60	0	0	0
1557	280	1	0	47	60	0	1	0
1558	54	1	0	40	60	4	0	0
1558	202	2	0	38	60	5	0	0
1558	258	1	0	25	60	3	0	0
1558	179	2	1	34	60	3	0	0
1558	415	0	0	20	60	1	0	0
1558	367	0	0	27	60	2	1	0
1558	310	2	0	39	60	2	0	0
1558	291	1	0	22	60	3	1	0
1559	165	0	0	33	60	4	0	0
1559	479	1	0	25	60	3	0	0
1559	116	1	1	38	60	0	0	0
1559	29	1	1	28	60	1	0	0
1559	381	1	0	48	60	0	0	0
1559	324	1	1	48	60	0	0	0
1559	268	0	1	36	60	1	0	0
1559	300	1	1	31	60	4	0	0
1560	307	1	0	22	60	1	0	0
1560	282	1	1	48	60	2	0	0
1560	459	0	1	49	60	5	0	0
1560	278	0	1	26	60	1	0	0
1560	309	0	0	24	60	0	0	0
1560	481	2	0	49	60	0	0	0
1560	394	1	1	26	60	3	1	0
1560	161	1	0	39	60	3	1	0
1561	12	1	0	27	60	4	0	0
1561	41	2	0	43	60	1	0	0
1561	8	1	1	23	60	0	0	0
1561	344	1	0	28	60	2	1	0
1561	210	2	0	26	60	5	1	0
1561	20	2	0	47	60	4	0	0
1561	374	0	1	45	60	0	0	0
1561	455	0	1	38	60	2	1	0
1562	113	0	0	22	60	1	0	0
1562	116	1	0	27	60	4	1	0
1562	28	0	1	25	60	2	0	0
1562	483	2	1	30	60	1	0	0
1562	266	0	0	27	60	1	1	0
1562	119	1	0	24	60	1	0	0
1562	336	2	1	25	60	0	0	0
1562	431	2	0	43	60	4	0	0
1563	131	2	0	44	60	2	0	0
1563	310	0	0	26	60	3	1	0
1563	247	1	1	36	60	3	0	0
1563	480	0	0	33	60	0	1	0
1563	429	1	0	50	60	0	1	0
1563	83	1	1	35	60	2	1	0
1563	222	2	0	44	60	4	0	0
1563	209	2	1	41	60	5	1	0
1564	380	2	0	45	60	4	1	0
1564	474	1	0	42	60	0	0	0
1564	81	2	1	47	60	5	0	0
1564	481	1	0	35	60	4	0	0
1564	72	2	0	30	60	2	0	0
1564	486	0	1	35	60	4	0	0
1564	111	1	0	31	60	2	0	0
1564	160	0	1	33	60	1	1	0
1565	126	0	0	41	60	5	1	0
1565	1	0	0	49	60	2	1	0
1565	409	1	1	30	60	2	0	0
1565	342	2	0	48	60	0	0	0
1565	150	0	1	26	60	4	0	0
1565	80	1	0	28	60	5	0	0
1565	446	1	0	34	60	4	0	0
1565	424	2	0	29	60	5	0	0
1566	385	2	1	26	60	3	0	0
1566	210	0	1	50	60	2	0	0
1566	355	2	1	20	60	2	0	0
1566	10	0	0	49	60	0	0	0
1566	486	0	1	27	60	4	0	0
1566	380	1	1	29	60	4	0	0
1566	412	2	0	42	60	0	0	0
1566	233	0	1	35	60	2	1	0
1567	389	0	0	48	60	2	1	0
1567	317	2	0	34	60	5	0	0
1567	277	1	0	31	60	4	1	0
1567	130	1	1	30	60	2	0	0
1567	494	1	1	37	60	1	1	0
1567	190	1	0	20	60	4	0	0
1567	26	2	1	49	60	1	0	0
1567	461	2	1	38	60	3	0	0
1568	370	0	0	37	60	2	0	0
1568	82	2	0	30	60	4	0	0
1568	122	0	0	22	60	5	0	0
1568	307	0	1	31	60	5	0	0
1568	318	1	0	42	60	5	1	0
1568	407	1	0	49	60	5	1	0
1568	391	0	0	41	60	4	0	0
1568	111	2	1	20	60	0	0	0
1569	148	0	0	25	60	4	0	0
1569	329	1	0	35	60	1	0	0
1569	219	0	0	36	60	3	0	0
1569	268	1	0	25	60	3	0	0
1569	434	2	0	45	60	1	1	0
1569	68	0	0	40	60	1	1	0
1569	305	1	1	36	60	0	0	0
1569	48	1	1	47	60	3	0	0
1570	8	1	0	40	60	2	0	0
1570	47	0	1	23	60	2	1	0
1570	324	2	0	26	60	2	0	0
1570	121	1	0	41	60	1	0	0
1570	205	2	1	34	60	1	0	0
1570	281	1	0	48	60	2	0	0
1570	2	2	0	39	60	3	0	0
1570	304	1	0	34	60	2	1	0
1571	129	2	1	47	60	2	0	0
1571	297	0	1	40	60	0	0	0
1571	468	1	0	32	60	4	1	0
1571	94	1	1	36	60	4	0	0
1571	60	0	0	36	60	1	0	0
1571	255	0	1	44	60	1	0	0
1571	453	0	1	47	60	1	1	0
1571	339	1	1	32	60	3	0	0
1572	296	0	0	39	60	4	0	0
1572	304	1	1	24	60	5	1	0
1572	4	2	0	41	60	2	1	0
1572	147	1	0	43	60	0	0	0
1572	354	1	1	33	60	5	0	0
1572	352	0	0	37	60	5	0	0
1572	229	0	1	49	60	5	0	0
1572	168	1	0	20	60	2	0	0
1573	364	1	1	50	60	4	0	0
1573	134	0	0	41	60	3	1	0
1573	191	0	0	48	60	1	0	0
1573	460	0	0	30	60	5	1	0
1573	24	0	0	45	60	4	0	0
1573	177	0	1	48	60	5	0	0
1573	393	0	1	29	60	2	1	0
1573	60	0	0	38	60	0	0	0
1574	419	2	1	34	60	2	1	0
1574	134	2	0	46	60	2	0	0
1574	456	2	0	50	60	4	1	0
1574	11	2	1	34	60	4	0	0
1574	315	1	0	40	60	2	0	0
1574	303	2	0	27	60	5	1	0
1574	75	2	0	37	60	0	0	0
1574	115	2	0	22	60	5	0	0
1575	226	2	0	29	60	4	0	0
1575	56	2	0	23	60	1	0	0
1575	294	2	1	27	60	1	0	0
1575	344	1	0	43	60	5	1	0
1575	151	1	0	48	60	3	0	0
1575	183	2	0	35	60	2	0	0
1575	137	2	0	50	60	4	0	0
1575	256	2	1	25	60	1	0	0
1576	485	1	1	38	60	0	1	0
1576	41	1	0	42	60	3	0	0
1576	243	0	0	24	60	0	0	0
1576	143	2	1	37	60	3	0	0
1576	193	0	0	38	60	3	0	0
1576	246	0	0	22	60	3	1	0
1576	147	2	1	23	60	5	1	0
1576	187	0	0	31	60	2	0	0
1577	18	1	0	30	60	2	0	0
1577	254	0	1	21	60	1	0	0
1577	463	1	0	44	60	3	1	0
1577	87	1	0	28	60	0	0	0
1577	240	0	1	41	60	4	0	0
1577	107	0	0	50	60	1	1	0
1577	101	2	1	35	60	1	0	0
1577	190	1	0	43	60	1	1	0
1578	344	2	1	25	60	3	1	0
1578	312	2	1	50	60	4	0	0
1578	396	2	1	34	60	0	0	0
1578	262	2	1	30	60	0	0	0
1578	347	0	0	47	60	4	1	0
1578	34	0	0	49	60	3	1	0
1578	39	2	1	43	60	4	0	0
1578	48	1	0	36	60	0	1	0
1579	74	1	0	38	60	1	0	0
1579	423	0	0	34	60	3	0	0
1579	299	2	1	23	60	5	0	0
1579	447	2	0	48	60	2	0	0
1579	464	1	1	45	60	5	0	0
1579	139	2	1	40	60	2	1	0
1579	5	0	0	50	60	1	0	0
1579	113	0	1	37	60	1	1	0
1580	493	1	1	47	60	5	0	0
1580	36	2	1	49	60	5	0	0
1580	116	2	0	45	60	5	0	0
1580	282	1	1	37	60	2	0	0
1580	135	2	1	20	60	1	0	0
1580	456	0	0	33	60	2	0	0
1580	222	1	1	34	60	3	1	0
1580	363	2	1	38	60	1	1	0
1581	25	2	0	33	60	3	1	0
1581	337	1	1	28	60	2	0	0
1581	8	2	0	20	60	5	1	0
1581	35	0	1	36	60	0	1	0
1581	179	2	0	47	60	5	0	0
1581	456	1	1	30	60	0	0	0
1581	16	0	1	28	60	4	1	0
1581	49	2	0	38	60	3	1	0
1582	162	0	0	32	60	1	0	0
1582	143	1	0	21	60	1	0	0
1582	38	2	1	42	60	0	1	0
1582	401	0	1	46	60	2	0	0
1582	72	1	0	31	60	0	1	0
1582	434	0	0	22	60	3	1	0
1582	244	0	1	34	60	2	0	0
1582	113	1	0	35	60	2	1	0
1583	300	1	1	21	60	4	0	0
1583	376	2	0	43	60	5	1	0
1583	278	1	0	45	60	5	1	0
1583	446	0	0	46	60	0	0	0
1583	26	1	0	44	60	4	1	0
1583	35	0	0	28	60	1	0	0
1583	192	0	0	22	60	5	0	0
1583	139	1	0	21	60	4	1	0
1584	263	1	1	24	60	3	0	0
1584	51	0	1	34	60	1	0	0
1584	494	1	1	37	60	4	1	0
1584	399	1	0	30	60	2	1	0
1584	8	2	0	35	60	1	1	0
1584	374	1	0	22	60	4	0	0
1584	457	1	1	32	60	0	1	0
1584	419	2	0	30	60	1	0	0
1585	341	2	0	42	60	5	0	0
1585	292	2	0	47	60	1	0	0
1585	481	0	0	24	60	2	0	0
1585	283	1	1	50	60	5	1	0
1585	300	1	0	46	60	2	0	0
1585	14	2	1	50	60	2	0	0
1585	250	2	1	43	60	4	0	0
1585	369	2	0	32	60	3	0	0
1586	325	1	1	48	60	0	0	0
1586	390	1	0	21	60	1	0	0
1586	434	0	1	49	60	5	0	0
1586	423	2	0	42	60	5	0	0
1586	243	0	0	41	60	2	0	0
1586	85	0	0	21	60	3	0	0
1586	32	1	1	37	60	4	0	0
1586	393	0	1	30	60	3	0	0
1587	98	1	0	33	60	0	0	0
1587	257	1	0	41	60	2	0	0
1587	282	0	0	35	60	1	0	0
1587	72	1	0	44	60	4	0	0
1587	385	1	1	37	60	5	0	0
1587	408	2	0	46	60	4	1	0
1587	331	0	1	42	60	2	1	0
1587	411	0	0	46	60	0	0	0
1588	424	0	1	43	60	1	0	0
1588	114	1	1	44	60	1	0	0
1588	142	1	0	41	60	2	1	0
1588	89	2	1	21	60	3	0	0
1588	196	0	1	29	60	0	1	0
1588	462	1	1	33	60	1	0	0
1588	163	0	1	20	60	2	0	0
1588	357	0	1	35	60	0	1	0
1589	227	1	1	26	60	0	0	0
1589	458	0	1	38	60	2	0	0
1589	477	0	1	33	60	3	0	0
1589	474	0	0	41	60	2	1	0
1589	472	2	0	22	60	2	0	0
1589	234	2	0	25	60	3	0	0
1589	238	0	1	32	60	1	0	0
1589	440	0	1	40	60	4	1	0
1590	189	2	0	29	60	1	0	0
1590	422	2	1	40	60	2	0	0
1590	49	2	0	33	60	2	0	0
1590	242	2	1	46	60	2	1	0
1590	393	1	0	40	60	3	0	0
1590	468	0	0	37	60	3	1	0
1590	449	1	0	36	60	0	1	0
1590	474	0	0	26	60	5	1	0
1591	65	1	0	30	60	3	0	0
1591	188	1	0	41	60	0	0	0
1591	192	1	0	34	60	0	0	0
1591	397	0	0	22	60	4	0	0
1591	423	1	1	38	60	2	0	0
1591	179	0	0	47	60	2	0	0
1591	467	0	1	35	60	1	0	0
1591	366	0	1	50	60	4	0	0
1592	272	0	0	37	60	1	0	0
1592	278	2	1	49	60	0	0	0
1592	347	0	0	40	60	0	0	0
1592	112	1	1	28	60	4	0	0
1592	340	2	0	33	60	5	0	0
1592	124	1	0	30	60	2	0	0
1592	330	2	0	45	60	1	1	0
1592	23	0	1	40	60	5	0	0
1593	413	0	0	23	60	0	0	0
1593	196	1	1	34	60	5	0	0
1593	330	1	0	32	60	3	0	0
1593	240	1	0	22	60	0	0	0
1593	95	0	0	26	60	3	0	0
1593	69	1	1	44	60	1	1	0
1593	396	2	1	35	60	0	0	0
1593	198	1	0	24	60	2	0	0
1594	272	0	0	34	60	3	0	0
1594	394	2	1	38	60	3	0	0
1594	365	2	0	40	60	0	0	0
1594	468	0	1	29	60	5	1	0
1594	189	0	0	20	60	4	0	0
1594	479	2	0	39	60	2	0	0
1594	129	0	1	26	60	2	1	0
1594	12	0	0	28	60	4	0	0
1595	32	2	0	46	60	1	1	0
1595	14	0	0	36	60	0	1	0
1595	119	1	0	45	60	3	0	0
1595	303	0	1	24	60	5	0	0
1595	464	0	0	33	60	0	0	0
1595	114	0	1	23	60	3	0	0
1595	27	2	1	33	60	0	0	0
1595	251	0	0	21	60	5	0	0
1596	6	0	1	22	60	4	0	0
1596	156	0	1	20	60	1	0	0
1596	292	2	0	45	60	0	0	0
1596	227	1	1	45	60	1	0	0
1596	474	0	0	24	60	1	0	0
1596	391	0	1	24	60	3	0	0
1596	255	0	0	47	60	4	1	0
1596	91	1	0	50	60	2	1	0
1597	282	1	0	43	60	4	0	0
1597	179	1	0	32	60	3	1	0
1597	251	0	1	38	60	2	1	0
1597	484	1	1	50	60	5	0	0
1597	295	2	1	50	60	2	0	0
1597	94	0	0	48	60	3	0	0
1597	305	0	0	36	60	4	1	0
1597	413	0	0	33	60	2	0	0
1598	63	1	0	27	60	1	1	0
1598	453	1	0	46	60	1	0	0
1598	351	2	0	35	60	0	1	0
1598	24	0	1	41	60	2	0	0
1598	244	1	0	49	60	4	0	0
1598	157	2	0	48	60	2	0	0
1598	112	0	1	28	60	0	1	0
1598	491	0	1	49	60	3	1	0
1599	417	0	1	41	60	5	1	0
1599	217	1	1	37	60	2	0	0
1599	260	0	1	39	60	1	0	0
1599	223	0	1	34	60	5	0	0
1599	10	2	1	34	60	4	0	0
1599	218	0	0	35	60	2	0	0
1599	275	2	0	39	60	2	0	0
1599	151	0	1	40	60	5	0	0
1600	414	1	0	39	60	3	0	0
1600	340	2	1	47	60	1	0	0
1600	145	0	0	40	60	2	0	0
1600	317	0	0	46	60	1	1	0
1600	64	1	1	22	60	1	0	0
1600	333	2	1	40	60	0	0	0
1600	487	0	0	44	60	3	0	0
1600	315	2	0	34	60	0	0	0
1601	459	1	0	49	60	3	0	0
1601	166	2	1	41	60	1	0	0
1601	351	0	1	31	60	3	0	0
1601	156	2	1	36	60	4	0	0
1601	478	0	0	27	60	2	1	0
1601	492	1	0	48	60	3	0	0
1601	130	0	0	50	60	5	0	0
1601	425	2	0	50	60	2	1	0
1602	40	0	1	40	60	2	0	0
1602	292	2	0	49	60	5	1	0
1602	327	0	1	46	60	0	0	0
1602	210	0	0	23	60	2	0	0
1602	18	1	1	35	60	3	0	0
1602	92	2	0	32	60	2	0	0
1602	215	1	1	28	60	2	0	0
1602	20	0	1	26	60	0	0	0
1603	479	1	0	43	60	4	0	0
1603	476	1	0	22	60	2	0	0
1603	404	1	1	49	60	2	0	0
1603	164	1	1	47	60	4	0	0
1603	10	0	0	23	60	2	0	0
1603	427	0	1	45	60	0	1	0
1603	224	2	1	43	60	0	0	0
1603	187	0	1	22	60	1	0	0
1604	224	0	0	29	60	5	0	0
1604	374	0	1	30	60	4	0	0
1604	401	1	0	31	60	0	0	0
1604	411	0	1	39	60	2	0	0
1604	283	2	1	35	60	3	1	0
1604	493	1	0	26	60	5	0	0
1604	240	2	1	32	60	4	0	0
1604	150	2	0	28	60	3	0	0
1605	447	1	1	49	60	2	0	0
1605	163	0	1	37	60	4	0	0
1605	316	2	0	43	60	4	0	0
1605	280	0	1	47	60	5	0	0
1605	145	0	1	29	60	0	1	0
1605	231	2	1	27	60	0	0	0
1605	262	1	1	38	60	0	1	0
1605	477	0	0	34	60	0	0	0
1606	194	0	0	41	60	0	0	0
1606	127	2	1	28	60	4	1	0
1606	300	2	0	22	60	1	0	0
1606	193	0	0	48	60	1	0	0
1606	100	0	1	24	60	5	1	0
1606	463	2	1	25	60	0	0	0
1606	456	2	0	30	60	3	0	0
1606	202	2	0	43	60	4	0	0
1607	426	0	0	47	60	5	0	0
1607	302	0	0	49	60	4	0	0
1607	351	2	1	26	60	0	1	0
1607	273	1	1	35	60	2	0	0
1607	83	1	0	46	60	4	1	0
1607	117	1	1	22	60	3	1	0
1607	296	1	0	34	60	0	0	0
1607	120	1	1	20	60	2	0	0
1608	33	0	1	44	60	5	0	0
1608	205	0	1	45	60	0	0	0
1608	500	1	1	50	60	1	0	0
1608	412	0	0	27	60	4	0	0
1608	288	0	0	23	60	4	1	0
1608	61	1	1	21	60	5	0	0
1608	349	1	0	49	60	1	0	0
1608	224	0	0	30	60	3	1	0
1609	366	1	0	49	60	3	0	0
1609	331	0	1	32	60	1	0	0
1609	269	0	0	45	60	5	1	0
1609	321	1	0	32	60	0	0	0
1609	59	0	0	48	60	0	0	0
1609	340	1	0	40	60	5	1	0
1609	431	1	1	25	60	2	1	0
1609	289	2	1	27	60	2	0	0
1610	126	2	1	37	60	2	0	0
1610	163	0	0	25	60	0	0	0
1610	21	0	1	49	60	4	0	0
1610	327	2	0	39	60	1	1	0
1610	328	0	0	44	60	2	1	0
1610	232	1	1	29	60	2	0	0
1610	293	2	1	20	60	2	0	0
1610	305	1	0	30	60	1	0	0
1611	495	1	0	35	60	4	1	0
1611	456	2	1	28	60	0	0	0
1611	64	0	1	42	60	4	1	0
1611	213	0	1	28	60	2	0	0
1611	84	2	1	39	60	4	0	0
1611	216	0	0	31	60	3	0	0
1611	364	2	0	23	60	2	0	0
1611	32	1	0	37	60	5	0	0
1612	292	1	1	48	60	5	1	0
1612	80	0	1	28	60	0	0	0
1612	372	2	0	24	60	2	0	0
1612	21	2	1	46	60	1	0	0
1612	373	2	1	38	60	0	0	0
1612	493	0	1	41	60	4	1	0
1612	92	2	0	37	60	1	0	0
1612	354	0	1	49	60	0	1	0
1613	437	1	1	33	60	3	0	0
1613	287	0	0	25	60	1	0	0
1613	101	0	1	20	60	5	0	0
1613	382	2	0	42	60	3	0	0
1613	103	1	1	44	60	0	0	0
1613	353	1	0	36	60	5	0	0
1613	144	0	0	29	60	5	1	0
1613	61	1	0	31	60	4	0	0
1614	172	0	1	28	60	1	0	0
1614	341	0	1	40	60	5	0	0
1614	197	0	1	31	60	3	1	0
1614	145	0	1	20	60	5	0	0
1614	357	2	1	22	60	5	0	0
1614	378	2	0	39	60	0	0	0
1614	298	1	0	25	60	4	1	0
1614	144	0	0	41	60	0	0	0
1615	213	0	1	39	60	0	0	0
1615	331	1	0	47	60	0	0	0
1615	178	1	1	29	60	0	0	0
1615	140	0	1	36	60	3	1	0
1615	116	0	1	37	60	0	0	0
1615	165	0	0	24	60	0	0	0
1615	264	1	1	34	60	0	0	0
1615	416	1	1	40	60	2	0	0
1616	220	0	0	43	60	2	0	0
1616	40	0	0	33	60	2	0	0
1616	320	1	0	28	60	4	0	0
1616	365	2	0	42	60	0	0	0
1616	242	2	0	39	60	4	0	0
1616	123	1	0	21	60	1	1	0
1616	229	2	0	22	60	5	1	0
1616	475	0	0	45	60	0	0	0
1617	91	0	1	40	60	3	1	0
1617	227	0	0	24	60	1	0	0
1617	391	1	0	40	60	5	1	0
1617	194	2	0	32	60	5	0	0
1617	259	2	1	22	60	0	0	0
1617	341	0	0	24	60	2	1	0
1617	477	0	1	28	60	5	0	0
1617	17	0	1	38	60	0	0	0
1618	42	1	0	42	60	4	0	0
1618	206	1	0	23	60	1	0	0
1618	398	0	1	29	60	2	0	0
1618	266	0	1	42	60	4	0	0
1618	255	0	1	21	60	4	1	0
1618	85	2	0	30	60	1	0	0
1618	183	0	1	33	60	4	0	0
1618	252	1	0	43	60	3	0	0
1619	408	0	0	48	60	2	0	0
1619	383	2	1	20	60	4	0	0
1619	265	0	1	43	60	0	1	0
1619	487	0	0	41	60	5	0	0
1619	184	0	1	49	60	5	0	0
1619	311	2	1	32	60	3	0	0
1619	167	0	1	29	60	4	0	0
1619	240	1	0	35	60	3	0	0
1620	290	0	0	39	60	2	1	0
1620	414	0	0	43	60	1	0	0
1620	265	0	1	48	60	5	1	0
1620	254	0	0	39	60	5	1	0
1620	155	2	1	36	60	1	1	0
1620	438	0	0	26	60	4	1	0
1620	270	0	0	41	60	2	0	0
1620	450	1	0	50	60	4	1	0
1621	152	1	1	36	60	0	0	0
1621	131	2	0	34	60	3	0	0
1621	172	1	0	43	60	4	0	0
1621	138	1	0	43	60	3	0	0
1621	361	0	1	26	60	5	1	0
1621	340	1	1	24	60	3	0	0
1621	459	0	1	34	60	0	0	0
1621	94	0	1	21	60	0	0	0
1622	138	2	1	27	60	3	0	0
1622	418	0	0	46	60	0	0	0
1622	330	2	1	38	60	5	0	0
1622	48	1	0	20	60	1	1	0
1622	66	0	1	30	60	2	0	0
1622	47	0	1	32	60	2	0	0
1622	382	1	1	44	60	2	0	0
1622	333	2	0	50	60	2	0	0
1623	311	1	1	20	60	5	0	0
1623	79	2	1	22	60	3	0	0
1623	177	0	0	40	60	3	0	0
1623	77	0	0	31	60	5	1	0
1623	353	0	1	34	60	2	0	0
1623	362	1	0	38	60	4	0	0
1623	62	1	1	43	60	3	0	0
1623	378	0	1	27	60	1	0	0
1624	5	1	1	34	60	4	1	0
1624	146	2	0	34	60	5	0	0
1624	100	2	1	27	60	4	1	0
1624	123	0	0	26	60	4	0	0
1624	8	2	1	34	60	4	1	0
1624	54	0	1	50	60	2	1	0
1624	402	1	1	48	60	2	0	0
1624	441	2	1	30	60	5	0	0
1625	47	1	0	33	60	0	0	0
1625	10	1	0	42	60	3	0	0
1625	181	0	1	48	60	0	1	0
1625	408	1	0	31	60	2	0	0
1625	206	2	1	45	60	5	0	0
1625	243	0	1	47	60	0	0	0
1625	421	2	0	40	60	4	1	0
1625	412	0	1	34	60	3	0	0
1626	400	2	1	35	60	4	1	0
1626	270	1	1	39	60	0	1	0
1626	101	1	0	21	60	1	0	0
1626	84	1	0	43	60	4	0	0
1626	20	0	0	39	60	1	0	0
1626	460	2	0	39	60	5	0	0
1626	374	1	1	48	60	1	0	0
1626	105	1	1	44	60	3	1	0
1627	468	1	1	30	60	2	1	0
1627	457	0	1	20	60	4	0	0
1627	385	0	0	27	60	5	0	0
1627	46	0	1	48	60	3	1	0
1627	455	1	0	31	60	2	0	0
1627	396	0	0	43	60	2	1	0
1627	113	2	1	35	60	1	0	0
1627	495	1	0	31	60	5	0	0
1628	199	1	0	21	60	1	1	0
1628	499	2	1	32	60	2	0	0
1628	500	1	1	35	60	3	0	0
1628	112	2	1	28	60	3	1	0
1628	437	0	0	32	60	0	0	0
1628	252	2	1	29	60	0	1	0
1628	258	0	1	44	60	5	0	0
1628	212	1	1	40	60	0	0	0
1629	157	0	1	35	60	0	0	0
1629	411	2	0	37	60	5	0	0
1629	381	0	1	41	60	4	0	0
1629	434	0	0	48	60	1	1	0
1629	139	2	1	27	60	1	0	0
1629	185	2	0	43	60	0	0	0
1629	296	1	1	22	60	1	0	0
1629	47	2	0	47	60	5	0	0
1630	318	1	0	31	60	4	0	0
1630	124	0	1	20	60	4	0	0
1630	141	2	0	47	60	3	0	0
1630	337	0	1	23	60	1	0	0
1630	351	1	0	32	60	1	0	0
1630	6	0	0	41	60	4	0	0
1630	73	1	1	28	60	5	0	0
1630	216	2	1	44	60	4	0	0
1631	374	0	0	30	60	3	0	0
1631	257	1	1	37	60	4	0	0
1631	25	2	1	46	60	4	0	0
1631	333	1	1	30	60	1	0	0
1631	130	0	0	23	60	3	0	0
1631	167	1	1	29	60	2	0	0
1631	402	1	0	40	60	1	0	0
1631	203	2	0	38	60	3	0	0
1632	167	0	0	42	60	2	0	0
1632	161	1	0	33	60	1	0	0
1632	433	2	1	22	60	1	0	0
1632	229	0	1	38	60	5	0	0
1632	172	1	1	26	60	2	0	0
1632	91	1	0	21	60	5	0	0
1632	385	0	0	35	60	4	0	0
1632	408	1	1	42	60	2	0	0
1633	374	1	0	46	60	3	1	0
1633	498	1	1	33	60	0	0	0
1633	115	0	0	43	60	1	0	0
1633	107	0	0	47	60	0	0	0
1633	181	0	1	41	60	1	0	0
1633	177	1	1	34	60	3	0	0
1633	231	2	0	26	60	4	0	0
1633	483	2	1	50	60	2	0	0
1634	392	0	1	30	60	3	0	0
1634	369	2	1	27	60	5	0	0
1634	332	1	1	40	60	3	1	0
1634	329	0	1	32	60	4	1	0
1634	182	1	1	20	60	3	0	0
1634	365	1	0	39	60	2	0	0
1634	338	2	1	45	60	5	0	0
1634	172	2	1	27	60	0	0	0
1635	222	2	1	39	60	4	1	0
1635	97	1	0	50	60	2	0	0
1635	380	0	1	26	60	4	0	0
1635	109	0	0	49	60	3	0	0
1635	287	0	0	25	60	5	0	0
1635	81	0	0	23	60	2	0	0
1635	410	0	0	50	60	4	0	0
1635	338	1	0	46	60	1	0	0
1636	115	2	1	50	60	1	1	0
1636	67	2	1	41	60	4	0	0
1636	94	2	0	42	60	2	0	0
1636	126	2	0	37	60	1	1	0
1636	450	1	0	50	60	0	0	0
1636	349	2	1	27	60	1	0	0
1636	114	0	1	38	60	4	0	0
1636	12	0	1	22	60	3	0	0
1637	344	2	1	28	60	5	0	0
1637	120	1	0	50	60	1	0	0
1637	8	2	1	46	60	4	0	0
1637	181	1	1	36	60	0	0	0
1637	38	1	0	40	60	3	0	0
1637	377	1	1	42	60	4	0	0
1637	241	1	1	34	60	4	1	0
1637	163	0	0	21	60	3	0	0
1638	15	0	0	25	60	5	0	0
1638	414	1	0	30	60	4	0	0
1638	476	1	0	26	60	5	1	0
1638	215	2	1	48	60	4	0	0
1638	35	1	1	45	60	3	0	0
1638	326	0	1	38	60	4	0	0
1638	157	2	1	30	60	3	0	0
1638	13	1	1	42	60	0	0	0
1639	310	1	0	28	60	3	0	0
1639	213	0	1	20	60	4	0	0
1639	5	0	1	20	60	3	0	0
1639	207	2	0	46	60	2	0	0
1639	409	2	0	27	60	1	0	0
1639	90	1	1	37	60	3	0	0
1639	136	0	1	21	60	3	1	0
1639	261	1	0	30	60	5	0	0
1640	281	0	0	47	60	5	0	0
1640	18	0	1	28	60	3	0	0
1640	101	2	0	44	60	5	0	0
1640	103	2	0	45	60	1	0	0
1640	66	0	1	21	60	2	0	0
1640	426	1	1	28	60	0	0	0
1640	236	0	0	34	60	2	0	0
1640	310	1	0	49	60	4	1	0
1641	10	2	0	23	60	1	0	0
1641	236	2	0	35	60	5	0	0
1641	269	0	1	22	60	5	0	0
1641	180	0	1	26	60	0	0	0
1641	34	0	0	39	60	2	0	0
1641	153	1	1	23	60	4	1	0
1641	113	2	0	20	60	2	0	0
1641	444	1	0	46	60	2	0	0
1642	27	1	0	35	60	2	1	0
1642	85	0	0	38	60	0	1	0
1642	470	2	0	25	60	3	0	0
1642	83	0	0	49	60	1	0	0
1642	179	0	0	38	60	5	0	0
1642	5	1	1	44	60	3	0	0
1642	465	1	0	40	60	1	0	0
1642	451	1	0	35	60	5	0	0
1643	15	2	0	26	60	3	1	0
1643	313	0	0	41	60	2	0	0
1643	157	1	0	25	60	3	1	0
1643	461	2	0	28	60	3	0	0
1643	115	1	0	24	60	2	1	0
1643	418	0	0	45	60	1	0	0
1643	214	0	1	30	60	0	0	0
1643	105	2	0	43	60	1	1	0
1644	460	1	0	44	60	0	0	0
1644	447	0	1	40	60	2	1	0
1644	62	0	0	34	60	5	0	0
1644	92	0	1	30	60	3	0	0
1644	169	2	1	22	60	2	0	0
1644	470	0	0	31	60	1	0	0
1644	297	1	1	23	60	1	1	0
1644	272	2	1	48	60	5	1	0
1645	245	0	1	40	60	4	1	0
1645	159	1	0	48	60	3	0	0
1645	36	2	0	50	60	4	0	0
1645	359	2	1	38	60	3	0	0
1645	466	1	0	43	60	4	0	0
1645	127	2	0	38	60	3	1	0
1645	211	0	0	20	60	0	0	0
1645	129	1	1	26	60	2	1	0
1646	93	1	0	35	60	2	0	0
1646	70	1	0	44	60	5	0	0
1646	60	2	1	39	60	1	0	0
1646	165	1	1	36	60	3	0	0
1646	104	2	1	46	60	3	0	0
1646	86	0	0	25	60	0	1	0
1646	341	2	0	49	60	5	0	0
1646	421	0	1	26	60	0	1	0
1647	168	2	1	34	60	1	1	0
1647	259	2	1	30	60	2	1	0
1647	62	1	0	28	60	4	0	0
1647	462	1	1	21	60	2	0	0
1647	404	1	0	32	60	2	0	0
1647	278	2	0	44	60	3	0	0
1647	390	2	1	35	60	2	0	0
1647	43	1	0	46	60	4	0	0
1648	321	1	1	25	60	0	0	0
1648	248	1	1	25	60	5	1	0
1648	419	1	0	28	60	5	0	0
1648	138	1	1	26	60	0	0	0
1648	456	2	0	32	60	3	1	0
1648	14	1	0	41	60	1	0	0
1648	373	2	0	28	60	5	0	0
1648	76	2	1	21	60	0	0	0
1649	389	1	1	43	60	5	1	0
1649	356	0	0	45	60	0	1	0
1649	407	2	1	39	60	1	0	0
1649	344	0	1	21	60	0	0	0
1649	359	2	1	49	60	0	0	0
1649	177	2	0	22	60	4	0	0
1649	260	1	1	41	60	1	0	0
1649	227	1	1	24	60	2	0	0
1650	408	2	1	41	60	5	0	0
1650	113	1	1	29	60	2	1	0
1650	473	1	0	32	60	4	0	0
1650	262	2	1	23	60	2	0	0
1650	283	1	1	23	60	4	0	0
1650	208	1	1	22	60	3	0	0
1650	451	0	0	36	60	4	0	0
1650	174	2	0	43	60	1	0	0
1651	94	0	1	20	60	5	1	0
1651	478	2	1	44	60	4	0	0
1651	392	1	1	23	60	2	0	0
1651	468	2	1	46	60	5	0	0
1651	209	0	1	23	60	3	0	0
1651	258	2	1	40	60	0	1	0
1651	38	1	1	22	60	3	0	0
1651	323	0	0	32	60	0	0	0
1652	272	0	0	26	60	3	0	0
1652	130	1	0	30	60	4	0	0
1652	100	0	0	25	60	2	0	0
1652	344	0	1	27	60	2	1	0
1652	451	2	1	25	60	5	0	0
1652	63	0	0	48	60	2	0	0
1652	489	2	1	49	60	4	1	0
1652	213	2	1	39	60	1	0	0
1653	55	2	1	48	60	5	0	0
1653	276	1	0	45	60	0	1	0
1653	69	0	1	23	60	0	0	0
1653	41	0	0	49	60	2	1	0
1653	381	0	0	46	60	4	0	0
1653	105	1	1	22	60	1	1	0
1653	218	1	1	20	60	5	0	0
1653	423	2	1	45	60	5	0	0
1654	462	1	1	33	60	3	0	0
1654	69	2	1	25	60	5	0	0
1654	88	2	0	20	60	4	0	0
1654	187	2	1	31	60	1	0	0
1654	390	0	1	21	60	5	0	0
1654	100	2	0	48	60	2	0	0
1654	204	2	0	44	60	3	0	0
1654	347	0	1	32	60	4	0	0
1655	188	1	0	31	60	5	0	0
1655	498	2	1	27	60	5	0	0
1655	408	0	1	37	60	3	0	0
1655	7	1	0	31	60	5	0	0
1655	291	2	1	35	60	3	0	0
1655	189	2	1	38	60	4	0	0
1655	367	1	0	27	60	2	0	0
1655	43	2	1	32	60	5	0	0
1656	65	1	1	23	60	3	0	0
1656	49	1	0	20	60	1	0	0
1656	20	1	0	44	60	0	0	0
1656	239	2	0	34	60	2	0	0
1656	55	1	0	34	60	3	0	0
1656	395	2	0	31	60	2	0	0
1656	451	2	1	31	60	5	0	0
1656	181	2	0	25	60	1	0	0
1657	71	0	1	28	60	1	0	0
1657	189	0	0	32	60	0	1	0
1657	491	0	0	35	60	3	0	0
1657	133	2	0	48	60	4	0	0
1657	391	1	1	43	60	2	0	0
1657	101	1	0	47	60	1	0	0
1657	439	0	0	24	60	3	0	0
1657	63	1	0	40	60	0	1	0
1658	286	2	1	44	60	5	1	0
1658	5	2	0	27	60	5	0	0
1658	291	1	0	46	60	0	1	0
1658	293	2	1	28	60	4	0	0
1658	241	1	0	24	60	4	0	0
1658	311	2	0	34	60	1	0	0
1658	303	1	1	49	60	3	0	0
1658	468	1	0	36	60	1	1	0
1659	18	1	1	37	60	1	1	0
1659	391	1	1	20	60	3	0	0
1659	304	2	1	31	60	5	0	0
1659	429	1	0	34	60	1	0	0
1659	361	2	0	35	60	5	1	0
1659	477	2	1	20	60	5	0	0
1659	421	2	1	34	60	5	0	0
1659	455	0	1	33	60	5	1	0
1660	140	1	1	24	60	0	0	0
1660	158	1	1	20	60	5	0	0
1660	385	1	0	37	60	0	1	0
1660	348	0	1	34	60	0	0	0
1660	41	1	0	37	60	2	1	0
1660	304	0	0	44	60	0	0	0
1660	276	1	0	37	60	0	0	0
1660	259	2	0	45	60	3	0	0
1661	121	2	1	22	60	3	0	0
1661	275	0	0	37	60	4	1	0
1661	345	2	1	43	60	4	0	0
1661	190	0	1	30	60	4	0	0
1661	79	0	1	46	60	5	1	0
1661	70	2	0	22	60	4	0	0
1661	465	2	0	27	60	0	0	0
1661	388	1	0	42	60	1	0	0
1662	1	0	1	48	60	5	0	0
1662	370	0	1	28	60	2	0	0
1662	12	2	1	29	60	2	0	0
1662	243	0	1	34	60	3	0	0
1662	172	2	1	45	60	0	0	0
1662	270	2	1	47	60	0	1	0
1662	218	1	0	50	60	5	0	0
1662	269	2	1	46	60	5	1	0
1663	239	2	0	33	60	5	0	0
1663	423	1	0	42	60	4	0	0
1663	305	0	1	33	60	2	0	0
1663	182	1	0	25	60	1	0	0
1663	117	1	1	36	60	1	0	0
1663	447	2	1	20	60	2	0	0
1663	358	0	0	25	60	4	0	0
1663	145	2	1	27	60	2	0	0
1664	230	0	0	48	60	5	1	0
1664	153	1	0	23	60	5	0	0
1664	111	1	0	45	60	3	0	0
1664	23	2	1	21	60	4	1	0
1664	121	2	1	48	60	5	0	0
1664	99	2	1	25	60	5	0	0
1664	486	2	1	48	60	5	0	0
1664	87	1	1	39	60	4	0	0
1665	122	2	0	40	60	2	0	0
1665	150	2	1	47	60	1	1	0
1665	465	1	1	25	60	5	1	0
1665	140	2	0	31	60	3	0	0
1665	77	2	0	23	60	2	0	0
1665	168	1	1	34	60	0	1	0
1665	387	0	0	44	60	2	0	0
1665	366	2	1	43	60	1	0	0
1666	335	1	0	47	60	3	1	0
1666	472	2	1	48	60	0	0	0
1666	272	0	0	27	60	4	0	0
1666	348	2	0	23	60	1	0	0
1666	395	0	0	47	60	0	1	0
1666	181	0	0	30	60	0	0	0
1666	239	1	0	30	60	4	0	0
1666	166	2	1	28	60	2	0	0
1667	224	0	1	29	60	3	1	0
1667	35	2	1	27	60	2	0	0
1667	477	0	1	22	60	2	0	0
1667	120	2	1	32	60	5	0	0
1667	279	2	0	36	60	2	0	0
1667	433	2	0	49	60	3	1	0
1667	278	1	0	29	60	2	0	0
1667	400	0	1	50	60	1	0	0
1668	53	2	0	50	60	4	0	0
1668	269	0	1	43	60	5	0	0
1668	375	0	0	35	60	5	1	0
1668	124	2	0	21	60	5	1	0
1668	178	2	0	50	60	3	0	0
1668	297	0	0	44	60	1	1	0
1668	329	2	0	36	60	3	0	0
1668	103	1	1	26	60	4	1	0
1669	466	1	0	23	60	4	0	0
1669	135	2	1	38	60	4	0	0
1669	444	2	0	29	60	4	0	0
1669	186	0	0	32	60	2	1	0
1669	21	2	0	31	60	1	0	0
1669	44	0	1	40	60	0	0	0
1669	367	1	1	42	60	1	0	0
1669	78	0	1	40	60	5	0	0
1670	195	0	1	46	60	4	1	0
1670	70	2	1	22	60	1	1	0
1670	412	2	0	27	60	4	1	0
1670	322	1	0	50	60	4	0	0
1670	118	2	0	23	60	5	0	0
1670	211	2	0	32	60	2	0	0
1670	69	2	1	33	60	5	0	0
1670	324	1	1	29	60	5	0	0
1671	125	1	0	47	60	0	0	0
1671	142	2	1	36	60	5	1	0
1671	180	2	1	47	60	0	0	0
1671	477	0	1	22	60	0	1	0
1671	98	1	1	25	60	0	0	0
1671	71	1	0	45	60	2	0	0
1671	499	0	0	31	60	2	0	0
1671	127	1	1	41	60	0	0	0
1672	450	1	1	34	60	1	1	0
1672	162	2	1	46	60	0	0	0
1672	92	0	1	21	60	4	0	0
1672	127	1	1	24	60	1	0	0
1672	228	1	0	31	60	4	0	0
1672	418	1	0	33	60	4	0	0
1672	166	2	0	29	60	3	0	0
1672	429	1	1	33	60	5	0	0
1673	109	2	1	45	60	2	0	0
1673	462	1	1	34	60	4	1	0
1673	332	2	1	24	60	4	1	0
1673	88	2	0	43	60	5	1	0
1673	145	0	1	36	60	2	0	0
1673	13	2	1	21	60	2	0	0
1673	378	0	0	22	60	1	0	0
1673	199	0	1	32	60	3	1	0
1674	367	1	1	36	60	4	0	0
1674	450	0	1	27	60	2	0	0
1674	392	0	1	22	60	4	1	0
1674	205	1	0	24	60	5	0	0
1674	63	0	1	31	60	5	1	0
1674	463	1	0	38	60	1	0	0
1674	254	2	1	41	60	0	1	0
1674	393	0	1	28	60	1	0	0
1675	183	0	1	49	60	2	0	0
1675	273	0	1	24	60	0	0	0
1675	116	0	0	45	60	5	0	0
1675	24	2	0	47	60	5	0	0
1675	426	2	0	50	60	5	1	0
1675	385	0	0	35	60	5	0	0
1675	407	0	0	47	60	1	1	0
1675	140	2	1	37	60	0	0	0
1676	142	0	1	48	60	3	1	0
1676	323	2	1	48	60	2	0	0
1676	55	1	0	20	60	1	0	0
1676	364	1	1	33	60	3	1	0
1676	237	2	0	47	60	3	0	0
1676	401	0	1	34	60	3	0	0
1676	26	1	1	32	60	5	0	0
1676	251	1	1	46	60	4	1	0
1677	263	0	1	43	60	5	0	0
1677	193	1	1	50	60	2	0	0
1677	344	2	0	26	60	3	0	0
1677	1	2	1	43	60	2	0	0
1677	369	1	1	46	60	5	0	0
1677	134	0	1	33	60	0	0	0
1677	226	0	1	24	60	0	0	0
1677	66	1	1	32	60	5	0	0
1678	57	2	1	39	60	3	0	0
1678	463	0	0	49	60	1	1	0
1678	208	2	0	22	60	1	1	0
1678	167	0	0	29	60	4	1	0
1678	228	1	0	34	60	5	0	0
1678	367	0	1	21	60	3	0	0
1678	389	1	0	46	60	3	0	0
1678	15	2	1	40	60	2	0	0
1679	239	2	1	46	60	4	1	0
1679	418	1	0	50	60	4	0	0
1679	64	0	1	35	60	5	0	0
1679	335	2	1	36	60	2	0	0
1679	281	0	1	47	60	1	0	0
1679	283	1	1	38	60	1	0	0
1679	328	0	1	30	60	3	0	0
1679	264	1	0	24	60	1	0	0
1680	142	2	1	23	60	1	0	0
1680	70	1	1	35	60	2	0	0
1680	417	2	0	50	60	3	0	0
1680	384	0	1	37	60	1	1	0
1680	289	2	1	28	60	4	0	0
1680	335	2	0	37	60	2	0	0
1680	128	1	0	30	60	4	0	0
1680	443	2	1	45	60	4	0	0
1681	450	1	1	50	60	5	0	0
1681	186	2	0	42	60	2	0	0
1681	159	0	1	29	60	5	1	0
1681	79	2	1	48	60	5	0	0
1681	139	0	1	38	60	1	1	0
1681	428	1	0	46	60	1	1	0
1681	257	0	0	34	60	4	0	0
1681	53	1	0	33	60	3	0	0
1682	305	0	1	49	60	3	1	0
1682	32	1	0	46	60	5	0	0
1682	291	1	0	26	60	1	1	0
1682	472	1	1	39	60	3	0	0
1682	83	2	0	21	60	3	0	0
1682	137	2	0	46	60	3	0	0
1682	91	0	0	38	60	5	0	0
1682	183	1	1	26	60	0	0	0
1683	329	1	0	30	60	0	1	0
1683	316	2	0	44	60	3	0	0
1683	121	1	0	41	60	1	0	0
1683	50	0	0	25	60	1	0	0
1683	299	1	0	49	60	0	1	0
1683	370	0	1	38	60	3	0	0
1683	145	0	0	25	60	3	0	0
1683	310	0	1	40	60	5	0	0
1684	82	1	1	41	60	1	0	0
1684	84	2	1	45	60	4	0	0
1684	161	1	0	48	60	4	0	0
1684	450	2	1	35	60	3	0	0
1684	389	0	0	34	60	5	0	0
1684	97	0	1	40	60	4	0	0
1684	10	0	1	24	60	0	0	0
1684	174	2	1	41	60	4	0	0
1685	411	0	1	45	60	2	0	0
1685	69	1	1	40	60	5	0	0
1685	145	1	0	25	60	2	0	0
1685	303	1	1	34	60	5	0	0
1685	367	2	1	44	60	3	0	0
1685	75	1	1	21	60	3	0	0
1685	62	2	1	34	60	5	1	0
1685	475	1	1	34	60	2	0	0
1686	456	1	0	49	60	4	0	0
1686	110	1	1	44	60	4	0	0
1686	204	1	1	46	60	5	1	0
1686	331	2	0	43	60	2	0	0
1686	377	0	1	35	60	2	0	0
1686	237	2	1	34	60	3	0	0
1686	447	1	0	20	60	5	1	0
1686	116	0	0	22	60	3	0	0
1687	284	1	1	38	60	1	0	0
1687	327	1	0	30	60	1	0	0
1687	490	1	0	32	60	1	0	0
1687	438	1	1	45	60	3	0	0
1687	471	1	0	43	60	3	0	0
1687	375	2	0	49	60	0	1	0
1687	472	0	0	24	60	0	0	0
1687	31	2	1	33	60	2	0	0
1688	456	0	1	31	60	5	1	0
1688	23	2	0	25	60	5	0	0
1688	84	2	0	49	60	4	1	0
1688	376	2	1	40	60	3	0	0
1688	343	0	0	41	60	3	0	0
1688	2	2	1	22	60	5	0	0
1688	129	2	1	42	60	1	0	0
1688	244	1	0	46	60	4	0	0
1689	54	0	0	50	60	3	1	0
1689	379	0	1	26	60	1	0	0
1689	112	2	1	29	60	1	0	0
1689	275	2	0	32	60	4	1	0
1689	297	2	0	39	60	2	0	0
1689	459	0	1	41	60	5	1	0
1689	341	1	1	42	60	3	1	0
1689	79	1	0	31	60	4	0	0
1690	45	0	0	26	60	3	1	0
1690	43	2	0	26	60	5	0	0
1690	132	1	1	31	60	4	1	0
1690	227	0	1	43	60	1	0	0
1690	213	1	1	43	60	1	0	0
1690	160	0	1	23	60	2	0	0
1690	440	2	0	33	60	1	0	0
1690	263	2	1	20	60	2	1	0
1691	385	0	1	38	60	0	0	0
1691	43	0	0	39	60	0	0	0
1691	428	2	1	28	60	0	1	0
1691	308	2	0	28	60	2	0	0
1691	6	1	1	30	60	1	0	0
1691	76	0	1	35	60	1	1	0
1691	85	2	0	35	60	5	0	0
1691	197	0	0	26	60	4	0	0
1692	197	2	1	31	60	0	0	0
1692	116	2	1	50	60	1	0	0
1692	370	1	1	21	60	3	0	0
1692	196	2	0	24	60	0	1	0
1692	157	1	0	35	60	4	0	0
1692	263	1	1	49	60	0	0	0
1692	236	2	1	34	60	4	1	0
1692	195	1	0	32	60	1	0	0
1693	188	1	1	27	60	2	0	0
1693	348	1	1	48	60	2	0	0
1693	239	0	0	31	60	5	1	0
1693	123	1	0	34	60	2	0	0
1693	199	1	0	41	60	1	0	0
1693	177	0	0	32	60	5	0	0
1693	72	1	0	26	60	0	1	0
1693	90	1	1	32	60	2	0	0
1694	226	0	1	30	60	4	1	0
1694	258	2	0	43	60	2	0	0
1694	59	2	0	35	60	4	0	0
1694	32	2	0	32	60	2	0	0
1694	224	1	0	41	60	2	0	0
1694	314	1	0	36	60	3	1	0
1694	50	1	0	34	60	4	0	0
1694	6	1	0	32	60	1	0	0
1695	380	2	1	50	60	2	0	0
1695	86	2	0	27	60	3	0	0
1695	109	0	1	27	60	1	1	0
1695	253	0	0	36	60	3	0	0
1695	134	1	1	29	60	2	0	0
1695	186	1	0	22	60	5	1	0
1695	283	1	1	31	60	0	0	0
1695	279	1	1	25	60	4	0	0
1696	202	1	1	41	60	3	0	0
1696	317	2	1	45	60	3	0	0
1696	120	1	0	24	60	5	0	0
1696	271	1	1	38	60	0	0	0
1696	38	1	1	24	60	5	0	0
1696	197	1	1	41	60	4	0	0
1696	228	0	0	34	60	4	0	0
1696	386	2	0	32	60	1	0	0
1697	391	0	0	39	60	5	0	0
1697	421	1	1	39	60	2	0	0
1697	300	1	0	43	60	1	0	0
1697	388	1	0	29	60	5	1	0
1697	41	1	0	39	60	2	0	0
1697	308	1	0	46	60	1	1	0
1697	276	2	0	40	60	0	0	0
1697	331	0	1	39	60	1	1	0
1698	479	0	1	47	60	1	0	0
1698	283	1	0	48	60	3	0	0
1698	252	2	0	37	60	2	0	0
1698	70	2	1	26	60	4	0	0
1698	411	1	1	21	60	1	1	0
1698	230	2	1	23	60	0	1	0
1698	9	2	0	23	60	4	0	0
1698	57	0	1	31	60	4	1	0
1699	500	0	0	28	60	0	0	0
1699	380	1	0	44	60	5	0	0
1699	192	2	1	25	60	2	0	0
1699	69	2	1	29	60	4	1	0
1699	416	0	1	47	60	4	0	0
1699	341	1	1	33	60	5	1	0
1699	9	0	1	20	60	2	1	0
1699	440	0	1	31	60	5	1	0
1700	184	0	1	20	60	4	0	0
1700	435	1	1	27	60	0	0	0
1700	478	0	1	26	60	2	0	0
1700	1	2	1	31	60	0	1	0
1700	224	0	1	37	60	2	0	0
1700	275	2	0	22	60	0	0	0
1700	182	0	1	50	60	1	1	0
1700	321	1	0	29	60	4	0	0
1701	263	0	1	23	60	1	0	0
1701	476	1	1	45	60	3	0	0
1701	57	1	1	31	60	5	0	0
1701	5	1	1	27	60	1	0	0
1701	290	1	0	40	60	3	1	0
1701	347	1	0	35	60	2	1	0
1701	375	2	1	24	60	4	0	0
1701	21	0	0	20	60	0	0	0
1702	172	0	0	48	60	4	0	0
1702	126	0	0	33	60	4	0	0
1702	305	1	1	48	60	4	0	0
1702	18	1	0	40	60	4	0	0
1702	133	1	0	29	60	1	0	0
1702	231	1	1	32	60	1	0	0
1702	9	1	0	23	60	5	0	0
1702	326	1	0	24	60	0	0	0
1703	52	2	0	26	60	2	0	0
1703	156	2	1	48	60	1	0	0
1703	464	1	1	31	60	4	0	0
1703	488	2	0	20	60	3	0	0
1703	21	2	1	23	60	1	1	0
1703	302	0	1	42	60	3	0	0
1703	114	0	1	32	60	2	1	0
1703	55	1	1	30	60	5	1	0
1704	227	2	1	21	60	4	1	0
1704	490	2	1	31	60	4	0	0
1704	194	2	1	38	60	0	1	0
1704	122	2	1	42	60	2	0	0
1704	434	1	1	33	60	1	1	0
1704	393	2	1	37	60	1	0	0
1704	426	1	1	46	60	2	0	0
1704	254	0	1	32	60	4	1	0
1705	287	2	0	40	60	1	1	0
1705	275	1	0	37	60	1	0	0
1705	12	0	0	29	60	2	1	0
1705	3	1	1	28	60	3	0	0
1705	339	0	0	28	60	3	0	0
1705	205	1	0	34	60	2	0	0
1705	256	0	1	40	60	0	0	0
1705	397	2	1	22	60	1	0	0
1706	90	2	1	40	60	0	0	0
1706	467	0	0	25	60	3	0	0
1706	241	0	1	26	60	3	1	0
1706	321	0	1	33	60	3	0	0
1706	346	1	0	40	60	4	0	0
1706	143	1	1	24	60	4	1	0
1706	131	2	0	46	60	1	0	0
1706	261	1	0	21	60	1	0	0
1707	2	1	0	32	60	4	0	0
1707	431	2	1	21	60	2	0	0
1707	398	0	0	40	60	3	0	0
1707	250	2	0	39	60	0	0	0
1707	354	1	1	41	60	2	0	0
1707	75	2	1	23	60	5	0	0
1707	238	1	1	50	60	2	0	0
1707	19	1	0	40	60	0	0	0
1708	183	1	0	26	60	2	0	0
1708	99	0	1	44	60	4	0	0
1708	395	0	1	44	60	3	0	0
1708	6	2	1	32	60	2	0	0
1708	106	2	1	33	60	4	0	0
1708	195	1	0	39	60	5	0	0
1708	103	1	0	48	60	0	0	0
1708	328	0	1	21	60	3	1	0
1709	47	1	1	23	60	1	0	0
1709	139	0	1	47	60	4	0	0
1709	495	2	1	41	60	4	0	0
1709	228	0	1	36	60	5	0	0
1709	153	0	0	50	60	1	1	0
1709	296	1	1	24	60	0	0	0
1709	401	2	0	37	60	5	0	0
1709	28	1	0	35	60	5	0	0
1710	157	2	1	49	60	5	0	0
1710	454	0	0	42	60	1	0	0
1710	65	1	1	50	60	5	0	0
1710	497	1	1	26	60	5	1	0
1710	125	0	1	24	60	4	0	0
1710	228	0	0	43	60	5	0	0
1710	343	1	1	23	60	3	0	0
1710	116	0	0	50	60	0	0	0
1711	93	2	0	30	60	0	0	0
1711	371	0	1	34	60	4	0	0
1711	147	1	0	47	60	3	1	0
1711	372	1	1	26	60	4	1	0
1711	218	1	1	31	60	5	0	0
1711	82	0	1	47	60	4	0	0
1711	53	2	1	41	60	0	0	0
1711	381	0	0	35	60	5	0	0
1712	357	0	0	41	60	1	1	0
1712	282	1	0	25	60	0	0	0
1712	274	2	0	39	60	1	1	0
1712	441	1	1	33	60	0	0	0
1712	455	2	0	29	60	4	0	0
1712	89	2	0	39	60	0	0	0
1712	235	0	1	35	60	4	0	0
1712	99	0	1	28	60	5	0	0
1713	396	1	0	20	60	3	0	0
1713	179	1	1	20	60	3	0	0
1713	338	2	1	45	60	1	0	0
1713	242	0	1	34	60	0	0	0
1713	155	0	0	24	60	3	0	0
1713	318	1	0	45	60	1	0	0
1713	112	2	1	39	60	1	1	0
1713	271	1	0	42	60	0	0	0
1714	293	1	1	25	60	1	0	0
1714	259	2	0	46	60	0	0	0
1714	366	1	1	37	60	0	0	0
1714	255	2	0	31	60	3	0	0
1714	364	2	0	50	60	3	0	0
1714	413	0	0	35	60	4	0	0
1714	73	2	1	45	60	1	0	0
1714	228	0	0	29	60	4	0	0
1715	464	0	0	46	60	3	0	0
1715	370	1	0	23	60	0	0	0
1715	473	1	0	20	60	1	1	0
1715	320	0	0	31	60	3	0	0
1715	155	2	0	23	60	3	0	0
1715	420	1	1	46	60	5	0	0
1715	468	1	0	29	60	1	0	0
1715	259	2	1	32	60	2	0	0
1716	335	0	0	38	60	4	0	0
1716	359	2	1	29	60	3	0	0
1716	49	0	1	22	60	2	0	0
1716	78	0	1	25	60	4	0	0
1716	357	2	0	24	60	1	1	0
1716	306	2	0	23	60	2	1	0
1716	409	0	1	32	60	1	0	0
1716	253	2	0	32	60	1	1	0
1717	406	2	1	25	60	1	0	0
1717	217	1	1	30	60	3	0	0
1717	262	0	1	31	60	2	1	0
1717	347	2	0	27	60	1	0	0
1717	312	1	0	50	60	3	0	0
1717	489	0	0	34	60	1	1	0
1717	155	2	0	20	60	0	0	0
1717	484	2	0	28	60	0	0	0
1718	209	0	1	47	60	3	0	0
1718	463	2	1	32	60	4	0	0
1718	264	2	1	41	60	4	0	0
1718	70	0	0	26	60	0	0	0
1718	48	2	0	35	60	3	1	0
1718	205	2	1	34	60	1	0	0
1718	182	0	0	24	60	3	0	0
1718	490	1	0	48	60	0	0	0
1719	100	2	0	25	60	0	1	0
1719	468	0	1	43	60	0	0	0
1719	189	2	0	39	60	5	0	0
1719	75	1	1	39	60	3	1	0
1719	30	1	0	34	60	1	1	0
1719	4	0	1	26	60	4	0	0
1719	379	0	0	48	60	3	0	0
1719	128	0	1	44	60	2	0	0
1720	186	0	0	39	60	3	0	0
1720	365	0	1	20	60	0	0	0
1720	373	0	0	37	60	2	0	0
1720	46	2	1	22	60	4	0	0
1720	183	2	0	47	60	4	0	0
1720	176	1	0	29	60	1	1	0
1720	243	1	0	29	60	5	1	0
1720	60	2	0	22	60	2	0	0
1721	9	2	1	27	60	3	0	0
1721	26	0	0	41	60	2	0	0
1721	428	0	0	30	60	3	0	0
1721	86	0	0	42	60	0	0	0
1721	89	2	1	50	60	4	0	0
1721	372	2	0	49	60	5	0	0
1721	155	0	0	40	60	3	0	0
1721	104	1	1	30	60	3	0	0
1722	235	0	1	31	60	4	1	0
1722	355	0	1	48	60	5	0	0
1722	220	2	1	27	60	0	0	0
1722	213	1	0	37	60	5	0	0
1722	91	1	0	29	60	4	0	0
1722	56	2	0	50	60	0	1	0
1722	165	1	1	24	60	0	1	0
1722	348	0	0	36	60	2	0	0
1723	275	2	0	37	60	2	0	0
1723	300	2	1	33	60	1	0	0
1723	242	2	0	22	60	1	0	0
1723	420	0	0	35	60	5	0	0
1723	393	2	0	25	60	5	1	0
1723	89	1	0	24	60	4	0	0
1723	30	1	1	31	60	0	0	0
1723	254	0	1	20	60	3	0	0
1724	271	1	0	32	60	4	0	0
1724	90	2	1	41	60	1	0	0
1724	179	2	0	44	60	5	1	0
1724	114	1	1	24	60	1	0	0
1724	483	0	1	41	60	3	0	0
1724	139	0	0	42	60	4	1	0
1724	398	1	1	43	60	5	0	0
1724	349	2	1	45	60	1	0	0
1725	316	2	1	31	60	5	0	0
1725	2	2	0	36	60	4	0	0
1725	82	2	0	50	60	5	0	0
1725	169	0	1	22	60	0	1	0
1725	197	0	0	28	60	2	0	0
1725	416	2	0	39	60	5	0	0
1725	234	1	1	21	60	5	0	0
1725	370	0	0	49	60	3	0	0
1726	20	1	0	41	60	4	1	0
1726	298	1	1	21	60	2	0	0
1726	362	0	0	29	60	2	0	0
1726	19	1	1	38	60	2	0	0
1726	50	2	1	31	60	1	1	0
1726	227	0	1	31	60	5	0	0
1726	496	0	1	28	60	1	0	0
1726	183	2	1	37	60	3	0	0
1727	91	1	1	30	60	5	0	0
1727	227	0	0	31	60	5	0	0
1727	341	1	1	22	60	2	0	0
1727	244	2	0	29	60	0	1	0
1727	375	1	1	38	60	1	0	0
1727	377	1	0	29	60	2	0	0
1727	62	2	1	31	60	4	0	0
1727	353	2	0	43	60	4	0	0
1728	334	2	1	22	60	4	0	0
1728	495	2	0	49	60	3	0	0
1728	145	1	1	47	60	4	0	0
1728	413	2	0	31	60	2	1	0
1728	186	0	0	26	60	5	0	0
1728	415	2	1	32	60	4	0	0
1728	300	2	1	47	60	4	0	0
1728	283	0	0	48	60	2	1	0
1729	181	1	1	20	60	4	1	0
1729	135	2	1	49	60	3	0	0
1729	452	2	1	43	60	4	1	0
1729	2	1	0	20	60	2	0	0
1729	430	1	0	20	60	5	0	0
1729	426	0	0	33	60	0	1	0
1729	103	0	0	23	60	1	1	0
1729	233	2	0	44	60	5	0	0
1730	496	1	0	38	60	1	1	0
1730	166	2	0	34	60	0	1	0
1730	55	2	0	49	60	4	0	0
1730	127	1	1	42	60	5	0	0
1730	104	1	0	20	60	1	1	0
1730	301	1	1	30	60	2	0	0
1730	147	2	0	37	60	5	0	0
1730	298	0	0	26	60	5	1	0
1731	388	0	1	29	60	0	1	0
1731	397	2	0	48	60	1	1	0
1731	125	1	1	23	60	0	0	0
1731	430	2	0	28	60	1	0	0
1731	211	2	1	38	60	3	0	0
1731	260	2	0	24	60	5	0	0
1731	128	1	0	47	60	2	0	0
1731	363	0	1	31	60	0	1	0
1732	50	1	1	37	60	1	0	0
1732	388	0	1	42	60	1	0	0
1732	26	0	0	39	60	0	0	0
1732	308	2	0	26	60	0	0	0
1732	144	2	1	26	60	4	0	0
1732	470	2	0	28	60	3	0	0
1732	403	2	1	25	60	3	0	0
1732	324	0	0	30	60	3	0	0
1733	286	0	0	32	60	2	0	0
1733	476	1	0	40	60	4	0	0
1733	358	1	0	27	60	5	0	0
1733	145	0	1	25	60	1	1	0
1733	293	2	1	24	60	5	0	0
1733	429	2	0	25	60	1	0	0
1733	452	2	1	33	60	4	0	0
1733	91	0	0	36	60	0	0	0
1734	461	1	0	30	60	4	0	0
1734	78	2	1	45	60	5	0	0
1734	203	1	0	38	60	2	0	0
1734	126	2	0	48	60	1	0	0
1734	98	0	0	35	60	4	0	0
1734	226	1	1	32	60	3	1	0
1734	45	2	1	38	60	1	0	0
1734	94	0	0	47	60	4	0	0
1735	296	0	0	21	60	5	0	0
1735	474	2	1	38	60	0	0	0
1735	232	2	0	47	60	0	0	0
1735	216	1	1	34	60	4	0	0
1735	477	1	0	35	60	3	0	0
1735	392	1	0	39	60	4	0	0
1735	264	2	1	25	60	0	0	0
1735	390	2	0	36	60	1	1	0
1736	121	0	0	49	60	0	0	0
1736	43	2	1	48	60	2	0	0
1736	414	1	1	44	60	5	1	0
1736	308	1	0	50	60	2	0	0
1736	240	1	0	45	60	5	1	0
1736	436	2	1	42	60	3	0	0
1736	83	0	1	49	60	3	0	0
1736	422	1	0	36	60	5	0	0
1737	208	2	1	42	60	0	0	0
1737	234	1	1	46	60	4	0	0
1737	393	1	1	22	60	1	0	0
1737	163	2	0	40	60	2	0	0
1737	345	2	0	42	60	1	0	0
1737	200	1	1	39	60	5	0	0
1737	397	1	1	21	60	2	1	0
1737	298	2	0	42	60	1	0	0
1738	267	0	1	49	60	1	0	0
1738	492	1	1	35	60	2	1	0
1738	337	2	1	49	60	0	1	0
1738	499	2	1	38	60	0	0	0
1738	437	2	0	23	60	5	0	0
1738	57	0	1	31	60	1	1	0
1738	287	0	0	23	60	5	0	0
1738	450	0	0	44	60	0	0	0
1739	424	2	0	39	60	1	1	0
1739	160	1	0	25	60	4	0	0
1739	157	0	0	37	60	5	0	0
1739	175	0	0	33	60	2	0	0
1739	478	1	0	25	60	4	1	0
1739	17	2	1	40	60	0	0	0
1739	486	1	1	35	60	5	0	0
1739	49	0	1	29	60	2	1	0
1740	314	0	1	49	60	5	0	0
1740	346	0	1	25	60	3	1	0
1740	496	0	1	28	60	3	0	0
1740	29	2	1	46	60	3	1	0
1740	471	1	1	36	60	4	0	0
1740	490	2	0	41	60	4	1	0
1740	343	1	0	26	60	4	1	0
1740	90	2	0	22	60	3	1	0
1741	167	1	0	32	60	4	0	0
1741	242	2	0	23	60	0	0	0
1741	304	2	1	28	60	1	1	0
1741	70	1	1	24	60	3	0	0
1741	6	0	0	22	60	1	0	0
1741	230	2	1	26	60	2	0	0
1741	170	0	1	46	60	4	0	0
1741	140	1	1	20	60	3	1	0
1742	255	2	0	49	60	2	0	0
1742	348	0	0	44	60	0	0	0
1742	173	0	0	43	60	5	0	0
1742	466	2	0	32	60	5	1	0
1742	286	1	1	40	60	5	0	0
1742	359	2	1	42	60	5	0	0
1742	192	1	0	49	60	2	0	0
1742	226	0	1	26	60	4	0	0
1743	321	2	1	39	60	0	1	0
1743	379	2	0	39	60	3	1	0
1743	480	1	1	44	60	3	0	0
1743	52	0	0	22	60	3	0	0
1743	365	0	0	42	60	1	0	0
1743	38	2	0	45	60	2	0	0
1743	133	2	0	22	60	3	0	0
1743	30	2	0	25	60	5	0	0
1744	410	2	1	46	60	0	1	0
1744	180	1	1	34	60	1	1	0
1744	480	0	0	39	60	4	0	0
1744	476	2	0	48	60	5	1	0
1744	88	0	0	30	60	0	0	0
1744	126	2	1	27	60	5	0	0
1744	295	1	0	41	60	3	1	0
1744	234	0	1	47	60	2	1	0
1745	101	2	0	45	60	3	0	0
1745	444	2	0	44	60	3	0	0
1745	108	1	1	31	60	0	0	0
1745	180	0	0	45	60	1	0	0
1745	56	1	1	20	60	1	0	0
1745	44	0	1	45	60	2	0	0
1745	4	2	1	50	60	3	0	0
1745	266	0	1	36	60	4	0	0
1746	31	0	0	39	60	3	1	0
1746	439	2	0	25	60	5	0	0
1746	254	0	1	49	60	1	0	0
1746	191	1	1	34	60	3	1	0
1746	355	1	0	38	60	0	0	0
1746	143	0	0	49	60	2	0	0
1746	475	2	0	47	60	4	0	0
1746	18	2	1	27	60	4	0	0
1747	371	2	1	23	60	1	1	0
1747	188	1	0	28	60	1	0	0
1747	421	1	1	50	60	1	0	0
1747	147	0	0	27	60	2	0	0
1747	396	2	1	39	60	1	0	0
1747	303	0	1	24	60	3	0	0
1747	407	2	1	48	60	5	0	0
1747	324	0	0	37	60	2	0	0
1748	439	1	0	27	60	1	0	0
1748	44	1	0	39	60	4	1	0
1748	361	0	1	49	60	5	0	0
1748	214	0	0	44	60	0	0	0
1748	213	1	1	47	60	4	0	0
1748	11	2	1	21	60	1	1	0
1748	278	1	0	33	60	0	0	0
1748	73	2	0	33	60	1	1	0
1749	85	0	0	35	60	5	0	0
1749	1	2	1	22	60	2	0	0
1749	93	2	1	20	60	1	1	0
1749	14	0	1	46	60	5	0	0
1749	191	1	0	34	60	2	1	0
1749	254	1	0	47	60	1	0	0
1749	68	0	1	47	60	4	0	0
1749	107	1	0	43	60	4	0	0
1750	182	1	0	44	60	2	0	0
1750	420	2	1	21	60	1	0	0
1750	373	2	0	28	60	5	0	0
1750	241	2	1	33	60	3	0	0
1750	288	2	0	31	60	1	0	0
1750	177	1	0	46	60	0	0	0
1750	299	0	0	39	60	5	0	0
1750	95	0	1	25	60	4	0	0
1751	270	1	1	28	60	0	1	0
1751	392	1	1	25	60	4	0	0
1751	92	1	0	27	60	3	1	0
1751	105	1	0	39	60	5	0	0
1751	378	2	1	48	60	5	0	0
1751	20	0	0	45	60	5	0	0
1751	476	2	1	46	60	3	0	0
1751	439	1	1	27	60	2	1	0
1752	197	1	0	49	60	4	0	0
1752	433	1	0	35	60	4	1	0
1752	29	0	1	39	60	0	1	0
1752	42	1	0	22	60	3	1	0
1752	259	0	1	29	60	4	0	0
1752	231	1	0	45	60	0	0	0
1752	3	0	1	30	60	1	0	0
1752	327	1	1	43	60	4	0	0
1753	51	1	1	47	60	4	1	0
1753	50	0	0	33	60	1	1	0
1753	152	0	1	36	60	4	0	0
1753	372	0	0	21	60	4	0	0
1753	186	0	0	23	60	3	0	0
1753	16	1	0	39	60	3	0	0
1753	238	0	1	43	60	2	0	0
1753	145	2	1	29	60	5	0	0
1754	294	1	0	39	60	2	0	0
1754	141	0	0	42	60	1	0	0
1754	27	0	1	22	60	0	0	0
1754	489	0	0	44	60	3	1	0
1754	380	1	0	34	60	3	0	0
1754	238	2	0	30	60	5	0	0
1754	146	0	1	25	60	5	0	0
1754	83	2	1	30	60	3	0	0
1755	465	2	1	49	60	5	0	0
1755	436	0	1	43	60	2	0	0
1755	22	0	0	33	60	2	0	0
1755	345	1	0	20	60	4	0	0
1755	28	1	0	20	60	0	0	0
1755	333	1	0	36	60	5	0	0
1755	62	2	0	25	60	2	1	0
1755	301	1	1	37	60	5	0	0
1756	145	0	1	34	60	0	0	0
1756	462	2	0	38	60	4	0	0
1756	86	1	0	30	60	0	0	0
1756	379	2	1	43	60	3	0	0
1756	198	0	0	36	60	0	0	0
1756	344	1	0	21	60	5	0	0
1756	209	1	1	27	60	4	1	0
1756	4	1	1	48	60	0	0	0
1757	111	0	1	31	60	5	0	0
1757	263	2	0	41	60	4	0	0
1757	126	0	0	20	60	0	0	0
1757	279	1	1	36	60	3	0	0
1757	74	1	0	41	60	3	0	0
1757	24	0	0	44	60	0	0	0
1757	332	1	1	47	60	1	0	0
1757	137	0	0	20	60	2	0	0
1758	4	1	0	29	60	1	0	0
1758	108	1	0	37	60	1	1	0
1758	126	1	0	44	60	3	0	0
1758	244	0	0	45	60	3	0	0
1758	263	1	0	49	60	4	0	0
1758	205	2	1	46	60	1	0	0
1758	316	1	1	44	60	4	1	0
1758	37	0	1	43	60	5	0	0
1759	497	0	1	46	60	5	1	0
1759	103	0	0	37	60	2	0	0
1759	438	1	0	39	60	2	0	0
1759	412	1	0	48	60	0	0	0
1759	376	1	1	34	60	1	1	0
1759	500	0	1	23	60	2	0	0
1759	402	1	1	30	60	0	0	0
1759	188	2	0	24	60	5	0	0
1760	268	0	1	41	60	5	0	0
1760	316	1	1	33	60	1	1	0
1760	147	1	1	35	60	0	0	0
1760	243	2	0	26	60	5	1	0
1760	183	1	0	26	60	4	0	0
1760	220	0	0	34	60	1	0	0
1760	305	1	1	44	60	5	1	0
1760	205	1	1	34	60	5	0	0
1761	55	2	0	50	60	1	0	0
1761	74	0	1	25	60	5	0	0
1761	7	0	0	37	60	5	0	0
1761	390	2	0	40	60	0	0	0
1761	287	2	1	45	60	3	0	0
1761	324	2	1	29	60	1	0	0
1761	254	2	1	39	60	5	0	0
1761	145	0	1	45	60	1	0	0
1762	441	1	0	45	60	3	1	0
1762	32	1	1	40	60	5	0	0
1762	491	2	0	27	60	4	0	0
1762	17	1	1	44	60	2	1	0
1762	326	0	1	50	60	1	1	0
1762	345	0	1	43	60	3	0	0
1762	188	1	1	23	60	5	0	0
1762	270	0	0	20	60	5	1	0
1763	342	2	1	32	60	4	0	0
1763	402	0	1	44	60	3	0	0
1763	113	2	1	39	60	0	1	0
1763	455	1	0	22	60	2	1	0
1763	232	2	0	22	60	5	0	0
1763	388	0	0	31	60	0	0	0
1763	50	0	0	45	60	2	0	0
1763	377	1	1	24	60	1	0	0
1764	189	2	0	34	60	0	0	0
1764	224	1	1	48	60	1	0	0
1764	8	2	1	22	60	1	0	0
1764	115	0	1	27	60	2	0	0
1764	324	1	1	43	60	0	1	0
1764	162	2	1	35	60	5	0	0
1764	292	2	0	34	60	3	0	0
1764	339	2	0	27	60	2	0	0
1765	419	2	0	21	60	4	0	0
1765	493	0	0	22	60	5	1	0
1765	209	0	0	44	60	2	0	0
1765	253	1	0	38	60	2	0	0
1765	447	0	0	20	60	5	0	0
1765	422	0	1	45	60	0	0	0
1765	54	2	0	24	60	1	0	0
1765	18	0	0	28	60	0	0	0
1766	401	1	0	42	60	3	0	0
1766	88	1	0	33	60	3	0	0
1766	133	0	0	44	60	0	0	0
1766	468	2	0	46	60	5	1	0
1766	324	2	1	23	60	2	0	0
1766	256	0	0	24	60	3	0	0
1766	23	1	0	21	60	1	0	0
1766	414	2	0	23	60	2	0	0
1767	98	2	1	34	60	3	0	0
1767	217	1	1	21	60	0	1	0
1767	339	0	1	47	60	0	0	0
1767	269	0	1	21	60	3	0	0
1767	123	2	0	38	60	0	1	0
1767	110	1	0	42	60	1	0	0
1767	360	0	1	28	60	3	1	0
1767	406	0	0	24	60	1	0	0
1768	336	0	1	40	60	2	1	0
1768	420	0	1	33	60	5	1	0
1768	104	2	0	47	60	1	0	0
1768	117	2	1	20	60	3	0	0
1768	366	1	0	45	60	0	0	0
1768	73	0	0	47	60	2	1	0
1768	258	0	1	40	60	0	0	0
1768	320	1	1	22	60	3	0	0
1769	336	2	0	46	60	1	0	0
1769	414	1	0	34	60	1	0	0
1769	491	2	0	26	60	1	0	0
1769	271	2	0	34	60	4	0	0
1769	362	1	0	30	60	4	0	0
1769	413	2	1	30	60	4	0	0
1769	73	1	1	37	60	2	0	0
1769	457	1	1	27	60	5	0	0
1770	79	0	0	34	60	5	0	0
1770	62	0	1	47	60	4	1	0
1770	148	1	1	42	60	3	0	0
1770	278	1	1	28	60	5	0	0
1770	204	0	1	30	60	3	0	0
1770	199	2	1	42	60	2	0	0
1770	207	0	1	31	60	4	0	0
1770	352	0	0	23	60	0	1	0
1771	30	2	0	40	60	3	0	0
1771	82	2	0	42	60	0	0	0
1771	141	1	0	42	60	1	0	0
1771	330	0	1	40	60	1	0	0
1771	271	2	0	33	60	0	0	0
1771	24	1	1	31	60	3	0	0
1771	329	1	1	27	60	4	1	0
1771	50	0	0	40	60	5	1	0
1772	391	2	1	24	60	0	0	0
1772	54	1	0	28	60	1	0	0
1772	8	2	0	23	60	3	0	0
1772	73	2	1	33	60	1	1	0
1772	111	0	0	42	60	1	1	0
1772	303	2	1	38	60	3	0	0
1772	466	0	1	23	60	2	0	0
1772	150	0	0	46	60	0	0	0
1773	441	1	1	28	60	4	0	0
1773	478	0	1	20	60	5	0	0
1773	389	0	0	45	60	5	0	0
1773	421	1	0	41	60	0	0	0
1773	281	2	0	21	60	0	0	0
1773	74	0	1	31	60	3	0	0
1773	175	0	0	40	60	0	0	0
1773	48	1	1	49	60	4	0	0
1774	432	2	1	31	60	5	0	0
1774	476	2	0	29	60	2	0	0
1774	104	1	1	21	60	3	0	0
1774	238	2	0	41	60	5	0	0
1774	240	2	0	20	60	3	1	0
1774	437	2	0	30	60	3	0	0
1774	278	0	0	34	60	3	1	0
1774	363	0	1	44	60	4	0	0
1775	55	2	1	37	60	0	0	0
1775	463	1	0	47	60	5	1	0
1775	8	1	0	30	60	2	1	0
1775	216	1	1	22	60	1	1	0
1775	17	1	0	20	60	2	0	0
1775	245	0	1	47	60	1	1	0
1775	108	2	1	23	60	5	0	0
1775	231	2	0	47	60	1	0	0
1776	430	2	0	37	60	0	0	0
1776	51	0	0	39	60	1	1	0
1776	217	2	1	49	60	5	0	0
1776	450	0	0	45	60	0	0	0
1776	473	2	1	23	60	4	0	0
1776	128	2	0	26	60	3	0	0
1776	481	1	1	35	60	5	0	0
1776	337	1	0	29	60	2	0	0
1777	444	2	1	47	60	2	0	0
1777	118	1	1	24	60	1	0	0
1777	147	2	1	41	60	5	1	0
1777	141	0	0	42	60	4	0	0
1777	335	0	0	44	60	3	0	0
1777	58	1	0	34	60	4	0	0
1777	367	0	0	46	60	1	1	0
1777	123	2	0	46	60	2	1	0
1778	292	2	0	29	60	3	0	0
1778	334	1	1	35	60	2	1	0
1778	448	0	1	35	60	1	0	0
1778	335	2	0	50	60	3	0	0
1778	331	1	1	44	60	1	0	0
1778	69	1	0	45	60	4	0	0
1778	73	2	1	43	60	2	0	0
1778	76	0	0	49	60	3	1	0
1779	82	0	1	31	60	3	0	0
1779	470	1	0	47	60	1	1	0
1779	136	1	1	46	60	4	1	0
1779	349	0	0	43	60	5	0	0
1779	441	0	0	45	60	2	1	0
1779	143	2	1	28	60	0	0	0
1779	162	2	0	43	60	0	0	0
1779	14	2	1	22	60	1	0	0
1780	252	0	0	40	60	0	0	0
1780	200	1	0	34	60	3	0	0
1780	182	2	1	45	60	5	0	0
1780	277	1	0	45	60	4	0	0
1780	85	1	1	37	60	5	0	0
1780	333	1	1	47	60	1	1	0
1780	335	0	0	36	60	5	0	0
1780	262	2	1	36	60	4	0	0
1781	471	1	1	33	60	3	0	0
1781	337	1	0	38	60	5	1	0
1781	358	0	1	36	60	1	0	0
1781	70	2	0	35	60	3	0	0
1781	141	0	0	40	60	2	0	0
1781	291	1	1	41	60	1	1	0
1781	163	1	1	46	60	0	1	0
1781	190	1	1	23	60	3	0	0
1782	301	0	1	45	60	4	0	0
1782	325	2	1	38	60	1	0	0
1782	250	0	0	46	60	3	0	0
1782	117	2	0	41	60	5	0	0
1782	359	1	1	45	60	5	1	0
1782	200	1	0	46	60	3	0	0
1782	478	2	1	39	60	3	1	0
1782	85	1	1	36	60	0	0	0
1783	186	1	1	39	60	3	1	0
1783	30	1	0	39	60	0	1	0
1783	477	0	0	26	60	5	0	0
1783	366	1	0	39	60	1	0	0
1783	88	2	1	30	60	0	0	0
1783	170	2	0	40	60	4	1	0
1783	371	2	1	43	60	4	0	0
1783	211	0	0	28	60	3	1	0
1784	400	2	1	34	60	3	1	0
1784	437	2	1	27	60	3	0	0
1784	110	0	0	40	60	1	0	0
1784	232	1	0	25	60	2	1	0
1784	380	0	1	27	60	3	0	0
1784	270	1	0	49	60	2	1	0
1784	367	2	1	23	60	2	0	0
1784	258	0	0	35	60	1	0	0
1785	320	2	1	25	60	5	1	0
1785	358	1	1	20	60	5	1	0
1785	6	2	0	42	60	1	0	0
1785	16	2	1	49	60	4	0	0
1785	93	0	1	43	60	3	1	0
1785	116	2	1	50	60	2	0	0
1785	413	0	0	35	60	1	0	0
1785	444	1	0	28	60	5	1	0
1786	98	1	0	46	60	4	0	0
1786	169	0	0	33	60	3	0	0
1786	25	1	1	41	60	3	1	0
1786	363	0	1	47	60	5	0	0
1786	68	0	1	23	60	3	1	0
1786	48	0	0	32	60	0	1	0
1786	177	2	1	39	60	3	0	0
1786	26	2	0	38	60	2	1	0
1787	187	0	0	29	60	1	1	0
1787	75	0	1	43	60	3	0	0
1787	86	0	1	20	60	2	0	0
1787	181	1	1	44	60	4	0	0
1787	372	0	1	37	60	1	0	0
1787	171	0	0	23	60	0	1	0
1787	299	0	0	35	60	1	0	0
1787	177	1	0	28	60	3	1	0
1788	157	0	0	35	60	0	0	0
1788	41	2	1	36	60	2	0	0
1788	370	2	0	32	60	5	1	0
1788	46	2	1	30	60	4	0	0
1788	69	0	1	21	60	1	0	0
1788	225	1	1	35	60	3	0	0
1788	226	2	1	38	60	3	0	0
1788	131	2	0	41	60	3	0	0
1789	6	0	1	34	60	3	0	0
1789	359	0	0	49	60	4	0	0
1789	480	2	0	44	60	2	1	0
1789	243	0	1	45	60	3	1	0
1789	62	2	0	40	60	4	0	0
1789	337	1	0	46	60	5	1	0
1789	440	1	0	33	60	3	1	0
1789	204	0	1	34	60	0	0	0
1790	14	1	0	32	60	2	1	0
1790	460	2	0	24	60	2	0	0
1790	490	2	1	40	60	1	0	0
1790	433	1	0	30	60	2	0	0
1790	64	1	0	50	60	1	0	0
1790	252	1	0	39	60	4	1	0
1790	311	2	0	50	60	0	0	0
1790	478	2	0	36	60	1	0	0
1791	84	1	1	45	60	3	0	0
1791	319	0	1	32	60	0	0	0
1791	495	0	0	21	60	2	0	0
1791	139	1	1	23	60	1	1	0
1791	91	2	0	38	60	5	1	0
1791	271	0	0	37	60	0	0	0
1791	23	0	0	41	60	2	1	0
1791	62	2	1	25	60	4	1	0
1792	175	0	1	49	60	3	1	0
1792	291	0	1	31	60	3	1	0
1792	208	1	1	24	60	4	0	0
1792	53	0	0	25	60	0	1	0
1792	473	1	1	22	60	0	0	0
1792	490	1	0	25	60	4	0	0
1792	455	1	1	41	60	2	0	0
1792	301	1	0	21	60	4	0	0
1793	217	2	1	29	60	2	1	0
1793	347	1	0	37	60	3	1	0
1793	487	1	1	36	60	4	0	0
1793	341	2	1	31	60	5	0	0
1793	99	1	0	34	60	1	0	0
1793	204	1	0	40	60	3	0	0
1793	406	0	1	48	60	2	0	0
1793	333	1	0	49	60	5	0	0
1794	11	2	0	21	60	0	0	0
1794	232	0	0	49	60	0	0	0
1794	196	1	0	49	60	4	0	0
1794	240	0	0	30	60	4	1	0
1794	218	2	0	41	60	1	0	0
1794	249	2	0	35	60	4	1	0
1794	449	0	1	26	60	1	0	0
1794	79	2	0	39	60	5	1	0
1795	274	0	0	35	60	4	0	0
1795	271	1	1	20	60	5	0	0
1795	275	1	0	50	60	4	1	0
1795	486	2	0	27	60	2	0	0
1795	487	0	0	22	60	2	0	0
1795	272	2	0	43	60	1	1	0
1795	157	1	0	50	60	5	1	0
1795	68	1	0	41	60	5	0	0
1796	342	1	0	29	60	3	1	0
1796	313	1	0	49	60	4	0	0
1796	220	1	0	26	60	4	0	0
1796	291	2	0	21	60	3	0	0
1796	485	2	1	36	60	0	1	0
1796	380	0	0	21	60	2	1	0
1796	438	2	0	23	60	4	0	0
1796	156	2	1	23	60	1	0	0
1797	107	0	0	43	60	1	1	0
1797	249	2	0	42	60	3	0	0
1797	57	0	1	27	60	2	0	0
1797	6	1	1	37	60	0	0	0
1797	222	1	0	47	60	4	0	0
1797	166	2	0	29	60	5	0	0
1797	483	2	0	33	60	2	1	0
1797	241	0	1	32	60	4	1	0
1798	350	0	1	42	60	5	0	0
1798	301	2	0	48	60	3	0	0
1798	82	1	1	26	60	1	0	0
1798	457	0	1	34	60	3	0	0
1798	451	2	0	30	60	1	0	0
1798	160	2	1	29	60	4	0	0
1798	14	0	0	29	60	5	0	0
1798	101	0	1	22	60	2	0	0
1799	21	1	0	34	60	4	0	0
1799	305	2	1	27	60	0	0	0
1799	189	1	0	34	60	3	0	0
1799	8	0	1	22	60	5	1	0
1799	117	2	0	32	60	2	0	0
1799	319	2	1	50	60	1	0	0
1799	61	2	0	25	60	1	0	0
1799	228	2	1	32	60	4	0	0
1800	374	0	1	50	60	0	0	0
1800	81	0	0	20	60	3	1	0
1800	244	0	1	35	60	1	0	0
1800	450	0	1	21	60	1	0	0
1800	88	0	1	40	60	0	0	0
1800	248	2	1	34	60	5	0	0
1800	431	1	1	37	60	3	0	0
1800	471	2	0	50	60	0	0	0
1801	433	2	1	38	60	1	0	0
1801	487	0	1	45	60	3	0	0
1801	409	0	0	26	60	2	0	0
1801	369	1	1	29	60	3	0	0
1801	406	1	0	25	60	0	0	0
1801	223	2	0	49	60	1	0	0
1801	463	1	1	37	60	0	0	0
1801	464	2	1	37	60	2	0	0
1802	286	0	0	24	60	0	0	0
1802	453	1	0	31	60	1	1	0
1802	293	1	1	20	60	2	0	0
1802	267	2	0	35	60	2	0	0
1802	123	2	0	30	60	2	0	0
1802	456	1	0	25	60	4	0	0
1802	55	0	0	41	60	4	0	0
1802	407	1	0	38	60	3	0	0
1803	347	1	1	27	60	2	1	0
1803	493	1	1	21	60	0	0	0
1803	326	2	0	30	60	4	1	0
1803	398	2	1	30	60	4	0	0
1803	35	2	1	42	60	0	0	0
1803	210	0	1	36	60	0	0	0
1803	332	2	0	30	60	2	0	0
1803	94	1	0	49	60	4	0	0
1804	400	2	0	36	60	4	0	0
1804	129	1	1	39	60	4	1	0
1804	269	2	1	41	60	0	0	0
1804	262	2	0	27	60	0	0	0
1804	57	2	0	43	60	4	1	0
1804	337	2	1	37	60	0	1	0
1804	167	1	0	46	60	3	1	0
1804	24	1	0	50	60	2	1	0
1805	174	0	1	35	60	5	1	0
1805	32	2	1	23	60	2	0	0
1805	423	1	1	26	60	2	0	0
1805	31	1	0	45	60	1	0	0
1805	126	1	1	29	60	4	1	0
1805	447	2	0	28	60	4	0	0
1805	10	2	0	20	60	4	0	0
1805	393	1	0	38	60	2	0	0
1806	372	2	0	23	60	4	1	0
1806	126	2	1	25	60	0	0	0
1806	323	2	1	49	60	1	1	0
1806	137	0	1	41	60	2	1	0
1806	87	1	1	39	60	2	0	0
1806	304	2	0	33	60	1	0	0
1806	483	0	0	20	60	1	1	0
1806	13	0	1	22	60	1	1	0
1807	461	1	1	27	60	5	0	0
1807	453	2	0	21	60	0	1	0
1807	38	2	1	38	60	1	1	0
1807	138	1	0	35	60	0	1	0
1807	157	1	1	48	60	1	0	0
1807	433	2	1	38	60	5	1	0
1807	395	0	1	32	60	2	0	0
1807	322	2	0	31	60	4	1	0
1808	206	0	0	24	60	5	0	0
1808	216	0	0	35	60	2	1	0
1808	371	1	0	34	60	0	0	0
1808	247	0	1	46	60	0	0	0
1808	354	2	0	29	60	2	0	0
1808	409	0	0	23	60	1	0	0
1808	50	2	1	35	60	1	0	0
1808	130	0	1	38	60	3	0	0
1809	208	0	0	40	60	0	0	0
1809	196	0	1	45	60	3	1	0
1809	393	0	1	28	60	2	0	0
1809	225	1	0	25	60	5	0	0
1809	341	0	1	27	60	3	0	0
1809	365	1	0	32	60	5	0	0
1809	240	2	0	22	60	5	0	0
1809	158	0	1	29	60	0	0	0
1810	361	2	0	50	60	5	1	0
1810	229	0	1	37	60	5	0	0
1810	176	0	0	26	60	4	1	0
1810	69	1	0	33	60	4	1	0
1810	362	2	0	32	60	3	0	0
1810	342	0	0	40	60	3	0	0
1810	351	1	0	35	60	4	0	0
1810	289	0	1	43	60	2	1	0
1811	453	0	1	35	60	4	0	0
1811	217	2	0	48	60	1	0	0
1811	180	1	0	33	60	2	0	0
1811	424	1	0	35	60	1	0	0
1811	36	2	0	23	60	1	0	0
1811	22	2	1	34	60	1	0	0
1811	334	0	0	25	60	0	0	0
1811	494	1	0	26	60	3	0	0
1812	429	0	0	33	60	2	0	0
1812	225	2	1	46	60	2	0	0
1812	288	0	1	35	60	2	0	0
1812	352	2	1	44	60	2	0	0
1812	331	0	1	20	60	2	0	0
1812	94	2	1	35	60	5	0	0
1812	136	1	1	50	60	2	1	0
1812	202	1	0	47	60	4	0	0
1813	362	2	1	47	60	1	1	0
1813	453	2	0	23	60	5	0	0
1813	45	0	1	38	60	3	0	0
1813	226	0	1	38	60	0	0	0
1813	455	2	1	31	60	3	0	0
1813	169	1	0	32	60	2	0	0
1813	418	0	0	35	60	3	0	0
1813	279	0	0	39	60	1	1	0
1814	241	1	0	30	60	4	0	0
1814	410	0	0	36	60	4	1	0
1814	407	1	1	20	60	0	0	0
1814	74	0	1	38	60	2	0	0
1814	85	1	1	38	60	2	1	0
1814	302	2	0	37	60	0	1	0
1814	313	0	0	24	60	3	0	0
1814	16	2	0	35	60	4	1	0
1815	155	2	1	43	60	1	0	0
1815	11	1	0	25	60	2	1	0
1815	72	1	1	44	60	3	0	0
1815	179	1	1	38	60	0	1	0
1815	322	1	0	37	60	2	0	0
1815	358	2	0	23	60	3	1	0
1815	46	0	1	36	60	4	0	0
1815	398	2	0	26	60	3	0	0
1816	490	1	0	40	60	5	0	0
1816	423	0	0	29	60	4	1	0
1816	338	1	0	36	60	1	0	0
1816	65	1	0	45	60	3	0	0
1816	360	2	0	48	60	1	0	0
1816	361	2	0	20	60	2	0	0
1816	313	2	0	47	60	5	0	0
1816	115	0	0	48	60	1	0	0
1817	143	0	0	32	60	1	0	0
1817	105	1	1	25	60	1	0	0
1817	128	2	0	50	60	2	1	0
1817	189	1	1	48	60	0	0	0
1817	192	2	1	25	60	3	0	0
1817	17	2	1	39	60	4	1	0
1817	110	0	1	40	60	2	0	0
1817	285	2	1	29	60	3	0	0
1818	435	2	0	37	60	4	0	0
1818	148	1	0	38	60	2	0	0
1818	277	2	0	49	60	2	1	0
1818	35	2	1	48	60	0	0	0
1818	443	2	0	27	60	3	0	0
1818	480	2	1	20	60	5	1	0
1818	278	0	0	36	60	3	0	0
1818	232	0	0	30	60	1	0	0
1819	81	0	0	27	60	3	1	0
1819	447	2	0	35	60	4	0	0
1819	182	2	1	40	60	0	0	0
1819	349	2	1	29	60	5	0	0
1819	35	2	0	27	60	0	0	0
1819	152	1	1	28	60	2	0	0
1819	369	2	1	35	60	4	0	0
1819	193	1	1	50	60	1	0	0
1820	79	1	1	37	60	1	0	0
1820	368	0	0	36	60	4	1	0
1820	21	2	0	44	60	0	0	0
1820	335	2	1	48	60	2	1	0
1820	207	0	0	36	60	1	0	0
1820	107	2	1	20	60	0	1	0
1820	267	1	0	41	60	3	0	0
1820	232	2	0	42	60	5	0	0
1821	405	0	1	37	60	3	0	0
1821	390	0	1	40	60	4	0	0
1821	305	2	0	27	60	3	0	0
1821	54	2	1	42	60	5	0	0
1821	469	0	1	24	60	2	0	0
1821	18	0	0	22	60	0	1	0
1821	327	2	0	37	60	0	1	0
1821	113	1	1	29	60	3	1	0
1822	15	1	1	24	60	0	0	0
1822	500	2	1	44	60	5	1	0
1822	434	1	0	31	60	3	0	0
1822	60	0	0	46	60	5	0	0
1822	401	1	0	31	60	0	0	0
1822	328	1	0	39	60	5	0	0
1822	408	0	0	44	60	1	0	0
1822	54	0	1	29	60	5	1	0
1823	335	1	0	35	60	1	0	0
1823	234	2	0	48	60	4	0	0
1823	391	2	0	30	60	4	1	0
1823	293	0	0	31	60	4	0	0
1823	286	0	0	43	60	2	0	0
1823	338	0	1	50	60	4	0	0
1823	382	1	0	24	60	5	0	0
1823	159	1	1	38	60	2	1	0
1824	466	1	1	25	60	4	0	0
1824	495	0	1	22	60	3	1	0
1824	105	2	1	49	60	5	0	0
1824	280	0	0	22	60	4	0	0
1824	347	2	1	47	60	4	0	0
1824	333	1	1	35	60	1	1	0
1824	398	2	0	40	60	4	0	0
1824	196	1	0	42	60	0	0	0
1825	230	2	0	46	60	4	0	0
1825	213	2	1	30	60	2	0	0
1825	39	2	1	41	60	0	0	0
1825	333	1	1	38	60	0	1	0
1825	25	0	1	36	60	3	0	0
1825	346	0	0	20	60	4	1	0
1825	116	0	1	23	60	3	1	0
1825	247	2	1	23	60	2	1	0
1826	212	1	1	48	60	2	0	0
1826	38	2	1	45	60	3	1	0
1826	176	1	0	37	60	0	0	0
1826	420	2	1	41	60	2	0	0
1826	250	1	0	31	60	0	1	0
1826	205	0	0	50	60	4	0	0
1826	65	2	0	20	60	3	0	0
1826	119	1	1	41	60	5	0	0
1827	166	2	0	24	60	0	0	0
1827	383	2	0	20	60	4	0	0
1827	4	2	0	27	60	3	0	0
1827	303	1	0	44	60	5	0	0
1827	33	0	0	23	60	3	0	0
1827	370	2	0	36	60	3	0	0
1827	47	2	1	20	60	3	0	0
1827	251	0	1	35	60	5	0	0
1828	12	1	1	35	60	0	0	0
1828	278	2	1	36	60	0	0	0
1828	388	1	1	24	60	5	0	0
1828	52	1	0	25	60	1	0	0
1828	314	0	1	38	60	5	0	0
1828	82	2	0	45	60	0	0	0
1828	396	1	1	39	60	4	0	0
1828	317	2	0	21	60	0	0	0
1829	350	0	1	47	60	5	0	0
1829	412	1	0	27	60	4	1	0
1829	21	1	0	45	60	5	0	0
1829	382	2	0	35	60	4	0	0
1829	198	1	1	32	60	1	0	0
1829	238	0	0	36	60	0	0	0
1829	105	1	0	23	60	3	0	0
1829	407	1	1	25	60	4	0	0
1830	54	2	0	34	60	0	0	0
1830	238	1	1	41	60	2	1	0
1830	313	1	1	49	60	2	1	0
1830	283	2	0	50	60	0	0	0
1830	398	2	0	37	60	5	1	0
1830	137	1	0	33	60	3	0	0
1830	411	1	0	24	60	0	1	0
1830	359	0	0	43	60	5	1	0
1831	430	2	0	36	60	1	0	0
1831	366	0	0	44	60	4	1	0
1831	243	1	0	24	60	1	0	0
1831	446	0	0	45	60	3	0	0
1831	404	2	0	40	60	5	0	0
1831	221	1	1	31	60	5	0	0
1831	83	1	0	22	60	0	0	0
1831	226	0	1	45	60	0	0	0
1832	184	2	0	36	60	3	0	0
1832	339	2	1	39	60	1	0	0
1832	400	0	0	21	60	1	0	0
1832	86	2	0	40	60	2	0	0
1832	410	1	0	40	60	2	0	0
1832	477	1	1	45	60	1	0	0
1832	318	2	0	34	60	5	0	0
1832	216	0	1	41	60	4	1	0
1833	243	0	1	29	60	3	0	0
1833	339	2	0	27	60	4	0	0
1833	33	0	0	27	60	3	1	0
1833	368	0	0	22	60	5	0	0
1833	343	0	1	40	60	5	0	0
1833	6	2	0	45	60	4	0	0
1833	425	0	0	27	60	5	0	0
1833	245	1	1	25	60	5	1	0
1834	320	2	1	48	60	4	1	0
1834	221	0	1	25	60	2	1	0
1834	390	2	0	32	60	4	0	0
1834	103	2	0	20	60	0	0	0
1834	362	1	1	25	60	3	1	0
1834	405	0	1	49	60	3	0	0
1834	384	2	0	35	60	3	0	0
1834	439	1	1	49	60	1	1	0
1835	34	1	1	48	60	3	0	0
1835	52	1	1	29	60	5	1	0
1835	386	2	0	47	60	0	1	0
1835	112	1	0	50	60	0	0	0
1835	486	1	1	47	60	2	0	0
1835	10	2	1	37	60	1	1	0
1835	53	0	0	44	60	4	0	0
1835	206	0	1	20	60	3	0	0
1836	212	2	1	27	60	2	0	0
1836	87	2	0	47	60	2	0	0
1836	191	2	1	20	60	0	0	0
1836	104	1	0	21	60	2	0	0
1836	274	2	1	49	60	5	0	0
1836	462	2	0	32	60	0	0	0
1836	265	2	0	50	60	5	0	0
1836	188	2	0	23	60	5	0	0
1837	131	0	0	33	60	5	0	0
1837	232	2	1	45	60	0	0	0
1837	413	1	1	49	60	1	0	0
1837	483	1	1	36	60	5	0	0
1837	463	1	1	24	60	5	0	0
1837	42	2	0	22	60	1	1	0
1837	107	2	0	40	60	0	1	0
1837	355	0	0	39	60	1	0	0
1838	83	0	0	46	60	4	1	0
1838	276	0	1	42	60	2	0	0
1838	2	2	0	23	60	4	1	0
1838	476	0	1	31	60	0	0	0
1838	442	0	0	29	60	0	1	0
1838	38	1	1	50	60	5	0	0
1838	235	2	1	23	60	5	0	0
1838	462	2	0	46	60	2	0	0
1839	234	0	1	49	60	1	0	0
1839	417	0	1	42	60	4	0	0
1839	115	0	0	27	60	2	0	0
1839	71	0	1	50	60	4	0	0
1839	308	2	0	25	60	1	0	0
1839	180	0	0	21	60	5	0	0
1839	89	1	0	39	60	3	0	0
1839	5	2	0	37	60	1	0	0
1840	144	0	1	24	60	4	0	0
1840	89	0	0	42	60	2	1	0
1840	348	2	1	34	60	1	0	0
1840	7	1	0	43	60	3	0	0
1840	343	2	0	35	60	1	1	0
1840	57	2	0	48	60	1	0	0
1840	251	0	1	24	60	5	1	0
1840	404	1	1	29	60	1	0	0
1841	205	2	1	29	60	1	0	0
1841	138	1	0	30	60	3	0	0
1841	488	0	0	34	60	3	0	0
1841	165	1	0	21	60	1	0	0
1841	479	1	1	22	60	2	0	0
1841	67	2	0	29	60	1	0	0
1841	333	1	0	28	60	4	1	0
1841	229	2	1	47	60	5	1	0
1842	446	0	1	36	60	2	0	0
1842	64	0	1	50	60	1	0	0
1842	69	0	1	27	60	0	1	0
1842	39	1	1	33	60	2	1	0
1842	104	2	1	34	60	2	1	0
1842	25	2	0	48	60	5	0	0
1842	189	0	0	42	60	4	0	0
1842	51	1	1	33	60	5	1	0
1843	52	0	0	28	60	5	0	0
1843	401	2	0	48	60	3	0	0
1843	35	0	1	37	60	4	1	0
1843	260	2	0	30	60	1	1	0
1843	238	2	1	27	60	5	1	0
1843	400	1	0	44	60	2	0	0
1843	218	1	1	32	60	0	1	0
1843	303	0	0	23	60	2	0	0
1844	210	0	1	43	60	5	1	0
1844	276	1	0	22	60	1	0	0
1844	461	0	0	45	60	5	0	0
1844	118	0	1	28	60	4	0	0
1844	422	0	0	38	60	4	0	0
1844	219	2	1	44	60	4	0	0
1844	237	2	1	46	60	1	0	0
1844	37	1	0	47	60	5	0	0
1845	491	2	1	48	60	4	0	0
1845	57	2	0	42	60	0	1	0
1845	71	2	0	21	60	4	0	0
1845	292	0	0	35	60	1	0	0
1845	470	1	0	28	60	1	1	0
1845	355	1	0	28	60	3	0	0
1845	154	1	1	36	60	1	0	0
1845	352	0	0	29	60	3	0	0
1846	299	1	1	46	60	3	1	0
1846	64	0	1	48	60	3	0	0
1846	459	0	0	27	60	1	0	0
1846	414	1	1	26	60	5	1	0
1846	161	1	0	35	60	3	0	0
1846	34	1	0	37	60	3	0	0
1846	250	1	1	43	60	2	1	0
1846	3	1	0	38	60	5	0	0
1847	267	2	1	22	60	2	0	0
1847	11	0	0	41	60	3	0	0
1847	9	2	0	23	60	5	0	0
1847	352	0	0	28	60	2	1	0
1847	443	1	1	47	60	5	1	0
1847	63	0	0	47	60	5	0	0
1847	17	1	1	28	60	0	0	0
1847	388	1	0	43	60	5	0	0
1848	11	0	1	33	60	3	0	0
1848	228	0	1	41	60	1	0	0
1848	172	2	1	46	60	5	1	0
1848	216	1	1	45	60	0	0	0
1848	421	1	1	28	60	5	1	0
1848	123	1	1	37	60	4	1	0
1848	407	1	1	45	60	0	1	0
1848	68	1	1	34	60	2	0	0
1849	135	0	1	35	60	1	0	0
1849	89	1	1	36	60	3	0	0
1849	434	0	0	37	60	1	0	0
1849	429	2	0	49	60	3	0	0
1849	162	0	0	48	60	3	0	0
1849	146	0	1	28	60	4	0	0
1849	193	2	0	47	60	5	0	0
1849	495	2	0	31	60	2	0	0
1850	64	1	1	24	60	2	1	0
1850	328	2	1	27	60	1	0	0
1850	198	2	0	21	60	4	1	0
1850	179	0	1	39	60	0	1	0
1850	445	0	1	20	60	5	0	0
1850	235	1	0	25	60	3	1	0
1850	243	1	1	22	60	4	1	0
1850	247	0	1	26	60	4	0	0
1851	344	0	1	24	60	4	1	0
1851	477	1	0	37	60	0	0	0
1851	263	1	0	21	60	5	1	0
1851	392	2	1	46	60	2	0	0
1851	333	0	0	26	60	0	0	0
1851	83	1	1	35	60	4	0	0
1851	239	2	1	28	60	2	0	0
1851	315	1	1	35	60	1	0	0
1852	421	0	0	29	60	5	0	0
1852	171	2	0	35	60	3	0	0
1852	328	2	1	23	60	2	0	0
1852	373	0	0	35	60	2	0	0
1852	317	1	1	48	60	4	0	0
1852	97	0	1	29	60	5	0	0
1852	159	0	1	31	60	3	0	0
1852	332	2	0	27	60	3	1	0
1853	440	1	0	21	60	2	0	0
1853	460	2	0	33	60	2	0	0
1853	181	1	1	38	60	0	1	0
1853	131	0	0	26	60	3	1	0
1853	27	0	1	24	60	2	0	0
1853	94	0	1	22	60	2	1	0
1853	44	1	1	29	60	1	0	0
1853	289	0	0	49	60	0	0	0
1854	4	0	0	34	60	0	0	0
1854	150	1	0	37	60	2	0	0
1854	456	0	1	43	60	0	1	0
1854	427	0	0	26	60	5	1	0
1854	447	0	0	27	60	0	1	0
1854	446	0	1	49	60	5	0	0
1854	354	2	1	33	60	3	0	0
1854	451	0	0	50	60	2	1	0
1855	130	0	1	28	60	0	1	0
1855	154	2	1	21	60	1	0	0
1855	457	1	0	23	60	2	0	0
1855	230	0	1	38	60	2	1	0
1855	334	1	0	49	60	0	1	0
1855	21	2	0	21	60	0	0	0
1855	239	0	0	27	60	4	0	0
1855	497	0	0	46	60	0	0	0
1856	484	0	0	25	60	0	0	0
1856	14	0	0	25	60	4	1	0
1856	415	2	1	37	60	5	1	0
1856	444	2	1	24	60	4	0	0
1856	264	1	1	32	60	5	0	0
1856	60	2	1	36	60	5	1	0
1856	151	0	0	34	60	2	0	0
1856	257	0	0	45	60	0	0	0
1857	276	0	1	21	60	3	0	0
1857	212	0	0	41	60	4	1	0
1857	410	1	0	34	60	3	0	0
1857	209	0	0	47	60	1	0	0
1857	424	2	0	39	60	5	0	0
1857	263	0	1	20	60	3	0	0
1857	324	0	1	32	60	4	0	0
1857	499	1	0	47	60	4	0	0
1858	433	0	0	28	60	5	0	0
1858	496	0	0	36	60	0	0	0
1858	449	1	0	37	60	3	0	0
1858	1	1	0	26	60	5	0	0
1858	374	2	1	39	60	2	0	0
1858	221	0	1	22	60	4	0	0
1858	436	2	0	47	60	4	0	0
1858	230	1	1	36	60	3	0	0
1859	347	1	0	21	60	5	1	0
1859	119	0	0	36	60	2	0	0
1859	318	2	1	27	60	0	0	0
1859	407	2	0	27	60	3	1	0
1859	423	1	1	39	60	0	1	0
1859	35	2	1	49	60	1	0	0
1859	82	1	1	30	60	1	0	0
1859	428	1	1	50	60	5	0	0
1860	436	1	1	37	60	1	0	0
1860	289	1	1	22	60	3	1	0
1860	273	0	0	37	60	0	1	0
1860	423	2	0	32	60	2	0	0
1860	227	1	1	30	60	2	0	0
1860	216	2	0	38	60	5	0	0
1860	49	1	0	34	60	0	0	0
1860	177	2	0	31	60	2	0	0
1861	290	0	1	45	60	2	0	0
1861	324	0	1	22	60	0	0	0
1861	61	0	1	25	60	5	1	0
1861	429	0	0	36	60	1	1	0
1861	269	2	1	42	60	5	1	0
1861	28	2	1	50	60	3	0	0
1861	364	2	0	24	60	5	0	0
1861	236	0	0	44	60	0	0	0
1862	422	2	1	44	60	2	0	0
1862	253	0	1	26	60	5	0	0
1862	429	0	1	35	60	0	0	0
1862	8	2	1	41	60	0	1	0
1862	179	0	1	40	60	1	0	0
1862	29	0	0	30	60	1	0	0
1862	111	2	0	20	60	3	0	0
1862	59	1	0	36	60	0	0	0
1863	381	2	1	31	60	0	0	0
1863	42	0	0	36	60	4	0	0
1863	150	2	0	27	60	3	0	0
1863	273	2	1	32	60	4	0	0
1863	106	1	1	32	60	2	0	0
1863	173	0	0	41	60	0	0	0
1863	368	2	1	46	60	4	0	0
1863	289	0	1	36	60	5	0	0
1864	69	1	0	33	60	1	0	0
1864	424	0	1	37	60	4	0	0
1864	426	2	1	43	60	4	0	0
1864	477	1	0	30	60	3	1	0
1864	236	0	1	36	60	5	1	0
1864	31	0	1	50	60	2	0	0
1864	23	1	0	22	60	5	0	0
1864	43	2	1	35	60	0	0	0
1865	265	1	1	30	60	5	0	0
1865	103	1	0	37	60	5	0	0
1865	17	0	0	48	60	4	0	0
1865	477	0	0	43	60	4	0	0
1865	120	0	1	20	60	2	0	0
1865	52	0	1	33	60	2	0	0
1865	123	2	1	33	60	3	0	0
1865	4	2	1	22	60	5	1	0
1866	275	1	1	39	60	2	0	0
1866	356	1	1	32	60	5	0	0
1866	458	0	1	32	60	0	0	0
1866	343	1	0	28	60	5	0	0
1866	50	0	1	21	60	1	0	0
1866	85	0	0	47	60	1	0	0
1866	388	2	1	27	60	2	0	0
1866	491	0	1	37	60	0	0	0
1867	409	0	1	43	60	4	0	0
1867	215	2	1	32	60	1	0	0
1867	182	2	0	29	60	3	0	0
1867	457	2	1	42	60	0	0	0
1867	137	1	0	30	60	3	0	0
1867	49	1	0	22	60	2	0	0
1867	86	1	0	23	60	3	0	0
1867	387	1	0	31	60	1	0	0
1868	454	0	0	38	60	2	0	0
1868	96	2	0	42	60	2	0	0
1868	178	2	1	38	60	0	0	0
1868	294	1	0	29	60	3	0	0
1868	57	1	0	29	60	0	0	0
1868	25	1	1	50	60	2	0	0
1868	363	2	0	50	60	2	1	0
1868	415	0	1	50	60	2	0	0
1869	122	0	1	43	60	3	1	0
1869	459	1	0	22	60	4	1	0
1869	162	2	0	34	60	4	0	0
1869	489	2	0	38	60	0	0	0
1869	333	2	0	49	60	3	0	0
1869	165	0	1	42	60	3	0	0
1869	64	1	1	27	60	2	0	0
1869	223	1	1	46	60	3	0	0
1870	470	0	1	38	60	3	1	0
1870	225	1	0	35	60	2	0	0
1870	99	1	1	21	60	4	1	0
1870	338	0	0	35	60	5	1	0
1870	78	2	0	37	60	2	1	0
1870	150	0	0	34	60	2	1	0
1870	40	2	0	37	60	1	0	0
1870	401	0	1	40	60	4	1	0
1871	125	2	1	38	60	3	0	0
1871	474	1	1	50	60	2	1	0
1871	48	2	0	28	60	0	0	0
1871	109	1	1	35	60	5	1	0
1871	240	1	1	23	60	3	0	0
1871	7	0	0	29	60	3	0	0
1871	108	0	1	29	60	4	1	0
1871	257	0	1	39	60	4	0	0
1872	294	2	1	38	60	0	0	0
1872	145	2	0	30	60	1	1	0
1872	130	2	0	24	60	4	0	0
1872	365	1	0	30	60	1	0	0
1872	100	2	0	23	60	2	0	0
1872	222	0	0	49	60	0	1	0
1872	455	1	0	49	60	2	0	0
1872	118	1	1	40	60	3	0	0
1873	92	0	1	40	60	1	0	0
1873	352	1	0	37	60	1	0	0
1873	126	2	0	50	60	4	0	0
1873	174	0	1	47	60	0	0	0
1873	379	0	1	34	60	5	1	0
1873	11	1	0	46	60	2	1	0
1873	470	1	0	41	60	1	1	0
1873	242	0	1	49	60	1	0	0
1874	188	1	1	38	60	4	0	0
1874	108	2	1	47	60	5	0	0
1874	298	1	1	47	60	0	0	0
1874	309	0	0	45	60	5	1	0
1874	69	1	1	23	60	3	0	0
1874	196	0	1	48	60	1	0	0
1874	130	0	0	37	60	3	0	0
1874	289	0	1	29	60	5	0	0
1875	210	0	0	20	60	4	0	0
1875	93	1	1	45	60	3	0	0
1875	26	1	1	49	60	0	0	0
1875	201	1	0	31	60	2	0	0
1875	397	0	0	47	60	3	1	0
1875	307	2	0	29	60	5	0	0
1875	332	2	0	36	60	2	0	0
1875	105	2	1	36	60	5	0	0
1876	232	0	0	42	60	2	0	0
1876	394	1	1	32	60	5	1	0
1876	117	2	0	36	60	4	0	0
1876	85	2	0	47	60	2	0	0
1876	410	1	0	46	60	5	0	0
1876	41	0	0	49	60	2	0	0
1876	338	1	1	31	60	1	1	0
1876	13	0	0	49	60	2	0	0
1877	288	1	0	40	60	4	1	0
1877	398	2	1	45	60	5	0	0
1877	212	0	0	45	60	0	0	0
1877	174	0	0	32	60	2	0	0
1877	11	0	0	30	60	0	0	0
1877	230	1	1	36	60	1	0	0
1877	224	1	1	50	60	3	0	0
1877	446	2	1	47	60	3	0	0
1878	3	1	0	30	60	0	0	0
1878	432	2	1	40	60	5	0	0
1878	293	2	1	34	60	4	1	0
1878	355	1	0	21	60	0	1	0
1878	169	0	0	41	60	4	0	0
1878	86	1	0	30	60	4	0	0
1878	199	2	0	29	60	5	0	0
1878	61	0	0	22	60	2	0	0
1879	139	2	1	40	60	0	0	0
1879	174	0	0	45	60	2	0	0
1879	337	1	1	24	60	5	0	0
1879	25	1	0	23	60	3	0	0
1879	16	1	0	45	60	5	0	0
1879	131	2	1	42	60	5	0	0
1879	491	2	0	41	60	3	0	0
1879	184	2	1	43	60	1	0	0
1880	159	0	0	44	60	2	0	0
1880	83	2	1	20	60	3	0	0
1880	356	0	1	48	60	0	0	0
1880	204	0	0	32	60	1	1	0
1880	474	1	1	25	60	3	0	0
1880	201	2	1	50	60	0	0	0
1880	184	1	1	28	60	5	0	0
1880	174	0	0	40	60	1	1	0
1881	192	0	0	42	60	0	1	0
1881	385	1	1	26	60	3	0	0
1881	300	2	1	29	60	2	0	0
1881	358	0	1	32	60	5	1	0
1881	458	2	0	48	60	0	0	0
1881	374	0	0	38	60	4	0	0
1881	256	2	0	33	60	3	0	0
1881	147	1	0	28	60	3	0	0
1882	82	1	1	31	60	2	0	0
1882	428	1	1	44	60	1	1	0
1882	128	0	0	20	60	5	1	0
1882	62	2	0	35	60	1	0	0
1882	259	1	0	28	60	2	0	0
1882	431	0	0	23	60	2	0	0
1882	448	0	0	48	60	3	1	0
1882	316	0	1	23	60	5	0	0
1883	188	0	1	37	60	4	0	0
1883	481	0	0	47	60	0	0	0
1883	145	0	0	24	60	5	0	0
1883	143	2	1	23	60	2	0	0
1883	384	0	0	21	60	3	0	0
1883	130	0	0	43	60	1	0	0
1883	126	0	0	38	60	3	1	0
1883	189	1	1	20	60	0	0	0
1884	245	0	0	22	60	4	0	0
1884	204	1	1	41	60	2	0	0
1884	65	0	1	46	60	1	0	0
1884	26	2	0	38	60	4	0	0
1884	85	1	1	30	60	0	1	0
1884	454	0	0	25	60	5	0	0
1884	399	2	1	22	60	0	0	0
1884	443	0	0	46	60	2	0	0
1885	52	0	0	44	60	1	0	0
1885	17	1	1	40	60	0	0	0
1885	482	0	0	21	60	4	0	0
1885	469	2	0	37	60	2	0	0
1885	253	0	0	40	60	5	0	0
1885	91	0	0	33	60	1	0	0
1885	83	2	0	35	60	0	1	0
1885	116	0	1	41	60	0	0	0
1886	70	0	0	37	60	4	0	0
1886	224	2	1	26	60	5	1	0
1886	82	2	1	23	60	4	0	0
1886	255	1	1	26	60	0	0	0
1886	497	2	1	44	60	2	0	0
1886	31	1	1	48	60	0	0	0
1886	416	0	0	27	60	1	0	0
1886	108	1	1	37	60	4	1	0
1887	37	2	1	29	60	2	0	0
1887	46	2	0	31	60	5	0	0
1887	101	1	1	31	60	4	0	0
1887	281	1	1	50	60	1	0	0
1887	75	0	0	41	60	1	0	0
1887	206	0	1	21	60	2	0	0
1887	55	2	1	49	60	0	0	0
1887	263	2	1	49	60	4	0	0
1888	206	2	1	25	60	2	0	0
1888	72	0	0	30	60	4	0	0
1888	385	2	1	48	60	0	0	0
1888	336	2	1	32	60	3	0	0
1888	35	1	0	32	60	0	0	0
1888	178	0	1	50	60	3	0	0
1888	132	1	0	25	60	5	0	0
1888	396	1	1	35	60	5	1	0
1889	311	0	1	26	60	4	0	0
1889	339	0	0	27	60	0	0	0
1889	244	1	1	33	60	4	0	0
1889	455	0	0	43	60	5	0	0
1889	375	0	0	46	60	2	1	0
1889	377	1	0	41	60	0	1	0
1889	211	0	0	26	60	1	0	0
1889	83	0	0	21	60	0	1	0
1890	31	1	1	44	60	1	0	0
1890	375	2	0	26	60	3	0	0
1890	469	0	1	28	60	5	0	0
1890	275	0	0	48	60	5	1	0
1890	409	2	0	27	60	4	0	0
1890	91	0	1	25	60	5	0	0
1890	451	1	1	46	60	3	0	0
1890	301	1	0	34	60	4	1	0
1891	2	0	0	34	60	1	0	0
1891	13	2	0	23	60	4	0	0
1891	269	1	0	47	60	0	0	0
1891	7	1	1	48	60	3	0	0
1891	27	1	1	27	60	3	0	0
1891	299	1	1	23	60	4	0	0
1891	205	0	1	36	60	4	0	0
1891	29	0	1	27	60	1	0	0
1892	116	0	1	24	60	0	1	0
1892	304	0	0	35	60	5	0	0
1892	216	2	1	35	60	1	0	0
1892	7	0	0	28	60	0	0	0
1892	482	2	1	38	60	1	1	0
1892	473	1	1	23	60	5	0	0
1892	399	0	0	42	60	0	1	0
1892	301	2	1	29	60	1	0	0
1893	409	1	1	46	60	0	0	0
1893	371	0	1	23	60	1	0	0
1893	318	2	0	20	60	0	0	0
1893	347	1	1	34	60	3	0	0
1893	351	0	1	28	60	1	0	0
1893	226	2	0	29	60	4	1	0
1893	444	0	0	22	60	4	0	0
1893	260	1	1	33	60	5	0	0
1894	251	2	0	30	60	1	0	0
1894	399	2	0	36	60	1	1	0
1894	340	2	1	24	60	5	0	0
1894	102	0	0	33	60	5	0	0
1894	173	0	1	25	60	1	0	0
1894	375	2	0	37	60	5	0	0
1894	262	1	1	35	60	1	0	0
1894	456	2	1	48	60	1	0	0
1895	215	2	1	37	60	3	1	0
1895	50	2	1	36	60	5	1	0
1895	82	1	1	44	60	0	1	0
1895	397	1	1	49	60	0	1	0
1895	429	2	0	41	60	0	1	0
1895	39	2	1	46	60	3	0	0
1895	207	0	0	35	60	5	0	0
1895	58	1	1	24	60	3	1	0
1896	123	2	1	47	60	1	0	0
1896	231	0	0	46	60	0	0	0
1896	242	2	1	47	60	2	0	0
1896	40	2	0	25	60	2	0	0
1896	389	1	0	33	60	3	1	0
1896	97	2	1	22	60	1	0	0
1896	278	0	1	47	60	5	1	0
1896	4	1	0	39	60	1	0	0
1897	252	1	0	50	60	0	1	0
1897	387	1	0	26	60	5	0	0
1897	243	0	1	42	60	2	0	0
1897	319	1	1	34	60	3	0	0
1897	79	1	1	32	60	3	0	0
1897	421	2	0	24	60	4	0	0
1897	357	1	1	36	60	3	0	0
1897	80	0	0	21	60	5	0	0
1898	300	2	1	33	60	0	0	0
1898	263	2	0	27	60	5	0	0
1898	78	1	1	31	60	4	0	0
1898	495	0	0	35	60	3	0	0
1898	184	1	1	27	60	5	0	0
1898	247	1	1	28	60	4	0	0
1898	201	0	0	29	60	1	0	0
1898	140	2	1	42	60	3	0	0
1899	275	2	0	32	60	4	0	0
1899	220	0	1	40	60	0	0	0
1899	293	2	0	32	60	4	1	0
1899	13	0	0	22	60	2	0	0
1899	109	0	0	42	60	5	0	0
1899	213	1	1	35	60	2	0	0
1899	204	2	0	42	60	4	0	0
1899	388	2	1	45	60	0	1	0
1900	319	1	0	46	60	4	0	0
1900	346	2	0	40	60	0	0	0
1900	460	1	0	24	60	1	0	0
1900	172	1	1	38	60	1	0	0
1900	430	0	1	29	60	0	1	0
1900	427	0	0	38	60	5	1	0
1900	478	0	0	28	60	3	0	0
1900	303	2	1	20	60	5	0	0
1901	235	1	1	30	60	4	0	0
1901	319	2	0	38	60	0	0	0
1901	242	2	1	37	60	1	0	0
1901	366	1	0	23	60	3	0	0
1901	225	1	0	38	60	5	0	0
1901	205	2	0	34	60	5	1	0
1901	470	2	0	21	60	0	0	0
1901	467	2	1	34	60	2	0	0
1902	242	0	0	35	60	4	1	0
1902	264	2	1	47	60	1	0	0
1902	482	2	1	43	60	5	0	0
1902	301	0	0	25	60	1	1	0
1902	72	1	1	28	60	5	1	0
1902	256	0	1	46	60	3	0	0
1902	449	1	0	29	60	3	0	0
1902	441	2	1	36	60	5	0	0
1903	128	1	0	26	60	2	1	0
1903	344	1	0	37	60	5	1	0
1903	112	1	1	50	60	0	1	0
1903	122	1	1	38	60	3	1	0
1903	473	2	0	25	60	1	0	0
1903	228	0	0	23	60	1	1	0
1903	210	0	1	49	60	4	1	0
1903	60	1	1	48	60	2	1	0
1904	96	2	0	38	60	3	0	0
1904	457	2	0	47	60	1	0	0
1904	483	2	1	41	60	5	0	0
1904	285	2	1	38	60	4	0	0
1904	240	1	1	38	60	5	0	0
1904	312	1	0	35	60	2	0	0
1904	74	1	0	20	60	3	0	0
1904	416	1	1	36	60	3	0	0
1905	229	1	0	42	60	5	0	0
1905	317	1	0	28	60	5	1	0
1905	344	0	0	25	60	4	0	0
1905	177	0	1	26	60	2	0	0
1905	210	0	1	28	60	2	1	0
1905	62	2	1	29	60	3	1	0
1905	482	2	1	38	60	3	0	0
1905	217	2	1	36	60	4	0	0
1906	381	2	1	41	60	0	0	0
1906	493	2	0	34	60	0	1	0
1906	16	0	0	33	60	3	0	0
1906	165	1	1	22	60	1	0	0
1906	347	0	1	47	60	5	0	0
1906	453	0	1	39	60	1	0	0
1906	25	0	1	45	60	0	0	0
1906	66	2	0	39	60	1	0	0
1907	312	0	1	20	60	0	1	0
1907	269	1	0	50	60	2	1	0
1907	468	2	1	41	60	3	1	0
1907	227	2	0	44	60	0	0	0
1907	225	0	0	40	60	2	0	0
1907	113	2	1	28	60	0	0	0
1907	31	1	0	30	60	4	0	0
1907	232	1	0	24	60	1	1	0
1908	426	1	1	43	60	5	0	0
1908	391	1	0	35	60	1	1	0
1908	25	1	1	28	60	4	0	0
1908	264	2	1	32	60	1	1	0
1908	361	1	0	28	60	0	1	0
1908	180	1	1	36	60	0	0	0
1908	38	0	0	45	60	5	0	0
1908	108	2	0	35	60	1	0	0
1909	459	0	1	20	60	0	0	0
1909	356	2	1	20	60	4	0	0
1909	137	2	1	29	60	3	0	0
1909	171	2	1	46	60	3	1	0
1909	209	1	0	25	60	0	0	0
1909	77	0	0	23	60	5	1	0
1909	340	2	1	47	60	5	0	0
1909	308	1	1	47	60	0	0	0
1910	95	2	0	20	60	4	0	0
1910	126	2	0	43	60	4	0	0
1910	50	0	0	39	60	5	0	0
1910	414	2	0	23	60	2	1	0
1910	258	1	1	27	60	3	0	0
1910	151	0	0	27	60	5	0	0
1910	203	2	0	32	60	4	0	0
1910	466	0	1	32	60	3	0	0
1911	306	0	0	34	60	0	0	0
1911	294	1	1	50	60	3	1	0
1911	272	2	0	44	60	3	1	0
1911	12	1	1	33	60	2	0	0
1911	88	0	1	24	60	0	0	0
1911	153	1	1	49	60	1	0	0
1911	256	0	1	27	60	2	0	0
1911	387	1	0	43	60	0	0	0
1912	64	1	1	21	60	3	0	0
1912	405	1	0	26	60	5	0	0
1912	426	0	0	43	60	5	0	0
1912	321	1	1	29	60	2	0	0
1912	364	0	1	29	60	2	0	0
1912	96	0	0	40	60	5	0	0
1912	433	1	0	31	60	3	0	0
1912	241	2	1	41	60	3	0	0
1913	494	1	1	20	60	0	0	0
1913	204	0	0	40	60	5	0	0
1913	185	2	1	43	60	0	1	0
1913	168	0	0	47	60	5	1	0
1913	36	0	0	49	60	2	1	0
1913	128	0	1	29	60	4	1	0
1913	17	1	0	23	60	1	0	0
1913	487	1	0	41	60	1	0	0
1914	306	2	1	29	60	3	1	0
1914	366	1	1	38	60	5	0	0
1914	286	0	0	22	60	3	0	0
1914	263	2	1	39	60	3	0	0
1914	11	0	0	31	60	4	0	0
1914	75	1	0	23	60	4	0	0
1914	308	2	1	25	60	1	0	0
1914	183	2	0	25	60	1	0	0
1915	394	0	0	40	60	4	0	0
1915	466	0	0	22	60	2	1	0
1915	405	1	1	31	60	4	1	0
1915	58	2	1	28	60	5	1	0
1915	19	2	0	42	60	0	0	0
1915	489	0	0	44	60	4	1	0
1915	442	1	1	26	60	3	0	0
1915	496	0	1	43	60	0	0	0
1916	479	2	1	39	60	0	0	0
1916	167	2	1	40	60	1	1	0
1916	138	2	1	25	60	1	0	0
1916	159	0	1	25	60	0	1	0
1916	353	2	1	23	60	0	1	0
1916	17	1	1	44	60	2	0	0
1916	383	1	1	20	60	0	0	0
1916	193	1	0	39	60	2	1	0
1917	163	1	0	20	60	1	1	0
1917	113	1	0	44	60	0	0	0
1917	197	2	1	35	60	0	0	0
1917	174	1	0	47	60	3	0	0
1917	20	2	1	27	60	3	0	0
1917	410	0	1	42	60	2	0	0
1917	400	0	1	38	60	5	0	0
1917	29	0	0	36	60	4	1	0
1918	296	1	0	44	60	1	0	0
1918	485	2	1	33	60	1	0	0
1918	256	2	1	47	60	3	0	0
1918	472	1	1	31	60	3	0	0
1918	16	1	0	37	60	5	0	0
1918	293	1	1	45	60	3	0	0
1918	360	1	0	28	60	4	1	0
1918	79	1	1	39	60	2	1	0
1919	199	0	0	24	60	5	1	0
1919	168	1	0	35	60	3	0	0
1919	66	0	0	46	60	1	0	0
1919	318	1	1	24	60	4	0	0
1919	117	1	1	44	60	4	0	0
1919	260	0	0	46	60	2	1	0
1919	356	1	0	31	60	5	1	0
1919	439	1	0	40	60	4	1	0
1920	341	1	0	37	60	0	0	0
1920	227	1	0	28	60	0	0	0
1920	251	0	0	47	60	1	0	0
1920	382	0	0	46	60	1	0	0
1920	243	0	0	20	60	2	1	0
1920	204	1	1	47	60	2	0	0
1920	34	2	1	23	60	4	1	0
1920	416	1	1	42	60	1	0	0
1921	445	2	0	38	60	5	0	0
1921	234	2	1	21	60	5	1	0
1921	347	0	1	47	60	2	0	0
1921	308	2	1	45	60	3	1	0
1921	87	2	1	33	60	0	0	0
1921	317	1	0	24	60	1	0	0
1921	405	0	1	30	60	1	1	0
1921	174	2	1	22	60	0	0	0
1922	278	2	1	30	60	3	0	0
1922	339	1	1	22	60	5	0	0
1922	36	1	1	21	60	3	1	0
1922	367	2	0	34	60	1	0	0
1922	445	2	1	30	60	4	1	0
1922	76	1	0	39	60	3	0	0
1922	30	2	0	20	60	1	0	0
1922	439	1	0	30	60	4	1	0
1923	398	1	0	29	60	4	0	0
1923	55	2	1	30	60	3	0	0
1923	337	2	0	22	60	5	0	0
1923	112	0	1	49	60	5	0	0
1923	492	2	0	32	60	1	0	0
1923	470	0	1	40	60	2	0	0
1923	185	0	1	29	60	1	0	0
1923	333	2	0	29	60	2	1	0
1924	452	2	0	38	60	3	1	0
1924	342	2	0	28	60	1	1	0
1924	311	0	0	20	60	5	0	0
1924	472	1	1	42	60	3	1	0
1924	429	1	0	21	60	5	0	0
1924	106	0	0	46	60	2	0	0
1924	298	1	1	47	60	5	1	0
1924	96	2	0	42	60	5	1	0
1925	444	0	0	44	60	2	0	0
1925	270	0	1	44	60	4	0	0
1925	282	1	0	25	60	1	0	0
1925	250	1	1	31	60	4	1	0
1925	459	0	0	25	60	4	0	0
1925	456	1	0	23	60	2	0	0
1925	396	0	1	29	60	4	0	0
1925	192	0	1	42	60	1	0	0
1926	138	1	0	25	60	5	0	0
1926	188	1	1	42	60	3	0	0
1926	252	2	1	25	60	2	0	0
1926	493	0	1	50	60	5	0	0
1926	229	1	0	47	60	1	0	0
1926	26	1	0	37	60	5	0	0
1926	363	2	1	20	60	3	1	0
1926	270	2	0	20	60	5	0	0
1927	261	0	1	41	60	1	0	0
1927	420	0	0	45	60	3	0	0
1927	294	1	0	41	60	0	1	0
1927	488	1	1	29	60	1	0	0
1927	170	2	0	37	60	3	1	0
1927	31	0	1	23	60	2	1	0
1927	102	2	0	24	60	1	0	0
1927	429	0	0	49	60	1	1	0
1928	338	2	0	31	60	1	0	0
1928	213	1	1	40	60	0	0	0
1928	206	0	0	28	60	5	0	0
1928	388	1	1	27	60	3	0	0
1928	339	2	1	49	60	4	0	0
1928	84	1	0	25	60	1	1	0
1928	392	0	0	37	60	3	0	0
1928	480	2	1	24	60	1	0	0
1929	438	1	0	32	60	0	0	0
1929	118	2	0	22	60	2	0	0
1929	464	0	0	48	60	1	0	0
1929	262	1	1	41	60	5	0	0
1929	13	0	0	50	60	5	1	0
1929	449	0	1	24	60	1	0	0
1929	482	0	1	36	60	5	0	0
1929	490	2	1	38	60	3	1	0
1930	270	2	0	32	60	2	0	0
1930	466	2	0	24	60	1	0	0
1930	12	2	0	41	60	1	0	0
1930	199	1	0	34	60	1	1	0
1930	161	2	1	45	60	2	0	0
1930	310	2	0	32	60	5	1	0
1930	96	1	0	26	60	2	1	0
1930	401	2	1	25	60	0	0	0
1931	479	1	1	28	60	5	0	0
1931	211	0	0	37	60	4	1	0
1931	14	2	1	35	60	3	1	0
1931	455	1	0	28	60	1	1	0
1931	265	1	0	43	60	0	0	0
1931	248	1	0	33	60	4	0	0
1931	458	2	0	46	60	2	0	0
1931	359	2	1	30	60	1	0	0
1932	176	2	0	43	60	5	0	0
1932	391	0	1	39	60	1	0	0
1932	55	2	1	34	60	0	0	0
1932	282	2	1	45	60	3	0	0
1932	44	0	0	24	60	2	1	0
1932	139	0	1	27	60	5	0	0
1932	31	1	0	49	60	0	0	0
1932	197	1	1	48	60	2	0	0
1933	291	0	0	30	60	5	1	0
1933	491	0	0	28	60	3	0	0
1933	230	1	1	27	60	0	0	0
1933	218	0	0	20	60	3	0	0
1933	182	2	1	20	60	2	0	0
1933	253	0	0	48	60	0	0	0
1933	360	1	1	22	60	3	1	0
1933	497	0	1	40	60	0	0	0
1934	202	2	0	23	60	3	0	0
1934	329	2	0	36	60	1	0	0
1934	227	1	1	50	60	0	0	0
1934	76	1	0	37	60	5	0	0
1934	50	2	1	35	60	4	0	0
1934	126	0	1	26	60	0	0	0
1934	277	0	0	45	60	3	0	0
1934	426	0	1	45	60	4	0	0
1935	316	0	0	39	60	4	0	0
1935	360	1	0	33	60	0	0	0
1935	485	1	0	21	60	3	0	0
1935	469	2	1	32	60	2	0	0
1935	42	0	0	21	60	2	0	0
1935	207	2	0	27	60	4	0	0
1935	332	1	0	20	60	4	0	0
1935	357	2	0	35	60	2	0	0
1936	491	2	1	40	60	5	0	0
1936	420	0	0	27	60	4	0	0
1936	328	2	0	32	60	0	0	0
1936	296	1	0	29	60	5	1	0
1936	195	1	0	44	60	5	1	0
1936	448	2	0	27	60	4	0	0
1936	260	2	1	40	60	3	0	0
1936	230	2	1	42	60	5	1	0
1937	203	0	1	41	60	0	0	0
1937	212	1	0	28	60	0	0	0
1937	254	1	0	35	60	3	0	0
1937	172	2	1	38	60	2	0	0
1937	450	1	0	34	60	4	0	0
1937	107	0	0	28	60	2	0	0
1937	429	0	0	28	60	3	0	0
1937	21	2	1	30	60	4	0	0
1938	443	2	0	36	60	5	1	0
1938	115	1	0	23	60	1	1	0
1938	432	1	1	29	60	0	1	0
1938	360	1	0	48	60	4	0	0
1938	402	2	1	31	60	0	0	0
1938	266	1	0	30	60	0	1	0
1938	412	2	0	50	60	3	0	0
1938	423	1	1	26	60	3	1	0
1939	457	2	0	43	60	1	0	0
1939	50	1	0	31	60	0	1	0
1939	435	2	0	35	60	5	1	0
1939	24	0	0	22	60	1	1	0
1939	138	1	0	22	60	0	0	0
1939	235	2	0	37	60	2	1	0
1939	163	0	0	38	60	0	0	0
1939	294	0	1	44	60	5	0	0
1940	7	0	0	35	60	5	1	0
1940	128	0	0	38	60	3	0	0
1940	189	0	0	32	60	3	0	0
1940	353	2	0	44	60	4	1	0
1940	364	0	0	31	60	3	0	0
1940	242	0	1	38	60	1	0	0
1940	193	0	1	44	60	2	0	0
1940	447	1	1	29	60	3	0	0
1941	279	1	1	25	60	4	0	0
1941	86	2	0	43	60	2	0	0
1941	364	0	1	50	60	3	0	0
1941	271	1	1	42	60	1	0	0
1941	90	2	1	42	60	4	0	0
1941	402	0	0	42	60	2	0	0
1941	471	2	1	35	60	5	1	0
1941	1	2	1	28	60	5	0	0
1942	48	1	0	49	60	5	1	0
1942	253	2	0	26	60	0	1	0
1942	114	0	1	29	60	1	0	0
1942	123	0	1	44	60	1	0	0
1942	286	2	0	33	60	4	0	0
1942	249	1	0	29	60	4	0	0
1942	118	2	0	46	60	0	0	0
1942	211	1	1	50	60	4	0	0
1943	407	0	0	31	60	0	0	0
1943	431	2	0	43	60	2	1	0
1943	374	0	1	46	60	4	0	0
1943	124	2	0	24	60	0	1	0
1943	10	2	1	29	60	5	0	0
1943	402	2	0	31	60	2	0	0
1943	79	0	1	24	60	3	0	0
1943	368	1	0	46	60	1	0	0
1944	309	2	0	20	60	1	1	0
1944	279	1	0	45	60	5	0	0
1944	239	1	0	45	60	3	0	0
1944	230	1	0	43	60	1	0	0
1944	254	0	1	27	60	1	1	0
1944	252	2	0	34	60	4	0	0
1944	231	0	1	22	60	2	0	0
1944	113	1	0	27	60	0	0	0
1945	98	0	1	36	60	1	0	0
1945	274	0	1	44	60	4	0	0
1945	233	0	1	23	60	5	1	0
1945	199	1	1	38	60	1	0	0
1945	41	0	0	30	60	5	0	0
1945	459	0	0	34	60	4	0	0
1945	333	0	0	50	60	3	1	0
1945	379	1	1	37	60	3	0	0
1946	426	1	1	40	60	4	0	0
1946	261	0	1	21	60	0	0	0
1946	459	2	1	40	60	2	0	0
1946	55	1	1	25	60	0	1	0
1946	210	1	1	32	60	5	0	0
1946	445	1	1	50	60	5	0	0
1946	444	0	0	28	60	3	0	0
1946	100	0	1	28	60	1	1	0
1947	436	2	1	50	60	2	0	0
1947	491	2	1	31	60	5	0	0
1947	243	2	1	43	60	1	0	0
1947	333	0	1	47	60	1	0	0
1947	328	1	0	40	60	2	0	0
1947	64	1	0	37	60	1	0	0
1947	302	0	1	47	60	3	0	0
1947	324	2	0	39	60	5	0	0
1948	303	1	1	44	60	2	0	0
1948	411	1	0	42	60	2	1	0
1948	417	2	1	39	60	4	0	0
1948	405	0	0	40	60	5	1	0
1948	311	1	1	50	60	5	0	0
1948	423	1	1	41	60	2	0	0
1948	32	2	0	24	60	4	1	0
1948	287	2	0	44	60	3	0	0
1949	173	2	0	29	60	2	0	0
1949	227	1	1	24	60	0	0	0
1949	359	0	0	38	60	3	0	0
1949	276	1	0	34	60	5	0	0
1949	159	0	1	21	60	5	1	0
1949	426	1	0	45	60	0	0	0
1949	424	2	0	42	60	4	0	0
1949	39	2	1	27	60	1	0	0
1950	254	2	1	27	60	5	0	0
1950	125	2	1	20	60	5	1	0
1950	81	0	0	47	60	0	0	0
1950	488	2	1	34	60	1	0	0
1950	228	0	0	40	60	0	0	0
1950	210	0	0	41	60	1	1	0
1950	475	2	0	42	60	0	1	0
1950	460	0	0	29	60	4	0	0
1951	251	1	0	24	60	4	1	0
1951	278	2	1	22	60	2	0	0
1951	291	1	1	36	60	5	0	0
1951	446	0	1	46	60	5	0	0
1951	120	1	0	30	60	0	0	0
1951	277	2	0	36	60	4	1	0
1951	392	1	1	40	60	0	0	0
1951	321	0	0	39	60	4	0	0
1952	86	2	0	38	60	3	0	0
1952	312	2	0	41	60	0	0	0
1952	410	2	0	25	60	0	0	0
1952	5	1	0	28	60	4	1	0
1952	254	1	0	45	60	0	0	0
1952	469	1	1	38	60	3	0	0
1952	455	1	1	36	60	3	1	0
1952	266	0	0	47	60	2	0	0
1953	177	0	0	21	60	2	0	0
1953	162	2	1	22	60	4	0	0
1953	328	1	1	33	60	5	0	0
1953	332	0	1	24	60	0	0	0
1953	398	0	0	50	60	1	0	0
1953	200	2	1	30	60	2	1	0
1953	50	1	1	23	60	3	1	0
1953	20	2	1	37	60	1	0	0
1954	253	2	0	42	60	0	0	0
1954	428	2	1	36	60	5	0	0
1954	164	1	1	38	60	5	1	0
1954	461	1	1	39	60	0	0	0
1954	447	2	0	46	60	1	0	0
1954	148	0	1	22	60	4	1	0
1954	252	0	0	30	60	0	0	0
1954	234	0	1	22	60	0	0	0
1955	301	1	1	20	60	2	0	0
1955	349	1	1	37	60	5	1	0
1955	375	2	0	29	60	1	0	0
1955	311	2	0	41	60	1	0	0
1955	280	2	1	31	60	4	0	0
1955	65	2	1	34	60	4	1	0
1955	117	2	1	45	60	5	1	0
1955	185	0	0	34	60	4	0	0
1956	306	2	0	38	60	5	0	0
1956	232	2	0	26	60	0	0	0
1956	68	0	0	21	60	1	0	0
1956	143	0	1	25	60	2	0	0
1956	222	2	1	36	60	1	1	0
1956	371	2	1	31	60	2	0	0
1956	137	2	1	40	60	5	0	0
1956	113	0	1	22	60	5	0	0
1957	493	1	0	37	60	1	1	0
1957	445	2	0	50	60	5	0	0
1957	183	1	0	45	60	1	0	0
1957	23	2	1	30	60	0	0	0
1957	273	2	0	36	60	3	0	0
1957	149	2	1	22	60	0	0	0
1957	210	0	1	45	60	5	0	0
1957	21	1	0	44	60	2	1	0
1958	58	1	1	21	60	4	1	0
1958	286	1	0	20	60	5	1	0
1958	141	1	1	22	60	2	0	0
1958	2	2	0	34	60	2	0	0
1958	239	1	0	47	60	0	1	0
1958	257	2	1	50	60	2	0	0
1958	171	1	0	40	60	5	0	0
1958	106	0	1	35	60	0	0	0
1959	340	0	0	48	60	3	0	0
1959	476	2	1	20	60	2	0	0
1959	64	0	0	47	60	3	0	0
1959	394	0	1	24	60	3	0	0
1959	405	0	0	41	60	5	0	0
1959	324	2	0	47	60	0	0	0
1959	162	0	1	32	60	1	0	0
1959	119	0	0	25	60	4	1	0
1960	22	2	1	35	60	2	1	0
1960	156	2	1	32	60	3	0	0
1960	354	0	1	28	60	3	0	0
1960	161	0	1	32	60	2	0	0
1960	166	0	0	46	60	3	0	0
1960	445	2	1	45	60	0	0	0
1960	268	2	0	22	60	3	1	0
1960	328	0	1	31	60	2	0	0
1961	485	2	0	31	60	1	0	0
1961	367	2	0	36	60	3	0	0
1961	27	2	0	30	60	5	1	0
1961	166	1	1	50	60	3	1	0
1961	424	1	0	29	60	4	1	0
1961	355	1	1	29	60	3	1	0
1961	300	2	1	29	60	3	0	0
1961	310	0	0	25	60	0	0	0
1962	100	1	0	40	60	5	0	0
1962	284	0	0	35	60	1	0	0
1962	64	1	0	25	60	0	1	0
1962	280	1	1	30	60	5	0	0
1962	463	0	1	22	60	3	0	0
1962	84	0	1	42	60	4	0	0
1962	428	2	1	32	60	0	0	0
1962	393	0	1	40	60	1	0	0
1963	221	1	0	23	60	4	0	0
1963	100	2	0	34	60	0	0	0
1963	190	1	0	41	60	2	0	0
1963	167	1	1	42	60	0	0	0
1963	376	1	0	23	60	3	0	0
1963	347	2	1	28	60	0	0	0
1963	299	0	1	34	60	4	1	0
1963	163	1	1	33	60	3	0	0
1964	298	1	1	50	60	0	0	0
1964	303	1	1	49	60	4	0	0
1964	441	1	0	47	60	2	1	0
1964	264	0	1	36	60	1	1	0
1964	442	2	0	33	60	0	0	0
1964	479	2	0	44	60	4	0	0
1964	468	0	0	32	60	1	0	0
1964	60	1	0	31	60	0	0	0
1965	17	1	0	27	60	0	1	0
1965	326	1	0	35	60	0	1	0
1965	114	2	0	39	60	1	1	0
1965	236	2	0	34	60	4	0	0
1965	363	2	0	41	60	4	0	0
1965	399	2	0	46	60	4	0	0
1965	406	0	0	27	60	5	1	0
1965	247	2	0	35	60	3	0	0
1966	489	2	0	38	60	2	0	0
1966	125	1	1	22	60	2	0	0
1966	268	0	0	49	60	5	0	0
1966	440	0	1	27	60	0	0	0
1966	110	0	1	30	60	1	1	0
1966	81	1	0	49	60	4	0	0
1966	66	1	1	47	60	3	0	0
1966	371	0	1	43	60	3	0	0
1967	36	0	1	41	60	4	0	0
1967	297	0	1	28	60	4	0	0
1967	145	1	0	28	60	0	0	0
1967	365	2	1	24	60	4	0	0
1967	440	0	1	32	60	4	1	0
1967	299	0	1	29	60	1	1	0
1967	394	0	0	42	60	0	0	0
1967	293	0	1	38	60	5	0	0
1968	100	2	1	50	60	5	1	0
1968	232	0	1	30	60	1	0	0
1968	315	2	0	29	60	3	1	0
1968	336	2	0	38	60	0	0	0
1968	289	2	1	42	60	0	0	0
1968	366	2	1	33	60	1	0	0
1968	285	2	1	46	60	2	0	0
1968	57	2	1	23	60	3	0	0
1969	327	1	0	34	60	5	1	0
1969	241	1	0	35	60	4	0	0
1969	87	0	0	30	60	0	0	0
1969	55	2	0	35	60	2	0	0
1969	480	0	0	46	60	0	0	0
1969	388	2	0	31	60	2	0	0
1969	454	0	0	43	60	1	0	0
1969	243	0	1	26	60	0	0	0
1970	437	0	0	35	60	5	0	0
1970	53	1	0	44	60	5	1	0
1970	63	1	1	35	60	2	0	0
1970	459	1	0	20	60	2	0	0
1970	202	2	0	26	60	0	1	0
1970	358	1	0	33	60	4	0	0
1970	42	1	1	35	60	2	1	0
1970	445	0	1	50	60	1	1	0
1971	376	2	0	20	60	2	1	0
1971	333	0	1	31	60	2	0	0
1971	162	1	1	44	60	0	0	0
1971	98	2	0	21	60	4	0	0
1971	164	1	0	45	60	2	1	0
1971	323	0	1	26	60	5	1	0
1971	218	0	0	21	60	5	0	0
1971	487	2	1	21	60	0	0	0
1972	172	0	1	28	60	4	0	0
1972	189	0	0	38	60	4	0	0
1972	37	0	0	36	60	2	0	0
1972	197	0	0	28	60	1	1	0
1972	27	1	0	31	60	0	0	0
1972	317	1	1	49	60	4	0	0
1972	463	0	0	49	60	5	0	0
1972	119	2	0	48	60	5	1	0
1973	232	2	1	47	60	5	0	0
1973	188	2	1	48	60	0	1	0
1973	29	1	0	44	60	3	0	0
1973	392	1	1	23	60	1	0	0
1973	59	2	1	38	60	1	0	0
1973	361	2	0	20	60	2	0	0
1973	225	1	0	24	60	0	0	0
1973	22	2	1	47	60	2	1	0
1974	500	0	1	20	60	3	0	0
1974	256	2	1	45	60	4	0	0
1974	193	0	1	21	60	2	0	0
1974	71	2	1	34	60	2	0	0
1974	300	1	0	30	60	3	1	0
1974	44	1	1	48	60	4	1	0
1974	423	2	0	50	60	2	0	0
1974	59	1	0	46	60	0	0	0
1975	60	2	1	49	60	2	0	0
1975	336	2	1	40	60	1	0	0
1975	304	0	0	25	60	2	0	0
1975	492	1	1	49	60	1	1	0
1975	99	2	1	42	60	4	0	0
1975	241	1	1	22	60	2	0	0
1975	54	1	1	37	60	1	0	0
1975	15	0	1	43	60	2	0	0
1976	274	0	1	43	60	2	0	0
1976	222	2	1	25	60	5	0	0
1976	120	0	0	24	60	0	0	0
1976	132	2	1	34	60	5	1	0
1976	378	1	1	34	60	3	0	0
1976	81	2	0	47	60	1	0	0
1976	14	1	0	44	60	3	0	0
1976	16	1	1	25	60	5	0	0
1977	374	0	0	22	60	5	0	0
1977	93	1	0	29	60	4	1	0
1977	170	0	0	35	60	3	1	0
1977	373	1	0	31	60	3	0	0
1977	185	1	0	43	60	4	0	0
1977	128	2	1	33	60	0	0	0
1977	410	2	0	23	60	2	0	0
1977	315	2	0	48	60	1	0	0
1978	145	2	1	49	60	4	0	0
1978	32	1	0	35	60	0	0	0
1978	3	0	1	47	60	1	0	0
1978	445	1	1	44	60	5	0	0
1978	79	0	0	29	60	5	1	0
1978	312	0	1	46	60	0	0	0
1978	371	1	1	35	60	2	0	0
1978	228	2	1	49	60	3	0	0
1979	24	0	1	28	60	0	0	0
1979	201	0	1	24	60	0	0	0
1979	22	1	0	37	60	0	0	0
1979	5	2	1	38	60	3	0	0
1979	252	0	1	35	60	1	1	0
1979	489	0	0	48	60	0	1	0
1979	136	1	0	50	60	3	0	0
1979	428	2	0	46	60	3	0	0
1980	64	1	1	25	60	1	0	0
1980	121	0	1	21	60	4	0	0
1980	32	2	0	31	60	4	1	0
1980	236	0	1	33	60	0	0	0
1980	80	1	0	39	60	0	0	0
1980	211	2	1	22	60	5	0	0
1980	480	0	0	32	60	2	0	0
1980	40	0	0	26	60	1	0	0
1981	231	2	0	31	60	4	0	0
1981	354	1	0	38	60	0	1	0
1981	443	1	0	47	60	5	0	0
1981	222	2	0	43	60	4	0	0
1981	323	1	1	44	60	2	0	0
1981	97	0	0	24	60	5	0	0
1981	175	1	0	42	60	3	1	0
1981	101	0	0	37	60	5	0	0
1982	454	1	1	47	60	3	0	0
1982	197	2	1	37	60	0	0	0
1982	403	1	0	24	60	0	0	0
1982	183	0	1	49	60	0	0	0
1982	305	1	0	29	60	4	1	0
1982	261	2	1	24	60	4	0	0
1982	67	0	0	47	60	3	1	0
1982	262	2	0	30	60	1	0	0
1983	467	1	0	35	60	4	1	0
1983	53	0	1	33	60	3	1	0
1983	197	1	0	38	60	3	0	0
1983	255	1	1	26	60	3	0	0
1983	418	2	1	21	60	2	0	0
1983	411	1	0	37	60	2	1	0
1983	296	1	1	33	60	4	0	0
1983	381	2	1	43	60	4	1	0
1984	248	1	0	32	60	1	0	0
1984	1	2	1	29	60	2	0	0
1984	436	2	0	48	60	2	0	0
1984	170	1	1	50	60	4	0	0
1984	174	0	0	43	60	0	0	0
1984	440	2	0	22	60	2	0	0
1984	73	1	1	26	60	1	0	0
1984	254	1	1	33	60	4	0	0
1985	427	1	0	37	60	4	0	0
1985	455	0	0	36	60	0	0	0
1985	185	0	0	32	60	1	1	0
1985	464	2	1	40	60	3	0	0
1985	63	1	1	21	60	0	1	0
1985	33	2	1	21	60	4	1	0
1985	100	1	1	41	60	4	0	0
1985	406	0	0	27	60	2	0	0
1986	422	2	1	42	60	0	0	0
1986	396	2	1	37	60	3	0	0
1986	336	2	0	32	60	3	0	0
1986	405	1	0	42	60	0	1	0
1986	341	0	1	41	60	1	0	0
1986	165	2	1	35	60	2	0	0
1986	38	1	1	30	60	3	0	0
1986	368	0	1	21	60	1	0	0
1987	474	2	0	21	60	1	0	0
1987	421	2	0	49	60	0	1	0
1987	56	1	0	22	60	2	0	0
1987	45	2	1	39	60	4	0	0
1987	295	0	0	27	60	2	0	0
1987	134	0	0	48	60	1	1	0
1987	472	1	1	34	60	1	0	0
1987	71	0	1	32	60	2	0	0
1988	198	0	1	20	60	1	0	0
1988	241	2	0	24	60	5	0	0
1988	482	0	0	35	60	2	0	0
1988	106	2	1	50	60	2	0	0
1988	244	2	1	21	60	5	0	0
1988	331	0	1	36	60	0	1	0
1988	446	2	1	39	60	3	0	0
1988	133	2	1	42	60	4	0	0
1989	230	0	0	32	60	4	0	0
1989	33	0	1	34	60	0	0	0
1989	338	1	1	25	60	0	0	0
1989	64	2	0	26	60	5	0	0
1989	264	1	1	32	60	5	0	0
1989	350	2	1	35	60	2	0	0
1989	459	1	0	41	60	2	0	0
1989	450	1	1	40	60	0	0	0
1990	426	1	0	31	60	2	1	0
1990	305	1	0	49	60	0	0	0
1990	100	1	0	35	60	2	0	0
1990	474	2	0	45	60	2	0	0
1990	179	0	0	28	60	2	0	0
1990	499	1	0	30	60	4	0	0
1990	36	1	1	33	60	0	0	0
1990	183	1	0	46	60	1	0	0
1991	102	2	1	46	60	5	0	0
1991	200	0	0	30	60	4	0	0
1991	115	2	1	32	60	4	0	0
1991	71	2	0	29	60	5	0	0
1991	500	2	1	45	60	2	0	0
1991	5	1	0	49	60	1	0	0
1991	329	0	1	36	60	5	0	0
1991	236	1	1	23	60	0	0	0
1992	105	2	0	49	60	1	0	0
1992	104	0	1	41	60	1	1	0
1992	247	2	1	34	60	4	0	0
1992	248	2	1	49	60	2	1	0
1992	459	0	0	24	60	3	0	0
1992	282	0	1	46	60	5	0	0
1992	352	0	0	37	60	2	0	0
1992	263	1	1	35	60	2	1	0
1993	181	2	1	50	60	3	0	0
1993	385	1	1	27	60	0	1	0
1993	106	2	0	21	60	5	0	0
1993	98	2	1	32	60	5	0	0
1993	21	1	0	26	60	4	0	0
1993	392	1	1	27	60	2	1	0
1993	346	2	1	39	60	3	0	0
1993	202	1	0	39	60	3	0	0
1994	72	0	1	23	60	1	0	0
1994	186	1	0	29	60	1	0	0
1994	263	1	1	28	60	2	0	0
1994	409	1	0	36	60	1	0	0
1994	424	0	1	35	60	2	0	0
1994	124	0	1	29	60	2	0	0
1994	120	2	1	36	60	3	0	0
1994	179	2	1	43	60	3	0	0
1995	11	2	0	20	60	5	0	0
1995	25	1	1	20	60	5	1	0
1995	79	0	0	35	60	5	1	0
1995	451	2	1	37	60	0	0	0
1995	40	2	0	23	60	4	0	0
1995	204	0	1	26	60	3	0	0
1995	373	2	0	38	60	4	0	0
1995	463	2	0	21	60	5	1	0
1996	450	2	1	23	60	1	0	0
1996	313	1	1	27	60	2	0	0
1996	13	1	1	30	60	4	0	0
1996	251	1	0	37	60	1	0	0
1996	420	2	0	22	60	5	0	0
1996	235	0	0	31	60	1	0	0
1996	79	2	0	37	60	5	0	0
1996	383	2	0	25	60	4	0	0
1997	262	2	1	46	60	3	0	0
1997	345	1	1	22	60	5	0	0
1997	358	0	1	23	60	4	0	0
1997	279	0	0	32	60	1	0	0
1997	183	1	0	39	60	3	1	0
1997	382	1	1	44	60	5	1	0
1997	230	0	0	33	60	4	0	0
1997	51	1	0	41	60	1	0	0
1998	293	1	1	35	60	2	0	0
1998	337	0	1	32	60	3	0	0
1998	122	2	1	43	60	1	0	0
1998	177	2	1	47	60	5	1	0
1998	498	1	0	50	60	0	1	0
1998	85	0	1	27	60	5	1	0
1998	281	2	1	38	60	5	0	0
1998	2	1	0	26	60	4	1	0
1999	130	1	1	50	60	4	0	0
1999	14	0	1	24	60	5	0	0
1999	53	1	1	34	60	3	1	0
1999	3	0	0	21	60	3	1	0
1999	51	0	0	27	60	4	1	0
1999	55	0	1	42	60	3	1	0
1999	78	0	1	31	60	5	0	0
1999	114	2	1	32	60	4	0	0
2000	205	1	1	37	60	0	1	0
2000	499	0	0	40	60	1	0	0
2000	120	2	1	28	60	1	0	0
2000	385	0	1	42	60	4	1	0
2000	417	0	0	24	60	2	0	0
2000	325	1	1	33	60	4	0	0
2000	315	1	0	38	60	5	1	0
2000	450	0	1	30	60	2	0	0
\.


--
-- Data for Name: playsfor_gk; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.playsfor_gk (playerid, teamid, startdate, salary) FROM stdin;
\.


--
-- Data for Name: playsfor_player; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.playsfor_player (playerid, teamid, startdate, salary) FROM stdin;
42	43	2023-01-01	156892.00
43	44	2023-01-01	43869.00
44	45	2023-01-01	70256.00
45	46	2023-01-01	83298.00
46	47	2023-01-01	126308.00
47	48	2023-01-01	34788.00
48	49	2023-01-01	36857.00
49	50	2023-01-01	97850.00
50	51	2023-01-01	111352.00
51	52	2023-01-01	40724.00
52	53	2023-01-01	127424.00
53	54	2023-01-01	47835.00
54	55	2023-01-01	155011.00
55	56	2023-01-01	74162.00
56	57	2023-01-01	103463.00
57	58	2023-01-01	125336.00
58	59	2023-01-01	151537.00
59	60	2023-01-01	91233.00
60	61	2023-01-01	48804.00
61	62	2023-01-01	39204.00
62	63	2023-01-01	90988.00
63	64	2023-01-01	51036.00
64	65	2023-01-01	123010.00
65	66	2023-01-01	62002.00
66	67	2023-01-01	138863.00
67	68	2023-01-01	141090.00
68	69	2023-01-01	94306.00
69	70	2023-01-01	115188.00
70	71	2023-01-01	110717.00
71	72	2023-01-01	158061.00
72	73	2023-01-01	61078.00
73	74	2023-01-01	59321.00
74	75	2023-01-01	78772.00
75	76	2023-01-01	155489.00
76	77	2023-01-01	94497.00
77	78	2023-01-01	74581.00
78	79	2023-01-01	77595.00
79	80	2023-01-01	150896.00
80	81	2023-01-01	105332.00
81	82	2023-01-01	67626.00
82	83	2023-01-01	81618.00
83	84	2023-01-01	101982.00
84	85	2023-01-01	48847.00
85	86	2023-01-01	70437.00
86	87	2023-01-01	41184.00
87	88	2023-01-01	158865.00
88	89	2023-01-01	84963.00
89	90	2023-01-01	31565.00
90	91	2023-01-01	56425.00
91	92	2023-01-01	81141.00
92	93	2023-01-01	135177.00
93	94	2023-01-01	115708.00
94	95	2023-01-01	127539.00
95	96	2023-01-01	52913.00
96	97	2023-01-01	137104.00
97	98	2023-01-01	34829.00
98	99	2023-01-01	76883.00
99	100	2023-01-01	113235.00
100	1	2023-01-01	119370.00
101	2	2023-01-01	116783.00
102	3	2023-01-01	108869.00
103	4	2023-01-01	156329.00
104	5	2023-01-01	60429.00
105	6	2023-01-01	134024.00
106	7	2023-01-01	147831.00
107	8	2023-01-01	71016.00
108	9	2023-01-01	118389.00
109	10	2023-01-01	50754.00
110	11	2023-01-01	74407.00
111	12	2023-01-01	99378.00
112	13	2023-01-01	96649.00
113	14	2023-01-01	49583.00
114	15	2023-01-01	139139.00
115	16	2023-01-01	63963.00
116	17	2023-01-01	108263.00
117	18	2023-01-01	110862.00
118	19	2023-01-01	40525.00
119	20	2023-01-01	55440.00
120	21	2023-01-01	38023.00
121	22	2023-01-01	152225.00
122	23	2023-01-01	35587.00
123	24	2023-01-01	46869.00
124	25	2023-01-01	52747.00
125	26	2023-01-01	154284.00
126	27	2023-01-01	82833.00
127	28	2023-01-01	36541.00
128	29	2023-01-01	36441.00
129	30	2023-01-01	125896.00
130	31	2023-01-01	140787.00
131	32	2023-01-01	63710.00
132	33	2023-01-01	141585.00
133	34	2023-01-01	80536.00
134	35	2023-01-01	133996.00
135	36	2023-01-01	109905.00
136	37	2023-01-01	111971.00
137	38	2023-01-01	83432.00
138	39	2023-01-01	65317.00
139	40	2023-01-01	115626.00
140	41	2023-01-01	55151.00
141	42	2023-01-01	90275.00
142	43	2023-01-01	43987.00
143	44	2023-01-01	79237.00
144	45	2023-01-01	65539.00
145	46	2023-01-01	106038.00
146	47	2023-01-01	45144.00
147	48	2023-01-01	100194.00
148	49	2023-01-01	130159.00
149	50	2023-01-01	85874.00
150	51	2023-01-01	65651.00
151	52	2023-01-01	132677.00
152	53	2023-01-01	156553.00
153	54	2023-01-01	137412.00
154	55	2023-01-01	125007.00
155	56	2023-01-01	74904.00
156	57	2023-01-01	122798.00
157	58	2023-01-01	108525.00
158	59	2023-01-01	73095.00
159	60	2023-01-01	66156.00
160	61	2023-01-01	114011.00
161	62	2023-01-01	139777.00
162	63	2023-01-01	83412.00
163	64	2023-01-01	48193.00
164	65	2023-01-01	101685.00
165	66	2023-01-01	143334.00
166	67	2023-01-01	121354.00
167	68	2023-01-01	83419.00
168	69	2023-01-01	65096.00
169	70	2023-01-01	151363.00
170	71	2023-01-01	78286.00
171	72	2023-01-01	124728.00
172	73	2023-01-01	155192.00
173	74	2023-01-01	143710.00
174	75	2023-01-01	129818.00
175	76	2023-01-01	45508.00
176	77	2023-01-01	55853.00
177	78	2023-01-01	63427.00
178	79	2023-01-01	141805.00
179	80	2023-01-01	59310.00
180	81	2023-01-01	100963.00
181	82	2023-01-01	59679.00
182	83	2023-01-01	103287.00
183	84	2023-01-01	122123.00
184	85	2023-01-01	48956.00
185	86	2023-01-01	132826.00
186	87	2023-01-01	74303.00
187	88	2023-01-01	143765.00
188	89	2023-01-01	50325.00
189	90	2023-01-01	110302.00
190	91	2023-01-01	134886.00
191	92	2023-01-01	49330.00
192	93	2023-01-01	124454.00
193	94	2023-01-01	43868.00
194	95	2023-01-01	147291.00
195	96	2023-01-01	70909.00
196	97	2023-01-01	150638.00
197	98	2023-01-01	51645.00
198	99	2023-01-01	90586.00
199	100	2023-01-01	53879.00
200	1	2023-01-01	98880.00
201	2	2023-01-01	80195.00
202	3	2023-01-01	44434.00
203	4	2023-01-01	61959.00
204	5	2023-01-01	93151.00
205	6	2023-01-01	101667.00
206	7	2023-01-01	53432.00
207	8	2023-01-01	93682.00
208	9	2023-01-01	125921.00
209	10	2023-01-01	129692.00
210	11	2023-01-01	71091.00
211	12	2023-01-01	106988.00
212	13	2023-01-01	125689.00
213	14	2023-01-01	123288.00
214	15	2023-01-01	93973.00
215	16	2023-01-01	43756.00
216	17	2023-01-01	89709.00
217	18	2023-01-01	131256.00
218	19	2023-01-01	52588.00
219	20	2023-01-01	44240.00
220	21	2023-01-01	32025.00
221	22	2023-01-01	59456.00
222	23	2023-01-01	84080.00
223	24	2023-01-01	113405.00
224	25	2023-01-01	118753.00
225	26	2023-01-01	124484.00
226	27	2023-01-01	116754.00
227	28	2023-01-01	147324.00
228	29	2023-01-01	47188.00
229	30	2023-01-01	96732.00
230	31	2023-01-01	35224.00
231	32	2023-01-01	118278.00
232	33	2023-01-01	97112.00
233	34	2023-01-01	33746.00
234	35	2023-01-01	130570.00
235	36	2023-01-01	43134.00
236	37	2023-01-01	52693.00
237	38	2023-01-01	138707.00
238	39	2023-01-01	81933.00
239	40	2023-01-01	120709.00
240	41	2023-01-01	100504.00
241	42	2023-01-01	130595.00
242	43	2023-01-01	39257.00
243	44	2023-01-01	86113.00
244	45	2023-01-01	44312.00
245	46	2023-01-01	104759.00
246	47	2023-01-01	147133.00
247	48	2023-01-01	96186.00
248	49	2023-01-01	112797.00
249	50	2023-01-01	71243.00
250	51	2023-01-01	152940.00
251	52	2023-01-01	56897.00
252	53	2023-01-01	154295.00
253	54	2023-01-01	135544.00
254	55	2023-01-01	121107.00
255	56	2023-01-01	40171.00
256	57	2023-01-01	72601.00
257	58	2023-01-01	51283.00
258	59	2023-01-01	90318.00
259	60	2023-01-01	45969.00
260	61	2023-01-01	88049.00
261	62	2023-01-01	107141.00
262	63	2023-01-01	137989.00
263	64	2023-01-01	154797.00
264	65	2023-01-01	89826.00
265	66	2023-01-01	106265.00
266	67	2023-01-01	120933.00
267	68	2023-01-01	86725.00
268	69	2023-01-01	52668.00
269	70	2023-01-01	119201.00
270	71	2023-01-01	47643.00
271	72	2023-01-01	57159.00
272	73	2023-01-01	116368.00
273	74	2023-01-01	134543.00
274	75	2023-01-01	130495.00
275	76	2023-01-01	51581.00
276	77	2023-01-01	62127.00
277	78	2023-01-01	79002.00
278	79	2023-01-01	155998.00
279	80	2023-01-01	68730.00
280	81	2023-01-01	42141.00
281	82	2023-01-01	157176.00
282	83	2023-01-01	45374.00
283	84	2023-01-01	110956.00
284	85	2023-01-01	99315.00
285	86	2023-01-01	47600.00
286	87	2023-01-01	121645.00
287	88	2023-01-01	100581.00
288	89	2023-01-01	92590.00
289	90	2023-01-01	82311.00
290	91	2023-01-01	104824.00
291	92	2023-01-01	85149.00
292	93	2023-01-01	116728.00
293	94	2023-01-01	82719.00
294	95	2023-01-01	108606.00
295	96	2023-01-01	115429.00
296	97	2023-01-01	144473.00
297	98	2023-01-01	96930.00
298	99	2023-01-01	110566.00
299	100	2023-01-01	109706.00
300	1	2023-01-01	127192.00
301	2	2023-01-01	84100.00
302	3	2023-01-01	150229.00
303	4	2023-01-01	94068.00
304	5	2023-01-01	43277.00
305	6	2023-01-01	104160.00
306	7	2023-01-01	62687.00
307	8	2023-01-01	53256.00
308	9	2023-01-01	84551.00
309	10	2023-01-01	93477.00
310	11	2023-01-01	96000.00
311	12	2023-01-01	31722.00
312	13	2023-01-01	128608.00
313	14	2023-01-01	104586.00
314	15	2023-01-01	157682.00
315	16	2023-01-01	157257.00
316	17	2023-01-01	95960.00
317	18	2023-01-01	76114.00
318	19	2023-01-01	71197.00
319	20	2023-01-01	92321.00
320	21	2023-01-01	40032.00
321	22	2023-01-01	43909.00
322	23	2023-01-01	101726.00
323	24	2023-01-01	83123.00
324	25	2023-01-01	83906.00
325	26	2023-01-01	46882.00
326	27	2023-01-01	60419.00
327	28	2023-01-01	123961.00
328	29	2023-01-01	57996.00
329	30	2023-01-01	36470.00
330	31	2023-01-01	109091.00
331	32	2023-01-01	156313.00
332	33	2023-01-01	82735.00
333	34	2023-01-01	62933.00
334	35	2023-01-01	127577.00
335	36	2023-01-01	53436.00
336	37	2023-01-01	127909.00
337	38	2023-01-01	126115.00
338	39	2023-01-01	133557.00
339	40	2023-01-01	51506.00
340	41	2023-01-01	128702.00
341	42	2023-01-01	103489.00
342	43	2023-01-01	56456.00
343	44	2023-01-01	121204.00
344	45	2023-01-01	147004.00
345	46	2023-01-01	120766.00
346	47	2023-01-01	57147.00
347	48	2023-01-01	133173.00
348	49	2023-01-01	127357.00
349	50	2023-01-01	95621.00
350	51	2023-01-01	33918.00
351	52	2023-01-01	37964.00
352	53	2023-01-01	131259.00
353	54	2023-01-01	135868.00
354	55	2023-01-01	91920.00
355	56	2023-01-01	99892.00
356	57	2023-01-01	64514.00
357	58	2023-01-01	59624.00
358	59	2023-01-01	156947.00
359	60	2023-01-01	79397.00
360	61	2023-01-01	41657.00
361	62	2023-01-01	151268.00
362	63	2023-01-01	55631.00
363	64	2023-01-01	95198.00
364	65	2023-01-01	112380.00
365	66	2023-01-01	152789.00
366	67	2023-01-01	99433.00
367	68	2023-01-01	62471.00
368	69	2023-01-01	103766.00
369	70	2023-01-01	46774.00
370	71	2023-01-01	56817.00
371	72	2023-01-01	136743.00
372	73	2023-01-01	142249.00
373	74	2023-01-01	49723.00
374	75	2023-01-01	134335.00
375	76	2023-01-01	40779.00
376	77	2023-01-01	44942.00
377	78	2023-01-01	87352.00
378	79	2023-01-01	153813.00
379	80	2023-01-01	110799.00
380	81	2023-01-01	141437.00
381	82	2023-01-01	60072.00
382	83	2023-01-01	129313.00
383	84	2023-01-01	122656.00
384	85	2023-01-01	39589.00
385	86	2023-01-01	122880.00
386	87	2023-01-01	107152.00
387	88	2023-01-01	112491.00
388	89	2023-01-01	103384.00
389	90	2023-01-01	118705.00
390	91	2023-01-01	58857.00
391	92	2023-01-01	147603.00
392	93	2023-01-01	78564.00
393	94	2023-01-01	90512.00
394	95	2023-01-01	51506.00
395	96	2023-01-01	133260.00
396	97	2023-01-01	66677.00
397	98	2023-01-01	128674.00
398	99	2023-01-01	58762.00
399	100	2023-01-01	108705.00
400	1	2023-01-01	73063.00
401	2	2023-01-01	45099.00
402	3	2023-01-01	154572.00
403	4	2023-01-01	73268.00
404	5	2023-01-01	64657.00
405	6	2023-01-01	75343.00
406	7	2023-01-01	48825.00
407	8	2023-01-01	53298.00
408	9	2023-01-01	86110.00
409	10	2023-01-01	59958.00
410	11	2023-01-01	136366.00
411	12	2023-01-01	83792.00
412	13	2023-01-01	123620.00
413	14	2023-01-01	149620.00
414	15	2023-01-01	111202.00
415	16	2023-01-01	150242.00
416	17	2023-01-01	156658.00
417	18	2023-01-01	68130.00
418	19	2023-01-01	153763.00
419	20	2023-01-01	44477.00
420	21	2023-01-01	129548.00
421	22	2023-01-01	136398.00
422	23	2023-01-01	152508.00
423	24	2023-01-01	132220.00
424	25	2023-01-01	96599.00
425	26	2023-01-01	82768.00
426	27	2023-01-01	146544.00
427	28	2023-01-01	110704.00
428	29	2023-01-01	33487.00
429	30	2023-01-01	84437.00
430	31	2023-01-01	72620.00
431	32	2023-01-01	99421.00
432	33	2023-01-01	143211.00
433	34	2023-01-01	49025.00
434	35	2023-01-01	69562.00
435	36	2023-01-01	32911.00
436	37	2023-01-01	54275.00
437	38	2023-01-01	117978.00
438	39	2023-01-01	63291.00
439	40	2023-01-01	154697.00
440	41	2023-01-01	155911.00
441	42	2023-01-01	78952.00
442	43	2023-01-01	116677.00
443	44	2023-01-01	119661.00
444	45	2023-01-01	123084.00
445	46	2023-01-01	41958.00
446	47	2023-01-01	120390.00
447	48	2023-01-01	63074.00
448	49	2023-01-01	133083.00
449	50	2023-01-01	98093.00
450	51	2023-01-01	55114.00
451	52	2023-01-01	93713.00
452	53	2023-01-01	145900.00
453	54	2023-01-01	153933.00
454	55	2023-01-01	120285.00
455	56	2023-01-01	71680.00
456	57	2023-01-01	64141.00
457	58	2023-01-01	142707.00
458	59	2023-01-01	78561.00
459	60	2023-01-01	149465.00
460	61	2023-01-01	58024.00
461	62	2023-01-01	95982.00
462	63	2023-01-01	158320.00
463	64	2023-01-01	116882.00
464	65	2023-01-01	35375.00
465	66	2023-01-01	130377.00
466	67	2023-01-01	78645.00
467	68	2023-01-01	58535.00
468	69	2023-01-01	40745.00
469	70	2023-01-01	146194.00
470	71	2023-01-01	61391.00
471	72	2023-01-01	33163.00
472	73	2023-01-01	100704.00
473	74	2023-01-01	34076.00
474	75	2023-01-01	45021.00
475	76	2023-01-01	132410.00
476	77	2023-01-01	72259.00
477	78	2023-01-01	133829.00
478	79	2023-01-01	71580.00
479	80	2023-01-01	102638.00
480	81	2023-01-01	65864.00
481	82	2023-01-01	58216.00
482	83	2023-01-01	86941.00
483	84	2023-01-01	101189.00
484	85	2023-01-01	128972.00
485	86	2023-01-01	120255.00
486	87	2023-01-01	120717.00
487	88	2023-01-01	78214.00
488	89	2023-01-01	72852.00
489	90	2023-01-01	52662.00
490	91	2023-01-01	96455.00
491	92	2023-01-01	114283.00
492	93	2023-01-01	73451.00
493	94	2023-01-01	82519.00
494	95	2023-01-01	104808.00
495	96	2023-01-01	156813.00
496	97	2023-01-01	54293.00
497	98	2023-01-01	39446.00
498	99	2023-01-01	53046.00
499	100	2023-01-01	77925.00
500	1	2023-01-01	67710.00
501	2	2023-01-01	50211.00
502	3	2023-01-01	58606.00
503	4	2023-01-01	35700.00
504	5	2023-01-01	124480.00
505	6	2023-01-01	133042.00
506	7	2023-01-01	62397.00
507	8	2023-01-01	132055.00
508	9	2023-01-01	32351.00
509	10	2023-01-01	50859.00
510	11	2023-01-01	109740.00
511	12	2023-01-01	117568.00
512	13	2023-01-01	42108.00
513	14	2023-01-01	89283.00
514	15	2023-01-01	57444.00
515	16	2023-01-01	60948.00
516	17	2023-01-01	102839.00
517	18	2023-01-01	69427.00
518	19	2023-01-01	107424.00
519	20	2023-01-01	152048.00
520	21	2023-01-01	104282.00
521	22	2023-01-01	159543.00
522	23	2023-01-01	96940.00
523	24	2023-01-01	52491.00
524	25	2023-01-01	45262.00
525	26	2023-01-01	62658.00
526	27	2023-01-01	72606.00
527	28	2023-01-01	105830.00
528	29	2023-01-01	120711.00
529	30	2023-01-01	58844.00
530	31	2023-01-01	75511.00
531	32	2023-01-01	117270.00
532	33	2023-01-01	108203.00
533	34	2023-01-01	107738.00
534	35	2023-01-01	55976.00
535	36	2023-01-01	73455.00
536	37	2023-01-01	42736.00
537	38	2023-01-01	57799.00
538	39	2023-01-01	118265.00
539	40	2023-01-01	121885.00
540	41	2023-01-01	123798.00
541	42	2023-01-01	120062.00
542	43	2023-01-01	83664.00
543	44	2023-01-01	142169.00
544	45	2023-01-01	65806.00
545	46	2023-01-01	150897.00
546	47	2023-01-01	56954.00
547	48	2023-01-01	113373.00
548	49	2023-01-01	122046.00
549	50	2023-01-01	65870.00
550	51	2023-01-01	39876.00
551	52	2023-01-01	116720.00
552	53	2023-01-01	111243.00
553	54	2023-01-01	159473.00
554	55	2023-01-01	89317.00
555	56	2023-01-01	92046.00
556	57	2023-01-01	73978.00
557	58	2023-01-01	85950.00
558	59	2023-01-01	92454.00
559	60	2023-01-01	113770.00
560	61	2023-01-01	144758.00
561	62	2023-01-01	141168.00
562	63	2023-01-01	119073.00
563	64	2023-01-01	123770.00
564	65	2023-01-01	158902.00
565	66	2023-01-01	96756.00
566	67	2023-01-01	55686.00
567	68	2023-01-01	98953.00
568	69	2023-01-01	147755.00
569	70	2023-01-01	108651.00
570	71	2023-01-01	120281.00
571	72	2023-01-01	143980.00
572	73	2023-01-01	56510.00
573	74	2023-01-01	68376.00
574	75	2023-01-01	76889.00
575	76	2023-01-01	37390.00
576	77	2023-01-01	142649.00
577	78	2023-01-01	62599.00
578	79	2023-01-01	113864.00
579	80	2023-01-01	94381.00
580	81	2023-01-01	114135.00
581	82	2023-01-01	73710.00
582	83	2023-01-01	149397.00
583	84	2023-01-01	159077.00
584	85	2023-01-01	60322.00
585	86	2023-01-01	78568.00
586	87	2023-01-01	143696.00
587	88	2023-01-01	50740.00
588	89	2023-01-01	40306.00
589	90	2023-01-01	72868.00
590	91	2023-01-01	35164.00
591	92	2023-01-01	45240.00
592	93	2023-01-01	92577.00
593	94	2023-01-01	150132.00
594	95	2023-01-01	89283.00
595	96	2023-01-01	116199.00
596	97	2023-01-01	103738.00
597	98	2023-01-01	146406.00
598	99	2023-01-01	77215.00
599	100	2023-01-01	132414.00
600	1	2023-01-01	134281.00
601	2	2023-01-01	122730.00
602	3	2023-01-01	145838.00
603	4	2023-01-01	58755.00
604	5	2023-01-01	124397.00
605	6	2023-01-01	106456.00
606	7	2023-01-01	39139.00
607	8	2023-01-01	153369.00
608	9	2023-01-01	129158.00
609	10	2023-01-01	62318.00
610	11	2023-01-01	137750.00
611	12	2023-01-01	33962.00
612	13	2023-01-01	114068.00
613	14	2023-01-01	155961.00
614	15	2023-01-01	91899.00
615	16	2023-01-01	128422.00
616	17	2023-01-01	63167.00
617	18	2023-01-01	52184.00
618	19	2023-01-01	155336.00
619	20	2023-01-01	36907.00
620	21	2023-01-01	75049.00
621	22	2023-01-01	107685.00
622	23	2023-01-01	123250.00
623	24	2023-01-01	75143.00
624	25	2023-01-01	69894.00
625	26	2023-01-01	57354.00
626	27	2023-01-01	51054.00
627	28	2023-01-01	124168.00
628	29	2023-01-01	46670.00
629	30	2023-01-01	51539.00
630	31	2023-01-01	135781.00
631	32	2023-01-01	43485.00
632	33	2023-01-01	86800.00
633	34	2023-01-01	141768.00
634	35	2023-01-01	81288.00
635	36	2023-01-01	134516.00
636	37	2023-01-01	83582.00
637	38	2023-01-01	88816.00
638	39	2023-01-01	59191.00
639	40	2023-01-01	81522.00
640	41	2023-01-01	96147.00
641	42	2023-01-01	131496.00
642	43	2023-01-01	78308.00
643	44	2023-01-01	51286.00
644	45	2023-01-01	34318.00
645	46	2023-01-01	75523.00
646	47	2023-01-01	109170.00
647	48	2023-01-01	159086.00
648	49	2023-01-01	86730.00
649	50	2023-01-01	115639.00
650	51	2023-01-01	138780.00
651	52	2023-01-01	78050.00
652	53	2023-01-01	113119.00
653	54	2023-01-01	63666.00
654	55	2023-01-01	97237.00
655	56	2023-01-01	39418.00
656	57	2023-01-01	99189.00
657	58	2023-01-01	129312.00
658	59	2023-01-01	94471.00
659	60	2023-01-01	85562.00
660	61	2023-01-01	52339.00
661	62	2023-01-01	134833.00
662	63	2023-01-01	82866.00
663	64	2023-01-01	31826.00
664	65	2023-01-01	37536.00
665	66	2023-01-01	102743.00
666	67	2023-01-01	39541.00
667	68	2023-01-01	60636.00
668	69	2023-01-01	64265.00
669	70	2023-01-01	158644.00
670	71	2023-01-01	80270.00
671	72	2023-01-01	66358.00
672	73	2023-01-01	63521.00
673	74	2023-01-01	142124.00
674	75	2023-01-01	40311.00
675	76	2023-01-01	124301.00
676	77	2023-01-01	39789.00
677	78	2023-01-01	38279.00
678	79	2023-01-01	74098.00
679	80	2023-01-01	31195.00
680	81	2023-01-01	51534.00
681	82	2023-01-01	36810.00
682	83	2023-01-01	109649.00
683	84	2023-01-01	117743.00
684	85	2023-01-01	120850.00
685	86	2023-01-01	101820.00
686	87	2023-01-01	79312.00
687	88	2023-01-01	126517.00
688	89	2023-01-01	145505.00
689	90	2023-01-01	69026.00
690	91	2023-01-01	132917.00
691	92	2023-01-01	33183.00
692	93	2023-01-01	141882.00
693	94	2023-01-01	61404.00
694	95	2023-01-01	38613.00
695	96	2023-01-01	85426.00
696	97	2023-01-01	102478.00
697	98	2023-01-01	113142.00
698	99	2023-01-01	83362.00
699	100	2023-01-01	54944.00
700	1	2023-01-01	86190.00
701	2	2023-01-01	128647.00
702	3	2023-01-01	104337.00
703	4	2023-01-01	159824.00
704	5	2023-01-01	130974.00
705	6	2023-01-01	42883.00
706	7	2023-01-01	59945.00
707	8	2023-01-01	36870.00
708	9	2023-01-01	105537.00
709	10	2023-01-01	115536.00
710	11	2023-01-01	62683.00
711	12	2023-01-01	102821.00
712	13	2023-01-01	131147.00
713	14	2023-01-01	39189.00
714	15	2023-01-01	116027.00
715	16	2023-01-01	49823.00
716	17	2023-01-01	85637.00
717	18	2023-01-01	111581.00
718	19	2023-01-01	127933.00
719	20	2023-01-01	152185.00
720	21	2023-01-01	43697.00
721	22	2023-01-01	140623.00
722	23	2023-01-01	131581.00
723	24	2023-01-01	83002.00
724	25	2023-01-01	45908.00
725	26	2023-01-01	111140.00
726	27	2023-01-01	96375.00
727	28	2023-01-01	63672.00
728	29	2023-01-01	71088.00
729	30	2023-01-01	83998.00
730	31	2023-01-01	51896.00
731	32	2023-01-01	137990.00
732	33	2023-01-01	90810.00
733	34	2023-01-01	117789.00
734	35	2023-01-01	38457.00
735	36	2023-01-01	138162.00
736	37	2023-01-01	62407.00
737	38	2023-01-01	124792.00
738	39	2023-01-01	141897.00
739	40	2023-01-01	108705.00
740	41	2023-01-01	137944.00
741	42	2023-01-01	152902.00
742	43	2023-01-01	30087.00
743	44	2023-01-01	83189.00
744	45	2023-01-01	137360.00
745	46	2023-01-01	41764.00
746	47	2023-01-01	132272.00
747	48	2023-01-01	63727.00
748	49	2023-01-01	62927.00
749	50	2023-01-01	100519.00
750	51	2023-01-01	155097.00
751	52	2023-01-01	32447.00
752	53	2023-01-01	74301.00
753	54	2023-01-01	115361.00
754	55	2023-01-01	60967.00
755	56	2023-01-01	40987.00
756	57	2023-01-01	159359.00
757	58	2023-01-01	152212.00
758	59	2023-01-01	56099.00
759	60	2023-01-01	149294.00
760	61	2023-01-01	125356.00
761	62	2023-01-01	48412.00
762	63	2023-01-01	101870.00
763	64	2023-01-01	70209.00
764	65	2023-01-01	87814.00
765	66	2023-01-01	42695.00
766	67	2023-01-01	137128.00
767	68	2023-01-01	114881.00
768	69	2023-01-01	56990.00
769	70	2023-01-01	130031.00
770	71	2023-01-01	117281.00
771	72	2023-01-01	57536.00
772	73	2023-01-01	109245.00
773	74	2023-01-01	42335.00
774	75	2023-01-01	67591.00
775	76	2023-01-01	88559.00
776	77	2023-01-01	64325.00
777	78	2023-01-01	125180.00
778	79	2023-01-01	31040.00
779	80	2023-01-01	57897.00
780	81	2023-01-01	126905.00
781	82	2023-01-01	32711.00
782	83	2023-01-01	155205.00
783	84	2023-01-01	76825.00
784	85	2023-01-01	153039.00
785	86	2023-01-01	90935.00
786	87	2023-01-01	32089.00
787	88	2023-01-01	96613.00
788	89	2023-01-01	124782.00
789	90	2023-01-01	65291.00
790	91	2023-01-01	125617.00
791	92	2023-01-01	141982.00
792	93	2023-01-01	105656.00
793	94	2023-01-01	78548.00
794	95	2023-01-01	40141.00
795	96	2023-01-01	35829.00
796	97	2023-01-01	75070.00
797	98	2023-01-01	46521.00
798	99	2023-01-01	117233.00
799	100	2023-01-01	70470.00
800	1	2023-01-01	47246.00
801	2	2023-01-01	111744.00
802	3	2023-01-01	143764.00
803	4	2023-01-01	152170.00
804	5	2023-01-01	56568.00
805	6	2023-01-01	40476.00
806	7	2023-01-01	102445.00
807	8	2023-01-01	141757.00
808	9	2023-01-01	137538.00
809	10	2023-01-01	133094.00
810	11	2023-01-01	39985.00
811	12	2023-01-01	149702.00
812	13	2023-01-01	133309.00
813	14	2023-01-01	64882.00
814	15	2023-01-01	147050.00
815	16	2023-01-01	139516.00
816	17	2023-01-01	100815.00
817	18	2023-01-01	109760.00
818	19	2023-01-01	95278.00
819	20	2023-01-01	51689.00
820	21	2023-01-01	109105.00
821	22	2023-01-01	99908.00
822	23	2023-01-01	83490.00
823	24	2023-01-01	91480.00
824	25	2023-01-01	44636.00
825	26	2023-01-01	128868.00
826	27	2023-01-01	87802.00
827	28	2023-01-01	110408.00
828	29	2023-01-01	75212.00
829	30	2023-01-01	76053.00
830	31	2023-01-01	99778.00
831	32	2023-01-01	44403.00
832	33	2023-01-01	67390.00
833	34	2023-01-01	135490.00
834	35	2023-01-01	61209.00
835	36	2023-01-01	49421.00
836	37	2023-01-01	134275.00
837	38	2023-01-01	104047.00
838	39	2023-01-01	32815.00
839	40	2023-01-01	73168.00
840	41	2023-01-01	108295.00
841	42	2023-01-01	63949.00
842	43	2023-01-01	62365.00
843	44	2023-01-01	79330.00
844	45	2023-01-01	60493.00
845	46	2023-01-01	116887.00
846	47	2023-01-01	89169.00
847	48	2023-01-01	130965.00
848	49	2023-01-01	123200.00
849	50	2023-01-01	83619.00
850	51	2023-01-01	141212.00
851	52	2023-01-01	43957.00
852	53	2023-01-01	140724.00
853	54	2023-01-01	112236.00
854	55	2023-01-01	74762.00
855	56	2023-01-01	115788.00
856	57	2023-01-01	95950.00
857	58	2023-01-01	107501.00
858	59	2023-01-01	155466.00
859	60	2023-01-01	101020.00
860	61	2023-01-01	93411.00
861	62	2023-01-01	99460.00
862	63	2023-01-01	90536.00
863	64	2023-01-01	56505.00
864	65	2023-01-01	128634.00
865	66	2023-01-01	132552.00
866	67	2023-01-01	60796.00
867	68	2023-01-01	134984.00
868	69	2023-01-01	149259.00
869	70	2023-01-01	100405.00
870	71	2023-01-01	131114.00
871	72	2023-01-01	85499.00
872	73	2023-01-01	76483.00
873	74	2023-01-01	117260.00
874	75	2023-01-01	111805.00
875	76	2023-01-01	131470.00
876	77	2023-01-01	34681.00
877	78	2023-01-01	69970.00
878	79	2023-01-01	128705.00
879	80	2023-01-01	158039.00
880	81	2023-01-01	53727.00
881	82	2023-01-01	40665.00
882	83	2023-01-01	95051.00
883	84	2023-01-01	88377.00
884	85	2023-01-01	54867.00
885	86	2023-01-01	38504.00
886	87	2023-01-01	88354.00
887	88	2023-01-01	84014.00
888	89	2023-01-01	36455.00
889	90	2023-01-01	136197.00
890	91	2023-01-01	132982.00
891	92	2023-01-01	68956.00
892	93	2023-01-01	151858.00
893	94	2023-01-01	108668.00
894	95	2023-01-01	35169.00
895	96	2023-01-01	92511.00
896	97	2023-01-01	49835.00
897	98	2023-01-01	47965.00
898	99	2023-01-01	109767.00
899	100	2023-01-01	79154.00
900	1	2023-01-01	110591.00
901	2	2023-01-01	121835.00
902	3	2023-01-01	54353.00
903	4	2023-01-01	84413.00
904	5	2023-01-01	119852.00
905	6	2023-01-01	104425.00
906	7	2023-01-01	73300.00
907	8	2023-01-01	109025.00
908	9	2023-01-01	31536.00
909	10	2023-01-01	59378.00
910	11	2023-01-01	108081.00
911	12	2023-01-01	124224.00
912	13	2023-01-01	42960.00
913	14	2023-01-01	49823.00
914	15	2023-01-01	53554.00
915	16	2023-01-01	54755.00
916	17	2023-01-01	58793.00
917	18	2023-01-01	54835.00
918	19	2023-01-01	121632.00
919	20	2023-01-01	67715.00
920	21	2023-01-01	44818.00
921	22	2023-01-01	100629.00
922	23	2023-01-01	75076.00
923	24	2023-01-01	87845.00
924	25	2023-01-01	116698.00
925	26	2023-01-01	115886.00
926	27	2023-01-01	151525.00
927	28	2023-01-01	75014.00
928	29	2023-01-01	141426.00
929	30	2023-01-01	88903.00
930	31	2023-01-01	46196.00
931	32	2023-01-01	128112.00
932	33	2023-01-01	113414.00
933	34	2023-01-01	54883.00
934	35	2023-01-01	85385.00
935	36	2023-01-01	138927.00
936	37	2023-01-01	127713.00
937	38	2023-01-01	147598.00
938	39	2023-01-01	148809.00
939	40	2023-01-01	66479.00
940	41	2023-01-01	91307.00
941	42	2023-01-01	86381.00
942	43	2023-01-01	82875.00
943	44	2023-01-01	79551.00
944	45	2023-01-01	113557.00
945	46	2023-01-01	46985.00
946	47	2023-01-01	96354.00
947	48	2023-01-01	30792.00
948	49	2023-01-01	104850.00
949	50	2023-01-01	72810.00
950	51	2023-01-01	32141.00
951	52	2023-01-01	46971.00
952	53	2023-01-01	80877.00
953	54	2023-01-01	78551.00
954	55	2023-01-01	133514.00
955	56	2023-01-01	135878.00
956	57	2023-01-01	87129.00
957	58	2023-01-01	143092.00
958	59	2023-01-01	151773.00
959	60	2023-01-01	126211.00
960	61	2023-01-01	99293.00
961	62	2023-01-01	59026.00
962	63	2023-01-01	96270.00
963	64	2023-01-01	113981.00
964	65	2023-01-01	54198.00
965	66	2023-01-01	158163.00
966	67	2023-01-01	117948.00
967	68	2023-01-01	98576.00
968	69	2023-01-01	89786.00
969	70	2023-01-01	65616.00
970	71	2023-01-01	88229.00
971	72	2023-01-01	109851.00
972	73	2023-01-01	95472.00
973	74	2023-01-01	66314.00
974	75	2023-01-01	77231.00
975	76	2023-01-01	126153.00
976	77	2023-01-01	51719.00
977	78	2023-01-01	114867.00
978	79	2023-01-01	34934.00
979	80	2023-01-01	64520.00
980	81	2023-01-01	137265.00
981	82	2023-01-01	33455.00
982	83	2023-01-01	109135.00
983	84	2023-01-01	150891.00
984	85	2023-01-01	36152.00
985	86	2023-01-01	131314.00
986	87	2023-01-01	74579.00
987	88	2023-01-01	76416.00
988	89	2023-01-01	33762.00
989	90	2023-01-01	136218.00
990	91	2023-01-01	110075.00
991	92	2023-01-01	52169.00
992	93	2023-01-01	99730.00
993	94	2023-01-01	42271.00
994	95	2023-01-01	62823.00
995	96	2023-01-01	129542.00
996	97	2023-01-01	30584.00
997	98	2023-01-01	48223.00
998	99	2023-01-01	101500.00
999	100	2023-01-01	131849.00
1000	1	2023-01-01	137635.00
1001	2	2023-01-01	93632.00
1002	3	2023-01-01	145541.00
1003	4	2023-01-01	114891.00
1004	5	2023-01-01	93993.00
1005	6	2023-01-01	159698.00
1006	7	2023-01-01	44362.00
1007	8	2023-01-01	93879.00
1008	9	2023-01-01	32198.00
1009	10	2023-01-01	72042.00
1010	11	2023-01-01	80950.00
1011	12	2023-01-01	143692.00
1012	13	2023-01-01	125270.00
1013	14	2023-01-01	56534.00
1014	15	2023-01-01	64448.00
1015	16	2023-01-01	120463.00
1016	17	2023-01-01	105639.00
1017	18	2023-01-01	130446.00
1018	19	2023-01-01	158412.00
1019	20	2023-01-01	74761.00
1020	21	2023-01-01	75296.00
1021	22	2023-01-01	140551.00
1022	23	2023-01-01	75441.00
1023	24	2023-01-01	127451.00
1024	25	2023-01-01	102876.00
1025	26	2023-01-01	59895.00
1026	27	2023-01-01	140915.00
1027	28	2023-01-01	63549.00
1028	29	2023-01-01	57096.00
1029	30	2023-01-01	101620.00
1030	31	2023-01-01	65991.00
1031	32	2023-01-01	104737.00
1032	33	2023-01-01	50664.00
1033	34	2023-01-01	125168.00
1034	35	2023-01-01	92278.00
1035	36	2023-01-01	113433.00
1036	37	2023-01-01	140115.00
1037	38	2023-01-01	76766.00
1038	39	2023-01-01	71003.00
1039	40	2023-01-01	59394.00
1040	41	2023-01-01	75647.00
1041	42	2023-01-01	127348.00
1042	43	2023-01-01	127981.00
1043	44	2023-01-01	35140.00
1044	45	2023-01-01	137780.00
1045	46	2023-01-01	110786.00
1046	47	2023-01-01	36905.00
1047	48	2023-01-01	48783.00
1048	49	2023-01-01	109118.00
1049	50	2023-01-01	152501.00
1050	51	2023-01-01	104559.00
1051	52	2023-01-01	97403.00
1052	53	2023-01-01	70985.00
1053	54	2023-01-01	107618.00
1054	55	2023-01-01	108340.00
1055	56	2023-01-01	73447.00
1056	57	2023-01-01	41000.00
1057	58	2023-01-01	36319.00
1058	59	2023-01-01	148721.00
1059	60	2023-01-01	54806.00
1060	61	2023-01-01	91341.00
1061	62	2023-01-01	62715.00
1062	63	2023-01-01	154144.00
1063	64	2023-01-01	73242.00
1064	65	2023-01-01	128860.00
1065	66	2023-01-01	35000.00
1066	67	2023-01-01	129939.00
1067	68	2023-01-01	111850.00
1068	69	2023-01-01	105176.00
1069	70	2023-01-01	112305.00
1070	71	2023-01-01	119196.00
1071	72	2023-01-01	152535.00
1072	73	2023-01-01	101894.00
1073	74	2023-01-01	76743.00
1074	75	2023-01-01	55510.00
1075	76	2023-01-01	117041.00
1076	77	2023-01-01	38784.00
1077	78	2023-01-01	139977.00
1078	79	2023-01-01	143735.00
1079	80	2023-01-01	78594.00
1080	81	2023-01-01	147804.00
1081	82	2023-01-01	131068.00
1082	83	2023-01-01	39554.00
1083	84	2023-01-01	124685.00
1084	85	2023-01-01	103668.00
1085	86	2023-01-01	99380.00
1086	87	2023-01-01	63310.00
1087	88	2023-01-01	34393.00
1088	89	2023-01-01	141890.00
1089	90	2023-01-01	33916.00
1090	91	2023-01-01	99538.00
1091	92	2023-01-01	154723.00
1092	93	2023-01-01	144164.00
1093	94	2023-01-01	116451.00
1094	95	2023-01-01	159202.00
1095	96	2023-01-01	84283.00
1096	97	2023-01-01	157887.00
1097	98	2023-01-01	60853.00
1098	99	2023-01-01	70332.00
1099	100	2023-01-01	152946.00
1100	1	2023-01-01	144615.00
1101	2	2023-01-01	117287.00
1102	3	2023-01-01	42593.00
1103	4	2023-01-01	84837.00
1104	5	2023-01-01	154695.00
1105	6	2023-01-01	105678.00
1106	7	2023-01-01	102139.00
1107	8	2023-01-01	125138.00
1108	9	2023-01-01	130363.00
1109	10	2023-01-01	52122.00
1110	11	2023-01-01	104523.00
1111	12	2023-01-01	73003.00
1112	13	2023-01-01	79808.00
1113	14	2023-01-01	56486.00
1114	15	2023-01-01	106755.00
1115	16	2023-01-01	130915.00
1116	17	2023-01-01	144814.00
1117	18	2023-01-01	91409.00
1118	19	2023-01-01	143211.00
1119	20	2023-01-01	118661.00
1120	21	2023-01-01	126183.00
1121	22	2023-01-01	155400.00
1122	23	2023-01-01	100738.00
1123	24	2023-01-01	47087.00
1124	25	2023-01-01	118618.00
1125	26	2023-01-01	139562.00
1126	27	2023-01-01	100483.00
1127	28	2023-01-01	150331.00
1128	29	2023-01-01	86131.00
1129	30	2023-01-01	57526.00
1130	31	2023-01-01	154126.00
1131	32	2023-01-01	62735.00
1132	33	2023-01-01	47416.00
1133	34	2023-01-01	32713.00
1134	35	2023-01-01	84917.00
1135	36	2023-01-01	71978.00
1136	37	2023-01-01	33786.00
1137	38	2023-01-01	66459.00
1138	39	2023-01-01	96043.00
1139	40	2023-01-01	136017.00
1140	41	2023-01-01	132580.00
1141	42	2023-01-01	154372.00
1142	43	2023-01-01	94087.00
1143	44	2023-01-01	61378.00
1144	45	2023-01-01	133897.00
1145	46	2023-01-01	150398.00
1146	47	2023-01-01	143762.00
1147	48	2023-01-01	128291.00
1148	49	2023-01-01	87180.00
1149	50	2023-01-01	127584.00
1150	51	2023-01-01	102786.00
1151	52	2023-01-01	92088.00
1152	53	2023-01-01	47040.00
1153	54	2023-01-01	147024.00
1154	55	2023-01-01	54559.00
1155	56	2023-01-01	41751.00
1156	57	2023-01-01	61061.00
1157	58	2023-01-01	80047.00
1158	59	2023-01-01	138790.00
1159	60	2023-01-01	40221.00
1160	61	2023-01-01	116178.00
1161	62	2023-01-01	37172.00
1162	63	2023-01-01	77513.00
1163	64	2023-01-01	116772.00
1164	65	2023-01-01	70028.00
1165	66	2023-01-01	142978.00
1166	67	2023-01-01	122817.00
1167	68	2023-01-01	52394.00
1168	69	2023-01-01	153772.00
1169	70	2023-01-01	141345.00
1170	71	2023-01-01	44608.00
1171	72	2023-01-01	94364.00
1172	73	2023-01-01	76975.00
1173	74	2023-01-01	133514.00
1174	75	2023-01-01	70712.00
1175	76	2023-01-01	136458.00
1176	77	2023-01-01	50456.00
1177	78	2023-01-01	77872.00
1178	79	2023-01-01	94383.00
1179	80	2023-01-01	120266.00
1180	81	2023-01-01	147829.00
1181	82	2023-01-01	52037.00
1182	83	2023-01-01	35263.00
1183	84	2023-01-01	60361.00
1184	85	2023-01-01	51459.00
1185	86	2023-01-01	30896.00
1186	87	2023-01-01	145119.00
1187	88	2023-01-01	149566.00
1188	89	2023-01-01	75933.00
1189	90	2023-01-01	114599.00
1190	91	2023-01-01	67827.00
1191	92	2023-01-01	42681.00
1192	93	2023-01-01	58024.00
1193	94	2023-01-01	51283.00
1194	95	2023-01-01	69258.00
1195	96	2023-01-01	53673.00
1196	97	2023-01-01	47723.00
1197	98	2023-01-01	126970.00
1198	99	2023-01-01	129634.00
1199	100	2023-01-01	97400.00
1200	1	2023-01-01	36238.00
1201	2	2023-01-01	133900.00
1202	3	2023-01-01	53126.00
1203	4	2023-01-01	39185.00
1204	5	2023-01-01	125976.00
1205	6	2023-01-01	147522.00
1206	7	2023-01-01	81427.00
1207	8	2023-01-01	124670.00
1208	9	2023-01-01	43675.00
1209	10	2023-01-01	99350.00
1210	11	2023-01-01	105272.00
1211	12	2023-01-01	92681.00
1212	13	2023-01-01	124364.00
1213	14	2023-01-01	131999.00
1214	15	2023-01-01	87599.00
1215	16	2023-01-01	53576.00
1216	17	2023-01-01	83927.00
1217	18	2023-01-01	89956.00
1218	19	2023-01-01	145015.00
1219	20	2023-01-01	115727.00
1220	21	2023-01-01	149902.00
1221	22	2023-01-01	132869.00
1222	23	2023-01-01	62666.00
1223	24	2023-01-01	122192.00
1224	25	2023-01-01	158747.00
1225	26	2023-01-01	122013.00
1226	27	2023-01-01	104732.00
1227	28	2023-01-01	41310.00
1228	29	2023-01-01	64131.00
1229	30	2023-01-01	69065.00
1230	31	2023-01-01	46978.00
1231	32	2023-01-01	138623.00
1232	33	2023-01-01	85749.00
1233	34	2023-01-01	147550.00
1234	35	2023-01-01	58549.00
1235	36	2023-01-01	119957.00
1236	37	2023-01-01	54606.00
1237	38	2023-01-01	71272.00
1238	39	2023-01-01	52030.00
1239	40	2023-01-01	142181.00
1240	41	2023-01-01	96451.00
1241	42	2023-01-01	106978.00
1242	43	2023-01-01	143826.00
1243	44	2023-01-01	139990.00
1244	45	2023-01-01	156215.00
1245	46	2023-01-01	91708.00
1246	47	2023-01-01	99096.00
1247	48	2023-01-01	131026.00
1248	49	2023-01-01	140425.00
1249	50	2023-01-01	157916.00
1250	51	2023-01-01	118323.00
1251	52	2023-01-01	108363.00
1252	53	2023-01-01	150666.00
1253	54	2023-01-01	139521.00
1254	55	2023-01-01	84818.00
1255	56	2023-01-01	149496.00
1256	57	2023-01-01	136327.00
1257	58	2023-01-01	83658.00
1258	59	2023-01-01	57157.00
1259	60	2023-01-01	91354.00
1260	61	2023-01-01	55739.00
1261	62	2023-01-01	36072.00
1262	63	2023-01-01	139872.00
1263	64	2023-01-01	151102.00
1264	65	2023-01-01	121472.00
1265	66	2023-01-01	91968.00
1266	67	2023-01-01	76939.00
1267	68	2023-01-01	96420.00
1268	69	2023-01-01	50482.00
1269	70	2023-01-01	74448.00
1270	71	2023-01-01	39641.00
1271	72	2023-01-01	52454.00
1272	73	2023-01-01	139149.00
1273	74	2023-01-01	114336.00
1274	75	2023-01-01	50509.00
1275	76	2023-01-01	45598.00
1276	77	2023-01-01	58279.00
1277	78	2023-01-01	68696.00
1278	79	2023-01-01	141207.00
1279	80	2023-01-01	77397.00
1280	81	2023-01-01	154480.00
1281	82	2023-01-01	139951.00
1282	83	2023-01-01	87860.00
1283	84	2023-01-01	145681.00
1284	85	2023-01-01	115911.00
1285	86	2023-01-01	64019.00
1286	87	2023-01-01	142518.00
1287	88	2023-01-01	99550.00
1288	89	2023-01-01	129409.00
1289	90	2023-01-01	96650.00
1290	91	2023-01-01	65108.00
1291	92	2023-01-01	71596.00
1292	93	2023-01-01	52494.00
1293	94	2023-01-01	129095.00
1294	95	2023-01-01	94548.00
1295	96	2023-01-01	60366.00
1296	97	2023-01-01	47922.00
1297	98	2023-01-01	79452.00
1298	99	2023-01-01	102013.00
1299	100	2023-01-01	118441.00
1300	1	2023-01-01	98960.00
1301	2	2023-01-01	136247.00
1302	3	2023-01-01	133098.00
1303	4	2023-01-01	149826.00
1304	5	2023-01-01	46340.00
1305	6	2023-01-01	139086.00
1306	7	2023-01-01	110591.00
1307	8	2023-01-01	116798.00
1308	9	2023-01-01	36692.00
1309	10	2023-01-01	112640.00
1310	11	2023-01-01	99243.00
1311	12	2023-01-01	113248.00
1312	13	2023-01-01	44039.00
1313	14	2023-01-01	127483.00
1314	15	2023-01-01	98847.00
1315	16	2023-01-01	138806.00
1316	17	2023-01-01	156727.00
1317	18	2023-01-01	84970.00
1318	19	2023-01-01	73031.00
1319	20	2023-01-01	46665.00
1320	21	2023-01-01	77323.00
1321	22	2023-01-01	103530.00
1322	23	2023-01-01	109147.00
1323	24	2023-01-01	66744.00
1324	25	2023-01-01	39701.00
1325	26	2023-01-01	53950.00
1326	27	2023-01-01	41187.00
1327	28	2023-01-01	54033.00
1328	29	2023-01-01	127388.00
1329	30	2023-01-01	58742.00
1330	31	2023-01-01	127576.00
1331	32	2023-01-01	39982.00
1332	33	2023-01-01	155326.00
1333	34	2023-01-01	30569.00
1334	35	2023-01-01	67232.00
1335	36	2023-01-01	100622.00
1336	37	2023-01-01	31065.00
1337	38	2023-01-01	110254.00
1338	39	2023-01-01	55236.00
1339	40	2023-01-01	53519.00
1340	41	2023-01-01	82637.00
1341	42	2023-01-01	112008.00
1342	43	2023-01-01	36973.00
1343	44	2023-01-01	61889.00
1344	45	2023-01-01	37003.00
1345	46	2023-01-01	33799.00
1346	47	2023-01-01	89883.00
1347	48	2023-01-01	134354.00
1348	49	2023-01-01	155044.00
1349	50	2023-01-01	89278.00
1350	51	2023-01-01	76704.00
1351	52	2023-01-01	104167.00
1352	53	2023-01-01	84762.00
1353	54	2023-01-01	89307.00
1354	55	2023-01-01	97387.00
1355	56	2023-01-01	118041.00
1356	57	2023-01-01	112081.00
1357	58	2023-01-01	60378.00
1358	59	2023-01-01	73435.00
1359	60	2023-01-01	138123.00
1360	61	2023-01-01	72338.00
1361	62	2023-01-01	54220.00
1362	63	2023-01-01	72500.00
1363	64	2023-01-01	148544.00
1364	65	2023-01-01	81773.00
1365	66	2023-01-01	151682.00
1366	67	2023-01-01	147615.00
1367	68	2023-01-01	101849.00
1368	69	2023-01-01	76343.00
1369	70	2023-01-01	77517.00
1370	71	2023-01-01	104734.00
1371	72	2023-01-01	95423.00
1372	73	2023-01-01	64483.00
1373	74	2023-01-01	69525.00
1374	75	2023-01-01	118797.00
1375	76	2023-01-01	79067.00
1376	77	2023-01-01	50133.00
1377	78	2023-01-01	64618.00
1378	79	2023-01-01	97908.00
1379	80	2023-01-01	78171.00
1380	81	2023-01-01	73322.00
1381	82	2023-01-01	115121.00
1382	83	2023-01-01	157722.00
1383	84	2023-01-01	153681.00
1384	85	2023-01-01	37935.00
1385	86	2023-01-01	144017.00
1386	87	2023-01-01	94705.00
1387	88	2023-01-01	112376.00
1388	89	2023-01-01	62301.00
1389	90	2023-01-01	84199.00
1390	91	2023-01-01	72357.00
1391	92	2023-01-01	151839.00
1392	93	2023-01-01	35022.00
1393	94	2023-01-01	72088.00
1394	95	2023-01-01	128211.00
1395	96	2023-01-01	80406.00
1396	97	2023-01-01	136491.00
1397	98	2023-01-01	60369.00
1398	99	2023-01-01	92970.00
1399	100	2023-01-01	129629.00
1400	1	2023-01-01	108866.00
1401	2	2023-01-01	55741.00
1402	3	2023-01-01	68827.00
1403	4	2023-01-01	41627.00
1404	5	2023-01-01	34988.00
1405	6	2023-01-01	47909.00
1406	7	2023-01-01	34179.00
1407	8	2023-01-01	132688.00
1408	9	2023-01-01	64699.00
1409	10	2023-01-01	70387.00
1410	11	2023-01-01	58256.00
1411	12	2023-01-01	116220.00
1412	13	2023-01-01	99427.00
1413	14	2023-01-01	153936.00
1414	15	2023-01-01	153976.00
1415	16	2023-01-01	134975.00
1416	17	2023-01-01	91739.00
1417	18	2023-01-01	54324.00
1418	19	2023-01-01	127496.00
1419	20	2023-01-01	126827.00
1420	21	2023-01-01	158252.00
1421	22	2023-01-01	82622.00
1422	23	2023-01-01	153602.00
1423	24	2023-01-01	65246.00
1424	25	2023-01-01	100479.00
1425	26	2023-01-01	42850.00
1426	27	2023-01-01	65314.00
1427	28	2023-01-01	49484.00
1428	29	2023-01-01	40307.00
1429	30	2023-01-01	130150.00
1430	31	2023-01-01	72620.00
1431	32	2023-01-01	35483.00
1432	33	2023-01-01	151551.00
1433	34	2023-01-01	77769.00
1434	35	2023-01-01	114466.00
1435	36	2023-01-01	75326.00
1436	37	2023-01-01	159190.00
1437	38	2023-01-01	153313.00
1438	39	2023-01-01	92808.00
1439	40	2023-01-01	143879.00
1440	41	2023-01-01	54319.00
1441	42	2023-01-01	98188.00
1442	43	2023-01-01	112573.00
1443	44	2023-01-01	43130.00
1444	45	2023-01-01	126290.00
1445	46	2023-01-01	92619.00
1446	47	2023-01-01	157515.00
1447	48	2023-01-01	61237.00
1448	49	2023-01-01	134486.00
1449	50	2023-01-01	100382.00
1450	51	2023-01-01	134999.00
1451	52	2023-01-01	138254.00
1452	53	2023-01-01	87577.00
1453	54	2023-01-01	52799.00
1454	55	2023-01-01	141480.00
1455	56	2023-01-01	139858.00
1456	57	2023-01-01	84683.00
1457	58	2023-01-01	109879.00
1458	59	2023-01-01	84165.00
1459	60	2023-01-01	68386.00
1460	61	2023-01-01	61000.00
1461	62	2023-01-01	53656.00
1462	63	2023-01-01	50431.00
1463	64	2023-01-01	129162.00
1464	65	2023-01-01	97245.00
1465	66	2023-01-01	117233.00
1466	67	2023-01-01	53861.00
1467	68	2023-01-01	143794.00
1468	69	2023-01-01	137677.00
1469	70	2023-01-01	108594.00
1470	71	2023-01-01	100036.00
1471	72	2023-01-01	54655.00
1472	73	2023-01-01	74170.00
1473	74	2023-01-01	79725.00
1474	75	2023-01-01	31979.00
1475	76	2023-01-01	157560.00
1476	77	2023-01-01	105498.00
1477	78	2023-01-01	41467.00
1478	79	2023-01-01	43682.00
1479	80	2023-01-01	87685.00
1480	81	2023-01-01	92543.00
1481	82	2023-01-01	62246.00
1482	83	2023-01-01	34153.00
1483	84	2023-01-01	103991.00
1484	85	2023-01-01	102988.00
1485	86	2023-01-01	147268.00
1486	87	2023-01-01	157809.00
1487	88	2023-01-01	56658.00
1488	89	2023-01-01	63657.00
1489	90	2023-01-01	82481.00
1490	91	2023-01-01	74445.00
1491	92	2023-01-01	125792.00
1492	93	2023-01-01	73218.00
1493	94	2023-01-01	133834.00
1494	95	2023-01-01	136488.00
1495	96	2023-01-01	145471.00
1496	97	2023-01-01	78695.00
1497	98	2023-01-01	128209.00
1498	99	2023-01-01	64972.00
1499	100	2023-01-01	80913.00
1500	1	2023-01-01	44090.00
1501	2	2023-01-01	56944.00
1502	3	2023-01-01	101036.00
1503	4	2023-01-01	159507.00
1504	5	2023-01-01	150594.00
1505	6	2023-01-01	50872.00
1506	7	2023-01-01	90673.00
1507	8	2023-01-01	76112.00
1508	9	2023-01-01	157556.00
1509	10	2023-01-01	152007.00
1510	11	2023-01-01	74061.00
1511	12	2023-01-01	63424.00
1512	13	2023-01-01	53735.00
1513	14	2023-01-01	35917.00
1514	15	2023-01-01	152984.00
1515	16	2023-01-01	106181.00
1516	17	2023-01-01	95709.00
1517	18	2023-01-01	97163.00
1518	19	2023-01-01	38138.00
1519	20	2023-01-01	60667.00
1520	21	2023-01-01	54411.00
1521	22	2023-01-01	75170.00
1522	23	2023-01-01	95366.00
1523	24	2023-01-01	114720.00
1524	25	2023-01-01	149525.00
1525	26	2023-01-01	116378.00
1526	27	2023-01-01	63764.00
1527	28	2023-01-01	68152.00
1528	29	2023-01-01	117521.00
1529	30	2023-01-01	159568.00
1530	31	2023-01-01	144160.00
1531	32	2023-01-01	100920.00
1532	33	2023-01-01	148810.00
1533	34	2023-01-01	35238.00
1534	35	2023-01-01	103706.00
1535	36	2023-01-01	138100.00
1536	37	2023-01-01	119616.00
1537	38	2023-01-01	45682.00
1538	39	2023-01-01	140836.00
1539	40	2023-01-01	90412.00
1540	41	2023-01-01	135849.00
1541	42	2023-01-01	82555.00
1542	43	2023-01-01	153611.00
1543	44	2023-01-01	39009.00
1544	45	2023-01-01	85069.00
1545	46	2023-01-01	104454.00
1546	47	2023-01-01	118836.00
1547	48	2023-01-01	37372.00
1548	49	2023-01-01	122809.00
1549	50	2023-01-01	99901.00
1550	51	2023-01-01	37300.00
1551	52	2023-01-01	64377.00
1552	53	2023-01-01	120547.00
1553	54	2023-01-01	131536.00
1554	55	2023-01-01	119632.00
1555	56	2023-01-01	116567.00
1556	57	2023-01-01	93322.00
1557	58	2023-01-01	154357.00
1558	59	2023-01-01	86165.00
1559	60	2023-01-01	131497.00
1560	61	2023-01-01	139031.00
1561	62	2023-01-01	70579.00
1562	63	2023-01-01	75009.00
1563	64	2023-01-01	114060.00
1564	65	2023-01-01	30804.00
1565	66	2023-01-01	42675.00
1566	67	2023-01-01	51488.00
1567	68	2023-01-01	54616.00
1568	69	2023-01-01	122321.00
1569	70	2023-01-01	87671.00
1570	71	2023-01-01	41617.00
1571	72	2023-01-01	44180.00
1572	73	2023-01-01	137143.00
1573	74	2023-01-01	75068.00
1574	75	2023-01-01	152396.00
1575	76	2023-01-01	42544.00
1576	77	2023-01-01	68464.00
1577	78	2023-01-01	85884.00
1578	79	2023-01-01	146728.00
1579	80	2023-01-01	123492.00
1580	81	2023-01-01	116784.00
1581	82	2023-01-01	103550.00
1582	83	2023-01-01	39758.00
1583	84	2023-01-01	44991.00
1584	85	2023-01-01	88226.00
1585	86	2023-01-01	132522.00
1586	87	2023-01-01	42035.00
1587	88	2023-01-01	103721.00
1588	89	2023-01-01	34521.00
1589	90	2023-01-01	158635.00
1590	91	2023-01-01	72333.00
1591	92	2023-01-01	59231.00
1592	93	2023-01-01	63250.00
1593	94	2023-01-01	92737.00
1594	95	2023-01-01	116316.00
1595	96	2023-01-01	132862.00
1596	97	2023-01-01	110816.00
1597	98	2023-01-01	135892.00
1598	99	2023-01-01	72918.00
1599	100	2023-01-01	132099.00
1600	1	2023-01-01	118731.00
1601	2	2023-01-01	111184.00
1602	3	2023-01-01	76446.00
1603	4	2023-01-01	102096.00
1604	5	2023-01-01	71321.00
1605	6	2023-01-01	126833.00
1606	7	2023-01-01	121485.00
1607	8	2023-01-01	30362.00
1608	9	2023-01-01	117248.00
1609	10	2023-01-01	114176.00
1610	11	2023-01-01	103563.00
1611	12	2023-01-01	113505.00
1612	13	2023-01-01	97796.00
1613	14	2023-01-01	158394.00
1614	15	2023-01-01	131197.00
1615	16	2023-01-01	96343.00
1616	17	2023-01-01	94275.00
1617	18	2023-01-01	98356.00
1618	19	2023-01-01	110175.00
1619	20	2023-01-01	118695.00
1620	21	2023-01-01	50408.00
1621	22	2023-01-01	137100.00
1622	23	2023-01-01	133939.00
1623	24	2023-01-01	130981.00
1624	25	2023-01-01	92631.00
1625	26	2023-01-01	88650.00
1626	27	2023-01-01	132252.00
1627	28	2023-01-01	51912.00
1628	29	2023-01-01	112911.00
1629	30	2023-01-01	130290.00
1630	31	2023-01-01	87976.00
1631	32	2023-01-01	45974.00
1632	33	2023-01-01	144744.00
1633	34	2023-01-01	77052.00
1634	35	2023-01-01	36709.00
1635	36	2023-01-01	107466.00
1636	37	2023-01-01	83837.00
1637	38	2023-01-01	47900.00
1638	39	2023-01-01	120152.00
1639	40	2023-01-01	41426.00
1640	41	2023-01-01	75232.00
1641	42	2023-01-01	38237.00
1642	43	2023-01-01	89789.00
1643	44	2023-01-01	76965.00
1644	45	2023-01-01	103317.00
1645	46	2023-01-01	159329.00
1646	47	2023-01-01	44912.00
1647	48	2023-01-01	130606.00
1648	49	2023-01-01	33733.00
1649	50	2023-01-01	44589.00
1650	51	2023-01-01	115264.00
1651	52	2023-01-01	151316.00
1652	53	2023-01-01	123066.00
1653	54	2023-01-01	46776.00
1654	55	2023-01-01	36236.00
1655	56	2023-01-01	64273.00
1656	57	2023-01-01	65111.00
1657	58	2023-01-01	121438.00
1658	59	2023-01-01	81005.00
1659	60	2023-01-01	111694.00
1660	61	2023-01-01	31606.00
1661	62	2023-01-01	141688.00
1662	63	2023-01-01	57986.00
1663	64	2023-01-01	82984.00
1664	65	2023-01-01	68635.00
1665	66	2023-01-01	64833.00
1666	67	2023-01-01	98057.00
1667	68	2023-01-01	75426.00
1668	69	2023-01-01	148804.00
1669	70	2023-01-01	99201.00
1670	71	2023-01-01	118416.00
1671	72	2023-01-01	123359.00
1672	73	2023-01-01	100497.00
1673	74	2023-01-01	32162.00
1674	75	2023-01-01	148106.00
1675	76	2023-01-01	64027.00
1676	77	2023-01-01	108298.00
1677	78	2023-01-01	149974.00
1678	79	2023-01-01	64329.00
1679	80	2023-01-01	47575.00
1680	81	2023-01-01	53609.00
1681	82	2023-01-01	120447.00
1682	83	2023-01-01	64058.00
1683	84	2023-01-01	57898.00
1684	85	2023-01-01	126968.00
1685	86	2023-01-01	34895.00
1686	87	2023-01-01	101606.00
1687	88	2023-01-01	104029.00
1688	89	2023-01-01	94676.00
1689	90	2023-01-01	59776.00
1690	91	2023-01-01	59688.00
1691	92	2023-01-01	84786.00
1692	93	2023-01-01	31176.00
1693	94	2023-01-01	143392.00
1694	95	2023-01-01	151976.00
1695	96	2023-01-01	38167.00
1696	97	2023-01-01	158234.00
1697	98	2023-01-01	82723.00
1698	99	2023-01-01	127273.00
1699	100	2023-01-01	115194.00
1700	1	2023-01-01	99938.00
1701	2	2023-01-01	44551.00
1702	3	2023-01-01	44346.00
1703	4	2023-01-01	140951.00
1704	5	2023-01-01	152925.00
1705	6	2023-01-01	50886.00
1706	7	2023-01-01	137772.00
1707	8	2023-01-01	152357.00
1708	9	2023-01-01	41713.00
1709	10	2023-01-01	130055.00
1710	11	2023-01-01	82261.00
1711	12	2023-01-01	67899.00
1712	13	2023-01-01	116673.00
1713	14	2023-01-01	125207.00
1714	15	2023-01-01	47615.00
1715	16	2023-01-01	35476.00
1716	17	2023-01-01	103096.00
1717	18	2023-01-01	56043.00
1718	19	2023-01-01	93683.00
1719	20	2023-01-01	99520.00
1720	21	2023-01-01	123513.00
1721	22	2023-01-01	156009.00
1722	23	2023-01-01	77430.00
1723	24	2023-01-01	83024.00
1724	25	2023-01-01	158956.00
1725	26	2023-01-01	47317.00
1726	27	2023-01-01	99734.00
1727	28	2023-01-01	50736.00
1728	29	2023-01-01	116316.00
1729	30	2023-01-01	142430.00
1730	31	2023-01-01	46920.00
1731	32	2023-01-01	121329.00
1732	33	2023-01-01	30011.00
1733	34	2023-01-01	82868.00
1734	35	2023-01-01	83696.00
1735	36	2023-01-01	157205.00
1736	37	2023-01-01	97826.00
1737	38	2023-01-01	148863.00
1738	39	2023-01-01	99403.00
1739	40	2023-01-01	126710.00
1740	41	2023-01-01	155325.00
1741	42	2023-01-01	136849.00
1742	43	2023-01-01	48475.00
1743	44	2023-01-01	118068.00
1744	45	2023-01-01	146733.00
1745	46	2023-01-01	35981.00
1746	47	2023-01-01	45760.00
1747	48	2023-01-01	61086.00
1748	49	2023-01-01	150548.00
1749	50	2023-01-01	130585.00
1750	51	2023-01-01	83945.00
1751	52	2023-01-01	66568.00
1752	53	2023-01-01	61188.00
1753	54	2023-01-01	123448.00
1754	55	2023-01-01	55098.00
1755	56	2023-01-01	30008.00
1756	57	2023-01-01	44500.00
1757	58	2023-01-01	76805.00
1758	59	2023-01-01	54749.00
1759	60	2023-01-01	127963.00
1760	61	2023-01-01	36385.00
1761	62	2023-01-01	94767.00
1762	63	2023-01-01	96941.00
1763	64	2023-01-01	61556.00
1764	65	2023-01-01	123874.00
1765	66	2023-01-01	89442.00
1766	67	2023-01-01	126164.00
1767	68	2023-01-01	143884.00
1768	69	2023-01-01	89719.00
1769	70	2023-01-01	120796.00
1770	71	2023-01-01	68448.00
1771	72	2023-01-01	46221.00
1772	73	2023-01-01	104696.00
1773	74	2023-01-01	156116.00
1774	75	2023-01-01	113083.00
1775	76	2023-01-01	121036.00
1776	77	2023-01-01	45306.00
1777	78	2023-01-01	145990.00
1778	79	2023-01-01	103769.00
1779	80	2023-01-01	100949.00
1780	81	2023-01-01	124764.00
1781	82	2023-01-01	104836.00
1782	83	2023-01-01	85420.00
1783	84	2023-01-01	76301.00
1784	85	2023-01-01	72469.00
1785	86	2023-01-01	71906.00
1786	87	2023-01-01	94215.00
1787	88	2023-01-01	38745.00
1788	89	2023-01-01	84748.00
1789	90	2023-01-01	126701.00
1790	91	2023-01-01	100997.00
1791	92	2023-01-01	117498.00
1792	93	2023-01-01	47487.00
1793	94	2023-01-01	81319.00
1794	95	2023-01-01	129277.00
1795	96	2023-01-01	87853.00
1796	97	2023-01-01	144543.00
1797	98	2023-01-01	115897.00
1798	99	2023-01-01	119051.00
1799	100	2023-01-01	62287.00
1800	1	2023-01-01	96047.00
1801	2	2023-01-01	124898.00
1802	3	2023-01-01	30696.00
1803	4	2023-01-01	153226.00
1804	5	2023-01-01	60118.00
1805	6	2023-01-01	88775.00
1806	7	2023-01-01	99699.00
1807	8	2023-01-01	153575.00
1808	9	2023-01-01	42362.00
1809	10	2023-01-01	117141.00
1810	11	2023-01-01	61495.00
1811	12	2023-01-01	61093.00
1812	13	2023-01-01	79265.00
1813	14	2023-01-01	58008.00
1814	15	2023-01-01	141502.00
1815	16	2023-01-01	107149.00
1816	17	2023-01-01	125629.00
1817	18	2023-01-01	151897.00
1818	19	2023-01-01	81662.00
1819	20	2023-01-01	99974.00
1820	21	2023-01-01	112452.00
1821	22	2023-01-01	49923.00
1822	23	2023-01-01	111237.00
1823	24	2023-01-01	131227.00
1824	25	2023-01-01	151130.00
1825	26	2023-01-01	95481.00
1826	27	2023-01-01	159880.00
1827	28	2023-01-01	138032.00
1828	29	2023-01-01	158606.00
1829	30	2023-01-01	72882.00
1830	31	2023-01-01	36349.00
1831	32	2023-01-01	149626.00
1832	33	2023-01-01	121880.00
1833	34	2023-01-01	66201.00
1834	35	2023-01-01	156997.00
1835	36	2023-01-01	56816.00
1836	37	2023-01-01	81436.00
1837	38	2023-01-01	62184.00
1838	39	2023-01-01	123191.00
1839	40	2023-01-01	110480.00
1840	41	2023-01-01	48101.00
1841	42	2023-01-01	30142.00
1842	43	2023-01-01	35892.00
1843	44	2023-01-01	158185.00
1844	45	2023-01-01	80789.00
1845	46	2023-01-01	68771.00
1846	47	2023-01-01	87661.00
1847	48	2023-01-01	62514.00
1848	49	2023-01-01	49179.00
1849	50	2023-01-01	98532.00
1850	51	2023-01-01	87017.00
1851	52	2023-01-01	143457.00
1852	53	2023-01-01	31521.00
1853	54	2023-01-01	41527.00
1854	55	2023-01-01	102983.00
1855	56	2023-01-01	143311.00
1856	57	2023-01-01	151820.00
1857	58	2023-01-01	92406.00
1858	59	2023-01-01	53147.00
1859	60	2023-01-01	80525.00
1860	61	2023-01-01	98682.00
1861	62	2023-01-01	150443.00
1862	63	2023-01-01	105390.00
1863	64	2023-01-01	120939.00
1864	65	2023-01-01	118661.00
1865	66	2023-01-01	149971.00
1866	67	2023-01-01	108324.00
1867	68	2023-01-01	126985.00
1868	69	2023-01-01	147524.00
1869	70	2023-01-01	150472.00
1870	71	2023-01-01	107010.00
1871	72	2023-01-01	143121.00
1872	73	2023-01-01	109443.00
1873	74	2023-01-01	34098.00
1874	75	2023-01-01	97655.00
1875	76	2023-01-01	70786.00
1876	77	2023-01-01	102205.00
1877	78	2023-01-01	65798.00
1878	79	2023-01-01	88076.00
1879	80	2023-01-01	103704.00
1880	81	2023-01-01	46108.00
1881	82	2023-01-01	96048.00
1882	83	2023-01-01	40895.00
1883	84	2023-01-01	65757.00
1884	85	2023-01-01	148162.00
1885	86	2023-01-01	100388.00
1886	87	2023-01-01	144448.00
1887	88	2023-01-01	34322.00
1888	89	2023-01-01	147654.00
1889	90	2023-01-01	120281.00
1890	91	2023-01-01	70450.00
1891	92	2023-01-01	97386.00
1892	93	2023-01-01	40107.00
1893	94	2023-01-01	66757.00
1894	95	2023-01-01	119198.00
1895	96	2023-01-01	147604.00
1896	97	2023-01-01	151457.00
1897	98	2023-01-01	124456.00
1898	99	2023-01-01	127433.00
1899	100	2023-01-01	69955.00
1900	1	2023-01-01	40404.00
1901	2	2023-01-01	84029.00
1902	3	2023-01-01	32969.00
1903	4	2023-01-01	102338.00
1904	5	2023-01-01	112591.00
1905	6	2023-01-01	125331.00
1906	7	2023-01-01	142163.00
1907	8	2023-01-01	65227.00
1908	9	2023-01-01	118958.00
1909	10	2023-01-01	108957.00
1910	11	2023-01-01	120525.00
1911	12	2023-01-01	44692.00
1912	13	2023-01-01	60741.00
1913	14	2023-01-01	38069.00
1914	15	2023-01-01	67331.00
1915	16	2023-01-01	88781.00
1916	17	2023-01-01	38063.00
1917	18	2023-01-01	57662.00
1918	19	2023-01-01	79219.00
1919	20	2023-01-01	132188.00
1920	21	2023-01-01	150210.00
1921	22	2023-01-01	70322.00
1922	23	2023-01-01	151399.00
1923	24	2023-01-01	94532.00
1924	25	2023-01-01	159631.00
1925	26	2023-01-01	45627.00
2	3	2023-01-01	72730.00
3	4	2023-01-01	59007.00
4	5	2023-01-01	122502.00
5	6	2023-01-01	118933.00
6	7	2023-01-01	47012.00
7	8	2023-01-01	137484.00
8	9	2023-01-01	95873.00
9	10	2023-01-01	70501.00
10	11	2023-01-01	123905.00
11	12	2023-01-01	73803.00
12	13	2023-01-01	149800.00
13	14	2023-01-01	77179.00
14	15	2023-01-01	30170.00
15	16	2023-01-01	62894.00
16	17	2023-01-01	124889.00
17	18	2023-01-01	33821.00
18	19	2023-01-01	111101.00
19	20	2023-01-01	110471.00
20	21	2023-01-01	129466.00
21	22	2023-01-01	146154.00
22	23	2023-01-01	69640.00
23	24	2023-01-01	138500.00
24	25	2023-01-01	75121.00
25	26	2023-01-01	53640.00
26	27	2023-01-01	78911.00
27	28	2023-01-01	42580.00
28	29	2023-01-01	116675.00
29	30	2023-01-01	49723.00
30	31	2023-01-01	130955.00
31	32	2023-01-01	159867.00
32	33	2023-01-01	107684.00
33	34	2023-01-01	61778.00
34	35	2023-01-01	93333.00
35	36	2023-01-01	32629.00
36	37	2023-01-01	122968.00
37	38	2023-01-01	38419.00
38	39	2023-01-01	62157.00
39	40	2023-01-01	67734.00
40	41	2023-01-01	157552.00
41	42	2023-01-01	108328.00
1	2	2023-01-01	5000.00
1926	27	2023-01-01	128412.00
1927	28	2023-01-01	47137.00
1928	29	2023-01-01	46008.00
1929	30	2023-01-01	69630.00
1930	31	2023-01-01	83164.00
1931	32	2023-01-01	149499.00
1932	33	2023-01-01	94825.00
1933	34	2023-01-01	98698.00
1934	35	2023-01-01	39001.00
1935	36	2023-01-01	44523.00
1936	37	2023-01-01	151751.00
1937	38	2023-01-01	38145.00
1938	39	2023-01-01	147277.00
1939	40	2023-01-01	82591.00
1940	41	2023-01-01	115725.00
1941	42	2023-01-01	92307.00
1942	43	2023-01-01	38092.00
1943	44	2023-01-01	129046.00
1944	45	2023-01-01	34886.00
1945	46	2023-01-01	101071.00
1946	47	2023-01-01	152766.00
1947	48	2023-01-01	55898.00
1948	49	2023-01-01	41691.00
1949	50	2023-01-01	41119.00
1950	51	2023-01-01	38024.00
1951	52	2023-01-01	156635.00
1952	53	2023-01-01	60697.00
1953	54	2023-01-01	98700.00
1954	55	2023-01-01	93056.00
1955	56	2023-01-01	119898.00
1956	57	2023-01-01	97810.00
1957	58	2023-01-01	93877.00
1958	59	2023-01-01	159169.00
1959	60	2023-01-01	150383.00
1960	61	2023-01-01	78719.00
1961	62	2023-01-01	93294.00
1962	63	2023-01-01	126862.00
1963	64	2023-01-01	81727.00
1964	65	2023-01-01	139960.00
1965	66	2023-01-01	116531.00
1966	67	2023-01-01	144306.00
1967	68	2023-01-01	141543.00
1968	69	2023-01-01	102169.00
1969	70	2023-01-01	145806.00
1970	71	2023-01-01	101714.00
1971	72	2023-01-01	42940.00
1972	73	2023-01-01	66589.00
1973	74	2023-01-01	99112.00
1974	75	2023-01-01	44957.00
1975	76	2023-01-01	73752.00
1976	77	2023-01-01	49029.00
1977	78	2023-01-01	122621.00
1978	79	2023-01-01	102844.00
1979	80	2023-01-01	52155.00
1980	81	2023-01-01	77804.00
1981	82	2023-01-01	114920.00
1982	83	2023-01-01	71679.00
1983	84	2023-01-01	153473.00
1984	85	2023-01-01	143237.00
1985	86	2023-01-01	51168.00
1986	87	2023-01-01	82696.00
1987	88	2023-01-01	91894.00
1988	89	2023-01-01	148871.00
1989	90	2023-01-01	87338.00
1990	91	2023-01-01	35595.00
1991	92	2023-01-01	95391.00
1992	93	2023-01-01	92584.00
1993	94	2023-01-01	130967.00
1994	95	2023-01-01	89114.00
1995	96	2023-01-01	92890.00
1996	97	2023-01-01	89236.00
1997	98	2023-01-01	105932.00
1998	99	2023-01-01	92907.00
1999	100	2023-01-01	127513.00
2000	1	2023-01-01	73102.00
\.


--
-- Data for Name: referee; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.referee (refereeid, refereename, gender, birthday, prodate) FROM stdin;
1	Howard Webb 1	Male	1980-01-01	2024-01-01
2	Markus Merk 2	Male	1980-01-01	2024-01-01
3	Felix Brych 3	Male	1980-01-01	2024-01-01
4	Cuneyt Cakir 4	Male	1980-01-01	2024-01-01
5	Bjorn Kuipers 5	Male	1980-01-01	2024-01-01
6	Nestor Pitana 6	Male	1980-01-01	2024-01-01
7	Nicola Rizzoli 7	Male	1980-01-01	2024-01-01
8	Mark Clattenburg 8	Male	1980-01-01	2024-01-01
9	Daniele Orsato 9	Male	1980-01-01	2024-01-01
10	Antonio Mateu Lahoz 10	Male	1980-01-01	2024-01-01
11	Szymon Marciniak 11	Male	1980-01-01	2024-01-01
12	Cl??ment Turpin 12	Male	1980-01-01	2024-01-01
13	Anthony Taylor 13	Male	1980-01-01	2024-01-01
14	Michael Oliver 14	Male	1980-01-01	2024-01-01
15	Danny Makkelie 15	Male	1980-01-01	2024-01-01
16	Wilmar Roldan 16	Male	1980-01-01	2024-01-01
17	Bakary Gassama 17	Male	1980-01-01	2024-01-01
18	Victor Gomes 18	Male	1980-01-01	2024-01-01
19	Slavko Vincic 19	Male	1980-01-01	2024-01-01
20	Stephanie Frappart 20	Male	1980-01-01	2024-01-01
21	Facundo Tello 21	Male	1980-01-01	2024-01-01
22	Ismail Elfath 22	Male	1980-01-01	2024-01-01
67	Bakary Gassama 67	Male	1980-01-01	2024-01-01
68	Victor Gomes 68	Male	1980-01-01	2024-01-01
69	Slavko Vincic 69	Male	1980-01-01	2024-01-01
70	Stephanie Frappart 70	Male	1980-01-01	2024-01-01
71	Facundo Tello 71	Male	1980-01-01	2024-01-01
72	Ismail Elfath 72	Male	1980-01-01	2024-01-01
73	Chris Beath 73	Male	1980-01-01	2024-01-01
74	Mustapha Ghorbal 74	Male	1980-01-01	2024-01-01
75	Pierluigi Collina 75	Male	1980-01-01	2024-01-01
76	Howard Webb 76	Male	1980-01-01	2024-01-01
77	Markus Merk 77	Male	1980-01-01	2024-01-01
78	Felix Brych 78	Male	1980-01-01	2024-01-01
79	Cuneyt Cakir 79	Male	1980-01-01	2024-01-01
80	Bjorn Kuipers 80	Male	1980-01-01	2024-01-01
81	Nestor Pitana 81	Male	1980-01-01	2024-01-01
82	Nicola Rizzoli 82	Male	1980-01-01	2024-01-01
83	Mark Clattenburg 83	Male	1980-01-01	2024-01-01
84	Daniele Orsato 84	Male	1980-01-01	2024-01-01
85	Antonio Mateu Lahoz 85	Male	1980-01-01	2024-01-01
86	Szymon Marciniak 86	Male	1980-01-01	2024-01-01
87	Cl??ment Turpin 87	Male	1980-01-01	2024-01-01
88	Anthony Taylor 88	Male	1980-01-01	2024-01-01
89	Michael Oliver 89	Male	1980-01-01	2024-01-01
90	Danny Makkelie 90	Male	1980-01-01	2024-01-01
91	Wilmar Roldan 91	Male	1980-01-01	2024-01-01
92	Bakary Gassama 92	Male	1980-01-01	2024-01-01
93	Victor Gomes 93	Male	1980-01-01	2024-01-01
94	Slavko Vincic 94	Male	1980-01-01	2024-01-01
95	Stephanie Frappart 95	Male	1980-01-01	2024-01-01
96	Facundo Tello 96	Male	1980-01-01	2024-01-01
97	Ismail Elfath 97	Male	1980-01-01	2024-01-01
98	Chris Beath 98	Male	1980-01-01	2024-01-01
99	Mustapha Ghorbal 99	Male	1980-01-01	2024-01-01
100	Pierluigi Collina 100	Male	1980-01-01	2024-01-01
23	Chris Beath 23	Male	1980-01-01	2024-01-01
24	Mustapha Ghorbal 24	Male	1980-01-01	2024-01-01
25	Pierluigi Collina 25	Male	1980-01-01	2024-01-01
26	Howard Webb 26	Male	1980-01-01	2024-01-01
27	Markus Merk 27	Male	1980-01-01	2024-01-01
28	Felix Brych 28	Male	1980-01-01	2024-01-01
29	Cuneyt Cakir 29	Male	1980-01-01	2024-01-01
30	Bjorn Kuipers 30	Male	1980-01-01	2024-01-01
31	Nestor Pitana 31	Male	1980-01-01	2024-01-01
32	Nicola Rizzoli 32	Male	1980-01-01	2024-01-01
33	Mark Clattenburg 33	Male	1980-01-01	2024-01-01
34	Daniele Orsato 34	Male	1980-01-01	2024-01-01
35	Antonio Mateu Lahoz 35	Male	1980-01-01	2024-01-01
36	Szymon Marciniak 36	Male	1980-01-01	2024-01-01
37	Cl??ment Turpin 37	Male	1980-01-01	2024-01-01
38	Anthony Taylor 38	Male	1980-01-01	2024-01-01
39	Michael Oliver 39	Male	1980-01-01	2024-01-01
40	Danny Makkelie 40	Male	1980-01-01	2024-01-01
41	Wilmar Roldan 41	Male	1980-01-01	2024-01-01
42	Bakary Gassama 42	Male	1980-01-01	2024-01-01
43	Victor Gomes 43	Male	1980-01-01	2024-01-01
44	Slavko Vincic 44	Male	1980-01-01	2024-01-01
45	Stephanie Frappart 45	Male	1980-01-01	2024-01-01
46	Facundo Tello 46	Male	1980-01-01	2024-01-01
47	Ismail Elfath 47	Male	1980-01-01	2024-01-01
48	Chris Beath 48	Male	1980-01-01	2024-01-01
49	Mustapha Ghorbal 49	Male	1980-01-01	2024-01-01
50	Pierluigi Collina 50	Male	1980-01-01	2024-01-01
51	Howard Webb 51	Male	1980-01-01	2024-01-01
52	Markus Merk 52	Male	1980-01-01	2024-01-01
53	Felix Brych 53	Male	1980-01-01	2024-01-01
54	Cuneyt Cakir 54	Male	1980-01-01	2024-01-01
55	Bjorn Kuipers 55	Male	1980-01-01	2024-01-01
56	Nestor Pitana 56	Male	1980-01-01	2024-01-01
57	Nicola Rizzoli 57	Male	1980-01-01	2024-01-01
58	Mark Clattenburg 58	Male	1980-01-01	2024-01-01
59	Daniele Orsato 59	Male	1980-01-01	2024-01-01
60	Antonio Mateu Lahoz 60	Male	1980-01-01	2024-01-01
61	Szymon Marciniak 61	Male	1980-01-01	2024-01-01
62	Cl??ment Turpin 62	Male	1980-01-01	2024-01-01
63	Anthony Taylor 63	Male	1980-01-01	2024-01-01
64	Michael Oliver 64	Male	1980-01-01	2024-01-01
65	Danny Makkelie 65	Male	1980-01-01	2024-01-01
66	Wilmar Roldan 66	Male	1980-01-01	2024-01-01
\.


--
-- Data for Name: refereeat; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.refereeat (matchid, refereeid) FROM stdin;
1	2
2	3
3	4
4	5
5	6
6	7
7	8
8	9
9	10
10	11
11	12
12	13
13	14
14	15
15	16
16	17
17	18
18	19
19	20
20	21
21	22
22	23
23	24
24	25
25	26
26	27
27	28
28	29
29	30
30	31
31	32
32	33
33	34
34	35
35	36
36	37
37	38
38	39
39	40
40	41
41	42
42	43
43	44
44	45
45	46
46	47
47	48
48	49
49	50
50	51
51	52
52	53
53	54
54	55
55	56
56	57
57	58
58	59
59	60
60	61
61	62
62	63
63	64
64	65
65	66
66	67
67	68
68	69
69	70
70	71
71	72
72	73
73	74
74	75
75	76
76	77
77	78
78	79
79	80
80	81
81	82
82	83
83	84
84	85
85	86
86	87
87	88
88	89
89	90
90	91
91	92
92	93
93	94
94	95
95	96
96	97
97	98
98	99
99	100
100	1
101	2
102	3
103	4
104	5
105	6
106	7
107	8
108	9
109	10
110	11
111	12
112	13
113	14
114	15
115	16
116	17
117	18
118	19
119	20
120	21
121	22
122	23
123	24
124	25
125	26
126	27
127	28
128	29
129	30
130	31
131	32
132	33
133	34
134	35
135	36
136	37
137	38
138	39
139	40
140	41
141	42
142	43
143	44
144	45
145	46
146	47
147	48
148	49
149	50
150	51
151	52
152	53
153	54
154	55
155	56
156	57
157	58
158	59
159	60
160	61
161	62
162	63
163	64
164	65
165	66
166	67
167	68
168	69
169	70
170	71
171	72
172	73
173	74
174	75
175	76
176	77
177	78
178	79
179	80
180	81
181	82
182	83
183	84
184	85
185	86
186	87
187	88
188	89
189	90
190	91
191	92
192	93
193	94
194	95
195	96
196	97
197	98
198	99
199	100
200	1
201	2
202	3
203	4
204	5
205	6
206	7
207	8
208	9
209	10
210	11
211	12
212	13
213	14
214	15
215	16
216	17
217	18
218	19
219	20
220	21
221	22
222	23
223	24
224	25
225	26
226	27
227	28
228	29
229	30
230	31
231	32
232	33
233	34
234	35
235	36
236	37
237	38
238	39
239	40
240	41
241	42
242	43
243	44
244	45
245	46
246	47
247	48
248	49
249	50
250	51
251	52
252	53
253	54
254	55
255	56
256	57
257	58
258	59
259	60
260	61
261	62
262	63
263	64
264	65
265	66
266	67
267	68
268	69
269	70
270	71
271	72
272	73
273	74
274	75
275	76
276	77
277	78
278	79
279	80
280	81
281	82
282	83
283	84
284	85
285	86
286	87
287	88
288	89
289	90
290	91
291	92
292	93
293	94
294	95
295	96
296	97
297	98
298	99
299	100
300	1
301	2
302	3
303	4
304	5
305	6
306	7
307	8
308	9
309	10
310	11
311	12
312	13
313	14
314	15
315	16
316	17
317	18
318	19
319	20
320	21
321	22
322	23
323	24
324	25
325	26
326	27
327	28
328	29
329	30
330	31
331	32
332	33
333	34
334	35
335	36
336	37
337	38
338	39
339	40
340	41
341	42
342	43
343	44
344	45
345	46
346	47
347	48
348	49
349	50
350	51
351	52
352	53
353	54
354	55
355	56
356	57
357	58
358	59
359	60
360	61
361	62
362	63
363	64
364	65
365	66
366	67
367	68
368	69
369	70
370	71
371	72
372	73
373	74
374	75
375	76
376	77
377	78
378	79
379	80
380	81
381	82
382	83
383	84
384	85
385	86
386	87
387	88
388	89
389	90
390	91
391	92
392	93
393	94
394	95
395	96
396	97
397	98
398	99
399	100
400	1
401	2
402	3
403	4
404	5
405	6
406	7
407	8
408	9
409	10
410	11
411	12
412	13
413	14
414	15
415	16
416	17
417	18
418	19
419	20
420	21
421	22
422	23
423	24
424	25
425	26
426	27
427	28
428	29
429	30
430	31
431	32
432	33
433	34
434	35
435	36
436	37
437	38
438	39
439	40
440	41
441	42
442	43
443	44
444	45
445	46
446	47
447	48
448	49
449	50
450	51
451	52
452	53
453	54
454	55
455	56
456	57
457	58
458	59
459	60
460	61
461	62
462	63
463	64
464	65
465	66
466	67
467	68
468	69
469	70
470	71
471	72
472	73
473	74
474	75
475	76
476	77
477	78
478	79
479	80
480	81
481	82
482	83
483	84
484	85
485	86
486	87
487	88
488	89
489	90
490	91
491	92
492	93
493	94
494	95
495	96
496	97
497	98
498	99
499	100
500	1
\.


--
-- Data for Name: stadium; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.stadium (stadiumid, stadiumname, city, capacity, yearfounded) FROM stdin;
2	Santiago Bernabeu 2	Madrid	93264	1982
4	Anfield 4	Liverpool	51925	1917
5	Maracana 5	Rio de Janeiro	57576	2011
6	Allianz Arena 6	Munich	93267	1962
7	Old Trafford 7	Manchester	71655	1962
8	San Siro 8	Milan	61929	1935
9	Lusail Stadium 9	Lusail	46252	1914
10	Estadio Azteca 10	Mexico City	41003	1916
11	Signal Iduna Park 11	Dortmund	46983	1923
12	Etihad Stadium 12	Manchester	40393	1927
15	Johan Cruyff Arena 15	Amsterdam	62332	2021
16	Stade de France 16	Paris	58480	2006
17	Metropolitano Stadium 17	Madrid	84883	1956
19	Veltins-Arena 19	Gelsenkirchen	78609	1963
20	Estadio da Luz 20	Lisbon	79261	1936
21	Giuseppe Meazza 21	Milan	59044	1941
22	Celtic Park 22	Glasgow	61044	1955
23	Ibrox Stadium 23	Glasgow	84900	1982
24	Estadio Monumental 24	Buenos Aires	90616	1951
25	La Bombonera 25	Buenos Aires	78913	1989
26	Mercedes-Benz Stadium 26	Atlanta	61796	2012
27	SoFi Stadium 27	Inglewood	89829	1986
28	Camp Nou 28	Barcelona	62886	1987
29	Santiago Bernabeu 29	Madrid	69250	1993
31	Anfield 31	Liverpool	70769	1989
32	Maracana 32	Rio de Janeiro	85697	1997
33	Allianz Arena 33	Munich	73269	1971
34	Old Trafford 34	Manchester	65442	1999
35	San Siro 35	Milan	76141	2020
36	Lusail Stadium 36	Lusail	69972	1973
37	Estadio Azteca 37	Mexico City	59068	1912
38	Signal Iduna Park 38	Dortmund	67685	1933
39	Etihad Stadium 39	Manchester	65353	2013
42	Johan Cruyff Arena 42	Amsterdam	69965	1940
43	Stade de France 43	Paris	52458	2004
44	Metropolitano Stadium 44	Madrid	70309	2001
46	Veltins-Arena 46	Gelsenkirchen	39425	1996
47	Estadio da Luz 47	Lisbon	82486	2011
48	Giuseppe Meazza 48	Milan	72499	1919
49	Celtic Park 49	Glasgow	60327	2011
50	Ibrox Stadium 50	Glasgow	84204	1915
51	Estadio Monumental 51	Buenos Aires	84256	1976
52	La Bombonera 52	Buenos Aires	75514	1972
53	Mercedes-Benz Stadium 53	Atlanta	82790	1954
54	SoFi Stadium 54	Inglewood	70424	1944
55	Camp Nou 55	Barcelona	66497	1922
56	Santiago Bernabeu 56	Madrid	77718	1998
58	Anfield 58	Liverpool	75421	1973
59	Maracana 59	Rio de Janeiro	45806	1918
60	Allianz Arena 60	Munich	42237	1979
61	Old Trafford 61	Manchester	90242	1979
62	San Siro 62	Milan	39652	1935
63	Lusail Stadium 63	Lusail	70952	1945
64	Estadio Azteca 64	Mexico City	80854	1926
65	Signal Iduna Park 65	Dortmund	68721	1931
66	Etihad Stadium 66	Manchester	60583	2020
69	Johan Cruyff Arena 69	Amsterdam	87409	1947
70	Stade de France 70	Paris	80616	2022
71	Metropolitano Stadium 71	Madrid	61213	1918
73	Veltins-Arena 73	Gelsenkirchen	76341	1917
74	Estadio da Luz 74	Lisbon	77763	1938
75	Giuseppe Meazza 75	Milan	71323	1967
76	Celtic Park 76	Glasgow	38036	1976
77	Ibrox Stadium 77	Glasgow	79646	1911
78	Estadio Monumental 78	Buenos Aires	47457	1931
79	La Bombonera 79	Buenos Aires	45695	1962
80	Mercedes-Benz Stadium 80	Atlanta	50155	1912
81	SoFi Stadium 81	Inglewood	85506	1957
82	Camp Nou 82	Barcelona	53418	2015
83	Santiago Bernabeu 83	Madrid	47553	1982
85	Anfield 85	Liverpool	40459	1972
86	Maracana 86	Rio de Janeiro	44041	1940
87	Allianz Arena 87	Munich	57535	1911
88	Old Trafford 88	Manchester	86212	1945
89	San Siro 89	Milan	50271	2006
90	Lusail Stadium 90	Lusail	92646	1915
91	Estadio Azteca 91	Mexico City	77184	1955
92	Signal Iduna Park 92	Dortmund	78514	1978
93	Etihad Stadium 93	Manchester	46817	1987
96	Johan Cruyff Arena 96	Amsterdam	69909	1976
97	Stade de France 97	Paris	79147	1916
98	Metropolitano Stadium 98	Madrid	66366	1952
100	Veltins-Arena 100	Gelsenkirchen	66121	2004
101	Estadio da Luz 101	Lisbon	87668	1967
102	Giuseppe Meazza 102	Milan	55705	1977
103	Celtic Park 103	Glasgow	41015	1947
104	Ibrox Stadium 104	Glasgow	69355	1946
105	Estadio Monumental 105	Buenos Aires	59466	1953
106	La Bombonera 106	Buenos Aires	53594	1949
107	Mercedes-Benz Stadium 107	Atlanta	94556	1932
108	SoFi Stadium 108	Inglewood	59546	1911
109	Camp Nou 109	Barcelona	90172	1972
110	Santiago Bernabeu 110	Madrid	75033	1988
112	Anfield 112	Liverpool	51212	1927
113	Maracana 113	Rio de Janeiro	46650	1968
114	Allianz Arena 114	Munich	58900	1987
115	Old Trafford 115	Manchester	81848	1927
116	San Siro 116	Milan	37460	1971
1	Camp Nou 1	London City	93478	2014
117	Lusail Stadium 117	Lusail	45642	1920
118	Estadio Azteca 118	Mexico City	92476	1940
119	Signal Iduna Park 119	Dortmund	61282	1985
120	Etihad Stadium 120	Manchester	56926	1998
123	Johan Cruyff Arena 123	Amsterdam	82607	1910
124	Stade de France 124	Paris	37610	1911
125	Metropolitano Stadium 125	Madrid	68920	1931
127	Veltins-Arena 127	Gelsenkirchen	49136	2021
128	Estadio da Luz 128	Lisbon	70146	1990
129	Giuseppe Meazza 129	Milan	75704	1997
130	Celtic Park 130	Glasgow	87623	1941
131	Ibrox Stadium 131	Glasgow	72503	2010
132	Estadio Monumental 132	Buenos Aires	36051	2003
133	La Bombonera 133	Buenos Aires	86127	1986
134	Mercedes-Benz Stadium 134	Atlanta	75244	1949
135	SoFi Stadium 135	Inglewood	76835	1971
136	Camp Nou 136	Barcelona	37032	2022
137	Santiago Bernabeu 137	Madrid	75783	1976
139	Anfield 139	Liverpool	50266	1936
140	Maracana 140	Rio de Janeiro	93257	1931
141	Allianz Arena 141	Munich	49123	1973
142	Old Trafford 142	Manchester	62307	2009
143	San Siro 143	Milan	36915	1999
144	Lusail Stadium 144	Lusail	36128	1920
145	Estadio Azteca 145	Mexico City	86090	2013
146	Signal Iduna Park 146	Dortmund	67822	1915
147	Etihad Stadium 147	Manchester	65624	1996
150	Johan Cruyff Arena 150	Amsterdam	59465	2020
151	Stade de France 151	Paris	56584	2011
152	Metropolitano Stadium 152	Madrid	66580	1954
154	Veltins-Arena 154	Gelsenkirchen	86978	2010
155	Estadio da Luz 155	Lisbon	93795	1914
156	Giuseppe Meazza 156	Milan	46904	1911
157	Celtic Park 157	Glasgow	68684	1965
158	Ibrox Stadium 158	Glasgow	82397	1958
159	Estadio Monumental 159	Buenos Aires	91276	2009
160	La Bombonera 160	Buenos Aires	41435	1916
161	Mercedes-Benz Stadium 161	Atlanta	62262	2014
162	SoFi Stadium 162	Inglewood	69560	1957
163	Camp Nou 163	Barcelona	86541	1961
164	Santiago Bernabeu 164	Madrid	62440	1938
166	Anfield 166	Liverpool	35161	1992
167	Maracana 167	Rio de Janeiro	83415	1961
168	Allianz Arena 168	Munich	83977	1956
169	Old Trafford 169	Manchester	38238	1955
170	San Siro 170	Milan	65815	1959
171	Lusail Stadium 171	Lusail	44219	1966
172	Estadio Azteca 172	Mexico City	37704	1972
173	Signal Iduna Park 173	Dortmund	50366	1952
174	Etihad Stadium 174	Manchester	51256	1922
177	Johan Cruyff Arena 177	Amsterdam	66025	1933
178	Stade de France 178	Paris	85927	1919
179	Metropolitano Stadium 179	Madrid	64867	1940
181	Veltins-Arena 181	Gelsenkirchen	69626	1930
182	Estadio da Luz 182	Lisbon	49797	1981
183	Giuseppe Meazza 183	Milan	35853	1913
184	Celtic Park 184	Glasgow	59505	1947
185	Ibrox Stadium 185	Glasgow	94439	1976
186	Estadio Monumental 186	Buenos Aires	84063	1930
187	La Bombonera 187	Buenos Aires	79810	2012
188	Mercedes-Benz Stadium 188	Atlanta	61064	2008
189	SoFi Stadium 189	Inglewood	42106	1933
190	Camp Nou 190	Barcelona	41997	1968
191	Santiago Bernabeu 191	Madrid	44028	1966
193	Anfield 193	Liverpool	48241	1985
194	Maracana 194	Rio de Janeiro	63362	1987
195	Allianz Arena 195	Munich	74960	1981
196	Old Trafford 196	Manchester	52017	1953
197	San Siro 197	Milan	35714	1991
198	Lusail Stadium 198	Lusail	57202	1996
199	Estadio Azteca 199	Mexico City	54136	1912
200	Signal Iduna Park 200	Dortmund	41804	1943
201	Etihad Stadium 201	Manchester	49017	1928
204	Johan Cruyff Arena 204	Amsterdam	47727	1925
205	Stade de France 205	Paris	70511	1974
206	Metropolitano Stadium 206	Madrid	51370	1977
208	Veltins-Arena 208	Gelsenkirchen	59478	1955
209	Estadio da Luz 209	Lisbon	49444	1993
210	Giuseppe Meazza 210	Milan	60501	1932
211	Celtic Park 211	Glasgow	81192	1912
212	Ibrox Stadium 212	Glasgow	90114	1913
213	Estadio Monumental 213	Buenos Aires	72367	1977
214	La Bombonera 214	Buenos Aires	67799	1970
215	Mercedes-Benz Stadium 215	Atlanta	66366	1986
216	SoFi Stadium 216	Inglewood	57418	1965
217	Camp Nou 217	Barcelona	66610	1911
218	Santiago Bernabeu 218	Madrid	82681	1931
220	Anfield 220	Liverpool	88060	1933
221	Maracana 221	Rio de Janeiro	48684	1930
222	Allianz Arena 222	Munich	77036	2001
223	Old Trafford 223	Manchester	40205	1999
224	San Siro 224	Milan	44055	2020
225	Lusail Stadium 225	Lusail	43850	1962
226	Estadio Azteca 226	Mexico City	52678	1985
227	Signal Iduna Park 227	Dortmund	76659	1910
228	Etihad Stadium 228	Manchester	55186	1998
231	Johan Cruyff Arena 231	Amsterdam	81835	1948
232	Stade de France 232	Paris	50210	2018
233	Metropolitano Stadium 233	Madrid	92965	1997
235	Veltins-Arena 235	Gelsenkirchen	85852	1913
236	Estadio da Luz 236	Lisbon	93054	2002
237	Giuseppe Meazza 237	Milan	92199	1981
238	Celtic Park 238	Glasgow	92790	1972
239	Ibrox Stadium 239	Glasgow	89220	2017
240	Estadio Monumental 240	Buenos Aires	62392	2017
241	La Bombonera 241	Buenos Aires	81965	1937
242	Mercedes-Benz Stadium 242	Atlanta	60770	1981
243	SoFi Stadium 243	Inglewood	89409	1931
244	Camp Nou 244	Barcelona	50469	1975
245	Santiago Bernabeu 245	Madrid	72802	1975
247	Anfield 247	Liverpool	43807	2016
248	Maracana 248	Rio de Janeiro	78058	2002
249	Allianz Arena 249	Munich	70591	2007
250	Old Trafford 250	Manchester	42387	1943
251	San Siro 251	Milan	73347	2008
252	Lusail Stadium 252	Lusail	56582	2006
253	Estadio Azteca 253	Mexico City	87704	1974
254	Signal Iduna Park 254	Dortmund	85572	1927
255	Etihad Stadium 255	Manchester	67015	2005
258	Johan Cruyff Arena 258	Amsterdam	77906	1932
259	Stade de France 259	Paris	90543	1929
260	Metropolitano Stadium 260	Madrid	35539	2005
262	Veltins-Arena 262	Gelsenkirchen	48888	2011
263	Estadio da Luz 263	Lisbon	72790	2009
264	Giuseppe Meazza 264	Milan	74713	1947
265	Celtic Park 265	Glasgow	81162	1950
266	Ibrox Stadium 266	Glasgow	76387	2014
267	Estadio Monumental 267	Buenos Aires	49907	1992
268	La Bombonera 268	Buenos Aires	49926	2014
269	Mercedes-Benz Stadium 269	Atlanta	74888	1975
270	SoFi Stadium 270	Inglewood	93074	1951
271	Camp Nou 271	Barcelona	89676	1920
272	Santiago Bernabeu 272	Madrid	57158	2007
274	Anfield 274	Liverpool	57630	2008
275	Maracana 275	Rio de Janeiro	67204	1999
276	Allianz Arena 276	Munich	45761	2014
277	Old Trafford 277	Manchester	57059	2010
278	San Siro 278	Milan	47709	1973
279	Lusail Stadium 279	Lusail	86432	2005
280	Estadio Azteca 280	Mexico City	38810	1984
281	Signal Iduna Park 281	Dortmund	47502	1947
282	Etihad Stadium 282	Manchester	81817	1953
285	Johan Cruyff Arena 285	Amsterdam	64721	2017
286	Stade de France 286	Paris	80392	1980
287	Metropolitano Stadium 287	Madrid	80434	1939
289	Veltins-Arena 289	Gelsenkirchen	83198	1991
290	Estadio da Luz 290	Lisbon	84254	2012
291	Giuseppe Meazza 291	Milan	57661	2005
292	Celtic Park 292	Glasgow	62277	1928
293	Ibrox Stadium 293	Glasgow	56956	2004
294	Estadio Monumental 294	Buenos Aires	37339	1964
295	La Bombonera 295	Buenos Aires	62002	1981
296	Mercedes-Benz Stadium 296	Atlanta	84828	1945
297	SoFi Stadium 297	Inglewood	48760	1988
298	Camp Nou 298	Barcelona	52369	1981
299	Santiago Bernabeu 299	Madrid	80633	1920
301	Anfield 301	Liverpool	39709	1990
302	Maracana 302	Rio de Janeiro	54472	1975
303	Allianz Arena 303	Munich	44268	1943
304	Old Trafford 304	Manchester	80142	1989
305	San Siro 305	Milan	80964	2008
306	Lusail Stadium 306	Lusail	87806	1934
307	Estadio Azteca 307	Mexico City	46293	1971
308	Signal Iduna Park 308	Dortmund	60190	2018
309	Etihad Stadium 309	Manchester	74207	1974
312	Johan Cruyff Arena 312	Amsterdam	77394	1978
313	Stade de France 313	Paris	93795	1971
314	Metropolitano Stadium 314	Madrid	67123	1926
316	Veltins-Arena 316	Gelsenkirchen	47213	1949
317	Estadio da Luz 317	Lisbon	88804	1915
318	Giuseppe Meazza 318	Milan	55512	2017
319	Celtic Park 319	Glasgow	55580	1999
320	Ibrox Stadium 320	Glasgow	57976	1934
321	Estadio Monumental 321	Buenos Aires	54375	1921
322	La Bombonera 322	Buenos Aires	48124	1931
323	Mercedes-Benz Stadium 323	Atlanta	49619	1967
324	SoFi Stadium 324	Inglewood	88830	2007
325	Camp Nou 325	Barcelona	91984	2018
326	Santiago Bernabeu 326	Madrid	77997	1997
328	Anfield 328	Liverpool	62112	1953
329	Maracana 329	Rio de Janeiro	51435	2012
330	Allianz Arena 330	Munich	50409	2014
331	Old Trafford 331	Manchester	57279	1981
332	San Siro 332	Milan	75314	2015
333	Lusail Stadium 333	Lusail	58263	2008
334	Estadio Azteca 334	Mexico City	49025	1950
335	Signal Iduna Park 335	Dortmund	63110	1994
336	Etihad Stadium 336	Manchester	35908	2010
339	Johan Cruyff Arena 339	Amsterdam	35159	1939
340	Stade de France 340	Paris	68619	1994
341	Metropolitano Stadium 341	Madrid	39588	2001
343	Veltins-Arena 343	Gelsenkirchen	47856	2000
344	Estadio da Luz 344	Lisbon	50839	1943
345	Giuseppe Meazza 345	Milan	66822	1942
346	Celtic Park 346	Glasgow	49454	1980
347	Ibrox Stadium 347	Glasgow	36880	1934
348	Estadio Monumental 348	Buenos Aires	58939	1922
349	La Bombonera 349	Buenos Aires	56934	1929
350	Mercedes-Benz Stadium 350	Atlanta	43260	1964
351	SoFi Stadium 351	Inglewood	57220	1964
352	Camp Nou 352	Barcelona	88840	1925
353	Santiago Bernabeu 353	Madrid	51668	1978
355	Anfield 355	Liverpool	47188	1919
356	Maracana 356	Rio de Janeiro	40087	1980
357	Allianz Arena 357	Munich	54526	1972
358	Old Trafford 358	Manchester	40436	1952
359	San Siro 359	Milan	37058	1945
360	Lusail Stadium 360	Lusail	63130	1944
361	Estadio Azteca 361	Mexico City	40191	1940
362	Signal Iduna Park 362	Dortmund	71373	1956
363	Etihad Stadium 363	Manchester	84246	2012
366	Johan Cruyff Arena 366	Amsterdam	73232	1960
367	Stade de France 367	Paris	35143	1995
368	Metropolitano Stadium 368	Madrid	80328	2007
370	Veltins-Arena 370	Gelsenkirchen	37882	1972
371	Estadio da Luz 371	Lisbon	91370	1997
372	Giuseppe Meazza 372	Milan	41529	1950
373	Celtic Park 373	Glasgow	42132	1954
374	Ibrox Stadium 374	Glasgow	48253	2012
375	Estadio Monumental 375	Buenos Aires	90199	2000
376	La Bombonera 376	Buenos Aires	36236	2013
377	Mercedes-Benz Stadium 377	Atlanta	94023	1912
378	SoFi Stadium 378	Inglewood	56677	1960
379	Camp Nou 379	Barcelona	57898	2000
380	Santiago Bernabeu 380	Madrid	80346	1992
382	Anfield 382	Liverpool	74551	1983
383	Maracana 383	Rio de Janeiro	36973	1960
384	Allianz Arena 384	Munich	84149	2001
385	Old Trafford 385	Manchester	36266	1969
386	San Siro 386	Milan	70900	1936
387	Lusail Stadium 387	Lusail	51012	1955
388	Estadio Azteca 388	Mexico City	76060	1949
389	Signal Iduna Park 389	Dortmund	85314	1980
390	Etihad Stadium 390	Manchester	36607	1913
393	Johan Cruyff Arena 393	Amsterdam	89367	1965
394	Stade de France 394	Paris	66130	1955
395	Metropolitano Stadium 395	Madrid	40438	1936
397	Veltins-Arena 397	Gelsenkirchen	76726	1922
398	Estadio da Luz 398	Lisbon	70670	1927
399	Giuseppe Meazza 399	Milan	49823	1989
400	Celtic Park 400	Glasgow	91718	1920
401	Ibrox Stadium 401	Glasgow	59570	2010
402	Estadio Monumental 402	Buenos Aires	59154	2003
403	La Bombonera 403	Buenos Aires	87217	2009
404	Mercedes-Benz Stadium 404	Atlanta	83693	1988
405	SoFi Stadium 405	Inglewood	94635	1958
406	Camp Nou 406	Barcelona	72292	1915
407	Santiago Bernabeu 407	Madrid	85941	1930
409	Anfield 409	Liverpool	75284	1964
410	Maracana 410	Rio de Janeiro	56574	1912
411	Allianz Arena 411	Munich	63371	1977
412	Old Trafford 412	Manchester	70178	1965
413	San Siro 413	Milan	91765	1934
414	Lusail Stadium 414	Lusail	43780	1984
415	Estadio Azteca 415	Mexico City	37904	1992
416	Signal Iduna Park 416	Dortmund	69005	1989
417	Etihad Stadium 417	Manchester	69284	1939
420	Johan Cruyff Arena 420	Amsterdam	76195	2004
421	Stade de France 421	Paris	81322	2000
422	Metropolitano Stadium 422	Madrid	64389	1972
424	Veltins-Arena 424	Gelsenkirchen	86343	1955
425	Estadio da Luz 425	Lisbon	68095	1954
426	Giuseppe Meazza 426	Milan	58814	1920
427	Celtic Park 427	Glasgow	35068	1934
428	Ibrox Stadium 428	Glasgow	37890	1973
429	Estadio Monumental 429	Buenos Aires	72360	1940
430	La Bombonera 430	Buenos Aires	91389	1947
431	Mercedes-Benz Stadium 431	Atlanta	81704	1949
432	SoFi Stadium 432	Inglewood	86814	1956
433	Camp Nou 433	Barcelona	41805	1970
434	Santiago Bernabeu 434	Madrid	64191	1926
436	Anfield 436	Liverpool	85464	1996
437	Maracana 437	Rio de Janeiro	92103	1921
438	Allianz Arena 438	Munich	54897	1929
439	Old Trafford 439	Manchester	64806	1927
440	San Siro 440	Milan	56732	2007
441	Lusail Stadium 441	Lusail	79012	2001
442	Estadio Azteca 442	Mexico City	93701	1985
443	Signal Iduna Park 443	Dortmund	68120	2018
444	Etihad Stadium 444	Manchester	64032	1933
447	Johan Cruyff Arena 447	Amsterdam	55114	1975
448	Stade de France 448	Paris	55433	1913
449	Metropolitano Stadium 449	Madrid	39769	1933
451	Veltins-Arena 451	Gelsenkirchen	45070	1955
452	Estadio da Luz 452	Lisbon	67495	1956
453	Giuseppe Meazza 453	Milan	54045	2006
454	Celtic Park 454	Glasgow	73410	2004
455	Ibrox Stadium 455	Glasgow	84860	1963
456	Estadio Monumental 456	Buenos Aires	45980	1981
457	La Bombonera 457	Buenos Aires	57272	1956
458	Mercedes-Benz Stadium 458	Atlanta	51579	1981
459	SoFi Stadium 459	Inglewood	72775	1985
460	Camp Nou 460	Barcelona	92175	1911
461	Santiago Bernabeu 461	Madrid	85514	1982
463	Anfield 463	Liverpool	45070	1912
464	Maracana 464	Rio de Janeiro	53292	1960
465	Allianz Arena 465	Munich	49844	1928
466	Old Trafford 466	Manchester	70831	1940
467	San Siro 467	Milan	37828	1990
468	Lusail Stadium 468	Lusail	37702	1967
469	Estadio Azteca 469	Mexico City	36647	1952
470	Signal Iduna Park 470	Dortmund	53258	1943
471	Etihad Stadium 471	Manchester	61907	1985
474	Johan Cruyff Arena 474	Amsterdam	74765	1961
475	Stade de France 475	Paris	39583	1981
476	Metropolitano Stadium 476	Madrid	75970	1966
478	Veltins-Arena 478	Gelsenkirchen	53998	1912
479	Estadio da Luz 479	Lisbon	40666	2006
480	Giuseppe Meazza 480	Milan	74153	1964
481	Celtic Park 481	Glasgow	63120	1965
482	Ibrox Stadium 482	Glasgow	54597	1941
483	Estadio Monumental 483	Buenos Aires	62397	2011
484	La Bombonera 484	Buenos Aires	61442	2022
485	Mercedes-Benz Stadium 485	Atlanta	81973	1989
486	SoFi Stadium 486	Inglewood	38944	1959
487	Camp Nou 487	Barcelona	42435	1942
488	Santiago Bernabeu 488	Madrid	86641	1978
490	Anfield 490	Liverpool	94746	1933
491	Maracana 491	Rio de Janeiro	82949	1977
492	Allianz Arena 492	Munich	63483	2009
493	Old Trafford 493	Manchester	88017	1942
494	San Siro 494	Milan	74870	1976
495	Lusail Stadium 495	Lusail	46481	1982
496	Estadio Azteca 496	Mexico City	80442	1977
497	Signal Iduna Park 497	Dortmund	56580	1951
498	Etihad Stadium 498	Manchester	76305	1971
3	Wembley Stadium 3	London City	39627	1939
13	Emirates Stadium 13	London City	42195	1974
14	Stamford Bridge 14	London City	55387	1915
18	Tottenham Hotspur Stadium 18	London City	79339	1992
30	Wembley Stadium 30	London City	78397	1965
40	Emirates Stadium 40	London City	62287	1930
41	Stamford Bridge 41	London City	65482	1974
45	Tottenham Hotspur Stadium 45	London City	90683	1946
57	Wembley Stadium 57	London City	67737	1913
67	Emirates Stadium 67	London City	82476	1942
68	Stamford Bridge 68	London City	35386	1967
72	Tottenham Hotspur Stadium 72	London City	78477	1971
84	Wembley Stadium 84	London City	83756	2005
94	Emirates Stadium 94	London City	80808	1942
95	Stamford Bridge 95	London City	40241	2016
99	Tottenham Hotspur Stadium 99	London City	66652	1969
111	Wembley Stadium 111	London City	77624	1914
121	Emirates Stadium 121	London City	53572	1970
122	Stamford Bridge 122	London City	54086	1981
126	Tottenham Hotspur Stadium 126	London City	62604	1984
138	Wembley Stadium 138	London City	51623	2002
148	Emirates Stadium 148	London City	68062	1982
149	Stamford Bridge 149	London City	41248	1918
153	Tottenham Hotspur Stadium 153	London City	41498	1986
165	Wembley Stadium 165	London City	41878	1957
175	Emirates Stadium 175	London City	64058	1931
176	Stamford Bridge 176	London City	74771	1986
180	Tottenham Hotspur Stadium 180	London City	64900	1995
192	Wembley Stadium 192	London City	57379	1933
202	Emirates Stadium 202	London City	42079	1947
203	Stamford Bridge 203	London City	76575	1996
207	Tottenham Hotspur Stadium 207	London City	51250	1980
219	Wembley Stadium 219	London City	52560	1959
229	Emirates Stadium 229	London City	60092	2003
230	Stamford Bridge 230	London City	75710	2018
234	Tottenham Hotspur Stadium 234	London City	93547	1977
246	Wembley Stadium 246	London City	94874	1968
256	Emirates Stadium 256	London City	70201	1945
257	Stamford Bridge 257	London City	93796	1972
261	Tottenham Hotspur Stadium 261	London City	73112	2014
273	Wembley Stadium 273	London City	38317	2015
283	Emirates Stadium 283	London City	52199	1974
284	Stamford Bridge 284	London City	46518	1911
288	Tottenham Hotspur Stadium 288	London City	44128	1998
300	Wembley Stadium 300	London City	43513	1958
310	Emirates Stadium 310	London City	88732	1995
311	Stamford Bridge 311	London City	70045	1926
315	Tottenham Hotspur Stadium 315	London City	65148	1917
327	Wembley Stadium 327	London City	91416	1953
337	Emirates Stadium 337	London City	74143	2011
338	Stamford Bridge 338	London City	54711	1973
342	Tottenham Hotspur Stadium 342	London City	91761	1953
354	Wembley Stadium 354	London City	56385	2004
364	Emirates Stadium 364	London City	52547	1993
365	Stamford Bridge 365	London City	68546	1999
369	Tottenham Hotspur Stadium 369	London City	64966	1940
381	Wembley Stadium 381	London City	94678	1941
391	Emirates Stadium 391	London City	73198	1957
392	Stamford Bridge 392	London City	47846	1944
396	Tottenham Hotspur Stadium 396	London City	61952	1946
408	Wembley Stadium 408	London City	43884	1973
418	Emirates Stadium 418	London City	87725	1979
419	Stamford Bridge 419	London City	50763	1978
423	Tottenham Hotspur Stadium 423	London City	82731	1917
435	Wembley Stadium 435	London City	55374	1946
445	Emirates Stadium 445	London City	49774	1915
446	Stamford Bridge 446	London City	62863	2002
450	Tottenham Hotspur Stadium 450	London City	57569	2001
462	Wembley Stadium 462	London City	51618	1934
472	Emirates Stadium 472	London City	62728	1924
473	Stamford Bridge 473	London City	72169	1944
477	Tottenham Hotspur Stadium 477	London City	79219	2011
489	Wembley Stadium 489	London City	88075	2014
499	Emirates Stadium 499	London City	87193	2000
500	Stamford Bridge 500	London City	80601	1983
\.


--
-- Data for Name: team; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.team (teamid, teamname, country, yearfounded) FROM stdin;
1	Belgium FC 1	Belgium	1893
2	Sweden FC 2	Sweden	1904
3	Turkey FC 3	Turkey	1918
4	Spain FC 4	Spain	1940
5	Ivory Coast FC 5	Ivory Coast	1914
6	Poland FC 6	Poland	1886
7	Portugal FC 7	Portugal	1907
8	Morocco FC 8	Morocco	1901
9	Argentina FC 9	Argentina	1918
10	Netherlands FC 10	Netherlands	1910
11	England FC 11	England	1894
12	Germany FC 12	Germany	1880
13	Japan FC 13	Japan	1894
14	Senegal FC 14	Senegal	1916
15	Brazil FC 15	Brazil	1934
16	Austria FC 16	Austria	1903
17	Croatia FC 17	Croatia	1924
18	USA FC 18	USA	1922
19	Israel FC 19	Israel	1894
20	Colombia FC 20	Colombia	1921
21	Italy FC 21	Italy	1896
22	Chile FC 22	Chile	1907
23	France FC 23	France	1906
24	Mexico FC 24	Mexico	1899
25	Egypt FC 25	Egypt	1893
26	Nigeria FC 26	Nigeria	1935
27	Scotland FC 27	Scotland	1880
28	Norway FC 28	Norway	1902
29	Belgium FC 29	Belgium	1904
30	Sweden FC 30	Sweden	1884
31	Turkey FC 31	Turkey	1928
32	Spain FC 32	Spain	1890
33	Ivory Coast FC 33	Ivory Coast	1928
34	Poland FC 34	Poland	1897
35	Portugal FC 35	Portugal	1918
36	Morocco FC 36	Morocco	1924
37	Argentina FC 37	Argentina	1898
38	Netherlands FC 38	Netherlands	1931
39	England FC 39	England	1895
40	Germany FC 40	Germany	1915
41	Japan FC 41	Japan	1904
42	Senegal FC 42	Senegal	1926
43	Brazil FC 43	Brazil	1930
44	Austria FC 44	Austria	1890
45	Croatia FC 45	Croatia	1884
46	USA FC 46	USA	1928
47	Israel FC 47	Israel	1914
48	Colombia FC 48	Colombia	1902
49	Italy FC 49	Italy	1931
50	Chile FC 50	Chile	1894
51	France FC 51	France	1933
52	Mexico FC 52	Mexico	1926
53	Egypt FC 53	Egypt	1884
54	Nigeria FC 54	Nigeria	1925
55	Scotland FC 55	Scotland	1939
56	Norway FC 56	Norway	1885
57	Belgium FC 57	Belgium	1929
58	Sweden FC 58	Sweden	1889
59	Turkey FC 59	Turkey	1924
60	Spain FC 60	Spain	1885
61	Ivory Coast FC 61	Ivory Coast	1912
62	Poland FC 62	Poland	1922
63	Portugal FC 63	Portugal	1912
64	Morocco FC 64	Morocco	1939
65	Argentina FC 65	Argentina	1896
66	Netherlands FC 66	Netherlands	1881
67	England FC 67	England	1898
68	Germany FC 68	Germany	1889
69	Japan FC 69	Japan	1925
70	Senegal FC 70	Senegal	1921
71	Brazil FC 71	Brazil	1905
72	Austria FC 72	Austria	1921
73	Croatia FC 73	Croatia	1912
74	USA FC 74	USA	1934
75	Israel FC 75	Israel	1919
76	Colombia FC 76	Colombia	1902
77	Italy FC 77	Italy	1895
78	Chile FC 78	Chile	1915
79	France FC 79	France	1928
80	Mexico FC 80	Mexico	1913
81	Egypt FC 81	Egypt	1924
82	Nigeria FC 82	Nigeria	1913
83	Scotland FC 83	Scotland	1928
84	Norway FC 84	Norway	1935
85	Belgium FC 85	Belgium	1915
86	Sweden FC 86	Sweden	1913
87	Turkey FC 87	Turkey	1894
88	Spain FC 88	Spain	1915
89	Ivory Coast FC 89	Ivory Coast	1889
90	Poland FC 90	Poland	1933
91	Portugal FC 91	Portugal	1899
92	Morocco FC 92	Morocco	1907
93	Argentina FC 93	Argentina	1886
94	Netherlands FC 94	Netherlands	1934
95	England FC 95	England	1886
96	Germany FC 96	Germany	1934
97	Japan FC 97	Japan	1882
98	Senegal FC 98	Senegal	1939
99	Brazil FC 99	Brazil	1925
100	Austria FC 100	Austria	1926
\.


--
-- Name: coach coach_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coach
    ADD CONSTRAINT coach_pkey PRIMARY KEY (coachid);


--
-- Name: coachedby coachedby_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coachedby
    ADD CONSTRAINT coachedby_pkey PRIMARY KEY (coachid, teamid);


--
-- Name: gkmatchstats gkmatchstats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gkmatchstats
    ADD CONSTRAINT gkmatchstats_pkey PRIMARY KEY (playerid, matchid);


--
-- Name: goalkeeper goalkeeper_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goalkeeper
    ADD CONSTRAINT goalkeeper_pkey PRIMARY KEY (playerid);


--
-- Name: match match_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.match
    ADD CONSTRAINT match_pkey PRIMARY KEY (matchid);


--
-- Name: matchstadium matchstadium_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matchstadium
    ADD CONSTRAINT matchstadium_pkey PRIMARY KEY (matchid);


--
-- Name: matchteam matchteam_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matchteam
    ADD CONSTRAINT matchteam_pkey PRIMARY KEY (matchid, teamid);


--
-- Name: player player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.player
    ADD CONSTRAINT player_pkey PRIMARY KEY (playerid);


--
-- Name: playermatchstats playermatchstats_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playermatchstats
    ADD CONSTRAINT playermatchstats_pkey PRIMARY KEY (playerid, matchid);


--
-- Name: playsfor_gk playsfor_gk_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playsfor_gk
    ADD CONSTRAINT playsfor_gk_pkey PRIMARY KEY (playerid, teamid);


--
-- Name: playsfor_player playsfor_player_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playsfor_player
    ADD CONSTRAINT playsfor_player_pkey PRIMARY KEY (playerid, teamid);


--
-- Name: referee referee_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.referee
    ADD CONSTRAINT referee_pkey PRIMARY KEY (refereeid);


--
-- Name: refereeat refereeat_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refereeat
    ADD CONSTRAINT refereeat_pkey PRIMARY KEY (matchid, refereeid);


--
-- Name: stadium stadium_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.stadium
    ADD CONSTRAINT stadium_pkey PRIMARY KEY (stadiumid);


--
-- Name: team team_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.team
    ADD CONSTRAINT team_pkey PRIMARY KEY (teamid);


--
-- Name: idx_match_date; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_match_date ON public.match USING btree (matchdate);


--
-- Name: idx_player_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_player_name ON public.player USING btree (playername);


--
-- Name: idx_stadium_city; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_stadium_city ON public.stadium USING btree (city);


--
-- Name: coachedby coachedby_coachid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coachedby
    ADD CONSTRAINT coachedby_coachid_fkey FOREIGN KEY (coachid) REFERENCES public.coach(coachid);


--
-- Name: coachedby coachedby_teamid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.coachedby
    ADD CONSTRAINT coachedby_teamid_fkey FOREIGN KEY (teamid) REFERENCES public.team(teamid);


--
-- Name: gkmatchstats gkmatchstats_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gkmatchstats
    ADD CONSTRAINT gkmatchstats_matchid_fkey FOREIGN KEY (matchid) REFERENCES public.match(matchid);


--
-- Name: gkmatchstats gkmatchstats_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gkmatchstats
    ADD CONSTRAINT gkmatchstats_playerid_fkey FOREIGN KEY (playerid) REFERENCES public.goalkeeper(playerid);


--
-- Name: goalkeeper goalkeeper_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.goalkeeper
    ADD CONSTRAINT goalkeeper_playerid_fkey FOREIGN KEY (playerid) REFERENCES public.player(playerid);


--
-- Name: matchstadium matchstadium_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matchstadium
    ADD CONSTRAINT matchstadium_matchid_fkey FOREIGN KEY (matchid) REFERENCES public.match(matchid);


--
-- Name: matchstadium matchstadium_stadiumid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matchstadium
    ADD CONSTRAINT matchstadium_stadiumid_fkey FOREIGN KEY (stadiumid) REFERENCES public.stadium(stadiumid);


--
-- Name: matchteam matchteam_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matchteam
    ADD CONSTRAINT matchteam_matchid_fkey FOREIGN KEY (matchid) REFERENCES public.match(matchid);


--
-- Name: matchteam matchteam_teamid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.matchteam
    ADD CONSTRAINT matchteam_teamid_fkey FOREIGN KEY (teamid) REFERENCES public.team(teamid);


--
-- Name: playermatchstats playermatchstats_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playermatchstats
    ADD CONSTRAINT playermatchstats_matchid_fkey FOREIGN KEY (matchid) REFERENCES public.match(matchid);


--
-- Name: playermatchstats playermatchstats_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playermatchstats
    ADD CONSTRAINT playermatchstats_playerid_fkey FOREIGN KEY (playerid) REFERENCES public.player(playerid);


--
-- Name: playsfor_gk playsfor_gk_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playsfor_gk
    ADD CONSTRAINT playsfor_gk_playerid_fkey FOREIGN KEY (playerid) REFERENCES public.goalkeeper(playerid);


--
-- Name: playsfor_gk playsfor_gk_teamid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playsfor_gk
    ADD CONSTRAINT playsfor_gk_teamid_fkey FOREIGN KEY (teamid) REFERENCES public.team(teamid);


--
-- Name: playsfor_player playsfor_player_playerid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playsfor_player
    ADD CONSTRAINT playsfor_player_playerid_fkey FOREIGN KEY (playerid) REFERENCES public.player(playerid);


--
-- Name: playsfor_player playsfor_player_teamid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.playsfor_player
    ADD CONSTRAINT playsfor_player_teamid_fkey FOREIGN KEY (teamid) REFERENCES public.team(teamid);


--
-- Name: refereeat refereeat_matchid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refereeat
    ADD CONSTRAINT refereeat_matchid_fkey FOREIGN KEY (matchid) REFERENCES public.match(matchid);


--
-- Name: refereeat refereeat_refereeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.refereeat
    ADD CONSTRAINT refereeat_refereeid_fkey FOREIGN KEY (refereeid) REFERENCES public.referee(refereeid);


--
-- PostgreSQL database dump complete
--


