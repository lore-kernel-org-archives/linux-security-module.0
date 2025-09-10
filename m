Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9891212B18
	for <linux-security-module@vger.kernel.org>; Wed, 10 Sep 2025 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757468419; cv=none; b=SUjKcc99esHJJHbWW4/1hMwb4w7BasOiqPgIA+BOgm680VwFUcHzlvzAM2aZelxp6zzjmEfBiEv0TqrHs8hOgyPubkwZm7oEGVmQtV+Tksi20IppQwei5X6Boeol4eHU2ISkVtQlacdHjs04KpQKVpha2Q/froaJKCCxx+CclOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757468419; c=relaxed/simple;
	bh=FHt07G2ckc/YJ1ZcIYot/VUnYBJdpLJpENBo+p+6XNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=KmYJ/0MS+AlL+L5XVNxyGfnsZoOPzmDNLIwiS541VdDBArjSeuPMXuY8PZcYjO0i2A36E90IgU/Z70iSJWn/qgMFi0cfH87jOfB2i5VIR+BWetz9PocfdYcpgGQmb2Q3VvcRO7QAmRMcqiiZU8OU6fWIGVQRBms3CdDrtjViCVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KoGZKXEx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KoGZKXEx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757468416;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9bf0TnMJBEYNTRXq3aALRg5uk33yVz0wdtITnMYWXzk=;
	b=KoGZKXExTTkleqIrIJnK9KcN8qfP6mtpPkqvUGeQabAFor2LUPnv85fe71K6OIeZwnCTmn
	MUmtMsJXmt9sYC/qQO5Y2NxBVV6QOu+zs7YmgpuP84a5/claP2c3OaDINnVhPxqjJN49GM
	8zcPdD9D52CFrqC1aSo7VAw4WGdPh/w=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-332-4dRLpnqVN6CQVzCS4m__3Q-1; Tue, 09 Sep 2025 21:40:15 -0400
X-MC-Unique: 4dRLpnqVN6CQVzCS4m__3Q-1
X-Mimecast-MFC-AGG-ID: 4dRLpnqVN6CQVzCS4m__3Q_1757468415
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-32db3d5f20aso758080a91.1
        for <linux-security-module@vger.kernel.org>; Tue, 09 Sep 2025 18:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757468414; x=1758073214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9bf0TnMJBEYNTRXq3aALRg5uk33yVz0wdtITnMYWXzk=;
        b=qIpXyM0Xxqy6TYkM+PR92zvskl2j8ji1e6Tj5JMM3LRmdkSFQoI2a5WBPqs7/9ITNX
         LXkfBaY4ENNtrgRHcD0HPcgvAo8vYAA6YdJnkwBbjQOshF1XrV1Y8jwslf2nm/pzOoT6
         9cUP9aJg1SwMkeU/l09HX/G3xC7c0GyYsfOueLoY7hhlwZFOUlsWwq63HuuLJqaoW64V
         y+NB5ZEuzuEwwHSM+MyAdQpm2C3pOH3jZHi8CbU+hZYHIVmcJUZEKHKKDtfCO3l6Rf66
         uiek7SjFGpu0TWAg0gl9fYNK2MwJ8fYBe6sKM4spTuG8axy3Y1U/FlDlJ4yqtnq027a2
         qr+A==
X-Forwarded-Encrypted: i=1; AJvYcCVgvnQksWNUV2RL3Uy+CQFYgB0lDNlcwH/XydSGdrwakebKYCbZq7HQb6Y1Nr8J2zJXh4XhNtfgPbx8l2eDpnKNwFOajts=@vger.kernel.org
X-Gm-Message-State: AOJu0YxefL1Du3LJlnp/+1bIBpg/S3aa8qDgI9BClJqll/P1Nfu+mE34
	ADGB2nS/D6rXrfQseE76YtPE7a31R0s8yJ7uwI/l5A5N9JLCx75LUnzvxKJ8oO0WU79y2SUy5YB
	1RUXxM5zRjfO1WvxflSSixtzJ+uvedhlfO6A0i2zvKah3ojmjj/WSDbN5v5XpLY1O9DNFh2Qn0R
	DD1/tcaUZrpVpgd9o=
X-Gm-Gg: ASbGncsaWUi4lzhXQaiPdDJN4kihAd+LKCIRDRVDTjILJLlS55KLhilfP6BGGLNLLbY
	EtNhFbvzXOZIZP/FplLs4jCTHj7jwADhYb/UWUR2PvRsyXQrvkGPF6RYHMfxi6LTNBRkwauQ51Z
	oYs4kZRTpg55v03gp1ktBUJoeVs19q+JL+rTgiT7IcJ/hVoJ6y3lNbPmLYZvFbsYQYRjLtTMVA6
	Qyn4KxJezYi+qOZBxNNciR4l6jSAnpW/DONU1etqZzEo1Q1mLwRN0hDbsPMTqWuNI5k2b6XigEq
	ns8Y6o3uSnbJ12Eqt9mQTiWzvj3gaNU=
X-Received: by 2002:a17:90b:3d04:b0:32a:34d8:33cf with SMTP id 98e67ed59e1d1-32d43f77634mr16823437a91.31.1757468414498;
        Tue, 09 Sep 2025 18:40:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWQlNFYMJg6XtDWuyZkLB1653jaInOG0K9bglwWI7QAmLbCiyDXHVpiFBScl37R1NTsEoaMQ==
X-Received: by 2002:a17:90b:3d04:b0:32a:34d8:33cf with SMTP id 98e67ed59e1d1-32d43f77634mr16823406a91.31.1757468414115;
        Tue, 09 Sep 2025 18:40:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb00f880sm537261a91.0.2025.09.09.18.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 18:40:13 -0700 (PDT)
Date: Wed, 10 Sep 2025 09:36:50 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <wwcnoevou44eoe3ner4oegtdsdg46tlvwidu3ynobs7huac7ae@ljivg5ksohxv>
References: <20250902042515.759750-1-coxu@redhat.com>
 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
 <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
 <13d7fcfecb06423294ae0553c9a561f4cc8faf67.camel@linux.ibm.com>
 <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eueCAsVYaj7nt4B1oSdU-fHOG5NUMXjBUm7OFaKl3so_1757468415
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Sep 08, 2025 at 04:58:05PM -0400, Mimi Zohar wrote:
>On Mon, 2025-09-08 at 10:53 -0400, Mimi Zohar wrote:
>> Hi Coiby,
>>
>> On Mon, 2025-09-08 at 19:12 +0800, Coiby Xu wrote:
>> > >
>> > > Even without an IMA appraise policy, the security xattrs are written out to the
>> > > filesystem, but the IMA_DIGSIG flag is not cached.
>> >
>> > It seems I miss some context for the above sentence. If no IMA policy is
>> > configured, no ima_iint_cache will be created. If you mean non-appraisal
>> > policy, will not caching IMA_DIGSIG flag cause any problem?
>>
>> Sorry.  What I was trying to say is that your test program illustrates the
>> problem both with or without any of the boot command line options as you
>> suggested - "ima_appraise=fix evm=fix ima_policy=appraise_tcb".  Writing some
>> other security xattr is a generic problem, whether the file is in policy or not,
>> whether IMA or EVM are in fix mode or not.  The rpm-plugin-ima should install
>> the IMA signature regardless.
>
>My mistake.  An appraise policy indeed needs to be defined for the file
>signature to be replaced with a file hash.

Thanks for the clarification! rpm-plugin-ima does try to install IMA
signature as shown from the following strace output,

     # strace rpm --reinstall ip*.rpm
     openat(11, "lnstat;68aee3f4", O_WRONLY|O_CREAT|O_EXCL, 0200) = 12
     dup(12)                                 = 13
     write(13, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0'\0\0\0\0\0\0"..., 19256) = 19256
     close(13)                               = 0
     getuid()                                = 0
     fchown(12, 0, 0)                        = 0
     fchmod(12, 0755)                        = 0
     getuid()                                = 0
     utimensat(12, NULL, [{tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */, {tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */], 0) = 0
     fsetxattr(12, "security.ima", "\3\2\4\3232\4I\0f0d\0020O\231\341q\323Q\322\235\341\7\323\224\205\2104\24\241\331#"..., 111, 0) = 0
     fsetxattr(12, "security.selinux", "system_u:object_r:bin_t:s0", 27, 0) = 0
     close(12)                               = 0

But after rpm-plugin-selinux sets security.selinux, the IMA
signature get cleared and is replaced with IMA hash.

>
>>
>> SELinux doesn't usually re-write the security.selinux xattr, so the problem is
>> hard to reproduce after installing the rpm-plugin-ima with "dnf reinstall
>> <package>".

Since rpm-plugin-selinux will write security.selinux for a newly
installed file, so this issue can be easily reproduced. If you want to
reproduce this issue by yourself, here are the steps to reproduce this
issue on Fedora,
1. Turn off secure boot and boot the kernel with 
    "ima_appraise=fix evm=fix ima_policy=appraise_tcb"
2. dnf install rpm-plugin-ima -y
3. dnf reinstall iproute -y
4. Run "getfattr -m - -d -e hex /usr/sbin/ip" to check if /usr/sbin/ip has IMA signature set

And my attached C reproducer is to extract the essence of what
rpm-plugin-ima does so it can be a minimal reproducer and also to
illustrate what the problem is.

>>
>> thanks,
>>
>> Mimi
>>
>

-- 
Best regards,
Coiby

