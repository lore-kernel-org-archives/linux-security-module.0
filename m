Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCB2A241695
	for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603744; cv=none; b=RE5lAsAgMuDEEGEUoEmhClf0zF1e7awel7h/9Ue8gH62Vsvx2RWgFguZSNXrMt1hmCYEvpybqIC+ei8QG4oz0OZR0nUUHP6iv1DFrTG3DBsYi5TUnkPy9f0nCf1gDOtLbfPMa7z6JIKCArptBItZbXAta0fz6JwItDplfFxUlAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603744; c=relaxed/simple;
	bh=0AGAs7JJ8TtLu3t2olRZW/V+LKtiteyh/Ex4FA+blTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TpfkTtMZZiqHJo7zRbYWqPy5IVW4eB2LaDqfE5GYqUg1TkFFL3R9nDZhvcr6d0aLQp1AqpTL9UjbtVhSojGKPThgVTVz8BY/LrnVfyKwDP8Yq28VHwl0mCJLAGP0SmhdoBeSVkLK/SdmXQEVgFl4sx3n37a7M9yKZjDSn75Rw3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GxiBAdAJ; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxiBAdAJ"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-48069a48629so22269155e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 20 Feb 2026 08:09:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771603742; x=1772208542; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yvycbt21ZcL/Dath/FI1wcBq4pVDzu0JK8D7Huk5vK0=;
        b=GxiBAdAJ5k50VhV+xN9BhE2RknkF5mj8y9SzB0vODuZRMsNSUWDNfK5edZ2YdApSIc
         9REepv5lt/jPy0tqh/RXiX3bA5TrIlVZzErbZ6ck+g+HiJoD08XMaZZkErHL0cF2cT/i
         k4JHUwCLEdTDVzkaqRROE7hAaCWv0JFnwIKMqWIoAlDU0cMAdm9woROOihIqn50zkRc8
         UN4mH40aNyeAG2+Ztt9/jPy9/fzSeEnFrW/zUQxngw33P4O3GavTMm4822im26aogmGU
         S29BnpWJTYccCKmJULSZlXUrFsI5osaKhLAvXV4L7j9s08xAt4OTG1zTiphxr6vzdQ91
         7ybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771603742; x=1772208542;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yvycbt21ZcL/Dath/FI1wcBq4pVDzu0JK8D7Huk5vK0=;
        b=w+mhX7X3Ppbb7JugS/kfFFYQ2N1pYWX54/QmfitSt3RDZh09UJNa64Eue0aQdFSEAd
         3n5/Y3W+ygcrD+Aj6AltkyjrDHHl6/zMlOtAK7wefWjP7tmuyDKPDM+ECPtUf+fOoD5P
         v43PNP5NIq99q5L+v72qnPn1omQf69sguVlm63n+V0W4bmwZQ/2yCfYW9hZwRDWMDgOM
         /7jey2bJU9AFH3KgqziacDF9hkWyQFN5H6+ulG3gQ59ws4E/agr9WF1aOS8WobSsLVWa
         aRAv/m4B9F1jZ6mLqobN6yUT5epyv4ZGuKy/FLf7nIfZhmElZoWpaRmM/42b93XtezLI
         5dig==
X-Forwarded-Encrypted: i=1; AJvYcCW262u565KNK1wuzZoBAIDH6mp3dBk732EfDE8dN/tpNhi0S9mRT74mGMInvh4EyWhPMstyPHMDDFHZeFG4m5fOhDGx/X8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+LTdzA5LobGc9sJJvdljRVmKLisNckkTPleZPjXoHiqiNi092
	AvT0+St6dN2H8MJHHtWDo08FM1h9fb4DuJO6TILtD6qX5L7qeF7cmNLL
X-Gm-Gg: AZuq6aIeubtJo4dbF1PxOD24zlDO19ShJ5cNdsSthFSwjO4tRNffRZNMFl1Dv8W8Mr2
	tqX2CRN+rI4QEKYNOQ3NZ5hapbxh3GSFPAA1+XEhFjImX89SvZ4It/9vJZQO7FhH3RW1IR4IiI8
	rd4all9srm0QHma8Z0vs8kX2PIjBrt4AGiekMLjnkHBV8k5vmr8VCCD4+bDtC62SCh1nw4rwo81
	+ePt1I/xWmaMv4yHYYm72grpM0WPEuEIPq2uyLya4e1gspGlru1DW8b2sWwSKUCudARt2QLga0+
	kEoywLGh0dKut9ZMsX/AXqqi1TpRM/rnD7czb3sIx/mKHgeMYin5Po058TRxEOHTFRD0l1OgMQB
	Cjfd4pPdfZpbMtRuS6WxneUHvXSIoPKC9plFJ8SqV4cTdz5UwOW7Q2McMVW4O3ootoyj/deSsdI
	55lBKjKRrV+F6oTafKz2oPtirbJabMd+gisbVVOtyRW3cFIeup
X-Received: by 2002:a05:600c:37cc:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-483a95e9b65mr619345e9.25.1771603741939;
        Fri, 20 Feb 2026 08:09:01 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439567aad3csm23491872f8f.36.2026.02.20.08.09.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Feb 2026 08:09:01 -0800 (PST)
Date: Fri, 20 Feb 2026 17:08:59 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: John Johansen <john.johansen@canonical.com>,
	Justin Suess <utilityemal77@gmail.com>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Demi Marie Obenour <demiobenour@gmail.com>,
	Alyssa Ross <hi@alyssa.is>, Jann Horn <jannh@google.com>,
	Tahera Fahimi <fahimitahera@gmail.com>
Subject: Re: [PATCH v5 3/9] samples/landlock: Add support for named UNIX
 domain socket restrictions
Message-ID: <20260220.e7da585e1dfb@gnoack.org>
References: <20260215105158.28132-1-gnoack3000@gmail.com>
 <20260215105158.28132-4-gnoack3000@gmail.com>
 <20260218.ufao5Vaefa2u@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260218.ufao5Vaefa2u@digikod.net>

On Wed, Feb 18, 2026 at 10:37:31AM +0100, Mickaël Salaün wrote:
> On Sun, Feb 15, 2026 at 11:51:51AM +0100, Günther Noack wrote:
> > @@ -444,6 +446,13 @@ int main(const int argc, char *const argv[], char *const *const envp)
> >  			"provided by ABI version %d (instead of %d).\n",
> >  			LANDLOCK_ABI_LAST, abi);
> >  		__attribute__((fallthrough));
> > +	case 7:
> > +		__attribute__((fallthrough));
> 
> The current code should print the hint when ABI <= 7.  Please send a
> dedicated patch to fix the TSYNC-related changes.

Good catch, thanks!  I sent a follow-up.

https://lore.kernel.org/all/20260220160627.53913-1-gnoack3000@gmail.com/

–Günther
