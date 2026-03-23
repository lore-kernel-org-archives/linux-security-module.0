Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197FA23ABAA
	for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 15:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774279928; cv=none; b=MQzj+o4FuXsowYf1yb3baqXMrxC/hEPGtXCosZYvXAoungxj4A1IxRC42f+hZE4Xc2KcGhBvm8/O46vyWzjxQWoJ8pUeBB+BxL8t9tt8DruaqD4MYuygCk/M6SvemfV+OiaoenIaK5j0t2iYe1FezpL4VHbn3KgvXzV6ZhM43KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774279928; c=relaxed/simple;
	bh=PEGnjDovZdCE+HnYhQmMuR6oFFp7NAe2bipZ0FUt5ig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R45M+Oo9PYvePNFnscfHTyTZzmB0iZdAy9ILPEanh/PayKnWJDGBkQukme+Z8dJDJbceu7GcH23lgvzWdvTEdeC9L1JqjapWYG7jYj5eXCgw7yjzHCc1CMgKWQzbSeZ2+RqBQ00eVjMFuJGzVoiWlDygAqu/qoycdbxIs49I6Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O/wmvFTH; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O/wmvFTH"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-486507134e4so3442375e9.0
        for <linux-security-module@vger.kernel.org>; Mon, 23 Mar 2026 08:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774279925; x=1774884725; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Z5ZV7l3Fxtmr1G9g8uZIpUEQ/LOVLTV4dKszYyUtIFw=;
        b=O/wmvFTHRG7A06bdPy1laDmvma6zIP1SRT8P+Z770bbQY1ZXYsDsEJ8qGUlnbVk+Uj
         ur2DwhV6ggDxMyAQQbTU6+E0NLsFqToY2/PFAWVKRfDgFBEG4cOuXr39HS13+Z4+DjJN
         z6+pFcqTq5R6mVkVmLlOg8XihcDyrfvDdcuC2XeIz4C5vXRh5g0Bmv8ZgvUNdatB/AQ3
         rQ7bMrT8zpK2Wmy3YbjAayDic84QX6WdMJsMBEGe7zxAbfUDT88fUTvY+f6Nnm1N+pBv
         bhzViale7SqWE99wBVufzCQfZWxpBSJIoQx/fmsBIEDXm9k2UgpDcW3qEHh7YnMM5+aV
         kodw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774279925; x=1774884725;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5ZV7l3Fxtmr1G9g8uZIpUEQ/LOVLTV4dKszYyUtIFw=;
        b=qnkTOPcJgiPl8wGr1SOY2VVeFBOQNd3o7acY+Uq85uQoGDt3iZAhXXPu5Uo3OHzr4A
         nxxW+XJSfMnqSOf6RWEBOYNi66Lpj0dxVdvt9hOWQ0X9s/4jlxpM/LrGW6tPvOFM2s4H
         GoUyTJKOoVV6Rox6UpTllV8EnSCbvYabxuk7LSRaFY6UfoXDPdE2PwvWT2DUJ/GC9Wrw
         hUUiX6N6MyXk2/UHVdOfkqxKJl2aPpDvkaJ+Avri10ooBTfMiGvpfQcLyxIle9yQyvrM
         RKDr0dGfjxDRs6ev5wMLP2BzisQQR6WJJ7gBb/BEHvkGKEtXus0XH0CYiRUMgLuhIssq
         WNjA==
X-Forwarded-Encrypted: i=1; AJvYcCWwFTKBklfQN4Yp7LKr7iPfgLCJ/Smpgeark+159LNrujnPcy2VdBDiAeeBiVf4oS+Tf0c/xeKlsH8FzNzBlyq4K2/3tEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuACgpYnkhG3opwsar8t49XqsqWAqJfWRK5IBvLsw6Y3HvMNJC
	26Po4ddPzY40wsJnfsduhlmFt6aSQzSqVe29nYAVbojt/GvMAoRB6U6A
X-Gm-Gg: ATEYQzwx4ivSp/kaDdhDafzXekJ/+c3sYG/In8a9/BagOm/hodoObMD8SE2DmHfRcZR
	58ZiPeNJw3gdbtFBoNrEtRZFoeBRBWaLjFGrYHjkYNudFcV1m+Iw4KBTWPc3EKIcAZfyoAUVwoh
	+izHitQoNym8/IY6hos/PNLDQuXkpnyror4Af7MadNMr546ccskKof0UPe0Z7Do7FVNVph/TGQ8
	o4VGeH7ClIMciLbMfDMVkSKzVv9KnOtw/pwfxd3glcXMqsWEdJqv3HTC1EHA6MeHXsElfXcg8uv
	5EQJVUx4mRIa9YZDa5o09MPJcVrZxddTZZTRZimCqDbzigS3A+dqslm/mIIYW3NlfcIotRJld+1
	cIstZWFsrxtuxtGvKnUUyOgid2jZOLMweFNSbD3X6J7vJ3OQdXPRJcrFHHQU++2aogk9PChVlzl
	J73j7Aj3suba3mq49e+ztZGV5ER4ET1Nwi1pakgDxOmQXCAPlG
X-Received: by 2002:a05:600c:8508:b0:485:3b00:f92e with SMTP id 5b1f17b1804b1-486fedab7dbmr179523845e9.2.1774279925024;
        Mon, 23 Mar 2026 08:32:05 -0700 (PDT)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486ff1dd9f1sm124828425e9.8.2026.03.23.08.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 08:32:04 -0700 (PDT)
Date: Mon, 23 Mar 2026 16:31:58 +0100
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
	Alyssa Ross <hi@alyssa.is>, Tahera Fahimi <fahimitahera@gmail.com>,
	Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v6 3/9] landlock: Control pathname UNIX domain socket
 resolution by path
Message-ID: <20260323.31999db4370b@gnoack.org>
References: <20260315222150.121952-1-gnoack3000@gmail.com>
 <20260315222150.121952-4-gnoack3000@gmail.com>
 <20260318.peecoo2Ooyep@digikod.net>
 <20260320.f59cddcb6c6b@gnoack.org>
 <20260320.eez3sheeThul@digikod.net>
 <20260320.ee35c8125f6f@gnoack.org>
 <20260321.Aiquah5gaedo@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260321.Aiquah5gaedo@digikod.net>

Hello!

On Sat, Mar 21, 2026 at 10:09:35AM +0100, Mickaël Salaün wrote:
> On Fri, Mar 20, 2026 at 11:25:04PM +0100, Günther Noack wrote:
> > On Fri, Mar 20, 2026 at 06:51:13PM +0100, Mickaël Salaün wrote:
> > > On Fri, Mar 20, 2026 at 05:15:40PM +0100, Günther Noack wrote:
> > > > On Wed, Mar 18, 2026 at 05:52:48PM +0100, Mickaël Salaün wrote:
> > > > > On Sun, Mar 15, 2026 at 11:21:44PM +0100, Günther Noack wrote:
> > > > > > + * @client: Client domain
> > > > > > + * @server: Server domain
> > > > > > + * @masks: Layer access masks to unmask
> > > > > > + * @access: Access bit that controls scoping
> > > > > > + */
> > > > > > +static void unmask_scoped_access(const struct landlock_ruleset *const client,
> > > > > > +				 const struct landlock_ruleset *const server,
> > > > > > +				 struct layer_access_masks *const masks,
> > > > > > +				 const access_mask_t access)
> > > > > > +{
> > > > > > +	int client_layer, server_layer;
> > > > > > +	const struct landlock_hierarchy *client_walker, *server_walker;
> > > > > > +
> > > > > > +	/* This should not happen. */
> > > > > > +	if (WARN_ON_ONCE(!client))
> > > > > > +		return;
> > > > > > +
> > > > > > +	/* Server has no Landlock domain; nothing to clear. */
> > > > > > +	if (!server)
> > > > > > +		return;
> > > > > > +
> > > > > 
> > > > > Please also copy the BUILD_BUG_ON() from domain_is_scoped().
> > > > 
> > > > I don't understand what this check is good for.  It says:
> > > > 
> > > > /*
> > > >  * client_layer must be a signed integer with greater capacity
> > > >  * than client->num_layers to ensure the following loop stops.
> > > >  */
> > > > BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));
> > > > 
> > > > For the loop to terminate, in my understanding, client_layer must be
> > > > able to store client->num_layers - 1 down to - 1, but that is anyway a
> > > > given since num_layers can't exceed 16 and client_layer is signed.  It
> > > > seems that the termination of this would anyway be caught in our tests
> > > > as well?
> > > > 
> > > > Could you please clarify what this BUILD_BUG_ON() is trying to assert?
> > > 
> > > The intent was to make sure client_layer is indeed an int and not an
> > > unsigned int for instance.  Hopefully tests catch that but using a
> > > build-time assert catch the potential issue and document it.  Also, it
> > > would be weird to not have the same checks in both copies of code.
> > 
> > It isn't clear to me why the BUILD_BUG_ON is checking based on the
> > sizeof() of these variables then.  The number of bytes in an integer
> > type is independent of its signedness, after all.  Should we rather do
> > this maybe?
> > 
> >   /*
> >    * client_layer must be a signed integer to ensure the following
> >    * loop stops.
> >    */
> >   BUILD_BUG_ON(!is_signed_type(typeof(client_layer)));
> 
> I didn't know about this macro, looks good.
> 
> > 
> > (Although that is also a bit of a triviality given that the same
> > variable is being defined as a signed integer just a few lines above,
> > but at least it is very explicit about it.)
> 
> Yeah, I know, but I added this canary check because I was bitten by a
> bug.  Even if it might be trivial now, it might help when working on
> other parts, and it's just a build-time check that also serves as doc.
> If in doubt, let's keep build-time checks that were most likely added
> for a good reason.  I prefer to have build-time errors than run-time
> ones.
> 
> > 
> > I'd drop the remark about the capacity, as even a signed 8-bit integer
> > is large enough to hold the layer indices and the -1.
> 
> Large enough for now...  All these checks are useful to easily spot
> issues if/when the current invariant change (e.g. if one day we extend
> the number of max layers).  Integer C types can silently cast to other
> integer types (with different capacity or sign/unsigned), which might be
> the source of bugs.  So yeah, please keep the current capacity check and
> add the sign one, it won't do any harm.

I feel that this is still not fully addressed.  I know it is a
triviality to go in circles over this BUILD_BUG, but the current form:

  BUILD_BUG_ON(sizeof(client_layer) > sizeof(client->num_layers));

checks that the size of client_layer is smaller(!) or equal than the
size of client->num_layers, so it seems that the check is accidentally
done the wrong way around.  It does not fire because the two integers
happen to have the same size, but it feels a bit misleading to leave
it like that?

To keep things moving, and because it feels like a minor (any maybe
optional) issue, I will send V7 now and optimistically do the
following:

* Copy the BUILD_BUG_ON and matching comment from domain_is_checked()
  as you initially requested.
* Make a constructive proposal that rewrites the check in both
  functions, to check that all numbers from -1 to
  LANDLOCK_MAX_NUM_LAYERS are representable (and the loop therefore
  terminates).  In my understanding that was the intention here.

–Günther
