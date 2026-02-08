Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E53F258CDF
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 20:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770583042; cv=none; b=fxwCjK/XZ+mneNVzNXo3B1luG/0fIlK8h1PG2PRrjvDROyzs4BGwveAutOUXs6kBJE9Rsr67NS5IVKrgnJw/IZb3JCVJ+va+KWKvZGH2kuIZqmR/s7RpCOSOxupaIs0iPR8F0GJyfx5SiW6rU11Y4cVy+HoTEEUs3IvSvk3Fl6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770583042; c=relaxed/simple;
	bh=w08k6xy6hjqgnw0SmrCWnuQJY40UQ/pV4xm6A3EJgfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFt+W5w4x/Q+/H6YgHomSHoxdggqmcM4xZhlXiPDtpz2bpY4/ozCMbrQFbScfn9Ci9/0DFXkf6ZLDO433AaHAs/MGeu7Y9/hkzWEdoxw75OkbQuefce9FH3Tvxfu7lfiCUNDGp6nDS9zSVg0VK4WYihtDP9+qgK23VkQy6V9K+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eW2z9jUz; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eW2z9jUz"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4833115090dso10632915e9.3
        for <linux-security-module@vger.kernel.org>; Sun, 08 Feb 2026 12:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770583041; x=1771187841; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6BpUYMZxQyr/wf/cRcsta2QKgSGupSQ3KHgGtwXPVgI=;
        b=eW2z9jUzEmbKXKuybUXYMN+ziiSqckjW0y1xNk+Ks8Y2xTIwcuXJNtVfPzS5YyzoY1
         nXu81r5K7ULCxoUCKRsnepE1fJRi4r6x5Jj3BrvHnTwvOAJjOmgugddyormbL+Pnysd6
         XHEchapW1EIU9fY5ATV1jziwtRh2KAJ1YIxMp/1h6a7nNsz1Ehr2waNdheXKfjouhpau
         83UeZksS3DmRtjUZvbr77ZYZSpBTmTASG33iS9FqZ2ZIN/Xy3jOuuH6FU8FU98F3DvPu
         ZDV0jne0oW/mzV4CjVdZS8C40PqmilVYxtNOE/cyF0aqco33j2I/aK3cufkVz3kAbaLJ
         K5ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770583041; x=1771187841;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6BpUYMZxQyr/wf/cRcsta2QKgSGupSQ3KHgGtwXPVgI=;
        b=GujVjC8Xo1og6a0dNP4YWw/hpatVCvMyWKIj1lAlWbAd7qJuFYDdTXWFBok6LI21yE
         ZZFe11Dog+J85srLHSu1hathCoE2xhvQh0wOBusmo0OHbcKEAHOrLxgl6Gl5bupm8oMU
         xSjdwROAey6CBdir8MxUAqOWPhgLh5X2LM/3fwsoXo0V4oWBMy8jntxZJsZuF6t3Zfo6
         zgidpxTDh9xgtSPA/P68mREcwE6urqdE/MqYUY9D/zZjytHMBwK5La87j6IPhKHpTyhp
         paPi+xhyftsUvFIQqfglnaMWy4xoWqsMpKmLfPJ0EUkVnWIWJ5KSNP30uQ2gGyy8rbm8
         ivbA==
X-Forwarded-Encrypted: i=1; AJvYcCWgEAOnCkfM2KP8VeN9Q9R+jd1jmXBlJTwlIofmV9NeJCm0gjjaxfcLqolhP2AXEc2Ywl0eKPQKKkcLP718IeBnkBQ1zHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWbqFx33PRDyyE9/FMUIyxqWLlt+pcCJHuHy1QoLJJaQF/Hxs/
	lt/OansYwlOjheYexvy/+dDWjjIzuquzC8e8fGiZE3FNYAZb2gx4+ldR
X-Gm-Gg: AZuq6aLyXPpn4C3wTPEcaXcKZvwK0NKB4ijxrJO3HjflgA5xTbXPDgaKyOf1bjfPRhA
	S4tNvwTMFUHNKLI5eVvKEg3SGBUJzJ6orBJ36uPG7LnhCtcssOjIxKlcZYN1Na237EjZJQcjeiX
	RzKheid+2t4Vw3TaFI845EgNVZZnXo+aMbpKBKmnh+3jGd8i6KrZq7fWrTTQx0C1uhAngnAVuC2
	FFwV4G0JN1SxoyUpqTmhqeLFxe8mluIZaV08uTEsKmXY577ScthFqmRxICc+IT3oxYBPmjQPsU0
	+//6ezc/M+oqcQ+S0Mq+BGEXBLpdpy7Dz5n4gBsDvCsjWOxmTCUoaopAYbt6RL4gTxG6l98vxyJ
	Oea5Wfp3ely0LWOfef1mfONh+wlYH5eIS3iSu8qJOPuT6ZrJdy0jrhy66LSIuIZoOLF7ownzpqa
	j1eHsvBOu1JCJ6hH1wby1Gum92xGeEwSTZw/vd
X-Received: by 2002:a05:600c:46d2:b0:480:4a90:1b06 with SMTP id 5b1f17b1804b1-4832022c31fmr136270595e9.34.1770583040309;
        Sun, 08 Feb 2026 12:37:20 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320719b8fsm211356065e9.9.2026.02.08.12.37.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 12:37:19 -0800 (PST)
Date: Sun, 8 Feb 2026 21:37:13 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Tingmao Wang <m@maowtm.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	=?iso-8859-1?Q?G=FCnther?= Noack <gnoack@google.com>,
	Justin Suess <utilityemal77@gmail.com>,
	Paul Moore <paul@paul-moore.com>,
	John Johansen <john.johansen@canonical.com>,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	linux-security-module@vger.kernel.org
Subject: Re: [PATCH v2 0/6] Landlock: Implement scope control for pathname
 Unix sockets
Message-ID: <20260208.4600394b9da7@gnoack.org>
References: <20260202.uu0oCheexahY@digikod.net>
 <8093547c-ab40-4814-ac9a-8dff6f2a2a90@gmail.com>
 <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
 <aYMxHRwHCao30HfX@google.com>
 <20260204.quaiyeiW9ipo@digikod.net>
 <20260205.8531e4005118@gnoack.org>
 <20260205.Kiech3gupee1@digikod.net>
 <ee38960f-8670-434b-9cf1-d95995b228da@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ee38960f-8670-434b-9cf1-d95995b228da@maowtm.org>

On Sun, Feb 08, 2026 at 02:57:10AM +0000, Tingmao Wang wrote:
> On 2/5/26 10:27, Mickaël Salaün wrote:
> > On Thu, Feb 05, 2026 at 09:02:19AM +0100, Günther Noack wrote:
> >> [...]
> >>
> >> The implementation of this approach would be that we would have to
> >> join the functionality from the scoped and FS-based patch set, but
> >> without introducing the LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET flag in
> >> the UAPI.
> >
> > Right, this looks good to me.  We'll need to sync both patch series and
> > remove the scope flag from UAPI.  I'll let you and Tingmao work together
> > for the next series.  The "IPC scoping" documentation section should
> > mention LANDLOCK_ACCESS_FS_RESOLVE_UNIX even if it's not a scope flag.
> 
> This sounds good to me.  I'm not sure how much code we can reuse out of
> the existing LANDLOCK_SCOPE_PATHNAME_UNIX_SOCKET patchset - but I think
> the selftest patches could still largely be useful (after changing e.g.
> create_scoped_domain() to use the RESOLVE_UNIX fs access instead of the
> scope bit for pathname sockets).  The fs-based rules (i.e. "exceptions")
> can then be tested separately from the scope tests (and would also check
> for things like path being different across mount namespaces etc).
> 
> Günther, feel free to take anything out of the existing scope series, if
> you feel it would be useful.  Also let me know if you would like me to
> help with any part of the RESOLVE_UNIX series if you feel that would be
> useful (but you don't have to if not).

Thank you, Tingmao!

So far, the selftests that I already had in fs_test.c were
straightforward to extend so that they cover the new cases.  I had a
look at your patch set, but found the scoping tests difficult to port
to fs_test.c, but I'll double check that we don't miss anything.
Either way, I'll make sure that you'll get appropriate credit for
it. :)

–Günther

(P.S. If this mail looks familiar, it's because I accidentally replied
with an earlier version of that to the wrong mail earlier today
(https://lore.kernel.org/all/20260208.b25c4105bc03@gnoack.org/) –
Replying here again so that this answer makes more sense.)
