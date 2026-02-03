Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578B92F616B
	for <linux-security-module@vger.kernel.org>; Tue,  3 Feb 2026 22:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770158460; cv=pass; b=d+lMjbCyu3FVuX0dSIuuy2jLZxrX14N7YBiczYKDOESXoraNATCRZgcq1V5EipjJVz+Ck1Qp7FdGzTV8rMpfFH2ilwal/nuvD4sMfs9DZadpjmkHTrpCn8VLVsK+vgloAa1HQ/i3HtVIsV4x8skM31yU2SyrLIDGuaEK3KC0sts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770158460; c=relaxed/simple;
	bh=mNxsZIpO12xYwIPhpNLEYqg3xGCJpxHU05Vm1/bMpH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t7V7K881DNknw9CDjwoFTXWgjOkLeuHTUHrL2NEFq2uytU8BP3Nh0kIS/ZmR5oQK/pchl+TRRnzx/0/s0JxOPIsFpTium5mve5Zt2mi+m0cFPEP71XkF9o304TIOSrXIJwAKSQMsFk/w5aTGSnpWQehAM8aIMvEBrJvD/mKGM1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=eFHErCUd; arc=pass smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="eFHErCUd"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a102494058so1335535ad.0
        for <linux-security-module@vger.kernel.org>; Tue, 03 Feb 2026 14:40:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770158459; cv=none;
        d=google.com; s=arc-20240605;
        b=VyuG7L8muCNYDz/3TdkEvM/xbYWpZU4RF2gg6/ZsfDSKVacdVrAXN8Mq8riSsOv+C7
         aStJ4TKQ0WuqB8g6S+ZCdK1e7cgdSG7Gs4Gr9a/AhqnMA52psKqipuvz5i0B26syJchn
         /Z5Uidvh5HZss8UQumWsFiJqKXOIuMF53R4FfGiiNdvPtoYY2oeu1O1SkOYPyO1W2qxk
         TwtEVT6nxm9RTBRgdd8TXgIzNxzp7xw59Lg9ZyNAVdnB8lB9w8iwqYuyjnBMEYOVZ0+1
         I4veSqg0BYnTwDTV1jDdClFjMioj28y89SKnFXAOZcLyjEDDf1FLhiZGZUS4w0pZXkG6
         GAFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yhF9jJ/5jkA/G3XXwtAD0z04CKPNClOANnWCQ+kHOf0=;
        fh=x7oSrjhs70bwsKMCNPjGpD7l1oNk35YkIlyo4TtjAV0=;
        b=kt5sRsOiSgYU/l+pZbma/Kvg8S1tPpORqJv4YA9oUWmNzqXTdbQ43sWxRgodCqwzS4
         dz/2DP6fVs9t1AoxBaymd9Wsm01bxpgT4+PDjTX32CulEbU/kM1rvQLLVk6e9ps5y7R6
         ketre4X5JteREqaXltxbmxwv3iV9dfTb1EVm15taXkNY9PJcewXFb3iclAn4hj1EvYzH
         gGzci5/jyAjsu3asMRJU4MNZgpfzBcSimt9ql89Tz1Mgz6cTRhEtET7LSubK67jtN14X
         XvUOtZIT9DJK65yw63dh9z+WATQ6eTzfbHoLO3EW1x1h0wGXZMEtxFuOps+vPiVO1/GE
         AIHQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1770158459; x=1770763259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yhF9jJ/5jkA/G3XXwtAD0z04CKPNClOANnWCQ+kHOf0=;
        b=eFHErCUdhFyWGykHjYB6biTI6lGhkeyvSU+/AGFo++dYiMonR9D2eLErqPy0mkDw4W
         2xKbh4/DpviR4nmus2RgdGNwaisyKe1eiTPPfwyu2kE7LqIIGidpt/kb68h7YfDfrvgS
         IrT90nehejOP8NrMiJ3XcHBRhXSczmZTklqN8NWV5swtwLwmX3hTf5d63xFjN01BCv6t
         wbuAr8OmZIcI4vBEeLTTE/8sesbRpwy4xw26u+/6906sqyWp0UqEv5VRVuFqLS4ZAjYI
         NgF29kbK+QaYbZ9qaLWDvl7U8mZ0VtIk7dVQ6pXScE/omqo+uz6cRUvzfDm3B37V/jIq
         NK9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770158459; x=1770763259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yhF9jJ/5jkA/G3XXwtAD0z04CKPNClOANnWCQ+kHOf0=;
        b=Z8FIcJJ83Gx3d0fEFbNkG1ai0KqwsgPeCwchs4EfTH6p/BAoZjFJv0yMlKGS6ff/hT
         xTPWhf3fanhfKvDMOm4INB8IZLittLUysoNh/FP8UG6EawUgUZE3WhTqTmcXm15wXIFf
         OS9W1r+t3K/ViVcFQgQO3mM/d9vHwmp00g8MzSh3QpCHOX7GfIVKFOn1AD7ahTznA7Aa
         eW565bk1B67yFMhrPhG+h+QqgSnQYG6uti17rugwUk9qLzPs5V16LAv1m2xSGLG2Ximt
         Yof9XK10kVE7GB2N3ZHdImfMkNXn6+iXj9lA2jR1NPCP2gy4TtT5y7vkrUW+4VHvFkgL
         5uXA==
X-Forwarded-Encrypted: i=1; AJvYcCXSBQ+1DrRKiYNpA0Dv2Vx2sGN7JHodcqEAKgtjBnMljaJbyyhTJL6YqDTNNODrm6QYYXLmZezucR92lzR8Pc+Jh6gruDM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNhQ+5h7E89+/zaS98XcQ1Cn+IviBoXOQTpdrrBUiW6ui8mER/
	T8rJmiNf4vptiY2BqunxOTLcdshsQYBdNCr0pijWN1qhXS7tqEAwXHDUBn9GUWqK3laiGHoviYG
	9Fd4a6YVGeal33dbuwYBK2CvhLqj+dgZ0G2I0+IEc
X-Gm-Gg: AZuq6aIG6VRjVf++a5TeWqfIBdurrcrgwfoEk7oKVBXAhPW11qko2Wg6i2SEbyaJsWJ
	La+aII2w9S/Byjy3itJQwBqthQ5CmD/QL1aT5CIhmNdhMmxujYTDn4TC3RcQJhIPGQOg4GNGENk
	bFC2EdrBPkcJgfDQEUaatu8w9ECRYzvDTwgsuIumhbvHeXKgV4Ld053+NhJ1Xc8RnaKqoyrMepa
	8cEy0UUqx9hTxVGgVt4AFlxK7DTEEmxxQTClmFutcNdwV5lVX/R6r4CW3k9tciRBZuVPfQ=
X-Received: by 2002:a17:902:cf07:b0:2a0:89c6:1824 with SMTP id
 d9443c01a7336-2a9245acb81mr45534675ad.8.1770158458714; Tue, 03 Feb 2026
 14:40:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2ec9c137-79a5-4562-8587-43dd2633f116@I-love.SAKURA.ne.jp>
 <CAHC9VhQikhv+qCyQdnJguvy-qTkGXB+NU7=QZjw5d+WfyVxZhw@mail.gmail.com>
 <00ed59a3-a9c9-47c3-97da-5a8e3da1ea82@I-love.SAKURA.ne.jp>
 <CAHC9VhQq6jY63kYEQCp2t89Vv+_PDqv54RV6TO_TePDQyU6Vug@mail.gmail.com>
 <1bb453af-3ef2-4ab6-a909-0705bd07c136@I-love.SAKURA.ne.jp>
 <CAHC9VhQEKfxXzFgYShojESpQn10LES5zL6Ua0YV9b8seEKFqyA@mail.gmail.com>
 <93d291db-4175-48c4-830c-e83bab373ae2@I-love.SAKURA.ne.jp>
 <CAHC9VhQPKU5DqG-ryZsiCV2vZeGGf_a-JStR_LVVCCn03C4usQ@mail.gmail.com> <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
In-Reply-To: <f9b88268-03dc-4356-8b31-0bab73cc9b1e@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 3 Feb 2026 17:40:46 -0500
X-Gm-Features: AZwV_Qif3yehzpr-f2ndt231BFo5lijgl4EiKO49mjjc8a7vIRsWIa1o9OOEp3s
Message-ID: <CAHC9VhRzRAR+hhn4TFADnHWpzjOxjmh0S_Hg_HktkPkKQ35ycg@mail.gmail.com>
Subject: Re: [PATCH] xfrm: kill xfrm_dev_{state,policy}_flush_secctx_check()
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: SELinux <selinux@vger.kernel.org>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Network Development <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 2, 2026 at 10:48=E2=80=AFPM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2026/02/02 13:07, Paul Moore wrote:
> > I'm asking you to verify that we have the LSM xfrm hooks in all of the
> > necessary locations to ensure that we are safely and comprehensively
> > gating all of the operations that result in removal of SPD and SAD
> > entries.
>
> That is impossible. We can't have the LSM xfrm hooks in all locations
> that result in removal of SPD and SAD entries.

It's a good thing that isn't what I said.  I said "... LSM xfrm hooks
in all of the
necessary locations to ensure that we are safely and COMPREHENSIVELY
GATING all of the operations that result in removal of SPD and SAD
entries."  I used the capitalization to emphasize the idea that the
goal is a comprehensive gating of the operations, not necessarily a
placement of LSM hooks in all of the functions.  It can be a subtle
difference, but it is an important one as I think you can understand.

> It is your role (not my role) to verify that we have the LSM xfrm hooks i=
n all
> of the necessary locations, for it is you who is wishing to ensure that w=
e are
> safely and comprehensively gating all of the operations that result in re=
moval
> of SPD and SAD entries.

All of us who contribute upstream have a responsibility to ensure the
proper operation and maintenance of the upstream Linux kernel, this is
especially true for individuals such as yourself who have accepted a
maintainer role.

You have identified what appear to be issues with the upstream kernel,
and have proposed changes to address that.  While reviewing those
changes I asked you to verify that the LSM hooks associated with your
proposed change were still working as expected, since it was not clear
from the discussion, or the patch, that an investigation had taken
place.  This is not an unusual request for such a proposed change, and
is something that I would expect a LSM maintainer to do without much
hesitation.  If you are unwilling to investigate this, can you explain
why?

--=20
paul-moore.com
