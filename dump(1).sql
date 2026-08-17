--
-- PostgreSQL database dump
--

-- Dumped from database version 10.23
-- Dumped by pg_dump version 10.23

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

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: accountstatus; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.accountstatus AS ENUM (
    'pending',
    'in_progress',
    'passed',
    'failed'
);


ALTER TYPE public.accountstatus OWNER TO propfirmsol_samdav;

--
-- Name: earningstatus; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.earningstatus AS ENUM (
    'available',
    'locked',
    'released',
    'claimed'
);


ALTER TYPE public.earningstatus OWNER TO propfirmsol_samdav;

--
-- Name: notificationtype; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.notificationtype AS ENUM (
    'GENERAL',
    'FAILED_ACCOUNT',
    'PASSED_ACCOUNT',
    'LOGIN',
    'ACCOUNT_RESET',
    'PASSWORD_RESET',
    'PAYMENT_PENDING',
    'PAYMENT_SUCCESS',
    'PAYMENT_FAILED',
    'PAYMENT_PARTIAL',
    'EMAIL_VERIFIED',
    'PASSWORD_CHANGED',
    'REGISTRATION_CREATED',
    'REGISTRATION_UPDATED',
    'general',
    'failed_account',
    'passed_account',
    'login',
    'account_reset',
    'password_reset',
    'payment_pending',
    'payment_success',
    'payment_failed',
    'payment_partial',
    'email_verified',
    'password_changed',
    'registration_created',
    'registration_updated',
    'credentials_received',
    'execution_started',
    'execution_paused',
    'progress_update',
    'timeline_delay',
    'challenge_passed',
    'challenge_failed',
    'challenge_queued',
    'trading_system_access',
    'client_interference',
    'service_closure',
    'upgrade_offer',
    'support_call',
    'testimonial_request',
    'reengagement',
    'CREDENTIALS_RECEIVED',
    'EXECUTION_STARTED',
    'EXECUTION_PAUSED',
    'PROGRESS_UPDATE',
    'TIMELINE_DELAY',
    'CHALLENGE_PASSED',
    'CHALLENGE_FAILED',
    'CHALLENGE_QUEUED',
    'TRADING_SYSTEM_ACCESS',
    'CLIENT_INTERFERENCE',
    'SERVICE_CLOSURE',
    'UPGRADE_OFFER',
    'SUPPORT_CALL',
    'TESTIMONIAL_REQUEST',
    'REENGAGEMENT'
);


ALTER TYPE public.notificationtype OWNER TO propfirmsol_samdav;

--
-- Name: passtype; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.passtype AS ENUM (
    'standard_pass',
    'guaranteed_pass'
);


ALTER TYPE public.passtype OWNER TO propfirmsol_samdav;

--
-- Name: paymentmethod; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.paymentmethod AS ENUM (
    'bank_transfer',
    'crypto',
    'paypal'
);


ALTER TYPE public.paymentmethod OWNER TO propfirmsol_samdav;

--
-- Name: paymentstatus; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.paymentstatus AS ENUM (
    'pending',
    'completed',
    'failed'
);


ALTER TYPE public.paymentstatus OWNER TO propfirmsol_samdav;

--
-- Name: sendertype; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.sendertype AS ENUM (
    'USER',
    'ADMIN'
);


ALTER TYPE public.sendertype OWNER TO propfirmsol_samdav;

--
-- Name: ticketpriority; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.ticketpriority AS ENUM (
    'LOW',
    'MEDIUM',
    'HIGH',
    'URGENT'
);


ALTER TYPE public.ticketpriority OWNER TO propfirmsol_samdav;

--
-- Name: ticketstatus; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.ticketstatus AS ENUM (
    'OPEN',
    'IN_PROGRESS',
    'RESOLVED',
    'CLOSED'
);


ALTER TYPE public.ticketstatus OWNER TO propfirmsol_samdav;

--
-- Name: txn_status_enum; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.txn_status_enum AS ENUM (
    'pending',
    'completed',
    'failed',
    'reversed'
);


ALTER TYPE public.txn_status_enum OWNER TO propfirmsol_samdav;

--
-- Name: txn_type_enum; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.txn_type_enum AS ENUM (
    'deposit',
    'withdrawal',
    'transfer',
    'payment',
    'refund'
);


ALTER TYPE public.txn_type_enum OWNER TO propfirmsol_samdav;

--
-- Name: withdrawalstatus; Type: TYPE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TYPE public.withdrawalstatus AS ENUM (
    'pending',
    'approved',
    'rejected',
    'completed'
);


ALTER TYPE public.withdrawalstatus OWNER TO propfirmsol_samdav;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: admin; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.admin (
    id uuid NOT NULL,
    email character varying NOT NULL,
    name character varying NOT NULL,
    password character varying NOT NULL,
    "Status" boolean NOT NULL,
    email_verified boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    roles json NOT NULL
);


ALTER TABLE public.admin OWNER TO propfirmsol_samdav;

--
-- Name: affiliate_settings; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.affiliate_settings (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    custom_commission_rate numeric(4,4),
    is_affiliate_enabled boolean NOT NULL,
    notes text,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.affiliate_settings OWNER TO propfirmsol_samdav;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO propfirmsol_samdav;

--
-- Name: banner; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.banner (
    id uuid NOT NULL,
    text character varying NOT NULL,
    link character varying,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.banner OWNER TO propfirmsol_samdav;

--
-- Name: booking_link; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.booking_link (
    id uuid NOT NULL,
    title character varying(255) NOT NULL,
    url character varying NOT NULL,
    is_active boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.booking_link OWNER TO propfirmsol_samdav;

--
-- Name: cryptopayment; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.cryptopayment (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    payment_id character varying,
    invoice_id character varying,
    order_id character varying,
    order_description character varying,
    price_amount double precision NOT NULL,
    price_currency character varying NOT NULL,
    pay_amount double precision,
    pay_currency character varying NOT NULL,
    pay_address character varying,
    payin_extra_id character varying,
    payment_status character varying NOT NULL,
    actually_paid double precision,
    purchase_id character varying,
    outcome_amount double precision,
    outcome_currency character varying,
    ipn_callback_url character varying,
    invoice_url character varying,
    is_fixed_rate boolean NOT NULL,
    is_fee_paid_by_user boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.cryptopayment OWNER TO propfirmsol_samdav;

--
-- Name: discount_codes; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.discount_codes (
    id uuid NOT NULL,
    discount_name character varying NOT NULL,
    discount_code character varying NOT NULL,
    percentage double precision NOT NULL,
    expires_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.discount_codes OWNER TO propfirmsol_samdav;

--
-- Name: global_affiliate_settings; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.global_affiliate_settings (
    id uuid NOT NULL,
    default_commission_rate numeric(4,4) NOT NULL,
    minimum_withdrawal_amount numeric(12,2) NOT NULL,
    is_program_enabled boolean NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.global_affiliate_settings OWNER TO propfirmsol_samdav;

--
-- Name: notification; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.notification (
    id uuid NOT NULL,
    user_id uuid,
    admin_id uuid,
    title character varying NOT NULL,
    message character varying NOT NULL,
    type public.notificationtype NOT NULL,
    is_read boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.notification OWNER TO propfirmsol_samdav;

--
-- Name: payment; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.payment (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    card_name character varying NOT NULL,
    card_number character varying NOT NULL,
    card_expiry_date timestamp without time zone NOT NULL,
    card_type character varying NOT NULL,
    card_cvv character varying,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.payment OWNER TO propfirmsol_samdav;

--
-- Name: prop_firm_plan; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.prop_firm_plan (
    id uuid NOT NULL,
    slug character varying NOT NULL,
    name character varying NOT NULL,
    subtitle character varying,
    description character varying,
    benefits json,
    is_popular boolean NOT NULL,
    highlight_text character varying,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.prop_firm_plan OWNER TO propfirmsol_samdav;

--
-- Name: prop_firm_plan_price; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.prop_firm_plan_price (
    id uuid NOT NULL,
    plan_id uuid NOT NULL,
    account_size integer NOT NULL,
    price double precision NOT NULL,
    account_size_display character varying NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.prop_firm_plan_price OWNER TO propfirmsol_samdav;

--
-- Name: prop_firm_registration; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.prop_firm_registration (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    login_id character varying NOT NULL,
    password character varying NOT NULL,
    propfirm_name character varying NOT NULL,
    propfirm_website_link character varying NOT NULL,
    server_name character varying NOT NULL,
    server_type character varying NOT NULL,
    challenges_step integer NOT NULL,
    service_scope integer,
    order_id character varying NOT NULL,
    propfirm_account_cost double precision NOT NULL,
    account_size double precision NOT NULL,
    account_phases integer NOT NULL,
    trading_platform character varying NOT NULL,
    propfirm_rules character varying NOT NULL,
    whatsapp_no character varying NOT NULL,
    telegram_username character varying NOT NULL,
    pass_type public.passtype NOT NULL,
    account_status public.accountstatus NOT NULL,
    payment_status public.paymentstatus NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.prop_firm_registration OWNER TO propfirmsol_samdav;

--
-- Name: referral_earning; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.referral_earning (
    id uuid NOT NULL,
    wallet_id uuid NOT NULL,
    referrer_id uuid NOT NULL,
    referred_user_id uuid NOT NULL,
    registration_id uuid,
    pass_type character varying NOT NULL,
    amount numeric(12,2) NOT NULL,
    status public.earningstatus NOT NULL,
    challenge_passed boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    released_at timestamp with time zone
);


ALTER TABLE public.referral_earning OWNER TO propfirmsol_samdav;

--
-- Name: support; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.support (
    id uuid NOT NULL,
    name character varying NOT NULL,
    email character varying NOT NULL,
    phone character varying NOT NULL,
    message character varying NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.support OWNER TO propfirmsol_samdav;

--
-- Name: support_message; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.support_message (
    id uuid NOT NULL,
    ticket_id uuid NOT NULL,
    sender_id uuid NOT NULL,
    sender_type public.sendertype NOT NULL,
    message text NOT NULL,
    created_at timestamp with time zone NOT NULL
);


ALTER TABLE public.support_message OWNER TO propfirmsol_samdav;

--
-- Name: support_ticket; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.support_ticket (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    subject character varying(255) NOT NULL,
    status public.ticketstatus NOT NULL,
    priority public.ticketpriority NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.support_ticket OWNER TO propfirmsol_samdav;

--
-- Name: transactions; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.transactions (
    id uuid NOT NULL,
    users_id uuid NOT NULL,
    type public.txn_type_enum NOT NULL,
    amount_cents bigint NOT NULL,
    status public.txn_status_enum NOT NULL,
    reference character varying,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.transactions OWNER TO propfirmsol_samdav;

--
-- Name: user; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public."user" (
    id uuid NOT NULL,
    email character varying NOT NULL,
    name character varying NOT NULL,
    password character varying NOT NULL,
    "Status" boolean NOT NULL,
    referral_code character varying NOT NULL,
    email_verified boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    referred_by character varying
);


ALTER TABLE public."user" OWNER TO propfirmsol_samdav;

--
-- Name: user_discount; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.user_discount (
    id uuid NOT NULL,
    discount_id uuid NOT NULL,
    user_id uuid NOT NULL,
    discount_code character varying NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.user_discount OWNER TO propfirmsol_samdav;

--
-- Name: user_purchased_package; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.user_purchased_package (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    package_name character varying NOT NULL,
    amount double precision NOT NULL,
    status character varying NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.user_purchased_package OWNER TO propfirmsol_samdav;

--
-- Name: vat; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.vat (
    id uuid NOT NULL,
    vat_name character varying NOT NULL,
    percentage double precision NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.vat OWNER TO propfirmsol_samdav;

--
-- Name: wallet; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.wallet (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    available_balance numeric(12,2) NOT NULL,
    locked_balance numeric(12,2) NOT NULL,
    total_withdrawn numeric(12,2) NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


ALTER TABLE public.wallet OWNER TO propfirmsol_samdav;

--
-- Name: withdrawal_request; Type: TABLE; Schema: public; Owner: propfirmsol_samdav
--

CREATE TABLE public.withdrawal_request (
    id uuid NOT NULL,
    wallet_id uuid NOT NULL,
    amount numeric(12,2) NOT NULL,
    payment_method public.paymentmethod NOT NULL,
    bank_name character varying,
    account_number character varying,
    account_name character varying,
    routing_number character varying,
    swift_code character varying,
    crypto_wallet_address character varying,
    crypto_network character varying,
    crypto_currency character varying,
    paypal_email character varying,
    status public.withdrawalstatus NOT NULL,
    admin_notes text,
    created_at timestamp with time zone NOT NULL,
    processed_at timestamp with time zone,
    batch_withdrawal_id character varying,
    payout_id character varying,
    external_status character varying,
    rejection_reason character varying
);


ALTER TABLE public.withdrawal_request OWNER TO propfirmsol_samdav;

--
-- Data for Name: admin; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.admin VALUES ('9d252819-da89-4665-9192-958a8627d02a', 'victoretb5@gmail.com', 'Victory Omoike', '$2b$12$wkOhJ2Ipe6/sWt9mHKN5buHHnDrNhTzNfAvzlroj8LWbSFSoriLkK', true, true, '2026-02-01 06:56:39.903719+00', '2026-02-01 06:56:39.903742+00', '["dashboard", "super_admin", "users", "transactions", "payouts", "prop_firms"]');
INSERT INTO public.admin VALUES ('4b84707b-679a-42e8-9faa-ec67dc8e3b32', 'develowithvic@gmail.com', 'developwithvic', '$2b$12$yGS02boqqjv7/EKneSwoYe7z.c1u.P4jjTNv/nnwzQuNh12ni8aHO', true, true, '2026-02-02 12:00:00.211274+00', '2026-02-02 12:00:00.211301+00', '["dashboard", "prop_firms", "payments", "payouts", "transactions", "support", "settings", "super_admin"]');
INSERT INTO public.admin VALUES ('c050d0a9-ff23-4a6b-9302-43c64ed0d9ca', 'adoxop1@gmail.com', 'Samuel Dawodu', '$2b$12$2WWMcVNBgAJHXG5RFKH1XOj/6Zj8wj8zKvFZA1LGFJA429D1Uoz16', true, true, '2026-01-31 21:10:03.738403+00', '2026-01-31 21:10:03.738423+00', '["dashboard", "super_admin", "users", "transactions", "payouts", "prop_firms"]');
INSERT INTO public.admin VALUES ('ea5cb2dd-0c17-4d59-87c5-82bc87ff4713', 'techio.com.ng@gmail.com', 'Dawodu Samuel', '$2b$12$NIu49zZZ.1AWY/YCFTn2TeTCDw91sbmaGWxTmR.scccH38CoLX82K', true, true, '2026-01-31 21:11:25.477795+00', '2026-01-31 21:11:25.477822+00', '["dashboard", "users", "prop_firms", "payments", "support", "settings", "payouts"]');
INSERT INTO public.admin VALUES ('1572a49d-0cfb-4953-a24f-1079bde52d7f', 'thompsoninemesit.c@gmail.com', 'Thompson Inemesit', '$2b$12$riQ2LKv8B5QJnXJV7jrEQujlRXz0ZtOdbz4D/bjAQb.Y3Y.2abZ6a', true, true, '2026-02-10 09:46:51.322254+00', '2026-02-10 09:46:51.322318+00', '["dashboard", "support", "payments", "users", "payouts", "transactions"]');


--
-- Data for Name: affiliate_settings; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--



--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.alembic_version VALUES ('022b1c76c3e0');


--
-- Data for Name: banner; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.banner VALUES ('45d3014d-8761-42ac-bc98-116f9edf4f07', 'Register for the upcoming call booking', 'https://calendly.com/hello-propfirmsol/30min', false, '2026-02-08 07:27:17.134822+00', '2026-02-08 07:27:17.134847+00');


--
-- Data for Name: booking_link; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.booking_link VALUES ('59df9a9c-96d0-4f1f-bb7f-fa8747df7094', 'Book Call', 'https://calendly.com/hello-propfirmsol/30min', true, '2026-02-08 07:26:30.944583+00', '2026-02-08 07:26:30.944603+00');


--
-- Data for Name: cryptopayment; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.cryptopayment VALUES ('7546ea9d-603e-422a-a5c9-e82ed3e776ee', '351bf5af-7807-458a-898d-bc1e80380e97', '6072404368', NULL, 'PS-74KARZIM', 'PropSol - FundedNext 1-Step Challenge - $200000k', 2600, 'usd', 2595.50368399999979, 'usdc', '0x321B69f71cABf15659f664957E21773b47a6d260', NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-06 12:17:17.936+00', '2026-02-06 12:17:17.955829+00');
INSERT INTO public.cryptopayment VALUES ('e17de715-4b93-4eab-88d7-8cdef0f01a36', '351bf5af-7807-458a-898d-bc1e80380e97', '4429581493', NULL, 'PS-XZQG5WER', 'PropSol - FundingPips 1-Step Challenge - $200000k', 2600, 'usd', 0.0375348299999999982, 'btc', '35HimeEzMYGhMNWFcygugoLZpCeyedM15D', NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-08 05:53:19.191+00', '2026-02-08 05:53:19.208493+00');
INSERT INTO public.cryptopayment VALUES ('f13aaa68-b30f-4de8-9b55-7422b810939c', '3e5be313-a9df-4834-b146-d35dc14e62c4', '4461024151', NULL, 'PS-01VIJNLW', 'PropSol - FundingPips 2-Step Challenge - $50000k', 10, 'usd', 9.92608899999999927, 'usdttrc20', 'TWcV83QJ4GNHYEu4WFPJBPUkLddYW8YEgc', NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-08 08:26:01.949+00', '2026-02-08 08:26:01.966411+00');
INSERT INTO public.cryptopayment VALUES ('86bb107b-9086-4b93-8fea-ea3299ebab77', '3e5be313-a9df-4834-b146-d35dc14e62c4', '5091483166', NULL, 'PS-IE9JUOP9', 'PropSol - FundingPips 2-Step Challenge - $50000k', 10, 'usd', 9.94400899999999943, 'usdttrc20', 'THw4eEk5ars14hrmQL8wa5fw4rPiqE4zJ9', NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-08 10:10:45.529+00', '2026-02-08 10:10:45.544455+00');
INSERT INTO public.cryptopayment VALUES ('b5fb18f5-b1ac-462e-b236-13f15afed805', '351bf5af-7807-458a-898d-bc1e80380e97', '4431410216', NULL, 'PS-TNFJ083H', 'PropSol - FundedNext 2-Step Challenge - $50000k', 10, 'usd', 9.9608509999999999, 'usdttrc20', 'TFpEHkuBoFvNX6KB5rCYkd83JruMmz1ouD', NULL, 'confirmed', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-08 17:33:43.255+00', '2026-02-08 17:33:43.271144+00');
INSERT INTO public.cryptopayment VALUES ('7c5a0ef4-3d66-4147-aa2b-bc0e9f82aba7', 'e85975ea-02c3-442e-90f9-479f2f690951', '4570639880', NULL, 'PS-V30OUSRY', 'PropSol - FundedNext 2-Step Challenge - $50000k', 490, 'usd', 0.00685602, 'btc', '3BJZQLRsjvf8bTSzwC5Jk8ZyeJfWYiDqJi', NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-08 20:00:31.094+00', '2026-02-08 20:00:31.114239+00');
INSERT INTO public.cryptopayment VALUES ('9f0e5199-7019-4193-a6d3-93f8cf5196e9', 'de36fe56-826b-49e7-9e30-3af9a8e9aa5c', '4486311018', NULL, 'PS-2HZME5ST', 'PropSol - FundingPips 2-Step Challenge - $50000k', 690, 'usd', 687.144006999999988, 'usdttrc20', 'TNC8m4W9Z8J7hWoqi4QdZuBbNxk8bYkKd2', NULL, 'partially_paid', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-10 04:12:34.751+00', '2026-02-10 04:12:33.981116+00');
INSERT INTO public.cryptopayment VALUES ('4512d6b3-c519-407a-887a-549d409c4884', '3e5be313-a9df-4834-b146-d35dc14e62c4', '6436924802', NULL, 'PS-UNICXTH5', 'PropSol - FundingPips 2-Step Challenge - $500000k', 10, 'usd', 9.98080500000000015, 'usdttrc20', 'TNUCkZ2anCS2BfHuVrAnmZCdi2UG1xkwBq', NULL, 'finished', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-10 09:03:15.748+00', '2026-02-10 09:03:15.76642+00');
INSERT INTO public.cryptopayment VALUES ('638379f2-d66a-4a54-84f4-40efc00139ac', 'db61433d-25ea-4edb-b3e2-6de586756ef4', '5080225844', NULL, 'PS-S53N4GE4', 'PropSol - FundedNext 2-Step Challenge - $100000k', 890, 'usd', 16.6264939500000004, 'ltc', 'MKEju5brT7PtQGk3oTuKNwaQPqhK4g2DDU', NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-10 23:55:24.622+00', '2026-02-10 23:55:24.64632+00');
INSERT INTO public.cryptopayment VALUES ('bcf1f848-1ba9-454e-a51e-bfbcb19d5651', 'd2ff5166-862b-4597-ab3a-e87102ddba87', '4427400739', NULL, 'PS-SK0VS2K1', 'PropSol - FundingPips 2-Step Challenge - $50000k', 690, 'usd', 689.379081000000042, 'usdttrc20', 'TNoFG28wq8rYKQedGVnxRkjzjjPMf52xkH', NULL, 'finished', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-15 12:17:08.548+00', '2026-02-15 12:17:08.570079+00');
INSERT INTO public.cryptopayment VALUES ('2ff96666-db20-4b43-ab66-052cd939cc56', '1741b8a3-7ee9-49cb-b9e7-97a33e16bae1', '5572257946', NULL, 'PS-3QO45J6K', 'PropSol - FundingPips 2-Step Challenge - $50000k', 490, 'usd', 488.672151009999993, 'usdcsol', 'Hesa5xkkFWAdQWghuqxwZo3o6M89wiiW8dN3CQrYZEBL', NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-16 15:51:12.542+00', '2026-02-16 15:51:12.569352+00');
INSERT INTO public.cryptopayment VALUES ('2a079f09-8a29-4489-b233-2e3a2a92238d', '5495ceef-417e-4329-b624-73dbd9ad2355', '5942929299', '5942929299', 'PS-43XQY0HV', 'PropSol - FundingPips 1-Step Challenge - $100000k', 1900, 'usd', NULL, 'btc', NULL, NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, 'https://nowpayments.io/payment/?iid=5942929299', false, false, '2026-02-19 08:15:56.12+00', '2026-02-19 08:15:56.135872+00');
INSERT INTO public.cryptopayment VALUES ('382f10b2-b69f-4db2-92a0-02725e1bbfb8', '8577825a-2a1c-4e8f-a039-aaad5730e91c', '5949374388', NULL, 'PS-J49H1MM3', 'PropSol - FundedNext 1-Step Challenge - $50000k', 1400, 'usd', 0.0205574, 'btc', '3CEAESNCpmcd6iUME6aGCp8BxdkEMgkTCe', NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-02-22 07:48:28.791+00', '2026-02-22 07:48:28.812942+00');
INSERT INTO public.cryptopayment VALUES ('08bd86f1-1333-4ea7-9470-ec6836f86af6', '6aa0f3e5-e16b-4b9f-89fd-2a6281517059', '6013187147', NULL, 'PS-J6GCR09V', 'PropSol - FundingPips 1-Step Challenge - $50000k', 1400, 'usd', 3921.41790399999991, 'trx', 'TKDJ42hGJLfPom8HQLK53T8oT8ugeH5dcw', NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-05-17 21:24:33.435+00', '2026-05-17 21:24:33.488307+00');
INSERT INTO public.cryptopayment VALUES ('e0576d9f-6430-47a5-929e-dbf5d0d30c7f', 'c136b479-1849-4f56-b4d0-36912a25f0f7', '5802665864', '5802665864', 'PS-Y8X62C1Z', 'PropSol - FundedNext 1-Step Challenge - $100000k', 1900, 'usd', NULL, 'btc', NULL, NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, 'https://nowpayments.io/payment/?iid=5802665864', false, false, '2026-06-01 22:10:28.575+00', '2026-06-01 22:10:28.595069+00');
INSERT INTO public.cryptopayment VALUES ('78261be8-1f51-4822-8efa-e8f61d5283bd', '11c50e6a-1018-4331-8069-fba733270d4e', '4602272663', NULL, 'PS-CJQAWC14', 'PropSol - FundedNext 2-Step Challenge - $500000k', 1790, 'usd', 1786.80185699999993, 'usdttrc20', 'TRyiE45M8usJLCFviLtznYUvsWPAtcNqTV', NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-07-17 21:32:48.29+00', '2026-07-17 21:32:48.315316+00');
INSERT INTO public.cryptopayment VALUES ('12ccd5e2-5e32-438a-b904-e2f9a43ddb52', '75d45b65-c2d5-4244-9723-174152621383', '5136555056', NULL, 'PS-2DNCOZVK', 'PropSol - FundingPips 2-Step Challenge - $500000k', 1790, 'usd', 0.0279325300000000006, 'btc', '3KFAk4rmdSEoF8yCR8D7oVmVA1iVtqqizz', NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, NULL, false, false, '2026-07-20 09:05:16.18+00', '2026-07-20 09:05:16.228065+00');
INSERT INTO public.cryptopayment VALUES ('b9cffab8-088f-4a8c-8826-71d0d2c00cbd', '351bf5af-7807-458a-898d-bc1e80380e97', '5744943636', '5744943636', 'PS-ON81C3GV', 'PropSol - FundedNext 2-Step Challenge - $200000k', 1700, 'usd', NULL, 'usdttrc20', NULL, NULL, 'waiting', NULL, NULL, NULL, NULL, NULL, 'https://nowpayments.io/payment/?iid=5744943636', false, false, '2026-08-08 01:59:55.564+00', '2026-08-08 01:59:55.578308+00');


--
-- Data for Name: discount_codes; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.discount_codes VALUES ('78fffd8a-6250-448d-93b7-0556b8dd7004', 'WELCOME10', 'WELCOME10', 10, '2026-02-26 06:04:00+00', '2026-02-11 06:04:16.620533+00', '2026-02-11 06:04:16.620547+00');


--
-- Data for Name: global_affiliate_settings; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.global_affiliate_settings VALUES ('b4345ee5-3c43-4088-85a2-aa01d2170415', 0.0200, 100.00, true, '2026-02-06 16:46:39.364306+00');


--
-- Data for Name: notification; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.notification VALUES ('179eec72-bde5-4462-8a31-aa7aa5e34250', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-02-02 12:25:15.917473+00', '2026-02-02 12:25:15.917563+00');
INSERT INTO public.notification VALUES ('e6ce9a24-f44b-4667-9f6e-4b501a883ad8', 'cd828787-7787-4a97-92bc-abd33b50a3a3', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-02-02 14:41:59.796364+00', '2026-02-02 14:41:59.796404+00');
INSERT INTO public.notification VALUES ('5e5d2299-56b5-4f6e-8f40-b744b3685e1a', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-F7RRL2I3. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-06 12:15:48.451247+00', '2026-02-06 12:15:48.451261+00');
INSERT INTO public.notification VALUES ('57dfc63a-7cc6-4120-b40a-97d7a48a6426', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-74KARZIM. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-06 12:17:16.814617+00', '2026-02-06 12:17:16.814631+00');
INSERT INTO public.notification VALUES ('0d080f6b-b583-48dc-add9-c2335135e00b', '8ff7d590-67f6-48e7-8d3c-ddf2519997d0', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-02-06 13:58:28.866372+00', '2026-02-06 13:58:28.866398+00');
INSERT INTO public.notification VALUES ('022756a1-73f0-411a-94d6-c123f8657818', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-KV7HQFQA. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-06 16:06:02.932703+00', '2026-02-06 16:06:02.932734+00');
INSERT INTO public.notification VALUES ('673588d0-b10b-44c6-9b79-7890ab7b38aa', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-PZPULODG. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 05:52:11.681106+00', '2026-02-08 05:52:11.681149+00');
INSERT INTO public.notification VALUES ('d3d315ba-1aff-4686-8b6d-8d8175e65ab0', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-XZQG5WER. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 05:53:18.459116+00', '2026-02-08 05:53:18.459129+00');
INSERT INTO public.notification VALUES ('361b35cc-da6a-493b-bfb5-4d80008f3399', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-ZIH6X76M. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 08:23:43.477638+00', '2026-02-08 08:23:43.477667+00');
INSERT INTO public.notification VALUES ('f894fc43-e27e-447e-baa2-f18290253bfa', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-LC4LL0I3. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 08:23:51.089997+00', '2026-02-08 08:23:51.090014+00');
INSERT INTO public.notification VALUES ('fb092df4-9eb1-4251-bea7-e648d970981f', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-01VIJNLW. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 08:26:00.512347+00', '2026-02-08 08:26:00.512364+00');
INSERT INTO public.notification VALUES ('28c33c9d-dcf5-4208-a9ba-2fa62c600051', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-4EDELRKZ. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 08:41:31.934939+00', '2026-02-08 08:41:31.934972+00');
INSERT INTO public.notification VALUES ('52fa1ec4-43d4-48ca-a5f1-b7ef7fe43506', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account In_Progress', 'Your account for FTMO has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-08 08:46:55.742258+00', '2026-02-08 08:46:55.742289+00');
INSERT INTO public.notification VALUES ('11e53dd6-d1c6-428b-aa39-516a1f52bdd1', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-ECNTZCUW. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 10:09:25.474677+00', '2026-02-08 10:09:25.474711+00');
INSERT INTO public.notification VALUES ('49ac9880-e212-49a8-80dc-33725a382c50', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-DIKQBXMQ. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 10:09:38.06972+00', '2026-02-08 10:09:38.069731+00');
INSERT INTO public.notification VALUES ('dc6bb54a-034a-4205-a2aa-df0dd7abad6c', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-IE9JUOP9. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 10:10:44.738699+00', '2026-02-08 10:10:44.738709+00');
INSERT INTO public.notification VALUES ('227c9e40-de41-441a-b2d5-375d584d2e73', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-7KNXH4GA. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 17:32:19.107801+00', '2026-02-08 17:32:19.107821+00');
INSERT INTO public.notification VALUES ('56f1bc8b-7e24-4212-af7b-97b4dab4f464', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-WFOBW2BT. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 17:32:30.02805+00', '2026-02-08 17:32:30.028059+00');
INSERT INTO public.notification VALUES ('0ce5b4bc-4060-410d-8a23-b0f72957be1b', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-TNFJ083H. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 17:33:42.651607+00', '2026-02-08 17:33:42.651616+00');
INSERT INTO public.notification VALUES ('17168b4f-0541-4051-99cc-bb8cb8f512fb', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account In_Progress', 'Your account for FundedNext has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-08 17:41:44.292584+00', '2026-02-08 17:41:44.292604+00');
INSERT INTO public.notification VALUES ('eb314c50-0ef3-4e09-9160-7296edcdaccc', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account In_Progress', 'Your account for FundedNext has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-08 18:49:23.237995+00', '2026-02-08 18:49:23.238013+00');
INSERT INTO public.notification VALUES ('5d10897d-ae12-49ae-a5d6-feaf048fc663', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account Failed', 'Your account for FTMO has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-08 19:03:47.38915+00', '2026-02-08 19:03:47.389162+00');
INSERT INTO public.notification VALUES ('e35885d1-fdb2-4a28-af06-a3fb4aee6cdb', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Failed', 'Your account for FundedNext has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-08 19:04:02.458085+00', '2026-02-08 19:04:02.458115+00');
INSERT INTO public.notification VALUES ('f3f010bc-3993-4bf0-85f9-5ed37fb68582', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Passed', 'Your account for FundedNext has been marked as AccountStatus.passed.', 'PASSED_ACCOUNT', false, '2026-02-08 19:04:06.531748+00', '2026-02-08 19:04:06.531761+00');
INSERT INTO public.notification VALUES ('9b2ffb9f-5a1c-4e58-bf50-99ca144ba936', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account In_Progress', 'Your account for FTMO has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-08 19:10:07.357444+00', '2026-02-08 19:10:07.357454+00');
INSERT INTO public.notification VALUES ('da8365b5-16fc-487f-9c81-ced6c71fd8d2', '6044e04e-7ae1-4c2f-be7e-c6dcd7059814', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-02-08 19:41:13.720739+00', '2026-02-08 19:41:13.720891+00');
INSERT INTO public.notification VALUES ('c3162b43-c976-47db-91d2-534a358736e6', '6044e04e-7ae1-4c2f-be7e-c6dcd7059814', NULL, 'Password Changed', 'Your password has been successfully updated.', 'PASSWORD_CHANGED', false, '2026-02-08 19:42:57.840894+00', '2026-02-08 19:42:57.840904+00');
INSERT INTO public.notification VALUES ('44dc0f83-a9f3-4a65-98ae-a7dffc4c0643', 'e85975ea-02c3-442e-90f9-479f2f690951', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-V30OUSRY. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-08 20:00:30.036855+00', '2026-02-08 20:00:30.036884+00');
INSERT INTO public.notification VALUES ('37b03fc0-9807-48be-b6da-c1345d8f91e6', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Failed', 'Your account for FundedNext has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-08 20:17:20.373898+00', '2026-02-08 20:17:20.373913+00');
INSERT INTO public.notification VALUES ('a6ddf959-bec3-4ff8-b816-117143c8322c', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account In_Progress', 'Your account for FundedNext has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-08 20:17:25.428479+00', '2026-02-08 20:17:25.428492+00');
INSERT INTO public.notification VALUES ('092bb87e-f0d8-492f-8852-15a2469c350e', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Failed', 'Your account for FundedNext has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-08 20:19:29.790049+00', '2026-02-08 20:19:29.790069+00');
INSERT INTO public.notification VALUES ('ca3a0dbc-d663-4b76-a2bd-3e458c0c7d68', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account In_Progress', 'Your account for FundedNext has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-08 20:19:58.088043+00', '2026-02-08 20:19:58.088052+00');
INSERT INTO public.notification VALUES ('43c702c4-7421-418c-a26c-6d1ca99decd6', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Failed', 'Your account for FundedNext has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-08 20:20:28.204812+00', '2026-02-08 20:20:28.204824+00');
INSERT INTO public.notification VALUES ('688b8108-3b28-4f37-b8f4-46443bc0130c', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account In_Progress', 'Your account for FundedNext has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-08 20:20:35.565333+00', '2026-02-08 20:20:35.565345+00');
INSERT INTO public.notification VALUES ('0c46d265-34ae-4e0e-b192-fe6a34663b5e', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Failed', 'Your account for FundedNext has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-08 20:30:33.468172+00', '2026-02-08 20:30:33.468194+00');
INSERT INTO public.notification VALUES ('083a0812-e6cf-4e41-8ddb-3cb9f4966201', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Challenge Update', 'Your FundedNext challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-08 20:30:33.487677+00', '2026-02-08 20:30:33.487686+00');
INSERT INTO public.notification VALUES ('bbd8457a-c9e4-46d1-ae7d-6067143633a1', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account In_Progress', 'Your account for FundedNext has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-08 20:30:40.862895+00', '2026-02-08 20:30:40.862917+00');
INSERT INTO public.notification VALUES ('091ed2c1-be3b-4dd3-b05c-74d75d9e3351', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Execution Started', 'Execution on your FundedNext challenge has begun.', 'EXECUTION_STARTED', false, '2026-02-08 20:30:40.874001+00', '2026-02-08 20:30:40.874023+00');
INSERT INTO public.notification VALUES ('259e5631-7506-48bf-87b8-041c0b55bba9', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Failed', 'Your account for FundedNext has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-08 20:30:58.658912+00', '2026-02-08 20:30:58.658927+00');
INSERT INTO public.notification VALUES ('00b6d0d0-32d1-4eba-8ef7-53d65ce8a9bf', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Challenge Update', 'Your FundedNext challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-08 20:30:58.690733+00', '2026-02-08 20:30:58.690747+00');
INSERT INTO public.notification VALUES ('2ab43d39-0817-4b9d-be97-499f3234bedb', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Passed', 'Your account for FundedNext has been marked as AccountStatus.passed.', 'PASSED_ACCOUNT', false, '2026-02-08 20:31:02.573038+00', '2026-02-08 20:31:02.573051+00');
INSERT INTO public.notification VALUES ('3e7fb0e9-1400-4b1d-b170-57e67995e87c', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Challenge Passed!', 'Congratulations! Your FundedNext challenge has been passed.', 'CHALLENGE_PASSED', false, '2026-02-08 20:31:02.580483+00', '2026-02-08 20:31:02.580498+00');
INSERT INTO public.notification VALUES ('4bf02a95-7eb4-409c-a20b-96cea1c8c5f1', 'd8b9a6b8-0671-488d-8687-7a5ffdea90f5', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-02-08 22:33:55.137757+00', '2026-02-08 22:33:55.137809+00');
INSERT INTO public.notification VALUES ('78b19523-4931-481c-90cc-39fc30b74c85', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account In_Progress', 'Your account for FundedNext has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-09 04:31:42.274469+00', '2026-02-09 04:31:42.274484+00');
INSERT INTO public.notification VALUES ('99ee79d3-6e63-4cd6-bf53-719b6446f2ae', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Execution Started', 'Execution on your FundedNext challenge has begun.', 'EXECUTION_STARTED', false, '2026-02-09 04:31:42.309868+00', '2026-02-09 04:31:42.309883+00');
INSERT INTO public.notification VALUES ('881ff86d-d6a4-41d8-bfab-9c4a2d4ed723', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Updated', 'Your registration details for FundedNext have been updated and verified.', 'GENERAL', false, '2026-02-09 04:38:12.862673+00', '2026-02-09 04:38:12.862691+00');
INSERT INTO public.notification VALUES ('e9d328e9-e678-4d14-a6b9-57a3c9bfaff7', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Updated', 'Your registration details for FundedNext have been updated and verified.', 'GENERAL', false, '2026-02-09 04:38:24.762692+00', '2026-02-09 04:38:24.762701+00');
INSERT INTO public.notification VALUES ('294f8164-d625-4b77-a545-c3c60e7b6de0', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account Passed', 'Your account for FTMO has been marked as AccountStatus.passed.', 'PASSED_ACCOUNT', false, '2026-02-09 04:41:28.787492+00', '2026-02-09 04:41:28.787506+00');
INSERT INTO public.notification VALUES ('77eb1c87-85b6-4132-938a-94147efeec30', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Challenge Passed!', 'Congratulations! Your FTMO challenge has been passed.', 'CHALLENGE_PASSED', false, '2026-02-09 04:41:28.816489+00', '2026-02-09 04:41:28.816503+00');
INSERT INTO public.notification VALUES ('fc38ba96-a011-42ce-9217-43611cef9741', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Failed', 'Your account for FundedNext has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-09 04:41:35.516813+00', '2026-02-09 04:41:35.516833+00');
INSERT INTO public.notification VALUES ('ec7cc537-8675-4a83-9b94-3b93d18bc408', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Challenge Update', 'Your FundedNext challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-09 04:41:35.529285+00', '2026-02-09 04:41:35.529301+00');
INSERT INTO public.notification VALUES ('80f6519c-e4e0-4109-9714-89d2567c719f', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account In_Progress', 'Your account for FundedNext has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-09 05:06:39.501275+00', '2026-02-09 05:06:39.501289+00');
INSERT INTO public.notification VALUES ('014dacfb-71f9-407a-a371-e966513614c9', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Execution Started', 'Execution on your FundedNext challenge has begun.', 'EXECUTION_STARTED', false, '2026-02-09 05:06:39.524031+00', '2026-02-09 05:06:39.524042+00');
INSERT INTO public.notification VALUES ('0cb3b193-6eea-4753-8392-e2f5ce262555', 'e85975ea-02c3-442e-90f9-479f2f690951', NULL, 'PropFirm Account Failed', 'Your account for FundedNext has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-09 05:24:22.130803+00', '2026-02-09 05:24:22.130821+00');
INSERT INTO public.notification VALUES ('46782ba0-ae67-4ef7-becb-dd77fb648487', 'e85975ea-02c3-442e-90f9-479f2f690951', NULL, 'Challenge Update', 'Your FundedNext challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-09 05:24:22.152222+00', '2026-02-09 05:24:22.152234+00');
INSERT INTO public.notification VALUES ('90c3baed-e0d8-41cb-9112-6dd23b58e952', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Failed', 'Your account for FundedNext has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-09 05:24:28.093998+00', '2026-02-09 05:24:28.094011+00');
INSERT INTO public.notification VALUES ('3765ce4a-177d-43a2-bfb7-9140ab5823c0', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Challenge Update', 'Your FundedNext challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-09 05:24:28.103265+00', '2026-02-09 05:24:28.103278+00');
INSERT INTO public.notification VALUES ('306839f8-0427-4c6d-b8d5-0114e3b11b0d', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account Failed', 'Your account for FundingPips has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-09 05:24:28.598091+00', '2026-02-09 05:24:28.598103+00');
INSERT INTO public.notification VALUES ('d1dbf97c-18a7-4500-baf5-6d986e86f4fd', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Challenge Update', 'Your FundingPips challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-09 05:24:28.606166+00', '2026-02-09 05:24:28.606179+00');
INSERT INTO public.notification VALUES ('c9c2b007-440b-47ae-9c1e-6ee50d08bc06', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account Failed', 'Your account for FundingPips has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-09 05:24:29.846907+00', '2026-02-09 05:24:29.846921+00');
INSERT INTO public.notification VALUES ('401d4c7c-ad68-4aa8-b7e2-0095472847f7', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Challenge Update', 'Your FundingPips challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-09 05:24:29.853294+00', '2026-02-09 05:24:29.8533+00');
INSERT INTO public.notification VALUES ('833d7a2d-6ae9-4fd9-a4eb-baf63b5b41ee', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account Failed', 'Your account for FundingPips has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-09 05:24:31.138957+00', '2026-02-09 05:24:31.138968+00');
INSERT INTO public.notification VALUES ('cb899139-70ee-4ac3-9079-7260f4fe929e', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Challenge Update', 'Your FundingPips challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-09 05:24:31.145325+00', '2026-02-09 05:24:31.145335+00');
INSERT INTO public.notification VALUES ('5b5d3109-fb04-4f93-9e61-d7e1c3bd6100', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account Failed', 'Your account for FundingPips has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-09 05:24:32.175949+00', '2026-02-09 05:24:32.175967+00');
INSERT INTO public.notification VALUES ('b48d73b0-ba61-4e63-83a7-11dc835c85c7', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Challenge Update', 'Your FundingPips challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-09 05:24:32.190328+00', '2026-02-09 05:24:32.190341+00');
INSERT INTO public.notification VALUES ('1d158972-30c0-4a80-94d9-4da98fba64af', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account Failed', 'Your account for FTMO has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-09 06:30:35.560209+00', '2026-02-09 06:30:35.560226+00');
INSERT INTO public.notification VALUES ('728f9ebc-8b4f-4975-8841-a1f3b05d1af7', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Challenge Update', 'Your FTMO challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-09 06:30:35.577665+00', '2026-02-09 06:30:35.577675+00');
INSERT INTO public.notification VALUES ('e4c53266-ae29-48ca-8e0a-3e9d56e78c86', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Failed', 'Your account for FundedNext has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-09 06:30:55.959233+00', '2026-02-09 06:30:55.959247+00');
INSERT INTO public.notification VALUES ('bb149210-9286-4c46-87d2-681fa86c172f', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Challenge Update', 'Your FundedNext challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-09 06:30:55.969192+00', '2026-02-09 06:30:55.969199+00');
INSERT INTO public.notification VALUES ('cc99b57c-86aa-441b-be76-fe814cbb84ce', '7658b747-c826-439a-afc6-807d21dc1493', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-02-09 07:06:16.427837+00', '2026-02-09 07:06:16.427864+00');
INSERT INTO public.notification VALUES ('73f0001e-d53e-42ad-a69b-e458e6c18da5', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account Passed', 'Your account for FundedNext has been marked as AccountStatus.passed.', 'PASSED_ACCOUNT', false, '2026-02-09 07:54:26.372946+00', '2026-02-09 07:54:26.372959+00');
INSERT INTO public.notification VALUES ('bf67285b-2b46-480b-bc43-b77b04251421', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Challenge Passed!', 'Congratulations! Your FundedNext challenge has been passed.', 'CHALLENGE_PASSED', false, '2026-02-09 07:54:26.406309+00', '2026-02-09 07:54:26.406317+00');
INSERT INTO public.notification VALUES ('3ee2c62b-905b-4ca4-b422-b78a6a42c73a', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'PropFirm Account In_Progress', 'Your account for FundedNext has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-09 07:54:30.360148+00', '2026-02-09 07:54:30.360162+00');
INSERT INTO public.notification VALUES ('f2ebfac1-5613-4f03-b637-0297d791d984', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Account Login Successful', 'We have successfully logged into your FundedNext account. Your challenge is now moving to execution.', 'GENERAL', false, '2026-02-09 07:54:30.368408+00', '2026-02-09 07:54:30.368421+00');
INSERT INTO public.notification VALUES ('4be1b03c-c794-40c9-9a2b-c5d8fe278d9d', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Execution Started', 'Execution on your FundedNext challenge has begun.', 'EXECUTION_STARTED', false, '2026-02-09 07:54:30.376741+00', '2026-02-09 07:54:30.376753+00');
INSERT INTO public.notification VALUES ('f92cd200-a006-49a4-add2-e9c7882f17bc', 'de36fe56-826b-49e7-9e30-3af9a8e9aa5c', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-2HZME5ST. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-10 04:12:31.780618+00', '2026-02-10 04:12:31.780643+00');
INSERT INTO public.notification VALUES ('39544862-b98d-438c-ba71-f6ac2e5de26e', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-PJD8W3NO. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-10 09:02:50.504251+00', '2026-02-10 09:02:50.50428+00');
INSERT INTO public.notification VALUES ('59cc44d1-da23-4033-911e-6212563bbe11', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-M250HGVJ. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-10 09:02:54.521181+00', '2026-02-10 09:02:54.521201+00');
INSERT INTO public.notification VALUES ('eb0411b8-67c0-42d9-85f6-9f3c9560b1e8', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-025OHQJ2. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-10 09:02:58.908745+00', '2026-02-10 09:02:58.90876+00');
INSERT INTO public.notification VALUES ('ee9db74a-c1c4-4bba-95b6-b19130f4df2c', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-SVGOSNAW. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-10 09:03:07.28515+00', '2026-02-10 09:03:07.285173+00');
INSERT INTO public.notification VALUES ('721085a9-51e2-4300-98f1-93b0d3048168', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-UNICXTH5. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-10 09:03:15.27325+00', '2026-02-10 09:03:15.27326+00');
INSERT INTO public.notification VALUES ('d200fa96-5e9c-4e0e-b399-d36f950e07e2', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account In_Progress', 'Your account for FundingPips has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-10 09:18:38.755797+00', '2026-02-10 09:18:38.755817+00');
INSERT INTO public.notification VALUES ('e8ed6e76-c613-4a81-b0be-5e37aac5a909', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Account Login Successful', 'We have successfully logged into your FundingPips account. Your challenge is now moving to execution.', 'GENERAL', false, '2026-02-10 09:18:38.772103+00', '2026-02-10 09:18:38.772119+00');
INSERT INTO public.notification VALUES ('1936abfe-c65a-4c22-9c1b-0d5c8aacd8e8', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Execution Started', 'Execution on your FundingPips challenge has begun.', 'EXECUTION_STARTED', false, '2026-02-10 09:18:38.780355+00', '2026-02-10 09:18:38.780369+00');
INSERT INTO public.notification VALUES ('62af7977-42a3-4171-8a68-cc14e8f2ad89', 'de36fe56-826b-49e7-9e30-3af9a8e9aa5c', NULL, 'PropFirm Account In_Progress', 'Your account for FundingPips has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-10 09:31:41.096272+00', '2026-02-10 09:31:41.09631+00');
INSERT INTO public.notification VALUES ('cef6b0de-9305-4dc8-9bdd-5676ac19921d', 'de36fe56-826b-49e7-9e30-3af9a8e9aa5c', NULL, 'Account Login Successful', 'We have successfully logged into your FundingPips account. Your challenge is now moving to execution.', 'GENERAL', false, '2026-02-10 09:31:41.108105+00', '2026-02-10 09:31:41.108118+00');
INSERT INTO public.notification VALUES ('a70cf6ef-f010-4cb6-9566-a0205ff3bd09', 'db61433d-25ea-4edb-b3e2-6de586756ef4', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-S53N4GE4. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-10 23:55:23.87186+00', '2026-02-10 23:55:23.871883+00');
INSERT INTO public.notification VALUES ('e16593b2-c3a7-44bc-b029-3497678df3b6', 'de36fe56-826b-49e7-9e30-3af9a8e9aa5c', NULL, 'Execution Started', 'Execution on your FundingPips challenge has begun.', 'EXECUTION_STARTED', false, '2026-02-10 09:31:41.116976+00', '2026-02-10 09:31:41.116984+00');
INSERT INTO public.notification VALUES ('9c7cb516-9061-458e-bbe1-f85e5d7d8c80', '0359bf2e-7216-41ae-b5d0-5b0a1feed859', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-6PZ1ZSAS. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-10 16:58:15.631906+00', '2026-02-10 16:58:15.631953+00');
INSERT INTO public.notification VALUES ('2a8447b6-216f-48a5-b024-5b24af852743', 'd2ff5166-862b-4597-ab3a-e87102ddba87', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-SK0VS2K1. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-15 12:17:07.31566+00', '2026-02-15 12:17:07.315694+00');
INSERT INTO public.notification VALUES ('d5b937e8-af89-42f7-a7a7-b5a6b1f5560f', '1741b8a3-7ee9-49cb-b9e7-97a33e16bae1', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-3QO45J6K. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-16 15:51:10.974612+00', '2026-02-16 15:51:10.974668+00');
INSERT INTO public.notification VALUES ('aa8bb247-1662-4ed3-a554-882fe46a5813', 'c24c11ec-cc55-46c0-bc9a-cd09a73d8211', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-02-17 06:11:42.249575+00', '2026-02-17 06:11:42.249627+00');
INSERT INTO public.notification VALUES ('adddc7f5-9c0f-4181-a387-f02e2ea56ebb', 'd2ff5166-862b-4597-ab3a-e87102ddba87', NULL, 'PropFirm Account In_Progress', 'Your account for FundingPips has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-17 11:54:36.802533+00', '2026-02-17 11:54:36.802578+00');
INSERT INTO public.notification VALUES ('1440c64c-8036-4562-aaff-cbc84e36efbb', 'd2ff5166-862b-4597-ab3a-e87102ddba87', NULL, 'Account Login Successful', 'We have successfully logged into your FundingPips account. Your challenge is now moving to execution.', 'GENERAL', false, '2026-02-17 11:54:36.824037+00', '2026-02-17 11:54:36.824054+00');
INSERT INTO public.notification VALUES ('dd039490-20f4-4d6a-b67b-6324362e635c', 'd2ff5166-862b-4597-ab3a-e87102ddba87', NULL, 'Execution Started', 'Execution on your FundingPips challenge has begun.', 'EXECUTION_STARTED', false, '2026-02-17 11:54:36.84087+00', '2026-02-17 11:54:36.840885+00');
INSERT INTO public.notification VALUES ('ea0e1763-3d2c-47e6-bb52-e629c494f2fd', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account Failed', 'Your account for FundingPips has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-17 11:54:59.694462+00', '2026-02-17 11:54:59.694477+00');
INSERT INTO public.notification VALUES ('7aebaabc-8576-40cd-8227-874ec0175918', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Challenge Update', 'Your FundingPips challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-17 11:54:59.707822+00', '2026-02-17 11:54:59.707841+00');
INSERT INTO public.notification VALUES ('41efdd99-f3ba-4fdb-b081-8d2d2c6c2b0c', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account In_Progress', 'Your account for FundingPips has been marked as AccountStatus.in_progress.', 'GENERAL', false, '2026-02-17 11:55:09.950502+00', '2026-02-17 11:55:09.950519+00');
INSERT INTO public.notification VALUES ('d59dcd69-313e-4d48-9d30-a312c4006413', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Account Login Successful', 'We have successfully logged into your FundingPips account. Your challenge is now moving to execution.', 'GENERAL', false, '2026-02-17 11:55:09.96598+00', '2026-02-17 11:55:09.965996+00');
INSERT INTO public.notification VALUES ('acc7cb3b-4dfa-4d7b-a640-8c51e01783d2', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Execution Started', 'Execution on your FundingPips challenge has begun.', 'EXECUTION_STARTED', false, '2026-02-17 11:55:09.975082+00', '2026-02-17 11:55:09.975093+00');
INSERT INTO public.notification VALUES ('ed841887-701e-4d32-afda-1fa58debeb9b', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'PropFirm Account Failed', 'Your account for FundingPips has been marked as AccountStatus.failed.', 'FAILED_ACCOUNT', false, '2026-02-17 11:55:11.271366+00', '2026-02-17 11:55:11.271378+00');
INSERT INTO public.notification VALUES ('9cd4f0ee-35d3-4c6f-ba35-962a93a5eec3', '3e5be313-a9df-4834-b146-d35dc14e62c4', NULL, 'Challenge Update', 'Your FundingPips challenge status has been updated.', 'CHALLENGE_FAILED', false, '2026-02-17 11:55:11.282721+00', '2026-02-17 11:55:11.282739+00');
INSERT INTO public.notification VALUES ('dabf806a-80c3-45b5-9623-dddfa092852c', '5495ceef-417e-4329-b624-73dbd9ad2355', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-43XQY0HV. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-19 08:15:55.481259+00', '2026-02-19 08:15:55.481282+00');
INSERT INTO public.notification VALUES ('a390b4b9-c274-4aff-af9a-613cd1ea68f6', '8577825a-2a1c-4e8f-a039-aaad5730e91c', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-J49H1MM3. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-22 07:48:27.895257+00', '2026-02-22 07:48:27.895404+00');
INSERT INTO public.notification VALUES ('12c29402-fd03-4a59-9516-d3ccebf00667', 'da5075ec-7b2a-47c4-9830-e51b806b4cd4', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-LOIKM5NI. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-22 10:36:53.78046+00', '2026-02-22 10:36:53.78049+00');
INSERT INTO public.notification VALUES ('060b5b06-ded5-41de-91eb-c27e97f30ca0', '43e93d11-cfbd-4238-a4ee-8931710ea9ad', NULL, 'Password Changed', 'Your password has been successfully updated.', 'PASSWORD_CHANGED', false, '2026-02-22 20:32:05.079592+00', '2026-02-22 20:32:05.079621+00');
INSERT INTO public.notification VALUES ('1687b0c8-c776-405a-aa7f-61c9c62d167e', '48fe238e-fa97-44e4-bf9c-53a961c3a4f4', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-02-24 16:37:02.688831+00', '2026-02-24 16:37:02.688896+00');
INSERT INTO public.notification VALUES ('99b1d5ba-394c-4838-97f1-533758a83d39', '48fe238e-fa97-44e4-bf9c-53a961c3a4f4', NULL, 'Password Changed', 'Your password has been successfully updated.', 'PASSWORD_CHANGED', false, '2026-02-24 16:38:34.000208+00', '2026-02-24 16:38:34.000246+00');
INSERT INTO public.notification VALUES ('f559114b-f310-4e07-8e96-50fa46d475cc', '19dd8dd5-e164-45a2-9cdd-1dcf76da8c7b', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-PVDD700C. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-02-26 15:18:33.830421+00', '2026-02-26 15:18:33.83046+00');
INSERT INTO public.notification VALUES ('0ead0c53-92eb-446e-a481-80a08006ee07', '6eaeb2a8-1907-4da8-93b8-bb0eeaad1440', NULL, 'Password Changed', 'Your password has been successfully updated.', 'PASSWORD_CHANGED', false, '2026-03-02 21:54:28.452121+00', '2026-03-02 21:54:28.452149+00');
INSERT INTO public.notification VALUES ('0cc66e8f-c9bb-453f-a63d-4922a159d32f', '84ed6765-4c60-4fc6-af56-d292a807faf1', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-03-10 03:44:40.476634+00', '2026-03-10 03:44:40.476661+00');
INSERT INTO public.notification VALUES ('8fae84a9-53a9-47e5-bf22-53b663999735', 'c442cf6c-2e6b-4c8c-929a-bce9c55b8876', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-9M9SS0F9. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-03-10 21:22:42.030844+00', '2026-03-10 21:22:42.030877+00');
INSERT INTO public.notification VALUES ('e1772d32-5874-4257-acc5-f016e6cdcf6a', '40bbc698-43bf-47a0-9ca7-3a86f48069b0', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-MEIK2WX2. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-03-13 23:18:52.334715+00', '2026-03-13 23:18:52.334781+00');
INSERT INTO public.notification VALUES ('f06ab043-bf33-485d-8ef8-7af94fdb9742', '0bd1c239-31f4-4271-9624-9fc9c164924d', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-THNQY4BN. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-03-17 10:47:34.275138+00', '2026-03-17 10:47:34.275438+00');
INSERT INTO public.notification VALUES ('48a8dd9d-a4de-4121-8b5c-d7a08ebef2e4', '392683d2-2e31-45b5-a188-c822a514db47', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-03-23 13:11:44.847686+00', '2026-03-23 13:11:44.847704+00');
INSERT INTO public.notification VALUES ('dfe422c7-fbb8-460e-b270-4f6410ab83c5', '7c82a528-83e6-41b2-b7a9-9372f54979d8', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-H5PL4116. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-03-24 04:45:00.131254+00', '2026-03-24 04:45:00.131276+00');
INSERT INTO public.notification VALUES ('525d00f9-e118-4536-92da-6b9c5a60625a', '42bddcee-8831-4c31-8de5-164f64d8743b', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-03-24 07:00:12.56805+00', '2026-03-24 07:00:12.568068+00');
INSERT INTO public.notification VALUES ('de154b9c-453d-4de4-acbb-965194e6f019', '73770b01-1454-4df8-8717-691b21193af2', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-SL4YI35N. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-03-31 22:12:28.586255+00', '2026-03-31 22:12:28.586465+00');
INSERT INTO public.notification VALUES ('4db8d32f-0575-48f2-afc3-fd05c830be3a', 'fa995b0d-e551-4338-b022-ecb0f3dc216b', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-04-15 08:24:35.781008+00', '2026-04-15 08:24:35.781158+00');
INSERT INTO public.notification VALUES ('1d29f18a-fb62-4f28-847e-b3b8df999b88', '7c68be31-5203-4f69-84d3-1ff5b5b2ba0d', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-04-16 06:25:06.126674+00', '2026-04-16 06:25:06.126824+00');
INSERT INTO public.notification VALUES ('bb855203-f2a0-471e-abe1-1ad58cc0cd34', '788204f1-e47f-4d5e-95d1-97ac91cc85d3', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-04-16 21:44:21.213335+00', '2026-04-16 21:44:21.213583+00');
INSERT INTO public.notification VALUES ('7bafbd84-41a0-40d0-b4ab-56174586a178', '6f63012b-1a70-413d-a1ca-ed1dad213622', NULL, 'Registration Created', 'Your FTMO registration has been created. Order ID: PS-J8EYYKYN. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-04-20 03:12:18.308191+00', '2026-04-20 03:12:18.308352+00');
INSERT INTO public.notification VALUES ('20e6711d-cc10-4722-ba3a-7f27e6a5fb8c', '65337816-4751-4629-b875-fefaa64123bb', NULL, 'Password Changed', 'Your password has been successfully updated.', 'PASSWORD_CHANGED', false, '2026-04-24 17:37:26.422087+00', '2026-04-24 17:37:26.422243+00');
INSERT INTO public.notification VALUES ('333d6bbb-7cc6-450c-a9ef-b16139b35a29', '30608326-8d07-4496-a1e8-6d3145cf5505', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-05-11 08:09:06.878633+00', '2026-05-11 08:09:06.878695+00');
INSERT INTO public.notification VALUES ('fea8fe07-fbc1-4602-b5d7-52b1f54c3e25', '6aa0f3e5-e16b-4b9f-89fd-2a6281517059', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-J6GCR09V. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-05-17 21:24:32.293323+00', '2026-05-17 21:24:32.29337+00');
INSERT INTO public.notification VALUES ('bb0fedba-f2b1-4b8f-86f2-0138eef07bbb', '6aa0f3e5-e16b-4b9f-89fd-2a6281517059', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-BQA78U2L. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-05-17 21:25:49.003585+00', '2026-05-17 21:25:49.0036+00');
INSERT INTO public.notification VALUES ('231e3305-210b-4700-8c95-bd95a76a7f30', '458a5e09-49c8-4cb7-988e-5ef4f7017dd1', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-432CMA4V. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-05-18 13:58:17.529347+00', '2026-05-18 13:58:17.529416+00');
INSERT INTO public.notification VALUES ('2361429a-a7bc-4bca-aab5-1121bdd2006d', '75112072-a12d-4ae0-82e2-26749e8bb296', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-RO282E2G. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-05-26 13:33:41.262291+00', '2026-05-26 13:33:41.262306+00');
INSERT INTO public.notification VALUES ('ff776eec-1987-49b6-87ae-d7f722098a49', '99e3e107-4eba-4986-924a-fc22f311b143', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-TDU2EHXN. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-05-30 05:32:50.19856+00', '2026-05-30 05:32:50.198591+00');
INSERT INTO public.notification VALUES ('00af4c1e-5047-4f49-98db-611a36d565fb', 'c136b479-1849-4f56-b4d0-36912a25f0f7', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-Y8X62C1Z. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-06-01 22:10:27.732923+00', '2026-06-01 22:10:27.733134+00');
INSERT INTO public.notification VALUES ('92754cfb-963c-4086-bebd-9a995ce8ad6e', 'd7a308ab-e4e5-4515-b232-559597d2d540', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-06-13 05:18:23.186226+00', '2026-06-13 05:18:23.186409+00');
INSERT INTO public.notification VALUES ('f03cbb0c-5b0f-4c3a-af40-dc01888a80fd', '04ec0171-608c-4572-8b2f-19eec44fc5a0', NULL, 'Registration Created', 'Your FTMO registration has been created. Order ID: PS-0BO2TIMX. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-06-29 15:53:27.230456+00', '2026-06-29 15:53:27.230483+00');
INSERT INTO public.notification VALUES ('05bb4ccd-1f54-4275-90da-435fa4ac78ae', '51c44574-c866-40b2-b5bb-972771097344', NULL, 'Email Verified', 'Your email has been successfully verified. Welcome aboard!', 'EMAIL_VERIFIED', false, '2026-07-02 01:03:27.145462+00', '2026-07-02 01:03:27.14551+00');
INSERT INTO public.notification VALUES ('6892a818-1d2b-4ba9-a811-547442799a6b', 'fc98c945-3906-4df6-8ea7-1b5caae77aa3', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-91RJA0QZ. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-07-09 00:24:24.089279+00', '2026-07-09 00:24:24.089339+00');
INSERT INTO public.notification VALUES ('9f6f875c-3209-4e38-a6be-85553cfeceb6', 'fc98c945-3906-4df6-8ea7-1b5caae77aa3', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-H7A4462D. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-07-09 00:24:33.914871+00', '2026-07-09 00:24:33.914884+00');
INSERT INTO public.notification VALUES ('05e98688-e055-49ad-a3a2-5447551b96ea', '11c50e6a-1018-4331-8069-fba733270d4e', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-CJQAWC14. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-07-17 21:32:47.226187+00', '2026-07-17 21:32:47.226242+00');
INSERT INTO public.notification VALUES ('59f24612-9831-455b-ab74-7b9f611de6a0', '75d45b65-c2d5-4244-9723-174152621383', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-2DNCOZVK. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-07-20 09:05:14.865954+00', '2026-07-20 09:05:14.865974+00');
INSERT INTO public.notification VALUES ('00c03483-114b-492c-a150-c1a97edb9304', '06aca963-1859-4c62-8705-9bca8429bf7c', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-3H7M53OP. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-07-25 09:36:38.078189+00', '2026-07-25 09:36:38.078245+00');
INSERT INTO public.notification VALUES ('375b523d-1aee-4e90-afdd-1004fecf0aff', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Created', 'Your FundingPips registration has been created. Order ID: PS-80B9I7CG. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-08-07 22:38:50.718898+00', '2026-08-07 22:38:50.718945+00');
INSERT INTO public.notification VALUES ('26f46246-a066-4f8e-95fb-7c24a6c58372', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-GJNHH5A5. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-08-07 22:53:50.045581+00', '2026-08-07 22:53:50.045616+00');
INSERT INTO public.notification VALUES ('8bd8ff6d-58ed-448e-b14e-a444b292ce1c', '351bf5af-7807-458a-898d-bc1e80380e97', NULL, 'Registration Created', 'Your FundedNext registration has been created. Order ID: PS-ON81C3GV. Please complete payment to proceed.', 'REGISTRATION_CREATED', false, '2026-08-08 01:59:54.761462+00', '2026-08-08 01:59:54.761482+00');


--
-- Data for Name: payment; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--



--
-- Data for Name: prop_firm_plan; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.prop_firm_plan VALUES ('cc91f6c2-cd9c-4687-afca-b228b4c7095d', 'guaranteed-2-step-step-1', '2-Step Challenge', 'Step 1 Pass Only', 'Best for traders who want help clearing the first stage. We handle Step 1 only. After passing, control is returned to you.', '["You may continue Step 2 yourself", "Or upgrade later to full completion"]', false, NULL, '2026-02-07 16:41:13.192504+00', '2026-02-07 16:41:13.192525+00');
INSERT INTO public.prop_firm_plan VALUES ('63ca042b-4c6f-426a-bb9b-8e6152933ea8', 'guaranteed-2-step-full', '2-Step Challenge', 'Full (Step 1 + Step 2)', 'Best for traders who want the entire challenge completed. We complete both Step 1 and Step 2, then return the passed account to you.', '["Optional access to the PropSol Trading System for funded trading support"]', true, 'MOST CHOSEN', '2026-02-07 16:41:13.220877+00', '2026-02-07 16:41:13.220895+00');
INSERT INTO public.prop_firm_plan VALUES ('7a471a1c-b83e-4ce4-8ac8-22d14baa1b53', 'guaranteed-1-step-full', '1-Step Challenge', 'Full', 'Best for firms with single-phase challenges. We complete the entire 1-Step challenge in one structured phase.', '["Funded account returned to you", "Optional access to the PropSol Trading System"]', false, NULL, '2026-02-07 16:41:13.232934+00', '2026-02-07 16:41:13.232947+00');
INSERT INTO public.prop_firm_plan VALUES ('c42c17da-a12d-4095-9423-e6bba9bdf13a', 'standard-2-step-step-1', '2-Step Challenge', 'Step 1 Pass Only', 'Best for traders who want help clearing the first stage. We handle Step 1 only. After passing, control is returned to you.', '["You may continue Step 2 yourself", "Or upgrade later to full completion"]', false, NULL, '2026-02-07 16:41:13.244053+00', '2026-02-07 16:41:13.24407+00');
INSERT INTO public.prop_firm_plan VALUES ('daa2785f-57cd-473d-b901-841f73bf0e4b', 'standard-2-step-full', '2-Step Challenge', 'Full (Step 1 + Step 2)', 'Best for traders who want the entire challenge completed. We complete both Step 1 and Step 2, then return the passed account to you.', '["Optional access to the PropSol Trading System for funded trading support"]', true, 'MOST CHOSEN', '2026-02-07 16:41:13.26331+00', '2026-02-07 16:41:13.263334+00');
INSERT INTO public.prop_firm_plan VALUES ('c369d14e-71a9-4588-bde3-1d77bbe76522', 'standard-1-step-full', '1-Step Challenge', 'Full', 'Best for firms with single-phase challenges. We complete the entire 1-Step challenge in one structured phase.', '["Funded account returned to you", "Optional access to the PropSol Trading System"]', false, NULL, '2026-02-07 16:41:13.281548+00', '2026-02-07 16:41:13.281566+00');


--
-- Data for Name: prop_firm_plan_price; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.prop_firm_plan_price VALUES ('87596a7f-0979-414a-97e4-6f6e7004de01', '7a471a1c-b83e-4ce4-8ac8-22d14baa1b53', 50000, 1400, '$50k Account', '2026-02-07 16:41:13.237875+00', '2026-02-07 16:41:13.237904+00');
INSERT INTO public.prop_firm_plan_price VALUES ('5c08db3e-3091-42ff-9a01-ac618115261c', '7a471a1c-b83e-4ce4-8ac8-22d14baa1b53', 100000, 1900, '$100k Account', '2026-02-07 16:41:13.238112+00', '2026-02-07 16:41:13.238123+00');
INSERT INTO public.prop_firm_plan_price VALUES ('f3376923-ee50-46bd-9c8c-f6fa8b4f32d6', '7a471a1c-b83e-4ce4-8ac8-22d14baa1b53', 200000, 2600, '$200k Account', '2026-02-07 16:41:13.238292+00', '2026-02-07 16:41:13.238304+00');
INSERT INTO public.prop_firm_plan_price VALUES ('8062d50c-7f9c-43bc-bdcd-7c6cd7b55a8d', '7a471a1c-b83e-4ce4-8ac8-22d14baa1b53', 500000, 3800, '$500k Account', '2026-02-07 16:41:13.238446+00', '2026-02-07 16:41:13.238457+00');
INSERT INTO public.prop_firm_plan_price VALUES ('7792906d-1d41-4376-beee-e70624026671', 'c42c17da-a12d-4095-9423-e6bba9bdf13a', 50000, 490, '$50k Account', '2026-02-07 16:41:13.252025+00', '2026-02-07 16:41:13.252045+00');
INSERT INTO public.prop_firm_plan_price VALUES ('dd60dda1-de22-49f2-9c49-48a73c396fb8', 'c42c17da-a12d-4095-9423-e6bba9bdf13a', 100000, 690, '$100k Account', '2026-02-07 16:41:13.252303+00', '2026-02-07 16:41:13.252314+00');
INSERT INTO public.prop_firm_plan_price VALUES ('5abb123c-a0fa-4ea7-b5a9-a49f85fab816', 'c42c17da-a12d-4095-9423-e6bba9bdf13a', 200000, 990, '$200k Account', '2026-02-07 16:41:13.252449+00', '2026-02-07 16:41:13.25246+00');
INSERT INTO public.prop_firm_plan_price VALUES ('2aba7e20-b29e-4412-a07f-7f3e045b2fca', 'c42c17da-a12d-4095-9423-e6bba9bdf13a', 500000, 1390, '$500k Account', '2026-02-07 16:41:13.252591+00', '2026-02-07 16:41:13.252603+00');
INSERT INTO public.prop_firm_plan_price VALUES ('16f51971-5a5c-464c-8249-1eb8f0887069', 'daa2785f-57cd-473d-b901-841f73bf0e4b', 50000, 690, '$50k Account', '2026-02-07 16:41:13.272778+00', '2026-02-07 16:41:13.272799+00');
INSERT INTO public.prop_firm_plan_price VALUES ('0364cd76-e0aa-49da-9e26-3daa60046a88', 'daa2785f-57cd-473d-b901-841f73bf0e4b', 100000, 890, '$100k Account', '2026-02-07 16:41:13.273059+00', '2026-02-07 16:41:13.273069+00');
INSERT INTO public.prop_firm_plan_price VALUES ('81c00a78-411d-4561-918a-d9e76d818f7e', 'daa2785f-57cd-473d-b901-841f73bf0e4b', 200000, 1290, '$200k Account', '2026-02-07 16:41:13.273192+00', '2026-02-07 16:41:13.273203+00');
INSERT INTO public.prop_firm_plan_price VALUES ('15554959-9363-4d81-8088-93853dfcac57', 'daa2785f-57cd-473d-b901-841f73bf0e4b', 500000, 1790, '$500k Account', '2026-02-07 16:41:13.273341+00', '2026-02-07 16:41:13.273352+00');
INSERT INTO public.prop_firm_plan_price VALUES ('f6f937ee-29d9-4937-b954-42bf8a46af75', 'c369d14e-71a9-4588-bde3-1d77bbe76522', 50000, 1400, '$50k Account', '2026-02-07 16:41:13.288094+00', '2026-02-07 16:41:13.288112+00');
INSERT INTO public.prop_firm_plan_price VALUES ('f64e60f3-1463-480d-ac7c-99f221f47b02', 'c369d14e-71a9-4588-bde3-1d77bbe76522', 100000, 1900, '$100k Account', '2026-02-07 16:41:13.288416+00', '2026-02-07 16:41:13.288428+00');
INSERT INTO public.prop_firm_plan_price VALUES ('a651e8ea-3a54-427f-a112-0da1407ee44b', 'c369d14e-71a9-4588-bde3-1d77bbe76522', 200000, 2600, '$200k Account', '2026-02-07 16:41:13.288535+00', '2026-02-07 16:41:13.288542+00');
INSERT INTO public.prop_firm_plan_price VALUES ('4c859bc0-91c5-4f76-bb82-e405eeeaf61c', 'c369d14e-71a9-4588-bde3-1d77bbe76522', 500000, 3800, '$500k Account', '2026-02-07 16:41:13.288658+00', '2026-02-07 16:41:13.288668+00');
INSERT INTO public.prop_firm_plan_price VALUES ('323c395e-69f1-4b40-8ffb-5afa8be511e2', '63ca042b-4c6f-426a-bb9b-8e6152933ea8', 50000, 1100, '$50k Account', '2026-02-10 09:55:47.064684+00', '2026-02-10 09:55:47.064709+00');
INSERT INTO public.prop_firm_plan_price VALUES ('33e4daa3-a4db-4cae-b434-0e58674ab0a8', '63ca042b-4c6f-426a-bb9b-8e6152933ea8', 100000, 1600, '$100k Account', '2026-02-10 09:55:47.065061+00', '2026-02-10 09:55:47.065074+00');
INSERT INTO public.prop_firm_plan_price VALUES ('af320617-1707-4d73-bc5b-ff22e5b071a7', '63ca042b-4c6f-426a-bb9b-8e6152933ea8', 200000, 2200, '$200k Account', '2026-02-10 09:55:47.065183+00', '2026-02-10 09:55:47.065192+00');
INSERT INTO public.prop_firm_plan_price VALUES ('7423a494-a060-44cd-be66-02fc3e2b3c08', '63ca042b-4c6f-426a-bb9b-8e6152933ea8', 500000, 3200, '$500k Account', '2026-02-10 09:55:47.065283+00', '2026-02-10 09:55:47.065291+00');
INSERT INTO public.prop_firm_plan_price VALUES ('7d5076b2-5e81-4978-933f-fde93cc8158a', 'cc91f6c2-cd9c-4687-afca-b228b4c7095d', 50000, 800, '$50k Account', '2026-02-08 06:42:01.646427+00', '2026-02-08 06:42:01.64645+00');
INSERT INTO public.prop_firm_plan_price VALUES ('b75e8f86-b1bc-464e-9a20-7f090e55a079', 'cc91f6c2-cd9c-4687-afca-b228b4c7095d', 100000, 1200, '$100k Account', '2026-02-08 06:42:01.646822+00', '2026-02-08 06:42:01.646835+00');
INSERT INTO public.prop_firm_plan_price VALUES ('f4fd18de-d28c-4820-a791-447b4fc24505', 'cc91f6c2-cd9c-4687-afca-b228b4c7095d', 200000, 1700, '$200k Account', '2026-02-08 06:42:01.647013+00', '2026-02-08 06:42:01.647025+00');
INSERT INTO public.prop_firm_plan_price VALUES ('2eecddba-0dc9-4b58-8384-642d735b9525', 'cc91f6c2-cd9c-4687-afca-b228b4c7095d', 500000, 2500, '$500k Account', '2026-02-08 06:42:01.647163+00', '2026-02-08 06:42:01.647176+00');


--
-- Data for Name: prop_firm_registration; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.prop_firm_registration VALUES ('af2aa240-caf1-4882-b028-4053f60b4035', '99e3e107-4eba-4986-924a-fc22f311b143', '2545855', 'yeyowep647@alf5.com', 'FundingPips', 'https://example.com', 'llk-iiguy', 'MT5', 2, 2, 'PS-TDU2EHXN', 1600, 100000, 2, 'Metatrader 5', 'No specific rules provided', '210255487545', '@kkkkhjbhyy', 'standard_pass', 'pending', 'pending', '2026-05-30 05:32:50.153039+00', '2026-05-30 05:32:50.153065+00');
INSERT INTO public.prop_firm_registration VALUES ('8b7908f3-6d7b-4e5b-b3f1-6d34329fc0b1', '3e5be313-a9df-4834-b146-d35dc14e62c4', '98457983oi4u', 'posjldfm', 'FundingPips', 'https://example.com', 'posdkjlg', 'MT5', 2, 2, 'PS-SVGOSNAW', 10, 500000, 2, 'Metatrader 5', 'No specific rules provided', '9843lkj', 'kldfnv', 'standard_pass', 'failed', 'pending', '2026-02-10 09:03:07.274641+00', '2026-02-10 09:03:07.274655+00');
INSERT INTO public.prop_firm_registration VALUES ('24e2b6ee-ab74-4dca-acd2-5d52d7b12c7f', '5495ceef-417e-4329-b624-73dbd9ad2355', '159838753', 'Saini@1234', 'FundingPips', 'https://example.com', 'Exness-MT5Real20', 'MT5', 1, 2, 'PS-43XQY0HV', 1900, 100000, 1, 'Metatrader 5', 'No specific rules provided', '+917073839707', 'Mahendra saini ', 'standard_pass', 'pending', 'pending', '2026-02-19 08:15:55.453801+00', '2026-02-19 08:15:55.453819+00');
INSERT INTO public.prop_firm_registration VALUES ('47e414f0-cd3d-4319-93bd-a9243f366870', '8577825a-2a1c-4e8f-a039-aaad5730e91c', '99DA0408', '99DA0408', 'FundedNext', 'https://example.com', 'Funded next-server1', 'MT5', 1, 2, 'PS-J49H1MM3', 1400, 50000, 1, 'Metatrader 5', 'No specific rules provided', '+250796442725', 'kalsajosef5@gmail.com', 'standard_pass', 'pending', 'pending', '2026-02-22 07:48:27.864375+00', '2026-02-22 07:48:27.864442+00');
INSERT INTO public.prop_firm_registration VALUES ('f96ada20-ac97-4b5d-b379-394981fa1514', 'e85975ea-02c3-442e-90f9-479f2f690951', '12345', 'anthonygh', 'FundedNext', 'https://example.com', 'exness', 'MT5', 2, 1, 'PS-V30OUSRY', 490, 50000, 2, 'Metatrader 5', 'No specific rules provided', '+233 505802354', 'Anthony buadee', 'standard_pass', 'pending', 'pending', '2026-02-08 20:00:30.018693+00', '2026-02-08 20:00:30.018708+00');
INSERT INTO public.prop_firm_registration VALUES ('2c248a5f-c43c-4559-a1bd-11d8d68ca0e6', 'da5075ec-7b2a-47c4-9830-e51b806b4cd4', '15727745', '@Milk202', 'FundedNext', 'https://example.com', 'Headway-Real', 'MT5', 2, 1, 'PS-LOIKM5NI', 1390, 500000, 2, 'Metatrader 5', 'No specific rules provided', '09046888688', '@MilkStarr1', 'standard_pass', 'pending', 'pending', '2026-02-22 10:36:53.745618+00', '2026-02-22 10:36:53.745646+00');
INSERT INTO public.prop_firm_registration VALUES ('3b78d983-28fe-4b7f-87f6-5131af795de1', '351bf5af-7807-458a-898d-bc1e80380e97', '12344678998', 'Enchpted!02030304', 'FundedNext', 'https://example.com', 'tesssisng ', 'MT5', 2, 2, 'PS-TNFJ083H', 10, 50000, 2, 'Metatrader 5', 'dkdkdkd', '+2345050505', '@samdavweb', 'standard_pass', 'in_progress', 'completed', '2026-02-08 17:33:42.641171+00', '2026-02-08 17:33:42.641186+00');
INSERT INTO public.prop_firm_registration VALUES ('d19ce010-120c-4b8c-8a49-6e56fa828d22', '3e5be313-a9df-4834-b146-d35dc14e62c4', '98457983oi4u', 'posjldfm', 'FundingPips', 'https://example.com', 'posdkjlg', 'MT5', 2, 2, 'PS-PJD8W3NO', 10, 500000, 2, 'Metatrader 5', 'No specific rules provided', '9843lkj', 'kldfnv', 'standard_pass', 'pending', 'pending', '2026-02-10 09:02:50.487831+00', '2026-02-10 09:02:50.487859+00');
INSERT INTO public.prop_firm_registration VALUES ('32c051c0-5f2d-4c99-8d41-7e19ff4a1e0c', '3e5be313-a9df-4834-b146-d35dc14e62c4', '98457983oi4u', 'posjldfm', 'FundingPips', 'https://example.com', 'posdkjlg', 'MT5', 2, 2, 'PS-M250HGVJ', 10, 500000, 2, 'Metatrader 5', 'No specific rules provided', '9843lkj', 'kldfnv', 'standard_pass', 'pending', 'pending', '2026-02-10 09:02:54.508071+00', '2026-02-10 09:02:54.508099+00');
INSERT INTO public.prop_firm_registration VALUES ('21afaf8e-75cf-437f-af18-1acb82b80937', '3e5be313-a9df-4834-b146-d35dc14e62c4', '98457983oi4u', 'posjldfm', 'FundingPips', 'https://example.com', 'posdkjlg', 'MT5', 2, 2, 'PS-025OHQJ2', 10, 500000, 2, 'Metatrader 5', 'No specific rules provided', '9843lkj', 'kldfnv', 'standard_pass', 'pending', 'pending', '2026-02-10 09:02:58.89788+00', '2026-02-10 09:02:58.897905+00');
INSERT INTO public.prop_firm_registration VALUES ('966a9236-6345-469d-91a8-580445f0a52d', '19dd8dd5-e164-45a2-9cdd-1dcf76da8c7b', '3BEFB914', 'King@2007 ', 'FundedNext', 'https://example.com', 'Fundednext-server', 'MT5', 1, 2, 'PS-PVDD700C', 1900, 100000, 1, 'Metatrader 5', 'No specific rules provided', '+233598457046', 'Kingsford ', 'standard_pass', 'pending', 'pending', '2026-02-26 15:18:33.754392+00', '2026-02-26 15:18:33.75443+00');
INSERT INTO public.prop_firm_registration VALUES ('f97a6421-d81c-469d-b779-90755bc3ac95', '3e5be313-a9df-4834-b146-d35dc14e62c4', '98457983oi4u', 'posjldfm', 'FundingPips', 'https://example.com', 'posdkjlg', 'MT5', 2, 2, 'PS-UNICXTH5', 10, 500000, 2, 'Metatrader 5', 'No specific rules provided', '9843lkj', 'kldfnv', 'standard_pass', 'in_progress', 'completed', '2026-02-10 09:03:15.263696+00', '2026-02-10 09:03:15.263718+00');
INSERT INTO public.prop_firm_registration VALUES ('ba57242c-40a6-4af4-b1ca-7988f37b66e2', 'de36fe56-826b-49e7-9e30-3af9a8e9aa5c', '11560908', '[aR4UyQZ?', 'FundingPips', 'https://example.com', 'FundingPips2-SIM', 'MT5', 2, 2, 'PS-2HZME5ST', 690, 50000, 2, 'Metatrader 5', 'No specific rules provided', '+2347025790024', '@kingsloogbuu', 'standard_pass', 'in_progress', 'pending', '2026-02-10 04:12:31.749814+00', '2026-02-10 04:12:31.749838+00');
INSERT INTO public.prop_firm_registration VALUES ('0e657188-b562-4b0a-875f-b4b748625964', '0359bf2e-7216-41ae-b5d0-5b0a1feed859', 'Hhik cd', 'T6ihr467', 'FundingPips', 'https://example.com', 'Fundryv ', 'MT5', 2, 2, 'PS-6PZ1ZSAS', 1100, 50000, 2, 'Metatrader 5', 'No specific rules provided', '+2348548858006', 'Darren ', 'standard_pass', 'pending', 'pending', '2026-02-10 16:58:15.611719+00', '2026-02-10 16:58:15.611749+00');
INSERT INTO public.prop_firm_registration VALUES ('3047135c-f9ad-498e-b8ea-5c1c4b68b148', 'c442cf6c-2e6b-4c8c-929a-bce9c55b8876', '298883028', 'Adonsi_1', 'FundedNext', 'https://example.com', 'Exness Technologie Ltd', 'MT5', 1, 2, 'PS-9M9SS0F9', 1900, 100000, 1, 'Metatrader 5', 'No specific rules provided', '+2290156562132', '@ibrahimmoubarak9', 'standard_pass', 'pending', 'pending', '2026-03-10 21:22:41.997232+00', '2026-03-10 21:22:41.997251+00');
INSERT INTO public.prop_firm_registration VALUES ('19992fed-e53c-40fd-a8d8-a0c9b2d216f3', '40bbc698-43bf-47a0-9ca7-3a86f48069b0', '5046787702', 'Chibuike601#$', 'FundedNext', 'https://example.com', 'MetaQuotes-Demo', 'MT5', 2, 2, 'PS-MEIK2WX2', 1100, 50000, 2, 'Metatrader 5', 'No specific rules provided', '‎‪+234 8148834980‬', 'Ashley Carolina ', 'standard_pass', 'pending', 'pending', '2026-03-13 23:18:52.302069+00', '2026-03-13 23:18:52.302097+00');
INSERT INTO public.prop_firm_registration VALUES ('9ea92f8b-97eb-4d45-a9b5-9de20b459365', 'db61433d-25ea-4edb-b3e2-6de586756ef4', '32918140', 'enaZN26##', 'FundedNext', 'https://example.com', 'FundedNext-Server3', 'MT5', 2, 2, 'PS-S53N4GE4', 890, 100000, 2, 'Metatrader 5', 'No specific rules provided', '+22372740579', '@AWM02K', 'standard_pass', 'pending', 'pending', '2026-02-10 23:55:23.851246+00', '2026-02-10 23:55:23.851291+00');
INSERT INTO public.prop_firm_registration VALUES ('92cb3eb7-03d8-4647-87e5-fb16de160aca', '0bd1c239-31f4-4271-9624-9fc9c164924d', '314700602', '5#Lo4@uszX', 'FundedNext', 'https://example.com', 'GoatFunded-Server', 'MT5', 1, 2, 'PS-THNQY4BN', 1400, 50000, 1, 'Metatrader 5', 'Daily Drawdown - $150
Max drawdown -$300
Profit target -$1500
Leverage -1:50', '08164564814', 'Frenandezsales', 'standard_pass', 'pending', 'pending', '2026-03-17 10:47:34.246264+00', '2026-03-17 10:47:34.24629+00');
INSERT INTO public.prop_firm_registration VALUES ('5cee0772-8d3e-4913-82e0-e4e7fd350f7f', '7c82a528-83e6-41b2-b7a9-9372f54979d8', '62424043', 'Marcus876brown$', 'FundedNext', 'https://example.com', 'DerivSVG-Server ', 'MT5', 1, 2, 'PS-H5PL4116', 1400, 50000, 1, 'Metatrader 5', 'No specific rules provided', '1876781-4693 ', 'Alex', 'standard_pass', 'pending', 'pending', '2026-03-24 04:45:00.105643+00', '2026-03-24 04:45:00.10567+00');
INSERT INTO public.prop_firm_registration VALUES ('d7b7cb87-c989-4bb5-86c6-86ad7131244a', '73770b01-1454-4df8-8717-691b21193af2', '10010045459', '@chimaobiO2', 'FundingPips', 'https://example.com', 'Metaquotes Ltd ', 'MT5', 2, 2, 'PS-SL4YI35N', 890, 100000, 2, 'Metatrader 5', 'No specific rules provided', '+234 07036848716', 'Ogbonna chimaobi ', 'standard_pass', 'pending', 'pending', '2026-03-31 22:12:28.541615+00', '2026-03-31 22:12:28.541637+00');
INSERT INTO public.prop_firm_registration VALUES ('135e4992-79be-45de-b1ee-bf58a7a90596', '1741b8a3-7ee9-49cb-b9e7-97a33e16bae1', '295520316', '42Mama_15', 'FundingPips', 'https://example.com', 'Exness-MT5Real27', 'MT5', 2, 1, 'PS-3QO45J6K', 490, 50000, 2, 'Metatrader 5', 'No specific rules provided', '09013862943', 'Gramm', 'standard_pass', 'pending', 'pending', '2026-02-16 15:51:10.947421+00', '2026-02-16 15:51:10.947444+00');
INSERT INTO public.prop_firm_registration VALUES ('0c8b7ccd-75b6-40d9-8d03-2c34b8e36bd9', 'd2ff5166-862b-4597-ab3a-e87102ddba87', '11598553', '.%QbqN#5n', 'FundingPips', 'https://example.com', 'FundingPips2-SIM', 'MT5', 2, 2, 'PS-SK0VS2K1', 690, 50000, 2, 'Metatrader 5', 'No specific rules provided', '+61406903992', '@Doug.', 'standard_pass', 'in_progress', 'completed', '2026-02-15 12:17:07.273679+00', '2026-02-15 12:17:07.273705+00');
INSERT INTO public.prop_firm_registration VALUES ('b13a5618-49d1-4929-91d2-ff446fff12a4', 'c136b479-1849-4f56-b4d0-36912a25f0f7', '16732694', '$n7Xh7A)', 'FundedNext', 'https://example.com', 'Weltrade ', 'MT5', 1, 2, 'PS-Y8X62C1Z', 1900, 100000, 1, 'Metatrader 5', 'No specific rules provided', '+260762402380', '@axess_alpha', 'standard_pass', 'pending', 'pending', '2026-06-01 22:10:27.633379+00', '2026-06-01 22:10:27.633538+00');
INSERT INTO public.prop_firm_registration VALUES ('3b27cd1a-c7eb-43af-b7ae-e6c9b8a9b532', '6f63012b-1a70-413d-a1ca-ed1dad213622', '44665767565', '67ryrtyewerwes', 'FTMO', 'https://example.com', 'demo', 'MT5', 2, 2, 'PS-J8EYYKYN', 1100, 50000, 2, 'Metatrader 5', 'No specific rules provided', '8o675432456', '65456785', 'standard_pass', 'pending', 'pending', '2026-04-20 03:12:18.245085+00', '2026-04-20 03:12:18.24512+00');
INSERT INTO public.prop_firm_registration VALUES ('a902b585-0cfd-4342-8b1e-d5e46d86ede3', '6aa0f3e5-e16b-4b9f-89fd-2a6281517059', '163091170', 'Jessypavion@20', 'FundingPips', 'https://example.com', 'Exness-MT5Real22', 'MT5', 1, 2, 'PS-J6GCR09V', 1400, 50000, 1, 'Metatrader 5', 'No specific rules provided', '5977641844', 'Jessypavion', 'standard_pass', 'pending', 'pending', '2026-05-17 21:24:32.149061+00', '2026-05-17 21:24:32.149225+00');
INSERT INTO public.prop_firm_registration VALUES ('686c073d-d9ec-4925-b832-d84bc21d91d0', '6aa0f3e5-e16b-4b9f-89fd-2a6281517059', '163091170', 'Jessypavion@20', 'FundingPips', 'https://example.com', 'Exness-MT5Real22', 'MT5', 1, 2, 'PS-BQA78U2L', 1400, 50000, 1, 'Metatrader 5', 'No specific rules provided', '5977641844', 'Jessypavion', 'standard_pass', 'pending', 'pending', '2026-05-17 21:25:48.981854+00', '2026-05-17 21:25:48.981878+00');
INSERT INTO public.prop_firm_registration VALUES ('356bb89e-6501-406e-b587-472b27f88563', '458a5e09-49c8-4cb7-988e-5ef4f7017dd1', '140477467', 'Mach258# ', 'FundedNext', 'https://example.com', 'DerivAVG-Server-03', 'MT5', 2, 2, 'PS-432CMA4V', 1100, 50000, 2, 'Metatrader 5', 'No specific rules provided', '862797892', '@MarketMastersAsistence', 'standard_pass', 'pending', 'pending', '2026-05-18 13:58:17.489492+00', '2026-05-18 13:58:17.489518+00');
INSERT INTO public.prop_firm_registration VALUES ('3525dee3-2c54-474f-8630-c228d69e5fbd', '75112072-a12d-4ae0-82e2-26749e8bb296', '20000', 'Supa11', 'FundedNext', 'https://example.com', 'Fundednext', 'MT5', 2, 2, 'PS-RO282E2G', 890, 100000, 2, 'Metatrader 5', 'No specific rules provided', '+233599450661', 'Braenkasa', 'standard_pass', 'pending', 'pending', '2026-05-26 13:33:41.214407+00', '2026-05-26 13:33:41.214432+00');
INSERT INTO public.prop_firm_registration VALUES ('87c66394-d75c-4de9-a864-5250a3199b78', '04ec0171-608c-4572-8b2f-19eec44fc5a0', '223736561', 'Emma720#*', 'FTMO', 'https://example.com', 'Exness-MT5Real30', 'MT5', 2, 1, 'PS-0BO2TIMX', 800, 50000, 2, 'Metatrader 5', 'No specific rules provided', '+237 672603304', 'Emma720', 'standard_pass', 'pending', 'pending', '2026-06-29 15:53:27.10283+00', '2026-06-29 15:53:27.102852+00');
INSERT INTO public.prop_firm_registration VALUES ('8ad6645d-ab06-467a-88a3-2d1317bddd56', 'fc98c945-3906-4df6-8ea7-1b5caae77aa3', '591794793', 'Z@ki3218', 'FundedNext', 'https://example.com', 'FxPro-MT5 Demo', 'MT5', 2, 1, 'PS-91RJA0QZ', 800, 50000, 2, 'Metatrader 5', 'No specific rules provided', '+252672023436', '@Mr_well_drive', 'standard_pass', 'pending', 'pending', '2026-07-09 00:24:24.016585+00', '2026-07-09 00:24:24.016647+00');
INSERT INTO public.prop_firm_registration VALUES ('86fec1d5-d235-48b1-b58d-26bf900560ff', 'fc98c945-3906-4df6-8ea7-1b5caae77aa3', '591794793', 'Z@ki3218', 'FundedNext', 'https://example.com', 'FxPro-MT5 Demo', 'MT5', 2, 1, 'PS-H7A4462D', 800, 50000, 2, 'Metatrader 5', 'No specific rules provided', '+252672023436', '@Mr_well_drive', 'standard_pass', 'pending', 'pending', '2026-07-09 00:24:33.89012+00', '2026-07-09 00:24:33.890156+00');
INSERT INTO public.prop_firm_registration VALUES ('836ed137-e46a-4649-9c49-e2fcbc0811c9', '11c50e6a-1018-4331-8069-fba733270d4e', '223822306', 'Ch1kweng008$', 'FundedNext', 'https://example.com', 'Exness-MT5Real30', 'MT5', 2, 2, 'PS-CJQAWC14', 1790, 500000, 2, 'Metatrader 5', 'No specific rules provided', '0719030569', 'KING', 'standard_pass', 'pending', 'pending', '2026-07-17 21:32:47.031673+00', '2026-07-17 21:32:47.031715+00');
INSERT INTO public.prop_firm_registration VALUES ('58dead01-bf46-4b90-b4c7-1512ee4cc27d', '75d45b65-c2d5-4244-9723-174152621383', '436619063', '@Milk202', 'FundingPips', 'https://example.com', 'Exness-MT5Trial9', 'MT5', 2, 2, 'PS-2DNCOZVK', 1790, 500000, 2, 'Metatrader 5', 'No specific rules provided', '07039469191', 'Amin Cool ', 'standard_pass', 'pending', 'pending', '2026-07-20 09:05:14.814566+00', '2026-07-20 09:05:14.814591+00');
INSERT INTO public.prop_firm_registration VALUES ('dd717e67-2320-4efc-abb2-4ab4dbf85953', '06aca963-1859-4c62-8705-9bca8429bf7c', '212696377', 'Simeon-02', 'FundingPips', 'https://example.com', 'Exness-Real33', 'MT5', 1, 2, 'PS-3H7M53OP', 1900, 100000, 1, 'Metatrader 5', 'No specific rules provided', '70553086', 'SIMI-USI ', 'standard_pass', 'pending', 'pending', '2026-07-25 09:36:38.018272+00', '2026-07-25 09:36:38.018302+00');
INSERT INTO public.prop_firm_registration VALUES ('2dcab597-fc00-4cc8-8b53-f9f07cba0029', '351bf5af-7807-458a-898d-bc1e80380e97', 'techio.com.ng@gmail.com', 'Encrypted@103', 'FundingPips', 'https://example.com', 'FundedNext-Server', 'MT5', 2, 1, 'PS-80B9I7CG', 450, 100000, 2, 'MT5', 'No specific rules provided', '+23470948484', '@samsav', 'standard_pass', 'pending', 'pending', '2026-08-07 22:38:50.667406+00', '2026-08-07 22:38:50.667433+00');
INSERT INTO public.prop_firm_registration VALUES ('8bd77653-c0fd-4a6e-bc83-6f943c97c339', '351bf5af-7807-458a-898d-bc1e80380e97', 'techio.com.ng@gmail.com', 'Encrypted@103', 'FundedNext', 'https://example.com', 'FundedNext-Server', 'MT5', 2, 2, 'PS-GJNHH5A5', 450, 50000, 2, 'MT5', 'No specific rules provided', 'vbgfgbgnghnh', 'n gnhhyum', 'standard_pass', 'pending', 'pending', '2026-08-07 22:53:50.025136+00', '2026-08-07 22:53:50.025156+00');
INSERT INTO public.prop_firm_registration VALUES ('6e45ee70-2c92-422a-9aca-6100b473060c', '351bf5af-7807-458a-898d-bc1e80380e97', 'otopopttpomtrpo', 'rklmtrmtttrnnltrn', 'FundedNext', 'https://example.com', 'Funded-NextServer', 'MT5', 2, 1, 'PS-ON81C3GV', 1700, 200000, 2, 'Metatrader 5', 'c dk df ldnk fkj kj fkj', '+234708484', '@samdvwed', 'standard_pass', 'pending', 'pending', '2026-08-08 01:59:54.705156+00', '2026-08-08 01:59:54.705182+00');


--
-- Data for Name: referral_earning; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--



--
-- Data for Name: support; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.support VALUES ('b57e1d8b-5fe1-4aa5-96cf-69ecee862d87', 'Kingsley Ogbu', 'ogbu54321@gmail.com', '07025790024', 'You were not able to pass my profirm challenge account. Should I give you another one to try or you refund me immediately?', '2026-03-25 06:22:43.77202+00');
INSERT INTO public.support VALUES ('7923ff2c-ec33-422f-8e68-b6bf5e27c2c8', 'ERIC FOKI SIMEU', 'fokiroyalnig@gmail.com', '+234 7061193485', 'I want to give you 50k account on audacity. how do I proceed', '2026-07-28 03:58:14.675018+00');


--
-- Data for Name: support_message; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.support_message VALUES ('4595d1c9-f07d-4d68-8648-5dfe86bc46f7', '27c10da8-afe8-4f4e-9ee4-89c0da9d6689', '351bf5af-7807-458a-898d-bc1e80380e97', 'USER', 'Support test 101', '2026-02-09 06:10:37.364412+00');
INSERT INTO public.support_message VALUES ('0c9c0184-21c3-43a5-b2d8-364f3c0b7c7a', '27c10da8-afe8-4f4e-9ee4-89c0da9d6689', 'c050d0a9-ff23-4a6b-9302-43c64ed0d9ca', 'ADMIN', 'ok', '2026-02-09 18:57:57.14533+00');
INSERT INTO public.support_message VALUES ('f6c949d1-2c3e-4c3c-a1f9-2a57e008a4da', '1a58ba21-f8fa-428a-8d1b-56db178710d0', 'de36fe56-826b-49e7-9e30-3af9a8e9aa5c', 'USER', 'I made payment for over 1 hour and it''s showing partial paid since then. Help me resolve it because the page has timeout and I never showed I paid ', '2026-02-10 06:47:10.271677+00');
INSERT INTO public.support_message VALUES ('d8fbfb52-b2c9-41c0-aa10-bb4045fc8093', '1a58ba21-f8fa-428a-8d1b-56db178710d0', '9d252819-da89-4665-9192-958a8627d02a', 'ADMIN', 'Hello. Please confirm you received our last email. Thank you', '2026-02-10 09:43:13.006882+00');
INSERT INTO public.support_message VALUES ('2a97bfe7-c4ae-4447-bcba-ac3f6cc0891d', '1a58ba21-f8fa-428a-8d1b-56db178710d0', 'de36fe56-826b-49e7-9e30-3af9a8e9aa5c', 'USER', 'If I understand very well, it means my payment was received?', '2026-02-10 10:08:03.170434+00');
INSERT INTO public.support_message VALUES ('cd0f7a53-4f56-45d8-bfa2-56d0d4f450f4', '1a58ba21-f8fa-428a-8d1b-56db178710d0', 'de36fe56-826b-49e7-9e30-3af9a8e9aa5c', 'USER', 'I also advise that u use comfirmo or another crypto payment in your plugin for checkout because this currenct one is really annoying. I spent over 2hour waiting for my payment to say successful but never saw that. I was really worried. This is money issue and better payment should be used not the one that is giving customers tension ', '2026-02-10 10:11:04.005099+00');
INSERT INTO public.support_message VALUES ('7cbf963f-7f63-4107-91a6-06f78431c9d8', '1a58ba21-f8fa-428a-8d1b-56db178710d0', '9d252819-da89-4665-9192-958a8627d02a', 'ADMIN', 'Thank you for your feedback. And yes, your account is already in progress. Thank you for reaching out.', '2026-02-11 17:41:01.195689+00');
INSERT INTO public.support_message VALUES ('f2c901c7-49bf-4104-bb71-c805f17e0519', '8e671d0d-38d4-4587-bc85-31ef690d8806', 'd2ff5166-862b-4597-ab3a-e87102ddba87', 'USER', 'It my first timenif using this platform.
Just bought $50,000 2 steps challenge. I want you guys to help me pass both stages. 
I have made payment already.
Just want to know when will trading activities start in this account?. ', '2026-02-15 12:44:27.691081+00');
INSERT INTO public.support_message VALUES ('f56cbde9-ba95-4c51-bdd5-32e799486659', '8e671d0d-38d4-4587-bc85-31ef690d8806', '1572a49d-0cfb-4953-a24f-1079bde52d7f', 'ADMIN', 'Hello Douglas, thank you for your patience. Your payment has been received and confirmed. Trading activities on your account will begin within the next few hours.', '2026-02-17 11:03:46.854255+00');
INSERT INTO public.support_message VALUES ('6130f471-9236-431c-ab8f-c709ebab62f1', '8e671d0d-38d4-4587-bc85-31ef690d8806', '9d252819-da89-4665-9192-958a8627d02a', 'ADMIN', 'Hello. We''ve been reaching out to you to forward correct login details. Kindly respond to our email to begin trading activities on your account please.', '2026-02-20 22:48:45.702401+00');


--
-- Data for Name: support_ticket; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.support_ticket VALUES ('27c10da8-afe8-4f4e-9ee4-89c0da9d6689', '351bf5af-7807-458a-898d-bc1e80380e97', 'Testing', 'RESOLVED', 'HIGH', '2026-02-09 06:10:37.335731+00', '2026-02-09 18:58:06.472827+00');
INSERT INTO public.support_ticket VALUES ('1a58ba21-f8fa-428a-8d1b-56db178710d0', 'de36fe56-826b-49e7-9e30-3af9a8e9aa5c', 'Payment system problem ', 'IN_PROGRESS', 'URGENT', '2026-02-10 06:47:10.251155+00', '2026-02-11 17:41:01.207033+00');
INSERT INTO public.support_ticket VALUES ('8e671d0d-38d4-4587-bc85-31ef690d8806', 'd2ff5166-862b-4597-ab3a-e87102ddba87', 'Just punches  2 step pass challenge.', 'IN_PROGRESS', 'MEDIUM', '2026-02-15 12:44:27.662791+00', '2026-02-20 22:48:45.715805+00');


--
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--



--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public."user" VALUES ('351bf5af-7807-458a-898d-bc1e80380e97', 'techio.com.ng@gmail.com', 'Sd Luiz', '$2b$12$DlozyNzD/vSseVthqlHQW.3cJdEEA3UsKjDG7VFK5p/mKFXTEIvKS', true, '6VA3RA3L6YSX', true, '2026-02-02 12:24:09.298298+00', '2026-02-02 12:24:09.298315+00', NULL);
INSERT INTO public."user" VALUES ('cd828787-7787-4a97-92bc-abd33b50a3a3', 'bloggers694@gmail.com', 'Test User', '$2b$12$7/KcyZjx6rON0bEENigWj.O0oM5WZbhxHtWANTcgqLbgrmej/bKje', true, 'K0Y1O3VEZLO2', true, '2026-02-02 14:40:46.756781+00', '2026-02-02 14:40:46.756799+00', NULL);
INSERT INTO public."user" VALUES ('3e5be313-a9df-4834-b146-d35dc14e62c4', 'victoretb5@gmail.com', 'Victory Omoike', '$2b$12$ZE/oCVBqX4lDaywfSkaQZuoYmSTZT4XrfqKUEDZMfjCmz6pf.dRa.', true, 'PJRI9LDHWDIU', false, '2026-02-05 12:30:38.502531+00', '2026-02-05 12:30:38.502551+00', NULL);
INSERT INTO public."user" VALUES ('8ff7d590-67f6-48e7-8d3c-ddf2519997d0', 'victorbarnabas24@gmail.com', 'Victor Barnabas', '$2b$12$yG96yLAPJ6diW2HIYKcv5OiZemu6hMkwpbbMbVrJMNEEKtoZVU5LS', true, 'HNI590UJVF6G', true, '2026-02-06 12:50:15.613792+00', '2026-02-06 12:50:15.613816+00', NULL);
INSERT INTO public."user" VALUES ('037b746b-b479-4f68-8df3-07edbd1dc93d', 'jlotjame@gmail.com', 'Lotanna  Chibueze', '$2b$12$9zuUiYgrsxQaXr7I6Aa8Fefn6Mfm3n6qbTtU9kqSBdg6eG0iR91fm', true, 'HIJHO5LOVNGK', false, '2026-02-08 19:23:03.299838+00', '2026-02-08 19:23:03.299865+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('17c302ab-2d35-4424-885d-07596b79bf0e', 'faisy8647@gmail.com', 'FAISAL SALEEM', '$2b$12$vz0pHMGidmHbeagfx/Y8Qe7mdmyMciZlT2Fjc.P6SYeJXH1LVTHFC', true, 'U4X5XQKBAR5H', false, '2026-02-08 19:30:18.764533+00', '2026-02-08 19:30:18.764568+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c7591415-9635-4060-848d-faaf39b3bf56', 'olubunmi3@gmail.com', 'Olubunmi Egberongbe', '$2b$12$7b7nqTvTnWJGuKZSKmgEQOHQwk/WpVoxfB6Rh.8JF93BgAcS4PSBi', true, 'CD8BG2JAQGHA', false, '2026-02-08 19:31:20.912644+00', '2026-02-08 19:31:20.912662+00', NULL);
INSERT INTO public."user" VALUES ('bc2dbdce-da96-498d-9eaf-13ff2d9280aa', 'brightbundle129@gmail.com', 'BRIGHT Emmanuel', '$2b$12$/BCumwt5vCv/JeAqvO0Y4uFFHo8T9JNZAUBWO15gaPYJuKEsmOQdi', true, 'RCK35QMOFNWC', false, '2026-02-08 19:34:39.000449+00', '2026-02-08 19:34:39.000466+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e85975ea-02c3-442e-90f9-479f2f690951', 'anthonybuadee456@gmail.com', 'Anthony Buadee', '$2b$12$ods9BzviI2PDAj9y7l191OAA0LAbvc3iF/HH82dr9TER.cBksh38q', true, 'PGBJZZX8VPM4', false, '2026-02-08 19:35:33.007433+00', '2026-02-08 19:35:33.00746+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('69992d47-cc40-4906-b8ae-d7f45bcf0501', 'aladesamsonmayowa@gmail.com', 'Alade Samson mayowa', '$2b$12$rVaxZr1BOEWhsGbA9wQiie6QnrPjIefo4J576as16NoK8gCG0Q6oi', true, 'PMNUVBYEKG08', false, '2026-02-08 19:36:22.143664+00', '2026-02-08 19:36:22.143682+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c81526f3-d7ef-44ed-8431-f095f00ac1d3', 'chibundui005@gmail.com', 'Chibundu Izuchukwu', '$2b$12$roulJNwgBVoQEtffTVv26OmHP5fuSNKBhXGwH00slyYsv8Y9ePHkK', true, '6017EJI0OMGM', false, '2026-02-08 19:36:31.003437+00', '2026-02-08 19:36:31.003459+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3e6d8ec2-3756-437a-b6e9-2dfc04bfa95b', 'royelie88@hotmail.com', 'Roy Elie', '$2b$12$q2kE38HVCXeU7OGMgXjdruhvflhj.qAsAB0n/oa5vaoHhEPEGQogu', true, 'KAXFLTNRRYC8', false, '2026-02-08 19:37:19.520116+00', '2026-02-08 19:37:19.520142+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b9110454-530d-4df6-9ddb-d68a28221ad9', 'dickekiru016@gmail.com', 'dickson ekiru', '$2b$12$OU1AV7Q2qEKN8PHtbahHW.rzHccUMTLC9EPRXwpNP6Upakdr2twJe', true, 'XZHWCIK4W8KL', false, '2026-02-08 19:39:01.244116+00', '2026-02-08 19:39:01.244156+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e24cce52-d8b7-4b11-b058-beb1e39be35e', 'jamesgason@yshoo.com', 'James Simon', '$2b$12$cB3G/8jOWIiDlM2zo8ePBehSMWXjn7eqe3TkX.fMql3MsFKn65WRS', true, '5GWMSEVOHKZ2', false, '2026-02-08 19:40:34.848749+00', '2026-02-08 19:40:34.848779+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9901961b-6e73-428f-8f53-9fed7757c1d4', 'tuyizereleandre69@gmail.com', 'Tuyizere Leandre', '$2b$12$fGCHqIfSBeuiFFlsGQHZjOdGcvzgFkByBLUFO6cRCpo8igrmRjcsa', true, 'Z7G8E701K1D5', false, '2026-02-08 20:55:15.874907+00', '2026-02-08 20:55:15.87493+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6044e04e-7ae1-4c2f-be7e-c6dcd7059814', 'samrosco22@gmail.com', 'Tosin Oladeinde', '$2b$12$tzVertATKEMStXGZ80JLxO3jEEW2HkJQIG0Cdv43Uv0YUaCYHZ8Ba', true, 'DSF95KBKRZ29', true, '2026-02-08 19:38:21.566443+00', '2026-02-08 19:38:21.566467+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f928eecb-a963-4c6b-b6e5-c744f699999d', 'rex.apeh@yahoo.com', 'Rex Apeh', '$2b$12$MlwLSNil39RhQ1f060xMRe8nl35kOZifwetQQWudBPGuIIR1FbJNW', true, '4LPCTP87O9U5', false, '2026-02-08 19:45:48.802576+00', '2026-02-08 19:45:48.802602+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('031ea2fb-b200-4deb-ae46-8a79c52851c9', 'judeadd@gmail.com', 'Jude Kwabena Nyarko  Adu - Addai', '$2b$12$2vAur9npwA2BpebLhomI4OvhMt3BomWV61iu6DRrr4967avrAAC3C', true, 'C0O476TF35CK', false, '2026-02-08 19:45:54.875039+00', '2026-02-08 19:45:54.875077+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7be77d40-d313-422d-b917-b7ee14330e7e', 'goodnewsokon848@gmail.com', 'Gooodnews Okon', '$2b$12$xwdkwXhRpDQRiat2irtsZORFSUsguMtmXeT/zlU40zu1pml02/4GK', true, 'YIVH9YZTK7IY', false, '2026-02-08 19:46:35.833618+00', '2026-02-08 19:46:35.833639+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0767d727-e8af-4a29-9bac-26f7266f66c5', 'samirsalehisa@gmail.com', 'Eisa Salih', '$2b$12$TVs.RtEeOWol03P0K8yLu.MznHT5oF5hfQzRixuWliG6LAbw7GEK6', true, 'G5DMHSFXY6P6', false, '2026-02-08 19:55:34.569611+00', '2026-02-08 19:55:34.569636+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a91f2746-5b9f-49dc-b3f0-237ddc31b2ef', 'ichadivineblessing@gmail.com', 'Divine Icha', '$2b$12$iEkfrCZKQqd9wQGBJcocme4SWRJRR8jRERbtN2J/ZyXPwP0hxnqcC', true, '7VDGMB19BQ6X', false, '2026-02-08 19:57:55.183786+00', '2026-02-08 19:57:55.183811+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6f9b6484-7772-48d4-9645-7033aa3d3445', 'asaremensah578@gmail.com', 'Asare Mensah Emmanuel', '$2b$12$Lk4X4SuYywoXqvHljeX0UeuwxuZpHg3chupeqKunrRceY.f8GCj4e', true, '5HSLP9YXEPV6', false, '2026-02-08 20:01:50.582041+00', '2026-02-08 20:01:50.582066+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('412a142f-998c-4b7d-be5a-9dd7e5ad943c', 'Beowolf347@hotmail.com', 'Ian Campbell', '$2b$12$Q4H0vfxV6ufCCbRdgmk4E.HClAP/mF7a5IjDfQQIXZ3bfD35fGike', true, 'PGR9UJP5JOKM', false, '2026-02-08 20:02:29.232028+00', '2026-02-08 20:02:29.232045+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c193e35c-9b03-416c-a121-7b3b8bd169a6', 'songezo29@gmail.com', 'Songezo Lila', '$2b$12$MyFEvVSSc15nKLQcMkycceGwdxn6va2W3hzqcsKF7wxsquwVFbcAW', true, 'KO39Y634PYZL', false, '2026-02-08 20:06:29.039314+00', '2026-02-08 20:06:29.039333+00', NULL);
INSERT INTO public."user" VALUES ('4f324965-2425-44ee-8bd8-b050d90d060f', 'anidenice@gmail.com', 'Aniefiok Udosen', '$2b$12$4foaqqUQkwHoIYLkZZ1IBeZJjoW3G9HSkj6..XV/tIslNBsxpFRUC', true, 'VZ9RGHODLA8T', false, '2026-02-08 20:07:06.065757+00', '2026-02-08 20:07:06.065774+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f3531376-408f-457d-b0d9-c922f1a8b989', 'chidubemchukwu59@gmail.com', 'Chidubem Chukwu', '$2b$12$GCCgNUSm9QUsxBjgLseBRuXiza4E7sJ46BGTco4O3x/9Zr9OfxZNO', true, '0M5U5927C1R0', false, '2026-02-08 20:09:08.23299+00', '2026-02-08 20:09:08.233017+00', NULL);
INSERT INTO public."user" VALUES ('e4610561-febf-4d69-814b-f62c4191fc77', 'manueliscalm045@gmail.com', 'Javon Howard l', '$2b$12$uHy5uKDUs9MIX6rMKPS5juKFng9L4fkl7RCiRNYNLEYwdUGkeeF4e', true, 'IC8E03TP7DTS', false, '2026-02-08 20:14:38.667729+00', '2026-02-08 20:14:38.667748+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('46f5867d-e34d-453d-ad52-6a11f4b8ffbe', 'olatayo.femi@gmail.com', 'olatayo femi', '$2b$12$AgfR.78Bhse4Yi0itKh43u/Qmlfcn36USXb99NtpubG/Dg/DnKNsu', true, 'QNUYUF2YIY4A', false, '2026-02-08 20:17:51.977602+00', '2026-02-08 20:17:51.977644+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('337b3f0e-8019-4923-a6ff-7890a2454506', 'm90983986@gmail.com', 'MORUTI JIMMY Jimmy Setagane', '$2b$12$YhGYWU4PzpJMYRqOMTFSGOSkvG/qIO7kiCbzBfQuwOZ.c3UoQeaTe', true, '9AO2L3SPXGIP', false, '2026-02-08 20:23:27.657121+00', '2026-02-08 20:23:27.657139+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4ce8bd35-6166-47c5-bae2-caf8a9c05116', 'teninye@gmail.com', 'Elkanah Ninye Thomas', '$2b$12$n4HdMBKC6II3mOoY.PZmkOleacTvDCo7yRTIrJfeRyevnjFkg19We', true, '1CCOTYPY7JLL', false, '2026-02-08 20:32:27.658761+00', '2026-02-08 20:32:27.658786+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9f4abab1-ff6e-4aea-a329-d6e2d7b2361d', 'burtonmwesa@gmail.com', 'Burton Mwakilasa', '$2b$12$gLyFZNc0e6lPyKPGLmHDFeUspyqh.RH7QT6pfNqWIoqlaAweBTaU.', true, '97PHZ2H6L4OZ', false, '2026-02-08 20:33:40.828151+00', '2026-02-08 20:33:40.828169+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d20640d6-8ab0-4547-ab14-6f4dba3f62ef', 'laitramebit08@gmail.com', 'Martial Tra', '$2b$12$33oMc2.jeeXk6/AyvBoCo.BSJRiUv1h3iZ9Uwn2cHb4BL5TqUR0i6', true, 'PDOY84X3SJIG', false, '2026-02-08 20:35:41.783626+00', '2026-02-08 20:35:41.783655+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8ab42681-9282-4890-95bb-4af6bd8e0e87', 'felixcha1738@gmail.com', 'Felix Chanda', '$2b$12$AoVLIABaBDZXvn3Y57.sa.UcrCm.R6ywZOkoTrumB3Tj.PmiSy/oK', true, 'Z131RRWHXQ3X', false, '2026-02-08 20:40:33.635403+00', '2026-02-08 20:40:33.635421+00', NULL);
INSERT INTO public."user" VALUES ('094516e7-d7c2-4be3-a3d2-56642e88e840', 'josiahbarrett204@gmail.com', 'Josiah Barrett', '$2b$12$/DJzY3uMCAh36ZknUREVrOM.8KrM644qX.UHe.Rza8qdxZtKNt0wS', true, 'TL7XDDEWA0YQ', false, '2026-02-08 20:40:47.652745+00', '2026-02-08 20:40:47.652769+00', NULL);
INSERT INTO public."user" VALUES ('3f8ee088-8ae3-466d-8bcb-c47c09f5859b', 'sigmafx2000@gmail.com', 'Olugbenga  Olorunmodimu', '$2b$12$7kQiObMlZWOYuZnW.CqNbekjypcQcLGEGCvKEKScu/UycBF/nkeL2', true, 'URXGF5WMSPAN', false, '2026-02-08 20:46:38.56146+00', '2026-02-08 20:46:38.561479+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6a1d4c38-14fd-48fd-b76b-7f010260afa1', 'hahawordl@gmail.com', 'Nshimirimana  BOSCO', '$2b$12$XjyRsbv9ys5f8AZe1.pLdeIpFMVsb5Z7UB1mlcIiCXINT3REHEmCy', true, 'GR77XVA6M5SD', false, '2026-02-08 20:57:36.407273+00', '2026-02-08 20:57:36.407295+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2c554b7f-0ecb-43f9-af0e-93725aec9230', 'mbishtm@gmail.com', 'Tecla Mbithe', '$2b$12$swGB34GX9St/6SPX0Gfz6eCiDtLoLgln1oBc1eVOR408FWrdAM3C.', true, 'EG44JFCXUUGW', false, '2026-02-08 21:02:07.791383+00', '2026-02-08 21:02:07.791408+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('06553524-4e8b-44cd-aed0-f7755d879ff7', 'farhannov523@gmail.com', 'Farhan Saeed', '$2b$12$NbsvQtafI7td.qSfMBnYtey4qNS7ry0flbuHg4hRob4NwQN4Zf4D2', true, 'O6MDRTUW4UCP', false, '2026-02-08 21:06:34.577974+00', '2026-02-08 21:06:34.577999+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4fb77cae-7e90-4bcd-b903-ccd56b6dc8cb', 'thebethluxy@gmail.com', 'Thebeth Musambachime', '$2b$12$mAnAK.WEKFezwLiOqKP8TuV0Z4Af1t7WsrskDjJbG0.K7jh.FX3ci', true, 'ST3697U2GAS3', false, '2026-02-08 21:17:56.642138+00', '2026-02-08 21:17:56.642163+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1a4d86c4-ecad-4e05-8ef0-ed79338aef93', 'amoakomanujohn@gmail.com', 'John Manu', '$2b$12$gX/8iuMwICbb0Gvgo6jk0.FcG/UfK.cPEifE.5uY.NTBzeGTYGG/O', true, '0835NOVDKHKG', false, '2026-02-08 21:19:10.462475+00', '2026-02-08 21:19:10.462498+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4a13a002-3f5f-49f0-a60d-25fcf1b14c4a', 'mussti666@gmail.com', 'Menduh Patir', '$2b$12$2QUlkA0XMeOqLLnrAZU6Lu6yHJ4SBj1wugl.Hjz9hk14QBNwFldR6', true, 'H3MVIWQYZ0GY', false, '2026-02-08 21:27:32.602834+00', '2026-02-08 21:27:32.602866+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c2f7ee20-2136-47f2-ac32-cc01956b6539', 'chukwudiadibeli44@gmail.com', 'Chukwudi Adibeli', '$2b$12$O6sGuAvq.uqHk3qlcGZdQ.Wu.w.claRQhEHKzU5IWauzBKB4qUzSS', true, 'TB0NE3Q6KIT6', false, '2026-02-08 21:28:26.674334+00', '2026-02-08 21:28:26.67435+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('eacc9836-2f15-49de-bec9-d87a6a67cc57', 'blingblingvictor24@gmail.com', 'Victor Mosaya', '$2b$12$/ckMj8HPV3rIR1PYzRjgQe/BaIPDotzRZF8AYQb3JoUqZzFzzuaju', true, '62FQIVATT1V7', false, '2026-02-08 21:36:15.713267+00', '2026-02-08 21:36:15.713295+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a7d0ab18-0e4f-4935-804b-97c620b367f5', 'juanpablosimancag@gmail.com', 'Juan Simanca', '$2b$12$6a1j/GbXhuX01UcdC28We.VNAaqVxHY4QaBlduqmTQWQw94D/Nk/W', true, '19NI61QNLBSB', false, '2026-02-08 21:43:03.139513+00', '2026-02-08 21:43:03.139541+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d59d688e-09d7-4282-9565-ea25dba1665c', 'docaguns@gmail.com', 'Samuel Agunbiade', '$2b$12$9PrnoH5MLyrWye.NAvqC9.VnFoiyxrIQywZng5kptcZyQU3P5sfbi', true, 'Z8F08P0QOBIS', false, '2026-02-08 21:42:13.939614+00', '2026-02-08 21:42:13.93964+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a22e4d8b-fdba-4088-ae2d-5dc70ea3c3ce', 'danielsaiki1@yahoo.com', 'Daniel Saiki', '$2b$12$qqVPWCYIrS6IBFzX4Oevzey6GkG97t9zDDx8GD1WOEwFtF5vP6Gj.', true, 'NJLT2JGSTAAP', false, '2026-02-08 21:44:53.336795+00', '2026-02-08 21:44:53.336817+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e5557427-d076-434b-ad9e-3fe1a3373a77', 'preciousidiado5@gmail.com', 'PRECIOUS IDIADO', '$2b$12$vlDW2YbD9D7Z6gRDD0P5.uAP3.U1IKeupcEabdTuxaIOsTMPIandC', true, 'TR3OO3QSD1AU', false, '2026-02-08 21:51:55.171665+00', '2026-02-08 21:51:55.171685+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c430c766-5f62-4eff-a9ea-1fbf7605f50f', 'fabulouzkiddo9@gmail.com', 'Dominic Mark', '$2b$12$BtwqECb0isLsQLk..FPcieKHdQiOiwIYrW1LGQYb/./aRHfoBEFLK', true, 'HUKIWTLRJAAA', false, '2026-02-08 21:52:41.972809+00', '2026-02-08 21:52:41.972837+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c23ec677-c3e3-42fa-b86a-8a24df974853', 'rodwellanderson2011@gmail.com', 'Rodwell Anderson', '$2b$12$2pl2B0NZ07VWTq3BEZdq6ONGmKxUFtBlbpjd100e1YZtuYdTa/B4K', true, 'JPBSH6BKA5BA', false, '2026-02-08 21:59:52.910282+00', '2026-02-08 21:59:52.910324+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('47253bbe-b207-4c61-b6ff-3c1970327bd4', 'dgeniusonline@gmail.com', 'Dayo Odewade', '$2b$12$RKpPMsg2GUvulpIv.wdid.xQu7Z/4puB.taNFwE0x0RDSMRSEDcKy', true, 'PMVG7RJ79HPI', false, '2026-02-08 22:05:17.354638+00', '2026-02-08 22:05:17.354662+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('568dfdf8-de6b-4141-bd4e-d966e10ef81e', 'joshwealth3@gmail.com', 'Joshua  Ebiotu', '$2b$12$m4XqstB9QMbNDjEyw3FdJOPBWG8Um6s2eIO4I/.oQPcwnc2/qkV4a', true, '2VK3I7B0RJ9D', false, '2026-02-08 22:11:39.879256+00', '2026-02-08 22:11:39.879284+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8b1fc6b1-1431-4fc9-81ad-578d99e14bb5', 'salarhadipv@gmail.com', 'Salar Hadi', '$2b$12$fC/WJiTaBdGJ1YqBuLaDZuDGS6Q0S6ty3IUMjpk7DhOa.iLvy98hW', true, '9J763HZI12K2', false, '2026-02-08 22:16:09.217383+00', '2026-02-08 22:16:09.217414+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7c2e89e8-cbed-4970-b91c-e706b18d3973', 'florenceobi2909@gmail.com', 'Emmanuel Victor', '$2b$12$KPfZGJwe/GN0cO5joJowNuNRRma8FAE/56MfG9Uc7XlcCAiUloKQq', true, 'BQDNRGPU44KW', false, '2026-02-08 22:23:44.795923+00', '2026-02-08 22:23:44.795969+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6b269625-c894-498b-807c-6ff2a14606bb', 'victorebesa@gmail.com', 'VICTOR EBESA', '$2b$12$hqMioyWIs6wu7x7woBXyo.7v2ly2ob3PkWTa78yYdxIsdW6XzyHXi', true, '57VXJU91ECW5', false, '2026-02-08 22:24:26.455242+00', '2026-02-08 22:24:26.455263+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('71e446db-a336-45be-bdfe-c579fbb9e245', 'Kimkelv3@gmail.com', 'Ediagbonya  Osayuki', '$2b$12$f5HCikN0rEYAWMpx9mvEAu5drNqoO3r2mauxecwOPiKLAlnxo88bq', true, 'V6XCBIPQSBSN', false, '2026-02-08 22:26:58.973053+00', '2026-02-08 22:26:58.973071+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1e61132f-99c5-49e2-987b-09f47479436e', 'ronkai4789@gmail.com', 'Kibalama Ronald', '$2b$12$uuQX5TzLrKEixr2GGuvX4Oya5WcMZgCILSALw.GQZbOxJDK.i1jGa', true, '4OPTVFP4RTE7', false, '2026-02-08 22:30:32.606635+00', '2026-02-08 22:30:32.606654+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d8b9a6b8-0671-488d-8687-7a5ffdea90f5', 'Kay4president@gmail.com', 'Onadipe Azeez', '$2b$12$qHisYbxPtbKARCjuEOxOqey8d.VsagWJYVr8KlmCYcPD3cPVM/TQm', true, '9LA5ZCEL35YF', true, '2026-02-08 22:33:03.20747+00', '2026-02-08 22:33:03.207491+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fdb883f9-7eb1-4660-919b-6b200d28751b', 'williamskingsley81@gmail.com', 'Kingsley  Williams', '$2b$12$2LOnGdOGsiFVO9gYg9LQnOHUljns4zWzJ/cXpDl4izBHtmh1CpMGq', true, 'D45G7YKK40LW', false, '2026-02-08 22:45:35.761828+00', '2026-02-08 22:45:35.761852+00', 'Pjr19ldhwdiu');
INSERT INTO public."user" VALUES ('755cbb31-02d2-45dd-b106-e62e6ccfcc37', 'toyindeals@gmail.com', 'Toyin Odujobi', '$2b$12$iD2LSaErj1s4DJdSk0GLiODrEr8XgHAYjGoe0mcTLjFSBNNyIW0bC', true, 'L1W2NAEKBNQW', false, '2026-02-08 23:09:56.116346+00', '2026-02-08 23:09:56.116369+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('498d6f5f-83e6-421e-ae9e-fea0c73101c6', 'johnathanakajay@gmail.com', 'Johnathan Mckoy', '$2b$12$m.0aQJLlVhdm97HnSm340.u1h81CBgQmho8kvn3Lx6Zeh2Ks9fiZS', true, 'GJ39GNUB2FZV', false, '2026-02-08 23:20:29.905633+00', '2026-02-08 23:20:29.905658+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3eddf2a3-7274-4199-8d78-2e5628fc230e', 'petef8885@gmail.com', 'Cranium CRFX', '$2b$12$igzgiTz9BFJr0xUK4gwjcuC3/ECYxyqmQo8/HBx7HMSJVExxViWwi', true, 'UTLILSK1EBFF', false, '2026-02-08 23:20:59.672662+00', '2026-02-08 23:20:59.672682+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a08f5289-de99-46cd-afa8-c9a538c1944a', 'ibrahimsulemana2008@icloud.com', 'Ibrahim Sulemana', '$2b$12$93q7xYb6jM6gFnopw0xo5uAyGUNyWD7fm1WAWWwZRVBwWjxRKd.62', true, 'EVVGHAGB7MPR', false, '2026-02-08 23:42:16.999132+00', '2026-02-08 23:42:16.999161+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a76f9fae-9159-4b05-8668-5abf8e246cb0', 'ruaigattiekgattangchuol@gmail.com', 'Ruai Gattiek Gattang chuol', '$2b$12$CCljmsnX2p/dfsGsXYEnaOFJB9sPb1flymUD4rNwC7vmrQ3tNaMZS', true, 'OW4U162K9724', false, '2026-02-08 23:54:20.699803+00', '2026-02-08 23:54:20.699829+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('87866084-807a-4c9a-9292-cc795d8646bc', 'sam1234.gab@gmail.com', 'Samuel S Gabriel', '$2b$12$I5kQkhD2CPuww5LjTdTCUuNSu4YFV7ulvS1Xe.ZcQoopTvNP.Ix9K', true, 'CGDPZWSW10R3', false, '2026-02-08 23:56:51.316335+00', '2026-02-08 23:56:51.316353+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('92c17393-e166-404e-96d3-97493aef792a', 'uhmadh@gmail.com', 'Ahmed Hassan', '$2b$12$g4.9tRtb0hSH8NTKz688suCqxiEF0aU07zIrwM7zAZ9BysWWlCTDq', true, 'RXJBVRP56626', false, '2026-02-09 00:12:58.932013+00', '2026-02-09 00:12:58.932033+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('36f50d19-763e-415a-9c44-9dd6b2a14c4b', 'decsoctave@gmail.com', 'Delson Octave', '$2b$12$k0TQ2pKTLbTPruxkLHpJeOQCPOHO/npBlKWGM9.ahCgE60NRV9DL2', true, 'U6L5DFWQLQ7Y', false, '2026-02-09 00:32:30.31344+00', '2026-02-09 00:32:30.31346+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('16303e0d-401c-4795-ae60-768dccf042c8', 'possibilitycafe20@gmail.com', 'EMMANUEL DANG', '$2b$12$ao3qvROATv4N1RR0ZUk71erTLv/as3UBETqw4HPuBMOY/eUz65eYS', true, 'H4AD98FRVKSW', false, '2026-02-09 00:45:04.623872+00', '2026-02-09 00:45:04.623911+00', NULL);
INSERT INTO public."user" VALUES ('f2b50b43-9279-4583-ac15-f89500490ff4', 'joy6424576@gmail.com', 'Stanly Rajendran', '$2b$12$mkX2rP1MurT5TNuctCvQy.bXt8TMPstp0bFVP7MZelVOfSLtyqxnG', true, 'DGWNA5F1SNTN', false, '2026-02-09 00:50:31.84699+00', '2026-02-09 00:50:31.847013+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9e264583-ed06-40c6-a1f3-306041b10aa9', 'ephumaz@gmail.com', 'Ephraim  Mazarura', '$2b$12$rBAHSErXOs3U4aM/v3Gfm.nfTKZVdQe27mLJSfKKm22PiM.a1sli.', true, 'I68BMK38D631', false, '2026-02-09 01:09:13.199004+00', '2026-02-09 01:09:13.199023+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b9df9e61-4256-4b93-893e-0862a7a6c8b5', 'altangerel78427@gmail.com', 'Altangerel Enkhbaatar', '$2b$12$EPiAnEHshpcfNnJm6ED/xuDZnYWHY9TM0EkU3DUmBdg/XZ3TrRl8a', true, 'UKNQ72TCN3DF', false, '2026-02-09 01:12:05.941735+00', '2026-02-09 01:12:05.941752+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('924e5629-e175-4284-9be4-a63e5d362c1a', 'seyiolorunmola1@gmail.com', 'OLUWASEYI  OLORUNMOLA', '$2b$12$xYU6oeSJCodVKrdC1nRhuO77jVHnf7SUsuXd/xT8QzFHaV3XRaYvy', true, 'VT4EX3S1KW5N', false, '2026-02-09 01:14:13.574391+00', '2026-02-09 01:14:13.574408+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('94934cc2-4fb6-455b-9710-2e450ab8e91a', 'oladmegy@yahoo.com', 'ANUOLUWAPO G DADA', '$2b$12$qNRf98WfMxBcLIuevL4oV.8Wphhr5fnESoo5My.vfMlNbQGc.k2ZS', true, 'B3RU2NMP4ZRN', false, '2026-02-09 01:16:40.108003+00', '2026-02-09 01:16:40.108023+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9cdb1024-250e-4501-99d2-f84dc80be301', 'femi.resource@gmail.com', 'Femi Olasanoye', '$2b$12$/bfT1q0rDv64wNqRsAY9tuQ6Amd2t2lrCe9R.L8xKNfz7kdx0g8Se', true, 'PTG4LL9PM807', false, '2026-02-09 01:23:08.51584+00', '2026-02-09 01:23:08.515859+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a8c1ebff-73cd-4490-81d2-f404d75eb3a5', 'mysticiyke9000@gmail.com', 'Micheal  Udegbunam', '$2b$12$IPWCfNnBAG2CHRaWxZk0ZO22i3oKpq2HkqCpBS0j9IqCcXQC32ix.', true, 'HP7YC1IDUQ1C', false, '2026-02-09 02:16:37.4633+00', '2026-02-09 02:16:37.46332+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3cd1a220-6d1b-4b17-bf20-6710e67549ea', 'rajsinga52@gmail.com', 'Raju Singh', '$2b$12$omz8DOSEjVS1raxABPxgtew/L8naTYZVLaU9DcWH5pWsTZS7lkYAe', true, 'F8S2J0ZUEZKD', false, '2026-02-09 02:33:43.382184+00', '2026-02-09 02:33:43.382207+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f8ae6013-c8d1-463d-aa50-e3f273151f9d', 'adegbolae@gmail.com', 'Emmanuel Adegbola', '$2b$12$8BdpCs8rhYLvMPXKD5PGqeENFGkXDV5gv0MOZ94oAr6kMQRw6q5py', true, 'BS0UTUC7X901', false, '2026-02-09 03:02:14.266455+00', '2026-02-09 03:02:14.266475+00', NULL);
INSERT INTO public."user" VALUES ('acf49896-2df1-4828-bc68-9ff923a80f19', 'grantmejoy2017@gmail.com', 'Bariloe  Abel', '$2b$12$aTNyOJ7PF6BLBJP6zzpsN.cKWuAjmy84PXTuhwdQTWXJA9puEnq46', true, 'YY9BDBVHYUK4', false, '2026-02-09 03:21:42.422597+00', '2026-02-09 03:21:42.422622+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c0855636-8f12-4e35-8614-352639990e7d', 'leod32421@gmail.com', 'Arun Kumar', '$2b$12$w00zGOrmJi/PXvxN4PO5OOabSAlqhZxMz8RBj/6YjJwYoaVP9Mr9G', true, 'P6GO635R7KBU', false, '2026-02-09 03:31:21.606741+00', '2026-02-09 03:31:21.606765+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c87425b7-0155-4c19-b4a8-bb85a573b8ce', 'ankury704@gmail.com', 'ANKUR YADAV', '$2b$12$ROyZSPX59C2YqAvP.k93B.n0EvWphWzEBXxJLvUIWAYbRyfWePVb2', true, '64ZAKYYWX7QA', false, '2026-02-09 03:37:00.116817+00', '2026-02-09 03:37:00.11684+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6e928128-748d-4881-a759-fa4ec9b8d4ae', 'tiamiyuakanni@gmail.com', 'Fatai Tiamiyu', '$2b$12$n8.LVK7FUu57XRytUDkhLuWRO80Ut3XUH47ia2p3l/ii6SQbkmwny', true, 'A1XW1UU42D73', false, '2026-02-09 03:37:27.351882+00', '2026-02-09 03:37:27.351899+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('65fe4fc5-e89a-4a06-a133-daa2dc18a5a7', 'solexcute@gmail.com', 'Solomon Moses', '$2b$12$t3A9Fi/7ZQHgE9cmBnn6O.zElwRawRuraGvfkh6ozPzAWUeVmK372', true, 'DMEMWRZXSTBA', false, '2026-02-09 04:28:08.186933+00', '2026-02-09 04:28:08.186959+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c23a3e53-25de-466d-a9ed-4b06c283506d', 'magetoeric09@gmail.com', 'Momanyi Mogiti', '$2b$12$44aeifiyb7FNJQyZe54saOPf1WwD1deJVRR9sVmSnIr9pKTUP6lDm', true, 'TL7RUKSQ6AE4', false, '2026-02-09 04:47:05.327202+00', '2026-02-09 04:47:05.327219+00', NULL);
INSERT INTO public."user" VALUES ('a176f4c5-724c-405d-a2e5-1c2062dd1065', 'tonkioktevino@gmail.com', 'Tevin Kiok', '$2b$12$Aa/H7o7B.tL.ID1xaSJG1OxRdBFiPJnIKaID4xeSVVtlcqJQMPxLu', true, '7TRXZFCS1MFT', false, '2026-02-09 05:50:47.443857+00', '2026-02-09 05:50:47.443906+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('79bddce8-2d4b-4647-913e-21d0fd9ca141', 'sohbutnden@gmail.com', 'SOHBUT NDEN', '$2b$12$6Y41GdkB46GhFQrTJw5cdeutjfXy51BRDjesUT2X.WsUGH8RYWZrq', true, 'X8G6Y83BU7I9', false, '2026-02-09 06:00:29.711277+00', '2026-02-09 06:00:29.711303+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e8c9210e-16b3-41e2-ba38-e539e75f911e', 'dominicagu4@gmail.com', 'Dominic Agu', '$2b$12$RQH/B75nbDodHw8Nz8mAgunajtjYXIDBzkIgDC.0ECfWf2Q8gxVmK', true, '4PR1BKWXC8PP', false, '2026-02-09 06:12:02.74928+00', '2026-02-09 06:12:02.749304+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c34f3651-41a5-4de8-b5a0-2f243bb13d7a', 'boysmall3@gmail.com', 'Navaneeth Kumar N', '$2b$12$Qpq09TvdyVDI.ps3bnDmte234Y1VaO89UYxBgjDii67VGVFb6./Si', true, 'UEDGFIKAIUX1', false, '2026-02-09 06:42:21.53037+00', '2026-02-09 06:42:21.530395+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('322878e8-d1ae-4276-9c71-9bf71531631e', 'adimedsoft@gmail.com', 'BENDOUGLAS UCHE OKOLO', '$2b$12$mdE.oP4HvNLpH1Wp9j3UPeS9bB1LjjDVOqYEyz/pvihkwCCOKQPma', true, '2451OUZHGD4Z', false, '2026-02-09 07:04:38.848085+00', '2026-02-09 07:04:38.848111+00', NULL);
INSERT INTO public."user" VALUES ('7658b747-c826-439a-afc6-807d21dc1493', 'bettywixpartner.us@gmail.com', 'Solomon Dawodu', '$2b$12$oKjMhlbhxVZ96ZkhAhGAbezxFAN7fErv7.MrUU8xuQukobZbZR3H2', true, 'KLHOS2L5LWOJ', true, '2026-02-09 07:05:26.266989+00', '2026-02-09 07:05:26.267012+00', NULL);
INSERT INTO public."user" VALUES ('9f9be258-d23c-4d86-a6ae-2dd08cb84a96', 'jimohkhalid55@gmail.com', 'Jimoh Khalid', '$2b$12$l/t2bFHlKIX8gAH62ON/TezWm829S7TJM7ZOEATizbdGQ0h9t/0Ea', true, 'KE06JNYLTK3T', false, '2026-02-09 07:40:26.251845+00', '2026-02-09 07:40:26.251871+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8e51ffab-ebf9-4776-b2ed-7475ecadf4dd', 'birhindwan@gmail.com', 'Nathan Birindwa', '$2b$12$Kn2g4HpAyKh90owLCWJ1n.hJQSZ8SPUK7M/BYsfx4wvj13fooewQi', true, 'J3U24N2NH1L0', false, '2026-02-09 07:56:04.370801+00', '2026-02-09 07:56:04.370827+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7902a5b3-6540-48c8-a3e1-01f2ded2fb6a', 'sojamatter@gmail.com', 'Michael Okoh', '$2b$12$H7QQjg6IOZ2FBqq6jRy.telehsPCrPnG.YlSiZatwSA9ZJYmrvjWO', true, 'XKAVVI1P1ZNH', false, '2026-02-09 08:38:16.500209+00', '2026-02-09 08:38:16.500241+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f69bb7da-8686-4058-8a8d-475f89237aaa', 'craigkudakwashemandizvidza@gmail.com', 'Craig Kudakwashe  Mandizvidza', '$2b$12$4H8okn6SiT/uvhzOQH430OHgYa5ioTP5IdZ1xvPnaMtjI7uLomH4e', true, 'F7P5BDX9KW2Z', false, '2026-02-09 09:36:51.87012+00', '2026-02-09 09:36:51.870139+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('48140b0a-33e3-42c7-97ab-cdfa143a4254', 'tosinsogo2349@gmail.com', 'Oluwatosin Ogunsakin', '$2b$12$dZ.XUu/hQWB0vJofQb7LDuejtXsn0ktdqx.V74nkKvotKYAUVpkjm', true, 'RB265TC8IDIL', false, '2026-02-09 09:46:08.359975+00', '2026-02-09 09:46:08.359993+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7e616394-8275-44db-b72c-ac8dbf31d35c', 'everonikagordon3@gmail.com', 'everonika gordon', '$2b$12$DNP/N5KxKFkT406107.bBuCwgtahwIoK0sXkuf1jdfeJaIPGzCfJe', true, 'KRZE4H7R1HKQ', false, '2026-02-09 10:13:42.299739+00', '2026-02-09 10:13:42.299769+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f426d40d-ba4b-4a61-8838-5b45fcee3f70', 'mauridmanda@gmail.com', 'Micheal Manda', '$2b$12$OEGJHZnltR0thmQRNL3fH.I/Iyp5jobW7tK6HZ.k8ceHr7fdrpPHu', true, 'WBNCM78PKAD7', false, '2026-02-09 10:38:33.448997+00', '2026-02-09 10:38:33.449027+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2ab697fa-5d8d-4818-88c6-45f5b1b91c42', 'jamesagyapong1234@gmail.com', 'Agyapong James', '$2b$12$gC4UWd.sTqTmObqLV3Fqjuh5F25/S03hOhsnIpyQwuwOiiz1Uca0W', true, 'JWUA0DW1PX58', false, '2026-02-09 11:04:30.418693+00', '2026-02-09 11:04:30.418713+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('581578c3-8ee1-4334-acc5-39341db4d72f', 'thabisomonethi@gmail.com', 'Thabiso Manyeisa', '$2b$12$ZG3fMcVuva5.UVF0hEVGeuV.FhZkO/2o61FNw3aBqmE1Tnfmu083y', true, 'EA0WI48B715O', false, '2026-02-09 11:15:35.840374+00', '2026-02-09 11:15:35.840407+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('765f908f-fbc5-4b7a-9853-0b3e2110656c', 'davidakintayo2050@gmail.com', 'DAVID AKINTAYO', '$2b$12$VH.SkVSTEBbmZuLmYk/7iOxymOR6MYG16xJIiTgnBdL0mB4cDswJW', true, 'D3LZJ7KVGNNL', false, '2026-02-09 12:10:38.633116+00', '2026-02-09 12:10:38.633142+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b39aa963-fd1e-4337-93df-bee1855ef507', 'gaetan.boussegui@gmail.com', 'GEORGES BOUSSEGUI', '$2b$12$aACzOAj2xGXq8/06vT1.Z.eqsxvDRu6nbq81qKRlTHCXIfEUj5M96', true, '5RC2SXUXNT05', false, '2026-02-09 13:13:08.440917+00', '2026-02-09 13:13:08.440953+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('790eef00-3739-4c82-a32e-03324d2381f6', 'fasanovalerio5@gmail.com', 'Valerio Fasano', '$2b$12$3WvVzFZhZqtmCVbyRJEsxOFw27DZndJJ3bZg4IUbPubDnWR.fLxui', true, '2XFF8YMCQ4OA', false, '2026-02-09 13:29:47.485488+00', '2026-02-09 13:29:47.485529+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('405c5f02-85d3-4956-a499-bba1b28ef855', 'mkgathecha07@gmail.com', 'Kevin Gathecha', '$2b$12$kKijFFWGQ/UdWHTtsB8eWO4DpIUBrKLaeJCIODU2u1s6OwkY1BJSO', true, '6HE07GB4O08J', false, '2026-02-09 13:59:26.98379+00', '2026-02-09 13:59:26.98381+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bfd0ff14-a862-48d4-ab6f-8b5c8a9416e4', 'neckoreid59@gmail.com', 'Alex Reid', '$2b$12$90UAnpgZEXDi8asSNYohV.2miYqnw7.fr0FT3AtUXheihZhA7pNTG', true, 'N2PBWU7LAEY6', false, '2026-02-09 14:07:29.73273+00', '2026-02-09 14:07:29.73276+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ce254f76-0f1a-4468-9900-5f1fa4fb518b', 'etelvinodecarvalho2000@gmail.com', 'Etelvino de carvalho', '$2b$12$LdM2xBQYHKjINKXym.TtUuoCdwG/6ZtEZAAzukPl9xjzRLZH4uGna', true, 'EZQ55SGQW5FJ', false, '2026-02-09 14:16:36.77753+00', '2026-02-09 14:16:36.777558+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3cbab914-7e9c-4bf7-a75c-59130149b638', 'mukwevhokhuthadzo@gmail.com', 'Khuthadzo Mukwevho', '$2b$12$RLd/0Mzu6/G45mg7KEYgdeya0DR.A6HYOSDkY2MY5F.3DZ8f/kq4i', true, 'T2GLVOMM1HRO', false, '2026-02-09 14:19:00.493939+00', '2026-02-09 14:19:00.493963+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a809d3cd-140c-47cb-966d-be34605dd0f7', 'nicholasbrew25@gmail.com', 'Nicholas  Brew', '$2b$12$qPDkyaPkkda1hH30j.YJ3uRxjTG0zwZ2gJ/Whm2J9PM1k/4ZZk7wK', true, 'BYF494LBJWWB', false, '2026-02-09 14:31:17.201866+00', '2026-02-09 14:31:17.201885+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0524a796-6004-43e6-a927-6d8d063b222c', 'chinazademian11@gmail.com', 'Onuzuruike Demian', '$2b$12$MV8yVmkYJ5JGYGBMjn5CqePIyn5DFQ3vgNuoxRWjl.qc5jQQNzywO', true, 'NGCKR5OABSXN', false, '2026-02-09 14:50:44.510378+00', '2026-02-09 14:50:44.510414+00', 'Demian11?');
INSERT INTO public."user" VALUES ('2e8e0446-1308-4334-b64c-84e8f69aafdf', 'Malapiletso@gmail.com', 'Matsobane  Malapile', '$2b$12$TSYJA6Ch2PXSQ20rmMJNY..JMsRYqsdqIF6BnBDGLKSniRFEZ/moG', true, 'NIBS3W3O9JWY', false, '2026-02-09 16:03:53.972225+00', '2026-02-09 16:03:53.972251+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('20006708-a207-419a-bbc4-0d8fb3294a9f', 'chilucy2016@gmail.com', 'Chidinma Obi', '$2b$12$eW/zZV1wyezeL7aO7D182Ot0T4FPDSUQXXj3mpUF.QWrN.alYIk.2', true, '9HMV0KBEU6ES', false, '2026-02-09 16:42:51.848926+00', '2026-02-09 16:42:51.848946+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2b06f6f1-6eee-4543-82a1-97144d4a9c53', 'kphiri68@gmail.com', 'Grace Kefilwe Phiri', '$2b$12$fgOC3GHqWeyMtHo11J.dSeFikR7/thwBYs8Xm7DAlTdbBl3LDoKZe', true, 'YM6K1X6T6XX2', false, '2026-02-09 16:46:56.49378+00', '2026-02-09 16:46:56.493799+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('579a514c-d4ea-4112-969f-60f1b560312f', 'murage.jane1976@gmail.com', 'Jane Murage', '$2b$12$d9aBrKZ606LAKhUNlG5RBu4cAxeNg8ZwvuDC6QUw7A.gE2DuZSYBS', true, 'EF543I2568AF', false, '2026-02-09 18:58:30.47862+00', '2026-02-09 18:58:30.478643+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6efc81ef-a215-4974-b40d-82d1e13d9814', 'godricleo111@gmail.com', 'Leo  Nweze', '$2b$12$/N5M9/V46cnmEHQCQLygtORVeIAZ54clqc40TDqoKfUVI7P1f6a7q', true, '4COHTO7NNBKC', false, '2026-02-09 19:59:02.011208+00', '2026-02-09 19:59:02.011237+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ce123420-c0b4-46a7-88f5-b69bd8dabe19', 'naveednskhan4444@gmail.com', 'Naveed Khan', '$2b$12$lFHljMd8bJZA/fnDGQr5MOJZWIPcR.Aa8sl9EcvyYIrLqcGLxcir2', true, 'TI4927NVT00T', false, '2026-02-09 20:02:41.685129+00', '2026-02-09 20:02:41.685154+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8ca4c389-feb9-4d3e-83e9-4b534d510b0a', 'mrclinton.28@gmail.com', 'Kaborloobari Patrick', '$2b$12$/wpIW51aLR25bi5Iy6B/D.UTJFJuUtm6BFGKFBsKsJshWdIqWDhYC', true, 'F6Z0WUBHCONS', false, '2026-02-09 20:20:13.727925+00', '2026-02-09 20:20:13.727949+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('01ac9761-dad7-4a66-b6a2-7edf2e95162d', 'mngunitroy7@gmail.com', 'Troy  Mnguni', '$2b$12$5Dj403iNgL5x00VvKtyqcuGDwTi7JmS/RM4FHnK7yPHx0TTnfX.82', true, 'MAGHI6EFUWWS', false, '2026-02-09 20:58:09.311919+00', '2026-02-09 20:58:09.311944+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('092153e5-8e65-4564-9f4a-14d41530e1ba', 'chinexjoe2006@gmail.com', 'Chinedu Joseph Orji', '$2b$12$bMomKg/WTfh5uhhPZWZcf.TBHGloqjDiGNtzLoAxmOsgiET1fwI.i', true, 'NONS697KP5Y6', false, '2026-02-09 20:59:01.557021+00', '2026-02-09 20:59:01.557046+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7f7974c8-f304-44e2-bc3d-0d49ca6af2b2', 'fxfire1vvip@gmail.com', 'joe BEN', '$2b$12$fetWBf7ltZUKP8wzIbNTiebNwkgvQ68LhssOZ1OhPEDTvJmNMpLlq', true, 'NZAX8QF2CJ94', false, '2026-02-09 21:04:34.856683+00', '2026-02-09 21:04:34.856703+00', NULL);
INSERT INTO public."user" VALUES ('885efd1b-b626-4daf-aaf6-4ee8f80fdffb', 'ezekaffairs@gmail.com', 'Ezekiel Daniel', '$2b$12$ifFQAHOl6EqUKxk8sCk6JOHaq9fXhVjEkvnttHfkn3I/RPJCyMNJS', true, 'AUVRN1WDIA87', false, '2026-02-09 22:11:35.247816+00', '2026-02-09 22:11:35.247856+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a491eccd-c033-46bd-9d49-3a1509104e9f', 'haniellahony@gmail.com', 'HANI SALEH', '$2b$12$wwE15bgwpf8C/Hcp1.vLKu6wgiHfE3aL/CnGY5D6HDtk5NjLlLckW', true, 'A5ZWGJPRVZK5', false, '2026-02-09 22:46:30.090261+00', '2026-02-09 22:46:30.090282+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7b20c938-8cb5-47c0-8b41-53e841a465e1', 'snavealegbe@gmail.com', 'Evans Alegbe', '$2b$12$Gl8ka4W3LTz4gKO.jJ96Xe4HJJR5ux3QrFs3IBn0uRwuqLy3TeiK6', true, 'OZY9LHI4WOO1', false, '2026-02-09 22:48:55.395087+00', '2026-02-09 22:48:55.395105+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('09862878-6ad5-4500-8bf8-0c495e828be4', 'davik4life@gmail.com', 'Victor Adeshile', '$2b$12$yVUvx65mDH0rb5Rk09k3UOU/25mhGOVgrHmZqAKMp.w3umr6UFBuG', true, 'ZK076N4GO1CK', false, '2026-02-09 23:10:23.839685+00', '2026-02-09 23:10:23.839704+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('93dc47bb-0529-446c-b302-5a245dcfa752', 'brainjlooo@gmail.com', 'Chukwumaeze  Anyanwu', '$2b$12$WpEW312Fu1PRlYjBKT/mh.a.pTsrAX3XZdaTzHbtkzkDHkWtMLp32', true, 'PNYQNR6K9S1I', false, '2026-02-09 23:52:21.155924+00', '2026-02-09 23:52:21.155953+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a62482f1-03ee-4612-8a96-134573dbe9b3', 'ruhainassayutii@gmail.com', 'SAYUTI RUHAINA', '$2b$12$cPw9LUJtWZC4ZA6dc1lS/./l8K4k5XhfOVCb1XYpPj/nItfoMonbG', true, 'IX4OUV9ODTCF', false, '2026-02-09 23:54:34.494422+00', '2026-02-09 23:54:34.494469+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('de36fe56-826b-49e7-9e30-3af9a8e9aa5c', 'ogbu54321@gmail.com', 'Kingsley Ogbu', '$2b$12$o.9ShqtK/Yu1qD4clo0kYOOX8IwkNh0u/yBBA/ANKw/2amnQmlHzG', true, '4BEEM613E8HD', false, '2026-02-10 03:03:53.872285+00', '2026-02-10 03:03:53.872307+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f6f570db-a337-46f3-90a8-eaa313be30ed', 'mlmtrigger001@gmail.com', 'Guma  Bright', '$2b$12$lXK6r1TS85uidtz8PjLsNuYOa8iMp6AEI1a2OM7uhgQ2rzrwQFnvi', true, 'C9L3Z46U6BOR', false, '2026-02-10 05:53:06.688587+00', '2026-02-10 05:53:06.688616+00', NULL);
INSERT INTO public."user" VALUES ('6f64fba7-c59d-4ddb-9d45-e5a5b12f7620', 'xmasdavid64@gmail.com', 'Agwu Gideon oluebube', '$2b$12$G8ktA.nTLmsR2QnWy6gDGeUXPj1vjlb9qZC1dKh0QYfDgMi84cfOy', true, 'QWDA7NYSBLBC', false, '2026-02-10 06:16:34.926329+00', '2026-02-10 06:16:34.926351+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('30237eba-d704-498d-badd-b657c25638f3', 'ling34711@gmail.com', 'Li Ling Ling', '$2b$12$e6WSW2V3wnKb0whNi0U8N.JaFcMO1ppqcm65KyhmLFuDjgQaxvMFq', true, 'PVMHP6SY1OY6', false, '2026-02-10 07:35:12.269315+00', '2026-02-10 07:35:12.269348+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('122d3da0-d150-49ff-bd25-3243d71e3655', 'mutuyimanafrank183@gmail.com', 'mutuyimana frank', '$2b$12$g.xNd4.7QiLnF9sccurVLO0qLJW35s2jR8NVkkFQgNJlYNDZVKzWi', true, 'DUI3839D0J8F', false, '2026-02-10 08:27:36.761872+00', '2026-02-10 08:27:36.761898+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('97e407de-37bf-4e46-955c-553acc48cde2', 'abdulkerim.asad10@gmail.com', 'Fadi Asad', '$2b$12$94VyywSKzcRbgVPDf3MNz.HZF65UVgYjBhAapCZb3N5cDg9l0t2v6', true, 'AY564LHEGCXX', false, '2026-02-10 09:13:04.435608+00', '2026-02-10 09:13:04.435635+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('450059f0-6a63-423d-a325-72866873a4a2', 'Lynvarion@gmail.com', 'Divine Okunwague', '$2b$12$slMHSctvXWbu67xxvR8Ez.o.RXyBpPSLxQm7jXJ3vznX2YNR6wzIm', true, 'TB55HNDGB081', false, '2026-02-10 09:20:27.446427+00', '2026-02-10 09:20:27.446446+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('70cbf790-abf6-4eac-8a7e-59755a031214', 'tradejan8@gmail.com', 'James Annas Narh', '$2b$12$9.7z5aSOslnUfmcxJMsdr.3/DdmY4D4nIMKjaWbl7mOsjq8.QQDVe', true, 'FS8BD4XM53FO', false, '2026-02-10 13:37:24.489951+00', '2026-02-10 13:37:24.489973+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('24e184cb-23cb-4378-b961-2518c3a21117', 'inatebtc@yahoo.com', 'Timi Anthony', '$2b$12$2m2K4KqEVp.oj9Fq9VLZKeyU6qAtotsU5n1VOLbLN8b6AmGkvYWpy', true, 'N5QHBIQA3ONU', false, '2026-02-10 10:58:14.712546+00', '2026-02-10 10:58:14.712571+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d04d180c-bcbf-4180-a651-9567568f8904', 'brandonestevendelae24@gmail.com', 'Brandon Montes', '$2b$12$4PmMmlanRgtJVsrgi1kNT.oGPvxHueZMh8wnDM5HJZtc5zUXcdlOi', true, 'OKQOV4PPTVGR', false, '2026-02-10 11:42:06.441492+00', '2026-02-10 11:42:06.441511+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4474d8e0-8d72-4ebb-9d51-4ae17062810a', 'ofuluejoe@gmail.com', 'OFULUE HENRY', '$2b$12$O4pZOU9CfXCGQ.Q0Vi1xIOPtqlm9l8IN/.bu2HU6zxsmxLgcCoMMa', true, '57FH7M978Z93', false, '2026-02-10 12:19:40.403422+00', '2026-02-10 12:19:40.403451+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('68d7ddba-e616-4edc-b908-9aa162feef06', 'daeneirasherlyn@gmail.com', 'Daeneira Sherlyn', '$2b$12$TS7wHEkzjmFjKVTP9BYPGe9dQUDDZlZa9jtKV7gBHr5a/cngDsSai', true, 'WOFSHVX8M951', false, '2026-02-10 17:40:32.012296+00', '2026-02-10 17:40:32.012328+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8fc32856-0f2f-4a80-9608-f5de45308f78', 'krishnakumarkrk007@gmail.com', 'Krishnakumar  Koorakkottil', '$2b$12$yxeh5QC0557XX6AhgpRh3eJI0ZTQ5MkJFL9MeN5a1aAIMsH8XrVn6', true, 'FVU9QDLNE57O', false, '2026-02-10 18:14:25.570151+00', '2026-02-10 18:14:25.570173+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a425a59d-9241-46f3-b0db-ca18ff61b6ca', 'ogbumchukwudum@gmail.com', 'Peter  Ogbum', '$2b$12$Dx1s.Uj3KKJc1m0IXlsdVOC0At7nrzQDWeHRy7Z7dZAwkPnLqXd9C', true, 'HVX666RBJO69', false, '2026-02-10 20:25:57.149225+00', '2026-02-10 20:25:57.149256+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('334eb3dd-a035-4cd3-b7ff-1ae6e1633504', 'stanleymboga43@gmail.com', 'Stanley Mboga', '$2b$12$WreOCJKOUUQ8SpNutask5eMUgCBhz5DRR/zOiah9HSRB6kN62RR4e', true, 'JPHZ7MX6PKVA', false, '2026-02-10 12:16:14.326696+00', '2026-02-10 12:16:14.32672+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7d7f8990-6855-423a-b89d-ae72c3d863ec', 'jennymorgan1330@gmail.com', 'Jenny   Morgan', '$2b$12$W.hUDoRvdvEA2cuyB0D9PO6Pyx2gknsSmA.GuHPN0gsHGiLf4zc52', true, 'YKVDK6PJRU53', false, '2026-02-10 18:43:04.401139+00', '2026-02-10 18:43:04.401156+00', NULL);
INSERT INTO public."user" VALUES ('63d0cc73-70e9-407a-a464-3c192a49981a', 'juwelranaabrikhan@gmail.com', 'Nagib Ahemed', '$2b$12$rOmrn39/1ONouoIhwObO1uz2vQQjqIZPZCSdSdb9iIgV.sOmka3PG', true, '7HYYVB2ILKHU', false, '2026-02-10 20:57:27.907173+00', '2026-02-10 20:57:27.907201+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('978e800c-c00b-46fd-839e-fc63261c3651', 'saifullahabdulazeez007@gmail.com', 'Saifullah Abdulazeez', '$2b$12$CuurmZIMfGAPNrcJpEXM3OthaFEDCcKLP1rv3tfsaACcI9K5qhia2', true, 'VBA06T5UL1VB', false, '2026-02-10 16:14:50.373254+00', '2026-02-10 16:14:50.373282+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0359bf2e-7216-41ae-b5d0-5b0a1feed859', 'darrendavid348@gmail.com', 'Darren  David', '$2b$12$Fz53l7H5E5keonobca65qO9O1t6B1BtLHzEPikagP2YhOrwzeHb0C', true, 'ODF39DW39T8R', false, '2026-02-10 16:55:44.737847+00', '2026-02-10 16:55:44.737869+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1441f5bf-3433-4d2b-868e-2c9ffb9a00ef', 'sethrety@gmail.com', 'Retyit Maxwell', '$2b$12$E1iD5b0mrlsXkcn0Y0fUauZF0csVGtFtZTdjn7a/iBMEeqlniO8ki', true, '1JMXRRI4PYUR', false, '2026-02-10 21:32:41.349226+00', '2026-02-10 21:32:41.349245+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bf66c687-35de-477f-b59c-ee147b4d05f2', 'zoriparviz@gmail.com', 'Parwiz Zori', '$2b$12$6pVBLoSiLwr5k4WCEsTHTO8BfSlbmqN27Qcdf1xWRWP/tNdwAtMUK', true, 'QPXF9YVJUQNM', false, '2026-02-10 22:28:51.265191+00', '2026-02-10 22:28:51.26521+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8659b8ab-4276-474e-978d-b64df388aae3', 'flawlessfx552@gmail.com', 'Francis Ide', '$2b$12$JxWUaTHQ2GB8fHD2YIqaLuQllFvPeRebZuYOx8iMbFMPQn5CUmGZa', true, 'FXB268KGT32I', false, '2026-02-10 19:12:49.698305+00', '2026-02-10 19:12:49.698328+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('db61433d-25ea-4edb-b3e2-6de586756ef4', 'felbou02@gmail.com', 'Felix Bouare', '$2b$12$WzCZdDoCYqTmAWPoUkv/qe4KmikEgMRfe/yo/P5n8uUyZfh9GjmlO', true, 'XERMP9U5B7JJ', false, '2026-02-10 23:42:17.698896+00', '2026-02-10 23:42:17.698913+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('694dddac-39f0-40ea-b89b-550642c2bc34', 'davidgreat45@gmail.com', 'REY-DAVID BONIFACE', '$2b$12$5yzqswW7aTB3ZRntqr5suuRXi4opeb.a14Izg9hWStRwgSESv1jpe', true, '1KZACKAEFG2J', false, '2026-02-11 00:30:37.319486+00', '2026-02-11 00:30:37.319536+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('206fe153-24a1-4b5d-b2f4-30c9b050c528', 'cwonder6644@gmail.com', 'Martins  Clinton', '$2b$12$VhJPOo8rjJGsN7qgqjGTzeUik2PnOfhIFy/Z.Mqu6pywgM4VOHUNO', true, 'RCGSE1JKEKQB', false, '2026-02-11 01:34:19.756573+00', '2026-02-11 01:34:19.756603+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0a95b365-0365-4ef9-aa32-1de2891fe4dc', 'elmoscapital@gmail.com', 'Moanamisi  Seyayo', '$2b$12$g9QjqYzwNF1Un4eQJZtem.6GV3z2eCZFxZT45HYJp2XD3oD43S9XG', true, '0A8NHUMWXBRA', false, '2026-02-11 06:37:56.279983+00', '2026-02-11 06:37:56.280009+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9fb26137-cb0c-4c02-864d-2fa89274cf42', 'simphiwexulu063@gmail.com', 'Simphiwe Xulu', '$2b$12$LPiJ2/n6nWXz2YGnryZeJ.XGbe9irKk/BUn0yiS5WPYtyc62.T4pC', true, 'FBP3BX10WA43', false, '2026-02-11 06:57:31.697237+00', '2026-02-11 06:57:31.697256+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a86476ff-db31-48a5-be78-7123c265b4fa', 'perfectisaacnyaving@gmail.com', 'Isaac  Perfect', '$2b$12$MqGvYBhrXRfhhENCIKveLufXBaX2LyAFoF0f7rYpfUC25vaWBAQvm', true, '52FZR82HT8AE', false, '2026-02-11 09:06:48.82108+00', '2026-02-11 09:06:48.821102+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a5cbb10a-fb54-46d0-83d2-fbbe9f8ddf06', 'hammabilyamin11@gmail.com', 'Bilyamin hamma', '$2b$12$pzJFr6EzZj/Xaa684lBFCuAvo3pYjhnRfHCxt0Al/zTn9hXajqnF.', true, 'SJQ3YI19OQ64', false, '2026-02-11 09:11:21.520565+00', '2026-02-11 09:11:21.520584+00', NULL);
INSERT INTO public."user" VALUES ('923cbc23-090b-437f-bf06-fb99240c79ec', 'rjflame975@gmail.com', 'rj flame', '$2b$12$Jry7Y/506H50eyoNZzRDreIwJyr.lnL0IqeKefS8Z7.b8zClrXHOy', true, 'R0K1YL2MYBDX', false, '2026-02-11 17:23:24.441272+00', '2026-02-11 17:23:24.441291+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('24803670-0e3c-4335-a75d-e34e56db23f6', 'boib27050@gmail.com', 'Hassan  Sesay', '$2b$12$dgS/1f/9G9NIQBrrDyt8huQdW8L9ux6btvYKMEAHy.x9N44ThMEMC', true, '84N9JOVCKVQI', false, '2026-02-11 20:32:19.328353+00', '2026-02-11 20:32:19.328377+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a8b0d021-8033-4fa8-ba99-ed65e8768835', 'riotsociety76@gmail.com', 'Moon Napoliane', '$2b$12$0OX7M4fXDBOK4hX/cQT73u17xlNmMvAyvHUlmhdYrNVIfiHyL4Xre', true, 'Y5S2UW640R07', false, '2026-02-12 05:27:37.314888+00', '2026-02-12 05:27:37.314906+00', NULL);
INSERT INTO public."user" VALUES ('38f69cfa-0ef4-4313-b7e6-686e4518d30d', 'popleenjakarta@gmail.com', 'Gospel  Osadolor', '$2b$12$iS7zqDIUMMsrY1YzYSYHcusoCVafz0RMlaZbctjEftSAyF9BBbXG2', true, 'WAGZ2MB2T1ZM', false, '2026-02-12 07:04:07.207693+00', '2026-02-12 07:04:07.207714+00', NULL);
INSERT INTO public."user" VALUES ('aa9c4a43-2f4b-4cee-a624-f26476e82778', 'navinnarayan001@gmail.com', 'Navin Sirsat', '$2b$12$BH4GAP9Wrdt1s1dw8Z6uaO41gPFOVJEkwkGYE5QzopDW0LrOtANOG', true, 'PA3M280OA1F4', false, '2026-02-12 07:05:45.107409+00', '2026-02-12 07:05:45.107433+00', NULL);
INSERT INTO public."user" VALUES ('fb475baa-6a9b-458d-9aca-6b9aa4b79b9d', 'wowegusa@gmail.com', 'Nizeyimana Patrick', '$2b$12$I.HCcjkfk4otAyQuiRdxs.zO.jUmDNw2PZEQrJ5Q/kKnFvJcYcwNy', true, '45YHML1JUCDS', false, '2026-02-12 07:08:01.182766+00', '2026-02-12 07:08:01.182783+00', NULL);
INSERT INTO public."user" VALUES ('24d0e861-76fa-4a57-affd-cd053bb06163', 'danielsanaki709@gmail.com', 'Daniel Sanaki Kwaku', '$2b$12$gPgWYdTTqKSFuX5gOpvWJuOS3aM4UwIzhFsoIOnZW2NTT8cGI28xG', true, 'LTJ8RQOXX1ST', false, '2026-02-12 07:08:22.712745+00', '2026-02-12 07:08:22.71277+00', NULL);
INSERT INTO public."user" VALUES ('dc6b7352-0308-401c-aca9-a59020f28667', 'aarizbhat7051@gmail.com', 'Aariz  Bhat', '$2b$12$s8ky0CqYueMXDGA1kmjVC.w7D6gSmIG6axYjh8hGXF1z0H.Q3MSbm', true, '1LPJXA8K1BFB', false, '2026-02-12 07:10:03.793196+00', '2026-02-12 07:10:03.793212+00', 'FCC07782');
INSERT INTO public."user" VALUES ('2b14fd1b-c3d1-4061-8dc5-19f1d2f5940c', 'kaushik6675@gmail.com', 'Kaushik Patel', '$2b$12$FCw84F6wqI.TblNKZuhMu.MVPKFW3nOfx62Mz6Ef9Yy0dyN6MV20q', true, 'ALYC5X2NQ3QC', false, '2026-02-12 07:10:23.38669+00', '2026-02-12 07:10:23.386712+00', NULL);
INSERT INTO public."user" VALUES ('e3c3ad62-a441-4351-85dd-586d7777e9ee', 'mdsarif999@gmail.com', 'md  Sarif', '$2b$12$c0c.TKiSlti1LFw3wNAOG.d1uu9tl8SFkrTk8YZSu8IqWhkN4N7S2', true, 'TQL51YI18EMP', false, '2026-02-12 07:10:37.832908+00', '2026-02-12 07:10:37.832986+00', NULL);
INSERT INTO public."user" VALUES ('6ea479f9-e742-42fa-9b5a-776033c930cb', 'gbestfx@gmail.com', 'Gideon  Pam', '$2b$12$gwdD1VqAZFHJejKou5PG0OopDrAmvt7Kt1jWjFBwpJCzDxKuE9GnK', true, 'HJCFLJN12JU7', false, '2026-02-12 07:10:39.962579+00', '2026-02-12 07:10:39.962601+00', NULL);
INSERT INTO public."user" VALUES ('bd588a3f-a110-4550-bb8c-e957ce6a7fa7', 'africanmavin@gmail.com', 'Verce Mhuza', '$2b$12$sw.05.GNH5ft05C8GPEEK.NUAIE0B/lrtCY5DHVscp42aFZStpLUa', true, 'QJLS0BNV8D95', false, '2026-02-12 07:14:45.67053+00', '2026-02-12 07:14:45.670555+00', NULL);
INSERT INTO public."user" VALUES ('56299b5a-6731-4613-8436-a30c91a0bb46', 'ochinenyengozi@gmail.com', 'Chinenye Iloh', '$2b$12$xjjAXulQBlfHyRurYjGRlueSa24WCwvDK/24GCWdAu8X58KtyfQ3a', true, 'HFUT6YBUEGC5', false, '2026-02-12 07:22:13.712389+00', '2026-02-12 07:22:13.712419+00', NULL);
INSERT INTO public."user" VALUES ('cdf9a34f-1076-47e4-af02-c8abc51d1a35', 'domainhaywhy@gmail.com', 'Ayomide Christopher', '$2b$12$LrdNHU0IGCm23Bsq.x/DTOfbzhCwnqj.vCtsLdL8Va5E1CIPjxAZO', true, '3E7VPCGN4BN5', false, '2026-02-12 07:42:20.511654+00', '2026-02-12 07:42:20.511679+00', NULL);
INSERT INTO public."user" VALUES ('6a26235e-bbd0-4448-96a9-717a2db17841', 'rehanbravo7@gmail.com', 'Rehan Zia', '$2b$12$0oGAKesQry5z1wxn/xrJvODEr7rKOYDMN3ELeUBNxV4RHDXGQADAW', true, 'WL3AVYAIYWIH', false, '2026-02-12 08:04:57.334281+00', '2026-02-12 08:04:57.334305+00', NULL);
INSERT INTO public."user" VALUES ('c0c80cc0-5e60-4fdc-a609-c57c6e960a3a', 'robertsdavies007@gmail.com', 'Bibby Egwu', '$2b$12$f/0/98P0SzuC9z9mXZE2KO56RgeggxpwudIsteIOKnjz0iGLqsS..', true, 'N2FIKJMB4S2L', false, '2026-02-12 08:42:21.652641+00', '2026-02-12 08:42:21.652677+00', NULL);
INSERT INTO public."user" VALUES ('537c0572-6365-48fb-84a2-cab862791bcb', 'ashangunza11@gmail.com', 'Asha  Ngunza', '$2b$12$D/MHI1nBIeQsjRzsDHt1AeliM06Hv1qP8RzNOtFKMoxi1gUDhw9ki', true, '1R0KV6DYRFBG', false, '2026-02-12 09:11:35.544361+00', '2026-02-12 09:11:35.544383+00', NULL);
INSERT INTO public."user" VALUES ('a2385664-22a3-44a6-afdd-f43c6f8b9e70', 'realricco1111@gmail.com', 'Royal  Ricco', '$2b$12$PfDrWBMIuJNzJbkCsTrQFOfzbHIElMGcgxiH9ox3otCR0dK05MdH2', true, '3VOQUU1E7FIT', false, '2026-02-12 10:05:28.650391+00', '2026-02-12 10:05:28.650415+00', NULL);
INSERT INTO public."user" VALUES ('8f4331b0-b245-4baf-b152-bda96b78b55c', 'bawabpeter@gmail.com', 'Piter Bawab', '$2b$12$bCTEvBz6WCG/nsZ1ky383OhRSYgG5NvIa4oqCC2vCRS7g6PNuCkJW', true, 'VCQZLXWNEMX7', false, '2026-02-12 10:14:46.074106+00', '2026-02-12 10:14:46.074128+00', NULL);
INSERT INTO public."user" VALUES ('9f2c2d17-92d1-44db-a021-c5b8891b2602', 'petertakunda316@gmail.com', 'Peter  Takunda', '$2b$12$/nOs0A3Rrgmm707uvig9TeLHyYJvLUZoAzKb112r46ep/53yBqFCS', true, '7CW7LTZFKFSF', false, '2026-02-12 11:26:47.250423+00', '2026-02-12 11:26:47.250441+00', NULL);
INSERT INTO public."user" VALUES ('1de3e48e-f62b-46cb-b46a-f749cc0374a3', 'halimaisa906@gmail.com', 'Usman Muhammad  Khalifa', '$2b$12$Jhh09w/OF9ITUU/jFsoXuO.b1sAPDaoICV.Y.Y0nMNjVZ7jZX1rF6', true, 'PJIE3G97GXKE', false, '2026-02-12 11:27:32.414597+00', '2026-02-12 11:27:32.414619+00', NULL);
INSERT INTO public."user" VALUES ('16cc0205-e75a-4260-bf69-ab2d1e193c7e', 'tradet123@gmail.com', 'Hai  T', '$2b$12$oxVBDLakEzNYJH9it6oQseqF8nhrLWSiRCFcloPYBwSHS96VtVLWq', true, '6R58KYF9FLY5', false, '2026-02-12 12:33:42.649381+00', '2026-02-12 12:33:42.649414+00', NULL);
INSERT INTO public."user" VALUES ('71245d86-dcd6-4973-8e92-2e4adb0ca5f6', 'trader123hai@gmail.com', 'Hai T', '$2b$12$K0Fmq5Gcwz9oeKZkC7D8tO80tWxgPtVmp6D6NQaV2f3DzN0dM7/sm', true, 'LK5ZQ2UW3WJM', false, '2026-02-12 12:35:48.296014+00', '2026-02-12 12:35:48.296034+00', NULL);
INSERT INTO public."user" VALUES ('8a38fc36-fa15-462a-b615-932f103d2773', 'pdaswift3009@gmail.com', 'Paul Azemoh', '$2b$12$Vd5iCriplax0ccIghSuaG.p8MND16gLi/c7cvXUVwcZbLv8YUuGie', true, '90GUZ19PRYQD', false, '2026-02-12 13:30:00.472394+00', '2026-02-12 13:30:00.472418+00', NULL);
INSERT INTO public."user" VALUES ('e1e584ff-08b9-478f-a388-ab2d00067ec2', 'happinesshass@gmail.com', 'Kah fei', '$2b$12$QHv3HEonbLDYOuIR2.Eum.LMCLq0FWOKnl4n4ISdTSKO5HU3VHjKm', true, 'JXM8QQY8UKLT', false, '2026-02-12 20:10:32.178648+00', '2026-02-12 20:10:32.178667+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('dfb01759-4ae4-4408-afee-62ece259e512', 'elmma686@gmail.com', 'elnathan mbofwana', '$2b$12$Lha6LmTJEXhCbGjiqcdUL.1JLtTPZD4Iy2tfjqvYmgH7WyRbuFRde', true, '7RQM5ND18FS4', false, '2026-02-12 22:49:32.962868+00', '2026-02-12 22:49:32.96289+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('39f42757-6012-42e1-bbe5-ef502b728c7a', 'edunrybaba@gmail.com', 'Oladimeji Edun', '$2b$12$pt1XILUMSQCZU/GeJ6BPyuWGg9CzqE6aSfgEZ2/nyY0oSRx8v5Nj.', true, 'J20LKTEC9ZXQ', false, '2026-02-12 23:52:24.802531+00', '2026-02-12 23:52:24.802548+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('49a103c3-abaf-4d6a-a6b7-cc9dd0ba2f40', 'Toyindeals@gmail.com', 'Toyim Odujobi', '$2b$12$1LpacPQJ6vxp2MUHaSPTLeGGxRFNoJJyJjSyHhRdrBt1Y4ZGjWaZO', true, 'TDB1NOGMBV46', false, '2026-02-13 02:08:29.045071+00', '2026-02-13 02:08:29.045099+00', NULL);
INSERT INTO public."user" VALUES ('fc8c9fe3-115d-45d9-994c-064afaa696f7', 'stevenwheny79@gmail.com', 'Steven  Lyimo', '$2b$12$ggOzQVa5jrDRkdjsj1d4h.08BJsKDFC8ieMBZRlMfDEL3QDiblDZ.', true, 'N0C0YY1JMEKW', false, '2026-02-13 04:47:06.105053+00', '2026-02-13 04:47:06.105074+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0b5e9c2c-5eec-43bb-ad8a-dc9ebbd4882f', 'ntuliedison100@gmail.com', 'Sandile  Ntuli', '$2b$12$Lp3gQjxx7iTcrfVFapiV1urO6VIlicZEIKSMt/8f3E6tWcTu4YDoO', true, 'GLD9NEJLHJF2', false, '2026-02-13 06:56:00.150452+00', '2026-02-13 06:56:00.15048+00', 'FCC07782');
INSERT INTO public."user" VALUES ('8d7ad01e-702c-489b-b58c-3ad2622c902c', 'abdullahakmal533@gmail.com', 'Abdullah Akmal', '$2b$12$1B/Y8AVxxnbnoOpjoSe.gOBDJMV7sS1TP2DTC3RQxMsHfLPuFh5Ky', true, 'WTEIVZW74F1S', false, '2026-02-13 09:34:43.418383+00', '2026-02-13 09:34:43.418414+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a69a40eb-5688-4881-b74d-ebfb5ebe0c26', 'parshalljoel9@gmail.com', 'ATIKPAHU ELIKPLIM', '$2b$12$/3jIkaGUeuK8Gfj1SdeZJuQF3MJjH3h7xsTs6fjyml/3RAm1Qbu1W', true, 'FNU3VML8S6GY', false, '2026-02-13 14:05:57.20459+00', '2026-02-13 14:05:57.204616+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('13d8edc9-5b23-4cb4-beb1-2344ef61dfd1', 'weindellsuvilla123@gmail.com', 'ELEAONOR SUVILLA', '$2b$12$ZBKVi382p4claYD7XVgmI.yIPLWx0zwcncCHtrE2VJKc93wyVVXwy', true, 'HHZR1OPTIK5C', false, '2026-02-13 14:22:13.025158+00', '2026-02-13 14:22:13.025186+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f5e1dff9-d2de-4c75-99c4-6948014450d3', 'emmanuelakubueze46@gmail.com', 'Emmanuel  Akubueze', '$2b$12$LULw0e1rxXQJM7qYQxUBau/bso8yVH2brCxaD9/eSJSN260twE5rG', true, 'N2VJMMJO78N1', false, '2026-02-13 15:20:45.361036+00', '2026-02-13 15:20:45.361056+00', NULL);
INSERT INTO public."user" VALUES ('71ad88e7-897f-4c55-9d57-c0ea4b36442f', 'eokechukwu616@gmail.com', 'Emmanuel Okechukwu', '$2b$12$KvPdlyYDmMScv/mL3KU1V.BYVhwNugHPKc/.gx9m9gJIwm7rTtgNq', true, 'CLHGRR4U75E9', false, '2026-02-13 18:59:37.540242+00', '2026-02-13 18:59:37.54026+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d8bbbbac-880c-4d93-9df8-1417f1df404e', 'itsinsachin.66@gmail.com', 'SACHIN DUBEY', '$2b$12$eRraLwuWv29QKImQaNHchu9tJu5RxGbuxzKgLxcHSvfoLNchOrKm.', true, 'FMT921K3PFFL', false, '2026-02-13 19:36:31.485567+00', '2026-02-13 19:36:31.485592+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('50735a32-4728-4085-b755-03233574771e', 'kikalendel1@gmail.com', 'Kika Lendel', '$2b$12$JffOKzT498UmiznkSjAYsucKT49E0uBGi76XqknWFrXsh0Ky1HXeK', true, 'ERHZJVCNED14', false, '2026-02-15 03:01:20.652131+00', '2026-02-15 03:01:20.652169+00', NULL);
INSERT INTO public."user" VALUES ('eef61e02-1ff4-417f-b0d2-e0611f1b3f9b', 'wdemar40@gmail.com', 'Demar Williams', '$2b$12$1x3rAfhF85Ej1b2GJzb0lewjzrjpRgLUEgF.IwBarlKJAKYuAvAh2', true, 'H1L5SWSVNWOU', false, '2026-02-15 22:04:10.429736+00', '2026-02-15 22:04:10.429761+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('dc1daffc-427f-47ad-8089-d6f894f3dc87', 'oluwatimilehinayomide6@gmail.com', 'AYOMIDE FALADE', '$2b$12$o0n9tlJCcdcOEpr1jRIoZugieda.4Vezi6rIalVFAQsR21aCsjyv.', true, 'W1G1U7P6F2O2', false, '2026-02-16 00:37:45.1163+00', '2026-02-16 00:37:45.116331+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d2b392fe-adf3-4f34-8536-ad3bf537dcab', 'ofentsetshepo231@gmail.com', 'Ofentse Tshepo', '$2b$12$D/RKdattPAImbIo.6kyewOlpHhVe9kglMmmzT53D0Sdoo2J5G3yAG', true, '9C2DL37XVX8Z', false, '2026-02-16 01:14:50.416372+00', '2026-02-16 01:14:50.41639+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('95601031-49ad-46ef-a152-ad2ec6c5901b', 'tayebriuk@gmail.com', 'Yishak Misyru', '$2b$12$vLUlDC7BQMGP.L4nA./Hcuo8ysMt4o9LwPshkcIGv5iY5qKLG7qlq', true, '121VV7JQ8Q37', false, '2026-02-16 01:19:01.785313+00', '2026-02-16 01:19:01.785345+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('85578a97-c52e-472e-94a0-fb7a9611b03f', 'dithakrisna1004@gmail.com', 'Bernaditha Krisna', '$2b$12$UWzq5tLi2I4nMgTZod2q2Ol0dI0VOLQ.C0tcYdKhf1qavOUT3JTWK', true, '4PNC9MKCAVVG', false, '2026-02-16 01:25:27.519775+00', '2026-02-16 01:25:27.519809+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('32db4b4e-773e-46bb-8be8-b469b5ff765b', 'ramishyt486@gmail.com', 'Ramish  Ali', '$2b$12$SbITT/47Oo8b7/aPYdD/AuoUhNw7JJBODaKk31WNpHShrUwccJcsC', true, 'AQGXT3Q8570D', false, '2026-02-16 05:56:40.692014+00', '2026-02-16 05:56:40.692067+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fe1e9bf5-77de-4457-bd4d-c6922802e482', 'luckyroland755@gmail.com', 'Lucky Roland', '$2b$12$zQ1//1nXIzUSl2oPBIoRaecBRcAzjEV/sdbPX6PWm8dcI/HFdKOJa', true, 'VSWZ046D8VA6', false, '2026-02-16 06:43:09.514676+00', '2026-02-16 06:43:09.514695+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4a39928e-72cf-4cb8-8368-ebb12574b72f', 'fakhirslb@gmail.com', 'Fakhir  Ismail', '$2b$12$ocZ8x/yzJ89BlOVJkT9lcuczt.sx/x7K.5S.FGI0HX.23xcEyKPzy', true, 'TV73I1QMJ379', false, '2026-02-16 14:34:32.013368+00', '2026-02-16 14:34:32.013392+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('397284cd-b5e1-442c-8656-f10e64eaed0a', 'muhirwavedasta@gmail.com', 'Muhirwa Vedaste', '$2b$12$4C.3.4cVIgYu/Dj7Cq2Yn.rIKWSksSun00jsbkVOlz.seRQrMgy5i', true, 'F06M2R8PS0I5', false, '2026-02-16 19:24:43.195484+00', '2026-02-16 19:24:43.195502+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c24c11ec-cc55-46c0-bc9a-cd09a73d8211', 'mathewsjana09@gmail.com', 'Mathews Jana', '$2b$12$bu/SUtDVodyseKkzF3/Rw.K43d8j0UPyBzTs9luCCRRQZ5Q.dZrL6', true, 'UAFLDRD0BO6Y', true, '2026-02-17 06:06:23.029326+00', '2026-02-17 06:06:23.029354+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('33ec8b53-9f39-47f0-97e7-46223809ebed', 'trinitybenson08@gmail.com', 'Trinity benson', '$2b$12$EIAiBUNcfn62tVNW9MBNdux7X15qv0HYKunWSkF7Iq2WsgEUmOlPq', true, 'GGWRWL1MEE6N', false, '2026-02-15 01:03:00.549491+00', '2026-02-15 01:03:00.549514+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b627e56d-4f2d-4b23-a48e-aed7d0264bb7', 'hamdanjaani896@gmail.com', 'sami ullah', '$2b$12$7WzYlwng5thKbgDvo72fb.q/iDz5kWVNhqEgVVzLOsu33I1gorn2K', true, 'UUXB7VLI39UF', false, '2026-02-16 01:14:58.28295+00', '2026-02-16 01:14:58.282969+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7d3ed82a-e6a6-414c-9bb9-24382f995ca9', 'abebehabenom710@gmail.com', 'abebe habenom', '$2b$12$H2qEJ8JQ16m0ZtwHeJsMduKpprrLh/eH.d40wVPwET44/lh4dtJbW', true, 'ZG6AKFWTBMSG', false, '2026-02-16 06:03:02.131929+00', '2026-02-16 06:03:02.131956+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1741b8a3-7ee9-49cb-b9e7-97a33e16bae1', 'ikechukwuw64@gmail.com', 'Mmadubuike  Ikechukwu', '$2b$12$wuCOLYSND.K6y2YnkYUF6uNZxALeH5INR7QbUkH6P.bB9olNF20ra', true, '30RZ9ZGIHTL5', false, '2026-02-16 15:38:22.534083+00', '2026-02-16 15:38:22.534115+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6b138960-2066-4a83-8af5-f14546c62cd8', 'israel.omosowoeni@gmail.com', 'Israel Omosowoeni', '$2b$12$9CAUKDCshrSxpyw.KhYepuno/TwtOEuzw87tkx.L2puwir51WeKcy', true, 'VCMVFTSG9ZGF', false, '2026-02-16 17:17:08.495361+00', '2026-02-16 17:17:08.495392+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c7ce40f0-29a7-46a0-b434-ccb19ca7eb62', 'jowaynemanning6@gmail.com', 'Jowayne  Manning', '$2b$12$LDoBcK56pXTLCjF1T7ELV.yY7B9uHB96z44YUlpzLKnIqGwefZEc2', true, '5PX6QYQYIMQ5', false, '2026-02-16 22:30:53.249502+00', '2026-02-16 22:30:53.249528+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('39ae0193-7d13-4dff-a3c4-165184f98fab', 'lawrencenyarko382@gmail.com', 'Lawrence  Nyarko', '$2b$12$trAILy.nPK.VJpa0/Q1MHukAqINW0KtQ/6mY1Qu75SazmL.otbpQK', true, '6UYVKPPMG4JN', false, '2026-02-17 01:03:31.180497+00', '2026-02-17 01:03:31.180515+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('155f55a2-ae5b-4649-a441-dc1fb24f5fef', 'walexogunfowora@gmail.com', 'OLAWALE OLUWATOSIN', '$2b$12$DcPnTE4Q6z948vvRviL.jeYRYZHYLhzECn8IEvcdYR593Dznvnti2', true, '46T4QPJNN1AV', false, '2026-02-15 10:15:41.08121+00', '2026-02-15 10:15:41.081237+00', 'Mr p');
INSERT INTO public."user" VALUES ('d2ff5166-862b-4597-ab3a-e87102ddba87', 'Dougiomos@yahoo.com', 'Douglas Omokhodion', '$2b$12$VAAwfx5wSYwTOcXI0CJ9luyCt5W65QTp3v0S7TZ3sHWUZnLIAIZny', true, '5HA2SEZ4WLVS', false, '2026-02-15 11:12:09.381257+00', '2026-02-15 11:12:09.381285+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('828ed372-7956-4623-a0ef-0d85504369b6', 'ajideoluwatimileyin9@gmail.com', 'Oluwatimileyin Ajide', '$2b$12$QUPBhCwOX2LvVK86mmy2KOqyNalGag/XPGjiaLXvdtQdOguklhrTS', true, 'YXGUJ9IULPSJ', false, '2026-02-15 12:50:17.961029+00', '2026-02-15 12:50:17.961055+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bf08c759-9bfe-45bd-985d-116aacfd2342', 'malikrajay4@gmail.com', 'Malik Honeywell', '$2b$12$grcrxrp6f3AdrMuo7zbbCudDL4jrN2ZcCu1f2Bu2H/XzxPgQs0L.G', true, 'XRJ6KBLTUT6X', false, '2026-02-15 20:43:52.400501+00', '2026-02-15 20:43:52.400523+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ace0fa18-a66b-4963-8cb0-760b2d3dbb15', 'eruinvest@gmail.com', 'Sunday Eruchi', '$2b$12$iXpRPwvUYAs997PqxcY4J.kAPEBFVA57a6RxmgZPGz.U/jik6kYgK', true, 'RFJX1UZER6UH', false, '2026-02-15 22:04:40.406134+00', '2026-02-15 22:04:40.406158+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1aaa1b83-1830-4c13-a3d1-803a3ec224d9', 'mampuia4721@gmail.com', 'Lalthankhuma Parte', '$2b$12$Oins0CTzVILwUrJemybHNuvZ1PNXtH2RzkDnSE0fE7JvvsVMAGRou', true, 'HJU22L7I01MC', false, '2026-02-16 02:44:37.962231+00', '2026-02-16 02:44:37.962251+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7659e264-268e-45f8-8b82-ed3e4310a601', 'manjunathsajjan2@gmail.com', 'Manjunath Sajjan', '$2b$12$JW6WRaOCptL0fr1YbKT6NeR5YKY/07UTVblwrGs/Y5AQcVcNjcRBO', true, 'KAB7OUO3X6SL', false, '2026-02-16 02:45:26.794978+00', '2026-02-16 02:45:26.795007+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0422f42a-9194-411f-825e-0e0ed7c62e74', 'edehvictor292@gmail.com', 'Miracle Nwanaekwu', '$2b$12$70Mr7sCNC8OWH0iiqs/vN.7hEJn1YYhF.iz7SsXoWtOaK0r0Yn.4K', true, 'Q7BSMZF5OU6N', false, '2026-02-16 10:28:54.636386+00', '2026-02-16 10:28:54.63641+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8a06cef9-0944-41f3-a2ea-f794bde7b1ee', 'alishba78fatima@gmail.com', 'Alishba fatima', '$2b$12$0Z5TKVOjDHk11EnfDd9Mvu/KHGDNdS490jaj8V5JjpOZEo/UjPKmq', true, '6QFCPUDRS2VA', false, '2026-02-16 12:05:06.376817+00', '2026-02-16 12:05:06.376841+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c0de9c6d-4c4b-48a5-a853-18309f7d70c3', 'algaraupendra01@gmail.com', 'Algara Upendra', '$2b$12$ZqPQpYCBZitYk6XUu4wqIOP.RBGtCgwvPVjGpejR16jAbe17HPJWi', true, 'V71AEUWCTGY1', false, '2026-02-16 14:35:21.997527+00', '2026-02-16 14:35:21.997547+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('56654e0e-6070-4c83-8507-ec806031ff33', 'lankeylarney@gmail.com', 'Nsenam Esseyene', '$2b$12$pvf5qisexDQnSvSuwWzJn.6JEgdiQxXPx0DpgZ/OUJ.el0fFjl4Qq', true, '0SNRVJET5GN4', false, '2026-02-16 16:45:14.479168+00', '2026-02-16 16:45:14.479187+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('95d9918b-a4b4-44a3-aefe-10ba3b76d001', 'echiwetara@gmail.com', 'EMENIKE  CHIWETARA', '$2b$12$8/C7gBCGm6qFeEoBgQSXhOh15X1428ZelQQbvjdEkQwnDI3vmUSre', true, 'O2RAD7LW453O', false, '2026-02-16 16:58:07.791841+00', '2026-02-16 16:58:07.79186+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0b5296bc-561a-45a2-bf5b-29d752f6fe17', 'demoycallum2007@gmail.com', 'Demoy Callum', '$2b$12$FQPumIpRbW68wdpPK9P1DeAlTeuriPGlms50wKbf7Xz2M3EUOIlJO', true, 'LKN6URMNF78O', false, '2026-02-16 19:28:05.953911+00', '2026-02-16 19:28:05.953932+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('43e93d11-cfbd-4238-a4ee-8931710ea9ad', 'empirelucky35@gmail.com', 'Mothusi Tony Marumo', '$2b$12$Rl3q17h1xG4XoC57rz3gRuWIXLbeJ1dMFUTjkrUwZYuetGwBYCr42', true, '00MI8HAZKHWC', false, '2026-02-15 20:18:12.915695+00', '2026-02-15 20:18:12.915715+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8e80776a-3667-4525-830e-4f2be2cfe8f7', 'guzodapa@gmail.com', 'Kennis Dapa', '$2b$12$VWBxQD8LPZGwPm9EBZi4feCzpgF.UgoAkpSPCio.tI6JmXnG5EjIu', true, '1EZIB1CSU9LG', false, '2026-02-15 20:25:49.377673+00', '2026-02-15 20:25:49.377704+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c2a11d66-311a-4a95-a9a2-c42213ad1228', 'victorotuyelu112@gmail.com', 'Victor Otuyelu', '$2b$12$C1G/c9ZWCQ5l8R3tOgb5geeob.U4C5.N5AMQaZraZZIzwW6yZnLE6', true, '6SGAH9O1TZUP', false, '2026-02-15 21:29:58.068629+00', '2026-02-15 21:29:58.068658+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('195a6149-d048-4aa1-9118-68fb6ac0b612', 'machinemyke369@gmail.com', 'Michael  Obiora', '$2b$12$kV3YfXvLndG3yf8O8YnEUuDYoGRDy3q9CmZ64Ko8MYVQwMzuBK676', true, 'O490XC0BH767', false, '2026-02-16 10:02:44.035381+00', '2026-02-16 10:02:44.035423+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5121a7b3-e9d2-4484-9ee8-d1bb2bef9976', 'daniele.mariotto@gmail.com', 'Daniele Mariotto', '$2b$12$tsoAPZg/so2F/mZRUVzQienTEX4r00cl4mLjDLycAb55MSbryrABG', true, 'SL80HZD522IH', false, '2026-02-16 11:33:49.369023+00', '2026-02-16 11:33:49.369068+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('cb26ce7b-0fd8-43ed-99c4-63d664df7f09', 'adebmatthew@gmail.com', 'Matthew Adebayo', '$2b$12$zGdQ8Sw4Ut.gGzu4FwAKuuubXFpkKXmCBSAcywQdCuZAf.9yNbGaW', true, 'U4MOSDW59P4H', false, '2026-02-16 20:50:18.667268+00', '2026-02-16 20:50:18.667293+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b073f20f-6066-4688-afee-1c6a2d6254d1', 'ibrahimdanladi571@gmail.com', 'Ibrahim Danladi', '$2b$12$J9LE7n.qAJXScAdIRiqLKuLFxtH1rNI2KhGdjUyHjKeoCW2VdnTgK', true, 'DL3Y1TRPK98O', false, '2026-02-16 21:25:21.662576+00', '2026-02-16 21:25:21.662599+00', NULL);
INSERT INTO public."user" VALUES ('466617ee-6a3c-450b-8e08-35c8483110af', 'tinashemasawi9@gmail.com', 'Tinashe Masawi', '$2b$12$1N6ISeoZcvzNfg80F0v2dOP7RIYiRNdAdLMEEeepuyZ7TvGQ4iGoe', true, 'J9TK1W4WA3W5', false, '2026-02-17 07:25:23.123873+00', '2026-02-17 07:25:23.123899+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c92b7e44-11ea-4a5c-a5a9-ead83094eb76', 'zeeshankhanx001yz@gmail.com', 'Zishan Khan', '$2b$12$ih.DZojBkg6U5B5nsu8QauSlTve3ZPAbIcVG0YZba/W6Pki1JlXhC', true, 'KYMYFE1IWX9Q', false, '2026-02-17 09:02:52.248974+00', '2026-02-17 09:02:52.249+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('018703ef-7b11-4115-bf21-9244d34ff12c', 'albertamador053@gmail.com', 'Albert Antonio Lara Amador', '$2b$12$5U3n4WoJ24sagW3UJPlGi.i7hE/f5KOfbR5M8JToxLYD8HPiyVzby', true, 'DOWCDBGX8Z54', false, '2026-02-17 13:20:47.277022+00', '2026-02-17 13:20:47.277046+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c96a526c-6507-4306-9872-494ef7138020', 'aymuratovquwandiq@gmail.com', 'Kuandik Aymuratov', '$2b$12$px8e6xQkAwh5GWVDzeq6.OAluGx0ff/IVpX.vVm8gyITU6Oq3l0Bq', true, 'XJM0HLW2YFA9', false, '2026-02-17 15:44:19.185026+00', '2026-02-17 15:44:19.185051+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f492e7f3-a5ab-4b53-baf5-3d5cc3e51f5b', 'stephoche2002@gmail.com', 'THANKGOD OYIGEBE', '$2b$12$xU2nayj2lSS/OoDVSssLhuiEjOYqcqMJoJikXwjme8MM3G940NfxK', true, 'O8ZEBBBSHDKG', false, '2026-02-17 15:46:25.39792+00', '2026-02-17 15:46:25.397942+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d00638bc-a727-49cc-9997-0a30f1a8f583', 'oshoopeyemi33@gmail.com', 'OPEYEMI OSHO', '$2b$12$PeuaNgREXt4k40Xp3ET0fOVy/5ZJhdlOH8Oz77SmyqVlWl2cx8s..', true, 'WWKUBWY2P5WF', false, '2026-02-17 16:54:16.591787+00', '2026-02-17 16:54:16.591818+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d09ab053-e92c-4276-ab2f-d1ada8609f10', 'ghotoshaman91@gmail.com', 'NAVEED AHMED', '$2b$12$uQ6XYTztZgMhOUq//75V/eoe8hgZNmkmY9Jd.54/xaqXZIxQf8hIG', true, 'EFMI3SE0G37A', false, '2026-02-17 17:23:20.815884+00', '2026-02-17 17:23:20.815902+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('90a15a41-7c96-4f15-958a-6dac3ebc9134', 'kurujyishuribarnabe38@gmail.com', 'KURUJYISHURI BARNABE', '$2b$12$2y.FRs.e10.Ym.r4x9rJaO5MAgEiSEly0ZigMwEiQHGOhPLXN0eC2', true, '0LF5BM1I8QF7', false, '2026-02-17 21:47:27.682142+00', '2026-02-17 21:47:27.682187+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('66161db4-8f3e-4c32-b3e3-2c63dd8f5c31', 'junh47698@gmail.com', 'Herminigildo Jr Hernando', '$2b$12$j7jMP.a/Yqxm2q5rvJOSXuHu2de1LzkO1665VI9osrdB5ePaIBMhK', true, '3JFB7ADC5JSL', false, '2026-02-17 22:32:06.965242+00', '2026-02-17 22:32:06.965271+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a2fe604d-cdc9-4839-aea2-30610d82fd47', '2977788@gmail.com', 'alex stenkoff', '$2b$12$uzdBm7AfYXr18VI/9P1i7OHTwkx9vH.7HEJFxIEIkOmZpsyd9qUm2', true, '9XM8MYTJIWG6', false, '2026-02-18 07:38:05.802505+00', '2026-02-18 07:38:05.802525+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e6f7fb2e-f7ef-4744-887c-d2de71a3deb8', 'jeannicolas745@gmail.com', 'nicolas nn', '$2b$12$4Ke70mXK9HwDnfTnF0cvwOL5JGslXqWSCh/k3qr/S8nF6SpgVllUa', true, 'ZC7MM41IYIQN', false, '2026-02-18 09:03:05.320892+00', '2026-02-18 09:03:05.320917+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1c435ad3-6d60-45e2-aaa8-4c0369613853', 'yohannaemmanuel125@gmail.com', 'Emmanuel Yohanna', '$2b$12$biqr9SmVaut4jfQU9DyxX.7sIoUzTotkAc0PD2eyaKXiw//3x7bwy', true, 'VKLGE8XEBLAO', false, '2026-02-18 09:03:50.191515+00', '2026-02-18 09:03:50.191541+00', NULL);
INSERT INTO public."user" VALUES ('460d45a5-7a21-4f46-b7cd-387e7f980fc7', 'ankrahjoshua93@gmail.com', 'joshua Ankrah', '$2b$12$1ZDuIxOCvGDXGCY5fVz0YeCkxltTt0K54NNMTuRjs.QxVgWxSms1.', true, 'WL9W0QCC7KZU', false, '2026-02-18 09:43:34.899881+00', '2026-02-18 09:43:34.899904+00', NULL);
INSERT INTO public."user" VALUES ('9a33a4b9-293c-4c6d-9f7f-256763f9f04a', 'phuonganh2641@gmail.com', 'NGUYEN ANH', '$2b$12$6YvZrbezON6PylaYUhalsOEQ1wUhEwAxrrXqeEZI9GxU9mL.rHeoK', true, 'YKYSW90M1WDH', false, '2026-02-18 12:15:25.740335+00', '2026-02-18 12:15:25.740356+00', NULL);
INSERT INTO public."user" VALUES ('a611619b-0b04-4e7b-a8b8-1c4666ce48f5', 'ezekianyamhanga@gmail.com', 'Ezekia nyamhanga', '$2b$12$bxsCs2YcDOjho7Te/QYtKeKol37la.3xLrKeZZgvrqcbVrcAte3JW', true, 'RLC8RI0RPFZZ', false, '2026-02-18 12:50:51.125943+00', '2026-02-18 12:50:51.125972+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e95a3967-acf7-4e29-a0cd-24fdc3d5ea49', 'YJSPYJS@gmail.com', 'Jiashun Yan', '$2b$12$UxlymvYkJPCB2H0JBh8R/.vNJkz2B2tH/UZJpWKqk4Tt1EYXDxTzC', true, 'PRLY1DDYXF19', false, '2026-02-18 13:48:28.286644+00', '2026-02-18 13:48:28.286685+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c048c283-135f-4c4c-96cf-382e8af0ffe4', 'syedshamsudin07@gmail.com', 'Syed Shamsudin', '$2b$12$pZUcru6p/sHL8xKIg1WUoOKjfuhK9i6j0qAYhmjN1p5P9yTIkpfUO', true, 'OTVAGXAOREDF', false, '2026-02-18 18:05:40.748541+00', '2026-02-18 18:05:40.748568+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4dd754c6-c741-47c2-8dfc-7a985656cb0b', 'itrader01042122@gmail.com', 'Sunil Parmar', '$2b$12$QEvurOtcDYCor0cXsqxjfu.ZBxbpTe2G5F8GfXyfSpGvrvabwz2A.', true, 'SFVCA8GXOSSY', false, '2026-02-18 18:09:18.567026+00', '2026-02-18 18:09:18.567046+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2773ec8f-eb0a-4168-8bf5-2c5c92815969', 'sakaabraham88@gmail.com', 'Abraham  Saka', '$2b$12$LDL492W/oyOI5ebKE7E4b.R5m26D2Eo0ZyuEmCYlOGp/JWPdKCfSe', true, 'UFQ6FLFUOKIF', false, '2026-02-18 18:40:23.353261+00', '2026-02-18 18:40:23.35328+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4686c266-323f-4d2d-9455-c9a943b14a05', 'joelbank98@gmail.com', 'Joel  Bankole', '$2b$12$z9h/1.k0DPhDJPVO4WRYLeEWXVIvKFCl4FHW6RzR.eXIqcUSZx13i', true, 'A5KGL3O03N1P', false, '2026-02-18 18:44:38.126123+00', '2026-02-18 18:44:38.126151+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e3f52a75-f800-4b33-a0ae-8f216545864a', 'miacledaniel@gmail.com', 'Miracle  Daniel', '$2b$12$5a.7qvxqQSJWNBUUjJJA5uBRInu7sMUljGpTneFr3/soG9zgO1Drm', true, 'VCDIC8JVJKVQ', false, '2026-02-18 22:55:04.413821+00', '2026-02-18 22:55:04.413838+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('28f08352-9752-4ebe-820d-5fb1928883be', 'udehfaith48@gmail.com', 'Faith Emmanuel', '$2b$12$ET2Z8CLYdar2582gsCaZs.iBu92l7vx9T/RoWXRJULLZQ8L9yNxoC', true, '2BKGJ4R4B1OH', false, '2026-02-19 00:35:34.32444+00', '2026-02-19 00:35:34.324466+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5495ceef-417e-4329-b624-73dbd9ad2355', 'mahendrasaini3839@gmail.com', 'saini ji', '$2b$12$JJLu7SAYdgkLHiZOFWzBI.GY1obmzQSCiDSdJU7M1ImIO.pZ.yBqu', true, 'QOL41KJWJI0V', false, '2026-02-19 08:01:49.382002+00', '2026-02-19 08:01:49.382052+00', 'PJRI9LDHWDIU ');
INSERT INTO public."user" VALUES ('0f77e52d-0a07-4317-beaa-55de6f0d0ebb', 'toni4life44@gmail.com', 'Anthony nnamani', '$2b$12$wVnxk/8I2yVQS.gOm6tXf.Tq4q3UHOSxIwUrLkJy3Zj9QcbdlRINu', true, 'D0BOLOJYK4FF', false, '2026-02-19 10:32:20.35561+00', '2026-02-19 10:32:20.355635+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c2be98ea-1549-4a5b-a480-c581e8178d6e', 'deugo1@gmail.com', 'ugochukwu iroanya', '$2b$12$DSRw9qvwVc7OxoFhB9PG0.s5z5IsAp5Z7UY.MtquKe4CEfe3/XFa6', true, 'I7ZMMQFJIU1B', false, '2026-02-19 10:47:21.494285+00', '2026-02-19 10:47:21.494314+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a8fb5d31-37b1-41a1-b630-9b91d9825a3d', 'zinhom327@gmail.com', 'Zun Silva', '$2b$12$3QmDCZd6IQ1/d2RIfgoo7eDVTsoa9VrT9zSgcKYcq1jT1bchRDerm', true, 'IQIXEG2I6A6M', false, '2026-02-19 17:47:07.035463+00', '2026-02-19 17:47:07.035485+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2a552ddc-186c-42cd-a191-69d374dfd340', 'cryptokotka@gmail.com', 'Martin Muchira', '$2b$12$AJHdWX84ntMWjusvzHWeb.eyvjzSKFMNUEtXPlJ7zuiuntXY69CPy', true, '93FW00UXLZ96', false, '2026-02-20 08:39:45.068947+00', '2026-02-20 08:39:45.068968+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1b2f6a69-ebfe-4d44-a660-39aff36f6a12', 'musnaffx@gmail.com', 'Mustapha Muhammad Bulama', '$2b$12$3Z3I8RVfh3qF.jKKNdGsm.kQ658529hkkObpEiuEjZ2z3rpkOTmsC', true, 'EN6MAATM8UEJ', false, '2026-02-20 09:11:43.912244+00', '2026-02-20 09:11:43.912265+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('20f9ff1c-1668-45fe-94fa-c7905c7c1749', 'sadiqmohamed738@gmail.com', 'mohamed sadiq', '$2b$12$ARRkMDGbjsawPNBbIvC/7OCElJZ245SX7OAppX3afDHLYHTZs/zru', true, 'YVWKZMF7DZ55', false, '2026-02-20 09:45:53.848475+00', '2026-02-20 09:45:53.8485+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bcb3efee-5084-4eab-b7df-91089e02b130', 'www.jrmackbw@gmail.com', 'Keamogetse Junior  Mack', '$2b$12$0PqH38iHka4AHsS66qs1yOPR57HiieOANevIcLV2TKjxVR2AniZbi', true, 'UVS5AX5MYV15', false, '2026-02-20 10:47:29.972322+00', '2026-02-20 10:47:29.972347+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4e34d342-8db7-4b30-ad93-6f829f362b59', 'theontelyt@gmail.com', 'Theontel Schalkwyk', '$2b$12$.Evg1u8FsCz0QT/OBmL9ced9tN5rjsGbimxwxQNcqHkfHGvEnDOOS', true, 'VFBL4OZQ8P52', false, '2026-02-20 14:02:16.275765+00', '2026-02-20 14:02:16.275793+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a5ce4298-2cd1-4885-a6b6-cac256a03621', 'hamzakhanofficial.se@gmail.com', 'Hamza  Khan', '$2b$12$4wD99rceTJVrEhEExDvCs.Q6YWNhX09rdUqM6mP4hSnX8RYq34kje', true, 'S22WIXXWJWD3', false, '2026-02-20 16:15:34.611546+00', '2026-02-20 16:15:34.611573+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('772a2b85-a2e8-413d-b350-e348ce766106', 'innocentokorode1@gmail.com', 'Innocent Okorode', '$2b$12$zcR3eCYEdmG2VJM2Jpslv.fLZo60ZcnH4BNAKGEFFbSsRUh6lIciW', true, 'ESVYP7QSGJ0X', false, '2026-02-20 21:45:22.857357+00', '2026-02-20 21:45:22.857388+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('46c0e11e-5115-4058-85d5-55875e6643a8', 'afolabiziko131@gmail.com', 'Ezekiel Afolabi', '$2b$12$oqJiGj8aXkqn5p0JiBMaQOCB68ih1.VnYg4DU.dgZ4bOaAVXrXGV2', true, 'XLVZCCAXDG07', false, '2026-02-20 22:37:06.019088+00', '2026-02-20 22:37:06.019118+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c382ffcd-0662-4b3c-aaca-2139751c5cd2', 'mvuladalitso33@gmail.com', 'Dalitso Mvula', '$2b$12$LxJU8/QfZhbLPZTpul1S0.PtN6NzEiX3ObjN5r24Gh8UdZGWCgR2y', true, '4MBC4ILONYLL', false, '2026-02-20 23:50:07.49207+00', '2026-02-20 23:50:07.492088+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('15cdfd7c-2ca5-4faf-b838-c57d68622db5', 'shahmeer.hameed09@gmail.com', 'Shahmeer Hameed', '$2b$12$lpBxlpLaIjMMiYKEVXXaZur.fBxyoYfwDaU3J/E8jSER5KMfjvqaG', true, 'DNAZQEHZ37J5', false, '2026-02-21 00:40:57.962772+00', '2026-02-21 00:40:57.9628+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('78a411db-8169-4423-a668-71653b1e939a', 'josepholamide454@gmail.com', 'Joseoh Oluwakanmbi', '$2b$12$GUy676olW0.Wy9yZGK305.mkHkhNd8xhin4bgk/SBiHlBcPZaVMCm', true, '719C4YL75CA2', false, '2026-02-21 11:52:18.9465+00', '2026-02-21 11:52:18.946523+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9d4b8edf-8124-41f5-be7f-6253c794f695', 'mulweliteddy971@gmail.com', 'Teddy  Mulweli', '$2b$12$lMWOABCErlimuYTqlSUiB.Tfim0pEA1vqS1mCDdHelUkmG4BVOzIK', true, 'C1L9LCRVJKSB', false, '2026-02-21 19:15:35.603095+00', '2026-02-21 19:15:35.603136+00', NULL);
INSERT INTO public."user" VALUES ('226f60e5-4ad4-4db7-8e69-e3622e98bd16', 'armandbester234@gmail.com', 'Christoffel Bester', '$2b$12$1PoAipYLx8QnRKToyneBb.JKxgF0iGnTIiHCLLVMteLThHg.xxhKO', true, 'W03WUN4ZYQL2', false, '2026-02-21 21:20:54.12807+00', '2026-02-21 21:20:54.128087+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8577825a-2a1c-4e8f-a039-aaad5730e91c', 'Kalsajosef5@gmail.com', 'Saturday  Joseph', '$2b$12$5ljR2jzSD1.yelomMOjPp.xqeG9jg/gjIWPgEhkTgcVYhimZHZYgu', true, 'TRDFZBMO9L1G', false, '2026-02-22 07:37:14.67268+00', '2026-02-22 07:37:14.672707+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d927425f-6a30-466f-9507-960dd63dae38', 'dikeemmanuel4376@gmail.com', 'Dike Emmanuel', '$2b$12$IFkh/TyRS1mLoQuP1D1w9uCvSdMXFugegk4cZ.4ZgHBHiIe.2hnwW', true, 'GO6PBAR56EQS', false, '2026-02-22 11:23:08.795802+00', '2026-02-22 11:23:08.795826+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f6892d98-8dd3-48e0-a3b9-f7bcadd3205e', 'daniels.israel@outlook.com', 'Daniel Israel', '$2b$12$LbjBYkhq8mcN0W3iIh7.Fuyy8RWTa29GEY2quCBz7KcQvS3sGqHnq', true, 'TP6FMGBJEE7M', false, '2026-02-23 21:51:01.537899+00', '2026-02-23 21:51:01.537926+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('26df37e6-fbc2-456d-90ff-8b3bcb14c8ca', 'maarzimurodivich@gmail.com', 'Azizbek Mingboyev', '$2b$12$k.srYcjG5W9ZN4zUMA7MTucl0GHQ5nRJepzW4FgFTOp8gNaW2hqbm', true, 'QI6EL1WCL15Y', false, '2026-02-21 07:05:12.67732+00', '2026-02-21 07:05:12.677353+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f27518a2-8e5f-42c1-b143-552c92a6d513', 'd.fonginja@gmail.com', 'David Fonginja', '$2b$12$qE5Rt0d7QpSRvjrcqypHOuyhlZX2Tn32FYkYeF86l.TVwbI/DZdH.', true, 'ZDN5XIBAGM5T', false, '2026-02-21 11:56:38.363142+00', '2026-02-21 11:56:38.363171+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('64e9fb56-20a7-49bb-95d1-bceefa21bede', 'emmanuelbobok96@gmail.com', 'Emmanuel  Ufuoma', '$2b$12$FynafrXjieiRa1n1PkZL7OiluwAYPgvreDQ.bYBTmMcimfiaKf1R.', true, 'SMDS45GUSUQM', false, '2026-02-21 19:53:14.871979+00', '2026-02-21 19:53:14.872003+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9763a79d-9cba-4e2b-8ace-c49f380fb2fb', 'kingsleymichael3696@gmail.com', 'Kingsley  Michael', '$2b$12$sPgZuxy6yHDLwdPJWrEPs.n//Y9BnoxBmoLP83iLUns25MDv6pelm', true, '6XZ46NQI40AU', false, '2026-02-22 03:55:42.399498+00', '2026-02-22 03:55:42.399525+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('212d5c35-fe49-4e3e-92dc-6f63fdeaa3cb', 'johnanioke6@gmail.com', 'John Okwamba', '$2b$12$OGrSLSjfnYDO8dwv1c0HGu34PykJVkrTFnl8wFH7ykrMJaFuLaac.', true, 'RTEPQVI4QGAN', false, '2026-02-22 08:50:02.431291+00', '2026-02-22 08:50:02.431316+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b7f051ed-e70b-491a-bc9f-1abaf607ad94', 'dk8965353426@gmail.com', 'Deep chandra Ahirwar', '$2b$12$0UqYeX0VQlu8pJL1U4khju9oKfPU9Nk0.cF7A5KGS8KgScbKFbcDu', true, '6KK7CGXMCW5F', false, '2026-02-22 09:38:16.64926+00', '2026-02-22 09:38:16.649292+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e96000b1-7fb8-4a70-be4a-687559f05f36', 'bobosonya@gmail.com', 'Collins Joseph', '$2b$12$iLUhjDaXOXqZgsEVtqPi4.JAhwNwVAMjwgoJ.WtP0vctJcqDzuA4u', true, 'YP0V7LJ4Z7IB', false, '2026-02-22 13:50:57.355232+00', '2026-02-22 13:50:57.355258+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('448d6a7b-9a1d-41ae-b31a-9785ca4118bc', 'timothynkhoma51@gmail.com', 'Timothy Nkhoma', '$2b$12$bW6OH.55.gmMvvNthZ9Kjuz/mLS1ykg2uHIIJseHD3lCgVr6K0Lu.', true, 'Q1HPLH868IZY', false, '2026-02-22 17:01:03.19859+00', '2026-02-22 17:01:03.198616+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ef4a9a8a-4212-4424-990a-4bc605061a2d', 'ujohn3799@gmail.com', 'John Ugboaja', '$2b$12$Ehp7ckbUTj8oni7QYWGkz.y7L2m/MqtUjGT7jlVV3.OuM9vx1gtie', true, 'R5M20AXB92MW', false, '2026-02-22 22:33:18.629021+00', '2026-02-22 22:33:18.629041+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5ceea5fe-55dc-4684-83a5-1d56e8e0b02c', 'halimamontero@gmail.com', 'Halima Mhando', '$2b$12$2M5VrCbLzNRqOlsjz105ZeqF4O/vMB0c8xke88hH2ZA0RCGr3jUte', true, '5D5EZN307ZSB', false, '2026-02-23 04:50:30.683311+00', '2026-02-23 04:50:30.683348+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('43a5161b-0430-4fba-9004-710345a67232', 'chestnutwillbookyou@gmail.com', 'Steven Chestnut', '$2b$12$F1J1F83pziE9nlRhsRVXe.6WnzGsRFikzXSVRjPmzldAMb2xHuLy.', true, 'FLW4BH7ON481', false, '2026-02-23 14:54:36.224133+00', '2026-02-23 14:54:36.224166+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f268dbda-2533-4813-8c93-f2107a79c6dc', 'vwokeogbevire@gmail.com', 'Vwoke Ogbevire', '$2b$12$opLwTsxsXi19mbFCZlMqduTY5sQ8nTM6hR5Nts3OMCi87eh4.z1mu', true, 'WGI7SEMKYGLY', false, '2026-02-21 12:40:57.988353+00', '2026-02-21 12:40:57.988376+00', NULL);
INSERT INTO public."user" VALUES ('043571ae-50fe-46b8-a0db-2eee7a15da4d', 'bakiar754@gmail.com', 'Baki Abdul Rahmon  Boluwatife', '$2b$12$tSv5bc7h5gyXytVLoo7bTe8B2nY20UXhVPWhcsrjhQicw8nIiK2JO', true, '4RKXRSIKTHQ6', false, '2026-02-22 12:20:04.758231+00', '2026-02-22 12:20:04.758256+00', NULL);
INSERT INTO public."user" VALUES ('48fe238e-fa97-44e4-bf9c-53a961c3a4f4', 'luvuyomphephi@gmail.com', 'Luvuyo Mphephi', '$2b$12$7p3kI7HdcIiUphYr9QFDuuXe/9XM92m2JvI7EQx.rwcPkPAmopRWy', true, '3MEQBQAL7AJU', true, '2026-02-24 16:06:57.390804+00', '2026-02-24 16:06:57.390833+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f2bc0ff9-e440-410f-bcb2-df5a0822560b', 'platinumgamezone3d@gmail.com', 'Muhammad Kafeel', '$2b$12$iMaD3q3tZd0cnX/B14yg.ewwm7e3GrpOpgJeVfNofD2BxZvIZJHTK', true, 'VQSK5V3XFXOS', false, '2026-02-21 14:31:53.93322+00', '2026-02-21 14:31:53.933238+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3de814c4-fe05-4703-825f-14caf4a3070b', 'a89447731@gmail.com', 'Abbas Abbas', '$2b$12$83PS3zTSxUs.tEOURsfW5e.AQb8BqPcyUmv9vBfW/nJw6SaURBHVi', true, '6VR6TZ0EX1TF', false, '2026-02-21 15:58:07.580895+00', '2026-02-21 15:58:07.580923+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('cd30e3d0-57cf-4e32-8552-a20dd22c0282', 'divodalon@gmail.com', 'Divo Dalon', '$2b$12$vn89PsJ5mCa4iQ5EQ2JYW.rb/KAV.3CYJs7z2VYQWIqYvYkqlsg8K', true, '2CDPVBCH11H7', false, '2026-02-22 02:05:44.275306+00', '2026-02-22 02:05:44.275348+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4961ede2-30f3-49ec-92a7-8ae3fd38bf0d', 'bappe.fin@gmail.com', 'Bappe Debnath', '$2b$12$b9deAeh4NSyUdxt9TzjH2OcaxguNqUpfL6kLnKcQPPBPI4s6cAOAq', true, 'WZPH6H0MK31A', false, '2026-02-22 20:57:21.056564+00', '2026-02-22 20:57:21.056584+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('010dff34-c792-451e-9a2d-5dfd0c0d98ac', 'akinmoji24@gmail.com', 'Akintunde Morakinyo', '$2b$12$oTPpPcqE.RXkfme0ye9e2.wOeN7bfJzdKccTdtJijZaioXCyxvjNS', true, 'PH3GLULXTV6N', false, '2026-02-24 13:06:48.924324+00', '2026-02-24 13:06:48.924344+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('da5075ec-7b2a-47c4-9830-e51b806b4cd4', 'musaaminu44411@gmail.com', 'Musa Aminu', '$2b$12$TDxGzjLYpAyN.UAoFn4hNuwqh705Icp0uVVHMdkY2XlHGl2Lb9JM2', true, 'JUSRVM8N6YCY', false, '2026-02-22 10:31:13.091347+00', '2026-02-22 10:31:13.091375+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f975f08e-1d63-4c65-a672-cf04f7806d69', 'melinhtravel@gmail.com', 'HUY DUNG HOANG', '$2b$12$t/zpx/f3YdH5JJRz54s5LeRkKSOav.wtk7/YF9Acm2Ejas/7P47La', true, 'PJGS3PS8IKW8', false, '2026-02-22 14:35:27.73435+00', '2026-02-22 14:35:27.734375+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('22ffe89c-8ab8-4241-bbad-691f61199ee6', 'MARUPINGEDWIN156@gmail.com', 'Maruping Edwin', '$2b$12$RY1IoOIJjUN18/uU0fWQCumQHiw/qmiHX/9udTn3dhu9bxoCzrJkG', true, 'CIOGGGQ3U0MN', false, '2026-02-22 21:35:07.307084+00', '2026-02-22 21:35:07.307107+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('19dd8dd5-e164-45a2-9cdd-1dcf76da8c7b', 'Kingsfordopoku64@gmail.com', 'KINGSFORD  OPOKU', '$2b$12$wWOIJN2WwSKSe1Q1b97lHefxSOB/XZ0uRC1T8eKuqWTytotHlK9Fq', true, '1UUA69S6TR3O', false, '2026-02-22 22:22:58.196544+00', '2026-02-22 22:22:58.196561+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0a8e80c9-3015-466a-94ee-ec3164ac9bf7', 'wandea66@gmail.com', 'Ade Abeg', '$2b$12$qVqNeu29Fv1r4FVs9UZGxOnoDHddFiqYpfJpETklRqEzb8NP6hafy', true, '5QN740U6VPNH', false, '2026-02-23 05:31:10.541838+00', '2026-02-23 05:31:10.541866+00', NULL);
INSERT INTO public."user" VALUES ('cf0297ca-1c84-4c48-8688-7dd37928a416', 'nghihalwaselma@gmail.com', 'Selma Nghihalwa', '$2b$12$g6lo489xSNt09UEQWmNbYOKhRYBj5xb1DdJzfFqcO./Ld4jZOlHGS', true, 'XQ45X86RHNQV', false, '2026-02-23 16:26:26.10503+00', '2026-02-23 16:26:26.105052+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f98a9851-250e-4684-a6d6-405080cd18ef', 'frittoxreb@gmail.com', 'Frittox Reb', '$2b$12$mm58mkxprTqRY8JH0zc6Deh4ZyCVokx9Y/oJHt82mTohfltF07URS', true, 'FQ8P5NF7KXG4', false, '2026-02-23 20:46:30.432507+00', '2026-02-23 20:46:30.432527+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4308fd57-95da-4a9d-8c61-4c2e64ddc5d3', 'klmasango@gmail.com', 'KUDZANAI MASANGO', '$2b$12$PVrS5EKpxZZYw2ZGoTix5Osa/frih5WpCf78./vwO6cFCzqMN5A8O', true, 'LH0K5WE5HY2O', false, '2026-02-24 07:44:59.736895+00', '2026-02-24 07:44:59.736913+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('59f24111-22f9-419c-96b9-0875e13a60aa', 'arabem607@gmail.com', 'Mohamed arab', '$2b$12$6Rl8adjYjLRc9BSq4ltHVeTkDN4IeXzFX9MCn5ey34hH/xrzIz/xK', true, 'VWABGIG9AA0Y', false, '2026-02-24 22:23:12.227803+00', '2026-02-24 22:23:12.227839+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('eb4e2f1b-2fc4-4374-a48d-acab9432031b', 'kabundafrank@gmail.com', 'Frank Kabunda', '$2b$12$BQ61EfyNYMvOV7dv11CELO3jgMEA6roqVGqxIyFDd9CFt1EPTVVNi', true, 'GSBI6HVYY4MU', false, '2026-02-25 10:45:09.070192+00', '2026-02-25 10:45:09.070224+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('de705f43-b49a-4e86-bee5-363cbd4cfc06', 'tafeman04@gmail.com', 'Tafese Hordofa', '$2b$12$uRb4zTeZVex7JCIEGGgxQO9hidoCF9qFZ4WgCC2BOr5SR7NDp6LNK', true, '96L8LXVX5KM3', false, '2026-02-28 13:51:38.21217+00', '2026-02-28 13:51:38.212201+00', NULL);
INSERT INTO public."user" VALUES ('ddef72af-d01a-4d14-95cd-f33a800ef598', 'mooraal74@gmail.com', 'Abdi Aziz', '$2b$12$5bFjS8RgfNRd6E7pyVYO4eHlIG8blPMjk3V2PiwNcLoTecGVvzjCS', true, '5MXWLU1ZHA9V', false, '2026-03-01 00:51:40.239378+00', '2026-03-01 00:51:40.239415+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('26576c0c-bd97-4ef0-9616-3e06ce3ee320', 'gospelc403@gmail.com', 'Chukwuemeka  Gospel', '$2b$12$3aO3vPIBArOcklZjTbrAHuXrhKQ8r9KNHzwGylIHJsnrmXHInu8yu', true, '360TPYJNQULL', false, '2026-03-01 01:39:05.842538+00', '2026-03-01 01:39:05.842563+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3133f7bd-194e-4b0c-948c-b07e0ff3f3ad', 'nehalkamli143@gmail.com', 'Nehal Kamli', '$2b$12$/Mt5zsG6juDamsi7UFpG7ew8i13cjUTinXExb56jdNsBh/LBZY6d2', true, 'WJCPLPKIZL32', false, '2026-03-01 11:22:48.585147+00', '2026-03-01 11:22:48.585169+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5c6d52bc-b62c-4b21-96b8-0f1d4a51ef15', 'nnamdivitalis56@gmail.com', 'Vitalis Nnamdi', '$2b$12$keK3N5KDN7002hmvNumG5uMNQY4jFq36Z0gKwRIUMeIEji4FYMBR2', true, 'LZOE6MSJA29I', false, '2026-03-01 18:41:08.074882+00', '2026-03-01 18:41:08.074905+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('318411d7-7ee3-42c1-88ed-56a4f020eb6d', 'busydog1914@gmail.com', 'Williams C Anyaogu', '$2b$12$D9kCwgMktZJS1Z9N2E2lFuEH4cJcz6rNzzYRbRs9c7ARJvWErpLji', true, 'YHAKI19QM473', false, '2026-03-01 23:37:45.818645+00', '2026-03-01 23:37:45.818668+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4fc89a9d-f1f1-449c-9c42-9c72e0976a88', 'tradingoff2024@gmail.com', 'Alberto Lunar Carvalho', '$2b$12$oaB3cw1IZRYAy27SbsLRoOqUnVGzYLEPSIUeFxQz0EIOTUiAvypCS', true, 'XD28CIPSCT58', false, '2026-03-02 09:02:40.540353+00', '2026-03-02 09:02:40.540385+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('02ab2779-1870-448c-b466-c5480898e083', 'jgkkrish1998@gmail.com', 'Jai  Gokul Krishna R', '$2b$12$0PlpL54WMcPPZCAgX2lo..jvd0FbskkUoaT7sMmyCM1Gkhb9wwYum', true, 'Y2FIV7HHFSS0', false, '2026-03-02 10:53:28.912004+00', '2026-03-02 10:53:28.912031+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('65f02763-3da4-4e19-8690-52e44a8b0442', 'yungemzy8@gmail.com', 'EMMANUEL CHIBUEZE', '$2b$12$vhi1ZAS4la7Vlgc/hsoikOSz2TP4AmqcZ5c/MdyFuQk9E2tShsQy.', true, '9B516T0GDTSF', false, '2026-03-02 14:35:19.099267+00', '2026-03-02 14:35:19.099299+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5c48ed20-6d2e-4f55-81e1-5fc8e6b8ce53', 'domingoszimba56@gmail.com', 'Domingos Zimba', '$2b$12$xkRPWdU/2prz4xpv0uX95O0FgS/VQJlqZmaYrHvt5.IFVQkR5LfJi', true, '6HR7ONKKT0J0', false, '2026-03-02 19:44:11.780804+00', '2026-03-02 19:44:11.780832+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6eaeb2a8-1907-4da8-93b8-bb0eeaad1440', 'ukaegbudecency@gmail.com', 'Ukaegbu  Decency', '$2b$12$lVHQ96MCweH6tgwC8K4Dxe8U5mc5EZmwnvlwrsKjVWnJl9k9mTYoW', true, 'MAV8MJFCBKFH', false, '2026-03-02 21:49:12.032861+00', '2026-03-02 21:49:12.032889+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('226f78d0-2a1d-4f22-9573-fb889460e517', 'mkapupa6@gmail.com', 'Martin Ben  Kapupa', '$2b$12$MNWzGQfAKoQBnu722Wge.uSCVeW3MZrdpEphjY1Rd4QDaaJb5O0V2', true, 'LK2G6GFFXINP', false, '2026-03-03 05:15:16.002654+00', '2026-03-03 05:15:16.002695+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f1ce22a0-3e62-47dc-9a86-e62403688d27', 'thais.serrano.p@gmail.com', 'Thais Serrano', '$2b$12$/9bW3ZRcF.Ax9bGoLmj.4ejNid04S6jC6ldp0UFmlfENCqxlu86Ki', true, '06R67706WH86', false, '2026-03-03 09:41:51.936912+00', '2026-03-03 09:41:51.93693+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('42dc4d05-117c-4713-90c9-316bc4840153', 'simplicemlankoui@gmail.com', 'Simplice Yao Mlankoui', '$2b$12$iIUw.KYic9BXiRxbOPJmoeOqdfuc8D53212S3FPCscwCWMbXnHc0.', true, 'T5DMUW1R8MGZ', false, '2026-03-05 22:17:08.5932+00', '2026-03-05 22:17:08.593231+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1c75a9f0-68b5-47fc-9c9e-f57b2376d32a', 'johnywesh254@gmail.com', 'john waweru', '$2b$12$rSC4GraloRJfFKuHrfQVBuYiObtkFd9QLx7lAiODw/wvpw4QFDH0a', true, '8KAAFWEUW0JH', false, '2026-03-06 08:32:31.581917+00', '2026-03-06 08:32:31.581943+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fe0aaf86-8a39-48bf-b183-323a21cb05e1', 'salavat@ya.ru', '✨85.000 Lira Seni Bekliyor - Tek Tıkla Al! https://bit.ly/4gazShB ✨ Go', '$2b$12$5/iqCJElHP7p3ZFA.qxQX.xiOi4SOhs2n.idMrFJ18Uf3iCKbWg7.', true, 'R1AV6MJOCXK5', false, '2026-03-06 10:47:51.447134+00', '2026-03-06 10:47:51.447158+00', NULL);
INSERT INTO public."user" VALUES ('8b4f880e-3e25-4510-bbc2-c6ea5a50ac77', 'tafeman0404@gmail.com', 'Tafese Hordofa', '$2b$12$ztqw9f/T0uSQm4gSXbH5QOu/ZEoekb8ckDWZ0k7MW8mN.rhfGVbRG', true, 'H3FI6VJXG2W1', false, '2026-03-08 10:58:02.574822+00', '2026-03-08 10:58:02.574849+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('86050011-bfee-4b62-8b91-415ff1275901', 'svh3933@gmail.com', 'Shaun van Heerden', '$2b$12$m32OIyekB8.Z0cSttRJXheKyHw.vOAAso5oh.P9GRsfK06gKwFzaa', true, '9Z7ZAE542DJA', false, '2026-03-08 16:26:27.224172+00', '2026-03-08 16:26:27.2242+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0f8ee8d3-6aaf-4ad4-8a08-57d912d9ad63', 'mrkisolo@gmail.com', 'Kevin Kisolo', '$2b$12$eTe9v88i87xBkTTC1PEpW.2t2Q88fKBD8oAPNdZqKwsbR5Bdt.ZH.', true, 'X2UA60P43JFO', false, '2026-03-08 17:10:58.342313+00', '2026-03-08 17:10:58.34234+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d49b6cca-5407-4041-bfc5-98c04a082d36', 'mcmedprohealth@gmail.com', 'Covenant Mugiriki', '$2b$12$SQZdg9GutSDWa8ee8ra9N.q.8MUGF/a1f6NG0QzppKtaCxKJt.Ztm', true, '760J7S6BP318', false, '2026-03-08 23:30:57.361426+00', '2026-03-08 23:30:57.361446+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2afd8ecb-a5a5-4636-bb29-0f2f3b98bc21', 'seyidavid606@gmail.com', 'Seyi David', '$2b$12$fxaCo0THvu4.p5AW0C.a8Op89MWLkKy0M1RDeju6DBMI/RJATIu9K', true, 'W5Z6NOQXBQ98', false, '2026-03-09 07:21:05.312393+00', '2026-03-09 07:21:05.312413+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ae6130c7-1f7d-46ae-b45f-c76d424de35a', 'johnnsikak177@gmail.com', 'NSIKAK JOHN', '$2b$12$3CjTmS/oCVlFa65HV7pq4OVRh4o7ok5v9476pdko6vkPJH3gTUuz6', true, 'HSBM3RTI1R8S', false, '2026-03-09 07:49:30.180616+00', '2026-03-09 07:49:30.180643+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('84ed6765-4c60-4fc6-af56-d292a807faf1', 'mtrevinoz1@yahoo.com', 'Modesto  Trevino', '$2b$12$xs49yU/BP/YfDkQQqEc/OOFjcZ31jiBQOrabhhT9GOePMWtN7cMFy', true, '0HS5RUL2HCOQ', true, '2026-03-10 03:41:19.591806+00', '2026-03-10 03:41:19.59186+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bc46ed1f-0bec-4460-9296-ed8c05b99c8f', 'quiechantell@yahoo.com', 'Laqushonique  Daniels', '$2b$12$PmIb2GdnaW5HcRowplu7HeuJu19Ocp6CkO76XTJsTXMppGox6nIJy', true, '9O0PXOXKCBXL', false, '2026-03-10 12:32:42.919007+00', '2026-03-10 12:32:42.919034+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('35ef0df4-da67-418b-ae95-bbb2cd860478', 'pandurangpatil002@gmail.com', 'PANDURANG PATIL', '$2b$12$i6xlh1e1nvuF3fuOIZTq/elMcJpa70S7siPAMAfSpUemt8REnWLzW', true, '2Q6N5S5IMUYH', false, '2026-03-10 18:45:21.253828+00', '2026-03-10 18:45:21.253856+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9263268a-b2a5-4179-9d8d-8ba3974d53dc', 'mbcosjossif2001@yahoo.com', 'COSMAS IFEANYI MBEREKPE', '$2b$12$pix6qzz8AtkfDyRff1iRm.TlY3Sfm1.j9op1GMhe77VaIhLRHwaLy', true, 'BAYULRSN166U', false, '2026-03-10 18:53:11.207922+00', '2026-03-10 18:53:11.207949+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('017ab0e1-aa46-4445-b515-f6393d99ea33', 'teresanna037@gmail.com', 'Theresa Namuyanja', '$2b$12$tR9ntZu6ijTMd7Ii/6IhdOfqP5WxWp4bcOulDtCm0lokaV.Gz50a6', true, 'QFISOHUMSN36', false, '2026-03-10 19:13:04.262424+00', '2026-03-10 19:13:04.262475+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('eb03ddf6-4ae3-4d03-a905-809b2a1de867', 'mujtabs001175@gmail.com', 'Syed  Mujtaba', '$2b$12$B9yO1Xjgjuj.6/5lFbihJui4yCoIEHiNwgF6c9Q31KGIfSjDEYBC2', true, 'L0VFASCGU1TZ', false, '2026-03-10 19:16:37.698349+00', '2026-03-10 19:16:37.698376+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('94aa484b-e1ec-4834-b8a6-eea17bb58ad4', 'akposdafe7@gmail.com', 'Dafe Akpos', '$2b$12$5fyU0UsTh4bFxy0oRcqHv.NcvFFG4TVcjTeeOizKWH3xRHC6Djwqy', true, '8IA50X6N19FX', false, '2026-03-10 20:33:33.909464+00', '2026-03-10 20:33:33.909487+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0bd1c239-31f4-4271-9624-9fc9c164924d', 'okaforcharles403@gmail.com', 'Okafor Emmanuel', '$2b$12$898oLx2vOnmxBGBMMUXeUuVBRiSfG.7kF8OeIerY8vyWJCobOqolC', true, 'KK6LSY3FZEGX', false, '2026-03-10 20:51:30.733794+00', '2026-03-10 20:51:30.733822+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c442cf6c-2e6b-4c8c-929a-bce9c55b8876', 'adonsisenarichard@gmail.com', 'ADONSI  SENA RICHARD', '$2b$12$0m37oPZ.dZUDHFZVi5xwe.VXoLrbOuM8rUTBfAMuNqDQels1aYZd6', true, 'SBLROMIO4YPB', false, '2026-03-10 21:10:27.997077+00', '2026-03-10 21:10:27.997095+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('eca427a2-ee66-4345-9a9f-04a21323442c', 'saif26664@gmail.com', 'SAIF ALI', '$2b$12$.XVYcI9vSBOlHf3qhw3dgOfXkSncLeI.z2wExIX8UE9MpbBroBsOG', true, '3L2HU1YFE4KH', false, '2026-03-10 22:39:05.876536+00', '2026-03-10 22:39:05.876562+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('384a5b79-860c-4b60-a85b-dbec9b430e95', 'davidameh@gmail.com', 'David Ameh', '$2b$12$G5ZAIg4FaM.KxPRm7U5ThOGvf7/tJDtL/sc9SE6ZCxdGvTifphP3K', true, '0HJCXPFGC4F8', false, '2026-03-11 03:46:31.729627+00', '2026-03-11 03:46:31.729691+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5dd738a6-432b-433f-b7f3-31e710b1c266', 'Fatbertahiri@gmail.com', 'Fatber Tahiri', '$2b$12$3rHn9GAoHFeTjrL1AgahmO2xjFkV8WPhaNtc7IhkuYNVoFQau4sIi', true, 'IIELDRTC874L', false, '2026-03-11 10:33:36.305379+00', '2026-03-11 10:33:36.305416+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1d2a31b8-ed68-4977-98d3-de800ce960a7', 'bochelletsanacurtis@gmail.com', 'Curtis  Bochelletsana', '$2b$12$UA2mEIOrUw9o6.5bn7VjiObKhW2UfexTnCPytf6j1ah56yXETksv.', true, '6GT74LHIFTNO', false, '2026-03-14 15:13:11.638742+00', '2026-03-14 15:13:11.638768+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d6558787-0707-4976-8598-1ca28f93cf40', 'BILALZWORLD69@gmail.com', 'BILAL ASGHAR', '$2b$12$Whb2rnUeUf.ltmtEzHznJehTO.z.fn5qSqaK1d.hGw.9/t2Cb6tV.', true, '3I3QERBC5JOL', false, '2026-03-11 00:26:00.003991+00', '2026-03-11 00:26:00.004015+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('65a33238-6599-445b-b97f-36992ba0ce80', 'haroldernest22@gmail.com', 'Harold Lawuo', '$2b$12$N43EUYZYJ/fnZ.hjFF32h.W.BBss3i1nhvpGPRtEpWdn.YYlrsTei', true, 'WV4KC88NNXSS', false, '2026-03-12 11:08:37.785568+00', '2026-03-12 11:08:37.785588+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5760b083-0847-4acb-9b9c-fff78dfc0e4d', 'hassandauda354@gmail.com', 'Hassan Dauda', '$2b$12$QC6vFOEiI4JmBUolpLZzsug78aEx7JRwbUWfd/xS6wntj4pJVce9O', true, '4BW3PQYVQE6G', false, '2026-03-12 12:04:20.065819+00', '2026-03-12 12:04:20.065853+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('40bbc698-43bf-47a0-9ca7-3a86f48069b0', 'ashleysuccess979@gmail.com', 'Chidera Victor', '$2b$12$4IlmJ55MSBOz3nPHvQovzu46f01VYTbVsSUj/dvBeq5CXcDCCEXjO', true, 'A63A5B6UC3OT', false, '2026-03-13 23:07:46.706092+00', '2026-03-13 23:07:46.70611+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c45b3d97-990a-4065-9070-6f60ac8a329f', 'columnajomari2018@gmail.com', 'JOMARI COLUMNA', '$2b$12$22Rx8QmjAcMTrq9NRsSNz.XYYiphNW3cqngv39KXM0t2Ne9We/WQG', true, '835T15LIVMUF', false, '2026-03-16 22:53:32.790312+00', '2026-03-16 22:53:32.790344+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b511ef20-a162-48c9-af6c-56ebb574a582', 'ronganoel@gmail.com', 'Noel Ronga', '$2b$12$8yd9hYzPvY2tc0lNreXk5.qo2jhelZGQvw8o4YE5yj84x0wL0Jx.m', true, '61DG1RQE0ZK6', false, '2026-03-17 03:00:58.004491+00', '2026-03-17 03:00:58.004508+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8a1f5a38-0635-4d85-8aa8-d18c0ef6ae41', 'boatengprince112@gmail.com', 'Prince  Boateng', '$2b$12$6jjXuQPwwwnvWG2cLO1tAu9GOLXeq98lqM.kk4zjre11sPOPC7Ecq', true, 'EZL8RSK87JEL', false, '2026-03-11 06:12:58.9351+00', '2026-03-11 06:12:58.93513+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('dd430a39-7490-4534-821d-64d1c932eb77', 'joshuawureka@gmail.com', 'Sike Wureka Sati', '$2b$12$WCvIb/IKqf9xxM4pJjV8qOj7W..ZjO.7GX2awshRMDmbDTwlCL8TG', true, 'CM40LVOKLZF3', false, '2026-03-11 15:45:21.351938+00', '2026-03-11 15:45:21.351966+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('03222355-3126-4f28-8de7-50c06f10a3be', 'walgens@hoperageous.com', 'Walgens Rely', '$2b$12$aLmPaDyQshD7wdES.JWJ0OTQ4yLCm2s4ZD3HQpX/qzZ5RF3kUMOAi', true, 'DMSSZFKUHRF6', false, '2026-03-11 16:03:00.608259+00', '2026-03-11 16:03:00.608285+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('369f109b-c625-413b-9cec-c1e4db582177', 'xettriarjun12@gmail.com', 'Arjun Khadka', '$2b$12$Po9kMR7i725kAWvxDfgjz.VxjIJ4zHmS69pyfK2lD9nm5aIfrbxA2', true, '3TYIOPIT32F5', false, '2026-03-11 16:23:26.998123+00', '2026-03-11 16:23:26.998141+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7646c987-3d7c-482b-bd6b-c34b10076eec', 'nakuwezajustine@gmail.com', 'Justine Nakuweza', '$2b$12$.ZOnBT27MSuDR0IT1ZfoQ.ItLxGD0jtXQXtrc89hN1Bgx4227cWsa', true, 'JG25V68LEGNG', false, '2026-03-11 16:34:40.426724+00', '2026-03-11 16:34:40.426749+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4e2de913-cda8-487b-b02b-ae2e03092c53', 'nnidan98@gmail.com', 'Navrattan Nidan', '$2b$12$W5vihARvDlSKEWJTAv.RMO2M6Vq3Md/HMWrYaQc2Q2ceIufptZbVC', true, '4493C6D7I3BE', false, '2026-03-11 22:03:12.819406+00', '2026-03-11 22:03:12.819424+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2321104a-adf5-477f-96b5-3435e055c3f1', 'dadaraphaelmiracle@gmail.com', 'Raphael Dada', '$2b$12$0CvapcuPt7QAcelXLTZU8um64wx2feIXLkakDlKogTCI3ltGiNhQy', true, 'UTLGLBOLK2C5', false, '2026-03-12 00:01:56.094642+00', '2026-03-12 00:01:56.094666+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('01cca090-fa9a-4943-9c8f-4fc77939d997', 'musthafaking098@gmail.com', 'Musthafa  Shaik', '$2b$12$NBmk8dzWkajfOOmzijOm/.o1c3eXMamrBtpenJa1eWuXtxYXMzFWa', true, 'EYK24YPJAB47', false, '2026-03-12 07:45:39.605754+00', '2026-03-12 07:45:39.605783+00', NULL);
INSERT INTO public."user" VALUES ('a0b563f0-5750-4ce5-af22-4888d51fb8f8', 'davidchikasunday22@gmail.com', 'David Chika', '$2b$12$VRn3.eCl6Q8qj8/1YfFS1uqk9aCz8grihuFitEUOrzWCaaV2CPihG', true, 'E14KIGORLBEL', false, '2026-03-13 14:35:00.552722+00', '2026-03-13 14:35:00.552747+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1d3db3ff-d369-4b9f-a066-df11f4fe1bcd', 'bitalisbageni@gmail.com', 'Vitalis Bageni', '$2b$12$ppP9zAxR3Ke4O7QohHKrde1SbijoRpWkBT/r3yDL/5J5DB3MU2ur2', true, 'JMIAZ4JWRTA8', false, '2026-03-13 15:37:49.392757+00', '2026-03-13 15:37:49.392782+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5e86353a-2289-4cc9-b4aa-630226e9fc31', 'vinodsony3546@gmail.com', 'Vinod Kumar  Soni', '$2b$12$69wDLBxV4W13Fpq70U4mxuRve7TdR7y/4iCJ7nijL7Gali1nim5E6', true, 'RUGTPXSG36Z4', false, '2026-03-16 14:23:58.876088+00', '2026-03-16 14:23:58.876114+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('47f74283-126c-4e98-b3a1-3b559e560dd4', 'gitwitayeho@gmail.com', 'Gentil Itwitayeho', '$2b$12$Q6zs22TEuDmG6JM6bBxEzeEzhoKTgKUeZYmGPh1QtOIevz6.pJF4G', true, 'MB9T8SZLZPWQ', false, '2026-03-16 14:47:22.785686+00', '2026-03-16 14:47:22.785714+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('524a2e3e-29c8-4f8d-aa90-ff001752dfdb', 'coolsavvo@gmail.com', 'SIMON GATKOI', '$2b$12$LZoueRcdi732npCEGO53Wud9vgbJQ3CZcljtG4Ps9dctV4xGIBFgS', true, 'BLFIPQ81UU15', false, '2026-03-11 07:23:07.649453+00', '2026-03-11 07:23:07.649476+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('530b20b9-4c29-43c1-9706-c9aa15b55e03', 'advanceglobalco@gmail.com', 'samson Adeniji', '$2b$12$ek9R5g7NQZdUH/88tIZssOND/ONnSfejrW9o9sv.45JmUYa3OoPSK', true, 'VF3BB0W178TY', false, '2026-03-11 08:22:20.786878+00', '2026-03-11 08:22:20.786906+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5c83523b-174d-4afa-8176-ddde5a0420bc', 'enja_1d@yahoo.com', 'Hkurelbaatar Enkhjargal', '$2b$12$5t.k/p9CBPEALxq7Yo1HDuTJPWIjWLX6ZJZlunx18KEYgWUX1Rjui', true, 'DSKVDI9GM7TH', false, '2026-03-11 10:05:49.794886+00', '2026-03-11 10:05:49.794914+00', '17061');
INSERT INTO public."user" VALUES ('5004b617-9fa7-4a94-b7b0-9b0fad7250fd', 'amineg992@gmail.com', 'Abdou Gh', '$2b$12$m0Z0cmvCR3vjuEvx28e2G./28aJsHLmG2nSovX7Vq3.JS5KZ5T0pu', true, '2VTAMFH6VA25', false, '2026-03-11 13:52:11.071669+00', '2026-03-11 13:52:11.071706+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5b96748f-9f97-4938-a099-41d2352917cd', 'zinzimkhwanazi00@gmail.com', 'Zinzi  Mkwanazk', '$2b$12$BAADJRdWzvIcLCCO3g.Qze4gmfd6niH1VoWBeOFYkTldNqwZPrkg6', true, 'WJTDGDR01PPT', false, '2026-03-11 18:20:37.293105+00', '2026-03-11 18:20:37.293145+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6502ddc5-2615-42ae-a339-5d4f7507873f', 'chideraeze327@gmail.com', 'Eze Chidera', '$2b$12$nnqSCXRyF9OSVzmeYrYI7.6CgADDzEHxT.yJ.zIqGWvzaQC0Sl8W6', true, 'IFED0VOZPOEN', false, '2026-03-11 18:25:38.844749+00', '2026-03-11 18:25:38.844802+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('154ff85d-d99a-4f46-b67e-dc7ffafc2000', 'yuzzomo58@gmail.com', 'Yusuph Mohamed', '$2b$12$tEfJ4n5nES6UXAdJo5aPqugrY1uQpzc05OpliXoX4JROAXHU7fuXi', true, 'S8H4M8JDQ2VM', false, '2026-03-13 10:16:24.98676+00', '2026-03-13 10:16:24.986786+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d96c4a28-4b35-434e-a380-c0953af478cb', 'getahunababu@gmail.com', 'Getahun Ababu', '$2b$12$UiwLewKySnlEPYAbUMe7aejsDgXjyGDzsNmmm3JAasjrPQrDTiAFq', true, 'Z5SC84KAHCQ8', false, '2026-03-15 15:22:47.390003+00', '2026-03-15 15:22:47.390032+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('eef719ec-9962-4c05-929c-83eaaaf2282b', 'eleuteriomafundisse90@gmail.com', 'Eleuterio Mafundisse', '$2b$12$8clg/xAeoIf5mOSoeHkkJeoG5BjgB.aBM66cTpy.h4XOgpGYlR32u', true, 'J38VEJOE4L3T', false, '2026-03-16 19:15:46.657758+00', '2026-03-16 19:15:46.657779+00', NULL);
INSERT INTO public."user" VALUES ('2f2354b0-93e9-425c-bcf8-27e6e6149e0d', 'imranijazkhan5@gmail.com', 'Imran Ejaz', '$2b$12$/ePe1.vlSK3QarWDr99SceDNfUaCqLy4BLZBjhoLcKqAHTwtZFuw2', true, 'QU24B2R9BZ0M', false, '2026-03-17 02:08:52.567724+00', '2026-03-17 02:08:52.567747+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d5d5d2ee-b299-42ab-8c75-af7bc63185a3', 'Chimerenkajudah@gmail.com', 'Chimerenka Samuel', '$2b$12$Rz/6naaZaLDcyRbiW63Hu.S8FGNO5PvHgFLmXnYn2gwoV.5jym1H6', true, 'DVG7X10KSHAY', false, '2026-03-11 16:40:36.727971+00', '2026-03-11 16:40:36.727997+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5fcc1af8-8ab2-4e36-8338-7766a94bdce9', 'jevilis550@gmail.com', 'Jesse Murphy', '$2b$12$A0Bf1inB3ZL/.hWC6.iOiOyk/WzOMCZ0lkTLfmNZKnxW1tW/vjaLW', true, 'IBF9Z4WNWV76', false, '2026-03-11 17:04:10.19967+00', '2026-03-11 17:04:10.199694+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('11cc82c5-06fb-4d82-bff4-d583318ec35b', 'Olivenaomi5606@gmail.com', 'Mukete Olive Naomi', '$2b$12$BhPp3FplWpxg9j2OcyiaPer.u.QybdhMRa4fvV7C67eDTAf2vPqzG', true, 'ZXZU7YX40YDZ', false, '2026-03-11 21:13:13.022937+00', '2026-03-11 21:13:13.022962+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c862f3c4-bca0-4f89-a7c6-21d2a3337314', 'prahsanth.k@gmail.com', 'Prahsanth Mohan', '$2b$12$fLkWLWzJ./bTXYzIhLNkE.hfTZbyDszjLSSWFceU8tBXJiqkGgAIW', true, 'VKA1GO2DXPO4', false, '2026-03-12 02:30:44.200504+00', '2026-03-12 02:30:44.20053+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1f5b8876-054d-4bad-9067-9a97b82b8317', 'thapelooscarmichael@gmail.com', 'Gotwemang T R Michael', '$2b$12$q8Hs24Ya.aqurOyAAdfVduAb9Fb6noBKalZgnNBlOVwOFrbl4Er.u', true, '4AFVJE54LOUC', false, '2026-03-12 19:00:22.147155+00', '2026-03-12 19:00:22.147181+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4d7c026e-b5f9-4119-8453-5fe7c6f83e94', 'olukokunisrael9@gmail.com', 'Olukokun Israel', '$2b$12$SCIN.I3gMRZLOKUPo1r5OuyZGWRsfK.VL9NndCCp3Ziw9qETXu8ny', true, 'QPTUQLLBVJSC', false, '2026-03-12 20:39:38.798022+00', '2026-03-12 20:39:38.798074+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b48a0dc7-e912-488f-96cd-e18171be793e', 'ercilioalfredo9@gmail.com', 'Ercilio Antonio Alfredo', '$2b$12$YuIT1JUok6EBZsYIZrCSTuV3TJocPQSU5SnxAV.85lGeZSzV4h/yS', true, 'FY17I1JH6XVF', false, '2026-03-12 21:42:26.395682+00', '2026-03-12 21:42:26.395703+00', NULL);
INSERT INTO public."user" VALUES ('c7e9c561-7e40-4129-9d72-6dd5b780dd3d', 'corey21orona@gmail.com', 'Corey Orona', '$2b$12$zMnlwKIJiH64h7aIjrxpfO5wtxIiSfWOKZb9KBO/uXOTxwd0kdgQO', true, 'QXK8PK5MIZE4', false, '2026-03-12 23:18:22.10336+00', '2026-03-12 23:18:22.103379+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('43bedf6f-d5dc-4479-90d5-11fc75648af6', 'orijigabriel175@gmail.com', 'gabriel oriji', '$2b$12$58ucvLtKVy6qaIElyI5V.OGigat6hWEcVkAN7DRiSh/vZv4z.7Qd2', true, '2WJ8IUM7TCVY', false, '2026-03-13 11:46:58.645058+00', '2026-03-13 11:46:58.645076+00', NULL);
INSERT INTO public."user" VALUES ('6ee08be0-45b7-417e-a641-a723b2c6be9f', 'danielpelumi944@gmail.com', 'Ogungbemiro  Daniel Pelumi', '$2b$12$XjaILOmR2wNiNdLOyXAoFOWzioGX3L3WVbvyIQ0.30woa5EyFcXJS', true, 'BCOT56GF53UC', false, '2026-03-13 13:41:23.751983+00', '2026-03-13 13:41:23.752016+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('37f9f0f7-4960-451b-a8d0-5fc1a689e889', 'kitoshbuckgum@gmail.com', 'victor  Kitonga', '$2b$12$RysJERya7dAw9KSivW2Q8.dXKNEUGEG.GJsziBfdloAcMw7ghb2ou', true, 'S8TWYZLMEII5', false, '2026-03-16 20:38:32.02061+00', '2026-03-16 20:38:32.020632+00', NULL);
INSERT INTO public."user" VALUES ('d5cb7ad4-f34c-44bf-b2a6-bcef0b3ca3fd', 'felicekpor@gmail.com', 'Felix  Ekpor', '$2b$12$Wk4qqMZrolVOWxKAKCp8u.uF2O8/N/OUdiND0529JscW0ySgYAqhS', true, 'VK2QONNJKYEY', false, '2026-03-16 21:21:19.58066+00', '2026-03-16 21:21:19.580683+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8bd3cb80-c1a5-45fd-98a0-ae62f40773f4', 'itsjuliannotderek17@gmail.com', 'Derek Nwabineli', '$2b$12$x5MXTh4duMUsevWc4NY48.bIQbBlXZGI1gUYGjxtUvDHpfzX29iSq', true, 'AHOMJ0FJOG4W', false, '2026-03-16 23:42:25.179371+00', '2026-03-16 23:42:25.179389+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2e792e37-2d96-4764-8e62-ca1d1c57aa9f', 'wesamalashwal18@gmail.com', 'Tamer Alashwal', '$2b$12$XpIWAeWj4x1.eHEG7pByTen1S8/lzNWEwtb3Epbsae/WNS0iS6IsO', true, 'OMA1SALQ906C', false, '2026-03-17 03:19:16.186426+00', '2026-03-17 03:19:16.186444+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('83bd2441-22c3-47a9-b585-855be17d5b13', 'abrahambrahimkiazolu5@gmail.com', 'Abraham  Kiazolu', '$2b$12$E36TCeXnXajm1UuQhOW8Nexui1va6WgNijtbU68DQ/PwpruEk7XiK', true, '621QJCNXN4SC', false, '2026-03-17 06:40:58.931672+00', '2026-03-17 06:40:58.931704+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('694cc8d5-5ff9-4e24-9aa4-cbb91935cf08', 'godiankeez01@gmail.com', 'GODIAN KESSY', '$2b$12$dG5IpZRmD3QBALoYpxa.3uGmvdw0fuKKk3aDoP3yhRiGPcxaNpxf2', true, '80DH0LP6SW45', false, '2026-03-17 07:20:03.697597+00', '2026-03-17 07:20:03.697647+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9f7aefc6-a72a-4390-b2ce-1cbab1e697ea', '2363339560@qq.com', 'dingshi zhou', '$2b$12$2m2i2QZzZ5X/72bEoiwxlOmQmBzi0k8drnNQNd9k8w5/mFl4QusVq', true, 'MNXJALEO32JP', false, '2026-03-17 14:28:30.036142+00', '2026-03-17 14:28:30.036169+00', NULL);
INSERT INTO public."user" VALUES ('9353ff54-83be-402f-bd2f-dee41cbd9eb7', 'gabrielodudu169@gmail.com', 'Gabriel Odudu', '$2b$12$XIrs42bWSyV3J1KXm7P.RORWAvev0NtjGd/9Shzhc2XxYcYD1B5x.', true, 'DSYPI2Z5K2X8', false, '2026-03-17 19:04:04.953091+00', '2026-03-17 19:04:04.953114+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fec5593c-656f-45b0-8f0c-1e3bfc51a182', 'summershine315@gmail.com', 'Summerville Ndukwe', '$2b$12$ladD2yUTWIPljzmI2IZ0Qey2DginPHCzZTHi0jT3IDrfGuqlF.JhC', true, 'VQQGIJ46J74M', false, '2026-03-17 22:48:34.833786+00', '2026-03-17 22:48:34.833806+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('249433f9-1ff8-492e-81e9-d4ed66a577a9', 'otubudaniel74@gmail.com', 'Daniel  Otubu', '$2b$12$1xr5IRXvZXx7OoWv5iMj9exih6xqeP7owhcR2/rGuE9zPtk.mxD6i', true, 'FNW5YAE4CEPW', false, '2026-03-17 23:06:04.422124+00', '2026-03-17 23:06:04.422151+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('44df741b-4fcc-43ed-b59c-5255a916d932', 'duongluyen17022017@gmail.com', 'TIEN DUONG Nguyen', '$2b$12$g.z2eWfqDwpNdDDPCUCckOdTqyQcBYnUyQHFidcLv9a6qLYP9QSZu', true, 'JNXGM8PSXRT1', false, '2026-03-18 02:43:31.841895+00', '2026-03-18 02:43:31.841927+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3c3eb14a-1cb3-4c2a-9ce4-fab182892704', 'ceejayjude3@gmail.com', 'chijioke jude njoku', '$2b$12$zKmV6s6eo.6g0eZFamd11OdtvRwaC2cn8ROPdZWTfb8lzeXrAMtl2', true, 'W6E4I7RDPEC9', false, '2026-03-18 17:09:21.450464+00', '2026-03-18 17:09:21.450489+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e29577f0-acef-40c6-9949-dd1338ec160f', 'onedunceman999@gmail.com', 'Hyacinth Howard', '$2b$12$gpNRejhAlrqkws0cH0EGcOqsE9Ts4i6C2xM9FBgPfNJzGUl.sk2tK', true, '83H8QDWTO0P3', false, '2026-03-18 18:25:47.866392+00', '2026-03-18 18:25:47.866422+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3177c3eb-6ddd-432e-8e57-f5924f820748', 'ruben.helderm@gmail.com', 'Ruben Vicente', '$2b$12$m/8GA2.aGjXRC3jOKpL/N.LF2YsU.SrtbPqDuL5ij5ZH5mzjFJCQe', true, 'E8B3Z3Q2GXIR', false, '2026-03-19 08:30:43.666483+00', '2026-03-19 08:30:43.66653+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4698f8b7-2bb8-4402-a090-98ede61c3038', 'Musichubafrica8@gmail.com', 'Peter Banda', '$2b$12$fyC7JwnUThjDznPzOgWXzuu6kBsqTlx0MkyYKYJNQJvDvp6XSZN.i', true, 'XJPKA0XUNDC2', false, '2026-03-19 14:58:11.223932+00', '2026-03-19 14:58:11.223968+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d273c2a8-8aee-4416-96e3-e13f1fdc2d99', 'Scantynii362@gmail.com', 'Eric  LARBI', '$2b$12$ckcMQYZf0W2B8yakeyK1HOfH9fM6q0M4CAD6UHwq.jgHOUf23dktm', true, 'K9W24VEXL6IR', false, '2026-03-19 15:36:50.542662+00', '2026-03-19 15:36:50.542689+00', 'MR.P');
INSERT INTO public."user" VALUES ('e8fcfbdf-e647-45df-ab40-054babaa8562', 'tutimas93@icloud.com', 'Aceem Grant', '$2b$12$.JqAr8mvy/jTCIEnYDuiKOJXiY8oMhB0yZHSgKeya9NbATdjbg3gG', true, '9LWO24JCMGIH', false, '2026-03-20 02:54:07.567702+00', '2026-03-20 02:54:07.567741+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('98028595-7cf3-48a4-a1fc-48dce7f4989b', 'startrick1300@gmail.com', 'Osato Osifo', '$2b$12$sYXaBwE6aDWLuU.ZpSVJOOQ58nk9OjQbBLHXhgik6kDlf5RVU6sBu', true, 'MAA8XSJFO1AY', false, '2026-03-20 09:53:41.317999+00', '2026-03-20 09:53:41.31802+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('929e3f5e-c730-4574-babf-b07433cc6d41', 'henrysoopu@gmail.com', 'Henry Soopu', '$2b$12$w/NuDKMWcSEkh.JBsVvj3OzLjXzuDESAcAuyNDl.k.EuigAcNxAy.', true, 'VWBFUCGME04P', false, '2026-03-20 16:05:51.482092+00', '2026-03-20 16:05:51.482111+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e136a75c-642b-45d3-a429-91c5613cb0d9', 'hardevgill701@gmail.com', 'hardev singh', '$2b$12$shH86RPsWKU0R9m07mEusemL3a1wci2Gw7qhM2liWaHbnSB62R3wa', true, 'WKSJEHRVBB0J', false, '2026-03-20 18:48:16.575138+00', '2026-03-20 18:48:16.575165+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5d133a69-17ff-477c-9209-12fa53b7fe3f', 'ernestsie9@gmail.com', 'SIE ERNEST', '$2b$12$ZnFmZZM2CvL1ryno8FiNReSSgF0.cCau.veTZVxwzV/1MO3z6.zxu', true, 'L7OFMR0FOQRC', false, '2026-03-21 06:11:22.385292+00', '2026-03-21 06:11:22.385312+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1d95a48c-2daf-423d-92dc-682f8ca81ab4', 'uzomavictor175@gmail.com', 'Victor  Uzoma', '$2b$12$hkP3WsRKGnquyJxBlAKShegc2efPTjg7TuO94MqbMk/2TFiAHgbYG', true, '8FKC5BYR6RSA', false, '2026-03-21 07:34:24.039234+00', '2026-03-21 07:34:24.039252+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d101dc95-0f9a-48be-9c8e-abbfdc114b56', 'balindermaurya846@gmail.com', 'TARUN MAURYA', '$2b$12$.mI/Wen9jUeVTNWPGRvKVuE8zT5Swl59SOH0PoJqT8zlot3WYAh8a', true, 'SEQ05AJR2HAD', false, '2026-03-21 08:54:12.349671+00', '2026-03-21 08:54:12.3497+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8c923e8b-1546-4dff-9d5c-b8144949646e', 'kmd55515@gmail.com', 'Mohd  Kaif', '$2b$12$OqYHseyQL/mVZoGaNU1NbOvBA/F8CXf59bfy.l2NC4sfMh0guuzwu', true, 'CUTH055K8TU0', false, '2026-03-21 21:17:44.479931+00', '2026-03-21 21:17:44.479968+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('32d8b036-eb6c-4b77-84b3-389649cfae77', 'romitchatterjee10@gmail.com', 'Romit Chatterjee', '$2b$12$fcTAYOzA2eDAk22gSTl5ZeMnnBOw0RPHwoRO78PzNyAVPd5Gn/c6G', true, '3L1J5RDDEPWH', false, '2026-03-22 07:21:34.276611+00', '2026-03-22 07:21:34.276638+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3a0e8d66-1fa1-4a6e-a99b-9cf7517342e4', 'charlesnyakinda2000@gmail.com', 'John Charles', '$2b$12$.WdTy2CV5eUaHJoYX542dO6KnRQLYMWluTnw5bUU.gAu/lBgD.R.O', true, 'CGCEV89V87GI', false, '2026-03-22 16:43:15.165872+00', '2026-03-22 16:43:15.165897+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('77652995-4cc0-4ab2-90e1-0348694e7d25', 'operasunny6@gmail.com', 'Sunday Okoronkwo', '$2b$12$S5iVnI9innlfWMfwGZlZr.dJIf0OPlrU6lvBjEaAJsHP6H29OyLia', true, 'JS1BD05TOD6E', false, '2026-03-22 16:56:35.891517+00', '2026-03-22 16:56:35.891549+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d0d34c27-186e-4cf8-bd3f-c6df2babf519', 'atharmuhammed6@gmail.com', 'ATHAR MUHAMMED', '$2b$12$f1TTm4XqH0lJJakV78lEvenSQ8CZDI1v4ytvpno35gDi.BK/lyeZq', true, '3ZQI888GIQ6F', false, '2026-03-22 21:31:46.524994+00', '2026-03-22 21:31:46.525019+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ecdcdaf3-200d-4c40-bfc9-e7de133713b9', 'chidishedrack18@gmail.com', 'Chidi Shedrack', '$2b$12$pK3Un3TszOiNG5aYz.lxzueCuOdjhoYGH3Nlb7kEuBHR6BIko5DSi', true, 'KGKQZUQOMLDB', false, '2026-03-22 21:36:23.897782+00', '2026-03-22 21:36:23.897803+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a86eaac8-70f9-4e38-98e3-ef6e2bdc9f3d', 'fxwave205@gmail.com', 'victor Anyanka', '$2b$12$Q3iK3K.PZMO.CTbl1DjIPOUKh7pnrRLyULW48pw3F0kg9Q2hoHNQy', true, 'VA9Q67UNXHL3', false, '2026-03-22 21:55:39.39736+00', '2026-03-22 21:55:39.39738+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e098552e-5786-452e-b36b-8dd5877d009f', 'magonzagerald@gmail.com', 'Gerald  Magonza', '$2b$12$IKNn1ue0RCb4mkQ3Vbqc6.mCkrDoA4QYQHOh9xk56bichqmyk.ZNi', true, 'LNCHXWITK65K', false, '2026-03-22 22:01:46.606644+00', '2026-03-22 22:01:46.606663+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e703106d-2d5d-49a9-a07c-95c70c3a883d', 'acharyasantosh424@gmail.com', 'Santosh  Acharya', '$2b$12$8lKr40t1FnX2XxlvxuU7zuSuTIpfeM49TyVHJz.1HMEeMal6ni7mW', true, 'JPRKONVUDZ4B', false, '2026-03-22 22:10:35.044513+00', '2026-03-22 22:10:35.044538+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('44b19b3c-8644-4f85-94b8-3fa7643ba876', 'themathapelo@gmail.com', 'Thapelo  Thema', '$2b$12$D2Q5ouaxm.wFDpibjyp5QuBSFDe4gUeS87c1dQIIg.JJJnCYmzFC2', true, 'B6B2OPD2JZV0', false, '2026-03-22 22:12:01.87098+00', '2026-03-22 22:12:01.871003+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a18ba56e-e135-4de6-a3c2-b305f4e8f585', 'binoinfo422@gmail.com', 'Lawrence Obiora Nwankwo', '$2b$12$YB0PQpOkuxT./nrN18E4Au3UcNnizn9.FTHH6COiX8qJnP5mlcyYa', true, '4Q5429VFIQBS', false, '2026-03-22 22:31:25.742522+00', '2026-03-22 22:31:25.742547+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('30c2ae72-7ab7-461f-85bd-3551dabdde76', 'shehujalingo01@gmail.com', 'Shehu Usman', '$2b$12$pZFzyyxcBg2Re7SJ49jktOq6L6DWWKVI4PXYtcrzlFny.m9C2OJEq', true, 'YRSCKRFMLT2E', false, '2026-03-22 22:40:06.362286+00', '2026-03-22 22:40:06.362312+00', NULL);
INSERT INTO public."user" VALUES ('ce4afe6f-c632-4896-9f52-bd0f8b568f8d', 'acomsarah1@gmail.com', 'Sarah Acom', '$2b$12$4ugp2xO9fBgMSedlQGosQ.WYeiNnCWo0GJwFhjQ/Sh6/6EdcAK5.i', true, 'ZYIUD65D31A2', false, '2026-03-22 23:26:45.394094+00', '2026-03-22 23:26:45.394122+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9d966c66-7429-4953-8dd7-44b049236853', 'iibiaselemi18@gmail.com', 'Aselemi Iibi', '$2b$12$rtuZyuf8UolvwsBFzx/ii.H7nyT0VN8zPsuwrNBzWjy6KUnfNzOHi', true, 'MVKTX2UYIJ2D', false, '2026-03-23 05:02:48.529425+00', '2026-03-23 05:02:48.529456+00', NULL);
INSERT INTO public."user" VALUES ('65c25926-85a8-48d7-804d-a9af48d98f08', 'albertochicavaseco@gmail.com', 'Alberto Seco', '$2b$12$UQi2b/PU0Jl.qSBt0MkU7ej2l.kRVE7eQsRNVZ63pQV9L4X.hFaUS', true, 'H8DJ4VYGKDFZ', false, '2026-03-23 06:51:45.573471+00', '2026-03-23 06:51:45.573492+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0a1bc7d5-a924-4ebb-a1ef-fa598b9090f9', 'moyoaleck56@gmail.com', 'Aleck Moyo', '$2b$12$PAo00myDvbB/CrDQUGYOh.VB//S8.9w6R1osOyFGtxMMob40/47zq', true, 'XT4H0OA24007', false, '2026-03-23 10:32:37.8203+00', '2026-03-23 10:32:37.82032+00', NULL);
INSERT INTO public."user" VALUES ('ea3c1274-a633-4acd-b853-92a25f785723', 'ankitlodhi402@gmail.com', 'Ankit Lodhi', '$2b$12$vMQVPk4B1FacqSk5a4hNjOJpjlGujpqHRH0cKDZHRKPdd6LJ/S9/m', true, '2CFU26LTR01X', false, '2026-03-23 18:28:15.221891+00', '2026-03-23 18:28:15.221912+00', NULL);
INSERT INTO public."user" VALUES ('cecd5931-6db7-4c28-a212-0d22cd643993', 'eseosaekiomado@gmail.com', 'Eseosa  Ekiomado', '$2b$12$5/zfXKUQjz4bq1QxGj848OTl2wAShsnhTW3vvSMhIlMe8A7tZQGx2', true, 'UR5Z7CKQM36W', false, '2026-03-23 21:40:05.056236+00', '2026-03-23 21:40:05.056265+00', NULL);
INSERT INTO public."user" VALUES ('42bddcee-8831-4c31-8de5-164f64d8743b', 'd_sparks1028@hotmail.com', 'Gbenro Odugbemi', '$2b$12$hh4Rd6HMB0cRZjQs.xMCv.pjkkTYKaSjd.wyiIJ65Qcp9TrmTWpR2', true, 'NKC5LMP3GUDZ', true, '2026-03-23 15:06:56.26227+00', '2026-03-23 15:06:56.262302+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b37fb1c2-c8fe-42b9-9ff0-b8ca093af38b', 'awa231217@gmail.com', 'Mechella Taborada', '$2b$12$g/oBz7H.rzruQ4Gvgt7MLONBcQtLu3P6vpIk.96CmzOBQpwnw8oi6', true, 'YKC0PE80MQIT', false, '2026-03-22 22:23:02.023843+00', '2026-03-22 22:23:02.023867+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('46c002ce-5c74-441a-a3f1-03e12bd91d6e', 'winaviator181@gmail.com', 'John Iheanacho', '$2b$12$HevPc.oxAT37RDaZ3JUSvOeskJ4OBMUp6L8Aq/4PPb/HJla2RPNLG', true, 'B3GQQXDJCDOG', false, '2026-03-22 22:38:20.581929+00', '2026-03-22 22:38:20.581961+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ce84462a-6a40-4b3f-9332-32f22aaadf54', 'palmpatel15@gmail.com', 'Pal Patel', '$2b$12$t3uTEF1gthTInq.ridVK7.TuUzcGixyKUORy1rQpo720bZnEQ/ysi', true, '7K60G8EU6HZN', false, '2026-03-23 14:55:30.500062+00', '2026-03-23 14:55:30.500081+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('95e69f32-f19b-440c-9c7b-635d88fc7878', 'kumarjayesh0156@gmail.com', 'Jayesh  Maurya', '$2b$12$0Ow8hOrb3t57vDxwHhLAfuShqRzltG3sh0PXFXBJhRanKT/VDZhse', true, 'ADBN2MZNHZFB', false, '2026-03-23 15:05:48.141861+00', '2026-03-23 15:05:48.141884+00', NULL);
INSERT INTO public."user" VALUES ('b538fa08-1c81-4fc6-a0a1-885543b25a73', 'sadotheric@gmail.com', 'Eric Sadoth', '$2b$12$wCPk7m4gro4Fq0FKn5zWeO2udH7XwwnBMr5Im3uVvomwkhIwcRLkG', true, '7DE2A94QIT13', false, '2026-03-23 23:04:30.378422+00', '2026-03-23 23:04:30.378462+00', NULL);
INSERT INTO public."user" VALUES ('469ba91b-3776-4c32-be58-49e340392dea', 'scottenpick@gmail.com', 'Patrick Mugerwa', '$2b$12$HM.Wlz.u.514ZILOLfGHa.TD7qAgFcCDyy1ssR3P0qYHMUVK2d0ve', true, '4514P4NDA3LO', false, '2026-03-24 03:13:02.812561+00', '2026-03-24 03:13:02.812583+00', NULL);
INSERT INTO public."user" VALUES ('a40bead0-c07a-4c04-8ee7-56260bd9188d', 'samerbm85@yahoo.com', 'Samer Muhammad', '$2b$12$Elaaj.mfj/zU1dmVOEIwOu.biEtZeCGbj.yz5OL11zlWhjhpdkGgq', true, '69YVR1X6S838', false, '2026-03-22 22:23:02.617452+00', '2026-03-22 22:23:02.617469+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f2eba937-872e-43a1-b847-24605a828f6b', 'gheeads@gmail.com', 'john Dawei', '$2b$12$ONoDIydlvkcAlF9lSe7xiOfi.uqd8Myd81HThXee5hIjzjMG1U4sK', true, '3EGUDSH75Q7I', false, '2026-03-22 23:07:57.165378+00', '2026-03-22 23:07:57.165403+00', NULL);
INSERT INTO public."user" VALUES ('c29bb098-2098-4764-a82e-22a696c35d1a', 'csulayman654@gmail.com', 'sulayman camara', '$2b$12$OrifpLHj4tL3gyiZNLMB3.io7m0r.sluRfioNpH1vCockJWIXP5KW', true, 'JE6CEYLOIQPK', false, '2026-03-22 23:16:15.708816+00', '2026-03-22 23:16:15.708842+00', NULL);
INSERT INTO public."user" VALUES ('6a3731af-8b72-4549-b9f6-dd71a08f578d', 'Akinezarodrigue@gmail.com', 'AKINEZA RODRIGUE', '$2b$12$xonTsNHfahSwND27BF7IT.wYW4oSSM3On0Px6nZAeS4FotTUrGZLO', true, 'C17FT771XN54', false, '2026-03-23 01:05:16.938904+00', '2026-03-23 01:05:16.938932+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fce527dc-8912-48a1-b0c8-8793989f1314', 'agboalujoseph@gmail.com', 'Joseph Agboalu', '$2b$12$VBt3KdRNqcJ0oAONIReCzO26jCzNwQBMuwkQ1yZBpVr22oyl3.8IC', true, 'K3Q60A1WZ0T4', false, '2026-03-23 03:45:02.276478+00', '2026-03-23 03:45:02.276507+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ddca0834-f182-4d42-bff6-30d12e7b0017', 'raysha0227@gmail.com', 'Reimond Eiseb', '$2b$12$HZ0WtCk.rvw2lCMUCKqjOedfmO3qlO9ZZRGQbF1DZHG2HLeKjPCKe', true, '8K0D3DDYT6DQ', false, '2026-03-23 06:50:59.580725+00', '2026-03-23 06:50:59.580748+00', 'raechos42@$');
INSERT INTO public."user" VALUES ('23f32876-3ba7-4e47-8ba0-28b1e162c741', 'oladelesamuel64@gmail.com', 'Olabisi Oladele', '$2b$12$HMdYK23jT/rcF010APQk.ei./6lK5UZlr7Dvspfc5qvqT/oHviFjm', true, 'SA8BR2GW7GZS', false, '2026-03-23 08:15:17.868503+00', '2026-03-23 08:15:17.868527+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4a28e566-8a92-49de-a7a7-a0aec89ed708', 'ezejohnskills@gmail.com', 'John Eze', '$2b$12$cp3yRqd7Xxet1l7msv66G.aZHywqGJ2/QtP0uANUydCsiL8xVqqk2', true, 'C410Q8UFX00R', false, '2026-03-23 09:00:38.866822+00', '2026-03-23 09:00:38.86685+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d2b82529-f47e-4b55-909b-63277eae69eb', 'raphaelugulashi@gmail.com', 'Raphael  Thomas', '$2b$12$o0QCuyPBAp4kxeAexxJQ3u1.e75FZ62oHI5PUySdR8s4WAG1PDLgO', true, '41T1LULWPMI8', false, '2026-03-23 09:11:33.514747+00', '2026-03-23 09:11:33.514769+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4e59be3d-c606-4b17-ad72-a5be0ea21f51', 'bussaruthzuhayr2@gmail.com', 'Zuhayr Bussaruth', '$2b$12$0Dd6UPliZrGlzteid9nDbOoqB0vc1OBb2qlrgkgknnfI9DnDO9ZlG', true, '9VSH0AJ7PIDW', false, '2026-03-23 09:20:13.229815+00', '2026-03-23 09:20:13.22984+00', NULL);
INSERT INTO public."user" VALUES ('5e771b49-e70d-4187-9d32-24db2b7eb69a', 'wilsonprophetpaschal@gmail.com', 'Pascal Wilson', '$2b$12$lcLgzReDOU0rqQ0fOsibu.DS44UA.xdmEDYI4KvmLji9tn/h.HTNy', true, 'CI5N6E62YLYH', false, '2026-03-23 13:01:02.527274+00', '2026-03-23 13:01:02.5273+00', NULL);
INSERT INTO public."user" VALUES ('392683d2-2e31-45b5-a188-c822a514db47', 'junaidimrb10@gmail.com', 'JUN AIDI', '$2b$12$AP3VhtzGl8j4Y0vKCzvMjePCa6TF3fp.a5wjgP2hM94fez4LgCQfO', true, 'U8W1VULGM3ON', true, '2026-03-23 13:07:09.581743+00', '2026-03-23 13:07:09.58177+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('63f400e7-a95d-455d-be12-4e809e4803d2', 'mfjammeh62@gmail.com', 'Muhammed Jammeh', '$2b$12$Bx9ZwyF4PUmZPuVgDtXfYOoLW0xUHyT41OD79vfkPnmOO39Ss4a5W', true, 'AI3AQPU90DS6', false, '2026-03-23 16:55:43.781125+00', '2026-03-23 16:55:43.78115+00', NULL);
INSERT INTO public."user" VALUES ('bd9663a3-f41d-43df-9318-97521de8be1a', 'emma53185@gmail.com', 'Emma Peter', '$2b$12$1nJ7EysQcJzewbAGpj.8Le86f.oJBCCj8lQBdME7LHTmEWjMR13Ze', true, 'M3YAGQC0HCAS', false, '2026-03-23 17:06:29.46524+00', '2026-03-23 17:06:29.465261+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e6091602-4cbc-4db9-9509-1fa7027925a9', 'alphawan1011@gmail.com', 'Ibrahim Baila wan', '$2b$12$rBmoclfMS8MqiYhPCxEL6.dtVqhuYERGdiQCUy/fMH2KrqOQYSq5G', true, 'SGH0H1TLNGDE', false, '2026-03-23 18:17:44.094427+00', '2026-03-23 18:17:44.094456+00', NULL);
INSERT INTO public."user" VALUES ('0a479b49-b538-4a7c-a068-407cc138a8a1', 'vb6415350@gmail.com', 'Vi Vi', '$2b$12$wfOXRjVuKiIIdIflBjX65Ou6MYzaQr2wNMOMg/mid8MgOr7S4Tqku', true, 'VAV62HF4J31V', false, '2026-03-23 21:05:53.292542+00', '2026-03-23 21:05:53.29257+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('78307d5d-0236-4681-a43d-c9e457337d90', 'bambafreelance@gmail.com', 'DAOUDA BAMBA', '$2b$12$pu7epcIIA7zDXLnA/HiwZuqyHcw.YGAR8luf4kJRmd0XVoJEHqKMG', true, 'M1GB1MN9O075', false, '2026-03-24 01:22:06.934021+00', '2026-03-24 01:22:06.934038+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c89b4246-9061-482b-bba6-ecf53713995b', 'bransonsam16@gmail.com', 'Sampson Branson', '$2b$12$OXxyLbDF4bArWVmTQYgW0OYL3VDOftR5skJ3MAEKEp8W8MuPLOPpO', true, 'VLNI95XJBEBZ', false, '2026-03-22 22:37:16.524891+00', '2026-03-22 22:37:16.524909+00', NULL);
INSERT INTO public."user" VALUES ('14fb7459-3158-44cc-a207-e2d8936081db', 'opheliaverdon@gmail.com', 'Christiana Reina Dossou', '$2b$12$hBlQEuhXsZSiueuBaEcxbO7TEmYXDVxt46sU6ICbz7Im39K5lmktO', true, 'T0JG2ZG1FRDZ', false, '2026-03-22 22:41:06.331412+00', '2026-03-22 22:41:06.331434+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('024c24df-07b3-4fa5-950a-6b2d5936a4aa', 'dongpeulefrancis@gmail.com', 'Francis  Dong peule', '$2b$12$BV/rKk7KvxM7b16ZF7AEzOHB6pLB9XJ64iXdljerhzVuGi5kL8gSG', true, 'AHX2LS5RZRRQ', false, '2026-03-22 23:04:50.244856+00', '2026-03-22 23:04:50.244884+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f02914e7-b369-4f0b-98f9-422ab6f6a794', 'kecy404040@gmail.com', 'Kelechi Abraham', '$2b$12$IerOFXUU6LYcM3QkC9FE0eaoIQZC6BqGpAilkuuZW9D5qHL7xGvkC', true, 'BW0Y8BTB1YAE', false, '2026-03-23 02:52:15.347479+00', '2026-03-23 02:52:15.347503+00', NULL);
INSERT INTO public."user" VALUES ('20b6cf1c-1526-4fd4-bc9b-e1512848db3a', 'osomsakhigbe00@gmail.com', 'osomhi odjemu', '$2b$12$Ts9Byyjw.ddvA6p5Ba4/3.y0zakN6mDMZfPz0o/SnFrA8BTojpUvi', true, 'L8ZQYMNS2JSB', false, '2026-03-23 07:36:12.246162+00', '2026-03-23 07:36:12.246185+00', NULL);
INSERT INTO public."user" VALUES ('0bb68093-28bc-4957-b9ed-7ffd4cd53d86', 'kawalyaisaac1@gmail.com', 'kawalya isaac', '$2b$12$YsYM3LxVbZHWcQpC..10DOjgxvRwmhQ637uVw9ixLjfPMjCRRJWEW', true, 'M7U1819GY6V1', false, '2026-03-23 10:38:15.911903+00', '2026-03-23 10:38:15.911928+00', NULL);
INSERT INTO public."user" VALUES ('2d5b896e-f2bf-441c-8af2-cb52881f7888', 'adeolamichaeltaye@gmail.com', 'TAYE MICHAEL', '$2b$12$bULskzIBpdB3FopmuXCoSerTkTp7Sm9fUfBEuSbhFv08JaJhMWJli', true, 'K63TQHJG993N', false, '2026-03-23 14:05:56.31807+00', '2026-03-23 14:05:56.318095+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a5a5dbe4-b0e5-49d7-a200-4c8826f5a6ab', 'shuki___@abv.bg', 'Shuhray Tefik', '$2b$12$qyY.d.D7KKuUWb4NOZ/3F.ChwYFZYJ9fvo4J0wgZHt3TwL7DupmYS', true, 'GJWPL78OJMX7', false, '2026-03-23 15:44:19.834654+00', '2026-03-23 15:44:19.834673+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0372b5c5-02c7-4f91-b359-46a380497e78', 'irfankhas0011@gmail.com', 'Irfan Khan', '$2b$12$i/78vn7AZLIb49I4PEU4qe2wTi.vMp8NgugG/PlzpxRBl5Wwi6QSe', true, 'SWTJ2UOUXZ7S', false, '2026-03-23 16:20:07.012126+00', '2026-03-23 16:20:07.012154+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b884adf5-c8c6-4244-a909-43b5b2beed48', 'espncashinfo@gmail.com', 'Ikechukwu Unegbu', '$2b$12$FuJzpDeXnvZTSZ38bMXNXOveBZ5o7TmLt4KKYvFRBs9paIbJZDkqW', true, '0EUZU28UWLBQ', false, '2026-03-23 18:12:26.862469+00', '2026-03-23 18:12:26.862491+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('67161b66-3fe9-45ab-b08c-528f5c16ac75', 'networkmarc484@gmail.com', 'Mmoloki Chuma', '$2b$12$QSwOlvjTc/4ppMZLH1QMt.yCo70xktCP51LxjXDo9qNO2K2ecTPBK', true, 'PED4T3PBKD19', false, '2026-03-23 19:48:02.794077+00', '2026-03-23 19:48:02.794103+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('62a85235-1d46-4192-a84e-1de9dc9ecaab', 'vishalbharti60266@gmail.com', 'Vi Vi', '$2b$12$6sPEEk96tFy3eHWWeex5Ieim5tuFaBHWTtsy.R..3qs1mgTrViQYC', true, '2XBK1K7RPBQI', false, '2026-03-23 21:09:10.308877+00', '2026-03-23 21:09:10.3089+00', NULL);
INSERT INTO public."user" VALUES ('2d2937d2-4625-40cb-b1c0-0d809b6f7ed9', 'abdul053597@gmail.com', 'Hummu Ahmed', '$2b$12$.kUB.YmsCEODfQX2CpvI0O4y7dnvUqdt9SGCYrypSLQ7BvFloFP5q', true, 'O45C3GQO35TQ', false, '2026-03-23 21:59:33.834159+00', '2026-03-23 21:59:33.834179+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fa275ee2-722e-4f45-8de4-db025dcd07e7', 'jeffjaphet17@gmail.com', 'Japhet  Philibus', '$2b$12$s6ZbUrkdGLmP1ruphH0Up.Q0qu8Kqo4GG0eeNpk6zaF2MF0Fuha26', true, 'J8XZLXMP7PE0', false, '2026-03-22 23:16:42.235397+00', '2026-03-22 23:16:42.235422+00', NULL);
INSERT INTO public."user" VALUES ('0b37f983-2d20-449f-9f24-93f812435017', 'moussongo77@gmail.com', 'Jacques  Yves', '$2b$12$MSv9zgPrsBVjkrjOiXFT5OgrhUAWFgYc/20/5TbNNqgSQ7C1Onogq', true, '13R0YKEDDIOM', false, '2026-03-22 23:49:06.124462+00', '2026-03-22 23:49:06.124489+00', NULL);
INSERT INTO public."user" VALUES ('8b662898-f1f7-48a4-bc0d-a4cd2c26da1a', 'netlinkcomputer2014@gmail.com', 'JASWINDER SINGH', '$2b$12$7PW97Mz.5I8PK9MyRUsjJ.rosEh8ipuMb/l10ubp0hSVBrTK6MPYy', true, 'M0CL2T3LCBUR', false, '2026-03-23 02:11:46.986051+00', '2026-03-23 02:11:46.986082+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3444aa3a-0bc0-4b4e-a242-ebf9a3ef065e', 'profxrissamson@gmail.com', 'Christopher Masunda', '$2b$12$p3YvBjHGNtR5l7sRRbPQReLIS/124q0as0LmfnH5OAuz8cLubAezK', true, '5GGJ1HTBRUCW', false, '2026-03-23 05:54:31.454651+00', '2026-03-23 05:54:31.45468+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e438cf10-961a-4cf3-a881-5bc8bb9cd48e', 'jenishharesh@gmail.com', 'Haresh Chavda', '$2b$12$xCzJq0I5qHRQDCsIQiyV5uZQZInsFxMe7Iwq9LVkyo5.ACbmJBQoK', true, 'ZJZ5JNVQ03D5', false, '2026-03-23 07:38:27.030537+00', '2026-03-23 07:38:27.030557+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a7c6bbf7-b55f-42ad-a2d4-e64f46152ed4', 'oluchiowuamanam@gmail.com', 'Oluchi Owuamanam', '$2b$12$vIPZMnhCJULSLszKy8p5oeU6OMLtUCy/m6wAAOcSnR2sizxZf7/K2', true, 'F15CZX1R7SRG', false, '2026-03-23 10:08:23.024825+00', '2026-03-23 10:08:23.024847+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5cc10917-d39c-4161-a7ff-3766f5dd80ea', 'kartikpawar275@gmail.com', 'Kartik Pawar', '$2b$12$bZoYqE5t0HxPGvEtXLHZG./Uo9S/fiQy32cQq7/TcsJ0/mEe0NIlS', true, '2Z2I4QG1IG9R', false, '2026-03-23 15:43:26.242769+00', '2026-03-23 15:43:26.242794+00', NULL);
INSERT INTO public."user" VALUES ('3bb9ea3c-19a8-4172-b73e-178272dd0b6d', 'kinkelv3@gmail.com', 'Osayuki EDIAGBONYA', '$2b$12$xF5qYbBjtM3ES.P.5DILCuG3RRJPgQ2Tx2eyTlEJ7omXvbmBJL7RC', true, 'YE011JP5AKZI', false, '2026-03-23 18:45:31.431448+00', '2026-03-23 18:45:31.431473+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a0e4571c-9a62-468d-93d6-4b98e8a9d494', 'starstone10k@gmail.com', 'Jacob Denteh', '$2b$12$jmB9pPOVsveTbp9q20qPmu5r5E1Ox6Uy5k/Axcn7PadO.k8wKD66O', true, 'EG7J9SVSCWUC', false, '2026-03-23 19:48:55.525535+00', '2026-03-23 19:48:55.525551+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6b78b99c-e785-4563-8980-353088065fbc', 'adanuagidike@gmail.com', 'Adanu Matthew', '$2b$12$MhTYsz75khP9enTMvkzTpu7aQ57oIMr08EkYhjpga558xzp.RjeOy', true, 'OA4O7SPU17CY', false, '2026-03-23 23:51:59.838625+00', '2026-03-23 23:51:59.838648+00', NULL);
INSERT INTO public."user" VALUES ('7c82a528-83e6-41b2-b7a9-9372f54979d8', 'gcvgfhb@gmail.com', 'Alex Brown', '$2b$12$hFYZYUnlbloILJKBNlBJsOAYNETf6ScM0/svzfN1g2zYTObUKRDsu', true, 'F5VS0M0YWCRR', false, '2026-03-24 04:39:38.959162+00', '2026-03-24 04:39:38.959191+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5718d75f-6394-4a40-8c16-83c50e06ca82', 'bsibaram6@gmail.com', 'Sibaram Behera', '$2b$12$EwmXhV5AhNaCXDfFA.OqK.jUVycwaobYdBYhEfOnhRO4R3SnNTeMS', true, '4VEH2V5MRSBA', false, '2026-03-24 07:55:05.645203+00', '2026-03-24 07:55:05.64523+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ae7f2a58-8687-442b-bef4-048a996e8961', 'andyalston52@gmail.com', 'Andy Alston', '$2b$12$OW26OEwL0VI9ARZDpV8faeFmtTw63wlleOmBrlsPn6VhldIiHGAXi', true, 'FDILC83EY0TG', false, '2026-03-24 14:28:28.339396+00', '2026-03-24 14:28:28.339417+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9409b05d-1b28-4636-8e09-40681b93b531', 'danparkas01@gmail.com', 'Daniel Akhahunde', '$2b$12$igOuQRVjAnwJqwq2LQ/w6.0AqxrNbz3PGQZ7U0dN7oP/VjjlVSECO', true, 'HEFZL203UB7B', false, '2026-03-24 14:43:11.597093+00', '2026-03-24 14:43:11.597126+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e47898ad-7c5e-4cc7-b17f-c35fcc483f45', 'kqsrecords@gmail.com', 'Thulasizwe Nkabinde', '$2b$12$lEhYsDwwIkhTJ5zdIkLNDOiMIakis9cGSiDhurv80YGRH/VTUKo1W', true, 'H7BTZM1XUURL', false, '2026-03-24 15:37:16.849923+00', '2026-03-24 15:37:16.849943+00', NULL);
INSERT INTO public."user" VALUES ('de6b5d7a-f583-41a0-8c16-968953f3ac3b', 'abdallamohamud238@gmail.com', 'ABDULAHI Mohamud', '$2b$12$Ykt8ANpU6ThxTYdb0sXZW.4LQBcN.uhTjvYAP1MVMiz/wqi9IJn9q', true, 'UYBS89KAWTH9', false, '2026-03-24 16:51:48.992179+00', '2026-03-24 16:51:48.992197+00', NULL);
INSERT INTO public."user" VALUES ('c0af5ae8-550f-4b5d-aa77-6ec7223fc59b', 'aubjon@gmail.com', 'Ayubjon Toijboev', '$2b$12$tpEf/ScL20BeiDuEazqgZODk2Pj.Kp50JcwKuE5F7oD0MJO85u/fa', true, '0UDYI0HXUAUO', false, '2026-03-24 21:53:52.096788+00', '2026-03-24 21:53:52.096812+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('29cc8bf8-4157-4859-8925-b0c2cb43562b', 'azizbek9806@gmail.com', 'AZIZBEK  MIRZAMAHMUDOV', '$2b$12$92Srh2HIWADhunuGzgSbo.Yx1ggFEPtCHUDzz6T5kpwC0ESQf0B8K', true, 'J41WXWJI4DC5', false, '2026-03-25 05:42:06.914891+00', '2026-03-25 05:42:06.914918+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9479d799-b4e4-4c5a-a01c-1c0ad479ee8e', 'nsisunge@gmail.com', 'nsisung ekanem', '$2b$12$6v4Az83ivSuD52TC5QVPLOezAwOBcUkyCLx8LqkV..iK6zoCb/xeS', true, 'WO9N7N2FTB1S', false, '2026-03-25 06:59:49.703454+00', '2026-03-25 06:59:49.703485+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('49562463-6034-4392-8ef0-29340c128566', 'eltachador@gmail.com', 'Roméo  Tchinda', '$2b$12$2ukT930e0IOv9.wEKhB91e9R1tDI5kKOIP4wlxutxJ9rPEeD25AM.', true, 'AJW9WGGG82IX', false, '2026-03-25 10:38:26.885187+00', '2026-03-25 10:38:26.885212+00', NULL);
INSERT INTO public."user" VALUES ('992ac2f4-b320-40fb-8c1a-f54a5c3492df', 'rackeshablackellar@yahoo.com', 'Rackesha  BLACKELLAR', '$2b$12$2SBQR8BtFKFTzCxeNWAxIuyVe/a/Uu2SCJ52Zu2Yyb9Q7sLRzQRSS', true, '5RXO7KEZ0XX8', false, '2026-03-25 21:31:31.597539+00', '2026-03-25 21:31:31.597568+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4b23256e-5bc4-45c9-ab92-f5ac6d4e954a', 'akherearebanmen123@gmail.com', 'Akhere  Samuel', '$2b$12$DS2tIUjpfeJDEh3woujoQ.VCio5YLLMp9CUEQJepxyuI9/Ro5Ilim', true, 'TY2MZJ36P83D', false, '2026-03-25 22:46:58.119286+00', '2026-03-25 22:46:58.119315+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('84106860-ff16-4e0e-a3e0-a8457b110c9f', 'fidelissitepu@gmail.com', 'FIDELIS MUSA AKATO SITEPU', '$2b$12$Sl01l0w7pS0x00RO66YP.eQJxnThhDynhg9It.K86i.pkYQURjgJq', true, 'A13CTFL7WARR', false, '2026-03-26 04:15:03.286947+00', '2026-03-26 04:15:03.286974+00', NULL);
INSERT INTO public."user" VALUES ('8a44644e-bed0-4bc0-b888-3e9cb4dc6f8d', 'isaacjohnjy@gmail.com', 'Isaac  John', '$2b$12$WHPvFzmj0tj9FN868GevXex9yINeVVjTs/yQqCgj5W1TUgiWFNTo6', true, 'IN8NL8048R3S', false, '2026-03-26 06:19:23.692138+00', '2026-03-26 06:19:23.692168+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('08d796fd-1f03-43a4-8f0e-e19c9a280651', 'muashechigandi@gmail.com', 'Munashe Chigandi', '$2b$12$4K99WEMXETVeRyqdUm41EuCs6ZIMgQvThRY9Pjj8ElB/gPC./zzfG', true, '3IC008DLV6C3', false, '2026-03-26 06:24:56.363339+00', '2026-03-26 06:24:56.363355+00', NULL);
INSERT INTO public."user" VALUES ('a9eb406b-1695-4e5c-8c29-ba935ce464e5', 'ajayapple28@gmail.com', 'Ajay Apple', '$2b$12$c7yBMn77ZpJtM4a3GUfhzuRhVMgcHTxuFSwQgP/G.q1ShM.pkppx.', true, 'J0E66IEJK6HM', false, '2026-03-26 11:48:33.208727+00', '2026-03-26 11:48:33.208749+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('117821b3-512b-45df-874e-63cee7dded85', 'hasnainriaz1000@gmail.com', 'MUHAMMAD HASNIAN', '$2b$12$lNkW6JZPdxf0XQTVszzWresmdj.odHG/dxc0rTjOcC4GwgGZxe8h.', true, 'O38AFW301E0W', false, '2026-03-26 17:32:56.497116+00', '2026-03-26 17:32:56.497147+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d6e2153d-1524-4da1-9f08-c70ac3f03b4d', 'godfreymaloba7@gmail.com', 'MALOBA GODFREY', '$2b$12$B/lxq32i1Xhj8v0u/3DzmOY4YHD3DRkTJ1a9ELVQMbGzaRotajW4C', true, '8CW8ZUUE4LP1', false, '2026-03-26 22:16:33.015548+00', '2026-03-26 22:16:33.015577+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ae317e09-d330-499d-978c-c0f76a57e958', 'davisonkelvin@yahoo.com', 'David Ekpenyong', '$2b$12$5Tx72SHhrp/O4xbVQpExS.w/3tBKZOonZ3L4TjnZKU21Dwcji7fs6', true, '4B2547L8EFI7', false, '2026-03-27 07:13:40.340975+00', '2026-03-27 07:13:40.340994+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7f0f414f-91bc-4685-af77-5451a8acf0f6', 'wasiuskyboyskyboy@gmail.com', 'Wasiu Skyboy', '$2b$12$C70003ma1CBrstqIX2OeP.Q/ScP8vPPyrnWATJiYs4WH2yGuTgLva', true, 'S62SPCMSNRES', false, '2026-03-27 14:48:05.573876+00', '2026-03-27 14:48:05.573899+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('14e9280f-93a8-4ada-b5f7-e36f04121434', 'emmy35429370@gmail.com', 'Precious Chukwudiuto', '$2b$12$vJYjAzZvkOVZ9yyxWWDDi.zKMDRTQ1MoSstOWdXUS8W85G.nBJVHi', true, 'VUJJWPAP5UED', false, '2026-03-27 17:17:19.096841+00', '2026-03-27 17:17:19.096867+00', NULL);
INSERT INTO public."user" VALUES ('b94d275d-4bcd-456b-a2b7-f790712be783', 'nkomoli9@gmail.com', 'Lindelwe Nkomo', '$2b$12$InnaiRLkZ//U7S5tuCoapOkeGuTtGcPPyWvzI1Lu8EgrkIO1rv8Pa', true, 'R0HPI3PZJKN1', false, '2026-03-27 23:43:01.587709+00', '2026-03-27 23:43:01.587734+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('05a52191-606e-4162-83de-1ae1538ae4c4', 'franciskapuya84@gmail.com', 'FRANCIS Kapuya', '$2b$12$Jmk27pb2OjPoJhbspIgMpuXOuWv6jWziJzNgWOw1GCJ0O/pc/41UC', true, '35ZCVTZ0JKVI', false, '2026-03-28 01:13:27.205243+00', '2026-03-28 01:13:27.205266+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ca9b2282-ce95-4df7-8a9a-024b01490bcd', 'ryanamini01@gmail.com', 'Ryan Amini', '$2b$12$zMmGyvLCCYn614DuJbd2zObUGNaNk14MjIdAjjNfdLGpAND9TtFC2', true, 'E58KJZSTKXED', false, '2026-03-28 10:40:53.215647+00', '2026-03-28 10:40:53.215672+00', NULL);
INSERT INTO public."user" VALUES ('3e7dbf13-ee7c-434b-bcdc-b38b44ce1360', 'khellious@gmail.com', 'Chinonye Nwakamma', '$2b$12$o2Heg4/8dphDPDgbTLwq9u61lPJiRnbB6BZ4ouFMPhYYZEM5nQAKG', true, 'MC69XC5RK780', false, '2026-03-28 12:04:20.447426+00', '2026-03-28 12:04:20.44746+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a5c4d545-633e-40af-a1ee-df5d7936bd5e', 'cheruiyot7007@gmail.com', 'Emmanuel korir', '$2b$12$DotiJQDs7bw3xc4W4GMX7u4h2OJPfYt62m3seKjAgKgyHg28KevLu', true, 'HTJXSVBQN6M6', false, '2026-03-28 17:57:25.817696+00', '2026-03-28 17:57:25.81772+00', NULL);
INSERT INTO public."user" VALUES ('9886c29f-9c8c-4f3f-9a66-5d2bcf5aef9a', 'nattaniel31@gmail.com', 'Eromosele Owobu', '$2b$12$xL2GL/d8eqIJtEdqs45y7upV/CjvGuPOmzc2xs6jzKpdcmCisiPu.', true, 'TN6UTMBU5CNT', false, '2026-03-28 19:01:27.605906+00', '2026-03-28 19:01:27.605928+00', NULL);
INSERT INTO public."user" VALUES ('0f18764b-6800-423f-b770-dfd7c40ae2b4', 'davidmilitschenko1@gmx.de', 'David Militschenko', '$2b$12$jFhoWeUQ0dOYUQvfBNELQ.xk3czeBFFxkIKuwNkiP881SP2uBuKiq', true, 'XM2VPI1CBD2R', false, '2026-03-28 22:29:26.6342+00', '2026-03-28 22:29:26.634219+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4bd63413-a6cc-4fb9-ae04-78b7cdff7311', 'karun9212@gmail.com', 'Arun Chaudhary', '$2b$12$PM2YKg2by1b2968g/RpLI.ix4Z8UXwnDcI.CZIOuKUPlJtmn6TNhK', true, 'PNFG9NB1ZYNN', false, '2026-03-29 11:10:35.749981+00', '2026-03-29 11:10:35.75+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4ec697cc-0170-4fbf-8f2d-b68bccb81149', 'ilmofino26@gmail.com', 'Ilmo Fino', '$2b$12$SiuPT2j8Ivf4JNZpnihsyOXMwitVxOIFLWYHh9vLCuPnqLxZVs7Ki', true, '6CXMTMOK2SKA', false, '2026-03-29 13:46:30.73344+00', '2026-03-29 13:46:30.733464+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a5ab5fc0-cad5-440d-8056-50cae232c1a2', 'alegrizy@gmail.com', 'Ayodele  Oyekunle', '$2b$12$NyrhHbrv3dRf/e4Ps74J7eKLxY5rZ5l5mRY/8oaqWSMwcTE/7mcKK', true, 'D994X9IUPRPN', false, '2026-03-29 15:32:48.459966+00', '2026-03-29 15:32:48.459986+00', NULL);
INSERT INTO public."user" VALUES ('c500fce7-d748-4f4c-92f5-0483f1b36245', 'edehk63@gmail.com', 'Edeh Kenneth', '$2b$12$VWJOk9buM1MJX/PKm..cZe9.CJRyOksqhL4oTeHx1JfFDTrXpCnX6', true, 'BDJGA3Y8Q9RQ', false, '2026-03-29 15:45:08.757646+00', '2026-03-29 15:45:08.757666+00', NULL);
INSERT INTO public."user" VALUES ('82dec985-de6d-48b1-b012-4dfe37763a0e', 'ge.edify@gmail.com', 'Grace Eke', '$2b$12$uLIwHD/RN9fJCqPMoUQM4uLap3wQEZF1wYy3b66I4HrMkETAZ4jEi', true, '1MBPBN5V0AJ7', false, '2026-03-29 16:35:14.441665+00', '2026-03-29 16:35:14.44169+00', NULL);
INSERT INTO public."user" VALUES ('26d17ba8-42ae-486d-b099-7467d29bb859', 'ajaykumarmuthuchamy2007@gmail.com', 'Ajay Kumar', '$2b$12$vueVymd13540NwHJOPZfYOQzhT5uvwOEuFc2BFj8yX5ezI3Rzgk1K', true, 'O2Y5VKLX82AB', false, '2026-03-30 02:11:49.280299+00', '2026-03-30 02:11:49.280317+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('03d922ae-5b1c-4978-8a8c-2da2c9eaf6d8', 'mm0728847425@gmail.com', 'Mohammad  Mohammadi', '$2b$12$/Q9aJ84fCLxSHrfSAlm1Qej/Be6V8H0HH94oMdKKICVZlB6Fqvcmu', true, '7K99U0AJXCJB', false, '2026-04-03 19:47:13.826032+00', '2026-04-03 19:47:13.826056+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f845ae6f-e222-40e7-8074-9ef3a5dcfd25', 'olalekanbakare10@gmail.com', 'Olalekan Bakare', '$2b$12$sd7pDV4EfIRgUyB5bq6IuOwfpB.eNlFgo809cHK5aNlrr2gmcoN5u', true, '8F9MC2XHQYLU', false, '2026-04-05 19:12:37.899532+00', '2026-04-05 19:12:37.89957+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('86493df2-6994-4ed0-8f1b-a25be5599c99', 'kafwembeben367@gmail.com', 'Benjamin Kafwembe', '$2b$12$PXtj6wSSTcvs/swpWKI8/uRXfCaTNaTeJxHnz9iQTkWpNKKN68T/a', true, 'HWTWDKF4N4JV', false, '2026-04-06 01:56:33.850617+00', '2026-04-06 01:56:33.850647+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5f48d678-756b-4370-bb91-086f34bb1223', 'myenigcina161@gmail.com', 'Gcina Myeni', '$2b$12$Ha0HSJ7UA/YIWc1kBUAcW.QrEEXJXxUjWFV8Ck4mcDlj4XVyjZS1y', true, '25NIGHQXAGHS', false, '2026-04-06 14:32:22.21208+00', '2026-04-06 14:32:22.212098+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5d48430f-1d95-44cd-abb2-0cf7fb92bbcc', 'mafuyaluke@gmail.com', 'Godfrey Mafuya', '$2b$12$eRzR.dqqx1jZdAmkamTEm.KCDY0rh0.gKOna1N3nvTgMvPhGHrz/O', true, 'VN4JRSA8SBHO', false, '2026-04-06 22:44:00.223962+00', '2026-04-06 22:44:00.223988+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3fb82e64-c87a-4e13-9c81-d3618309324e', 'skalehsk@gmail.com', 'Leornard Kabozu', '$2b$12$Z0njDqUuUcMzwX8Hus7R3OQdYqRlY/.XVocsyn.x4WbL4bUuS1rXi', true, 'F2V3Y8PBUI5J', false, '2026-04-07 13:41:15.988883+00', '2026-04-07 13:41:15.988899+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('982c0ede-a6c3-44ce-816b-97961a303ede', 'jerryjoepasie@gmail.com', 'Joseph  Pasipamire', '$2b$12$Yfgc92R4LnKTu5e5p.uXWuQ0c56Actu85OSX.ePD0RbKupKvQhAB6', true, 'B66ILLH8E5DR', false, '2026-04-08 07:53:55.474707+00', '2026-04-08 07:53:55.474727+00', NULL);
INSERT INTO public."user" VALUES ('77662db3-31da-4caa-8791-5e63006c514d', 'walterdeactivate5@gmail.com', 'Iyasara Walter', '$2b$12$/bLmFWnVjPRA/zLJLqZo8OLWH9oLvmqJ2oIBwahv/dkrWEfkvMeDW', true, 'LT019UB97PEM', false, '2026-04-08 19:21:08.295358+00', '2026-04-08 19:21:08.295383+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6e9533d9-7154-4f4d-b0bb-48f1f49c37e3', 'ajpandya2005@yahoo.co.uk', 'Arvind Pandya', '$2b$12$zm/KY7ug1YWNhBR4VlfC6.Ot7wO77mL/pLv1ji5zz7KR/AhTr7alS', true, 'MGBD7O4PLUZV', false, '2026-04-08 20:44:47.351205+00', '2026-04-08 20:44:47.351226+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f6b7ac31-af66-4339-a0b1-6cec6ca6695c', 'sherikafoster2000@gmail.com', 'Sherika Foster', '$2b$12$bhkDmo8s8sY9PS5UD96CBuC7QfbrlfoSVF5bZTthi2MqtOajNn6Eq', true, '0MHM6T4OA1L7', false, '2026-04-10 11:40:02.288202+00', '2026-04-10 11:40:02.288253+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('68271e34-98ba-4e7a-9bf0-b4608f0493eb', 'thatompye@gmail.com', 'Thato Mpye', '$2b$12$PQjXU5QcknWXZCfGS0SeJOnbjAVt4l8OjTAF4iDDqW9H8u8edIuHC', true, '4X6T5R22HLMS', false, '2026-04-12 07:21:58.410884+00', '2026-04-12 07:21:58.410916+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5ffecc60-7cfb-4d9f-b366-c3a676ff0447', 'tatendachuma24@gmail.com', 'John Chuma', '$2b$12$w76pbvmdUXdZUAVQJsCXs.3DaWE2buCyKItBWnaBKqro8rO2Kx8wq', true, '4CTR2HAMGR6D', false, '2026-04-13 13:36:26.690285+00', '2026-04-13 13:36:26.69032+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ec8c2684-9be4-47d0-82ee-efd288afc1fa', 'idugibsebi@gmail.com', 'Ebi Idu', '$2b$12$5WETJGYXAFECLSXRL6ROk.jbJP8jnFUfJmpTCmYPK9odOht.CrSTC', true, '24WBM2A4KS19', false, '2026-04-15 11:28:47.406987+00', '2026-04-15 11:28:47.407014+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bf4e289d-e48c-4e54-9735-20e9bae30b31', 'jayzmoore1@aol.com', 'Momoh  James', '$2b$12$HOOpQ21rwhAYhJSV2qcm8OPw4Kejg.jjsiTndKTVvffOau32ZTRRq', true, '7HE7FCWJ7OKJ', false, '2026-04-15 21:31:55.764598+00', '2026-04-15 21:31:55.764624+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('35888a93-bfee-48a1-8489-206858b93eb8', 'crasyads@gmail.com', 'Surineni  Satish rao', '$2b$12$XkzJPnlQc79QaJRx.AGir.UiN8C..qn3fhRqfwjmZew4bVA4RAokq', true, 'RXAGPZYB4QOP', false, '2026-04-16 16:56:41.446289+00', '2026-04-16 16:56:41.446326+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b2389bfc-4278-4335-a11e-f8b43f8951f6', 'michaelwhit777@gmail.com', 'Michael  White', '$2b$12$Cj1t.zIO4GBBs0RDLj2vSe0mXeqwoq0wNYyPg6vw.Xiic.IXswgwu', true, 'C5SICJOOUPG2', false, '2026-04-22 08:28:19.455451+00', '2026-04-22 08:28:19.455474+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('302e3357-00a2-4064-80f0-50e2984082e5', 'aarizkdot@gmail.com', 'Muhammad Tahir Shabbir', '$2b$12$st6I/iXpTy7r0EIDMqidr.ShJ5tHQRs7zEv/mANp82K.sExWqnMx.', true, '500HMDINHYMP', false, '2026-03-29 19:52:35.465774+00', '2026-03-29 19:52:35.465796+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('73770b01-1454-4df8-8717-691b21193af2', 'Chimaogbonna381@gmail.com', 'Ogbonna  Chimaobi', '$2b$12$vBAv8qkXHqbGXP.JCSMh8OaZvYPjxYscqRACEfPyihyXRmwB/FglO', true, 'P4WURHIVPE3T', false, '2026-03-31 22:00:57.410905+00', '2026-03-31 22:00:57.410921+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('56be700d-941a-42dc-b97f-4838fb2ec581', 'cihangir.kadyrov@mail.ru', 'Жахонгир Кадыров', '$2b$12$ZT2yB09J8HRl2/9QmNNxPOTpWLF1IHp.LsOR.C3MHQq.Ml0/ooReK', true, '4RRNM83BA3QQ', false, '2026-04-02 07:21:03.42515+00', '2026-04-02 07:21:03.425187+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('31dc20f9-1892-425d-ad9e-7aa2a26f31e4', 'adegbiteabdullahakorede@gmail.com', 'Adegbite  Abdullahi Akorede', '$2b$12$2DmG..XKwbketpnzGEizse0QP4cCUfCcA9f1cpmBxQ4TKdecF8foC', true, 'L09JK40PFP07', false, '2026-04-05 21:57:22.59392+00', '2026-04-05 21:57:22.593938+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7689c4fc-b39f-4808-aaa7-66cff98fcda5', 'khaleil25th@gmail.com', 'Khaleil Lowe', '$2b$12$Fhv/Z2rxnaw3z2ntJ63tVeSnfDCU/XkmKC.45BeRmEUEeEruW7EXa', true, 'KLUKSI98LDLP', false, '2026-04-06 03:26:40.206732+00', '2026-04-06 03:26:40.206757+00', NULL);
INSERT INTO public."user" VALUES ('59c49e7c-299a-4751-82ec-0e79f458a8c8', 'brahimaguous@gmail.com', 'Brahim  Aguous', '$2b$12$CWDXf5xDkpw9LRvOv3cdUO7LPGy7rSB0QT7hReYeEQVB25lYhgTL2', true, '70Z9QBDFLXO1', false, '2026-04-06 03:56:07.914279+00', '2026-04-06 03:56:07.9143+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3a5e5757-5433-4732-819f-4c19ca97022c', 'jagatihomes@gmail.com', 'Satish  Rai', '$2b$12$EYYgWBaDXWqhzIFDZ9DrvOV4D.hkQ.Ir2gRSAKYIw.WmUmkBcVHEy', true, '6LBPP26A9VMI', false, '2026-04-07 21:34:24.623641+00', '2026-04-07 21:34:24.623664+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('df4efed2-16b8-4de3-bce8-bcea3bf52baf', 'tanyam2ukona@gmail.com', 'Tanya Mukona', '$2b$12$fFn4UdbGkLC9pr8wN8pO5.ho1XjQNMQsKseyShrUIofszYPra8Fme', true, '224NQ1XSQ3DW', false, '2026-04-12 06:51:57.365278+00', '2026-04-12 06:51:57.365304+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a6f18a3d-7a83-4daa-8772-76b98e161846', 'hammadpelewura@gmail.com', 'Hammad Pelewura', '$2b$12$2X6BtLEHu7frp/H26vc66.WmQdkHjG96NJdCbekT4Wz0kNDhcjoQy', true, '3ZPX4NF4S7T0', false, '2026-04-13 23:44:03.983202+00', '2026-04-13 23:44:03.983227+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fa995b0d-e551-4338-b022-ecb0f3dc216b', 'abo2gomal92@gmail.com', 'Olatunde Abodunrin', '$2b$12$BaYGHSQfU6EA3SAHAgFZOe4a3P8cFhs3B/TyKb2Nx2R6WP9QLnTk2', true, 'OFI2VUSSKNVT', true, '2026-04-15 08:16:05.719712+00', '2026-04-15 08:16:05.719754+00', NULL);
INSERT INTO public."user" VALUES ('7c68be31-5203-4f69-84d3-1ff5b5b2ba0d', 'fuyanafuyana@gmail.com', 'Busani Fuyana', '$2b$12$jG40jOzEbSyELT.vPw1DEOe63Ap6xxt00A2RTcIXFZiBC/XlxU0a6', true, 'C79CNNALY4UO', true, '2026-04-16 06:24:05.804789+00', '2026-04-16 06:24:05.804838+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6f63012b-1a70-413d-a1ca-ed1dad213622', 'tanmayswain001@gmail.com', 'tanm tanm', '$2b$12$SdYkzMqUf5k0iYZ.ak3DCOQBq/o7V.42z1DdGfQjilN1xGuaH9n3O', true, '1K53Y8OJIAE7', false, '2026-04-20 03:09:22.937999+00', '2026-04-20 03:09:22.938022+00', NULL);
INSERT INTO public."user" VALUES ('02c18c97-8001-49bd-8e4b-622f8c4d1bc1', 'tadahgildas2@gmail.com', 'Gildas  Tadah', '$2b$12$I6YW3HarMgeBc.bXOUayY.UGmG7lm2awRXI7H2cwOaY2ABCBwJiLC', true, 'EDSMPJGZMMGJ', false, '2026-04-20 15:31:48.793413+00', '2026-04-20 15:31:48.793439+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e7c1bf5a-6531-4671-9475-e9836823429b', 'kennedyelughaiwe65@gmail.com', 'Kennedy  Elughaiwe', '$2b$12$IFo/R9hlBS3ERJyhqqGT8eHc3qrcNmQLELat2Kvn9Q5SZzOM5Hzuy', true, '2D4ZHOBF1110', false, '2026-03-29 22:50:44.570781+00', '2026-03-29 22:50:44.570802+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('871d84dd-8fc8-403e-b2d1-5a313a66a4c3', 'danielgrlavalie@gmail.com', 'daniel lavalie', '$2b$12$PVaialkk7LQWPlR9MyTDTuesX/wjyvSfqqJaEnImUPZzrgV8zl9lq', true, '387F6NYFJ4XZ', false, '2026-03-31 20:59:22.318137+00', '2026-03-31 20:59:22.31816+00', NULL);
INSERT INTO public."user" VALUES ('959a334c-f036-412b-b92d-ff27dee5a580', 'om293508@gmail.com', 'Michael Owoseni', '$2b$12$OZUQGh4DNwWjcaJwi0vB8O.9yrzUh4GBPpqkVqIjp.eXArBIR8.J2', true, 'DHK75GZPGXZJ', false, '2026-04-02 23:01:03.64302+00', '2026-04-02 23:01:03.643044+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('94cdefab-df60-48eb-ba4f-45b853aa717d', 'donaldbb19@hotmail.com', 'Donald Baukol', '$2b$12$80WV1GN/SVZJWROKaAlHK.mX126TCS9IDGvSZroNQ5eYOllZrNyhO', true, 'GMS5IJ96UYYD', false, '2026-04-07 18:04:02.577682+00', '2026-04-07 18:04:02.577706+00', NULL);
INSERT INTO public."user" VALUES ('74bbfbc3-5adc-4d85-8151-17f083cfe5fc', 'bigm43088@gmail.com', 'Big Man', '$2b$12$m9hpM5Qb6rwCf.Gw0vPH4ubsd6urFu3BNZ4TVyQ30uqHeslaplHgS', true, 'VX5OS7CN62MG', false, '2026-04-11 15:17:21.097144+00', '2026-04-11 15:17:21.097188+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f3e3ab0c-1b7e-4d65-a9d3-47db92c89c4f', 'fajarop09@gmail.com', 'Fajar Ullah', '$2b$12$BDCcFATAV6YZt7fdAslMoudz.NTH/QHqTCvFcXO2QH9opaT.Ymdry', true, '9IHFZBTLF7NC', false, '2026-04-11 18:13:19.653839+00', '2026-04-11 18:13:19.653878+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9c3802be-176b-4f81-9ebb-e8c7609440cf', 'damonfx1@gmail.com', 'Paul ochima', '$2b$12$GpDZL31vweMs1E2Bs1RIjeOrpWqTKl.IH911t6Mi739f/Xte1Dxki', true, 'FWSXPXUVH65E', false, '2026-04-12 00:27:55.928193+00', '2026-04-12 00:27:55.928215+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a51ce105-838e-401b-9623-dca34b3441b9', 'tedmotlapele37@gmail.com', 'Toze  Motlapele', '$2b$12$kbNIF2xsqVKQXKRqfyn1De/x2aeKGnzigD0Cap7odLPuE/o2GWYUe', true, 'FOPQN4MPW52P', false, '2026-03-30 12:17:47.526587+00', '2026-03-30 12:17:47.526614+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0d5ae581-8e32-4bea-8641-b4e75d890a51', 'onlytradeinfo@gmail.com', 'Amrut Kv', '$2b$12$w4z6otbHwkWMH2.pQ6v91uNTN6QlZbL0YMAQkFTbz9X/qnGVhDmJa', true, 'ZYNA9JOCQ30U', false, '2026-03-31 03:18:29.956814+00', '2026-03-31 03:18:29.956832+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0935fae4-1023-41f0-81c0-021e05e2a7f1', 'mm0728847419@gmail.com', 'Mohammad  Mohammadi', '$2b$12$nv8LfYT6ut/gye80wTvwbuSqxq5EneB4D8WPYSoVehxo8KqqFtzvK', true, 'IHKWEVZ9XCLB', false, '2026-04-03 19:49:26.265917+00', '2026-04-03 19:49:26.265942+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7d4616a9-6a29-428e-aafc-e3f37f560e27', 'phoenixbeatz4@gmail.com', 'Solomon  Effah', '$2b$12$4hXknFzhrTll/3miD8jlRunjepnjAWGVkdfbdYpCeGRmjJ7vV8rxS', true, 'FU8S8PQ5URU0', false, '2026-04-06 07:37:34.26126+00', '2026-04-06 07:37:34.261297+00', NULL);
INSERT INTO public."user" VALUES ('f7f43014-e70a-4ac5-97e1-9897efbdc0ef', 'praiseabelayoolaemma@gmail.com', 'Praise  Ayoola', '$2b$12$bs.rqIsz5x8YxgMEvMX1gu0SvlWp8gAE8CjcphuRKaelKyNkqlrJC', true, 'T7UOX83F6M8G', false, '2026-04-06 08:22:38.244515+00', '2026-04-06 08:22:38.244545+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9dfb00f6-cf74-4f9b-8720-e81d3e39832e', 'francisdarren253@gmail.com', 'darren francis', '$2b$12$MkVTi7tOL8IQPd7IA4A/1ubX1BPIha9250UpZ0xLQzKUwgOFRdJuS', true, 'JUARTBFQXEG2', false, '2026-04-06 14:55:37.015471+00', '2026-04-06 14:55:37.01549+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('358e237a-5b1d-4f06-a075-d639b77fe622', 'israel4king@gmail.com', 'Olaide Fadiji', '$2b$12$Jmv4VmpfNGLRoEke5mzmaOEbCzA.iytnHnwH0g2k7VBC.WPcITraW', true, '1BPUZ723NOWI', false, '2026-04-06 15:08:12.265854+00', '2026-04-06 15:08:12.265891+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('36dfeb0b-470f-4e8d-bc14-7d88acf66ef6', 'bbaseer05@gmail.com', 'Baseer Baseer1', '$2b$12$NGF57FXxORTo/ZdzS0lPmuy.ygCg0TDl5SZ4pr04zaivsu9uEtCM2', true, 'WZ4JU5TYAQ9F', false, '2026-04-06 17:41:46.044358+00', '2026-04-06 17:41:46.044381+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('976d0a64-a163-46df-8459-c70246991414', 'nokutendamhlanga@gmail.com', 'nokutenda mhlanga', '$2b$12$3ybM8KoSaDuO5X2knCbD3uZHKimvxb9q6o0zxwSW7LCOHv9jTAx7u', true, 'G8G0WJRR3A04', false, '2026-04-08 03:32:25.614062+00', '2026-04-08 03:32:25.614087+00', NULL);
INSERT INTO public."user" VALUES ('1993421a-da1e-4b10-9f5c-afc3d92aefbd', 'sean.mdonnelly@outlook.com', 'Sean Donnelly', '$2b$12$Xuuql4wLkooQxSdxBrsvm.IJCD3EZEq4qRnzHVuj2PXKnRZEyy9Ii', true, 'H5VR6X6GU7BT', false, '2026-04-09 06:35:04.876286+00', '2026-04-09 06:35:04.876349+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('49a67e42-6ce4-4652-930a-117544cd2e82', 'terriefarbbzss@gmail.com', 'Tererai Matavire', '$2b$12$q5Vjx0tyBO0gLUGOCmjbnOvc0.xzYo.WBru1mf.FpaSk5ixtbVbpy', true, 'YZ91DAI2MTTC', false, '2026-04-09 15:36:22.398174+00', '2026-04-09 15:36:22.398225+00', NULL);
INSERT INTO public."user" VALUES ('25fbeec5-bb25-48e2-8636-42b6a75a6ae6', 'scholars.seek2020@yahoo.com', 'Kenneth Wilson Emmanuel', '$2b$12$ltJIlTxUNrUx4j7KCBRXUelDrxU1D33OCVbLHggY.cFYzLbgA2.Yu', true, 'JY8QNPNOZ491', false, '2026-04-11 19:44:43.067955+00', '2026-04-11 19:44:43.067997+00', NULL);
INSERT INTO public."user" VALUES ('788204f1-e47f-4d5e-95d1-97ac91cc85d3', 'knoxmpofu37@gmail.com', 'Knowledge Mpofu', '$2b$12$d9qnt3eJsHaDY/EvHUAkUu3tbCRE/9H98yz5oYsA43pgbmUTRIQKC', true, '1J98F1SCMHDG', true, '2026-04-16 21:44:01.672146+00', '2026-04-16 21:44:01.672173+00', NULL);
INSERT INTO public."user" VALUES ('ae1aea80-368f-4dc3-bd20-8e7a809233fe', 'obandedestin@gmail.com', 'Destiny  Obande', '$2b$12$F/Kq5uGEvr/7YsbySZ9ZqOh/TSfsZ/RiGNLhNxutPCWK6z4ijcpSm', true, '37VDFUD8GHUI', false, '2026-04-20 17:08:22.341609+00', '2026-04-20 17:08:22.341635+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('60cdb8f3-b010-49e0-94f7-c98602aa721a', 'adekoyadebisi06@gmail.com', 'adebisi adekoya', '$2b$12$as5tQqaH3EQqzs3v4plvX.Gl8TouYP3K80yS.G38rO0U4YOluMk9u', true, 'LRB9UCHAEUE8', false, '2026-03-31 00:35:26.474445+00', '2026-03-31 00:35:26.474465+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3a2ea38a-44b0-477b-9218-4af059a6462c', 'wonkebe@gmail.com', 'Wondwosen Wondwosen', '$2b$12$981lE6SbjPOcpVnBG9kwHOL3PBMQYjamk12hDK0LGGnB0Swxsi9yq', true, 'EXTYEWD4VJUI', false, '2026-04-01 13:33:05.037749+00', '2026-04-01 13:33:05.037766+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2aa5b020-6f9c-4ec1-9163-c406f208b3f4', 'chrisdollarie137@gmail.com', 'Ifekwe udo', '$2b$12$H3aB8Pzg6uB/4S2RdSPSq.qd3qQqCopVi4RdtLCjEVmtf.5OPAroy', true, '6P9B6H4EPOQ8', false, '2026-04-03 18:51:11.280814+00', '2026-04-03 18:51:11.280833+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5f7d820d-26ee-4a82-894c-12572597640c', 'setherskine18@gmail.com', 'seth Erskine', '$2b$12$Bp8q75UtWf0TLEDScDH0a.SoVH/z5Jbb6vU53/jm9naBbW/NGEgX.', true, '0KTODD82457I', false, '2026-04-06 03:30:57.672646+00', '2026-04-06 03:30:57.672664+00', NULL);
INSERT INTO public."user" VALUES ('59b3c74a-b796-46e2-b83c-e62aa37c00c0', 'ranbrinth@gmail.com', 'Raymond Mazire', '$2b$12$F.gibSYW7O7js4Kajzw7.eWFStRcQNgaVf5a/0ZgWOv2PRb1TFqqq', true, 'P9Q9R30MI24P', false, '2026-04-07 00:47:45.230853+00', '2026-04-07 00:47:45.230879+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('79f159cb-439d-4d67-b018-eca66103f9b0', 'sellingpoint_123@hotmail.com', 'Prosper O', '$2b$12$1AqegQ.hig3cLvuYzDSXru3E1s08QhMJGod/ojWzjymdX6YSkaJXK', true, '26HLOIFD1UZ2', false, '2026-04-09 20:48:45.669574+00', '2026-04-09 20:48:45.669616+00', NULL);
INSERT INTO public."user" VALUES ('b92ce32f-a496-4415-9859-e4f8b76cd6ea', 'naldocast3@gmail.com', 'Bernardo Paulo', '$2b$12$22va/p425VEVklMsu0xqcOo0/NMfvnuN.ddMoUOKpBop3op3pllru', true, '2BKTXS2PUFEH', false, '2026-04-11 18:12:23.936143+00', '2026-04-11 18:12:23.936169+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ee48c02e-22f4-4fbe-98c0-eb051cb918b7', 'godswilledafiroro@gmail.com', 'Godswil Edafiroro', '$2b$12$bZxHYCQ43I/yU3JEb.nyouamN4TXzSXezdeD0hQg2tM2VCUb1SQ4S', true, 'WDF5269MNHN4', false, '2026-04-12 20:41:51.879246+00', '2026-04-12 20:41:51.879264+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b413cf7a-c153-47c3-94a0-d8ecaba7f777', 'kipkiruiweldon19@gmail.com', 'Weldon Kipkirui', '$2b$12$GCD9Zaa6YxPS2dN/QdU.6uWm/3THJeEfQVeRgHcL.tmJECjuO7j9W', true, 'R8F8O955V3A2', false, '2026-04-13 07:21:45.017311+00', '2026-04-13 07:21:45.017339+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('162df68c-c775-45c3-8b12-725b54096597', 'okirors24@gmail.com', 'Omoding Calvin  Jonathan', '$2b$12$34PKroRjIOePKKS6BuiRpOg/ovNPwKn1g3lz7K4dvCbEaqLOcmvua', true, 'URKMHP1L16TJ', false, '2026-04-21 04:21:41.881562+00', '2026-04-21 04:21:41.881589+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bfdde58e-5200-4b0f-b930-6ad7be5e5ad4', 'Mbsmax75@gmail.com', 'Bunyodbek Maxmudovich', '$2b$12$dIL048QRBs4Y4OaECfhDE.FaMOvK5qsCUbaruyuUfREUN2BtUfeze', true, 'A2OYC65PDREC', false, '2026-04-22 11:20:44.832135+00', '2026-04-22 11:20:44.832161+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('dc7aa91c-4c5c-4bfe-9510-a94805ce9441', 'elietradings@gmail.com', 'Eliezer Feliz Rondon', '$2b$12$mBCwIhWSM/21gkKM0U7tEO/MNmyLlRfXANXMStw.QfydBah0nQ5D6', true, 'NJT7CTEK9YNU', false, '2026-04-23 03:28:36.752194+00', '2026-04-23 03:28:36.752219+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2440627a-439d-415c-bbb3-8c2c4548d92b', 'foamark27@gmail.com', 'Mark Foa', '$2b$12$MmqdClBkwvpC3GW0ODoSA.AtM/dknnV4QpGD5xSsTgRg/Oxjj/OZ2', true, 'AEYY0XCFJMKT', false, '2026-04-23 17:49:16.558258+00', '2026-04-23 17:49:16.558309+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b32bfc3b-b27b-4d5f-a12d-18e7a85536ac', 'christiano3paul@gmail.com', 'Christiano Paul', '$2b$12$BGe9NsAtKgzrww9Hr/WhJuMFmTCRZwA9Xal978Xr3p2d2sH88xXFy', true, 'GL3X9T70DP5O', false, '2026-04-23 20:29:05.022704+00', '2026-04-23 20:29:05.022739+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8a84437b-8cfa-490b-b656-50f56356d4d3', 'danilocan17@gmail.com', 'Daniel Canales', '$2b$12$Ew3r/sR7rhAxgWKvDhD.AeJZ6pZQmU4XInjmj6cjYwIwnUyDvT1Du', true, 'RW6IU3KVCWD0', false, '2026-04-23 20:52:54.080681+00', '2026-04-23 20:52:54.080707+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6cd46496-761b-47ee-8347-199198d18561', 'lyndrengambi079@gmail.com', 'Tionge Ngambi', '$2b$12$vf4/czSs542hwNmwV/3mBuw.lA2Uw.L4KPRxFUNZs9oTGtXx4B.aO', true, 'XX7KC749UT5U', false, '2026-04-23 21:51:40.137972+00', '2026-04-23 21:51:40.137999+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1234f1c5-be65-4963-9cad-a9bb88f404d4', 'laminethiam@gmail.com', 'Lamine Thiam', '$2b$12$JQjBF1jHm3n.HSZo3xtbPOV95tSsZzozV5z/ijKAQIJbH1CtGk5DW', true, 'KMZQO7UMEETG', false, '2026-04-23 22:53:08.737003+00', '2026-04-23 22:53:08.737031+00', NULL);
INSERT INTO public."user" VALUES ('cfa90f9f-db07-43a4-98b1-729c2920b696', 'simeongilbertidor5@gmail.com', 'SIMEON GILBERT', '$2b$12$5mbz/nDSnLuM6lHGoYQ2kOgkgwaW94645TmB0.toz6Pkf2uglsy6O', true, 'NTRT2GEJB5AE', false, '2026-04-24 15:14:17.230854+00', '2026-04-24 15:14:17.230882+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('65337816-4751-4629-b875-fefaa64123bb', 'marimuthum74120@gmail.com', 'Marimuthu Murugesan', '$2b$12$gSq0O41nMhgJI68kfxowSugArIwOFwr//rv4dC47BEpV.8G2ToxAC', true, 'BIMUZO2FTMJS', false, '2026-04-24 17:33:00.866582+00', '2026-04-24 17:33:00.866607+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4abf2085-e2e3-4b07-af87-332693884033', 'nilson.amparo12@gmail.com', 'Nilson Amparo', '$2b$12$Q.L7DfmvjBFpo8cKwzSK0uooPYp5tcG6O2Y7Ud0U1ux7SOz9Ngkmq', true, 'QBIMI8FY8MYM', false, '2026-04-25 09:33:29.179428+00', '2026-04-25 09:33:29.179461+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bb24b7d1-8fc7-403e-bb8e-f38c302a5d1b', 'sanjaybandgar1781@gmail.com', 'Sanjay Bandgar', '$2b$12$5ZOc5kc4dF1TyrIcPx9NZuYeqZ33a6U6sf85kbwQAqMUuOpSex542', true, 'TZFBS2GUWDB4', false, '2026-04-25 15:46:36.602407+00', '2026-04-25 15:46:36.602451+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f98ec5f0-b6e2-42bb-a4cc-cb0168efb2a2', 'nagosadawit@gmail.com', 'Dawit Nagosa', '$2b$12$iPsq2dqLAK81nBmGpNTITeS/OUNdmGVHdmpBKDBEuINBH7FOsxOMe', true, '0JIU87M19D3U', false, '2026-04-25 19:36:58.270329+00', '2026-04-25 19:36:58.270353+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('753130a0-89fa-42e3-814e-f078fcfb1ebc', 'tinotareva12@gmail.com', 'Tinotenda  Tareva', '$2b$12$0BAvakZW2a.XFWHUOq9fKuQtAmT7GEbt4sZFOtL0Ko0JlISvnqXTu', true, 'PIYO49RI5F3P', false, '2026-04-26 01:44:07.207592+00', '2026-04-26 01:44:07.207612+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e81fa633-f58e-4190-9499-1ee85cfbb31b', 'cfaitshop@gmail.com', 'Babacar DIANE', '$2b$12$ckp8F5qkoDkrulp/imvVYe6m0Dt5Z38PVERRnYjcrR9mK9jMYZS1u', true, '9X2WU2BV5EZ7', false, '2026-04-26 20:41:28.837341+00', '2026-04-26 20:41:28.83739+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('59b3c662-4b31-4ffe-bda4-c27ba2fe764d', 'paulobour2g@gmail.com', 'Paul Obour', '$2b$12$UHXL54Zroz1SBGP3oZJuk.PHurKAQktE1dGVTVV7c0ZrDKNxeKtg2', true, 'TGYN7Z6SY3BU', false, '2026-04-26 20:44:22.637868+00', '2026-04-26 20:44:22.637904+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7e897775-525d-438f-88db-3f2894dcfffe', 'hassansalisugaladima@gmail.com', 'Hassan  Galadeema', '$2b$12$6DlR//KYX7Xh3sqFqGcQyurZrCgmt.Kw0EeVseLjkmSPDOtnrdt6q', true, 'KP77SEA9X67G', false, '2026-04-26 21:36:40.978055+00', '2026-04-26 21:36:40.978077+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('30988521-d0aa-4084-9a59-15d4ca122341', 'munasaryare44445@gmail.com', 'ABDULAHI MAHAMED', '$2b$12$0HDRzE69a6vMmwt9xBVYQOn/7wpOsPJng6/lLiwhM/dxrCYJXEYda', true, 'LENGUL0WASCW', false, '2026-04-30 14:04:37.169815+00', '2026-04-30 14:04:37.169831+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3de221b2-fc8f-4eec-be83-40316fb1d43d', 'johntemashah.jm76@gmail.com', 'John Macharia', '$2b$12$n5zuzn3.wVGwuEKhUt7N3eNrMcMxe79NYNbkY3qFHav/FQ8RhUsSy', true, 'VSUA3I5SXDO4', false, '2026-05-01 10:16:40.240609+00', '2026-05-01 10:16:40.240629+00', NULL);
INSERT INTO public."user" VALUES ('2d100fb4-1490-485d-876c-d42deb63e617', 'promiseobi2025@gmail.com', 'Monique Bester', '$2b$12$SariEoDxoVDLt/yHLNPUbuUsfaBoTFN5f5C0zhx0UxL70da6er9Ka', true, '1I2V5XW1PQ57', false, '2026-05-03 19:43:56.295566+00', '2026-05-03 19:43:56.295604+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3a013650-4dd7-4910-995e-b6e19f0a05a6', 'okorongujoshua@gmail.com', 'Joshua Okorongu', '$2b$12$3y1pfYvY8p.jfXVYioAm.O5ctP9FkXS2XCSB8CfCSx0TozmTcOgoK', true, '63W5CEYL629T', false, '2026-05-03 19:46:10.800213+00', '2026-05-03 19:46:10.800231+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f16d4730-d836-4149-b953-8be314b4e80f', 'leeld750@gmail.com', 'lee-lin davids', '$2b$12$.fhJnah5UCXYxuO7E7kdzulyLBteng/7hxp9OqfccC73a9z6oFnCi', true, '0PDM0Y7SOE7J', false, '2026-05-03 20:05:50.629012+00', '2026-05-03 20:05:50.629041+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bf1d3a8b-2ad2-46d6-8ce9-34b3d9ad3b1a', 'olubatoandrew5@gmail.com', 'Olubato Andrew', '$2b$12$fGhYetkE5f4a1vaqBIR1G.XH0OHpu5SXUTtxeoHaSWXxuB9KBZk5a', true, 'CL2BBDMM3AUP', false, '2026-05-05 06:44:25.909234+00', '2026-05-05 06:44:25.909255+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e64e05d1-d0e4-419c-8706-3671a6e1832c', 'gilbertkawimbe@yahoo.com', 'Gilbert  Kawimbe', '$2b$12$jo0iWjP9RFLn.oRm3Q7dUeGTqxqJNsUcC0bC8wZRC/nNG5hQUgntS', true, 'IEMK27KRM6Y8', false, '2026-05-05 19:44:54.997489+00', '2026-05-05 19:44:54.997541+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4aeeccd8-00e0-4c04-b103-fcd1226e9b91', 'blessingchihuri89@gmail.com', 'Blessing Chihuri', '$2b$12$wr9upBqMPXcmspZSipFdOeQpeI/uKtNzXqAivC9Wsc9HoZDx6AGLW', true, 'Y2AQ6DH9JPLY', false, '2026-05-06 12:52:10.232442+00', '2026-05-06 12:52:10.232475+00', NULL);
INSERT INTO public."user" VALUES ('b20b9541-ed27-4773-88eb-89def9da01b2', 'awiafejunior1737@gmail.com', 'Atta Junior  Wiafe', '$2b$12$xh9wdnCO8VBlYJNiVOe0HOK5BEMEPiMBsYE617wN37xc8rvl7XanS', true, 'E3ANMEVKDLTS', false, '2026-05-08 06:28:52.84108+00', '2026-05-08 06:28:52.841108+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2e885a70-55a8-4cb8-a47e-eed1ed8eb3e0', 'g01675276@gmail.com', 'Govind jadhav', '$2b$12$BxZu9L.KOMv4d1sGjaA2I.e75Bw/WbWlYNun6uAjYzSiNk5WrNFhm', true, 'OIPKSNO3763E', false, '2026-05-09 05:41:05.886661+00', '2026-05-09 05:41:05.886691+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('35d6a97d-0c2b-440c-b9cc-37933ecdb01e', 'abbynwatony@gmail.com', 'Anthony Nnaji', '$2b$12$juR5iYFRp0IbQIM/IPHCcOKQnyOWEPVSV995LY/dvZdNPBsOSYvZO', true, '7HKNMNSHFAY9', false, '2026-05-09 21:02:24.73311+00', '2026-05-09 21:02:24.73314+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1ecf6cc6-9de3-4b6c-9ade-3290b0e369d4', 'parmarshakti54@gmail.com', 'Parmar  Shakti', '$2b$12$QPiSq5fAQGphpVC3m9SCyui00yG6V.LWAHPX3KowkBPghwfDVn4uy', true, '3H0D8I753QEV', false, '2026-05-10 06:10:39.589494+00', '2026-05-10 06:10:39.589515+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('524dcbbf-96cb-4287-b952-8e1e0b8b155e', 'famousfruitful@gmail.com', 'ADEGOKE Micheal SUNDAY', '$2b$12$vsjkOZvO8XyFN9LqiRkI9.rQcwm1zzX83ha7D9Si2lD27On5wQEWC', true, '8JVBSZJMPS6M', false, '2026-05-10 13:48:46.080649+00', '2026-05-10 13:48:46.080673+00', NULL);
INSERT INTO public."user" VALUES ('de9f610c-b0cc-485a-aad3-ee31395d3272', 'shafique8355@gmail.com', 'Muhammad Shafique', '$2b$12$/5EU8nQxmzk9Qil4npkzX.bJEPo/2CQcZhzQRJVfeClW0aIIq4G9G', true, 'TLN9O7RYYF37', false, '2026-05-11 00:13:57.555996+00', '2026-05-11 00:13:57.556033+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('98d77b01-5e67-44d2-83a2-66d9dff93a65', 'gurvir101520@gmail.com', 'SINGH Gurvir', '$2b$12$gSiBVX.U8d3pdQ35/2Rn3.47/IexgwkN36xSlS0142I41C8SOR4RG', true, 'TALJNWJZI5N5', false, '2026-05-11 04:03:56.869868+00', '2026-05-11 04:03:56.869889+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2c044836-c66d-40ba-8bc9-22dc39bab51f', 'nwokoyechukwudi8@gmail.com', 'Nwokoye Chukwudi', '$2b$12$g0syn8j7ueeAiPYFQLqVPeMRUEycDHb2nfqE7qE9xTDm0nXDubq7q', true, 'VAPP6JWIASD3', false, '2026-05-11 07:49:11.660324+00', '2026-05-11 07:49:11.66035+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('30608326-8d07-4496-a1e8-6d3145cf5505', 'richbobby682@gmail.com', 'Richard Siberie', '$2b$12$3QpT1RipCF6TjgSSqG09Teje88CbtDQUYpzq7uhXlOj1tIvAUF6ji', true, 'XMJ8LYC7LONH', true, '2026-05-10 16:08:47.126384+00', '2026-05-10 16:08:47.12642+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('52ef8fdc-2d92-4064-9412-f47cad74d202', 'anthonybirch266@gmail.com', 'Anthony Birch', '$2b$12$geKN/gH9OwnaXfJRyPqAnueaUwXynTf3BjHOS7gXnrSnPTz7PuSTK', true, 'I2YYG6JKM13Q', false, '2026-05-12 02:19:26.428669+00', '2026-05-12 02:19:26.428688+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('336c28ab-db73-49aa-b6d0-56dd91420531', 'andyz_90@hotmail.com', 'Andrew Cronin', '$2b$12$Z8j0/t5W1KKNCov5R4U.BOyvm1uhE5yVx8BDrhkkfr/Otks2Ju6jK', true, 'GZD27G37TYWP', false, '2026-05-17 18:06:06.813891+00', '2026-05-17 18:06:06.813916+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6ceb66df-6123-486e-8cae-7faf12d3e61c', 'frankneo98@gmail.com', 'Chukwu Nwanneka', '$2b$12$XmfRpEDB8ArhH9giVTdRvuKJft9e/vmGiydEEmFxrnM7VtCA.ewF.', true, 'ZA6CRFB40GI6', false, '2026-05-17 23:49:51.328258+00', '2026-05-17 23:49:51.328278+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9acf5397-082e-40ca-80d3-51e23ab4d6e4', 'lestrader23@gmail.com', 'Lesedi Moakofi', '$2b$12$z86p3UbxQdnlDwKi/MnZ0Ok9QUzywbLuXndWpee/By75Orb5Eeno6', true, 'VD6AGEX6WDP8', false, '2026-05-23 04:15:01.077867+00', '2026-05-23 04:15:01.077891+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b69614f2-7707-4fac-9400-edc392b309ef', 'keisaabdimohamed@gmail.com', 'Keisa Mohamed', '$2b$12$QC7DWwK075Lf6EFQ7OhwLOd8Z7vJOgHYCj3k5Zie.FY8QhQBPvx.e', true, '7ZYSQSPF0V2G', false, '2026-05-11 23:45:53.339538+00', '2026-05-11 23:45:53.339564+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2b2700d5-798a-4123-8420-4ced66e7431c', 'callistussunny30@gmail.com', 'Callistus Adimachukwu Uwalaka', '$2b$12$XNrZfvrN9fo1dhlNechM9.Qwu8hlldhyUMJGynpfAR6OwU2PJjSca', true, 'CAEZ4LSUOHHV', false, '2026-05-17 18:53:38.879793+00', '2026-05-17 18:53:38.879817+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('83efc4f7-5aea-40a7-995a-b88f53eadc07', 'Kumarsuneel3254@gmail.com', 'Suneel Kumar  Suneel Kumar', '$2b$12$HvBxskW6f6uCfTlKMHjA9um1wKu.mmZzV3mnHnOxNTwbzppBw7wB2', true, 'CV75ZU9GE824', false, '2026-05-21 05:19:33.397085+00', '2026-05-21 05:19:33.397562+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('dec82e3e-1e4c-43f6-bc96-e3025e1d320f', 'kuros9754@gmail.com', 'Sainur Rosikin', '$2b$12$YpQnh.28fl2I1uu4qcbPVOW3iSJGlU6YbIFoOcJzFWYHeyn6uEGDe', true, 'OINSMVOIV3SN', false, '2026-05-22 18:59:34.163755+00', '2026-05-22 18:59:34.16378+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('25cc88d0-7c68-4a6a-beea-b7edd1377c7d', 'saheedow@clowmail.com', 'Saheed Owolabi', '$2b$12$E53WvK5KGOD.Lz7bbuzY3uEL9S.eflcwpb8Vf2dm/GjUbvQS2/2SS', true, 'USQ0MH2LQU36', false, '2026-05-13 11:41:16.051481+00', '2026-05-13 11:41:16.051517+00', NULL);
INSERT INTO public."user" VALUES ('a61e0798-ca5c-411a-a291-36ef7137a03d', 'brysonwilson66@gmail.com', 'Bryson Kantabula', '$2b$12$cpXUM3B.I81TSnDWvAoSBeWrSPHqqBUjHsC8vJ/4QiaNzjtX9m6DO', true, '299SBCLVB0RL', false, '2026-05-13 17:29:28.143259+00', '2026-05-13 17:29:28.143286+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0427670e-6c77-4c12-8856-cbb0ab698b22', 'semilooreleo@gmail.com', 'Israel Osapegun', '$2b$12$ndF6sc9FY7Scu6atwXbp2O45zT51CopcO24hUwZyLs3yc9ooUWMlO', true, 'XQS0CQKTM7X7', false, '2026-05-15 13:07:31.661099+00', '2026-05-15 13:07:31.661132+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6aa0f3e5-e16b-4b9f-89fd-2a6281517059', 'jessypavion16@gmail.com', 'Jessy Pavion', '$2b$12$yNUojakRtaJ3NkC0DRxHbO2If/vM7Lb6GyYpYh64giRwD4xqSBPZ2', true, 'ITEBRFB6R7HS', false, '2026-05-17 21:17:22.337371+00', '2026-05-17 21:17:22.337389+00', NULL);
INSERT INTO public."user" VALUES ('6bd925d9-b6b1-4519-928f-6855b0eab52a', 'ruibenja7@gmail.com', 'rui matsinhe', '$2b$12$6piNdoioJv6ztZiH3D1/nu3W2qZrf4DSxAdYDoltzhszuRwRDvaqW', true, '4I793NT7T61N', false, '2026-05-19 16:33:02.891923+00', '2026-05-19 16:33:02.891941+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('51bb9fe5-ddaa-4fc0-ac8b-46d4a3cada4a', 'anthonyalanepiu@gmail.com', 'Epiu Allan', '$2b$12$Xlyqpiq2JGPKewxanwjaBucLuM7xeFwqDH4AmpxutQc2pBzoOTGWS', true, 'FKXM4RWTQISF', false, '2026-05-20 11:02:16.342907+00', '2026-05-20 11:02:16.342933+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ac6b3139-472f-4a20-9115-5cd5ac7fe8fa', 'musa1muhammed3@gmail.com', 'Musa Muhammed', '$2b$12$ZtSXDNno.mQGLYjCMMLp/eUSJpAo5UeU4F01X5MuTt1YyGI1AAArS', true, '8VB7NCIVNXIY', false, '2026-05-23 19:28:47.314617+00', '2026-05-23 19:28:47.314644+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('45779ad3-ca5e-4b82-a388-06363bfa1e1b', 'ibrahimabideen200@gmail.com', 'Zainil Abideen Ibrahim', '$2b$12$XlpQ6v0o9KNqRM63kEKlfOYILfTihrbxDPd5qmEbA1hOuCZOKL2Mm', true, '5WVCHT52RF57', false, '2026-05-14 13:59:21.570548+00', '2026-05-14 13:59:21.570599+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7be4fb31-3a68-4ec8-a0ac-c42ed987be58', 'irerimartin373@gmail.com', 'Martin Ireri', '$2b$12$PV/EQj9DBvlgyWfRzaO2d.txQBgx4abRd/fDN1zy3Ey7KR0fPILE.', true, 'EVXB6MCUR4JW', false, '2026-05-16 19:10:02.229749+00', '2026-05-16 19:10:02.22977+00', NULL);
INSERT INTO public."user" VALUES ('4a6be98c-a071-4f5c-8b3a-53d4b76197e0', 'amantleyaone@icloud.com', 'Yaone Kelapile', '$2b$12$eisS/5zwCZWWdTsQzU6JvubnVaiDzFYzzIbk9zPF.TRqpIqi3XQM.', true, 'UMAR7GOG8C3P', false, '2026-05-18 12:54:06.182391+00', '2026-05-18 12:54:06.182415+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('34c0bbcd-51bf-4ff8-9739-885e1b0d1d7c', 'sachinkumar707059@gmail.com', 'Sachin  Kumar', '$2b$12$OJuxNuKpzmhk8/u/03frZemL4sB9xM/XOA2H2GdFBFBPagUOA1Bhu', true, 'UJK0TCNNLBEO', false, '2026-05-20 11:33:08.320337+00', '2026-05-20 11:33:08.320355+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('dc5bdf42-f999-45ff-8ca3-be9e34e2cdab', 'chitinipassmore@gmail.com', 'Passmore Chitini', '$2b$12$2OTVcwtEW0x00QMZJU.J5eRGBLEKW6W4MVW6wEvqaot1GmNknj3i2', true, '1U5NEA7Z0OGL', false, '2026-05-21 15:43:21.410407+00', '2026-05-21 15:43:21.410432+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('848369bd-4332-4d39-a562-a8911934c2e4', 'alfabet325nascimento@gmail.com', 'Karina  Dos santos', '$2b$12$hYtADNuOwdTZr72VVMR9kekF6MyUNTSxOeP6MNH9AHQwwwtTSAq6a', true, 'AD9ZOETEATIL', false, '2026-05-24 09:17:09.271939+00', '2026-05-24 09:17:09.27196+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5cce9c27-f653-438d-b4ac-0fa538e0ed7f', 'hunsumichael@gmail.com', 'Hunsu Michael', '$2b$12$b4PQw5S2D2hsVwv11CUgCuDqyq9yakXnC3aDkYEHlDPu1iOHmtyma', true, 'FJNUTHU90ZNB', false, '2026-05-15 21:54:24.840306+00', '2026-05-15 21:54:24.840337+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2945dbb2-d8a5-4340-957d-7c2030b75392', 'ak9276803@gmail.com', 'Ajit Kumar  Yadav', '$2b$12$O/VFGf/zlNdf9dYXdpF1X.iCRIZiUikhi9z7pU.m4vqD1f4gjac1K', true, '02STJLHWSDKG', false, '2026-05-16 17:05:30.408168+00', '2026-05-16 17:05:30.408196+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('458a5e09-49c8-4cb7-988e-5ef4f7017dd1', 'dagracaloide314@gmail.com', 'Loide Machoane', '$2b$12$1M9O1b3FXUk53MlDpW0sQu4/wdNMIDccgmDL5qvAsNKyJOz.Utwi6', true, '1K2HRT2WORF6', false, '2026-05-18 13:48:34.414191+00', '2026-05-18 13:48:34.414209+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c8c73549-83be-45f8-8d9f-ba0a5d356ba7', 'asanteprince002@gmail.com', 'PRINCE ASANTE', '$2b$12$UNDzhFth9gnz99pxLUr.DOqSJIGQcBM1dYpc4J49jkdzY1nE3OrOe', true, 'B43VV7O29DYS', false, '2026-05-24 14:29:23.449574+00', '2026-05-24 14:29:23.449596+00', NULL);
INSERT INTO public."user" VALUES ('eb4e144f-8188-42af-8492-ea48914c41fd', 'jeffmaiadamawa@gmail.com', 'JAPHET PHILIBUS', '$2b$12$GeuUZMYbyNtrJA.q7Wk6xOjNJFV8s4EwqjVERhFD845G/4t/ITRCy', true, 'DG7C24J52SOW', false, '2026-05-24 18:21:53.544515+00', '2026-05-24 18:21:53.544538+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ae86cebf-f732-42e9-9623-4d63431ff898', 'jhhhhv@gmail.com', 'Gyygggg Bhgcdx', '$2b$12$714qLmZBmBA5Z7ch9aBLt.XYl2RUbqM9ihP9kx5IkWYgjU1o1JHyq', true, 'O7QPGHQE6OAA', false, '2026-05-24 19:35:35.482262+00', '2026-05-24 19:35:35.482285+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('426f28ba-2164-4fc8-95c1-9537cd4f0c68', 'fastlastcool150@gmail.com', 'shafni MOHAMMADU', '$2b$12$QG5hKfHV9/Tdt6hO2Go1p.jSBJ.buwO4x0suq1hnN05FOeAXlyopO', true, 'U3MI3Y405FOE', false, '2026-05-24 21:42:39.411342+00', '2026-05-24 21:42:39.411374+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a1b2875a-6bf8-4c7b-9b1d-d20c2ffb6bc8', 'juliusmuramuzi86@gmail.com', 'Julius Muramuzi', '$2b$12$lZtsvwP8xv8i2h9goxMMQ./v6Nnx6locAPdUbg2hvIZflFKzEPaAe', true, 'UZLVB4JC7IV5', false, '2026-05-25 03:24:08.253104+00', '2026-05-25 03:24:08.253125+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('eda84c02-060b-4adf-911a-7a1a4790f3b5', 'umasorgodfrey@gmail.com', 'Godfrey  Umasor', '$2b$12$nLq9XI1UujcYNEzDxM/7XuL/QzyH3ymcMTAXqj8et0Z3IODcrRyMa', true, 'HCE80MBTAXFH', false, '2026-05-25 09:11:48.012094+00', '2026-05-25 09:11:48.012116+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4cecc156-9f22-45a4-b2b3-c1b0937811df', 'nasiraliyuabubakar021@gmail.com', 'Nasir ALIYU', '$2b$12$Q2P1te2izg8dvzh7BLfuTumH8DFQcxh3YKUcHJ7m8.A45vPaPJZdO', true, 'NBNEKH7JCXY9', false, '2026-05-25 12:23:51.376509+00', '2026-05-25 12:23:51.37653+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d8f1de5a-ca84-4dd4-aee9-1abf76fdb3fb', 'emusic20official@gmail.com', 'Sunday Eruchi', '$2b$12$665yMsEq427hMH8OYiFQTOIwVIitE9x2C.rfGwiry2EzJAswqtIAy', true, '2ZMFKXZCQDB5', false, '2026-05-25 13:24:24.510882+00', '2026-05-25 13:24:24.510912+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0a7465fe-50af-4536-a3ea-ca634a75cd33', 'jonieljonathan2014@gmail.com', 'Jonathan Joniel', '$2b$12$S1Z2Ktdyah6Z8tOd712Gc.Pj3QObxF9ZQxLtKMCWQpBumP0f1QBCW', true, 'FH5KN402X7AG', false, '2026-05-25 17:57:20.422063+00', '2026-05-25 17:57:20.422104+00', NULL);
INSERT INTO public."user" VALUES ('75112072-a12d-4ae0-82e2-26749e8bb296', 'christianavornyo250@gmail.com', 'Christian  Avornyo', '$2b$12$065pMOrlel6ANi.4W4u1hOfOirsxIp4dJapOsOKkXD2bcGzyS9Cxi', true, 'L9U7BZ6FWH7U', false, '2026-05-26 13:17:54.167458+00', '2026-05-26 13:17:54.167485+00', NULL);
INSERT INTO public."user" VALUES ('90d36588-592d-4ba6-8e11-c81fcc0a4d0b', 'adanugustave47@gmail.com', 'Gustave  Seyram', '$2b$12$SYA6EEuxUjHK4IQDlmF0uuNnD3qHSAFcXfyLnqNcsaWqO3.RRyX06', true, 'IFEB0X9CPTQK', false, '2026-05-26 16:42:03.519176+00', '2026-05-26 16:42:03.519206+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('eccb3452-6ddb-4e3b-bc5e-e615a704919d', 'emmanuelkaluba50@gmail.com', 'Emmanuel Kaluba', '$2b$12$/osD/NljigGPO8FkOEDmLu/.T0aTsHW/jSzft9wPtFgKBuwX7r7di', true, '0WT5VVKHGU2L', false, '2026-05-26 19:48:20.022023+00', '2026-05-26 19:48:20.022064+00', NULL);
INSERT INTO public."user" VALUES ('017fb619-f2a9-433d-a95d-628e5dcb923f', 'boubscamara@gmail.com', 'Boubacar Camara', '$2b$12$QimmONWxknd3lJ455tmyJOtqoXk4exzPGwt0ynkHpJ4mwVHPr.5wC', true, 'TV97W4ZPBBVP', false, '2026-05-27 00:47:54.689778+00', '2026-05-27 00:47:54.689801+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('68b673e0-47e6-45e2-8ba9-063c9c162f0f', 'baslb4903@gmail.com', 'باسل باسل', '$2b$12$pLbuFXd4j/HzfD697ta/SuWxbSUejdP4IbNCOME9LSymAvtB9w2my', true, 'IUGVLXVJY5IT', false, '2026-05-27 02:08:39.399177+00', '2026-05-27 02:08:39.399205+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('81f94bfe-ef4b-44df-93f1-a605ba7e7432', 'sandeepsingh1991navi@gmail.com', 'sandeep singh', '$2b$12$odt.73CTLnSsiOi5cnteIeHtenYGmYAY8QXpMTElIcDD22aBx.Pfm', true, 'M5JJSCG2QX6G', false, '2026-05-28 03:25:34.789194+00', '2026-05-28 03:25:34.789232+00', NULL);
INSERT INTO public."user" VALUES ('0fe01028-9776-45be-b1f4-bd97c052d0a7', 'sagarxettri61@gmail.com', 'Sagar Rayamajhi', '$2b$12$D4EYXXvNBQctuGiMUcqfmuM4BTwURGmwAFnYI1xu8QgTHaNXQWcs2', true, 'YBL5ZCD39OI9', false, '2026-05-29 16:34:13.350985+00', '2026-05-29 16:34:13.351004+00', NULL);
INSERT INTO public."user" VALUES ('783aca10-e857-4d46-a91a-c3bad2b036d4', 'gangadharchekuribitinvest@gmail.com', 'Chekuri GangadharaRao', '$2b$12$HIYnW8ZyN49ElZDcT9b.2OTNC2jOvQbhhmEIoWucNtJoqQGB2UgES', true, 'U5HXVUOHZXCC', false, '2026-05-29 18:28:27.917754+00', '2026-05-29 18:28:27.917774+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('99e3e107-4eba-4986-924a-fc22f311b143', 'yeyowep647@alf5.com', 'tuyfjh hcfrtxhuyjg', '$2b$12$mJ8VTsc7hGkoIMOdkLYW.ueP1sQXKAjvFo/1R0VwyjUL0YsJ9qSiK', true, 'YP10IZ941HV0', false, '2026-05-30 05:31:00.152275+00', '2026-05-30 05:31:00.152306+00', NULL);
INSERT INTO public."user" VALUES ('728325d7-983d-4805-af76-85fd4da281ff', 'gentle817166@gmail.com', 'Gentle  Fx', '$2b$12$dcSXlPiVMrHQp6aEoRz9KO0d3FapJZDJVk7aOO/zO5eCUTMgGAtKi', true, 'FPD6XRKQKBT3', false, '2026-05-30 10:27:31.936845+00', '2026-05-30 10:27:31.936877+00', NULL);
INSERT INTO public."user" VALUES ('cf1f115a-146b-4eb7-b550-d2de7b4ce315', 'parasharpushpendra96@gmail.com', 'Pushpendra Kumar', '$2b$12$zR7FyhHAncdHmjBLSeGSwuKIq8soSPSKxiMST8SyHNPZF5oE86b2i', true, 'WYSKFRG6YNY0', false, '2026-05-30 11:32:42.858864+00', '2026-05-30 11:32:42.858924+00', NULL);
INSERT INTO public."user" VALUES ('b0c51aec-3e04-4a42-bbb8-7a93754ebf93', 'noelnfor1@gmail.com', 'Tantoh Noel Nfor', '$2b$12$5Q2RdSD3.IiPttNH5ZjK2eS79fo.kCMzM6Q7/97ehYIvtbYld/jwO', true, 'N095Z34I08LR', false, '2026-05-30 22:46:17.530216+00', '2026-05-30 22:46:17.530237+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('70b0b5dc-9301-4372-844f-3767fb0dbe9c', 'ezekielugwu001@gmail.com', 'Ugwuagbor  Ezekiel', '$2b$12$jiiPfiGQPiF65f.2LfopJeslOkWbuSAMXmwdMzow/0adhiV7Qlowm', true, '8BK8137SXTKR', false, '2026-05-31 09:38:57.342117+00', '2026-05-31 09:38:57.342139+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('002cd1d4-cb73-4d30-a88b-ff4843b1350e', 'rusfandiwijaksono78@gmail.com', 'Rusfandi Wijaksono', '$2b$12$H406GzqJV80mhBUnb4ibM.b4RZH9xSWAJ4OBGwbHXc.TX2OH3pTam', true, 'XE92BA24RV23', false, '2026-05-31 17:29:56.548334+00', '2026-05-31 17:29:56.548357+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('15dcf75b-efbd-40cb-8717-6bb523cefeb5', 'shahrozhussain376@gmail.com', 'Shahroz Hussain', '$2b$12$U2pG65kLoRvZiB5RXn12FuWuQArdu4tqeA/IVz/XBs9QONNDR2Xyy', true, '2WSXHAW3397H', false, '2026-05-31 17:46:28.818976+00', '2026-05-31 17:46:28.819002+00', NULL);
INSERT INTO public."user" VALUES ('61f05846-ecff-4239-81a3-6cbbd83a9507', '12345qqqqeyddyd@gmail.com', 'Abdulaziz Amri', '$2b$12$UjgLmsnRmsp1BxENiKSlrOUzENmt3wnZPVN61TKF9jrE8rlW2PTY2', true, 'K7HUH4V5DAE6', false, '2026-05-31 20:32:24.059654+00', '2026-05-31 20:32:24.059675+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3d3950ae-0fd8-476d-95a9-a557766898a5', 'omowonuolaadebayo1@gmail.com', 'Omowonuola Adebayo', '$2b$12$rgwx0LGqaJSdqyyv3cI3dOvBCL61j4SQhQ/pFT7nWQw39RLAsNll6', true, '24N0C6L1FLKF', false, '2026-05-31 22:01:17.541126+00', '2026-05-31 22:01:17.541145+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2e8093da-5349-4313-9276-426229244691', 'malikrajay99@gmaio.com', 'Mal  Brown', '$2b$12$O4rMZW.fci/oda0OJgGULOcQ539yLTd16FBa1fvklST9D1juNtske', true, '80XTZXKIITOJ', false, '2026-05-31 22:55:20.44874+00', '2026-05-31 22:55:20.448756+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('50351699-8158-46b8-b0a7-a0c6986a9224', 'aymd019@gmail.com', 'Ayomide Adeleke', '$2b$12$1YxZlVEPzIJLXzLRemI4meN.rXEunlDoUS4eUv0t2Q.n4XJhLbMGq', true, 'DOISFFLI9T6D', false, '2026-05-31 23:18:32.438231+00', '2026-05-31 23:18:32.438257+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4f37c83d-2cae-44b4-943d-8e3ef3d22cc5', 'emmanuelabikoue@gmail.com', 'Abikoye Emmanuel', '$2b$12$6NyKySqsbUOK7fZPMH4tuOg0Kc5v6DZy4uddA7uPwDApzADjuCXsK', true, 'IXACBIQZ3GJC', false, '2026-06-01 07:48:27.215651+00', '2026-06-01 07:48:27.215676+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6a4d2799-9c20-41dc-aad1-1664d54c549b', 'davidadebola948@gmail.com', 'David Adebola', '$2b$12$ukAj3Anj0WM0aKxFKqCNVO5apYg7XGTXNgNRN0z30PXQ4mme/PuIq', true, 'F1ZFHAYUJSFL', false, '2026-06-01 10:47:54.604245+00', '2026-06-01 10:47:54.60427+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c93181c0-3f52-402a-a47b-0084e77626c8', 'jehuoffical@gmail.com', 'Takudzwa Mabika', '$2b$12$FWY8b4Lljs7dRsmqPyoEtesxUpDnCKcBsfJkpxsJ5PQ9k6OaWm5.6', true, 'N50MABAPKEAM', false, '2026-06-01 18:59:30.632211+00', '2026-06-01 18:59:30.632235+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c136b479-1849-4f56-b4d0-36912a25f0f7', 'kingsley1uleka@gmail.com', 'Samson  Mwanza', '$2b$12$aG8Uak3UBbcMAFhjBFESV.qtonPF6vdsvz/2fuSC6q.CXtbcrZp32', true, 'BOY5CNF1IN9Z', false, '2026-06-01 22:02:10.936811+00', '2026-06-01 22:02:10.936836+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b98801af-c8e8-4551-a099-4445870b9db8', 'omadeyeabraham@gmail.com', 'Emajake Abraham', '$2b$12$EXTVkqeLmIqGwkQKavyC7.QC1imr.FKNd7gccyVXPuVYIxvWFUuFO', true, '5QO16YL4ALTX', false, '2026-06-02 12:04:34.024824+00', '2026-06-02 12:04:34.024863+00', NULL);
INSERT INTO public."user" VALUES ('04723da5-7808-48cc-a9ec-afdd11e039d5', 'nayemmondal894@gmail.com', 'NAYEM MONDAL', '$2b$12$ttAMPJFzNmMQ9tQV8ikYA.A03GLxHBCpIqtkZc71p7vncqLUY//6.', true, 'U3Z3CK1SEPD8', false, '2026-06-03 15:23:13.399408+00', '2026-06-03 15:23:13.399436+00', NULL);
INSERT INTO public."user" VALUES ('dc442060-e1b6-47e1-8c1e-0342ae190679', 'kingstef718@gmail.com', 'Jeffery Fortune', '$2b$12$WsxjuHMUsu/kKo8c.399juvzg8YcmYIgcARVzLsnwv97Q1GbmyktK', true, 'CS9QPBK1ZPXA', false, '2026-06-03 19:05:57.326395+00', '2026-06-03 19:05:57.326422+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('97e4d827-7529-4b8a-bcf2-d857cbbd8819', 'ogodoevelynashinedu@gmail.con', 'Evelyn Ogodo', '$2b$12$nhF3afLh3j6W6lZOORlZJO0f9/iUf8Y0YRG44R77I2BnRFUsMbhlS', true, 'JAQ4TSUWE7N4', false, '2026-06-03 23:08:31.053396+00', '2026-06-03 23:08:31.053422+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bbdb815e-aea8-41e7-8c1c-84398acb35c5', 'ogodoevelynashinedu@gmail.com', 'Evelyn Ogodo', '$2b$12$A5iRFJam3KK6z2R2mXkrdeeiJvSX9oEqWkVts9nUFbIFjyhPyfsHO', true, '8F36EJG7SI8T', false, '2026-06-03 23:10:34.837225+00', '2026-06-03 23:10:34.837249+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c49251f8-2d7b-473d-8da7-5c20f2a31cbe', 'aka.patrcik@gmail.com', 'Kissi Guy Ange Patrick Aka', '$2b$12$VSjVMHGecVfi9t.Hyiczg.6b.9pYlOHDRhryfZGY4ZBFBwRLWYJbq', true, 'PISGGG3W0JCC', false, '2026-06-04 02:43:41.514456+00', '2026-06-04 02:43:41.514481+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a6de5d41-09c4-4410-8d15-59d52fdf2475', 'mjezbeat@gmail.com', 'Mohammed Isah', '$2b$12$gqeMxFtCxT9mujx1CJzDQO8LnUn7GX.Ynf1YZu1Km9Km.h/jj6Yde', true, '2D3SCTNHV9FB', false, '2026-06-05 01:37:56.751942+00', '2026-06-05 01:37:56.751987+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('81c2bbed-2e20-4298-9cf7-0c1b172d3cd9', 'MasibuleleN@icloud.com', 'Lina Ntantasane', '$2b$12$5SXoPrGrFY2DVjFsWPx9jebn9o/52SEAGtwEnbeC4a3Z3nUL2CDoa', true, 'M4KTP9BZ5DKZ', false, '2026-06-05 12:59:59.503307+00', '2026-06-05 12:59:59.503328+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('59e585ca-2b79-4bc9-bd6d-8fd070b65fec', 'uthadotey0@gmail.com', 'ADOTEY  JOSEPH NII ADDO', '$2b$12$SjqbFwX2eXp3ZeCWU4VAe..PnjOuTv9mhVeSYgiS6KPf.4v2NE7Ka', true, 'SZFXRAX0P5ZJ', false, '2026-06-05 16:09:54.949601+00', '2026-06-05 16:09:54.949624+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('75302015-7b68-4ea5-8608-666c2a16b7a1', 'aremuolamide415@gmail.com', 'Aremu Olamide', '$2b$12$OCKZdVWSuc1W9Qg0Dnna5up3KSCPQBfI/jd1aeU1EJuJsLIxONTJ2', true, '5FB042ANQVDK', false, '2026-06-05 16:16:36.697317+00', '2026-06-05 16:16:36.697347+00', 'MrP');
INSERT INTO public."user" VALUES ('eb349aa4-b376-4204-b7ce-70385453a4b9', 'shikongo84@gmail.com', 'Thomas Thangeni Shikongo', '$2b$12$8tfUuvjemMJghUCrtgL9VeLhDkpoHQD6T0D1AAibrnutxvTYAjjky', true, 'ESX6ZHK38KXK', false, '2026-06-06 20:04:46.883913+00', '2026-06-06 20:04:46.883937+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('886fb5e2-4fe5-42f6-85d1-128d8eded25b', 'frederikandeunice@gmail.com', 'F R', '$2b$12$h3SpEc2RH0xjG3b6ffRCy.sV/aUqazaztELP1mJoxMNoLkH3Lkytu', true, '5QBP7ZJ99LFY', false, '2026-06-06 21:17:06.378527+00', '2026-06-06 21:17:06.378552+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2534a41d-bac9-42c2-a32b-2f036b194dc7', 'christianbrayan656@gmail.com', 'Brayan Christian', '$2b$12$a5goCBZnpWnuX/kQwYdxh.HAuV1.4dOs20a8zAggXrCMNPaHMKoam', true, 'I5QXCXMBQ88Z', false, '2026-06-05 13:32:41.140125+00', '2026-06-05 13:32:41.140158+00', NULL);
INSERT INTO public."user" VALUES ('36e8ec1d-841b-4101-b596-569a7badf35d', 'samuelmatavela80@gmail.com', 'Samuel  Matavela', '$2b$12$3InXPonmx43VbL8lEl7BFerX/EMULmNpuwC7Zcbx0o0.C7dRKQsDW', true, 'W5MYCMEIHHGZ', false, '2026-06-05 15:34:49.842539+00', '2026-06-05 15:34:49.842569+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d7a8b7d6-7bfa-46df-a69c-c4fbaba27bc1', 'mphatsopanja164@gmail.com', 'Mphatso Panja', '$2b$12$baSvYPFfqj5hYXvroGpipOJPGQ/GcLvtF4Pcb8zjG8XOUDDw2GTau', true, '9N0F1F1BB9AS', false, '2026-06-06 10:40:50.244524+00', '2026-06-06 10:40:50.244548+00', NULL);
INSERT INTO public."user" VALUES ('67bd1c4d-888d-4b4a-bb52-c8e461e8fec0', 'ykalyango@yahoo.co.uk', 'Yusuf Kalyango', '$2b$12$ymcxh4MPG5EGtxVHYkaxuuGBf7jDYYhR8rTeHUtAiwlRTJ5SXQnUO', true, 'VMFH64B03DCK', false, '2026-06-06 19:42:57.183531+00', '2026-06-06 19:42:57.183549+00', NULL);
INSERT INTO public."user" VALUES ('4ac64f55-c79d-4b2a-b82e-0b127b6eca59', 'anyulalinakala01@gmail.com', 'Ryan Anyula', '$2b$12$93H65PMm.rjWsquTfLMSpuUNOdWht6WkCyD4N1pvbaR53tl9/g4q6', true, 'LTO3FA5GGR9A', false, '2026-06-05 19:07:00.990558+00', '2026-06-05 19:07:00.990584+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b2491a47-cc7e-4104-a68e-9be0fe7bf9bd', 'fernandoeugeniomacuvele@gmail.com', 'Fernando Macuvele', '$2b$12$093Hv954BUgusq/vl0/x/.8/MlUXykg3VUh2xqAzZ2.l1OO6eLdpG', true, 'P7PML3T2DYBM', false, '2026-06-06 13:58:28.947069+00', '2026-06-06 13:58:28.947092+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('67bb2cb8-eea7-4e0c-8490-7cf903939be4', 'manuelbanskey@gmail.com', 'Emmanuel  Ogbonna', '$2b$12$6G9o1Vfq4MZjnDdB4VTGQO6vY1VxcfhmHgJwU.d9RmuaRrPivGXDm', true, 'M50SQ54QKHRH', false, '2026-06-07 00:30:51.483009+00', '2026-06-07 00:30:51.483059+00', 'GRACE');
INSERT INTO public."user" VALUES ('025c7431-69b3-41c4-8555-de1395f7ae92', 'josemonitize@gmail.com', 'Joseph  Balogun', '$2b$12$MULGCS1MHkGK6ExdzNea5OD27SuGs1oS178RnFAvXV6Z6R87bcGZi', true, 'V1YVEFW8WS7B', false, '2026-06-08 00:57:58.154303+00', '2026-06-08 00:57:58.154331+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b6bc5f9d-8790-4ac0-bf74-9ddce9949c7a', 'chisomnwali027@gmail.com', 'Chisom Nwali', '$2b$12$Uno20UvMt.i5be/aXBhlHeuIPj7w4KrJqIcQQXHNnHPNVxsYPZKna', true, 'KV6RP0IW7W6M', false, '2026-06-08 15:17:29.518585+00', '2026-06-08 15:17:29.518612+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fe8423fb-f68c-446b-b098-49d09d3a7959', 'bethelsharon44@gmail.com', 'Bethel Sharon', '$2b$12$dsvDYT2k1pkLVFGTLULF1Oql7zA87cUguETrRt/wqIJ.h7nB.EXr6', true, 'ICM7GUIPT3M6', false, '2026-06-08 17:31:44.472038+00', '2026-06-08 17:31:44.472064+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1040ed3b-deab-4228-8ed5-7505feb22e5e', 'yanshking13@gmail.com', 'Yanshu Sonker', '$2b$12$Gdp4jnO1O.gthKWJltdR2./YJJl.GaeRC8WfHBroN7ePboAby1XP.', true, 'OLFM907K5GT1', false, '2026-06-09 11:24:36.583855+00', '2026-06-09 11:24:36.583946+00', NULL);
INSERT INTO public."user" VALUES ('012d4bf6-48da-4b1f-9134-a579ac6cdeb4', 'dinkohafeez7@gmail.com', 'Hafeez Dinko', '$2b$12$7XqtwEHsjoQCwu3hLoJPoegNiaUgjCsyVMoJMEM2uPEGG0E28nEAq', true, 'R77Y8Y9KHSVI', false, '2026-06-09 13:10:31.746786+00', '2026-06-09 13:10:31.746813+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9213f9f2-cc9d-4443-b604-5320aaef211d', 'ibrahimkalokohforex@gmail.com', 'Ibrahim  Kalokoh', '$2b$12$Po4iFB7ju69ECv.ROdIHLeSERcxFIq28RWwB.gOZw6aWT8QyaCFWK', true, 'BDUIYP9V75GX', false, '2026-06-09 15:27:28.308075+00', '2026-06-09 15:27:28.308233+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5fa8765f-2f6c-4a45-a472-11bf285f1ef1', 'eie46807@gmail.com', 'monish roshan', '$2b$12$fcfpyv0vgqVEs6CEhSr0q.ZF.X/uJzOFoFcW3Ntgific8JnCRTwfS', true, 'RCIFAVVCKOZ2', false, '2026-06-09 16:24:11.960812+00', '2026-06-09 16:24:11.960841+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('62bd4ba3-30a0-45d8-bb26-7a8f6788304a', 'sianmanjot9@gmail.com', 'Manjot Sian', '$2b$12$rzbSVmSZTbcIS0KpOSt5duD.aJCUjL3hQeTKnmH/gh5UUO6Ulke5G', true, 'NORN3BIDCYAE', false, '2026-06-09 18:05:45.716744+00', '2026-06-09 18:05:45.716768+00', NULL);
INSERT INTO public."user" VALUES ('6a2a33a0-99ff-45a3-916d-fe08e11f42df', 'mohdaslamali4354@gmail.com', 'Mohdaslam ali', '$2b$12$TjSjmdGu8Low9iQkK0S5AORNjJJfBrS7YyM7VWqOoWC6FRBu1swpO', true, 'CWL6N11FM9OS', false, '2026-06-09 20:22:23.247275+00', '2026-06-09 20:22:23.247295+00', NULL);
INSERT INTO public."user" VALUES ('0f46b235-2c1f-4f99-87d7-e5aef26c4046', 'rkmahto1@icloud.com', 'Rahul Kumar', '$2b$12$pIgDHzet3F1pGed9H8Be6.UVKgtq/stwO4zmrBnEbVlBGbvyQrR.C', true, '6K7RHEH3H88Q', false, '2026-06-10 14:28:12.252248+00', '2026-06-10 14:28:12.252286+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0769a809-5aac-4544-a228-084aeddc3168', 'omyadav8283@gmail.com', 'Om Shankar Yadav', '$2b$12$MgGK/BZ2sLZv4yTYOdHSTu5zBnX6n7xWAPJTHIReAdDmuCjiWKhTO', true, 'VSSUKQXNEIY8', false, '2026-06-10 15:34:31.330944+00', '2026-06-10 15:34:31.330962+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('55af015b-c2de-4b6c-a312-079a927d133d', 'patelsiddharth8238@gmail.com', 'patel g.', '$2b$12$zsOpaN.T7tXrx9dOEQmDsODMbYa0j2sN6XjSCNfZtZYC1Jh5QaOl2', true, 'NOQ9ANB692YA', false, '2026-06-10 19:23:11.496395+00', '2026-06-10 19:23:11.49642+00', NULL);
INSERT INTO public."user" VALUES ('e2e68b1f-1985-47af-9718-f0cab1d0aa31', 'austinamiemba@gmail.com', 'Austin  Amiemba', '$2b$12$13hd0QGvZwDtluI.D8wJ2eNLOJa19aBZiWhnkxw.jB1LDhUeCyOpi', true, 'UPUO03METVET', false, '2026-06-10 22:38:22.839409+00', '2026-06-10 22:38:22.839433+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c65b3f0a-fc4b-4cc3-a4be-d5816ffc76b7', 'peterbeshel94@gmail.com', 'Peter Beshel Utubakwu', '$2b$12$easOgZxQKQx0RFV1Fkdw7unIl9EKxlXf6wPukCOz13Ph6GEsM/lpy', true, '7GOW2MH7FZK0', false, '2026-06-11 17:41:57.133318+00', '2026-06-11 17:41:57.13334+00', NULL);
INSERT INTO public."user" VALUES ('69ecfa10-7252-46bc-bc6a-8baf9806be94', 'prashantsingh00112@gmail.com', 'Prashant  Singh', '$2b$12$U8arOW8zLb7Iq.rTpJVr2eUY8gaTSfylG/NN.rjN0m8BXxC6NrgXa', true, 'JXT46MLJW9V8', false, '2026-06-11 19:54:00.183117+00', '2026-06-11 19:54:00.183156+00', NULL);
INSERT INTO public."user" VALUES ('ec0ba140-26f5-41bd-b27f-e4f69909f600', 'ironbarroxanne@gmail.com', 'Ansa Ironbar', '$2b$12$rg2e0gdbrdOOtELObhtp..hwqu/oP9LqAKFKv0hYxJ1wT2YpC6YGm', true, '1C39BM1YBBHH', false, '2026-06-12 07:13:28.877551+00', '2026-06-12 07:13:28.877584+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d7a308ab-e4e5-4515-b232-559597d2d540', 'johnmagara06@gmail.com', 'John Magara', '$2b$12$Linzz2GsMhK4sSzRbpw/7uzM0cq4bABg59wWv7yk.D35kZ47FCqRa', true, 'PQLRJ6PMOXY8', true, '2026-06-12 18:03:43.464647+00', '2026-06-12 18:03:43.464685+00', NULL);
INSERT INTO public."user" VALUES ('7b5b9118-416c-4032-a0df-14f99071ea32', 'enowhns@gmail.com', 'Success Enownoh Effim', '$2b$12$WoXJHAz1atUucDyHcS1f1eax.b.G.MJwKZlioZKEqcEsd9m5XEezG', true, 'UH51HB4QWXBW', false, '2026-06-13 20:38:43.882006+00', '2026-06-13 20:38:43.882033+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fdb26b99-ecd7-4c46-88ae-8464b5336f52', 'droy86799@gmail.com', 'Dan Riy', '$2b$12$nv21UcAns42.hppdmAj/NuL2Yybeszo8UaHYIrpT1D2dFUa9rFbyO', true, 'E9Y1L64TCXTD', false, '2026-06-14 19:56:50.700476+00', '2026-06-14 19:56:50.700499+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a2eb8e4d-d9d3-46b0-8792-217d3d71273a', 'princelydee7@gmail.com', 'Dan Roy', '$2b$12$ZpbqlzYnmE/6ZMhHzhvyUOREllS44dH7QX7uOxQL21fZ7k1hCkrmi', true, '1HOCSAQA4TT5', false, '2026-06-14 19:58:18.619207+00', '2026-06-14 19:58:18.619234+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('60713359-ffc6-4bfc-9e4f-389a113f3f1e', 'mustaphajamiu084@gmail.com', 'Mustapha  Jamiu', '$2b$12$YKraH7kdFeyNF51ci5VZkOK7qIB0sDnVZ/n3hkT1nBo9LouhurmDq', true, '6ERPQBVX10KI', false, '2026-06-14 21:43:12.411804+00', '2026-06-14 21:43:12.411843+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('212fe5f4-b479-4ab4-93bb-96aafe8db000', 'mhdmunavvar11@gmail.com', 'Mohamed Munavvar', '$2b$12$bHVIUY8VfCYsSRc9WuomlOnKG/D45FDyaZoGi9IXFJ.cCMGk91F0y', true, '5RVBDMTE9RQB', false, '2026-06-15 00:39:11.734488+00', '2026-06-15 00:39:11.734512+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('31df3ce6-8cf9-4d4c-8d18-d6cc4f9e1438', 'navinsirsat735@gmail.com', 'Navin Sirsat', '$2b$12$h6C0GaPmfZhbaTiE50RUXO94HCB0UzbkYLQPn/gZdZXJUOLY6jBAG', true, 'U4EC75WJ47CC', false, '2026-06-15 02:57:37.757326+00', '2026-06-15 02:57:37.757357+00', NULL);
INSERT INTO public."user" VALUES ('d072b3fd-79f2-4d08-85ad-7e3ea8fc248c', 'kudziewatson@gmail.com', 'Watson Matyarufu', '$2b$12$GR6ImALgEqyzKXrX71g/2OJeYywKZawMaULGOBJLn.tj/JSdsFd7a', true, 'G5F165OUDA3H', false, '2026-06-15 03:15:34.794495+00', '2026-06-15 03:15:34.794519+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('226112b2-d17e-4552-a5fd-6de0eb1eeb8d', 'mc3400901@gmail.com', 'Manish  Chauhan', '$2b$12$pMwWxHBzmtPNPIVvcFmpjODqGKHx4rpvFnf3yljIVhpkiGKLwIhQ2', true, 'KT99NJO2TPPY', false, '2026-06-15 03:34:23.810303+00', '2026-06-15 03:34:23.810326+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d13e0d53-a9a1-4e0f-8156-99ebe5b57326', 'mcag061@gmail.com', 'Manish  Chauhan', '$2b$12$qsXEVH5VwebLhV.wSzgSlOUpt3qdycAQY0n7Cha2RBrfXu7RLIYyq', true, '5QJR01E1S4QA', false, '2026-06-15 03:35:12.366965+00', '2026-06-15 03:35:12.367009+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ac9b5014-5f97-4528-8beb-8982c2e1685b', 'payodeji387@gmail.com', 'Ayodeji Akinbola', '$2b$12$BS0BuK3UILsuXJrYuGP4e.PWc4WkL89KeeUd0LMRbh61xTbdOEb6O', true, 'SA84APWD7BKW', false, '2026-06-15 06:05:49.065934+00', '2026-06-15 06:05:49.065966+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('54b8b83f-df68-4411-9cab-0d870b3bf409', 'nfatoye22@gmail.com', 'Noah Fatoye', '$2b$12$SF.qy/q.JHneOo8mpgTdgup2WwYk82t3AzDnT0Kv3.AaDnccyFekC', true, 'N70Q3IKK0OOM', false, '2026-06-15 14:37:39.843164+00', '2026-06-15 14:37:39.843213+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c650a86b-2ce6-42d9-bd2a-a1aab7f95ab6', 'franklinking479@gmail.com', 'Valentine eze', '$2b$12$APrG6OUBYgkZbStKBxTZHeK9MLYVTyR4TcAyLSVi6fqiyxtYwnk1e', true, 'G69TRHTRNL4K', false, '2026-06-15 15:09:44.153138+00', '2026-06-15 15:09:44.153174+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('563bbcab-9836-47ff-83ae-e63c2716f5dd', 'ifeanyink3@gmail.com', 'Ajah Ifeanyichukwu', '$2b$12$cna7AfSC.DQttRlff4/O4e.bOZfV8hJFrodgJi6gd0WpAQq2lRda6', true, 'X8SLAVJLN67L', false, '2026-06-15 15:18:37.04829+00', '2026-06-15 15:18:37.048319+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('365f03ea-7ef9-49da-997e-9e90b515d9c6', 'khatridwij0204@gmail.com', 'Khatri Dwij', '$2b$12$lXdu81W0m.Lt5XVjfYI5Eu72Tp0X0Oqn/20MXkvg3iN9.8eKZrd9.', true, '9SQ5NQUDW3VQ', false, '2026-06-15 17:35:51.755631+00', '2026-06-15 17:35:51.755672+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fc50a8df-40e7-41b4-944a-4d7af260636b', 'okepatrick555@gmail.com', 'Peter Patrick', '$2b$12$dKe9c4YX5CG0TJf/iuYR2ukSD3HW48oTFt55bepGxYAE6cvQ44u1y', true, 'EUB8C4UZT4PE', false, '2026-06-15 18:04:33.975856+00', '2026-06-15 18:04:33.975894+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bbbd343d-2f7b-4466-ab2f-e6fd908ba9fb', 'nma4luv@gmail.com', 'MIRACLE CHIDINMA ONYENERO', '$2b$12$1hvul.b9D.tA5DNFMLOGGueENj3XqtXB5JEZIbzMhIDTVzxTHLEky', true, 'FI1QICRIRCJ9', false, '2026-06-15 20:51:07.277214+00', '2026-06-15 20:51:07.277239+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c8f76d42-be95-4e3a-8184-36dcf7af13e8', 'Ajibolaimoleayobami@gmail.com', 'ajibola Imole', '$2b$12$IUEUljv0uz.0YLNdjW2DbuqmNHLRfKLKfLKqa6S8zS.msYP.zpNKG', true, 'BBSC9LRWRZPJ', false, '2026-06-15 21:25:13.823754+00', '2026-06-15 21:25:13.823806+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1a761cd2-4959-46dc-a116-4b936fd6a0b4', 'igicwacoin@gmail.com', 'Dushimimana Aime', '$2b$12$5s8RtEhyi9Yu6o4HBrBx4OqUyTGQFhPSTHQ9XhgWw2TiNfG5GsmY2', true, 'XF6FFUXVMTF2', false, '2026-06-15 22:31:24.676036+00', '2026-06-15 22:31:24.676086+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1876170a-6e90-4d5d-9ec3-eed79f13489f', 'fabianchukwu5@gmail.com', 'fabian chukwu', '$2b$12$rV61gOWkfY1CIwDgCo7qfeBo8hGu7sFdZIQCvB76WIKBERjHdPlhy', true, 'PC6LALD3VQB4', false, '2026-06-16 15:20:56.396856+00', '2026-06-16 15:20:56.396878+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('59017d84-4d03-4630-aa13-e91f10e3ee63', 'peterthankgod747@gmail.com', 'Peter  ThankGod Chidalu', '$2b$12$kB82IPl06.mglB1rsD6DD.etTKKuUi8r4wvaelguFDEQ.q6kcIw6u', true, 'X91ORYV7FU2O', false, '2026-06-16 19:58:16.681622+00', '2026-06-16 19:58:16.681659+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('05e71865-961f-491b-953f-3036b6bffd8c', 'innocentcharles808@gmail.com', 'Innocent Charles', '$2b$12$PaHOibKA8FIg7DLog8dVYecU4siKB0t0YXJoHg7Q9vbIq39W4/v7e', true, 'BCVK4BSAJS2D', false, '2026-06-16 21:05:19.818685+00', '2026-06-16 21:05:19.81871+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('530570aa-647a-4811-aa58-242ab0ca985d', 'bellomsean@gmail.com', 'Oluwaseun Bello', '$2b$12$F35US6TV6hpZlH2A0EciLulw.DmutOPZHWQp7q.gV0SczIE6SrQd6', true, 'MSPZ3XYSOAQA', false, '2026-06-16 22:44:33.257198+00', '2026-06-16 22:44:33.25725+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('89db8d10-5033-4cad-adab-332ba1424d76', 'pstdavidoluwaseun@gmail.com', 'Seun david Adeojo', '$2b$12$Ej8aMB79DjIqGo4WvY/VJeVqRiP29hFQVi93SROmV0jcI6w/Yq0lO', true, 'M4E8AXM0U92X', false, '2026-06-17 12:15:44.216721+00', '2026-06-17 12:15:44.216777+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5ddd6c55-0d50-41a0-b434-d53227428bb1', 'oseiwinfred6@gmail.com', 'Winfred osei', '$2b$12$LHj1PJRhh3rtnbUUlaOMfO8RRCC0/evVsFtgEexWAqcNglTCh/C8O', true, 'AR8J5G48R2I5', false, '2026-06-17 19:13:50.190794+00', '2026-06-17 19:13:50.190836+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4b7ed184-d706-4a71-a1f6-b4433e91b8d1', 'saschagrammel000@gmail.com', 'Wisdom Chigozie', '$2b$12$BfbV2G8Cf3a4673zR1.ogeRE80zPdmc8uZA5KiWORe2mJ8CxdDFTy', true, '0KF3BRQZ78RE', false, '2026-06-18 14:22:23.489269+00', '2026-06-18 14:22:23.489306+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0d76e568-68eb-4ad0-99b1-6aede0e09ca3', 'jsstudio107@gmail.com', 'juned shaikh', '$2b$12$eWrBtq52cHUqWQyOLh.e.exOYnw99Yp8I8IjdNRkDlWyt79651.m.', true, '4F0PJJL89EAG', false, '2026-06-18 15:36:07.567766+00', '2026-06-18 15:36:07.567791+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1546d01c-fe3d-4faf-810f-5511802fe80a', 'preciousmatthew176@gmail.com', 'precious  Matthew', '$2b$12$eFiVc2klEXrdlf4KkmgEleTg36z7RX0S/jdinG6zlT6gv9COoxZL2', true, 'VBC6P79ZGVQ8', false, '2026-06-19 10:32:09.444392+00', '2026-06-19 10:32:09.444413+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('bfa0e8a7-0eea-46ca-8c09-350ebcfb8028', 'tamngwahumphry@gmail.com', 'Tamngwa Tanyu', '$2b$12$st/m6A8SaZ0pnm9E36t.9ukF/hv0qwa93GR0R4fyisUsIJhcOuLjG', true, 'X71LX3YQWBKD', false, '2026-06-20 12:48:42.571328+00', '2026-06-20 12:48:42.571362+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d369ec27-ca8c-411b-8023-3bc1e1439300', 'jonathankasime@gmail.com', 'Jonathan  Kasime', '$2b$12$EcFp3VH0Ou3k32uA0po7AuY4yVmoYpStGyh4njWcU84De19BBFW6S', true, 'Y20RYNPS3GKC', false, '2026-06-21 07:14:30.484634+00', '2026-06-21 07:14:30.484682+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9ecc2150-e7b8-472f-89c3-a98a0cce971e', 'akudinobiemmanuel0@gmail.com', 'Daniel Akudinobi', '$2b$12$O2SQt6/jFFRO01U1TLXszOicgqg5mat3QPhkW8Ya/B5z7H.PWseHq', true, 'PK9XCQ65X8JW', false, '2026-06-22 08:27:42.501079+00', '2026-06-22 08:27:42.501097+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('70fa06d0-1508-4a53-bcaf-eaab5cb29ace', 'qbdzg06@smartnator.com', 'Abdus  Halim', '$2b$12$69nUotu1NOGrUBGaK8kqHe5j/7fvKAE6hFac0gEvp3dHmgCVtAwSW', true, '2W9B8N0RLJDI', false, '2026-06-21 13:20:02.796178+00', '2026-06-21 13:20:02.796211+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('da42bfd2-9256-4cb0-82d0-7be5d90d297b', 'k.ern.l.i.m400@gmail.com', 'Rasel Amad', '$2b$12$njQd.aXdLrXL7VOWp6N5q.2.ls4qi5OWszW3PJcAgsfxewN/SsiMO', true, 'I1GOLREOO0DR', false, '2026-06-21 13:21:42.674706+00', '2026-06-21 13:21:42.674727+00', NULL);
INSERT INTO public."user" VALUES ('93e8d6da-b0c7-4ad5-b606-9fce458efde6', 'khangmail9090@gmail.com', 'Shahab Ali', '$2b$12$wcv16tfHofwcX4quTeW5Xu5HdGwJ4l4Dm7c50IIBN0SBezWr8FqAm', true, 'VO233Z8EDZUI', false, '2026-06-21 19:01:29.581932+00', '2026-06-21 19:01:29.581953+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a6970719-bdb0-445e-b3a5-a4385741ba62', 'olaoluwarinsayo@gmail.com', 'Israel  Ola', '$2b$12$igzTkXD33Z1IRC5hnqjasO2G8KGYFVDETSUe2RQRoSl30AsWZLubG', true, '5O8CYKMZ1FUO', false, '2026-06-23 11:19:26.784715+00', '2026-06-23 11:19:26.784757+00', NULL);
INSERT INTO public."user" VALUES ('75e67b87-a63a-4815-bb58-2b21b235b8c8', 'patrickigobor@gmail.com', 'Patrick  Joseph', '$2b$12$xTFykxoClscRqbjrHqFyeePNiXuJi5aU86RivbARaGp.sIPD8CKo2', true, 'UDQRVSYN02M5', false, '2026-06-23 20:43:22.518186+00', '2026-06-23 20:43:22.518231+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2e6d9e05-4ac7-4879-b5df-dc807260c440', 'djohnhenry1@hotmail.com', 'John Henry Daramola', '$2b$12$HIHHGIDkdylEs19SgC0pPuFioWGx9VR5pgFzeppaK4jzzI5RKLhB2', true, 'VFVDZAM25KZ8', false, '2026-06-23 22:21:07.891269+00', '2026-06-23 22:21:07.891308+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d0863615-bfb4-4dab-af0d-e818b1735d07', 'udvic20022@gmail.com', 'Victor  Oburu', '$2b$12$wNp.f1C8zObt9gZfrmUUn.cNvrZkh9UVZXJZcYPDn6QO71pZ.C1Ha', true, 'C4XQQNOBBADR', false, '2026-06-24 08:17:51.278821+00', '2026-06-24 08:17:51.27886+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6579b6ef-b9e6-4130-a4bb-3cbdc545b38b', 'vetor232@gmail.com', 'Emmanuel ojesanmi', '$2b$12$4tVUvIIgYn/Aqmkrb6CFv.6LR2zVVXgR3yHFca7TXpu8pTwdq/3WC', true, '5EFFVIEUV78Z', false, '2026-06-24 14:54:54.599311+00', '2026-06-24 14:54:54.599332+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5cb35108-ce2d-4bc1-87c2-751bbfc085d8', 'hughgo7777@gmail.com', 'David Morales', '$2b$12$czlq1vVvozQyfFdd4FXtbOvRhZ6rKplVSy6da920TaxH4CR/Uh84G', true, 'UOGO39Q7UEBH', false, '2026-06-24 16:52:33.605117+00', '2026-06-24 16:52:33.605137+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d8dc62fc-d76d-4eab-a222-b0de73bcc73a', 'cardo.lover@gmail.com', 'Ricardo Liedeman', '$2b$12$22f8.JN.W3qnw.VjVgNXZedJZiBqssvWTwYKe.Xd6cK7SKuMiv3R6', true, '90Q659NPNN70', false, '2026-06-25 11:03:37.544739+00', '2026-06-25 11:03:37.54476+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('96543a0f-3441-4994-a589-51935c30d645', 'antoniode202@gmail.com', 'AFONSO Antonio', '$2b$12$GffXHUK7N5sHmJDtzoUx2uPdCB6VpnGtk9kDw2dQsX8JyGSlfEzMm', true, 'NKB3E7TEU1J7', false, '2026-06-25 22:35:30.024095+00', '2026-06-25 22:35:30.024119+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('877294b5-c2fa-4c6f-9866-619b333e363e', 'claesenthierry@gmail.com', 'thierry claesen', '$2b$12$FbYa9Bj8CgI2NYaalwPsGONVlV/KhKbZGdA7YnE.ZYRHqJEqjFhVi', true, 'A58PBYV5300S', false, '2026-06-26 19:31:51.053171+00', '2026-06-26 19:31:51.053199+00', NULL);
INSERT INTO public."user" VALUES ('dc6540c4-c189-4d2f-aca4-33439b7ede89', 'mo22518191@utg.edu.gm', 'Michale Oghenekevwe', '$2b$12$.oXdK9NErAiSTKVfkJ8iwOxV3.WhQAkBUi/jgL4cwH8KXd2QvXiPC', true, 'FI44YM9XMSLG', false, '2026-06-27 05:03:16.15696+00', '2026-06-27 05:03:16.15698+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('39a5ff9c-6c43-4c56-8188-7053df24a5ea', 'abdulsalamayomide510@gmail.com', 'Abdulsalam Soliu', '$2b$12$s1zbE87P9Bx3XA2jCV6CCuR7Wr/0DTKWwpTw44EqwdUbDOP.y3OoW', true, 'REJX9KON7Q0N', false, '2026-06-27 11:40:34.850784+00', '2026-06-27 11:40:34.850804+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4e2718fe-31ba-4257-8f79-dd30451d7266', 'nbakobbytog@gmail.com', 'Kobby  Tymer', '$2b$12$kIPR8ksTvkYG.zcgh.Dr6ex.WSTkPVz0g7BGV3SwTqhDZqMIEnLBi', true, 'XL21NFTOHO8W', false, '2026-06-27 14:04:14.659411+00', '2026-06-27 14:04:14.659432+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a25b21d3-d2ad-44d9-9177-460f646e6338', 'innocentmulenga705@gmail.com', 'Innocent Mulenga', '$2b$12$H20ObZiuQQM1DxOvaqONYOtJYTd.Wb8SaOx78T3XqQ1dJnkY5t/Ka', true, 'P6Z1MTB8I1S9', false, '2026-06-28 16:03:23.489521+00', '2026-06-28 16:03:23.489544+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('41aa4ee5-f6f7-40ca-ba1f-59e7839becd7', 'thierryclaesen2@gmail.com', 'thierry claesen', '$2b$12$C9C7WqpKvuNNEId14YWfa.ozNL3bffeFvQKci/NNJqrTp22ZRjcp2', true, 'UYHR5R00VG2E', false, '2026-06-28 19:51:32.36281+00', '2026-06-28 19:51:32.362834+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('08ffaf50-e626-4bb9-857a-886f10ac5f40', 'Carolobi84@gmail.com', 'Caroll thozama  Obi', '$2b$12$jeWug1tk8YeiGBYgWorXzuiSaoUn2IvCca8A2Pu8PGl/PQw3yTP.6', true, 'C24WB0ALMM3I', false, '2026-06-28 19:55:49.171115+00', '2026-06-28 19:55:49.171134+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e550a33b-a944-4451-8368-9ae35e79932a', 'mwasakasteven7@gmail.com', 'Steven Alberto Mwasaka', '$2b$12$Ns7ojZBo0ki/IteqMPXipuw.SX0IrZN7tTxeh3ibY3KdThPi0xL06', true, 'P6I7SWPAUHRY', false, '2026-06-28 20:40:40.171584+00', '2026-06-28 20:40:40.171607+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1f08a2d5-f7bc-4beb-bbe6-bf19110ff819', 'tradermayur07@gmail.com', 'Mayur Baswal', '$2b$12$xbkcPBWqZ7088RcDwvHijuGqJX6k7ULU3K2HXN0xqUD68CM8BwQh.', true, 'O43HT906829V', false, '2026-06-28 21:25:40.065557+00', '2026-06-28 21:25:40.065583+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9e871b61-1791-4355-a40f-f815845e3c02', 'enduranceetuonu@gmail.com', 'Etuonu Endurance', '$2b$12$lM3FmZhcaWxVRCWFGdEugupf6pPcfFsJ5iRRiNzXmoFX5YA6GCI66', true, 'LVISLOPCA0DR', false, '2026-06-28 22:07:57.046646+00', '2026-06-28 22:07:57.046681+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fe0d2b91-b0ae-4e7c-ae2a-d4f063d8fab6', 'mulenganamandulu40@gmail.com', 'Mulenga Namandulu', '$2b$12$K1Gnr/WzASbo1kHH/SqgbO9a9S3afQh.PUDKX38H8L2NMTaZuclZy', true, 'TXCHVBL9H0QR', false, '2026-06-28 22:14:44.02977+00', '2026-06-28 22:14:44.029796+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('93f1ca52-cd2e-4ce6-889f-1cc63cd9af90', 'oladelejosephfadahunsi@gmail.com', 'Oladele Fadahunsi', '$2b$12$M0jN2GTj50Sqt4vARY5RQOGph6O18aXWSgaTF77VAsdXnsfj9vG5G', true, 'F69X29UUJI4R', false, '2026-06-28 22:23:47.364633+00', '2026-06-28 22:23:47.364658+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4f42f45e-340a-41b6-a47c-22bba1bf23b4', 'bravebluntfx@gmail.com', 'Oladele Fadahunsi', '$2b$12$v5RsYMUfrk5bqWGsaQsPQOXxp2tHrULj1T4LmFgG9/HObW1lpPUQK', true, 'VL4PZ6G8ZVFP', false, '2026-06-28 22:42:32.880031+00', '2026-06-28 22:42:32.880053+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a488f61a-8637-40a8-a5ac-8f0abbd81e09', 'cryptoolord@gmail.com', 'Prince  Ugo', '$2b$12$uYT/GymhdIfX5VusLRm6AOWbyeLOqF6sxFQ3Bj73OYhzdsnr9aPGS', true, 'PP0M1680PXN6', false, '2026-06-28 23:22:07.273607+00', '2026-06-28 23:22:07.273627+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b9f556e0-45f6-4250-8e8b-a6cc664c3580', 'ghostfx6184@gmail.com', 'Joshua Adeleye', '$2b$12$wL8Jf4VZE/EeBIxX2VEU7uOsbrt2SDOEQ9izmPuKFgylbY.5AWavG', true, '5RBU4121KB2T', false, '2026-06-29 02:16:59.793858+00', '2026-06-29 02:16:59.79388+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('05e40552-c8d1-4e94-9e64-f436c4369596', 'latasharmalatakumari@gmail.com', 'Dhruv Sharma', '$2b$12$DIjEBnMP.jKM6qaU1BCLweTMPuajoZd/BtU3F/bva6MTeBqqdjqa.', true, 'GY3Z07SSR3VL', false, '2026-06-29 02:26:39.977358+00', '2026-06-29 02:26:39.977396+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('82db715f-46e2-492d-a854-55a4ac18a525', 'mike20murithi@gmail.com', 'Mike Murithi', '$2b$12$74.hS67uWkGyEh0H7.4dDOyOhSdsaCcdEMT51Yo72PNoIZqsBg1OK', true, 'STS4QA2C3F4R', false, '2026-06-29 06:37:10.585728+00', '2026-06-29 06:37:10.585748+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('52f528c6-9886-4d40-81ae-c1e368486676', 'ngarimikefabiannjeru@gmail.com', 'MIKEFABIAN NJERU', '$2b$12$padU.H1/xwJdWthu1bw2j.VfHdvMAaF7G9gmRdOPgjwLOTLp3J3I.', true, 'L074K2LBI13I', false, '2026-06-29 07:45:36.045686+00', '2026-06-29 07:45:36.045706+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a694827e-a8f7-4131-8195-e148a42a8802', 'preciouswaseni@mail.com', 'precious waseni', '$2b$12$AlFKJK/EmOGUOPEor6YXhenWja7tj3nuxiOmibkYUqDAT32J6Otc.', true, 'IH0LIQRLN8WZ', false, '2026-06-29 08:46:41.282449+00', '2026-06-29 08:46:41.282467+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('57e73868-160b-472b-b11f-5f9102ffe58d', 'jdosso2007@gmail.com', 'Junior Dosso', '$2b$12$4.2FozImkc8TwfhSSI1HUuOtkCnuz7ucQ.v.48c6gpfmQW7Eac6/.', true, 'YH337SBUDF4D', false, '2026-06-29 09:53:44.252626+00', '2026-06-29 09:53:44.252648+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('04ec0171-608c-4572-8b2f-19eec44fc5a0', 'ndjoksobiffoupierreemmanuel00@gmail.com', 'Pierre biffou', '$2b$12$dZ2cm9bO0ufzYasveOGsueTGazIJCZiX.Z3Ld7ZcwQTXbB/5PYJfi', true, '6TOAPOFWQ226', false, '2026-06-29 15:41:48.490845+00', '2026-06-29 15:41:48.490871+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8c7af04a-9bce-4ba1-b216-7fa70d18fa67', 'pknziradzakare@gmail.com', 'Provide Kudzai  Nziradzakare', '$2b$12$YeFLDApNqCy2sqxtP5/X6ejsWnLPWpsazxGL9s1yceIf04dk7g.mW', true, 'ENS41YAF5ZTR', false, '2026-06-29 18:44:52.260455+00', '2026-06-29 18:44:52.260496+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e862e91a-afdf-42da-b1b4-656f67f07107', 'azirsoleymani@gmail.com', 'Azir Soleymani', '$2b$12$9FZ5PJnOgFWf/XXBSWS34uiP2hub7UEyrTuoOb8ijarmSqcKRDhBq', true, 'SRG40SWBVIRB', false, '2026-06-29 19:36:25.903233+00', '2026-06-29 19:36:25.903294+00', NULL);
INSERT INTO public."user" VALUES ('5bf28cd4-3934-4777-bdc4-23364c7dca0e', 'kayceeforex@gmail.com', 'Kelechi  Nwokocha', '$2b$12$GZyJHwWFq0dSWSPvziWozehQl1EKi4kya7X.EbinqGdYg6lIh9Bc2', true, '1SUWNAPDJ33D', false, '2026-06-30 01:35:08.686919+00', '2026-06-30 01:35:08.686947+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0787ff5d-4398-4095-917d-e31395556f8a', 'aleeumohammad82@gmail.com', 'Aliyu Mohammad', '$2b$12$QUKipkhDU.wqH1TBzoBayOgEKPthZ9rkOqZCSXnqNjlmPF5Mztxti', true, '7Y7MMGDA1G5V', false, '2026-06-30 12:38:18.463195+00', '2026-06-30 12:38:18.463216+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1cfd9036-5597-4a60-97d4-1221571c3259', 'mikyakinola@gmail.com', 'michael Akinola', '$2b$12$vrs.cEV3.0IANqmzUWMObuAuZBaJkCudVqS6yhdX3IfKadKkenwf2', true, 'K7WZEEN3AGTG', false, '2026-06-30 16:37:57.343694+00', '2026-06-30 16:37:57.343719+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6a1933f1-c5b6-4033-8300-dc2e9fa6b8f1', 'Christopherhomeboy1@gmail.com', 'Sunday Christopher', '$2b$12$81BPj7XYu/Ie0kAnSwSVNOMPSLqomIlBD18uS9P1jqtdX0pHbjHgq', true, 'KJAK1C7BQT8G', false, '2026-06-30 17:45:29.232431+00', '2026-06-30 17:45:29.232456+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5895d969-ea2c-4519-bd43-c8f24fe96d7c', 'teyerichmond3040@gmail.com', 'Richmond  Teye', '$2b$12$6zNMT8qnBprwlpauF4sIheIvPgaBaS4oiv0RACcvfVnED0Nu/uzua', true, '8NSYVEZQKMQ1', false, '2026-07-01 03:20:43.383686+00', '2026-07-01 03:20:43.383704+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('f0f192b9-5327-4f62-922c-8a3e1c84a802', 'workwithsibin@gmail.com', 'Sibin Baby', '$2b$12$5cWS9Ui6YWhUgl27/S/4je9Kcr1lLU.4h0XFMQYGZKOmoIjLOw1Ii', true, '2TTW7N8RUEPM', false, '2026-07-01 08:29:17.492904+00', '2026-07-01 08:29:17.492929+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5bc13df7-6a26-49cb-b539-5df144ac33a4', 'wistedderrickchamwenda@gmail.com', 'wisted chamwenda', '$2b$12$lciR4gacmnoZ2tOmUHc8beIob8oPa1T0rbjfOcNHQruHYiw.nLh2u', true, '3UULOQTZ9459', false, '2026-07-01 20:08:06.854552+00', '2026-07-01 20:08:06.854576+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('51c44574-c866-40b2-b5bb-972771097344', 'shaatboss007@gmail.com', 'Khaleil Anderson', '$2b$12$08oxQvebjwF55tCLc/NPke3Qc6bk0Y7vd3woRQtGE22nDBV/wM7pS', true, '38K9WAX89GPL', true, '2026-07-01 20:49:10.59858+00', '2026-07-01 20:49:10.598597+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('581c496b-de5d-4db6-8da8-872518ef47c5', 'hpbundhaliya@gmail.com', 'prince bundheliya', '$2b$12$3Yj216DikbCGSolJXUv0u.XZPM4c6cfPnTJgAEMJOpAwwe/SJd2oC', true, 'KRY4KPW526SE', false, '2026-07-02 15:35:07.911659+00', '2026-07-02 15:35:07.911696+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a92ed4e1-fa82-4019-bb60-5310f9179fd8', 'joyumoh817@gmail.com', 'Joyce Umoh', '$2b$12$I4GqpH4qVVynsg.FYjOa1u5CjIBaF.JUEF5e2I9wIMraurEPh7gwC', true, 'E5JIQH7G1M2E', false, '2026-07-05 18:16:31.893824+00', '2026-07-05 18:16:31.893853+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d0fc866c-a457-4fbf-92c5-411eab17104e', 'wellingtondaniel216@gmail.com', 'Daniel Wellington', '$2b$12$/jNQwkUnKWqdKenRzYL47.muwJlCk0/yLVSNnPlTEWv/RRSkaQQym', true, 'D8CSHYVJQZTQ', false, '2026-07-06 10:05:19.125616+00', '2026-07-06 10:05:19.125655+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fc98c945-3906-4df6-8ea7-1b5caae77aa3', 'zakidhago@gmail.com', 'Sakariye  Jaamac cali', '$2b$12$AkIYTo5Ca/ktLfvAo3ccruy8YDBzCLH/KxjrHF3oBrW2lash1Qwc6', true, 'UQT2MIJFA4AU', false, '2026-07-09 00:19:01.235326+00', '2026-07-09 00:19:01.235345+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('42be05f7-9fc1-45a6-9091-824e4357bce5', 'mosiii66@gmail.com', 'Mustafa Dezfuli', '$2b$12$U20AhSjs8ADnsp6j6I0IAObXXdtJfH2r77LhGP7kWON4v9ZMyhsO.', true, 'QVGHS5S8MU40', false, '2026-07-10 21:53:29.829519+00', '2026-07-10 21:53:29.829553+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('fc2ab9b2-faf8-4f6e-a5ba-b5ef448cf25c', 'roseudom7@gmail.com', 'Rose Udom', '$2b$12$T1JRW/GXqmQ2vpoPrLpc6eFsooDqPftVa3wIoQGEnbDibZIxOKfom', true, 'HFTMABHPJGRL', false, '2026-07-02 07:32:23.800219+00', '2026-07-02 07:32:23.800255+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8952911c-911b-41b2-8375-e1aed93e961c', 'jetbizdigital@gmail.com', 'Kingsley  Azugo', '$2b$12$inzTtgfAtuTyL3sBnGzHFer0OG.pu2AmGQgveGjUci0AjYDvCQJ0C', true, 'D0GTXHSYKAKI', false, '2026-07-02 11:03:34.184103+00', '2026-07-02 11:03:34.184124+00', NULL);
INSERT INTO public."user" VALUES ('7218a3cc-5ac9-4236-99da-c924045089dd', 'dk334m@gmail.com', 'Dhinesh Kumar', '$2b$12$0wOzSKG84Lh9Dl14/naJO..e/3O/m6NHG3A7kbO2aJRWdcyqxR8NW', true, 'GLUY03NYBU8L', false, '2026-07-06 06:53:21.887337+00', '2026-07-06 06:53:21.887366+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ffe00839-1853-4390-a312-9d69c769f778', 'osamudiamenrichard648@gmail.com', 'Osamudiamen Richard', '$2b$12$vP1qYB9QA2Os8yx/i9K6HO.2Mk8wDJgqYrmNRG3iMXzKcc5hQ7euO', true, 'L3EECQOA23Z4', false, '2026-07-08 16:15:12.796402+00', '2026-07-08 16:15:12.796433+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('445b1865-21a9-42c4-aa9a-41f72492664b', 'tiffanyemelda@gmail.com', 'Efetobor  emelda  Oluwaseun', '$2b$12$lGMIzMiY.3k0hOp7cKIpk.OrSIR/Z6qZ2.ibykMK7kGvLrI5u4tQy', true, 'FPJ2RBJ0F41D', false, '2026-07-09 10:47:32.922549+00', '2026-07-09 10:47:32.922574+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('15e3c1e7-327f-408a-b304-a9435d6fd793', 'mathewemmanuel070@yahoo.com', 'Emmanuel Mathew', '$2b$12$b9KDUF9aTgcD.l9cRRygE.tIuyT35CDOsh/8drPvD7xMWNDngiVJ6', true, 'AKQ71QURLGDV', false, '2026-07-13 17:28:50.895777+00', '2026-07-13 17:28:50.895801+00', NULL);
INSERT INTO public."user" VALUES ('6909da54-677e-4484-9105-563de2303a81', 'futureengr@hotmail.com', 'zakariyya magashi', '$2b$12$LWfRXyzb9lvId119m0BcH.8p4y4xi5Yu3RFDzXMC4BKCm1QfYDSry', true, 'UTSYRTV1XY2I', false, '2026-07-02 10:56:48.340764+00', '2026-07-02 10:56:48.340792+00', NULL);
INSERT INTO public."user" VALUES ('e277c7bb-a89a-4b96-955a-44d457214fc7', 'okpojohnu.franklin@gmail.com', 'Okpo John', '$2b$12$W7RjR4oNSlMONIHBermDn.5f.XUBFjIw1fkB/YK3YDiKCAPs/9UPC', true, 'CVNK0OI1ERHQ', false, '2026-07-04 10:49:52.455586+00', '2026-07-04 10:49:52.455609+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d0545d50-ba23-4113-8a6f-00beb9db8f85', 'yathishahmyathisha@gmail.com', 'Yathisha H M Yathisha', '$2b$12$g2eGI979fHmkw81Zq47Gg.JmQwB7YnXvyYsLm5nmmLuYYxlaJG.tK', true, 'ZZZCIVOEQXZV', false, '2026-07-04 16:31:36.041505+00', '2026-07-04 16:31:36.041535+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8653c344-46c9-4c98-bebf-d941200d4c22', 'bofadin2003@gmail.com', 'Sarafa Badmus', '$2b$12$Qaj9s2sjNb/RltZQfktv1.aJ02yJP/HFTuEU4sMFdmoZcnpXmj/Pu', true, '31N3T112KZIY', false, '2026-07-05 14:32:37.09388+00', '2026-07-05 14:32:37.093901+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('90b8f404-ac01-4df0-87cd-7c280ebf27dd', 'aliasgharakbary001@gmail.com', 'aliasghar akbary', '$2b$12$rMAmgtZm3NVQenjPkqPv4O0vANptxPA094t40wqWsp9k7TeSGfqQ2', true, '046H9B0MC3AF', false, '2026-07-07 07:21:46.343811+00', '2026-07-07 07:21:46.343841+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3a19a6c2-0e06-470d-872b-5a863ecb5bd6', 'oladimejie400@gmail.com', 'Oladimeji Emmanuel', '$2b$12$xQ8IjlyPA5DStfkvDhvhbOcZ5aVVR3Lluqk/Jw8DInuQ7drct6X.W', true, 'OKM5F4YSXF7W', false, '2026-07-07 13:10:41.051667+00', '2026-07-07 13:10:41.051693+00', NULL);
INSERT INTO public."user" VALUES ('874f51d7-84de-489b-8d99-665726d448e9', 'mikeoduor3559@gmail.com', 'Michael Oduor', '$2b$12$5MpYH95K03HsYH9.u6Hb4u05NDbS0Rzj6BZejzxge7kNxfmQTaX5m', true, 'TKEZ19VQMV6Q', false, '2026-07-12 20:04:34.839451+00', '2026-07-12 20:04:34.839519+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ba0ebc1d-1dd9-402c-9357-de4d18ff4b91', 'owaolaolu@gmail.com', 'OLAOLU OWA', '$2b$12$Wv4XTHM5oN9OZNnOYClC0OiLwCwgMBSbKjcS2eAuZvBz5hLGApJPm', true, '2J4M9ZJG2MXC', false, '2026-07-14 16:54:36.066679+00', '2026-07-14 16:54:36.066717+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('8b907742-322c-415d-aa08-0c7f98518e4a', 'hamidulukman195@gmail.com', 'Hamidu Lukman', '$2b$12$7jf92rFvGxE2kSkaSbv2suhuBDiQCbDK.JC4PKa.Mlz/ONoHFK7vW', true, 'QJ9QETS6FTSX', false, '2026-07-16 00:59:06.486081+00', '2026-07-16 00:59:06.486126+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('04811d5e-aea6-48bf-b434-78c98bd90cb3', 'zeroscribefx@gmail.com', 'prize naabiae', '$2b$12$RTlxEHRCTtZ6s2jEnqxRBurbsMIlVY4UI/4u1Qs7hDmp/X.VW9lPq', true, 'K10BEG8N0BKG', false, '2026-07-02 11:53:46.868597+00', '2026-07-02 11:53:46.868637+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5f2ca9b7-ca19-4fd6-9e69-61f9a8fa0a59', 'business2005busy@gmail.com', 'Wezy Zimba', '$2b$12$Wzkl1W5BxMCQT1hvOq7HtOz6jrG.1vBmspBqTJDFickRyqtS8PVim', true, 'EZQ6OI5DU14I', false, '2026-07-05 16:04:29.079373+00', '2026-07-05 16:04:29.079407+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c66b9f88-9217-4e96-9aa2-c5fc67fa0820', 'sadiqabdul649@gmail.com', 'Abdulmumin  Sadiq', '$2b$12$3Iaf3dW1BGbVg78507h8oeuphkOk1UiAl1TLTWuS9UwJB22LR2Esi', true, '2LJ3K37PYG4I', false, '2026-07-12 19:45:32.84933+00', '2026-07-12 19:45:32.849361+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0de91dca-779f-465b-a748-ef26d8b69937', 'olubolade1528@gmail.com', 'Precious  Olubolade', '$2b$12$nOwSaZyiOehDWYgQX5B1/euAVFlwrc0gaMEFrihJaMvf.qzty50Qq', true, 'X5GT68WOPVIE', false, '2026-07-03 07:17:56.546119+00', '2026-07-03 07:17:56.546146+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('15210855-7cd7-44b4-84fd-3a5277d8bce4', 'chiboyprecious0@gmail.com', 'Oguike Nwachinemere', '$2b$12$aa6aRVAO43v5NNooyYSsref7ozHwj8PgBHFzki9O/JTUX4/taikz2', true, 'I0BOXX0C2BGJ', false, '2026-07-04 08:03:45.696631+00', '2026-07-04 08:03:45.696661+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a3d05de6-0b55-4ed1-9166-de116f808118', 'faizalkyle9@gmail.com', 'Faisal Kyle', '$2b$12$84n6Vez/R//AWHIi4pbwV.W1tvt51EtXoizFwjmXn2.rcm029jaVm', true, 'JEJZH1MKRULR', false, '2026-07-05 11:02:33.541668+00', '2026-07-05 11:02:33.541695+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('1530409c-a6ac-40f7-a573-51e897b77969', 'migayelmartin@gmail.com', 'Migayel vazhappilly', '$2b$12$5bYJ8WUDG8teg.qjPskTiukPAq/SohmyeLBLODTLpHpZ2PpFPRPEG', true, 'E4I7RO3UJ1FF', false, '2026-07-06 10:28:47.49194+00', '2026-07-06 10:28:47.491972+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c3e84501-8a2b-4b1c-affd-5c18cf3bb3d4', 'abugrioscar55@gmail.com', 'Oscar Abugri', '$2b$12$r4J3/Q/1hF56onFjq0z4mODsOvSyMmuwLU/hFCIomy/cvAWgjpJ9K', true, '6S54IOKXZC8F', false, '2026-07-07 21:22:18.891543+00', '2026-07-07 21:22:18.891562+00', NULL);
INSERT INTO public."user" VALUES ('0e4573ca-d2e7-484b-92f2-7e42008f0a50', 'mekiadanaa4@gmail.com', 'Meki Adanaa', '$2b$12$ZxrAe/z6W0DUPfQfrbvrh.bmdWOS9xEhaN9yiq3eAZjmBMRM4ma46', true, 'BTFRKW9714T6', false, '2026-07-11 00:16:38.847954+00', '2026-07-11 00:16:38.847973+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('2330f53a-0a1a-4307-98d3-02e14c061486', 'popemichael20182019@gmail.com', 'Michael  Pope', '$2b$12$1r4R4WFgfDMMff1gzKxVVeGzz.ic4z45MKYxPorm5C/diqsXxmeve', true, 'KWWKR0A0J2P4', false, '2026-07-13 03:11:35.618214+00', '2026-07-13 03:11:35.618238+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3ad5e1e3-bc86-4572-957b-937510d6a4b8', 'bakar9yce10@gmail.com', 'Abubakar Ndaman', '$2b$12$A0gRrMtTIaKxlhziSg.t/u7YVtrh5MG/G5snqTfJAF/tMTa8diUcK', true, 'L9QG4HXVRA8T', false, '2026-07-13 16:11:07.723708+00', '2026-07-13 16:11:07.723738+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d8445ebc-df69-483e-b1ff-4befd92a7993', 'arabimodibbo1984@gmail.com', 'Abdulrahman Modibbo', '$2b$12$M4I.ZRfG4j/D2TRWbrR0s.eLOQr1qjua5jsHDP9MDyE4Cf0gXfNe2', true, 'EKGRPXK4IZ4O', false, '2026-07-16 21:43:04.451555+00', '2026-07-16 21:43:04.451574+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('11c50e6a-1018-4331-8069-fba733270d4e', 'k05788734@gmail.com', 'Pritty Chirombo', '$2b$12$N/fK.HFXi571TMkOtyJFvuxqOIt16fbgQpCDxW2262GXukcVp4wNC', true, 'XDUA7IF7UOX5', false, '2026-07-17 21:24:31.948238+00', '2026-07-17 21:24:31.948286+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('88cb62a9-0143-4e3f-8fe6-cadae37b6e1c', 'sukilstrademax@gmail.com', 'Sukil Trademax', '$2b$12$QGLU8Bi.SNRwMV5M7OxjBe2TfMqvpH5lEmdVS1GtM2CuM8iQ7lQki', true, '9FQFQOX8RX7S', false, '2026-07-18 08:28:39.208315+00', '2026-07-18 08:28:39.208365+00', NULL);
INSERT INTO public."user" VALUES ('369898ab-1498-43a4-a689-4b91f3c545d0', 'amitmahto91552484@gmail.com', 'AMIT MAHTO', '$2b$12$czzzhs8yAi1Ahyad2s.8V.PeyQ/HA0uJ57KXQxsCGO5DghwKAQj0C', true, 'NCSCPVUIZRQ5', false, '2026-07-19 18:44:19.473637+00', '2026-07-19 18:44:19.473662+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('eebb0cf3-25eb-4c3a-8d9b-42d88f8fd4e0', 'stephenxcel@gmail.com', 'Stephen Koumassi', '$2b$12$t/c6mKjBuBeQa86LnlZIZOpOeQyjgizqwc6CTI3anKeJzGC/jPXXe', true, 'T1HEZQ6DU8V3', false, '2026-07-19 20:08:34.086922+00', '2026-07-19 20:08:34.086972+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('6e13d542-3a96-40f2-b01b-a0331c87df0d', 'ogbojisundaygodwin@gmail.com', 'SUNDAY  GODWIN', '$2b$12$SI.H8uBBY2egojZUsK39Mufau70RIewZUkIhZd6v2AYZ/gCG2aFOS', true, 'Z36K4KXN97DJ', false, '2026-07-19 22:35:49.037443+00', '2026-07-19 22:35:49.037468+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('661e453c-8ee8-4622-b2bc-94c09a2627ee', 'kelvinsonarhin@gmail.com', 'Kelvin  Arhin', '$2b$12$Iv27kp1cbHQA4i6PEn9Nn.G6da2fnFKmWy2MoRNuxDsJN.WJ1PLI2', true, 'DDL7QR04MCCD', false, '2026-07-19 23:08:10.431456+00', '2026-07-19 23:08:10.431483+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('75d45b65-c2d5-4244-9723-174152621383', 'amincoolboy15@gmail.com', 'Amin  Cool', '$2b$12$TIfGQS0z0MkOAC0zoSegAeWg3Qg74xH9CxnCv47Q1FNFigGiDGZUa', true, '3W2T4WT1DV83', false, '2026-07-20 08:59:32.199343+00', '2026-07-20 08:59:32.199371+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('faad8686-0daa-49eb-81af-f1a714fa3297', 'angelnellynyamai@gmail.com', 'Angel Nelly', '$2b$12$Ko2NGH6M023zi4LKEZ9uMO3fRyp4aOIcP6nkT23kOZkCNDujECvUC', true, 'OSTIWGIS4B5L', false, '2026-07-24 15:04:29.141087+00', '2026-07-24 15:04:29.141113+00', NULL);
INSERT INTO public."user" VALUES ('f3946400-b162-41fa-8090-5dfdc2f0938e', 'vinnbalavad@gmail.com', 'Kelvin Mollel', '$2b$12$2zmca3H2Gwsaa8VdxrJZNe4BUXEsC4CJFKGH0Viw4WERNftgDonam', true, 'NR7VBQU06CJO', false, '2026-07-25 05:34:57.603685+00', '2026-07-25 05:34:57.603732+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('06aca963-1859-4c62-8705-9bca8429bf7c', 'tanisimeon@gmail.com', 'Simeon Tani', '$2b$12$GrbbzHyxKHCOeJsl.ZjD0.26ifbp0yTY2Jqqharn8BHU65CVuujB.', true, 'QKD8N15U0VUG', false, '2026-07-25 09:25:46.179533+00', '2026-07-25 09:25:46.179554+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d1c58daf-42af-4a03-be1a-2fd4e520e24d', 'terrencebmasuku@gmail.com', 'Bonginkosi Masuku', '$2b$12$twc0.7p6bSNB8WoO2ptPrOzKHr.Y.ybis6KBccS58mOG0axRc3lEK', true, 'S504Q7B7P24H', false, '2026-07-25 19:06:58.45524+00', '2026-07-25 19:06:58.455281+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('e5c7d69a-f413-412e-b3cc-e70a24c79222', 'oladelefadahunsi@gmail.com', 'Oladele  Fadahunsi', '$2b$12$sTWjEqFa/FFNh8XbEkECQOsphsWMCB9b0fh4QHQY0c.s4lT7.jQ3q', true, 'ZSE2PR4WA2BX', false, '2026-07-27 15:54:41.947803+00', '2026-07-27 15:54:41.947838+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('9063980d-285a-41a3-8e7b-039f3af5d0fe', 'cleberfried@hotmail.com', 'Cleber Fried Brito', '$2b$12$sk8DJaX3ITiVgjC5ftioC.0BE62SjNGjy5OAA6ZqQkbDdnClkiTHa', true, 'KBWDF5JSMVFU', false, '2026-07-28 02:21:29.983181+00', '2026-07-28 02:21:29.983222+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d11debcc-0982-455d-ba51-73e164854049', 'ranjithkumar72774@gmail.com', 'Ranjit Kumar', '$2b$12$JeftNvm3KU4m6KzkKff.EuCmwYqqVJxWtTa81L.y3cBXHIQn85F/S', true, 'MNLTR23LEP2E', false, '2026-07-28 02:50:04.185027+00', '2026-07-28 02:50:04.18505+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b5340560-9a5d-48d1-a3df-6ad3c48ddce3', 'fokiroyalnig@gmail.com', 'ERIC SIMEU', '$2b$12$.q10A3YGFeKH1Wi4uXPO4.p.YniFNsLyqGeOnyWtsrzKNd.7hv2HC', true, '7UUCVFF2T331', false, '2026-07-28 03:53:46.93026+00', '2026-07-28 03:53:46.930284+00', NULL);
INSERT INTO public."user" VALUES ('ce2d5352-d8a8-4bc6-bba4-73c144449f1a', 'viifinance.info@gmail.com', 'BRIGHT LAWANI', '$2b$12$qJ34.focHx8hy4oatODTX.iWJ2AbeZMTGdfhTJQt9ZlNAuA3eKbbK', true, '8IWT7CFHE98Z', false, '2026-07-28 14:49:28.458907+00', '2026-07-28 14:49:28.458925+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('31acd7e8-478d-4d04-9c9c-b36daeb64d8c', 'uyidigitalworldenterprise@gmail.com', 'OSAMUYI OSAZEMWONGIE', '$2b$12$ytAqyy5FUM4oheaaHoWpouBhP3UN/gQN4NZnjStF1XbgifuvS75Yi', true, 'YPEV8OU6URHK', false, '2026-07-28 15:26:45.5524+00', '2026-07-28 15:26:45.552428+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('cb1cc4be-5159-4439-8876-5b3eecb5f911', 'iara_celia@yahoo.com.br', 'Iara Sant''Anna', '$2b$12$seYqwtaj3YmICmL2Kofi/.tNBXk0hkoaTWq9hhhcoZd70V0Yd50gW', true, '9OCXZBGXI0UW', false, '2026-07-28 17:11:29.283838+00', '2026-07-28 17:11:29.283866+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d6d5a388-75ef-4f6d-ad34-5eb01bccfea1', 'Jafarmuhammadisa@gmail.com', 'Jafar  Muhammad isa', '$2b$12$EUShBRiLQ0Kfod.NLdaE6O6H7Z3tckFX/bzURlvcIpb2ovaRLnIvu', true, 'UODINV92TE21', false, '2026-07-28 17:43:35.666016+00', '2026-07-28 17:43:35.666036+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('070860c3-971a-490e-b916-87b482f43676', 'saheedmohammed2345@gmail.com', 'Saheed Mohammed', '$2b$12$x2lRCMAQFZ5EkxpLFQDZ2OA52rcUsF83WS1miqtbn1rbqgA//irRe', true, 'I4539VLGS75G', false, '2026-07-28 18:19:09.413057+00', '2026-07-28 18:19:09.413084+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('4cbd3ba0-afa6-476a-b7cb-323d0175d32a', 'juniorkwelagobe@gmail.com', 'Amolemo Kwelagobe', '$2b$12$I9qOHjNdsW7gNP0UGUBPbuMUR1/lUVHK3O2uKkhYCRb28gBVAqh9u', true, 'VM076Z2PJOTF', false, '2026-07-29 18:59:51.451421+00', '2026-07-29 18:59:51.451446+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('d680a4fb-5879-4779-b256-fbd461959651', 'omusaev063@gmail.com', 'Otabek Musaev', '$2b$12$SPozcsbR4APtJD9vHvtEhe0kMi13LKLyAAEGSszoGNjW2hlCjUFu.', true, '7U9AK39SX2N6', false, '2026-07-31 06:50:02.754755+00', '2026-07-31 06:50:02.754779+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('b0658e4b-2108-48af-ae66-5b2987aa0657', 'alexienus@yahoo.com', 'Adebayo Aliu Kareem', '$2b$12$oVrK41Bfe5QhWKPmHdZmlu4lwarnEaZo8IbANmzL1JJ.oN9QjMg9S', true, '5PTSYGXSTS18', false, '2026-08-02 14:36:50.765567+00', '2026-08-02 14:36:50.7656+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('c12a45c6-73c1-4dfb-a8aa-4c6225789c1c', 'fflegend6860@gmail.com', 'Nicole Clark', '$2b$12$0Ei3r99wpv5OMRz3uDzM9OQpB33R71eN8pPaPm6.UsxfVc0hCACH.', true, 'HCGZYOP6P64U', false, '2026-08-02 19:26:35.805163+00', '2026-08-02 19:26:35.805189+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('7cfcb296-5fb8-412d-83d6-e273895d2b06', 'abdishakuuryare49@gmail.com', 'ABDULAHI MAHAMED', '$2b$12$elT2Vr8ggYWQt8OA0KZ2AOyXen0ES0aRfybsu1Mi/3WBIj4lFrLeO', true, '0AI6N23ZDT2U', false, '2026-08-02 20:53:09.312663+00', '2026-08-02 20:53:09.31269+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('43f59ce3-b7b7-4a5c-8b4d-e2d31eb4194d', 'flavierhenry5@gmail.com', 'Flavier Henry', '$2b$12$/zGQ5Oe.d3npoPfxY8LQGeNX35UffF889CQjaThXRZE.VIlLPzskO', true, '0NIRHIDAGN6W', false, '2026-08-02 22:37:21.808743+00', '2026-08-02 22:37:21.808909+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('462eac49-6278-4301-8a3f-3e2f16026256', 'ajilos65@gmail.com', 'Ajilo Chibuike Samson', '$2b$12$VPjRy8fZI2Dy1ur15ldHz.lm6OhvlVtFrVD8VAtc5JShRKKloC/2y', true, 'MY8NQF3MPO6L', false, '2026-08-02 22:47:08.671995+00', '2026-08-02 22:47:08.672017+00', NULL);
INSERT INTO public."user" VALUES ('9d16a0ed-e89a-4d2e-880f-28c1e8feacc7', 'brandonranger037@gmail.com', 'Brandon Ranger', '$2b$12$R.2dNaNaCIwO9/GhI4IjuOLvF.Huy639fXB/SriroWPMbd6LmJpsW', true, 'ID7BXW0ZC7PG', false, '2026-08-02 22:58:25.675772+00', '2026-08-02 22:58:25.675792+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('3331f6e8-ce4c-4713-90d9-925fa10fb355', 'rangerjean7@gmail.com', 'Brandon Ranger', '$2b$12$YTyyY8ib649MQ1I//gSEZufdpLcH4yKcJjeR8zHc/cEMnO5TGUzgG', true, '1G8NZXPHQOYH', false, '2026-08-02 23:00:11.371678+00', '2026-08-02 23:00:11.3717+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('ff100371-f5ad-45bb-8a9c-597b16acde63', 'luckybrew11@gmail.com', 'Lucky Brew', '$2b$12$1tsN2Z7jXMZ0oLx.RvmQ0OID3UsdEfOjlMSwLUMe0NqI8YYEV39D.', true, 'V04HPJEOEEIX', false, '2026-08-03 07:39:59.412774+00', '2026-08-03 07:39:59.412809+00', NULL);
INSERT INTO public."user" VALUES ('c4411953-a03b-413f-b8cb-fd5740a9db2a', 'esther26olab@gmail.com', 'Esther Olabiyi', '$2b$12$4nwwO45zno3fF8aH9Pt7f.v6Ez7.pZ7ErwBG052bvEAJwGA3lKF86', true, 'Y0FDI5PX195F', false, '2026-08-03 09:16:10.789365+00', '2026-08-03 09:16:10.789393+00', 'PJ...');
INSERT INTO public."user" VALUES ('69cdc42e-eef3-42cf-b1b5-e89705e0ff4a', 'kibromgebru100@gmail.com', 'Kibrom Gebru', '$2b$12$oswfKNmMSPsEPu7LAPs07ug5nyNseGCrfCBnWTH4gJDvjYHsydedq', true, 'VKF8X7IENKTK', false, '2026-08-03 09:28:23.589321+00', '2026-08-03 09:28:23.589348+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('0aa55264-4353-41a9-99be-1a4cc573a162', 'edwardopapito@gmail.com', 'Edwardo Bwambale', '$2b$12$9BqlRNlEd1ke/SRz29wVfes1GkwhkAJWAZuD0rkoRIaHjYZqO.wy6', true, '6SFPIPXWS3QR', false, '2026-08-03 14:57:22.527067+00', '2026-08-03 14:57:22.527087+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('dcd5195e-2f4d-4fae-91b6-e5a8799db802', 'imniraj.luitel@gmail.com', 'Niraj Luitel', '$2b$12$tKiuj7haS6uDLO6Ecdtjv.QBs.Qwxj3QhTrUNGc5QrLqptpVso0Sa', true, 'YW5LP15R4BD1', false, '2026-08-03 17:21:56.095749+00', '2026-08-03 17:21:56.095791+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('46170950-df5e-48ce-87fc-b47870fb1a63', 'eriquephiri@yahoo.com', 'Eric Phiri', '$2b$12$4.Jh/rST5nlu1OkK778HOepleb3AIFymnk76Z6h5jHBrNOdDyI8Wu', true, 'A24PYG12BUAE', false, '2026-08-06 04:40:52.874211+00', '2026-08-06 04:40:52.874594+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('a17f4635-5a59-463e-b82f-a0213ce3c6f2', 'king8080909@gmail.com', 'Ashok Prajapati', '$2b$12$BVydmjLy.yrJr.PiSqw8rOlAgAwuhyq1ilLGxKSXUm64DksSVI8wG', true, 'EW7LZTHYUJCO', false, '2026-08-04 12:23:30.812305+00', '2026-08-04 12:23:30.812354+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('5a2971b8-83ee-4093-8255-19ea6d5e5cdf', 'isah_salwa@yahoo.com', 'Salwa Isah Garba', '$2b$12$LFzMgahfsXmbWuGiurIW.OPuDS8f03Z5woQJhN.l00QhDj4S4NVxm', true, '68GLEDCBLEZU', false, '2026-08-06 02:01:10.538742+00', '2026-08-06 02:01:10.538783+00', 'PJRI9LDHWDIU');
INSERT INTO public."user" VALUES ('834c26d2-707d-4bc5-9843-a5022f5269cc', 'dd0994589@gmail.com', 'David Excel', '$2b$12$8dEWVDzI09mxbLtkEXEDhu17tLarOEAyA7VtddwSxipzo5J8naI7i', true, 'FLZ7O8PD886Z', false, '2026-08-06 18:47:22.514308+00', '2026-08-06 18:47:22.514345+00', 'PJRI9LDHWDIU');


--
-- Data for Name: user_discount; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.user_discount VALUES ('6c4c41ce-2707-4b94-88c9-9cf2b1930539', '78fffd8a-6250-448d-93b7-0556b8dd7004', '351bf5af-7807-458a-898d-bc1e80380e97', 'WELCOME10', '2026-02-11 06:04:39.894816+00', '2026-02-11 06:04:39.894843+00');


--
-- Data for Name: user_purchased_package; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--



--
-- Data for Name: vat; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--



--
-- Data for Name: wallet; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--

INSERT INTO public.wallet VALUES ('9e0fe7ef-c91b-4949-8f32-df5745798514', '351bf5af-7807-458a-898d-bc1e80380e97', 0.00, 0.00, 0.00, '2026-02-02 12:34:47.668776+00', '2026-02-02 12:34:47.668798+00');
INSERT INTO public.wallet VALUES ('665d5bed-503d-4e51-9afa-605b8a2bf781', '3e5be313-a9df-4834-b146-d35dc14e62c4', 0.00, 0.00, 0.00, '2026-02-05 12:30:59.507205+00', '2026-02-05 12:30:59.507251+00');
INSERT INTO public.wallet VALUES ('94eb0239-19bc-4577-92b4-052442e170b7', '8ff7d590-67f6-48e7-8d3c-ddf2519997d0', 0.00, 0.00, 0.00, '2026-02-06 12:51:33.000072+00', '2026-02-06 12:51:33.000103+00');
INSERT INTO public.wallet VALUES ('9ac6611f-42a7-4d8e-8066-5d7598c9c447', 'c7591415-9635-4060-848d-faaf39b3bf56', 0.00, 0.00, 0.00, '2026-02-08 19:32:08.756968+00', '2026-02-08 19:32:08.757022+00');
INSERT INTO public.wallet VALUES ('5c890e33-69d4-4489-b299-38a50db321a3', '3e6d8ec2-3756-437a-b6e9-2dfc04bfa95b', 0.00, 0.00, 0.00, '2026-02-08 19:43:01.546622+00', '2026-02-08 19:43:01.546643+00');
INSERT INTO public.wallet VALUES ('25cd080d-731f-49fb-9f33-f5aefbedd6bc', 'f928eecb-a963-4c6b-b6e5-c744f699999d', 0.00, 0.00, 0.00, '2026-02-08 19:46:38.516349+00', '2026-02-08 19:46:38.51638+00');
INSERT INTO public.wallet VALUES ('1abea96d-135e-42ed-9452-f395ff5f2f78', '031ea2fb-b200-4deb-ae46-8a79c52851c9', 0.00, 0.00, 0.00, '2026-02-08 19:46:44.929906+00', '2026-02-08 19:46:44.929931+00');
INSERT INTO public.wallet VALUES ('2c31372f-4f5a-4279-9cef-48088c6c3cf2', '337b3f0e-8019-4923-a6ff-7890a2454506', 0.00, 0.00, 0.00, '2026-02-08 20:27:53.783033+00', '2026-02-08 20:27:53.783048+00');
INSERT INTO public.wallet VALUES ('f7dd9bde-51b5-4888-8900-b0eb2a30ffab', 'd20640d6-8ab0-4547-ab14-6f4dba3f62ef', 0.00, 0.00, 0.00, '2026-02-08 20:36:36.685988+00', '2026-02-08 20:36:36.686082+00');
INSERT INTO public.wallet VALUES ('1dce4f92-c118-47e8-9c92-69312720b814', '6a1d4c38-14fd-48fd-b76b-7f010260afa1', 0.00, 0.00, 0.00, '2026-02-08 20:58:44.807219+00', '2026-02-08 20:58:44.807256+00');
INSERT INTO public.wallet VALUES ('bed9605a-fc9f-42c6-ab14-fc4ae30a293e', '06553524-4e8b-44cd-aed0-f7755d879ff7', 0.00, 0.00, 0.00, '2026-02-08 21:07:55.269549+00', '2026-02-08 21:07:55.26959+00');
INSERT INTO public.wallet VALUES ('fbe49fa9-ac5a-45fc-ae2a-50506728445f', '8b1fc6b1-1431-4fc9-81ad-578d99e14bb5', 0.00, 0.00, 0.00, '2026-02-08 22:16:53.440734+00', '2026-02-08 22:16:53.440763+00');
INSERT INTO public.wallet VALUES ('feaf9f35-85e6-4a32-bb4e-fadb12600eb2', '6b269625-c894-498b-807c-6ff2a14606bb', 0.00, 0.00, 0.00, '2026-02-08 22:24:44.757153+00', '2026-02-08 22:24:44.75719+00');
INSERT INTO public.wallet VALUES ('25502fa6-9409-45ab-9022-0b3e12b77c14', '47253bbe-b207-4c61-b6ff-3c1970327bd4', 0.00, 0.00, 0.00, '2026-02-08 22:25:29.051868+00', '2026-02-08 22:25:29.051894+00');
INSERT INTO public.wallet VALUES ('be6aa00c-44fd-4669-b20d-ae7ccf2aab9a', 'a08f5289-de99-46cd-afa8-c9a538c1944a', 0.00, 0.00, 0.00, '2026-02-08 23:43:16.832649+00', '2026-02-08 23:43:16.832664+00');
INSERT INTO public.wallet VALUES ('c35e3c69-dc71-43eb-b83a-e8fcb244cca8', '36f50d19-763e-415a-9c44-9dd6b2a14c4b', 0.00, 0.00, 0.00, '2026-02-09 00:33:34.597751+00', '2026-02-09 00:33:34.597789+00');
INSERT INTO public.wallet VALUES ('92c66103-9dd9-4231-87d2-b65bd8c32f47', '9cdb1024-250e-4501-99d2-f84dc80be301', 0.00, 0.00, 0.00, '2026-02-09 01:23:43.089375+00', '2026-02-09 01:23:43.089406+00');
INSERT INTO public.wallet VALUES ('4b179c6b-ad38-467c-8c83-844da8de0ab1', 'f426d40d-ba4b-4a61-8838-5b45fcee3f70', 0.00, 0.00, 0.00, '2026-02-09 10:41:29.760743+00', '2026-02-09 10:41:29.760779+00');
INSERT INTO public.wallet VALUES ('8e18e68e-2070-44c9-b07c-cfd86cf1ce0a', '405c5f02-85d3-4956-a499-bba1b28ef855', 0.00, 0.00, 0.00, '2026-02-09 14:00:46.145416+00', '2026-02-09 14:00:46.145477+00');
INSERT INTO public.wallet VALUES ('7ed52e1e-cffe-4af5-aa5a-5f51049c0850', '6efc81ef-a215-4974-b40d-82d1e13d9814', 0.00, 0.00, 0.00, '2026-02-09 20:00:15.985923+00', '2026-02-09 20:00:15.985962+00');
INSERT INTO public.wallet VALUES ('4a898529-542b-48ba-9976-88f9cb736933', '8ca4c389-feb9-4d3e-83e9-4b534d510b0a', 0.00, 0.00, 0.00, '2026-02-09 20:24:07.225904+00', '2026-02-09 20:24:07.225951+00');
INSERT INTO public.wallet VALUES ('3edb10ee-2c16-4069-b2e7-14162b2be78b', '7f7974c8-f304-44e2-bc3d-0d49ca6af2b2', 0.00, 0.00, 0.00, '2026-02-09 21:21:35.485875+00', '2026-02-09 21:21:35.485912+00');
INSERT INTO public.wallet VALUES ('6ef410c4-1675-4719-8348-17af2ca4e367', '7b20c938-8cb5-47c0-8b41-53e841a465e1', 0.00, 0.00, 0.00, '2026-02-09 22:51:53.968921+00', '2026-02-09 22:51:53.968946+00');
INSERT INTO public.wallet VALUES ('0626cd50-bbe9-4ed3-9873-066c4f179eec', '6f64fba7-c59d-4ddb-9d45-e5a5b12f7620', 0.00, 0.00, 0.00, '2026-02-10 06:17:57.418283+00', '2026-02-10 06:17:57.418345+00');
INSERT INTO public.wallet VALUES ('4d2cf13d-5097-4c96-9b3e-8750ce978861', 'de36fe56-826b-49e7-9e30-3af9a8e9aa5c', 0.00, 0.00, 0.00, '2026-02-10 06:25:33.139785+00', '2026-02-10 06:25:33.139808+00');
INSERT INTO public.wallet VALUES ('9ae6fb60-ab17-4941-ad95-5bb106606a6f', '122d3da0-d150-49ff-bd25-3243d71e3655', 0.00, 0.00, 0.00, '2026-02-10 08:28:24.088744+00', '2026-02-10 08:28:24.088768+00');
INSERT INTO public.wallet VALUES ('7dfad13a-cfe7-4319-80fa-190c62f74841', 'd04d180c-bcbf-4180-a651-9567568f8904', 0.00, 0.00, 0.00, '2026-02-10 11:42:34.057132+00', '2026-02-10 11:42:34.057219+00');
INSERT INTO public.wallet VALUES ('55a78701-8c43-407c-b453-c7b134dca7c1', '70cbf790-abf6-4eac-8a7e-59755a031214', 0.00, 0.00, 0.00, '2026-02-10 14:45:58.364013+00', '2026-02-10 14:45:58.364045+00');
INSERT INTO public.wallet VALUES ('462a6e5b-99ec-4054-981a-a92de49cc73d', '68d7ddba-e616-4edc-b908-9aa162feef06', 0.00, 0.00, 0.00, '2026-02-10 17:42:55.432517+00', '2026-02-10 17:42:55.432544+00');
INSERT INTO public.wallet VALUES ('19870b68-c33e-49e9-8492-d3b54a40724d', '7d7f8990-6855-423a-b89d-ae72c3d863ec', 0.00, 0.00, 0.00, '2026-02-10 18:45:48.05166+00', '2026-02-10 18:45:48.051717+00');
INSERT INTO public.wallet VALUES ('09775710-48a4-4d2c-a032-838ab7930f71', '63d0cc73-70e9-407a-a464-3c192a49981a', 0.00, 0.00, 0.00, '2026-02-10 20:58:13.265613+00', '2026-02-10 20:58:13.265661+00');
INSERT INTO public.wallet VALUES ('d0538ed9-b54f-4317-b2a2-0a8ba859de50', 'bf66c687-35de-477f-b59c-ee147b4d05f2', 0.00, 0.00, 0.00, '2026-02-10 22:30:13.934755+00', '2026-02-10 22:30:13.934785+00');
INSERT INTO public.wallet VALUES ('0ac92fd5-ce73-489e-9077-1a9357fedcc5', 'db61433d-25ea-4edb-b3e2-6de586756ef4', 0.00, 0.00, 0.00, '2026-02-10 23:42:41.809283+00', '2026-02-10 23:42:41.80931+00');
INSERT INTO public.wallet VALUES ('cc1bbcb5-2f59-43df-a5f9-55656c06a929', '206fe153-24a1-4b5d-b2f4-30c9b050c528', 0.00, 0.00, 0.00, '2026-02-11 01:35:31.051741+00', '2026-02-11 01:35:31.051779+00');
INSERT INTO public.wallet VALUES ('39b8447d-53fb-4f14-9c0b-bcbe171942d0', '0a95b365-0365-4ef9-aa32-1de2891fe4dc', 0.00, 0.00, 0.00, '2026-02-11 06:39:33.23644+00', '2026-02-11 06:39:33.236477+00');
INSERT INTO public.wallet VALUES ('d3ca23ab-1c49-43d8-a4f8-048adb57dd99', 'a86476ff-db31-48a5-be78-7123c265b4fa', 0.00, 0.00, 0.00, '2026-02-11 09:07:17.311706+00', '2026-02-11 09:07:17.311738+00');
INSERT INTO public.wallet VALUES ('079655b6-cf63-4d4e-86e5-53f930bfbc97', 'a5cbb10a-fb54-46d0-83d2-fbbe9f8ddf06', 0.00, 0.00, 0.00, '2026-02-11 09:13:23.950832+00', '2026-02-11 09:13:23.950878+00');
INSERT INTO public.wallet VALUES ('82c0e78c-bf43-48a2-b1f5-3a69b9e76e27', '923cbc23-090b-437f-bf06-fb99240c79ec', 0.00, 0.00, 0.00, '2026-02-11 17:23:52.801136+00', '2026-02-11 17:23:52.801194+00');
INSERT INTO public.wallet VALUES ('00e8a5eb-9e02-4441-890d-e7d45fed1f5a', '24803670-0e3c-4335-a75d-e34e56db23f6', 0.00, 0.00, 0.00, '2026-02-11 20:32:56.633813+00', '2026-02-11 20:32:56.633835+00');
INSERT INTO public.wallet VALUES ('8be49896-4475-471d-81bf-1a07ea87319a', '2b14fd1b-c3d1-4061-8dc5-19f1d2f5940c', 0.00, 0.00, 0.00, '2026-02-12 07:11:13.319077+00', '2026-02-12 07:11:13.319098+00');
INSERT INTO public.wallet VALUES ('926bf840-0031-4691-b0b2-82d5ef08c76f', '71245d86-dcd6-4973-8e92-2e4adb0ca5f6', 0.00, 0.00, 0.00, '2026-02-12 12:37:24.771305+00', '2026-02-12 12:37:24.771336+00');
INSERT INTO public.wallet VALUES ('222a9ec8-415d-460f-8ef6-fbcc9e44adda', '8a38fc36-fa15-462a-b615-932f103d2773', 0.00, 0.00, 0.00, '2026-02-12 13:30:21.042831+00', '2026-02-12 13:30:21.04286+00');
INSERT INTO public.wallet VALUES ('7ed0bacb-64bd-4b1a-b282-efe5c98aeb6f', 'e1e584ff-08b9-478f-a388-ab2d00067ec2', 0.00, 0.00, 0.00, '2026-02-12 20:17:44.789379+00', '2026-02-12 20:17:44.789406+00');
INSERT INTO public.wallet VALUES ('dcd6f470-ad11-4f9a-8fa4-bf0f545b68ed', 'fc8c9fe3-115d-45d9-994c-064afaa696f7', 0.00, 0.00, 0.00, '2026-02-13 04:47:39.794223+00', '2026-02-13 04:47:39.794276+00');
INSERT INTO public.wallet VALUES ('8a2276ac-9c30-4471-9aee-508cf4f7e291', '0b5e9c2c-5eec-43bb-ad8a-dc9ebbd4882f', 0.00, 0.00, 0.00, '2026-02-13 07:03:04.958986+00', '2026-02-13 07:03:04.959018+00');
INSERT INTO public.wallet VALUES ('bb43ceb3-100c-4825-bb0d-ebbdd8342fa4', 'a69a40eb-5688-4881-b74d-ebfb5ebe0c26', 0.00, 0.00, 0.00, '2026-02-13 14:06:57.495523+00', '2026-02-13 14:06:57.495556+00');
INSERT INTO public.wallet VALUES ('06209c7b-26f9-4632-a37d-8e303ddad569', '71ad88e7-897f-4c55-9d57-c0ea4b36442f', 0.00, 0.00, 0.00, '2026-02-13 19:02:25.591944+00', '2026-02-13 19:02:25.591995+00');
INSERT INTO public.wallet VALUES ('d79a83d3-104b-4213-b515-11e2074974d7', 'd2ff5166-862b-4597-ab3a-e87102ddba87', 0.00, 0.00, 0.00, '2026-02-15 12:25:56.42884+00', '2026-02-15 12:25:56.428877+00');
INSERT INTO public.wallet VALUES ('6d235a19-847c-45de-bd4f-2af2af94cb8b', 'd2b392fe-adf3-4f34-8536-ad3bf537dcab', 0.00, 0.00, 0.00, '2026-02-16 01:15:33.855979+00', '2026-02-16 01:15:33.856011+00');
INSERT INTO public.wallet VALUES ('f5f46e72-1f4e-48a6-af1b-57aa1d2666a8', '1aaa1b83-1830-4c13-a3d1-803a3ec224d9', 0.00, 0.00, 0.00, '2026-02-16 02:45:11.448865+00', '2026-02-16 02:45:11.448898+00');
INSERT INTO public.wallet VALUES ('5712a185-80e6-4951-bcd3-1c9e0fff0a7b', '7d3ed82a-e6a6-414c-9bb9-24382f995ca9', 0.00, 0.00, 0.00, '2026-02-16 06:03:19.926722+00', '2026-02-16 06:03:19.9268+00');
INSERT INTO public.wallet VALUES ('f6f94548-fc7f-4ed1-96b4-599ed931cb4d', '4a39928e-72cf-4cb8-8368-ebb12574b72f', 0.00, 0.00, 0.00, '2026-02-16 14:35:20.893504+00', '2026-02-16 14:35:20.893535+00');
INSERT INTO public.wallet VALUES ('c89ed634-0bfa-4b91-b747-56f641bd9d83', '56654e0e-6070-4c83-8507-ec806031ff33', 0.00, 0.00, 0.00, '2026-02-16 16:45:32.122718+00', '2026-02-16 16:45:32.122738+00');
INSERT INTO public.wallet VALUES ('b80e36d0-65e2-4583-9c78-9b6be5e91aee', '397284cd-b5e1-442c-8656-f10e64eaed0a', 0.00, 0.00, 0.00, '2026-02-16 19:35:17.238231+00', '2026-02-16 19:35:17.238277+00');
INSERT INTO public.wallet VALUES ('5f324558-1337-4a76-8a8c-0358d8b9d7d3', 'b073f20f-6066-4688-afee-1c6a2d6254d1', 0.00, 0.00, 0.00, '2026-02-16 21:26:09.079697+00', '2026-02-16 21:26:09.079739+00');
INSERT INTO public.wallet VALUES ('49f75493-c53e-4e80-8e17-4c455aad81d6', 'c24c11ec-cc55-46c0-bc9a-cd09a73d8211', 0.00, 0.00, 0.00, '2026-02-17 06:07:20.292731+00', '2026-02-17 06:07:20.292756+00');
INSERT INTO public.wallet VALUES ('a587ddd3-ae6b-47bf-ae89-67f1ff1c7f72', '466617ee-6a3c-450b-8e08-35c8483110af', 0.00, 0.00, 0.00, '2026-02-17 07:26:12.328185+00', '2026-02-17 07:26:12.328208+00');
INSERT INTO public.wallet VALUES ('bbe5b3b8-e4ea-4482-982f-506c4d0a3a6f', 'c92b7e44-11ea-4a5c-a5a9-ead83094eb76', 0.00, 0.00, 0.00, '2026-02-17 09:03:11.547242+00', '2026-02-17 09:03:11.547304+00');
INSERT INTO public.wallet VALUES ('53e041fc-579a-489c-aea4-d7e7187609b1', '018703ef-7b11-4115-bf21-9244d34ff12c', 0.00, 0.00, 0.00, '2026-02-17 13:21:11.389833+00', '2026-02-17 13:21:11.389865+00');
INSERT INTO public.wallet VALUES ('4d4bf10b-296c-4a17-a028-570c3e0c7d65', '460d45a5-7a21-4f46-b7cd-387e7f980fc7', 0.00, 0.00, 0.00, '2026-02-18 09:47:01.602391+00', '2026-02-18 09:47:01.602421+00');
INSERT INTO public.wallet VALUES ('da5d80f2-ad92-423a-b74b-a635d637012b', '9a33a4b9-293c-4c6d-9f7f-256763f9f04a', 0.00, 0.00, 0.00, '2026-02-18 12:15:59.146763+00', '2026-02-18 12:15:59.146793+00');
INSERT INTO public.wallet VALUES ('ce0f0856-71ad-431a-a4ac-96fea3dde1e4', 'a611619b-0b04-4e7b-a8b8-1c4666ce48f5', 0.00, 0.00, 0.00, '2026-02-18 12:51:25.014507+00', '2026-02-18 12:51:25.01453+00');
INSERT INTO public.wallet VALUES ('4cf6c74f-78f2-482e-9c5e-f6c8ac7bd178', 'e95a3967-acf7-4e29-a0cd-24fdc3d5ea49', 0.00, 0.00, 0.00, '2026-02-18 13:49:49.334957+00', '2026-02-18 13:49:49.33498+00');
INSERT INTO public.wallet VALUES ('434dea8a-0db9-474a-b1f5-268c4f26331f', 'c048c283-135f-4c4c-96cf-382e8af0ffe4', 0.00, 0.00, 0.00, '2026-02-18 18:06:12.150313+00', '2026-02-18 18:06:12.150342+00');
INSERT INTO public.wallet VALUES ('5bd35968-95a1-4da1-ad7d-6892ade1d3d3', '2773ec8f-eb0a-4168-8bf5-2c5c92815969', 0.00, 0.00, 0.00, '2026-02-18 18:41:02.735337+00', '2026-02-18 18:41:02.735371+00');
INSERT INTO public.wallet VALUES ('2ceaad54-9b47-48b2-95c6-a3b448306371', '5495ceef-417e-4329-b624-73dbd9ad2355', 0.00, 0.00, 0.00, '2026-02-19 08:02:28.90479+00', '2026-02-19 08:02:28.904811+00');
INSERT INTO public.wallet VALUES ('12569b2d-9568-457c-b6e1-c77c4c0681c6', 'a8fb5d31-37b1-41a1-b630-9b91d9825a3d', 0.00, 0.00, 0.00, '2026-02-19 17:48:58.255451+00', '2026-02-19 17:48:58.255478+00');
INSERT INTO public.wallet VALUES ('76fef2fd-3861-44ce-a0eb-3b27339b20c0', '772a2b85-a2e8-413d-b350-e348ce766106', 0.00, 0.00, 0.00, '2026-02-20 21:45:54.504478+00', '2026-02-20 21:45:54.504533+00');
INSERT INTO public.wallet VALUES ('a8b53430-0e9d-4fe3-aaf3-45fcd9ec6658', 'c382ffcd-0662-4b3c-aaca-2139751c5cd2', 0.00, 0.00, 0.00, '2026-02-20 23:50:54.66317+00', '2026-02-20 23:50:54.663214+00');
INSERT INTO public.wallet VALUES ('cc395c17-7c20-4899-bddf-ac1c98e1f36a', '26df37e6-fbc2-456d-90ff-8b3bcb14c8ca', 0.00, 0.00, 0.00, '2026-02-21 07:06:08.117227+00', '2026-02-21 07:06:08.117277+00');
INSERT INTO public.wallet VALUES ('b95e5a36-ff41-458e-b654-edc34cd8c170', 'f27518a2-8e5f-42c1-b143-552c92a6d513', 0.00, 0.00, 0.00, '2026-02-21 11:57:30.077557+00', '2026-02-21 11:57:30.077581+00');
INSERT INTO public.wallet VALUES ('3c06ef9d-3d89-4576-beaf-a300286e9602', '64e9fb56-20a7-49bb-95d1-bceefa21bede', 0.00, 0.00, 0.00, '2026-02-21 19:55:22.852028+00', '2026-02-21 19:55:22.852051+00');
INSERT INTO public.wallet VALUES ('3c70a6c0-75ac-4463-9fe0-986b06bafeab', '226f60e5-4ad4-4db7-8e69-e3622e98bd16', 0.00, 0.00, 0.00, '2026-02-21 21:21:29.988944+00', '2026-02-21 21:21:29.988976+00');
INSERT INTO public.wallet VALUES ('019c1a5b-f2db-4afd-86c0-94fdf3094d1d', 'da5075ec-7b2a-47c4-9830-e51b806b4cd4', 0.00, 0.00, 0.00, '2026-02-22 10:38:37.117388+00', '2026-02-22 10:38:37.117402+00');
INSERT INTO public.wallet VALUES ('97e28565-eeab-41b3-a40e-0e98b2cc4cac', '043571ae-50fe-46b8-a0db-2eee7a15da4d', 0.00, 0.00, 0.00, '2026-02-22 12:20:52.11082+00', '2026-02-22 12:20:52.110852+00');
INSERT INTO public.wallet VALUES ('5f779c29-fca0-45f3-b979-9d632acefba2', 'f975f08e-1d63-4c65-a672-cf04f7806d69', 0.00, 0.00, 0.00, '2026-02-22 14:36:49.011842+00', '2026-02-22 14:36:49.011862+00');
INSERT INTO public.wallet VALUES ('cbd03722-4b6f-42c0-99a8-dff0ac13d781', '448d6a7b-9a1d-41ae-b31a-9785ca4118bc', 0.00, 0.00, 0.00, '2026-02-22 17:01:40.284184+00', '2026-02-22 17:01:40.284227+00');
INSERT INTO public.wallet VALUES ('629bb01a-24db-4d30-8d82-c9c8a9eda5d1', '5ceea5fe-55dc-4684-83a5-1d56e8e0b02c', 0.00, 0.00, 0.00, '2026-02-23 04:51:22.439684+00', '2026-02-23 04:51:22.439739+00');
INSERT INTO public.wallet VALUES ('4c3abe4b-ec65-4e34-8ea5-89fda82d2810', '9763a79d-9cba-4e2b-8ace-c49f380fb2fb', 0.00, 0.00, 0.00, '2026-02-23 07:17:27.003668+00', '2026-02-23 07:17:27.003711+00');
INSERT INTO public.wallet VALUES ('e2f6d654-575d-4992-b5af-1561f8bf29ff', 'eb4e2f1b-2fc4-4374-a48d-acab9432031b', 0.00, 0.00, 0.00, '2026-02-25 10:47:11.269222+00', '2026-02-25 10:47:11.269256+00');
INSERT INTO public.wallet VALUES ('48eb2035-9416-4a69-9756-ab7e2be3de25', '3133f7bd-194e-4b0c-948c-b07e0ff3f3ad', 0.00, 0.00, 0.00, '2026-03-01 11:23:19.292137+00', '2026-03-01 11:23:19.292191+00');
INSERT INTO public.wallet VALUES ('37d65908-2769-461e-a362-137027529567', '0f8ee8d3-6aaf-4ad4-8a08-57d912d9ad63', 0.00, 0.00, 0.00, '2026-03-08 17:12:14.637332+00', '2026-03-08 17:12:14.637359+00');
INSERT INTO public.wallet VALUES ('4a70a7d9-a330-4460-b1fa-abad5a69f37d', 'c442cf6c-2e6b-4c8c-929a-bce9c55b8876', 0.00, 0.00, 0.00, '2026-03-10 21:11:14.095669+00', '2026-03-10 21:11:14.095698+00');
INSERT INTO public.wallet VALUES ('55ead762-4565-49dd-9ce1-900bd3d89f33', '43a5161b-0430-4fba-9004-710345a67232', 0.00, 0.00, 0.00, '2026-02-23 14:56:54.681704+00', '2026-02-23 14:56:54.681727+00');
INSERT INTO public.wallet VALUES ('6a97ef90-98b9-48e5-a207-93dd86d399ce', '154ff85d-d99a-4f46-b67e-dc7ffafc2000', 0.00, 0.00, 0.00, '2026-03-13 10:16:57.974464+00', '2026-03-13 10:16:57.974496+00');
INSERT INTO public.wallet VALUES ('f5363120-5fbe-46ce-8bf8-ac225fad6492', '5e86353a-2289-4cc9-b4aa-630226e9fc31', 0.00, 0.00, 0.00, '2026-03-16 14:24:53.692913+00', '2026-03-16 14:24:53.693191+00');
INSERT INTO public.wallet VALUES ('c8c49f21-9f46-4bee-9f76-744dd739b344', '47f74283-126c-4e98-b3a1-3b559e560dd4', 0.00, 0.00, 0.00, '2026-03-16 14:48:23.561705+00', '2026-03-16 14:48:23.561747+00');
INSERT INTO public.wallet VALUES ('7e2cc941-4232-4068-b6cb-b53e134055f9', 'eef719ec-9962-4c05-929c-83eaaaf2282b', 0.00, 0.00, 0.00, '2026-03-16 19:16:35.426697+00', '2026-03-16 19:16:35.426753+00');
INSERT INTO public.wallet VALUES ('4ca7b988-b3d3-4a2f-95b8-75c44ff171fa', '3c3eb14a-1cb3-4c2a-9ce4-fab182892704', 0.00, 0.00, 0.00, '2026-03-18 17:12:23.042698+00', '2026-03-18 17:12:23.04273+00');
INSERT INTO public.wallet VALUES ('ff88c8b8-d8bb-463d-82e2-d579e1539bb6', 'd273c2a8-8aee-4416-96e3-e13f1fdc2d99', 0.00, 0.00, 0.00, '2026-03-19 16:36:22.780402+00', '2026-03-19 16:36:22.780433+00');
INSERT INTO public.wallet VALUES ('0493a006-2fe1-4ee0-889a-eec74dbcfd55', 'f98a9851-250e-4684-a6d6-405080cd18ef', 0.00, 0.00, 0.00, '2026-02-24 02:45:59.903423+00', '2026-02-24 02:45:59.903456+00');
INSERT INTO public.wallet VALUES ('30adda38-c55c-49c5-b9c6-c928418942de', '59f24111-22f9-419c-96b9-0875e13a60aa', 0.00, 0.00, 0.00, '2026-02-24 22:23:41.528563+00', '2026-02-24 22:23:41.528615+00');
INSERT INTO public.wallet VALUES ('f7133741-5ffb-4e7a-968d-819ea45b9e3c', '42dc4d05-117c-4713-90c9-316bc4840153', 0.00, 0.00, 0.00, '2026-03-05 22:20:49.898929+00', '2026-03-05 22:20:49.899+00');
INSERT INTO public.wallet VALUES ('d6bac6f1-f86a-4386-80e9-6f798f7fb809', '2afd8ecb-a5a5-4636-bb29-0f2f3b98bc21', 0.00, 0.00, 0.00, '2026-03-09 07:22:20.466478+00', '2026-03-09 07:22:20.466514+00');
INSERT INTO public.wallet VALUES ('7e08d643-ed24-4060-a1e2-da28389727df', '01cca090-fa9a-4943-9c8f-4fc77939d997', 0.00, 0.00, 0.00, '2026-03-12 07:46:22.4388+00', '2026-03-12 07:46:22.438824+00');
INSERT INTO public.wallet VALUES ('bc2bc5fc-c7cb-4c23-b6a6-e2f1290a3085', '1d3db3ff-d369-4b9f-a066-df11f4fe1bcd', 0.00, 0.00, 0.00, '2026-03-13 15:39:30.740979+00', '2026-03-13 15:39:30.741014+00');
INSERT INTO public.wallet VALUES ('e9dfd993-4cce-4e0c-8512-06cc6fe5ed37', '6eaeb2a8-1907-4da8-93b8-bb0eeaad1440', 0.00, 0.00, 0.00, '2026-03-02 21:55:08.760566+00', '2026-03-02 21:55:08.760596+00');
INSERT INTO public.wallet VALUES ('d0cdc2d2-f820-430c-9241-516fb820ed33', 'd5d5d2ee-b299-42ab-8c75-af7bc63185a3', 0.00, 0.00, 0.00, '2026-03-11 16:41:03.306518+00', '2026-03-11 16:41:03.306565+00');
INSERT INTO public.wallet VALUES ('06e6413e-94bb-4c03-af04-40f7466f087c', '2e792e37-2d96-4764-8e62-ca1d1c57aa9f', 0.00, 0.00, 0.00, '2026-03-17 03:19:40.468912+00', '2026-03-17 03:19:40.46894+00');
INSERT INTO public.wallet VALUES ('ca4d92f6-681c-4e15-80d4-f62cf655859b', '83bd2441-22c3-47a9-b585-855be17d5b13', 0.00, 0.00, 0.00, '2026-03-17 06:41:40.755727+00', '2026-03-17 06:41:40.75576+00');
INSERT INTO public.wallet VALUES ('4a7bad09-7a6d-4aab-b1b6-5bc8fac3e9d0', 'd49b6cca-5407-4041-bfc5-98c04a082d36', 0.00, 0.00, 0.00, '2026-03-08 23:36:18.830697+00', '2026-03-08 23:36:18.83073+00');
INSERT INTO public.wallet VALUES ('34bbd30d-393c-410d-a8ca-ac8f078eeb97', 'ae6130c7-1f7d-46ae-b45f-c76d424de35a', 0.00, 0.00, 0.00, '2026-03-09 07:53:50.915398+00', '2026-03-09 07:53:50.915423+00');
INSERT INTO public.wallet VALUES ('84c7805d-3602-4bf0-908d-3f3ab8324156', '84ed6765-4c60-4fc6-af56-d292a807faf1', 0.00, 0.00, 0.00, '2026-03-10 03:45:40.160583+00', '2026-03-10 03:45:40.160615+00');
INSERT INTO public.wallet VALUES ('0c7fadd6-7c88-4951-842d-e56dc03ad33d', '017ab0e1-aa46-4445-b515-f6393d99ea33', 0.00, 0.00, 0.00, '2026-03-10 19:16:07.004772+00', '2026-03-10 19:16:07.004805+00');
INSERT INTO public.wallet VALUES ('e88baa18-1836-4963-a035-f2aff442c491', '5c83523b-174d-4afa-8176-ddde5a0420bc', 0.00, 0.00, 0.00, '2026-03-11 10:06:17.968315+00', '2026-03-11 10:06:17.968346+00');
INSERT INTO public.wallet VALUES ('5d0efe21-4512-4bb8-a029-265b1935c308', '9353ff54-83be-402f-bd2f-dee41cbd9eb7', 0.00, 0.00, 0.00, '2026-03-17 19:04:40.32062+00', '2026-03-17 19:04:40.320683+00');
INSERT INTO public.wallet VALUES ('9f3e23bb-fec7-41c7-9ccc-892bcf5b059c', '98028595-7cf3-48a4-a1fc-48dce7f4989b', 0.00, 0.00, 0.00, '2026-03-20 09:55:00.16101+00', '2026-03-20 09:55:00.161056+00');
INSERT INTO public.wallet VALUES ('bc6ded65-5646-413c-8697-2809a0f632fd', 'e136a75c-642b-45d3-a429-91c5613cb0d9', 0.00, 0.00, 0.00, '2026-03-20 18:49:03.471212+00', '2026-03-20 18:49:03.471248+00');
INSERT INTO public.wallet VALUES ('26a4d8b0-1bc7-4706-a4fb-b9a3b7fbf576', '5d133a69-17ff-477c-9209-12fa53b7fe3f', 0.00, 0.00, 0.00, '2026-03-21 06:14:48.280754+00', '2026-03-21 06:14:48.28078+00');
INSERT INTO public.wallet VALUES ('0caed264-1c59-4cc5-831c-9984d2ea3d5e', 'd0d34c27-186e-4cf8-bd3f-c6df2babf519', 0.00, 0.00, 0.00, '2026-03-22 21:32:06.987227+00', '2026-03-22 21:32:06.98726+00');
INSERT INTO public.wallet VALUES ('c4fbe14f-02a2-4a13-a42b-c51fbe796537', 'a86eaac8-70f9-4e38-98e3-ef6e2bdc9f3d', 0.00, 0.00, 0.00, '2026-03-22 21:56:26.149688+00', '2026-03-22 21:56:26.149714+00');
INSERT INTO public.wallet VALUES ('9c02c866-c741-479e-a473-1d2899d69c53', 'e703106d-2d5d-49a9-a07c-95c70c3a883d', 0.00, 0.00, 0.00, '2026-03-22 22:11:05.987293+00', '2026-03-22 22:11:05.987322+00');
INSERT INTO public.wallet VALUES ('e7b42032-41f7-492d-ace1-7c8ad8b72525', '44b19b3c-8644-4f85-94b8-3fa7643ba876', 0.00, 0.00, 0.00, '2026-03-22 22:12:43.669107+00', '2026-03-22 22:12:43.669153+00');
INSERT INTO public.wallet VALUES ('b55e2441-efb5-4a7c-96f7-e4490d3a60cb', '46c002ce-5c74-441a-a3f1-03e12bd91d6e', 0.00, 0.00, 0.00, '2026-03-22 22:38:44.761186+00', '2026-03-22 22:38:44.761223+00');
INSERT INTO public.wallet VALUES ('63d28898-756c-4aa1-9e49-fb072982523d', 'f2eba937-872e-43a1-b847-24605a828f6b', 0.00, 0.00, 0.00, '2026-03-22 23:09:02.913374+00', '2026-03-22 23:09:02.913413+00');
INSERT INTO public.wallet VALUES ('f13aa198-2a49-4fdd-a9ab-e9ddb5820bd4', 'c29bb098-2098-4764-a82e-22a696c35d1a', 0.00, 0.00, 0.00, '2026-03-22 23:17:49.610325+00', '2026-03-22 23:17:49.610361+00');
INSERT INTO public.wallet VALUES ('c867b9fc-0f03-4a41-9767-5d0dc6e78c96', 'fa275ee2-722e-4f45-8de4-db025dcd07e7', 0.00, 0.00, 0.00, '2026-03-22 23:19:52.130298+00', '2026-03-22 23:19:52.13032+00');
INSERT INTO public.wallet VALUES ('4d295797-2531-467b-8de6-0645eb391e9d', '9d966c66-7429-4953-8dd7-44b049236853', 0.00, 0.00, 0.00, '2026-03-23 05:04:10.243977+00', '2026-03-23 05:04:10.243999+00');
INSERT INTO public.wallet VALUES ('a8b67cea-5307-4547-a497-021e5040cdd5', 'ddca0834-f182-4d42-bff6-30d12e7b0017', 0.00, 0.00, 0.00, '2026-03-23 06:51:37.642207+00', '2026-03-23 06:51:37.642236+00');
INSERT INTO public.wallet VALUES ('6b4a07b9-7caa-4c17-8517-914aac0f876e', '65c25926-85a8-48d7-804d-a9af48d98f08', 0.00, 0.00, 0.00, '2026-03-23 06:52:39.82225+00', '2026-03-23 06:52:39.822273+00');
INSERT INTO public.wallet VALUES ('040e1818-5f7b-444c-859e-40d2a5f174d5', 'd2b82529-f47e-4b55-909b-63277eae69eb', 0.00, 0.00, 0.00, '2026-03-23 09:12:19.792269+00', '2026-03-23 09:12:19.792295+00');
INSERT INTO public.wallet VALUES ('33ef6f8e-8347-49a2-a865-764732731879', '4e59be3d-c606-4b17-ad72-a5be0ea21f51', 0.00, 0.00, 0.00, '2026-03-23 09:20:34.142025+00', '2026-03-23 09:20:34.142052+00');
INSERT INTO public.wallet VALUES ('ef19241a-15a3-4f04-aaf4-cca1be1abbaa', '5760b083-0847-4acb-9b9c-fff78dfc0e4d', 0.00, 0.00, 0.00, '2026-03-23 09:21:04.046111+00', '2026-03-23 09:21:04.046144+00');
INSERT INTO public.wallet VALUES ('a2e9027e-9332-4493-8cdf-c5809faaeb7b', '392683d2-2e31-45b5-a188-c822a514db47', 0.00, 0.00, 0.00, '2026-03-23 13:07:42.519974+00', '2026-03-23 13:07:42.520011+00');
INSERT INTO public.wallet VALUES ('ed735678-f85f-4e51-b59b-04c850b2db9f', '95e69f32-f19b-440c-9c7b-635d88fc7878', 0.00, 0.00, 0.00, '2026-03-23 15:06:17.424761+00', '2026-03-23 15:06:17.424796+00');
INSERT INTO public.wallet VALUES ('3392dd6e-3673-41e0-ad0b-ef1503c74a58', '5cc10917-d39c-4161-a7ff-3766f5dd80ea', 0.00, 0.00, 0.00, '2026-03-23 15:44:23.885784+00', '2026-03-23 15:44:23.885817+00');
INSERT INTO public.wallet VALUES ('c0832c28-009b-476c-8c6e-959147c10edb', '63f400e7-a95d-455d-be12-4e809e4803d2', 0.00, 0.00, 0.00, '2026-03-23 16:56:14.365246+00', '2026-03-23 16:56:14.365276+00');
INSERT INTO public.wallet VALUES ('d670b35b-7f9a-4c99-bf57-542df41963e4', 'b884adf5-c8c6-4244-a909-43b5b2beed48', 0.00, 0.00, 0.00, '2026-03-23 18:13:03.777778+00', '2026-03-23 18:13:03.777798+00');
INSERT INTO public.wallet VALUES ('e9eec94b-8632-4839-b174-9076a111d5b1', 'a0e4571c-9a62-468d-93d6-4b98e8a9d494', 0.00, 0.00, 0.00, '2026-03-23 19:50:04.161315+00', '2026-03-23 19:50:04.161345+00');
INSERT INTO public.wallet VALUES ('fe3ff8e1-1ddb-4237-b106-6626a80615f1', '0a479b49-b538-4a7c-a068-407cc138a8a1', 0.00, 0.00, 0.00, '2026-03-23 21:06:29.327947+00', '2026-03-23 21:06:29.327975+00');
INSERT INTO public.wallet VALUES ('50c8fa6d-ba3c-44d7-8229-b096eac14f3b', '78307d5d-0236-4681-a43d-c9e457337d90', 0.00, 0.00, 0.00, '2026-03-24 01:26:51.151769+00', '2026-03-24 01:26:51.151801+00');
INSERT INTO public.wallet VALUES ('c0ec2faa-95fe-442b-9e90-22ac841ced20', '9409b05d-1b28-4636-8e09-40681b93b531', 0.00, 0.00, 0.00, '2026-03-24 14:43:50.115406+00', '2026-03-24 14:43:50.115438+00');
INSERT INTO public.wallet VALUES ('8f27f53d-7f25-4064-b8c9-e835dd4bce21', 'e47898ad-7c5e-4cc7-b17f-c35fcc483f45', 0.00, 0.00, 0.00, '2026-03-24 15:42:40.465098+00', '2026-03-24 15:42:40.465121+00');
INSERT INTO public.wallet VALUES ('1880be9c-3eab-4d36-8cff-c235478bcda1', 'c0af5ae8-550f-4b5d-aa77-6ec7223fc59b', 0.00, 0.00, 0.00, '2026-03-24 21:55:45.76604+00', '2026-03-24 21:55:45.766076+00');
INSERT INTO public.wallet VALUES ('c28d79ec-548c-417f-9352-dc71d0368b27', '49562463-6034-4392-8ef0-29340c128566', 0.00, 0.00, 0.00, '2026-03-25 10:39:39.219341+00', '2026-03-25 10:39:39.219424+00');
INSERT INTO public.wallet VALUES ('c9b5465c-7c7b-4d70-b308-2356c7bb7fff', '4b23256e-5bc4-45c9-ab92-f5ac6d4e954a', 0.00, 0.00, 0.00, '2026-03-25 22:47:44.916346+00', '2026-03-25 22:47:44.916383+00');
INSERT INTO public.wallet VALUES ('444c8b0e-e65c-4921-8ff7-b1609df8c46c', '117821b3-512b-45df-874e-63cee7dded85', 0.00, 0.00, 0.00, '2026-03-26 17:33:37.811818+00', '2026-03-26 17:33:37.811859+00');
INSERT INTO public.wallet VALUES ('2c591d40-8c18-465c-a7de-99cc0e94af49', 'd6e2153d-1524-4da1-9f08-c70ac3f03b4d', 0.00, 0.00, 0.00, '2026-03-26 22:17:34.04696+00', '2026-03-26 22:17:34.046976+00');
INSERT INTO public.wallet VALUES ('3fd0dcd4-4d95-4fb9-b70e-94a40b42ab51', '05a52191-606e-4162-83de-1ae1538ae4c4', 0.00, 0.00, 0.00, '2026-03-28 01:14:07.120027+00', '2026-03-28 01:14:07.120077+00');
INSERT INTO public.wallet VALUES ('4bb22d59-299e-4adb-ba12-563929b23dad', 'c500fce7-d748-4f4c-92f5-0483f1b36245', 0.00, 0.00, 0.00, '2026-03-29 15:46:50.44677+00', '2026-03-29 15:46:50.446803+00');
INSERT INTO public.wallet VALUES ('83e3e821-3a0e-4672-8633-d951944ed0d0', '6044e04e-7ae1-4c2f-be7e-c6dcd7059814', 0.00, 0.00, 0.00, '2026-03-30 06:08:03.007759+00', '2026-03-30 06:08:03.007829+00');
INSERT INTO public.wallet VALUES ('2b7b99bf-b40e-49f6-a1f2-b9f40bf14c20', '60cdb8f3-b010-49e0-94f7-c98602aa721a', 0.00, 0.00, 0.00, '2026-03-31 00:36:37.591614+00', '2026-03-31 00:36:37.591675+00');
INSERT INTO public.wallet VALUES ('bdf263b2-2402-4738-97ee-51ddbe448ea7', '871d84dd-8fc8-403e-b2d1-5a313a66a4c3', 0.00, 0.00, 0.00, '2026-03-31 20:59:58.712583+00', '2026-03-31 20:59:58.712614+00');
INSERT INTO public.wallet VALUES ('30637c9e-c9be-4a8e-beae-4e4469afdc6e', '73770b01-1454-4df8-8717-691b21193af2', 0.00, 0.00, 0.00, '2026-03-31 22:01:51.015568+00', '2026-03-31 22:01:51.015602+00');
INSERT INTO public.wallet VALUES ('6b4db285-6aea-4cdd-9b48-4c10b7184977', '56be700d-941a-42dc-b97f-4838fb2ec581', 0.00, 0.00, 0.00, '2026-04-02 07:21:44.999655+00', '2026-04-02 07:21:44.999804+00');
INSERT INTO public.wallet VALUES ('2ecc3ee3-12e4-4773-ab3a-bbf2ad71a09b', '2aa5b020-6f9c-4ec1-9163-c406f208b3f4', 0.00, 0.00, 0.00, '2026-04-03 18:51:43.65407+00', '2026-04-03 18:51:43.654092+00');
INSERT INTO public.wallet VALUES ('d3638958-bf1c-4fe5-a38a-7a1d5cd4630e', '0935fae4-1023-41f0-81c0-021e05e2a7f1', 0.00, 0.00, 0.00, '2026-04-03 19:52:49.403738+00', '2026-04-03 19:52:49.403775+00');
INSERT INTO public.wallet VALUES ('bfc72ea0-bfc4-4551-bad0-16b5960b33f6', '31dc20f9-1892-425d-ad9e-7aa2a26f31e4', 0.00, 0.00, 0.00, '2026-04-05 21:58:25.129637+00', '2026-04-05 21:58:25.129669+00');
INSERT INTO public.wallet VALUES ('8dbf9bb5-2631-4255-9b7e-2ee9951b99e9', '7689c4fc-b39f-4808-aaa7-66cff98fcda5', 0.00, 0.00, 0.00, '2026-04-06 03:27:35.869255+00', '2026-04-06 03:27:35.869343+00');
INSERT INTO public.wallet VALUES ('1a81597e-f0a1-41b4-9000-f1f1f3c35f9c', '7d4616a9-6a29-428e-aafc-e3f37f560e27', 0.00, 0.00, 0.00, '2026-04-06 07:38:43.35317+00', '2026-04-06 07:38:43.353209+00');
INSERT INTO public.wallet VALUES ('89ebf021-8157-4101-b919-3829af985dbb', '5f48d678-756b-4370-bb91-086f34bb1223', 0.00, 0.00, 0.00, '2026-04-06 14:32:59.196+00', '2026-04-06 14:32:59.196032+00');
INSERT INTO public.wallet VALUES ('9daa903e-4914-4192-8944-07d596ca3d2a', '9dfb00f6-cf74-4f9b-8720-e81d3e39832e', 0.00, 0.00, 0.00, '2026-04-06 14:57:18.308604+00', '2026-04-06 14:57:18.308637+00');
INSERT INTO public.wallet VALUES ('07b7729b-3af5-4ff5-8b26-7d525361cf03', '36dfeb0b-470f-4e8d-bc14-7d88acf66ef6', 0.00, 0.00, 0.00, '2026-04-06 17:42:11.531981+00', '2026-04-06 17:42:11.532012+00');
INSERT INTO public.wallet VALUES ('5f395ca2-c386-4c33-b57e-c6c2d9756da6', '3a5e5757-5433-4732-819f-4c19ca97022c', 0.00, 0.00, 0.00, '2026-04-07 21:35:44.437229+00', '2026-04-07 21:35:44.437258+00');
INSERT INTO public.wallet VALUES ('19600825-1e36-49f5-aa07-75860849b991', '79f159cb-439d-4d67-b018-eca66103f9b0', 0.00, 0.00, 0.00, '2026-04-09 20:49:29.225645+00', '2026-04-09 20:49:29.225819+00');
INSERT INTO public.wallet VALUES ('a01d65c4-e9af-4124-bd80-87df7bf5881e', '6e9533d9-7154-4f4d-b0bb-48f1f49c37e3', 0.00, 0.00, 0.00, '2026-04-10 14:59:49.099392+00', '2026-04-10 14:59:49.099554+00');
INSERT INTO public.wallet VALUES ('b2566741-024e-4dda-820d-aac47413ec34', 'f3e3ab0c-1b7e-4d65-a9d3-47db92c89c4f', 0.00, 0.00, 0.00, '2026-04-11 18:13:50.374909+00', '2026-04-11 18:13:50.376758+00');
INSERT INTO public.wallet VALUES ('62e13e2e-dc7c-4624-ae82-68936679497f', 'b413cf7a-c153-47c3-94a0-d8ecaba7f777', 0.00, 0.00, 0.00, '2026-04-13 07:22:19.48413+00', '2026-04-13 07:22:19.484365+00');
INSERT INTO public.wallet VALUES ('e73dbb66-fe61-4abd-a5a2-99e6cf2cf03e', '788204f1-e47f-4d5e-95d1-97ac91cc85d3', 0.00, 0.00, 0.00, '2026-04-16 21:45:14.708962+00', '2026-04-16 21:45:14.708995+00');
INSERT INTO public.wallet VALUES ('1d5bebbf-4d97-4506-a286-cf5090aaecb3', '2d5b896e-f2bf-441c-8af2-cb52881f7888', 0.00, 0.00, 0.00, '2026-04-19 21:36:52.994086+00', '2026-04-19 21:36:52.994271+00');
INSERT INTO public.wallet VALUES ('51d268ed-bbdb-4a37-89cc-b4bc17bd3a41', '02c18c97-8001-49bd-8e4b-622f8c4d1bc1', 0.00, 0.00, 0.00, '2026-04-20 15:32:26.584104+00', '2026-04-20 15:32:26.584136+00');
INSERT INTO public.wallet VALUES ('83ca655f-8d04-40a3-988f-ba8ced78aa6c', 'ae1aea80-368f-4dc3-bd20-8e7a809233fe', 0.00, 0.00, 0.00, '2026-04-20 17:09:00.436799+00', '2026-04-20 17:09:00.436834+00');
INSERT INTO public.wallet VALUES ('0531bb57-1031-4edd-9e02-c8f206f728b7', 'bfdde58e-5200-4b0f-b930-6ad7be5e5ad4', 0.00, 0.00, 0.00, '2026-04-22 11:21:41.559156+00', '2026-04-22 11:21:41.559189+00');
INSERT INTO public.wallet VALUES ('02d6b459-dbc8-4114-914a-d28f0c37f306', 'b2389bfc-4278-4335-a11e-f8b43f8951f6', 0.00, 0.00, 0.00, '2026-04-23 11:58:12.966989+00', '2026-04-23 11:58:12.967139+00');
INSERT INTO public.wallet VALUES ('57396fcd-43a5-4ddb-bbe6-610e343fa4d7', '30608326-8d07-4496-a1e8-6d3145cf5505', 0.00, 0.00, 0.00, '2026-05-10 16:25:15.6757+00', '2026-05-10 16:25:15.675888+00');
INSERT INTO public.wallet VALUES ('c69a904a-540e-4794-8440-f5132c94753c', '2c044836-c66d-40ba-8bc9-22dc39bab51f', 0.00, 0.00, 0.00, '2026-05-11 07:49:49.90379+00', '2026-05-11 07:49:49.903826+00');
INSERT INTO public.wallet VALUES ('7c525959-05fc-42ed-bee7-d49faf18e3f7', '52ef8fdc-2d92-4064-9412-f47cad74d202', 0.00, 0.00, 0.00, '2026-05-12 02:20:25.301418+00', '2026-05-12 02:20:25.301447+00');
INSERT INTO public.wallet VALUES ('217edc25-5a3c-4a01-b327-7ba4ed215659', 'a61e0798-ca5c-411a-a291-36ef7137a03d', 0.00, 0.00, 0.00, '2026-05-13 17:30:28.534844+00', '2026-05-13 17:30:28.535022+00');
INSERT INTO public.wallet VALUES ('0ed32907-7a5d-4a6a-9d3d-c819cf4d6791', '7be4fb31-3a68-4ec8-a0ac-c42ed987be58', 0.00, 0.00, 0.00, '2026-05-16 19:10:51.550644+00', '2026-05-16 19:10:51.550772+00');
INSERT INTO public.wallet VALUES ('04ed9087-58ce-46f0-98e0-159bd584a0c9', '6aa0f3e5-e16b-4b9f-89fd-2a6281517059', 0.00, 0.00, 0.00, '2026-05-17 21:18:06.488681+00', '2026-05-17 21:18:06.488718+00');
INSERT INTO public.wallet VALUES ('6b88926c-a254-4a5c-bc44-f809d7414c9f', '4a6be98c-a071-4f5c-8b3a-53d4b76197e0', 0.00, 0.00, 0.00, '2026-05-18 12:55:05.640254+00', '2026-05-18 12:55:05.640288+00');
INSERT INTO public.wallet VALUES ('391747be-805c-412e-83f2-3c6b3c13d186', 'dc5bdf42-f999-45ff-8ca3-be9e34e2cdab', 0.00, 0.00, 0.00, '2026-05-21 15:44:26.902449+00', '2026-05-21 15:44:26.902621+00');
INSERT INTO public.wallet VALUES ('30aa3205-19c0-46c4-8089-33a3643f54a1', 'dec82e3e-1e4c-43f6-bc96-e3025e1d320f', 0.00, 0.00, 0.00, '2026-05-22 19:00:14.677095+00', '2026-05-22 19:00:14.677186+00');
INSERT INTO public.wallet VALUES ('caa118e4-09d9-43bc-af12-1469d9693b9f', '848369bd-4332-4d39-a562-a8911934c2e4', 0.00, 0.00, 0.00, '2026-05-24 09:17:41.359046+00', '2026-05-24 09:17:41.359079+00');
INSERT INTO public.wallet VALUES ('a5e87642-4104-4cfd-8ac1-f91c751dee69', '426f28ba-2164-4fc8-95c1-9537cd4f0c68', 0.00, 0.00, 0.00, '2026-05-24 21:43:41.69481+00', '2026-05-24 21:43:41.694831+00');
INSERT INTO public.wallet VALUES ('eec6aa1f-0cce-4b0c-9f87-8ce1e3a5e840', 'd8f1de5a-ca84-4dd4-aee9-1abf76fdb3fb', 0.00, 0.00, 0.00, '2026-05-25 13:25:23.478725+00', '2026-05-25 13:25:23.478747+00');
INSERT INTO public.wallet VALUES ('c65949ee-f422-47be-a214-f77f4cae7fa4', '68b673e0-47e6-45e2-8ba9-063c9c162f0f', 0.00, 0.00, 0.00, '2026-05-27 02:09:04.357596+00', '2026-05-27 02:09:04.357625+00');
INSERT INTO public.wallet VALUES ('62cace39-7acb-4733-9c8e-f9f480779407', '728325d7-983d-4805-af76-85fd4da281ff', 0.00, 0.00, 0.00, '2026-05-30 10:28:18.931182+00', '2026-05-30 10:28:18.931206+00');
INSERT INTO public.wallet VALUES ('27280ce6-7ab5-4167-813c-c353e49c9c70', '002cd1d4-cb73-4d30-a88b-ff4843b1350e', 0.00, 0.00, 0.00, '2026-05-31 17:30:36.820531+00', '2026-05-31 17:30:36.820556+00');
INSERT INTO public.wallet VALUES ('e9a58e59-8cd0-4ff0-a1d1-264fe2874689', '15dcf75b-efbd-40cb-8717-6bb523cefeb5', 0.00, 0.00, 0.00, '2026-05-31 17:52:08.212094+00', '2026-05-31 17:52:08.212128+00');
INSERT INTO public.wallet VALUES ('bbe3896e-6b53-4800-a187-fa98f90f16a9', '61f05846-ecff-4239-81a3-6cbbd83a9507', 0.00, 0.00, 0.00, '2026-05-31 20:33:41.343183+00', '2026-05-31 20:33:41.343205+00');
INSERT INTO public.wallet VALUES ('4159d22a-134d-4bf6-96e2-63abc35de79e', '6a4d2799-9c20-41dc-aad1-1664d54c549b', 0.00, 0.00, 0.00, '2026-06-01 10:48:31.64831+00', '2026-06-01 10:48:31.648494+00');
INSERT INTO public.wallet VALUES ('6587f2b2-c232-460f-9e28-84f235992084', 'c93181c0-3f52-402a-a47b-0084e77626c8', 0.00, 0.00, 0.00, '2026-06-01 18:59:59.438061+00', '2026-06-01 18:59:59.438078+00');
INSERT INTO public.wallet VALUES ('f82467ea-624f-4712-a398-ca398d835778', 'b98801af-c8e8-4551-a099-4445870b9db8', 0.00, 0.00, 0.00, '2026-06-02 12:04:59.960605+00', '2026-06-02 12:04:59.960771+00');
INSERT INTO public.wallet VALUES ('70536883-4963-4f3d-89bd-6b7ff9b8c249', '2534a41d-bac9-42c2-a32b-2f036b194dc7', 0.00, 0.00, 0.00, '2026-06-05 13:33:29.859002+00', '2026-06-05 13:33:29.859128+00');
INSERT INTO public.wallet VALUES ('3e4d592b-041b-4aac-902d-fc80e4ecddd1', '59e585ca-2b79-4bc9-bd6d-8fd070b65fec', 0.00, 0.00, 0.00, '2026-06-05 16:10:35.904602+00', '2026-06-05 16:10:35.904639+00');
INSERT INTO public.wallet VALUES ('1d90d8e8-109a-4923-9b32-835657bb7b8f', '4ac64f55-c79d-4b2a-b82e-0b127b6eca59', 0.00, 0.00, 0.00, '2026-06-05 19:08:13.745366+00', '2026-06-05 19:08:13.745391+00');
INSERT INTO public.wallet VALUES ('9151ec57-1f5a-4f21-9e37-1a0e4e5d23b5', 'd7a8b7d6-7bfa-46df-a69c-c4fbaba27bc1', 0.00, 0.00, 0.00, '2026-06-06 10:42:03.61901+00', '2026-06-06 10:42:03.619057+00');
INSERT INTO public.wallet VALUES ('53c4a20b-c569-48d1-8117-289f7663ce08', 'b2491a47-cc7e-4104-a68e-9be0fe7bf9bd', 0.00, 0.00, 0.00, '2026-06-06 13:59:13.544809+00', '2026-06-06 13:59:13.544839+00');
INSERT INTO public.wallet VALUES ('d070bb2a-02be-4d8e-bcc8-46315b790704', 'b6bc5f9d-8790-4ac0-bf74-9ddce9949c7a', 0.00, 0.00, 0.00, '2026-06-08 15:21:00.721653+00', '2026-06-08 15:21:00.721684+00');
INSERT INTO public.wallet VALUES ('4c684864-9e33-4691-9f10-3813d48967af', 'dd430a39-7490-4534-821d-64d1c932eb77', 0.00, 0.00, 0.00, '2026-06-09 18:02:59.844208+00', '2026-06-09 18:02:59.844261+00');
INSERT INTO public.wallet VALUES ('293acc97-dd75-4e9c-997a-29be5d58cc4b', '55af015b-c2de-4b6c-a312-079a927d133d', 0.00, 0.00, 0.00, '2026-06-10 19:23:37.642251+00', '2026-06-10 19:23:37.642267+00');
INSERT INTO public.wallet VALUES ('d0eb65da-0560-4766-a380-f6a957bbb19e', 'c65b3f0a-fc4b-4cc3-a4be-d5816ffc76b7', 0.00, 0.00, 0.00, '2026-06-11 17:42:57.701255+00', '2026-06-11 17:42:57.701284+00');
INSERT INTO public.wallet VALUES ('01202c8f-8c11-4610-90de-60cc05e440ab', '69ecfa10-7252-46bc-bc6a-8baf9806be94', 0.00, 0.00, 0.00, '2026-06-11 19:56:31.132788+00', '2026-06-11 19:56:31.132819+00');
INSERT INTO public.wallet VALUES ('5c0774a6-36a8-4ae5-b7a0-dbb18e5f5449', 'd7a308ab-e4e5-4515-b232-559597d2d540', 0.00, 0.00, 0.00, '2026-06-12 18:04:13.189679+00', '2026-06-12 18:04:13.191033+00');
INSERT INTO public.wallet VALUES ('9f373454-774a-4820-a4f8-ee6aa13f31c8', '60713359-ffc6-4bfc-9e4f-389a113f3f1e', 0.00, 0.00, 0.00, '2026-06-14 21:45:25.138573+00', '2026-06-14 21:45:25.138605+00');
INSERT INTO public.wallet VALUES ('4305fe05-7692-4a45-a325-cb89005eb03a', '226112b2-d17e-4552-a5fd-6de0eb1eeb8d', 0.00, 0.00, 0.00, '2026-06-15 03:38:25.483327+00', '2026-06-15 03:38:25.483397+00');
INSERT INTO public.wallet VALUES ('98de9268-fd41-41e4-bbd7-e204eb4765f3', 'c650a86b-2ce6-42d9-bd2a-a1aab7f95ab6', 0.00, 0.00, 0.00, '2026-06-15 15:10:16.290087+00', '2026-06-15 15:10:16.290134+00');
INSERT INTO public.wallet VALUES ('204ae777-42bb-4e00-9bc6-6e32c138ecef', 'c8f76d42-be95-4e3a-8184-36dcf7af13e8', 0.00, 0.00, 0.00, '2026-06-15 21:27:01.167287+00', '2026-06-15 21:27:01.167314+00');
INSERT INTO public.wallet VALUES ('d63dd404-98f4-436e-92e8-fd9447617d53', '35ef0df4-da67-418b-ae95-bbb2cd860478', 0.00, 0.00, 0.00, '2026-06-21 08:26:35.375963+00', '2026-06-21 08:26:35.376109+00');
INSERT INTO public.wallet VALUES ('3d588100-360f-4d30-816c-f2fef9d57d20', '93e8d6da-b0c7-4ad5-b606-9fce458efde6', 0.00, 0.00, 0.00, '2026-06-21 19:03:38.671642+00', '2026-06-21 19:03:38.671667+00');
INSERT INTO public.wallet VALUES ('abed8348-c13b-48ef-8752-92dbe23cfa1a', '9ecc2150-e7b8-472f-89c3-a98a0cce971e', 0.00, 0.00, 0.00, '2026-06-22 08:28:21.58906+00', '2026-06-22 08:28:21.589087+00');
INSERT INTO public.wallet VALUES ('666fab5e-65cd-41e4-a786-218bab6ff199', 'a25b21d3-d2ad-44d9-9177-460f646e6338', 0.00, 0.00, 0.00, '2026-06-28 16:03:49.253701+00', '2026-06-28 16:03:49.25373+00');
INSERT INTO public.wallet VALUES ('23410f8c-7ca1-4b31-b7b3-23a3f584e098', '1f08a2d5-f7bc-4beb-bbe6-bf19110ff819', 0.00, 0.00, 0.00, '2026-06-28 21:26:04.153698+00', '2026-06-28 21:26:04.153733+00');
INSERT INTO public.wallet VALUES ('d5b2d734-bc7c-429c-a619-12d988d944f6', 'a694827e-a8f7-4131-8195-e148a42a8802', 0.00, 0.00, 0.00, '2026-06-29 08:48:05.649568+00', '2026-06-29 08:48:05.649597+00');
INSERT INTO public.wallet VALUES ('3e8325fb-3aee-4a73-a2fd-f5a7858ee08c', 'f0f192b9-5327-4f62-922c-8a3e1c84a802', 0.00, 0.00, 0.00, '2026-07-01 08:31:11.90327+00', '2026-07-01 08:31:11.90334+00');
INSERT INTO public.wallet VALUES ('3ba2f1dd-658d-456d-9e0d-d5f54de5bef8', 'fc2ab9b2-faf8-4f6e-a5ba-b5ef448cf25c', 0.00, 0.00, 0.00, '2026-07-02 07:33:31.989096+00', '2026-07-02 07:33:31.989126+00');
INSERT INTO public.wallet VALUES ('22597ffe-9784-4769-a0cf-2179332d791a', '6909da54-677e-4484-9105-563de2303a81', 0.00, 0.00, 0.00, '2026-07-02 10:57:41.530825+00', '2026-07-02 10:57:41.531026+00');
INSERT INTO public.wallet VALUES ('0b60519e-3ac6-48e8-a1f1-0ca2c5b66bff', '15210855-7cd7-44b4-84fd-3a5277d8bce4', 0.00, 0.00, 0.00, '2026-07-04 08:05:40.142692+00', '2026-07-04 08:05:40.142891+00');
INSERT INTO public.wallet VALUES ('e0393622-110c-4385-ae1b-e55138a758df', 'd0545d50-ba23-4113-8a6f-00beb9db8f85', 0.00, 0.00, 0.00, '2026-07-04 16:32:13.117371+00', '2026-07-04 16:32:13.117582+00');
INSERT INTO public.wallet VALUES ('278865ca-a6d7-4bb6-a8da-bc801b097975', 'a3d05de6-0b55-4ed1-9166-de116f808118', 0.00, 0.00, 0.00, '2026-07-05 11:02:51.971215+00', '2026-07-05 11:02:51.97135+00');
INSERT INTO public.wallet VALUES ('adad6043-fe83-408c-907f-7c120454e326', '5f2ca9b7-ca19-4fd6-9e69-61f9a8fa0a59', 0.00, 0.00, 0.00, '2026-07-05 16:05:46.080744+00', '2026-07-05 16:05:46.080759+00');
INSERT INTO public.wallet VALUES ('f2b639d1-7e3a-45e1-b2cd-afb019587c65', 'a92ed4e1-fa82-4019-bb60-5310f9179fd8', 0.00, 0.00, 0.00, '2026-07-05 18:17:13.349029+00', '2026-07-05 18:17:13.349054+00');
INSERT INTO public.wallet VALUES ('29bbc4a8-0564-4798-950c-d36b62770fa1', 'ffe00839-1853-4390-a312-9d69c769f778', 0.00, 0.00, 0.00, '2026-07-08 16:16:16.822962+00', '2026-07-08 16:16:16.823108+00');
INSERT INTO public.wallet VALUES ('04d9238b-0803-48c4-a91d-3494d53932cd', '42be05f7-9fc1-45a6-9091-824e4357bce5', 0.00, 0.00, 0.00, '2026-07-10 21:54:02.940644+00', '2026-07-10 21:54:02.940862+00');
INSERT INTO public.wallet VALUES ('9b026b28-ec6b-4c4d-9aad-9f80960e4807', 'c66b9f88-9217-4e96-9aa2-c5fc67fa0820', 0.00, 0.00, 0.00, '2026-07-12 19:47:33.753879+00', '2026-07-12 19:47:33.754103+00');
INSERT INTO public.wallet VALUES ('7096d373-6c2d-49e1-9f9e-c0961ad3107a', '874f51d7-84de-489b-8d99-665726d448e9', 0.00, 0.00, 0.00, '2026-07-12 20:05:27.591423+00', '2026-07-12 20:05:27.591664+00');
INSERT INTO public.wallet VALUES ('924b95da-dc13-4a19-95d4-440180f1a170', '8b907742-322c-415d-aa08-0c7f98518e4a', 0.00, 0.00, 0.00, '2026-07-16 01:00:52.385063+00', '2026-07-16 01:00:52.385442+00');
INSERT INTO public.wallet VALUES ('3df33ca8-1e73-4ac8-a1a5-6ae50a3ffb56', '88cb62a9-0143-4e3f-8fe6-cadae37b6e1c', 0.00, 0.00, 0.00, '2026-07-18 08:29:01.075658+00', '2026-07-18 08:29:01.075673+00');
INSERT INTO public.wallet VALUES ('c12782b9-24e0-4c49-8bc1-c7383494496b', 'eebb0cf3-25eb-4c3a-8d9b-42d88f8fd4e0', 0.00, 0.00, 0.00, '2026-07-19 20:10:51.191872+00', '2026-07-19 20:10:51.19189+00');
INSERT INTO public.wallet VALUES ('69a52f4f-d575-4724-89da-afea8e75c514', '75d45b65-c2d5-4244-9723-174152621383', 0.00, 0.00, 0.00, '2026-07-20 09:00:30.213354+00', '2026-07-20 09:00:30.213373+00');
INSERT INTO public.wallet VALUES ('c77f93bc-80ff-4806-8139-358131531af9', 'e5c7d69a-f413-412e-b3cc-e70a24c79222', 0.00, 0.00, 0.00, '2026-07-27 16:39:53.220723+00', '2026-07-27 16:39:53.220912+00');
INSERT INTO public.wallet VALUES ('692082b4-2538-4a90-808b-2eb5019453eb', 'b5340560-9a5d-48d1-a3df-6ad3c48ddce3', 0.00, 0.00, 0.00, '2026-07-28 03:54:57.60312+00', '2026-07-28 03:54:57.6033+00');
INSERT INTO public.wallet VALUES ('52dd479e-6a8b-4147-ba65-3bfd40c358c2', 'ce2d5352-d8a8-4bc6-bba4-73c144449f1a', 0.00, 0.00, 0.00, '2026-07-28 14:59:16.688272+00', '2026-07-28 14:59:16.688288+00');
INSERT INTO public.wallet VALUES ('060b94ba-ea98-43e1-aee7-1b0febd6d393', '4cbd3ba0-afa6-476a-b7cb-323d0175d32a', 0.00, 0.00, 0.00, '2026-07-29 19:03:02.425803+00', '2026-07-29 19:03:02.425825+00');
INSERT INTO public.wallet VALUES ('de0df157-175b-46e6-aae2-9295e5911e2f', '7cfcb296-5fb8-412d-83d6-e273895d2b06', 0.00, 0.00, 0.00, '2026-08-02 20:54:00.175699+00', '2026-08-02 20:54:00.175721+00');
INSERT INTO public.wallet VALUES ('c0a195c0-e08e-459a-b035-8f6cf65bb5c8', '834c26d2-707d-4bc5-9843-a5022f5269cc', 0.00, 0.00, 0.00, '2026-08-06 18:48:03.211719+00', '2026-08-06 18:48:03.212078+00');


--
-- Data for Name: withdrawal_request; Type: TABLE DATA; Schema: public; Owner: propfirmsol_samdav
--



--
-- Name: admin admin_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.admin
    ADD CONSTRAINT admin_pkey PRIMARY KEY (id);


--
-- Name: affiliate_settings affiliate_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.affiliate_settings
    ADD CONSTRAINT affiliate_settings_pkey PRIMARY KEY (id);


--
-- Name: affiliate_settings affiliate_settings_user_id_key; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.affiliate_settings
    ADD CONSTRAINT affiliate_settings_user_id_key UNIQUE (user_id);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: banner banner_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.banner
    ADD CONSTRAINT banner_pkey PRIMARY KEY (id);


--
-- Name: booking_link booking_link_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.booking_link
    ADD CONSTRAINT booking_link_pkey PRIMARY KEY (id);


--
-- Name: cryptopayment cryptopayment_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.cryptopayment
    ADD CONSTRAINT cryptopayment_pkey PRIMARY KEY (id);


--
-- Name: discount_codes discount_codes_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.discount_codes
    ADD CONSTRAINT discount_codes_pkey PRIMARY KEY (id);


--
-- Name: global_affiliate_settings global_affiliate_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.global_affiliate_settings
    ADD CONSTRAINT global_affiliate_settings_pkey PRIMARY KEY (id);


--
-- Name: notification notification_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_pkey PRIMARY KEY (id);


--
-- Name: payment payment_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_pkey PRIMARY KEY (id);


--
-- Name: prop_firm_plan prop_firm_plan_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.prop_firm_plan
    ADD CONSTRAINT prop_firm_plan_pkey PRIMARY KEY (id);


--
-- Name: prop_firm_plan_price prop_firm_plan_price_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.prop_firm_plan_price
    ADD CONSTRAINT prop_firm_plan_price_pkey PRIMARY KEY (id);


--
-- Name: prop_firm_registration prop_firm_registration_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.prop_firm_registration
    ADD CONSTRAINT prop_firm_registration_pkey PRIMARY KEY (id);


--
-- Name: referral_earning referral_earning_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.referral_earning
    ADD CONSTRAINT referral_earning_pkey PRIMARY KEY (id);


--
-- Name: support_message support_message_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.support_message
    ADD CONSTRAINT support_message_pkey PRIMARY KEY (id);


--
-- Name: support support_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.support
    ADD CONSTRAINT support_pkey PRIMARY KEY (id);


--
-- Name: support_ticket support_ticket_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.support_ticket
    ADD CONSTRAINT support_ticket_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: user_discount user_discount_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.user_discount
    ADD CONSTRAINT user_discount_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: user_purchased_package user_purchased_package_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.user_purchased_package
    ADD CONSTRAINT user_purchased_package_pkey PRIMARY KEY (id);


--
-- Name: vat vat_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.vat
    ADD CONSTRAINT vat_pkey PRIMARY KEY (id);


--
-- Name: wallet wallet_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.wallet
    ADD CONSTRAINT wallet_pkey PRIMARY KEY (id);


--
-- Name: wallet wallet_user_id_key; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.wallet
    ADD CONSTRAINT wallet_user_id_key UNIQUE (user_id);


--
-- Name: withdrawal_request withdrawal_request_pkey; Type: CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.withdrawal_request
    ADD CONSTRAINT withdrawal_request_pkey PRIMARY KEY (id);


--
-- Name: ix_admin_email; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE UNIQUE INDEX ix_admin_email ON public.admin USING btree (email);


--
-- Name: ix_cryptopayment_invoice_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_cryptopayment_invoice_id ON public.cryptopayment USING btree (invoice_id);


--
-- Name: ix_cryptopayment_payment_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_cryptopayment_payment_id ON public.cryptopayment USING btree (payment_id);


--
-- Name: ix_discount_codes_discount_code; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE UNIQUE INDEX ix_discount_codes_discount_code ON public.discount_codes USING btree (discount_code);


--
-- Name: ix_discount_codes_discount_name; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_discount_codes_discount_name ON public.discount_codes USING btree (discount_name);


--
-- Name: ix_discount_codes_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_discount_codes_id ON public.discount_codes USING btree (id);


--
-- Name: ix_discount_codes_percentage; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_discount_codes_percentage ON public.discount_codes USING btree (percentage);


--
-- Name: ix_payment_card_name; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_payment_card_name ON public.payment USING btree (card_name);


--
-- Name: ix_prop_firm_plan_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_prop_firm_plan_id ON public.prop_firm_plan USING btree (id);


--
-- Name: ix_prop_firm_plan_price_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_prop_firm_plan_price_id ON public.prop_firm_plan_price USING btree (id);


--
-- Name: ix_prop_firm_plan_slug; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE UNIQUE INDEX ix_prop_firm_plan_slug ON public.prop_firm_plan USING btree (slug);


--
-- Name: ix_referral_earning_referred_user_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_referral_earning_referred_user_id ON public.referral_earning USING btree (referred_user_id);


--
-- Name: ix_referral_earning_referrer_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_referral_earning_referrer_id ON public.referral_earning USING btree (referrer_id);


--
-- Name: ix_referral_earning_registration_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_referral_earning_registration_id ON public.referral_earning USING btree (registration_id);


--
-- Name: ix_transactions_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_transactions_id ON public.transactions USING btree (id);


--
-- Name: ix_transactions_reference; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_transactions_reference ON public.transactions USING btree (reference);


--
-- Name: ix_transactions_status; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_transactions_status ON public.transactions USING btree (status);


--
-- Name: ix_transactions_type; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_transactions_type ON public.transactions USING btree (type);


--
-- Name: ix_user_discount_discount_code; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_user_discount_discount_code ON public.user_discount USING btree (discount_code);


--
-- Name: ix_user_discount_discount_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_user_discount_discount_id ON public.user_discount USING btree (discount_id);


--
-- Name: ix_user_discount_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_user_discount_id ON public.user_discount USING btree (id);


--
-- Name: ix_user_discount_user_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_user_discount_user_id ON public.user_discount USING btree (user_id);


--
-- Name: ix_user_email; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE UNIQUE INDEX ix_user_email ON public."user" USING btree (email);


--
-- Name: ix_user_referral_code; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE UNIQUE INDEX ix_user_referral_code ON public."user" USING btree (referral_code);


--
-- Name: ix_user_referred_by; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_user_referred_by ON public."user" USING btree (referred_by);


--
-- Name: ix_vat_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_vat_id ON public.vat USING btree (id);


--
-- Name: ix_vat_vat_name; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_vat_vat_name ON public.vat USING btree (vat_name);


--
-- Name: ix_withdrawal_request_batch_withdrawal_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_withdrawal_request_batch_withdrawal_id ON public.withdrawal_request USING btree (batch_withdrawal_id);


--
-- Name: ix_withdrawal_request_payout_id; Type: INDEX; Schema: public; Owner: propfirmsol_samdav
--

CREATE INDEX ix_withdrawal_request_payout_id ON public.withdrawal_request USING btree (payout_id);


--
-- Name: affiliate_settings affiliate_settings_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.affiliate_settings
    ADD CONSTRAINT affiliate_settings_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: cryptopayment cryptopayment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.cryptopayment
    ADD CONSTRAINT cryptopayment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: notification notification_admin_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_admin_id_fkey FOREIGN KEY (admin_id) REFERENCES public.admin(id);


--
-- Name: notification notification_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.notification
    ADD CONSTRAINT notification_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: payment payment_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.payment
    ADD CONSTRAINT payment_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: prop_firm_plan_price prop_firm_plan_price_plan_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.prop_firm_plan_price
    ADD CONSTRAINT prop_firm_plan_price_plan_id_fkey FOREIGN KEY (plan_id) REFERENCES public.prop_firm_plan(id);


--
-- Name: prop_firm_registration prop_firm_registration_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.prop_firm_registration
    ADD CONSTRAINT prop_firm_registration_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: referral_earning referral_earning_wallet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.referral_earning
    ADD CONSTRAINT referral_earning_wallet_id_fkey FOREIGN KEY (wallet_id) REFERENCES public.wallet(id) ON DELETE CASCADE;


--
-- Name: support_message support_message_ticket_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.support_message
    ADD CONSTRAINT support_message_ticket_id_fkey FOREIGN KEY (ticket_id) REFERENCES public.support_ticket(id);


--
-- Name: support_ticket support_ticket_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.support_ticket
    ADD CONSTRAINT support_ticket_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: transactions transactions_users_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_users_id_fkey FOREIGN KEY (users_id) REFERENCES public."user"(id);


--
-- Name: user_discount user_discount_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.user_discount
    ADD CONSTRAINT user_discount_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: user_purchased_package user_purchased_package_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.user_purchased_package
    ADD CONSTRAINT user_purchased_package_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id);


--
-- Name: wallet wallet_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.wallet
    ADD CONSTRAINT wallet_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(id) ON DELETE CASCADE;


--
-- Name: withdrawal_request withdrawal_request_wallet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: propfirmsol_samdav
--

ALTER TABLE ONLY public.withdrawal_request
    ADD CONSTRAINT withdrawal_request_wallet_id_fkey FOREIGN KEY (wallet_id) REFERENCES public.wallet(id) ON DELETE CASCADE;


--
-- Name: TABLE admin; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.admin TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE affiliate_settings; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.affiliate_settings TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE alembic_version; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.alembic_version TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE banner; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.banner TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE booking_link; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.booking_link TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE cryptopayment; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.cryptopayment TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE discount_codes; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.discount_codes TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE global_affiliate_settings; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.global_affiliate_settings TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE notification; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.notification TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE payment; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.payment TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE prop_firm_plan; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.prop_firm_plan TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE prop_firm_plan_price; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.prop_firm_plan_price TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE prop_firm_registration; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.prop_firm_registration TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE referral_earning; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.referral_earning TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE support; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.support TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE support_message; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.support_message TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE support_ticket; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.support_ticket TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE transactions; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.transactions TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE "user"; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public."user" TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE user_discount; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.user_discount TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE user_purchased_package; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.user_purchased_package TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE vat; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.vat TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE wallet; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.wallet TO propfirmsol_secureprofrimsoldb;


--
-- Name: TABLE withdrawal_request; Type: ACL; Schema: public; Owner: propfirmsol_samdav
--

GRANT ALL ON TABLE public.withdrawal_request TO propfirmsol_secureprofrimsoldb;


--
-- PostgreSQL database dump complete
--

