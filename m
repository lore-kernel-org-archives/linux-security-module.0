Received: from smtp-bc08.mail.infomaniak.ch (smtp-bc08.mail.infomaniak.ch [45.157.188.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C433537DA
	for <linux-security-module@vger.kernel.org>; Sun,  8 Mar 2026 09:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.157.188.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772961382; cv=none; b=g2MvVRz2ZB3/OnC83Ri8oSOAtjePTmb3lq8nOx00+IO8muHNh3JPOssyEKU5G9it9yCyZnE4LWskcgakifdVb/jWLXgWX/d0oGarrTvlUBmE0rVcQcU4NBDsAMCxzSgf3sfNeDEbA8Sj40PgtXHLazAfztCooIrutHtgvXgbkcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772961382; c=relaxed/simple;
	bh=dY7aV8PjEJFsNWzIYqg5PC3zubmmReQdXvvnh5Ksnbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ti1q+BJHq3Zp71KjLbZtK397wV2sVLEI/om/KssyPJmyMWcsVQrH9LPGz63wpibnad/0dUalYYgfPGZGCaXu4v1We0xd8j13UuCVPK4POoutvWJZJJZo+EGBjhoP5TWIIGZ6onunY2DkDI+vRVBhdpr2aZ3odP8J/GSD+45Qn18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=wQKK3t2n; arc=none smtp.client-ip=45.157.188.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="wQKK3t2n"
Received: from smtp-3-0000.mail.infomaniak.ch (smtp-3-0000.mail.infomaniak.ch [10.4.36.107])
	by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4fTDqH3n0yz8XS;
	Sun,  8 Mar 2026 10:09:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1772960971;
	bh=ixxX42SudKgPtlOFhWAtbUdAT0D5WwMCtN2JoO9Goxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wQKK3t2nAEAoJv2il4+Ms7IOiDUDgj4BK/QNpCJZ6vSf641tsCG2gGry2vXIJQOkO
	 C/wgReSAb5S8Yn0y+HUcUgSQr6DPGkfOE268zbVZPrsBBflx0Ok6Fv+ZX2/J8oNYod
	 DUUu2HjukV4FjL5XOn8243Vtnge5kRYOyNwiZOf8=
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4fTDqG50dkzkRr;
	Sun,  8 Mar 2026 10:09:30 +0100 (CET)
Date: Sun, 8 Mar 2026 10:09:21 +0100
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
Message-ID: <20260308.zie6thaiP0aj@digikod.net>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-3-gnoack3000@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260215105158.28132-3-gnoack3000@gmail.com>
X-Infomaniak-Routing: alpha

On Sun, Feb 15, 2026 at 11:51:50AM +0100, Günther Noack wrote:
> * Add a new access right LANDLOCK_ACCESS_FS_RESOLVE_UNIX, which
>   controls the look up operations for named UNIX domain sockets.  The
>   resolution happens during connect() and sendmsg() (depending on
>   socket type).
> * Hook into the path lookup in unix_find_bsd() in af_unix.c, using a
>   LSM hook.  Make policy decisions based on the new access rights
> * Increment the Landlock ABI version.
> * Minor test adaptions to keep the tests working.
> 
> With this access right, access is granted if either of the following
> conditions is met:
> 
> * The target socket's filesystem path was allow-listed using a
>   LANDLOCK_RULE_PATH_BENEATH rule, *or*:
> * The target socket was created in the same Landlock domain in which
>   LANDLOCK_ACCESS_FS_RESOLVE_UNIX was restricted.
> 
> In case of a denial, connect() and sendmsg() return EACCES, which is
> the same error as it is returned if the user does not have the write
> bit in the traditional Unix file system permissions of that file.

It is not the same error code as for scoped abstract unix socket
(EPERM), but it makes sense because the scope restrictions are closer to
ambient rights (i.e. similar to a network isolation), whereas here the
final denial comes from a missing FS rule (and all FS access checks may
return EACCES).  It would be worth mentioning this difference in the
user documentation.

> 
> This feature was created with substantial discussion and input from
> Justin Suess, Tingmao Wang and Mickaël Salaün.
> 
> Cc: Tingmao Wang <m@maowtm.org>
> Cc: Justin Suess <utilityemal77@gmail.com>
> Cc: Mickaël Salaün <mic@digikod.net>
> Suggested-by: Jann Horn <jannh@google.com>
> Link: https://github.com/landlock-lsm/linux/issues/36
> Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> ---
>  include/uapi/linux/landlock.h                |  10 ++
>  security/landlock/access.h                   |  11 +-
>  security/landlock/audit.c                    |   1 +
>  security/landlock/fs.c                       | 102 ++++++++++++++++++-
>  security/landlock/limits.h                   |   2 +-
>  security/landlock/syscalls.c                 |   2 +-
>  tools/testing/selftests/landlock/base_test.c |   2 +-
>  tools/testing/selftests/landlock/fs_test.c   |   5 +-
>  8 files changed, 128 insertions(+), 7 deletions(-)

> +static int hook_unix_find(const struct path *const path, struct sock *other,
> +			  int flags)
> +{
> +	const struct landlock_ruleset *dom_other;
> +	const struct landlock_cred_security *subject;
> +	struct layer_access_masks layer_masks;
> +	struct landlock_request request = {};
> +	static const struct access_masks fs_resolve_unix = {
> +		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> +	};
> +
> +	/* Lookup for the purpose of saving coredumps is OK. */
> +	if (unlikely(flags & SOCK_COREDUMP))
> +		return 0;
> +
> +	/* Access to the same (or a lower) domain is always allowed. */
> +	subject = landlock_get_applicable_subject(current_cred(),
> +						  fs_resolve_unix, NULL);
> +
> +	if (!subject)
> +		return 0;
> +
> +	if (!landlock_init_layer_masks(subject->domain, fs_resolve_unix.fs,
> +				       &layer_masks, LANDLOCK_KEY_INODE))
> +		return 0;
> +
> +	/* Checks the layers in which we are connecting within the same domain. */
> +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> +	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
> +			     fs_resolve_unix.fs);
> +
> +	if (layer_access_masks_empty(&layer_masks))

I don't see the point of this helper and this call wrt the following
is_access_to_paths_allowed() call and the is_layer_masks_allowed()
check.

> +		return 0;
> +
> +	/* Checks the connections to allow-listed paths. */
> +	if (is_access_to_paths_allowed(subject->domain, path,
> +				       fs_resolve_unix.fs, &layer_masks,
> +				       &request, NULL, 0, NULL, NULL, NULL))
> +		return 0;
> +
> +	landlock_log_denial(subject, &request);
> +	return -EACCES;
> +}
