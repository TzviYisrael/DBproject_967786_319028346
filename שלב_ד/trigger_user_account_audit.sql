-- =============================================================================
-- Trigger 1: audit every balance/status update on users
-- =============================================================================
-- Required UPDATE trigger.

CREATE OR REPLACE FUNCTION trg_log_user_account_update()
RETURNS TRIGGER
LANGUAGE plpgsql
AS $$
DECLARE
    v_reason VARCHAR(200);
BEGIN
    IF NEW.balance IS DISTINCT FROM OLD.balance
       AND NEW.account_status IS DISTINCT FROM OLD.account_status THEN
        v_reason := 'Balance and status changed';
    ELSIF NEW.balance IS DISTINCT FROM OLD.balance THEN
        v_reason := 'Balance changed';
    ELSE
        v_reason := 'Status changed';
    END IF;

    INSERT INTO account_audit_log (
        user_id,
        old_balance,
        new_balance,
        balance_delta,
        old_status,
        new_status,
        audit_reason
    )
    VALUES (
        NEW.user_id,
        OLD.balance,
        NEW.balance,
        NEW.balance - OLD.balance,
        OLD.account_status,
        NEW.account_status,
        v_reason
    );

    IF NEW.account_status = 'Blocked'
       AND OLD.account_status IS DISTINCT FROM NEW.account_status THEN
        INSERT INTO risk_review_queue (user_id, risk_score, reason, status)
        SELECT NEW.user_id, 85, 'User status changed to Blocked by trigger', 'Open'
        WHERE NOT EXISTS (
            SELECT 1
            FROM risk_review_queue rrq
            WHERE rrq.user_id = NEW.user_id
              AND rrq.status = 'Open'
              AND rrq.reason = 'User status changed to Blocked by trigger'
        );
    END IF;

    RETURN NEW;
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'trg_log_user_account_update failed for user %. Error: %', NEW.user_id, SQLERRM;
        RAISE;
END;
$$;

DROP TRIGGER IF EXISTS users_account_audit_update ON users;

CREATE TRIGGER users_account_audit_update
AFTER UPDATE OF balance, account_status ON users
FOR EACH ROW
WHEN (
    OLD.balance IS DISTINCT FROM NEW.balance
    OR OLD.account_status IS DISTINCT FROM NEW.account_status
)
EXECUTE FUNCTION trg_log_user_account_update();
