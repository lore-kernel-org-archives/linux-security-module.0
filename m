Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D20714CACF
	for <linux-security-module@vger.kernel.org>; Fri, 23 Feb 2024 20:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721292; cv=none; b=T38H2QJZThRPZmSTXoFqmqu5ewV6h+vpWpJpW8gkecOwSzI101+7YeUAvA0mbJclwA0Ih+VNnEccW0d3UAiI53vCHYQvDKObAbs9x1JoOdoJz2JMtyOYWMMZ53UZ5eyX+9DJWvYQ3TwpZ7JYSm6XcqA9GXpasgStrcxFT267gKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721292; c=relaxed/simple;
	bh=XrIweBt1xAeTI+DcqMD36fsii+srzNHP7jHLCDfCPsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZMZ3CLHs/3KHmg2TQfflplqN5mZbl25v3T3RE54XBCW3uxATMVxjYrDlz8nt/sd8XH8hjUJURc+jTMn5IJjHH0KyQVMon4eO7K8Au/kJlGDihuCkKsUG4Rlu0DWj1twKldNhy0qsctq7VIWivNphHHZ4a/rA9UhSl6p9zi/QMkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bLBv3fYJ; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bLBv3fYJ"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6087396e405so6789857b3.0
        for <linux-security-module@vger.kernel.org>; Fri, 23 Feb 2024 12:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708721290; x=1709326090; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrIweBt1xAeTI+DcqMD36fsii+srzNHP7jHLCDfCPsk=;
        b=bLBv3fYJELOZ6nfGWoobO0anvO1jTjRBdTd2oTf/gIyOGKQst9Uq42SlO1Wu5izh8w
         5EazRfsfXx9H0Owe+vMv4NEDOMfS5SLY8Qik6ulvw4UyoYqGsJbnBcrzXVfH6ixuSAk3
         bhdbjzSt6P7jDIvPggMXzq9RFeD2i1ROAOmcZhTU0YZM8AqD80EO8M99nUzDdUsqJd1e
         RIAFE9CBKWelkK+Y9m+O19AOaqzdYzVyd0o+/u5aFKwnOpSCERJddy/pmhfLO0B8214t
         mEs2lyznZZZxzNf6CZq5X1XZzK1USZCCcVtQaJ7LRc0xS/RNAbn8KC0o5PXKStetuwR7
         Xf/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708721290; x=1709326090;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrIweBt1xAeTI+DcqMD36fsii+srzNHP7jHLCDfCPsk=;
        b=G+uwjylUNrj9OBAi3RfCFIgsR5iNYMbzw1qgs3Y6hRvIw80KvtKLq1mPVz9FDsExiw
         3pbJy8/wm2/RwOmr/Rygie43NRpVc+UQpKF7/1atpJd/4PaGqkIyfBouEV9Iq0fZXiiq
         lkOAUAQHgCUNKnEsadiS1KeI02Uqk+LKSZjCEkkEroDXWnVv55arGIoVwXSQsL88O0VG
         kuUw84Faxelbq6GQb3FiEFo4R5Qc/X7Eki2uO6xpN8hfCsOxruiYjPx0QaeisyFM3txI
         XZ7bAZQSyFNr0rIEXGRpQ0KBphcmw1JHq2sOLxh0s1n2C6QT24stU+r0hpO3juhL9cZ+
         YcEw==
X-Forwarded-Encrypted: i=1; AJvYcCXkd3hkIS3MpHxAlu63pMBKQBGEI28pH2srosBo2Kfyq2ht7RzlyHufiKK/j3AJ0UL4/Wrb80oYwTOw+1Pi3BSp0nyGwyz04VAYjQBS0D6V7s6etrRa
X-Gm-Message-State: AOJu0YwHomn1g21Mnqbc6lRjYNZ1NxItL77Azl8O7dsYa5JG/piOevKe
	3ux2hnCxCVolYBuxHLYyOnWodF/pLLXD/GcNbzkdzePfQl5ENXLNICZLkKGa2erVokOYw1Bq37c
	ifH4hv220ImYU3QkmI3+znN7/9Ofo8Khgc5xeyfx9idaGTvU=
X-Google-Smtp-Source: AGHT+IGupIAFw7nMLiV1//RpofK99g5hxlJIZq7LOh30Kty2WViyFfQDmsNjq2ePE9NcWOZZ8IBp5gns5fSynhBzG9c=
X-Received: by 2002:a25:6642:0:b0:dc2:4fff:75ee with SMTP id
 z2-20020a256642000000b00dc24fff75eemr837275ybm.3.1708721290133; Fri, 23 Feb
 2024 12:48:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223.iph9eew7pooX@digikod.net>
In-Reply-To: <20240223.iph9eew7pooX@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 15:47:59 -0500
Message-ID: <CAHC9VhRpE2rFya6t4p=sUUbpUzDw1cYWQq=UX4cYJQwNkNnvfQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] SELinux: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:17=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> These bugs have been found with syzkaller. I just sent a PR to add
> support for the new LSM syscalls:
> https://github.com/google/syzkaller/pull/4524

Thanks :)

--=20
paul-moore.com
