Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794686759;
	b=J82nXBI15O2ZmfSEYwuVrZ8F7eIAsFOybkvTwdX9IBDOnsBqqT4O1Y2mDAmkt69GuP0j
	 LS74p8I7pYrtHk2vBBANgP1Nb1XFb7jp6k01odf82xTqtaRdfABXXuALw800pd4tcMz6h
	 72WUrzoc+B+vmoaHqlwdapFBsEh75fewCcLFwyzYB+SE66Pa5lIORNIWkLuiqCGrUW5Bx
	 sbQyVmzpckD3OG1jaE2ZJrV92eUvolb1XhseT2PAL9U75Nx6r8D9DWulhHBNBVvt18nlj
	 3wSKjc/zCAVaxlK6XjPodwCjf2xuI1jTAuLLz8nK48eYr49VMlL73Q6SxXWqz405pbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794686759;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Disposition:Message-ID:User-Agent;
	bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
	b=z5pzRaZhujkREvuzuDT/Fz2PEjfCHuaGxs0Fbk0+3MrB0PfNGZ3n2WZKuRJp5mk3I1B+
	 yt9M8jaNemDaHrHhq1HW1Q2H4vawJcZZMF5W+UQTfFrLVCKXotrnRppfQMrg6A5ZcPg++
	 QHANjlUjM23IdxBDc4iKMhVutcJ/9FwLS7pfMjNJIGriGUqFHI2IC21ZSSGCs0se93Tj5
	 +AFjM/w0Np/sDOASWLV8FXBCOyNxzvj0f97sh+IUdNmDgtOHsohF/YQ/KqE/rtGDHgo/h
	 lKhNqUMyjTvSxpK1tH/TtwZgRofyfduhRnS9f2quoN2ns+YjUufR4ZBYsLyNFMHWoGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chrisdown.name;
	spf=pass smtp.mailfrom=chrisdown.name;
	dkim=pass header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF2B606A8BF
	for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 20:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EF2B606A8BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chrisdown.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.a=rsa-sha256 header.s=google header.b=t4xxtvlP
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3b18717a193so1228652a91.1
        for <linux-security-module@vger.kernel.org>; Sat, 14 Nov 2026 12:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google; t=1794686758; x=1795291558; darn=vger.kernel.org;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=t4xxtvlP4RAICjpBIWPIkESb6EJJVOcRd9+LEytv251d1ZQsfD2pYblwETMOf/zroc
         BDzAo5elUgpAiRA0oYEfExHYSjjGywxztBxThvGs665InMbo4S8LytfXKr2B4Cw2IX6x
         hCl30XcWjOl3zGKKK0Vny1KN9lt2zjyLiPz3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794686758; x=1795291558;
        h=user-agent:message-id:content-disposition:content-type:mime-version
         :references:in-reply-to:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cEK0v6G1yB2cz/8630PKsjvi8Z78P9QyctaIU0ylRW4=;
        b=OJTWyfhshWqKWqRkDtUbaAsUnbbYJPVl0Y8JhSRaMgMoiSRVeD6EOoFIOKnds+5BR7
         zTVcft6HHvaTnpwiVyppdMt6VcPgz8TC6mrG/iL9tPu8yXZmfACd+U+fqjcmxxKAJ6sj
         26v0gDaK4SM4o6jjpGWCQWJlsd3mKScy8ZRforvoM+aq2amGmMHskP4tVup3po0GnyvL
         dlxCAvO1e9IzaHKgHsjDso9t3ANsNlVKibl9R9x12w/vguz6uk1IgwEb/+9duOGVHhPs
         VkZXnW9f+l5DxmGFi3BdpkZAquQ50q3iJ4yneeXcetzR5xMxu1xR/eXgNilwSoExriax
         I1iA==
X-Forwarded-Encrypted: i=1; AL+hErEZf+iPIC/igtR3Uxsc4WonLfMvL1/B3aKoN2IEJdG3Ja4MTRvNCx/+9uyFZtlMPi2dt+rWBLx4+nwoZ8imsEyuho6gAFk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9gstlUFbvk4JUm2HqcuOxUyf9ZjdRbKTUiw5k2Etd/3DtHvuh3
	w7AHejjQugdEBBgeU1vbRDUaGCcqcImwgKllf7DXecFnavFPN4cz0/H33+SjDJnBwrk=
X-Gm-Gg: AYBFou0wNJ9QkDO3WVAVssK3ypcctra4H2brxJPFVC0RzAfEYwztvwybgte4jAyB/b9
	fVnjihFJ2NjkmASBETmaCowudssObwMxECk3zgu1OelrbJDGGUkEbwoOCYboyGmpX9LnsB0XZmO
	Xeqjit3dL0V89HucaE9JtWKsO8z8IFt9NYIL8Rw0MzysdyOwPklI1imL4TONBoJeGSuC1ThUkKB
	V3MN3WvWJ16UXgivOpdB/Dq5ZfgWuOm+1cUHUmtPUNY1o1F//HDN4ulSrFNQSNZN41BMIXXwah/
	caLR9x79RhUB6oK9XElvGUIGZ7jrnAT77ohQd40OJHZTnLb2M6MBkdEvtjO/f2G+rCGI0S2f7sO
	0d8o/1gil55qLaZ2AYvL8lseISv2Z4WOPdV8AWHSJDjkSddp44jVoYKnMDwaHsCDtERNyCV7bOe
	sUwnyLbAITG9Nr5VKG3UH2ilB+1KxkKb5ZuSu6rhXUYR7VGifHlog2MkSON1QC8t5FB75Y7wkKF
	1DxcizTJGf4CnJ58uPmCxjqhcpQCd8jbFVY6/K3N9R4v22ums+cvfCT9jWj2jDLRkU0L+INGREG
	Yu++QqCrY0RR6YWPrpN10nO8uXviH19A3r+cNCmez7H6DBOBepTOSUBwbUhKXZPuscgB8+tsjlj
	nsZrNU6K593MUFqxj0KtuKs4IpDMH1wAQxZjx64X3kh9jLcahw02Q8/zc5DZnUIGBsc1lXPuOiB
	V3DcbSy3KE9g45tqTxOSRV2uVQWkgIahXmQGjDj+TJmtmE1sH0eGPuHl5b
X-Received: by 2002:a17:90b:3b8a:b0:3b0:9f53:e8a8 with SMTP id 98e67ed59e1d1-3b1b0b5f2c1mr6192503a91.52.1794686758572;
        Sat, 14 Nov 2026 12:05:58 -0800 (PST)
Received: from [172.22.0.2] ([64.16.22.130])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1b266d873sm4654869a91.1.2026.11.14.12.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 12:05:57 -0800 (PST)
Date: Sat, 14 Nov 2026 12:05:55 -0800
From: Chris Down <chris@chrisdown.name>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>,
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
	linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
	driver-core@lists.linux.dev, linux-mm@kvack.org, bpf@vger.kernel.org,
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org, netdev@vger.kernel.org,
	fuse-devel@lists.linux.dev, linux-efi@vger.kernel.org,
	xen-devel@lists.xenproject.org, ocfs2-devel@lists.linux.dev,
	linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-usb@vger.kernel.org, Amir Goldstein <amir73il@gmail.com>,
	linux-erofs@lists.ozlabs.org, linux-kselftest@vger.kernel.org,
	Alexander Mikhalitsyn <alex@amutable.com>
Subject: Re: [PATCH RFC v2 17/42] securityfs: use fc_init_pseudo()
In-Reply-To: <20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
	<20261114-work-loop-pseudo-v2-17-98639a2286fb@kernel.org>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Message-ID: <20261114120555.cbfaf8ab8a92fb25@chrisdown.name>
User-Agent: Mutt/2.4.3 (cc9e3943) (2026-10-09)

Hi Christian,

Christian Brauner writes:
>AppArmor puts a .null device node into securityfs but only ever opens
>it via dentry_open() which doesn't care about SB_I_NODEV.

Not a big deal, but userspace can see that node too, as
/sys/kernel/security/apparmor/.null. Opening it by path works in current
kernels and fails with EACCES after this patch. Now, I don't know of
anything that does that, but selinuxfs gets SB_I_NODEV cleared again in
the next patch for the same kind of node, so I think we should do the
same thing here. If not, it would be good to have a line in the
changelog saying that opening it by path is meant to stop working.

Once that's fixed, please feel free to add:

Reviewed-by: Chris Down <chris@chrisdown.name>
