Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159B519DF4F
	for <linux-security-module@vger.kernel.org>; Mon, 15 Sep 2025 06:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757916619; cv=none; b=B6cUsgIUPO3fc1KvPOsrGQFxLOCKme13NPi1JG65mgYyFYQRqxqrfsNQN8AfW5z4jv3u2XEqLHw5T8LGGYwadtrmGtD2iJrK4ADNXHHJVR4zqcFhCLBFJomsdvBE8APzvnz4RkK2AqTiqaNzbt+p6ssSpytErW7TjX/B6gJqais=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757916619; c=relaxed/simple;
	bh=hn/AO5Wc5PezQglXXzvuXeX5O2ZUagUhwm5XzDzqzz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mcXr+9HQBS1k3291bQprbex2RtwI8/W5qjDzHfuHzlpdJ08DWPoO9oEj1KgJVWlpdRBp3SOMqt54LumNXK8FEUKx2YBPi/Vn0e3cNWwxdGwL2jo2hwEIuaaDZNKybOHNl3KXicirIfEGbtxipAiDojBDDcfXX4Tv+tMkuCERFz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDZu4KSI; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDZu4KSI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757916616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JQLpe+khIHoCgKf3IFT4TfFBdedPAuIsgy8bFmFQ+Iw=;
	b=FDZu4KSIx+7DitYOI9CXovl22k2hxG+gzb6gt4ooS/bApvsd2T2aZ+/dwaa5msKLkx/jH2
	AWBxnpv50Io5lECuntl0y58RxHQKIZv3vx3/d817uZ+nTFtTJLgiSzxW6BxvI9g6Xc88Ev
	sq/F52sTG/i4DbqCzDydNihfLKwKhrk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-513-5myhNjODOoOubbaG16qEag-1; Mon, 15 Sep 2025 02:10:15 -0400
X-MC-Unique: 5myhNjODOoOubbaG16qEag-1
X-Mimecast-MFC-AGG-ID: 5myhNjODOoOubbaG16qEag_1757916614
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-76e2eb787f2so3495414b3a.3
        for <linux-security-module@vger.kernel.org>; Sun, 14 Sep 2025 23:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757916614; x=1758521414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQLpe+khIHoCgKf3IFT4TfFBdedPAuIsgy8bFmFQ+Iw=;
        b=aHuLpjR+LTXFIgDdTWoujvaQvaM3OV/QCaUfWt85mFKQV1QDuSO9qavGqDRzCwzbCy
         iMWsn5GM114JjCdSvj2/ob7ujSt9kP79q8qzWfDOQHn/gPT/sBBboE7pY6+X46cUESmt
         bczgGYXD1b37KQKDHUq3L7S7e7IHfN6t5W50GLmWoPbuuiDkhdEkXn/nO1LImRK8qlaa
         U/g2yD6/ChxHVrGL4souI9KxfkBzZkdE1zMLvKir/T+rwUk9pov+Xn1JxlZRor+VDHU+
         gymSisAcBBS4LKeUhJ23VSAzJdmUXb4OEBv68cb7gN9fwy4ULwuy6oLuJXpfRsJNuXki
         2nnA==
X-Forwarded-Encrypted: i=1; AJvYcCUUwYAn/07BJuvQqROPQTdjJ8ctglYDiqceCRLfkhCA4rfDz0WlSREqpZmAm04om/wFY28h0eabRw+LFnOaH+GRkO18hjc=@vger.kernel.org
X-Gm-Message-State: AOJu0YycqCnRRdoi/CnY4yMTEuCZnBKrQmSl1NQy4yfw8BPOOQE58ALt
	A236r74o+ou+qnpstK7rqeGjCYHngx9dzoqDVAFPavGrTI9hR9wCIXPhqeQnhRjOpJoY8LQDbD9
	MaCk/hqqg/uPpwXqwrue2wQH9IaAUVnH3GqlG0TGzOvNLR2qACaKnSXBa3hePcoZ00drMXrQCyf
	6C0g==
X-Gm-Gg: ASbGnct97f26sh3cCMDjfPuB4X9ethN9obAONXvyGyrM9CJIp2MKvdmeq8vumd60ywD
	Kg3qlJTzJTdZDT6YxlNDBhZWcAZOSbCRmsRnmkJ0w5Nk60GcwZGbU0dY4vDJONfSctbnZqiFGEu
	jnysGfkPM56sNGo5XAZDh0cFXLv45tnjAyVai1XMSvMS8AZvgpLaNMmgIIUS6dnrB/j6dJJzrAh
	UGy2czpkvBL6ff+Pb6pHiedFZ8KddcazxGST9bWyaJnC1gydDgDY8wwhdZ9UpuwDVZKmuUCj4G3
	M3P9L8PvaApbKsA2xNStHRAyt3FnqFQ=
X-Received: by 2002:a05:6a20:748d:b0:249:467e:ba57 with SMTP id adf61e73a8af0-2602a59a02amr14839204637.24.1757916614396;
        Sun, 14 Sep 2025 23:10:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECQRPiQitOqtajzh6bXpLG+V7zH9SLL0OR61z/8orLwVHwrBxRsiKGz8RZndsKYlzFa4Vdpw==
X-Received: by 2002:a05:6a20:748d:b0:249:467e:ba57 with SMTP id adf61e73a8af0-2602a59a02amr14839189637.24.1757916614030;
        Sun, 14 Sep 2025 23:10:14 -0700 (PDT)
Received: from localhost ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7760793bc77sm11823853b3a.4.2025.09.14.23.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Sep 2025 23:10:13 -0700 (PDT)
Date: Mon, 15 Sep 2025 14:07:04 +0800
From: Coiby Xu <coxu@redhat.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, 
	Roberto Sassu <roberto.sassu@huawei.com>, Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, 
	Eric Snowberg <eric.snowberg@oracle.com>, Paul Moore <paul@paul-moore.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	"open list:SECURITY SUBSYSTEM" <linux-security-module@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ima: don't clear IMA_DIGSIG flag when setting non-IMA
 xattr
Message-ID: <xy26wjlyha2m3jlcnowr74q4mv2vyr7xzm7zh2ab47osx5hffi@jhwihai3t4wb>
References: <20250902042515.759750-1-coxu@redhat.com>
 <d252b04934908e7e65a3299bfeffc282c7b0b12f.camel@linux.ibm.com>
 <53wb5tzech2k4k25xy2heq7ohmp2elw2a7l4x3nfk6fajfydur@5thsinydau5x>
 <13d7fcfecb06423294ae0553c9a561f4cc8faf67.camel@linux.ibm.com>
 <9fb8781bfb9c9ae9dd0a1413e23cae20dcd7356a.camel@linux.ibm.com>
 <wwcnoevou44eoe3ner4oegtdsdg46tlvwidu3ynobs7huac7ae@ljivg5ksohxv>
 <6f2b7320b691669068dda110c29c25f8aae2f244.camel@linux.ibm.com>
 <gw7xopwfzrp5qatwqa4n4i3miztbvbdolfaa2jxslb5pktc7fs@56r7n6feu55m>
Precedence: bulk
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <gw7xopwfzrp5qatwqa4n4i3miztbvbdolfaa2jxslb5pktc7fs@56r7n6feu55m>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6fL8eD8OweQ3RhtDPnpG3awKfMlygrF6FlPdXdFLjhA_1757916614
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Mon, Sep 15, 2025 at 12:06:14PM +0800, Coiby Xu wrote:
>On Wed, Sep 10, 2025 at 08:21:33AM -0400, Mimi Zohar wrote:
>>On Wed, 2025-09-10 at 09:36 +0800, Coiby Xu wrote:
>>>On Mon, Sep 08, 2025 at 04:58:05PM -0400, Mimi Zohar wrote:
>>>> On Mon, 2025-09-08 at 10:53 -0400, Mimi Zohar wrote:
>>>> > Hi Coiby,
>>>> >
>>>> > On Mon, 2025-09-08 at 19:12 +0800, Coiby Xu wrote:
>>>> > > >
>>>> > > > Even without an IMA appraise policy, the security xattrs are written out to the
>>>> > > > filesystem, but the IMA_DIGSIG flag is not cached.
>>>> > >
>>>> > > It seems I miss some context for the above sentence. If no IMA policy is
>>>> > > configured, no ima_iint_cache will be created. If you mean non-appraisal
>>>> > > policy, will not caching IMA_DIGSIG flag cause any problem?
>>>> >
>>>> > Sorry.  What I was trying to say is that your test program illustrates the
>>>> > problem both with or without any of the boot command line options as you
>>>> > suggested - "ima_appraise=fix evm=fix ima_policy=appraise_tcb".  Writing some
>>>> > other security xattr is a generic problem, whether the file is in policy or not,
>>>> > whether IMA or EVM are in fix mode or not.  The rpm-plugin-ima should install
>>>> > the IMA signature regardless.
>>>>
>>>> My mistake.  An appraise policy indeed needs to be defined for the file
>>>> signature to be replaced with a file hash.
>>>
>>>Thanks for the clarification! rpm-plugin-ima does try to install IMA
>>>signature as shown from the following strace output,
>>
>>Agreed. I was referring to the SELinux label, which would be installed for new
>>files, but not necessarily re-installed on existing files.  The test program
>>simplified testing.  Thank you.
>
>My pleasure! Note reinstalling a package using dnf/rpm is equivalent to
>installing a new package in terms of this issue. Because according to
>the strace output and rpm's source code, when reinstalling a package,
>the following steps happens, taking lnstat as an example,
>
>1. A temporary file "lnstat;68aee3f4" is created
>2. Read the content from RPM and write it to lnstat;68aee3f4
>3. Set file permission
>4. Set security.ima by rpm-plugin-ima
>5. Set security.selinux by rpm-plugin-selinux
>6. Rename "lnstat;68aee3f4" to lnstat
>
>And here's the strace output,
>
>    # strace rpm --reinstall ip*.rpm
>    openat(11, "lnstat;68aee3f4", O_WRONLY|O_CREAT|O_EXCL, 0200) = 12
>    dup(12)                                 = 13
>    write(13, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0'\0\0\0\0\0\0"..., 19256) = 19256
>    close(13)                               = 0
>    getuid()                                = 0
>    fchown(12, 0, 0)                        = 0
>    fchmod(12, 0755)                        = 0
>    getuid()                                = 0
>    utimensat(12, NULL, [{tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */, {tv_sec=1734480000, tv_nsec=0} /* 2024-12-17T19:00:00-0500 */], 0) = 0
>    fsetxattr(12, "security.ima", "\3\2\4\3232\4I\0f0d\0020O\231\341q\323Q\322\235\341\7\323\224\205\2104\24\241\331#"..., 111, 0) = 0
>    fsetxattr(12, "security.selinux", "system_u:object_r:bin_t:s0", 27, 0) = 0
>    close(12)                               = 0
>    ...
>    renameat(11, "lnstat;68aee3f4", 11, "lnstat") = 0

Btw, I realize my commit message that says the problem happens when reinstalling a
package can be a bit misleading. So in v3, I rephrase it as 
"... installing/reinstalling a package will not make good reference IMA generated"

