Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bDeI84bt"
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE7A193
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 13:13:34 -0800 (PST)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-35d56fb336aso8291975ab.0
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 13:13:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702070013; x=1702674813; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mpntkCfQwDaAgbaJaTI4iT/n+8OOJsz8SUdIGxRKoCo=;
        b=bDeI84btSsYxUVrOO3AVmLizwS9V+guO5WR8MwuD0DBZUOW3CtNpDxr9nTQayz7gkd
         Err2Ackqn5HhsmeVIVBx2SS+fWf/amoCpanTep0g8u6yhPEWrMsU7ZxZn0P2da38Jduu
         QhdB66CIfZMkvsNvdNI8ZbVzHqa6vle7/tekI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702070013; x=1702674813;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpntkCfQwDaAgbaJaTI4iT/n+8OOJsz8SUdIGxRKoCo=;
        b=c4tcUZO6gO+PgupWFrB6iSTBWq9T50UHM11KnRMiy9oXDOgVqYXvwRDvoERXHwEgF2
         w37F2YhOhBstOhUTYrnw5riveKYooFHlA3ptvUExXHfynry9IWq2otP3Q2YxOU7vnbnp
         cs9oKKdCGb+OZkFNTJqsaRTbxVT3mB48FTAO0nrZOCoBd0QYmyQ8KegWoUIei1SyY7mk
         PAJ38CKfINQnJG2J/uZK6TTDarCmxlODQMPUu/lqm9AfAkvjxZS/TM036TJ+doQV/Phr
         Kn/F0DE7gl4vKt90id7lnn1ijxrM66ZPOVRHkvJEQQFgZplYB00csBOxpdshoa73Ks2M
         1Rrw==
X-Gm-Message-State: AOJu0YxbmsSTxeirCsG4ffLTXdGMhytwWIwIZ5iyonmbp4w/oOlEiaGT
	s87DRU+6JTKo7Fp3UEFX1lkaxO+8aGJwWYDRfiU=
X-Google-Smtp-Source: AGHT+IG+5kvteZ8JpbXWSobQV/zCyZcte6WZM3+VssRgy6WXu8EFGkOQuad9kjeMkOkWqOGsejW8ig==
X-Received: by 2002:a92:ca07:0:b0:35d:59a2:a32f with SMTP id j7-20020a92ca07000000b0035d59a2a32fmr993717ils.49.1702070013688;
        Fri, 08 Dec 2023 13:13:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id c11-20020a63d50b000000b005ab281d0777sm2013165pgg.20.2023.12.08.13.13.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 13:13:32 -0800 (PST)
Date: Fri, 8 Dec 2023 13:13:32 -0800
From: Kees Cook <keescook@chromium.org>
To: Paul Moore <paul@paul-moore.com>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org,
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org,
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com,
	pabeni@redhat.com
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
Message-ID: <202312081302.323CBB189@keescook>
References: <20231110222038.1450156-1-kpsingh@kernel.org>
 <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook>
 <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
 <CAHC9VhRguzX9gfuxW3oC0pOpttJ+xE6Q84Y70njjchJGawpXdg@mail.gmail.com>
 <202312081019.C174F3DDE5@keescook>
 <CAHC9VhRNSonUXwneN1j0gpO-ky_YOzWsiJo_g+b0P86c9Am8WQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHC9VhRNSonUXwneN1j0gpO-ky_YOzWsiJo_g+b0P86c9Am8WQ@mail.gmail.com>

On Fri, Dec 08, 2023 at 03:51:47PM -0500, Paul Moore wrote:
> Hopefully by repeating the important bits of the conversation you now
> understand that there is nothing you can do at this moment to speed my
> review of this patchset, but there are things you, and KP, can do in
> the future if additional respins are needed.  However, if you are
> still confused, it may be best to go do something else for a bit and
> then revisit this email because there is nothing more that I can say
> on this topic at this point in time.

I moved to the list because off-list discussions (that I got involuntarily
CCed into and never replied to at all) tend to be unhelpful as no one else
can share in any context they may provide. And I'm not trying to rush
you; I'm trying to make review easier. While looking at the v8 again I
saw an obvious problem with it, so I commented on it so that it's clear
to you that it'll need work when you do get around to the review.

As far as the CONFIG topic, I think we're talking past each other (it IS
figuring out the correct value, but it looks like you don't want it even
to be a choice at all), but we can discuss that more when this series
bubbles up your list.

-- 
Kees Cook
