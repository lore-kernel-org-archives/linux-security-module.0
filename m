Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292072;
	b=Q6MSX8dXJEtHi1Rh5hB52Bmy/lFpl4K9BwwY5Aeqs/U21i4sdtv1xZO7oLnefAz29mFa
	 9oBZk8juBGoAcHge4vRnHEGAw2e+/A5svvOHBpVk9+/hCjZShnrscLstYPYdS8zIU4zx/
	 yC48rq8q6BQy51tVRc9JguVo+KDAc2YZRaya+bsKSSxe+ec6ho0NDhH5UiQAy1TmKZFi1
	 pKDCQDPts8i5hmOhgb7lVZWktmXxX2SBMMQYEksFOlTfeoQ08tcmyiGjVVlrDbu6hV3nr
	 12hC7NTvQYxtPF/eJsDAH6WYFB4qCOeuX5NnNlFqaTOOXPueJfmGSfUcnIOeh5hAbVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292072;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=vZbI+36cuLWKSblKMENitfEJ+yoA6aEpBQf4/oO9DlE=;
	b=LtET9yDhOHr0PMYPGQMkHhw2l2a/D8NNfd+KCgYH0mhUgtJhEfClJm2OIrGi3RRsgdOT
	 J+8n+xqBaBLcAwLoGBY6kqAg8Ok/RK4kPvFe6sjstq4m2d3YzYMtgkihAZ6PGMePk/Huc
	 5N6uQYEei6Uo7pL0P0JSFnPWX6bn4u7MQ1NaqsgnhHiEYODY1NNyvDKebygHLxHkwCaEo
	 6mroc6zkYEF3+TNGHLzwQ0oXbN+mltpzWJPdyM0i6QhmJy0wey+jPJnGhtMHEl8Xg1UN7
	 ZJ5TSheaCAya4T5QmgWF2bjp+cONd4W1z/uYVWk8mUL9+dTmlq2HqNuOp4mP6MJ7Ywg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCFxxLBM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996B1606A31A;
	Thu, 29 Oct 2026 16:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cCFxxLBM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8672E1F01824;
	Thu, 29 Oct 2026 16:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292072;
	bh=vZbI+36cuLWKSblKMENitfEJ+yoA6aEpBQf4/oO9DlE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cCFxxLBMp97ap//WtLS7w322xpRZpmLs68Q4jIBgA/FMQa/L4OcXOSJa/qMlYkQDd
	 hbpbmqBQesfMi83aEbhOe9t0rNHSHIoWg8lH1bog9wq5Ftm0lpTlkADBu5zCrFCkMH
	 Bxnk3cX8TQap035qjDI9iX7pOBdWyN8ki8e1UMce0OpUbKVEIlpzzDceZrwOScoJdZ
	 Wjak97x8JGbcwVv7AyLpxv76z4rtU3uDbLI6BIkCtwthBAwsC3CVtC8yHqiIH/ImJr
	 Yyfc5vN7Ga9y2uFjSBTk9jkR2yZTqkUEiECTmqHIvChMuryPM4bBGu/YH4ucHLZdql
	 NInjk1oYdSO0g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 29 Oct 2026 17:40:56 +0100
Subject: [PATCH v2 1/7] lsm: always call the namespace_free hook
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-work-security-namespace_free-v2-1-65591dbba7b3@kernel.org>
References: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
In-Reply-To: <20261029-work-security-namespace_free-v2-0-65591dbba7b3@kernel.org>
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, 
 =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack@google.com>, netdev@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2360; i=brauner@kernel.org;
 h=from:subject:message-id; bh=C2BO3VYPrmNUuuCqz/uwcSrR57rLhf95j9OE/k19Z48=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9Lpdft1C7ZEXXia0LJ08oeMv/l0UxtPXpLN1ApvBtS
 s9ZnzAkd5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykSZzhnzWHtcub++/CXX8q
 T2uauW9XfMhMpcCvdo0vK6yWaIRoBTP8j1b8c+nipab6Fbnn2TVXqDQ4/J/7QqHg77cs5u85Kpr
 +XAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

security_namespace_free() returns early if ns->ns_security is NULL and
skips the namespace_free hook. But ns->ns_security is only allocated if
an LSM requests a namespace blob via lbs_ns and currently no LSM does.
So the namespace_free hook is never called at all.

Landlock only uses namespace_init and namespace_install so it doesn't
care. But the bpf LSM attaches to every hook and a program attached to
namespace_free never runs. We want to use it in systemd-nsresourced to
get notified when a user namespace goes away. Right now it has to kprobe
retire_userns_sysctls() for that.

Note that a bpf program can't work around this. The size of the
namespace blob is fixed at boot and the bpf LSM doesn't request one.
And security_namespace_init() allocates the blob before the
namespace_init hooks are called anyway.

The check isn't needed. __ns_common_free() is only ever called after
__ns_common_init() succeeded and security_namespace_init() only calls
security_namespace_free() after the blob has been allocated. So if an
LSM requests a namespace blob it is always there when the hook runs.
Call the hook unconditionally like security_sb_free(),
security_file_free() and security_bpf_map_free() do.

The bpf LSM attaches programs to its bpf_lsm_*() stubs so fentry on the
stubs shows what a bpf LSM program sees. Booted with lsm.debug, which
prints "LSM: blob(ns) size 0", and created 100 user and uts namespaces:

  bpftrace -e 'fentry:bpf_lsm_namespace_init { @init = count(); }
               fentry:bpf_lsm_namespace_free { @free = count(); }' &
  for i in $(seq 100); do unshare -Uu true; done

  before: @init: 200 @free: 0
  after:  @init: 200 @free: 200

Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
Cc: <stable@kernel.org> # mainline only
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 security/security.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index f6583d507395..1e76c097b28d 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3412,9 +3412,6 @@ int security_namespace_init(struct ns_common *ns)
  */
 void security_namespace_free(struct ns_common *ns)
 {
-	if (!ns->ns_security)
-		return;
-
 	call_void_hook(namespace_free, ns);
 
 	kfree(ns->ns_security);

-- 
2.53.0

