Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B7D1E2834
	for <linux-security-module@vger.kernel.org>; Sat, 14 Mar 2026 23:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773530121; cv=none; b=nFfEMWhfczGvFHQnhdKjWTPd9wg2vEt8hJB3f6CkZlYpQEpr9IxkRYFXud7LJrBSOG9q2jJ8Vw/dZhksJvjFoFX3owpaKsn9yeMaCVtchFchOpssrAETMZw9apaSj3EeR7hbpB2PI5b8dTI2Q4BamIiFLzk6n5kLq0K4r22l9wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773530121; c=relaxed/simple;
	bh=Jc4c5RWWlpyz+Y/xM6h2GZ3gmh1zFT1BVla0vTnmSUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qK1qhzhViRjjWRySxEQXHNI66NftEIRJ3uG0J6RE+/v95iO+vCSBfvuxD3gg5CTqVrVxlumbXKsre0ZWqN73if766LSNH0DJJcPAhWAaD6DCm0lt5qYMoOrckyoF2PazUG4WtoCtJt3GuztlQAGvqyxpnBKduoU4VT1NmA2qKqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKEaM76N; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKEaM76N"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso29373495e9.2
        for <linux-security-module@vger.kernel.org>; Sat, 14 Mar 2026 16:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773530117; x=1774134917; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+gDeE4P/6IdgnuTY6X2lFCljhSpvptcxebxvlgeFOaE=;
        b=bKEaM76NmNKJmF//OxQgDNcC+CcfbcQZ/VSwUPv3LN5bk0qz0ii3VY0dXG9erETY5V
         fvEn2Tc7ff56DEXSEpL1hfhxUvyrX9guzOPOEEDDcNclHKaYt9wwCzgSo/T3E1a829Ko
         fuQ3sZe5TKdvKljXxNW88ZaEpgyq1K6cCqsTlcKtynumSPLnNpAVAARkI4QaETWBuql/
         P2SDzKe/36qgN1EggzuQmSoQZPrBHXp8ELBZ0nshMsawjs6urxR1PEwGuDhH3wXLVOlb
         rEjaIqz0i0vXE9jy36VVobDhyr1iBsIzSPp1KprfD2w5n7FMf16uGrVskkq7SHXO0YsA
         lQUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773530117; x=1774134917;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+gDeE4P/6IdgnuTY6X2lFCljhSpvptcxebxvlgeFOaE=;
        b=aRzwNROawcRmYuZoeBW0FMh3Ws/qnhThtt6BpGOL4311FFHZUi50dS6mDGnPcTdGGh
         9527TtLQ4/AV2VJi8acHCsdHWbao3y/wSRDt4Uhj4ieFK/NcnNBISkzvqOIhmySXHBWg
         3IJOtTQMdQTqDUVoLrGvs+XaIa6QvbVNsVFXf+NjOTRG5rk+CugEnk0F1BRJK/D8kHYa
         CZnPbeWBGF6m6bEmaKFRd3Xwd2iwbiFHR3Y878cdBOw/tKiHhhyR1BmIR/Ngg1FWFIkE
         Zd7+DHRwXsjcRlOpruffThq2uNhDmy6bU9YY1QKeFJ34vK7FDklinH0xb6WxJm/blDXQ
         jFmw==
X-Forwarded-Encrypted: i=1; AJvYcCUfo5m644DKzXVYltrapVf1Y9JsfA18T4/QJFH19ODPQNv2Ac6OAmsWB7csO1lsdIHBdVReRwfhO9VnPc2kc/5BJqtJ7GQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxnSgLlGwe1CA+IsoMmHw7Kjh+JmFB5vFBIfZO0WwvwIklbhQ7
	jr/AiZdCh9bl7cuN4vjN02hFYqOr5DbiA79uPKKecE7XkNq0p369/a0k
X-Gm-Gg: ATEYQzxImCTzDP4ZUgIhXssP3zZ6LYAJwEbWBe6fj+vyRncI0lDo+asz11j0SOb7o+h
	2gmQ6w3qgr3WaQ8DVMYf+9hNmxXf737G6Sw3h9Mi5ce9V9PBksirt5QpnrmlxaG3dx2d8i35hiI
	kRca2TPJqGCeaSCvRCbJn83ss83pUJmZy3NVJZMWAeHVH4CvRRp4scghhhYTaCWfZ38XdpqZaAS
	xtMq1mcSMBFu6M6K8uH5+3jvqvAlmL9tVBFNHebYk0Ws6TE1YkSrT3I3x9YsmeX6g7FSfaSq5S1
	3pIJSAHpQFCbipCQsEekQStxaGoGGtOa1QFtUC5p+UM2ooCqcNDnSAfXGSfr1Kf3nEHyeEK0moX
	BWCf373RNVDiEUkIxYPIxQ+rlyjN+214fVOnJBDX0aXxI6Y2jT/cqOO+EFxmphXagXZxe4MtZVa
	Fe7QRrmRrmyTWaRnvYSGKs0tjmXUC6JzuECw/nC274UsD8DO9aZP8veQ/079g=
X-Received: by 2002:a05:600c:1d24:b0:485:379b:57bb with SMTP id 5b1f17b1804b1-485566c69a5mr135014035e9.3.1773530117143;
        Sat, 14 Mar 2026 16:15:17 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48557c6ce2fsm53196905e9.25.2026.03.14.16.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 16:15:16 -0700 (PDT)
Date: Sun, 15 Mar 2026 00:15:10 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
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
Message-ID: <20260314.f83f9a697865@gnoack.org>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-3-gnoack3000@gmail.com>
 <20260217.lievaS8eeng8@digikod.net>
 <20260219.IF4zee3Quo3j@digikod.net>
 <aZcXSmhZRVcRCvum@google.com>
 <20260307.aeth4weik2Ah@digikod.net>
 <20260308.IexeiQuae7ee@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260308.IexeiQuae7ee@digikod.net>

On Sun, Mar 08, 2026 at 12:50:06PM +0100, Mickaël Salaün wrote:
> On Sun, Mar 08, 2026 at 10:09:52AM +0100, Mickaël Salaün wrote:
> > On Thu, Feb 19, 2026 at 02:59:38PM +0100, Günther Noack wrote:
> > > On Thu, Feb 19, 2026 at 10:45:44AM +0100, Mickaël Salaün wrote:
> > > > On Wed, Feb 18, 2026 at 10:37:16AM +0100, Mickaël Salaün wrote:
> > > > > On Sun, Feb 15, 2026 at 11:51:50AM +0100, Günther Noack wrote:
> > > > > > * Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
> > > > > >   controls the look up operations for named UNIX domain sockets.  The
> > > > > >   resolution happens during connect() and sendmsg() (depending on
> > > > > >   socket type).
> > > > > > * Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
> > > > > >   LSM hook.  Make policy decisions based on the new access rights
> > > > > > * Increment the Landlock ABI version.
> > > > > > * Minor test adaptions to keep the tests working.
> > > > > > 
> > > > > > With this access right, access is granted if either of the following
> > > > > > conditions is met:
> > > > > > 
> > > > > > * The target socket's filesystem path was allow-listed using a
> > > > > >   LANDLOCK_RULE_PATH_BENEATH rule, *or*:
> > > > > > * The target socket was created in the same Landlock domain in which
> > > > > >   LANDLOCK_ACCESS_FS_RESOLVE_UNIX was restricted.
> > > > > > 
> > > > > > In case of a denial, connect() and sendmsg() return EACCES, which is
> > > > > > the same error as it is returned if the user does not have the write
> > > > > > bit in the traditional Unix file system permissions of that file.
> > > > > > 
> > > > > > This feature was created with substantial discussion and input from
> > > > > > Justin Suess, Tingmao Wang and Mickaël Salaün.
> > > > > > 
> > > > > > Cc: Tingmao Wang <m@maowtm.org>
> > > > > > Cc: Justin Suess <utilityemal77@gmail.com>
> > > > > > Cc: Mickaël Salaün <mic@digikod.net>
> > > > > > Suggested-by: Jann Horn <jannh@google.com>
> > > > > > Link: https://github.com/landlock-lsm/linux/issues/36
> > > > > > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > > > > > ---
> > > > > >  include/uapi/linux/landlock.h                |  10 ++
> > > > > >  security/landlock/access.h                   |  11 +-
> > > > > >  security/landlock/audit.c                    |   1 +
> > > > > >  security/landlock/fs.c                       | 102 ++++++++++++++++++-
> > > > > >  security/landlock/limits.h                   |   2 +-
> > > > > >  security/landlock/syscalls.c                 |   2 +-
> > > > > >  tools/testing/selftests/landlock/base_test.c |   2 +-
> > > > > >  tools/testing/selftests/landlock/fs_test.c   |   5 +-
> > > > > >  8 files changed, 128 insertions(+), 7 deletions(-)
> > > > 
> > > > > > index 60ff217ab95b..8d0edf94037d 100644
> > > > > > --- a/security/landlock/audit.c
> > > > > > +++ b/security/landlock/audit.c
> > > > > > @@ -37,6 +37,7 @@ static const char *const fs_access_strings[] = {
> > > > > >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_REFER)] = "fs.refer",
> > > > > >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_TRUNCATE)] = "fs.truncate",
> > > > > >  	[BIT_INDEX(LANDLOCK_ACCESS_FS_IOCTL_DEV)] = "fs.ioctl_dev",
> > > > > > +	[BIT_INDEX(LANDLOCK_ACCESS_FS_RESOLVE_UNIX)] = "fs.resolve_unix",
> > > > > >  };
> > > > > >  
> > > > > >  static_assert(ARRAY_SIZE(fs_access_strings) == LANDLOCK_NUM_ACCESS_FS);
> > > > > > diff --git a/security/landlock/fs.c b/security/landlock/fs.c
> > > > > > index e764470f588c..76035c6f2bf1 100644
> > > > > > --- a/security/landlock/fs.c
> > > > > > +++ b/security/landlock/fs.c
> > > > > > @@ -27,6 +27,7 @@
> > > > > >  #include <linux/lsm_hooks.h>
> > > > > >  #include <linux/mount.h>
> > > > > >  #include <linux/namei.h>
> > > > > > +#include <linux/net.h>
> > > > > >  #include <linux/path.h>
> > > > > >  #include <linux/pid.h>
> > > > > >  #include <linux/rcupdate.h>
> > > > > > @@ -314,7 +315,8 @@ static struct landlock_object *get_inode_object(struct inode *const inode)
> > > > > >  	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > > > > >  	LANDLOCK_ACCESS_FS_READ_FILE | \
> > > > > >  	LANDLOCK_ACCESS_FS_TRUNCATE | \
> > > > > > -	LANDLOCK_ACCESS_FS_IOCTL_DEV)
> > > > > > +	LANDLOCK_ACCESS_FS_IOCTL_DEV | \
> > > > > > +	LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
> > > > > >  /* clang-format on */
> > > > > >  
> > > > > >  /*
> > > > > > @@ -1561,6 +1563,103 @@ static int hook_path_truncate(const struct path *const path)
> > > > > >  	return current_check_access_path(path, LANDLOCK_ACCESS_FS_TRUNCATE);
> > > > > >  }
> > > > > >  
> > > > > > +/**
> > > > > > + * unmask_scoped_access - Remove access right bits in @masks in all layers
> > > > > > + *                        where @client and @server have the same domain
> > > > > > + *
> > > > > > + * This does the same as domain_is_scoped(), but unmasks bits in @masks.
> > > > > > + * It can not return early as domain_is_scoped() does.
> > > > 
> > > > Why can't we use the same logic as for other scopes?
> > > 
> > > The other scopes, for which this is implemented in domain_is_scoped(),
> > > do not need to do this layer-by-layer.
> > > 
> > > I have to admit, in my initial implementation, I was using
> > > domain_is_scoped() directly, and the logic at the end of the hook was
> > > roughly:
> > > 
> > >    --- BUGGY CODE START ---
> > >        // ...
> > >        
> > >        if (!domain_is_scoped(..., ..., LANDLOCK_ACCESS_FS_RESOLVE_UNIX))
> > >            return 0;  /* permitted */
> > > 
> > >        return current_check_access_path(path, LANDLOCK_ACCESS_FS_RESOLVE_UNIX)
> > >    }
> > >    --- BUGGY CODE END ---
> > > 
> > > Unfortunately, that is a logic error though -- it implements the formula
> > > 
> > >    Access granted if:
> > >    (FOR-ALL l ∈ layers scoped-access-ok(l)) OR (FOR-ALL l ∈ layers path-access-ok(l))     (WRONG!)
> > > 
> > > but the formula we want is:
> > > 
> > >    Access granted if:
> > >    FOR-ALL l ∈ layers (scoped-access-ok(l) OR path-access-ok(l))     (CORRECT!)
> > 
> > It is worth it to add this explanation to the unmask_scoped_access()
> > description, also pointing to the test that check this case.
> > 
> > > 
> > > This makes a difference in the case where (pseudocode):
> > > 
> > >    1. landlock_restrict_self(RESOLVE_UNIX)  // d1
> > >    2. create_unix_server("./sock")
> > >    3. landlock_restrict_self(RESOLVE_UNIX, rule=Allow(".", RESOLVE_UNIX))  // d2
> > >    4. connect_unix("./sock")
> > > 
> > >    ,------------------------------------------------d1--,
> > >    |                                                    |
> > >    |    ./sock server                                   |
> > >    |       ^                                            |
> > >    |       |                                            |
> > >    |  ,------------------------------------------d2--,  |
> > >    |  |    |                                         |  |
> > >    |  |  client                                      |  |
> > >    |  |                                              |  |
> > >    |  '----------------------------------------------'  |
> > >    |                                                    |
> > >    '----------------------------------------------------'
> > > 
> > > (BTW, this scenario is covered in the selftests, that is why there is
> > > a variant of these selftests where instead of applying "no domain", we
> > > apply a domain with an exception rule like in step 3 in the pseudocode
> > > above.  Applying that domain should behave the same as applying no
> > > domain at all.)
> > > 
> > > Intuitively, it is clear that the access should be granted:
> > > 
> > >   - d1 does not restrict access to the server,
> > >     because the socket was created within d1 itself.
> > >   - d2 does not restrict access to the server,
> > >     because it has a rule to allow it
> > > 
> > > But the "buggy code" logic above comes to a different conclusion:
> > > 
> > >   - the domain_is_scoped() check denies the access, because the server
> > >     is in a more privileged domain relative to the client domain.
> > >   - the current_check_access_path() check denies the access as well,
> > >     because the socket's path is not allow-listed in d1.
> > > 
> > > In the 'intuitive' reasoning above, we are checking d1 and d2
> > > independently of each other.  While Landlock is not implemented like
> > > that internally, we need to stay consistent with it so that domains
> > > compose correctly.  The way to do that is to track is access check
> > > results on a per-layer basis again, and that is why
> > > unmask_scoped_access() uses a layer mask for tracking.  The original
> > > domain_is_scoped() does not use a layer mask, but that also means that
> > > it can return early in some scenarios -- if for any of the relevant
> > > layer depths, the client and server domains are not the same, it exits
> > > early with failure because it's overall not fulfillable any more.  In
> > > the RESOLVE_UNIX case though, we need to remember in which layers we
> > > failed (both high an low ones), because these layers can still be
> > > fulfilled with a PATH_BENEATH rule later.
> > > 
> > > Summary:
> > > 
> > > Option 1: We *can* unify this if you want.  It just might come at a
> > > small performance penalty for domain_is_scoped(), which now uses the
> > > larger layer mask data structure and can't do the same early returns
> > > any more as before.
> > > 
> > > Option 2: Alternatively, if we move the two functions into the same
> > > module, we can keep them separate but still test them against each
> > > other to make sure they are in-line:
> > > 
> > > This invocation should return true...
> > > 
> > >   domain_is_scoped(cli, srv, access)
> > > 
> > > ...in the exactly the same situations where this invocation leaves any
> > > bits set in layer_masks:
> > > 
> > >   landlock_init_layer_masks(dom, access, &layer_masks, LL_KEY_INODE);
> > >   unmask_scoped_access(cli, srv, &layer_masks, access);
> > > 
> > > What do you prefer?
> > 
> > I was thinking about factoring out domain_is_scoped() with
> > unmask_scoped_access() but, after some tests, it is not worth it.  Your
> > approach is simple and good.
> > 
> > > 
> > > 
> > > > > > + *
> > > > > > + * @client: Client domain
> > > > > > + * @server: Server domain
> > > > > > + * @masks: Layer access masks to unmask
> > > > > > + * @access: Access bit that controls scoping
> > > > > > + */
> > > > > > +static void unmask_scoped_access(const struct landlock_ruleset *const client,
> > > > > > +				 const struct landlock_ruleset *const server,
> > > > > > +				 struct layer_access_masks *const masks,
> > > > > > +				 const access_mask_t access)
> > > > > 
> > > > > This helper should be moved to task.c and factored out with
> > > > > domain_is_scoped().  This should be a dedicated patch.
> > > > 
> > > > Well, if domain_is_scoped() can be refactored and made generic, it would
> > > > make more sense to move it to domain.c
> > > > 
> > > > > 
> > > > > > +{
> > > > > > +	int client_layer, server_layer;
> > > > > > +	const struct landlock_hierarchy *client_walker, *server_walker;
> > > > > > +
> > > > > > +	if (WARN_ON_ONCE(!client))
> > > > > > +		return; /* should not happen */
> > 
> > Please no comment after ";"
> > 
> > > > > > +
> > > > > > +	if (!server)
> > > > > > +		return; /* server has no Landlock domain; nothing to clear */
> > > > > > +
> > > > > > +	client_layer = client->num_layers - 1;
> > > > > > +	client_walker = client->hierarchy;
> > > > > > +	server_layer = server->num_layers - 1;
> > > > > > +	server_walker = server->hierarchy;
> > > > > > +
> > > > > > +	/*
> > > > > > +	 * Clears the access bits at all layers where the client domain is the
> > > > > > +	 * same as the server domain.  We start the walk at min(client_layer,
> > > > > > +	 * server_layer).  The layer bits until there can not be cleared because
> > > > > > +	 * either the client or the server domain is missing.
> > > > > > +	 */
> > > > > > +	for (; client_layer > server_layer; client_layer--)
> > > > > > +		client_walker = client_walker->parent;
> > > > > > +
> > > > > > +	for (; server_layer > client_layer; server_layer--)
> > > > > > +		server_walker = server_walker->parent;
> > > > > > +
> > > > > > +	for (; client_layer >= 0; client_layer--) {
> > > > > > +		if (masks->access[client_layer] & access &&
> > > > > > +		    client_walker == server_walker)
> > 
> > I'd prefer to first check client_walker == server_walker and then the
> > access.  My main concern is that only one bit of access matching
> > masks->access[client_layer] clear all the access request bits.  In
> > practice there is only one, for now, but this code should be more strict
> > by following a defensive approach.

This function works even if multiple access request bits with
"scope-like" semantics were being checked in parallel; if you consider
the logic in:

  if (masks->access[client_layer] & access &&
      client_walker == server_walker)
          masks->access[client_layer] &= ~access;

you'll realize that the check for "masks->access[client_layer] &
access" is technically irrelevant - if that check fails, all the
affected bits are already zero, so clearing them is a no-op.  This
code is equivalent, but might perform slightly more writes (although
it likely does not make a performance difference in practice):

  if (client_walker == server_walker)
          masks->access[client_layer] &= ~access;

With that code it's a bit easier to see that "access" is actually only
used to decide which bits to clear.  This works both with one and with
multiple access rights.

This follows the same logic as outlined in the comment above in the
code, where it says:

    Clears the access bits at all layers where the client domain is the
    same as the server domain.  We start the walk at min(client_layer,
    server_layer).  The layer bits until there can not be cleared because
    either the client or the server domain is missing.

Clearing bits that aren't there is a no-op



<Optional Math>

I found it helpful to visualize the scoping logic, this is directly
from my notes: (Web version is at https://wiki.gnoack.org/LandlockDomainIsScoped)

The domain_is_scoped() helper implements the following predicate:

  ∀ l ∈ (0,16): (hasbit(self, l) implies-that domain(self, l) == domain(other, l))

That is, we require for each layer l nesting depth that:

  * **If** scoping is active at the layer,
  * **Then** the domains of self and other are the same
             at the given nesting depth.

For example:

       [ ]
        |
       [x]     self and other have the same domain at this depth
        |
       [ ]
      /   \
    [x]   [ ]  self and other have differing domains at this depth
     |     |
    [ ]   [ ]
     |
    [ ]     "other"             "x" marks a domain where "self" has
                                    set the scoping bit
  "self"

</Optional Math>


> > > > > > +			masks->access[client_layer] &= ~access;
> 
> Actually, why not removing the access argument and just reset
> masks->access[client_layer]?  The doc would need some updates.

It would feel brittle to me if this function were to clear out
unrelated access rights. It receives a struct layer_access_masks after
all, where it is normally expected that multiple kinds of access
rights are set.  In my understanding, the bit masking does not cost
much extra performance compared to clearing it out entirely, so I'd
prefer to have clearer semantics and only operate on the access rights
that it's about, even when the other bits are all zero at the moment.

(For full disclosure, I have contemplated for a bit whether
hook_unix_find() should take a layer_mask_t-like type where each bit
indicates whether a given access right
(LANDLOCK_ACCESS_FS_RESOLVE_UNIX, in this case) is set at a given
layer, and then it would only clear out the bits there.  That would be
in some ways simpler, but then the caller would still need to convert
back and forth to a layer mask anyway, because that's what the other
functions there take.  So it didn't seem like a good option in the
bigger scheme (and I would also prefer to not re-introduce
layer_mask_t after we just removed it).)

Maybe I did not understand your remark fully though;
Does my argument sound reasonable?

–Günther
