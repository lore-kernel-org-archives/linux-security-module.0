Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20931716D
	for <linux-security-module@vger.kernel.org>; Mon, 14 Sep 2026 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789352667; cv=pass; b=S1pV0mgEl3W8ov8kP2XScdFhY5xBQVAcRgpU4wtHAumaZkoGs8h4f36h6GEbD6F0F3xyI0MWNQCoIQ/QczO2QiIC+y2dK01HUP2WMv0DY/m3243dSdH71wVYlqal3ecgAAKdRB1wa8GPFmrxSClH4/acVwELip2wBxC4gbgHA7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789352667; c=relaxed/simple;
	bh=tr92RxUfetBUYnectTORLM72uF0Ccm/8PlWorGu06k8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T14OK/sUktrdGKuu6ygADu67IFh4sVht2QVABVD6OmSjpN8yhDH0p78Stxm17mwsMdZQUyr46ss+llXqFaTI3BTEOdpVj6aAaw5rGTmd9D1wsHddH1CpAKXDg6fcRpUpEhS6A2YtTWk6nf8LY/rQ3jtnFbb97CV4wM1ET+ZL0mM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxefRYVc; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxefRYVc"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-86a25369f16so2101422b3a.3
        for <linux-security-module@vger.kernel.org>; Sun, 13 Sep 2026 19:24:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789352665; cv=none;
        d=google.com; s=arc-20260327;
        b=SaFsy7ey7O272IWT4uF/LxMgGc3uDbUsih6dDBGNwaIhutpA8JvX5AD6hSkbBC2Nhm
         4rjvgsIbPNWTTx48U3PrKF+Z2CLOQrmJT7bUCiJGnAO990Ckj+6LVVGYv2ILneoslkjV
         1h6BeE9naLw/dzIxOaiP6P0zQIX6gBJR8Nw5sbMhY467ndGRQ10x7/VP2mOWmwZIdlZt
         SZwbxEQVThHU4xmSIXuECCauOwdECGgO+1cPSPyPwYHCYTbLf2k2zmWwaBiB4PoQp3AY
         Q+I5J1e0sro758LntToUdhDewwJ4oeRVpIBqYRA8VczWdlJVttVu9UwLbOSHTm0xO7mY
         SAsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=robbY/RJvD+ycB/sUyfcCcbZu7QGUhf6dyHtU9h8Jsg=;
        fh=u3eAUB51BDeC4HlfMbH/xXMc3O67FgE0B5oZWIkBOVw=;
        b=TiT1fNXjTV8LGsXgo5RR1PkVnW9wRBOZJAs9JBN2K78MiGbG5sk0fzNfcYGyGPOzcT
         tlXjwow/olzthmrQfr0sShDwjnjKsaJuIcuiUeoTln+5jge9adod5rXL7vug/oEMRDvC
         ySnHA8Vc/iPqCKfvP2HQUNNJ9hwurlX8AZwav01lPTa8RJ+Wbi61/NBS38dtZ+1bkWvF
         32FN4TQnZXK6UgeWpZG1C7Q91u4f8Pduu06MJLad8bu4agas/BDl2S5QhxT/8lS0ZbNS
         Wd/ZV72Tju/HGixiF0+kYkcJLfxVwQybBvHDrHadiLbcaxt2GRve8506U8CYclGLz/ge
         JUyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789352665; x=1789957465; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=robbY/RJvD+ycB/sUyfcCcbZu7QGUhf6dyHtU9h8Jsg=;
        b=cxefRYVcVolJqBSAHxTT7ytIlBcVR/yupayD6e8vgXDHIfSjHnzZLl5EGG1RE0K+1a
         vRfTAvTGGm1zjOOzer8bTitRH40nkprMil9toRIt6h4lqZv8vmIrY8Jg0iNAWFtCbqUz
         SUuqbYD/7huIZp4Xf5yKSgcjCbUM5VetnSiHLThNHL9xOcw+yYFW7EBN3cYBHWXKdsHf
         Ep1eAC4PguvLiTT2mN/0lDgdSjRLd3SbiRaa9cbQ6ZjT0hYqKs9aMBZ/rLAeZ4cDKin1
         2ziMfEBx6o6L8lQssQHjFCwloTJliFCcsHUi2jS8Oau36n1EdkXUXp8QLIkHDReqARfh
         ayeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789352665; x=1789957465;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=robbY/RJvD+ycB/sUyfcCcbZu7QGUhf6dyHtU9h8Jsg=;
        b=ARo5yFzchCdE0xI8jQTD9Ss9uJ/CU/ZpSHHTtZtvy+LN00kdw+JhGJkq8HUSmTPleU
         00X1tY0j1NO3AHQwxVl5qrwwW724m/utn1m+EgxThaj6MGd7qt+i0s972Un3qR3JKC9j
         PkyYJSbRenDJDZ8+esI+/pc2IwqZyCmpI84K+OjiPylQ7x56AAua0pltUkon5k7NMKyy
         W74VtTATgkVg0miiSAFhrEMl1xyyjigr7/zgRdyY3lk3erOp/bqLRvDDvecoY2ShSmNr
         xPkJrbPdBMpSII6dBPd3y16VfeaOfU2w7m35qOWpVgDRD+kzoC3nH1upJakrPgUso7K4
         WhDQ==
X-Forwarded-Encrypted: i=1; AKwUvBwE5+qLDK2eyVYglCna04ZpQWF873Pp1RYCGfxf6xQH0pFWmmDIwpuMsJUAue7+bdQDavekYtejQmASW2UiRFaKkftf8t0=@vger.kernel.org
X-Gm-Message-State: AFuF++kk3lRyZVFwkWKtEJKXVumeJK0glbwk7b/cq6otRCdVCcmCp56Z
	G4NBrJD95sCt1UzaguHjAxcqFr5IfC+84tsdasad6zvkTZp3T3KCE58+SB/sbmih+xuVLzFOHwK
	vf2dA+BLeXUQTafPPxB7SftIG86KSWNU=
X-Gm-Gg: AYBFou2s3CKE+fAvBekzOrb1yBSnLCoB7m/IsVTp9701dQdkma5v0MJmByS2NjZuacH
	YbuoRpNAsS3gtO2E9O11z5j9eR0hAp/9vkv+5Cd4hJbhV3nw8L8ZbfjIvgxwg7ctgYQgGtCPcQY
	f7zrRNojoQQasoGjZGTv/ieYaNLywxke+L3maiLZlESuEZknMI1Dh+rxcQ8yq8q3tca9gDCLyRR
	ZcCVxYgRtfLieq/IcI+Atg70g6PwGW+k0qiEadBZ+uIxj4lrCe747IUnXGUwX+N+Zjpx5eDZ5Yl
	Hwgxl8oM3Aym+HUGeEUMOc22K3w2WSIFKMqmEg+jRGpQXsOxXf3StsMc2KGKaPBY1Ghu+PlIyS2
	qKuQNNjDaVRXtVzM4IXStuSzHUSUDw7cECsyMqAw=
X-Received: by 2002:a05:6a20:e290:b0:3da:6bdd:2308 with SMTP id
 adf61e73a8af0-3db4053d966mr790488637.18.1789352665301; Sun, 13 Sep 2026
 19:24:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909193719.518517-1-utilityemal77@gmail.com>
 <20260909193719.518517-5-utilityemal77@gmail.com> <CAHC9VhQHZ+ngFdzKqmnzBh341CGEg-jexu+QYU8=1qXK=u-x-Q@mail.gmail.com>
 <aqHUw6k0Mf83CGFT@zenbox> <CAHC9VhTM7emi9vxs+5Za8Hrc_e9dg7fZx+Z6BGUc4VQ1qhEAUA@mail.gmail.com>
 <DLD0VQ3D8CYC.3V5ZT8HDMY4IH@gmail.com> <aqTZdCz6JaoK16Fp@zenbox>
 <DLDL7KK3FZKU.17ADLLWJVXB5F@gmail.com> <CAHC9VhS0JckwfomqLTUJkZZkDSgeRXYOjMmPQYErgYynQYqMKQ@mail.gmail.com>
 <CAADnVQJCJjy9Eiwn6-88c0iOk4LfgPU6KBv+w0JZdBzmXBMUCw@mail.gmail.com> <CAHC9VhTh446SkpPF-hUiLYOHipuurzkgju_nH9LsRGdERSAL1w@mail.gmail.com>
In-Reply-To: <CAHC9VhTh446SkpPF-hUiLYOHipuurzkgju_nH9LsRGdERSAL1w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 13 Sep 2026 19:24:14 -0700
X-Gm-Features: AcwNN1VHje-1mlgyoqyzgACqg1pNN767AgvJcvGzVCEPYAVsQlnEZtYN4fUz1O4
Message-ID: <CAADnVQLZscKkCxvK5puuOE1aN8nW6PnaS+_dx_zBQjjP2T-DFg@mail.gmail.com>
Subject: Re: LSM boundaries. Was: [PATCH bpf-next v3 04/15] lsm: Add the
 bpf_lsm_policy_release kfunc and policy object destructor
To: Paul Moore <paul@paul-moore.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <matt@bobrowski.net>, =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, 
	Kees Cook <kees@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	=?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Jan Kara <jack@suse.cz>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Jiri Olsa <jolsa@kernel.org>, Tingmao Wang <m@maowtm.org>, 
	bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	LKML <linux-kernel@vger.kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 13, 2026 at 5:10=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Sep 13, 2026 at 7:25=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> > On Sun, Sep 13, 2026 at 12:41=E2=80=AFPM Paul Moore <paul@paul-moore.co=
m> wrote:
> > > On Sat, Sep 12, 2026 at 3:33=E2=80=AFPM Alexei Starovoitov
> > > <alexei.starovoitov@gmail.com> wrote:
> > > > On Fri Sep 11, 2026 at 10:26 PM PDT, Justin Suess wrote:
> > > > >
> > > > > If fs/, mm/, drivers/, net/, are permitted to have kfuncs, then w=
hy not
> > > > > security/? kfuncs.rst doesn't seem to forbid this.
> > > >
> > > > because fs, mm, net see the value in bpf. bpf helps these subsytems
> > > > to focus on their core technologies and moves policy decisions out =
of
> > > > kernel and into bpf.
> > > > while lsm people treat bpf as arch-enemy.
> > >
> > > It's amusing to read this when just this week we merged a patchset
> > > into the LSM tree for the benefit of those writing BPF LSMs.  If you
> > > look at the discussion around patch 2/2 you will even see a reasonabl=
e
> > > exchange between Matt Bobrowski, a BPF LSM maintainer, and me about
> > > the patch.  Alexei is obviously welcome to his own opinion, but I
> > > would encourage those reading this thread to look beyond his comments=
.
> > >
> > > https://lore.kernel.org/linux-security-module/20260904-lsm-mount-idma=
ps-v3-0-920a1963675d@amutable.com/
> >
> > And that's an example of unacceptable land grab by LSM folks
> > that I'm concerned about.
>
> I made sure that patchset was ACK'd or Reviewed-by'd a VFS maintainer,
> a BPF LSM maintainer, and the Smack maintainer before merging (I
> covered the LSM and SELinux parts).  You might want to double check
> your definition of "land grab".

You're still missing the point.
Christian could have landed it via vfs tree with your ack for security/*.
You have no power over lsm hook changes within vfs.
