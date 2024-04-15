Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46819757FD
	for <linux-security-module@vger.kernel.org>; Mon, 15 Apr 2024 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191031; cv=none; b=g99KcD3u6V351ECUbAURT/uKKg3Hn6VUvvMgFy28MPuyB7NMiRuwvePYtWB5ilV86mg44SjogFo1NTw8PfoPlKyYPBK6H3gq9wcwu+ngbSdbirVuSpnbkihKATtias4m6wCwAbCrjNV84ZSNtefuVeDe3pwWo+oFZEjGORiuYqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191031; c=relaxed/simple;
	bh=DjPumZsJVqQfEW+5UWh6pJFZsGr6TITJM6/HJu6WuT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE3ZvRf98J95nOXgFShSM3mGSmweBZ4X2FZk/0XiNnV0Hl+tKWAFzfBcNK7V/jh3AcrzbmnI77ySjH23841k8XNzA9hSgf2gDxKfqAI5Qhri5F48A/nK26i8UpCtt85E9ypPTILQWqhytxX+5TgIE8DkgdL91PBVCdEG11bRMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BoaMYgfc; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BoaMYgfc"
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-617ddc988f5so38833177b3.2
        for <linux-security-module@vger.kernel.org>; Mon, 15 Apr 2024 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1713191029; x=1713795829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y9VbcLLmnz0/DZyVAYjkm3SQI/d2qqNn15GQkXprXI=;
        b=BoaMYgfczgaDjoRxhzNAQ7bZ0H8eU+4jlR/fMEGeke6IVqH8nRCIXyx8jo1N7tiWkx
         rNm7o+0QP8Vv21hfqyhbAzOfJ5BLpfFYINqwT8M0hw8wS51H6T43CavRlDl/LJsPa0SO
         Vq2uhxr3fP9KKS6PBOFadLxLD/DuWRlFFeSiQ3SF1137w3MZca4BuEP+tUHuZJfZbaY9
         m0YkttXxHKE1/dz5ytD5XbFx+S06LpjPPwYuJOB5gttVS+E/bglNsNG21No7t5P1TXJu
         z0MYPy5Ftjt7XUv04wzP+A88IOnT7KWsBOy5XNbfjmOjtuo6kOG8R13bxG0nnoU2ay/V
         gVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191029; x=1713795829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1y9VbcLLmnz0/DZyVAYjkm3SQI/d2qqNn15GQkXprXI=;
        b=PREDJhxOOTzQq0xBx01w1Xdt4oXf1mlpk4v8Q1xdCUbwD4/zcDfAalne7HMH8XtOVg
         l+c+YeE2YfwaJW9oiBrVk5MYMh8reFtGzUbu+6Ar9FDLnXwUTANcuTlnSUrnjJmVTF3V
         KN9eCAnOcGI43e1l8bMH22JIJMVrGk0l6oKwehXGSYYz+Lv1q6rGFLZsM31IVt0f4QkL
         3SRjrxaKMNIc+JXpGyiHC0NXk3Cw5IEzqIKWK/2vv4358MVKf+yS5o5oNCmTyQ1ueUxa
         qGAcbaHsR2wSuJhgZ5JXcuBkT5UtyBymYf56SPAOYNyFdds0e0BbdROh3dOuK5UbfOBo
         9o1g==
X-Forwarded-Encrypted: i=1; AJvYcCUvk8grW9g+f3+jjfKxwDCqg5UV7p/VUTjYLkM9u76EN4XcYGsmP1AqROPcg2jcX+r3Gic8Mrk4R7W8ArcDOcVHrBA4DYKSiq3NDqBoWSmm3g+bPM2G
X-Gm-Message-State: AOJu0YycLIUk3KZO6TjORO9l45WMKn3VLdjWObMurGtbB12R5VSu8Jsg
	5/MMhNUavP7ki4LOvvod83VJHL2jkQ1c+LCQ0ZoQTC+9qzbZ7bITc3FHpvUQROx3ZfFDYTSeI5d
	+CWz3b4s8ijV9n65/kOQET5zGULOqEXgzIoBe
X-Google-Smtp-Source: AGHT+IG5YBGt31zPh1RxDxOyUC/oOmAliyWal5DihWErYrtjx3gqFZi1R7MMZV9pnaXYiGSBEJ7vqkkuCBVCnULk0Vs=
X-Received: by 2002:a0d:dd91:0:b0:614:6b2d:c6f8 with SMTP id
 g139-20020a0ddd91000000b006146b2dc6f8mr8940716ywe.46.1713191029296; Mon, 15
 Apr 2024 07:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404151225.ce542e38-lkp@intel.com> <757538DA-07A4-4332-BAFA-B864BFD06A76@kernel.org>
 <30876b80-c437-4916-b982-97c1a95c0747@I-love.SAKURA.ne.jp>
In-Reply-To: <30876b80-c437-4916-b982-97c1a95c0747@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Apr 2024 10:23:38 -0400
Message-ID: <CAHC9VhS=hQuvv+Sw6cc2HwzcLApO7Rc3dAnqHytyzBpC1rokFA@mail.gmail.com>
Subject: Re: [kpsingh:static_calls] [security] 9e15595ed0: Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: KP Singh <kpsingh@kernel.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, 
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 9:21=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/04/15 17:26, KP Singh wrote:
> > This seems like an odd config which does not enable STATIC_CALL, I am g=
oing to
> > make CONFIG_SECURITY depend on CONFIG_STATIC_CALL and make the dependen=
cy explicit.
>
> If CONFIG_SECURITY depends on CONFIG_STATIC_CALL, architectures which do =
not
> support CONFIG_STATIC_CALL can no longer use LSM ? That sounds a bad depe=
ndency.

Agreed.  If the arch doesn't support static calls we need a fallback
solution for the LSM that is no worse than what we have now, and
preferably would still solve the issue of the BPF hooks active even
where this is no BPF program attached.

--=20
paul-moore.com
