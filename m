From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu, 30 Mar 2017 16:50:26 -0700
Subject: [PATCH v13 09/10] KEYS: Restrict asymmetric key linkage using a
	specific keychain
In-Reply-To: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
References: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
Message-ID: <20170330235027.6879-10-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Adds restrict_link_by_signature_keyring(), which uses the restrict_key
member of the provided destination_keyring data structure as the
key or keyring to search for signing keys.

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/crypto/asymmetric-keys.txt | 11 +++++
 crypto/asymmetric_keys/asymmetric_type.c | 35 +++++++++++++++-
 crypto/asymmetric_keys/restrict.c        | 71 ++++++++++++++++++++++++++++++++
 include/crypto/public_key.h              |  5 +++
 4 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/Documentation/crypto/asymmetric-keys.txt b/Documentation/crypto/asymmetric-keys.txt
index 4373e7d86c6a..9814722f4b6b 100644
--- a/Documentation/crypto/asymmetric-keys.txt
+++ b/Documentation/crypto/asymmetric-keys.txt
@@ -340,6 +340,17 @@ Several restriction methods are available:
      signing key. The ca_keys kernel parameter also affects which keys are used
      for signature verification.
 
+ (3) Restrict using a separate key or keyring
+
+     - Option string used with KEYCTL_RESTRICT_KEYRING:
+       - "key_or_keyring:<key or keyring serial number>"
+
+     Whenever a key link is requested, the link will only succeed if the key
+     being linked is signed by one of the designated keys. This key may be
+     specified directly by providing a serial number for one asymmetric key, or
+     a group of keys may be searched for the signing key by providing the
+     serial number for a keyring.
+
 In all of these cases, if the signing key is found the signature of the key to
 be linked will be verified using the signing key.  The requested key is added
 to the keyring only if the signature is successfully verified.  -ENOKEY is
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 2e3380d09631..72700ed81594 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -475,6 +475,11 @@ static struct key_restriction *asymmetric_restriction_alloc(
 static struct key_restriction *asymmetric_lookup_restriction(
 	const char *restriction)
 {
+	char *restrict_method;
+	char *parse_buf;
+	char *next;
+	struct key_restriction *ret = ERR_PTR(-EINVAL);
+
 	if (strcmp("builtin_trusted", restriction) == 0)
 		return asymmetric_restriction_alloc(
 			restrict_link_by_builtin_trusted, NULL);
@@ -483,7 +488,35 @@ static struct key_restriction *asymmetric_lookup_restriction(
 		return asymmetric_restriction_alloc(
 			restrict_link_by_builtin_and_secondary_trusted, NULL);
 
-	return ERR_PTR(-EINVAL);
+	parse_buf = kstrndup(restriction, PAGE_SIZE, GFP_KERNEL);
+	if (!parse_buf)
+		return ERR_PTR(-ENOMEM);
+
+	next = parse_buf;
+	restrict_method = strsep(&next, ":");
+
+	if ((strcmp(restrict_method, "key_or_keyring") == 0) && next) {
+		key_serial_t serial;
+		struct key *key;
+
+		if (kstrtos32(next, 0, &serial) < 0)
+			goto out;
+
+		key = key_lookup(serial);
+		if (IS_ERR(key)) {
+			ret = ERR_CAST(key);
+			goto out;
+		}
+
+		ret = asymmetric_restriction_alloc(
+			restrict_link_by_key_or_keyring, key);
+		if (IS_ERR(ret))
+			key_put(key);
+	}
+
+out:
+	kfree(parse_buf);
+	return ret;
 }
 
 struct key_type key_type_asymmetric = {
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index a3afbf783255..183cb642580e 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -108,3 +108,74 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	key_put(key);
 	return ret;
 }
+
+/**
+ * restrict_link_by_key_or_keyring - Restrict additions to a ring of public
+ * keys using the restrict_key information stored in the ring.
+ * @dest_keyring: Keyring being linked to.
+ * @type: The type of key being added.
+ * @payload: The payload of the new key.
+ * @trusted: A key or ring of keys that can be used to vouch for the new cert.
+ *
+ * Check the new certificate only against the key or keys passed in the data
+ * parameter. If one of those is the signing key and validates the new
+ * certificate, then mark the new certificate as being ok to link.
+ *
+ * Returns 0 if the new certificate was accepted, -ENOKEY if we
+ * couldn't find a matching parent certificate in the trusted list,
+ * -EKEYREJECTED if the signature check fails, and some other error if
+ * there is a matching certificate but the signature check cannot be
+ * performed.
+ */
+int restrict_link_by_key_or_keyring(struct key *dest_keyring,
+				    const struct key_type *type,
+				    const union key_payload *payload,
+				    struct key *trusted)
+{
+	const struct public_key_signature *sig;
+	struct key *key;
+	int ret;
+
+	pr_devel("==>%s()\n", __func__);
+
+	if (!dest_keyring)
+		return -ENOKEY;
+	else if (dest_keyring->type != &key_type_keyring)
+		return -EOPNOTSUPP;
+
+	if (!trusted)
+		return -ENOKEY;
+
+	if (type != &key_type_asymmetric)
+		return -EOPNOTSUPP;
+
+	sig = payload->data[asym_auth];
+	if (!sig->auth_ids[0] && !sig->auth_ids[1])
+		return -ENOKEY;
+
+	if (trusted->type == &key_type_keyring) {
+		/* See if we have a key that signed this one. */
+		key = find_asymmetric_key(trusted, sig->auth_ids[0],
+					  sig->auth_ids[1], false);
+		if (IS_ERR(key))
+			return -ENOKEY;
+	} else if (trusted->type == &key_type_asymmetric) {
+		const struct asymmetric_key_ids *kids;
+
+		kids = asymmetric_key_ids(trusted);
+
+		if (!asymmetric_key_id_same(kids->id[1], sig->auth_ids[0]))
+			return -ENOKEY;
+
+		key = __key_get(trusted);
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	ret = key_validate(key);
+	if (ret == 0)
+		ret = verify_signature(key, sig);
+
+	key_put(key);
+	return ret;
+}
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index ec0262fa08f8..bb6a884352a5 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -55,6 +55,11 @@ extern int restrict_link_by_signature(struct key *dest_keyring,
 				      const union key_payload *payload,
 				      struct key *trust_keyring);
 
+extern int restrict_link_by_key_or_keyring(struct key *dest_keyring,
+					   const struct key_type *type,
+					   const union key_payload *payload,
+					   struct key *trusted);
+
 extern int verify_signature(const struct key *key,
 			    const struct public_key_signature *sig);
 
-- 
2.12.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
