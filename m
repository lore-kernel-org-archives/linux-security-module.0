Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794524445;
	b=JvfJm2Cxtw7QwCi9zF23PCg2+0PmIePRwrACFwvlMOZdVC/m6H+whLa0B9urDV44P7pB
	 41enj8PJ19HhWfhM8z4x7fB3JwddorYLbTHIf8pj1x7+W+ov/qLO15inN2ffKnvzzmbf8
	 rOGfRFXiIn0h9rwno4OM6El3uf0jyiFXn5zTbsscr8hZHrmjd60Nb2hcAhfFXL2eKVn+F
	 e62bqbkEckB3J+jeb6CVqH5CbujOGoHV0Bn9DrDl9ZmgzXkPhO3kBQ1EEN4r+PQf0jj1I
	 /llhe7p9sOvKpxdN2JencfBdfNafccklGvPuSQ7NZsa6vss5z8zYuwDNk+9iXHcw7qA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794524445;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=zJauvZE1zf4JwsOOkP65TpK/2FnkZR8UcBkJu4VCs5g=;
	b=qnWln3Kx2ab94EPsWUcQB7zrZXroDsaJx+DOyy7H4DITQBcrfj8XM0feMN4ou0ECweBQ
	 DrNrtgRSQ4bK1D0OfL+gpjviIgPqrG2bArJK5s5lubIeYKQsmgPjxOCqaB3C5T7Q6/h8+
	 6v9L6RDvls+ipomp3esLt7Q9q/J9QYJaXugTGrMwOE7RkeOibXriboGpSZ1EpUNYcbjzV
	 mpBcpUcNAvw3q+Ch7FiZvuGYzMemGNnZnEbUHXK4vWI3836LTJKRzSfoD7ln5YPEn0PYA
	 E2jKuq/I2blXaT/g+8kfoCZr4V3buXopKc4R4UkcNlxKaIoKaCKOPJGpudLnE1Okb/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sjDNXoB6;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BA5606A887
	for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 23:00:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 22BA5606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sjDNXoB6
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-4919a880834so139109f8f.0
        for <linux-security-module@vger.kernel.org>; Thu, 12 Nov 2026 15:00:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794524443; cv=none;
        d=google.com; s=arc-20260327;
        b=A0NhDB8uN+a7f0IhL8lD82KbX//gmdPP/v8nRUx7EwJC5BzBKrk6vCbXoCXsjczhiD
         9RxR6F2C3frxid65e1Ym6p0727L+07xw1q6LBVcXG22p3WqLI5QfNW6NNhGO/1SshpO7
         Kbo8toNeYPcletLPmvnNhOQHe9GYePqhSB7fXvzpt5J6t9PZYMI+366A80Dzi/Z4fLcm
         EIckEx+wSOPWNjSBXIrNa3xowRw9BfCRQGzpSqg4GVfbvAgmOuVnhkizmX5WiOFdu2Nc
         +EhCxrb1EOAQxM2xpilVQGV7+7RuNxEI9x5WwTNVLNwEdP5h/uBS9548MNpxrCAKl1x1
         D1EQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zJauvZE1zf4JwsOOkP65TpK/2FnkZR8UcBkJu4VCs5g=;
        fh=3XVRsAIqSCi6RApF6wPoymWBL7SzFFY6Nkm4TrL541U=;
        b=l63OIbNZUwa4Ua9cu+3vKHlk0YPURAEHvixNbrAMxcLw59vFxqwKIuUkWPJV4QB7PE
         HrWXrf7ljC+1Wks3Bo1h8GVAdpNY0BeKGYvAKePpwaPEQJt65WRodyX0nePbFqJKGnhh
         sNKQft8NBYiT+gwe8Ja7Ca7s6YGNg2t6yoSoyL6Za/HDuzJjngy0Vc6pruQMsBrMiVUj
         vaKD9Eodory0CKVMdvW550BQ/YKUNL+Q47jZn/aYO4SabrX+YQy54NrwlGudHXXT8wQE
         Z/yzcFEoldCCFMHTo49KiTtPiAo6oPBQtIR2rEfuxHDIwCz+xypbr0MabkeiskveTkfq
         MKcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794524443; x=1795129243; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zJauvZE1zf4JwsOOkP65TpK/2FnkZR8UcBkJu4VCs5g=;
        b=sjDNXoB6zcBiHEPu0PrEs2iYorJls7T5etmbz/NfEcTCj55pFun2I3zOD+NvijjUFq
         D8yiW6Uiq2zT4drRfzL9g5WwSV4ljjPc29uE6wvdNUnHImRqP16nNPnTPWyBCkQzNLHV
         q5PDapA0AchXZA16ia4F+ggMZ2/zrtRRYTKgp9xjWIRjxGMGoi7faYMHEmlYnUi3aIXa
         9VxSOqG1BBDzjKyfVJz5o0RTpyFmjH2JMc1a+HIKFSXSXOvPNDQlDazqg0WXpcHJBQhO
         lhWT9ZptbmEspFpTbPm/7iixxbpoXNroTtUoAf3riQTFMIPr1RwbRNSRLOrkDGXrAmiT
         onpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794524443; x=1795129243;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zJauvZE1zf4JwsOOkP65TpK/2FnkZR8UcBkJu4VCs5g=;
        b=kc2hckkGEx7DhGJqJ2Hw5Fm8jlOjo3bqORwZqNMiBYpp3yZEq2B5+DkxCA1vIaSnaY
         g3WozB+KYjvxe/caRSuUJpFkXhNIlfVjbVJzj2ClRvVlRWCOni+V9AwMfXaARWfHkdzs
         Q1PWcg2wxrciOBbOdkqQOo/Ryb91Iq+D9bKDGJYeFCsqRhJJTBr2INOLETGa+fv/vQLR
         wWKGYJEw2mJT19kly5WREbVEbTk6Kvd6U/n7tcvMXi8BWgjhGiMsKoW0cZEqNSYH5ReW
         ur/Pz2Bfbhr+pyTv+WMkvwIaqUZc6WYOhODNcCmlEQ6GTkW0AoNPibDr4pLcd4blPXpo
         5S6A==
X-Forwarded-Encrypted: i=1; AL+hErE+/KGR1GPhP44tGYGrGmVjpg86qZps/sMOMuqkjwPHSnYUgh+sV9b9SPg9vMn3yMj8r9vEUXAPskBjoaBjyKBhuyQP7j8=@vger.kernel.org
X-Gm-Message-State: APuU4Z8L4Vx7GDlaenk6iKZ3kqzD66a1H8nUVK77Wk0H5hiw/56Htiu1
	GQ4mSEX5yqxL21xLO0jZaEEN2zSxR3MhWD0Yd1Pf9iWm1BjeGk688stIBsXi7WueiO2rFdzOPR+
	v2DMN/6fvJvygA+XyBBz5m4/JypFEG3k=
X-Gm-Gg: AYBFou2fKBit+Jv/oFvBHmrU3v81OqIq9/UQ7o/lfURc5tmfSPOuaRsotpn8e/4irSW
	PYiCLGdpxccKWyuagDcPpWW9JgO3FjS5pza0SVH+kM2q8I0U1wY4V8vUeSohOORts4yyF1csCI1
	1nCKvbNNvMgnGBuceCu5D8+wnVYfWR0NFG/oBknQLmAyKj5M6dr3IVAzevkhYX7gzTF2fFyT0Xa
	eTmN2+n26wdQzidnHGX6bRR/In7JFeXDgg7faCiBDEdUSXGGc/br4SuvOI+8/Kaa7//RQyqkblK
	k0uR10hBLeSze8OEy0+e9x1IMYkIVeCuwk4ZlsCwA+Fa4nAv8ahNzIi1NCDxJ43gwY4zZgdr7ZF
	teSlT6AYVukEGVbDOgtV+XSvepJovWHzd1SAHHbUlEDPstavWhseSwqVYuEA1dte4pU3k9MVBDq
	ystZQUt/wxxQOUFJVtLZ6XC1hkMqRH+HdtbtnI97Uyr7Q12/J474jAVSUa
X-Received: by 2002:a05:6000:4916:b0:48e:4300:c6d8 with SMTP id
 ffacd0b85a97d-49c723fc072mr1488764f8f.35.1794524443278; Thu, 12 Nov 2026
 15:00:43 -0800 (PST)
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
 <CAEf4BzZKmn6g0SK8OddjKFj_vAmZFvpZv32Hs_S+GHgT7VNfrg@mail.gmail.com> <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com>
In-Reply-To: <9d6bdc31-e57c-4187-be78-29d82471f710@app.fastmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 12 Nov 2026 15:00:32 -0800
X-Gm-Features: AclHuK-Kr9JdTGalkEgmmfAfdsFcOEOJ-nbAKjHr2jm9SnDPJTrEN9CPnUV0p4o
Message-ID: <CAEf4Bzb+oYDqO20v4YbJ45wdtcGgJT3xVse822P+=oA7fpFAOA@mail.gmail.com>
Subject: Re: [BUG] bpf, lsm: new first argument in 7.4 inode hooks silently
 breaks BPF LSMs
To: roblabla <linux@roblab.la>
Cc: Paul Moore <paul@paul-moore.com>, Daan De Meyer <daan@amutable.com>, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul.mabileau@harfanglab.fr, 
	linux-kernel@vger.kernel.org, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 9, 2026 at 7:08=E2=80=AFAM roblabla <linux@roblab.la> wrote:
>
> Hi,
>
> Thanks for the replies!
>
> > LSMs that need to provide a stable API must provide an abstraction
> > layer between the LSM hook callbacks and their stable API.  The LSM
> > framework is not responsible for the stability of individual LSM APIs.
>
> Understood, that lines up with my expectations. I think the biggest
> thing here would not necessarily be stability guarantees, but rather to
> make sure that the eBPFs fail to load when the compatibility is broken.
> But that's probably a problem for the eBPF side, and not LSM, I assume.
>
> > So, in short, would it be possible to send a follow up to Daan's
> > commit and move `struct mnt_idmap *idmap` to the end of LSM argument
> > list?
>
> If this is possible, that'd be nice so that we avoid this breakage in
> the short term, since the change isn't in a released kernel yet.

can you please send a patch proposing that and we can continue
discussion there? please cc me so I can follow along

>
> > Having said that, there is a way to handle this, although ugly and
> > *everyone* using specific LSMs would need to do this on their own.
> > Instead of using convenience BPF_PROG() macro to define BPF program,
> > you just use raw `u64 ctx[]` access, and then cast ctx[0] to either
> > `struct mnt_idmap *` on new kernel, or `struct dentry *` on old
> > kernel.
>
> So, we already do similar tricks in the software we ship (which uses
> various eBPF program types, not just LSM) to cover kernels 4.11 to 7.3,
> using a mixture of CO-RE tricks similar to what you describe and
> per-kernel builds selected at runtime.
>
> Here's the problem though: We ship to customers, and we don't control
> when they upgrade their kernel relative to our agent. When the kernel
> changes a hook signature, a program built before we could handle that
> new version still loads fine and just reads the wrong arguments, which
> causes some really gnarly bugs that can cause really bad breakage (such
> as accidentally denying events that should have been allowed, often
> resulting in machines left broken).
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
>

All this is not really an LSM-specific problem, it's a more general
tracing problem. And even if we have some custom hacky "solution" for
LSM specifically (but also see my previous replies, it's not something
that's easy to do either in libbpf nor kernel, IMO), the same problem
is still present for tracepoints, among other use cases.

It basically falls on BPF users to keep track of kernel evolution in
terms of attach points they are depending on. Luckily breakage doesn't
happen often and usually can be worked around or be adopted to. And so
far kernel community has been pretty understanding in terms of
evolution of some pre-existing hooks (like scheduler tracepoint I
mentioned before, and hopefully in this case with new argument moved
to the end of argument list).

> Thanks,
> roblabla
