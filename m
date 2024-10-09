Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372C370
	for <linux-security-module@vger.kernel.org>; Wed,  9 Oct 2024 00:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728432218; cv=none; b=ehvlt06msxJJEJJKZc64nPOQvHSylaGs5I/I91h7iT7q1y6XT7YLM7qnO5NeVMahk/YooLSXLCmtF/kLKJSrjb+Ybb3SzsQ+AdTze/To1B8yYBJSaZ2VodP2limFBWLdBA3RvV6zdBxhOk04gQXmItL0Ekit7bhYWuxU1SXbtAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728432218; c=relaxed/simple;
	bh=4isKTSnGZnWy2IfXN7gS5dEf0YoojasjmIgkuR4XjEE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlj6MZqyq0tuW67ieN3UumaVY2Ox2BrWzvn4jRmbUmAdZGHqLFbENTe7f1qOBUuUhqj96LYH46ItKuyV02GUeurzUDwi31PnYFncFZepFZm+HqizZlCYK/KBPlcVAxAOVGNfAnrNqsepAr8g2/Zm8FzEzRdTjo6iSvnRsOn6ZjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=FeFgJHR8; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="FeFgJHR8"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-20bb39d97d1so54170655ad.2
        for <linux-security-module@vger.kernel.org>; Tue, 08 Oct 2024 17:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1728432216; x=1729037016; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fWH9enmlhfqAT3vWvYvl8tJAKSdliXa4XjK8FeqbOo=;
        b=FeFgJHR84nfGCSj8Vpar+qujcLKobmHYkyesBB83YqzH6yqunE6zzdqd/W70LkqDKy
         /qsLtjMkp3vuXstQPMAF+RTVQqZBmypAgXfPHYTTI+aoHjJCMw9mpVxjjQWwtooWkIoS
         Az6uoMfLXWWjnbuLIt0Z7Cpc0hU1usy34TeJFo8c1m74/hx/odlFLIaTKvbYrAYmxcZf
         6QtlOtkF+q90chGDDTvUMaXk0KPddnFaplsgeDidlO8DL0tZgB+xwhMFDaq092iAxPR0
         6m6InlDY/RIffeNHzw9H+kTQ66GgXMqErkcANN9AOybUd0weIODjblsUjQdCQVJhPN62
         mfVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728432216; x=1729037016;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fWH9enmlhfqAT3vWvYvl8tJAKSdliXa4XjK8FeqbOo=;
        b=rMSwnTEPJHK4ecCh3/WkemBpFD4QMLtIEYhIt/0TKvnkhN5JWSmn6ss2mVBNb26taa
         jTkRuiAwbSezN3/WbN9SdrN5/hqiNZIQIrMCpiUp5MpmZSt2o0vXjtwq1L2gKlLQUkAt
         Tgp8lj+cyU+Iw/LK3RbQDLq0xXjzzRtoHAN2X1+ce+wtaX//4RJ9FaTXfv13yAHsWsLh
         ne1cijZWX5fskvx+16GlDf8tWNk8E4kEBqBSeF7U3nOl5r8ywmzUxw5IQFGO3tGPM/7b
         e5Xm9cJ+BtLTr7vYjcXzIuMf81GYml6YRcAQH8iNx1AOOk8LEVQbjt7/6hJrbP6rkSh6
         suZA==
X-Forwarded-Encrypted: i=1; AJvYcCXUBD1/7+pJh94C8/WzsCMuIXKdxBn+Wn7ZRP8TEg1aEOym/J297yc8Nxk2DcEtbXCWvBuIKeJqS+aMrB1WMVActo6/ycs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQOuCl8wcvO8Iget1KLJvbS397e4BHb9vTeKyY5x6YceceMMcq
	fDePYDwE/KY+HId9YftCZE0IO2+bq9Kl+42GJ6Ns2LZVbZVHGNMAy/OK7ANXSHY=
X-Google-Smtp-Source: AGHT+IG3HQtugnX7cL0c229gRqowrq0NHWN1EMQPefxreF1oIsepqnEwQBhkCpq1bsv0lkRKJD9/Mw==
X-Received: by 2002:a17:902:e743:b0:20b:96b6:9fc2 with SMTP id d9443c01a7336-20c63746f29mr11451615ad.10.1728432216227;
        Tue, 08 Oct 2024 17:03:36 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-78-197.pa.nsw.optusnet.com.au. [49.179.78.197])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139391e5sm60763765ad.133.2024.10.08.17.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Oct 2024 17:03:35 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1syKAv-00Fo9C-0y;
	Wed, 09 Oct 2024 11:03:33 +1100
Date: Wed, 9 Oct 2024 11:03:33 +1100
From: Dave Chinner <david@fromorbit.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@infradead.org>,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-bcachefs@vger.kernel.org, kent.overstreet@linux.dev,
	=?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@linux.microsoft.com>,
	Jann Horn <jannh@google.com>, Serge Hallyn <serge@hallyn.com>,
	Kees Cook <keescook@chromium.org>,
	linux-security-module@vger.kernel.org
Subject: Re: lsm sb_delete hook, was Re: [PATCH 4/7] vfs: Convert
 sb->s_inodes iteration to super_iter_inodes()
Message-ID: <ZwXIVRzMfKV04DfS@dread.disaster.area>
References: <20241002014017.3801899-1-david@fromorbit.com>
 <20241002014017.3801899-5-david@fromorbit.com>
 <Zv5GfY1WS_aaczZM@infradead.org>
 <Zv5J3VTGqdjUAu1J@infradead.org>
 <20241003115721.kg2caqgj2xxinnth@quack3>
 <CAHk-=whg7HXYPV4wNO90j22VLKz4RJ2miCe=s0C8ZRc0RKv9Og@mail.gmail.com>
 <ZwRvshM65rxXTwxd@dread.disaster.area>
 <CAOQ4uxgzPM4e=Wc=UVe=rpuug=yaWwu5zEtLJmukJf6d7MUJow@mail.gmail.com>
 <20241008112344.mzi2qjpaszrkrsxg@quack3>
 <20241008-kanuten-tangente-8a7f35f58031@brauner>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008-kanuten-tangente-8a7f35f58031@brauner>

On Tue, Oct 08, 2024 at 02:16:04PM +0200, Christian Brauner wrote:
> I still maintain that we don't need to solve the fsnotify and lsm rework
> as part of this particular series.

Sure, I heard you the first time. :)

However, the patchset I posted was just a means to start the
discussion with a concrete proposal. Now I'm trying to work out how
all the pieces of the bigger puzzle go together as people think
about what it means, not polish the first little step.

-Dave.
-- 
Dave Chinner
david@fromorbit.com
