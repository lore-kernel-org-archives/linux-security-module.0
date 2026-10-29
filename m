Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292075;
	b=BzMiUbUDbc3QqBw0fzzKMUiWVY4HsYD0w2Hamsezh3Jpyh4y336WieehFUNmNc/3YJKj
	 IK+TMm9uS6LgOHp27XUp9SPM3hlkqkuk9ZHVdNqlsYZoDG1lf+tjBVK+HI+yEimTFUTcm
	 CtVmNp0w8TkZIcibeOJ6ZKhuADNrHntrNZpAlsglTTGXIz71pEmZut3DENL2ZYXk3+mKb
	 t9eX8CjVTBZ46WmEiJQ9JIIf9oCbkzCYaQPTSqhFZsw5ZYavLr6gn1Ys5VwSeqsiZnSNU
	 uQS+LdoFJbL3syQ18Sfdu4xWOGrQ9ieij3B//g3x+1HEZ6oDUbf9AmL1yJoY8woRqvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292075;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=l8KMUSDuJM/tAJiQhZ667p8aiwFCnFU6ppauc310Mso=;
	b=gABUwRkUXwN7Fn85k1SR0dzM4cjbvnv5vBZX55Nos280Zda9pArOQY0TNBnt8oHE8nNQ
	 u0VQoDx6DcOE+6TpDGR/gOCOBX7/wyZg9LSDLWfB/qhcHhXrcsp2jv6WL43ER8IpEbc1P
	 rwjVfUz46SA8lERqvkFRz8BsD0He9uZ4egjYQpu2fFUtc5arylPwOISad3IR+ywC4ygOZ
	 cIsycJEu6aIoyH3msewQ/5GoRL7E4a8ymcGRJFkRPGYQ0KTpML+S61enbUn/UB3Ql04Nr
	 o19RGBH812lCKB+Lyx9d2apSjDUH+IVXaSu8QgSkJMvti9dXwnJk04Qypf5OLO95FZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6zGjw5w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C6606A327;
	Thu, 29 Oct 2026 16:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=O6zGjw5w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B73601F01816;
	Thu, 29 Oct 2026 16:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292075;
	bh=l8KMUSDuJM/tAJiQhZ667p8aiwFCnFU6ppauc310Mso=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O6zGjw5w2bqMFuVibwsbkEuz9Ajuqmeou1CrUQPv2h3CggGcVDfRZAAsMVEg+JZxz
	 AltOI94nKGhMPIAAPARo5m8MC8Dvy8cDUlURgs2hK5m5xBnajYu0/PvB8GIcg9ZHuH
	 4NjAvbJSDNE0VdHH74BUq6SMdTwEsmo/abL465Pff7wYujYzWxgnamCe8jmKFccCRo
	 BBpPYthn9opBLQskYpixSzQ/zBbBKV8aQjTq421t8Xdz3q/RyXRS7FR7+sqvM2FJG8
	 4fVw2mL2tLURFSvXNivUatO99dvbYY0XOJWbPXZ+2nnMLOCBwzTJRci6PWiIjItItt
	 AVZK+uOmJCrVQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 29 Oct 2026 17:40:57 +0100
Subject: [PATCH v2 2/7] bpf: don't mark namespace_init and namespace_free
 arguments as trusted
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
Message-Id: <20261029-work-security-namespace_free-v2-2-65591dbba7b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2194; i=brauner@kernel.org;
 h=from:subject:message-id; bh=k2PlNlAKArt6qN+/fHgU8WckYvJZ6f/3TOh5KXxG/mQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9LpdXZLM/m//Ohz+U8bvlHUkDtecvt/NWP7l7TK46K
 ve7Z/nXjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIm4P2Rk6Dn3l39b/I8siexP
 Tx4GXnl3e+aniqfdz4s+L7K7vWVDnwcjw6xy6cbd/a7NjQ/T1RY0MrybMu1PvQrjKo5LN/rUXC/
 v4gcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The bpf LSM marks the arguments of all hooks as trusted unless the hook
is listed in untrusted_lsm_hooks. That list was added in commit
c0c852dd1876 ("bpf: Do not mark certain LSM hook arguments as trusted")
for hooks that are called on objects that are only partially set up or
that are already on their way out. The namespace_init and namespace_free
hooks are exactly that but they aren't listed.

namespace_init is called from __ns_common_init() before the namespace
has been set up. It isn't in the namespace trees yet and for all types
but network namespaces even the owning user namespace isn't set yet. If
any LSM rejects the namespace or if anything after ns_common_init()
fails the namespace is freed right away without looking at its reference
count.

namespace_free is called from __ns_common_free() when the namespace is
torn down or when its initialization failed.

Currently there's no kfunc that takes a namespace. But once there is
one, e.g., for namespace local storage, a program could take a reference
to or create storage on a namespace that is about to be freed. So don't
mark the arguments of these hooks as trusted. namespace_install is
called with a reference to a fully set up namespace and stays trusted.

Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
Cc: <stable@kernel.org> # mainline only
Acked-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Daniel Borkmann <daniel@iogearbox.net>
Tested-by: Daniel Borkmann <daniel@iogearbox.net>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 kernel/bpf/bpf_lsm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/bpf/bpf_lsm.c b/kernel/bpf/bpf_lsm.c
index f58dce888ff4..468e63dbd922 100644
--- a/kernel/bpf/bpf_lsm.c
+++ b/kernel/bpf/bpf_lsm.c
@@ -411,6 +411,8 @@ BTF_ID(func, bpf_lsm_bpf_map_free)
 BTF_ID(func, bpf_lsm_bpf_prog_free)
 BTF_ID(func, bpf_lsm_file_alloc_security)
 BTF_ID(func, bpf_lsm_file_free_security)
+BTF_ID(func, bpf_lsm_namespace_init)
+BTF_ID(func, bpf_lsm_namespace_free)
 #ifdef CONFIG_SECURITY_NETWORK
 BTF_ID(func, bpf_lsm_sk_alloc_security)
 BTF_ID(func, bpf_lsm_sk_free_security)

-- 
2.53.0

