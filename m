Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UW5smEd7"
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4566B6
	for <linux-security-module@vger.kernel.org>; Mon, 11 Dec 2023 00:49:22 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-db53f73eefeso4402331276.0
        for <linux-security-module@vger.kernel.org>; Mon, 11 Dec 2023 00:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702284562; x=1702889362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Owh1Syk0ZNlTmvXNtbwF6wDId1bkrStE1MY5dtkm5mQ=;
        b=UW5smEd7SIjaXJNjNXS9AFmLoaiqjoZ7a6jPjDQRfTU9lB+PJ/WMaDcSRJNZPo/jv6
         HjCUWZbnh329Mk27Ex8y7cSayuP1zrYHdGqxD5i81TMHsK0DPsoisAWrmd8SeAQ7+/87
         6l8bdpY+BA42vB9X+/tiS/efZDHaVH7e+Tng9mAgI2SSNVVpGm/eHbnZmd8N9uT6J133
         TdUEoHwSEemCsjlvaOG49yPD1avZxyJue9srq4zzDajo7Ts8hT1WEyYA5uHUIUY8dVqp
         pUPmVZt4uH/OaafiSN//acjZTDLn9051IyCWvVOBGA7mOkL8Gydn9La0jh7+kyk/cEuK
         ZbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702284562; x=1702889362;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Owh1Syk0ZNlTmvXNtbwF6wDId1bkrStE1MY5dtkm5mQ=;
        b=lJlBGStpGheQIxDkJQTPuxHfntWHpxrFlPMxczfDFYGDSCjx+Zv89/uSFf2JkQD23F
         mgUUxwYQYjDwYEOUV4HRMBkLpHFiIXEdWXJ6YHEWRRMJJuThsygJrl8z5ImN4zXd1Kso
         M1+6i3nGnB11eVkNgiwGKXxhbXNm2F2aJANRgWduyiNsz4D4fqjUSXxbyPi8wiEL+M+2
         tA+ujvpbtzikr5ZbKCC4/t4ioSYCu/8oy8sLS8TOKRH7Tu1nN3IAWhdbS20i83SDaLrv
         uGc76Z2dJmnMfkCllg0jL5dRI1V/qRL4LuQU5D3oC3LRMYmBFerbtbBh3Wx1A5H4uluR
         ZwZA==
X-Gm-Message-State: AOJu0YymFdHpRpp8SJVyQVVadxVK8u5+Mzh6ikgvqlU51qQE+1EcaNI6
	X9GOAYZ2oN+CYjbDDhe7YrIx43JnG0E=
X-Google-Smtp-Source: AGHT+IHADZNPJ6Lbugm8snOt4emULj590PwI+Vg6wQGfYGAIyDmyPOad+GbNykqrXXlTYnXndQmG8/3HazY=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:8dfb:6b15:9b0:522a])
 (user=gnoack job=sendgmr) by 2002:a25:4093:0:b0:db5:4766:e365 with SMTP id
 n141-20020a254093000000b00db54766e365mr27097yba.8.1702284561940; Mon, 11 Dec
 2023 00:49:21 -0800 (PST)
Date: Mon, 11 Dec 2023 09:49:14 +0100
In-Reply-To: <20231211.ieZahkeiph1o@digikod.net>
Message-Id: <ZXbNCkzHbvystV8t@google.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231208155121.1943775-1-gnoack@google.com> <20231208155121.1943775-10-gnoack@google.com>
 <20231211.ieZahkeiph1o@digikod.net>
Subject: Re: [PATCH v8 9/9] landlock: Document IOCTL support
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>, Paul Moore <paul@paul-moore.com>, 
	Konstantin Meskhidze <konstantin.meskhidze@huawei.com>, Matt Bobrowski <repnop@google.com>, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello Micka=C3=ABl!

Thanks for the review!

On Mon, Dec 11, 2023 at 08:04:33AM +0100, Micka=C3=ABl Sala=C3=BCn wrote:
> On Fri, Dec 08, 2023 at 04:51:21PM +0100, G=C3=BCnther Noack wrote:
> > ++------------------------+-------------+-------------------+----------=
---------+
> > +|                        | ``IOCTL``   | ``IOCTL`` handled | ``IOCTL``=
 handled |
> > +|                        | not handled | and permitted     | and not p=
ermitted |
> > ++------------------------+-------------+-------------------+----------=
---------+
> > +| ``READ_FILE`` not      | allow       | allow             | deny     =
         |
> > +| handled                |             |                   |          =
         |
> > ++------------------------+             +-------------------+----------=
---------+
> > +| ``READ_FILE`` handled  |             | allow                        =
         |
> > +| and permitted          |             |                              =
         |
> > ++------------------------+             +-------------------+----------=
---------+
> > +| ``READ_FILE`` handled  |             | deny                         =
         |
> > +| and not permitted      |             |                              =
         |
> > ++------------------------+-------------+-------------------+----------=
---------+
>=20
> Great! Could you please format this table with the flat-table syntax?
> See https://docs.kernel.org/doc-guide/sphinx.html#tables

This link actually says that =E2=80=9CKernel style for tables is to prefer =
simple table
syntax or grid table syntax=E2=80=9D (instead of the flat-table syntax).

This "visual" style is more cumbersome to edit, but editing documentation
happens less than reading it, so further edits are less likely.  I also fin=
d it
easier to reason about what the cell sizes are that way, rather than having=
 to
wrap my head around special :rspan: and :cspan: syntax.

If you are not strongly opposed to it, I'd prefer to keep the existing styl=
e,
but we can do it either way if you feel strongly about it.  Let me know how
important this is to you.

Thanks,
=E2=80=94G=C3=BCnther
