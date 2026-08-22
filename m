Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731F738F654
	for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 21:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787435499; cv=none; b=iBPFFDNh4y1qGLKM4bAGDYRyF0zLvHC8KYKuBLRJQJ+BKsO0PPHEtZAHLW89zV4cK2wWRPHBWmaP0LctFljAuZSf3suJ+L6uMq0pL1JewxjTqLiOWSNnY4gMf5Ye6rvnc6QyIUWPhGd2+Xf6X4w+d9r18GjcPoLx/kt8Jg9Czu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787435499; c=relaxed/simple;
	bh=L+JW9PTYmuk5Ohw/HVDf1T4WNq3X/NHrtfzcmU62VFs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=poboPsc5evjEWR1zzGo5pUVrEhTo81uYY0+CARKqIJSEPYuX2cMR6kJq92Y5i6clU1pxUfBOthoTcY3QE53R0yXDpWw1kpKjzTaa5c8HfsGRFr8ZqwLblxodOOQq44Z2Rc4RPMnGvZDuHM5/WyEpVLm6GalMe5hnDkBvupwVLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEs5cTLk; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEs5cTLk"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8200b55dc47so34781047b3.3
        for <linux-security-module@vger.kernel.org>; Sat, 22 Aug 2026 14:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787435494; x=1788040294; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Kotc196bVnpw0bDrOXaNFE1eM70FAJ3bW37lICdS+k=;
        b=EEs5cTLkINuCMIQjj+55lc9Wetrn+mIL5JlSezx5dTCjdtdrY2qw6vZFV68M/Muo7p
         t1oMx+D1sEvTOW7xoJJ9GhxxSnf15DVlhoFIIk/DXETOBNenLzSetpxWLE3fa+B4Jl+I
         xqYaLRBx/ooVz2cuUMrLPQRDeTvb03cDcXY8ssgDtP2hSvHsbiDeHN6PeeQE2/CJ+iaK
         l1hnoVXIvzflJ3uOu6TeSLZIKzHJfA7ncYBy9CmXNpU7VLMkM9Plmlw0WPmRlq4+jAHc
         Rx5aJJc9bASQQQheyl3fAVuGoRAnHG/a+rEyS4z4EaVeY8lkg+901gaBKzWTo3PdjULd
         4IPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787435494; x=1788040294;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5Kotc196bVnpw0bDrOXaNFE1eM70FAJ3bW37lICdS+k=;
        b=Pdtql4Eoejw6/YMSUTlsNfvhe/SweVLMxdl5rCXvxd1h0A4xiPNYXtW521RRaILoC/
         iRb83jsuEFI8/w/sU8ygLPK76HQ5HTtSUtRWT5JHAq7wCAlEjJFwvIA4KJtAgVVoFvgM
         rHBeZq8aoUhAwuIp7Qo/7cAIEgf+6/eY4lvQEGAPhKmbQiQZJX8w4RpKDMDcXs38Nsch
         f3xcSooGS8yUhb2akhg27fDGnKkWeMkaKMrPFWantN4gzMqryDT7vBbBHTzSBesBwblj
         ffmHh0lKV2DGOcoCfC54gvSAEI+ovTIx3Lu1aVZpIvrWuMOflDKH7kcwZRjCVyJFrJKC
         sHhQ==
X-Forwarded-Encrypted: i=1; AHgh+RqyRyDBYcrr+KleBcMrCfx6SblL8x7NCuP/Pg0JbF1z2rBoG78fzL+RtpbTcoBhtsoKslVyi/dQ9IOq1aeC+l9RHRUED+M=@vger.kernel.org
X-Gm-Message-State: AFuF++mTy4z5pYQfySvWPoiIUsGDGKiTDlfKHRLnz4lLsAKqbM2uSnuH
	kNJpaXl7/y7+PnE/Gd99wTicNMlCDTbTZg5ujQQxYtbT5IE+Jyt8l1Dt
X-Gm-Gg: AR+sD135IlOqyZaXYnJp35IxG7A508xv+7l4rHJcNZlyXfc7z/KDgRvHp1aSL47niHU
	javg7AJnrclQGSxy3K7sPvLsfrCjU+vatHjrx6CMT9opSo6PNuRNUdeDPmjIZfGBo9txrXc6FL2
	7Bu+dnB4sutq7FYYwIrCBhdGsZe+1h8N0NFUf4RQK8GQPzwN8fOzca5GnuFvgniJlGZnYgIO97m
	81i2UhnXogi/A/+4Rz6s0iFzhq/chIE1WCgSr5q5iWb8wJ2qEALUjr4dgT58l7I/v3rT7NS1JuX
	2Y1o4U9Ddm4dtLZ1HP5rr11zG2o4hY0Ow+Y7/ajDEhQJU0BXMY1znlgrG6V6g8XenMvQCDG8wb7
	x9gp/9psLWXKb1UH9nBcUMwL3pTuu+jPPtCMpw5x5mxo9KAD8wXfCXmdF2xGi1RSR8cVIXDs9SZ
	rUz/mLSHEvLkDWhUumUdXH9rkW49OTj8j+q6xMdd0fAM6xCjeyMq7xKVYr4oyjztcu5qtb23LGA
	Tx5Zvk+A9SZQCNDtvvG
X-Received: by 2002:a05:690c:d8f:b0:80f:9998:e614 with SMTP id 00721157ae682-84c9b3154fcmr25877167b3.28.1787435494513;
        Sat, 22 Aug 2026 14:51:34 -0700 (PDT)
Received: from zenbox ([2600:1700:18fb:6011:26:e4c5:f749:31e3])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cac4ef4edsm14711547b3.45.2026.08.22.14.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 14:51:33 -0700 (PDT)
Date: Sat, 22 Aug 2026 17:51:33 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: mic@digikod.net, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] landlock: Add scoped access bit for SysV message
 queues
Message-ID: <aooS2VVhwWjY7ugo@zenbox>
References: <20260727230833.138165-1-utilityemal77@gmail.com>
 <20260822.c9dcabf4999f@gnoack.org>
 <20260822.3340c3dd2a46@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260822.3340c3dd2a46@gnoack.org>

On Sat, Aug 22, 2026 at 11:13:44PM +0200, Günther Noack wrote:
> On Sat, Aug 22, 2026 at 07:26:33PM +0200, Günther Noack wrote:
> > I get the impression that with this scheme it would be possible for a
> > landlocked process to guess the key of a set of programs which have
> > not created their message queue yet, so that these would then start
> > communicating on that message queue which the sandboxed process has
> > access to.
> 
> I realized I did maybe not express that clearly enough: Not only would
> the landlocked process guess the right key, but it would then also
> *create* the queue msgget(key, IPC_CREAT|mode).
> 
> There apparently is a pattern in real-world software where the program
> creates the message queue on the fly if it doesn't exist yet, but uses
> the existing queue if it does.  Such software is then prone to reuse
> the message queue that was created by the landlocked process.  (You
> can find such programs using the Debian code search query from the
> parent mail.)
> 
> Step 1: Landlocked program creates message queue.
>         Because it creates the queue, it has access to it.
> 
> Step 2: Program outside of that domain runs, trying to use the message
>         queue.  It discovers that the queue already exists and starts
>         using it.
> 
> Step 3: Landlocked program can read and write the queue and manipulate
>         it.
> 
I do agree. It's a little harder than unix sockets where we can control
things at the client/server level (no such construct exists for sysv)

It's a little bit tricky. I suppose the easiest way to handle it would
be to deny the ability to squat in a key in the first place. (deny msgget
except with IPC_PRIVATE).

This comes with a cost in functionality, but it is easy to implement and
closes the gap.

Justin
> –Günther
> 
> > (Other processes can in principle protect against that by using
> > IPC_CREAT only with IPC_EXCL, but if I understand correctly, it is
> > also a common pattern that communicating processes all simply use
> > msgget() with IPC_CREAT but *without* IPC_EXCL, so that the message
> > queue for them gets created on the fly when first used?)
> > 
> > To get a feeling for the number of invocations without IPC_EXCL,
> > compare the number of search results on Debian Code Search for:
> > https://codesearch.debian.net/search?q=msgget%5C%28.*IPC_CREAT&literal=0 (90 results)
> > https://codesearch.debian.net/search?q=msgget%5C%28.*IPC_EXCL&literal=0 (26 results))
> > 
> > The construction of the keys is often simple and not built to protect
> > against guessability.  ftok() is already somewhat guessable.  Some
> > programs even use hardcoded key numbers or invent their own
> > ftok()-like derivation scheme.
> > 
> > I do not see how we can prevent the message-queue-squatting situation
> > with the current patch set; It feels like a mistake that we need to
> > analyze what other programs outside the sandbox do, in order to
> > enforce that the sandboxed program can't talk to them.
> > 
> > Do you have thoughts on this?
> > 
> > > Quirks
> > > ======
> > > - Denials surface as -EACCES rather than -EPERM because the generic
> > >   ipcperms() path maps every LSM denial to -EACCES before returning
> > >   to userspace.  This is documented and the selftests check for
> > >   -EACCES accordingly.
> > > - Because there is no persistent handle, a msqid already obtained
> > >   by a process before it enforces this scope can become unusable
> > >   once the restriction is in place; this is intentional and
> > >   documented.
> > > 
> > > Patch layout
> > > ============
> > >   1. Add the kern_ipc_perm credential blob and @kind enum.
> > >   2. Implement LANDLOCK_SCOPE_SYSV_MSG_QUEUE, the ipc_permission
> > >      hook, and msg_queue_msgctl coverage for IPC_RMID/IPC_SET and
> > >      IPC_INFO/MSG_INFO.
> > >   3. Bump the Landlock ABI.
> > >   4. Selftests covering msgget plus a separate fixture for msgsnd,
> > >      msgrcv, and msgctl using a pre-created msqid.
> > >   5. sandboxer sample support for the new scope.
> > >   6. Documentation updates covering the new scope, the -EACCES
> > >      return code, and the implications of non-persistent handles.
> > > 
> > > Test coverage
> > > =============
> > > Selftests exercise denial and allow paths for msgget, msgsnd,
> > > msgrcv, and msgctl(IPC_STAT) across domain boundaries, including
> > > nested-domain inheritance.  All existing and added tests are
> > > passing.
> > 
> > An audit test would be nice as well; we have one for each possible
> > denial, I think.
> > 
> > > 
> > > Changes since v1
> > > ================
> > > - Rebased on mic/next.
> > > - Fixed the kernel-doc Return descriptions of hook_ipc_permission()
> > >   and hook_msg_queue_msgctl().
> > > - Renamed the internal audit request type to
> > >   LANDLOCK_REQUEST_SCOPE_SYSV_MSG_QUEUE for consistency with the
> > >   UAPI macro and the "scope.sysv_msg_queue" audit blocker string.
> > > - Integrated the new scope with the sandboxer's quiet access
> > >   support added in ABI 10 (new "sysv_msg_queue" LL_QUIET_ACCESS
> > >   token).
> > > - Selftests: track the created msqid in the fixture and remove it in
> > >   FIXTURE_TEARDOWN_PARENT() so queues are reclaimed even when a failed
> > >   assertion aborts a test (and never subject to the scoping under
> > >   test); use IPC_PRIVATE where the key is not needed.
> > > - Added CONFIG_SYSVIPC=y to the selftest config fragment.
> > > - Fixed the patch 6 subject typo (LANDLOCK_SCOPE_SYSV_MESSAGE_QUEUE)
> > >   and replaced an incorrect ipcperms(3) manpage reference with the
> > >   kernel helper ipcperms().
> > > - Reworded the LANDLOCK_SCOPE_SYSV_MSG_QUEUE UAPI comment and the
> > >   in-code comment explaining the -EACCES mapping.
> > > 
> > > v1: https://lore.kernel.org/all/20260521160640.1716746-1-utilityemal77@gmail.com/
> > > 
> > > Kind Regards,
> > > Justin Suess
> > > 
> > > Justin Suess (6):
> > >   landlock: Add kern_ipc_perm credential blob structs
> > >   landlock: Add LANDLOCK_SCOPE_SYSV_MSG_QUEUE
> > >   landlock: Bump ABI for LANDLOCK_SCOPE_SYSV_MSG_QUEUE
> > >   selftests/landlock: Test LANDLOCK_SCOPE_SYSV_MSG_QUEUE
> > >   samples/landlock: Support LANDLOCK_SCOPE_SYSV_MSG_QUEUE in sandboxer
> > >   landlock: Document LANDLOCK_SCOPE_SYSV_MSG_QUEUE
> > > 
> > >  Documentation/admin-guide/LSM/landlock.rst    |   1 +
> > >  Documentation/userspace-api/landlock.rst      |  30 +-
> > >  include/uapi/linux/landlock.h                 |   4 +
> > >  samples/landlock/sandboxer.c                  |  24 +-
> > >  security/landlock/audit.c                     |   4 +
> > >  security/landlock/audit.h                     |   1 +
> > >  security/landlock/limits.h                    |   2 +-
> > >  security/landlock/setup.c                     |   1 +
> > >  security/landlock/syscalls.c                  |   2 +-
> > >  security/landlock/task.c                      | 137 +++++++++
> > >  security/landlock/task.h                      |  50 ++++
> > >  tools/testing/selftests/landlock/base_test.c  |   2 +-
> > >  tools/testing/selftests/landlock/config       |   1 +
> > >  .../landlock/scoped_sysv_msg_queue_test.c     | 265 ++++++++++++++++++
> > >  .../testing/selftests/landlock/scoped_test.c  |   2 +-
> > >  15 files changed, 517 insertions(+), 9 deletions(-)
> > >  create mode 100644 tools/testing/selftests/landlock/scoped_sysv_msg_queue_test.c
> > > 
> > > 
> > > base-commit: 28ca6f6f271d47253c240e64cc88a72c89456d74
> > > -- 
> > > 2.54.0
> > > 
> > 
> > –Günther
