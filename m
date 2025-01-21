Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5508328F3;
	Tue, 21 Jan 2025 02:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737427536; cv=none; b=H6YqUiq/v7eL400Ec0TCppeqKUibJRzLIHbF2McDHnXfGUfRZh1J/ZtLmemWxihBFJsmtjH3kyVictQkwpS4GxJ0feXh7W8JQTT/xC4ZBUG4kF8A2D9r11GUouZTvIik9CrgexViZqpkr7YBr9RWHBg0/lIkNy48izwRf1y+kxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737427536; c=relaxed/simple;
	bh=mA70fPw4qld7eMKx4+RpqRlZeDBv1FSMqvaeKd0veyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ArmfkC+WSCBtnCglKBiR0dUktAQ0RFkBufR93bxSzFRF1wvVks/a21a7X/jXFiPnJIfgjsSRxbSMUqrsInbGXHrAx0gRlH0GOOViEsJ2zs098DuWpvEBJUsNvDTvMiKjWlDYAa8Qi8iwbEeHojOgoWrGcNL62TqfIO0VTi0gHMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=kuhOSGya; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="kuhOSGya"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1737427525; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=WD0D0GnfCbIOWboR1KygzrWFVBDpslTEM9Y3iw76L8U=;
	b=kuhOSGyaQrRJPjoj0za4RhiTQWD07NOmC5wZpgUReWT/aIWhcGWx1o1vb9aI0C8mzgpKmeFv78Rm3TSfTAEHsdimhdwW92fTqMpI3qICkgoFXXm/l/jkeGIOPtmvYnlIan48uLUCASsHwEMwwQdvp3eQll+c2gqUjvPN2TgW1Io=
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0WO3ld2s_1737427514 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 21 Jan 2025 10:45:25 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: john.johansen@canonical.com
Cc: paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	apparmor@lists.ubuntu.com,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 1/2] apparmor: Modify mismatched function name
Date: Tue, 21 Jan 2025 10:44:44 +0800
Message-Id: <20250121024444.88981-2-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20250121024444.88981-1-jiapeng.chong@linux.alibaba.com>
References: <20250121024444.88981-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No functional modification involved.

security/apparmor/file.c:184: warning: expecting prototype for aa_lookup_fperms(). Prototype was for aa_lookup_condperms() instead.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=13605
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 security/apparmor/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/apparmor/file.c b/security/apparmor/file.c
index 85f89814af1e..f113eedbc208 100644
--- a/security/apparmor/file.c
+++ b/security/apparmor/file.c
@@ -169,7 +169,7 @@ static int path_name(const char *op, const struct cred *subj_cred,
 
 struct aa_perms default_perms = {};
 /**
- * aa_lookup_fperms - convert dfa compressed perms to internal perms
+ * aa_lookup_condperms - convert dfa compressed perms to internal perms
  * @subj_uid: uid to use for subject owner test
  * @rules: the aa_policydb to lookup perms for  (NOT NULL)
  * @state: state in dfa
-- 
2.32.0.3.g01195cf9f

