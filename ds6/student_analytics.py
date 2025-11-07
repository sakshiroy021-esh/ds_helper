import pandas as pd
import numpy as np
import mysql.connector
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix
import matplotlib.pyplot as plt

conn = mysql.connector.connect(
    host="localhost",
    user="root",  # change to your MySQL username
    password="your_password",  # change to your MySQL password
    database="student_performance_db"
)

query = '''
SELECT s.student_id, s.first_name, s.last_name,
       (a.attended_classes / a.total_classes) * 100 AS attendance_percent,
       AVG(g.marks_obtained) AS avg_marks
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id
JOIN Grades g ON s.student_id = g.student_id
GROUP BY s.student_id;
'''

df = pd.read_sql(query, conn)
conn.close()

print("Data Loaded Successfully!")
print(df.head())

df['result'] = np.where((df['avg_marks'] >= 60) & (df['attendance_percent'] >= 75), 1, 0)

X = df[['avg_marks', 'attendance_percent']]
y = df['result']

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.3, random_state=42)

model = DecisionTreeClassifier(random_state=42)
model.fit(X_train, y_train)
y_pred = model.predict(X_test)

print("\nModel Evaluation:")
print("Accuracy:", accuracy_score(y_test, y_pred))
print("\nClassification Report:\n", classification_report(y_test, y_pred))
print("Confusion Matrix:\n", confusion_matrix(y_test, y_pred))

plt.figure(figsize=(7,5))
plt.scatter(df['attendance_percent'], df['avg_marks'], c=df['result'], cmap='coolwarm', edgecolors='k')
plt.xlabel('Attendance Percentage')
plt.ylabel('Average Marks')
plt.title('Attendance vs Marks (Pass=1, Fail=0)')
plt.show()
