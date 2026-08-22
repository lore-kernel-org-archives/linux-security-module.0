Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FAA355803
	for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 21:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787433233; cv=none; b=EKFD3NmiEjJUiuaugaZ9B2ZhUDVrF7AzGkypO1Oam4uikQbq2K49HuJkPk5MTVKke3EPmkIiDQEeKhA/pIDostxYLrbz3DnVh1tpiBTfZwgALXCunPhLuFhoXIusq44tq/NIhUKZKNxFTWcqI0z4AqRQB8YczehHkeRedPcu4OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787433233; c=relaxed/simple;
	bh=7P8b0PiXZkXLkBCI7+fw+OLCGRdaT4yASBksG39Fqco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBUlH8SMfi9GndD5zNN/uERM2zO4c2FPtk2Xbo8bywOCmJOLsb/fIwLdbjwekAlIiSgxK8dCEOjAoaQgdOvBojF5Xjd9KTnW2yO/EXQwZRNo8ejyDJyDrEEQIkCJNUtUAUbLz91Thg7kNDI8VUwjUJ7A+i3Fzp47acANW/M7AgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHYq87Va; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHYq87Va"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a20319d030so3415528a12.2
        for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 14:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787433229; x=1788038029; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tUUymyRcxRdxWUHun2KoKNT+znoTD5gkX1D64Gb9Ido=;
        b=ZHYq87VaT4tXo5xe+jbrZ751qDKBkG1I+ecuOyL20DxdxDPcJMgs0THCKOZgvX5N2U
         JB/MvqGJUcpOTRcBlk6Uu2r6JcOQZ6eIAQX6iuqK8dZKOj6SJKW4/DTtiiBZ6fZGEVvO
         vF5k61rB3/n3BEcDJr8XbVwxRfLjXtZuOGhEGe17df+fFtcCez5F6x0FsM5+WVzLBF58
         +oR2m7QK5qZHaFOxPnagd9LRg0H5i0mA3UDgaAYf5CyRkZqcP+OUCwWMevV66I/qOoUM
         l65DL/YJrkivJ+gFFAnOTkUmI2LCoGS21pIWRhB8cMHKM0yiZrVV1+GvYnDKOH2sPgAl
         pFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787433229; x=1788038029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tUUymyRcxRdxWUHun2KoKNT+znoTD5gkX1D64Gb9Ido=;
        b=EZstBvRfJNJNwTSJvY/NYEViyV/Cy0hIlN428PsazVyAKhtNY8F/JUPmyQ3y729GaL
         RM90hpHJjkHUNsYk79uDqjMZALpx3HG8xvwDeQGkK7KL3tKm+QDVoxIN4Tdr14BdoEY2
         9dP0OEzFe/KqOfZrJlnzYamR7lrARjimzg8D161ZYSlLvVwVppzsBpgvU7Ya6hGXvSMv
         MATLvxqjYVDGXEANROJghP03qhGefuA56fXpNTrVZQfJPHSq98P01zQdMgFclaZUGFRB
         I4fM1xyW7AAlHcefj47mKx+ZmUA0/vHCGnhL2YnPycnTxNzCYC/RN32QnrnCv39afpqF
         5UHw==
X-Forwarded-Encrypted: i=1; AHgh+Rp8eOxY+8JKCNsMGgc7qbH3d+Tt2oSYunhQAMbHSVCb4NtLHt9dUvyxnsi43QeHA9rPyBzqPS8J1sa8ZOHSa5/8jSLpeVc=@vger.kernel.org
X-Gm-Message-State: AFuF++mAN83jPYE2pqc2MekheixKXVgMslWjTqUVwsf/r/ZTflkjgpx4
	6zkK7xKGe5svLfMUq9KB8zqXrDa31/yCpmyowz6eUazx0JEbj2ybIhfp
X-Gm-Gg: AR+sD131pDP1u3BJfvb3JTOhWQD6DeBpvLcRwFCMlQGocORpTie/8VKjYxRNHRdvPvV
	eswGxV0QWEtQkHGKdAIWj8PMjcobnCHNEuKgWbunzgdvVDBuPERAbO30P/lJpYOkP99EQ6Wztxo
	XHy3eE+gAUegr1JRQ41YmqpYKtoGx1XDZN5nbsmJKkR9q1wy3vY/XpqUh91X1abuZASYqVkszaB
	9cZ1UBxMqgEr+f62hw9PvQkMuhyglwpo6I8ixx2Xyp7CbEEW2s5+qWbrKsmgRWPPu82NX9B5dJj
	5eUMCQH+IK9QkLxvJCj0yRKFyr0Sp9y1Pq6Os8QNd2wGauQcEdMfxaZmm8y9pZJ8wDRsz8cYOYY
	a/A1P0ZAAUAgHo/ZVVYfD66AaKT/FdVJH/6MYK4K0W1sgyR0CBpAxz9H9St4fmlxbex8fraiszS
	O/2NjJG2BAhsP/QeyYjilThMSSn87T2r+RCTmKRkXVOTepbvRXuaf8+DUuAJz/BCastQknucEEB
	tLuj0j7W7WDvg==
X-Received: by 2002:a05:6402:450f:b0:6a0:a65a:a0c2 with SMTP id 4fb4d7f45d1cf-6a42f1a0226mr17866603a12.7.1787433229189;
        Sat, 22 Aug 2026 14:13:49 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff177b1esm14274106a12.29.2026.08.22.14.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:13:48 -0700 (PDT)
Date: Sat, 22 Aug 2026 23:13:44 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: mic@digikod.net, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] landlock: Add scoped access bit for SysV message
 queues
Message-ID: <20260822.3340c3dd2a46@gnoack.org>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
 <20260822.c9dcabf4999f@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260822.c9dcabf4999f@gnoack.org>

On Sat, Aug 22, 2026 at 07:26:33PM +0200, Günther Noack wrote:
> I get the impression that with this scheme it would be possible for a
> landlocked process to guess the key of a set of programs which have
> not created their message queue yet, so that these would then start
> communicating on that message queue which the sandboxed process has
> access to.

I realized I did maybe not express that clearly enough: Not only would
the landlocked process guess the right key, but it would then also
*create* the queue msgget(key, IPC_CREAT|mode).

There apparently is a pattern in real-world software where the program
creates the message queue on the fly if it doesn't exist yet, but uses
the existing queue if it does.  Such software is then prone to reuse
the message queue that was created by the landlocked process.  (You
can find such programs using the Debian code search query from the
parent mail.)

Step 1: Landlocked program creates message queue.
        Because it creates the queue, it has access to it.

Step 2: Program outside of that domain runs, trying to use the message
        queue.  It discovers that the queue already exists and starts
        using it.

Step 3: Landlocked program can read and write the queue and manipulate
        it.

–Günther

> (Other processes can in principle protect against that by using
> IPC_CREAT only with IPC_EXCL, but if I understand correctly, it is
> also a common pattern that communicating processes all simply use
> msgget() with IPC_CREAT but *without* IPC_EXCL, so that the message
> queue for them gets created on the fly when first used?)
> 
> To get a feeling for the number of invocations without IPC_EXCL,
> compare the number of search results on Debian Code Search for:
> https://codesearch.debian.net/search?q=msgget%5C%28.*IPC_CREAT&literal=0 (90 results)
> https://codesearch.debian.net/search?q=msgget%5C%28.*IPC_EXCL&literal=0 (26 results))
> 
> The construction of the keys is often simple and not built to protect
> against guessability.  ftok() is already somewhat guessable.  Some
> programs even use hardcoded key numbers or invent their own
> ftok()-like derivation scheme.
> 
> I do not see how we can prevent the message-queue-squatting situation
> with the current patch set; It feels like a mistake that we need to
> analyze what other programs outside the sandbox do, in order to
> enforce that the sandboxed program can't talk to them.
> 
> Do you have thoughts on this?
> 
> > Quirks
> > ======
> > - Denials surface as -EACCES rather than -EPERM because the generic
> >   ipcperms() path maps every LSM denial to -EACCES before returning
> >   to userspace.  This is documented and the selftests check for
> >   -EACCES accordingly.
> > - Because there is no persistent handle, a msqid already obtained
> >   by a process before it enforces this scope can become unusable
> >   once the restriction is in place; this is intentional and
> >   documented.
> > 
> > Patch layout
> > ============
> >   1. Add the kern_ipc_perm credential blob and @kind enum.
> >   2. Implement LANDLOCK_SCOPE_SYSV_MSG_QUEUE, the ipc_permission
> >      hook, and msg_queue_msgctl coverage for IPC_RMID/IPC_SET and
> >      IPC_INFO/MSG_INFO.
> >   3. Bump the Landlock ABI.
> >   4. Selftests covering msgget plus a separate fixture for msgsnd,
> >      msgrcv, and msgctl using a pre-created msqid.
> >   5. sandboxer sample support for the new scope.
> >   6. Documentation updates covering the new scope, the -EACCES
> >      return code, and the implications of non-persistent handles.
> > 
> > Test coverage
> > =============
> > Selftests exercise denial and allow paths for msgget, msgsnd,
> > msgrcv, and msgctl(IPC_STAT) across domain boundaries, including
> > nested-domain inheritance.  All existing and added tests are
> > passing.
> 
> An audit test would be nice as well; we have one for each possible
> denial, I think.
> 
> > 
> > Changes since v1
> > ================
> > - Rebased on mic/next.
> > - Fixed the kernel-doc Return descriptions of hook_ipc_permission()
> >   and hook_msg_queue_msgctl().
> > - Renamed the internal audit request type to
> >   LANDLOCK_REQUEST_SCOPE_SYSV_MSG_QUEUE for consistency with the
> >   UAPI macro and the "scope.sysv_msg_queue" audit blocker string.
> > - Integrated the new scope with the sandboxer's quiet access
> >   support added in ABI 10 (new "sysv_msg_queue" LL_QUIET_ACCESS
> >   token).
> > - Selftests: track the created msqid in the fixture and remove it in
> >   FIXTURE_TEARDOWN_PARENT() so queues are reclaimed even when a failed
> >   assertion aborts a test (and never subject to the scoping under
> >   test); use IPC_PRIVATE where the key is not needed.
> > - Added CONFIG_SYSVIPC=y to the selftest config fragment.
> > - Fixed the patch 6 subject typo (LANDLOCK_SCOPE_SYSV_MESSAGE_QUEUE)
> >   and replaced an incorrect ipcperms(3) manpage reference with the
> >   kernel helper ipcperms().
> > - Reworded the LANDLOCK_SCOPE_SYSV_MSG_QUEUE UAPI comment and the
> >   in-code comment explaining the -EACCES mapping.
> > 
> > v1: https://lore.kernel.org/all/20260521160640.1716746-1-utilityemal77@gmail.com/
> > 
> > Kind Regards,
> > Justin Suess
> > 
> > Justin Suess (6):
> >   landlock: Add kern_ipc_perm credential blob structs
> >   landlock: Add LANDLOCK_SCOPE_SYSV_MSG_QUEUE
> >   landlock: Bump ABI for LANDLOCK_SCOPE_SYSV_MSG_QUEUE
> >   selftests/landlock: Test LANDLOCK_SCOPE_SYSV_MSG_QUEUE
> >   samples/landlock: Support LANDLOCK_SCOPE_SYSV_MSG_QUEUE in sandboxer
> >   landlock: Document LANDLOCK_SCOPE_SYSV_MSG_QUEUE
> > 
> >  Documentation/admin-guide/LSM/landlock.rst    |   1 +
> >  Documentation/userspace-api/landlock.rst      |  30 +-
> >  include/uapi/linux/landlock.h                 |   4 +
> >  samples/landlock/sandboxer.c                  |  24 +-
> >  security/landlock/audit.c                     |   4 +
> >  security/landlock/audit.h                     |   1 +
> >  security/landlock/limits.h                    |   2 +-
> >  security/landlock/setup.c                     |   1 +
> >  security/landlock/syscalls.c                  |   2 +-
> >  security/landlock/task.c                      | 137 +++++++++
> >  security/landlock/task.h                      |  50 ++++
> >  tools/testing/selftests/landlock/base_test.c  |   2 +-
> >  tools/testing/selftests/landlock/config       |   1 +
> >  .../landlock/scoped_sysv_msg_queue_test.c     | 265 ++++++++++++++++++
> >  .../testing/selftests/landlock/scoped_test.c  |   2 +-
> >  15 files changed, 517 insertions(+), 9 deletions(-)
> >  create mode 100644 tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c
> > 
> > 
> > base-commit: 28ca6f6f271d47253c240e64cc88a72c89456d74
> > -- 
> > 2.54.0
> > 
> 
> –Günther
