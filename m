Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3ED468C05
	for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 14:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786546321; cv=none; b=GY8DW3hIQ71FD0PJScdTdq4DMah2OEXxM1v3xx6YcNAHRfJsV5WguzjXmqkB8R99iUWKktKME4Lh2Z8dhcg/frlg7RyfOns6g3deWu0qqGBClDYlkNx4uygRSzRRO5nQW2SOxwycrNvFq3ddjgWV5ILQ1OrWOZO03h5L5xbotsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786546321; c=relaxed/simple;
	bh=Y11hNluv2icyTm8lnL/Bn2Xr3Nk5hYxyS/uz2OwDTlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=g2WrHn3RrjiDuaNrAo3PASNdz1YVJeiJZYVZ9+4dqEfXRFNxiwSWZDRVpgwLG8NSHCHL9re8YJqI9/pZyxge39VP91Hw1PbBHzKBlyrRi/k4vjfX+MDc7NNIND445349P48/FJjBKOnyubWRA+rZdbrcNHLKkb8jM3Bjp96pE8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bIpNDwDa; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bIpNDwDa"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-498012a61f6so59525e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 12 Aug 2026 07:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786546313; x=1787151113; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XFEQDpKGBGfe2eFcLfrei3wf2IxikY9MSg+V8LKW8dU=;
        b=bIpNDwDaNoDqkoC3l8CEzoYUDyT3Q0MvK3PidvJvVtkbnSvlh1vf4QQaKNYrQpJvvQ
         rL5bw+ymA9ZUwWOyDUcyuMjvtqjwc+sCkuhZAIlLVH9wHS+bJT3j7GMzdZmUeGhNzerZ
         VxjKcsm6mOy/EksYQUK61FsZFyh0sdCo1I4IEce/Ncaw479U6l1TGrpzK9QOInzjUj/L
         /4n47azrAuS6vCopKJ9K/5DqRuQWVr6lhaASh64QB/V98CN8Tts1kVRKl27niuuRB+cP
         IpbjGeI4YcmASQRCkaMwDaA/1zfu323zYP35tfgaTdtBerL2ADV5RkfQDeh4vCS+A/hr
         rBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786546313; x=1787151113;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=XFEQDpKGBGfe2eFcLfrei3wf2IxikY9MSg+V8LKW8dU=;
        b=dUyWFrrLZZgAc0NxmSU1LjmXR5wV10x8dmnZTzkelnQ9LX7GX19uQgNiNHy374vv2H
         jAwKlRi5tYUSnNfYeetiyj3HsaWy9vIfbQc5ZRZAGvxrHBXnmJjqypGkTz3JEv3kp+Ib
         kLhrm9WNDynnh5dCdedITmECfhi/YbVlfEK0xk/Mkl7iLgHP2eYxcECXBPPlvRuSXfqJ
         slqM1aSiVaH9jXoaTw4ESwRn3tw7izln7zsUYFS6Iwi0pFASFZaLzhJQ8ttki3Ajisg/
         yyU9oQ1G6nBEfm1v2+S8AJKyZq8G93MJ8wTozyE0btu04jiNNW7txuHF7aPaml6k54DL
         84sw==
X-Forwarded-Encrypted: i=1; AHgh+RomJ1kxDeaxrIGtjwhgCtxIYHLYlMxRnxzM9uVuOSZMe2iQxf0vTva+0G1HSuATSBopt3HcWplupcE7SX25ZNuR+WGcUgs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCYgfFctL07OIcvH1xDnE/0yaVgxIgrDhT/eSU1UhYCCr0NspA
	ZPqZEFyRxRRlZ7H9WLTosmCWUQenNOMOlUaRzZ+DvYc07p23brz9YisoOXTvxxOWHdr0P/IaKtl
	eRh/BDAnX
X-Gm-Gg: AR+sD10WjudRMCmQDsX7rwnEJSA9Nun9spV+0P91yBH7yGvb+zId53/DF1cjw7g385K
	+AV3F+7UlODU6db2t3z7dsDnlA74ERoG4UpEfnS9v9mJhNsTmjxs25QGiADh+ty5NjREXz+s+SU
	KdWgqUr0IBKcsryJC1XOHYqJW/DWiKKTq5EL0/76ZoUbhecx5Olb74Crd4MqqssvloZhv1wtdH4
	FQ9kq2NKpt0JEzakqxW14YkIA82nc9RoXGWssYCNmCJUlRWR7/4coDmUFT+QiySmbml/yEl6BB7
	FBFiMUsLzUysIHCYNo3JDkcG2oFOcR7f13dlAnoBWoFE9yuvkevT8tUOazw+ENWGN1zfxynzeMZ
	1E1879Iuqh3TRvO3d/R3aZke12VRhBSxuxfZ23XX5YBBfimBD1dtijJ/95+bv1ZmFkJ6HW8SbaF
	3jcNFlQ3ks8RI+n/lFFYkCfxLXOD+MafQVsUF8GsFVeF9bplFrMKqJu4fVezavHXIR0/WmlWK+v
	/7akSdfVniGMTlaPVyzYVsKTVh2C3VbxOv6LologVbciqU4v+DMW66TRcJi
X-Received: by 2002:a05:600c:a210:b0:495:51b1:3b7c with SMTP id 5b1f17b1804b1-4997ae8fa87mr1131525e9.8.1786546312851;
        Wed, 12 Aug 2026 07:51:52 -0700 (PDT)
Received: from localhost ([2a00:79e0:288a:8:d358:790c:76c6:1a58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48150d4e3f5sm7852708f8f.22.2026.08.12.07.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 07:51:51 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 12 Aug 2026 16:51:46 +0200
Subject: [PATCH] cred: remove RCU initializer for init_task.cred
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260812-task-cred-fixup-v1-1-318440888adc@google.com>
X-B4-Tracking: v=1; b=H4sIAIGIfGoC/yXMSwqDQBCE4atIr9OgI4rkKsHFPEptA0amnRAQ7
 +5olh9F/TspokDpWewU8RWVz5JRPQryk11GsIRsMqVpy64yvFl9s48IPMgvrWzQ+CY4tLZ2lF9
 rRB7u4qv/W5Ob4bcrQ8dxAnvxW6VzAAAA
X-Change-ID: 20260812-task-cred-fixup-2e5c5dbe6a3b
To: Paul Moore <paul@paul-moore.com>
Cc: "Serge E. Hallyn" <serge@hallyn.com>, 
 linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel test robot <lkp@intel.com>, Jann Horn <jannh@google.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786546307; l=1236;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Y11hNluv2icyTm8lnL/Bn2Xr3Nk5hYxyS/uz2OwDTlE=;
 b=iin2C2yYQ5icjSiLi/dBPRCgsywT3zE78fmJNMR5iknlWOt7ts2xtWfrUVm/Moc11GnsHrCwd
 pm7bN3axQGsD7sevRgPL73yTDOYXXsnc4uOXvaXDEo4Br5f2oHErHs6
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

sparse noticed that an RCU initializer was left behind for init_task.cred,
which is no longer marked __rcu. Fix it up.

Fixes: a4229a2a16a8 ("cred: clarify that task_struct::cred is only for the current task")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202608121153.nzs6HZg7-lkp@intel.com/
Signed-off-by: Jann Horn <jannh@google.com>
---
maybe squash this into the original commit, if that is a thing you do on
the dev-staging branch?
---
 init/init_task.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/init_task.c b/init/init_task.c
index b67ef6040a65..6529b002135b 100644
--- a/init/init_task.c
+++ b/init/init_task.c
@@ -159,7 +159,7 @@ struct task_struct init_task __aligned(L1_CACHE_BYTES) = {
 	.sibling	= LIST_HEAD_INIT(init_task.sibling),
 	.group_leader	= &init_task,
 	RCU_POINTER_INITIALIZER(real_cred, &init_cred),
-	RCU_POINTER_INITIALIZER(cred, &init_cred),
+	.cred		= &init_cred,
 	.comm		= INIT_TASK_COMM,
 	.thread		= INIT_THREAD,
 	.fs		= &init_fs,

---
base-commit: 1f2f7a1fd1fc34e757107e3a3849f8d22b14cc6b
change-id: 20260812-task-cred-fixup-2e5c5dbe6a3b

Best regards,
--  
Jann Horn <jannh@google.com>

