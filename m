Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25535F8CE
	for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763575669; cv=none; b=EKlOppe6TDRzGRs+HTj4Y55Ce7pfNKPIN49Lf/L73mXYySK8ZRVUmjOU2hHdgXYhPOfbzvzl0Ukr57l5ZsPR8U1FeuN40GStK5wwFJfMU6E+9JdU89QS61lN4UyhwfUxOlqPOCpqiTuD6V//aZrFd72PE2rcDiRdNvYBnf1OrRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763575669; c=relaxed/simple;
	bh=3RqkxMumRZiF2Na3hqHDZyT4nXmBPp/f7fPFLwbD9mI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4VAlyEWnqs68wmfAzxM7c6KQOBAA+Im9X+/R0UC4gZr5i3NgDhqVKXj7IkF6d5HjoxxLbLrFcr4Wx89Ft4qrllTM5XqKuuZsigc2RX8hmT715OBT9TzMvxtz4AL4VtiR18n3tHgwGsNLRxY5rNkmOA+Tc0yFdu8NEQhWisAj+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RAMsOXFf; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RAMsOXFf"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8b1b8264c86so2777985a.1
        for <linux-security-module@vger.kernel.org>; Wed, 19 Nov 2025 10:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763575651; x=1764180451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aRb64dPsg+Qp0OcFvDdGRbS5EyDXfj3+9D2P3rx0hkw=;
        b=RAMsOXFfuRO3wD5wW9tAe6tZ09ZiasrA3kQeFbQBCVpyBGHzc9GehLnVkE8sOdSe10
         VYknD+I0Y/BRc4Xa7dUZYJOF4a0Q8cJMnPZWxywIyYwN8DR6gcPd3I4+NLRCMztl192K
         Mk+4iNgpJwLyfn1WFT/plP61qieLd9lDquwhCkF+sX8BJ18WMhKqWtWwYrHaXlL2he+6
         Cchxkm7bMRNMn7hy8S1CeoQ7iOW8k1EcyuT5xICBO4mEb1cioqhuUy/mUAUVbp8Nq/ib
         yeQaM+PMo9538uxHtBimn3SsQCN+BOZuWuKrR83I2RSe20bcmnqsNyESfvF2x8zgYLhB
         lnlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763575651; x=1764180451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aRb64dPsg+Qp0OcFvDdGRbS5EyDXfj3+9D2P3rx0hkw=;
        b=gGAx6tPqqvjSn260J6vZM1ao4+Tpwh3/DwIiFZKdbKv0ospO6YjiBpw8/8ozrdttBU
         x38mUORfNV76PqMl5DvC6RrJDmFiHibCTc7WiGYlQJ+/fqvtGAHXTDTFZikB1Vj1FlfP
         zW3dSWE8EqGh/CUaf4m+J16WdDfZ+fiL/KQFhCwlGcz7TyGEfXaKlM0Czdmf9EDgdD6Q
         tQIiVVYcGoMvk1A5ID4GwbBwe0gRgPwe4V3xrGCnMHTa/2I5TU/hhE+SQsUdUXaD4oOF
         dsHHN6ZdmyL7iD+MmGF7xNDCuXPdXTsHXvonDDuC6CT/GH+fbEOJzJlYSZmgenSeb15j
         Vkhw==
X-Gm-Message-State: AOJu0Yy2NWpTmlNPTSizkZw5UGzEMo7UYc6ZPCIaAXO9G3F8OqEGdByQ
	jVeHMwzj2v6kXC56z8IdtCgS0V9KQ+udBKQ/eReO1/NXwwYniVz7QX1y
X-Gm-Gg: ASbGncsskrfTZIXc/uKIBJpVoU192ExzMSfkqPQRmorXAeABFYSc64ESzY0RW+Kjr+P
	wc2iqWLYewyWjQlwY3R7KWFnFADT6EQzp5Ws1gDgT2XiKfVSgF4U1DzaURYCwwzrI1POx0IW2rL
	TEdhNoMrO8NWt4mjfkLZ0ZcCshWDm8lxi4hN2vL6AhZhhBYfjuHbO7g9OGFlXtn9Zc9shgsPRoN
	CMANX1e4FUjPxbkfXHGWukkG4lEkZ1MXEC2iooduW1u0L2j/48oFMVVhU5N8FLjQk/7vWpLdyUM
	tsIY7NADTZ6mTzxnY1GMsv+fSLivK43L5LTe7937hGALlGPNgGvFvuLNE2FuhhR5g/dhORMR5Ul
	kGyuOaaHWZpgdedrINdTtwVDKDRvYTrJxxuPG7kp7ASO7nMc+HwAeYVof06T0OtGIGV4Xtm6hI/
	mYuFBC++yHg9/uBmNMYBw012z7qsqSvJ8px3sr9vDKDw==
X-Google-Smtp-Source: AGHT+IGlEtq9UPmlT92goRTkdus9C3Afqmms2OCeol2+kTpyhU62k9NnVzX7oZZeLjhQ4p8BsmD8rA==
X-Received: by 2002:a05:620a:454d:b0:8b1:c1d3:8e91 with SMTP id af79cd13be357-8b3273492afmr43991685a.39.1763575651102;
        Wed, 19 Nov 2025 10:07:31 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.94.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e54d251sm68956d6.32.2025.11.19.10.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 10:07:30 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
 Xiu Jianfeng <xiujianfeng@huawei.com>, Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nathan Lynch <nathanl@linux.ibm.com>, Matthew Garrett <mjg59@google.com>,
 Kees Cook <keescook@chromium.org>, David Howells <dhowells@redhat.com>,
 James Morris <jmorris@namei.org>
Subject: [PATCH v2] lockdown: Only log restrictions once
Date: Wed, 19 Nov 2025 13:07:28 -0500
Message-ID: <1961790.USuA9gRusQ@daniel-desktop3>
In-Reply-To:
 <CAHC9VhQNGnm6NBSrUmfwoEwAxqedYbHckEkb+J47W5gWjrKBOA@mail.gmail.com>
References:
 <3641397.L58v44csPz@daniel-desktop3>
 <CAHC9VhQNGnm6NBSrUmfwoEwAxqedYbHckEkb+J47W5gWjrKBOA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

KDE's lockscreen causes systemd-logind to spam dmesg about hibernation.
systemd declined to cache /sys/power/state due to runtime changeability.

Link: https://github.com/systemd/systemd/pull/39802
Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
---
 security/lockdown/lockdown.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/security/lockdown/lockdown.c b/security/lockdown/lockdown.c
index cf83afa1d879..83b50de52f21 100644
--- a/security/lockdown/lockdown.c
+++ b/security/lockdown/lockdown.c
@@ -58,13 +58,16 @@ early_param("lockdown", lockdown_param);
  */
 static int lockdown_is_locked_down(enum lockdown_reason what)
 {
+	static volatile unsigned long lockdown_reasons_seen;
+	static_assert(ARRAY_SIZE(lockdown_reasons) < sizeof(lockdown_reasons_seen) * 8);
+
 	if (WARN(what >= LOCKDOWN_CONFIDENTIALITY_MAX,
 		 "Invalid lockdown reason"))
 		return -EPERM;
 
 	if (kernel_locked_down >= what) {
-		if (lockdown_reasons[what])
-			pr_notice_ratelimited("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
+		if (lockdown_reasons[what] && !test_and_set_bit(what, &lockdown_reasons_seen))
+			pr_notice("Lockdown: %s: %s is restricted; see man kernel_lockdown.7\n",
 				  current->comm, lockdown_reasons[what]);
 		return -EPERM;
 	}
-- 
2.51.0



