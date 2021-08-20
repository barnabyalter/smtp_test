import os
from smtplib import SMTP

smtp_server = os.getenv('SMTP_SERVER')
smtp_domain = os.getenv('SMTP_DOMAIN')
smtp_port = os.getenv('SMTP_PORT')
smtp_user = os.getenv('SMTP_USER')
from_email = os.getenv('SMTP_FROM_EMAIL')
smtp_password = os.getenv('SMTP_PASSWORD')
to_email = os.getenv('SMTP_TO_EMAIL')

smtp = SMTP(smtp_server, smtp_port)
smtp.connect(smtp_server, smtp_port)
smtp.ehlo()
smtp.starttls()
smtp.login(smtp_user, smtp_password)
text = "testing"
smtp.sendmail(from_email, to_email, text)
smtp.quit()
