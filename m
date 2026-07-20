Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AB93B9943
	for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 20:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578585; cv=pass; b=c6hMLanaI4h8FRlWLfgKtvJEDgpGbh+9kZrRZlM5AeCh2x9cAqHRlK7Hc1hbg0E3Dfr16CznIMbjAmbtBEUD9AlZaluCIpSqY8uw3khL0ECoaRBWkf/OTJ3zHhX7L0CgPSI0UFsckFFWBo3n1zx9KEoUIz7woPhgLLm/QJ5sw3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578585; c=relaxed/simple;
	bh=qOEkNLJrOibH57gOt/DIm3R8ct2tEakFik9JpGI7f18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Np6iZ15f0mZ7swL5PSKiDLeJJY3l5zu+EWdFeMMbqiVopfoPulnAzciJyhO8xRk10V56942SruFujS+N2FNt5aK2SZQe4a9X1KiCQimQkkbtGGmcn99Aqm5WI0uALXxwXEDOHQqc+CdbAxZec1UvECzFNncr2g4C7PHSJDh4ykY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=d2866SVJ; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="d2866SVJ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84a2dcec51cso9688589b3a.3
        for <linux-security-module@vger.kernel.org>; Mon, 20 Jul 2026 13:16:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784578569; cv=none;
        d=google.com; s=arc-20260327;
        b=FEj0VAfiLC+699ED1r4YCsVJGLhIfvOD45y2L6IYYnYFCbfVn2P6ZEFNEsgHkrfUzJ
         B2mgL7Zjw60xzAFNAmJwVcP9fwgIr2wgZ1UGN0SuFx2gCPvTTtnCnmzSnQCMKSGs8msi
         n/RL+bkQs5H7RkARcHZcDQihuyFvt5TmFIOTNA6++jqvIfM/ptsMSjHsukt7f/Qn5YeW
         xkbjDw18PQiUPPpMw0IirI1cfTWqzRozwpxvE1Jn2J6ilMFMXoK71n8OFqkZrcJA56xY
         Z6RgEKT5BTj8nxd8bwiSkiSBKy/WaoiuVkxUpo2Az/6oZtpTfsxkSgsBeFEbENbMJZeT
         ntnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NEIzKGx6nstnSDXiYsrtWuuGIdEs+ij5HpQm4P2etZk=;
        fh=/Ktv7tjRKuIY+OM4YzQu7QQAhWqAwKNsatCnPxQ7qM8=;
        b=N9tNcE0tRHg4eQTDFKMSMRbW2sSeUGg0XHa5Cn+epPjG6fE4SXGNEXFxZ8kIfhck1i
         Y2ayTW52fXnnWjgU7CxHvsKJla40TVQT7ypWIowzLlKRd7Obm83wSXyhZaxAGdsoq3Ga
         4r9nlQOOYUZh2W5AFRqH7l3vHqm2Hz9W25QA91kv6lJMTFnYMF9o/bsLF2+Fiki5GTIl
         222rc33SvbWmr3fcT3gpY/iT/hr8bX/GCGIg9xmr16uaz9mgVtoH8AhPZFx4OMSi6E9N
         OUzfhHaJP4Wm9TkKCA56txHh14KcaS5So82vKgi30PvnVsZ9o+EgYoxjcqIrZxb/NZm9
         VR2w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1784578569; x=1785183369; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NEIzKGx6nstnSDXiYsrtWuuGIdEs+ij5HpQm4P2etZk=;
        b=d2866SVJs2a0e1lfW2MqZvVhHeHIcHycmtnI65CnmV5ZeaakXFzLdM8aykzl8XCp4r
         FjIgoqKhSid0Ww300wNhKHUVQRbmt5vyhdjyGdMviHWnGpWlKD632Cn+BMeib6C6LWxu
         5VF1OoAfbCwtkrxfDTYj1XkpnLVMkWpe3YoGEjDstsJEFzdcsMULJhwhQKwNyQ66OkgV
         wxxZ3fXTFoneravECaIHMy3fg9WbwXzJbK0co4pRXXXR+ue0ep3EFGwbAXctpImE5eOB
         lQn0zqJHw2zJRBZHBTCL4C56JbOgGfThb8fVfsLLcdX4fLZAht1e0QHTyJG44uJFYEjm
         ip9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784578569; x=1785183369;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NEIzKGx6nstnSDXiYsrtWuuGIdEs+ij5HpQm4P2etZk=;
        b=UlPfg+aGoiAPEXCsg05+c9AVo76wSz+KFlGuyAqpzsquU+G3iJ0MBnJRSVP5cu19Nv
         hNpdkTZkBIMBsw7u24DmWqxsV7NZpt5iSqD/B5CKs9uqZAHLctAvLfiftFlkaH0bQ1h6
         UZ/tRzrcaB42nM3YOKNytUs9oT40cYsuE6DL7aVTqJLX52hvXwf5rN4KSOGgJmbp8QCB
         9687W1h3PPzN+8AwczauwpYcFh7V9hJuRDSbzPII6MwnK2rLrI26o8ntyEXpz9btUiHt
         IA3FcsP7YKWZSs/GumfAHpRsp/BARXLv0QZgEgDADR7ljCX0kLQ2LDzgLvnWD6nlyENu
         wsAQ==
X-Forwarded-Encrypted: i=1; AHgh+RpghBgQB4LEcfkhB7/tD3Iu1iCS4ngMj+wVT6oY8l/GJKc0cUGaI2tiesnkEjEqLqkrazvq9IMZKs3Jlz48poGTqJP0y2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIV2KxTGUOfu4YIgxszP1SbRMapoXCmkhHEkg7NHlowsw0P1MU
	UmcSEbGjE4pz+jBkgTidIffYjyAmMDAcGew1C4V2HbiRT7/Ia62rxp0iBxtzuUJZbRkyGZyjg3q
	eTOkK/Qyk/bIIpM5BkrmUBLEaX0+8wUWtnh1tWkGJ
X-Gm-Gg: AfdE7cm5rpbt/+DtEd1cPVsKOqEuMO/b2o1rAlz/5b7eXQeZd7J2sCD4OASFk8mlEqU
	OmGGhtERM0TMa3cc254gb/LvnUheB60wA2EIe95DgytSKsGsY34gVh5FddGq1pAcwroNsCeBM7j
	R3knnUW7ERhdeGLI3T+R9MoCU4YqgxGNNceBRjmGAiV73XcuZoat8oWI6s0Uava4VW4tPfi9UxX
	F24YDBX2pPhDMKN/t2Geelxo4E+MIaMNpBv5MaRaSRv6xHKUwy2iAXLH+ph6Q==
X-Received: by 2002:a05:6a00:438d:b0:848:68d7:c673 with SMTP id
 d2e1a72fcca58-84c2948848fmr15306792b3a.47.1784578569285; Mon, 20 Jul 2026
 13:16:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260708000956.46138-3-dwindsor@gmail.com> <a3a376bce713ac38ce6746508239c1af@paul-moore.com>
 <CAEXv5_gt7BPWvdR4D1_3XJ0_XpBXWN52jeAOf1K2QJ7LL6CtPQ@mail.gmail.com> <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com>
In-Reply-To: <DK3LZOFOVG5L.3F34IKOCO1I04@gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 20 Jul 2026 16:15:56 -0400
X-Gm-Features: AUfX_mw17rEY5xGffzntET0ex7-B1yqGVCACoJsXOFIbYfGKrVihTs1yl3fAaHM
Message-ID: <CAHC9VhR8n_TBPGLGq-Pray+mHrUCdcmqGXi9wTXyeGa2Dc4m4g@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] bpf: add bpf_init_inode_xattr kfunc for atomic
 inode labeling
To: David Windsor <dwindsor@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, Matt Bobrowski <mattbobrowski@google.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, 
	Casey Schaufler <casey@schaufler-ca.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, Shuah Khan <shuah@kernel.org>, 
	bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org, 
	selinux@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 20, 2026 at 2:27=E2=80=AFPM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
> On Mon Jul 20, 2026 at 8:12 PM CEST, David Windsor wrote:
> > On Thu, Jul 16, 2026 at 5:55=E2=80=AFPM Paul Moore <paul@paul-moore.com=
> wrote:
> >>
> >>
> >> I'm sorry David, now that I'm seeing this function again, especially
> >> with the LSM specific bits extracted into a LSM function, this absolut=
ely
> >> belongs somewhere under security/.  It's only callable from within a
> >> BPF LSM callback and all it does outside of some BPF pointer boilerpla=
te
> >> is call right back into a LSM helper function.
> >>
> >> If the BPF maintainers aren't willing to accept that, then we will all
> >> need to find another way.
> >
> > Where this code lands doesn't matter to me, so I'll stay out of the
> > decision of where it lives.

Yes, you're caught up in some territorial wrangling that goes a fair
bit beyond what you're looking to accomplish.  My apologies for my
half of that, it is an unfortunate part of upstream kernel
development.

> > If this kfunc goes to security/, would we also want to move eg
> > bpf_set_dentry_xattr similarly?
> >
> > I'll roll v6 of this series meanwhile and we'll see what the BPF
> > maintainers say.

Thanks.  Fortunately, it should be easy enough to move the kfunc
around, that's likely one of the smaller changes needed in v6.

> I don't think there was any preference expressed from the BPF side.

Look at the second patch in the v4 patchset, you'll see a preference.

> Logically,
> one cannot be faulted for adding a kfunc to set the xattr for inode in th=
e same
> file where similar kfuncs to set xattr on other FS objects / entities exi=
st.

First off, I can't say that the existing BPF kfuncs intended for use
within a BPF LSM program are in a good location.  Unlike every other
LSM which locates its code under security, the BPF LSM devs have
chosen to locate their associated code all over the place.  Some of
that happened before I was responsible for the LSM framework, and some
of that which has happened afterwards has likely intentionally avoided
traditional LSM review.  Unfortunately, this has muddied things with
respect to what is possible generally in BPF versus what is possible
only when the BPF LSM is enabled; we just recently saw where this was
arguably the root cause of an exploitable vulnerability.

> The question about bpf_set_dentry_xattr is thus valid.

It's a very valid question.  It is my opinion that kfuncs which are
only intended to be called from within BPF LSMs should be located
under security/, just like every other LSM.  If there is a kfunc that
is generally useful from other contexts, that is a different story,
but in the bpf_set_dentry_xattr() case, it is explicitly only useful
for setting 'security.bpf.*' xattrs.

--=20
paul-moore.com
