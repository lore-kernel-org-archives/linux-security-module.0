Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792940256;
	b=vIFCcmm9CJHJWfKgc1y1rNP5z1fdJ6wHdKCGy44+5/kDk7AOm7fefrmNlIprDaScY+J5
	 sys29Mjnoq4bpiQjHz5uhFPu+w/Pf05xBGLXXpqN/HBytSA8ZvT+Lvpu1fDQzgUC1vxJs
	 IuS/LGom1XNzQImxT0s2U5x5zbyhov1Ezqv1ZTbM6jB9UGtF4slhHSOLbxtpxmV3Y1cHb
	 n2cth4dn9DIt9T6nOIfaweWlS7Pz3boMXXAZe1AT60nMAGwjZBwXvKb2yV2XxfIIMlD9L
	 aWumTEJarcefSZY+eY3n2pJee8GwYhbUb72ttU0vTQqn5zJvzs/2yS6RosYEgppg3FQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792940256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=IExH7VqrZ8oPD6Z8eyPZrnBoWcrKLM561SgLi8Akt3Q=;
	b=MblVE+nN5qdwrEnAgD1Sl0yJbmQCMO/4Y3gwCANZ21T8HqB3sxLOyIVk55yiD7k7MGjp
	 QpVO5QLauBg6sOaKB/A4se/21DXvxTgtWZroDKIK0fcU8sN/uM7R8jGFomascFqYV0Q9n
	 DufbClGwNx9XZn/3LDcMxRc1RLO0fRnrKFaNBwBINroS1zYWueB9iziiN+c69rb5FRSUd
	 O2R/mcbP0U3TjQrVFM7D8+OItNuT95h6E4omLXFTZTDYvaO+O9MFI9Z7CZlM37UEbD/0L
	 BZZUnmykLJOfm+O9RFEbljL8wuIdF0ELqtslnv8aQSjJd0pA41Y7F8LUq0WTzsMpv2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P7Ipz8vv;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD522606A31B
	for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 14:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD522606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=P7Ipz8vv
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so3326375e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 25 Oct 2026 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792940254; x=1793545054; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IExH7VqrZ8oPD6Z8eyPZrnBoWcrKLM561SgLi8Akt3Q=;
        b=P7Ipz8vvUWjpF6FHXG21uKZKLgsCCgQG3zNgpPHYI7kNj/SzMLzfA1i8Yh+l5L67RN
         +lnFJijTHERB8MBgM7MQvq+ia5BTwqQ+O8Bo3eAuXvyGDVJndQfLIC5iz8rLKEU0vvmd
         ZusY0rRuHxrxpmAikb5wG1YGTMRRjtt66YeGaMSLIb17IdJV98dYTI8m+xZFFfU2kHB1
         pv+EGQv+SQuyEERCUbNj6Hcq/N1N4qao5PUPxTYz6Lbcl1ls5SFzU+14Jj0yzoI3cfWi
         OiMy4HjCXERNI8dveVidEVDlFuHqzs1iTNtr0VOIfnLhVFWziFqavrN9q3ne+IysQUZD
         GtpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792940254; x=1793545054;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IExH7VqrZ8oPD6Z8eyPZrnBoWcrKLM561SgLi8Akt3Q=;
        b=k9N1t9nI1xQj9flF09oeVn6efqJVa8T/sG99ZoNweTh4oRxqM2t/r3w/LU39PI2VrN
         qzNCtE9UGHEec46ORazTGqnoI5N8XE+/9L0/Ss/JSgRYr/XBYBmjQnZ88ioqZ3trhhF9
         PWV9Mdj76m3E2562LsJuajQ9P/r8sNYeMfcN7d2giH6Jf/LYMOgjX/DTTgTgsrgAS7p2
         N7a1iYD0OE08ozMiLHQ/UJsfWF6nWwsb+vA6TVRjBhrzfOVTaUkZD5b85xLpSnveozM6
         r7iJlMzntzbInmghJ8cThFST1aGA0QJ8LElwHtwH9tpiG+6DUczuCJuLzNNHaAcpk/53
         qlrg==
X-Forwarded-Encrypted: i=1; AKwUvBzCy+5qSacrV1oYWrOeteYgYQQGo/3eZ3UpPnEHrIVIaeXEGfQTmbBYwbA0qi/4VwMWRmxpGGFrXLUfBdZvjFoT+rOu53E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIVHAeD7b9Q0pD2scASruuT2r6kcEA6ZzmwQcNTUVY/7IsMny0H
	ktvVwnUtcqyTXadd99yknqVSg7vdcQa+4xKA7ddJcMwHPhrXj8S/S9u8
X-Gm-Gg: AYBFou27U2GHQHQV6xU1yKDChp8p/wH0lQnV36AAfkgPC1PZHvwiLtWI2+PKpbL1ZQd
	hHnbnlwA5tapHgY8RmpMqqQqpX8HEQJN4VJctSzjk03PBNayMDTUTWVXHGI7/bSVGyiglohR5ks
	Wd+sjL6rCtrxxMJt7qXl/7JZkY3MUpk1cPGjrLkuaId6zuBCfTI7jtnLbu6/ujlqI2rqi1ohGD6
	GFJV4ttZSIln28tbBWS9r7K71PecOnDQSdewmVX8Msog9g/jpWjQdJmWoLWelznK5Jp3t1NdS4Z
	dF8E26tkW4+5EldT5/RpKD2xUaVCUn3QWOyIBN/9RduqDwtVgQ/kp20h7/9KC7wA25PeKagMO2N
	Tu3U8iLlQlCkPIGRdgg05OYhX1lG+0KV7TZ4vtBDRtXupj27wAzyQce74kwCMTKg2EaBDTFkU2F
	xGh8BQaj2vwWXqN97rAGZy5QIYf0CfdjJqLp4dnoqxw6lMxiJwEDTVyQmWAAZXbwVwIsDLKCtk3
	3YiAnkevshbPjZuDm3KRs8y7gMvuflD1rtGI34jiY4A6mbH+WQO93E8qJae4jFTJSU1k864ucYr
	KwHs
X-Received: by 2002:a05:600c:6095:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4a35ac7f0d2mr64643565e9.9.1792940254154;
        Sun, 25 Oct 2026 07:57:34 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48e0sm11218693f8f.38.2026.10.25.07.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 07:57:33 -0700 (PDT)
Date: Sun, 25 Oct 2026 15:57:32 +0100
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
Message-ID: <20261025.8e22954c9c47@gnoack.org>
References: <20261024-landlock-created-rights-v1-0-77c8db3f6bd2@gmail.com>
 <20261025.769b43a39e24@gnoack.org>
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
In-Reply-To: <20261025.769b43a39e24@gnoack.org>

On Sun, Oct 25, 2026 at 12:07:10PM +0100, Günther Noack wrote:
> Hello Farid!
> 
> On Sat, Oct 24, 2026 at 01:39:16PM -0700, Farid Zakaria wrote:
> > This is a proposal for an idea to add support for landlock to work
> > better with build systems such as Nix where they want to apply
> > restrictions but the paths may not yet exist.
> > 
> > TL;DR;
> > ========
> > 
> > Landlock rules attach to inodes that exist when a ruleset is built.
> > That makes a directory shared between trusted and sandboxed tasks hard
> > to confine: the sandbox may create entries there with
> > LANDLOCK_ACCESS_FS_MAKE_*, but no rule can name those entries ahead of
> > time, and granting read access on the directory to cover them exposes
> > every other entry as well. This series adds a rule flag that grants
> > access rights on the entries a domain creates in a directory, instead
> > of on the directory.
> > 
> > Motivation
> > ==========
> > 
> > The motivating user is the Nix build sandbox. Every Nix build runs in
> > its own sandbox, and a build may only read its declared inputs in
> > /nix/store and must be able to write and read back the outputs it
> > creates there. Nix enforces this with a private mount namespace: it
> > creates an empty store directory and bind-mounts each input path into
> > it, one mount per input. Nix has paid this per-input cost since the
> > sandbox was introduced [1].
> > 
> > The cost is paid per build and grows with the size of the input
> > closure. Nix is moving towards much finer-grained builds (many small
> > derivations instead of a few large ones), so the number of sandboxes
> > grows while each build's own work shrinks, and the sandbox setup is
> > becoming the bottleneck. A typical build has hundreds of inputs; large
> > ones have thousands.
> > 
> > A microbenchmark sets up and tears down a Nix-like sandbox (user,
> > mount, PID, IPC, UTS and network namespaces, pivot_root into a chroot,
> > removing the chroot afterwards). It compares one bind mount per input
> > with a single bind mount of the whole store plus one Landlock rule per
> > input. Median latency per sandbox, one sandbox at a time, Linux 7.1,
> > ext4, 16 cores:
> > 
> >   inputs   bind mount per input   one bind mount + Landlock   speedup
> >       10         3.2 ms                    2.3 ms               1.4x
> >      100        11.6 ms                    2.8 ms               4.1x
> >     1000        79.3 ms                    6.4 ms              12.4x
> >     5000       400.1 ms                   24.4 ms              16.4x
> > 
> > With Landlock, an input costs an O_PATH open and a landlock_add_rule()
> > call: there is a single mount, and no mountpoint directory to create
> > before the build and remove after it (removing the 1000 empty
> > mountpoints alone took 17 ms).
> > 
> > The single bind mount is only sound if the store listing and the
> > undeclared store paths stay unreadable while the build can still use
> > its outputs. Without this series, covering the outputs requires a rule
> > on /nix/store itself, which makes every store path readable again.
> > 
> > [1] https://github.com/NixOS/nix/issues/179
> 
> I have not done a thorough code review yet, and will focus on the
> general approach.
> 
> I am generally in favor of this approach where we keep track of the
> directory inode plus the file name.

Apologies, I think I was jumping to conclusions here when I read this
too superficially - I realize that you have implemented something
different;

If I understand correctly, your proposed patch set is granting the
access rights on every file that you are creating freshly, but not on
files that were created by other processes in the same directory.  The
semantics, from what I can see, seem like a Landlock variant to what
the "sticky bit" does in /tmp -- you have access to what you create
yourself, but not to the files created by other processes.


## Alternative suggestion

I have been discussing the other approach with Mickaël a while back.
This would also work in use cases where we want to express a rule on a
path whose underlying file inode might change, with examples being
/etc/resolv.conf (recreated by a DHCP client) or Pathname Unix Domain
Sockets (commonly recreated when services restart).

In that approach, we'd add a rule like

/* pseudocode; name and exact layout TBD */
struct landlock_path_beneath2_attr {
	__u64 allowed_access;
        __s32 parent_fd;
        char  *basename;
}

During the path walk when checking for an access right, it would match
if the parent_fd matches an inode and the name of the next path
component is basename.  For example, to access a (potentially
changing) /etc/resolv.conf:

struct landlock_path_beneath_attr2 attr = {
	.allowed_access = READ_ONLY_ACCESSES,
        .parent_fd      = open("/etc", O_PATH|O_CLOEXEC),
        .basename       = "resolv.conf",
}

Or to allow the creation of an output file:

struct landlock_path_beneath_attr2 attr = {
	.allowed_access = READ_WRITE_ACCESSES | LANDLOCK_ACCESS_FS_MAKE_REG,
        .parent_fd      = open("/output/directory", O_PATH|O_CLOEXEC),
        .basename       = "mymodule.o",
}

Would that be a model that would work for your Nix use case as well?
I'm imagining that you are declaring the exact list of output files,
is that correct?

–Günther
