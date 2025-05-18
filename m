Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3C5D2FB;
	Sun, 18 May 2025 07:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747554015; cv=none; b=PKxgpCwvH+iCRQZ9muShM7ws81/IfqUFdg4Rvgaz6fSZjgzGUoPGKs9g5ISc9hwiPAs+bQXnFda/igzYB+guozieejkyUdzj8qeLjSNEI+byiRVFZa9XDrJTiCLb18FbYo3NI+jVCkhJVHRaglLQHFG0ET/oz8JU8bAeKRrzDOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747554015; c=relaxed/simple;
	bh=259/vvOiHFW9j83D4pgOWUBhX2qdMM+IkobAc02T0m8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DS5CuVH9wy6ourzAuMd4R98GOWC8pp+2zkCwkUgD75bctvS5K2OQQkIpB/cC8WLdk7v/kQ9RH88nMavIZ76dmilc4eCPFhurmWnKw43/PXqITSOwl9I51BDxe3mPZecY9xntsBw/6pS1vjEuGw917n01S6zNHiw8RTeZUjWO+30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faHnKcMo; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faHnKcMo"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so26927815e9.0;
        Sun, 18 May 2025 00:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747554012; x=1748158812; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AYXAaAw4CbkA8JroVCgYmv4BfUphEKyu10sZc0Jhu4Q=;
        b=faHnKcMox18fkxFo/0WmGfMLzYmSEk4RBjFDxtttluZ5mLwstgN6MNAZDPTNJ/mAyG
         haHY20t0HZ3xzHSFXN6xbd0ZqWdFjKolH3kdvbXMTkpptUyLJ/nxyemD9k5vU4AThZZr
         Xh0zZ593d5CbkjehZeyGAs1GLku4snBhc9sTO7oJN2/xjUMPMAq7Y3Rb3rPcPYAF61F8
         TzVjOSgJqQLr1Yumngn7MnJ7EOywC31jgcLix9pSyMtCbQbUHRiG1+nJlPJOXdifxJHJ
         I4i3vRWeA5ceZpEVeQrUuSI8wPpx0QIPP1uglcC+6kOkFBCoCTlRmz9ttq1dkEWq1Mav
         BF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747554012; x=1748158812;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AYXAaAw4CbkA8JroVCgYmv4BfUphEKyu10sZc0Jhu4Q=;
        b=JUgAqnC9IzK4nYN82pbSuxNQp9QIV30JX5Mo9YKhfl/q9gjZkNe5XIjDlaYnIL46XD
         FrYlG1Vl65S6SGwyvIEMqjddrxEfre/EwSe3lLaHIqHq0WF2g5/zlaMRxVxlS4hgA4Qi
         nPF1GZ2XPg+CvQOGfmgER7RJYjGkEMim7GoJnpaxuJ8wXKEbQTaFbRWwufsyfhllM5nb
         VgHBcdSyT5HjbWujil2xkCSwdrbpuPBpFp04Ry/6/QIqJ8n3/aaZUw6QugSlt2eWy1rd
         f+9keOYGtxg0KJrhsueyLzNlEBQSBiJS3fUegOwz/AsuVj0RzlufSYrKYgFy/vIdtHT3
         xCAw==
X-Forwarded-Encrypted: i=1; AJvYcCVSAqTincaC/x7OqOcmgM/lO2ac92taVe8kXM8jKPFrQUwV4NCpIL+9SB5mdjYJonPSokctGmRSYzY304K52t1y/aShkP/r@vger.kernel.org, AJvYcCWiJ/mD6LsNR7VPCdryi2pI5FDD/zTlrN2XhvINXZPdm6X5YP/KxpvmkXvm/0UE3MNZz3LsPHvSM7sHwVo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxddRA/sQ6xXccmbPTitoisCbQIgh3F1o32/9ej2wKPsK9aPZGi
	gFH5KMUehX2eyQML9qt+pBwpBo9RqxPVHbX736ziigFdQ86JfUOwm1y1
X-Gm-Gg: ASbGncsXrgR66gluWcg3aNGhDNnVXWU3jAW1FcLq+qWJQ6u1yDNq2sss5kYt5Xdd7DU
	ZWMUTTwkzqcJliUt0u3EhCjLRck17pZ8CMp/qA5/wXlljCwcPfQKGooOQYDLccD/+hPd/W8zFgl
	jMGnpMB0EgFFuQ2z6RCCWoHU/Tlm03Byet0MEsRSj5yEllWtItaaJz/z8+Wu9Q3CfMC1RkN6yFC
	gbJRKOJHcwtaO4fmVPoxG+/M86VJGym/ti8QKUOYBbHS4f1Cs9/nmGePO+xHcSoOj7qrhuwl2y9
	m7e+TuLHYGqD7v9vepoz964WKP8PC8bqTvvmlZiPKHh/UjMBRVzODDaAMGnIbHAHnd+OVdPuWBZ
	wYA==
X-Google-Smtp-Source: AGHT+IEhqjylGQD0TUVbGsvBE3gcdJSP3/LO/DXHIXpUNSC8Z/W/wx6jlEfUNOLgfMtT8cZkkuuoLw==
X-Received: by 2002:a05:600c:6748:b0:43c:f050:fee8 with SMTP id 5b1f17b1804b1-442fd6724b0mr72287375e9.20.1747554011259;
        Sun, 18 May 2025 00:40:11 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-442f39ef87asm164913475e9.36.2025.05.18.00.40.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 00:40:10 -0700 (PDT)
Date: Sun, 18 May 2025 09:40:05 +0200
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, sergeh@kernel.org,
	David Howells <dhowells@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org,
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>,
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
	Peter Newman <peternewman@google.com>
Subject: Re: [RFC 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <20250518.be040c48937c@gnoack.org>
References: <20250221184417.27954-2-gnoack3000@gmail.com>
 <20250221184417.27954-3-gnoack3000@gmail.com>
 <20250227.Aequah6Avieg@digikod.net>
 <20250228.b3794e33d5c0@gnoack.org>
 <20250304.aroh3Aifiiz9@digikod.net>
 <20250310.990b29c809af@gnoack.org>
 <20250311.aefai7vo6huW@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250311.aefai7vo6huW@digikod.net>

Hello!

On Tue, Mar 11, 2025 at 03:32:53PM +0100, Mickaël Salaün wrote:
> On Mon, Mar 10, 2025 at 02:04:23PM +0100, Günther Noack wrote:
> > On Tue, Mar 04, 2025 at 09:25:51PM +0100, Mickaël Salaün wrote:
> > > On Fri, Feb 28, 2025 at 06:33:55PM +0100, Günther Noack wrote:
> > > > Hello!
> > > > 
> > > > Thanks for the review!
> > > > 
> > > > I'm adding David Howells to this thread as well.  David, maybe you can
> > > > help us and suggest a appropriate way to update the struct cred across
> > > > multiple threads?
> > 
> > Paul and Serge, since you are volunteering to take ownership of
> > credentials, maybe you can advise on what is the best approach here?
> > 
> > To summarize the approaches that I have been discussing with Mickaël:
> > 
> > Approach 1: Use the creds API thread-by-thread (implemented here)
> > 
> >   * Each task calls prepare_creds() and commit_creds() on its own, in
> >     line with the way the API is designed to be used (from a single
> >     task).
> >   * Task work gets scheduled with a pseudo-signal and the task that
> >     invoked the syscall is waiting for all of them to return.
> >   * Task work can fail at the beginning due to prepare_creds(), in
> >     which case all tasks have to abort_creds(). Additional
> >     synchronization is needed for that.
> > 
> >   Drawback: We need to grab the system-global task lock to prevent new
> >   thread creation and also grab the per-process signal lock to prevent
> >   races with other creds accesses, for the entire time as we wait for
> >   each task to do the task work.
> 
> In other words, this approach blocks all threads from the same process.

It does, but that is still an improvement over the current
libpsx-based implementation in userspace.  That existing
implementation does not block, but it is running the risk that
prepare_creds() might fail on one of the threads (e.g. allocation
failure), which would leave the processes' threads in an inconsistent
state.

Another upside that the in-kernel implementation has is that the
implementation of that is hidden behind an API, so if we can
eventually find a better approach, we can migrate to it.  It gives us
flexibility.

I guess a possible variant (approach 1B) would be to do the equivalent
to what userspace does today, and not make all threads wait for the
possible error of prepare_creds() on the other threads.


> > Approach 2: Attempt to do the prepare_creds() step in the calling task.
> > 
> >   * Would use an API similar to what keyctl uses for the
> >     parent-process update.
> >   * This side-steps the credentials update API as it is documented in
> >     Documentation, using the cred_alloc_blank() helper and replicating
> >     some prepare_creds() logic.
> > 
> >   Drawback: This would introduce another use of the cred_alloc_blank()
> >   API (and the cred_transfer LSM hook), which would otherwise be
> >   reasonable to delete if we can remove the keyctl use case.
> >   (https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com/)
> 
> cred_alloc_blank() was designed to avoid dealing with -ENOMEM, which is
> a required property for this Landlock TSYNC feature (i.e. atomic and
> consistent synchronization).

Remark on the side, I suspect that the error handling in nptl(7)
probably also does not guarantee that, also for setuid(2) and friends.


> I think it would make sense to replace most of the
> key_change_session_keyring() code with a new cred_transfer() helper that
> will memcpy the old cred to the new, increment the appropriate ref
> counters, and call security_transfer_creds().  We could then use this
> helper in Landlock too.
> 
> To properly handle race conditions with a thread changing its own
> credentials, we would need a new LSM hook called by commit_creds().
> For the Landlock implementation, this hook would check if the process is
> being Landlocked+TSYNC and return -ERESTARTNOINTR if it is the case.
> The newly created task_work would then be free to update each thread's
> credentials while only blocking the calling thread (which is also a
> required feature).
> 
> Alternatively, instead of a new LSM hook, commit_creds() could check
> itself a new group leader's flag set if all the credentials from the
> calling process are being updated, and return -ERESTARTNOINTR in this
> case.

commit_creds() is explicitly documented to never return errors.
It returns a 0 integer so that it lends itself for tail calls,
and some of those usages might also rely on it always working.
There are ~15 existing calls where the return value is discarded.

If commit_creds() returns -ERESTARTNOINTR, I assume that your idea is
that the task_work would retry the prepare-and-commit when
encountering that?

We would have to store the fact that the process is being
Landlock+TSYNC'd in a central place (e.g. group leader flag set).
When that is done, don't we need more synchronization mechanisms to
access that (which RCU was meant to avoid)?

I am having a hard time wrapping my head around these synchronization
schemes, I feel this is getting too complicated for what it is trying
to do and might become difficult to maintain if we implemented it.

> > Approach 3: Store Landlock domains outside of credentials altogether
> > 
> >   * We could also store a task's Landlock domain as a pointer in the
> >     per-task security blob, and refcount these.  We would need to make
> >     sure that they get newly referenced and updated in the same
> >     scenarios as they do within struct cred today.
> >   * We could then guard accesses to a task's Landlock domain with a
> >     more classic locking mechanism.  This would make it possible to
> >     update the Landlock domain of all tasks in a process without
> >     having to go through pseudo-signals.
> > 
> >   Drawbacks:
> >   * Would have to make sure that the Landlock domain the task's LSM
> >     blob behaves exactly the same as before in the struct cred.
> >   * Potentially slower to access Landlock domains that are guarded by
> >     a mutex.
> 
> This would not work because the kernel (including LSM hooks) uses
> credentials to check access.

It's unclear to me what you mean by that.

Do you mean that it is hard to replicate for Landlock the cases where
the pointer would have to be copied, because the LSM hooks are not
suited for it?


Here is another possible approach which a colleague suggested in a
discussion:

Approach 4: Freeze-and re-enforce the Landlock ruleset

Another option would be to have a different user space API for this,
with a flag LANDLOCK_RESTRICT_SELF_ENTER (name TBD) to enter a given
domain.

On first usage of landlock_restrict_self() with the flag, the enforced
ruleset would be frozen and linked to the Landlock domain which was
enforced at the end.

Subsequent attempts to add rules to the ruleset would fail when the
ruleset is frozen.  The ruleset FD is now representing the created
domain including all its nesting.

Subsequent usages of landlock_restrict_self() on a frozen ruleset would:

(a) check that the ruleset's domain is a narrower (nested) domain of
    the current thread's domain (so that we retain the property of
    only locking in a task further than it was before).

(b) set the task's domain to the domain attached to the ruleset

This way, we would keep a per-thread userspace API, avoiding the
issues discussed before.  It would become possible to use ruleset file
descriptors as handles for entering Landlock domains and pass them
around between processes.

The only drawback I can see is that it has the same issues as libpsx
and nptl(7) in that the syscall can fail on individual threads due to
ENOMEM.

If we can not find a solution for "TSYNC", it seems that this might be
a viable alternative.  For multithreaded applications enforcing a
Landlock policy, it would become an application of libpsx with the
LANDLOCK_RESTRICT_SELF_ENTER flag.

Let me know what you think.

–Günther
