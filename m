Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292088;
	b=JtIqi+Zhi00Ydhh83Q87Hzcxwsk7owtE8teqmAKsCXZ+vGkDbPRihNn9yDzk2/+/7XWL
	 ZIDE5uVYtsTSMqroaxKyRLjCwsezzLeQtDxgllpn1U9St75cWZn2AAWpv18UqrjGSMJPw
	 SfuhIeHAPdZmL62mV9+ZkfGHzr12vuv7hNNw/SgMkoCI9TyQhj1zO+QXBwJCKLO3vQcfN
	 odK5N0bpNdN+mdiAZ19ketb5gW7Wje120bVWIFhq0E8QXUi4MsvPfEvp4eglZ4lLwPVgD
	 vL2hY6HvhxTU8RgWoWNXWvj5NHuhfLBZGz7mNv1IPV1VLuHFkvKh5Q+HNGKHPJLzkTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292088;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=67EUHCtqjfB+tccUv3dsIzzhumxwNVJ2yslHfCYJQGw=;
	b=JjbpWSE/J9Hr+nhuGLuZvbcBXDuBbKfNIi92QS9nmKXgmnytESuPlKw9RDqiykMLKvdE
	 finivJP4cufu/oSfHkldk3Zwu/vrPx6Q6VHyQt3ZgmHJOdP72+2VdVl5Qf5+JuVHNDK3R
	 I41tZCoijcDGpQE/ZxBM6eaOH9nv/MIzC5ub0Q4C5V/EDh3bp7mhj72TyvisQVEM76xm8
	 0jRa2dGfcr0jZg0mOEGh7Fnw/99tWn9mJ11SsgQo35fz2RDe2VkY3UtIoGBdzP6/9CFAF
	 jDLBtABDP9++ZdR2K0wrQBIQJIr7xBtDTzTZ9glsRoBJvgLOs0NKtQa3giqhvw0rDyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xw6ZHbkE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E35D606A33D;
	Thu, 29 Oct 2026 16:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xw6ZHbkE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82AC11F01816;
	Thu, 29 Oct 2026 16:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793292088;
	bh=67EUHCtqjfB+tccUv3dsIzzhumxwNVJ2yslHfCYJQGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Xw6ZHbkEFUGlYZcgEYEkT5Z2AOxg+q8msKR94rB0I8id9fYqWFHd8VXng5aQCEIKd
	 Vdzqaf95Mfg25eIgtZJapL7w6gdmf98YvewMqBdkHOrRWOrZUwHFV6yFfPVMXRST3F
	 IRyGtVzMZ9M3O1BHNnN6bpEVpCIybZSDjLf/GHIUpD+F/814h1yT/VHuqppEVKwUMX
	 W7G3a9mGX7/Wt0fVoXU+vP8c82x7oGdZTRd6ckS/MzuFFAOu9SBFB0AoOewplxoZrB
	 YMvqOS49jIUyM9Plhj5eAplSWHqvg+hanw5KOKomQIISjXXtL8tFDpA5uo9Hmhw3vH
	 bie+D0NogZQcw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 29 Oct 2026 17:41:01 +0100
Subject: [PATCH v2 6/7] lsm: fix the security_namespace_init() kernel-doc
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
Message-Id: <20261029-work-security-namespace_free-v2-6-65591dbba7b3@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LU/y2L5eVemTv0E47phbRKaXIXa34YzJQ/j0ZrgeaAA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9Lpc/l33tR/cyqb/pey/I1Ra8+ZOoeMWix9tC+iwLb
 3pzZ3ZpRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESMTjAy7NzzUba0XzMmceqk
 Uoey1A0z1zY9+ij+WT99lezu179+pTMybD/waE9bmgnzrCaJV7Pk9MtfuZ6aofqWd17D1Wr+8Oz
 3DAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The kernel-doc claims that the owning user namespace is available via
ns->ops->owner(ns). But security_namespace_init() is called from
__ns_common_init() before the namespace has been set up. Apart from
network namespaces the owning user namespace isn't set at that point so
->owner() returns NULL. And for init_net with CONFIG_NET_NS=n ns->ops
itself is NULL.

What a namespace_init hook can rely on is the namespace type and, now
that it is allocated before the hook is called, the namespace id. So
document that instead.

No functional changes.

Fixes: f675d2e95569 ("lsm: add LSM blob and hooks for namespaces")
Cc: <stable@kernel.org> # mainline only
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 security/security.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index 1e76c097b28d..81dac9e48a51 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3382,9 +3382,9 @@ int security_create_user_ns(const struct cred *cred)
  * security_namespace_init() - Initialize LSM security data for a namespace
  * @ns: the namespace being initialized
  *
- * Initialize the LSM security blob attached to the namespace. The namespace type
- * is available via ns->ns_type, and the owning user namespace (if any)
- * via ns->ops->owner(ns).
+ * Initialize the LSM security blob attached to the namespace. The namespace
+ * hasn't been set up yet but its type and id are available via ns->ns_type
+ * and ns->ns_id.
  *
  * Return: Returns 0 if successful, otherwise < 0 error code.
  */

-- 
2.53.0

