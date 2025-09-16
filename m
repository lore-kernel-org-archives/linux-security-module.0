Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F4D307ACC
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060865; cv=none; b=NCFtxm6S14wt0Ub+WljFLAsxkKU1eMAUvjMIpnEIHw76kfNJFhRswfMwUbtjuYnIjcrCV+2FHmtPDNl+lIzkywsIJXUajyLMO3unv2FWr0M+zmB4tbryKQP5uW1GO0w3FsF70MkSa+hIptpzrFD3WmQzsO6B1JmpIVNpbdDdxIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060865; c=relaxed/simple;
	bh=Q7ZOEABy3jJJ2JP19xb/Kao4mYXENOAI2IfARTBHnfk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pj78j3hsudJBE/rtqhPQIM1CNHAPfGWWpIyrg8cpoe6IYqTY6BBWJogYCVhd2lxVzqLUP/figrZtKstbqm62XjAfnRHsfjOCljvXoYwBTZ8jxNx4DDoexFpQLVkiaWKto1SrYghLMTY40OqgajRAiYLuGhoY3/iydqDaktKzrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=HJco/9yW; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HJco/9yW"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-78393b4490cso25833926d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060862; x=1758665662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f49nponootI31KA2Yo+vdW3eScDBQdhhKkpsXkVPSDE=;
        b=HJco/9yWSBz3JaWgRh20GsS5mF39/oBDYtd55F2AgMr2ZjhTtDFt4jCqa372AV6R7m
         4AaB8FOGSjgv7EeqHh25yOXSNOA5+NtIMQpneGpxYfR7qwtVX/S9Kp936o9xU8aM5kjH
         bvBgO0Eec5ucMbNI4K44SIiIFJik87OquOGy+rV9kYBAVSt8ibA51E/1i5k4MymNyOqQ
         ii+u6gWLqKHNiRb1sT6XYHONC2KfF0GngnHlXB+28WFON+bacl5z9zKJOs3Cau/Qca4v
         cQ1xwNWzRcRdnlrm8Zf1gOFeJIGe7crkAgJ6QL1JuW+GY9qSo0lsijXCO8UlousI+EYz
         D0Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060862; x=1758665662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f49nponootI31KA2Yo+vdW3eScDBQdhhKkpsXkVPSDE=;
        b=QgDQJxGjvFREDYXzuippZvP+iwil0O15WHOx1Zylj+rjUdoxQixNBSKNcCfaLtSW1H
         jQLh801mp7OC2RmRAx8Q5HK0itKVQbkH9hRdk2xulvNolrZUAiJd1/HVv4g7ZIsAxdEW
         Qm0PsavFWp6psAC4o7BG49eB4hljt7tM9/FhYCtN/TIRs2AwLbo0Y8JDGICcRN//H5CF
         92gI56YLEcondRU7LiVxD0WMIeBKsiTt++rzU7ugdyrMBASVQ0/ZOdAV/p3b08RaBRd3
         jXeHz8Za9az9kwPbjKci1iWF6Pestya0oSp4wW5eGe9ClYjfaQAnqGUhNF0NqOPMs/Bc
         sZrw==
X-Gm-Message-State: AOJu0YxlPniIRHq9f4D4k+y8ADJ/xb1HsHoZuoJloeAgmWeeeKk2LN4a
	uWbwlHoqzNh62l5znzdjXpfHKZquSjf/9h1NTUk8/6QQgPNsk8IbLdVaglF6iL/KByTaMInZXq4
	wb6Y=
X-Gm-Gg: ASbGncs30ETK77dSe6tcGIsc4GmOGNleyb58wxr3OzjlF7rKmNO+pbB8d1dkUJ5Fus8
	8TNVNIeKbe9ZX+HDUiM+FccA50ZPjbzw0EyFdduzWZWdWOAcsFy/Kfq+2U9O1VDJ5U40BtSKWOA
	ECWJtsVqHe94z+9i6PwGAlyFi0APHUhfmKzKHL8j/QImlT2ZtZ8xgPg5x/Q4oFgrTexF89Lknk+
	Z/GL0y1pmzHII98+NOPMQppVsSvyIpUsw/0pgX5LRfa3dDMR6Q9y42lUBaBI90f6ahvTfGkMoZs
	u4qxFHQ8xKjaYUvCJkZctes+dcZCLO4cnncdyxuJy0n3bAKXx1t18v6rowS0yZCTHQND7uouiv+
	DEUF4KTuXKXKfhiYe8AsNuKH7fNVB/fx59/gNeXJNKoYTGaqoXw9OvBu85bY5PFoNmkMe
X-Google-Smtp-Source: AGHT+IFBjBQFDuBmD2zDm7TZmOYfn3grpHuemV/xzDj6uRYVQVkAzf+tS3nnFdOvHixskRvBDTPQLA==
X-Received: by 2002:ad4:5ba8:0:b0:786:8f81:43e with SMTP id 6a1803df08f44-7868f810840mr73130766d6.33.1758060862371;
        Tue, 16 Sep 2025 15:14:22 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-778d99113d1sm59678156d6.68.2025.09.16.15.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:14:21 -0700 (PDT)
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
Subject: [PATCH v4 24/34] loadpin: move initcalls to the LSM framework
Date: Tue, 16 Sep 2025 18:03:51 -0400
Message-ID: <20250916220355.252592-60-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1267; i=paul@paul-moore.com; h=from:subject; bh=Q7ZOEABy3jJJ2JP19xb/Kao4mYXENOAI2IfARTBHnfk=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd8XU60aTMDAMqFMWd8cnCUNeXZi+xCbcmY9Z mppqptDzHeJAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMnfFwAKCRDqIPLalzeJ cxeED/49StXxU3L1Jv4DL9L1r859r5yYY4dHLlGw7K39Ymx+kD0IA1s13Q0HA5YqSB59dWn895E kF8xRnX5836nOj0ad6xlihtTPMY5wiPo1SaNeQNFEole651/lCaqNyaI3qB8nrsDleUQ4T/+8iJ 8eat6vThH9sepGGTREMOu2yFvwVYNXWweA/fz4kx25Jfa4RXKH7D0IK1QTEikS7v6gLf3nY/ib3 5YMfMwmqduRJnnSeoJyPIWJO/dLZdUZxOki8ZlZl+sMBDEpudKJ6ve7ymnnBQfyt85HG/UXZIZp iULJRyvp+0jl2aOr1uTD7Dbszp/slvPFw/+9O3YjbAFF+Ux95X7YsOSv/DRKBfONZU0VbjuxTVj Je/Omf1OFkIPX0UW79q4BtWZvOdy6vUA9Jm2LHNEWj0jz5MGfnxgTCR0v+trq/kmx3ltAOO85+Z D+/Hy7htdRhfIU+acTW/lfBYgL/Mt1HR6EYXZzCssgE/lSm3d3hcu6nrrKZYa/s1H/cmeQUnSse ZhezVgB++J3w1KP0FlTu1GO3uJqk7ni9ad6h2C9tntdM3AGFxdPJQ2SbVapTIV1BlOo10KMyKYO SX3jEROqfgDpcSyK+I8zMulHsZMN4Ji/AG//cGYzu2g8S9Zx75EkiyEPMGZqUJZRo224kdwTJ1U 4PHrdiC+1aSqfXw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Acked-by: Kees Cook <kees@kernel.org>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 security/loadpin/loadpin.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/security/loadpin/loadpin.c b/security/loadpin/loadpin.c
index b9ddf05c5c16..273ffbd6defe 100644
--- a/security/loadpin/loadpin.c
+++ b/security/loadpin/loadpin.c
@@ -270,11 +270,6 @@ static int __init loadpin_init(void)
 	return 0;
 }
 
-DEFINE_LSM(loadpin) = {
-	.id = &loadpin_lsmid,
-	.init = loadpin_init,
-};
-
 #ifdef CONFIG_SECURITY_LOADPIN_VERITY
 
 enum loadpin_securityfs_interface_index {
@@ -434,10 +429,16 @@ static int __init init_loadpin_securityfs(void)
 	return 0;
 }
 
-fs_initcall(init_loadpin_securityfs);
-
 #endif /* CONFIG_SECURITY_LOADPIN_VERITY */
 
+DEFINE_LSM(loadpin) = {
+	.id = &loadpin_lsmid,
+	.init = loadpin_init,
+#ifdef CONFIG_SECURITY_LOADPIN_VERITY
+	.initcall_fs = init_loadpin_securityfs,
+#endif /* CONFIG_SECURITY_LOADPIN_VERITY */
+};
+
 /* Should not be mutable after boot, so not listed in sysfs (perm == 0). */
 module_param(enforce, int, 0);
 MODULE_PARM_DESC(enforce, "Enforce module/firmware pinning");
-- 
2.51.0

