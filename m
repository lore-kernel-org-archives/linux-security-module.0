Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2235B186E57;
	Mon,  2 Sep 2024 08:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725267529; cv=none; b=hcTZLkGRYcmUkJbw1x6TPwL5rry+i79R4QZeCyGjEPXBAtePAiI7VSpJXUjkOn4ROQhf6BTrL4kXbRqXn+U0TkFm+4DWU3GMzr0OjrHknM4Cq9zuKu0wxop58/lBtgr+m0NTjs7Bd+ClAgMzNdf3jC/want7oAnQMcD1sDs9Hnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725267529; c=relaxed/simple;
	bh=gdMjarlsxkIjz3GacO7XUTqQrGRcxTtT3SPegpVNcMg=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Sy7XfN8ecKj26qBXWQXhEcz5pxi2YHP4MyEmdhehBNlr6gSrCY5fYp1SViFoe5X8TzIdm0ZcltXvz/3fCysCE1oAfRtEycPClUGOwuR2N375pJxoA0g1/NLZ6s9+Qw6Ukz7neiiUyNNYxkz2LpYJMSiqVG1wLdaRNmICIwASMto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MDe3fjvi; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MDe3fjvi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1725267218;
	bh=xyAiDIvAC8LrbiIkOc9JTsgcYxtGvhFsoImt2CUMHWo=;
	h=From:To:Cc:Subject:Date;
	b=MDe3fjviYVCLiUcQ9mKVnurW6tr5JYmzhHgju/1E5GBqoc0blTHlyudPJP0pHTQqE
	 aq+lj1YRVVGkRLNs93JTSaBx+UGXZbicWcOeTkos+bR/MT8uANbGYqd8wxqB7vxpR4
	 d+knpO3Et4DcPFB6lHsnFMLDyau0f3zUHJXIitXQ=
Received: from localhost.localdomain ([114.246.200.160])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id BD832428; Mon, 02 Sep 2024 16:47:24 +0800
X-QQ-mid: xmsmtpt1725266844t1yiwz6e7
Message-ID: <tencent_39FA49154F494DFE0FEC2F20A9A34AA9B308@qq.com>
X-QQ-XMAILINFO: NhpLzBn2I3XwmRtRQDLpav3czAf1B15RF2AP0KtjFIMLaqOSxwqtGhfKMHR3QP
	 d7XXIDUS9BpKwgKtlXOw/BrO3UZO3L7uN+fbgBeFOdk/KLeaqRrwBLxi9BCOaX8ps7A5PZYEF1iY
	 wQ6Ocq1WWiKYVWfPEXBJI7656swXoxA07NdjpsVw1dI+gDwzpBMczQB1zFIFuSQAW5Mretg/6bUC
	 TlbI3h0iTN7DE5IS8nQkkZXxYDt4hqieOGdorIiwRZenyGG3s7Uy6ab7KbYV6jaZVoB6zUz/PAm7
	 /TTgTEGQh65po5WlQ5NpakCVxNljXTEQvRwvwhw4tZmNr5GLg2jnwnxOu8jKFDQVWDXulRAvUPZa
	 KBjE6ctScF2nJyCYEm8A6L7LwP4jgsqqPx6m/hNRabGoT7FoObPdX/OdgJLkYwTkAmFsq8BUVicl
	 ShRuNLWHazGtJaPUYNzJve1qG4VChmTEJuOQ6L45SdWA3eKEJluW8t0G7HXvULkEESYGSZ7FSPd8
	 4lBFL2UK4x/GnfQxTSvXooHJHdhz89hbaXXzS6ESps4FjKWv2tqUqGwZhM5jT6U1STWmaqN6nFPu
	 cTklZs679/ovcnys/rLPqWjRd9TEa2x3IIwqJWKlOIsZDudOCsUMjuLvWlaRZYOpm/vKppIgFHQP
	 BVl0dOsWmq4al+ZVuNEGtUofRMDZZajTxhaUS6fZzZz712mYT6MmbWkwXTGqW/GZhlKncQa8bZI9
	 RxHnoUhDWhj0Mq4TW5E4cp1YWXxsLGNMHeysv8jHjncTTK/9RUk1zhx6pVLdG26Q4zS0i7bSUErf
	 yrIM61UP1LvvRByfWm3mk63GQ6aEvd9P3VIfOA/1vM9nhE2ENf1UnFmmRHsftG0bu8kOxaIx8Bd5
	 hh0qxmGIBH94329tQcsK+8pjOo3fM4zrfGQHyB0ZtBK7b8hoAssG8l86eJhRZMmeZ5vIyA7m1XR5
	 ZksvImJZWjjoQiAw0uFPxQJhBHvfzD+VfRU23ET/JBki9vcopPS29x41hkQqGRYvry6uBIjPRUzY
	 ajxjdGTKWj0RriK6W5lpgdGSazwiG3cy+bAUuc1PnJ0zM7q2DHmDtWHAezAFHzR+v9me4AvA==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: Jiawei Ye <jiawei.ye@foxmail.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	pawan.kumar.gupta@linux.intel.com
Cc: linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] smackfs: Use rcu_assign_pointer() to ensure safe assignment in smk_set_cipso
Date: Mon,  2 Sep 2024 08:47:26 +0000
X-OQ-MSGID: <20240902084726.26179-1-jiawei.ye@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the `smk_set_cipso` function, the `skp->smk_netlabel.attr.mls.cat`
field is directly assigned to a new value without using the appropriate
RCU pointer assignment functions. According to RCU usage rules, this is
illegal and can lead to unpredictable behavior, including data
inconsistencies and impossible-to-diagnose memory corruption issues.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

To address this, the assignment is now done using rcu_assign_pointer(),
which ensures that the pointer assignment is done safely, with the
necessary memory barriers and synchronization. This change prevents
potential RCU dereference issues by ensuring that the `cat` field is
safely updated while still adhering to RCU's requirements.

Fixes: 0817534ff9ea ("smackfs: Fix use-after-free in netlbl_catmap_walk()")
Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
---
 security/smack/smackfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/security/smack/smackfs.c b/security/smack/smackfs.c
index e22aad7604e8..5dd1e164f9b1 100644
--- a/security/smack/smackfs.c
+++ b/security/smack/smackfs.c
@@ -932,7 +932,7 @@ static ssize_t smk_set_cipso(struct file *file, const char __user *buf,
 	}
 	if (rc >= 0) {
 		old_cat = skp->smk_netlabel.attr.mls.cat;
-		skp->smk_netlabel.attr.mls.cat = ncats.attr.mls.cat;
+		rcu_assign_pointer(skp->smk_netlabel.attr.mls.cat, ncats.attr.mls.cat);
 		skp->smk_netlabel.attr.mls.lvl = ncats.attr.mls.lvl;
 		synchronize_rcu();
 		netlbl_catmap_free(old_cat);
-- 
2.34.1

