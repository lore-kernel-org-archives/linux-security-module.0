Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792926438;
	b=yivECGU53wNNyJyruIRg3zpuNCXJGQM/6o8iuHEn6poK9V8nQIzPAHUalnAj+FP5KWdM
	 QfATg0TC1YXm3aj7R5uO7Q/ewZ9fZEmKrAL7QGt9vDJUZddX2RM0F/ETFFYhjW9Lr87RA
	 m1mR/hur9xeLoZsCIE90zgdsQ3KYST8qyOPawlvLXlZx8gYab2ohUIfbn83irGTx+NKD0
	 KkuzyetBMfK86kUFh/EDWoMszsnyH5IgrEVDkrquqhlyoHF3iHAoX2Q2Z+rCEUPzo1m58
	 0hghiVruhBxoyOT8w8YcUPMW6yTlrctzxj2CekIygA8CATv3Na8yCW3+jr6bke5vyvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792926438;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=HNmWqF1JTLCSQrPqjI1jaX+dUsgvu4DGBpBuWqz6xVM=;
	b=mH6QaaZCb19Y5fOFl5MnBf/d9YrLRHzsJ7hYmebtnWY0/BSkmONQh8XL49uhwOR62eMZ
	 JBED2oyghVsqWhr5j32o17kjzYp2vwKGfcWJWJYEVfFCg2oBJafwp9Poc5N4N+Gnc4P5r
	 J7KIkkaFOONw+OsmcYGfGYMttjz5u00tN37anEbKAE6EDYQgyqWKlwFOD7aI/PDg/L7EO
	 1jQwFecel22l1ESTACvd7qZIzlvbNx78EZXK+skP9ufgVhqq7O/wE+pPq8NYki4UoD/FX
	 QA1ILFWsAZY0Tvvh1TOEWXRu9DUmbbkanliVH20X+fKy/8COO3QYKiuEGOuEaR7iTyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ODS+EAZs;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58D40606A31A
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 11:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 58D40606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ODS+EAZs
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a215e64962so14169215e9.1
        for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 04:07:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792926437; x=1793531237; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HNmWqF1JTLCSQrPqjI1jaX+dUsgvu4DGBpBuWqz6xVM=;
        b=ODS+EAZsfQsQqYnYDNcBMTL5sH2KJriCY5hM05coRfGpI9gQbLYP6jnTuqcZuWkam9
         rkHxAwt/KFDkKPF79ZJEdtrgvylh/6UKgEatmQKNDrQIpePLuXEYPmuhKmOoEFMIfSXa
         EwW9vGXk7rbThpoluUtt1lF4N4iHPMrBk8VE8eojm50tfSnjXsd83vP6F8ljeRTfJmNg
         jpC1Cs7cCMMNfT4wqf786El5BMOQA2X9R/gAyOib57oQJ6KCVmOzFU956Eo51mJxFxK5
         IN72E2vX62+X+WRaa4snaXzhtjqf6dE3LTNyfoWYdm5kVc9hnOxfIzBg4p95s9DXsyZq
         NOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792926437; x=1793531237;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=HNmWqF1JTLCSQrPqjI1jaX+dUsgvu4DGBpBuWqz6xVM=;
        b=KG74OJoX40dh7t5A/T4iozyGWjaoLHsbc/nm58lIlnAIrFjJNQ9SAM0qML+6DrLgOd
         RRtdAvtFu1YvO3mgqL557K13tnS4XXZ5e3MG+epggzkzMKUE9XBTSkbxKGuVe43zQ+qd
         FA1gLdsVJZafeAFmAG90/7BXRv7OMtt1TOjnJBiMKbcYA7zMHQSogX2MKJ+NV57OCYia
         rW+g+AYSWBbBJE9Oy5ll+jNi4m8mHOhN5itZstCUEGVjyRdNOtNEEimkoKxZfQw4Geu7
         c11jAv55ko0GRGAKD4Da3Il1wj+ZMrllVZ2Vs9K9gKjbC3KSipgczPb0e2JKphxyvbou
         i1wQ==
X-Forwarded-Encrypted: i=1; AKwUvByMf/93FVYvCcd6uGlgvA0K+uBIyRe+VgbhneR4XPKrINH52d6e2pQ2MMXMZbnX9ojHtUuQonvT6SZLI2dxvAYAfAcxsHU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJBGNtjG5xbfUtfBUf79Bel5WZQC+lziMc3gtNOj0xbOEtF3otj
	J+8O7Jl92fUWJS2K9Cu9xhAd0vef8l2wxH5unOAPcRfZQ2Ada3yzW9qq
X-Gm-Gg: AYBFou1fwIF+XTJNP35/YmGEiYRdWbwne+2qK8FToyF1qCbvU62l/LCaO7vJsGoZrW0
	NChMpaiHsprgBrbv64LaZlaZetc2MCM6p6hOu3d7ekZ6pnGLeq4XXrcQlr9egLiqCRBHfGooJ6B
	RWERDe02IfmVDExazwoJQAOWo3D+cI5RbffMVNOuaYGArk6t/gb7OP+aT+Awbf3C6b30XKqfwpL
	S+bJmut4qVuPMDBbVXrL4v0a4/1kMQUMHYt6UhHQ8AWaiwecluqXjP+G0ocYDcRo+1dNZV6p9Uf
	8XB1w+nK46raTN6O+2TiH46HqdOdbFzgu70e3WvRZBu2VCgeCRJ/AoKb3Pm2TOyCTyy9hNHlSOP
	IyEUApQQfOlesSDTfGPCAmR2GwIojhgYa+Py8iyrXNb0ZJdduee6AOTHW1AHeXC82PL8R93gWoK
	d9HHDI2MpdvPMB2M771LIbsH1y0Wt+MQCvxI2PwHRJuZg+pffdSyvI3WOADPHn2vf719+hUfg/f
	3hpvTTLjfktLqZn4TjdKwmIp4DlEvtJXWoVMftI2X2icKrNCZJ0dAGgC54CnhkSrHdcuPK/ShzL
	oiFYbA==
X-Received: by 2002:a05:600c:870f:b0:4a1:f7f4:7ced with SMTP id 5b1f17b1804b1-4a35ac9d1cdmr64334395e9.17.1792926436490;
        Sun, 25 Oct 2026 04:07:16 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a029332sm102825965e9.4.2026.10.25.04.07.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 04:07:16 -0700 (PDT)
Date: Sun, 25 Oct 2026 12:07:10 +0100
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
Message-ID: <20261025.769b43a39e24@gnoack.org>
References: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
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
In-Reply-To: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>

Hello Farid!

On Sat, Oct 24, 2026 at 01:39:16PM -0700, Farid Zakaria wrote:
> This is a proposal for an idea to add support for landlock to work
> better with build systems such as Nix where they want to apply
> restrictions but the paths may not yet exist.
> 
> TL;DR;
> ========
> 
> Landlock rules attach to inodes that exist when a ruleset is built.
> That makes a directory shared between trusted and sandboxed tasks hard
> to confine: the sandbox may create entries there with
> LANDLOCK_ACCESS_FS_MAKE_*, but no rule can name those entries ahead of
> time, and granting read access on the directory to cover them exposes
> every other entry as well. This series adds a rule flag that grants
> access rights on the entries a domain creates in a directory, instead
> of on the directory.
> 
> Motivation
> ==========
> 
> The motivating user is the Nix build sandbox. Every Nix build runs in
> its own sandbox, and a build may only read its declared inputs in
> /nix/store and must be able to write and read back the outputs it
> creates there. Nix enforces this with a private mount namespace: it
> creates an empty store directory and bind-mounts each input path into
> it, one mount per input. Nix has paid this per-input cost since the
> sandbox was introduced [1].
> 
> The cost is paid per build and grows with the size of the input
> closure. Nix is moving towards much finer-grained builds (many small
> derivations instead of a few large ones), so the number of sandboxes
> grows while each build's own work shrinks, and the sandbox setup is
> becoming the bottleneck. A typical build has hundreds of inputs; large
> ones have thousands.
> 
> A microbenchmark sets up and tears down a Nix-like sandbox (user,
> mount, PID, IPC, UTS and network namespaces, pivot_root into a chroot,
> removing the chroot afterwards). It compares one bind mount per input
> with a single bind mount of the whole store plus one Landlock rule per
> input. Median latency per sandbox, one sandbox at a time, Linux 7.1,
> ext4, 16 cores:
> 
>   inputs   bind mount per input   one bind mount + Landlock   speedup
>       10         3.2 ms                    2.3 ms               1.4x
>      100        11.6 ms                    2.8 ms               4.1x
>     1000        79.3 ms                    6.4 ms              12.4x
>     5000       400.1 ms                   24.4 ms              16.4x
> 
> With Landlock, an input costs an O_PATH open and a landlock_add_rule()
> call: there is a single mount, and no mountpoint directory to create
> before the build and remove after it (removing the 1000 empty
> mountpoints alone took 17 ms).
> 
> The single bind mount is only sound if the store listing and the
> undeclared store paths stay unreadable while the build can still use
> its outputs. Without this series, covering the outputs requires a rule
> on /nix/store itself, which makes every store path readable again.
> 
> [1] https://github.com/NixOS/nix/issues/179

I have not done a thorough code review yet, and will focus on the
general approach.

I am generally in favor of this approach where we keep track of the
directory inode plus the file name.

Other projects that have run into the problem before are:

(1) Justine Tunney's Landlocked Make experiment
    (https://github.com/jart/landlock-make).  This one shares the same
    "build system" problem, I believe the topic came up during code
    review at the time.

    So I think this is a general problem in build systems that use
    Landlock.

(2) Michael Stapelberg's Go rsync implementation.

    https://github.com/gokrazy/rsync/commit/f85bc9b98cdda705ff8e76ebcd8fba03c6560467

In the rsync case, the issue is not a rule for *creation*, but for
*reading* files.  But it could still be resolved with the same
mechanism: When allow-listing the /etc/resolv.conf file, the policy
works for a while, but eventually a system-level network management
daemon might exchange the file for a new one with an atomic rename,
changing the inode number.  It would be desirable to express a policy
in this case as well, which is tied to the /etc inode plus the
"resolv.conf" filename, for opening files for reading.

The same problem also exists for allow-listing of Pathname Unix Domain
Sockets, where the common way to restart these is to unlink the socket
file and recreate it during bind(2).

In both cases, the best current workaround is to grant the access
right on the parent directory, which is arguably often granting more
than necessary.

Do you think your patch would generalize for the non-creation use
cases as well?


> Series
> ======
> 
> Patch 1 lets an LSM observe inode creation through the
> inode_init_security hook when no LSM provides an xattr. Patch 2 adds
> the LANDLOCK_ADD_RULE_CREATED flag for path-beneath rules and bumps the
> ABI to 13. Patch 3 adds selftests.

I only had a short look so far, but stumbled across the words "package
store" / "store" etc.  In other packaging systems, I have not come
across the term "package store" before.  In the kernel code, please
let's not assume that readers have a familiarity with Nix, and let's
please explain features in more general terms.  (Note to self, on
review, grep for the word "store".)

(FWIW, I suspect that this wording might have been put there by an AI.
I've observed in the past that AIs sometimes have an unfortunate
tendency to blur the lines between abstraction layers and
cross-reference implementation internals across abstraction layers.
Maybe something to watch out for?)


> Testing
> =======
> 
> The series applies to the Landlock next branch (3e271a27c46f) and was
> tested on Linux 7.3 with that branch applied.
> 
> Without patch 2, the five new tests and the ABI version check fail.
> 
> Open questions
> ==============
> 
> - A created inode stays pinned until the layer's hierarchy is freed, so a
>   sandbox that creates many entries in such a directory keeps them all in
>   memory. Should this be bounded?

Is that a preexisting problem that predates your patch?


> - Creation is detected in inode_init_security, so on filesystems that do
>   not call security_inode_init_security() created entries get no rights.
>   Is there a better hook?

We are already hooking into hook_path_mknod(), hook_path_symlink()
etc.  Is the feature not possible based on that hook as well?

In fact, I would have assumed that you would only need to change the
logic in the path walk so that it can pick up the special rule type?
Does that not work?

> - Through overlayfs, created entries get no rights either, because the
>   upper inode is created with the mounter's credentials. Should overlayfs
>   be handled, e.g. via security_dentry_create_files_as()?

Landlock does generally provide the normal semantics when you use
files through an OverlayFS mount.  We have exhaustive tests for it in
fs_test.c as well.


> - A file renamed or linked in keeps only the rights it had at its source.
>   Should it get none instead?

Please see the logic and discussions around the
LANDLOCK_ACCESS_FS_REFER access right: When linking or renaming a file
to a new location, we must make sure that a landlocked program can not
move it to a place where it suddenly has more access rights on the
file because it is now accessible under different parent directories.

Thanks,
–Günther
