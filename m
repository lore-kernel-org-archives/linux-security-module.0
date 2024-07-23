Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FDCB13D52B
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 23:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721776655; cv=none; b=eqF12WKNqVffVuHuwRfNgRaOUhEMChmyFpFEea0oTvhTC83bNJ8YmvOwE2N8FFbqg0RqWdY7ny8cbE30ZiW3g2KI5ZVhcGDA0wcMwYaP8ne6BExbQODWVSJtjq3vDlCxWkkTg1c1lRXjeKg+3rGy3oag4GL/Ijrx4P2WJt0vzYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721776655; c=relaxed/simple;
	bh=kIEnaaeEGU35ODa3uqp6T8cthoWM41kvWm1c9qPUblM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0gyHxOxUh4Y4SNT8t0EjuVPQbAW/OQgwSnJU2F9BeyVK0eRrW7H7sad0tZcK9Waw9pY8qshnfybUZd4RaNm2PwnPv2V1Xqm/DOxy4x8cpilH7oQhpKVzRwlFj1dWN1u3BMp4usF71j8L8p3Vpw3wGF4q6mbOewMqJWpd51ulkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=sGmt//9E; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sGmt//9E"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-2642cfb2f6aso2156874fac.2
        for <linux-security-module@vger.kernel.org>; Tue, 23 Jul 2024 16:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1721776652; x=1722381452; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm+Jbk/dOKo6otuxH0nvNEGCn7XfDJnF5hiRAojuxYs=;
        b=sGmt//9EaCTBmxXXALVu1H4POu19jOhnVwXJgxO1vEMzv7KOgBXHEjjJSNL+jFY4wG
         7XipCtt8dGBJvPUUeaW+owkFI72N7D0sMvSsZZ85yFGvc6n0/bA5BS8guG7CJhHrdpOI
         gUaZ0mpTLNts5LOwOfjETOlgwzfB+v/tGxrMINImiKh77gzfPbwa/ypgkXCKRKkV1e41
         IKK2PduNTZDtzGKdbKKDqst1Hbpvom6TzmInr7Xdw/L5fXCD6tJTKV0qDQOrVr96FLam
         JnAb1ybLlNPmIhqGlkGKsy2KyQfsiHCWRd1KVzpUr/Y1z8tkF9OQfqOfN/tr5vALUPtH
         KV+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721776652; x=1722381452;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm+Jbk/dOKo6otuxH0nvNEGCn7XfDJnF5hiRAojuxYs=;
        b=HPtO3ToNvO9ytxk/wRkHTbmze7se5yrIxkdeRow0Utqrx0Q6WOmLaLmNzHCpjgPzr4
         LjYLlYNu48RrnWRKvzllFM0nK0JdBAzg5x176YlCOS93nmcuh95oMZZKngG9nwlPKGgk
         2bgkrjsCMbb5XoNPM2QMHq6b24aKx3y2TOEY2DYpIAPURzTz8mMP4Xv9jRFTGkEdY16B
         Xn+kKklxAj3V6Ta+7yM67ECYsZ8xj4uElLK8bHP38JiqbLUARhyAHHVza7DMCDqYHA0C
         3DfsonpQZECmvC6EwSrnxKGd+epojzYj/BCZTNXxZcI5vOMGcyV7Yck2V9pFQsbgbhdE
         82OQ==
X-Forwarded-Encrypted: i=1; AJvYcCWX8VF1yCmBlY+nMVrTZBLvLuHovNEwGFUQpeb6g+zaWOLkvxLkXPmgKZwWo/Jfhx6b0yZyl70A+E6LlfBv28Dsl2Qo6CtlBZbfIJMFnhVy2wxcW40H
X-Gm-Message-State: AOJu0Yw7LA7RCCszvxsBYRB6ujrc2R0SvqUG8xiKlRiuYYPQ5odgFZBT
	BYav/+jdoy+rhJU4xk8I+opz+WLxYA2G0Bg4rHB9FxVQXfP10TAMZ+yndU0/0yRi8Lcd2YjtiM/
	D
X-Google-Smtp-Source: AGHT+IEoJAWyE1+b20yQtGzHuYB4ELmJHuvh+/7cgMAD02Ucm3pElQQQbIv6brHY4wv9bCaaCbjc0A==
X-Received: by 2002:a05:6870:1647:b0:260:f6c3:7c78 with SMTP id 586e51a60fabf-261213a552amr12258679fac.17.1721776652225;
        Tue, 23 Jul 2024 16:17:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-47-239.pa.nsw.optusnet.com.au. [49.181.47.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70d165333c7sm5289154b3a.191.2024.07.23.16.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 16:17:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sWOl7-0091dH-0l;
	Wed, 24 Jul 2024 09:17:29 +1000
Date: Wed, 24 Jul 2024 09:17:29 +1000
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, Matus Jokay <matus.jokay@stuba.sk>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	Mimi Zohar <zohar@linux.ibm.com>,
	Roberto Sassu <roberto.sassu@huawei.com>,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [RFC PATCH] lsm: add the inode_free_security_rcu() LSM
 implementation hook
Message-ID: <ZqA6CeCSXwIyNDMm@dread.disaster.area>
References: <20240710024029.669314-2-paul@paul-moore.com>
 <20240710.peiDu2aiD1su@digikod.net>
 <ad6c7b2a-219e-4518-ab2d-bd798c720943@stuba.sk>
 <CAHC9VhRsZBjs2MWXUUotmX_vWTUbboyLT6sR4WbzmqndKEVe8Q@mail.gmail.com>
 <Zp8k1H/qeaVZOXF5@dread.disaster.area>
 <20240723-winkelmesser-wegschauen-4a8b00031504@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240723-winkelmesser-wegschauen-4a8b00031504@brauner>

On Tue, Jul 23, 2024 at 05:19:40PM +0200, Christian Brauner wrote:
> On Tue, Jul 23, 2024 at 01:34:44PM GMT, Dave Chinner wrote:
> > All accesses to the VFS inode that don't have explicit reference
> > counts have to do these checks...
> > 
> > IIUC, at the may_lookup() point, the RCU pathwalk doesn't have a
> > fully validate reference count to the dentry or the inode at this
> > point, so it seems accessing random objects attached to an inode
> > that can be anywhere in the setup or teardown process isn't at all
> > safe...
> 
> may_lookup() cannot encounter inodes in random states. It will start
> from a well-known struct path and sample sequence counters for rename,
> mount, and dentry changes. Each component will be subject to checks
> after may_lookup() via these sequence counters to ensure that no change
> occurred that would invalidate the lookup just done. To be precise to
> ensure that no state could be reached via rcu that couldn't have been
> reached via ref walk.
> 
> So may_lookup() may be called on something that's about to be freed
> (concurrent unlink on a directory that's empty that we're trying to
> create or lookup something nonexistent under) while we're looking at it
> but all the machinery is in place so that it will be detected and force
> a drop out of rcu and into reference walking mode.

Yes, but...

> When may_lookup() calls inode_permission() it only calls into the
> filesystem itself if the filesystem has a custom i_op->permission()
> handler. And if it has to call into the filesystem it passes
> MAY_NOT_BLOCK to inform the filesystem about this. And in those cases
> the filesystem must ensure any additional data structures can safely be
> accessed under rcu_read_lock() (documented in path_lookup.rst).

The problem isn't the call into the filesystem - it's may_lookup()
passing the inode to security modules where we dereference
inode->i_security and assume that it is valid for the life of the
object access being made.

That's my point - if we have a lookup race and the inode is being
destroyed at this point (i.e. I_FREEING is set) inode->i_security
*is not valid* and should not be accessed by *anyone*.

> Checking inode state flags isn't needed because the VFS already handles
> all of this via other means as e.g., sequence counters in various core
> structs.

I don't think that is sufficient to avoid races with inode teardown.
The inode can be destroyed between the initial dentry count sequence
sampling and the "done processing, check that the seq count is
unchanged" validation to solidify the path.

We've seen this before with ->get_link fast path that stores the
link name in inode->i_link, and both inode->i_link and ->get_link
are accessed during RCU It is documented as such:

	If the filesystem stores the symlink target in ->i_link, the
        VFS may use it directly without calling ->get_link(); however,
        ->get_link() must still be provided.  ->i_link must not be
        freed until after an RCU grace period.  Writing to ->i_link
        post-iget() time requires a 'release' memory barrier.

XFS doesn't use RCU mode ->get_link or use ->i_link anymore, because
its has a corner case in it's inode life cycle since 2007 where it
can recycle inodes before the RCU grace period expires. It took 15
years for this issue to be noticed, but the fix for this specific
symptom is to not allow the VFS direct access to the underlying
filesystem memory that does not follow VFS inode RCU lifecycle
rules.

There was another symptom of this issue - ->get_link changed (i.e.
went to null) on certain types of inode reuse - and that caused
pathwalk to panic on a NULL pointer. Ian posted this fix for the
issue:

https://lore.kernel.org/linux-xfs/164180589176.86426.501271559065590169.stgit@mickey.themaw.net/

Which revalidates the dentry sequence number before calling
->get_link(). This clearly demonstrates we cannot rely on the
existing pathwalk dentry sequence number checks to catch an inode
concurrently moving into I_FREEING state and changing/freeing inode
object state concurrently in a way that affects the pathwalk
operation.

My point here is not about XFS - my point is that every object
attached to an inode that is accessed during a RCU pathwalk *must*
follow the same rules as memory attached to inode->i_link. The only
alternative to that (i.e. if we continue to free RCU pathwalk
visible objects in the evict() path) is to prevent pathwalk from
tripping over I_FREEING inodes.

If we decide that every pathwalk accessed object attached to the
inode needs to be RCU freed, then __destroy_inode() is the wrong
place to be freeing them - i_callback() (the call_rcu() inode
freeing callback) is the place to be freeing these objects. At this
point, the subsystems that own the objects don't have to care about
RCU at all - the objects have already gone through the necessary
grace period that makes them safe to be freed immediately.

That's a far better solution than forcing every LSM and FS developer
to have to fully understand how pathwalk and inode lifecycles
interact to get stuff right...

> It also likely wouldn't help because we'd have to take locks to
> access i_state or sample i_state before calling into inode_permission()
> and then it could still change behind our back. It's also the wrong
> layer as we're dealing almost exclusively with dentries as the main data
> structure during lookup.

Yup, I never said that's how we should fix the problem.  All I'm
stating is that pathwalk vs I_FREEING is currently not safe and that
I_FREEING is detectable from the pathwalk side. This observation
could help provide a solution, but it's almost certainly not the
solution to the problem...

-Dave.
-- 
Dave Chinner
david@fromorbit.com
