Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801341B282
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jan 2024 03:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="BLKAXCl/"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a28a6cef709so665964866b.1
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jan 2024 19:40:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1705030852; x=1705635652; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gm1uV8nauYydYh4R8L5vh4G6BKRZADuM0xKtlvDNSU8=;
        b=BLKAXCl/EkJ7r8T0o4KJBW2ORNo2Q0UMIniipZJ4hD0VR/zPd/NfnTsS5gbkGxnOm0
         AnmXBI+W2/1HA4tCrLPxTg4EF654zCUKQo5aPPUFqVKK+Fw2sl+oYssjX15MU3RDDD5F
         Idr0CeKbvCjn2KjUwTcIGaFt+N8quWWCoKajA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705030852; x=1705635652;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gm1uV8nauYydYh4R8L5vh4G6BKRZADuM0xKtlvDNSU8=;
        b=tB/XOAZWgugwwhN3aDllGvXTfoj05TJK0bgUBf6v4Xt9ezU8POctNYNu/1kHt/k7de
         1ULMGObHQ/c3BQ5cOKj8pkrDVLggeYT0JsZtA1fGwtUX5Mw45lpRQ4UwJoiMIOtMjCfF
         sd0xSsemLoiKR8BSjYb492fDj3C+ULwom0gmtdRvraKADs8zH2Ck3xHBQT5gyejiigNu
         cYmZhp8BZ38VY7/ZrkMvBnFH/RQ6pSxIL/+3x+0MT5jix2Z2sQ2VSro6ggAijpP4ixXq
         KAqW3CUy/ywHdirG3gE4E2tYWz3Lvg1zyf8sx2J6geUUGhQv79bjFYhpA4vQVJTBMIvr
         y8Aw==
X-Gm-Message-State: AOJu0YyoTYMM40Ca5pBQTNQpK4qHiHlVNHrDphzgVTyT2aKWKV51SBmp
	7dvRmcFnsRBXcF4QNinyhdU6MsNxmaJLNgPDbsgLugcuZLOi3/H4
X-Google-Smtp-Source: AGHT+IGbxyEMgl36jhe8xJHnIoBYqeCuAW4CJ30FsKhR6CWxEk7b1MGdLYIEW4oIr87yNKNWtaHJrA==
X-Received: by 2002:a17:906:3597:b0:a2a:769e:bfa2 with SMTP id o23-20020a170906359700b00a2a769ebfa2mr265274ejb.100.1705030852705;
        Thu, 11 Jan 2024 19:40:52 -0800 (PST)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id o26-20020a170906289a00b00a2bd8953af2sm1288330ejd.55.2024.01.11.19.40.49
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jan 2024 19:40:49 -0800 (PST)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a271a28aeb4so661183266b.2
        for <linux-security-module@vger.kernel.org>; Thu, 11 Jan 2024 19:40:49 -0800 (PST)
X-Received: by 2002:a17:907:a02:b0:a28:df9e:b2e1 with SMTP id
 bb2-20020a1709070a0200b00a28df9eb2e1mr358646ejc.54.1705030849339; Thu, 11 Jan
 2024 19:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net> <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
 <2f595f28-7fcd-4196-a0b1-6598781530b9@roeck-us.net> <CAHk-=wjh6Cypo8WC-McXgSzCaou3UXccxB+7PVeSuGR8AjCphg@mail.gmail.com>
 <77b38aa7-a8b1-4450-8c50-379f130dda16@roeck-us.net>
In-Reply-To: <77b38aa7-a8b1-4450-8c50-379f130dda16@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 11 Jan 2024 19:40:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgK81n4=pfKnhWfYxxtFBS_1UQDaeBGRRJ39qjVw-oyCQ@mail.gmail.com>
Message-ID: <CAHk-=wgK81n4=pfKnhWfYxxtFBS_1UQDaeBGRRJ39qjVw-oyCQ@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
To: Guenter Roeck <linux@roeck-us.net>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Miklos Szeredi <mszeredi@redhat.com>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-api@vger.kernel.org, linux-man@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>, 
	Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Thu, 11 Jan 2024 at 15:57, Guenter Roeck <linux@roeck-us.net> wrote:
>
> I wonder if something may be wrong with the definition and use of __m
> for u64 accesses. The code below also fixes the build problem.

Ok, that looks like the right workaround.

> But then I really don't know what
>
> struct __large_struct { unsigned long buf[100]; };
> #define __m(x) (*(struct __large_struct __user *)(x))

This is a historical pattern we've used because the gcc docs weren't
100% clear on what "m" does, and whether it might for example end up
loading the value from memory into a register, spilling it to the
stack, and then using the stack address...

Using the whole "tell the compiler it accesses a big structure" turns
the memory access into "BLKmode" (in gcc terms) and makes sure that
never happens.

NOTE! I'm not sure it ever did happen with gcc, but we have literally
seen clang do that "load from memory, spill to stack, and then use the
stack address for the asm". Crazy, I know. See

  https://lore.kernel.org/all/CAHk-=wgobnShg4c2yyMbk2p=U-wmnOmX_0=b3ZY_479Jjey2xw@mail.gmail.com/

where I point to clang doing basically exactly that with the "rm"
constraint for another case entirely. I consider it a clang bug, but
happily I've never seen the "load only to spill" in a case where the
"stupid code generation" turned into "actively buggy code generation".

If it ever does, we may need to turn the "m" into a "p" and a memory
clobber, which will generate horrendous code. Or we may just need to
tell clang developers that enough is enough, and that they actually
need to take the asm constraints more seriously.

                Linus
