Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE217A2EA;
	Thu, 26 Feb 2026 02:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772071219; cv=none; b=uCsQCPtgUrmd9Iw6A2vUbYvCcM/TB2V2MRVcs7cJZc6jrO4FT7RWbsfGAOJloe/zRM5QEjYIySSMQHQf4dawlE6hhuy8ulZkiIpjB9OLRNjvq7F2SP2ygBdUvgZ1AlbiOt+9uto5i2C1ZjcmT6Ql9CYgQ4+VYYdXgowuFiImiPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772071219; c=relaxed/simple;
	bh=z2shwl/36XqPrciv+644gOwiwOQE5nwBi4vxfSyrFug=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Km+UiEKV6Vzs1ft0wZ/XvRVx7BI9Eg9rRX5XuaWMkKTPMWfkxlWrnsY63AmPzY1lQ8sXpEKdR7oibKPLupxYLqYe3m6tcVNzDULNg6gD0dXfEQaAIcasenqqeXDsaSwlfV7cbbWCf+R+uT2DDI2ELOgVaMenbVTXcm+Dvk42GhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=O22Bi4cI; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="O22Bi4cI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772071182;
	bh=hqeiiQSibDnPSeM8goNnMtJt3VgUQjfxUXKZENPXUqo=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=O22Bi4cI6GnvTyaKbya1hZHBJfV5O9yFHQlsETFw/UE7KAyfJqRuTfWn3W3AYonMi
	 RR7qL9U9HPPpSQgjRfh+xnpDJPIeS9q6Eom/AzQs1drONF7+0ygPCW9wGB032v61SO
	 5Oxh+r3UIxBisLDLGEHhgOMtyStH4hqgWuTl2N94=
X-QQ-mid: esmtpgz13t1772071166ta66bd646
X-QQ-Originating-IP: ELxuA8gLkrBQqTufhKHDK8Rw0c1w/RxOyFlz5yqlgjQ=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 26 Feb 2026 09:59:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 1850426630943409006
EX-QQ-RecipientCnt: 8
From: Yihan Ding <dingyihan@uniontech.com>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com,
	Yihan Ding <dingyihan@uniontech.com>
Subject: [PATCH v3 2/2] landlock: Clean up interrupted thread logic in TSYNC
Date: Thu, 26 Feb 2026 09:59:03 +0800
Message-Id: <20260226015903.3158620-3-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260226015903.3158620-1-dingyihan@uniontech.com>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: OafsCT7BOK1+JMiP6Gk//JNN3SGdiQz4grVSsnbJhz4eSGC3oVjg7DiW
	v7QYPQQoGs+MAl6liSD0pp0j9Sttq21sbqU8cTR5e79dZHljCmbJFxTRT2li1MjSLTZl4qS
	gCYivVqVB9UhjYwkuct8KFaldHF+o+XzZPwKzewh0xjJJ6Ozb+uq0ZrqLclDpYvVry8lbDg
	2iORZp79Wb4zPpkON8/OQmG+PArq+leeRIeW+H6vR3cD86fPjlA8AvGuehwP3AZNWZa4cK3
	7I1vX+lK5FY3sfafo1wBMYf9R8B/rNMrnnlwzu7TYjy9gtWwIODQtdtQTm6Wm6nuvVzduBy
	2BItmiQL+hm1g8fVzNhnFPvQxMBTlmTSrkRtKoz54AWrxKxRbp+A6xPX1HyCtDHHcvmwOsJ
	sHXnHsgsUR7R5Oy+Llhx+GW843qUoJVWskmu4hTZnhkhsYQyXV/lV2JIvp0UvT1btQbZc44
	TzTnWdTYVNVB9VPwbl1Qu89YdiCa+rYtuoSatSwN+75mMZMsAdXbrnv5Aa1fFFad0B2tdFY
	lN/blh5DxEoRk40ZRfmqIyQW2NBcKbDl2D6IsXQWT64ZfBVNpT66Y6fLm61GHz5KZbTReVn
	xuw9r8BTVtb3MLa5xGpHJBzhbANRn4UUapEjo0Ba7+HDz8cJrflgSglPTaH+jUBVn91ExoX
	h7eleqIhnMyrqwTnVXqKeexU3v5nKR/cmYCNijjvngModfhZKyJJR8IcuclW1tRrRVkhIe4
	2B5CU0swGI1UBoET/txmnaweifbM9Mz6tMpbTqZSeRT9ENTCkt6b+A/f0OVAaZyV8Z3hkOA
	85eLe0oi48UvRcWzkBwqjD/x9inL0ydL+EBLna8uXSwI1Pmffgb/hEzU8VI8fhPeGk1y6k5
	c9hYGfrZ261avWksjeF9nH8uNl3CBZnyry1X0SJFsouyTqq11shU4Xso4Ix0DftAYYQdxIp
	zBu7FdrRTcxi0Z+ihRMPrzi2wOUsasX6L4KZML1HkbhnqHlErK94sj/7w4Gf9cUjTQytXno
	En8k0xU4CEtanQKHf5aR6jlB2F/hO/G0LStXoGeA==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

In landlock_restrict_sibling_threads(), when the calling thread is
interrupted while waiting for sibling threads to prepare, it executes
a recovery path.

Previously, this path included a wait_for_completion() call on
all_prepared to prevent a Use-After-Free of the local shared_ctx.
However, this wait is redundant. Exiting the main do-while loop
already leads to a bottom cleanup section that unconditionally waits
for all_finished. Therefore, replacing the wait with a simple break
is safe, prevents UAF, and correctly unblocks the remaining task_works.

Clean up the error path by breaking the loop and updating the
surrounding comments to accurately reflect the state machine.

Suggested-by: Günther Noack <gnoack3000@gmail.com>
Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
---
Change in v3:
-No change in v3

Changes in v2:
- Replaced wait_for_completion(&shared_ctx.all_prepared) with a break
  statement based on the realization that the bottom wait for 'all_finished'
  already guards against UAF.
- Updated comments for clarity.
---
 security/landlock/tsync.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 420fcfc2fe9a..9731ec7f329a 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -534,24 +534,28 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 					   -ERESTARTNOINTR);
 
 				/*
-				 * Cancel task works for tasks that did not start running yet,
-				 * and decrement all_prepared and num_unfinished accordingly.
+				 * Opportunistic improvement: try to cancel task works
+				 * for tasks that did not start running yet. We do not
+				 * have a guarantee that it cancels any of the enqueued
+				 * task works (because task_work_run() might already have
+				 * dequeued them).
 				 */
 				cancel_tsync_works(&works, &shared_ctx);
 
 				/*
-				 * The remaining task works have started running, so waiting for
-				 * their completion will finish.
+				 * Break the loop with error. The cleanup code after the loop
+				 * unblocks the remaining task_works.
 				 */
-				wait_for_completion(&shared_ctx.all_prepared);
+				break;
 			}
 		}
 	} while (found_more_threads &&
 		 !atomic_read(&shared_ctx.preparation_error));
 
 	/*
-	 * We now have all sibling threads blocking and in "prepared" state in the
-	 * task work. Ask all threads to commit.
+	 * We now have either (a) all sibling threads blocking and in
+	 * "prepared" state in the task work, or (b) the preparation error is
+	 * set. Ask all threads to commit (or abort).
 	 */
 	complete_all(&shared_ctx.ready_to_commit);
 
-- 
2.51.0

