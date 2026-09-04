Received: from mta1.migadu.com (out-107.mta1.migadu.com [95.215.58.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD173E95A8
	for <linux-security-module@vger.kernel.org>; Fri,  4 Sep 2026 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.107
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788510674; cv=none; b=bzoDPuPVPI6sOsUamTEZ5zAuM5Yldo//18KPtYScX0wJeldI9SElPLe7e5LRPl7WL+CvYA1XrevgCiZciBL2rtjTdPNAha8MiTvboSVkpNJ2Lc+vrTZtUD9NKV16e4SEnc0lQWtmFJd/7Bl1YVbk0wBC2BazZP1yJe0gq94QAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788510674; c=relaxed/simple;
	bh=+SXmtKc9SrYxbBPOvsPXeXvF9U/YMgEAJNrujcS+q+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duZj+MNaWJBbcwcNYu1zf+Rir7hRsQLINONwwcAqzdyunxPUgUD4oJBIF1e31+fuYU60x6G4ClyFI2IpSn4lJdKp7jKD4/txW4WqHFmYFXFsKqdMWc+BzSen7xZzBCCTGUvhRMcdX8HPjQZ3L1Jqs1fd9ZYcKk9JX+rzrrhlVyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kGf5WZHo; arc=none smtp.client-ip=95.215.58.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kGf5WZHo"
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=+SXmtKc9SrYxbBPOvsPXeXvF9U/YMgEAJNrujcS+q+c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788510670; v=1; x=1789115470;
 b=kGf5WZHosNuan7P+prM6GrhJbzFxmetqPMJPR4vOaZROimZ9wgCSKckRGzr1y5KGpuYR3WXk
 gXRVsksx/Uu36M5mbsTx9YIefYjgGEEk9p02e0eB4IAeMM23sHY7hezvTXGhT+TUdydxo+i0iGn
 rRApQe0iDi9vZgvorZAuqusQ=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id f1edcafb530ef41a;
	Fri, 04 Sep 2026 08:31:10 +0000
X-Mizu-Trace-ID: f1edcafb530ef41a
X-Migadu-Flow: FLOW_OUT
From: Ye Liu <ye.liu@linux.dev>
To: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>
Cc: Ye Liu <liuye@kylinos.cn>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 8/8] security/landlock: convert thread iterator to for_each_thread_rcu
Date: Fri,  4 Sep 2026 16:30:00 +0800
Message-Id: <20260904083001.553587-9-ye.liu@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260904083001.553587-1-ye.liu@linux.dev>
References: <20260904083001.553587-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ye Liu <liuye@kylinos.cn>

Replace guard(rcu)() + for_each_thread() with for_each_thread_rcu(),
so that the RCU read-side critical section is scoped to the loop body.

No functional change.

Signed-off-by: Ye Liu <liuye@kylinos.cn>
---
 security/landlock/tsync.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 0b71e158c3f5..f1c08aae179b 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -335,9 +335,7 @@ static size_t count_additional_threads(const struct tsync_works *works)
 
 	caller = current;
 
-	guard(rcu)();
-
-	for_each_thread(caller, thread) {
+	for_each_thread_rcu(caller, thread) {
 		/* Skip current, since it is initiating the sync. */
 		if (thread == caller)
 			continue;
@@ -376,9 +374,7 @@ static bool schedule_task_work(struct tsync_works *works,
 
 	caller = current;
 
-	guard(rcu)();
-
-	for_each_thread(caller, thread) {
+	for_each_thread_rcu(caller, thread) {
 		/* Skip current, since it is initiating the sync. */
 		if (thread == caller)
 			continue;
-- 
2.25.1

