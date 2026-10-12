Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B377D49BD63
	for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 15:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818601; cv=pass; b=gubb2I1HvhK9TYUfHNcJT7Y4jE02KwMmfvAHprtzrM4C9xdhK0pUgGIV5V1bSd5BrC0DNZvMhLS09jCqaGplUfo/EmzKrnON7ZoizmgV6e7WaShrEfcUuAvTZf6FYdODUCeb51fdqxmvDDpSHN+MYBY71CzlyYKz72sQ74NbvDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818601; c=relaxed/simple;
	bh=ZTliVUlbqhN96UOmLmVxV+MSqDsRny4axY4ONWBVUaA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bgLAWiQBoCO5viiPnLlwl4hF0d3QO0hSs3Hy5QP+4jmyo+VdnO1reT8H9PeeCaQiCypm91I2rwqsYDrOBXXkThOTg0G7nJi3HBS4m87uaf38sdnv7waJlQxLKlnz4Cjd82jJWte9DJAI9sQcHVWnmxnhC9vCPymP4j78v5GWYPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vk72UCtg; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vk72UCtg"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6711f05fb14so1589693d50.2
        for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 08:23:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791818598; cv=none;
        d=google.com; s=arc-20260327;
        b=WKLvDLyjEMt1O4+xEb+og9zPGQl/iTwmsaLGwtqMHX64/U/gYH1TArcZtyHlfsvHv5
         5L2M4QrpO2waKCNi8/raguJorxKxdQfkuJg3J8IpAti/0ZcC5gloc4EOUqV4xCwpbz9z
         bq0y5S219CXBbl9Kkf8VMFGfyrrFcXdrhnIySGYoqYOCML4GXCtfsifALutBe5XHpTSz
         QCu8RWFCa70Nlp3X5qriP7l+IMm5t4NAf9+scbgBGsZfcO2Qq3tRu9TGOLNK0m3U/z8U
         yoaFVBmmh6n6BeXxGYAzZBIPF4jWGWnSjbRnnI5pmYF2XswjwKnHj9mu4UhTXPph3ZI6
         OqeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dxe5/7iE0L8+p44y9JDuvt/mRgid1dnQVUsBId/B/e0=;
        fh=iZ9D67TR/9XzCsfVJl/14Vw2zez+vFisTOb4wngII8E=;
        b=YNwG/QKy+CRxTln41yadXQkjf5dmwYM57isjkgNzjCyoGm41aC8BoCB5ZO0yWBh0zn
         Vji+zhYh0dOG7wLK/eWmcV9e/dysUK4zSKXYqd7FgGZoGsLw4gw0/KkiBnBo9XFVu1ac
         wMz0yEDjYdSl6VCZSThU4qX8L0VQ9hvkvwrSB+YOqI23lAtfxkwPJJAefE79cHdtnbZc
         oua4mAzDGXXLAL1efFXB2qNwat38I2hrQQ6JxJxpEGbGPDrcTsH7r8pdyufZt0qBQ3QD
         AA9QcJJaMT0ZtoY5oQow2Ui25y+FJU2YtV6dzxLZESv/kaEbGhhi2UPHcOvN+hDkmXpq
         CG3w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791818598; x=1792423398; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dxe5/7iE0L8+p44y9JDuvt/mRgid1dnQVUsBId/B/e0=;
        b=Vk72UCtg1FJGt6IIETfINuJHT7wXKgEY9Qbw3qEt7O9vb+OAcU/e68raoZtAWUJ1jG
         tD73IhvgFuFzgBtbS42Rejf/O54aW7yaCMlTCgODMQ1XZU64ujWo8oXLdqkp7c9X8b1z
         s/vjqh3D+8ysnSrOVytEVjqPNY+FX+FGWSXXcuWSezEb/63ldb0JAFm7Bu2cRo/+n2Vy
         1VX7Rvt/uEXf0RXCJOhSVAZMqap+U9zpCmAY55LLvA9S6+7OiQ0QNWGGxkEVwf0mbiag
         fi4T7kMtKuDZi+joA4LQVRfO/nkaJ5HAxaauZ2ierfzrFbiX2GU4UUbWzYn7aBz/Jh0w
         obvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791818598; x=1792423398;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dxe5/7iE0L8+p44y9JDuvt/mRgid1dnQVUsBId/B/e0=;
        b=iIRSjWTTi5TngKELRqcv3qKGlwZ1iDtac4hs4AW5WW/KGaTNgXjUJcQKRZqrqfSjBh
         dXEhyA3AEs4K7Xc9vpvbUu7ba5OtEkngEOsGu0F5SuQiQiBscuFZNO34oa2aQXdUFH6R
         +yvlcCIr9XaGP2fJmrRdCUMXp9DCLLpFx1ZV9yXBpt2xMsChVY91dL1sEYMTP9VFm25m
         KaLZP5H20yA4M3ogbbbaQa9gf/Orogdn6cEwuPzxAnpkpdBF97fxTBC45QybNyRrzzCa
         aSmdxKH3h2EJjKIydZ+Km0FToGiOyOBELJfWny4puBtzJOg3J5OtgHLw+98rlC6NTtWS
         gSCA==
X-Forwarded-Encrypted: i=1; AKwUvBwsYc6Nmb4nVyalXJDXmT8dORdPT4ebKX1ROwFzNm54qEjbeEHllmZkYS32BvHeZOWD1OldZsuwBjY4dvonsVkj5GsQHfo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLlduXtkjEDUnZz7lIzvw9J36LKAKJdFadqpdv8/NBZtyfIeu4O
	EICbRIArxJ2j0XHUmWyFzC81c8OKu04TKA3lHS+LNIG2bKR+QOF7PCOpBBCeDOS4V+f7KIjQTBf
	wPfgvh5MDuMcsrYq9Imq/9gLyJ87G8spC4g==
X-Gm-Gg: AYBFou1dAFaxe4Hj+j8Wmz5hwxOFku1iu3Ci0XsMCeqbZTurBFlLQeeGwTTSc9JC1dP
	aFaNZFdoE4DfxgCpop7vh6Gd9sEvYlQqKE/fjGwTvEx6c+GbwtnyMFs1zq59LnX4rxUnG4zu0ow
	TBpxsUD8QKn6SpLgDSTyd4AvMSS3A8IeyuqRNQK0WHuM+utmhFEPrkpHzeu1yQdn8lyobYnPhdA
	gt86KPQYGPSPJjEQ/lwq6qGr26HT+CefSCmi78UjiGmFlKEOr5bGMssnpCE6k3vA0zaX04n2DRk
	Fk5234fKARWuYBBwM12q8ZOV+wF2VFTDkRhnDutpXgUPQMTf0fZS3i0AiPeyrCl36Eo=
X-Received: by 2002:a53:ac86:0:b0:677:d0da:192b with SMTP id
 956f58d0204a3-67936006671mr3791582d50.31.1791818598572; Mon, 12 Oct 2026
 08:23:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <tencent_96F9E846FDA4A67FF38C7C393D985A44690A@qq.com>
In-Reply-To: <tencent_96F9E846FDA4A67FF38C7C393D985A44690A@qq.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Mon, 12 Oct 2026 11:23:07 -0400
X-Gm-Features: AclHuK-lsvXIdaTbY4bhYNDRFlD_elSj2POyX4r8YNdsklre3_y2ohDtohrCN9k
Message-ID: <CAEjxPJ6oN4zZ+0fTS8+Unp7wNRYZxjWCBrc5XQLUOFbt-xU2Hg@mail.gmail.com>
Subject: Re: [BUG REPORT] selinux: general protection fault in
 avtab_search_node() during an AVC lookup
To: 1sh1ro <yangguikun19@qq.com>
Cc: Paul Moore <paul@paul-moore.com>, Ondrej Mosnacek <omosnacek@gmail.com>, selinux@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 10:38=E2=80=AFAM 1sh1ro <yangguikun19@qq.com> wrote=
:
>
> Hi Paul, Stephen,
>
> fuzzing with syzkaller on a 7.3.0-rc5 KASAN kernel (SELinux enabled,
> permissive) produced a general protection fault in avtab_search_node() fr=
om
> the AVC lookup path.  The policy's avtab appears to contain garbage: the
> first fault reads a non-canonical address, and it is followed by thousand=
s
> of further Oopses (8850 in this run) as later lookups keep hitting the
> broken structure.
>
> The crash
> ---------
>
> Oops: general protection fault, probably for non-canonical address 0xe06f=
3dc280000000: 0000 [#1] SMP KASAN NOPTI
> KASAN: maybe wild-memory-access in range [0x037a0e1400000000-0x037a0e1400=
000007]
> CPU: 1 UID: 0 PID: 14271 Comm: systemd-udevd Not tainted 7.3.0-rc5 #2 PRE=
EMPT(lazy)
> Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-de=
bian-1.16.3-2 04/01/2014
> RIP: 0010:avtab_search_node+0x24d/0x4d0
> Call Trace:
>  <TASK>
>  cond_compute_av+0x59/0x340
>  context_struct_compute_av+0x7f2/0x11f0
>  security_compute_av+0x558/0xd60
>  avc_compute_av+0x86/0x820
>  avc_perm_nonode+0x9b/0x170
>  avc_has_perm+0x27b/0x2f0
>  selinux_inode_follow_link+0x226/0x380
>  security_inode_follow_link+0x96/0xe0
>  pick_link+0x447/0x1570
>  step_into_slowpath+0x928/0xdd0
>  link_path_walk+0xdae/0x1b20
>  path_lookupat+0x70/0xb80
>  filename_lookup+0x213/0x5e0
>  filename_setxattr+0x89/0x1b0
>  path_setxattrat+0x1cc/0x2a0
>  __x64_sys_setxattr+0xc6/0x140
>  do_syscall_64+0xec/0x4e0
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>  </TASK>
>
> Context
> -------
>
> - The task is systemd-udevd (uid 0) in setxattr() (ORIG_RAX 0xbc), which
>   follows a symlink while walking the path; the first AVC decision for th=
e
>   symlink hits the corrupt avtab.
> - The same crash appeared on three runs of this fuzzing instance:
>   2026-10-08 23:39 UTC, 2026-10-12 04:50 UTC and 2026-10-12 10:48 UTC.
> - The kernel log of the crashing run shows only avc denials
>   (permissive=3D1) and no policy (re)load, so the avtab was already corru=
pt
>   when this lookup happened.  From this run alone I cannot tell whether t=
he
>   corruption originates in SELinux or comes from an unrelated memory
>   corruption bug in the same fuzzing session (that instance also produced
>   unrelated memory-safety crashes around the same time).
> - No reproducer: the instance ran with syzkaller's reproduce disabled.  I
>   can rerun it with reproduce enabled if you would like one.

Yes, please rerun it with reproduce enabled. Thanks.

> 7.3-rc5 already contains the recent policy-load validation fixes (class a=
nd
> permission counts, level category sets, boolean values), so this looks li=
ke
> a separate instance of the avtab-corruption family rather than one of tho=
se.
>
> Thanks,
> 1sh1ro
>
