Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A0813956C
	for <linux-security-module@vger.kernel.org>; Wed,  1 May 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714588975; cv=none; b=Y71mktuY8UJGuenAZUqarheKIvubyap55iJq/1PHv5QXf64tBekQi3XnVWMtOPqc4TR1s01APGWffx0KqQTs001MYN0gG18aRjDGmU166+tQZQr+XZ8siB13YQJ5wGEz1e5vISzAuODvnaFmK4vEK/J6YqecZm68TwpdilczGUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714588975; c=relaxed/simple;
	bh=KZG3Z33WSOUuGsuKITl/3R8e2eOWTgDeq6YC1+Q1hqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=oh32Q+FUonmYhhJlsWz/CKbDBITGgsmEAP35pqCvhl0D6Z2de0Zp1sGGZYjtuIzp1ezXPZpJjVRR/5Jg4PT8yOVtXoyoV6BpjkX1Z6+ZLZWxfdL/NoV7U5u2TGZFyn/JznHxui8EbDvSD2kUvtzM+FkOksUp0laE64NZchd6wyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RE/mticr; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RE/mticr"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-61be4b986aaso33724567b3.3
        for <linux-security-module@vger.kernel.org>; Wed, 01 May 2024 11:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1714588972; x=1715193772; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SRWc9mBkBVHXX1gOsllivvFKRbbQ7hgbx9ndGkIfkaU=;
        b=RE/mticrkm07q91hTs4S5NEkjajmw7JojXyeUIrLGSFG3I53hHpa90JIYt6LDfJYs9
         Ki8no1zgVCxlg/SxiXuWQwy9lMuEO+E+eEtWqtRFJsi9OI79ybijTCtZLRFWFTtMa0fH
         cTgmeKE1h4z/zkubX2LMqFoZuk1NSNWcCyNQwvYqqloMKSMhb83/tFl/xoMaZNFx18UE
         7tcrulIJ+i6Ivgd6Qd59sS4qCeDsW1/strYAZzPHJba1jjyG8/oQYaAhf5STZZvPeg86
         DMeKkWaHBNU/AJBZYGe2Weofmm8cHA7lY/a1UvomAZgnbYPu8MS2+AS67x4IzTGQ5PTm
         Qhpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714588972; x=1715193772;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SRWc9mBkBVHXX1gOsllivvFKRbbQ7hgbx9ndGkIfkaU=;
        b=wFFkSoP0QQ1GQ2upM9CyW8pqfLFQeCAZ5xllhu2GM3GwlvcUuyQJyNBtTdkjIjXCFr
         iGSmc8Up6mohMZNl9Z01FHfu3GQVd/2T1vcoIPBCFycxsyklonWwO2N0u1+hmc/CxYuF
         6rv3s+23pBwydhZ03djf7tH+Q099rL5q7SzeI8qYmv/BRqL7MtVw+tdJLvwedXyCr12u
         rC6gKO9X/ekJ1y0s/CYQhysdIV8t7VcrO9MCURcHcCzkpzGylg83FTQgU6zAXf5EkRt2
         alyUOR6UiboHt6ulSVq2drXXpkRdlJZDHPEyomYv8RjaGtBeIOCVLlMwAGoTVJS1rpvz
         WwYQ==
X-Gm-Message-State: AOJu0YzQeTcmK6p6uzchQ6klK/56xOREIeGajBHk6Q+mQoZ3DIiG506P
	84y4b5hInF3TbO6Dk5V1DRZIWicmyWabyn69kxPOBW/Yt+eil6hmqMb/1haBtsvvNGv7nasgFtL
	hiqwD39wwB9j090S5xniJeOUXJfAi+JnNiOk9RmLWBL/2gIM=
X-Google-Smtp-Source: AGHT+IFfdB4+Vq/K6P85KYhEd/pBAREPFQuRlW2X/7aSEVP+DcdTXhp90FUQaOScUh4znt8oxcLRpjelkSuUxibX0vc=
X-Received: by 2002:a05:690c:112:b0:609:efe8:2bfc with SMTP id
 bd18-20020a05690c011200b00609efe82bfcmr3619453ywb.27.1714588972608; Wed, 01
 May 2024 11:42:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240501160725.12027-2-paul@paul-moore.com> <CAHC9VhSvU_B+nQBBWC556=uvLUGUHTu9nXFzZiE4jxJvfd6Vow@mail.gmail.com>
In-Reply-To: <CAHC9VhSvU_B+nQBBWC556=uvLUGUHTu9nXFzZiE4jxJvfd6Vow@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 1 May 2024 14:42:41 -0400
Message-ID: <CAHC9VhSMuKCNMZ-a=ZwMi1_Ki6fzE=QmD2MUp2jbTqJVAr_k0A@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: update the LSM file list
To: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 1, 2024 at 1:57=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
> On Wed, May 1, 2024 at 12:07=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> >
> > The LSM entry was missing a number of files under include/.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  MAINTAINERS | 3 +++
> >  1 file changed, 3 insertions(+)
>
> Merged into lsm/dev.

... and of course I forgot include/security.h :/  I'm updating the
commit in lsm/dev.

--=20
paul-moore.com
