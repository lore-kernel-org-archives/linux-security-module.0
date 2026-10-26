Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008653;
	b=mLbAmCJ5nPQeuLAyxm+J24TCvYO7IetEZ/bsCtn9qb82Po1j4i6XTVrvGuRHQaxFhIG2
	 hgvwSutpRTD/cO+adl9FNdSSLVSiV54zBEuGqt1/mqBlzLpNm5g0fL8gBFoCpnYZAb7fU
	 1mN7Km9tROaWW56JsAxZvsGnZCU362rxtBCc1R7i3RpyjT0HWCll5IT/Yp+yCPzUY9vIw
	 IPOOkN6RutjIvZsFx+vtV5Jb/+8PMjQpVRP0YSc/pa3VV4ffodYd9kunvhLmD9yavBQeD
	 6+USckr4Goszzcoztn//TLj3Pn6O+CdF1DiK1RWwUr+wCSZVxpI8ZdFVSeTIriNXtRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008653;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=6GR6gp4o2Xon7w0PknX8WYUm34TsbdlDzkFce1Jj8Ec=;
	b=FEO+HuX0P/h/pKCE0Ad+/ZtqOzAecIIwFdmNkzjZ8A2m1jWOeSGMOTvcY47rvDkN+q5d
	 JY90C0dahBd9tCKDTJnoB2/jqGhIJNgEZ1ax1VxH4kImC5OKEFjwtPjp7oG35niimxt35
	 rzuHZSnB2RIkq0/1Kr8348k/GBK5JVeOpJWxR7Fn4dhIsELq7UuF7PSKL5MJPeys1BgFe
	 0mZbStSvD86Yjcrt8szxe/2poEUvmbG+f3surMtXczCi6ZrRXic6DMf03fsN6FwC6ms7x
	 QAMFgjMBEHAR/JWe0lnSWtQNeW1+hDis2ITt5vO9gC+oaUjNIgAO/CNFAtK0twMuKaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHDSVryf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 087E4606A32F;
	Mon, 26 Oct 2026 09:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BHDSVryf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E4D1F01825;
	Mon, 26 Oct 2026 09:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008652;
	bh=6GR6gp4o2Xon7w0PknX8WYUm34TsbdlDzkFce1Jj8Ec=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BHDSVryf4GLK3sXVHcPLvOaJcnmAVYfu936DrHgR53iW8mrV6JXgJ2jV/uN2T7SQm
	 NTnp584NtvALaZnZebUbtRTFTiUdtTGOaSZqcTzjd7Va2F6gIdM/qiCUbF5YHA8m30
	 wELvHA71Npxq+LPmTQ+zvJAs1/tYr3KJSxiI68POLbSYWWUDA3Ls8hLQgSdIZxulx5
	 yy8Rd7bONGWeY4Qcutid+QXpQD7pmx0N4ODxPzI8KgTMxiNdqNDtGIiQam4mChUSBS
	 AFRoTJW6/udM5GvdbhKZzgJjhw1DvjvIAyUSh/ubaF2YWu00MUnC7kfR3XRRhhMURl
	 gxH7dYYcDjFHA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 26 Oct 2026 10:57:10 +0100
Subject: [PATCH 2/8] bpf: don't mark namespace_init and namespace_free
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
Message-Id: <20261026-work-security-namespace_free-v1-2-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2046; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1fgMDKeXBEiBfIQuOzNEWDEpf9jfJ++UO6hxrW2RggQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdV2GaMa3S6/AjnxjTI3kiiQaVnMtZlgWtE9q85EVW/
 OLV21cldZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEwkJpHhnyETb+fkb3xn12y4
 fT2ibZOJfkiR2c3nbf6cFaX7tz034mRkuLJur9ptxxj+gsJ3mV+1t8k23zVUi7nh8IvD4EXQiot
 3eQE=
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

