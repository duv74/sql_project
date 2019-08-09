-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


SET XACT_ABORT ON

BEGIN TRANSACTION QUICKDBD

CREATE TABLE [DEPARTMENTS] (
    [dept_no] int  NOT NULL ,
    [dept_name] varchar(30)  NOT NULL ,
    CONSTRAINT [PK_DEPARTMENTS] PRIMARY KEY CLUSTERED (
        [dept_no] ASC
    )
)

CREATE TABLE [DEPT_EMP] (
    [emp_no] int  NOT NULL ,
    [dept_no] int  NOT NULL ,
    [from_date] date  NOT NULL ,
    [to_date] date  NOT NULL ,
    CONSTRAINT [PK_DEPT_EMP] PRIMARY KEY CLUSTERED (
        [emp_no] ASC
    )
)

CREATE TABLE [DEPT_MANAGER] (
    [dept_no] int  NOT NULL ,
    [emp_no] int  NOT NULL ,
    [from_date] date  NOT NULL ,
    [to_date] date  NOT NULL ,
    CONSTRAINT [PK_DEPT_MANAGER] PRIMARY KEY CLUSTERED (
        [emp_no] ASC
    )
)

CREATE TABLE [EMPLOYEES] (
    [emp_no] int  NOT NULL ,
    [birth_date] date  NOT NULL ,
    [first_name] varchar(30)  NOT NULL ,
    [last_name] varchar(30)  NOT NULL ,
    [gender] bool  NOT NULL ,
    [hire_date] date  NOT NULL ,
    CONSTRAINT [PK_EMPLOYEES] PRIMARY KEY CLUSTERED (
        [emp_no] ASC
    )
)

CREATE TABLE [SALARIES] (
    [emp_no] int  NOT NULL ,
    [salary] money  NOT NULL ,
    [from_date] date  NOT NULL ,
    [to_date] date  NOT NULL ,
    CONSTRAINT [PK_SALARIES] PRIMARY KEY CLUSTERED (
        [emp_no] ASC
    )
)

CREATE TABLE [TITLES] (
    [emp_no] int  NOT NULL ,
    [title] varchar(30)  NOT NULL ,
    [from_date] date  NOT NULL ,
    [to_date] date  NOT NULL ,
    CONSTRAINT [PK_TITLES] PRIMARY KEY CLUSTERED (
        [emp_no] ASC
    )
)

ALTER TABLE [DEPT_EMP] WITH CHECK ADD CONSTRAINT [FK_DEPT_EMP_dept_no] FOREIGN KEY([dept_no])
REFERENCES [DEPARTMENTS] ([dept_no])

ALTER TABLE [DEPT_EMP] CHECK CONSTRAINT [FK_DEPT_EMP_dept_no]

ALTER TABLE [DEPT_MANAGER] WITH CHECK ADD CONSTRAINT [FK_DEPT_MANAGER_dept_no] FOREIGN KEY([dept_no])
REFERENCES [DEPT_EMP] ([dept_no])

ALTER TABLE [DEPT_MANAGER] CHECK CONSTRAINT [FK_DEPT_MANAGER_dept_no]

ALTER TABLE [EMPLOYEES] WITH CHECK ADD CONSTRAINT [FK_EMPLOYEES_emp_no] FOREIGN KEY([emp_no])
REFERENCES [TITLES] ([emp_no])

ALTER TABLE [EMPLOYEES] CHECK CONSTRAINT [FK_EMPLOYEES_emp_no]

ALTER TABLE [SALARIES] WITH CHECK ADD CONSTRAINT [FK_SALARIES_emp_no] FOREIGN KEY([emp_no])
REFERENCES [DEPT_MANAGER] ([emp_no])

ALTER TABLE [SALARIES] CHECK CONSTRAINT [FK_SALARIES_emp_no]

ALTER TABLE [TITLES] WITH CHECK ADD CONSTRAINT [FK_TITLES_emp_no] FOREIGN KEY([emp_no])
REFERENCES [SALARIES] ([emp_no])

ALTER TABLE [TITLES] CHECK CONSTRAINT [FK_TITLES_emp_no]

COMMIT TRANSACTION QUICKDBD