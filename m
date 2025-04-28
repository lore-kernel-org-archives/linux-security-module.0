Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709484A18
	for <linux-security-module@vger.kernel.org>; Mon, 28 Apr 2025 23:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745884298; cv=none; b=n9m6vgcqaUd2zduTtzWzl48Uucw2bU81RoLX3b+KZZKO3G3YWYNKFOJZFcHOQEBedO320T12Kt7bkdeL7quElgvdLt0hqL4z1braqX6euLCK2yz5g46Fat3KcAxckKxH2U8RiR7N7o9tryL8GizdUIpxfQK4yJYa2VD2wx1ElsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745884298; c=relaxed/simple;
	bh=2lTklSMfsgnWqToUR8RRkI6z1i2MEe1hAHC6M1/q9Yo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qbZbGPu53jgW32RCLMOXkuYy3tQJGQzLeXrWRokySuE28xvODIjdiTjPo2fWr0RUUdbHiJ5mH3YcRe09d7h8Twc0XIvlvJK77KycngUnC450miYq9yeJaIbfHrgGYvQuHbw/a8qU97NHL4r25hMugopkbBEWYG3mnhH822YN+0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0aoF4Ucy; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0aoF4Ucy"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac34257295dso916468366b.2
        for <linux-security-module@vger.kernel.org>; Mon, 28 Apr 2025 16:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745884295; x=1746489095; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Do9VX2wMn3K0EJWgBWHyEw4PPHSaUeH91/gCc64jFCM=;
        b=0aoF4Ucy1jQz8umhJJPaqH9u9W9f7FaBJTrL+ZVU3kBKe8GU2Z/AK4sQiVjwCUHNlG
         KFv+MFMbG2C+yUHpkuJlccLWzMBpbcVQ2lnaFGstOaR1I3iNkLbJviChqVnfy2asVmsI
         Jb85L5CM8DM+yvj88c2cRrI8H8cFAlHlG4ZgwSlNrdmYGATKj5UcfZW1KYNqkp7BrjXU
         7+pzYZrpVSmScCTDIjyY949+A4k9wB6rWnS8+rtlmpIJWhfFL5mbQvlNFAeKM9B3dXYz
         5Zv16w08qPH6IqAecqkRUvsF/jPFQraebX67kTlo4A5rm4bQ+BGQ77445Z+LoEnMFzRj
         NVkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745884295; x=1746489095;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Do9VX2wMn3K0EJWgBWHyEw4PPHSaUeH91/gCc64jFCM=;
        b=s1Zi5nrQgHXcay4+njWSoomOIIJGciLwBQcDZDa5Cq9ZdqFleLd/vb86Rm0P6/Gdei
         E6QCVCfzneFR3iT3YSIODwOynA4m9Tt8YZDFceHfh0PL6Xw8bxNSDutMeoWYjIVWlt4n
         TMSA270w5raonh5G+06PQWuFWVv/ui8UXh3JTlHlb+mj4AxDioxmukQ7sIsSzirzRa+P
         oB1uhZRHbC6LcyYwYeAX07OoC8wP5AQ3p3rBoiOF7XcXlQ8DboSYvKBBbtH2BI7Gnjwn
         txakzXyBl7/SgoiNmeaxgeagqZrKhXmv/EtS7nLnwO+bFMEPYW0jg5vdVfqFcxiKP58E
         jiTQ==
X-Gm-Message-State: AOJu0YwajqnSeXzKrj3Ktm2/tU7NreEryKtnGiR6U76m2IgEi1JZD0Eq
	GkTiiSL8IRiYXM6vsXArgqm8F6bBzpEAdf86V/B7DDp1J7BH6GcM/wLyK5kYCVVdAxrlj0f88MB
	+4Hr9k2nk9tcdnTAG9XufHlxVWeOoaTI8I1TZ
X-Gm-Gg: ASbGnctAkZa5Nqa9go39P4HDW3s/NO4wGQ+8JFq9d108NwLf2hqbfjaoQXOCjkM6LyG
	Qnv3DIuqWoIYECcK6yoIdqMwcKNKqOHSw+onJyIqmgABXs7Wt6bgLmtqNYuhmOssqTRyC7UBFAW
	MXwJEg1Bjpzcc1ecRgRMl465Vbwjw4qncOLF+DntGHnFwskiTHhxYa
X-Google-Smtp-Source: AGHT+IF9urPFd00ZFyxpohj2tI0MRmyR1h5eCTi3TQVROHRNSysRbnDHvLvpQ6lrEcCKpXVzA/VpyC+Erq2o3AW9VdE=
X-Received: by 2002:a17:907:3e0b:b0:ac1:db49:99a3 with SMTP id
 a640c23a62f3a-acec4f35fb7mr143374466b.40.1745884294650; Mon, 28 Apr 2025
 16:51:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA25o9THx_+SzE_+DMjCeSRE28s3kxZ0OkXgSib3tU3svdQPzA@mail.gmail.com>
 <CAA25o9Q24atyK5M6BQaVx5sVq_ZouwRdhXEo3UPa5pE4XVqxQw@mail.gmail.com> <4689f3d0-5c5a-4736-9e09-e40712a53e08@schaufler-ca.com>
In-Reply-To: <4689f3d0-5c5a-4736-9e09-e40712a53e08@schaufler-ca.com>
From: Luigi Semenzato <semenzato@google.com>
Date: Mon, 28 Apr 2025 16:51:23 -0700
X-Gm-Features: ATxdqUEY0lX3ij2G0PLjaW9hKEWTGSfi8eS8aVzW6-eYnzT1tDlIk_4SD9-0jY0
Message-ID: <CAA25o9Re9Zddos=MgWzEU3wd_VKYD-5xcrL6QaoQ_XcR0WJREw@mail.gmail.com>
Subject: Re: how are new CAP_* added? CAP_{DISPLAY,DRM,GPU}?
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: linux-security-module@vger.kernel.org, serge@hallin.com, 
	Jann Horn <jannh@google.com>, Daniel Erickson <danerickson@google.com>, 
	Dave Hill <davehill@google.com>, Alex Glaznev <glaznev@google.com>, Su Hong Koo <sukoo@google.com>, 
	Sean Paul <seanpaul@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

"DRM" stands for Direct Rendering Manager, which I understand is the
standard way of accessing the GPU on the (vast?) majority of modern
Linux systems, for the purpose of producing output on the display.
(Other googlers on this thread would know better---for instance I
don't know if DRM is used also for general-purpose computing on the
GPU.)

The DRM master essentially owns the display, so this may be similar to
the totality of the CAP_NET_* capabilities.  Also similar to
CAP_SYS_TIME, as it refers to a large class of hardware components.

OTOH, just by looking at capability.h I am seeing that there is a lot
of competition for those bits!

I am wondering if this has come up for discussion before.  I couldn't
find references to it.  Probably because it just isn't a good
candidate.

On Mon, Apr 28, 2025 at 4:16=E2=80=AFPM Casey Schaufler <casey@schaufler-ca=
.com> wrote:
>
> On 4/28/2025 3:19 PM, Luigi Semenzato wrote:
> > I have a use case for adding a CAP_DRM, or similar, to replace the
> > CAP_SYS_ADMIN in drivers/gpu/drm/drm_auth.c for the purpose of
> > becoming the DRM master.
> >
> > I am not an expert on either DRM or capabilities, and I am wondering
> > how one can decide the appropriate level of granularity for a new
> > capability.  Is CAP_DRM general enough (but not too much), or should
> > it be CAP_GPU, or CAP_DISPLAY?  Or perhaps capabilities should be
> > discouraged for this case?
>
> There are a limited number (64) of capabilities available, so we're
> being careful about handing them out. My first question is one of general=
ity.
> If there is only one case where the capability is useful, there's really =
no
> way to justify it. If a process would need another capability (typically
> CAP_SYS_ADMIN) in all cases, there's no point in a separate one. If the
> use case isn't going to be around more or less permanently, or it is uniq=
ue
> to a hardware platform, we won't approve it. Without knowing what a "DRM =
master"
> is, it's difficult to say for sure, but I'm guessing you are going to be =
up
> against all these criteria.
>
> >
> > Thanks!
> >
> >
> > On Mon, Apr 28, 2025 at 3:16=E2=80=AFPM Luigi Semenzato <semenzato@goog=
le.com> wrote:
> >> I have a use case for adding a CAP_DRM, or similar, to replace the CAP=
_SYS_ADMIN in drivers/gpu/drm/drm_auth.c for the purpose of becoming the DR=
M master.
> >>
> >> I am not an expert on either DRM or capabilities, and I am wondering h=
ow one can decide the appropriate level of granularity for a new capability=
.  Is CAP_DRM general enough (but not too much), or should it be CAP_GPU, o=
r CAP_DISPLAY?  Or perhaps capabilities should be discouraged for this case=
?
> >>
> >> Thanks!
> >>
