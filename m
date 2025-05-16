Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6DA19CD17
	for <linux-security-module@vger.kernel.org>; Fri, 16 May 2025 18:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747418817; cv=none; b=BugEmx31w9yqCN9LbXlSZWkm3ieA6vlIsLXDt+bOUAa0dFCvRqZC8DsNCSqrvU6MUxdq40lR9EzYAx7N8VLbZjMTWB5530J4CGFGxpOf4aQkBhhtLXtLOIK+brTiswJ3nr24cWMXmk9lJBp8xpwQk+8hEzLYnGavcNNGD3ZiN+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747418817; c=relaxed/simple;
	bh=EaGhh9y9W0mWJ2B10mg/vhu02sSfHCRzfLE0DGJv0cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Gy89d3fMsjtD27kFLNFFXfwJEYSQbCGD1caQ0QpuHcBrryXysEd9EsMh/rdY3+QSnrfU4d6snb/GF8BJFIXY6x73apTBDJb4Ccy7bGIyrQlUNKtHnN9dG18LIfwDWjHj6vSg0VDKpiCN9OL7Q83pz5YZtLtXfWaHZhT4T+M1iAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yv5/rPHL; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yv5/rPHL"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5fce6c7598bso1220a12.0
        for <linux-security-module@vger.kernel.org>; Fri, 16 May 2025 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747418813; x=1748023613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ffBJsle0Lwjz8ccEmGsxhnpnfJLHOgF0YGAm3DFQxjI=;
        b=yv5/rPHLfOC52xCUvO3ijjcn2nup1tXhC3T8uA8ZcL8G5hKRWrJbTBaVpYTYXOtJ0C
         0RkIj8exEquEIept8NAp3pGfo82aiIx7bVM1E0gDee7f4AalbEUJpAzkOHj55N7LTBa1
         SHS7zyhzAifbN9KL6qtnBOYQsBr5BwzuniUajjPdZZmOS0l4yEwNz6bMA7/7RIogVpEk
         Chk/ZLTfxn7sGZp+XrC+qoWbC86DEeRI+rOeNZXf6yaCYptWG1JqTWW6AAjiZfBB1nLE
         KhcaNpVWGrOfsvRUrqhunuZIPK9MQCRBBplLQgE87aSNH0bSX+SoqudovrlbMQI2uzNc
         xIPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747418813; x=1748023613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ffBJsle0Lwjz8ccEmGsxhnpnfJLHOgF0YGAm3DFQxjI=;
        b=k0qflvF63QxFRl21ssn/XX6iQAdJidWkFdlGYwpZUWtjeT48Lh06rEGgqcRNXFCRZD
         uf+OvKtRxti2u9TzEzq8nEYkQ4SwSS96U/afvYs/E81fINWrmXF3yBnT4CI+Ebjqeqrc
         6YgE0EIAIwWrwjYvTJf45alDWn1AJBSr3IgTYYz2gcorZ26LgfD/u4FzdlxI+amqcXLx
         OfCowuE/i5wXGMLcuR+xOo/64zZ7XEwsrieM5MGiyZif/5OzlouWWeoy2hV3nTCxYjTQ
         7L/31+x1Zo2MZw9BO03MgoO8DligwTFh4TZioHZj+fzWOzlkoCnUHKD7cgRtULEZ4Iqj
         1drw==
X-Forwarded-Encrypted: i=1; AJvYcCU9GqVMERGLpn+xxX1MgUq9E+mne/Vq26BkQjm8q7RQhSpePixsmST79Rh/RqhZcXSnWyfrqFKMsyOIkYdqO6YfUMOx6XM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcfwARFHRgMsAbmxO86tNh9eyNdDuHViNuJI+c8Z7XTe+Vosh+
	EDtHFGKEv+zOVkT0e3Kp0VhJzpCMUG+vWmR5Fhvgc5+p4muIM8dsTIPILXUOTA3KZkm/FU6XOTS
	pLv97GVAGNWW0qmp7TzdVsCeR9qbCEA6GeDAYqfkn
X-Gm-Gg: ASbGncumv+8OG06YySTN0/8E5pXseKtCS97fdm8ndyril+pfpdXCSNoq7n3EkcjXEl8
	ne3ynDGtanqwCiEyWMso8+yKSIkdo5V+7Dn4jzq9Z+yDXW0qrURO7ijCNYLDv9ejHIjc1/lPg7M
	QBJjwbM26crw9Ux6DT5MNPbzyrb4W/i5l+EBF8KDbHKraNCHH3L5K135TPiUDMaQarGlcXu30=
X-Google-Smtp-Source: AGHT+IHjVT1gKmVLBj3knAgZ7m159qYk3Ok4v0D1Bg/SE2WIJQB4Z3hZw0B78cj70OkvwZmrrSyMeN4kzMZtpVX3b1g=
X-Received: by 2002:a05:6402:f85:b0:5fd:28:c3f6 with SMTP id
 4fb4d7f45d1cf-6019c8884b4mr2262a12.4.1747418813012; Fri, 16 May 2025 11:06:53
 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250306082615.174777-1-max.kellermann@ionos.com>
 <878qmxsuy8.fsf@email.froward.int.ebiederm.org> <202505151451.638C22B@keescook>
 <87ecwopofp.fsf@email.froward.int.ebiederm.org>
In-Reply-To: <87ecwopofp.fsf@email.froward.int.ebiederm.org>
From: Jann Horn <jannh@google.com>
Date: Fri, 16 May 2025 20:06:15 +0200
X-Gm-Features: AX0GCFsTNJfHA0lDPOLsfx2AHvwhpi8BaLe2zu9yZK-Y_kwCHJr4mJE3cbEsjCU
Message-ID: <CAG48ez1VpuTR9_cvLrJEMmjOxTCYpYFswXVPmN6fE3NcSmPPVA@mail.gmail.com>
Subject: Re: [PATCH] exec: Correct the permission check for unsafe exec
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Kees Cook <kees@kernel.org>, Max Kellermann <max.kellermann@ionos.com>, 
	"Serge E. Hallyn" <serge@hallyn.com>, paul@paul-moore.com, jmorris@namei.org, 
	Andy Lutomirski <luto@kernel.org>, morgan@kernel.org, 
	Christian Brauner <christian@brauner.io>, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 16, 2025 at 5:26=E2=80=AFPM Eric W. Biederman <ebiederm@xmissio=
n.com> wrote:
> Kees Cook <kees@kernel.org> writes:
>
> > On Thu, May 15, 2025 at 11:24:47AM -0500, Eric W. Biederman wrote:
> >> I have condensed the logic from Linux-2.4.0-test12 to just:
> >>      id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(new->=
egid);
> >>
> >> This change is userspace visible, but I don't expect anyone to care.
> >> [...]
> >> -static inline bool __is_setuid(struct cred *new, const struct cred *o=
ld)
> >> -{ return !uid_eq(new->euid, old->uid); }
> >> -
> >> -static inline bool __is_setgid(struct cred *new, const struct cred *o=
ld)
> >> -{ return !gid_eq(new->egid, old->gid); }
> >> -
> >> [...]
> >> -    is_setid =3D __is_setuid(new, old) || __is_setgid(new, old);
> >> +    id_changed =3D !uid_eq(new->euid, old->euid) || !in_group_p(new->=
egid);
> >
> > The core change here is testing for differing euid rather than
> > mismatched uid/euid. (And checking for egid in the set of all groups.)
>
> Yes.
>
> For what the code is trying to do I can't fathom what was trying to
> be accomplished by the "mismatched" uid/euid check.

I remember that when I was looking at this code years ago, one case I
was interested in was what happens when a setuid process (running with
something like euid=3D1000,ruid=3D0) execve()'s a normal binary. Clearly
the LSM_UNSAFE_* stuff is not so interesting there, because we're
already coming from a privileged context; but the behavior of
bprm->secureexec could be important.

Like, I think currently a setuid binary like this is probably (?) not
exploitable:

int main(void) {
  execl("/bin/echo", "echo", "hello world");
}

but after your proposed change, I think it might (?) become
exploitable because "echo" would not have AT_SECURE set (I think?) and
would therefore load libraries based on environment variables?

To be clear, I think this would be a stupid thing for userspace to do
- a setuid binary just should not be running other binaries with the
caller-provided environment while having elevated privileges. But if
userspace was doing something like that, this change might make it
more exploitable, and I imagine that the check for mismatched uid/euid
was intended to catch cases like this?
