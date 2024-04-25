# ***Проєкт "Бджілка"***

![Logo](/app/assets/images/logo.svg)

## **Про нас**

***Проєкт "Бджілка"*** - це багатофункціональна інтернет платформа для бронювання різноманітних послуг з метою спрощення життя людини - від вибору особистого фітнес тренеру, замовлення репетиторів для навчання дітей, вигулу домашніх тварин до планування туристичних подорожей чи використання послуг віртуального асистента. Серед аналогів проєкту є вкрай популярний сервіс "Kabanchik.ua".

---

Платформа уявляє собою багатосторінковий web-сайт, для роботи з яким не потрібно мати спеціальних навичок, адже проста та зручна реалізація користувальницького інтерфесу стане зрозумілою навіть для дитини. Серед головних можливостей застосунку є пошук і бронювання необхідних видів послуг, а також ознайомлення з рейтингами виконавців та цілодобова технічна підримка. Користувачу надається можливість відчути увесь спектр переваг використання веб-додатку завдяки виконанню простих умов щодо регістрації, з можливостями подальшої аутентифікації та авторизації. 

---

***"P.S."*** Проєкт був розроблений на базі мови програмування Ruby, користуючись функціональними можливостями фреймворку Ruby on Rails, засобами web-дизайну HTML & CSS та сервера управління базами даних. Веб-додаток підготували студенти ХНУ ім. В.Н. Каразіна, факультету комп'ютерних наук, групи КС32, у 2024 році. 

---

## Посилання

- [Про нас](#про-нас)
- [API Документація](#api-документація) 
- [Діаграми](#діаграми)
    - [ER Діаграма](#er-діаграма)
- [Скрипти](#скрипти) 
    - [Скрипти завдань](#скрипти-завдань)
    - [Скрипти тестів](#скрипти-тестування) 
- [Встановлення та запуск](#встановлення-та-запуск)

---

# **API Документація**

| HTTP-метод | Шлях (URL)         | Дія                   |
|------------|--------------------|-----------------------|
| GET        | /                  | Головна сторінка      |
| GET, POST, DELETE | /clients/sign_in, /clients/sign_up, /clients/password/new | Авторизація(вхід), реєстрація, скидання пароля користувачів |
| GET, POST, PUT, PATCH, DELETE | /difficulties, /services, /urgencies, /comments, /statuses, /specializations, /positions, /addresses, /orders, /employees, /clients | Операції з ресурсами |
| GET        | /up                | Перевірка стану додатка |

---

# **Діаграми**

## ER Діаграма

![ER-diagram](/docs/ScreenOfDBFinal.png)

---

# **Скрипти**

## Скрипти завдань

- [parser_data.rake](/lib/tasks/parse_data.rake) - Rake задача розпарсування

## Скрипти тестування

- [parse_task_test.rb](/test/tasks/parse_task_test.rb) - Тест для Rake задачі розпарсування

---

# Встановлення та запуск

Якщо Ви хочете стати адміністраторм web-додатку, то Вам необхідно виконати наступні дії щодо встановлення та запуску:

1. Встановіть програмне забезпечення для мови програмування Ruby (бажано також мати RubyMain чи інший IDE).
2. Клонуйте проєкт із даного репозиторію GitHub (перевірте, чи встановлений Git на Вашому пристрої):
    - створіть робочу директорію на комп'ютерному прристорї (ex: C:\User\Users\work_dir);
    - за допомогою засобів командного рядка, введіть git-команду "*git clone https://github.com/SabinaGamidova721/PlatformForBookingServices.git*";
3. Перевірте, чи усі дані були повністю перенесені на Ваш пристрій.
4. У поточній робочій директорії виконайте декілька кроків для налаштування та запуску web-застосунку:
    - використовуючи можливості консолі, введіть команду "*bundle install*" для завантаження необхідних gems;
    - запустіть локальний сервер завдяки команді "*rails s*" (завершення роботи серверу - "*Ctrl+C*");
    - користуючись будь-яким браузером, який встановлений на Вашому ПК, перейдіть за посиланням "*localhost:3000*".
5. Використовуйте веб-додаток для здійснення власних цілей. Нехай щастить!

***"P.S."*** Проєкт "Бджілка" є лише початковим прототипом сервісу для бронювання послуг, тому на даний момент увесь функціонал реалізується на локальному сервері комп'ютерного пристрою.
