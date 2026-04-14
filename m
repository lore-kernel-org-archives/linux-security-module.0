Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3BD6344031
	for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776175175; cv=pass; b=jvz6WUY+YE0+HVA4Bs1Ep/KCcKRxDOPGkLIiyjeTEfp7HWW61+QiqX/3Yjs7f+V5PrS5egjPVk1DWO7eDlTZnyYPTw2S7Rcbv3p7qpzxAXdRaGQuNcg/4nKHVDnfgburT2pjOM/rvWQiuA4RH92z/m+d1z09nUkFjQHy4Gtkj4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776175175; c=relaxed/simple;
	bh=uhkKoG4nDJFkr1B87DG2veQXw+10pkGHqsixQqY1vjQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B15qDuqhG1gR0VEAti4mXbxD6EwbhLId/2SZz3wLi3jVuz9b/9GtqqR8IVXL+I27y7/xpNSMjf4RRTmxDmo7xthzBSdEY2+wYMMCqGz1CUHM62x/gBPVW+FgIHdrCJcmbpticcYRv+WWCX6EtvX7dN/rvjK+hVws1ay2ricc3CE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=S1MkYPEj; arc=pass smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="S1MkYPEj"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-35d90833cacso3382564a91.2
        for <linux-security-module@vger.kernel.org>; Tue, 14 Apr 2026 06:59:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776175173; cv=none;
        d=google.com; s=arc-20240605;
        b=LHuUuhvAmpYzvMHLRt8Xfz6/aGeez+0TPpTYZWeZL++Jf7P5tToDA2wnCHg7t6J9Sb
         rr56JSDrEXd8v6waAlIhxVxqU7artBjvnCk3M6S0cJGiv/HnwEP2YlYNQGGf9z04UZqX
         f/vrJPU56WCua6wFWqwX2W115LSg3ePpjoJCsRyfGtYLmGSRoaHrWdHBK5BEA5LNw5KZ
         X0p8/lz1dJbCg7jYnwTw2PrOgpOF2ThyowwL2AAzlUQV3d6zhjxSgP/oCodVnoU6IJq8
         2J9nbSmUV27Z8wMCOq1bPen8pYo26I1sIYyV8chbtEaVz2Z9gkL9riXKfon9RwVmPziF
         k3+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Yn7fwY2ls7VFIteCUJo+VkkyMal6bHZLIgIF+IhGWsA=;
        fh=jqAKW33Zr+S/ASLb4akDX4FbKRj8rdayHzdUVrmiypA=;
        b=cf+lrIndjPbPnqmPdEJJ9Y6nwlX4QsBc4wcMygarTEYInBnCJPNdLnF2y60uitL/cE
         8KrEoija4i8hPxMOq1UDqHrGAmbBF6TWwf1CjBdZCxDkZqGKhWmCQms1wiQcSor16FX4
         Mak+znSal5etosd4UlHN/Gpi8CBk4M1pHds5WCXvev2QUWpVdYohRbbX+u5v1P4fvTjM
         rfgqW5f+V9NeY1t6YLZ29UP1WkvXmXjFO9PWdSnHlimeun2pzQlU67wJt5KhZpr0po0M
         mWf0X+jK9KXJ1IP5reS4TYyL0bomG3VERm2U3yiKSsZ+2cbQkCeatb0C/gmy1kMkHx5j
         eHKw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1776175173; x=1776779973; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yn7fwY2ls7VFIteCUJo+VkkyMal6bHZLIgIF+IhGWsA=;
        b=S1MkYPEjty/sVOA2T+1I+hWL8KKin6SHIOjyVMNImxiNyf0I1sbsAHw8EsNKlU7taq
         +XW/aZ02YfFJzwzVXRVK6nsAAIKN0MBiPGsXYmF/4V2yuT17DtH9SPG8qYt8VG/8OrVm
         spPhxGYmOpEuArNdNazZyhXVPFDRNh5jCE2iBcKbWyWr4+rLxm94Ow9sXCOsE37yTALR
         uDs91LvAenykXTTkEEuUlUVJP8oB49Kv2rznZA7DixGTsUBCEd2o9mHOfpB58hA18ryW
         XSoa6bbClo8vdKEZJoTdhrpLKIhY7OwX+ZBs0uD8dGeFc9RGY+tD600EbxCwqacUhpA5
         OXSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776175173; x=1776779973;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Yn7fwY2ls7VFIteCUJo+VkkyMal6bHZLIgIF+IhGWsA=;
        b=LnsKX6X0k5an41VGpzcYCthORUkTB2wRbTgnlgTQATSfA/BJcIJKDOxUGKksmYY8C0
         arS11Od8gbgyU5lFb8e5JJI4KoYXc4+ZIRS4d6X29nlhan352LSpHZpm8WE/bGJObdhi
         X71vis3XgPvvpA7F4ogjoBYTCTUnn8LkW/z69t/NUkHT7Zd9sQL3lcV7tYK32A7ITp/8
         jLghuOcRIiYDfcSkPOdHarnMREBnlIFQAYi0nLI6DV79btp+G0SjbowPQ5CcRV3ps/0t
         Oic/sIcbLKzRc/2sgUmt3mY8XfBrH0vBSapJnI4vmi44Pc216KCpJ9Vp1lFa6Lf+/r4N
         zEcg==
X-Forwarded-Encrypted: i=1; AFNElJ+NoRDd3raeMWTP2cfIkhdgNkB6d2WxFu5OurV9nS2Z4VtsdysdytboB77X7xP9b4YUDg9ER962DZJZZEf2IkzH+60OMu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1L7JnSMmTZ1+LIzTToIdxtS1qOJTJZr7IjXm5JqMDCObunRbK
	qaMt6gXFiFODJXveiYnLbfYhUOQwtk6fy1MHtIaVJ4rqY8eb6qwnPlsLN3C0mFzk6AgOOs2Ep/Y
	w2kyS/QpjHa9SuADx6pOSKGx9qGu8Z4YXjAivTAH4
X-Gm-Gg: AeBDievCkqzCGADZKt3whjADPeyrqeuBxoHIcAkW4UkQ/hqzYRcWLY+qHeRpK4SsmAi
	u9cqix3SnLZFSnCKikBTxkgYBeXmocVS0t1WXEdDTfd1AkFyC5y7MzrI12s0O5GMvLwW/ayN8Cu
	NUl6SkDwLiC0ILkR0iXXLOOQujdVsSFeIDtt/DYkr0Gfx1i8+zGITMEiDwI83D7jHrgHJdjhA6B
	Ig+aqD8KeQpQRCt2dnVRZUS0sUhLV5gRWW5ojm7A9a1oi4+DKYjy4rQa70MdU7NTQs/3aKskIPZ
	yU01hh06G6e3hQUgmg==
X-Received: by 2002:a17:90b:4a41:b0:35f:bf4b:c396 with SMTP id
 98e67ed59e1d1-35fbf4bc5afmr5097560a91.1.1776175173140; Tue, 14 Apr 2026
 06:59:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69dde155.050a0220.3030df.004d.GAE@google.com>
In-Reply-To: <69dde155.050a0220.3030df.004d.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Apr 2026 09:59:21 -0400
X-Gm-Features: AQROBzDmCcuqLX2LRPTmlUV3w5wYWNkElipbcPGc2XI8z-enDYeQlCt_CgR9i-c
Message-ID: <CAHC9VhTO4z1oPnNK748oTU6H7FcnxL2yzbuqkEKAfsrDV2Rcig@mail.gmail.com>
Subject: Re: [syzbot] Monthly lsm report (Apr 2026)
To: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+liste5004e02dae137bbd339@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 14, 2026 at 2:48=E2=80=AFAM syzbot
<syzbot+liste5004e02dae137bbd339@syzkaller.appspotmail.com> wrote:
>
> Hello lsm maintainers/developers,
>
> This is a 31-day syzbot report for the lsm subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/lsm
>
> During the period, 0 new issues were detected and 0 were fixed.
> In total, 3 issues are still open and 45 have already been fixed.
>
> Some of the still happening issues:
>
> Ref Crashes Repro Title
> <1> 95      Yes   INFO: task hung in process_measurement (3)
>                   https://syzkaller.appspot.com/bug?extid=3Dcb9e66807bcb8=
82cd0c5
> <2> 68      Yes   possible deadlock in keyring_clear (3)
>                   https://syzkaller.appspot.com/bug?extid=3Df55b043dacf43=
776b50c
> <3> 31      Yes   INFO: task hung in ima_file_free (4)
>                   https://syzkaller.appspot.com/bug?extid=3D8036326eebe7d=
0140944

Mimi, Roberto,

If I recall correctly, we've discussed the process measurement issue
before, and I thought it was being resolved.  What is the current
status on a fix?

I don't recall discussing the ima_file_free() issue, but it looks like
the syzbot reports go back to 2024; is there a fix under development
for that?

Thanks.

> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> To disable reminders for individual bugs, reply with the following comman=
d:
> #syz set <Ref> no-reminders
>
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
>
> You may send multiple commands in a single email message.

--=20
paul-moore.com
