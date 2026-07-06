Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D123290AD;
	Mon,  6 Jul 2026 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346220; cv=none; b=eQp0YR6X5qT6fYA0TBVcmGCohZDwo5FZNrACbUEvTv3zeBo3sVuB78Ywbv2gWqFNsu69fe7V2iMRFz5tB8u7Fq0WVDIbiibh/fm1IAeI5o39k6WLsJINIhHYAu2i+79JNDcWk0g9KhnYLAsjblFj+XadkT82XR+FPzxagntVIso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346220; c=relaxed/simple;
	bh=x8XtNeRZvgX8/szMrzvnvHxfMPOTfjSDwOCtgahJIjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFmg+dSY85GvOk2I6U+t938jnYWd2UoSWCX5HxYWlNdrLv6jJBFDzOHNiWIajIOJxKMQ/ncqeuh0Gyxi/iToXskyUihXRg2ZNMjE4spVdgDZN+ovmX2lkD7HRdHGKL6Pt8z/fvmhBOehxu5dxL/hE+APcNt9vMzmhr5StkXqn1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=MB3JFYXV; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="MB3JFYXV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=K91/uupA3BSM2SUVEXpcffcMKiZwTtNrMEHJT3/jLt0=; b=MB3JFYXV1bN6Ly1Gg9Cc9OABU1
	cUIhM0lukMltUsugoWpbY7Vg8ni2ujZs4wbEKxCyGix0pkLM7/J5f6hWy/sT6Ri97Dgwg7mGANgug
	gozgTP2h830jMbAjzo0Y/QdldIFCFEmQOLE6iy5dIBwFcM1x89AwcGUB1pWhOWoVUwO4QbtlP9FMy
	wBq9PzKIQOAy27yjDelwxTW3D2H1/znfo5rLyJyQ9eIaObwryW/CnWLQrKQafY2Dlm1BCwuBpSt/0
	dg8w3DzpDivvhB/s2ogE8CDckgrE48lIsPNKWQu0b99EVGuRzV5hwSU9d6dSdg9Q5j2+XVSMqnKaI
	R6TxkpRg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wgjoY-000E2V-0q;
	Mon, 06 Jul 2026 15:56:50 +0200
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
Subject: [PATCH bpf-next v4 5/9] bpftool: Check EVP_Digest when computing excl_prog_hash
Date: Mon,  6 Jul 2026 15:56:40 +0200
Message-ID: <20260706135644.326006-6-daniel@iogearbox.net>
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

bpftool_prog_sign() ignores the return value of EVP_Digest(). If the
digest computation fails (context allocation failure, or a digest
fetch failure under OpenSSL), EVP_Digest() returns 0 and leaves the
output buffer untouched, but the function still reports success.

Fixes: 40863f4d6ef2 ("bpftool: Add support for signing BPF programs")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 tools/bpf/bpftool/sign.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/sign.c b/tools/bpf/bpftool/sign.c
index f9b742f4bb10..1257dba8ef2f 100644
--- a/tools/bpf/bpftool/sign.c
+++ b/tools/bpf/bpftool/sign.c
@@ -175,8 +175,11 @@ int bpftool_prog_sign(struct bpf_load_and_run_opts *opts)
 		goto cleanup;
 	}
 
-	EVP_Digest(opts->insns, opts->insns_sz, opts->excl_prog_hash,
-		   &opts->excl_prog_hash_sz, EVP_sha256(), NULL);
+	if (EVP_Digest(opts->insns, opts->insns_sz, opts->excl_prog_hash,
+		       &opts->excl_prog_hash_sz, EVP_sha256(), NULL) != 1) {
+		err = -EIO;
+		goto cleanup;
+	}
 
 		bd_out = BIO_new(BIO_s_mem());
 	if (!bd_out) {
-- 
2.43.0

