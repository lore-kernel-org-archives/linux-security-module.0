Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E221CAA65
	for <linux-security-module@vger.kernel.org>; Wed,  1 Jul 2026 22:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782946713; cv=pass; b=Q27UmFc2oa0vYo77I2ABUKpyVO1o89hOgROSxlp53vf0dsHsd9keZ76Ami+p3AXaH5oDLKumGeO8FgkjlgZP5LqGPxyEKtcR/NrJMcPMmOmBWnstb2DWtI4vpJKkncxDsNhh9yvU8IHWcgpuZRpb5HaOMGVuKCUPmUNKKbiqRec=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782946713; c=relaxed/simple;
	bh=v333IQ17seFPobRriFVv9irQiGfOh08ZeyJ80kHbi8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsQ2zR0BF+tgk2xd1eKsFwKHEqiwP4exMcBHSiLn2WZYpeCdO56VtIPRdKxZrx5QRT3hvpdPQ9tlBADb+qp+LMrMCzGhwLh/RdCwEvR7GLfzTsbjIzqNQTSYuVYVqdXT9S3m9mi2Eha8v9Uo6vc9xtzQHiAONkSzml1L0K0s1PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFMFLejt; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFMFLejt"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ef1dc934d1so10096616d6.0
        for <linux-security-module@vger.kernel.org>; Wed, 01 Jul 2026 15:58:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782946711; cv=none;
        d=google.com; s=arc-20260327;
        b=rGUpOxHUesLC5yk8A750op+gQkWLDLyY5u+Kq66I5ZyO9NXP2TsBI34dC/+NajYobl
         Awyo9S7i4orWcJiuRfdFQifX8/kpB6isFBrMmZQXGJsVIROhSACPOxpszR+DKFj37RiC
         cCE/qiJTbHHQMkfpezY6yjrNvxxsocpaFcqtm0pVrmJpCG0/OwPRIyNBpJ6NQgwfMAnL
         rQsTb+xrFS1PYUcEI4u3JnmxSjxI00Kg/nLReIVEYkqEa/U+HsCO1N0hadw/UwjF5jBw
         jBdvU1tvtvCInCvzqTSb1Lv0o0eQwGg/vLuHpq9kDu1/4Juqz9sHviQbrTaWtqajWhhx
         H86A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        fh=4LRgU3GocqQQ5nnaqI8hvHKf825hpHfgfQpfTGWZrVM=;
        b=RkPkHIlMxTSTGA4qV61oK+RwJutowyJ4ZskQfyFU3TRxN0cL4JFOBjfBG+dxsXArCg
         eTRUrzctQpld+aLPj56vWxV93qj4jG+0ojUdQbNI1EjtgCAR+jb+8gxQb+R0cKziWttW
         QbVu67/upuodO0kcXLylUXomGheJ39GcF1SkU/1sZUBLq6FGgU7PgI1isWTE7QukTMJP
         BstI6Sr59OzizCgaElzoFAUTW/+nr41nPDDcEfrsWNtaX/ohQYB9Wxjpr/m10O8aSust
         /dRE4dnalrB65rC6yY2+3kE7IYkHHt3cdecIQwMELMN+xiXHpLBNAYNehD91rKbJY8WS
         6ZvA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782946711; x=1783551511; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        b=FFMFLejt7D9ehe+p004hrq2XpYh/HnFijFKVfrm8olTlbQQ7Q7yb6sS8daedUAOGKB
         6ppRzKfwcFgKnNWKKZCE6lRbSrfVChgXrJ2eDvBGCtvSvvffEJgsf/boiPb+ZDxXdvM3
         jEmUVryajCTjqPWMW4oqmFlumVnrN9HEaI5FyMjkJl2TwZxGCHXsx/IhjQjvDSRsdW8y
         ci4HYwBhSnUhNKlgPp2+jbNcb7bE9UE9b8PV15OB0S0VWPHeifUM23eKuQT5ZR2Jwm4+
         guR9YrxXCt6E+5bP4RccjNaIhWPN5J4t5uV62EOTkayWIG7vRIM5AgvE/c5wYCTy8lnT
         rJNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782946711; x=1783551511;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CGmjOEAN5rh7B8OxF2M94IMyzquznWKtrlOs0FGhk1c=;
        b=cPOL2Efp29kjTkGPwEDYlweIlT8MaHMtvBhj/rx5F94nW+DmOuer/xaQ7LrvQI4oKq
         pSRwkwMfX4nCPumLZ7et5ymmVTMcQ8fmcf9RmIWJkURsykDUZBt2lKXtNahlldGw6rA8
         uZ/jEZ4/unVi6z4BxWeY1Q29YtKr/3Ld3Oklk05B9Ve24UZ/ECQptnrYLDswY+e8d+DT
         iUnvf3GIe1AYFYpZlA0O/GJN2Qeax1oN5onoXp9+kDPByaOhXnZfWYgoV/OXfjUGZICT
         RFjzcHkNp/n3Ej5Ei6qURMAN2N6mHiZJDmbVBw01Wtuhq3WCiBRS1ZKSZ0N9IWOwF4WO
         hVrA==
X-Forwarded-Encrypted: i=1; AHgh+RpKxtjIsJ+9NMw9DHQhBgm/FhQKbhKCTicR4Yzy2zZjO3rMSa6vqF+5yV06aEp9K6XR33kmKwXMyifz7N2rEhMDeNdI3iY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbp+o9oXD4gnYZM5UL0nKfTNlIczghvyVlb9T+B0beP7wBIScC
	CY3NEb3cYbGkrY5lJZdBdebZLNsaY66NzG+oCKxPqI0b4+24z576RhU2GIFjBZcFz2HQhIzSf0h
	MPfABNaiz842CckwobeUr5HGykLDFctk=
X-Gm-Gg: AfdE7clYQj2MXPMZ7qboWW8JlrgDC1ZL0w29cANO1ce7QYAIFgujnbQWhXvimiQ+9uR
	rZXzCAXl7pUFwNUFaUH7Si7JCKArwNktckj66t5+NOLz8uBrvoo8dI46FhGZrZ4noWaixUFjiL6
	jNoswfqiuexlOqqBhMlWsQVLPJhUwfqqIVJgXxTcqF70BqNoAwaV1OdScrJuBgQAZBBIINKcYv0
	c4EkeKhTQjozqGsbnnSYAJEMz8PEQlWAw5Tar+i8gZxB7gVyi4Ad3gYKHz+dDEn7u7UrHtAUJUt
	U460GTlfRH6YvBidhMzPZ7+UOPc=
X-Received: by 2002:a05:6214:55c1:b0:8e0:c0f3:a2cb with SMTP id
 6a1803df08f44-8f24ead200amr108961456d6.0.1782946711091; Wed, 01 Jul 2026
 15:58:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630183956.281293-1-dwindsor@gmail.com> <20260630183956.281293-3-dwindsor@gmail.com>
 <CAHC9VhSYNF=_Tfe-D99rHy70EXQVr1ES0arxT09Bidey4zOFdg@mail.gmail.com>
 <DJN0EPROS056.3RY0R6W1XZHNZ@gmail.com> <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
In-Reply-To: <CAHC9VhT37f5TwgksE_i0Yttpy3i7niBr6QrNVVmpwe_eGX428g@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Wed, 1 Jul 2026 18:58:19 -0400
X-Gm-Features: AVVi8Cd--WxIEfBHVAG_4saw_HtYaBPqRNY7ATulZIzQtiR23TCVwYiJaDu_5Wg
Message-ID: <CAEXv5_ig4P=wMoiy4h-TbZt-Wz-YBAs5k6R4szSSxr4C0kjCTw@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 2/3] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Paul Moore <paul@paul-moore.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Emil Tsalapatis <emil@etsalapatis.com>, 
	Matt Bobrowski <mattbobrowski@google.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Shuah Khan <shuah@kernel.org>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-integrity@vger.kernel.org, selinux@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 8:55=E2=80=AFAM Paul Moore <paul@paul-moore.com> wro=
te:
[...]
>
>   kfunc bpf_init_inode_xattr(...)
>   {
>     /* sanity check params */
>     if (!xattrs ...)
>       return -EINVAL;
>
>    /* get value/len from bpf dynptr */
>
>    /* hook will check for LSM specific xattr count/limits, allocate,
> copy value*/
>    rc =3D security_lsmxattr_add(xattrs, LSM_ID_BPF, value, value_len);
>    if (rc)
>      return rc;
>   }
>
> David, if you like I can provide you a patch that implements the
> security_lsmxattr_add() hook above if you aren't comfortable writing
> that, but if you want to give it a shot that's all the better :)
>

Makes sense, I can do it while I'm fixing the remaining issue flagged
by sashiko.

I'll route the LSM preparation patch containing struct lsm_xattrs and
security_lsmxattr_add() through security and the kfunc and selftest
through bpf. Does that work for you?

Thanks,
David
