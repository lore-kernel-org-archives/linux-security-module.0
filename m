Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E288F3587CA
	for <linux-security-module@vger.kernel.org>; Fri,  9 Jan 2026 14:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767969699; cv=none; b=rex4hIOsEnP+1qK1EHuhfTncjY7HT+XMHGUnj7VUzAbM8XkqhfXWmoWj9RnJrXtVQSJYTAmxsUxvFX0B/U6nIoTbMPXgpEd3b9NUf6PfvVFnfdjreyC2lsy1hso7/DWNqMsA5uCjG+MzYngtwrdlgAK52bMzYfDfw0oOC0dQuLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767969699; c=relaxed/simple;
	bh=Ef5Cwxb6qBuR3QSsA8pD2M2d87FH79Nbug+vTjKHD+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G+50hPDvmV/3hHT46m3/ehpgxixcjidPuT2nZk7HR71m+iDZASMcBq51PL8zUgQVwmw16W5E85q9fH2cTHr6G4VQaphGQ5w4uhAWLH1Q457mMjnCpBpy8tSj5eIFL7bDyn5LBMREPrr65ovkmwtjhCJASOYVRPDKiHJ6/1X/1MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IE8HJ8zk; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IE8HJ8zk"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b725ead5800so603236266b.1
        for <linux-security-module@vger.kernel.org>; Fri, 09 Jan 2026 06:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767969696; x=1768574496; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GNty8eNpyiy41uWb+2ldzPCPkOq0IkaY2HLXGaT/y3U=;
        b=IE8HJ8zkgRzDEQ5ClKmgSGo9fKWQNelxVJBDg11iqqMbHy6a7uPb2WxP3E4rReJcnN
         G5hAvr2Innnm8XF/r5qHhZVIWR/Kr833WK9+8kHV/FZ9D7s01xbsCXMxeiuSai5xexWe
         Jk5wNf5P4CfsNTe1xp5T3zfDzz1Hk8tsIdY2jO2IEQ+ZLN0sWN0yQ62+w3cBP2525u62
         ZICOaZFvZBXXhP19LAUtm0liIBZaeuJhUevT1Qb0l0YsPCks5tKBSYTpEGqXs5Xl8xeT
         +c2kytgIsghWvCkT7I7dcEE7//wA4XTm7Q85sV5VSE3Y+GDGR5lUcJULROyIE7noK0GO
         GFOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767969696; x=1768574496;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GNty8eNpyiy41uWb+2ldzPCPkOq0IkaY2HLXGaT/y3U=;
        b=Su1rFq6oJxf2sftiZbt4Q1JupqBKQl6zBoiDH4/urADfORHSrW521mmXwtidu3KpWN
         5D6aN4ovlKCUuBwsCzVdMc/V3KvJQCI0skh5LOrS4YLCJoQTEhiTAXl/HP+79IO2Js4N
         lJP/Ghm5srU/QjALw+IWN1rMWbNRLeel/NY++CqKu+c9AqMsCFDG/qh/bQHtlwm9gEmQ
         dfcnW41rtbQ9piXGKrdgTYPxax6j3cAYaQVVFFHvV/S/io95pDAh4fM6c37du3Mbhnhp
         FQGbRa9f8VU101DHZJWfxcgNO9sfEVs5R/aCJxOgyeF5JOM7zG1dYrikPTVPjcSmcXpb
         L4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUn0wH1YWJOuEtI0gE/+GpFWzUbnQL4Uun+euLZreZUwF50u1U90+unjhCnDNqwokOlMsA0r+9zwhNdzUlCQeVwoxcgV1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIKi9chqVPnAsjjJmdAhcvBzK4g1Lsb2y33uNjHdGBNIKhuCaW
	DZlHzXoUrOiK28yuIAXN/CrVwXzvVvVnBYbtKieqRdB8yIDDw8H2Q6KU
X-Gm-Gg: AY/fxX4/oWEtxTMaJRPt4Q36VFr492X/ENNpegIZZMLZO+c/65+febSdHUe14ryouUt
	c9etyxCbuU925sB0iU8psoV8Ep4vzc2X4LHhi/3jh/GgUz9M31FS8FklrbIdhX3WZib6Atj3x5g
	k8YZQyUcwmYuJcTnnLYI0InH772/WtfU5LPPX10L6zttTPMjjhAzI1KQ2ei9eCFM5+yPs2gisG7
	lXmy/hNHqGvdPvvW5dywzPj2gkW+K4M7rLsemGspF58iJrb+g6iI7ZB9CWCFQftQ3Wl4muFjUXL
	jnYOMAobinR4HkcRdxQAQlODhHQk4bHEPi852vQFhz8Y0FD/IZnvLfJodowZHKpQDCZpU1pQoPR
	L4sstzBCH+b616gFipnQpZcb/IiC8hBKI4vPJopPguRK4z6vThqkcdCgftwo6lSR97YiyFyeOwO
	D7nfo20MidUqBH1qtitzEUAXyU16JrQuHqZQ1U
X-Google-Smtp-Source: AGHT+IH0D6HZCJssgtbzOMGAOE4P2LAAbB+FIOKqzXNOQ7u8doLYWLzHHQQpDmqwQBATl2gZDfy9JQ==
X-Received: by 2002:a17:907:3e83:b0:b84:2b70:98ec with SMTP id a640c23a62f3a-b84453a51b6mr986494366b.42.1767969695924;
        Fri, 09 Jan 2026 06:41:35 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6507be658b3sm10358002a12.18.2026.01.09.06.41.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 06:41:35 -0800 (PST)
Date: Fri, 9 Jan 2026 15:41:33 +0100
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
Message-ID: <20260109.d4c29e22f15f@gnoack.org>
References: <20260101134102.25938-1-gnoack3000@gmail.com>
 <20260109.she1eg0Ohl4u@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260109.she1eg0Ohl4u@digikod.net>

On Fri, Jan 09, 2026 at 11:37:12AM +0100, Mickaël Salaün wrote:
> On Thu, Jan 01, 2026 at 02:40:57PM +0100, Günther Noack wrote:
> > ## Motivation
> > 
> > Currently, landlocked processes can connect() to named UNIX sockets
> > through the BSD socket API described in unix(7), by invoking socket(2)
> > followed by connect(2) with a suitable struct sockname_un holding the
> > socket's filename.  This can come as a surprise for users (e.g. in
> > [1]) and it can be used to escape a sandbox when a Unix service offers
> > command execution (some scenarios were listed by Tingmao Wang in [2]).
> > 
> > These patches are built on Justin Suess's patch which adds the LSM
> > hook:
> > https://lore.kernel.org/all/20251231213314.2979118-1-utilityemal77@gmail.com/
> 
> As Kuniyuki pointed out [1], we should handle both connect and send.
> This would be similar to the scoped restriction from Tingmao.  I guess
> we'll need a similar hook for the send operation.  Because there is no
> need to differenciate between connected and disconnected unix socket in
> a security policy, we should have one access right for both.  Any
> proposal for its name? Something like TRANSMIT_UNIX or EMIT_UNIX?
> 
> [1] https://lore.kernel.org/all/CAAVpQUAd==+Pw02+E6UC-qwaDNm7aFg+Q9YDbWzyniShAkAhFQ@mail.gmail.com/

Ah, thanks for pointing it out.

The restriction as implemented in this patch set already solves this
for all the three cases where a Unix socket file is looked up.  I
believe that it is happening in all the right times (everytime when
the lookup has to happen).

The cases where the restriction applies are the following:

* unix_stream_connect - when calling connect() on a stream socket
* unix_dgram_connect - when calling connect() on a dgram socket
* unix_dgram_sendmsg - when calling sendmsg() on a dgram socket
                       (per-message lookup only)

You can find the code locations by looking for the call to
unix_find_other() in af_unix.c.  (That function invokes either
unix_find_bsd() or the lookup for abstract Unix sockets.)

In the unix_dgram_sendmsg() case, the lookup is only performed if an
explicit sockaddr_un was provided together with the arguments to the
sendmsg().  (And sendto(2) also uses the same code path as
sendmsg(2).)

It is true that the current name for the access right is slightly
misleading.  How about LANDLOCK_ACCESS_FS_UNIX_SEND?  (Like
"transmit", but a bit closer to the naming of the sendmsg(2)
networking API?)

(I guess the other alternative would be to wire the socket type
information through to the unix_find_bsd() function and pass it
through. Would require a small change to the af_unix.c implementation,
but then we could tell apart LANDLOCK_ACCESS_FS_UNIX_STREAM_CONNECT
and LANDLOCK_ACCESS_FS_UNIX_DGRAM_SEND). WDYT?

–Günther
