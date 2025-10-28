Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2272724BC0A
	for <linux-security-module@vger.kernel.org>; Tue, 28 Oct 2025 01:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761616225; cv=none; b=UvBHS4pYXew1EmvYO+maLOCWCMGeFnylbPKytYt8k1P6jCfCbOx/gKtekXpohJQ0ioeSp1c3uUpXyKetFVl9OaDAtDuPea1k6o8VAXpDzccv1j9630XS7cNrBh8nbu4MeE2sJVsHYYseICr8PtywCRTVAC7JyHoqyGeXi7OoHEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761616225; c=relaxed/simple;
	bh=egI9YqNPe+9Ospz/laL6gjdZwfp2mENxEK9oSkrWlg0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eFvpIboDpq/00WlAYSz9jzb2Ksu7uTpr1frJN4oD/bT3GGqVUZmJB6q9IWlXQp9VeE0h4UZs+VQ9dQmCdgq4/d3f1gW2R2ymJD4i8yWvGKk+ScaDS1Mf/LWGQZv+taT+4hhMwIrjYMiScdnhH8hGqIPuj23b/v7SpZiC5xC+lWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=DJNInhTR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="DJNInhTR"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-330b4739538so5458890a91.3
        for <linux-security-module@vger.kernel.org>; Mon, 27 Oct 2025 18:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1761616223; x=1762221023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uqWsER2lvpM1BFwi97W3jPbnbI+DdhSgyhsiCuGVeQ=;
        b=DJNInhTRi+VwGwYhOqJfNzQHCsrxYfwuZdRXrTKDIZn5n2OY9c7Jk/28Yjj9gAM2wW
         1Hbo0yJvkW5H43hwXZ9bZzcPbIuGYlM1s+JJN38oAJ5nRUFd7IZ7Khhd0K69fRBo0Vnu
         /yIgNlb8SDKNAS9LyoVA+nEXxd1FYaRdmnKtmWnizWIMmD3mQBwErCT7lGtVSlJ1EbyY
         HFVzra+USkfttjasQvA2gCNj2wL4DFbFUGgAnytb/wdHhorJ48sGkJwbtzeHeH7amArY
         E+iL7LLpIqtA8Mdm4A+efLco3F5NdGSdcSUYoi4co3U05n0+OaVs2gqsUKUfUN4IRA8e
         fVhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761616223; x=1762221023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0uqWsER2lvpM1BFwi97W3jPbnbI+DdhSgyhsiCuGVeQ=;
        b=K0e1Y1zrTM0K8/gAzBrpbn8k4cyZ5FLk1yiJs62QiFbah9VDvzmBMFm2NO8cB8P76+
         gAxp2IpQRT+xPUDkpHwt7NitBkNi+oHJvuaIMaNo+KE8YDxMp+Ktg2xcgCTjGJBC9YVD
         B3zSE3DomNCMlBJMCcUZCTo4ldd04905FNWAq/VQ7A5a0XilSr0oxPWXXOw2fPXGTzfw
         mt7q9b1vAXwLDwMuHOoZRDcJrG0Zbpit/Bfd0vXZ6tOZq2xYzloOYb5uNiBvUsEDgGWK
         6kPizibnzhLhlSIe3uFLTeG+4rd9pAqBsJUq2qW3wjYnhxtSUiVg2S/KMWLp6pPZAQRK
         +FLA==
X-Forwarded-Encrypted: i=1; AJvYcCXxoTvtbp+lJiUzBTak1d7H+BB/OohrPOjkwZ3rLWlL2yeKBkhRVVDqzgjkFyJk0bv9p9TLC4JjPHIwp6o9lkJ1qHKszkg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXLSwDUAv694vnXNuItTsSrx7/e7M0OzUsHwy4uAo3IuacMSWl
	N7ufFu7Zo938jLZIhY7lBBxrJmUF9NynlWtYMY4Wenc0UiTeSJ88TAiwESsRSj9c0Q1L6c0hxIq
	TVuRBamNb4cBwzh1HMMjtbN/CesDOrKMjr/JcNoHX
X-Gm-Gg: ASbGncucBzEhLpp9S01ctUw4MLu1NEOA+Al7QaHeIfHd5lan5dGAv55Cso2AYCK8NAQ
	XGMeOOdxxZshbCO74Ao8vqHC9zB9cQMYC1C8QAH2GIIMtmkWCWGs8bUBslpnhvZEwfA3gtOqoaN
	BoB3rfmTf5DmUU3RO5HmgoP6RB+Hsv09Hr8uxYq492I3hE9r4evfdxZrcQWsWzFkVVSmMQcW2B2
	xJuwcFyXmZ8/HjW3toVTF6Bi8slCRxoYaltcXVJRhV+T73pddRNhbM/uxnC
X-Google-Smtp-Source: AGHT+IFIcd+uaOxgvUBNoN1jswBfv9wR75xnyXOcRVREkUsbREllucHhYo/8m8rqI1IihjpMqJ8++4byeibL2ds9fH8=
X-Received: by 2002:a17:90b:4f81:b0:339:d1f0:c740 with SMTP id
 98e67ed59e1d1-340279a5f62mr2127114a91.1.1761616223299; Mon, 27 Oct 2025
 18:50:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251025001022.1707437-1-song@kernel.org> <CAHC9VhTb2p3DL_knRgFyDv396BwH-KhwR0cBhqLQ-KdgcA1yLw@mail.gmail.com>
 <CAPhsuW6O96aJbZptVY754tQ1-C_JtH8PwS1oZX6a1Tch7ehEkg@mail.gmail.com>
In-Reply-To: <CAPhsuW6O96aJbZptVY754tQ1-C_JtH8PwS1oZX6a1Tch7ehEkg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 27 Oct 2025 21:50:11 -0400
X-Gm-Features: AWmQ_blXtmJiRO5K1bqpyuAPod0MDG6LK8RiElIaQpVZH3OFxc9EiJ_KCQvr22o
Message-ID: <CAHC9VhRzjkTSUPS9odXRruAuSNbv44Atxj2sreQgcVpDu5pL-Q@mail.gmail.com>
Subject: Re: [RFC bpf-next] lsm: bpf: Remove lsm_prop_bpf
To: Song Liu <song@kernel.org>
Cc: bpf@vger.kernel.org, linux-security-module@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, casey@schaufler-ca.com, 
	kpsingh@kernel.org, mattbobrowski@google.com, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org, john.johansen@canonical.com, 
	eparis@redhat.com, audit@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 27, 2025 at 6:45=E2=80=AFPM Song Liu <song@kernel.org> wrote:
> On Mon, Oct 27, 2025 at 2:14=E2=80=AFPM Paul Moore <paul@paul-moore.com> =
wrote:
> > On Fri, Oct 24, 2025 at 8:10=E2=80=AFPM Song Liu <song@kernel.org> wrot=
e:
> > >
> > > lsm_prop_bpf is not used in any code. Remove it.
> > >
> > > Signed-off-by: Song Liu <song@kernel.org>
> > >
> > > ---
> > >
> > > Or did I miss any user of it?
> > > ---
> > >  include/linux/lsm/bpf.h  | 16 ----------------
> > >  include/linux/security.h |  2 --
> > >  2 files changed, 18 deletions(-)
> > >  delete mode 100644 include/linux/lsm/bpf.h
> >
> > You probably didn't miss any direct reference to lsm_prop_bpf, but the
> > data type you really should look for when deciding on this is
> > lsm_prop.  There are a number of LSM hooks that operate on a lsm_prop
> > struct instead of secid tokens, and without a lsm_prop_bpf
> > struct/field in the lsm_prop struct a BPF LSM will be limited compared
> > to other LSMs.  Perhaps that limitation is okay, but it is something
>
> I think audit is the only user of lsm_prop (via audit_names and
> audit_context). For BPF based LSM or audit, I don't think we need
> specific lsm_prop. If anything is needed, we can implement it with
> task local storage or inode local storage.
>
> CC audit@ and Eric Paris for more comments on audit side.

You might not want to wait on a comment from Eric :)

> > that should be discussed; I see you've added KP to the To/CC line, I
> > would want to see an ACK from him before I merge anything removing
> > lsm_prop_bpf.
>
> Matt Bobrowski is the co-maintainer of BPF LSM. I think we are OK
> with his Reviewed-by?

Good to know, I wasn't aware that Matt was also listed as a maintainer
for the BPF LSM.  In that case as long as there is an ACK, not just a
reviewed tag, I think that should be sufficient.

> > I haven't checked to see if the LSM hooks associated with a lsm_prop
> > struct are currently allowed for a BPF LSM, but I would expect a patch
> > removing the lsm_prop_bpf struct/field to also disable those LSM hooks
> > for BPF LSM use.
>
> I don't think we need to disable anything here. When lsm_prop was
> first introduced in [1], nothing was added to handle BPF.

If the BPF LSM isn't going to maintain any state in the lsm_prop
struct, I'd rather see the associated LSM interfaces disabled from
being used in a BPF LSM just so we don't run into odd expectations in
the future.  Maybe they are already disabled, I haven't checked.

If you want to keep those interfaces/hooks enabled for a BPF LSM, just
keep the lsm_prop_bpf struct/field.

--=20
paul-moore.com
