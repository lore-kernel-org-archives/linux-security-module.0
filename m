Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [45.157.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0EB2253AB
	for <linux-security-module@vger.kernel.org>; Tue, 11 Mar 2025 19:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721372; cv=none; b=h+2O9iYAIWh3uwTAmPstGq8UjdeXqLMfO3ZIaoSg3HDsmAzEdv+TZluSabna9aLUsEt/dERRV0c/6BRgjEQWCXLF/zRBt08jRAxy27ZoIBiRRvHOav+G+dAuq+4E0oSMlvlhhLGE+6hUxoyvlQOZN0iEUiSlfSbmvHdqJKBi8wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721372; c=relaxed/simple;
	bh=mSaiYhhtmJBnUVke38ATqhNgOAEjqJiVWvhpiUDHLNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bs9rsy91fXoTmiVIqSa10qnAnm2FaV4tU/Q5JTQfjf8fX4eYUgKVczRKGak6hyuYoG8J6FvGMV0gjO8IatPfRLQQ+6PdlYlC769rQyJBXtgZZyGM8TI4W4JdTdSQYjUKryWSWTUmmLR2eDyvK4w2W96l42knlyg8FEcZt+diJUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=DGQDjQ+P; arc=none smtp.client-ip=45.157.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="DGQDjQ+P"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10:40ca:feff:fe05:1])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4ZC3jZ3RQYzQWT;
	Tue, 11 Mar 2025 20:29:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1741721362;
	bh=jQSnOAufRrWN0Q7GsX4jU6BFD1ChP+6jZwWv0CTY3uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGQDjQ+P4j7XFib+WSGL/GsGvE2SKJUwuSeaM3rzNA3QTU3Lgk+alwfaQzrsnqrnk
	 QqaQORlGcQQjpXhr6C8ps1oVkD5IEE5FD/YE/gFoHpr2lBV2PyW1LYK1tPD9aKFlmi
	 75zRcCHGTJy33uKSLIlsqzb+aQ7BGsXxwnLJrLOI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4ZC3jY73GBz9q6;
	Tue, 11 Mar 2025 20:29:21 +0100 (CET)
Date: Tue, 11 Mar 2025 20:29:21 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Tingmao Wang <m@maowtm.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	Jan Kara <jack@suse.cz>, linux-security-module@vger.kernel.org, 
	Amir Goldstein <amir73il@gmail.com>, Matthew Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org, Tycho Andersen <tycho@tycho.pizza>
Subject: Re: [RFC PATCH 6/9] Creating supervisor events for filesystem
 operations
Message-ID: <20250311.Ou4doot9Ohqu@digikod.net>
References: <cover.1741047969.git.m@maowtm.org>
 <ed5904af2bdab297f4137a43e44363721894f42f.1741047969.git.m@maowtm.org>
 <20250304.oowung0eiPee@digikod.net>
 <f6e136a8-7594-4cca-bf48-58c0ddc0ddc7@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6e136a8-7594-4cca-bf48-58c0ddc0ddc7@maowtm.org>
X-Infomaniak-Routing: alpha

On Mon, Mar 10, 2025 at 12:39:17AM +0000, Tingmao Wang wrote:
> On 3/4/25 19:50, Mickaël Salaün wrote:
> > On Tue, Mar 04, 2025 at 01:13:02AM +0000, Tingmao Wang wrote:
> > > NOTE from future me: This implementation which waits for user response
> > > while blocking inside the current security_path_* hooks is problematic due
> > > to taking exclusive inode lock on the parent directory, and while I have a
> > > proposal for a solution, outlined below, I haven't managed to include the
> > > code for that in this version of the patch. Thus for this commit in
> > > particular I'm probably more looking for suggestions on the approach
> > > rather than code review.  Please see the TODO section at the end of this
> > > message before reviewing this patch.
> > 
> > This is good for an RFC.
> > 
> > > 
> > > ----
> > > 
> > > This patch implements a proof-of-concept for modifying the current
> > > landlock LSM hooks to send supervisor events and wait for responses, when
> > > a supervised layer is involved.
> > > 
> > > In this design, access requests which would end up being denied by other
> > > non-supervised landlock layers (or which would fail the normal inode
> > > permission check anyways - but this is currently TODO, I only thought of
> > > this afterwards) are denied straight away to avoid pointless supervisor
> > > notifications.
> > 
> > Yes, only denied access should be forwarded to the supervisor.
> 
> I assume you meant only denied access *by the supervised layers* should be
> forwarded to the supervisor.

Yes

> 
> > In another patch series we could enable the supervisor to update its layer
> > with new rules as well.
> 
> I did consider the possibility of this - if the supervisor has decided to
> allow all future access to e.g. a directory, ideally this can be "offloaded"
> to the kernel, but I was a bit worried about the fact that landlock
> currently quite heavily assumes the domain is immutable. While in the
> supervised case breaking that rule here should be alright (no worse
> security), not sure if there is some potential logic / data race bugs if we
> now make domains mutable.

Domains are currently immutable, it would be good to keep this property
as much as possible, but at the same time I don't see how this
supervisor feature would work in practice without the ability to update
the domain.

> 
> > 
> > The audit patch series should help to properly identify which layer
> > denied a request, and to only use the related supervisor.
> 
> The current patch does correctly identify which layer(s) (and sends events
> to the right supervisor(s)), but aligning with and re-using code in the
> audit patch is sensible.  Will have a look.

Yes please, some helpers look very similar.  It would be useful if you
reviewed this part in the audit patch series.

> 
> > 
> > > 
> > > Currently current_check_access_path only gets the path of the parent
> > > directory for create/remove operations, which is not enough for what we
> > > want to pass to the supervisor.  Therefore we extend it by passing in any
> > > relevant child dentry (but see TODO below - this may not be possible with
> > > the proper implementation).
> > 
> > Hmm, I'm not sure this kind of information is required (this is not
> > implemented for the audit support).  The supervisor should be fine
> > getting only which access is missing, right?
> > 
> > > 
> > > This initial implementation doesn't handle links and renames, and for now
> > > these operations behave as if no supervisor is present (and thus will be
> > > denied, unless it is allowed by the layer rules).  Also note that we can
> > > get spurious create requests if the program tries to O_CREAT open an
> > > existing file that exists but not in the dcache (from my understanding).
> > > 
> > > Event IDs (referred to as an opaque cookie in the uapi) are currently
> > > generated with a simple `next_event_id++`.  I considered using e.g. xarray
> > > but decided to not for this PoC. Suggestions welcome. (Note that we have
> > > to design our own event id even if we use an extension of fanotify, as
> > > fanotify uses a file descriptor to identify events, which is not generic
> > > enough for us)
> > 
> > That's another noticable difference with fanotify.  You can add it to
> > the next cover letter.
> > 
> > > 
> > > ----
> > > 
> > > TODO:
> > > 
> > > When testing this I realized that doing it this way means that for the
> > > create/delete case, we end up holding an exclusive inode lock on the
> > > parent directory while waiting for supervisor to respond (see namei.c -
> > > security_path_mknod is called in may_o_create <- lookup_open which has an
> > > exclusive lock if O_CREAT is passed), which will prevent all other tasks
> > > from accessing that directory (regardless of whether or not they are under
> > > landlock).
> > 
> > Could we use a landlock_object to identify this inode instead?
> 
> Sorry - earlier when reading this I didn't quite understand this suggestion
> and forgot to say so, however the problem here is the location of the
> security_path_... hooks (by the time they are called the lock is already
> held). I'm not sure how we identify the inode makes a difference?

Yes, we should just be able to create a O_PATH FD from the hooks, but in
the task_work (see my other reply).

> 
> > 
> > > 
> > > This is clearly unacceptable, but since landlock (and also this extension)
> > > doesn't actually need a dentry for the child (which is allocated after the
> > > inode lock), I think this is not unsolvable.  I'm experimenting with
> > > creating a new LSM hook, something like security_pathname_mknod
> > > (suggestions welcome), which will be called after we looked up the dentry
> > > for the parent (to prevent racing symlinks TOCTOU), but before we take the
> > > lock for it.  Such a hook can still take as argument the parent dentry,
> > > plus name of the child (instead of a struct path for it).
> > > 
> > > Suggestions for alternative approaches are definitely welcome!
> > > 
> > > Signed-off-by: Tingmao Wang <m@maowtm.org>
> > > ---
> > >   security/landlock/fs.c        | 134 ++++++++++++++++++++++++++++++++--
> > >   security/landlock/supervise.c | 122 +++++++++++++++++++++++++++++++
> > >   security/landlock/supervise.h | 106 ++++++++++++++++++++++++++-
> > >   3 files changed, 354 insertions(+), 8 deletions(-)
> > > 
> > 
> > [...]
> 
> 
