Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F402931AA83
	for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 17:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769102847; cv=pass; b=hMHQ1oikhsZGMuKgRACat5cuP+9HKcswMN4kb8cV7zVaBLfB6HDcglaYmpxo7z0+8J03XH7m6GLIjqZeMQQUDJn3BBss5JeYnQEDoQyP38v1d71orglW6yxAj2f8oV9V0SoGWyV0RpNYmV6jYfELqJWduE65Rd1wy1e6VnAgM80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769102847; c=relaxed/simple;
	bh=i8wRRwgcRBRX/QtBIFh7w+tGkhK9mt5SnMal1LQmNU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4C36rOyid3162pz1SSx3C6+W3HQKQhCmRVBDnh3mL7MgBGIqUXoW74CllX29B+0xRmLHAyhnAInWLOeBCD8GdB5efHV63bWaz9UWPRWNpv3Voy7gvq7u+uwwkmAhuzOfZcZyOmFmjdYom3k2tXtHDdqJCQuKdX6GKHwvnEtUbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=TIpC9eCY; arc=pass smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="TIpC9eCY"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2a77c1d5c3bso5878835ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 22 Jan 2026 09:27:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769102832; cv=none;
        d=google.com; s=arc-20240605;
        b=Y+zTFs8BMFOkplFHbvpydTnzKwON2+VdnBQ0jjq8nBU7prqeP2AWql8tm425H/w6KI
         iWqVRTnBeK7e5JfzlxVa5T/wBz9I4tRq/nCcTF7hFm9t6DmyXiihmCdtzPn2AVhVOKTL
         BKuWVlaqy1m8VHPDV5/GS2sfA1MUZxzuNsQJXVU5xhuZFZyq02GgSPXH/dIQXXEP/pRP
         d6Pf99Po72SFjcuFibEndGGJXs1FHVkkkM40JtJq0UcWS50DzTgUTQDHXNTDGChFOqxB
         7Ayeew6OMx1MwMT0P/l0c93z8JptoMbkWVkxk/kg4UZaID/bOm3bxjHA5heIKVWFrVBh
         u1fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t2OpF/78edG0DEw7aAeFXM5BMMrCw0GoSViw0JiFp8k=;
        fh=BzQNUJryaJNWU/xwVeREfCDrjEj17RmskTmVJozZXxI=;
        b=M6r/38W6mgRvzbKRmpz8D7v+cOZnpI4yWqyn4VaBWAGPyNcAgZoi5alJt3mIx+wLYA
         edslUjqMJfYozohw1puL7Ds7+xzh/YPOhk1tQBH1Dteji/yv2BLCkdILTLwUcZ7FG1Yr
         jy2vvcekM0lNpBTWGlnIBuNXWUTZAravPUa6GEmmKl+8Esps7SL6jQeIIcVBRx0PPOdW
         PyreKpnDouHekI5zvJ9RVKhiYksjGXQAsQWlKIIKGUVTW9A/tEirqgRSuP1tGFuieSWK
         Xi6MD1HWNDucgRWHjSVolEAI/1wCUKcwneFAolztRaU2S1k7wcteyfvPEtFZsD/NcUJ1
         QasQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769102832; x=1769707632; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t2OpF/78edG0DEw7aAeFXM5BMMrCw0GoSViw0JiFp8k=;
        b=TIpC9eCYYmP/8eAsufXnWfk19A6gwFSMJhwsyZO6KpJQLjosuWfxLdcSL4wS1GlXcw
         Ug7TJlzwAai2JjaVu9fkv048nDt7ajKnPypGlD20dtrv2G02hzpL78SewscmE9TcAmlC
         4fWeubFHYy2ub1amXcLOFPoywOWGlp4BVA2a6KX/FnV/6l2IxuBNFp8i/WIdaKFbx95y
         De0TK8thxowJW+DfGSF1QtBadyzK6CAfXiOqu+ENMGrK8VMZMgsBJFqsqi6jCoQw9CXJ
         /jArDod06bGKlyOC2nA7YxZfVFStgPbp0RfcizS2BE5l3vEchsykK3zzHEDXevErnCQU
         UO8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769102832; x=1769707632;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=t2OpF/78edG0DEw7aAeFXM5BMMrCw0GoSViw0JiFp8k=;
        b=LCbYb22HzAipDJncUVCryET0t1wY1XVowRwMPMNgCtqGjv/7t5BSoGkREKuNdpzGoj
         nV/bZZe6Ob1JSs+5wx4mnbetfnu0uH6mL7y4brz+1PFO18tOde4281988qB82dRETsiJ
         pW/t2sqasuHWm8c/XB9d3OkDjY2WQzy7WQ44yeffy5Cx4fV+xA2+YOK0AS3kaZHfhEM2
         RxwDP3nDhV+XjmorH+8yJTIg0YAfXbkPeJBzhrIh9u/XfuAtPCQ+1qjpbK72agH8iCKm
         T1dd1IFP+2Gls7aZBK53AhXu2ZoR7ZoehqrT6THEvoF91A1ME/z6hZ/4t6p0Qt1AG+XH
         nBjw==
X-Forwarded-Encrypted: i=1; AJvYcCWTDtukj0TEgUb1nIr2T9gAb7t94+2z/FQX8l601WeqWF64chrVBr2iL4B8qrboaWuDFwjM/ukzq7d4qteogjOWxdn5Rjs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd2wBxCrEMG7FR7MNkyU9BkZBIfsqEVSLEg80FiAGoTkuhm9jf
	mLwMu9H7gFTi/l+zzdI2K95B8OdjDbjDYIeJYquFQo/PGNQcmPKP5RwGP5JJ/caEE3zj81Lf6dX
	2Pp5HSBsJK9tbF+cq5iG6yMmKZ2y4Nh40dMvJtrTu
X-Gm-Gg: AZuq6aJKnCye+e3JriqHOSR18js7wKmorny7FNNptpYRWAMLg0siIR4bqgN27xNvKZF
	NqI6GIRmhYg6vnNff829Gfb7p45jwyL/IX4jXVaRqSeC4Li0Y2+9AeuGtdWa5XugqQNISJ0lXtp
	xWullpFCgp7esUitGxI5frFDuTMsiWXKkcS2jeJTM8h6zWjrvy5IDFzkxui2JLiSaMzIMKnmKTl
	DqJzyS741WxJrXZeD+f9ApkOjxnWUCcvb9rlf6nIHRFXxEQHyiQRThjbJrwS49pAMqQrrU=
X-Received: by 2002:a17:902:d4c8:b0:2a2:dc3f:be4c with SMTP id
 d9443c01a7336-2a7fe442a86mr1368065ad.10.1769102831964; Thu, 22 Jan 2026
 09:27:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPhsuW4=heDwYEkmRzSnLHDdW=da71qDd1KqUj9sYUOT5uOx3w@mail.gmail.com>
 <CAHC9VhRU_vtN4oXHVuT4Tt=WFP=4FrKc=i8t=xDz+bamUG7r6g@mail.gmail.com> <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
In-Reply-To: <CAPhsuW6vCrN=k6xEuPf+tJr6ikH_RwfyaU_Q9DvGg2r2U9y+UA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 22 Jan 2026 12:27:00 -0500
X-Gm-Features: AZwV_QibKES0kD4tscaEcwePngrOSwTB4wIlklspWkjv8E3aPoOucAI-iTyzcnk
Message-ID: <CAHC9VhSSmoUKPRZKr8vbaK1222ZAWQo51G5e3h65g135Q3p8jw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Refactor LSM hooks for VFS mount operations
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, 
	lsf-pc@lists.linux-foundation.org, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Christian Brauner <brauner@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 21, 2026 at 10:00=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Wed, Jan 21, 2026 at 4:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Wed, Jan 21, 2026 at 4:18=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > Current LSM hooks do not have good coverage for VFS mount operations.
> > > Specifically, there are the following issues (and maybe more..):
> >
> > I don't recall LSM folks normally being invited to LSFMMBPF so it
> > seems like this would be a poor forum to discuss LSM hooks.
>
> Agreed this might not be the best forum to discuss LSM hooks.
> However, I am not aware of a better forum for in person discussions.

The Linux Security Summit (LSS), held both in North America and Europe
each year, typically has a large number of LSM developers and
maintainers in attendance.  The CfP for LSS North America just
recently opened (link below), and it closes on March 15th with LSS-NA
taking place May 21st and 22nd; reworking the LSM mount APIs would
definitely be on-topic for LSS.  While there is a modest conference
fee to cover recordings (waived for presenters), anyone may attend LSS
as no invitation is required.

https://sessionize.com/linux-security-summit-north-america-2026

The CfP for Linux Security Summit Europe will open later this year,
you can expect a similar CfP as LSS North America.

https://events.linuxfoundation.org/linux-security-summit-europe

> AFAICT, in-tree LSMs have straightforward logics around mount
> monitoring. As long as we get these logic translated properly, I
> don't expect much controversy with in-tree LSMs.

It seems very odd, and potentially a waste of time/energy, to discuss
a redesign of an API without the people needed to sign-off on and
maintain the design, but what do I know ...

--=20
paul-moore.com
