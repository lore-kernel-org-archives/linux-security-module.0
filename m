Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A19F4229A0;
	Thu,  2 Jul 2026 14:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783002978; cv=none; b=thHjOXAJWNjsPRROnes+Ynu6aF9GcYJG6QL1fA4fR8VPBIO98kKQ2Cd0avwE3mP2SzKldYthIdAmugrDUfNjJGOIo3i2Bm9NaSq1DGw9m9xeaxYeLFfVZR4piXUYIz0cyVyl9bYWEX1k9BL3lMNxv98zch8AqSPLBP6wOyR8mk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783002978; c=relaxed/simple;
	bh=hYY4zozvCgnGuuNeyl1P62GfoqyfpahYvLNr0/+XFwo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RWMjb4otF2ggvlQucI/5VU27Wr9AjbQ7WhKD2aIbpUTD3G/ScnW/Zc39zxZ3EIVTFTlbbiQn4PYiuGwi826I9xTDMeIl5Ci9UyxrxTOZXpH33Fzi8L2C8JEGqr5ZyXx7Naa/QoH8tPtKD4En3VK+vqB9gqK4vq1kwmszkUNmd/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=JHLkTWT8; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="JHLkTWT8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=n0Nb5PWunmUFssnWQJ4ChvcojQ5hv+XmuWLXppaTGag=; b=JHLkTWT8ctdYDloYUgYU8w/MPf
	JjvVHQcVyjmdxfRSXeAlU7yKF6F7zBL0d6b2wgbAZm4PmNUDL0dzQO2aeOgC/gzIRf1fyCPzbjczE
	mbv9jT/hi/JiqLkuUz4j1C7ROaE6DzX2+H/z837nGnoDXxoQnhlNLlzGuci3PYQMNM6RgwUXRpg6z
	GazUoU1L9NI8rfT1KZWfg8+sjG89uwQ9tI+ypjWVvlr/uHVdRukSmzmO7fmn6rYfK4TQPzaIsYeR1
	041kfdoiqg7oIwCt5I6EOgb/Zd4a5jk9O4jEe9+dDq6TVtQmbud+2KSLUkPTfvks2HpJDHn+cQS6h
	8HQky7xw==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wfIWQ-0004sd-08;
	Thu, 02 Jul 2026 16:36:10 +0200
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
Subject: [PATCH bpf-next v3 4/6] bpftool: Cover loader metadata with the program signature
Date: Thu,  2 Jul 2026 16:36:03 +0200
Message-ID: <20260702143605.252797-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260702143605.252797-1-daniel@iogearbox.net>
References: <20260702143605.252797-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28048/Thu Jul  2 08:25:04 2026)

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
bytecode to establish what the signature actually attests to [0].

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/lkml/ecf0521ed302db672672ebfbc670ecfba36a6e00.camel@HansenPartnership.com [0]
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
index f9b742f4bb10..7cc991c69dc2 100644
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
@@ -178,7 +190,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	EVP_Digest(opts->insns, opts->insns_sz, opts->excl_prog_hash,
 		   &opts->excl_prog_hash_sz, EVP_sha256(), NULL);
 
-		bd_out = BIO_new(BIO_s_mem());
+	bd_out = BIO_new(BIO_s_mem());
 	if (!bd_out) {
 		err = -ENOMEM;
 		goto cleanup;
@@ -212,6 +224,7 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 	X509_free(x509);
 	EVP_PKEY_free(private_key);
 	BIO_free(bd_in);
+	free(data);
 	DISPLAY_OSSL_ERR(err < 0);
 	return err;
 }
-- 
2.43.0

