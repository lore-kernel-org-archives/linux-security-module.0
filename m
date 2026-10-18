Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5EB3F86F0
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344745; cv=none; b=C/uj5XO5V8WBhsjpK6ogVdkw4EgDHzC+GK6+yzQRqNHPddYr5hXfh/wnO6Q86T6nWR1YzdpYjKsQGgVdzuVCQy9UYbN8qojt4uxqeGMPJ8WJNe0HkxShLXUMEi0M2bmNvvHPBd/EANa4IVa0UlW2T7oL/7Z2/vg6LLRhiHPSPns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344745; c=relaxed/simple;
	bh=5vYjeIucC39gWaCyswzm4Vdfqahb0uz5XFUqIHHjksk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EdiJQ3keU6gqkUFic5ep5FfFlcyzmCSAMK/BlBl/e05sGN/zOjh47VFH+Jatp1EGDpym2pJ86zXWttvit6HM4TpyffI8XO+CFK/Z13kAO+SHUJjiBF5BHbQpdk9pWu5VAlQelv8I9x8eLB+UqxTza0zediuibcxbBiyb26K3kCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=NZOXfvAt; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="NZOXfvAt"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-917a64f28d0so31134746d6.0
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344743; x=1792949543; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A7LBBfxXIexhP1jPimaJy3KAv//kOJkCYbq7WAEYoW8=;
        b=NZOXfvAtmNSkLE1TpHNiaciZdsWKu3Ibk9gabPISRau08zxSpqSpbK+W5Ebw9DmNyY
         H5AixXGyhwALW3Z4rZMyDFyg9cvZTtq4FW/tJuAvy5CKlAc0W/4CXk5wtLQvzp5IkxX8
         tcH4qAc3AQ334znJ3t1T0WgRWIPJV3UjSz1hOLgWzoP9FDPqKHkxIm6gGFIkL7BRHUmr
         /B2RN61K0lGFd6/Lwfg0mZMAqjENG4sIxBHGPazNO7fmRcBQ+qEkNuTUQ5ZaqCR4dEGj
         9zU6Kf1csYB9GgEHgta5iHVi2L3Bg+/5wJCbScXHB0wlLYuaSlYoQzgeYcr48gwGFXPZ
         xgug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344743; x=1792949543;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=A7LBBfxXIexhP1jPimaJy3KAv//kOJkCYbq7WAEYoW8=;
        b=Ja7b58UzU3P4/oWewcmk/sxRiUfjJqpEzhRNfQ3Pmr21CD8tYZMZe6agLrz6zXYUYN
         XLqeUZykdPWuhRl+YotjQ9LGYb08WnrA8aUZXSditrqZM688dkNHy3S+hE2KOMj+MYaH
         yjeGwlAPB+Fp7Cq5ZBwnPhhuS49vKzbSmHTuRoTHetMw90Ujk47KdVzGNSucPtKKz7f3
         0/puZl+QJqFatYo4NyFTAnmzxF5yQ15qcWNe00P6dZxNN4hNnot/j6t7LeLvGwIscZpM
         0n29M2s8rWdODV65bmZN7/hzweQo5M3KiKxU/MK+wgGrShv6vAtfIpX3p0dM9gcSVscY
         k9Bg==
X-Forwarded-Encrypted: i=1; AKwUvBzB5I75XF7GF4jG1Dvn9vEaQFMpuAg/annw6pE4N0OsnxVDVKrFY2D8YjXJqxBqM9YOjvMRPFM0yd/M3ssJWOBZGNav+00=@vger.kernel.org
X-Gm-Message-State: AFq9FYKde0hTy+EJGSEUELGsXVCe5G7i6zeCqQoM8ecioo3RWIZ/49ZV
	mhDZb3St9fYMDVCeMBo7cRJlw3auEJPyHXOCPqLNaqnrPI8RTFuduB2wNEfeGNqOaQlvcbrw8ls
	vA5Bd
X-Gm-Gg: AYBFou3rvGzoSOAFO3Ro0mfGq/l0hV9TDJGcn2QdriyJxJsvyGfdE10ITacMgDGBThN
	yuylPpNXBLIpTRzDUVyX1xvf52Cek1ALBZkbXK0de3hYolB3Hmo9XivgpHSIAo0m/wAM8rpKa0R
	7LC9wPdhr39rFe50hfjiaT/baosSlubKZ8iblGUeM6uQBJNIHm8l6N2AjIfcmk2cgJku3ilpaYw
	ccHr0x8iBB6nWPkYVeGWZskRn/sTXGSL4ZIV8zSk3yNM4Zy5mYc9wgmZEBCK1iN0OWa3OygJZ+U
	/nuXkjrd0Tc2iZ11nC2Fqzn1FeJZNdcJkwvXUR7VUSsOlHZlxYmkj2QbYeQGHv600Mo0csmTFLm
	Z9gqXZOSYLQ5UPTnJBCTTDcMA/pa/tJm/E1AD1DSQyXPQBjJOa/+he8XNiMUPo8+18dgp95l7oB
	3v/uvYu/Gbyl9GF2ATyE2b8+1nvNE8YOkSzJgOl6ig1ZCNaxXdMpTD/dTJrwvX0nFRnBc5f6/Qk
	ZwyowbqIGCeAvc=
X-Received: by 2002:a05:6214:4488:b0:914:40f4:d4b9 with SMTP id 6a1803df08f44-91bdf02842cmr87004986d6.12.1792344743581;
        Sun, 18 Oct 2026 10:32:23 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.251])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bccc721a8sm75547916d6.12.2026.10.18.10.32.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:22 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:54 +0000
Subject: [PATCH 12/13] ptrace: use cred_ids_allow_control()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-12-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344715; l=2063;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=5vYjeIucC39gWaCyswzm4Vdfqahb0uz5XFUqIHHjksk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QIJyn3tfzNhLh4XN7paqAW95Eh2sHIaKpxC2QZ/TPIv5EHUrlp+MLMo9+Dbv6tJOWddrQGhe8la
 fHZGe1brWaA8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__ptrace_may_access() picks the filesystem or the real uid and gid of the
caller by its mode and wants them to be all three of the uids and gids of
the target. Say which ids it is and use the library.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 kernel/ptrace.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index 4e9822a87aab..2d2ffc656b41 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -305,8 +305,7 @@ static bool task_still_dumpable(struct task_struct *task, unsigned int mode)
 static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 {
 	const struct cred *cred = current_cred(), *tcred;
-	kuid_t caller_uid;
-	kgid_t caller_gid;
+	enum cred_ids caller_ids;
 
 	if (!(mode & PTRACE_MODE_FSCREDS) == !(mode & PTRACE_MODE_REALCREDS)) {
 		WARN(1, "denying ptrace access check without PTRACE_MODE_*CREDS\n");
@@ -327,8 +326,7 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 		return 0;
 	rcu_read_lock();
 	if (mode & PTRACE_MODE_FSCREDS) {
-		caller_uid = cred->fsuid;
-		caller_gid = cred->fsgid;
+		caller_ids = CRED_IDS_FS;
 	} else {
 		/*
 		 * Using the euid would make more sense here, but something
@@ -338,16 +336,10 @@ static int __ptrace_may_access(struct task_struct *task, unsigned int mode)
 		 * used a syscall that requests access to another process
 		 * (and not a filesystem syscall to procfs).
 		 */
-		caller_uid = cred->uid;
-		caller_gid = cred->gid;
+		caller_ids = CRED_IDS_REAL;
 	}
 	tcred = __task_cred(task);
-	if (uid_eq(caller_uid, tcred->euid) &&
-	    uid_eq(caller_uid, tcred->suid) &&
-	    uid_eq(caller_uid, tcred->uid)  &&
-	    gid_eq(caller_gid, tcred->egid) &&
-	    gid_eq(caller_gid, tcred->sgid) &&
-	    gid_eq(caller_gid, tcred->gid))
+	if (cred_ids_allow_control(cred, caller_ids, tcred))
 		goto ok;
 	if (ptrace_has_cap(tcred->user_ns, mode))
 		goto ok;

-- 
2.55.0

