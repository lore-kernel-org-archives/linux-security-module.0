Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451773B0AF0;
	Tue, 19 May 2026 20:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779221380; cv=none; b=Vx5v5nS23AZJFRuXRmqTa2LbcsCBzc85Xj+7TOFFtrQChAKin9GPbE9o5gkOdQgxBii1++50FHg8Lt3rWCiGiiClWiHeosYwuqOUnQOfw00L7kllw8kcs0b3igk8UTiIRhbBewxy67GIu5YXJaQK6J4fba7nrzBhmlUM3X0cHvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779221380; c=relaxed/simple;
	bh=DK/2lsORPLzwBN2/kK76cxy++/gAwmQ/2uidG2vMd9g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y1B6ftQCum7GkQ7ls8rWnT73vd8zv30C1KTBfB2BwsgnD4LB3FNSIT4j3oPveSBJZayDOXGPZiVo0THh6XZmdveC/8Tr5yFc500IK4ei8bFT492Jj0NRiW95fCZiiMdW3ihpVTilayuvxdfe8LwCS+a1soY4QRJsXNtBwhdORn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mMTJbi4n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mMTJbi4n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05541F000E9;
	Tue, 19 May 2026 20:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779221378;
	bh=YI2mdONzYKZOxRqC1fr+F+7SB5OH+cuh+BqlVGdL64g=;
	h=From:To:Cc:Subject:Date;
	b=mMTJbi4n/BAH0ZWUWnrjfE3VmcZTHIwyGPdXhKytYwsRit0/Q0DyRvFebd9INLyvk
	 6341xscp2jLbx2UxUDPU8Z78DMES+cCTDM5U1raITzq6qED4NXKIuxzwIwHE+DFzmg
	 3X1lqLq6aRv2twu/bF7FskElQUCbuUCkjfMj9leQsow8jPLHIcEHXxa9k4Z8MbfXRj
	 HSn5p+bX5xdn7p6zRaRbcicyxCTPOPcKTTFxKsj5JlHacmcZ7zaa1qqeHuAwT4O79f
	 FIgJiyqvzmCCESB7jUQaHIIenFXOvY6W9uM9Hvev4LV87LG5J9AGsPY8acK50khtzl
	 uq+VKFOKojwHQ==
From: KP Singh <kpsingh@kernel.org>
To: bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	Xianrui Dong <dongxianrui1@gmail.com>,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH] bpf: reject NULL data/sig in bpf_verify_pkcs7_signature
Date: Tue, 19 May 2026 22:09:33 +0200
Message-ID: <20260519200933.30752-1-kpsingh@kernel.org>
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
 kernel/bpf/helpers.c | 5 +++++
 1 file changed, 5 insertions(+)

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
-- 
2.53.0

