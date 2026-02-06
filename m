Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375CC280329
	for <linux-security-module@vger.kernel.org>; Fri,  6 Feb 2026 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390351; cv=none; b=mELO2jgJdk88cmKrc+b5QkNNFQGIpPBpBuv9/2im9tjNnD95rUxnHFvR7bd/KWGTAPQb0JbGaiyFl059zs3mRzWSB67Lr4c5Q/S7n76j70yo6EVYX17UWNhDxLE+e7JYa7Zx9liOPqzDpvcxeoIMYicxbD8VMtALUnrzUiAXD/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390351; c=relaxed/simple;
	bh=3viOC1jQ5M6s8UgvvrTdLLKV6IqlstfTgujlxqBKJus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+evfZ+Xa5gvhjyMTu01eMRVMU4zm4irtWV4RuU287VwKJqQKHT9fk1SN+hd/PwqVbTpxycMsV1dNYOPsrHt8e7EnXPbn+3Bg/FfK/QEipE9L/GubEXBXu3x0mULS5iX2xtWkU1Kh6QeH6IoeQaDMI7x+yOFbtdVnLCLuJeDipo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lxspG6q8; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lxspG6q8"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-482f454be5bso27117065e9.0
        for <linux-security-module@vger.kernel.org>; Fri, 06 Feb 2026 07:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770390349; x=1770995149; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Vh1+QCwU/Th4Bv5wKQ+RAnb2cUbXXFldcPPS1LJmBRs=;
        b=lxspG6q8XQXp6cUsnmM1MCgSOGA0oy333u7R2GYXOVlSqgKP6jBtvYqxOqDHj3p1Fa
         vxKE2TgaUc8lMUI4WLnS4a2xGWIgEJkZFSInD35CvicI0KsLU7lhkrO5fl5KRrylm5e3
         ao+SdFGXKxw2MWuhO0JQIXBOE7PLb8Nj1GyNihGohVfP3WPJTDnRV7UgXf/jr4UCDFIX
         akpFBRtrxpn28+FGDLx9K9bTJnwod/fERMVnMwQHAEMN7m53+edahLzVws0qR41vjtE0
         SMri2kN7luIA4ukE+kMW8pkSZmK9ra8vZ6iva2Puqxx7mnXCgSIsTA7hiFRfFQx5gk4P
         n51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770390349; x=1770995149;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh1+QCwU/Th4Bv5wKQ+RAnb2cUbXXFldcPPS1LJmBRs=;
        b=hsIvYtdqxH/7s8ZAMcIHChgzyyH0HEsaCKSxJ6RLW/aRmoOgDhCis3rUOaLIv2UaHn
         9zanbwtLp59YScBJQDp60lS57y1Hde83A+uE/jywGykca+XwYDupqaIs3q/Lcv77/YET
         TmwRUgHjwRxlnaJYqKt2wcBDm45Loacesy/8+r8BtmnrdzIOFdzwO2EQpGpFy1HHmfYP
         P3ZBYhvushViI5mbiBnKeuYpkr1Zc8ILJ3E20wbbYQynmD9dfqL14tNLZYpB3D0Fd8sS
         2geZmSy35V8wVl5uHXnTvMqwLti7ygMuD/CN02oGKEbLHoIeJ3SZ1vyzv842l55jmvGf
         OMvQ==
X-Gm-Message-State: AOJu0YzP9f83JLhnOxswGvQEy/2PbIIeewtTH0BiyfOsE6IBk9Q00I3g
	w61yycRapLZG8F8c0JaU4M5clBm1hMlgYnRcCqcFIE22mvwlr1H8m2NG
X-Gm-Gg: AZuq6aIOc03QnTJWxdkh+lVHVwDM5KG6/ue4+umflf2alxxG2oKgyHuFWTuw2v2HIHS
	nAegbcoFDtZvm7RuubJBzaTwGlQa8Eta7WIG9pbmMNIlEsiX+9OGShB/ZA/H4VCxnckUAtDBJA7
	P+ajKQqZaY9AcVJkrnnxCSEV2N1ZUucQVj4yJ+YTZ9KzPLTRx4MNoP+gG4hsODf6XM5Odvs61yp
	BUJujihhEdbiVBvAs3YIGgKRDBsJaa3e2WtOO/YwnIlfe4ycZ/BUMClZx+CHZLtcyB926ftoPFH
	PkYqPsaVP6aLyaXn2oAakf+1hTdCZMWQ2tVxtDgRVc836qZ5TuuIkjC7Ksd2P2R6seaHLYK5cTx
	R7Z0DtzJtyO/boHpeUw6u90zulJqhadn4MLK9ZfYrEUK3o4Rvi4y+FOhXEvxDuXxXBaf8gZ7eWr
	xFJNGzvwSgAsQOuTAOu9rvNDPhscL4V9H2J0N1
X-Received: by 2002:a05:600c:6d11:b0:477:a53c:8ca1 with SMTP id 5b1f17b1804b1-483179218d2mr72575335e9.14.1770390349401;
        Fri, 06 Feb 2026 07:05:49 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48317d33f5fsm138517975e9.5.2026.02.06.07.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 07:05:49 -0800 (PST)
Date: Fri, 6 Feb 2026 16:05:31 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc: linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/3] selftests/landlock: Add filesystem access
 benchmark
Message-ID: <20260206.50e4ed89b670@gnoack.org>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-2-gnoack3000@gmail.com>
 <20260128.eiJou3fiezai@digikod.net>
 <20260206.e69a9f79acac@gnoack.org>
 <20260206.ietoh7AeR7Ei@digikod.net>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260206.ietoh7AeR7Ei@digikod.net>

On Fri, Feb 06, 2026 at 01:59:41PM +0100, Mickaël Salaün wrote:
> On Fri, Feb 06, 2026 at 01:24:02PM +0100, Günther Noack wrote:
> > On Wed, Jan 28, 2026 at 10:31:23PM +0100, Mickaël Salaün wrote:
> > > We should have a loop to build the directories, then start the timer and
> > > have another loop to add Landlock rules.
> > 
> > I have to politely push back on this; the granularity of time
> > measurement is not high enough and the measurement below only works
> > because we repeat it 100000 times.  This is not the case when we
> > construct a Landlock ruleset, and it would IMHO be weird to build the
> > ruleset multiple times as well.  It feels like this would better be
> > measured in a separate benchmark.
> > 
> > Adding a rule is an operation whose runtime does not depend on the
> > depth of the nested directories, so such a separate benchmark would
> > then also be simpler and wouldn't need to construct such a deeply
> > nested hierarchy.
> 
> OK.  Please add this explanation in a comment.

Done.

–Günther
