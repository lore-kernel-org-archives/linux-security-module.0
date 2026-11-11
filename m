Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397824;
	b=IyBU9MKwuCYAhPB5hrptEaOc56+/OHfuRBjEPayrgPjH8vAGMGV3xAK4tSiSQsFigpub
	 x9EwTkrg2EJYjMGkOEYKMVKP9SagIe+TK7n0TsokoQdtfg+5SD6YFEP23cQ+yOepw7QBy
	 FCRwJ9+K//kBXanl/VNQsi9rIpQk+OgSvtAAfVg8LAPvGt02N3hKbIhx+3V1pTp/M4oBJ
	 iS9w6seJQMbxfKPCil/+0ylobMhxqouaepO4wUOBBRqAPaq/FzGw8J6RNnylcUlQHX08t
	 kb1IPQxU1eEpSTIB8Ei2Q/crgzZ6Ub0+k8RlcvPI5nkiLYw40fjhaGBumnnH0HTaztg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397824;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=Dc2ur1eEMfadZarhXVKmuwAoygldop+kYoP3/kwySV8=;
	b=bCNa+GN4Y7IXqw+kiy3QjLcrVk/6m83rAITX7KJd+saT06/T5s9UR0u5D4189UMfeLrN
	 9pQVep41C/QTH5vXKC69M0M2ympoFp4viyVKaZ9ixpHSPn7K9LVr8l0ARw5u7dtMHRTym
	 kPHCweRoZU6hplU2AvMyEHcM1BotGBlZQdEzNj784VtOSjHbb7CE/Klyi7cbF8+53a778
	 Zk5ztpgI4sPlMHos/iT/LY9ekBCVe6+XnEUDHThqNAkDT+Jq200vJBKXEpDhcY8DxTIrC
	 290waK9ogzTcXSY5hVPYJA1oOE8utkImKSH3sHoPaK1Nc923heZlb9ASnzRMsluzNNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxuuVLWZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE82606A31C;
	Wed, 11 Nov 2026 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DxuuVLWZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A3B1F00A05;
	Wed, 11 Nov 2026 11:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794397823;
	bh=Dc2ur1eEMfadZarhXVKmuwAoygldop+kYoP3/kwySV8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=DxuuVLWZj9vISmmJgHpsejaNRq3UNlVxCxqVv4qGP+SMXHiNjgPu6ucXJKneOg+bm
	 gmd7AK38KeerJNzqp1omiPRo+GRrlYd3rsLYB0eTc6Aq3QE2EdIGr1/hqXLQSB1Yy1
	 /nLOg2nF8tBJtQ0Bxl6YnziNdYJAehMbv8bTPjwUZ6yKYBA0OxHaS1jVPdihsv9vaQ
	 io8i1bz4mhQmGfDBzp50V7xloyHp2xmBcIXoxNXk9tt8uZMrFm4GYEn/qRPc9p6dyX
	 7/NVRB6Tl/3ioYO/AIgYWuOe+f3KpK+TQjHH0OmOfte1NUN+LDlmQW3lV3fjmknMiF
	 ZKAQEcDrtoM4Q==
Date: Wed, 11 Nov 2026 12:50:19 +0100
From: Christian Brauner <brauner@kernel.org>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Jann Horn <jannh@google.com>, 
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	Justin Suess <utilityemal77@gmail.com>
Subject: Re: landlock bug: procfs denials because inodes have unstable
 identity
Message-ID: <20261111-fassen-sanduhr-waage-d8afda23f703@brauner>
References: <auS7gAFy13EOp_Zt@google.com>
 <CAG48ez2e607HNArcX_xA9UTv_u1tvThLwW2kDvnejHcx4A80KA@mail.gmail.com>
 <20261105.gai4OeWungae@digikod.net>
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
In-Reply-To: <20261105.gai4OeWungae@digikod.net>

On Thu, Nov 05, 2026 at 10:34:02PM +0100, Mickaël Salaün wrote:
> On Wed, Nov 04, 2026 at 08:47:14PM +0100, Jann Horn wrote:
> > On Fri, Oct 30, 2026 at 4:45 PM Günther Noack <gnoack@google.com> wrote:
> > > The Landlock LSM lets processes define policies which are attached to
> > > struct inode objects internally.  As a consequence, if filesystems
> > > forget these inodes and start using new inode objects for the same
> > > files or directories later on, these policies do not work as intended
> > > any more.
> > >
> > > As it turns out, procfs has that property as well and can lose inode
> > > identities over time, even though it does not happen immediately.
> > 
> > Right; basically, dentries can be dropped from caches while the
> > corresponding inodes still exist. In normal filesystems, dentry lookup
> > rediscovers already-existing inodes, but procfs calls new_inode() for
> > non-persistent dentries from several places without checking whether
> > an equivalent inode already exists, which works because procfs doesn't
> > really tie any state to inodes. new_inode() is called from these
> > places for non-persistent dentries:
> > 
> >  - proc_pid_make_inode
> >  - proc_get_inode
> >  - proc_sys_make_inode
> > 
> > File systems that care about having something like a 1:1 relationship
> > between an inode and the object it refers to can instead use
> > mechanisms like path_from_stashed() or iget_locked().
> > 
> > > In my understanding, this is not intended.  Landlock has explicit
> > > selftests to exercise that Landlock policies work in Procfs.
> > 
> > I think from the procfs perspective, it's currently an intentional
> > design choice that simplifies procfs implementation.
> 
> I don't understand why it could help to have a weak mapping between
> inode and a path while the inode is still referenced.

It simplifies the implementation as Jann quite a bit.

> Christian, what do you think would be possible?

I think anything that request changes to how procfs lookup handles needs
to proof that a) it is a general improvement and b) that it doesn't
impact performance meaningfully.

Even if you make use of the 64-bit pidfd inode number in struct pid
you'd have to have a lookup data structure. And that will cost no matter
how you spin it and in general we're not very forthcoming when it comes
to degrading subsystem performance for special-purpose consumers.

> > > For reference, similar issues have been investigated also for hostfs
> > > [1] and 9p [2]:
> > >
> > > [1] https://lore.kernel.org/all/20230309165455.175131-2-mic@digikod.net/
> > > [2] https://lore.kernel.org/all/cover.1756935780.git.m@maowtm.org/
> > >
> > >
> > > Steps to reproduce
> > > ==================
> > >
> > > Process A:
> > >
> > > * Enter a Landlock domain where access to /proc/sys/kernel/random
> > >   (and files below it) is allowed.
> > > * Repeatedly open and close the boot_id file from that same directory
> > >
> > > At the same time, the dentry caches get freed up.
> > > We can emulate this by writing to /proc/sys/vm/drop_caches from
> > > another (root) process:
> > >
> > > # echo 2 > /proc/sys/vm/drop_caches
> > >
> > > Observed result: Process A fails because of a Landlock refusal opening
> > >   the boot_id file.  When Landlock walks the path for the check, the
> > >   inodes have now a different identity than before and don't match, so
> > >   Landlock denies the operation.
> > >
> > > Expected result: Dropping the caches should not affect Landlock's
> > >   behaviour.
> > >
> > > At the bottom of this email, I am including the source code for a
> > > program that does Process A -- you can run this to reproduce, and then
> > > write into the drop_caches file from another process as root.
> > >
> > >
> > > Solution...?
> > > ============
> > >
> > > I don't have a fix for it yet.
> > >
> > > I am open to suggestions.  Is this feasible to change in procfs?
> > 
> > A landlock domain is supposed to be usable for a hierarchy of multiple
> > processes, and for that usecase, if all those processes want a working
> > /proc/self, landlock currently can't meaningfully restrict procfs
> > beyond what is done implicitly through ptrace access checks, right? I
> > think if there is a desire to have fine-grained landlock policies for
> > procfs, that would first require some design decisions on how procfs
> > peculiarities like per-process directories should be handled.
> > I imagine one option would be to add a mechanism that automatically
> > grants full access to {procfs mount}/$pid of all in-domain pids, and
> > then consider whether sysctls should have persistent dentries or

Meh, there's 1775 sysctls on my system alone. Making them permanent
means they remain pinned and waste memory. kernfs avoids that because it
pins kernfs nodes which is 136 bytes. An inode is about 650 bytes. If
you pin all of then you're already wasting 1MB. Why do you want to make
Ram Altman unhappy?

> > something like that?
> 
> I agree, it would be useful (and it has been requested) to properly handle
> procfs.  I think the "scope" interface would make sense to access
> process/thread-related resources.  Other kind of files/directory should
> use the current path_beneath mechanism, and I'm wondering if identifying
> these kind of files is already reliable (vs the process-related files).
> 
> > 
> > > —Günther
> > >
> > >
> > >
> > > Reproducer program, for easier reproduction (don't forget to drop
> > > caches in parallel):
> > [...]
> > 
> 

-- 
