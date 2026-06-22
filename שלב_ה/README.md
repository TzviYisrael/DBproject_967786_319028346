# שלב ה' – ממשק גרפי לניהול BetMaster

ממשק ניהול גרפי (Admin GUI) לבסיס הנתונים BetMaster, שנבנה ב- **Python 3** עם **Dear PyGui** ו-**psycopg2**.

---

## הוראות הפעלה

### דרישות מקדימות
- Python 3.10+
- Docker & Docker Compose

### 1. הפעלת בסיס הנתונים

```bash
docker compose up -d
```

### 2. התקנת תלויות

```bash
cd שלב_ה
pip install -r requirements.txt
```

### 3. הרצת האפליקציה

```bash
python main.py
```

האפליקציה מתחברת אוטומטית ל- `localhost:5432` עם המשתמש `betmaster_user` / `betmaster_pass`.

---

## כלים וטכנולוגיות

| כלי | שימוש |
|------|---------|
| **Dear PyGui 2.x** | ספריית GUI חוצת-פלטפורמות (עיצוב כהה מודרני, תמיכה ב-hardware acceleration) |
| **psycopg2-binary** | מתאם PostgreSQL עבור Python (שאילתות פרמטריות, commit אוטומטי) |
| **Docker Compose** | הרצת PostgreSQL 16 בקונטיינר עם הגדרות קבועות |

---

## סקירת האפליקציה

### מבנה שלושת המסכים

1. **בית (Home)** – לוח בקרה עם שלושה כרטיסי ניווט: נתונים (Data), פעולות (Actions), ויציאה (Exit).
2. **נתונים (Data)** – תפריט צדדי עם 21 טבלאות המקובצות לפי תחומים (Core, Football, Integration, Audit & Risk). בחירת טבלה מציגה תצוגת עמודות (500 שורות בכל שליפה) עם כפתור **Load More**. בתחתית המסך שלוש לשוניות: **Create**, **Update**, **Delete**.
3. **פעולות (Actions)** – שתי לשוניות: **Queries** (5 שאילתות אנליטיות משלב ב') ו- **Programs** (4 תתי-תוכניות PL/pgSQL משלב ד').

### תכונות עיקריות

- **FK Resolution** – מפתחות זרים מוצגים כשמות קריאים (שם קבוצה, שם משתמש וכו') במקום מספרי ID.
- **חיפוש (Search)** – חיפוש ILIKE על פני כל עמודי הטקסט בטבלה, עם תמיכה ב-pagination.
- **Pagination** – שליפת נתונים בנתחים של 500 שורות עם כפתור Load More למניעת הקפאת הממשק.
- **עדכון (Update)** – המשתמש מזין ערך מפתח ראשי, לוחץ Fetch, המערכת מביאה את שאר השדות ואז ניתן לערוך ולשמור.
- **טיפול בשגיאות** – שגיאות בסיס נתונים (טבלאות חסרות, הפרת constraints) מוצגות בתוך הממשק ללא קריסה.

---

## תיאור הקבצים

| קובץ | תיאור |
|------|-------------|
| `main.py` | נקודת כניסה – מאתחל חיבור לבסיס הנתונים ומפעיל את ה- UI |
| `db/connection.py` | ניהול חיבור PostgreSQL (autocommit, פרטי התחברות קבועים) |
| `db/repository.py` | מטא-דטה עבור כל 21 הטבלאות, שאילתות עם FK, CRUD, חיפוש, pagination, שאילתות שלב ב' ותוכניות שלב ד' |
| `ui/app.py` | ממשק Dear PyGui מלא – 3 מסכים, עיצוב כהה, גופן Cantarell, טפסי CRUD, חיפוש, pagination |
| `requirements.txt` | תלויות Python (`dearpygui`, `psycopg2-binary`) |

---

## שאילתות ותוכניות זמינות

### שאילתות שלב ב'
1. **Top 10 Winning Users** – משתמשים מדורגים לפי סך זכיות
2. **Top 5 Highest-Value Bets** – ההימורים הגדולים ביותר
3. **User Win Rate** – אחוז הצלחה בהימורים לפי משתמש
4. **Monthly Revenue** – הכנסות הפלטפורמה לפי חודש
5. **Active Since Date** – משתמשים שנרשמו לפני תאריך נתון

### תוכניות שלב ד'
1. **Open User Risk Report** – ניקוד סיכון למשתמש, הכנסה ל- `risk_review_queue`
2. **Match Financial Summary** – סיכום חשיפה פיננסית לפי משחק
3. **Settle Match** – סגירת משחק, תשלום זכיות, תיעוד settlement
4. **Recalculate User Statuses** – עדכון סטטוס סיכון המוני למשתמשים

---

## צילומי מסך

| מסך | תצוגה מקדימה |
|------|---------|
| **מסך הבית** – לוח בקרה מרכזי | ![Home](screenshots/home_page.png) |
| **מסך נתונים** – דפדפן טבלאות עם תפריט צד, CRUD, חיפוש ו-pagination | ![Data](screenshots/data_page.png) |
| **מסך פעולות – שאילתות ותוכניות** – הרצת שאילתות משלב ב' ותוכניות PL/pgSQL משלב ד' | ![Queries](screenshots/query_page.png) |
