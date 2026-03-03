Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC3C19ADB0
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 02:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505646; cv=none; b=ZpkAwc/Zq/S6aQNy/w+7b6OUwC58QsgPtPm4svsbmcOoiES3nh7pii+ZkbgbS5HDjSDatqXP3RnSrBMZlyTLDIFkURgV9344+6l21i5UJFH983lSip307cWPAxPctVTtIbFuIXi75EqB0ptTWS90HfnAAWYxQDnL6lBxuAY2FlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505646; c=relaxed/simple;
	bh=EzIJgoDViogTuakwms2QSpzswyRSWW+aZVVFbk0Tmsg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YvavVYs2VfbnOGDqpsJiL/gpkBtkNCtwNvZAqmzYBezmy3wMgr6XaIwL0Awm94/0afNVGkMf/yF1/4iaGhWyWyta9gN0ngitnsKhbR4j+ffQibEVS5KlJSPZYyPaufABz5aELI0cM91zUJ9/jAAyHtnTBGOyXgsjMsN/Bn6wyXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N7iO21Do; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N7iO21Do"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-82735a41920so1966630b3a.2
        for <linux-security-module@vger.kernel.org>; Mon, 02 Mar 2026 18:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772505645; x=1773110445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EC0KQWG5f7x/l5iqyhqWVEVbUwwKM1oXTZqZtZkwId4=;
        b=N7iO21DoFQoi8s4EImb0HgmYbmj2DXj7X5Nv7oTFEaZJ9YJxcHoNzjxYyfYxOEeAxN
         SxD4qrlYHD/sSqQ3TkUdQBJm3MVAma3uv7nJoXOlgEn7C1tLpoLmE83O4f6u2mwDNgv3
         DzH6hNcRu6RhqqnQpHPwgTwyzdPB3lh/K0DujafHIXZdPIfuWSHsba1bk+r4aeX1mB/+
         H/27Gv5PcCIRaNgzlushbw1QkMwe5uya/ikijLwByuSuQxROV4NenORcjnLpPSKB9NnJ
         /36twPpSTjiGzx2VPHh6nXWeowvrj+shxocgI/ChaihaQcU4lH5smlqwP4CJZG2NbgFZ
         2t1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772505645; x=1773110445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC0KQWG5f7x/l5iqyhqWVEVbUwwKM1oXTZqZtZkwId4=;
        b=rMD03mvhZh17PGr+fxy8Fu4yPY8/DOVgAscWrCq9iseKlNGphCrOjFKJGgDaFbyZ3V
         ikvKmuL6VlRPY52vl3cpmHN4AC7Lc0Dwy3HpBflSXzIrkyLJFXafhO0A/iX3DfV3XVWO
         7m283vsD28D9fgeEGyiWwig8BQBNavXAzteVPYlwDhY1EbfeeeL+dF45ktrJRUPNLZmP
         KROOGJLv9IH1kPDDIv437sbGmpckPKz4ztF1aoQXnoGRkJ4RYmFwZVClrgDqlySmn6rl
         SgDjLN/GpA74TfVG8DuCmWOLP71OGv93wGokJyKpBS3SMTIledB7WQuCzX0ZVFXGrxqP
         /8cw==
X-Forwarded-Encrypted: i=1; AJvYcCXE9BLRxLKVcpsBTr5o6JtY2J06CbkEdoJRYDLiSUC6T070HQPBMqLHP1JI5zvzW1jIUVAffj+cyL4dRnuU0uj0b/EgCcE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaIK8T+lpzEQwjxl+icru++Ot22dCpkYgHVlZcId2BGNyOu+zM
	DgVhlDwXUSbQExBKI6raBtI8QMRxm5gABmWybzxkq5WfZHv4aKKu3LAG
X-Gm-Gg: ATEYQzxt0mGbwCc0zC+gTAyw7QemiBchYl6pnAI84iIN3MHSEoK3+UlXmIS9wCMS7Fk
	umcB4hwoyIS8Y/hK0kBU9qjedZiBErejn8s2mEL2uW9NZPRRajTAO9jm24PCiu9iTFqu7WdyTTO
	X4Y5kUTYSfSSXL3wWn9EAiaUol3R9dzYFpr2T44yqnXnZs6RWcXLS405mOHkCdXNZ2yFcfIANmi
	ndBQD5yiELLx+B38+DEDgnGJlZMJ+uvezuR0kPpHxTMYbs2EaenjGhRbCvBLGsyR2Xn3C9cPkMq
	j6C7J1f4V+9D0dT94kDyksmKs2Z+6DRHuqr4cw13p7iq/be7sxrkQRkl89vUz4ppVGrLCkQXzYl
	hEiZQkbRmek19Q04riMUfQ5eG0PhBHfJI1ZIaFPcTw2uPdQenflKsVFS7IAo8Z8AVrYDgSuTZK3
	ED3geNTXdbWyr9k8krgJ0cMIwNoba8sokXLXw=
X-Received: by 2002:a05:6a00:9518:b0:823:30a1:d5ba with SMTP id d2e1a72fcca58-8274da04bfbmr13644095b3a.51.1772505644643;
        Mon, 02 Mar 2026 18:40:44 -0800 (PST)
Received: from localhost.localdomain ([124.127.200.90])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82739d94de6sm14624901b3a.24.2026.03.02.18.40.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 18:40:44 -0800 (PST)
From: "yanwei.gao" <gaoyanwei.tx@gmail.com>
To: mortonm@chromium.org
Cc: paul@paul-moore.com,
	linux-security-module@vger.kernel.org,
	"yanwei.gao" <gaoyanwei.tx@gmail.com>
Subject: [PATCH v1] security/safesetid: fix comment and error handling
Date: Mon,  2 Mar 2026 21:40:24 -0500
Message-ID: <20260303024025.37916-1-gaoyanwei.tx@gmail.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Fix comment in lsm.c: use CAP_SETGID instead of CAP_SETUID in the
  GID capability check comment to match the actual logic.
- In handle_policy_update(), set err = -EINVAL and goto out_free_buf
  when policy type is neither UID nor GID, so the error is returned
  to the caller instead of only logging.
- In safesetid_init_securityfs(), return ret directly when
  policy_dir creation fails instead of goto error (no cleanup needed
  at that point).

Signed-off-by: yanwei.gao <gaoyanwei.tx@gmail.com>
---
 security/safesetid/lsm.c        | 2 +-
 security/safesetid/securityfs.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index d5fb949050dd..a7b68e65996c 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -128,7 +128,7 @@ static int safesetid_security_capable(const struct cred *cred,
 		if (setid_policy_lookup((kid_t){.gid = cred->gid}, INVALID_ID, GID) == SIDPOL_DEFAULT)
 			return 0;
 		/*
-		 * Reject use of CAP_SETUID for functionality other than calling
+		 * Reject use of CAP_SETGID for functionality other than calling
 		 * set*gid() (e.g. setting up userns gid mappings).
 		 */
 		pr_warn("Operation requires CAP_SETGID, which is not available to GID %u for operations besides approved set*gid transitions\n",
diff --git a/security/safesetid/securityfs.c b/security/safesetid/securityfs.c
index a71e548065a9..50682abd342b 100644
--- a/security/safesetid/securityfs.c
+++ b/security/safesetid/securityfs.c
@@ -224,6 +224,8 @@ static ssize_t handle_policy_update(struct file *file,
 	} else {
 		/* Error, policy type is neither UID or GID */
 		pr_warn("error: bad policy type");
+		err = -EINVAL;
+		goto out_free_buf;
 	}
 	err = len;
 
@@ -321,7 +323,7 @@ int __init safesetid_init_securityfs(void)
 	policy_dir = securityfs_create_dir("safesetid", NULL);
 	if (IS_ERR(policy_dir)) {
 		ret = PTR_ERR(policy_dir);
-		goto error;
+		return ret;
 	}
 
 	uid_policy_file = securityfs_create_file("uid_allowlist_policy", 0600,
-- 
2.43.5

