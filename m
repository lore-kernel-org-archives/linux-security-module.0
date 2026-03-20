Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3418A33C52A
	for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 22:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774045520; cv=none; b=pKq6lledNEOthlGERL7Q2vLhsTAqBkYWqfP80mS4G9xNjCDPGdEjEx/d+i44L355AZeM/rqGeqz4cPD74IZcI6s9DGWmJoS6GqcpTm7rjEYUhicdRGHLSMIdSWUJd9AHV7prAVjsl5phobutn7g+q/sdJlf7WdyZR21svjhLZy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774045520; c=relaxed/simple;
	bh=MfdWo9eRsfI8Ile3uD/oTl1sxYs1Hoh9dK7cbRFFjvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ENaVuYo/vxliSZRrxyCG90YB4VAW2fbu0fd+0SgyLhXmn4quaK0OuJUuDD34LYuOfxca35afxfQdsNkaM4rA9SmV0AL7dat1zFzddvYOp0JmcWX0x1V25F7F0E9ztdHkR3ask3GN5CUge/kLeWzo+bOrHCn6sKxgyptyvsT+4ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+D+LY5y; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+D+LY5y"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-486fd27754bso15252575e9.3
        for <linux-security-module@vger.kernel.org>; Fri, 20 Mar 2026 15:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774045516; x=1774650316; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3B8JDb3+hhwPiAVk0UOO5wlFYITC9jHcZ9Z36F5KsWg=;
        b=j+D+LY5yU3K6iTAx2VJcVPw78s/rVc2xmN1TLrhb+JuBrhSoIe1YdGcx35le+vkt9/
         3zZoZ8/6xokwSJbg/XuCQyTgFwcvlDDeasKI/Fy4drjrGe1+wYpd7WQGvJMYZFbpsG4e
         SZr1Gw62pHvtlYwyb3UatScrvjdavkBuQtNak1gz6IDrHMyucsc1TQJqYSj5Gcpq5Fl/
         ISRKRCgAqwnmXpbnBJuHvtWwR5WEw5OwMpg15AsFliBvkXTAP+tRakNxUIRSBvkVjcBe
         k0ABKlbOSrabaYSxBOZzA2sWcdeWoP3OmSYFmc/LbxtU8BaF5Yq9VInzGSEERBT7Mqiv
         m6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774045516; x=1774650316;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3B8JDb3+hhwPiAVk0UOO5wlFYITC9jHcZ9Z36F5KsWg=;
        b=hEucwBKpBzvyQPMD+QfCGs0T2diXKN5Fy7YjzN+R1uq0DzAQdxAuR8Y0fjQTsf6dMC
         51SuWP1sBPDAC07Qbu2QunV5x2H/LZ+MizAiw2An7DC1xojJ9+RHSI5xMUIsqk0SCO8j
         x92iJMsCqXcZKDirTWHYQwmLtZXqgD0xpn0BPv7N9d3vpD+4Rin/jeUxyCUZQJ5Jse+K
         9XionPRYbumgCv6GEdzElAUpAnBUSJHuUdt2ingvC+yRQfItFTVcbIjs4pXeVtmqMBRX
         rNT0oEc8P1JFnF1qpKUw6CMHacSQ9agQ4i6aDiJx6PvVZIQzkY+Y5vswFd60MTO3Z14k
         2U5w==
X-Forwarded-Encrypted: i=1; AJvYcCXjwwD8lK471QfDfoXhHMDl8+HJiodR7p7Kln3V9S6drKL5Hm03NFLz8vwS9vhwjD/8G9D0Tnv5FZGdTftALAfIgJ98+m4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLDov3SXEjJTu8KkL+rUe57mMXP7V/V0l0mW2+v0Ibf3/ptpwB
	S25q4QmTe1J6UkRTqdSVrYMwhXUxc4iyNgsuoO1sgsrfXyWg3wMWkgUX
X-Gm-Gg: ATEYQzzjxTMyR3w/aVP+eT/RbK3UVZ8cDI5u6YS8L3H7zYFiEW329FKBBy3vSGcf2eH
	4tmJzHXVNU2HQdTXt0b+lCcen6QUKF+7nR/NCRU0xpNpT96JVb6+2NQ6vPKjQ/a4/BvB1QQS3nH
	HzjY0XXWhogsVTfo7EQY+kKnkLtjc1ll9/94RgJZ4kvliOSI2YpEcoRBK7ED6DAOUpjAEgb0Wl6
	SEr6zVPeTBULJX9vszMdQu8gqMiffHdjjRnvOF9SuZEkp8MFRe594Sed0cVJT32pqze4ZBpd1kD
	pYtaLmmXm/UqD7oeG9o5uFntUrvQwaHFSyfh5KhDzLD0nBj3e0/UworqYFKAksDTY6KsHahecOf
	zJ1O1mwT34zV4K1VxZb7TKLev/SLxDg1nLUWqQ9mYUpC1zNifw7ZScERtwsyLDYjt6qY46ZobN4
	38UoVdboaV8oneOiQOItJQXKlYFIoCyz+Sl5ElwiZrgCxUS7Si
X-Received: by 2002:a05:600c:3554:b0:485:30f7:6e88 with SMTP id 5b1f17b1804b1-486ff01edc9mr70052355e9.31.1774045516334;
        Fri, 20 Mar 2026 15:25:16 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1d3befsm24119395e9.32.2026.03.20.15.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 15:25:15 -0700 (PDT)
Date: Fri, 20 Mar 2026 23:25:04 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
	Tingmao Wang <m@maowtm.org>, Justin Suess <utilityemal77@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Kuniyuki Iwashima <kuniyu@google.com>, Jann Horn <jannh@google.com>,
	linux-security-module@vger.kernel.org,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v6 3/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260320.ee35c8125f6f@gnoack.org>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-4-gnoack3000@gmail.com>
 <20260318.peecoo2Ooyep@digikod.net>
 <20260320.f59cddcb6c6b@gnoack.org>
 <20260320.eez3sheeThul@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260320.eez3sheeThul@digikod.net>

On Fri, Mar 20, 2026 at 06:51:13PM +0100, Mickaël Salaün wrote:
> On Fri, Mar 20, 2026 at 05:15:40PM +0100, Günther Noack wrote:
> > On Wed, Mar 18, 2026 at 05:52:48PM +0100, Mickaël Salaün wrote:
> > > On Sun, Mar 15, 2026 at 11:21:44PM +0100, Günther Noack wrote:
> > > > + * @client: Client domain
> > > > + * @server: Server domain
> > > > + * @masks: Layer access masks to unmask
> > > > + * @access: Access bit that controls scoping
> > > > + */
> > > > +static void unmask_scoped_access(const struct landlock_ruleset *const client,
> > > > +				 const struct landlock_ruleset *const server,
> > > > +				 struct layer_access_masks *const masks,
> > > > +				 const access_mask_t access)
> > > > +{
> > > > +	int client_layer, server_layer;
> > > > +	const struct landlock_hierarchy *client_walker, *server_walker;
> > > > +
> > > > +	/* This should not happen. */
> > > > +	if (WARN_ON_ONCE(!client))
> > > > +		return;
> > > > +
> > > > +	/* Server has no Landlock domain; nothing to clear. */
> > > > +	if (!server)
> > > > +		return;
> > > > +
> > > 
> > > Please also copy the BUILD_BUG_ON() from domain_is_scoped().
> > 
> > I don't understand what this check is good for.  It says:
> > 
> > /*
> >  * client_layer must be a signed integer with greater capacity
> >  * than client->num_layers to ensure the following loop stops.
> >  */
> > BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
> > 
> > For the loop to terminate, in my understanding, client_layer must be
> > able to store client->num_layers - 1 down to - 1, but that is anyway a
> > given since num_layers can't exceed 16 and client_layer is signed.  It
> > seems that the termination of this would anyway be caught in our tests
> > as well?
> > 
> > Could you please clarify what this BUILD_BUG_ON() is trying to assert?
> 
> The intent was to make sure client_layer is indeed an int and not an
> unsigned int for instance.  Hopefully tests catch that but using a
> build-time assert catch the potential issue and document it.  Also, it
> would be weird to not have the same checks in both copies of code.

It isn't clear to me why the BUILD_BUG_ON is checking based on the
sizeof() of these variables then.  The number of bytes in an integer
type is independent of its signedness, after all.  Should we rather do
this maybe?

  /*
   * client_layer must be a signed integer to ensure the following
   * loop stops.
   */
  BUILD_BUG_ON(!is_signed_type(typeof(client_layer)));

(Although that is also a bit of a triviality given that the same
variable is being defined as a signed integer just a few lines above,
but at least it is very explicit about it.)

I'd drop the remark about the capacity, as even a signed 8-bit integer
is large enough to hold the layer indices and the -1.

Does that sound reasonable?  I can do it in the other function as well
if you want to keep things consistent.

–Günther
