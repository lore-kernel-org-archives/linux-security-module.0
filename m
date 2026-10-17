Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33AC2DF126
	for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792250502; cv=none; b=teG7NXu1TMGaaFSxvJNzX81mS6Kns1rbpSF6AqTkyUrVmcoqJUmtKczpgjsBAODaUFwlmhFNpSln7o2kfHQZ4KHM+BiOHQfP0NDgqA/bQh7tQEa/LfNZOQR+i0yExHTR03QxG4wWyDp5+6VZWhMt3qy96dwm97wq5jHkID0VVY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792250502; c=relaxed/simple;
	bh=mmkEj2/6FluSuVa6kOpFI+95vVAVdqDsent70A21+zY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kgS4FQcnkAmzRz+lsxO6rfGCCHot2bMIa18r7NaJtXKwlH1FNwIC0QygKNOXID4DuezICHg6adnA9iYDajrfrwKO0dvMQg+zt4uc1Xde+y4aK9XOGKaDoOas7nlEMnoQhDKkPXNxxDd28XWCK34GxGjhjpf/dbl8cj+oXva6tBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/og+7vw; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/og+7vw"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ac451e128cso547701a91.1
        for <linux-security-module@vger.kernel.org>; Sat, 17 Oct 2026 08:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792250500; x=1792855300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bHLEUnpsV2P3ynQ8MKirB0DKPzZUp3tF3QyWRet8Yzk=;
        b=E/og+7vwzpPF1cy2RTRCcS6f0NnfQ6gmDiTk5XOEiRIHyz3R0W8YXMC5PHQtS2Lmhg
         RuKXapg42VAU1HUyTDSMNyUJL9CZhc7sJGmaX2DFZLwkdDvAm8gDsc11Icci3URXOVhl
         +WuSLPq5CmU52fZpZpb/hmAUft+EagOsBfiEyy9mRIYbAeZ7owUmcxPvKB+eFVqn16FQ
         CAVH2ZBLhsEM5aJpIODrOu2MAAN7VHWdaeGG68CGZemrJ2biKOSpCT+b+y7wRmZhT1a3
         s4dhXKiAYLNoRx1imsrvm0qxZVbbXA6qFzDWOqfcepG+pObA1y9ImQplJnQ9KEajOwDV
         q4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792250500; x=1792855300;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bHLEUnpsV2P3ynQ8MKirB0DKPzZUp3tF3QyWRet8Yzk=;
        b=PF9TsK56OOTOgWwkqOvO41le3Rp4mKozp8I3092U8IkcI278Q3HnYzcLhMDNq+0i5R
         YPyEbg9vbiJ4QjUv6Hqe5lGiUyVh7EBOe57FUmlT/loo8hEJ7CGPlimOez5iTub8JJ8/
         /GtJcYXvLzUfkvBSORpIyYv8vMVSeQ7Cx2e4oZ5UL5XJgEg9I/NY7Gc3uu777oerAg8b
         6JvnSwCJj3HMm6WnsmcR7CQrhxg9xI+l/oCRH8Ih5OwjpKBhkKKTS9Jcyi4c0nYBgpSt
         GaAFw9EOR+zPxLZHpET8tpj94iZVsA5o6J7vOlqpO/Q4YHJ+DeFA70Ivx0mrZc/bPwPl
         XuDg==
X-Forwarded-Encrypted: i=1; AKwUvBxZKtLMpDnm2LnuDX/IKzZVQkXsA7J7S/OomAZgDOMUJAvmnKfCdh/lWhb1PosJ2TDS0X7hfr14UD6pGq9uz9OnnIbi8EY=@vger.kernel.org
X-Gm-Message-State: AFq9FYL4T3MNsEIc4UFEv9kZWEzBVqi4ikrbrUtNC8g6NPvlnUpTzKNT
	EYPzl0PS0fK1SkOE/tRAfe/MREni8G+BTp2tz/TsnCIHzLUEHZ8LOGrN/v1lXg==
X-Gm-Gg: AYBFou0LFSLR5z9zaSDiG6e1E2fcUGJ6FM5ZyxShEhn8KiVxPMZUhJoxezqRAFEaqCc
	imtdHQZEzar8EmZumTwqkpEugOzrcyPpYY33at1tiFLiHS/9v41VERyN9Y0ZehNxz5CWrdUUjtX
	hveqkpk7aGdsdGvXPlIdH0eqRj+iqDFJWGbP7cocdGuCwZIY1qTEy0YILxZpMvfm/rQbgrxV2Qh
	h5w0EozbLbLX62FO+CHvgV3cxevej8AF0njif/C7krtuEL1iRnTF6smVybItPda5scXZtNuJp8d
	dLERll0SAUUE435Vh7y/M+gOadzf9wNYYP+QqC1coZ3kPVAJP4vG6qx59Qu2BzCxyPJnvkZ1gPW
	xStwds4VO2QtCaycSuLTMLuaOl0DSTbrhqIEfpaO94MnAL8aI+yNdMPWeFxwZ3VRojMKtCO/oQw
	fx8vZd+79EWEfhqIt8KEi4/ylBgrl1gMZq3WbOUZmE77AKD46IGjh99LaudVrKpvxUlXy/AzkJT
	UNiL0jPQKg=
X-Received: by 2002:a17:90b:4b04:b0:3a8:f70f:2437 with SMTP id 98e67ed59e1d1-3acef52ae13mr2520951a91.50.1792250500220;
        Sat, 17 Oct 2026 08:21:40 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc48f19d9sm8511142a91.11.2026.10.17.08.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 08:21:37 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Howells <dhowells@redhat.com>,
	Jarkko Sakkinen <jarkko@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	"Jason A . Donenfeld" <Jason@zx2c4.com>,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] keys: big_key: Remove the redundant quota reservation
Date: Sun, 18 Oct 2026 00:21:23 +0900
Message-ID: <20261017152123.1200429-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <atK186hMPBhYyPCN@kernel.org>
References: <20261016040004.324286-1-4ncienth@gmail.com> <atK0MnGM2h9IH6FD@kernel.org> <atK186hMPBhYyPCN@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A big_key is charged a fixed 16 bytes of key quota, regardless of its
payload size.  big_key_update() nevertheless reserves the new raw payload
length before destroying the old payload, and generic_key_instantiate()
then reserves the fixed quota length.

For an update shorter than 16 bytes, the first reservation temporarily
returns quota.  Another key operation by the same user can consume that
quota before generic_key_instantiate() reserves it again.  If the second
reservation fails, the key remains positive after its old payload has been
destroyed.  Reading a buffer-backed key or revoking a shmem-backed key then
dereferences a NULL payload pointer.

On a KASAN build, reading a buffer-backed key reports:

  BUG: KASAN: null-ptr-deref in big_key_read+0x110/0x310
  Read of size 64 at addr 0000000000000000

Revoking a shmem-backed key reports, with oops=panic:

  KASAN: null-ptr-deref in range [0x68-0x6f]
  RIP: vfs_truncate+0xa2/0x730
  big_key_revoke+0xbd/0xe0
  Kernel panic - not syncing: Fatal exception

The first reservation is unnecessary.  A positive big_key already has a
16-byte reservation from successful instantiation, so the reservation in
generic_key_instantiate() has zero delta and cannot fail after the old
payload is destroyed.  A negative key has no old payload to destroy, and
generic_key_instantiate() performs the required reservation before
publishing the new payload.

Remove the redundant reservation so that the update path adjusts quota only
once and cannot expose a temporary quota gap.

Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
Changes since v1:
- Remove the redundant first reservation instead of changing its length,
  leaving generic_key_instantiate() as the single quota reservation on the
  update path, as suggested by Jarkko.
- Verify full-quota positive and negative updates separately.  A positive
  update keeps a zero quota delta; a negative update can still return
  -EDQUOT before publishing a payload and succeeds after quota is released.

 security/keys/big_key.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 268f702df380e..ef707f2a81a98 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -193,12 +193,6 @@ void big_key_destroy(struct key *key)
  */
 int big_key_update(struct key *key, struct key_preparsed_payload *prep)
 {
-	int ret;
-
-	ret = key_payload_reserve(key, prep->datalen);
-	if (ret < 0)
-		return ret;
-
 	if (key_is_positive(key))
 		big_key_destroy(key);
 

base-commit: 58161ead29e50d70a317ea26b472e0c7508e69da
-- 
2.55.0

