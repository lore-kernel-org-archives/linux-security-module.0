Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546486AC5
	for <linux-security-module@vger.kernel.org>; Wed, 14 Feb 2024 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707936948; cv=none; b=Z3BBUY+2pGHwn19XckEakkmKKEh6ptR73dYsDjB5KMCx4+6dJEnp3XEX/qI8QEZ00Rf9T8MWN2wRn6mKSFGYjjZiubbc0BdpOLj23+4pvYGkXRfqWBgp0ZUcWqJjEhGOizL8Lf0Y0Z8Y8UE14rCeUCFg1vfkGTjDbVlujOR+knE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707936948; c=relaxed/simple;
	bh=2o9yW87YDHDJIk+FUhejOTprdZYTL4CxwGrGu5Rk+MM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TDC4PbmTp81QbroGWVBkBsAXLYUJ1EYJhCFNsvgTXZpvSGljDas3csboYOr9SRNKUDpdX0UuzKsXot0aG3ENuLjBHqauVccJP9OgAPHsS0Ih/mBF0m9pR06u7R5loOgYy6rQVGwICmDFbr9FWqTeLb3Kd7GhuuqbVnD5TwgBgWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=R23scEYm; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="R23scEYm"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-607815b5772so1127517b3.0
        for <linux-security-module@vger.kernel.org>; Wed, 14 Feb 2024 10:55:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707936946; x=1708541746; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2o9yW87YDHDJIk+FUhejOTprdZYTL4CxwGrGu5Rk+MM=;
        b=R23scEYmAMs7WILKLCH8DdZ40VNHgpksy8Bg0iao805KMFIlSLn1hqBJMmoNpqYKOm
         LEwSHeokr0KEYqQigvL5a0C7zPA7/a7gncMFP4iB9R/2RgdmjLXenHE/1lUHm6naW4zB
         hiFalWGfhDAEiqAziYuDC1uMM7IhSbDKIxMP4jBEqfmvd05JRB4tWgtpKgHOy80bBr3F
         jYAksXStSwJPhDzSLLHSBgk43hFxzEK87CWPjaMgtag9ARH/QcZ/thCAArTRmqv2alZY
         mG297YhVa13aY7aEuD7xlaKPqDJDrTGxDOk6m/TK3YOKfjLdyv7L3QlvEYeYibttnRDk
         lrKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707936946; x=1708541746;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2o9yW87YDHDJIk+FUhejOTprdZYTL4CxwGrGu5Rk+MM=;
        b=CKIC9ToFhcZpCbargTK9DO1iwYmSMI5472N3HGlBlvHTl1Bi/Mk2P1BpbhO0JcWcJh
         DKFHNJgFCAUxixzS310h0GVsDg2pcQkCkFUyzv3MTv42P4TLIDPdA8RJ+rS9S4xiHhlH
         uprLtiZfcxjiN9RVLJ7CjouuVAZ5wJqquHU8HT5KUm2UBuHkrhn3VyB7tH25KpAagket
         ytC6DMtp4ruakNDm5HfeHao1liuLaOD8bSDLYTmw4z3RanFgOgjSxna+MffQjsKOBIfD
         fA4d9zQT/j6mhunB/ZlukOWHmNQ8T3x4nkjI73X/8lXIY9C7t2w8vpMMnW+3q3s1H9jy
         xA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUaCYPQxpOy3qhbD4pA9Dl53OxVbpAeUMl18AhC68AtZZGGAYQxsaaXgC8c0a0gH/JjuAJ48p/CNEhW7I4H6VEN45Hh8Rz9p/kK0rzwdCRraNakD8Z4
X-Gm-Message-State: AOJu0YxrKU1NwI1oyKR7JZ8eBNxgarssCo0fiJVcvScVHP55RDxBBt4B
	uaEtUrwX6dcfYLCrMUq9i9eRSxNZbXfxSFti4FVPUyreoNkAufT9bLttF3GLTdplXAckROMDM+D
	Dm5HJj15NbXepg5Lqfburi8PGbpXwehnYmjWxQlKvXaWfoX0=
X-Google-Smtp-Source: AGHT+IGUo04AyZemVAkiO7tj93PLXn5mdvRMXMbOKHVilUaBMwDF1mV2je0WKEQl8JX4z+LTKHDTr8pOTPJWXflV+Ss=
X-Received: by 2002:a05:690c:4506:b0:607:b0d5:97c5 with SMTP id
 gt6-20020a05690c450600b00607b0d597c5mr1406634ywb.21.1707936945737; Wed, 14
 Feb 2024 10:55:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ad9dddfe-0fa1-40f6-9f8c-f2c01c7a0211@I-love.SAKURA.ne.jp>
 <fa719d6f-1960-491e-89c2-ed2c14d184fc@I-love.SAKURA.ne.jp>
 <2fa0a73a-1d03-4937-8599-e4560297af3f@schaufler-ca.com> <f15e4a73-02e1-4758-a8e6-0edd27224c0a@I-love.SAKURA.ne.jp>
 <757dc423-f914-44b7-98bb-fde5cd42d33b@schaufler-ca.com> <b240a8ad-240a-4bc5-9414-62bd417f0b92@schaufler-ca.com>
In-Reply-To: <b240a8ad-240a-4bc5-9414-62bd417f0b92@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 14 Feb 2024 13:55:34 -0500
Message-ID: <CAHC9VhRdqjWa0Zhw==U=kLNiSeYHDWnQyP8Yb4JNtTA7ki1gqw@mail.gmail.com>
Subject: Re: smack: Possible NULL pointer deref in cred_free hook.
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 14, 2024 at 12:11=E2=80=AFPM Casey Schaufler <casey@schaufler-c=
a.com> wrote:
> On 2/7/2024 10:53 AM, Casey Schaufler wrote:
> > On 2/6/2024 6:54 PM, Tetsuo Handa wrote:
> >> On 2024/02/07 10:39, Casey Schaufler wrote:
> >>> On 2/6/2024 6:31 AM, Tetsuo Handa wrote:
> >>>> Hello, Casey.
> >>>>
> >>>> I confirmed using fault injection shown below that smack_cred_free()=
 is not
> >>>> prepared for being called without successful smack_cred_prepare().
> >>> The failure cases for smack_cred_prepare() result from memory allocat=
ion
> >>> failures. Since init_task_smack() is called before either of the pote=
ntial
> >>> memory allocations the state of the cred will be safe for smack_cred_=
free().
> >>> The fault you've described here removes the init_task_smack(), which =
will
> >>> always succeed, and which is sufficient to prevent the smack_cred_fre=
e()
> >>> failure below. Are you suggesting that there is a case where a cred w=
ill
> >>> be freed without ever having been "prepared"?
> >> Yes. If smack_cred_prepare() is not the first entry of the cred_prepar=
e list
> >> and the first entry of the cred_prepare list failed, smack_cred_prepar=
e()
> >> will not be called (and therefore init_task_smack() will not be called=
).
>
> Ah, but it turns out that the only LSM that can fail in _cred_prepare()
> is Smack. Even if smack_cred_prepare() fails it will have called
> init_task_smack(), so there isn't *currently* a problem. Should another
> LSM have the possibility of failing in whatever_cred_prepare() this
> could be an issue.

Let's make sure we fix this, even if it isn't a problem with the
current code, it is very possible it could become a problem at some
point in the future and I don't want to see us get surprised by this
then.

--=20
paul-moore.com
