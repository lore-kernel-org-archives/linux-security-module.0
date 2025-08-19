Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B65D30FF31
	for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 18:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755628866; cv=none; b=Il637P6ZuGZACUNfB4ttMpXlv6q0tROWZqAJOVb0bf+c9ZYO2W4VgsChKf2m6hyoeaNjI1zZCS7QU+OoXfxomnBVIjNbWMA/dJyh+wFdF/hP1ir5NBnzqFTy5YiWy9Ic0ImOmQHqH+/gwp0QwShTU2OZfAHnOYqUE5BFV6PCkdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755628866; c=relaxed/simple;
	bh=W7sVkeb5pWE1Au3Nc9LfMt6/vUKKnkVU2aVsvV7RFLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L8vsn+ddYM9C1QaR2BzH5XYUUCAqAMF2SmRPPPpIyd/XhUoC4mt1w8ht09oIfwSJGTVEMfXzIalcyqlpg3ULS71/RmZaen54EcDIBqxceObo/wpC5vVspbAxQMAqlkdSJmER8b0NAerg8m0ksZ5OyhQab0VlJ5Er++qYgNXtWUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=f7LG8uy+; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="f7LG8uy+"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2ea94c7cso4982058b3a.2
        for <linux-security-module@vger.kernel.org>; Tue, 19 Aug 2025 11:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1755628864; x=1756233664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxA8r6gICCYCTtmqt0g1TsD+OxRWGjOL0XWuu12ws+0=;
        b=f7LG8uy+jW859njIbV0NYezcZeWb9Gv4XkrtAPhhzvEClcQBeLiiq3gUecKUY29vP7
         oqRfkF4dwx+Vfh/VgTtXOsUSGZuHb3VrlYlAubHLvXunlFpsBTfnR8zUmauXx7ooHntu
         gVRATnyuLC3KkiWw9rIwps/ql20s/xn0Vwy3J8pxeu9N9+j5wl8uzuhemkcFrDJl0kOj
         Gcq5XbXvy+jztRfhxQJroVUwDb5H+mvwBYgcvrQu+zPcdFOI2npFSJC7V1h++b8T1OXa
         7PPUcgwXDqqMFrF2naCpHR0uHO7amdk+yNDTjDLHTu6S5lsDwpz5dFxg/ghcVUQ1wAUc
         vlEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755628864; x=1756233664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxA8r6gICCYCTtmqt0g1TsD+OxRWGjOL0XWuu12ws+0=;
        b=oWCw0rzF3aAjLcX17q6A/gA4P0kDBuNZKyGsYPEzxfn8IphGemx3ytSCgmfbfFbsiD
         CJo2RFP5OZVwokyWL6IVswAtLTq/WQIqVw4uixpBK3xCnK91YvMTAaMV/UeVG/UENlLT
         CpegsvBlIqQcmirORL3eIfLC06ph3VLpjlGf0p4laNQtdCchsXGrDP3PWUnH4yGkO8Le
         5roR969L2PFvATCy+HHBKEiJKOGXIDle/JYndyLkoKfFOCewhJYodwWT/L96BOwkaWhk
         TKqpuohKFq3kC7DqTb1FD86SGhC3UpTgiyuIopaJjNdV8spjr+WQMp/x2bXTGn7cWpfm
         aLNQ==
X-Gm-Message-State: AOJu0YwIw6Qxes4tBMs7iGCm8TmJWZRANKPUS7P2jCqmGZ1FKmfNcXjP
	8tBGbdfuFw7Mz8taORbTROYNM83HVvGM3MWy3GnSZZh5+QY5HTN4RFKGKmVkh+aQsKDoR8UHFQT
	jxh758WQLflrBivPW117vDxQ3ZoLvvTPvaqAJLqYB
X-Gm-Gg: ASbGnctt5C7M/W8eCzeYAAGozJMDovUz0V5SCmnJjJ9CmqNRl9UWLsqR60yXCkfY/2W
	KY0dklstncIMITnVj6wu7beWiggN1w2ocEtYEKkY5dVvOPK0JvEMWMLJojSfvmdqKsD7e39vvHH
	vq3oFg4N7Ney+0YaV6l9Xr6n8zc/CpD+gTS/HetTIm++1GxgJd3Ysqf2Lrz9dpZ/zIAILbPDqWN
	ccuUTAkw8eOJE3U2g==
X-Google-Smtp-Source: AGHT+IGDF8x8XEUQ3Vh7YwBSb0dBdB7J+oY3SecooHs7eRSM+kdsUUtwvJPYWr15d0XEfLOWM95fsdf/TD2BJtOBss4=
X-Received: by 2002:a05:6a21:328b:b0:240:1a3a:d7bc with SMTP id
 adf61e73a8af0-2431b7e84fdmr475390637.3.1755628863867; Tue, 19 Aug 2025
 11:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhRGMmhxbajwQNfGFy+ZFF1uN=UEBjqQZQ4UBy7yds3eVQ@mail.gmail.com>
 <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
In-Reply-To: <2e303958-ca60-4458-ac6d-6b83f331f660@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Aug 2025 14:40:52 -0400
X-Gm-Features: Ac12FXxZgeluVuqZS6ryRgI2NbH5NDlrWjuMdFfxKc0UiPQ_AAWyDeG46s5bB9U
Message-ID: <CAHC9VhQ5Vs+_DYAcN_Z4M9PVqW=PjaHcr4sVXADU5yqp1zFHVQ@mail.gmail.com>
Subject: Re: LSM namespacing API
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	John Johansen <john.johansen@canonical.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 19, 2025 at 1:11=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> The advantage of a clone flag is that the operation is atomic with
> the other namespace flag based behaviors. Having a two step process
>
>         clone(); lsm_set_self_attr(); - or -
>         lsm_set_self_attr(); clone();
>
> is going to lead to cases where neither order really works correctly.

I was envisioning something that works similarly to LSM_ATTR_EXEC
where the unshare isn't immediate, but rather happens at a future
event.  With LSM_ATTR_EXEC it happens at the next exec*(), with
LSM_ATTR_UNSHARE I imagine it would happen at the next clone*().

--=20
paul-moore.com
