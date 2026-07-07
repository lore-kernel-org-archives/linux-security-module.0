Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2815B321420;
	Tue,  7 Jul 2026 19:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783452672; cv=none; b=I0SQK5t782ttpIt0WrFtWXiddrJxudJD8w1AltnbMdU4dv1AbK8WBmmpdZeRCD6E3aFKaWuQSjTCF0Sdm3S07DH69xul8KdkjvNuw68ICqEvsiGN08RatmaN8Pnl68YHIJwUYAi96PQpfEtMkdjyEqZ1R4HxIFSm8tJgKfWHvk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783452672; c=relaxed/simple;
	bh=x8XtNeRZvgX8/szMrzvnvHxfMPOTfjSDwOCtgahJIjs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e8uk287zqOJ+KlX38zgDNiknwLde0JED3n93DZ+wU511ZAN4sQakzOfvhznaffDrvegL8ppuJ4ErrgrnRJiAZ85QUgnQC5AkAQka9esQo/+QgBno9WjRPmQ4KeDe9xc/OJRtoEh+rKFPu5PjZG8gv/Pm3NKc/7lgmMksuIGyfh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=CydeNPqR; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="CydeNPqR"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=K91/uupA3BSM2SUVEXpcffcMKiZwTtNrMEHJT3/jLt0=; b=CydeNPqRwkbZKOyECdYC7fwXJs
	Xag9XehRuc9V93JrR+0ChP6DoaXokEtiWscsInwv4+GmdwzsqNtv+w/gzKA7dv6sfpskhVuqGrvio
	dkc4wAX8diLVJiHXOM9iskV21et6yyjISekR//DJel0aU63lfi27Uw2RaXXABV7n/jAdptkTOpJ6y
	AB6EDKZFnDCCKEOQKPcikK9U19OkD3kj22JZF20wURfb3xnmIuFFwh7EPYdAN5OmmhDwUxMU/LqUe
	9p4RFP2IuQNsEBjLtFzlVxuFzvsfaQjynrClbAejCZ+ORyQ7O+xpbbj8IvnYGUGvBoITFlem7VH0X
	GSpiYrpQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1whBVd-000LXC-0v;
	Tue, 07 Jul 2026 21:31:09 +0200
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
Subject: [PATCH bpf-next v5 4/8] bpftool: Check EVP_Digest when computing excl_prog_hash
Date: Tue,  7 Jul 2026 21:31:00 +0200
Message-ID: <20260707193104.350066-5-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260707193104.350066-1-daniel@iogearbox.net>
References: <20260707193104.350066-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28053/Tue Jul  7 08:24:37 2026)

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

