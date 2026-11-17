Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794937360;
	b=x4BPBFxjOz39+ZThoLP3R9PS13V27Un7dBcEQV6YqLuj3H0bgw6NRc7DlTjCyLIfwAxG
	 hRPOwJJJv1PAQVMEV5rTyPRXeIA7u8g+JZFDsa5UYvUNpL6CLHXGJdb56eQ8rbc7mNd2p
	 mBTVNebBEUoOEZ1ngNu0dRAa6KITbSnz1Cw980zG5c/Nv5tKbb8PJOy0wwDNWT6RfVp/X
	 wsxZRJAW6QTV6myFo08BWt/T2iZN6mnsp48dUoPEX5TTxP+/ny/YuwduLM2QFmjLiOuqN
	 n8yj84JjLZX84o3EsD4R58BSeOktcGLO3UU8CK5mk9aDOltwLPEmCxUVOmJ5KxLYh6A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937360;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=C0Br6uNbCeSZG/D0SaMC7uBQz4y4PQvjObMC5HHmvxw=;
	b=2YTeEc9zdwkK/3SNOVqghKV6HFcCP3pFJmOjJnlBK3t2B9rAmVA5uzL7dSqRUP+Eb0F5
	 BH0+sZ6Mn/TLOFzAPyHtvZEel4t/4FEOWdUSi1H8CTxpgJmeJSUZlrWaQE/7ix0SQDCwR
	 pnT+8bEdSpr4EsBzqEUD6t4p+Rb6mKjAfuqOAovs72CnYqcl48y534OBMK2h1e4fFJGqK
	 u0zf+Irk2gmZI/oH3pfLaCErV0Lclcpnn2ZtgePTGKDWz5CJt5vvEH4+EKsxTUYZGdBwY
	 rbFwG9QNja9FjDmHWtrffF1CKVDIYoTFaRsxTfuPWH4cWwXjHj30OjsZex++diCeOSw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EEvWGAFb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE48606A32C
	for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 17:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FE48606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EEvWGAFb
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5bcdae234ecso3173e87.3
        for <linux-security-module@vger.kernel.org>; Tue, 17 Nov 2026 09:42:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794937359; cv=none;
        d=google.com; s=arc-20260327;
        b=EGlaEbaPRRFMpNSM+zuOnM40k1OHVL81GCxD5+hHYIkLQdqSEZ9z/iA32opK4hR7dj
         epvxIlOW0lkNXCb92FoL0gw7Ggtu5w3FX7aUacs9iC+WR3uy5TlHA9ga9wRhGwJw00LU
         WO210rrVNqrU4RL7G/nRshZDq/Oo/is/rRB3gFSCuA+BliqIHPqnZfCIZ4oJk5cFHnR/
         GT9kxZOYzQVIzGUdKGc3lR6POOWQJivEiVCzsASrzBKiJP8Yc66tnsyoEBfu7I2QBium
         LLbQ6itevC3hQIt/UA3D//i/B6ns3TyRgkpOfZZ50RUAiY79RO2uMMvfYkRa/qFcBhXt
         P58A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=C0Br6uNbCeSZG/D0SaMC7uBQz4y4PQvjObMC5HHmvxw=;
        fh=l5GXUFFoiURXMG7Uxx5f4dxFdr0NWgGmH4L+QB4vYno=;
        b=LLrEbM5s14M5m6BW2G8CJFEJubiiVK0alcNmKnx7rlNBEc3pfn1ytw2vo/6JvmL+9p
         8iWyFhrT8duOG01ZVsaIpYYp7j2kkjj0fBmeu1EhGGJNXDEbSQgxvzrD9zph7TtcyVT4
         BGvYJftIdFpwd1ol8rN4Ti+L/anfYaNmiUlOQCAgYTeeB4QSNM/cAIEkDCIG4puEw8JC
         ZsdmYef0YbHnJUNoAFkV5VB6/ANJ9KXXxembJuGq36HPT61c/Swf4enxFi0UxozzTStA
         chGmjoHNl3YDcDFqbC9P5DvawZ7oM4z9S0oJH5AGO6cbtbkgrrtqHduXtkevQtDFgT9Z
         /a4w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1794937359; x=1795542159; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=C0Br6uNbCeSZG/D0SaMC7uBQz4y4PQvjObMC5HHmvxw=;
        b=EEvWGAFbOmPz0e1bruaOl0rjybH0s4KDHt1ZdsIprIDdOYSYYFkdgv0P5ZbqLm9wOt
         QUKZ38KmXI7yBp+GV0/eyJrlR0x9jaOEr3Ii55nnjpnVrQIiwkaoActJokk0nmQSZd7G
         61WKKrB70e3ufmKjp4oHO9TAABVl1efKkOpBvtOYK6RF6gVHy0E+rjZz0xIx57DanHDh
         1TInlFBGPv/IJYMg1cTj312Sc7q2gHY8Ugtu6+Jpk/LKIOoiULHPpgJvsVB0ghEN1g8q
         2dPQMdyQdgbZ8hjQrp+yJxxt3I0107KE+viwJ2hHYYVk4FGOG+dWGVAy9wgHIHfa0LWA
         TeLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794937359; x=1795542159;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C0Br6uNbCeSZG/D0SaMC7uBQz4y4PQvjObMC5HHmvxw=;
        b=CSq4ubMYLNjBYg/b41Ld6WncFKMopk7ag1TlhXEdJVOOvNk55r9fsEzAdQZXgR6PA8
         aH+JrKH9b/JBbg+9jptGNtyCwPlFU4PwBGCMss6t0FnbQYli3hGH9PbyZ3s7vEwq005L
         n7XO0pMhyZvJ0q4vGZ49qsEpklOFZOFB/y+xaEWdwIBBXymbVrTed22lacuTlO2i/liF
         HX9SMzc4zjjg2lMSBlmORfxMNGaExBKcmnJzSI1tQaxxDEFvizfqaaJSLd5bhBwTG30i
         nzbFrt6CXAK3XltWIIlogiVzbQSrB9CbNYnFZbhaquZDknKcsG6/PYAFJqhVYUTjK0jA
         LwHQ==
X-Forwarded-Encrypted: i=1; AL+hErHApaSFUxKSTZPjCIH05HLMIA9Fmjt20lb3JY6jmxz3mSGkL2pS/byE2z+JP4Gv1Z28QYqi+kmxbsj285m8XvqQLsBTM+s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+8pi02yK7mQdpzymHoHHvVsy1EDPY0/OQygXMvkPt7EN7PIc3P
	2a2/UTb8tG79LkKRPKBqx58lYqtuNpiRSkB6O7NiPtWLZUPBWQOhpKJzPGUsESfRdxLyLCqCLS8
	IMzfnW5lOA69u03QmBRk7vxZxEfiGIssCU5Lo758I
X-Gm-Gg: AYBFou3mGTryByku4qAGq20jhjvtAB9xhzM67ZwGgkr5/E+NcWuIyayBcIP1Nr3V1/K
	6qOeaXP+93OZRkcOkT9KO77kBtzFTGiYg7PjUA5RqnUl5pT/cV9cS3qtMohSSsWxlWvvJdClO2C
	HLJNJSsqaUhXTr/Es1eedXhyMZCjeoozDfr9+Z4eqlLzMvs7gCytqk53omC7ru4kRdoJLatyBKt
	z8fq017PaGR96PgeSOvrw+se49x3Y8CvlSmjAFRfdt9wl/zhibn++IgPYsQGQ4IMZanETw0emci
	VBnqmKg6cET0iwhsBET21kFvNUxVjlhWT/FuR72Z4861BkAAsvaARHEYKi5z9AjpCshPJj0zBNS
	FdWZOjxImF5umtd2BJx3E0BEIZlmRq2Sfsg==
X-Received: by 2002:ac2:4bc9:0:b0:5c1:4ccf:f0b8 with SMTP id
 2adb3069b0e04-5c170a0bb3cmr7252657e87.16.1794937358574; Tue, 17 Nov 2026
 09:42:38 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117050841.3289652-1-jarkko@kernel.org> <20261117050841.3289652-8-jarkko@kernel.org>
In-Reply-To: <20261117050841.3289652-8-jarkko@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 17 Nov 2026 09:42:26 -0800
X-Gm-Features: Aa3M54o6AJsup2EB_D5C3UIkkriS8wK22wW9apyv8KKATx5_DoWBh2HrH9mfDyU
Message-ID: <CALCETrWtbUFQGDOCHkxAN9O4i29ixfL5KKF1Cqw2-CjxKwC6gQ@mail.gmail.com>
Subject: Re: [RFC PATCH 07/13] rootns: Add rootns_enter() system call
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Ben Segall <bsegall@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	Juri Lelli <juri.lelli@redhat.com>, Kees Cook <kees@kernel.org>, 
	K Prateek Nayak <kprateek.nayak@amd.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Manfred Spraul <manfred@colorfullife.com>, Mel Gorman <mgorman@suse.de>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Paul Moore <paul@paul-moore.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Serge Hallyn <sergeh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vlastimil Babka <vbabka@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 9:09=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> Multithreaded userspace daemons cannot call setns(CLONE_NEWUSER) or
> safely mutate process-wide filesystem state in place before spawning a
> child into a target namespace set.
>
> Add the rootns_enter() system call to fork a child process directly into
> a rootns whose root mount has been installed. Transition the rootns from
> ROOTNS_READY through ROOTNS_FORKING to ROOTNS_RUNNING for the first
> process so it becomes PID 1, serialize concurrent entrants on waitq
> until bootstrap resolves, and admit subsequent callers into the running
> PID namespace until teardown begins.
>
> Require CAP_SYS_ADMIN in the target user namespace, forbid credential or
> PR_SET_NO_NEW_PRIVS privilege escalation

Why are you disallowing this if no_new_privs?

This isn't necessarily a showstopper, but fork() is really quite slow
in many cases.  It would be nice to have a more spawn-like API
available.  I assume it's possible to open a file in the target's
mountns by some sane API even without entering that mountns, as a side
effect of how the fsopen / move_mount mechanism works.

--Andy
