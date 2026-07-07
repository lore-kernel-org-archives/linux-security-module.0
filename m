Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806753A4F34
	for <linux-security-module@vger.kernel.org>; Tue,  7 Jul 2026 19:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783451451; cv=none; b=N1EagISa/uXnMLSB+nqrQLHRLCnJpFhFO6auXujr2Mj4e6AD0W+MXbtq7iM3zuj/JTniFpOYjqp0i2ml0/Ob5xRcaqNBV5tQvtKHFIFnVIGO2ifeKPRNgbiAgfYPn7fDHa20PwKWquP2DrXkkHsnkYZQPmtUMxWfh0nOSeqrbpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783451451; c=relaxed/simple;
	bh=9e9qjg8FjE4LIAcZ8mjOkqL/o0d4wmhbdAuKcnOX1/Y=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=dfRTcUm0VwA7bsjApVrOG8fkY9FzY48BdT4FiAcPwYchjs8bwa1PKbelcTP+DrNLRHA04h2WrQe3Femwyk5fZmQMp/ZcPUXh/psAviirmJTrK3IS97UYGTrakV0Es6+pbAkKTx85uhZu15TzBXm5lb2pOCxoIF49qtEV+haR5QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=EQxitSu4; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="EQxitSu4"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8efef6533aaso35769076d6.0
        for <linux-security-module@vger.kernel.org>; Tue, 07 Jul 2026 12:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1783451447; x=1784056247; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mBSYWCX0Xl0nrH7KuyJZql2xgbujaGVevFK59n9qnxQ=;
        b=EQxitSu4R1D7XwJ2ijwuyXMLO4lNwZa6kMMfoi5eV9WaDx4ELjcZFnB0IG3ZfdWmnM
         GHdtwcsAGgMxpJOuYVy+ItS8Y3lyy6i+FicFIcqMaLIuMB/Y7rlk632Y0g8hz64N8S26
         S+02vS/e3//ux0QMLNxr9aKJIz/GTMWuNI6hXxA5VlDTvzYZbux5KicDEBNTM0FTSdZO
         aNA5sbY4X/jJWDZ+z4Ep7i7Xx0IUj+IXR3VMYr5r/xPqqF+ET1O0Kby6+yqZ4CJ2P/jC
         J14ra/5leABskcW+AEF3o7Laey8f6Pa8msJQQ0yGgY/+XSN1tSUhqs5nsBipfB/5Mso4
         BjaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783451447; x=1784056247;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-type:mime-version:message-id:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mBSYWCX0Xl0nrH7KuyJZql2xgbujaGVevFK59n9qnxQ=;
        b=PFTkNXlGa53Twn9a5RROJ+SUqmPMZ7II86GLPYbp/tm6hEcyj5hlWQSr1aJwAYPEIw
         mKO+og+Zbg/3JSsgXxK7cyzYNjGz7Kfyc2aW2JE394Qrfajw6cubq6gYWKYHo4Uz4+wB
         7RW7ZWgJ0GRZv567OOXMquiD02KAHhga3bhDPXR+Zc0ZNghQcCxfCtLdQUKNe+O+9fNi
         xQyE+OWgLo/B6PtjzQXAGH1NPgGuXE19QA03FsSCL8yGiFS99W68QTrE3SaFsvjyVgao
         0PxhWTqV1mdmpMlKqdFMcgvxUud0TxwhfOUeUajiPQBbIHk9zKuW6HQil0u2errfR1jR
         mpxg==
X-Forwarded-Encrypted: i=1; AHgh+RoLu9kIRCVEsb443MDt6FG0EGBNrX1D7K1LZQy5wWV75ZT50TgJPrThp2RvQ1kUIMKshXKTGeh7nbKz42o+REJp2rb0uPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycoTReDhTdjt2dxD/nhh2kK2E89FagSVnU8/E2Alih91SQxODo
	lNdDkc4sN8wn9cuBLEiwifq2FYsVYMwM6kXlqQxXOt9Y52lwfQOXoThALZl1nGFOQQ==
X-Gm-Gg: AfdE7ckJTiZNx1X3rQdKAwbuTKJmLH43/OZZ89S/dquIqBF9WFcJUSouVpTtVmzFdXs
	U3QDbEBxQ+J6tGUQZ2ytTgAH0Pkf3vivLO50z/Td9iH+D9ewdfBWFkei6oYYM8IgQajGXjqEKGt
	/+X+QqIaRfIJTfhIVZFvKlkZUJ8wr+rVelCe8R5lCNdbtU+UvHP3J0x1xKJ4cp6Cvd39/ZL5i7R
	u2MFlzeyJz+aavY9DJV186yZwk+NmlZ2bBVBSHrM38leQvBUyEzH3EcuG81655j0ydQYeQLwxKB
	X8u7bdEXrCnUFxFiPoIpZnU5/GsVmzZ4B5TwCnctmFsNMrLapSr3uaFAeymdDpLmmzeK3nCnrFS
	dSmFJdT/XcNHnpskjF+HSTyAs6UA6Kg1JyQ1xFJObjwX0m3Jes3OV/qxhaz4o3QpMX4XBjz8l3S
	quC9ni+/29gpFl9vNCtiH3/yL309iaTTe43xiEJjI/cPwjljUjyr/VQhhFnhVC5AlJiijY
X-Received: by 2002:ad4:5d4a:0:b0:8eb:24e8:8d28 with SMTP id 6a1803df08f44-8fcb4904bd7mr89056376d6.46.1783451447567;
        Tue, 07 Jul 2026 12:10:47 -0700 (PDT)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f46f30c04fsm178016696d6.22.2026.07.07.12.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2026 12:10:46 -0700 (PDT)
Date: Tue, 07 Jul 2026 15:10:45 -0400
Message-ID: <054bead629039656c730231393b4418f@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20260707_1504/pstg-lib:20260707_1258/pstg-pwork:20260707_1504
From: Paul Moore <paul@paul-moore.com>
To: Alice Ryhl <aliceryhl@google.com>, Serge Hallyn <sergeh@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Shuah Khan <skhan@linuxfoundation.org>, Alex Shi <alexs@kernel.org>, Yanteng Si <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Jann Horn <jannh@google.com>, linux-security-module@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v5 2/2] cred: delete task_euid()
References: <20260703-remove-task-euid-v5-2-c90c7e2ddf54@google.com>
In-Reply-To: <20260703-remove-task-euid-v5-2-c90c7e2ddf54@google.com>

On Jul  3, 2026 Alice Ryhl <aliceryhl@google.com> wrote:
> 
> task_euid() is a very weird operation. You can see how weird it is by
> grepping for task_euid() - binder is its only user. task_euid() obtains
> the objective effective UID - it looks at the credentials of the task
> for purposes of acting on it as an object, but then accesses the
> effective UID (which the credentials.7 man page describes as "[...] used
> by the kernel to determine the permissions that the process will have
> when accessing shared resources [...]").
> 
> Since usage in Binder has now been removed, get rid of the resulting
> dead code.
> 
> Changes to the zh_CN translation was carried out with the help of
> Gemini and Google Translate, and since adjusted as per Alex Shi's
> feedback.
> 
> Suggested-by: Jann Horn <jannh@google.com>
> Reviewed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
>  Documentation/security/credentials.rst                    |  6 ++----
>  Documentation/translations/zh_CN/security/credentials.rst |  4 +---
>  include/linux/cred.h                                      |  1 -
>  rust/helpers/task.c                                       |  5 -----
>  rust/kernel/task.rs                                       | 10 ----------
>  5 files changed, 3 insertions(+), 23 deletions(-)

Merged into lsm/dev, thanks!

--
paul-moore.com
