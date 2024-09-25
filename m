Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1369156236
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 11:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727262133; cv=none; b=tDEnCUEiRNTJj2yuczqvisCdWNIdSOa6vy+6p3N5H4J5t7VuWVKxN5OkZ69ujzJk+7IMxnw7CZa86/ltAn6uSA2MDjA4E3dHcJV5qwSw6LEnQoPKcbiABaw83KtT9o2Hs1lGACEUjNBf5k31pUpYZSjvuQRJZ2+YgW45aNWOjUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727262133; c=relaxed/simple;
	bh=QkIh7JRTkOzoDzCNV3tDsOWs7PI5+vHq3LKKy1hmDds=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KcG8AT3OJ7J0ShOw55xEKIGMXQ7kVkNxalLxjYElasGg4VS3Mcn7HrAiki26pjrFHlec618uxlGtRV7hueGXV6rXmZjAvWpSRtqwf0rRzrOjnLCISbEWiHJHiRPsmer5wyjGXxIDYrTQpkWfFVt5L4LxYq5Ti80uq7f4ceWFJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav315.sakura.ne.jp (fsav315.sakura.ne.jp [153.120.85.146])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 48PB1qBf044394;
	Wed, 25 Sep 2024 20:01:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav315.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp);
 Wed, 25 Sep 2024 20:01:52 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav315.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 48PB1qJk044389
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 25 Sep 2024 20:01:52 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <ca37ee54-574b-44ba-b967-ef6f8f2780f9@I-love.SAKURA.ne.jp>
Date: Wed, 25 Sep 2024 20:01:52 +0900
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH] tomoyo: fallback to realpath if symlink's pathname does not
 exist
To: tomoyo-users-en@lists.osdn.me, Alfred Agrell <blubban@gmail.com>,
        David Drysdale <drysdale@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>
References: <d26b117d-1e13-42d1-9580-6dd6ce034c21@gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <d26b117d-1e13-42d1-9580-6dd6ce034c21@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Alfred Agrell found that TOMOYO cannot handle execveat(AT_EMPTY_PATH)
inside chroot environment where /dev and /proc are not mounted, for
commit 51f39a1f0cea ("syscalls: implement execveat() system call") missed
that TOMOYO tries to canonicalize argv[0] when the filename fed to the
executed program as argv[0] is supplied using potentially nonexistent
pathname.

Since "/dev/fd/<fd>" already lost symlink information used for obtaining
that <fd>, it is too late to reconstruct symlink's pathname. Although
<filename> part of "/dev/fd/<fd>/<filename>" might not be canonicalized,
TOMOYO cannot use tomoyo_realpath_nofollow() when /dev is not mounted.

Therefore, fallback to tomoyo_realpath_from_path() when
tomoyo_realpath_nofollow() failed. This change makes TOMOYO unable to
utilize argv[0] for controlling domain transitions for multi-call binaries
(e.g. busybox), but this change would be better than failing to handle
execveat(AT_EMPTY_PATH) inside chroot environment.

Reported-by: Alfred Agrell <blubban@gmail.com>
Closes: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1082001
Fixes: 51f39a1f0cea ("syscalls: implement execveat() system call")
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Alfred, what do you think? That commit mentioned

  This does however mean that execution of a script in a /proc-less
  environment won't work

. Are you expecting that execution of non-scripts in a /dev-less and
/proc-less environment work? I guess that majority of programs depend
on /dev and /proc being mounted even inside chroot environment. But
if you have programs intended to be executed in a /dev-less and
/proc-less chroot environment, this patch should fix this problem...

 security/tomoyo/domain.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/security/tomoyo/domain.c b/security/tomoyo/domain.c
index 90b53500a236..272e8474d15f 100644
--- a/security/tomoyo/domain.c
+++ b/security/tomoyo/domain.c
@@ -723,10 +723,14 @@ int tomoyo_find_next_domain(struct linux_binprm *bprm)
 	ee->r.obj = &ee->obj;
 	ee->obj.path1 = bprm->file->f_path;
 	/* Get symlink's pathname of program. */
-	retval = -ENOENT;
 	exename.name = tomoyo_realpath_nofollow(original_name);
-	if (!exename.name)
-		goto out;
+	if (!exename.name) {
+		/* Fallback to realpath if symlink's pathname does not exist. */
+		retval = -ENOMEM;
+		exename.name = tomoyo_realpath_from_path(&bprm->file->f_path);
+		if (!exename.name)
+			goto out;
+	}
 	tomoyo_fill_path_info(&exename);
 retry:
 	/* Check 'aggregator' directive. */
-- 
2.43.5


