PRAGMA foreign_keys = ON;

CREATE TABLE users (
    author_id INTEGER PRIMARY KEY
    fname CHARACTER NOT NULL, 
    lname CHARACTER NOT NULL
);

CREATE TABLE questions (
    questions_id INTEGER PRIMARY KEY
    title CHARACTER NOT NULL,
    body CHARACTER NOT NULL,
    author_id INTEGER,

    FOREIGN_KEY (author_id) REFERENCES users(author_id)
);

CREATE TABLE question_follows (
    question_follows_id INTEGER PRIMARY KEY,
    author_id INTEGER,
    questions_id INTEGER,

    FOREIGN_KEY (author_id) REFERENCES users(author_id),
    FOREIGN_KEY (questions_id) REFERENCES questions(questions_id)
);


CREATE TABLE replies (
    replies_id INTEGER PRIMARY KEY,
    reply  CHARACTER NOT NULL,
    question_follows_id INTEGER,
    
    FOREIGN_KEY (question_follows_id) REFERENCES question_follows(question_follows_id)
);
