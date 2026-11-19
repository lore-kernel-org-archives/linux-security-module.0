Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795111106;
	b=AUYdPyUG+88eilTmLsaaorQ8UlzlLhXAQbhNBMRI6zy8vsIMg/2IwJ+XYNpzkX9E6WXj
	 k1iKYDVcvAbTgc/zld94EFa/sP2/Ng3hVsZl0GFVRQJrWmuHieO33TBlgvHx/c0j/63uG
	 //86hYi+I2oFMABFaO9lfISPtJydfdatDIzo2gJlHA96BQi1sKmqgh8HtHvVwAMtHN6wA
	 lDcV208wd1zPViDzvBd2reTmQmccHl99sDdXR1aXywQx3U0Ln8+fzLOrS1eXH9liZ73lQ
	 wMkpRAkuLE3g3UeXZCy2nCWrdryJL3Xxl3PP98AzmdojW6o2kDQo1Chwj4IiR6KgOEg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795111106;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PslAxsc1zc8ecKHENMwh3peIr40sPCuNVTraR5q6Nts=;
	b=o1F+pM9YwioBfgoz6P0+LYAagXN52v96uCEdh7QxqWwJdZPaIP41GCI3KglTfWIJgsQv
	 LgzJWXG5FCTVxj6OL7eaq6kABwEiC3/reT6KF8Zvjx5uzObCeqdTTBFUGkSVJYNqycFfn
	 zynlYChLyZ/zkbpNkL61qcIeTf5UuCugryhStnWL/Al9ZJ7BrAuHsOxJw+EJkudxtO4wB
	 TFHWacNSm5Ydr/X77BBG46A6wna/ZGjhJyOUUU1yMeCJiVNpyl9XM7NRDm7T/PrHXQuVq
	 VkXt+Q/66AIJOTJHndN71ctfP7pz2arg/SNFTgbbwlJnjrKsHxa2/nz97QoWTxOsoTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KskaJ4DE;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.51
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0EC60A5BC6
	for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 17:58:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F0EC60A5BC6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=KskaJ4DE
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4a357b1c649so1704572f8f.3
        for <linux-security-module@vger.kernel.org>; Thu, 19 Nov 2026 09:58:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795111104; cv=none;
        d=google.com; s=arc-20260327;
        b=PgIIXR+GmMbUZsm6TYwyJ/OaLxZwQk5v510LDPpqGhWCA+RPK3C3rGvhBaIp6NOL2E
         kBAxToMNJAtcHXJK8HOn5txb3QhkxdbIZqjE8js01khF4p0UvXYfLH3i4Wgm64LdD/0J
         fLrZddD7VkvmwCl9W41mRheWgtazzHvz+DkwdOuEDcjaELf2+TO8SjfSp6rWksU3l0RJ
         ng71y/itu6LebrJqPUulJKsjzVzkHX0ytD5Jt7ygywuyTFYnQIfpf6oEZ4648mHNkIvj
         CDxSbbqmawMG/toQZi7mNxFV31zZV3gUyDQQnHAW/4PHtHd3HSoMLVNOdc+bVCBd9Wxv
         +XIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PslAxsc1zc8ecKHENMwh3peIr40sPCuNVTraR5q6Nts=;
        fh=irfqPuGfU4Av6HRJkUfeSXcIp/ts15+mRscdu4qMbQU=;
        b=bIPE4DyN6KqmffEhS7MBsV14hA5NElR4A2acIstcF9esPkOhhKCKxYHD5bObAWEV7V
         onxcPl55lwzWGVKGv5rhtl2p7TRjvIFiZk3zlXUVaYBF817NwHlvxMIiiVJ/xGMHdfUk
         N3GH1wmQi6kEkfchYJKnwZGqRha2jM/lFAUSABP5ilZMb/I9zgfRiGlxaSSOQ25dEL5g
         jJxLmOD8sDc6W0bkEOAYcWr1ZiuPo9XE2+FpkdJhtCGAKZQPgpK9Ht7F7p1L1XmYRP4j
         GcoVeOX5/BGpJ3swt7Is8nxuu42p03/eKPRgmxygJ0p9xBw8DuULTIc1vp3cJV5XlNeJ
         4gTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795111104; x=1795715904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PslAxsc1zc8ecKHENMwh3peIr40sPCuNVTraR5q6Nts=;
        b=KskaJ4DE9TbkUaMgwVxD/dbhrstg5KGdGNvSesaol/MYrJhWspuc0LVzoL0MwJEqzY
         g4fOwkWNChJfSfmqPxn4GprZEmgOvbYFS25vXUkx2YkNPADbYswD/0HRkFRcS3jHNJWA
         o+1yod281+t+3gODsKlHjGn4eIG0oemdhiiMxBEpK8LhpLMRA+rS6oE07kIoV8saIWAb
         O11fWDJd3UQpFLK2B4dy8VBZJm3nf5wDBWyvQu78Z34xuWQXazOgCUCDofobObBR9Iqh
         Aa6/b1pJ2Nx8gkVMxmtWMz2esM8nJYipSMzevRUFsN0VBXk1tZHFFxq4/1gEvbQiMdJC
         aCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795111104; x=1795715904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PslAxsc1zc8ecKHENMwh3peIr40sPCuNVTraR5q6Nts=;
        b=Yq9yPSqhZKjkG9zZMgDD0ArGzUfoNJVk3HTlGvfxggQeMnAXtJ/1v/few1iy+DnPhU
         jFgg8j9PADvmN7MuZOBisrlgqMUBq6QaFZkIVIDkzOE3K8d/HrCD+3+rs0bJueXlM9uG
         2QE5TZPEuhV0OqRF7uXhws7WWs9LvX5xFBG26w36qtpEGtlkmDQVoEIsroJCWwgaXIOp
         vL2m6B+GfWJo9hUY0G8bhbpoV2gMLBJaVa16WAJy9fnFhq+AT86UY8z0Nddn/QLHaW4G
         meGWQ62qPGhDtYJrspwvdLnpbeg3vMDAAjbs40ox4U/EkvOgByNAdaab7hCDlnTIm2RW
         Th0Q==
X-Forwarded-Encrypted: i=1; AL+hErFmER9zPT1XQobWAj9JHCLwvxGpI2Xm5U6aVqamte8Z7/DY6UOX+zl708KhtH4pOBZz0rTqpBLg1yVeAWYd5MQvwpTkAQ4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/+7jwtqyKEBhYxuN/M6nWf9qSpKPGlmBrI1OCyps5LZuhosEf/
	gm4jnbL4Ewll9/Akjo+oZsp2rDdeicKHqBw7Sl2dRly14WYWvcDCUAQJYZzkxM2SrGBrcIjZJT7
	A7H25c8kUq5df3PBnSOJ23raj2sZuNwPAEKVD
X-Gm-Gg: AZFdTZf5wH8ylNv5JKpsKvggiMY8qI2w3PDCV4+B2UreryWMH1MIq+UgMXObh8Hl1vl
	Xxv3HYDJuDZJHjlHZvL745DifoiqymHZ/i4YUf/n1EKJFyW0v6fovNd/213Kk5O/x9mkFIAAh/X
	L59gKkQjTV+/9UVaqpH6GZICSffPR2oyMgynJo1pRrrFheDGhi40TrVa1pVLzAiE6Ijq/HuXR/p
	ZwwRqSlh93GNJztLm7NpIH01tFdAB0+ejdiZScZwr/hx9UvsqXLlfqbE9tNefL5zS5ft7I/vRmA
	VLCPutFpaBd4hsDT4Iu6w1BdmYT+xreygkUga01eskECfIb2N8W4Uy7nUga/UmqEIs6IuqxaUcc
	CJxg1LbFSf5pHGH5WmoYSo32rgHtzkxpbBkSHFjg2YAVnE0g9Ur0ZV5nR2y4IKhRSEivU1YN/PX
	BTGUBqr93HancETmBrJjf1kWDNxUhf168Ygw==
X-Received: by 2002:adf:e010:0:20b0:4a8:647c:f965 with SMTP id
 ffacd0b85a97d-4abb348dae1mr205469f8f.41.1795111104076; Thu, 19 Nov 2026
 09:58:24 -0800 (PST)
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
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 19 Nov 2026 09:58:12 -0800
X-Gm-Features: Aa3M54px5BqoBHIu0T3IW_WGJ1h2ACQTKlGPoaDQlVnbwzNn0EkGy5HFiAACHIU
Message-ID: <CAEf4BzYNo54oz12C+s51KG5yWozDHGsQHYqdqHfqpSJ8=QPmyQ@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: roblabla <linux@roblab.la>, Paul Moore <paul@paul-moore.com>, 
	Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 17, 2026 at 4:52=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
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

it's an interesting idea, we discussed this internally, needs a bit
more iteration and making sure that it will work reliably (e.g.,
accessing program's context through CO-RE relocatable accesses is not
guaranteed to work, and that depends on compiler decisions, so we need
to make sure we can guarantee this works). Ihor is going to
investigate this more thoroughly.

one slightly different take on this idea would be to have
pre-generated structs like bpf_func_args___deny_create in above
example in vmlinux.h by bpftool, so that users don't have to use yet
another magic BPF_PROG_ARGS macro and repeat kernel-side function
argument types and names. Instead all this can be (hopefully) just
provided by vmlinux.h so users just do

int my_prog(struct bpf_func_args___deny_create *ctx) {
    const struct mnt_idmap *idmap =3D NULL;

    if (bpf_core_field_exists(ctx, idmap))
        idmap =3D ctx->idmap;

    /* use ctx->dentry unconditionally */
    ...
}

something to consider as an alternative, perhaps (still there is that
relocatable access to ctx issue that we need to figure out)

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

+1

>
> >
> > Thanks,
> > roblabla
>
