Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE362BE031
	for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768516352; cv=none; b=QjgtOtrPX1rnef5rQ/rbEQ1mHh3gn8bLPXIuebsqQqIBO9OjgczWU+ZqrD3SffHYIU835ahI0LmltXKZlVMXD8zB1uTU4fUn/4sO3XZRb7sR9fRSW2UBnrsQ6WtwJr1UbZ55xrcpjycejmoJpZB8mxTMm0LsZJhZBJBTb3eAG8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768516352; c=relaxed/simple;
	bh=RVSsbvnzcTskaSr4JxPP+QTDROhjoiuxQ42GIhG1hE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b1imOtc0twX+YIWpFqdpOm0sg41NYtTZMKtlR0KhpYFliNf6RYv2xOAkZLvsMVvHjPyd92EtvsiOixho29w5jnWRzAhOwWw+0DR5JCWLPn5a1KJFjMYITvvV4TZShwRFRgcyVLI0MGflgHAi1RJW8hjz3mYKpFHkaX129quA7xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BvXh5HF8; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BvXh5HF8"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b86f69bbe60so206316266b.1
        for <linux-security-module@vger.kernel.org>; Thu, 15 Jan 2026 14:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768516349; x=1769121149; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ERhpIfe0KAnH+I0lEftkXUyHU4cnivju7fTaghPhTpk=;
        b=BvXh5HF8habEtr2XKDZ4NmSoGxBSjm2SZQx4uNCkslz0ACV9ixI0Rper9LDCPclFUC
         xlxSdqURMvZ08e50VQK/EUOgaMpd4F+ZDFsCz4Jbkyj0Xh7uxexD2YeGe6vmZFEqL0pD
         mOCqteOiv0a+gkaX1jWJaqv+dRN8Ucvr24d1eKdDji4dOdPC120uMHuJ5m5/riXlrigM
         uR0Qg+i6oD/n3SeVazQGbkShp9HsxUR+2zxZlqoPuXw9G/THaSrn5BVOz21bj8bw67DQ
         4L0OjdcCOai6I2PHxRtEfCHH66k4/t7IursNNh1dKAMf43Vyr4/VsP2bTgj+3eFw5UNI
         cZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768516349; x=1769121149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ERhpIfe0KAnH+I0lEftkXUyHU4cnivju7fTaghPhTpk=;
        b=oOM1am04qJTWh0s0VODi/BkZLL10PnSAHWdfsv1IyMCl15GvHj9sPm0gLaTS5obFwu
         5gxLC51JkxPLtIkZIxerqj1BE1xiT3S4U9k1UZUK1zIZ8WQPuamrWc6ohzhcavYtAie3
         yGWgEouObt7mPi21ZeizY8lUd9ROxQuw4mxk7yFSXV0Zz6OkoKhldXGAuNxXtzi9B316
         /6bDck9H3bGqjh3ZCD9ZS+/mRnb8NtdGHf+mJWRhtAfjokLEc2bODFoR+aDqoIOz9Xp5
         iTzeBU4xBtmsgXVH8ILI4xHV4IgDdQQdy1l7c7KVAO2tb7nmNyPMHKwBw8MXX4m7otEL
         kd7w==
X-Forwarded-Encrypted: i=1; AJvYcCVQFIYFAod2r1ch1IhxeS2rqEcF9x00GYo6MoGKCjv7yzQdB+rLbmXNTQBbh+Tg+bR2SHQDXzeHXYCTI6Fyoe11DK2fWZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFJ1a0s5t6NgkggCsH/zhpWc2vOjTCjyhmriHXgDYkaZkJOkes
	0qV9i+QswYEDiqkhivMpaqZP/1jDlIJLJtTjtF3rlR+05d3CcEPz8rtE
X-Gm-Gg: AY/fxX5D5jCMMll4qeegO0415N54LbzIepDC8QrYWQdtYsZb1FqF0lXcRBxOYefeANN
	SmaLsHbxHlQh4wswnKd0bylv2/Ho8hDOKGcFXqxUPxOBOw8eY1wpYLhlPzaAXpQfwyv/zHja45v
	TsyFvP3ZvNRjOo9wPaZ4EYtrrA4PtkfRAW7vtYK+llSPXli1oDMvpR/XQL3oUTzJ5y0NRiqSClv
	1uylM40PMRgp2FoPbXbzSmdPRYP0CpB9kVwKFg4xiSz2cF8vQj6QM/l39J459IwcO2oOv27S8xD
	+oA2IuzA6oGEzHAwMAWs60IKi1ilN3c3jaSTfRTVvZbd58+ZX4ydNafJMoVsMegNNi0/40nvxJf
	M2F0l3sEiHUkitSpw5Ehwz3WrBGOq1EGIwyoVXKfPWrYk84XSjiEqBoOVBiDz3siV1N6p0CjDil
	rcYyqK/hV/qHIN6ydla+8LSHB5OESG1EzwGDNv
X-Received: by 2002:a17:907:1c25:b0:b87:1048:6e21 with SMTP id a640c23a62f3a-b8796bb3de8mr41587966b.62.1768516348976;
        Thu, 15 Jan 2026 14:32:28 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9fb0sm54856766b.43.2026.01.15.14.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 14:32:28 -0800 (PST)
Date: Thu, 15 Jan 2026 23:32:21 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Demi Marie Obenour <demiobenour@gmail.com>
Cc: Paul Moore <paul@paul-moore.com>,
	Christian Brauner <brauner@kernel.org>,
	Justin Suess <utilityemal77@gmail.com>,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	James Morris <jmorris@namei.org>,
	"Serge E . Hallyn" <serge@hallyn.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com, Alyssa Ross <hi@alyssa.is>,
	Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2 1/5] lsm: Add hook unix_path_connect
Message-ID: <20260115.a6f842555347@gnoack.org>
References: <20260110143300.71048-2-gnoack3000@gmail.com>
 <20260110143300.71048-4-gnoack3000@gmail.com>
 <20260113-kerngesund-etage-86de4a21da24@brauner>
 <CAHC9VhQOQ096WEZPLo4-57cYkM8c38qzE-F8L3f_cSSB4WadGg@mail.gmail.com>
 <20260115.b5977d57d52d@gnoack.org>
 <4c3956c2-4133-46bb-9ee5-4abf9bf7fff8@gmail.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4c3956c2-4133-46bb-9ee5-4abf9bf7fff8@gmail.com>

On Thu, Jan 15, 2026 at 04:24:48PM -0500, Demi Marie Obenour wrote:
> On 1/15/26 05:10, Günther Noack wrote:
> >   I would prefer if the correctness of our LSM did not depend on
> >   keeping track of the error scenarios in af_unix.c.  This seems
> >   brittle.
> 
> Indeed so.

Thanks for the support!

> > Overall, I am not convinced that using pre-existing hooks is the right
> > way and I would prefer the approach where we have a more dedicated LSM
> > hook for the path lookup.
> > 
> > Does that seem reasonable?  Let me know what you think.
> > 
> > –Günther
> 
> Having a dedicated LSM hook for all path lookups is definitely my
> preferred approach.  Could this allow limiting directory traversal
> as well?

No, this does not limit all path lookups, in the sense of what was
discussed in the thread at [1]. (I assume this is what you meant?)

The LSM hook proposed here is only about the lookup of named UNIX
domain sockets, as it happens when clients pass a struct sockaddr_un
to connect(2) or sendmsg(2).

–Günther

[1] https://lore.kernel.org/all/81f908e3-8a98-46e7-b20c-fe647784ceb4@gmail.com/
