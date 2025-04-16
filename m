Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 110EF1A5BAA
	for <linux-security-module@vger.kernel.org>; Wed, 16 Apr 2025 22:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843403; cv=none; b=o2HCFe1nn2RTRKo8FY3Bcp7n0fGWETa19mv964yaQ8005UwlURS1Iyp1HRXOhBdZ25d+GOVx9tuIf/xzB6j1SATPInRNzCyE5ma+2kIYZe4CTz5ednA+WV4zEV0PAUKdp2MR0LwgvX59s6dL5Dk9tPNCVvN0zS1O5HWLacTZByw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843403; c=relaxed/simple;
	bh=vQSJTz8VNIQr21ESV2/QVV8EKRdPLsZ+NRvhYpZOsbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I1WzmiU0JdvsTbIYrOICnXw+rBng6vhu7EF0JHBgpkoEYws0DjTnd8O/KUn44MTHw2lJb0aThKKTmwjTrGhOsyRBzcLvWSCoEXdQBStuR9r3nmObTsacMS6efgU5Ss3yzNxB5QsucR9vfr1MjljPc7klGW/GV/sKyNq5dA5nKbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=iwNC2Txr; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="iwNC2Txr"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-7c546334bdeso7438585a.2
        for <linux-security-module@vger.kernel.org>; Wed, 16 Apr 2025 15:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1744843401; x=1745448201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GXvF8jWqTAPbBfMGadL9eK3fbSPQW8EywO5ebfJwrW8=;
        b=iwNC2TxrZqRmn6OjgkLmVgO2dSU1pRE5PTV74sjwR16kmI8gs058MNHNbIObepMcQk
         QWKcGMjyRLbs04ru36g7HJOcmsGJSv7c+wjizrOzqT4T4Fwyt4tVqDZpHhLUTIdC4hEl
         3VL3KSOlQocNnEYQ54wd7B+EdkxGSF26ZvkwFJtcx7gJWh/CzdqSF95kIKsFrksofozK
         grOYvCkjDy57RexddZBjDTiEsz85cOJyGXOx5Y8fSA1N5FTFg55rwQJrk57Rk31Wgt0G
         urNNOQUwFxwNBOerXTIXQrL4IF7Di3wVBklbLQ43LFZeiKZwvncBkkgPRaqctkmUbcDf
         PA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843401; x=1745448201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GXvF8jWqTAPbBfMGadL9eK3fbSPQW8EywO5ebfJwrW8=;
        b=oMaSB9oIQPa3BUBkA4xEGjwh7SwJF+j3tIlC3vEDaQi51C30Q2xN0Iyr04hmvZ45Od
         0gv1F7I/Oq5kFVwfCdvJ1ThA9FyR/N0SpFYH23T01N+xqFokwIUviUHYvc4QqQ4WT4JK
         PSdp88n9vxBNBPAYF+v2CSYChJ6aAjKTevd8brtNVtxZCY1doZmZQwMAFKSzwOJyRutJ
         oCDRrk/zaBvxTnz7rdpy+vqLqDZPUhvZIlzJsmDQ65BqVrWCwLzL+UoPujE0lkQZ5uBG
         rtIQqHVzHV5BCtJApCVMHtdgxGst+3LV5OoHRnhiOGkKTP46zu2QPrUxuHFPE1roQepV
         p6KA==
X-Forwarded-Encrypted: i=1; AJvYcCX1+D0DQ+v7g4RKhR6zn0zWPGCpBz7hrBgOalCNudLhQpylwxe7SIP34SQ3vdWmkweC6mPFRKzvM3HP5ngfIciNp2ZXRE4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy61rhAuuptCQGU/dDNqHiNi5zzwhF1HR0Vo9ad5SmJ69COuBfI
	U9D0ekWlpgtefRppWetf2Beb7QhkUbklzpPmWkRITnRhfW/40+G+FDpDmEPBmiZmsp6RB2umhWh
	qUAM=
X-Gm-Gg: ASbGnctN8X/Wom8sYD7vQPbV0BtG4pyA8ukQUXuramN1eB4lGZqC+1xg9l51JzuoTzP
	6c5o1msbTEZ5209gDudnr68SV2LpLwNZMvcALi9MhExYXBbBOiwes0NRkNvPPEIqsGJJ5m3jCnw
	yXVJ2nkW1SNduyVw+N7qDmmrUlLe7xX1VV8nBXOiiqXkRq5HIpSbwJb08mWmKMsYfiIQIeMWuOW
	Sny2RvZ4K6ucsedwcWb+WRXtdDPodtTpKdzDDiucCQKcCgFPCNOWoZQJje77jjZLXMdPuvux7hD
	t5X9g6fwiqQt0dw8zDrslVUS1BMGRaJYAxuKCAm53kWX
X-Google-Smtp-Source: AGHT+IFqNxWvCYrCjO50YwOE/Qxpql7PF4d30nYG3yq6QaaGjlXcY1rR42qyuzXMLZDkOOjL8aecmg==
X-Received: by 2002:a05:620a:24c8:b0:7c7:bb3f:fd40 with SMTP id af79cd13be357-7c918fceacbmr548508185a.5.1744843400859;
        Wed, 16 Apr 2025 15:43:20 -0700 (PDT)
Received: from localhost ([65.222.209.234])
        by smtp.gmail.com with UTF8SMTPSA id af79cd13be357-7c7a8951646sm1103716285a.34.2025.04.16.15.43.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 15:43:20 -0700 (PDT)
From: Gabriel Totev <gabriel.totev@zetier.com>
To: john.johansen@canonical.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	Gabriel Totev <gabriel.totev@zetier.com>
Subject: [PATCH 1/2] apparmor: shift ouid when mediating hard links in userns
Date: Wed, 16 Apr 2025 18:42:08 -0400
Message-Id: <20250416224209.904863-1-gabriel.totev@zetier.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When using AppArmor profiles inside an unprivileged container,
the link operation observes an unshifted ouid.
(tested with LXD and Incus)

For example, root inside container and uid 1000000 outside, with
`owner /root/link l,` profile entry for ln:

/root$ touch chain && ln chain link
==> dmesg
apparmor="DENIED" operation="link" class="file"
namespace="root//lxd-feet_<var-snap-lxd-common-lxd>" profile="linkit"
name="/root/link" pid=1655 comm="ln" requested_mask="l" denied_mask="l"
fsuid=1000000 ouid=0 [<== should be 1000000] target="/root/chain"

Fix by mapping inode uid of old_dentry in aa_path_link() rather than
using it directly, similarly to how it's mapped in __file_path_perm()
later in the file.

Signed-off-by: Gabriel Totev <gabriel.totev@zetier.com>
---
 security/apparmor/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 5c984792cbf0..ecd36199337c 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -430,9 +430,11 @@ int aa_path_link(const struct cred *subj_cred,
 {
 	struct path link = { .mnt = new_dir->mnt, .dentry = new_dentry };
 	struct path target = { .mnt = new_dir->mnt, .dentry = old_dentry };
+	struct inode *inode = d_backing_inode(old_dentry);
+	vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_idmap(target.mnt), inode);
 	struct path_cond cond = {
-		d_backing_inode(old_dentry)->i_uid,
-		d_backing_inode(old_dentry)->i_mode
+		.uid = vfsuid_into_kuid(vfsuid),
+		.mode = inode->i_mode,
 	};
 	char *buffer = NULL, *buffer2 = NULL;
 	struct aa_profile *profile;
-- 
2.34.1

