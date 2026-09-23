Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4422AD35;
	Wed, 23 Sep 2026 03:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133234; cv=none; b=A2t/dviWhRkOojgbh12K6pyfvqev3M7ub78Ztk68yseGn8o4slVLEmZt6jBUw2eWsTMJlmyQ9kBhdgWqz5hBA34+rexR6HC36JZQlanO2yug2TToFbk9DN2DhmN8IlKgO79sR+YA7LzZMHuOQwsR06SjSvtZ96/tRfGSzEf8ixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133234; c=relaxed/simple;
	bh=wSwRZCLNZgxwPzeKe4iEUPEd7PgDtA5PKjXAMd1mW7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCqYu+nmQDL47ZhUacL7yT8EAlDZu82XRJV7o/aF4/j7xsN/GytUskh+TCjxwDH/uZ3fgt+eXbYXjgyodvHCSJVo3iEkg+3HvI6Z+LT7HTc2JfQU8vDW/QpcW95czVqN4oyPrewUELmxFpbX1YYk9ITRxiE5JRBWl0hgp0WI/f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDweNtyH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDweNtyH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB13B1F00893;
	Wed, 23 Sep 2026 03:13:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790133232;
	bh=s5x+veFgRX8LKTI/wZtWAwS1aUs7xtYA1sK5BXFOFek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mDweNtyHCZX3yJGzNMjW+Q1mqNTlRf+1ECWYljAt5HMlxSDFBrxWV2ePB/Sw5Nzvw
	 41HBh1vgy8lWQlCO+tXeVpRSwfB2BmoAeHRJqgvtW8Yj+glbknjy47PYbv0n22wFJ0
	 2Z/wrCv7/alUYJ0UMmrnjvzMyUtSQmZW8HlqW3qOnAznlztDSBKYrfOUQdYGiStDSf
	 FbV6zIlEhgmOHtAbKh7BKM+G+r38KLb9yIjEyvoWQu0DjttcnpzGvhSYt3YXpZRxR5
	 mU9L4wd9R1XUL/JEdvNTMEqIV/EwpJFmtzhoB1Q5xV4V8exW2l4vw8nqoNiu/NEFfe
	 zz5SOc4yVb8ZQ==
From: Fan Wu <wufan@kernel.org>
To: linux-security-module@vger.kernel.org
Cc: paul@paul-moore.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ipe: fix use-after-free when auditing a newly loaded policy
Date: Tue, 22 Sep 2026 20:13:48 -0700
Message-ID: <20260923031349.1216431-2-wufan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923031349.1216431-1-wufan@kernel.org>
References: <20260923031349.1216431-1-wufan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

new_policy() audits the policy after ipe_new_policyfs_node() publishes it
and drops the new directory's inode lock. A concurrent delete can free
the policy while ipe_audit_policy_load() is still using it.

Audit the successful load under that lock.

Fixes: f44554b5067b ("audit,ipe: add IPE auditing support")
Cc: stable@vger.kernel.org
Assisted-by: claude-opus-5.5
Signed-off-by: Fan Wu <wufan@kernel.org>
---
 security/ipe/fs.c        | 8 +++-----
 security/ipe/policy_fs.c | 3 +++
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/security/ipe/fs.c b/security/ipe/fs.c
index 076c111c85c8..847a76afb93d 100644
--- a/security/ipe/fs.c
+++ b/security/ipe/fs.c
@@ -159,18 +159,16 @@ static ssize_t new_policy(struct file *f, const char __user *data,
 	}
 
 	rc = ipe_new_policyfs_node(p);
-	if (rc)
-		goto out;
 
 out:
 	kfree(copy);
 	if (rc < 0) {
 		ipe_free_policy(p);
 		ipe_audit_policy_load(ERR_PTR(rc));
-	} else {
-		ipe_audit_policy_load(p);
+		return rc;
 	}
-	return (rc < 0) ? rc : len;
+
+	return len;
 }
 
 static const struct file_operations np_fops = {
diff --git a/security/ipe/policy_fs.c b/security/ipe/policy_fs.c
index 9d92d8a14b13..a7aeb57483c6 100644
--- a/security/ipe/policy_fs.c
+++ b/security/ipe/policy_fs.c
@@ -481,6 +481,9 @@ int ipe_new_policyfs_node(struct ipe_policy *p)
 	inode_lock(root);
 	p->policyfs = policyfs;
 	root->i_private = p;
+	/* Only audit signed policies from userspace */
+	if (p->pkcs7)
+		ipe_audit_policy_load(p);
 	inode_unlock(root);
 
 	return 0;
-- 
2.55.0

