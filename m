Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21BC9231CA4
	for <linux-security-module@vger.kernel.org>; Fri,  4 Oct 2024 21:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728075824; cv=none; b=ttopSHKX2wBjwOA3rdUfrt2QrfugjRMWFd3XPq4rqOobQWGr480qwjZBTM46nZbUjPXD+Y4+NJ2gxAfWu0aswiGihylT9XbkY5rjx0lhyHiPPOQZHT+vuy1ngWOIBGsXmx6IIL6vopg3afomQhrxhecD8P0hblw1xtVyxHfWpT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728075824; c=relaxed/simple;
	bh=LUtF8OMZD6OhjTztSKVwiIymqMIIcBngOldnt8i1bzM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DwNtgvgSLr1kp8zJcDeDWxn6WOsa+8HbskbMC5xutlpLSlkpHiVvxvnJUitorBP0s13hd1xughtjtTXHuIlM5mQzHToVigGzVZLwGO44lQJPnCNfG04e6R/H8IlHF9gZ/z6UL1ZgCNs7mHCCpKDN22IxDVxNi8rtgbDwqv+CXpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=YqWHMmDL; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="YqWHMmDL"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6dbb24ee2ebso27448947b3.1
        for <linux-security-module@vger.kernel.org>; Fri, 04 Oct 2024 14:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1728075822; x=1728680622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LUtF8OMZD6OhjTztSKVwiIymqMIIcBngOldnt8i1bzM=;
        b=YqWHMmDL74EsBXaLAb9B8BPOP+9y/hO23il3KViASGyy9Mvy2I3gUPU32Fw6gphp0G
         gGT7a22Do2NavsGDpj0Y7wnD3jJucm5x2tB38vxH6eJuoi5UI54KdMGjX587mH/Gb5ok
         0T75YX0FzEJPxZGyCZnZB8cXQKHLjDf+jjEqNYI4JrdRT+Nolt76waJL3u2qnjDPTrBF
         JoeMnL8xxjxviR9TgHToiKr2FcAIGwmg+ja1Ev+spV7CN4UF/g5nJWzBjNy/5moyPOCs
         CghJvQigL4vD8VmgeSJeMlhrUBs4PnaFblF+37fjwa19xPRD33Ayd19dcflrCCN0UWvt
         ax2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728075822; x=1728680622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LUtF8OMZD6OhjTztSKVwiIymqMIIcBngOldnt8i1bzM=;
        b=Fn2J3eMlZaxzKgb3kQBrLTI/uS+jVw8WIcRhFsdjPdwcLyBRUE9oJlJqCOkz22EhR8
         J7bkfBQSpNAJ961VivhaVz6IL8IBHYddiDhooWDPikFcOCnLN45h5F1rh0l3+Jy3CmPZ
         IzPMZeTI4yW3rNh9wbRRcYHPFfALXZDOHlOh6DooVb7mPjp68v4VWyOdmJtYe/vLoEn7
         buFmo6wjfNl5BlAtVO3+Cy4+QRmeOTqO1orXfAnOGhlDKVmU6kaVQB6UN5s9KNQP+Mfj
         Bb9R06pEn5+RtdfqfrorlF63kaRha8RmmYIlK1qLU5b620HhYL+xWy23wwLnO/c5kqJ/
         G64Q==
X-Forwarded-Encrypted: i=1; AJvYcCW1Vj8WsdudcGkiV6jXSYILRmOpQ+bFL1pehqucuypeFWqHtppxXa09HQN9Is+OufZB03/gjiLH2V9BByYy5Kl0TNW3W0w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5TQJ8qegY8/PXpK/uJs6tDpwGBMZ9ImzJ2xro9jrPk/R/WS9M
	oVQDsNb6ngW9Gwjc5CprFtIFUX/dbQklqaJyZfVE6mKq3S4ObHERWVMnxrRNr3lp5/zIojW+d3Z
	A69FavXXBw9Gre/nPlDG8h+ygKHC1npj1eeWy
X-Google-Smtp-Source: AGHT+IGAr6opPG1Q4+oZSiu/GkMgXb2Y7rEkBWMwEnmKdYjyk+LS0K7/NwFoc1q4RRubDX2GI9V7Emnt08ErrdvnMJ4=
X-Received: by 2002:a05:690c:3010:b0:6db:d7c9:c97b with SMTP id
 00721157ae682-6e2c72b2c50mr32676227b3.40.1728075822062; Fri, 04 Oct 2024
 14:03:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHC9VhR=QjdoHG3wJgHFJkKYBg7vkQH2MpffgVzQ0tAByo_wRg@mail.gmail.com>
 <202410041305.544EA7E4E@keescook>
In-Reply-To: <202410041305.544EA7E4E@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 4 Oct 2024 17:03:31 -0400
Message-ID: <CAHC9VhRPHrzVNAp-krAt5RFA8_nN8hPyW3of7i2fhY9ioESogA@mail.gmail.com>
Subject: Re: TOMOYO's pull request for v6.12
To: Kees Cook <kees@kernel.org>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Fan Wu <wufan@linux.microsoft.com>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Mimi Zohar <zohar@linux.ibm.com>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, KP Singh <kpsingh@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 4, 2024 at 4:54=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> On Wed, Oct 02, 2024 at 04:12:50PM -0400, Paul Moore wrote:
> > As I wrote in my original response to this pull request, this is not
> > something I would accept in a new LSM submission and thus I feel
> > compelled to speak out against this change and submit a revert to
> > Linus.
>
> The patch should be reverted regardless of the LSM specifics ...

Just in case people haven't seen this already:

https://lore.kernel.org/linux-security-module/a68d32deab61b1c4b1be66e5346ef=
547@paul-moore.com

--=20
paul-moore.com
