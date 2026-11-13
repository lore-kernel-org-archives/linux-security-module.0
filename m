Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794601437;
	b=AIdEzxPJ/NYw2ZUFSdqaArbmajI0G/eJbr0qOPM7xL5PwPl7SxPdNCPe4rVYZkZ8srhg
	 EICqxbQ4XWMdMpTtQ46djrgD1nmYcsO2s2uEiDuui9hf+3DFK/483+S523XEzIkQmsyEq
	 WNjBTPC4Gjaz5ZVqCBOWB984ShWQef8hnL3nuQPQ1aSm+eCRRSZydjpZJH0RhjvOeTASx
	 uwKbFGfGKT2DDhuvSxeYBWHY8pZK8P+mym9mZgItNS9O0f4THeB4TGyYoMNViQGdiAT5M
	 CVunQiFx6flbtGygCn7R3t+H0qxw8cA+PiOm75ZG/Qz8+4f8dW08ig5067VPPSCnJKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794601437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=xbWBgXkenSa9yRsymUcI7Wl4ur3mhX+FS+9uM+YkKCo=;
	b=m6O+WtjYTGgUFKwcdJSTeZWZte3mxkpj6Odd1RqmJuG1bUOtg4ptY1xnNx5kWS78JDoh
	 9dTgLlA5TaI8E02CQtBgmMj1sidBKdC/Z61Lvp9/zGZMRUP/Blm5WM+FTqvn3nsCYk8q2
	 aYeeMGL/k362jcHLFNtlRIpXZ4Xia0+TnqD7TJAIQx5czpSix2lUMqk4sqENjq3WTETY8
	 kJmp8CgaYikYi17PxYVBSdoeWwJDUXlaR/WUVpQGRc+7kX/FCfwnsD/cOxjaV5DkX9mA2
	 T3gpaRipL9O0uEKohEEdmCByGQjJJjahyoKSQy69HJxGWjoyZr2Hc3IelRxgqOswfXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZbXb6Toi;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6BE606A880
	for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 20:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F6BE606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZbXb6Toi
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4bb55cda775so6654415e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 13 Nov 2026 12:23:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794601435; x=1795206235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbWBgXkenSa9yRsymUcI7Wl4ur3mhX+FS+9uM+YkKCo=;
        b=ZbXb6ToiEor+Fks4PY5+zaOANffpyCUalvAA3FTNQCzl3dIT67JiJK/lFT+LibVv1R
         +gcfdwZ0t//pP1PP3y3RGJhyRZvOW0btRS7B7Ama9LRWK+Dj7UOoi+mOAyHnQfo459SQ
         RKDQe0OsTaJ+THPvQppDwb5gv8aYVMq85S1f5b4S4aO91vVMDOJd5AADEH8eE4bN9CXP
         vWTeg3GtQGcWyxouqrVH2W7SlfZp/05TwfTyHyG4zXw5VW4RD/UFMak6Spk0oOmTFywY
         JaW4xxvQBR6Eo6iZ7smq63zHqsHc1jFxGGk3ajq2CbTtiNX0d7NzGzzraRjbQBjTMMbo
         unoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794601435; x=1795206235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xbWBgXkenSa9yRsymUcI7Wl4ur3mhX+FS+9uM+YkKCo=;
        b=hsHSxDgk9iK0/ywxgNHv1sY0FaoKWaSsc3T7eApafKOg1VnvGRhEli+zuTg4JOh5By
         IlQADQ6AhoK5ePI88ldW47tTdLSZuNlQ5mkN4rwrmuE9LK6Rnx7oAHhb6NJIOW22P8ah
         MlPuZC2lOAsRkshCYIOh+Lozc1deJL7zWHM2hE1F6ogC+Bw66vrrf2i2XBFSUHzJWbcC
         1bLGispu9RV3kCP9uCKdL1Y3+LHa4hsq4YiWiGrTuGiPkzt0KQS0uxmEjgXjHBGmcDNN
         LRnMr8ZueoLk+QdzYVkmxtYAz1FFb06f+iBRVOQBVpY5uDHctVBDKEg3XBaILeMYceqX
         ZuRw==
X-Forwarded-Encrypted: i=1; AL+hErE3r0/huA12mSrcOprJYJg7eiyQvHEne52+Hy9B5+h7gc/TK6MYStfNwr5o2hNMGc/nQ5T+5UyypUGnpj3awxoI/nSuUfE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+n83Q5lvwG5t8ZD79z9nEznVQXF6VYlyaEql8ZBHFVl65FYyXr
	tNygOZUf6YWICXDIPMKG93S6rE1bSCQL6+a6tAYkrEZJatzIdwA5Fc7U
X-Gm-Gg: AYBFou1iDRK8tmLbO2to6e1/1HTs1uWFLy14HfYxJWzkJVvvUrbU4d23aUU6KvbURXw
	tEIzcAWXZsKZ9P5BhZLruF1U3Y7pBVgvorp7iP5G+WUEn5R9JxNm9zyTWkTcwJBwvVk59Zo6KvF
	jYwCdAbDIDQK4iyiQLgSAaP3a57ccbs/uOMqQu8GDKDISFv4R5zDzoFl6OxnixXGxVQs2eChR+W
	leJg5+9ALblO/+OQTRn6Jq4/QXcwTJWdN5ld6APhJF7USeBJI0Ir/blCyfEIK/YgLGI4niMhfyb
	k4PYSLOYD+PbWoY+TTpnph/bAW/X9jTXD6uow7UQw7d1IyXD6u5nP20dziCrAWYJBIVmyAIbvaC
	x4kXEjveZaMcXGs2cYH7ya0chAfLe5TqD+xDEUJeWXlIbxBVuTbrZmnAoNh+eFSnu848FsS82cP
	2NaXW29zaTrtfHlUnXPQk4Pt6Js6fDPsaPt5GlOGR5okGHLIsTSXf55udUyzfwHX0w2iBZbovBn
	M5IuxesT7XXE32Itwj7DBEIXoivk21RS2Kf1QRFIO64DjDZvym6y4EAMzc53F/vFYPn/yVcGap0
	zqWxTAxpR798PUvbLypVoybldHhg5khkDeaihYrKt3T8aD9wonTWtw==
X-Received: by 2002:a05:600c:4504:b0:49e:6581:7baf with SMTP id 5b1f17b1804b1-4bb559f044amr74646205e9.2.1794601435369;
        Fri, 13 Nov 2026 12:23:55 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571f976esm40414575e9.3.2026.11.13.12.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:23:55 -0800 (PST)
From: =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Date: Fri, 13 Nov 2026 21:23:23 +0100
Subject: [PATCH v3 1/5] landlock: Fix layer composition of
 LANDLOCK_ACCESS_FS_REFER
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
Content-Transfer-Encoding: 8bit
Message-Id: <20261113-b4-landlock-refer-nonfs-layer-v3-1-02d7e42bcdfd@gmail.com>
References: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
In-Reply-To: <20261113-b4-landlock-refer-nonfs-layer-v3-0-02d7e42bcdfd@gmail.com>
To: =?utf-8?q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
 "Serge E. Hallyn" <serge@hallyn.com>, 
 Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
 Shuah Khan <shuah@kernel.org>, Dwi Siswanto <me@dw1.io>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
X-Mailer: b4 0.15.2

In landlock_get_fs_access_mask(), only add the
LANDLOCK_ACCESS_FS_REFER right if any filesystem access rights are
handled at all.  This prevents us from accidentally treating
non-filesystem layers as if they handled LANDLOCK_ACCESS_FS_REFER.

landlock_get_fs_access_mask() is used when initializing the layer
masks for doing access right checks, so this bug meant that we
unintentionally denied "refer" (e.g., link, rename) operations in
layered cases, where the same operation would have been accepted if
only either one of the two layers had been enforced.  If the rulesets
individually allow an operation, the composition of these rulesets
should also allow it.

The bug only manifests as soon as one other layer handles filesystem
access rights.  Otherwise, Landlock filesystem path walk is guarded by
an early exit for the case that no filesystem-enforcing layer exists.

Reported-by: Dwi Siswanto <me@dw1.io>
Link: https://github.com/landlock-lsm/linux/issues/67
Link: https://github.com/landlock-lsm/go-landlock/issues/66
Fixes: fff69fb03dde ("landlock: Support network rules with TCP bind and connect")
Cc: stable@vger.kernel.org
Signed-off-by: Günther Noack <gnoack3000@gmail.com>
---
 security/landlock/domain.h       | 13 ++++++++++---
 security/landlock/errata/abi-4.h | 21 +++++++++++++++++++++
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/security/landlock/domain.h b/security/landlock/domain.h
index 935e18b12b3c..d9ebf4857fce 100644
--- a/security/landlock/domain.h
+++ b/security/landlock/domain.h
@@ -262,9 +262,16 @@ static inline access_mask_t
 landlock_get_fs_access_mask(const struct landlock_domain *const domain,
 			    const u16 layer_level)
 {
-	/* Handles all initially denied by default access rights. */
-	return domain->layers[layer_level].handled.fs |
-	       _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+	access_mask_t handled = domain->layers[layer_level].handled.fs;
+
+	/*
+	 * Handles all initially denied by default access rights, but only for
+	 * layers handling filesystem accesses.
+	 */
+	if (handled)
+		handled |= _LANDLOCK_ACCESS_FS_INITIALLY_DENIED;
+
+	return handled;
 }
 
 static inline access_mask_t
diff --git a/security/landlock/errata/abi-4.h b/security/landlock/errata/abi-4.h
index fe11ec7d7ddf..9784ca645073 100644
--- a/security/landlock/errata/abi-4.h
+++ b/security/landlock/errata/abi-4.h
@@ -20,3 +20,24 @@
  * that rely on these protocols while using Landlock network restrictions.
  */
 LANDLOCK_ERRATUM(1)
+
+/**
+ * DOC: erratum_5
+ *
+ * Erratum 5: Denial of ``LANDLOCK_ACCESS_FS_REFER`` in layered domains
+ * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+ *
+ * This fix addresses an issue where ``LANDLOCK_ACCESS_FS_REFER`` was implicitly
+ * handled in domain layers that handle no filesystem access rights.
+ *
+ * With this fix, a reparenting operation is allowed in a layered Landlock
+ * domain if and only if each layer, enforced on its own, would allow it.
+ *
+ * Impact:
+ *
+ * In kernels without this fix, if a domain combined a layer that handles
+ * filesystem access rights with a layer that doesn't, the resulting layered
+ * domain would deny all ``LANDLOCK_ACCESS_FS_REFER`` operations, even when the
+ * filesystem layer granted these operations with a rule.
+ */
+LANDLOCK_ERRATUM(5)

-- 
2.56.1

