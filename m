Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D941B371057
	for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 20:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773608345; cv=none; b=F3Pu/XkhDA3hZ2gTr6vPLedw5eaS3PQKewh+wZW1rnvY0844mfdlfCk5Ss3X7vJiT1VAiQo3uULHeqzCLqSK4Er82BxpMizyDLlx00qGgRbnEKmaXOk5yS3X1e7G1/bdzkgT5ESFmJVmurWxjeI6eW1+YYXtWyVUGdcuLqWhD7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773608345; c=relaxed/simple;
	bh=3k1PMWAq8SVen9s8I3JcFq8BsZzS8FOA9gTpzngs3Ew=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+I+ohxs5JZs9zYsss9w/+71Ko55RZLEJJ53UfPtdeyZmEBV+Qu/fP9hpq2wSJt9wNqGIxfEH97y+1+PSrCfAfj8D3bnLBIlLenuW3jDKI1lo5iRYzPD9FqeyxSeex86eUEIQRA659afLQDHOc50HfJburx5CqDwAkruUUxTy20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W23xXD5P; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W23xXD5P"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-89a06bc2f1bso70840346d6.1
        for <linux-security-module@vger.kernel.org>; Sun, 15 Mar 2026 13:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773608342; x=1774213142; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HUtD2tnCdB1ksL3ocbjFWjgoV7+dAsNBOcvbL1rIDX0=;
        b=W23xXD5PKztRud/w9sE+ePOQxkoiRGJ77ZOe1TWdNWYYMYYDKWTr/ZSFOTGsgkcZsb
         zC7Rp2se3uz8p+WbSLBfKkeNJLVJzelZmHBzg5f7H4rEXfdtgDyQvCJyBhEKyo+ciSe6
         Z+9La2q8tpp59+TT1UGhztbL1mk9Ip4ks2NvhTgocBLGC9D0YsQInaEYzA5AJOKSp5M9
         9GTU6YN/GaIgRHSTzIf0sVCEaL0CSkDNwc4Om71F1lq1YS+jzv2PBg36pTdv+Zf+hpXv
         lZ7Q/P6JQG7lJ2iQ8r16LaTk2hzLtQMY8l1u8X70sGoPlaM4xRoABze0tYrXAUn/6086
         IjiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773608342; x=1774213142;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUtD2tnCdB1ksL3ocbjFWjgoV7+dAsNBOcvbL1rIDX0=;
        b=DAgH9gwSC+N6rwYNpkUHu/Ipt7rdXAWPymoQetoPFXKnwTYu3tqETObukhffipULsB
         c3uMyF6sSM1Byeito4iYE+jEFbRIZyuwu04psu2k5Ygs88Q6WdgU+ox8+DrVWaWGnZOJ
         W+yV3n0YJOEcu07Km1ycD3En9GRAalnulG71BHsSVbGqZVCBZX/+RIvd6dkkjXnjGVU+
         faKypUUyBmW+jEdk41Q5c1DIxL9DIHwGQlHk2YaiExYbCb389bgsuUYd2Kf8kWqhkZeh
         J++a+raufxiucbJNgMfwO/sBxo42fqkN7ZFVWV3A7I3yWff6vg5LXY7E3LgCCJHnLwx8
         UDTA==
X-Forwarded-Encrypted: i=1; AJvYcCVzud/1ZVszVV+Cm1xyOM85bNRAZQvWXOvradGQd6TC8aGxosQGngGYKnhRv0s6uhSe9SkvSrr+UAWLrpI+Cr4vxvhK9Og=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/wF5dmukYikAl8cBhc32T0VtPkPri6avJxlf7c66NozmWSfdg
	MxV127nABtDi0M/KTG1cF56DoMuHjXv1Ayq9/fjZGq0wb+HET9nZ3jae
X-Gm-Gg: ATEYQzyfuXcVvD5+38XDcopRjAR2ceUvYxKa3XEUFh7CRmFkdJyizSJyzHsIUFG4xK3
	Mx7t9J5MUupxcKIyXH+3PicE1d2p2EdONSJHVp2ratFhSyPMVX5QPH/lOQ3ufHJ7PT+MTVpS5XE
	LIEGnNWCZqCOM5mF1wiuXr/jIAr1JUufbCwBUrzCP5vmiwvwl9UprjvyQGf4zoarStct1G4W1uj
	M7fMHYm77lV+U802UW16weLf0DNubrZbIfFFnk3vy2dUG9GGvIwaLEjcd6hv2zDTmWYeqWv9sy7
	jWB/CcqMFBLtEM6n+h1O/dlUksa3aLEma4st0XRmHjWhw0REXVOE8YY3mtN8pto525zV/vlTSF1
	SFsjlVs1tesi8YJHyHxzDSqiEbV+/qxLEB9YhzSLsjZT01rPfHNS84cFPGXmrSzd2gs991fstnB
	coO7/sWTJomIoQBLIMwb+8cB1NRR68GCoePKXG2P7CWGjl6+KO
X-Received: by 2002:a05:6214:413:b0:899:fab4:7301 with SMTP id 6a1803df08f44-89a81f8be31mr152286206d6.35.1773608342284;
        Sun, 15 Mar 2026 13:59:02 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c5471fc7asm1541806d6.12.2026.03.15.13.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 13:59:01 -0700 (PDT)
Date: Sun, 15 Mar 2026 21:58:53 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
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
Message-ID: <20260315.690dc189df72@gnoack.org>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-3-gnoack3000@gmail.com>
 <20260308.zie6thaiP0aj@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260308.zie6thaiP0aj@digikod.net>

On Sun, Mar 08, 2026 at 10:09:21AM +0100, Mickaël Salaün wrote:
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
> 
> It is not the same error code as for scoped abstract unix socket
> (EPERM), but it makes sense because the scope restrictions are closer to
> ambient rights (i.e. similar to a network isolation), whereas here the
> final denial comes from a missing FS rule (and all FS access checks may
> return EACCES).  It would be worth mentioning this difference in the
> user documentation.

Sounds good, added to the syscall documentation for V6.


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
> 
> > +static int hook_unix_find(const struct path *const path, struct sock *other,
> > +			  int flags)
> > +{
> > +	const struct landlock_ruleset *dom_other;
> > +	const struct landlock_cred_security *subject;
> > +	struct layer_access_masks layer_masks;
> > +	struct landlock_request request = {};
> > +	static const struct access_masks fs_resolve_unix = {
> > +		.fs = LANDLOCK_ACCESS_FS_RESOLVE_UNIX,
> > +	};
> > +
> > +	/* Lookup for the purpose of saving coredumps is OK. */
> > +	if (unlikely(flags & SOCK_COREDUMP))
> > +		return 0;
> > +
> > +	/* Access to the same (or a lower) domain is always allowed. */
> > +	subject = landlock_get_applicable_subject(current_cred(),
> > +						  fs_resolve_unix, NULL);
> > +
> > +	if (!subject)
> > +		return 0;
> > +
> > +	if (!landlock_init_layer_masks(subject->domain, fs_resolve_unix.fs,
> > +				       &layer_masks, LANDLOCK_KEY_INODE))
> > +		return 0;
> > +
> > +	/* Checks the layers in which we are connecting within the same domain. */
> > +	dom_other = landlock_cred(other->sk_socket->file->f_cred)->domain;
> > +	unmask_scoped_access(subject->domain, dom_other, &layer_masks,
> > +			     fs_resolve_unix.fs);
> > +
> > +	if (layer_access_masks_empty(&layer_masks))
> 
> I don't see the point of this helper and this call wrt the following
> is_access_to_paths_allowed() call and the is_layer_masks_allowed()
> check.

layer_access_masks_empty() is indeed the same thing as
is_layer_masks_allowed(), so I removed that implementation again for
V6.

The reason why I was calling this here is so that we can skip the path
walk in the case where the scoped-access check already suffices to
allow the operation.  It is not strictly needed though, so I can
remove it.  It is probably better to implement such a shortcut within
is_access_to_paths_allowed() instead.

Removed the call and the implementation for V6.


> > +		return 0;
> > +
> > +	/* Checks the connections to allow-listed paths. */
> > +	if (is_access_to_paths_allowed(subject->domain, path,
> > +				       fs_resolve_unix.fs, &layer_masks,
> > +				       &request, NULL, 0, NULL, NULL, NULL))
> > +		return 0;
> > +
> > +	landlock_log_denial(subject, &request);
> > +	return -EACCES;
> > +}
