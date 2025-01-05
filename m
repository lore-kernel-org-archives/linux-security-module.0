Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCFD35976
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 02:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736043159; cv=none; b=KkP7ZY2iTvXurKtERdOTi6POfF8vRhNP/sRzd35un1zo3NQdvtdVdaSttn1Z+oPF1rbfXHmb4rvjXHoTa5GIDZDwZDhk+RlRQzRLwV0HWpIp16ZCAdv3p2AGPHHFrBICvVJbmMgmUIWo1sezhuheNHgJsU8qlam7CljNe/RT6P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736043159; c=relaxed/simple;
	bh=Jzfp8M24ZGYO8CfByHmvPRILhEgp3SAXkuYYuv0i5/I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jaJJtHFa2Kjpfmvn4zo0r5Lv/zOqIquYeK09vAZqujjcluC2/xu4gIkTLY4ytPOSpnMKW8a3rEjss4NiA+lLQwk8beYYZ1FP0U6rSogbc8sJPC7t9XvUDDtGvCGjXfZkAgx8BbfylrLNBII5QNf8FNobGI8E+tSrFk9nustysB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CySZ8vf9; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CySZ8vf9"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-e53c9035003so15686937276.2
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 18:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736043157; x=1736647957; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVhkp6+4+SyxA1C7vrnL8lux54uiVvQyU708Zob6d9M=;
        b=CySZ8vf9OLOhU24WKEejG0p3XnXqR//c4ziWRDp7La6dRSXO59Y1Oy0jjA8GTgbpEP
         hJsdXrQFqfzjFUFgb/6VMYSH24vTFN1R7fTN2bMVl0aJEpuQA3Zm2YRCG7Kr7f4//zNh
         tEoYIoSaQssNv7AQv+QINIvjodklba+Qmb3ZTl9kojYvBQet4/bhhUVCUxFySH2RgVnn
         8G/t8bUOZWrIrvhSF4Ho1LuyUuhgLQwPeqpTapRUNOvmVhqSYo3XBQEUR2ikHXhfNLan
         Sbfzgh5mlGL8F3Lvc5duhXxCe64VKPZxGd75bi2R93t5XcFQHpL52a5cRGzMGKKDqEEw
         rs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736043157; x=1736647957;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qVhkp6+4+SyxA1C7vrnL8lux54uiVvQyU708Zob6d9M=;
        b=JAN6yMacSU8XtKaIN3PIB1UCqH0LAcelggee/aFs+XmqKwX1Q+HV0HYzWxntS7Reb4
         ZqKQKFm7/tSt0vOYT4o8m2nBFiCSssVJoF6VTYdDu0PdjBfCRTlhpKKyfXmERL8cr1CT
         ak8L1I3fypOxZCGmaDuXk7McqWIuqmP7PR9T9O0Fa5+QLi8kt8SIH7umLtbCS3bMEFUu
         pDlnNLfjHuvpuno4MQRVg6w6jon1IFQIPracH3Hx8UAlToRda7v6WeOmkzaYyJedU3Bp
         gsob5iyjtc/Yb8ksobrwa51XON+TC0cjrJ/ijUDpEqfw9p530QCSJysW4HuLXh5uiBsv
         M7wQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0w3dOvJL6UJK/z3fHHJbo4GUD1k7RStcivpeQ9mPYgUSGuDxpIEAB1UuQo1WhzEbG7lW6tbd2v2QojCu5iJovdaipw1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxkTlAk4DbGkv4nsO35ycafAH+LeOiuIlg7x5YBVy68JSMI1hWl
	59UYW0XxtzvRNobVylGDFrNLHBimeMNJj6nimzt83WYqqOEAefHk01Fjqu5JaC3iacyFp70ZZbF
	97xA2aBAbk7yajQWtS8LWkaRIvgXz/LowJ5ms
X-Gm-Gg: ASbGnctvjsqkYXXHQpcZKatgmsiwDnwwiKkE0qQAqtyiAuq+MYx8c02/NP1oaNyhvYf
	8eFDCimTq7nbHws9kLYR2lo0W3zRNe2dGy+rH
X-Google-Smtp-Source: AGHT+IECujpE4SlfMSgDTibr3ecgQxCdF8XBs81RAecEaO9HiXL8b8vWykU+LPwyt7KcvSbGf6hiT7jTg2ydSuKCgd8=
X-Received: by 2002:a05:690c:6009:b0:6f2:8781:32dc with SMTP id
 00721157ae682-6f3f820ae78mr369384597b3.30.1736043157303; Sat, 04 Jan 2025
 18:12:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241219204143.74736-1-hamzamahfooz@linux.microsoft.com> <4ad606c2-c7d1-4463-a2f1-4fd0c63c6e9b@schaufler-ca.com>
In-Reply-To: <4ad606c2-c7d1-4463-a2f1-4fd0c63c6e9b@schaufler-ca.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 4 Jan 2025 21:12:26 -0500
Message-ID: <CAHC9VhSWUNfFUZPtEQdHN4ON6VzWoRN38NeoHJHmGZj68NprYw@mail.gmail.com>
Subject: Re: [PATCH] lsm,io_uring: add LSM hooks for io_uring_setup()
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, linux-security-module@vger.kernel.org, 
	io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	Pavel Begunkov <asml.silence@gmail.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, =?UTF-8?Q?Bram_Bonn=C3=A9?= <brambonne@google.com>, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 19, 2024 at 4:34=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
> On 12/19/2024 12:41 PM, Hamza Mahfooz wrote:
> > It is desirable to allow LSM to configure accessibility to io_uring.
>
> Why is it desirable to allow LSM to configure accessibility to io_uring?

Look at some of the existing access controls that some LSMs, including
Smack, have implemented to control access to certain parts of io_uring
such as credential sharing.  While having a control point at the top
of io_uring_setup() is a fairly coarse way to restrict io_uring, the
advantage is that it is very simple.

--
paul-moore.com
