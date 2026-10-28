Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.197
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793168197;
	b=s0Wra67KDc2dklsjIHHbCBWSEUBliSCUu/fvKNZzQgzhmFvgpAZhpSkcxLEZ6usGnYpE
	 Fx/ciOr9ipTC7Y5WnpeolmCMsp+ZgrgKUzdcAijuXS3QlVnGyvtPU6vO0T7vVLmNdw6wu
	 F+hrq3D4GP/PapJzX4UqjA7y42FMTbCXFRKaHLf0mhUzSZi2mLqb+tGr5/n8joZaZDl3V
	 F5+k8JrfDyl+i8Ic+Mo5HAJuIoivGLEmzWLHAD7jycn15elkZBwohzUBMpqPM/o37qw5o
	 SEVWbTEk3PHGE8/55SjTTVW/GnKXB/LKz1RYXk3IzxJvXwiZs7V+/QkOWbsQLk45xBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793168197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:MIME-Version:X-Received:
	 In-Reply-To:References:Message-ID:Date:Subject:From:To:Cc:
	 Content-Type;
	bh=X4wg8Pbjg2SQve6wgEy6XvKbvCoQemBjrt/2F9Kq2TY=;
	b=m4gi6yFBgBpKYeoiArdf4U1DmnK/T6Ku0GhaiNorQlwudGXk/ySgu5iHtnU3BjzTW2/8
	 6U0ZrYepw8AvNKlJZCgXrnb80a5t1kO09xC5p86nP2CurFG0ZZ4hizN8ituMfK2vxhlN5
	 bs750FTK62aX/v4Rgt3UhUdmV1t64URpJ4/YwB0moV+gWMxC2rFiS79YlYpobDdPQxBIY
	 hyunrhA4z19Ch7TBKUUQunnEWwowJNQ1oGjxyZZoXsFY8YF8OMekJq/rwG/dL/CO2Yk+T
	 wkdQHxRRMc1gRfzB3D4nohnJUEZl/MSgu9szXF02uX4HyZdDqUKntrfnD8TXt2HXJNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jeffxu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C6Pudu23;
	arc=none smtp.remote-ip=74.125.82.197
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4FC606A322
	for <linux-security-module@vger.kernel.org>; Wed, 28 Oct 2026 06:16:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6C4FC606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jeffxu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=C6Pudu23
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-35cbea41088so944971eec.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Oct 2026 23:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793168196; x=1793772996; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:date:message-id:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X4wg8Pbjg2SQve6wgEy6XvKbvCoQemBjrt/2F9Kq2TY=;
        b=C6Pudu23merR8N3QUSSvCl7wNv2iJ4wZUywbEvQhTfxkkwUD1bmyJMvQ2INlo/bCI7
         3J2m8hD96wmYaDz2HNVTnKY7bDC8tFyaNdiOM1QFSV5826GR/S9EbVVncFbiq7dSSy2t
         w24/QFazfb8wG5dHVpT8H928MituPMKXEXB8snmifr3Gc2O/tC3crUaeuJw9TS9d5Gvn
         r5pkfFwogZZk3Efst5f17eYYlK22KsZS0vTvX+rFSthgeT4zRTnDzcMhm7e0c3Erq6Sh
         bhACPNNEje+m79G8yP5AhOuwbfhrViJl3Ag1sVFrnaEc56uj8+6SQualB4meyXj8OWeW
         6OeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793168196; x=1793772996;
        h=content-type:cc:to:from:subject:date:message-id:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X4wg8Pbjg2SQve6wgEy6XvKbvCoQemBjrt/2F9Kq2TY=;
        b=PXMa7qasn4pKEZvTA14hCFxn4CeHi1TX3m8AFRGr07ETsKRCLGLid4ONcv84feOqSW
         iQaX5sMFh9k7+cvhhQpkSv8LguQEJ8FD/z8xjSqFTML5wwr+iSJ/iAb3NYijI6SRexLL
         Tao2W52be67KNjkHOkTJNyMouOMy9creA3hYNxZWenvuN/nApwbEbrGvHJXRAfjSok9U
         LF/iimC/GIDCV4W1tVxispDVMXTmOrl1/9OIK47Iw+R++UAe6eUff8JOGLFhdEaer2A6
         JCq7gaq+PQChpU6rDD4VmxPbmvqsdadYHqbS37PfdwVDaEAGPcT+QSo08+3dnmRT1u2u
         9UzQ==
X-Forwarded-Encrypted: i=1; AKwUvBx8w3ORA1RkXMvGj7aG76i+oqwPMgrX2BeEnLALUN60VH65OsMdKb61YOBPafeqJm23oxDXnAuO2nDv/KhoGInb1jX3nw8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLYWd8GrLCbYQiReLX8Lppnsnda5/FQJ1luOI8vHwM3tMqTTip7
	WrVAvwEtLxqMW2tA1Ww18pX9RUlqJ3VJpdCXZJY2lQWZvb5vM+1gWi1X51nM0YGYIe9dTVGpN1X
	5eFy0CQ==
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: from dyx13.prod.google.com ([2002:a05:693c:820d:b0:36a:1d37:273b])
 (user=jeffxu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:7301:6195:10b0:35d:95e4:267d
 with SMTP id 5a478bee46e88-36a200c3b89mr2179969eec.27.1793168196147; Tue, 27
 Oct 2026 23:16:36 -0700 (PDT)
In-Reply-To: <auGOXLB1XZFWcTfX@chrisdown.name>
References: <cover.1793094611.git.chris@chrisdown.name> <5bd3c89d733ad22224f296dfa8900769de937de0.1793094611.git.chris@chrisdown.name>
 <auCxjbvY3qPv1sV6@gremlin> <auDTMb6WMFUpxeZy@chrisdown.name>
 <auDTptDQsB4xBcz7@gremlin> <18e2972cb8520c2e.3137322e32382e342e3434.279dd1.0000sendgmr@google.com>
 <auGNkhSHpBRd2U_5@chrisdown.name> <auGOXLB1XZFWcTfX@chrisdown.name>
Message-ID: <18e29cf9499c7ec0.3137322e32382e342e3434.2a28ab.0000sendgmr@google.com>
Date: Wed, 28 Oct 2026 06:16:36 +0000
Subject: Re: [PATCH 1/3] mseal sysmap: Add mseal_system_mappings= boot parameter
From: Jeff Xu <jeffxu@google.com>
To: Chris Down <chris@chrisdown.name>
Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Jann Horn <jannh@google.com>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, Kees Cook <kees@kernel.org>, 
	Jeff Xu <jeffxu@chromium.org>, Jeff Xu <jeffxu@google.com>, Andrey Vagin <avagin@gmail.com>, 
	Alexander Mikhalitsyn <alexander@mihalicyn.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Shuah Khan <shuah@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org, linux-hardening@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes

Hi Chris,

On Wed, Oct 28, 2026 at 01:55:40PM +0800, Chris Down wrote:
> Chris Down writes:
> > - Have check_sealed skip as usual when [vdso] isn't sealed and param
> >   is not set
> > - A new test, say expect_sealed, fails in the same case
> > - run_vmtests runs with -T expect_sealed when
> >   CONFIG_MSEAL_SYSTEM_MAPPINGS=y

> Er, the other way around. I meant vm_runtests passes -T expect_sealed
> _unless_ CONFIG_MSEAL_SYSTEM_MAPPINGS=y.

Using kselftest_harness's `-T expect_sealed` together with checking
`/proc/cmdline` for `no_mseal_sys_mappings` in `check_sealed` sounds
great to me -- very clean and covers both regression cases without extra
argument parsing.

Thanks!
Jeff
