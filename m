Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741D82561A2
	for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 19:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743018041; cv=none; b=hrHlGnN5YUbM24aVWqD1rVsFvaq5co67yOmdNIUW3SCC5ka5Qm2wy6UyTqDWU0/9+rHvOFf42LvwiHmZ1ITKdqMzLCswvesxbRGYBAqwdC5A+yweRi4sY4uIyOYmZfklLt7wZouiZDXxXyQrcE4SuMvZvs2L0jC+Z9hmuYltpN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743018041; c=relaxed/simple;
	bh=6JmmSbRQ8MpL+89HMfAzj2vUP7QBs0D+i13dt/VsGmg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFosiIxoeqfShy+mhshLgAvgC7wozsriv8q0ixs0x0WIs9hgMgEeUFhxpwdM/IVuu+jeELahwN57grYrvJExL0XLpzU+yu82QYxiyEaQpjnl4ModKQp1bGV+Oe9CrIIwESkKu54xMPiIVxnjW4MRnvLuRcROhMOwSeCvvR/rjNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RcLxu09W; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RcLxu09W"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ac289147833so38397966b.2
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 12:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743018037; x=1743622837; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YTnx5GpAo0KL0E3TtxHMmgaX5DlYUN52FQs+TSmcpSY=;
        b=RcLxu09WxsKH8GB5HRO67X5F/6OuKRnuZvhKok9QsexNcUFSW6Rmn2t0Ty5nXszw/5
         RAm/SEdA5qvPiudPe7nP4KqSFoWyk+LHpME68see2CnpqSE/dsI6F0WNMzy1gRfey9M6
         /OBCvpoK8BHxmGJhuQy3pm4tVLLY9QE1YQKkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743018037; x=1743622837;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YTnx5GpAo0KL0E3TtxHMmgaX5DlYUN52FQs+TSmcpSY=;
        b=Jm3p327ZeyGOIYs5n1FBWiZ9C+ZKVUKVT/GPYdmspkjT5g29OER5HIl3Rdztt5smBI
         gH3WnUL4jqPIVn8mtORYkgPhrB5jb4jvwuT09/9MJO+d7pdgCwNLfmWVxaqMz5P4P9uZ
         64mqb7Ei3OX9OESD35rf43EsMs8jUGw2VRyyyOReOjY16idnoXHEUygRCvKsPIxM90KZ
         +WzOQdBwbfdDaICHwYVGfuBILKfA8AbiR82s+E52rGxoxBZe6jv/ASuO2Wh0eY+icl4e
         3VTvIXYIrQL2j0Y06hFItuOyMMyPebXlhjf7CZMKGMIlmSlV2PHXPtMUHwQnD1tW8BLq
         uU+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQz4eZYehGlvfwh7tkOp8XZ1T4gfn8+fhIZQWiC6CJLDSbbbiUdsz6vDNO81iy4iGPGYTYkGkEjwqTcwvUTWc+NgFjCA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5BIVzIh9HNpe74xXUFAhG4QmlxTDuFJBW9caEtjc+LO5CEDxR
	9cTV/jEB6KVk+tzAUZlIGxXR0S/fNmzWQXo9Xok4Sn5jE645/B1+4x+3gb2DsqFaVbzETUs68LQ
	QsnIlVQ==
X-Gm-Gg: ASbGnctAh8q0yIZAQB451SQ6oXwsc25eTW/q8PZpv9/TH4TdRZUiAZITSNnKA3NCqjr
	RtsCIauWhmeDYhHwcI94UfyNW9dhL8ggxZaRSjEyET9QB9GL4+XZGG0+2qsT/ayX0FNWnndJulO
	H17TNYVTKjjlDJS4MhyQTyPMz6tVg5aKCumuZLhTVWk6HQI40mh35L45IzShzWLDtiw15S0lbzh
	/gqDD5zWOge8Io4NQi3BdXsZAahGoGFW5OEKL0Yn4yoXYaalWY90mgw/4sYE7vaqQsmU5VopbaV
	rkwug1kNhF/UkyTNwnefh3OGF26VNmGmbGNzhYHL5yquYPCdVvYnwjcmCJCwMH+Zc+d9xrcAWGn
	zBTd3X0qULFV2qdiZX10=
X-Google-Smtp-Source: AGHT+IH60Cs2kx5zQemCMY4uhVJ1oH6kAL0EzxlHc5P1Bq0nocuarWYoK5u/7TYNeT+90vrJvBz8yQ==
X-Received: by 2002:a17:906:c102:b0:ac6:d160:e39e with SMTP id a640c23a62f3a-ac6faef4ae2mr60619666b.31.1743018037400;
        Wed, 26 Mar 2025 12:40:37 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3efd48021sm1088514066b.168.2025.03.26.12.40.36
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Mar 2025 12:40:36 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac2dfdf3c38so32189866b.3
        for <linux-security-module@vger.kernel.org>; Wed, 26 Mar 2025 12:40:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVvVZWtsp4nHXJo0OowchMHZZZMB5b3gz5b2inX5DJUtzbPogxZAzbauMFjRNhvQmS6pQaJTrWj4yhCy1lGY1gc/3sMYOk=@vger.kernel.org
X-Received: by 2002:a17:906:d553:b0:abf:641a:5727 with SMTP id
 a640c23a62f3a-ac6fae44e6fmr66686466b.7.1743018036263; Wed, 26 Mar 2025
 12:40:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <d0ade43454dee9c00689f03e8d9bd32a@paul-moore.com>
 <CAHk-=wjbahY4JjLCXNT4o3xVq2cejqBG69z+MNfHsN9FQBnbOw@mail.gmail.com> <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
In-Reply-To: <CAHC9VhRExVqdhHqs0njs7NY6bFg0BfcE-gMpS30HW9O7MSDfWQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 26 Mar 2025 12:40:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
X-Gm-Features: AQ5f1JoV2NGzR0LooAp6oXwmVVp2SH1Bo3tIPZjlGoykS6sG1BTk0PCL13rM5D8
Message-ID: <CAHk-=wi9m8-_3cywQCohJQEQtuQ+teS4gOtBkWZrhFWzNy-5_A@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20250323
To: Paul Moore <paul@paul-moore.com>, "Cameron K. Williams" <ckwilliams.work@gmail.com>, 
	"Kipp N. Davis" <kippndavis.work@gmx.com>, Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 26 Mar 2025 at 11:36, Paul Moore <paul@paul-moore.com> wrote:
>
> From my perspective this is largely a continuation of our discussion
> last April, and considering that you ignored my response then, I'm not
> sure typing out a meaningful reply here is a good use of my time.

What you are saying is that I have complained about added overhead
before, and you aren't even willing to explain why new code was added?

> Anyone who is interested can find that thread on lore, unfortunately
> much of my response still applies.

That thread was similar in that yes, it was complaining about extra
overhead of the lsm code. Not just me, btw.

But your respose doesn't make sense. I asked for *why* this was added.
You're saying "I am not going to answer because you've complained
about other overhead before".

I actually went and tried to find the discussion on the mailing lists,
and nowhere *there* did I find an explanation for why this was done
either.

In other words: why were new policy entries added? The commit message
and the list explains what the commit *does*, but doesn't explain
*why* it does it.

I'm cc'ing the other people involved, exactly *because* we've had the
whole discussion before, and because I want to see explanations for
*why* new policy hooks are added to the security layers.

I really think that "policy hooks just because policy hooks" is not
acceptable. And the reason it's not acceptable is exactly the fact
that we have a bad history of various random policies becoming
problematic over time.

There needs to be a *reason* for a policy hook stated. Not "there are
no matching policy hooks".

And I do not see why firmware loading should be a policy issue if the
kernel code that initiated the firmware load (ie the module load that
*was* checked for policy) was already done.

Do I believe this particular case is going to be a performance issue? No.

Do I strongly feel that any additional hooks need *EXPLANATIONS*? Hell yes.

                 Linus
