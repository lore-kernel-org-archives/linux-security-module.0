Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219D6495E5
	for <linux-security-module@vger.kernel.org>; Sun, 22 Feb 2026 18:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771783497; cv=none; b=PFD43x8jcPMz0DgFdzpzBtUI9XU7GqL469K1Ys2z7DIQ+BOHkfp2t4mFqD+OHDtAHdvL8fpqW5QkseAaEkwqmnrq49KDEM2VmKW7IpUGKRNitpBrqzdaWkuQ6fKS2o1aatjm6LYfJWIxL8hh7RyvtAopjWGMXERnGnqVxMF3Lxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771783497; c=relaxed/simple;
	bh=9SgtW8MY3REk5lVJSw4dh49CGsQR8cSpdYmNSYA3wDk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=siZbVKe8yDzyhCwBGKA7qbi0jtxoA8WyiOsAE6+t1N42eNFZxWlH/9Kl0O7tqY9Vdcb0BactmEcySTPVNLQF4/cioNojTUjy5tvQ2FrwmDmPh3JQzuo0naVp6uEV+GA0T0T8Lc/qJRLcBvSWxfpFu5GB2/QrZKu8fkqWy0REv50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org; spf=pass smtp.mailfrom=maowtm.org; dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b=G2L6sb+0; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KcYndY6K; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=maowtm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maowtm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maowtm.org header.i=@maowtm.org header.b="G2L6sb+0";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KcYndY6K"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4B3C67A0184;
	Sun, 22 Feb 2026 13:04:54 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Sun, 22 Feb 2026 13:04:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maowtm.org; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1771783494;
	 x=1771869894; bh=bddXfVy2xfaK2qoluRPXbINVo+ttCukChE7r2ZTNjGE=; b=
	G2L6sb+0dKBpDFSndujOJRfIe3wicsTqA18uuRRp2nDA1GkN7DNh0MaEZ+TUiI1C
	qJQQ8WkKMW4XJovzwsGzJMlLqTb4QqFy3+gvmSP8H+49qpORLRaLtFYqvOkjF6Cq
	/XChcHDtJ2PrLJva7/shfsV20/ezS9dQzlrT7C+KYXsW3EAoDYJalYDUvd9ZLjZA
	ohWBysTvjFXzjFBkP6JSvsqxCGmzhnIRODQl1+pJ5Wp07z+zowdNz9iy49x6BAYI
	1XaKMBD2/URkYk7h+ynh0kAg+jJAAqL28DEuOB4O/yf//57mwOXzfv3IdEScPy2w
	rl87kylHZsBwg1nQJgQXHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1771783494; x=
	1771869894; bh=bddXfVy2xfaK2qoluRPXbINVo+ttCukChE7r2ZTNjGE=; b=K
	cYndY6K1wE1x/w9j6mFqb9yHEhuB5vKTnrWPiygBo8GA5Vbf5ilFNMyj04VFQflT
	N+xytlHg/bJD9VV01cR+kAoQ+nJRcMnvpQU3C+p5CYCul8VTEkxnSBauyxf1fzf8
	Z/VwFxkDFIkRTTTgNJEShZ/e8rza5XYq5b2DSMNZI1igTHimruKDaJHDsD3Neby8
	OzT5fMF64zAhz9rUgz4IjYOnKtGPVf6NzO7oTLv05upCU/Cjb95sWBbi1DBIHNkG
	6lu5lS9TYfcNFvBN114i4X4OYNgyfzWszuNVSlJPFzNNVM+713OVmv5+0UJmU1wt
	RkGLoUwrexS4XNaMTvsNw==
X-ME-Sender: <xms:RUWbaduXwhzikXksoPrwluaqQ9GCYCyKZOjzDF_msOoDbLVosaUsoQ>
    <xme:RUWbaW4gzwz-bc4NgNPuMkfPTWvuLpQqXBGjUDnwioZl5JD-a29TK4e-9FtPMe548
    t0GqPZsw3S0VslBb5owq2cEtJqtgeTNUFsyGyYCRJL7mFRWlgBJFMo>
X-ME-Received: <xmr:RUWbaRefwp0NSPKgSLdi6ijDiyRZKlT-TvOlMAnC90afwESVCRbzfDhyVWYRU75YacbSFFbjtuuAg0y1PQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvfeegleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhnghhm
    rghoucghrghnghcuoehmsehmrghofihtmhdrohhrgheqnecuggftrfgrthhtvghrnhepud
    evjeehteeltdegvdfgkefhuefhgeehleehhfeuhfeileefgefgieelgeehvdevnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghdpmhgrnhejrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhesmhgrohifthhmrdhorhhgpdhn
    sggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehuthhilh
    hithihvghmrghljeejsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhnohgrtghksehg
    ohhoghhlvgdrtghomhdprhgtphhtthhopehmihgtseguihhgihhkohgurdhnvghtpdhrtg
    hpthhtoheprghmihhrjeefihhlsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghk
    sehsuhhsvgdrtgiipdhrtghpthhtohepjhgrnhhnhhesghhoohhglhgvrdgtohhmpdhrtg
    hpthhtoheplhhinhhugidqshgvtghurhhithihqdhmohguuhhlvgesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehpvghnghhuihhnqdhkvghrnhgvlhesihdqlhhovh
    gvrdhsrghkuhhrrgdrnhgvrdhjphdprhgtphhtthhopehsohhngheskhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:RUWbabxNzBlhz6jO8fmnEDC6ggooIrbUrwXBU8z3ucGlY0vyBst0Uw>
    <xmx:RUWbae85yq7hX87lIe2KQL0KkkvVTi4yp4ZhMpkTkvDuqbnLvbSgPw>
    <xmx:RUWbaRxm8PZbH1udmKRQFvv1tM9rb2plHYPGtZogs4nv_bRJxfbYEw>
    <xmx:RUWbaep5BuYZyAzwQEk0qDrfwmAesYrPkkZU8IOAcoVm2tK790aGHA>
    <xmx:RkWbab8J05vjmAKKpJSFMZuoV5lvMlvhPEawgsvnBDnDJpKWmZUReya8>
Feedback-ID: i580e4893:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Feb 2026 13:04:52 -0500 (EST)
Message-ID: <838ee276-9823-4921-a454-4da9e9095b09@maowtm.org>
Date: Sun, 22 Feb 2026 18:04:51 +0000
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] Landlock: mutable domains (and supervisor notification uAPI
 options)
To: Justin Suess <utilityemal77@gmail.com>, =?UTF-8?Q?G=C3=BCnther_Noack?=
 <gnoack@google.com>, =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: amir73il@gmail.com, jack@suse.cz, jannh@google.com,
 linux-security-module@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp,
 song@kernel.org
References: <20260215212353.3549464-1-utilityemal77@gmail.com>
 <20260216212753.4159224-1-utilityemal77@gmail.com>
Content-Language: en-US
From: Tingmao Wang <m@maowtm.org>
In-Reply-To: <20260216212753.4159224-1-utilityemal77@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/16/26 21:27, Justin Suess wrote:
> On Sun, Feb 15, 2026 at 02:54:08AM +0000, Tingmao Wang wrote:
>> [...]
>> The next stage is to introduce "mutable domains".  The motivation for this
>> is two fold:
>>
>> 1. This allows the supervisor to allow access to (large) file hierarchies
>>    without needing to be woken up again for each access.
>> 2. Because we cannot block within security_path_mknod and other
>>    directory-modification related hooks [6], the proposal was to return
>>    immediately from those hooks after queuing the supervisor notification,
>>    then wait in a separate task_work.  This however means that we cannot
>>    directly "allow" access (and even if we can, it may introduce TOCTOU
>>    problems).  In order to allow access to requested files, the supervisor
>>    has to add additional rules to the (now mutable) domain which will
>>    allow the required access.
>
> Is blocking during connect(2) allowed either if the socket is non-blocking?
>
> This may be another example case that needs to be handled differently than calls
> we can block in safely.

I think the non-blocking socket case is worth considering but is
orthogonal to the above discussion - even when the socket is marked
non-blocking, we can still "safely" block in the connect hook (as long as
there isn't another reason, like locks, that prevents us from doing so),
because it only affects the calling process.  Although if we're doing the
-ERESTARTNOINTR approach for fs, we might as well do the same here and
return -ERESTARTNOINTR from the connect hook (but that would still "block"
the syscall).  Also, even for the file create/delete case, while we don't
block in the hook, from the user-space perspective, we're still blocking
(i.e. in the task_work), since the syscall doesn't immediately return (but
instead waits for a response from the supervisor).

However we could consider implementing some special case for
non-blocking-capable operations (like socket connect) such that we return
from the syscall without waiting for a supervisor response (and we return
a value that a "try again later" response would normally return), but then
we have to figure out how to cause a "you can retry now" notification that
would normally be sent for the non-blocking operation.

Related, there is the question of how we want to handle "non-blocking
open()s".  Technically there isn't a non-blocking open() for regular files
from the user-space perspective, but ideally, for example, a wait on a
Landlock supervisor would not prevent an io_uring_enter() processing
multiple openat()s from continuing on to other requests.  But I suspect
this would be very hard to implement.

> [...]
>> (Disallowing) self-supervision
>> ------------------------------
>>
>> We should figure out a way to ensure that a process cannot call
>> landlock_restrict_self() with a ruleset that has a supervisor for which it
>> has access to (i.e. via a supervisor ruleset fd).  This prevents
>> accidental misuse, and also prevents deadlocks as discussed in [11].  I'm
>> not sure if this will be easy to implement, however.
>
> This seems like a graph acyclicity problem.
>
> Here are a couple cases to consider:
>
> 1. LANDLOCK_RESTRICT_SELF_TSYNC misuse:
>
> In the case where a user wants to use this supervisor to supervise other
> threads within the same process, a user could naively call
> LANDLOCK_RESTRICT_SELF_TSYNC (merged into 7.0) when enforcing the
> supervisee_fd. This would enforce the same policy on the thread running
> the supervisor and the supervisee.

Yes, but if the intention is to supervise threads within the same process
(which IMO is already a slightly questionable use case, maybe it can be
used as a tracing method, but certainly not for security), calling
restrict with LANDLOCK_RESTRICT_SELF_TSYNC is itself a mistake.  There is
a case for us to try to detect and prevent this, but I'm thinking it would
more be to prevent "useless sandboxing" rather than to prevent deadlocks
(after all, it might not deadlock if someone else also has a fd for that
supervisor).

>
> 2. Transfer of the supervisee_fd (SCM_RIGHTS)
>
> It's possible to transfer file descriptors over unix domain sockets. If
> we had a supervisor daemon that used this form of IPC to send precooked
> supervisee_fds to other threads, and one of those ended up in a parent
> process of the supervisor, we could inadvertently end up with problems.

Note that being a parent process of the supervisor itself is not a
problem, what matters here is the Landlock domain relationships.  It will
only be a problem if the fd is then used to make the supervisor be
supervised by itself (but if it's an unrelated parent process that is
supervised, it should still be fine).

>
> 3. Blocking in other LSMs (pointed out in your source [11])
>
> The hardest case to deal with, other LSMs like TOMOYO can also block and
> cause dependency cycles.
>
> ---
>
> This gets tricky, and I don't know  if just checking parent / child
> relationships would work. Because the supervisor and supervisee rulesets
> are just file descriptors, and there are potentially unlimited number of
> ways these FDs could be transfered or instantiated.
>
> I think the best way to deal with this is constraining the problem space:
>
> An idea (binding supervisors/supervisees to domains on first use)
>
> Whenever landlock_restrict_self(supervisee_fd,...) is called, check the
> current domain credentials and verify that the domain is a *proper
> subset* of the supervisors domain. Then permanently close the
> supervisee_fd and never allow reenforcement. Similarly, once a
> supervisor_fd is created, never allow commiting from a context with
> "current landlock domain != original landlock domain at creation"
>
> This prevents post-enforcement usage of the supervisee_fd by a parent
> domain, and post-commit usage of a supervisee_fd by any subdomain.

It's not the supervisee fd that matters right?  For example, a supervisor
can still call landlock_restrict_self() with the supervisee_fd it acquired
from the ioctl() (after all, this call itself is fine, it's only the fact
that there is no other process holding the supervisor fd that means this
gets us into a deadlock situation).  I would think that if we
automatically close any fds, it would be the supervisor fd that we would
close.  In this particular case this then means that there are no longer
any process holding the supervisor fd, which is a case we can detect, and
just deny any access request by the supervisee from that point forward
(preventing deadlock).

>
> I'm not sure if it's possible to check whether one domain is a
> proper subset of another (ie supervisor domain includes but *doesn't equal*
> supervisee domain), but I think that's one way do do it.
>
> This idea would help, but doesn't address case 3 above.
>
>>
>> [11]: https://lore.kernel.org/all/cc3e131f-f9a3-417b-9267-907b45083dc3@maowtm.org/
>>
>>
>> Supervisor notification
>> -----------------------
>>
>> The above RFC only covers mutable domains.  The natural next stage of this
>> work is to send notification to the supervisor on access denials, so that
>> it can decide whether to allow the access or not.  For that, there are
>> also lots of questions at this stage:
>>
>>
>> - Should we in fact implement that first, before mutable domains?  This
>>   means that the supervisor would only be able to find out about denials,
>>   but not allow them without a sandbox restart.  We still eventually want
>>   the mutable domains, since that makes this a lot more useful, but I can
>>   see some use cases for just the notification part (e.g. island denial
>>   log), and I can't see a likely use case for just mutable domains, aside
>>   from live reload of landlock-config (maybe that _is_ useful on its own,
>>   considering that you can also find out about denials from the kernel
>>   audit log, and add missing rules based on that).
>>
>>
>> - Earlier when implementing the Landlock supervise v1 RFC, I basically
>>   came up with an ad-hoc uAPI for the notification [12], and the PoC code
>>   linked to above also uses this uAPI.  There are of course many problems
>>   with this as it stands, e.g. it only having one destname, which means
>>   that for rename, the fd1 needs to be the child being moved, which does
>>   not align with the vfs semantic and how Landlock treat it (i.e. the
>>   thing being updated here is the parent directory, not the child itself).
>>   Same for delete, which currently sends the child as fd1.
>>
>>   But also, in discussion with Mickaël last year, he mentioned that we
>>   could reuse the fsnotify infrastructure, and perhaps additionally, use
>>   fanotify to deliver these notifications.  I do think there is some
>>   potential here, as fanotify already implements an event header, a
>>   mechanism for receiving and replying to events, etc.  We could possibly
>>   extend it to send Landlock specific notifications via a new kind of mark
>>   (FAN_MARK_LANDLOCK_DOMAIN ??) and add one or more new corresponding
>>   event types.  Mickaël mentioned mount notifications [13] as an example
>>   of using fanotify to send notifications other than file/dir
>>   modifications.
>>
>>   I'm not sure if directly extending the fanotify uAPI is a good idea tho,
>>   considering that Landlock is not a feature specific to the filesystem -
>>   we will also have denial events for net_port rules, and perhaps more in
>>   the future.  However, Mickaël mentioned that there might be some
>>   internal infrastructure which we can re-use (even if we have our own
>>   notification uAPI).
> I think that a new FAN_MARK would be required to use fanotify uAPI.
>
> There are a couple questions I have with this: (if we extend fanotify)
>
> 1. What FAN_CLASS_* would notifications use?
>
> FAN_CLASS_* specifies the type of notification, when the notification is
> triggered.
>
> See [1] for the current classes.
>
> If we want interactive, pre-access blocking, that would correspond to
> FAN_CLASS_PRE_CONTENT or FAN_CLASS_CONTENT. Both of which currently
> require CAP_SYS_ADMIN regardless of FAN_MARK. Which requiring that
> would require that supervisors have CAP_SYS_ADMIN, if the current
> CAP_SYS_ADMIN requirements remain in place.
>
> (If we don't have interactive blocking denials, we could just use
> FAN_CLASS_NOTIF)

I'm not sure, using fanotify is just a vague idea at this point and I
don't have any concrete design to offer, and this is indeed a good point -
we definitely don't want to require CAP_SYS_ADMIN (since being
unprivileged is one advantage of Landlock)

>
> 2. How would fanotify events be encoded?
>
> Events in fanotify use this structure for event data (one or more of the
> following must be recieved in a notification) [2]
>
>            struct fanotify_event_metadata {
>                __u32 event_len;
>                __u8 vers;
>                __u8 reserved;
>                __u16 metadata_len;
>                __aligned_u64 mask;
>                __s32 fd;
>                __s32 pid;
>            };
>
> There are access classes landlock restricts that might not have an fd at
> all, like abstract unix sockets, tcp ports, signals etc.

This was also one of my concerns, I guess we might still need a cookie to
identify such events.  This is one of the reasons why I think extending
seccomp-unotify makes slightly more sense (if we have to choose one of
these two, but of course we can still create a standalone uAPI).

>
> Good news is fanotify supports multiple types of additional information
> records, and we could potentially extend fanotify to support new ones as
> you alluded to.
>
> For examples of this, see struct fanotify_event_info_mnt,
> fanotify_event_info_pidfd.
>
> These records get attached to the event so they could be used to pass
> landlock access data.
>
> 3. If we support interactive permission decisions (even for a
> subset of landlock access rights only), do we use the response code?
> (question might be moot if we don't do blocking/responses at all)

Regardless of uAPI choice, I would really like to support blocking (even
though it makes this whole thing much more difficult).

>
> From [2]:
>
>        For permission events, the application must write(2) a structure
>        of the following form to the fanotify file descriptor:
>
>            struct fanotify_response {
>                __s32 fd;
>                __u32 response;
>            };
>
>
> response is a FAN_ALLOW or FAN_DENY. This is used by fanotify as a
> one-time access decision. Would this be used to do one-off exceptions to
> policy, or would we require policy decisions to go through the
> supervisor_fd and ignore the response code?

I don't think we would be able to do one-off allow decisions (but we
should still be able to do deny) regardless of the uAPI we use, due to the
problem with inode locks.

>
> 4. How would we reconcile the disparity between fanotify access rights
> and landlock access rights?
>
> There's no clean 1:1 mapping between fanotify access rights and landlock
> access rights as Mickaël pointed out. [2] [3]
>
> Many fs rights (creation, deletion, rename, linking) are not handled or
> implemented, (not even considering network/unix/signal scoping), so we'd
> be adding all these landlock specific rights.
>
> We could make a "catch-all" FAN_LANDLOCK_ACCESS or similar and ignore
> all the existing rights, and put the actual access data in the event
> record. It's awkward either way.
> ---
>
> In conclusion, I think extending fanotify is more viable than seccomp,
> from a purely technical standpoint. because it seems extensible,
> and because it runs post-lsm hooks.
>
> That being said, it's awkward, requires large extensions to the API, and
> definition of permissions that are specific to landlock.
>
> Whether or not landlock makes sense in fanotify from a semantic point of
> view is an entirely different question. There's no precedent for
> non-filesystem access controls in fanotify, so it's a little... out-of-place
> for an LSM to expose features on a filesystem access notification api?
>
> Curious on what people think.
>
> [1]: https://man7.org/linux/man-pages/man2/fanotify_init.2.html
> [2]: https://man7.org/linux/man-pages/man7/fanotify.7.html
> [3]: https://lore.kernel.org/all/20250304.Choo7foe2eoj@digikod.net/
>>
>>
>> - The other uAPI alternative which I have been thinking of is to extend
>>   seccomp-unotify.  For example, a Landlock denial could result in the
>>   syscall being trapped and a `struct seccomp_notif` being sent to the
>>   seccomp supervisor (via the existing mechanism), with additional
>>   information (mostly, the file(s) / net ports being accessed and access
>>   rights requested) attached to the notification _somehow_.  Then the
>>   supervisor can use the same kind of responses one would use for
>>   seccomp-unotify to cause the syscall to either be retried (possibly via
>>   `SECCOMP_USER_NOTIF_FLAG_CONTINUE`) or return with an error code of its
>>   choice (or alternatively, carry out the operation on behalf of the
>>   child, and pretend that the syscall succeed, which might be useful to
>>   implement an "allow file creation but only this file" / "allow `mktemp
>>   -d` but not arbitrary create on anything under /tmp").
>>
>>   Looking at `struct seccomp_notif` and `struct seccomp_data` however, I'm
>>   not sure how feasible / doable this extension would be.  Also,
>>   seccomp-unotify is supposed to trigger before a syscall is actually
>>   executed, whereas if we use it this way, we will want it to trigger
>>   after we're already midway through the syscall (in the LSM hook).  This
>>   might make it hard to implement (and also twists a bit the uAPI
>>   semantics of seccomp-unotify).
>>
>
> (Some of the stuff discussed with seccomp below is derived from a side
> conversation with Tingmao over this proposal)
>
> There are some problems with extending seccomp unotify. Passing the
> full context needed through this api to the supervisor is problematic.
> seccomp unotify notifications look like this [4]:
>
>            struct seccomp_notif {
>                __u64  id;              /* Cookie */
>                __u32  pid;             /* TID of target thread */
>                __u32  flags;           /* Currently unused (0) */
>                struct seccomp_data data;   /* See seccomp(2) */
>            };
>
> And struct seccomp_data [5]:
>
>            struct seccomp_data {
>                int   nr;                   /* System call number */
>                __u32 arch;                 /* AUDIT_ARCH_* value
>                                               (see <linux/audit.h>) */
>                __u64 instruction_pointer;  /* CPU instruction pointer */
>                __u64 args[6];              /* Up to 6 system call arguments */
>            };
>
> Even if we pass the syscall data, for the userspace to actually decode
> the arguments to figure out what the access is doing we have two
> critical problems (1,2) and one annoyance (3):
>
> 1. The syscall itself doesn't necessarily contain the full context of the access.
>
> 2. We cannot decode the pointer-based arguments from userspace for a syscall
> in seccomp without TOCTOU. It also requires reaching into userspace
> memory. [6]
>
> 3. Decoding the syscall number is an arch-specific operation that we now have
> to expect userspace to deal with.

We would probably need to attach additional (potentially variable length,
like file names for mknod / link / rename requests) Landlock-specific
information.  The supervisor should not have to do any syscall decoding
(otherwise this partially defeats the point of Landlock supervise - they
can just use seccomp-unotify instead, and handling all "monitored"
syscalls on behalf of the supervisee to prevent TOCTOU).

Also, if we do not allow one-off allows (but require the supervisor to
modify the ruleset), this cannot lead to TOCTOU because if the supervised
process tries to change the argument, it will cause another Landlock
denial and notification.

Thanks for the review!
Tingmao
