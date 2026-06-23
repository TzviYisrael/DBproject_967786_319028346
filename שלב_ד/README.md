# שלב ד' - תכנות PL/pgSQL

תיקייה זו מכילה את ההגשה של שלב ד' עבור בסיס הנתונים המשולב של BetMaster. בשלב זה כתבנו PL/pgSQL Programs שעובדים על בסיס הנתונים המורחב משלב ג' ומדגימים לוגיקה אמיתית בבסיס הנתונים, ולא רק `SELECT` Queries פשוטים.

הרעיון המרכזי של השלב הוא להשתמש במערכת ההימורים כמערכת תפעולית:

- לזהות משתמשים בסיכון,
- לסכם חשיפה פיננסית במשחקים,
- לסגור משחקים ולשלם זכיות,
- לתעד שינויים חשובים,
- להוכיח שטיפול בחריגות מתבצע בצורה תקינה.

## 1. מדוע ה-Programs האלה נבחרו

בסיס הנתונים המשולב מכיל טבלאות הימורים (`users`, `bets`, `transactions`, `matches`, `odds`) וטבלאות ניהול כדורגל מהשלב הקודם. עבור שלב ד', הלוגיקה התכנותית המשמעותית ביותר היא סביב פעולות הימורים, כי אזור זה דורש באופן טבעי עדכונים, אימות, לולאות, cursors ורשומות audit.

ה-Programs תוכננו סביב שני תהליכי עבודה ריאליים:

1. **תהליך בדיקת סיכון**
   חברת הימורים צריכה לאתר משתמשים עם חשיפה גבוהה בהימורים ממתינים, הפסדים רבים, משיכות גדולות או סטטוס לא פעיל/חסום. הדבר מצדיק את ה-Function של דוח הסיכון, את ה-Procedure לחישוב מחדש של סטטוס המשתמש ואת ה-Trigger לתיעוד עדכוני משתמשים.

2. **תהליך סגירת משחק**
   כאשר תוצאת משחק ידועה, המערכת צריכה לסגור את המשחק, לסמן הימורים כמנצחים/מפסידים, לשלם לזוכים, להכניס רשומות עסקאות ולשמור לוג סגירה. הדבר מצדיק את ה-Function של סיכום המשחק, את ה-Procedure לסגירת המשחק ואת ה-Trigger לתיעוד עדכוני יחסי הימורים.

תהליכים אלה אינם טריוויאליים משום שהם משתמשים במספר טבלאות יחד ומשנים את מצב בסיס הנתונים.

## 2. מבנה התיקייה

| נתיב | מטרה |
| --- | --- |
| `AlterTable.sql` | supporting schema changes הנדרשים לשלב ד' |
| `programs/` | Functions, Procedures, Triggers ו-Main Programs |
| `screenshots/` | הוכחות בצילומי מסך לכל Program נדרש |
| `evidence/stage4_execution_output.txt` | פלט psql מלא של ההרצה |
| `backup4.sql` | גיבוי סופי של בסיס הנתונים לאחר שלב ד' |
| `RunAllStage4.sql` | סקריפט שטוען ומריץ את כל Stage D Programs |
| `דוח הפרויקט שלב ד.md` | דוח מלא של שלב ד', כולל נספח קוד |

`AlterTable.sql` נשאר בשורש של `שלב_ד` משום שהמטלה דורשת במפורש קובץ אחד בשם זה עם כל שינויי הטבלאות. שאר קבצי ה-Programs מרוכזים ב-`programs/` כדי שההגשה תהיה נוחה לקריאה.

## 3. רשימת בדיקה מול הדרישות

| דרישת המטלה | מימוש |
| --- | --- |
| 2 Functions | `fn_open_user_risk_report`, `fn_match_financial_summary` |
| 2 Procedures | `proc_settle_match`, `proc_recalculate_user_statuses` |
| 2 Triggers, לפחות אחד על UPDATE | `users_account_audit_update`, `odds_audit_update`; שניהם Triggers על UPDATE |
| 2 Main Programs | `MainProgram_RiskReview.sql`, `MainProgram_SettleMatch.sql` |
| שימוש בבסיס הנתונים המורחב משלב ג' | ה-Programs משתמשים בטבלאות ההימורים והמשחקים המשולבות |
| פקודות DML | עדכונים והכנסות ל-`users`, `bets`, `matches`, `transactions`, טבלאות audit וטבלאות log |
| Cursors | Cursors מפורשים ולולאות cursor מרומזות |
| החזרת Ref Cursor | `fn_open_user_risk_report` מחזירה `REFCURSOR` |
| הסתעפויות | `IF`, `ELSIF`, `CASE` |
| לולאות | `LOOP`, `FETCH`, `FOR record IN SELECT` |
| חריגות | `EXCEPTION WHEN OTHERS` ואימות תוצאה לא תקינה |
| Records | משתני `RECORD` ב-Functions וב-Procedures |
| גיבוי | `backup4.sql` |
| דוח | `דוח הפרויקט שלב ד.md` |

## 4. שינויי טבלאות תומכים

קובץ:

```text
AlterTable.sql
```

קובץ זה יוצר טבלאות תומכות שהופכות את ה-Programs למשמעותיים יותר וגם שומרות הוכחה לכך שה-Programs שינו את בסיס הנתונים.

| טבלה | מטרה |
| --- | --- |
| `account_audit_log` | שומרת ערכי יתרה וסטטוס ישנים/חדשים עבור עדכוני משתמשים |
| `risk_review_queue` | שומרת משתמשים שדורשים בדיקת סיכון |
| `match_settlement_log` | שומרת תוצאות סגירת משחק וזכיות ששולמו |
| `odds_audit_log` | שומרת ערכי יחסי הימורים ישנים/חדשים לאחר עדכוני odds |

טבלאות הבסיס לא נוצרו מחדש. הוספנו רק טבלאות תומכות, משום שהמטלה דורשת להשתמש בבסיס הנתונים המורחב מהשלב הקודם.

## 5. קבצי ה-Programs

| סוג | קובץ | מה הוא עושה |
| --- | --- | --- |
| Function | `programs/function_open_user_risk_report.sql` | מחשבת ציוני סיכון, מכניסה רשומות בדיקה ומחזירה ref cursor |
| Function | `programs/function_match_financial_summary.sql` | מסכמת חשיפה פיננסית לפי משחק |
| Procedure | `programs/procedure_settle_match.sql` | מסיימת משחק, מעדכנת הימורים, משלמת זכיות ומתעדת סגירה |
| Procedure | `programs/procedure_recalculate_user_statuses.sql` | מחשבת מחדש סטטוס חשבון משתמש לפי כללי סיכון |
| Trigger | `programs/trigger_user_account_audit.sql` | מתעד שינויי UPDATE על `users` |
| Trigger | `programs/trigger_odds_update_audit.sql` | מתעד שינויי UPDATE על `odds` |
| Main Program | `programs/MainProgram_RiskReview.sql` | קוראת ל-Function ול-Procedure אחת עבור בדיקת סיכון |
| Main Program | `programs/MainProgram_SettleMatch.sql` | קוראת ל-Function ול-Procedure אחת עבור סגירת משחק |

## 6. הסבר על ה-Programs

### Function 1 - `fn_open_user_risk_report`

Function זה מחשב ציון סיכון לכל משתמש. הוא בודק חשיפת הימורים ממתינים, יחס הפסדים, משיכות וסטטוס חשבון. משתמשים מעל הסף שנבחר מוכנסים ל-`risk_review_queue`.

ה-Function מחזיר `REFCURSOR`, ולכן הקריאה הראשית היא:

```sql
SELECT fn_open_user_risk_report(35);
FETCH ALL IN "risk_report_cursor";
```

הערך `35` הוא ציון הסיכון המינימלי שמוצג בדוח. הוא נבחר עבור צילום המסך משום שהוא מחזיר מספיק שורות כדי להוכיח בבירור שה-Function עבד. ברירת המחדל של ה-Function היא `50`, כך שניתן להשתמש בו גם עם סף מחמיר יותר.

הוכחה בצילום מסך:

![Function סיכון עם ref cursor](screenshots/function_risk_refcursor.png)

בצילום המסך, ה-Function מחזיר את שם ה-cursor `risk_report_cursor`. לאחר מכן `FETCH ALL` קורא את ה-cursor ומדפיס משתמשים עם ציון סיכון, סיבה, סטטוס וזמן פתיחה. הדבר מוכיח גם את דרישת ה-ref cursor וגם את ההכנסה ל-`risk_review_queue`.

רכיבי PL/pgSQL מרכזיים:

- cursor מפורש,
- `RECORD`,
- לולאה עם `FETCH`,
- תנאי `IF`,
- פקודת DML מסוג `INSERT`,
- החזרת `REFCURSOR`,
- טיפול בחריגות.

### Function 2 - `fn_match_financial_summary`

Function זה מסכם את המצב הפיננסי של משחקים. הוא מחזיר מספר הימורים, הימורים ממתינים, הימורים שניצחו/הפסידו, סכום הימורים כולל וחשיפה פוטנציאלית.

העברת `NULL` פירושה: לסכם מספר משחקים במקום משחק מסוים אחד. זה היה שימושי לצילום המסך משום שהוא מציג כמה שורות פלט.

הוכחה בצילום מסך:

![Function סיכום פיננסי למשחק](screenshots/function_match_financial_summary.png)

צילום המסך מציג מספר סיכומי משחקים. כל שורה כוללת סטטוס משחק, הימורים ממתינים, סכום הימורים כולל וחשיפה פוטנציאלית, ולכן הוא מוכיח שה-Function מבצע עיבוד פיננסי מקובץ ולא הדפסה פשוטה של טבלה.

רכיבי PL/pgSQL מרכזיים:

- cursor מרומז באמצעות `FOR record IN SELECT`,
- `RECORD`,
- לולאה,
- `CASE`,
- חישובים,
- טיפול בחריגות.

### Procedure 1 - `proc_settle_match`

Procedure זה מקבל מזהה משחק ותוצאה סופית (`Home`, `Draw`, `Away`). לאחר מכן הוא:

1. מעדכן את המשחק ל-`Finished`,
2. מסמן הימורים מנצחים כ-`Won`,
3. מסמן את שאר ההימורים הממתינים כ-`Lost`,
4. מוסיף זכיות ליתרות המשתמשים,
5. מכניס עסקאות `Winnings`,
6. מכניס שורה אחת ל-`match_settlement_log`.

זו דוגמת ה-DML החזקה ביותר בשלב, משום שהיא משנה כמה טבלאות בתהליך עסקי אחד.

הוכחה בצילום מסך:

![Procedure לסגירת משחק](screenshots/procedure_settle_match.png)

צילום המסך מציג את המשחק הנבחר לפני ואחרי ה-Procedure. לפני ה-`CALL`, למשחק יש הימורים ממתינים. אחרי ה-`CALL`, המשחק הוא `Finished`, `pending_bets` הוא 0, נספרים זוכים ומפסידים, זכיות משולמות ונוצרת שורה ב-`match_settlement_log`.

### Procedure 2 - `proc_recalculate_user_statuses`

Procedure זה בודק משתמשים ומשנה את סטטוס החשבון שלהם כאשר כללי הסיכון דורשים זאת. לדוגמה, משתמשים עם חשיפה גבוהה בהימורים ממתינים יכולים להפוך ל-`Blocked`. עדכונים אלה מפעילים את ה-Trigger מסוג UPDATE של המשתמשים, ולכן אותו תהליך מוכיח גם את ה-audit Trigger.

הוכחה בצילום מסך:

![Procedure לחישוב סטטוס משתמשים ו-Trigger משתמשים](screenshots/procedure_recalculate_user_statuses_and_user_trigger.png)

החלק העליון של צילום המסך מציג את תור בדיקת הסיכון. החלק התחתון מציג את `account_audit_log`, שמוכיח שעדכוני המשתמשים תועדו.

### Trigger 1 - `users_account_audit_update`

Trigger זה רץ לאחר UPDATE על `users.balance` או `users.account_status`. הוא כותב ערכים ישנים, ערכים חדשים, delta, סיבה וחותמת זמן לתוך `account_audit_log`.

זה חשוב משום ששינויים רגישים בכסף או בסטטוס משתמש צריכים להיות מתועדים.

הוכחה בצילום מסך:

![Trigger audit לעדכון משתמשים](screenshots/procedure_recalculate_user_statuses_and_user_trigger.png)

רשומות ה-audit כוללות סטטוס ישן, סטטוס חדש, יתרה ישנה, יתרה חדשה וסיבה. הדבר מוכיח שה-trigger רץ אוטומטית כאשר `users` מתעדכנת.

### Trigger 2 - `odds_audit_update`

Trigger זה רץ לפני UPDATE על ערכי יחסי ההימורים. הוא מוודא שהיחסים נשארים גדולים מ-1, מעדכן את `update_date`, וכותב את ערכי היחסים הישנים/חדשים לתוך `odds_audit_log`.

זה חשוב משום ששינויי odds משפיעים על חשיפה פיננסית ולכן צריכים היסטוריה.

הוכחה בצילום מסך:

![Trigger לתיעוד עדכון odds](screenshots/trigger_odds_update_audit.png)

צילום המסך מציג `UPDATE 1` על `odds` ושורות תואמות ב-`odds_audit_log`, כולל ערכי odds ישנים וחדשים.

## 7. Main Programs

### Main Program 1 - בדיקת סיכון

קובץ:

```text
programs/MainProgram_RiskReview.sql
```

Main Program זה קורא ל:

```sql
SELECT fn_open_user_risk_report(35);
CALL proc_recalculate_user_statuses(1200, 500, 40);
```

לאחר מכן הוא מדפיס שורות מתוך `risk_review_queue` ומתוך `account_audit_log`.

הוכחה בצילום מסך:

![Main Program לבדיקת סיכון](screenshots/procedure_recalculate_user_statuses_and_user_trigger.png)

צילום המסך מוכיח שה-Main Program מריץ תהליך בדיקת סיכון מלא: פלט Function, קריאה ל-Procedure, פלט תור סיכון ופלט audit.

### Main Program 2 - סגירת משחק

קובץ:

```text
programs/MainProgram_SettleMatch.sql
```

Main Program זה בוחר משחק עם הימורים ממתינים, מציג את הסיכום הפיננסי לפני הסגירה, קורא ל-Procedure הסגירה ולאחר מכן מציג את הסיכום הפיננסי לאחר הסגירה.

הוא מוכיח שבסיס הנתונים השתנה משום ש-`pending_bets` הופך ל-0 ונוצרת שורה ב-`match_settlement_log`.

הוכחה בצילום מסך:

![Main Program לסגירת משחק](screenshots/procedure_settle_match.png)

צילום המסך מוכיח שה-Main Program מריץ את תהליך הסגירה המלא: סיכום לפני סגירה, קריאה ל-Procedure, סיכום לאחר סגירה ופלט לוג סגירה.

## 8. טיפול בחריגות

![חריגה עבור תוצאת משחק לא תקינה](screenshots/exception_invalid_settlement_result.png)

צילום המסך מציג תוצאה לא תקינה מכוונת, `InvalidResult`, ואת הודעת החריגה המבוקרת.

## 9. הוראות הרצה

מתיקיית השורש של הפרויקט, להריץ:

```bash
docker exec -w /project betmaster_db psql -U betmaster_user -d betmaster -f /project/שלב_ד/RunAllStage4.sql
```

הסקריפט מבצע את הסדר המלא:

1. יצירת טבלאות תומכות,
2. יצירת ה-Functions,
3. יצירת ה-Procedures,
4. יצירת ה-triggers,
5. הרצת Main Program 1,
6. הרצת Main Program 2,
7. הדגמת trigger ה-UPDATE של odds,
8. הדגמת טיפול בחריגות.

יצירת הגיבוי הסופי:

```bash
docker exec betmaster_db pg_dump -U betmaster_user betmaster > שלב_ד/backup4.sql
```

## 10. הערות סופיות

פלט ההוכחה המלא נשמר בקובץ:

```text
evidence/stage4_execution_output.txt
```

הדוח הסופי הוא:

```text
דוח הפרויקט שלב ד.md
```

הדוח כולל:

- תיאור של כל Program,
- הוכחות בצילומי מסך,
- הסבר על ההוכחות,
- נספח קוד מלא.
