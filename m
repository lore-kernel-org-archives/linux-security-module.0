Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC912132C10
	for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 19:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125316; cv=none; b=B4c53uS/R9GI/MsozndC06DOSPnvdEKTRedO3oflOQ0tWklPSeG+I1P3VjYqWyt1M51DQIUs+gEFtoQm3I8rvWVX6IQc8xAB9olfzcRHZBW5lO9C8G09oGyx9vx8TcZebixSZqr0NBV6uTUdGS9IZ9aErEh5D3wkLfDUCSLbuOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125316; c=relaxed/simple;
	bh=ouJwYHRa4mmcxxGDuONLqBrc9eGAB9TSx7zyDOPpuZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLLhnPORrhQ9o56MLm+VZIfZGWWxmwyuMozrfYzSAOACRqIWKHDEWe79nk+dOgr/cJ9cDlt2p8ul2X1dCv0x5ivXVG305+aVf18eYqZU/r21aAzLkqcLP3LvABcGuS75CAlbcLxYi/wQ66LUY2TdwGXE5APZRSGxCplNwt7rnhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=V5ub+sov; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="V5ub+sov"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a3106f5aac8so154174366b.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 11:41:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706125313; x=1706730113; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uH4xyu20AZv2y9FxRkejBz/ztRhAIrUHK2zRol0B+1g=;
        b=V5ub+sovq3NZYBptrCECOob6x6h6EcgEA1e6g5WOaLPBI9iqsrCgVgofP4D2t6yM6R
         kPfHxOdo+oVd5T73X0pRpKil1nrBTLgZYlCuwDRo3ZMM0mnec+Fk8yFvqaFTE/VJ41Mw
         riBfoWBgIayi0koYFdAt8Z8MffXbA8AAp7qEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706125313; x=1706730113;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uH4xyu20AZv2y9FxRkejBz/ztRhAIrUHK2zRol0B+1g=;
        b=uFPDjqO6fKmX6ijacTJuWhdwXGaliYVQEsMZYqTmN0Q2QjlvQBEHSC8OsKJUVgSljJ
         GKuVpMFscVPbsM/gRqcSwnK0/Eo+0IrZvU8RK3qFQpnNP7zpDnfo6cg5FTSj8xKeCuwJ
         WajCDLhmitI3OuP+0QXDkT4j+s3+dEiJ0Ce/D4q4iZ4LD2xh3hY3ZTJvRGo2LYhK8zo9
         dqc9C6JDih2Js/0KySPgf7Wd8UJe1SMecgrKaH33tIO37ErAWS2xfh/3gQ5i1186UGc7
         HqJAhlKETud2naD81/xqAtM6BQLURkKKxjraKkyP9pBBArhHo0m7EzqBkmjRwkIoFm/v
         p2kQ==
X-Gm-Message-State: AOJu0YyWPWOvGLcM9jeDfuxnBIbuhjyri2jgIhW0FeSfy0XrfVx/Ibbz
	1WQlK7OqJnfQPh1uT53Pw1W/ecCaOhMq2V/dHJ+l5mj1/HMwN/1sMiihNL7LGdfWl3B15C9MQjs
	NB0tNgg==
X-Google-Smtp-Source: AGHT+IE5aC5+LAHoIYVkhfBrWv4y5gYamzgkrqIn1Yhre6/6EXJ5Kh7a4JxdTyiFZyjU/a1lPDNniw==
X-Received: by 2002:a17:907:c082:b0:a2c:7293:af58 with SMTP id st2-20020a170907c08200b00a2c7293af58mr1421332ejc.79.1706125312729;
        Wed, 24 Jan 2024 11:41:52 -0800 (PST)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id s11-20020a17090699cb00b00a316896b4aesm7996ejn.80.2024.01.24.11.41.52
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 11:41:52 -0800 (PST)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a8fb31fc2so5471032a12.0
        for <linux-security-module@vger.kernel.org>; Wed, 24 Jan 2024 11:41:52 -0800 (PST)
X-Received: by 2002:aa7:c853:0:b0:55a:6f4b:27cc with SMTP id
 g19-20020aa7c853000000b0055a6f4b27ccmr1999900edt.44.1706125311944; Wed, 24
 Jan 2024 11:41:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook> <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com> <202401241058.16E3140@keescook>
In-Reply-To: <202401241058.16E3140@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 11:41:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgEXx0m_eaeN5-DoZQxStF0pOLU9s3GkFbhBt-2ro3Ofg@mail.gmail.com>
Message-ID: <CAHk-=wgEXx0m_eaeN5-DoZQxStF0pOLU9s3GkFbhBt-2ro3Ofg@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Kees Cook <keescook@chromium.org>
Cc: Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	John Johansen <john.johansen@canonical.com>, Paul Moore <paul@paul-moore.com>, 
	Kevin Locke <kevin@kevinlocke.name>, Josh Triplett <josh@joshtriplett.org>, 
	Mateusz Guzik <mjguzik@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 11:02, Kees Cook <keescook@chromium.org> wrote:
>
> Yup. Should I post a formal patch, or do you want to commit what you've
> got (with the "file" -> "f" fix)?

I took your formal patch. Thanks,

               Linus
