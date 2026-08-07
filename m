Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD01135C1B0
	for <linux-security-module@vger.kernel.org>; Fri,  7 Aug 2026 20:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786134996; cv=pass; b=bPqnGBwDxrfk5G7Wgxc38IlWiOMLzxI9v49xJhgrKLlgd/Rdqt1b4uIWU6CEtnddgIha9AQPi9UD5qGKuB1EaHjV2eeY7G/JBh3Cztkq2HLxLajaKSUs6oRqAP+EKf08AdPp2OF5WntyO187n2MMDi+1FVQjNeHGHfX56wdpGxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786134996; c=relaxed/simple;
	bh=m/YK82kcESKdILFJlJFUns2fClsu77ujhWQ48l2ndGM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mqyzvN7ECA0SuFy66aTv78vfLhs0+Dyw+ojtSK9OVtp9okXciRdo9jwcw3HfPxyNpKLpKnKIe7hlU3ZsJJs+1Ekxk6pGq0uAHFyP0e/0QWhJLjr5TVaG/eExOfUFnWKc3y+jwtL5NDngcPqtZJf8HIfqlh92HSSdLQq3MjRCB2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=STSraQJ+; arc=pass smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="STSraQJ+"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e58034d05so3461030a91.2
        for <linux-security-module@vger.kernel.org>; Fri, 07 Aug 2026 13:36:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786134994; cv=none;
        d=google.com; s=arc-20260327;
        b=Nxa/8wFVMc7d8eTnWv7oGjWMJNE4suBCVGheN5xVbt1og0GUfoTjRxypVEmrtR2mur
         wxGWPni5EOnlrZqJgujsQp9sKffvT1YmvfrTqPNKCSjKAaA68z+6baAXIWdRgRVEIUBl
         yVL9JKKRuHo18N8rypvCD1tbQBu0GztYL/H8pzsR4GH3axO+IBjnzfAQTtOk9FNrSVW4
         IchgOsdfTACllZiYJQBgzta61gOS9hExErqTqEb9v964jpwHcU0n48Gg9MvhH2AtVye3
         qnW5+CuBz3lgs2Hn4Zt9lfHRNwMAU+gueq/WRJFzVb21fnevWMtgsLMOMSIDzPLZJNOl
         Soxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ochpLTMD032NQhagC0dX/Gh/xAiy43T2kbSx5oTIX+Y=;
        fh=52WWZFrZ1SVGOzZ9v1+X1p5RXvcIO4LflZe+ls/kzjs=;
        b=HA04gHzc8Xb+vIYYwIBfA5c1UyFTglZaOF8pEORruhq4Ct3O3gXXsUNG4wyEoub/NF
         xOWY31bG9LwcldV1mmC00//YgaPpTJv7JZYScKPUScdSVyuqHOn48neGBxTpLfht7AYu
         jcASRuTH9uPkFvrI6pBgRnq1pEysW+gyZ/x0OmHchxcjIHeEIsMNyks5FDktiun7Kkxw
         zQwtu0l0pJVbyTHYHp8EFjaRVxugu1DjEHKqg6AResa8Fqceql0a1qcn3geFn9Q+atno
         Y1dOrA4oX8PolDv0FfirCoQvEdMYnvFD7GyJ4mHJsA+d+jsCQDjeLcSIAfxwUzoeQF00
         43lg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1786134994; x=1786739794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ochpLTMD032NQhagC0dX/Gh/xAiy43T2kbSx5oTIX+Y=;
        b=STSraQJ+cxrlPzbmMadUUMwODnrPv17JJ5MX7yRyYzbK6grx/ws3PG7T1yQNPR5wsB
         RNlSB+uzLssMCHO2Bhf3SW+GeZVBJXMczwM57OCfHt5jefN1SUfudj+8BQi2fK+7GrFB
         xe2mPTbxcICBp5ZGolckxQ7N+Op0XEb7SA6aiuUdtgTWOsUgDm/DFAVYaTjrElLLKW95
         fFexYXCh9azSl6bj3fNg/6Em24/mXYzoGamIlqEJ4u/f8tbcwn0Mbp0xcedUrKOn8eWH
         RvQJPJ/5qlkKa0BJXe4krEi5mClUmOWyj0C1Fyc+jF8FkWy8w8RbfSkQcXmy0ZXsQk1I
         uzjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786134994; x=1786739794;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ochpLTMD032NQhagC0dX/Gh/xAiy43T2kbSx5oTIX+Y=;
        b=BRz/SCoJKm2itft4WPcpXEQZsEoePRa/wD7gfcerlofqmr4va9PDCGA4fzciipt1Gl
         mVANaDJX9ObDC39BK4ShXCify5KJJW4aeZa22Z/3wsP6A7+kn9Dauxc2bGxJ0axykPQx
         upC+WhKVdFmHgWLeGOb6TIc0DjjD5XpAAfDh1CubwPUEkyN2S47BQg7lSLNdH0d/izdo
         TNQOO5kmqCa/03GN6v17jSZYoAtj++wNlPS2gV/Ia5e2adDnnrAk6O/rtKf3omplNKHT
         2A+/syJN9bsYRM1U41dPJIBAVeccirj5fFhqdwXY3ZFILj2GkSISuJxhnsg2Vt1d5iak
         aaJw==
X-Forwarded-Encrypted: i=1; AHgh+RqgXOCchU+qdtifEvCo0B9JxZ2zaY4qZ0MSrOsFrxyZ2O78XX+cUptLm4VNW1jBJYRALhfEx1DVFmZIKp0Zc2PM2DrltXs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyur+8jXHzHECCPJN28r3LPE0uIsyiiofD4VcqZe7A+XLw3r2A/
	vRMBXSZGm669Jl9nMLiRRc+LIfHolWLCPr3jIHaJGwtTI2OH7vBSs8MvfMf64UgY6ZAGReBE23J
	EZilDdmZhZdJwXWk9Q+kSv04AlfrEbQyKFvoWEeXc
X-Gm-Gg: AR+sD12sRux+AUqNIv7S1GlVBGAV9ryxlHWE+EeApv8r6iNj+RsnFS7cK4nQaspWRSK
	qxWdfbrCpdZwL8VdWVRb72UPzOi4n4enOuLxRXcjBhQQuRpfAk532FfebOAFlJmkZJUC0m+AisZ
	hV8wzhSPA5HCmfu3uVDQt4uunzOa12q13LDnYh0NlFUcbtr9QHPNRYkrSnUT1Zj3AJJWu37Olob
	8vrY8Cw8UyNVTYzW9IZWEz/xNYjg7fv1MBEA78uUr56DMUAnGRlhKfioJobpzEd757b+zKU9Nht
	RWXcNCYMpkkSGpdmJVibdfVLzDvkFgLr7iqdAVBGdfyy
X-Received: by 2002:a17:90b:28c3:b0:381:bc4c:da56 with SMTP id
 98e67ed59e1d1-3903c6128c6mr27246576a91.19.1786134994234; Fri, 07 Aug 2026
 13:36:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731022047.189137-1-utilityemal77@gmail.com>
 <CAHC9VhSSzNBCSvy4cQHh6OOM4-EvHF+bmrB9=V1y=Lj53RvxQQ@mail.gmail.com>
 <anOnaGmBTlBW9xwj@zenbox> <CAHC9VhRBYMaNBPfnV=TK8g-M7H_qsBu=CsVVOwnAzTPAkpAZaA@mail.gmail.com>
 <anPAbFzuLOizAhm-@zenbox>
In-Reply-To: <anPAbFzuLOizAhm-@zenbox>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 7 Aug 2026 16:36:20 -0400
X-Gm-Features: AUfX_myucQAgH3RinM6gYViFUKcbyHZCYmjwR4UvYwS_lXRmeABclx6STS4J9IY
Message-ID: <CAHC9VhSJ1q59RUtEEMAmiZLLLi92=XO1tkd9z0fr5T7vuhoy8Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next 00/13] BPF interface for applying Landlock rulesets
To: Justin Suess <utilityemal77@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	kpsingh@kernel.org, mic@digikod.net, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, kees@kernel.org, gnoack@google.com, jack@suse.cz, 
	song@kernel.org, yonghong.song@linux.dev, martin.lau@linux.dev, m@maowtm.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 8:32=E2=80=AFPM Justin Suess <utilityemal77@gmail.co=
m> wrote:
> On Wed, Aug 05, 2026 at 06:51:56PM -0400, Paul Moore wrote:
> > On Wed, Aug 5, 2026 at 5:37=E2=80=AFPM Justin Suess <utilityemal77@gmai=
l.com> wrote:
> > > On Fri, Jul 31, 2026 at 04:30:39PM -0400, Paul Moore wrote:
> > > > On Thu, Jul 30, 2026 at 10:21=E2=80=AFPM Justin Suess <utilityemal7=
7@gmail.com> wrote:
> > > > [...]
> > > > As you may, or may not have seen, there is currently an ongoing deb=
ate
> > > > regarding the location of LSM kfuncs that will impact this patchset=
.
> > > > Sadly, we don't appear to be approaching an agreement on this issue
> > > > which introduces some additional risk to this patchset.  We'll have=
 to
> > > > see how that ends up, but I just wanted you to be aware of the
> > > > situation.
> > >
> > > Quick aside question: Would security/bpf/ be a better place for these
> > > type of kfuncs?
> > >
> > > security/bpf/bpf_lsm_kfuncs.c could be for LSM framework kfuncs,
> > > and each LSM could maintain their own security/bpf/<lsm>_kfuncs.c
> > > for kfuncs dealing with lsm-specific types.
> >
> > This gets back to the other issue in the patchset that we've
> > discussed: general LSM interfaces vs Landlock specific interfaces.
> > There are plenty of reasons why we don't support the kernel calling
> > directly into individual LSMs, and from my perspective this is another
>
> I'm 100% on board with the no calling directly into individual LSMs part.
>
> > instance of that.  Here it just happens to be that the kernel caller
> > was written in BPF and not C (or Rust for that matter).
>
> The intention is the opposite. The point of the separate directory is
> that the kfuncs can never call into an individual LSM, they only get
> the LSM framework API in <linux/security.h>.
>
> Every kfunc is a thin wrapper over the generic policy kptr hooks:
>
>     bpf_landlock_get_ruleset_from_fd()
>       -> security_policy_kptr_from_fd(LSM_ID_LANDLOCK, ...)
>         -> Landlock's hook implementation
>
> So kfunc -> generic lsm hook -> individual LSM, same as any other
> caller in the kernel.

Not exactly.  That "bpf_*landlock*_XXX" kfuncs are a move away from an
LSM agnostic API and not something we currently do in the kernel.
Some will, and have, argued that this is more akin to the Landlock
syscalls, but I see (at least) two problems with that comparison: the
kfuncs being presented aren't syscalls, they are cross-subsystem
kernel function calls; the Landlock syscalls were created in a
different time, today these would need to be reframed as LSM
syscalls*.

(* To be clear, we're not going to remove the Landlock syscalls for
all the obvious reasons, but we're also not going to support APIs like
that unless we have throughly exhausted all other options.)

--=20
paul-moore.com
