Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647A6D1B9
	for <linux-security-module@vger.kernel.org>; Thu,  6 Jun 2024 21:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717710810; cv=none; b=AJu5UB41xBH1wo/f0p1pukLKJWRlmfhulOt7kzYxkQofl6qlS3hH+6g5lL4rCJMbPMzI0PQgKo38LdxZg4IQnukvlJXVcnNmfuRjBM5f3wh7se+Qxp/R/N7I8vFPeY4iOsPVOErh477pelO/MQsbdjUUYWcRJxuMo+Ch/eYy6b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717710810; c=relaxed/simple;
	bh=+FpI6vYpR5bbyxTEbYr9rtFq5rhJFeJhBlUYUqcnlgY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7fUx97t8QCtL9jeLEQ7aHlZu90Y3cfqbUdkcshwipGegofgOS2oVGCFyFhfK9+iJOV8227OMO7lcnckxuv9yTw2OosTKkyQe8vwy4w631NRpSRkxhq+2GcQrKzDXeOpsMqoJM5J4xidmGGZmENyMRa4VJfrTVjQKVsBzNW/QIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RajqOgPB; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RajqOgPB"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-62a087bc74bso15053967b3.2
        for <linux-security-module@vger.kernel.org>; Thu, 06 Jun 2024 14:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717710807; x=1718315607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y9/LZLrVCiBmLFl657w1ASVEfglGqQmKYkFf7dxmKcI=;
        b=RajqOgPBwv8XJAwhXWZXlVonrRF/YPPRy9ozsRER3hLSkk6xn5+2NkLmVUpYWo4z24
         vkdDuC+8GAi+qh9w4Q8U8gJqytgI1tFDxKjmY07/kt30zRk4SsHMnidS0/j80kJsZYJZ
         e9uYsPru6kO6APku6GR8PEw+6fLvfsvBKhdW7NkohU3AbJ9ua2xvtoDbuMaFPC00pb5y
         4aDAvy4mPm25RQfwi7BHcBrjo2H1pAYX0OFVEOYbCs/fmyHVX4I6gpN5bfjuRB1O1Ov+
         87VlPFsC7ESewPLRCFIkMsnBlfW3xXJB4C9PpcBVxvg+1WLVZzfVBQGLcqG+xHyCgNS7
         2gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717710807; x=1718315607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y9/LZLrVCiBmLFl657w1ASVEfglGqQmKYkFf7dxmKcI=;
        b=ubrfvnwcoB/Y5KGgRJ36XX/bZ19MRUrxj+HB5oG9aB1YyVdjWlp0nkRkz7FuLGS4QE
         +U8/8Q1zBgZIH9fmMxwyeVwNc+HrJ55DQYKTjoeQqSeSTxVqxqgDIRso8/DRUuGE9HJL
         XAFIi4YMt5RKIk9Bxq4uylLHZs9szwzfozyvB9CyySbHzBdBZgUUDuHTa/11RFOMGT+8
         NtZH4UBw/QTonDzho7gfMFIrEjXSE6Atsi/DNMHkBhtBxUoLA5Rewd84/y1DZDQ1S8Nu
         DmzRvBBLzd2Gxg5wYVHetbg61nZxbStUb5oWvc9oHyD1mNkNS9C4HjGiQsmSB2VuxlkM
         QPnw==
X-Forwarded-Encrypted: i=1; AJvYcCVliVyZxLfdPGkzpzD2PEBKxjiPaisxxXwNtTDGVbW/ZhZ/+JiyUhi+4qE/8RISt/lz0ff9rVwWGHlsqlHw1aXa58wA2dsCw+obCvZ74/ntq1opWXqo
X-Gm-Message-State: AOJu0YyYqmR9NvI1BcvWjDf8PVdJi45y7dPbIWk5Kfh/FBfHJUl/iox8
	esf6w1eHHP5boRo3XliIVCaN0wEHcFQU1ny8Ka05CtxoRrIm0pPdrRM8L+litj0x+QY3xg00pEp
	ERKBhHKQP5hX2OsdJviEiUOTL/v8A4MJMrWN5
X-Google-Smtp-Source: AGHT+IHr+vEgrNOTl351kbnQRCFUgvkUIF6Lp0SFJ0/CR+WTO6ePRrwS52Q8I6+bzc57ubSMFu7oFmRulMZYl2piscY=
X-Received: by 2002:a81:7b57:0:b0:622:df58:2cf6 with SMTP id
 00721157ae682-62cd568be78mr5356547b3.50.1717710807083; Thu, 06 Jun 2024
 14:53:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240411122752.2873562-1-xukuohai@huaweicloud.com> <20240411122752.2873562-2-xukuohai@huaweicloud.com>
In-Reply-To: <20240411122752.2873562-2-xukuohai@huaweicloud.com>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 6 Jun 2024 17:53:16 -0400
Message-ID: <CAHC9VhRipBNd+G=RMPVeVOiYCx6FZwHSn0JNKv=+jYZtd5SdYg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 01/11] bpf, lsm: Annotate lsm hook return
 value range
To: Xu Kuohai <xukuohai@huaweicloud.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Matt Bobrowski <mattbobrowski@google.com>, 
	Brendan Jackman <jackmanb@chromium.org>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Shung-Hsi Yu <shung-hsi.yu@suse.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 11, 2024 at 8:24=E2=80=AFAM Xu Kuohai <xukuohai@huaweicloud.com=
> wrote:
>
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Add macro LSM_RET_INT to annotate lsm hook return integer type and the
> default return value, and the expected return range.
>
> The LSM_RET_INT is declared as:
>
> LSM_RET_INT(defval, min, max)
>
> where
>
> - defval is the default return value
>
> - min and max indicate the expected return range is [min, max]
>
> The return value range for each lsm hook is taken from the description
> in security/security.c.
>
> The expanded result of LSM_RET_INT is not changed, and the compiled
> product is not changed.
>
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>
> ---
>  include/linux/lsm_hook_defs.h | 591 +++++++++++++++++-----------------
>  include/linux/lsm_hooks.h     |   6 -
>  kernel/bpf/bpf_lsm.c          |  10 +
>  security/security.c           |   1 +
>  4 files changed, 313 insertions(+), 295 deletions(-)

...

> diff --git a/include/linux/lsm_hook_defs.h b/include/linux/lsm_hook_defs.=
h
> index 334e00efbde4..708f515ffbf3 100644
> --- a/include/linux/lsm_hook_defs.h
> +++ b/include/linux/lsm_hook_defs.h
> @@ -18,435 +18,448 @@
>   * The macro LSM_HOOK is used to define the data structures required by
>   * the LSM framework using the pattern:
>   *
> - *     LSM_HOOK(<return_type>, <default_value>, <hook_name>, args...)
> + *     LSM_HOOK(<return_type>, <return_description>, <hook_name>, args..=
.)
>   *
>   * struct security_hook_heads {
> - *   #define LSM_HOOK(RET, DEFAULT, NAME, ...) struct hlist_head NAME;
> + *   #define LSM_HOOK(RET, RETVAL_DESC, NAME, ...) struct hlist_head NAM=
E;
>   *   #include <linux/lsm_hook_defs.h>
>   *   #undef LSM_HOOK
>   * };
>   */
> -LSM_HOOK(int, 0, binder_set_context_mgr, const struct cred *mgr)
> -LSM_HOOK(int, 0, binder_transaction, const struct cred *from,
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_set_context_mgr, con=
st struct cred *mgr)
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transaction, const s=
truct cred *from,
>          const struct cred *to)
> -LSM_HOOK(int, 0, binder_transfer_binder, const struct cred *from,
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_binder, con=
st struct cred *from,
>          const struct cred *to)
> -LSM_HOOK(int, 0, binder_transfer_file, const struct cred *from,
> +LSM_HOOK(int, LSM_RET_INT(0, -MAX_ERRNO, 0), binder_transfer_file, const=
 struct cred *from,
>          const struct cred *to, const struct file *file)

I'm not overly excited about injecting these additional return value
range annotations into the LSM hook definitions, especially since the
vast majority of the hooks "returns 0 on success, negative values on
error".  I'd rather see some effort put into looking at the
feasibility of converting some (all?) of the LSM hook return value
exceptions into the more conventional 0/-ERRNO format.  Unfortunately,
I haven't had the time to look into that myself, but if you wanted to
do that I think it would be a good thing.

--=20
paul-moore.com
