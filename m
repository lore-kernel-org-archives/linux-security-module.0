Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491E231AA96
	for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 13:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771509589; cv=none; b=qml8PnTw4ODQGFr2Z+I0s+T2hmU3v7a5y5kxDpdc/Mr4RRQA2goRhF23Hi9jL7nPGhRJIuWeZPiKAC+Sb6/l+APuLgl3Xps5EctlUUdEludlhiMQl0MrV2w+nWjMNZr/s+WB4O29EUYKIffBQPjkjvfmLPordReKOt7t5yORmtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771509589; c=relaxed/simple;
	bh=G9tZURGwqOcLLZUILQ/FrmbLTRlxHR6kmtzolzjxs80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iM7eYAU5bZncd/bPsA6kJbbi0WmhSw3YHNbJfqL3l6tZM15CKp7bcE6oZb5yF9Z6rRWR5qpdTTceMzpZEruhVp7SG2zp5QMHnCbBZPpa3gVBrskuZppz3VyJQkJJWnVT8buZisR3eM/GADgP5xISols4OPYg/ljff9GB+rhAolg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R7yw1YzX; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R7yw1YzX"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483a233819aso4850865e9.3
        for <linux-security-module@vger.kernel.org>; Thu, 19 Feb 2026 05:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771509585; x=1772114385; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5DNJXbpyy98Ciqpm4Jp65JfKwTAixl7tFMnkVNHQjBw=;
        b=R7yw1YzXl9LkLoIprzsBQyU3tQnlY66GyRf3Ooq96PlFU1E85zA+jWrW4y+doYfiht
         S7sY6rKJjUWNTKq+OVgyIjctghu5fvsAi2ypNBiptiL3fQdhe3BWq3UKwUKm+oPYZJaX
         jDLWXl0HZK7SOy67sXRzyzTwnjE4vm5ovlJNMNDA8znGLPidRCbri75fbCk+7P7NX46R
         d5pO3c6E8dUZcT+0fVdwLrvdgJSYCTQeNUR0j+6OZ1ZbPdNBBinrYkDRTuoMw+ow9Lnn
         rAjvflwKlKHNrpYWSPJuehY1hW9JoOKQlrDwQOcFFP8oNjB9rbEBakEfB2kgF9fTXk4A
         cIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771509585; x=1772114385;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5DNJXbpyy98Ciqpm4Jp65JfKwTAixl7tFMnkVNHQjBw=;
        b=UxF2RTeRxLhBd0C1XthaLOV2hX5W9C4hUmat4M/DJANPoFJiX54S+nqXZWm5a2YUfG
         sytx+c1HupenimRysdkNNKiG+NC8qfjOJA2nwpRC0+8QBmR1TNo6JsYRb1tdTqDJF75i
         TGxuJclI1xU17J3q6iJUla8CU+qZCbZFn4MAQkqHa5VoMZ3i66lsD4IUK7r+Dn8YJkoo
         mc/gm1YadmoBJqRyL2/edu/9Ouj/aDogGLj4KhHEI3jKf4hnsWx8AzzZuAaSf67bLgOn
         vmZNbuJEg+jeCK4cSvfYBuJCC5jXXMq96GPo5Do0OnUDd6jKn6bORDEDKW4BzJI7dBx4
         N0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCWfl9SxfXW+ZqVcElBS+7BgoucDAULcWLMgNrlM0LRnNa1FyChZWDMxyixNBesTPPmKEqmzvYWLNnHuKPCW3AhP3uCk/hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4VEWA1t7AApk619u3Mlt9g+oKYCXnv9biD5Ibqikg0HMqxXzu
	t7wcirgoFGzCan9zaPp5pKA5JpjYzHXsRms6EmGO4sM+6R0ln3X1p3KewycySmcPmw==
X-Gm-Gg: AZuq6aLclUlMD6xIh79rRSDr9qGwtUmTucgZr+0vTfU//rO+FDWGTlsJELvJ5VXY5vH
	CtIAO16/SSpv2+Sq1QiogiHWHjRgKn+1vMeE8KaCVsi9E3uOCEzwMPJyd/GssJZWyDLszQOW/Hs
	I5MFySHg2pz08kbkMV+2GKf8Wf1gQrKJMjZStaE71xHMUJRWcRsDoGW7RakyoChcoghpFIg1CNj
	mubgiPpK9gMD6x0kGpjuaMdQLsb06o08bRNOusYGzeJLMVoxXBfrEduySyqM4xIw4yGL28hKg3o
	NbKRXAWoVGCLhBWP6sYOaRkJ62nAcADrh1ExR2jPtTtTyo/dzneiqIAAC2NbyoDa/zLXoce6x4V
	OgGqMTSo9Qg7bM6qKOt04qeNFf4F1DZCYApXNaWFTsI3v3aFJKoFeEY8w9ONTVrTT42CD9Qz+Ij
	nv0DLzMu6t9hog8wopWLT6FJyHNFqBizuiH6VxrU1Xo1vyw8PWZ8FWEg==
X-Received: by 2002:a05:600c:3542:b0:477:54cd:200e with SMTP id 5b1f17b1804b1-48398a678cfmr97192065e9.1.1771509584897;
        Thu, 19 Feb 2026 05:59:44 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:846b:b058:f015:d4d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483a31ba9easm5510345e9.4.2026.02.19.05.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 05:59:44 -0800 (PST)
Date: Thu, 19 Feb 2026 14:59:38 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 2/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <aZcXSmhZRVcRCvum@google.com>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-3-gnoack3000@gmail.com>
 <20260217.lievaS8eeng8@digikod.net>
 <20260219.IF4zee3Quo3j@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260219.IF4zee3Quo3j@digikod.net>

On Thu, Feb 19, 2026 at 10:45:44AM +0100, Mickaël Salaün wrote:
> On Wed, Feb 18, 2026 at 10:37:16AM +0100, Mickaël Salaün wrote:
> > On Sun, Feb 15, 2026 at 11:51:50AM +0100, Günther Noack wrote:
> > > * Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
> > >   controls the look up operations for named UNIX domain sockets.  The
> > >   resolution happens during connect() and sendmsg() (depending on
> > >   socket type).
> > > * Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
> > >   LSM hook.  Make policy decisions based on the new access rights
> > > * Increment the Landlock ABI version.
> > > * Minor test adaptions to keep the tests working.
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
> > > 
> > > This feature was created with substantial discussion and input from
> > > Justin Suess, Tingmao Wang and Mickaël Salaün.
> > > 
> > > Cc: Tingmao Wang <m@maowtm.org>
> > > Cc: Justin Suess <utilityemal77@gmail.com>
> > > Cc: Mickaël Salaün <mic@digikod.net>
> > > Suggested-by: Jann Horn <jannh@google.com>
> > > Link: https://github.com/landlock-lsm/linux/issues/36
> > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > ---
> > >  include/uapi/linux/landlock.h                |  10 ++
> > >  security/landlock/access.h                   |  11 +-
> > >  security/landlock/audit.c                    |   1 +
> > >  security/landlock/fs.c                       | 102 ++++++++++++++++++-
> > >  security/landlock/limits.h                   |   2 +-
> > >  security/landlock/syscalls.c                 |   2 +-
> > >  tools/testing/selftests/landlock/base_test.c |   2 +-
> > >  tools/testing/selftests/landlock/fs_test.c   |   5 +-
> > >  8 files changed, 128 insertions(+), 7 deletions(-)
> 
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
> > > index e764470f588c..76035c6f2bf1 100644
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
> > > @@ -314,7 +315,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> > >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> > >  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > > -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> > > +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> > > +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
> > >  /* clang-format on */
> > >  
> > >  /*
> > > @@ -1561,6 +1563,103 @@ static int hook_path_truncate(const struct path *const path)
> > >  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> > >  }
> > >  
> > > +/**
> > > + * unmask_scoped_access - Remove access right bits in @masks in all layers
> > > + *                        where @client and @server have the same domain
> > > + *
> > > + * This does the same as domain_is_scoped(), but unmasks bits in @masks.
> > > + * It can not return early as domain_is_scoped() does.
> 
> Why can't we use the same logic as for other scopes?

The other scopes, for which this is implemented in domain_is_scoped(),
do not need to do this layer-by-layer.

I have to admit, in my initial implementation, I was using
domain_is_scoped() directly, and the logic at the end of the hook was
roughly:

   --- BUGGY CODE START ---
       // ...
       
       if (!domain_is_scoped(..., ..., LANDLOCK_ACCESS_FS_RESOLVE_UNIX))
           return 0;  /* permitted */

       return current_check_access_path(path, LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
   }
   --- BUGGY CODE END ---

Unfortunately, that is a logic error though -- it implements the formula

   Access granted if:
   (FOR-ALL l ∈ layers scoped-access-ok(l)) OR (FOR-ALL l ∈ layers path-access-ok(l))     (WRONG!)

but the formula we want is:

   Access granted if:
   FOR-ALL l ∈ layers (scoped-access-ok(l) OR path-access-ok(l))     (CORRECT!)

This makes a difference in the case where (pseudocode):

   1. landlock_restrict_self(RESOLVE_UNIX)  // d1
   2. create_unix_server("./sock")
   3. landlock_restrict_self(RESOLVE_UNIX, rule=Allow(".", RESOLVE_UNIX))  // d2
   4. connect_unix("./sock")

   ,------------------------------------------------d1--,
   |                                                    |
   |    ./sock server                                   |
   |       ^                                            |
   |       |                                            |
   |  ,------------------------------------------d2--,  |
   |  |    |                                         |  |
   |  |  client                                      |  |
   |  |                                              |  |
   |  '----------------------------------------------'  |
   |                                                    |
   '----------------------------------------------------'

(BTW, this scenario is covered in the selftests, that is why there is
a variant of these selftests where instead of applying "no domain", we
apply a domain with an exception rule like in step 3 in the pseudocode
above.  Applying that domain should behave the same as applying no
domain at all.)

Intuitively, it is clear that the access should be granted:

  - d1 does not restrict access to the server,
    because the socket was created within d1 itself.
  - d2 does not restrict access to the server,
    because it has a rule to allow it

But the "buggy code" logic above comes to a different conclusion:

  - the domain_is_scoped() check denies the access, because the server
    is in a more privileged domain relative to the client domain.
  - the current_check_access_path() check denies the access as well,
    because the socket's path is not allow-listed in d1.

In the 'intuitive' reasoning above, we are checking d1 and d2
independently of each other.  While Landlock is not implemented like
that internally, we need to stay consistent with it so that domains
compose correctly.  The way to do that is to track is access check
results on a per-layer basis again, and that is why
unmask_scoped_access() uses a layer mask for tracking.  The original
domain_is_scoped() does not use a layer mask, but that also means that
it can return early in some scenarios -- if for any of the relevant
layer depths, the client and server domains are not the same, it exits
early with failure because it's overall not fulfillable any more.  In
the RESOLVE_UNIX case though, we need to remember in which layers we
failed (both high an low ones), because these layers can still be
fulfilled with a PATH_BENEATH rule later.

Summary:

Option 1: We *can* unify this if you want.  It just might come at a
small performance penalty for domain_is_scoped(), which now uses the
larger layer mask data structure and can't do the same early returns
any more as before.

Option 2: Alternatively, if we move the two functions into the same
module, we can keep them separate but still test them against each
other to make sure they are in-line:

This invocation should return true...

  domain_is_scoped(cli, srv, access)

...in the exactly the same situations where this invocation leaves any
bits set in layer_masks:

  landlock_init_layer_masks(dom, access, &layer_masks, LL_KEY_INODE);
  unmask_scoped_access(cli, srv, &layer_masks, access);

What do you prefer?


> > > + *
> > > + * @client: Client domain
> > > + * @server: Server domain
> > > + * @masks: Layer access masks to unmask
> > > + * @access: Access bit that controls scoping
> > > + */
> > > +static void unmask_scoped_access(const struct landlock_ruleset *const client,
> > > +				 const struct landlock_ruleset *const server,
> > > +				 struct layer_access_masks *const masks,
> > > +				 const access_mask_t access)
> > 
> > This helper should be moved to task.c and factored out with
> > domain_is_scoped().  This should be a dedicated patch.
> 
> Well, if domain_is_scoped() can be refactored and made generic, it would
> make more sense to move it to domain.c
> 
> > 
> > > +{
> > > +	int client_layer, server_layer;
> > > +	const struct landlock_hierarchy *client_walker, *server_walker;
> > > +
> > > +	if (WARN_ON_ONCE(!client))
> > > +		return; /* should not happen */
> > > +
> > > +	if (!server)
> > > +		return; /* server has no Landlock domain; nothing to clear */
> > > +
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
