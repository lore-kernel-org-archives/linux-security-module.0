Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795021194;
	b=q80wv+woXFH6EM0YZ1L7CejBVvCY4bvHenXWz+9FVw5W1zGRpxoTVh525JLIfpNCvY0Y
	 lpGvkUR0HigO2xOgf4FlbcTnqPYLnMvveY9X4MvzWS1OE5w3BJm8k0bsUNFnLiDVSsvI4
	 wE8txKCtvft6fOJTfnanuyqo473I5mW8Y8E2n6oV7dxy5d+1mheLHpG4Z1qzvPs3Gs6ZD
	 lHuxKy8r1MXbsdn9zb4F+rrniAWawznS0qs2uBMQPtpySPIovROCLrLMkUOP3nxHgmPTL
	 DxqBkD6K//O+IPu0wDfLu+8+hf+nn7prJocTlJMjALl2qVry/R8mR6u4h1AAHq+Slyg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795021194;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+eo4FKNzNbHf/eH43g1C8Z3to6Do7+2E27gt4uDxW08=;
	b=Er6adzcCCcRBtWYCQUwdCtXGG4j1SQ0bcEPoqGro+9fXH0j/bYGfRUATg9gbiOh+f4K2
	 OsXZZlMVoI7WQ06ybrLd266BclxbKdLUMnJBIkEdPTeSNJ7rUPaTO+L8qvb66NQwtE1LQ
	 NuXisnim2OAJVP0foNtO9mtqZDABmkrw584AxYW4eYBQVvUSKAT4nkbwN1/hu/AjlSKLr
	 hRlGO+Qk/E6Ch8/1iCL7eKA/5KoP7vZ1VOrBBiI+KV7Iz3jgPLvPbXvZoHCYKRdGj2ils
	 Y1ufDiWj5LObY/8qjbjqnmw4gcsr+Lw2wA7/INNZK5V2+/hBjL4bNShRVPGsafUhadA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amacapital.net;
	spf=pass smtp.mailfrom=amacapital.net;
	dkim=pass header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b="tsb3jtv/";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8BA606A336
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 16:59:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4C8BA606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amacapital.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20260707.gappssmtp.com header.i=@amacapital-net.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tsb3jtv/
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3adfcafaabbso12774021fa.3
        for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 08:59:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795021192; cv=none;
        d=google.com; s=arc-20260327;
        b=awk4zkjImSL7xSb3AxV3OR+fdR7b8R5KyDcrOg3YkOcUOUoMfJ7lJOY8sbRfzDg5DP
         o01yzI+M2HaaaUHqHnQHSyFVqGyGwf5szr9bN5lxTUEAVLzVI8iBaxvLcUutFdZ8L+qw
         9PGphofqaDP1vsU3MsggNJmYOwjDKcicGcauHyKKQqnB2OATwo9aL6lN5WD4m/2V/odA
         ix6zpzfeEHuU/mVmV9Awn3rVAV8aTjrv52IwptkL2oK7/lmRhr2XHh69HEcur0kNOl/S
         38DhE5lKqGqVRr7Dddg3cUT6BYmwp5v+ZZNnT2rVIQdpCIEz9WgyxMZhu9rzhcSQbij5
         jddQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+eo4FKNzNbHf/eH43g1C8Z3to6Do7+2E27gt4uDxW08=;
        fh=0vB8ydkiCJSv9lwhBcBvY7IJYssmm8QM18anUgMqHg8=;
        b=ErLOHMr5ePCr8RZXHoodHjICnpazMT60Pkn2zrjhE7iZYJYwQkWyvpZZIxVlNNO+vp
         25YKVbTIMZ0Odmm+DqoHrMf2jGkGQv+T2fvCL0hLRX49nFk5/zU0y54j/ENXdbNRWg5T
         lt0G+P00XbJ+OIjEES502pqfHObvOaC9qSZQC3+RFJS/TzV2gLx8i9xXxqODYYQ3Spvz
         Glyi0JvbYAC/Rv43UVWDSleW3jO4SVm9LZPZl4LBYICFMElItDWKmCel2WfALLx1dzq9
         Cl12ubn+jsLlUKuFjlbyKtDK6LmCVbHohtL1vbPWtDYuwaU4vl5vcWOC6CIn85xlCSWS
         leVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20260707.gappssmtp.com; s=20260707; t=1795021192; x=1795625992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+eo4FKNzNbHf/eH43g1C8Z3to6Do7+2E27gt4uDxW08=;
        b=tsb3jtv/d+zI1r94mKuk01oFSXaGJ5VfBd68Dm3Rzy3k/9SLJEJI9zvC5ERx83P8mh
         L/1k5WahXt+pRRzhHcYHDMSRuJM1TjD5VHtPSmgdvcsE7bgjMsIlMo+YJOsxodt6BDKE
         WgZi0KNeAOjP6r2GiyTfd+fHBUESbduG4DYdClB/Bqst6T6AYc3Y24sbaheI8lu+qMGX
         3hhYwGZJIpgbaepiYwepZXr+V9cZ/bQz35fnXnkTNzQzPv5ISz2zAb8tKPjJ5JQ0vFBn
         iosrC4gHAY/nVJ74V0i+yTKb1wxgWpU8SzcVufvUcALVry0duvdDvm8V8jy8r4h1xcDj
         iTDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795021192; x=1795625992;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+eo4FKNzNbHf/eH43g1C8Z3to6Do7+2E27gt4uDxW08=;
        b=aCPDEk6DATUWoRiu7dhIzxQvvn4HHO8agxV8WGtFZ83uUxPdA1z0jG1qxlb9CawN+2
         uA+uDPHgI/eEr4gFb9SEkd81RSoMCwgnYXgN2Z9MleGCDcSDPZ0xOeR7OyOq1Eloolyf
         r6KkMPwIAWe9PMbp+qxew1RXjzqU8NVQpeFseu3j0hik5IP/a2kZq3P9+K/cS51C9FRp
         AefVxRBwmbzUQNGuG7eMvyA/DbTYT3C41WhXF80KqMKqMMsKkAWs6WPG7D3KAxkAt/t8
         XcdGS5KI71LeQxbGfSF4OZK1wQSsAB2LxrNa8VBjepv2JILzk6nSZurXcZbC9Abdu6BF
         LhbQ==
X-Forwarded-Encrypted: i=1; AL+hErGmzQmISU0z3elX57rBmOFps+IqwNnfcyZHaugQZudXSJa/PRZAO5NVZ1z1s/ClMygA0gSIB1RNaZXyLEDsntQaw4BNR1A=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LaimShxeu02r+Sevw9776QtvikbwbfAHUmNNimG2kyUCTSXrp
	INjjV9YjNgdrm5HCdwZWBUtPjTMbcnXtiTg06WIFRE+qXoHNbhQWqGerZ/87dZ1u3P+OhPLJmDv
	LRwLRGnlMYYjsBTji1dXuNy0pFLKi9bEv59OhQs8T
X-Gm-Gg: AYBFou1lg/xTSBc5z7hrdlRi1/eKob7By+AOIIsvWIqi6WEMwkmVe4WSk4AT+ptn3kC
	kVB0Gs4hg8F5Et36EXanPykVLYU6zpkRjqj9AvrGUYQc9dHj+UiLRZZ9GbTVAlG0/PObJBlFPLh
	D5rRkF2tDUnta7Lx4MI+DL6lp9m9pDxV2t7BJ6HHAdR3W8SAUOPB0CdiFzuH9Y9HWgaZJfwhbAj
	SYk0xeQttx/3HJ+H2CZVftK36qd/ZZjsdpD3YVtVbT5oXOIzecFhRIVR3Aut2ZGCjhK5BFsHVQ2
	NasDhY4+YbOvCAF968ByZlYgyGWw1vlMKssRe5Cp5gAitYkvJp5+z5OkVoncwGgS+u5VmGF1o17
	8oVtsr3sK/8GG3YNizEB/BYQDMWfvFN0uuQ==
X-Received: by 2002:a05:6512:318a:b0:5c1:4e41:3cdf with SMTP id
 2adb3069b0e04-5c1a9c09ccemr1012943e87.12.1795021192313; Wed, 18 Nov 2026
 08:59:52 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117231352.3816603-1-jarkko@kernel.org>
In-Reply-To: <20261117231352.3816603-1-jarkko@kernel.org>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 18 Nov 2026 08:59:39 -0800
X-Gm-Features: Aa3M54p70wvOKpegO09-C-J-9l2I7cJO4B_J5hynU_tjApdK664yCTjVeFp42MQ
Message-ID: <CALCETrVUkbpoFjwSAejyA4b_9qEauAP_36i=O8Op1ifp8aUkqA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 00/13] Namespace for namespace roots
To: Jarkko Sakkinen <jarkko@kernel.org>, josef@toxicpanda.com
Cc: linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, 
	Ben Segall <bsegall@google.com>, Christian Brauner <brauner@kernel.org>, 
	David Hildenbrand <david@kernel.org>, David Howells <dhowells@redhat.com>, 
	Davidlohr Bueso <dave@stgolabs.net>, Dietmar Eggemann <dietmar.eggemann@arm.com>, 
	Ingo Molnar <mingo@redhat.com>, Jan Kara <jack@suse.cz>, Jonathan Corbet <corbet@lwn.net>, 
	John Johansen <john.johansen@canonical.com>, Juri Lelli <juri.lelli@redhat.com>, 
	Kees Cook <kees@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, 
	Manfred Spraul <manfred@colorfullife.com>, Mel Gorman <mgorman@suse.de>, 
	Michal Hocko <mhocko@suse.com>, Mike Rapoport <rppt@kernel.org>, Neal Gompa <neal@gompa.dev>, 
	Paul Moore <paul@paul-moore.com>, Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
	Peter Zijlstra <peterz@infradead.org>, Randy Dunlap <rdunlap@infradead.org>, 
	Serge Hallyn <sergeh@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Suren Baghdasaryan <surenb@google.com>, 
	Valentin Schneider <vschneid@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Zygmunt Krynicki <zygmunt.krynicki@canonical.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 3:14=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org>=
 wrote:
>
> OVERVIEW
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> A root namespace (rootns) is a kernel object backed by a file descriptor
> that binds together:
>
> 1. A full or partial set of detached namespaces.
> 2. A dedicated PID namespace for spawning processes into, signaling
>    members, and polling or waiting on PID 1 exit.
> 3. An initially empty mount namespace (CLONE_EMPTY_MNTNS) that must be
>    populated before going live, without inheriting host mount-tree
>    ancestors.
>
> Work on this feature started in 2025 from David Howells' container object
> patch set [1], which I turned into a namespace for namespace roots and
> rebuilt around that premise.
>
> While the patch set is manually written, the original motivation came
> from isolating LLM agents. Running untrusted agent workloads made it
> clear that OCI runtimes need to minimize their live configuration
> surface.
>
> Assembling mounts, credentials, and namespaces inside helper processes
> with a half-configured container is what I see as the main challenge,
> and the existential debate around namespaces and container objects is an
> unfocused discussion topic.


I've skimmed some of the series, and I see a bunch of good ideas that
involve using an fd to manage a thing.  But I'm wondering how much of
the value is added by that and how much is added by having a new
*type* of thing: the "rootns".

How much of the value comes from the rootns vs the new APIs to
configure namespaces without entering them first?

For that matter, the cells series also seems to contain a (possibly
very similar) variant of the same thing.

Would it make sense to come up with a patchset that does *just* the
configure-a-namespace-by-fd part?  It seems to me that this should be
an easier thing to agree on, and it's a big part of the complexity of
all of this, and it solves a real problem even without
cells/rootnses/jails/whatever.

--Andy
