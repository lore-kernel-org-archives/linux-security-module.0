Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E47A22B64A
	for <linux-security-module@vger.kernel.org>; Thu, 24 Oct 2024 19:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729798633; cv=none; b=drF8hj4qBldDmJz2yl68lRwCfj3MUxiA3E3aP09bzBkZrpDwuK9ATp83FswyNde5Rs9dUfPj/OViYfrYHOY9iOTUpUiPa3/OZI//2YP1X8ZkFWXFNEkr1riJpVYfdzWt+GXCA7/DggNmK6icyEcqA0oF9lnc7yxH3d+s+Fg826A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729798633; c=relaxed/simple;
	bh=cK6bBwEwe8Knb20h7wlOE2i2Cfj9jY4wKifjSI62suc=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=J2eNBPh35pdlRazLIiG/5n1jVGoz6pfZUwpefIGm0e4pDX2E5iydpMWufinaqFcbMpOaa4PxqR97IU6LVkoeWNI3bL6txmnoB2uwoOkVNE5oLE/Y4g9NGXXHsf7kH4wSNEgBmKY9zbH4NU4VHo08ft3+REPY2LpJKlb8GEgz9yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RLA4f60q; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RLA4f60q"
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5ebc22e6362so676153eaf.2
        for <linux-security-module@vger.kernel.org>; Thu, 24 Oct 2024 12:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1729798630; x=1730403430; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dgNeK1Z6KIWekDlGcWVDGGoz1nSoRxMds735VUHAEPg=;
        b=RLA4f60q2T3ibemSBNLMOvtbq3s10cgLlSw3nLz+U2k9tAwtnA7jxDDc2YCRWmB1KJ
         E7kHJ5qVMlRXHkTiqdYCTQVWxAhRzVmKFZYARnFO0Vkue86RMu481fKcWhCV9OCWNklQ
         a0mg6UezO9xylH+h7xXcCmbYTnKujq4Awn8ZGXheVbR5yIy17DNOXhX1YgPw9Q3WVKUT
         0EZTIOjACF/yF7dlPXVUK3jwYoLB7rLxKraj6D2BU07Ux2lHQfKdEh59GMLWiP2y6faD
         7KzwZKU2oRDFZ6QELtI37yvxTnDcPphesOrli0Ob6GVWNbnYJEPazNa2e8wlA69WuMs5
         MUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729798630; x=1730403430;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dgNeK1Z6KIWekDlGcWVDGGoz1nSoRxMds735VUHAEPg=;
        b=PS2o+L9XsoduVLe+oRRkkgjwkCvWBp9q8z/m79e1LeqhBsG2KxKAcGFAM2Xd3chVIG
         RqHdbF+ifKCyjKTS1bcgHZDpWPc2k4LcB1yhHAu4Gd9enRxOR5A//rEzKuqX5IzLpuXY
         Q6rpsuttCxJSOyqRlWbFU4x006p3yUH0k5hCfSsYE5J+YO970lrdpHVEmtXnur9Or1VH
         wpkvCH6SCPyj9RLkpv8xWHuFsF3QJqas2TJB7JN+uNP7mTDs2DGkT+jB1pm/j5dpqeta
         no/8K0yIdM5BZP6Z3Aaor9wkOAuQwRoCdpsYm7sghl4AAxSyB3z+yG1nnajmgmI6WaPQ
         QFKw==
X-Forwarded-Encrypted: i=1; AJvYcCXg+yg7NlJ7gskaZbGKn2409M+NV+8ZBDZEQmGkGHYhSe0oyIf4YC6bwXJBYCH7lhjMe5yWNd/12TpGjMC6MzYHhc8vLTk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV6twZpczftpxhDG/7UW51slEALY4lZoUBQDoDPeT/V3jr+LEZ
	fNAa/65zmnPhT8zWL/5uPOksMyUFktuRgSMNuEdIbUP/Z6JfYoLlwjdgPPt3Iw==
X-Google-Smtp-Source: AGHT+IGDaCeBHQn/6q/o/rgDKzA3P9FSd8bJpnIlTLiZTxBcrw+C7QpjQy37LPEKmKd5AyfsYIF9CA==
X-Received: by 2002:a05:6359:5fa2:b0:1c3:7b75:24ec with SMTP id e5c5f4694b2df-1c3d811d147mr531244255d.15.1729798630471;
        Thu, 24 Oct 2024 12:37:10 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b165a892cbsm512196885a.136.2024.10.24.12.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 12:37:10 -0700 (PDT)
Date: Thu, 24 Oct 2024 15:37:09 -0400
Message-ID: <0920e116b02c7872e6f1897afbe3f702@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20241024_1524/pstg-lib:20241024_1230/pstg-pwork:20241024_1524
From: Paul Moore <paul@paul-moore.com>
To: Jordan Rome <linux@jordanrome.com>, linux-security-module@vger.kernel.org
Cc: linux-trace-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>, Yonghong Song <yonghong.song@linux.dev>
Subject: Re: [PATCH v1] security: add trace event for cap_capable
References: <20241024104012.1815022-1-linux@jordanrome.com>
In-Reply-To: <20241024104012.1815022-1-linux@jordanrome.com>

On Oct 24, 2024 Jordan Rome <linux@jordanrome.com> wrote:
> 
> In cases where we want a stable way to observe/trace
> cap_capable (e.g. protection from inlining and API updates)
> add a tracepoint that passes:
> - The credentials used
> - The user namespace which needs the capability
> - The user namespace that actually has the capability (if one exists)
> - The capability to check for
> - Bitmask of options defined in include/linux/security.h
> - The return value of the check
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  MAINTAINERS                       |  1 +
>  include/trace/events/capability.h | 58 +++++++++++++++++++++++++++++++
>  security/commoncap.c              | 21 +++++++----
>  3 files changed, 74 insertions(+), 6 deletions(-)
>  create mode 100644 include/trace/events/capability.h

...

> diff --git a/include/trace/events/capability.h b/include/trace/events/capability.h
> new file mode 100644
> index 000000000000..092b8e77063a
> --- /dev/null
> +++ b/include/trace/events/capability.h
> @@ -0,0 +1,58 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM capability
> +
> +#if !defined(_TRACE_CAPABILITY_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_CAPABILITY_H
> +
> +#include <linux/cred.h>
> +#include <linux/tracepoint.h>
> +#include <linux/user_namespace.h>
> +
> +/**
> + * capable - called after it's determined if a task has a particular
> + * effective capability
> + *
> + * @cred: The credentials used
> + * @targ_ns:  The user namespace which needs the capability
> + * @capable_ns:  The user namespace that actually has the capability
> + *               if ret is 0 otherwise this will be NULL
> + * @cap: The capability to check for
> + * @opts: Bitmask of options defined in include/linux/security.h
> + * @ret: The return value of the check: 0 if it does, -ve if it does not
> + *
> + * Allows to trace calls to cap_capable in commoncap.c
> + */
> +TRACE_EVENT(capable,

This should either be named "cap_capable" if you are only interested in
the CAP_XXX capability checks or "capable" if you are interested in all
of the checks that are performed when capable() is called from within
the kernel.  Presently safesetid, apparmor, and selinux all enforce
access controls when capable() is called, with the potential for
additional checks in future kernel releases.

> +	TP_PROTO(const struct cred *cred, struct user_namespace *targ_ns,
> +		struct user_namespace *capable_ns, int cap, unsigned int opts, int ret),
> +
> +	TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> +
> +	TP_STRUCT__entry(
> +		__field(const struct cred *, cred)
> +		__field(struct user_namespace *, targ_ns)
> +		__field(struct user_namespace *, capable_ns)
> +		__field(int, cap)
> +		__field(unsigned int, opts)
> +		__field(int, ret)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->cred       = cred;
> +		__entry->targ_ns    = targ_ns;
> +		__entry->capable_ns = capable_ns;
> +		__entry->cap        = cap;
> +		__entry->opts       = opts;
> +		__entry->ret        = ret;
> +	),
> +
> +	TP_printk("cap %d, opts %u, ret %d",
> +		__entry->cap, __entry->opts, __entry->ret)
> +);
> +
> +#endif /* _TRACE_CAPABILITY_H */
> +
> +/* This part must be outside protection */
> +#include <trace/define_trace.h>

--
paul-moore.com
