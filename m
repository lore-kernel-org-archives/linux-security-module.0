Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A281BC2A
	for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 20:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727296996; cv=none; b=iLbL3TPsdkmF2Fkw7P7JoBMnh33SamFmRInHnrk2FfTfz/khmJp6+xKXOxJ7c1l7M7bDsM9NAq1BcuM9jzGpyGMdgROo7xkq1nLxjATSgzT+BggIHYvlX1FlWdqiUqlRvjiTGt5o6ExCt+cpmqSCBHDSV7fpHTYHp/yY9/I6FRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727296996; c=relaxed/simple;
	bh=boMEV9fnBRwRoCSzqZGcJQBPinpyOW8x7YYCbjWtVsk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fzBX5vV7frruyiD0JDtIbBRwQKgjLCUF92WR0lTUdHgXLwkQ2yN6RaWjdjDouLtHmf+ValcD86VjBm5N9AwWB3EgFdDbvxVSXSHNwxHdUL6XXLrfMjZYJ6W2pHh5NUvbGWfkUVuukCK0MmPoyWJvOasEN7J+vGOFmz/Ch5xg5PI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AMwgQgJ8; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AMwgQgJ8"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6ddceaaa9f4so2892917b3.2
        for <linux-security-module@vger.kernel.org>; Wed, 25 Sep 2024 13:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727296993; x=1727901793; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=boMEV9fnBRwRoCSzqZGcJQBPinpyOW8x7YYCbjWtVsk=;
        b=AMwgQgJ8qonmEYtEJDPSgBNfQZEy21mrA/hOU9WQr6kO/ZubSKgqgEFM9tOsSaghyC
         prgqbEAuS3mmlPshxxuu2pnPSiCqUD8GK9MvYbxt5gQZqhJN1MwpOJ0vbijFzd+NGCTd
         L4B5dPILoCe8HuyHyDu10qRoU0kPmQQKxfJ/qG6tDUdppWMFjyQkQeToPYdwd2sxIXj5
         iw/28plNGLoQ+DBcbGISkMrq+jOOo/FFUL3r6sLxfHbboSY2rAKEMi6mrEcvyf30hXfQ
         h9SYPm3ozA+fsHgyZ2BpyS3/sMLHDoltzncTwugfVdkCmAtkkSsyiOLxITjIByrZ6aNx
         nOzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727296993; x=1727901793;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=boMEV9fnBRwRoCSzqZGcJQBPinpyOW8x7YYCbjWtVsk=;
        b=Bl5CqoMTwaUCroxKBoSSND75bnb8vrM6zA0faZY1GHmblRMdtnSCpt7WsRXmKQ+JMN
         5YV8cptSgUj9EdcrBxEL2zm9j7gXw+9z6Q7v8/RJtFdMp6lHrrdAbE0fN1qHkabV3P3a
         FEoX6rzlJ3dtYNO4shloh1qyGhiJrJ9HW23+suwd3/zJbQG9N8Q+WAPRKNKQACmTvI+C
         ihsZ4l/fRcOQZLm72od3tbUg7HOluG4ujh10Q2rl4BfjCsvceKfwxTj+q68ZiD2ItIii
         91IO+dW2+9sumK/VKT3Ob8dcnP9QkfvQm8uPLqWgGYswY7dnz20OvEdgiA5YtNHLHKts
         KKJw==
X-Gm-Message-State: AOJu0YzCYoBfs5QX1NagmUlFPXjAZF71nyFz1h68lySLa0PrH6fhpo85
	Hp6JVbTHoeQuRIRmWBEFc6r4BzSYpOAJ2t7hwST5YGRUv+hVSb98g97qghhSOjRhJFaBuEmNNyG
	+B0SBHKWKAwNNeipR84ADYx7yzJE=
X-Google-Smtp-Source: AGHT+IGTdnq/EGb1aZr2rLX1lbNDGfgUxFq7wZA5cNp/1slcpzPbYFbVSLbIJR8DL1uKSJGpPsgYiFsuMXFzgXcxF0U=
X-Received: by 2002:a05:690c:f87:b0:6db:d738:b27c with SMTP id
 00721157ae682-6e21d8b6f09mr41638427b3.19.1727296993413; Wed, 25 Sep 2024
 13:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922135614.197694-1-luca.boccassi@gmail.com>
 <20240922135614.197694-2-luca.boccassi@gmail.com> <4a8414c5-6df1-40aa-b538-a1b4c48f8f1f@linux.microsoft.com>
 <CAMw=ZnR0M+tsLnoNAeb_+NNw4167qtU-O_Pm3NiFjwaGY5AXWQ@mail.gmail.com> <255d857b-2578-4d49-9a17-f0aa4bba3b44@linux.microsoft.com>
In-Reply-To: <255d857b-2578-4d49-9a17-f0aa4bba3b44@linux.microsoft.com>
From: Luca Boccassi <luca.boccassi@gmail.com>
Date: Wed, 25 Sep 2024 22:43:01 +0200
Message-ID: <CAMw=ZnSVdnsWo29GN7tLfN6=BKwFt8OG=Q0gCB7iOWV29nGg6Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] ipe: also reject policy updates with the same version
To: Fan Wu <wufan@linux.microsoft.com>
Cc: linux-security-module@vger.kernel.org, paul@paul-moore.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 24 Sept 2024 at 18:32, Fan Wu <wufan@linux.microsoft.com> wrote:
>
>
>
> On 9/23/2024 2:48 PM, Luca Boccassi wrote:
> > On Mon, 23 Sept 2024 at 20:01, Fan Wu <wufan@linux.microsoft.com> wrote=
:
> >>
> >>
> >>
> ...
> >> Hi Luca,
> >>
> >> Can you elaborate more about the potential confusion for the userspace
> >> users?
> >>
> >> The policy version is currently used to prevent the activation of
> >> outdated or vulnerable policies (e.g., to avoid activating a policy
> >> trusting a compromised device). The version is not incremented unless =
a
> >> vulnerability is identified. Essentially, version comparison acts as a
> >> minimum threshold, ensuring only policies that meet or exceed this
> >> version can be activated.
> >
> > "Version" suggests something that is bumped every time there is a
> > change, that's usually what the term is used for. The fact that one
> > can change the policy without changing the version confused me a lot.
> > Perhaps it should be renamed to "generation" or so, to make it more
> > clear that it is not intended to be changed every time, but just to
> > signal the start of a new generation to avoid downgrade attacks?
> >
>
> I=E2=80=99m inclined to keep the 'version' name, but I agree with your po=
int.
> Requiring a newer version for policy updates makes sense to me. As for
> the version check in ipe_set_active_pol(), we can maintain the current
> behavior, allowing the version to continue serving as a minimum
> threshold for activating a policy. In this case, I think the only change
> needed for this patch is to update the documentation for the `update`
> operation.
>
> -Fan

Sure, just sent v2 with the doc update, thanks.
