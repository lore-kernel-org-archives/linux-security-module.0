Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453172777F3
	for <linux-security-module@vger.kernel.org>; Wed,  9 Apr 2025 18:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744224834; cv=none; b=c1Bl1XX99w0t/fxOZLNKthOGvUwPOTGKfgpHWGR0SaseTA7GUKkpe8+F+r4xaBXYYicULwTyKqOX4VHiIpHdJgwa57CWf8ceJVIwEJY07QoO6Aa22fu8jrWZ4lBP57IcT1XYTXRo89M7dfLuFntECvHRaMKgmpp3YnI93QW8xrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744224834; c=relaxed/simple;
	bh=MkPoYwIG4TinjPfNk0EXrsRLK59ADeRUmFIT97JZOE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s9vRqATdw+yXQ2xVLZ7G67OO7TsFk2OcJZCjz235B2E3EHcM6ZdEI1YGjOwy+awxgykv+cwv2TH++U73oGIRhnummp4Pt3t0zYoXxEUDZWyz89piO93buY5ihO4FWlgTKIKimVpZWG9ZezFLMRN/uXYdugn5QhZAfIMgDBXmI/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=B4B8KgAN; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="B4B8KgAN"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7c56a3def84so4181985a.0
        for <linux-security-module@vger.kernel.org>; Wed, 09 Apr 2025 11:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1744224832; x=1744829632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MpBxHpsE71g/suNoRLUwEmP3N3oQiPkN9k6/6tTBThM=;
        b=B4B8KgANTO2yMHa4TLnCd7wW9aprQd1uLNDJqAGyqZttnLaxWL9lv7pxK/OfibSkpF
         2IZAosKKF44VVLw3o+Ue9afWSUy2g9LDKaa3JyOCsRsY92f6S8bFjcuT0VYbiajqzb+d
         HYkaYUx/gX4kzY6Yr5uQTcepv0zlFp7aJ9rIQVKlIIjhBkmUa6Qp2dZJ8HlzYX7ZMJpu
         xqM1gXbaW/BMqE4Yw1Cvi66D4kvr5PBHE/rhsZi5AaWUsaiT36wjy1xV+rTdFJMkI9C3
         QQUl+hK3d3wHEwORezgDTZp3MA7mrBarFVXwv6P0FlojDv1DOj/+h+ji6wdZg2zTkMuu
         uHhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744224832; x=1744829632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MpBxHpsE71g/suNoRLUwEmP3N3oQiPkN9k6/6tTBThM=;
        b=YQSylPGte34ztojLr6bBC4n2ML+DO7/6oN9P4lASjZ/PFf3oYe4kKEQUcSdTs3faxZ
         xKklBoEoRCyzC7NZJdBczwVMy3FDvShIy22YsjePkNNqlnfo5f39kCoyidF6EU7KJ5T7
         28beZUvKZM4ZHhMdik6v6Xa9a9bKsTmka9iAIadPVHWW2G/in/4xGuFquzvs7x3Ooz+A
         kBMnnCt9By5gZx10HCX/PbQFb6ARDCmlIETpcVr+HyOCgya368rBYRbhW/An2vuG7E9C
         l1+xN5r+JaH1ElWgQGwqCGLG4nJcanCJ8KMIa6/zU0r3TFcMktUicX3hEtLA/WZy9cdV
         TmBg==
X-Gm-Message-State: AOJu0YwEvnKtumOVSKeuT/v0Yd4oBVA3MX9m0aXdZmIsEEe+hTler4cj
	sxwfuxGXQMU8bQrzci3LVocyqiJ64kEZGiiSpipEgBNFllI0fgtGILlzZCu6sGx7+tG3TyN4vv0
	=
X-Gm-Gg: ASbGncvxyQSPgN3WaGXGINN8HcDmM/BOAQ+Ea4pdCALwtCje/AQHsRAX1c/IF9q/f+B
	GakeW0gT8CsMRWv45jDoTFWDp9U6SgUYbZoI0DyPMjoeLMxdEgeaZIaBYL5UA4oVlbsOvKjx3rE
	erRVAlt9pcCt9L0NHZni76ECBe8oFOy1l93hBsl1ud8x57nFCfSmJzbG9rwUUA2ZfnL2Mvbtc4t
	PrdrcQjmZBfIe3KCIEC+ckFbGUdh6iy7VBCZqj+F0kDx3ijxyUFMcyj6faJYefC2LQVzqGt49hk
	3NJv7vCDt4PJ2K0QTLiMHfTTK1w3Hlbk5IhBiLi4crrmnzYJpOO/KuKLNwEFq+ynqUzVWDr5jVJ
	WN3sbCEkJ+g==
X-Google-Smtp-Source: AGHT+IGKjEcW8b/8GPzhZUHT1zNIKNgDIj/v7fuhXJr44NKDkgr4AuVO0W+EG6FcVrakZVdFk11qZA==
X-Received: by 2002:ac8:5844:0:b0:476:80ce:a61f with SMTP id d75a77b69052e-4795f3598ffmr68385611cf.39.1744224832022;
        Wed, 09 Apr 2025 11:53:52 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47964da3c4asm10539011cf.21.2025.04.09.11.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 11:53:51 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: John Johansen <john.johansen@canonical.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Fan Wu <wufan@kernel.org>,
	=?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Kees Cook <kees@kernel.org>,
	Micah Morton <mortonm@chromium.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [RFC PATCH 24/29] lockdown: move initcalls to the LSM framework
Date: Wed,  9 Apr 2025 14:50:09 -0400
Message-ID: <20250409185019.238841-55-paul@paul-moore.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250409185019.238841-31-paul@paul-moore.com>
References: <20250409185019.238841-31-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=734; i=paul@paul-moore.com; h=from:subject; bh=MkPoYwIG4TinjPfNk0EXrsRLK59ADeRUmFIT97JZOE0=; b=owEBbQKS/ZANAwAIAeog8tqXN4lzAcsmYgBn9sH7zz2TyyNFtvO3UgRZnEV312ilpaAUNyWAI hQx5NGZYJCJAjMEAAEIAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCZ/bB+wAKCRDqIPLalzeJ cwNwEACfZo0wxnpfxkfjEszjRYFP9SCK/ie6gsYwcnTay9PKHXK8dv/Z4Hkt3MEWRmw3yIhWk2x 7bhGuKKRKWE4yrAbvkiEtFiApt10TVNU8JbiwrAJ6tVn2P47KPw0xGf70X5FLCvTKepz/k6+n9h D9jcyIOM5XE5nOUB6ojFqnLxOH/6C1QbrYBsg9238A1T1MVqk438tnlXYt1vQ5shxMM5nMYRGjQ yLAFBk9r5KP6f81vUEOVBA9gi2FgAYt1tWfUxWlOdUmTb7b0zAH/FL5K3Hga5NWgt2L/sr8D4Yb jBSh0HFxlXRGUe+ImUxEmqjZAREIwIP6KZuN4Q1hItmkTijpeY30koe3NF+o3f1+M/NvlC/I6xw alM7u43vHu5uP+1ehpTTS4VkdeDfv2a5Z86Mk/fZ7c0k+gDkaDBIuFEpnDuIGKxeoRZkIUut7zH kNg1TRNxeU4HxyJ9kSvhuX+VzgunlavA7XD6KFeQA3rrscdJPiLTQPT+NKxCKxrJ+7MxO5WKkCM ovXoKMxLPvHVbTbBYiPkhmOUEOsBcCQie+JGS6MTZSQlgyqAH3/l9O/s19FdSZO4OeAHQyGZb0U rt9tBhntZiEZ4EzbFllxU1uO+BhsfCtmhPWzQpWqYdAeSXS94BWyheG32ouvcy9XiUH1co/8qVn uNrcYeQ+acXJCew==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lockdown/lockdown.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index 4813f168ff93..8d46886d2cca 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -161,8 +161,6 @@ static int __init lockdown_secfs_init(void)
 	return PTR_ERR_OR_ZERO(dentry);
 }
 
-core_initcall(lockdown_secfs_init);
-
 #ifdef CONFIG_SECURITY_LOCKDOWN_LSM_EARLY
 DEFINE_EARLY_LSM(lockdown) = {
 #else
@@ -170,4 +168,5 @@ DEFINE_LSM(lockdown) = {
 #endif
 	.id = &lockdown_lsmid,
 	.init = lockdown_lsm_init,
+	.initcall_core = lockdown_secfs_init,
 };
-- 
2.49.0

