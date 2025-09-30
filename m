Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41002FF16B
	for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 15:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759247309; cv=none; b=ln/nbkVaBHPXyc+LzwEBKSwbh9mnC7MDgr0L2GKWkw75bY/UiOsC3nnCUdzaI5DoqNOjjWWCFXaeYEmLYGKzSmgWJAfeuXjNdd4Ii3Y3PKkHAOXJzMkAQWaVn1tTYPqmAF/yfre9snZRDIlf7UQpBU4VgC3qKxWnx9WeZ9/JtsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759247309; c=relaxed/simple;
	bh=5dk+SBRw24GnWlhj/fQ5DeJlOcYn8lBKeo22Opld+4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o+9sw4DZRe0L8psLaRDADEEFirptx2+x+JEp/ZxW1M+a7imo9q9VFRP7AnablQWw9FOy7PfLjzJpHbUFobaAsf3u0qJFV6/uzO9AY3C3MinbLhY7EgckQtIr2UcNl2MIgFtTkHCAZkuN+dctYroMP1eKqVIqD4WebfwMdg8Knu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=WZfrcBfM; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="WZfrcBfM"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b4539dddd99so167149066b.1
        for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 08:48:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1759247306; x=1759852106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BBG0QiSMVhr1SLCtRL7FqkE9Hmi4p6uP4U2GxU0hK9c=;
        b=WZfrcBfMs74gZSaxTIAIjQGx7r/uQVg4Aj79uF1mzjCNMKII7emQFYLA4fHh3/WYks
         Tec9YVhNqipnlqFtMEB9rYM/PWILxieIFFKRIStLpWo3IVEhgsvLN/MQyuhgAKPgBker
         UG49cB9lui80OeUYLHF/YYxXmvKZfJ/fcyKKQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759247306; x=1759852106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BBG0QiSMVhr1SLCtRL7FqkE9Hmi4p6uP4U2GxU0hK9c=;
        b=ebVSQbI2aIEHqLxT2MnUZUjqOOxHiFqFKVjOvg2slJ/Llt4CBqFRqFTpdVVSK30FB+
         f398+FBEVd6pp+LBrgrZIKQs5S638ti6JH2UuqjpX+rAMBYCP8PP6PMPjz8rfR4PckxE
         8MAQ4z4Z167cLHOrWV9eIA3kkhDFyohsiswPZHvpS4BmYQG0ZAAIwy0rmU3SIq/QxgD4
         hI0GT1Pvz1mkZmqjRJvmuUrceEalrfVRSi7dx7FZe4Uix8quywwWTYbLY3Athd+EfhC4
         8m2dLxgS8ZNPLj6OqUv6bxJybVBP5Jq0mZ+vO2Z99XhH6+Eiku68uXrQdQKffLnEFgQJ
         0Zpw==
X-Forwarded-Encrypted: i=1; AJvYcCUNJQurYLd2I1KP7Z0JM4ns+i0WNveqdGc1R7Vfg3MY2fG/CQbGoaA2ORohMmuQGLkWOfOoZbgWEeEIg0z64bYm9ppl+dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5NXLkeaGHmY4qQsvJ8kmjYNGnuEsVDGaO31Sz41mNIDG2aDtD
	YYFgVruruVs+68fWJFSw9F/R+VT7eWxcXPMqE8QjTAHaSQ97IXxm2/g4I94rM++ZoqrpGGmMlry
	ObA1yQ5pJmA==
X-Gm-Gg: ASbGncvmRyJXGK87zHtE3FPeVBFrw2bjSlJIwdks7shrgG/xSVuxSGhTY5IXWtPFHcW
	jkxWmHO5adO2x257efopaDiLs4kIwscuNJ22DRHnS4HCFVWH3sYOaEf6TGePUqzl7+ygEvrqbOt
	A9a1A67lUCiaPsFxKcqA8iFgyMvsSjIjlMW4ETG8VCFb7VFyv0DJMkW0QZhaE7/MijygsnfdX2u
	SJdnHWHpVXGp+pXZC2uhRhaLYGUoyXKhsCtqYoo5XJe5S4Z9ZurkkREx33hGztJU4OyXKU2usDr
	itDDtPObVTKnNL978zmdr0uZjatWF7QUOFoxIVmtA4sx6W/zDu20d+25ThZA9/4xWbXz6+bFglc
	JRZpdNpb586sYRD6yZRiOgYdr12OYlhCgsf0rTsiE+5niOp23/7YXxKvqA21bEsWzYG7jDWpd1N
	TjBQXlMfd5szwHqoTE2vUs
X-Google-Smtp-Source: AGHT+IHdzKI7BZoGpWzWmnUma/zZS5WOa0kezjwPeVfwn7A6rUhyOcBNQbfWD02c6e44Tv+zbkBykw==
X-Received: by 2002:a17:907:3c89:b0:b3c:42d4:1c67 with SMTP id a640c23a62f3a-b46e31e02afmr11362066b.23.1759247305749;
        Tue, 30 Sep 2025 08:48:25 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b353efa4c35sm1165067466b.26.2025.09.30.08.48.24
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Sep 2025 08:48:25 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-b3da3b34950so461966966b.3
        for <linux-security-module@vger.kernel.org>; Tue, 30 Sep 2025 08:48:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXUfN/Ky5e2lzXdPS2EyqXWgUqa4U0I+4L5kVnQXGvGhD2I/ZQxtef2R1CLmsW0Oy2JhpxY0hiBczA7UHLeQBs6vLH3g28=@vger.kernel.org
X-Received: by 2002:a17:907:da1:b0:b2d:9286:506d with SMTP id
 a640c23a62f3a-b46e612bed0mr11449766b.38.1759247304449; Tue, 30 Sep 2025
 08:48:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com>
In-Reply-To: <6edbd0e6dc79902981bf9a34e8d41128@paul-moore.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 30 Sep 2025 08:48:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgfeAjTNomdTU3gx308O+k5+3STqwBMSqrM7=D8CyEydQ@mail.gmail.com>
X-Gm-Features: AS18NWDnegEfxl0-IfjBztjUvXWxvekoliLaNtqKY6s9U9XtFR6zj4hxzgx-h1A
Message-ID: <CAHk-=wgfeAjTNomdTU3gx308O+k5+3STqwBMSqrM7=D8CyEydQ@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250926
To: Paul Moore <paul@paul-moore.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Sept 2025 at 20:07, Paul Moore <paul@paul-moore.com> wrote:
>
> - Remove our use of get_zeroed_page() in sel_read_bool()
>
>   Update sel_read_bool() to use a four byte stack buffer instead of a
>   memory page fetched via get_zeroed_page(), and fix a memory in the
>   process.
>
>   Needless to say we should have done this a long time ago, but it was
>   in a very old chunk of code that "just worked" and I don't think
>   anyone had taken a real look at it in many years.

Lol.

... and when I looked at this, I went "scnprintf for a 4-byte buffer?"

It uses

        len = scnprintf(buffer, sizeof(buffer), "%d %d", ..

and I went "printing two numbers and just four bytes" before I noticed
that they are just booleans and so 'len' always is just 3.

It literally could have done

        char buffer[] = { '0' + !a, ' ', '0' + !!b, 0 };

instead, and I guess a compiler could do that transformation in a perfect world.

But this isn't exactly performance-crticial, so nobody cares.

                Linus
