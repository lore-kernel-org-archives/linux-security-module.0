Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [84.16.66.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E797A374E42
	for <linux-security-module@vger.kernel.org>; Sun, 26 Jul 2026 16:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.66.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785082840; cv=none; b=Q9c3m93ZBlTxGyWKlegraosB27Uy64G3tyPo6AknoEehGlNW2R22RMiYAB61WyeTGqd7bBBvVziBQN19sAAmIiohU3NsnU3QfjbXgjS9XWQoppzvVFePEigCosvIQedAV/nbnsy4acv/jkirh+b81214oYwy2WcLFueMDdZSC1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785082840; c=relaxed/simple;
	bh=1ZiVpCjImjDtDgYROgrjenE0VVGcfHJVmIaR0VW/tSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qMjyeC2xGN9z1lXa7LiP6wVYBYFKyAjX6s7eaL9V4oQIZGB/tvTsCw0YM3dX/4rJjqGazCLeG1SInfbMAPK1RguFrIy9dQASNLpdF4ULfx9EF1w2WJWvn7gwmXhqjGYC70FhrNC+8tCwMViBYSym1gVAAPnmRwCXdsWd+iBhxE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=hxkCHvGF; arc=none smtp.client-ip=84.16.66.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="hxkCHvGF"
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [IPv6:2001:1600:4:17::246b])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4h7Rcs5vwzzcBr;
	Sun, 26 Jul 2026 18:14:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1785082461;
	bh=nXRMUk2iXuESfBfVajal/C2Xk3tWoD0PIRR7JUkxZpc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hxkCHvGFp3wtd33xxr6hCxLeB95uG3Pibd8L0tS3IMSbwFjy2XqOLYUE21COGXayQ
	 50nnebiKMTyFebpuflblqUetPjX7MU2oPKiVR18bzY8TH2AnRTC0gvNBvuEHiX3CM+
	 f/lzxs6521DqctlvLVZl+qDA7FXRzpM6VfWL+/qA=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4h7Rcr4VGPzm4t;
	Sun, 26 Jul 2026 18:14:20 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Daniel Durning <danieldurning.work@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Justin Suess <utilityemal77@gmail.com>,
	Lennart Poettering <lennart@poettering.net>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>,
	Shervin Oloumi <enlightened@google.com>,
	Tingmao Wang <m@maowtm.org>,
	kernel-team@cloudflare.com,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: [PATCH v3 06/12] landlock: Copy the quiet mask in the ruleset merge helper
Date: Sun, 26 Jul 2026 18:13:51 +0200
Message-ID: <20260726161400.3010511-7-mic@digikod.net>
In-Reply-To: <20260726161400.3010511-1-mic@digikod.net>
References: <20260726161400.3010511-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Relocate the quiet_access hierarchy copy from landlock_merge_ruleset()
into merge_ruleset(), where the ruleset lock is already held and the
per-layer state is snapshotted.

No behavioral change: quiet_access is set once in create_ruleset() and
never modified afterwards.  This is done for consistency with the
following commit, which copies quiet_perm (mutated per rule by
landlock_add_rule()) at the same site so it is captured atomically with
the allowed mask.

Cc: Günther Noack <gnoack@google.com>
Cc: Tingmao Wang <m@maowtm.org>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v2:
- New patch.
---
 security/landlock/ruleset.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/security/landlock/ruleset.c b/security/landlock/ruleset.c
index af08a8cc705c..b6552415f3be 100644
--- a/security/landlock/ruleset.c
+++ b/security/landlock/ruleset.c
@@ -402,6 +402,10 @@ static int merge_ruleset(struct landlock_ruleset *const dst,
 		goto out_unlock;
 #endif /* IS_ENABLED(CONFIG_INET) */
 
+#ifdef CONFIG_AUDIT
+	dst->hierarchy->quiet_access = src->quiet_access;
+#endif /* CONFIG_AUDIT */
+
 out_unlock:
 	mutex_unlock(&src->lock);
 	mutex_unlock(&dst->lock);
@@ -587,10 +591,6 @@ landlock_merge_ruleset(struct landlock_ruleset *const parent,
 	if (err)
 		return ERR_PTR(err);
 
-#ifdef CONFIG_AUDIT
-	new_dom->hierarchy->quiet_access = ruleset->quiet_access;
-#endif /* CONFIG_AUDIT */
-
 	return no_free_ptr(new_dom);
 }
 
-- 
2.54.0

