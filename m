Received: from cvsmtppost11.nm.naver.com (cvsmtppost11.nm.naver.com [114.111.35.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3373346B4
	for <linux-security-module@vger.kernel.org>; Sat,  3 Oct 2026 10:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.111.35.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791024899; cv=none; b=Emrm3jug4D6eIvtPyzX/TjhYK6/rM6r879V5KqOZInA66j3+Y+5wFsYkniCyDngFXLj43x7+8STx44mzk6O1FAS1KzwnBMSHLM2x8uLDur11cOacUB0CJ2bGV1286PIOVtU6JtjrMQpner4cMvH/kqjfnrZ6fEXLxGYex1+yr4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791024899; c=relaxed/simple;
	bh=Hjy8ICAJXIAuwiDFKQ8ZUuWhgz5IefLTmTJu2piga5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bA7SjM0MEF9yo1ZwiTPqg4uYw8wYammGQkfMYSC1/ETPAPWBW28QkAntrD655qgD0WUCb0rxrzo90iJf2YyuIT/O3mU+VaXoMWCB7sRFFl7vHPnQTNWbBGM0kV9TAAbwoSUqWPi1a7IiO3dUumBQtlao1iyHN/aVXyJNELAwNHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com; spf=pass smtp.mailfrom=naver.com; dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b=X8PHpBT6; arc=none smtp.client-ip=114.111.35.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=naver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=naver.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=naver.com header.i=@naver.com header.b="X8PHpBT6"
Received: from cvsendbo026.nm ([10.112.20.48])
  by cvsmtppost11.nm.naver.com with ESMTP id PBqRAlCQTnmm-m4ZJnXvGQ
  for <linux-security-module@vger.kernel.org>;
  Sat, 03 Oct 2026 10:34:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=naver.com; s=s20171208;
	t=1791023671; bh=Hjy8ICAJXIAuwiDFKQ8ZUuWhgz5IefLTmTJu2piga5Y=;
	h=From:To:Subject:Date:Message-ID:From:Subject:Feedback-ID:
	 X-Works-Security;
	b=X8PHpBT64cKr6jfJhl0SoearvNHJFEgtJUvPB9Y35kUDZpq75YFHWqGQguoAGe8Y3
	 SlLf5bz3+OH6W6FPQdJT6EXoh5V+EuGE0ii3GaUD5uYNR412JIlmK4Gc/VFNZgOB3x
	 ed1OqaY7SO/gd4CVFEHZKWQfmp8wYlmnhFlYfwKQcC6gay9nuyH/bnZKIohd2rCopU
	 u0e0/pzukAF9kj1BteNPF3wAh7FITZhMkfVltJvmPF267qMeBPMqNFPtHQ1oB48YON
	 V937Q7+sz0vQglZMWMeDsUoxnbt69yu20ySGS54SedX0KiIn++T5egXF9NKk26X+HV
	 bLRoOFBIiN2Nw==
X-Session-ID: hxW-p6ZdTie88dg+22MhzQ
X-Works-Send-Opt: O9RwpzGdjHmdKHFOMr39Ko3YKHmwKBmwFAbrFxKrKqEmjJkaBd9YKBmm
X-Works-Smtp-Source: AwYlaxglFqJZ+HmwFqUw+6E=
Received: from localhost.localdomain ([115.136.205.4])
  by cvnsmtp007.nm.naver.com with ESMTP id hxW-p6ZdTie88dg+22MhzQ
  for <multiple recipients>
  (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
  Sat, 03 Oct 2026 10:34:31 -0000
From: tjdqudcks0424@naver.com
To: Micah Morton <mortonm@chromium.org>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Cc: James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Thomas Cedeno <thomascedeno@google.com>,
	Shuah Khan <shuah@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	security@kernel.org
Subject: [PATCH 1/2] security: safesetid: use real GID for GID policy lookup
Date: Sat,  3 Oct 2026 19:34:15 +0900
Message-ID: <d7e10b50556ab3b79c7132018249f6f7c608411b.1791023194.git.tjdqudcks0424@naver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1791023194.git.tjdqudcks0424@naver.com>
References: <cover.1791023194.git.tjdqudcks0424@naver.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sung Byeongchan <tjdqudcks0424@naver.com>

SafeSetID policies constrain the ID transitions available to a task for
each source ID.  id_permitted_for_cred() always builds that source key
from the old real UID, even when it is checking a GID transition.  If the
real UID and real GID differ, the policy attached to the real GID is
therefore missed and the lookup can return the unconstrained default.

On current mainline, a test task with real UID 1000, real GID 2000 and
only CAP_SETGID obtained non-allowlisted GID 2002 despite a 2000:2001 GID
policy.  The bypass reproduced for setgid(), setegid(), setregid(),
setresgid(), setfsgid() and setgroups() across three clean QEMU boots,
and enabled access to a synthetic group-protected resource.  This shows
a SafeSetID GID policy bypass and group privilege expansion; it does not
show direct UID 0 elevation or a universal local privilege escalation.

Build the source key from the old real UID for UID policy checks and the
old real GID for GID policy checks.  In three fixed-kernel boots, all
tested non-allowlisted transitions were blocked while the allowed target,
existing-ID, no-policy and UID-policy controls, and the existing SafeSetID
selftest continued to pass.

Fixes: 5294bac97e12 ("LSM: SafeSetID: Add GID security policy handling")
Cc: stable@vger.kernel.org
Assisted-by: OpenAI Codex
Signed-off-by: Sung Byeongchan <tjdqudcks0424@naver.com>
---
 security/safesetid/lsm.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/security/safesetid/lsm.c b/security/safesetid/lsm.c
index d5fb949050dd8..18124fc499dbc 100644
--- a/security/safesetid/lsm.c
+++ b/security/safesetid/lsm.c
@@ -148,13 +148,16 @@ static int safesetid_security_capable(const struct cred *cred,
 static bool id_permitted_for_cred(const struct cred *old, kid_t new_id, enum setid_type new_type)
 {
 	bool permitted;
+	kid_t source_id;
 
 	/* If our old creds already had this ID in it, it's fine. */
 	if (new_type == UID) {
+		source_id.uid = old->uid;
 		if (uid_eq(new_id.uid, old->uid) || uid_eq(new_id.uid, old->euid) ||
 			uid_eq(new_id.uid, old->suid))
 			return true;
 	} else if (new_type == GID){
+		source_id.gid = old->gid;
 		if (gid_eq(new_id.gid, old->gid) || gid_eq(new_id.gid, old->egid) ||
 			gid_eq(new_id.gid, old->sgid))
 			return true;
@@ -162,11 +165,10 @@ static bool id_permitted_for_cred(const struct cred *old, kid_t new_id, enum set
 		return false;
 
 	/*
-	 * Transitions to new UIDs require a check against the policy of the old
-	 * RUID.
+	 * Transitions require a check against the policy of the old real ID.
 	 */
 	permitted =
-	    setid_policy_lookup((kid_t){.uid = old->uid}, new_id, new_type) != SIDPOL_CONSTRAINED;
+	    setid_policy_lookup(source_id, new_id, new_type) != SIDPOL_CONSTRAINED;
 
 	if (!permitted) {
 		if (new_type == UID) {
-- 
2.43.0

