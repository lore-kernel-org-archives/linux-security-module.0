Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71D23E342
	for <linux-security-module@vger.kernel.org>; Fri, 16 Oct 2026 04:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792123224; cv=none; b=ZccdDYn+J12ZerHgt9+jzvv/H5S9CGoiCfCAbMZRxAB1RmSmdEMrQT9jstJ1hbHafQDAvDx25Re40a049QPW5yEybBTrYzEWLTjujxE1dHjalOQ667/qSnLwK2ugJwME5vSTNM1gr6uabKIrSfa2ouRt9BnfrowKmzUlgoY5e7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792123224; c=relaxed/simple;
	bh=R1f53fZVOQpXpGpCi4RklZRTZOgEf4RFVZqHIV1IEjY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kpfomnheejzuSmEG13KY8IzDzThsBTcrmDbqre24jD0tUAJVWDBmm1FH5CG0zbEtrLo8/YH0+13lnuYVa5cMAx+IUWjSgZF/G3TWIsNZIPUssGHH7u2U32tJ9XXWuahPIOosalRJYYgGe4TVdeWf8B52vgPZiXpiEgt4FJLsLfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZIn4Nb8; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZIn4Nb8"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ac5b090d16so432254a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 15 Oct 2026 21:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792123222; x=1792728022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=g9IQw/iWHXUIP0xYQGBwa0OfUNbaaj14Fj4E0JqM4sE=;
        b=LZIn4Nb86Im+eJt/C2Z8tvysgraS2xt11OqHgABFEDtbc4L9UzgX+rkAmvCaf3qWpZ
         YrRQ/G9DWEHcA3jaEQVGVLgo1w6xS4ttOxTDJiarb9APKyqPBovADl9C/WFYx5gjuNIp
         NYxK934bVsZnzU4025+/660RdteqDSkEOjjCLYBYpp75chpAug5MlTcNHiCFHauNf5ee
         xnPfvK2P7k2P9q/jSGzTildbi5YZA/ZMctd1x+Sw+aJdu1TmqCj/gJ7+qoxkkdY/d6XH
         x6jcETDeUjBSd72vBER9PuBgP61DzxNIUd1eDYK4dOCXVpCQ5fk4AbXVPxL3+XP5BECO
         5llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792123222; x=1792728022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=g9IQw/iWHXUIP0xYQGBwa0OfUNbaaj14Fj4E0JqM4sE=;
        b=RGPTJJdnm9tZhxjfZjsZYSeIc6OoDFRpb4ZfHaWDcxBC3Zt/PMAjSBYjcTa2LTiMrP
         mLLupsdX4kbK//u6HFVMXdyuTk82webLbqUsSwOSuP4VG30hxO4xDhJUMtQShmDg74Ai
         MOtUDCKIOrAg+CLMM8M1V1fl775z9oDVf/1V0FmJGBow/iz4qthiwGqpI1YAXnahGwj8
         unA0Xj8WgqfuNVP6ToY414Z/ZCZRBSRXUiY3jR10Qg+dsWYhneL+JciHn5NRvGNDvDz+
         1VE6hj5RyfRfrQyB0NKiE3ZE1QXuUWx9BydIKqJ0e7080/p4GGWPu9Ph+7aK/fBScBzr
         kuow==
X-Forwarded-Encrypted: i=1; AKwUvBzKji9o/vgjyLbmwhbo5zsMq/ChhZF9EtnoEvKWXz+xuU23XDxHOrSrRWM3DdVmYLiQ6MM0BLcvQdSsAAkAvAbY+D7DP9s=@vger.kernel.org
X-Gm-Message-State: AFq9FYLKSPE5wAOROiMMQ089bSrpWbO3paJHlIt5NKPBDB8sZkQ/9FEm
	5oEepm6kRIn59dXgS2yCoREtvEtx6u9JS7Lg0yyBpeSMFdfxR9H2gYfX
X-Gm-Gg: AYBFou0SLykWhhp8slkd1wm+JcdxRPGn+ZKKg/TiwN5yaD73VgppFPmZr+8ipjD00Cf
	yrBsTfnTYD98clWH7nLZNQ/9YylbJXXyB57bQGv1fJdMTQESAqIjmmkc6n6yJpC4riOdcjPAjRn
	ytrlZfvXXovcJQvp02GLKTX8wlO+L1g6+9I+LBiYSU4pQ1VJmH8B/XoQ2TW+NGCjvYkZrnKiyJ/
	6V+/7B264WyERX6fRTdT7QgYr6W1YgIygSjqAiVZ75oHSe7hsoI1Wq1VLX2zYRRMjX0i1Yzxze/
	nV0y3DfnVRIsVcwoE0rm7kEe8eqGcnYkp778ctS8D7E5Y1bu4merMgy2NBKn9ogiiCzlxHDRihb
	NUdU71PkhqXfE1AvCYTwbmj2nrJL84YLRijar5Ppy9WaBub9oE5CtFA0ubpggWXW3kiVUdLfjYw
	htYMsSJ/mmjq1vIkALHEZZix5+G4w4aorsIgD8Vryq6SXPESGj9WMFuWnWDHUHeCJ9+/o38Oxpx
	K3kbJA8AUk=
X-Received: by 2002:a17:90b:3e89:b0:3aa:412f:b0a7 with SMTP id 98e67ed59e1d1-3acbb689d36mr1258321a91.5.1792123221974;
        Thu, 15 Oct 2026 21:00:21 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac94627250sm7017040a91.8.2026.10.15.21.00.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 21:00:20 -0700 (PDT)
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
Subject: [PATCH] keys: big_key: Reserve the final quota before destroying the payload
Date: Fri, 16 Oct 2026 13:00:04 +0900
Message-ID: <20261016040004.324286-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A big_key is charged a fixed 16 bytes of key quota, regardless of the
actual payload size.  big_key_update() currently reserves the actual new
payload length before destroying the old payload, while the subsequent
generic_key_instantiate() reserves the fixed quota length.

For an update to a payload shorter than 16 bytes, the first reservation
temporarily returns quota.  Another key operation by the same user can
consume that quota before generic_key_instantiate() tries to reserve it
again.  If that second reservation fails, the key remains instantiated but
its old big_key payload has already been destroyed.  Reading a
buffer-backed key or revoking a shmem-backed key then dereferences a NULL
payload pointer.

On a KASAN build, reading a buffer-backed key reports:

  BUG: KASAN: null-ptr-deref in big_key_read+0x110/0x310
  Read of size 64 at addr 0000000000000000
  ...
  big_key_read+0x110/0x310
  keyctl_read_key+0x2da/0x550

Revoking a shmem-backed key reports, with oops=panic:

  Oops: general protection fault
  KASAN: null-ptr-deref in range [0x68-0x6f]
  RIP: vfs_truncate+0xa2/0x730
  big_key_revoke+0xbd/0xe0
  key_revoke+0xc0/0x1a0
  Kernel panic - not syncing: Fatal exception

Reserve the final fixed quota length before destroying the old payload.
The reservation in generic_key_instantiate() then has no quota delta and
cannot fail for this reason after the destructive step.

Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 security/keys/big_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/keys/big_key.c b/security/keys/big_key.c
index 268f702df380e..6aff1a73c7b38 100644
--- a/security/keys/big_key.c
+++ b/security/keys/big_key.c
@@ -195,7 +195,7 @@ int big_key_update(struct key *key, struct key_preparsed_payload *prep)
 {
 	int ret;
 
-	ret = key_payload_reserve(key, prep->datalen);
+	ret = key_payload_reserve(key, prep->quotalen);
 	if (ret < 0)
 		return ret;
 
-- 
2.55.0

