Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792687598;
	b=u40rYdgOAehn84gheUqjrjz+WncAE7P41SKwAlttGr72YV9rXMSkqHT8tesMCZ4fT7vz
	 1vZjgZ02fJujxXY/k7zPkkSYXoe5FqnqLkepqTSRwl5XG9QjhSgMHGNSv8IAkWtl1pEbW
	 Il5Jqf+ylRopmeBNC9ifdiKWzxq7XxQSIA2vTYoErDy39U951+1k8o82KB6RDIuMxouAC
	 zg2D8tJf8dAfxbWZ80GndUckrm47KX4SeGj5wHoOrlXN9op2wFYMvM8ThITHcy1FHVRpQ
	 q+TkEu32yNPO8cZWW2nrDcWgxzzRf0BYNrOwLDmaQBlDWEfJM3z6u63/5VYexQ90tzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792687598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=uWReZSZPnxFWoJInKY4s3rEgmqruohf2mZWoSu7TMG0=;
	b=ZtNXT3ArEZadx+q6NAgnC78gos4kj/wsxxRzRYSEnfKDSBM0VtWGJ2nvCIlqVC6vcWiu
	 J6o2UsvdGSN1yUZTx+EySqgtOWnHdbD/pQvXCGtNgKl7s9KMcxlAPESRfZ7DyQga2Lyas
	 fiM66uIhrsoOz66Hw0RWowB5eO1+80WXLJ8rjYSlkkJDlIpZn57kZo82lrCwEKRr/8Frs
	 GJGi0BKOaf0RolCljC0TO+qt0T0IfKJIgen1Ht4GnliprpJ4mRwwAbcv4O0IzC88RSRr6
	 ZcKjxTQOFC6d0GcqVR3CaEp+H1IneH3cnnrQU1RO1dpYNCwQyJ1mEruppgXuv5ZuxMA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GwsFZfAG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B246B606A31B
	for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 16:46:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B246B606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=GwsFZfAG
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e8d6fcbba0so65925ad.1
        for <linux-security-module@vger.kernel.org>; Thu, 22 Oct 2026 09:46:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792687597; cv=none;
        d=google.com; s=arc-20260327;
        b=asiXci2PVREflQuBIexgZ7ejlzBrrgbhp+DoY+8qgTQ36wSDH/2zL5LXi9puW7iCQs
         XwqBdRwInqphGHZFUrf+tSoZg/BAI+MynmsUiV8UTDSV6lCTZgnSaqL1rGpzBqhSEHPj
         nW8IiAC1sqqVVQJFTEoVzUI91p8gwrGjn3sJ/c0D/vRZZgQoH8mD9MjOT86AzBGwYe+P
         gsMGSExKc3ZS3OMxMbS6Jppz8NctFBi0f7R/oQADyN7Wd3Gpx+VHceZ+x92fUQDKdCnP
         vtJpUBVCyRAKbEdMb8QSEh2jDJytwunhE+cBbgSfkRQXfiMb8ybcAdp8TV2/BKnZktph
         kAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uWReZSZPnxFWoJInKY4s3rEgmqruohf2mZWoSu7TMG0=;
        fh=+smmSfOEpe+hiI4ABJT3DxyoX72ijC7KPKN39QTOKs8=;
        b=TNAWYQ4MNTWi2BFqJE6TYJltPoRoVFvKW39L2m24WOLBViCEj5I8rzB8VhYeLvPZOt
         QeEH6prpXfMSC37rKo5abPPlKzZu8MOwrJWR3JO00NnWE33qIF0/64fVUeppHTbptwnd
         SkIfgtj911BI9ewCIkwIon3Rqa6bzo/L992UvwNcwJEzbH3029VGd+SLs383/Hn/mjty
         4Fl+8eOFUSyBEYO/8f8ytHYIQc8IkdnjNHrmMfvThWXl5MjkvnhsHTuAdEFCpmPiV+K4
         1yB9h2xvWuiMGgc5yNUKEBQwiSgsmOEJpxVoQHAojpJQgx2bJOd+ZSPNY3EOrcY7ozsq
         thNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1792687597; x=1793292397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uWReZSZPnxFWoJInKY4s3rEgmqruohf2mZWoSu7TMG0=;
        b=GwsFZfAGN5WK9cknlncIZ+dExC3F9P6aYB8Y7HxgAhobV6QAQgPWZoSO354JKjEpvF
         FPWjKKUDWFpR/YFwVogODJfj5PyEUOMF2ed4wZsK6z0h0/jjE0OHp2Dne6/F0bjLNt4V
         X3UpSMUASG0FzhAq8jRMWIVOcqp0k6ZLrJ2KiPPyu1RNTtI+lXFv8RoRTXowpr3bE+Qs
         T2nwQWAFaJ/pzE9nSsvssHt7ZOMRI2yjJu1Foq78zmJdr0k4DBeOfbHt5rIHOZYLxSbc
         T22YUmHcNVpH9EqeeA3KGKLqdKdYuXVhf2cjKdTVXTRsMUbawAqtlBw5WxvgxN+WH6T0
         7aFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792687597; x=1793292397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uWReZSZPnxFWoJInKY4s3rEgmqruohf2mZWoSu7TMG0=;
        b=BSd0uuIBSUolWSam/CrRy5J7N1K6TmxBp6kn3tg4E7rKIDB4/fjrWVEm/n0e6tp5Ah
         Uc1cVdUFa77c4tYHdWJJzv6t4b6jTcDAtZXZzaacc1Nh5vM6sdaH463RFOAyRe/gKE86
         zkbw15HxGnS4fWshqMR05wKfj1t9cvcNJKe3a+e/NrlaG9iYkwl5AyLTdVOdn68tshMb
         tlVbllGWbgpkw9wvjVOwNo5Iw/kz3JqDIwAXyiMNqcgvQa0IuWc9zoe3BTY70UkUBCP3
         bJLv/65trDGqP1qbREBar0HW5XlEeckzHdEFIYdM4yzJ+J44H/uBbImTI0j/fu/cil26
         acSg==
X-Forwarded-Encrypted: i=1; AKwUvBxwPcddJeFQf9ZICsP3hfdeHDqo5gjK7sC2Njlshc8Q9Ks+cD9ELJmOildvhL7uT8NZ3i/62diXnryzbWDlUsKSTFQ2pnQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/n/COwVIIMIJMnIJvym5kcsw2bd7ufv14hsFWuKND2lQhb0Bl
	CY6Lq3BFwudWaqJURd2RouNFdMDP1k9Fexf9I8Eb64rUT0ICHh3/TJ1ZGCkSxqFvyCVuQ7pZsfu
	W9K0Me0G/VNIQ12japFZfdg0yzz4zQga9Nyc6q9Mx
X-Gm-Gg: AYBFou0vc/NX1yHyUU8Y6RGriNVterTuoWjotI9OGnKMnwDfLgafXyLFy93zb9ELPoC
	atNykeN0iLbw8DcGdy3oKwTXoaaDWjev2u90kg8Ao663p2/0t4f/17B1Q93L7sKuriXjHRB+qyv
	lYyzng9K9BDSSat4rjRKVeraMYqnfESBTsh0wsAqbRtYIqr6NP7utn9mKmGciesnWPjF00vOXe4
	dVP1nXJlXVCx0WTqXMJbtE4emfM66yf/oiSiHs8uF+Y+3sS2d6CgttXgFX0FlPUa2cPNNxMVTLR
	1l2+mQUNYOHhWA4wnC/NfW2krmLvRiy3H6Ef/zjucwS4GYHSzDcQFXIo9w6ObfY5T59E8KltW4p
	RdFBtHTh1h0T4booGQv0Zlu5/Wdrfn9fY7wNuNhdypw947AQ6Xj973EES4U754BoO8XKxuE7eir
	o0TQujMP5CvqicMva/7kyqsA==
X-Received: by 2002:a17:902:db11:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2ea63088254mr5085175ad.2.1792687596491; Thu, 22 Oct 2026
 09:46:36 -0700 (PDT)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021162538.1852602-1-mic@digikod.net>
In-Reply-To: <20261021162538.1852602-1-mic@digikod.net>
From: Jann Horn <jannh@google.com>
Date: Thu, 22 Oct 2026 18:45:59 +0200
X-Gm-Features: AclHuK9zuGI6ax3vqvDDohM9t-hsk36f5joo8NmHv8Bwy_LXI-q37xMxgIQtv9M
Message-ID: <CAG48ez3Rptvjvt=t_YEcBHHwYGD4zmPtc6tk+gPLtorZY7WEFg@mail.gmail.com>
Subject: Re: [GIT PULL] Landlock update for v7.4-rc1
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Christian Brauner <brauner@kernel.org>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, 
	Haofeng Li <lihaofeng@kylinos.cn>, Paul Moore <paul@paul-moore.com>, Tingmao Wang <m@maowtm.org>, 
	Wang Yan <wangyan01@kylinos.cn>, linux-hardening@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 6:28=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
> Jann Horn (1):
>       cred: clarify that task_struct::cred is only for the current task

FYI, that already is in mainline as
https://git.kernel.org/linus/b030ffaedc1d638f232f6992406cdcdcc82d5602,
it went through the LSM tree.
