Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D9217BD9
	for <linux-security-module@vger.kernel.org>; Wed, 15 Jan 2025 00:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736900296; cv=none; b=QNgL0074W7lhRRYIu/DZCRG4oidMZn9yZyXuPiMWp04OvpFjvMqmPBZbuVuRer4es8Ycg4wFQorNnRhk2wac6kl+yl++8eNx4wmEKv2IWk3YGJKRKUFz1rUWMW5429KWopf2MEGiYKPpPCn9sckkOa2JlTa699oOqST/AQHE4Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736900296; c=relaxed/simple;
	bh=Zp49rurA1Myl0pyaSxk9MhtQoSZ5WS+5uSafkdF+aKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jUyvEacctbATYCVhB49gnV0aZ++JvvGeZ3msN0+kZxgR0O2D7Gfi3IPJp312s+3v+mGi/aR6jYuHrrhfaJHn3rBDmmf0cdUYz53hXZYGrsxERdyqPRpQrltdISfk3YQufBBYz/y4h3VMBXLxMGqZRY2VjEHCeoJxB3/HLarxk+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Ytd0/5vt; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Ytd0/5vt"
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e46c6547266so9205704276.3
        for <linux-security-module@vger.kernel.org>; Tue, 14 Jan 2025 16:18:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736900294; x=1737505094; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zp49rurA1Myl0pyaSxk9MhtQoSZ5WS+5uSafkdF+aKI=;
        b=Ytd0/5vt5mbHsaA+1uehqTjn72JDz0D4KPYxpwRIK1lXSfDUrv4JepQt1rUn3Ppubx
         5x2pX1MHSrJ8817FJmBDcfBRCTfIt6tPGDTtfyWEJqSJvaFTnO4wJ9s7HiKGnjD4PRxg
         MJ4O2YdI20kDRQnXZGTf9JisB75gVe1Bl8oJ6zUQPui6t1odFJouRmIYG0OZVWlXd9r3
         f2c7xoSdrl/SArjItXBG0tq95SfgLfreQi1qKrUZb5krTQ4B3wDPRgPmxRAF3VUBgEQ+
         q3Hc2Q3jOQNbafNKmo/FB9Lo4Wk1b7ji9OMhebr6OFtf6uQUlhVwOkIMp2yb5U+B8xC2
         Dotw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736900294; x=1737505094;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zp49rurA1Myl0pyaSxk9MhtQoSZ5WS+5uSafkdF+aKI=;
        b=NRM/bNHkeOvdnCbyFE7xki6tDv13XUjFiY6yWt/LD8MH6udh/Rk9wIfynwAAwuTHXL
         7/b0s2eNpYpzF9sUmNBJxL+8aBrxQwW0/EAdXE6kK+O2mteyqVfpNyaYWDUuADEGSciQ
         kusWBT2t+lwEZx5EJ0lBSEaOxd2RTzqnimCAMUaDimuTcGLJ8oG8vMQNLiyKjFBDXbki
         M1lrLa5JU7ykIgHntB1iCyGh2mbf/PeO2QEPfLHU3C4GGyrRPmjD51ctfcH5+aLMNHhz
         lWf13tWTrJm8KbS5vlTEPX3p/l5eA4zWNKCNyFoUWzO/OXHWL018s++056cO1fF46EDw
         HcpA==
X-Forwarded-Encrypted: i=1; AJvYcCX7P0yk6diCJbjG2+r3oUe1JwZppHZTtX7Yo4KPT8geyQcor+mVnWD4VlyrQyZV++xuheey8Zy7NPFVa0FUAb2Osx8Yqms=@vger.kernel.org
X-Gm-Message-State: AOJu0YysCl8nODvGjVSoewJ+mEcTQtzbQDFUD917Ld0yBX7Cs0ARmKGo
	/NZvIX/WCJJ1dsNpf800gh9JsgFkLkGFPqa3VrQdfifGdzsiJwMtChUQAxqh1V/sRM5Il3xDdSV
	Fco8XNsBUW3Vo/H9Ghbf+wkBBkKQCVFj1+xFV
X-Gm-Gg: ASbGnctuzCN7PTv4ZpHmG1P5U/RC6amR7IDu+BjSEqAoi/GzUF5rAYnN6XyTKDS2EyB
	9mrAcFpSTTQHF+9um0/wUl11ZQooANSs88CiH
X-Google-Smtp-Source: AGHT+IHtJYSwXkwz+07V0jN+izWJEyDVHZCMBZLUC2IdNu3wLbY2abzMLGBC7XuWrOyXqA98/b43/EFQmm+YZfl72hQ=
X-Received: by 2002:a05:6902:1444:b0:e57:2e8f:b680 with SMTP id
 3f1490d57ef6-e572e8fb8d7mr13442994276.40.1736900294049; Tue, 14 Jan 2025
 16:18:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250111.22fc32ae0729@gnoack.org> <20250112072925.1774-1-tanyaagarwal25699@gmail.com>
 <20250113.a860b47a11c7@gnoack.org> <d1b05612412a1d4b858662f296b45279c2141aa8.camel@linux.ibm.com>
 <CAPdGtUw9Ee7weCmS2ZP-Hi5KwPw9-O1fGRrY_KLKQh-SWgEN5Q@mail.gmail.com>
In-Reply-To: <CAPdGtUw9Ee7weCmS2ZP-Hi5KwPw9-O1fGRrY_KLKQh-SWgEN5Q@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 14 Jan 2025 19:18:03 -0500
X-Gm-Features: AbW1kvaUpZnLTH-RTdyjzL8irQYqX_incLPjKbOpK4BgJaOp8exyZK1GGvI_Sl0
Message-ID: <CAHC9VhQ1X_6V3ReOQv1ob22My=fjYk-b4Cfm0wB1YS6fomJtYg@mail.gmail.com>
Subject: Re: [PATCH V2] security: fix typos and spelling errors
To: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	casey@schaufler-ca.com, takedakn@nttdata.co.jp, 
	penguin-kernel@i-love.sakura.ne.jp, john.johansen@canonical.com, 
	jmorris@namei.org, serge@hallyn.com, roberto.sassu@huawei.com, 
	dmitry.kasatkin@gmail.com, eric.snowberg@oracle.com, mic@digikod.net, 
	gnoack@google.com, stephen.smalley.work@gmail.com, omosnace@redhat.com, 
	linux-kernel@vger.kernel.org, apparmor@lists.ubuntu.com, 
	linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 14, 2025 at 11:13=E2=80=AFAM Tanya Agarwal
<tanyaagarwal25699@gmail.com> wrote:
>
> Hi All,
> Thanks for the review.
> Sure, I'll split patches of different security subsystems so, that
> they are easy for maintainers to merge.

Thanks!

--=20
paul-moore.com
