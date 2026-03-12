Received: from smtp-190d.mail.infomaniak.ch (smtp-190d.mail.infomaniak.ch [185.125.25.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392AD2D77F7
	for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2026 10:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.25.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773309920; cv=none; b=VzFZ6DmTj9gaBnUn8t09jaiLBj1Q5muEk/mHdoKp1ke4l7oLYVIdA8IYDqe0fbcevtKSr/VSHAzn4G/+PKfrIpwZNji6YP3stuMc/2ZCirHU5BMuhkAV1SAZQck/OE2XqMMfFLbEjaZ2wKLtK08CTXcZco6KU4R4HYm/RbVb61E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773309920; c=relaxed/simple;
	bh=i2d7dw+TCLA+boP78ErxydkDAcv2IhHH8PUa3oCh1LA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UE1SVKRtzFZtobpAnKzkG2h/CMf0FIlc4GoyP00uiK8Gu4cOEmrdpUXTaGvcQ3Wca3si2CJwp8IKTYb84UuPT2r5gvfdh+A4yEg/mlUTABKG84E7EZKnuhAa2V13FyyvxrKsVZNdfuwfrS8ydw/ZS1MC78lrNbK+U2WD+Sl0EZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=jqOA1yJ5; arc=none smtp.client-ip=185.125.25.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="jqOA1yJ5"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fWjsn5flVz1BG0;
	Thu, 12 Mar 2026 11:05:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1773309917;
	bh=fD6HF1lmUl6p9lC1inUdLVxbMt2reJMKjj9GnF2j1AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jqOA1yJ5H2xTOJuPiahLQplZx0UN/fOvmyUVZ8EKHeRsefDW4ACg5TOTtIclSTltz
	 BuT6slqEVLIGRie3I22Wm/Vw3t8Bi9g4/n5aAz0nXFzqrtjKW/XXlweoHoZdHPWqeG
	 qmoCoakJGi1LQW/Bt8QlK/CRe+bwfT1rgT3qE0hc=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fWjsn1KyRzVV;
	Thu, 12 Mar 2026 11:05:17 +0100 (CET)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?G=C3=BCnther=20Noack?= <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>,
	"Serge E . Hallyn" <serge@hallyn.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
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
Subject: [RFC PATCH v1 07/11] selftests/landlock: Drain stale audit records on init
Date: Thu, 12 Mar 2026 11:04:40 +0100
Message-ID: <20260312100444.2609563-8-mic@digikod.net>
In-Reply-To: <20260312100444.2609563-1-mic@digikod.net>
References: <20260312100444.2609563-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

Non-audit Landlock tests generate audit records as side effects when
audit_enabled is non-zero (e.g. from boot configuration).  These records
accumulate in the kernel audit backlog while no audit daemon socket is
open.  When the next test opens a new netlink socket and registers as
the audit daemon, the stale backlog is delivered, causing baseline
record count checks to fail spuriously.

Fix this by draining all pending records in audit_init() right after
setting the receive timeout.  The 1-usec SO_RCVTIMEO causes audit_recv()
to return -EAGAIN once the backlog is empty, naturally terminating the
drain loop.

Domain deallocation records are emitted asynchronously from a work
queue, so they may still arrive after the drain.  Remove records.domain
== 0 checks from tests where a stale deallocation record from a previous
test could cause spurious failures.

Also fix a socket file descriptor leak on error paths in audit_init():
if audit_set_status() or setsockopt() fails (e.g.  when another audit
daemon is already registered), close the socket before returning.

Fix off-by-one checks in matches_log_domain_allocated() and
matches_log_domain_deallocated() where snprintf() truncation was
detected with ">" instead of ">=" (snprintf() returns the length
excluding the NUL terminator, so equality means truncation).

Cc: Günther Noack <gnoack@google.com>
Fixes: 6a500b22971c ("selftests/landlock: Add tests for audit flags and domain IDs")
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---
 tools/testing/selftests/landlock/audit.h      | 29 +++++++++++++++----
 tools/testing/selftests/landlock/audit_test.c |  2 --
 2 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/landlock/audit.h b/tools/testing/selftests/landlock/audit.h
index 44eb433e9666..550acaafcc1e 100644
--- a/tools/testing/selftests/landlock/audit.h
+++ b/tools/testing/selftests/landlock/audit.h
@@ -309,7 +309,7 @@ static int __maybe_unused matches_log_domain_allocated(int audit_fd, pid_t pid,
 
 	log_match_len =
 		snprintf(log_match, sizeof(log_match), log_template, pid);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
@@ -326,7 +326,7 @@ static int __maybe_unused matches_log_domain_deallocated(
 
 	log_match_len = snprintf(log_match, sizeof(log_match), log_template,
 				 num_denials);
-	if (log_match_len > sizeof(log_match))
+	if (log_match_len >= sizeof(log_match))
 		return -E2BIG;
 
 	return audit_match_record(audit_fd, AUDIT_LANDLOCK_DOMAIN, log_match,
@@ -379,19 +379,36 @@ static int audit_init(void)
 
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
+
+	/*
+	 * Drains stale audit records that accumulated in the kernel backlog
+	 * while no audit daemon socket was open.  This happens when
+	 * non-audit Landlock tests create domains or trigger denials while
+	 * audit_enabled is non-zero (e.g. from boot configuration), or when
+	 * domain deallocation records arrive asynchronously after a
+	 * previous test's socket was closed.
+	 */
+	while (audit_recv(fd, NULL) == 0)
+		;
 
 	return fd;
+
+err_close:
+	close(fd);
+	return err;
 }
 
 static int audit_init_filter_exe(struct audit_filter *filter, const char *path)
diff --git a/tools/testing/selftests/landlock/audit_test.c b/tools/testing/selftests/landlock/audit_test.c
index 46d02d49835a..f92ba6774faa 100644
--- a/tools/testing/selftests/landlock/audit_test.c
+++ b/tools/testing/selftests/landlock/audit_test.c
@@ -412,7 +412,6 @@ TEST_F(audit_flags, signal)
 		} else {
 			EXPECT_EQ(1, records.access);
 		}
-		EXPECT_EQ(0, records.domain);
 
 		/* Updates filter rules to match the drop record. */
 		set_cap(_metadata, CAP_AUDIT_CONTROL);
@@ -601,7 +600,6 @@ TEST_F(audit_exec, signal_and_open)
 	/* Tests that there was no denial until now. */
 	EXPECT_EQ(0, audit_count_records(self->audit_fd, &records));
 	EXPECT_EQ(0, records.access);
-	EXPECT_EQ(0, records.domain);
 
 	/*
 	 * Wait for the child to do a first denied action by layer1 and
-- 
2.53.0

