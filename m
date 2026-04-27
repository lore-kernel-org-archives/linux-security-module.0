Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3024B35F8D2
	for <linux-security-module@vger.kernel.org>; Mon, 27 Apr 2026 03:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777261385; cv=pass; b=QwXHfL15tQVYBHKous0XnEP5a1NLHOgj/NHSf4/5Q8mI/Qbj9CzYz5e/rokZSQSEEP7PKS78zx3TcKQ3mzYDpAPxdK2uUVdAEGUlnPs+9LuFGX9NWIxEIgscdxg9c1e1b3zuzIjF/PdK42wH70gr2Gk6V7eHF/8Ff7UgUZUj8ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777261385; c=relaxed/simple;
	bh=t7jMQTzH4WvNAPNg0QKfjgjMMI8uJxMDy8LRPrdEgV8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MiKjdqRyUxYHbk0G39yBn9GCRhXHRRzXFQiG3fE8qlhOJ7Z40WNbusUD9fNezauk33S8edRLGx1k8N8fchZdCGc8XsV/eiy3AGvOVOngh3YZBkHCZeFw6kARc1linFjPiDHa+aLx54f29UFCQmbubv8vEyGadoTXHCVG29vJUTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kv56Ns0H; arc=pass smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kv56Ns0H"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8a3342d301aso95969126d6.2
        for <linux-security-module@vger.kernel.org>; Sun, 26 Apr 2026 20:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777261383; cv=none;
        d=google.com; s=arc-20240605;
        b=LrQGmyOdBO2UAqaO7PmdJ8wqmqTUl4mUtbu+rHPRrPrOclQyv8kzXry+Cj0hjUfpkn
         M+dFaRM46qY5IGzpb9uPgeKSFr1qQxgM6bxlQFYJNGX+su6ja+Gdasf4v1SvTZNSZFLl
         MNRlDBV9p2X1rIWRD8k6sEo+XYRDVGxlRcFXWsnR/u9FX9d3/gDBEnEUE/oxcSSqh9iI
         Wi703Q0+g9PEO/+cV/kVzeVlXSEBgz9UYx1HzCk8+Y04Ljd06Uv4kSuZMaoUlmdUkmwR
         Z/gxdCC9wWrSplGrtS346GzYC5/23mgm2FA+/UIU/kC5xfxxIC6D07mTzM12Mr6lwwhK
         LN2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i1wsozKYAd1yUpII51kKd/OUBtsrEEmUo4ZxLHwLHGM=;
        fh=pW6VSZ2E7beBk7kdkNAo3G4bu9vKA8f3oNqHlikvj04=;
        b=DMo/AxrZ2w6i3photHQVQ5rrytlxcTVv6Qm0R72E1dzm3k4gDmB7Enq8YN0j0BfKh4
         RWA1FVrmJWG5S5q9jaXuWqOP4HDGVSMgQtujC34rGAn9hyNhiA2LEPg1nHyK/HkByF81
         /pDtWCU2LPNmF9FXHKHiOuJWBeKBxgg9sEgoh3djK6BWNBtspSgkC87HWc5UkgLyTlPK
         BtniUi9q0Ky4PvSPHq62Pg9WO6g14bCJUfDgj8uvhS7jwomE3VdoluEkT8aGPmrmMCNK
         xQVcnQiJReR5OlVuQs5WaHKL3rGWDFIEvWFcAxU5PF1EYpDkibb1d72gqQcZPh87wCJI
         3oAA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777261383; x=1777866183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i1wsozKYAd1yUpII51kKd/OUBtsrEEmUo4ZxLHwLHGM=;
        b=kv56Ns0H56/PH3riSf5jXuV/d617/NZ4LBdT7ZKMAIuKsf8cjWvmX1wD84IZvxKa4H
         vcPOHfGrU70eLXMzJId0Zy8Wp5YSQbFqFE9VbPYcxeJesHpsPRSwufZJyddSaT+w39T5
         S6Mw+Tr++2zjfs+9gkizI712Uis5FqqRZ3vOEW9UbxE8eZYAykYWP12v409iv4PH4KxH
         hi2LBR5FmZjD1DhiJXvh1qr+un+DtMDRqm05vaGJ9I1SXBdrYEPNsjVYVmz/FpktiXCv
         J0z6aqPzqxzXsvbFlIMm7YF3CqU1K0TztLam1lv6SvqqqdcNtcZeqLDzrZEjTdUWJU7i
         xUvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777261383; x=1777866183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i1wsozKYAd1yUpII51kKd/OUBtsrEEmUo4ZxLHwLHGM=;
        b=mDYqkSOGpgZhjIighYRLxxKz2tUJ/eCMxbvYJLfSv8w7kupGTECyfSZa4mux27JpAB
         vySE54pdI9EnFoPxgtUJEL2sfbkyZd2hQyjRGTVi8jucRoa0dB5T/EaLjnxGIJIMMoLv
         aB/crdFjjsHToDaPwgHDgUk5CouYsEwlPiZ9UZwx5pJ97n0LKwwJG5M+nYa/rnFj0+jQ
         q40WLRQwINuXek/wtJSBtUTXf0G4G7fqiOeiuWS1Cga+R+3SzBXjF1tdDy1GYGoaeRY/
         mElttbhO0UZZYIgSYXqvfxOlVqz5MnpSu76ExgOupOMFZ1Tyhp4RzE01l+ciPWlUQHCu
         S46A==
X-Forwarded-Encrypted: i=1; AFNElJ9minzwY1MRi6dBuJ/l5COblbcIqq+1p+OlKakndMvLGKboUrDHh7igs45n5UYPi8Nb7FJ08rr1VxtliLEiNGvpTuf4yqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3LfqSJ0BqYybMZJDdW6WIjkrEptBY/0hQzmB/TLiReUQZBez
	9X2vD6FhXzAGr+2qFaS61vSidqCs5xzpyvq562GKbO0siGHTmfSrcWq22KdOrS2pG6URQ8cXo0y
	Y7dSoY8GZBGOof3+kFFgkPU1T8EExgHQ=
X-Gm-Gg: AeBDieuqAIUMiBG9wcEzbeCpqJ+4p1eeBOCM4Oan3aB27fmZQmfHKLaA4dolFgeRtAr
	r32YcG7z+JrX/uSb8gX8nXiFuftIS7ciGvFJuYTpQWt75yFpcGknhBa423qxEVHk2HMkinu6l09
	yH0CS9tV9Lfp8ds4ULKrABJ/V0JYAoV7T+6UEelNe1unAcjlnMZ9g46pgOjN+0M445PgZwrbtu2
	s0oR9kkWRL8ACQN9TwrPNq+1cPt5+bOCzfJDouUDQIsFpB9MKtQ4OJKQXOAsgSLJgRVaik93mpW
	yvcH2Sy8GSCOjIjxYnUBmFku+JKtYCLAxkaBx/pMxQT/M79ZrrwEBWojWjZojA==
X-Received: by 2002:a05:6214:588e:b0:8ac:a48a:a586 with SMTP id
 6a1803df08f44-8b02803f167mr647114386d6.14.1777261382999; Sun, 26 Apr 2026
 20:43:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com> <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
In-Reply-To: <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
From: David Windsor <dwindsor@gmail.com>
Date: Sun, 26 Apr 2026 23:42:52 -0400
X-Gm-Features: AVHnY4Lv_udS1YjhPNVYhT9R-oIUIcO_YCQ6gEoTqdWddJ4UBJuMugcb2-0tXIc
Message-ID: <CAEXv5_geng=0cNdC99b_p=9GV65wv73npAWBtooVRzXN5xVhnQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Song Liu <song@kernel.org>, 
	Jan Kara <jack@suse.cz>, John Fastabend <john.fastabend@gmail.com>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yonghong.song@linux.dev>, 
	Jiri Olsa <jolsa@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 26, 2026 at 11:33=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> wrote:
> >
> > On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwivedi
> > <memxor@gmail.com> wrote:
> > >
> > > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.com> wrot=
e:
> > > >
> > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to atomically=
 set
> > > > xattrs via inode_init_security hook using lsm_get_xattr_slot().
> > > >
> > > > lsm_get_xattr_slot() claims a slot by writing to xattr_count, which=
 BPF
> > > > programs cannot do: hook arguments are not directly writable from B=
PF.
> > > > To hide this, the BPF-facing API is just bpf_init_inode_xattr(name,
> > > > value), and the verifier transparently rewrites each call into
> > > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value). xattrs=
 and
> > > > xattr_count are extracted from the hook context, which the verifier
> > > > spills to the stack at program entry since R1 is clobbered during n=
ormal
> > > > execution.
> > > >
> > > > A previous attempt [1] required a kmalloc string output protocol fo=
r
> > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow all LSM=
s to
> > > > provide xattrs for inode_init_security hook") [2], the xattr name i=
s no
> > > > longer allocated; it is a static constant. We take advantage of thi=
s by
> > > > passing the name directly. Because we rely on the hook-specific ctx
> > > > layout, the kfunc is restricted to lsm/inode_init_security.
> > > >
> > > > Link: https://kernsec.org/pipermail/linux-security-module-archive/2=
022-October/034878.html [1]
> > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linu=
x.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > Suggested-by: Song Liu <song@kernel.org>
> > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > ---
> > >
> > > The explanation and code make no sense to me. Why not pass xattrs and
> > > xattr_count directly as arguments, even if you choose to restrict the
> > > kfunc to a specific hook? Why does the verifier core need the hack to
> > > spill the context and extract the two arguments?
> > >
> >
> > xattr_count is an output parameter; we cannot currently write to it in
> > bpf as there is no verifier support for writing to int *.  xattrs and
> > xattr_count can be fixed up by the verifier, so we only require the
> > user to pass the name and value.
>
> Sure, but the kfunc can. Did you try passing them in directly?
> If that doesn't work for some reason, we should fix it instead.
>

Aha yes, I did try that and I believe the verifier rejected it because
btf_ctx_access converts the pointer to a scalar. Will confirm the
exact error tomorrow.

> >
> > > pw-bot: cr
> > >
> > > >  [...]
