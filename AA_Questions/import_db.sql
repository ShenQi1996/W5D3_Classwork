PRAGMA foreign_keys = ON;

-- DROP DATABASE questions;

CREATE TABLE users (
    author_id INTEGER PRIMARY KEY,
    fname CHARACTER NOT NULL, 
    lname CHARACTER NOT NULL
);

CREATE TABLE questions (
    questions_id INTEGER PRIMARY KEY,
    title CHARACTER NOT NULL,
    body CHARACTER NOT NULL,
    au_id INTEGER,
    FOREIGN KEY (au_id) REFERENCES users(author_id)
);

CREATE TABLE question_follows (
    question_follows_id INTEGER PRIMARY KEY,
    author_id INTEGER,
    questions_id INTEGER,
    FOREIGN KEY (author_id) REFERENCES users(author_id),
    FOREIGN KEY (questions_id) REFERENCES questions(questions_id)
);

CREATE TABLE replies (
    replies_id INTEGER PRIMARY KEY,
    reply CHARACTER NOT NULL,
    questions_id INTEGER,
    parent_id INTEGER,
    author_id INTEGER,
    FOREIGN KEY (questions_id) REFERENCES question_follows(questions_id),
    FOREIGN KEY (parent_id) REFERENCES replies(replies_id),
    FOREIGN KEY (author_id) REFERENCES question_follows(author_id)
);

CREATE TABLE question_likes (
    author_id INTEGER,
    questions_id INTEGER,
    likes BOOLEAN,
    FOREIGN KEY (author_id) REFERENCES question_follows(author_id),
    FOREIGN KEY (questions_id) REFERENCES question_follows(questions_id)
);