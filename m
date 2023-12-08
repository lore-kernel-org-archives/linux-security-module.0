Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WxIFehZT"
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9B661996
	for <linux-security-module@vger.kernel.org>; Fri,  8 Dec 2023 09:46:42 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-db5e692d4e0so2709871276.2
        for <linux-security-module@vger.kernel.org>; Fri, 08 Dec 2023 09:46:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1702057602; x=1702662402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNmsRcekZnRxXQ5gy0OoeOtUGR4cju8EsG3DYT+pGXY=;
        b=WxIFehZTKqZU5zxyoiMNALpWMjG9d3nNYONs3sF37exfSmksbi2OmURP3p6nUpxt2L
         KArVL7IWvkb40kRp9DjqdFo5yLboPRQu8jTvSJuaqM9MtkRyuU9+tJg2IoUK8ZIiK+Dp
         hkkAVCsZSmxo88PdRnYj1af7em8KdJQVY9tmr7iFRhd0d60hg0gVRtrM3urP0LsWwDLy
         i8o/GcsfwHVfBviUPRYugk9dnFlLFo6bY0Tp2Kc3JTQr46D+iqyk9kOtbhv+xQ8aUhWq
         iiReF2xdSclR5WWR4k+yeMrzCg+BRnPfvE8RTyAMS+4hON7c/Ec/j33ZIWw+JLQrDq4G
         /Quw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702057602; x=1702662402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UNmsRcekZnRxXQ5gy0OoeOtUGR4cju8EsG3DYT+pGXY=;
        b=QQOy3gkeSmWMW1lnGySyEaabycY4fv2OIdStm74aSkM294XBz7roXuJexTvHY7bfuJ
         Hn7S5xnvuYAIB6lG5RNN5HcIaQp3xpaOvA/7BNOrT7KN5+fTcrrLhPb5TqxSZA3XYhtA
         NBWBILrRzDf0L2cCOYhOaf89IOURUku89MVcf2Yfyfvcb9Qzn0BCAPAf3s87EI0j7Cs+
         u+Y2AZKUjbGUkJIMa4OKTR2aAk3BSH3z5GNyZItWR3GEAPl91IAdbeeMjbUMW9B8v6gq
         2ytWT1FcheYAsRcE5kbx1HFfgU263kHmZICbP6Rf4Kk7cRoCj1l0JfadK0MRF5Zvwf5z
         eVAA==
X-Gm-Message-State: AOJu0YwBGwBw9LKHeWHDXOCRbRa0RXmDYIfQlkBW8Sv6XGrj/aVxtShB
	VXN0jo15xSyGbulz7WhCqh9ttFB+8Osw09LXz4Vp
X-Google-Smtp-Source: AGHT+IGVz2uXoWS24Jy5RIDh4XGLvWvVwWltqnctCKFZl7+o06Fu4ZlQulisdeRIiHEcRAT1q5xdn+vhjGtgbDfA1/c=
X-Received: by 2002:a25:ad1b:0:b0:daf:b23c:8619 with SMTP id
 y27-20020a25ad1b000000b00dafb23c8619mr287890ybi.51.1702057601724; Fri, 08 Dec
 2023 09:46:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231110222038.1450156-1-kpsingh@kernel.org> <20231110222038.1450156-6-kpsingh@kernel.org>
 <202312080934.6D172E5@keescook>
In-Reply-To: <202312080934.6D172E5@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 8 Dec 2023 12:46:30 -0500
Message-ID: <CAHC9VhTOze46yxPUURQ+4F1XiSEVhrTsZvYfVAZGLgXj0F9jOA@mail.gmail.com>
Subject: Re: [PATCH v8 5/5] security: Add CONFIG_SECURITY_HOOK_LIKELY
To: Kees Cook <keescook@chromium.org>
Cc: KP Singh <kpsingh@kernel.org>, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org, casey@schaufler-ca.com, song@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, renauld@google.com, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 8, 2023 at 12:36=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Fri, Nov 10, 2023 at 11:20:37PM +0100, KP Singh wrote:
> > [...]
> > ---
> >  security/Kconfig | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
>
> Did something go missing from this patch? I don't see anything depending
> on CONFIG_SECURITY_HOOK_LIKELY (I think this was working in v7, though?)
>
> Regardless, Paul, please take patches 1-4, they bring us measurable
> speed-ups across the board.

As I mentioned when you were poking me off-list, this is in my review
queue and I will get to it when it reaches the top.  I can promise you
that continued nudging doesn't move the patchset further up in the
queue, it actually has the opposite effect.

--=20
paul-moore.com
