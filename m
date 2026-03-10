Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE1295DAC
	for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773167095; cv=pass; b=ELzN8ZytDx5pFZXimc4K7XOzKmZPSDBYpgWCU6x1M+yEs3HLcSHVGHw/cMKch2kpM6IUg3aDIUmu2RKJytV4JNX+n1f8uNondZhBoWRDGmk74TcsPFD/KwDyiXiCDh/ymZOB+EUnG6aXYPi4tVOpf6e9sjith9noPb+YqJwzSq4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773167095; c=relaxed/simple;
	bh=DNljjTsXDTz9AmTMKJoCY/iqU+57dyRUyrXu/iyiD/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QyuNKirM10vel363qlyBnCDhObOvfiDJXh+bvNFP/wXWWbxZGIDhwS7heKEMRTeR3uJUoN6F7OzD5R/AD+CmRnMh04hZJMrNVZBxFKVBu689Z5FZ8u4LEPJvQhmy/HVb68BXB5FTVmJ+1verm4eBGfXFCk61SbL9fu34PbjkE0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dW2GKaP6; arc=pass smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dW2GKaP6"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-829a27414a3so2579142b3a.3
        for <linux-security-module@vger.kernel.org>; Tue, 10 Mar 2026 11:24:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773167093; cv=none;
        d=google.com; s=arc-20240605;
        b=iZnn+6PEzcl7nBpVScTdjfTEGt8sb58Tbe+RwuBjH+nXEUWndQl5nMviN7myJhq6Ei
         e136zle6dfEcx8mQ0TfGAfH1gyltQtKA8zNqp8rShhk+D06RJ5et44VBLv+K0ERfaVgA
         3Ofb31ZwI4bWby1+COqFZleo77bWHNCLZZCI4YMa4bOAWy0my5AgzmfAJnkj8QPPYoQq
         v8JrCF1W/Q6m/9pT4N8j3N/wCrldQqH9G1JPTEhg/r5XuBj2pS7PcvYrSeLbd9kDxhoM
         e4WUoXu/tI11SxhiKZiZB8yveTxQWYaMoWokBh6sKYQSKnFlOCNt5eARMPaVoLvdSsYG
         6szg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ow19yV1kpEamONOgB4zylv1tLaNIWkTk676jBhWRO+c=;
        fh=fGYvJNQ/+GltsF6epk8k+G9meKBBroJ0eK8Pivlam5o=;
        b=A7KII+5hFpgNmy3d1j1f2Qvxe8i2iIj3dpMxl1zLTF3nq5nsUQZqp+PTwYPpIUYX1M
         OPfsyy8gKMHArCdku1cns1ADnUbEyE+Ci+YA0wh6zPYNPLIKe3LNRovT7WS0L/qc9JKN
         agSdofakY7yM9rwWqeNhqGmjTK4Tfz/i2a8yhWy4me1q/18pYiE0WLlAGXc5b48kG9GP
         XRiHsL9RfeTURUNvJLUsiYnjYObcrY47Y3XMVEso2HPWNYjLylCu2jXPzylrGDQkCKzl
         KBPP37mBzCSbtf2euAdPgP0HAruYwUIp+RbuxQBnAoBBnp5a0LxBvf7F7giO7P72JNT3
         KBdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773167093; x=1773771893; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ow19yV1kpEamONOgB4zylv1tLaNIWkTk676jBhWRO+c=;
        b=dW2GKaP6C4Xh5jwCOkvlNf2RsFsyFhn7kIDaDNyhhxTv4wW2dX9G3sB3B7qUj2R1se
         qYM7SbxmAEpke0lcXjsv5eE+hYERZPCPY+UftYlcX3hJtex9kfplGJny/rzovWrZBPdb
         DOgN4UGI7FnkCp89mG0Eq1U0EHMcRDJxc8SRPJaIP7QHJJCy/laRfc2JV7P+fkMpskUP
         Pdr+cz/Nz+bgpewAskYBrE22SN5V4lrZ5bOFkcUReWlU3G5QrPeYlkf+UbdZnn3NkP4O
         DdNCrkbvPstMRE/svBOL4clE+zOWWhRDwhChyGZgNZVbv1m9uXd2YIaXotxBYYhY4MBQ
         zUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773167093; x=1773771893;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ow19yV1kpEamONOgB4zylv1tLaNIWkTk676jBhWRO+c=;
        b=hxEi00d1ZYNgIGlk1BE9T+xrVzGlR/uZI+GENZoDjGBS3NakF5bKzwh5PqehNBB3Py
         kg6xCcoSlpZfDBuzAYPD3zYqXlHvF2wBKbTqHedl4TVbVmykhM2luQGpuWF8Nl9xP4Ps
         O8SAojNrunfa9N6HE9uHitLULS5JQSiTA3jJ6nGggWME38LuPYHGePF9I7AmxGeVkwiZ
         xVw51hmaclLDy9tMvdKClbwZIJumeyvT+UDnYOCz6ywxX6ecovdGWz0pm0ahV75VBDx3
         9+NXLcFtR/mNtZfHnmVfPTiHmrprit1SwwmkLKpg+tlStefmGgbmP3C9bhRo7NTcZIyT
         0z8w==
X-Forwarded-Encrypted: i=1; AJvYcCVq/SPQOuar0np54sXxe5+VSeEQyr5s27ac3kW69OJsjb9YNoJa7sOLJDiEv+OMPc613OAwJfQXKtK2H6oej9u7HePk59Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhhHglRwY0Zd/gGNbkoVXOiEiqmIQPY+Pi20Ws+TCgoiFbl7eb
	DkLSW5bADoANEFXqLL63Xr+FiZhV587JcjB25vJqcvBppdKH1Q7As06QI3xm7pShOuTzbMY/Pxx
	jdemtYD2ulY7IoG7l/YzBunbSILH5bZzBJFCtnXwy
X-Gm-Gg: ATEYQzyQynwnSFpBThOZpzutY1wh4MYkRXTgwdlBZVYebYTHPnuQ/mSUiz+2jxy3tCZ
	0q3YMxTvnmQuOmXWZI9i2ba2U8FeZyc7Jtmnp7IusCup6/FskJ4+10yFXp1cXGUOkvGjM10ITu8
	vJpFX82p6Qr6jGNiIrQfoIzyQUyZiCYB+64ZiGxFFQwiKhcTCcwT/m5HLYRqwi9o/fh4oMiFQ9F
	w3yopBGsOpqoKkDX7LXdGz06VbiSOXLyswDQActikgdRLQuQwD5SjNsVQsDFv6aVWAUyTynLmK9
	FnD9O1Y=
X-Received: by 2002:a05:6a21:3296:b0:398:4c9f:d970 with SMTP id
 adf61e73a8af0-39858fb5c06mr15668111637.14.1773167092721; Tue, 10 Mar 2026
 11:24:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260309-fw-lsm-hook-v1-0-4a6422e63725@nvidia.com>
 <CAHC9VhTR9CsBgxRCAHXm5T2NZ5tr+XfmA--zkt=udmk9hPRuZQ@mail.gmail.com>
 <20260309193743.GZ12611@unreal> <CAHC9VhSRt_QEJKJFBDBySNQCiPpcawd5A76xmoRNtppRKGaCog@mail.gmail.com>
 <20260310090733.GA12611@unreal>
In-Reply-To: <20260310090733.GA12611@unreal>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Mar 2026 14:24:40 -0400
X-Gm-Features: AaiRm50dpMW8dCOCca72DjrFfp-PxzBkUaezLGHSrRR_qVFuX74TYWMkIgzHv8A
Message-ID: <CAHC9VhTKsOYrs8Wh-O548=2gE7N_gkBy+q05+atcR=D+30uQ=w@mail.gmail.com>
Subject: Re: [PATCH 0/3] Firmware LSM hook
To: Leon Romanovsky <leon@kernel.org>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Saeed Mahameed <saeedm@nvidia.com>, Itay Avraham <itayavr@nvidia.com>, 
	Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, Chiara Meiohas <cmeiohas@nvidia.com>, 
	Maher Sanalla <msanalla@nvidia.com>, Edward Srouji <edwards@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 5:07=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
> On Mon, Mar 09, 2026 at 07:10:25PM -0400, Paul Moore wrote:
> > On Mon, Mar 9, 2026 at 3:37=E2=80=AFPM Leon Romanovsky <leon@kernel.org=
> wrote:
> > > On Mon, Mar 09, 2026 at 02:32:39PM -0400, Paul Moore wrote:
> > > > On Mon, Mar 9, 2026 at 7:15=E2=80=AFAM Leon Romanovsky <leon@kernel=
.org> wrote:

...

> > > > Hi Leon,
> > > >
> > > > At the link below, you'll find guidance on submitting new LSM hooks=
.
> > > > Please take a look and let me know if you have any questions.
> > > >
> > > > https://github.com/LinuxSecurityModule/kernel/blob/main/README.md#n=
ew-lsm-hooks
> > >
> > > I assume that you are referring to this part:
> >
> > I'm referring to all of the guidance, but yes, at the very least that
> > is something that I think we need to see in a future revision of this
> > patchset.
> >
> > >  * New LSM hooks must demonstrate their usefulness by providing a mea=
ningful
> > >    implementation for at least one in-kernel LSM. The goal is to demo=
nstrate
> > >    the purpose and expected semantics of the hooks. Out of tree kerne=
l code,
> > >    and pass through implementations, such as the BPF LSM, are not eli=
gible
> > >    for LSM hook reference implementations.
> > >
> > > The point is that we are not inspecting a kernel call, but the FW mai=
lbox,
> > > which has very little meaning to the kernel. From the kernel's perspe=
ctive,
> > > all relevant checks have already been performed, but the existing cap=
ability
> > > granularity does not allow us to distinguish between FW_CMD1 and FW_C=
MD2.
> >
> > It might help if you could phrase this differently, as I'm not
> > entirely clear on your argument.  LSMs are not limited to enforcing
> > access controls on requests the kernel understands (see the SELinux
> > userspace object manager concept), and the idea of access controls
> > with greater granularity than capabilities is one of the main reasons
> > people look to LSMs for access control (SELinux, AppArmor, Smack,
> > etc.).
>
> I should note that my understanding of LSM is limited, so some parts of m=
y
> answers may be inaccurate.
>
> What I am referring to is a different level of granularity =E2=80=94 spec=
ifically,
> the internals of the firmware commands. In the proposed approach, BPF
> programs would make decisions based on data passed through the mailbox.
> That mailbox format varies across vendors, and may even differ between
> firmware versions from the same vendor.

That helps, thank you.

> > > Here we propose a generic interface that can be applied to all FWCTL
> > > devices without out-of-tree kernel code at all.
> >
> > I expected to see a patch implementing some meaningful support for
> > access controls using these hooks in one of the existing LSMs, I did
> > not see that in this patchset.
>
> In some cases, the mailbox is forwarded from user space unchanged, but
> in others the kernel modifies it before submitting it to the FW.

Without a standard format, opcode definitions, etc. I suspect
integrating this into an LSM will present a number of challenges.
Instead of performing an LSM access control check before submitting
the firmware command, it might be easier from an LSM perspective to
have the firmware call into the kernel/LSM for an access control
decision before performing a security-relevant action.  This removes
the challenge of parsing/interpreting the arbitrary firmware commands,
but it does add some additional complexity of having to generically
represent the security relevant actions the firmware might request
(this is somewhat similar to how the LSM framework doesn't necessarily
hook the syscalls, but the actions the syscalls perform).  Yes, one
does have to trust the firmware in this approach, but given the
relationship between the firmware and associated hardware, I think
users are implicitly required to trust their firmware in the vast
majority of cases.

--=20
paul-moore.com
