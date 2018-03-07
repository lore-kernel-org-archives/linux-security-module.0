From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Wed, 07 Mar 2018 15:31:27 -0800
Subject: [RFC v2 2/5] tpm2-sessions: Add full HMAC and encrypt/decrypt
	session handling
In-Reply-To: <1520465374.4894.12.camel@HansenPartnership.com>
References: <1520465374.4894.12.camel@HansenPartnership.com>
Message-ID: <1520465487.4894.14.camel@HansenPartnership.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

This code adds true session based HMAC authentication plus parameter
decryption and response encryption using AES.

The basic design of this code is to segregate all the nasty crypto,
hash and hmac code into tpm2-sessions.c and export a usable API.

The API first of all starts off by gaining a session with

tpm2_start_auth_session()

Which initiates a session with the TPM and allocates an opaque
tpm2_auth structure to handle the session parameters.  Then the use is
simply:

* tpm_buf_append_name() in place of the tpm_buf_append_u32 for the
  handles

* tpm_buf_append_hmac_session() where tpm2_append_auth() would go

* tpm_buf_fill_hmac_session() called after the entire command buffer
  is finished but before tpm_transmit_cmd() is called which computes
  the correct HMAC and places it in the command at the correct
  location.

Finally, after tpm_transmit_cmd() is called,
tpm_buf_check_hmac_response() is called to check that the returned
HMAC matched and collect the new state for the next use of the
session, if any.

The features of the session is controlled by the session attributes
set in tpm_buf_append_hmac_session().  If TPM2_SA_CONTINUE_SESSION is
not specified, the session will be flushed and the tpm2_auth structure
freed in tpm_buf_check_hmac_response(); otherwise the session may be
used again.  Parameter encryption is specified by or'ing the flag
TPM2_SA_DECRYPT and response encryption by or'ing the flag
TPM2_SA_ENCRYPT.  the various encryptions will be taken care of by
tpm_buf_fill_hmac_session() and tpm_buf_check_hmac_response()
respectively.

To get all of this to work securely, the Kernel now needs a primary
key to encrypt the session salt to, so we derive an EC key from the
NULL seed and store it in the tpm_chip structure.  We also make sure
that this seed remains for the kernel by using a kernel space to take
it out of the TPM when userspace wants to use it.

Signed-off-by: James Bottomley <James.Bottomley@HansenPartnership.com>

---

v2: Added docbook and improved response check API
---
 drivers/char/tpm/Kconfig         |    3 +
 drivers/char/tpm/Makefile        |    2 +-
 drivers/char/tpm/tpm.h           |   26 +
 drivers/char/tpm/tpm2-cmd.c      |   22 +-
 drivers/char/tpm/tpm2-sessions.c | 1030 ++++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/tpm2-sessions.h |   56 +++
 6 files changed, 1126 insertions(+), 13 deletions(-)
 create mode 100644 drivers/char/tpm/tpm2-sessions.c
 create mode 100644 drivers/char/tpm/tpm2-sessions.h

diff --git a/drivers/char/tpm/Kconfig b/drivers/char/tpm/Kconfig
index 0aee88df98d1..8c714d8550c4 100644
--- a/drivers/char/tpm/Kconfig
+++ b/drivers/char/tpm/Kconfig
@@ -8,6 +8,9 @@ menuconfig TCG_TPM
 	select SECURITYFS
 	select CRYPTO
 	select CRYPTO_HASH_INFO
+	select CRYPTO_ECDH
+	select CRYPTO_AES
+	select CRYPTO_CFB
 	---help---
 	  If you have a TPM security chip in your system, which
 	  implements the Trusted Computing Group's specification,
diff --git a/drivers/char/tpm/Makefile b/drivers/char/tpm/Makefile
index 41b2482b97c3..b83737ccaa81 100644
--- a/drivers/char/tpm/Makefile
+++ b/drivers/char/tpm/Makefile
@@ -5,7 +5,7 @@
 obj-$(CONFIG_TCG_TPM) += tpm.o
 tpm-y := tpm-interface.o tpm-dev.o tpm-sysfs.o tpm-chip.o tpm2-cmd.o \
 	 tpm-dev-common.o tpmrm-dev.o tpm1_eventlog.o tpm2_eventlog.o \
-         tpm2-space.o tpm-buf.o
+         tpm2-space.o tpm-buf.o tpm2-sessions.o
 tpm-$(CONFIG_ACPI) += tpm_ppi.o tpm_eventlog_acpi.o
 tpm-$(CONFIG_EFI) += tpm_eventlog_efi.o
 tpm-$(CONFIG_OF) += tpm_eventlog_of.o
diff --git a/drivers/char/tpm/tpm.h b/drivers/char/tpm/tpm.h
index 51c1fab2354c..1b495d748f90 100644
--- a/drivers/char/tpm/tpm.h
+++ b/drivers/char/tpm/tpm.h
@@ -42,6 +42,9 @@
 #include <asm/intel-family.h>
 #endif
 
+/* fixed define for the curve we use which is NIST_P256 */
+#define EC_PT_SZ	32
+
 enum tpm_const {
 	TPM_MINOR = 224,	/* officially assigned */
 	TPM_BUFSIZE = 4096,
@@ -93,6 +96,7 @@ enum tpm2_const {
 enum tpm2_structures {
 	TPM2_ST_NO_SESSIONS	= 0x8001,
 	TPM2_ST_SESSIONS	= 0x8002,
+	TPM2_ST_CREATION	= 0x8021,
 };
 
 /* Indicates from what layer of the software stack the error comes from */
@@ -114,16 +118,25 @@ enum tpm2_return_codes {
 enum tpm2_algorithms {
 	TPM2_ALG_ERROR		= 0x0000,
 	TPM2_ALG_SHA1		= 0x0004,
+	TPM2_ALG_AES		= 0x0006,
 	TPM2_ALG_KEYEDHASH	= 0x0008,
 	TPM2_ALG_SHA256		= 0x000B,
 	TPM2_ALG_SHA384		= 0x000C,
 	TPM2_ALG_SHA512		= 0x000D,
 	TPM2_ALG_NULL		= 0x0010,
 	TPM2_ALG_SM3_256	= 0x0012,
+	TPM2_ALG_ECC		= 0x0023,
+	TPM2_ALG_CFB		= 0x0043,
+};
+
+enum tpm2_curves {
+	TPM2_ECC_NONE		= 0x0000,
+	TPM2_ECC_NIST_P256	= 0x0003,
 };
 
 enum tpm2_command_codes {
 	TPM2_CC_FIRST		= 0x011F,
+	TPM2_CC_CREATE_PRIMARY	= 0x0131,
 	TPM2_CC_SELF_TEST	= 0x0143,
 	TPM2_CC_STARTUP		= 0x0144,
 	TPM2_CC_SHUTDOWN	= 0x0145,
@@ -133,6 +146,7 @@ enum tpm2_command_codes {
 	TPM2_CC_CONTEXT_LOAD	= 0x0161,
 	TPM2_CC_CONTEXT_SAVE	= 0x0162,
 	TPM2_CC_FLUSH_CONTEXT	= 0x0165,
+	TPM2_CC_START_AUTH_SESS	= 0x0176,
 	TPM2_CC_GET_CAPABILITY	= 0x017A,
 	TPM2_CC_GET_RANDOM	= 0x017B,
 	TPM2_CC_PCR_READ	= 0x017E,
@@ -141,6 +155,7 @@ enum tpm2_command_codes {
 };
 
 enum tpm2_permanent_handles {
+	TPM2_RH_NULL		= 0x40000007,
 	TPM2_RS_PW		= 0x40000009,
 };
 
@@ -243,11 +258,18 @@ struct tpm_chip {
 #endif /* CONFIG_ACPI */
 
 	struct tpm_space work_space;
+	struct tpm_space kernel_space;
 	u32 nr_commands;
 	u32 *cc_attrs_tbl;
 
 	/* active locality */
 	int locality;
+
+	/* details for communication security via sessions */
+	u32 tpmkey;
+	u8 tpmkeyname[34];
+	u8 ec_point_x[EC_PT_SZ];
+	u8 ec_point_y[EC_PT_SZ];
 };
 
 #define to_tpm_chip(d) container_of(d, struct tpm_chip, dev)
@@ -428,6 +450,9 @@ u8 tpm_get_inc_u8(const u8 **ptr);
 u16 tpm_get_inc_u16(const u8 **ptr);
 u32 tpm_get_inc_u32(const u8 **ptr);
 
+/* opaque structure, holds auth session parameters like the session key */
+struct tpm2_auth;
+
 extern struct class *tpm_class;
 extern struct class *tpmrm_class;
 extern dev_t tpm_devt;
@@ -547,4 +572,5 @@ static inline int tpm_read_log_efi(struct tpm_chip *chip)
 
 int tpm_bios_log_setup(struct tpm_chip *chip);
 void tpm_bios_log_teardown(struct tpm_chip *chip);
+int tpm2_sessions_init(struct tpm_chip *chip);
 #endif
diff --git a/drivers/char/tpm/tpm2-cmd.c b/drivers/char/tpm/tpm2-cmd.c
index 13d9e74084aa..2042d4008b9c 100644
--- a/drivers/char/tpm/tpm2-cmd.c
+++ b/drivers/char/tpm/tpm2-cmd.c
@@ -16,17 +16,10 @@
  */
 
 #include "tpm.h"
+#include "tpm2-sessions.h"
 #include <crypto/hash_info.h>
 #include <keys/trusted-type.h>
 
-enum tpm2_object_attributes {
-	TPM2_OA_USER_WITH_AUTH		= BIT(6),
-};
-
-enum tpm2_session_attributes {
-	TPM2_SA_CONTINUE_SESSION	= BIT(0),
-};
-
 struct tpm2_startup_in {
 	__be16	startup_type;
 } __packed;
@@ -435,10 +428,10 @@ void tpm2_flush_context_cmd(struct tpm_chip *chip, u32 handle,
  * @hmac: the session HMAC or password, may be NULL if not used
  * @hmac_len: the session HMAC or password length, maybe 0 if not used
  */
-static void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
-				 const u8 *nonce, u16 nonce_len,
-				 u8 attributes,
-				 const u8 *hmac, u16 hmac_len)
+void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
+			  const u8 *nonce, u16 nonce_len,
+			  u8 attributes,
+			  const u8 *hmac, u16 hmac_len)
 {
 	tpm_buf_append_u32(buf, 9 + nonce_len + hmac_len);
 	tpm_buf_append_u32(buf, session_handle);
@@ -1095,6 +1088,11 @@ int tpm2_auto_startup(struct tpm_chip *chip)
 
 	rc = tpm2_get_cc_attrs_tbl(chip);
 
+	if (rc)
+		goto out;
+
+	rc = tpm2_sessions_init(chip);
+
 out:
 	if (rc > 0)
 		rc = -ENODEV;
diff --git a/drivers/char/tpm/tpm2-sessions.c b/drivers/char/tpm/tpm2-sessions.c
new file mode 100644
index 000000000000..7d4620e73aae
--- /dev/null
+++ b/drivers/char/tpm/tpm2-sessions.c
@@ -0,0 +1,1030 @@
+// SPDX-License-Identifier: GPL-2.0
+
+/*
+ * Copyright (C) 2018 James.Bottomley at HansenPartnership.com
+ *
+ * Cryptographic helper routines for handling TPM2 sessions for
+ * authorization HMAC and request response encryption.
+ *
+ * The idea is to ensure that every TPM command is HMAC protected by a
+ * session, meaning in-flight tampering would be detected and in
+ * addition all sensitive inputs and responses should be encrypted.
+ *
+ * The basic way this works is to use a TPM feature called salted
+ * sessions where a random secret used in session construction is
+ * encrypted to the public part of a known TPM key.  The problem is we
+ * have no known keys, so initially a primary Elliptic Curve key is
+ * derived from the NULL seed (we use EC because most TPMs generate
+ * these keys much faster than RSA ones).  The curve used is NIST_P256
+ * because that's now mandated to be present in 'TCG TPM v2.0
+ * Provisioning Guidance'
+ *
+ * Threat problems: the initial TPM2_CreatePrimary is not (and cannot
+ * be) session protected, so a clever Man in the Middle could return a
+ * public key they control to this command and from there intercept
+ * and decode all subsequent session based transactions.  The kernel
+ * cannot mitigate this threat but, after boot, userspace can get
+ * proof this has not happened by asking the TPM to certify the NULL
+ * key.  This certification would chain back to the TPM Endorsement
+ * Certificate and prove the NULL seed primary had not been tampered
+ * with and thus all sessions must have been cryptographically secure.
+ * To assist with this, the initial NULL seed public key is made
+ * available in a sysfs file.
+ *
+ * Use of these functions:
+ *
+ * The design is all the crypto, hash and hmac gunk is confined in this
+ * file and never needs to be seen even by the kernel internal user.  To
+ * the user there's an init function tpm2_sessions_init() that needs to
+ * be called once per TPM which generates the NULL seed primary key.
+ *
+ * Then there are five usage functions:
+ *
+ * tpm2_start_auth_session() which allocates the opaque auth structure
+ *	and gets a session from the TPM.  This must be called before
+ *	any of the following functions.  The session is protected by a
+ *	session_key which is derived from a random salt value
+ *	encrypted to the NULL seed.
+ * tpm_buf_append_name() to add a handle to the buffer.  This must be
+ *	used in place of the usual tpm_buf_append_u32() for adding
+ *	handles because handles have to be processed specially when
+ *	calculating the HMAC.  In particular, for NV, volatile and
+ *	permanent objects you now need to provide the name.
+ * tpm_buf_append_hmac_session() which appends the hmac session to the
+ *	buf in the same way tpm_buf_append_auth does().
+ * tpm_buf_fill_hmac_session() This calculates the correct hash and
+ *	places it in the buffer.  It must be called after the complete
+ *	command buffer is finalized so it can fill in the correct HMAC
+ *	based on the parameters.
+ * tpm_buf_check_hmac_response() which checks the session response in
+ *	the buffer and calculates what it should be.  If there's a
+ *	mismatch it will log a warning and return an error.  If
+ *	tpm_buf_append_hmac_session() did not specify
+ *	TPM_SA_CONTINUE_SESSION then the session will be closed (if it
+ *	hasn't been consumed) and the auth structure freed.
+ */
+
+#include "tpm.h"
+#include "tpm2-sessions.h"
+
+#include <linux/random.h>
+#include <linux/scatterlist.h>
+
+#include <crypto/aes.h>
+#include <crypto/kpp.h>
+#include <crypto/ecdh.h>
+#include <crypto/hash.h>
+#include <crypto/hmac.h>
+#include <crypto/skcipher.h>
+
+/* if you change to AES256, you only need change this */
+#define AES_KEYBYTES	AES_KEYSIZE_128
+
+#define AES_KEYBITS	(AES_KEYBYTES*8)
+#define AUTH_MAX_NAMES	3
+
+/*
+ * This is the structure that carries all the auth information (like
+ * session handle, nonces, session key and auth) from use to use it is
+ * designed to be opaque to anything outside.
+ */
+struct tpm2_auth {
+	u32 handle;
+	/*
+	 * the size here is variable and set by the size of our_nonce
+	 * which must be between 16 and the name hash length. we set
+	 * the maximum sha256 size for the greatest protection
+	 */
+	u8 our_nonce[SHA256_DIGEST_SIZE];
+	u8 tpm_nonce[SHA256_DIGEST_SIZE];
+	/*
+	 * the salt is only used across the session command/response
+	 * after that it can be used as a scratch area
+	 */
+	union {
+		u8 salt[EC_PT_SZ];
+		/* scratch for key + IV */
+		u8 scratch[AES_KEYBYTES + AES_BLOCK_SIZE];
+	};
+	/*
+	 * the session key and passphrase are the same size as the
+	 * name digest (sha256 again).  The session key is constant
+	 * for the use of the session and the passphrase can change
+	 * with every invocation.
+	 *
+	 * Note: these fields must be adjacent and in this order
+	 * because several HMAC/KDF schemes use the combination of the
+	 * session_key and passphrase.
+	 */
+	u8 session_key[SHA256_DIGEST_SIZE];
+	u8 passphrase[SHA256_DIGEST_SIZE];
+	int passphraselen;
+	/* saved session attributes */
+	u8 attrs;
+	__be32 ordinal;
+	struct crypto_skcipher *aes;
+	struct tpm_chip *chip;
+	/* 3 names of handles: name_h is handle, name is name of handle */
+	u32 name_h[AUTH_MAX_NAMES];
+	u8 name[AUTH_MAX_NAMES][2 + SHA256_DIGEST_SIZE];
+};
+
+/*
+ * this is our static crypto shash.  This is possible because the hash
+ * is multi-threaded and all the state stored in the desc
+ */
+static struct crypto_shash *sha256_hash;
+
+/*
+ * It turns out the crypto hmac(sha256) is hard for us to consume
+ * because it assumes a fixed key and the TPM seems to change the key
+ * on every operation, so we weld the hmac init and final functions in
+ * here to give it the same usage characteristics as a regular hash
+ */
+static void hmac_init(struct shash_desc *desc, u8 *key, int keylen)
+{
+	u8 pad[SHA256_BLOCK_SIZE];
+	int i;
+
+	desc->tfm = sha256_hash;
+	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+	crypto_shash_init(desc);
+	for (i = 0; i < sizeof(pad); i++) {
+		if (i < keylen)
+			pad[i] = key[i];
+		else
+			pad[i] = 0;
+		pad[i] ^= HMAC_IPAD_VALUE;
+	}
+	crypto_shash_update(desc, pad, sizeof(pad));
+}
+
+static void hmac_final(struct shash_desc *desc, u8 *key, int keylen, u8 *out)
+{
+	u8 pad[SHA256_BLOCK_SIZE];
+	int i;
+
+	for (i = 0; i < sizeof(pad); i++) {
+		if (i < keylen)
+			pad[i] = key[i];
+		else
+			pad[i] = 0;
+		pad[i] ^= HMAC_OPAD_VALUE;
+	}
+
+	/* collect the final hash;  use out as temporary storage */
+	crypto_shash_final(desc, out);
+
+	/* reuse the desc */
+	crypto_shash_init(desc);
+	crypto_shash_update(desc, pad, sizeof(pad));
+	crypto_shash_update(desc, out, SHA256_DIGEST_SIZE);
+	crypto_shash_final(desc, out);
+}
+
+/*
+ * assume hash sha256 and nonces u, v of size SHA256_DIGEST_SIZE but
+ * otherwise standard KDFa.  Note output is in bytes not bits.
+ */
+static void KDFa(u8 *key, int keylen, const char *label, u8 *u,
+		 u8 *v, int bytes, u8 *out)
+{
+	u32 counter;
+	const __be32 bits = cpu_to_be32(bytes * 8);
+
+	for (counter = 1; bytes > 0; bytes -= SHA256_DIGEST_SIZE, counter++,
+		     out += SHA256_DIGEST_SIZE) {
+		SHASH_DESC_ON_STACK(desc, sha256_hash);
+		__be32 c = cpu_to_be32(counter);
+
+		hmac_init(desc, key, keylen);
+		crypto_shash_update(desc, (u8 *)&c, sizeof(c));
+		crypto_shash_update(desc, label, strlen(label)+1);
+		crypto_shash_update(desc, u, SHA256_DIGEST_SIZE);
+		crypto_shash_update(desc, v, SHA256_DIGEST_SIZE);
+		crypto_shash_update(desc, (u8 *)&bits, sizeof(bits));
+		hmac_final(desc, key, keylen, out);
+	}
+}
+
+/*
+ * Somewhat of a bastardization of the real KDFe.  We're assuming
+ * we're working with known point sizes for the input parameters and
+ * the hash algorithm is fixed at sha256.  Because we know that the
+ * point size is 32 bytes like the hash size, there's no need to loop
+ * in this KDF.
+ */
+static void KDFe(u8 z[EC_PT_SZ], const char *str, u8 *pt_u, u8 *pt_v,
+		 u8 *keyout)
+{
+	SHASH_DESC_ON_STACK(desc, sha256_hash);
+	/*
+	 * this should be an iterative counter, but because we know
+	 *  we're only taking 32 bytes for the point using a sha256
+	 *  hash which is also 32 bytes, there's only one loop
+	 */
+	__be32 c = cpu_to_be32(1);
+
+	desc->tfm = sha256_hash;
+	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	crypto_shash_init(desc);
+	/* counter (BE) */
+	crypto_shash_update(desc, (u8 *)&c, sizeof(c));
+	/* secret value */
+	crypto_shash_update(desc, z, EC_PT_SZ);
+	/* string including trailing zero */
+	crypto_shash_update(desc, str, strlen(str)+1);
+	crypto_shash_update(desc, pt_u, EC_PT_SZ);
+	crypto_shash_update(desc, pt_v, EC_PT_SZ);
+	crypto_shash_final(desc, keyout);
+}
+
+static void tpm_buf_append_salt(struct tpm_buf *buf, struct tpm_chip *chip,
+				struct tpm2_auth *auth)
+{
+	struct crypto_kpp *kpp;
+	struct kpp_request *req;
+	struct scatterlist s[2], d[1];
+	struct ecdh p = {0};
+	u8 encoded_key[EC_PT_SZ], *x, *y;
+	unsigned int buf_len;
+	u8 *secret;
+
+	secret = kmalloc(EC_PT_SZ, GFP_KERNEL);
+	if (!secret)
+		return;
+
+	p.curve_id = ECC_CURVE_NIST_P256;
+
+	/* secret is two sized points */
+	tpm_buf_append_u16(buf, (EC_PT_SZ + 2)*2);
+	/*
+	 * we cheat here and append uninitialized data to form
+	 * the points.  All we care about is getting the two
+	 * co-ordinate pointers, which will be used to overwrite
+	 * the uninitialized data
+	 */
+	tpm_buf_append_u16(buf, EC_PT_SZ);
+	x = &buf->data[tpm_buf_length(buf)];
+	tpm_buf_append(buf, encoded_key, EC_PT_SZ);
+	tpm_buf_append_u16(buf, EC_PT_SZ);
+	y = &buf->data[tpm_buf_length(buf)];
+	tpm_buf_append(buf, encoded_key, EC_PT_SZ);
+	sg_init_table(s, 2);
+	sg_set_buf(&s[0], x, EC_PT_SZ);
+	sg_set_buf(&s[1], y, EC_PT_SZ);
+
+	kpp = crypto_alloc_kpp("ecdh", CRYPTO_ALG_INTERNAL, 0);
+	if (IS_ERR(kpp)) {
+		dev_err(&chip->dev, "crypto ecdh allocation failed\n");
+		return;
+	}
+
+	buf_len = crypto_ecdh_key_len(&p);
+	if (sizeof(encoded_key) < buf_len) {
+		dev_err(&chip->dev, "salt buffer too small needs %d\n",
+			buf_len);
+		goto out;
+	}
+	crypto_ecdh_encode_key(encoded_key, buf_len, &p);
+	/* this generates a random private key */
+	crypto_kpp_set_secret(kpp, encoded_key, buf_len);
+
+	/* salt is now the public point of this private key */
+	req = kpp_request_alloc(kpp, GFP_KERNEL);
+	if (!req)
+		goto out;
+	kpp_request_set_input(req, NULL, 0);
+	kpp_request_set_output(req, s, EC_PT_SZ*2);
+	crypto_kpp_generate_public_key(req);
+	/*
+	 * we're not done: now we have to compute the shared secret
+	 * which is our private key multiplied by the tpm_key public
+	 * point, we actually only take the x point and discard the y
+	 * point and feed it through KDFe to get the final secret salt
+	 */
+	sg_set_buf(&s[0], chip->ec_point_x, EC_PT_SZ);
+	sg_set_buf(&s[1], chip->ec_point_y, EC_PT_SZ);
+	kpp_request_set_input(req, s, EC_PT_SZ*2);
+	sg_init_one(d, secret, EC_PT_SZ);
+	kpp_request_set_output(req, d, EC_PT_SZ);
+	crypto_kpp_compute_shared_secret(req);
+	kpp_request_free(req);
+
+	/* pass the shared secret through KDFe for salt */
+	KDFe(secret, "SECRET", x, chip->ec_point_x, auth->salt);
+ out:
+	crypto_free_kpp(kpp);
+}
+
+/**
+ * tpm_buf_append_hmac_session() append a TPM session element
+ * @buf: The buffer to be appended
+ * @auth: the auth structure allocated by tpm2_start_auth_session()
+ * @attributes: The session attributes
+ * @passphrase: The session authority (NULL if none)
+ * @passphraselen: The length of the session authority (0 if none)
+ *
+ * This fills in a session structure in the TPM command buffer, except
+ * for the HMAC which cannot be computed until the command buffer is
+ * complete.  The type of session is controlled by the @attributes,
+ * the main ones of which are TPM2_SA_CONTINUE_SESSION which means the
+ * session won't terminate after tpm_buf_check_hmac_response(),
+ * TPM2_SA_DECRYPT which means this buffers first parameter should be
+ * encrypted with a session key and TPM2_SA_ENCRYPT, which means the
+ * response buffer's first parameter needs to be decrypted (confusing,
+ * but the defines are written from the point of view of the TPM).
+ *
+ * Any session appended by this command must be finalized by calling
+ * tpm_buf_fill_hmac_session() otherwise the HMAC will be incorrect
+ * and the TPM will reject the command.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_append_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth,
+				 u8 attributes, u8 *passphrase,
+				 int passphraselen)
+{
+	u8 nonce[SHA256_DIGEST_SIZE];
+
+	auth->attrs = attributes;
+	auth->passphraselen = passphraselen;
+	if (passphraselen)
+		memcpy(auth->passphrase, passphrase, passphraselen);
+
+	/* random number for our nonce */
+	get_random_bytes(nonce, sizeof(nonce));
+	memcpy(auth->our_nonce, nonce, sizeof(nonce));
+	tpm_buf_append_u32(buf, 9 + 2 * SHA256_DIGEST_SIZE);
+	tpm_buf_append_u32(buf, auth->handle);
+	/* our new nonce */
+	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
+	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
+	tpm_buf_append_u8(buf, auth->attrs);
+	/* and put a placeholder for the hmac */
+	tpm_buf_append_u16(buf, SHA256_DIGEST_SIZE);
+	tpm_buf_append(buf, nonce, SHA256_DIGEST_SIZE);
+}
+EXPORT_SYMBOL(tpm_buf_append_hmac_session);
+
+/**
+ * tpm_buf_fill_hmac_session() - finalize the session HMAC
+ * @buf: The buffer to be appended
+ * @auth: the auth structure allocated by tpm2_start_auth_session()
+ *
+ * This command must not be called until all of the parameters have
+ * been appended to @buf otherwise the computed HMAC will be
+ * incorrect.
+ *
+ * This function computes and fills in the session HMAC using the
+ * session key and, if TPM2_SA_DECRYPT was specified, computes the
+ * encryption key and encrypts the first parameter of the command
+ * buffer with it.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_fill_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth)
+{
+	u32 cc, handles, val;
+	struct tpm_chip *chip = auth->chip;
+	int i;
+	struct tpm_input_header *head = (struct tpm_input_header *)buf->data;
+	const u8 *s, *p;
+	u8 *hmac = NULL;
+	u32 attrs;
+	u8 cphash[SHA256_DIGEST_SIZE];
+	SHASH_DESC_ON_STACK(desc, sha256_hash);
+
+	/* save the command code in BE format */
+	auth->ordinal = head->ordinal;
+
+	desc->tfm = sha256_hash;
+	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+
+	cc = be32_to_cpu(head->ordinal);
+
+	i = tpm2_find_cc(chip, cc);
+	if (i < 0) {
+		dev_err(&chip->dev, "Command 0x%x not found in TPM\n", cc);
+		return;
+	}
+	attrs = chip->cc_attrs_tbl[i];
+
+	handles = (attrs >> TPM2_CC_ATTR_CHANDLES) & GENMASK(2, 0);
+
+	s = &buf->data[TPM_HEADER_SIZE];
+	/*
+	 * just check the names, it's easy to make mistakes.  This
+	 * would happen if someone added a handle via
+	 * tpm_buf_append_u32() instead of tpm_buf_append_name()
+	 */
+	for (i = 0; i < handles; i++) {
+		u32 handle = tpm_get_inc_u32(&s);
+
+		if (auth->name_h[i] != handle) {
+			dev_err(&chip->dev, "TPM: handle %d wrong for name\n",
+				  i);
+			return;
+		}
+	}
+	/* point s to the start of the sessions */
+	val = tpm_get_inc_u32(&s);
+	/* point p to the start of the parameters */
+	p = s + val;
+	while (s < p) {
+		u32 handle = tpm_get_inc_u32(&s);
+		u16 len;
+		u8 a;
+
+		/* nonce (already in auth) */
+		len = tpm_get_inc_u16(&s);
+		s += len;
+
+		a = *s++;
+
+		len = tpm_get_inc_u16(&s);
+		if (handle == auth->handle && auth->attrs == a)
+			hmac = (u8 *)s;
+
+		s += len;
+	}
+	if (s != p) {
+		dev_err(&chip->dev, "TPM session length is incorrect\n");
+		return;
+	}
+	if (!hmac) {
+		dev_err(&chip->dev, "TPM could not find HMAC session\n");
+		return;
+	}
+
+	/* encrypt before HMAC */
+	if (auth->attrs & TPM2_SA_DECRYPT) {
+		struct scatterlist sg[1];
+		u16 len;
+		SKCIPHER_REQUEST_ON_STACK(req, auth->aes);
+
+		skcipher_request_set_tfm(req, auth->aes);
+		skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
+					      NULL, NULL);
+
+		/* need key and IV */
+		KDFa(auth->session_key, SHA256_DIGEST_SIZE
+		     + auth->passphraselen, "CFB", auth->our_nonce,
+		     auth->tpm_nonce, AES_KEYBYTES + AES_BLOCK_SIZE,
+		     auth->scratch);
+		crypto_skcipher_setkey(auth->aes, auth->scratch, AES_KEYBYTES);
+		len = tpm_get_inc_u16(&p);
+		sg_init_one(sg, p, len);
+		skcipher_request_set_crypt(req, sg, sg, len,
+					   auth->scratch + AES_KEYBYTES);
+		crypto_skcipher_encrypt(req);
+		/* reset p to beginning of parameters for HMAC */
+		p -= 2;
+	}
+
+	crypto_shash_init(desc);
+	/* ordinal is already BE */
+	crypto_shash_update(desc, (u8 *)&head->ordinal, sizeof(head->ordinal));
+	/* add the handle names */
+	for (i = 0; i < handles; i++) {
+		u8 mso = auth->name_h[i] >> 24;
+
+		if (mso == 0x81 || mso == 0x80 || mso == 0x01) {
+			crypto_shash_update(desc, auth->name[i],
+					    SHA256_DIGEST_SIZE + 2);
+		} else {
+			__be32 h = cpu_to_be32(auth->name_h[i]);
+
+			crypto_shash_update(desc, (u8 *)&h, 4);
+		}
+	}
+	if (buf->data - s != tpm_buf_length(buf))
+		crypto_shash_update(desc, s, buf->data
+				    + tpm_buf_length(buf) - s);
+	crypto_shash_final(desc, cphash);
+
+	/* now calculate the hmac */
+	hmac_init(desc, auth->session_key, sizeof(auth->session_key)
+		  + auth->passphraselen);
+	crypto_shash_update(desc, cphash, sizeof(cphash));
+	crypto_shash_update(desc, auth->our_nonce, sizeof(auth->our_nonce));
+	crypto_shash_update(desc, auth->tpm_nonce, sizeof(auth->tpm_nonce));
+	crypto_shash_update(desc, &auth->attrs, 1);
+	hmac_final(desc, auth->session_key, sizeof(auth->session_key)
+		   + auth->passphraselen, hmac);
+}
+EXPORT_SYMBOL(tpm_buf_fill_hmac_session);
+
+/**
+ * tpm_buf_append_name() - add a handle area to the buffer
+ * @buf: The buffer to be appended
+ * @auth: the auth structure allocated by tpm2_start_auth_session()
+ * @handle: The handle to be appended
+ * @name: The name of the handle (may be NULL)
+ *
+ * In order to compute session HMACs, we need to know the names of the
+ * objects pointed to by the handles.  For most objects, this is simly
+ * the actual 4 byte handle or an empty buf (in these cases @name
+ * should be NULL) but for volatile objects, permanent objects and NV
+ * areas, the name is defined as the hash (according to the name
+ * algorithm which should be set to sha256) of the public area to
+ * which the two byte algorithm id has been appended.  For these
+ * objects, the @name pointer must point to this.
+ *
+ * As with most tpm_buf operations, success is assumed because failure
+ * will be caused by an incorrect programming model and indicated by a
+ * kernel message.
+ */
+void tpm_buf_append_name(struct tpm_buf *buf, struct tpm2_auth *auth,
+			 u32 handle, u8 *name)
+{
+	int slot;
+	u8 mso = handle >> 24;
+
+	slot = (tpm_buf_length(buf) - TPM_HEADER_SIZE)/4;
+	if (slot >= AUTH_MAX_NAMES) {
+		dev_err(&auth->chip->dev, "TPM: too many handles\n");
+		return;
+	}
+	tpm_buf_append_u32(buf, handle);
+	if (mso == 0x81 || mso == 0x80 || mso == 0x01) {
+		if (!name)
+			dev_err(&auth->chip->dev, "TPM: Handle requires name but none specified\n");
+	} else {
+		if (name)
+			dev_err(&auth->chip->dev, "TPM: Handle does not require name but one is specified\n");
+	}
+
+	auth->name_h[slot] = handle;
+	if (name)
+		memcpy(auth->name[slot], name, SHA256_DIGEST_SIZE + 2);
+}
+EXPORT_SYMBOL(tpm_buf_append_name);
+
+/**
+ * tpm_buf_check_hmac_response() - check the TPM return HMAC for correctness
+ * @buf: the original command buffer (which now contains the response)
+ * @auth: the auth structure allocated by tpm2_start_auth_session()
+ * @rc: the return code from tpm_transmit_cmd
+ *
+ * If @rc is non zero, @buf may not contain an actual return, so @rc
+ * is passed through as the return and the session cleaned up and
+ * de-allocated if required (this is required if
+ * TPM2_SA_CONTINUE_SESSION was not specified as a session flag).
+ *
+ * If @rc is zero, the response HMAC is computed against the returned
+ * @buf and matched to the TPM one in the session area.  If there is a
+ * mismatch, an error is logged and -EINVAL returned.
+ *
+ * The reason for this is that the command issue and HMAC check
+ * sequence should look like:
+ *
+ *	rc = tpm_buf_transmit(&buf, ...);
+ *	rc = tpm_buf_check_hmac_response(&buf, auth, rc);
+ *	if (rc)
+ *		...
+ *
+ * Which is easily layered into the current contrl flow.
+ *
+ * Returns: 0 on success or an error.
+ */
+int tpm_buf_check_hmac_response(struct tpm_buf *buf, struct tpm2_auth *auth,
+				int rc)
+{
+	struct tpm_output_header *head = (struct tpm_output_header *)buf->data;
+	struct tpm_chip *chip = auth->chip;
+	const u8 *s, *p;
+	u8 rphash[SHA256_DIGEST_SIZE];
+	u32 attrs;
+	SHASH_DESC_ON_STACK(desc, sha256_hash);
+	u16 tag = be16_to_cpu(head->tag);
+	u32 cc = be32_to_cpu(auth->ordinal);
+	int parm_len, len, i, handles;
+
+	if (rc != 0)
+		/* pass non success rc through and close the session */
+		goto out;
+
+	rc = -EINVAL;
+	if (tag != TPM2_ST_SESSIONS) {
+		dev_err(&chip->dev, "TPM: HMAC response check has no sessions tag\n");
+		goto out;
+	}
+
+	i = tpm2_find_cc(chip, cc);
+	if (i < 0)
+		goto out;
+	attrs = chip->cc_attrs_tbl[i];
+	handles = (attrs >> TPM2_CC_ATTR_RHANDLE) & 1;
+
+	/* point to area beyond handles */
+	s = &buf->data[TPM_HEADER_SIZE + handles * 4];
+	parm_len = tpm_get_inc_u32(&s);
+	p = s;
+	s += parm_len;
+	/* TPM nonce */
+	len = tpm_get_inc_u16(&s);
+	if (s - buf->data + len > tpm_buf_length(buf))
+		goto out;
+	if (len != SHA256_DIGEST_SIZE)
+		goto out;
+	memcpy(auth->tpm_nonce, s, len);
+	s += len;
+	attrs = *s++;
+	len = tpm_get_inc_u16(&s);
+	if (s - buf->data + len != tpm_buf_length(buf))
+		goto out;
+	if (len != SHA256_DIGEST_SIZE)
+		goto out;
+	/*
+	 * s points to the HMAC. now calculate comparison, beginning
+	 * with rphash
+	 */
+	desc->tfm = sha256_hash;
+	desc->flags = CRYPTO_TFM_REQ_MAY_SLEEP;
+	crypto_shash_init(desc);
+	/* yes, I know this is now zero, but it's what the standard says */
+	crypto_shash_update(desc, (u8 *)&head->return_code,
+			    sizeof(head->return_code));
+	/* ordinal is already BE */
+	crypto_shash_update(desc, (u8 *)&auth->ordinal, sizeof(auth->ordinal));
+	crypto_shash_update(desc, p, parm_len);
+	crypto_shash_final(desc, rphash);
+
+	/* now calculate the hmac */
+	hmac_init(desc, auth->session_key, sizeof(auth->session_key)
+		  + auth->passphraselen);
+	crypto_shash_update(desc, rphash, sizeof(rphash));
+	crypto_shash_update(desc, auth->tpm_nonce, sizeof(auth->tpm_nonce));
+	crypto_shash_update(desc, auth->our_nonce, sizeof(auth->our_nonce));
+	crypto_shash_update(desc, &auth->attrs, 1);
+	/* we're done with the rphash, so put our idea of the hmac there */
+	hmac_final(desc, auth->session_key, sizeof(auth->session_key)
+		   + auth->passphraselen, rphash);
+	if (memcmp(rphash, s, SHA256_DIGEST_SIZE) == 0) {
+		rc = 0;
+	} else {
+		dev_err(&auth->chip->dev, "TPM: HMAC check failed\n");
+		goto out;
+	}
+
+	/* now do response decryption */
+	if (auth->attrs & TPM2_SA_ENCRYPT) {
+		struct scatterlist sg[1];
+		SKCIPHER_REQUEST_ON_STACK(req, auth->aes);
+
+		skcipher_request_set_tfm(req, auth->aes);
+		skcipher_request_set_callback(req, CRYPTO_TFM_REQ_MAY_SLEEP,
+					      NULL, NULL);
+
+		/* need key and IV */
+		KDFa(auth->session_key, SHA256_DIGEST_SIZE
+		     + auth->passphraselen, "CFB", auth->tpm_nonce,
+		     auth->our_nonce, AES_KEYBYTES + AES_BLOCK_SIZE,
+		     auth->scratch);
+		crypto_skcipher_setkey(auth->aes, auth->scratch, AES_KEYBYTES);
+		len = tpm_get_inc_u16(&p);
+		sg_init_one(sg, p, len);
+		skcipher_request_set_crypt(req, sg, sg, len,
+					   auth->scratch + AES_KEYBYTES);
+		crypto_skcipher_decrypt(req);
+	}
+
+ out:
+	if ((auth->attrs & TPM2_SA_CONTINUE_SESSION) == 0) {
+		/* manually close the session if it wasn't consumed */
+		if (rc)
+			tpm2_flush_context_cmd(chip, auth->handle, 0);
+		crypto_free_skcipher(auth->aes);
+		kfree(auth);
+	}
+	return rc;
+}
+EXPORT_SYMBOL(tpm_buf_check_hmac_response);
+
+static int parse_start_auth_session(struct tpm2_auth *auth, const u8 *data)
+{
+	struct tpm_output_header *head = (struct tpm_output_header *)data;
+	u32 tot_len = be32_to_cpu(head->length);
+	u32 val;
+
+	data += TPM_HEADER_SIZE;
+	/* we're starting after the header so adjust the length */
+	tot_len -= TPM_HEADER_SIZE;
+
+	/* should have handle plus nonce */
+	if (tot_len != 4 + 2 + sizeof(auth->tpm_nonce))
+		return -EINVAL;
+
+	auth->handle = tpm_get_inc_u32(&data);
+	val = tpm_get_inc_u16(&data);
+	if (val != sizeof(auth->tpm_nonce))
+		return -EINVAL;
+	memcpy(auth->tpm_nonce, data, sizeof(auth->tpm_nonce));
+	/* now compute the session key from the nonces */
+	KDFa(auth->salt, sizeof(auth->salt), "ATH", auth->tpm_nonce,
+	     auth->our_nonce, sizeof(auth->session_key), auth->session_key);
+
+	return 0;
+}
+
+/**
+ * tpm2_start_auth_session - create a HMAC authentication session with the TPM
+ * @chip: the TPM chip structure to create the session with
+ * @authp: A pointer to an opaque tpm2_auth structure to be allocated
+ *
+ * This function contacts the TPM via the kernel space for an
+ * authentication session, allocates a tpm2_auth structure to contain
+ * all the session details necessary for performing the HMAC, encrypt
+ * and decrypt operations, fills it in and returns.
+ *
+ * Return: zero on success or actual error encountered.  If return is
+ * zero, @authp will be allocated.
+ */
+int tpm2_start_auth_session(struct tpm_chip *chip, struct tpm2_auth **authp)
+{
+	struct tpm_buf buf;
+	struct tpm2_auth *auth;
+	int rc;
+
+	auth = kmalloc(sizeof(**authp), GFP_KERNEL);
+	if (!auth)
+		return -ENOMEM;
+
+	auth->chip = chip;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_NO_SESSIONS, TPM2_CC_START_AUTH_SESS);
+	if (rc)
+		goto out;
+
+	/* salt key handle */
+	tpm_buf_append_u32(&buf, chip->tpmkey);
+	/* bind key handle */
+	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+	/* nonce caller */
+	get_random_bytes(auth->our_nonce, sizeof(auth->our_nonce));
+	tpm_buf_append_u16(&buf, sizeof(auth->our_nonce));
+	tpm_buf_append(&buf, auth->our_nonce, sizeof(auth->our_nonce));
+
+	/* append encrypted salt and squirrel away unencrypted in auth */
+	tpm_buf_append_salt(&buf, chip, auth);
+	/* session type (HMAC, audit or policy) */
+	tpm_buf_append_u8(&buf, TPM2_SE_HMAC);
+
+	/* symmetric encryption parameters */
+	/* symmetric algorithm */
+	tpm_buf_append_u16(&buf, TPM2_ALG_AES);
+	/* bits for symmetric algorithm */
+	tpm_buf_append_u16(&buf, AES_KEYBITS);
+	/* symmetric algorithm mode (must be CFB) */
+	tpm_buf_append_u16(&buf, TPM2_ALG_CFB);
+	/* hash algorithm for session */
+	tpm_buf_append_u16(&buf, TPM2_ALG_SHA256);
+
+	rc = tpm_transmit_cmd(chip, &chip->kernel_space, buf.data, PAGE_SIZE,
+			      0, 0, "start auth session");
+	if (rc == TPM2_RC_SUCCESS)
+		rc = parse_start_auth_session(auth, buf.data);
+
+	tpm_buf_destroy(&buf);
+
+	if (rc)
+		goto out;
+
+	auth->aes = crypto_alloc_skcipher("cfb(aes)", 0, 0);
+	if (IS_ERR(auth->aes)) {
+		rc = PTR_ERR(auth->aes);
+		dev_err(&chip->dev, "TPM: error getting cfb(aes): %d\n", rc);
+	}
+ out:
+	if (rc)
+		kfree(auth);
+	else
+		*authp = auth;
+
+	return rc;
+}
+EXPORT_SYMBOL(tpm2_start_auth_session);
+
+static int parse_create_primary(struct tpm_chip *chip, u8 *data)
+{
+	struct tpm_output_header *head = (struct tpm_output_header *)data;
+	u16 len;
+	u32 tot_len = be32_to_cpu(head->length);
+	u32 handle, val, parm_len;
+	const u8 *resp, *tmp;
+
+	data += TPM_HEADER_SIZE;
+	/* we're starting after the header so adjust the length */
+	tot_len -= TPM_HEADER_SIZE;
+
+	resp = data;
+	handle = tpm_get_inc_u32(&resp);
+	parm_len = tpm_get_inc_u32(&resp);
+	if (parm_len + 8 > tot_len)
+		return -EINVAL;
+	len = tpm_get_inc_u16(&resp);
+	tmp = resp;
+	/* validate the public key */
+	val = tpm_get_inc_u16(&tmp);
+	/* key type (must be what we asked for) */
+	if (val != TPM2_ALG_ECC)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* name algorithm */
+	if (val != TPM2_ALG_SHA256)
+		return -EINVAL;
+	val = tpm_get_inc_u32(&tmp);
+	/* object properties */
+	if (val != (TPM2_OA_NO_DA |
+		    TPM2_OA_SENSITIVE_DATA_ORIGIN |
+		    TPM2_OA_USER_WITH_AUTH |
+		    TPM2_OA_DECRYPT |
+		    TPM2_OA_RESTRICTED))
+		return -EINVAL;
+	/* auth policy (empty) */
+	val = tpm_get_inc_u16(&tmp);
+	if (val != 0)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* symmetric key parameters */
+	if (val != TPM2_ALG_AES)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* symmetric key length */
+	if (val != AES_KEYBITS)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* symmetric encryption scheme */
+	if (val != TPM2_ALG_CFB)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* signing scheme */
+	if (val != TPM2_ALG_NULL)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* ECC Curve */
+	if (val != TPM2_ECC_NIST_P256)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* KDF Scheme */
+	if (val != TPM2_ALG_NULL)
+		return -EINVAL;
+	val = tpm_get_inc_u16(&tmp);
+	/* x point */
+	if (val != 32)
+		return -EINVAL;
+	memcpy(chip->ec_point_x, tmp, val);
+	tmp += val;
+	val = tpm_get_inc_u16(&tmp);
+	if (val != 32)
+		return -EINVAL;
+	memcpy(chip->ec_point_y, tmp, val);
+	tmp += val;
+	resp += len;
+	/* should have exactly consumed the tpm2b public structure */
+	if (tmp != resp)
+		return -EINVAL;
+	if (resp - data > parm_len)
+		return -EINVAL;
+	/* creation data (skip) */
+	len = tpm_get_inc_u16(&resp);
+	resp += len;
+	if (resp - data > parm_len)
+		return -EINVAL;
+	/* creation digest (must be sha256) */
+	len = tpm_get_inc_u16(&resp);
+	resp += len;
+	if (len != SHA256_DIGEST_SIZE || resp - data > parm_len)
+		return -EINVAL;
+	/* TPMT_TK_CREATION follows */
+	/* tag, must be TPM_ST_CREATION (0x8021) */
+	val = tpm_get_inc_u16(&resp);
+	if (val != TPM2_ST_CREATION || resp - data > parm_len)
+		return -EINVAL;
+	/* hierarchy (must be NULL) */
+	val = tpm_get_inc_u32(&resp);
+	if (val != TPM2_RH_NULL || resp - data > parm_len)
+		return -EINVAL;
+	/* the ticket digest HMAC (might not be sha256) */
+	len = tpm_get_inc_u16(&resp);
+	resp += len;
+	if (resp - data > parm_len)
+		return -EINVAL;
+	/*
+	 * finally we have the name, which is a sha256 digest plus a 2
+	 * byte algorithm type
+	 */
+	len = tpm_get_inc_u16(&resp);
+	if (resp + len - data != parm_len + 8)
+		return -EINVAL;
+	if (len != SHA256_DIGEST_SIZE + 2)
+		return -EINVAL;
+
+	memcpy(chip->tpmkeyname, resp, SHA256_DIGEST_SIZE + 2);
+
+	chip->tpmkey = handle;
+
+	return 0;
+}
+
+int tpm2_create_null_primary(struct tpm_chip *chip)
+{
+	int rc;
+	struct tpm_buf buf;
+	struct tpm_buf template;
+
+	rc = tpm_buf_init(&buf, TPM2_ST_SESSIONS, TPM2_CC_CREATE_PRIMARY);
+	if (rc)
+		return rc;
+
+	rc = tpm_buf_init_2b(&template);
+	if (rc) {
+		tpm_buf_destroy(&buf);
+		return rc;
+	}
+
+	/* create the template */
+
+	/* key type */
+	tpm_buf_append_u16(&template, TPM2_ALG_ECC);
+	/* name algorithm */
+	tpm_buf_append_u16(&template, TPM2_ALG_SHA256);
+	/* object properties */
+	tpm_buf_append_u32(&template, TPM2_OA_NO_DA |
+			 TPM2_OA_SENSITIVE_DATA_ORIGIN |
+			 TPM2_OA_USER_WITH_AUTH |
+			 TPM2_OA_DECRYPT |
+			 TPM2_OA_RESTRICTED);
+	/* sauth policy (empty) */
+	tpm_buf_append_u16(&template, 0);
+
+	/* BEGIN parameters: key specific; for ECC*/
+	/* symmetric algorithm */
+	tpm_buf_append_u16(&template, TPM2_ALG_AES);
+	/* bits for symmetric algorithm */
+	tpm_buf_append_u16(&template, 128);
+	/* algorithm mode (must be CFB) */
+	tpm_buf_append_u16(&template, TPM2_ALG_CFB);
+	/* scheme (NULL means any scheme) */
+	tpm_buf_append_u16(&template, TPM2_ALG_NULL);
+	/* ECC Curve ID */
+	tpm_buf_append_u16(&template, TPM2_ECC_NIST_P256);
+	/* KDF Scheme */
+	tpm_buf_append_u16(&template, TPM2_ALG_NULL);
+	/* unique: key specific; for ECC it is two points */
+	tpm_buf_append_u16(&template, 0);
+	tpm_buf_append_u16(&template, 0);
+	/* END parameters */
+
+	/* primary handle */
+	tpm_buf_append_u32(&buf, TPM2_RH_NULL);
+	/* simple authorization for empty auth */
+	tpm2_buf_append_auth(&buf, TPM2_RS_PW, NULL, 0, 0, NULL, 0);
+	/* sensitive create size is 4 for two empty buffers */
+	tpm_buf_append_u16(&buf, 4);
+	/* sensitive create auth data (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* sensitive create sensitive data (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* the public template */
+	tpm_buf_append_2b(&buf, &template);
+	tpm_buf_destroy(&template);
+	/* outside info (empty) */
+	tpm_buf_append_u16(&buf, 0);
+	/* creation PCR (none) */
+	tpm_buf_append_u32(&buf, 0);
+
+	rc = tpm_transmit_cmd(chip, &chip->kernel_space, buf.data, PAGE_SIZE,
+			      0, 0, "attempting to create NULL primary");
+
+	if (rc == TPM2_RC_SUCCESS)
+		rc = parse_create_primary(chip, buf.data);
+
+	tpm_buf_destroy(&buf);
+
+	return rc;
+}
+
+int tpm2_sessions_init(struct tpm_chip *chip)
+{
+	int rc;
+
+	tpm2_init_space(&chip->kernel_space);
+	sha256_hash = crypto_alloc_shash("sha256", 0, 0);
+	if (!sha256_hash) {
+		dev_err(&chip->dev, "TPM: failed to allocate hash\n");
+		return -ENOMEM;
+	}
+
+	rc = tpm2_create_null_primary(chip);
+	if (rc)
+		dev_err(&chip->dev, "TPM: security failed (NULL seed derivation): %d\n", rc);
+	return rc;
+}
+EXPORT_SYMBOL(tpm2_sessions_init);
diff --git a/drivers/char/tpm/tpm2-sessions.h b/drivers/char/tpm/tpm2-sessions.h
new file mode 100644
index 000000000000..24870b7a8e3e
--- /dev/null
+++ b/drivers/char/tpm/tpm2-sessions.h
@@ -0,0 +1,56 @@
+/*
+ * Defines for TPM2 authentications
+ */
+
+#ifndef _TPM2_SESSIONS_H
+#define _TPM2_SESSIONS_H
+
+#include "tpm.h"
+
+enum tpm2_object_attributes {
+	TPM2_OA_FIXED_TPM		= BIT(1),
+	TPM2_OA_ST_CLEAR		= BIT(2),
+	TPM2_OA_FIXED_PARENT		= BIT(4),
+	TPM2_OA_SENSITIVE_DATA_ORIGIN	= BIT(5),
+	TPM2_OA_USER_WITH_AUTH		= BIT(6),
+	TPM2_OA_ADMIN_WITH_POLICY	= BIT(7),
+	TPM2_OA_NO_DA			= BIT(10),
+	TPM2_OA_ENCRYPTED_DUPLICATION	= BIT(11),
+	TPM2_OA_RESTRICTED		= BIT(16),
+	TPM2_OA_DECRYPT			= BIT(17),
+	TPM2_OA_SIGN			= BIT(18),
+};
+
+enum tpm2_session_attributes {
+	TPM2_SA_CONTINUE_SESSION	= BIT(0),
+	TPM2_SA_AUDIT_EXCLUSIVE		= BIT(1),
+	TPM2_SA_AUDIT_RESET		= BIT(3),
+	TPM2_SA_DECRYPT			= BIT(5),
+	TPM2_SA_ENCRYPT			= BIT(6),
+	TPM2_SA_AUDIT			= BIT(7),
+};
+
+enum tpm2_session_types {
+	TPM2_SE_HMAC	= 0x00,
+	TPM2_SE_POLICY	= 0x01,
+	TPM2_SE_TRIAL	= 0x02,
+};
+
+struct tpm2_auth;
+
+void tpm2_buf_append_auth(struct tpm_buf *buf, u32 session_handle,
+			  const u8 *nonce, u16 nonce_len,
+			  u8 attributes,
+			  const u8 *hmac, u16 hmac_len);
+
+int tpm2_start_auth_session(struct tpm_chip *chip, struct tpm2_auth **authp);
+void tpm_buf_append_name(struct tpm_buf *buf, struct tpm2_auth *auth,
+			 u32 handle, u8 *name);
+void tpm_buf_append_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth,
+				 u8 attributes, u8 *passphrase,
+				 int passphraselen);
+void tpm_buf_fill_hmac_session(struct tpm_buf *buf, struct tpm2_auth *auth);
+int tpm_buf_check_hmac_response(struct tpm_buf *buf, struct tpm2_auth *auth,
+				int rc);
+
+#endif
-- 
2.12.3

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
