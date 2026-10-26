Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008665;
	b=YzzobDX7DVD2728AJFA32ho5F7h9l/7lZKr3oaQku5xyB+QnxRg72KFtL+BmOaaWMugH
	 laC1dSMAPKJWv5XBTx8KwBjdnKzgXFGoixAu+7NoF4vZLtNC+8WEWIj3YtjD+W7+afhjX
	 rLmlHq6KEy9gVwcEyPIee1riXcZEA7EaYbTFgXOEl43tHOuKktCZ3PKXS+OzUrLBfXC8v
	 wtV+ag1T66RtiL3mwBOvIz/hmi7lZMj7+SqA0x4uInggRk5SdYK1IvxmJ07Wm0zDYAFpw
	 bV4eU+RoiAB+hpVHk5hTPkqCsCgy35LP/vj2SSqU7ZM4TfpzkZolFPzo9O6aUZNz8rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008665;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=67EUHCtqjfB+tccUv3dsIzzhumxwNVJ2yslHfCYJQGw=;
	b=tIbtLCBYsMttk/i/kknkZtJU0ds9OWdFc0KKx6icF/l9Sg+sVQtz+ukWcPjFKcuBY23X
	 hiUOZv/yXqSS0xm2+A7/THo4k+DWgrFcS+6Be91g1qYRmBnna+jE0KoNri5uL/hJEQeJ8
	 NynzlQSRDAxmxffpKHJFi3XrKP+0r02brXZQ63C7zmAHUZ9Ptf64hcBLaMgnanBOssTx/
	 JcfyfaN7ncyY1uPAf3rHI3aX57Y91M9YnuCZmPcua8WKfGpdANDmLo0pLLUWv8WAGvOlw
	 4R8WTsdgLUatrINi6gKbSAGrZpr9ddTrh4kxXcX2yYzeA+SEroLc8B7AbOaC8GXbnHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ied+n71Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83564606A337;
	Mon, 26 Oct 2026 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ied+n71Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 188431F01181;
	Mon, 26 Oct 2026 09:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793008665;
	bh=67EUHCtqjfB+tccUv3dsIzzhumxwNVJ2yslHfCYJQGw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ied+n71ZmjGazrwxKadThDhjyVKsR3+gZcKoUUSm9mbeQjlNHRUnvFPsARozjPoAL
	 0mkK6P3UPOdYMwoqOslfMaChzmglmpCUM2v/exNkO0wffkfRHJ5xChfgaTztpfVBuM
	 QfzPy8lNfupTfn7m6Yf7UZ/JuIDwk0HoW2wqPpcsE6I0yKSuosRkd2tui5PGBRdo4h
	 GY03jkOkmNIXx+Y/+4TUgK9yHtwP0WyBXLYAHvD3PUGuRymsqxaFVdGbOovZAxKvMB
	 xgEfyg19aH8BXfdR3e/FAi9syBGEflLN++Am+4cSEKbHN0l/sj5sA4BJgwUZPxuHMZ
	 iB75yaGNUP4Jw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 26 Oct 2026 10:57:15 +0100
Subject: [PATCH 7/8] lsm: fix the security_namespace_init() kernel-doc
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
Message-Id: <20261026-work-security-namespace_free-v1-7-ffa3ebbf71bd@kernel.org>
References: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
In-Reply-To: <20261026-work-security-namespace_free-v1-0-ffa3ebbf71bd@kernel.org>
To: linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Paul Moore <paul@paul-moore.com>, netdev@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1633; i=brauner@kernel.org;
 h=from:subject:message-id; bh=LU/y2L5eVemTv0E47phbRKaXIXa34YzJQ/j0ZrgeaAA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTdV2H6fOlDt6bK5Lk2F25pP+ZY6Pf9ievKAofLBg2ct
 6P0ctqLOkpZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACYyVZeR4e6JTyYx7FPPioTs
 C0s/c1rGM37HqR4ROXHn42oCKuK60xj+Z/0ukk1RO3F8Tbmo36d+FfaF69e7zfxb0/bvUeru3JC
 17AA=
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

