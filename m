Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42551DF965
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 10:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734431604; cv=none; b=VOq44pmBokR7lj1kVbg+DtQ0h3pLS5VqqFavykKmUlvqTngHzyp8vkUA7bM9+F5S+cdl/WQ4JLf4cfwZ+Hzkv8XxrDE1l7OcRtEvKLzZrQPxtKanpqe01akgrTAEJCcKi9OCggVxCUUvr/k3vwsc8Ei/hrpE4yIM6j5Hmp6V89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734431604; c=relaxed/simple;
	bh=X0Dk4mKTwXRmRyUWbbVE0URfkFleKVOCGuKbrd9QACw=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=LUNDZvoM3iWisDca6rC8MiSP0g0apVxjEzDoW+NrsgLswZ4oMQNxJVlmD3BMA2R/UFRXBZ2bWkjlFzIAsP0zBYjOJfTlJ+X7sy8UIFpJ3WXQz5bk+O37yVH8YXe+pGsU3Z7n8+vAqhcgcCsXJ9hVZ+RFZBdLjw+3ePsm6q+jaLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4BHAXDke062191
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 19:33:14 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4BHAXDRC062185
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO)
	for <linux-security-module@vger.kernel.org>; Tue, 17 Dec 2024 19:33:13 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <8ef40e0e-bd01-4cee-bf14-93fd080a2202@I-love.SAKURA.ne.jp>
Date: Tue, 17 Dec 2024 19:33:13 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-security-module <linux-security-module@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] tomoyo: use realpath if symlink's pathname refers to procfs
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp

Fedora 41 has reached Linux 6.12 kernel with TOMOYO enabled. I observed
that /usr/lib/systemd/systemd executes /usr/lib/systemd/systemd-executor
by passing dirfd == 9 or dirfd == 16 upon execveat().

Commit ada1986d0797 ("tomoyo: fallback to realpath if symlink's pathname
does not exist") used realpath only if symlink's pathname does not exist.
But an out of tree patch suggested that it will be reasonable to always
use realpath if symlink's pathname refers to proc filesystem.

Therefore, this patch changes the pathname used for checking "file execute"
and the domainname used after a successful execve() request.

Before:

  <kernel> /usr/lib/systemd/systemd
  file execute proc:/self/fd/16 exec.realpath="/usr/lib/systemd/systemd-executor" exec.argv[0]="/usr/lib/systemd/systemd-executor"
  file execute proc:/self/fd/9 exec.realpath="/usr/lib/systemd/systemd-executor" exec.argv[0]="/usr/lib/systemd/systemd-executor"

  <kernel> /usr/lib/systemd/systemd proc:/self/fd/16
  file execute /usr/sbin/auditd exec.realpath="/usr/sbin/auditd" exec.argv[0]="/usr/sbin/auditd"

  <kernel> /usr/lib/systemd/systemd proc:/self/fd/16 /usr/sbin/auditd

  <kernel> /usr/lib/systemd/systemd proc:/self/fd/9
  file execute /usr/bin/systemctl exec.realpath="/usr/bin/systemctl" exec.argv[0]="/usr/bin/systemctl"

  <kernel> /usr/lib/systemd/systemd proc:/self/fd/9 /usr/bin/systemctl

After:

  <kernel> /usr/lib/systemd/systemd
  file execute /usr/lib/systemd/systemd-executor exec.realpath="/usr/lib/systemd/systemd-executor" exec.argv[0]="/usr/lib/systemd/systemd-executor"

  <kernel> /usr/lib/systemd/systemd /usr/lib/systemd/systemd-executor
  file execute /usr/bin/systemctl exec.realpath="/usr/bin/systemctl" exec.argv[0]="/usr/bin/systemctl"
  file execute /usr/sbin/auditd exec.realpath="/usr/sbin/auditd" exec.argv[0]="/usr/sbin/auditd"

  <kernel> /usr/lib/systemd/systemd /usr/lib/systemd/systemd-executor /usr/bin/systemctl

  <kernel> /usr/lib/systemd/systemd /usr/lib/systemd/systemd-executor /usr/sbin/auditd

Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 security/tomoyo/domain.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index aed9e3ef2c9e..3a7b0874cf44 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -722,10 +722,17 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 	ee->bprm = bprm;
 	ee->r.obj = &ee->obj;
 	ee->obj.path1 = bprm->file->f_path;
-	/* Get symlink's pathname of program. */
+	/*
+	 * Get symlink's pathname of program, but fallback to realpath if
+	 * symlink's pathname does not exist or symlink's pathname refers
+	 * to proc filesystem (e.g. /dev/fd/<num> or /proc/self/fd/<num> ).
+	 */
 	exename.name = tomoyo_realpath_nofollow(original_name);
+	if (exename.name && !strncmp(exename.name, "proc:/", 6)) {
+		kfree(exename.name);
+		exename.name = NULL;
+	}
 	if (!exename.name) {
-		/* Fallback to realpath if symlink's pathname does not exist. */
 		exename.name = tomoyo_realpath_from_path(&bprm->file->f_path);
 		if (!exename.name)
 			goto out;
-- 
2.43.5

