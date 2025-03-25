Received: from mail-io1-f52.google.com (mail-io1-f52.google.com [209.85.166.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E252571DB
	for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 15:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742918391; cv=none; b=mfj2GA6PxCB9gSnFsWsv44sP42Sy4S4Xm4JMEuj+TV81vM6aG6SwVAX/F4wqyiFGbjEFBjVLlRXWOtnPWDX8lWOKQbZJAyAT7aigmQNwh7kO5NZRLpjsHh19QG1CcYkeIxCdYepxcljHPfVuQ6M3hE6opVZa78dsrIQhTp9ZtnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742918391; c=relaxed/simple;
	bh=P9EZvz4B3JvjSrOKiGhWM8/zqDEdiPCtLo7O1sswpoM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QB+fL2LY+Nehf778orsWrzNutmS0c5uFW9aWBIYU/90triVG2uukUD9dYnFmOAbnTXiJoVC1Xwjwnuu2ohBaWqevZB0LwZwca7mhpXCcYLuDsba5vgTe7wmSlB1ZG+VifsIeBclP7k8cYoburRtUwwHMTM4z1gYXwfESGwrl91I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=BVn6XOb5; arc=none smtp.client-ip=209.85.166.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="BVn6XOb5"
Received: by mail-io1-f52.google.com with SMTP id ca18e2360f4ac-85b42db7b69so66437939f.0
        for <linux-security-module@vger.kernel.org>; Tue, 25 Mar 2025 08:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1742918388; x=1743523188; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ToYD10NOrDEQyo76Lqg0Zr9yLQm8kUn7JcZ1hRviNk4=;
        b=BVn6XOb5sKx0mD1rcQ8BW8NwiwPKWKQbkmRq/H3H9puIXuH1y52rb3P0neRwphDyui
         FimyQGLI9nqWnHFtszqk60ypb2+FCmw6C3lNvk0QdG5t4XZXgL2KhFaBlW9p1dpHuzGq
         qLPnzV+vyCsByBkMK2M4h+dIfw8ChzmvSuc4/XznIAtjHqQ/iBONF8S+kd/DH7K2P8a5
         foSjhX2XeQdkiamLNdHbhd0tAEcNSSTZZ/0tFa446hmKDSLvdWwQF8o5OMIXHJTwxxY5
         SS8O64Rt5WJwpNHW3VLR/7a6BmwfUu1kKMSKU9U3spHuyuQYMQLj+S64bAbe5zXD5jfo
         q5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742918388; x=1743523188;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ToYD10NOrDEQyo76Lqg0Zr9yLQm8kUn7JcZ1hRviNk4=;
        b=rc81MYjOz2Skr9Dk43Z0XVhx7l2evVEh1oqwhfSxCFWygRHdV3WZ4pSevKrg1bKFA9
         QL0yeu5k03KJ9C8FP3uQd/wlvw9oit7sLtopch58Br5clRZHfOrS9DlUdEpuHBov4M1Y
         QqOTTmvH36l6su7t/Nud4codHdcI+7un66YfeFoI1CGhhXV03CTwBvoL2Ott2D8xcrg/
         M3+wl8gOSHO+0i9ByJBU81ZDjeN0IEyomq1SBdcpPmZzpBxxycjJcPT2W+VUMMbERNJ3
         Jyoi0AKArimkOx5dne+mP4FWAqZvCYGeezZV8CGIXfS03gxN6oTbUGgCCWw6d6VUujw3
         3Ynw==
X-Forwarded-Encrypted: i=1; AJvYcCXGQseAqSaGrcxdLwCDBq6513tRHlqznc8ysr55JlE8vmDZJtcpyvSqIR5JMTQphRKTANpGj00fr/7qL3th7VV7jM1efio=@vger.kernel.org
X-Gm-Message-State: AOJu0YymShB4khQMssHM72pvamc3QQxfFh17Rvfi1KRDVd1QV2HQKegA
	FX8jzV/cTjOpyfc0aqZe0vCPkDJERtfalq6cxQPIZhyUzFvxcokKa6oX2VGGmoo=
X-Gm-Gg: ASbGncuwGd2twusIjOSc3dRglmddb+TGcdzooj1jlXoF2E1vWjGVfaXu0ONpHegmbYj
	dvG1RyZfZ1uM9BEbWzfmZAbWm9NpVUOGwVvC5X2vI128oraiEkx7EUWbgZYpRQLv1Dlsuf7sEUc
	npikWTjTbI6ljkxiUjbwUC2Lgax2h5kgY0pASYnHJ6ENL8eLfHqEAPgKNEEuv/+q9XtSeDVObJE
	6jBaAedB302top3+gZUfwZV0vCvS5N3rl5SrYtd1cS9IhJ+96P4YPgGhLkkqbUCsklbYd/W/tTk
	Tn+dnWdmPvM5SfJBVWbRYDVU3ymK
X-Google-Smtp-Source: AGHT+IERsLCKQu0CXD36QCbALj7leHW0DXhR5mfzF4W90S9fbas/OUhKJkADjxti4v/7OWSezllccQ==
X-Received: by 2002:a05:6602:4013:b0:85b:3827:ed06 with SMTP id ca18e2360f4ac-85e2ca33995mr1894741539f.4.1742918388082;
        Tue, 25 Mar 2025 08:59:48 -0700 (PDT)
Received: from CMGLRV3.. ([2a09:bac5:8152:1b37::2b6:1])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-85e2bc273a1sm219975639f.18.2025.03.25.08.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 08:59:47 -0700 (PDT)
From: Frederick Lawler <fred@cloudflare.com>
To: Mimi Zohar <zohar@linux.ibm.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Roberto Sassu <roberto.sassu@huawei.com>
Cc: Eric Snowberg <eric.snowberg@oracle.com>,
	James Morris <james.l.morris@oracle.com>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	linux-ima-devel@lists.sourceforge.net,
	linux-ima-user@lists.sourceforge.net,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-team@cloudflare.com,
	Frederick Lawler <fred@cloudflare.com>
Subject: [PATCH] ima: process_measurement() needlessly takes inode_lock() on MAY_READ
Date: Tue, 25 Mar 2025 10:58:59 -0500
Message-ID: <20250325155934.4120184-1-fred@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On IMA policy update, if a measure rule exists in the policy,
IMA_MEASURE is set for ima_policy_flags which makes the violation_check
variable always true. Coupled with a no-action on MAY_READ for a
FILE_CHECK call, we're always taking the inode_lock().

This becomes a performance problem for extremely heavy read-only workloads.
Therefore, prevent this only in the case there's no action to be taken.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
---
 security/integrity/ima/ima_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 2aebb7984437..78921e69ee14 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -181,7 +181,7 @@ static int process_measurement(struct file *file, char *buf, loff_t size,
 	action = ima_get_action(inode, mask, func, &pcr);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK) &&
 			   (ima_policy_flag & IMA_MEASURE));
-	if (!action && !violation_check)
+	if (!action && (mask == MAY_READ || !violation_check))
 		return 0;
 
 	must_appraise = action & IMA_APPRAISE;
-- 
2.43.0

