Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B341A23B6
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2025 13:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738071434; cv=none; b=US7J5ndrMAWy/WjATOz7JGjCXEKL/mvXMNjAg1Y0PYN7FvgriRS9VrD+Sb+Mrj4376Toa75tUFgoVA79wks/Us9i4y1hF0jy7QhZ2cNgk2YF0WbI0A6e7TFksYGGODHG4Cr8eoBwrAcsqMOVONzfncQW+RJi5B1TtZWrJFY5IIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738071434; c=relaxed/simple;
	bh=za4jWSIXiWnx1/PtIdrlQUWfgRWi88/FEbsBClDq++Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbOl1s3n/i92pAuw1mNcs3q1Kzb2d9khNgR3Wt9SZDySsg8VmeH6GxVTRKfprIRcRPSpviCQRUKgzJat0Ya3lnvrHH141feKbL1ocvibLopGeb71g5zAocHejP1HSzR7MzlZA033eRDGMbUkz11gE462I1fN25gDEzAapx+phAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=BM/I/aVo; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="BM/I/aVo"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-46c8474d8daso44604911cf.3
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2025 05:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738071432; x=1738676232; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cEBqaIaDwYzpAfJb0Xza7F8apQH4HtqaJ+JjUwM8mEQ=;
        b=BM/I/aVopvQmXAAU9Lx1lLYfIsFez4u45iXCOilKTl7APoK/QCR33ZVougxbmZ2gci
         TW171voLB67P7eFXO54deYTFS2jCJ+VRUj7eNV1ZJS2fV++Ldaw73t7+w1eywC/EUeKm
         eH/YKXNOz+nYR/rWsYV+53sm75gtKTIAmL3PA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738071432; x=1738676232;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cEBqaIaDwYzpAfJb0Xza7F8apQH4HtqaJ+JjUwM8mEQ=;
        b=jgPinYN1HKZ2I+JPoixAb47brAte7M4OGvr62c4oVtlWRXc0sBuv1KaeL6Z9LYcGPM
         GS9d12L1wSsCACVzP8Kne7L9CwdJSrUSBH/Qz7HUxs6324Goi/MGZf1Qii5dwi6GCcyG
         wxmhqbOPwIKCBkPl2lw+7Ve1z57W/fbGlFpMJ8C821wIdAYKIcQjo5i3Ak9YO1/BL02G
         LnK/61Elms1hzt09t586Q45DYQmOkJK2o2QUlpwVVGk33Gn2VHueFmBzRJPjBOKpzI6Y
         bI45TuHP1TbPkdaxJALLLNwsneHuP4LUST1K7RvV+G7kKdWrlSHXaljcsiIgEp4i41wh
         faAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUr9N1H1+JLZljIMO5RJiAaKecS/IpPwJKWP/VfzWYxrjm8ActokARBKIEsLsM4jHpbgZKrPhLCaDlilQf5ld3+E1/lLc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/0Dibdxc0lDi7tRPPMBL+JsMUOZer00R2BhhbQUrqaY/v4H7T
	z/gHEq3ZWW9mhs+hy/DFj4ZwDDLH52QgcB8byKk/vn0HGEt2+yRkEF+nGVO4jOsxXoTqKeMKcHh
	zbitBLFeXA3ikg9VvLBdtrinnBSqaU0aVUrTtMA==
X-Gm-Gg: ASbGncv3QAsxZljetZmJAfDhFSucfrY2VB8OJAshYuqe1ah2LHfx3LqqvitiKBrMJ8z
	5Un06lXvDXza9wVMs/SRiAAEDSPO0CxfWVS4FE1p3RK3WDOhiEE+aCK9pqOm475kOWh9Xhco=
X-Google-Smtp-Source: AGHT+IFWTIAnK+5eL7HyrGG7lpTg04Tgrx5YKQ2A5MNEXhLez1EsL/JNf1CxyLCjHr2w2Q9lyVqeWMCdUDReSZN1y/4=
X-Received: by 2002:a05:622a:1311:b0:467:5eb6:5153 with SMTP id
 d75a77b69052e-46e12a3f746mr729277911cf.19.1738071431912; Tue, 28 Jan 2025
 05:37:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123194108.1025273-1-mszeredi@redhat.com> <20250123194108.1025273-3-mszeredi@redhat.com>
 <CAHC9VhRzRqhXxcrv3ROChToFf4xX2Tdo--q-eMAc=KcUb=xb_w@mail.gmail.com>
 <2041942.usQuhbGJ8B@xev> <CAJfpegsKWitBYVRSjWO6O_uO-qmnG88Wko2-O+zogvAjZ9CCxA@mail.gmail.com>
In-Reply-To: <CAJfpegsKWitBYVRSjWO6O_uO-qmnG88Wko2-O+zogvAjZ9CCxA@mail.gmail.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 Jan 2025 14:37:00 +0100
X-Gm-Features: AWEUYZmizeJU0a7RXrBJlqhjTqK1mNWtSBDQH9Nt1-ZaM-h_jUVyMC5_wxbnhOg
Message-ID: <CAJfpegs7n5eO6yOms+_TqeXGrN=OaJbjRB9qVm4VsW7JpWG5Xg@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] fanotify: notify on mount attach and detach
To: russell@coker.com.au
Cc: Miklos Szeredi <mszeredi@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 28 Jan 2025 at 13:42, Miklos Szeredi <miklos@szeredi.hu> wrote:

> fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MOUNT,  FAN_OPEN,
> AT_FDCWD, "/proc/self/ns/mnt");

Sorry, this should have been:

1)
fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MNTNS, FAN_MNT_ATTACH |
FAN_MNT_DETACH, AT_FDCWD, "/proc/self/ns/mnt");

This notifies on mount and unmount events in the current mount namespace.
