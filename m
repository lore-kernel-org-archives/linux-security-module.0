Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F4FB658;
	Sun,  5 Jan 2025 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736099552; cv=none; b=h8Cyvc+lkFwRlM1xWeuuUaciyQqsxXaXnFi2mXKI9P60BeRlUetkN8EgOLHLmP29EBzODYH9ZmHhxlxafC0t9gQx4j7MwQ2MEQHcSjb93WqoTIFGsaKRznxaBAikEvAs9JkMjEA61HBdh9hvrLJ8zzcdFr9GRhmnT2wmyL+SD4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736099552; c=relaxed/simple;
	bh=xNBPA4resaiUSs4KnFuBu8NQk++qEi1dLXtoi9eWQrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H/OASj1WQqle9WO6iE8LNGvfN1opKoPdXY+lnGi473ZMTE+EIWQ+iE6OM26TCNbXI7k9Pw6deGa4f8Slaya9MK7L6rmBMiibA8NoCyJnLQGE7ksBKoKxb6OI+arblgp1jN9Oo1JGYwX8ZLuHRs9ngIwL1wZa6bavjIiVUoC5zzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QCa3Juw0; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QCa3Juw0"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aaf57c2e0beso938187466b.3;
        Sun, 05 Jan 2025 09:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736099549; x=1736704349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkv4g/Yz/u/3d9D4eqcCq8T2dE6MAra8Lzfwnyjf1uA=;
        b=QCa3Juw0aXs99Y8rMxOK29DcNvsXkouK04IWdGbX9UqI4Rwxm1AMzy0/IlGKqcyOj2
         1lfZ7nW6nEV4H/1TacQ+tYz/BLQmBfFNeX8r6Q4O9wl/jIBcQ7rJneuoUjSPqLiBwMpo
         pDX36hzy/PzIpkrOOXYQBTtD9mFcztSPrLMySw7phAM8iJ7eTUPxjPZS5a6VDpcsQqeU
         XX1b/dX/+5Qhgh5BfowBvbdEuAWo60zCrx5HQN/gxsFYOEan7UhXTDzgWNlphHhnGIJ2
         xOyyM7qTMymzv2khP/1e5hrkExy2ICbvWAzxDSx+pgYr9XMdzmZwTdsgJ15GnLLWWtya
         sv+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736099549; x=1736704349;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkv4g/Yz/u/3d9D4eqcCq8T2dE6MAra8Lzfwnyjf1uA=;
        b=jOLidgzm3SFc/L2x9XfbSyemRKXmXH/ihMgDBJ1jb+XO1RmxhYB/Q7XF3RnWEwvOHE
         v75y4hG8vsqWbmupw7gtxG5cBG/wOInVXmQj54RW6gBPXacL+pj2aJ3KhUogNAvOYZA8
         /NsDQLYYebJ9n/3tQXR5t9mfytPkt9rWfIyC0+yXAIVO8VXjIzAfcfYZxQFGQG4SDb6L
         yzL5AuRzudhyKMgQHmQMlSXm4XcOa1EdgNzfZJ3InqYbEoGIs098On17pVFpAJQg5t9g
         RB0+6KXND9pwxArJfBlg6EXl9gyiyR/1vvpuERSIntRB5q0xYQuLXkXu/GXqXrMG7cAo
         ZoeA==
X-Forwarded-Encrypted: i=1; AJvYcCWKMCuD82Za6IdO3la/0N0SrvrsJZDL0PGjieTNxST+4UdXo4vPSYTLz3SqD5sWmSVTazKJqopAd9LzEqJx6mmYZn/Rsmrh@vger.kernel.org, AJvYcCXNfZExKogjH9GBGFWkoLGDdWmYRrh1s9Zf+RTeb5fJRDeT15tLp1OFdvD/2C6ZV3ij7quE1gD4w/cGpKE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUNLFsABtOyTq9VZq+dl9UjA9VWTwUlRr1f0f3X4mx+qWkJu/C
	crQVa3JNLiI2feRHyZ2QtZodlrTfj5q+cS/tSBuvJI6cc5UV1tOyFTA6c/1EiGsHQWFwDKmOuZF
	8KLkmcdsuJB6o8oaMgRU40o3Aj/A=
X-Gm-Gg: ASbGncv8sDbcTg0jzhv6+fcHQ+Q5rKFcbh3AcTBeD13Tfbk5trL3WrpEdn0kTgnRyAj
	Wr5IfGtrJ9q+m8oPGOYEvFcfgqaQ1Was76zccWXIv3qq7wubDbyIcIMeVcPOG6a4H1e2VfeWX
X-Google-Smtp-Source: AGHT+IEKCme3xeaeRe0+dVjujBQKwlFsF1ZxqdlzPvIzgo67U13xtarQBAxmpfkeP0iirYIP1/ea8COscoXAQg/qToE=
X-Received: by 2002:a17:907:9724:b0:aa6:9624:78f1 with SMTP id
 a640c23a62f3a-aac28c14948mr4558272166b.9.1736099548841; Sun, 05 Jan 2025
 09:52:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250105070537.58334-1-tanyaagarwal25699@gmail.com> <2f7db63290c5c81513721f10a65f602e@paul-moore.com>
In-Reply-To: <2f7db63290c5c81513721f10a65f602e@paul-moore.com>
From: Tanya Agarwal <tanyaagarwal25699@gmail.com>
Date: Sun, 5 Jan 2025 23:22:17 +0530
Message-ID: <CAPdGtUwDVtVi5fcHv4HM4GacS_MTaE6b0CxBu1arZS2NEMd1+g@mail.gmail.com>
Subject: Re: [PATCH v3] lockdown: Initialize array before use
To: Paul Moore <paul@paul-moore.com>
Cc: jmorris@namei.org, serge@hallyn.com, kees@kernel.org, 
	yuehaibing@huawei.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, matthewgarrett@google.com, 
	skhan@linuxfoundation.org, anupnewsmail@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 5, 2025 at 11:18=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Jan  5, 2025 Tanya Agarwal <tanyaagarwal25699@gmail.com> wrote:
> >
> > The static code analysis tool "Coverity Scan" pointed the following
> > details out for further development considerations:
> > CID 1486102: Uninitialized scalar variable (UNINIT)
> > uninit_use_in_call: Using uninitialized value *temp when calling
> > strlen.
> >
> > Conclusion:
> > Initialize array before use in lockdown_read() to satisfy the static
> > analyzer.
> >
> > Fixes: 000d388ed3bb ("security: Add a static lockdown policy LSM")
> > Signed-off-by: Tanya Agarwal <tanyaagarwal25699@gmail.com>
>
> I removed the 'Fixes:' tag as the code isn't actually broken as we
> discussed in previous iterations of this patch.  I also edited the
> subject line and commit description a bit, but otherwise this is
> fine.  Merged into lsm/dev.
>
> --
> paul-moore.com


Thank you, Paul.

Regards,
Tanya
