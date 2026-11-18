Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795038587;
	b=C/Wz5rxBZfAtvblE3m1U0w6qsmHfqpnYfT8gta+FjWCSqbf8A9GE/XIS9IWYK7HzQlni
	 Ox8BHCelsPJ47BdBU8w4VuxkCL7/1rvbcMrqLNgSjrWwso5K0lXJQ6/pyiTMUZC/kd/ap
	 EC6LwbG5YUP/kUOoIGivLpRIJcYzE0H1GAOgbPbL1TbePih3+Iix0Wb24kTyLybrSZq9E
	 vK+1ueEtnxQ53UCv+ogQ76aUUgTsZ+wTiCKlm3L6hppuCPanrupour2V7gMMvAGfOhkm7
	 36TahItIVYqCGQI8UUQO/H/JKqUNs1ZIsN+8I734ZLkYeUC5Xxr+rxyoC36SykAG9Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795038587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=CZPHqjEKi2vg5bpASOGDI+kJVhoG5JNXko8FEV4Oxfg=;
	b=P9/XSmJQf8aT3vvoQ4LoA72CppDsO5WPn24XNi62oZeij1jb8LtrPBWnR+vuDAuTZMpW
	 OyT5fY3q7FbZz/nnEHNvzluYQG5AFUWgAABvNjP8qqhW4BNcZUGD4akhhgA3uylb05vpy
	 EbFKq1BFUuj24m0u3DcVXJx7xYYfdOKfUP6WfFxnQ98wagn6e8PeTUCwlKCDzIG0nf9I5
	 Lha9britYowp2KPigUzLBCp9MZWW7jaA4YnDPlOdqNlfDKeOAn7xEhO/xZ2GItUppDV83
	 7O/0L3tlVBWKHintgFDtqqdBEVv271GNkQfgiWCZ2vw/fuVo6ai8oXEJGz2mylzmIAw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KaciEEIF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.41
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B0606A32F
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 21:49:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 967B0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=KaciEEIF
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5c15956ce07so284197e87.0
        for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 13:49:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795038585; cv=none;
        d=google.com; s=arc-20260327;
        b=om5XvKXja7dMii2dNc333XMV+3xnG4KJfeDHg6ZzGjuOykc0wSkcgM2yQT5JtK5In2
         xJkhI3zOdIt3OOlVQ32Uf95eWjFFBefWm7QNKMKxbXtuKkM6oG/vNJPqqi0U4YRqVy05
         xEdxaclPtGC29ARt2rYutwT6qKbgzctAoR6QDUNpQu3D0rJOfBCGfcafun/ZOSXrkuCl
         6a34r9V/59buEM+BuGISMxoHS9m32QOJvO1t9xzEP6TTcoD8otxF/9SVJRb2xIxgfX64
         WYCwEVxAXBKv5IQynOfvPIm9AJvM+L0DzCubbBpXL3y9yKcU9KcF1hH+ByR6ubxuhvQB
         jEyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CZPHqjEKi2vg5bpASOGDI+kJVhoG5JNXko8FEV4Oxfg=;
        fh=e25dz4yDzKer0qOacC6rPiZGOSjss5a/Y72dKFHHvfM=;
        b=WRRhvdWw9yaAxpJcQEbK3Gmt+y1e/5+CSwO9EjByCx9SIR7+ZNAfnE7dXbUwMz40b1
         RkdS8Xoiv7BTFoWtcKy8kLS/G/OCbq3POApfBMPLQvBZLWipXQWH/yHSV1SJ3cnP7hHs
         7f1pMsT5wdckazX+Hky2pN7V04j6MliZpa3JgjqilVuR0oXGkqMdrhBaA/lub6i/WsdE
         0zl3iLq9CQDS8ArJM3/t+WmcRMZxaSaJD6ApZiNTpeZhvWMWzza3E8giwhuLuHDKbLco
         yO3C1MKR+GVQac2F2sKGGxYs7YmBWQUU8oTx9BcQS9vFdpYCcbQnwnJeJvtXh1xRKOHq
         VzRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795038585; x=1795643385; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CZPHqjEKi2vg5bpASOGDI+kJVhoG5JNXko8FEV4Oxfg=;
        b=KaciEEIFbL/YwiIDScNJOJE/ZISkK9Hm5quErzyii+lNT1WfC7kXZg/3FpRZhArF36
         Ad6xuGX4OWHMMcj6Uv+Z0P3xjYKr4xdoCcBZYBSZ40V+hyh+sFba/6f/Byhy6/IHBYV0
         /krtJ2/zrzEeNc29BPoEzTEoutLnweqJEraHWGz4Xdqq1myp231uUNQJfdNikDffJxU0
         OhrtcSpB956rNGC7WaELPyoRadGtF0ROnUwsxD71d4jKhm42p47rbfwAaCyy31Ekzp8c
         eLl8tZDuFmJ51rjZGikkRD11SztUd+7xg3bdsx6y/sDvmlwM86hcs70DaEGgQFzFJe8W
         wh1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795038585; x=1795643385;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CZPHqjEKi2vg5bpASOGDI+kJVhoG5JNXko8FEV4Oxfg=;
        b=OVih7+dftxpxpBK/uuo96HVOfCF2WtqZWoJ3slLHgbYcayElnYqozhJDcxTCNGW5CS
         j+x6r4dshic/e5CMTZh9iXcF2vw6ENzO8x39MKbvjE24GG1GKYD5L5NwO849VuUoUAXx
         zsH7EnWh2DsLjDLisuVeJXumNBkhWCTccfVjDFzJrTO0Aymrh5toqWaZnzrD2qEYg6DP
         4rCD4CvQQkC0iBltLn1xERmXXp0J8fv43Gn6mDY6X5FJb1iw5FDqlCD9nIE5dXiQ8E0j
         TrGblxHRTFP/c6eHQOJXhyXIOeHGen5KWuhrb3EeNlsUr76RdKWlpwv8ARsV145cICGv
         i3fg==
X-Forwarded-Encrypted: i=1; AL+hErHtynxUE33WpwukgEnnje/MsX4LVXS6F45JAcBtjILZh1wr/Y1FAN4a1KHlCihS+pYnvRQ5OhdvQ+V+DI05hX8EzTPGPEE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WHQpPEB/YRNrr2FU73/rVvcq+56BZPqhTL5+uxAgoNjInwGda
	GGJnRap5EKz8kv1Xln6kZ7WIXGE0Jgcd7TYXqm6VZwY2nW4cMf1JUuB+Gq1C3ZbZh0SqVbrPq4Y
	9F/v+jKkgCCAvj5YXOp3yu5IDVsP605Iqd358lx4r
X-Gm-Gg: AYBFou1FNZCY3Lhh+RCKjNxaBugu6+uTP953wB7qY6VRn8U603G2fEs7ANzoXlTv4DF
	gqjk3GOo6/hiFbQq1NbcIrs2J65qjZFGprQ9T4Azqf6fWKxLqJ3Van2pgIuyXxZSIpdcr9Wg/3K
	GkPd+A4ALSSPWCxz2NB0kQxHsOK6l5OikzodA5qjWVvzn777WVEc7UdQlhCfzYBtfutOf2ik110
	5molxQVrdfRyf55iYNlU4K/aZ8cclZjQ9h/qSd94Z3mqLUINjKNIguR3RkifYF+cD63eVNleSVO
	viIOpSl4r/iDripQ0GqIarRptscrQ8Uq5E1zjm0jQpvpn5IBZMeF29YPFIYPPU9yYm2+rmU0z+U
	USaIfe/d8tjOJVMwkS0VNA1dReenc4+YdJQ==
X-Received: by 2002:a05:6512:3c8e:b0:5c1:ac5f:e596 with SMTP id
 2adb3069b0e04-5c1b40e9b72mr9362e87.23.1795038584801; Wed, 18 Nov 2026
 13:49:44 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-befreien-addieren-eislauf-e09212803534@brauner>
 <CALCETrWa1SBLcb5oWjqjgzZvKvCoHjmYFk=Lf5ytEM9uqm5jYA@mail.gmail.com>
 <avM41a80aig2de-R@google.com> <20261111-behagen-faktisch-entgegen-e2e714373895@brauner>
 <CALCETrUjW=kXxyggDUvEN+Pxc-pE98eVbdW8XBU8JzfqXj_voA@mail.gmail.com>
 <20261117-rational-ohnehin-unbeugsam-e5c04759a156@brauner>
 <CALCETrWhuOnBy0N0KznmczD4S2XEK0fbr0C=1KFQqTnoTJbQbg@mail.gmail.com>
 <20261118-stapeln-eckpunkte-lesbar-ee73537f474d@brauner> <20261118-zufahrt-baubeginn-gutsbetrieb-c09004227e8f@brauner>
 <CALCETrUMNr=32ENT6VBKPzoyJDfaX6nzZsjMVxuz9O3z+6LRhw@mail.gmail.com> <20261118-professionell-kondition-kerzen-5dd23c1ee490@brauner>
In-Reply-To: <20261118-professionell-kondition-kerzen-5dd23c1ee490@brauner>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Nov 2026 13:49:32 -0800
X-Gm-Features: Aa3M54rEY9J5hVHcO1DPxjhsi7Vv-UveBjN-XrYjaJlUs9gt6QOZEnzJ-89YhLo
Message-ID: <CALCETrXAGpb=OZyGQ2=VfKmA6xeizAsusGZ_HmRtp_s99RpRJA@mail.gmail.com>
Subject: Re: [PATCH 0/8] userns: per-namespace capability bounding set and
 opt-in netns loopback
To: Christian Brauner <brauner@kernel.org>
Cc: lennart@poettering.net, Jann Horn <jannh@google.com>, 
	"Hallgrimur H. Gunnarsson" <halg@google.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, Kees Cook <kees@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	KP Singh <kpsingh@kernel.org>, Jonathan Calmels <jcalmels@3xx0.net>, 
	Casey Schaufler <casey@schaufler-ca.com>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-api@vger.kernel.org, 
	containers@lists.linux.dev, netdev@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 18, 2026 at 1:37=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Nov 18, 2026 at 01:12:45PM -0800, Andy Lutomirski wrote:

> > > > * deny privilege gain on exec in the initial user namespace and all=
ow it
> > > >   in nested ones. I mused about this in
> > > >   https://github.com/uapi-group/kernel-features/pull/38
> > > >
> > > > Also, since v7.1 there's CLONE_NNP to spawn a child without no_new_=
privs
> > > > set.
> > >
> > > Forgot:
> > >
> > > https://www.thkukuk.de/blog/no_new_privs/
> > >
> > > has an overview of where we're currently at.
> >
> > Nice!
> >
> > I commented in the uapi-group issue:
> >
> > I think there may be a rather more direct solution to this problem. I
> > seem to recall advocating for clearing no_new_privs when entering a
> > userns way back when, and IIRC I dropped this as part of the extensive
> > negotiation to get NNP into the kernel in the first place. (I think
> > dropping it was probably the right decision to keep the final patch
> > simple.)
> >
> > But I think I would still advocate for an option to let clone, unshare
> > and setns callers turn no_new_privs off. The logic is that, if you own
> > a userns, you already have all capabilities in it. If you enter it,
> > you get to keep those by having them raised in cap_permitted. Being
> > able to clear NNP and thus drop and subsequently regain them does not
> > let you do anything you couldn=E2=80=99t already do.
> >
> > An LSM hook for this would be needed because this argument does not
> > apply to non-namespace-scoped LSM-based privileges. But the LSM hook
> > would just be a "may this caller enter this userns and clear
> > no_new_privs while doing so" query. In the absence of LSMs, the
> > operation would be allowed.
> >
> > This would allow a fully no_new_privs host to run an ordinary
> > container that runs, in the ordinary way, without no_new_privs, and
> > without hitting any new LSM calls after it's started.
> >
> > The API could be as simple as a CLONE_CLEAR_NNP bit.
>
> I think that sounds ok. I worry a little it since it would somewhat
> alter the promise that NNP gives. What model do you envision?
> It seems that CLONE_CLEAR_NNP would only be allowed with CLONE_NEWUSER.
> I _think_ this safe even for privileged users that create a user
> namespace and map uid 0 to uid 0. So I think this could work.

Whoops.  I thought that and didn't type that.  Yes, I think you should
only be able to clear NNP with CLONE_NEWUSER.

(And if something like cells ever lands, presumably a task with NNP
set should be allowed to create a cell without NNP in the init task as
long as the same LSM hook says it's okay.)
