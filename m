Received: from smtp-8fa9.mail.infomaniak.ch (smtp-8fa9.mail.infomaniak.ch [83.166.143.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5F4727E05F
	for <linux-security-module@vger.kernel.org>; Wed,  1 Apr 2026 16:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775060506; cv=none; b=bh3gLsCanOR2s5IbO9bF7sWi3PC++hCg2zteM3tkdjgOW3NAHPnf2i8+PSPU6KbaItPHPfOOzEytt9/4JVPt7RanPajh4Cnmm6anR5T4zxwInPNC6nIDPXeY+HWxVF7sSW6Gv4lswHd/jN0IL1/YCkINjP1qVZ9TTQKt0ZN378U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775060506; c=relaxed/simple;
	bh=J9cAS4fB/FW8Roo8YyDjhgmvTTjTUHAhZ6b0VyKKZ4k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l7qGpayNuu9KA/Qb98EhLQVmWfLVG13tBajpwUJmGaUWe1o9x17vP+qvxF0kZGEaL1ZKbg370omcsatD9jmw0Q4khXD1V1b0RiOshKmWFikiCFwKWgd5oD6SAmNwckARCgQAM4Pasntb2llbJgirZZJQ85JvYRx9U21mKNJbItY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Kbj2V9sY; arc=none smtp.client-ip=83.166.143.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Kbj2V9sY"
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fm97h5Mspz3JP;
	Wed,  1 Apr 2026 18:15:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1775060128;
	bh=r1SkO6xjizLxWPyr7WAb5Qd8nq6tmDyWDMj5NZpadN8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kbj2V9sYvvmh8Vi/Hv9wWjg1ufWB1PqIGF0QoqKk21OL8nlNO5hwlAS1U7qPAiWy9
	 nVjxrKh39MI+MvEK2qUxDMekGFtsvIh5lQYvxCr++/vy85VrncWZunEZVmcPYQpDY+
	 E0nJWk3wHF/XQjyFfctIjaP37kvt9HXXXQ2SFMb4=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fm97h2dBjz9rf;
	Wed,  1 Apr 2026 18:15:28 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: =?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org,
	Justin Suess <utilityemal77@gmail.com>,
	Tingmao Wang <m@maowtm.org>
Subject: [PATCH v2 2/4] selftests/landlock: Fix socket file descriptor leaks in audit helpers
Date: Wed,  1 Apr 2026 18:14:49 +0200
Message-ID: <20260401161503.1136946-3-mic@digikod.net>
In-Reply-To: <20260401161503.1136946-1-mic@digikod.net>
References: <20260401161503.1136946-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

audit_init() opens a netlink socket and configures it, but leaks the
file descriptor if audit_set_status() or setsockopt() fails.  Fix this
by jumping to an error path that closes the socket before returning.

Apply the same fix to audit_init_with_exe_filter(), which leaks the file
descriptor from audit_init() if audit_init_filter_exe() or
audit_filter_exe() fails, and to audit_cleanup(), which leaks it if
audit_init_filter_exe() fails in FIXTURE_TEARDOWN_PARENT().

Cc: Günther Noack <gnoack@google.com>
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Link: https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

Changes since v1:
https://lore.kernel.org/r/20260312100444.2609563-8-mic@digikod.net
- New patch (split from the drain fix, extended to
  audit_init_with_exe_filter() and audit_cleanup()).
---
 tools/testing/selftests/landlock/audit.h | 26 +++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 1049a0582af5..6422943fc69e 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -379,19 +379,25 @@ static int audit_init(void)
 
 	err = audit_set_status(fd, AUDIT_STATUS_ENABLED, 1);
 	if (err)
-		return err;
+		goto err_close;
 
 	err = audit_set_status(fd, AUDIT_STATUS_PID, getpid());
 	if (err)
-		return err;
+		goto err_close;
 
 	/* Sets a timeout for negative tests. */
 	err = setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &audit_tv_default,
 			 sizeof(audit_tv_default));
-	if (err)
-		return -errno;
+	if (err) {
+		err = -errno;
+		goto err_close;
+	}
 
 	return fd;
+
+err_close:
+	close(fd);
+	return err;
 }
 
 static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
@@ -441,8 +447,10 @@ static int audit_cleanup(int audit_fd, struct audit_filter *filter)
 
 		filter = &new_filter;
 		err = audit_init_filter_exe(filter, NULL);
-		if (err)
+		if (err) {
+			close(audit_fd);
 			return err;
+		}
 	}
 
 	/* Filters might not be in place. */
@@ -468,11 +476,15 @@ static int audit_init_with_exe_filter(struct audit_filter *filter)
 
 	err = audit_init_filter_exe(filter, NULL);
 	if (err)
-		return err;
+		goto err_close;
 
 	err = audit_filter_exe(fd, filter, AUDIT_ADD_RULE);
 	if (err)
-		return err;
+		goto err_close;
 
 	return fd;
+
+err_close:
+	close(fd);
+	return err;
 }
-- 
2.53.0

