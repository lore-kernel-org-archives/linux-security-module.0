Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFEE3DD847
	for <linux-security-module@vger.kernel.org>; Tue, 15 Sep 2026 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494305; cv=pass; b=f8PS11uz1bPY7Avz7aE6TlHLJbJCD+UgEejk5OKodQLu0H8cEwdXkmW2+9m0Ilzlkn4nzOm4pUIls67FZTcOJFOOQRvb/okqsFSxH0j4nCkRNjh6TPIhHOoH3LhDI/v3VH+Wqst5kYpGkmxi7udE3T9MPJUFTSul21p2lEEuwgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494305; c=relaxed/simple;
	bh=qLsONXS3rVfAxLm2IhQyHKIDHJvREIlv8BIgfU7zuFc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kryoVTP+MkkysqPNrH32l/lX3TX32gEsG+q2i+LX5bA0jlBbQpwF7vmo3lkoYfdvoc73GXd3xerS5VFpwQj4ytBRL4z6TXHcGHWIppF0zFURX2Q0LrL/z0ou7qxIj5yjuzLt2xY64mE3do6SegCpyl78WXrOx/7uftdQmZfCgX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=adknD9V7; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="adknD9V7"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd84862f2bso6975ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 15 Sep 2026 10:45:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789494302; cv=none;
        d=google.com; s=arc-20260327;
        b=SJqiPbzMtrPxWrNoasX+BMA8TVJgErYau8/1FOUbmtDoi2nnE6A6/PGHB1a0d5qpaq
         fXPeCQWOldI6xbq62mXixgJ69uv23micFzrKtvjbw+RM3auDQdrx+ma9e1JzoEI2dcjz
         KV0vRrmsNe3+optdoysW8Klehiap3Rb42Rm1c06hECva+qyxCa0s1DcDqyEmp7uYtHqL
         agc5Ur/flfjyW/XWrFrxB+kzVTwXWCSoLvS9OGmAFw6KgHThvr5ZwkxdQZSXgSYEhYO+
         t5sjuN9ot4SnWAchE9snBjzzWelaX6Zi7CXgOlhwYK6WEqbhs3PVpgBqeDFWq0AqCHqR
         I8jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xmRfP1DMByF3Rtx2gmf0os+22aeO/oOugKejrIEnKoE=;
        fh=JUhopTssVN568jFhT+RxXxth5zQQiLPrWMOBloa93Wk=;
        b=WvaogrbAESu3pR3EWx78nf3Fs5++hlfKaRwsMiabTPG2dk125Fbr1XruXf9HlbwqSR
         oG2f+1q6Gu5+tGY0H8tGhp9w8HaY0y4hrRfxq2kkwDAFCVrGUF3/W3a13ZEU/RmM/KpM
         rd0REJC95QQr4u61N01HsnJCxV6q4NMYR0P3z5NRgI5p+6105HiTyefj6J1O7XHjUj3c
         8d2ujM2H0zSCGOZJljpvhcYo3y/RJ0Dhbu0gH7NvRrGYh3N5A+ScdyfaqIZBI1IYUCz/
         OIlj/ALJTNxHCvRI3A9k3y/4CgEUhRaereOo7u5sWvdc96O2kjGntB1E+Adq6JNaL49x
         iyRw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789494302; x=1790099102; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xmRfP1DMByF3Rtx2gmf0os+22aeO/oOugKejrIEnKoE=;
        b=adknD9V7jyfpjRwECoSNo/2J63D9lwfwgVKhMURNsK+MXIgq7zUXIcJw8yNWHtFOz/
         8jLS1PjaWnzesfXxKaCKoFVhIRc3Sf386mrhFELwYZ0EGfG/T6KbFhSfphIHQNZT/hxx
         bLyOiHiEHuG/CJxE9YWiZHnWf4yfVAL1j/M39bzKBd1S7b6ZAg+MJ57y93l/UqjXALYC
         MHj6wU0X+2++2m/LbniE/vIZd+6uUPw/lRiRzHl4NCzruJ9l5QnduNUDvZ/5JdzR/zE4
         Nxs09BqJV/Tgr2n5Ilvzacv4mYgHllpxMw56rdBgBUmvIEDv8Y8ebw0gyMaQmXqHBHqO
         3hBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789494302; x=1790099102;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xmRfP1DMByF3Rtx2gmf0os+22aeO/oOugKejrIEnKoE=;
        b=kaTo3LyIm1Vg2Sbibpun/E/QTRygLp/9FM+xVLmJxU9S/ME010Ck29OYko318UEYRE
         JeURRIX8iQNUbfNRatFeQl5o5qxJdlkr3cxkS/HG/t2QPBKjJ+i2K0Uwth9ZVtiOGRfE
         RJKFYHatnYbFX47hWuo1fVDPdrI14O9tJGhoGClQv29T9rPryX72fQkfqFeB+WzOl8f2
         4vQ3kp0krAmYEn67mspHavzj/a4WBLg+QPK+L9jVT9JAGPKJ81/FOdD+HU85HwD1uP9P
         vecfKpyxSvb+BZ4sV2RWQh5Dw+TWvXLDFjH/lBbWW73vAA/0PzoJOVBzj4KSU3IV+XUV
         FM4Q==
X-Forwarded-Encrypted: i=1; AKwUvBxV6er2zP1UUEm4xmtnYG7gOu9dvGTZoNV3H4FkZ+E6LVWtflG8vcJYSytadFhPGkZsc1fuVzRycwNsoAyMcmU7YvYf3Rw=@vger.kernel.org
X-Gm-Message-State: AFuF++mC5xovrSiMbl82pjpKJXheiuHWcUQiSao7pRFhpfPzPiBqibZ6
	JtmtD2MKcgcFaITUuVEBidMTlColCtkwHPC4OWrDszvBfNR6WYJUELAGkmlALnI1krKhOVRVUTs
	qWVk7hzayVmckZvFQc/+zdwItzuh9rG9FylZIepxP
X-Gm-Gg: AYBFou10lk8T321h7lp6Vv/E/+89i7pUcSvJdMkBc+8cPoQvzFr+tzQCpNMGwSklJ3W
	ZBaizxFHo38OHgov95R1BB+ZE8CEiAdR3Ni06lAQkytLExBOU45EZEnOVidR/0GBVER0rOkRi8G
	2yg0UWl3LsoT/BW7rZJVyTrNYl8lwGe040vpyctj/Zc+I4635UZTocetmk/DD09cGC9yhZ9+oSF
	WbDXlB68Afmb62GqEptMrIBb7x/85Vsmfc8Dj7bSt7ddaSI6hpayLbnH08y7BAj4iVhxbvpphh8
	YBkQla5ICllM5P+/dQfU4HtYnGpA7JQpT5y0NGsAXwHjwNPbOGMIgDFSK2gdaQTpFIk46B1QBCs
	7nmyoKh4h7HGY3Jl4e8SVOeIRy01bSpJkqGS0TRZn1A==
X-Received: by 2002:a17:902:e948:b0:2dd:3a08:d47b with SMTP id
 d9443c01a7336-2dd89d9ed00mr120845ad.13.1789494301281; Tue, 15 Sep 2026
 10:45:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260907-selinux-pokemem-v3-0-0bafbaeafe50@google.com>
 <20260907-selinux-pokemem-v3-2-0bafbaeafe50@google.com> <aql6gyQJoxEjx0xY@shallyn-amd>
In-Reply-To: <aql6gyQJoxEjx0xY@shallyn-amd>
From: Jann Horn <jannh@google.com>
Date: Tue, 15 Sep 2026 19:44:23 +0200
X-Gm-Features: AcwNN1XRdfxLKSy49OGqywbafRdvs8vOvOcncc58q2Uu2XpqGH8ksJIePZ107Ts
Message-ID: <CAG48ez3THXFA=jF_R-wRNsEA=BfD8X1=pHm7dtVnbOto+rXW3w@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: "Serge Hallyn (AMD)" <sergeh@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 15, 2026 at 7:04=E2=80=AFPM Serge Hallyn (AMD) <sergeh@kernel.o=
rg> wrote:
> On Mon, Sep 07, 2026 at 11:00:17PM +0200, Jann Horn wrote:
> > +/**
> > + * security_mem_foll_force() - Check if FOLL_FORCE is allowed
> > + * @subject: credentials using which /proc/$pid/mem was opened
> > + * @opened_by_owner: whether checks on open() were bypassed because th=
e opener
> > + *                   has the same MM as the target
> > + *
> > + * Check if FOLL_FORCE is allowed for accessing process memory through
> > + * /proc/$pid/mem. opened_by_owner signals whether the opener's MM was=
 the same
> > + * as the target MM, meaning the security_ptrace_access_check() hook w=
as
> > + * bypassed on open().
> > + * (Current current->mm does not matter for this; for example, if writ=
e() is
> > + * called on an FD that was received from another process which obtain=
ed it with
> > + * open("/proc/self/mem"), @opened_by_owner is still true.)
> > + *
> > + * Note that this hook is only designed to be useful in the opened_by_=
owner
> > + * case, where the subject credentials effectively also describe the o=
bject.
>
> Given this, would it make more sense to call the hook something
> like `security_mem_foll_force_self()` and only call it in the
> opened_by_owner=3D=3Dtrue case?
>
> I only suggest it because it seems to lower the cognitive load
> when looking at this code, so it might make it easier to maintain.

I agree with you, and that is what I did in the previous versions. :P

But given that two relevant maintainers disagreed with me, I changed
it in this version.
