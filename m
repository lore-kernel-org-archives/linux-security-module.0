Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56887375F95;
	Mon,  6 Jul 2026 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346220; cv=none; b=YPErpLF87ka1nMw8LWHzIMMrtXtq4V9lDZPzqEXO3e9pAixD6gfErREWqpdcqPeEbOVY4dOpwiy7M06JnjQU41hvPPiFrQcy15UHi8hx2pMgBvYy7pd9n9jL9ywxN8ciEWZBsBXZzMz4i+IABhwGJgQPWtZBgpEQXHu8d3CzYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346220; c=relaxed/simple;
	bh=pcDq4NbrjGH+jQFnA9KjaALKY0CKT6ybpFa8Q0UEvlM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VZczMt7se6zNlu/6CpL5+z5uSwk+b/t1yp1BeG70zl1nid5i8MQCV0lU8NPTSIDn8UyJC5skCt7BHfQF4r9kWeTDuEoQARw0Lv9fOsIknYiSX+IpiW8NmXnlcf2SbQmn8UxBEUmIXpM2+MJ2R6SVxPLP0QYynyS/9hm/B0Syd/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=B/ucG39r; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="B/ucG39r"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=Fqx6ojbpajiobyI4Lzc0PA8hQj2/Xu7CNaTSYwlllAI=; b=B/ucG39rIvG+lZcuf4Grhd+2nH
	EcxxnGct6JbhSQ9Px3Xf9cmpyoy9xn1atYdGJ0wzJxUlvEg3OE6+49lb9pHaUfRnodWlj4ksCeKRj
	kDkKVEZXunSFDqMz4dMd6yTVPbzq3uEJrW+XgHB4bYPj1HS7Um3q8nbx2RHu2G+l9lp8IvoCLg+uz
	F+iuHCAihHzEGc/8YnnpaioPGvOI1zVvtry7NUsvSSOeWUp3OrMV7yCK/xNa7I2kXEmJk/ByLygo8
	WAI0JkAoxzGhWLRFmA1EbPY09nfQbECJSnh2g5tRK6TaqhztAtmXeV3BxGU4kzGS6YLpkG4C1onU+
	oIjtrg/A==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wgjoZ-000E2g-07;
	Mon, 06 Jul 2026 15:56:51 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: ast@kernel.org
Cc: kpsingh@kernel.org,
	James.Bottomley@hansenpartnership.com,
	paul@paul-moore.com,
	bboscaccy@linux.microsoft.com,
	memxor@gmail.com,
	torvalds@linux-foundation.org,
	a.s.protopopov@gmail.com,
	bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH bpf-next v4 6/9] bpftool: Cover loader metadata with the program signature
Date: Mon,  6 Jul 2026 15:56:41 +0200
Message-ID: <20260706135644.326006-7-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706135644.326006-1-daniel@iogearbox.net>
References: <20260706135644.326006-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28052/Mon Jul  6 08:24:35 2026)

bpftool_prog_sign() signed only the loader instructions. The metadata
blob the loader installs was left to an in-loader hash check, which
the kernel now performs at load time over insns || metadata.

Sign that same concatenation: pass the metadata blob (gen_loader_opts
data) through to bpftool_prog_sign() and feed insns || metadata to
CMS_final(). The excl_prog_hash stays a digest of the instructions
alone; it binds the metadata map to the loader and is matched against
prog->digest by the verifier, independent of what the signature covers.

The signed artifact is now plain data: both bytes the signature
covers are embedded verbatim in the generated skeleton, so signing
and verifying an lskel is an ordinary CMS operation that a signer or
auditor can perform (or reproduce) offline, without analyzing loader
bytecode to establish what the signature actually attests to.

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/bpf/bpftool/gen.c  |  2 ++
 tools/bpf/bpftool/sign.c | 17 +++++++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 6ae7262ebe0c..a01d06d22d1a 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -793,6 +793,8 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	if (sign_progs) {
 		sopts.insns = opts.insns;
 		sopts.insns_sz = opts.insns_sz;
+		sopts.data = opts.data;
+		sopts.data_sz = opts.data_sz;
 		sopts.excl_prog_hash = prog_sha;
 		sopts.excl_prog_hash_sz = sizeof(prog_sha);
 		sopts.signature = sig_buf;
diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
index 1257dba8ef2f..88726a6db6d0 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -135,9 +135,21 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	CMS_ContentInfo *cms = NULL;
 	long actual_sig_len = 0;
 	X509 *x509 = NULL;
+	void *data = NULL;
+	size_t data_sz;
 	int err = 0;
 
-	bd_in = BIO_new_mem_buf(opts->insns, opts->insns_sz);
+	data_sz = (size_t)opts->insns_sz + opts->data_sz;
+	data = malloc(data_sz);
+	if (!data) {
+		err = -ENOMEM;
+		goto cleanup;
+	}
+	memcpy(data, opts->insns, opts->insns_sz);
+	if (opts->data_sz)
+		memcpy((char *)data + opts->insns_sz, opts->data, opts->data_sz);
+
+	bd_in = BIO_new_mem_buf(data, data_sz);
 	if (!bd_in) {
 		err = -ENOMEM;
 		goto cleanup;
@@ -181,7 +193,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 		goto cleanup;
 	}
 
-		bd_out = BIO_new(BIO_s_mem());
+	bd_out = BIO_new(BIO_s_mem());
 	if (!bd_out) {
 		err = -ENOMEM;
 		goto cleanup;
@@ -215,6 +227,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	X509_free(x509);
 	EVP_PKEY_free(private_key);
 	BIO_free(bd_in);
+	free(data);
 	DISPLAY_OSSL_ERR(err < 0);
 	return err;
 }
-- 
2.43.0

