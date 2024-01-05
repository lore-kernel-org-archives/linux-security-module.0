Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36E1225A6
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jan 2024 21:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DvAPBwUi"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso2256041e87.2
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jan 2024 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704491152; x=1705095952; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=yEXiwrq4KNUdt55Ouq+3g5whmUfNY0DSzzUMj+HSUwY=;
        b=DvAPBwUisQdTKVeb2QnpaAIkg5XvT/M8NI92tP3BRcKWJnZe2lomkZMjBNZdmsW/TR
         ZrZt9xyIm11BqgRKNmdjYP8//P/wcj+g+cJqickXg7KgpxVVQK//8TEwLKMK/PFjNlQM
         aqqDjweJG5Tun+umhcQ99S15jh5xXtsjCYLfk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704491152; x=1705095952;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yEXiwrq4KNUdt55Ouq+3g5whmUfNY0DSzzUMj+HSUwY=;
        b=jDumPPlyG+WYkeNmBIrZNaOTL1NiF155b8bI+a8nOouzABSzKIFkRmRAUdxgP4yGVx
         zu/O1Ym9bWew/ZPB4scSF/gIIosxu7B0mHd//ZIa/1bTJTAtWBNmfG756pIJQJtq53Hx
         WE8S2SU2kWI0kllhQt709evlklx/ssyqEzImsm3Ji0MeKmFLSE6KTGLIXGXvG3riQZPJ
         qXbr/JzHh0QtbQrWk9zUWnNUfnhsR6Ri5N3f0RgG0AWKm91jdVs0oqZavEmCf5+Ih3Ip
         4CdBLzwKDgTLlVBJU03nCb5WCkrpLyYyEnC/IjMI0lP2+TYhheCKh3JTBXwKgBnbq9w3
         v4Xw==
X-Gm-Message-State: AOJu0YylG/CpDV7ZSpfyAUFsrPo7zXYih31yt3oMTwBDe6ozwAM5zRcW
	BqN3DjCHAFfj3EwxnNI7OY21ynm3R1hRKFfyVzK7f7H09tgIFGaM
X-Google-Smtp-Source: AGHT+IEA/IYZqZkM0Y7ynuHPS+cQlt8SulGMOd07Bm2JUy7+6dndEEOoYjsJs2+0XDzSs8fRAJbU0g==
X-Received: by 2002:a19:f50a:0:b0:50e:79a5:7771 with SMTP id j10-20020a19f50a000000b0050e79a57771mr14326lfb.221.1704491152478;
        Fri, 05 Jan 2024 13:45:52 -0800 (PST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id b69-20020a509f4b000000b005557bbb81bfsm1421436edf.79.2024.01.05.13.45.51
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 13:45:51 -0800 (PST)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3366ddd1eddso37630f8f.0
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jan 2024 13:45:51 -0800 (PST)
X-Received: by 2002:a7b:c34d:0:b0:40d:4de8:222c with SMTP id
 l13-20020a7bc34d000000b0040d4de8222cmr35659wmj.252.1704491151463; Fri, 05 Jan
 2024 13:45:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
In-Reply-To: <20240103222034.2582628-4-andrii@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 5 Jan 2024 13:45:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
Message-ID: <CAHk-=wgmjr4nhxGheec1OwuYRk02d0+quUAViVk1v+w=Kvg15w@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

Ok, I've gone through the whole series now, and I don't find anything
objectionable.

Which may only mean that I didn't notice something, of course, but at
least there's nothing I'd consider obvious.

I keep coming back to this 03/29 patch, because it's kind of the heart
of it, and I have one more small nit, but it's also purely stylistic:

On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> +bool bpf_token_capable(const struct bpf_token *token, int cap)
> +{
> +       /* BPF token allows ns_capable() level of capabilities, but only if
> +        * token's userns is *exactly* the same as current user's userns
> +        */
> +       if (token && current_user_ns() == token->userns) {
> +               if (ns_capable(token->userns, cap))
> +                       return true;
> +               if (cap != CAP_SYS_ADMIN && ns_capable(token->userns, CAP_SYS_ADMIN))
> +                       return true;
> +       }
> +       /* otherwise fallback to capable() checks */
> +       return capable(cap) || (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
> +}

This *feels* like it should be written as

    bool bpf_token_capable(const struct bpf_token *token, int cap)
    {
        struct user_namespace *ns = &init_ns;

        /* BPF token allows ns_capable() level of capabilities, but only if
         * token's userns is *exactly* the same as current user's userns
         */
        if (token && current_user_ns() == token->userns)
                ns = token->userns;
        return ns_capable(ns, cap) ||
                (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
    }

And yes, I realize that the function will end up later growing a

        security_bpf_token_capable(token, cap)

test inside that 'if (token ..)' statement, and this would change the
order of that test so that the LSM hook would now be done before the
capability checks are done, but that all still seems just more of an
argument for the simplification.

So the end result would be something like

    bool bpf_token_capable(const struct bpf_token *token, int cap)
    {
        struct user_namespace *ns = &init_ns;

        if (token && current_user_ns() == token->userns) {
                if (security_bpf_token_capable(token, cap) < 0)
                        return false;
                ns = token->userns;
        }
        return ns_capable(ns, cap) ||
                (cap != CAP_SYS_ADMIN && capable(CAP_SYS_ADMIN));
    }

although I feel that with that LSM hook, maybe this all should return
the error code (zero or negative), not a bool for success?

Also, should "current_user_ns() != token->userns" perhaps be an error
condition, rather than a "fall back to init_ns" condition?

Again, none of this is a big deal. I do think you're dropping the LSM
error code on the floor, and are duplicating the "ns_capable()" vs
"capable()" logic as-is, but none of this is a deal breaker, just more
of my commentary on the patch and about the logic here.

And yeah, I don't exactly love how you say "ok, if there's a token and
it doesn't match, I'll not use it" rather than "if the token namespace
doesn't match, it's an error", but maybe there's some usability issue
here?

              Linus
