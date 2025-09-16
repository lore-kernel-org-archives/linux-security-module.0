Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2E12E11D1
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758060836; cv=none; b=Ixvhkd67l1R+HtzxVYlamqoBuo1JbBSMYjmilKcXxDB4mN9qryyLxX4yc0nzi+bU4EvdvrnIei/XSwX6ClGOx8n1qPvGqxZqwb5tmZ7t3W6xb6tQ7doIqE8qM4P8shX1UnScYXiCsIkhss3GVNF+e7LPiUHd1AGTc4AfWoBH/RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758060836; c=relaxed/simple;
	bh=C8fAAfNCJo8ezSFbgvkaqSR6eHZAy9Z/not183lBHEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HIV8Hra5XaCVhBidy2kJkH7cdIQ1qthwlVyxWJaQWbUWOU2nWlSrwhwsEf3OAhS9Irls+AdwJJ5S2hu8RY3SfPgxibms6LW/0pIEZieIhb7aMwGT0uZp/kEsWGdoPUZvPGOWyeR9nh/ddFFvvnr18eY2j+19g42p/9N0QTqqxSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f91AZXiB; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f91AZXiB"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-78e9f48da30so847356d6.1
        for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 15:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1758060833; x=1758665633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CVmuYrc2ZSV0CkAyCEOmCvRCDvBU40QoTcyhLcIIX9I=;
        b=f91AZXiBOaiHQxZVSIKXiwh/E7AemHNwNV5wT5C/dtz7b2b28xH/bpxAs0L8G6pGRE
         +acavElLOSnkA2zKwu+lk2m+fPYf1zfwOBfH4vKvWRorNUgQ4eDUJ+9wV++5OvrT0PGa
         WhaIyuxzaKYxQnvvpVNOzKip+XVHSSDGDgqUuTd1KX7XgF3YdiPw/F9NwoQREwuQTefl
         cmq+P2mtMljuq2ignwBePds9eSnzpMSEkv5RBSQ/STIAPC3LDs67fLjVj9gP6Adp3x1c
         Stf+ostc1UwD0cHrlxIsVphCBB2awTXjM7Wq3VnfypXowUC6wExzoOUerLQ+ivSGCupS
         nRIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758060833; x=1758665633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CVmuYrc2ZSV0CkAyCEOmCvRCDvBU40QoTcyhLcIIX9I=;
        b=IpYVNrUYbgHYmCwL2X+v38ul/Kox8sWKnoPa01PitfiYTnd6f5wJVBN1UMHDnBTa3g
         WPNc3f2Seq7zBMQSMvT+ppmzUc226Qp5HSaJai9PePiDL3/cal2U4Ct94+xH1nMO7JXD
         YTCBcKU3CjGWvtZL11m9AIdfLijvQS9YQPswSA3huLp6W0iq9WvzSsDY8uyoSF989rBx
         bdPMYYLL0EzNoSQBFHr4ofIDMcBU0RYNywL3iH60JJUrKFqcRtgJni8rgBffap2GgRLJ
         1l9LpEuFzcLn1uJ0RicTyJCxK9CyCYJzW+3v+pg4VRWCGXRe+Ujo9otz4V1xxN8u5obu
         SHeg==
X-Gm-Message-State: AOJu0YylUS5GMSLzlKLjOkiTpzKr2IFSLSPLDpQetdOn5Q76sPUufy/V
	SK+CotWPAfb9/bKGUzsGjzekguyVN9RBug3wq9tr/jP6ej5GzhgCUn3SHMFiu0dJOOrOY6G97f0
	Wz98=
X-Gm-Gg: ASbGnctpNlFQHbTR1vXXK/I7JGbZeFnymblS/01YfBKaNgRJLCr4dQpqDXZNfUZztA7
	CIPb25ekfq3C3dLWIBIHlUe2K3SmbC62upMkSjmU/yUm8Va3Uw55iYju3nHxBP5KsHz/UMXzmku
	YFpfsCAz8nHlRDMA9fYIqR8YSn6lqxHPtq6B8WcpSe21tCYNO0P11ZmG1y5LYikrLu1vyZyuFh1
	eMU9I2ZZ65ahdoDBN5/rrrjJ+oS/PDN9IELPGEwVBsxXe7E5CoruiGKe8h3Mt2eMNmKwljer1X0
	qZ+Kc9jzNfPH+B5NyO8k1Z5LFv9vEHNy+IsItFvwy2RFC/aerfc1bKTNoipgOjApOFhVhtBqrXp
	Zhs+s+359NZa2mPoScHA2/3NKAE10ntNXh2/qYKd2UUGWqIrvn9jCfFaXxGoMWdGJUKiK
X-Google-Smtp-Source: AGHT+IETr/JO5w6/1jofE1KUReuH7tsgiuxoC/glakD+vrUpdkwkKCwpZKJiGIcXU0WF1ETCMB1U8Q==
X-Received: by 2002:a05:6214:2aa5:b0:78b:e6ac:7169 with SMTP id 6a1803df08f44-78be6ac71demr67798886d6.32.1758060833122;
        Tue, 16 Sep 2025 15:13:53 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-763bfedb916sm100708146d6.57.2025.09.16.15.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Sep 2025 15:13:52 -0700 (PDT)
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
Subject: [PATCH v4 10/34] lsm: rework lsm_active_cnt and lsm_idlist[]
Date: Tue, 16 Sep 2025 18:03:37 -0400
Message-ID: <20250916220355.252592-46-paul@paul-moore.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250916220355.252592-36-paul@paul-moore.com>
References: <20250916220355.252592-36-paul@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3035; i=paul@paul-moore.com; h=from:subject; bh=C8fAAfNCJo8ezSFbgvkaqSR6eHZAy9Z/not183lBHEM=; b=owEBbQKS/ZANAwAKAeog8tqXN4lzAcsmYgBoyd7p+lW6P5VO3uXb+0iJNBsDm1UIp+rZTvG6n Ra9TexMzj6JAjMEAAEKAB0WIQRLQqjPB/KZ1VSXfu/qIPLalzeJcwUCaMne6QAKCRDqIPLalzeJ c/9HEACHhdnidu1stC4UPy8SDB4OCHyW8837lv/3ot4rjalhKMSawcD4ZyaV9D3phjJDCLszwrx fy6+d8hUN65h+/2mLPEP+6Ij8YkAVybWlJEHdiY4PfdNXTu3LFKn3K3qo7n52G5JhRG/k7AINxS Vy1dzo5jygycmu+vXmfQsTmdiVt5zLPxGScI6JCr0QhXGyw8AbbEKQEnYptBbdL2k6lhuyLqe8M fieh7rrQXSkZgmU9PA5Ts/79aGfxFGqjgzmGNua5OwPp3XRLChwV5C8ZlH/VFjYCa5xpKXGdGEh AHdjgQgW+tZN1X8Mq38R+1D+aIb/vQXtHGQoJN5ksRdVc92X106HbkHlSxT6Z1qsqx82JQGJo6/ w/UKHXEPOq1MXd4ihwLW9l8vfkkHQmqPzOAPCwQ4rKPiNefftoDnLWWeFQijO1e3EZLB3IBsF4h 4Pe5KPBisQu3DMPu+sSFI4ZP9nFG8Lumoec3yAsdqpc1US5I+l6Up/m+u2HhTF3PGnSZVmILrgH Pl3RzpW0+u8hE6HTqkeoIA0qviSlwk4tuTd6gkMJlGoyX4yfkVAbBi/AzKwphtpDyv4Vd30NEpt 9ScqJOH3Kl9fXCWIf++n7aXHX8KPEOXHxbrayC46ELK7ydugCEfkjonD2fuI3a8fueBFsb21MIC o7Fz+GvWbissdUw==
X-Developer-Key: i=paul@paul-moore.com; a=openpgp; fpr=7100AADFAE6E6E940D2E0AD655E45A5AE8CA7C8A
Content-Transfer-Encoding: 8bit

Move the LSM active count and lsm_id list declarations out of a header
that is visible across the kernel and into a header that is limited to
the LSM framework.  This not only helps keep the include/linux headers
smaller and cleaner, it helps prevent misuse of these variables.

Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
Reviewed-by: John Johansen <john.johhansen@canonical.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
---
 include/linux/security.h | 2 --
 security/lsm.h           | 5 +++++
 security/lsm_init.c      | 6 ------
 security/lsm_syscalls.c  | 2 ++
 security/security.c      | 3 +++
 5 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/security.h b/include/linux/security.h
index 521bcb5b9717..8560c50edd2e 100644
--- a/include/linux/security.h
+++ b/include/linux/security.h
@@ -167,8 +167,6 @@ struct lsm_prop {
 };
 
 extern const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX+1];
-extern u32 lsm_active_cnt;
-extern const struct lsm_id *lsm_idlist[];
 
 /* These functions are in security/commoncap.c */
 extern int cap_capable(const struct cred *cred, struct user_namespace *ns,
diff --git a/security/lsm.h b/security/lsm.h
index 0e1731bad4a7..dbe755c45e57 100644
--- a/security/lsm.h
+++ b/security/lsm.h
@@ -7,6 +7,11 @@
 #define _LSM_H_
 
 #include <linux/lsm_hooks.h>
+#include <linux/lsm_count.h>
+
+/* List of configured LSMs */
+extern unsigned int lsm_active_cnt;
+extern const struct lsm_id *lsm_idlist[];
 
 /* LSM blob configuration */
 extern struct lsm_blob_sizes blob_sizes;
diff --git a/security/lsm_init.c b/security/lsm_init.c
index 2e76cefb1585..9e495a36a332 100644
--- a/security/lsm_init.c
+++ b/security/lsm_init.c
@@ -217,12 +217,6 @@ static void __init initialize_lsm(struct lsm_info *lsm)
 	}
 }
 
-/*
- * Current index to use while initializing the lsm id list.
- */
-u32 lsm_active_cnt __ro_after_init;
-const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
-
 /* Populate ordered LSMs list from comma-separated LSM name list. */
 static void __init ordered_lsm_parse(const char *order, const char *origin)
 {
diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
index 8440948a690c..5648b1f0ce9c 100644
--- a/security/lsm_syscalls.c
+++ b/security/lsm_syscalls.c
@@ -17,6 +17,8 @@
 #include <linux/lsm_hooks.h>
 #include <uapi/linux/lsm.h>
 
+#include "lsm.h"
+
 /**
  * lsm_name_to_attr - map an LSM attribute name to its ID
  * @name: name of the attribute
diff --git a/security/security.c b/security/security.c
index ff6da6735e2a..add46073af0c 100644
--- a/security/security.c
+++ b/security/security.c
@@ -73,6 +73,9 @@ const char *const lockdown_reasons[LOCKDOWN_CONFIDENTIALITY_MAX + 1] = {
 	[LOCKDOWN_CONFIDENTIALITY_MAX] = "confidentiality",
 };
 
+unsigned int lsm_active_cnt __ro_after_init;
+const struct lsm_id *lsm_idlist[MAX_LSM_COUNT];
+
 struct lsm_blob_sizes blob_sizes;
 
 struct kmem_cache *lsm_file_cache;
-- 
2.51.0

