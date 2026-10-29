Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793282668;
	b=gEvUYq6Nyy9AZ6OJnDZSWxaqX7fSNZ23Dm+sn8eGQc6rdvLkPOX11m35PRUDB8H6jWhJ
	 CYDrURB91OLf5kS8iZoTmFhQSq1Pw8bY0lgAeVXJ2GU5yuDvLoEEw5hn0eJCaG4tShEJb
	 AJYiDzEzfnSLGxLc0YSxFJOO/LCAuUiK19aQxwBjmOJQXoprmnTERfHPs/aFhXd2e8Ng9
	 261Ip6ghYA1c+uUTQ9GGb4nqL/3LuNe5z5BcTz60GywmugDwFitp1hIgUTPTbX75qNBN2
	 q8s0fXtsc2rf1U1vpAHLMdfqwfRee+2EZuGDSJm5SyU7SbDDbPwVXzd3Gd+NeIOHkXg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793282668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jOIJiz3JqGs+BXIFdn+z8p3AdQ++3MvGNgnUSp9BRR0=;
	b=Touk1rDQJQzKoRhQKmcDEEsMbjLqXb8sGfqtgibGHhSYqzmN0SnYxMKMqMRQiOHg2fIL
	 1isJH4bf2YifeauLSwhLe+q101kFmy/7UMdQ/yXF1UjQ1NEJJTIGHysibUofk60aeRo1g
	 m+XhdZkZomnB1D3j3YeYwhuO96kFqwQtnPDMNEA48m3wG2KMCAhW0EVMYsvFGn7WMI1dh
	 u71OA181CA5Voz3wvLJ485CiNDxtK9rI3CjbNvx3JF+tMAJo9HXz20EVH69Hri0x5XrFE
	 V0+xS8cr5LUkGzfSsJrTgZTRiHWzFz/hPOCOtMjHH/5cEUJBgMu+LviRu01DO3y4i8w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5dc86bd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.179
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A93F606A327
	for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 14:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9A93F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Y5dc86bd
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-8ab395abf79so19691907b3.0
        for <linux-security-module@vger.kernel.org>; Thu, 29 Oct 2026 07:04:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793282666; cv=none;
        d=google.com; s=arc-20260327;
        b=DMdTb5fUnW4PcWjpNg+5m2sZngmoVOrnD4QxghsQ+V/Ph3fTxdtC5Ecgh/xW0k75Y7
         0Dwv+4SjxNAfupskI00OqggwlRdcADk678iCqtykNu8VSqm7AJfOXi/3cmj3epjqvdQH
         5mxwdEGQnOozKMeoVK25+HrP5k+HVT6GLSaAUId4i6rcLqT3N3/DG2yS1ixIhhybmu8k
         erww4ndEEV+RrEczGtEa+gSyNvsiPdBeyx5zPUgcCF8yQdHPr5RPNDVIZJp5MiSKzshT
         8jnVxVasG7kT2rGVKfwdTtaNe7rMvaOU23n30eJ5PmxGG/7Gy7R3efRYdiKsg9Gh/7/e
         kRIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jOIJiz3JqGs+BXIFdn+z8p3AdQ++3MvGNgnUSp9BRR0=;
        fh=AsmTOtQmHv6oTVt4nFcjZtPyNv2qYrZsSjCWIqzg8mA=;
        b=khSnPMB3KIalAVCwR64l6k04UjjslO9+RlALTX2iUzdqwV124SD5H0v4jGOColXNAO
         u5c5i1TK3oym5mFpWiUVljvazPieNdtMUCevRZW+Nt3YTB+MQVJmufpZ+LsQJmELbuoj
         UNpG0Ca9MQbeEZB5ioY0p5LK2y9uZNCORtp/KewSBIbvcB5PALlx03eWYwxo2UCdSK9r
         9nLQ9nauK/G3WSmvclCPREyw1/giAXXsf0YtVSDndOOnw+KH2qwCtHyr5cTw3STgfHN4
         DL3Xjph+8l6iZUD/ZeL3grrUU1jkXT7qmoZlbbWSZzGS07UVAAUSl7U64lJtfNOrxDdj
         h4jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793282666; x=1793887466; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jOIJiz3JqGs+BXIFdn+z8p3AdQ++3MvGNgnUSp9BRR0=;
        b=Y5dc86bdmRKt0Fdg7JrcFIXb7pnxA/3b62rmNTk9808VnsIAhs6WArPEI0iUxgHrL2
         kNy2Fnr55h/+B/Kr3EyDMectt3PxMyAT3K6NK9vl3HIPrlieIYtTQWO/60Kg6q5Is/Ej
         3UbiDcVYy90YvayGElyL2fIMeR14BjKWxH41LL1ZIyPZIl9L4o6HstRg2XOMXaSe52te
         E6y7yXkvvfIVtBkGQAPaSjKdchUn+jH7oFvbepT6fRIx8X1COgHBXe38/kZyxR/XfzpX
         l6Rs9SFQBXi4HJcuM/cIkFAETr806GIfsvfTVdKQoOqmVYt2r6c7j0NYzQAFjH9AdAIs
         0KZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793282666; x=1793887466;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jOIJiz3JqGs+BXIFdn+z8p3AdQ++3MvGNgnUSp9BRR0=;
        b=a5uYx1CIva/R48P4X+/g5jopjFZrWBZ4HJU/SkOpBAOCkjzbvG8ULjIohI6MnVhJjE
         xi012D9KHa4h/geJjK8sSOJ5Gi3e0tMe/ElOjzPhFn8Tb8B6quFQpX0EAa69K/LZ/NPF
         w4ztQC34lgICCgMDW8I/+BXQrvxxb/yNsPqQdHFh2tuSZA0RfaqyzFa9Uex/DQIbpWVA
         XM46q4r3GbbIQonMiV94KvZuhlrArErskL3sHAzVu94jHKThZm00nSW3yeUgL//FjFjJ
         0hzfYldS2kO2+Nx+JpulYwvMVMuB0U481+5w0vv6yMgqB8NCXqZLsL9l0bvo2EHdjfG7
         fYmg==
X-Forwarded-Encrypted: i=1; AKwUvBwf/rJyqNj3I9Kr8DZ/4cM0tYcE5PJLaG4Ei4hiEmpW5gJ70AySqkfgSjIiW698y8fGtx3w3Lu36JoNBamrr3/NSsyKvd0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3bRD9Ew9Mm/P5y/FOuNQsEtYRmO2cck2OvvylQYOgj6IAmepw
	xBCF4hW4KEPVTAlThsGcnXLZyfgjMxsD7/cv8kFButXKIKynpILaou39d11ReKan2xXWFl4hfUH
	Zcqqpo3qRV6WH4SJYFVCldzZkuM4qGLA=
X-Gm-Gg: AYBFou1gPMU74865dGYSe/LmRe+a3HwmXz+xGwUszNpWAwU/Uq3ZdTgR6Jhr0ocLIAV
	n4IXPoOLpwZb5glFip1nwtYOBk2jRulAzes4exE15NqlMGtAgHOemJjWcGL3PW9iVIUt5VfyRR2
	kqIDIL0sAAoIa0dd7ne8QMV/3Nve93WrEjXvJMJXJDYw4VF8uFWoo9PzXvzxO+4W71mAcftXgcu
	bWmeJUXYyl9d/ciACLOIWbWGuOse1cJSmI5HNrSbKKjMC/a/xhja+CNYzOEzaN6fJDcBxFNI0WL
	OnH+xn0SiDlBGGmCsJbrdcjrKRT56B1Z/Mg6LILwOmJcaQkAKTjWV24CgUU63iIVZOUpsb7jFRS
	3UQbcTO/4ybeDy6yoPwA/tys2PKaIAWCGdbDZpwA=
X-Received: by 2002:a05:690c:94e:b0:8b1:2aff:1740 with SMTP id
 00721157ae682-8b1b5bbc547mr36572347b3.14.1793282666501; Thu, 29 Oct 2026
 07:04:26 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <pm-keys-update-type-removal-20261029-v6-3d92b2f9693854230a02@gmail.com>
 <auNGzJIWFt64IMWY@kernel.org>
In-Reply-To: <auNGzJIWFt64IMWY@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Thu, 29 Oct 2026 22:04:13 +0800
X-Gm-Features: AclHuK-fL_kIzHPwfOpnScrTRCdAOv9QyH89rdm7dSYyaUfxKyQ-LUn7ts43gAw
Message-ID: <CAFRLqsXdUfqvNyzNpnz=dvgtHrVyRhYoZqt-CQUo98HW7BtNJA@mail.gmail.com>
Subject: Re: [PATCH] keys: Protect the update method check against type removal
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8829=E6=
=97=A5=E5=91=A8=E5=9B=9B 21:14=E5=86=99=E9=81=93=EF=BC=9A
>
> On Thu, Oct 29, 2026 at 07:58:06PM +0800, Cen Zhang wrote:
> > key_update() reads key->type->update, ->def_datalen and ->preparse
> > before it takes key->sem. A reference on the key does not pin the
> > module that provides its type, so KEYCTL_UPDATE can race with the
> > unloading of that module, for example dns_resolver:
> >
> >   KEYCTL_UPDATE task                  Module unload and key GC
> >   ------------------                  ------------------------
> >   keyctl_update_key()
> >     key_update()
> >       key_permission()
> >       load key->type
> >                                       exit_dns_resolver()
> >                                         unregister_key_type()
> >                                           GC: down_write(&key->sem)
> >                                           GC: retype to key_type_dead
> >                                           GC: up_write(&key->sem)
> >                                         unregister_key_type() returns
> >                                       free_module()
> >       read saved type's update member
> >
> > The final access reads freed module memory. With the updating task
> > held after the key->type load, it faults:
> >
> >   BUG: unable to handle page fault for address: fffffbfff804107f
> >   #PF: supervisor read access in kernel mode
> >   RIP: 0010:key_update+0x12d/0x550
> >   Call Trace:
> >    keyctl_update_key+0x6b/0x110
> >    __do_sys_keyctl+0x21d/0x4f0
> >
> > This is the same problem that commit 925c84e3cc21 ("keys: Protect the
> > read method check against type removal") fixed for KEYCTL_READ.
>
> This is useful bit, thanks.

Thanks for the review.

>
> >
> > The encrypted and trusted types can be built as modules and have an
> > update method. For them there is a second window: the GC can move the
>
> How is the second window related to the fact that encrypted and trusted
> can be built as LKMs and where is "there"?
>
> > key to key_type_dead after the method check and before key_update()
> > takes key->sem. key_update() then calls the NULL update method of
> > key_type_dead.
>
> I don't understand this paragrap overall. Needs a rewrite.

Sorry for that. Perhaps this wording would be better:

For dns_resolver, which has no update method, key_update() returns at
the check, so doing the check with key->sem held would be enough. A
key type that is built as a module and has an update method, like
encrypted or trusted, gets past the check. If its module is unloaded
after the check and before key_update() takes key->sem, the GC has
already moved the key to key_type_dead, and key_update() calls the
update method of key_type_dead, which is NULL. So key->sem has to stay
held from the check until the update is done.

> >
> > Assisted-by: LLM
>
> Please run checkpatch.pl --strict for the next version.

Thanks, I see that the Assisted-by tag has been removed from the
documentation and checkpatch. I will drop it in v2.

>
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
> > ---
> >  security/keys/key.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/security/keys/key.c b/security/keys/key.c
> > index e88548f1a704..bac2333089fc 100644
> > --- a/security/keys/key.c
> > +++ b/security/keys/key.c
> > @@ -1101,9 +1101,13 @@ int key_update(key_ref_t key_ref, const void *pa=
yload, size_t plen)
> >       if (ret < 0)
> >               return ret;
> >
> > +     /* the GC cannot change the key's type while we hold the semaphor=
e */
>
> I don't understand this.

I will remove it in v2.

Best regards,
Cen Zhang
