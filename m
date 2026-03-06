Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1702FD1B6;
	Fri,  6 Mar 2026 02:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772763491; cv=none; b=KulI2mSl6h3bVAH5qj+Ltse3+FSI8UUpd1xKaXuSSDM8zM4DsDYZDwQxn5LE7PPfh7FxKU9UMBBchGWFAcK5alzVQG1i+PpyQo6WcQCSp2HGYMMQrgnqFWb+NjbE1KmSkcUNobaDdPlP1vb/vK72Rq2pWDRrDupt2n7Rjo9NbBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772763491; c=relaxed/simple;
	bh=uT4GaYEoEWcXxRj1J00akdNKQbaeyyG4cNHir36SbSc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mHYPJh6OuMRPUwVhZ+kUZj6NEFYpXdT3OcU1epj0eGeKzHleRWd3Trcw7gbZHdYIVg+pFWNEdnLhdF/Q1n23VIydxMTtRAKekjqZ4TK7BFivpMTv55/FdjsLYoXCbDtziF+zQzMMDzBExzEXHHu2HO2qCVLNoLVrkiNM/RP80vY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=Wy32M/oJ; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="Wy32M/oJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772763444;
	bh=V845cZ30XMnNibLWcbQwL2AxTpfZTtQF9z2UlfASRx0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=Wy32M/oJIpS9Ha+5cRQVfotqvAZXIv1CrdJcZrw5l5tnmD1T76CS/HIuQARDz8luX
	 9NtEgKAcRMeZ1/ke8xpFZ+8Ce7PBUzYYpyhOtAbJh9/QNv2h6wOUV4GsB1cSD9HQfg
	 w/poqrayVJIkNBsUeIx4dU+nLzuLuw7hwq5Xz92I=
X-QQ-mid: esmtpgz16t1772763427teb8fca0f
X-QQ-Originating-IP: qoBKk+Q2gz0F4mZSjdn5GSH7N+f0I4v8zxVpizIkhNI=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Mar 2026 10:17:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16528853221485374802
EX-QQ-RecipientCnt: 10
From: Yihan Ding <dingyihan@uniontech.com>
To: gnoack3000@gmail.com
Cc: dingyihan@uniontech.com,
	jannh@google.com,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	m@maowtm.org,
	mic@digikod.net,
	paul@paul-moore.com,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com,
	utilityemal77@gmail.com
Subject: [PATCH v5 2/2] landlock: Clean up interrupted thread logic in TSYNC
Date: Fri,  6 Mar 2026 10:16:51 +0800
Message-Id: <20260306021651.744723-3-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260306021651.744723-1-dingyihan@uniontech.com>
References: <20260306021651.744723-1-dingyihan@uniontech.com>
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
X-QQ-XMAILINFO: Nc4Sv39/e83Wp3Zs7rg8R8dZzEZJrg7Z1R4iQDIyfi/qYSl0rPVl0KpC
	cr40Xyw0Gt24KZHLSEuOwjWcpekqjszMSNISKb2doUPrxCyz0gkMsJD3vvC8gRa0sxZDCrP
	JWFDMaVIv5ixFVqG6i8Uf7Ri7tp9XsPbBRlBbDCC8wNmdAKVcADD5DqGEuf7xkuP1oVi5Df
	OgE0nYG6KzSfd50Vw8R5VE3Np4VaFHcaICpsCZD0uQhKyF/EuioXdvqS7eI7MWCyWwu0v3a
	1h9O/3GMa8fsPKolO+J3VVe+yAkA+o4TzUEb4wmOvt/xA45pmqPVg+mKjf2SjotdjoM9DGP
	/OuiP5H4KE58qFItEnFfujMxgGYsUyv24oipzExfxCW/bOTPOSONWfAQgkbBe9WPJlxcU1/
	vM6+uojL2B7Bqfc0fxBIAyYpzTlIpdZPhkZfNAV0LcXRjkmkT6GAmM38bB3mit+P8Pqueqt
	qI0viyGtPOzbfY0bfGelKp/jMnB/5mWr2M7ExI+27M1bO+BCG6vAFBJMpaISzIaxa4rekRS
	XVHUmYzFRltKpiibugzqQR9PkEYsEzpKP7SzuMaeEq9D6fuOAYP1Obf6bD5rINuG7URn6rd
	t/0rBEsZfsHyW9EEsGbcHbrV1yDuQTS8qdfBusirN/AioGvO7Z4bj2+VQBPQIUP0fc3U6r1
	ea1JKpICcakkyrdJPRsoXO7RAVOqJleyXr85t51JT6dINVmHoszttVM3arpkQc9XHjbqZGR
	8pAfbQY3QfCjJiZcNLLp0xOfUKVbjA5+UGh0IfBOcxUAEUwgDiGUucI9R5q1ergNU6GVj87
	U3o/I5OFJpfc6OBcwIOOna0DaHVA2mPy2OsVFIUOqyRHBT2o5fnNfQzK2gklP9WREeCVRpr
	UDbmDguO0k7sEhvMK3s5D0QTcLpGptrXy1ziHlUFFSJgv6rQEtn5S30hQYoMr4BkocfLPwK
	9+MqzNSpqwW5t14D0t1Q8jhSXeUIy0wqHp4mn5+RBWKuELaatTEzaApH/fY2pxMaTnsgjfc
	FHAzH9g8ogj17e1wnZWDaWCy7osXY=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
Changes in v3, v4, v5:
- No changes.

Changes in v2:
- Replaced wait_for_completion(&shared_ctx.all_prepared) with a break
  statement based on the realization that the bottom wait for 'all_finished'
  already guards against UAF.
- Updated comments for clarity.
---
 security/landlock/tsync.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 1f460b9ec833..d52583ee1d93 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -536,24 +536,27 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 					   -ERESTARTNOINTR);
 
 				/*
-				 * Cancel task works for tasks that did not start running yet,
-				 * and decrement all_prepared and num_unfinished accordingly.
+				 * Opportunistic improvement: try to cancel task works for
+				 * tasks that did not start running yet. We do not have a
+				 * guarantee that it cancels any of the enqueued task works
+				 * because task_work_run() might already have dequeued them.
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
+	 * We now have either (a) all sibling threads blocking and in "prepared"
+	 * state in the task work, or (b) the preparation error is set. Ask all
+	 * threads to commit (or abort).
 	 */
 	complete_all(&shared_ctx.ready_to_commit);
 
-- 
2.20.1

