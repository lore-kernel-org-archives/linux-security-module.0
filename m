Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D431346794
	for <linux-security-module@vger.kernel.org>; Tue, 21 Oct 2025 16:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761063790; cv=none; b=hxKsafW4v0AGYfUGUzPysRNvtrn/GEXRvDrUwo0cYZVPUI9vPNFYhY6VtCGjih8HKWUio/EmSdujwvTrDJQjIapEnXqJx+mmZPY/NGhaqnLwBEH5djlLpEMXMRp9sem8oSzVF9GTya04liCVO/+5uOv+dxB1B7QT/IVk7isBq9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761063790; c=relaxed/simple;
	bh=ioFG2QaGQxwz5gnpyd7wKdUTHVMhLAfWcPTQKhiPDj8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfvmpX2YktuJ0Qc1ayPms5sr2PjsxRcu1l2nUt1nAvpkqSe+qBGrnOKdsdq5KEJyPhQlX852sHNYgrKg0Goa64ONub5h4jaTc3idmZm2XxbmFdXsFdtmCrxYEq5Bo6ZVl1SH3O8eCb2CcncInhDs2REjYgSpASWUWKvTztkmlbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=PIzC92+N; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="PIzC92+N"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33bbc4e81dfso5900848a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 Oct 2025 09:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761063788; x=1761668588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ko+Kc8EOpLWbTMFL12IdldJO27v4hHa56bAgcQaqoNs=;
        b=PIzC92+NAcRrYYvOCcZ5zh179YtDgPKe7MKBk7CoapOyIg4BBBAzBlR/LJlFyxb0Mq
         nYW5837NRRpXxTIEPbJBngIrWSHtNcWwYBsYWunuEGNLgJfHzqdaVv9qqb+45pnLxCNi
         K26JiyGTv6humd543ucN0thQnxaZ0r1MhKH+BLqmJ9T8jFVofv3yRPprn4pYc4sBAQKw
         NcREaUPtuPZnWOibV/FM3XuFU7NSwPs2xlt1D33o0ahRZGhz8wJtmPrAGh5KTzAmeSet
         RUkEdZkCrhKSYYxr4AOckza20b52/4uJqoj5kV+AKl3a1l2vSM3wqZ1YyxChjjT5Cdpm
         4NuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761063788; x=1761668588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ko+Kc8EOpLWbTMFL12IdldJO27v4hHa56bAgcQaqoNs=;
        b=iuhlT4TP1jR4aruUuz8r6PCuCv4mY3csisUQSq08NxBBfQSbaaN+JSm0bcySKq2dGl
         ssn56CXpdoX8qgMLjyMLCh625uwCytJihpwD89GBX/lWn1qpyDFymmDYejjsr6eZqq9h
         tblnTjNiFZdVqVeIA/zKs2etnQYpb2/s7/kBzMSOGkjISwEc0Ua3AySr6hSmz1MZ7GFn
         Ubd9Y6OHrFHbB42VDaJGcAzvrHyeZ0xIUVLFLqoYTlFyLsL+kFLw+Pl+FTuSXZDZQsqF
         P1xhByAtZprN63tjZXeKQ2Hli55dpiK54DcDmIxdnWL6ddtN1mzIoCjpAHNEOAaFYxk7
         KwDA==
X-Forwarded-Encrypted: i=1; AJvYcCVlfpXkRAIWBIc03c8Yz/eiJBUpzvc9N+mdVl9ykP2ytnQOJ+xJHufF4jNBlgY8KgWjJMdc4nK4gtrP+xuN3TdcPwjGn3E=@vger.kernel.org
X-Gm-Message-State: AOJu0YxR5+swiZs1SlbyH6h1s8Wk+6BXegn9GDXQv0+X3F94rZE5Bcba
	Yzg3T2YRDxp8Qn0u3dtO14UrHdI6uf2JOJiEMS42gEJzqAeNZsutuUlqeqAzSX0gs6SSLeFch3V
	9EZ4NJPWS3D0JHRgT2fDW9zEe343zqmYm/s2HY24n
X-Gm-Gg: ASbGncvjr4wuYzirDrSGvwHhziEvIEoc8nNTYdqlkWM0KwVTVX/TFrQYXEaMMmqpXYt
	B9kuj8B8wQnmmr1Sec0zPkB+oONy//23vc+hzhdPjTiU5i5RLlC1OKls4n95BkhDbu2mcsfcjRQ
	XClz0XhDTlFeBRYzLs8QsqNgp167siLg+n/7MKZ51FQNTEZJ9v9uvsvt2EWcl8ETlUiH5xP4amq
	RuxoNuoqEd4186Lgrk54boTLWYpDEfbqljaLZpL0eyiqOFPDJvAjCePjskidcwLxwkeBCE=
X-Google-Smtp-Source: AGHT+IGt4Lzi4mhp1MfH5jF+IcHXWUOccQlOFd9tFKs5S9MlSna+BmR7SWJIKFfxQoQ0qSxgAqL9kA7McL4N2dVYx68=
X-Received: by 2002:a17:90b:180e:b0:32e:73fd:81a3 with SMTP id
 98e67ed59e1d1-33bcf93dfbdmr27922336a91.33.1761063787525; Tue, 21 Oct 2025
 09:23:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251021122758.2659513-1-omosnace@redhat.com>
In-Reply-To: <20251021122758.2659513-1-omosnace@redhat.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Oct 2025 12:22:56 -0400
X-Gm-Features: AS18NWB5lQV6vOb0FNBV3MhIGbNUH6yZO81tIZnwRE8GRrrg4_dPsp5GczFYtAw
Message-ID: <CAHC9VhTf51hZ=r=hNpeHGU3FBAC-Y3yB6FmsQq_hKq4WUihRBQ@mail.gmail.com>
Subject: Re: [PATCH v2] x86/bpf: do not audit capability check in do_jit()
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org, 
	selinux@vger.kernel.org, linux-security-module@vger.kernel.org, 
	"Serge E . Hallyn" <serge@hallyn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:28=E2=80=AFAM Ondrej Mosnacek <omosnace@redhat.co=
m> wrote:
>
> The failure of this check only results in a security mitigation being
> applied, slightly affecting performance of the compiled BPF program. It
> doesn't result in a failed syscall, an thus auditing a failed LSM
> permission check for it is unwanted. For example with SELinux, it causes
> a denial to be reported for confined processes running as root, which
> tends to be flagged as a problem to be fixed in the policy. Yet
> dontauditing or allowing CAP_SYS_ADMIN to the domain may not be
> desirable, as it would allow/silence also other checks - either going
> against the principle of least privilege or making debugging potentially
> harder.
>
> Fix it by changing it from capable() to ns_capable_noaudit(), which
> instructs the LSMs to not audit the resulting denials.
>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=3D2369326
> Fixes: d4e89d212d40 ("x86/bpf: Call branch history clearing sequence on e=
xit")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>
> v1: https://lore.kernel.org/selinux/20250806143105.915748-1-omosnace@redh=
at.com/
> Changes in v2:
>  - just silence the audit records instead of switching to bpf_capable()
>
>  arch/x86/net/bpf_jit_comp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
