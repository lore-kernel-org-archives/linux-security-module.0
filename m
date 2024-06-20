Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D9423774
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 14:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718895282; cv=none; b=Sl70hqtiEfuK0rE1FT+WLNR02ko0io2Ef3EaCahhvgmac7D4JPIkUrZdm97ldhLVeNvOQsqbGCtm9NYCjwTraERxtdkNyd8rh3PnSeY/4uKuDSs7zMtEitwuLUsCeRam4UjckRLHJfzpThv8FdnErmnJoohFHkcZtn9A4zjzVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718895282; c=relaxed/simple;
	bh=gMIU85E4sVlbAmhxL8HA4spZPOe6dtkhsj6eMGzEWGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uo/SUTvSlLEOM5Z7amlTGFrp7Iqn/zMNChgC5YA+GHnxFogeUtYE88V3IHzYW7ydP3opp16/8XS5BgdomVufP4qC+XDeO2Zxgrk0KBSdUKQMcGhXlw93r+xK/azsXA/r4hQWTsr0KtOJEZvoLBDyNB8wY9t1WvmjTyj0oABfV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iu7sDsea; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iu7sDsea"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2c348a263easo1534978a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 07:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718895280; x=1719500080; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N038QHxhArka8W/5BWMhOgRaal0bxOlQ0gQWQJRILY8=;
        b=Iu7sDsea2L7TgVO3G7zoDi650bD68jpm+u37r0PQ4LUplgKm/l/NxJT7dsj+zwIZft
         56EAoHDhfqKl7CUx4zdvv8dAP5Q5YYrlDHUeWTEbxK+6zC7V8k9OES2Bk4C0tgUlP2zM
         K29XMRXluyeJ2xYOPvmJAHwDh96yN5TQ9RQP0h20yLhPqymvGdpGznOfVQ9S7o10M/2Z
         kH4UoL9iH2SnTUnzEcms3CfIRm5fG6HblxuzjIVNDjkxx4kUzDSo0BQSXbrj7uCJYL9i
         0zgLdVk8tR+c0ZvwkneDBeeeshR1bLqSVLArJ1nt6LWKpJFpCTBxHSg9rGuFmB7uJ4xJ
         3Bzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718895280; x=1719500080;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N038QHxhArka8W/5BWMhOgRaal0bxOlQ0gQWQJRILY8=;
        b=FBhU15dD+R/t/WvBnnpHtEt6xNW4NvnWPlbYH7Qxr1JaE/zAjj9ArVYaNJSZNlGX7y
         YA8HQmuQuoGlUeUJCJJVMJZuBvMAVyUGzmpjYuLTQC5Fmr0WtkmjrnuyyxrxMP4VOZxA
         uZI1myFfgcYgDKYULUIZMH1slA6eiIAvqUbcpE6XweyQJahbDkcawLUGRoRULI8UnJAf
         jmfRi4hJi2KdNHb44CxD4u0ZsEeXlbyry/688TekJuQANQ+GWMaFqEqY8G1qhxWcrNEK
         E2FzmwgaPuPavws7qRAIZebbR1NyDT3qoo5cIERMYel8/ridJHeEflkfekX19eKs31/H
         Bqnw==
X-Gm-Message-State: AOJu0YzvcR4rafB4wGrEgFxEYqet4DA3D9keh/SpB3ejGrzsaZRPiidN
	PXTzrID/y8a383/mMC4nKzMmCQzlu0/vDSRdRC54UPb6+kHipp/k8bczCcfoBKtXwV02R7YzsDr
	n9P4pOCqGo6chTxJcgT3G6O90kEA=
X-Google-Smtp-Source: AGHT+IFspGCwwI/rbHKHWfh+hmuJr5IWxM4itLm+d2epVW5VbqRMlA2jXKXZIpJPcrwrbVvO+VvmCwMxRqQAcT7TMQc=
X-Received: by 2002:a17:90a:9a8a:b0:2c8:647:3238 with SMTP id
 98e67ed59e1d1-2c8064732a6mr1226158a91.9.1718895279925; Thu, 20 Jun 2024
 07:54:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
 <CAEjxPJ7oNGyzh3Q5FyXLtDoq0BmzbBAfLv11ZSkZYBt3Vz_pEw@mail.gmail.com>
In-Reply-To: <CAEjxPJ7oNGyzh3Q5FyXLtDoq0BmzbBAfLv11ZSkZYBt3Vz_pEw@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Jun 2024 10:54:28 -0400
Message-ID: <CAEjxPJ53FRaMGO0mZ214jpHpHR-NXVcoQrfSxc-upR7C_1Ke4w@mail.gmail.com>
Subject: Re: Yet another vision of Linux security | Endpoint Security Framework
To: Timur Chernykh <tim.cherry.co@gmail.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 10:28=E2=80=AFAM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
>
> On Thu, Jun 20, 2024 at 9:40=E2=80=AFAM Timur Chernykh <tim.cherry.co@gma=
il.com> wrote:
> >
> > Hello!
> >
> > I'm here for yours' opinions.
> >
> > The modern Linux, in fact, does not provide convenient options to
> > write AV/EDR software with real-time system events analysis as far as
> > unified system security events. For now we have only inconsistent
> > self-made events from eBPF, audit, fanotify, etc. eBPF itself is a
> > cool technology, but even CO-RE sometimes works as not expected or
> > gets broken, for example:
> > https://github.com/aquasecurity/tracee/pull/3769/files. This hack (one
> > of a huge amount of the same hacks) looks a bit "crutchy".
> >
> > As an EDR developer, I have an idea how to fix this situation, using a
> > unified endpoint security framework (ESF) placed in the kernel. Its
> > must:
> > - Provide unified and consistent security events;
> > - API to communicate with kernel:
> >  - To send program-defined events (as audit has);
> >  - Read events from kernel;
> > - Trusted agents delivery mechanisms (signing like kernel modules);
> > - Has a possibility to control what happens on system e.g block some
> > file operations, binary executions and so on;
> > - Has a portable and flexible events structure which doesn't get
> > broken from version to version;
> >
> > For now I have PoC, which describes the concept in more detail:
> > GH mirror: https://github.com/Linux-Endpoint-Security-Framework/linux.
> > It contains all listed above points (maybe except portable event
> > structures)
> >
> > There are an examples with:
> > - Security agent:
> > https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/mai=
n/samples/esf/agent.c
> > - API: https://github.com/Linux-Endpoint-Security-Framework/linux/blob/=
esf/main/include/uapi/linux/esf/ctl.h
> > - Event structures and types:
> > https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/mai=
n/include/uapi/linux/esf/defs.h
> > - Main ESF source code:
> > https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/mai=
n/security/esf
> >
> > Questions I'm interested in:
> > How does the community feel about this idea? Is it a viable concept?
> > If all is OK, what should I, as developer, do further? How much kernel
> > code outside the LSM module may be modified to keep further merge
> > acceptable? (currently not all LSM hooks meet to intercept all needed
> > data).
> >
> > The general purpose is to make AV/EDR software development easier,
> > more convinient, and stable for Linux-based operating systems. This
> > PoC (as far as technology idea) is inspired by MacOS Endpoint Security
> > based on MAC policy.
>
> I could be wrong, but I thought that supporting such solutions was one
> of the reasons that fanotify was introduced, and that some combination
> of LSM + fanotify + audit could fulfill most if not all of the
> requirements. Can you explain which ones can't be met using those
> today?
>
> Note that a number of the LSM hooks are called from interrupt or while
> holding locks and thus cannot sleep/block.

Looking for a list of such hooks, it appears that the BPF LSM is
maintaining a list of sleepable LSM hooks in its sleepable_lsm_hooks
list in kernel/bpf/bpf_lsm.c.
