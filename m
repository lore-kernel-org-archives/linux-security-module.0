Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793821672;
	b=hLYZ21nC5EaXi3TL6hruyQzFrdmzdeKlkJcCQdGJ4Vsb6rD00Y1sSohb+kA149kGekto
	 eg6UM1bxy20rmWsx0yB7RTyJ71BPfwqnY0sTHEXxsoLMwWJa416SrpVKTDn/2FYXM6H3U
	 z4UMRKPyzjHjDaNg3S+ArC98yC9ZXxzs+VEFvXqgCoT129GvIUShYOVg/8VY5JyvgL0zu
	 2cvJ9t2bhQbG8M5tPA1FoinHIfNeYbomFqSIQNizvjuLrtaXRkdgEhtnRVYwcK75QT1t8
	 mJGUDFuWS/KlAPQCA6GI1v62EDIGjtZ8tAceR7875a42s2wXG8RDvtFzOLqw0eT47Lw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793821672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=E8RgS9Fy/AEzzzRdR1tDID8pHQZHUShrwVCmHXZNpOM=;
	b=tbuX8gw92nkeAIupl+FNaas0UtyQ51FF9cjn0EvnVWgHepodZbanSMMjReYDJRIguU8y
	 23OvfnaBZC2HvhcamTFvmxnrtbMsxct5uC+smVLQ3bT2eSiI4Jo1BbEg6mPGWgFYC22iK
	 ZQwKgjKKGvitzZ4vMgkSmN2miAfVvtoTOoptcg3BF7/5wqttHG0VrWNineNv9jmqucFlf
	 sxQ7hZ1crVvdeFFeXJuxttrqFQ6ZL6YDmNpRzA9jTQbBXIgCdHk40sZ66ybQ7EED1mgBm
	 KV7pSCa7CwPa51iv8u6Y3/VU1YiEPCKvnq7PCq13gvAVEUZfEwTx8aiVkGFzQKqq7hQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b="Pre6/T+K";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714D4608ED7A
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 19:47:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 714D4608ED7A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Pre6/T+K
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2ea7f9c11e6so9675ad.0
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 11:47:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793821672; cv=none;
        d=google.com; s=arc-20260327;
        b=otN2cAon28IDn8wKnnGENIACWaT64TBDjRqqxzTEgzCW9CqR0p+7xcmuSUh03lYrpM
         WgD5pRNmrTs1LYzH2PztkJfwa+GJ33EKXxySFHdknKe7jPJZxv+enRuQS9oYmaWk7rcZ
         /Ns77csGmFIS6u+XaGGmrryPkCsEbYe1KagBF0uy6csatXc0v+ixSMCrPhWlC4sfCmSP
         nHU8sPympqP3cFQ2S/krscPC7NneAN0u3HOd04V0Zmbl29OjOOdmA/nQSvM4OAXu9934
         ZH+aexwsTvT4l5b9NxaryNXQWz/H8KGYAw/pxkhTbtw81Hbz5dBy9tnm6stYQEnXOlD7
         tprw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E8RgS9Fy/AEzzzRdR1tDID8pHQZHUShrwVCmHXZNpOM=;
        fh=ACDWcN6cUGs0q7bsC6mLSMqJtxskmTQilJqucCEwAEw=;
        b=PyjKNvln+6v9MdJhU0uoHeXlUca1wWJJQjHg+LIzNYMBYzYSTyrFVCktICbCcNkOX0
         XI6/wPWzZY6tJ64gynY79yq+lMTBpeYLA9o1axnExYOITtam5iCm9xnc9T5AHjsdb4HG
         7Go6mxsNMxUyW29Hn0RvUjCMc0trji+vwAXsHKVi42BmcvCoa5dtP2yzVXwmAG922gB9
         xVK/LpfNtFoVY8gAa2BiRGesyX8Kq2VBKp1FeMrYswZZKk1Id8sd2CptnWcGg+7soPrZ
         Z/tvM65h8AjK7MVVqxLTvR/bdFRnIFgZySQU13vigwOU6OVBJ7X0yYYKZD+qA0ZpwXfq
         MHuw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793821672; x=1794426472; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E8RgS9Fy/AEzzzRdR1tDID8pHQZHUShrwVCmHXZNpOM=;
        b=Pre6/T+KB25HpZOrUgjpGk7BYEiTmgAh2V7MBgC7+kz5pppzdcOtDLW9/HXIsWX7w8
         JGdka7KX2vYErnklggY1QD/7PyLyt/7Ec9VSaJO+xcCBiNu9Vv539qbGYMEZSuxV85OL
         Dj/X/xaXNkRWK4mO75s4bFPODgbSekHYekfO3TCgxx5H+mH+X39Y4mde6JGDE6nZiw8l
         MoCkdlgLpp7ynFSENYC6276qkehDa95pPCMnQVMaKUn2F6BQ09Cl8dg2BqYmiwFft5fT
         +knGNY3hAj6+johQ1ZGTBdHmwXyucQSoMTFGE5wFKLyPobpz2TXj6zanL0E+H1wfyErJ
         q0nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793821672; x=1794426472;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E8RgS9Fy/AEzzzRdR1tDID8pHQZHUShrwVCmHXZNpOM=;
        b=Su26mJOHtuK3T6DqaU3ag0Og4TnRpIvwGpMbKpJu9eY0xkAasuQnL5pvNTtTe7ylBs
         nJ99ODsJbdh4iPms8aifxB5FwtaMjAsV3TxG/rF+7YJYsvJOqandeqUhMeJijUJeP0SE
         ADs5kj1zS4FGktgBWHZDl/fVSur7XuoHeX2AQj0VCma3y9ZLdU50SdccBshSemEu26Wf
         zbPtC00M1LZGYyqAoi2FmYjnuKozDso0RHkRL0lSDNWpRxJUhOh8x5eprCEEwnXPSNua
         t7bmNuAKpJA4d/ID9cGEmWk5lnBORydLLbtYzSRUVo0epJpciqj+vIgjdGrKE+VDj0xh
         GxCA==
X-Forwarded-Encrypted: i=1; AKwUvBz3vQRd+13mn0dCP2ggeFbc+gTtg+2r7m0ZWDzPQFJIaYzlJGUZfoHzhy5cJveSZFPrmoprUxG+KwRs/w93GSzB1VMVKSU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U5hew3BouU7sJ8GJuT1lLPviIcH0b++aN+gAiK0ANuy8/BFgG
	SnfbvOu4DD8biz3wkmFE/HnGkzlTcn+OfcjDlm7JfyftKG8QZBrukMGzkd5MU+PTUgoYaoDBdrd
	ope+uWMl5idSbfbbF0xUc+9FoxzjCKUj1LaMzV7BWcvqc/MYTpmJqD81BM38=
X-Gm-Gg: AYBFou3bpl21Dq6I3unX5hGfjo7ofbjo1XAIOcj7F6nxcC45XPtE+RZ5UhQ1iBxKO5m
	FGZU42cPOidzOJcVRsu3DiCz1elBUf/450S/zL1wP3zfgdfsM8J3bb6CqrAt+iaQILs1wx4MC+9
	kL1c7d+MshSqSbePqs4cCOqsJiINNH072Tsn61hFOiJ1XEspLazA4BtN71/X6YJX8g7A1qFeXjQ
	Wg6LV565bUGuDPkyioh+F1zksiqAukJwAXjOZDZO5XiSyOnat7ytTZ3ihuJWCjYwLYJlYzFAlDY
	EJH/lvF4r4xS4czJgBSiUSG1ezQPTBp9t+96iRvAyDMoM8Wu4a6VKUcSZnzkGu+atCiA4BBewKj
	cRBuHuKBoXTkIO39KVsZmODPA/y39NyJIfLRHQ8r85gn5zb6xkid8Q6i1zhF0Ez7j1yBUIuMuIv
	10PrzI52cVswEAA0esc0792Gk=
X-Received: by 2002:a17:903:1a03:b0:2e5:9bdf:6b65 with SMTP id
 d9443c01a7336-2ed25671982mr1025875ad.0.1793821671183; Wed, 04 Nov 2026
 11:47:51 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <auS7gAFy13EOp_Zt@google.com>
In-Reply-To: <auS7gAFy13EOp_Zt@google.com>
From: Jann Horn <jannh@google.com>
Date: Wed, 4 Nov 2026 20:47:14 +0100
X-Gm-Features: AclHuK91TcmyWyDMmafA8MM2TvukK-iXd9ZaYxJjCOqPlgsZDHPV4sGOrjcK_VE
Message-ID: <CAG48ez2e607HNArcX_xA9UTv_u1tvThLwW2kDvnejHcx4A80KA@mail.gmail.com>
Subject: Re: landlock bug: procfs denials because inodes have unstable identity
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 4:45=E2=80=AFPM G=C3=BCnther Noack <gnoack@google.c=
om> wrote:
> The Landlock LSM lets processes define policies which are attached to
> struct inode objects internally.  As a consequence, if filesystems
> forget these inodes and start using new inode objects for the same
> files or directories later on, these policies do not work as intended
> any more.
>
> As it turns out, procfs has that property as well and can lose inode
> identities over time, even though it does not happen immediately.

Right; basically, dentries can be dropped from caches while the
corresponding inodes still exist. In normal filesystems, dentry lookup
rediscovers already-existing inodes, but procfs calls new_inode() for
non-persistent dentries from several places without checking whether
an equivalent inode already exists, which works because procfs doesn't
really tie any state to inodes. new_inode() is called from these
places for non-persistent dentries:

 - proc_pid_make_inode
 - proc_get_inode
 - proc_sys_make_inode

File systems that care about having something like a 1:1 relationship
between an inode and the object it refers to can instead use
mechanisms like path_from_stashed() or iget_locked().

> In my understanding, this is not intended.  Landlock has explicit
> selftests to exercise that Landlock policies work in Procfs.

I think from the procfs perspective, it's currently an intentional
design choice that simplifies procfs implementation.

> For reference, similar issues have been investigated also for hostfs
> [1] and 9p [2]:
>
> [1] https://lore.kernel.org/all/20230309165455.175131-2-mic@digikod.net/
> [2] https://lore.kernel.org/all/cover.1756935780.git.m@maowtm.org/
>
>
> Steps to reproduce
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Process A:
>
> * Enter a Landlock domain where access to /proc/sys/kernel/random
>   (and files below it) is allowed.
> * Repeatedly open and close the boot_id file from that same directory
>
> At the same time, the dentry caches get freed up.
> We can emulate this by writing to /proc/sys/vm/drop_caches from
> another (root) process:
>
> # echo 2 > /proc/sys/vm/drop_caches
>
> Observed result: Process A fails because of a Landlock refusal opening
>   the boot_id file.  When Landlock walks the path for the check, the
>   inodes have now a different identity than before and don't match, so
>   Landlock denies the operation.
>
> Expected result: Dropping the caches should not affect Landlock's
>   behaviour.
>
> At the bottom of this email, I am including the source code for a
> program that does Process A -- you can run this to reproduce, and then
> write into the drop_caches file from another process as root.
>
>
> Solution...?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> I don't have a fix for it yet.
>
> I am open to suggestions.  Is this feasible to change in procfs?

A landlock domain is supposed to be usable for a hierarchy of multiple
processes, and for that usecase, if all those processes want a working
/proc/self, landlock currently can't meaningfully restrict procfs
beyond what is done implicitly through ptrace access checks, right? I
think if there is a desire to have fine-grained landlock policies for
procfs, that would first require some design decisions on how procfs
peculiarities like per-process directories should be handled.
I imagine one option would be to add a mechanism that automatically
grants full access to {procfs mount}/$pid of all in-domain pids, and
then consider whether sysctls should have persistent dentries or
something like that?

> =E2=80=94G=C3=BCnther
>
>
>
> Reproducer program, for easier reproduction (don't forget to drop
> caches in parallel):
[...]
