Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795766649;
	b=OsRaAB/jegzNXz6PVYtHMj3Vr8i+gYk6Ukl8Tz9mrPRbHqiWEjt+zMi3/+hSxRbWu89p
	 3ro9sHxn+3bz38Mj0kDKe7nk0cGCI6bS+E4KJPf0YNwLM8pDELYdItI8Rzay1HdTQz9GQ
	 mWVKvfCnMMrF0Tz16AmOFZINdi+CEiRjlF559/ybCaeSAWkWjBEsowqgC1F6hdvOuXu8b
	 vtad20NIPe7hI8ZFEx4chyDG4smSkIA5goy/Q4GimXnBuJz7NDzDLGHFlWEyUrEGxqrOG
	 DWBcZchCMLkM+o98gmzRrTtqEv0CUdD40qg3vNCMSwj9nBDEMTmSp78l3j7lag3rBPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795766649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Z9aPSWNuVkjxdyQpwpLgQbf2amCCZj6fJ5ndu/9NBHY=;
	b=ZaCYyWl/6X/aUuNIuYR8q9IEjlS0+UhltpHuJMhnS6f3ll1nf03K9fIw3UGUxKVqnvII
	 /UKJcqtAUhNczMuqcdKj8FY15u99FR6lA6IhvSdeNmR+wy+0omUzGFX4Q4L8hUrpjUGIH
	 RyDRp0D9Q8EYmJpWVJikPULF/Zw5WO6gv6xfxXA0mkm+YnyNYh8qI8x1HpdX6+2gm58+J
	 fMez2DZUYpR2lc207dfe3d6AEvMKENjvrcWvxxIMuCfHHUpi+6TObclbnOT/Yk7cjHwCQ
	 BvP21m3Hx+VwaQWX36aq7gNlUeQ+GjMtD5e+gmS0V0HyN0/YxTc0rgFJj4jmbSKof0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oyXWUyo5;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C65F606A31E
	for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 08:04:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C65F606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=oyXWUyo5
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8a0880a46e7so4669643b3a.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Nov 2026 00:04:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795766648; x=1796371448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z9aPSWNuVkjxdyQpwpLgQbf2amCCZj6fJ5ndu/9NBHY=;
        b=oyXWUyo5LfOXPrX/MQ3o6HKh31ehKDoY3MEsTGpLFwfzkhBIS2pJ+fR5ceoG0Qx2li
         Sf3pNqNfOATHnFU2AmHvbLl6eSdsA/qLNC5q7GIkInCmo1NHb9Oe/FJjxq8RME3raakW
         UbtYHosCHS6UbmLpw69UssW4xd9MbDMbGgvQhqQeUeTQA+Ryt9C/1d9ueeg777VUb7IF
         ZZmTUPoZ+zGdCY37p6ojfdl7HRFRSFe9Mjxaqvejl+UwbphSf0/4M39INc2MdxW2yki3
         EQpznr/Jrnv5C6dBON8c2Vla4uqZ5CyKTk9xYjmH/OTHLTObLxa57DIPADr7HDUZq7UQ
         EBCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795766648; x=1796371448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z9aPSWNuVkjxdyQpwpLgQbf2amCCZj6fJ5ndu/9NBHY=;
        b=tYSDResW6rtoYvyzaPxWkYrtHb6upQcC7TiEnEIiVmKAbuLk//Roy3vcEIq3cLxBWu
         Htao4p16gOg3LNNS8QgZMuU5qN+yzR5irQpemsZ4KxLH0a5AzlyAJJ6R8fGhwdmEIr9s
         1vwcBtdnYlYDhFeMkRIA+N/EVmsbR9BYmnzd1X1hTrQlDWPrpPdH+JAKp/jAbdif8Oz4
         632k5itfmN/7H3WM14iwCmYfc+AMATZ3IiVsSc8EAOznDqUfs1V+tFACU0/CnENUqFeC
         b1rjbhxM/NiSeUQESyi6WvtXM/WML4M+u1/iUe2bm3japZ/OOrrNOwm7K1E4up+NBYox
         i9CA==
X-Forwarded-Encrypted: i=1; AL+hErHEpCiZx4H/RDS3/AIJZq51oOfED7sUhdHnhIdwau2zrhDl/ISjEI4Cycvll+HjR4UgLJd5KnNu8trDn9WzJIJZt0tb3M4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8ZevN04KaiJ+vrc84Uy1ogHWPzOdwMsbM/8wxkU/228jiV/Bu
	ICwt2CHvCKcJrppiIRtxtMSJEjicL8W5IJQiuzsAOIhM7Xc8XVO1v4/6
X-Gm-Gg: AZFdTZdjPIde67npLkkVuJ6iGMaVr8mau+RoiYvGhuEczM+PqqwDgwF3EUyh8QY5YQE
	OojYMCN4dSSrJuTy7/9R9I+VQUo6N/At/RV0a9nKlVbitbaGhnpLrKDkMB0Ef15TfSt4fVVqElM
	iZ+mt9rnxGj85OvBXAxHfYHXVh9SP86uTg71JP7QUKKk1WNaLtYudM3QHtv7mQQy1CH3yzyYtdC
	mt+rFUqm5p9sKnIrOBJHiIv2IaAWrX7SyAQX1gTSRs8vYxZwgYJPSggF/dCOesyMFJ3EsWtfPx/
	3pXWK/M53pLEHv5QS0aShRP/rq9T5mbZSFw1+HcPTHM35fVdL1A/BXFxgwJyy8xmAxhYaW1WFwy
	cBciXZgjUtiYm8DNLQKN3U5DpwhB/SPURcxFydJQD5ncDnq0oHL4qE1QD+80FEKZNeGpZk1Olwf
	U7m2SqzzbzuRrRiovGwX1bUno/yH0P+hDYNb9M0xJgRBpfGqHCtUrdAW2MQkVyTJz16xFTiDndm
	Ab+0Y4VT45+xVb+WdShwYAmOMdkhqGJLKJbtAGJTCq/nX+V8CGUU165xR5DcmHY43wnavbDSDED
	XAKLObiRuq9qDJ9tacz+yN4rcKL+yCxFGfHxusAW0xiKtY9HR0ysvXzChO0cKBzjSUa5
X-Received: by 2002:a05:6a00:188c:b0:89e:9d69:c0bc with SMTP id d2e1a72fcca58-8c87d51d396mr16809308b3a.27.1795766647440;
        Fri, 27 Nov 2026 00:04:07 -0800 (PST)
Received: from SGN-LDSENG.tasernet.com ([2405:4800:5cc3:11a:1ac0:4dff:fe8b:4a69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c872e485f5sm12242899b3a.22.2026.11.27.00.04.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 00:04:07 -0800 (PST)
From: Cong Nguyen <congnt264@gmail.com>
To: John Johansen <john.johansen@canonical.com>,
	Georgia Garcia <georgia.garcia@canonical.com>
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] apparmor: set xattr_count only after the xattrs array is allocated
Date: Fri, 27 Nov 2026 15:04:00 +0700
Message-Id: <20261127080400.275982-1-congnt264@gmail.com>
X-Mailer: git-send-email 2.25.1
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

unpack_xattrs() sets profile->attach.xattr_count before it allocates
profile->attach.xattrs with kcalloc(). If the allocation fails, the load
fails and free_attachment() runs on the profile. It loops over
xattr_count entries and reads attach->xattrs[i], which is NULL, so it
dereferences a NULL pointer.

Set xattr_count after the allocation has succeeded.

Fixes: 8e51f9087f40 ("apparmor: Add support for attaching profiles via xattr, presence and value")
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
---
 security/apparmor/policy_unpack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 24fbce2e4322..83cfa981f7bd 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -598,10 +598,10 @@ static bool unpack_xattrs(struct aa_ext *e, struct aa_profile *profile)
 
 		if (!aa_unpack_array(e, NULL, &size))
 			goto fail;
-		profile->attach.xattr_count = size;
 		profile->attach.xattrs = kcalloc(size, sizeof(char *), GFP_KERNEL);
 		if (!profile->attach.xattrs)
 			goto fail;
+		profile->attach.xattr_count = size;
 		for (i = 0; i < size; i++) {
 			if (!aa_unpack_strdup(e, &profile->attach.xattrs[i], NULL))
 				goto fail;
-- 
2.25.1

