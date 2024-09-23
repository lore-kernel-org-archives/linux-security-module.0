Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0281F9D4
	for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 21:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727128105; cv=none; b=QuhirIDoMpHUmTR1LZlLRC0Le4JanH4OGJZD89EDjm7ERB6vo8o/N3xgr1/e5mRZkCPMHz/lr2ANUkflzD/28ZIGitNWaJk1Yo/lcTRlK2eyG2QesufNyNajRZwzAiXxWGAmC23bgC0adqpgEN6V+dva5kr5YoTB3o/1wRn3+4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727128105; c=relaxed/simple;
	bh=AwTfBZiFb+FbAiJMy329k2dR0K1YvHBnxBiC9MSv1DU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SPCT9Ds62Yfx1eUB6TFl+SzkJdWk7TrbxV5D+tOJyLw/aHrhBrIJL/Cjaq18ccb61wOaa6nA9ODUs4cUlD+5bWBhWM/ouf79os6gwDa++TqbFc+rQgkMQv57VqFqN3ZJSccvLLVlDmpExlp0cLm94AmDq7PZXdI50sMG/1H9ldQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4Vy8G3d; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4Vy8G3d"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6d9f65f9e3eso41415437b3.3
        for <linux-security-module@vger.kernel.org>; Mon, 23 Sep 2024 14:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727128103; x=1727732903; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a/xArTOmSgwA3hUp3zPZq4S68/9WTou+o/ELlcdC2kM=;
        b=T4Vy8G3dFbUGzeci6+HuFu0BFl8UYkccDpBK48rn0y/+eMapfuIY5HBztxV4qrbFa6
         PrO4uoJLnRFR/1ShUUHchPXXy7z5CtyR7JUEfu7AyUucomoowGfFoP+6sJ/SjkJUslac
         gkwcFolOL6rpLq4TIk4g4sJxrmtxlIIfyIs5ER/ikDqCIxk9WEuHbhgU9JS8/Y+bNGSo
         q3Bb1DZNqi+0kpgFQHqn9pi/b0wEtcIJS1ka92jq40dW55Le1tsOFtj6gCoR3+vhExgB
         WCWbqo359g8emSKNG6JMAjnCcwdgZ3ukehKMD+Xz8WFB5PApTA0CFvnkMJWLihKv6SLh
         maAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727128103; x=1727732903;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a/xArTOmSgwA3hUp3zPZq4S68/9WTou+o/ELlcdC2kM=;
        b=TAAoJBjBS0R7zBAJejcOmzc7kO2hzMxa/T+giFtljA860BdsmCf4XSMCDfJn8e800R
         JN5AgxdlvgoA73jKatrmNA0U1QBCVtMgGabUKOfXBHdiid5dpXrs/fLkX3luW9sxsbMZ
         1xI34NkTDHAY0bYTsDG4I7fzqcEMBOT2lL2pNiLVZevSSmmvErhLbAm8Gt41oYM2S4C1
         YDILwphwO5ZIqMVEaADXF6bkjeI23vqCGeKSpsFOspocdfQa73yxwLHEUtpwGu/3lnit
         8GjuNwV9vHnrTtdJaJ3N+YSpaE6sLAWxpwg5KTsF6ZgEnyl5pyV/171JeKoRE6A/K2yF
         7PJA==
X-Gm-Message-State: AOJu0Yykuj9pZrAYR3D0gBIxkFWFrBIHCvZUbJyAMKN0AcdaqiGxLYJz
	Fa2e37IPq86L/jelp7p8FhiKxRMnmfKRDcfwJWIjAclQsZuIJMZLOlnoJFm8LqYNn5gNa6EtiT0
	P7+yM9iw/kySGG77lS+0M3XY4cLU=
X-Google-Smtp-Source: AGHT+IElsDnVtAnrkrRhHI8fp0CCbKBIf67YxAWN9/R09YAS08rC4AEVEL0kIPxf6eazpp7b5bRmQg8gMxdxzMxGaQA=
X-Received: by 2002:a05:690c:b:b0:6ae:486c:59f with SMTP id
 00721157ae682-6dfeeec5994mr97421237b3.29.1727128102774; Mon, 23 Sep 2024
 14:48:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922135614.197694-1-luca.boccassi@gmail.com>
 <20240922135614.197694-2-luca.boccassi@gmail.com> <4a8414c5-6df1-40aa-b538-a1b4c48f8f1f@linux.microsoft.com>
In-Reply-To: <4a8414c5-6df1-40aa-b538-a1b4c48f8f1f@linux.microsoft.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Mon, 23 Sep 2024 23:48:10 +0200
Message-ID: <CAMw=ZnR0M+tsLnoNAeb_+NNw4167qtU-O_Pm3NiFjwaGY5AXWQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] ipe: also reject policy updates with the same version
To: Fan Wu <wufan@linux.microsoft.com>
Cc: linux-security-module@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 20:01, Fan Wu <wufan@linux.microsoft.com> wrote:
>
>
>
> On 9/22/2024 6:56 AM, luca.boccassi@gmail.com wrote:
> > From: Luca Boccassi <bluca@debian.org>
> >
> > Currently IPE accepts an update that has the same version as the policy
> > being updated, but it doesn't make it a no-op nor it checks that the
> > old and new policyes are the same. So it is possible to change the
> > content of a policy, without changing its version. This is very
> > confusing from userspace when managing policies.
> > Instead change the update logic to reject updates that have the same
> > version with ESTALE, as that is much clearer and intuitive behaviour.
> >
> > Signed-off-by: Luca Boccassi <bluca@debian.org>
> > ---
> >   security/ipe/policy.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/security/ipe/policy.c b/security/ipe/policy.c
> > index 5de64441dfe7..01da3a377e7f 100644
> > --- a/security/ipe/policy.c
> > +++ b/security/ipe/policy.c
> > @@ -115,7 +115,7 @@ int ipe_update_policy(struct inode *root, const char *text, size_t textlen,
> >               goto err;
> >       }
> >
> > -     if (ver_to_u64(old) > ver_to_u64(new)) {
> > +     if (ver_to_u64(old) >= ver_to_u64(new)) {
> >               rc = -ESTALE;
> >               goto err;
> >       }
> Hi Luca,
>
> Can you elaborate more about the potential confusion for the userspace
> users?
>
> The policy version is currently used to prevent the activation of
> outdated or vulnerable policies (e.g., to avoid activating a policy
> trusting a compromised device). The version is not incremented unless a
> vulnerability is identified. Essentially, version comparison acts as a
> minimum threshold, ensuring only policies that meet or exceed this
> version can be activated.

"Version" suggests something that is bumped every time there is a
change, that's usually what the term is used for. The fact that one
can change the policy without changing the version confused me a lot.
Perhaps it should be renamed to "generation" or so, to make it more
clear that it is not intended to be changed every time, but just to
signal the start of a new generation to avoid downgrade attacks?

> Additionally, the version check is performed in ipe_set_active_pol(), so
> it will need to be updated accordingly. The documentation should also be
> refreshed to reflect these changes and ensure consistency with the new
> version handling process.
>
> -Fan
