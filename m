Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E05B50276
	for <linux-security-module@vger.kernel.org>; Wed,  4 Sep 2024 17:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725469278; cv=none; b=PvALpYauNFE/milSnsShxR8AY+S+iBFP5vmptk+Zqqfg+n/q1/CisykLF/5od/MsUGEF/sOe8XPoYGBsQXcjqa3ICsUU47zi14KgbdCmCjgOVGN5rsRXkxBd5AU0nfSzKeOI0yPYhUKPlUfY4ZQTcVCuIsSvbjal7f1g4QUbHis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725469278; c=relaxed/simple;
	bh=SMwfMxRbhIejqPpvJ6rfUHRCXekvUWgpLlZca+d08ow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nXvESwIu8lWYJczHZny5sn3SQV3ByyW8FN0gN/1h7ZTYZotKarsVHfqXWd2n9HuhJMH/+zV/mxwbmIjrnM69AysTckj2k2A+YcnyiqD1qDqgBwqh6d7xIebj9nITfPbOqzuE3PYGohb0qFWHp+JpffhphP2g5QawmSpHf0UVJWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=dO4blEU0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="dO4blEU0"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c263118780so2992923a12.2
        for <linux-security-module@vger.kernel.org>; Wed, 04 Sep 2024 10:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1725469275; x=1726074075; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=igjjJkRDnT4710DOt69t7RwKA+wIuknyStdIEfj6q8s=;
        b=dO4blEU0jtCIU+AAyn9ZRpBtu2hvJ4YfwLtOaN2XztckU2FAxODQPnONXiEs19lwny
         RwNQk0L6inXFmtPdersfCGobwWOXi7huET+cotTPvgVkaXBtmmL96103J/8OwK9dDB2/
         lESdTFn56i67Ghw0BNCNhkzeGt+tKGnSdGygpYPB2E2wo+cEzK/wUttfojFDH1a1G0wM
         JUj7//Bg6P+Q1bITXCzm1t53lQQSwHY5aFl6qRg3FkQ+9kmCHREgTmVuOQ6CPSOcay9K
         ovY8ZrUHoHWNFXhhW3g2Njd5iYXpIQieZyBuaT+0Bhx8dLg6+NXrzUCEV5R+rRi3Up4A
         ZdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725469275; x=1726074075;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igjjJkRDnT4710DOt69t7RwKA+wIuknyStdIEfj6q8s=;
        b=bDTVilhZJ3D4ymFxjjV2BM+vHoTVyJyRmLK6RiVFV3VJR2ZxNpGD2JhN+bu4q36qJv
         /CHKTL437/8tKGUOSKMw57MQxNpISwvCTfHRhQ5YhxDqLKv78v/pdMLLm3COA3ZuIF+j
         SzLeDtWVF5qrsjBGdyrWudTkdsDkkMU+Myf7nWoOI720ugaY+je79kxYPG6WIMOKT+F3
         /LmC7UXMHPeaYNu+2EW4LWtY/auMi9q2Sjrbl32kKOjV/pz+c2Lv4qoGW98IzEU0+vCu
         0g9j7FWg09NV6sqpOV9DoXvpI2MSAHrfe2ts21V1FRJnBJvsuL8gVANg2o0rnO5y/NH9
         95bQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9zTA//XybHYXTglPpquYOjPH1IqRc4+lpm9XSIN5LodawV/sktyr2ITukUu3nN0CWJGUS0AVeVUwvkLIuuVScrSjNC5w=@vger.kernel.org
X-Gm-Message-State: AOJu0YylxNlkgDSjuCZMIn3zk9fbCFYhPgnUqheWbk4tjOJcnzJz7bj6
	FHTvCCCof9YqNqCVj+6b2X7mLL7rXV16Dsmmg+RMRBAy1aDsPwTcTm4Nqy0deQ4=
X-Google-Smtp-Source: AGHT+IEdhO+6u5bQtS/Pjv4pVjqT1PHlHw58PSqoO2bfvx8uyhINdf+pDMVbe4vM0TqY/tHlEK8Ojw==
X-Received: by 2002:a17:907:7206:b0:a7a:be06:d8eb with SMTP id a640c23a62f3a-a8a1d4c2635mr725404566b.53.1725469274485;
        Wed, 04 Sep 2024 10:01:14 -0700 (PDT)
Received: from localhost (109-81-94-33.rct.o2.cz. [109.81.94.33])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8a623a6ca1sm14385166b.173.2024.09.04.10.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 10:01:14 -0700 (PDT)
Date: Wed, 4 Sep 2024 19:01:13 +0200
From: Michal Hocko <mhocko@suse.com>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yafang Shao <laoar.shao@gmail.com>, jack@suse.cz,
	Vlastimil Babka <vbabka@suse.cz>,
	Dave Chinner <dchinner@redhat.com>,
	Christian Brauner <brauner@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-bcachefs@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2 v2] remove PF_MEMALLOC_NORECLAIM
Message-ID: <ZtiSWUxMQSBzN9cr@tiehlicka>
References: <20240902095203.1559361-1-mhocko@kernel.org>
 <ggrt5bn2lvxnnebqtzivmge3yjh3dnepqopznmjmkrcllb3b35@4vnnapwr36ur>
 <20240902145252.1d2590dbed417d223b896a00@linux-foundation.org>
 <20240903051342.GA31046@lst.de>
 <l3dngdjyglhpnlcmjxerpmiyw4euodb6sxsxe3mwtyd2z3uopu@amisj3chjfqe>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <l3dngdjyglhpnlcmjxerpmiyw4euodb6sxsxe3mwtyd2z3uopu@amisj3chjfqe>

On Wed 04-09-24 12:27:04, Kent Overstreet wrote:
> On Tue, Sep 03, 2024 at 07:13:42AM GMT, Christoph Hellwig wrote:
> > On Mon, Sep 02, 2024 at 02:52:52PM -0700, Andrew Morton wrote:
> > > It would be helpful to summarize your concerns.
> > 
> > And that'd better be a really good argument for a change that was
> > pushed directly to Linus bypassing the maintainer after multiple
> > reviewers pointed out it was broken.  This series simply undoes the
> > damage done by that, while also keeping the code dependend on it
> > working.
> 
> Well, to be blunt, I thought the "we don't want the allocator to even
> know if we're in a non-sleepable context" argument was too crazy to have
> real support, and moving towards PF_MEMALLOC flags is something we've
> been talking about quite a bit going back years.
> 
> Little did I know the minefield I was walking into...

There is a lot of historical baggage and several people tried to explain
that things are quite complex and you cannot simply apply design choices
same way as if you were developing something from scratch. 

> But the disccussion seems to finally be cooling off and going in a more
> productive direction.

Reality check: https://lore.kernel.org/all/8734mitahm.fsf@trenco.lwn.net/T/#u
-- 
Michal Hocko
SUSE Labs
