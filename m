Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D03621
	for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2024 23:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710457528; cv=none; b=kZqRlzr0Qt+F7OzDjG87TIaeG2ZVCv+IzWbZx3ATNCXWwoORPpUoJov58Qkd1L1QPDYyvqhJvj+aE1lNWMgM9mGXa929lZ5Q1DUjPQYE2W+DB4Vk3RA+Ab/KZJ77hPxReR9TTDVbW3gi/BYB+EfxfLNAl+SCwDCVScnyOEgz4ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710457528; c=relaxed/simple;
	bh=EQZ/45evtuO+++qaNfNIk3sxSnAYQotM6BezQU2ECFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+ITMd5EMvg0Cny5Zf4Ha6vbA7CBftkWISjxJP+Xj2PvYNBZ1rhMgUaggqgSgXPyBsxexu5hRpZKV7zg1QVJTwAznUji4jWppnOcOFuIDYCvtNNQe9zkCvqboaw1EtChhNzt5hrYB+d0vDABsRKAPjRpsy0JvthNsjtDI7Xp6V0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=UsCPAoCf; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="UsCPAoCf"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a44e3176120so192041066b.1
        for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2024 16:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1710457524; x=1711062324; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eOLqBJYl+Zv2uwlXW3yqDcamvgCQRPjZY652QVEqHVk=;
        b=UsCPAoCfBOPZYHUTjgPdFz5ccAlp8B4IlngO3ur60FqxQx9E48nV1Xrmb+k+CvbLkJ
         3Js6071GDxmiKfTYtc4M+DNnXSDKeQBqhlLN/hTAgH/6SJVspDmO+0uWK4lfcXrkaM1F
         vJ8FDd+4F/aN6C1a9ox9H6fikS1JqkTsfIGbw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710457524; x=1711062324;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eOLqBJYl+Zv2uwlXW3yqDcamvgCQRPjZY652QVEqHVk=;
        b=JffRp46XIFmu99rXNxoJwqazJG3pD7jW34CYi8tnUSeeqW44LcmLq/NYKrco8cN9fr
         6Y1GTPeKGxau2R5ecf1ukntBnr5c+ovra6x9sPIR4mJ0EaW1kjvJZiUDlQkPtY8nXV4+
         3eTptQqPmpqTCSoL6DD7hoK167J64A0Z/t/5MSNrGgMjthM3WuJU7g3j+knq1j/92Iv0
         ZAJc6oOKtcd8421G9pr5zSuVPvlOjv0Wj3lGyiBAOJQlFKTzGrJQ670DySJt0w5mcMxb
         nU0Mogp8mxEwCjSX9g9xEAvYiok6E/T1Bn2PJgbyidPWk0PdZ487kXmfEkfSm/o48xDe
         k+Ow==
X-Gm-Message-State: AOJu0YyYKV1WQxOq12wC3VrpLrND3Mxz6bIzROdXd5kafGJrCBsVYpL5
	iDnqUYG9ZmkXV8vFpF17O5DNw7oEQdXyNlot7y1iZbXdLFmfrdQ5LuKIzgnPve7BtYQXurFOZbG
	3yP4P3A==
X-Google-Smtp-Source: AGHT+IFHtfC4KrpgWm5VnLc3RzzvgqRjyc9dnuNArOAYV7lr760wtS71GbRl2Q+theVr1yhGCdtlCA==
X-Received: by 2002:a17:906:2795:b0:a45:ad29:72e7 with SMTP id j21-20020a170906279500b00a45ad2972e7mr262508ejc.36.1710457523999;
        Thu, 14 Mar 2024 16:05:23 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id t21-20020a1709066bd500b00a46675c4842sm1101765ejs.86.2024.03.14.16.05.23
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 16:05:23 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-56829f41f81so1981289a12.2
        for <linux-security-module@vger.kernel.org>; Thu, 14 Mar 2024 16:05:23 -0700 (PDT)
X-Received: by 2002:a17:906:6858:b0:a46:5f1d:f357 with SMTP id
 a24-20020a170906685800b00a465f1df357mr756853ejs.10.1710457522597; Thu, 14 Mar
 2024 16:05:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3f2a695a148db9e1daae8c07d9ce5c85@paul-moore.com>
In-Reply-To: <3f2a695a148db9e1daae8c07d9ce5c85@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Mar 2024 16:05:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjXK3ZDtCM754mQVWzcZdQd50dBU5Y+AoATWcCGCMWzgg@mail.gmail.com>
Message-ID: <CAHk-=wjXK3ZDtCM754mQVWzcZdQd50dBU5Y+AoATWcCGCMWzgg@mail.gmail.com>
Subject: Re: [GIT PULL] lsm/lsm-pr-20240314
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 14 Mar 2024 at 13:31, Paul Moore <paul@paul-moore.com> wrote:
>
> I would like if you could merge these patches, I believe fixing the
> syscall signature problem now poses very little risk and will help us
> avoid the management overhead of compat syscall variants in the future.
> However, I'll understand if you're opposed, just let me know and I'll
> get you a compat version of this pull request as soon as we can get
> something written/tested/verfified.

No, attempting to just fix it after-the-fact in the hopes that nobody
actually uses the new system call yet sounds like the right thing to
do.

6.8 has been out for just days, and I see it's marked for stable, so
hopefully nobody ever even sees the mistake. I can't imagine that the
new system call is that eagerly used.

Famous last wods.

               Linus
