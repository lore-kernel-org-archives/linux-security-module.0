From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Wed, 07 Mar 2018 15:29:34 -0800
Subject: [RFC 0/5] add integrity and security to TPM2 transactions
Message-ID: <1520465374.4894.12.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

By now, everybody knows we have a problem with the TPM2_RS_PW easy
button on TPM2 in that transactions on the TPM bus can be intercepted
and altered. ?The way to fix this is to use real sessions for HMAC
capabilities to ensure integrity and to use parameter and response
encryption to ensure confidentiality of the data flowing over the TPM
bus.

This RFC is about adding a simple API which can ensure the above
properties as a layered addition to the existing TPM handling code.
?Eventually we can add this to the random number generator, the PCR
extensions and the trusted key handling, but this all depends on the
conversion to tpm_buf which is not yet upstream, so I've constructed a
second patch which demonstrates the new API in a test module for those
who wish to play with it.

This series is also dependent on additions to the crypto subsystem to
fix problems in the elliptic curve key handling and add the Cipher
FeedBack encryption scheme:

https://marc.info/?l=linux-crypto-vger&m=151994371015475

In the second version, I added security HMAC to our PCR extend and
encryption to the returned random number generators and also extracted
the parsing and tpm2b construction API into a new file.

James

---

James Bottomley (5):
  tpm-buf: create new functions for handling TPM buffers
  tpm2-sessions: Add full HMAC and encrypt/decrypt session handling
  tpm2: add hmac checks to tpm2_pcr_extend()
  tpm2: add session encryption protection to tpm2_get_random()
  tpm2-sessions: NOT FOR COMMITTING add sessions testing

 drivers/char/tpm/Kconfig              |    3 +
 drivers/char/tpm/Makefile             |    3 +-
 drivers/char/tpm/tpm-buf.c            |  184 ++++++
 drivers/char/tpm/tpm-chip.c           |    1 +
 drivers/char/tpm/tpm.h                |  116 ++--
 drivers/char/tpm/tpm2-cmd.c           |  129 ++---
 drivers/char/tpm/tpm2-sessions-test.c |  177 ++++++
 drivers/char/tpm/tpm2-sessions.c      | 1030 +++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.h      |   56 ++
 9 files changed, 1548 insertions(+), 151 deletions(-)
 create mode 100644 drivers/char/tpm/tpm-buf.c
 create mode 100644 drivers/char/tpm/tpm2-sessions-test.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.h

-- 
2.12.3
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
