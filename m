Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721930CDAA
	for <linux-security-module@vger.kernel.org>; Thu,  4 Sep 2025 15:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756998794; cv=none; b=fLiMV9F3pQaklT8MUoN2oXWiY8KKvo8ikUz0JJ+cx1WkJ0+wrr6Cel0FpD7Dk8NPa36BuRaf5sdl2tbk49azgC0lOitrK05jAJzdyb2ymgiUtpQnc/x8O9AdtIZX+Vl3zbq5FanOWYuMTbP7tO40WuZPLmrO+CrcjGeUtxklmmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756998794; c=relaxed/simple;
	bh=hQTesLUjwHoE69NvEeQegylR6nw/aEJIYz4xhLEq3pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ez3Nc0cnYvyTiyl2bokm/WgBx7ouWSNnkzOuLRCPGfFKE/3Yxw/AiGINyZpJFp25FAfMgsz6VoVj4NVMdirT8+VhOUgDg4/47u5Lo57LODumAlPhrfuUaLks1rO0y1+vumJHWSXh4ud7gohXwk2uIENNHO0AQfKpa61XUp5JQN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BpvHdX66; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BpvHdX66"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-32b02d88d80so1043440a91.0
        for <linux-security-module@vger.kernel.org>; Thu, 04 Sep 2025 08:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1756998793; x=1757603593; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zWu8/uT79TLkFHaoOripy/trgu/RnF6WTT4bI5QB+j8=;
        b=BpvHdX66LvkycmwydTOg/y7ECD+YX4EjnHp/f0PRlCAltaGzCodAfm2TX9c77LiJF4
         9j1wYGKxoj8xxT7IcVcZ6XGcKxpbmjZn1YywAh935G3WjDNKCpG20ojRzELorZ5DhL8a
         oUx96WIDS8oeYFGOgBNtlcsjEnC0Q5MSA/BgLFGw5JrxNXNAjnnj/A2JakkfO9tzZUvB
         05eF2WwEHp7fRyNwbkk2UOW80WuV6BszewWr8MwKEq8jO05eDlAuoKmXxO/0X2wMCEYv
         dV2Fohl7aIPCTcPplo0VBdMn0SKMU5uT1D4IAYKQBYgahXlYY79f/+XgSBi4/1moUbc3
         Is5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756998793; x=1757603593;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zWu8/uT79TLkFHaoOripy/trgu/RnF6WTT4bI5QB+j8=;
        b=byOg/7f/KVwyzXNpUnu+kuNzKhZbWL2FOZaZhb981f1nwDZRG6bXTz+Ze8JBRp6FWA
         tl1XrIWSTw2324sslI+7Uz2OnvEHVuJrNvMWiwP1raCXTvO+oOIoUNnoingYCGVMkBss
         woPLa8OYC0V/Ag8gohi7itzYcHiEjMaOtuz19FxaGHmifCVNDWDFXtwT3oQifsGaswoB
         lRIiLL4tqZmYnuXNeNAtMYEHVVcCFRqJKAnvD5XjDjMoMC5+IrAn6RNmZYqaHlTdsY0F
         BKjT+vD5VOWjNw0dHuv99hq74wMl11L+Iit8C6Kza78dGTPuIF0aGoGEjszTaWyRKJG+
         5zcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUd8neD4+yW4xqTBPZSX7BVxExwJ8swhI/PtaX6Qdmi3HZnBUVWIp7xgUx/LHti7esZC9FjqNZzKJ7zIye6SWdednqWs0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpF8LW/sGbwZ/WB7nIe5kxh2BwHQ5cYM4oqnBgNw+EdOuMhYh
	UQhyzVB3v5RajUlexk0n48wLNpPHwBvq7UlrOxm4VwvzTLY+nqbk8Nc9WhmmGOkw72CxtHQjoB1
	Ykx7rPEK4O09m9Zb1YtieZkhAIYyVsefbc1RsJKDN
X-Gm-Gg: ASbGncsIR15jhhJzEj7kKb2Z0yvTtFBtq5O0QgPhOuK3Yo6j0dQozeeEInTcN5RM/Av
	FA9JSclAXWHjp7Yt5XgtvXOZaZjywJ1UPlcB4k5AcUoJN5RYebMImqyG7EqzA7kqrcZ5I2EyhjK
	kx147LNogwPOP4cHoYUl21n4y+pnqjdJ0zECnc69iL6U+F3dkipsnctfVWT3+OpIiB+FTUyaUD2
	6i60v2UBqr+Pf8BLQ==
X-Google-Smtp-Source: AGHT+IGqcMqHHAT75zSTTPlBqCVyFcn6AnTIKyagfTnT5D4zUa/iS7NyI7Sait1maUMEoXcJ2nw24OBTrZDWN8ZihOE=
X-Received: by 2002:a17:90b:2ec7:b0:327:e59d:2cc2 with SMTP id
 98e67ed59e1d1-32815436083mr27618387a91.10.1756998792394; Thu, 04 Sep 2025
 08:13:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68b93e3c.a00a0220.eb3d.0000.GAE@google.com> <68b9ab18.050a0220.192772.0008.GAE@google.com>
In-Reply-To: <68b9ab18.050a0220.192772.0008.GAE@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 4 Sep 2025 11:12:59 -0400
X-Gm-Features: Ac12FXzmdDvybcxdLMeRBs2OONbitrTJM6yCl57blUt8t099sFu8t2Ati4PBkBs
Message-ID: <CAHC9VhR6+cHx+FvonHtAvuNZ-Ls77HjGnU5k5VR7qy1BUSaxdA@mail.gmail.com>
Subject: Re: [syzbot] [kernel?] INFO: trying to register non-static key in
 skb_dequeue (4)
To: syzbot <syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com>
Cc: apparmor@lists.ubuntu.com, audit@vger.kernel.org, casey@schaufler-ca.com, 
	davem@davemloft.net, edumazet@google.com, eparis@redhat.com, 
	eric.dumazet@gmail.com, horms@kernel.org, jmorris@namei.org, 
	john.johansen@canonical.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, luto@kernel.org, 
	netdev@vger.kernel.org, omosnace@redhat.com, pabeni@redhat.com, 
	peterz@infradead.org, selinux@vger.kernel.org, serge@hallyn.com, 
	stephen.smalley.work@gmail.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 4, 2025 at 11:07=E2=80=AFAM syzbot
<syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com> wrote:
>
> syzbot has bisected this issue to:
>
> commit eb59d494eebd4c5414728a35cdea6a0ba78ff26e
> Author: Casey Schaufler <casey@schaufler-ca.com>
> Date:   Sat Aug 16 17:28:58 2025 +0000
>
>     audit: add record for multiple task security contexts
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D1199fe6258=
0000
> start commit:   5d50cf9f7cf2 Add linux-next specific files for 20250903
> git tree:       linux-next
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D1399fe6258=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1599fe6258000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D7d2429dff5531=
d80
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dbb185b018a51f8d=
91fd2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15b9a312580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16819e6258000=
0
>
> Reported-by: syzbot+bb185b018a51f8d91fd2@syzkaller.appspotmail.com
> Fixes: eb59d494eebd ("audit: add record for multiple task security contex=
ts")
>
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion

The timing on this is amusing, I got the sysbot report just as I
merged a fix for this provided by Eric Dumazet :)

https://lore.kernel.org/audit/20250904072537.2278210-1-edumazet@google.com

The commit has the appropriate syzbot tags so this should close out
automatically.

--=20
paul-moore.com
