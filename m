Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA44933031C
	for <linux-security-module@vger.kernel.org>; Tue, 28 Apr 2026 16:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394039; cv=pass; b=q6SDpE2oPzxyQd7GLl39rArjRTyNvcJjjjxlfxXCIiBcBUk6ENoIR50og63kSwFPQewVZWsEYEQ4ID9Drw1tnDRMfWPkNVwruzXBHd3B0YVMSHdmB6EyJsLTI4QUcvT/ixmzHMd/4E1Ioacq6E/a5HyGcwR3qHFRsqU4xqnrokY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394039; c=relaxed/simple;
	bh=52MdagQnrh3ZadMCj+Aj5TQ5SCuB+VKPYF2izc01Hgg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H8dSZzPNjteQXhyzv9DmvOUY0gu6ab1y45X8pZK+h7tRdB5+A3Mp2/KjMTzp9HQO+ZOX5gAqgxzfI1OnjB+2vB+XF5jz5krHU2PBqEJ6W193V+Q9BO2Wf8Q9V3VgpE8WABhFvpv/uf2YWpPqtcVNNNEfgl7ZhFs5l/OaoAMj1h4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gOq5rH3q; arc=pass smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOq5rH3q"
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-488b0e1b870so199093595e9.2
        for <linux-security-module@vger.kernel.org>; Tue, 28 Apr 2026 09:33:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777394036; cv=none;
        d=google.com; s=arc-20240605;
        b=WhbxKMgiICwQrk6UOIFdlr3oDrhDWhaXEZG+cycDRz1uS8cFMIPeL7LtD1MLFM7dhO
         N9zUxbo+qYKThb5YgYCKqdb8T7z1xYE7j6/jxQbMbiIltJVG80gGmVEP9vZaT0CUG3+u
         ITeIUQp25Wouxf2ocoPYEA49yQ1AkN/cBaiBnBQl3ta+jORcvSUu/1XTkOnwPgbupMy1
         2vG9lPf41QfSn7eL5yNwERen8gr06ZHBS2fyaxk6fhu8z4+lRwc2HNIYytCglOp+QGGS
         h2dpnrw4l8Kn6Y5ao625W7LyGZfJNbKvS3Th/uWHynh8HOTHsfF0LlxGjzpfugSQk0S3
         MW/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=H4tL94f/+zrQ9tmGfQ35+hzuIQymZx/bUR4W9C2f3sk=;
        fh=Xiagob23ZMHZvWC1GiFlCVJ2Ck7dbCufDLfNSWtHsMU=;
        b=U3S3tnVoxyeqpNcqAgiqvWSN2xWDi95TaxZxn/6FjDNCzU4Fvz/h8jkqf7041ukQqm
         +d/+SYQb6gC2oIQgjIHDcJQuzi7jKrP8VWIB7Lqczb5hBzdm/jQXb72U53qDL5vEIl1h
         2syaGzWauXggssBjHdKsDHG3zrolZlTC63N9pVxDUKY241/mwv4ZLWObSsrV2etb5V/b
         NB1RDOPEIq2UGI36tqN1+ry1etGuOtHW+xb8vwSIXkmG34c4XkP82oQfMQR8KNe2wkse
         HR5uf4hyzqddOgBt2ztgW8eKDYITYWlFgayMsjn8we9dm9i9DSgMJqfjtBRSqY9XeDpS
         ElYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777394036; x=1777998836; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H4tL94f/+zrQ9tmGfQ35+hzuIQymZx/bUR4W9C2f3sk=;
        b=gOq5rH3q1hO6smyOz5GzqsPvxPNLDz3e/MlvRz5dyyg0/MnMIvzOWGlOBynkUz6bQB
         l/Oi6SUp1x+0mOtg7NTulQSbwDWDik7w/N4axau/LqIf9ZdF7JeWdEX7v4r26ewv4z3e
         fX7xTBb/NjxY2OdM9axpZruwB2LphvNJOwDJOcDUvympYS4DrBJbv0fXzsvJYbPC4Y+h
         n5grZAEZeYcHy326JARFl4XHpajn2scsSbcTzYR1E1jC6I/mdZMKrYtukmwZhize6Y0R
         csIqvJZCB6+vRcboClVSHD9IyGs+6KOBRDdE+Ay/2h+oJ6KxhDjW3pDzfMak6C31RPoX
         v9fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777394036; x=1777998836;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=H4tL94f/+zrQ9tmGfQ35+hzuIQymZx/bUR4W9C2f3sk=;
        b=YIdNgqC5ZEFlINNyyn+oC/K8Jh1dr1jyBXNBGbqRuAruknCVRb4O+AVAlgTG11kVEZ
         /H17vi7EZGcvCxS5+rFpOT/mavgZ4lgTBRaSIMW1Ipk/VMsF4ZuBpBfgfGMLcVvRCiNm
         26G6tSF9VGIHsu2Ovc+fkY69dkOC24qgqr7fbFOR9DR8IT4QBRgmg/jhsWZ9ojgwItYU
         1Wlli+lojGXmRnhgtWB1XMZN6HpJ1aDwOmwX8BCX3XOFu4PIoZKrQ6rKcDuS1mOfhHwM
         Zimb+JOdFMhNTnjcZsM3O4K3R9yQaVk+2Fh2FQQ4I0S3kMsexsGtu+cFDMXgpUl60APy
         TwWQ==
X-Forwarded-Encrypted: i=1; AFNElJ+VrHRoAPjUwIDEOCbOhRHl+tJRL49oWN1zhSzEc+/nlmYzAdyAzWISDQHrAVWI2oSwXr3UJy20EDWPVaTFyVLf1CzeG5I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIbUHDRIppWb1ViItZ4vCuZYJay+JKV/fuzzRCFP82KjPH897U
	7eugSx2SVqXfYTG1DNZGLVUfLBWtDx43JAlJ/LMbATgzMrOA3DgYUCEG+zHicJJyxqyA8z+5fpw
	rqTVnHlGNr2Gxdngm0wmaZoveM/7khNg=
X-Gm-Gg: AeBDieuETSXH7Yv1vse0ApOVVQSelcbBb1Zph42WvMK/2Tac/mdLBjEEj8A5OygjOYZ
	YSKN9SLeepBVq2OV4QiOtrcLMVjZjeLGoaR6/x1EMYT1wq4fbCu9LruhuXtV7x7gQW1Ja44Ww1F
	tmDvLN5uxDfEbbBqdHZs14BK4WfJujuA7csYBkrS2WYi9yP33qH8xTebE3Iu/UcErW5nKZyitlt
	8r+mywISbxEiQi06V0r27xSF+zQg46xyh2i7jYyb3T55weiMSM1gsQFPQzMlLd3l0PWpesl/y2i
	JpdRQyjLKQdlFaElSc3Xjr3zQ4eGazAo7uiQPyyAdKI5Q7CCsZbPfUrKDGz18sILrwq5FQ1OqvM
	Nutbdj38w6oSY0SQ6Xq1eUveoVI1wHVhtDogFjN4mHDOVVJu2ZD50i3WFtcw57+9sZGsQ
X-Received: by 2002:a05:6000:2905:b0:43f:e94a:e777 with SMTP id
 ffacd0b85a97d-4464a070b10mr6490623f8f.37.1777394036183; Tue, 28 Apr 2026
 09:33:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427001602.38353-1-dwindsor@gmail.com> <20260427001602.38353-2-dwindsor@gmail.com>
 <CAP01T74iuSDJeL6g=5yLdYGb-VcESK1SYY3R1S1r-CtQEsW+oQ@mail.gmail.com>
 <CAEXv5_heSFK5rZYtaJG70Xgv92Um6Dbq8b95PtnpKy7XFwpKUw@mail.gmail.com>
 <CAP01T74WBjcMXbWYeaWB-oTk-bUzoxi_EEALDpT1hFUEOovnpw@mail.gmail.com>
 <ae82Vv0RWzcXqSaz@google.com> <CAPhsuW60SRXZbFYRDm-QaTiB8tTtJD_N4jk1=680x5UsZmpj9w@mail.gmail.com>
 <CAP01T75SBw6NNvBKyPW11JSYY2oh449yoBsWi_GOBR5Kq1ykmw@mail.gmail.com> <afCUADdbNrpbEPMa@google.com>
In-Reply-To: <afCUADdbNrpbEPMa@google.com>
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date: Tue, 28 Apr 2026 18:33:18 +0200
X-Gm-Features: AVHnY4I9zeiNlmD4AyDEKEpxt8mFMp29ig53d2G_1svR9xHiMr5JdVGll07goQM
Message-ID: <CAP01T76ipTgY3EM8uMSXymdO4co3AWZeXqwV3amqDnHiFXhrTw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: Matt Bobrowski <mattbobrowski@google.com>
Cc: Song Liu <song@kernel.org>, David Windsor <dwindsor@gmail.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, KP Singh <kpsingh@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jan Kara <jack@suse.cz>, 
	John Fastabend <john.fastabend@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Apr 2026 at 13:03, Matt Bobrowski <mattbobrowski@google.com> wro=
te:
>
> On Mon, Apr 27, 2026 at 04:33:18PM +0200, Kumar Kartikeya Dwivedi wrote:
> > On Mon, 27 Apr 2026 at 16:21, Song Liu <song@kernel.org> wrote:
> > >
> > > On Mon, Apr 27, 2026 at 11:11=E2=80=AFAM Matt Bobrowski
> > > <mattbobrowski@google.com> wrote:
> n> > >
> > > > On Mon, Apr 27, 2026 at 05:32:47AM +0200, Kumar Kartikeya Dwivedi w=
rote:
> > > > > On Mon, 27 Apr 2026 at 05:24, David Windsor <dwindsor@gmail.com> =
wrote:
> > > > > >
> > > > > > On Sun, Apr 26, 2026 at 10:57=E2=80=AFPM Kumar Kartikeya Dwived=
i
> > > > > > <memxor@gmail.com> wrote:
> > > > > > >
> > > > > > > On Mon, 27 Apr 2026 at 02:16, David Windsor <dwindsor@gmail.c=
om> wrote:
> > > > > > > >
> > > > > > > > Add bpf_init_inode_xattr() kfunc for BPF LSM programs to at=
omically set
> > > > > > > > xattrs via inode_init_security hook using lsm_get_xattr_slo=
t().
> > > > > > > >
> > > > > > > > lsm_get_xattr_slot() claims a slot by writing to xattr_coun=
t, which BPF
> > > > > > > > programs cannot do: hook arguments are not directly writabl=
e from BPF.
> > > > > > > > To hide this, the BPF-facing API is just bpf_init_inode_xat=
tr(name,
> > > > > > > > value), and the verifier transparently rewrites each call i=
nto
> > > > > > > > bpf_init_inode_xattr_impl(xattrs, xattr_count, name, value)=
. xattrs and
> > > > > > > > xattr_count are extracted from the hook context, which the =
verifier
> > > > > > > > spills to the stack at program entry since R1 is clobbered =
during normal
> > > > > > > > execution.
> > > > > > > >
> > > > > > > > A previous attempt [1] required a kmalloc string output pro=
tocol for
> > > > > > > > the xattr name. Since commit 6bcdfd2cac55 ("security: Allow=
 all LSMs to
> > > > > > > > provide xattrs for inode_init_security hook") [2], the xatt=
r name is no
> > > > > > > > longer allocated; it is a static constant. We take advantag=
e of this by
> > > > > > > > passing the name directly. Because we rely on the hook-spec=
ific ctx
> > > > > > > > layout, the kfunc is restricted to lsm/inode_init_security.
> > > > > > > >
> > > > > > > > Link: https://kernsec.org/pipermail/linux-security-module-a=
rchive/2022-October/034878.html [1]
> > > > > > > > Link: https://git.kernel.org/pub/scm/linux/kernel/git/torva=
lds/linux.git/commit/?id=3D6bcdfd2cac55 [2]
> > > > > > > > Suggested-by: Song Liu <song@kernel.org>
> > > > > > > > Signed-off-by: David Windsor <dwindsor@gmail.com>
> > > > > > > > ---
> > > > > > >
> > > > > > > The explanation and code make no sense to me. Why not pass xa=
ttrs and
> > > > > > > xattr_count directly as arguments, even if you choose to rest=
rict the
> > > > > > > kfunc to a specific hook? Why does the verifier core need the=
 hack to
> > > > > > > spill the context and extract the two arguments?
> > > > > > >
> > > > > >
> > > > > > xattr_count is an output parameter; we cannot currently write t=
o it in
> > > > > > bpf as there is no verifier support for writing to int *.  xatt=
rs and
> > > > > > xattr_count can be fixed up by the verifier, so we only require=
 the
> > > > > > user to pass the name and value.
> > > > >
> > > > > Sure, but the kfunc can. Did you try passing them in directly?
> > > > > If that doesn't work for some reason, we should fix it instead.
> > > >
> > > > Hm, perhaps this fixup approach might be the simplest in order to
> > > > assure the needed safety?
> > >
> > > +1. I think this is the best approach I can think of.
> >
> > We're not going to add more and more special cases to the verifier.
> > The whole approach is unscalable.
>
> Totally fair of you to push back here. I'm also agreement with you on
> the fact that extending the BPF verifier with such special casing
> doesn't scale all that well.
>
> > If the concern is that int xattr_count passed for xattrs can be
> > unrelated int pointer obtained from elsewhere, can we pack the xattrs
> > and xattr_count into a struct and pass it as an argument to the LSM?
> > Then the pair struct can be passed in directly, ensuring both
> > originate from the arguments passed to the LSM. That should eliminate
> > concerns about either being out of sync if obtained from different
> > sources.
>
> This could work, but we'd also need to modify all the other
> pre-existing hook implementations along with the core
> security_inode_init_security() LSM hook itself. I don't think that'd
> be an issue. The biggest hurdle here I think would be convincing the
> LSM maintainers themselves.

Yeah, when these parameters were introduced, we changed all LSMs, so I
don't see why we cannot adjust things again to benefit this use case.

>
> > Even if we wanted to ensure argument provenance was stuff loaded from
> > context, the right solution would be some kfunc flag that constraints
> > the argument to be derived by following the ctx pointer, not whatever
> > is done in this patch.
>
> OK, so it is provenance-like tracking which you were initially kinda
> alluding to here. Currently, I don't believe that PTR_TO_CTX is
> preserved upon any subsequent R1 (ctx) dereferences, so we'd need to
> think about how this type could be preserved such that we can enforce
> this kinda constraint (__ctx) at the time which the new BPF kfunc is
> called. Do you have any ideas on how to do this?

I think we'll have to track in the register whether the PTR_TO_BTF_ID
came from a PTR_TO_CTX load. That said, I still prefer changing the
prototype to pack the array and its output size parameter together. It
is even clearer to have a well named type than int *xattr_count in the
prototype.
