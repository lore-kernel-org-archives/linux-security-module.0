Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C0925B1F1;
	Tue, 29 Apr 2025 23:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745970727; cv=none; b=Hqow/09c6DxE08t8f9yq2GKwe2+c+7nOCpbC2kWdfNeUzq8EVsrx0JRNNwEC3w8Vnx3xIGD2jGRTSoY8qVRj+FDD00M78mVKouVsaSB+9iSsnLACfp0KpERPu5MWNYY6E05H6VPk6NNvsjjru9yfNVmBsFmD587rzlGCSAcM7BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745970727; c=relaxed/simple;
	bh=LZoWhT/ZdEHRRohLRIC+c4ZeZS/vTE91JzMlmj68zbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mh2kHTHI4RODiVK3xjlPQvKtVyUPAhj7GKvd65of6hVkxMZGuDLb55DPxCKOmievjeGBS6iTo2BA+/ygBR1sDZOBfBYkfqhCSy/O+byNrNQditzTmV7Y7wps/IeNIv3eLtOT2OBz/41LHSiGL5pMS4ALi+Z8gzQ0nOOFhJTjKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Byxg01+F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Byxg01+F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55878C4CEEB;
	Tue, 29 Apr 2025 23:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745970726;
	bh=LZoWhT/ZdEHRRohLRIC+c4ZeZS/vTE91JzMlmj68zbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Byxg01+Fl4NOHTHnxzVkk0GBmSy2q/Onj2lrN4wur7Hr2ROG42NT/sW67Xm/DUp8K
	 Sse2KPkjoLvbxHSn3nHeN2mQiVPcD+fgK1aVetrCPoEQy8YwsyY17ZQ9dQstxgKKr0
	 viKs0hf8jkmwAW0xCHetS9njRGofMV8nWCENY+wlBTSt/HEqPRYO2tbT7kcg6sk1Ps
	 +oBAfFs2eLkBbBB2rwJpck+Qi4W+FFE9PfxAxJLPqWVePPYlKFegzX3CO7qHaTdP00
	 NlJxnHjtGH3rNu0AvRh7Nat0vsBKM0XZ+wWqqB0hnUyX1XW599JDi4aX3MMIqtd2sG
	 L88IyPZpXjE1A==
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
Subject: [PATCH AUTOSEL 6.12 24/37] ima: process_measurement() needlessly takes inode_lock() on MAY_READ
Date: Tue, 29 Apr 2025 19:51:09 -0400
Message-Id: <20250429235122.537321-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250429235122.537321-1-sashal@kernel.org>
References: <20250429235122.537321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.25
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
index a9aab10bebcaa..2f3f267e72167 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -245,7 +245,9 @@ static int process_measurement(struct file *file, const struct cred *cred,
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

