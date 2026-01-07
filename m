Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07E4280329
	for <linux-security-module@vger.kernel.org>; Wed,  7 Jan 2026 07:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771227; cv=none; b=RGmeOhvpDoFYMbng4+7QfyUB4+WEH8pYfPTN0ipsXnr9dLc+kchTy3aj0Sv5oOJOydDZrFhBW5/7ehLWvhavnTusQgJ5KvqXrrpugok2Q/Xok/6SrTPwpFerZANvIaota3wYZEjGI8/c2QOfF02RN0jiB3EuLY1l6D0GSdx/6cY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771227; c=relaxed/simple;
	bh=DqDSpwcYbNYLl1aM0TIWsuAfF70N/EEM8oLleO/iIYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pd0F87ej8DK/LVWhP4lUj3+bo7XKlTEV5kFR5QdF+H9eVMgFuoggrm8LO+R2qLSOP1LpB66KogU09wqVvtgjgqiQC7K/ukKVhv0GJyh//gzOoXIWyp/70izNVYJV2oQmB+WK+fa936PuLK8/DwN6R8czwn9vhFLszd5eQ74aX+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nu9mPLFl; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nu9mPLFl"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-11f36012fb2so1505526c88.1
        for <linux-security-module@vger.kernel.org>; Tue, 06 Jan 2026 23:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767771224; x=1768376024; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AYGT8bDi0cltarggyS89UVlr8I1trzzHf57StlSFRxg=;
        b=nu9mPLFlQLFcXvYMdpBsB/O0an09BuHjlbGv4n3ValpajYAd8oryCLw7PzYBMMjMdL
         eTxsfwK2qFou9sKdWRVstuAGMaT7gV1rgdVNqVm/5xVGd4b8sLhlXhWYibDgd0Gk+MCu
         3n25Gn0MuAK3Fo8J27jBTGobTwVj8j5fDYkisgDsTKKlwOKP9R6JgzTVhdfUbJRo4K53
         OeJObygvs5fWQ/2Wf0tdvC4To1GRutNr4aQm8frfU9XAmp9hzpOBRhHS3eoaAEpO3zL8
         MtlJaWX7w3FblM2gnqUKn3jath67T2Y4QbYUkpIvr7M9F1B/8UZK/tVaz36NGLB3kuPB
         tJwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767771224; x=1768376024;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AYGT8bDi0cltarggyS89UVlr8I1trzzHf57StlSFRxg=;
        b=NHP7aEh5xNI9OmAJNtBFMK4wZf1d3HPZYCndoQMFNSIIyrI3j818lCr03ZFrVE+qb2
         2U2Dlt8QEY9SRJV9V+SnqB1lhpgNB3dzSYk329NL3ztAX/O7oHTj2L25SHVtYLq4ceih
         o+Mx5jMw14Rhi3t7fJqb+r9mDYz/0Nuqo6SvWuEZ/sx2x20pASw4+HF+NJifzw/0rMmk
         MqCg67BmR5URt7/SpCMIg+glT40j9C3gnMlUts4aqwVIqW7kGm/TrDwc0u7/dNYIed8K
         RoTDJri3aPoqnHmgTjTiSgtBNfkcsWnXJJLEccpc2LSLdwdbIUx+ComFVsYkj2EOUEOd
         rA2A==
X-Forwarded-Encrypted: i=1; AJvYcCVH62Ww4M/NVhJbN0OWxa6crSrxGrUHEKugTYadVL9NbqGA4ROO23NL5Wba6XqhvYC4Cq3nID9+3K2JowEDtA8nZZ32Xgo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxic4ewUSZO9550rnJZzjq+Enc9AFl3b4ch+nYMz+hj1v38ggBD
	OqHaY9+0p/8i+N5IRCHZ+ZukuHYXh/j2VLtR4T11wEGwis4nbsvjhZ50BZN/w45FHuuCbxYjwVz
	dA61ZB6loQHXjGYvxsv37LZvxEqmrbXsYoqN9m3wr
X-Gm-Gg: AY/fxX5VJi0CteBMkb6RKsT7Qq+8pq+mx7Rry8+3yLiGHGt9bbPZ0OuXLvEAMgHB8l6
	MYJW9FSf2x85Taz82G02gdN4LggypsAm1aSCLECu3LXKoRQdImRFtinfvHyBNq2e8lNZD9wntZl
	LA1bczEi6KuILSBqdVg5AoE0qFxhD7VSNM03W2EjzCbKnoKGgI2HnvhNtTACI5ke/1eSPmbMlGY
	iTLOEL8vwFUTy8tZLd6yhvYS/o8GRee5B3UaU2kKWoWTO/JFRFlrESWsNsBoZ+zPPXXZi3DSG2u
	piseWrurBfwQ4glKFqxY+17bEtM=
X-Google-Smtp-Source: AGHT+IGVWDaAAufKG6cmY61WIEHpz/DCkMzHNAMA7Qq/9XczEH9ksqtPnuAAKTZpAqiEaew+WJqsmTkoKXiTFbLDgrA=
X-Received: by 2002:a05:7022:41d:b0:11a:342e:8a98 with SMTP id
 a92af1059eb24-121f8a3172fmr1585843c88.0.1767771223553; Tue, 06 Jan 2026
 23:33:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251231213314.2979118-1-utilityemal77@gmail.com>
 <CAAVpQUCF3uES6j22P1TYzgKByw+E4EqpM=+OFyqtRGStGWxH+Q@mail.gmail.com> <aVuaqij9nXhLfAvN@google.com>
In-Reply-To: <aVuaqij9nXhLfAvN@google.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 6 Jan 2026 23:33:32 -0800
X-Gm-Features: AQt7F2oljSqURSVX-s0tTsTMpeCMLJQxfW23hgyHnAzDH_XdW9vmaQD1ns9eGvg
Message-ID: <CAAVpQUB6gnfovRZAg_BfVKPuS868dFj7HxthbxRL-nZvcsOzCg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/1] lsm: Add hook unix_path_connect
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: Justin Suess <utilityemal77@gmail.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>, 
	netdev@vger.kernel.org, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+VFS maintainers

On Mon, Jan 5, 2026 at 3:04=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.co=
m> wrote:
>
> Hello!
>
> On Sun, Jan 04, 2026 at 11:46:46PM -0800, Kuniyuki Iwashima wrote:
> > On Wed, Dec 31, 2025 at 1:33=E2=80=AFPM Justin Suess <utilityemal77@gma=
il.com> wrote:
> > > Motivation
> > > ---
> > >
> > > For AF_UNIX sockets bound to a filesystem path (aka named sockets), o=
ne
> > > identifying object from a policy perspective is the path passed to
> > > connect(2). However, this operation currently restricts LSMs that rel=
y
> > > on VFS-based mediation, because the pathname resolved during connect(=
)
> > > is not preserved in a form visible to existing hooks before connectio=
n
> > > establishment.
> >
> > Why can't LSM use unix_sk(other)->path in security_unix_stream_connect(=
)
> > and security_unix_may_send() ?
>
> Thanks for bringing it up!
>
> That path is set by the process that acts as the listening side for
> the socket.  The listening and the connecting process might not live
> in the same mount namespace, and in that case, it would not match the
> path which is passed by the client in the struct sockaddr_un.

Thanks for the explanation !

So basically what you need is resolving unix_sk(sk)->addr.name
by kern_path() and comparing its d_backing_inode(path.dentry)
with d_backing_inode (unix_sk(sk)->path.dendtry).

If the new hook is only used by Landlock, I'd prefer doing that on
the existing connect() hooks.


>
> For more details, see
> https://lore.kernel.org/all/20260101134102.25938-1-gnoack3000@gmail.com/
> and
> https://github.com/landlock-lsm/linux/issues/36#issuecomment-2950632277
>
> Justin: Maybe we could add that reasoning to the cover letter in the
> next version of the patch?
>
> =E2=80=93G=C3=BCnther
