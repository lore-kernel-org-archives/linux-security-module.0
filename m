Received: from smtp-8fa8.mail.infomaniak.ch (smtp-8fa8.mail.infomaniak.ch [83.166.143.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DFB18A6A8
	for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 09:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771494366; cv=none; b=szGVjoeIbo4T0ajJg+h2onP1IsMjF+iXyvpMQhuTWMzUXtMlchZlMPKixzglymySIgBri0+j5CHtM6gINBENeRfVtRqtIM7EQuCylvSjNROs6v0pibgN+wVb36929xkFCnoHG2336Io8/BN30fQU+klsezBKeEILyUh7mfNMJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771494366; c=relaxed/simple;
	bh=x5uhtNJ5K5eoFpRL/NeFexqCc0hHLGqVnq1Q+KEJcg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hKRXeqwIsAOVONeHMfshXbtOIT7RwJkCzBi7vu1spkoPz+f4nzCFW3DotU9ahVTo+Gr64iROHKWj1CCTxXlKdPjI9aZxXRRApYbGbQMPihCgtQGkSFGVVHg78vawJ2S7gu2XZRmotrBHUPCRdOgg0YQROHPzKzbrCC4+2sTrD5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=kqQaMHRK; arc=none smtp.client-ip=83.166.143.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="kqQaMHRK"
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fGpR356N7zKKh;
	Thu, 19 Feb 2026 10:45:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1771494351;
	bh=PS7hqY+KK+FSmhQSCrdJQffLZpXbUaa5qCTHyJi2DaY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kqQaMHRKNByTxjCUMZM0NuTU2caT2yFXy3+Y9eU7g2KpM4KNb7duSjHBEx6WlTRd+
	 ltP2Ynnzo6CUcQlaJ7MUqg8eLh2Q8q3xY0ndjA6zNRxrGKzmyN+gTcd+ZsThlmQZlK
	 riKmu1OXtdD9Bdy7xAX2nKhf36Y0R4vOJT51RfWM=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4fGpR23VNHzjyR;
	Thu, 19 Feb 2026 10:45:50 +0100 (CET)
Date: Thu, 19 Feb 2026 10:45:44 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>
Cc: John Johansen <john.johansen@canonical.com>, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>, 
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org, 
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>, Matthieu Buffet <matthieu@buffet.re>, 
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, konstantin.meskhidze@huawei.com, 
	Demi Marie Obenour <demiobenour@gmail.com>, Alyssa Ross <hi@alyssa.is>, 
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 2/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260219.IF4zee3Quo3j@digikod.net>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-3-gnoack3000@gmail.com>
 <20260217.lievaS8eeng8@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260217.lievaS8eeng8@digikod.net>
X-Infomaniak-Routing: alpha

On Wed, Feb 18, 2026 at 10:37:16AM +0100, Mickaël Salaün wrote:
> On Sun, Feb 15, 2026 at 11:51:50AM +0100, Günther Noack wrote:
> > * Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
> >   controls the look up operations for named UNIX domain sockets.  The
> >   resolution happens during connect() and sendmsg() (depending on
> >   socket type).
> > * Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
> >   LSM hook.  Make policy decisions based on the new access rights
> > * Increment the Landlock ABI version.
> > * Minor test adaptions to keep the tests working.
> > 
> > With this access right, access is granted if either of the following
> > conditions is met:
> > 
> > * The target socket's filesystem path was allow-listed using a
> >   LANDLOCK_RULE_PATH_BENEATH rule, *or*:
> > * The target socket was created in the same Landlock domain in which
> >   LANDLOCK_ACCESS_FS_RESOLVE_UNIX was restricted.
> > 
> > In case of a denial, connect() and sendmsg() return EACCES, which is
> > the same error as it is returned if the user does not have the write
> > bit in the traditional Unix file system permissions of that file.
> > 
> > This feature was created with substantial discussion and input from
> > Justin Suess, Tingmao Wang and Mickaël Salaün.
> > 
> > Cc: Tingmao Wang <m@maowtm.org>
> > Cc: Justin Suess <utilityemal77@gmail.com>
> > Cc: Mickaël Salaün <mic@digikod.net>
> > Suggested-by: Jann Horn <jannh@google.com>
> > Link: https://github.com/landlock-lsm/linux/issues/36
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >  include/uapi/linux/landlock.h                |  10 ++
> >  security/landlock/access.h                   |  11 +-
> >  security/landlock/audit.c                    |   1 +
> >  security/landlock/fs.c                       | 102 ++++++++++++++++++-
> >  security/landlock/limits.h                   |   2 +-
> >  security/landlock/syscalls.c                 |   2 +-
> >  tools/testing/selftests/landlock/base_test.c |   2 +-
> >  tools/testing/selftests/landlock/fs_test.c   |   5 +-
> >  8 files changed, 128 insertions(+), 7 deletions(-)

> > index 60ff217ab95b..8d0edf94037d 100644
> > --- a/security/landlock/audit.c
> > +++ b/security/landlock/audit.c
> > @@ -37,6 +37,7 @@ static const char *const fs_access_strings[] = {
> >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
> >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
> >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
> > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX)] = "fs.resolve_unix",
> >  };
> >  
> >  static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
> > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > index e764470f588c..76035c6f2bf1 100644
> > --- a/security/landlock/fs.c
> > +++ b/security/landlock/fs.c
> > @@ -27,6 +27,7 @@
> >  #include <linux/lsm_hooks.h>
> >  #include <linux/mount.h>
> >  #include <linux/namei.h>
> > +#include <linux/net.h>
> >  #include <linux/path.h>
> >  #include <linux/pid.h>
> >  #include <linux/rcupdate.h>
> > @@ -314,7 +315,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> >  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> > +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> > +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
> >  /* clang-format on */
> >  
> >  /*
> > @@ -1561,6 +1563,103 @@ static int hook_path_truncate(const struct path *const path)
> >  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> >  }
> >  
> > +/**
> > + * unmask_scoped_access - Remove access right bits in @masks in all layers
> > + *                        where @client and @server have the same domain
> > + *
> > + * This does the same as domain_is_scoped(), but unmasks bits in @masks.
> > + * It can not return early as domain_is_scoped() does.

Why can't we use the same logic as for other scopes?

> > + *
> > + * @client: Client domain
> > + * @server: Server domain
> > + * @masks: Layer access masks to unmask
> > + * @access: Access bit that controls scoping
> > + */
> > +static void unmask_scoped_access(const struct landlock_ruleset *const client,
> > +				 const struct landlock_ruleset *const server,
> > +				 struct layer_access_masks *const masks,
> > +				 const access_mask_t access)
> 
> This helper should be moved to task.c and factored out with
> domain_is_scoped().  This should be a dedicated patch.

Well, if domain_is_scoped() can be refactored and made generic, it would
make more sense to move it to domain.c

> 
> > +{
> > +	int client_layer, server_layer;
> > +	const struct landlock_hierarchy *client_walker, *server_walker;
> > +
> > +	if (WARN_ON_ONCE(!client))
> > +		return; /* should not happen */
> > +
> > +	if (!server)
> > +		return; /* server has no Landlock domain; nothing to clear */
> > +
> > +	client_layer = client->num_layers - 1;
> > +	client_walker = client->hierarchy;
> > +	server_layer = server->num_layers - 1;
> > +	server_walker = server->hierarchy;
> > +
> > +	/*
> > +	 * Clears the access bits at all layers where the client domain is the
> > +	 * same as the server domain.  We start the walk at min(client_layer,
> > +	 * server_layer).  The layer bits until there can not be cleared because
> > +	 * either the client or the server domain is missing.
> > +	 */
> > +	for (; client_layer > server_layer; client_layer--)
> > +		client_walker = client_walker->parent;
> > +
> > +	for (; server_layer > client_layer; server_layer--)
> > +		server_walker = server_walker->parent;
> > +
> > +	for (; client_layer >= 0; client_layer--) {
> > +		if (masks->access[client_layer] & access &&
> > +		    client_walker == server_walker)
> > +			masks->access[client_layer] &= ~access;
> > +
> > +		client_walker = client_walker->parent;
> > +		server_walker = server_walker->parent;
> > +	}
> > +}
