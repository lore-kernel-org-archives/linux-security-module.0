Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6611243378
	for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 23:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753140275; cv=none; b=QNUjaMXkgXxmG7YI1bDN4a4rb3wKzSxrCdI29ac0A13pLp5x7/oM+vWEw5yOQYcvTc6bbaaQMhnIGLTzjtYF9GAgpHpdTchfnfNB0zVYLxfk5SZMCNEgvT3h05Ha7WKT6ImX4dPF7u/fJnoZcDPh0ITaVj+mCMgQTYrCD3hGVhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753140275; c=relaxed/simple;
	bh=dtTlDf9Zs1w3qXgBN4kcfoXdJ9Galgh9dd6NXDYVJZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVbavMj833a65m5avyClgQXVzTZRCfU0Dv8iI/AaRz/1M7+iQkzvecQO3ASM+d6CFjdk5Zym6Gr3UilJHvDShXDHcTGaGPtlMlVL9SGfAKU1fLxCKrFmCQlWFFTH43OGPM7q35EGo/1djyJMRexxty1cV/jc0KqzUxV+t1URNLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CBzCQrjU; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CBzCQrjU"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-7e32c5a174cso468185985a.1
        for <linux-security-module@vger.kernel.org>; Mon, 21 Jul 2025 16:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1753140272; x=1753745072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4osn1cU2KHpyctysVPOujBHcpLOdAZCknxigtl4erg=;
        b=CBzCQrjUfV4R8fFYnokVkLgmzsFVP8Gg17oYQ29VLVoAtQlGemi1aOEIJ05eDsPSNN
         +Hakb8SVfIL8l73OA7So8wpyLjqMibcs2nV567iz5HFn+tGTJLlZ00w0vbmTDkoqBwtG
         Aby96dwIEZyCjFsazDD1KpU82BfM4ofQJ4bL9H57UEil0l7UlzMS2NpuoPjNQS7XoRTh
         6OKutoI5/I6czFZWiJZMZzNxhwLbEnx2b7WYRko7B0OicKiLnPa9OzKctECFqbdE7fcb
         5FE1sbFZFTWBPo+5pBIwf3wnu6lD/q0Tsy6WoP6UEQ1ZsKH3MMwhJBqhb06Q/pX7Xudm
         KzAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753140272; x=1753745072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4osn1cU2KHpyctysVPOujBHcpLOdAZCknxigtl4erg=;
        b=B42jWogPzDqbi+gcq7eKKmqDanO3G3Sv8VDmEsKqY9AX5v4KQsh3UK8sds89NEjG2T
         uzCub+1aN5YLbNK1WzPyNSuw4Bw85fx7RvBCV/tkRnSyL41XU+mXz2RlekWaqErsW8uv
         0VhbJNh6dkeo24j0GR5YBkNgxMxdpegFRAiz9Wf3dbBnw3QBTaEizfy5pOB6zktWzrD9
         OoKPtvWIqH2M3uwtPyEx3zcgDtac1fRaAjpCr1ZzrMC3lOXX5txaUfmTdCzEkfenzpbl
         w15a5Hl5XimFcS8m9tksy1GIgprpE+/9uDYXdFzbfcwCjcM2RQ6JG2ZnHTiDGFZ5vonF
         3rmg==
X-Gm-Message-State: AOJu0Yza//CTWhtUS5AzIefJLE+kChNJb1PvqC5am/w3w0jsVSzsuAjr
	N8RhmySm3UFxQMdWKSgtJCp4bkJvl/fgVmXHoRO7TlXm7HwJK23p+rv+UVFTPnHj4OKUy/5JnC8
	B1To=
X-Gm-Gg: ASbGncvliPRTYn5uslqmtnHLJIMNYbDdoBDQs3CEzM5xyZOjJB/58p0ouasVdN7ZDKV
	YcMcMpJPsVM/KQqzC3Uz3m990zY50KQqEcZjOwA33RmRw1NmL6wFdMTbSWoRMSB56+QSXHNiff3
	ipwH6+NhIePMkKf2XEovbTT+N91q7B3EquzG/hVOFXDjJYzpJOVbuCS3Eq3co2gwkhzr9zMBqV9
	olWTCHTM5PjQ6wufQD7TA/XvZZVaGwzGTqVHlvpGmYDhPDAF1EVi9z4uqE9Ov1f5cPqHmUnJEgl
	h0APG+Bi2MGDNMG5SlxmjiJeAv0/LS3LKO8rtZkQjXtcUwq+XreSVJ1orPKe70S60TdcTKIbDri
	Yu5aNIhruy7bohATL1Drj8gswomN4O+pN8Zw/f9qgBv4TkRtVbrbx/aoveunTOJiwvHw=
X-Google-Smtp-Source: AGHT+IFkxGCxtcFnWVigtUFhdyx2aVzIyfYem/1oEuP3/Zm9qp6xaLQfWlhY3zSnEccPCMBAk1ecng==
X-Received: by 2002:a05:620a:12c6:b0:7d3:c4c7:75d6 with SMTP id af79cd13be357-7e34d9d33dbmr2054160585a.47.1753140272445;
        Mon, 21 Jul 2025 16:24:32 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-7051b92394fsm44367576d6.51.2025.07.21.16.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 16:24:32 -0700 (PDT)
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
Subject: [RFC PATCH v2 30/34] lockdown: move initcalls to the LSM framework
Date: Mon, 21 Jul 2025 19:21:33 -0400
Message-ID: <20250721232142.77224-66-paul@paul-moore.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250721232142.77224-36-paul@paul-moore.com>
References: <20250721232142.77224-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=776; i=paul@paul-moore.com; h=from:subject; bh=dtTlDf9Zs1w3qXgBN4kcfoXdJ9Galgh9dd6NXDYVJZs=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBofsvy3UEZdfYgB23vwGfEkd84LDlsFR4wF6KP+ yniXnVb3q2JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaH7L8gAKCRDqIPLalzeJ c+btEACauTWNp5Gu8YrkRQgdA4davHACFivPcXvrQ0Il6ENbXpajLH2TWVTaUlQU3YZhIJyT23v cRM868Poy+cb7oob11+8scn9nuO92G3E2YdladXyFnt0c0QUG6PlU4f2H6lm2VR8Ti+d+AJYCtz zrIVH8io5PiTjgy4qxyDJOUafdDbJODKMJvAY/wKcGARa8yGXH1KZmrpnHMDz1kGj3A1uhaIOnz ggR0W0+fFO/dGkrRgAm2FctkVHlGBXNxJCWEbgPevx8gxx7QUZYZFUOSU8wywc++Dtodq8J3rmW e8piOK9TgjyFcJgWnGms3TP3YacJ2LOYJhsH4KtjQLFgLPmYUaE2GtFZNvi5Pj4aDjC6CNM0d59 ihkl3WL88A3fDwtlJdJH28MLimjtz0NLTJrpuTUI6FypLQapA5U8P9fKV+JgwOGsaw+3XsRRI6u xaJiVpBfGAV7dhw6aibup9vYOG0yRVAE6/G9sMiGvVm0gp/uGup5muMix6FwmrWcMK3oQSkHQkF ZizYDYcJDr7rbDXgvUcHV6FzVOz1RNrwxn5HyJ0IBgsLYWGelAdYq0J6m8XrU3LYlu3RT5Jc7zp MjnoSIzrKUqklG6PCsA0vaitp64IbcxUY+AB/uoghzqnRdyOpzLW9rsNgey3cffgxwpYecYLt3p 9J5j0FwPnbh9EFA==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Reviewed-by: Kees Cook <kees@kernel.org>
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
2.50.1

