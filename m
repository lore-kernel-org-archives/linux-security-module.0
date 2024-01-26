Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A483733CEA
	for <linux-security-module@vger.kernel.org>; Fri, 26 Jan 2024 22:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706307543; cv=none; b=BzPrZNbbU8PqeK1fDvmUDBECoJEpAbNytPoR5Kxs9LIoI6PaLJ/sIovI0oGiWCOsWIAyQCZyvHcZZkYnHErx1yO5uCTYGW75qRy4Z819Pam/6enOR4Qg+zjohT0xq1MuIaMcF5bgdOh5P7z7x0tlBsiYl2jxABrYKDwdh9YpDKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706307543; c=relaxed/simple;
	bh=qpzQw5s6Dqxh+Qc3y41Tq123yZfxoXEp3OvaOWhv/ek=;
	h=Date:Message-ID:MIME-Version:Content-Type:Content-Disposition:
	 From:To:Cc:Subject:References:In-Reply-To; b=VaRPDAdcAjvDq05uduElT1c74ztZDOAK+tc7gyaRubw/dgRJfDI4XGBhKSLvLvGoypLbuLFJWdUgxuSv8b6x1inZkmdpfdRxP5Pk2tdbAt2SXR1I7arw9tCSurvxkRNH+4DCmn/KgG6VIv5LzgP08We97b2xa7lO21R18HG851k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=WgzItryM; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="WgzItryM"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-783ced0216aso44437885a.1
        for <linux-security-module@vger.kernel.org>; Fri, 26 Jan 2024 14:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1706307540; x=1706912340; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bp1h2UkOsHruZ6BwuUmNXr6zMZJ5tkOoiZnpdhJ7b4I=;
        b=WgzItryMpIwDRwVR/AioiJ+wyB812W6Ts9lA3VMu/+IGmFuJWP4jylc2OcIyZ580dv
         8kaiHGyYZSgKLbn04NUX2VIGmEJjfjJhgLNXfW+3leHezMH7c0XvmO50uscd1rdiXkxW
         sjjtHpp0HdVuqQCKBbJC348cFTc0hq09pbcU7MyrH4WPZ319wDn4pSFwyLHhtLOmG9A0
         PzFDvjknZG0Ifv6ZfX1AFsMkqH8DJiudvwwmjm5z4VVTFKdo9+whR/+CU8EnLirJX0Az
         nwAVsL2C0PME88RelFM6c4JeGjhXsdANG84m4uNzvXWIleQvZ2XS2cx5NFNXlxcdEe/M
         FzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706307540; x=1706912340;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :content-disposition:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bp1h2UkOsHruZ6BwuUmNXr6zMZJ5tkOoiZnpdhJ7b4I=;
        b=bwbHLK1xjgvxeGD8xXxqUs7t/EsVm5Tu24hhOGuiop3c86OcdjbqL+7HsWZmjaw8jP
         7BEH5vuX7mPnlGBXnvxI0B9repa5YiSsa9xLat0VqnqK1vhnSSjVBX1P/hdHbyyoiZFl
         qtwU5T/Iz7bAT9NnSVBn5yq56StTNqkdODtiLYe3A+RmQ14LKvDew9P93uiwYgijC1w3
         Ft6LM4eYMWW+lw0pME3h37EUMbJft9sTZWV1n+u4MXEDD4/NOx0pgDUy5uoxgCKN7eI/
         rYzVFqjLfBq9XhZyk9nMTjLoV8OSLMmYPStS3RgK9XFixFTrNpD2TV5SIJUWBwz8N6J0
         1jwg==
X-Gm-Message-State: AOJu0YzuJpd6PLoUj45pr4TKH+KDQ91HQ8KRKzagKj9XC+e7nayNIjE8
	/Hi7/y/uroSzz2V3xxqKOhUy9aCXKVo+sXM6ISqOdnvIKShMzY8iXVYBCev5v8MG5E3J6kXy1uk
	=
X-Google-Smtp-Source: AGHT+IFgBnXc0hgyvmYRe2ni5uzRKRcYJb9teEW+YwzPApVx696blu9ZWpPZsfHPxIfO9nBt6nBsWQ==
X-Received: by 2002:ae9:e513:0:b0:783:25ef:818e with SMTP id w19-20020ae9e513000000b0078325ef818emr460280qkf.116.1706307540461;
        Fri, 26 Jan 2024 14:19:00 -0800 (PST)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id f15-20020a05620a20cf00b007832b17f3eesm929603qka.41.2024.01.26.14.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 14:19:00 -0800 (PST)
Date: Fri, 26 Jan 2024 17:18:59 -0500
Message-ID: <b3e1fdd22be4d2abbaccba73f6dc3e38@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=utf-8 
Content-Disposition: inline 
Content-Transfer-Encoding: 8bit
From: Paul Moore <paul@paul-moore.com>
To: Ondrej Mosnacek <omosnace@redhat.com>
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, linux-security-module@vger.kernel.org, selinux@vger.kernel.org
Subject: Re: [PATCH] security: fix the logic in security_inode_getsecctx()
References: <20240126104403.1040692-1-omosnace@redhat.com>
In-Reply-To: <20240126104403.1040692-1-omosnace@redhat.com>

On Jan 26, 2024 Ondrej Mosnacek <omosnace@redhat.com> wrote:
> 
> The inode_getsecctx LSM hook has previously been corrected to have
> -EOPNOTSUPP instead of 0 as the default return value to fix BPF LSM
> behavior. However, the call_int_hook()-generated loop in
> security_inode_getsecctx() was left treating 0 as the neutral value, so
> after an LSM returns 0, the loop continues to try other LSMs, and if one
> of them returns a non-zero value, the function immediately returns with
> said value. So in a situation where SELinux and the BPF LSMs registered
> this hook, -EOPNOTSUPP would be incorrectly returned whenever SELinux
> returned 0.
> 
> Fix this by open-coding the call_int_hook() loop and making it use the
> correct LSM_RET_DEFAULT() value as the neutral one, similar to what
> other hooks do.
> 
> Reported-by: Stephen Smalley <stephen.smalley.work@gmail.com>
> Link: https://lore.kernel.org/selinux/CAEjxPJ4ev-pasUwGx48fDhnmjBnq_Wh90jYPwRQRAqXxmOKD4Q@mail.gmail.com/
> Fixes: b36995b8609a ("lsm: fix default return value for inode_getsecctx")
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> Reviewed-by: Casey Schaufler <casey@schaufler-ca.com>
> Link: https://bugzilla.redhat.com/show_bug.cgi?id=2257983
> ---
> 
> I ran 'tools/nfs.sh' on the patch and even though it fixes the most
> serious issue that Stephen reported, some of the tests are still
> failing under NFS (but I will presume that these are pre-existing issues
> not caused by the patch).
> 
> I can also see an opportunity to clean up the hook implementations in
> security/security.c - I plan to have a go at it and send it as a
> separate patch later.
> 
>  security/security.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)

Merged, with the RHBZ link tag, into lsm/stable-6.8.  I've also added a
stable tag/Cc should this should get picked up by the stable folks to
fix the breakage in the recent stable kernel releases.

Assuming no problems are uncovered over the weekend and early next week,
I'll send this to Linus next week.

Thanks everyone!

--
paul-moore.com
