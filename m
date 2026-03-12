Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659D139BFF5
	for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2026 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773316670; cv=none; b=nsGRa2FhLLxfclKxE2uaPFZklTen5Q83b5+UeGmbQ6jkTCrsZL+886Of8zhvq29rYW80JjgP/dpkOiaDJNovxmIJbNdrYk/cyGMn+XrPrYZEh7koKMtUqrfGOGOlOFLKQ9Gkf+ICd1N7DRySt/j/6xjSXSE8XH7r9VGkqgTIKyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773316670; c=relaxed/simple;
	bh=CiPkEu0KchtUWqyQAqlfgPp/A8B94UZpV512wcvMAto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cmp3iig/zI4gLOXVEA1JWKRXVhR2dc7H/ap+JxY+9xeXg8z3KNUVrAkfvwc8rUOhj4sIi5jysfvz+4nKjRE1om78NyqXa+/uEEbrQD0FVCBdmhTRndpUhVe5o1Gn8meYV7UB4Lm31felalM6vujVrNB/HopViM7vpo4+fK9/ock=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IM2CRMaK; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IM2CRMaK"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4852e9ca034so9023835e9.2
        for <linux-security-module@vger.kernel.org>; Thu, 12 Mar 2026 04:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1773316667; x=1773921467; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QJCuAOqDAcH+98Bbde1RzlYkCjcB4w2Z7gNrH1RvKUo=;
        b=IM2CRMaK1ivxyeDu6bErH9FQXad+I35y283o4DFdfhA2y0PqrdWQR67MxplDHbkwa9
         njPuqwb+TjEI+SJj73pMpti0+O21VAxrespIoTGY6BFnHVKncwCbPg4TQLWQk7Jvwc6G
         ZqGCMQK5qT4B4iEuBhtl+nSI4xQWm4QKVRsmhvRPm4OXOpzuU2ItXNdO1iZdAQ3hyjzf
         CJgU1wG24KGmDAz32n00P0oiBeUHmpdfVuwjEtKB7gN5K/WfxVjrDywvg07n0cHpjPd6
         7yOK1E1nlQOq74N1+9L7cYTsMMtCA8SGl+c6XMYM1jRCL2d7aKJ6HcQZCdaUfr84BXh/
         4v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773316667; x=1773921467;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJCuAOqDAcH+98Bbde1RzlYkCjcB4w2Z7gNrH1RvKUo=;
        b=oezt3Les1SFQGBc3LivI8k5XebsTHUCv/8qzjubiNAZy7bd/2vEuCCc4ZJw4Ojvl+o
         WS/aqqb1EywKtF1k2DwIepNodKgvftdX76rKl/jXbOOH0H4SzBh9yMIaaCi86gMdmWfh
         NScz+VT8iNGDc+TVkzuQIXGDeLsumEsAJ0vSP5hBVO2SiTYk9Je++ejV9RdoWS2exXk8
         tjbKlYT7Ua+B5R/L3rkQbIjVOO68HV275pT4IqyZjjcveAgJm9zS86gG55VLViRcBmQy
         /FbtNh7KyWVe1WLWbANaGBD9nbtWbKIbiMeIX9QI6D54JO+ZcOLvcYlLjsDBWyMW270t
         yn9A==
X-Forwarded-Encrypted: i=1; AJvYcCVpKO96POf0FqUfvY/LR+2I3j4QSXD9Fy3PxfkdQuAT7/LqEYgraXA5Pi7nDN/T/XoTCWlqA5JNk3UkcxprpW248qmT9os=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsIU+nqjCcA9SVIw61M9qWRwIQ8wy/bWNx8k+XHMfGUlMTBFSG
	a/cci8cnp4ZuM1MEhmRS/yUX+1tC5vv7m+UG2zblNSncl2i4uXSWYyElSfgWrWgABg==
X-Gm-Gg: ATEYQzw0kSEYfpu5gursXzUAkKYMZL9neV+NVHYTans61FQJA5T9oTkaAn3nC/1Smvy
	0T6eWvNMdf5pelLMZrtotqfZ/8clOO9GyarMX8b2HBjOJbT2XbRwTyuIscLgk00DQ407TgMCJYp
	sucRFfwo8HTjM/WnNkdMk/kA5U6pLM34aZvZVp+ycBDIUuTbcGU8ChM2HIIBlYysu8o5KIn3Hsh
	1UTWekDDhzK7ubqpUAQz+TjmpZ2ip8vObpBGo+x8hN/8AfxDDFIbRDdNhBqUa/uoYA3O7BO2hyj
	xBBp56uM2E/h3ruCK4Kj/cySq44agSe5BlAAN+qr7jPOxzlbpFQiSC5n9lsIIPQMEiVwNh3QvCZ
	qtSMu1YNjhcK+0I/vg5hBdirWbFcmmwq7xw0Ehqk1/uJWdl61DGmrOCgla0g6MVX661w0ZQx/3M
	B6CiBey2mVCDe4ODZ3aUtsn4InQzRFVkPwvCuuv99MI3ZPdQIIBt9lYA==
X-Received: by 2002:a05:600c:458e:b0:485:3ae8:2231 with SMTP id 5b1f17b1804b1-4854b11a321mr91026695e9.30.1773316666248;
        Thu, 12 Mar 2026 04:57:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:9b73:b4a8:4aa4:fca5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541ac17f2sm206036685e9.6.2026.03.12.04.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 04:57:45 -0700 (PDT)
Date: Thu, 12 Mar 2026 12:57:39 +0100
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: Justin Suess <utilityemal77@gmail.com>,
	=?utf-8?Q?G=C3=BCnther?= Noack <gnoack3000@gmail.com>,
	brauner@kernel.org, demiobenour@gmail.com, fahimitahera@gmail.com,
	hi@alyssa.is, horms@kernel.org, ivanov.mikhail1@huawei-partners.com,
	jannh@google.com, jmorris@namei.org, john.johansen@canonical.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	matthieu@buffet.re, mic@digikod.net, netdev@vger.kernel.org,
	samasth.norway.ananda@oracle.com, serge@hallyn.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
Message-ID: <abKqM_4_YgO6YsbC@google.com>
References: <aZcPd3OKqxwCZV-5@suesslenovo>
 <20260219200459.1474232-1-utilityemal77@gmail.com>
 <20260219.de5dc35ec231@gnoack.org>
 <CAHC9VhSu=YtE0dMiEtUQgz0pFy5K8cuHh_EWprNtFTDAxhss_w@mail.gmail.com>
 <abFhawSTjNoa-KaH@suesslenovo>
 <CAHC9VhSA=jaKTXg-Tmzzpaj9STGMXH3ZMgQm_XvicimRqdW0+w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSA=jaKTXg-Tmzzpaj9STGMXH3ZMgQm_XvicimRqdW0+w@mail.gmail.com>

On Wed, Mar 11, 2026 at 12:08:43PM -0400, Paul Moore wrote:
> On Wed, Mar 11, 2026 at 8:34 AM Justin Suess <utilityemal77@gmail.com> wrote:
> >
> > On Tue, Mar 10, 2026 at 06:39:12PM -0400, Paul Moore wrote:
> > > On Thu, Feb 19, 2026 at 3:26 PM Günther Noack <gnoack3000@gmail.com> wrote:
> > > > On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> > > > > Add a LSM hook security_unix_find.
> > > > >
> > > > > This hook is called to check the path of a named unix socket before a
> > > > > connection is initiated. The peer socket may be inspected as well.
> > > > >
> > > > > Why existing hooks are unsuitable:
> > > > >
> > > > > Existing socket hooks, security_unix_stream_connect(),
> > > > > security_unix_may_send(), and security_socket_connect() don't provide
> > > > > TOCTOU-free / namespace independent access to the paths of sockets.
> > > > >
> > > > > (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> > > > > This requires another path lookup. A change in the path between the
> > > > > two lookups will cause a TOCTOU bug.
> > > > >
> > > > > (2) We cannot use the struct path from the listening socket, because it
> > > > > may be bound to a path in a different namespace than the caller,
> > > > > resulting in a path that cannot be referenced at policy creation time.
> > > > >
> > > > > Cc: Günther Noack <gnoack3000@gmail.com>
> > > > > Cc: Tingmao Wang <m@maowtm.org>
> > > > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > > > ---
> > > > >  include/linux/lsm_hook_defs.h |  5 +++++
> > > > >  include/linux/security.h      | 11 +++++++++++
> > > > >  net/unix/af_unix.c            | 13 ++++++++++---
> > > > >  security/security.c           | 20 ++++++++++++++++++++
> > > > >  4 files changed, 46 insertions(+), 3 deletions(-)
> > >
> > > ...
> > >
> > > > Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> > > >
> > > > Thank you, this looks good. I'll include it in the next version of the
> > > > Unix connect patch set again.
> > >
> > > I'm looking for this patchset to review/ACK the new hook in context,
> > > but I'm not seeing it in my inbox or lore.  Did I simply miss the
> > > patchset or is it still a work in progress?  No worries if it hasn't
> > > been posted yet, I just wanted to make sure I wasn't holding this up
> > > any more than I already may have :)
> >
> > Good Morning Paul,
> >
> > Can't speak to the rest of the patch, but I sent this LSM hook for
> > review purposes before inclusion with the rest of the V6 of this patch.
> >
> > Günther added his review tag, but I was asked to make some minor comment / commit
> > message updates. I sent the same patch, with updated comments/commit to him
> > in a follow up, off-list email to avoid spamming the list. No code changes were
> > made, just comments.
> >
> > I don't think this particular patch will change substantially, unless we find
> > something unexpected. But the way we use the hook may change (esp wrt to
> > locking and the SOCK_DEAD state), which is important for your review.
> >
> > So you may want to hold off your review until the full V6 series gets sent so
> > you can review the hook in context. There were some questions about
> > locking that needed proper digging into. [1]
> 
> Great, thanks for the update, that was helpful.  As you recommend,
> I'll hold off on reviewing this further until we have the full context
> of the other patchset; we've already talked about this hook addition a
> few times anyway, and based on a quick look yesterday, nothing
> particularly evil jumped out at me.

Yes, thanks - I have been busy with the TSYNC fixes recently, which
were more urgent because it's in the RC for 7.0, but will get back to
the UNIX restrictions soon.

—Günther
