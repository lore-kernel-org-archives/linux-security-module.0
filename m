Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAF263C7F
	for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 14:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753368570; cv=none; b=EganzGvinZsf2PUGNhXA9P+zaDvhX0qGGymqFik37T5LDVdlIzRPraR6z1mzmiMTI6eIg/cPJhF8HE1xTfICLh8wWablsPARcRbggt4pzoFCkQdnmXMrBpyBzmzN/MDwTSju/ol8s/rOQk3sPckMtLBDr8TK1sBIpe/el/sJj+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753368570; c=relaxed/simple;
	bh=YmARGcz9wv3OsEhUy+7NgjOpWp1jlbhwdLoF2F5RrdM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bbRcFb/xu9SHlg8xq/+3SdqiQWgacaPWPIG5Dplq+rpPxHJrwWSQVKIJJqh+pCWS5B5nWeYm01vS01fg4tXM9EJBhb7WFvNU63qV7c4d6lG85lDWvtqqxme8Qgm/O5IqTbSiln7PsOKA0X1yF3pUKRSwZmlxtlpwqLVarhiPuH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WLCQBMLF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--gnoack.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WLCQBMLF"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-45611579300so7518905e9.0
        for <linux-security-module@vger.kernel.org>; Thu, 24 Jul 2025 07:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753368567; x=1753973367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YRbxqspNvpyg2zYT0onkzpmjQFDQ7HfOK5gXqw/PXt4=;
        b=WLCQBMLFBCdpg6kLuL5JSZWCDy+t9XMnLugsmsCIYOAyVbuw3HqUTTlu6GaS9RKtc9
         5RfuIeLQhWZN11HwSptXN0I3uiEqAFcWPp/oHmwc3fqzQVYmKULBHcZY0+9F4th/w9pJ
         SQW0++Owog5zGuwcwW9J3z50Ya2NtbE8q5Q+Fo+f8TB9lMGDIgY2FnFRkjkud701O2zF
         pi54V+DKXkc83LxIGNaGIHF7+xSr5fLaKYpkqZK0cAXeDn+R2eOCMlEH9ATtlXb33ia+
         yp43nS6mUxxSnfUQVKb0eV0d/E3ovkL51mkZFjhsMkkXqvD7ghOXoFot3dAMj/6xWUut
         4tVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753368567; x=1753973367;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YRbxqspNvpyg2zYT0onkzpmjQFDQ7HfOK5gXqw/PXt4=;
        b=b6+lKoIAKzWxgYKzF/CFu6MAenOWfn9nvDyJ1vuv97Hb1ZbMAcOqmfwEOcCV5V6DhV
         Un0h0HVNR5nFFqj2/yx7cdJEsS4oFSOdxDzC0Os+ytPPx4yC84cvHw9CfbbbuBF+1eGL
         ryTpg3nB7BnsAn1+PEiyZFnYCA4hHY9NGkDwlCwglQ+afzjkXnyGXB+hCJi7C/8o6WHp
         mnHnd4ybYh5HQowiLlqjGN6S2J+KkZ2e9yfsQrlXXp6Db2fTIl2UlFGoxCdbYZ11H3/b
         AL8QsGxhMIEhxCeLmyD+ZxtJ60/USYLEwpUUBYKcBnMUz1SmTUFdvTw7lEXdBNYLVDXt
         v5/A==
X-Forwarded-Encrypted: i=1; AJvYcCXf25sgKiBQZQ/KnoCRrOVN7atpN+V0zmdziN4ounAAYIJCtFJPh4TDYSdNmEw5ijLgSJ7KCA5TrqRJb3hLCdViUn1KYR0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7tt88H7mjtupKGGhw1Kcbi8qqmvvPM+RaHPGFhQekqqRwcybK
	p0w3456IN1Bzzzb72kv4Jnz1TpitLckufm7IHZZ6QR9wdt1Xl+aU4m4ZIy/ks2az+5k6G1FZ2M3
	HSCogDw==
X-Google-Smtp-Source: AGHT+IFC95NWFAcMCRVE1tz1A3E6NzEiALzu//+2BuWa9o5yv3qmRbvmfvt5gtpiIp0bCUJdV8JgYzWT4ZQ=
X-Received: from wmsr8.prod.google.com ([2002:a05:600c:8b08:b0:450:def3:7fc6])
 (user=gnoack job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:1785:b0:3a4:fbd9:58e6
 with SMTP id ffacd0b85a97d-3b768f01e5bmr5320462f8f.50.1753368567238; Thu, 24
 Jul 2025 07:49:27 -0700 (PDT)
Date: Thu, 24 Jul 2025 16:49:24 +0200
In-Reply-To: <20250723.vouso1Kievao@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250719104204.545188-1-mic@digikod.net> <20250719104204.545188-3-mic@digikod.net>
 <18425339-1f4b-4d98-8400-1decef26eda7@maowtm.org> <20250723.vouso1Kievao@digikod.net>
Message-ID: <aIJH9CoEKWNq0HwN@google.com>
Subject: Re: [PATCH v3 2/4] landlock: Fix handling of disconnected directories
From: "=?utf-8?Q?G=C3=BCnther?= Noack" <gnoack@google.com>
To: "=?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?=" <mic@digikod.net>
Cc: Tingmao Wang <m@maowtm.org>, Jann Horn <jannh@google.com>, 
	John Johansen <john.johansen@canonical.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Ben Scarlato <akhna@google.com>, Christian Brauner <brauner@kernel.org>, 
	Daniel Burgener <dburgener@linux.microsoft.com>, Jeff Xu <jeffxu@google.com>, 
	NeilBrown <neil@brown.name>, Paul Moore <paul@paul-moore.com>, 
	Ryan Sullivan <rysulliv@redhat.com>, Song Liu <song@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 11:01:42PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> On Tue, Jul 22, 2025 at 07:04:02PM +0100, Tingmao Wang wrote:
> > On the other hand, I'm still a bit uncertain about the domain check
> > semantics.  While it would not cause a rename to be allowed if it is
> > otherwise not allowed by any rules on or above the mountpoint, this get=
s a
> > bit weird if we have a situation where renames are allowed on the
> > mountpoint or everywhere, but not read/writes, however read/writes are
> > allowed directly on a file, but the dir containing that file gets
> > disconnected so the sandboxed application can't read or write to it.
> > (Maybe someone would set up such a policy where renames are allowed,
> > expecting Landlock to always prevent renames where additional permissio=
ns
> > would be exposed?)
> >=20
> > In the above situation, if the file is then moved to a connected
> > directory, it will become readable/writable again.
>=20
> We can generalize this issue to not only the end file but any component
> of the path: disconnected directories.  In fact, the main issue is the
> potential inconsistency of access checks over time (e.g. between two
> renames).  This could be exploited to bypass the security checks done
> for FS_REFER.
>=20
> I see two solutions:
>=20
> 1. *Always* walk down to the IS_ROOT directory, and then jump to the
>    mount point.  This makes it possible to have consistent access checks
>    for renames and open/use.  The first downside is that that would
>    change the current behavior for bind mounts that could get more
>    access rights (if the policy explicitly sets rights for the hidden
>    directories).  The second downside is that we'll do more walk.
>=20
> 2. Return -EACCES (or -ENOENT) for actions involving disconnected
>    directories, or renames of disconnected opened files.  This second
>    solution is simpler and safer but completely disables the use of
>    disconnected directories and the rename of disconnected files for
>    sandboxed processes.
>=20
> It would be much better to be able to handle opened directories as
> (object) capabilities, but that is not currently possible because of the
> way paths are handled by the VFS and LSM hooks.
>=20
> Tingmao, G=C3=BCnther, Jann, what do you think?

I have to admit that so far, I still failed to wrap my head around the
full patch set and its possible corner cases.  I hope I did not
misunderstand things all too badly below:

As far as I understand the proposed patch, we are "checkpointing" the
intermediate results of the path walk at every mount point boundary,
and in the case where we run into a disconnected directory in one of
the nested mount points, we restore from the intermediate result at
the previous mount point directory and skip to the next mount point.

Visually speaking, if the layout is this (where ":" denotes a
mountpoint boundary between the mountpoints MP1, MP2, MP3):

                          dirfd
                            |
          :                 V         :
	  :       ham <--- spam <--- eggs <--- x.txt
	  :    (disconn.)             :
          :                           :
  / <--- foo <--- bar <--- baz        :
          :                           :
    MP1                 MP2                  MP3

When a process holds a reference to the "spam" directory, which is now
disconnected, and invokes openat(dirfd, "eggs/x.txt", ...), then we
would:

  * traverse x.txt
  * traverse eggs (checkpointing the intermediate result) <-.
  * traverse spam                                           |
  * traverse ham                                            |
  * discover that ham is disconnected:                      |
     * restore the intermediate result from "eggs" ---------'
     * continue the walk at foo
  * end up at the root

So effectively, since the results from "spam" and "ham" are discarded,
we would traverse only the inodes in the outer and inner mountpoints
MP1 and MP3, but effectively return a result that looks like we did
not traverse MP2?

Maybe (likely) I misread the code. :) It's not clear to me what the
thinking behind this is.  Also, if there was another directory in
between "spam" and "eggs" in MP2, wouldn't we be missing the access
rights attached to this directory?


Regarding the capability approach:

I agree that a "capability" approach would be the better solution, but
it seems infeasible with the existing LSM hooks at the moment.  I
would be in favor of it though.

To spell it out a bit more explicitly what that would mean in my mind:

When a path is looked up relative to a dirfd, the path walk upwards
would terminate at the dirfd and use previously calculated access
rights stored in the associated struct file.  These access rights
would be determined at the time of opening the dirfd, similar to how we
are already storing the "truncate" access right today for regular
files.

(Remark: There might still be corner cases where we have to solve it
the hard way, if someone uses ".." together with a dirfd-relative
lookup.)

I also looked at what it would take to change the LSM hooks to pass
the directory that the lookup was done relative to, but it seems that
this would have to be passed through a bunch of VFS callbacks as well,
which seems like a larger change.  I would be curious whether that
would be deemed an acceptable change.

=E2=80=94G=C3=BCnther


P.S. Related to relative directory lookups, there is some movement in
the BSDs as well to use dirfds as capabilities, by adding a flag to
open directories that enforces O_BENEATH on subsequent opens:

 * https://undeadly.org/cgi?action=3Darticle;sid=3D20250529080623
 * https://reviews.freebsd.org/D50371

(both found via https://news.ycombinator.com/item?id=3D44575361)

If a dirfd had such a flag, that would get rid of the corner case
above.
