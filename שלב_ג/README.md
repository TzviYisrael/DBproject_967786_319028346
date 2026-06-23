# שלב ג' - אינטגרציה ו-Views

## 1. מטרת השלב

בשלב ג' שילבנו שתי מערכות בסיסי נתונים שונות לתוך בסיס נתונים משולב אחד.

המערכת המקורית שלנו היא **BetMaster**, מערכת לניהול הימורי כדורגל. המערכת שהתקבלה היא **Football Management System**, שמנהלת קבוצות כדורגל, משחקים, שחקנים, מאמנים, שופטים, אצטדיונים וסטטיסטיקות משחק.

האינטגרציה בוצעה לפי **שיטה א'** מהמטלה:

- בניית DSD של המחלקה שהתקבלה מתוך קובץ הגיבוי שלה.
- ביצוע reverse engineering מה-DSD שהתקבל ל-ERD.
- תכנון ERD משולב משותף.
- המרת ה-ERD המשולב ל-relational schema חדש.
- שינוי בסיס הנתונים הקיים באמצעות פקודות SQL במקום יצירה מחדש של כל הטבלאות מאפס.
- וידוא שבסיס הנתונים המשולב מכיל נתונים משתי המערכות.
- הרצת Stage B Queries הקודמים על בסיס הנתונים המשולב.
- יצירת שני Views נדרשים, אחד עבור כל מחלקה מקורית, ושני Queries משמעותיים לכל View.
- יצירת הגיבוי הסופי `backup3.sql`.

## 2. רשימת בדיקה להגשה

| דרישה | קובץ / הוכחה |
| --- | --- |
| DSD של המחלקה שהתקבלה | `Diagrams/received_DSD.png` |
| ERD של המחלקה שהתקבלה | `Diagrams/received_ERD.png` |
| ERD משולב | `Diagrams/integrated_ERD.png` |
| DSD לאחר האינטגרציה | `Diagrams/integrated_DSD.png` |
| פקודות יצירה/שינוי של טבלאות | `Integrate.sql` |
| Views ו-Queries על Views | `Views.sql` |
| גיבוי סופי מעודכן | `backup3.sql` |
| דוח שלב ג' | `דוח הפרויקט שלב ג.md` |
| צילומי מסך ופלטים | `screenshots/` |
| פלט אימות האינטגרציה | `integration_validation_output.txt` |
| Stage B Queries לאחר האינטגרציה | `stage_b_queries_on_integrated_output.txt` |

## 3. מדריך צילומי מסך

הטבלה הבאה מסבירה את מטרת כל צילום מסך שמופיע ב-README זה.

| צילום מסך | מטרה | מה לבדוק |
| --- | --- | --- |
| `integration_counts.png` | מאשר שבסיס הנתונים המשולב מכיל נתונים | גם טבלאות BetMaster המקוריות וגם טבלאות `football_*` החדשות מכילות שורות |
| `stage_b_top_recent_winners_integrated.png` | מוכיח ש-Stage B Query עדיין עובד לאחר האינטגרציה | ה-Query מחזיר משתמשים חדשים יחסית עם זכיות גבוהות |
| `view_betmaster_select.png` | מציג את פלט ה-View של BetMaster | כל שורה מסכמת פעילות הימורים ופיננסים של משתמש אחד |
| `view_betmaster_query1.png` | מציג משתמשים פעילים עם פעילות הימורים גבוהה | משתמשים פעילים וממוינים לפי נפח הימורים כולל |
| `view_betmaster_query2.png` | מציג משתמשים שהזכיות שלהם גבוהות מהמשיכות | עמודת ההפרש המחושבת חיובית |
| `view_football_select.png` | מציג את פלט ה-View של Football Management | כל שורה מסכמת שחקן, קבוצה, חוזה וביצועי משחק |
| `view_football_query1.png` | מציג את השחקנים היעילים ביותר | השחקנים ממוינים לפי שערים ועוד בישולים |
| `view_football_query2.png` | מציג שחקנים עם שכר גבוה ותרומת שערים נמוכה | השכר גבוה ביחס לנתונים ומספר השערים נמוך מ-5 |
| `view_integrated_select.png` | מציג דוגמה מעורבת מה-View המשולב | שורות BetMaster מציגות נתוני הימורים ושורות FootballManagement מציגות נתוני אצטדיון |

## 4. DSD של המחלקה שהתקבלה

הגיבוי שהתקבל שוחזר ונותח. מתוך הטבלאות, Primary Keys, Foreign Keys ו-Constraints, בנינו את ה-DSD של המחלקה שהתקבלה.

הטבלאות המרכזיות במערכת שהתקבלה:

- `team`
- `match`
- `matchteam`
- `player`
- `goalkeeper`
- `playermatchstats`
- `coach`
- `coachedby`
- `referee`
- `refereeat`
- `stadium`
- `matchstadium`

**DSD של המחלקה שהתקבלה:**

![DSD שהתקבל](Diagrams/received_DSD.png)

**איך לקרוא את התמונה:** תרשים זה מציג את מבנה הטבלאות הפיזי של בסיס הנתונים שהתקבל לפני האינטגרציה. הוא משמש כהוכחה לכך ששחזרנו וניתחנו את הגיבוי של הקבוצה האחרת.

## 5. ERD של המחלקה שהתקבלה

לאחר בניית ה-DSD, ביצענו reverse engineering והמרנו אותו ל-ERD.

הישויות הקונספטואליות המרכזיות הן:

- `Team`
- `Match`
- `Player`
- `Coach`
- `Referee`
- `Stadium`

טבלאות קשר כגון `matchteam`, `coachedby`, `playsfor_player` ו-`refereeat` פורשו כקשרים קונספטואליים בין ישויות.

**ERD של המחלקה שהתקבלה:**

![ERD שהתקבל](Diagrams/received_ERD.png)

**איך לקרוא את התמונה:** תרשים זה ממיר את הטבלאות שהתקבלו לישויות וקשרים קונספטואליים. הוא מציג את תוצאת ה-reverse engineering עבור המחלקה שהתקבלה.

## 6. אלגוריתם Reverse Engineering

תהליך ה-reverse engineering מסכמת בסיס הנתונים שהתקבלה ל-ERD היה:

1. שחזור הגיבוי שהתקבל.
2. הצגת כל הטבלאות בבסיס הנתונים ששוחזר.
3. עבור כל טבלה, בדיקת עמודות, Data Types, אפשרות לערכי NULL ו-Constraints.
4. זיהוי Primary Keys באמצעות Constraints מסוג `PRIMARY KEY`.
5. זיהוי Foreign Keys באמצעות Constraints מסוג `FOREIGN KEY`.
6. התייחסות לטבלאות עם Primary Keys עצמאיים כישויות חזקות.
7. התייחסות לטבלאות שמורכבות בעיקר מ-Foreign Keys כטבלאות קשר.
8. התייחסות לטבלאות שה-Primary Key שלהן הוא גם Foreign Key כתת-סוג או ישות תלויה.
9. קביעת קרדינליות לפי Foreign Keys וייחודיות.
10. המרת המבנה הרלציוני ל-ERD קונספטואלי.

## 7. החלטות תכנון באינטגרציה

החלטת האינטגרציה המרכזית הייתה לחבר את שתי המערכות דרך ישויות הכדורגל המשותפות לשתיהן:

- `Team`
- `Match`

ב-BetMaster כבר היו:

- `teams`
- `matches`
- `users`
- `bets`
- `transactions`
- `odds`

במערכת שהתקבלה היו נתוני ניהול כדורגל סביב קבוצות ומשחקים:

- שחקנים
- מאמנים
- שופטים
- אצטדיונים
- סטטיסטיקות משחק
- חוזי שחקנים

### החלטות אינטגרציה מרכזיות

1. רשומות `team` שהתקבלו הוכנסו לטבלת `teams` הקיימת.
2. רשומות `match` שהתקבלו הוכנסו לטבלת `matches` הקיימת.
3. טבלאות קיימות שונו באמצעות `ALTER TABLE`; לא יצרנו מחדש את כל בסיס הנתונים מאפס.
4. טבלאות כדורגל חדשות נוצרו רק עבור ישויות שלא היו קיימות ב-BetMaster.
5. נוצרו טבלאות מיפוי כדי לשמור את הקשר בין המזהים שהתקבלו לבין המזהים המשולבים.
6. נוספו `source_system`, `received_team_id` ו-`received_match_id` כדי לשמור מידע על מקור הנתונים.
7. נוספה עמודת `teams.home_stadium_id` כדי לקשר כל קבוצה לאצטדיון הבית שלה.
8. אם לקבוצות שהתקבלו היו שמות שלא התאימו לקבוצות BetMaster, הן נשמרו כקבוצות נפרדות עם מעקב מקור.

## 8. ERD משולב

ה-ERD המשולב הוא התכנון הקונספטואלי של המערכת המאוחדת.

מרכז ה-ERD המשולב הוא:

- `Team`
- `Match`

צד BetMaster מתחבר דרך הימורים, משתמשים, יחסי הימורים ועסקאות. צד Football Management מתחבר דרך שחקנים, מאמנים, שופטים, אצטדיונים וסטטיסטיקות.

**ERD משולב:**

![ERD משולב](Diagrams/integrated_ERD.png)

**איך לקרוא את התמונה:** זהו התכנון הקונספטואלי של המערכת המשולבת. `Team` ו-`Match` נמצאות במרכז המשותף, עם ישויות BetMaster בצד אחד וישויות Football Management בצד השני.

## 9. DSD לאחר האינטגרציה

ה-DSD לאחר האינטגרציה נוצר מתוך ה-ERD המשולב ב-ERDPlus. הוא מציג את ה-relational schema שנובע מתכנון ה-ERD, כולל הטבלאות המרכזיות, keys והקשרים.

קובץ:

```text
Diagrams/integrated_DSD_erdplus.png
```

**DSD שנוצר על ידי ERDPlus מתוך ה-ERD המשולב:**

![DSD משולב שנוצר על ידי ERDPlus](Diagrams/integrated_DSD_erdplus.png)

**איך לקרוא את התמונה:** זהו ה-relational schema שנוצר מתכנון ה-ERD המשולב. הוא מציג את מבנה בסיס הנתונים הצפוי לפי ההמרה של ERDPlus.

בנוסף, שמרנו DSD מבוסס schema שמשקף את מבנה בסיס הנתונים שיושם בפועל לאחר הרצת `Integrate.sql`:

```text
Diagrams/integrated_DSD.png
```

**DSD של ה-relational schema שמומש:**

![DSD של ה-schema הממומש](Diagrams/integrated_DSD.png)

**איך לקרוא את התמונה:** תרשים זה משקף את בסיס הנתונים שיושם בפועל על ידי `Integrate.sql`. הוא כולל פרטי מימוש כגון טבלאות מיפוי ועמודות אינטגרציה טכניות.

## 10. מדוע ה-DSD של ERDPlus וה-DSD הממומש אינם זהים

ה-ERD המשולב נבנה ב-ERDPlus כתרשים קונספטואלי. ERDPlus יכול גם ליצור relational schema מתוך ה-ERD, וה-DSD שנוצר כך צורף כ-`integrated_DSD_erdplus.png`.

עם זאת, ה-DSD הממומש מבוסס על SQL schema אמיתי שנוצר על ידי `Integrate.sql` ונשמר ב-`backup3.sql`. לכן ה-DSD הממומש עשוי לכלול טבלאות טכניות נוספות, טבלאות מיפוי ופרטי מימוש שאינם מוצגים באותה צורה ב-schema שנוצר על ידי ERDPlus.

זה מצב צפוי: ה-DSD של ERDPlus מדגים את ההמרה מ-ERD ל-relational schema, בעוד שה-DSD הממומש מדגים את מבנה בסיס הנתונים האמיתי לאחר האינטגרציה.

## 11. SQL של האינטגרציה

פקודות האינטגרציה נמצאות בקובץ:

```text
Integrate.sql
```

הקובץ מבצע את הפעולות הבאות:

1. יצירת `integration_sources` לתיעוד מקורות הנתונים.
2. הרחבת הטבלאות הקיימות `teams` ו-`matches`.
3. יצירת טבלאות מיפוי עבור מזהי קבוצות ומזהי משחקים שהתקבלו.
4. העברת קבוצות שהתקבלו לתוך `teams`.
5. העברת משחקים שהתקבלו לתוך `matches`.
6. יצירת טבלאות חדשות לניהול כדורגל.
7. העברת שחקנים, מאמנים, שופטים, אצטדיונים, חוזים וסטטיסטיקות.
8. חיבור קבוצות לאצטדיוני בית.
9. הרצת Validation Queries לבדיקת כמות שורות.

## 12. אימות האינטגרציה

לאחר האינטגרציה, בדקנו שבסיס הנתונים המשולב מכיל נתונים גם בטבלאות BetMaster המקוריות וגם בטבלאות Football Management החדשות.

**צילום מסך של בדיקת כמות שורות:**

![כמויות באינטגרציה](screenshots/integration_counts.png)

**מה צילום המסך מוכיח:** בסיס הנתונים המשולב מכיל רשומות משתי המערכות. טבלאות BetMaster כגון `users`, `bets`, `transactions` ו-`odds` עדיין מכילות נתונים, וגם טבלאות `football_*` החדשות מכילות נתונים מהמערכת שהתקבלה.

פלט אימות מלא:

```text
integration_validation_output.txt
```

## 13. הרצת Stage B Queries לאחר האינטגרציה

הדרישה במטלה היא להריץ את Queries השלב הקודם על בסיס הנתונים המשולב כדי לוודא שהם עדיין עובדים.

הרצנו את Stage B Queries לאחר האינטגרציה. צילום המסך הבא מציג את ה-Query `top_recent_winners.sql` רץ על בסיס הנתונים המשולב ומחזיר משתמשים חדשים יחסית עם זכיות גבוהות.

**פלט לדוגמה:**

![Stage B Query על בסיס הנתונים המשולב](screenshots/stage_b_top_recent_winners_integrated.png)

**מה צילום המסך מוכיח:** Query משלב ב' עדיין רץ בהצלחה לאחר האינטגרציה. הפלט מציג משתמשים חדשים יחסית עם זכיות גבוהות, ולכן פונקציונליות BetMaster המקורית לא נשברה בעקבות האינטגרציה.

פלט מלא:

```text
stage_b_queries_on_integrated_output.txt
```

## 14. Views

המטלה דורשת שני Views:

1. View אחד מנקודת המבט של המחלקה המקורית.
2. View אחד מנקודת המבט של המחלקה שהתקבלה.

יצרנו את שני ה-Views הנדרשים וגם View משולב נוסף.

### הערות פרשנות חשובות

ההערות הבאות מסבירות את העמודות המחושבות המרכזיות שמופיעות בצילומי המסך:

- `total_bet_amount` הוא סכום הכסף הכולל שמשתמש או משחק קיבל בהימורים.
- `balance` היא יתרת החשבון הזמינה הנוכחית של המשתמש.
- `bet_count` הוא מספר ההימורים שבוצעו על משחק.
- `won_bets` ו-`lost_bets` סופרים רק הימורים שהוכרעו. עבור משחקים מתוכננים או מבוטלים, ייתכן שלמשחק יש הימורים אך עדיין יופיעו `0` הימורים מנצחים ו-`0` הימורים מפסידים.
- שדות אצטדיון ריקים בשורות BetMaster הם צפויים, כי מערכת BetMaster המקורית לא שמרה נתוני אצטדיונים.
- שדות הימורים אפסיים בשורות FootballManagement הם צפויים, כי מערכת Football Management שהתקבלה לא שמרה נתוני הימורים.

### מדוע חלק מהערכים ריקים או אפסיים

חלק מצילומי המסך מכילים תאים ריקים או ערכי אפס. ערכים אלה צפויים ומשקפים את ההבדל בין שתי המערכות ששולבו.

| מקרה | מדוע זה קורה | מדוע זו אינה שגיאה |
| --- | --- | --- |
| שורות BetMaster כוללות עמודות אצטדיון ריקות | מערכת BetMaster המקורית ניהלה נתוני הימורים, לא נתוני אצטדיונים | נתוני האצטדיונים הגיעו ממערכת Football Management שהתקבלה |
| שורות FootballManagement כוללות `bet_count = 0` ו-`total_bet_amount = 0` | המערכת שהתקבלה ניהלה משחקי כדורגל, לא הימורים | הימורים קיימים רק עבור משחקי BetMaster המקוריים |
| למשחקים מתוכננים יש הימורים אך `won_bets = 0` ו-`lost_bets = 0` | משתמשים יכולים לבצע הימורים לפני שהמשחק מסתיים | ההימורים לא מוכרעים עד שיש תוצאה סופית |
| למשחקים מבוטלים עשויים להיות הימורים אך ללא ניצחונות/הפסדים | המשחק לא הושלם | אין תוצאה סופית שלפיה ניתן לסמן הימורים כמנצחים או מפסידים |
| `competition_stage` ריק בשורות BetMaster | BetMaster לא שמרה שלבי טורניר | שדה זה נוסף עבור משחקים שהתקבלו מ-Football Management |
| `attendees` ריק בשורות BetMaster | BetMaster לא שמרה נתוני קהל | נתוני קהל הגיעו מנתוני האצטדיון/משחק שהתקבלו |

ה-View המשולב שומר בכוונה את שתי המערכות באותה תוצאה. לכן לא לכל שורה יש ערכים בכל עמודה. שורת BetMaster עשירה בנתוני הימורים, בעוד ששורת FootballManagement עשירה בהקשר של אצטדיון וכדורגל.

## 15. View 1 - נקודת המבט של BetMaster

שם ה-View:

```text
vw_betmaster_user_activity
```

View זה מסכם פעילות משתמשים במערכת ההימורים. הוא משלב משתמשים, הימורים ועסקאות. זה אינו SELECT פשוט מטבלה אחת.

הוא כולל:

- פרטי משתמש,
- מספר הימורים כולל,
- סכום הימורים כולל,
- הימורים שניצחו,
- הימורים שהפסידו,
- הפקדות,
- משיכות,
- זכיות.

### הצגת 10 רשומות

```sql
SELECT *
FROM vw_betmaster_user_activity
LIMIT 10;
```

![בחירת נתונים מ-View של BetMaster](screenshots/view_betmaster_select.png)

**מה צילום המסך מציג:** 10 שורות לדוגמה מתוך ה-View של BetMaster. כל שורה מסכמת פעילות הימורים ופיננסים של משתמש אחד.

### Query 1 על View של BetMaster

מטרה: למצוא משתמשים פעילים עם נפח הימורים גבוה.

```sql
SELECT
    user_id,
    full_name,
    email,
    total_bets,
    total_bet_amount,
    balance
FROM vw_betmaster_user_activity
WHERE account_status = 'Active'
  AND total_bets >= 10
ORDER BY total_bet_amount DESC
LIMIT 10;
```

![Query 1 על View של BetMaster](screenshots/view_betmaster_query1.png)

**מה צילום המסך מציג:** משתמשים פעילים עם הימורים רבים, ממוינים לפי נפח הימורים כולל. הדבר מסייע למחלקת ההימורים לזהות משתמשים עם פעילות גבוהה.

### Query 2 על View של BetMaster

מטרה: למצוא משתמשים שהזכיות שלהם גבוהות מהמשיכות שלהם.

```sql
SELECT
    user_id,
    full_name,
    total_winnings,
    total_withdrawals,
    total_winnings - total_withdrawals AS winnings_after_withdrawals
FROM vw_betmaster_user_activity
WHERE total_winnings > total_withdrawals
ORDER BY winnings_after_withdrawals DESC
LIMIT 10;
```

![Query 2 על View של BetMaster](screenshots/view_betmaster_query2.png)

**מה צילום המסך מציג:** משתמשים שסך הזכיות שלהם גבוה מסך המשיכות שלהם. העמודה המחושבת מציגה את ההפרש שנותר בין זכיות למשיכות.

## 16. View 2 - נקודת המבט של Football Management

שם ה-View:

```text
vw_football_player_performance
```

View זה מסכם ביצועי שחקני כדורגל. הוא מחבר שחקנים, קבוצות, חוזי שחקנים וסטטיסטיקות משחק.

הוא כולל:

- פרטי שחקן,
- שם קבוצה,
- שכר,
- מספר משחקים ששוחקו,
- שערים,
- בישולים,
- כרטיסים צהובים,
- כרטיסים אדומים.

### הצגת 10 רשומות

```sql
SELECT *
FROM vw_football_player_performance
LIMIT 10;
```

![בחירת נתונים מ-View של Football](screenshots/view_football_select.png)

**מה צילום המסך מציג:** 10 שורות לדוגמה מתוך ה-View של Football Management. כל שורה מסכמת את הקבוצה, החוזה וביצועי המשחק של שחקן אחד.

### Query 1 על View של Football

מטרה: למצוא את השחקנים היעילים ביותר לפי שערים ובישולים.

```sql
SELECT
    player_id,
    player_name,
    team_name,
    total_goals,
    total_assists,
    total_goals + total_assists AS total_contributions
FROM vw_football_player_performance
WHERE matches_played > 0
ORDER BY total_contributions DESC, total_goals DESC
LIMIT 10;
```

![Query 1 על View של Football](screenshots/view_football_query1.png)

**מה צילום המסך מציג:** השחקנים היצרניים ביותר לפי תרומת שערים כוללת. העמודה `total_contributions` מחושבת כשערים ועוד בישולים.

### Query 2 על View של Football

מטרה: למצוא שחקנים בעלי שכר גבוה ותרומת שערים נמוכה.

```sql
SELECT
    player_id,
    player_name,
    team_name,
    salary,
    matches_played,
    total_goals
FROM vw_football_player_performance
WHERE salary > 100000
  AND total_goals < 5
ORDER BY salary DESC
LIMIT 10;
```

![Query 2 על View של Football](screenshots/view_football_query2.png)

**מה צילום המסך מציג:** שחקנים בעלי שכר גבוה ותרומת שערים נמוכה. סף השכר נקבע ל-`100000` כי הוא מתאים לסקאלת השכר בנתונים האמיתיים.

## 17. View משולב נוסף

בנוסף לשני ה-Views הנדרשים, יצרנו View משולב נוסף:

```text
vw_integrated_match_betting_context
```

View זה משלב מידע על משחקים עם הקשר הימורים, קבוצות, אצטדיונים, קהל ומידע על מערכת המקור. צילום המסך משתמש בדוגמה מעורבת: שורות BetMaster מדגימות פעילות הימורים, ושורות FootballManagement מדגימות נתוני אצטדיון וקהל.

```sql
WITH betmaster_examples AS (
    SELECT *
    FROM vw_integrated_match_betting_context
    WHERE source_system = 'BetMaster'
      AND total_bet_amount > 0
    ORDER BY total_bet_amount DESC
    LIMIT 5
), football_examples AS (
    SELECT *
    FROM vw_integrated_match_betting_context
    WHERE source_system = 'FootballManagement'
      AND attendees IS NOT NULL
    ORDER BY attendees DESC
    LIMIT 5
)
SELECT *
FROM betmaster_examples
UNION ALL
SELECT *
FROM football_examples
ORDER BY source_system, total_bet_amount DESC, attendees DESC;
```

![בחירת נתונים מה-View המשולב](screenshots/view_integrated_select.png)

**מה צילום המסך מציג:** דוגמה מעורבת מתוך ה-View המשולב. שורות BetMaster מציגות פעילות הימורים, בעוד ששורות FootballManagement מציגות נתוני אצטדיון וקהל. עמודות אצטדיון ריקות בשורות BetMaster הן צפויות, משום שמערכת ההימורים המקורית לא שמרה מידע על אצטדיונים. עמודות הימורים אפסיות בשורות FootballManagement הן גם צפויות, משום שהמערכת שהתקבלה לא שמרה הימורים.

## 18. גיבוי סופי

הגיבוי המשולב הסופי הוא:

```text
backup3.sql
```

גיבוי זה נוצר לאחר:

1. שחזור שתי המערכות,
2. הרצת סקריפט האינטגרציה,
3. יצירת ה-Views,
4. אימות הנתונים,
5. הרצת Stage B Queries בהצלחה.

## 19. סדר הרצה סופי

סדר ההרצה בפועל היה:

1. שחזור גיבוי שלב ב' שלנו.
2. שחזור הגיבוי שהתקבל.
3. הרצת `Integrate.sql`.
4. הרצת `Views.sql`.
5. אימות כמות שורות.
6. הרצת Stage B Queries על בסיס הנתונים המשולב.
7. יצירת `backup3.sql`.

## 20. סיכום

בסיס הנתונים המשולב הסופי מכיל נתונים משתי המערכות המקוריות. האינטגרציה שומרת על פונקציונליות ההימורים המקורית של BetMaster ומוסיפה מידע ניהולי של כדורגל כגון שחקנים, מאמנים, שופטים, אצטדיונים וסטטיסטיקות ביצועים.

התרשימים הנדרשים, סקריפטי ה-SQL, ה-Views, ה-Queries, הפלטים, הדוח והגיבוי הסופי כלולים כולם בתיקייה זו.
