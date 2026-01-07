Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D53A0B1B
	for <linux-security-module@vger.kernel.org>; Wed,  7 Jan 2026 16:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805077; cv=none; b=sC0+pQnCSqZhQix28ft3gRa0oCR684t9YzSMSpj42RkvhZETwCzqlQnv0He/qeucmTRuFR0+NEYPcakbV5hjjoYLxiolYO2+SmrwbqjRt9tfEMcBMenJAeCV4BS5h7cGD8GIm0oj9C1/tgtY2cv880fJ0mKOT3VohpL62nhbFvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805077; c=relaxed/simple;
	bh=oTh/Bm7Bvc5pQDGtio2WHmCSYQcQfl+HLeQb6+ZuPa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCapG6LGImcOKw35MEHff82o7n4wgtd87RrU2tJBoYg1TX2kLfZFKtdwBMznKNkwz3SkX5lwhftfPTk6XLjwYfKO2n9bjGhcL83nDANyVrvlXCtzNv7P/eHiEndWya4LkM3zuHZoXWhgbNn5ozxzoRDmbePxZfRe50J8CRrIb+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WNb+a3iI; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNb+a3iI"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47755de027eso13834425e9.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 Jan 2026 08:57:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767805070; x=1768409870; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9cVSMIV0M1vHEkGoca4IYHePZY2mIben9Mxd1bnOl0g=;
        b=WNb+a3iI069+UVfkyi0mdxhz3UHcXoR2Dks6g/Zr5duayBmAFceV4VkycZSQSpNejh
         HLZlFMYjlGHuAd5pKPpyck8hVhyA2qdSQS6CJ0AFLDAqOnmDIgtA5UrRPi6TgeY3OBXb
         M7jL5UtGiyEB5/LAvkngUsdz8mpiVg5rAWbvbWb69JZ3mBVLfT4SVX43b32nfuvyPxDS
         oVaOjdXCtPvHyFZkhXo97/vde6t2f3pdnBRP4enQVaZtjMSYvHnmG3e3qQ/L9D7r8sEL
         vxr5lm3h5pey/t84dNgdBxUxJDBVt3m5XkrlodFszwtaV2LuITUgssDn6gLTPFbCNLb7
         sLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767805070; x=1768409870;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9cVSMIV0M1vHEkGoca4IYHePZY2mIben9Mxd1bnOl0g=;
        b=HDQ01XYOpXFMjqhU6BHr6NShd6Zbn+8QXT08HvHfGANg/6MTbrGfvT12wd8oKLVRxQ
         +mvd8/FELLngI5nCb3HKTdInfs3/jXkTU4ZHY+d5MohkfWvi9MOJTUvrlZLRwnwo6PTY
         UjhyOVucdVNPAa5hEeTYZ3svQWw0LKnc/gyNPK9GqPVNlZagdbANdrG1lfaixd/1RXXI
         3bQWwwlGuLHfQyy8cranRtugaGnDkd0J0pLVpBz0h9rowiIriJSBTRo8zYKfTRhrIoqt
         6F4Yo8Kioa3Kv5NxU1t6Tgs8d280GPHL7dQia+TiLBPlYB4AE1is52mUEZzrY+j+rXd7
         bkQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKNZf049Igc6b4lHzsFGi4YpQZHyWzkmnodT6qZN5fNwVlURjGT7o7WBAG6ovss6kEKIVb2rV/6QLvR61mh4DEc24SAC8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2tuGc2XfkHGMht7ka1KM/xbr16hfKLBUzSoaqauxahiSCEmAt
	s0JcsdQs8uVwBnWoVyMuhUuIJ2oy1bH4PvfFlAcK8hv/lKiI36kESmDQBykRM53lFjiNN3m3sb7
	L4f3tevwj
X-Gm-Gg: AY/fxX5uRDD4uZERlu71sVzeIQGo4WDmcDwk4mThuZZkxZIPA0LVU/THgbPleha8Xx8
	mEkTKDrWChpykLMvmjPR1nbH7L4iJG8ALmVRlzKT8xoOOX9n3MH+oYeZ6AT7sRmziEVm1A+c5os
	ZkVTHkvzVDHNjr2D36SQPJQlCStgVzM9UCQQ74p1Slvc/ACr3P4QZcFXDM/yWIKjJZYC3Y0u12y
	hj7iwVJvrNqBQGh1bhKEKBbAB/5N5z/CIRufvsGQvVyBqRphv3bWujdSSJbnmE6ywuacHlo2L3W
	eyXm8M0b3zIhron8hdIUcu8PRlF6qTSNB3QscdWoxPtZ/tcKNXIq3Kfvr601GT5GJmYacmAjORm
	0KEbgsVNocNJ/QMOgl0NrdtgFNbsONPGq72QqktXj1M9GQK/Kihcb4m4qn2sYBDDqGM17xKYVa8
	CMBr1waUZPaBDTtuhGOedW6QnNPZ9DTcIg4vFDyKTXIA==
X-Google-Smtp-Source: AGHT+IFNWlJitUC1NSOuwXl+nF0iGIoib1vo+UR+IFwK8+8wYGCEbPSdCgCOi3fSLDFCBKtQyHctnQ==
X-Received: by 2002:a05:600c:8b2c:b0:477:7f4a:44b0 with SMTP id 5b1f17b1804b1-47d84b3ea06mr36754095e9.33.1767805069507;
        Wed, 07 Jan 2026 08:57:49 -0800 (PST)
Received: from google.com ([2a00:79e0:288a:8:aaba:e2c1:29df:3e24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f41f5e0sm104518655e9.8.2026.01.07.08.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jan 2026 08:57:48 -0800 (PST)
Date: Wed, 7 Jan 2026 17:57:43 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Justin Suess <utilityemal77@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	Simon Horman <horms@kernel.org>,
	=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
Message-ID: <aV6Qh39jVg8trMlg@google.com>
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
 <aVuaqij9nXhLfAvN@google.com>
 <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>
 <2da3f1ae-1fe1-40c4-8748-9fb371e696f0@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2da3f1ae-1fe1-40c4-8748-9fb371e696f0@gmail.com>

On Wed, Jan 07, 2026 at 07:19:02AM -0500, Justin Suess wrote:
> On 1/7/26 02:33, Kuniyuki Iwashima wrote:
> > +VFS maintainers
> >
> > On Mon, Jan 5, 2026 at 3:04 AM Günther Noack <gnoack@google.com> wrote:
> >> Hello!
> >>
> >> On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
> >>> On Wed, Dec 31, 2025 at 1:33 PM Justin Suess <utilityemal77@gmail.com> wrote:
> >>>> Motivation
> >>>> ---
> >>>>
> >>>> For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
> >>>> identifying object from a policy perspective is the path passed to
> >>>> connect(2). However, this operation currently restricts LSMs that rely
> >>>> on VFS-based mediation, because the pathname resolved during connect()
> >>>> is not preserved in a form visible to existing hooks before connection
> >>>> establishment.
> >>> Why can't LSM use unix_sk(other)->path in security_unix_stream_connect()
> >>> and security_unix_may_send() ?
> >> Thanks for bringing it up!
> >>
> >> That path is set by the process that acts as the listening side for
> >> the socket.  The listening and the connecting process might not live
> >> in the same mount namespace, and in that case, it would not match the
> >> path which is passed by the client in the struct sockaddr_un.
> > Thanks for the explanation !
> >
> > So basically what you need is resolving unix_sk(sk)->addr.name
> > by kern_path() and comparing its d_backing_inode(path.dentry)
> > with d_backing_inode (unix_sk(sk)->path.dendtry).
> >
> > If the new hook is only used by Landlock, I'd prefer doing that on
> > the existing connect() hooks.
> I see. Did you have a particular hook in mind to extend?
> 
> One complication I see is whatever hook this gets added to
> would also need CONFIG_SECURITY_PATH, since logically this restriction
> would fall under it:
> 
> From security/Kconfig:
> 
> config SECURITY_PATH
>     bool "Security hooks for pathname based access control"
>     depends on SECURITY
>     help
>       This enables the security hooks for pathname based access control.
>       If enabled, a security module can use these hooks to
>       implement pathname based access controls.
>       If you are unsure how to answer this question, answer N.
> 
> config SECURITY_NETWORK
>     bool "Socket and Networking Security Hooks"
>     depends on SECURITY
>     help
>       This enables the socket and networking security hooks.
>       If enabled, a security module can use these hooks to
>       implement socket and networking access controls.
>       If you are unsure how to answer this question, answer N.
> 
> Logically, this type of access control falls under both categories, so must be
> gated by both features. No existing LSM hooks are gated by both afaik, so
> there is not really an existing logical place to extend an existing hook without
> changing what features are required to be enabled for existing users.
> 
> I do see more uses for this hook that just landlock, bpf lsm hooks
> or other non-labeling LSMs like apparmor or TOMOYO could take advantage
> of this as well.

Apologies, I overlooked your reply earlier today.

The existing hooks that are called from af_unix.c are:

- security_unix_stream_connect() for SOCK_STREAM unix(7) sockets
- security_unix_may_send() for SOCK_DGRAM unix(7) sockets

Apart from that, at a higher level, there are also

- security_socket_connect()
- security_socket_sendmsg() and security_socket_recvmsg()

These are used from net/socket.c.

For the connectionless dgram Unix sockets, we would need to tell apart the cases
where sendmsg()/recvmsg() are used with and without a sockaddr.  (Dgram sockets
can be either connected with connect() and then have a fixed sockaddr, or they
can be passed a remote sockaddr with each message send and receive operation.)
This can told apart in security_socket_sendmsg() from the msg argument, but it
doesn't look like we could tell it apart from security_unix_may_send().

Landlock already depends on CONFIG_SECURITY_NETWORK and CONFIG_SECURITY_PATH,
so we would not need to have further #ifdefs to use one of these hooks.

There are other difficulties I found which worry me and which I listed in the
other mail at https://lore.kernel.org/all/aV5WTGvQB0XI8Q_N@google.com/.

—Günther
