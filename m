Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57909461
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 04:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736049863; cv=none; b=aGx76d24w/H0pXgtOrG1vEyp6jizRu5mFt/xcohkR+1an39HsG4cW0ieS1E2Fabg2DVwVT4+mRHXP3scTPOCDmarDiDYlyCvChY//Dw11/+A8guFFvdP4bqq5CpDWW6pzSscmf+bbiUnIWWND9QDsKqV7IVtkBS6n4EMcunr5Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736049863; c=relaxed/simple;
	bh=3WReSFYMsKW3Kg60qssqQLXfjVQ0S9xUvUd/EYJ92MA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eOirujF+kkVojrWtUtCjD+nC5fTgLjqmRw8nTAW7awz60ID/rMxBBSJ7t1S3SpHS6M437V1PWvjFIq6XBUC6lH7og6QW9Yag4cmX/fi+uPcMq2pvgVxV5nzZUFzV7Gj115WEANX6vnarPaYX6gnK6tpyKqC4UQUuhruS5IRW2rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=OoAGyLSW; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="OoAGyLSW"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e53a91756e5so17645758276.1
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 20:04:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736049860; x=1736654660; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FHP0DfJRnVMC2nRs6LVvahB5caK8ctNmQriM6U7pNGg=;
        b=OoAGyLSWEljMJNJP+v5X1RYznmKGX3Ap7Jdw+zEmk7wS2u2MAt+5jMhTIvLZMk3HQ4
         LXJd5xFx7ZpF/K/Vs3JnmvhUW5H3VP/WVtguPnkkhC0ytI9VCotXCTzy1kVoXGHVd/U3
         BeWux1BSw7tinHIHkmdI+Pr7FNPYAq/8cLwGW1igHaCjvfyEmCnCVmqNoc7odVlVoagK
         DLN9DvZLfQmF3K1ef5EG/SPgv6oXCJ0rO2rxqAuEpcMHjQ9soU5njwuNVnfVCdrm4fH1
         vrS+ykt0/d8mrqChHLqjd1q72DKj4ebBhx9OXDYOo1kT+RqALMaSehpjQLDERGJQDFWA
         1xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736049860; x=1736654660;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FHP0DfJRnVMC2nRs6LVvahB5caK8ctNmQriM6U7pNGg=;
        b=ip7ikXfaXzWXLFupqrMLkpEN3+ZmVI92GDD6rbSd6tTZC+WEUASCjwXFRYO68E9RBb
         Dns5Pnh/P6FltDHyZXWdBZGmCcBAyfjAXghofsyFK2Q+07yC3SAQIDd+N5DKIOmMCujv
         R7pSdiGcxPpSzdk51AJlXTR5ZE2cIz6mZobTpnhHtkm/x8QhpEFyLRIO5K3SBG2/HKtq
         8xWYkBmLPAq49qrpjZTMuagsRp3va1VI4EPHHalyF5x3SdZf76rWG3xetzp6f9aIRSZY
         gB5VtNfYdO/bi5ufzImr2MNMbDf5zvNORenR0hxEZJ7+gYteNYOCrutPgWMnjzNvejT2
         VqEw==
X-Forwarded-Encrypted: i=1; AJvYcCUhO2o8iyKk85NCMYrxeavFkn6aXw+IK0WyCOahKawYilxKswqfKR3kUICwNX4SzxR6BDs/7FFYdiWbOk0u+0IY6T9ywS0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyL0hX/LfxHSUYR96h4GehgN7eq1OrMgcaTPs1DNAwBEdtmacLW
	2RINaiVry6b8dVFkbjBrNh9WUIH/4Z8TE7e/FkFrEuAUG2lZd/pwPPuGPlV7c8O3cI2HMFp/70c
	pdg/nONZfqXRiw0L7N5eK7Ux10OFqG3wTxDCn
X-Gm-Gg: ASbGnctdcFy+m07RHVP9AzE11gkzX4h0FeNXwI/74bDQPteFc4AX2Y8ZyR/9Dy/9ZJY
	aPNV4cNTlYwkj14XedKKo3dRH9wY/Z5GO0enX
X-Google-Smtp-Source: AGHT+IEA6WJmuttlP+GOkalJMb/6gOa+UmCxrDnHO9xNE01ZzBqSf8gTjyoOcpAlzXnyRqwObZS2F4VfUK/G++bBsKc=
X-Received: by 2002:a05:690c:7341:b0:6ef:579c:38e6 with SMTP id
 00721157ae682-6f3f82238b4mr411527887b3.28.1736049859753; Sat, 04 Jan 2025
 20:04:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <675f513a.050a0220.37aaf.0106.GAE@google.com> <20241217182657.10080-2-leocstone@gmail.com>
 <CAHC9VhQGeNv=UEhXPN5MN1h0xEZkeE9kbE79+k9HvNxdK_4xzA@mail.gmail.com>
 <ed6e5639-c87e-49e8-8125-5b93cec69d43@I-love.SAKURA.ne.jp>
 <9fcd3f3d-33c1-4feb-8c98-472d44bc0a54@I-love.SAKURA.ne.jp> <202412222126.E70910E7A8@keescook>
In-Reply-To: <202412222126.E70910E7A8@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 4 Jan 2025 23:04:09 -0500
Message-ID: <CAHC9VhRkAbvj=9qe8iWPCtsgkF0zvgP+pbOsUG=VVFcPgO3-jQ@mail.gmail.com>
Subject: Re: [PATCH v2] lsm: check size of writes
To: Kees Cook <kees@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	syzbot+4eb7a741b3216020043a@syzkaller.appspotmail.com, jmorris@namei.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	Leo Stone <leocstone@gmail.com>, mortonm@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 12:33=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
>
> If the LSM core did a kmem_buckets_create() for each LSM, and the LSMs
> were adjusted to explicitly allocate from their own bucket set, that
> would be one way. Or just for the LSM as a whole (1 set of buckets
> instead of a set for each LSM). I'd be happy to review patches for
> either idea.

If we're doing the work to shift over to kmem_buckets, it seems like
creating per-LSM buckets is the better option unless I'm missing
something.

I'm also not sure why the LSM framework would need to call
kmem_buckets_create() on behalf of the individual LSMs, can someone
help me understand why the individual LSMs couldn't do it in their
init routines?

If it is necessary for the LSM framework to create the buckets and
hand them back to the individual LSMs, I would suggest adding a new
flag to the lsm_info->flags field that a LSM could set to request a
kmem_bucket, and then add a new field to lsm_info that the LSM
framework could use to return the bucket to the LSM.  LSMs could
opt-in to kmem_buckets when they found the time to convert.

> I think per-site buckets is going to be the most effective long-term:
> https://lore.kernel.org/lkml/20240809072532.work.266-kees@kernel.org/
>
> But that doesn't exclude new kmem_buckets_create() users.

Is there an update on the per-site buckets?  I agree that would be the
preferable solution from a hardening perspective, and if it is on the
horizon it may not be worth the effort to convert the LSMs over to an
explicit kmem_buckets approach.

--=20
paul-moore.com
