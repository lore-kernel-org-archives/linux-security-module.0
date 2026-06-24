Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A41D3C10BE;
	Wed, 24 Jun 2026 14:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311252; cv=none; b=GoH7BH70DuNFFTe3bDuoCH3xHDbGjkvxAm0BGtxLvRCimu8t06mdZ2qtKEzkIJqB4M8YAvyFd+DpisV+FhnKIxSlg+jcppnHJf5v/2K/Ve2bXnPrwdbz3X5kRa4Nh8/TeL6LmTa9/B9HPIwPKaNxBTA5kpYESTU3yBjy4r0wXOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311252; c=relaxed/simple;
	bh=dFTXNRYWTVtFFDfHKh7YltCJspJ+/bi+xQwUZUpAS3E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhZ2IwzomQIAwipkfIZbUrEDwKHBkasQjjqoDM5zNBavg62wGZvBj/KrP6IKSeVORbh8K9FCld2t8z0G6HQ6QRy/HzW6WT6asoTnT/olbnZJKOf9vHni2NPZ16FBym4XAaYc/TKpbJ5zduVtlnm5jR4pjr0ayIwgeWXVY0MfB/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=LRZFl/C0; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="LRZFl/C0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=8pxDyYVUKftH7xhJy9yoagEtYo5UZhJoIBxkjKr6zmw=; b=LRZFl/C0/t+9YPJNA4/I/8453z
	xzutY1BZZjKh2rJsYRvVTe4PAp4Cj5wBadViUUggghkx0bYBLo7ucvcxMoXyb5ssIF98j36fbWlS1
	R2mkhlu8MQCPah7Tc0WjEV9bHKEGdwmN+D4Rl5S147FBfXvd7iQO9ZWC6o0xfyn7r/WkUog7hE8cH
	QElE6cZ4Xzc4WIZrcZefdiLarSkgInN2XPOl/NfQDz+dfXFh809zaLsQt3PbMoMHO1pyhgeTauKoe
	ok0L02vWOfp2ek4jwmuFJowhN3wOzlOcOWEIZ3tOlm2dbzpIjglRgPbSNl1z6CJHPY6SL/zjpaF1m
	pyU6is9Q==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wcOC1-000GIG-2t;
	Wed, 24 Jun 2026 16:03:05 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: kpsingh@kernel.org,
	James.Bottomley@hansenpartnership.com,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	memxor@gmail.com,
	torvalds@linux-foundation.org,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v2 4/5] selftests/bpf: Verify load-time signed loader metadata
Date: Wed, 24 Jun 2026 16:03:00 +0200
Message-ID: <20260624140301.93421-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260624140301.93421-1-daniel@iogearbox.net>
References: <20260624140301.93421-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28041/Wed Jun 24 08:24:54 2026)

The signed gen_loader no longer checks its metadata map from within
BPF; the kernel does it at BPF_PROG_LOAD by folding the loader's frozen
exclusive fd_array maps into the signature. Exercise that path end to
end. Extend with more test cases (e.g. map-less program, asserting the
LSM admission hook observes BPF_SIG_UNSIGNED and BPF_SIG_VERIFIED), and
retire the subtests that asserted the old in-loader check, which no
longer exists.

  # LDLIBS=-static PKG_CONFIG='pkg-config --static' ./vmtest.sh -- ./test_progs -t signed_loader
  [...]
  #410/1   signed_loader/loadtime_no_map:OK
  #410/2   signed_loader/loadtime_with_map:OK
  #410/3   signed_loader/metadata_match:OK
  #410/4   signed_loader/signature_enforced:OK
  #410/5   signed_loader/signed_nonexcl_fd_array_rejected:OK
  #410/6   signed_loader/signed_nonarray_fd_array_rejected:OK
  #410/7   signed_loader/signed_btf_fd_array_rejected:OK
  #410/8   signed_loader/signature_failure_logs:OK
  #410/9   signed_loader/signature_too_large:OK
  #410/10  signed_loader/signature_bad_keyring:OK
  #410/11  signed_loader/metadata_ctx_max_entries_ignored:OK
  #410/12  signed_loader/metadata_ctx_initial_value_ignored:OK
  #410/13  signed_loader/signature_authenticates_insns:OK
  #410/14  signed_loader/hash_requires_frozen:OK
  #410/15  signed_loader/no_update_after_freeze:OK
  #410/16  signed_loader/freeze_writable_mmap:OK
  #410/17  signed_loader/no_writable_mmap_frozen:OK
  #410/18  signed_loader/map_hash_matches_libbpf:OK
  #410/19  signed_loader/map_hash_multi_element:OK
  #410/20  signed_loader/map_hash_bad_size:OK
  #410/21  signed_loader/map_hash_unsupported_type:OK
  #410/22  signed_loader/lsm_signature_verdict:OK
  #410     signed_loader:OK
  Summary: 1/22 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 .../selftests/bpf/prog_tests/signed_loader.c  | 597 +++++++++++++-----
 1 file changed, 433 insertions(+), 164 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/signed_loader.c b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
index 5fc417e31fc6..00591b67ba20 100644
--- a/tools/testing/selftests/bpf/prog_tests/signed_loader.c
+++ b/tools/testing/selftests/bpf/prog_tests/signed_loader.c
@@ -11,6 +11,8 @@
 #include <linux/keyctl.h>
 #include <linux/bpf.h>
 
+#include <bpf/btf.h>
+
 #include "bpf/libbpf_internal.h" /* for libbpf_sha256() */
 #include "bpf/skel_internal.h"	 /* for loader ctx layout (bpf_loader_ctx etc) */
 
@@ -19,8 +21,6 @@
 #include "test_signed_loader_data.skel.h"
 #include "test_signed_loader_lsm.skel.h"
 
-#define SIG_MATCH_INSNS 33 /* excl (5) + 4 * sha-dword (7) */
-
 enum {
 	BPF_SIG_UNSIGNED = 0,
 	BPF_SIG_VERIFIED,
@@ -35,7 +35,8 @@ enum {
 };
 
 static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
-		       const void *sig, __u32 sig_sz, __s32 keyring_id)
+		       const void *sig, __u32 sig_sz, __s32 keyring_id,
+		       __u32 fd_array_cnt)
 {
 	union bpf_attr attr;
 	int fd;
@@ -52,6 +53,7 @@ static int load_loader(const void *insns, __u32 insns_sz, int map_fd,
 		attr.signature_size = sig_sz;
 		attr.keyring_id = keyring_id;
 	}
+	attr.fd_array_cnt = fd_array_cnt;
 	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
 	fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr,
 		     offsetofend(union bpf_attr, keyring_id));
@@ -62,14 +64,12 @@ static int run_gen_loader(const void *insns, __u32 insns_sz,
 			  const void *data, __u32 data_sz,
 			  const void *excl, __u32 excl_sz,
 			  const void *sig, __u32 sig_sz,
-			  bool get_hash, void *ctx, __u32 ctx_sz, bool *loader_ran)
+			  void *ctx, __u32 ctx_sz, bool *loader_ran)
 {
 	LIBBPF_OPTS(bpf_map_create_opts, mopts,
 		    .excl_prog_hash = excl,
 		    .excl_prog_hash_size = excl_sz);
-	__u8 hbuf[SHA256_DIGEST_LENGTH];
-	struct bpf_map_info info;
-	__u32 ilen = sizeof(info), key = 0;
+	__u32 key = 0;
 	union bpf_attr attr;
 	int map_fd, prog_fd, ret;
 
@@ -87,15 +87,6 @@ static int run_gen_loader(const void *insns, __u32 insns_sz,
 		ret = -errno;
 		goto out_map;
 	}
-	if (get_hash) {
-		memset(&info, 0, sizeof(info));
-		info.hash = ptr_to_u64(hbuf);
-		info.hash_size = sizeof(hbuf);
-		if (bpf_map_get_info_by_fd(map_fd, &info, &ilen)) {
-			ret = -errno;
-			goto out_map;
-		}
-	}
 
 	memset(&attr, 0, sizeof(attr));
 	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
@@ -108,6 +99,7 @@ static int run_gen_loader(const void *insns, __u32 insns_sz,
 		attr.signature = ptr_to_u64(sig);
 		attr.signature_size = sig_sz;
 		attr.keyring_id = KEY_SPEC_SESSION_KEYRING;
+		attr.fd_array_cnt = 1;
 	}
 	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
 	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr,
@@ -236,79 +228,6 @@ static int sign_buf(const char *dir, const void *buf, __u32 len,
 	return ret;
 }
 
-static void check_sig_match_shape(const struct bpf_insn *in, int n)
-{
-	int a = -1, cleanup = -1, i, base, t, br[5], nb = 0;
-
-	/* BPF_PSEUDO_MAP_IDX (the struct bpf_map * form) is used only here. */
-	for (i = 0; i + 1 < n; i++) {
-		if (in[i].code == (BPF_LD | BPF_IMM | BPF_DW) &&
-		    in[i].src_reg == BPF_PSEUDO_MAP_IDX) {
-			a = i;
-			break;
-		}
-	}
-	if (!ASSERT_GE(a, 0, "emit_signature_match present"))
-		return;
-	if (!ASSERT_LE(a + SIG_MATCH_INSNS, n, "block fits in program"))
-		return;
-
-	/* excl check: r2 = *(u32 *)(map + 32); if r2 != 1 goto cleanup */
-	ASSERT_EQ(in[a + 2].code, (BPF_LDX | BPF_MEM | BPF_W), "excl load width");
-	ASSERT_EQ(in[a + 2].off, SHA256_DIGEST_LENGTH, "excl field offset");
-	ASSERT_EQ(in[a + 4].code, (BPF_JMP | BPF_JNE | BPF_K), "excl branch op");
-	ASSERT_EQ(in[a + 4].imm, 1, "excl compared to 1");
-	br[nb++] = a + 4;
-
-	/* 4 sha-dword checks: r2 = *(u64 *)(map + i*8); if r2 != r3 goto cleanup */
-	for (i = 0; i < 4; i++) {
-		base = a + 5 + i * 7;
-		ASSERT_EQ(in[base + 2].code, (BPF_LDX | BPF_MEM | BPF_DW), "sha load width");
-		ASSERT_EQ(in[base + 2].off, i * 8, "sha dword offset");
-		ASSERT_EQ(in[base + 3].code, (BPF_LD | BPF_IMM | BPF_DW), "sha imm64 (H_meta)");
-		ASSERT_EQ(in[base + 6].code, (BPF_JMP | BPF_JNE | BPF_X), "sha branch op");
-		br[nb++] = base + 6;
-	}
-
-	/*
-	 * Locate the real cleanup label so we can pin the exact jump target,
-	 * not just "some backward label". bpf_gen__init() emits the cleanup
-	 * block as a prog-fd close loop whose first instruction is the label
-	 * every error branch jumps to.
-	 */
-	for (i = 0; i + 2 < a; i++) {
-		if (in[i].code == (BPF_LDX | BPF_MEM | BPF_W) &&
-		    in[i].dst_reg == BPF_REG_1 && in[i].src_reg == BPF_REG_10 &&
-		    in[i + 1].code == (BPF_JMP | BPF_JSLE | BPF_K) &&
-		    in[i + 1].dst_reg == BPF_REG_1 && in[i + 1].imm == 0 &&
-		    in[i + 1].off == 1 &&
-		    in[i + 2].code == (BPF_JMP | BPF_CALL) &&
-		    in[i + 2].imm == BPF_FUNC_sys_close) {
-			cleanup = i;
-			break;
-		}
-	}
-	if (!ASSERT_GE(cleanup, 0, "cleanup label located"))
-		return;
-	for (i = 0; i < nb; i++) {
-		t = br[i] + 1 + in[br[i]].off;
-		ASSERT_EQ(t, cleanup, "sig-match lands on cleanup");
-	}
-	/*
-	 * Same invariant for every other cleanup-bound jump in the program:
-	 * emit_check_err() is the only source of "if (r7 < 0) goto cleanup",
-	 * so each of those must also resolve exactly to cleanup.
-	 */
-	for (i = 0, t = 0; i < n; i++) {
-		if (in[i].code != (BPF_JMP | BPF_JSLT | BPF_K) ||
-		    in[i].dst_reg != BPF_REG_7 || in[i].imm != 0 || in[i].off >= 0)
-			continue;
-		ASSERT_EQ(i + 1 + in[i].off, cleanup, "err-check lands on cleanup");
-		t++;
-	}
-	ASSERT_GT(t, 0, "found emit_check_err jumps");
-}
-
 struct gen_loader_fixture {
 	struct test_signed_loader *skel;
 	struct gen_loader_opts gopts;
@@ -372,16 +291,6 @@ static void gen_loader_fixture_fini(struct gen_loader_fixture *f)
 	test_signed_loader__destroy(f->skel);
 }
 
-static void metadata_check_shape(void)
-{
-	struct gen_loader_fixture f;
-
-	if (gen_loader_fixture_init(&f) == 0)
-		check_sig_match_shape((const struct bpf_insn *)f.gopts.insns,
-				      f.gopts.insns_sz / sizeof(struct bpf_insn));
-	gen_loader_fixture_fini(&f);
-}
-
 static void metadata_match(void)
 {
 	struct gen_loader_fixture f;
@@ -391,94 +300,221 @@ static void metadata_match(void)
 	if (gen_loader_fixture_init(&f) == 0) {
 		r = run_gen_loader(f.gopts.insns, f.gopts.insns_sz, f.blob,
 				   f.data_sz, f.excl, sizeof(f.excl), NULL, 0,
-				   true, f.ctx, f.ctx_sz, &ran);
+				   f.ctx, f.ctx_sz, &ran);
 		ASSERT_TRUE(ran, "loader ran");
 		ASSERT_EQ(r, 0, "honest loader retval");
 	}
 	gen_loader_fixture_fini(&f);
 }
 
-static void metadata_sha_mismatch(void)
+static void signature_enforced(void)
 {
+	static const __u8 junk[64] = { 0x30, 0x42, 0x13, 0x37, };
 	struct gen_loader_fixture f;
-	bool ran;
-	int r;
+	int fd;
 
 	if (gen_loader_fixture_init(&f) == 0) {
 		/*
-		 * blob[0] lives in the loader's fd_array scratch (first add_data in
-		 * bpf_gen__init); a 0-map program never reads it, so flipping it
-		 * changes only map->sha. The metadata check is the only thing that
-		 * can notice -> isolates emit_signature_match.
+		 * A present-but-invalid signature (the cert bytes are not a
+		 * PKCS#7 signature) must be rejected at load: the signature
+		 * path is honored, not ignored. (The valid path is covered by
+		 * the signed lskels.)
 		 */
-		f.blob[0] ^= 0xff;
-		r = run_gen_loader(f.gopts.insns, f.gopts.insns_sz, f.blob,
-				   f.data_sz, f.excl, sizeof(f.excl), NULL, 0,
-				   true, f.ctx, f.ctx_sz, &ran);
-		ASSERT_TRUE(ran, "loader ran");
-		ASSERT_EQ(r, -EINVAL, "tampered blob rejected by emit_signature_match");
+		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
+				 sizeof(junk), KEY_SPEC_SESSION_KEYRING, 0);
+		ASSERT_LT(fd, 0, "invalid signature rejected at load");
 	}
 	gen_loader_fixture_fini(&f);
 }
 
-static void metadata_not_exclusive(void)
+static void signed_nonexcl_fd_array_rejected(void)
 {
+	static const __u8 junk[64] = { 0x30, 0x42, 0x13, 0x37, };
 	struct gen_loader_fixture f;
-	bool ran;
-	int r;
+	int map_fd, fd;
 
 	if (gen_loader_fixture_init(&f) == 0) {
 		/*
-		 * Correct blob but a non-exclusive metadata map: the verifier does
-		 * not reject (excl_prog_sha unset), so the runtime map->excl == 1
-		 * check in the loader must.
+		 * A signed program may only bind exclusive maps through fd_array
+		 * (their contents are folded into the signature). Binding a
+		 * non-exclusive map is rejected, before the signature is even
+		 * examined.
 		 */
-		r = run_gen_loader(f.gopts.insns, f.gopts.insns_sz, f.blob,
-				   f.data_sz, NULL, 0, NULL, 0, true, f.ctx,
-				   f.ctx_sz, &ran);
-		ASSERT_TRUE(ran, "loader ran");
-		ASSERT_EQ(r, -EINVAL, "non-exclusive metadata map rejected");
+		map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "nonexcl", 4,
+					f.data_sz, 1, NULL);
+		if (ASSERT_OK_FD(map_fd, "nonexcl_map")) {
+			fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd,
+					 junk, sizeof(junk),
+					 KEY_SPEC_SESSION_KEYRING, 1);
+			ASSERT_EQ(fd, -EPERM,
+				  "non-exclusive map in signed fd_array rejected");
+			if (fd >= 0)
+				close(fd);
+			close(map_fd);
+		}
 	}
 	gen_loader_fixture_fini(&f);
 }
 
-static void metadata_hash_not_computed(void)
+static void signed_nonarray_fd_array_rejected(void)
 {
+	static const __u8 junk[64] = { 0x30, 0x42, 0x13, 0x37, };
+	LIBBPF_OPTS(bpf_map_create_opts, mopts);
 	struct gen_loader_fixture f;
-	bool ran;
-	int r;
+	int map_fd, fd;
 
 	if (gen_loader_fixture_init(&f) == 0) {
 		/*
-		 * Correct, exclusive, frozen map, but its hash was never computed
-		 * (no OBJ_GET_INFO_BY_FD), so map->sha stays zero. The loader must
-		 * fail closed rather than treat an unset hash as a match.
+		 * Only a plain BPF_MAP_TYPE_ARRAY may be folded into the
+		 * signature. An exclusive map of any other type is rejected
+		 * (-EINVAL) rather than folded - this is the type gate that
+		 * keeps arena maps (map_direct_value_addr() returns a user
+		 * address) and insn-array maps (buffer smaller than value_size)
+		 * out of the hashed region, where the old code would have
+		 * memcpy()'d from them. A hash map stands in here: it is
+		 * exclusive (bound to the loader digest) but not an array.
 		 */
-		r = run_gen_loader(f.gopts.insns, f.gopts.insns_sz, f.blob,
-				   f.data_sz, f.excl, sizeof(f.excl), NULL, 0,
-				   false, f.ctx, f.ctx_sz, &ran);
-		ASSERT_TRUE(ran, "loader ran");
-		ASSERT_EQ(r, -EINVAL, "uncomputed metadata hash rejected");
+		mopts.excl_prog_hash = f.excl;
+		mopts.excl_prog_hash_size = sizeof(f.excl);
+		map_fd = bpf_map_create(BPF_MAP_TYPE_HASH, "excl_hash", 4, 4, 1,
+					&mopts);
+		if (ASSERT_OK_FD(map_fd, "excl_hash_map")) {
+			fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd,
+					 junk, sizeof(junk),
+					 KEY_SPEC_SESSION_KEYRING, 1);
+			ASSERT_EQ(fd, -EINVAL,
+				  "non-array map in signed fd_array rejected");
+			if (fd >= 0)
+				close(fd);
+			close(map_fd);
+		}
 	}
 	gen_loader_fixture_fini(&f);
 }
 
-static void signature_enforced(void)
+static int setup_meta_map(const struct gen_loader_fixture *f);
+
+static void signed_btf_fd_array_rejected(void)
+{
+	char dir_tmpl[] = "/tmp/signed_loader_btfXXXXXX", *dir = NULL;
+	__u32 sig_sz = 8192;
+	int map_fd = -1, prog_fd = -1;
+	unsigned char *buf = NULL;
+	struct gen_loader_fixture f;
+	bool have_fixture = false;
+	struct btf *btf = NULL;
+	union bpf_attr attr;
+	int fds[2];
+	__u8 sig[8192];
+
+	syscall(__NR_request_key, "keyring", "_uid.0", NULL,
+		KEY_SPEC_SESSION_KEYRING);
+	dir = mkdtemp(dir_tmpl);
+	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
+		return;
+	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+		rmdir(dir);
+		return;
+	}
+	if (gen_loader_fixture_init(&f) != 0)
+		goto out;
+	have_fixture = true;
+
+	/*
+	 * fd_array binds maps and BTFs alike, but only exclusive array maps are
+	 * folded into the signature. Build a genuinely signed load - insns ||
+	 * metadata, exclusive frozen map at fd_array[0] - so it reaches
+	 * BPF_SIG_VERIFIED, then smuggle an extra BTF into fd_array[1]. The BTF
+	 * is not foldable and carries no excl_prog_sha, so it is not covered;
+	 * the post-verifier coverage check (used_btf_cnt != 0) must reject the
+	 * verified program with -EACCES.
+	 */
+	buf = malloc((size_t)f.gopts.insns_sz + f.data_sz);
+	if (!ASSERT_OK_PTR(buf, "signbuf"))
+		goto out;
+	memcpy(buf, f.gopts.insns, f.gopts.insns_sz);
+	memcpy(buf + f.gopts.insns_sz, f.blob, f.data_sz);
+	if (!ASSERT_OK(sign_buf(dir, buf, f.gopts.insns_sz + f.data_sz, sig,
+			       &sig_sz), "sign insns||metadata"))
+		goto out;
+
+	map_fd = setup_meta_map(&f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map"))
+		goto out;
+	btf = btf__new_empty();
+	if (!ASSERT_OK_PTR(btf, "btf_new_empty"))
+		goto out;
+	btf__add_int(btf, "int", 4, BTF_INT_SIGNED);
+	if (!ASSERT_OK(btf__load_into_kernel(btf), "btf_load"))
+		goto out;
+
+	fds[0] = map_fd;
+	fds[1] = btf__fd(btf);
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
+	attr.insns = ptr_to_u64(f.gopts.insns);
+	attr.insn_cnt = f.gopts.insns_sz / sizeof(struct bpf_insn);
+	attr.license = ptr_to_u64("Dual BSD/GPL");
+	attr.prog_flags = BPF_F_SLEEPABLE;
+	attr.fd_array = ptr_to_u64(fds);
+	attr.fd_array_cnt = 2;
+	attr.signature = ptr_to_u64(sig);
+	attr.signature_size = sig_sz;
+	attr.keyring_id = KEY_SPEC_SESSION_KEYRING;
+	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr,
+			  offsetofend(union bpf_attr, keyring_id));
+	ASSERT_EQ(prog_fd < 0 ? -errno : prog_fd, -EACCES,
+		  "BTF in signed fd_array rejected post-verifier");
+	if (prog_fd >= 0)
+		close(prog_fd);
+out:
+	if (btf)
+		btf__free(btf);
+	if (map_fd >= 0)
+		close(map_fd);
+	if (have_fixture)
+		gen_loader_fixture_fini(&f);
+	if (dir)
+		run_setup("cleanup", dir);
+	free(buf);
+}
+
+static void signature_failure_logs(void)
 {
 	static const __u8 junk[64] = { 0x30, 0x42, 0x13, 0x37, };
+	char log_buf[1024] = {};
 	struct gen_loader_fixture f;
+	union bpf_attr attr;
 	int fd;
 
 	if (gen_loader_fixture_init(&f) == 0) {
 		/*
-		 * A present-but-invalid signature (the cert bytes are not a
-		 * PKCS#7 signature) must be rejected at load: the signature
-		 * path is honored, not ignored. (The valid path is covered by
-		 * the signed lskels.)
+		 * Signature verification now runs inside bpf_check(), so a
+		 * failure is reported through the verifier log. A present-but-
+		 * invalid signature is rejected and the log says why.
 		 */
-		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
-				 sizeof(junk), KEY_SPEC_SESSION_KEYRING);
+		memset(&attr, 0, sizeof(attr));
+		attr.prog_type = BPF_PROG_TYPE_SYSCALL;
+		attr.insns = ptr_to_u64(f.gopts.insns);
+		attr.insn_cnt = f.gopts.insns_sz / sizeof(struct bpf_insn);
+		attr.license = ptr_to_u64("Dual BSD/GPL");
+		attr.prog_flags = BPF_F_SLEEPABLE;
+		attr.signature = ptr_to_u64(junk);
+		attr.signature_size = sizeof(junk);
+		attr.keyring_id = KEY_SPEC_SESSION_KEYRING;
+		attr.log_level = 1;
+		attr.log_buf = ptr_to_u64(log_buf);
+		attr.log_size = sizeof(log_buf);
+		memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
+
+		fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr,
+			     offsetofend(union bpf_attr, keyring_id));
 		ASSERT_LT(fd, 0, "invalid signature rejected at load");
+		if (fd >= 0)
+			close(fd);
+		ASSERT_HAS_SUBSTR(log_buf, "signature verification failed",
+				  "verifier logs signature failure");
 	}
 	gen_loader_fixture_fini(&f);
 }
@@ -495,7 +531,7 @@ static void signature_too_large(void)
 		 * is rejected before the buffer is read.
 		 */
 		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
-				 64 << 20, KEY_SPEC_SESSION_KEYRING);
+				 64 << 20, KEY_SPEC_SESSION_KEYRING, 0);
 		ASSERT_EQ(fd, -EINVAL, "oversized signature rejected");
 	}
 	gen_loader_fixture_fini(&f);
@@ -515,7 +551,7 @@ static void signature_bad_keyring(void)
 		 * large positive serial takes the user-keyring path and won't exist.
 		 */
 		fd = load_loader(f.gopts.insns, f.gopts.insns_sz, -1, junk,
-				 sizeof(junk), INT_MAX);
+				 sizeof(junk), INT_MAX, 0);
 		ASSERT_EQ(fd, -EINVAL, "signature with bad keyring_id rejected");
 	}
 	gen_loader_fixture_fini(&f);
@@ -575,7 +611,7 @@ static void metadata_ctx_max_entries_ignored(void)
 	memcpy(blob, gopts.data, data_sz);
 
 	r = run_gen_loader(gopts.insns, gopts.insns_sz, blob, data_sz,
-			   excl, sizeof(excl), NULL, 0, true, ctx, ctx_sz, &ran);
+			   excl, sizeof(excl), NULL, 0, ctx, ctx_sz, &ran);
 	if (!ASSERT_TRUE(ran, "loader ran") ||
 	    !ASSERT_EQ(r, 0, "loader retval"))
 		goto free_blob;
@@ -661,7 +697,7 @@ static void metadata_ctx_initial_value_ignored(void)
 	memcpy(blob, gopts.data, data_sz);
 
 	r = run_gen_loader(gopts.insns, gopts.insns_sz, blob, data_sz,
-			   excl, sizeof(excl), NULL, 0, true, ctx, ctx_sz, &ran);
+			   excl, sizeof(excl), NULL, 0, ctx, ctx_sz, &ran);
 	if (!ASSERT_TRUE(ran, "loader ran") ||
 	    !ASSERT_EQ(r, 0, "loader retval"))
 		goto free_blob;
@@ -714,6 +750,7 @@ static void signature_authenticates_insns(void)
 	__u8 excl[SHA256_DIGEST_LENGTH], sig[8192];
 	__u32 sig_sz = sizeof(sig), insns_sz, data_sz, ctx_sz;
 	unsigned char *insns = NULL, *tampered = NULL, *blob = NULL;
+	unsigned char *signbuf = NULL;
 	int nr_maps = 0, nr_progs = 0, r;
 	struct bpf_program *p;
 	struct bpf_map *m;
@@ -760,29 +797,46 @@ static void signature_authenticates_insns(void)
 	memcpy(blob, gopts.data, data_sz);
 	libbpf_sha256(insns, insns_sz, excl);
 
-	if (!ASSERT_OK(sign_buf(dir, insns, insns_sz, sig, &sig_sz), "sign-file"))
+	signbuf = malloc((size_t)insns_sz + data_sz);
+	if (!ASSERT_OK_PTR(signbuf, "signbuf"))
+		goto cleanup;
+	memcpy(signbuf, insns, insns_sz);
+	memcpy(signbuf + insns_sz, blob, data_sz);
+	if (!ASSERT_OK(sign_buf(dir, signbuf, insns_sz + data_sz, sig, &sig_sz),
+		       "sign-file"))
 		goto cleanup;
 
 	memset(ctx, 0, ctx_sz);
 	((struct bpf_loader_ctx *)ctx)->sz = ctx_sz;
 	r = run_gen_loader(insns, insns_sz, blob, data_sz, excl, sizeof(excl),
-			   sig, sig_sz, true, ctx, ctx_sz, &ran);
+			   sig, sig_sz, ctx, ctx_sz, &ran);
 	ASSERT_TRUE(ran, "valid signature: loader loaded and ran");
 	ASSERT_EQ(r, 0, "valid signature accepted");
 	close_loader_ctx_fds(ctx, nr_maps, nr_progs);
 
 	memcpy(tampered, insns, insns_sz);
 	tampered[insns_sz / 2] ^= 0xff;
+	/*
+	 * Bind the metadata map to the tampered loader's own digest, so the
+	 * verifier's exclusive-map check (excl_prog_sha == prog->digest) passes
+	 * and the signature - verified after the maps are resolved - is what
+	 * rejects the load. This is the attacker's best case: even after
+	 * re-binding the exclusive map to their tampered loader, the signature
+	 * over the original insns || metadata still fails. (Leaving the map
+	 * bound to the original digest would instead trip the excl check first.)
+	 */
+	libbpf_sha256(tampered, insns_sz, excl);
 	memset(ctx, 0, ctx_sz);
 	((struct bpf_loader_ctx *)ctx)->sz = ctx_sz;
 	r = run_gen_loader(tampered, insns_sz, blob, data_sz, excl, sizeof(excl),
-			   sig, sig_sz, true, ctx, ctx_sz, &ran);
+			   sig, sig_sz, ctx, ctx_sz, &ran);
 	ASSERT_FALSE(ran, "tampered loader rejected before run");
 	ASSERT_EQ(r, -EKEYREJECTED, "signature is bound to the instructions");
 cleanup:
 	free(insns);
 	free(tampered);
 	free(blob);
+	free(signbuf);
 	free(ctx);
 	test_signed_loader__destroy(skel);
 	run_setup("cleanup", dir);
@@ -1007,10 +1061,11 @@ static void lsm_signature_verdict(void)
 {
 	char dir_tmpl[] = "/tmp/signed_loader_lsmXXXXXX", *dir = NULL;
 	struct test_signed_loader_lsm *lsm = NULL;
+	__u32 sig_sz = 8192, msig_sz = 8192;
 	int map_fd = -1, prog_fd = -1;
 	bool have_fixture = false;
 	struct gen_loader_fixture f;
-	__u32 sig_sz = 8192;
+	unsigned char *buf;
 	__s32 ses_serial;
 	__u8 sig[8192];
 
@@ -1029,7 +1084,7 @@ static void lsm_signature_verdict(void)
 	if (!ASSERT_OK_FD(map_fd, "meta_map_unsigned"))
 		goto out;
 	lsm->bss->seen = 0;
-	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, NULL, 0, 0);
+	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, NULL, 0, 0, 0);
 	close(map_fd);
 	map_fd = -1;
 	if (!ASSERT_OK_FD(prog_fd, "unsigned loader load"))
@@ -1062,22 +1117,51 @@ static void lsm_signature_verdict(void)
 		goto out;
 	lsm->bss->seen = 0;
 	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
-			      sig_sz, KEY_SPEC_SESSION_KEYRING);
+			      sig_sz, KEY_SPEC_SESSION_KEYRING, 0);
 	close(map_fd);
 	map_fd = -1;
-	if (!ASSERT_OK_FD(prog_fd, "signed loader load"))
-		goto out;
-	close(prog_fd);
+	ASSERT_EQ(prog_fd, -EACCES, "unfolded metadata rejected");
+	if (prog_fd >= 0)
+		close(prog_fd);
 	prog_fd = -1;
 
 	ses_serial = syscall(__NR_keyctl, KEYCTL_GET_KEYRING_ID,
 			     KEY_SPEC_SESSION_KEYRING, 0);
 	ASSERT_EQ(lsm->bss->seen, 1, "signed: one observed load");
-	ASSERT_EQ(lsm->bss->sig_verdict, BPF_SIG_VERIFIED, "signed verdict");
+	ASSERT_EQ(lsm->bss->sig_verdict, BPF_SIG_VERIFIED,
+		  "admission saw a valid signature");
 	ASSERT_EQ(lsm->bss->sig_keyring_type, BPF_SIG_KEYRING_USER, "signed keyring type");
 	ASSERT_GT(ses_serial, 0, "session keyring serial resolved");
 	ASSERT_EQ(lsm->bss->sig_keyring_serial, ses_serial,
 		  "signed: validated against session keyring");
+
+	buf = malloc((size_t)f.gopts.insns_sz + f.data_sz);
+	if (!ASSERT_OK_PTR(buf, "meta_signbuf"))
+		goto out;
+	memcpy(buf, f.gopts.insns, f.gopts.insns_sz);
+	memcpy(buf + f.gopts.insns_sz, f.blob, f.data_sz);
+	if (!ASSERT_OK(sign_buf(dir, buf, f.gopts.insns_sz + f.data_sz,
+				sig, &msig_sz), "sign insns||metadata")) {
+		free(buf);
+		goto out;
+	}
+	free(buf);
+
+	map_fd = setup_meta_map(&f);
+	if (!ASSERT_OK_FD(map_fd, "meta_map_bound"))
+		goto out;
+	lsm->bss->seen = 0;
+	prog_fd = load_loader(f.gopts.insns, f.gopts.insns_sz, map_fd, sig,
+			      msig_sz, KEY_SPEC_SESSION_KEYRING, 1);
+	close(map_fd);
+	map_fd = -1;
+	if (!ASSERT_OK_FD(prog_fd, "metadata-bound loader load"))
+		goto out;
+	close(prog_fd);
+	prog_fd = -1;
+	ASSERT_EQ(lsm->bss->seen, 1, "metadata: one observed load");
+	ASSERT_EQ(lsm->bss->sig_verdict, BPF_SIG_VERIFIED,
+		  "metadata-bound verdict");
 out:
 	if (map_fd >= 0)
 		close(map_fd);
@@ -1090,20 +1174,205 @@ static void lsm_signature_verdict(void)
 	test_signed_loader_lsm__destroy(lsm);
 }
 
+/*
+ * Load-time metadata verification: the kernel folds the frozen metadata map
+ * into the signature (insns || metadata) and checks it at BPF_PROG_LOAD via
+ * fd_array_cnt, rather than the loader checking from within BPF. Sign that
+ * concatenation, hand the kernel the map, and confirm the signed loader loads,
+ * runs, and installs its target.
+ */
+static int loadtime_drive(const char *dir, const void *insns, __u32 insns_sz,
+			  const void *data, __u32 data_sz, const __u8 *excl,
+			  void *ctx, __u32 ctx_sz, int *load_ret, bool *ran)
+{
+	LIBBPF_OPTS(bpf_map_create_opts, mopts,
+		    .excl_prog_hash = excl,
+		    .excl_prog_hash_size = SHA256_DIGEST_LENGTH);
+	__u32 sig_sz = 8192, key = 0;
+	unsigned char *buf = NULL;
+	int map_fd, prog_fd, ret = 0;
+	union bpf_attr attr;
+	__u8 sig[8192];
+
+	*ran = false;
+	*load_ret = 0;
+
+	/*
+	 * Metadata map, bound to the loader digest and frozen, exactly as
+	 * skel_internal.h's bpf_load_and_run() sets it up.
+	 */
+	map_fd = bpf_map_create(BPF_MAP_TYPE_ARRAY, "__loader.map", 4,
+				data_sz, 1, &mopts);
+	if (map_fd < 0)
+		return -errno;
+	if (bpf_map_update_elem(map_fd, &key, data, 0) || bpf_map_freeze(map_fd)) {
+		ret = -errno;
+		goto out_map;
+	}
+
+	/* Sign insns || metadata, the same bytes the kernel reconstructs. */
+	buf = malloc((size_t)insns_sz + data_sz);
+	if (!buf) {
+		ret = -ENOMEM;
+		goto out_map;
+	}
+	memcpy(buf, insns, insns_sz);
+	memcpy(buf + insns_sz, data, data_sz);
+	ret = sign_buf(dir, buf, insns_sz + data_sz, sig, &sig_sz);
+	if (ret)
+		goto out_map;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.prog_type = BPF_PROG_TYPE_SYSCALL;
+	attr.insns = ptr_to_u64(insns);
+	attr.insn_cnt = insns_sz / sizeof(struct bpf_insn);
+	attr.license = ptr_to_u64("Dual BSD/GPL");
+	attr.prog_flags = BPF_F_SLEEPABLE;
+	attr.fd_array = ptr_to_u64(&map_fd);
+	attr.signature = ptr_to_u64(sig);
+	attr.signature_size = sig_sz;
+	attr.keyring_id = KEY_SPEC_SESSION_KEYRING;
+	attr.fd_array_cnt = 1;
+	memcpy(attr.prog_name, "__loader.prog", sizeof("__loader.prog"));
+	prog_fd = syscall(__NR_bpf, BPF_PROG_LOAD, &attr,
+			  offsetofend(union bpf_attr, keyring_id));
+	if (prog_fd < 0) {
+		*load_ret = -errno;
+		ret = -errno;
+		goto out_map;
+	}
+
+	memset(&attr, 0, sizeof(attr));
+	attr.test.prog_fd = prog_fd;
+	attr.test.ctx_in = ptr_to_u64(ctx);
+	attr.test.ctx_size_in = ctx_sz;
+	if (syscall(__NR_bpf, BPF_PROG_RUN, &attr,
+		    offsetofend(union bpf_attr, test)) < 0) {
+		ret = -errno;
+		goto out_prog;
+	}
+	*ran = true;
+	ret = (int)attr.test.retval;
+out_prog:
+	close(prog_fd);
+out_map:
+	free(buf);
+	close(map_fd);
+	return ret;
+}
+
+static void loadtime_verify(struct bpf_object *obj, int expect_maps)
+{
+	LIBBPF_OPTS(gen_loader_opts, gopts, .gen_hash = true);
+	char dir_tmpl[] = "/tmp/signed_loader_ltXXXXXX", *dir = NULL;
+	int nr_maps = 0, nr_progs = 0, load_ret = 0, r;
+	__u8 excl[SHA256_DIGEST_LENGTH];
+	struct bpf_prog_desc *pd;
+	struct bpf_map_desc *md;
+	unsigned char *blob = NULL;
+	struct bpf_program *p;
+	struct bpf_map *m;
+	__u32 ctx_sz, data_sz;
+	void *ctx = NULL;
+	bool ran = false;
+
+	syscall(__NR_request_key, "keyring", "_uid.0", NULL,
+		KEY_SPEC_SESSION_KEYRING);
+	dir = mkdtemp(dir_tmpl);
+	if (!ASSERT_OK_PTR(dir, "mkdtemp"))
+		return;
+	if (!ASSERT_OK(run_setup("setup", dir), "verify_sig_setup")) {
+		rmdir(dir);
+		return;
+	}
+
+	if (!ASSERT_OK(bpf_object__gen_loader(obj, &gopts), "gen_loader"))
+		goto out;
+	if (!ASSERT_OK(bpf_object__load(obj), "gen_load"))
+		goto out;
+
+	bpf_object__for_each_program(p, obj)
+		nr_progs++;
+	bpf_object__for_each_map(m, obj)
+		nr_maps++;
+	if (!ASSERT_EQ(nr_maps, expect_maps, "fixture map count"))
+		goto out;
+
+	ctx_sz = sizeof(struct bpf_loader_ctx) +
+		 nr_maps * sizeof(struct bpf_map_desc) +
+		 nr_progs * sizeof(struct bpf_prog_desc);
+	ctx = calloc(1, ctx_sz);
+	if (!ASSERT_OK_PTR(ctx, "ctx_alloc"))
+		goto out;
+	((struct bpf_loader_ctx *)ctx)->sz = ctx_sz;
+
+	data_sz = gopts.data_sz;
+	blob = malloc(data_sz);
+	if (!ASSERT_OK_PTR(blob, "blob_alloc"))
+		goto out;
+	memcpy(blob, gopts.data, data_sz);
+
+	/* excl_prog_hash = SHA256(loader insns) == the loader's prog->digest. */
+	libbpf_sha256(gopts.insns, gopts.insns_sz, excl);
+
+	r = loadtime_drive(dir, gopts.insns, gopts.insns_sz, blob, data_sz,
+			   excl, ctx, ctx_sz, &load_ret, &ran);
+	ASSERT_OK(load_ret, "signed loader loaded (insns || metadata)");
+	ASSERT_TRUE(ran, "loader ran");
+	ASSERT_EQ(r, 0, "loader installed its target");
+
+	md = (struct bpf_map_desc *)((char *)ctx + sizeof(struct bpf_loader_ctx));
+	pd = (struct bpf_prog_desc *)(md + nr_maps);
+	ASSERT_GT(pd[0].prog_fd, 0, "target program installed");
+	if (nr_maps)
+		ASSERT_GT(md[0].map_fd, 0, "target map installed");
+
+	close_loader_ctx_fds(ctx, nr_maps, nr_progs);
+out:
+	free(blob);
+	free(ctx);
+	if (dir)
+		run_setup("cleanup", dir);
+}
+
+static void loadtime_no_map(void)
+{
+	struct test_signed_loader *skel = test_signed_loader__open();
+
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+	loadtime_verify(skel->obj, 0);
+	test_signed_loader__destroy(skel);
+}
+
+static void loadtime_with_map(void)
+{
+	struct test_signed_loader_map *skel = test_signed_loader_map__open();
+
+	if (!ASSERT_OK_PTR(skel, "skel_open"))
+		return;
+	loadtime_verify(skel->obj, 1);
+	test_signed_loader_map__destroy(skel);
+}
+
 void test_signed_loader(void)
 {
-	if (test__start_subtest("metadata_check_shape"))
-		metadata_check_shape();
+	if (test__start_subtest("loadtime_no_map"))
+		loadtime_no_map();
+	if (test__start_subtest("loadtime_with_map"))
+		loadtime_with_map();
 	if (test__start_subtest("metadata_match"))
 		metadata_match();
-	if (test__start_subtest("metadata_sha_mismatch"))
-		metadata_sha_mismatch();
-	if (test__start_subtest("metadata_not_exclusive"))
-		metadata_not_exclusive();
-	if (test__start_subtest("metadata_hash_not_computed"))
-		metadata_hash_not_computed();
 	if (test__start_subtest("signature_enforced"))
 		signature_enforced();
+	if (test__start_subtest("signed_nonexcl_fd_array_rejected"))
+		signed_nonexcl_fd_array_rejected();
+	if (test__start_subtest("signed_nonarray_fd_array_rejected"))
+		signed_nonarray_fd_array_rejected();
+	if (test__start_subtest("signed_btf_fd_array_rejected"))
+		signed_btf_fd_array_rejected();
+	if (test__start_subtest("signature_failure_logs"))
+		signature_failure_logs();
 	if (test__start_subtest("signature_too_large"))
 		signature_too_large();
 	if (test__start_subtest("signature_bad_keyring"))
-- 
2.43.0

