# Create List of Test Students and Students

cd /home/quagadmin/lbgfs2020
# test student usernames
cat test_students_lbgfs2020.txt | cut -d ',' -f1 > test-student-usernames-lbgfs2020.txt
# student usernames
cat students_lbgfs2020.txt | cut -d ',' -f1 > student-usernames-lbgfs2020.txt
