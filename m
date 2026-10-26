Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792999358;
	b=H+Bdst5Xk/H48hMjtzgABCoQGEBiWXn26apxoscJiCEtsxHHTCCIYDzH08E9/H4Vqnup
	 2WmSXsjpFugjam1IvkluzbKE+dBijxe1h2wTtquA3mm5FfskAiJBzCk5Ugf2RKtJ6prx6
	 /ADp2Rg2S1MWAjhVjixijEgDkLu6UUmYJcMycg3NflnqTw/L6bG/ZBo5a5uEwDgXwPY+Y
	 Y3bmwAFvqfWjph7hEEDnNdOZd9j8ZQP01tG3vXF1oatgY2qU5WIxu0F48j665QvZTnFf2
	 +JAPnEwxgU03YsgvvidTfST/xUcmd7noZ+nAist7rxT3BsGqJuhPc4sJrN9Z2SPUWbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792999358;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=HJZtmQZPEueeCiwg4sV5mAgkGS8BZr7Xf8cF5fmkfCA=;
	b=KET6KuquS/F1hQF6YMKE2DpivY9RxRcoWPF/hOxys7/4lkp/v0l5AiZOHLf1QSIkkZSw
	 owcoVFYM2aIGGjL9QhnXBUfd4AwO5AYLfYZevqkNdT2c//Fd0pedenN7wW5fLZBZA98N7
	 xTim4f2nE+86VU29lM9vG8q0rAnOxwP6lLylpYj/dgfEfBWqUMjfqbyfOo2C5KeK4pDCH
	 KuBdvW1t2q8ElU6ew+FMdYcIMx65sZcgI4BXNHqKl9Nw7Q8s9pEPuXbVuDrMBB/JPjTlN
	 l3IjGHXYZFVlLcSVLzLOpGtlsgPMd08De2ObnYkUKIFWrougi8IqVKKq+mULB/ymEaw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PHi3VkvJ;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90057606A31E
	for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 07:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 90057606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PHi3VkvJ
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so15981595e9.2
        for <linux-security-module@vger.kernel.org>; Mon, 26 Oct 2026 00:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792999356; x=1793604156; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HJZtmQZPEueeCiwg4sV5mAgkGS8BZr7Xf8cF5fmkfCA=;
        b=PHi3VkvJzLMPj8R1/whCS+guMKXQNQ7sbyf7+jCM6ssCp7yNs/alG9/dqGX4U5tT65
         wpQParAJvvCWuz//hHzfbPXsJsUAVnpk0zNv1XfIzboShrlBl1BPzm5UWfAE9apaxDPa
         /Bgt0+1z58inytsxoTvxOauRUasdefC8hCtKehHRa4ShYQoFHjfULm1ui6hcE1W+vYfO
         10v9oNYrrmzypnfRNG413fv+YgZl9TyrZ1vXorxqljIgKzr9ZREqNqOLdfr2YQ2Sup3k
         6UOiH3JPhP/D/02GBs7YDgxQEDEkOhFbB/zNGQ7Gg0tNB0wIjXBkcLeO6oqHvPv3njjC
         uHuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792999356; x=1793604156;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HJZtmQZPEueeCiwg4sV5mAgkGS8BZr7Xf8cF5fmkfCA=;
        b=V0nOM9nP/+/CcPO2CfV4agYhJM5RhbsXwioOIH/TowWTDe4vqmKHXdN99PizpgaWgT
         +U0kDx/JnYV35eafhZOoTFY4FpVh9zsp47kdQ5JLi6o/6acZpwIAGOgTuPM8QWiOSDEr
         RHWTq7KzfvB0AEbzhaDgbjBdeCs1tRu9kifvjfDG+60UZv0SWaRTjmdjtxRzIoQOO1D4
         6WGx6AoA9dq9Qmle0oQEpE0xAyfHy32Qfp/UgNOyCzDZzNwxj38qhQ9RDNtA5m4HJDGo
         CQrk4V0tSFRB3F76/bokZzpTw4u8WbC8O3DyCS90dj4/iwo7IR97jUJVK6+B3uJcv7uX
         01EQ==
X-Forwarded-Encrypted: i=1; AKwUvBxF3fei83gA8yrRZECnYxpJ44z5hGnbkSup+YQrxKJzaZ14rXVFDkoScdweP6/KZXxosofu/ljV/PoSv/s0k+G2XV2xsvk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKQAQYD4vkQz6UQZ+PWyBEEf+Pp+5K1bME28uio+vhGNHjXfocE
	GCpwXYeKXRWt0JRkRbbuULc4eXJZpkktrcUp4SWc6D9jUjEl+3p3Hj+y
X-Gm-Gg: AYBFou2bd2+a23qJ/6kqHNCr1P/zVJM+R4GjLQbWSVDPWEgmDwlmLrNDa+DhaPEoNpq
	AROrOzvdv8vZWm6+MJQeN8kk9Jj61+d0z0ZFw1eavEFxKQY+tZmoN9K2uwsQ4Me0cF0OOZgsQDC
	hbFiswJ4nA2sh86l+am0aIl7RVhe08J57QzuKIwdej2jedKabfNz0MGJPmleI3Qtaonww6Acgpf
	mUtVARwgN4Qr01pQQwbKhtJYRfZdvHsIjnWi/gpCARUxhmldVjtkmSSbqGbSF5uCgg70zeOO3av
	FnGMV//TlfDwRSjlXGi9tcA1bdZn26fHg1ZmUfcW6q5tRvwTF9SXoA4F46tDor0ZOntAUZwEi3t
	Uz0y+F8w1x71ftAf8h7uFb+lYYS8Cq4ljHd8fl06wGNXk4T6Lnt1LnF9CgKgd4WRTLyCD38iysl
	8LR/FbuNAzogH1Taop8WqdWFFuudrCnRaAHU3ib8lWFBafQ329tAPdDTndGFCVN1Caal14iSMUR
	bi1gPc2ib4MyNgd7sAdvBtg6PCFRhwtDlgPTcBpuJwZP2Nv563J+7WTIOuGNiBdwMpF+lrIdRcy
	ycyp
X-Received: by 2002:a05:600c:3d8d:b0:4a2:150f:1601 with SMTP id 5b1f17b1804b1-4a35ac94951mr108366005e9.12.1792999355465;
        Mon, 26 Oct 2026 00:22:35 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35b4a8bc1sm84113045e9.4.2026.10.26.00.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 00:22:35 -0700 (PDT)
Date: Mon, 26 Oct 2026 08:22:30 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Farid Zakaria <farid.m.zakaria@gmail.com>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ericson <mail@johnericson.me>,
	linux-security-module@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/3] landlock: Add access rights on created files
Message-ID: <20261026.dd06418f7fd4@gnoack.org>
References: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
 <20261025.769b43a39e24@gnoack.org>
 <20261025.8e22954c9c47@gnoack.org>
 <DME3ZOI3Z6VE.1XGI920DJV4LE@gmail.com>
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
In-Reply-To: <DME3ZOI3Z6VE.1XGI920DJV4LE@gmail.com>

On Sun, Oct 25, 2026 at 10:52:14AM -0700, Farid Zakaria wrote:
> On Sun Oct 25, 2026 at 7:57 AM PDT, Günther Noack wrote:
> > On Sun, Oct 25, 2026 at 12:07:10PM +0100, Günther Noack wrote:
> >> Hello Farid!
> >> 
> >> On Sat, Oct 24, 2026 at 01:39:16PM -0700, Farid Zakaria wrote:
> >> > This is a proposal for an idea to add support for landlock to work
> >> > better with build systems such as Nix where they want to apply
> >> > restrictions but the paths may not yet exist.
> >> > 
> >> > TL;DR;
> >> > ========
> >> > 
> >> > Landlock rules attach to inodes that exist when a ruleset is built.
> >> > That makes a directory shared between trusted and sandboxed tasks hard
> >> > to confine: the sandbox may create entries there with
> >> > LANDLOCK_ACCESS_FS_MAKE_*, but no rule can name those entries ahead of
> >> > time, and granting read access on the directory to cover them exposes
> >> > every other entry as well. This series adds a rule flag that grants
> >> > access rights on the entries a domain creates in a directory, instead
> >> > of on the directory.
> >> > 
> >> > Motivation
> >> > ==========
> >> > 
> >> > The motivating user is the Nix build sandbox. Every Nix build runs in
> >> > its own sandbox, and a build may only read its declared inputs in
> >> > /nix/store and must be able to write and read back the outputs it
> >> > creates there. Nix enforces this with a private mount namespace: it
> >> > creates an empty store directory and bind-mounts each input path into
> >> > it, one mount per input. Nix has paid this per-input cost since the
> >> > sandbox was introduced [1].
> >> > 
> >> > The cost is paid per build and grows with the size of the input
> >> > closure. Nix is moving towards much finer-grained builds (many small
> >> > derivations instead of a few large ones), so the number of sandboxes
> >> > grows while each build's own work shrinks, and the sandbox setup is
> >> > becoming the bottleneck. A typical build has hundreds of inputs; large
> >> > ones have thousands.
> >> > 
> >> > A microbenchmark sets up and tears down a Nix-like sandbox (user,
> >> > mount, PID, IPC, UTS and network namespaces, pivot_root into a chroot,
> >> > removing the chroot afterwards). It compares one bind mount per input
> >> > with a single bind mount of the whole store plus one Landlock rule per
> >> > input. Median latency per sandbox, one sandbox at a time, Linux 7.1,
> >> > ext4, 16 cores:
> >> > 
> >> >   inputs   bind mount per input   one bind mount + Landlock   speedup
> >> >       10         3.2 ms                    2.3 ms               1.4x
> >> >      100        11.6 ms                    2.8 ms               4.1x
> >> >     1000        79.3 ms                    6.4 ms              12.4x
> >> >     5000       400.1 ms                   24.4 ms              16.4x
> >> > 
> >> > With Landlock, an input costs an O_PATH open and a landlock_add_rule()
> >> > call: there is a single mount, and no mountpoint directory to create
> >> > before the build and remove after it (removing the 1000 empty
> >> > mountpoints alone took 17 ms).
> >> > 
> >> > The single bind mount is only sound if the store listing and the
> >> > undeclared store paths stay unreadable while the build can still use
> >> > its outputs. Without this series, covering the outputs requires a rule
> >> > on /nix/store itself, which makes every store path readable again.
> >> > 
> >> > [1] https://github.com/NixOS/nix/issues/179
> >> 
> >> I have not done a thorough code review yet, and will focus on the
> >> general approach.
> >> 
> >> I am generally in favor of this approach where we keep track of the
> >> directory inode plus the file name.
> >
> > Apologies, I think I was jumping to conclusions here when I read this
> > too superficially - I realize that you have implemented something
> > different;
> >
> > If I understand correctly, your proposed patch set is granting the
> > access rights on every file that you are creating freshly, but not on
> > files that were created by other processes in the same directory.  The
> > semantics, from what I can see, seem like a Landlock variant to what
> > the "sticky bit" does in /tmp -- you have access to what you create
> > yourself, but not to the files created by other processes.
> >
> >
> > ## Alternative suggestion
> >
> > I have been discussing the other approach with Mickaël a while back.
> > This would also work in use cases where we want to express a rule on a
> > path whose underlying file inode might change, with examples being
> > /etc/resolv.conf (recreated by a DHCP client) or Pathname Unix Domain
> > Sockets (commonly recreated when services restart).
> >
> > In that approach, we'd add a rule like
> >
> > /* pseudocode; name and exact layout TBD */
> > struct landlock_path_beneath2_attr {
> > 	__u64 allowed_access;
> >         __s32 parent_fd;
> >         char  *basename;
> > }
> >
> > During the path walk when checking for an access right, it would match
> > if the parent_fd matches an inode and the name of the next path
> > component is basename.  For example, to access a (potentially
> > changing) /etc/resolv.conf:
> >
> > struct landlock_path_beneath_attr2 attr = {
> > 	.allowed_access = READ_ONLY_ACCESSES,
> >         .parent_fd      = open("/etc", O_PATH|O_CLOEXEC),
> >         .basename       = "resolv.conf",
> > }
> >
> > Or to allow the creation of an output file:
> >
> > struct landlock_path_beneath_attr2 attr = {
> > 	.allowed_access = READ_WRITE_ACCESSES | LANDLOCK_ACCESS_FS_MAKE_REG,
> >         .parent_fd      = open("/output/directory", O_PATH|O_CLOEXEC),
> >         .basename       = "mymodule.o",
> > }
> >
> > Would that be a model that would work for your Nix use case as well?
> > I'm imagining that you are declaring the exact list of output files,
> > is that correct?
> >
> > –Günther
> 
> Gunther,
> 
> From my reading of your suggestion and the code, I think that would work
> for Nix and maybe a little simpler. Nix does know ahead of time the
> output directory (/nix/store/<hash>-<name>, one per output), so
> a parent_fd and a basename that we walk uptowards would be sufficient
> without creating inodes.
> 
> This sounds like a good approach to me and my research upon your
> suggestion is that it would simplify the proposal as well (drop
> a patch). Should I try to implement this and send a new patch series?
> (Disclosure: Will use AI to help me write the code, but will review and
> test it myself.)

I'm on board with this approach, but I'd recommend briefly waiting for
Mickaël's ack, because he is the one who gives final approval on these
patches.  (In the interest of everyone's time, might be better to
first figure out which of these approaches is viable, before we jump
into more implementation details.)

Mickaël, can you please double check and confirm that the approach I
described above is in line with the one you also had in mind when we
discussed it at LSS?


The use of AI is fine in Landlock, I've used it myself for patches in
the past.  (The Linux-wide rules apply of course, as documented in [1]
-- Take full responsibility for the contribution and make sure you
understand it the same as if you had written it by hand.)

–Günther


[1] https://docs.kernel.org/process/coding-assistants.html

P.S.: The requirement for the "Assisted-by" tag has been dropped in
commit 1e035297ffda ("docs: remove Assisted-by references") now.
