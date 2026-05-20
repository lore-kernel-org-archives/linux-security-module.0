Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1C6302767;
	Wed, 20 May 2026 02:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779244866; cv=none; b=nqcY9IfnpVngLIDH6QbTwzPM1UxdSaainoQZSRyaAg7+f6Eda+UPMvrFeaxfNXdvUDbAbttNRYXlAGz4sUmJ33pDgk3OQO1HGy3KwnPmsOaDW3UiEyid1huHazfpJLUYHp8ttmjgsjUuwBwf3YfkW+qw3w4zS7Mg4mjSE05SY/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779244866; c=relaxed/simple;
	bh=6ua6dP85AQ4nt7D+K3js7WWrh6A4zjLkDywplN3PGKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=btH/SkfwOfwHM4HlUXfkCEti8LtfV4qh6Gn0Hz7BmdtHBX71FieXZuwBI9UBX2dUwuSjXprLqg5rnBJ14rRxUogpixAstW/PippKev5Qksa4zE/gmDJguuwf29+VW1BTQ4g8sZu2y8ppwlfyB0RVNU4KRCc/tdUB+pfPyfomiM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyFsjlax; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyFsjlax"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B49AC1F000E9;
	Wed, 20 May 2026 02:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779244864;
	bh=zjuBdR5RduBCHJPTdjqDQAN29h+i6CofW+fqVD6Ur5U=;
	h=From:To:Cc:Subject:Date;
	b=hyFsjlax2RJH1df6Mi4nleaWvlH0R0J/97bhiUi68OnAqzPicf2kUR0UIiWBcIRps
	 v5O3xHzahZi+RBMbY7ivw9zyvd/jaSwoFGuqJR6QMUZQXDxIYU+FIoczMIWSX4VAgv
	 JWJLHKc+B8mKRuyeIuWeQcFULjfGGbr2+lqEDZxC89OF33np29E//fR4WLNtw4MJLq
	 jh9pRX+eNNDdIsvsSc0d+toQrYAjUC9nGm4+tNoC5MmRUt6jrgNN73BVfYsSQAaOTJ
	 orslEbZpsQz2PBWhuAzO7m1WJ5Bj+9p6opDi4uce718OXCdixAGvproETgOP2XQuij
	 It6qtDibWf1cg==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	Xianrui Dong <dongxianrui1@gmail.com>,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH v2] bpf: reject NULL data/sig in bpf_verify_pkcs7_signature
Date: Wed, 20 May 2026 04:40:59 +0200
Message-ID: <20260520024059.313468-1-kpsingh@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__bpf_dynptr_data() can return NULL (FILE dynptrs, any non-contiguous
backing). bpf_verify_pkcs7_signature() forwards the pointer to
verify_pkcs7_signature() unchecked, causing a NULL deref in
asn1_ber_decoder() reachable from a sleepable BPF LSM at lsm.s/bpf.

NULL-check both pointers and reject with -EINVAL. Mirrors the guards
already in kernel/bpf/crypto.c.

Fixes: 865b0566d8f1 ("bpf: Add bpf_verify_pkcs7_signature() kfunc")
Reported-by: Xianrui Dong <dongxianrui1@gmail.com>
Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/helpers.c                                        | 5 +++++
 tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 2bb60200c266..b5314c9fed3c 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4241,8 +4241,13 @@ __bpf_kfunc int bpf_verify_pkcs7_signature(struct bpf_dynptr *data_p,
 
 	data_len = __bpf_dynptr_size(data_ptr);
 	data = __bpf_dynptr_data(data_ptr, data_len);
+	if (!data)
+		return -EINVAL;
+
 	sig_len = __bpf_dynptr_size(sig_ptr);
 	sig = __bpf_dynptr_data(sig_ptr, sig_len);
+	if (!sig)
+		return -EINVAL;
 
 	return verify_pkcs7_signature(data, data_len, sig, sig_len,
 				      trusted_keyring->key,
diff --git a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
index 8cd298b78e44..04aaf4c9cf5e 100644
--- a/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
+++ b/tools/testing/selftests/bpf/prog_tests/kfunc_dynptr_param.c
@@ -14,7 +14,7 @@ static struct {
 	const char *prog_name;
 	int expected_runtime_err;
 } kfunc_dynptr_tests[] = {
-	{"dynptr_data_null", -EBADMSG},
+	{"dynptr_data_null", -EINVAL},
 };
 
 static bool kfunc_not_supported;
-- 
2.53.0

