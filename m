Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 561A8202997
	for <linux-security-module@vger.kernel.org>; Tue, 13 May 2025 23:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747178002; cv=none; b=B5xQU6OdtGVktm0DRb6vi1B2jaNqTewLfwzvIGvO7s/LbNBuZZ3UyxijtBKp1uUy9fSX0BkNYErbQTkIDWp6zZT5GrE+xoeN40nLHDj+R/NzHYD0lPjBdhB09h7u9i2yi5PiY7Dg1pisJKdI80gEI9Q8QPl+twPC0QGLT+HTxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747178002; c=relaxed/simple;
	bh=mkNoC9Ryjx5ogPibaruvHLv5BB0SKVa9LeUZetHB668=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OtJ0qErvN9NekbtZxNhC4vAQ1blV/QjfOZ5n0OaWgBC92xmoMtBfsu4U02seoRAX9Fk/mKttNAB2miVQ99mhw/BkFPnZ9ioSPhwFHAEtCTdnU2B+xfD9ajtPvB7yfr0gpABa+OGSC2c19txCjexDAWLyuPMhOGBmpGomo4HgfAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=dZ2Q8r41; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="dZ2Q8r41"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7081165a238so49095487b3.1
        for <linux-security-module@vger.kernel.org>; Tue, 13 May 2025 16:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747177998; x=1747782798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiQbN1KcgTdXz0K2nzgAi4Zdc8zBRkZfmeECcgv3ydc=;
        b=dZ2Q8r41/H/WVPFxRkTvgt116JPUMWrXkKLKUm+HTy3Jc4ALAfb4M1xby7fRHPiFRu
         0o++vToPt831qri85tV9CTMBZ4kVl/GUn8gj2lgwp3/enONWMsJZemHCMwi7ywYbP4On
         g3006Ln7sZLiLe+acUSk3H+UkV0WfiqLH/KJTAHPT4GYvCYbhcCHIgbEJ6P7FVlyOI+C
         mO/yVV3Of6Zzh1KJVouhYMkoQ+iJZ3Drt5swuHKTlhBKuLoc+cfjaI+QXY7DXyFrrSJS
         DmNwBbW29pvpFxdajyc0a5sTSov05eciea0vMwARymoZOiWU+9otaF29R88sTJ3+o4wx
         g9BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747177998; x=1747782798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiQbN1KcgTdXz0K2nzgAi4Zdc8zBRkZfmeECcgv3ydc=;
        b=w/wojfW8e41hflb7aGg/PyMQvDWUrIzW8WmZbAa8Jcy2LMNz87/sPVZhlwTP4jR66X
         SRP5LrcklHAbkqDFrryyd86JD7eu1JDZRS8ET4yOVOP97FLpXAOIuIQ3sHvr3STeOtSi
         BSjnf8OLxbtyJOWUkH03Q9pli7tNJiBjpOjqcfocIDxbQPQvchKACBzHlxMdzrGUia4A
         qrM5h368Xa6o3D28CaSop1QDf81wMdw8UbNcD7RJ7pBstOoWu5W1zk77tM2rqN5fagaT
         kmVr+Ko+Q6TZxUBtA1Mi13ZxEnlFKNFjQSA8ZKmP4BURA8DkKk0h23kvTWe+D1C6kOKl
         5rtA==
X-Gm-Message-State: AOJu0YxOZrROED3KlrRYCl1RubOaY5kigT9BnMhZ0Edi19W4LNFjgHov
	6oicH/7XGo7v562mfxUWuQxrTV/xHxMZK56EF/bIMEk2mXvD5d8/p/pPmNtDXIBfa4usxeLv/a0
	JPRBM+l72Io4NDo4KpA6EYp1FS7gvPIi6AiLppX+t2bdaY7jTCA==
X-Gm-Gg: ASbGncsM+TEPN2BjRVFj/CuVEaVpbO+IZlMtG375dVJT+DD6hQpW1SEg4kE3EVmhYgf
	cbA4JO+GGS4bLf/BuS6LPn4OkoHZnNCj2JR1w0RYdvPxo3mMXWHrOweJHC9+2j7kKxMaRFzQPdS
	OV7nzeGS1nSMU5odu3JsJIXuTlFIt0vpXF
X-Google-Smtp-Source: AGHT+IGLKVOpD4gMWPsE80wgsYXtnIT3oZdD49clxQKHdbkqN8XwpQ6PDL6R86iNciW5PD8VH5cUkNh1g8L2GtOCwBU=
X-Received: by 2002:a05:690c:6a09:b0:709:1bf8:f7a6 with SMTP id
 00721157ae682-70c7f2221cbmr21351427b3.28.1747177998122; Tue, 13 May 2025
 16:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508140438.648533-2-alexjlzheng@tencent.com>
 <20250509032326.GJ2023217@ZenIV> <20250509043757.GL2023217@ZenIV>
In-Reply-To: <20250509043757.GL2023217@ZenIV>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 May 2025 19:13:07 -0400
X-Gm-Features: AX0GCFttm-rmrczbIyF2qWJ3ynZfRM2SOJV9UI_yLmpmO36LFSjrxOCcAum3iQY
Message-ID: <CAHC9VhR7-R20Q7A8RGCAMvBxNyUXOcj-dHAcMi-GAyVsxQZ7aQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] securityfs: don't pin dentries twice, once is enough...
To: linux-security-module@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, alexjlzheng@gmail.com, jmorris@namei.org, 
	serge@hallyn.com, greg@kroah.com, chrisw@osdl.org, 
	linux-kernel@vger.kernel.org, Jinliang Zheng <alexjlzheng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 9, 2025 at 12:38=E2=80=AFAM Al Viro <viro@zeniv.linux.org.uk> w=
rote:
>
> From 5c463d47c814e16adb6e997a05ca5625df41152d Mon Sep 17 00:00:00 2001
> From: Al Viro <viro@zeniv.linux.org.uk>
> Date: Thu, 8 May 2025 23:38:01 -0400
> Subject: [PATCH 1/8] securityfs: don't pin dentries twice, once is enough=
...
>
> incidentally, securityfs_recursive_remove() is broken without that -
> it leaks dentries, since simple_recursive_removal() does not expect
> anything of that sort.  It could be worked around by dput() in
> remove_one() callback, but it's easier to just drop that double-get
> stuff.
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---
>  security/inode.c | 2 --
>  1 file changed, 2 deletions(-)

Replying with a lore link to the associated discussion and warning so
we have some record of it in the LSM patchwork.

https://lore.kernel.org/linux-security-module/20250509044613.GT2023217@ZenI=
V/

--=20
paul-moore.com
