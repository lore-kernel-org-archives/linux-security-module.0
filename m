Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27576390C8C
	for <linux-security-module@vger.kernel.org>; Tue, 23 Jun 2026 03:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782187156; cv=pass; b=qfWii1pc+pNwVbGug4T5fcwaEEEbITykmn4a0rdAORiEII6x8agBSEJxyKSmSQt4cbzWlfmi08/f5AESdn2mdhCZRHBJg/jbKZGRkUYeEKIK6Z5zk6pLpOYh9tDMXyfNH793wNYUMTsWdQtLdJVM+1JAFYB1O7ESTDV6cBv4JuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782187156; c=relaxed/simple;
	bh=gG3nM6GM0xXcee7k3sO2+otJiw1n1BGZCjCkgApMqe8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q0r4zgPBTYW8D7E7N5OvtMW8A6pdauZ3iND4QdPXaPc4ocwci0m3+OCtR9UlqebiA1AZ0eKqG9gv8TtOvHmUv/+6zUTbOfRG43H66jMDhwbKhFp13zSv4+C1tOJ1zQqMAVRrYn60gbmP8OXiYZRFlflFsyPwjvs722F+r9HWJQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ayc6Yxc9; arc=pass smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ayc6Yxc9"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2c6c101aeafso32713255ad.0
        for <linux-security-module@vger.kernel.org>; Mon, 22 Jun 2026 20:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782187153; cv=none;
        d=google.com; s=arc-20240605;
        b=TQ9xSIO5sR/gCxQifHuJkWX+rQfYPbPm5XUyzRm/A/Rkt0msMRjz3ZeU/ZsYhBU2S6
         x5ouE/gdHPbRjp45M9SBcOhYK9Cu6ULma52hFtdcSPktd/+BvdvoixoHV2rzj7vhHPuc
         MMbcZKre4C8mt35yCkjontjjT5gBly1CKbDjd3zT1rn3NH1wNEgUXd0CM7+irIbEF6Be
         /3Vh2HPey2CkP6V53FKQRLa80c1tN6Nj9wVXdZm3Qsg6LTBC2YblLSq4ZM1l7jmXTZaO
         j9D5F4ewwCkep+DR8MCdgv4gHQYHBpOXsPBHF8HCYvxvnUuHjXxKszPZ3kvrHJzKE2Nf
         eZIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        fh=LCG9jfnKYrjo4lXu5LZjB5ovxrMz6AFocujmKtClw+s=;
        b=NK1PUoVAAbMG4p1aVps2rDazC8NuxNL/nopMyytLUivGKj72Nr8wr8a7vHiMtadFBZ
         nBkjweJ4o9xE5ctBRDSI+bfb82ocLsZsblpv/3XSuq/Du4hXwjV2PThiL3Cvp5hZUH26
         UivTmck9SBlnxPMpz+9QR29nmoSCDj6ba+GOyJXkDWcdntme/YxUJcOR4HnO1SJEdUbU
         og8hQqDlhY1snjuW8ELFNcq+ELysy8BrdPMyB2bBTYzMC+uU7HFl6/I1Orw1bDoLkptt
         FiikM+EWwIHlrsbDH46qYNI56+A8pW4evUyjv9b+Gaoil5jJUmAiEsGMNUdPCccozQF5
         WVkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782187153; x=1782791953; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        b=ayc6Yxc9BZ+MZUTfJWUjsUjR6/AmNZnL8Egi5GytMU1FqCvZDNwOE7s9xkQgfiztdR
         nn4jlG1gEP78vF/wMFDw8ZTiKMBvy6GjmBy58WtRFUjFfG2V+u5XAAY7w46Umife8eo4
         qgQIM+1syaO/b2udQFkxZ7jSfGNGACFkI2L+6E0oZqfxuHmPaMTbJHenO6rubQThlvf6
         IDKcvkU59HSHmQBC4k2UWtPEk2TmMMqqQhgwttGAdhfDFjuCbbnKbl/0gH7QzexsqcgP
         d0WhSZcBajAwY5rIT2/lcz1WT6GLNYVvfcU3GF7DH7yfScHes7q+viapvK0ytMpyzOXI
         YRgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782187153; x=1782791953;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fv4+YQzwW9vJ3yUowssNEEOn5d5CfHMnYf5q6sRM4Aw=;
        b=J2yvEk5qvLwWJ/r0Apm9H2b52Yyu6fQAyPwMO1y0DvIDxTmbEqLsKLF4oSToTpLeC4
         vl1aeLgUYayG2A+R01HEP7NnwQMvwGO1HFxLonicWMZov5bAq31PVknO4gBjAfE1k2ZG
         1XP1pW1CViiqZWXbiciLxyPXcj5rSxSSEpaVNkxdIIDElunpn8UEc76D+cQN3cm9oBPs
         AhyhMXoJcap0oz2DdE3S60wtgiDtU13+DujM4DjiWcP2CW4aBrrIluFHGJ4EoM4+lver
         8Had1f0BlqZOpIBJHy0K1aV9LxS8gvDn70y6KEXyXIOzU5mwsWTyl6iRJGTFkQ7G2FUB
         GF1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq4gvthM1zFLowkqgPGxzVD2M1N3EXEHYyKrYWZQfHbdKROZww/qE1im59tJ0Sbe053bvKMmEH4np4S5reZloLGoVWRfM8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygKcxBXn7/az9d+HqeKBzCVGmE7rozRSTGpzo7iQtkscaz1CH+
	pWAOkGfPWCBKGamWfXnjTXhGayZu2q/KgA9d7cZwWBFA98zCje3jBkRTjRYJVdWtyXl/BMzUOxW
	OnqK22B76OlmV6S1+7vmpdktHeKkGwVQ=
X-Gm-Gg: AfdE7cne/2F8Gz1AfDhEmr1yaA3Ti+YWaLD/dM89A6Ezll7Hsuse1+9slxTmwbTFLbe
	auWQqDSzy7OCrsaTAUfMJhmc8s6F7Is6x9X/IJoNunfoPQmnJV2cgZtbknAo18wPG4N7ca/4UiZ
	baH7sHAoJfbHy94UBwDcnQCBlwb5pOafi2BtSr/TrldsPmw9+IB7jIW76elWxltMg3Udrjtxen+
	8w4vlqy2HFlgBvXTfzkx2XDlai53Bka2P8k81s+TNFXlp76jIsWoN8xjl/tCXaRS1E/ODFnaRf4
	HX2UzYjvHbP8DWxPYlhaxLB8uSKkDKn90OuXQQXegoODmaLZ71qGW59u8lAgWFA0XW1W9EU/qES
	SoaYRjA+iVxjRag==
X-Received: by 2002:a17:902:db04:b0:2c6:bb31:4564 with SMTP id
 d9443c01a7336-2c7c9ae9c89mr6495325ad.34.1782187153306; Mon, 22 Jun 2026
 20:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260618203411.73917-1-dwindsor@gmail.com> <20260618203411.73917-2-dwindsor@gmail.com>
 <DJFZGYZFMN73.1799LMXW49WZO@gmail.com> <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
In-Reply-To: <CAEXv5_jVXS4JoExcd71YkXEE2WXPJ0_9STO-uCwgNF+Eia_h5w@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jun 2026 20:59:01 -0700
X-Gm-Features: AVVi8CcolJU9x8Dp8q7P56rN1jCQzLpqqLG-VPMeXHQRVjQ7aayUcNcv-uHuUCc
Message-ID: <CAADnVQJsdrL2RjxM4UE1WyWrT9KsprFP+=xLHRtFhUSccDqQcg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/2] bpf: add bpf_init_inode_xattr kfunc for
 atomic inode labeling
To: David Windsor <dwindsor@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Emil Tsalapatis <emil@etsalapatis.com>, KP Singh <kpsingh@kernel.org>, 
	Matt Bobrowski <mattbobrowski@google.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Mimi Zohar <zohar@linux.ibm.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, dmitry.kasatkin@gmail.com, 
	eric.snowberg@oracle.com, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Ondrej Mosnacek <omosnace@redhat.com>, Casey Schaufler <casey@schaufler-ca.com>, 
	Shuah Khan <shuah@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	Linux-Fsdevel <linux-fsdevel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	LSM List <linux-security-module@vger.kernel.org>, 
	linux-integrity <linux-integrity@vger.kernel.org>, selinux@vger.kernel.org, 
	"open list:KERNEL SELFTEST FRAMEWORK" <linux-kselftest@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 22, 2026 at 8:49=E2=80=AFPM David Windsor <dwindsor@gmail.com> =
wrote:
>
> On Mon, Jun 22, 2026 at 7:57=E2=80=AFPM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Thu Jun 18, 2026 at 1:34 PM PDT, David Windsor wrote:
> > > +
> > > +static int __bpf_init_inode_xattr(struct xattr_ctx *xattr_ctx,
> > > +                               const char *name__str,
> > > +                               const struct bpf_dynptr *value_p)
> > > +{
> > > +     struct bpf_dynptr_kern *value_ptr =3D (struct bpf_dynptr_kern *=
)value_p;
> > > +     size_t name_len;
> > > +     void *xattr_value;
> > > +     struct xattr *xattr;
> > > +     struct xattr *xattrs;
> > > +     int *xattr_count;
> > > +     const void *value;
> > > +     u32 value_len;
> > > +
> > > +     if (!xattr_ctx || !name__str)
> > > +             return -EINVAL;
> > > +
> > > +     xattrs =3D xattr_ctx->xattrs;
> > > +     xattr_count =3D xattr_ctx->xattr_count;
> > > +     if (!xattrs || !xattr_count)
> > > +             return -EINVAL;
> > > +     if (bpf_xattrs_used(xattr_ctx) >=3D BPF_LSM_INODE_INIT_XATTRS)
> > > +             return -ENOSPC;
> >
> > This check is good to have, but it's enough. No need to duplicate it.
> > More below.
> >
>
> > > +
> > >  static int bpf_fs_kfuncs_filter(const struct bpf_prog *prog, u32 kfu=
nc_id)
> > >  {
> > >       if (!btf_id_set8_contains(&bpf_fs_kfunc_set_ids, kfunc_id) ||
> > > -         prog->type =3D=3D BPF_PROG_TYPE_LSM)
> > > +         prog->type =3D=3D BPF_PROG_TYPE_LSM) {
> > > +             /* bpf_init_inode_xattr only attaches to inode_init_sec=
urity. */
> > > +             if (kfunc_id =3D=3D bpf_init_inode_xattr_btf_ids[0] &&
> > > +                 prog->aux->attach_btf_id !=3D bpf_lsm_inode_init_se=
curity_btf_ids[0])
> > > +                     return -EACCES;
> >
> > This is unnecessary. Only one hook will have xattr_ctx type.
> > The normal verifier type enforcement will do its work.
> >
>
> Good point, thanks.
>
> > > diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
> > > index 1a721fc4bef5..b41b02173e24 100644
> > > --- a/kernel/bpf/trampoline.c
> > > +++ b/kernel/bpf/trampoline.c
> > > @@ -859,6 +859,9 @@ static int bpf_trampoline_add_prog(struct bpf_tra=
mpoline *tr,
> > >       }
> > >       if (cnt >=3D BPF_MAX_TRAMP_LINKS)
> > >               return -E2BIG;
> > > +     if (node->link->prog->aux->attach_limit &&
> > > +         tr->progs_cnt[kind] >=3D node->link->prog->aux->attach_limi=
t)
> > > +             return -E2BIG;
> >
> > No need. The check inside kfunc is enough.
> >
>
> Paul wanted this check because it occurs at bpf prog attach time,
> whereas the one in the kfunc is at inode creation time.

Sorry, we're not adding redundant code to the verifier.
