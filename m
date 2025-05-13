Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24516136337
	for <linux-security-module@vger.kernel.org>; Tue, 13 May 2025 23:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747177677; cv=none; b=aO0pyKymunAaHryycoNIcW8WVUNYcjkYRrvLxC3iia/fM36faM73Jhn0hHVnJAptTJyp1YSPiwNkA6eqaRB4TKTl+DAYm5sCp55vZK1bdcAMcnPSj/GvNDHfXK/lfVAtQnJvnZiBVFT9xDw33WBr5jcZQ8IZjzMiDlEbsTjrhqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747177677; c=relaxed/simple;
	bh=3z3zk5nEwkdkXxKrLTyUiKBjpFVZOfep51OZ+gg+Cjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mx5FhBVRyzFCysfcKiZ4aX3PUnfkQ/KTpn7gqT4Lf0kDqCoJNCMMSiC9/b/vDx00Fz2m91R56KRe3nnqVVvLMapTeU+gjthZjvYx/l1dU3Yb3J6LEg/DH421DATUE9quc1NJxng/1APMG923I3zKw+TJmMoevxBwH3H6eIHCzEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=grMfeyn1; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="grMfeyn1"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-70a2970cb70so50290127b3.0
        for <linux-security-module@vger.kernel.org>; Tue, 13 May 2025 16:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1747177675; x=1747782475; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SLiRsf9mmaNyekeLjq4HRAp81aLdDloUOkxmHepBBjM=;
        b=grMfeyn1zHbkxl9qUVb/J/CBZ7y/CcAHMGpYJYo/E1qyrvvXX3MBWrBIvS7ginNXno
         X+wJddJmGjRyuzXYu7oJgXMCQP7nsTNVs+2OXcm03alTZ5CjZqJmpeQQ9fFukkUAQdOh
         tbN+weJJNQxJUdLDSJ3jESfd/D5QNTtkyb0qs718rxC9zgDqT/gom5rLXJD4AYetJ6N6
         EUhD0KXwyWiL+VPOU+2KWRCx46rTHqBwhbt/OM0UdM+GDlvwtyV6x/kxIpuoi+Gsdq4b
         7yNo51d4acuERdV5vM8QfkJuaGPAc5DqYx78hTFTVMg0Nd6cVJVHgou+rUhvOsfw5lK3
         qnaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747177675; x=1747782475;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SLiRsf9mmaNyekeLjq4HRAp81aLdDloUOkxmHepBBjM=;
        b=CZF1vpYWnH+6N6RryAGXhyacQowx2Iv5mfaAAozJWrURWJzTI4jQzEaBPx0B7giIGL
         lzZRC6zJ7BHYS7dUS4P50IijcxNxa5PGr2d3h6re5Q89+YOvH0yZShVKDhgt/3WJm333
         J0WEHlfyoMduOu7kO+O5LfBVpzQAZNIYybeiXmUjw3gyEWdoxRXeFXrqYSd3TmJAjmJo
         cs25zsq+ZA5cIKr0PNCx+jcfhbT3EpDn3QoGGiuxlb3ONYD7l6VMQkIKRQ4avXwMAtK8
         0KOI60jPLtAnoBlgj2Zf0dIUlwHyJNBsbJGl5w1Wk9l7HKXjO9L+e686Hol+t2V1qcQb
         YK9Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoA6Lgu6WyvGqyLTsUQ5apjznvH8XQTXk0Vuc3Kdvrsuo7lbBnYXXvzDz/WOCysz5IyTqcu+ivXJyH67Acfz2SPokz1aI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkGJh8FQmvhn5XVcbMKP5tdIrlGbls7qbYxlLVzjvK++nVa4V4
	AyJJ8y/DgxSoH5ixzxiMcioXzCMZ07eVCk0DfRC0jszYML2Tt/WsiviBAZRBcxYUptdDuPQhhTa
	Um/B8nmJsRZsHEE0jVjp+pzuixuf7j4oDOo0L
X-Gm-Gg: ASbGncvbWc5+fquOs6dElViRY0l0Za6viVP6xDa0LlvbgkjMz7nInt5DaFXj0PXcdgv
	5wdNCgQUq5ULGN1eR6Cpvq8onHt6DdS4rn5H+xDl93ggU3Z9viX8ZihdMRZ5S/QA1K2W38KOEm5
	xzOLnq4OqaHQPnG1uOskVDImhCcbGgRDBCzl8JK/X/HPs=
X-Google-Smtp-Source: AGHT+IGhTpj3O+FiLhnN3AWPcKuSZTnCWxc7WDOiqjDHrZHTR+PRISZuqqVr4/p0XzcrEiV+ZNppAndOSCDZ8ZRycu4=
X-Received: by 2002:a05:690c:6a09:b0:709:1bf8:f7a6 with SMTP id
 00721157ae682-70c7f2221cbmr21127307b3.28.1747177674988; Tue, 13 May 2025
 16:07:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250321102422.640271-1-nik.borisov@suse.com> <CAHC9VhSpgzde_xRiu9FApg59w6sR1FUWW-Pf7Ya6XG9eFHwTqQ@mail.gmail.com>
 <67f69600ed221_71fe2946f@dwillia2-xfh.jf.intel.com.notmuch>
 <68226ad551afd_29032945b@dwillia2-xfh.jf.intel.com.notmuch>
 <CAHC9VhSyz2MqMjnHFbTiMqYvhAFZf162ZabnSsyyCQEZj-V9=g@mail.gmail.com> <efcca734-2c80-43e3-b347-2af39f811502@suse.com>
In-Reply-To: <efcca734-2c80-43e3-b347-2af39f811502@suse.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 13 May 2025 19:07:44 -0400
X-Gm-Features: AX0GCFs5o9YdzJl9n7dGDDnhmYchki1Q9uiYa8B0jg4gN191K-_7nF2pfZ1OB2I
Message-ID: <CAHC9VhRyKtyROAwTSdRv+UmLSwat-Vxiu-BqM+1DwnYv2r1ejA@mail.gmail.com>
Subject: Re: [PATCH 0/2] Allow individual features to be locked down
To: Nikolay Borisov <nik.borisov@suse.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-security-module@vger.kernel.org, 
	serge@hallyn.com, kees@kernel.org, linux-kernel@vger.kernel.org, 
	kirill.shutemov@linux.intel.com, linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2025 at 7:10=E2=80=AFAM Nikolay Borisov <nik.borisov@suse.c=
om> wrote:
> On 5/13/25 01:01, Paul Moore wrote:
> > On Mon, May 12, 2025 at 5:41=E2=80=AFPM Dan Williams <dan.j.williams@in=
tel.com> wrote:
> >> Dan Williams wrote:
> >>> Paul Moore wrote:
> >>>> On Fri, Mar 21, 2025 at 6:24=E2=80=AFAM Nikolay Borisov <nik.borisov=
@suse.com> wrote:
> >>>>>
> >>>>> This simple change allows usecases where someone might want to  loc=
k only specific
> >>>>> feature at a finer granularity than integrity/confidentiality level=
s allows.
> >>>>> The first likely user of this is the CoCo subsystem where certain f=
eatures will be
> >>>>> disabled.
> >>>>>
> >>>>> Nikolay Borisov (2):
> >>>>>    lockdown: Switch implementation to using bitmap
> >>>>>    lockdown/kunit: Introduce kunit tests
> >>>>
> >>>> Hi Nikolay,
> >>>>
> >>>> Thanks for the patches!  With the merge window opening in a few days=
,
> >>>> it is too late to consider this for the upcoming merge window so
> >>>> realistically this patchset is two weeks out and I'm hopeful we'll
> >>>> have a dedicated Lockdown maintainer by then so I'm going to defer t=
he
> >>>> ultimate decision on acceptance to them.
> >>>
> >>> The patches in this thread proposed to selectively disable /dev/mem
> >>> independent of all the other lockdown mitigations. That goal can be
> >>> achieved with more precision with this proposed patch:
> >>>
> >>> http://lore.kernel.org/67f5b75c37143_71fe2949b@dwillia2-xfh.jf.intel.=
com.notmuch
> >>
> >> Just wanted to circle back here and repair the damage I caused to the
> >> momentum of this "lockdown feature bitmap" proposal. It turns out that
> >> devmem maintainers are not looking to add yet more arch-specific hacks
> >> [1].
> >>
> >>      "Restricting /dev/mem further is a good idea, but it would be nic=
e
> >>       if that could be done without adding yet another special case."
> >>
> >> security_locked_down() is already plumbed into all the places that
> >> confidential VMs may need to manage userspace access to confidential /
> >> private memory.
> >>
> >> I considered registering a new "coco-LSM" to hook
> >> security_locked_down(), but that immediately raises the next question =
of
> >> how does userspace discover what is currently locked_down. So just tea=
ch
> >> the native lockdown LSM how to be more fine-grained rather than
> >> complicate the situation with a new LSM.
> >
> > Historically Linus has bristled at LSMs with alternative
> > security_locked_down() implementations/security-models, therefore I'd
> > probably give a nod to refining the existing Lockdown approach over a
> > new LSM.
> >
> > Related update, there are new Lockdown maintainers coming, there is
> > just an issue of sorting out some email addresses first.  Hopefully
> > we'll see something on-list soon.
>
> So I guess the most sensible way forward will be to resend these 2
> patches after the new maintainer has been officially announced?

Possibly, or at least bump the thread to get it some fresh attention.

--=20
paul-moore.com
