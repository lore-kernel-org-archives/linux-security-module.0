Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408991991AA
	for <linux-security-module@vger.kernel.org>; Thu, 25 Jul 2024 12:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721909297; cv=none; b=TDmtzp/0e8PHUIRrjWkXtMu499YxfHZ4pybGU5xJeZS9yqS9Qj7928SMZzIKzwsDPFBLqg37QQr7Ll3FMdiH5znP7AADHN/IcBGfRp5GbxNNehdYH+c9PUe49Ug/51rpaeqiWQ/AR9IUH5JzyVXvUjFmhjxBbw5y0pVIZpwq9rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721909297; c=relaxed/simple;
	bh=ioduvqYVGgbgC6jMMeBNN6IfPN5LLvDKelGy+hAVfsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCdVxVc3aVMrFGUOO6rT1olE35BmnTs51YogX6YmupHW4ucM/4uFvFBiLHL2XegW08jbkWW1IfrAiMVCQ9LYGLTP+WV9Su9dGiB3J1Dn5Ks2EBKtsGMqrPauhWbWgRvmRkB96yzHBAAH5WsGve8t9WMYEmyXcndKEA3XChlMBZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VB5e54GP; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VB5e54GP"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6b5f46191b5so4257796d6.3
        for <linux-security-module@vger.kernel.org>; Thu, 25 Jul 2024 05:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721909295; x=1722514095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ioduvqYVGgbgC6jMMeBNN6IfPN5LLvDKelGy+hAVfsk=;
        b=VB5e54GPVo/Cb5w1WDDd4yUwmJlHm4R6GLdajt7HRYND6bPKXPeNH+LModsuowaMf9
         z35dWtRwX4eOI9xE0EprRdj2fsEdOzhi/6pVxEZQ8bxBC+vWKdr2aEKyfv2A4JHijP3a
         bHqAlg1wyL2pAmElAwZL25tAaQ0v65TpjfgrA2+1sPr8fBz88qVI/6kerMjhLRuu8ij+
         HDi1ewC+RT1So+KnMlabZzFJ/3WH5ozvGp8WHqnzlUDXwVbzxQ9JwhPFjik5RpP6pShi
         XlBLnxj9vJYRcT7SOeDVBDFNbiey8PSrZQxG2T/N7SrHB8hkyEYEdefhp22EjWl1Gdqi
         ZohQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721909295; x=1722514095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioduvqYVGgbgC6jMMeBNN6IfPN5LLvDKelGy+hAVfsk=;
        b=qqME3RqU0nJdeGpm/KOLs62LZB72lDQBEN0KcE489po6uGDTTgm+z1N1b7qgAIL0Y3
         T7gvZ8fMg5WNsu3Du/P5QgzJsZC4thnEFflEg9+92s95Wv65WIUZepsuVnwGtfC6ENMI
         N9L7WsI5vKmZdzrZU+gOUetMKyd0/8qqaEnIqHsGzvpYLofJu71rImPszeaZmXModlUh
         XFqQLvRGHf5R5OCFP2dgal+uQ1hYgEc3MCXzWbdEyk4bwhkC5phTCGhD2059O8AWTfFj
         eEBEiHden2lQOgM3ZwW2SaL1ya1HKNeCGp5/r6WPQ3pn/ttjjoH+J1NhBGZrEPc8PRWb
         J1UA==
X-Gm-Message-State: AOJu0YxEMAxwhmqBE1mtzqAii4DiW2ikJqTps50KAbq4u61ZA27XFIEy
	/aDVGWvTVVxECyogqW7Pr3NJivZbF2XWT6+temAwwgHMneI4YSMx4tZpzROS4I2HgP/6c+FxDiq
	m+uqPKdaidi/jmVP/BwB4npCap+0v7/ra
X-Google-Smtp-Source: AGHT+IE7yIGqe9TMm2QHoaCm6X/pAmFyDVS2EPhmJ8/HqP38hnDq6tc4yZjnHX6xILJLwmZwLHtjS8Ygeb5FzWm4eAA=
X-Received: by 2002:a05:6214:5193:b0:6b5:e099:4d69 with SMTP id
 6a1803df08f44-6bb3ca597bamr25040226d6.26.1721909295139; Thu, 25 Jul 2024
 05:08:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240725054216.18587-1-laoar.shao@gmail.com> <d4b034c5-4b22-47c1-afbb-8ea1852a5e83@I-love.SAKURA.ne.jp>
In-Reply-To: <d4b034c5-4b22-47c1-afbb-8ea1852a5e83@I-love.SAKURA.ne.jp>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Thu, 25 Jul 2024 20:07:38 +0800
Message-ID: <CALOAHbDs8Npu4kKwS32tAPyrGROw0j9JcM6Hhz=M+OXto88gOQ@mail.gmail.com>
Subject: Re: [PATCH] security/tomoyo: Prevent message flooding if no Tomoyo
 loader is present
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module@vger.kernel.org, takedakn@nttdata.co.jp
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 25, 2024 at 2:34=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Hello.
>
> On 2024/07/25 14:42, Yafang Shao wrote:
> > After upgrading our OS to Rocky Linux 9, we've noticed an abundance of
> > Tomoyo-related messages in the dmesg output, specifically indicating th=
at
> > Mandatory Access Control is not being activated due to the absence of
> > /sbin/tomoyo-init. These messages repeatedly appear as systemd periodic=
ally
> > checks for Tomoyo, but since the loader does not exist, it triggers the
> > messages, as follows,
>
> TOMOYO requires zero modification of userspace programs (including system=
d).
> That is, systemd is not checking for TOMOYO periodically. It is some othe=
r
> program that is executing /usr/lib/systemd/systemd (maybe as a container'=
s
> init program), and TOMOYO is checking for /sbin/tomoyo-init when
> /usr/lib/systemd/systemd is executed.
>
> > While disabling Tomoyo is a straightforward solution to prevent the mes=
sage
> > flooding, it's suboptimal as we're unsure if any system components rely=
 on
> > its functionality.
>
> No userspace programs rely on TOMOYO's functionality (except TOMOYO's man=
agement
> tools including /sbin/tomoyo-init ). It is safe to disable TOMOYO.

Thanks for your explanation. I will disable it.

--=20
Regards
Yafang
