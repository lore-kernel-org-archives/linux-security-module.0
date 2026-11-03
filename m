Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.38
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705833;
	b=DVXjvJlP3dWOLbvk2vAN/1EAFeYisLNqrLSWioGAfaIKEss34zo6lCKRWx2wX6iAE3G5
	 aPP4/8aslh7dWphzoQFFesoGWVYacs8Fiq7fSgWxspZxhPD1Pp7JGA4apBuvAh3n3eHKO
	 uP0E0Swh3UPK84XfZFydKz/h4I4Uv1mz4eJO/1/rATJwzUKZOsvKDhPT1njURmN6xJfsE
	 trcQhuyd5O0WdZjNbEX9Z32p4dMwR0AkGbMBhS4j3vYmHAk1dgSNba/Z8RYVwTcevk1P6
	 AL8Uz4IHCr0RoWZKphX7rFaYlo2Mxpz5Guo4rAYSoaSRyBbWtVeTdQ8E9PUHRmLoVFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705833;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=kTRoHbntaqnndGjH129vXretNlBYX8gFbRCMh4VaxMs=;
	b=qlIuOPPOb0pdy3hwDrBSL15EaRL3ggFLddhKr0+YUgdV6o8KtVXa6v0mlD3TmUXxyCvM
	 xkYMOLwaxI68QgPTkgvpRVCDLT57AKSMBDn+H3c+LqEiMAUG0dL/GCRW7w+aRuOf6/GMl
	 5B/5EBbIu3oyzGnaAgMHh2zm/Kf382YaMYl1b9qwfSpL1UXR8XGnMUWq4xMZDm9QAaD8t
	 KjJiblCthmhJKSyVr1FHda3vfp6LzWJHx+wznMgWoqnx+z1AoxjiMZYeMZ/laPy6yEuXX
	 qRr70Q67P2arQzCqTMnrzV5zmMlNDlPvdsoIS2ib16U4vWPNdWEAdWrj7gZOOMbe9DA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wyuan.org;
	spf=pass smtp.mailfrom=wyuan.org;
	arc=none smtp.remote-ip=91.218.175.38
Received: from mta0.migadu.com (out-38.mta0.migadu.com [91.218.175.38])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341A6606D83E
	for <linux-security-module@vger.kernel.org>; Tue,  3 Nov 2026 11:37:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 341A6606D83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
X-Envelope-To: linux-security-module@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=p4HR613kc1KeED90M+lkiRrn86yWtAiyyB8MCLzTTh0=;
 c=simple/simple; d=wyuan.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793705828; v=1; x=1794310628;
 b=N09cjyu5VCQfjTA3D3vznx8Y6WUG4j99QP4Tz/lMq/r2Foix1BM+NuWi9BH4YOxXEzSoDupm
 of2xW+VVRIpvroZVPL0sdbyPY1sEMxymjp12z4WEnJaFkgBU2H3wOOnGzsen6cqpD/1E6LsbyLq
 phE0ldtq+xmgU1ZRXcZPidJAZopELhegL5Cnf6XPr/u1oc6EtIMTbkjTU6K5ntfRnOZsHS1vFt5
 fkBo/qeP3lqfVFgRSSYsEXWlb8gUxWe1WB1BEVGJFb28wz2UWIMHJXQfB+OXRL/Vo0B8zYGTZgI
 3b8tjnzxaMTRDjjmnCiwIIaYTtpNH4GTOD1VOg3AHiUvA==
X-Envelope-To: linux-security-module@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 06a3a3eea0a52372;
	Tue, 03 Nov 2026 11:37:07 +0000
X-Mizu-Trace-ID: 06a3a3eea0a52372
X-Migadu-Flow: FLOW_OUT
Date: Tue, 3 Nov 2026 19:37:02 +0800
From: Weijie Yuan <wy@wyuan.org>
To: Yan Zhu <zhuyan2015@qq.com>
Cc: dzm91@hust.edu.cn, skhan@linuxfoundation.org, gnoack@google.com,
	linux-doc@vger.kernel.org, linux-security-module@vger.kernel.org,
	alexs@kernel.org, si.yanteng@linux.dev, corbet@lwn.net,
	mic@digikod.net
Subject: Re: [PATCH 00/10] docs/zh_CN: add LSM admin-guide Chinese translation
Message-ID: <aunHXtl-L__1isgc@wyuan.org>
References: <tencent_001080DF135CEE2CD1B260EFA08E3CC71A09@qq.com>
 <tencent_7F10C2E7BB9C4B842554D6E95DE5D1DBD806@qq.com>
X-Mailing-List: linux-security-module@vger.kernel.org
List-Id: <linux-security-module.vger.kernel.org>
List-Post: <mailto:linux-security-module@vger.kernel.org>
List-Help: <mailto:linux-security-module+help@vger.kernel.org>
List-Subscribe: <mailto:linux-security-module+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-security-module+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-security-module+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_7F10C2E7BB9C4B842554D6E95DE5D1DBD806@qq.com>

Yan Zhu <zhuyan2015@qq.com> writes:

> Ping
> 
> On 6/12/2026 11:58 PM, Yan Zhu wrote:
> > This patch series adds the Chinese translation for the Linux Security Module
> > (LSM) admin-guide documentation, including the main index and all ten
> > sub-pages: apparmor, LoadPin, SELinux, Smack, tomoyo, Yama, SafeSetID,
> > ipe, and landlock.  The admin-guide toctree is also updated to list the
> > newly translated LSM/index.
> > 
> > The original English documentation was restructured into reStructuredText
> > by Kees Cook in commit 504f231cda56 ("doc: ReSTify and split LSM.txt"),
> > and each sub-page has been kept up-to-date with subsequent mainline changes.
> > 
> > 
> > base: https://git.kernel.org/pub/scm/linux/kernel/git/alexs/linux.git docs-next
> > 
> > 
> > 
> > Yan Zhu (10):
> >    docs/zh_CN: add LSM/index Chinese translation
> >    docs/zh_CN: add LSM/apparmor Chinese translation
> >    docs/zh_CN: add LSM/LoadPin Chinese translation
> >    docs/zh_CN: add LSM/SELinux Chinese translation
> >    docs/zh_CN: add LSM/Smack Chinese translation
> >    docs/zh_CN: add LSM/tomoyo Chinese translation
> >    docs/zh_CN: add LSM/Yama Chinese translation
> >    docs/zh_CN: add LSM/SafeSetID Chinese translation
> >    docs/zh_CN: add LSM/ipe Chinese translation
> >    docs/zh_CN: add LSM/landlock Chinese translation

Hi,

I suspect that your series was long since buried in maintainers' inbox,
because your actual patches are not "In-Reply-To" this cover letter.

And I do remember I mentioned it elsewhere that it may has something to
do with your QQ email server.  I suggest resending this serie after
fixing email stuffs.

Thanks.



