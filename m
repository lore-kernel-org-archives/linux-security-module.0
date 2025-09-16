Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2538B1E285A
	for <linux-security-module@vger.kernel.org>; Tue, 16 Sep 2025 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757987741; cv=none; b=rn5MJq/wj0drUAFuqGcc7ObP6N71btYNG8lSWbyQdZt/IoiukQRfaI1VC4mzbCRiLzXzqIW1wIyWBV8ic82CFoZ7aFHer9nPQpJSkslw9v5TvjH8vEmQ57/bnbOLyCnxHCV9tbgxMA7rKDfGU+upLTNIPgUIvd5rQe9VLDckbJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757987741; c=relaxed/simple;
	bh=jep2u5VNTk538PUR4KP/b48BjYybUEbcPCBXSSZj1Jc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F0ly1KPgSuDkY1EwhB0jU7hiGsC6xspckYp2JsGo/hQUJ6c2PV0YTEdvFEO37snap3W4s4LKiM6B6DdGf7VGVrOyz/eyW7x+shXGtCVtzwm6cBiWTV1yLUJw3RWSKQ5QsTnhimPwQ6kf9zC3Y+UulX7EAdT2iWVhBqgcOAT1wM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7jrtFBe; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7jrtFBe"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b04b55d5a2cso849532566b.2
        for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 18:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757987737; x=1758592537; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3JiJuCf5fDbcsVFqie8KviQvSHh9fw4OMPm4D25E3/I=;
        b=L7jrtFBeKsXLrJDFDYYmH2CyVHVGaP7NniIcPoVRTVVLg7SFE9957XIvhw3x8MgICw
         CDpPEd/EvkXVp9dPXf1Gt53xcIN4DTYeAO3uejVWSujOZM9uyd36wYS6GMlsLZdT6UnW
         7HYKpyB74OKpRCums2wzPDgp4aCBWP+hhOmTDPahklmaFkFJaDxaUqwpTMnEWIL4wYhJ
         k8ZieHGQYUcarek1roI9rrQRmip+Wz/0Zk9V5+eJJVC+HOOwSnB/dSpO77nC8RzFxzfd
         F72+Hx13bHOcSLWvv/YOj3CYWyDS3b7dhzjLh+XgHPDoLwdjeuc9OBclZHONhptg+yB/
         j4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757987737; x=1758592537;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3JiJuCf5fDbcsVFqie8KviQvSHh9fw4OMPm4D25E3/I=;
        b=k1RPIaVYVht89b0WkaLX7DtJ+PbWKI0KBbZCl/23UxMFUb7Zrb3T4+gUdTIFOi8lt0
         nR6FkGN80sxR+Wl38VEHw0ew7IqGquh/XqL45kC1n8YE7GneWblwEwyJ5zZFMcea4PzG
         x6ktOerwuRzKcGLH1d9kQQ5zvocLVA9TALKYXbxB0QWxJzeQfGqhCU7KIQQRULrnfS3d
         Ns8bJFQ0dANp45mvWcjFY5Jr5+IH4XxcvhI5ruA+ALYxLT+IwR+ufFpp9qTPTRjRO6T4
         ogTySJ3YEpc9CsdhbVzNrTDGU5SWIYjjvPm9QwvJ7fM9Vjz2yxEUAc+l3szRhcvZMmFm
         4vvw==
X-Forwarded-Encrypted: i=1; AJvYcCV6afCU7AbPGKvnTrRo13DjD2eBfTIzhytqcmpO4ORDdl1xiv89j/f9g5Yyc3RQvjYxLUhzlUHT+x7wUNedkvVk/HghYdE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WPArKGK4PiV+FmRXOhJ8RBSJmmbRlh5kzuyqIT3tvhCSatRm
	JoLBOkMuIVAqbj8wcBLG1Z1dmQzW+yLj3R6H2LmRGNdm2YLVWNkckeA+BgoKSuvgjHtMinOkXjI
	o19oytpVltV0V0I3rw+qi31EEZXefiEc=
X-Gm-Gg: ASbGnct0krDxsLWuo3zZOQoZkDCcUbXqbKGLWnGuBr1SvMikY2QH9eAIfNJLkHC3mID
	Xzi4wFso0m5ot7y10WRcCcGELx2QsRy/0KveJmwOMbtQXjk+g16deK3CESYwV9JVY/45wtXjuyL
	srir6hmmHnIpHM6EeHBaDBdJKg80etlRcQ5fIZjGaUeVtezs5wdFxZtc83sV5kIaSRvHvKv5hzx
	6eIRvJb
X-Google-Smtp-Source: AGHT+IHJugXW7PgqM4C561Es6pZ+yMEeghRxxr249HgOnA0uY3PnwVnYPJp7RZWq/M8Ro+g8NAKFEnS73k9uc/Q2N9g=
X-Received: by 2002:a17:907:969e:b0:b04:6c19:ed8d with SMTP id
 a640c23a62f3a-b07c35bdfa1mr1378153066b.26.1757987737286; Mon, 15 Sep 2025
 18:55:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915134729.1801557-1-dolinux.peng@gmail.com> <20250915144052.VHYlgilw@linutronix.de>
In-Reply-To: <20250915144052.VHYlgilw@linutronix.de>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 16 Sep 2025 09:55:25 +0800
X-Gm-Features: AS18NWAOIt4gv03twwvlmnUbxI3Di3y_xFKnQycCNlJ75R-ks7_KB2ty8Keq5J8
Message-ID: <CAErzpmsW7=3RmLZxByxVD+vD=FV0YDF6POHVZZce784r7jMQyg@mail.gmail.com>
Subject: Re: [PATCH v2] rcu: Remove redundant rcu_read_lock/unlock() in
 spin_lock critical sections
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: tj@kernel.org, tony.luck@intel.com, jani.nikula@linux.intel.com, 
	ap420073@gmail.com, jv@jvosburgh.net, freude@linux.ibm.com, bcrl@kvack.org, 
	trondmy@kernel.org, longman@redhat.com, kees@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-nfs@vger.kernel.org, linux-aio@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	intel-gfx@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-s390@vger.kernel.org, cgroups@vger.kernel.org, 
	Hillf Danton <hdanton@sina.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
	pengdonglin <pengdonglin@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 15, 2025 at 10:40=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-09-15 21:47:29 [+0800], pengdonglin wrote:
> > From: pengdonglin <pengdonglin@xiaomi.com>
> >
> > Per Documentation/RCU/rcu_dereference.rst [1], since Linux 4.20's RCU
> > consolidation [2][3], RCU read-side critical sections include:
> >   - Explicit rcu_read_lock()
> >   - BH/interrupt/preemption-disabling regions
> >   - Spinlock critical sections (including CONFIG_PREEMPT_RT kernels [4]=
)
> >
> > Thus, explicit rcu_read_lock()/unlock() calls within spin_lock*() regio=
ns are redundant.
> > This patch removes them, simplifying locking semantics while preserving=
 RCU protection.
> >
> > [1] https://elixir.bootlin.com/linux/v6.17-rc5/source/Documentation/RCU=
/rcu_dereference.rst#L407
> > [2] https://lore.kernel.org/lkml/20180829222021.GA29944@linux.vnet.ibm.=
com/
> > [3] https://lwn.net/Articles/777036/
> > [4] https://lore.kernel.org/lkml/6435833a-bdcb-4114-b29d-28b7f436d47d@p=
aulmck-laptop/
>
> What about something like this:
>
>   Since commit a8bb74acd8efe ("rcu: Consolidate RCU-sched update-side
>   function definitions") there is no difference between rcu_read_lock(),
>   rcu_read_lock_bh() and rcu_read_lock_sched() in terms of RCU read
>   section and the relevant grace period. That means that spin_lock(),
>   which implies rcu_read_lock_sched(), also implies rcu_read_lock().
>
>   There is no need no explicitly start a RCU read section if one has
>   already been started implicitly by spin_lock().
>
>   Simplify the code and remove the inner rcu_read_lock() invocation.
>
>
> The description above should make it clear what:
> - the intention is
> - the proposed solution to it and why it is correct.

Thanks, that's much clearer. I'll use this commit message in v3.

>
> You can't send a patch like this. You need to split it at the very least
> by subsystem. The networking bits need to follow to follow for instance
>    Documentation/process/maintainer-netdev.rst

Thanks, I will split this into a series for v3.

>
> and so on.
>
> Sebastian
