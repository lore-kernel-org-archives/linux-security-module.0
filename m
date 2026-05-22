Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB83329373;
	Fri, 22 May 2026 02:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417174; cv=none; b=jUAzrHgjHInaUYLTBqZBUqgJhgqVSvziCTnnEVQGSnAa8oLmh4hw0RGXBIGpVnxgiuXZWR4E152QDIYNx7UnSKHYdcBQ+O2qXoGwxijSUAUNJoykAWiarC9Oo0VwJz089N+lF+v9uynJFtRmZ4MtwJIGyOQF2ZyRxC27PuJdJ2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417174; c=relaxed/simple;
	bh=y9qFbHqqi1svjK7QqZamuV45CjAtqlJ8tkO/amCfVf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNXPGKLCT5fixpHNPXjMLH2khdxdXB/83TX09gcQgLV/t6Ao9aX6eJ2ycNRWUfteXMEAaFPoXToGvWlCDqy1ONnUElK0+BzXvzPDpHHK/oEyOYu84DrkM3dCIdCQvc9/ZnkCZv8Gv+JJaP6Fzs3Vkr/oFofsfioX/KccgK0sb7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Az3PtgiY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Az3PtgiY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C969F1F000E9;
	Fri, 22 May 2026 02:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417173;
	bh=ZcZNaOA6CzyPeujch6TIAv4wuMs14rEOJHy06me6pPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Az3PtgiYLIKyLUCNLz6+UwzavyMEHkmvhJ4vglhJgFyj5rOn/jZpfaqRYCFjaH3Zv
	 oRsT/3O1Poi3s+jte12K6NWb+btVcOrt4QuYJgFbm9HgDbJLOcX8flMaOQ3vk7wQOp
	 2O5BXeI/WqBHp6j3/CYw5XNRYNzX95nauh4L0HcwBPV/JsHl8R6ZEFTD0sktQrpIuf
	 sd1Vq2ol4RkxQ/8PgQTcg25A1cjNXZn0chsUHld/BkhI1nTeRDUSdm7PBbEbORedTe
	 FPRdHhlBeSB5a1tfkybHWhfCdataqo3un+QViUz8/P1/a+74ryTe55rSKaDKsVXFbv
	 ITBsWKTmJ7ZPA==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 08/13] bpftool gen: embed loader prog BTF in the lskel header
Date: Fri, 22 May 2026 04:32:28 +0200
Message-ID: <20260522023234.3778588-9-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260522023234.3778588-1-kpsingh@kernel.org>
References: <20260522023234.3778588-1-kpsingh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the signed lskel codegen to include the loader prog BTF in
the generated header and the PKCS#7 signature scope. The loader
needs this BTF at load time so the kernel can resolve kfunc calls
by name.

Lskels generated without -S are unchanged; the new codegen is gated
on opts.btf_sz.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 tools/bpf/bpftool/gen.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/tools/bpf/bpftool/gen.c b/tools/bpf/bpftool/gen.c
index 2f9e10752e28..95dba5c53ef4 100644
--- a/tools/bpf/bpftool/gen.c
+++ b/tools/bpf/bpftool/gen.c
@@ -793,6 +793,8 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 	if (sign_progs) {
 		sopts.insns = opts.insns;
 		sopts.insns_sz = opts.insns_sz;
+		sopts.btf = opts.btf;
+		sopts.btf_sz = opts.btf_sz;
 		sopts.excl_prog_hash = prog_sha;
 		sopts.excl_prog_hash_sz = sizeof(prog_sha);
 		sopts.signature = sig_buf;
@@ -822,6 +824,17 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 		\n\
 		\";\n");
 
+		if (opts.btf_sz) {
+			codegen("\
+			\n\
+				static const char opts_btf[] __attribute__((__aligned__(8))) = \"\\\n\
+			");
+			print_hex(opts.btf, opts.btf_sz);
+			codegen("\
+			\n\
+			\";\n");
+		}
+
 		codegen("\
 		\n\
 			opts.signature = (void *)opts_sig;			\n\
@@ -830,6 +843,14 @@ static int gen_trace(struct bpf_object *obj, const char *obj_name, const char *h
 			opts.excl_prog_hash_sz = sizeof(opts_excl_hash) - 1;	\n\
 			opts.keyring_id = skel->keyring_id;			\n\
 		");
+
+		if (opts.btf_sz) {
+			codegen("\
+			\n\
+				opts.btf = (void *)opts_btf;			    \n\
+				opts.btf_sz = sizeof(opts_btf) - 1;		    \n\
+			");
+		}
 	}
 
 	codegen("\
-- 
2.53.0

