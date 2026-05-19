# BetMaster – Football Betting Management System (Stage B)

## שלב ב: שאילתות, אילוצים ואינדקסים

### 1. שאילתות SELECT עם שתי גרסאות (Double Implementation)
עבור כל שאילתה מוצגות שתי דרכי מימוש והסבר על היעילות.

#### שאילתה 1: זוכים מובילים מהזמן האחרון (Top Recent Winners)
**תיאור:** מזהה משתמשים שנרשמו ב-6 החודשים האחרונים וזכו בסכום העולה על 500.

**גרסה א' (JOIN ו-GROUP BY):**
```sql
SELECT 
    u.user_id, u.full_name, u.email, 
    EXTRACT(YEAR FROM u.registration_date) as reg_year,
    SUM(t.amount) as total_winnings,
    COUNT(t.transaction_id) as winning_count
FROM USERS u
JOIN TRANSACTIONS t ON u.user_id = t.user_id
WHERE t.transaction_type = 'Winnings' 
  AND u.registration_date >= CURRENT_DATE - INTERVAL '6 months'
GROUP BY u.user_id, u.full_name, u.email, u.registration_date
HAVING SUM(t.amount) > 500
ORDER BY total_winnings DESC;
```

**גרסה ב' (שימוש ב-CTE):**
```sql
WITH RecentWinners AS (
    SELECT 
        user_id, SUM(amount) as total_winnings, COUNT(transaction_id) as winning_count
    FROM TRANSACTIONS
    WHERE transaction_type = 'Winnings'
    GROUP BY user_id
)
SELECT 
    u.user_id, u.full_name, u.email, 
    EXTRACT(YEAR FROM u.registration_date) as reg_year,
    rw.total_winnings, rw.winning_count
FROM USERS u
JOIN RecentWinners rw ON u.user_id = rw.user_id
WHERE u.registration_date >= CURRENT_DATE - INTERVAL '6 months'
  AND rw.total_winnings > 500
ORDER BY rw.total_winnings DESC;
```
**הסבר יעילות:** גרסה א' יעילה יותר בדרך כלל מכיוון שהיא מבצעת סינון (Filtering) של המשתמשים לפי תאריך הרישום לפני שהיא מבצעת את ה-JOIN והאגרגציה, מה שמקטין את נפח הנתונים המעובד. גרסה ב' מחשבת אגרגציה על כל טבלת הטרנזקציות לפני הסינון.

![Top Winners](screenshots/top_winner.png)

#### שאילתה 2: משתמשים "אזוריים" בעלי ערך גבוה (High-Value Regional Users)
**תיאור:** משתמשים שנרשמו בשנה האחרונה והימרו בסכום מצטבר של מעל 300 על משחקים שבהם משחקת קבוצה מישראל.

**גרסה א' (Multi-table JOIN):**
```sql
SELECT 
    u.user_id, u.full_name, u.email, 
    EXTRACT(MONTH FROM u.registration_date) as reg_month,
    COUNT(b.bet_id) as bet_count,
    SUM(b.bet_amount) as total_invested
FROM USERS u
JOIN BETS b ON u.user_id = b.user_id
JOIN MATCHES m ON b.match_id = m.match_id
JOIN TEAMS t_home ON m.home_team_id = t_home.team_id
JOIN TEAMS t_away ON m.away_team_id = t_away.team_id
WHERE (t_home.country = 'Israel' OR t_away.country = 'Israel')
  AND u.registration_date >= CURRENT_DATE - INTERVAL '1 year'
GROUP BY u.user_id, u.full_name, u.email, u.registration_date
HAVING SUM(b.bet_amount) > 300
ORDER BY total_invested DESC;
```

**גרסה ב' (Correlated Subqueries):**
*(קוד השאילתה מופיע ב-high_value_regional_users.sql)*

**הסבר יעילות:** גרסה א' המשתמשת ב-JOIN היא משמעותית יותר יעילה. תת-שאילתות מקושרות (Correlated Subqueries) רצות פעם אחת עבור כל שורה בטבלת המשתמשים, מה שגורם לעומס כבד בטבלאות גדולות. JOIN מאפשר לאופטימייזר לבצע חיבור יעיל של כל הנתונים בבת אחת.

![Regional Users](screenshots/regional_users.png)

#### שאילתה 3: דפוסי זכייה חשודים (Suspicious Winning Patterns)
**תיאור:** איתור משתמשים עם אחוז זכייה גבוה במיוחד (מעל 75%) ומינימום 5 הימורים.

**גרסה א' (GROUP BY עם CASE):**
```sql
SELECT 
    u.user_id, u.full_name, u.email,
    EXTRACT(YEAR FROM u.registration_date) as joined_year,
    COUNT(b.bet_id) as total_settled_bets,
    SUM(CASE WHEN b.bet_status = 'Won' THEN 1 ELSE 0 END) as wins,
    ROUND(CAST(SUM(CASE WHEN b.bet_status = 'Won' THEN 1 ELSE 0 END) AS NUMERIC) / COUNT(b.bet_id) * 100, 2) as win_rate_percentage
FROM USERS u
JOIN BETS b ON u.user_id = b.user_id
WHERE b.bet_status IN ('Won', 'Lost')
GROUP BY u.user_id, u.full_name, u.email, u.registration_date
HAVING COUNT(b.bet_id) >= 5 
   AND (CAST(SUM(CASE WHEN b.bet_status = 'Won' THEN 1 ELSE 0 END) AS NUMERIC) / COUNT(b.bet_id)) > 0.75
ORDER BY win_rate_percentage DESC;
```

**גרסה ב' (Nested Subqueries):**
*(קוד השאילתה מופיע ב-suspicious_winning_patterns.sql)*

**הסבר יעילות:** גרסה א' יעילה יותר כיוון שהיא סורקת את טבלת ההימורים פעם אחת בלבד ומחשבת את כל המדדים תוך כדי הקיבוץ (Grouping). גרסה ב' יוצרת טבלה זמנית (Subquery) ואז מחברת אותה, מה שעלול לצרוך יותר זיכרון וזמן עיבוד.

![Suspicious Winning](screenshots/sus_winning.png)

#### שאילתה 4: הפתעות של קבוצות חוץ (Away Team Upsets)
**תיאור:** מציאת משחקים בהם קבוצת החוץ ניצחה עם יחס הימורים גבוה (מעל 3.5).

**גרסה א' (Explicit JOIN):**
```sql
SELECT 
    m.match_id, m.match_date, t_home.team_name as home_team, 
    t_away.team_name as away_team, o.away_win_odd
FROM MATCHES m
JOIN TEAMS t_home ON m.home_team_id = t_home.team_id
JOIN TEAMS t_away ON m.away_team_id = t_away.team_id
JOIN ODDS o ON m.match_id = o.match_id
WHERE m.final_result = 'Away' AND o.away_win_odd > 3.5
ORDER BY o.away_win_odd DESC;
```

**גרסה ב' (Correlated Subquery ב-SELECT):**
*(קוד השאילתה מופיע ב-away_team_upsets.sql)*

**הסבר יעילות:** גרסה א' יעילה בהרבה. בגרסה ב', עבור כל משחק שנמצא, בסיס הנתונים צריך להריץ 4 תת-שאילתות נפרדות (לקבלת שמות הקבוצות והיחס). JOIN מבצע זאת בפעולה אחת אחודה.

![Away Upsets](screenshots/away_team.png)

---

### 2. שאילתות SELECT נוספות
שאילתות אלו מנתחות היבטים נוספים של המערכת.

#### שאילתה 5: מהמרים בתדירות גבוהה (High-Frequency Bettors)
**תיאור:** חישוב ממוצע הימורים יומי עבור כל משתמש (למשתמשים עם וותק של מעל חודש).
![High Frequency](screenshots/high_frequency_bettors.png)

#### שאילתה 6: משתמשי "לווייתן" חדשים (New Whale Users)
**תיאור:** משתמשים חדשים (90 יום) שהימרו בממוצע מעל 100 להימור.
![New Whales](screenshots/new_whales.png)

#### שאילתה 7: ניתוח תזרים מזומנים חודשי (Monthly Cash Flow)
**תיאור:** סיכום הפקדות, משיכות ותזרים נקי עבור הפלטפורמה בכל חודש.
![Cash Flow](screenshots/cash_flow.png)

#### שאילתה 8: מדד יעילות זכייה (Winning Efficiency)
**תיאור:** חישוב כמה כסף המשתמש הרוויח בממוצע עבור כל יום חברות באתר.
![Winning Efficiency](screenshots/winning_efficiency.png)

---

### 3. שאילתות DELETE ו-UPDATE
עבור כל שאילתה מוצגת מטרתה ותוצאת ההרצה (לפני/אחרי).

#### עדכון 1: בונוס נאמנות לזוכים (Loyalty Bonus)
**תיאור:** הוספת 25.00 ליתרה של כל משתמש פעיל שזכה לפחות בהימור אחד.
![Update Winnings](screenshots/update_winnings.png)

#### עדכון 2: עדכון סטטוס משחקי עבר (Mass Settle Matches)
**תיאור:** עדכון משחקים שתאריכם עבר אך עדיין מופיעים כ-'Scheduled' לסטטוס 'Finished'.
![Update Game Status](screenshots/update_game.png)

#### מחיקה 1: ניקוי חשבונות נטושים (Cleanup Abandoned Accounts)
**תיאור:** מחיקת משתמשים שנרשמו לפני שנתיים ומעולם לא ביצעו הימור או טרנזקציה.
![Delete Abandoned](screenshots/del_abandon.png)
![Delete Abandoned Verify](screenshots/remove_abandon_users.png)

#### מחיקה 2: הסרת משיכות זעירות (Remove Micro-Withdrawals)
**תיאור:** ניקוי לוג הטרנזקציות ממשיכות בסכום הנמוך מ-100.
![Delete Small](screenshots/remove_small.png)

---

### 4. אילוצים (Constraints)
הוספת אילוצים לשמירה על תקינות הנתונים ובדיקתם על ידי ניסיון הכנסה שגוי.

#### אילוץ 1: תאריך רישום לא בעתיד
```sql
ALTER TABLE USERS ADD CONSTRAINT chk_registration_date CHECK (registration_date <= CURRENT_DATE);
```
**ניסיון הכנסה שגוי:**
![Constraint 1 Error](screenshots/cons_1.png)

#### אילוץ 2: קבוצת בית וחוץ חייבות להיות שונות
```sql
ALTER TABLE MATCHES ADD CONSTRAINT chk_different_teams CHECK (home_team_id <> away_team_id);
```
**ניסיון הכנסה שגוי:**
![Constraint 2 Error](screenshots/cons_2.png)

#### אילוץ 3: סכום הפקדה/זכייה חייב להיות חיובי
```sql
ALTER TABLE TRANSACTIONS ADD CONSTRAINT chk_positive_transaction CHECK (
    (transaction_type IN ('Deposit', 'Winnings') AND amount > 0) OR 
    (transaction_type IN ('Withdrawal', 'Bet Placement'))
);
```
**ניסיון הכנסה שגוי:**
![Constraint 3 Error](screenshots/cons_3.png)

---

### 5. טרנזקציות (Commit & Rollback)
הדגמת ניהול טרנזקציות על מספר רב של שורות.

#### דוגמת Rollback (ביטול בונוס):
הענקת בונוס לכל המשתמשים הלא פעילים וביטולו.
![Rollback Demo](screenshots/commit.png)
*(הערה: ה-Screenshot מציג את תהליך ה-BEGIN, UPDATE ו-ROLLBACK/COMMIT)*

---

### 6. אינדקסים (Indexes)
שיפור ביצועים על ידי הוספת אינדקסים ובדיקת זמני ריצה.

#### אינדקס על אימייל משתמש (`idx_user_email`)
**לפני:** Seq Scan, זמן ריצה גבוה.
**אחרי:** Index Scan, זמן ריצה אפסי.
![Index 1](screenshots/index_3.png)

#### אינדקס על תאריך טרנזקציה (`idx_transaction_date`)
![Index 2](screenshots/index_1.png)

#### אינדקס על סטטוס ותאריך משחק (`idx_match_status_date`)
![Index 3](screenshots/index_2.png)

---

### 7. ניתוח מעמיק של ביצועי האינדקסים
להלן הסבר טכני על ההבדלים שנצפו בזמני הריצה והתכנון:

#### למה ב-`idx_user_email` (אינדקס 3) רואים שיפור בעיקר בזמן התכנון?
בטבלאות קטנות יחסית (כמו טבלת המשתמשים שלנו המכילה 800 שורות), בסיס הנתונים לעיתים קרובות כבר טוען את כל הטבלה לזיכרון ה-RAM. במצב כזה, סריקה סדרתית (Seq Scan) היא מהירה מאוד. 
*   **זמן תכנון (Planning Time):** האינדקס מאפשר לאופטימייזר "להבין" מיד שיש לו מפה ישירה לרשומה אחת ספציפית, מה שמקטין את המורכבות של יצירת תוכנית השאילתה.
*   **יעילות (Cost):** גם אם זמן הריצה נראה דומה, ה-"Cost" (עלות המשאבים) יורד משמעותית כי בסיס הנתונים ניגש ישירות לדף הנתונים הנכון במקום לסרוק את כולם.

#### היעילות של `idx_transaction_date` (אינדקס 1)
זהו האינדקס המשמעותי ביותר בטבלאות גדולות (מעל 20,000 שורות).
*   **צמצום I/O:** ללא אינדקס, המערכת חייבת לקרוא את כל 20,000 השורות מהדיסק. האינדקס משתמש במבנה של **B-Tree** כדי לדלג ישירות לטווח התאריכים המבוקש, מה שחוסך קריאות דיסק מיותרות ומשפר את זמן הריצה (Execution Time) בצורה דרמטית.

#### היתרון של אינדקס מורכב ב-`idx_match_status_date` (אינדקס 2)
אינדקס זה משלב שתי עמודות (`status` ו-`match_date`).
*   **סינון משולב:** במקום לחפש קודם סטטוס ואז תאריך, האינדקס שומר רשימה ממוינת מראש לפי שני הפרמטרים. זה מאפשר שליפה מהירה מאוד של "כל המשחקים שהסתיימו בתאריך X", פעולה שהיא קריטית להצגת דאשבורדים ודוחות סיכום.
