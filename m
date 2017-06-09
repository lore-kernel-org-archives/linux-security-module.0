From: jmorris@namei.org (James Morris)
Date: Fri, 9 Jun 2017 13:51:28 +1000 (AEST)
Subject: [GIT PULL] Keys subsystem update
Message-ID: <alpine.LRH.2.20.1706091349040.8421@namei.org>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Please pull these Keys subsystem fixes for 4.12.  From David Howells:


"Here are a bunch of fixes for Linux keyrings, including:

 (*) Fixing up the refcount handling now that key structs use the
     refcount_t type and the refcount_t ops don't allow a 0->1 transition.

 (*) Fix a potential NULL deref after error in x509_cert_parse().

 (*) Don't put data for the crypto algorithms to use on the stack.

 (*) Fix the handling of a null payload being passed to add_key().

 (*) Fix incorrect cleanup an uninitialised key_preparsed_payload in
     key_update().

 (*) Explicit sanitisation of potentially secure data before freeing.

 (*) Fixes for the Diffie-Helman code."


---

The following changes since commit aea4156c308670699d74dedb182ebceffb633185:

  Merge tag 'modules-for-v4.12-rc5' of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux (2017-06-08 16:28:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/jmorris/linux-security.git for-linus

Bilal Amarni (1):
      security/keys: add CONFIG_KEYS_COMPAT to Kconfig

Dan Carpenter (1):
      X.509: Fix error code in x509_cert_parse()

Davidlohr Bueso (1):
      security: use READ_ONCE instead of deprecated ACCESS_ONCE

Eric Biggers (16):
      KEYS: put keyring if install_session_keyring_to_cred() fails
      KEYS: encrypted: avoid encrypting/decrypting stack buffers
      KEYS: encrypted: fix buffer overread in valid_master_desc()
      KEYS: encrypted: fix race causing incorrect HMAC calculations
      KEYS: encrypted: use constant-time HMAC comparison
      KEYS: fix dereferencing NULL payload with nonzero length
      KEYS: fix freeing uninitialized memory in key_update()
      KEYS: sanitize add_key() and keyctl() key payloads
      KEYS: user_defined: sanitize key payloads
      KEYS: encrypted: sanitize all key material
      KEYS: trusted: sanitize all key material
      KEYS: sanitize key structs before freeing
      KEYS: DH: forbid using digest_null as the KDF hash
      KEYS: DH: don't feed uninitialized "otherinfo" into KDF
      KEYS: DH: ensure the KDF counter is properly aligned
      KEYS: DH: add __user annotations to keyctl_kdf_params

Loganaden Velvindron (1):
      crypto : asymmetric_keys : verify_pefile:zero memory content before freeing

Mark Rutland (1):
      KEYS: fix refcount_inc() on zero

Markus Elfring (1):
      KEYS: Delete an error message for a failed memory allocation in get_derived_key()

Mat Martineau (1):
      KEYS: Convert KEYCTL_DH_COMPUTE to use the crypto KPP API

 arch/arm64/Kconfig                        |    4 -
 arch/powerpc/Kconfig                      |    5 -
 arch/s390/Kconfig                         |    3 -
 arch/sparc/Kconfig                        |    3 -
 arch/x86/Kconfig                          |    4 -
 crypto/asymmetric_keys/verify_pefile.c    |    4 +-
 crypto/asymmetric_keys/x509_cert_parser.c |    1 +
 include/linux/key.h                       |    1 -
 include/uapi/linux/keyctl.h               |    4 +-
 security/keys/Kconfig                     |    6 +-
 security/keys/dh.c                        |  300 ++++++++++++++++++-----------
 security/keys/encrypted-keys/encrypted.c  |  204 +++++++-------------
 security/keys/gc.c                        |    4 +-
 security/keys/key.c                       |   16 +-
 security/keys/keyctl.c                    |   16 +-
 security/keys/keyring.c                   |   12 +-
 security/keys/process_keys.c              |    7 +-
 security/keys/trusted.c                   |   50 ++---
 security/keys/user_defined.c              |   16 ++-
 19 files changed, 330 insertions(+), 330 deletions(-)
--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
