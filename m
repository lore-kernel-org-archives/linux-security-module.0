Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="HILqKYZ4"
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CE7112
	for <linux-security-module@vger.kernel.org>; Tue, 21 Nov 2023 20:41:27 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-da30fd994fdso385107276.1
        for <linux-security-module@vger.kernel.org>; Tue, 21 Nov 2023 20:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1700628087; x=1701232887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZGTSoBXC/6Jkt5M8V7vCMsiBLn/G0YqKZNvpHoWAN7w=;
        b=HILqKYZ4n1N9Ad42Z/VVJUn+8ranxQhzx9VA0YXdMNGpyGLaH19kcqhf0DOT8b1ti9
         Zty/AZrfNDWUuF/egTOeVG3iCUyp55OxpWcEDrJjioY5l5Jpjfq3om/wQI9vOt/2ijEH
         SazXpSdMm7xzeu2Quhha+0+MJWvCG5zZBySI2+zWj4Xdi6OtTcUuWMOo/6V1EOtljMI8
         aRfPGC7vgdmzx7Ofjzm9MZNucg701zIAVyokCRBkNgpApINy8TGOtl3v0c+yrMZjitTa
         cG5MCIdP3BmeiC7N3FqHs5YexVkV3nZWkgp5e5UI17T1YGnFMqcJsayiijr2tWuFn9eX
         aXCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700628087; x=1701232887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZGTSoBXC/6Jkt5M8V7vCMsiBLn/G0YqKZNvpHoWAN7w=;
        b=lxBUaQzeBAiKt19MbmrluMuI+sibbgZEqpUm1PE69B9K6gYYB9OGV3txvd1EEk4OIx
         L4P4blsRoQT0szenCuE5oL8Qa5yNcpIO5XuWknZSEo8lPsWILJ2hfB4FafEAk24n3X+C
         mYcP1SqDJZyUCjYW0IwD/VfoAuo2tyRYbMd/C31N0JkAUGbSOoQihG9ue3E8z3qSH7MX
         6C8IGAJzuH2kpV2ReFCDTiQt7okIb0QUu2rp/LHMSDSCnFcrJs20fNNV/cInrRFWAvrj
         hgou4aYqIyCOqfhCYl69Dz4agVQcoVyPvGbPI6GMDjEhMeLYkVJ4qMpWyXIy25Do0vdb
         rqCQ==
X-Gm-Message-State: AOJu0YwUhPz9T1fhKY/DYRwdAwbYBmZgphmD0zdXNdxfdGYkgTMLiBrA
	2WK/m+ev4tO6L4vNhpCB4/nAgObPC41XWdvQI7ZGfaqfGbW5aoY=
X-Google-Smtp-Source: AGHT+IHe8amBKBsj3yLOHRxofJ+KPSrg0taVp4UY3/qytXiDrVNd3+3/eM9zDlh5XZb5Egn1ifS1YQTJpxov+QEIpYM=
X-Received: by 2002:a25:3496:0:b0:db3:5185:1737 with SMTP id
 b144-20020a253496000000b00db351851737mr1001554yba.17.1700628086781; Tue, 21
 Nov 2023 20:41:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <93b5e861-c1ec-417c-b21e-56d0c4a3ae79@I-love.SAKURA.ne.jp>
 <CAHC9VhRbak9Mij=uKQ-Drod0tQu1+Z+JaahUzH5uj9JUf7ZTuA@mail.gmail.com> <7b9e471a-a9df-4ff6-89bf-0fed01fcd5e7@I-love.SAKURA.ne.jp>
In-Reply-To: <7b9e471a-a9df-4ff6-89bf-0fed01fcd5e7@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 21 Nov 2023 23:41:16 -0500
Message-ID: <CAHC9VhRy_sZNSRHMJoULFX2vb=opj1s2hEffaVNJyaHycWF+=w@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/4] LSM: Officially support appending LSM hooks
 after boot.
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: linux-security-module <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, 
	Casey Schaufler <casey@schaufler-ca.com>, song@kernel.org, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, renauld@google.com, 
	Paolo Abeni <pabeni@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 21, 2023 at 8:03=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2023/11/21 7:52, Paul Moore wrote:
> > On Mon, Nov 20, 2023 at 8:28=E2=80=AFAM Tetsuo Handa
> > <penguin-kernel@i-love.sakura.ne.jp> wrote:
> >>
> >> This functionality will be used by TOMOYO security module.
> >>
> >> In order to officially use an LSM module, that LSM module has to be
> >> built into vmlinux. This limitation has been a big barrier for allowin=
g
> >> distribution kernel users to use LSM modules which the organization wh=
o
> >> builds that distribution kernel cannot afford supporting [1]. Therefor=
e,
> >> I've been asking for ability to append LSM hooks from LKM-based LSMs s=
o
> >> that distribution kernel users can use LSMs which the organization who
> >> builds that distribution kernel cannot afford supporting.
> >
> > It doesn't really matter for this discussion, but based on my days
> > working for a Linux distro company I would be very surprised if a
> > commercial distro would support a system running unapproved
> > third-party kernel modules.
>
> A commercial distro does not care about problems that are caused by
> using kernel modules that are not included in that distro's kernels.

My experience has taught me otherwise.

> If a commercial distro does not want to allow use of kernel modules that
> are not included in that distro's kernels, that distro would enforce modu=
le
> signature verification rather than disabling loadable module support.
> Keeping loadable module support enabled is a balance that is important fo=
r
> getting wider developers/users.

We don't currently support LSMs as dynamically loadable kernel modules
and if the only reasons for doing so are either to A) support
out-of-tree LSMs or B) avoid having to recompile a kernel (to hack an
unsupported LSM into a distro kernel) I have to say (yet again) that I
am not interested.

> > We've talked a lot about this core problem and I maintain that it is
> > still a disto problem and not something I'm really concerned about
> > upstream.
>
> LSM modules that are not built into vmlinux currently cannot be appended
> after boot. Such asymmetry is strange and remains a big barrier.
>
> You are not concerned about this asymmetry, but I am very much concerned.
> Please give me feedback on not "I don't need it" but "how we can do it".

I thought my feedback has been clear up to this point, but perhaps I
need to be more direct.  At this point in time I am not interested in
supporting dynamically loaded LSM kernel modules if the only reasons
are to support out-of-tree LSMs or users who want to hack unsupported
LSMs into pre-built distro kernels; both of these use cases can be
solved today by compiling your own kernel.

As with the other threads involving this topic, I'm going to refrain
from any further comments until I see a new discussion point.

--
paul-moore.com
