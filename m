Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FCC3294E4
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060855; cv=none; b=Wt5OrOmHVyD74sX924O7Kl9IN16e/H0hln/atpVtwWl8R5MNOnsYNinkbMYYYMrdxWMJavRxt7QSYSHrgyuTInvFTTXZXoOoKmgLCwkgE4/lAh8wNwINX57rnT8GaKX6IFpgp7IOe2D+9XZBccfYX04/Nva54ir/LCU8xIaJ3pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060855; c=relaxed/simple;
	bh=mbrtZf9bOS9pgfXCSv71LdHYNEXgUh6LnTJt3ijKQe0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VIenxGY6/gF6s6fw/gXss8U6eF6EILgDd4qNeu/mYTbETZshlZvmBGjbh72YYjVTVRWuXnCtm9XjkpLGaR64G+umXForU3iASTlS0diMtU3GgzwPEzSQxnNwUdqTFl7ZsncevEs8Nr/r4jp/4teq1fQo+nyp+1+rIxa6yPay7vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=a3vkNC/u; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="a3vkNC/u"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78cce797cc2so10700496d6.2
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060851; x=1758665651; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wcl2fixASQNkgI+qWy3dVn05HBYvzj4aNmOOyaBFBoA=;
        b=a3vkNC/u26duPApRIlTqxQ9RZFg6IG4t2IzK7OVWdbK5gFvZk2jwTpWHvytzO57zBB
         y3F3EkfCNSIJo35r4hceNV9QVxIQn3rFrqkMCFmxICVSBTQDnW4LMEbuME9PAQzUiVZ7
         PO8KbuUdadmkevCGpwGnOpkDYoUwr4htmJ7tJyjHED4A4cBOiFVWyhQg17mAjF/Ht1iz
         TujGPnQMUJQT7xBPj4wAfxnrrRheykX5ADXkLNlYJaw6EOAu2r46YfJzskHPdNkHMNWU
         /PmtY7u0H1Fv3FxMn+KtFl10aiIJWvgG9ZRQqDNuQUZ6HOWxuhKiKbHtbdZ8vkdJmyjn
         65gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060851; x=1758665651;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wcl2fixASQNkgI+qWy3dVn05HBYvzj4aNmOOyaBFBoA=;
        b=IC66bfwcaxIm+A9w+baykgR+BdCO7sf2CAUXemz/ehQ72U4DhlbfZdqpsyxxC4hc+c
         igMBAI5Wp/sESJ0it26kr1YTqj+gVNwn0qNDtlE3V1BFlttZNLNiYHz/S7Mqf8KLAmlQ
         ORve8+OHMlV6RgLxIzeK8OEoJQEpkqWCu66IovOTBNohnfkQgf81u4EvF7pXrMI4kcml
         aYaxLqTMxk2V754uZ3zfNnEyTiUdxHNyRunI4sQwvKBPJb85W5H7hiAHStvluMAcw+QN
         7K/1cEM122fmLonQS3aKyFXMveQdCv+N7mslQBYnT3sQqzdOr3QMAIAnhLdf+THoWkbf
         opow==
X-Gm-Message-State: AOJu0YzomPbF3zC+/gEbYcsoZmiWmZTUV/ltz+EdcZ6ootE6pbjYQ7P2
	v3NW5YKiISa9lLuVhpfRIiG2fzDKAof9U2waT5ECqG3GidNQkw1LygnswcxGZ6gxgEr3ZNp5ekj
	YF20=
X-Gm-Gg: ASbGncuTp0/EEQn3LZ+UMzQhm+ly5GKdhkjNGqCUTicTfukZfPnAZdCCVaZyPIjsp0e
	IaKXj3RAXctKgFRHG4I51V55ouoVDzBcNq6v4OUUIq+i8csFKY3E3dWic5ApUtHQN68O5eFzI+D
	nOUP/HvltVsou8wSZKu21908/81T/zBd6IobI1HW6lCJAvxkN9+vnEKDxbDA4UW0dN7QgmJujqA
	G5BJ/UjQBrXh9POTlwm9i6OVn+23tkwnBlseVd8PWUIfFsnZOpib8MGV9iVPmSdZyDROeo3zvYq
	fLzUrpJu0jUsvQrEXPvRKiEFQ6nTc0vog5qRmRmrYu9HcxGf7cT/xN/aTYxOI/UJ4lvI/sBFqoc
	Y5ddEQDTZlyTSiHPKMhSCoFsr47GWq7s1cXPc4oDw5X+WA9S36xwe0sRutqw7aY6TGwbX
X-Google-Smtp-Source: AGHT+IE7VDyQwt0iMpZDr/QXQ64UR1zTCi+6UpxLl8UGMq8XLQV4GtnegPot0P5ZpAhQpcBY4vO8Ww==
X-Received: by 2002:ad4:5741:0:b0:709:cf54:2cb6 with SMTP id 6a1803df08f44-767bc8d551amr229823596d6.16.1758060850800;
        Tue, 16 Sep 2025 15:14:10 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-763b54a1f09sm100450106d6.16.2025.09.16.15.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:10 -0700 (PDT)
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Xiu Jianfeng <xiujianfeng@huawei.com>
Subject: [PATCH v4 19/34] lsm: add/tweak function header comment blocks in lsm_init.c
Date: Tue, 16 Sep 2025 18:03:46 -0400
Message-ID: <20250916220355.252592-55-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1907; i=paul@paul-moore.com; h=from:subject; bh=mbrtZf9bOS9pgfXCSv71LdHYNEXgUh6LnTJt3ijKQe0=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8HiCjAkevQZjJQISZc5FQ1r5Yh+jkW+dVO7 P6GrLD5YXKJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfBwAKCRDqIPLalzeJ c4+tEADYP6tM4QJ2IXfgMtnvka2DvTHO5w/u/w4tgbdTjOw4W2NBYYL8IPe3OxF2LUVoGr6WoUi TAIYO+okDNuXN6nYq3Y+bzhqZE5FZqhu7ylD8rrsG34LXHqfwc1kn97qKgzNCeQfkAdFfWeSuc1 91CdHMgrrgKgBcqMvqqjWN1eYH4re8licR6/UAxVnTCAyZrnva2LnMuWN/MtzxlCtPLlAuVbO+4 IkOJyKIFyvMktBJYd5orCjydtv0c3qkpoPsUq6OgPOTMnwopZh0qEoIIg23yHrLGOthYYFRkjaw tWVehOVlTagcH13ZXKehFUWbsffhFn5CaAA4Ic/qWtx2REkdz6PsCZkavquY/VRVFfJ6lshBGfF Rjmdji/U/7OkMtuNinxKSVCtYugfsRhAPmQ/I8jx2RX7Y3BSWvBVHz5QmeCzSSDzHSaqS8vvogd +ZKFATwoe6AsCU/jIh5l3c4sRYMSLgTmfGbkp+cxh8wRj5VHWRHZKBajv+cJ1+q3eFS0SM091Zw w1r3YKWcTR8WuOjDYd+RhOUZA9wt8l8hP+c9J3uDnk332PStxvD/p/WAOdKuqOBQICwNid8AbxA CbR7EXYqqj5E5qUSOQYhb2Kh7FygaT3ck27oSX+wDLcDlpuTUCujrCtNzgA3sJJabr+p9tpvQX6 +UptfXiBBuWRkaw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add function header comments for lsm_static_call_init() and
early_security_init(), tweak the existing comment block for
security_add_hooks().

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/lsm_init.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/security/lsm_init.c b/security/lsm_init.c
index f87f5441617b..37593805ba9e 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -315,6 +315,10 @@ static void __init lsm_order_parse(const char *list, const char *src)
 	}
 }
 
+/**
+ * lsm_static_call_init - Initialize a LSM's static calls
+ * @hl: LSM hook list
+ */
 static void __init lsm_static_call_init(struct security_hook_list *hl)
 {
 	struct lsm_static_call *scall = hl->scalls;
@@ -335,12 +339,12 @@ static void __init lsm_static_call_init(struct security_hook_list *hl)
 }
 
 /**
- * security_add_hooks - Add a modules hooks to the hook lists.
- * @hooks: the hooks to add
- * @count: the number of hooks to add
- * @lsmid: the identification information for the security module
+ * security_add_hooks - Add a LSM's hooks to the LSM framework's hook lists
+ * @hooks: LSM hooks to add
+ * @count: number of hooks to add
+ * @lsmid: identification information for the LSM
  *
- * Each LSM has to register its hooks with the infrastructure.
+ * Each LSM has to register its hooks with the LSM framework.
  */
 void __init security_add_hooks(struct security_hook_list *hooks, int count,
 			       const struct lsm_id *lsmid)
@@ -353,6 +357,9 @@ void __init security_add_hooks(struct security_hook_list *hooks, int count,
 	}
 }
 
+/**
+ * early_security_init - Initialize the early LSMs
+ */
 int __init early_security_init(void)
 {
 	struct lsm_info *lsm;
-- 
2.51.0

