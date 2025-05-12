Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2768255F5F
	for <linux-security-module@vger.kernel.org>; Mon, 12 May 2025 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747087312; cv=none; b=mfPtUdJH+zxnBZTI6QXouv2jZG5LNN5chqOemMpeOKxJ4A07BYdUu8RxA5zXnFUC7sCX2aK8LpTxmlwJFfkQFsKPkZX7Nf9TtUt6w9JNqHzlr8cPyP9bEDlxPG5aLF/Mvl5v9rEBfNP0scekRSJw23rpnO8ioB6derfCd3rp7bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747087312; c=relaxed/simple;
	bh=rHfSaTbnyI9XoypCkJo/iUq/Y4OjgIW4d0dEWEOb4WQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qKOa0pCEgu+aAUm0TPbgdFJJv/5OYkxd/3zoWusrrq4rXgCF6S4Q/paFtiJXPXPca/gOWdeNyH/Upx0+G52OL2OfamUXH34pcLEwmjR7H+xjkJaMWFCa1ULiyB52gCJBtv00pMTvfVWZ57496Dp9c5D4PLiK3Lwc8fZaQOaCVA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZtEZgBw0; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZtEZgBw0"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-70a2d8a8404so42484937b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 12 May 2025 15:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747087309; x=1747692109; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XKie0IlRkp83iNNzrci+462IuBHk3Z5i8ViXJGbM2zI=;
        b=ZtEZgBw0GmHrKBzqkZyUxP7mkbD8/w0vn//14mhD4T1atH4bDu2pDSP46+cDLmfAPY
         ZI4MJ//OPOZlf9nwd4wVP5Xe8Y9DrKnmsgUmO1y68MZIRWaHL1OsGOFzAfK40sz+4giL
         mgJU2jOZvRFhkXm2qSi4InNudvUCgsLge5YbBhD5zVY37468STGiJOe5PMmBfPgs3FxW
         qmFU9FgvEhJSaasZbRMKjy7OW7qhraSdnYTu7f9vZWpqHvYGfQNyovl5kZLGZCp4+Y/l
         Whx9hGFvjrUamAFiJYOBG/YNAlg4LRwGaGoUS9nVHsQ2aBtWZu8rv3q3DhcsN+Cpb7uK
         IpZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747087309; x=1747692109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XKie0IlRkp83iNNzrci+462IuBHk3Z5i8ViXJGbM2zI=;
        b=Qv1YTlKMcmCooZwI9HlMZnC/X+uU2ab9ImQcm7/uzKv2oRge5CaYjJEYJN6dfPRzLf
         w/7ZHj4fxzya8RxZNQZMY0xazpZyeE865SWyCq3eKxfs3Z2sevpV9w/swzaqdPXAtrWY
         eOYHQjL65J+TEsnlOFUkExLXufupMW7aCBNVgdq4pp1l2R60cyWj0/pwa3JgpuxBjjOg
         jao9rmjHKIU/dozvLviK+SFi8DvkOrmj5DYGOGqUhh/1WdeXY0LovSNP4MthIFTWzx6n
         7NeL5MROTGNRFK30FdG0gVeDOTXYN3TCZMM6hUtUNyMcRcaNTwj2ZUW36Ulk8rZKkQx0
         uIrA==
X-Forwarded-Encrypted: i=1; AJvYcCUkOH82eZvRSfUf2Z/TLZzfmpQd6PoqJP84hrvHshUW1MyH7sMWkWVcKewbQ0bKBi5quPDhcT0NX/KB1bIL/uEvro9qw9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYC3g7XYRBlRYf+IaE9HYYOxLcW4yfX2A3GzcxZux+W+gCgf31
	8HP4OPNbkAb0dExciyvOJwcutMhASUSLekxVZZ4MtzbwQ4uCQU8rYGt6i00awj0SM46+hV3AHxM
	pM3T74paxv2KjaE8Vxum+Y6HJsL9F+fnlCoca
X-Gm-Gg: ASbGncs+Z71axo5ScDKjXq44LTaz2xGv2FxQz1UVemSEd1Nk8UTgGu9eBcgz9qWMsU8
	56pYNqQOz1YwM0hbNv/QDPx+beEYqjVo+KLwNI39BVQ8+U/6aQDSHH+VQwwEovMay2Os2rEYmh7
	JS7VoUVdyiej4+/kAuQs2nJc9yrMHnnDsy
X-Google-Smtp-Source: AGHT+IFOMIsPRB6N77R/jqBwaSjy0jmjto+6IHP1IR9XhbZIQXfDLlpLMX4TWO85MDI4QzsKiGldRFQrkRYAnblk9Us=
X-Received: by 2002:a05:690c:4b0f:b0:706:ac56:825f with SMTP id
 00721157ae682-70a3f9ec8e0mr191260187b3.5.1747087309387; Mon, 12 May 2025
 15:01:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321102422.640271-1-nik.borisov@suse.com> <CAHC9VhSpgzde_xRiu9FApg59w6sR1FUWW-Pf7Ya6XG9eFHwTqQ@mail.gmail.com>
 <67f69600ed221_71fe2946f@dwillia2-xfh.jf.intel.com.notmuch> <68226ad551afd_29032945b@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <68226ad551afd_29032945b@dwillia2-xfh.jf.intel.com.notmuch>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 12 May 2025 18:01:38 -0400
X-Gm-Features: AX0GCFtgJv-4_VcLPYA2b-6hwyHqoFeVQTahFrJ-tcQAIU0sDVq-uYd-lD9xr08
Message-ID: <CAHC9VhSyz2MqMjnHFbTiMqYvhAFZf162ZabnSsyyCQEZj-V9=g@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allow individual features to be locked down
To: Dan Williams <dan.j.williams@intel.com>
Cc: Nikolay Borisov <nik.borisov@suse.com>, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, kees@kernel.org, linux-kernel@vger.kernel.org, 
	kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 12, 2025 at 5:41=E2=80=AFPM Dan Williams <dan.j.williams@intel.=
com> wrote:
> Dan Williams wrote:
> > Paul Moore wrote:
> > > On Fri, Mar 21, 2025 at 6:24=E2=80=AFAM Nikolay Borisov <nik.borisov@=
suse.com> wrote:
> > > >
> > > > This simple change allows usecases where someone might want to  loc=
k only specific
> > > > feature at a finer granularity than integrity/confidentiality level=
s allows.
> > > > The first likely user of this is the CoCo subsystem where certain f=
eatures will be
> > > > disabled.
> > > >
> > > > Nikolay Borisov (2):
> > > >   lockdown: Switch implementation to using bitmap
> > > >   lockdown/kunit: Introduce kunit tests
> > >
> > > Hi Nikolay,
> > >
> > > Thanks for the patches!  With the merge window opening in a few days,
> > > it is too late to consider this for the upcoming merge window so
> > > realistically this patchset is two weeks out and I'm hopeful we'll
> > > have a dedicated Lockdown maintainer by then so I'm going to defer th=
e
> > > ultimate decision on acceptance to them.
> >
> > The patches in this thread proposed to selectively disable /dev/mem
> > independent of all the other lockdown mitigations. That goal can be
> > achieved with more precision with this proposed patch:
> >
> > http://lore.kernel.org/67f5b75c37143_71fe2949b@dwillia2-xfh.jf.intel.co=
m.notmuch
>
> Just wanted to circle back here and repair the damage I caused to the
> momentum of this "lockdown feature bitmap" proposal. It turns out that
> devmem maintainers are not looking to add yet more arch-specific hacks
> [1].
>
>     "Restricting /dev/mem further is a good idea, but it would be nice
>      if that could be done without adding yet another special case."
>
> security_locked_down() is already plumbed into all the places that
> confidential VMs may need to manage userspace access to confidential /
> private memory.
>
> I considered registering a new "coco-LSM" to hook
> security_locked_down(), but that immediately raises the next question of
> how does userspace discover what is currently locked_down. So just teach
> the native lockdown LSM how to be more fine-grained rather than
> complicate the situation with a new LSM.

Historically Linus has bristled at LSMs with alternative
security_locked_down() implementations/security-models, therefore I'd
probably give a nod to refining the existing Lockdown approach over a
new LSM.

Related update, there are new Lockdown maintainers coming, there is
just an issue of sorting out some email addresses first.  Hopefully
we'll see something on-list soon.

--=20
paul-moore.com
