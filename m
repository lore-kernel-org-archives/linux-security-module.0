Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82932080C1
	for <linux-security-module@vger.kernel.org>; Wed,  7 May 2025 20:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649530; cv=none; b=oeOsMcw9Boq9gUnHi0E6meS1hiXrRZ+BcWP8mrX03flCIGIweWR576YPV5kq2Qya5wDgTk/+p2Mk2rPgjlRd7SEimunyIJhrEXrKfuOpUUEMOiRd/AFsweN6Xa78XP+MVIyTfLP2EAjEi7tFSSYR1dasV4W837nuJI9pG/j9N0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649530; c=relaxed/simple;
	bh=qdiPfeEduMFcY18UGwTytvzaR9eZwYZDCj1Ymp6ZXOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BLIBh8eB2xJ63oRJnfMqekXBpHFel7Wj5NyjKVSPvcMt1Xn+FcbfnP5lxoq+oRvjiNQYeK71zIXze0dyZ+9x994QLagdgSr0fsin7UuuwumPwIEDftQSjPIKKZo1dPgRPNBZqpAzzbA+MSCL9KCRqYZ0ZCtqrAepzEEk0Uw3FmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LQzqmrOH; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LQzqmrOH"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7080dd5f9f1so2214817b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 07 May 2025 13:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1746649527; x=1747254327; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NALzzc7ouJeBPR1TUY0o8qCUJh5kyiSiCwpTtRH0S2Q=;
        b=LQzqmrOHVKzVpku5wUi78oaQrwRwbhtDWcpXCso8WejVRIGUrhyquzuEabtIpalxe/
         CcZMD2nPeFAQXkKLpl6Zz5RCE7uyWlV96LBixQA0CVs0YDYCTQYi4dIVm89HW6w67Rnq
         lmc5gevmbjPvcvwwrCL+D1EYwoKavGsSynG7d/utbJmBOAnrn1RDR7wRCY9RNrl3SJn8
         MlOKXZ7kqUsgjdPo5uwNzjAF50AXNJOQXyQtmFz/5t2pP8BurlZ2mScRKhA3tbdUvZdD
         Nl7PAD5VFHo3b3aoYMsScDafM6koSoEYm1v7Q37Q5ZaT4M+5xWh41pB5MdPYDIL1/36x
         VGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746649527; x=1747254327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NALzzc7ouJeBPR1TUY0o8qCUJh5kyiSiCwpTtRH0S2Q=;
        b=hHXfV0Kak0C9ao8tiZIuV08qw+r+z4wnMKN5OzDqJW/a2OO70F+eYViGvOzkQSpRTE
         A2L514cYKSOdTMHAgdOxNuxjlZa1RCZwEP5u6trIIfUFEiEocvj7htc/j9gEmu1Gwv6+
         W874xvrzEqo/aQuvimVPKfe9X9LUjRsV6+83Fp4A7mOKTmmm90u0K1LFdyjQZptjoSwF
         Vb2ypCQuQh+rqqEovTxUlkM1y1ugGsq2XnJUNB/uzKfatMPeXysJ3/PulM6XOqDa1FCb
         0tNYa319rrFmQJqZelk/gmcNK7hJETtjXeZGcCPnf6HtjsElO4IE3Uonc8Rvm9+Wb+8u
         +jFg==
X-Forwarded-Encrypted: i=1; AJvYcCU2OfpK132hExljowAkIl1/7I0Y6Ua1kW8KDeVp5/7rj3WwcsuRJSZW/w+1lpPQzJJY6N39fExg1zTEPKwNbCagEhWCcy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoPfy5TRne4jBAuGaifYxYpNPXMCgpL4ieMI1BOV1En9wXAXp7
	HCeAPiXGq5uxTI4gjeQdlBddY7Efp1mofWu8dxlPSYbfIFHGJPLti/B215Fe1eU/1+bzkLqzl/H
	omLM7Z0ZPZn+BsXiMkxBWX69NuwsjX4sBaoKB
X-Gm-Gg: ASbGnctor+t8+jlC8CzzjoCLksFi4MwYmbVafbvY4cVBS5dZ0WhH6/+v0A1zekX7elT
	yUlE3wRzqZ8xubkjvL+SFo+ndl2d6G1+mOEDu5yHY7Ay8JODeQxBsRLh+0REi2j8kNiuFnDlKKP
	fhL+bk32qbbb3Dstfv89Hf+w==
X-Google-Smtp-Source: AGHT+IEnsTmJtfSd7Oi4sYpnW+x9F1ytxun5MpNFWBa6XR5ci2YLPQTnwDSO5rA4KRr9sVcjKs48yaHdzYejiKICMdQ=
X-Received: by 2002:a05:690c:3581:b0:708:100a:5797 with SMTP id
 00721157ae682-70a1da6eff0mr72099047b3.11.1746649526482; Wed, 07 May 2025
 13:25:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250506143254.718647-1-maxime.belair@canonical.com>
 <20250506143254.718647-3-maxime.belair@canonical.com> <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
In-Reply-To: <9c68743f-5efa-4a77-a29b-d3e8f2b2a462@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 May 2025 16:25:15 -0400
X-Gm-Features: ATxdqUGLFAcBMOosGYQgzrTfPBBKYyLh7ma_JO834Kmp4fDuZcqb-SMlNb5e7uk
Message-ID: <CAHC9VhRKwB4quqBtYQyxRqCX2C6fCgTbyAP3Ov+NdQ06t1aFdA@mail.gmail.com>
Subject: Re: [PATCH 2/3] lsm: introduce security_lsm_manage_policy hook
To: =?UTF-8?Q?Maxime_B=C3=A9lair?= <maxime.belair@canonical.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-security-module@vger.kernel.org, john.johansen@canonical.com, 
	jmorris@namei.org, serge@hallyn.com, mic@digikod.net, kees@kernel.org, 
	stephen.smalley.work@gmail.com, casey@schaufler-ca.com, 
	takedakn@nttdata.co.jp, linux-api@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 7, 2025 at 6:41=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2025/05/06 23:32, Maxime B=C3=A9lair wrote:
> > diff --git a/security/lsm_syscalls.c b/security/lsm_syscalls.c
> > index dcaad8818679..b39e6635a7d5 100644
> > --- a/security/lsm_syscalls.c
> > +++ b/security/lsm_syscalls.c
> > @@ -122,5 +122,10 @@ SYSCALL_DEFINE3(lsm_list_modules, u64 __user *, id=
s, u32 __user *, size,
> >  SYSCALL_DEFINE5(lsm_manage_policy, u32, lsm_id, u32, op, void __user *=
, buf, u32
> >               __user *, size, u32, flags)
> >  {
> > -     return 0;
> > +     size_t usize;
> > +
> > +     if (get_user(usize, size))
> > +             return -EFAULT;
> > +
> > +     return security_lsm_manage_policy(lsm_id, op, buf, usize, flags);
> >  }
>
> syzbot will report user-controlled unbounded huge size memory allocation =
attempt. ;-)
>
> This interface might be fine for AppArmor, but TOMOYO won't use this inte=
rface because
> TOMOYO's policy is line-oriented ASCII text data where the destination is=
 switched via
> pseudo=E2=80=91filesystem's filename ...

While Tetsuo's comment is limited to TOMOYO, I believe the argument
applies to a number of other LSMs as well.  The reality is that there
is no one policy ideal shared across LSMs and that complicates things
like the lsm_manage_policy() proposal.  I'm intentionally saying
"complicates" and not "prevents" because I don't want to flat out
reject something like this, but I think there needs to be a larger
discussion among the different LSM groups about what such an API
should look like.  We may not need to get every LSM to support this
new API, but we need to get something that would work for a
significant majority and would be general/extensible enough that we
would expect it to work with the majority of future LSMs (as much as
we can predict the future anyway).

--
paul-moore.com
