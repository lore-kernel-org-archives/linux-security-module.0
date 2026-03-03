Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4A14D8D83
	for <linux-security-module@vger.kernel.org>; Tue,  3 Mar 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554815; cv=none; b=mEtb5MNVltR8TIqs7Y2B3Y/5lRxCxomK01v2pWFzkDTACsji11nKJ9G1DrDFPy+QMUW4lvRHTS6ws5/nvd/tr5N9dASr5e7ydALxCw8KP3DKWiUH9VLoXHDLFYpOoCd0CmrHJtdyIIbLs4hECQaU6NdOZfYVeKHfeeCx9HPU4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554815; c=relaxed/simple;
	bh=pRWVtA0NPBuRlebAWpqWGdY4rkxOs6wGjx/Hbb76f4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V+0z0yivoT3km9GTcWPLTopWlogH5XnngZXzOkMm+KDV1C0xNPSAbw3lqpiJ01pWtTpl3uU4jNXDosLSV0w3r5CXTNDot74qNTDbfSPFOKVBnV/WX6luMp8zroPc904ZNDjq9X6l6L4F1zp2iNG8/YnndNykd1xB26qdy6M6tV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSJe0M9f; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSJe0M9f"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7927261a3acso50185127b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Mar 2026 08:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772554813; x=1773159613; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o834rxCETENfWBz/+3Of3O+oNKGzA/VUJ8iJDGGROqo=;
        b=WSJe0M9f6srdsuyYUPjFWYa7uouZDVRVXCEjpbYlU0Xx9tlGWn1cX4+2Xqr5HgObXW
         K1rjwG16PHIU2SPUAhR3iciAmESCjFqnPrHjgWF/5/IU0TXlSG42nkDe8x8CwPrGWo3I
         vtxINb2qnmnVccpiv2T4cDWW6InEhcdE53Lk+1K/1GxpJmLWKpHr6pogN9zo/DUjj1Gb
         ziO0BH66TyPlesZuJyh+Qv/JIH/p3h/9QsPqogZATlYF5sMCf0Kiz2t7lMO9RhGjUn5O
         qgdLab8G+lh2pnI4ukswaaa9tanDWbspJ6JHEfZmsUcltNBNj4mKE99MMLkNo70IMu+h
         KCFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772554813; x=1773159613;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o834rxCETENfWBz/+3Of3O+oNKGzA/VUJ8iJDGGROqo=;
        b=OrUzFl1xMGeW9VX3RAEza8K448Krsr3rFUWSh7Rm8r/zSBndE2eUoCoqfJor5K7UGk
         roYNv7DSkXfq/8ZgJTyxYKeOjVVN4MRNCXsURTOZRu5AvSd9iKAv7FLwFa4+cgz46HzX
         5ue524jTkrKzG9h/r8uphVIPiMUbDALANJApRAbitJ1nbNp9V1iy3+GUIikOYVLsGgAl
         fyoZ0xhGfz/xzCxOOSb9gFan6dVuZIa7e3NiQYVQUFoqWG+8ccPpVnnbRBYlgR0Fh9UT
         sJb77FAU1z8yiNnSt5l7e+BdpRm+LYXfL/a5i6t5tgxR88c7WzauhFVe6XqPnMVvMf6G
         PC6w==
X-Forwarded-Encrypted: i=1; AJvYcCUYv9sicVDstGXHZ2msT6cgKZxTd3uIoW+9KDAPVsm/zFf0uwsoJMS5Q9Umdh6AvJWNdCN3bsfULQ5YFalmpZHqDkbpU6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi1CYzMIfNOAo33KC4v6cPSZVGHGA2FZ/eJcAzYugJFgSKzHPT
	FsoB189HIU6ixaVXTfGEPQ61INj82QnzrPnSRhsqwIutHsEsXZbq3HWk
X-Gm-Gg: ATEYQzx1k8aFY0WcDApGsckOTsV7yiyEg/gfpB48zNdGIZB2Y8eTkJODDFi7sQCfeNW
	GfzsbdwfW0MQydArqUk1XDKKdVnmiguBp/34I3075fu9SESNSAEtrdQk1/ABQncp6O610UMvjBN
	8Y9hb1CbxCvb5k0XEr3il/wdy8qBqROoPVhSLn9AQDz85FKOZ+3uBTOvdTa67nv/EoGOubo5oHC
	n44KIn9LellvymgtqLZKa8LTNKwW47cNB/YH7Wqg3cuLRYHIHS5W5ShsMIgtw52LBnHj+EEIz/O
	JjX3FxZJEabiqBTEPPZymUdOULZ1iCJxOXc4Rb9OG8e0qHKUI3dhU3KRFBGCnBf8zfBTFcVZgA9
	0TbYaUOuSVLO7oOeb4qj6UFS+LPh+AcF2X0VSSQZK16i1IMcnETfqyydXhKmnsn7v6n5INiKg/f
	HB50b6Y0m2J5u+/D5jAI8NreUjCkdcyg==
X-Received: by 2002:a05:690c:650a:b0:795:1d73:4d7d with SMTP id 00721157ae682-7988544b709mr153197667b3.12.1772554813155;
        Tue, 03 Mar 2026 08:20:13 -0800 (PST)
Received: from suesslenovo ([129.222.254.128])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79876c7fa3fsm65285537b3.45.2026.03.03.08.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 08:20:12 -0800 (PST)
Date: Tue, 3 Mar 2026 11:20:10 -0500
From: Justin Suess <utilityemal77@gmail.com>
To: Yihan Ding <dingyihan@uniontech.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
	Paul Moore <paul@paul-moore.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
Subject: Re: [PATCH v3 1/2] landlock: Serialize TSYNC thread restriction
Message-ID: <aacKOr1wywSSOAVv@suesslenovo>
References: <20260226015903.3158620-1-dingyihan@uniontech.com>
 <20260226015903.3158620-2-dingyihan@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260226015903.3158620-2-dingyihan@uniontech.com>

On Thu, Feb 26, 2026 at 09:59:02AM +0800, Yihan Ding wrote:
> syzbot found a deadlock in landlock_restrict_sibling_threads().
> When multiple threads concurrently call landlock_restrict_self() with
> sibling thread restriction enabled, they can deadlock by mutually
> queueing task_works on each other and then blocking in kernel space
> (waiting for the other to finish).
> 
> Fix this by serializing the TSYNC operations within the same process
> using the exec_update_lock. This prevents concurrent invocations
> from deadlocking. 
> 
> We use down_write_trylock() and return -ERESTARTNOINTR if the lock
> cannot be acquired immediately. This ensures that if a thread fails
> to get the lock, it will return to userspace, allowing it to process
> any pending TSYNC task_works from the lock holder, and then
> transparently restart the syscall.
> 
> Fixes: 42fc7e6543f6 ("landlock: Multithreading support for landlock_restrict_self()")
> Reported-by: syzbot+7ea2f5e9dfd468201817@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=7ea2f5e9dfd468201817
> Suggested-by: Günther Noack <gnoack3000@gmail.com>
> Signed-off-by: Yihan Ding <dingyihan@uniontech.com>
> ---
> Changes in v3:
> - Replaced down_write_killable() with down_write_trylock() and 
>   returned -ERESTARTNOINTR to avoid a secondary deadlock caused by 
>   blocking the execution of task_works. (Caught by Günther Noack).
> 
> Changes in v2:
> - Use down_write_killable() instead of down_write().
> - Split the interrupt path cleanup into a separate patch.
> ---
>  security/landlock/tsync.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
> index de01aa899751..xxxxxxxxxxxx 100644
> --- a/security/landlock/tsync.c
> +++ b/security/landlock/tsync.c
> @@ -447,6 +447,13 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
>  	shared_ctx.new_cred = new_cred;
>  	shared_ctx.set_no_new_privs = task_no_new_privs(current);
>  
> +	/*
> +	 * Serialize concurrent TSYNC operations to prevent deadlocks
> +	 * when multiple threads call landlock_restrict_self() simultaneously.
> +	 */
> +	if (!down_write_trylock(&current->signal->exec_update_lock))
> +		return -ERESTARTNOINTR;
These two lines above introduced a test failure in tsync_test
completing_enablement.

The commit that introduced the bug is 3d6327c306b3e1356ab868bf27a0854669295a4f
(this patch) and is currently in the mic/next branch.

I noticed the test failure while testing an unrelated patch.

The bug is because this code never actually yields or restarts the syscall.

This is the test output I observed:

  [+] Running tsync_test:
  TAP version 13
  1..4
  # Starting 4 tests from 1 test cases.
  #  RUN           global.single_threaded_success ...
  #            OK  global.single_threaded_success
  ok 1 global.single_threaded_success
  #  RUN           global.multi_threaded_success ...
  #            OK  global.multi_threaded_success
  ok 2 global.multi_threaded_success
  #  RUN           global.multi_threaded_success_despite_diverging_domains ...
  #            OK  global.multi_threaded_success_despite_diverging_domains
  ok 3 global.multi_threaded_success_despite_diverging_domains
  #  RUN           global.competing_enablement ...
  # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
  # competing_enablement: Test failed
  #          FAIL  global.competing_enablement
  not ok 4 global.competing_enablement
  # FAILED: 3 / 4 tests passed.


Brief investigation and the additions of these pr_warn lines:


diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
index 0d66a68677b7..84909232b220 100644
--- a/security/landlock/syscalls.c
+++ b/security/landlock/syscalls.c
@@ -574,6 +574,9 @@ SYSCALL_DEFINE2(landlock_restrict_self, const int, ruleset_fd, const __u32,
 		const int err = landlock_restrict_sibling_threads(
 			current_cred(), new_cred);
 		if (err) {
+			pr_warn("landlock: restrict_self tsync err pid=%d tgid=%d err=%d flags=0x%x ruleset_fd=%d\n",
+				task_pid_nr(current), task_tgid_nr(current), err,
+				flags, ruleset_fd);
 			abort_creds(new_cred);
 			return err;
 		}
diff --git a/security/landlock/tsync.c b/security/landlock/tsync.c
index 5afc5d639b8f..deb0f0b1f081 100644
--- a/security/landlock/tsync.c
+++ b/security/landlock/tsync.c
@@ -489,8 +489,11 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 	 * Serialize concurrent TSYNC operations to prevent deadlocks when multiple
 	 * threads call landlock_restrict_self() simultaneously.
 	 */
-	if (!down_write_trylock(&current->signal->exec_update_lock))
+	if (!down_write_trylock(&current->signal->exec_update_lock)) {
+		pr_warn("landlock: tsync trylock busy pid=%d tgid=%d\n",
+			task_pid_nr(current), task_tgid_nr(current));
 		return -ERESTARTNOINTR;
+	}
 
 	/*
 	 * We schedule a pseudo-signal task_work for each of the calling task's
@@ -602,6 +605,10 @@ int landlock_restrict_sibling_threads(const struct cred *old_cred,
 
 	tsync_works_release(&works);
 	up_write(&current->signal->exec_update_lock);
+	if (atomic_read(&shared_ctx.preparation_error))
+		pr_warn("landlock: tsync preparation_error pid=%d tgid=%d err=%d\n",
+			task_pid_nr(current), task_tgid_nr(current),
+			atomic_read(&shared_ctx.preparation_error));
 
 	return atomic_read(&shared_ctx.preparation_error);
 }

Resulted in the following output:

  landlock: tsync trylock busy pid=1263 tgid=1261
  landlock: landlock: restrict_self tsync err pid=1263 tgid=1261 err=-513 flags=0x8 ruleset_fd=6
  # tsync_test.c:156:competing_enablement:Expected 0 (0) == d[1].result (-1)
  # competing_enablement: Test failed
  #          FAIL  global.competing_enablement
  not ok 4 global.competing_enablement

I have a fix that I will send as a patch.

Kind Regards,
Justin Suess
