Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE1B2D6630
	for <linux-security-module@vger.kernel.org>; Fri,  2 Jan 2026 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767347641; cv=none; b=Tzj5M603Qpm6Atm8qsYdvngkKUd9rIgdz8TasX2myCFGqqvmiXFg3EpJSYvscY6eLqbDY+/O1bKqwXY9R6gCVoKRZyB+NKpYfzpSOV39PE30SkbPaSnTYg8r7sObpzdl8bA8qAGR5lIkHNYAXhTnct0RNsXB5xPeTkK09U1JbxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767347641; c=relaxed/simple;
	bh=/1u8kNkS5/7b6bZOgwSAKsE8qkZc5CCRgGr+sVssJBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eZiN2a+YJf7ziPX00sl6iR+MtK8SFG8OOwe8uzrTHjY8GX4aeejQJEVDQ8kNP+y7z6mbq4Xd03NVxI2NOXL/4s2XQpO3+Y3WZollgVbSdJkCTc2Z4HJ07Gq25VjA8l5MC3zjJyVZhmJJBjYy/UnUeYAnzq7P0LPT49q40tksQFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcdYJj4m; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcdYJj4m"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7355f6ef12so2295792866b.3
        for <linux-security-module@vger.kernel.org>; Fri, 02 Jan 2026 01:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767347638; x=1767952438; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xoEaB3uMABzEDCAE435hPxHUq2dKJQN7Br/fp6BoKMY=;
        b=lcdYJj4mPlqaoMf+SUor49kKd0lMBwuwJdcFbd+d6frIhLPDu+IH2YyJJpQywg7wFN
         ormyCNRueTPbLQfVJZqqGa7MkB2s+fUvdod8p2V+H4SPvq0fNR7pjPyQAINdTpC32wIa
         +nU+sgahLQ0Re6TotZugvL/sH/79huAG04EJGRUlHPlHKyuFRBds9fQdy8aTojldhASX
         AaK/fe1nNHy/2PDqB9HVQWvWNyNpEfjidziCcQR21asNRLJ0ko9YwTIO8TSIebxGnVFU
         QfT/4McohEje1WssbFZec3gOHWH05pJ4frmtHiRzyIZpUrULbpGjgnwui6P17lW+vuV0
         v3Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767347638; x=1767952438;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xoEaB3uMABzEDCAE435hPxHUq2dKJQN7Br/fp6BoKMY=;
        b=Lkt4ad9bUDEQbqNGrW/oQREiSva09WH/2obrbxMkOMRUXElQzC5FPfYEtjzOq++bHx
         A0sX0K7Z89yW3zxmUM9DRyrADLJa5sPf1a3uoBuAmkJoCQ57TRpxMCjecneAZKJp8gp9
         X87GPmJgB8IOA10VxDp2WctO/0N6AmdhOkZY2UHn3IHvAAAdgmPY2WvRIXzfItnY35Em
         U94n0k7DX7dB48unt4QVlxN9m1pE0f0IeASzIzgnfry7LebJHFGEFMLAoRVEPurzn5aJ
         0UhfHgyN/RNbKdKko9lfM0yKwAJI3Y1ueIJFyzxfpqEvQtHmIIhS7hF9f3HNnnBBqt1T
         DgrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYTamUQLGd+pW9wpAmYrJ+GQH4jqYmRZcgfhKWMcY6xTr+ojqVI620EQQOIfo3OC/XgxwED5UpoXOQZfrGyjO7Tj45xhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfQWMDrvOqQITpxNFWov4bD7WnsFxP1/iBIvVeiSVdEAcSleuU
	FVaEmqXdgK4uNf1VbBrDINEACgpH/c/s2gUwRqWQxHvUkJ/KO4eKh8pBCqJpCw==
X-Gm-Gg: AY/fxX5obDB9Q4YNntOYLfzSzszw7Hb5Q8qbMQEnw8gzUXXBy3aCwMwV6wOFAEuPAnk
	EAQAKjETt9TYcYh24KaL+l0+W2poH5jJfp65f03lCknvtECzZ9l7K/l+QLJG+VC6ilbESyFotJe
	VKYl34YJa2If/7Y7ERmCublJSlizq0bbKdA439Z0mI2uTpfEko4AeUrRW514LqljoxqNQt5kzzQ
	9wo8lQ5jAXlBpq+hY/mHnsX8i+jP5+mzNIwA4trSXGjdTy52F0rqumXD1JpQrmBIAa5qAYUnS3q
	3zEhxlR8a/cVNYk7k9QPVFsqhe+/pV+1LuOZgIwHYl1ydJZucTlLxuzFUyMh7POHGXnbyAMejQ+
	X+0j3WMSwZhU6nDPneWl4XHD6Z6sFQ1iiZ9N+zjhPrpCHSltdjsa5IxkcnJkwgp7cbhv3syRrtL
	MtIK2DnU9Bfpf1X26M8R1i28Mj2kiqTQf4ChqH
X-Google-Smtp-Source: AGHT+IGATUnT0DdIIxCMhRWS+4D+9n39bS0Y3YX+QerAJVuBk6sme5S2dBR3jNAKyhEHR6fxkDyNRg==
X-Received: by 2002:a17:907:9406:b0:b79:c879:fe71 with SMTP id a640c23a62f3a-b8036f0f04emr4152599266b.19.1767347637681;
        Fri, 02 Jan 2026 01:53:57 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8044f4acdbsm4399086866b.22.2026.01.02.01.53.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jan 2026 01:53:57 -0800 (PST)
Date: Fri, 2 Jan 2026 10:53:49 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Tingmao Wang <m@maowtm.org>,
	fahimitahera@gmail.com, hi@alyssa.is,
	ivanov.mikhail1@huawei-partners.com, jannh@google.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org, matthieu@buffet.re,
	mic@digikod.net, paul@paul-moore.com,
	samasth.norway.ananda@oracle.com
Subject: Re: [RFC PATCH 3/5] samples/landlock: Add support for
 LANDLOCK_ACCESS_FS_CONNECT_UNIX
Message-ID: <20260102.d6870733fe10@gnoack.org>
References: <20260101134102.25938-4-gnoack3000@gmail.com>
 <20260101193009.4005972-1-utilityemal77@gmail.com>
 <423dd2ca-ecba-47cf-98a7-4d99a48939da@maowtm.org>
 <22e29fd8-2f39-4a64-b08c-2f41153e3be8@gmail.com>
 <2d02eefa-bc86-4f04-b190-beed304337d4@maowtm.org>
 <43c0515d-afd3-4e00-a0fe-4d651a1d5cf1@gmail.com>
 <884e44c6-7695-49a2-8d60-c7e76d260bea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <884e44c6-7695-49a2-8d60-c7e76d260bea@gmail.com>

On Thu, Jan 01, 2026 at 05:39:26PM -0500, Demi Marie Obenour wrote:
> On 1/1/26 17:38, Justin Suess wrote:
> > On 1/1/26 17:19, Tingmao Wang wrote:
> >> On 1/1/26 22:11, Demi Marie Obenour wrote:
> >>> On 1/1/26 17:07, Tingmao Wang wrote:
> >>>
> >>> (snip)
> >>>
> >>>> Looking at this I guess it might also make sense for the kernel side to
> >>>> enforce only being able to add LANDLOCK_ACCESS_FS_CONNECT_UNIX on socket
> >>>> files (S_ISSOCK(d_backing_inode)) too in landlock_append_fs_rule?
> >>>>
> >>>> Also, for the sandboxer logic, maybe a better way would be having
> >>>> LANDLOCK_ACCESS_FS_CONNECT_UNIX in ACCESS_FILE (matching the kernel code),
> >>>> then another if(!S_ISSOCK) below this that will clear out
> >>>> LANDLOCK_ACCESS_FS_CONNECT_UNIX if not socket.
> >>> A process might legitimately need to connect to a socket that doesn't
> >>> exist at the time it sandboxes itself.  Therefore, I think it makes
> >>> sense to for LANDLOCK_ACCESS_FS_CONNECT_UNIX access to a directory
> >>> to allow LANDLOCK_ACCESS_FS_CONNECT_UNIX to any socket under that
> >>> directory.  This matches the flexibility mount namespaces can achieve.
> >> Right, I forgot about the fact that we also need it on dirs, apologies.
> >>
> >> (But maybe it might still make sense to not allow this on files which are
> >> neither a socket or a dir? (If the file later gets removed and recreated
> >> as a socket, the rule would not apply retroactively anyway due to being
> >> tied to the inode.))
> > How do we handle IOCTL access on regular files? I think that landlock will let you put IOCTL rights on regular files even they are not valid for that operation.
> 
> Regular files definitely support ioctls.

The LANDLOCK_ACCESS_FS_IOCTL_DEV right only applies to ioctl(2)
invocations on device files.


> > Sockets seem like a similar case where the operation is only valid for a subset of file types.
> > 
> > I think we should mirror the existing behavior is for consistency.
> > 
> > Besides, restricting which file types can have that right also makes it harder for applications that may not care about the specific file type, but now would have to check the filetype before making a policy on them (also opening them to TOCTOU).
> 
> I agree.

I also agree with your interpretation, Justin.

For the record, Landlock's kernel implementation currently groups FS
access rights into two groups:

 - file access rights
 - directory-only rights

When adding a rule, the directory access rights can only be granted on
a directory inode.  The file access rights can be granted on both a
directory inode and a regular file inode.

It is pointless to grant the CONNECT_UNIX (or IOCTL_DEV) right on a
file which is not a Unix socket (or device file).  But it complicates
the userspace API if we introduce more special rules there. - Users of
Landlock would have to keep track of all these special cases and
mirror the logic, which is error prone.  IMHO is is granular enough if
we differentiate between files and directories as we currently do.

For reference, this is documented at
https://docs.kernel.org/userspace-api/landlock.html#filesystem-flags
and the logic is implemented in landlock_append_fs_rule() in fs.c.

(Actually, in the implementation, the IOCTL_DEV right is treated the
same as one of the ACCESS_FILE rights - I should probably revise that
documentation: That right does not *directly* apply to a directory
inode, as directories are not device files.  It only inherits down in
the file system hierarchy.  Looking back at earlier versions of the
IOCTL_DEV patch set, it was different there.  I think I missed to keep
the documentation in-line.)

–Günther
