Received: from smtp-bc09.mail.infomaniak.ch (smtp-bc09.mail.infomaniak.ch [45.157.188.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FA925A653
	for <linux-security-module@vger.kernel.org>; Tue, 11 Mar 2025 14:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741703588; cv=none; b=MJVU23izCNx3DzjVgNgAf7taz9Fm7rCJtqG8riem7pz8whDsa7ABY5C4ry97KKLSXfY9eTSfkgtwM00wM2H9QYz8U2aaHgTdXPMEje6Tq1zUSoikZ6GrjL3RU9H5I8JgTQCkjbdr/cfU9Oo6NpGirDvt4gAY/jNC00iFNF5UtPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741703588; c=relaxed/simple;
	bh=SDDAXoqsqgExN7f0hzwwey7bsU0+LraGSsZgPodTofU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VYWvmPJtz+odeGHi7fjCMI4fiGhMwbsity7nElH4f/lxWata5Jbg92t1hPMEFMphtk06mhG0CzmCOMN6eGGDETo9rqs4Z8+2Tm3cg49BQz9/4G8UQL5/Hf9llxRImLQ8kTb5linhfiuHO7KjsPT+Cc5F9jdFs6Ap1ThkoJEYjqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=Hg0EY7KV; arc=none smtp.client-ip=45.157.188.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="Hg0EY7KV"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZBx7W2svnzPw3;
	Tue, 11 Mar 2025 15:32:55 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741703575;
	bh=2YaIPQV3+DbYwSfcD/whlGeuuxi/uei3xpiA8a5+614=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hg0EY7KVZr1ApFtnd/GAt7n68atO6ULLYkeN+FJ6eIaZNUS2cNYoTHL/RPWaXgNS9
	 Wz7mfId0x0dwjq5N7fVjW8RnncOxImFwxlT3ZtpSzPVISNqd676yS+eMCeSbWpm7mb
	 qohwJrlT3KMgK6Pu26RRGbZCnn/BhDL4Vs3Npdo8=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZBx7V4tKgzhL7;
	Tue, 11 Mar 2025 15:32:54 +0100 (CET)
Date: Tue, 11 Mar 2025 15:32:53 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, sergeh@kernel.org, 
	David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, 
	Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org, 
	Peter Newman <peternewman@google.com>
Subject: Re: [RFC 1/2] landlock: Multithreading support for
 landlock_restrict_self()
Message-ID: <20250311.aefai7vo6huW@digikod.net>
References: <20250221184417.27954-2-gnoack3000@gmail.com>
 <20250221184417.27954-3-gnoack3000@gmail.com>
 <20250227.Aequah6Avieg@digikod.net>
 <20250228.b3794e33d5c0@gnoack.org>
 <20250304.aroh3Aifiiz9@digikod.net>
 <20250310.990b29c809af@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250310.990b29c809af@gnoack.org>
X-Infomaniak-Routing: alpha

On Mon, Mar 10, 2025 at 02:04:23PM +0100, Günther Noack wrote:
> Hello Paul and Serge!
> 
> On Tue, Mar 04, 2025 at 09:25:51PM +0100, Mickaël Salaün wrote:
> > On Fri, Feb 28, 2025 at 06:33:55PM +0100, Günther Noack wrote:
> > > Hello!
> > > 
> > > Thanks for the review!
> > > 
> > > I'm adding David Howells to this thread as well.  David, maybe you can
> > > help us and suggest a appropriate way to update the struct cred across
> > > multiple threads?
> 
> Paul and Serge, since you are volunteering to take ownership of
> credentials, maybe you can advise on what is the best approach here?
> 
> To summarize the approaches that I have been discussing with Mickaël:
> 
> Approach 1: Use the creds API thread-by-thread (implemented here)
> 
>   * Each task calls prepare_creds() and commit_creds() on its own, in
>     line with the way the API is designed to be used (from a single
>     task).
>   * Task work gets scheduled with a pseudo-signal and the task that
>     invoked the syscall is waiting for all of them to return.
>   * Task work can fail at the beginning due to prepare_creds(), in
>     which case all tasks have to abort_creds(). Additional
>     synchronization is needed for that.
> 
>   Drawback: We need to grab the system-global task lock to prevent new
>   thread creation and also grab the per-process signal lock to prevent
>   races with other creds accesses, for the entire time as we wait for
>   each task to do the task work.

In other words, this approach blocks all threads from the same process.

> 
> Approach 2: Attempt to do the prepare_creds() step in the calling task.
> 
>   * Would use an API similar to what keyctl uses for the
>     parent-process update.
>   * This side-steps the credentials update API as it is documented in
>     Documentation, using the cred_alloc_blank() helper and replicating
>     some prepare_creds() logic.
> 
>   Drawback: This would introduce another use of the cred_alloc_blank()
>   API (and the cred_transfer LSM hook), which would otherwise be
>   reasonable to delete if we can remove the keyctl use case.
>   (https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45e6b8@google.com/)

cred_alloc_blank() was designed to avoid dealing with -ENOMEM, which is
a required property for this Landlock TSYNC feature (i.e. atomic and
consistent synchronization).

I think it would make sense to replace most of the
key_change_session_keyring() code with a new cred_transfer() helper that
will memcpy the old cred to the new, increment the appropriate ref
counters, and call security_transfer_creds().  We could then use this
helper in Landlock too.

To properly handle race conditions with a thread changing its own
credentials, we would need a new LSM hook called by commit_creds().
For the Landlock implementation, this hook would check if the process is
being Landlocked+TSYNC and return -ERESTARTNOINTR if it is the case.
The newly created task_work would then be free to update each thread's
credentials while only blocking the calling thread (which is also a
required feature).

Alternatively, instead of a new LSM hook, commit_creds() could check
itself a new group leader's flag set if all the credentials from the
calling process are being updated, and return -ERESTARTNOINTR in this
case.

> 
> Approach 3: Store Landlock domains outside of credentials altogether
> 
>   * We could also store a task's Landlock domain as a pointer in the
>     per-task security blob, and refcount these.  We would need to make
>     sure that they get newly referenced and updated in the same
>     scenarios as they do within struct cred today.
>   * We could then guard accesses to a task's Landlock domain with a
>     more classic locking mechanism.  This would make it possible to
>     update the Landlock domain of all tasks in a process without
>     having to go through pseudo-signals.
> 
>   Drawbacks:
>   * Would have to make sure that the Landlock domain the task's LSM
>     blob behaves exactly the same as before in the struct cred.
>   * Potentially slower to access Landlock domains that are guarded by
>     a mutex.

This would not work because the kernel (including LSM hooks) uses
credentials to check access.

> 
> I'd be interested to hear your opinion on how we should best approach
> this.
> 
> P.S. This is probably already clear to everyone who read this far, but
> the problem that creds can't be updated across tasks has already lead
> to other difficult APIs and also bleeds into user-level interfaces
> such as the setuid() family of syscalls as well as capability
> updating.  Both of these are solved from user space through the signal
> hack documented in nptl(7), which is used in glibc for setuid()-style
> calls and in libpsx for capabilities and Landlock's Go library.  If we
> had a working way to do these cross-thread updates in the kernel, that
> would simplify these userspace implementations.  (There are more links
> in the cover letter at the top of this thread.)
> 
> Thanks,
> –Günther
> 
