Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E23FD1D5CC6
	for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734155; cv=none; b=SXS50b7la2kMMaQAIHWwxY3heGtNdBF43vMiS6S56cgfucsm5M5lY/UoyIqsabDoYrLte3soK/72CBRAmNMEjoj9PDHnD7mOqnF5VdDJjIA8BD8/xBrA78JBBw8vvr7GmuxvHNfmvWbfQw7KlMrDDRG6zFvBk8qIQ1st1dK1ktA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734155; c=relaxed/simple;
	bh=WKicIXmz7bnIQGhAXSwDfAouRuhWgFryW5dnjoIl1Z4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Io6kTr3yY9VKIBNKPrzHnntRTkGVpDvk+qTC6NZ5DajK4++9JHIW5PFgk1UZYtOgxdYDVsyk82GWnPq6qnA++al7RwRErivENc3JBA/lc/A9fQgdhVVM6VmxmnA/hmqxDjv4O4q6SzkasUd4rr+DhB6iZ5VXZw0SRJBWcvzNhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Va/+6G0Z; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Va/+6G0Z"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-88f86727622so348748085a.1
        for <linux-security-module@vger.kernel.org>; Fri, 17 Oct 2025 13:49:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1760734152; x=1761338952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RKtz/vkc290/v3y7dFkvXfjVdcrtyl+E7FWTxNg0D5A=;
        b=Va/+6G0Zj56SaC38gysg7S+eb+skTwu7auy03obW0Z5qPB2XTruqVQb+D1UW4i4ovH
         Cule3L7QynhW2TudzCK3Fj5PO4yGwO7MhZO6YSLD6QlvUkHrOimxEdfhrj1YKviMGwOa
         GFONhMgAhfd9LWoBDPaWoLFXi/VhUZ0pt2x9sitPfDLA0MrpuPetstL4YYG+DTk3+5kV
         qYV9sNQLQZlmrofmNvZcS3eFwTBAIaaYw+LSaD//UX3PYg8Dlxss2ie6tSDETuaMDemK
         qHdnlKP52Pd8Lrao63e2MSkB3omxjGyoWW2PdJgcmmgX6PJItVZEsO9CTWZSGCnSMqRy
         z74Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734152; x=1761338952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RKtz/vkc290/v3y7dFkvXfjVdcrtyl+E7FWTxNg0D5A=;
        b=Ul5MTmay/i+SdNmBY5dPesISdS0NzUBTrKw9mPOQS4m9hb+/l4IOrdWDTQROKt3NTM
         Df7fq76O6src8es3M4OVsOvuvx39ahI2aigeTe9rUOkUi3nuTxZG5SHLgYT8M2+QMh80
         kjwOdFV0Ps+6fxpfdQ6doHlD70NfIypP3c42OpgKCCx2BENLReZWNXrltvDACMXcyBq9
         gjRM4p+/+0UlYQqpxyYDtTctkmtuTfzRZCzPAZ7CUiDEt+ypVm82NPKvVcH9uZq45p3o
         owv5JvhwRZSfy7PTqt4tPfVc8BcP9XVWCUIyYSnlQ1OYSOxgE3hpp7hUk+YtNurUYwSw
         3aLA==
X-Gm-Message-State: AOJu0Yw3+TvW3h/sCiS5tkinQ2aO9j5670Ugi4CSGKkeYgydftXhihcL
	Zaw75vRD6+o9dSATomdtWJrh9iyaDO/E6ObXHysVTgrAQV/rbsyliYLr+rSVABg9+ZpOA1oEmJZ
	Zc4qjSw==
X-Gm-Gg: ASbGncsowOlLfdYgXzslBLGtDu4NL2jahCEosn50VF0OeENugm2b1jN0pMrWV4JafWE
	jFgX0fHVp86ZWa9Q5oB0pucBEkJV5lZ06xqzqBGADBE/f0ejkw21vwe6bPB4x0X9OdRm8P+9IYg
	58RHI8PhYBMBn7t/eRPGblKdoadXqT4z8okaVDpgvV9blls7aRncTMH40EaeIlzkmVrNC2hopoV
	lcWbK6St+iP1uhevu0tYDwuyHHRSJaX45CzWZT42KskOAMge00KxNAcTPWCLRDK37ldMI7FLUjU
	xjckEqiWzfjf8PICKFpHCBdRk/zjdfCOYmpDMAsMoWIlR9xwGz6kZrVCUhCyyIbuipKTlNcPcwL
	qanJDl/5mmCk6uUcrEAZDBS4lc2kzuZOfhLA2YJd07RZusgJBT89oxflbIiJRftH71PHiItQsDx
	vF4Md5QoZXOaqZgsfwSHPu+Ri20IfO1PDiqKEhqKuffi5hCY4xtkNYlhKV
X-Google-Smtp-Source: AGHT+IHGZu78yRyhIKfalS/+sm4s6XszeQNLh4vmUvi7QqFzyQmuCMuSpemEdlt2MRk8WCsOPnaUQQ==
X-Received: by 2002:ac8:5707:0:b0:4dd:ca89:8d7d with SMTP id d75a77b69052e-4e89d3a27dcmr76029711cf.56.1760734152046;
        Fri, 17 Oct 2025 13:49:12 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-87d028a9987sm5018766d6.44.2025.10.17.13.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Oct 2025 13:49:10 -0700 (PDT)
From: Paul Moore <paul@paul-moore.com>
To: linux-security-module@vger.kernel.org,
	linux-integrity@vger.kernel.org,
	selinux@vger.kernel.org
Cc: john.johansen@canonical.com,
	zohar@linux.ibm.com,
	roberto.sassu@huawei.com,
	wufan@kernel.org,
	mic@digikod.net,
	gnoack@google.com,
	kees@kernel.org,
	mortonm@chromium.org,
	casey@schaufler-ca.com,
	penguin-kernel@I-love.SAKURA.ne.jp,
	nicolas.bouchinet@oss.cyber.gouv.fr,
	xiujianfeng@huawei.com
Subject: [PATCH v5 11/11] lsm: add a LSM_STARTED_ALL notification event
Date: Fri, 17 Oct 2025 16:48:25 -0400
Message-ID: <20251017204815.505363-22-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.1.dirty
In-Reply-To: <20251017204815.505363-12-paul@paul-moore.com>
References: <20251017202456.484010-36-paul@paul-moore.com>
 <20251017204815.505363-12-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1136; i=paul@paul-moore.com; h=from:subject; bh=WKicIXmz7bnIQGhAXSwDfAouRuhWgFryW5dnjoIl1Z4=; b=kA0DAAoB6iDy2pc3iXMByyZiAGjyq6+ghB3O3BYguG+6jVCkggcsRoWS+8eeqUiOeWQsm4zWI IkCMwQAAQoAHRYhBEtCqM8H8pnVVJd+7+og8tqXN4lzBQJo8quvAAoJEOog8tqXN4lz4uIQAMhf t1D9gT3dBoizePCN9guhDI5Dz5nrvexVFzSF+5Ry9flh2HBkmO1QUy8OXtndsXa/76/yKY9UPF7 q632ClOg56jdniSVdfcVfwoFO4lizUTBLkIOfuf/LZy5f4dZHDrRHMUC1h4DmqTQWvSnwWyYYhx NJOaTYTcPxObVnE+3dVNvmOiD1baRVgZNiBs5iV46+mwZqUoHqDAynp6JuI53jgQCJdJkr7m37b 3YxgMPmqVbxLWDDwuQP9HrRT8ZKHpUWvxVU12NjBOnkOVcdGQG269vB6dIF8sEEuGLYM8+YIngp NbltnD3w3eQLTnaWa7m2DUlrNdUIvOKg3iKCcvxigKEKshMTyGBRZ+kFy9g7HCWm4JcRxO42Ywm 8yOBvHex8RMVG1xJRFCjM06PzEm1vL5YAcEua9YDlGydnIn2c52Yje7IWIfSSnW6DKx2wLILP/C sSl4ZIMfiLrfoVUO1UEyTD5AvkBSU75xB4OFDZrE6/EV1ZoMENUCzBT0Om68W7bN+Nmmk+EmoDK 6KWfyQX3Lw2ZWdARXMDydi/CdjDVlVO6ILKzQNFH90NgIKo1evEIlOXwLU1HKYjD1MweSH+/NBV 7tQTirmn8wPbfUniGN3mlB7+7kIZoWWGiRVfYmutFXI/FC24cfGwUAvY8ERLT3quHblGSlssfnN QWPH7
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Add a new LSM notifier event, LSM_STARTED_ALL, which is fired once at
boot when all of the LSMs have been started.

Reviewed-by: Kees Cook <kees@kernel.org>
Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 1 +
 security/lsm_init.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/security.h b/include/linux/security.h
index 556890ea2e83..eb36451ce41f 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -85,6 +85,7 @@ struct timezone;
 
 enum lsm_event {
 	LSM_POLICY_CHANGE,
+	LSM_STARTED_ALL,
 };
 
 struct dm_verity_digest {
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 0f668bca98f9..6bb67d41ce52 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -556,6 +556,7 @@ static int __init security_initcall_late(void)
 
 	rc = lsm_initcall(late);
 	lsm_pr_dbg("all enabled LSMs fully activated\n");
+	call_blocking_lsm_notifier(LSM_STARTED_ALL, NULL);
 
 	return rc;
 }
-- 
2.51.1.dirty

