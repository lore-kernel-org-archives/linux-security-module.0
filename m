Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74011DE3DC
	for <linux-security-module@vger.kernel.org>; Thu, 28 May 2026 03:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779937772; cv=none; b=NrK8LtliIYDzTOqVQ3keYWxPD8iI5WM3P3vcXrObjAtKwtOyp89FW6bbCwAkIsqpaSZhVx4F+Qc05PcTgxfUw2xx5963+cxBD/qv+PAKANiVL0HAyXB1Ko0VsnfxZ8mmkua2FCz/FQBoW+eCOnqHvuMr63vJhvANJ5yZJdYs8LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779937772; c=relaxed/simple;
	bh=kmJqaAoLR9OtqKrBq+Z6qAgfKnFSeI0rkvF4WOmikTM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RAuBebpqTebJEX2V4JmvApO7L8K1Uy6o8LZEh+8HKXBOuV4uStdwF77OsJE/4Em67TZJuQZPmly0pcluJ1LjKI5GwotoZVPVHtfFXssoZtzr/P/GJjMyP/sN/SFLf2AgqNsQsw2QcaP2mZyz7TUteyMLrEdpjmmTdsX0yC167RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XMrPeI7O; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XMrPeI7O"
Received: from narnia.corp.microsoft.com (unknown [40.78.13.147])
	by linux.microsoft.com (Postfix) with ESMTPSA id C40F220B7168;
	Wed, 27 May 2026 20:09:17 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C40F220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779937758;
	bh=UHUrKiwqJ+jz19s1c1zixpml4094khc6l/z5LeZZHRc=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=XMrPeI7OoDiJl+G0/h8KTccRgiykmaIBn4M+o9cw8XkBx62QrYdZcVo41+HJj9uja
	 U/gATbn27i2M+8q3za6OJATexrQni8npoSlyebys2RzO7D37JJ+iLmSJN3qjF3o8PA
	 Y7Dy1W0K0KYs5MP/GpX8PiF0dsuh+aE5ZGoMjRgA=
From: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
To: "Jonathan Corbet" <corbet@lwn.net>,
	"Shuah Khan" <skhan@linuxfoundation.org>,
	"Paul Moore" <paul@paul-moore.com>,
	"James Morris" <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	"Eric Biggers" <ebiggers@kernel.org>,
	"Fan Wu" <wufan@kernel.org>,
	James.Bottomley@HansenPartnership.com,
	"Blaise Boscaccy" <bboscaccy@linux.microsoft.com>,
	linux-security-module@vger.kernel.org
Subject: [PATCH 01/11] hornet: fix TOCTOU in signed program verification
Date: Wed, 27 May 2026 20:08:10 -0700
Message-ID: <20260528030915.2654994-2-bboscaccy@linux.microsoft.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
References: <20260528030915.2654994-1-bboscaccy@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The signature verification path was vulnerable to a time-of-check vs
time-of-use race at both the program load and program run hook sites:
between the moment a map's contents were hashed for signature
verification and the moment the program run hook re-verified them, an
attacker with sufficient privileges could swap or mutate the map
contents.

Close the race by snapshotting the map hashes during program load,
attaching them to the program, and re-verifying them from the
security_bpf_prog hook against prog->aux->used_maps. Because used_maps
is the same map set the verifier and runtime resolve against, there is
no longer a window in which the verified set and the executed set can
diverge.

Since we are no longer targeting the fd_array passed in, drop the map
index data entirely and check for whether or not the set of requested
map hashes is a subset of prog->aux->used_maps.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Blaise Boscaccy <bboscaccy@linux.microsoft.com>
---
 Documentation/admin-guide/LSM/Hornet.rst |  39 +++-----
 scripts/hornet/gen_sig.c                 |  17 +---
 security/hornet/hornet.asn1              |   1 -
 security/hornet/hornet_lsm.c             | 121 +++--------------------
 tools/testing/selftests/hornet/Makefile  |   2 +-
 5 files changed, 35 insertions(+), 145 deletions(-)

diff --git a/Documentation/admin-guide/LSM/Hornet.rst b/Documentation/admin-guide/LSM/Hornet.rst
index 0ade4c17374c6..a369bc11408f4 100644
--- a/Documentation/admin-guide/LSM/Hornet.rst
+++ b/Documentation/admin-guide/LSM/Hornet.rst
@@ -86,15 +86,14 @@ Hornet protects against the following threats:
 
 - **Tampering with map data**: When map hashes are included in the
   signature, Hornet verifies that frozen BPF maps match their expected
-  SHA-256 hashes at load time. Maps are also re-verified before program
-  execution via ``BPF_PROG_RUN``.
+  SHA-256 hashes at load time after the program is publically exposed.
 
 Hornet does **not** protect against:
 
 - Compromise of the signing key itself.
 - Attacks that occur after a program has been loaded and verified.
 - Programs loaded by the kernel itself (kernel-internal loads bypass
-  the ``BPF_PROG_RUN`` map check).
+  the map check).
 
 Known Limitations
 =================
@@ -117,6 +116,10 @@ Known Limitations
   data. It does not guarantee positional binding of maps to specific
   fd_array slots.
 
+- Map hash verification does not enforce any ordering. It simply asserts
+  that the set of map hashes requested to be verified exist in the used
+  array.
+
 - BPF_MAP_TYPE_PROG_ARRAY maps must be frozen for Hornet to verify
   them. Unfrozen prog array maps are not covered by verification.
 
@@ -159,24 +162,19 @@ The following describes what happens when a userspace program calls
 5. Hornet extracts the authenticated attribute identified by
    ``OID_hornet_data`` (OID ``2.25.316487325684022475439036912669789383960``)
    from the PKCS#7 message. This attribute contains an ASN.1-encoded set
-   of map index/hash pairs.
+   of map hash hashes
 
-6. For each map hash entry, Hornet retrieves the corresponding BPF map
-   via its file descriptor, confirms it is frozen, computes its SHA-256
-   hash, and compares it against the signed hash.
+6. For each map hash entry, Hornet retrieves stores the target map hash in
+   the program's LSM blob.
 
 7. The resulting integrity verdict is passed to the
    ``bpf_prog_load_post_integrity`` hook so that downstream LSMs can
    enforce policy.
 
-Runtime Map Verification
-------------------------
-
-When ``bpf(BPF_PROG_RUN, ...)`` is called from userspace, Hornet
-re-verifies the hashes of all maps associated with the program. This
-ensures that map contents have not been modified between program load
-and execution. If any map hash no longer matches, the ``BPF_PROG_RUN``
-command is denied.
+8. After the verifier processes the program, once it's ready to be published,
+   Hornet intercepts the ``bpf_prog`` hook, and verifies that the set of
+   required hashes exist in the programs used maps. If the map hashes are
+   unable to be found, the command is denied.
 
 Userspace Interface
 -------------------
@@ -199,14 +197,10 @@ the following ASN.1 schema::
   HornetData ::= SET OF Map
 
   Map ::= SEQUENCE {
-      index   INTEGER,
       sha     OCTET STRING
   }
 
-Each ``Map`` entry contains the index of the map in the program's
-``fd_array`` and its expected SHA-256 hash. A zero-length ``sha`` field
-indicates that the map at that index should be skipped during
-verification.
+Each ``Map`` entry contains an expected SHA-256 hash.
 
 Tooling
 =======
@@ -229,7 +223,7 @@ Usage::
           --key <signer.key> \
           [--pass <passphrase>] \
           --out <signature.p7b> \
-          [--add <mapfile.bin>:<index> ...]
+          [--add <mapfile.bin> ...]
 
 ``--data``
   Path to the binary file containing eBPF program instructions to sign.
@@ -248,8 +242,7 @@ Usage::
 
 ``--add``
   Attach a map hash as a signed attribute. The argument is a path to a
-  binary map file followed by a colon and the map's index in the
-  ``fd_array``. This option may be specified multiple times.
+  binary map file. This option may be specified multiple times.
 
 extract-skel.sh
 ---------------
diff --git a/scripts/hornet/gen_sig.c b/scripts/hornet/gen_sig.c
index 8dd9ed66346a2..b4f983ab24bcd 100644
--- a/scripts/hornet/gen_sig.c
+++ b/scripts/hornet/gen_sig.c
@@ -55,7 +55,6 @@
 
 struct hash_spec {
 	char *file;
-	int index;
 };
 
 typedef struct {
@@ -66,7 +65,6 @@ typedef struct {
 
 DECLARE_ASN1_FUNCTIONS(HORNET_MAP)
 ASN1_SEQUENCE(HORNET_MAP) = {
-	ASN1_SIMPLE(HORNET_MAP, index, ASN1_INTEGER),
 	ASN1_SIMPLE(HORNET_MAP, hash, ASN1_OCTET_STRING)
 } ASN1_SEQUENCE_END(HORNET_MAP);
 
@@ -253,12 +251,11 @@ static int sha256(const char *path, unsigned char out[SHA256_LEN], unsigned int
 	return rc;
 }
 
-static void add_hash(MAP_SET *set, unsigned char *buffer, int buffer_len, int index)
+static void add_hash(MAP_SET *set, unsigned char *buffer, int buffer_len)
 {
 	HORNET_MAP *map = NULL;
 
 	map = HORNET_MAP_new();
-	ASN1_INTEGER_set(map->index, index);
 	ASN1_OCTET_STRING_set(map->hash, buffer, buffer_len);
 	sk_HORNET_MAP_push(set->maps, map);
 }
@@ -320,14 +317,8 @@ int main(int argc, char **argv)
 			data_path = optarg;
 			break;
 		case 'A':
-			if (strchr(optarg, ':')) {
-				hashes[hash_count].file = strsep(&optarg, ":");
-				hashes[hash_count].index = atoi(optarg);
-				if (++hash_count >= MAX_HASHES) {
-					usage(argv[0]);
-					return EXIT_FAILURE;
-				}
-			} else {
+			hashes[hash_count].file = optarg;
+			if (++hash_count >= MAX_HASHES) {
 				usage(argv[0]);
 				return EXIT_FAILURE;
 			}
@@ -371,7 +362,7 @@ int main(int argc, char **argv)
 		if (sha256(hashes[i].file, hash_buffer, &hash_len) != 0) {
 			DIE("failed to hash input");
 		}
-		add_hash(set, hash_buffer, hash_len, hashes[i].index);
+		add_hash(set, hash_buffer, hash_len);
 	}
 
 	oid = OBJ_txt2obj("2.25.316487325684022475439036912669789383960", 1);
diff --git a/security/hornet/hornet.asn1 b/security/hornet/hornet.asn1
index e60abf451ae23..3cf50379f5e7c 100644
--- a/security/hornet/hornet.asn1
+++ b/security/hornet/hornet.asn1
@@ -7,6 +7,5 @@
 HornetData ::= SET OF Map
 
 Map ::= SEQUENCE {
-	index			INTEGER ({ hornet_map_index }),
 	sha			OCTET STRING ({ hornet_map_hash })
 } ({ hornet_next_map })
diff --git a/security/hornet/hornet_lsm.c b/security/hornet/hornet_lsm.c
index a4d11fa5b0889..516038413f321 100644
--- a/security/hornet/hornet_lsm.c
+++ b/security/hornet/hornet_lsm.c
@@ -21,26 +21,18 @@
 
 #define MAX_USED_MAPS 64
 
-struct hornet_maps {
-	bpfptr_t fd_array;
-};
-
 /* The only hashing algorithm available is SHA256 due to it be hardcoded
  * in the bpf subsystem.
  */
-
-struct hornet_parse_context {
-	int indexes[MAX_USED_MAPS];
-	bool skips[MAX_USED_MAPS];
-	unsigned char hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
-	int hash_count;
-};
-
 struct hornet_prog_security_struct {
 	int signed_hash_count;
 	unsigned char signed_hashes[SHA256_DIGEST_SIZE * MAX_USED_MAPS];
 };
 
+struct hornet_parse_context {
+	struct hornet_prog_security_struct *security;
+};
+
 struct lsm_blob_sizes hornet_blob_sizes __ro_after_init = {
 	.lbs_bpf_prog = sizeof(struct hornet_prog_security_struct),
 };
@@ -51,79 +43,17 @@ hornet_bpf_prog_security(struct bpf_prog *prog)
 	return prog->aux->security + hornet_blob_sizes.lbs_bpf_prog;
 }
 
-static int hornet_verify_hashes(struct hornet_maps *maps,
-				struct hornet_parse_context *ctx,
-				struct bpf_prog *prog)
-{
-	int map_fd;
-	u32 i;
-	struct bpf_map *map;
-	int err = 0;
-	unsigned char hash[SHA256_DIGEST_SIZE];
-	struct hornet_prog_security_struct *security = hornet_bpf_prog_security(prog);
-
-	for (i = 0; i < ctx->hash_count; i++) {
-		if (ctx->skips[i])
-			continue;
-
-		err = copy_from_bpfptr_offset(&map_fd, maps->fd_array,
-					      ctx->indexes[i] * sizeof(map_fd),
-					      sizeof(map_fd));
-		if (err != 0)
-			return LSM_INT_VERDICT_FAULT;
-
-		CLASS(fd, f)(map_fd);
-		if (fd_empty(f))
-			return LSM_INT_VERDICT_FAULT;
-		if (unlikely(fd_file(f)->f_op != &bpf_map_fops))
-			return LSM_INT_VERDICT_FAULT;
-
-		map = fd_file(f)->private_data;
-		if (!READ_ONCE(map->frozen))
-			return LSM_INT_VERDICT_FAULT;
-
-		if (!map->ops->map_get_hash)
-			return LSM_INT_VERDICT_FAULT;
-
-		if (map->ops->map_get_hash(map, SHA256_DIGEST_SIZE, hash))
-			return LSM_INT_VERDICT_FAULT;
-
-		err = memcmp(hash, &ctx->hashes[i * SHA256_DIGEST_SIZE],
-			      SHA256_DIGEST_SIZE);
-		if (err)
-			return LSM_INT_VERDICT_UNEXPECTED;
-
-		memcpy(&security->signed_hashes[security->signed_hash_count * SHA256_DIGEST_SIZE],
-		       &ctx->hashes[i * SHA256_DIGEST_SIZE], SHA256_DIGEST_SIZE);
-		security->signed_hash_count++;
-	}
-	return LSM_INT_VERDICT_OK;
-}
-
 int hornet_next_map(void *context, size_t hdrlen,
 		     unsigned char tag,
 		     const void *value, size_t vlen)
 {
 	struct hornet_parse_context *ctx = (struct hornet_parse_context *)context;
 
-	if (++ctx->hash_count >= MAX_USED_MAPS)
+	if (++ctx->security->signed_hash_count >= MAX_USED_MAPS)
 		return -EINVAL;
 	return 0;
 }
 
-int hornet_map_index(void *context, size_t hdrlen,
-		     unsigned char tag,
-		     const void *value, size_t vlen)
-{
-	struct hornet_parse_context *ctx = (struct hornet_parse_context *)context;
-
-	if (vlen != 1)
-		return -EINVAL;
-
-	ctx->indexes[ctx->hash_count] = *(u8 *)value;
-	return 0;
-}
-
 int hornet_map_hash(void *context, size_t hdrlen,
 		    unsigned char tag,
 		    const void *value, size_t vlen)
@@ -134,11 +64,8 @@ int hornet_map_hash(void *context, size_t hdrlen,
 	if (vlen != SHA256_DIGEST_SIZE && vlen != 0)
 		return -EINVAL;
 
-	if (vlen) {
-		ctx->skips[ctx->hash_count] = false;
-		memcpy(&ctx->hashes[ctx->hash_count * SHA256_DIGEST_SIZE], value, vlen);
-	} else
-		ctx->skips[ctx->hash_count] = true;
+	memcpy(&ctx->security->signed_hashes[ctx->security->signed_hash_count * SHA256_DIGEST_SIZE],
+	       value, vlen);
 
 	return 0;
 }
@@ -147,7 +74,6 @@ static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *attr,
 				struct bpf_token *token, bool is_kernel,
 				enum lsm_integrity_verdict *verdict)
 {
-	struct hornet_maps maps = {0};
 	bpfptr_t usig = make_bpfptr(attr->signature, is_kernel);
 	struct pkcs7_message *msg;
 	struct hornet_parse_context *ctx;
@@ -172,7 +98,8 @@ static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *attr,
 	if (!ctx)
 		return -ENOMEM;
 
-	maps.fd_array = make_bpfptr(attr->fd_array, is_kernel);
+	ctx->security = hornet_bpf_prog_security(prog);
+
 	sig = kzalloc(attr->signature_size, GFP_KERNEL);
 	if (!sig) {
 		err = -ENOMEM;
@@ -225,7 +152,7 @@ static int hornet_check_program(struct bpf_prog *prog, union bpf_attr *attr,
 		goto cleanup_msg;
 	}
 
-	*verdict = hornet_verify_hashes(&maps, ctx, prog);
+	*verdict = LSM_INT_VERDICT_OK;
 	err = 0;
 
 cleanup_msg:
@@ -257,10 +184,8 @@ static int hornet_bpf_prog_load_integrity(struct bpf_prog *prog, union bpf_attr
 						     &hornet_lsmid, verdict);
 }
 
-static int hornet_check_prog_maps(u32 ufd)
+static int hornet_check_prog_maps(struct bpf_prog *prog)
 {
-	CLASS(fd, f)(ufd);
-	struct bpf_prog *prog;
 	struct hornet_prog_security_struct *security;
 	unsigned char hash[SHA256_DIGEST_SIZE];
 	struct bpf_map *map;
@@ -268,12 +193,6 @@ static int hornet_check_prog_maps(u32 ufd)
 	bool found;
 	int covered_count = 0;
 
-	if (fd_empty(f))
-		return -EBADF;
-	if (fd_file(f)->f_op != &bpf_prog_fops)
-		return -EINVAL;
-
-	prog = fd_file(f)->private_data;
 	security = hornet_bpf_prog_security(prog);
 
 	if (!security->signed_hash_count)
@@ -316,26 +235,14 @@ static int hornet_check_prog_maps(u32 ufd)
 	return 0;
 }
 
-static int hornet_bpf(int cmd, union bpf_attr *attr, unsigned int size, bool kernel)
+static int hornet_bpf_prog(struct bpf_prog *prog)
 {
-	/* in horent_bpf(), anything that had originated from kernel space we assume
-	 * has already been checked, in some form or another, so we don't bother
-	 * checking the intergity of any maps. In hornet_bpf_prog_load_integrity(),
-	 * hornet doesn't make any opinion on that and delegates that to the downstream
-	 * policy enforcement.
-	 */
-
-	if (cmd != BPF_PROG_RUN)
-		return 0;
-	if (kernel)
-		return 0;
-
-	return hornet_check_prog_maps(attr->test.prog_fd);
+	return hornet_check_prog_maps(prog);
 }
 
 static struct security_hook_list hornet_hooks[] __ro_after_init = {
 	LSM_HOOK_INIT(bpf_prog_load_integrity, hornet_bpf_prog_load_integrity),
-	LSM_HOOK_INIT(bpf, hornet_bpf),
+	LSM_HOOK_INIT(bpf_prog, hornet_bpf_prog),
 };
 
 static int __init hornet_init(void)
diff --git a/tools/testing/selftests/hornet/Makefile b/tools/testing/selftests/hornet/Makefile
index 432bce59f54e7..316364f95f28c 100644
--- a/tools/testing/selftests/hornet/Makefile
+++ b/tools/testing/selftests/hornet/Makefile
@@ -51,7 +51,7 @@ $(OUTPUT)/gen_sig: ../../../../scripts/hornet/gen_sig.c
 
 sig.bin: insn.bin map.bin $(OUTPUT)/gen_sig
 	$(OUTPUT)/gen_sig --key $(CERTDIR)/signing_key.pem --cert $(CERTDIR)/signing_key.x509 \
-		--data insn.bin --add map.bin:0 --out sig.bin
+		--data insn.bin --add map.bin --out sig.bin
 
 signed_loader.h: sig.bin
 	$(SCRIPTSDIR)/write-sig.sh loader.h sig.bin > $@
-- 
2.53.0

