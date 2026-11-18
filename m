Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795011498;
	b=uALA3cKSvlmuoUwjXPnPI98lzkDoLSr+fbKvv4KAvVEgAbLxYKMY4eboBgQShnv8K+WG
	 IIR5RuA34xtHZiXN4lYeUjokr9hFvbK0U1HzcuQV5JDJJVrFcke8Xo3njOHPV9903UkFD
	 TL8AdTHJZ/6WW4E8L99K/kqfFHMib2UBQnUTgLQKqtsvf+64xRyOg05q2s9y8y5qb+nVe
	 nBjkOKhmg+QZbVizgGv/DNXhHN09rSwif3G+CIRm4vyqwpTol3/vLZtaTttLxwR4+63ac
	 N1/Gxdl+jyXK0jd2dKVzjWaeVu7s4uobpe+YqL3+FNhgTpY9negBuRe3pyTzKZNrOCQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795011498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=E995rutgSzyg1i9LNX9zVJhyluCmPXgjFoQIxd7q954=;
	b=1j6xNjxql8lumM3pT54Ibf9dfPcXFytfGAhcDYjqKPinRFJC8pQjjYSfurUxfhRSxvrn
	 bZKnEVxzPfkNrhICmwffOU2VuOXpa8BcAKSZiw5nKdfeNJywHEG2I0ENRWBWjJZy69hjI
	 gKmYxg68WO9tBSD/XXKDRnXrgi3oiEjrUWh5OYiOporHUxEaC8rBtc1rHT8equBcZ2P2e
	 zkjYMsOzzCcEwlZebBKGj+CtSbG10B1ohTUNETF9JoI2JtyNx08Ki7ySVDCh2GAfzlAt+
	 l7Z1nHWgv/xQD/BW8PuWXVYqgFVUhFMx75taMOBBH+82aJX1UkylO/zTKzfGRB2UF/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AUModmDo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.224.48
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA69C60A2602
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 14:18:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AA69C60A2602
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=AUModmDo
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67da69e7c31so918762d50.3
        for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 06:18:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795011497; cv=none;
        d=google.com; s=arc-20260327;
        b=UhltCVdw+lN9B0vkaSPEWLfzV+PclUPyedvRho8I3Kk4FRq5JgkyDHONYBg6/0XvUf
         DC1ub9aFqjGKDGzkmvg65KBOL73lCNZc65qnqT6FA8G2PC9Pazh2HA0NN6/wdfcOIfrm
         S0jy1RIkZcllU3osdduR5SWCwM3047PnlrS3OCVQ0ve1JQKwjTeAfH4Txlzjds7XCt0x
         3GTRe0OkSeV2Mhkmf++f9GAyL52FH4XiEJBYdpyC7+CDvc8IkCIDd+63g/dkfRyqSPRC
         BgbpI/hyqh1IhPTX/MjJdsFcJK1tddnjoFEykTAISl/eG6ldbwWGKpR9H9mxbnUyqkkW
         Ookg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E995rutgSzyg1i9LNX9zVJhyluCmPXgjFoQIxd7q954=;
        fh=8CdP6mb7dPn2FYYvcObeCU+lnH7B1eOJCal7Y53Y1C8=;
        b=QBeGBwPYx1WLTBUwAKYxxwFsrYr1UTg8Dyw4PWE+QPSmp004qlQ7w1ZdFAiiIl4Lao
         ACbZSEjnHgynOI5sSeKoHm1piBCMNItO1g84iSw7J4XCCBbrbRGtjojDl+LSACnazyOY
         ITOVWP+q9/iVTvVj4Si3ElqdwiY2rhqaNbyKgDrPkcI2GrsGcxOmETmmBH06MXqSMwpo
         /dN9642YNNpv3ArfnteK6rf+t5eQ3N7z7JAlKkAOCFweQH5qfljFcboKcQVzV7/j5Nwp
         d2eTuxofXmtSPVBGGz31gtzLMtsgXMMhmfESgKqeeLa2lBM0MAe/6iTfrSZBHiGv0HZI
         wWgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1795011496; x=1795616296; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=E995rutgSzyg1i9LNX9zVJhyluCmPXgjFoQIxd7q954=;
        b=AUModmDof6ErWSMGyCdXNcxfTkCwx7QQL2OOBXQ7guAC6qyj7WSCpZaWOY6QzreIOx
         4pS1K2knwQavnNNBqwkB7+CVuy4nIAO47uvqWWVcKyxSaO6HjJtoc//F5a0pyaE8S01s
         /czjdm/4IH2mCCMXcGgJ+GZqDBEUEiy7q/sTAICpTY1pUfq86x1hJs/saKnvMVve4VAU
         dhgD9wlXcDkxqLBCRCjgiv0lYbOp/01AnpGqDAN4hs0GNRXnJ/5567cggS43udDzh4hT
         S1mqoJlVcJcBRP7sAPAVEiqwKlHWhgOXZR0SkDez/xXmjrYfV8KYm/x8HKsnMN15yy24
         SeHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795011497; x=1795616297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=E995rutgSzyg1i9LNX9zVJhyluCmPXgjFoQIxd7q954=;
        b=HsJv7Aw48ARx+wA83DTklaT0GOGDDUxlCPVA1POTuA+NP/0a+q5JIQCnfR1Xh7sZlD
         MNCnyzBy8LRiyjZKV9T9UTAXaouTLXAltPK6sFd2RJO/VaebUYtbXxIZ98YV1cA0nn2M
         RYIQtLcMUTE2bk0IpHDg+TF0llW2eKnz22Q53BBHYQyb3rBruUv3OkSI2/skiz5YgY5k
         QgMv+odL7EwvujxzfwzYYvXCLFSsYa35Der4buPkaW7kuNqB1DAb85DCNzO7VpLviBWS
         xI3Jkw8LYjsDIj2C9QSJAp8hMgUWJtZc+o/l/b5CQ6CBTXwJH2kL66LrMfgB3KK/leqa
         869A==
X-Forwarded-Encrypted: i=1; AL+hErG0KN90GAobiz7b10aLAK5E1mEaxmOfCGZ7AGTRdF3g6ymG+FXdKLfysMRW/fMCK4yXbaHTiBXlfy+Z1CF3JGD0bMP7Z64=@vger.kernel.org
X-Gm-Message-State: APuU4Z9vwNbqkMWfnLqVf9AYRtcur39WZpOdefNaAT/4HRoUJTpfQzxg
	M7mpRLHvSqVLQhyFCVvJPEv7A+QfsBYFIqVvq3BIG2xnRf3mRQhN4oiatHBt7Kj5Gv79xSKqbV4
	CSuExrQNjxtLFyp+LOaIaUySCCeTK3zpSY39413NbJPQ=
X-Gm-Gg: AZFdTZfBntOHf2N/N7uDjGA17nQiy1oOmw6UqCBmiC3Ge7fKzIIksw38A2RIpGzsfrl
	zJ2NX2VEiiHYA5c8aJKw4g6u010dqSsL/GJMYo5hBszi8cIFRt+Q/KlLaQS7mYxnCaNcwgkhClq
	iaNKv18cuI+qUSfbhn0ZczJJaJIDl8rs3jCbIzg24BhXHWqIE3aDDJnqkx+6rCtoecLz644DiaR
	i4h6XYCVDgK7iz33jRbAEOD5nQ9+ry7KuS/CvIxfkIySumntvRBG/37LF+LwXfrejqDbJb3uFQn
	IIDC1hhJstEFqJlk5y8dlD5Ir4UWQzHegQjxmM7CaMh/MYFDW+HO+a2UEd0NBROX2IlEQnGA9lz
	aGBiG5OA6zh4flCoG10O7O0XNqtIT+q05uH9WMZTOo/zPSLSrxJ+cD4yAhdVfZyQnJ1kqSC4=
X-Received: by 2002:a05:690e:190d:b0:679:a42b:f0dd with SMTP id
 956f58d0204a3-67dd3cf9efcmr1187071d50.14.1795011496626; Wed, 18 Nov 2026
 06:18:16 -0800 (PST)
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com> <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com> <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
In-Reply-To: <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
From: Daan De Meyer <daan@amutable.com>
Date: Wed, 18 Nov 2026 15:18:05 +0100
X-Gm-Features: AclHuK_kSwvu5Jj3k6C9_kA8WpAYJGoXqqdOwo0daouusPGhJdTvAUCcGkN4sy0
Message-ID: <CAPa8sAh6b5xn4rZzPfM0nZ+_kkywWj22fy8deLq+6qYews0rdQ@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: roblabla <linux@roblab.la>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, 
	Paul Moore <paul@paul-moore.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Note that we've already merged code in systemd that depends on the
current argument order, so I'd really prefer if it didn't change. If
it does, do cc me on the patch so I can fix the issue in systemd.

Cheers,

Daan

On Wed, Nov 18, 2026 at 1:52=E2=80=AFAM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> On 11/9/26 8:07 AM, roblabla wrote:
> > Hi,
> >
> > Thanks for the replies!
> >
> >> [...]
> >
> > So what would be really nice is a way to make eBPF code robust against
> > kernel changes such that it either works, or fails to load, but doesn't
> > do the halfway "loads but silently misbehaves". Here are two ideas that
> > have been in the back of my mind that could help solve this issue (thou=
gh
> > I understand that they may be rather large changes, I'm putting them ou=
t
> > there mostly as a conversation starter):
> >
> > 1. Could libbpf/the kernel have a mismatch check on hook arguments? I
> >    understand that libbpf and the verifier don't know the types a
> >    program expects, since BPF_PROG() only casts u64s. But the macro
> >    does know the types at compile time. Could it (or an opt-in variant)
> >    record the expected prototype in the program's BTF, so that libbpf
> >    can compare it against the LSM hook's prototype in vmlinux BTF and
> >    refuse to load on a mismatch?
> >
> > 2. Since kernel BTF has parameter names for the bpf_lsm_* functions,
> >    could we maybe have CO-RE-style relocation to resolve "the argument
> >    named dentry" to the argument index at load time? This way, adding a
> >    new argument could happen anywhere in the argument list without
> >    breaking eBPFs, and removing an argument will (correctly) cause our
> >    eBPF to stop loading. It does mean the eBPF programs must provide th=
e
> >    same argument names, but maybe that's an acceptable tradeoff?
>
> Hi everyone.
>
> roblabla's comments got me curious, and I spent some time with my
> helpful assistants poking at the problem.
>
> There is another workaround in addition to what Andrii suggested.
> A program can already make itself fail to load on a signature
> mismatch:
>
>         union security_list_options___mine {
>                 int (*inode_create)(struct inode *dir,
>                                     struct dentry *dentry, umode_t mode);
>         };
>
>         extern void lsm_proto_mismatch__inode_create(void) __ksym __weak;
>
>         SEC("lsm/inode_create")
>         int BPF_PROG(deny_create, struct inode *dir, struct dentry *dentr=
y)
>         {
>                 if (!bpf_core_type_matches(union security_list_options___=
mine))
>                         lsm_proto_mismatch__inode_create();
>                 ...
>         }
>
> bpf_core_type_matches() checks the expected prototype against the
> hook's member of union security_list_options in kernel BTF.
> On a mismatch the call to the unresolved weak kfunc stays reachable,
> so the verifier rejects the program, and libbpf reports:
>
>   kfunc 'lsm_proto_mismatch__inode_create' is referenced but wasn't resol=
ved
>
> It's positional and needs the exact argument count, but it turns
> silent misbehavior into a load failure. The same should work for
> tp_btf with the btf_trace_<tp> typedefs.
>
> But of course it's just a workaround..
>
> A bit more generally, expanding on roblabla's second idea, I think libbpf
> could resolve hook arguments by name with the existing CO-RE machinery,
> without kernel, verifier or LSM changes.
>
> The BPF side could look like this:
>
>         SEC("lsm/inode_create")
>         int BPF_PROG_ARGS(deny_create, struct inode *, dir,
>                           struct dentry *, dentry)
>         { ... }
>
> BPF_PROG_ARGS() (name TBD) takes (type, name) pairs like BPF_PROG2(),
> but instead of casting ctx[0], ctx[1], ... it reads each argument
> through a local preserve_access_index-marked struct, so every argument
> access is a regular CO-RE field relocation:
>
>         struct bpf_func_args___deny_create {
>                 const struct mnt_idmap *idmap;  /* 7.4+ */
>                 struct inode *dir;
>                 struct dentry *dentry;
>         } __attribute__((preserve_access_index));
>
>         SEC("lsm/inode_create")
>         int deny_create(u64 *ctx)
>         {
>                 struct bpf_func_args___deny_create *args =3D (void *)ctx;
>
>                 if (bpf_core_field_exists(args->idmap))
>                         /* use args->idmap */;
>
>                 return check(args->dir, args->dentry);
>         }
>
> Nothing changes on the loader side:
>
>         skel =3D deny_create__open_and_load();
>         if (!skel)      /* mismatch: load fails, libbpf logs why */
>                 return -errno;
>         err =3D deny_create__attach(skel);
>
> To achieve this libbpf would need to do the following at load time:
>
>   - treat bpf_func_args___* as a reserved type in CO-RE relocations;
>   - find the program's attach target in kernel (or module) BTF:
>     bpf_lsm_<hook>, the fentry/fexit target, or the tracepoint stub for
>     tp_btf;
>   - build a struct from the target's prototype: one member per
>     parameter, named after it, at the parameter's ctx offset, plus 'ret'
>     for fexit, fmod_ret and LSM;
>   - resolve the relocations against it by name, with a strict type check
>     (pointee types must match, qualifiers ignored), since CO-RE normally
>     treats any two pointers as compatible.
>
> A missing argument or a type mismatch is a normal CO-RE relocation
> failure: the program fails to load with an error naming the argument,
> unless the access is guarded by bpf_core_field_exists().
>
> And this is not LSM specific, fentry/fexit/fmod_ret and tp_btf would
> work the same way.
>
> It doesn't help if a hook keeps its signature but changes semantics,
> or if the attach point goes away (that already fails to attach).
>
> Here is a vibe-coded prototype of the above:
> https://github.com/kernel-patches/bpf/compare/bpf-next_base...theihor:bpf=
:bpf-named-args
>
> It's an entirely new libbpf feature though.
>
> Andrii, what do you think of it?
>
> ---
>
> And just my 2c re argument ordering:
>
> Paul, with all due respect, prioritizing code style and personal
> preferences over backwards compatibility is unreasonable even for
> unimportant applications. And here we are talking about apps
> implementing security policies, which many organizations (not just
> companies) in the world rely on. Given the recent flood of
> cybersecurity issues (in Linux and beyond), I don't see why would we,
> as in kernel devs, intentionally make the defenders' job harder.
>
>
> >
> > Thanks,
> > roblabla
>
