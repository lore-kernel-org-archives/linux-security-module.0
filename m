Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F9839D6F2;
	Wed,  4 Mar 2026 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772618252; cv=none; b=A6BWbHcuLYaEI8UY6wL/ZITKmS8K+0lLTStGfL798FUd2NyXBAL/eCzo9STWSgjSswVo+RfN/GR8pOijELnuGyRvhrmnpvGOgVB45MomhxMB0lMUEyafeq+dNY1TTNXqt3gT8cDKkKWxmAK4/JDhuxcPseKSuWV7uPXBr+Sc0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772618252; c=relaxed/simple;
	bh=i/5IL7EM74KTIdujOneytMkWhKIF8v1uAFN8QyAM3tI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vDvc1oSOch22VIhJNNcpWmdev5ugd/jz3pDHY3ebzS/YH1C83ePibRrodh6CE8Riv8Hj5HG/DIL48K1MIKUnAyruzIygr3jz3M9BSWqZb6bSvemgcoJ0XgkrW84HpFvPWMVdDkFMc8TJigt6NPa3bUjuYVZfNjZwgMXK+W6RHRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=T8rm40V8; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="T8rm40V8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1772618206;
	bh=quejclThrut5tBfPvQaqLgibHvXYiuhaAFoQ01cYzE8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=T8rm40V8FyniYZBgUsB1d1mru8BSlyZMRWExsrlKP54TAWBsnhNCfG8Hbe9ZrI5hK
	 Xuy7invKSLjJtg7Rra1JwkizyLIyAJEpbF41fSYlgVvi7Y/qnydyuUVwldUEWkYHcW
	 5+4tzJg4YFMGl3vDQWDOVkJGJQmtCZVWzXEAdIPk=
X-QQ-mid: esmtpgz11t1772618184td66c0092
X-QQ-Originating-IP: iLWrPiKNfH1xdKjr4ecOsNXlnwRjB+Zg856rnzwbzlA=
Received: from localhost.localdomain ( [123.114.60.34])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 04 Mar 2026 17:56:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3511329184745356515
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
Subject: [PATCH v4 2/2] landlock: Clean up interrupted thread logic in TSYNC
Date: Wed,  4 Mar 2026 17:54:18 +0800
Message-Id: <20260304095418.465594-3-dingyihan@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260304095418.465594-1-dingyihan@uniontech.com>
References: <20260304095418.465594-1-dingyihan@uniontech.com>
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
X-QQ-XMAILINFO: NNCgUTg3ctKTXvjQCOdekrhx6ttbjahJFs1qdZK6xuWTuK9GcOeY6NJK
	jiRIN/JQdBWL8Bo4Mk/HZMtpZiY8iV2hiZn7eMUGvlgY8dB+n6sb+FF+nfFsD2MTmjze60Q
	7wvXKzLG7PIptbqtBM6fj65kxKAhNNk4OvpO534BpdyPk/yUId956v+MS/VPBvUzq5EWMLZ
	VEbJYM+H4KitwWF3SnZRX9gLhee1d87otKu80sCZp5JKmPaTbrI79edT+9g1yZ7Alc0WkAv
	2grh9G0uoMWKUhyieo2b4DmY2kye3kglh+hQQ8SVRfmOtFNbtYgQFi3aNdGLDzjIFfArLQD
	EIYwTf4R/ajhneOTtIcAfdz5kR4+Q91qmsbm2GKyoCbryyBlcB2zOe0K0uCN+qLBMNjBweZ
	mbRSE7lZ+ViQXuAMuz0lHNAbnIAAgJZgvnUU3FUtKrNOD41y4ihGE4awvAhov+OOr9+a2hY
	NoyXtq+23By/PaWS/YscQR5EKj+dAil3JC0si7vNOWysprWCv9LLPGcBzNZ6/5yQt8k1e0z
	/JLWBIz8tD1wIoAWPjnBvutRnECBLmzDZhUOmuQi7PdAqYHu+FHPqBDzMd6AAfpcZ6BeO35
	SbIJH3iTSjSpwg4YDkPbrZh6p0Pb94gkZwNUJ1X2M/DZauZeVPYcLry8gnGA+fxB2um61bA
	ThwWJfOIyrxS83278soICeiVoG2qOZtskiyAUFl/LugJbQoRQrsNhMPiGh+UmiAVHrNvcfX
	X3fQvws3SD1ACHERZzoMy1/tLiJf/ETtnHgpVPwECdQ7GUMKuirDv1N3A9Nply40PYrULuO
	spGZSi+FAd2CnroRCszf66r+rzlbRs2CzqaAyd38q6XZ1IWCcSh1KP4efkFcPfN7czm/iyl
	I4/VbRAA+lqNbVQ9SWGMeYyv05AAZvIhgm563xKSmqMbw7VE+Fseprl0sMQcK7+fCZko6b9
	3miUTYLWEBE1yWWHzw/RlU4uBD7zDUWYPHNOBClo4zR9uLnVz9MdMQYXG+IQa3VEhvTlQ6H
	jMh1P9J1BydPdJcVk4dOmKNt76IyA=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

