Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECDE4CB24
	for <linux-security-module@vger.kernel.org>; Wed, 10 Jan 2024 16:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Lq/TzgyS"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbeda700015so3310722276.2
        for <linux-security-module@vger.kernel.org>; Wed, 10 Jan 2024 08:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1704903251; x=1705508051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvddn3dPHHr9kcurs7ME8j0fV21596szf3DjOsQborg=;
        b=Lq/TzgyS0gOtZfn/kngIi7uvk3UsZOlDgIBUBEVz2bxCJKlMuWOds1csOlDR6HZqMR
         dZJpIiw4uYhbqs0u8tcEOPxEXqNX0vOQKDlqenKaLOjIbb+xJECWcyZXPuBWMZHP8JmL
         IFrttyTxar0zG5DfdEig6eXK6BXySIUCYF/n11yqPMMOxyXzb0uvc26dz1nzIDnRnu7x
         8PoLfZJQVkpkg2+L0rh+f8TFLEHo0ZgMPKSZl4WsEqXcLVqaoOnp9CHCvySMuOE7o0+a
         pFpYRDQUc+5yAh6QI+4qEYfbGJSvS8Fv9rmsA6kCu7rQjKhRwQXN7ipWDpfzeS6q+WR+
         /7Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704903251; x=1705508051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tvddn3dPHHr9kcurs7ME8j0fV21596szf3DjOsQborg=;
        b=FotUk8k4n6CfCaIHpETghyuwH1DAXeo6+ahMpoSHxzTK4mNRXU7t2ap52PoDaV4m22
         QFCToNOv8XUunFW0HFBitfHEZ9O4Y2/HrXYNmvLAcpy0g9Ny7RfFH/mhwEV0XFg/kEf2
         RY20Ms3kIEswTr4hW2EBF54uSAVaYsA4zEtW/Hs85j94QWLrlWteaITCZhsmZn1eWPm1
         D1VQoQ09MLmS2xSbqf7d6SaMkPEYlsWpr9DaeVeDAsLwvBdTMIt21JDHZhX42dlENvQb
         AMef2ZomwJzcQFhnWMREm1fdBBTDgKQxLYA/mqi6QOP5Ots4DHoGFdrVGBZpFFQknWoP
         Zsbw==
X-Gm-Message-State: AOJu0YxIb1yLL2wZHAYGpmgOmHE96AnMuwioz2/FQL85P+Lo/xmHisMJ
	FcCP+SHb1BmOqVlmOh045Autq06mSTbhsLvrvM6zo7Dyf2NK
X-Google-Smtp-Source: AGHT+IFaub2qZEQFBSk6g/x72Y2vAWfcKztShBJR3c3dJ6hdDRBJYj/92PbQufB6opycssFLhrSeQQNbHkXDWbdCJAU=
X-Received: by 2002:a25:b1a2:0:b0:dbd:996c:1f92 with SMTP id
 h34-20020a25b1a2000000b00dbd996c1f92mr1041392ybj.27.1704903251346; Wed, 10
 Jan 2024 08:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214125033.4158-1-laoar.shao@gmail.com> <CAHC9VhTs_5-SFq2M+w4SE7gMd3cHXP2P3y71O4H_q7XGUtvVUg@mail.gmail.com>
 <CALOAHbDEoZ_gPNg-ABE0-Qc0uPqwHJBLRpqSjFd7fH6r+oH23A@mail.gmail.com>
 <CAHC9VhQkRPMO2Xpg0gYdpOPZTDrp1xKwU=idt9EQJg7Zi7XjqQ@mail.gmail.com>
 <CALOAHbA-aW5gHXuf4MZVDXqD89Ri=9Ff7wcnV5wnBe=+pjkLrQ@mail.gmail.com>
 <CALOAHbCqMZE2F9E+KdLtF=hw9_hEkhjAsHaCHaRwKYWU3wyDyA@mail.gmail.com>
 <CAHC9VhREmXPg2TgDcK+moeJv3AvDR1wKiKNEex0AX6cQAzhVjg@mail.gmail.com> <CALOAHbCJdPdSjU2ab_s=CtAJ6VULpSZUMhEL2bcG0yAmE+quUA@mail.gmail.com>
In-Reply-To: <CALOAHbCJdPdSjU2ab_s=CtAJ6VULpSZUMhEL2bcG0yAmE+quUA@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 10 Jan 2024 11:14:00 -0500
Message-ID: <CAHC9VhR241UqLqepaAYNEpt4nRaBr-_BAdEbzQ+yysubywQOyg@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 0/5] mm, security, bpf: Fine-grained control
 over memory policy adjustments with lsm bpf
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Kees Cook <keescook@chromium.org>, "luto@amacapital.net" <luto@amacapital.net>, wad@chromium.org, 
	akpm@linux-foundation.org, jmorris@namei.org, serge@hallyn.com, 
	omosnace@redhat.com, casey@schaufler-ca.com, kpsingh@kernel.org, 
	mhocko@suse.com, ying.huang@intel.com, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, bpf@vger.kernel.org, 
	ligang.bdlg@bytedance.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 10:56=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com>=
 wrote:
> On Wed, Jan 10, 2024 at 10:28=E2=80=AFPM Paul Moore <paul@paul-moore.com>=
 wrote:
> > On Wed, Jan 10, 2024 at 1:07=E2=80=AFAM Yafang Shao <laoar.shao@gmail.c=
om> wrote:
> > > Paul,
> > >
> > > Do you have any additional comments or further suggestions?
> >
> > No, I'm still comfortable with my original comments and stand by them.
>
> I understand your perspective, but it seems I have to propose an
> eBPF-based seccomp in the next step.

You likely already know this, but just in case, eBPF-based seccomp has
been proposed many times in the past and has been rejected.  I don't
want to dissuade you from doing so again, but I suspect that this use
case will not be compelling enough to be successful.

--=20
paul-moore.com
