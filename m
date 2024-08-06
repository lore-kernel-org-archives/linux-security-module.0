Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E040356452
	for <linux-security-module@vger.kernel.org>; Tue,  6 Aug 2024 03:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722913812; cv=none; b=cmWL13Ki1fqjyA7zfoR0Kg2sna6ZWCWj4zIUgVgB7GBJ39aEZrikRCYsZqcPPQnGRshiefplAIaH02SuZNntCEEd4wvoLuDaxPDKsoQ8qLbJQcJwjj83p9MmarVzaz9ZGC4IJ95vhEQ0GaWsVhdcgpGZXex/E6qddirAl9MmlCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722913812; c=relaxed/simple;
	bh=M8lCPbpz8MJ7MmX8w6ySSM335BKWQPUYdlyNM4pcNL8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ntk34cyQziTkxNfGsavO7ZT531L6AjYeljdIT9YOlu0g1D9vEShwMqkoFaQuF2TfUUCPIv5ZU2w+4rSQpNN/9yznFTsB8ZBDp8LJsuymrGNiRXzqBHyUuBTtm1y35MFgrRJeulLcHgAK0tlqY+DcmuOvB5CWZeOlFiH941DBxGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=AqIjGFxt; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="AqIjGFxt"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a7a9a7af0d0so4331466b.3
        for <linux-security-module@vger.kernel.org>; Mon, 05 Aug 2024 20:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1722913809; x=1723518609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=AqIjGFxtM0nFjNXxOr7KDYCUIJeYxKS32lAgjemtmmhh9bvx3RgcyRhtpne9s7jhkw
         8JaHUpJqtcDLArsgJamUrkgkrJQk/mdyXVPUbfOYS9kY5bzsrpUHWNPaW1nz9o9qGaEK
         HB5VZVGmFKgZ0VFV6k1d4LmCh5BFz3eqoS5cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722913809; x=1723518609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ddVwpujzlJzBqKH8my+rFJponoM7SG54MA80H5/+gq8=;
        b=uTJBmrqv2WO9Qqhdv5keKOoi1LajMHr5nsEJ6tZBH4M0N359WJO5i3kPSsGmjezob/
         TCxjVRxbpiUuYljR3lGsKSH/N+aXX6XT7hE6jPCX+zLKUC+rqGJacpggHsZImUR8ecB0
         LSF2D0DR6a8oNtdQhawuIe8eAZdVw6+ZHLS4rhz39XvVRl/PLowkSpYOhvdw86Omuaxu
         bZIS0hdD2ZEbXk4Szz+lK83dZDHinr0wn4R4nnR3evZSG1JGUz4fmACvfJKJq+uLVZyz
         Z4Ozei+aNRKKrZ7enYVDtrCe7Q2j5khxCfRtwh9p51DoEgYUkykq8VEh1J+mCV6Te+Wy
         oTqw==
X-Forwarded-Encrypted: i=1; AJvYcCVrggzPKOAgVS2PXvsEJBnPAgKeTTQcRjS6oKfz3ZH0x+kqApQMXJ8tJTf1rb5W/UBR4ZrXXpRkjO/94TioAr5VcenkfHrkm7JLswQ/ZxAG4S6HUAd2
X-Gm-Message-State: AOJu0YzkTWNFbTZwTnKXT62Szw9ogrDyn2UEHcKyxBTyGH7ab0ywORUV
	sdCzCx2QzHtCUPP8zAgx88umnR15Mpc6sfvfkMLQ2Fc1WXUPAshWIKinlZNYPreFUiKhjhugQYe
	4H0K3OA==
X-Google-Smtp-Source: AGHT+IFdI1+c3pfQrAk+tphLzFz2o/K3bobtyi8GJnoHfiVVitau02V/xll6ptZvsPnpwKH01bP7aQ==
X-Received: by 2002:a17:906:6a0b:b0:a7a:a892:8e11 with SMTP id a640c23a62f3a-a7dc4fca327mr861276566b.32.1722913808993;
        Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9d433fesm515593766b.142.2024.08.05.20.10.08
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso5294866b.0
        for <linux-security-module@vger.kernel.org>; Mon, 05 Aug 2024 20:10:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXNsdlRIHU1bVN4Bpp+1/m2xfofOpwmHzdpHBS0Ng9R41bjoUrSaqvhbDZUGVChlf4LtlI6mBOaTlTJ38aSXNHh0dWlCSc3wZNS8hu5hr1a20quPYrG
X-Received: by 2002:a17:907:da9:b0:a6f:4fc8:266b with SMTP id
 a640c23a62f3a-a7dc4db9f44mr1005005366b.3.1722913808064; Mon, 05 Aug 2024
 20:10:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240804075619.20804-1-laoar.shao@gmail.com> <CAHk-=whWtUC-AjmGJveAETKOMeMFSTwKwu99v7+b6AyHMmaDFA@mail.gmail.com>
 <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
In-Reply-To: <CALOAHbCVk08DyYtRovXWchm9JHB3-fGFpYD-cA+CKoAsVLNmuw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 5 Aug 2024 20:09:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Message-ID: <CAHk-=wgXYkMueFpxgSY_vfCzdcCnyoaPcjS8e0BXiRfgceRHfQ@mail.gmail.com>
Subject: Re: [PATCH v5 0/9] Improve the copy of task comm
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, ebiederm@xmission.com, 
	alexei.starovoitov@gmail.com, rostedt@goodmis.org, catalin.marinas@arm.com, 
	penguin-kernel@i-love.sakura.ne.jp, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	audit@vger.kernel.org, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Aug 2024 at 20:01, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> One concern about removing the BUILD_BUG_ON() is that if we extend
> TASK_COMM_LEN to a larger size, such as 24, the caller with a
> hardcoded 16-byte buffer may overflow.

No, not at all. Because get_task_comm() - and the replacements - would
never use TASK_COMM_LEN.

They'd use the size of the *destination*. That's what the code already does:

  #define get_task_comm(buf, tsk) ({                      \
  ...
        __get_task_comm(buf, sizeof(buf), tsk);         \

note how it uses "sizeof(buf)".

Now, it might be a good idea to also verify that 'buf' is an actual
array, and that this code doesn't do some silly "sizeof(ptr)" thing.

We do have a helper for that, so we could do something like

   #define get_task_comm(buf, tsk) \
        strscpy_pad(buf, __must_be_array(buf)+sizeof(buf), (tsk)->comm)

as a helper macro for this all.

(Although I'm not convinced we generally want the "_pad()" version,
but whatever).

                    Linus
