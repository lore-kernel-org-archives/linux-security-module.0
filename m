Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639B63B05AB
	for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507683; cv=none; b=XZd700xWXnw6DFci4cmK7DBR7nh8Z750pNQdJI4vo6OBK7VC0monxWh3mA2oVZxQSRUjmiz7NXHaDGsJim0daTmztyk+dJJEeVVy4TBaSvyfp20DX3aXUBz3Vh3sAVMnvabnWKiI1SovG6YlVkVwOMKXeVMryf/RDerWSmhQcoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507683; c=relaxed/simple;
	bh=XTV7X+o5M/o2y2t//UDELfeegsHVcrrYqFPQIiwWNBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=clfQ82zC2avgCxW54ZLxO5dJEnmqx8UGH3SWLKYC/FAFzxaE0XLTA6TpPMZZlnIo+QGM0XongAIywxiABt8CJ+XqzU2Yb+KGG1BGudEk/EDtO73wdmhB8Ojwr0ytiGUSjMfQA4N0Jf9sosYBJS+jK+w9xGbupJaMJfVzMeYm7Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ula9uZQJ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ula9uZQJ"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a08a2b7e5bso264095a12.1
        for <linux-security-module@vger.kernel.org>; Fri, 31 Jul 2026 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785507680; x=1786112480; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lFUBPHL4HT3ZB2x0LdxtUzT9HmxvuyXwEsyaG7XBc7E=;
        b=ula9uZQJ3GJ5JcJLc6KEeMLflU6HtqvzQyKfXCPvqn11zSScBwuJvfisv2KVIvYy2n
         pM/nUPlLBu2unouYb1Qcl55/cOhAEH9kREXsUcYqdbfRAHqLiaEKs0m3/95e2Kc8uh9w
         AYQ86fhSphz2wVe6ud58X1c1DeELzzW6PCpNQqHleNfRYZXd9wL5hJe6tmzLlZRxRZ7L
         FnLL7ZTCwgK60WIScdVNSJ709Of6YtyN6qn3rt/5khZiEtr+qt8QBZFQO+dQR98GtqTG
         Ai2pKJ6mRT3GzRWaLqh1PD6LpXIvR3p7zuFNzcpO/QqJIlL9tqsqcSILO5Qr1xb2vi07
         SOkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785507680; x=1786112480;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lFUBPHL4HT3ZB2x0LdxtUzT9HmxvuyXwEsyaG7XBc7E=;
        b=g07gblJqQDD0xvdO2ytUHvaV+YZ5FOdmpMAXo1VO7XPw82E3Qgl0gL7WBhRqBSIxCK
         Xm8b1q87Hk4Qiqgp5hZud9E/gUAo7M+8l6BInwg7Yh2fCLLX9wcRQflTLL13l4NxQ+MJ
         9hr8itLovij3dTC5xrzAabpBK8kHQYLohHCPmLTS5iCupP1vzEJL8+0sq7DXAopNosIz
         +NwE7Nj5cDS5gU0hoDZy7EpOiGJluzoOjt4IrRfDOtjiTOhH3QgujP2f8+Cf1w41hA8G
         rSZ+JFQPRjwakCpoVypFgtd3cn66lOaCYVREzGgFOrE+MlPTAOHASv7betr4NNNa+BFn
         RX/g==
X-Forwarded-Encrypted: i=1; AHgh+RozaycgCM6xepVVhCyx4w2VvFvJt71r0r7tOcfUO4bkmyKeeMOCqoIFtA8CJD4S1y9a6IzZwZYJ7eWNDhvjUnujodPY44g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzhq5R/ihkC3CG4AS5dYFplOqblqJaiyGaNJAixKD2EBWUNF1L
	D76SyLUHtKybnifHRXWsIH+C099pxx2OjLzkVs4EckaDfnetbm0xGknDIEf2WFWVb1qXi3Q/aa+
	GfwPTicaT
X-Gm-Gg: AR+sD114A2khXWpzUF7AUdihR2hKebWhIBFvZHXKTfxw7qa10qRyCBFsyVd7gqe2oOI
	PiTeFCceEbXbkScyRD1kNcriZFXkvxMIcYV73G5+fTsgI/Zf5c/SmAd89+UbCFfw77qu/iFoH55
	mjCkcrk3bq+j8DbFhfWNZRLws9f0rmPrsCYf0+p3c2D3ruJO/6tAjKif0KscgngR1GIBAjLQxX3
	WhbZ+UIG5P44eaKAaf0S69aTCqHSBSoc8onPHWpUVyyg0syZ3qrnOuvnbX8P7w1uZ+JfTk//+Ew
	ZvbhIYab41F/bDGbS8s6EgL3oRU7omVPZcxMXCdmlwpLZ0mhbDXZoy4LegHH4GcsOdpbowyhS+T
	TuKq3dmZcq8pbkbHAK3OsBBtw5mjO6+o1Ttg28gCyplve7uap7ZKXm4BP9/G4rwYVdqZ8QPdd3r
	tmEcs8OcqalaX0/F914MW2ZDljvcnFQiuB5g+2Gn/fxddJPPDWsi01OKvRhJF6ASNdcJLNL3qpT
	W6HZl6MLkn9aQco924=
X-Received: by 2002:a05:6402:a6c2:10b0:698:b92b:c785 with SMTP id 4fb4d7f45d1cf-6a09b9f3c21mr833139a12.3.1785507680149;
        Fri, 31 Jul 2026 07:21:20 -0700 (PDT)
Received: from google.com ([2a00:79e0:288a:8:3ba9:7454:5ca0:a791])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a09c674842sm1966410a12.31.2026.07.31.07.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 07:21:19 -0700 (PDT)
Date: Fri, 31 Jul 2026 16:21:14 +0200
From: =?utf-8?Q?G=C3=BCnther?= Noack <gnoack@google.com>
To: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-security-module@vger.kernel.org,
	Paul Moore <paul@paul-moore.com>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>, Serge Hallyn <serge@hallyn.com>,
	Stephen Smalley <stephen.smalley.work@gmail.com>
Subject: Re: [PATCH v4 2/5] landlock: Require LANDLOCK_ACCESS_FS_MAKE_REG for
 whiteout creation
Message-ID: <amyvWp25gjy_U5Hv@google.com>
References: <20260724161004.2360749-1-gnoack@google.com>
 <20260724161004.2360749-3-gnoack@google.com>
 <20260731.eiNi7aik6cah@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260731.eiNi7aik6cah@digikod.net>

On Fri, Jul 31, 2026 at 01:07:57PM +0200, Mickaël Salaün wrote:
> On Fri, Jul 24, 2026 at 06:10:01PM +0200, Günther Noack wrote:
> > +
> > +/**
> > + * DOC: erratum_4
> > + *
> > + * Erratum 4: Creation of whiteout objects
> > + * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > + *
> > + * This fix addresses an issue through which it was possible to create whiteout
> > + * objects, even when all file creation is restricted using Landlock.
> > + *
> > + * With this fix, the creation of whiteout objects is now guarded using
> > + * ``LANDLOCK_ACCESS_FS_MAKE_REG``, both when it is done through
> > + * :manpage:`renameat2(2)` with `RENAME_WHITEOUT`, and when it is done through
> > + * :manpage:`mknod(2)` with ``S_IFCHR`` and ``makedev(0, 0)`` (which previously
> > + * required ``LANDLOCK_ACCESS_FS_MAKE_CHAR``).
> > + *
> > + * Whiteout objects are special file types used in OverlayFS to mark the absence
> > + * of a file in an upper file system, even when the lower (often read-only) file
> > + * system does have a file with the same name.
> > + *
> > + * Impact:
> > + *
> > + * Without this fix, it was possible to create whiteout files from userspace
> > + * using :manpage:`renameat2(2)` with the ``RENAME_WHITEOUT`` flag.
> 
> The errata should focus on the change of access rights which are needed
> (and could potentially break some use cases), not to talk about the
> RENAME_WHITEOUT (bypass) fix.  Most fixes don't get a Landlock errata
> bit.  The impact should then be explicit that this is for sandboxed
> programs such as fuse-overlayfs.
> 
> This patch does two things:
> - fix the RENAME_WHITEOUT creating a whitout without being controlled
>   (no errata, just a fix),
> - and repurpose the MAKE_REG to control whitetout creation instead of
>   relying on MAKE_CHAR (which needs an errata because it could break
>   legitimate use cases/policies).

FYI, I'm thinking to change the phrasing to this:

/**
 * DOC: erratum_4
 *
 * Erratum 4: Creation of whiteout objects
 * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 *
 * This fix changes the access rights required for the creation of whiteout
 * objects through :manpage:`mknod(2)` with ``S_IFCHR`` and ``makedev(0, 0)``.
 * This way of creating whiteout objects is now guarded by
 * ``LANDLOCK_ACCESS_FS_MAKE_REG`` instead of ``LANDLOCK_ACCESS_FS_MAKE_CHAR``.
 *
 * Whiteout objects are used in OverlayFS to mark the absence of a file in an
 * upper file system.  Despite being created with ``S_IFCHR``, whiteout objects
 * do not count as character devices.
 *
 * Impact:
 *
 * Sandboxed programs that create OverlayFS whiteouts (such as fuse-overlayfs)
 * now require ``LANDLOCK_ACCESS_FS_MAKE_REG`` instead of
 * ``LANDLOCK_ACCESS_FS_MAKE_CHAR``.
 */
LANDLOCK_ERRATUM(4)

Please let me know whether that sounds better.

—Günther
