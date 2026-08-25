Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DBC483BC0
	for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 13:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787665652; cv=pass; b=c1SLjg86L1sdePANEzd0A72KCkugySel9ZzWNJqDtiLGkMzJpu+XwZVGXSQAWwuqEGKZIO0FM1ZeJ4cO0hdhK48KcIGS7pzr3Bqq63oB7y9NZWtRih3bdh6/kwCxVTkNatD1e39HzHMtqvMir5GJoxmowmAWYFAW6zDh1+H0l0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787665652; c=relaxed/simple;
	bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svsh0rI1gusSq2970tishkDN6Nm1BQ/J9g0Y5BFvfMWlhrB4YJxiNPrc6RfH+z5mHVj3Z666eyjzghxlKaMcGwSHZrxWjgOLos8bfWqY5i1RqKJM6BKW8J0/yphWpxFSF2QEbrV9rxYsgq/WJ9cKM8bTMKDB9rI+DoQCgpEN2dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=pQfCLGzK; arc=pass smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pQfCLGzK"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2d3b440b97aso103515ad.1
        for <linux-security-module@vger.kernel.org>; Tue, 25 Aug 2026 06:47:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787665650; cv=none;
        d=google.com; s=arc-20260327;
        b=sx0PFUYIWwRkQDXm9M1HIpHreutNpw+FyflGqAfPkr4+SYfGvqsazMMNITixSJQM6F
         RxRZWvIBZafWKsQPI53ct6x2KOM75sifCYykDhqOA3UuleiO0BRcoxZrtuG1Kn5wSHpy
         Yd17ZRVLxx7fKCk8it1RJCn/gBxIfG9Ve9YAF/d8UegQOXdDnQUZ3X3LcmSEyDmlwSVr
         bLjda2elXimAAi7h5lLdVTPtlyE1/GKviFLg24dDp0YJ7XvR5FCAlkuV4mdTPdvOosnT
         muT+y1d1qLjIFXDvQFtvRZsDHKynWPrCRssnCy0viwG34b9gXP378RpbBEhXc6fBxh/s
         uicA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
        fh=UTtVUWqgA+FO4u2w7MMBvOiH7tyST6rNhsjG/zB2ViQ=;
        b=LIg8Ol6yRg1FJyg0/THwSG30nbfVyblDneT6KRAvt4ZZoK7PAYLO6RE7dYrw/o0v2m
         ro08RCvFm5zX3N16ltxO+6pyMSDsVO1bj6hLZ5pDjxfeFuM5Qy1vuNtOwsg+i8ZCmELZ
         7mgxFDmwcFMfkC78zkW4HO5mtNiVis+DhK24/Pr3IuliD1IudloJh0WRFxbhmRexYOab
         kVh7dORsG28qQVRiGHJWOHR1kEHf9IfetBXALhDm5FcRCRjKmHpOrQtqBMS7Denfr0MV
         +A41spIEc2QWRY0fghhbY4tBOMq6ak11DyLhokcOBXeufmfvfNHHwfdnWp96gWcy2vmS
         IvIQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787665650; x=1788270450; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
        b=pQfCLGzKXbJopNI4+KcVgfsQq1F8p0CjJtsfYdHWRAQkL5eRP+32k1FD8Jt1lDOdKI
         5h0Rspo6RfZObUsE0agFw1NLNHW4HgwVFS/eLezGlS6iW+QeBLLkBaF1up1/qNX57b1M
         oIN3sNEwjYmpkPyNRewHCOhrFGcRVNT94tU9GKJPZeJ2E17RLhVgnBngdEsmaIUwcP3m
         4tGr/g5DrgibwEsm16Tws6a3TcMgyDK7oT2GmfhDqtf2y9lRrIVvcA6/hxhMaHqFCQqV
         yrXQl3Nazf9w87Sxuvi5dcawq6JSLQA7OkOFgns3kHO6bxXFQGmapNRQahbg4i1Zux3j
         b0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787665650; x=1788270450;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f27C2IG9jxEp5m5m+A45U94PwUHYq9WXQ+b1ZTPnZCY=;
        b=DfnrODsrKTH4DjDFy5v24tbifW0YNglgzTk60wbOcxTqdqYcWHqglJwUQTlwSjVuq6
         oIuR7uQHTb0UJ+6F3VI9lrTTeID2s8jsmZyMrLYi9on9pb2TsOeFPzeV76f+Rkfhzvbk
         h24DniOZqUuiGNSyRmafPBcC+3TA17maLKTa7K0/5z3Be1GV6dFgHskaXh71zIORUarA
         2OUXNcJPJGhqMJO0tv7EqwjmZ2A09mGsafh557Pu77am6XvpTG5GEbPCJvNI1He2VV2F
         7M7tNx/69hWec2jXOnfvo7FWm1+82PSabw+litEL7JTISYrQzBp6nbZwjnbKE3fDHG8h
         qbEA==
X-Forwarded-Encrypted: i=1; AHgh+RqHOW6AIXqdHCm3+5Pu21j2FhEj9C+N42woQI0rhyV3MKzQMRs5wEB1kl+QO+6sZw1WNVM4y8z3uJLf2U7K+ylpHlJm8fI=@vger.kernel.org
X-Gm-Message-State: AFuF++mTN7THXxffTTtvIK/Dh1VBPREeVwrVEAEBueoXJLfQd93K3Iq6
	1TMgCFZul9wSxzOeWn7tYL/A4Gwyf6NAo5n+4QWmw4pkBn5bq9Cr6/QozVHdMXKi8hz8JpSmmPV
	WKmoETMfPtcj0kFKTqaPJfyhqOzi2Z1d4dxUAs72I
X-Gm-Gg: AR+sD112Svdh15V0ngWX2xC79Cj6mqKUY3nglGhnwH5JIgg2hbEuwt+W/sMy56PWU+d
	2iFf0aSKj31gekK1Pww6o/7hz6lmYth400y73JrjIYTMAiYpib2GDa3U8Rd+3TSFK2R+UWQm8LT
	CqcAAXjEun6fHjs25gDTK3Y8xJPug6bJQBKHEWZ6p2h7Opy3rmz0da4vTew12GtpQjN/wZRO8f+
	aqSbo4nawMXI8HyvrQygrdEHIcjpAIMi/DECb0l2ULecXIxRsUdOe9V+Rh6nN8oBxEk5TQbpLdI
	HaOGTCFrY6wFXbipH1tlU3Gjl4MFTeaHkRpaEIbRHEUtwhnGXHKJM18gFD+nlHCBMR0EM76rtss
	KljRYqPKuCGScr8p+eqAMR3hi3JHirQ==
X-Received: by 2002:a17:902:c394:b0:2c7:b1e7:501e with SMTP id
 d9443c01a7336-2d6e0833465mr5727505ad.3.1787665649437; Tue, 25 Aug 2026
 06:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-2-90cd2357ee05@google.com> <20260825-passt-semmel-primitiv-37712c04e6c6@brauner>
In-Reply-To: <20260825-passt-semmel-primitiv-37712c04e6c6@brauner>
From: Jann Horn <jannh@google.com>
Date: Tue, 25 Aug 2026 15:46:50 +0200
X-Gm-Features: AcwNN1WZJkxp4obi4wAiUHBJBjq7knCxVUW1syYekpF7g7n4ms28g-sCd7iZ7lk
Message-ID: <CAG48ez22J6tYZv6cG0TEoUFBrbhtWh6BHrZYBWuD-ee1hVr4ZA@mail.gmail.com>
Subject: Re: [PATCH 2/3] proc: query LSMs for introspective mem access (if PROC_MEM_FORCE_ALWAYS)
To: Christian Brauner <brauner@kernel.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	Jeff Xu <jeffxu@google.com>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, Ondrej Mosnacek <omosnace@redhat.com>, 
	selinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 3:13=E2=80=AFPM Christian Brauner <brauner@kernel.o=
rg> wrote:
> On Tue, Aug 18, 2026 at 09:51:06PM +0200, Jann Horn wrote:
> > If the system is running with PROC_MEM_FORCE_ALWAYS, LSMs currently hav=
e no
> > good opportunity to block a process from overwriting read-only code in =
its
> > own address space through FOLL_FORCE writes via /proc/self/mem.
> > The security_ptrace_access_check() LSM hook is bypassed when a process
> > opens /proc/self/mem because this is considered "introspection".
>
> Useful. I ran into this issue just yesterday in:
>
> https://github.com/systemd/systemd/pull/43511
>
> Btw, it's kinda annoying that PTRACE_POKE{TEXT,DATA} still allows foll
> force writes even if PROC_MEM_FORCE_NEVER is enabled. So ideally there'd
> also be a hook for that option.

You need either /proc/$pid/mem or PTRACE_POKETEXT for installing
software breakpoints. I think if you want to completely block
FOLL_FORCE through ptrace, you're probably in a scenario where ptrace
should either be blocked completely, or at least restricted to
mostly-read-only operations?

> The other thing - though not directly FOLL_FORCE related - is that
> process_vm_writev() isn't subject to any security restrictions other
> than seccomp filtering either.

It does go through mm_access() and ptrace_may_access() unless the
access is same-MM, so it can be blocked by LSMs like Yama.
