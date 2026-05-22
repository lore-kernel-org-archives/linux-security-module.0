Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4593C32B125;
	Fri, 22 May 2026 02:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417178; cv=none; b=HlOJDC8iOpe7RlN/wBb5eTPLsphWBzCSd2bIBT3a/crG54gyV7mC6YpUXj6qE+jqAZxXOYO1didfdynaWeLnHRDC+0GHRwyygYiwe1F8iXxUC8gTftPmP8KBD4fqqgY7DA1ZUNq2FfgxjuJ7kB9trRfPGAjY2l742Hrfh34UU+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417178; c=relaxed/simple;
	bh=jHsiWuhInTnstNLH+P/hQmQoc5/N6bzqq5j5EgF8WhQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JH1UPS580J+T7VcpLru4/aMDhKSGUToUCYQlCv7GITXKxBIMfmF0QL+AAwZ7JIxAmcZ4XS1Y/Tr28mL4UQoaIBlRIEidnsUqMhgbZo+7KIgFEEqZML5lUiTLv6JytI0cwTO2Cv+/al+47XcdElSS9JwJvmQI/XL/xB4uOizcC1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3oVBl5K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3oVBl5K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2AB21F000E9;
	Fri, 22 May 2026 02:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779417177;
	bh=HvJKEpYN2JuGnsw977oKnolBqDqUs99XLkLgyua4xS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k3oVBl5KE9dbBW4r8ClR/I3smKFu6oDZavk7ddPfjj6j653QbNWTSkva2LBo1+Px4
	 kaTGg8nUgqEhx+VwLLoloKWCik+WgpA5JMs71Q/dA0tFHieVknQpaG2OZrVTpbhyX8
	 b/ntI4HJ+SgVr65DqxQgP8BSjiCGnzTO0+Ku2D5OFTdP7O2I0wgU0KQ+c0xoS2r2N2
	 +YMJjOUW19uGpTStagnSsbZvkE7w8OPwEKk1pZUAezfHNAxFEn1l9qsT9w9rnuiN95
	 HYcts6cP72BpOtu/vnQCHeu1uIuGRMQvnjUB5BNkc6tumvG2M1QSZcgARyJsn690rF
	 C774vwsroI2cw==
From: KP Singh <kpsingh@kernel.org>
To: linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	James.Bottomley@HansenPartnership.com,
	paul@paul-moore.com,
	KP Singh <kpsingh@kernel.org>
Subject: [PATCH bpf-next 10/13] bpf: invoke security_bpf_prog_load_post_integrity from the metadata kfunc
Date: Fri, 22 May 2026 04:32:30 +0200
Message-ID: <20260522023234.3778588-11-kpsingh@kernel.org>
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

Call security_bpf_prog_load_post_integrity from
bpf_loader_verify_metadata just before promoting
prog->aux->sig.verdict from BPF_SIG_OK to BPF_SIG_METADATA_VERIFIED.
This lets policy LSMs deny the metadata-verified transition.

A non-zero return aborts the kfunc and leaves the verdict at
BPF_SIG_OK; observers that key off METADATA_VERIFIED never see a
verdict the LSM denied.

Signed-off-by: KP Singh <kpsingh@kernel.org>
---
 kernel/bpf/helpers.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 9afa71fbcac3..52e71fb6e200 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4300,6 +4300,14 @@ __bpf_kfunc int bpf_loader_verify_metadata(struct bpf_map *map,
 	if (memcmp(sha, hash, SHA256_DIGEST_SIZE))
 		return -EBADMSG;
 
+	/* Metadata integrity is decided by the checks above; the LSM hook
+	 * is an observer of that verdict and may apply policy (e.g. deny),
+	 * but cannot vouch for integrity it did not verify itself.
+	 */
+	err = security_bpf_prog_load_post_integrity(aux__ign->prog);
+	if (err)
+		return err;
+
 	aux__ign->sig.verdict = BPF_SIG_METADATA_VERIFIED;
 	return 0;
 }
-- 
2.53.0

