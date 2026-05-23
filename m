Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DED234964
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 16:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779554965; cv=pass; b=NdV5vGlxcs/LxYnvQWQRkelBtQREVTfi3ZAWRn50tdk/HP7ZlmavZ1QiWYpbDllTgK7pnmONteuk+Q6Tn2G8dvrv7bwQ1ssimZg6pXrM/zisrSKkLQUUuHYeg2Z1Ia2OU/IqFfDF3+W1hhRHAHvIWsQhqq18oHk64kOu2luTZvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779554965; c=relaxed/simple;
	bh=EIa8bm3wefqdftkj44KMQX6I0eapyj2RnpgMUVefGr0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kr+22rZCGRsILBEn0GuKwfv60nKgX8ROs/DI5bsUxp4dwjuA+rinsGj3VJ2QxiieKEjawdn2VjrZLrZRtj94DcCKdonoLuLF0xUG0xOSQJLlMkWDhtBGyOQSqgLmvKXdXo1HUCxVtvsOkzdTzDwkEo6EV/WfGFeSgE2437cdsrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gMphvjga; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gMphvjga"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48d146705b4so88313875e9.3
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 09:49:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779554962; cv=none;
        d=google.com; s=arc-20240605;
        b=FjJ2JgXLcMLgnP/0VPbR5u062Fwj8eHUPLoYldk5MCaNSwApsjhbFRpQeb155KJwiL
         pO58320Egl1OW3LiLrM/hdKrAyeSidf7k6tXNyjpocZ5XagZAe5kD3AkzRsLBhxrWUwg
         dpsubr6mXSGYOGlhF4Qz8urUTcRCKonIBLnTT9wF5t6LKuaskRGpXhHLb5RU3hcDYQSU
         St1CWxJq+c31za5Su41ER0+fKUP8jKAIjdHeCQRe+4Ww0UenDHG4jLRiVLbwkTW2qAk4
         2sTrsoA2hsMqI7v7aW7I+5hXJaU5PXH2By1n00Fi3IratuT8NgPIWk5q5kmZdIgAIxF/
         tdYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EIa8bm3wefqdftkj44KMQX6I0eapyj2RnpgMUVefGr0=;
        fh=bN4nGiGVMoYvaEVGV0iOqumB+ukS2TASSPIMWw11zK8=;
        b=GI3aNz8RJal67/SUCNmAb30Qfnq+DbM3InycknWVugRB36RFyN8whdmBBTZXzX5YFn
         45QCZk4BcQht8JrJlw8pSk9wakHYyPvWC+jnc5FCfqFcKfjL4cVxgZiyOzW86mamTXND
         Dmax1wyDeEdPfzKaS+CRM3vvXHw8KL2Sb8oA2jUVFIwllX+0u1WjS/GTOHgkf1Wdu/br
         3eI3QCSyy7200GbznvzM1Ofjiy2oTs42OqJcpenSv0hfl9V7nMyKvTF5l1BhED8GAc/u
         txm/JrzXq5hH8sP7enytiD3qwRkI/PGFXckAyGKh8hqGOrgOQKC316XDXkNN35mkVHTz
         lbBQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779554962; x=1780159762; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EIa8bm3wefqdftkj44KMQX6I0eapyj2RnpgMUVefGr0=;
        b=gMphvjgaFstTp34uoGnV1dbF6GiURqLPxX3ljzQUDBuTARAIjVwi9w5U5KvFmyL1Ot
         6EHLL8E+307uPfMhVDZCX1Eqjd6Qa9yWExfIAvgIb1oDFo/xWETMPuGMhE3NKgtFiLjW
         FWe39RnLbl7wLT1ve/cAaWEpNTX+oRZVu/lzpPAPT8BdLDmfm1zuLJjyQKJv2qq/kXvx
         vDjCK3OeLLDq5hBgKzeYagVeVTYuC4U138PgmiJQYu9QWMG4RjMAZ5x37gaCkRpuxJ9+
         hldDUk9tcQmCsxGsHc5KkUoKpIyrUZy1Y+G3Flc79DRn+Je/ccF2sNkPE6nGWIcvBQIp
         Tjmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779554962; x=1780159762;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EIa8bm3wefqdftkj44KMQX6I0eapyj2RnpgMUVefGr0=;
        b=h+/9SouW7vAM7AADgP6HkvxtmSLaAFK1bdzXN3+48buC5xs5PwCk088CkL+ixZ8AJo
         TuI+4axrYzjV0iTHPy0iyQAF7byqmCmDr6cmvnHIBmukA+D++DNcMzP4UNlBNjnNvh1v
         WSjfB4F86KxcY5obdjnnwfEJZl5T3kDGoxiLJzquWnjQegb0AFGNYO+nGNlr5uRpaOo0
         2IfUDzZyIGhDWtWxl5MjnPonCFPPGHtMH85ZNAshA+WjHHSb6Kv/7grPDFq7eehnJFRc
         6VElkrJVh+LrSaatLnvT7jhJPyqQoiRarhryHOKtNumiEZXPtXjQZxjakJ21SGSvGpmm
         TlhQ==
X-Gm-Message-State: AOJu0Yy8QovSWpmzfUF4oUlfVflvG3vl1O+MXqWR1RPzXmnPKdnzZHWh
	LDXR3dJKCMz/vrzmBwxit/SfnM4OeSuWem1TKR24iuSouDdvpKVAw+VcwGchbQ8KI/+dDsxH5ya
	jhZVB5aNS3qaj+Z3mlD3LP4WpujKtcp4=
X-Gm-Gg: Acq92OEcSyY2z25foW8Kk1mYrK6ul33+7NrQu1vv3MJtiWo1QWqoitz+RdrGELjBa1H
	YK7vX05TusXmjz+wdGwX7Ed3Km4DhaRAPBqjENkw2O4HfqFMjs/JCYXF0qbgAWeY/U8TpES9sXS
	6HkKImXG+AfBDRB3XRPypHgEzmJManr9OqR2dACHk9nQS47dr28X7rNmmiNUwu8Xmo919Lgt/fU
	NzePuSrCVkO7RT9y6pKL9MadiX8/4ucZE6Q0GIKg3MHHScxvJpR25l7BH6XQ71v74jL48FSDjUh
	3pMP/M8t/bTdYjUhFToKZx9fUg/lX4MXJyfmtozrGPfyMQIfNtJmBJUWRJNcTqGkpiHS
X-Received: by 2002:a05:600c:4e0c:b0:489:1a63:509c with SMTP id
 5b1f17b1804b1-490422608cemr136597435e9.0.1779554962257; Sat, 23 May 2026
 09:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <20260522023234.3778588-6-kpsingh@kernel.org>
In-Reply-To: <20260522023234.3778588-6-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 18:49:11 +0200
X-Gm-Features: AVHnY4LErFJSCm8vXvIVuhSpX1QDsKcWsBatlBn4YeIC0InaTOnQJ0A0Ch0pTNM
Message-ID: <CAADnVQL4ZXwGwxBb-Z6W1m3K8+Vs8HYUZQa5-dvpqpy-8p0cgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 05/13] bpf: compute prog->digest at BPF_PROG_LOAD entry
To: KP Singh <kpsingh@kernel.org>
Cc: LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 22, 2026 at 4:32=E2=80=AFAM KP Singh <kpsingh@kernel.org> wrote=
:
>
> add_subprog_and_kfunc relocates kfunc CALLs by patching insn->imm
> and src_reg, and bpf_prog_calc_tag has no rule to mask kfunc CALL
> fields.

add_subprog_and_kfunc() doesn't modify the insn stream afaict.
Do you mean that bpf_check_btf_info() resolves CO-RE relos?
but loader prog doesn't use CO-RE.
I don't quite see the point of the patch.
