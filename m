Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5359E47126E
	for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 09:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787306394; cv=none; b=ALYqO4h1xNsAgT5KwcQYz5Fz6308uc2wPcsNAbMKMf3Os7G66WWgYGOFpj3bv/f4cgsUv8yneGc7rlKESevzFRkRdvF9u6hnNTuBdZGw/YA/T+Z9Wnksb8t1/UItMG5RfTe9nLVX9FoW/EknDxnqvfnpm57HMV2BrnnIC/AFzrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787306394; c=relaxed/simple;
	bh=SiMn3BqPiCpQOzGd3YbNwjGLW1tzFnVrSniAKmS5pmA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p8JdtL6LGagiMr8jV+SWTjvnzuGY3L2ITXgJCaYOMoGfVbkGVRe+EnmWY4i5pTwjxt7ZC9f4oj732cuVUyfH0AW5dQ0zAsfFaLFzl1dvZM35kV+St8Yu6nAdtO6P2VCq6MblZ49pxfz8iXad0qG6HLEf56BrJ2MYoceBoWBngbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mMEs2PwF; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mMEs2PwF"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38e041ea211so727358a91.0
        for <linux-security-module@vger.kernel.org>; Fri, 21 Aug 2026 02:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787306381; x=1787911181; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MASfaprH7+tFgg5DHxo9bD5T6H4OeE/g5W/L8IgkjoY=;
        b=mMEs2PwFOJEfTPjCJ4cYFn4+7tUs3pmd3X9kObQcZQ6PqdTGq9o/+EWK3h6uuvtm4S
         8bll6DQXwoaTt52+HqC20OsUbIzQQ/56N9bW1tYCcGq2a87DuXK6yAm/FVwqGFihdaXd
         1CVWEQwddkkRKnDMMkIjEP9QUoOQqEwX1XYxL57s/1VkB4nAO2He5muUwxh+qiCMSpNd
         FVuJ36SXVKTum6ZDjvnyJ6UHSzk1ySUuVTpzsU5p+Yr2iDP0a8GFCJ67BiRqoZjcyQwq
         Bgv6ugemKVlWlhncJ9EaJCTc2i+Gkz5IUPPTAQxiijZQ0CDpdrv6SRwmY0sgLIPw72Ab
         hHrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787306381; x=1787911181;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MASfaprH7+tFgg5DHxo9bD5T6H4OeE/g5W/L8IgkjoY=;
        b=OhWcv/S+G9Y5CQvIAJ0ZEOU76ex7hZO5WnJn/Dp+QtHRGRtmxLacGX2nU6tbW1jogD
         4dBc9o4eUuIU4urgmGEGW5wyXorg97tQ85DbDUShJIbGcUhEwD/J7H3RGGUOfwM+Tw1z
         rBxh/4XH2hNK5t3xsPXzCA75beLFxVo9giOld496EmytRXe9KLO+LWt9qztGEN2sTNOD
         XEWB0Zq4b04zVBYdRJPruRNHwKFcLPfNPFAAgLEUpj4lSIZ5+o1UVCSq1zjKlG9aev+F
         Y+3YDEtCPRheR9s17yfd5BrnUA59nzK2uYR4vviON8fQsMQAuhKCp4sdGcfKnLgwYtfT
         wv2A==
X-Forwarded-Encrypted: i=1; AHgh+RrPy2iK7CcIpJHsn4f7MvWGEabJVfPT7TAHDayH1cz/6w+nVRHXjUwP2JxJ6RddwrHUiDQpdXecIiFUIqAZyrrWjR0LAPI=@vger.kernel.org
X-Gm-Message-State: AFuF++l9JOc1zJ5m+i4cz4Rp6WGMgFnOrIreqN8WAj0WTy3d5JD1sVpt
	4p+gMYAK0Z+jcxUeyV+BzDXKJTmRBICAi0LvsBe1jrz5m8M5874WTJY6
X-Gm-Gg: AR+sD11cewx5eEqK6LJdz/2qgxRjZwPeCok2x1W9VEhfR5d3uLq+akNS6rScGq/XHU2
	PDYQwUqyq4PZ9vLbmanoqJDJbtT+HWqwDtnoKGWWHYzK57O9sEauSP86tCpZ9A/j+5ofk0RQLaB
	zBi4MOgpEnaYgvC7Ee9MeDwkTofe4c19TgiYsPsqH2ayo8DwVA3a0U9mWBbYVbaiRKp2E1N0nE3
	ziu2BpvZx70sfoyR8HzltaBJz6X+YQaIGvdfW59G4jwZxoEbca7xsspFA/LZ7tEkXheRSnKV3lZ
	5C2gA+weGlm4LOdpEHoI3p2tiUUe5w7s+uoWWV9PEg5Fsjn4/jb0LX0sP03czAyeof75l7GSL/Y
	wJ0CS2hfk33jpeynzkGgFpwRnF4tx/vNgI+eP6c9BgfxQHoa7EUjjqIm4TuhT5mU9twnz1C8QLs
	jGzFO6darrVJD8ZCJSvKh/GQv7O5BMtau9EzOLIkY0ebj/moI2I5Sk0Q3zj4khb1yLJtaWq8jIA
	ZyhnlbeQXYGUiBNOCJxfOTh
X-Received: by 2002:a17:90b:5646:b0:38d:f5bb:e0f4 with SMTP id 98e67ed59e1d1-395c33367ebmr10081913a91.1.1787306381365;
        Fri, 21 Aug 2026 02:59:41 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c45530absm2509528a91.4.2026.08.21.02.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 02:59:40 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To: dhowells@redhat.com,
	jarkko@kernel.org
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	James.Bottomley@HansenPartnership.com,
	keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maoyi Xie <maoyixie.tju@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] keys: translate request_key_auth pid for the reading procfs instance
Date: Fri, 21 Aug 2026 17:59:35 +0800
Message-Id: <20260821095935.1864998-1-maoyixie.tju@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

request_key_auth_describe() prints rka->pid into /proc/keys as a raw
pid_t in the initial pid namespace. A reader can open /proc/keys through
a mount in another pid namespace. That reader sees a number with no
meaning there. The number can even name an unrelated task. The line
needs VIEW on the key. So the reader either shares the key owner's uid
or possesses the key.

The fix keeps a struct pid. Commit 4f82f45730c6 ("net ip6 flowlabel:
Make owner a union of struct pid * and kuid_t") gave
/proc/net/ip6_flowlabel the same storage. The print goes through
pid_nr_ns(). It renders against the pid namespace of the procfs instance
the line is read through. Commit ad08978ab41c ("ipv6/flowlabel: simplify
pid namespace lookup") moved that print to the same anchor. Output
through an initial namespace /proc does not change. The line shows 0 for
a requestor with no number in that namespace.

Translating at read time was the alternative. find_pid_ns() can resolve
a recycled number. The line would then name a live task with no
connection to the key. A stored struct pid gives 0 instead when the
requestor has no number there.

Link: https://lore.kernel.org/keyrings/20260809110202.2180410-1-maoyixie.tju@gmail.com/
Fixes: 78b7280cce23 ("KEYS: Improve /proc/keys")
Cc: stable@vger.kernel.org # v5.10+
Assisted-by: Claude:claude-opus-5 codeql
Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>
---

 include/keys/request_key_auth-type.h |  2 +-
 security/keys/request_key_auth.c     | 12 +++++++++---
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/include/keys/request_key_auth-type.h b/include/keys/request_key_auth-type.h
index 01e42ee5f4099..464636278c4f8 100644
--- a/include/keys/request_key_auth-type.h
+++ b/include/keys/request_key_auth-type.h
@@ -22,7 +22,7 @@ struct request_key_auth {
 	const struct cred	*cred;
 	void			*callout_info;
 	size_t			callout_len;
-	pid_t			pid;
+	struct pid		*pid;
 	char			op[8];
 } __randomize_layout;
 
diff --git a/security/keys/request_key_auth.c b/security/keys/request_key_auth.c
index 282e09d8fa46c..ed6f55b9cdd93 100644
--- a/security/keys/request_key_auth.c
+++ b/security/keys/request_key_auth.c
@@ -9,6 +9,8 @@
 
 #include <linux/sched.h>
 #include <linux/err.h>
+#include <linux/pid.h>
+#include <linux/proc_fs.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -73,7 +75,10 @@ static void request_key_auth_describe(const struct key *key,
 	seq_puts(m, "key:");
 	seq_puts(m, key->description);
 	if (key_is_positive(key))
-		seq_printf(m, " pid:%d ci:%zu", rka->pid, rka->callout_len);
+		seq_printf(m, " pid:%d ci:%zu",
+			   pid_nr_ns(rka->pid,
+				     proc_pid_ns(file_inode(m->file)->i_sb)),
+			   rka->callout_len);
 }
 
 /*
@@ -113,6 +118,7 @@ static void free_request_key_auth(struct request_key_auth *rka)
 	if (rka->cred)
 		put_cred(rka->cred);
 	kfree(rka->callout_info);
+	put_pid(rka->pid);
 	kfree(rka);
 }
 
@@ -226,14 +232,14 @@ struct key *request_key_auth_new(struct key *target, const char *op,
 
 		irka = cred->request_key_auth->payload.data[0];
 		rka->cred = get_cred(irka->cred);
-		rka->pid = irka->pid;
+		rka->pid = get_pid(irka->pid);
 
 		up_read(&cred->request_key_auth->sem);
 	}
 	else {
 		/* it isn't - use this process as the context */
 		rka->cred = get_cred(cred);
-		rka->pid = current->pid;
+		rka->pid = get_pid(task_pid(current));
 	}
 
 	rka->target_key = key_get(target);
-- 
2.34.1

