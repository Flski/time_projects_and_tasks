PRAGMA foreign_keys=ON;

CREATE TABLE IF NOT EXISTS clients (
    id INTEGER PRIMARY KEY,
    login TEXT NOT NULL CHECK(LENGTH(login) BETWEEN 4 AND 100),
    password_hash NOT NULL CHECK(LENGTH(password_hash) BETWEEN 8 AND 10000),
    UNIQUE(login)
);

CREATE TABLE IF NOT EXISTS projects (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL CHECK(LENGTH(name) BETWEEN 1 AND 100),
    description TEXT CHECK(LENGTH(description) BETWEEN 1 AND 10000),
    status TEXT NOT NULL CHECK(status in ('active', 'completed')),
    created_at TEXT NOT NULL CHECK(LENGTH(created_at) BETWEEN 1 AND 10000),
    user_id INTEGER NOT NULL,
    FOREIGN KEY (user_id) REFERENCES clients (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS tasks (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL CHECK(LENGTH(name) BETWEEN 1 AND 100),
    description TEXT CHECK(LENGTH(description) BETWEEN 1 AND 10000),
    status TEXT NOT NULL CHECK(status in ('passive', 'start', 'stop', 'pause')),
    created_at TEXT NOT NULL CHECK(LENGTH(created_at) BETWEEN 1 AND 10000),
    project_id INTEGER NOT NULL,
    FOREIGN KEY (project_id) REFERENCES projects (id) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS time_logs (
    id INTEGER PRIMARY KEY,
    datetime_start TEXT NOT NULL CHECK(LENGTH(datetime_start) BETWEEN 1 AND 10000),
    datetime_end TEXT CHECK(LENGTH(datetime_end) BETWEEN 1 AND 10000),
    comment TEXT CHECK(LENGTH(comment) BETWEEN 1 AND 10000),
    duration TEXT CHECK(LENGTH(duration) BETWEEN 1 AND 10000),
    task_id INTEGER NOT NULL,
    FOREIGN KEY (task_id) REFERENCES tasks (id) ON DELETE CASCADE
);

CREATE INDEX index_user_id ON projects(user_id);
CREATE INDEX index_project_id ON tasks(project_id);
CREATE INDEX index_task_id ON time_logs(task_id);
CREATE UNIQUE INDEX index_login ON clients(login);