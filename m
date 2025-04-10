Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8601F09B3
	for <linux-security-module@vger.kernel.org>; Thu, 10 Apr 2025 17:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744305915; cv=none; b=fFWaU98GcR7/6SAnsWLCB2KAk2OadtIOHZGvTp8Zygulh5Or3Yh1WpN4oxWUxiTNRKGdT3YG8TFpC+JeW/LQ6kyj0u3melJfUnJe01tGDQibUl4hs1swIkkt4bhSkRwAANpsQqXwB9b/LrreeHz8M31uEYHVnZs9mZSGRhySnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744305915; c=relaxed/simple;
	bh=wcQi8W9LX8nVrhQ53b+wMd3oZKIKnIgl+yqFjkr3x6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SmXlxRKXPS8LPgjZS1QEBB1LjBp+YWCkwk5TLosPjoA7l51YgplGbpZw9snwLe6zAU+PgJVoTebgIcu+BrEzpQ2FH3zu0/W8O6hPCvxSVJQScqP7nrOnhPQ8dQW+nqq3j9Zy56W4B21zddhkntya4upbhXPPzp3YNikct60J+7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=uOqlv+hf; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="uOqlv+hf"
Received: from smtp-4-0000.mail.infomaniak.ch (smtp-4-0000.mail.infomaniak.ch [10.7.10.107])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZYRMh5N41zTbp;
	Thu, 10 Apr 2025 19:17:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1744305456;
	bh=L7tUzc1W6d7egGwzo3TXqk29mI9VO/9b9vzhaLvrMDs=;
	h=From:To:Cc:Subject:Date:From;
	b=uOqlv+hfp8FBKWY5iFXLxCDA/8wEIVmFHJADEXXydHTxyFNgLAPh3+tPCXhxe8gY8
	 qVwJtNpW4utJmJ6JJbkGvWG2N8R6QkQ4q34lA4xz0BxUGklzkzBNyYP1rwQHf07jEy
	 HGcPt3NQ5sBgTmCAo2nxWD3yDyMsWfOTx5jnW7Mw=
Received: from unknown by smtp-4-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZYRMh2J1dzGQ6;
	Thu, 10 Apr 2025 19:17:36 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH v1 1/3] landlock: Log the TGID of the domain creator
Date: Thu, 10 Apr 2025 19:17:21 +0200
Message-ID: <20250410171725.1265860-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

As for other Audit's "pid" fields, Landlock should use the task's TGID
instead of its TID.  Fix this issue by keeping a reference to the TGID
of the domain creator.

Existing tests already check for the PID but only with the thread group
leader, so always the TGID.  A following patch adds dedicated tests for
non-leader thread.

Remove the current_real_cred() check which does not make sense because
we only reference a struct pid, whereas a previous version did reference
a struct cred instead.

Cc: Christian Brauner <brauner@kernel.org>
Cc: Günther Noack <gnoack@google.com>
Cc: Paul Moore <paul@paul-moore.com>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 security/landlock/domain.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/security/landlock/domain.c b/security/landlock/domain.c
index bae2e9909013..a647b68e8d06 100644
--- a/security/landlock/domain.c
+++ b/security/landlock/domain.c
@@ -16,6 +16,7 @@
 #include <linux/path.h>
 #include <linux/pid.h>
 #include <linux/sched.h>
+#include <linux/signal.h>
 #include <linux/uidgid.h>
 
 #include "access.h"
@@ -99,8 +100,7 @@ static struct landlock_details *get_current_details(void)
 		return ERR_PTR(-ENOMEM);
 
 	memcpy(details->exe_path, path_str, path_size);
-	WARN_ON_ONCE(current_cred() != current_real_cred());
-	details->pid = get_pid(task_pid(current));
+	details->pid = get_pid(task_tgid(current));
 	details->uid = from_kuid(&init_user_ns, current_uid());
 	get_task_comm(details->comm, current);
 	return details;
-- 
2.49.0

