Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5D18E750
	for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2025 12:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068176; cv=none; b=A3cRidPxc6+qvpmFxgOlNq+dYF60zvIx8ONf2aT9pKmfX7h+TBTuq7nGUL1WHWfqWwkU8P6SpjuShRK+uhRkeQs8g+SAQ/74V9KPX4qbZZWMy7Meh9FciN42T0gfNnxy+UO9+550ycDQkcNcMkXpkf1EqXEUfDdHO+xix17S6gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068176; c=relaxed/simple;
	bh=i4Ih4yOsCitMuKZsbd4LjFylOAQUX1g8j4CPdMxyPDE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nAmesXkMt9PDdpCSpM0FqNXj96e/QfgrPDx4vfgdaIemMejuUhBaJG9CK759FkVM6mtMHblyOhXOKtpErNJkJP0Vw5TKwB2FhWTGnYwEN0qaJZvGygGOWJpHT7waIwZk3O9lFNo22Max3LONtsXIiOKHczCyRq0cE9AQ0Pj/82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=OKUl7Q1q; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="OKUl7Q1q"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6e1a41935c3so81908986d6.3
        for <linux-security-module@vger.kernel.org>; Tue, 28 Jan 2025 04:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1738068174; x=1738672974; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P9Hjz/HBikG9/lKNWOcgvjSfQzXvtdwqalUBjRJ0K+I=;
        b=OKUl7Q1qkBRpl6L88ox9Yk92wtAsOuVo5IayOUU/hzGVgf3Rjjecryl2WT1lZFfS+E
         35FcxVpBKuvDaSdC7AJdwWVFVzBNhQqmFJAiwmz0BfFiNYgIRVTYuRuHS49codimYGWh
         YOqM3wAb0i8y6dAuFhqKpLnsBaAxtDrfuqFOQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738068174; x=1738672974;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P9Hjz/HBikG9/lKNWOcgvjSfQzXvtdwqalUBjRJ0K+I=;
        b=PLiYZBtg+/E+0sWpGeVyktqMyR+2ZB9YYzFR7jXpByYHt+GrQKnsvTM4yic2ojOgyZ
         vEYIAEnwgXFwSBUQUbFSFdEOS6p87qca7quo2TMjdiIVtA5lfURf+ii8Bx9k8VbInGXM
         OOvRbT1/Y0JHHvUkinbt7eCHLksCZ3L02apn13KRnqSuZX5hhcukI4mB2pu0SQJYclyt
         2rcRHe3K4zRDrGedfgR+qmwsW6RnD6cVc2h+vGwCyTjtoJsvbQPW6xqsfA4hHE+HKNH1
         ehiSnLscNYRvdLhLIgUzghym1do1mKTK5Cv/RuOO0WodmYduLcYq9cHi0kLDjEzB1zyt
         PdSw==
X-Forwarded-Encrypted: i=1; AJvYcCVCcuRaUem+VR1HfRYHLVns8wrkxFwW4Besaiec+J8OHBmSUIvuPTYOs6siZ61hzdEZKhD5APikzVivAM8MJ5lwN4ufVuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWSXQmxHcg6r7RQm+3X4LWyBwuRls/DGRjSgJNLnMzHSgJmPkL
	9ynCs7KlbOvqogAx3GczyveB/fXke7JiXLqW9yaofd5nZQr/Uc8wOMSzluVe6LUxRkvy46ijVir
	qH0Y0Q1z8CCo++imGMdx3XuZR64yWg0B+VJ+wFA==
X-Gm-Gg: ASbGncuOIT2oX0UlqOMlQmbuzZzxFqw/D2pvbrFFwIX7bk5H/Kj8V+iO99mjzDUWREK
	od4WsWaAV853yh41Aq9E2l0wN94jimkaZ9yQBlgQnaIzi1jE4oOSb9mhpX4Z1YJjeEv+nM0c=
X-Google-Smtp-Source: AGHT+IFHqb1dD1KZwsa+gpNM1NJUXqlXL4Uhb8XNRH7U63qw4cN6AM1D6ndQnVoLZlpWFWSgCzZ1R+5zN2z1g9INqw8=
X-Received: by 2002:a05:6214:590a:b0:6d4:22d4:f5b0 with SMTP id
 6a1803df08f44-6e1b220a5abmr649661266d6.33.1738068174227; Tue, 28 Jan 2025
 04:42:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250123194108.1025273-1-mszeredi@redhat.com> <20250123194108.1025273-3-mszeredi@redhat.com>
 <CAHC9VhRzRqhXxcrv3ROChToFf4xX2Tdo--q-eMAc=KcUb=xb_w@mail.gmail.com> <2041942.usQuhbGJ8B@xev>
In-Reply-To: <2041942.usQuhbGJ8B@xev>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 28 Jan 2025 13:42:43 +0100
X-Gm-Features: AWEUYZncrMihch-xJFLSWbspT9bam0hgksBqzvIpiATyQ_1noZ-r1ZsPAgPon9U
Message-ID: <CAJfpegsKWitBYVRSjWO6O_uO-qmnG88Wko2-O+zogvAjZ9CCxA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] fanotify: notify on mount attach and detach
To: russell@coker.com.au
Cc: Miklos Szeredi <mszeredi@redhat.com>, Paul Moore <paul@paul-moore.com>, 
	linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Amir Goldstein <amir73il@gmail.com>, Karel Zak <kzak@redhat.com>, 
	Lennart Poettering <lennart@poettering.net>, Ian Kent <raven@themaw.net>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-security-module@vger.kernel.org, 
	selinux@vger.kernel.org, selinux-refpolicy@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 Jan 2025 at 02:17, Russell Coker <russell@coker.com.au> wrote:

> What's the benefit in watching mount being separate from watching a namespace
> mount?

1)
fanotify_mark(fan_fd, FAN_MARK_ADD | FAN_MARK_MOUNT,  FAN_OPEN,
AT_FDCWD, "/proc/self/ns/mnt");

This notifies on mount and unmount events in the current mount namespace.

2)
fanotify_mark(fan, FAN_MARK_ADD | FAN_MARK_MOUNT, FAN_OPEN, AT_FDCWD,
"/proc/self/ns/mnt");

This notifies on open events within the nsfs mount (proc uses a kernel
private nsfs mount, so all accesses through proc will trigger this).

The latter doesn't really make sense (these files are not openable),
but it's doable with current kernels and events on the failed opens do
get generated.

So overloading FILE__WATCH_MOUNT might work, but it is also very
confusing, since watching a mount namespace and watching a mount mean
completely different things.

Thanks,
Miklos
