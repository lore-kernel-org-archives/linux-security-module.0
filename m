Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFCB345724
	for <linux-security-module@vger.kernel.org>; Fri,  5 Dec 2025 16:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764953890; cv=none; b=lBNhXkbLaR5Tx/K5L2DppbegJIO+cZT7o/C+XiA3oporsRIFk9WqJ0WB6Puu5JGFQutdqbFBUZa6jHckIn+kmClWLrZgZZBLUSMoi2Fgdw0yYRmIZR+zjCmzJwF6YLdmBvLZutyqAII253fOBK26EvvhQr4QibjHoV0WBhbm9Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764953890; c=relaxed/simple;
	bh=GUXjWqQrXR5tbeayZTPHGzNJL057n7dY+SwgT4JYN9Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fExvHT15ibhURdgFMXwwchbdHtGa6bh6SC5pVt64HS8OfkNaMfElWZFFuoBi8xffWBAUSFXxZF/d9OAmgNZcdzepiM6hH3sBPkPiNmj/2Jb++0Bi93p+cyWDDhRi23oPdJ4OTguA8JAqydDfA1BUdxuyr5nS2J+DGZqIg4Ezsn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=IBnn2A85; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="IBnn2A85"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-644f90587e5so3557062a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 05 Dec 2025 08:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1764953880; x=1765558680; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=d1BXNXF9/SCbBa4W+p7Gu1WGIc24DxvdSo5Sv8osjpo=;
        b=IBnn2A85Xe22p3QBn0DbwBCTV3nEZpqulVdLgE7zM5Xx/NrxJGYFg5S7Nwr5FDjNLh
         ldVC7Q265M5iZXdyGhQsK4JLauZ7xGgk7SE6lvlUvpxT/Bu8YjJENKth1QVdlrzGWu+N
         6lMe9s6KeCsFF5vD9PtXNA+XLRxrWcCrLevgo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764953880; x=1765558680;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1BXNXF9/SCbBa4W+p7Gu1WGIc24DxvdSo5Sv8osjpo=;
        b=cm08a13ejSLPohWwpu+7eWEcX3K39sjyQXZyGzOH4THO0+4aa/TuKP67wy4cYBLwwZ
         POlTxP7Exl7lH3P357uCerpdY02gzhNFb6aEgX1OKBnUK9PrcBA7nNj7CgqXo/ijjraD
         WvbbZRQzt67oyHgGxyu57/tu7khcPOFmeQGLVt4Rusr7C1xs7nz8pXy+BqTg7V+fYJh6
         Ex8uLarKOJmhHkvkKxBJXdBki+i8xtCDREdlgv1cPGKKNMWRXm0K31/ptZRuMZ5nsubv
         53amfcS+2X6pTBS8LwWxx22018b2G3izGfkpI+mHA1jFeEigGusG9NJBoC82PJS+TRj4
         c7xQ==
X-Gm-Message-State: AOJu0Ywrd2ToRfzgaCxyZwJJmJLVU3lBsPGOLZjYaIyuNn+B45zW1XKl
	m9J6+SVeBUzoEJoRVYwrxljkxiq68hpMD9ffdfZsGY6SIzsPEo/Ele7ziKKt27PwatciFzn/Lp3
	gpcx/Zqw=
X-Gm-Gg: ASbGncv5sn6cIpkq67ziVYBupJq1IKfai7NSIKKkYlrrUz2GRef2J6A3NEpKwOQWsxj
	BIukCZkxnBSEAx2q9MnL+qSt72hEtlF39333RdmbkK++83eJ5oFITyTzW84bvdzf1pC2bXS/j/s
	NDBpWO9aM8rL+BY77qD6HgcP81b9xsqwIHC3+UB3kYwvOM2z0VX/M0gxxEgHVwZtPAbuKs9cMvc
	HA6yRxxFJWlhJaK8AurDTxUoTeYXWtFx1h82K4CsQn4GT+zM7lHNH9jVfPV7Bl1oAuh0RVehQnU
	pFjlDxw6K2W0xMi+8JAngcv/ijPa88YyuJHNvOiJEYECRzN5s+/9vZBz50gogYVwQPSeR8KKpvh
	qSD0sBr/TaJqIFPjQN4WnKqDAvLGfn8s9CUlPVLBLd1hVfwxZ0RU72Odk1ZgrdZIbKK3Axy06kd
	caRzwZ4EBrh94e1rzsGIho8Kh8Kq0QuW4JhKA9OpprkvcDJQuT0VViAhK3Fhs8xNOI/cL8qwY=
X-Google-Smtp-Source: AGHT+IF/9OnToRhTQKLFjKXwfcHHYiZPKBA16yl9Ayd0bP+U7Tt9OiJIF+zD3Yk5IzNkDznwY1HrOQ==
X-Received: by 2002:a05:6402:430a:b0:647:a636:76c with SMTP id 4fb4d7f45d1cf-647abdf82e3mr6160118a12.31.1764953880514;
        Fri, 05 Dec 2025 08:58:00 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-647b2ec2d8csm4273587a12.5.2025.12.05.08.57.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Dec 2025 08:57:59 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-64166a57f3bso3832444a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Dec 2025 08:57:59 -0800 (PST)
X-Received: by 2002:a05:6402:3508:b0:647:a2b2:3db3 with SMTP id
 4fb4d7f45d1cf-647abd992c0mr6370909a12.13.1764953879103; Fri, 05 Dec 2025
 08:57:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aTIm6grHZUhRncFH@mail.hallyn.com> <CAADWXX_rO42NznU6c+rjqzaUuTLMp_DXSf_mn8rVDCe+1AMUTQ@mail.gmail.com>
 <aTJi1TunpnTguOtm@mail.hallyn.com>
In-Reply-To: <aTJi1TunpnTguOtm@mail.hallyn.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 5 Dec 2025 08:57:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgxM=an8or=+=vwXbLou-ApqV-rJAsqNt4+jCd3y7vfbQ@mail.gmail.com>
X-Gm-Features: AQt7F2qk-xg4DRrB_IYZ-uoc8xBeMlNnXa6Oc6nQ-chtduJhri9vARFZHm00u5g
Message-ID: <CAHk-=wgxM=an8or=+=vwXbLou-ApqV-rJAsqNt4+jCd3y7vfbQ@mail.gmail.com>
Subject: Re: [GIT PULL] capabilities update for v6.19
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: linux-security-module@vger.kernel.org, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Ryan Foster <foster.ryan.r@gmail.com>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 4 Dec 2025 at 20:43, Serge E. Hallyn <serge@hallyn.com> wrote:
>
> The odd thing is, when I send emails to my own gmail account I don't see
> any complaints about DKIM or DMARC, only:
>
> ARC-Authentication-Results: i=1; mx.google.com;
>        spf=pass (google.com: domain of serge@hallyn.com designates 178.63.66.53 as permitted sender) smtp.mailfrom=serge@hallyn.com

Yes, that's what I see the headers say too - but then in gmail if you
go to "show original", it will also say "DMARC: FAIL" at the top. So
gmail seems to internally consider "no dmarc" to be a failure.

Note that it's entirely possible that your email was marked as spam
for random other reasons, but I've seen this thing before with other
cases that don't do the full dkim and dmarc setup. So I think it just
raises the likelihood of email being marked as spam.

             Linus
