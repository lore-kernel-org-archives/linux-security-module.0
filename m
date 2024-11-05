Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E047216215
	for <linux-security-module@vger.kernel.org>; Tue,  5 Nov 2024 21:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842156; cv=none; b=JuaFM2OpVx1JtjNgnn4m4dhQrxEF/u4kpAtahbfmyp70FuzvBZ+jeKUY/ScoDWzQtwNzDne/qQ2WEr+PAq5K1BFmJ2yxHuwOGFiTolS60/ATnJxBUjM55gp40Pg7zJOsMJoq2ceqrq+CESyfp8E4oOnCaq09YvKZAsbF9I5pr/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842156; c=relaxed/simple;
	bh=oyupIWVCNbG6nZyet7ZY97/axFE8juePohjXg4awVWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xtbi5zPg8gSGpTyacdNL2rbhU85VE2NwrkqMahFS+93bd54IHMRCHYypqDpq5YAsXL7Kf3fdhPMaGdxFygOimqK4rOlprgOfRQ4gzL2XhwUokwj8BMITmuEe7oQEHOaUocNkq+lTgXDSj5pRBkQN6KEwy+03oJ8FWGNAjIdw8Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Mw2FgVlS; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Mw2FgVlS"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e330f2e9fc0so4177421276.2
        for <linux-security-module@vger.kernel.org>; Tue, 05 Nov 2024 13:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1730842153; x=1731446953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNuaPCY23vejYYQ3mN0NTRsMOB1o3Eo9eQ3O6OLcmbQ=;
        b=Mw2FgVlS8KnLi4gDC1siHvYPylCaeOuKGT2xS75uc8LFx+uKNMt6995Iz8dhD9FBS8
         Prwl/mL+CaDu/yMs6DZjiAPuNWA/w0wF3jq7EVyFWeCbDh4TjP+AAbTcn5co82L1KaVQ
         B4swLle7LGfhxgzM3GQdU+qj+3tor9smkqi+SxoY9h+bLtsk2DSydw9uWLX0UMEv6w/l
         cOPwYNxmx3HHXg7hwehpdjegkHicVvp4BjCnQGpeyUTCtYJYThRqJEFd1r705Tq3SzO6
         rGrtm/4GbN1LVgCZ7j7JHxEVBRENtBs7yoZeTOkdQChRs3ksREV6543RNSKeNChcSz/J
         HR/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842153; x=1731446953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XNuaPCY23vejYYQ3mN0NTRsMOB1o3Eo9eQ3O6OLcmbQ=;
        b=OpefaVb3FFc6eX+eobp+muxWCq8U4oHy+uo8VDHX8lvVxu5hLw4HAOR0Iv0/HfBTcC
         Y70r2TM0M+5qCo4QTO99x1Ndkf65KWyxWtD7dfUn3lGpcbq9R+OX5jcCCoQdrluO006V
         gFk50R5R2CGW8Z7g4aVb5IfZfVt2cIyfs0lMFfZlBhhlUFXZzqab3Da4w4NUVFrtv3Sb
         TGvu3cwrbkFFGL2fZd78ln1F6GCEaqU746qzM+F4Zkwr1uMX1b3h0vsPl5upv+fUW/FZ
         mTaTHKAZYZf9kGZgJW92p3P2AWAIpBSiHG/MYIbNYK1E2K4gbS2EhLoivqvdDBmftXPg
         0ADg==
X-Forwarded-Encrypted: i=1; AJvYcCUfCEJ2jHFFYssSrJNB+R8nZWLaW6o6qRmgheZ5gX5TWNpX7fl+Ab3a/awvFlpItnuzsbw4ebLLR0XZWf4yW9WfU+v1834=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpqeWo65yrNaJAvrCPSkGIodPN4OWqFMOq+obAHoHcyvvMIeS/
	+UBaJ/ZXMArJBrlvb/f03A209OxBW8CmLHhTwo65pyP/DwYTp/dimUF5FLM7a/vNRbFHn3Ctr1M
	uwpqb4QjV+kPhdWk+aS7hxqa8VqFbCt95P5V6SiPQqSlc7WI=
X-Google-Smtp-Source: AGHT+IFo7jb8lP2Z+4a/T0GbVpP69I/MQLR+mNGDVCTSIG/20sXx7EyA6QZTbj3IONBRPsZqaGCUpeGIlJp6qhw8TJw=
X-Received: by 2002:a05:6902:1541:b0:e33:1061:fbf8 with SMTP id
 3f1490d57ef6-e331061fe92mr15357527276.41.1730842153479; Tue, 05 Nov 2024
 13:29:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <549fd50d-a631-4103-bfe2-e842de387163@stanley.mountain>
 <Zyn9oJ9oxltqbK0x@calendula> <06e25ad3-bb68-416c-8f19-5bdedf38029e@schaufler-ca.com>
In-Reply-To: <06e25ad3-bb68-416c-8f19-5bdedf38029e@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 5 Nov 2024 16:29:02 -0500
Message-ID: <CAHC9VhRdk2qgsc4OGn6zkqXYraRgE_Bz8zLKGRmXCm0fjaJj0Q@mail.gmail.com>
Subject: Re: [bug report] lsm: replace context+len with lsm_context
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	netfilter-devel@vger.kernel.org, 
	LSM List <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 5, 2024 at 3:09=E2=80=AFPM Casey Schaufler <casey@schaufler-ca.=
com> wrote:
> On 11/5/2024 3:12 AM, Pablo Neira Ayuso wrote:
> > Hi,
> >
> > There is another issue in this recent series, see below.
> >
> > This needs another follow up.
>
> Dan Carpenter sent a patch:
>
> https://lore.kernel.org/lkml/b226a01a-2545-4b67-9cc6-59cfa0ffabbc@schaufl=
er-ca.com/

... and I've been slacking so far this week.  I'm reviewing and
merging these fixes now.

--=20
paul-moore.com
