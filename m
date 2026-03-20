Received: from smtp-bc0d.mail.infomaniak.ch (smtp-bc0d.mail.infomaniak.ch [45.157.188.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B6F3D301B
	for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 17:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029093; cv=none; b=PxhR1OOlIg1eIH98HW02GA88vPlRWZ8zqDgLFmpZknuzEznHIj9yRS2xf42iycIccl5H4UXQZxCyD4cF62W9OM4SoeODC09pCQVKfhKe/SubdUYD3PpTF89ZY2BP6/U5HAmynw9+/0KfkmFDs+uEozawJnKArvkDnoIiyVTvysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029093; c=relaxed/simple;
	bh=nZlPTfXLTD+3aemOvG1JEPM+wa0kCOoMHQ7YVnO5OMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KQDtm28iSFJNMrPekHx4k/IYjBJ4duwlrGo2pYmf2EBYZ1O2D+I/u8Cu4qmhTmIJ66JCb87gOZHeJ7wXNrjYhUWvXtezR0gHlN8NR3RW6o3PRepZBwkF8m+yq3WMsNP9zz+ofN+lhxWS772LyEu75m1TcjLwq+I7YWr9J+QW00k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=e3MlTicX; arc=none smtp.client-ip=45.157.188.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="e3MlTicX"
Received: from smtp-4-0001.mail.infomaniak.ch (unknown [IPv6:2001:1600:7:10::a6c])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fcqql1RqDzXHn;
	Fri, 20 Mar 2026 18:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1774029075;
	bh=qEvGIUEmCdq8sNj78T8rEfwhZ5D+1ZU231VXELtWKKc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3MlTicX9mvsfWmacMg7xpZglA9WWmvdwewAdlAJLqH+xLOOJoZRwPkXTGeJl5NM2
	 TVRfe97yT39R0uVZXoeNrJ7hh7BP6TmNIiXhgPSpcJgiaA15DVW3yjxGx+5g8raQu6
	 VFmaRTkmw2OdOhsN/SLSGzQyICeINtfSvYVFzeMI=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fcqqk0DfXzYJ6;
	Fri, 20 Mar 2026 18:51:13 +0100 (CET)
Date: Fri, 20 Mar 2026 18:51:13 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v6 3/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260320.eez3sheeThul@digikod.net>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-4-gnoack3000@gmail.com>
 <20260318.peecoo2Ooyep@digikod.net>
 <20260320.f59cddcb6c6b@gnoack.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320.f59cddcb6c6b@gnoack.org>
X-Infomaniak-Routing: alpha

On Fri, Mar 20, 2026 at 05:15:40PM +0100, Günther Noack wrote:
> Hello!
> 
> On Wed, Mar 18, 2026 at 05:52:48PM +0100, Mickaël Salaün wrote:
> > On Sun, Mar 15, 2026 at 11:21:44PM +0100, Günther Noack wrote:
> > > * Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
> > >   controls the look up operations for named UNIX domain sockets.  The
> > 
> > lookup
> 
> Done.
> 
> 
> > >   resolution happens during connect() and sendmsg() (depending on
> > >   socket type).
> > > * Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
> > >   LSM hook.  Make policy decisions based on the new access rights
> > > * Increment the Landlock ABI version.
> > > * Minor test adaptions to keep the tests working.
> > 
> > adaptations
> 
> Done.
> 
> 
> > > * Document the design rationale for scoped access rights,
> > >   and cross-reference it from the header documentation.
> > > 
> > > With this access right, access is granted if either of the following
> > > conditions is met:
> > > 
> > > * The target socket's filesystem path was allow-listed using a
> > >   LANDLOCK_RULE_PATH_BENEATH rule, *or*:
> > > * The target socket was created in the same Landlock domain in which
> > >   LANDLOCK_ACCESS_FS_RESOLVE_UNIX was restricted.
> > > 
> > > In case of a denial, connect() and sendmsg() return EACCES, which is
> > > the same error as it is returned if the user does not have the write
> > > bit in the traditional Unix file system permissions of that file.
> > 
> > UNIX
> 
> DONE
> 
> 
> > > Document the (possible future) interaction between scoped flags and
> > > other access rights in struct landlock_ruleset_attr, and summarize the
> > > rationale, as discussed in code review leading up to [2].
> > > 
> > > This feature was created with substantial discussion and input from
> > > Justin Suess, Tingmao Wang and Mickaël Salaün.
> > > 
> > > Cc: Tingmao Wang <m@maowtm.org>
> > > Cc: Justin Suess <utilityemal77@gmail.com>
> > > Cc: Mickaël Salaün <mic@digikod.net>
> > > Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > > Cc: Kuniyuki Iwashima <kuniyu@google.com>
> > > Suggested-by: Jann Horn <jannh@google.com>
> > > Link[1]: https://github.com/landlock-lsm/linux/issues/36
> > > Link[2]: https://lore.kernel.org/all/20260205.8531e4005118@gnoack.org/
> > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > ---
> > >  Documentation/security/landlock.rst          |  40 +++++++
> > >  include/uapi/linux/landlock.h                |  19 ++++
> > >  security/landlock/access.h                   |   2 +-
> > >  security/landlock/audit.c                    |   1 +
> > >  security/landlock/fs.c                       | 110 ++++++++++++++++++-
> > >  security/landlock/limits.h                   |   2 +-
> > >  security/landlock/syscalls.c                 |   2 +-
> > >  tools/testing/selftests/landlock/base_test.c |   2 +-
> > >  tools/testing/selftests/landlock/fs_test.c   |   5 +-
> > >  9 files changed, 176 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/Documentation/security/landlock.rst b/Documentation/security/landlock.rst
> > > index 3e4d4d04cfae..4bbe250a6829 100644
> > > --- a/Documentation/security/landlock.rst
> > > +++ b/Documentation/security/landlock.rst
> > > @@ -89,6 +89,46 @@ this is required to keep access controls consistent over the whole system, and
> > >  this avoids unattended bypasses through file descriptor passing (i.e. confused
> > >  deputy attack).
> > >  
> > > +.. _scoped-flags-interaction:
> > > +
> > > +Interaction between scoped flags and other access rights
> > > +--------------------------------------------------------
> > > +
> > > +The ``scoped`` flags in ``struct landlock_ruleset_attr`` restrict the
> > > +use of *outgoing* IPC from the created Landlock domain, while they
> > > +permit reaching out to IPC endpoints *within* the created Landlock
> > > +domain.
> > > +
> > > +In the future, scoped flags *may* interact with other access rights,
> > > +e.g. so that abstract UNIX sockets can be allow-listed by name, or so
> > > +that signals can be allow-listed by signal number or target process.
> > > +
> > > +When introducing ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``, we defined it to
> > > +implicitly have the same scoping semantics as a
> > > +``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` flag would have: connecting to
> > > +UNIX sockets within the same domain (where
> > > +``LANDLOCK_ACCESS_FS_RESOLVE_UNIX`` is used) is unconditionally
> > > +allowed.
> > > +
> > > +The reasoning is:
> > > +
> > > +* Like other IPC mechanisms, connecting to named UNIX sockets in the
> > > +  same domain should be expected and harmless.  (If needed, users can
> > > +  further refine their Landlock policies with nested domains or by
> > > +  restricting ``LANDLOCK_ACCESS_FS_MAKE_SOCK``.)
> > > +* We reserve the option to still introduce
> > > +  ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` in the future.  (This would
> > > +  be useful if we wanted to have a Landlock rule to permit IPC access
> > > +  to other Landlock domains.)
> > > +* But we can postpone the point in time when users have to deal with
> > > +  two interacting flags visible in the userspace API.  (In particular,
> > > +  it is possible that it won't be needed in practice, in which case we
> > > +  can avoid the second flag altogether.)
> > > +* If we *do* introduce ``LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET`` in the
> > > +  future, setting this scoped flag in a ruleset does *not reduce* the
> > > +  restrictions, because access within the same scope is already
> > > +  allowed based on ``LANDLOCK_ACCESS_FS_RESOLVE_UNIX``.
> > > +
> > >  Tests
> > >  =====
> > >  
> > > diff --git a/include/uapi/linux/landlock.h b/include/uapi/linux/landlock.h
> > > index f88fa1f68b77..751e3c143cba 100644
> > > --- a/include/uapi/linux/landlock.h
> > > +++ b/include/uapi/linux/landlock.h
> > > @@ -248,6 +248,24 @@ struct landlock_net_port_attr {
> > >   *
> > >   *   This access right is available since the fifth version of the Landlock
> > >   *   ABI.
> > > + * - %LANDLOCK_ACCESS_FS_RESOLVE_UNIX: Look up pathname UNIX domain sockets
> > > + *   (:manpage:`unix(7)`).  On UNIX domain sockets, this restricts both calls to
> > > + *   :manpage:`connect(2)` as well as calls to :manpage:`sendmsg(2)` with an
> > > + *   explicit recipient address.
> > > + *
> > > + *   This access right only applies to connections to UNIX server sockets which
> > > + *   were created outside of the newly created Landlock domain (e.g. from within
> > > + *   a parent domain or from an unrestricted process).  Newly created UNIX
> > > + *   servers within the same Landlock domain continue to be accessible.  In this
> > > + *   regard, %LANDLOCK_ACCESS_RESOLVE_UNIX has the same semantics as the
> > 
> > LANDLOCK_ACCESS_FS_RESOLVE_UNIX
> 
> Whoops, done.
> 
> 
> > > + *   ``LANDLOCK_SCOPE_*`` flags.
> > > + *
> > > + *   If a resolve attempt is denied, the operation returns an ``EACCES`` error,
> > > + *   in line with other filesystem access rights (but different to denials for
> > > + *   abstract UNIX domain sockets).
> > 
> > This access right is available since the ninth version of the Landlock ABI.
> 
> Thanks, added.
> 
> 
> > > + *
> > > + *   The rationale for this design is described in
> > > + *   :ref:`Documentation/security/landlock.rst <scoped-flags-interaction>`.
> > >   *
> > >   * Whether an opened file can be truncated with :manpage:`ftruncate(2)` or used
> > >   * with `ioctl(2)` is determined during :manpage:`open(2)`, in the same way as
> > > @@ -333,6 +351,7 @@ struct landlock_net_port_attr {
> > >  #define LANDLOCK_ACCESS_FS_REFER			(1ULL << 13)
> > >  #define LANDLOCK_ACCESS_FS_TRUNCATE			(1ULL << 14)
> > >  #define LANDLOCK_ACCESS_FS_IOCTL_DEV			(1ULL << 15)
> > > +#define LANDLOCK_ACCESS_FS_RESOLVE_UNIX			(1ULL << 16)
> > >  /* clang-format on */
> > >  
> > >  /**
> > > diff --git a/security/landlock/access.h b/security/landlock/access.h
> > > index 42c95747d7bd..89dc8e7b93da 100644
> > > --- a/security/landlock/access.h
> > > +++ b/security/landlock/access.h
> > > @@ -34,7 +34,7 @@
> > >  	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> > >  /* clang-format on */
> > >  
> > > -typedef u16 access_mask_t;
> > > +typedef u32 access_mask_t;
> > 
> > This change and the underlying implications are not explained in the
> > commit message, especially regarding the stack delta.
> 
> Thanks, will add it.
> 
> 
> > >  /* Makes sure all filesystem access rights can be stored. */
> > >  static_assert(BITS_PER_TYPE(access_mask_t) >= LANDLOCK_NUM_ACCESS_FS);
> > > diff --git a/security/landlock/audit.c b/security/landlock/audit.c
> > > index 60ff217ab95b..8d0edf94037d 100644
> > > --- a/security/landlock/audit.c
> > > +++ b/security/landlock/audit.c
> > > @@ -37,6 +37,7 @@ static const char *const fs_access_strings[] = {
> > >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
> > >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
> > >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
> > > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX)] = "fs.resolve_unix",
> > >  };
> > >  
> > >  static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
> > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > > index 97065d51685a..0486f5ab06c9 100644
> > > --- a/security/landlock/fs.c
> > > +++ b/security/landlock/fs.c
> > > @@ -27,6 +27,7 @@
> > >  #include <linux/lsm_hooks.h>
> > >  #include <linux/mount.h>
> > >  #include <linux/namei.h>
> > > +#include <linux/net.h>
> > >  #include <linux/path.h>
> > >  #include <linux/pid.h>
> > >  #include <linux/rcupdate.h>
> > > @@ -36,6 +37,7 @@
> > >  #include <linux/types.h>
> > >  #include <linux/wait_bit.h>
> > >  #include <linux/workqueue.h>
> > > +#include <net/af_unix.h>
> > >  #include <uapi/linux/fiemap.h>
> > >  #include <uapi/linux/landlock.h>
> > >  
> > > @@ -314,7 +316,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> > >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> > >  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > > -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> > > +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> > > +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
> > >  /* clang-format on */
> > >  
> > >  /*
> > > @@ -1557,6 +1560,110 @@ static int hook_path_truncate(const struct path *const path)
> > >  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> > >  }
> > >  
> > > +/**
> > > + * unmask_scoped_access - Remove access right bits in @masks in all layers
> > > + *                        where @client and @server have the same domain
> > > + *
> > > + * This does the same as domain_is_scoped(), but unmasks bits in @masks.
> > > + * It can not return early as domain_is_scoped() does.
> > 
> > I'd like a summary of your previous excellent explanation of
> > unmask_scoped_access() in this comment.
> 
> Adding:
> 
>  A scoped access for a given access right bit is allowed iff, for all
>  layer depths where the access bit is set, the client and server
>  domain are the same.  This function clears the access rights @access
>  in @masks at all layer depths where the client and server domain are
>  the same, so that, when they are all cleared, the access is allowed.
> 
> It's not as detailed as drawing a picture in the other mail, but I
> hope it helps.

Good

> 
> 
> > > + * @client: Client domain
> > > + * @server: Server domain
> > > + * @masks: Layer access masks to unmask
> > > + * @access: Access bit that controls scoping
> > > + */
> > > +static void unmask_scoped_access(const struct landlock_ruleset *const client,
> > > +				 const struct landlock_ruleset *const server,
> > > +				 struct layer_access_masks *const masks,
> > > +				 const access_mask_t access)
> > > +{
> > > +	int client_layer, server_layer;
> > > +	const struct landlock_hierarchy *client_walker, *server_walker;
> > > +
> > > +	/* This should not happen. */
> > > +	if (WARN_ON_ONCE(!client))
> > > +		return;
> > > +
> > > +	/* Server has no Landlock domain; nothing to clear. */
> > > +	if (!server)
> > > +		return;
> > > +
> > 
> > Please also copy the BUILD_BUG_ON() from domain_is_scoped().
> 
> I don't understand what this check is good for.  It says:
> 
> /*
>  * client_layer must be a signed integer with greater capacity
>  * than client->num_layers to ensure the following loop stops.
>  */
> BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
> 
> For the loop to terminate, in my understanding, client_layer must be
> able to store client->num_layers - 1 down to - 1, but that is anyway a
> given since num_layers can't exceed 16 and client_layer is signed.  It
> seems that the termination of this would anyway be caught in our tests
> as well?
> 
> Could you please clarify what this BUILD_BUG_ON() is trying to assert?

The intent was to make sure client_layer is indeed an int and not an
unsigned int for instance.  Hopefully tests catch that but using a
build-time assert catch the potential issue and document it.  Also, it
would be weird to not have the same checks in both copies of code.

> 
> 
> > > +	client_layer = client->num_layers - 1;
> > > +	client_walker = client->hierarchy;
> > > +	server_layer = server->num_layers - 1;
> > > +	server_walker = server->hierarchy;
> > > +
> > > +	/*
> > > +	 * Clears the access bits at all layers where the client domain is the
> > > +	 * same as the server domain.  We start the walk at min(client_layer,
> > > +	 * server_layer).  The layer bits until there can not be cleared because
> > > +	 * either the client or the server domain is missing.
> > > +	 */
> > > +	for (; client_layer > server_layer; client_layer--)
> > > +		client_walker = client_walker->parent;
> > > +
> > > +	for (; server_layer > client_layer; server_layer--)
> > > +		server_walker = server_walker->parent;
> > > +
> > > +	for (; client_layer >= 0; client_layer--) {
> > > +		if (masks->access[client_layer] & access &&
> > > +		    client_walker == server_walker)
> > > +			masks->access[client_layer] &= ~access;
> > > +
> > > +		client_walker = client_walker->parent;
> > > +		server_walker = server_walker->parent;
> > > +	}
> > > +}
> > > +
> > > +static int hook_unix_find(const struct path *const path, struct sock *other,
> > > +			  int flags)
> > > +{
> > > +	const struct landlock_ruleset *dom_other;
> > > +	const struct landlock_cred_security *subject;
> > > +	struct layer_access_masks layer_masks;
> > > +	struct landlock_request request = {};
> > > +	static const struct access_masks fs_resolve_unix = {
> > > +		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> > > +	};
> > > +
> > > +	/* Lookup for the purpose of saving coredumps is OK. */
> > > +	if (unlikely(flags & SOCK_COREDUMP))
> > > +		return 0;
> > > +
> > > +	/* Access to the same (or a lower) domain is always allowed. */
> > 
> > This comment is related to the unmask_scoped_access() call.
> 
> Thanks, I moved it down.
> 
> 
> > > +	subject = landlock_get_applicable_subject(current_cred(),
> > > +						  fs_resolve_unix, NULL);
> > > +
> > > +	if (!subject)
> > > +		return 0;
> > > +
> > > +	if (!landlock_init_layer_masks(subject->domain, fs_resolve_unix.fs,
> > > +				       &layer_masks, LANDLOCK_KEY_INODE))
> > 
> > This case is not possible because landlock_get_applicable_subject()
> > already check it.  Other hooks just ignore the returned value in this
> > case.
> 
> Hm, fair enough. I added a comment to explain why we are ignoring the
> return value, as it wasn't as obvious to me.  In the other places, we
> are using the result of the landlock_init_layer_masks() function
> (because in the generic case, it can be a subset of the original
> access rights).

Another way to document it would be to use a WARN_ON_ONCE(), but that
would not be very useful in this case and add code which cannot be
tested/covered.

> 
> 
> > > +		return 0;
> > > +
> > > +	/* Checks the layers in which we are connecting within the same domain. */
> > > +	unix_state_lock(other);
> > > +	if (unlikely(sock_flag(other, SOCK_DEAD) || !other->sk_socket ||
> > > +		     !other->sk_socket->file)) {
> > > +		unix_state_unlock(other);
> > > +		return 0;
> > 
> > Is it safe to not return -ECONNREFUSED?
> 
> Yes.  My reasoning is:
> 
> In all three places where this gets called in af_unix.c (stream
> connect, dgram connect, dgram send), these functions check for socket
> death shortly after, and if they find the socket to be SOCK_DEAD, they
> will *retry* the UNIX lookup.  The code commentary about this says
> that this is for a race condition where the VFS has "overslept" the
> socket death, so I presume that the retry aims at getting a race-free
> sitation on the next attempt.
> 
> Since sock_orphan() is a one-way teardown operation, when we observe
> SOCK_DEAD in our hook, we can be sure that the caller will see it as
> well when it does the same check a bit later after our hook.
> 
> If we *were* to return -ECONNREFUSED, the caller would immediately
> return an error though, and it would not retry as it normally does
> when it encounters this race condition.  So we have to return 0 here.

OK, sound good.

> 
> 
> > > +	}
> > > +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> > > +	unix_state_unlock(other);
> > > +
> > > +	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
> > > +			     fs_resolve_unix.fs);
> > 
> > dom_other is not safe to use without the lock.
> 
> Thanks, fixed by extending the lock scope across that function call,
> as discussed in other thread in more detail.
> 
> 
> > > +	/* Checks the connections to allow-listed paths. */
> > > +	if (is_access_to_paths_allowed(subject->domain, path,
> > > +				       fs_resolve_unix.fs, &layer_masks,
> > > +				       &request, NULL, 0, NULL, NULL, NULL))
> > > +		return 0;
> > > +
> > > +	landlock_log_denial(subject, &request);
> > > +	return -EACCES;
> > > +}
> > > +
> > >  /* File hooks */
> > >  
> > >  /**
> > > @@ -1834,6 +1941,7 @@ static struct security_hook_list landlock_hooks[] __ro_after_init = {
> > >  	LSM_HOOK_INIT(path_unlink, hook_path_unlink),
> > >  	LSM_HOOK_INIT(path_rmdir, hook_path_rmdir),
> > >  	LSM_HOOK_INIT(path_truncate, hook_path_truncate),
> > > +	LSM_HOOK_INIT(unix_find, hook_unix_find),
> > >  
> > >  	LSM_HOOK_INIT(file_alloc_security, hook_file_alloc_security),
> > >  	LSM_HOOK_INIT(file_open, hook_file_open),
> > > diff --git a/security/landlock/limits.h b/security/landlock/limits.h
> > > index eb584f47288d..b454ad73b15e 100644
> > > --- a/security/landlock/limits.h
> > > +++ b/security/landlock/limits.h
> > > @@ -19,7 +19,7 @@
> > >  #define LANDLOCK_MAX_NUM_LAYERS		16
> > >  #define LANDLOCK_MAX_NUM_RULES		U32_MAX
> > >  
> > > -#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_IOCTL_DEV
> > > +#define LANDLOCK_LAST_ACCESS_FS		LANDLOCK_ACCESS_FS_RESOLVE_UNIX
> > >  #define LANDLOCK_MASK_ACCESS_FS		((LANDLOCK_LAST_ACCESS_FS << 1) - 1)
> > >  #define LANDLOCK_NUM_ACCESS_FS		__const_hweight64(LANDLOCK_MASK_ACCESS_FS)
> > >  
> > > diff --git a/security/landlock/syscalls.c b/security/landlock/syscalls.c
> > > index 3b33839b80c7..a6e23657f3ce 100644
> > > --- a/security/landlock/syscalls.c
> > > +++ b/security/landlock/syscalls.c
> > > @@ -166,7 +166,7 @@ static const struct file_operations ruleset_fops = {
> > >   * If the change involves a fix that requires userspace awareness, also update
> > >   * the errata documentation in Documentation/userspace-api/landlock.rst .
> > >   */
> > > -const int landlock_abi_version = 8;
> > > +const int landlock_abi_version = 9;
> > >  
> > >  /**
> > >   * sys_landlock_create_ruleset - Create a new ruleset
> > > diff --git a/tools/testing/selftests/landlock/base_test.c b/tools/testing/selftests/landlock/base_test.c
> > > index 0fea236ef4bd..30d37234086c 100644
> > > --- a/tools/testing/selftests/landlock/base_test.c
> > > +++ b/tools/testing/selftests/landlock/base_test.c
> > > @@ -76,7 +76,7 @@ TEST(abi_version)
> > >  	const struct landlock_ruleset_attr ruleset_attr = {
> > >  		.handled_access_fs = LANDLOCK_ACCESS_FS_READ_FILE,
> > >  	};
> > > -	ASSERT_EQ(8, landlock_create_ruleset(NULL, 0,
> > > +	ASSERT_EQ(9, landlock_create_ruleset(NULL, 0,
> > >  					     LANDLOCK_CREATE_RULESET_VERSION));
> > >  
> > >  	ASSERT_EQ(-1, landlock_create_ruleset(&ruleset_attr, 0,
> > > diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> > > index 968a91c927a4..b318627e7561 100644
> > > --- a/tools/testing/selftests/landlock/fs_test.c
> > > +++ b/tools/testing/selftests/landlock/fs_test.c
> > > @@ -575,9 +575,10 @@ TEST_F_FORK(layout1, inval)
> > >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> > >  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > > -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> > > +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> > > +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
> > >  
> > > -#define ACCESS_LAST LANDLOCK_ACCESS_FS_IOCTL_DEV
> > > +#define ACCESS_LAST LANDLOCK_ACCESS_FS_RESOLVE_UNIX
> > >  
> > >  #define ACCESS_ALL ( \
> > >  	ACCESS_FILE | \
> > > -- 
> > > 2.53.0
> > > 
> > > 
> 
> –Günther
> 
