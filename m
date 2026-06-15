Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D3F3AB272;
	Mon, 15 Jun 2026 20:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781553846; cv=none; b=X3tAsidL2oPyzwtZfalUoPHCX8O0JhGuU0vEjwnpGZNei0Oz2QzaIgMjjx/NLEwNbzMud7p7GLe2hZaQbuCSoIHMy9uqEZvt8WaV3EhxSS+7Gt4Fg+p7pXHRborMEwA5zFXn8+ABlgqneFTceryvhW0ecgokM/s2AJEJruUiBaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781553846; c=relaxed/simple;
	bh=C7kU0WAZkrNvwX4UnIZhcd2h5WRQqQMJ4LbpYJ3cIeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5xdiUKkxtlHKw07yOjONbQMgjpx8ykW4S41oVKJH92tHMLo9dXpC8gdFEcddh4vysoUxP8q9EhSGWV8RCCsBreSpDW1J//jm0CqulVgPwtRtBsMQC5qhvhVpXsws4myCFg8aMN+Md2M3WJKuoB2XCxvSS0hMUll9O8nymiO4Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=sjz6uCfo; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="sjz6uCfo"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19C2C354B;
	Mon, 15 Jun 2026 13:04:00 -0700 (PDT)
Received: from fedora (LJ9QCPV96V.austin.arm.com [10.118.102.30])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 89DB73F905;
	Mon, 15 Jun 2026 13:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1781553844; bh=C7kU0WAZkrNvwX4UnIZhcd2h5WRQqQMJ4LbpYJ3cIeQ=;
	h=From:To:Cc:Subject:Date:From;
	b=sjz6uCfoei7prOphCxznfaxAP+86fvGFHBS54GGiOOk2lk8v8DZMaooGLMAJksxCw
	 7K5bruHfdrfTQChas3u/eXHHZmHev/PGM8n5n4ca1nCJBjls9tVXDKJLMFxCeoYBQe
	 T0YDffDtr8PaPK8Llo0TOjc8a2JaO0+LjU4wDYxU=
From: Bill Roberts <bill.roberts@arm.com>
To: Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: casey@schaufler-ca.com,
	Bill Roberts <bill.roberts@arm.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] security: clarify task_prctl hook documentation
Date: Mon, 15 Jun 2026 15:03:25 -0500
Message-ID: <20260615200325.260057-1-bill.roberts@arm.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The task_prctl hook comment incorrectly described the hook as checking
whether a prctl operation is allowed. In reality, the hook exists for
LSMs to handle LSM-specific prctl operations.

Update the function description and kernel-doc comment to reflect the
actual behavior. The old wording appears to have been copied from other
permission-check hooks despite differing semantics.

Signed-off-by: Bill Roberts <bill.roberts@arm.com>
---
 security/security.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/security/security.c b/security/security.c
index 4e999f023651..96e6ef088801 100644
--- a/security/security.c
+++ b/security/security.c
@@ -3301,15 +3301,14 @@ int security_task_kill(struct task_struct *p, struct kernel_siginfo *info,
 }
 
 /**
- * security_task_prctl() - Check if a prctl op is allowed
+ * security_task_prctl() - Handle an LSM specific prctl call
  * @option: operation
  * @arg2: argument
  * @arg3: argument
  * @arg4: argument
  * @arg5: argument
  *
- * Check permission before performing a process control operation on the
- * current process.
+ * Handle lsm specific prctl operations.
  *
  * Return: Return -ENOSYS if no-one wanted to handle this op, any other value
  *         to cause prctl() to return immediately with that value.
-- 
2.54.0

