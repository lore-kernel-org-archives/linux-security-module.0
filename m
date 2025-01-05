Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4427612BF24
	for <linux-security-module@vger.kernel.org>; Sun,  5 Jan 2025 02:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736045119; cv=none; b=W8iGg6ttl/q84L+JLpECCf5aIq4sXXo0echAqmd12lSw0mbyACGc0Dneme6K7T6aZ4+0xgiOnbk50iVDRXdIGFCVEEBx1lJYcJthiF0IWjA/pOZ1Et0H3k8Xee4fIJCqUBsjXiJ/kVu7ysCi6auus7RM0w6dOyOr7Ao2pTcnYRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736045119; c=relaxed/simple;
	bh=2niM7QSDO7vIA7tySXm3RyrEBzfXKmBzlRoR6+V8WhI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gqAycbtCHS8Kyghbr6VLDG903JaItTQHH5T7nj23dehxYLnGy3jdgFynQqLW2WQo/kSb1dhdB7HfTT8YxIu32cMYTB4llh7oZ+lwvNqSoxRuebXb6n/haFAW4mUjBalI3Ye8d4aa+tui7CKOfqS0CYC7NuZpBU2fg3mrh6rzgrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=bsfY9nbF; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="bsfY9nbF"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e4930eca0d4so17101904276.3
        for <linux-security-module@vger.kernel.org>; Sat, 04 Jan 2025 18:45:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1736045116; x=1736649916; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GUhUFqDCLLYcCKnTvKrRzZf5y8VDBYHwWNIj7mYbRr8=;
        b=bsfY9nbFARMvkb1N/MALpH9KXMi78I91FMkxsnz+qHOS6IG4tNJpDRWr6ESQhX0MxF
         T8Jvan12nnhMkqtDC5xblfEbvCOh3TfamTLQlkeJTAodek3qanTvZwP8WBk9A2rCjwFF
         T9Oc9bN1Bm112n/wlUpaF0isvHiqfQuegGWip84hynRWzuJ3tTPDvtuOIgyKLERvhNzP
         K1OxIzlcneyobBD6Jft+D7Cl5YkSHgrYXjxoQcA21UStVnfOSkFQyDZhdg0nU2r7Lz+x
         S+avvDgG4boTYB3m8Xjvql+EbOQhQ/b8464iP8yM7dQ+hVtzV+wuEQY4UN0gcMquXqbA
         vqog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736045116; x=1736649916;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GUhUFqDCLLYcCKnTvKrRzZf5y8VDBYHwWNIj7mYbRr8=;
        b=Jcbzosk0igFqMpteYdOOITGE+PkgHIZMBrg5KYybOT+00IVrB5oVdPfKoo1cPDlmC8
         KuXA/ufh3tI9QWcEtCvsc1QLteASGb0o9LX6F6PyBMoIBN+jWTKIN0ljkLQjFXWvYhqa
         04svcUcdlACbOjcEX7L8Xu3K5tKynTBayMtEkVyzi+U/MPSize/ZdX0PKX1GNbl4cfSM
         XPN74+W7SEAQCjMe4E3jEgIUehzdLJmP+eDntAQ/ZMg+uXh1rKp64gPyjtiyDds69RvR
         kxvActb4tYyvvU2XenMlNgf/AHvcA2818s3R+17hgs/JVmpywhvaQPpbW7BAeqolyhKe
         uyBw==
X-Forwarded-Encrypted: i=1; AJvYcCXEVcKbx8yWFG4WEhimV78DSp4uovtGmMfWPtorSgMjMAwmYYCTufINUR+sizAPAaEvmxNqkmsQsFNv/OugiRoPLhwoeig=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWr+BQtEQHmCFelSZzgR9EQRVHodO6mmubgtQTXs2rKHMZpMuL
	KxJQ5gSyUSNeYwQOJyd74IJAK1/USODhyGxbePF3Mimug6KZDoNeWCpFWkSZLQGs6I/qy44EvRE
	hJ0yx16qPgFG5ZP5SjJPhPpEUiJCLFvgh0eAn
X-Gm-Gg: ASbGncvlZl0IT1e4RECBsyL9uOt62Yd2C/9C5zTOt5oqbJECR6HqcGV5azFBlHX4ft/
	juhoyfO+n4tfuSNe+0BS0FadI4t4o6iED3Rlf
X-Google-Smtp-Source: AGHT+IGThgi8HmQDrrdLZKo7/6iXHtT/+1efSKbFMBP4wTU/9vzStB4XDWagUs38rOJg1HKyWbfdsUnbP2IRzhgHd+w=
X-Received: by 2002:a05:690c:4b05:b0:6ef:801f:437d with SMTP id
 00721157ae682-6f3f820e12amr435589197b3.26.1736045115828; Sat, 04 Jan 2025
 18:45:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241223070650.2810747-1-luogengkun@huaweicloud.com> <20241223070650.2810747-2-luogengkun@huaweicloud.com>
In-Reply-To: <20241223070650.2810747-2-luogengkun@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Sat, 4 Jan 2025 21:45:05 -0500
Message-ID: <CAHC9VhRRu-UYEV_-0-QgOZ3ByVwp-ZdEphmsvy4NcdqynH_tDg@mail.gmail.com>
Subject: Re: [PATCH linux-next 1/2] perf: Remove unnecessary parameter of
 security check
To: Luo Gengkun <luogengkun@huaweicloud.com>
Cc: peterz@infradead.org, mingo@redhat.com, acme@kernel.org, 
	namhyung@kernel.org, mark.rutland@arm.com, alexander.shishkin@linux.intel.com, 
	jolsa@kernel.org, irogers@google.com, adrian.hunter@intel.com, 
	kan.liang@linux.intel.com, tglx@linutronix.de, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, will@kernel.org, 
	jmorris@namei.org, serge@hallyn.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, stephen.smalley.work@gmail.com, 
	omosnace@redhat.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 23, 2024 at 1:57=E2=80=AFAM Luo Gengkun <luogengkun@huaweicloud=
.com> wrote:
>
> It seems that the attr parameter was never been used in security
> checks since it was first introduced by:
>
> commit da97e18458fb ("perf_event: Add support for LSM and SELinux checks"=
)
>
> so remove it.
>
> Signed-off-by: Luo Gengkun <luogengkun@huaweicloud.com>
> ---
>  arch/x86/events/intel/bts.c     |  2 +-
>  arch/x86/events/intel/core.c    |  2 +-
>  arch/x86/events/intel/p4.c      |  2 +-
>  drivers/perf/arm_spe_pmu.c      |  4 ++--
>  include/linux/lsm_hook_defs.h   |  2 +-
>  include/linux/perf_event.h      | 10 +++++-----
>  include/linux/security.h        |  5 ++---
>  kernel/events/core.c            | 14 +++++++-------
>  kernel/trace/trace_event_perf.c |  4 ++--
>  security/security.c             |  5 ++---
>  security/selinux/hooks.c        |  2 +-
>  11 files changed, 25 insertions(+), 27 deletions(-)

This patch seems fine to me from a LSM and SELinux perspective, but
I'd want to see an ACK from the perf folks before I merge this.

I'll also leave patch 2/2 for the perf folks as it seems largely
unrelated to this patch.

--=20
paul-moore.com
