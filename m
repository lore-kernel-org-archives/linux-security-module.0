Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1851922B8A6
	for <linux-security-module@vger.kernel.org>; Tue,  6 Jan 2026 12:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767702552; cv=none; b=A0aPPQAdAjQmJhtkkr5SdNkpuruAgP9eWnXUNTNGyhs3UAht9/WshKuYqt4V1y8RmeQWB/Ee993Bntt2hLG27DA4v9I/wufkAZxNWOuXVxKXsmU3+BSBc98LPCNxv19TbSU9G7yhEDzrc3dkcX1W3hTNQb+EcWBs/oh3L8aok2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767702552; c=relaxed/simple;
	bh=wXZzH27gnUDagNl5a0ME5KVazZHyReqGn/kmzzyAPc4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=c8Ot7rS868hi/RC3FfRkZN71wF3djHBxrtJFhVGSduYG4Zt8E/6RR0hUJx+xjWfyYSn4H9CQGrJyN5ABognahIOYq3Kp/NmZ3ZvLL+Q6buqN18Xc4zFzsdklqSmSuY38KwOB/YBKw1epoA4VNfwAkp4qao0FUIISaBdc72x33BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OWUnrMCK; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jackmanb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OWUnrMCK"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4775d8428e8so7598105e9.0
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jan 2026 04:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767702549; x=1768307349; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pZdwAP/wq9kuKKVzLJ5M0q6p8KUwTZW9kKk5Fbt3zQ=;
        b=OWUnrMCKUalOFZT/gUYHr07AWT2rTRwrSqgqxeuDxnE0z0GZZ+NGPZ+hCJf4Ir222K
         K4otTyiq/JnfKQtblLaZ+v44nK3+hDCbknid3jMOiVfU2GBRk1KjJXszrsdQS2XhlacK
         2kOxEL3hmQhCLdGQcQIs9eO+bjL2/JjZoXlFQ6ukfhnjiuQr/9cjGGPBByYHGsGHCw13
         VUWO7pEgb64JcKpaVdWMADfIo8hUd409h974cDRdGb7Tun5ff7AXVNDT73pTDjHTxWzN
         4dazhgDBfqXyaeY1Zcz1nhK0WLMXJ6R3CqKZMFBnOq6YlR+XkHAE6kaoND/u6Ir6lbRe
         1SdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767702549; x=1768307349;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/pZdwAP/wq9kuKKVzLJ5M0q6p8KUwTZW9kKk5Fbt3zQ=;
        b=S9wsUpCH+24MG5gXKnJ4CAI55mCBcbQ0lyHwpIp7WsTqAVKNr87WDfAtzLXvgGQaMq
         mvxHC12joD5QOUs4WKPvGXAkvNmGZsg/1Po2PHvbDfM1ssP1BTk6PHjr24H2wyb00s1r
         BIZIx+ueUIVksFJsE5SkL/rm10JhUJsWdQyiFzAIPXYEy884bb0A4kKi290USOrz9NAK
         /DSF5eA70OA8wLp1rRxMSBI1shdF6uh3eCvOgu2/3gewj2q3tZwdFESjnlsGTFSsgcWA
         SabkXKMSzHfCSbbWl5EQCs4DScICxn+GfEqjx6cP2S2M5ThZ7M6iiMuBe1/jUP55xU60
         EM3A==
X-Forwarded-Encrypted: i=1; AJvYcCVQ7v8VZjyAhpsGcVOGri5tWv3QQWy29sa0P8LEh+1zs5shFcffZHWuGz/ClBdRwS2fIgDK93vLnOxHfTmX1nNmT9wAoio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1VRxLI9XaGbU6pJ7HE5woDdDGYyxSbsGf+wZq2VL+zqPTbRQw
	gq/DOfvHD4g8Th8YhDDv2gAhd/67dYATTTU1gDtBI8gAmMDfH33w+V9f4MWoBQcH+JJcWPvy+bW
	341dKXW0uBNv3vw==
X-Google-Smtp-Source: AGHT+IGDb5uS6PkHdgGZm/vN+neaeuomXNsUF5fH4vDNKaBbgCTUgMqpCF8VtoYm6kaWCOvj+sJGU4W9OTyeoQ==
X-Received: from wmoo8-n1.prod.google.com ([2002:a05:600d:108:10b0:479:36b0:ff54])
 (user=jackmanb job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3b27:b0:475:da1a:5418 with SMTP id 5b1f17b1804b1-47d7f062feamr32360515e9.1.1767702549472;
 Tue, 06 Jan 2026 04:29:09 -0800 (PST)
Date: Tue, 06 Jan 2026 12:29:08 +0000
In-Reply-To: <20251016104409.68985-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250830163949.20952-1-reddybalavignesh9979@gmail.com> <20251016104409.68985-1-reddybalavignesh9979@gmail.com>
X-Mailer: aerc 0.21.0
Message-ID: <DFHI984SEFV3.2JL88CLHNT2SO@google.com>
Subject: Re: [PATCH v3] selftests: complete kselftest include centralization
From: Brendan Jackman <jackmanb@google.com>
To: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>, <akpm@linux-foundation.org>, 
	<shuah@kernel.org>, <richard.weiyang@gmail.com>
Cc: <david.shane.hunter@gmail.com>, <khalid@kernel.org>, 
	<Liam.Howlett@oracle.com>, <davem@davemloft.net>, <david@redhat.com>, 
	<edumazet@google.com>, <gnoack@google.com>, <horms@kernel.org>, 
	<kuba@kernel.org>, <linux-kernel@vger.kernel.org>, 
	<linux-kselftest@vger.kernel.org>, <linux-mm@kvack.org>, 
	<linux-security-module@vger.kernel.org>, <lorenzo.stoakes@oracle.com>, 
	<mhocko@suse.com>, <mic@digikod.net>, <ming.lei@redhat.com>, 
	<pabeni@redhat.com>, <surenb@google.com>, <vbabka@suse.cz>, 
	<linux-kernel-mentees@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu Oct 16, 2025 at 10:44 AM UTC, Bala-Vignesh-Reddy wrote:
> This follow-up patch completes centralization of kselftest.h and
> ksefltest_harness.h includes in remaining seltests files, replacing all
> relative paths with a non-relative paths using shared -I include path
> in lib.mk

This seems to be breaking the x86 build for me:

=E2=9D=AF=E2=9D=AF  git checkout e6fbd1759c9ece5044d3470f30a5e2166dc9de89
=E2=9D=AF=E2=9D=AF  make -j mrproper
=E2=9D=AF=E2=9D=AF  make -sj100 defconfig
=E2=9D=AF=E2=9D=AF  make -sj100 headers
=E2=9D=AF=E2=9D=AF  make -sj100 -C tools/testing/selftests  TARGETS=3D"x86"
In file included from syscall_nt.c:17:
helpers.h:10:10: fatal error: kselftest.h: No such file or directory
   10 | #include "kselftest.h"
      |          ^~~~~~~~~~~~~
[...]
=E2=9D=AF=E2=9D=AF  git checkout HEAD^
=E2=9D=AF=E2=9D=AF  make -sj100 -C tools/testing/selftests  TARGETS=3D"x86"
[builds]

If I just revert all the changes to tools/testing/selftests/x86/, it
builds again.
