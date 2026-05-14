Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA022E1C4E
	for <linux-security-module@vger.kernel.org>; Thu, 14 May 2026 02:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778726208; cv=none; b=EU5pleYOzq8lVY5k2TVvrRKEU83n9FUo1/9p1TKlCP4Q9PdZl7htmMjrEdRSYALTfqJzB6OL2kMG+I2I0m4oAg3LEvguglMl0t2ekLlCiSc7ks9gLuT4seGMGvKCSImf9vkgy6lsFrMgm8twC4dBwEO+8Kd+TDOGH15WTML/dj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778726208; c=relaxed/simple;
	bh=WMhniOJSWPxMGmlQegkClDH6ch6QzSrRNimBuWfzuBI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XDDMQqd7MlI0KLksZMZJm3zfJX24tq2+HK7MMpZvyJqmWvmLMro7MFSHoIKBT501qJMRnDg8Pb0Cj4PybEf/AqrhnWSylrPOAdjrZNf8vc0M6X+wHg8iQmN4bwMxZrHS0ZXHuLXlBspRVw8eOjNavl62Iq5BSglMXIuSA+KILpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Rom0diOT; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Rom0diOT"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8b5cda2dab9so69491816d6.0
        for <linux-security-module@vger.kernel.org>; Wed, 13 May 2026 19:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1778726205; x=1779331005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=myRSXff2zZ7XyiQQfJfIlOKKngpbcODuIS6F/L0JmT4=;
        b=Rom0diOT8xIL5sa/U6b3Gg+GUhoBBVSoeqWxZKla8S0Z9gUH7GtCARxYktroxYWW3v
         dTLl/qdcOm5WP+JG/A0ytpuSQZQ9vMw35GaZa+Sb+DuVL6URO6787MiZgRm6TsRNrLYn
         Vtar9sFwndF3uBAgLV9/p9DGcWGscHFnrHsxlocq7fT1GcB0g49w+NcsvqOjNhlpNVK+
         9KBvV9R17iZuE3bWyW2HpXzweSkTYO3lJ88iX3oKRZnEoAxsg2sPHyNcIQN2BWsgdBY4
         P2+HMxALvWW2LlNBPY3GwJIIVLEsq/jZIE2x9o3yCNdksgM3oE/WXDq63YBANMblqlF6
         IkQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778726205; x=1779331005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=myRSXff2zZ7XyiQQfJfIlOKKngpbcODuIS6F/L0JmT4=;
        b=V3CQ8KHaqkUxSLL8C1Tx+Fp7qGz0E9GIrvddTWfp0cB4vvLTXRaQ/2mvSysjxWfz6C
         VpYjxcvH0dlRg+gUDekdB5lZEVtjAiVrzCJr1dnBogx6pL00lYauu4M3Mj+acm9MtLyq
         ZR1t0EUkSVClXFsJIyCJGVd9prRocIn/K+rwEUjKgWqwEu9S0ydB1nBv8aKADIVAFiML
         yaFbvBjk7m0Ff0wlmFd91/LXL+Buel4c1wLi4SOWV+Yys1Hk3hNc3quICHGF/7mFEyH4
         ahizNtOOybCcrBP3Cl9L56yRAPTo/MJLY1hbYTnGycQOaTQGEN/pL+SQPoMX0LvOkh1c
         5TrA==
X-Gm-Message-State: AOJu0Yx8NCUtWVNzt60g5EOYAMD9HN0TcNsnARgINpgK0DFoXUSK/NZg
	ALIB+vp4MIFt1c4XPF3gm32Ni3Yi9SxLNX08OkvRSLJt6dS3aeNPIZFfYyAQ4+MrdT5demgNGWw
	Dtgs=
X-Gm-Gg: Acq92OGVh23MGrlyUz/EMmjTWN9W8ZvJl0Ltk17ePIDyNV6rvT/c35B0lQBf87ApqVR
	e3kYuApLk9djdPvLjzrKQXGU7KqvmeUv2KFJ5yPDsJ8QraAvDykQuWV0UEHA29G8lqWT75Vm8/J
	0eD0AGMQ1Cpgoq2lNkI2uHGwEkxXx83mK11FLHT5SEo1mPdA7/SnjGkCAMZKYw1Up7qwmYhau7d
	8KuedksDgBMPTosjzyDmoq9axbq0Fs4G6IbcSs+Bfh+iJO/cRNh9OcFg8z2vm8sHNYo/GjpWgHJ
	dBvx2sxEEb9/6A6VipW2Z7UHvfV0DTPYKXQyJ59CLs6SemnrLUrdHu1HLbwbuofERPb3TDfvTIM
	8hVA6iq6ANij9Jugr7YXY/HN7mUjH0YhCGkhbaXl7GpcjsoZX/0mAGBuXru4dDwtlp1Z65CA4o7
	vF4TbodopGgNwOj0NtDMWYjpguetPqn55zZiF+3Awkjk3fvTiVoqWRVOOl4/w+lnQDRg/EB7g+p
	XQQuhQ=
X-Received: by 2002:a05:6214:4801:b0:8ba:d36a:8b0c with SMTP id 6a1803df08f44-8c8fbd05f71mr27017326d6.12.1778726204949;
        Wed, 13 May 2026 19:36:44 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90874d869sm12080766d6.7.2026.05.13.19.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 19:36:44 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org
Cc: Fan Wu <wufan@kernel.org>,
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>
Subject: [PATCH] ipe: restore the kdoc comments for evaluate_property()
Date: Wed, 13 May 2026 22:36:41 -0400
Message-ID: <20260514023640.574020-2-paul@paul-moore.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=921; i=paul@paul-moore.com; h=from:subject; bh=WMhniOJSWPxMGmlQegkClDH6ch6QzSrRNimBuWfzuBI=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBqBTU44FhylTyessKOIkmPgqrBH4BKo7y+axapo XinLBYjOhqJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCagU1OAAKCRDqIPLalzeJ cwtQD/9bzB1c+jlZxAbvKc31AMXEU9c8yAZkxVBGuvfoe/JkMZEAoHRuD/ckBCXvW0/1s2yNNC5 ZaxMnRVIJa0i56vihp/+pQPh9ZvyVrjAecbKGkc3Y4lO6zCeQrbFPzax1VwPEUyVVGzyHkguu8Y 17IRRmGikNOVA0RK/TrPpwZi7Dwv/OWzyt8YbeOa6bvNcOHmC+oe/zX/aiPMhcWnXQXfbAyZGXW vE1Wi8gUrdslHqh+5aVObJ2NO8f3RubzTv5eOPBEShrQ5j/kUqxqR3KmGyHKEDi0yXGSgf3Cc1T NMB/RDhYWVeKH3VSNRV9mr/rCTZRbG7Fxkglv7Pa6vTMKbIkho4LmUUDtDIVvpEjKndbzVeYg9J m63V/M998oW5QacEcpPWiAlDY8wLvOcjhPiTYp9miJTaSI9SyLTbmishf5DWvc8lvT7H9lq8b/Z Wt9mRf3s/YVWbxMeaC1MnFnM2dFfiobnNwDjhopFPQ0j0h/DsqFiFuWuTNU64RxBN4TPpXKyJXW eRsybQBqmF4z5NewOOf9wHu5oCMW6IsWuoNpUdIGRlECYeOB4E/LVhMg7COZnWhg/U95uceBlzC iP9bapMOi4a04s+guZmln3Q/uLSy93pcNRo3wha0iW7Yvh5ryJEQhZnZmgKVfeGFxGK4uBz3Uke p46qA0evgLBeWEQ==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

The Hornet integration patch mistakenly munged the kdoc comment block
for the evaluate_property() function, this patch restores that
comment.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605141037.VVorBhvP-lkp@intel.com/
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/ipe/eval.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/security/ipe/eval.c b/security/ipe/eval.c
index 705c4ecfda69..23ae1edf896b 100644
--- a/security/ipe/eval.c
+++ b/security/ipe/eval.c
@@ -331,7 +331,9 @@ static bool evaluate_bpf_kernel(const struct ipe_eval_ctx *const ctx)
 	return false;
 }
 #endif /* CONFIG_IPE_PROP_BPF_SIGNATURE */
+
 /**
+ * evaluate_property() - Analyze @ctx against a rule property.
  * @ctx: Supplies a pointer to the context to be evaluated.
  * @p: Supplies a pointer to the property to be evaluated.
  *
-- 
2.54.0

