Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619652DCF41
	for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 15:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781277638; cv=pass; b=i6r84/KlJQwsBLmc9q8qrSv+hW0hYWZJ6bKATVK6/pnfMXaKj6xyeNqvQSqcucx4cVN79b2fs0qDzoCIGd+aViLDPZd2FylWVpp1qlhms0NhQixyN0vfB6RgXXVtZAnqicuJdYQmaQUTKbJ2wHgfrmpzvxypRqeaIEzkzSHBH1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781277638; c=relaxed/simple;
	bh=q05ryQ6x2sO8cTzsw635KyRO0xWh/j4v+/MdYH8lnCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XpYlfzqBEF2CVZ/XayVmqBYWY4bEf5R8IfuQuK/EQToY7/l3Mze77QzjlOfyDHYTjkC2VPeL9LywJqAhy2OsZutx3OhJA0qoyMDQSCHuhykKC1j+7kV4Fvri3A/pLIG52s3mkf8hsVggyHhNnqvc/ALMhZjkVgxxg1kAgjEg5dM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fx8Pb/+D; arc=pass smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fx8Pb/+D"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2bf20f6be6bso8381325ad.3
        for <linux-security-module@vger.kernel.org>; Fri, 12 Jun 2026 08:20:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781277637; cv=none;
        d=google.com; s=arc-20240605;
        b=AMEJ1MbCfliHdj+r//En6leRJwtNcP7ajBoV2tvEKCIOEboo19lWHcHnQxAwWiv+kj
         DmriUlYmndl5uHQ8Gs2jhwpvc1fkYKnPK0vqk5ZuID/3MlStaNMG4bXmEGlQD4l2avKb
         4yxNSBfMwWruq8OU6RYWNDS+HqnmGIwU28O1fzI+VVmSMseqsF6NGIOhSvmSsnbFsFZI
         Xueb4iQOBJdJcgE1tzztJVhBVRHuoQumTUS7vmRZLbynwz+kAtMynTzcxhZib9TO/i+A
         zRXNHLscvF7Zd92Zv35EoWnTbyba4U4zW4i5F2upkOXifhIEhIWMsXnnZwZrBMzckJny
         1aIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0cBAqeHn7mlTP+xG9XPCKaq9JCMY+Ozzw6VqXECwevE=;
        fh=iDNLqUKqpH6XRY6cLhQOAMgsmu4IjEe2d2aQe7Kh+I4=;
        b=hidNi9bxDlM42RFZUFpxFZk63i1veccWTgKb2p17odV1pV6H72UbnpPQpR0ZHEsrhJ
         QZ5Y5UqUBV1qqi84U0Q6JkO2q4cTTQfPnS3LZHvR5hM2BWOv77n6mOkrwlwws7oiKiHa
         2APS4jehEbYkVNsyXARDSCTbT/xo73m7uXuqw/e3MlCrDSWdkzDOVUS05jcJ8MlUwUUx
         gzmdmqhF4nOt3kz8qjl5GQ78PENfCgIbvOtbDzzQbWvkOrq0g/WHyKAyHWKamoHpuYDn
         sgOAphvIYi7rNQEo82h9lDfa8aMrxctCxxF1zNOl2FA4+YYWRRAGxekMydu1g+nPAewg
         TdGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781277637; x=1781882437; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0cBAqeHn7mlTP+xG9XPCKaq9JCMY+Ozzw6VqXECwevE=;
        b=Fx8Pb/+Dytu6Zy/hcEzNWmg90Mk6CuxUcP2Wq8oERDxgFZu+bTVK8ifEY7zpRyn6MD
         wI8DVHA6YrX8pl8ABY+cjGONxn6bixmi7AqrXgW1gC8I+PbizPpkH+3woGI7ZH85di/P
         MAr9k7jCfrD7Q699MS+23oR83ThWygc5unvCkjz7QAQMsBE4EVtB5Ml2xBbRa/7yvAHt
         unncnamZ2zixlhHdHPYJaSx1ze0Tx5BUMPuocqBTMLVY5FIsDdYdzEYQZqE0WnrckwBr
         h1zayfzXbGlYEvWc0KdYxOJUymy37ZckPFRfo9bLK7Uyqjt96xc1uJYu2HKfuvURS9cU
         +1Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781277637; x=1781882437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0cBAqeHn7mlTP+xG9XPCKaq9JCMY+Ozzw6VqXECwevE=;
        b=e7SGBzbszO5PMICXZAA0IVk1aLPr23jkzobdLVh0LQqGlIDNEtc6/aAz0OKignM67U
         /84Ta0InrYjwWbJCSaq537pIAThsebF3QTBuwJEJALABFi7vcABtq82Yu4KFRlm/dXV/
         ltcjxUHpqkjqmyLy8j/zWGAb9S0JOgrWPewhonIflGAPxspR+sidNSH8bxY3NfTfBaOq
         bPdW2IOv/5MwA1IVgm2nyHJ/+Az8Onu+f69RdUKk+HvigrDDQd/NYa8OV3IJvth+TloK
         Dizb8oDWEOQ5724stzKK2jPjkoRMQZMJ/LH0MridOI2cFCJwr39MnJDbEG5ag9w5bj/J
         9L2A==
X-Forwarded-Encrypted: i=1; AFNElJ/RbGDIWLmgRAEdJUnt270x/uFyyNglwiCShoWsXaedzrnEiXTVgXrIQMuIqAqd/IRTSoMRcC7VzyP9APj7gtVqtyvdMKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7xmMqfsdOY+g8fZytEi3NWH5SCpQ6Rogybv+Q+cGpz6PNbSWZ
	11trJDJboEwQR2l2UKcwCNOcIUhdJ6cja7XHvxAVFyQX5nut/XzB2qP+ZZXPrnze5PMV0lAX+sk
	G/7PIBFO/SwDRDJGbBswMWxWJYMSwP6E=
X-Gm-Gg: Acq92OHB/V8sqAZbDU6QZ5cp2SYkqIvpKGcuh8KZHsSNQxQH4eoq9Uj+1fihRJIJ+ts
	Ea+12/Mc00C1UXpUScBc7f6UQiSavjNpDACQRWDeGNowumf2FRChlCT6UN3RamVyG/9WLLv5tkD
	Udmy4OjCrp56M+p1PtWUW/Mlol1vKxcpM2w8+03mt0texbo4Vi/rgiROAD4IGdUa+aP3R0L3rto
	b8hEWteEWYbvICeVyOgByPgCT/Jd+WQWDljyUL8NMFqxbFDT/M+FYPBpeEodOUCc4zQXbM2KJp+
	W7g9hzk/fL9TbPyK8JoPZrfPY332zmsgZpMb9t7kgd8m2Q73YGIdCOgcMkjdF0KdUnSH8vJl9Hz
	tv1gls063DERl+k2eMpBc5gA4
X-Received: by 2002:a17:902:ced2:b0:2bd:7684:34b0 with SMTP id
 d9443c01a7336-2c4105092a4mr43638605ad.15.1781277636625; Fri, 12 Jun 2026
 08:20:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260611-b4-rfc-loadpin-ebpf-v1-1-11a6c8e6170d@outlook.com> <20260612000825.105100-1-dwindsor@gmail.com>
In-Reply-To: <20260612000825.105100-1-dwindsor@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 12 Jun 2026 08:20:25 -0700
X-Gm-Features: AVVi8CfjbbJ9NP2806R-zYhI-lIJTK8hbauQkHIEdP7hO_raPyV_nSTdTdG6xJw
Message-ID: <CAADnVQL9CJMY9h8haj5+99x-0GmiaHv3wDWuZ_YCYETKTznBbw@mail.gmail.com>
Subject: Re: [PATCH] Add LoadPin support for eBPF program loading
To: David Windsor <dwindsor@gmail.com>
Cc: alex.roberts109@outlook.com, Kees Cook <kees@kernel.org>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, LKML <linux-kernel@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, KP Singh <kpsingh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 11, 2026 at 5:08=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> On Thu, Jun 11, 2026 at 01:59:10PM -0500, Alex Roberts wrote:
> > +static int loadpin_bpf_prog_load(struct bpf_prog *prog, union bpf_attr=
 *attr,
> > +                               struct bpf_token *token, bool is_kernel=
)
> > +{
> > +     int res =3D 0;
> > +     struct file *exe_file =3D NULL;
> > +     struct mm_struct *mm =3D current->mm;
> > +
> > +     if (is_kernel || !mm)
> > +             return 0;
> > +
> > +     exe_file =3D get_mm_exe_file(mm);
> > +     if (!exe_file)
> > +             return 0;
> > +
> > +     res =3D loadpin_check(exe_file, READING_EBPF);
>
> Why are we checking current here? IIUC this will be whoever calls
> bpf(2), which would be the loader, which would then be able to load bpf
> programs from an untrusted source.
>
> In the kmod case loadpin_check() sees the .ko itself.

See sashiko comments:
- [High] The LoadPin eBPF trust mechanism can be trivially bypassed
using standard system interpreters like the dynamic linker (`ld.so`).
- [High] The LoadPin eBPF trust mechanism can be bypassed by a
privileged attacker using prctl(PR_SET_MM_EXE_FILE).

and the bot is correct.
This patch is pointless.
