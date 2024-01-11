Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7E38F
	for <linux-security-module@vger.kernel.org>; Thu, 11 Jan 2024 00:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="M/CaZ57Q"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a27cd5850d6so509682566b.1
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jan 2024 16:33:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1704933195; x=1705537995; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ecki/5hmhCZ1pJBgLNzGL9kIecS6fNHUeL7VAgIOt7A=;
        b=M/CaZ57QYb2AR/YE5NAH+iU3v0+x8+9Z6kUAf48OtfoFLdAiYjyZb/Wy2zHzoiKh80
         syxHWFEKyPEsk1PxQJv0dz2E84SrGCToicwpm30BYNuyZYxMvnqusSpkIC7bVFnY/gs6
         TO1ZxUABEs7EVxg3E6rFgyrCcBf0uqZcmWa4A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704933195; x=1705537995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ecki/5hmhCZ1pJBgLNzGL9kIecS6fNHUeL7VAgIOt7A=;
        b=dzDfelUdUe7fOKGppy8fDB6NVXej9Gi060o1poQuWQ8UDtZI79D6lPA7qTJYtGvf4O
         WLiG7p8cd7KYtPBlw+ucIPZwxfEp5BcrYTa8r+QIer1Sw258po7NnqAFIJ4FjOKl+YpP
         LTZLqQThGAiaSf0/18ieF3CnvBbN2h0woGytaGnevelkhHK3ARYyAfcxLuPCI9evXVPO
         chQ6qk2/6u62JsWJxQQOtCED50syasFD7VTI2WvOkJBFQIWwtkm1gGEXkgtKBn5w0YHe
         6fmQh9U1Vpuz/Nn3BinjRT0xY72Pt/km0sjhdOdEDJytrm46Enq/LciGjafLU+c0t7qT
         Xzqg==
X-Gm-Message-State: AOJu0YxNMupbC/X8kgM6GvY/kyw6gmFvm22dmYATHiU8SdVeNmuaUKa9
	LNfVrGjhKXYuVeX09I2/Ma6mKVm7vfD1U4oxbmNG5Cz0TcwcyTcF
X-Google-Smtp-Source: AGHT+IEbux0rIu3Qyn7c+VQATCRbX6wyceUDw1g5L0MSDLq1VWVxElg5ku0pnuGgYDwU+02EfQQfhA==
X-Received: by 2002:a17:907:50e:b0:a23:71ca:2bb4 with SMTP id wj14-20020a170907050e00b00a2371ca2bb4mr115012ejb.144.1704933195078;
        Wed, 10 Jan 2024 16:33:15 -0800 (PST)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id v27-20020a170906181b00b00a2ae0aa9002sm2588249eje.40.2024.01.10.16.33.14
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 16:33:14 -0800 (PST)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a277339dcf4so523705566b.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jan 2024 16:33:14 -0800 (PST)
X-Received: by 2002:a17:907:1c9b:b0:a28:d5dd:574f with SMTP id
 nb27-20020a1709071c9b00b00a28d5dd574fmr218565ejc.31.1704933194074; Wed, 10
 Jan 2024 16:33:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231025140205.3586473-1-mszeredi@redhat.com> <20231025140205.3586473-6-mszeredi@redhat.com>
 <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
In-Reply-To: <75b87a85-7d2c-4078-91e3-024ea36cfb42@roeck-us.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Jan 2024 16:32:57 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
Message-ID: <CAHk-=wjdW-4s6Kpa4izJ2D=yPdCje6Ta=eQxxQG6e2SkP42vnw@mail.gmail.com>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
To: Guenter Roeck <linux@roeck-us.net>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-man@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>, David Howells <dhowells@redhat.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, Christian Brauner <christian@brauner.io>, 
	Amir Goldstein <amir73il@gmail.com>, Matthew House <mattlloydhouse@gmail.com>, 
	Florian Weimer <fweimer@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Jan 2024 at 14:23, Guenter Roeck <linux@roeck-us.net> wrote:
>
> with this patch in the tree, all sh4 builds fail with ICE.
>
> during RTL pass: final
> In file included from fs/namespace.c:11:
> fs/namespace.c: In function '__se_sys_listmount':
> include/linux/syscalls.h:258:9: internal compiler error: in change_address_1, at emit-rtl.c:2275

We do have those very ugly SYSCALL_DEFINEx() macros, but I'm not
seeing _anything_ that would be odd about the listmount case.

And the "__se_sys" thing in particular is just a fairly trivial wrapper.

It does use that asmlinkage_protect() thing, and it is unquestionably
horrendously ugly (staring too long at <linux/syscalls.h> has been
known to cause madness and despair), but we do that for *every* single
system call and I don't see why the new listmount entry would be
different.

           Linus
