Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F17619ABAB
	for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 15:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743090605; cv=none; b=fcUydEa4peEIPLz3fAUrDIujq2IWh+uamwzZMR+Q8sE1R5rygyqhG6M16Em9OXHn4HinRhxTx1NxDD+RUpo56DBOgJ1oQjL8Gp8aWS5bivccZVXGunC4xrIa9lTdFaqZMMIm7YQ2fosJaoI2lrU2uIzip+skCGzbdMdF2LOrJws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743090605; c=relaxed/simple;
	bh=qeSfzsuQ+OnvzOB9ynW6I4+8VDYguG/d7VHfeNiTSM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfI9MFpfp+3YwBO4usHNNwniZ32kVEgU2hOOIhslaAklT5ggdyyv83hcOc1IyjISiOEfBjr4dYJyX6yqF4ynryx8uDDVq8/ciCB6X/SlZ+owY6O5Z4i7aL/7tUhY21qSxY3RMIJczq5/pKmrJyvR9Df0fZj7UHw3varn4uTusYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Oq+xEplI; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Oq+xEplI"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aaf0f1adef8so163229566b.3
        for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 08:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743090601; x=1743695401; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=giFLnP1jrB3bJbmUGr3lK+uOvsNT5VzaCpu7lPsk4hs=;
        b=Oq+xEplIxNaC/jjoSOBE9weI6KgcgDj/cxp2XfEfDNSMHOHFJKs7ikjxwqCJ11MjWA
         B8F/ireESXVCfC93P6lHubTdu7DWI+fTRbuZ1KyH9VdIV8Qp+br4FSrvT+AS+vKXL66L
         VOhxhwC2UWnarwcIKdDnOyJiV/ZLgCcZ5kztI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743090601; x=1743695401;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=giFLnP1jrB3bJbmUGr3lK+uOvsNT5VzaCpu7lPsk4hs=;
        b=d5Kbydnio1Eczu6h6i02w1dbFlywXEljhfyvEmkNNhLGcPzTLZbtMnqGfwBgGFZhcK
         eF3euZ0NGH1XyZPRwqk32IpTk+A0cVHv0kbW2ddKhfI7B5xwMpI5RoNO30Q190zaPiHP
         Qtf0YoyYBXLtlQ/6GCA8UXkn02XkIcwOOqKtKIf8ne9nJb4AXViac7hiMsYMxrF/8Gm0
         YIxClcDnMuvN+Am+hKN518HTARKBy6W5K38UJ7BjV9byWYvvNhkkd9tI/EKTpk/R6LWD
         Z6tpICrl7hRT05+EtfYE5m6G3W93DXmI5FuB285YxCLJilxlG7i3mXoLvUJtF1fZq66i
         MYwQ==
X-Forwarded-Encrypted: i=1; AJvYcCV13/2RKCD4o5ryqh+bmUPybxOktfJfmdZzt5dbuZHNBuBXivnROEARP/KibHA1Umv7yNuWqTUI1JEasjsD0L+nurlvt2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGI/0Mtsh5wJN/fmQEBAmu0ibc62/5bhYNwFn4d0AGt5RgOcmJ
	iXF5ViLB2UKteA+cXfuK58ykwmNRUv6uo5i9Tw8yZwkwq5mid94p8bd9PBKWXrQ+3Y0CeyprLxh
	RzrY=
X-Gm-Gg: ASbGncuDyvlJUy1IIZk62fQ37U04g8QjytfGY58IJJpBIvUNRpQ5HWLrNSeCnkPMfk0
	Da96cAkAr20iCSpmd8u3kVKhxKczXPZ+dshY1tenrxwg8aVZQcwxZJZhftWZznAEf7akxF5Y/TG
	R+MmI7NEX1+fjzIGzP4axxewYTJbv0y06yoklS6d1qaQwE1z12+s2uMHuC1WhieOMTIUh5XU/iX
	1Lf2CmH4h8Kt4+iyiNieetMcevRS6kS6ewA2bsjU0pPrOJektPbuMlC3s0mJlN8ZTNpuTgH5mwa
	lkOXoTOyHmU4NMFjfsw708UX6dubuLI35BsRECWg2pwcgWf3/gpMS/iqWLpZP4KK4YXlXKYrpc/
	6MDHSdi87XfD8qIUI4v4=
X-Google-Smtp-Source: AGHT+IH7sxoal6NRmo0IeXJses2i6YmiRxV7O+9ZkWzXHQRJjf8vWLbEAySpI9HdLbMAgrnndhICEA==
X-Received: by 2002:a17:907:7ba1:b0:ac1:e2be:bab8 with SMTP id a640c23a62f3a-ac6faf34d25mr350213766b.26.1743090601326;
        Thu, 27 Mar 2025 08:50:01 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac71922cc94sm14655166b.28.2025.03.27.08.50.00
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 08:50:00 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5e5c7d6b96fso2179811a12.3
        for <linux-security-module@vger.kernel.org>; Thu, 27 Mar 2025 08:50:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUgEWNTBPgAWUC85yn2KNIpAiIonCSQI7+dg5eGbOdEiZwiefhpDiW67S+B6P3yWTCQAw6OgE7KB1VJQDRFMLW0v1hw9fw=@vger.kernel.org
X-Received: by 2002:a17:907:969e:b0:ac3:3f13:4b98 with SMTP id
 a640c23a62f3a-ac6fb14a9eemr321047366b.39.1743090599993; Thu, 27 Mar 2025
 08:49:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com>
 <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
 <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
 <CAHC9VhT3D7X=4SpO5xbYm=JUwJqTa7tn=J6QMDBV96c7VBUw4g@mail.gmail.com>
 <CAHk-=wiH3hoPTxX3=xTRzRuCwktf3pNzFWP45-x6AwoVAjUsUQ@mail.gmail.com>
 <CAHC9VhT5G6W7g9pB3VM6W7wCEJjWfYSUWNgWF+rRiQ4ZQbGMEQ@mail.gmail.com>
 <CAHk-=whwQhJtafHN4B1w-z2Gno__xLHS4NouKKHrYNTYa8kz3g@mail.gmail.com>
 <CA+zpnLeK2Ecj1mBod2rFe4ymd9eXiJkbyYwFh4Yrmck3DVB2SA@mail.gmail.com>
 <CAHk-=wiBH8FBL+pnXui8O-FSdyoG-yX81mUF9bsZcC6rR5ZtgQ@mail.gmail.com>
 <CA+zpnLe_AOpS_F1UBNOvN3YRswUSy_3=0jjUAy4GPxEHYumD0g@mail.gmail.com>
 <CAHk-=wgJ0gzYJD+MghfVW-YeGLW6sLU5soFY13KWmPAxobk5Mw@mail.gmail.com> <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
In-Reply-To: <CABXk95AqgpqGtjzK2o=mxWJg5RUZG80dAEaKF9JdUT6n5eFENQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 27 Mar 2025 08:49:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
X-Gm-Features: AQ5f1JpfPxIDPXqHseSeuENAM4paunItAZJKgsQVaCtDcDayjV2pwNNW6TWk5bQ
Message-ID: <CAHk-=wh1refm6JkAB__TmC8OBJyNdH2DmNQAbvcL=tKepkHrYw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Jeffrey Vander Stoep <jeffv@google.com>
Cc: =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Nick Kralevich <nnk@google.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Mar 2025 at 01:59, Jeffrey Vander Stoep <jeffv@google.com> wrote:
>
> The value here isn't so much about checking the source context
> "kernel", but rather about checking the target context and enforcing
> that firmware can only come from trusted filesystems. So even a
> compromised privileged process that sets firmware_class.path cannot
> cause the kernel to load firmware from an arbitrary source.

Yes, and that's literally why I earlier in the thread pointed out the
new code in selinux_kernel_load_data()

  "I'm looking at selinux_kernel_load_data() in particular, where you
   don't even pass it a file at all, so it's not like it could check for
   "is this file integrity-protected" or anything like that"

because I understand that you might want to verify the *file* the
firmware comes from, but I think verifying the context in which the
firmware is loaded is absolutely insane and incorrect.

And that is literally *all* that the new case in
selinux_kernel_load_data() does. There is no excuse for that craziness
that I can come up with.

And yes, I'm harping on this, because I really *hate* how the security
layer comes up in my performance profiles so much. It's truly
disgusting. So when I see new hooks that don't make sense to me, I
react *very* strongly.

Do I believe this insanity matters for performance? No.

But do I believe that the security code needs to *think* about the
random hooks it adds more? Yes. YES!

Which is why I really hate seeing new random hooks where I then go
"that is complete and utter nonsense".

[ This whole patch triggered me for another reason too - firmware
loading in particular has a history of user space actively and
maliciously screwing the kernel up.

  The reason we load firmware directly from the kernel is because user
space "policy" decisions actively broke our original "let user space
do it" model.

  So if somebody thinks I'm overreacting, they are probably right, but
dammit, this triggers two of my big red flags for "this is horribly
wrong" ]

                Linus
