FROM perl:5.32.1

ENV PERL_MM_USE_DEFAULT 1

RUN apt-get update -qq && apt-get install -y \
      ca-certificates

RUN cpan IO::Socket::SSL
RUN cpan Net::SMTP 
RUN cpan Authen::SASL
RUN cpan XML::LibXML
RUN cpan XML::LibXSLT

RUN sed -i "s|DEFAULT@SECLEVEL=2|#DEFAULT@SECLEVEL=2|g" /etc/ssl/openssl.cnf
RUN sed -i 's/MinProtocol = TLSv1.2/MinProtocol = TLSv1.0/' /etc/ssl/openssl.cnf

WORKDIR /app
ADD demo.pl .
# COPY lib/ ./

ENTRYPOINT ["perl", "-MIO::Socket::SSL=debug4"]
CMD ["demo.pl"]
# CMD ["ALEPH_HOLD_NOTICE_PARSE_SEND.pl", "FIRST_NOTICE_EMAIL.xml"]
# CMD ["TNS_HOLD_NOTICE_PARSE_SEND.pl", "FIRST_NOTICE_EMAIL_TNS.xml"]
