Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52B814A623
	for <linux-security-module@vger.kernel.org>; Thu, 13 Jun 2024 18:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718303012; cv=none; b=AguDXhwq8Md1gvPsdc1Q9W19XnWyI0gOjAwpKsrwt4lTImm0ngjkjdF76ndgQKPOEdalVEI/QIyQNQBtZrVv17Hjohi1gaEjxl9DK7DL+FEuOOOQ7bNHmLh8a7GN5sYHvGXkqAfHmyTLPn/FmHF8p5tbSlBOX36yrDN0gHvtsQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718303012; c=relaxed/simple;
	bh=krCnTrtnkHB1D6bVOwKkRyMFqhSVLnQUJePCdLAPTDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ti4uT2uo+/WnEaFqmarCb/aU7T4NRAVD5CaBY8oeEcH2I9X4pAkCs8N/240N+29/ai30v0nUeVS+QK3hCwcaRxJFvYPhm9Gzfh5R1BzPWeLb0QB4UYSX4seQXdGuFtqqNFTcafEDTHmleAcRenGAKQsfHJ6DnquZ0DHALSzvwsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=MrMqolDU; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="MrMqolDU"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dff0067a263so1545104276.0
        for <linux-security-module@vger.kernel.org>; Thu, 13 Jun 2024 11:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1718303010; x=1718907810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G7FnJEUeHYST8KdquXXOOwJt3IXf3k8psfyOLW+siSs=;
        b=MrMqolDUAlzO/IwTF/IGKX2UT5qyxUTNn9DCi10W5dPT07/AkjTeQUapfuL+zOuWnG
         dBS7kyFdbOpfHtC0oZqGrrymabTVe1iQnNtN7Ftsfw+kZX9ZLIYUWNYyZDhjYzw149uG
         sal4RQFSAfd+AnOShUxqyWj5VOrVCw6Rt3XMvjk05zUOu0SEbUkwvdckXx5VLwfAFgZ9
         B2bzl48OgAetQRpB/iQsTY2vMnLj4xpYx1sip/7brXX0H1J5jzJHppAAal0yOFz4wnSJ
         oigpWpaJGgc0fyEuSLg+2WjG4f5uq5AdVdb+YX2bUgOZWRHpnWQr/DmhRT90KqgEQfbb
         AXzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718303010; x=1718907810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G7FnJEUeHYST8KdquXXOOwJt3IXf3k8psfyOLW+siSs=;
        b=SVposSLklbBXUCpxQjSRVwlcFcOZnndDAiLkgtF1xO9lQYOB0WP/8G1B3AtJBvoLLD
         rRXhZheWUxuhXiizTqe210OKwjT5VYH28UxD3P6Q1E/cw2jpbgb6W0GT6y8XRuLxTECK
         a/+92zKaPKLTyZqjBTvDDxF81r1YO/SzXg2IRTiqGu477/ap/cpqhMWskyGybb7VBbNp
         2TwPR5ELVAxldtbTII6ap5L/Ux4y3ss1vfO+ThrlAtZKNCsDd4BaD0FTiRqBTZd4cilR
         fmdSDnucjF38LcvPcLvAnnKRFS0vYlHdMBAea7R5QFL7vudmQ/wAGZ9eWjIuH+L/yNOU
         l7JQ==
X-Forwarded-Encrypted: i=1; AJvYcCXBIgmFCZerGcugg1FJPhicC0HTS+qgjVvaWak9miK0psT8ZtSWvEdToGmGeFx1Nt8S7O5FTmeLDZKnN+Lt0tO2Bp2P1arxhPRyFLFNRT0kaZE1fYcP
X-Gm-Message-State: AOJu0Yx2s2TImF9jp0dHDYW3/lyZP3aCcRgp2XkWvVbcthC0lBcELbpv
	1l64+1hJBxPBQ0w16QoLStkbXI3QYAn0ZASpbofSlOt6HGlTC1v0Bf60kLptNROBCy7EczvkNDj
	Wkdza2Xnd4cUEjqeWwL329MBWKSLbwUA5J+h5
X-Google-Smtp-Source: AGHT+IE4Ltjey1yaGfz53sQ/9WLShdZ82+JIBb7XxCn7Eqt0EFUMoYYVjqNU2UFmX1J77aFxmDQczyuNhRm+3bZd5xw=
X-Received: by 2002:a25:dbcb:0:b0:dfa:584e:c661 with SMTP id
 3f1490d57ef6-dff153c3883mr320940276.34.1718303009863; Thu, 13 Jun 2024
 11:23:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYvWXuWyd3NiX3WwRyorRiDRbxGmRW_7aVnBVKUVA_TaGg@mail.gmail.com>
 <CAHC9VhSeNGo4fPY0H5eM_fFsPSQ18xWUYMvyHBChEysXk-+00Q@mail.gmail.com>
In-Reply-To: <CAHC9VhSeNGo4fPY0H5eM_fFsPSQ18xWUYMvyHBChEysXk-+00Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 13 Jun 2024 14:23:19 -0400
Message-ID: <CAHC9VhRg3efo2J5VsxxskFW0ntotwswvLmn7cWEMmSTkEC4QFg@mail.gmail.com>
Subject: Re: security: ima_policy.c:427:17: error: too many arguments to
 function 'ima_filter_rule_init'
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, lkft-triage@lists.linaro.org, 
	Linux Regressions <regressions@lists.linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, John Johansen <john.johansen@canonical.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 13, 2024 at 1:36=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
> On Thu, Jun 13, 2024 at 8:43=E2=80=AFAM Naresh Kamboju
> <naresh.kamboju@linaro.org> wrote:
> >
> > The arm and arm64 kselftests builds started failing on Linux next-20240=
613 tag.
> > Please find the build log and related links below.
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> Thank you, the same error was reported by the kernel test robot
> overnight.  I'm going to look at it today, I suspect it is a conflict
> between the LSM and IMA/EVM branches.  FWIW, I compiled and booted a
> kernel using the LSM changes yesterday without problem.

Nevermind, it turns out the patch is bad :( ... more on the LSM list shortl=
y.

> > Build error:
> > --------
> > security/integrity/ima/ima_policy.c: In function 'ima_lsm_copy_rule':
> > security/integrity/ima/ima_policy.c:427:17: error: too many arguments
> > to function 'ima_filter_rule_init'
> >   427 |                 ima_filter_rule_init(nentry->lsm[i].type, Audit=
_equal,
> >       |                 ^~~~~~~~~~~~~~~~~~~~

--=20
paul-moore.com
