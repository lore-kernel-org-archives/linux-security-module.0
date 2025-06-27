Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AED9C2FB
	for <linux-security-module@vger.kernel.org>; Fri, 27 Jun 2025 20:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751056028; cv=none; b=u9E+U8OxXTquv/shynJg+i2cqOLw6eAUn38O4SV7V7ViCGK9ZAtMhi36X2a+QELe2RdnYaSTfKezlD8dMw4I9ilHzfqTCdnU3giWct8DqW39ZAoMh3933W7lBGny78+fDn5NLoQVxP5zfFZQXQSnLRJyApT3F9LzQNnm0t66FGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751056028; c=relaxed/simple;
	bh=h5V3EVzZYv0O6zwYKkLKDl+GL1MXBrxLtnc9JiVC4lc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gU/D8Lvl6vw7EMHI6pKBpl2pFO3QQ2eSUXfd0rifxe/htuK6CqXERtOUE/lLMz2Ca2/tDXlvE3NRImnpcryWA6c+Ctzbzc3tE65Fp0LKS3esR+jdZN8VqbhBnM2zbw4hbPB/V5io2XEjnDIcT9XsWmPEEqHCY/Vq6m5rxVvozTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lXN92zjC; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lXN92zjC"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-60c6fea6742so4376043a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 27 Jun 2025 13:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751056025; x=1751660825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gC7to85VmDtFkyJWxPO4KSUOgpSiB/439g07kO2DLg4=;
        b=lXN92zjCVt8624UYov/y6/P9ydiveDGaKki7grQRwUyNd3ImwERDoQNemFe0rlJT0A
         2Tk+tSFJZNGHLER0PhbmApLuKFG8aGdhg7L9goHvFBHu5fSaZLSq95omLMV1ImxmpE3F
         ay2C8H7Gw5CLooXm5qkGwqZZNSVn4TXpvorfkoV4S2BxA8GWuczWUtwnJm6U7QYUqD49
         x9ZL4qMufBxgT5E/c5PNB/pB03QaR2OImBg3yfD+O38WAOLm380yipkBSo0g1m6J4bCs
         i4pA+uNnBV+UfC2TUpuwqtPHGz36djGSb2zNIxiVuAUDwWs/E5j9PwvvviVoq0EBh6UI
         EfRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751056025; x=1751660825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gC7to85VmDtFkyJWxPO4KSUOgpSiB/439g07kO2DLg4=;
        b=WEDvniJAsgcwjPnlZv65RL6657tyJ6kK2VMYtRUf6Bep9SCm2nTo/0lolCzkv4qB4P
         q/jfve9T4lxdg36tvH3/kqzqu1gt8lr01YtgFdezKJNoBkZ5y72VFCjUYd3Wmv5ufYeu
         jLg5CuDs4DiNCDaFzd8yfsOyH03pM3+qI3oeQEoS2GRqjgDZSSksniSWbC7mCb6P4/cV
         f5/G1iIdbHLo7JA22kcnYuq5kPIPB+T54YVtBw3/r/PoDvMeyu09swVx6gImrPXY7JYL
         d2lDLc3v4M68UMgb9C1vRvu9wMWRgNubE2bhDWX2LA4sIUStHBZoXEdKoIEBQn6Qi900
         wWsA==
X-Gm-Message-State: AOJu0Yzlt2NPkHoatMp+bRr+3iRXURjI1HES82OxaSumVo9d7Dr6jAW4
	Jbp5O7TfyyCO2EEVuNwawu7OCypuFGvF2UF5iKiJkWvFdnQdvA5L/UCL5asNJXBym1oftJjfbku
	AyiBPz0HcVicqcbgX3WoeJZDO1jSjUEs3g8rbkh4v
X-Gm-Gg: ASbGncuj0R/v7QgBGwqRnV+m9/1LKUNzGeUJDB6O5sDQ3VxIJ6L2qruOHjCBMXCl4yT
	R4BnwLYac1oNsNp134V0qAjKfoepQSlK/SfaWLJZFAt7JRSvvLsA+h0vjjzo3V7cXZQu+jk0wvq
	WXgpQ3RYr6cZnMvEsinNKqWfRJCwMmmuKFIr2DfcyuKNl6J6i/qKGNmb/vXV/JT/MRYOEuZyAux
	Q==
X-Google-Smtp-Source: AGHT+IFNuRkPvymSHt5NhDqhDh1K9fpy5uFLuy4N7OjWw1RW7lrlojHarbLbPkuuFy28t0V+wbEfgvxrWa0wgAmS8BI=
X-Received: by 2002:a05:6402:42c4:b0:60c:3cca:6503 with SMTP id
 4fb4d7f45d1cf-60c88e639b3mr4146977a12.32.1751056025150; Fri, 27 Jun 2025
 13:27:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAA25o9TqH3LNWy8F2tXO7P6AdQk0x+boWiPhy+CKL=wDouKODw@mail.gmail.com>
 <CAHC9VhT-UKWRbmsuJfkWO6BK_Mon4KUMB8DU5py1gDBJgYwJDw@mail.gmail.com>
In-Reply-To: <CAHC9VhT-UKWRbmsuJfkWO6BK_Mon4KUMB8DU5py1gDBJgYwJDw@mail.gmail.com>
From: Luigi Semenzato <semenzato@google.com>
Date: Fri, 27 Jun 2025 13:26:54 -0700
X-Gm-Features: Ac12FXzjdVOus1tLAxzcDyx00zlxWm9nAIaDCH6fDzK0iJqlTYrfngzoxKiQCCc
Message-ID: <CAA25o9QqmFGA1AsxK+5jds80uDV-3=BtM7kH0WgU=k+DEuxaiA@mail.gmail.com>
Subject: Re: adding CAP_RESERVED_# bits
To: Paul Moore <paul@paul-moore.com>
Cc: linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry for the delay in responding, and thank you so much for
clarifying the Linux priorities.

For our project we ended up hijacking an existing bit which we're
comfortably sure we won't need for that binary (or any binary,
really), plus a seccomp filter.  It's a total hack, but a simple one,
and it beats the alternatives.


On Fri, Jun 6, 2025 at 7:11=E2=80=AFPM Paul Moore <paul@paul-moore.com> wro=
te:
>
> On Fri, Jun 6, 2025 at 1:58=E2=80=AFPM Luigi Semenzato <semenzato@google.=
com> wrote:
> >
> > Recently I inquired about the decision process for adding a CAP_DRM
> > bit to capability.h (to become DRM master).  It occurred to me that
> > the process for adding ANY bit would be fraught with controversies (to
> > say the least).
> >
> > So I looked into maintaining a patch in our own kernel sources, but
> > that was surprisingly messy due to the build-time dependencies of
> > capability.h and the way we maintain and share sources internally for
> > multiple kernel versions.  This would have been quite simple if there
> > were a few reserved bits, such as CAP_RESERVED_0, ..,
> > CAP_RESERVED_<N-1> with, say, N=3D3.
> >
> > Would this also be controversial?
>
> Yes, and likely rejected too.  The upstream Linux kernel generally
> doesn't make any sacrifices to support out-of-tree kernel code, and
> giving up precious capability bitmap space would definitely be
> considered a sacrifice.
>
> --
> paul-moore.com
