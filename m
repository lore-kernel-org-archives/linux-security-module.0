Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C360D28E28
	for <linux-security-module@vger.kernel.org>; Thu,  4 Jan 2024 19:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S9PehNeE"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50e7c6f0487so869280e87.3
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jan 2024 11:04:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704395080; x=1704999880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xABQKYwqb6Tn050lqN4gkUa6ogl98DT9i/4GjNnCoY0=;
        b=S9PehNeEr+4blxt6e8NKLyPCSA2MX+RY9rcAoM3px4mPQPOO+kRd3glFZgMH+UW4r7
         MZ9qeyyNPJiGMZHOYIR/4hJ/a7FeOvgqlL0xGVzFT9nNcQCiezvfZfYVNzLd/fLUqawB
         Pap8dX9qdHLkAx09xHOOuRMXM5t3EdOsWhD7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704395080; x=1704999880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xABQKYwqb6Tn050lqN4gkUa6ogl98DT9i/4GjNnCoY0=;
        b=rNk1SxHhIzlIHFvOSFxMX0nZGvsGbxFtzWC/4nLS854HD3DNAuas0fCVcZMNrTGBsB
         rh+LFW1lS+1SiOlrtsTjWCtIaJmxSEOBTWaYnsXTcs2SQLST8mbjRN3TA+IGH+BfMxXX
         MoOKEky9W4rQSv7AKGE8Sd0q01cVY7mgW793ucCpVFopVv79LqNw9Im3wM6DYdgFetbq
         Y18qNjLeBDzxeg7OOMwSmu+Q06xhb+bYnWwdI6cC/7Sxacy2sKwnkQMxX3W4FgaZ7BNs
         9P4+XtWO8srOo7haYM02/qnVw7wm+N5TrKqp+VepVvn6jUjGduSy6R2VSgFwb6CsMAjt
         xggQ==
X-Gm-Message-State: AOJu0YylY3TKKXFzTBc7lX8tGxYUegvJdHQ3/nmRpAquzO/2czCpYS5U
	3MV9mGDR/FjWgVCPXxTCGzzXe2hf6zGKPy0/FcGuohoRZdXJnDi1
X-Google-Smtp-Source: AGHT+IGV9ioxQHlGG86hFjfrbp2ZuOKzSoBBNGYNZE89mvmvscBms4esA4SFO7yD4BAcV/rutQgU1Q==
X-Received: by 2002:a05:6512:1083:b0:50e:644a:dc63 with SMTP id j3-20020a056512108300b0050e644adc63mr433122lfg.5.1704395080652;
        Thu, 04 Jan 2024 11:04:40 -0800 (PST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id e17-20020a170906505100b00a26ade46618sm13240402ejk.99.2024.01.04.11.04.40
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 11:04:40 -0800 (PST)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5571dd9f570so164897a12.1
        for <linux-security-module@vger.kernel.org>; Thu, 04 Jan 2024 11:04:40 -0800 (PST)
X-Received: by 2002:a17:906:18:b0:a28:f456:42a2 with SMTP id
 24-20020a170906001800b00a28f45642a2mr318777eja.44.1704395079598; Thu, 04 Jan
 2024 11:04:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-14-andrii@kernel.org>
In-Reply-To: <20240103222034.2582628-14-andrii@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Thu, 4 Jan 2024 11:04:22 -0800
X-Gmail-Original-Message-ID: <CAHk-=whDxm+nqu0=7TNJ9XJq=hNuO5QsV7+=PTYt+Ykvz51yQg@mail.gmail.com>
Message-ID: <CAHk-=whDxm+nqu0=7TNJ9XJq=hNuO5QsV7+=PTYt+Ykvz51yQg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 13/29] libbpf: add BPF token support to
 bpf_map_create() API
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 3 Jan 2024 at 14:24, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> Add ability to provide token_fd for BPF_MAP_CREATE command through
> bpf_map_create() API.

I'll try to look through the series later, but this email was marked
as spam for me.

And it seems to be due to all your emails failing DMARC, even though
the others came through:

       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=kernel.org

there's no DKIM signature at all, looks like you never went through
the kernel.org smtp servers.

             Linus
