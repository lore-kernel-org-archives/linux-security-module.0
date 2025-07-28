Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7495C224B12
	for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753690628; cv=none; b=iQBHmFYKcNWvcA4av+7GRdJHswocgyeE15bAiv/YS/xlY6G5o0dj0wl5pgExlmu8zxvzTaJTWwwzHDamrDPpd3mFaia2dd8r6J98nxRGWKjVLtngobxn6UGB8QTG9vJzs/h5uzKHQC6ksZZuv0fLQkdjTVaLUuam9y4QEOcLRtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753690628; c=relaxed/simple;
	bh=oVOsc6ibl2c4BxKOGSlypnNZvk85m52BrD53itvnuCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FljIumcp9xoNfi3fDfwZ1tJeuUYz0xbcUu/m4Tatb40FzQ/GFA4iNxmfeD4lJzAqGEbE3XCG2T1GpCZffiPDrcvFckHrGs7qisTWf6+b1zjWKxvbpJjTYqOyPaLabOzvmvS0DxWOjgZDOVZtLnweCzMKORvE02WzrtM0a/30xk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vVOfrBKq; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vVOfrBKq"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6fac7147cb8so54778606d6.1
        for <linux-security-module@vger.kernel.org>; Mon, 28 Jul 2025 01:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753690625; x=1754295425; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVOsc6ibl2c4BxKOGSlypnNZvk85m52BrD53itvnuCs=;
        b=vVOfrBKqXZq82K89blrYjpqba8kIYshhPZ28MnlENhy/eXPoiyesny97PmdYur41io
         4Eif5JXu1QhjSy9ykPYotE4ZMFK5TZyB32gjOf2gt/b4Sp9UJMdi01g1IL1xfrEqA3gs
         PMTo7HlzgZrxp7yO3bMTQRpS9EfQNXKkWkZx605Vso0j0draAqohyCNwmj5AHamASmTq
         kz1Y8cggL19lTavQVjd0XA/li8C4Bv4mHCi8o/QyELbkPp7YEm8Fgo6ZqdeF6N1zeaXm
         mQrakeNMLPc+Yj64I6o7bKXDB+r/LEppFTbJp+ib3Ga1hYfgwlNT+Zen+29n83VxjYSY
         QpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753690625; x=1754295425;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVOsc6ibl2c4BxKOGSlypnNZvk85m52BrD53itvnuCs=;
        b=w8BY5XVf4olpSjqruPxMFEH7wgESBys4+dBNF6uRpI82NJYeAOl4srn08grLEEsIMt
         BPfcthglspX3IZz30MfVvVUT2RtSP/V31taTtcsZ5jTEB06BW1hylgk9MnOw6WEO5TH/
         D9Bvb/QFZ5cRF552uw01rTA5ZKqkdMphF9RNwy6MMnEzXP42sM1yfqBNcvuNmVVkv6X1
         ffh4ufGIYS8V8iVKJTI11AME+sJpbjfLKw77T4zl1N+8XVN0IXgolMm5S1gfboP86ja/
         Huf54JlG6adcMASdUuVgfmWJ6uXJ2aluwV50afNcnzyyZ1D8xSzUMpeLoqn53WCgRDzB
         9adA==
X-Forwarded-Encrypted: i=1; AJvYcCVIU/+rReW9gVgP2qIEOhMvQEqkyKtFmAw+9n1AmiYc/JjgnY2JhacgY8MDnAJpUlrQjIUQOznEyNoLCnrKjAHbb7X33ec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6rz5ouUdfMlpL/hyTtBDQzPXcl6lpmYV0XghHla/UiTdjHm9Y
	T37fk8TovN0f53hDcSDwclcwXK+ACZWZsQNO/of9g6PRf3cz1jdMmrdkBRr5ooqv+OnkBjTXCN1
	b+gUpRIYvbXiUJ4XIVhsQiKHWVQy5iza0BtFO6siK
X-Gm-Gg: ASbGncs27zvy55vXdJAc/JOfABuoZJywR6KNoxhXochT38lBwIms7XljNsLyb62DrqX
	b2OU9VM4L+ycwCweXG3hPOwo/hkw9NYp27ckUx93V/8hV67XNy9Su0QFIS5+QwrvTl8mGTpdCdR
	iD0gj4AAplDm8qztPml3O0KLt8/euzs9RtnviV6qwdIs2uxkNY3BbEGXZhBwdbpJGnSOVxluB6M
	3zCmpDJdT1f/rlq3Q+ecokBmopYSdB//s4gGA==
X-Google-Smtp-Source: AGHT+IGJVja+BOlBDSueHM4xwgtmGAcntpknGmQBU6g6I7fWUhaq1g+6fNhuHcvRNLAtk8WzaUNpyzvQMZ0Hf40qYp8=
X-Received: by 2002:a05:6214:5290:b0:704:95c6:f5f1 with SMTP id
 6a1803df08f44-707205c02c1mr132327006d6.34.1753690625039; Mon, 28 Jul 2025
 01:17:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <687e09e3.a70a0220.693ce.00eb.GAE@google.com>
In-Reply-To: <687e09e3.a70a0220.693ce.00eb.GAE@google.com>
From: Alexander Potapenko <glider@google.com>
Date: Mon, 28 Jul 2025 10:16:28 +0200
X-Gm-Features: Ac12FXyuIo8mg0__JhxicCkBMBx-2UyW5BATXdwFGTnJezh5fbSE4P26Te_FKXc
Message-ID: <CAG_fn=WSae7yjaHh=_iUc7eFALHX1vLQFMw8ryfas4-ijgFTiQ@mail.gmail.com>
Subject: Re: [syzbot] [apparmor?] linux-next test error: WARNING in apparmor_unix_stream_connect
To: john.johansen@canonical.com
Cc: apparmor@lists.ubuntu.com, jmorris@namei.org, john@apparmor.net, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, serge@hallyn.com, 
	sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 21, 2025 at 11:35=E2=80=AFAM syzbot
<syzbot+cd38ee04bcb3866b0c6d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:

John, do you have an idea what's going on?
This is pretty likely to be related to your "apparmor: make sure unix
socket labeling is correctly updated." patch.
