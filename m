Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDBF516A381;
	Wed, 29 May 2024 09:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716975500; cv=none; b=Ou1i3bWq6G6+arSHYuVebTB4tlRPxmuj6RKgvWHmEEHKysHFwwyjPUZMyf3DFhTB3iLo3pc+YRv2SfwS4v3hKPMzwQuvwkYP5gv2nbqNWIqnxM+wEPNlClkpyy27NSTnSaqhcdjDve4n0GV4t995mVDiDpoQNuzt/hlhPgow/94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716975500; c=relaxed/simple;
	bh=nRx92IjGm86HR4V8oZzkRs0aIanlP+XxMvyW7SOoQPE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ctky4x/bZQD0GtdVXkDs410Jiccc7OtcIaKp+2rDszebLjQjtqAzNJMt2L6ZRPgxAUDCwHfVc5sEjI4GXVfzhhFKgmkSAizzMx+UjbJ7zpqygJB9soFt7PLi9qAUcGIvefWfSaDoKPblbegH2XNBsrpLYufGhaetwAEcS5TYn5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR56hVG+; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR56hVG+"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e6f51f9de4so25522911fa.3;
        Wed, 29 May 2024 02:38:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716975497; x=1717580297; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRx92IjGm86HR4V8oZzkRs0aIanlP+XxMvyW7SOoQPE=;
        b=YR56hVG+45U8zxvkuLUwK+wkrRHivvK1jlcj0kZfzXP2DqzPpRhPgPVTI9x9q9hjRA
         bTrocIfEzO6ZA191VcWAU4KJXZQroSqAuOqj39TIveN0CYrwhiml/1twtnJ9MSXVt8W2
         uWjE/ppy1nJ0/XIS6L4KMnMAp2aBRi1MjKVyW8kgESOhuuY0Ca7c+lt9R0ww0zb2YgIo
         FVmINdYwiqQ2kE2+6Xejey+2r9rUbZY9bASlB+/wcgoSi+j1sKR2RSp4hoiGWbe+u127
         Gv7OmU8OCNU384w/cTm6+r4PLlYr8VI62j713Vkf8X8qGSdWRIVZrLKENXLf335z7EzX
         aSKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716975497; x=1717580297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRx92IjGm86HR4V8oZzkRs0aIanlP+XxMvyW7SOoQPE=;
        b=fEnxUtRs5MBMFz35UVNi4dMh7ASKhFQuPpqvQu4rXabgZJxvXWLlcBNUNWqyGWN2UI
         0xVYv2OkQOC88A5JndyG7nqdmlsSdGTVKs5zUVc8UOVtvdwwwZzw4TheFpaTpBCPV0wX
         2oqarbm3OBGBS1gLFiluXgCuyAQIKLQD4Yhs5TBKEL40rFN7nhVi41T5E22GGdh7BTqk
         Ua2/Z7Zj25Odgz6C9CtRie7z4+q0elTwtitpkXAMsqKBJAJwS5So8T7HRGAsetDoIhNV
         GIEdQ8YsTqXf/B6JPEciTYRac65+Xdz7QDkxQrU5LJZ/eCvW6W5eK2WO29AYEMbsptJq
         NsYA==
X-Forwarded-Encrypted: i=1; AJvYcCVZXmBpLSsLKWbSfIwqhJrneoS8uL+1FmPdG6oNisbQl1tli96Jo+UPCDIB9sq2w+jq1h1G9+l6+6CWIRAeP/Wp6p8QEQGGyW3NrihQve1fTSKxmSKUtDWZr+KW8Hs9rQgB/4U/qO1JVeQqLbk7ayzqD/CP
X-Gm-Message-State: AOJu0YxftKEe4ULDTFO1ncV2amwVuOGoXJO/G1+akGnM65Hy5wCrgxL7
	Vh96At4+rRE66kS6KzSFyvAl0RiH9WzTxoISpjrDtQ1xtNDcaNTOAy7562aqB9C7GsTtR7q2+cf
	z01sO4+BrvJUz2kbF5ERJIMHOLXc=
X-Google-Smtp-Source: AGHT+IGmab8FsMOO1Mi1C3BhAPxA07HolrdLa1W444dOo1v7T4E8Z9DRX4WhskR3J6/tv+9ZXdM+1wnNxU/f8/8kKLQ=
X-Received: by 2002:a05:6512:3e19:b0:529:b718:8d00 with SMTP id
 2adb3069b0e04-529b7188dc4mr5909595e87.8.1716975496547; Wed, 29 May 2024
 02:38:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f184a2d6-7892-4e43-a0cd-cab638c3d5c2@amd.com> <096178c9-91de-4752-bdc4-6a31bcdcbaf8@amd.com>
 <4871a305-5d45-47d2-85f2-d718c423db80@canonical.com> <CAGudoHFkDmGuPQDLf6rfiJxUdqFxjeeM-_9rFCApSrBYzfyRmA@mail.gmail.com>
 <3b880c7c-0d19-4bb6-9f0f-fb69047f41cd@canonical.com> <CAGudoHEycK3iTO2Rrsqr56_Lm69rCzMRaYz11NLrOcn5gKB3RA@mail.gmail.com>
 <5c94947b-1f1f-44a7-8b9c-b701c78350b4@canonical.com> <CAGudoHFxma+H_iHPV8+gfEkHc0uwFD8=rJtFy7ZE3TH+7tGiwQ@mail.gmail.com>
 <78cfe966-33ec-4858-b114-57697e478109@canonical.com>
In-Reply-To: <78cfe966-33ec-4858-b114-57697e478109@canonical.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 29 May 2024 11:38:04 +0200
Message-ID: <CAGudoHGqvAuAYnc75xRhSMYfxRbgpQuCYnxUWiCXJM8YtGJxjQ@mail.gmail.com>
Subject: Re: [RFC 0/9] Nginx refcount scalability issue with Apparmor enabled
 and potential solutions
To: John Johansen <john.johansen@canonical.com>
Cc: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "Gautham R. Shenoy" <gautham.shenoy@amd.com>, 
	"Shukla, Santosh" <Santosh.Shukla@amd.com>, "Narayan, Ananth" <Ananth.Narayan@amd.com>, 
	raghavendra.kodsarathimmappa@amd.com, koverstreet@google.com, 
	paulmck@kernel.org, boqun.feng@gmail.com, vinicius.gomes@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 2:37=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> I don't have objections to moving towards percpu refcounts, but the overh=
ead
> of a percpu stuct per label is a problem when we have thousands of labels
> on the system. That is to say, this would have to be a config option. We
> moved buffers from kmalloc to percpu to reduce memory overhead to reduce
> contention. The to percpu, to a global pool because the percpu overhead w=
as
> too high for some machines, and then from a global pool to a hybrid schem=
e
> because of global lock contention. I don't see a way of doing that with t=
he
> label, which means a config would be the next best thing.
>

There was a patchset somewhere which adds counters starting as atomic
and automagically converting themselves per-cpu if there as enough
load applied to them. General point being it is plausible this may
autotune itself.

Another option would be a boot-time tunable.

> Not part of your patch but something to be considered is that the label t=
ree
> needs a rework, its locking needs to move to read side a read side lock l=
ess
> scheme, and the plan was to make it also use a linked list such that new
> labels are always queued at the end, allowing dynamically created labels =
to
> be lazily added to the tree.
>

It's not *my* patchset. ;)

> I see the use of the kworker as problematic as well, especially if we are
> talking using kconfig to switch reference counting modes. I am futzing wi=
th
> some ideas, on how to deal with this.
>

Thanks for the update. Hopefully this is going to get sorted out in
the foreseeable future.

--=20
Mateusz Guzik <mjguzik gmail.com>
