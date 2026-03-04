Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06D083988FA
	for <linux-security-module@vger.kernel.org>; Wed,  4 Mar 2026 09:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772616639; cv=none; b=PnTuync0q+e9H2xSnQfm3ScUQ8xcgaPT5fNrFeJIS18uFgsm08lREmWM4BMa+d+m9Yq+ASWCCrxEQKk6r3D9BABThOJo72Rb/1GRvdrdqUoDHVAdlRvB/ZtvKh8YCUEDB27p18eWQEUG3b5WeUiMsIbpV/lQeJPAqnMlP14pAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772616639; c=relaxed/simple;
	bh=qyvL/iXE6+TakoKVVxVCaopqm1BpX+f7Q05dx5gBHDE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwyo+svmMDYXiYxG8SfbGuVK6aXGevH1jQU2fvuks1qBiGTDLVxTT98v0GV3IIotCKZwnpXbdOn6YAPHchvBkI+D6Dtz7EcJTNVta4dJnO+Ei3sQYsTl5lxyzrAvrJHQFA2JsPYPJJxhHlwSUX9zwIk1f86DVgz35DIYDokR2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9sIRKFF; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9sIRKFF"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-483a233819aso64872385e9.3
        for <linux-security-module@vger.kernel.org>; Wed, 04 Mar 2026 01:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772616636; x=1773221436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
        b=b9sIRKFFaokgkSrgeWrbA/ViOpJjWP1ViLK9R1Hc1//m2coegBzgKtpFqwevCmiACZ
         C7afbaacWCHtjdaHICcRaatb9x6ZEJn6NhG6Zj9DIWESFWJ1Wfs22M1hBHSvsJT6ov0y
         u+gbatvToXFWw4Ws1z6B810aDtF2H+NtjWSzWUXjnH2Uagh4gEk5+S1nkLp8lVzxzopS
         A1lgIkzEEAlqX7ANlEMButL3162rmrsjjiFCTqL06qEr4gqfcdGAwI6S5Z1yvtqPS7rR
         QeMeyyLIZ4ZsiMHZmsjBPBW/Gjz82S/2K6mHxq88plnIdodtUPQPjzOSR2cd/SZiIcXY
         bgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772616636; x=1773221436;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BUzQoESoh9/PqMSFbMpuw4Pmh5IPXiGP/qvOjxX4wwo=;
        b=BtCEy/Cc8ZAEWqe4j7wXB3BlahzabM1BXQqXmDWq6fr+XmVsbcT5OjNvgHdiPg4TvN
         9KO5D72HX8lTkSjtCU0cRppU+2awzNZUAh8yOEm5cpmf5GQvNEyKb8LQmMhDCxX9C10J
         eSvhh2WZId5Y9FxyNk9ewMvpqg5LPiFY1YHK/pJCQqqlBZj8+Q2pZwHbMgrlVA0OTy3+
         a0NrmZWncRsclrRLQKBTIHF6t04mDJqufTpGE8QEExArdHEXGVX40DgGMznyr1nsengV
         UbprcEppR1WxaXH/XK1lT/GGxkLOB2pAN/a0SubtyXkbGseK9x02IoYDdOZbNOCfC5mR
         5WXg==
X-Forwarded-Encrypted: i=1; AJvYcCXN/vVRzHDB6wWzc5avuYdMjP6Bb2unKlvZ73Xh22UsgA16PyHYZ75AsXObbdK+XSC3w15lijt5TvX6J+XvHKhp2FCu2d4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcjQ29m1SSjE0yFtzYL9M6AHZqR9bGwXPQwpRzS9ptjjkuWOVa
	ewga4AgWV66md56sn3p/hAjO6Z086APByIKaqLL6YuS/i/E4CpXkn7oc
X-Gm-Gg: ATEYQzx7UBBxezgGy1iCIAdi22BnevcijtbqHVB0RpStz/CAtCePfAEotCKbN+wao3R
	uvPGpfiuFCKn6MKlmvq/xy2dIPyA+vFmZh2urpvCqJMwo+U4U5nVruPWpCM8qixbcO/4zRfG3pH
	1WTRO1N1QrARchHNHTaqb3BzQFHn/eKVwSDP4sMsVmz9+w94VvwLEfuUIVVxKvhfNB3PBOTpQJ8
	u0wBny5+TIDny7p0UN2stqDWkiVYewkN7+UlDdgATnkZMywqLa6kdFyuaUNuCU/pOwcX+ZIUZb0
	WKHvE4F9p3Fb7pErZ9SvLbjT0e5cW1FiILDslXuroUZkrzNqU5sm5dmGLgJk+KRWJih40GzWGO8
	q/X71gTwXou9pyw1KwlVIzZHIxTjQNfzaH1WDNYMJe660d6WOmj4r5oM2rPHLoOCHV8crzMUc7g
	GLfWooX3rFvhO9z/rW8L9gdp/thcmFHoug+n5pnumpRkIXK3zYG7NLTmXgXTlr1qpj
X-Received: by 2002:a05:600c:8b53:b0:483:498f:7963 with SMTP id 5b1f17b1804b1-4851989024emr19550785e9.26.1772616636117;
        Wed, 04 Mar 2026 01:30:36 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4851884225asm38972555e9.6.2026.03.04.01.30.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 01:30:35 -0800 (PST)
Date: Wed, 4 Mar 2026 09:30:33 +0000
From: David Laight <david.laight.linux@gmail.com>
To: NeilBrown <neilb@ownmail.net>
Cc: "Jeff Layton" <jlayton@kernel.org>, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 nvdimm@lists.linux.dev, fsverity@lists.linux.dev, linux-mm@kvack.org,
 netfs@lists.linux.dev, linux-ext4@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-nilfs@vger.kernel.org, v9fs@lists.linux.dev,
 linux-afs@lists.infradead.org, autofs@vger.kernel.org,
 ceph-devel@vger.kernel.org, codalist@coda.cs.cmu.edu,
 ecryptfs@vger.kernel.org, linux-mtd@lists.infradead.org,
 jfs-discussion@lists.sourceforge.net, ntfs3@lists.linux.dev,
 ocfs2-devel@lists.linux.dev, devel@lists.orangefs.org,
 linux-unionfs@vger.kernel.org, apparmor@lists.ubuntu.com,
 linux-security-module@vger.kernel.org, linux-integrity@vger.kernel.org,
 selinux@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, netdev@vger.kernel.org,
 linux-perf-users@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-hams@vger.kernel.org,
 linux-x25@vger.kernel.org, audit@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-can@vger.kernel.org,
 linux-sctp@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH v2 000/110] vfs: change inode->i_ino from unsigned long
 to u64
Message-ID: <20260304092559.554ac9a9@pumpkin>
In-Reply-To: <177260561903.7472.14075475865748618717@noble.neil.brown.name>
References: <20260302-iino-u64-v2-0-e5388800dae0@kernel.org>
	<1787281.1772535332@warthog.procyon.org.uk>
	<1c28e34c7167acf4e20c3e201476504135aa44e8.camel@kernel.org>
	<177260561903.7472.14075475865748618717@noble.neil.brown.name>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 04 Mar 2026 17:26:59 +1100
NeilBrown <neilb@ownmail.net> wrote:

> On Tue, 03 Mar 2026, Jeff Layton wrote:
> > On Tue, 2026-03-03 at 10:55 +0000, David Howells wrote:  
> > > Jeff Layton <jlayton@kernel.org> wrote:
> > >   
> > > > This version splits the change up to be more bisectable. It first adds a
> > > > new kino_t typedef and a new "PRIino" macro to hold the width specifier
> > > > for format strings. The conversion is done, and then everything is
> > > > changed to remove the new macro and typedef.  
> > > 
> > > Why remove the typedef?  It might be better to keep it.
> > >   
> > 
> > Why? After this change, internel kernel inodes will be u64's -- full
> > stop. I don't see what the macro or typedef will buy us at that point.  
> 
> Implicit documentation?
> ktime_t is (now) always s64, but we still keep the typedef;
> 
> It would be cool if we could teach vsprintf to understand some new
> specifier to mean "kinode_t" or "ktime_t" etc.  But that would trigger
> gcc warnings.

A more interesting one would be something that made gcc re-write the
format with the correct 'length modifier' for the parameter.

That would save a lot of effort!

	David

> 
> NeilBrown
> 

