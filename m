Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBF7221FAE
	for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 04:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757909420; cv=none; b=Cuq1B8Q/gYTelSnyjeXGKW2APUalqmAlbagKYtGrrIkS2i61KNF3Sn2weCAUNDUCf17zdBVrNvbo3RZXbp+pwCRnnK1tVbfDoWm1TmnCdPa8CYadAvXJ3kjR83RH1l0n7MJ5UvQjg26T4vNLMgnmiPJokQyrpX695BfCjgrDVYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757909420; c=relaxed/simple;
	bh=h8k5kgiQo04J4cYIvgiwArMCbShond7hXSIPbojyJj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=S4pXJUvCgoONhKD1ZUfditHvRk3oMbgr82/uCj5QJahHgepSEL99q9VWT73mgo4eSsNEtl0MKS5SxRqmzB4xCFViJzUXyTOi3gSEkblPzTxKMJujDu8vSf75rmsvoh5zGSlaE1PqfwaW3z/eAbZR8claZVM0swWUQoR/OjlFfe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=faZbQpMT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="faZbQpMT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757909417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sGoOHPT/CWj+fQ5zG/JFWu43Z6MNUxq6JbcjP4KWET0=;
	b=faZbQpMTylw8DgQFZq7aNnQrZC2Qrg2XNPe+IBxHuzw5clCknOTtL7La/A2mstGGb0WnLQ
	rur7qDiKV3L6YbpJPSJpspymiporg6dYjn37/Jmt5zeA4JsdtLaUv2ZLMBpYjy9bBcNmtw
	qHbuTs2W8b+/VBV+d1bYDyt6g61Jyus=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-Z12kA4-YOj2AyH9WgXiW1A-1; Mon, 15 Sep 2025 00:10:15 -0400
X-MC-Unique: Z12kA4-YOj2AyH9WgXiW1A-1
X-Mimecast-MFC-AGG-ID: Z12kA4-YOj2AyH9WgXiW1A_1757909414
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24ced7cfa07so40177915ad.1
        for <linux-security-module@vger.kernel.org>; Sun, 14 Sep 2025 21:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757909414; x=1758514214;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sGoOHPT/CWj+fQ5zG/JFWu43Z6MNUxq6JbcjP4KWET0=;
        b=YaV4SgNQjh9Fq9w1OJG1vc2qny7KWIz8nWNnMhahTQAytRJKi0PEvqqd2q9e4aRagh
         B126No9DCVxIwZcAHxlE3n125miB7A+/eyNZ4qLKSHYPNnb7e3dJAA35DZTe/V/02Tqn
         6qkFfZuQHB+iuRvCjnkYhsDgkXgF/85HC+fdeGUvTALFSqfuF4hBqdKQtz9NqyXc1FEM
         JBUZJ24s6pzBz7tgYbMbAG0+2E1WKSOJqbRAKeV8qkVtHiVHDfM7zo6NxsoOg2E8DDse
         /62I95To3/1586heDH82SdGkNikXmXJq/Ldbjr9NMIaukUk1yBm7iCiVjX/7YNz/0ADq
         sjTw==
X-Forwarded-Encrypted: i=1; AJvYcCVsV0CGE1wR81FYpp+H5gOmQN6V7KcanAx1zgDRcBmDOYF5YMP3b7wm02/Z3q5o/f9yptpOMbkYeWzznwcRVG58EHQ6Yqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd5iWeKwe2mzNveDUxqcCIFHtZy27uBXjb/rAFJ0IOYiKo9NNJ
	vJJGA3POiVQ5Aky3b7EGcDBGyzfbOh2S0LFe4+MCaCdO+osb1Y7fKq8kIm9hdq4trb1bw9FHb0J
	kHK9adI1MuEDEm1GVZVT/J6EG4z2ZRbf6JcO12sDc3AUnZPfcNdJu0uF+ZoZCQbXG2pMc/7yaPo
	/SEmsmeY0KEtnkuLU=
X-Gm-Gg: ASbGncvFueJJpg/qs/KZ0SuQGuQ9t9eOgHxm8kTjWu4pq7kfdffcxaSANZSF5aZuO0r
	h/l94EiWrqOki3gBK0vGuWCzvutwGPp8Gd0nBjo9apg+DzYKYk3T7p6mOtEBHwzl07RW5Or3p++
	QmDXKkriKRAiOk09imQyh11l+FNUTZ2jw48Sm/nfnPL7SWFBcLQOkrWr3UpA1w1s+z3aFX4LZhD
	DzbH436F31i3X7o+YRoFxVjIsgOCY9qt+zkZr8cB2N8okteuIFpYEQIMuDp3QyWupVZby6M6te6
	qpEwChWAb6xKZ5hkq8dHd3g7+9dH6Yg=
X-Received: by 2002:a17:903:2f50:b0:24e:e5c9:ed02 with SMTP id d9443c01a7336-25d2733433amr153723605ad.54.1757909414424;
        Sun, 14 Sep 2025 21:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyK81nXtCTp8GRKJSmbRDpD+Db9frZqrd9pWO6WKwuNgkdIsfhXl6/0fESeThCnYRYxzwvWg==
X-Received: by 2002:a17:903:2f50:b0:24e:e5c9:ed02 with SMTP id d9443c01a7336-25d2733433amr153723255ad.54.1757909413939;
        Sun, 14 Sep 2025 21:10:13 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2610eb7c962sm56275785ad.12.2025.09.14.21.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 21:10:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 12:06:14 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <gw7xopwfzrp5qatwqa4n4i3miztbvbdolfaa2jxslb5pktc7fs@56r7n6feu55m>
References: <20250902042515.759750-1-coxu@redhat.com>
 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
 <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
 <13d7fcfecb06423294ae0553c9a561f4cc8faf67.camel@linux.ibm.com>
 <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>
 <wwcnoevou44eoe3ner4oegtdsdg46tlvwidu3ynobs7huac7ae@ljivg5ksohxv>
 <6f2b7320b691669068dda110c29c25f8aae2f244.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6f2b7320b691669068dda110c29c25f8aae2f244.camel@linux.ibm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7yW0e-BXSVvHgEyMuwnNlihb3ARQMlft6UgVkJsp-8M_1757909414
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Wed, Sep 10, 2025 at 08:21:33AM -0400, Mimi Zohar wrote:
>On Wed, 2025-09-10 at 09:36 +0800, Coiby Xu wrote:
>> On Mon, Sep 08, 2025 at 04:58:05PM -0400, Mimi Zohar wrote:
>> > On Mon, 2025-09-08 at 10:53 -0400, Mimi Zohar wrote:
>> > > Hi Coiby,
>> > >
>> > > On Mon, 2025-09-08 at 19:12 +0800, Coiby Xu wrote:
>> > > > >
>> > > > > Even without an IMA appraise policy, the security xattrs are written out to the
>> > > > > filesystem, but the IMA_DIGSIG flag is not cached.
>> > > >
>> > > > It seems I miss some context for the above sentence. If no IMA policy is
>> > > > configured, no ima_iint_cache will be created. If you mean non-appraisal
>> > > > policy, will not caching IMA_DIGSIG flag cause any problem?
>> > >
>> > > Sorry.  What I was trying to say is that your test program illustrates the
>> > > problem both with or without any of the boot command line options as you
>> > > suggested - "ima_appraise=fix evm=fix ima_policy=appraise_tcb".  Writing some
>> > > other security xattr is a generic problem, whether the file is in policy or not,
>> > > whether IMA or EVM are in fix mode or not.  The rpm-plugin-ima should install
>> > > the IMA signature regardless.
>> >
>> > My mistake.  An appraise policy indeed needs to be defined for the file
>> > signature to be replaced with a file hash.
>>
>> Thanks for the clarification! rpm-plugin-ima does try to install IMA
>> signature as shown from the following strace output,
>
>Agreed. I was referring to the SELinux label, which would be installed for new
>files, but not necessarily re-installed on existing files.  The test program
>simplified testing.  Thank you.

My pleasure! Note reinstalling a package using dnf/rpm is equivalent to
installing a new package in terms of this issue. Because according to
the strace output and rpm's source code, when reinstalling a package,
the following steps happens, taking lnstat as an example,

1. A temporary file "lnstat;68aee3f4" is created
2. Read the content from RPM and write it to lnstat;68aee3f4
3. Set file permission
4. Set security.ima by rpm-plugin-ima
5. Set security.selinux by rpm-plugin-selinux
6. Rename "lnstat;68aee3f4" to lnstat

And here's the strace output,

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
     ...
     renameat(11, "lnstat;68aee3f4", 11, "lnstat") = 0

>
>Mimi
>

-- 
Best regards,
Coiby

