Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8DB32E137
	for <linux-security-module@vger.kernel.org>; Mon,  5 Jan 2026 16:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767629109; cv=none; b=Iiee3TySJtUXGyUAkOOsqczQ71dH9NZ+N0YmlphnDXbPvHr9gWPpak8xfNncYk2B0qxmRqJqCkwn+iZV/OnOl0YYRHCQ2lvbbX9Ic0YvHrz2PwzwEeYlrXt3VsAqzBAh4WJYwvn6djXe1yyfznpasIOb19N+K20mrENiffcwh4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767629109; c=relaxed/simple;
	bh=OvV1Sv0/ykXDeetgzIzEs1LX6j1noqEFgD4n9YnUn4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D1dlPHflB9Yv0aYVWrjRqU21+d8e+Pop1LOBf1d60cZY1hcFkWHBgf5oXflnHjbpwGJw4fdcbx/ngVvX7/OpoCvUl3FInUkbRLICYP9gIL/A5X8jXckKouiFYgya9F7faVOJmoFseO800BHnXG5IhEL9WD4kqwCZAkEuzK0L1pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b6oFEnlZ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b6oFEnlZ"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-78fc520433aso1254897b3.1
        for <linux-security-module@vger.kernel.org>; Mon, 05 Jan 2026 08:05:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767629102; x=1768233902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M84IjyY1kCiZUs3R1uSAC8/ZkpRcc9te4IoZICHe4xk=;
        b=b6oFEnlZUe6bofKOJ7e/E8HTrYYeLHB8pWINnXKlrwz30mV5aRk2+KKfz2GL59MGZh
         74vcPYewh3FNNV5MUUR6V54MXs1MfP/ru/7qMgFe+8xKhZCszDULvQ5OyJClqveVmVH9
         qp1nXxr8FSX+hFHo0UjIhixU7+qt3O554XVbIEkkpv2KuQaawKof6LVYt3zhhGuueC3n
         684CPZDL+BG2A+Fcmvle0ISpgsfKFt0wGRwqXgjEL1692VV9E6XTzNLRslSRQgHcqh+X
         rNxJQbenkump+Ux6iTMe6HDI6FDU4Uqgz5hUCO0XCe1lkzuDDABQ6b8RZargGee+Qrza
         Tl4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767629102; x=1768233902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M84IjyY1kCiZUs3R1uSAC8/ZkpRcc9te4IoZICHe4xk=;
        b=Wk8SEPbjrew3DmYb3vFj19Za0qGBFzsCEXOkeLXGP9V4DbDvSXe20tYoMMfouO/euL
         y57A6cs5rb6+8krU9vXvNd8OCDz2EKwsiX1VfyD14eDE5gCfeWg1as8E+XeHx8hlUAW+
         rD70CTS/wlp7FNeIew9xlo5t/ZlBOqG8eRRskC8gMskBffADsBT5i43cZQUbk6+97PGd
         HR8juf49YO1Q3BB6XECii0EsyXFrTDOxpb5jGP0YGx3h4D9P6znnOgRngb6wQvMDkyJw
         h5DYGZJ9cqSItCRGlFiBkiDKDEocb9ZufwCDd/l19fjn030XwN1MfYbPHuvrWI4Kpvzu
         C5gg==
X-Forwarded-Encrypted: i=1; AJvYcCVrYhZQigFO+QGBjvIanjG6/FF6x/igOkML8n6fqZeFDkQstFVfD5+bRnLkM/AkNSbHkVDjNFgMMr6lTBs6uf0B4XfF6zA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxirdxLZQr5VZu7t996i+jN3nh9pm1Snf3gUOkN0NjMlUsJUV/7
	ScHUS5c8ebbz6c/Ax2Eq+iSMxv3lsE6l8c/rn/nGXYlgMfqIgDd6oblH
X-Gm-Gg: AY/fxX6HwiwrfrpzwHujRiQotnHlqdk7zZDGaCKPjPv5i5UmHWONzloHduours0ym/u
	utaeY+wICEg5+L6FfBB6gMJY9B64p/7wcVMVxeuB/jxpybRoGGEKpXCVn05rmD0u3vPg7cEEpLY
	B2lFCgzJxj8vYW9hln0CBz6vFgA5q1c+PwC+dIEmtL52/lLG5d8e7sat0GKWw8CXbwrpec8qJgP
	zZW4cEZ4oLLJIIUoKJuuivbO+hNEGSKjbYSEm9y5QBePatgrw1GmdSrExq/4Um4fzyDB1BnigjA
	pLcf0+rK6Oyh+W4fmGiCEhpcdrsZF/dv8O/pQzQFCSGURwnc9kp89dRgbczmnLzsjExaIwYvAgK
	+COlyfJZM49vDQxk3HZ3x6oVjZdHz+8YfKL6RwdIbkoJzMtPJASMTeby27QU4bALVFDwIHHAZDl
	/ator46zeedU4YZjMtFsdEFzyzD0F6JK6rYri0KOYtfHLhbpiRwvnLATaTmEU+jKTQIfMnbnsOt
	MAnqSEj
X-Google-Smtp-Source: AGHT+IHFkS4y+TVFiwxQd2cB8nQ+oqPnSWL+FzNMasXg8+ydm8LesgOvRSMxqGR4s5SeeB2ofha1uA==
X-Received: by 2002:a05:690c:338f:b0:78f:aa6d:48cf with SMTP id 00721157ae682-790a8b18b82mr227287b3.52.1767629101825;
        Mon, 05 Jan 2026 08:05:01 -0800 (PST)
Received: from [10.10.10.50] (71-132-185-69.lightspeed.tukrga.sbcglobal.net. [71.132.185.69])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-790a87f3057sm352577b3.22.2026.01.05.08.05.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jan 2026 08:05:01 -0800 (PST)
Message-ID: <9845c197-167f-4507-818c-f4e9189823f7@gmail.com>
Date: Mon, 5 Jan 2026 11:04:59 -0500
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>,
 Kuniyuki Iwashima <kuniyu@google.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
 "Serge E . Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>,
 =?UTF-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>,
 linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
 netdev@vger.kernel.org
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com>
 <aVuaqij9nXhLfAvN@google.com>
Content-Language: en-US
From: Justin Suess <utilityemal77@gmail.com>
In-Reply-To: <aVuaqij9nXhLfAvN@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/5/26 06:04, Günther Noack wrote:
> Hello!
>
> On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
>> On Wed, Dec 31, 2025 at 1:33 PM Justin Suess <utilityemal77@gmail.com> wrote:
>>> Motivation
>>> ---
>>>
>>> For AF_UNIX sockets bound to a filesystem path (aka named sockets), one
>>> identifying object from a policy perspective is the path passed to
>>> connect(2). However, this operation currently restricts LSMs that rely
>>> on VFS-based mediation, because the pathname resolved during connect()
>>> is not preserved in a form visible to existing hooks before connection
>>> establishment.
>> Why can't LSM use unix_sk(other)->path in security_unix_stream_connect()
>> and security_unix_may_send() ?
> Thanks for bringing it up!
>
> That path is set by the process that acts as the listening side for
> the socket.  The listening and the connecting process might not live
> in the same mount namespace, and in that case, it would not match the
> path which is passed by the client in the struct sockaddr_un.

Agreed. For the unix_sk(other)->path method you described to work, it requires the 

programs to be in the same mount namespace.


Doing it this way would make it impossible for landlock to restrict sockets mounted into a container,

and would be very confusing behavior for users to deal with, which is exactly the kind of stuff landlock avoids.


Does anyone have any thoughts on ignoring SOCK_COREDUMP? I think ignoring it for this check is correct.

>
> For more details, see
> https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
> and
> https://github.com/landlock-lsm/linux/issues/36#issuecomment-2950632277
>
> Justin: Maybe we could add that reasoning to the cover letter in the
> next version of the patch?
>
> –Günther

Will do. It's about ready to go, I may resend it today if I have time.


