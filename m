Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C58943603D2
	for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776075502; cv=pass; b=IETgtQGn7nBnXMMgZRv3dSlZPRro3CoYWrStPPQynsxiiC+NT/A4tA8KL9WGAaCj/2yYF3dPBoQUnLkoeY66KKQCKBvnZvzyjoOtSKv2pPmjMkmUe8pg+WKoMQu09qydY6BpucoKHpMP4U4pSq0FROHjummdcerQH7HM17ak5X8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776075502; c=relaxed/simple;
	bh=pgS+c4UZJZAwc+Rzym6q2DvKdC8hB6ekETvokSu/ZJM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S42uikDGidpa4v9fNYC0F5bVxECu4mQEIhLOYYTEr2oSgoOTKWQNBOBOfWT5nlKICjzhIlTAGCElAHA+1hMlyZ/S8GA05P6XadRrIrzakuAx98fZI8SyWhRPd/h2UsZBk+hQAjL9OdUt26uG2+aCIiWFTHTD9DnT5Ba10yShGeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=VdwkJXgb; arc=pass smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="VdwkJXgb"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8a48deebe95so35597726d6.0
        for <linux-security-module@vger.kernel.org>; Mon, 13 Apr 2026 03:18:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776075500; cv=none;
        d=google.com; s=arc-20240605;
        b=AdbAZPluOXhCEOrkVl5fM2UnKZqmmcFxx2v3cJEnVlCElnHqvy8yUA3bF65hxVq6fO
         6FDNlkozTHEmk6dIpIJOKFibNtrb9eG17PDijExA5js/4wOtBC/PG9R7p/W8ZvbKkrmc
         MvuAL40U9j72ByA6mV8gjq0sjcyhEZY3F0rI5U7cDOrSYgarE9jX8HPkFPj9YKhSkGj8
         2RGmy/Rtd7sMKlfkTKpz2rBshS2l18Ow/UG1UiuTktl5tu6koeqjZ/g6am6bpICDIQe/
         FhZEbrqTFJmUaiL/inbHbBRAdOTAa8L5EyYt3yCZj2H1VFMOWKH3BqFshkhwQwMdUnkg
         fLoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ebakUwqGP3PYO+B5bX1Qe8QRB6fgaSIxDegK7FnlU2w=;
        fh=5G7qKX6JnYq4J3tfuJn61mDa9yBGnSID7S1DI1qibrQ=;
        b=S615FL034MFDIXn/x5lRn+5etIsMOGlPkRIbQL+xTDkTsZbn655xvgyBH+FtA43Rem
         DlfK6ML6CIem/tUuLKhaCHTSVx7NHwrDk5rlBKTBhyU+f1a+MjlTmkJzlWWf2V+6OLTy
         rUQNHlzOwo9k57aIHcheanOKmvzJP+n9fQORMFVEPCHLUPWsEFUfzGgAlm0jvkb6+Asj
         xgUOu+LNJJsRN6/PPfCNTzBSET+YlMsQ1pIulKYBBXVFNJVHNdWUwIZhklrTof5ZqSNe
         qIJcM7t7sSaAzw5DB9S2HOxvBhmW8P07TXeCtIqQSZmLXpYTLP7ZsldFSs+CfxUW/clq
         LArw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1776075500; x=1776680300; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebakUwqGP3PYO+B5bX1Qe8QRB6fgaSIxDegK7FnlU2w=;
        b=VdwkJXgbNxXdG90DwYdxAFlVUBoZAqYeZCVrc9OZknvUG2YtWCBEcfpAAzsmaRJtWt
         1XaMUg2BaRlfJfNKd6NEFdSTahO2QWLBW9p/WsyJ77ssd8RsZJ7dMO/rat0OteXAfzV7
         jdJAHxK5hk/DoF7ISP9TfoTpFfcwu3lg5RB1g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776075500; x=1776680300;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ebakUwqGP3PYO+B5bX1Qe8QRB6fgaSIxDegK7FnlU2w=;
        b=Y1sh10gFgHnsT2NJrTMtFvg6/Iz7aOaMiD+x53zyPvmTFGsaMXX8gLiRe4U/7mPtRl
         pbiXxBFp8PwQ9k/1tL+toPNlaP4nFcETVRnD8B5iRShGfEm2zuG5YpnJfvr0kZEAGirW
         f0QCEDv8Po885IzYVYMCXG1Wa2rojIqiMmLlvsQ0aWSpkVvxnILE3nHWcGo3hDaokMJA
         GKPnu0/dQ5BEu5Mla4zdK2XRDtAivSBejU9jD711WLmEtbG6doszL0E+W/0fTRtNhui5
         UqBUbV1fxQ10K88MeZ3k2tevK9DhvFCC2nLwenMlwXAbjov7Va5rTwemYqniHJQt7NZK
         ViDw==
X-Forwarded-Encrypted: i=1; AFNElJ+DINuSjBzS8dquQLLpBR+eMkufgwLxMU0V3QrUTwEZu5PB1npvJVF762Mucy1LKdLoHR0/rjz2AR15awkZKJmyQbY+zdU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgXW0pBW9GcYaYdVt87mwZTKofiIL3UHihIDyJy8yyAiyEq6dl
	Lx7gxSlmlEDopwjTt1xZeDV9a3Mhm0aDMrhRnD2ccJ6iX17JdmU47jQrOSScCHFPx9N38qPdm05
	CZEfnVJz0B3MasuCklbNIy8rGj834dEAR19EIIqoPvQ==
X-Gm-Gg: AeBDiesjcGEE+Oz6nM9Cr8WjwJ0Xkm9caMX0l0ESxIVwXzqGBYA4aOcrhdY2PwdcYwy
	U+HvZ7m2n7c4Wsnt5L0Nq4AuQa60uS9fTV7uO9l7Bx4ZWf7GkcJDWaL/gXy2jhnJMDxUwuXGuvG
	VE7ZFYD5FPkZjK4UonoUT0Lu+9lzbsHyZWmnhotEL1lBzb1qhvHEKPiLv0U35W+kiq6crY40Q+v
	2b70k/51Q7xFJoF4YoMlLKiTOZuAeL93MVPVy0s2I9WiitTy49taoExhkNxCi69gAdtqUizxh9p
	e+3F8MMAYOiN0yIwW/AXk2HKbsiG+AyZem/3
X-Received: by 2002:a05:6214:6112:b0:89c:ba96:5fd7 with SMTP id
 6a1803df08f44-8ac862fd7d9mr166846566d6.53.1776075499587; Mon, 13 Apr 2026
 03:18:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adUBCQXrt7kmgqJT@google.com> <06337e89-349a-4334-a735-b8dc9b566cdd@hallyn.com>
 <20260409-entbrennen-turnschuh-54af9b45610e@brauner> <adoIGHwgMJSuRfE5@google.com>
In-Reply-To: <adoIGHwgMJSuRfE5@google.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Mon, 13 Apr 2026 12:18:08 +0200
X-Gm-Features: AQROBzDjo_3YYqKB8cYM9p_-avFzNPL-7bhMkw6XSxShMEB5rkuEMgg0hzBXOjs
Message-ID: <CAJfpegv6GDFZjdGrQ=0Jahvz5mSgfJr+GvjVwws=SFX-yirpSg@mail.gmail.com>
Subject: Re: LSM: Whiteout chardev creation sidesteps mknod hook
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Christian Brauner <brauner@kernel.org>, Serge Hallyn <serge@hallyn.com>, 
	Amir Goldstein <amir73il@gmail.com>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Paul Moore <paul@paul-moore.com>, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 11 Apr 2026 at 10:36, G=C3=BCnther Noack <gnoack@google.com> wrote:

> I also don't currently see how an attacker would abuse this, but I still =
see
> this as a violation of Landlock's security model if we can create a polic=
y that
> denies the creation of character device directory entries, and then we st=
ill
> have a way to make them appear there where we previously had a different =
file.

Look: a whiteout is a whiteout, NOT a character device.  Don't let the
fact that it's represented by "c 0 0" fool you, this is a completely
different beast.  See commit a3c751a50fe6 ("vfs: allow unprivileged
whiteout creation").

Does this beast need special handling by LSMs?  I have no idea, but
treating them the same as char devs sounds like a bad idea.

Thanks,
Miklos
