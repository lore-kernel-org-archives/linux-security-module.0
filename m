Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=45.157.188.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793914458;
	b=pyUenudzRK+DBU7M+fuPSWbxPFAs7Opcvel8eKT53wmFrDByfDMfaRkeeKGpqBQA5hQM
	 268is2YJ0Fm6YZPqW7BAi20TM3YLc46fEvvh0jBHCy4UO6fTV1rYWRl7gOZTl309lCxfA
	 Vr5rpXoxsZ0bWOwlqOA/SoBZKBB3Z/5ErjB8nZEdPhnBYiykExSQJiWQ49r2WnJy0XK47
	 WbBgsivY9ZHdtWrdUD1QOwZNDN8GPDd2lAND3L3ZofQYFrMnUUp8H11q/86OUmPvkfJDH
	 McKR9pvOzYo5lEoi4HIM8wWseLQlBn1QIp3CxuD9LlouE5CprR1LD6QBbFj4HK0P+cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793914458;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
	 X-Infomaniak-Routing;
	bh=sM8g16qJyhXnwsM/EyHFzFXNkCfztU/zXuBuKwRv5RU=;
	b=c5oGyS5riJWtt8A90AKieyj46VnkvyqU4EgfJdgJvKM8dN+tX2P9oGUVVJq+n28gv/67
	 AXxs15myc8EVJQShp2nn03PqwI4tju6Lw0D2QsGhIEr+wPyQad619XqqrDHfZgZiG1guY
	 Jg+9i8ccjIT4taUgG1yvhVRGElm45Kh5NwF5r4Gp6uFmMBCbFDYJsgb2J7nXWsN6hEBbv
	 W6wbZPDnWDtEwT1nXbMYZHuikKO8Y3klwA8Lbtdnja2H2TEpprzSVWhgQUr6M0bRIjNEl
	 qGsedEmkAttwuPso97dND2yQzV8UTgCIR1qYH3ENqja+QIZWCVndmleQgitNK3LPQxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=digikod.net;
	spf=pass smtp.mailfrom=digikod.net;
	dkim=pass header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=xUVYDsca;
	arc=none smtp.remote-ip=45.157.188.11
Received: from smtp-bc0b.mail.infomaniak.ch (smtp-bc0b.mail.infomaniak.ch [45.157.188.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19E606EE93
	for <linux-security-module@vger.kernel.org>; Thu,  5 Nov 2026 21:34:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE19E606EE93
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=digikod.net header.i=@digikod.net header.a=rsa-sha256 header.s=20191114 header.b=xUVYDsca
Received: from smtp-3-0001.mail.infomaniak.ch (smtp-3-0001.mail.infomaniak.ch [10.4.36.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4jLFtl2phzz16VF;
	Thu,  5 Nov 2026 22:34:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1793914447;
	bh=sM8g16qJyhXnwsM/EyHFzFXNkCfztU/zXuBuKwRv5RU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xUVYDscaB4hwWloda0HBdQTSnm/ebZlh3qEMK+U37ifr0o13rg+RFxt8Q/H1oAR0p
	 q3UhfGazI6wUhKKODe3ckBa2ZZiWIG9yWsJ9m7nM0PEIALXQJAiJo2mw7fnXkiXDr5
	 dMJA+p6r4yuySMiPS2WnF8qCJrP8YS0JhbcniHNg=
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4jLFtk30zBzc3h;
	Thu,  5 Nov 2026 22:34:06 +0100 (CET)
Date: Thu, 5 Nov 2026 22:34:02 +0100
From: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To: Jann Horn <jannh@google.com>, Christian Brauner <brauner@kernel.org>
Cc: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>
Subject: Re: landlock bug: procfs denials because inodes have unstable
 identity
Message-ID: <20261105.gai4OeWungae@digikod.net>
References: <auS7gAFy13EOp_Zt@google.com>
 <CAG48ez2e607HNArcX_xA9UTv_u1tvThLwW2kDvnejHcx4A80KA@mail.gmail.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez2e607HNArcX_xA9UTv_u1tvThLwW2kDvnejHcx4A80KA@mail.gmail.com>
X-Infomaniak-Routing: alpha

On Wed, Nov 04, 2026 at 08:47:14PM +0100, Jann Horn wrote:
> On Fri, Oct 30, 2026 at 4:45 PM Günther Noack <gnoack@google.com> wrote:
> > The Landlock LSM lets processes define policies which are attached to
> > struct inode objects internally.  As a consequence, if filesystems
> > forget these inodes and start using new inode objects for the same
> > files or directories later on, these policies do not work as intended
> > any more.
> >
> > As it turns out, procfs has that property as well and can lose inode
> > identities over time, even though it does not happen immediately.
> 
> Right; basically, dentries can be dropped from caches while the
> corresponding inodes still exist. In normal filesystems, dentry lookup
> rediscovers already-existing inodes, but procfs calls new_inode() for
> non-persistent dentries from several places without checking whether
> an equivalent inode already exists, which works because procfs doesn't
> really tie any state to inodes. new_inode() is called from these
> places for non-persistent dentries:
> 
>  - proc_pid_make_inode
>  - proc_get_inode
>  - proc_sys_make_inode
> 
> File systems that care about having something like a 1:1 relationship
> between an inode and the object it refers to can instead use
> mechanisms like path_from_stashed() or iget_locked().
> 
> > In my understanding, this is not intended.  Landlock has explicit
> > selftests to exercise that Landlock policies work in Procfs.
> 
> I think from the procfs perspective, it's currently an intentional
> design choice that simplifies procfs implementation.

I don't understand why it could help to have a weak mapping between
inode and a path while the inode is still referenced.

Christian, what do you think would be possible?

> 
> > For reference, similar issues have been investigated also for hostfs
> > [1] and 9p [2]:
> >
> > [1] https://lore.kernel.org/all/20230309165455.175131-2-mic@digikod.net/
> > [2] https://lore.kernel.org/all/cover.1756935780.git.m@maowtm.org/
> >
> >
> > Steps to reproduce
> > ==================
> >
> > Process A:
> >
> > * Enter a Landlock domain where access to /proc/sys/kernel/random
> >   (and files below it) is allowed.
> > * Repeatedly open and close the boot_id file from that same directory
> >
> > At the same time, the dentry caches get freed up.
> > We can emulate this by writing to /proc/sys/vm/drop_caches from
> > another (root) process:
> >
> > # echo 2 > /proc/sys/vm/drop_caches
> >
> > Observed result: Process A fails because of a Landlock refusal opening
> >   the boot_id file.  When Landlock walks the path for the check, the
> >   inodes have now a different identity than before and don't match, so
> >   Landlock denies the operation.
> >
> > Expected result: Dropping the caches should not affect Landlock's
> >   behaviour.
> >
> > At the bottom of this email, I am including the source code for a
> > program that does Process A -- you can run this to reproduce, and then
> > write into the drop_caches file from another process as root.
> >
> >
> > Solution...?
> > ============
> >
> > I don't have a fix for it yet.
> >
> > I am open to suggestions.  Is this feasible to change in procfs?
> 
> A landlock domain is supposed to be usable for a hierarchy of multiple
> processes, and for that usecase, if all those processes want a working
> /proc/self, landlock currently can't meaningfully restrict procfs
> beyond what is done implicitly through ptrace access checks, right? I
> think if there is a desire to have fine-grained landlock policies for
> procfs, that would first require some design decisions on how procfs
> peculiarities like per-process directories should be handled.
> I imagine one option would be to add a mechanism that automatically
> grants full access to {procfs mount}/$pid of all in-domain pids, and
> then consider whether sysctls should have persistent dentries or
> something like that?

I agree, it would be useful (and it has been requested) to properly handle
procfs.  I think the "scope" interface would make sense to access
process/thread-related resources.  Other kind of files/directory should
use the current path_beneath mechanism, and I'm wondering if identifying
these kind of files is already reliable (vs the process-related files).

> 
> > —Günther
> >
> >
> >
> > Reproducer program, for easier reproduction (don't forget to drop
> > caches in parallel):
> [...]
> 
