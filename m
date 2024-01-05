Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2463608B
	for <linux-security-module@vger.kernel.org>; Fri,  5 Jan 2024 20:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fu1qBJqI"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-50e6ee8e911so2243956e87.1
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jan 2024 12:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1704486360; x=1705091160; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jlHlTQ7UwNnsRaaZVTPe3koXZRT/RuAbWyf3puCIBE4=;
        b=Fu1qBJqIWxxcyDLUZHseQ4WL035I81YDj3pn4RYWS9nLOvCf/jU1OCWf1Rka9AZP+T
         yj/5OBHTzEmbAVaqc0LUlgwfz7gzOUzUSIg2MniCFPbjoMLdB1tz4K7rkGztgO4dgBQn
         3bIun3N9s3c2Drt49Phvx14aix5mVT8Eoy9zQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704486360; x=1705091160;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jlHlTQ7UwNnsRaaZVTPe3koXZRT/RuAbWyf3puCIBE4=;
        b=tWk3JluOeVpXQsox0/4IECT8lD1bFDh/OqQyuBOTvw/ICvaPfbPhmrN6m6VjBJtPRJ
         TWZ6/J/VlrYUwJMOoU3tqgxdJ4/Ncf9Xyzicx5XvrQoEv0gJ0i1oS95aF5tO7HevbdK6
         IG+qL9PrzJx9kSm+H+agmG0lWaLLicuaIQxoCX4HWlR/jp60F6l5uom2nJE6rYhCYFLa
         +6Y6guPixV3pC37yCyo2xQFkynpVMWhomGjg9LtpEpSJdZjtMGajyxyE8Yq18pDH6nGa
         lEZzwwtjbbBxGIHHBtv/G7poevdl2FyHRFET2VXh9F85TQ8cq4VmK/yoWKpBmxPxTYcq
         MnTQ==
X-Gm-Message-State: AOJu0YxldvpkgVHC/Csc1A8AkMjowtWDUXtwF2T8Nggd6lY9WDOjn8VX
	LD54SOsATa46VdvCnnoo8BB3e7AQmr673eX7ueZgWhziKsEX3K3D
X-Google-Smtp-Source: AGHT+IGm1KyqiJJ2iT2FmlAGNMGJvoOIp8bB33MRTqAmw+3+EirITi46yqYqU4Y6YZiEHn527598cQ==
X-Received: by 2002:ac2:5d49:0:b0:50e:7bd0:1c93 with SMTP id w9-20020ac25d49000000b0050e7bd01c93mr1024766lfd.61.1704486359936;
        Fri, 05 Jan 2024 12:25:59 -0800 (PST)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id k5-20020a056402340500b00553a86b7821sm1309421edc.74.2024.01.05.12.25.59
        for <linux-security-module@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jan 2024 12:25:59 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a28d25253d2so209362366b.0
        for <linux-security-module@vger.kernel.org>; Fri, 05 Jan 2024 12:25:59 -0800 (PST)
X-Received: by 2002:a17:906:25d4:b0:a27:9365:ef73 with SMTP id
 n20-20020a17090625d400b00a279365ef73mr1360283ejb.38.1704486358728; Fri, 05
 Jan 2024 12:25:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240103222034.2582628-1-andrii@kernel.org> <20240103222034.2582628-4-andrii@kernel.org>
In-Reply-To: <20240103222034.2582628-4-andrii@kernel.org>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 5 Jan 2024 12:25:42 -0800
X-Gmail-Original-Message-ID: <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
Message-ID: <CAHk-=wi7=fQCgjnex_+KwNiAKuZYS=QOzfD_dSWys0SMmbYOtQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 03/29] bpf: introduce BPF token object
To: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, paul@paul-moore.com, 
	brauner@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"

I'm still looking through the patches, but in the early parts I do
note this oddity:

On Wed, 3 Jan 2024 at 14:21, Andrii Nakryiko <andrii@kernel.org> wrote:
>
> +struct bpf_token {
> +       struct work_struct work;
> +       atomic64_t refcnt;
> +       struct user_namespace *userns;
> +       u64 allowed_cmds;
> +};

Ok, not huge, and makes sense, although I wonder if that

        atomic64_t refcnt;

should just be 'atomic_long_t' since presumably on 32-bit
architectures you can't create enough references for a 64-bit atomic
to make much sense.

Or are there references to tokens that might not use any memory?

Not a big deal, but 'atomic64_t' is very expensive on 32-bit
architectures, and doesn't seem to make much sense unless you really
specifically need 64 bits for some reason.

But regardless, this is odd:

> diff --git a/kernel/bpf/token.c b/kernel/bpf/token.c
> +
> +static void bpf_token_free(struct bpf_token *token)
> +{
> +       put_user_ns(token->userns);
> +       kvfree(token);
> +}

> +int bpf_token_create(union bpf_attr *attr)
> +{
> ....
> +       token = kvzalloc(sizeof(*token), GFP_USER);

Ok, so the kvzalloc() and kvfree() certainly line up, but why use them at all?

kvmalloc() and friends are for "use kmalloc, and fall back on vmalloc
for big allocations when that fails".

For just a structure, a plain 'kzalloc()/kfree()' pair would seem to
make much more sense.

Neither of these issues are at all important, but I mention them
because they made me go "What?" when reading through the patches.

                  Linus
