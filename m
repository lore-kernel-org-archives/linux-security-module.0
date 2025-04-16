Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C1C23D291
	for <linux-security-module@vger.kernel.org>; Wed, 16 Apr 2025 22:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744843437; cv=none; b=Y0Fa+nrL6rbzxQClUjElds0d6Q6VBizlupQqLkdJsNZtZxb8LqTGgvG/PGnF0uuDIFJ/v+Ai7ioJTWK1QviEOjpeZZLZoaCN95P7QxW0J/1xYTJJrxMUE9gFW4dT8lriDvwQO2hFqT1OT8MDkliKA/5Q4JvwebZgdk9JerVxAO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744843437; c=relaxed/simple;
	bh=a4bk5BK0CMYagdUFqb8KCXh2LlCurP+DtdOTbkq8XH8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Aquu2SIClyH5+Db1XI/kw7870rU7ja1TLYZxORLpPN+3R/axPWSEIAKXnA6G/X6tlMw5sPnMqz1huTOUsBHCi259Egq1qdIcV9hAMbz6gJ6rJYWkW2WAn5181QoWNE0QjnI6uwNor6vauwAi5nM8/MJnRgtdLnWMpEIdTMVVzwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com; spf=pass smtp.mailfrom=zetier.com; dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b=eBcrjuq9; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zetier.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zetier.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zetier.com header.i=@zetier.com header.b="eBcrjuq9"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6e8f8657f29so1787916d6.3
        for <linux-security-module@vger.kernel.org>; Wed, 16 Apr 2025 15:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zetier.com; s=gm; t=1744843434; x=1745448234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnEM9XiDhU2AJ9VDyuYs2ejarQSTEt/r5Epz8Sz7V4o=;
        b=eBcrjuq9ySga/ge28SXvWgbG9xsIVIY4351WRldO7T2hMSlDP3KAp0fzp6an509v7/
         3Ho6K5F1yDMzVWdaDdseWjw2RwhnT+soBG0ZskROT7Gh5z2l5/0uiPAJB892AclAZpsT
         ih4ET0RERLqbwX8G9exOcWGTTkgV/AGQBjJIHt7h3FfJBnf2Tm7WSDq3cmRa4BFdt/4O
         Igy+Tgu96AfWvhfoyt95nz5Ej//HIYxX1O1D3murdLxtEuSncEKb+RQ1zuJaChUTSXPJ
         qoLI7z+VOSbHvsHj7etN+IUoEoFu7QkZGv7KvKz5d5XQQagMDPIpveQWdMflw1kDPLiE
         U/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744843434; x=1745448234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JnEM9XiDhU2AJ9VDyuYs2ejarQSTEt/r5Epz8Sz7V4o=;
        b=MRbiKS4sGPUDzBKcZy889IHnK4qNRT7ZE7NmUa7bLzTJw7AOnhPw9qpcEOi83Q704r
         mygZuchO8XoNPULM62JKdqt8QWUc1ClIhFi4TuoCSoWmIM2NpmGzsVZLlhTSOYbn8vFo
         UGSirabU3/WtvOKfvy5SRttAG66XfRfVxMuALgxYciBPAAZYuQvOeQeQIPP037fqBeon
         m7UN8AiwD4M85/753Cs2qXQs63slb6mWUklgXsm3yT8QpttfSLhs7TEM1YJWEXKQLD+H
         xmJg5HCaoO+5ilwa+5khH43nZZhG9cPRLH7Dlzq8AUEgQqDw1+haeVTPy0sH2hScah/8
         pCzA==
X-Forwarded-Encrypted: i=1; AJvYcCUciW4UHJQCImmI5aL01xpL8JASbmtWKsYot5J+HqfRCGf79JDyIRofUB4YLcqyxROWjSBxpp9/vYPw8a2azIpc2heUMhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyURHavvCueIck0y2LgjOVNrY4r9y6hommMaYToXb+rYFcetTr2
	DgYzdzdKOPltPblWRYDqBNgpZsQNQ2TVyRe2wXs8krdewgIHKaMv1VlvQSEV1ZE=
X-Gm-Gg: ASbGncs8cXeQa8C+7jahtih3mLwu3n1/Fc2N+oKYmj7QhvW9UzgKSZ2mNgceEwm4F1Q
	3imxSOv9H900JrhC2mhigtNq/PhL93XiQVxHfpmq5TOv82uoK9iHLbOgRlFVf1Y6zS3oz/PPJHt
	C91mnxb26jlOqzsYG1U/+InGffB3s8hvObXPbWICj0Vh4PFyfd+0g1boKzAN7eN6O9mC9vE+Xfd
	AYeS7v63MxiudVFO4w8uN2CN3j+pZYuOPOUS3Od6TGz8U7svj0nEZyihgGmxbuk2TgL9riyXjdN
	xPL6QkrWTrsDSnIRjtWwGDd3CuOLBcMkd+0N4XESh5bK
X-Google-Smtp-Source: AGHT+IEjJczMd16JgpoOiKHr+8HtiftAbq04aqYlza74AGhSL4ac0RjMhPcsyusccIpAzUIxrFmcUg==
X-Received: by 2002:a05:6214:4001:b0:6e6:6103:f708 with SMTP id 6a1803df08f44-6f2b307f67cmr61339006d6.38.1744843434315;
        Wed, 16 Apr 2025 15:43:54 -0700 (PDT)
Received: from localhost ([65.222.209.234])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6f0dea081fasm120096326d6.92.2025.04.16.15.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 16 Apr 2025 15:43:54 -0700 (PDT)
From: Gabriel Totev <gabriel.totev@zetier.com>
To: john.johansen@canonical.com
Cc: apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	Gabriel Totev <gabriel.totev@zetier.com>
Subject: [PATCH 2/2] apparmor: shift uid when mediating af_unix in userns
Date: Wed, 16 Apr 2025 18:42:09 -0400
Message-Id: <20250416224209.904863-2-gabriel.totev@zetier.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250416224209.904863-1-gabriel.totev@zetier.com>
References: <20250416224209.904863-1-gabriel.totev@zetier.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid unshifted ouids for socket file operations as observed when using
AppArmor profiles in unprivileged containers with LXD or Incus.

For example, root inside container and uid 1000000 outside, with
`owner /root/sock rw,` profile entry for nc:

/root$ nc -lkU sock & nc -U sock
==> dmesg
apparmor="DENIED" operation="connect" class="file"
namespace="root//lxd-podia_<var-snap-lxd-common-lxd>" profile="sockit"
name="/root/sock" pid=3924 comm="nc" requested_mask="wr" denied_mask="wr"
fsuid=1000000 ouid=0 [<== should be 1000000]

Fix by performing uid mapping as per common_perm_cond() in lsm.c

Signed-off-by: Gabriel Totev <gabriel.totev@zetier.com>
---
The example above was taken from an Ubuntu Noble 6.8.0 kernel, which has
a different af_unix.c file, which nevertheless contains an identical
section that I patched identically and verified the connect operation
saw the correctly shifted ouid.

I was not able to verify this fix on the mainline kernel as it does not
appear to mediate af_unix (due to dcd7a559411e "gate... behind v9 abi"?)
and I don't know how to make it do so.

I am also not sure how this change should be propagated to the Ubuntu
kernel and its differing af_unix.c

First time patch mailer so please excuse my ignorance or blunders.

 security/apparmor/af_unix.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/af_unix.c b/security/apparmor/af_unix.c
index ed4b34b88e38..a1c2b8516681 100644
--- a/security/apparmor/af_unix.c
+++ b/security/apparmor/af_unix.c
@@ -12,6 +12,7 @@
  * License.
  */
 
+#include <linux/fs.h>
 #include <net/tcp_states.h>
 
 #include "include/audit.h"
@@ -45,8 +46,11 @@ static int unix_fs_perm(const char *op, u32 mask, const struct cred *subj_cred,
 	 */
 	if (u->path.dentry) {
 		/* the sunpath may not be valid for this ns so use the path */
-		struct path_cond cond = { u->path.dentry->d_inode->i_uid,
-					  u->path.dentry->d_inode->i_mode
+		struct inode *inode = u->path.dentry->d_inode;
+		vfsuid_t vfsuid = i_uid_into_vfsuid(mnt_idmap(u->path.mnt), inode);
+		struct path_cond cond = {
+			.uid = vfsuid_into_kuid(vfsuid),
+			.mode = inode->i_mode,
 		};
 
 		return aa_path_perm(op, subj_cred, label, &u->path,
-- 
2.34.1

