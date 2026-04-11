Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668EA1C84BB
	for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 08:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775896610; cv=none; b=YxDm9iWhtiq55A2EnitG2UBGXKOWV91QVYld+T0qymmAlT7mjQPUH1yVxjyalDcTsTE/mqbPBsQgKyaREHiEvm+8yXnIkz9LxHOAQuN4cTmnGFxhhJia5nxNxOJEqLNJdjykJbUttgbAeg/X7rdHcFF3k2Xt4EvDW/imMIB8rXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775896610; c=relaxed/simple;
	bh=MVUF7SP1sd0Cy5545Dd+aWne606r1wgsVyI2cxhgHpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/rZ0kPbCaUrHhRzo92GIEId682OMhmLdU9j22YMhdw22g7RlPN0ivtCMV+LUsjkRZ7jyaf/pG5XXvnkHzNpsCTFaAjfi/D0eClHxflc46s/f3mJqBs21X+XhOQP78TWrp+gM0aiG3L0IdZ2Sw0OHDHzI695XBT5nVLnsuAXk/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LiDUka9S; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LiDUka9S"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-488b8efed61so25413415e9.1
        for <linux-security-module@vger.kernel.org>; Sat, 11 Apr 2026 01:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775896607; x=1776501407; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8wzioy4E/6FOUF7Efgzz7WDtjqLGZQycOJu2qhn5rpk=;
        b=LiDUka9SSXPxcVq886f9Asq3Ar+sAzlFfPgyPPqTfvRZ20Op5RqfgLBTUVvXBbHGG5
         7gpdvWyIVXzpLIqALhK2/iqYX3Fm5O/AuXzjH7tWuB30noWi3l6pmsppGO98t+nnWHLF
         rcVA8Mh6ksaF+de8CN1iPQ3G97AFmwRXJS3f/7vyTyqC6X+wUacwV5zpWfKyZYE3HDrv
         gkbPmICUZ8rtHcmq1c/IeyT0FQfAUqCSuOTQptUeQQz1a4VFXRuASX/C6L6L6s5aJZdZ
         +92MzhVwNN+s4gGrvd694w8XrngMINUGvTTJCngy6h1zINQLzR0nrkaW072pLIWh8xpf
         U7Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775896607; x=1776501407;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8wzioy4E/6FOUF7Efgzz7WDtjqLGZQycOJu2qhn5rpk=;
        b=Ciwkctwm66zLnDpvD/FXoKRfIWRQb7cb7OjTISEfRwlVMEPJtxAITQZOC1Ij3ZXtE0
         gpm4I020262n1+iaVsZX2q4TqbS6fgZ/GbUIdBg7uEbA0BNY19vulKXEIlzsT5QlB1jP
         pPF7YTmFAUYbistAVB+juDEI1xmyHhYHg5s/6+C2chdHPfQNwdsksUnKfhA/O4UcokfX
         4HfRw3zVzF8GY2+425Olf/vDSk3qZO3oK/h8v/X2hNmODXWR/q40WNzCwULTukksHaah
         T+arAvlPN2soQtyqw1pAbT6KQiHw8cIzC+S4qPat1cjPbD7WseuR+lEHux8Bl2s2aOYw
         c1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCWemZc864fQ73MmJjkTttaar9evvAhJ9Hc7TazAGyoqP1UMkx7qFmLLVIRbMvEKhJKYBBD+As0EIoYiVZw+8YjPi9Xj1l4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9UWlh5Qv1wsexC0nuH8Gr58k+R8Ukd5aAgYIUipqDH5Sit74b
	riSUg+82xqsQWsnm5z2VqisS2P+r33FvgYcXUAfdgMeQZP2tyB47owDB6BTzxMLmZA==
X-Gm-Gg: AeBDiesWuqH6NtZ7/rxkSULLArsxGRH9E8tBqdlQfyousJtCF90uTQZnsMFCQQedt8f
	gzhJULp7emoM44b+0G1H0ku0kDlhA4qCVMUx9gyumusnvQQE4kMtxnSCv96cxCMcnXuqjy/UJbX
	eZKlyUz+k3ry30KJB2ctvGl0DQDtyuExF0b7Id/ILyYApnh9T3hXD0skIDOasrKZxiNErt1KWjq
	0I7q5tBNFNi46hWfgGyk1z2N9wnQ8+VpfUFSxjMPvacbogy4cXR14CEoVbo9jMG5Q6qbgRWxy56
	s9fjZx/YPvpGKCzdGZxmBBP8C9uVZZpg+uQGIKUzk2HWnpedDbRR8EPo+f3ktmdXqqoZfjS3xSi
	E/Xkv1JDyH4IPZRFAKDz/x+qTB21RxxMWQWsDqFheSxMGOc+tqrb6kzfonfrR6EaemTaT7PnHgE
	Y7UJPPV/+Nf04CRkNsgyoSe/Th7ebF75RiH4fhCetn+z0Qdb4hX12SjQkR3TUpyjQv
X-Received: by 2002:a05:600c:3ba4:b0:488:c6e9:1e0c with SMTP id 5b1f17b1804b1-488d6847de9mr75093505e9.5.1775896606313;
        Sat, 11 Apr 2026 01:36:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:2b66:d8bf:3624:ab43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5888a97sm157704815e9.2.2026.04.11.01.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Apr 2026 01:36:45 -0700 (PDT)
Date: Sat, 11 Apr 2026 10:36:40 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Serge Hallyn <serge@hallyn.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org
Subject: Re: LSM: Whiteout chardev creation sidesteps mknod hook
Message-ID: <adoIGHwgMJSuRfE5@google.com>
References: <adUBCQXrt7kmgqJT@google.com>
 <06337e89-349a-4334-a735-b8dc9b566cdd@hallyn.com>
 <20260409-entbrennen-turnschuh-54af9b45610e@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260409-entbrennen-turnschuh-54af9b45610e@brauner>

On Thu, Apr 09, 2026 at 02:47:16PM +0200, Christian Brauner wrote:
> On Tue, Apr 07, 2026 at 12:15:00PM -0500, Serge Hallyn wrote:
> > Apr 7, 2026 08:05:43 Günther Noack <gnoack@google.com>:
> > 
> > > Hello Christian, Paul, Mickaël and LSM maintainers!
> > >
> > > I discovered the following bug in Landlock, which potentially also
> > > affects other LSMs:
> > >
> > > With renameat2(2)'s RENAME_WHITEOUT flag, it is possible to create a
> > > "whiteout object" at the source of the rename.  Whiteout objects are
> > > character devices with major/minor (0, 0) -- these devices are not
> > > bound to any driver, so they are harmless, but still, the creation of
> > > these files can sidestep the LANDLOCK_ACCESS_FS_MAKE_CHAR access right
> > > in Landlock.
> 
> They aren't devices.

The LANDLOCK_ACCESS_FS_MAKE_CHAR access right is about the *creation of
character device directory entries*.

These files do not hook up to any of the kernel's device driver subsystems, but
they *are* directory entries of the chardev type, and the creation of these is
still sidestepping the LANDLOCK_ACCESS_FS_MAKE_CHAR right.


> > > I am unconvinced which is the right fix here -- do you have an opinion
> > > on this from the VFS/LSM side?
> > >
> > >
> > > Option 1: Make filesystems call security_path_mknod() during RENAME_WHITEOUT?
> 
> No.
> 
> > >
> > > Do it in the VFS rename hook.
> > >
> > > * Pro: Fixes it for all LSMs
> > > * Con: Call would have to be done in multiple filesystems
> > >
> > >
> > > Option 2: Handle it in security_{path,inode}_rename()
> > >
> > > Make Landlock handle it in security_inode_rename() by looking for the
> > > RENAME_WHITEOUT flag.
> > >
> > > * Con: Operation should only be denied if the file system even
> > >   implements RENAME_WHITEOUT, and we would have to maintain a list of
> 
> Why? Just deny RENAME_WHITEOUT. What does it matter if the filesystem
> implements it or not. Overlayfs would fall back to non-RENAME_WHITEOUT
> if not provided by the upper fs anway.

I'll send a patch with this approach for discussion.

It turns out it is less difficult than I feared:

* OverlayFS uses its own credentials object, and since that is not under a
  Landlock policy, the OverlayFS-internal vfs_rename() invocations do not have
  that problem.  (Under a Landlock policy, mount(2) is not permitted, so the
  OverlayFS-internal credentials are not Landlocked.)
* The remaining use case is only when a user calls renameat2(...,
  RENAME_WHITEOUT) directly on a filesystem (which is not necessarily part of an
  OverlayFS).  That case can be restricted with Landlock.

We might have slight error code inconsistencies yes, but as Mickaël is saying on
the sibling mail thread, it would not be worth the tradeoff to maintain a list
of supported file systems just to get the error codes right.


> > >   affected filesystems for that.  (That feels like solving it at the
> > >   wrong layer of abstraction.)
> > > * Con: Unclear whether other LSMs need a similar fix
> > >
> > >
> > > Option 3: Declare that this is working as intended?
> > 
> > Option 3 has my vote.
> 
> Seconded.

(See also discussion on sibling thread)

I also don't currently see how an attacker would abuse this, but I still see
this as a violation of Landlock's security model if we can create a policy that
denies the creation of character device directory entries, and then we still
have a way to make them appear there where we previously had a different file.

I'll send a tentative patch for option 2 for discussion. We can discuss more in
the context of that more concrete proposal, if needed.

—Günther
