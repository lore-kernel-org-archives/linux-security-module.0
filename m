Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073343321CF
	for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 10:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768126513; cv=none; b=J+uuGLdT1EBuagVstiRFpuplmKY3s3f2Xb3VsaK4fZCUd66uokEzn9nQgVqnyDm7bhmNoKpbWwdVAptj4h4SRdsrOS50227ZnnsmitGfp76zhMrEhPOzV9FjOX/C8jgBcs9Dk4Rx7WiM99/JcdzX+TpQm3aa6irq8VB6CH+Vwyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768126513; c=relaxed/simple;
	bh=fRI9eHxNTSBKeuwskp8MduRVZDQWZ6TQJVlDjJEl2y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6oU/rIK3qvrFfIxeL/agcpm/LVTPiJiM1ijN49MXKflwVb4BQgsAcvr4WnZJyF2RX3cKXaVApQAeC48uNflyUmaquav9QZp4rXZyIlgnad4oytNZ5cuvfYTTDe+Lue5b5Zuza6DLGN11fLYVrbcsrO44A0/EPpojh2KF5UrOWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mzZ+w31V; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mzZ+w31V"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64b83949fdaso9103295a12.2
        for <linux-security-module@vger.kernel.org>; Sun, 11 Jan 2026 02:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768126507; x=1768731307; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mtecyWu0CIlQbogybrq2ASaWoc+PqhrSsd/P3g74+NA=;
        b=mzZ+w31VhcMHtTj/kCSIZ0oYh6Kg+62HTDw2crtgblP46YZoP1vzdVYkjaDhsR6+81
         YE1JhcFZN+bNGtgwJcWfZA8L9UXHBgB1buVrkSVSetVbhVyysIxJZfCIkpV/xP9TKT4Y
         9O5pFO/AMKDsni5JLf4P2nE68N/qWCmboTmcKSJalHpXTLMM8YwjNAqKCvy934avdXKm
         m8RArfCQ18ZYACov7CzjIwKkglx+htw024pnuKlZCqDeClES1d8fXI9zibf7Ru9Qc05R
         SdZ+Sl/g2NXKxPNjXejvt3rwDdtpRZt8Y+DyEOwRy9ExpwPmDosTow0M1BK/la1DBwei
         nbsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768126507; x=1768731307;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mtecyWu0CIlQbogybrq2ASaWoc+PqhrSsd/P3g74+NA=;
        b=XP//FKdSC1IenLiQhjMuA+0iTUJzOvV8aOaRjOVBCAzHU7+o6VKpXNWTY5Ng5r5+mv
         HZUOg/8LM34GTk3r+7d0vASsC0ermI5/Kbrwe3Bu/yeQajkkpmaWoHZ6p93/+iiEO2qw
         cg8i3VB2aBI2aFCgaiU3ZNuK1Pr7OHagxAkfO68FHsl71zgIbt8zXNHzGuvd3ywj0VWX
         ebbtqYiO1W3KrlK5rfPWVUkrhgDSQsTubzQYj7g4xvOVq+kEKLzvCydYzghOX3KdMYs3
         kbMtZeNrG1aBGfv65/x5fQZtfsM01nyWhBfIhKsV7pzNSRpBg3PqJgYBCLIe6FaSGtFb
         WfwA==
X-Forwarded-Encrypted: i=1; AJvYcCXLQO9fskAut4SBEtadIrgLCc4KPDKHF9gKoDb2c6kwZqb9iun8MJNYrZDG6cGh3c92uhrXahvuC+QeVNvtkNEy0f3J9aY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHhSyhw++PW0i29kgeiWuw1B6rBvb53pQU03YnPNF21Ek1bfVN
	nyDyQv5P2t3tzjZ//EquLEKxQX81KH6EqmtWgd6LAy3JLVyv72mlZfKE
X-Gm-Gg: AY/fxX4DP4s7uvS+jMYhAdabbxW7a+6L5Y8LwV7g+GC2Aun1Gwtkpbry71P6vyleYSr
	sLKbPOFIUzaa20bILkN7kzTVAybfKWMbmqLany8eh05qqE8DdFSaLzrYKRNK7UYrk91tpKIH/ZD
	ZjI71k4oDWqu66nPst2yFyshLZk7fDfRFDYocoVd8Ss+Y/6J+RcCOG5eBcdOplBj21g80TuA7wX
	9sbuH+KYfF/rFVWntkW2wsPeF4NtXp6GsVLx8Cd/+Hx2FBWpINFI01xYBXBaIGY0imBRZynalF4
	LhFrnLIIvPVOibp7mzd2sf5BLobLVGOFmm+R+pwSWLuJWH0INEVLEvhqn0zkb3dFclTCVaPQ6HZ
	xJ+3vbCgSRAQxOekscNcyKykT0iMrh55dJQHkrK2PrMm81WaObeltqgS6efi2wT88/EPmFzRa2f
	bqk3Z1iKF05NeqDvSeUboG6mh926FArZiP6uXwpLtg5R/KbwU=
X-Google-Smtp-Source: AGHT+IErovAP5QmAXH8BBFB7PDareFDeaGgh+e0aBqEoFZmYVF6rIYTDd0VqnRMkgwW5suE9+iI8TQ==
X-Received: by 2002:a17:907:da9:b0:b71:ea7c:e4ff with SMTP id a640c23a62f3a-b8444c40038mr1359767766b.6.1768126506706;
        Sun, 11 Jan 2026 02:15:06 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b8706c2604bsm210733566b.16.2026.01.11.02.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jan 2026 02:15:06 -0800 (PST)
Date: Sun, 11 Jan 2026 11:15:04 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [RFC PATCH 0/5] landlock: Pathname-based UNIX connect() control
Message-ID: <20260111.bb3d6a4badd0@gnoack.org>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <20260109.she1eg0Ohl4u@digikod.net>
 <20260109.d4c29e22f15f@gnoack.org>
 <20260109.aiXa3Iesh5wa@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109.aiXa3Iesh5wa@digikod.net>

On Fri, Jan 09, 2026 at 04:20:49PM +0100, Mickaël Salaün wrote:
> On Fri, Jan 09, 2026 at 03:41:33PM +0100, Günther Noack wrote:
> > On Fri, Jan 09, 2026 at 11:37:12AM +0100, Mickaël Salaün wrote:
> > > As Kuniyuki pointed out [1], we should handle both connect and send.
> > > This would be similar to the scoped restriction from Tingmao.  I guess
> > > we'll need a similar hook for the send operation.  Because there is no
> > > need to differenciate between connected and disconnected unix socket in
> > > a security policy, we should have one access right for both.  Any
> > > proposal for its name? Something like TRANSMIT_UNIX or EMIT_UNIX?
> > > 
> > > [1] https://lore.kernel.org/all/CAAVpQUAd==+Pw02+E6UC-qwaDNm7aFg+Q9YDbWzyniShAkAhFQ@mail.gmail.com/
> > 
> > Ah, thanks for pointing it out.
> > 
> > The restriction as implemented in this patch set already solves this
> > for all the three cases where a Unix socket file is looked up.  I
> > believe that it is happening in all the right times (everytime when
> > the lookup has to happen).
> > 
> > The cases where the restriction applies are the following:
> > 
> > * unix_stream_connect - when calling connect() on a stream socket
> > * unix_dgram_connect - when calling connect() on a dgram socket
> > * unix_dgram_sendmsg - when calling sendmsg() on a dgram socket
> >                        (per-message lookup only)
> > 
> > You can find the code locations by looking for the call to
> > unix_find_other() in af_unix.c.  (That function invokes either
> > unix_find_bsd() or the lookup for abstract Unix sockets.)
> > 
> > In the unix_dgram_sendmsg() case, the lookup is only performed if an
> > explicit sockaddr_un was provided together with the arguments to the
> > sendmsg().  (And sendto(2) also uses the same code path as
> > sendmsg(2).)
> 
> Great

FYI, V2 splits the access rights for the three UNIX access types
SOCK_STREAM, SOCK_DGRAM and SOCK_SEQPACKET.

FYI, I double checked that the logic extends cleanly to the
SOCK_SEQPACKET case as well: SOCK_SEQPACKET is implemented as a thin
layer above the existing hooks for SOCK_STREAM and SOCK_DGRAM - it
does connect(2) with the SOCK_STREAM implementation, and it does
sendmsg(2) with the SOCK_DGRAM implementation, but in the sendmsg(2)
case it removes any explicitly passed recipient addresses beforehand.
(See "unix_seqpacket_ops" in net/unix/af_unix.c) So as far as the UNIX
path lookup hook is concerned, SOCK_SEQPACKET behaves like
SOCK_STREAM, and only invokes the hook during connect(2).


> > It is true that the current name for the access right is slightly
> > misleading.  How about LANDLOCK_ACCESS_FS_UNIX_SEND?  (Like
> > "transmit", but a bit closer to the naming of the sendmsg(2)
> > networking API?)
> 
> We should try to keep the access right naming consistent:
> LANDLOCK_ACCESS_FS_<VERB>[_NOUN]
> 
> What about USE_UNIX, or FIND_UNIX (closer to the kernel function), or
> RESOLVE_UNIX?  It should be clear with the name that it is not about
> listening nor receiving from a process outside of the sandbox (which
> should have its own access right BTW).

Thanks, changed in V2 to say RESOLVE_UNIX, and also split up the
access rights for the three UNIX socket types.

(For reference, the path_resolution(7) man page [1] also uses the verb
"resolve". I think both "resolve" and "lookup" are used exchangeably
for paths.)

[1] https://man7.org/linux/man-pages/man7/path_resolution.7.html

> > (I guess the other alternative would be to wire the socket type
> > information through to the unix_find_bsd() function and pass it
> > through. Would require a small change to the af_unix.c implementation,
> > but then we could tell apart LANDLOCK_ACCESS_FS_UNIX_STREAM_CONNECT
> > and LANDLOCK_ACCESS_FS_UNIX_DGRAM_SEND). WDYT?
> 
> I think the hook should have the same arguments as unix_find_bsd()'s
> ones.  This gives the full context of the call.

You are right, I had not recalled that the socket type information
already gets passed to unix_find_bsd() - it required not much
additional wiring at all, in the end. 👍

–Günther
