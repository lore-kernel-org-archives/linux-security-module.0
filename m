Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CD953E23
	for <linux-security-module@vger.kernel.org>; Tue, 20 Aug 2024 04:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724128762; cv=none; b=BLrESAA2N6CQjlFMwwAWlCZ3Ll2PiTHX/ALX72OBYe0/YEY/LvabkMPB1gurHa7XB9HQBNQfLBfy0qenh4fw1vYgBrwzJl87nK21MXJ9pwgRQA5j0LbvwMvRH7EjO8Ec1uXjsZOUlK1KgPl21r2+cz4fg85iwMWeQAuZiIgnnqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724128762; c=relaxed/simple;
	bh=x8SXMFpjGPOwJ8LoO1Tb2GK4QZZAJ8O1PgsLSdeGr+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b/6OjkVy3VnKVf4ey+eNm0JLiheyyG3LENeGWQERTxsoAkp53kLo0eIcwS/cOI0CWp6sIetahKiLrmA5KUSAWJfVxKweToSqp2W9wNjVhV6i+NZlXXLO+OmmJI4n1EmJkhVql1NQxhVnI27oTH0k5dLQ0UyiaH/C8wr1Ys1EVhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ZJyotmYl; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ZJyotmYl"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e0ea24477f0so5390360276.2
        for <linux-security-module@vger.kernel.org>; Mon, 19 Aug 2024 21:39:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1724128760; x=1724733560; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVLG+2V5adXXHXUhEy1H242ae/Dt7QyF68DVBbvLxYY=;
        b=ZJyotmYlcmktT7Y5eaxIrPXLLseKZCnrb6yvg3rjYLURA4lLJ2KhCzdSYMra8BW0+b
         YL+npqe7ZocxL3Zv6CGTZMaWB6bzW7y2Y8iUCjYvCZtsFWozE7qT+RSqSXwPOtJQn87L
         ReB4Hf5glhQtClPlXANSeUHz5XaKdEBhqWNmCQ+jPelmuPoqr+rJZ8uOu2zF7TF+QXko
         uJFaI4TKOgnuU69w0b2Jq77zse21iXImnDfDXWSKjMJHDi837KSyFbZXblO/Z1UVBALK
         nftTxNU0CjTKDu8Yv9lFfJ+GoHaNwqf3/Pz80+iRDWzvUeWTumIuqPZz4S5hXZq+n6IC
         vNNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724128760; x=1724733560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GVLG+2V5adXXHXUhEy1H242ae/Dt7QyF68DVBbvLxYY=;
        b=uezjFuqhO0y95IhPxutRcaYFbquKE3b++RmT3TkU/0kyGDchjbjm9ZVEBMzKYOLCR2
         A1ClA5ZDmxo1JjqjJAv6h7LOrFJ2E2zRKbwnF173YGk3UQ3fd0QoRwqPPx6W015WgCEf
         1sEfuHsf9pbWgIF9h230UGYR+m0LFMFkwZBBpOFInsJhBVZsT0w+4MMCAo/MWEs9ORL6
         1Yj+fc92XTJnrLghOOCCzZlk+r619ntzpGER/DjHuWFeJK/Rojngrs39L24gK54a1fs4
         J+i7EGGVFcRy22OhV2LakgMxoOVRhsyttHdVazzOS1/CJTCauMNoXh3+rARv2CGPt1rf
         QPpw==
X-Gm-Message-State: AOJu0YyYltuLM9jKz4auM1KxOZws9DHKTorXuzuOy0dyeilZkB/VXiWi
	BhcBBMvkC26mxV8aNPByHqLeMk3TeJ2j7hV08cuTHtFOALCHh8q1w3GGc/LfmAcnb5VlqC8kMh9
	NFRYiP1gxHm8pWZoiz/dcgA6dNd5qAO4zyHIl
X-Google-Smtp-Source: AGHT+IHBZJsmdHe3NGOVgh/bOqPFH1XH+ZrKh82osDensmly2I3g0Bu1sbUvsfEwVI8fgR0Yf2jItzzaLoaJBzyFEoA=
X-Received: by 2002:a05:690c:2e90:b0:6b4:e3ca:3a76 with SMTP id
 00721157ae682-6b4e3ca3c9dmr80575167b3.19.1724128760224; Mon, 19 Aug 2024
 21:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816154307.3031838-1-kpsingh@kernel.org> <20240816154307.3031838-4-kpsingh@kernel.org>
In-Reply-To: <20240816154307.3031838-4-kpsingh@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Aug 2024 00:39:09 -0400
Message-ID: <CAHC9VhS18-1+a1Ftep66-AX4Z_PVeSMr2D_jsG5njStWgFJRig@mail.gmail.com>
Subject: Re: [PATCH v15 3/4] lsm: count the LSMs enabled at compile time
To: KP Singh <kpsingh@kernel.org>
Cc: linux-security-module@vger.kernel.org, bpf@vger.kernel.org, ast@kernel.org, 
	casey@schaufler-ca.com, andrii@kernel.org, keescook@chromium.org, 
	daniel@iogearbox.net, renauld@google.com, revest@chromium.org, 
	song@kernel.org, linux@roeck-us.net, Kui-Feng Lee <sinquersw@gmail.com>, 
	John Johansen <john.johansen@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 11:43=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrot=
e:
>
> These macros are a clever trick to determine a count of the number of
> LSMs that are enabled in the config to ascertain the maximum number of
> static calls that need to be configured per LSM hook.
>
> Without this one would need to generate static calls for the total
> number of LSMs in the kernel (even if they are not compiled) times the
> number of LSM hooks which ends up being quite wasteful.
>
> Suggested-by: Kui-Feng Lee <sinquersw@gmail.com>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Acked-by: Song Liu <song@kernel.org>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> Reviewed-by: John Johansen <john.johansen@canonical.com>
> [PM: subj tweaks]
> Signed-off-by: Paul Moore <paul@paul-moore.com>

For future reference, it's fine to grab the commits that I previously
merged into the lsm/dev branch to use as a base, but you should
probably drop the merge edit notes (the stuff in the braces) when you
(re)post the patches.

>  include/linux/args.h      |   6 +-
>  include/linux/lsm_count.h | 128 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 131 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/lsm_count.h

--=20
paul-moore.com
