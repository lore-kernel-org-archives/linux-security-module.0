Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793823298;
	b=3oMLtJoHBfTU9F3oWiCHcLU6NPYSBUrpwN53x+qUCAlNdo3idTjCA+TrYzTiMwALyrlF
	 Ff4L7iXwy9E6hVRyot+1fgxhTPHonDk4N81kiwIbCq2zhwr/jt3PagmS7HLHGmoW3q2cU
	 W81SJKXmQbf2VPccrjRrwlgoHPJWObeHhSwm9Jkgn+fIibwustGPVMP3EsE92fPAyz0dj
	 vs1tIVXKL83KYU6ZJpJtJ/aP2AVtyb0PBcvCmiwve5PmK+PuqVCzpDHtD/BSnSMQXbEwI
	 28iVG3uVQPiuZVJZBhCbPiebDZ/ZFFIOGwK1oGkgB0i/Ujl1gbjeykYYVE6ePTDbS5Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793823298;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:MIME-Version:X-Received:
	 In-Reply-To:References:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type;
	bh=AS/luxCxZZ4IKfwOyJu4Ue765u+vBG+6P6QAZr4AiP8=;
	b=Nln6Fhniqyi8idt3T+CX13yXCZJjk6fBGhM9ST7UyAQX/oQc/kmLAECb3nHhW6QgZaks
	 CTgEybXJNIwI8Dnh+yIy04yiRAxA55RS3URcQqIh8mSZSu5YIa8pceEy59YZS50UfBAqJ
	 i+816WYm536vu8FdilNHC2wP/0sOS61R4/V8uS6Kgy18+jClejFD5S8v3wTcEz4LYaVnG
	 nxbGDPIxfwzdhWiDJnmxr90BrqtCSvk3rnxRtOtXgrRzI3CizAShfUkk7nTTj0+xfjF4I
	 eppQkRsCqzfw9ym+C2Uawztb9KM5rDgSM6GldqU+esCDMZ7s3RdIe+g0V4nRoCRzq8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jeffxu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WOmd94Mh;
	arc=none smtp.remote-ip=74.125.82.198
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com [74.125.82.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38A2160B88D1
	for <linux-security-module@vger.kernel.org>; Wed,  4 Nov 2026 20:14:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38A2160B88D1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeffxu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=WOmd94Mh
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-341eff9e381so1961044eec.1
        for <linux-security-module@vger.kernel.org>; Wed, 04 Nov 2026 12:14:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793823296; x=1794428096; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AS/luxCxZZ4IKfwOyJu4Ue765u+vBG+6P6QAZr4AiP8=;
        b=WOmd94Mh+1IsHCPkayZDec6JPAxqUizBUQICw7d1GTvFYhvGyIcRDUYVGA4mrhJ2Gw
         LlwBfvWxf6C/dkbd/wYeCVyGFNqSQNTNemKeHNozM+B3thODy6YTQUG8zPI+Zc0fLAsc
         ywPjVR6u2U7pkPrIYEEEE7pR/Fv2GUmpGF5C6hZYbFhN+xzjvjlTlZgt1yXCOuMk8ZV8
         7dgvN0RspKuuDt9X8QL4OxxBptYW7RdbVtxUU3AipSC6ioGA6dVwnv5HTegyIPEZQbol
         lNJjqnZui4CPRajfzE+ydyWOkaI+BYJB/fWwmMyfr6ch4/bN/0JzLGDra0aJW3LNaEPF
         9UKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793823296; x=1794428096;
        h=content-type:cc:to:from:subject:date:message-id:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AS/luxCxZZ4IKfwOyJu4Ue765u+vBG+6P6QAZr4AiP8=;
        b=o3+RV7c5hbNJ6yfKRFNePPfof2cT+hoD5IglPNdNdTwgzUbuPAZAKq2gSwUxpyUu/X
         WC1kvzqJXtxFysvY+LtQCXZrRAdL3LlayGb46ub3mpiLyPMciYRTk66lXzIu48qGXyQk
         hHqIDRrVNCus99OjiILQjidALpYEDLOt7QS2HoOe5OXHyxEN0dbRZ6qlehC/7TWY7wE6
         olnqZmrN0JsibovuJ2bfULbXEUZ1lGMKLbiCGVUG8uo6bqHb+miGgmgYCiheZAXAGq1G
         6p+ReY1wdyKgso/14LFlWtVXg1sKPDKNg5nW+LnmlaFELeuV2Ig+95JWAJMfD1LrtC3u
         jWEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgZMtS9X/mZt+X8YCk1wqmJr89zla7soKDYyFR6+DO99VdCt+wflm+ZA+4rWBWKh0mS3zTkqItubF6tk02nFePEhFQOuI=@vger.kernel.org
X-Gm-Message-State: APuU4Z9FIoF/M1BzhGMac9xzBQxDFk5dGvIcaSfgIG0MiQ5YGOflllZN
	b+Ic/MtTBtD2Hpf+aExGwp0iP/jOjdeefCtFlvubPdVKSzV1okgfCqGq2k6AW7igVWyFH8WGf14
	06VB4LA==
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: from dybkf8.prod.google.com ([2002:a05:7301:3a88:b0:36a:e67:fbc2])
 (user=jeffxu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7022:1608:b0:185:4ad4:3d15
 with SMTP id a92af1059eb24-1ac56302329mr19203878c88.1.1793823295901; Wed, 04
 Nov 2026 12:14:55 -0800 (PST)
In-Reply-To: <cover.1793718940.git.chris@chrisdown.name>
References: <cover.1793718940.git.chris@chrisdown.name>
Message-ID: <18e4f0c895c8d2ed.3137322e32382e342e3434.27cc5b.0000sendgmr@google.com>
Date: Wed, 04 Nov 2026 20:14:55 +0000
Subject: Re: [PATCH v2 0/8] mseal sysmap: Choose system mapping sealing at boot
From: Jeff Xu <jeffxu@google.com>
To: Chris Down <chris@chrisdown.name>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>
Cc: Jeff Xu <jeffxu@google.com>, David Hildenbrand <david@kernel.org>, 
	Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Kees Cook <kees@kernel.org>, Andrey Vagin <avagin@gmail.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Shuah Khan <shuah@kernel.org>, 
	Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Jiri Olsa <jolsa@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>, 
	linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, linux-arm-kernel@lists.infradead.org, 
	loongarch@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

On Tue, Nov 3, 2026 at 11:17:43PM +0800, Chris Down wrote:
> System mapping sealing is currently a build time choice. Hosts which
> want it and hosts which need to move or unmap these mappings therefore
> need separate kernels, which is not ideal. Let's allow the administrator
> to choose at boot time.

Thanks Chris for the updates and for adding the unsealed boot parameter
test coverage! The v2 series looks good to me.

Reviewed-by: Jeff Xu <jeffxu@google.com>
