Received: from mail-ed1-f73.google.com (mail-ed1-f73.google.com [209.85.208.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F1219ABC2
	for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 16:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748622373; cv=none; b=mf8yW2fQxvlLMdagGvWrEW2TWSukoDkpSBUBpeImGuw8LOE06wmUVakXj9f/uqPdwNSRAJVYX+5A30HSE53SZ2Wc/muPRNPVzwMh6db3q5PpVG48NBTQbyxJMSzPyf1MN3jJ2+uLaCj3OqIz/13cJCUfPrLpWfP988VBL4kpVuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748622373; c=relaxed/simple;
	bh=1fng35ixqqBrckudTBy0Pyb56ilge4zWiZ7ZGbgtJDA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PxT2i7NkCPwCcVPOCnExefryIjLYiCCSKWw76lK78uFNao/DVhbKcm7JEasBMjIu8d9NOkbgayyJTv4/Dk+1ITw04lzdjOs9NUFW3s2QhcWuyVZLG/syUVswVvxfXmTi0TwfuNbFlLNOi97IeC8eRfjM66qoCmnFP4mgGpnOEn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=csTG5BqK; arc=none smtp.client-ip=209.85.208.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="csTG5BqK"
Received: by mail-ed1-f73.google.com with SMTP id 4fb4d7f45d1cf-604e837c1deso1920364a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 30 May 2025 09:26:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748622370; x=1749227170; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yKpPdX/pBg9NsqtCdWDxQDQHdGt0GO0GXMX5bmb0CeY=;
        b=csTG5BqKRjAl1pzPFE+JBX+POz0gIrhCtOOIaCmmykqOFd0l9jwkzNgtLL6JOkR6fP
         uDHa7EF5pbJ42PsI/m7S8Jh7zb79BbGI+Bo3xaXWr2O3Iz796Q30tFpy8gCBpKhoPVSY
         yXDuNzd1PgSE3hO5WNJHoiWNQLZuPIJVHOH+890y3wKReWKLtBz8mnMtdlZd7yQccIxN
         4BABA3kI11YDFB3vz0S4LKwNkNyK5T5o0ekhzwIYNpkar/zbjuxwYkKKiW8aXuqhEFHD
         4gvA3k7LaXdPbwLHRHl5YPaC9NnHQK8bxFEScmXZV7C+0VfH+PU7ZxHAqC5Lo+VKrIkY
         rQFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748622370; x=1749227170;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yKpPdX/pBg9NsqtCdWDxQDQHdGt0GO0GXMX5bmb0CeY=;
        b=UNn9zJu7odHWYRiYXw7XSOwiKaG/yvaCvfYMXi1LtSg33bZa9oHV+8HAZso4FkYVH1
         uPADuruBrQMkebZuf+GBt/fEbjWKeyHb132I7WnyJHqCTv6Nx2ZKXFeD7ln9IBoL7LM5
         0qNO23oaOlepUPDBtdnQ6TdiogFEMjnmVetfMvjhNE7EPkhGJPt4DfyXP9R3bNCwanYv
         bjsofdZDtSymJEffT7RAqvmRgA5xpI9wYjOAmeeiMVT/Bb0l/WGtUovUHSn3xcYFSZnu
         OY/gE9uGjFzHvNJljQYPnF+v3FkNqvVV8Y8daKmri5PLFIroiWHDuUuuOjSGerYyFZ4z
         OEvA==
X-Forwarded-Encrypted: i=1; AJvYcCWRF3Vs2hWREqCG0WqJw0hRIMYdFeRldBcF4s4/6WUOFxUvXYr/jNGp1H1QP9UN3N8LOzfbRrJhiMTC3nsNoWlME6wBfb4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzowrazmsYPiR5Ocg9lN+wQjsDGVCel1o7pJJeqe6QchuoCCssB
	a35lJyg5SVMeGhUUUn4O2SdLHP2wDDw4pD0rkzyCBIvCkGGW75i8gEVkIFR7zerjlrw1ZgSOaKF
	fk7RujQ==
X-Google-Smtp-Source: AGHT+IEfnkM9EKGtG//Yqz/IdFCNfi7nAt9WRzaaVNSLbe+iFYneywKAv5HztF7mOdYQa3OchFjO8aBfOtw=
X-Received: from edyb20.prod.google.com ([2002:aa7:df94:0:b0:601:b195:ed99])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6402:274a:b0:604:e99e:b78f
 with SMTP id 4fb4d7f45d1cf-6056df488b8mr3360734a12.16.1748622369847; Fri, 30
 May 2025 09:26:09 -0700 (PDT)
Date: Fri, 30 May 2025 18:26:07 +0200
In-Reply-To: <20250530.ozeuZufee5yu@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250221184417.27954-3-gnoack3000@gmail.com> <20250227.Aequah6Avieg@digikod.net>
 <20250228.b3794e33d5c0@gnoack.org> <20250304.aroh3Aifiiz9@digikod.net>
 <20250310.990b29c809af@gnoack.org> <20250311.aefai7vo6huW@digikod.net>
 <20250518.be040c48937c@gnoack.org> <20250518.xeevoom3kieY@digikod.net>
 <aDmvpOMlaAZOXrji@google.com> <20250530.ozeuZufee5yu@digikod.net>
Message-ID: <aDncH8D9FoyAIsTv@google.com>
Subject: Re: [RFC 1/2] landlock: Multithreading support for landlock_restrict_self()
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>, Casey Schaufler <casey@schaufler-ca.com>
Cc: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack3000@gmail.com>, Paul Moore <paul@paul-moore.com>, sergeh@kernel.org, 
	David Howells <dhowells@redhat.com>, Kees Cook <keescook@chromium.org>, 
	linux-security-module@vger.kernel.org, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Jann Horn <jannh@google.com>, 
	linux-kernel@vger.kernel.org, Peter Newman <peternewman@google.com>, 
	Andy Lutomirski <luto@amacapital.net>, Will Drewry <wad@chromium.org>, 
	Jarkko Sakkinen <jarkko@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 30, 2025 at 05:11:34PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, May 30, 2025 at 03:16:20PM +0200, G=C3=BCnther Noack wrote:
> > On Sun, May 18, 2025 at 09:57:32PM +0200, Micka=C3=ABl Sala=C3=BCn wrot=
e:
> > > We should rename the flag to LANDLOCK_RESTRICT_SELF_PROCESS to make i=
t
> > > clear what it does.
> > >=20
> > > The remaining issues are still the potential memory allocation failur=
es.
> > > There are two things:
> > >=20
> > > 1. We should try as much as possible to limit useless credential
> > >    duplications by not creating a new struct cred if parent credentia=
ls
> > >    are the same.
> > >=20
> > > 2. To avoid the libpsx inconsistency (because of ENOMEM or EPERM),
> > >    landlock_restrict_self(2) should handle memory allocation and
> > >    transition the process from a known state to another known state.
> > >=20
> > > What about this approach:
> > > - "Freeze" all threads of the current process (not ideal but simple) =
to
> > >   make sure their credentials don't get updated.
> > > - Create a new blank credential for the calling thread.
> > > - Walk through all threads and create a new blank credential for all
> > >   threads with a different cred than the caller.
> > > - Inject a task work that will call cred_transfer() for all threads w=
ith
> > >   either the same new credential used by the caller (incrementing the
> > >   refcount), or it will populate and use a blank one if it has differ=
ent
> > >   credentials than the caller.
> > >=20
> > > This may not efficiently deduplicate credentials for all threads but =
it
> > > is a simple deduplication approach that should be useful in most case=
s.
> > >=20
> > > The difficult part is mainly in the "fleezing". It would be nice to
> > > change the cred API to avoid that but I'm not sure how.
> >=20
> > I don't see an option how we could freeze the credentials of other thre=
ads:
> >=20
> > To freeze a task's credentials, we would have to inhibit that commit_cr=
eds()
> > succeeds on that task, and I don't see how that would be done - we can =
not
> > prevent these tasks from calling commit_creds() [1], and when commit_cr=
eds()
> > gets called, it is guaranteed to work.
> >=20
> > So in my mind, we have to somehow deal with the possibility that a task=
 has a
> > new and not-previously-seen struct creds, by the time that its task_wor=
k gets
> > called.  As a consequence, I think a call to prepare_creds() would then=
 be
> > unavoidable in the task_work?
>=20
> OK, we don't need to freeze all threads, just to block thread creation.
>=20
> What about that:
> 1. lock thread creation for this process
> 2. call prepare_creds() for the calling thread (called new_cred)
> 3. call cred_alloc_blank() for all other threads, store them in a list,
>    and exit if ENOMEM
> 4. asynchronously walk through all threads, and for each:
>   a. if its creds are the same (i.e. same pointer) as the calling
>      thread's ones, then call get_cred(new_cred) and
>      commit_creds(new_cred).
>   b. otherwise, take a blank cred, call cred_transfer(), add the
>      Landlock domain, and commit_creds() with it.
> 5. free all unused blank creds (most)
> 6. call commit_creds(new_creds) and return
>=20
> Pros:
> - do not block threads
> - minimize cred duplication
> - atomic operation (from the point of view of the caller): all or
>   nothing (with an error)
> - almost no change to existing cred API
>=20
> Cons:
> - block thread creation
> - initially allocate one cred per thread (but free most of them after)

The proposal is growing on me.

One way to view transfer_creds() and have it nicely fit into the credential=
s API
would be to view prepare_creds() as a convenience wrapper around
transfer_creds(), so that prepare_creds() is implemented as a function whic=
h:

  1) allocates a new struct cred (this may fail)
  2) calls transfer_creds() with the new struct cred to populate

We could then move the bulk of its existing prepare_creds() implementation =
into
the new transfer_creds(), and could also move the keyctl implementation to =
use
that.

A remaining problem is: The caveat and the underlying assumption is that
transfer_creds() must never fail when it runs in the task work, if we want =
to
avoid the additional synchronization.  The existing cases in which the
credentials preparation logic can return an error are:

* Allocation failure for struct cred  (we would get rid of this)
* get_ucounts(new->ucounts) returns NULL  (not supposed to happen, AFAICT)
* security_prepare_creds() fails.  Existing LSM implementations are:
  * Tomoyo, SELinux, AppArmor, Landlock: always return 0
  * SMACK: May return -ENOMEM on allocation failure


So summing up, in my understanding, the prerequisites for this approach are=
 that:

  1) get_ucounts() never returns NULL, and

  2) SMACK does not bubble up allocation errors from the cred_prepare hook

     Casey, Jarkko: do you think this is realistic for SMACK to change?

and that

  3) We can block new thread creation

     Micka=C3=ABl, do you have a specific approach in mind for that?

     As Jann pointed out in [1], the tasklist_lock and siglock are not slee=
pable
     and can't be used while waiting, which is why he proposed an approach =
where
     we retry in a loop until no new threads show up any more, while gettin=
g the
     existing threads stuck in the task_work as well (where they can't spaw=
n new
     threads).


Thanks,

=E2=80=94G=C3=BCnther

[1] https://lore.kernel.org/all/CAG48ez0pWg3OTABfCKRk5sWrURM-HdJhQMcWedEppc=
_z1rrVJw@mail.gmail.com/
