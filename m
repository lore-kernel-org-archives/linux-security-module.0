Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793542249;
	b=k7U/igcQHkOxll2Ybc6epRcFW/j2eIpnhfEg8g+RTkyYN6ixD/cgAACjv0y2jWWuO519
	 NOtBlqIJ3R3y1Thw+LYof/RBogRnHG/xox9VBqLmtTctMSfnHgBmz6TwW9TUffyXQHOMb
	 gCb44rfTiTxKsdLyXCF6wmN/jbnmRoD+9qFSenFijaqbkPcvnh9TRQyYYb/iNlR0TAeR1
	 FMBVYQoX6+Jiy0JOZb+LZ5hgUeiWJxhdYi1hXGDx5QM7BJQGvQ2dCDvRwtZT4lbBGNWbX
	 ypDQniejM2wHEwr3Esz4TrmKbO9eGg8vA2CBwP1VUu6KIrgM6+pZSxXc1V8eHGiDJmA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793542249;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=JZh0dtB7kEzQ8t1Ji8gaTvjeVLTDeZZWpW+cXbA/soM=;
	b=Xs1kzbxEuVGMja9GAG8LeB29Q113iTPyjifeSke8WCnDRl6gxNqgLurg8VbL4+xdoZU4
	 vVXNavqjRiuJKwXUevzie7T9EiWkjJhamRDhgBXKwncfZcFmAXArENZde4wpWKL8L1SfQ
	 fYNRrFbO2wWotzky98EKI6JlrtftYZR2kLHQ6542FrOW3MauuzzAkjm/EXNntr7uFFpc0
	 F/XGwYUh3Iv1TX4tbgLddPq0xORJ4IdPBWeth0ls8facIk63UT0WDq1Wmx3sTDfiEj1o5
	 rY1VsuEy9mIol64+vVEo589EYxHQWw9rIQJT/H9NEdf06UZUiArz4zhG0+CYmH8r5nA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaP+YbmJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.169
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E76606A324
	for <linux-security-module@vger.kernel.org>; Sun,  1 Nov 2026 14:10:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E76606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LaP+YbmJ
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2e8ad5b2f61so4887325ad.2
        for <linux-security-module@vger.kernel.org>; Sun, 01 Nov 2026 06:10:47 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793542247; cv=none;
        d=google.com; s=arc-20260327;
        b=lO1a95sKCKMzSfRmE+H95QIvMF1VMtJ622Q1yC06/WP5WUW7aM8EyDL+XTCgGUqGri
         jAS3H3grgOQeFkIFMOVdEZQsxIOjdBJQ8gNcfOE2MfcJtzqWOLCs2NMHgutITREGJPQc
         Fq+6UYv5p18eWkgZyTUsLcrftXxnqmuXJHjwYvXK49LFRoqUJp+AEjZDst43jeu1+iCO
         ixQgOZdNMPas/qXjhR4Jd39HWcUP85XPw53+6NXE600MA71TIJOcj5iLzyCIBWHDpJE7
         UHJpOCn6zSs0hlwzWhu9Wcuy+rjvvrkOVkRiu+g90mg++KoY0U1+lgoa04/5HDgkma0m
         ElCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JZh0dtB7kEzQ8t1Ji8gaTvjeVLTDeZZWpW+cXbA/soM=;
        fh=LphjGaLZzbFKAm3aTRFGSBaqadpYKXoSfeZYCfA9Peg=;
        b=HYB0Dr6mGCcAfmqyPoXYgqGKtklTN6PgUOnjbMjybab7qcglxih2OIcBJEdZn2D9tp
         0X4GnrSxZGYvpLTRpnlJebGml94A9VXkzp0gQSBUdccsjT/AtT7QiPCwFt0a+vDgnDWW
         l6x6gNIJLkBX1PtBCcq5YuLnWS4jSg6fli694GutbancAjlDCAV2S0MfeAcqtrinZzKY
         pVZ7Tq/CvG+AEl63E1xTdkYVlmOOowdHJcGdW9Q+0PRW1THgUmP1PMK1V7DRXLt27rZL
         Mm80r5HHiy1I62gRTFBPx5NWXnF3NTq1FNXT1T/CHbUe5WrV6C63Y1aq9CfVRQATNI9e
         G8dQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793542247; x=1794147047; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JZh0dtB7kEzQ8t1Ji8gaTvjeVLTDeZZWpW+cXbA/soM=;
        b=LaP+YbmJ+d7ZL7RAB/xZ4Gr8/NqdeGEpalT9pkPsP3BbxkgnbfywM4i13gRyzyrh5p
         qGLcDRdKsYzTzRAwREzWCzZeUCl1JCjETt70UHuL13AoN/+SAAixYcoTu2X+XUabGwnN
         k6Y+8yRax0qrezjt/pHm0kACHTUhSctTFBTPURmUbuMWaW/BWtY5RnWeZ+yDSGhA6RPp
         pAwthZhJZJ1Vp8RPnHxeIn4eJFj49yxktPt2WVJ4ZdZuH9dWCQvCb6S/xaglr3FCh5Oy
         XJueE8R1QfX+tiJDllV4f8XKfce5p+zQ9DT5ql44O5cT9uUYSW/2ZxwnjhCPAFVHRPZ4
         1YNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793542247; x=1794147047;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JZh0dtB7kEzQ8t1Ji8gaTvjeVLTDeZZWpW+cXbA/soM=;
        b=WjjPClH8+5Gb0ktpvQ/xvDbykuZMZMQeIIVrFt2EhbCNsS2Pqeg2YtvZeopUzP2CCt
         wv6v3D/UUikt/DNtmqhFpCRIaPIGJEAuzWbRbe5MOYY8ziQecKXJOKqwLgzfttEVADm/
         NAfiI7m+3Yv43AoxdPYL045uUcNVX59Fhj+uNKMFp+GOIbnCoTeU+8xft5wjSlScfAie
         LJo1hmDRKf4rDv2tQjDSJQmf9GM786ZFwgKvs8Ip23Y3+I/8Ahb+l5K6/g/hdMcGKdBS
         9JGEmyFtqj4/x2F/g9XRLbMjVadC/qUdkJ4t3/NTXMvvRAzH5IBmwn61/InFHAF0Kk7S
         A4NQ==
X-Forwarded-Encrypted: i=1; AKwUvBw8q99LSjijSRIklJbu6UTMusXj7h07GTY3kgXtwoEGMumx88WA9yXwOXqMIwp/j976Q9qcNZz6XMOFNhzfxBH1964gMiM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xDNyNfVXxCIrANOLF/9TONi4fguKk5EblHME08RQJGShSQrv0
	5SczizwJ7Mq0OiTEZpTtZwP6BKImAGWDsfe1k2USk2g36bdVT5R7rbNM5WVR/8YNKlGnU6LCMFb
	qPTXuYGXvLGKJ9h8iJpFd/e7zcEPCIoo=
X-Gm-Gg: AYBFou2anQZP1dH+1BskXn8H8AtxmeeRDdtGgAicLVTlUUFiwmTqVSibaY2prlaiAWF
	nu/iM1MIhTSlnSDMYLBst0J7NwYdYtyBs6WmC2WGHkRhDyaT7BPbiC6He6leelKRzRcEBjHM40B
	QQWmLf7c/V5YOKAtKMrsk2gL7ZZi1M+XgaRbB99995EOXGUIhD1GYRuWfWAGDYyne0T8SxW2xKc
	LhKALeDM9NnzUgPS3JciBL/f/NCTF16H8GWLDBAbHFjie1HRbRizKjN07K2ACMM5RZgQrmH6tyJ
	PFi68mFrscSnr+ImG8gQii4sZmZUacxTT39kSHF5H+Tw6b5skC37qf/KGHyCY26/ZZugYUtjWKg
	9AWKO88Wufh5GUFXFndhr4VYwyoRCrsqhbJR11ywlAgFD+aSPCSbRVYuqdabsa1qEItS/+Q==
X-Received: by 2002:a17:903:2341:b0:2e9:53b1:a3c8 with SMTP id
 d9443c01a7336-2eb36335149mr116070385ad.0.1793542247147; Sun, 01 Nov 2026
 06:10:47 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261029033942.3644-1-q.h.hack.winter@gmail.com>
 <CAHC9VhRQ8E7zysipt3Kt44oC9m-eUc78mR5ipR3YQOwuBXAV5g@mail.gmail.com> <CAH78GvvgG0GpuR9bvM7fDDz-mpakfBuvC418-nEBUrA9pR8suw@mail.gmail.com>
In-Reply-To: <CAH78GvvgG0GpuR9bvM7fDDz-mpakfBuvC418-nEBUrA9pR8suw@mail.gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Sun, 1 Nov 2026 22:10:36 +0800
X-Gm-Features: AclHuK9N0FJ5UQy90T4KGShYVLXixh_gSNnYfvcP7CZvWoUeBSlsdGZgU1GhS-E
Message-ID: <CAH78GvsS+G8DkiZ=kuchsOp9E5FQMWc45eoBZvRDO3_Y5wvXag@mail.gmail.com>
Subject: Re: [PATCH net v4] cipso: fix optlen corruption in cipso_v4_delopt()
To: Paul Moore <paul@paul-moore.com>
Cc: netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	=?UTF-8?B?THVjYXMgRHVwcsOpLS1SYWJpbm92aWNp?= <omniameasunt@proton.me>, 
	kuba@kernel.org, Eric Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Adding the net maintainers to Cc for visibility.

No changes to the patch.

On Sat, Oct 31, 2026 at 3:22=E2=80=AFPM Qihang <q.h.hack.winter@gmail.com> =
wrote:
>
> Adding the net maintainers to Cc for visibility.
>
> No changes to the patch.
>
> Paul Moore <paul@paul-moore.com> =E4=BA=8E 2026=E5=B9=B410=E6=9C=8829=E6=
=97=A5=E5=91=A8=E5=9B=9B 21:55=E5=86=99=E9=81=93=EF=BC=9A
>>
>> On Wed, Oct 28, 2026 at 11:39=E2=80=AFPM Qihang <q.h.hack.winter@gmail.c=
om> wrote:
>> >
>> > cipso_v4_delopt() recomputes the option length by walking the option
>> > buffer after the CIPSO option has been moved out.  The walk then reads
>> > the stale bytes at the tail of the buffer as option data, and a crafte=
d
>> > setsockopt(IP_OPTIONS) buffer can make it treat one of them as an opti=
on
>> > length, increasing opt->opt.optlen beyond the valid option data.
>> >
>> > The corrupted length stays on the socket and is later used as the copy
>> > length by getsockopt(IP_OPTIONS) and by the udp/raw/ping sendmsg paths=
,
>> > where it exceeds the size of the buffers they copy into.
>> >
>> > Compute the new length from the intact options before the move and
>> > subtract the CIPSO length, and fill the padding with IPOPT_END.
>> >
>> > Assisted-by: LLM
>> > Fixes: 014ab19a69c32 ("selinux: Set socket NetLabel based on connectio=
n endpoint")
>> > Cc: stable@vger.kernel.org
>> > Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
>> > ---
>> > v4:
>> >  - rebased onto net (fcc00b15cb21a)
>> >  - reworded the impact paragraph only, no functional change
>> >  - first public posting (v1-v3 were reviewed privately)
>> >
>> >  net/ipv4/cipso_ipv4.c | 9 +++++++--
>> >  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> Thanks!
>>
>> Acked-by: Paul Moore <paul@paul-moore.com>
>>
>> --
>> paul-moore.com
