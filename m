Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230922D3462;
	Tue, 29 Apr 2025 23:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970787; cv=none; b=RYrFOYZX+qx2MJnQF0opkNRVGAVhOd6L4ipdqBxfRZ6e3lmfnar5sapKSjsvAveiBYtXPwAIrR+fTMhZC3UQounPawJfFOpPXhZxbuwhBNGIss9Bhggz/5R9sMAzI/SBfkHA1gX6sQrW9dPElM5Jm1muBtiVGqLhQzDBumF2zJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970787; c=relaxed/simple;
	bh=2BXUmckJQQO5q7PlEnmciAtPCRsEaMB39VON6scAkbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pL5AMFjWuIoC/EHVyuwqDRdqPDt8nZgX0o5/JySGq+6L5tyuNH6/kQ99VvdYHalNCAKQ5eHA8ccGyfu/mIumSS/lkHI+YyAq1+u70IVz6EQ7Y93FDbHSRVYTrPgLnygTBT6FX+hIHdMcAChypaAM4E6YerRxFZaLtraWZnEUBWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CgmPHAa5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CgmPHAa5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE28C4CEEE;
	Tue, 29 Apr 2025 23:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970786;
	bh=2BXUmckJQQO5q7PlEnmciAtPCRsEaMB39VON6scAkbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CgmPHAa5d5+91yd0ERCk4R6Eltr52Wy37Tpc0Wg9A5aWxTqBoUhsaN0/73u9SAtWS
	 xcRZV2WdKz7LBOP9oa6Gk43CaV7WJ+tl2CeHHOHTIfsoXUTYLy8t5SBTCuTDD5LYxx
	 BQ2wLXyYvIAkbGFO5E64XmyH2roMhV3JzRQmUS07QIbdNg2RFU7zlDyJE+F0jbyeQN
	 iAr6v5MlhVA94+fVpd2lkEqHqnSdAiR17YN/VkxuG4lKdE4/t1U+cns8tOTAoWvhix
	 WnWtEKkiaPyEu4jE6Ss8aWQTGk9vyJKGzl+CHV0V9ufd8LFrkMrQWVA4JM8lN4ev+B
	 0m32hiT9nLVTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Frederick Lawler <fred@cloudflare.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	Mimi Zohar <zohar@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>,
	dmitry.kasatkin@gmail.com,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	linux-integrity@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 17/21] ima: process_measurement() needlessly takes inode_lock() on MAY_READ
Date: Tue, 29 Apr 2025 19:52:29 -0400
Message-Id: <20250429235233.537828-17-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235233.537828-1-sashal@kernel.org>
References: <20250429235233.537828-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.88
Content-Transfer-Encoding: 8bit

From: Frederick Lawler <fred@cloudflare.com>

[ Upstream commit 30d68cb0c37ebe2dc63aa1d46a28b9163e61caa2 ]

On IMA policy update, if a measure rule exists in the policy,
IMA_MEASURE is set for ima_policy_flags which makes the violation_check
variable always true. Coupled with a no-action on MAY_READ for a
FILE_CHECK call, we're always taking the inode_lock().

This becomes a performance problem for extremely heavy read-only workloads.
Therefore, prevent this only in the case there's no action to be taken.

Signed-off-by: Frederick Lawler <fred@cloudflare.com>
Acked-by: Roberto Sassu <roberto.sassu@huawei.com>
Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/integrity/ima/ima_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index 98308a2bdef6e..068edb0d79f73 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -235,7 +235,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
 				&allowed_algos);
 	violation_check = ((func == FILE_CHECK || func == MMAP_CHECK ||
 			    func == MMAP_CHECK_REQPROT) &&
-			   (ima_policy_flag & IMA_MEASURE));
+			   (ima_policy_flag & IMA_MEASURE) &&
+			   ((action & IMA_MEASURE) ||
+			    (file->f_mode & FMODE_WRITE)));
 	if (!action && !violation_check)
 		return 0;
 
-- 
2.39.5

