Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4F53B894B;
	Wed, 24 Jun 2026 14:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311248; cv=none; b=C2mzwPkQKOWGIOMr9B05/BnvMpTBXEjP7AJwIfLL2U+SG74Y7LhHHvQSIteKpKxmkrnabw8VabhiLMEHcJeZk7N3vFCM0zWVUzACX8jV8JUU2YfVUAk/7euZQIbvZSTBYfN7hHgrlqcSIjaZmxlN1/V/X8Jaw418W4gRii2HqFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311248; c=relaxed/simple;
	bh=nSHPGol8x9CCK09iBh8UQ1G+rjqITRIm1pqgMN2wi3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gIElUPnZ4iihtqBMJMGwAWDQU+brgF/VlvsGX6MaqwkRhHjAxMY1BS5fxDAO1++Z9z1nvzdF13qg4SxUUEUYWLX3opYee+HcmkNdVyk4bmYYBK8e8Fxig3Gltn572iyGTATNuckhlK2jomEbJzeoAEB601JWwm3CzSoq9/li1Mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=nyQdiic9; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="nyQdiic9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=oK+PnwiemjV8qpnT02h65wnJMPwpi/Jz+sRqcwoADug=; b=nyQdiic9FSXgujNEF6kaIhpzMJ
	KnpEdEcSIx3fmfokP4MyzoCLFPUxkcxljm0Ao5ND9b+MxguNHrojVcMgE2DFzRXnpvF99onfFMdXN
	QFW0yKSW5avVr3N3AjggCP1w+FdfTQwacyGMhyt4uC0kzt4trZR6eGAZiqRjI+Vn+clCBKKhvBr4m
	OZqCdxwI3Abuu7RAd/ZYeIs9ld2AK4x8RF9S0S8DNaEEMbyYg74nnvzPk3ENmJlsa7xGJcgN2UYXp
	qpPJwpzRJ4+4p4/GOJXYZt5LztSFPswfEX4NhB83YYQemAz4cTycMxREQgA1aOgwEfQD4a8Lc4tRD
	oeUtQrmg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wcOC1-000GI4-0H;
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
Subject: [PATCH bpf-next v2 3/5] bpftool: Cover loader metadata with the program signature
Date: Wed, 24 Jun 2026 16:02:59 +0200
Message-ID: <20260624140301.93421-4-daniel@iogearbox.net>
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
 tools/bpf/bpftool/sign.c | 15 ++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

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
index f9b742f4bb10..4ce020a141dc 100644
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

