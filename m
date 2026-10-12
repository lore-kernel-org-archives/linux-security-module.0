Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B5369D64
	for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 13:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811858; cv=pass; b=bbPx/L5o7or1cbfuUZJEl0QOGtgh5dQ8RPEd47PnyQNWMMOmEFGQARIu6Sv+ZStK4VA3WLTtBBMMATGCgxSl1B1K/6X22bHMqck1U6m8BupfSitouSgBErS4YjxS3M2o3iCNj0tK35nYSWA7ywTyCBGbh6b0+1s4pmiErqtD3IQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811858; c=relaxed/simple;
	bh=EmjxUhPi9se44vvqI3S6zFF2XZYXEIws4ovhrSHoy+g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sdSqAw8zjJDhJQ40idt+z/lxSqok+MrZXrj3P/6f9D/cW2diDORshemUtR2Kn2BElQU+XaLzr9qM7+Cx0dcwSbHpbh5DcpzTbqBEYRWytJyP3auN8v2Kh3YSVSx/PDFIk4Zap+SKmPyEY37RhmJ2dBMh5+iA+0aT2Mq27WHQa4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=To+M7vtE; arc=pass smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="To+M7vtE"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-8ac4806e210so11144887b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 12 Oct 2026 06:30:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791811856; cv=none;
        d=google.com; s=arc-20260327;
        b=QqxHKfKIS5dPA0P1N1NPKuZHD6s6xMdGKBZE+6MTDimj+C7In3M5Qqp8XB9IWKq9cd
         W6mi5Lbn+2+JIpcV72oaYV8PHHewqZr7z/JaoUhY79f4bJDGupprYHXnR6udNqivG7cy
         Uqs8M80LPwv2YU7yg3Lnyj79plgdoPscayB60goFVUWc+6WglpMsneEr1NkeBZy5NXzr
         l0ePcb5CWAVMFs8g0GL2ceVpHaNobHDWUyLu/0ounSSaB6VsRlYxiYCZhem8vyOjUFIx
         ceasFc7y6YlUVkoZR11YWjtBkGpioyyF7OhSCzo/Ns3eCrhAX1I+ECTvz3g6LB2V+ZLd
         y1hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EmjxUhPi9se44vvqI3S6zFF2XZYXEIws4ovhrSHoy+g=;
        fh=xjnXBCcarQvs9b7wkAbqF8Ozezke+CprWH0qCkk4V+4=;
        b=OAfqTD6GC5SMc8slwCSA3z9hYKBNkFDeCAEcu66hfIjUlG2OXxIxySZc030l6TOCJi
         ToTGmHUvQi5+wE8qs2KOEnfsco/Sq9ziTRb/rJeQ/S0ne/CDBvaE42cZS2BN3QG3haGp
         hi7miPfihLGcJYpLjGi1cWEjKLGZebbpDI/X/3dFkxEJCKZ1ng5qDljyeeM+BzZ0jJDN
         4srWWMDb+CBhQ7VWYzKv29g4+CtMXDqsZrFXdsO6QRR5y5MTP4LP0Vj5ktK5ww3VzOVN
         niKZoo5Wk336zjvIncbpBvCO4Esc3TD52+mLgu4BBHfil7XaX6AkgSFnst+xMgooJGYs
         W4kg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791811856; x=1792416656; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EmjxUhPi9se44vvqI3S6zFF2XZYXEIws4ovhrSHoy+g=;
        b=To+M7vtEZkHjvtni0GIsJBcpb0+VCa/dx3mQlJluv7Qpe9ljPPgmqRSrKAo/OZ99xL
         3jM5alSXRo2mXSMvFY2cShficiN3ssbSKnQplu+kzxCjE8+VbiZ90UFLksVHJG6ul2u2
         c+ZObO3y8ocMfuoRfHUqAplNQgNZrVWvFRVXVffPRtSiNgA/I6FVnWKv/QTS3s6V6P3k
         U5a4GqYXtC3WUOu0wSaQRNagJJLOGHkLi1SVwrCchuWIMFAUOFJe795cA8WdgDa94gcC
         pC1lApWtK1n+JvxyZK8gXSrDpUAwYE/utCJeTMnOv7a3LGsp5hiKQqpeBgIZX+0fZdo7
         ofgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791811856; x=1792416656;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EmjxUhPi9se44vvqI3S6zFF2XZYXEIws4ovhrSHoy+g=;
        b=1JsuDjtNb5LT/Rnxjg6URBBamPpOX38PqPCArU8ayQS7XD68R7FblNJ/NCS86f/ZZ9
         gmgvSMUD8Xg1+gBA5QLQi3662hvCrS7MPIc7p734lwZ1v3KFSI7go47WIcpstJqMKjF7
         ++KB7XoOZl8z7wBXaDj5h88TADG/Ez0PSsrOJ+yXpFS7j3xgLGRrLlrz/jH5Jz2cK3UL
         bkggeSAY9AZfoQl60DNw4kyqQ+ddSdTT29OJYeywvU04mLvKf1AOFPVnSUUOlHNoE33J
         r36YSwgnVrSJajVYCnALEk3U8F106TTtKuIRMni3rJeFGuZkqygvowp6KNBPR/D4Z+LS
         eXcg==
X-Forwarded-Encrypted: i=1; AKwUvBztazZ+ncrT3CFmGkjC98D3lwuIyYMX0bxXcvlvNu2H9DvtrfovZvHhYUqBOmGhGCIOEGwG6VUQLjZrmnSrmoHxnwgV5Ns=@vger.kernel.org
X-Gm-Message-State: AFq9FYI5pgu3lQaVwE3MRiovGU4EV7rRVNPvV/RDD+rrQvUt2s4c9bJU
	ifr8JPEQR31f98qTr/SvFuedMomd+qsuUnUtOv5j9WgdJBFbJCBI5Cbw8++X5TWrNmul8uiDZ5T
	ok0zDpvaruec35//TOg3Y/CWxYkNS1JY=
X-Gm-Gg: AYBFou2jqqjv4Aw9V9ig6SzKjd53leuksPByM1BpS+XXVyR4fAk9qzLc3UEuFcojSdR
	kb4P32ePrZs0fRJSe/y0HKgGMhkjggQoLwjjZT8ikPUYIFDfKIFt7pRGOm5BYnjai88mLfes4Ag
	VMFm9EeYsp4tyCuJ8DFipDQA0OhYfEZUOVwPmXJUeuoJ+xLyT76KivkVc8KuNm6cU/OozdZnwo+
	LnJK3ENlIqYwqx/xHrQvVANeyOAvnVAKrRdInvLeZ3Bb+xByj4B/MzHgK9cnDKyT50EqNx1P8vJ
	lRWYcv6Zk8+eplv2Tz+TgSlG6mUIY/GuHLOgYzxsXH+qfh4XmzXybbYOSg==
X-Received: by 2002:a05:690c:d8c:b0:866:7724:3bcd with SMTP id
 00721157ae682-8b07ed1e667mr44288127b3.16.1791811856206; Mon, 12 Oct 2026
 06:30:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pm-key-management-objects-candidate-0001-v6-9876bf3e2116d47c065e@gmail.com>
 <aszZ3KPvMMHLEJ0s@kernel.org> <aszalro6U6BFO_D3@kernel.org>
In-Reply-To: <aszalro6U6BFO_D3@kernel.org>
From: Cen Zhang <zzzccc427@gmail.com>
Date: Mon, 12 Oct 2026 21:30:43 +0800
X-Gm-Features: AclHuK-JMVmEQk9s9PUAJHaHm55xlb-Is6siTbFN4AUKpBCWpjVUnqE1DSSZ9Ps
Message-ID: <CAFRLqsUB0MQRoCHg8cXmyofWqbDGyvAr7vV07i0jUpMnSaksVQ@mail.gmail.com>
Subject: Re: [PATCH] KEYS: Protect user key quota access during instantiation
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org, 
	serge@hallyn.com, akpm@osdl.org, keyrings@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	baijiaju1990@gmail.com, jjzuming@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jarkko,

Thanks very much for the detailed feedback and for your patience with this =
:).

Jarkko Sakkinen <jarkko@kernel.org> =E4=BA=8E2026=E5=B9=B410=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=B8=80 21:03=E5=86=99=E9=81=93=EF=BC=9A
>
>
> I appreciate the fix but if I'm completely hones the commit message
> looks like direct LLM output, which is not acceptable.
>
> It needs to be proof-readed and edited. For this reason, I want a better
> iteration before I apply this.
>
> Br, Jarkko

Thanks very much for the detailed feedback and for your patience with this.

Several people have mentioned that my commit messages look like they were
generated by an LLM =E2=80=94 and to be honest, I did write them with LLM a=
ssistance.
However, they often gave me the feeling of being questioned rather
than explained.
I spend most of my time looking for bugs, following my interest, so
I=E2=80=99m more familiar
with bug patterns than with the deeper details of the subsystem. That
means I can
make mistakes. I=E2=80=99m willing to listen to feedback and keep revising =
the
patch until it=E2=80=99s in
good shape, but the pressure sometimes makes me afraid to continue the
conversation,
worried about making more mistakes. Your patient explanation this time
really means a
lot to me.

Of course, I also fully understand that busy developers feel
uncomfortable when seeing
unclear or poorly written messages. I just wanted to express my thanks
for taking the time
to gently and patiently explain things clearly.

I=E2=80=99ll carefully rework the commit message following your suggestions=
 to
make the concurrency
scenario and the reasoning clearer, and send a new patch once it=E2=80=99s
ready. I=E2=80=99d appreciate it if
you could take another look then.

Best regards,
Cen Zhang
