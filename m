Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F55B4F211
	for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893708; cv=none; b=f2OCw415XtM3fq+rndOm+BL2Hv6DTk6lACxLwjlEtXffpl8M78N7oWTguZqvDT+JmjQ0hFOh7iLVwff3K7HYdQBTxY8zkp1hDTJ+BmMvSusrIi9S0sLA2RTfZmGjXkxlpaoLYEvujAV1Vv/BRiSH957ZoydrjezZKnOh0VYMbvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893708; c=relaxed/simple;
	bh=otjxl1XpViYm/3qcSCYio1XXFgV44DKbrx2s+qJRjN8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avKpCzoFrIJwIk41gXIPrm0RQzWd7XrrMsOLByXtoAqOlD5dq4VjUro1i6+SeypEKP9A67ABBExbzh9x8Yuwj8Nj9TUbmmYpQ5sdDQ17cdm51NZr8xz1VeKmzcJrISZssK81RJRUEvHt7HH/ogYe1gT3yW68szANG6MyzVUyifE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eGXxYXHS; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGXxYXHS"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70435f4c330so893153b3a.1
        for <linux-security-module@vger.kernel.org>; Thu, 20 Jun 2024 07:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718893706; x=1719498506; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XR7wHT13iygLkcIEjWAfVaOtnqk5nw86T9eqiSlk9K8=;
        b=eGXxYXHSQ7WkLAWrI4u8+j1iFx0f4zPwLDvGmPG39puhgYa3DzSiORUbz2AQo45aLo
         JroxK5vSbELEnvTGtQH4zUTsfYCQcFmGPdBhLtB05qNWLCde6iWk1U+leOp+lBnD4X+7
         a3mMvZhIKSYoJOVmxC4TKXFaQang5+gClFjBmTlV5GdYwiL2n7q802klJtEDr0/5wx/J
         uMh9RRegmC1+11OdBNaCazqp6ovgK08/7k8KwC+6/9lx/VaS/er4jQJY2/yDuReVkD9U
         YhciWHs+wfn5QucdYwYbCsGU9uCZJT5qgPlnP/sCdfnloMa9cdgyK9yR8aoiuomyimrG
         /0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718893706; x=1719498506;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XR7wHT13iygLkcIEjWAfVaOtnqk5nw86T9eqiSlk9K8=;
        b=jVaqTdI6a50V6sgj2djmNJ+ewjeaasPq1NGbMnwUmX1yVfCqUYhR8ZLrxzScPbW8iR
         1ArYQKkgJ+ZoOYK/g0q99EKwsjgEtKZONBqNd0KkdGCwikRV495fvd4L5NEKr7NRgjWk
         tnvK/m7cW3BpLQ/qvUPwxm3854g7Ny8cyeDLegMQTp09ojqIN6xwhG0MvXpSzDX32oGz
         7YOIi1nXcrzcmJnyF9DvGbNcPIbdclROQFYDP31VNGULRzKeUPsV5nSOCwV1pGoCZnCw
         +ip+D6C5khdU4r+MC77H8WTXSPopQLA/QnUBFPjt+67DtHwDZhtFESzmBUM4HyegwI12
         Kgdg==
X-Gm-Message-State: AOJu0YxE2NkZFJKltW/dBMmRJhmcD/3qCoNaC0e0xkvVHjUM8jzGDkWq
	0INSTSo2A4oLG1NBLQOK9NMWKot9j6PMysXteA1EhtrMklPoORgXbPqQKS8g5jbHDSZA0qC3mTH
	wKY6obSxbl0qqEh7bkWX6YIHacSs=
X-Google-Smtp-Source: AGHT+IEY05x9VDyfAT7rTjKya0xeE48cvXGTwMvq6sB1tdFs9KTPZqnvRTr3Eqke6IrTmxe9SSzGTc/ooQG2BiPYfsM=
X-Received: by 2002:a05:6a20:c11a:b0:1b2:b16f:3b26 with SMTP id
 adf61e73a8af0-1bcbb3dcbb5mr5289638637.7.1718893706096; Thu, 20 Jun 2024
 07:28:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
In-Reply-To: <CABZOZnS13-KscVQY0YqqWZsBwmQaKyRO_G=kzCL8zc9jHxAC=A@mail.gmail.com>
From: Stephen Smalley <stephen.smalley.work@gmail.com>
Date: Thu, 20 Jun 2024 10:28:14 -0400
Message-ID: <CAEjxPJ7oNGyzh3Q5FyXLtDoq0BmzbBAfLv11ZSkZYBt3Vz_pEw@mail.gmail.com>
Subject: Re: Yet another vision of Linux security | Endpoint Security Framework
To: Timur Chernykh <tim.cherry.co@gmail.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 20, 2024 at 9:40=E2=80=AFAM Timur Chernykh <tim.cherry.co@gmail=
.com> wrote:
>
> Hello!
>
> I'm here for yours' opinions.
>
> The modern Linux, in fact, does not provide convenient options to
> write AV/EDR software with real-time system events analysis as far as
> unified system security events. For now we have only inconsistent
> self-made events from eBPF, audit, fanotify, etc. eBPF itself is a
> cool technology, but even CO-RE sometimes works as not expected or
> gets broken, for example:
> https://github.com/aquasecurity/tracee/pull/3769/files. This hack (one
> of a huge amount of the same hacks) looks a bit "crutchy".
>
> As an EDR developer, I have an idea how to fix this situation, using a
> unified endpoint security framework (ESF) placed in the kernel. Its
> must:
> - Provide unified and consistent security events;
> - API to communicate with kernel:
>  - To send program-defined events (as audit has);
>  - Read events from kernel;
> - Trusted agents delivery mechanisms (signing like kernel modules);
> - Has a possibility to control what happens on system e.g block some
> file operations, binary executions and so on;
> - Has a portable and flexible events structure which doesn't get
> broken from version to version;
>
> For now I have PoC, which describes the concept in more detail:
> GH mirror: https://github.com/Linux-Endpoint-Security-Framework/linux.
> It contains all listed above points (maybe except portable event
> structures)
>
> There are an examples with:
> - Security agent:
> https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/=
samples/esf/agent.c
> - API: https://github.com/Linux-Endpoint-Security-Framework/linux/blob/es=
f/main/include/uapi/linux/esf/ctl.h
> - Event structures and types:
> https://github.com/Linux-Endpoint-Security-Framework/linux/blob/esf/main/=
include/uapi/linux/esf/defs.h
> - Main ESF source code:
> https://github.com/Linux-Endpoint-Security-Framework/linux/tree/esf/main/=
security/esf
>
> Questions I'm interested in:
> How does the community feel about this idea? Is it a viable concept?
> If all is OK, what should I, as developer, do further? How much kernel
> code outside the LSM module may be modified to keep further merge
> acceptable? (currently not all LSM hooks meet to intercept all needed
> data).
>
> The general purpose is to make AV/EDR software development easier,
> more convinient, and stable for Linux-based operating systems. This
> PoC (as far as technology idea) is inspired by MacOS Endpoint Security
> based on MAC policy.

I could be wrong, but I thought that supporting such solutions was one
of the reasons that fanotify was introduced, and that some combination
of LSM + fanotify + audit could fulfill most if not all of the
requirements. Can you explain which ones can't be met using those
today?

Note that a number of the LSM hooks are called from interrupt or while
holding locks and thus cannot sleep/block.
