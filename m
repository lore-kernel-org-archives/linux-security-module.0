Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B2430677D
	for <linux-security-module@vger.kernel.org>; Mon,  1 Jun 2026 03:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780286345; cv=pass; b=hQmzx6pCsG446QeI8dZRJP9gj2CLc6zfJUNSYoW+VIHq+cK+2wQr0x/XVfr17ovKwoeufQ9BVQFMaDVIWwtwvHbCk0lyO+vDC8rGbb7W1VuvUhuOCxMzlOsJjVTXuO/8SqhWkKzLHH37BL2NyiAE0uoJCfC5qwntwCloeTAFT0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780286345; c=relaxed/simple;
	bh=R2gda0sh3Y9ZKjnqeBHRoWIg5TBSqprzO9+faDr6yYs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sC39KIfqTF56BKnWyfKFHVeZkvtB7OY5xcioPpyAdgv1EkNjgCT5oagH/ftr1LgejODyjtLkrgWrvrmLAzQgAZusRwpOP5vJVON1pIxAUArOccePfEnreY7cdpvZS3huaVVFwAN+Kydtg1gdxAPmk0X7O4cn4BkAFRBAu7w3jBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fgqc1Gu/; arc=pass smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fgqc1Gu/"
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-45ee6d32402so1904831f8f.1
        for <linux-security-module@vger.kernel.org>; Sun, 31 May 2026 20:59:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780286341; cv=none;
        d=google.com; s=arc-20240605;
        b=edDgeuuvwPj0lGEJ2QPt5c8gfm46pLqqZ6HS5MYUnJ7a/xJ3Z2mFepPHcYbQZchRUV
         rwejyn4qUWeXaCQOEDjieFPXOC7MnHRBQQJvARtGXLJAU0JU4GGO+LNnNN24xFNW/qtN
         rBimu1rPBsvLwLQqsd2gmpiIq5vyBw2XKpjy8mCPrTQhJ0Fybfi9yzDqdUQhxaDRFFEq
         rFXhFhnYAEDcwFb9jWvf/XRbjtqsf5o6oEurD5xRGQNDEtasCN17Gc9XKjIuJ3sQxiSh
         enAUWMzvISUBY3lva/Yh6lTyt3lM9FkjuNPnOG/mUgqFmBwf0ThBrl8MKx2/LVu1vTxH
         v4LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jNudWB04Wpw+ZJC/nF3aN5jO9/6RuxUwPuu638+/KJo=;
        fh=k93CaD1i5gyTZQ5zW5QvgQTih2YyJAmC9EcvxACisT4=;
        b=DawEiK07FaIzEeLoZi86AYZAuttvVYK9u3d/C5vXzWP7LNbm0qFCrImLBA9swZtmd4
         o7m0oWsUhPym4G6Qwav0wEEmWY9hbAbNn0mQopYqZVrvsck0DV+hJtDCem4tWmnM/6hh
         +k867j6te5EVaXfTrQrUEvqYX1q9+P9NynU2l0JaGYuS3lz80jrcYERLyKBHvQQPku78
         iBOYhR64umH6mtKjN9xx93mExsoNF9qJ/9q5DGlli9WMf9jWUvnf2qciFzrw6Nys55G6
         yeqktKviyj293hzM1e0as6ozLXqbNcNXx2CF5+2rpJE3t/NU8qT+XHAKOW9shfTsksjj
         HYrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780286341; x=1780891141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jNudWB04Wpw+ZJC/nF3aN5jO9/6RuxUwPuu638+/KJo=;
        b=Fgqc1Gu/Xkd5+sMJsaLzfKOZjEHXvGArgaq/+X1LKPNno+gEfoWhSrTTHoUE1uodah
         I20jX+LU4P6h8rnN/oU7jfVjVeBsRu6jx2Bu1B91SvQfPUPf8HTuQh7/KlmGR69/GEVj
         FV4f9fQdbH5FLsZn+E6oEHu5nWVyLRQVhMJlUByS91aMMxqTOtspdEbRMQlqw+DVpxP3
         2JzR/jEW39qD/bm9nvPsfKBsW8eFSMh8AEbWKB0hfPYYI/MWghSv4j/iZvreV9RBg/2+
         tQ95HFqEKdFG7WjdaidMpS+tS1UMulSPd3GswQJIbVS9vbQ3CRk2zb3S+xpkTHRiEnNv
         WCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780286341; x=1780891141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jNudWB04Wpw+ZJC/nF3aN5jO9/6RuxUwPuu638+/KJo=;
        b=grw0TttxrusX3/vdEM0wc16CcQuO9Vk40gZG77XCloCKIj+ER9Z2FAv57rUNmEyg9l
         kb2ruNXS8g+JOPUuDXlz2Vr51ufV55sKQptDjTurEkBYCs0FlsmkKmBMhWPEWOvzXKkv
         InGofElMGirouAtUAZF9q00nX5y0nD8p5L1Aqm6E90Ij7mNE07jHbrUkjwjblbCE56cr
         sV7Gas6209mhjl4m52YPq8+ck7ECHWfTwbKYczgKbfagP9vSG3DhKwEYNmkoKEYcdf2h
         qRH15YABSvOVfsWEie1GRXHxF80J0F9FQZW/uTo9QBNOp/ZLiSqxNRddubau1fS/vAxw
         mqIA==
X-Forwarded-Encrypted: i=1; AFNElJ/KqrZlsOqWwncuDmlkynnI3sAp08ogme1OZRfBHzdfmukvZNcwCSLhz1qvJN8KRfQCPsr1cVR+HgfGm0lR9LGDs5KhADo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywpnvyn9ui6dG1/e0cpRZ5uJQEkEm1N/IyWAB9DdelJCw4QME4R
	jQ4BTEA+vvVedi58sjN9/yhaJ6CtwA+e3/hVYLxYYzbw6u52PNQvBhG+wAMh/msGgmQjOBGkP7U
	Do4CvFsoH1ByAQ0GhT8947KW8t7l2P34=
X-Gm-Gg: Acq92OFQ18o+NXbcvg8qvuySIqhYtuOF37zOKG8NvQGQ/yXXMet7AbuPpR1t2jhkVO+
	ciftt8p3LkN0IsvJse8F2N4JWLhqwBRX77B+i2Bodk4WLWMhXck/PPTVxTVl24+VY3i87zA171j
	vPTrI1Z+o6wqfjdyTDtE2Sr2IzNWkQDfSJ4MEuhZBtfnYnuydrCEU5pq9mQyB/8Xn3M2FZhOHcT
	7uXCeJ0i37MNSlrn9P4o3FQ8HHcOsFkcTrsXW/+k2lWvU4AQxXrsXMK6dGs/qOsXv9tf157/n19
	WxJe9/Oy+GVbUvEoxRKhYcWaK9EZM4DATrZG6b8TrS8S1Y7B1o6jd2u9LuRStYE7LLg3W2yFAqP
	B4A==
X-Received: by 2002:adf:f78d:0:b0:45e:ed7e:f8f8 with SMTP id
 ffacd0b85a97d-45ef6b0231bmr12455650f8f.8.1780286340409; Sun, 31 May 2026
 20:59:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601030649.2513937-1-hushijia1@uniontech.com>
In-Reply-To: <20260601030649.2513937-1-hushijia1@uniontech.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 31 May 2026 20:58:49 -0700
X-Gm-Features: AVHnY4K4C1soJyFxmMVHHhTiOD884427RYesf2FVX6XxkT8y6UJ_fmjeCZLuc_U
Message-ID: <CAADnVQ+=-UM-JC4eM=vqvgK2tLt6PwmDjOcrrDG9kz8BV6n49Q@mail.gmail.com>
Subject: Re: [PATCH] fork: Ensure copy_process() returns a valid error pointer
 on failure
To: Shijia Hu <hushijia1@uniontech.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	Kees Cook <kees@kernel.org>, Paul Moore <paul@paul-moore.com>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, LKML <linux-kernel@vger.kernel.org>, 
	linux-mm <linux-mm@kvack.org>, LSM List <linux-security-module@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, stable <stable@vger.kernel.org>, kernel@uniontech.com, 
	Quan Sun <2022090917019@std.uestc.edu.cn>, Yinhao Hu <dddddd@hust.edu.cn>, 
	Kaiyan Mei <M202472210@hust.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 31, 2026 at 8:08=E2=80=AFPM Shijia Hu <hushijia1@uniontech.com>=
 wrote:
>
> copy_process() returns ERR_PTR(retval) from its error path, so retval
> must be a negative errno in the range [-MAX_ERRNO, -1]. Values outside
> that range produce a pointer which is not caught by IS_ERR() in
> kernel_clone().
>
> This can be triggered by attaching a BPF_MODIFY_RETURN program to
> security_task_alloc() and returning an invalid value. copy_process()
> treats the non-zero return as a failure, but ERR_PTR(1) or
> ERR_PTR(-MAX_ERRNO - 1) does not produce an error pointer recognized by
> IS_ERR(). kernel_clone() may then dereference the returned pointer.
>
> Normalize unexpected values before returning ERR_PTR() from the
> copy_process() error path. This keeps the fix local to the fork error
> handling contract and does not change BPF_MODIFY_RETURN verifier behavior=
.
>
> Fixes: 6ba43b761c41 ("bpf: Attachment verification for BPF_MODIFY_RETURN"=
)
> Reported-by: Quan Sun <2022090917019@std.uestc.edu.cn>
> Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
> Closes: https://lore.kernel.org/bpf/973a1b7b-8ee7-407a-890a-11455d9cc5bf@=
std.uestc.edu.cn/
> Link: https://lore.kernel.org/all/20260411163556.8567-1-yangfeng59949@163=
.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Shijia Hu <hushijia1@uniontech.com>
> ---
>  kernel/fork.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 8ac38beae360..40bfbdfffbdc 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -2599,6 +2599,13 @@ __latent_entropy struct task_struct *copy_process(
>         spin_lock_irq(&current->sighand->siglock);
>         hlist_del_init(&delayed.node);
>         spin_unlock_irq(&current->sighand->siglock);
> +       /*
> +        * The error path returns ERR_PTR(retval), which requires retval =
to be a
> +        * negative errno in the range [-MAX_ERRNO, -1]. Normalize unexpe=
cted
> +        * values to avoid returning non-error pointers to callers.
> +        */
> +       if (unlikely(retval >=3D 0 || retval < -MAX_ERRNO))
> +               retval =3D -EINVAL;

This was reported earlier and there is a fix in the works.
This approach is incorrect.
You have to fix the root cause, not the symptom.

pw-bot: cr
