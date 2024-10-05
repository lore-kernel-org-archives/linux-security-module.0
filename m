Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4175D44C86
	for <linux-security-module@vger.kernel.org>; Sat,  5 Oct 2024 16:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728145830; cv=none; b=Ku0hXVTSdDUdeyPnTJWqiTFllcupyodErshx1WgKAJoDJG86KNiGThjVtZ9Gr1fyGAVTG7smZSzCRm7t5+OAfRzqKzggYZduKDBecNBJ2tRgASl7r36WfzOk9jFVbozFeYGIjZPloitPxWjrw2ghKMIcFiQhYyBzdZN7lo+HFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728145830; c=relaxed/simple;
	bh=o4OffiSTl9+0f0OW8v547b9eRFcU8JOEANAzTXDf5qo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NQJCdLPr8hiNfqfwiHrTQTOE+b4Mb5dbtMvZ69wE/BjLr4UpBZeZftdd8wGybbNDGf4OURt2wR70ZH3YZhnjIClBdUb9oKmoVxbL9B/jxDagw9dUIeeATLN1Zk242ECsmpF4CWtVMu8gO39G6xTUB/2SI207ci9LPch8MgiuUdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=M4ngg/C6; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="M4ngg/C6"
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6d6891012d5so26122707b3.2
        for <linux-security-module@vger.kernel.org>; Sat, 05 Oct 2024 09:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728145828; x=1728750628; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YxQdQdR/TB0B+vp8jyNlg9Ic21SGf9aq80k1atY1OUI=;
        b=M4ngg/C6/ZQ0gUWh5kEKyrwKEWPvQRGGy7ojX2gLnSE75FErQBRDU1K6QpBGnMZ3yw
         nJrXl+I3FuSwEto33IRyehoWd+ycyIb60a1GzO9o2ZSoSeKyIbXX84nBrD1tW4ElHpgf
         No1Iq6TiVkQYenOUUt0EiiYTo6K72DKg+9HceXhzTBj8CGRcJIgvKFhAzgstsnSQ6IDw
         REM708YaayUyvqRPnMWzJB3k6pA7eqnwhpVBuTMHVA9QE8FkIueKeO00CzIl6nUQkLJg
         Wll/WaaCFcZS9nxvdDizuKInk+CmEAOewZixZj8b+6YVBJaqZ9Dt60Ir01njQngvdD/c
         IyDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728145828; x=1728750628;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YxQdQdR/TB0B+vp8jyNlg9Ic21SGf9aq80k1atY1OUI=;
        b=BrRWQTOcq2iZdNmh4o8rJtNZTdS+MQERIWvQEa4yiLv9M2v4Ae+wWplWv0bkiKGzq5
         j0wFuWt/LXwKzaVgP1lVjP/MxcFNjlNxxNIdrEvQdD98OljZFuNUaVC8xrw7bolLfEQl
         FeWycoKqwNtShq3Ltriwi0NeA4Q/RYULtvVVQSlgHos7gP7Cj2t1GPWrhFv24IO44pWA
         nLmLojhtI+Hw4ju0zioSAq8cEjip0eSMDbIW3qskVBbXz7TOovGVnbQBRSzWGaQxnsPs
         1sON5l3/rIFPqRadYcOb/Bl1Go6g32wq6L1HO/exRi9qe5WGy6ZWeWohIglhjtzYJXa8
         uAVQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD1zJZCjtqrbbYl+z8Zxgz2sQCNMU75S7cQqr0+sihL2Cnefx5Uq7v0mwfI3WZSotef9De3Wq21CTMbm/PF8Hv3p0Q790=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF6/w+Ucjaa+PG2tzd8SmKPS3939bVN+WyXK30YIg66embtY0m
	AhBbru/t2ZhCZNlSdVEQLXoj945Tg9ON3Z2nIOEdbRsqXYKAzpSD4CzQ9i+9p+W4rP/ObNr24Lz
	myMaTjagNURl6OXLV+prN8bmsw3TpJOaskQJY
X-Google-Smtp-Source: AGHT+IGb+nRIePO0MRQUiiqOoIJ13dgcGU+CYdLsbC3hwIMqXf4ccwxsy/DtXVzVKvHA2A7jExFWgjZrTetoPU/JTe0=
X-Received: by 2002:a05:690c:660f:b0:6dd:d119:58dd with SMTP id
 00721157ae682-6e2c7017952mr63084187b3.16.1728145828261; Sat, 05 Oct 2024
 09:30:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook> <ece0c7bd-0d28-4562-8760-c54b0077583a@I-love.SAKURA.ne.jp>
 <202410041645.27A48DA@keescook> <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
In-Reply-To: <5b09909b-fe43-4a9c-b9a7-2e1122b2cdb6@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 5 Oct 2024 12:30:17 -0400
Message-ID: <CAHC9VhQLONjomYjs6pK2tibVfOaPY+TbDA2CYQ1YEGX7ENVkYw@mail.gmail.com>
Subject: Re: TOMOYO's pull request for v6.12
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Kees Cook <kees@kernel.org>, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 5, 2024 at 3:11=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> I think that this pull request succeeded in revealing what LSM community =
thinks.
> Each developer is thinking different things. One thinks "anyone can rebui=
ld kernels
> with whatever changes", but that opinion ignored secure boot / module sig=
ning part.

As I believe that I'm the developer quoted above, let me say that my
comment did not ignore UEFI SB.  The Machine Owner Key (MOK) concept
provided by shims/bootloaders is designed just for this use case.
More advanced users can even replace the UEFI SB key databases, on
hardware that supports it, with their own to permit loading of their
self-built kernels without the need for the MOK; this is arguably one
of the most "secure" UEFI SB configurations.

I've successfully used MOK on my own systems to support my own kernel
builds, and I've successfully replaced the UEFI SB key databases in
VMs to use UEFI SB and my own kernel builds without MOK.

--=20
paul-moore.com
