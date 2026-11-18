Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.2
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794963165;
	b=21s6KPRfyFsY/f0JINdrpe9S20zT0jwui8HLwIULYhgsihYm+sohAtjT+e5Br7WFXJ8O
	 Q/rdFG5vgCbBAKJjMxeNTmN5uBLp//UOkc3AdJxvuhNdkUzdCzkRygDJ7ueX8sQ+r5ZSm
	 3pfMy8TeUxHb5uRBMn8IRCyxPfXbXZBRLV2N4zQdK6VMBEt9z1rJT7clR97iEZlmMIjcq
	 RHX3fyFoR8KNGW+utLfNS3qHlkKjY+UwdWMW2cuyySy768zrpbnrzihnsjOJHEod2h60L
	 j5Ts1AdE+XIAWbjrV2BoHstsl2eHZx5YY9g7C2L6RjebMetSXQoO0qBrrKxGbTYsUZQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794963165;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=u4E0fQhmGCeFsbiKHI/HoTeHZ7lq7KvgeuRTX4/oJSY=;
	b=ZYnnEGRDuLeLDxfQNJFTimQ/utzzz6/RCdUl6VNElOfuzhEMeQiTE2Gh8HNpcu1RwXPf
	 RvVRzKp9vyWRurj8YBpkMO+13VIRvvFWQpGl/XrsTX4n8t26Jg5kLgxawlr8epEChz9n9
	 +x1/tx2nXRLwEvDGXX6VOmxzqrBTGMc3sGO0DxTWsn2C7Z4ippCPrtxxb77WliS6Hp0gV
	 Po7tBASF865L0p3dH/31NI1Ob44FppP6EGvdYHb74WyerkRj+D/lGgOmqAB+fQL41W9Kv
	 hvQ9ixSDqQdjFKq9Nxi+oi4YOWa2LGRn5atbOqlFH7fcXSapsP2r3ISDfTghStFVt/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tOC4QT1z;
	arc=none smtp.remote-ip=95.215.58.2
Received: from mta1.migadu.com (out-2.mta1.migadu.com [95.215.58.2])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBFB606A32A
	for <linux-security-module@vger.kernel.org>; Wed, 18 Nov 2026 00:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CBFB606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=tOC4QT1z
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jAcKC7XNRVh0GKcOuxn1Fu7bTvbspwLeOY4x6dh/4d4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794963163; v=1; x=1795567963;
 b=tOC4QT1z8jK2RG9eRb9Ibc70UQ38UNsYD2ncTafZVocMYFKDQVVZNcRrCtZZKGBpBINLUGu7
 sxYkJz9l3DHtZCWCh21VQCm8Li49LLHKQyfcMt4DdyxpbyjW+1m4WR33PNKshm6SKBAermUeaF7
 hMX6Akw9TjYfKdGzJwO20LPo=
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id c0217c32623d0320;
	Wed, 18 Nov 2026 00:52:42 +0000
X-Mizu-Trace-ID: c0217c32623d0320
X-Migadu-Flow: FLOW_OUT
Message-ID: <9695ec3d-7b81-488d-989f-0bd411d673f2@linux.dev>
Date: Tue, 17 Nov 2026 17:52:38 -0700
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: roblabla <linux@roblab.la>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Paul Moore <paul@paul-moore.com>, Daan De Meyer <daan@amutable.com>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org,
 paul.mabileau@harfanglab.fr, linux-kernel@vger.kernel.org,
 Andrii Nakryiko <andrii@kernel.org>
References: <d85ece6e-27f9-4d9f-83af-4101bc76fef6@app.fastmail.com>
 <356db94e-f5d6-4fb2-839a-b97aef72256b@app.fastmail.com>
 <CAHC9VhR9sjunJRnM9gy-BkBZkapQTrr8a8FtmaK7JkAmUqTrLA@mail.gmail.com>
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com>
 <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com>
Content-Language: en-US
From: Ihor Solodrai <ihor.solodrai@linux.dev>
In-Reply-To: <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/9/26 8:07 AM, roblabla wrote:
> Hi,
> 
> Thanks for the replies!
> 
>> [...]
> 
> So what would be really nice is a way to make eBPF code robust against
> kernel changes such that it either works, or fails to load, but doesn't
> do the halfway "loads but silently misbehaves". Here are two ideas that
> have been in the back of my mind that could help solve this issue (though
> I understand that they may be rather large changes, I'm putting them out
> there mostly as a conversation starter):
> 
> 1. Could libbpf/the kernel have a mismatch check on hook arguments? I
>    understand that libbpf and the verifier don't know the types a
>    program expects, since BPF_PROG() only casts u64s. But the macro
>    does know the types at compile time. Could it (or an opt-in variant)
>    record the expected prototype in the program's BTF, so that libbpf
>    can compare it against the LSM hook's prototype in vmlinux BTF and
>    refuse to load on a mismatch?
> 
> 2. Since kernel BTF has parameter names for the bpf_lsm_* functions,
>    could we maybe have CO-RE-style relocation to resolve "the argument
>    named dentry" to the argument index at load time? This way, adding a
>    new argument could happen anywhere in the argument list without
>    breaking eBPFs, and removing an argument will (correctly) cause our
>    eBPF to stop loading. It does mean the eBPF programs must provide the
>    same argument names, but maybe that's an acceptable tradeoff?

Hi everyone.

roblabla's comments got me curious, and I spent some time with my
helpful assistants poking at the problem.

There is another workaround in addition to what Andrii suggested.
A program can already make itself fail to load on a signature
mismatch:

	union security_list_options___mine {
		int (*inode_create)(struct inode *dir,
				    struct dentry *dentry, umode_t mode);
	};

	extern void lsm_proto_mismatch__inode_create(void) __ksym __weak;

	SEC("lsm/inode_create")
	int BPF_PROG(deny_create, struct inode *dir, struct dentry *dentry)
	{
		if (!bpf_core_type_matches(union security_list_options___mine))
			lsm_proto_mismatch__inode_create();
		...
	}

bpf_core_type_matches() checks the expected prototype against the
hook's member of union security_list_options in kernel BTF.
On a mismatch the call to the unresolved weak kfunc stays reachable,
so the verifier rejects the program, and libbpf reports:

  kfunc 'lsm_proto_mismatch__inode_create' is referenced but wasn't resolved

It's positional and needs the exact argument count, but it turns
silent misbehavior into a load failure. The same should work for
tp_btf with the btf_trace_<tp> typedefs.

But of course it's just a workaround..

A bit more generally, expanding on roblabla's second idea, I think libbpf
could resolve hook arguments by name with the existing CO-RE machinery,
without kernel, verifier or LSM changes.

The BPF side could look like this:

	SEC("lsm/inode_create")
	int BPF_PROG_ARGS(deny_create, struct inode *, dir,
			  struct dentry *, dentry)
	{ ... }

BPF_PROG_ARGS() (name TBD) takes (type, name) pairs like BPF_PROG2(),
but instead of casting ctx[0], ctx[1], ... it reads each argument
through a local preserve_access_index-marked struct, so every argument
access is a regular CO-RE field relocation:

	struct bpf_func_args___deny_create {
		const struct mnt_idmap *idmap;	/* 7.4+ */
		struct inode *dir;
		struct dentry *dentry;
	} __attribute__((preserve_access_index));

	SEC("lsm/inode_create")
	int deny_create(u64 *ctx)
	{
		struct bpf_func_args___deny_create *args = (void *)ctx;

		if (bpf_core_field_exists(args->idmap))
			/* use args->idmap */;

		return check(args->dir, args->dentry);
	}

Nothing changes on the loader side:

	skel = deny_create__open_and_load();
	if (!skel)	/* mismatch: load fails, libbpf logs why */
		return -errno;
	err = deny_create__attach(skel);

To achieve this libbpf would need to do the following at load time:

  - treat bpf_func_args___* as a reserved type in CO-RE relocations;
  - find the program's attach target in kernel (or module) BTF:
    bpf_lsm_<hook>, the fentry/fexit target, or the tracepoint stub for
    tp_btf;
  - build a struct from the target's prototype: one member per
    parameter, named after it, at the parameter's ctx offset, plus 'ret'
    for fexit, fmod_ret and LSM;
  - resolve the relocations against it by name, with a strict type check
    (pointee types must match, qualifiers ignored), since CO-RE normally
    treats any two pointers as compatible.

A missing argument or a type mismatch is a normal CO-RE relocation
failure: the program fails to load with an error naming the argument,
unless the access is guarded by bpf_core_field_exists().

And this is not LSM specific, fentry/fexit/fmod_ret and tp_btf would
work the same way.

It doesn't help if a hook keeps its signature but changes semantics,
or if the attach point goes away (that already fails to attach).

Here is a vibe-coded prototype of the above:
https://github.com/kernel-patches/bpf/compare/bpf-next_base...theihor:bpf:bpf-named-args

It's an entirely new libbpf feature though.

Andrii, what do you think of it?

---

And just my 2c re argument ordering:

Paul, with all due respect, prioritizing code style and personal
preferences over backwards compatibility is unreasonable even for
unimportant applications. And here we are talking about apps
implementing security policies, which many organizations (not just
companies) in the world rely on. Given the recent flood of
cybersecurity issues (in Linux and beyond), I don't see why would we,
as in kernel devs, intentionally make the defenders' job harder.


> 
> Thanks,
> roblabla

