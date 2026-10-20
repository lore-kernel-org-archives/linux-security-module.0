Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792533508;
	b=GK3VjpnsveEPxSXtoptP39RIIBpuXMqCU+jeAPzTRsUV6sf36ZOyrXJpm31Md7crdCrS
	 2TBWcm7vBIoGy5fMvTDjvcGUeiaR/4t79ml+5/rzJC6EjqcEvsuk7CHR4tAx3u9vLF7Y9
	 I7l6e3rCifqas96kNFWmNymOVfvPxvdLUE+mUrAU6PpVfGPWjPRA6WfGwRezbuOytlYGY
	 sPkW9lCivQ9Z455Tj38Vx15lwL3SIJF72CyX7yS/tu/kHgHU7rmffo7uQ9ka5ogf10u3E
	 IHoFRVsiCAuYW3lurff5pFp2UEEbVJnTKqwFb5C5ofm1bAmMrMLn823Ml46A+u3XeEQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792533508;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=sr2CLGfHoWoGGElFIf0Rz1gXMEHFA2vL11vrI5IV4+0=;
	b=tIODt49pEmlh2wbrVNldPKGGm+CWO49tfTI92qNxH2d1oUHHRANUAbXMjKDia/FZEICy
	 u7k8k36fp3kfmWIJ+aSTC1raxcA7k7UBx1wXXgpDIAnVYLQvUf+QfWaS7TVsKIaQenVVy
	 nqGhXN81n6j0Gfe0cC8KOVwpNdBTWcHkKpsWRFsYZQGSTbkhGOVRsmHJdQ+tnLKvh/arG
	 ftu0q6Mwh+z6zp/n4jrNMu+t2DbEgKvlhcTOnlWba15uab6D3yD5Hb5qF2IeU8aI0qyGy
	 IDMt38xISf5O9CH9W6kEXvtQpiviY7FQJ87ITvsfxKOtRLesmjfEZ4oHAKoZBUjxhvw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ZlCPSaes;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.175
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF0606A31C
	for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 21:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CDF0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=ZlCPSaes
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso363325ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 20 Oct 2026 14:58:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792533507; cv=none;
        d=google.com; s=arc-20260327;
        b=BEyta/UeTPtsOouZxsblqpwN6yFK0DAaC7ldlB35gJ+jtnE92JIGFDUUBSugxGoipy
         PCeWSLch5plHE/uOQP/k7GAdFuHo9LXTnLnfH20m3v35bkEiSAdB6/V8bg/D0/FZ9SKZ
         5QaT5mVO9MDfamLZAO0nwKXaEi9vqEZiRqY8ZuLsEmYnuHkC1IXKAn3aDEgoGuQs9QRR
         W4/pYSX1EkGusO7JU40AdQlckqohcFazq14oE4araKGiTp7Hzrxb5jBwEnFolg4z2ukz
         xc+Tii9wpP8uQKCH8wxgAnD6DqjXWs/R4ELhohIypZtviySahUWF42qwbQMpU9kgtGaY
         pavg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sr2CLGfHoWoGGElFIf0Rz1gXMEHFA2vL11vrI5IV4+0=;
        fh=+S1z5i81wl6BOaV+LE48lRyvW1pjFXTzd2cthdLWbVQ=;
        b=NpGIqYsoL0XkM+I0/wQONBS6uOhAzp2EBeOHR7wrbeeUHguZ2bfCP2HaaTRAFLMfsr
         cqpkSCnl/I/2nvPFaDA3Lv0sXz01qTifxQejdpJANGwOP15LfwDEMD9/YSXt5khchwcw
         ZR0EAcq/RDCOMW1XNfQi7EpSuRC1aibuMe3W4SFXAlAR6MqX4yEZB9NxXFMKzin07cJR
         IUypG10BjHyVOwjtPgYlNRtBPviXGU3BhkJ71DMMtyVA+q3jgbLSs6xBteiDgFYQST8s
         9IjPxRTVHPbEFdc5lKn1he8g4zgol/uyt2x85G3ql/hED0CrZQWcL3gtWHxyrVEbR+tx
         fUUA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1792533507; x=1793138307; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sr2CLGfHoWoGGElFIf0Rz1gXMEHFA2vL11vrI5IV4+0=;
        b=ZlCPSaesvwK6ytevnWbTHn0TkN/ILYgKMLvVa+tEKPUiI/PXEgd7eOMiq+SnfX0kRJ
         wqPZqYXGzmDSfSov9ygbM5FaoZsi8bAJ5yPxoeKuAggi1uuyppnl86Kf6jIq1ueT2MkJ
         fNMdSChgDXaIEYSYaeWM6YWOdsxPAhe4AbIEkCaAJAsGZ9mOy/IhBXPiNSjTZ3GHubiU
         XwoZ7vMLO/o01Slg5yXTFqwib0as9ToE5VFmGl9Kq8tH4ULUtbFXWDJNOFVY/oZXWiMe
         dHnNiznLoItrj5HNuMEJDE+1IKIutN+nzKD0M6XegYgQImAS2CNtMjD7ojkhTlY3ZSpW
         ZnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792533507; x=1793138307;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sr2CLGfHoWoGGElFIf0Rz1gXMEHFA2vL11vrI5IV4+0=;
        b=GXs/kEbymJu/PTYRhyxYmEErnjz7gM+Uo5pStLiILu5EmXt78z5cq5dYDminVMi8/8
         iCtKBREVPdjrLXkV1VJrTH8gV6KKFClt5+1j61vUwrfVfBWhFrJm3N+9pvZf/jcrOOPY
         2yLu91zrMCnV5whMtBe+T4WOdX758Dc0SE369npleZbsNhU+mL79UgA/k8hsdHYMNdNc
         PK03xgP6vjdQbS8wYNxaxUrn0oyyltqdW8fiBVo5aZtGUpw7K2VLV68VeNtUTWfg318d
         N7Wl/4hVQNf2vqpPp7qllQgHWr0u787joyoCJmsw3eLkaPbAsLuhAVk2nskVTOJ7eViW
         oH1g==
X-Forwarded-Encrypted: i=1; AKwUvByMa2cQ7BJyzpjAqJ3q66BRz8cizGuLqVj0AvMSN4HfefujVlIM0VmzMav44i2dvjNZQqK/wcILSa89FzjKjs90BVybXQE=@vger.kernel.org
X-Gm-Message-State: AFq9FYJRp9Ao7X+H8Rhfiudy3PWlL6F0bqB/FubBp97scFl8NwixE/iX
	CcQThJFL1Oq0xWZVxcMCKw3/OK5w5+HfrgUyBfM7TP2P81zMt+CmzF0JV+v7vxMLasDP9lRGbJb
	d9ViHp5pX1Gl2SnM9M6VjVoScwYymBtj2UZlyTxKk
X-Gm-Gg: AYBFou1ZgRQkQuUEetUOAEotI7eVowp5iHqE7D7QOVTTWxSrS8ejuGk0vo3bsktXhPk
	Fb8SPdNBE0sSlZCnl5fAfrNgrYIl3Vyoj4y3AHTVSwuRJ3RzLdF9gyvSDWUTErGqztfAmzM8Yjo
	ZpQVcrc1gJjpJEfpncvzS3egjLgIUw3w71LYoIQky9OyXt/KNnkJc2QX8cXCsLsMopKBt7zFM5n
	5Bmg67nW6aHirsE4NTcLOf3fteQtuTAphxAnPuWtLowDbIHaUhrrB+wOyuW+TQYpkOQkZ1bFyiW
	iDZLXIh0df3Pa3oAWla0jWUyfPaZhEomwQJZTaKFQaWLFcuMnRvghGqwhvOPtqYV/FGWha3plhd
	za4WsofG4q8iN
X-Received: by 2002:a17:903:98f:b0:2e9:7e90:8a3 with SMTP id
 d9443c01a7336-2ea43c649bcmr890865ad.39.1792533506693; Tue, 20 Oct 2026
 14:58:26 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <179138670045.80227.16292613517250896744@gmail.com>
 <CAL4WiirbJrQThGS4BUo=a=AV9ckJk2AyedO8AgJgozjHOwu5Vw@mail.gmail.com>
 <CAHC9VhT5w3K1MvmP=1Mxf6KKWZD5BbK14bVHJGYFN93080j5jg@mail.gmail.com> <179216077404.22091.15636720633867774901@gmail.com>
In-Reply-To: <179216077404.22091.15636720633867774901@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Oct 2026 17:58:15 -0400
X-Gm-Features: AclHuK_bFa67Ysq0EPlVn9haOjzs2jVy9717_wwLtZiIrC2qKhEMo2q1W3c8W7E
Message-ID: <CAHC9VhTDnwGkX47vOLvS_1HTAcqg7qjkXCiJwn=qGhdy_n0Jvw@mail.gmail.com>
Subject: Re: [PATCH net] calipso: update payload_len when removing the CALIPSO option
To: Joas Antonio dos Santos <joasantonio108@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Alice Mikityanska <alice.kernel@fastmail.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 16, 2026 at 10:26=E2=80=AFAM Joas Antonio dos Santos
<joasantonio108@gmail.com> wrote:
>
> On Wed, Oct 14, 2026 at 9:39 AM Paul Moore wrote:
> > while basic CALIPSO labeling is tested via an automated test job, this
> > particular code path is not part of the automated testing.
> > Improvements to the tests are always welcome.
>
> Hi Paul,
>
> I opened a PR adding a forwarding test to tests/inet_socket:
>
>   https://github.com/SELinuxProject/selinux-testsuite/pull/106
>
> It builds a client -- router -- server setup with network namespaces
> and checks both directions: the router removing the CALIPSO option and
> the router adding one.  On Fedora 44 (6.19.10, without the fix) only
> the removal subtest fails, with the forwarded packet dropped as
> truncated; with the fix all inet_socket and sctp tests pass, both as
> unconfined_t and sysadm_t.
>
> Until the fix reaches the kernel used by the CI, the removal subtest
> will fail there; I'm happy to gate it on a kernel version if you
> prefer.

I see you sent it to the list too - thank you for helping with this!

--=20
paul-moore.com
