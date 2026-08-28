Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501C53DD871
	for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 08:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787904497; cv=none; b=uozuuxI1LupsyQILmjRklIwsQdbja1i00B2Pgm8B8mzp9GL20IMWI4iiRpYGEsRMx8Bqtryd/bOueGm7d6f0spc2gYg8pMRVrv+VGd+IS7kpXfybkKL+7OE+KarMjKXtYRvb6/AnMSSZOxxoILMEbnG2RzYGcygTA5O04AN5RPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787904497; c=relaxed/simple;
	bh=HuGnxPkrP++JhIOty86OoEu+y5wkYW0oqmS3RUjsEAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=obABBYcvRNe55JG5qnnZ7nCvolG822CBY+br+1n71Y/8RcBc3z5p69+fw/n7OeEF4aYnglRLi/nRE4inwa2T4mL/yBr+dJb01nGex/tmFdSg+BnD5WvaiFKKghuoVIej0XjVkva12UKxCAl9T7RiW1hy0AQUUuPi9GBHCzdUQME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hSRRfkyU; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hSRRfkyU"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d6f55a7089so6089285ad.3
        for <linux-security-module@vger.kernel.org>; Fri, 28 Aug 2026 01:08:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787904493; x=1788509293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1RxSzc/tdhLrfiCMdxDqFkVCnqjmbHn0IwP7JFLZaWY=;
        b=hSRRfkyUAu3yP+2+eTeRmP9OPpQScDPVewxKcgc5xkkmliaX/W/2KfTYPGhEvYCxw9
         4+g0vyEa8DkgUzE8wtl3ZgFmrBOg02794N6so2XwjS55mSG3R4LiO1YVI+CSZwLYV47K
         HWWsZq4DP+or7Y1A/auFAbxFcwR2Wg8gf7pbSvJDtxPUJumaGKuPSTYDdK+1OtfebHzj
         ChCSVJZjHscM0LhwwKSS0OCIEMPyBy1F/ZwCIu3Ix+FlgRWMqLZv9wuCNYIPZ/JqcNDx
         YyHB85sTO0+n53Ac2OhiWjTttqFMuUknQmr1hHkxTsmd68DGPDM8QY+ps6lIKjw0XzyA
         VGpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787904493; x=1788509293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1RxSzc/tdhLrfiCMdxDqFkVCnqjmbHn0IwP7JFLZaWY=;
        b=ZqjIygWpXCTd3lr7fLHC3A7cYA7fhqvgFB4BJZkfiU9kEyyS15q8yQFsrKiBlhhHHv
         uO+zW9EuwpWuSRGP+uJCgGz5uTq7ILBivkE5pF9ljBRL+RcMdAbEYyRtU6XP3sJv865Q
         IKh+YQo5/kpijojCuIM7iLJ5kcQZiP/IVoQNsIU+S3BcA1AmFSGx9RngRAW6iSWxKQnf
         DctpocqmcbXpnSD9PGoiwe3tbcYLCEnLlrEXy3+p3j68SlRLy+/zRX33vwLzaJQxxEWh
         qsGbyGzRyLqsDwSfu64Mwu0I8ABjL1Yq0EqBNbTEbHus/ZraGsPYYbeo1VBzMKrNud54
         ZO2w==
X-Forwarded-Encrypted: i=1; AHgh+Rpipq7EyN/k+tyq+DkbTJaH1Fw8ctQzpaRCZ6T7eq7xggLloncNPEOiXebbvZe2gh05yKvN6NgRpiBx/Rvu/An4v6pFfes=@vger.kernel.org
X-Gm-Message-State: AFuF++mH9I2Cf1d8NV0/fMWmoL9k55LJY/LP7Y9+GZWsFyWRuqhsq9/7
	KyQLcOinVB5Dp2cM3sCdrdnF3kDeGZEhK9RXObxHv+JBjTKoLWiniPo6
X-Gm-Gg: AR+sD10oBlu9Wq8GVyCyRK70i5J2IoDoNBuhzW8jCufkVa8h2Uj6mIMK91qAdmCBJ4+
	CnLyNNBP3X+Y4wblGhxrSIj7NE538fw37v7l/6Jjd1Bec3xf154QWd6fFHtNPp6gfy9DizUHuK+
	5Ptn4Qndkb6jfRrZ7jV57BoSSlSbvQtDhrRyt83Az2eOfwIYMEeowyEg/aks3aEcgGDID3LZrCL
	lWITT2vpwcnRkWs/H4pxFLsQvArN8r4wwvOertVYmOOzA8ok4Mo/dGXcokIKyEaKTQxQGEccThp
	zt0aQquVWVjgdhbhT+oFDMaZ8eNfB4ZDi0vxbzl26Iqhc43FnBguF5U9CQJiPhB1Bfr4VYgBwWs
	UPxjzL2ZvqbmZLVo39mAlyKnJASeg0cz3vFcIN6krOFGhH7lLaQ+jBI0eII3Wk43hqPLiuwUEAV
	tlKevlVvofVDOaFVK+dqKf5SuZIIA6KGdAI14pfdoYkbpyDjZ1KqN6kNun8BRGTNxCtPPlrMiA
X-Received: by 2002:a17:903:2f0d:b0:2c9:aae1:a61a with SMTP id d9443c01a7336-2d74e07003dmr100122815ad.14.1787904493442;
        Fri, 28 Aug 2026 01:08:13 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d759869cfdsm3074755ad.51.2026.08.28.01.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 01:08:12 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org,
	lukas@wunner.de,
	ignat@linux.win
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	4ncienth@gmail.com
Subject: [PATCH v2] keys: reject descriptions that exceed the index length
Date: Fri, 28 Aug 2026 17:07:28 +0900
Message-ID: <20260828080728.2641312-1-4ncienth@gmail.com>
In-Reply-To: <20260828053805.1410721-1-4ncienth@gmail.com>
References: <20260824113004.3755053-1-4ncienth@gmail.com> <apEWZUFe8NmwgPDb@kernel.org> <20260828053805.1410721-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

struct keyring_index_key::desc_len is a u16.  User-provided key
descriptions are limited to 4095 bytes, but a key type preparser can
generate a longer description when the caller passes NULL.

The X.509 parser forms a description from the certificate subject and
twice the raw serial length when the certificate has no Subject Key
Identifier.  A certificate with a two-byte subject and a 32766-byte serial
therefore produces a 65536-byte description.  Assigning strlen() to
desc_len wraps it to zero, after which __key_link_begin() hits:

    BUG_ON(index_key->desc_len == 0);

This was reproduced through keyctl on a v6.12.105 KASAN kernel with
panic=1 and oops=panic.  The process ran as uid and gid 1000 with no
capabilities, and the console recorded:

    CapInh: 0000000000000000
    CapPrm: 0000000000000000
    CapEff: 0000000000000000
    [   14.044055] ------------[ cut here ]------------
    [   14.044211] kernel BUG at security/keys/keyring.c:1308!
    [   14.044375] Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
    [   14.044558] CPU: 0 UID: 1000 PID: 138 Comm: keyctl Not tainted 6.12.105-dirty #1
    [   14.044788] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014
    [   14.045025] RIP: 0010:__key_link_begin+0x1e5/0x250
    [   14.047630] Call Trace:
    [   14.047711]  <TASK>
    [   14.047785]  __key_create_or_update+0x490/0xcd0
    [   14.047954]  ? __pfx___key_create_or_update+0x10/0x10
    [   14.048139]  ? __pfx_lookup_user_key_possessed+0x10/0x10
    [   14.048323]  key_create_or_update+0x47/0x60
    [   14.048484]  __do_sys_add_key+0x219/0x430
    [   14.048632]  ? __pfx___do_sys_add_key+0x10/0x10
    [   14.048794]  ? switch_fpu_return+0x127/0x250
    [   14.048980]  ? srso_return_thunk+0x5/0x5f
    [   14.049163]  ? arch_exit_to_user_mode_prepare.constprop.0+0x6f/0xa0
    [   14.049417]  ? srso_return_thunk+0x5/0x5f
    [   14.049582]  do_syscall_64+0x5a/0x130
    [   14.049721]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
    [   14.051772]  </TASK>
    [   14.051975] ---[ end trace 0000000000000000 ]---
    [   14.054729] Kernel panic - not syncing: Fatal exception

The same boundary was independently reproduced on 3/3 fresh v6.12.105
KASAN boots with the source reproducer.

A one-byte-short control with a 32765-byte serial parsed successfully and
returned EDQUOT without a splat, showing that the wrap boundary is causal.

Measure generated descriptions before narrowing the length and reject
values that cannot be represented.  On 3/3 fresh patched mainline KASAN
boots, the boundary returned EINVAL and the control continued to return
EDQUOT, with no BUG, Oops, KASAN report, warning or panic.

A tested source reproducer exists and is available to maintainers
privately.

Fixes: f771fde82051 ("keys: Simplify key description management")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes in v2:
- Add the observed keyctl crash trace and before/after runtime results to the
  commit message.
- Clarify that the serial is used when the certificate has no Subject Key
  Identifier.
- No code changes.

 security/keys/key.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/security/keys/key.c b/security/keys/key.c
index b34a64d81d47ab..f2f472b45f4eee 100644
--- a/security/keys/key.c
+++ b/security/keys/key.c
@@ -14,6 +14,7 @@
 #include <linux/workqueue.h>
 #include <linux/random.h>
 #include <linux/err.h>
+#include <linux/limits.h>
 #include "internal.h"
 
 struct kmem_cache *key_jar;
@@ -820,6 +821,7 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 	const struct cred *cred = current_cred();
 	struct key *keyring, *key = NULL;
 	key_ref_t key_ref;
+	size_t desc_len;
 	int ret;
 	struct key_restriction *restrict_link = NULL;
 
@@ -865,7 +867,12 @@ static key_ref_t __key_create_or_update(key_ref_t keyring_ref,
 		if (!index_key.description)
 			goto error_free_prep;
 	}
-	index_key.desc_len = strlen(index_key.description);
+	desc_len = strlen(index_key.description);
+	if (desc_len > U16_MAX) {
+		key_ref = ERR_PTR(-EINVAL);
+		goto error_free_prep;
+	}
+	index_key.desc_len = desc_len;
 	key_set_index_key(&index_key);
 
 	ret = __key_link_lock(keyring, &index_key);

base-commit: 0a0d1d55dad570724bf8c7ea83409639cfb4be9b
-- 
2.54.0
