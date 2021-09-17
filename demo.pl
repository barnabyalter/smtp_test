use strict;
use warnings;

use Net::SMTP;
use Authen::SASL;

my $smtpserver = $ENV{SMTP_SERVER};
my $smtpdomain = $ENV{SMTP_DOMAIN};
my $smtpport = $ENV{SMTP_PORT};
my $smtpuser = $ENV{SMTP_USER};
my $from = $ENV{SMTP_FROM_EMAIL};
my $smtppass = $ENV{SMTP_PASSWORD};
my $sendto = $ENV{SMTP_TO_EMAIL};

my $smtp = Net::SMTP->new(
        $smtpserver,
        Port => $smtpport,
        SSL => 0, 
        Timeout => 30,
        Debug => 1,
        SendHello => 0
);

$smtp->hello();
$smtp->starttls();
$smtp->hello();
$smtp->auth($smtpuser, $smtppass);
$smtp->mail($from);
if ($smtp->to($sendto)) {
        $smtp->data();
        $smtp->datasend("From: $from\n");
        $smtp->datasend("To: $sendto\n");
        $smtp->datasend("Subject: Test message\n");
        $smtp->datasend("\n");
        $smtp->datasend("The test works!\n");
        $smtp->dataend();
} else {
        print "Error: ", $smtp->message();
}
$smtp->quit;
