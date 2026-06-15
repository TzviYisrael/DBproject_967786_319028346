-- =============================================================================
-- Stage D - Supporting schema changes for PL/pgSQL programs
-- =============================================================================
-- These tables keep audit, risk-review and settlement evidence without changing
-- the existing business tables from the integrated schema.

CREATE TABLE IF NOT EXISTS account_audit_log (
    audit_id BIGSERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    old_balance NUMERIC(12,2),
    new_balance NUMERIC(12,2),
    balance_delta NUMERIC(12,2),
    old_status VARCHAR(20),
    new_status VARCHAR(20),
    audit_reason VARCHAR(200) NOT NULL,
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_account_audit_log_user_time
    ON account_audit_log(user_id, changed_at DESC);

CREATE TABLE IF NOT EXISTS risk_review_queue (
    review_id BIGSERIAL PRIMARY KEY,
    user_id INT NOT NULL REFERENCES users(user_id),
    risk_score NUMERIC(10,2) NOT NULL,
    reason VARCHAR(300) NOT NULL,
    status VARCHAR(20) NOT NULL DEFAULT 'Open',
    opened_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    closed_at TIMESTAMP
);

CREATE INDEX IF NOT EXISTS idx_risk_review_queue_open
    ON risk_review_queue(status, risk_score DESC);

CREATE TABLE IF NOT EXISTS match_settlement_log (
    settlement_log_id BIGSERIAL PRIMARY KEY,
    match_id INT NOT NULL REFERENCES matches(match_id),
    final_result VARCHAR(10) NOT NULL,
    affected_bets INT NOT NULL DEFAULT 0,
    paid_winnings NUMERIC(12,2) NOT NULL DEFAULT 0,
    settled_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    details VARCHAR(500)
);

CREATE INDEX IF NOT EXISTS idx_match_settlement_log_match
    ON match_settlement_log(match_id, settled_at DESC);

CREATE TABLE IF NOT EXISTS odds_audit_log (
    odds_audit_id BIGSERIAL PRIMARY KEY,
    odd_id INT NOT NULL REFERENCES odds(odd_id),
    match_id INT REFERENCES matches(match_id),
    old_home_win_odd NUMERIC(5,2),
    new_home_win_odd NUMERIC(5,2),
    old_draw_odd NUMERIC(5,2),
    new_draw_odd NUMERIC(5,2),
    old_away_win_odd NUMERIC(5,2),
    new_away_win_odd NUMERIC(5,2),
    changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    change_reason VARCHAR(250) NOT NULL DEFAULT 'Manual odds update'
);

CREATE INDEX IF NOT EXISTS idx_odds_audit_log_odd_time
    ON odds_audit_log(odd_id, changed_at DESC);
