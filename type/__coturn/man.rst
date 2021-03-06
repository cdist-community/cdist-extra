cdist-type__coturn(7)
=====================

NAME
----
cdist-type__coturn - Install and configure a coturn TURN server


DESCRIPTION
-----------
This (singleton) type installs and configures a coturn TURN server.


REQUIRED PARAMETERS
-------------------
None.


OPTIONAL PARAMETERS
-------------------
static_auth_secret
    Secret used to access the TURN REST API.

realm
    Default realm.

allowed-peer
    Allow specific IP addresses or ranges of IP addresses. Can be specified multiple times.

denied-peer
    Ban specific IP addresses or ranges of IP addresses. Can be specified multiple times.

cert
    Path to certificate file. Absolute or relative. Use PEM file format.

pkey
    Patch to private key file. Use PEM file format.

min-port
    Lower bound of the UDP port range for relay endpoints allocation.
    Default value is 49152, according to RFC 5766.

max-port
    Upper bound of the UDP port range for relay endpoints allocation.
    Default value is 65535, according to RFC 5766.

extra-config
    This will be appended verbatim to the end of `coturn.conf`, use this for more
    complex setups where the parameters exposed by this type are not enough.
    If its value is `-`, stdin will be used.


BOOLEAN PARAMETERS
------------------
use-auth-secret
    Allows TURN credentials to be accounted for a specific user id.

no-tcp-relay
    Disable TCP relay endpoints.

no-udp-relay
    Disable UDP relay endpoints.

no-tls
    Disable TLS listener.

no-dtls
    Disable DTLS listener.


EXAMPLES
--------

.. code-block:: sh

    __coturn \
      --realm turn.domain.tld \
      --no_tcp_relay

    __coturn \
      --realm turn.domain.tld \
      --extra-config '-' <<EOF
    # Debug logging
    Verbose
    # Use a redis database
    redis-userdb="ip=[::1] dbname=coturn password=secret port=6379 connect_timeout=2"
    EOF


SEE ALSO
--------
- `coturn Github repository <https://github.com/coturn/coturn>`_

AUTHORS
-------
Timothée Floure <timothee.floure@ungleich.ch>


COPYING
-------
Copyright \(C) 2020 Timothée Floure. You can redistribute it
and/or modify it under the terms of the GNU General Public License as
published by the Free Software Foundation, either version 3 of the
License, or (at your option) any later version.
