Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287080046
	for <linux-security-module@vger.kernel.org>; Thu,  9 May 2024 20:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715285324; cv=none; b=q/YlkhijnFmhIBqoKzfg/keL3UsWxaeuSTsssNw+dAi647UH9rTEwYRYEjUfJ/j7UNDyQGhiPFNxK3Fr/pVj6cOP7/HuXvESGUNBbLnLRlDaf+Yzl5Ka4/W1TQY1dEFjU851x7QFsFbDYi9MV0B10uSR2jvey+CNrKRCm99P4S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715285324; c=relaxed/simple;
	bh=jiZAk5HR5wPgy5aOVjXkVGPvP5lERxl/XkRvrevfatM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RDu1DCGyUSXeqIhAmsWgq/FuNdtRWV/JLnBzEhtp0Yaw8pLAf8u6FhOojIU/M4UzJgGNCeDCG0HA6j6o1yoVyAb4c7VgiUMm1Cs3jZ3G9D7Typ80aMhjs6Hs0MUR5KBwRatAr/eDWp7tyxpCbpiOVNc2abm4EvcJm8taVRQw27g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=NDT2ouZz; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="NDT2ouZz"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-61ab6faf179so13250877b3.1
        for <linux-security-module@vger.kernel.org>; Thu, 09 May 2024 13:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715285322; x=1715890122; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDmvoUGNMm0LV+6uiHByGZp6sbq5qjhyDSOvi5SMvmI=;
        b=NDT2ouZzaEnEJf65Rm8E+zSJIxpG0tCb+lQyrpCCBf+Q0r4yhz9L2dpBILPgUHKX/t
         QLuHAd6RFQKR6FzrwNkjK6IqKrk5xZ8DEh3urFGDGP9dGa9XjXxCy26xUtpYLNNx89KD
         7QdSQCe2lt1lCuJg8GCoiOwm7z33D9TRyPWXCuGf3DMICEKrlYFL5SI1RQ7Zg3b38Sj0
         T2wXyYqTOP3SzL2ZbOhxvBOQTKP8rMbQGU3bipPO8ZOrVcUkCj0SUrZDuzWAwIOyUgEt
         S9lvqM0ifm8uYcJyfkumIKXbSxibF8Ug5SW9XcLzCGJ+wJ0cwKmPQgDnrt3fn+P2abF9
         I4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715285322; x=1715890122;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lDmvoUGNMm0LV+6uiHByGZp6sbq5qjhyDSOvi5SMvmI=;
        b=nTByh3LiboMwCw5FKMJaXPUnyjv6tTcaEYRx0jxtdcPg4JfG1+Pb5nI6bMvkng3aRe
         KvbOw8cjTsBzWDw/pX8v6V1NuF0va0Y4UApByRGcb/ScsUgkMuDBXcAaD/GORS4b0CJf
         a162SUGXg+Kv0cLxEGBWyMk4kW66PcARQSL6jb4My9pUIgqyuEkZA0+2ch722zO0GeBc
         9o/UiyC/a/XiNHhYO4NlrCz3Isl+boM4gwCfx6IMoQJDPn3UWnsrVWbZkv6aMsLECYmx
         +xm5wvEQnSImJUMBJv8+qm40c9EQ5oRcjU9RRS0e7aLlS/mrFkrccvjpVlvqdOO4loYy
         gF9A==
X-Forwarded-Encrypted: i=1; AJvYcCWgshnPpcgRf/zZetFExU087NH5TpYokuDIumDRrfMO5TXsHsMfq3lecKHjQY6FBjPziAW7mGXO/bEE0vrvhgiSXbWLzezjjumbGzrZ16Qqmd+euxyE
X-Gm-Message-State: AOJu0Yxa3pxVm3h0zYBs9DM3TANNYc49SrITNkGBso7WmYVKYvPXsgSk
	6pW5RvZsZ4WqIIw+ETKhyvnZHiPohqzvkscBcVk99D2VpaT6Jxk4Hz8HXV5hPHuqL1mbl5vR3gH
	2Lypji3C8KNfCZC0JqLubtIpeAlJKabEPA7wb
X-Google-Smtp-Source: AGHT+IEgum7HpmFmz3of6qj4OEgzfMl2bUVC+kxJomD6t/Wq8xEHOeAgefbQVL2d9DrUw2+lGcp3mv56ZzEiN9TNcrY=
X-Received: by 2002:a05:690c:660f:b0:61a:7d6e:80e8 with SMTP id
 00721157ae682-622afff97eamr8108917b3.36.1715285321985; Thu, 09 May 2024
 13:08:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240507221045.551537-1-kpsingh@kernel.org> <20240507221045.551537-6-kpsingh@kernel.org>
 <202405071653.2C761D80@keescook> <CAHC9VhTWB+zL-cqNGFOfW_LsPHp3=ddoHkjUTq+NoSj7BdRvmw@mail.gmail.com>
 <202405071930.A3022BFDC7@keescook>
In-Reply-To: <202405071930.A3022BFDC7@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 9 May 2024 16:08:30 -0400
Message-ID: <CAHC9VhRcofEGmBAE+8DEkVv0t66xwmMV1kXGtqUjodXryBbh2A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 5/5] bpf: Only enable BPF LSM hooks when an
 LSM program is attached
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	jackmanb@google.com, renauld@google.com, casey@schaufler-ca.com, 
	song@kernel.org, revest@chromium.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 10:35=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
>
> On Tue, May 07, 2024 at 09:45:09PM -0400, Paul Moore wrote:
> > I don't want individual LSMs manipulating the LSM hook state directly;
> > they go through the LSM layer to register their hooks, they should go
> > through the LSM layer to unregister or enable/disable their hooks.
> > I'm going to be pretty inflexible on this point.
>
> No other LSMs unregister or disable hooks. :)

To be clear, it doesn't really matter if it is all of the LSMs or just
one; preserving the interface abstraction as much as possible is
worthwhile and good.

> > Honestly, I see this more as a problem in the BPF LSM design (although
> > one might argue it's an implementation issue?), just as I saw the
> > SELinux runtime disable as a problem.  If you're upset with the
> > runtime hook disable, and you should be, fix the BPF LSM, don't force
> > more bad architecture on the LSM layer.
>
> We'll have to come back to this later. It's a separate (but closely
> related) issue.

It's a moot point given KP's latest suggestion, but just to give some
insight on priorities, correctness is always my primary concern and
while the performance improvement in this patchset is a nice win, the
most interesting part to me was that it provided a solution for the
empty-BPF-LSM-hook problem that has been an ongoing source of
problems.  Yes, we have made a number of improvements in that area,
and I expect those to continue, but selectively enabling/disabling the
BPF LSM hook implementations is a big step forward.

--=20
paul-moore.com
