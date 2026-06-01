Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBE636A354
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780355631; cv=pass; b=AAqG/UfJzOOCtpZjfyHIqKBSBmTHs6yQbp3Tq2PT1cRckF1jw8ycxuIfajwkIJUcXJ/xkLfwgr85Dku/3SYG7HBN4w+F4pzkwGRTXT0A9qoKFyDYJSqV0stQxrkvF7sEAvY1obaCBSmzZ6Z0Agz1Z9uorH96VD2xUoMYDYVoegg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780355631; c=relaxed/simple;
	bh=aHqU/GAv+Kwj1BqBbcVETpbD87Fi+TBisbMXFFy+wTs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i7/dv4DCffpk2HGir+WWBdOLvEq6uioJ7k1b3/3wl+OYJ3THJNvVGpaBHuruEahOWnUOtUxQ/nV2iqj67tniWYTNLj7OmZItMGF7qDJRw4l3r6I5QY5hxx0323CF62E8Hmm3clYkrpKdXHqHdbZgeMKU7sDb8BelXYL+dTAgAWs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LnIjykco; arc=pass smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LnIjykco"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2c0bb4a94b8so14521975ad.2
        for <linux-security-module@vger.kernel.org>; Mon, 01 Jun 2026 16:13:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780355629; cv=none;
        d=google.com; s=arc-20240605;
        b=RfKhUOfkovBHJ6qshF9lkd3gJv/vYw82tjnTTbyfgrO47a97p7Gbn4JEi3Cz6FzXfQ
         uvoZYFjgFrItbB2jE2d4r6EYkvAoNblMONjf9S3hvPMiObXSp5g4l4hsr4iHQzRXIubO
         /o4S2v3a5hCloBMEyK3QrzmYK5xnD2V9VfBz53/xFtJyt/eGwC807iG/Cm0nLoz+SHOf
         kr1FGnh5hguE07RssK/N64thl0zV3fR+Nv5tXm2oMct9T/QZ66YPm1FwXCFQ6Lp8ec7K
         GCP4l+eH6LmFuktdUa2FxuXxJJgBUuYzVjxRSivcyTYZRUQDwOQVeUWVoGFk+n6oe05F
         9pXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vz7MwT4u5UsOtiG3xQsmDxW+jD8LsxAD2bqnbWJgenk=;
        fh=0xLuOxb51Wr+LnIdV5coCfFs12kNc3JH5aM5z4bZF4M=;
        b=j7xPlXGH+gwbxvsz2sJG6u1XEXAqAyGbvIPtUYaU3JyBgODmFoGfa+6UN9PKbzzrEy
         DrtTD8H6UkRwV17sI8OfH68I38PcbTstDRKEMOygvlJ0QQuaBw2lczjc1bqpfeH9gaz0
         sfnBj3NlPdVQBHZQkYGSLNpjC2ECPBbPRsP7jjQw87HU9jweP5Z2mD+mxNwhcOvjOjk9
         ftdTyZTjif1vYJz1Umihn547n1JYGsUXE4TR3qbEwWgkM0f37o/8ZYt04P7ARomsDOBY
         yI4Hg/2RZwfbT4J5LBUlc748TV8l0AWOuCXD6RpU4ZyUq06iokoO0QmtD43Et2mDXmz3
         twrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1780355629; x=1780960429; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vz7MwT4u5UsOtiG3xQsmDxW+jD8LsxAD2bqnbWJgenk=;
        b=LnIjykcojR6vyy08kHpOWVWsSFeDXGxpMMVde26QTGOjhFB60YFvmGgjCjuRfUuzFS
         J4NUevoyFi7xAgvDJeQjjRAuB3AxsbOb8aEkXZomD5dsOvR0G+tPFCCr9dkq0SLSz9TF
         YxhMcpdgKDKOjSdPI4sB4izsz9o7enwjLhNnEs9sdz8UGE5UEYeImQiB0DoIuLBf2iy/
         sRwWZKExf4h6mEZ92zOV9P5qXShSzvqGWFBpwPO7+a1/jXhmZuDSd9dsufalQP7hokiQ
         g771zr6u0J+RySuiC3tKdFp86Hg1O+1juFHYhY8i2pM8vKXcpaw/69fa7eG//m8ITQkp
         nA/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780355629; x=1780960429;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vz7MwT4u5UsOtiG3xQsmDxW+jD8LsxAD2bqnbWJgenk=;
        b=I7O81N8YPsy0LZwaKIxmUcHwtJA/imZG+dUp344kBJCpuwDZ6LT0b/jipJzFIPS5m8
         zv+SGFqZryiCXX/5Vs8e41Qg64aS1yD96PgYneQiMrcehysCGZP5hB3NAXVJBqDbYxfB
         bjKyKyasy9jplzK7KIJL4/UWRMnh4qp54k7pqVa4DBo/z+TkgT9xDMo9jeEamEv6vzt+
         9hk1A3WI96qs9q9UPuj09gnv+NqebyD44SrV6Yn0b9kDJZQ9Cst1g/ldHDyO1Wlo9u4F
         X49+qCRb0ghbhuHUUC3itujNN2I/Qesil9UeujEtMpLVzfX7Vij4SmHDxJ/lpeLRRZ/B
         oQCg==
X-Forwarded-Encrypted: i=1; AFNElJ8lGChTjTkfaYzgN2vAVc4dGqV2eYUZqrT0P7Pjrg4yOWpU/xwhEF4PxOv+wO0LiNl8KaWVinXqOPO4jYfOrwyiwaC2zoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVWWjLGWrEZ4gmE1cnqymRwdUe7c8TSAp9gq8qJ0Uf4aXhWygg
	BQv1NmWG1DFBsEf8Vy34wg2bxvLOYBF+JI5xYcpt++uMnQvVAf46jv7hWUqOSc1pNz6SezZzO7/
	u13LKw0IlpnPvNT9NLkpzjbhfN/5jkuCNBQq0t8xJ
X-Gm-Gg: Acq92OH2mAq6vQC1ttE+F2lAYHv2a1srF9rfxRYuwgKAWMneZgqvfob1FWb3rcvUpHv
	mYCVeVQ6p0vTGMjIa9d6c1nhEL8EorZI4grcnSmV7BnHbAQCZsEdE8GkHABJJdmfr01ZwN6+zC7
	N9PPh2sKOtzBI7/lvwefqGOMYQplB0Tuv3QYoALZ5PGEKtEYeJSpONG8ZOylxJU8Va5V7tu3uj5
	3RvUEBUnfx6rvRAaE8HL8c8cDpljFzmOo8RPmcXKbXH6YdIVk7Pb0Nlqm6kN2CBo9/5EaECe3I/
	xqFyaGiyOWl5wiJXn8KcFRnStpx7
X-Received: by 2002:a17:902:f64a:b0:2c0:c940:dc1e with SMTP id
 d9443c01a7336-2c0c940e206mr79129685ad.20.1780355629409; Mon, 01 Jun 2026
 16:13:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260529-remove-task-euid-v4-0-07cbdf3af980@google.com>
In-Reply-To: <20260529-remove-task-euid-v4-0-07cbdf3af980@google.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 1 Jun 2026 19:13:37 -0400
X-Gm-Features: AVHnY4L0VLMjaF6hJi9yQFqw7kmnIWO5yk2GkkTGfjEcklH1ybYU-qiacr6meWU
Message-ID: <CAHC9VhR5Ca+WyP2OiNGtL1SqHn0SwLe=M9SB8D2bxtdS52quhg@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Delete task_euid()
To: Alice Ryhl <aliceryhl@google.com>
Cc: Serge Hallyn <sergeh@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, 
	Dongliang Mu <dzm91@hust.edu.cn>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, 
	linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 29, 2026 at 5:33=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> The task_euid() method is a very weird method, and Binder was the only
> user. As of commit 65b672152289 ("binder: use current_euid() for
> transaction sender identity") Binder doesn't use task_euid() anymore,
> so we can delete this method.

Given the problems from last time, it seems like it might be prudent
to let the commit have some time to "breathe" in a proper release, I'd
suggest merging this not for the upcoming v7.2 merge window but
instead waiting for v7.3.

> My suggestion would be to merge this through the LSM tree.

That's fine with me.  I'd also suggest updating the commit description
in patch 1/2 to indicate that binder is no longer using task_euid();
it currently reads like it is still being used.

--=20
paul-moore.com
