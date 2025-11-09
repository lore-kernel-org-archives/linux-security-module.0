Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B8F26CE02
	for <linux-security-module@vger.kernel.org>; Sun,  9 Nov 2025 21:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762725168; cv=none; b=Pd1bf/qf6DxYkjbo4dpdpkvvg1/kOZr/VsGLWot+iTI8lwQq+CwWXzw+tZMnpL7SEflZgguaORjlIFViX41INJugS5dYHmyK3V2ETPDc/DvJsLKNNtHhp7r+Me39AXP/hxhhglSNsv4WWTWFDg0aYOHAL1A8AfgaNXpLu3jeF+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762725168; c=relaxed/simple;
	bh=KSSGO7Agzs+7TYQ7KKqeAnwYaZ28KPMxXbYzy0PaAEY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qBT0MOcAH5X1BUxXqR1B6CtDsAsW5dHT7OiTSwbSDHo0+LIiiFn+wMqE1fi5iw7NKBEbFU9rakzEf9OLCrwUAH44GNUKA1t6wVCgG0YwYFskadrZpNNiR+gTF9Pq8GaTLK2IaxWgGQ0RLc1y0CS/Pf9nPiUiIzfgOR6Sl7SoQqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ob6C8J68; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ob6C8J68"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b70bee93dc4so316879966b.3
        for <linux-security-module@vger.kernel.org>; Sun, 09 Nov 2025 13:52:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762725165; x=1763329965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vVwXJXq3xWo7DohhoxXnTI8foqK4xMVIwL9L7OpKE7Y=;
        b=Ob6C8J68SNMi/2OZe8EwvYd25JSvqSB+LCZoiIFFsUR4M2y4YXkyEGfGl+ivoYjzRf
         CMM6br0Xn0Hi7m728FeV+cLK0/OuwSp7mKqLWix5KKfryH2MgfX0ahulqujg2inrF3WH
         9GQRjipsCKjjnOk+fIggsJZqYZ2d7CJ8IfJj+rYvlPqq7uE+JX93TOcGp8CyLQe+8t1O
         xE/AIK1LuVj0rexDvh48Z86TByqgRMYFL4FAvAVnDWoGSbaeMgJp5OHptSjK2NZJc5qy
         MQNrFOElc73Fkn+/WwkQif5TFqtlpzw61LiiQpK/2ciWCmdJBYcnPMwuUigGeFuclXRh
         K4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762725165; x=1763329965;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vVwXJXq3xWo7DohhoxXnTI8foqK4xMVIwL9L7OpKE7Y=;
        b=tUp768fRKA++HVyTy267L7zrUNrEK8botGM5R0AGP2mDZ1zQuyN1Fw5KqblP3TIKdM
         D6zfuEzczONrii6Y4yyH74TJQZYy/RwQqM38IH5QAJ/3rXRiTkt56xWYiY5R9lbdOulU
         WUfKvPLri2uG3YuP0ruNVb7E+cYxj5oECfx5rdH6BT8gBJ4Rj9Xp60BP94vyMmFeOR0z
         omDcot/MC4ZKhZycd0ci3JC6S6evP/RF1DASMukLvuKRqozBbLXHciV22wAVbn2cElck
         Bkmif79zNVsPergPE09pui0nYN7qE66y9yPs4DAUW8woY7y6rHeulWe24DCL0S0k21cB
         rHZA==
X-Forwarded-Encrypted: i=1; AJvYcCUQ+k94FXoqmPTYkGqmKPYEpCNgLtNP+1p3lFHjrorCPtMkdrgFIhGzZLo/iAzsPfLOSi9LbiNIn2M4SNODJ5C7Zjd74xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqbAfVTGHQasOP+ALrSxq6w/aZ91uBFD9ChRKnVzlOa33eBX5e
	D41nd6dMb07jJ1mZMzLcKEPXZ9jDDyqVcbU4fVF52fHi5fdT7Fdna4qMnYplXZyMiAjTfdcbjan
	lhgFfJCwOencVs00aMgd4GpmkcjhwpR8=
X-Gm-Gg: ASbGnct/2cDANsTIYng0LkKXg5QutwvtQGBcfXIveDQs2dsqeRf7TFeBEVhU2XRSlR3
	BlzuZJ5xuOlaQ2iGyX0dxSuIk/AYSkElzqjTt+0HOgkL8q6sbWtjZ2iJwLhgaLMV+paH7+lL+H+
	XBQwyqoygmGS86YY4V/TjGeZ7+e43piejuqqxJr/XmjPm4vEsvtno/Gn9zWXWMMC1MNo0/pf834
	R9oilBeKW+5WWK+bkcbOQVurV6SLGhLnru1iPi10Rlk7WsRXM2vSDhTU6TaqMic8pGSbj2SwRIL
	SUrUlw6LVbpWypLIrJVB8oJQRw==
X-Google-Smtp-Source: AGHT+IGm2zklAUKqRRTqPY7KSD4Xj1sW03y/dnI40dOTMnRkZJwmNoipuG5q4hPL908aTtcn44Mm7+NVMASEDBRVfMU=
X-Received: by 2002:a17:906:730e:b0:b71:1420:334a with SMTP id
 a640c23a62f3a-b72e028a620mr608665966b.13.1762725165049; Sun, 09 Nov 2025
 13:52:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251109192940.1334775-1-mjguzik@gmail.com> <CAHC9VhRCvoXrUESCjbxz5Bcxjq8GXLj4GvSoXq+sukdP1cuXNg@mail.gmail.com>
In-Reply-To: <CAHC9VhRCvoXrUESCjbxz5Bcxjq8GXLj4GvSoXq+sukdP1cuXNg@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Sun, 9 Nov 2025 22:52:32 +0100
X-Gm-Features: AWmQ_bk0b4hawYzyDXb9sgQUMhe7v79BweJw0OhxRSsIbcnHE0pse_GzfiY6jM8
Message-ID: <CAGudoHHhLPTktY7tORrJFagxC8xgwM5UzWgrPHsnkGwihBfQmQ@mail.gmail.com>
Subject: Re: [PATCH] security: provide an inlined static branch for security_inode_permission()
To: Paul Moore <paul@paul-moore.com>
Cc: casey@schaufler-ca.com, keescook@chromium.org, song@kernel.org, 
	andrii@kernel.org, kpsingh@kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 9, 2025 at 10:29=E2=80=AFPM Paul Moore <paul@paul-moore.com> wr=
ote:
>
> On Sun, Nov 9, 2025 at 2:29=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
> >
> > The routine is executing for every path component during name resolutio=
n in
> > vfs and shows up on the profile to the tune of 2% of CPU time in my
> > tests.
> >
> > The only LSMs which install hoooks there are selinux and smack, meaning
> > most installs don't have it and this ends up being a call to do nothing=
.
>
> Unless you have a reputable survey or analysis to back up claims like
> this, please refrain from making comments like these in commit
> messages.  I can't speak to Smack's adoption numbers, but last I
> looked in 2023, and considering only Android since numbers were easy
> to source, SELinux was deployed in enforcing mode on over 3 billion
> systems.  Of course I don't have numbers handy for *all* Linux
> systems, and there are some numbers that simply are never going to be
> public, but given the +3 billion Android systems alone, I think there
> is a very real likelihood that there are more systems running SELinux
> than those that are not.
>

Fair, I was mostly thinking stuff like Ubuntu. Phone stuff is not on my rad=
ar.

> > While perhaps a more generic mechanism covering all hoooks would be
> > preferred, I implemented a bare minimum version which gets out of the
> > way for my needs.
>
> I'd much rather see a generalized solution than hacks for a small
> number of hooks.
>

I'll ponder about this.

> --
> paul-moore.com
