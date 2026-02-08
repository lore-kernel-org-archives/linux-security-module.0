Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E152FFF9C
	for <linux-security-module@vger.kernel.org>; Sun,  8 Feb 2026 23:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770592897; cv=none; b=Vv5hxl8WUrkXQ3UcMihRkgAJZWxd4MPNObxILV52QymX//8sbUOntDagghhPqgCpow+5i2aT7zauKkAMoJimBZl09PptZoqh0RL338mQPFoQ3WBL0bnyK7lIU5x1JxZIY8snUdQNh1JfVYTQxJWIn/m2JvfDgpg31W8CZkPGHEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770592897; c=relaxed/simple;
	bh=6mznC6HbFaUhkFiSM0EiJq+2tWa0FZvrTd6czN8KerU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdC227k9pWnfWp7LieytVfzXARcHxwpoBu6YEK4Yox83vKpO/9RdiRnE9IYwq0gpmHU3Swth/oCmZAQ9b2GLiIFEUAdDw2U0t3zHXm27DD7QBCZZDLBmgd+3xn7Su4Ob6cM4kKd/NRZbcxFbWDcL4ZjFf+nvEa+vliZfgF5JDk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MPtwndB9; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MPtwndB9"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee07570deso20348635e9.1
        for <linux-security-module@vger.kernel.org>; Sun, 08 Feb 2026 15:21:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770592895; x=1771197695; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=daicSj91Gb4Mp30HPR+0/Ymmsuk76wG0kdSub0yLPKE=;
        b=MPtwndB9rmj+UsffGBUZ1eT+MpIDF+14F6lqBP4PL3iykO/I68w+DDzCDEOXxwXIp+
         41NDEqCWJBXSM5XKuj076wkpmroW6QijSZL5eDV3uNbpCD58RqSrQqzCOZCAUYDuiuIl
         m6xWsUTQ/AMeYrLMQLI+1y+dzjMu+FNHVpvOTq4FM7DrgfBmPUMObTQ7nbnx7yZAYDnY
         G9HU3bCjcLkJSnCA0qljGe3eSJl/bkCfyfyAKxW9bTyHhmXD/YhGz9Yao53MctW2FtMR
         D8EEwjxQpq83/nJ+1DB8JLJhRzZJNsfMZOCMf5wzPNI5+BH3mV2k5ao1mYC7g+/HoQEQ
         UZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770592895; x=1771197695;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=daicSj91Gb4Mp30HPR+0/Ymmsuk76wG0kdSub0yLPKE=;
        b=q3o0u4vHCC8oaXs6joNM5TemXkbLzyiyPEyHE6wVWOKvA5yQypeVwPkfTph3Wo48wC
         GOwGcJCxKyFXQHb5Zp5muFEG2EDi1jkCAquuayTEVYPt4woLZX5eUXJzK7mIS3D9X/X/
         iBukh9284kLXR1XhgEqj3Q47b1vvPanvRcXPCaGPV4RrDzkaPVr/DolIDgO6uhZJjlij
         pnUR49oq+8AdqzzY+/8qAKOvEGXfmbXuwkArdMoEqu/FSJBZln/fzOkj3TkJ4XGt8ou8
         jD5TIyIfucycVnzrcbgGoHI3tImAPgBJ78pnsPXO9K8ipvHXSZxSn1v4iW75wAukac9W
         Mdlw==
X-Forwarded-Encrypted: i=1; AJvYcCWALP1dcV64cjmCgyLYkN+EqMFPZjCipWJmg+m5Rou9SJVFQ75JONO19DjFh0itvP1VVjDnDpHdLW7RvP54lrlrWC7nyxY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu3CyIAUgvMWMToBTyRKZSS3eNa1TwpvdbsFikINRDOsGabm9E
	TIzenB99O/QyZv9ylxnECrq7TKq7I4Ijni0kQL0KW0o4FLIgYiXWA/SV
X-Gm-Gg: AZuq6aKvGuCXEh+g3YcZ4ucCckywLE9G8o6TPO1/HR89q78KlKPcW3avrNbGCxdhipI
	8xpYO5MNJaQRr7ZRmcuUIlenlk71HAg2O4OAe5WYRUaPFQzXoF+CktWqwwnoIyM2OHePufO5Za8
	qF0EQeVTIHJ5ulXyMLb2eRxOBcFfbSZMh1CQ7zAek8rzWNyjsP7+337GAvt+SjcuvQfEQBI1PJn
	1e9Z3wPLRfQQd3E5YniRyE2i+H7sVviIMsx6dWMWTtUqrPDoP4oreykO71u+/uiH752mEtktkyu
	McMmZfC68TyD9NaNvMCulrr+n1OHPoXLTnkPHOuRYLt+Dl7lRXkyVUpGYwbRhx6hq8Eo2GOyR9w
	yhRLcU0iA5BWJvies2teJvrx0YtRfyyXhjAz+j59tzrXzwLH9XBcA26tBo59wa5CPw2LBcUJW7D
	6lgchDzlI79qJbBmFt2FyZMDMmgBEjcWmuvcAM
X-Received: by 2002:a05:600c:4745:b0:483:885:f0b0 with SMTP id 5b1f17b1804b1-48320227169mr153957095e9.35.1770592894905;
        Sun, 08 Feb 2026 15:21:34 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376accfc0bsm7380480f8f.32.2026.02.08.15.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 15:21:34 -0800 (PST)
Date: Mon, 9 Feb 2026 00:21:29 +0100
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
Message-ID: <20260208.2bef1edc844a@gnoack.org>
References: <16129d76-b6d3-4959-b241-dc79a32dd0cd@maowtm.org>
 <aYI2OQhPMgdMAOiz@google.com>
 <e6b6b069-384c-4c45-a56b-fa54b26bc72a@maowtm.org>
 <aYMxHRwHCao30HfX@google.com>
 <20260204.quaiyeiW9ipo@digikod.net>
 <20260205.8531e4005118@gnoack.org>
 <20260205.Kiech3gupee1@digikod.net>
 <ee38960f-8670-434b-9cf1-d95995b228da@maowtm.org>
 <20260208.4600394b9da7@gnoack.org>
 <c33926c5-3c7a-40d8-b910-ac99b43576ff@maowtm.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c33926c5-3c7a-40d8-b910-ac99b43576ff@maowtm.org>

On Sun, Feb 08, 2026 at 08:48:22PM +0000, Tingmao Wang wrote:
> On 2/8/26 20:37, Günther Noack wrote:
> > Thank you, Tingmao!
> >
> > So far, the selftests that I already had in fs_test.c were
> > straightforward to extend so that they cover the new cases.  I had a
> > look at your patch set, but found the scoping tests difficult to port
> > to fs_test.c
> 
> I was thinking that the tests in scoped_abstract_unix_test.c could be
> extended to test scoping of pathname UNIX sockets as well (otherwise
> wouldn't you have to write another instance of the scoped_domains test
> based on scoped_base_variants.h, whether you put it in fs_test.c or
> somewhere else?)
> 
> And if you think that is sensible, then I'm hoping that patch 4,5,6 of the
> series would be mostly useful.  But it's up to you :)

I maybe have not wrapped my head around the scoped_test enough; for
now I sent a tentative V4 patch set to the list, so that we can
discuss something concrete.

If you spot things that are missing, or you feel inspired to port your
tests on top, I am still happy to accept that. (But for today it is
too late in the evening here %-))

–Günther
