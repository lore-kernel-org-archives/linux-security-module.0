Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB08E299949
	for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 22:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551623; cv=pass; b=vDeVklEWRloeBDDhMtt6ecg8ZcgjttyWTY9CY18SIoCENp34uMYJTwAoAvl8gefqCbSHUnOgqXoIhZPP4WixFkiJjsDWDqhhxNFHX7eU64PuPfNGJOfqsIxvpXi98EBBX4csigPM6BBvaseVmGxCIC1wBh/c1f/L9y0FeKesook=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551623; c=relaxed/simple;
	bh=XKfjnHsBZAYgJApNq6t6VLNpHjKp5fSp10j9/3sDWYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rPer7nkZces5PzUvsMneTTx4ervro2Y/WzAc8Y8gOnkcBtwSd2IVAYBOpw7o/bGXdVB0GWGXhdNXoQ7pC4o7ERrwaMEpAKhuvRgVYyXt9O6KhcJVyijYzZTLiE30cQVCXpQeoId8pojzbRYi24d0586zsK7rhAMdh7FNPs9uAV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=LhtTuf5R; arc=pass smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="LhtTuf5R"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c47ee987401so107776a12.1
        for <linux-security-module@vger.kernel.org>; Tue, 27 Jan 2026 14:07:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769551621; cv=none;
        d=google.com; s=arc-20240605;
        b=dcH851O7EGPUeQDC69zay0x5uOk/PN1SGrpopBUsRmcLsIh+AugFjDVZMo+a729Do6
         svpi8cbBuFKIJ7ecUx44urhKjoASKpg+9+SZb72K01LFz3+jGBzObmcTsRVE+jZltOEA
         dWQIAIN/3VWSZGsoRjWQp/b+AjLXF15abF+ja7HcdNyItlOnEwdu6qXdEOJ8Mqlq7Gem
         ebA2nSiD6JaY8z3kdNSbanIvEgCQaszsX8fajh6qpfpLLF1BCm6uwa7/ZL7JypDkAfTY
         GeCJJdol9OdNUKSaGi8UByOxOI/hRyc3GM5zk877FqVJqBp6FbOS9AbvHcuZ0jYvk+B5
         Uqvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZE0HZ09BWMy+Q/V9UHBO/lkHNdcHXcIuvBmx4T0PBPk=;
        fh=1nn3FWa7Iiykrthtw1vHT374RtjYFUGXodV2BamQ8e8=;
        b=VLBzbck+b5sf7oni/KhyWfwq3qZfLlN7P3PCMScqzH1SfF+I0M0i3THo9HU731z7gv
         wR4e+SpbiAVCGaQHw3wcvdIDvbjq7gscRUIsI5zoHkJtzHAmWhSb43cGABMTPYyUi7hJ
         PUK4mNCCEU4Ejdyrxd4a//TF9EX/RJb3FH07PQrvOOUys3nb44LpwHnAg7zAoMr1CRGm
         dQeoAUxzjABrS/ZrrX2ZHNfagwJp7TigQ4SUNfXK5hBtDO4UKXLzH7ZrSgPsOa6NdsRR
         1qHmCkFjZXl0y4sKLMNn1H/GuSN17iiQnvpC9/7Yqx2swKLtFLxzdvGtMuxMJBm9/B7V
         Mt9A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1769551621; x=1770156421; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZE0HZ09BWMy+Q/V9UHBO/lkHNdcHXcIuvBmx4T0PBPk=;
        b=LhtTuf5RUDlpqAv5u+/zkhzGd0Hxb6pivngVsQMBjk4UhC8h//Xe1n8gW2DWsySgiI
         Dm8OYBRjpMc7aSgsO0xqCubEx57D5gjKZv69WtLFtLxn8/cI93roN0b89R81zApTcSMm
         JgPVR5ljI5qus/3mKrFQ2ci8U7J1Lz4ql/oVNEg4+Kq8SldEOzaObts/nosoFi+OsIpJ
         TTzAa+VXC62y1BRwV8+taXqaD78gjIf/0qMLoHFwxhCWu5bHPEQiTOkaRoLiDaJMfYGm
         7PXfmc/Fx9ZYIcT/HA9b6bFsgqdqInwsFXWnejNDmb42gG8zecV4u5/Gc26jV02DcodI
         C+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769551621; x=1770156421;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZE0HZ09BWMy+Q/V9UHBO/lkHNdcHXcIuvBmx4T0PBPk=;
        b=Kq0Nl6ck8wyg4Wl3h6AC56Wr54cOT3uk/9N4gi0BZzAtFyHZf5rToTeuYeoNKM6J+/
         Oga0t2F0F2woxSnFol4BccJS6++o5U698BP4czy6HueSRXoN4zq0AxOcMaFVUPkGoaeH
         R7cfleerwcGSD2UXDT73r6BsR7mUnbCtUp9HJJCmKUyCyyS/nK16z+yJNGllmr7miEut
         uH1fq8HAV8GtQXtEq2JWlmEI1mC+Bdie8WSBpMiqZocWdewuPANIXTXw0WYuhkddolAB
         yzGWLnGnei5J4umznBjCFXSNQaN4xk4+sER82C9w0bi+tvv4DnspXIyZfNFnhOTLWwxH
         kIrA==
X-Forwarded-Encrypted: i=1; AJvYcCWH2m0vR9RhqXretjR5SeBTrU7rvhDyI2pnQEV8hnksKe/cJPB7jtKM1dKywXThzU/x45ApXL3zHcRWp/4TtKI4K9N95Qk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXiCo/wVYpXGUEoD3aXpL17GhT7ty6Aoxnnnh4ZThD78lOxMzP
	ZcIihFOZMRvPI7qEcQziidqvY2C0dTF3p6dgAED7+kkzOg/uXvhqyKDLUU3958Qm5TmLx6Qip7L
	6zTZ9CXS+5OunxHfcyQePBuKEMVMCcOio73vLUzxm
X-Gm-Gg: AZuq6aI2CjQRVNbtb5yMzySld8XqiDy7+hq3Zhd1qTVPLNl+QhwUEq3JMD/p+JrTvSP
	cQknAMuNeTxlM3ZGdecJYx7J3/QZCYtuBCrqEWLqEPKrvDl208F61X2/hQ+GFYbf7PBsAc+ANEG
	bpI9kUSJ9yPzswEvmAE/ug+4AMuSTtoCk4QwgYCY99I3p89IcaKeJOBD0X/KbY6Wf0C+4gcC5jK
	uO55XQLmxMK5g5kCnhgH6uQZHvFhYceYgDgFNqTvFSUEM6GPgFOK+wZSxbTLoUeHaYUAJs=
X-Received: by 2002:a17:902:d588:b0:2a0:b432:4a6 with SMTP id
 d9443c01a7336-2a8712f2a71mr34602905ad.15.1769551621104; Tue, 27 Jan 2026
 14:07:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260122141303.241133-1-omosnace@redhat.com> <CAHC9VhQYLJVweDgBkRo=0_kS1TAUQH_YfT+woSfBW0SjUO4nqg@mail.gmail.com>
 <aXgcd81ktMaAHhwj@mail.hallyn.com>
In-Reply-To: <aXgcd81ktMaAHhwj@mail.hallyn.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 27 Jan 2026 17:06:47 -0500
X-Gm-Features: AZwV_QhrzCWyWyOCOztscIRZCxotOlDxZzu489IoZSksCt0ceKp2sRAbzStURrM
Message-ID: <CAHC9VhSLi2-TBUyayML+tAuC+XF7jCAAL48oCB4qQqTrGXcMyA@mail.gmail.com>
Subject: Re: [PATCH] ipc: don't audit capability check in ipc_permissions()
To: "Serge E. Hallyn" <serge@hallyn.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Eric W . Biederman" <ebiederm@xmission.com>, Alexey Gladkov <legion@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 26, 2026 at 9:01=E2=80=AFPM Serge E. Hallyn <serge@hallyn.com> =
wrote:
> On Mon, Jan 26, 2026 at 05:50:12PM -0500, Paul Moore wrote:
> > On Thu, Jan 22, 2026 at 9:56=E2=80=AFAM Ondrej Mosnacek <omosnace@redha=
t.com> wrote:
> > >
> > > The IPC sysctls implement the ctl_table_root::permissions hook and
> > > they override the file access mode based on the CAP_CHECKPOINT_RESTOR=
E
> > > capability, which is being checked regardless of whether any access i=
s
> > > actually denied or not, so if an LSM denies the capability, an audit
> > > record may be logged even when access is in fact granted.
> > >
> > > It wouldn't be viable to restructure the sysctl permission logic to o=
nly
> > > check the capability when the access would be actually denied if it's
> > > not granted. Thus, do the same as in net_ctl_permissions()
> > > (net/sysctl_net.c) - switch from ns_capable() to ns_capable_noaudit()=
,
> > > so that the check never emits an audit record.
> > >
> > > Fixes: 0889f44e2810 ("ipc: Check permissions for checkpoint_restart s=
ysctls at open time")
> > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > ---
> > >  include/linux/capability.h | 6 ++++++
> > >  ipc/ipc_sysctl.c           | 2 +-
> > >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > This change seems reasonable to me, but I would make sure Serge has a
> > chance to review/ACK this patch as it has a capability impact.
>
> Acked-by: Serge Hallyn <serge@hallyn.com>
>
> Thanks - looks good to me.

I don't see a dedicated IPC maintainer/tree, do you want to take this
via the capabilities tree Serge?

--=20
paul-moore.com
