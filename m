Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F71306486
	for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 16:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769446341; cv=none; b=ZoWF9iHbstJ6iZVWWFm/qMqOsdtVneleeUycdklHpYmfnDoTFyWdmSM0MBAwAtR5zm443wHjQ4VKmhAGB7Qs3HXXJq5zhASglYrVYtyQ7XtbttOXjBaQpn8JHVItcYPLgIRdgQvD2o3yiEGMUtbAQ9h38pQMX+LRCaukBzGJr+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769446341; c=relaxed/simple;
	bh=FwuQyobXUa3rGZ00bfbz1Bialw2/KrjtbB9iSkebktM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gITlUa9n27yvrFDSJWyekgPBxwQJ64Fl05AwJe0ImkPBPV4/VtCbo9h2x8scAFbqeOHZn8n2p9i2LEyQJ49+mg7T9MW4z2uwCO/ZxCSHMp5cyjuxMRe3sW1AawrrSTwys1H2YFn8nwnoRxoNfLJGoY6xNbcCWhJ7m6zFAhUmFg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5FGHTXE; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5FGHTXE"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-435a11957f6so3912512f8f.0
        for <linux-security-module@vger.kernel.org>; Mon, 26 Jan 2026 08:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769446338; x=1770051138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=31wanlT+6Au80Qu9oKuPkvV8GImmjOjGKb34LDPwV58=;
        b=A5FGHTXEEr2dVnBW9bkxOkrBWnsiDf868IEfLhUnrBFcT5Pe8AKJQSEYkrRTwDJbES
         TLMhvScPOo5fvFu7obLKEp2AN00FyaWfz5WGMopRrtK0lbH9NIFEvmz4BMs2XiX8ig9E
         i2xwy64jblJXKiaYEzfAog3yhPVMD3+D5xCTiWT7o+0BZj9WkkE3CKMuKlL5+zQvOo6w
         94krv/Ahmj5M4iikfDoPH8MrYpgl6evMYJD3p2jDYcTV8EB5+TJAf50M/nJKdtwDKPWd
         b6qBEFRWR7lJO9IvCVgcy3JxeiUg8OcgHQePPbwWw2d4l+rpdKY8tRWZiHUvxKK1G5Q0
         x2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769446338; x=1770051138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=31wanlT+6Au80Qu9oKuPkvV8GImmjOjGKb34LDPwV58=;
        b=CAndFnmzzHQm7q3Of5NNAYJn4+sSAxOrXw6L7BiZvAKRXEeZ0EE6g8zPu4GYUmgM0P
         JagYuhtOEHwGy3MheReT6/8QRughFF+BtU2y32gUXWSfF0C69H3IlAvSAsVSMxMU6P/4
         CeG1ZIjPdhfOrlRVWu5u2yghGLHieqGAjLBDw/f6Cpt+Za4KuYIZ1x6QrxESJ6wmOlr1
         FHCKX2s3WxfDswgnQ1m1NLKHKt5Yqn9xO6uENzywd/SQyDwwWo4oBuJuXkG4wS0N/TmG
         Wp0sHqa4C/ZqeptbID3J8SVApV1M+cidYj43CedRaOFtQxbWXqVFHCVTYEaQCZ4gn2AF
         CW6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUOLJAK7/vwndYnWww7OWVLsMs/YSbNtboE7Go4OLmdndKIwa8zz2DgA80P4RAevLAYzMImdFMl3JECQ0sDhZd+NyT+S9M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGvDY+eyJBmA+QKyDXISLyWN4b4fpUqHO9rPnScaNg07YWZ+Ki
	/DvHwj545rTYLlofJsRa/zMHnFcVKGjo8PjwD4OCuRK4ltwviwI9R64/
X-Gm-Gg: AZuq6aJsXZfrKY2i/JYdu2HbNELAcUK5nWDM3caO7H6M6Mx9nxdE1/QFPhO+lvK6/5J
	zXEwD7ZzDC7ItT/x83lKVRxDYasiNMrSF3smI96155+4R02PznwtAliDeFX7gQn5XYg/tzURa5e
	no5KVfs7WrWv7pUtA7d0lyNjplaU0CO/LduNrI+DGQjNZiH2CsZWPRr6k2cF+zuV57UVUQ2ZsM0
	7JTrfOD9V0CtOGU0b/YKc+U5lWDm7oqnjlkEtdYUyzfmfv2BfegmSSHMdxOm5dep5Baj0+meNNz
	eQBxBi9iqi0h2g+YWgEKikFuexy8wbpMlDp5d8fjYLzOQlgEI7xEtwNXrqMibqpf62CvLqPUJsi
	Y0tin0wLli8cm13bYKWCR5B/ze3Rp0JSvPJthOEGTk+ug05z1e0QySMQ2RC8Z7umxpouuLyQd84
	ysHe+foYvn/gI2E8fbSYj9J6xWPpRXejmFrzDx
X-Received: by 2002:a05:6000:25c2:b0:430:b100:f591 with SMTP id ffacd0b85a97d-435ca12fdc7mr8705685f8f.28.1769446337791;
        Mon, 26 Jan 2026 08:52:17 -0800 (PST)
Received: from localhost (ip87-106-108-193.pbiaas.com. [87.106.108.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435b1c24f15sm32338988f8f.18.2026.01.26.08.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jan 2026 08:52:17 -0800 (PST)
Date: Mon, 26 Jan 2026 17:52:16 +0100
From: =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>,
	linux-security-module@vger.kernel.org, Tingmao Wang <m@maowtm.org>,
	Justin Suess <utilityemal77@gmail.com>,
	Samasth Norway Ananda <samasth.norway.ananda@oracle.com>,
	Matthieu Buffet <matthieu@buffet.re>,
	Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>,
	konstantin.meskhidze@huawei.com
Subject: Re: [PATCH v2 3/3] landlock: transpose the layer masks data structure
Message-ID: <20260126.fd8c7b7537e1@gnoack.org>
References: <20260125195853.109967-1-gnoack3000@gmail.com>
 <20260125195853.109967-4-gnoack3000@gmail.com>
 <7b7b8fd5-7e1f-4572-a342-11a0fd24b0ac@infradead.org>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7b7b8fd5-7e1f-4572-a342-11a0fd24b0ac@infradead.org>

On Sun, Jan 25, 2026 at 02:02:50PM -0800, Randy Dunlap wrote:
> The first line here is confusing: "in @rule in @masks"
> Maybe:
> 
> On 1/25/26 11:58 AM, Günther Noack wrote:
> > +/**
> > + * landlock_unmask_layers - Cross off access rights granted in @rule in @masks
> 
>                              - Update (or Remove) access rights in @masks that are
>                                granted in @rules
> 
> ?

Thanks, that is a better wording indeed.

Will be included in next patch set version,
I think this is less grammatically ambiguous:

- * landlock_unmask_layers - Cross off access rights granted in @rule in @masks
+ * landlock_unmask_layers - Remove the access rights in @masks
+ *                          which are granted in @rule

–Günther
