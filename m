Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD0818A957;
	Thu, 24 Oct 2024 13:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729777252; cv=none; b=iE+VwF5xaF2qGsWEgPzWaRd1qk5299rzTXnstS0zdfxOPHZWYf63oRzLvkXefnKBwwWUHLqSwg1f5hp4Bmbo/ZzZgYWQk5WcQtP8nZSCw5vcpEyT86Ffina5OVL+GXZ61NcLBO/+9qvhQ83rzetDBoHBTiIundBDNIcK9BDLusg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729777252; c=relaxed/simple;
	bh=SMLEjYHd/nohEH2QnDTBbR89bV+wcUkiINeAEboVv/Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QerVCCM8kcYKj4FZ1wWHX498nKjJ00wWs/H6CXVifceD8mb7DcHkqxFgTIsjg9rtSp+G8gQjjMHFJGaQX7DsWZQt61I3VOVl2DfSfCwprDiNiWgPVgm3xCo9AOSXi/4LfANNVSmd91sPwxxU4KMCDwZAW1aR23bWTDvd0EnauiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jordanrome.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a4ccfde548so2762125ab.1;
        Thu, 24 Oct 2024 06:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729777248; x=1730382048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NeCPoI+SKGcGw6l5DAOJbn//oQV3pGhKVIFlqZ+HzA8=;
        b=KsOVLBZhl++7zRJ//mHLJ6PIGKGBOLnWFcOc70y6mcUAIYvMkcuEXcGAetkAzPDkY1
         FotBKs7YY/XSNtwQsGbvSmpyo2Bdoh3q9RAgo/yBDNf/rZNPMnqzf5v6+rY8z5VNcUNQ
         L6H7aRXs0rAGDAaE0OHe/YsexFQ8fcemLd4O7ph26gabXxT/APozq0zW/aiM+SQHaBzt
         9GaS2MSJCq7PxicR53Zxy/nYrzaUpy399IIq8hGiQNBHLAzS9fA2kxDx+pLruXpqL4fM
         jAobbMJ5DBmMr3X/pZvhMlFCWshDQNeA/xLqNvNIfSZYyF0aw9dcWsWRxD58BY9V2ich
         KaFg==
X-Forwarded-Encrypted: i=1; AJvYcCWMoqRkBHqQvH9/6xcdNe+FChkx/WokyFV2Jch73PBRxyl5YZ03mzfmnPhHucayRCGYGnaw3NXdFaq7juEO9/RdC7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdqJoAifGxHB79o8ZTEw3RIAaxJilZq8n93WJH7Fz6nlf+A7wi
	O83GoNyZwmUDwm/xzVH2f6JrCEE+dYr6lg8lD7cdUVo5BNeHwhKLtfBsb0eS9yhjLhEiPyV4OAb
	AY2j20kg1NDyeHo9Z+KLY5qHRZT3sZg==
X-Google-Smtp-Source: AGHT+IFOJmWpwhsF0pRFwmt9xzgkQmrPux0NqystJ34aWaUARhFNUovYgLLYe6dpzl7Tih5MktRpXNSRUnXFYBkbf8s=
X-Received: by 2002:a92:c26c:0:b0:3a0:9903:42c3 with SMTP id
 e9e14a558f8ab-3a4de72a232mr15319895ab.10.1729777248480; Thu, 24 Oct 2024
 06:40:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241024104012.1815022-1-linux@jordanrome.com> <20241024091904.2650d758@rorschach.local.home>
In-Reply-To: <20241024091904.2650d758@rorschach.local.home>
From: Jordan Rome <jordan@jordanrome.com>
Date: Thu, 24 Oct 2024 09:40:37 -0400
Message-ID: <CA+QiOd7uOcJKcKewfDHa5+E6Z5R+8AOae__WOFcpgtFY8j1vuA@mail.gmail.com>
Subject: Re: [v1] security: add trace event for cap_capable
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-security-module@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Kernel Team <kernel-team@fb.com>, Serge Hallyn <serge@hallyn.com>, 
	Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 9:19=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 24 Oct 2024 03:40:12 -0700
> Jordan Rome <linux@jordanrome.com> wrote:
>
> > +TRACE_EVENT(capable,
> > +
> > +     TP_PROTO(const struct cred *cred, struct user_namespace *targ_ns,
> > +             struct user_namespace *capable_ns, int cap, unsigned int =
opts, int ret),
> > +
> > +     TP_ARGS(cred, targ_ns, capable_ns, cap, opts, ret),
> > +
> > +     TP_STRUCT__entry(
> > +             __field(const struct cred *, cred)
> > +             __field(struct user_namespace *, targ_ns)
> > +             __field(struct user_namespace *, capable_ns)
> > +             __field(int, cap)
> > +             __field(unsigned int, opts)
> > +             __field(int, ret)
> > +     ),
> > +
> > +     TP_fast_assign(
> > +             __entry->cred       =3D cred;
> > +             __entry->targ_ns    =3D targ_ns;
> > +             __entry->capable_ns =3D capable_ns;
> > +             __entry->cap        =3D cap;
> > +             __entry->opts       =3D opts;
> > +             __entry->ret        =3D ret;
> > +     ),
> > +
> > +     TP_printk("cap %d, opts %u, ret %d",
> > +             __entry->cap, __entry->opts, __entry->ret)
> > +);
> > +
>
> You record cred, targ_ns and capable_ns but don't use it in TP_printk?
>
> It's fine to print pointers there. Is there a reason you do not?
>
> -- Steve

I wasn't sure if printing the pointers was useful. I'm fine to add them in.
