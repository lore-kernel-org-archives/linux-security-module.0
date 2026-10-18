Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374140489A
	for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 17:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792344727; cv=none; b=B/bcFDAOKL8+O4BHtvzLL3XLX5RBf8duUUcrB0rRS+pw3E7+Y2tGf2YDc18bY2De47yivSDF7A/K8Y9IGYm8AS4oMltsmqKzygFhW0YIechTg5wyzSMkniRfoIlO4Oi4tJIH4o7NnxF6ru756QWlCLBlLr9scy/rsUHqxNc/5uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792344727; c=relaxed/simple;
	bh=KucUm1Ey8fIwY6N4JmI10cItucWI4TcTRwIQX++lvsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rNEyPTmdYsQ2AsucVJ9yDHn0xF7an9nYIUvsTEnurszZ5cNciTWx22ERcp2UDH5j9Ab6dd+KBGg0n0DD+wV28gROcurUcfWZELC3ZQALuoJwrIufgC08O8TiCFQJxJL8sJdqXi5b7ypPgJGQEZzSOxNyjIOhgbDzvV0HTckrWfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=Yf2rbL59; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="Yf2rbL59"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-919abb3335fso10718556d6.0
        for <linux-security-module@vger.kernel.org>; Sun, 18 Oct 2026 10:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792344725; x=1792949525; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pk5Sywaxxvlf3kNYWYgbWDu+VHub7GjAh3IWbEexT5o=;
        b=Yf2rbL59wTqm2x7NiYvTAQnt21YSVzR0zpngUoiTiOEmx3sNElE0i9nGBaAEN03AAI
         Hk8VnSEmeaKEgngI5VEsBzpCOoLqMZS5BrQ1Sg4PXymwHFyKks07QNJqpKfeA0H1IHqv
         hKjozZnEXBSuTQzECY2N/+03Cm4720q+NcwhwtpPyuQp6cZN1OuSXRHIPIv+I7f4APFA
         JXsgLaHun0cqhNAQKUBikFo/k4Gh1avnlBr+TAkxGP7UIPexmnXfq3kmHj6DgetviBcv
         MmuVioqy8xrMyeXoO4tMWNXtFr+MnyyCq2N2n0mySySj6/8iJtO8kmLlkKDh9ntROnRw
         k/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792344725; x=1792949525;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pk5Sywaxxvlf3kNYWYgbWDu+VHub7GjAh3IWbEexT5o=;
        b=jLNQhj8Q2733hpTnNHWlxYlUoLi8rmasKIIkorPvkHQj/31p+OPNJGQ5sr04O0vApX
         4Pk4lplK3W11bsynTNcNl8SI0+E8NEDbGrpBU0fW/YCp0tOG022Wpxd1z5WB9cja3BjT
         lD7deZqFegaqgmL24GYoYduaHcH7Mk2L614GLlFFKiqKX+C+Cvp7zIZTcA2+Iv2PnNX7
         0einDgjzPix/dLcQA8qrOx35ls/atHQoB9GZJMA0SBwVYfWE98fbrEwEXUe2CiR6e1xX
         l53CKuppLz3GOHab+w3Lh1cqmNuKZ+qmD+Vek7KclNO0KFZpDWvkycoYKOPHuxInQNpv
         bPzw==
X-Forwarded-Encrypted: i=1; AKwUvBxEmYyXhdPBxSmV87ZxMpnun6loq9zgX4yac9aSn4v737ojGB5muCynr5RKcGPQklSM5O0UBCR/qvEeK0bdpP/yhmgEMhM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhwcvxVAsKSy3uWpj1eGeMFllGCXPykDCoWwVqQ51ftTyvSVEr
	jX+o0EeL0a+wErwYW9+PMwszbl7tk314x/CpjSrlriZ0lxFFy4UPKINShJLFkHj/n7BzG4enUD6
	HYhhf
X-Gm-Gg: AYBFou0BKHdYa5cSCaHEFylepP4xk0Yi+/XE2iB4WclSDazP+TpCKKkJpOC80wtduQJ
	trsHQgGr1tm1nJbkKCXq9fRdaZHsU96cQHJcL5rBhqMXyaVCKeN36dtXh71xjNIuhlqfmXv/Byi
	s2q2T8gmtnhvVtMOU2zOQfaGr8N5JGufga/89SOuYhhuil2/WVVzPyRUAQHIX/Kwv+rKy5T9+Qq
	31teJ31mwzfvSzDlG3o6V6pTdhzbUjd6hogVPH5BkZE6ymjQpbWyqhjlG0C3Y3ru4I1CFc8UZJS
	dhiF9CBrb/v/9HXVi6K66wO8WLHHf4+YIp4mZxKkq/p3IWqRzk7IXZ/6nPT3lmXGJb901lLZi7M
	1SjJce1aNdid+hP4OVIEH6ZMH1xTYjNB3Hi1W9b3q6Z5DU+Hqwx1WW3tHda8HoYd2LA1rG7WDTE
	EgAFTT7Udf3oXs/52Lb4orrT868NQqMQIX+0h3lnMzGG4HU/D0RjRo6+RCgFhynvT186oY/oNHw
	pWXAjgtZiDRzFrS9QSGJ0OyYQ==
X-Received: by 2002:a05:6214:f07:b0:91b:a852:b469 with SMTP id 6a1803df08f44-91bdf154d12mr104021176d6.41.1792344725328;
        Sun, 18 Oct 2026 10:32:05 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.243])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bd2158f7dsm68875366d6.6.2026.10.18.10.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 10:32:04 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Sun, 18 Oct 2026 17:31:46 +0000
Subject: [PATCH 04/13] fcntl: use cred_ids_allow_sigio()
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261018-b4-cred-ids-v1-4-7bdf2db4ea9f@toxicpanda.com>
References: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
In-Reply-To: <20261018-b4-cred-ids-v1-0-7bdf2db4ea9f@toxicpanda.com>
To: Christian Brauner <brauner@kernel.org>, 
 Paul Moore <paul@paul-moore.com>
Cc: Serge Hallyn <sergeh@kernel.org>, linux-fsdevel@vger.kernel.org, 
 linux-security-module@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792344714; l=4179;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=KucUm1Ey8fIwY6N4JmI10cItucWI4TcTRwIQX++lvsY=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QCQbV0TouY4f8RR5evfTj4xII+Shq+EZ4tnipAGq4OEtuVeFSFqlvliRiaxxJXsJDXCbcl710gV
 S8ClFsu7Q6g8=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

sigio_perm() has the four comparisons of kill_ok_by_cred(), and lets euid
0 signal anybody. Use the library.

The library compares credentials. F_SETOWN only copies the uid and the
euid of the caller into struct fown_struct, so keep a reference on its
credentials instead, as struct file does for whoever opened it. That makes
the sender of a SIGIO a credential like the sender of any other signal.

F_GETOWNER_UIDS goes on reporting uid 0 for a file whose owner was never
set.

The credentials now stay around until the owner is set again or the file
is released. Clearing the owner leaves them alone, as it left the two ids
alone, so that F_GETOWNER_UIDS goes on reporting them. Who may be
signalled does not change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/fcntl.c             | 19 ++++++++++---------
 include/linux/fs.h     |  4 ++--
 security/landlock/fs.h |  3 +--
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/fs/fcntl.c b/fs/fcntl.c
index 9b71bc9d71d1..07fe32330bec 100644
--- a/fs/fcntl.c
+++ b/fs/fcntl.c
@@ -120,6 +120,7 @@ void file_f_owner_release(struct file *file)
 	f_owner = file_f_owner(file);
 	if (f_owner) {
 		put_pid(f_owner->pid);
+		put_cred(f_owner->cred);
 		kfree(f_owner);
 	}
 }
@@ -140,10 +141,9 @@ void __f_setown(struct file *filp, struct pid *pid, enum pid_type type,
 		f_owner->pid_type = type;
 
 		if (pid) {
-			const struct cred *cred = current_cred();
 			security_file_set_fowner(filp);
-			f_owner->uid = cred->uid;
-			f_owner->euid = cred->euid;
+			put_cred(f_owner->cred);
+			f_owner->cred = get_current_cred();
 		}
 	}
 	write_unlock_irq(&f_owner->lock);
@@ -315,9 +315,12 @@ static int f_getowner_uids(struct file *filp, unsigned long arg)
 
 	f_owner = file_f_owner(filp);
 	if (f_owner) {
+		const struct cred *cred;
+
 		read_lock_irq(&f_owner->lock);
-		src[0] = from_kuid(user_ns, f_owner->uid);
-		src[1] = from_kuid(user_ns, f_owner->euid);
+		cred = f_owner->cred;
+		src[0] = from_kuid(user_ns, cred ? cred->uid : GLOBAL_ROOT_UID);
+		src[1] = from_kuid(user_ns, cred ? cred->euid : GLOBAL_ROOT_UID);
 		read_unlock_irq(&f_owner->lock);
 	}
 
@@ -847,10 +850,8 @@ static inline int sigio_perm(struct task_struct *p,
 
 	rcu_read_lock();
 	cred = __task_cred(p);
-	ret = ((uid_eq(fown->euid, GLOBAL_ROOT_UID) ||
-		uid_eq(fown->euid, cred->suid) || uid_eq(fown->euid, cred->uid) ||
-		uid_eq(fown->uid,  cred->suid) || uid_eq(fown->uid,  cred->uid)) &&
-	       !security_file_send_sigiotask(p, fown, sig));
+	ret = cred_ids_allow_sigio(fown->cred, cred) &&
+	      !security_file_send_sigiotask(p, fown, sig);
 	rcu_read_unlock();
 	return ret;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 83d41d9f1130..51aff96e6aa7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1183,10 +1183,10 @@ static inline unsigned imajor(const struct inode *inode)
 
 struct fown_struct {
 	struct file *file;	/* backpointer for security modules */
-	rwlock_t lock;          /* protects pid, uid, euid fields */
+	rwlock_t lock;          /* protects pid, cred fields */
 	struct pid *pid;	/* pid or -pgrp where SIGIO should be sent */
 	enum pid_type pid_type;	/* Kind of process group SIGIO should be sent to */
-	kuid_t uid, euid;	/* uid/euid of process setting the owner */
+	const struct cred *cred; /* of the process setting the owner */
 	int signum;		/* posix.1b rt signal to be delivered on IO */
 };
 
diff --git a/security/landlock/fs.h b/security/landlock/fs.h
index 50b3ddb8ac1c..d3aa84820594 100644
--- a/security/landlock/fs.h
+++ b/security/landlock/fs.h
@@ -84,8 +84,7 @@ struct landlock_file_security {
 	 * @fown_subject: Landlock credential of the task that set the PID that
 	 * may receive a signal e.g., SIGURG when writing MSG_OOB to the
 	 * related socket.  This pointer is protected by the related
-	 * file->f_owner->lock, as for fown_struct's members: pid, uid, and
-	 * euid.
+	 * file->f_owner->lock, as for fown_struct's members: pid and cred.
 	 */
 	struct landlock_cred_security fown_subject;
 	/**

-- 
2.55.0

