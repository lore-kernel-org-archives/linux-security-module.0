Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759AE35B646
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 17:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559860; cv=none; b=ezp1PalekwOLkQPswtN1hILOiqO2OqYQIDzj/AdS9M9tTe+F1L2+AMSEidWwQTB5owi1MImRfkZEjvF8fvTvGeJavvsE2DeWkTa1Xw3Uv0tOVd0YyraDaY2f0JHqoKNA9MctfKl+dxx+jnH++hwimXrllkeWpblozMNBp8A435U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559860; c=relaxed/simple;
	bh=2bTN1ME3/2EldBpMKBpdmdtzeEHMVMfOhPFMipUaxb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s6llwvE3KvXKwaUJLF2hM1jw63NXxt2PJxXDwxr8qDp/kr25b/9MfGQAkxaUeK4O6KJNCedq/8l5CqgDdWrAmWL4tVlJtTWOpJKBHTkzed3k9bdSsl9i315Ar+x6M954hzx07BDF7P04p5G8Su2dLyUzQflKpGZxLIh2iJd2JMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPK1Iz6F; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPK1Iz6F"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-79881805788so56545347b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 09:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772559858; x=1773164658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oy5X8hlJD2fK1wCFDd+uVtTVs3mQ0C0IdGo1DpdHR6s=;
        b=MPK1Iz6FBkgSqYNt3XR25PuIO9AnnXsZz7HKZnGpaZlOyBBl1LhvJ8yXWrfNiDkj96
         /usbZwZwsDx+bf/YvyxnTY455HnqxLdxGUL59u0ck4DZcF6gH00St4CVWOEdzaMr5Adm
         NgZGbL/uABcIWMQY2fXs4snUcMOEb5M+KHMaUI/5ziKB5WVFBB+VBYzCuPo5uOi77yYQ
         nXd8Uigf1ijW7OtE5uVP67rIBDnQCmDwL/b6DIjBK/u91y5YqxSR8jneL9me0Wm531W8
         Ez0TyIlZX3L8QL54Vs4pfV4zdb3nxHm9BGKD6ybGwgc+vw/DAOkL6Oum1XFJN7/zG1UK
         4q3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559858; x=1773164658;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oy5X8hlJD2fK1wCFDd+uVtTVs3mQ0C0IdGo1DpdHR6s=;
        b=iarnc10tchjijIb4Tx4jd57kiSim5odLD+T+HrKqVvAzVJMRlYuDJMAj6FXzfx3ZoG
         CwudP4JUoxvypjAZIosHY8kyN4VOv7Ce0hOlT1HfEj0MvDoO9KtxkdQ8We8/U2KA3L1k
         ADD5dFX6TGg7GBgnOnHGO887ZDkzp+3Dp4r883QWrSSbLumME4u9piYSlyZixTErsGZm
         sOP7NlHkOlJBRHVoYPfEbl5jRLCXfRv/nGXp5Q/4QBBRJC6hDphxAGmPAZDBq0P3UbQX
         GwNLLJY7m04J0eLeWB8vQqWXCljEwz7BuxzfyLjDnzVMJTZjCag0Msy/DPEuXzcjiWFH
         MIcg==
X-Gm-Message-State: AOJu0YyHaxFHsyQQgpuo1FwdVs44smeIGt9jg33OnwAjpCqsNCsJaZ/6
	XqTEPKUQmNxNbf3PmdEyL0tZFrSn50EKHt6JyvxSAoUTXDg8dKEv7FDyxgyNfA==
X-Gm-Gg: ATEYQzzLcy2tM7bFW5ofnbBVZWOM6wjYfjJrhM31PS3yFZocrnDvZTkptBg3nJ/L7gf
	erZ/lQINEAXYSzsigyhybTMPVxkXgc+px7DAhmgVphEGrp7/H8oewbQAy4fR+g7qAhP16VVOeKZ
	uRkzPyXxGZNa+5qucBNDDVpj90vpfK5MKENuactbHji8LLIYt62leLgH3FK1Drn+1nYGga7+zGc
	LIyRpw0TWYgAel12/4TqvkU42HLm/P+mvJeWp2bwNFap2cIUQqQJ6XY9vBqtGlQUNWLGt7YRdNU
	aF9SsDlJjGX+IlYKeEgsHg4VCUVQNwo0ARVi79Fr+kK8FXn0D4gjdJ3R91SdN3eQLZ2CWt2TcaQ
	62PSm0UBOShtW47hR85tZD1NJKnfxjFD7gTsIV5u2PFeIjbGb4QnZLVxWwgDCqANrVNJKlVkgJz
	E+fi9Dgygz5Agsw1KRQQUV/llKYgnAcbc=
X-Received: by 2002:a05:690c:3610:b0:796:210b:f31b with SMTP id 00721157ae682-79885605c14mr150415907b3.59.1772559858234;
        Tue, 03 Mar 2026 09:44:18 -0800 (PST)
Received: from zenbox ([71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876a8db33sm66047507b3.4.2026.03.03.09.44.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:44:17 -0800 (PST)
From: Justin Suess <utilityemal77@gmail.com>
To: linux-security-module@vger.kernel.org,
	Yihan Ding <dingyihan@uniontech.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Subject: [PATCH] landlock: Yield if unable to acquire exec_update_lock
Date: Tue,  3 Mar 2026 12:43:54 -0500
Message-ID: <20260303174354.1839461-1-utilityemal77@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Instead of returning -ERESTARTNOINTR when there is no pending
signal, run the pending tasks in the current thread and yield
until the exec_update_lock can be acquired.

This allows other tasks to run and allows the lock contention
to resolve in the kernel's task scheduler.

Cc: Yihan Ding <dingyihan@uniontech.com>
Cc: Günther Noack <gnoack3000@gmail.com>
Fixes: 3d6327c306b3 ("landlock: Serialize TSYNC thread restriction")
Closes: https://lore.kernel.org/linux-security-module/aacKOr1wywSSOAVv@suesslenovo/
Signed-off-by: Justin Suess <utilityemal77@gmail.com>
---

Notes:
    This fixes the failure in tsync_test.competing_enablement:
    
      landlock: tsync trylock busy pid=1263 tgid=1261
      landlock: landlock: restrict_self tsync err pid=1263 tgid=1261 err=-513 flags=0x8 ruleset_fd=6
      # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
      # competing_enablement: Test failed
      #          FAIL  global.competing_enablement
      not ok 4 global.competing_enablement
    
    The test passes after applying this patch.

 security/landlock/tsync.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 956a64cb6945..83938849620f 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -487,10 +487,14 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 
 	/*
 	 * Serialize concurrent TSYNC operations to prevent deadlocks when multiple
-	 * threads call landlock_restrict_self() simultaneously.
+	 * threads call landlock_restrict_self() simultaneously. If we are unable to
+	 * acquire the lock, we yield nicely and retry.
 	 */
-	if (!down_write_trylock(&current->signal->exec_update_lock))
-		return -ERESTARTNOINTR;
+	while (!down_write_trylock(&current->signal->exec_update_lock)) {
+		if (task_work_pending(current))
+			task_work_run();
+		cond_resched();
+	}
 
 	/*
 	 * We schedule a pseudo-signal task_work for each of the calling task's

base-commit: 8ff74a72b8af3672beca7f6b6b72557a9db94382
-- 
2.51.0

