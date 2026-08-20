Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842C3379EDA
	for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2026 15:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787239434; cv=pass; b=PSrhcJbonsVtTusxKJ8szsFpoZtmkekq+i4NjrN3ZFNopvuDVe0mRmuw6dooSZ8e1VcsKeEUaPj3MwZQrv/2Ag798qQdcx9hJQm2FV1RPZVjqn0jvXiCXv08daceLjQvPf72dcMoGfRKgj3EzFT0aIvVdDYYW0Qe1rEa8oOs378=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787239434; c=relaxed/simple;
	bh=PQ0Uv3fFLVyIJEFAQf/e1k9Wz6QlYJWOA2A7cUy7gUo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MzMxmPOoc5XV4rFpojPUbn3HOFG2wPG4ya2RXWQt2gBbNqO4PFAiYMf0HAG+EBh/jkRwIn1UT7I3J1nouDnQdn6QcERpdEMmSPaThL3UPCPxJ8KTUSzWEPV/x6nCVS4xIB+YeiE2hcUjUSUEIutzj/jcA89J6P+64UjSTGvig/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=noDFYPDe; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="noDFYPDe"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ccdf36f63dso71125ad.0
        for <linux-security-module@vger.kernel.org>; Thu, 20 Aug 2026 08:23:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787239433; cv=none;
        d=google.com; s=arc-20260327;
        b=mrJsbspQAf8o4jZ3iGC/qYab3la/GpC5+NR4Q0IfksAz/4D2SQLCn6CsCD/q61T6rn
         IIGRaS9eYHPqShtrscILRQcu2kVtfpZdOeN7Oa/JSC6G1yghcOu420hOVPBsoFPmzLz0
         V/k/HqImT6FzfM1BxWmtpx2/DHDB9Oa+PbMe3sNqnNcogQAJRwBYhbSm2TOK3kTXUPmf
         ImB8Glu3h9O3g/z0oWgzf02dsP3tnhwxxXmsMupHOmc+3z//tuiCOO7YbAhlK886HT8p
         Qjm/sgMMHB6JFHu5NP7IeRjl3hJy30C+9Yt2d/8vWNC+y/LGcnTOj38jeK/BZU/L+Rt/
         m2lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lma3KONpFpngSE5q14dN/Z1uVUgszHUnJkkI2Hjlr4Q=;
        fh=eso6yrAtHU4Hifd7evKnjmkyFHV38dUsihrawgm9R80=;
        b=LHBqfsvuqb0ky+Ns8KPc2xTV3hG0/jZ9mgcry+BwRY+jHjFPzpXoZvZnv8T5w7oE3V
         Syar2N5idkn6esQE4P0yJS6snp9p1NWqWr1ml4DqdX42IQn2Ku8g0s07KFPtsRRb1PwS
         vaSCVUpZbbk0zQU+HWX1flO/G3bPDY1AwntZ0NcVEgmdBqFokKkGpDm0Fb+1g1k5ZHM3
         2POc6X7Kx5meHSfAdtUnSXgToz2Btfs156q0uZcPDhhPcmLdJJ0yU1/iv9PlNiorhkyU
         lsYLOdmEoz2yslHHQ/J09DV60/3XYdlsv1EMowBY+2iXA/EWzq1w0w6062XoqCujLt+t
         leog==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787239433; x=1787844233; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lma3KONpFpngSE5q14dN/Z1uVUgszHUnJkkI2Hjlr4Q=;
        b=noDFYPDejiltH6Z5HYHHnoLKbKNvBxK/7X421zy0ZEtN9ZY48PRqsUlpy/CbFgtnDb
         GmL/oG6LeakrQ35Xl8ZBN7DHeQMTrKvW2XK7bvtzZ2pfJvTHsDNvHlc5gAseTiQAXsvo
         eeEKGH+09QXLquXcZ65M5eTTOctX2VPP0J55dk+isHR2ryvRq4Wuccl+C5B95XmKPAMb
         kcC7z8fKCLGwQIrvP37cse92VpoG2sQ/A0YnqS5MaO4aEndm1it0NThP6Cak6oANZnA6
         lkcnr1jT+yGHI5z6MDEUqsjq0iprveLmbKDGnMYqXuSUJo9UUnlX8Bv9oKYiiPrDqI/K
         QtQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787239433; x=1787844233;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lma3KONpFpngSE5q14dN/Z1uVUgszHUnJkkI2Hjlr4Q=;
        b=By2EGqPeZB9IdZiTADGqgBAj9txBxPvQ3vizWHqtW5GkVLkm52dX20Pou5n02hO7KP
         bhcyEw0RWJKIFHdKn1tinSyzKKDWTXfBrBqR7V3O3t/yxvykfdw3AugvGrIll2SuPyMw
         v75VHaLGhfEyOdcYSs7YnNmTvK+gfgYCype6/LobdW7JTwXOC5jQsZbonugKwNvww1YY
         +k4a7CQM25zqCC13tCJE5mGF8LxVm6pMh51mtD1/prTJuCBJ3Ysj2Jkh+RtxXdJvUEvw
         W5Moifv48J9R09xe6UzXG8tDqcncR8noEU85qfG8Vci5BagM7Mu0T88yPOrGUlKQhQwP
         hxwA==
X-Forwarded-Encrypted: i=1; AHgh+RqYEWdM+RfW5zwG5lGQbyhXRktQrr+X6MnoyBEBq5V5cyfYxweCBaDDYGB0efGDccSgnWgZeoxVsmehi/8TKbvebeCkmiU=@vger.kernel.org
X-Gm-Message-State: AFuF++mb1QtPXZc0W/Qh3ZcjAIpWYDVAKpykMCTkx0JGL5srZxo9oFxZ
	zOoKwanBkXVY7kM3+Pzpz9zE135u/Xkk6Cna3Urpr9lAgceqf4U6KMm9D3tUVMMvwWCy5kztESo
	CflFV7ZB4DF1mwXNosiWJPDLN96xIczYigrmF8ez5Oaie+7zfrQ6zB4lO
X-Gm-Gg: AR+sD13LNzvaazluvaPyZkSRxivE338uL7EGVhT3HEEtf6N0gQ7M8ro7u0wyigevViM
	Vp0PGOeMkMFojprLW7dNvgi8I/gT+33PXBmRFrMkPuDo79Yzn8pd3C9of1qP0CvPMT5bSuTrIlr
	f6devcNvnLzL9I3yj1xX6M288NzhlCH9vmvZ0Cy/p6vxYDXru7TMgBYYzCD3uoDydt5yiO4t7LB
	Zka+jrAuc/XM1mDxcxqaRgXAJ9VaPsn2Q302Yh4WUnYlTsNoOTsyTDoFNX7LAZ5O7lYMxpwjRHp
	tpncY7X4P1/J82Z2ADO0EdXfuguB8zGGxOyKQY0j8bsau3rdij2XJL+bl6wMtyl9c/SQBROR6z4
	m8Wg8JoLwoUjlkdhQf8fROZ9yEAJPOg==
X-Received: by 2002:a17:902:fd8b:b0:2d5:db38:8013 with SMTP id
 d9443c01a7336-2d61eaf0bdfmr8352105ad.18.1787239432253; Thu, 20 Aug 2026
 08:23:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260818-selinux-pokemem-v1-0-90cd2357ee05@google.com>
 <20260818-selinux-pokemem-v1-3-90cd2357ee05@google.com> <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
In-Reply-To: <CAEjxPJ714iCMiQRVAN6MQoOyNx998MS5Xfhbhmugcwz+gWYAuQ@mail.gmail.com>
From: Jann Horn <jannh@google.com>
Date: Thu, 20 Aug 2026 17:23:15 +0200
X-Gm-Features: AcwNN1WfGO0jtM01Prl7T2bhwvtOuD_4x4w_Hjk9Mm13CRcqjZxrghBAfwYQIPw
Message-ID: <CAG48ez3h2Gft4onQ8AgBmf8gHrF26YqTinajuBysNPkUKaTBoA@mail.gmail.com>
Subject: Re: [PATCH 3/3] selinux: require EXECMEM or PTRACE for FOLL_FORCE introspection
To: Stephen Smalley <stephen.smalley.work@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Jeff Xu <jeffxu@google.com>, 
	=?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	linux-fsdevel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Ondrej Mosnacek <omosnace@redhat.com>, selinux@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <liam@infradead.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 4:54=E2=80=AFPM Stephen Smalley
<stephen.smalley.work@gmail.com> wrote:
> On Tue, Aug 18, 2026 at 3:51=E2=80=AFPM Jann Horn <jannh@google.com> wrot=
e:
> >
> > On systems configured with PROC_MEM_FORCE_ALWAYS, ensure that a process=
 can
> > only create anonymous executable memory via /proc/self/mem if it has on=
e
> > of:
> >
> >  - EXECMEM (like for other methods of creating anonymous executable pag=
es)
> >  - PTRACE (like when using /proc/$pid/mem of another process)
>
> Allowing it if _either_ permission is allowed is unusual in SELinux
> and seems prone to errors.
> Is there a reason to not just require PTRACE always?

Hmm, that might work.

My two concerns about that approach are:

1. This is an operation where a process acts on itself, while PTRACE
is normally for acting on another process. It feels to me like those
are different types of privilege.
2. I feel like blocking this operation even for a process with EXECMEM
privilege increases the risk of breaking existing configurations.

I think if we want to gate it on PTRACE, we might need to put this
behind a policy capability and let policy authors figure this out?
But I'm no expert on how new security hooks are normally added, or
what SELinux policies outside Android look like, so if you think it
would be fine to just check for PTRACE, I'd be happy to go with that.

(I've caused stable regressions several times at this point and am
trying to avoid causing more...)
