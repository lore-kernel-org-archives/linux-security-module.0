Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C12EA480
	for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 12:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773232496; cv=none; b=bRY+XoIhfbuJdmjkp0I9I8jRfyhamRDVQwhOlQ31IgUowME/w3C32Q+fytWasVRG8Ozz+chz4kBVhskLa3oMUoLcLn3GFufFy5zKQSmezxC+3BZCOKWFb6mlnKmW9sVr8BxYdH6173pHqGTzI5cMKqT5nvOJ2lGhmvo7cumgw5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773232496; c=relaxed/simple;
	bh=4V/FLewYp4qpRJBMOlrGqYSXJ1bd8KpRc1fnh/8a82k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4JZ/q9slfpF56pEXzskZGnevbhoRyQE4iHRK/ept1tGMhtP/xn0Gd2XvUetuch2HUgrQbwUy7Q316K9kAXX5XNLco/9Piq5q4WS0zA8ojxg8WuZcga1/wr8tCRzcumXT5EoDakmEi/pEEIbu1Osf6/RUuiRGSQwugFo7K9XJIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jm+bPJvJ; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jm+bPJvJ"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-64ae222d978so13945462d50.1
        for <linux-security-module@vger.kernel.org>; Wed, 11 Mar 2026 05:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773232493; x=1773837293; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bCTlsnYg7WlwyrXb9b++ZpE0INNBNp3LJgQh0I5kfE=;
        b=jm+bPJvJ5zE2Z91Qq6YgMknCJiN7F3XLqlJmdlKcxF+NQ1GMTxvoidhTjcGBunBYG+
         zt0aTPC93/9syrgsO7ND4e0Aluc+WxOTkyrhxpOKdLNbf0JYEukfjxaTwF/d//qGQWfa
         5AvOAPMumKKLvg0nV+LqEqqVoban4aJPfUe1nfmK1sRZwko3ylLAVpdeuZY6McH9GA86
         OYN+YDyQdWBOHCucTV1WO7Tl725BPnVGhtVQV26kRv/uGanJV1OeKAKWltGxXbMbm6Sq
         3W3E/xf7wmD4GKNC9Jzbd7HRHEIVpXmc8t/8xaptpFZNcnTvN0UFvkJOm7/UEqJlcE2F
         z2Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773232493; x=1773837293;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bCTlsnYg7WlwyrXb9b++ZpE0INNBNp3LJgQh0I5kfE=;
        b=FATtKXDDQKCytAn15cbQBWC9VNMV/Xp81MskUQsGqfl+n/dFhWHc4BY0J7O+Tqp/3R
         ulJ/5NfXSuf+p6lMaKIKtqUQi2FDc0Eb7hmY3gHktvX90WvCAg68LvYlh3/jpLi7Hkh/
         DY50dGJ8Kbr/DQSXcrMtW2yPpq0cH95xPQJrItKy15Kw5HIJePVMiJdz+GGoNzW+h/Fl
         ev4PVaN1Kc3WUSI/9qS7TmcNkGBlkQto3NKha7v90GqxXzQrWPQwbkWb/Q6CXLk8OGe4
         OosZ4t15vGt05vwtCkuCfephIpS8apVcjwV4rcOl5dIZIogCOKp5CAWtYTZUrnkcCROF
         23NA==
X-Forwarded-Encrypted: i=1; AJvYcCUGXfFi4eRpJaqJG7khLv9Vcav2InkhGB5jryMBnesMPI/4Y7lk8rzfrBd1bg5dhDlw61ww7ciGn/jiTQKUpQz6xUdWHZc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtgLmO4MXcnVyfn9DqPZpAe7ey9ViNpOPwYpVEzCLXQRerZp5M
	i8pRECh7b4zKchmV7SToIpZ63cDKHoDXIbAyBcSecgAE7k7PyvGmyCqH
X-Gm-Gg: ATEYQzyYEArvhelfPux1NFmHRzuGv0il6kS4rzJ0HcEJIzBJHQlyuYlx8TfzUn5Xd3e
	0V3Olg6LSgWQ5yl8Ix1LjarjkkTHKLpMmGf05xSjyGhXkqwapCDG3eI2+7tmljrx+quiADZqURc
	gtWvRgI6/5CNppvuOxA7/m8Er3Q2mne0wfFaPXxYgxKqw/JFANpTO0fffn7mVrNZwMAvi4OkGw7
	/03IpZGi/1rqRh4+hTLNg/u/cf/pxeFtp+qSQzavfHCBpg3B6T+6WlclF8g1148bHjZVKnjDWHA
	B5ykGLhzjq12ZFSOveWLX8dpOl5ZiI1d2QyJMWn2W1th7kNV7Cke5K+FVT7IOuKNRsiQAkt/NqJ
	AkSRGSusrw3MS2VuigneLcgWYfyaeQXham0LfQSw+8Ue+mfv6n+yvmjmd3bUuvTO6VKqijEsUP8
	lpu2/ab4AKqQLhr4RAKgNyaQauNaby
X-Received: by 2002:a05:690c:6c8d:b0:785:cecb:4b19 with SMTP id 00721157ae682-79917e8baeamr20238127b3.5.1773232492914;
        Wed, 11 Mar 2026 05:34:52 -0700 (PDT)
Received: from suesslenovo ([129.222.85.110])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79917ee4feasm12115467b3.30.2026.03.11.05.34.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 05:34:52 -0700 (PDT)
Date: Wed, 11 Mar 2026 08:34:51 -0400
From: Justin Suess <utilityemal77@gmail.com>
To: Paul Moore <paul@paul-moore.com>
Cc: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>,
	brauner@kernel.org, demiobenour@gmail.com, fahimitahera@gmail.com,
	hi@alyssa.is, horms@kernel.org, ivanov.mikhail1@huawei-partners.com,
	jannh@google.com, jmorris@namei.org, john.johansen@canonical.com,
	konstantin.meskhidze@huawei.com,
	linux-security-module@vger.kernel.org, m@maowtm.org,
	matthieu@buffet.re, mic@digikod.net, netdev@vger.kernel.org,
	samasth.norway.ananda@oracle.com, serge@hallyn.com,
	viro@zeniv.linux.org.uk
Subject: Re: [PATCH v6] lsm: Add LSM hook security_unix_find
Message-ID: <abFhawSTjNoa-KaH@suesslenovo>
References: <aZcPd3OKqxwCZV-5@suesslenovo>
 <20260219200459.1474232-1-utilityemal77@gmail.com>
 <20260219.de5dc35ec231@gnoack.org>
 <CAHC9VhSu=YtE0dMiEtUQgz0pFy5K8cuHh_EWprNtFTDAxhss_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHC9VhSu=YtE0dMiEtUQgz0pFy5K8cuHh_EWprNtFTDAxhss_w@mail.gmail.com>

On Tue, Mar 10, 2026 at 06:39:12PM -0400, Paul Moore wrote:
> On Thu, Feb 19, 2026 at 3:26 PM Günther Noack <gnoack3000@gmail.com> wrote:
> > On Thu, Feb 19, 2026 at 03:04:59PM -0500, Justin Suess wrote:
> > > Add a LSM hook security_unix_find.
> > >
> > > This hook is called to check the path of a named unix socket before a
> > > connection is initiated. The peer socket may be inspected as well.
> > >
> > > Why existing hooks are unsuitable:
> > >
> > > Existing socket hooks, security_unix_stream_connect(),
> > > security_unix_may_send(), and security_socket_connect() don't provide
> > > TOCTOU-free / namespace independent access to the paths of sockets.
> > >
> > > (1) We cannot resolve the path from the struct sockaddr in existing hooks.
> > > This requires another path lookup. A change in the path between the
> > > two lookups will cause a TOCTOU bug.
> > >
> > > (2) We cannot use the struct path from the listening socket, because it
> > > may be bound to a path in a different namespace than the caller,
> > > resulting in a path that cannot be referenced at policy creation time.
> > >
> > > Cc: Günther Noack <gnoack3000@gmail.com>
> > > Cc: Tingmao Wang <m@maowtm.org>
> > > Signed-off-by: Justin Suess <utilityemal77@gmail.com>
> > > ---
> > >  include/linux/lsm_hook_defs.h |  5 +++++
> > >  include/linux/security.h      | 11 +++++++++++
> > >  net/unix/af_unix.c            | 13 ++++++++++---
> > >  security/security.c           | 20 ++++++++++++++++++++
> > >  4 files changed, 46 insertions(+), 3 deletions(-)
> 
> ...
> 
> > Reviewed-by: Günther Noack <gnoack3000@gmail.com>
> >
> > Thank you, this looks good. I'll include it in the next version of the
> > Unix connect patch set again.
> 
> I'm looking for this patchset to review/ACK the new hook in context,
> but I'm not seeing it in my inbox or lore.  Did I simply miss the
> patchset or is it still a work in progress?  No worries if it hasn't
> been posted yet, I just wanted to make sure I wasn't holding this up
> any more than I already may have :)
>
Good Morning Paul,

Can't speak to the rest of the patch, but I sent this LSM hook for
review purposes before inclusion with the rest of the V6 of this patch.

Günther added his review tag, but I was asked to make some minor comment / commit
message updates. I sent the same patch, with updated comments/commit to him
in a follow up, off-list email to avoid spamming the list. No code changes were
made, just comments.

I don't think this particular patch will change substantially, unless we find
something unexpected. But the way we use the hook may change (esp wrt to
locking and the SOCK_DEAD state), which is important for your review.

So you may want to hold off your review until the full V6 series gets sent so
you can review the hook in context. There were some questions about
locking that needed proper digging into. [1]

Thank you for your time.

Justin

[1]: https://lore.kernel.org/linux-security-module/20260220.82a8adda6f95@gnoack.org/

> -- 
> paul-moore.com
