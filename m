Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0B2DC33D
	for <linux-security-module@vger.kernel.org>; Mon,  8 Sep 2025 21:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757365964; cv=none; b=U8asCWoYn120UmAOV1o8r5V393jJlyTx6q1G+E+zBjIOdR8C3z4ITrYYd8GO97JZFqOTh8/DCpL7ouAJ/uwmPaR8aC7Q9mrupm1nHVKzht1ru8FOVda+Dxq7UnR+3uQqgexOCFjOimo+RazZdYz6cuFHDH5uxVUQYfpeqRHMC1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757365964; c=relaxed/simple;
	bh=XRTx+EIPYf2U/8kH1WHhk+Pr+1repADusuxwe8OzR40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nYOP3Vx3/uAxEaWgJICw6E3gUWg6NL1znVrHVvLH7pAXPhFJYEGV8jA8SPqB3ak2zRcTk/wKNBnbEJLy1HUxbmvC2sjSILdcE1Wv7GoT++R2aEL1QL4N8Eroct+ZCZsFJk5Z1NsfIm3MB+RzrqdNXohlghyGahZzY3jZR6dAmyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NwwlXF+2; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NwwlXF+2"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32b60a9aa4cso3105565a91.0
        for <linux-security-module@vger.kernel.org>; Mon, 08 Sep 2025 14:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1757365961; x=1757970761; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2NQT+Mk3p4TSCxt7pK5wFXpw9ktcr0hQ9tdUnoEinw=;
        b=NwwlXF+2GLZv9OEZPONFZAH0prn35DQcA8xpLQXPmRs5wk7t16OIVhF34SSXAmHze4
         EhbUUQ/o+G2Kx+jyo6TPwl0WusU4pdkuz1NmPIENKUvkQSKbNpXY2IwlAi90i1dmngWF
         j0E18L4XRmjZEtPYOIH+CowhukKP4lZs4aDtGKYf4jzbqYVafBWWZKuAmiSDWkePnO6+
         uxd3tFSuh4wd7AHyeIKwMYM84tcbmy5MXMvrnQYsliXXTMG6F2CdDZpAz3/Ce7EwAJVo
         O+xJvIRQhL05GSaTMHsq60jR8H/5m73DxDbNJwLS3DbsRgPdCXH2ljE7fbU8bEDDHuJF
         vF8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757365961; x=1757970761;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2NQT+Mk3p4TSCxt7pK5wFXpw9ktcr0hQ9tdUnoEinw=;
        b=e+8anWkYOJWNfJc36JDaqMRXMp9FX9O5pR4XSt6LT+CTxydxtO2AfiAjjhCMDKSbSB
         kaOZqLZa0iZTol7qZ/qt1U9DM6v/U/6spTeGkWAfNYd9gcOyXP1b30hXWK9ojDDeBqL+
         6qQrkAca1JzHo9rgJSyieXtPchlWmeHQcWBKZoDDTEsdL2ZpzZdvBbEjCNrjJDZLL+gW
         +NaSOiRFSe1Zn3n463hpkGgpHOMiZi6VGYEYTO6TTrfqaGprK/Ug9MauAPD1PwriwO8l
         xqTTV2LfuNouNW9+B1gee8UEPRsLWNfBdmgpHaDni8JvAIagxIjG8oQyLYN2ZGUghypZ
         oTTQ==
X-Gm-Message-State: AOJu0Yxm6ajut+yMY2/j1qKz8WO3j5TO9u/LTgDN9xseXwUlPBkjDjwa
	bvwvUBSDClqVB6qj9scuQN82RmxINVdbAeH3TRGoEuqcfc+JOS1q1Ze6p7PZGFFyX0Fx6ecajz+
	vxigUsGAne8LJ6Rybrbn5lo3IC9hV40lTLVsQlD6P
X-Gm-Gg: ASbGncvsQMkd4UM54nVnTzuYUOvkLEHwrOFQjNG5Nw7PqkDG+v+do+DIod2FIfxpRMX
	qLq0a/dmsDB3bMOuCj3oxmI8TidVYcRK1F+QAe7W3vxx/0xbhm9S+pZIkneSQNl9Wb8vuZ1isDW
	B2dvvw6gdwRzYxO6nqfyfK2ES8IlTYy9YDm4GvWFCXLzDBcC/+wUsYBd8XJtSv0SKIVjaIRszMY
	shjGlc=
X-Google-Smtp-Source: AGHT+IF+BzdxpdKA4HQ7DSSEF6ppz8VTpKBNm20HIVjqV21Axz9rUCShq8QssdNHtSFg2qc+MCxuDjz1Saanyjzg7Ds=
X-Received: by 2002:a17:90b:1e51:b0:32b:d089:5c14 with SMTP id
 98e67ed59e1d1-32d440c5edfmr12330752a91.35.1757365961252; Mon, 08 Sep 2025
 14:12:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814225159.275901-36-paul@paul-moore.com> <20250814225159.275901-65-paul@paul-moore.com>
 <e1ed0bc4-136b-4e46-b030-1159411d6240@canonical.com>
In-Reply-To: <e1ed0bc4-136b-4e46-b030-1159411d6240@canonical.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 8 Sep 2025 17:12:29 -0400
X-Gm-Features: Ac12FXzddwEYAqNyhtf5sw2V7Z4CigwREJqUTu6_Er36SjqbkuSUTppS-HqFowg
Message-ID: <CAHC9VhSmwuwvTWc+QSbQq3my=D6YuV5bUu3120_XXH+_6ei_cg@mail.gmail.com>
Subject: Re: [PATCH v3 29/34] apparmor: move initcalls to the LSM framework
To: John Johansen <john.johansen@canonical.com>
Cc: linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Fan Wu <wufan@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Kees Cook <kees@kernel.org>, Micah Morton <mortonm@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Nicolas Bouchinet <nicolas.bouchinet@oss.cyber.gouv.fr>, Xiu Jianfeng <xiujianfeng@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 8, 2025 at 3:12=E2=80=AFAM John Johansen
<john.johansen@canonical.com> wrote:
> On 8/14/25 15:50, Paul Moore wrote:
> > Reviewed-by: Kees Cook <kees@kernel.org>
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
>
> Sorry this took so long.
> So the patch itself looks good, and can have my
> Acked-by: John Johansen <john.johansen@canonical.com>

No worries, thanks.

> with that said I have done 3 different builds with this series. Tweaking =
the base,
> and the config, and I haven't been able to successfully booted any of the=
m. I am
> not sure what I am missing yet. I working on a bisect, but its just a sid=
e project
> atm.
>
> Until I can get a successful boot, and test. I am going to refrain from f=
inishing
> out the review.

It obviously built, booted, and worked for me, but as I mentioned in
the other mail to Mimi, that was some weeks ago so it's possible that
there is an issue with this patchset and one of the latest tagged
-rc's from Linus.  Once the IMA/EVM patch is sorted out, which I
expect to happen in a day or two, I'll go ahead and do another post of
the patchset (complete with the usual testing beforehand) and when I
do I'll make a full tree available in the cover letter for people to
review/test/etc. in a known working context.

--=20
paul-moore.com
