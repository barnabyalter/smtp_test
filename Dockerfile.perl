FROM perl:5.32.1

RUN sed -i "s|DEFAULT@SECLEVEL=2|#DEFAULT@SECLEVEL=2|g" /etc/ssl/openssl.cnf
RUN sed -i 's/MinProtocol = TLSv1.2/MinProtocol = TLSv1.0/' /etc/ssl/openssl.cnf

RUN cpan Net::SMTP Authen::SASL

WORKDIR /app
ADD demo.pl .

ENTRYPOINT ["perl", "-MIO::Socket::SSL=debug4"]
CMD ["demo.pl"]
