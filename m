Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABA1D551
	for <linux-security-module@vger.kernel.org>; Sun, 17 Mar 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710703268; cv=none; b=uViCj/U2CKfDYixq6zvaThi/5dqKmHR7eHCP/DCsjh+8o6Cah4YpfCSwHngVbTD1Wpsqt6/AORIJrm6x+cnMD1rO58s8RXPj7fUgHkxneT7vIRoQcXT5gUh+DtZgnoh1k6ofg/HP9WzcWZ0eWaVZROFjfI2XLISO8fRwx61uSRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710703268; c=relaxed/simple;
	bh=pvNZUotQThd7AEclgQlsjocr8sc3DWqZyCZZBZInnYQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q2OMxAiIVb4ro/t2ZZOEyWN7rYnIXpM9F8wQdi6zuvTcyIgwXrv+5FF4592rzj0wQzEtAZRHtb74sBmP6Q5qV+bn8/8N5ONXYx62A80zhwNpaqsUkpCziEGS4+GLWu4D5OzfuntClsFBcQe1vqLRcXY19w5OC/qv1J+o34FxDM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SAfXbhLR; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SAfXbhLR"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dc745927098so3115145276.3
        for <linux-security-module@vger.kernel.org>; Sun, 17 Mar 2024 12:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710703264; x=1711308064; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F7htIJOT32OYQLLsf66q0tnFZvU1LOUU0DSCAkhOx9A=;
        b=SAfXbhLR1q03WqHzS5mCF3J4edfER9j9v0pKy3ZFmXFfrOWt4EEYlOdz1pwp4orA+m
         vTzC8sYlhVZiNZZQ0GC9BhUDrmoywX4sTHJpn+4AUQzKNy+qQstCHYZYoA1GH0V8rftR
         diRMDpRziY0dospgxQXzoFqxghs/a4//5sO9qtFnEoiX7ce1w7tmkdRuKtDjg0n7MyDI
         JEDyRjzDG/uBu626VDvueuEfVuUf399mGvOgkge5j+Ig9SyY4FKo1uzFol3AUqC2FVoX
         7BPESPLjc6rJhkckUXuGF5z9qK+dLTCIvNxTnnwpaTRojd21POSrd8+BisjHueyTaVnf
         2GwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710703264; x=1711308064;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F7htIJOT32OYQLLsf66q0tnFZvU1LOUU0DSCAkhOx9A=;
        b=g16gxDE5oLbsav+OOagygWlpskdZ8pbYIx5/1XIT5qXu3Gsn9lYB1s4H3VU8a/3OhZ
         GPksGYBTC1zjsgxVPQD+1VhzEczbRWZxthC7pW0aXmDZFbirBoegkyHIjSMkmgTI4Jqx
         9NpHexrOP7xoIYOOPmuR09KuUwAYOsLqE3Lfn4WGYLTipS1BQPk8MKzrDqiNSEUTiWZu
         QNds+5bzpU6Yo0kvA6JjKPK1z6KhV5v9E8vayPjR34CFYw1L+XwHmgYBSOa6kfcZsyg7
         3zN4ovtQAV5uo2B067CSSCYrM+M+uFaq7TlMNRmtahmCvNq3wYs0P5C16tCXi8yxJUa8
         eaWw==
X-Gm-Message-State: AOJu0YxRQoHqlVp8l+uWnKG93oKVnyVMTSx+K0IGEFzD7qw+W/n2U/78
	LLrfKrNYHtYzOY4cCjsNu+vS5i/NTugcEBqdppAai+zZ94hC/eBuOnJhyirF8E8LLgdXpGBQFgM
	a21giVVhS5cPE7SFsGd9CCocrxFpCmimK3gHLN5W1ir4bf1U=
X-Google-Smtp-Source: AGHT+IFgPv5hp9lsca2YSHaRsZggaWrjJrUxcPF4x7aRpDmxZOGQ0aiiVfDQh5Es1n7fBXnWJIFTIfmYdvXiHitThQs=
X-Received: by 2002:a5b:944:0:b0:dce:1285:e9a5 with SMTP id
 x4-20020a5b0944000000b00dce1285e9a5mr5576358ybq.11.1710703264574; Sun, 17 Mar
 2024 12:21:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240316104714.GA22794@wind.enjellic.com>
In-Reply-To: <20240316104714.GA22794@wind.enjellic.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sun, 17 Mar 2024 15:20:53 -0400
Message-ID: <CAHC9VhQC4YvE5LyG76sOsCihBxdrMS8ekLuuOCAAPcLwuwjYdw@mail.gmail.com>
Subject: Re: TSEM code organization.
To: "Dr. Greg" <greg@enjellic.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 16, 2024 at 6:47=E2=80=AFAM Dr. Greg <greg@enjellic.com> wrote:
>
> Good morning Paul, I hope your weekend is going well or your week is
> starting well, whenever this e-mail finds you.
>
> We've been waiting for the release of 6.8 for the V3 release of TSEM.
> TSEM seems to be co-habitating with it reasonably well, modulo some
> atomic structure magazine refill issues we are sorting out that appear
> to be caused by workqueue scheduling latency differences between this
> kernel and older kernels, so we are getting ready to push the V3
> release.
>
> Casey has previously raised an issue with the fact that we used a
> single include file, tsem.h, for all of the entities that are global
> to the various compilation units.  We placed that file first in the
> patch series so that it could be referenced for review as the
> individual compilation units were added ...

Considering that there are still a number of concerns around the
design of TSEM I wouldn't worry too much about the smaller, easier to
change implementation details, like header file organization at this
point in time.  If you've got something that is functional, that
should be sufficient.  We still need to sort out if the basic design
and TSEM concepts are acceptable upstream.

--=20
paul-moore.com
