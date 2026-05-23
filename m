Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2279232395
	for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 17:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779555695; cv=pass; b=ZM+OE7NQG0Zuj/0A+FKoeT0eHPq+5PKjJuVBw1iTHXNA3SwvBsGH32ns5i9qL5+nTl51jnqPLXe4Uo68m7C60uN3/h9Bd0TG10HE1sLa/Q8F89CMywrGPUV7UPVDuxE86nrGZcJOBS99b7dKU6semmjom5kUFGDMdXGIXYpreg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779555695; c=relaxed/simple;
	bh=cEmrk462oGjeu+ADXPndK8LVZiOJEDqSfM9ebCI1RUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FcXyD2yzEZ5lqMsWjaOPOgXFw9crFYHhILeHzqjapj88mlvrm8imuW0t2uKqsRPlk+pcXdLXGSJg4LQPtgeKoQ+LBFeWmtjPWCXYbROZlzgS89Oh/uKAnQsiR48Rod0TzCgUVuUPQxlAxvb96nHG6lVGrJs/nc2DJM0KqpSSNjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRmK7I7C; arc=pass smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRmK7I7C"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48a563e4ef7so62723015e9.0
        for <linux-security-module@vger.kernel.org>; Sat, 23 May 2026 10:01:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779555692; cv=none;
        d=google.com; s=arc-20240605;
        b=LYiF7Rz8NSW2fgjn6swcWVJrBG0hWKk+Z4Ra/LlFAtcuYjig2w5MLSs7fBxKU5OI01
         ++G8nSOh72Lrzt02zO9pIvJU8iZ/Pq5mwaVv+onG8Z0OG0Uy1xYuB/7OzTmOHR1lRn5e
         q5zYK2NXeZFFjydL0u32r9kwiCFTHcj3T4mM3JeingPd7PYW7jTw6N9eW3AzX69Utpl1
         NhzYB/TxXHurazdwl3hHOzpr4NXrbqSLaHiWwHkHYv2ccYB8BJzh4PSbaHBiiwcJ/ZCl
         13+MbaBawuX/2rKAwNoCJ0iNNpg3sIQqNd7X0nt9dryuV2FFzkzdWk19WQcHijpaG5r4
         x8mA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9f5AmCFliRhUxxEAOVXzXyssTmCJ1zSC0wsG9UgnqpE=;
        fh=bN4nGiGVMoYvaEVGV0iOqumB+ukS2TASSPIMWw11zK8=;
        b=M4IA8uSiaSCy1GPYt7iKX9YbFzxrX6A0K4dQAqgIW0q2ixGlY3kkKSZRFNOXJ5KZ7x
         sKk/xDINYVGp01BlmitrCBd0IByt5qC0fWXEw0F5Url6fcNEM5NIyYCsHzXBQqajozSy
         2yXgIpSEVi/Sw8agyMbvvM3jdz9PlEkIeTWPVFvRxcDcBXpVtIboexRir6FvWXqApJg8
         hCXrwlIfVPLEMSWvnmahF3bX1LDRcnhX2fpvxWG5Xs5UlvyZRDbwzQs6ShEkYj13baBc
         j4LHK48BV8aCkAbro6++c8iLCnZIPnbtoD3Q88p28eItyrCbJXXEOdM0STMFWZCTrSFA
         lBAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779555692; x=1780160492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9f5AmCFliRhUxxEAOVXzXyssTmCJ1zSC0wsG9UgnqpE=;
        b=eRmK7I7Ci+1ZHCBfOE6TqXmx1WnX8k/s/25k+RvvbZSBZrGLCK2UmhERI17R+1mzhi
         yMPtfgobEMqgqGE4UkXvYgA70wHXqIoKi/VDjKGUsib8Kd+VinhYBwfAlKYfmr8HSgmc
         Ev1f2rrtsA8gs7iaxzVTko7kczgjU4jpFXQt+Ei2iRSNFS8eSm+ujoFy0lkDkWX/SdF7
         jTnCsTZbQ7B9EV6Tj2t7faEMluaSKSxCYJRr33aklE2eyo8ilfFVEZKkqbvee5oLOOqq
         8oVyUSQghUI88sm9v5Z7/m0xmpPN6/ne8BgBTbgTwZvLrbRtsB6+GgpnGpfGZ4DbB1MX
         ytNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779555692; x=1780160492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9f5AmCFliRhUxxEAOVXzXyssTmCJ1zSC0wsG9UgnqpE=;
        b=bnj2t5VnmfGW+6H1nYKEsHYB67Lw8Tf1bOUxTIgaVSmi/9IqtaokSUMKitbatUT1cX
         MPnfOWIT5NMQU7kmRwmGhjCYUj5cKiibS9NvZ7BLCpbmeN2UJBAM6ozefnMmAdIqzsnj
         MWu/mgGTYjzQo/v28i9udBEMTO84a/IPwLmwgWcEDet9Hdi9efp6kuCrJbZQBB87+uOQ
         55FJxhIbKYS1ifj1BHFe5oEYctLcYk26Bw5twOvOblVsaBGxsPNiS8pO6kjfnOdnGXve
         DjMASaXTLTPo72gnqLP9EjQc0OVxMeI6mbEQaoNyTo4IQrtQqdBW3l5yJr+bSJPHsRnS
         097Q==
X-Gm-Message-State: AOJu0YzFm8EH2z/HmvUIxXUJHiu9L63m4JghUpYfe+cWSr1uuVGb4GSW
	tb1dRVxRjEkzrIG/kbohnUaDL6O9We7eaQmMH7usc4Hp3SgSn3Qv9vYgw4ItbXigCYgX8YEWgKy
	UxCXXRxZU9X3J7va9VLO4CwXjlMx89Ak=
X-Gm-Gg: Acq92OHdEo3q44+Mk6QQ6D3bUWR/r7JL9FZnazooDT5P/7YTkgKNA03y7oy/mVbgpRz
	a5eccxrZD6RY+Kaz/fWOzoLsO6H5f5jnMHwHHVtpo7shu2ZrZrJJKlNAS1D/tcES9k+syOYul8m
	QplMiVJ954YjKMCaGECIzmmMp6vQTEnXF0moeKyT/AiT+eKoM3gMO+jrFsAFll8qgfkLKz10H8/
	PeMDYBZ7mm/Z1dM64CnXai8J7TPYP0reYcpQfNJcAxKNbgUZdNrUV79x8VIy2gLYCUqzMgB/mFe
	bBqLEIJwbt5j20VwCKV/jUrTFLsVwj3Z5z1XAYqwdMGjY2XOMNKcuDJ4TXFRypFdoQI07tsVe9O
	Saqc=
X-Received: by 2002:a05:600c:4ecc:b0:48f:e249:4094 with SMTP id
 5b1f17b1804b1-490426d4bf0mr129148105e9.18.1779555691921; Sat, 23 May 2026
 10:01:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260522023234.3778588-1-kpsingh@kernel.org> <20260522023234.3778588-7-kpsingh@kernel.org>
In-Reply-To: <20260522023234.3778588-7-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 23 May 2026 19:01:20 +0200
X-Gm-Features: AVHnY4IgpP9nB-uNXblxkUX447jJ_6u_pp-3jTyj86wvJ9EN9xcferBciMbRCrA
Message-ID: <CAADnVQ+CN1vOxaEOY_uTAXOc1wVkh9_tXR69CeEBmm4f10y=ZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 06/13] bpf: resolve loader-style kfunc CALLs
 against prog BTF
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
> gen_loader-emitted signed loaders cannot bake vmlinux BTF ids into
> kfunc CALL imm at sign time. Add a new pseudo
> BPF_PSEUDO_KFUNC_CALL_PROG_BTF that gen_loader emits in src_reg, with
> imm holding the FUNC type id in the loader's own prog BTF.
>
> In add_subprog_and_kfunc, look the FUNC up by name in vmlinux BTF,
> patch imm with the resolved id, and rewrite src_reg back to
> BPF_PSEUDO_KFUNC_CALL so downstream passes see a normal kfunc CALL.
> Leave standard src_reg calls unchanged.
>
> Signed-off-by: KP Singh <kpsingh@kernel.org>
> ---
>  include/linux/bpf_verifier.h   |  6 ++++
>  include/uapi/linux/bpf.h       |  5 ++++
>  kernel/bpf/verifier.c          | 54 ++++++++++++++++++++++++++++++++--
>  tools/include/uapi/linux/bpf.h |  5 ++++
>  4 files changed, 67 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
> index 185b2aa43a42..396b85830996 100644
> --- a/include/linux/bpf_verifier.h
> +++ b/include/linux/bpf_verifier.h
> @@ -959,6 +959,12 @@ static inline bool bpf_pseudo_kfunc_call(const struc=
t bpf_insn *insn)
>                insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL;
>  }
>
> +static inline bool bpf_pseudo_kfunc_call_prog_btf(const struct bpf_insn =
*insn)
> +{
> +       return insn->code =3D=3D (BPF_JMP | BPF_CALL) &&
> +              insn->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL_PROG_BTF;
> +}
> +
>  __printf(2, 0) void bpf_verifier_vlog(struct bpf_verifier_log *log,
>                                       const char *fmt, va_list args);
>  __printf(2, 3) void bpf_verifier_log_write(struct bpf_verifier_env *env,
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 552bc5d9afbd..06056e714e8e 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -1382,6 +1382,11 @@ enum {
>   * bpf_call->imm =3D=3D btf_id of a BTF_KIND_FUNC in the running kernel
>   */
>  #define BPF_PSEUDO_KFUNC_CALL  2
> +/* when bpf_call->src_reg =3D=3D BPF_PSEUDO_KFUNC_CALL_PROG_BTF,
> + * bpf_call->imm =3D=3D btf_id of a BTF_KIND_FUNC in the program's
> + * prog BTF. The verifier resolves it to a vmlinux btf_id by name.
> + */
> +#define BPF_PSEUDO_KFUNC_CALL_PROG_BTF 3
>
>  enum bpf_addr_space_cast {
>         BPF_ADDR_SPACE_CAST =3D 1,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index f0e45cfa5b34..1b5d06b9d74a 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -3088,6 +3088,47 @@ bool bpf_prog_has_kfunc_call(const struct bpf_prog=
 *prog)
>         return !!prog->aux->kfunc_tab;
>  }
>
> +/*
> + * Resolve a gen_loader-emitted kfunc CALL by FUNC name in vmlinux BTF,
> + * then rewrite src_reg back to BPF_PSEUDO_KFUNC_CALL. Caller must have
> + * already filtered for BPF_PSEUDO_KFUNC_CALL_PROG_BTF.
> + */
> +static int resolve_loader_kfunc(struct bpf_verifier_env *env,
> +                               struct bpf_insn *insn, int insn_idx)
> +{
> +       struct btf *prog_btf =3D env->prog->aux->btf;
> +       const struct btf_type *t;
> +       const char *name;
> +       s32 vmlinux_id;
> +
> +       if (!prog_btf || !btf_vmlinux || insn->off) {
> +               verbose(env, "kfunc call insn %d: PROG_BTF resolution req=
uires prog BTF and insn->off =3D=3D 0\n",
> +                       insn_idx);
> +               return -EINVAL;
> +       }
> +       t =3D btf_type_by_id(prog_btf, insn->imm);
> +       if (!t || !btf_type_is_func(t)) {
> +               verbose(env, "kfunc call insn %d: imm %d is not a FUNC in=
 prog BTF\n",
> +                       insn_idx, insn->imm);
> +               return -EINVAL;
> +       }
> +       name =3D btf_name_by_offset(prog_btf, t->name_off);
> +       if (!name || !name[0]) {
> +               verbose(env, "kfunc call insn %d: prog-BTF FUNC has no na=
me\n",
> +                       insn_idx);
> +               return -EINVAL;
> +       }
> +       vmlinux_id =3D btf_find_by_name_kind(btf_vmlinux, name, BTF_KIND_=
FUNC);
> +       if (vmlinux_id < 0) {
> +               verbose(env, "kfunc call insn %d: %s not found in vmlinux=
 BTF\n",
> +                       insn_idx, name);
> +               return vmlinux_id;
> +       }
> +       insn->imm =3D vmlinux_id;
> +       insn->src_reg =3D BPF_PSEUDO_KFUNC_CALL;
> +       return 0;

Ohh. So this patch does it.
Probably worth squashing the patches then?

Also since the resolution into kernel kfunc is by name only,
it feels odd to create a fake prog BTF proto just for the name.
What is an alternative?

Also note that we were discussing allowing the replacement of kfuncs
by modules with the same name. This kfunc should be
immutable?
