From: mathew.j.martineau@linux.intel.com (Mat Martineau)
Date: Thu, 30 Mar 2017 16:50:27 -0700
Subject: [PATCH v13 10/10] KEYS: Keyring asymmetric key restrict method with
	chaining
In-Reply-To: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
References: <20170330235027.6879-1-mathew.j.martineau@linux.intel.com>
Message-ID: <20170330235027.6879-11-mathew.j.martineau@linux.intel.com>
To: linux-security-module@vger.kernel.org
List-Id: linux-security-module.vger.kernel.org

Add a restrict_link_by_key_or_keyring_chain link restriction that
searches for signing keys in the destination keyring in addition to the
signing key or keyring designated when the destination keyring was
created. Userspace enables this behavior by including the "chain" option
in the keyring restriction:

  keyctl(KEYCTL_RESTRICT_KEYRING, keyring, "asymmetric",
         "key_or_keyring:<signing key>:chain");

Signed-off-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
---
 Documentation/crypto/asymmetric-keys.txt |   7 +-
 crypto/asymmetric_keys/asymmetric_type.c |  31 ++++--
 crypto/asymmetric_keys/restrict.c        | 158 +++++++++++++++++++++++--------
 include/crypto/public_key.h              |   5 +
 4 files changed, 155 insertions(+), 46 deletions(-)

diff --git a/Documentation/crypto/asymmetric-keys.txt b/Documentation/crypto/asymmetric-keys.txt
index 9814722f4b6b..5ad6480e3fb9 100644
--- a/Documentation/crypto/asymmetric-keys.txt
+++ b/Documentation/crypto/asymmetric-keys.txt
@@ -343,7 +343,7 @@ Several restriction methods are available:
  (3) Restrict using a separate key or keyring
 
      - Option string used with KEYCTL_RESTRICT_KEYRING:
-       - "key_or_keyring:<key or keyring serial number>"
+       - "key_or_keyring:<key or keyring serial number>[:chain]"
 
      Whenever a key link is requested, the link will only succeed if the key
      being linked is signed by one of the designated keys. This key may be
@@ -351,6 +351,11 @@ Several restriction methods are available:
      a group of keys may be searched for the signing key by providing the
      serial number for a keyring.
 
+     When the "chain" option is provided at the end of the string, the keys
+     within the destination keyring will also be searched for signing keys.
+     This allows for verification of certificate chains by adding each
+     cert in order (starting closest to the root) to one keyring.
+
 In all of these cases, if the signing key is found the signature of the key to
 be linked will be verified using the signing key.  The requested key is added
 to the keyring only if the signature is successfully verified.  -ENOKEY is
diff --git a/crypto/asymmetric_keys/asymmetric_type.c b/crypto/asymmetric_keys/asymmetric_type.c
index 72700ed81594..e4b0ed386bc8 100644
--- a/crypto/asymmetric_keys/asymmetric_type.c
+++ b/crypto/asymmetric_keys/asymmetric_type.c
@@ -496,20 +496,37 @@ static struct key_restriction *asymmetric_lookup_restriction(
 	restrict_method = strsep(&next, ":");
 
 	if ((strcmp(restrict_method, "key_or_keyring") == 0) && next) {
+		char *key_text;
 		key_serial_t serial;
 		struct key *key;
+		key_restrict_link_func_t link_fn =
+			restrict_link_by_key_or_keyring;
+		bool allow_null_key = false;
 
-		if (kstrtos32(next, 0, &serial) < 0)
-			goto out;
+		key_text = strsep(&next, ":");
+
+		if (next) {
+			if (strcmp(next, "chain") != 0)
+				goto out;
+
+			link_fn = restrict_link_by_key_or_keyring_chain;
+			allow_null_key = true;
+		}
 
-		key = key_lookup(serial);
-		if (IS_ERR(key)) {
-			ret = ERR_CAST(key);
+		if (kstrtos32(key_text, 0, &serial) < 0)
 			goto out;
+
+		if ((serial == 0) && allow_null_key) {
+			key = NULL;
+		} else {
+			key = key_lookup(serial);
+			if (IS_ERR(key)) {
+				ret = ERR_CAST(key);
+				goto out;
+			}
 		}
 
-		ret = asymmetric_restriction_alloc(
-			restrict_link_by_key_or_keyring, key);
+		ret = asymmetric_restriction_alloc(link_fn, key);
 		if (IS_ERR(ret))
 			key_put(key);
 	}
diff --git a/crypto/asymmetric_keys/restrict.c b/crypto/asymmetric_keys/restrict.c
index 183cb642580e..86fb68508952 100644
--- a/crypto/asymmetric_keys/restrict.c
+++ b/crypto/asymmetric_keys/restrict.c
@@ -109,31 +109,20 @@ int restrict_link_by_signature(struct key *dest_keyring,
 	return ret;
 }
 
-/**
- * restrict_link_by_key_or_keyring - Restrict additions to a ring of public
- * keys using the restrict_key information stored in the ring.
- * @dest_keyring: Keyring being linked to.
- * @type: The type of key being added.
- * @payload: The payload of the new key.
- * @trusted: A key or ring of keys that can be used to vouch for the new cert.
- *
- * Check the new certificate only against the key or keys passed in the data
- * parameter. If one of those is the signing key and validates the new
- * certificate, then mark the new certificate as being ok to link.
- *
- * Returns 0 if the new certificate was accepted, -ENOKEY if we
- * couldn't find a matching parent certificate in the trusted list,
- * -EKEYREJECTED if the signature check fails, and some other error if
- * there is a matching certificate but the signature check cannot be
- * performed.
- */
-int restrict_link_by_key_or_keyring(struct key *dest_keyring,
-				    const struct key_type *type,
-				    const union key_payload *payload,
-				    struct key *trusted)
+static bool match_either_id(const struct asymmetric_key_ids *pair,
+			    const struct asymmetric_key_id *single)
+{
+	return (asymmetric_key_id_same(pair->id[0], single) ||
+		asymmetric_key_id_same(pair->id[1], single));
+}
+
+static int key_or_keyring_common(struct key *dest_keyring,
+				 const struct key_type *type,
+				 const union key_payload *payload,
+				 struct key *trusted, bool check_dest)
 {
 	const struct public_key_signature *sig;
-	struct key *key;
+	struct key *key = NULL;
 	int ret;
 
 	pr_devel("==>%s()\n", __func__);
@@ -143,7 +132,7 @@ int restrict_link_by_key_or_keyring(struct key *dest_keyring,
 	else if (dest_keyring->type != &key_type_keyring)
 		return -EOPNOTSUPP;
 
-	if (!trusted)
+	if (!trusted && !check_dest)
 		return -ENOKEY;
 
 	if (type != &key_type_asymmetric)
@@ -153,25 +142,64 @@ int restrict_link_by_key_or_keyring(struct key *dest_keyring,
 	if (!sig->auth_ids[0] && !sig->auth_ids[1])
 		return -ENOKEY;
 
-	if (trusted->type == &key_type_keyring) {
-		/* See if we have a key that signed this one. */
-		key = find_asymmetric_key(trusted, sig->auth_ids[0],
-					  sig->auth_ids[1], false);
-		if (IS_ERR(key))
-			return -ENOKEY;
-	} else if (trusted->type == &key_type_asymmetric) {
-		const struct asymmetric_key_ids *kids;
+	if (trusted) {
+		if (trusted->type == &key_type_keyring) {
+			/* See if we have a key that signed this one. */
+			key = find_asymmetric_key(trusted, sig->auth_ids[0],
+						  sig->auth_ids[1], false);
+			if (IS_ERR(key))
+				key = NULL;
+		} else if (trusted->type == &key_type_asymmetric) {
+			const struct asymmetric_key_ids *signer_ids;
 
-		kids = asymmetric_key_ids(trusted);
+			signer_ids = asymmetric_key_ids(trusted);
 
-		if (!asymmetric_key_id_same(kids->id[1], sig->auth_ids[0]))
-			return -ENOKEY;
+			/*
+			 * The auth_ids come from the candidate key (the
+			 * one that is being considered for addition to
+			 * dest_keyring) and identify the key that was
+			 * used to sign.
+			 *
+			 * The signer_ids are identifiers for the
+			 * signing key specified for dest_keyring.
+			 *
+			 * The first auth_id is the preferred id, and
+			 * the second is the fallback. If only one
+			 * auth_id is present, it may match against
+			 * either signer_id. If two auth_ids are
+			 * present, the first auth_id must match one
+			 * signer_id and the second auth_id must match
+			 * the second signer_id.
+			 */
+			if (!sig->auth_ids[0] || !sig->auth_ids[1]) {
+				const struct asymmetric_key_id *auth_id;
 
-		key = __key_get(trusted);
-	} else {
-		return -EOPNOTSUPP;
+				auth_id = sig->auth_ids[0] ?: sig->auth_ids[1];
+				if (match_either_id(signer_ids, auth_id))
+					key = __key_get(trusted);
+
+			} else if (asymmetric_key_id_same(signer_ids->id[1],
+							  sig->auth_ids[1]) &&
+				   match_either_id(signer_ids,
+						   sig->auth_ids[0])) {
+				key = __key_get(trusted);
+			}
+		} else {
+			return -EOPNOTSUPP;
+		}
 	}
 
+	if (check_dest && !key) {
+		/* See if the destination has a key that signed this one. */
+		key = find_asymmetric_key(dest_keyring, sig->auth_ids[0],
+					  sig->auth_ids[1], false);
+		if (IS_ERR(key))
+			key = NULL;
+	}
+
+	if (!key)
+		return -ENOKEY;
+
 	ret = key_validate(key);
 	if (ret == 0)
 		ret = verify_signature(key, sig);
@@ -179,3 +207,57 @@ int restrict_link_by_key_or_keyring(struct key *dest_keyring,
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
+	return key_or_keyring_common(dest_keyring, type, payload, trusted,
+				     false);
+}
+
+/**
+ * restrict_link_by_key_or_keyring_chain - Restrict additions to a ring of
+ * public keys using the restrict_key information stored in the ring.
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
+int restrict_link_by_key_or_keyring_chain(struct key *dest_keyring,
+					  const struct key_type *type,
+					  const union key_payload *payload,
+					  struct key *trusted)
+{
+	return key_or_keyring_common(dest_keyring, type, payload, trusted,
+				     true);
+}
diff --git a/include/crypto/public_key.h b/include/crypto/public_key.h
index bb6a884352a5..e0b681a717ba 100644
--- a/include/crypto/public_key.h
+++ b/include/crypto/public_key.h
@@ -60,6 +60,11 @@ extern int restrict_link_by_key_or_keyring(struct key *dest_keyring,
 					   const union key_payload *payload,
 					   struct key *trusted);
 
+extern int restrict_link_by_key_or_keyring_chain(struct key *trust_keyring,
+						 const struct key_type *type,
+						 const union key_payload *payload,
+						 struct key *trusted);
+
 extern int verify_signature(const struct key *key,
 			    const struct public_key_signature *sig);
 
-- 
2.12.1

--
To unsubscribe from this list: send the line "unsubscribe linux-security-module" in
the body of a message to majordomo at vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
