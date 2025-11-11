Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCD036C586
	for <linux-security-module@vger.kernel.org>; Tue, 11 Nov 2025 16:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762877706; cv=none; b=jvc7GTBsF5/YWS8OoKjZ9DBDTZPYAi5RQ/YRdrh01U/erHxEwR5mPeqNaCgqCuk+W1Sbzvh3JzD/K2018Ejt58CcfRW24PVB1gT+WxWhmrinf852Ebxsazl0GbYAo6ohOiQifOdpAaSS4zfLMlOrcv4apB5eABjplmYVNAOYUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762877706; c=relaxed/simple;
	bh=CAzz4tdO9jRd3NYeIx+mzCdWu/XNR9YZQNSh6xs3tkM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DBrGt97Q/poVtraHpQorxm0zyzTPmpDr2DhTYzaCEAa+KgfXZFhCxQfOOatru1qBL+At5wFYqoMXB5gY79XQNDrlJ6l4Zrzc76wiEn38VDxgPF5JudIMmJeRFasKEcw0AQZZ4kPrRM/yvEXXStXTv+8Sp5CMYpbDYM5dHeb9MXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ShpdqHqd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ShpdqHqd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762877703;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CAzz4tdO9jRd3NYeIx+mzCdWu/XNR9YZQNSh6xs3tkM=;
	b=ShpdqHqd+rzXQjaYRwkTL8gcJ24Pgkfs9TIw6ziKC4xuK2NdrxtcRnkVHXUony4ixqWMAZ
	T+pG42eOOzzv/Ga/HnJxqzdBHw9Xy7bvHAYjroeN7yIJiOhyFSssJTpSKgRtbqnqry6tCq
	ju2Co95NeFB89rsiYwwfkIYg1M3KAPM=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-pZ5fjWXSOXmjzVRUilV-Cg-1; Tue, 11 Nov 2025 11:15:02 -0500
X-MC-Unique: pZ5fjWXSOXmjzVRUilV-Cg-1
X-Mimecast-MFC-AGG-ID: pZ5fjWXSOXmjzVRUilV-Cg_1762877702
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-8b1c1d39066so1110014485a.3
        for <linux-security-module@vger.kernel.org>; Tue, 11 Nov 2025 08:15:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762877702; x=1763482502;
        h=mime-version:user-agent:content-transfer-encoding:organization
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CAzz4tdO9jRd3NYeIx+mzCdWu/XNR9YZQNSh6xs3tkM=;
        b=Y5VZd2m2ODZsT2Wm+dlt8fLRoX3+8A/UAVqU2cH9y+OiPkoyvoV375jrYXTcMBU24w
         BW00Jeh7X9j5DVMjCJoV81BRWRiZQ9htckJ7fYcipsWtMBaBBGk4NOpbUbU5hZ9Z3zUS
         NJideWwKSnK2O0rRhM2lGEeBrdWNzUA14+O5g7wZBn5OlWhj4+ZYtk3yeYj+dUCjOkaI
         gbyhx94u+mnSs3I2z2yyzmG8kdvzjARwYQT8p/E5ySiAmuV4zrjeWmS3aynkgxXgVuM5
         pD/qyeNJePKviFt3tSUnioTk0RtJ6jA8ETevAHaGHYsvYyTr4+oynCci4zH10EC7T7zB
         OjWA==
X-Forwarded-Encrypted: i=1; AJvYcCXfblg5d9ADwA4nkeHvHOAewwjdXBD0h57Jg5K1QfIEfUqlKzeRp9wmq2CRjE3oDwS6BSjz/uY38AYwpvVreiLICC9QqoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyYu2XPIhbAttSmvPpA7W659z1dLithSYpU0jMXLCP5aHyyfRe
	nNLliY05QmlK4NtegV5v5GpL14AOoJC7KKPZOkZgRlh3lybZSfRh3BhGWt7ynKFT9RyhNCVHgn1
	gPdT+V22O6C0fuYVyJQn/x9ArSVrT3Vs0WbZgym1+Ba1A5MHPRBe1IUsCrg1RbdT7VFGk8tSRx7
	1/rA==
X-Gm-Gg: ASbGncslLMD+ES5fpWtWIYnRQxv7dNtCrWUiio4C0HH5hIjP/toeefCjurG7VoE2Uf8
	mYak5vJij6H7BE4CUKOK/N6ddcUi2SkQEe2gnqWnT0RTcWDpdNetHA/iOrACx9c34TLD81FPLQP
	x7J70/JzJ9od/y1c2pQtdmS/XwnoOYdc8fFrB1ZSlW0Iv2oaD8uLiGeUfUCiEXVWqU8GmdT9Vt2
	ZfRsjXOWHISMRFfP8/Krz7oAs7F+lSnbIYbDSfKA5aTBSVCmJl8GShIilWFSpL7uGc9OMa38tA2
	XWjBeLY8fNowflQeE5SZE3uUOaHlFidBYiWTHmzTgKx58FzS7znluO7WlCQN/Yiz9OehIQ==
X-Received: by 2002:a05:620a:6914:b0:8b2:1f64:7bc5 with SMTP id af79cd13be357-8b257f69f9emr1539504185a.86.1762877701872;
        Tue, 11 Nov 2025 08:15:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGZzM88+sgVGmR4fCbMdvG+bTstulnQHQtfzsOqHKlcvJHTzfGD4ZKhDU5deE0z92drdTBPyA==
X-Received: by 2002:a05:620a:6914:b0:8b2:1f64:7bc5 with SMTP id af79cd13be357-8b257f69f9emr1539498485a.86.1762877701360;
        Tue, 11 Nov 2025 08:15:01 -0800 (PST)
Received: from m8.users.ipa.redhat.com ([2603:7000:9400:fe80::318])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b29aa25791sm9814985a.52.2025.11.11.08.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 08:15:00 -0800 (PST)
Message-ID: <1ce413b202ca7c008e077a6f1cfa88f94a3a7cbd.camel@redhat.com>
Subject: Re: Module signing and post-quantum crypto public key algorithms
From: Simo Sorce <simo@redhat.com>
To: "Elliott, Robert (Servers)" <elliott@hpe.com>, David Howells
	 <dhowells@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>, Ignat Korchagin
	 <ignat@cloudflare.com>, Herbert Xu <herbert@gondor.apana.org.au>, Stephan
 Mueller <smueller@chronox.de>, "torvalds@linux-foundation.org"
 <torvalds@linux-foundation.org>,  Paul Moore <paul@paul-moore.com>, Lukas
 Wunner <lukas@wunner.de>, Clemens Lang <cllang@redhat.com>,  David Bohannon
 <dbohanno@redhat.com>, Roberto Sassu <roberto.sassu@huawei.com>,
 "keyrings@vger.kernel.org"	 <keyrings@vger.kernel.org>,
 "linux-crypto@vger.kernel.org"	 <linux-crypto@vger.kernel.org>,
 "linux-security-module@vger.kernel.org"	
 <linux-security-module@vger.kernel.org>, "linux-kernel@vger.kernel.org"	
 <linux-kernel@vger.kernel.org>
Date: Tue, 11 Nov 2025 11:14:59 -0500
In-Reply-To: <IA4PR84MB4011485C0EFFFF9F2820A1BFABC1A@IA4PR84MB4011.NAMPRD84.PROD.OUTLOOK.COM>
References: <IA4PR84MB4011FE5ABA934DEF08F1A263ABC3A@IA4PR84MB4011.NAMPRD84.PROD.OUTLOOK.COM>
	 <501216.1749826470@warthog.procyon.org.uk>
	 <CALrw=nGkM9V12y7dB8y84UHKnroregUwiLBrtn5Xyf3k4pREsg@mail.gmail.com>
	 <de070353cc7ef2cd6ad68f899f3244917030c39b.camel@redhat.com>
	 <3081793dc1d846dccef07984520fc544f709ca84.camel@HansenPartnership.com>
	 <7ad6d5f61d6cd602241966476252599800c6a304.camel@redhat.com>
	 <69775877d04b8ee9f072adfd2c595187997e59fb.camel@HansenPartnership.com>
	 <3d650cc9ff07462e5c55cc3d9c0da72a3f2c5df2.camel@redhat.com>
	 <534145.1762588015@warthog.procyon.org.uk>
	 <IA4PR84MB4011485C0EFFFF9F2820A1BFABC1A@IA4PR84MB4011.NAMPRD84.PROD.OUTLOOK.COM>
Organization: Red Hat
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O7wngQRIFmQ1pDM46ODOF38M5hZbgRU21JdD1HMRfLk_1762877702
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2025-11-09 at 19:30 +0000, Elliott, Robert (Servers) wrote:
> The composite motivation is to provide some protection if someone
> discovers a basic flaw in the PQC algorithm. If quantum computers
> haven't arrived yet to break the traditional algorithm, the
> composite still proves validity.

Given you quoted me wrt composite signatures, I'd like to make clear I
do *not* necessarily favor it.

Unlike regular software or firmware, kernel modules are generally tied
to a specific version of the kernel, therefore there is no real need
for long term resistance (unless you plan to never upgrade a kernel).

If a defect in a signing algorithm is found you can simply distribute a
new kernel with modules resigned with a different algorithm.

The problem of using composite algorithms are many:
- You need composite keys (or at least two keys, depending on the
implementation).
- You will pay a higher price in terms of CPU/time for verification for
each signature.=20
- You will pay a higher price in terms of disk/ram space to store
multiple signatures.

It is generally not worth paying this price when the remediation is
easy.

--=20
Simo Sorce
Distinguished Engineer
RHEL Crypto Team
Red Hat, Inc

